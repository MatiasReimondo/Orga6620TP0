#include "functions.h"
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#define SIZE_OF_MEMORY 4096
#define SIZE_OF_BLOCK 32
#define BLOCK_NUMBER 16
#define NO_TAG -2
#define SETS_CACHE 2

// Estructura de un bloque cache
// data: son los 32 bytes del bloque
// use last: se va cambiando a medida de que se accede en la lectura 1 o 0 dependiendo de a cual se acceda
struct cache_block{
    unsigned char * data;
    int bit_dirty;
    int tag;
    int use_last;
};

//Memoria principal
unsigned char * memory;

//Cantidad de miss
unsigned int miss;

//Cantidad de accesos a memoria
unsigned int access;

// Via 0 de la cache
struct cache_block v0[BLOCK_NUMBER];

// Via 1 de la cache
struct cache_block v1[BLOCK_NUMBER];

// Iniciacion de la metadata de la cache y los malloc
void pre_run(){
    memory = malloc(SIZE_OF_MEMORY);
    for (int i = 0; i <BLOCK_NUMBER ; ++i) {
        v0[i].data = malloc(SIZE_OF_BLOCK);
        v0[i].bit_dirty = 0;
        v0[i].tag = NO_TAG;
        v0[i].use_last = 0;
        v1[i].data = malloc(SIZE_OF_BLOCK);
        v1[i].bit_dirty = 0;
        v1[i].tag = NO_TAG;
        v1[i].use_last = 0;
    }

}

//Init pedido por el enunciado, lo del bit de dirty lo agregue, es una de als dudas
void init(){
    miss = 0;
    access = 0;
    for (int i = 0; i <BLOCK_NUMBER ; ++i) {
        memset(v0[i].data,'\0',SIZE_OF_BLOCK);
        memset(v1[i].data,'\0',SIZE_OF_BLOCK);
        v0[i].bit_dirty = 1;
        v1[i].bit_dirty = 1;
    }

}

unsigned char read_byte(int address){
   // int bloque_cache = extract_index(address,SETS_CACHE,SIZE_OF_BLOCK);
    //int tag = extract_tag(address,SETS_CACHE,SIZE_OF_BLOCK);
    int bloque_cache = address%BLOCK_NUMBER;
    int tag = address/BLOCK_NUMBER;
    int offset = extract_offset(address,SETS_CACHE,SIZE_OF_BLOCK);
    access = access+ 1;

    if((v0[bloque_cache].tag == tag) && (v0[bloque_cache].bit_dirty!= 1)){
        v0[bloque_cache].use_last = 1;                  //Si encuentra en la cache le dato, setea esa via como la ultima usada
        v1[bloque_cache].use_last = 0;                  // y la otra como no
        return v0[bloque_cache].data[offset];

    }else if((v1[bloque_cache].tag == tag) && (v1[bloque_cache].bit_dirty!= 1)){
        v0[bloque_cache].use_last = 0;
        v1[bloque_cache].use_last = 1;
        return v1[bloque_cache].data[offset];
    }else{
        miss = miss +1;                             //Sino encuentra el dato lo guarda en la que fue menor usada
        if((v0[bloque_cache].bit_dirty!=1) &&(v1[bloque_cache].bit_dirty!=1)){
            if(v0[bloque_cache].use_last){
                v1[bloque_cache].data[offset] = memory[address];
                v1[bloque_cache].bit_dirty = 0;
                v1[bloque_cache].tag = tag;
            }else {
                v0[bloque_cache].data[offset] = memory[address];
                v0[bloque_cache].bit_dirty = 0;
                v0[bloque_cache].tag = tag;
            }
        }else if(v0[bloque_cache].bit_dirty==1){
            v0[bloque_cache].data[offset] = memory[address];
            v0[bloque_cache].bit_dirty = 0;
            v0[bloque_cache].tag = tag;
        }else{
            v1[bloque_cache].data[offset] = memory[address];
            v1[bloque_cache].bit_dirty = 0;
            v1[bloque_cache].tag = tag;
        }
        return -1;
    }
}

int write_byte(int address, unsigned char value){
  //  int bloque_cache = extract_index(address,SETS_CACHE,SIZE_OF_BLOCK);
   // int tag = extract_tag(address,SETS_CACHE,SIZE_OF_BLOCK);
    int bloque_cache = address%BLOCK_NUMBER;
    int tag = address/BLOCK_NUMBER;
    int offset = extract_offset(address,SETS_CACHE,SIZE_OF_BLOCK);
    access = access+ 1;

    if(v0[bloque_cache].tag == tag){
        v0[bloque_cache].data[offset] = value;
        v0[bloque_cache].bit_dirty = 0;
        memory[address] = value;
        return 0;
    }else if(v1[bloque_cache].tag == tag){
        v1[bloque_cache].data[offset] = value;
        v1[bloque_cache].bit_dirty= 0;
        memory[address] = value;
        return 0;
    }else{
        memory[address] = value;
        miss = miss +1;
        return -1;
    }

}

unsigned int get_miss_rate(){
    printf("%d \n", miss);
    printf("%d \n", access);
    unsigned int missRate = (miss*100)/access;
    return missRate;
}

int parse_arguments(int argc, char * argv[]){
    pre_run();
    init();
    FILE *fi;
    int exe_code = 0;
    size_t len = 32;
    char *line = NULL;
    char *argument1 = NULL;
    char *argument2 = NULL;
    char *argument3 = NULL;
    if(argc !=2){
        return 0;
    }else{
        fi = fopen(argv[1],"r");
        if(errno != 0){
            fprintf(stderr,"No se pudo abrir el archivo \n");
            exe_code = ERROR_NO_FILE;
            return exe_code;
        }
        while(getline(&line,&len,fi)!=-1){
            argument1 = strtok(line,DELIMITERS);
            if(strcmp("W",argument1) == 0){
                argument2 = strtok(NULL,DELIMITERS);
                int arg2 = atoi(argument2);
                argument3 = strtok(NULL,DELIMITERS);
                unsigned char arg3 = (unsigned char) atoi(argument3);
                write_byte(arg2,arg3);
            }
            if(strcmp("R",argument1) == 0){
                argument2 = strtok(NULL,DELIMITERS);
                int arg2 = atoi(argument2);
                read_byte(arg2);

            }
            if(strcmp("MR",argument1) == 0){
                get_miss_rate();
                printf("%u \n",get_miss_rate());


            }
        }
        free_cache();
        return 0;
    }

}

void free_cache(){
    for (int i = 0; i <BLOCK_NUMBER ; ++i) {
        free(v0[i].data);
        free(v1[i].data);

    }
}

//Usamos operadores de bits para segun el addres que se pasa sacar los tres datos necesarios


int ilog2 (int x){
    int result = 0;

    while (x != 0) {
        result++;
        x = x >> 1;
    }
    return result;
}

int extract_tag (int address, int sets, int block_size){
    int offset_bits = ilog2(block_size);
    int index_bits = ilog2(sets);

    int tag = address >> (index_bits + offset_bits);
    return tag;
}

int extract_index (int address, int sets, int block_size){

    int offset_bits = ilog2(block_size);
    int index_bits = ilog2(sets);

    int index = (address >> offset_bits) & ((1 << index_bits) - 1);
    return index;
}

int extract_offset (int address, int sets, int block_size){

    int offset_bits = ilog2(block_size);

    int offset = address & ((1 << offset_bits) - 1);
    return offset;
}



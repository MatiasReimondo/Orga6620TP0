
#include "functionsMips.h"
#include <ctype.h>
#include <getopt.h>
#include <errno.h>
#include <stdio.h>
#include <malloc.h>

#define SIZE_LONG 8

int parse_arguments(int argc, char *argv[]){
    int option, outputFlag = 0, file_flag =0;
    FILE *fi, *fo;
    int exe_code = 0;
    option = getopt(argc,argv,OPTIONS);
    while(option != -1){
        switch(option){
            case 'V':
                versionDisplay();
                exe_code = 0;
                return exe_code;
            case 'h':
                helpDisplay();
                exe_code = 0;
                return exe_code;
            case 'o':
                outputFlag = 1;
                fo = fopen(optarg,"w");
                if(errno != 0){
                    printf("No se pudo abrir el archivo \n");
                    exe_code = ERROR_NO_FILE;
                    return exe_code;
                }
                break;
            case 'i':
                file_flag = 1;
                errno = 0;
                fi = fopen(optarg,"r");
                if(errno != 0){
                    printf("No se pudo abrir el archivo \n");
                    exe_code = ERROR_NO_FILE;
                    return exe_code;
                }
                break;
            default:
                printf("No existe el comando \n");
                exe_code = FALSE_ARGS;
                return exe_code;

        }
        option = getopt(argc,argv,OPTIONS);
    }
    if(!file_flag){
        exe_code = ERROR_NO_FILE;
        printf("Debe ingresar un archivo de entrada, -h para el menu de ayuda \n");
        return exe_code;
    }
    if(!outputFlag){
        exe_code = load_file(fi,stdout);

    }else {
        exe_code = load_file(fi,fo);


    }
    fclose(fi);
    if(outputFlag){
        fclose(fo);
    }

    return exe_code;
}


int load_file(FILE *fi, FILE *fo){
unsigned int filas = getCantidadFilas(fi);
    unsigned int columnas = getCantidadColumnas(fi);
    unsigned int filasMemory = filas;
    unsigned int columnasMemory = columnas;
    unsigned int sizeOfMemory = filasMemory * columnasMemory * SIZE_LONG *SIZE_LONG;
    long long * matrizOrigen = malloc(sizeOfMemory); // Reserva el espacio de memoria para la matriz
    memset(matrizOrigen,0,sizeOfMemory);
    long long * matrizDestino = malloc(sizeOfMemory);
    memset(matrizDestino,0,sizeOfMemory);
  

    long long numero = 0;
    unsigned int i;
    unsigned int j;
    for (i = 0; i <filas ; ++i) {
        for ( j = 0; j <columnas ; ++j) {
            unsigned int posicion = (i+j*filas)* SIZE_LONG;
            int scan_result = fscanf(fi,"%lld",&numero);
            if(scan_result != 1){
                printf("Hubo un error cargando la matriz, probablemente este mal ingresada, revise el archivo de entrada y vuelva a intentarlo \n");
                free(matrizOrigen);
                free(matrizDestino);
                return BAD_MATRIX;
            }
            matrizOrigen[posicion] = numero;
        }
    }
    trasponer(filas,columnas,matrizOrigen,matrizDestino);
    save_file(fo,filas,columnas,matrizDestino);

    free(matrizOrigen);
    free(matrizDestino);
    return 0;
}

int save_file (FILE *fo, unsigned int filas, unsigned int columnas, long long *matrix){

    unsigned int k,l;
    fprintf(fo,"%d",columnas);
    fprintf(fo," ");
    fprintf(fo,"%d",filas);
    fprintf(fo,"\n");
    for ( k = 0; k <columnas ; ++k) {
        for ( l = 0; l < filas ; ++l) {
            unsigned int posicion = (k+l*columnas)* SIZE_LONG;
            fprintf(fo,"%lld  ",matrix[posicion]);

        }
        fprintf(fo,"\n");
    }

}

unsigned int getCantidadFilas(FILE *fi){
    unsigned int filas = 0;
    int scanResult = fscanf(fi,"%d",&filas);
    if(scanResult != 1){
        return FAIL_SCAN;
    }else{
        return filas;
    }
}

unsigned int getCantidadColumnas(FILE *fi){
    unsigned int columnas = 0;
    int scanResult = fscanf(fi,"%d",&columnas);
    if(scanResult != 1){
        return FAIL_SCAN;
    }else{
        return columnas;
    }
}



// Completen con sus nombres
int versionDisplay(){
    printf("TP1 - Version 1.0 FIUBA 2018\n");
    printf("Alumnos:\n");
    printf("Pinto, Santiago 96850\n");
    printf("Llauro, Manuel 95736\n");
    printf("Reimondo, Matias 95899\n");
    printf("\n");
    return 0;
}

int helpDisplay(){
    printf("Usage:\n"
                   "traspuesta -h\n"
                   "traspuesta -V\n"
                   "traspuesta [options]\n"
                   "Options:\n"
                   "-V, --version Print version and quit.\n"
                   "-h, --help    Print this information.\n"
                   "-o, --output  Path to the output file.\n"
                   "-i, --input   Path to the input file.\n"
                   "Examples:\n"
                   "traspuesta -o - mymatrix\n");
    printf("\n");
    return 0;
}

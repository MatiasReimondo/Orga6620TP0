#include "functions.h"
#include <ctype.h>
#include <getopt.h>
#include <errno.h>
#include <stdio.h>
#include <malloc.h>

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
    unsigned int sizeLong = sizeof(long long);
    unsigned int filasMemory = filas+1;
    unsigned int columnasMemory = columnas+1;
    long long * matrizOrigen = malloc(filasMemory * columnasMemory * sizeLong); // Reserva el espacio de memoria para la matriz
    long long * matrizDestino = malloc(columnasMemory * filasMemory * sizeLong);



    long long numero = 0;
    for (unsigned int i = 0; i <filas ; ++i) {
        for (unsigned int j = 0; j <columnas ; ++j) {
            unsigned int posicion = (i+j*filas)* sizeLong;
            int scan_result = fscanf(fi,"%lld",&numero);
            matrizOrigen[posicion] = numero;
        }
    }
    int prueba =trasponer(filas,columnas,matrizOrigen,matrizDestino);
    printf("%d \n",prueba);
    /*
    for (unsigned int k = 0; k <columnas ; ++k) {
        for (unsigned int l = 0; l < filas ; ++l) {
            unsigned int posicion = (k+l*columnas)* sizeLong;
            printf("%lld  ",matrizDestino[posicion]);

        }
        printf("\n");
    }
     */

    free(matrizOrigen);
    free(matrizDestino);
    return 0;
}

/*
int trasponer(unsigned int filas, unsigned int columnas, long long *entrada, long long *salida){

    for (int i = 0; i <filas ; ++i) {
        for (int j = 0; j <columnas ; ++j) {
            unsigned int posicionEntrada = (i+(j*filas))* sizeof(long long);
            unsigned int posicionSalida = ((i*columnas)+j)* sizeof(long long);
            salida[posicionSalida] = entrada[posicionEntrada];
        }
    }
    return 0;

}
 */

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

#include <stdio.h>
#include "functions.h"

#define TWO_ARGS 5 //numero de argumentos -i -o
#define ONE_ARG 3 // numero de argumentos -i/-o
#define HELP_VERSION 2
#define NO_ARGS 1 // Sin argumentos

//Bloque main, lo unico qu hace es redirigir al respectivo comportamiento
int main(int argc, char *argv[]) {
    int exe_code = 0;
    if(argc == NO_ARGS){
        exe_code = no_arguments();
    }
    else if(argc == ONE_ARG){
        exe_code = one_argument(argc,argv);

    }
    else if(argc == TWO_ARGS){
        exe_code = two_arguments(argc,argv);
    }
    else if(argc == HELP_VERSION){
        version_option(argc,argv);
    }
    else {
        printf("Comandos Incorrectos");
    }
    if(exe_code == ERROR_NO_MEMORY){
        printf("Se ha excedido el limite de memoria del sistema, la palabra que intenta ingresar es demasiado grande \n");
        printf("Por favor actualice su sistema si desea ingresar una palabra tan grande");
    }
    return 0;
}



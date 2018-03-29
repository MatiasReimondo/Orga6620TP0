#include <stdio.h>
#include "functions.h"

#define TWO_ARGS 5 //numero de argumentos -i -o
#define ONE_ARG 3 // numero de argumentos -i/-o
#define HELP_VERSION 2
#define NO_ARGS 1 // Sin argumentos

//Bloque main, lo unico qu hace es redirigir al respectivo comportamiento
int main(int argc, char *argv[]) {
    int exe_code = 0;
    exe_code = parse_arguments(argc,argv);
    return exe_code;
}


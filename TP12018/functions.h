
#ifndef TP1_FUNCTIONS_H
#define TP1_FUNCTIONS_H

#include <stdio.h>

#define ERROR_NO_FILE -1
#define FALSE_ARGS -2
#define FAIL_SCAN 0
#define NO_VALID_ARGS -4

//lista de opciones del programa
static const char OPTIONS[] = "Vhoi:";

//Parsea los argumentos, abre el archivo y pasa los flags  y el file pointer correspondiente
int parse_arguments(int argc, char *argv[]);

//Carga los parametros para mandar como argumentos a la funcion trasponer
int load_file(FILE *fi, FILE *fo);

//Obtiene la cantidad de filas
unsigned int getCantidadFilas(FILE *fi);

//Obtiene la cantidad de columnas
unsigned int getCantidadColumnas(FILE *fi);

//funcion transponer
int trasponer(unsigned int filas, unsigned int columnas, long long *entrada, long long *salida);


//Muestra la descipcion de la version
int versionDisplay();

//Muestra el menu de ayuda
int helpDisplay();


#endif //TP1_FUNCTIONS_H


#ifndef TP0P_FUNCTIONS_H
#define TP0P_FUNCTIONS_H

#include <stdio.h>
#define ERROR_NO_FILE -1
#define FALSE_ARGS -2
#define COUNTER_OUT_OF_RANGE -3
#define NO_VALID_ARGS -4
#define NO_FILE_OPTION -5

//lista de opciones del programa
static const char OPTIONS[] = "Vhlwci:";

//Parsea los argumentos, abre el archivo y pasa los flags  y el file pointer correspondiente
int parse_arguments(int argc, char *argv[]);

// Lee el texto y de acuerdo a la flag indicada imprime cantidad de lineas, palabras y caracteres
int read_text(int lineFlag, int wordFlag, int charFlag , FILE *fr);

//Muestra la descipcion de la version
int versionDisplay();

//Muestra el menu de ayuda
int helpDisplay();



#endif //TP0P_FUNCTIONS_H

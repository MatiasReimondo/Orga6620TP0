#ifndef UNTITLED_FUNCTIONS_H
#define UNTITLED_FUNCTIONS_H


#include <stdio.h>
#define BUFFER_INITIAL_SIZE 1024
#define BUFFER_EXTENDS 2
#define ERROR_NO_MEMORY -1
//lista de caracteres legales o permitidos por el enunciado
static const char LEGAL_CHARS[] = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890-_";


static const char OPTIONS[] = "Vhio";


//Chequea que un caracter este dentro de los caracteres permitidos
int is_valid_char(char input_char);

//Imprime en el archivo de salida
void print_word_in_file(FILE *f,char array[BUFFER_INITIAL_SIZE], int size_word, int words_printed);

// Devuelve 0 si es capicua o algun numero mayor a 0 si no lo es
int is_capicua(char array[BUFFER_INITIAL_SIZE], int size_word);

//Comportamiento si el programa se ejecuta sin argumentos leee y escribe entrada y salida estandar
int no_arguments();

//COmportamiento con un argumento ya sea entrada o salida
int one_argument(int argc, char *argv[]);

// Comportamiento con dos argumentos entrada y salida en cualquier orden
int two_arguments(int argc, char *argv[]);

//Muestra la descipcion de la version
int versionDisplay();

//Muestra el menu de ayuda
int helpDisplay();

//Comportamiento para mostrar ayuda o opciones
int version_option(int argc, char*argv[]);

// Entrada y salida de la funcion
int in_out(FILE *fr, FILE *fw);


#endif //UNTITLED_FUNCTIONS_H

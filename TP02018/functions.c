#include "functions.h"
#include <ctype.h>
#include <getopt.h>
#include <errno.h>

int parse_arguments(int argc, char *argv[]){
    int option, linesFlag = 0, wordsFlag = 0, charFlag = 0, file_flag =0;
    FILE *fr;
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
            case 'l':
                linesFlag = 1;
                break;
            case 'w':
                wordsFlag = 1;
                break;
            case 'c':
                charFlag = 1;
                break;
            case 'i':
                file_flag = 1;
                errno = 0;
                fr = fopen(optarg,"r");
                if(errno != 0){
                    printf("No se pudo abrir el archivo \n");
                    exe_code = ERROR_NO_FILE;
                    return exe_code;
                }
                break;
            default:
                printf("No existe el comando \n");
                exe_code = FALSE_ARGS;
                break;
        }
        option = getopt(argc,argv,OPTIONS);
    }
    if(!file_flag){
        printf("Debe ingresar un archivo con la opcion -i \n");
        exe_code = NO_FILE_OPTION;
        return exe_code;
    }
    if(!linesFlag && !charFlag && !wordsFlag){
        printf("Debe ingresar alguna opcion validad -l -w -c \n");
        exe_code = NO_VALID_ARGS;
        return exe_code;
    }
    if(exe_code != FALSE_ARGS){
        exe_code = read_text(linesFlag,wordsFlag,charFlag,fr);
    }
    fclose(fr);
    return exe_code;
}


// Explico paso a paso lo que hice asi mas o menos se entiende
int read_text(int lineFlag, int wordFlag, int charFlag, FILE *fr){
    unsigned long long max_range = 18446744073709551600ULL;
    char input_char;                                            //Caracter que se leera del archivo
    char last_read = ' ';                                       //Ultimo caracter leido
    unsigned long long lines_read = 0, words_read = 0, chars_read = 0; //Contadores unsigned long long range 0 a +18,446,744,073,709,551,615
    while((input_char = getc(fr)) != EOF){
        chars_read++;                                           // Cada vez que lee un caracter aumenta la cantidad de caracteres
        if(!isalpha(input_char)){                               // si el caracter no es alfabetico
            if((!is_valid_char(input_char)) && (isalpha(last_read))){ // y ademas no es un caracter valido (excepciones del texto) y el ultimo leido es alfabetico
                words_read++;                                   // Suma uno a las palabras
            }
        }
        if( input_char == '\n') {                           // Si lee un salto de linea aumenta el contador de lineas
            lines_read++;
        }
        last_read = input_char;                         // Asigna el ultimo leido

        if(chars_read > max_range){                             // Si se sobrepasa el limite del contador se cierra el programa
            printf("Se ha excedido el rango del contador \n");
            return COUNTER_OUT_OF_RANGE;
        }

    }
    if(isalpha(last_read)){
        words_read++;
    }
    if(lineFlag){
        printf("Lines: %llu \n",lines_read);
    }
    if(wordFlag){
        printf("Words: %llu \n",words_read);
    }
    if(charFlag){
        printf("Characters: %llu \n",chars_read);
    }
    printf("\n");
    return 0;
}

int is_valid_char(char input_char){
    int is_valid = 0;
    int i;
    for (i = 0; i < sizeof(LEGAL_CHARS) ; ++i) {
        if(input_char == LEGAL_CHARS[i]){
            is_valid =1;
        }
    }
    return is_valid;
}

// Completen con sus nombres
int versionDisplay(){
    printf("TP0 - Version 1.0 FIUBA 2018\n");
    printf("Alumnos:\n");
    printf("Pinto, Santiago \n");
    printf(", Manuel   \n");
    printf("Reimondo, Matias 95899\n");
    printf("\n");
    return 0;
}

int helpDisplay(){
    printf("Usage:\n"
                   "tp0 -h\n"
                   "tp0 -V\n"
                   "tp0 [options]\n"
                   "Options:\n"
                   "-V, --version Print version and quit.\n"
                   "-h, --help    Print this information.\n"
                   "-l, --words  Print number of lines in file.\n"
                   "-w, --words  Print number of words in file.\n"
                   "-c, --words  Print number of characters in file.\n"
                   "-i, --input  Path to the input file.\n"
                   "Examples:\n"
                   "tp0 -w -i input.txt\n");
    printf("\n");
    return 0;
}



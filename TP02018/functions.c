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
    if(!linesFlag && !charFlag && !wordsFlag){
        printf("Debe ingresar alguna opcion validad -l -w -c \n");
        exe_code = NO_VALID_ARGS;
        return exe_code;
    }
    if((exe_code != FALSE_ARGS) && file_flag){
        exe_code = read_text(linesFlag,wordsFlag,charFlag,fr);
    }
    if(!file_flag){
        exe_code = read_text(linesFlag,wordsFlag,charFlag,stdin);
        return exe_code;
    }
    fclose(fr);
    return exe_code;
}


// Explico paso a paso lo que hice asi mas o menos se entiende
int read_text(int lineFlag, int wordFlag, int charFlag, FILE *fr){
    unsigned long long max_range = 18446744073709551600ULL;
    unsigned char input_char;                                            //Caracter que se leera del archivo
    unsigned char last_read = ' ';                                       //Ultimo caracter leido
    unsigned long long lines_read = 0, words_read = 0, chars_read = 0; //Contadores unsigned long long range 0 a +18,446,744,073,709,551,615
    int flagfile;
    int in_space = 1;
    while((flagfile = getc(fr)) != EOF){
        input_char = flagfile;
        last_read = input_char;
        chars_read++;                                           // Cada vez que lee un caracter aumenta la cantidad de caracteres
        if (isspace(input_char)) {                              // Si el caracter leido es un espacio
            in_space = 1;
            if (input_char == '\n') {
                lines_read++;
            }
        } else {
            words_read += in_space;                         // Sino es un espacio aumenta en 1 las palabrass y setea in_sppace en 0
            in_space = 0;
        }

        if(chars_read > max_range){                             // Si se sobrepasa el limite del contador se cierra el programa
            printf("Se ha excedido el rango del contador \n");
            return COUNTER_OUT_OF_RANGE;
        }

    }
    if ((last_read != '\n' )&& (chars_read!= 0)) {
        lines_read++;
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


// Completen con sus nombres
int versionDisplay(){
    printf("TP0 - Version 1.0 FIUBA 2018\n");
    printf("Alumnos:\n");
    printf("Pinto, Santiago 96850\n");
    printf("Llauro, Manuel 95736\n");
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





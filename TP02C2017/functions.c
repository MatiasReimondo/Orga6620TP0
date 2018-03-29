#include "functions.h"
#include <ctype.h>
#include <string.h>
#include <getopt.h>
#include <stdlib.h>


int in_out(FILE *fr, FILE *fw){
    char input_char;
    int num_read = 0;
    int buffer_size = BUFFER_INITIAL_SIZE;
    int words_printed = 0;
    char *word = malloc(buffer_size);
    while ((input_char = getc(fr)) != EOF) {
        int is_valid = is_valid_char(input_char);
        if(is_valid){
            if (num_read >= buffer_size) {
                char *new_word;
                buffer_size = buffer_size *BUFFER_EXTENDS ;
                new_word = realloc(word, buffer_size);
                if (new_word == NULL) {
                    free(word);
                    return ERROR_NO_MEMORY;
                }
                word = new_word;
            }
            word[num_read] = input_char;
            num_read++;
        }else {
            if (is_capicua(word, num_read) == 0) {
                print_word_in_file(fw,word, num_read,words_printed);
                words_printed++;
            }
            if(input_char == '\n'){
                fprintf(fw,"\n");
                words_printed = 0;
            }
            word[0] = '\0';
            num_read = 0;
        }
    }
    free(word);
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

void print_word_in_file(FILE *f,char array[BUFFER_INITIAL_SIZE], int size_word, int words_printed){
    int i;
    if((words_printed>0)){
        fprintf(f," ");
    }
    for (i = 0; i <size_word ; ++i) {
        fprintf(f,"%c",array[i]);
    }
}

int is_capicua(char array[BUFFER_INITIAL_SIZE], int size_word){
    int capicua = 0;
    int last_letter = size_word-1;
    int i;
    if(array[0]== '\0'){
        capicua++;
    }
    for (i = 0; i <size_word ; ++i) {
        if(toupper(array[i]) != toupper(array[last_letter-i])){
            capicua++;
        }
    }
    return capicua;
}



int no_arguments(){
    int exe_code= in_out(stdin,stdout);
    return exe_code;
}

int one_argument(int argc, char *argv[]){
    int opt;
    FILE *fw;
    FILE *fr;
    int exe_code;
    opt = getopt(argc,argv,OPTIONS);
    while(opt != -1){
        switch(opt){
            case 'V':
                versionDisplay();
                break;
            case 'h':
                helpDisplay();
                break;
            case 'o':
                fw = fopen(argv[2],"w");
                exe_code = in_out(stdin,fw);
                fclose(fw);
                break;
            case 'i':
                fr = fopen(argv[2],"r");
                exe_code= in_out(fr,stdout);
                fclose(fr);
                break;
            default:
                printf("No existe el comando \n");
                break;
        }
        opt = getopt(argc,argv,OPTIONS);
    }

   return exe_code;
}


int two_arguments(int argc, char *argv[]){
    FILE *fr;
    FILE *fw;
    int exe_code;
    if ((strcmp (argv[1], "-o") == 0) && (strcmp (argv[3], "-i") == 0)) {
        fr = fopen(argv[4],"r");
        fw = fopen(argv[2],"w");
        exe_code = in_out(fr,fw);
        fclose(fr);
        fclose(fw);
    }
    else if ((strcmp (argv[3], "-o") == 0) && (strcmp (argv[1], "-i") == 0)) {
        fr = fopen(argv[2],"r");
        fw = fopen(argv[4],"w");
        exe_code = in_out(fr,fw);
        fclose(fr);
        fclose(fw);
    }
    else {
        printf("No existe el comando \n");
    }
    return exe_code;
}

int versionDisplay(){
    printf("TP0 - Version 2.0 FIUBA 2017\n");
    printf("Alumnos:\n");
    printf("Charytoniuk, Martin 96354\n");
    printf("Perez, Martin  97378 \n");
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
            "-i, --input   Location of the input file.\n"
            "-o, --output  Location of the output file.\n"
            "Examples:\n"
            "tp0 -i ~/input -o ~/output\n");
    printf("\n");
    return 0;
}

int version_option(int argc, char*argv[]){
    int opt;
    opt = getopt(argc,argv,OPTIONS);
    while(opt != -1){
        switch(opt){
            case 'V':
                versionDisplay();
                break;
            case 'h':
                helpDisplay();
                break;
            default:
                printf("No existe el comando \n");
                break;
        }
        opt = getopt(argc,argv,OPTIONS);
    }
    return 0;
}


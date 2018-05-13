#ifndef CACHE_FUNCTIONS_H
#define CACHE_FUNCTIONS_H

#define ERROR_NO_FILE -10

static const char DELIMITERS[] = " ,\n";

//Parsea el archivo y hace las correspondientes llamadas a las primitivas
int parse_arguments(int argc, char * argv[]);

//Realiza el malloc de las variables globales
void pre_run();

void init();

unsigned char read_byte(int address);

int write_byte(int address, unsigned char value);

unsigned  int get_miss_rate();

void free_cache();

#endif //CACHE_FUNCTIONS_H

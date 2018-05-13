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

int ilog2 (int x);

int extract_offset (int address, int sets, int block_size);


int extract_tag (int address, int sets, int block_size);

int extract_index (int address, int sets, int block_size);

#endif //CACHE_FUNCTIONS_H

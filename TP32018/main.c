#include "functions.h"
// DUDAS:
//1. Estuve investigando y el bit de dirty en la estrategia de WT/-WA no se usa por un tema de que siempre se actualiza la memoria
//2. Como podria detectar el bit de la memoria cache al cual apunta la direccion actualmente solo se cambia el 0
//3. Actualmente solo estoy actualizando el miss y el access en la lectura, no se si deberia hacer lo mismo en la escritura
int main(int argc, char * argv[]) {
    return parse_arguments(argc,argv);
}
#include <mips/regdef.h>
 
#ifndef SIZE_LONG_LONG
#define SIZE_LONG_LONG 8
#endif
 
    .text
    .abicalls
    .align 2
    .globl trasponer
    .ent trasponer
trasponer:
    subu  sp, sp , 48
    sw    ra, 40(sp)
    sw   $fp, 36(sp)
    move $fp,sp
    sw    gp, 32(sp)
 
    sw    a0, 48(sp)      # Cantidad de filas
    sw    a1, 52(sp)      # Cantidad de columnas
    sw    a2, 56(sp)
    sw    a3, 60(sp)
 
    add  t0, zero, zero   # t0 es el valor de "i" fila
    add  t1, zero, zero   # t1 es el valor de "j" columna
    addi v0, zero, 0
FOR_FILAS:
    blt   t0, a0, FOR_COLUMNAS
 
FINISH:
    lw    gp, 32(sp)
    lw   $fp, 36(sp)
    lw    ra, 40(sp)
    addiu sp, sp, 48
    jr    ra
 
 
FOR_COLUMNAS:
    blt   t1, a1, TRASPOSE
    add   t1, zero, zero
    addi  t0, t0, 1
    b    FOR_FILAS
 
 
TRASPOSE:
    mulou t2, t1, a0			# Guardo en t2 j * filas
    addu  t2, t2, t0			# Sumo t2 a i
    addi  t3, zero, SIZE_LONG_LONG			# seteo t3 en 8
    mulou   t2, t3, t2                  # t2 es la posicion de entrada
    mulou   t2, t3, t2                  # t2 es la posicion de entrada
 
    mulou   t4, t0, a1			# guardo en t4 i * columnas
    addu  t4, t4, t1			# Sumo t4 a j
    addi  t3, zero, SIZE_LONG_LONG
    mulou   t4, t3, t4                  # t4 es la posicion de salida
    mulou   t4, t3, t4                  # t4 es la posicion de salida
 
    addu  t5, t2, a2			#En t5 sumo t2 y la direccion de memoria	
    ld   t6, 0(t5)
     
    addu  t8, t4, a3
    sd    t6, 0(t8)
    
 
    addi  t1, t1, 1
    b FOR_COLUMNAS
 
    .end trasponer

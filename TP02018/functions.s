	.file	1 "functions.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
	.type	OPTIONS, @object
	.size	OPTIONS, 8
OPTIONS:
	.ascii	"Vhlwci:\000"
	.align	2
$LC0:
	.ascii	"r\000"
	.align	2
$LC1:
	.ascii	"No se pudo abrir el archivo \n\000"
	.align	2
$LC2:
	.ascii	"No existe el comando \n\000"
	.align	2
$LC3:
	.ascii	"Debe ingresar un archivo con la opcion -i \n\000"
	.align	2
$LC4:
	.ascii	"Debe ingresar alguna opcion validad -l -w -c \n\000"
	.text
	.align	2
	.globl	parse_arguments
	.ent	parse_arguments
parse_arguments:
	.frame	$fp,80,$31		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$31,72($sp)
	sw	$fp,68($sp)
	sw	$28,64($sp)
	move	$fp,$sp
	sw	$4,80($fp)
	sw	$5,84($fp)
	sw	$0,28($fp)
	sw	$0,32($fp)
	sw	$0,36($fp)
	sw	$0,40($fp)
	sw	$0,48($fp)
	lw	$4,80($fp)
	lw	$5,84($fp)
	la	$6,OPTIONS
	la	$25,getopt
	jal	$31,$25
	sw	$2,24($fp)
$L18:
	lw	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L20
	b	$L19
$L20:
	lw	$2,24($fp)
	addu	$2,$2,-86
	sw	$2,56($fp)
	lw	$3,56($fp)
	sltu	$2,$3,34
	beq	$2,$0,$L29
	lw	$2,56($fp)
	sll	$3,$2,2
	la	$2,$L30
	addu	$2,$3,$2
	lw	$2,0($2)
	.cpadd	$2
	j	$2
	.rdata
	.align	2
$L30:
	.gpword	$L22
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L26
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L23
	.gpword	$L27
	.gpword	$L29
	.gpword	$L29
	.gpword	$L24
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L29
	.gpword	$L25
	.text
$L22:
	la	$25,versionDisplay
	jal	$31,$25
	sw	$0,48($fp)
	lw	$2,48($fp)
	sw	$2,52($fp)
	b	$L17
$L23:
	la	$25,helpDisplay
	jal	$31,$25
	sw	$0,48($fp)
	lw	$2,48($fp)
	sw	$2,52($fp)
	b	$L17
$L24:
	li	$2,1			# 0x1
	sw	$2,28($fp)
	b	$L21
$L25:
	li	$2,1			# 0x1
	sw	$2,32($fp)
	b	$L21
$L26:
	li	$2,1			# 0x1
	sw	$2,36($fp)
	b	$L21
$L27:
	li	$2,1			# 0x1
	sw	$2,40($fp)
	la	$25,__errno
	jal	$31,$25
	sw	$0,0($2)
	lw	$4,optarg
	la	$5,$LC0
	la	$25,fopen
	jal	$31,$25
	sw	$2,44($fp)
	la	$25,__errno
	jal	$31,$25
	lw	$2,0($2)
	beq	$2,$0,$L21
	la	$4,$LC1
	la	$25,printf
	jal	$31,$25
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,48($fp)
	lw	$2,48($fp)
	sw	$2,52($fp)
	b	$L17
$L29:
	la	$4,$LC2
	la	$25,printf
	jal	$31,$25
	li	$2,-2			# 0xfffffffffffffffe
	sw	$2,48($fp)
$L21:
	lw	$4,80($fp)
	lw	$5,84($fp)
	la	$6,OPTIONS
	la	$25,getopt
	jal	$31,$25
	sw	$2,24($fp)
	b	$L18
$L19:
	lw	$2,40($fp)
	bne	$2,$0,$L31
	la	$4,$LC3
	la	$25,printf
	jal	$31,$25
	li	$2,-5			# 0xfffffffffffffffb
	sw	$2,48($fp)
	lw	$2,48($fp)
	sw	$2,52($fp)
	b	$L17
$L31:
	lw	$2,28($fp)
	bne	$2,$0,$L32
	lw	$2,36($fp)
	bne	$2,$0,$L32
	lw	$2,32($fp)
	bne	$2,$0,$L32
	la	$4,$LC4
	la	$25,printf
	jal	$31,$25
	li	$2,-4			# 0xfffffffffffffffc
	sw	$2,48($fp)
	lw	$2,48($fp)
	sw	$2,52($fp)
	b	$L17
$L32:
	lw	$3,48($fp)
	li	$2,-2			# 0xfffffffffffffffe
	beq	$3,$2,$L33
	lw	$4,28($fp)
	lw	$5,32($fp)
	lw	$6,36($fp)
	lw	$7,44($fp)
	la	$25,read_text
	jal	$31,$25
	sw	$2,48($fp)
$L33:
	lw	$4,44($fp)
	la	$25,fclose
	jal	$31,$25
	lw	$2,48($fp)
	sw	$2,52($fp)
$L17:
	lw	$2,52($fp)
	move	$sp,$fp
	lw	$31,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$31
	.end	parse_arguments
	.size	parse_arguments, .-parse_arguments
	.rdata
	.align	2
$LC5:
	.ascii	"Se ha excedido el rango del contador \n\000"
	.align	2
$LC6:
	.ascii	"Lines: %llu \n\000"
	.align	2
$LC7:
	.ascii	"Words: %llu \n\000"
	.align	2
$LC8:
	.ascii	"Characters: %llu \n\000"
	.align	2
$LC9:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	read_text
	.ent	read_text
read_text:
	.frame	$fp,96,$31		# vars= 56, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,96
	.cprestore 16
	sw	$31,88($sp)
	sw	$fp,84($sp)
	sw	$28,80($sp)
	move	$fp,$sp
	sw	$4,96($fp)
	sw	$5,100($fp)
	sw	$6,104($fp)
	sw	$7,108($fp)
	li	$3,-1
	li	$2,-16
	sw	$2,24($fp)
	sw	$3,28($fp)
	li	$2,32			# 0x20
	sb	$2,33($fp)
	move	$2,$0
	move	$3,$0
	sw	$2,40($fp)
	sw	$3,44($fp)
	move	$8,$0
	move	$9,$0
	sw	$8,48($fp)
	sw	$9,52($fp)
	move	$2,$0
	move	$3,$0
	sw	$2,56($fp)
	sw	$3,60($fp)
	li	$2,1			# 0x1
	sw	$2,68($fp)
$L35:
	lw	$3,108($fp)
	lw	$2,108($fp)
	lw	$2,4($2)
	addu	$2,$2,-1
	sw	$2,4($3)
	bgez	$2,$L38
	lw	$4,108($fp)
	la	$25,__srget
	jal	$31,$25
	sw	$2,76($fp)
	b	$L39
$L38:
	lw	$2,108($fp)
	lw	$3,0($2)
	move	$4,$3
	lbu	$4,0($4)
	sw	$4,76($fp)
	addu	$3,$3,1
	sw	$3,0($2)
$L39:
	lw	$3,76($fp)
	sw	$3,64($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L37
	b	$L36
$L37:
	lbu	$2,64($fp)
	sb	$2,32($fp)
	lbu	$2,32($fp)
	sb	$2,33($fp)
	lw	$2,56($fp)
	lw	$3,60($fp)
	addu	$2,$2,1
	sltu	$4,$2,1
	addu	$3,$3,$4
	sw	$2,56($fp)
	sw	$3,60($fp)
	lbu	$3,32($fp)
	lw	$2,_ctype_
	addu	$2,$3,$2
	addu	$2,$2,1
	lbu	$2,0($2)
	srl	$2,$2,3
	andi	$2,$2,0x1
	beq	$2,$0,$L40
	li	$2,1			# 0x1
	sw	$2,68($fp)
	lbu	$3,32($fp)
	li	$2,10			# 0xa
	bne	$3,$2,$L42
	lw	$2,40($fp)
	lw	$3,44($fp)
	addu	$2,$2,1
	sltu	$4,$2,1
	addu	$3,$3,$4
	sw	$2,40($fp)
	sw	$3,44($fp)
	b	$L42
$L40:
	lw	$2,68($fp)
	sra	$4,$2,31
	lw	$2,68($fp)
	move	$3,$4
	lw	$4,48($fp)
	lw	$5,52($fp)
	addu	$8,$4,$2
	sltu	$6,$8,$2
	addu	$9,$5,$3
	addu	$9,$9,$6
	move	$2,$8
	move	$3,$9
	sw	$2,48($fp)
	sw	$3,52($fp)
	sw	$0,68($fp)
$L42:
	lw	$2,60($fp)
	lw	$3,28($fp)
	sltu	$2,$3,$2
	bne	$2,$0,$L44
	lw	$3,60($fp)
	lw	$2,28($fp)
	bne	$3,$2,$L35
	lw	$2,56($fp)
	lw	$3,24($fp)
	sltu	$2,$3,$2
	bne	$2,$0,$L44
	b	$L35
$L44:
	la	$4,$LC5
	la	$25,printf
	jal	$31,$25
	li	$9,-3			# 0xfffffffffffffffd
	sw	$9,72($fp)
	b	$L34
$L36:
	lbu	$3,33($fp)
	li	$2,10			# 0xa
	beq	$3,$2,$L45
	lw	$2,56($fp)
	lw	$3,60($fp)
	or	$2,$2,$3
	beq	$2,$0,$L45
	lw	$2,40($fp)
	lw	$3,44($fp)
	addu	$2,$2,1
	sltu	$4,$2,1
	addu	$3,$3,$4
	sw	$2,40($fp)
	sw	$3,44($fp)
$L45:
	lw	$2,96($fp)
	beq	$2,$0,$L46
	la	$4,$LC6
	lw	$6,40($fp)
	lw	$7,44($fp)
	la	$25,printf
	jal	$31,$25
$L46:
	lw	$2,100($fp)
	beq	$2,$0,$L47
	la	$4,$LC7
	lw	$6,48($fp)
	lw	$7,52($fp)
	la	$25,printf
	jal	$31,$25
$L47:
	lw	$2,104($fp)
	beq	$2,$0,$L48
	la	$4,$LC8
	lw	$6,56($fp)
	lw	$7,60($fp)
	la	$25,printf
	jal	$31,$25
$L48:
	la	$4,$LC9
	la	$25,printf
	jal	$31,$25
	sw	$0,72($fp)
$L34:
	lw	$2,72($fp)
	move	$sp,$fp
	lw	$31,88($sp)
	lw	$fp,84($sp)
	addu	$sp,$sp,96
	j	$31
	.end	read_text
	.size	read_text, .-read_text
	.rdata
	.align	2
$LC10:
	.ascii	"TP0 - Version 1.0 FIUBA 2018\n\000"
	.align	2
$LC11:
	.ascii	"Alumnos:\n\000"
	.align	2
$LC12:
	.ascii	"Pinto, Santiago 96850\n\000"
	.align	2
$LC13:
	.ascii	"Llauro, Manuel 95736\n\000"
	.align	2
$LC14:
	.ascii	"Reimondo, Matias 95899\n\000"
	.text
	.align	2
	.globl	versionDisplay
	.ent	versionDisplay
versionDisplay:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	la	$4,$LC10
	la	$25,printf
	jal	$31,$25
	la	$4,$LC11
	la	$25,printf
	jal	$31,$25
	la	$4,$LC12
	la	$25,printf
	jal	$31,$25
	la	$4,$LC13
	la	$25,printf
	jal	$31,$25
	la	$4,$LC14
	la	$25,printf
	jal	$31,$25
	la	$4,$LC9
	la	$25,printf
	jal	$31,$25
	move	$2,$0
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	versionDisplay
	.size	versionDisplay, .-versionDisplay
	.rdata
	.align	2
$LC15:
	.ascii	"Usage:\n"
	.ascii	"tp0 -h\n"
	.ascii	"tp0 -V\n"
	.ascii	"tp0 [options]\n"
	.ascii	"Options:\n"
	.ascii	"-V, --version Print version and quit.\n"
	.ascii	"-h, --help    Print this information.\n"
	.ascii	"-l, --words  Print number of lines in file.\n"
	.ascii	"-w, --words  Print number of words in file.\n"
	.ascii	"-c, --words  Print number of characters in file.\n"
	.ascii	"-i, --input  Path to the input file.\n"
	.ascii	"Examples:\n"
	.ascii	"tp0 -w -i input.txt\n\000"
	.text
	.align	2
	.globl	helpDisplay
	.ent	helpDisplay
helpDisplay:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	la	$4,$LC15
	la	$25,printf
	jal	$31,$25
	la	$4,$LC9
	la	$25,printf
	jal	$31,$25
	move	$2,$0
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	helpDisplay
	.size	helpDisplay, .-helpDisplay
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

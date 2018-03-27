	.file	1 "functions.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
	.type	LEGAL_CHARS, @object
	.size	LEGAL_CHARS, 65
LEGAL_CHARS:
	.ascii	"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234"
	.ascii	"567890-_\000"
	.align	2
	.type	OPTIONS, @object
	.size	OPTIONS, 5
OPTIONS:
	.ascii	"Vhio\000"
	.align	2
$LC0:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	in_out
	.ent	in_out
in_out:
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
	li	$2,1024			# 0x400
	sw	$2,32($fp)
	sw	$0,36($fp)
	lw	$4,32($fp)
	la	$25,malloc
	jal	$31,$25
	sw	$2,40($fp)
$L18:
	lw	$3,80($fp)
	lw	$2,80($fp)
	lw	$2,4($2)
	addu	$2,$2,-1
	sw	$2,4($3)
	bgez	$2,$L21
	lw	$4,80($fp)
	la	$25,__srget
	jal	$31,$25
	sb	$2,56($fp)
	b	$L22
$L21:
	lw	$2,80($fp)
	lw	$3,0($2)
	move	$4,$3
	lbu	$4,0($4)
	sb	$4,56($fp)
	addu	$3,$3,1
	sw	$3,0($2)
$L22:
	lbu	$2,56($fp)
	sb	$2,24($fp)
	sll	$2,$2,24
	sra	$3,$2,24
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L20
	b	$L19
$L20:
	lb	$2,24($fp)
	move	$4,$2
	la	$25,is_valid_char
	jal	$31,$25
	sw	$2,44($fp)
	lw	$2,44($fp)
	beq	$2,$0,$L23
	lw	$2,28($fp)
	lw	$3,32($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L24
	lw	$2,32($fp)
	addu	$2,$2,100
	sw	$2,32($fp)
	lw	$4,40($fp)
	lw	$5,32($fp)
	la	$25,realloc
	jal	$31,$25
	sw	$2,48($fp)
	lw	$2,48($fp)
	bne	$2,$0,$L25
	lw	$4,40($fp)
	la	$25,free
	jal	$31,$25
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,52($fp)
	b	$L17
$L25:
	lw	$2,48($fp)
	sw	$2,40($fp)
$L24:
	lw	$3,40($fp)
	lw	$2,28($fp)
	addu	$3,$3,$2
	lbu	$2,24($fp)
	sb	$2,0($3)
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	b	$L18
$L23:
	lw	$4,40($fp)
	lw	$5,28($fp)
	la	$25,is_capicua
	jal	$31,$25
	bne	$2,$0,$L27
	lw	$4,84($fp)
	lw	$5,40($fp)
	lw	$6,28($fp)
	lw	$7,36($fp)
	la	$25,print_word_in_file
	jal	$31,$25
	lw	$2,36($fp)
	addu	$2,$2,1
	sw	$2,36($fp)
$L27:
	lb	$3,24($fp)
	li	$2,10			# 0xa
	bne	$3,$2,$L28
	lw	$4,84($fp)
	la	$5,$LC0
	la	$25,fprintf
	jal	$31,$25
	sw	$0,36($fp)
$L28:
	lw	$2,40($fp)
	sb	$0,0($2)
	sw	$0,28($fp)
	b	$L18
$L19:
	lw	$4,40($fp)
	la	$25,free
	jal	$31,$25
	sw	$0,52($fp)
$L17:
	lw	$2,52($fp)
	move	$sp,$fp
	lw	$31,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$31
	.end	in_out
	.size	in_out, .-in_out
	.align	2
	.globl	is_valid_char
	.ent	is_valid_char
is_valid_char:
	.frame	$fp,32,$31		# vars= 16, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 0
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,8($fp)
	sw	$0,12($fp)
	sw	$0,16($fp)
$L30:
	lw	$2,16($fp)
	sltu	$2,$2,65
	bne	$2,$0,$L33
	b	$L31
$L33:
	lw	$3,16($fp)
	la	$2,LEGAL_CHARS
	addu	$2,$3,$2
	lb	$3,8($fp)
	lb	$2,0($2)
	bne	$3,$2,$L32
	li	$2,1			# 0x1
	sw	$2,12($fp)
$L32:
	lw	$2,16($fp)
	addu	$2,$2,1
	sw	$2,16($fp)
	b	$L30
$L31:
	lw	$2,12($fp)
	move	$sp,$fp
	lw	$fp,28($sp)
	addu	$sp,$sp,32
	j	$31
	.end	is_valid_char
	.size	is_valid_char, .-is_valid_char
	.rdata
	.align	2
$LC1:
	.ascii	" \000"
	.align	2
$LC2:
	.ascii	"%c\000"
	.text
	.align	2
	.globl	print_word_in_file
	.ent	print_word_in_file
print_word_in_file:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	sw	$4,48($fp)
	sw	$5,52($fp)
	sw	$6,56($fp)
	sw	$7,60($fp)
	lw	$2,60($fp)
	blez	$2,$L36
	lw	$4,48($fp)
	la	$5,$LC1
	la	$25,fprintf
	jal	$31,$25
$L36:
	sw	$0,24($fp)
$L37:
	lw	$2,24($fp)
	lw	$3,56($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L40
	b	$L35
$L40:
	lw	$3,52($fp)
	lw	$2,24($fp)
	addu	$2,$3,$2
	lb	$2,0($2)
	lw	$4,48($fp)
	la	$5,$LC2
	move	$6,$2
	la	$25,fprintf
	jal	$31,$25
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	b	$L37
$L35:
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	print_word_in_file
	.size	print_word_in_file, .-print_word_in_file
	.align	2
	.globl	is_capicua
	.ent	is_capicua
is_capicua:
	.frame	$fp,32,$31		# vars= 16, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 0
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$0,8($fp)
	lw	$2,36($fp)
	addu	$2,$2,-1
	sw	$2,12($fp)
	lw	$2,32($fp)
	lb	$2,0($2)
	bne	$2,$0,$L42
	lw	$2,8($fp)
	addu	$2,$2,1
	sw	$2,8($fp)
$L42:
	sw	$0,16($fp)
$L43:
	lw	$2,16($fp)
	lw	$3,36($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L46
	b	$L44
$L46:
	lw	$3,32($fp)
	lw	$2,16($fp)
	addu	$2,$3,$2
	lb	$2,0($2)
	sll	$3,$2,1
	lw	$2,_toupper_tab_
	addu	$2,$3,$2
	addu	$4,$2,2
	lw	$3,12($fp)
	lw	$2,16($fp)
	subu	$3,$3,$2
	lw	$2,32($fp)
	addu	$2,$3,$2
	lb	$2,0($2)
	sll	$3,$2,1
	lw	$2,_toupper_tab_
	addu	$2,$3,$2
	addu	$2,$2,2
	lh	$3,0($4)
	lh	$2,0($2)
	beq	$3,$2,$L45
	lw	$2,8($fp)
	addu	$2,$2,1
	sw	$2,8($fp)
$L45:
	lw	$2,16($fp)
	addu	$2,$2,1
	sw	$2,16($fp)
	b	$L43
$L44:
	lw	$2,8($fp)
	move	$sp,$fp
	lw	$fp,28($sp)
	addu	$sp,$sp,32
	j	$31
	.end	is_capicua
	.size	is_capicua, .-is_capicua
	.align	2
	.globl	no_arguments
	.ent	no_arguments
no_arguments:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	la	$4,__sF
	la	$5,__sF+88
	la	$25,in_out
	jal	$31,$25
	sw	$2,24($fp)
	lw	$2,24($fp)
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	no_arguments
	.size	no_arguments, .-no_arguments
	.rdata
	.align	2
$LC3:
	.ascii	"w\000"
	.align	2
$LC4:
	.ascii	"r\000"
	.align	2
$LC5:
	.ascii	"No existe el comando \n\000"
	.text
	.align	2
	.globl	one_argument
	.ent	one_argument
one_argument:
	.frame	$fp,64,$31		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$31,56($sp)
	sw	$fp,52($sp)
	sw	$28,48($sp)
	move	$fp,$sp
	sw	$4,64($fp)
	sw	$5,68($fp)
	lw	$4,64($fp)
	lw	$5,68($fp)
	la	$6,OPTIONS
	la	$25,getopt
	jal	$31,$25
	sw	$2,24($fp)
$L50:
	lw	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L52
	b	$L51
$L52:
	lw	$2,24($fp)
	sw	$2,40($fp)
	li	$2,104			# 0x68
	lw	$3,40($fp)
	beq	$3,$2,$L55
	lw	$3,40($fp)
	slt	$2,$3,105
	beq	$2,$0,$L60
	li	$2,86			# 0x56
	lw	$3,40($fp)
	beq	$3,$2,$L54
	b	$L58
$L60:
	li	$2,105			# 0x69
	lw	$3,40($fp)
	beq	$3,$2,$L57
	li	$2,111			# 0x6f
	lw	$3,40($fp)
	beq	$3,$2,$L56
	b	$L58
$L54:
	la	$25,versionDisplay
	jal	$31,$25
	b	$L53
$L55:
	la	$25,helpDisplay
	jal	$31,$25
	b	$L53
$L56:
	lw	$2,68($fp)
	addu	$2,$2,8
	lw	$4,0($2)
	la	$5,$LC3
	la	$25,fopen
	jal	$31,$25
	sw	$2,28($fp)
	la	$4,__sF
	lw	$5,28($fp)
	la	$25,in_out
	jal	$31,$25
	sw	$2,36($fp)
	lw	$4,28($fp)
	la	$25,fclose
	jal	$31,$25
	b	$L53
$L57:
	lw	$2,68($fp)
	addu	$2,$2,8
	lw	$4,0($2)
	la	$5,$LC4
	la	$25,fopen
	jal	$31,$25
	sw	$2,32($fp)
	lw	$4,32($fp)
	la	$5,__sF+88
	la	$25,in_out
	jal	$31,$25
	sw	$2,36($fp)
	lw	$4,32($fp)
	la	$25,fclose
	jal	$31,$25
	b	$L53
$L58:
	la	$4,$LC5
	la	$25,printf
	jal	$31,$25
$L53:
	lw	$4,64($fp)
	lw	$5,68($fp)
	la	$6,OPTIONS
	la	$25,getopt
	jal	$31,$25
	sw	$2,24($fp)
	b	$L50
$L51:
	lw	$2,36($fp)
	move	$sp,$fp
	lw	$31,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$31
	.end	one_argument
	.size	one_argument, .-one_argument
	.rdata
	.align	2
$LC6:
	.ascii	"-o\000"
	.align	2
$LC7:
	.ascii	"-i\000"
	.text
	.align	2
	.globl	two_arguments
	.ent	two_arguments
two_arguments:
	.frame	$fp,56,$31		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$31,48($sp)
	sw	$fp,44($sp)
	sw	$28,40($sp)
	move	$fp,$sp
	sw	$4,56($fp)
	sw	$5,60($fp)
	lw	$2,60($fp)
	addu	$2,$2,4
	lw	$4,0($2)
	la	$5,$LC6
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L62
	lw	$2,60($fp)
	addu	$2,$2,12
	lw	$4,0($2)
	la	$5,$LC7
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L62
	lw	$2,60($fp)
	addu	$2,$2,16
	lw	$4,0($2)
	la	$5,$LC4
	la	$25,fopen
	jal	$31,$25
	sw	$2,24($fp)
	lw	$2,60($fp)
	addu	$2,$2,8
	lw	$4,0($2)
	la	$5,$LC3
	la	$25,fopen
	jal	$31,$25
	sw	$2,28($fp)
	lw	$4,24($fp)
	lw	$5,28($fp)
	la	$25,in_out
	jal	$31,$25
	sw	$2,32($fp)
	lw	$4,24($fp)
	la	$25,fclose
	jal	$31,$25
	lw	$4,28($fp)
	la	$25,fclose
	jal	$31,$25
	b	$L63
$L62:
	lw	$2,60($fp)
	addu	$2,$2,12
	lw	$4,0($2)
	la	$5,$LC6
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L64
	lw	$2,60($fp)
	addu	$2,$2,4
	lw	$4,0($2)
	la	$5,$LC7
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L64
	lw	$2,60($fp)
	addu	$2,$2,8
	lw	$4,0($2)
	la	$5,$LC4
	la	$25,fopen
	jal	$31,$25
	sw	$2,24($fp)
	lw	$2,60($fp)
	addu	$2,$2,16
	lw	$4,0($2)
	la	$5,$LC3
	la	$25,fopen
	jal	$31,$25
	sw	$2,28($fp)
	lw	$4,24($fp)
	lw	$5,28($fp)
	la	$25,in_out
	jal	$31,$25
	sw	$2,32($fp)
	lw	$4,24($fp)
	la	$25,fclose
	jal	$31,$25
	lw	$4,28($fp)
	la	$25,fclose
	jal	$31,$25
	b	$L63
$L64:
	la	$4,$LC5
	la	$25,printf
	jal	$31,$25
$L63:
	lw	$2,32($fp)
	move	$sp,$fp
	lw	$31,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$31
	.end	two_arguments
	.size	two_arguments, .-two_arguments
	.rdata
	.align	2
$LC8:
	.ascii	"TP0 - Version 2.0 FIUBA 2017\n\000"
	.align	2
$LC9:
	.ascii	"Alumnos:\n\000"
	.align	2
$LC10:
	.ascii	"Charytoniuk, Martin 96354\n\000"
	.align	2
$LC11:
	.ascii	"Perez, Martin  97378 \n\000"
	.align	2
$LC12:
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
	la	$4,$LC8
	la	$25,printf
	jal	$31,$25
	la	$4,$LC9
	la	$25,printf
	jal	$31,$25
	la	$4,$LC10
	la	$25,printf
	jal	$31,$25
	la	$4,$LC11
	la	$25,printf
	jal	$31,$25
	la	$4,$LC12
	la	$25,printf
	jal	$31,$25
	la	$4,$LC0
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
$LC13:
	.ascii	"Usage:\n"
	.ascii	"tp0 -h\n"
	.ascii	"tp0 -V\n"
	.ascii	"tp0 [options]\n"
	.ascii	"Options:\n"
	.ascii	"-V, --version Print version and quit.\n"
	.ascii	"-h, --help    Print this information.\n"
	.ascii	"-i, --input   Location of the input file.\n"
	.ascii	"-o, --output  Location of the output file.\n"
	.ascii	"Examples:\n"
	.ascii	"tp0 -i ~/input -o ~/output\n\000"
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
	la	$4,$LC13
	la	$25,printf
	jal	$31,$25
	la	$4,$LC0
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
	.align	2
	.globl	version_option
	.ent	version_option
version_option:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	sw	$4,48($fp)
	sw	$5,52($fp)
	lw	$4,48($fp)
	lw	$5,52($fp)
	la	$6,OPTIONS
	la	$25,getopt
	jal	$31,$25
	sw	$2,24($fp)
$L69:
	lw	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L71
	b	$L70
$L71:
	lw	$2,24($fp)
	sw	$2,28($fp)
	li	$2,86			# 0x56
	lw	$3,28($fp)
	beq	$3,$2,$L73
	li	$2,104			# 0x68
	lw	$3,28($fp)
	beq	$3,$2,$L74
	b	$L75
$L73:
	la	$25,versionDisplay
	jal	$31,$25
	b	$L72
$L74:
	la	$25,helpDisplay
	jal	$31,$25
	b	$L72
$L75:
	la	$4,$LC5
	la	$25,printf
	jal	$31,$25
$L72:
	lw	$4,48($fp)
	lw	$5,52($fp)
	la	$6,OPTIONS
	la	$25,getopt
	jal	$31,$25
	sw	$2,24($fp)
	b	$L69
$L70:
	move	$2,$0
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	version_option
	.size	version_option, .-version_option
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

	.file	1 "main.c"
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
	.ascii	"Comandos Incorrectos\000"
	.align	2
$LC1:
	.ascii	"Se ha excedido el limite de memoria del sistema, la pala"
	.ascii	"bra que intenta ingresar es demasiado grande \n\000"
	.align	2
$LC2:
	.ascii	"Por favor actualice su sistema si desea ingresar una pal"
	.ascii	"abra tan grande\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
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
	sw	$0,24($fp)
	lw	$3,48($fp)
	li	$2,1			# 0x1
	bne	$3,$2,$L6
	la	$25,no_arguments
	jal	$31,$25
	sw	$2,24($fp)
	b	$L7
$L6:
	lw	$3,48($fp)
	li	$2,3			# 0x3
	bne	$3,$2,$L8
	lw	$4,48($fp)
	lw	$5,52($fp)
	la	$25,one_argument
	jal	$31,$25
	sw	$2,24($fp)
	b	$L7
$L8:
	lw	$3,48($fp)
	li	$2,5			# 0x5
	bne	$3,$2,$L10
	lw	$4,48($fp)
	lw	$5,52($fp)
	la	$25,two_arguments
	jal	$31,$25
	sw	$2,24($fp)
	b	$L7
$L10:
	lw	$3,48($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L12
	lw	$4,48($fp)
	lw	$5,52($fp)
	la	$25,version_option
	jal	$31,$25
	b	$L7
$L12:
	la	$4,$LC0
	la	$25,printf
	jal	$31,$25
$L7:
	lw	$3,24($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L14
	la	$4,$LC1
	la	$25,printf
	jal	$31,$25
	la	$4,$LC2
	la	$25,printf
	jal	$31,$25
$L14:
	move	$2,$0
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"

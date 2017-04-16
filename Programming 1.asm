.data

x:	.word	0:10
y:	.word	0:10
sum:	.word	0:10

 # Asking user for input

prompt1:	.asciiz	"Please enter 10 integers for first array:"
prompt2:	.asciiz	"Please enter 10 integers for second array:"
spaces:	.asciiz	"  "
newline:.asciiz	"\n"

.text

main:
	la	$a0,prompt1		# calling prompt;
	li	$v0,4
	syscall


	li	$s0,0
	la	$s1,x		# reference of prompt one;

rd_loop:			# making a loop;
	li	$v0,5		# putting everthing in loop; 
	syscall
	sw	$v0,($s1)
	add	$s1,$s1,4	# each word is 4 byets so adding 4 at a time;
	add	$s0,$s0,1
	blt	$s0,10,rd_loop	# closing loop;

	la	$a0,prompt2		# calling prompt;
	li	$v0,4		#Load immediate;
	syscall

	li	$s0,0
	la	$s1,y 	# reference of prompt one;
				
rd_loop1:		#  making a loop;
	li	$v0,5		#  putting everthing in loop ;
	syscall
	sw	$v0,($s1)
	add	$s1,$s1,4	# each word is 4 byets so adding 4 at a time;
	add	$s0,$s0,1
	blt	$s0,10,rd_loop1		# closing loop;


	li	$s0,0	# new Array; 
	la	$s1,x  	# First Array; 
	la	$s2,y 	# Second Array
	la	$s3,sum		# The Array sum
				
loop:	lw	$t1,($s1)	# Loding the word;  
	lw	$t2,($s2)
	add	$t1,$t2,$t1
	sw	$t1,($s3)
	add	$s1,$s1,4	#    each word is 4 byets so adding 4 at a time;
	add	$s2,$s2,4	#    each word is 4 byets so adding 4 at a time;
	add	$s3,$s3,4	#    each word is 4 byets so adding 4 at a time;
	add	$s0,$s0,1
	blt	$s0,10,loop		#	closing loop; 

	li	$v0,4			# listing immediate value in to regester;
	syscall


	li	$s0,0
	la	$s1,sum		# loding address of the sum array;

wr_loop:move	$a0,$s0		# Moving s0 in to a0;
	li	$v0,1		# listing immediate value in to regester;
	syscall

	la	$a0,spaces	# loading space; 
	li	$v0,4	# listing immediate value in to regester;
	syscall

	lw	$a0,($s1)	# Loding the word; 
	li	$v0,1	# listing immediate value in to regester;
	syscall

	la	$a0,newline		# Loding the space; 
	li	$v0,4	# listing immediate value in to regester;
	syscall

	add	$s1,$s1,4	# adding 4 to an array one;
	add	$s0,$s0,1	# adding 1 to an array new Array;
	blt	$s0,10,wr_loop	# loop done;

	li	$v0,10
	syscall
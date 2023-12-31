# Copyright 2002 Manu Datta (gmail.com ID Manu dot Datta)
# All rights reserved
	
.data
msg1: .asciiz "\nEnter integer values followed by return (-1 terminates input): \n"
msg2: .asciiz ","
msg3: .asciiz "Bubble Sort"
msg4: .asciiz "#########pass#########"
msg5: .asciiz "\n"
msg6: .asciiz "\nNumber list has been sorted\n"
.text 				
		
.globl main
main:
	move $s0,$gp			#get the intial point to save array 
	addi $t0,1			# $t0 = 1
	add $t1,$zero,$zero		# 
	add $t2,$zero,$zero		# 
	add $t3,$zero,$zero		# 
	add $t6,$zero,$zero        
	add $t4,$zero,$zero        
	sub $t7,$zero,1			# terminate        
	li $v0,4		# system call to put the string
	la $a0,msg1		# 
	syscall		#
	add $s1,$s0,$zero	# copy the pointer to array in $s1
entervalues:
	li $v0,5		# get the value in v0 
	syscall		# 
	beq $v0,$t7,bubblesort # end of string run to bubblesort
	sb $v0,0($s1)	# put the value at the position pointed by $s1
	addi $s1,1		# move the $s1 pointer by one
	add $t5,$s1,$zero # $t5 stores the end value
	j entervalues
bubblesort:
	add $t4,$s0,$zero
	addi $t6,1
	#s1-1 -> s0
	sub $s1,$s1,$t0
	beq $s1,$s0,ending  	# we have sorted everything
	#s0 -> s1
	add $s2,$s0,$zero
loopinterno:
	lb $t1,0($s2)		# first element
	lb $t2,1($s2)		# second element
	slt $t3,$t2,$t1		# 
	beq $t3,$zero,proximo	# 
	sb $t2,0($s2)		# 
	sb $t1,1($s2)		#		
proximo:
	addi $s2,1		#
	bne $s2,$s1,loopinterno #
	li $v0,4		# system call to put the string
	la $a0,msg5		# 
	syscall		#
	li $v0,4		# system call to put the string
	la $a0,msg4		# 
	syscall		#
	li $v0,4		# system call to put the string
	la $a0,msg5		# 
	syscall		#
imprime:
	li $v0,1
	lb $a0,0($t4)
	syscall
	li $v0,4
	la $a0,msg2
	syscall		
	addi $t4,1
	bne $t4,$t5,imprime
jal bubblesort	
ending:
	li $v0,4		# system call to put the string
	la $a0,msg6		# 
	syscall		#
	li $v0,5
	syscall	 
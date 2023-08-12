#include <stdio.h>

#Declare global variables 
int array[10];
int sortedArray[10];

main:

#Initialize array
la $t0, array
li $t1, 0

loop1:
addi $t1, $t1, 1
sll $t2, $t1, 2
add $t2, $t2, $t0

#Prompt user for input
li $v0, 4
la $a0, inputMsg
syscall

#Read user input
li $v0, 5
syscall

#Store the user input in array
sw $v0, 0($t2)

#Check if all inputs were entered
blt $t1, 10, loop1

#Sort the array
la $t0, array
li $t1, 0

loop2:
addi $t1, $t1, 1
sll $t2, $t1, 2
add $t2, $t2, $t0

#Compare the elements
lw $t3, 0($t2)
lw $t4, 4($t2)
bgt $t3, $t4, swap

#Swap the elements
sw $t3, 4($t2)
sw $t4, 0($t2)

swap:
j loop2

#Print the sorted array
li $t1, 0

loop3:
addi $t1, $t1, 1
sll $t2, $t1, 2
add $t2, $t2, $t0

#Load the element in $a0
lw $a0, 0($t2)

#Print the element
li $v0, 1
syscall

#Repeat until all elements are printed
blt $t1, 10, loop3

#Exit the program
li $v0, 10
syscalls
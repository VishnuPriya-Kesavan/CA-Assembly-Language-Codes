.data
numbers: .space 100 # space to store up to 25 32-bit numbers
input: .space 4 # space to store user input
prompt: .asciiz "Enter a number (-1 to stop): "
result: .asciiz "The even numbers in the set are: "
space: .asciiz " "

.text
.globl main
main:
# Prompt user to enter a number
li $v0, 4 # system call to print string
la $a0, prompt # load the address of the prompt string
syscall

# Read user input
li $v0, 5 # system call to read integer
la $a0, input # load the address of the input buffer
syscall
move $t0, $v0 # store user input in $t0

# Loop to read numbers from user
li $t1, 0 # initialize counter to 0
la $t2, numbers # load address of numbers array
readLoop:
beq $t0, -1, print # if input is -1, go to print loop
sw $t0, 0($t2) # store user input in numbers array
addi $t1, $t1, 1 # increment counter
addi $t2, $t2, 4 # move to next element in array
li $v0, 4 # print prompt again
la $a0, prompt
syscall
li $v0, 5 # read user input again
la $a0, input
syscall
move $t0, $v0 # store user input in $t0
j readLoop

# Loop to print even numbers
print:
li $v0, 4 # print result message
la $a0, result
syscall
la $t3, numbers # load address of numbers array
li $t4, 0 # initialize loop counter to 0
printLoop:
lw $t5, 0($t3) # load element of numbers array into $t5
rem $t6, $t5, 2 # check if the number is even
beq $t6, $zero, printNumber # if the number is even, go to printNumber
addi $t4, $t4, 1 # increment loop counter
addi $t3, $t3, 4 # move to next element in array
blt $t4, $t1, printLoop # if loop counter < array size, go back to print loop
j exit # if all numbers have been printed, exit program

printNumber:
li $v0, 1 # print the number
move $a0, $t5 
syscall
li $v0, 4 # print a space after the number
la $a0, space
syscall     
li $v0, 4 # print string system call
syscall
addi $t4, $t4, 1 # increment loop counter
addi $t3, $t3, 4 # move to next element in array
blt $t4, $t1, printLoop # if loop counter < array size, go back to print loop
j exit # if all numbers have been printed, exit program

exit:
li $v0, 10 # exit program
syscall

#code to find an element in an array
.data
numbers: .space 100 # space to store up to 25 32-bit numbers
input: .space 4 # space to store user input
prompt: .asciiz "Enter a number (-1 to stop): "
searchPrompt: .asciiz "Enter the number you want to search for: "
resultFound: .asciiz "The number was found in the set."
resultNotFound: .asciiz "The number was not found in this array."

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
beq $t0, -1, search # if input is -1, go to search loop
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

# Loop to search for a number
search:
li $v0, 4 # print search prompt
la $a0, searchPrompt
syscall
li $v0, 5 # read number to search for
syscall
move $t3, $v0 # store number to search for in $t3
li $t4, 0 # initialize loop counter to 0
la $t5, numbers # load address of numbers array
searchLoop:
lw $t6, 0($t5) # load element of numbers array into $t6
beq $t6, $t3, found # if the element matches the search number, go to found
addi $t4, $t4, 1 # increment loop counter
addi $t5, $t5, 4 # move to next element in array
blt $t4, $t1, searchLoop # if loop counter < array size, go back to search loop
j notFound # if element not found, go to not found

found:
li $v0, 4 # print message that number was found
la $a0, resultFound
syscall
j exit

notFound:
li $v0, 4 # print message that number was not found
la $a0, resultNotFound
syscall
j exit

exit:
li $v0, 10 # exit program
syscall

.data
prompt: .asciiz "Enter a number to calculate its factorial: "
result: .asciiz "The factorial of the number is: "
error: .asciiz "Error: input must be non-negative."

.text
.globl main
main:
# Prompt user to enter a number
li $v0, 4 # system call to print string
la $a0, prompt # load the address of the prompt string
syscall

# Read user input
li $v0, 5 # system call to read integer
syscall
move $t0, $v0 # store user input in $t0

# Check if input is negative
blt $t0, $zero, printError # if input is negative, print error message and exit

# Calculate factorial
li $t1, 1 # initialize factorial to 1
li $t2, 1 # initialize loop counter to 1
loop:
mul $t1, $t1, $t2 # multiply factorial by loop counter
addi $t2, $t2, 1 # increment loop counter
ble $t2, $t0, loop # if loop counter <= input, go back to loop
j printResult # if factorial has been calculated, print result and exit

printError:
li $v0, 4 # print error message
la $a0, error
syscall
j exit

printResult:
li $v0, 4 # print result message
la $a0, result
syscall
li $v0, 1 # print the factorial
move $a0, $t1
syscall
j exit

exit:
li $v0, 10 # exit program
syscall

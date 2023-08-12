.data
str1: .space 80   # Allocate space for string 1
str2: .space 80   # Allocate space for string 2
output: .space 160   # Allocate space for concatenated string
prompt1: .asciiz "Enter string 1: "   # Prompt for string 1 input
prompt2: .asciiz "Enter string 2: "   # Prompt for string 2 input
result: .asciiz "Concatenated string is :"   # Newline character
.text
.globl main
main:
li $v0, 4         # Prompt for string 1 input, system call for printing 
la $a0, prompt1   # Load address of prompt1 into $a0
syscall
li $v0, 8   # Read string system call,for string 1 input
la $a0, str1   # Load address of str1 into $a0
li $a1, 80   # Maximum number of characters to read
syscall
li $v0, 4   # Print string system call, Prompt for string 2 input
la $a0, prompt2   # Load address of prompt2 into $a0
syscall
li $v0, 8   # Read string system call
la $a0, str2   # Load address of str2 into $a0
li $a1, 80   # Maximum number of characters to read
syscall
# Concatenate the strings
la $t0, str1   # Load address of str1 into $t0
la $t1, str2   # Load address of str2 into $t1
la $t2, output   # Load address of output into $t2
loop:
lb $t3, ($t0)   # Load byte from str1 into $t3
beqz $t3, done   # If null byte, jump to done
sb $t3, ($t2)   # Store byte into output
addi $t0, $t0, 1   # Increment str1 pointer
addi $t2, $t2, 1   # Increment output pointer
j loop   # Jump back to loop
done:
lb $t3, ($t1)   # Load byte from str2 into $t3
beqz $t3, exit   # If null byte, jump to exit
sb $t3, ($t2)   # Store byte into output
addi $t1, $t1, 1   # Increment str2 pointer
addi $t2, $t2, 1   # Increment output pointer
j done   # Jump back to done
exit:
la $a0, result  # Load address of newline into $a0
li $v0, 4   # Print string system call
syscall
la $a0, output   # Load address of output into $a0
li $v0, 4   # Print concantenated string system call
syscall
li $v0, 10   # Exit program system call
syscall

.data
prompt: .asciiz "Enter a string: "
sub_prompt: .asciiz "Enter a sub-string to search for: "
output: .asciiz "The sub-string was found!\n"
nfound: .asciiz "The sub-string was not found.\n"
input_string: .space 80
sub_string: .space 80
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt   # Prompt user for input string
    syscall
    li $v0, 8
    la $a0, input_string     # Read input string
    li $a1, 80
    syscall
    li $v0, 4
    la $a0, sub_prompt         # Prompt user for sub-string
    syscall
    li $v0, 8
    la $a0, sub_string      # Read sub-string
    li $a1, 80
    syscall
    la $t0, input_string  # pointer to input string
    la $t1, sub_string   # pointer to sub-string           # Find sub-string in input string
loop:
    lb $t2, ($t0)        # get character from input string
    lb $t3, ($t1)        # get character from sub-string
    beqz $t3, found      # if end of sub-string, we have found it
    beqz $t2, not_found  # if end of input string, sub-string not found
    bne $t2, $t3, next   # if characters don't match, check next in input string
    addi $t0, $t0, 1    # move pointer to next character in input string
    addi $t1, $t1, 1    # move pointer to next character in sub-string
    j loop              # repeat loop
found:
    li $v0, 4
    la $a0, output      # Print message indicating sub-string was found
    syscall
    li $v0, 10            # Exit program
    syscall
next:
    la $t1, sub_string    # Move pointer back to beginning of sub-string
    addi $t0, $t0, 1       # Move pointer to next character in input string
    j loop                # Repeat loop
not_found:
    li $v0, 4
    la $a0, nfound        # Print message indicating sub-string was not found
    syscall
    li $v0, 10             # Exit program
    syscall

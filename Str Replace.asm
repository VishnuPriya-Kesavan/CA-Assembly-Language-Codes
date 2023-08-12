.data
prompt: .asciiz "Enter a string: " # Prompt for user input
find: .asciiz "Enter the string to replace: " # Prompt for the string to find
replace: .asciiz "Enter the string to replace with: " # Prompt for the replacement string
output: .asciiz "New string: " # Output message for the new string
buffer: .space 50 # Buffer for user input
string: .space 50 # Buffer for the original string
string_new: .space 50 # Buffer for the new string
find_string: .space 50 # Buffer for the string to find
replace_string: .space 50 # Buffer for the replacement string
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt            # Prompt the user for the string to modify
    syscall
    li $v0, 8
    la $a0, buffer             # Get user input
    li $a1, 50
    syscall
    la $t0, string             # Copy user input into string buffer
    la $t1, buffer
    loop_copy:
        lb $t2, ($t1)
        beq $t2, $zero, loop_copy_end # If end of input string, exit loop
        sb $t2, ($t0) # Copy byte from input string to buffer
        addi $t0, $t0, 1
        addi $t1, $t1, 1
        j loop_copy
    loop_copy_end:
        sb $zero, ($t0) # Null-terminate string buffer
    li $v0, 4
    la $a0, find         # Prompt the user for the string to find
    syscall
    li $v0, 8
    la $a0, find_string  # Get user input
    li $a1, 50
    syscall
    li $v0, 4
    la $a0, replace         # Prompt the user for the replacement string
    syscall
    li $v0, 8
    la $a0, replace_string        # Get user input
    li $a1, 50
    syscall
    la $t0, string
    la $t1, string_new      # Copy original string into new string buffer, replacing occurrences of find_string with replace_string
    la $t2, find_string
    la $t3, replace_string
    loop_copy_replace:
        lb $t4, ($t0)
        beq $t4, $zero, loop_copy_replace_end # If end of string, exit loop
        la $t5, loop_check # Set loop_check as destination for branch
    loop_check:
        lb $t6, ($t2)
        lb $t7, ($t0)
        beq $t6, $zero, loop_copy_replace_next # If end of find_string, replace string and continue
        beq $t6, $t7, loop_check_next # If current byte of find_string matches current byte of string, check next byte
        sb $t7, ($t1) # Copy byte from string to new string buffer
        addi $t0, $t0, 1
        addi $t1, $t1, 1
        j loop_copy_replace
   loop_check_next:
    addi $t0, $t0, 1 # Increment string buffer
    addi $t2, $t2, 1 # Increment find_string buffer
    beq $t6, $zero, loop_copy_replace # If end of find_string, replace string and continue
    j loop_check # Check next byte of find_string
loop_copy_replace_next:
    la $t2, replace_string # Reset replace_string buffer to beginning
    la $t6, loop_check # Set loop_check as destination for branch
    loop_replace:
        lb $t7, ($t3)
        sb $t7, ($t1) # Copy byte from replace_string to new string buffer
        addi $t1, $t1, 1
        addi $t3, $t3, 1
        lb $t8, ($t3)
        beq $t8, $zero, loop_copy_replace_end # If end of replace_string, exit loop
        j loop_replace
loop_copy_replace_end:
    sb $zero, ($t1) # Null-terminate new string buffer
    la $t0, output
    li $v0, 4
    syscall
    la $a0, string_new
    li $v0, 4
    syscall
    li $v0, 10
    syscall


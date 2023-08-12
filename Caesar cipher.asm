.data
prompt: .asciiz "Enter your name: "
output: .asciiz "Encrypted name: "
newline: .asciiz "\n"

.text
.globl main

main:
    # Display prompt to user and get input
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 8
    la $a0, buffer
    li $a1, 256
    syscall
    
    # Loop through input and encrypt each character
    la $t0, buffer
    la $t1, encrypted_buffer
    
loop:
    lb $t2, ($t0)
    beq $t2, 0, endloop  # End loop if null terminator is found
    
    addi $t2, $t2, 3     # Shift character by 3 positions
    sb $t2, ($t1)        # Store encrypted character
    
    addi $t0, $t0, 1     # Move to next character in input buffer
    addi $t1, $t1, 1     # Move to next character in output buffer
    j loop

endloop:
    # Display encrypted name to user
    li $v0, 4
    la $a0, output
    syscall
    
    li $v0, 4
    la $a0, encrypted_buffer
    syscall
    
    # Display newline and exit
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 10
    syscall

.data
buffer: .space 256
encrypted_buffer: .space 256

.data
prompt:        .asciiz "Enter a number: "
result_true:   .asciiz "The number is a Krishna Moorthy number."
result_false:  .asciiz "The number is not a Krishna Moorthy number."

.text
.globl main

main:
    # Print prompt message
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read the input number
    li $v0, 5
    syscall
    move $t0, $v0    # Move input number to $t0
    
    # Calculate the sum of factorials of digits
    li $t1, 0        # Initialize the sum to zero
    move $t2, $t0    # Copy input number to $t2
    
loop:
    beqz $t2, check  # If input number is zero, jump to check
    
    # Calculate factorial of the current digit
    andi $t3, $t2, 0xFF  # Get the least significant digit
    jal factorial      # Jump to the factorial subroutine
    
    # Add the factorial to the sum
    add $t1, $t1, $v0
    
    # Shift the input number right by one digit
    srl $t2, $t2, 8
    
    j loop

factorial:
    # Calculate factorial of the current digit
    move $v0, $t3    # Move current digit to $v0
    li $t4, 1       # Initialize counter to 1
    li $v1, 1       # Initialize factorial to 1
    
fact_loop:
    beq $t4, $v0, fact_exit   # If counter equals digit, exit loop
    
    mul $v1, $v1, $t4   # Multiply factorial by counter
    addi $t4, $t4, 1    # Increment counter
    j fact_loop
    
fact_exit:
    jr $ra  # Jump back to the calling instruction

check:
    # Compare sum with the original input number
    beq $t1, $t0, print_true
    j print_false

print_true:
    # Print the result
    li $v0, 4
    la $a0, result_true
    syscall
    j exit

print_false:
    # Print the result
    li $v0, 4
    la $a0, result_false
    syscall
    j exit

exit:
    # Exit the program
    li $v0, 10
    syscall

.data
    buffer: .space 100   # allocate space for a string of up to 100 characters
    prompt: .asciiz "Enter a string: "
    true:   .asciiz "The string is a palindrome."
    false:  .asciiz "The string is not a palindrome."
.text
main:
    li $v0, 4            # syscall code for printing a string
    la $a0, prompt       # load the address of the prompt string
    syscall
    li $v0, 8            # syscall code for reading a string
    la $a0, buffer       # load the address of the string buffer
    li $a1, 100          # maximum length of the string
    syscall
    move $t0, $a0        # copy the address of the string to $t0
    li $t1, 0            # initialize counter to 0
loop:
    lbu $t2, ($t0)       # load a byte from memory
    beqz $t2, check     # if the byte is zero, we have reached the end of the string
    addi $t1, $t1, 1    # increment the counter
    addi $t0, $t0, 1    # move to the next byte
    j loop              # repeat until we reach the end of the string
check:
    move $t0, $a0        # copy the address of the string to $t0
    addi $t1, $t1, -1    # decrement counter by 1 to get string length
    li $t3,2
    div $t1,$t2,$t3        # divide string length by 2 to get middle index
    mflo $t3             # store middle index in $t3
    add $t0, $t0, $t1    # add string length to $t0
    subi $t0, $t0, 1     # subtract 1 to point to last character of string
loop2:
    beq $t1, $zero, done # if middle index is 0, we have checked the entire string
    lbu $t2, ($a0)       # load byte from beginning of string
    lbu $t4, ($t0)       # load byte from end of string
    bne $t2, $t4, not_palindrome # if bytes don't match, string is not palindrome
    addi $a0, $a0, 1     # move pointer to next byte from beginning of string
    subi $t0, $t0, 1     # move pointer to next byte from end of string
    addi $t1, $t1, -1    # decrement counter
    j loop2              # repeat until middle index is reached
not_palindrome:
    li $v0, 4
    la $a0, false    # Print "The string is not a palindrome."
    syscall
    j done
done:
    li $v0, 4
    la $a0, true     # Print "The string is a palindrome."
    syscall
    li $v0, 10       # Exit program
    syscall

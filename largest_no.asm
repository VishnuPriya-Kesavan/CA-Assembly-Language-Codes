.data
prompt: .asciiz "Enter a number (-1 to exit): "
result: .asciiz "The maximum number is: "
numbers: .space 100

.text
.globl main

main:
    # Initialize variables
    li $t0, 0    # max = 0
    li $t1, 0    # count = 0

    # Prompt user to enter numbers
    loop:
        la $a0, prompt    # load prompt message
        li $v0, 4         # syscall for printing string
        syscall

        li $v0, 5         # syscall for reading integer
        syscall
        add $t2, $v0, $zero   # save user input to $t2

        # Check if user input is negative
        bltz $t2, done    #branch if less than zero

        # Update max value
        bge $t2, $t0, update_max
        j loop

    update_max:
        move $t0, $t2    # max = input value
        j loop

    done:
        # Print result
        la $a0, result    # load result message
        li $v0, 4         # syscall for printing string
        syscall

        move $a0, $t0     # load max value into $a0
        li $v0, 1         # syscall for printing integer
        syscall

        # End program
        li $v0, 10        # syscall for exit
        syscall

# MIPS Assembly code for finding the sorted array by getting user input

.data
    array:  .space 40    # space for 10 integers
    prompt1: .asciiz "Enter 10 integers:\n"
    prompt2: .asciiz "The sorted array is:\n"
    
.text
    main:
        # print the prompt to enter integers
        la $a0, prompt1
        li $v0, 4
        syscall
        
        # get 10 integers from the user and store in array
        la $t0, array
        li $t1, 10
        
    loop1:
        li $v0, 5
        syscall
        sw $v0, ($t0)
        addi $t0, $t0, 4
        addi $t1, $t1, -1
        bne $t1, $zero, loop1
        
        # sort the array using bubble sort
        li $t1, 10
        
    loop2:
        li $t2, 0
        la $t0, array
        
    loop3:
        lw $t3, ($t0)
        lw $t4, 4($t0)
        bge $t3, $t4, skip
        sw $t4, ($t0)
        sw $t3, 4($t0)
        li $t2, 1
    skip:
        addi $t0, $t0, 4
        addi $t1, $t1, -1
        bne $t1, $zero, loop3
        
        # if no swaps were made in the last pass, then the array is sorted
        beq $t2, $zero, end
        
        # otherwise, repeat the sorting process
        j loop2
        
    end:
        # print the prompt to show the sorted array
        la $a0, prompt2
        li $v0, 4
        syscall
        
        # print the sorted array
        la $t0, array
        
    loop4:
        lw $a0, ($t0)
        li $v0, 1
        syscall
        li $v0, 4
        la $a0, " "
        syscall
        addi $t0, $t0, 4
        addi $t1, $t1, -1
        bne $t1, $zero, loop4
        
        # exit the program
        li $v0, 10
        syscall

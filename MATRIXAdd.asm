.data
matrix1: .word 0:100 # first matrix
matrix2: .word 0:100 # second matrix
result: .word 0:100 # result matrix
newline: .asciiz "\n" # newline character
space:  .asciiz " "
MatSize:.asciiz " Enter matrix size: "
Mat1:.asciiz "Enter matrix 1 elements:"
Mat2:.asciiz "Enter matrix 2 elements:"
.text
.globl main

# function to print a matrix
print_matrix:
    li $t0, 0 # row index
    li $t1, 0 # column index

print_loop:
    beq $t0, $a0, done_print # if row index == size, exit loop

    # print matrix element
    lw $t2, ($a1) # load matrix element
    li $v0, 1 # print integer
    move $a0, $t2
    syscall

    addi $t1, $t1, 1 # increment column index
    bne $t1, $a0, next_column # if column index != size, go to next column

    # if column index == size, go to next row
    li $v0, 4 # print newline character
    la $a0, newline
    syscall
    addi $t0, $t0, 1 # increment row index
    li $t1, 0 # reset column index

    j print_loop

next_column:
    # print space character
    li $v0, 4 # print space character
    lw $a0, space
    syscall

    j print_loop

done_print:
    li $v0, 4 # print newline character
    lw $a0, newline
    syscall

    jr $ra # return from function

main:
    # prompt user for matrix size
    li $v0, 4 # print string
    la $a0,MatSize
    syscall

    li $v0, 5 # read integer
    syscall
    move $t0, $v0 # save matrix size to $t0
    mul $t2, $t0, $t0 #calculate total number of elements
    # prompt user for matrix 1
    la $a0,Mat1
    li $v0, 4 # print string
    syscall

    la $a1, matrix1 # set matrix1 pointer
    li $t1, 0 # element counter

    matrix1_loop:
        blt $t1, $t2, read_matrix1 # if element counter < size*size, read matrix element
        j matrix2_input # if element counter >= size*size, go to matrix 2 input

    read_matrix1:
        li $v0, 5 # read integer
        syscall
        sw $v0, ($a1) # store matrix element
        addi $a1, $a1, 4 # increment matrix pointer
        addi $t1, $t1, 1 # increment element counter
        j matrix1_loop

    # prompt user for matrix 2
    matrix2_input:
    la $a0, Mat2
    li $v0, 4 # print string
    syscall

    la $a1, matrix2 # set matrix2 pointer
    li $t1, 0 # reset element counter

    matrix2_loop:
        blt $t1, $t2,read_matrix2
read_matrix2:
li $v0, 5 # read integer
syscall
sw $v0, ($a1) # store matrix element
addi $a1, $a1, 4 # increment matrix pointer
addi $t1, $t1, 1 # increment element counter
j matrix2_loop

# add matrices
la $a1, matrix1 # set matrix1 pointer
la $a2, matrix2 # set matrix2 pointer
la $a3, result # set result matrix pointer
li $t1, 0 # reset element counter

add_loop:
    blt $t1, $t2, add_matrix # if element counter < size*size, add matrix element
    j print_result # if element counter >= size*size, print result matrix

add_matrix:
    lw $t2, ($a1) # load matrix1 element
    lw $t3, ($a2) # load matrix2 element
    add $t4, $t2, $t3 # add elements
    sw $t4, ($a3) # store result element
    addi $a1, $a1, 4 # increment matrix1 pointer
    addi $a2, $a2, 4 # increment matrix2 pointer
    addi $a3, $a3, 4 # increment result matrix pointer
    addi $t1, $t1, 1 # increment element counter
    j add_loop

# print result matrix
print_result:
la $a0 , Result_matrix
li $v0, 4 # print string
syscall
Result_matrix:
la $a1, result # set result matrix pointer
jal print_matrix # print result matrix

# exit program
li $v0, 10 # exit program
syscall
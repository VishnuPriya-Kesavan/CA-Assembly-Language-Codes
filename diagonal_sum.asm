.data
matrix: .word 1, 2, 3, 4   # matrix is 2x2
        .word 5, 6, 7, 8
sum:    .word 0             # initialize sum to 0
.text
.globl main
main:
    li $t0, 0             # set row counter to 0
    lw $t1, sum           # load sum into $t1
    li $t2, 0             # set column counter to 0
    li $t3, 2             # set matrix size to 2x2
loop:
    mul $t4, $t0, $t3     # calculate matrix index
    add $t4, $t4, $t0     # based on row and column
    add $t4, $t4, $t2
    sll $t4, $t4, 2       # multiply index by 4 to get byte offset
    la $t5, matrix        # load matrix address
    add $t5, $t5, $t4     # add offset to matrix address
    lw $t6, ($t5)         # load matrix element into $t6
    beq $t0, $t2, add_sum # check if on diagonal
    addi $t0, $t0, 1      # increment row
    addi $t2, $t2, 1      # increment column
    j loop
add_sum:
    add $t1, $t1, $t6     # add diagonal element to sum
    addi $t0, $t0, 1      # increment row
    addi $t2, $t2, 1      # increment column
    bne $t0, $t3, loop    # check if end of matrix
    sw $t1, sum           # store sum back into memory
    li $v0, 10            # exit program
    syscall

.data
array: .word 5, 2, 9, 1, 8, 3, 7, 4, 6, 0
n: .word 10
.text
.globl main
main:
    # initialize variables
    lw $t0, n      # load n into $t0
    addi $t1, $zero, 1  # set $t1 to 1
    addi $t2, $zero, 0  # set $t2 to 0
    add $t3, $zero, $zero  # set $t3 to 0
outer_loop:
    bge $t3, $t0, end_sort  # exit loop if $t3 >= n
    add $t2, $zero, $t3  # set $t2 to $t3
inner_loop:
    add $t4, $zero, $t2  # set $t4 to $t2
    addi $t4, $t4, 1  # increment $t4 by 1
    lbu $t5, array($t2)  # load array[$t2] into $t5
    lbu $t6, array($t4)  # load array[$t4] into $t6
    ble $t5, $t6, skip_swap  # skip swap if array[$t2] <= array[$t4]
    sb $t6, array($t2)  # store array[$t6] into array[$t2]
    sb $t5, array($t4)  # store array[$t5] into array[$t4]
skip_swap:
    addi $t2, $t2, 1  # increment $t2 by 1
    blt $t2, $t0, inner_loop  # loop back to inner_loop if $t2 < n
    addi $t3, $t3, 1  # increment $t3 by 1
    j outer_loop  # loop back to outer_loop
end_sort:
    li $v0, 10  # load system call 10 (exit) into $v0
    syscall  # call system call to exit

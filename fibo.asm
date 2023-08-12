.data
fib_limit:   .word 10        # limit of the Fibonacci series
fib_seq:     .space 40      # array to hold the Fibonacci sequence
newline:     .asciiz "\n"  # string for printing a new line
.text
.globl main  # initialize the first two numbers of the Fibonacci sequence and store them in the array
main:
  la $t0, fib_seq      # load address of the array
  li $t1, 0            # first number in the sequence
  li $t2, 1            # second number in the sequence
  sw $t1, 0($t0)       # store the first number in the array
  sw $t2, 4($t0)       # store the second number in the array
  addi $t0, $t0, 8     # increment the array pointer by 8 bytes
  la $t3, fib_limit    # load address of the limit
  lw $t3, 0($t3)       # load the limit value
  li $t4, 2            # index of the next Fibonacci number
  loop:
    bge $t4, $t3, exit  # exit the loop if we've reached the limit and compute the next Fibonacci number and store it in the array
    lw $t5, -8($t0)     # load the previous number from the array
    lw $t6, -4($t0)     # load the current number from the array
    add $t7, $t5, $t6   # add the previous and current numbers
    sw $t7, 0($t0)      # store the result in the array
    addi $t0, $t0, 4    # increment the array pointer by 4 bytes
    addi $t4, $t4, 1    # increment the index
    j loop             # repeat the loop
  exit: # print the Fibonacci sequence
    la $t0, fib_seq      # load address of the array
    li $t1, 0            # start index of the array
    li $t2, 2            # end index of the array
    li $v0, 4            # system call for printing a string
    la $a0, newline      # load the address of the newline string
    syscall              # print a newline
  print_loop:
    bge $t1, $t3, end_program # exit the program if we've printed up to the limit
    lw $a0, 0($t0)       # load the number from the array
    li $v0, 1            # system call for printing an integer
    syscall              # print the number
    la $a0, newline      # load the address of the newline string
    li $v0, 4            # system call for printing a string
    syscall              # print a newline
    addi $t0, $t0, 4    # increment the array pointer by 4 bytes
    addi $t1, $t1, 1    # increment the index
    j print_loop         # repeat the loop
  end_program:
    li $v0, 10           # system call for exiting the program
    syscall

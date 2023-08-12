# MIPS Assembly Language program to find the nth Fibonacci number
# Assumes n is passed in $a0
.data
fib_num: .space 16  # Space for two 32-bit Fibonacci numbers # Used to handle multiple-precision numbers
.text
.globl main
main:
  move $t0, $a0              # Store the value of n in $t0

  # Handle edge cases where n = 0 or n = 1
  li $t1, 0   # Initialize fib(0) to 0
  li $t2, 1   # Initialize fib(1) to 1
  beq $t0, 0, end
  beq $t0, 1, end

  # Calculate fib(n) for n > 1
  subi $t0, $t0, 2    # Decrement n by 2
  loop:
    # Calculate fib(n) = fib(n-1) + fib(n-2)
    add $t3, $t1, $t2  # t3 = fib(n-1) + fib(n-2)
    sw $t2, fib_num    # Save fib(n-2) in memory
    move $t2, $t1      # fib(n-2) = fib(n-1)
    lw $t1, fib_num    # fib(n-1) = previous fib(n-2)
    move $t0, $t0      # NOP instruction (to help with pipeline)
    addi $t0, $t0, -1  # Decrement n
    bne $t0, $0, loop  # Loop until n = 0

  end:
    move $v0, $t3      # Return fib(n) in $v0
    jr $ra             # Return from function

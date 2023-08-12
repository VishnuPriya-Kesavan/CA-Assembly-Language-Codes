# Fibonacci series program in MIPS assembly language

# Data segment
.data
prompt: .asciiz "Enter a number: "
fib_msg: .asciiz "Fibonacci series: "
newline: .asciiz "\n"
max_num: .word 0

# Text segment
.text
.globl main

# Main program
main:
  # Prompt the user for input
  li $v0, 4        # Print string system call code
  la $a0, prompt   # Load prompt string address into $a0
  syscall          # Print the prompt
  
  # Read user input
  li $v0, 5        # Read integer system call code
  syscall          # Read user input into $v0
  move $t0, $v0    # Move user input into $t0
  
  # Calculate and print Fibonacci series
  li $v0, 4        # Print string system call code
  la $a0, fib_msg  # Load Fibonacci message string address into $a0
  syscall          # Print the Fibonacci message
  
  # Initialize Fibonacci series
  li $t1, 0        # Set $t1 to 0
  li $t2, 1        # Set $t2 to 1
  
  # Print first two numbers in series
  li $v0, 1        # Print integer system call code
  move $a0, $t1    # Move $t1 into $a0
  syscall          # Print first number in series
  syscall          # Print newline
  move $a0, $t2    # Move $t2 into $a0
  syscall          # Print second number in series
  syscall          # Print newline
  
  # Calculate and print remaining numbers in series
  loop:
    add $t3, $t1, $t2   # Add $t1 and $t2 and store in $t3
    bgt $t3, $t0, done  # Branch to done if $t3 > user input
    li $v0, 1           # Print integer system call code
    move $a0, $t3       # Move $t3 into $a0
    syscall             # Print $t3
    syscall             # Print newline
    move $t1, $t2       # Move $t2 into $t1
    move $t2, $t3       # Move $t3 into $t2
    j loop              # Jump to loop label
  
  # Exit program
  done:
    li $v0, 10   # Exit system call code
    syscall      # Exit program

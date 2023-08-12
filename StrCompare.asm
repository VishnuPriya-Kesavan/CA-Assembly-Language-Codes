.data
str1: .space 20      # space for first string
str2: .space 20      # space for second string
msg1: .asciiz "Enter first string: "
msg2: .asciiz "Enter second string: "
eq: .asciiz "Strings are equal."
neq: .asciiz "Strings are not equal."
.text
main:
  li $v0, 4            
  la $a0, msg1            # Print message to enter first string
  syscall
  li $v0, 8               # Read first string
  la $a0, str1
  li $a1, 20
  syscall
  li $v0, 4
  la $a0, msg2               # Print message to enter second string
  syscall
  li $v0, 8
  la $a0, str2           # Read second string
  li $a1, 20
  syscall
   # Compare strings
  la $t0, str1      # address of first string
  la $t1, str2      # address of second string
    loop:
    lbu $t2, ($t0)    # load byte from first string
    lbu $t3, ($t1)    # load byte from second string
    beq $t2, $t3, equal    # if equal, go to equal label
    bne $t2, $t3, notequal  # if not equal, go to notequal label
    addi $t0, $t0, 1  # move to next byte in first string
    addi $t1, $t1, 1  # move to next byte in second string
    bne $t2, $zero, loop  # if not end of string, continue loop
    j end            # end of string
  notequal:
    li $v0, 4     # print "Strings are not equal."
    la $a0, neq
    syscall
    j end
  equal:
    addi $t0, $t0, 1  # move to next byte in first string
    addi $t1, $t1, 1  # move to next byte in second string
    bne $t2, $zero, loop  # if not end of string, continue loop
    li $v0, 4     # print "Strings are equal."
    la $a0, eq
    syscall
 end:
    li $v0, 10
    syscall

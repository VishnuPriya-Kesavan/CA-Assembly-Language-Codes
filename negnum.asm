.data
prompt: .asciiz "Enter a number (or enter '0' to stop and evaluate): "
neg_count: .asciiz "The count of negative numbers entered is: "
newline: .asciiz "\n"
.text
.globl main
main:
# set up variables
li $s0, 0 # counter for negative numbers
li $s1, 0 # input number
# print prompt
prompt_loop:
la $a0, prompt
li $v0, 4
syscall
# get user input
li $v0, 5
syscall
move $s1, $v0
# check if input is zero
beq $s1, $zero, end_loop
# check if input is negative
blt $s1, $zero, increment_counter
j prompt_loop

increment_counter:
# increment counter for negative numbers
addi $s0, $s0, 1
# continue loop
j prompt_loop

end_loop:
# print count of negative numbers
la $a0, neg_count
li $v0, 4
syscall
# print counter value
move $a0, $s0
li $v0, 1
syscall
# print newline
la $a0, newline
li $v0, 4
syscall
# exit program
li $v0, 10
syscall

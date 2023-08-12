.data
    prompt: .asciiz "Enter a student ID to search (or 'exit' to quit): "
    directory: .asciiz "John\n12345\nProjectA\nMary\n67890\nProjectB\nPeter\n54321\nProjectC\nAlice\n98765\nProjectD\nBob\n45678\nProjectE"
    foundMsg: .asciiz "Student ID found.\nStudent Name: "
    idMsg: .asciiz "Student ID: "
    projectMsg: .asciiz "Project: "
    notFoundMsg: .asciiz "Student ID not found in the directory.\nDo you want to add a project for this student? (y/n): "
    addPrompt: .asciiz "Enter the project name to add: "
    addedMsg: .asciiz "Project added to the directory."
    directoryInfo: .asciiz "Current Directory:\n"
    buffer: .space 20      # Input buffer for student ID

.text
.globl main

main:
    li $v0, 4               # Print directory information
    la $a0, directoryInfo
    syscall

    li $v0, 4               # Print the directory
    la $a0, directory
    syscall

search_loop:
    li $v0, 4               # Print prompt
    la $a0, prompt
    syscall

    li $v0, 8               # Read student ID from user
    la $a0, 20              # Maximum ID length
    la $a1, buffer          # Load the address of the input buffer
    syscall

    move $t0, $a1           # Store user input in $t0

    li $t1, 0               # Initialize index to 0
    la $t2, directory       # Load the base address of the directory

search_directory:
    lbu $t3, ($t2)          # Load a character from the directory

    beqz $t3, not_found     # If end of directory, ID not found

    beq $t3, 10, check_id   # If newline character, check the ID

    addiu $t2, $t2, 1       # Move to the next character in the directory

    j search_directory      # Continue searching the directory

check_id:
    addi $t1, $t1, 1        # Increment index
    addiu $t2, $t2, 1       # Move to the next character in the directory

    move $t3, $t2           # Store the address of the current character

    lbu $t4, ($t2)          # Load a character from the directory

    beqz $t4, not_found     # If end of directory, ID not found

    beq $t4, 10, compare_id # If newline character, compare the ID

    j check_id              # Continue checking the ID characters

compare_id:
    move $a0, $t0           # Pass user ID as the first argument
    move $a1, $t3           # Pass directory ID as the second argument

    jal compare_strings     # Jump to the compare_strings subroutine

    move $t5, $v0           # Store the result of string comparison

    beqz $t5, found         # If strings match, ID found

    j not_found             # ID doesn't match, ID not found

found:
    addi $t2, $t2, 1        # Move to the next character

    li $v0, 4               # Print found message
    la $a0, foundMsg
    syscall

    move $a0, $t2           # Pass the address of the student name
    jal print_string        # Jump to the print_string subroutine

    addi $t2, $t2, 6        # Move to the next line (skip ID)

    li $v0, 4               # Print ID message
    la $a0, idMsg
    syscall

    move $a0, $t2           # Pass the address of the student ID
    jal print_string        # Jump to the print_string subroutine

    addi $t2, $t2, 6        # Move to the next line (skip project)

    li $v0, 4               # Print project message
    la $a0, projectMsg
    syscall

    move $a0, $t2           # Pass the address of the project name
    jal print_string        # Jump to the print_string subroutine

    j search_loop           # Repeat search loop

not_found:
    li $v0, 4               # Print not found message
    la $a0, notFoundMsg
    syscall

    li $v0, 12              # Read a single character from user
    syscall

    beqz $v0, search_loop   # If the user enters 'n', repeat search loop

    li $v0, 4               # Print add prompt
    la $a0, addPrompt
    syscall

    li $v0, 8               # Read project name from user
    la $a0, 20              # Maximum project name length
    la $a1, buffer          # Load the address of the input buffer
    syscall

    move $a0, $t2           # Pass the address of the project name
    move $a1, $a1           # Pass the address of the user input
    jal add_project         # Jump to the add_project subroutine

    li $v0, 4               # Print added message
    la $a0, addedMsg
    syscall

    j search_loop           # Repeat search loop

compare_strings:
    li $v0, 0               # Initialize result to 0

compare_loop:
    lbu $t6, ($a0)          # Load a character from the first string

    lbu $t7, ($a1)          # Load a character from the second string

    beqz $t6, check_end     # If end of first string, check the end of the second string

    bne $t6, $t7, return    # If characters don't match, return 0

    addiu $a0, $a0, 1       # Move to the next character in the first string
    addiu $a1, $a1, 1       # Move to the next character in the second string

    j compare_loop          # Continue comparing characters

check_end:
    beqz $t7, return        # If end of second string, return 0

    j compare_loop          # Continue comparing characters

return:
    move $v0, $zero         # Set result to 0 (strings don't match)
    jr $ra                  # Return to the calling routine

print_string:
    li $v0, 4               # Print string
    syscall

    li $v0, 4               # Print new line
    la $a0, "\n"
    syscall

    jr $ra                  # Return to the calling routine

add_project:
    move $t8, $a0           # Store the address of the project name
    move $t9, $a1           # Store the address of the user input

add_loop:
    lb $t6, ($t9)           # Load a byte from the user input

    sb $t6, ($t8)           # Store the byte in the project name

    beqz $t6, add_end       # If end of input string, end the loop

    addiu $t8, $t8, 1       # Move to the next byte in the project name
    addiu $t9, $t9, 1       # Move to the next byte in the user input

    j add_loop              # Continue adding bytes to the project name

add_end:
    sb $zero, ($t8)         # Store null termination at the end of the project name

    jr $ra                  # Return to the calling routine


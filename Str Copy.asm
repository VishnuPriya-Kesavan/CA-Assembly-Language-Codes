.data
input:  .space  100    # allocate space for input string
output: .space  100    # allocate space for output string
prompt: .asciiz "Enter a string: "
copymsg:.asciiz "\nThe copied string is: "
nl:     .asciiz "\n"
.text
.globl main
main:
    li      $v0, 4          # system call for printing string
    la      $a0, prompt     # load address of prompt string
    syscall
    li      $v0, 8          # system call for reading string
    la      $a0, input      # load address of input buffer
    li      $a1, 100        # maximum number of characters to read
    syscall
    la      $s0, input      # address of input string
    la      $s1, output     # address of output string
copy:
    lb      $t0, ($s0)      # load a byte from input string
    beqz    $t0, print      # if null terminator, jump to print
    sb      $t0, ($s1)      # store byte to output string
    addi    $s0, $s0, 1     # increment input string pointer
    addi    $s1, $s1, 1     # increment output string pointer
    j       copy           # jump back to copy
print:
    li      $v0, 4          # system call for printing string
    la      $a0, copymsg    # load address of copymsg string
    syscall
    li      $v0, 4          # system call for printing string
    la      $a0, output     # load address of output string
    syscall
    li      $v0, 4          # system call for printing string
    la      $a0, nl         # load address of newline string
    syscall
    li      $v0, 10         # system call for exit
    syscall

.data
nl:     .asciiz "\n"


.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
    
    # Print a newLine
    jal		printNewLine		# jump to newLine and save position to $ra

    li		$v0, 10		        # Exit
    syscall

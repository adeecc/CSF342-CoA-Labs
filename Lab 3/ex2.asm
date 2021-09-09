.data
pi: 
    .double 3.14159
nl:
    .asciiz "\n"

preCvt:
    .asciiz "In double Precision: "

postCvt:
    .asciiz "After converting to float: "

.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
    # Load and print pi
    l.d		$f12, pi		    # $f12 = pi
    li		$v0, 3		        # $v0 = 6
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    # Read a double Number
    li		$v0, 7		        # $v0 = 6
    syscall                     # Read double number to $f0

    # Print pre convert message 
    la		$a0, preCvt		# 
    li		$v0, 4		# $v0 = 4
    syscall

    # Print the double value
    mov.d   $f12, $f0            # Move from 0 to 12
    li		$v0, 3		        # $v0 = 2
    syscall                     # Print $f12

    jal		printNewLine		# jump to newLine and save position to $ra

    # Convert
    mov.d   $f10, $f12
    cvt.s.d $f12, $f10

    # Print post convert message
    la		$a0, postCvt		# 
    li		$v0, 4		# $v0 = 4
    syscall

    # print the floating number
    li		$v0, 2		# $v0 = 2
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    li		$v0, 10		        # Exit
    syscall

.data
x:      .word	26
nl:     .asciiz	"\n"

evenMsg:	.asciiz "x is Even!"
oddMsg:	.asciiz "x is Odd!"


.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
	lw		$t1,	x
	# div		$0, 	$t1, 	2
	# mfhi	$t3

	# Equivalent to above code; rem is a pseudo instruction
	rem		$t3, 	$t1, 	2

	beq		$t3, 	1,		odd

	la		$a0, 	evenMsg
	li		$v0, 	4
	syscall

	beq		$0, 	$0, 	exit

odd:
	la		$a0, 	oddMsg
	li		$v0, 	4
	syscall

exit:	
    li		$v0, 10		        # Exit
    syscall

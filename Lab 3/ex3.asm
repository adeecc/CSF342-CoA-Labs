####### Note: NEVER use Odd f registers with doubles.

.data
x: 
    .float 3.14159
y:
    .float 2.71828

addMsg:
    .asciiz "x + y = "

subMsg:
    .asciiz "x - y = "

subWithNegMsg:
    .asciiz "x + (-y) = "

nl:
    .asciiz "\n"

cvtToD:
    .asciiz "Converting to double...\n"

.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
    # Load the numbers
    l.s     $f1, x
    l.s     $f2, y

    # Print the sum message
    la		$a0, addMsg		     # 
    li		$v0, 4              # $v0 = 4
    syscall

    # Print the sum
    add.s   $f12, $f1, $f2
    li		$v0, 2				# $v0 = 2
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    # Print the sub message
    la		$a0, subMsg			# 
    li		$v0, 4				# $v0 = 4
    syscall

    # Print the sub
    sub.s   $f12, $f1, $f2
    li		$v0, 2				# $v0 = 2
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    # Print the sub with neg message
    la		$a0, subWithNegMsg	# 
    li		$v0, 4				# $v0 = 4
    syscall

    # Print the sub using neg
    neg.s   $f3, $f2
    add.s   $f12, $f1, $f3
    li		$v0, 2				# $v0 = 2
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra
    
    # Print the cvtToDouble message
    la		$a0, cvtToD			# 
    li		$v0, 4				# $v0 = 4
    syscall

    # Converting to Double
    cvt.d.s $f4, $f2
    cvt.d.s $f2, $f1


    # Print the sum message
    la		$a0, addMsg			# 
    li		$v0, 4				# $v0 = 4
    syscall

    # Print the sum
    add.d   $f12, $f2, $f4
    li		$v0, 3				# $v0 = 3
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    # Print the sub message
    la		$a0, subMsg			# 
    li		$v0, 4				# $v0 = 4
    syscall

    # Print the sub
    sub.d   $f12, $f2, $f4
    li		$v0, 3				# $v0 = 3
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    # Print the sub with neg message
    la		$a0, subWithNegMsg	# 
    li		$v0, 4				# $v0 = 4
    syscall

    # Print the sub using neg
    neg.d   $f6, $f4
    add.d   $f12, $f2, $f6
    li		$v0, 3				# $v0 = 3
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    li		$v0, 10		        # Exit
    syscall

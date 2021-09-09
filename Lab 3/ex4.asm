.data
x: 
    .word 19
y:
    .word 4

mulMsg:
    .asciiz "x * y = "

divMsg:
    .asciiz "x / y = "

modMsg:
    .asciiz "x % y = "

nl:
    .asciiz "\n"


.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
    # Load x and y
    lw		$t0, x		        # 
    lw		$t1, y		        # 
    
    # Print Mul Message
    la		$a0, mulMsg		    # 
    li		$v0, 4		        # $v0 = 4
    syscall
    
    # Print Product
    mul     $a0, $t0, $t1
    li		$v0, 1		        # $v0 = 1
    syscall

    # Print a newLine
    jal		printNewLine		# jump to newLine and save position to $ra
    
    # Print Div Message
    la		$a0, divMsg		    # 
    li		$v0, 4		        # $v0 = 4
    syscall
    
    # Print Product
    div     $a0, $t0, $t1
    li		$v0, 1		        # $v0 = 1
    syscall

    # Print a newLine
    jal		printNewLine		# jump to newLine and save position to $ra

    # Print mod Message
    la		$a0, modMsg		    # 
    li		$v0, 4		        # $v0 = 4
    syscall
    
    # Print Product
    div     $t0, $t1            # Divide to generate remainder
    mfhi    $a0                 # mfhi contains the remainder after division
    li		$v0, 1		        # $v0 = 1
    syscall

    # Print a newLine
    jal		printNewLine		# jump to newLine and save position to $ra

    li		$v0, 10		        # Exit
    syscall

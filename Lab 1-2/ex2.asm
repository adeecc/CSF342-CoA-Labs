.data
    imsg: .asciiz "Enter any Number: "
    omsg: .asciiz "You Entered: "

.text
.globl main

main:
    # Print Input Message
    li		$v0, 4		        # $v0 = 4
    la		$a0, imsg		    # 
    syscall

    # Take Input
    li		$v0, 5		        # $v0 = 5
    syscall                     # Take input from user
    move 	$t0, $v0		    # $t0 = $v0

    # Print Output Message
    li		$v0, 4		        # $v0 = 4
    la		$a0, omsg		    # 
    syscall
    
    # Print Integer
    li		$v0, 1		        # $v0 = 1
    move 	$a0, $t0		    # $a0 = $t0
    syscall

    li		$v0, 10		        # Exit
    syscall

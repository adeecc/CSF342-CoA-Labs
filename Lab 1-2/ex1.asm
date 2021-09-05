.data

.text
.globl main

main:
    # Take Input
    li		$v0, 5		        # $v0 = 5
    syscall                     # Take input from user
    move 	$t0, $v0		    # $t0 = $v0  
    
    # Print Integer
    li		$v0, 1		        # $v0 = 1
    move 	$a0, $t0		    # $a0 = $t0
    syscall

    # Exit
    li		$v0, 10		        # Exit
    syscall

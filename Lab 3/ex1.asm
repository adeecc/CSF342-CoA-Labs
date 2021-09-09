.data
pi: 
    .float 3.14159
nl:
    .asciiz "\n"

.text
.globl main

main:
    l.s		$f12, pi		    # $f12 = pi
    li		$v0, 2		        # $v0 = 6
    syscall

    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall

    li		$v0, 6		        # $v0 = 6
    syscall                     # Read floating point number to $f0

    mov.s  $f12, $f0            # Move from 0 to 12

    li		$v0, 2		        # $v0 = 2
    syscall                     # Print $f12
    
    li		$v0, 10		        # Exit
    syscall

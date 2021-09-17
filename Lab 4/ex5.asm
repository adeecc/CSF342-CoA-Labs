.data
nl:	.asciiz	"\n"


.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
    # Returns in $v0 , MSB of $a0 
    srl     $v0,    $a0,    31

    # Flip bits
    xori     $v0,    $a0,    -1 # -1 = 0xFFFF_FFFF

    # Perform not operation
    
exit:	
    li		$v0, 10		        # Exit
    syscall

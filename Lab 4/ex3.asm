.data
nl:	.asciiz	"\n"
n:  .word   5

.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
    li      $t0,    0
    lw      $t1,    n

predicate:
    blt		$t1, 1, endloop	# if $t1 < 1 then endloop

consequent:
    add     $t0,    $t0,    $t1
    sub 	$t1,    $t1,    1			# $t1 = $t1 - 1
    j predicate          
    
endloop:
    move    $a0,    $t0 
    li      $v0,    1
    syscall
    
exit:	
    li		$v0, 10		        # Exit
    syscall

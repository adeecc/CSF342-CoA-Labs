.data
x: 
    .word 3
y:
    .word 2

minMsg: .asciiz "Min(x, y): "
maxMsg: .asciiz "Max(x, y): "


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
    lw		$t1, x		# 
    lw		$t2, y		# 

    # Min in t3, max in t4

    bgt		$t1,    $t2,    else	# if $t1 > $t2 then else
    move    $t3,    $t1     
    move    $t4,    $t2
    beq     $0,     $0,     exit

else:
    move    $t3,    $t2
    move    $t4,    $t1
    
exit:

    la      $a0,    minMsg
    li      $v0,    4
    syscall

    move    $a0,    $t3
    li      $v0,    1
    syscall

    jal printNewLine

    la      $a0,    maxMsg
    li      $v0,    4
    syscall

    move    $a0,    $t4
    li      $v0,    1
    syscall

    jal		printNewLine		# jump to newLine and save position to $ra

    li		$v0, 10		        # Exit
    syscall

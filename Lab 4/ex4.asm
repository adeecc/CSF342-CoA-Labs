.data
nl:	.asciiz	"\n"

minMsg: .asciiz "Min(x, y): "
maxMsg: .asciiz "Max(x, y): "

x: .float  1.23423648
y:	.float  1.237237

.text
.globl main

printNewLine:
    # Print a new line
    la		$a0, nl		        # $a0 = nl
    li		$v0, 4		        # $v0 = a
    syscall
    jr $ra

main:
	l.s		$f0, 	x
	l.s		$f1, 	y

	c.lt.s	$f0, 	$f1
	bc1t	end

swap:
	mov.s 	$f3,	$f0
	mov.s 	$f0,	$f1
	mov.s 	$f1,	$f3

end:
	la      $a0,    minMsg
    li      $v0,    4
    syscall

    mov.s    $f12,    $f0
    li      $v0,    2
    syscall

    jal printNewLine

    la      $a0,    maxMsg
    li      $v0,    4
    syscall

	mov.s    $f12,    $f1
    li      $v0,    2
    syscall

    jal		printNewLine
    
exit:	
    li		$v0, 10		        # Exit
    syscall

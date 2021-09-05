.data
nl: .asciiz "\n"
addMsg: .asciiz "The Sum is: "
subMsg: .asciiz "The Diff is: "

.text
.globl main

main:
    # Set Variables 
    li		$t1, 4		        # $t1 = 4
    li		$t2, 5		        # $t2 = 5
    
    la		$a0, addMsg		    # print Add Message
    li		$v0, 4		        # $v0 = 4
    syscall

    add		$t0, $t1, $t2		# $t0 = $t1 + $t2
    addi	$a0, $t0, 0			# $a0 = $t0 + 0 => $a0 = $t0
    li		$v0, 1		        # $v0 = 1
    syscall

    la		$a0, nl		        # print NewLine
    li		$v0, 4		        # $v0 = 4
    syscall

    la		$a0, subMsg		    # print Sub Message
    li		$v0, 4		        # $v0 = 4
    syscall

    sub		$t0, $t1, $t2		# $t0 = $t1 - $t2
    addi	$a0, $t0, 0			# $a0 = $t0 + 0 => $a0 = $t0
    li		$v0, 1		        # $v0 = 1
    syscall

    la		$a0, nl		        # 
    li		$v0, 4		        # $v0 = 4
    syscall

    li		$v0, 10		        # Exit
	syscall
    
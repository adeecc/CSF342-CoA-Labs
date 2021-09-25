.data
nl:	.asciiz	"\n"
str: .space 10
isPalindrome: .asciiz "String is a palindrome"
notPalindrome: .asciiz "String is NOT a palindrome"


.text
.globl main

printNL:
    # Print a new line
    la	$a0,	nl		#$a0 = nl
    li	$v0,	4		#$v0 = a
    syscall
    jr $ra

main:
    ### Check whether a string is a palindrome or no
    lb $t4, nl
    # Read String
    li $v0, 8
    la $a0, str
    li $a1, 10
    syscall

    add $t2, $a0, $zero # Load base Addr in $t2; find input string length

    slen_0: # Loop to find the last char
        lb      $t3, ($t2)
        addi    $t2, $t2, 1
        beq     $t3, $t4, next # If current byte is '\n'
        bne     $t3, $zero, slen_0 # If current byte is not '\0', then repeat

    next:
        add     $t1, $a0, $zero # load base addr in $t1
        addi    $t2, $t2, -2 # Because moved beyond '\0' or '\n


    test_loop:
        bge     $t1, $t2, is_palin
        lb      $t3, ($t1)
        lb      $t4, ($t2)
        bne     $t3, $t4, not_palin

        addi    $t1, $t1, 1
        addi    $t2, $t2, -1

        j test_loop

    is_palin:
        li      $v0, 4
        la      $a0, isPalindrome
        syscall
        j exit

    not_palin:
        li      $v0, 4
        la      $a0, notPalindrome
        syscall
        j exit

exit:	
    li	$v0,	10		# Exit
    syscall

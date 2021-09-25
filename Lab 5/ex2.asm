.data
nl:	.asciiz	"\n"
char: .asciiz	"u"


str: .space 10
charFound: .asciiz "Found char in string!"
charNotFound: .asciiz "char not found in string :("


.text
.globl main

printNewLine:
    # Print a new line
    la	$a0,	nl		#$a0 = nl
    li	$v0,	4		#$v0 = a
    syscall
    jr $ra

main:
    ### Search for a char in a string

    # Read String
    li $v0, 8
    la $a0, str
    li $a1, 10
    syscall

    # Load Char to search for:
    lb $t0, char
    li $t1, 0 # Char not found yet

    add $s0, $a0, 0 # $s0 = str
    lb  $s1, ($s0) # $s1 = str[0]

    search_loop:
        beq $s1, $zero, search_end # Termination Condition
        seq $t1, $s1, $t0 # $t1 = (str[0] == char)
        bgt $t1, $zero, search_end # If $t1 is set, go to search end, char found

        addi $s0, $s0, 1 # $s0 = str + 1
        lb  $s1, ($s0) # $s1 = str[0]

        j search_loop

    search_end:
        beq $t1, $zero, not_found

        # Char found
        li $v0, 4
        la $a0, charFound
        syscall

        j exit

    not_found:
        # Char found
        li $v0, 4
        la $a0, charNotFound
        syscall
        
        j exit


exit:	
    li	$v0,	10		# Exit
    syscall

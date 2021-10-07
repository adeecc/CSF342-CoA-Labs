.data
nl:	.asciiz	"\n"
str: .space 200

pk: .asciiz "k: "
pal012312: .asciiz "\nIs Palindrome\n"
notpal312: .asciiz "Is Not Palindrome\n"


itisa: .asciiz "It is a "
itisnota: .asciiz "It is not a "
kwaymsg: .asciiz "-way palindrome. "
kcompletemsg: .asciiz "-way complete palindrome."
notkwaymsg: .asciiz "It is not a k-way palindrome. It is not a k-way complete palindrome"

.text
.globl main

printNewLine:
    # Print a new line
    la	$a0,	nl		#$a0 = nl
    li	$v0,	4		#$v0 = a
    syscall
    jr $ra


# FUNCTION is_palindrome
# ARGS:
# a0: start offset
# a1: end offset
# RETURNS:
# v0: whether str[a0...a1] is a palindrome 

is_palindrome:
    addi		$sp,	$sp,	-4
    sw			$ra,	0($sp)

    li          $v0,    1
    move        $s1,    $a0
    move        $s2,    $a1

    pal__loop_condition:
        # While ($s1 < $s2) {
        slt			$t0, $s1, $s2
        beq			$t0, $zero, pal__loop_end
    pal__loop_body:

        lb  $t1, str($s1)
        lb  $t2, str($s2)

        bne $t1, $t2, not_pal

        add $s1, $s1, 1
        add $s2, $s2, -1
        j	pal__loop_condition

        not_pal:
            li $v0, 0
    pal__loop_end:
        # } 
        nop 


    lw			$ra,	0($sp)
    addi		$sp,	$sp, 4
    jr			$ra


main:

#### Vars
# t0: offset
# t7: size of str
# t8: str is k-way
# t9: str is a palindrome
####

    #	Load and Read String
    la			$a0,	str
    li			$a1,	200
    li			$v0,	8
    syscall

    la              $s1, str
    la              $s2, str

    str_len:
        lb $t0, ($s2)
        beq $t0, $zero, str_len_end
        add $s2, $s2, 1
        j str_len

    str_len_end:
        add         $s2, $s2, -2        
        sub			$t7, $s2, $s1		# $t7 = n - 1

    #### Check if str is a palindrome
    li          $a0, 0              # start = 0
    move        $a1, $t7            # end = n - 1

    jal         is_palindrome

    move 		$t9, $v0			# $t9 = $v0  
    

    iter_k__loop_init:
        li			$s0,	1 # $s0 = 1; 
    iter_k__loop_condition:
        bge			$s0,	$t7,	iter_k__loop_end		#	break if s0 >= n - 1
    
    iter_k__loop_body:
        # Do Stuff

        # Check if first segment is palindrom
        li          $a0, 0
        move        $a1, $s0
        jal is_palindrome
        move $s6, $v0


        # Check if second segment is palindrom
        add         $a0, $s0, 1
        move        $a1, $t7
        jal is_palindrome
        move $s7, $v0



        and     $t8, $s6, $s7
        add		$s0,	$s0,	1		#	$s0++

        beq     $t8, 1, k_found
        j iter_k__loop_condition
    iter_k__loop_end:
        nop

    k_notfound:
        #	Load and Print String
        la			$a0,	notkwaymsg
        li			$v0,	4
        syscall

        j exit

    k_found:
        la		    $a0, itisa			# $a0 = itisa
        li			$v0, 4				# syscall print str
        syscall							# execute

        move		$a0, $s0			# $a0 = $s0
        li			$v0, 1				# syscall print int
        syscall							# execute

        la		    $a0, kwaymsg		# $a0 = kwaymsg
        li			$v0, 4				# syscall print str
        syscall							# execute

        and         $t9, $t8, $t9
        beq         $t9, $zero, not_k_complete

        la		    $a0, itisa			# $a0 = itisa
        li			$v0, 4				# syscall print str
        syscall	

        move		$a0, $s0			# $a0 = $s0
        li			$v0, 1				# syscall print int
        syscall							# execute

        la		    $a0, kcompletemsg		# $a0 = kwaymsg
        li			$v0, 4				# syscall print str
        syscall	

        j exit

    not_k_complete:
        la		    $a0, itisnota			# $a0 = itisa
        li			$v0, 4				# syscall print str
        syscall	

        move		$a0, $s0			# $a0 = $s0
        li			$v0, 1				# syscall print int
        syscall							# execute

        la		    $a0, kcompletemsg		# $a0 = kwaymsg
        li			$v0, 4				# syscall print str
        syscall	


exit:
    li	$v0,	10		# Exit
    syscall

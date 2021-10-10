# ID: 2019A7PS0178H
# Name: Aditya Chopra
# Contact No: +91 90072 21485
# Email: f20190178@hyderabad.bits-pilani.ac.in


.data

num: .space 20
primes: .space 200

nl:	.asciiz	"\n"
space: .asciiz " "
debug_msg: .asciiz "Appending"

num_d_m: .asciiz "Enter the number of digits: "
num_m: .asciiz "Enter the number: "
op_m: .asciiz "Output: "


###### Vars
# $s5: sum
# $s7: size of number
# $s6: Address of number
######




.text
.globl main

# FUNCTION cvt_to_num
# ARGS:
# a0: start offset
# a1: end   offset
str_to_num:
    addi		$sp,	$sp,	-20
    sw			$s0,	16($sp)
    sw			$s1,	12($sp)
    sw			$s2,	8($sp)
    sw			$s3,	4($sp)
    sw			$ra,	0($sp)

    li          $v0, 0          # To store the number
    
    iter_i__loop_init:
        move		$s0,	$a0 # $s0 = $a0; 
    iter_i__loop_condition:
        bge			$s0,	$a1,	iter_i__loop_end		#	break if s0 >= $a1
    
    iter_i__loop_body:
        mul         $v0,    $v0,    10
        lb          $t0,    num($s0)
        sub         $t0,    $t0,    48 # Offset of 0
        add         $v0,    $v0,    $t0
                
    
        add			$s0,	$s0,	1		#	$s0++
        j iter_i__loop_condition
    iter_i__loop_end:
        nop


    lw			$s0,	16($sp)
    lw			$s1,	12($sp)
    lw			$s2,	8($sp)
    lw			$s3,	4($sp)
    lw			$ra,	0($sp)
    addi		$sp,	$sp, 20


    jr			$ra




# FUNCTION check_prime
# ARGS:
# a0: num
check_prime:
    addi		$sp,	$sp,	-20
    sw			$s0,	16($sp)
    sw			$s1,	12($sp)
    sw			$s2,	8($sp)
    sw			$s3,	4($sp)
    sw			$ra,	0($sp)

    move        $s0,    $a0

    beq		    $s0, 0, np	# if $s0 == 0 then np
    beq         $s0, 1, np
    beq         $s0, 2, p       



    iterl__loop_init:
        li			$t0,	2 # $t0 = 3; 
    iterl__loop_condition:
        bge			$t0,	$a0,	iterl__loop_end		#	break if t0 >= $a0
    
    iterl__loop_body:
        rem         $t1,    $a0,    $t0

        beq         $t1,    0,      np         
    
        add			$t0,	$t0,	1		#	$t0++
        j iterl__loop_condition
    iterl__loop_end:
        nop

    p:
        li      $v0, 1
        j exit__check_prime 

    np:
        li      $v0, 0
        j exit__check_prime



exit__check_prime:
    lw			$s0,	16($sp)
    lw			$s1,	12($sp)
    lw			$s2,	8($sp)
    lw			$s3,	4($sp)
    lw			$ra,	0($sp)
    addi		$sp,	$sp, 20



    jr			$ra


main:


###### Check str_to_num function



#### End test


# ###### Check isPrime function

# #	Read Int
# li			$v0,	5
# syscall
# move		$t0,	$v0

# move        $a0,    $t0
# jal         check_prime

# nop

# j exit

# ####### End test



#	Read sz
la			$a0,	num_d_m
li			$v0,	4
syscall

li			$v0,	5
syscall
move		$s7,	$v0

# Read number

#	Load and Print String
la			$a0,	num_m
li			$v0,	4
syscall

#	Load and Read String
la			$a0,	num
li			$a1,	20
li			$v0,	8
syscall
move		$s6,	$a0



iter_j__loop_init:
    li			$s0,	0 # $s0 = 0; 
iter_j__loop_condition:
    # CHECK THIS CONDITION
    bgt			$s0,	$s7,	iter_j__loop_end		#	break if s0 >= $s7

iter_j__loop_body:

    iterk__loop_init:
        add			$s1,	$s0,    1 # $s1 = $s0 + 1; 
    iterk__loop_condition:
        bgt			$s1,	$s7,	iterk__loop_end		#	break if s1 >= $s7
    
    iterk__loop_body:
        
        move        $a0, $s0
        move        $a1, $s1

        jal         str_to_num

        move        $s3,    $v0


        # ####### Debug Start

        # move		$a0,	$s3
        # li			$v0,	1
        # syscall

        # la			$a0, space
        # li			$v0, 4
        # syscall

        # ##### Debug End


        # Check if $t0 is prime
        move        $a0, $s3
        jal         check_prime

        # Add $s3 to $s5 if prime
        bne		    $v0, 1, skip_append	# if $v0 != 0 then skip_append

        # ####### Debug Start

        # la			$a0,	debug_msg
        # li			$v0,	4
        # syscall

        # ##### Debug End

        add         $s5, $s5, $s3


        skip_append:
            nop

        # ####### Debug Start

        # la			$a0, nl
        # li			$v0, 4
        # syscall

        # ##### Debug End
        
    
        add			$s1,	$s1,	1		#	$s1++
        j iterk__loop_condition
    iterk__loop_end:
        nop

    add			$s0,	$s0,	1		#	$s0++
    j iter_j__loop_condition
iter_j__loop_end:
    nop


#  Output
#	Load and Print String
la			$a0,	op_m
li			$v0,	4
syscall

#	Load and Print Int
move		$a0,	$s5
li			$v0,	1
syscall

    
exit:
    li	$v0,	10		# Exit
    syscall

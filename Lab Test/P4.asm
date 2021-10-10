.data
nl:	.asciiz	"\n"

num_1_m: .asciiz "Enter 1st Number: "
num_2_m: .asciiz "Enter 2nd Number: "

sign_1_m: .asciiz "Sign bit of num1: "
sign_2_m: .asciiz ", Sign bit of num2: "
sign_res_m: .asciiz ", Sign bit of result: "

exp_1_m: .asciiz "Exponent of num1: "
exp_2_m: .asciiz ", Exponent of num2: "

mantissa_1_m: .asciiz "Mantissa of num1: "
mantissa_2_m: .asciiz ", Mantissa of num2: "

exp_no_bias_res_m: .asciiz "Exponent without bias of result: "
exp__biased_res_m: .asciiz ", Exponent with bias of result: "
mantissa_denorm_m: .asciiz "Denormalized Mantissa after multiplication: "

exp_norm_res_m: .asciiz "Normalized Exponent: "
mantissa_norm_res_m: .asciiz "Normalized Mantissa: "

# 1110 1001 1001 1000 0000 0000 0000 0000


.text
.globl main

###### Vars:
# $f4: x
# $f5: y

# $t4: x
# $t5: y
# $t8: Res 

######

# FUNCTION get_mantissa
# ARGS:
# a0: x
# RETURN:
# v0: mantissa(x)
get_mantissa:
    and         $v0, $a0, 0x007FFFFF # Mask of sign and exp
    or          $v0, $v0, 0x00800000 # Append 1 at the 24th bit

    jr			$ra


# FUNCTION get_exp
# ARGS:
# a0: x
# RETURN:
# v0: exp(x)
get_exp:
    and         $v0, $a0, 0x7F800000 # Mask of Sign and Mantissa 
    srl		    $v0, $v0, 23			# $v0 = $v0 >> 23
    sub         $v0, $v0, 127

    jr			$ra


# FUNCTION calc_exp
# ARGS:
# a0: exp(x)
# a1: exp(y)
# RETURNS:
# v0: exp(x*y) (biased) and print the relevant information
calc_exp:
    add         $v0, $a0, $a1

    # Print Unbiased Exp of result
    la			$a0,	exp_no_bias_res_m
    li			$v0,	4
    syscall

    move		$a0,	$v0
    li			$v0,	1
    syscall

    add         $v0, $v0, 127


    # Print biased Exp of result
    la			$a0,	exp__biased_res_m
    li			$v0,	4
    syscall

    move		$a0,	$v0
    li			$v0,	1
    syscall

    jr			$ra


# FUNCTION calc_mantissa
# ARGS:
# a0: mantissa(x)
# a1: mantissa(y)

calc_mantissa:
    addi		$sp,	$sp,	-20
    sw			$s0,	16($sp)
    sw			$s1,	12($sp)
    sw			$s2,	8($sp)
    sw			$s3,	4($sp)
    sw			$ra,	0($sp)

    mult	    $a0, $a1			# $a0 * $a1 = Hi and Lo registers
    mfhi        $s0

    #	Print Denormalized Mantissa
    la			$a0,	mantissa_denorm_m
    li			$v0,	4
    syscall

    #	Move and Print Int
    move		$a0,	$s0
    li			$v0,	1
    syscall


    move        $v0, $s0

    lw			$s0,	16($sp)
    lw			$s1,	12($sp)
    lw			$s2,	8($sp)
    lw			$s3,	4($sp)
    lw			$ra,	0($sp)
    addi		$sp,	$sp, 20

    jr			$ra

main:

    #	Read x
    la			$a0,	num_1_m
    li			$v0,	4
    syscall

    #	Read Float
    li			$v0,	6
    syscall
    mov.s		$f4,	$f0

    #	Read y
    la			$a0,	num_2_m
    li			$v0,	4
    syscall

    #	Read Float
    li			$v0,	6
    syscall
    mov.s		$f5,	$f0


    mfc1        $t4, $f4
    mfc1        $t5, $f5


determine_sign_bits:
    #	Print Sign bit of x
    la			$a0,	sign_1_m
    li			$v0,	4
    syscall

    srl		    $a0, $t4, 31			# $a0 = $t4 >> 31
    li			$v0, 1
    syscall


    #	Print Sign bit of y
    la			$a0,	sign_2_m
    li			$v0,	4
    syscall

    srl		    $a0, $t5, 31			# $a0 = $t4 >> 31
    li			$v0, 1
    syscall
    

    xor         $t8, $t4, $t5 # Store result in $t8, 32nd Bit of $t8 = sign of result

    #	Print Sign bit of res
    la			$a0,	sign_res_m
    li			$v0,	4
    syscall

    srl		    $a0, $t8, 31			# $a0 = $t4 >> 31
    li			$v0, 1
    syscall


    la			$a0, nl
    li			$v0, 4
    syscall

    
get_exp_mantissa_of_inputs:

    # Get exp of x
    move        $a0,    $t4
    jal         get_exp
    move        $s1, $v0

    # Get exp of y
    move        $a0,    $t5
    jal         get_exp
    move        $s2, $v0

    # Get mantissa of x
    move        $a0,    $t4
    jal         get_mantissa
    move        $s3, $v0

    # Get mantissa of y
    move        $a0,    $t5
    jal         get_mantissa
    move        $s4, $v0

    # Print Exponents of inputs
    la			$a0,	exp_1_m
    li			$v0,	4
    syscall

    move	    $a0,	$s1
    li			$v0,	1
    syscall

    la			$a0,	exp_2_m
    li			$v0,	4
    syscall

    move		$a0,	$s2
    li			$v0,	1
    syscall

    la			$a0, nl
    li			$v0, 4
    syscall

    # Print Mantissa of inputs
    la			$a0,	mantissa_1_m
    li			$v0,	4
    syscall

    move		$a0,	$s3
    li			$v0,	1
    syscall

    la			$a0,	mantissa_2_m
    li			$v0,	4
    syscall

    move		$a0,	$s4
    li			$v0,	1
    syscall  

    la			$a0, nl
    li			$v0, 4
    syscall

    move        $a0, $s1
    move        $a1, $s2
    jal calc_exp
    move        $s6, $v0

    la			$a0, nl
    li			$v0, 4
    syscall

    move        $a0, $s3
    move        $a1, $s4
    jal calc_mantissa
    move        $s6, $v0

    



exit:
    li	$v0,	10		# Exit
    syscall

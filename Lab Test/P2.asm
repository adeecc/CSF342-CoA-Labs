.data
fibs: .space 20

in_N: .asciiz "N: "
in_M: .asciiz "M (Target Sum): "

ob: .asciiz "("
cb: .asciiz ") "
sep: .asciiz ","


#### Vars
# $s0: N
# $s1: M
####

.text
.globl main

# FUNCTION gen_fib
# ARGS:
# a0: N
# Generate the fibs array
gen_fib:
    addi		$sp,	$sp,	-20
    sw			$s0,	16($sp)
    sw			$s1,	12($sp)
    sw			$s2,	8($sp)
    sw			$s3,	4($sp)
    sw			$ra,	0($sp)


    # Store initial Values to avoid duplication
    la          $s0,    0
    li          $t0,    0
    sw          $t0,    fibs($s0)

    la          $s0,    4
    li          $t0,    1
    sw          $t0,    fibs($s0)

    la          $s0,    8
    li          $t0,    2
    sw          $t0,    fibs($s0)

    mul         $t8,    $a0,    4
    sub         $t8,    $t8,    4 # Do I need this?
    # $t8 = 4(N - 1)

    li          $t0,    2
    li          $t1,    3

    
    fib__loop_init:
        li			$s0,	12 # $s0 = 12; 
    fib__loop_condition:
        bge			$s0,	$t8,	fib__loop_end		#	break if s0 >= 4(N - 1)
    
    fib__loop_body:
        # Do Stuff

        sw      $t1,     fibs($s0)
        
        add     $t2, $t0, $t1
        move    $t0, $t1
        move    $t1, $t2

    
        add			$s0,	$s0,	4		#	$s0++
        j fib__loop_condition
    fib__loop_end:
        nop


    lw			$s0,	16($sp)
    lw			$s1,	12($sp)
    lw			$s2,	8($sp)
    lw			$s3,	4($sp)
    lw			$ra,	0($sp)
    addi		$sp,	$sp, 20


    jr			$ra


# FUNCTION print_pair
# ARGS:
# a0: x
# a1: y
# Prints "($a0, $a1) "
print_pair:

    addi		$sp,	$sp,	-20
    sw			$s0,	16($sp)
    sw			$s1,	12($sp)
    sw			$s2,	8($sp)
    sw			$s3,	4($sp)
    sw			$ra,	0($sp)

    move        $s0, $a0
    move        $s1, $a1

    #	Load and Print String
    la			$a0,	ob
    li			$v0,	4
    syscall

    move		$a0, $s0			 
    li			$v0, 1				
    syscall						

    #	Load and Print String
    la			$a0,	sep
    li			$v0,	4
    syscall

    move		$a0, $s1		 
    li			$v0, 1				
    syscall						

    #	Load and Print String
    la			$a0,	cb
    li			$v0,	4
    syscall

    lw			$s0,	16($sp)
    lw			$s1,	12($sp)
    lw			$s2,	8($sp)
    lw			$s3,	4($sp)
    lw			$ra,	0($sp)
    addi		$sp,	$sp, 20


    jr			$ra



##### Print New Lines (duh)
printNewLine:
    addi		$sp,	$sp,	-4
    sw			$ra,	0($sp)

    la	$a0,	nl
    li	$v0,	4
    syscall

    lw			$ra,	0($sp)
    addi		$sp,	$sp, 4

    jr			$ra






main:

    #	Read N
    la			$a0,	in_N
    li			$v0,	4
    syscall

    li			$v0,	5
    syscall
    move		$s6,	$v0

    #	Read M
    la			$a0,	in_M
    li			$v0,	4
    syscall

    li			$v0,	5
    syscall
    move		$s7,	$v0



    # Generate the Fibonacci Sequences
    move        $a0, $s6
    jal         gen_fib



    # Start Checking pairs
    mul         $t6, $s6, 4
    blt         $s6, 3, check_pairs # If number of items < 2, our optimization has not been used
    sub         $t6, $t6, 4 # Reduce number of elements to check by one, since we removed the duplicate 1

    check_pairs:

    iter_i__loop_init:
        li			$s0,	0 # $s0 = 0; 
    iter_i__loop_condition:
        bge			$s0,	$t6,	iter_i__loop_end		#	break if s0 >= $t6
    
    iter_i__loop_body:
        lw          $t0,    fibs($s0)


        iter_j__loop_init:
            add			$s1,	$s0,    4 # $s1 = $s0 + 4; to avoid (x, x) pairs 
        iter_j__loop_condition:
            bge			$s1,	$t6,	iter_j__loop_end		#	break if s1 >= $t6
        
        iter_j__loop_body:
            lw          $t1, fibs($s1)

            add         $t2, $t0, $t1


            ble         $t2, $s7, continue
            
            move        $a0, $t0
            move        $a1, $t1
            jal         print_pair

            continue:
                nop

            add			$s1,	$s1,	4		#	$s1++
            j iter_j__loop_condition
        iter_j__loop_end:
            nop


    
        add			$s0,	$s0,	4		#	$s0++
        j iter_i__loop_condition
    iter_i__loop_end:
        nop


exit:
    li	$v0,	10		# Exit
    syscall


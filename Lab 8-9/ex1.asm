.data
nl:	.asciiz	"\n"


.text
.globl main

### VARS
# s1: Bytes of data to be stores, = num elements * 4
# s2: Base Address of Array
# s3: sum
main:
    #	Read Int
    li			$v0,	5
    syscall
    move		$s1,	$v0
    mul         $s1,    $s1,    4 # s1 = s1 * 4

    # Allocate Memory
    move 	    $a0,    $s1		# $a0 = $s1      
    li          $v0,    9
    syscall

    move 	$s2, $v0		# $s2 = $v0
    move 	$t0, $v0		# $t0 = $v0

    array_in__loop_init:
        li			$s0,	0 # $s0 = 0; 
    array_in__loop_condition:
        bge			$s0,	$s1,	array_in__loop_end		#	break if s0 >= $s1
    
    array_in__loop_body:
        # Do Stuff

        #	Read N integers
        li			$v0,	5
        syscall
        move		$t1,	$v0

        sw          $t1,    0($t0)

        add         $t0,    $t0,    4
        add			$s0,	$s0,	4		#	$s0 += 4
        j array_in__loop_condition
    array_in__loop_end:
        nop



    # Compute the sum
    li      $s3,    0
    move    $t0,    $s2

    sum__loop_init:
        li			$s0,	0 # $s0 = 0; 
    sum__loop_condition:
        bge			$s0,	$s1,	sum__loop_end		#	break if s0 >= $s1
    
    sum__loop_body:
        lw          $t1,    0($t0)

        add         $s3,    $s3,    $t1

        add         $t0,    $t0,    4
        add			$s0,	$s0,	4		#	$s0 += 4
        j sum__loop_condition
    sum__loop_end:
        nop


    #	Move and Print Int
    move		$a0,	$s3
    li			$v0,	1
    syscall

exit:
    li	$v0,	10		# Exit
    syscall

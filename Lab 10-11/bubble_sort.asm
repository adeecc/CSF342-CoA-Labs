.data
nl:	.asciiz	"\n"
space: .asciiz " "
m_Size: .asciiz "Enter Size of array: " 
m_Input: .asciiz "Enter Array Elements: "
m_Sorted: .asciiz "Sorted Array: "
.text
.globl main

###### Variables
# s0: Base Location of the array
# s1: 4 * Numner of elements in the array
# 3 1 2 5 4 7 6
main:
	#	Load and Print String
	la			$a0,	m_Size
	li			$v0,	4
	syscall

	# Read N, and Allocate Space for Array
	li			$v0,	5
	syscall
	move		$s1,	$v0
	mul			$s1,	$s1,	4
	
	move 		$a0, 	$s1		# $a0 = $s0
	li 			$v0, 	9
	syscall

	move 		$s0, 	$v0		# $s0 = $v0

	#	Load and Print String
	la			$a0,	m_Input
	li			$v0,	4
	syscall


	move 		$a0, 	$s0		# $a0 = $s1
	move 		$a1, 	$s1
	jal 		arr_input


	move 		$a0, 	$s0		# $a0 = $s1
	move 		$a1, 	$s1
	jal 		bubble_sort


	#	Load and Print String
	la			$a0,	m_Sorted
	li			$v0,	4
	syscall


	move 		$a0, 	$s0		# $a0 = $s1
	move 		$a1, 	$s1
	jal 		arr_print
	move 		$s0, 	$v0

exit:
    li	$v0,	10		# Exit
    syscall



# FUNCTION arr_input
# ARGS:
# a0: base address of array
# a1: number of bytes
arr_input:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)

	move 			$s0, 	$a0
	move 			$s1, 	$a1


	#### Get Array Input
	arr_input__loop_init:
		li			$t0,	0 # $t0 = 0; 
	arr_input__loop_condition:
		bge			$t0,	$s1,	arr_input__loop_end		#	break if t0 >= $s1
	
	arr_input__loop_body:
		li			$v0,	5
		syscall
	
		sw			$v0, 	0($s0)
	
		add			$s0,	$s0,	4		#	$a0 += 4
		add			$t0,	$t0,	4		#	$t0 += 4
	
		j arr_input__loop_condition
	arr_input__loop_end:
		nop


	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra



# FUNCTION bubble_sort
# ARGS:
# a0: base address of array
# a1: number of bytes
bubble_sort:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)

	move 	$s0, $a0		# $s0 = $a0
	move 	$s1, $a1
	sub		$s2, $s1, 4		# $s2 = $s1 - 4
	

	bubble_sort_outer__loop_init:
		li			$t0,	0 # $t0 = 0; 
	bubble_sort_outer__loop_condition:
		bge			$t0,	$s2,	bubble_sort_outer__loop_end		#	break if t0 >= $s2
	
	bubble_sort_outer__loop_body:
		
		bubble_sort_inner__loop_init:
			li			$t1,	0 # $t1 = 0; 
		bubble_sort_inner__loop_condition:
			bge			$t1,	$s2,	bubble_sort_inner__loop_end		#	break if t1 >= $S2
		
		bubble_sort_inner__loop_body:
			# 

			add			$t2, 	$s0, 	$t1 	# $t2 = base_addr + j
			add			$t3, 	$t2, 	4		# $t3 = base_addr + j + 4
			
			lw			$t4, 	0($t2)			# $t4 = A[j]
			lw			$t5, 	0($t3)			# $t5 = A[j + 1]

			# if (a[j + 1] > a[j]) break

			bge		$t5, $t4, bubble_sort_inner__loop_iter	# if $t0 >= $t1 then jump

			# swap(a[j + 1], a[j])
			sw			$t5, 	0($t2)
			sw			$t4, 	0($t3)

			bubble_sort_inner__loop_iter:
			add			$t1,	$t1,	4		#	$t1++
			j bubble_sort_inner__loop_condition
		bubble_sort_inner__loop_end:
			nop
	
		add			$t0,	$t0,	4		#	$t0++
		j bubble_sort_outer__loop_condition
	bubble_sort_outer__loop_end:
		nop

	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra




# FUNCTION arr_print
# ARGS:
# a0: base address of array
# a1: number of bytes
arr_print:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)


	move 			$s0, 	$a0
	#### Print Array
	arr_print__loop_init:
		li			$t0,	0 # $t0 = 0; 
	arr_print__loop_condition:
		bge			$t0,	$a1,	arr_print__loop_end		#	break if t0 >= $a1
	
	arr_print__loop_body:

		lw			$a0, 	0($s0)
		li			$v0,	1
		syscall


		#	Load and Print String
		la			$a0,	space
		li			$v0,	4
		syscall
	
	
		add			$s0,	$s0,	4		#	$s0 += 4
		add			$t0,	$t0,	4		#	$t0 += 4
	
		j arr_print__loop_condition
	arr_print__loop_end:
		nop

	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra
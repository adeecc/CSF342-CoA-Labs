.data
nl:	.asciiz	"\n"
space: .asciiz " "
m_inOrderTraversal: .asciiz "Inorder Traversal of the BST: "
m_preOrderTraversal: .asciiz "Preorder Traversal of the BST: "
m_postOrderTraversal: .asciiz "Postorder Traversal of the BST: "

# 5 7 3 6 1 4 2 10 9 8 
.text
.globl main

main:
	li  $s0,    0
	read_input:
	
	#	Read Int
	li		$v0,	5
	syscall

	beq     $v0,    $zero,  no_more_inputs

	
	move    $a0,    $s0 	# Pass the root node
	move    $a1,    $v0 	# Pass the input value

	jal tree_insert
	move 	$s0, $v0		# $s0 = $v0 # Update the Root Node

	j read_input

	no_more_inputs:
	# Perform Preorder Traversal of Tree
	la			$a0,	m_preOrderTraversal
	li			$v0,	4
	syscall

	move    $a0,    $s0
	jal preorder_traversal

	la			$a0, nl
	li			$v0, 4
	syscall

	# Perform Inorder Traversal of Tree
	la			$a0,	m_inOrderTraversal
	li			$v0,	4
	syscall

	move    $a0,    $s0
	jal inorder_traversal

	la			$a0, nl
	li			$v0, 4
	syscall

	# Perform Inorder Traversal of Tree
	la			$a0,	m_postOrderTraversal
	li			$v0,	4
	syscall

	move    $a0,    $s0
	jal postorder_traversal

	la			$a0, nl
	li			$v0, 4
	syscall
	
exit:
	li	$v0,	10		# Exit
	syscall


# struct Node {
#     int val; // 4 Bytes
#     Node *left; // 4 bytes
#     Node *right; // 4 bytes
# } = 12 bytes


# FUNCTION tree_insert
# ARGS:
# a0: Root Node
# a1: Value to be inserted into the Tree
# Returns:
# $v0: address to the root element
tree_insert:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)

	bne		    $a0,    $zero,  non_trvial_case	# if $a0 != $zero then non_trvial_case
	
	# Trivial Case:     root == NULL
	# Allocate memory for element
	li          $a0,    12
	li          $v0,    9
	syscall

	sw          $a1,    0($v0) # v0.val = a1
	sw          $zero,  4($v0) # v0.left = NULL
	sw          $zero,  8($v0) # v0.rigt = NULL

	j tree_insert_ret

	non_trvial_case:

	move    $s0,    $a0     # Temporarily store the value of the root node
	
	lw      $t1, 0($a0)     # load $a0.val into $t1 
	bgt		$a1, $t1, right	# if $a1 > $t1 then insert into right subtree
							# i.e. if $a1 > $a0.val, insert into right subtree

	left:
	lw      $a0, 4($s0) 	#### Key Takeaway: You need to load the address of $a0->left from memory. 
	jal     tree_insert
	sw      $v0, 4($s0)		#### Store it in a similar way!
	j       non_trivial_termination

	right:
	lw      $a0, 8($s0)
	jal     tree_insert
	sw      $v0, 8($s0)
	j		non_trivial_termination				# jump to non_trivial_termination
	
	
	non_trivial_termination:
	move 	$v0, $s0		# $v0 = $s0

	tree_insert_ret:
	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra



# FUNCTION inorder_traversal
# ARGS:
# a0: Root Node
inorder_traversal:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)
	

	# Inorder Traversal
	move        $s0,    $a0
	beq         $s0,    $zero,  ret_inorder_traversal # Return if root == NULL

	# Traverse Left
	lw          $a0,    4($s0)
	jal inorder_traversal

	# Print Current value
	lw			$a0,	0($s0)
	li			$v0,	1
	syscall

	la			$a0, space
	li			$v0, 4
	syscall

	# Traverse Right
	lw          $a0,    8($s0)
	jal inorder_traversal


	ret_inorder_traversal:

	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra


# FUNCTION preorder_traversal
# ARGS:
# a0: Root Node
preorder_traversal:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)
	

	# Inorder Traversal
	move        $s0,    $a0
	beq         $s0,    $zero,  ret_preorder_traversal # Return if root == NULL

	# Print Current value
	lw			$a0,	0($s0)
	li			$v0,	1
	syscall

	la			$a0, space
	li			$v0, 4
	syscall


	# Traverse Left
	lw          $a0,    4($s0)
	jal preorder_traversal


	# Traverse Right
	lw          $a0,    8($s0)
	jal preorder_traversal


	ret_preorder_traversal:

	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra

# FUNCTION postorder_traversal
# ARGS:
# a0: Root Node
postorder_traversal:
	addi		$sp,	$sp,	-20
	sw			$s0,	16($sp)
	sw			$s1,	12($sp)
	sw			$s2,	8($sp)
	sw			$s3,	4($sp)
	sw			$ra,	0($sp)
	

	# Inorder Traversal
	move        $s0,    $a0
	beq         $s0,    $zero,  ret_postorder_traversal # Return if root == NULL

	# Traverse Left
	lw          $a0,    4($s0)
	jal postorder_traversal


	# Traverse Right
	lw          $a0,    8($s0)
	jal postorder_traversal

	
	# Print Current value
	lw			$a0,	0($s0)
	li			$v0,	1
	syscall

	la			$a0, space
	li			$v0, 4
	syscall


	ret_postorder_traversal:

	lw			$s0,	16($sp)
	lw			$s1,	12($sp)
	lw			$s2,	8($sp)
	lw			$s3,	4($sp)
	lw			$ra,	0($sp)
	addi		$sp,	$sp, 20


	jr			$ra
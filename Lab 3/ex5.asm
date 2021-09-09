.data
x:              .word 65535
y:              .word 32767

nl:             .asciiz "\n"
debug:          .asciiz "Debug...\n"
msgSOps:        .asciiz "Working on Single Precision Floats...\n"
msgDOps:        .asciiz "Working on Double Precision Floats...\n"
msgMul:         .asciiz "x * y = "
msgProdDiff:    .asciiz "Error = "

.text
.globl main

printString:
    li		    $v0, 4		        # $v0 = a
    syscall
    jr $ra

printNewLine:
    # Print a new line
    la		    $a0, nl		        # $a0 = nl
    li		    $v0, 4		        # $v0 = a
    syscall
    jr $ra

####### Variable Descriptors #########

# Reserved: $a0, $v0, $f12 
# $t2: x
# $t4: y
# $t6: x * y
# $t8: int(x.f * y.f) -> int (x.d * y.d)

# $f2: x.f -> x.d
# $f4: y.f -> y.d
# $f6: x.f * y.f
# $f8: x.d * y.d

####### Variable Descriptors #########


main:
    # Load Integer
    lw		    $t2,    x
    lw          $t4,    y

    # Multiply and print
    la          $a0,    msgMul
    jal         printString

    mul         $t6,    $t2,    $t4
    move 	    $a0,    $t6		# $a0 = $t6
    li          $v0,    1
    syscall

    jal		    printNewLine				# jump to printNewLine and save position to $ra

######## Starting Single Precision Operations ########
    la          $a0,    msgSOps
    jal         printString

    # Convert both integers to single precision float
    mtc1        $t2,    $f2                 # Copy t2 to $f0
    cvt.s.w     $f2,    $f2                 # convert $f0 to float and store in $f2

    mtc1        $t4,    $f4                 # Copy t4 to $f0
    cvt.s.w     $f4,    $f4                 # convert $f0 to float and store in $f4

    # Multiple both floating point numbers and print
    mul.s       $f6,    $f2,    $f4         # $f6 = $f2 * f4

    # Print Message for Multiplication Result
    la          $a0,    msgMul
    jal         printString

    # Print Multiplied Values
    mov.s       $f12,    $f6
    li          $v0,    2
    syscall

    jal		printNewLine				# jump to printNewLine and save position to $ra
    
    # Convert product to integer
    cvt.w.s     $f12,   $f6
    mfc1        $t8,    $f12            # $t8 = int($f6)

    la          $a0,    msgProdDiff
    jal         printString

    sub		    $a0,    $t6,    $t8		# $a0 = $t6 - $t8
    li          $v0,    1
    syscall

    jal		printNewLine				# jump to printNewLine and save position to $ra

######## Finish Single Precision Operations ########


######## Starting Double Precision Operations ########
    la          $a0,    msgDOps
    jal         printString

    # Convert both integers to Double precision float
    mtc1.d      $t2,    $f0 # Copy t2 to $f0
    cvt.d.w     $f2,    $f0 # convert $f0 to float and store in $f2

    mtc1.d      $t4,    $f0
    cvt.d.w     $f4,    $f0

    # Multiple both floating point numbers and print
    mul.d       $f8,    $f2,    $f4

    la          $a0,    msgMul
    jal         printString

    mov.d       $f12,   $f8
    li          $v0,    3
    syscall

    jal		printNewLine				# jump to printNewLine and save position to $ra
    
    # Convert product to integer
    cvt.w.d     $f12,   $f8
    mfc1.d      $t8,    $f12

    la          $a0,    msgProdDiff
    jal         printString

    sub		    $a0,    $t6,    $t8		# $a0 = $t6 - $t8
    li          $v0,    1
    syscall

    jal		printNewLine				# jump to printNewLine and save position to $ra

######## Finish Double Precision Operations ########

    li		    $v0, 10		        # Exit
    syscall

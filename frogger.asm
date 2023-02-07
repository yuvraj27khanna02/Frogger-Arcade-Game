#####################################################################
#
# CSC258H5S Winter 2022 Assembly Final Project
# University of Toronto, St. George
#
# Student: Yuvraj Khanna, 1006734161
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# - Milestone 4
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#

.data
	displayAddress: .word 0x10008000
	#game_image:	.space 4096
	#frog_row:	.word 7
	#frog_column:	.word 4
	#row_width:	.word 512
	#log_row1:	.space 512
	#log_row2:	.space 512
	#car_row1:	.space 512
	#car_row2:	.space 512
	frog_xy:	.word 3640
	lives:		.word 1
	# log_1:	.word 528
	log_1_1:	.word 528
	log_1_2:	.word 532
	log_1_3:	.word 536
	log_1_4:	.word 540
	log_1_5:	.word 544
	log_1_6:	.word 548
	log_1_7:	.word 552
	log_1_8:	.word 556
	#log_2:		.word 592
	log_2_1:	.word 592
	log_2_2:	.word 596
	log_2_3:	.word 600
	log_2_4:	.word 604
	log_2_5:	.word 608
	log_2_6:	.word 612
	log_2_7:	.word 616
	log_2_8:	.word 620
	#log_3:		.word 1056
	log_3_1:	.word 1056
	log_3_2:	.word 1060
	log_3_3:	.word 1064
	log_3_4:	.word 1068
	log_3_5:	.word 1072
	log_3_6:	.word 1076
	log_3_7:	.word 1080
	log_3_8:	.word 1084
	#log_4:		.word 1120
	log_4_1:	.word 1120
	log_4_2:	.word 1124
	log_4_3:	.word 1128
	log_4_4:	.word 1132
	log_4_5:	.word 1136
	log_4_6:	.word 1140
	log_4_7:	.word 1144
	log_4_8:	.word 1148
	#log_5:		.word 1536
	log_5_1:	.word 1536
	log_5_2:	.word 1540
	log_5_3:	.word 1544
	log_5_4:	.word 1548
	log_5_5:	.word 1552
	log_5_6:	.word 1556
	log_5_7:	.word 1560
	log_5_8:	.word 1564
	#log_6:		.word 1600
	log_6_1:	.word 1600
	log_6_2:	.word 1604
	log_6_3:	.word 1608
	log_6_4:	.word 1612
	log_6_5:	.word 1616
	log_6_6:	.word 1620
	log_6_7:	.word 1624
	log_6_8:	.word 1628
	#car_1:		.word 2576
	car_1_1:	.word 2576
	car_1_2:	.word 2580
	car_1_3:	.word 2584
	car_1_4:	.word 2588
	#car_2:		.word 2640
	car_2_1:	.word 2640
	car_2_2:	.word 2644
	car_2_3:	.word 2648
	car_2_4:	.word 2652
	#car_3:		.word 3100
	car_3_1:	.word 3100
	car_3_2:	.word 3104
	car_3_3:	.word 3108
	car_3_4:	.word 3112
	#car_4:		.word 3164
	car_4_1:	.word 3164
	car_4_2:	.word 3168
	car_4_3:	.word 3172
	car_4_4:	.word 3176
	game_over:	.asciiz "Game Over.  Do you want to play again?"
	frog_color:	.word 0x008958
	
.text
	lw $t0, displayAddress # $t0 stores the base address for display

############

main:
	#lw $t0, displayAddress
	jal Background
	jal MakeLogs
	jal MakeCars
	jal MoveFrog
	jal CollisionDectection
	jal MakeFrog
	li $v0, 32
	li $a0, 1000
	syscall
	j main			#this makes the program run in a loop

Background:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)

	lw $t0, displayAddress	# load Bitap Display Address
	
	addi $t1, $zero, 0
	jal background1
	jal background2
	jal background3
	jal background4
	jal background5
	addi $t9, $zero, 0
	jal background6		# make lives
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)

	jr $ra
	
background1:			# safe area background
	beq $t1, 512, background1_end
	li $t2, 0x00ff00	# green color
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	j background1

background1_end:
	jr $ra

background2:			# water background
	beq $t1, 2048, background2_end
	li $t2, 0x0000ff	# blue color
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	j background2

background2_end:
	jr $ra

background3:			# middle safe area
	beq $t1, 2560, background3_end
	li $t2, 0x00ff00	# green color
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	j background3

background3_end:
	jr $ra

background4:			#road background
	beq $t1, 3584, background4_end
	li $t2, 0x808080	# grey color
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	j background4
	
background4_end:
	jr $ra

background5:
	beq $t1, 4096, background5_end
	li $t2, 0x00ff00	# green color
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	j background5

background5_end:
	jr $ra

background6:
	lw $t8, displayAddress
	lw $t7, lives
	beq $t9, $t7, background6_end
	li $t2, 0xff0000
	sw $t2, 8($t8)
	addi $t8, $t8, 8
	addi $t9, $t9, 1

background6_end:
	jr $ra

MakeFrog:

	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t0, displayAddress	# load Bitap Display Address
	
	lw $t8, frog_xy
	
	lw $t2, frog_color	# green color
	add $t0, $t0, $t8
	sw $t2, 0($t0)
	sw $t2, 8($t0)
	sw $t2, 128($t0)
	sw $t2, 132($t0)
	sw $t2, 136($t0)
	sw $t2, 260($t0)
	sw $t2, 384($t0)
	sw $t2, 388($t0)
	sw $t2, 392($t0)
	
	li $t2, 0x000000
	sw $t2, 0($t0)
	sw $t2, 8($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
		
	jr $ra
	
MoveFrog:
	
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t8, 0xffff0000
	beq $t8, 1, Keyboard_input
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

Keyboard_input:
	
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $v0, 31
	li $a0, 127
	li $a1, 100
	li $a2, 127
	li $a3, 127
	syscall
	
	lw $t2, 0xffff0004
	
	beq $t2, 0x61, respond_to_A
	beq $t2, 0x64, respond_to_D
	beq $t2, 0x77, respond_to_W
	beq $t2, 0x73, respond_to_S
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

respond_to_A:
	
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t3, frog_xy
	addi $t3, $t3, -8
	
	blt $t3, 0, main
	bgt $t3, 3712, main
	beq $t3, 120, main
	beq $t3, 124, main
	beq $t3, 248, main
	beq $t3, 252, main
	beq $t3, 376, main
	beq $t3, 380, main
	beq $t3, 504, main
	beq $t3, 508, main
	beq $t3, 632, main
	beq $t3, 636, main
	beq $t3, 760, main
	beq $t3, 764, main
	beq $t3, 888, main
	beq $t3, 892, main
	beq $t3, 1016, main
	beq $t3, 1020, main
	beq $t3, 1144, main
	beq $t3, 1148, main
	beq $t3, 1272, main
	beq $t3, 1276, main
	beq $t3, 1400, main
	beq $t3, 1404, main
	beq $t3, 1532, main
	beq $t3, 1536, main
	beq $t3, 1656, main
	beq $t3, 1660, main
	beq $t3, 1784, main
	beq $t3, 1788, main
	beq $t3, 1912, main
	beq $t3, 1916, main
	beq $t3, 2040, main
	beq $t3, 2044, main
	beq $t3, 2168, main
	beq $t3, 2172, main
	beq $t3, 2296, main
	beq $t3, 2300, main
	beq $t3, 2424, main
	beq $t3, 2428, main
	beq $t3, 2552, main
	beq $t3, 2556, main
	beq $t3, 2680, main
	beq $t3, 2684, main
	beq $t3, 2808, main
	beq $t3, 2812, main
	beq $t3, 2936, main
	beq $t3, 2940, main
	beq $t3, 3064, main
	beq $t3, 3068, main
	beq $t3, 3192, main
	beq $t3, 3196, main
	beq $t3, 3320, main
	beq $t3, 3324, main
	beq $t3, 3448, main
	beq $t3, 3452, main
	beq $t3, 3576, main
	beq $t3, 3580, main
	beq $t3, 3704, main
	beq $t3, 3708, main
	beq $t3, 3832, main
	beq $t3, 3836, main
	beq $t3, 3960, main
	beq $t3, 3964, main
	beq $t3, 4088, main
	beq $t3, 4092, main
	beq $t3, 4096, main
	
	sw $t3, frog_xy
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

respond_to_D:
	
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t3, frog_xy
	addi $t3, $t3, 8
	
	blt $t3, 0, main
	bgt $t3, 3712, main
	beq $t3, 120, main
	beq $t3, 124, main
	beq $t3, 248, main
	beq $t3, 252, main
	beq $t3, 376, main
	beq $t3, 380, main
	beq $t3, 504, main
	beq $t3, 508, main
	beq $t3, 632, main
	beq $t3, 636, main
	beq $t3, 760, main
	beq $t3, 764, main
	beq $t3, 888, main
	beq $t3, 892, main
	beq $t3, 1016, main
	beq $t3, 1020, main
	beq $t3, 1144, main
	beq $t3, 1148, main
	beq $t3, 1272, main
	beq $t3, 1276, main
	beq $t3, 1400, main
	beq $t3, 1404, main
	beq $t3, 1532, main
	beq $t3, 1536, main
	beq $t3, 1656, main
	beq $t3, 1660, main
	beq $t3, 1784, main
	beq $t3, 1788, main
	beq $t3, 1912, main
	beq $t3, 1916, main
	beq $t3, 2040, main
	beq $t3, 2044, main
	beq $t3, 2168, main
	beq $t3, 2172, main
	beq $t3, 2296, main
	beq $t3, 2300, main
	beq $t3, 2424, main
	beq $t3, 2428, main
	beq $t3, 2552, main
	beq $t3, 2556, main
	beq $t3, 2680, main
	beq $t3, 2684, main
	beq $t3, 2808, main
	beq $t3, 2812, main
	beq $t3, 2936, main
	beq $t3, 2940, main
	beq $t3, 3064, main
	beq $t3, 3068, main
	beq $t3, 3192, main
	beq $t3, 3196, main
	beq $t3, 3320, main
	beq $t3, 3324, main
	beq $t3, 3448, main
	beq $t3, 3452, main
	beq $t3, 3576, main
	beq $t3, 3580, main
	beq $t3, 3704, main
	beq $t3, 3708, main
	beq $t3, 3832, main
	beq $t3, 3836, main
	beq $t3, 3960, main
	beq $t3, 3964, main
	beq $t3, 4088, main
	beq $t3, 4092, main
	beq $t3, 4096, main
	
	sw $t3, frog_xy
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

respond_to_W:
	
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t3, frog_xy
	addi $t3, $t3, -256
	
	blt $t3, 0, main
	bgt $t3, 3712, main
	beq $t3, 120, main
	beq $t3, 124, main
	beq $t3, 248, main
	beq $t3, 252, main
	beq $t3, 376, main
	beq $t3, 380, main
	beq $t3, 504, main
	beq $t3, 508, main
	beq $t3, 632, main
	beq $t3, 636, main
	beq $t3, 760, main
	beq $t3, 764, main
	beq $t3, 888, main
	beq $t3, 892, main
	beq $t3, 1016, main
	beq $t3, 1020, main
	beq $t3, 1144, main
	beq $t3, 1148, main
	beq $t3, 1272, main
	beq $t3, 1276, main
	beq $t3, 1400, main
	beq $t3, 1404, main
	beq $t3, 1532, main
	beq $t3, 1536, main
	beq $t3, 1656, main
	beq $t3, 1660, main
	beq $t3, 1784, main
	beq $t3, 1788, main
	beq $t3, 1912, main
	beq $t3, 1916, main
	beq $t3, 2040, main
	beq $t3, 2044, main
	beq $t3, 2168, main
	beq $t3, 2172, main
	beq $t3, 2296, main
	beq $t3, 2300, main
	beq $t3, 2424, main
	beq $t3, 2428, main
	beq $t3, 2552, main
	beq $t3, 2556, main
	beq $t3, 2680, main
	beq $t3, 2684, main
	beq $t3, 2808, main
	beq $t3, 2812, main
	beq $t3, 2936, main
	beq $t3, 2940, main
	beq $t3, 3064, main
	beq $t3, 3068, main
	beq $t3, 3192, main
	beq $t3, 3196, main
	beq $t3, 3320, main
	beq $t3, 3324, main
	beq $t3, 3448, main
	beq $t3, 3452, main
	beq $t3, 3576, main
	beq $t3, 3580, main
	beq $t3, 3704, main
	beq $t3, 3708, main
	beq $t3, 3832, main
	beq $t3, 3836, main
	beq $t3, 3960, main
	beq $t3, 3964, main
	beq $t3, 4088, main
	beq $t3, 4092, main
	beq $t3, 4096, main
	
	sw $t3, frog_xy
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

respond_to_S:
	
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t3, frog_xy
	addi $t3, $t3, 256
	
	blt $t3, 0, main
	bgt $t3, 3712, main
	beq $t3, 120, main
	beq $t3, 124, main
	beq $t3, 248, main
	beq $t3, 252, main
	beq $t3, 376, main
	beq $t3, 380, main
	beq $t3, 504, main
	beq $t3, 508, main
	beq $t3, 632, main
	beq $t3, 636, main
	beq $t3, 760, main
	beq $t3, 764, main
	beq $t3, 888, main
	beq $t3, 892, main
	beq $t3, 1016, main
	beq $t3, 1020, main
	beq $t3, 1144, main
	beq $t3, 1148, main
	beq $t3, 1272, main
	beq $t3, 1276, main
	beq $t3, 1400, main
	beq $t3, 1404, main
	beq $t3, 1532, main
	beq $t3, 1536, main
	beq $t3, 1656, main
	beq $t3, 1660, main
	beq $t3, 1784, main
	beq $t3, 1788, main
	beq $t3, 1912, main
	beq $t3, 1916, main
	beq $t3, 2040, main
	beq $t3, 2044, main
	beq $t3, 2168, main
	beq $t3, 2172, main
	beq $t3, 2296, main
	beq $t3, 2300, main
	beq $t3, 2424, main
	beq $t3, 2428, main
	beq $t3, 2552, main
	beq $t3, 2556, main
	beq $t3, 2680, main
	beq $t3, 2684, main
	beq $t3, 2808, main
	beq $t3, 2812, main
	beq $t3, 2936, main
	beq $t3, 2940, main
	beq $t3, 3064, main
	beq $t3, 3068, main
	beq $t3, 3192, main
	beq $t3, 3196, main
	beq $t3, 3320, main
	beq $t3, 3324, main
	beq $t3, 3448, main
	beq $t3, 3452, main
	beq $t3, 3576, main
	beq $t3, 3580, main
	beq $t3, 3704, main
	beq $t3, 3708, main
	beq $t3, 3832, main
	beq $t3, 3836, main
	beq $t3, 3960, main
	beq $t3, 3964, main
	beq $t3, 4088, main
	beq $t3, 4092, main
	beq $t3, 4096, main
	
	sw $t3, frog_xy
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
	
MakeLogs:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)

	lw $t0, displayAddress	# load Bitap Display Address
	
	jal log1_2
	jal log1_3
	jal log1_4
	jal log1_5
	jal log1_6
	jal log1_7
	
	jal log2_2
	jal log2_3
	jal log2_4
	jal log2_5
	jal log2_6
	jal log2_7
	
	jal log3_2
	jal log3_3
	jal log3_4
	jal log3_5
	jal log3_6
	jal log3_7
	
	jal log4_2
	jal log4_3
	jal log4_4
	jal log4_5
	jal log4_6
	jal log4_7
	
	jal log5_2
	jal log5_3
	jal log5_4
	jal log5_5
	jal log5_6
	jal log5_7

	jal log6_2
	jal log6_3
	jal log6_4
	jal log6_5
	jal log6_6
	jal log6_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)

	jr $ra

log1_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_1_2
	addi $t5, $t5, 4
	beq $t5, 636, con_log_1_2
	sw $t5, log_1_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log1_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_1_3
	addi $t5, $t5, 4
	beq $t5, 640, con_log_1_3
	sw $t5, log_1_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log1_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_1_4
	addi $t5, $t5, 4
	beq $t5, 644, con_log_1_4
	sw $t5, log_1_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log1_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_1_5
	addi $t5, $t5, 4
	beq $t5, 648, con_log_1_5
	sw $t5, log_1_5
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log1_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_1_6
	addi $t5, $t5, 4
	beq $t5, 652, con_log_1_6
	sw $t5, log_1_6
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log1_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_1_7
	addi $t5, $t5, 4
	beq $t5, 656, con_log_1_7
	sw $t5, log_1_7
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log2_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_2_2
	addi $t5, $t5, 4
	beq $t5, 636, con_log_2_2
	sw $t5, log_2_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log2_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_2_3
	addi $t5, $t5, 4
	beq $t5, 640, con_log_2_3
	sw $t5, log_2_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log2_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_2_4
	addi $t5, $t5, 4
	beq $t5, 644, con_log_2_4
	sw $t5, log_2_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log2_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_2_5
	addi $t5, $t5, 4
	beq $t5, 648, con_log_2_5
	sw $t5, log_2_5
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log2_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_2_6
	addi $t5, $t5, 4
	beq $t5, 652, con_log_2_6
	sw $t5, log_2_6
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log2_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_2_7
	addi $t5, $t5, 4
	beq $t5, 656, con_log_2_7
	sw $t5, log_2_7
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log3_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_3_2
	addi $t5, $t5, -4
	beq $t5, 1020, con_log_3_2
	sw $t5, log_3_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)

	jr $ra

log3_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_3_3
	addi $t5, $t5, -4
	beq $t5, 1024, con_log_3_3
	sw $t5, log_3_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log3_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_3_4
	addi $t5, $t5, -4
	beq $t5, 1028, con_log_3_4
	sw $t5, log_3_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log3_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_3_5
	addi $t5, $t5, -4
	beq $t5, 1032, con_log_3_5
	sw $t5, log_3_5
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log3_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_3_6
	addi $t5, $t5, -4
	beq $t5, 1036, con_log_3_6
	sw $t5, log_3_6
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log3_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_3_7
	addi $t5, $t5, -4
	beq $t5, 1040, con_log_3_7
	sw $t5, log_3_7
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log4_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_4_2
	addi $t5, $t5, -4
	beq $t5, 1020, con_log_4_2
	sw $t5, log_4_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log4_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_4_3
	addi $t5, $t5, -4
	beq $t5, 1024, con_log_4_3
	sw $t5, log_4_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
log4_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_4_4
	addi $t5, $t5, -4
	beq $t5, 1028, con_log_4_4
	sw $t5, log_4_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log4_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_4_5
	addi $t5, $t5, -4
	beq $t5, 1032, con_log_4_5
	sw $t5, log_4_5
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log4_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_4_6
	addi $t5, $t5, -4
	beq $t5, 1036, con_log_4_6
	sw $t5, log_4_6
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log4_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x954b00	# different brown color
	
	lw $t5, log_4_7
	addi $t5, $t5, -4
	beq $t5, 1040, con_log_4_7
	sw $t5, log_4_7
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

log5_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_1
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_1
	sw $t5, log_5_1
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)

	
	jr $ra

log5_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_2
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_2
	sw $t5, log_5_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)

	jr $ra

log5_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_3
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_3
	sw $t5, log_5_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)

	
	jr $ra

log5_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_4
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_4
	sw $t5, log_5_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)

	jr $ra

log5_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_5
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_5
	sw $t5, log_5_5
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

log5_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_6
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_6
	sw $t5, log_5_6
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)

	jr $ra

log5_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_5_7
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_5_7
	sw $t5, log_5_7
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

log6_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_1
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_1
	sw $t5, log_6_1
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

log6_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_2
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_2
	sw $t5, log_6_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0, $t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)

	jr $ra

log6_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_3
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_3
	sw $t5, log_6_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0, $t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

log6_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_4
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_4
	sw $t5, log_6_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0, $t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)

	jr $ra

log6_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_5
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_5
	sw $t5, log_6_5
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0, $t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

log6_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_6
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_6
	sw $t5, log_6_6
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0, $t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

log6_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0x964b00	# brown color
	
	lw $t5, log_6_7
	addi $t5, $t5, 4
	beq $t5, 1664, con_log_6_7
	sw $t5, log_6_7
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0, $t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4		# popping $ra from stack (part2)
	
	jr $ra

con_log_1_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_1_2
	addi $t9, $t9, -128
	sw $t9, log_1_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
con_log_1_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_1_3
	addi $t9, $t9, -132
	sw $t9, log_1_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_1_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_1_4
	addi $t9, $t9, -136
	sw $t9, log_1_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_1_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_1_5
	addi $t9, $t9, -140
	sw $t9, log_1_5
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_1_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_1_6
	addi $t9, $t9, -144
	sw $t9, log_1_6
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_1_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_1_7
	addi $t9, $t9, -148
	sw $t9, log_1_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra	

con_log_2_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_2
	addi $t9, $t9, -120
	sw $t9, log_2_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
con_log_2_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_3
	addi $t9, $t9, -124
	sw $t9, log_2_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_2_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_4
	addi $t9, $t9, -128
	sw $t9, log_2_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_2_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_5
	addi $t9, $t9, -132
	sw $t9, log_2_5
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_2_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_6
	addi $t9, $t9, -136
	sw $t9, log_2_6
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_2_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_7
	addi $t9, $t9, -140
	sw $t9, log_2_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_3_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_3_2
	addi $t9, $t9, 120
	sw $t9, log_3_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_3_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_3_3
	addi $t9, $t9, 124
	sw $t9, log_3_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_3_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_3_4
	addi $t9, $t9, 128
	sw $t9, log_3_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_3_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_3_5
	addi $t9, $t9, 132
	sw $t9, log_3_5
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_3_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_3_6
	addi $t9, $t9, 136
	sw $t9, log_3_6
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_3_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_3_7
	addi $t9, $t9, 140
	sw $t9, log_3_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_4_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_4_2
	addi $t9, $t9, 120
	sw $t9, log_4_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
con_log_4_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_4_3
	addi $t9, $t9, 124
	sw $t9, log_4_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_4_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_4_4
	addi $t9, $t9, 128
	sw $t9, log_4_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_4_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_4_5
	addi $t9, $t9, 132
	sw $t9, log_4_5
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_4_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_4_6
	addi $t9, $t9, 136
	sw $t9, log_4_6
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_4_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_4_7
	addi $t9, $t9, 140
	sw $t9, log_4_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_5_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_1
	addi $t9, $zero, 1544
	sw $t9, log_5_1
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_5_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_2
	addi $t9, $zero, 1540
	sw $t9, log_5_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
con_log_5_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_3
	addi $t9, $zero, 1536
	sw $t9, log_5_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_5_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_4
	addi $t9, $zero, 1532
	sw $t9, log_5_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_5_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_5
	addi $t9, $zero, 1528
	sw $t9, log_5_5
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_5_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_6
	addi $t9, $zero, 1524
	sw $t9, log_5_6
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_5_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_5_7
	addi $t9, $zero, 1520
	sw $t9, log_5_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_6_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_1
	addi $t9, $zero, 1544
	sw $t9, log_6_1
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_6_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_2
	addi $t9, $zero, 1540
	sw $t9, log_6_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
con_log_6_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_3
	addi $t9, $zero, 1536
	sw $t9, log_6_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_6_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_4
	addi $t9, $zero, 1532
	sw $t9, log_6_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_6_5:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_5
	addi $t9, $zero, 1528
	sw $t9, log_6_5
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_6_6:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_6
	addi $t9, $zero, 1524
	sw $t9, log_6_6
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_log_6_7:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_6_7
	addi $t9, $zero, 1520
	sw $t9, log_6_7
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

MakeCars:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)

	lw $t0, displayAddress	# load Bitap Display Address

	jal car1_1
	jal car1_2
	jal car1_3
	jal car1_4
	
	jal car2_1
	jal car2_2
	jal car2_3
	jal car2_4
	
	jal car3_1
	jal car3_2
	jal car3_3
	jal car3_4
	
	jal car4_1
	jal car4_2
	jal car4_3
	jal car4_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)

	jr $ra

car1_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_1_1
	addi $t5, $t5, 4
	beq $t5, 2684, con_car_1_1
	sw $t5, car_1_1
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_1_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_1_1
	addi $t9, $t9, -120
	sw $t9, car_1_1
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car1_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_1_2
	addi $t5, $t5, 4
	beq $t5, 2688, con_car_1_2
	sw $t5, car_1_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_1_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_1_2
	addi $t9, $t9, -124
	sw $t9, car_1_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car1_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_1_3
	addi $t5, $t5, 4
	beq $t5, 2692, con_car_1_3
	sw $t5, car_1_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_1_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_1_3
	addi $t9, $t9, -128
	sw $t9, car_1_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car1_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_1_4
	addi $t5, $t5, 4
	beq $t5, 2696, con_car_1_4
	sw $t5, car_1_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_1_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_1_4
	addi $t9, $t9, -132
	sw $t9, car_1_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car2_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_2_1
	addi $t5, $t5, 4
	beq $t5, 2684, con_car_2_1
	sw $t5, car_2_1
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_2_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, log_2_1
	addi $t9, $t9, -120
	sw $t9, log_2_1
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car2_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_2_2
	addi $t5, $t5, 4
	beq $t5, 2688, con_car_2_2
	sw $t5, car_2_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_2_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_2_2
	addi $t9, $t9, -124
	sw $t9, car_2_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car2_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_2_3
	addi $t5, $t5, 4
	beq $t5, 2692, con_car_2_3
	sw $t5, car_2_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_2_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_2_3
	addi $t9, $t9, -128
	sw $t9, car_2_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car2_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_2_4
	addi $t5, $t5, 4
	beq $t5, 2696, con_car_2_4
	sw $t5, car_2_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_2_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_2_4
	addi $t9, $t9, -132
	sw $t9, car_2_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car3_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_3_1
	addi $t5, $t5, -4
	beq $t5, 3068, con_car_3_1
	sw $t5, car_3_1
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_3_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_3_1
	addi $t9, $t9, 120
	sw $t9, car_3_1
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car3_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_3_2
	addi $t5, $t5, -4
	beq $t5, 3072, con_car_3_2
	sw $t5, car_3_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_3_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_3_2
	addi $t9, $t9, 124
	sw $t9, car_3_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car3_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_3_3
	addi $t5, $t5, -4
	beq $t5, 3076, con_car_3_3
	sw $t5, car_3_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_3_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_3_3
	addi $t9, $t9, 128
	sw $t9, car_3_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car3_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_3_4
	addi $t5, $t5, -4
	beq $t5, 3080, con_car_3_4
	sw $t5, car_3_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_3_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_3_4
	addi $t9, $t9, 132
	sw $t9, car_3_4

	
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car4_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_4_1
	addi $t5, $t5, -4
	beq $t5, 3068, con_car_4_1
	sw $t5, car_4_1
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_4_1:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_4_1
	addi $t9, $t9, 120
	sw $t9, car_4_1
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car4_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_4_2
	addi $t5, $t5, -4
	beq $t5, 3072, con_car_4_2
	sw $t5, car_4_2
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_4_2:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_4_2
	addi $t9, $t9, 124
	sw $t9, car_4_2
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car4_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_4_3
	addi $t5, $t5, -4
	beq $t5, 3076, con_car_4_3
	sw $t5, car_4_3
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_4_3:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_4_3
	addi $t9, $t9, 128
	sw $t9, car_4_3
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

car4_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	li $t2, 0xff8c00	# orange color
	
	lw $t5, car_4_4
	addi $t5, $t5, -4
	beq $t5, 3080, con_car_4_4
	sw $t5, car_4_4
	lw $t0, displayAddress	# load Bitmap Display Address
	add $t0 ,$t0, $t5
	sw $t2, 0($t0)
	sw $t2, 128($t0)
	sw $t2, 256($t0)
	sw $t2, 384($t0)
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

con_car_4_4:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t9, car_4_4
	addi $t9, $t9, 132
	sw $t9, car_4_4
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra

CollisionDectection:
	addi $sp, $sp, -4	# pushing $ra to stack (part1)
	sw $ra, 0($sp)		# pushing $ra to stack (part2)
	
	lw $t0, displayAddress
	lw $t5, frog_xy
	add $t0, $t0, $t5
	
	li $t3, 0xff8c00
	lw $t2, 0($t0)
	beq $t2, $t3, Live_lost
	
	lw $t2, 8($t0)
	beq $t2, $t3, Live_lost
	
	li $t3, 0x0000ff
	lw $t2, 0($t0)
	beq $t2, $t3, Live_lost
	
	lw $t2, 8($t0)
	beq $t2, $t3, Live_lost
	
	li $t3, 0x964b00
	lw $t2, 0($t0)
	beq $t2, $t3, respond_to_D
	
	lw $t2, 8($t0)
	beq $t2, $t3, respond_to_D
	
	li $t3, 0x954b00
	lw $t2, 0($t0)
	beq $t3, $t2, respond_to_A
	
	lw $t2, 8($t0)
	beq $t2, $t3, respond_to_A
	
	lw $ra, 0($sp)		# popping $ra from stack (part1)
	addi $sp, $sp, 4	# popping $ra from stack (part2)
	
	jr $ra
	
Live_lost:
	lw $t5, lives
	addi $t5, $t5, -1
	
	li $v0, 32
	li $a0, 1000
	syscall
	
	li $t2, 0xffffff
	sw $t2, frog_color
	jal MakeFrog
	
	li $v0, 32
	li $a0, 1000
	syscall 
	
	li $t2, 0xffffff
	sw $t2, frog_color
	jal MakeFrog
	
	li $v0, 32
	li $a0, 1000
	syscall 
	
	beq $t5, 0, Exit
	
	beq $t5, 1, Make_lives_1
	beq $t5, 2, Make_lives_2
	beq $t5, 3, Make_lives_3
	
	sw $t5, lives
	
	j main

Make_lives_1:
	
	li $t2, 0xff0000
	lw $t0, displayAddress
	
	sw $t2, 8($t0)
	
	j main

Make_lives_2:
	
	li $t2, 0xff0000
	lw $t0, displayAddress
	
	sw $t2, 8($t0)
	sw $t2, 16($t0)
	
	j main

Make_lives_3:
	
	li $t2, 0xff0000
	lw $t0, displayAddress
	
	sw $t2, 8($t0)
	sw $t2, 16($t0)
	sw $t2, 24($t0)
	
	j main

Exit:
	li $v0, 31
	li $a0, 127
	li $a1, 1500
	li $a2, 57
	li $a3, 127
	syscall
	
	li $v0, 55
	la $a0, game_over
	li $a1, 0
	li $v0, 50
	la $a0, game_over
	syscall
	
	lw $t8, lives
	addi $t8, $zero, 1
	sw $t8, lives
	
	lw $t8, frog_xy
	addi $t8, $zero, 0
	addi $t8, $zero, 3640
	sw $t8, frog_xy
	
	li $t2, 0x008958
	sw $t2, frog_color
	
	beq $a0, 0, main
	

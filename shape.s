############################################################################################
#Program Name: Shape 
#Programmer: Jacob Richardson
#Date: 2/5/18
############################################################################################
# Functional Description:
# Calculates the area of a circle, square, and rectangle based on 2 cordinates. 
############################################################################################


	.data	# Data declaration section
	Prompt1: .asciiz"Please enter x1 "
	Prompt2: .asciiz"Please enter y1 "
	Prompt3: .asciiz"Please enter x2 "
	Prompt4: .asciiz"Please enter y2 "
	Prompt5: .asciiz"The answer for circle is "
	Prompt6: .asciiz"\nThe answer for square is "
	Prompt7: .asciiz"\nThe answer for rectangle is "
	Prompt8: .asciiz"\nTo quit enter 0 "
	Prompt9: .asciiz"\nTo calculate the area of a circle enter 1 "
	Prompt10: .asciiz"\nTo calculate the area of a square enter 2 "
	Prompt11: .asciiz"\nTo calculate the area of a rectangle enter 3 \n"
	
	.text
main:				# Start of code section
Greeting:
	li $v0, 4 			#Telling the user how to use the program
	la $a0, Prompt8
	syscall
	li $v0, 4
	la $a0, Prompt9
	syscall
	li $v0, 4
	la $a0, Prompt10
	syscall
	li $v0, 4
	la $a0, Prompt11
	syscall
	li $v0, 5
	syscall
	move $s5, $v0 		#storing the users choice in $s5
	li $t0, 0
	beq $t0, $s5, Quit
InputValues:
	li $v0, 4
	la $a0, Prompt1 		#input values
	syscall
	li $v0, 5
	syscall 
	move $t0, $v0 		#t0 = x1
	li $v0, 4
	la $a0, Prompt2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 		#t1 = y1
	li $v0, 4
	la $a0, Prompt3
	syscall
	li $v0, 5
	syscall
	move $t2, $v0 		#t2 = x2
	li $v0, 4
	la $a0, Prompt4
	syscall
	li $v0, 5
	syscall
	move $t3, $v0 		#t3 = y2
	li $s6, 1 			#putting 1 into $s6 
	beq $s6, $s5, Circle		#If the input($s5) = 1 go to cirlce
	li $s6, 2			#putting 2 into $s6
	beq $s6, $s5, Square		#If the input($s5) = 2 go to sqaure
	li $s6, 3			#putting 3 into $s6
	beq $s6, $s5, Rectangle	#If the input($s5) = 2 go to rectangle
Circle:
	sub $t4, $t2, $t0
	sub $t5, $t3, $t1
	mult $t4, $t4
	mflo $s0
	mult $t5, $t5
	mflo $s1
	add $s2, $s0, $s1
	li $t9, 314156
	li $t8, 100000
	mult $s2, $t9
	mflo $t7
	div $t7, $t8
	mflo $t8
	li $v0, 4
	la $a0, Prompt5
	syscall
	li $v0, 1
	move $a0, $t8
	syscall
	b Greeting
Square:
	sub $t4, $t2, $t0
	sub $t5, $t3, $t1
	mult $t4, $t4
	mflo $s0
	mult $t5, $t5
	mflo $s1
	add $s2, $s0, $s1
	li $v0, 4
	la $a0, Prompt6
	syscall
	li $v0, 1
	move $a0, $s2
	syscall
	b Greeting
Rectangle:
	sub $t4, $t2, $t0
	sub $t5, $t3, $t1
	mult $t4, $t5
	mflo $s4
	li $v0, 4
	la $a0, Prompt7
	syscall
	li $v0, 1
	move $a0, $s4
	syscall	
	b Greeting
Quit:
	li $v0, 10
	syscall
# END OF PROGRAM
############################################################################################
#Program Name: bitOperations (Lab 4)
#Programmer: Jacob Richardson
#Date: 2/28/18
############################################################################################
# Functional Description:
# Will print out the location of all the 1's in a given bit string, give the union of two sets, give the intersection of two sets, 
# and can determine whether or not a number is in a set.
############################################################################################

	.data	# Data declaration section
	blank: .asciiz " "
	newLine: .asciiz "\n"
	prompt1: .asciiz "\nPlease enter a number "
	prompt2: .asciiz "In the set "
	prompt3: .asciiz "Not in the set "
	prompt4: .asciiz "\nHave a good day "
	prompt5: .asciiz "\nUnion is "
	prompt6: .asciiz "\nIntersection is  "
	.text

main:		# Start of code section
	
	li $s1, 1  			# loop counter in $s1
	li $s2, 32  			# 32 is in $s2 to check if $s1 is > 32
	li $t1, 0xaaaaaaaa		# test set 1
	li $t2, 0x24924924		# test set 2
	li $s3, 0x00000001     	# $s3 has the starting masking bit pattern
	li $t0, 0			# putting 0 into $t0
	move $t4, $t1   		# Load test data 1
	jal locations		# locations runs off $t4
	move $t4, $t2		# Load test data 2
	li $s1, 1			# Rest loop counter
	li $s3, 0x00000001		# Rest masking pattern
	la $a0, newLine		# Prints a new line
	li $v0, 4		
	syscall
	jal locations		# Reruns locations with new data
	li $s3, 0x0000001		# Reset bit pattern
	li $s1, 1  			# Reset loop counter 
	li $t0, 0			# putting 0 into $t0
	jal union			# Union gets the or and moves it into $t4 for locations to run off
	jal locations		# Calls location to run off Union data
	li $s3, 0x0000001		# Reset bit pattern
	li $s1, 1  			# Reset loop counter
	li $t0, 0			# putting 0 into $t0
	jal inter			# Inter gets the and and moves it into $t4 for locations to runn off
	jal locations		# calls location to run off location data
	move $s7, $t1		# membership runs off $s7
	jal membership
	li $s3, 0x0000001		# Reset bit pattern
	move $s7, $t2		# moves test data for set 2 into $s7
	jal membership		# recalls membership with new test data
	jal quit			# Goes to quit
	
	
locations:

loop:
	bgt $s1, $s2, label2 		# Checks to see if loop counter is > 32
	and $s4, $s3, $t4		# Ands $s3 (bit mask) with $t1 (test value 1) and puts the result in $s4
	beq $s4, $t0, notIn		# If the AND does equal zero the number isnt in the set
	move $a0, $s1		# Moves the loop counter into $a0
	la $s6, print		# Loads $s4 with print 
	jalr $t3, $s6		# Jumps to print and return adress in $t3	
notIn:	
	addi $s1, $s1, 1		# Adds one to the loop counter
	sll $s3, $s3, 1		# Need to shift the masking bit pattern
	b loop			# Branches to the top of the loop
label2:
	jr $ra
	
membership:
	li $s3, 0x00000001      	# $s3 has the starting masking bit pattern
	li $t0, 0			# $t0 has 0
	la $a0, prompt1		# Prompting the user to enter a number
	li $v0, 4
	syscall
	li $v0, 5			# Reading in the integer
	syscall
	move $s4, $v0		# $s4 has the number they enter
	addi $s4, $s4, -1		# $s4 is input -1
	sll $s3, $s3, $s4		# shift left logial the bit mask save it into the bit mask and shift by input -1
	and $t8, $s3, $s7		# t8 has the shifted bit mask anded with test data 1
	beq $t8, $t0, notIn2	 
	la $a0, prompt2
	li $v0, 4
	syscall
	jr $ra
notIn2:
	
	la $a0, prompt3		#Not in the set
	li $v0, 4
	syscall
	jr $ra
union:
	li $t1, 0x0aaaaaaa		# test set 1
	li $t2, 0x04924924		# test set 2
	or $s4, $t1, $t2
	move $t4, $s4 		# moves the or to $t4 to run locations off the or
	la $a0, prompt5
	li $v0, 4
	syscall
	jr $ra
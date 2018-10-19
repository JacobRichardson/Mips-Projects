############################################################################################
#Program Name: isSubstring (Assignment 2)
#Programmer: Jacob Richardson
#Date: 3-07-18
############################################################################################
# Functional Description:
# The user inputs two strings, and determines whether or not the second string is a sub-string of the first string
############################################################################################

	.data	# Data declaration section
	userInput1: .space 20
	userInput2: .space 20
	prompt1: .asciiz "Please enter string 1. "
	prompt2: .asciiz "Please enter string 2. "
	prompt3: .asciiz "String 1: "
	prompt4: .asciiz "String 2: "
	prompt5: .asciiz "Position: "
	prompt6: .asciiz "\nNow checking to see if the the characters continue to be eqaul "
	blank: .asciiz " "
	
	.text

main:		# Start of code section
	jal prompts
	li $s2, 1				# $s2 is string1 counter
	li $t5, 10				# $t5 has 10 in it to compare to enter ascii value
	move $t0, $s0			# $t0 is the start address of userInput1
	move $t1, $s1			# $t4 is the start address of userInput2
	jal subString
	jal quit
prompts:
	#prompting the user to input strings
	
	la $a0, prompt1			# loading prompt 1
	li $v0, 4				# syscall to print string
	syscall
	li $v0, 8				# syscall for reading string
	la $a0, userInput1			# loading userInput data
	li $a1, 20				# allocating 20 bytes of space
	syscall	
	move $s0, $a0			# moving the address of string1 into $s0
	la $a0, prompt2
	li $v0, 4
	syscall
	li $v0, 8
	la $a0, userInput2
	li $a1, 20
	syscall
	move $s1, $a0			# moving the address of string2 into $s1
	
	# printing out the inputted strings
	
	la $a0, prompt3
	li $v0, 4
	syscall
	la $a0, userInput1			# printing out $s1 which has userInput1 in it
	li $v0, 4
	syscall
	la $a0, prompt4			# telling the user what string 2 was
	li $v0, 4
	syscall
	la $a0, userInput2
	li $v0, 4
	syscall
	jr $ra
subString:
	lb $t2 0($t0)			# $t2 is used to process userInput1 ($t2)
	lb $t3 0($t1)			# $t3 is used to process userInput2 ($t1)
	beq $t2, $t5 end			# jump to end if they entered the enter key (10)
	addi $t0, 1				# incrementing the address
	beq $t2 $t3, equal			# jump to equal if the two bytes are equal
	add $s2, $s2 1			# adding 1 to the counter
	j subString
equal:
	#getting here means one character from string one is equal to one character of string two
	la $a0, prompt5			# printing "Position:"
	li $v0,4
	syscall
	move $a0, $s2			# moving looping counter into $a0 to print it.
	li $v0, 1
	syscall
	jr $ra
end:	
	la $a0, prompt5
	li $v0, 4
	syscall
	li $a0, -1
	li $v0, 1
	syscall
	jr $ra
quit:	
	li $v0, 10
	syscall
	
	

# END OF PROGRAM
############################################################################################
#Program Name: isPrime (Assignment 1)
#Programmer: Jacob Richardson
#Date: 2-14-18
############################################################################################
# Functional Description:
# Determines whether or not a given number is prime and lists out all the factors of the number
############################################################################################

	.data	# Data declaration section
	Prompt1: .asciiz"Please enter a postive integer "
	Prompt2: .asciiz"That is not a positive interger. Please Try again. \n"
	Prompt3: .asciiz" \n The factors are: "
	Prompt4: .asciiz"\n This number is prime \n " 
	Prompt5: .asciiz"\n This number is not prime \n "
	Prompt6: .asciiz"\n "
	Prompt7: .asciiz"Thank you. Have a nice day "
	.text

main:		# Start of code section
	li $v0, 4
	la $a0, Prompt1
	syscall
	li $v0, 5
	syscall
	move $s0, $v0               # $s0 is the number they give
	li $v0, 0
	beq $s0,$t5, Quit2
	li $t0, 0		            # $t0 = 0
	li $s1, 1 		            # $s1 = 1 --Count1 = count to see how many times we divide
	li $s2, 1	            	# $s2 = 1 --Count2 = how many times we print a factor out
	blt $s0, $t0, Error
	li $v0, 4			
	la $a0, Prompt3
	syscall
	b loop
Error:
	li $v0, 4
	la $a0, Prompt2
	syscall
	b main
	
loop:					        #loop 1 - givenNumber (s0) when it gets a remainder of zero it prints it out
	div $s0, $s1
	mfhi $t1			        # $t1 is the remainder
	bne $t1, $t0, update		# Go to update when the remainder does not equal zero
	li $v0, 4
	la $a0, Prompt6
	syscall
	li $v0, 1					
	move $a0, $s1
	syscall
	addi $s2, $s2, 1	    	# updating the number of times we count a factor	
update:	 
	addi $s1, $s1, 1
	bgt $s1, $s0, done
	b loop
done:
	li $t2, 2
	bgt $s2, $t2, Quit		    #If the number of factors is greater than 2 go to quit
	li $v0, 4	
	la $a0, Prompt4			    #This means the number of factors is less than or equal to 2 so it is prime
	syscall
	li $v0, 10			        #End
	syscall
Quit:
	li $v0, 4		
	la $a0, Prompt5			    #This means the number of factors is greater than 2 so it is not prime
	syscall
	b main
Quit2:
	li $v0, 4
	la $a0, Prompt7
	syscall
	b main
# END OF PROGRAM
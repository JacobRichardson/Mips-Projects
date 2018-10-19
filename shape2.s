############################################################################################
#Program Name: Shape2
#Programmer: Jacob Richardson
#Date: 2-12-18
############################################################################################
# Functional Description:
#Calculating the area of a circle, square, and rectangle using floats and functions using
############################################################################################


	.data	# Data declaration section
	Prompt1: .asciiz"Please enter x1 "
	Prompt2: .asciiz"Please enter x2 "
	Prompt3: .asciiz"Please enter y1 "
	Prompt4: .asciiz"Please enter y2 "
	Prompt5: .asciiz"\nThe answer for circle is "
	Prompt6: .asciiz"\nThe answer for square is "
	Prompt7: .asciiz"\nThe answer for rectangle is "
	PI: .double 3.14159265

	.text

main:		# Start of code section
	li $v0, 4
	la $a0, Prompt1
	syscall
	li $v0, 7
	syscall
	mov.d $f2, $f0		#x1 is in $f2
	li $v0, 4
	la $a0, Prompt2
	syscall
	li $v0, 7
	syscall
	mov.d $f4, $f0		#x2 is in $f4
	li $v0, 4
	la $a0, Prompt3
	syscall
	li $v0, 7
	syscall
	mov.d $f6, $f0		#y1 is in $f6
	li $v0, 4
	la $a0, Prompt4
	syscall
	li $v0, 7
	syscall
	mov.d $f8, $f0		#y2 is in $f8
	jal Square              #jump to square
	jal Rectangle		#jump to rectangle
	jal Circle		#jump to circle
	li $v0, 10
	syscall
	
Square:
	la $s1, getDistance         
	jalr $s3, $s1		#calls getDistance saves return address in $s3 and jumps to getDistance ($s1)
	la $s2, getSquared
	jalr $s4, $s2		#calls getSquared saves return address in $s4 and jumpts to getSquared ($s2)
	add.d $f12, $f22, $f22  #adds (X2-Y2)^2 to (X1-Y1)
	li $v0, 4
	la $a0, Prompt6
	syscall
	li $v0, 3
	syscall
	jr $ra
Rectangle:
	la $s1, getDistance
	jalr $s3, $s1		#calls getDistance saves return adress in $s3 and jumpts to getDistance ($s1)
	mul.d $f12, $f10, $f14	#(X2-X1) * (Y2-Y1) stored in $f12 (A=L*W)
	li $v0, 4
	la $a0, Prompt7
	syscall
	li $v0, 3
	syscall
	jr $ra
	
Circle:
	la $s1, getDistance
	jalr $s3, $s1
	la $s2, getSquared
	add.d $f18, $f22, $f20		#(X2-Y2)^2 ($f22) added together (Y1-Y1)^2 $(f20) answer in $f18
	l.d $f16, PI
	mul.d $f12, $f18, $f16      	#X2-X1 squared added with Y2-Y1 multipled with PI stored in $f12
	li $v0, 4
	la $a0, Prompt5
	syscall
	li $v0, 3
	syscall
	jr $ra
	
getDistance:
	sub.d $f10, $f6, $f2         #X2-X1 stored in $f10
	sub.d $f14, $f8, $f4        #Y2-Y1 stored in $f14
	jr $s3
	
getSquared:
	mul.d $f22, $f10, $f10       #X2-X1 squared stored in $f22
	mul.d $f20, $f14, $f14       #Y2-Y1 squared stored in $f20
	jr $s4

# END OF PROGRAM
################## HACI HASAN SAVAN ######################
################### 190 104 27 04 ########################
##################### 15.11.21 ###########################
##########################################################
.data
newLine: .ascii "\n"

whiteSpace: .asciiz " " 
#test arrays:
givenArr1: .word 3,10,7,9,4,12
givenArr2: .word 3,10,7
givenArr3: .word 10,9,2,5,3,7,101
givenArr4: .word 12,4,9,7,3		
givenArr5: .word 0,1,0,3,3,3,4
givenArr6: .word 55,65,75,85

givenArrSize: .word 24				# size = size*4 (.word 4 byte)
resultArr: .word 0,0,0,0,0,0,0,0,0,0		# This includes all possible solutions (candidate and longest one)
resultArrCursor: .word 0			# 
resultArrSize: .word 0				# size = size*4 (.word 4 byte)	
lastElement: .word 0				# to compare with next
longestSubSeq: .word 0,0,0,0,0,0,0,0,0,0	# stores longest one
longestSize: .word 0				# longest one's size. size = size*4 (.word 4 byte)
						# longest one can be at most 10 digit 
whiteSpaceAndComma: .ascii ", "
buffer: .space 200

fout: .asciiz "output.txt" # filename for output

.text

########################## MAIN.PROCEDURE ############################
main:

#----------------- Open (for writing) a file that does not exist -------------------
	li $v0, 13 		
	la $a0, fout 		
	li $a1, 1 		
	li $a2, 0		
	syscall 		
	move $s7, $v0 	# save the file descriptor 
	#case1		
	la $a1, givenArr1
	li $t1, 24
	sw $t1, givenArrSize
	la $a2, ($a1)
	la $a3, ($a1)
	jal foo					
 	jal write2File
 	jal printNewLine
 	#case2
 	jal resetElements		
	la $a1, givenArr2
	li $t1, 12
	sw $t1, givenArrSize
	la $a2, ($a1)
	la $a3, ($a1)
	jal foo					
 	jal write2File
 	jal printNewLine
 	#case3	
 	jal resetElements
	la $a1, givenArr3
	li $t1, 28
	sw $t1, givenArrSize
	la $a2, ($a1)
	la $a3, ($a1)
	jal foo					
 	jal write2File
 	jal printNewLine
 	 #case4	
 	 jal resetElements
	la $a1, givenArr4
	li $t1, 20
	sw $t1, givenArrSize
	la $a2, ($a1)
	la $a3, ($a1)
	jal foo					
 	jal write2File
 	jal printNewLine
 	 #case5	
 	 jal resetElements
	la $a1, givenArr5
	li $t1, 28
	sw $t1, givenArrSize
	la $a2, ($a1)
	la $a3, ($a1)
	jal foo					
 	jal write2File
 	jal printNewLine
 	 #case6	
 	 jal resetElements
	la $a1, givenArr6
	li $t1, 16
	sw $t1, givenArrSize
	la $a2, ($a1)
	la $a3, ($a1)
	jal foo					
 	jal write2File


#----------------- Close the file -------------------
	li $v0, 16 		
	move $a0, $s7 		
	syscall 		
	
j Exit

########################## END.OF.PROCEDURE ########################## 
#resets the all element befero every call
resetElements:
li $t1, 0
sw $t1, resultArrCursor #reset to 0
sw $t1, resultArrSize #reset to 0
sw $t1, lastElement #reset to 0
sw $t1, longestSize #reset to 0
sw $t1, lastElement #reset to 0
lw $t2, givenArrSize 
foorLoop:
	beq $t1, $t2, exitForLoop
	sw $zero, resultArr($t1) #reset to 0,0,0,0,0,0,0,0,0,0
	sw $zero, longestSubSeq($t1)#reset to 0,0,0,0,0,0,0,0,0,0
	addi $t1, $t1, 4
	j foorLoop
exitForLoop:
li $t2, 200
li $t1,0
la $t3, buffer
bufferLoop:
	beq $t1, $t2, exitBufferLoop
	sb $zero, buffer($t1) 
	addi $t1, $t1, 1
	j bufferLoop
exitBufferLoop:
jr $ra
########################## FOO.PROCEDURE ############################
# This is the Procedure that does the actual work. Only this procedure
# reads and writes s registersa on the other hand other procedures
# use s registers like read-only
foo:						
 .data 
 i: .word 0					
 k: .word 0					
 m: .word 0					
 .text
 
 #la $s0, givenArr				
 lw $t1, givenArrSize				
 #la $s2, resultArr				
 lw $s3, resultArrCursor			
 lw $s4, resultArrSize				
 lw $s5, lastElement
 lw $s0, i #$s0					
 lw $s2, k #$s2					
 lw $t3, m #$s6				
 sw $ra, 0($sp)
while1:
	lw $t1, givenArrSize	
	beq $s0, $t1, exit1							
	#while1 codes
	
	#lw $t0, givenArr($s0) 	  					
	lw $t0,($a1)
	sw $t0, resultArr($s3)						
	lw $s3, resultArrCursor
	lw $s4, resultArrSize
	addi $s3, $s3, 4						
	addi $s4, $s4, 4						
	sw $s3, resultArrCursor
	sw $s4, resultArrSize	
	
	jal write							
	lw $ra, 0($sp)							 
	#lw $t0, givenArr($s0)
	lw $t0,($a1)						
	add $s5, $t0, $zero																
	#while1 codes
	addi $s2, $s0, 4						# k = i+1
	addi $a2, $a1, 4  #a2 = a1+1
	while2:
		lw $t1, givenArrSize
		beq $s2,$t1,exit2					
		#while2 codes
		#lw $t0, givenArr($s2) 	
		lw $t0,($a2)				
		slt $t8, $s5, $t0					
		beq $t8, $zero, loop2					
		#lw $t0, givenArr($s2)
		lw $t0,($a2)						
		sw $t0, resultArr($s3)						
		lw $s3, resultArrCursor
		lw $s4, resultArrSize
		addi $s3, $s3, 4							
		addi $s4, $s4, 4						
		sw $s3, resultArrCursor
		sw $s4, resultArrSize	
		jal write							
		lw $ra, 0($sp)							
		#lw $t0, givenArr($s2)	
		lw $t0,($a2)					
		add $s5, $t0, $zero								
		#while2 codes
		addi $s6, $s2, 4					# m = k+1
		addi $a3, $a2, 4 #a3 = a2+1
		while3:
			lw $t1, givenArrSize
			beq $s6, $t1, exit3				
			
			#while1 codes
			#lw $t0, givenArr($s6) 	
			lw $t0,($a3)				
			slt $t9, $s5, $t0					
			beq $t9, $zero, loop3					
			#lw $t0, givenArr($s6)	
			lw $t0,($a3)					
			sw $t0, resultArr($s3)						
			lw $s3, resultArrCursor
			lw $s4, resultArrSize
			addi $s3, $s3, 4						
			addi $s4, $s4, 4						
			sw $s3, resultArrCursor
			sw $s4, resultArrSize	
			jal write							
			lw $ra, 0($sp)							
			#lw $t0, givenArr($s6)
			lw $t0,($a3)						
			add $s5, $t0, $zero							
			#while1 codes
			loop3:
			
			addi $s6, $s6, 4				# m++
			addi $a3, $a3, 4 # a3++
			j while3
		exit3:
		#while2 codes
		#lw $t0, givenArr($s0)
		lw $t0,($a1)						
		add $s5, $t0, $zero						
		li $t9,0
		lw $t0, resultArr($t9)#0($s2) 							
		jal clear							
		li $s3, 0
		li $s4, 0
		sw $s3, resultArrCursor
		sw $s4, resultArrSize							
		lw $ra, 0($sp)							
		sw $t0, resultArr($s3)						
		lw $s3, resultArrCursor
		lw $s4, resultArrSize
		addi $s3, $s3, 4							
		addi $s4, $s4, 4						
		sw $s3, resultArrCursor
		sw $s4, resultArrSize
		#while2 codes
		loop2:
		addi $s2, $s2,4						# k++			
		addi $a2, $a2, 4 #a2++
		j while2	
	exit2:			
	#while1 codes
	#while1 codes

	jal clear
	li $s3, 0
	li $s4, 0
	sw $s3, resultArrCursor
	sw $s4, resultArrSize	
	#li $s4, 0
	lw $ra, 0($sp)							
	addi $s0, $s0, 4
	addi $a1, $a1, 4						# i++								
	j while1
exit1:

	jr $ra
########################## CLEAR.PROCEDURE ########################### 
# Clears the candidate result array
clear:
li $t6,0
whilecl:
	beq $t6, 40, exitClear #size*4
	sw $zero, resultArr($t6)
	addi $t6, $t6, 4 #i++
	j whilecl
exitClear:

jr $ra
########################## END.OF.PROCEDURE ########################## 
printNewLine:
	li $v0, 4
	la $t0, newLine # newLine: .asciiz "\n"
	move $a0, $t0
	syscall
jr $ra
########################## WRITE.PROCEDURE ########################### 
# Print Candidate results to the Console also detects the
# longest one and saves  it to the longestSubSeq. 
# This Procedure no takes parameter. And return nothing

write:
      
li $t6,0 # t6 = i

whileWrite:
	beq $t6, $s4, exitWrite
	#print(number)
	li $v0, 1
	lw $t0, resultArr($t6)
	move $a0, $t0
	syscall
	#print(" ")
	li $v0, 4
	la $t0, whiteSpace
	move $a0, $t0
	syscall
	addi $t6, $t6, 4 #i++
	j whileWrite
exitWrite:
.data
ss: .ascii " - "
.text
	#print("\n")
	li $v0, 4
	la $t0, ss # newLine: .asciiz "\n"
	move $a0, $t0
	syscall
	
#----------------- Holding Longest One -------------------
	lw $t0, longestSize
	lw $t7, resultArrSize
	slt $t1, $t0, $t7 # if( longestSize < resultArrSize) $t1 = 1
	beq $t1, $zero, pass
	move $t0, $t7 #longestSize = resultArrSize
	sw $t0,longestSize #!
	li $t3,0  #i = 0
	Loop:
		beq $t3, $t7, pass
		lw $t1, resultArr($t3) # temp = resultArr[i]
		sw $t1, longestSubSeq($t3) ## longestSubSeq[i] = temp
		addi $t3, $t3, 4	#i++	 
	j Loop
	pass:	
jr $ra
########################## END.OF.PROCEDURE ########################## 

########################## WRITE2FILE.PROCEDURE ######################
# This procedure writes the longestSubSeq array that stores the result.																									
# LongestSubSeq is a .word array for this reason this procedure uses 
# custom atoi procedure. Extract .word number from array and sent it to
# the custom itoa. Needs to be Opened the writeFile before this procedure
# for writing.
write2File:
sw $ra, 0($sp)
addi $t8,$zero,0
lw $t6, longestSize 
la $t2, whiteSpaceAndComma
loopMain:
      	beq $t8, $t6, exitFromLoop2
      	lw $t1, longestSubSeq($t8) 	
      	move $a0, $t1      # a number
      	jal itoa
      	lw $ra, 0($sp)
      	move $t5, $v0 #catch the number
      	move $t3, $v1 #catch the size

#----------------- Write to file that opened in main -------------------
	li $v0, 15 		
	move $a0, $s7 		
	move $a1, $t5 		
	move $a2, $t3
	syscall 		
#----------------- Writing comma and space -----------------------------
      	addi $t7, $t6, -4 
      	beq $t8, $t7, passCommaAndWriteNewLine
      	li $v0, 15 		# system call for write to file
       	move $a0, $s7 		# file descriptor
       	move $a1, $t2 		# address of buffer from which to write
       	li $a2, 2	        
       	syscall
       	j pass2
      passCommaAndWriteNewLine:
        li $v0, 15
        move $a0, $s7
        la $t1, newLine
	move $a1, $t1
	li $a2, 1	        
	syscall
	pass2:
 	addi $t8, $t8, 4 #i++
 	j loopMain
exitFromLoop2:
jr $ra
########################## END.OF.PROCEDURE ########################## 								
	
########################## ITOA.PROCEDURE ############################
# This Function takes .word (multi digit or one digit doesn't matter) and
# convert it to the ASCII digits and returns it

itoa:
      li $t9, 0			#sayýnýn uzunluðu
      la   $t0, buffer+150 		
      sb   $0, 1($t0)     
      li   $a1, '0'  
      sb   $a1, ($t0) 
      li   $a3, 10  
      atla:      
      bgtz $a0, itoaLoop 
      
itoaLoop:
      div  $a0, $a3       
      mflo $a0
      mfhi $t4            
      add  $t4, $t4, $a1  
      sb   $t4, ($t0)     
      sub  $t0, $t0, 1    
      addi $t9, $t9, 1	  #size++
      bne  $a0, $0, itoaLoop  
      addi $t0, $t0, 1    
      move $v1, $t9 	  
      move $v0, $t0      
      jr   $ra           

########################## END.OF.PROCEDURE ##########################
Exit:

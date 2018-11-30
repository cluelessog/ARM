     PRESERVE8
	 THUMB
	 AREA appcode, CODE, READONLY
	 EXPORT __main
	 ENTRY 
__main  FUNCTION 			;The vertical and horizontal length of crosswire is 100 respectively
							;X and Y is input from user for origin which will be stored in R0 and R1
							;X is treated as Row and Y is treated as Column
							;For horizontal line, First X(row) is pushed and then Values of Y(column) is pushed which keeps on changing
							;For vertical line, First Y(column) is pushed and then Values of X(row) is pushed which keeps on changing
		MOV R0, #160 		;X
		MOV R1, #120 		;Y
		MOV R6, #0x20000000 ;start address of array
		LDR R3, =0x20000000
		MOV R7, #0 			;R7 is used for Indexing inside array
		STR R0,[R6,R7] 		;First Value of X(row) is pushed which is fixed
		MOV R5, #0 			;Loop Counter
		SUB R8, R1, #50		;R8 will have starting of horizontal line i.e Value of (R1 - 50)
							;Value of Y(column) will vary from R1-50 to R1+50
HORIZONTAL	CMP R5, #100 
		BEQ LOADY		 	;Branch if R5 = 100
		ADD R7, R7, #1		;increment Index
		STR R8, [R6,R7] 	;storing changing values of Y(column)
		ADD R8, R8, #1		;increment Y(column) value
		ADD R5, R5, #1		;increment loop counter
		B HORIZONTAL

LOADY	ADD R7, R7, #1
		STR R1,[R6,R7] 		;Now Value of Y(column) is pushed which is fixed
		B XVALUE

XVALUE	SUB R8, R0, #50		;R8 will have starting of Vertical line i.e Value of (R0 - 50)
							;Value of X(row) will vary from R0-50 to R0+50
		MOV R5, #0 			;Loop Counter
VERTICAL	CMP R5, #100
		BEQ DRAWCROSSWIRE 	;Branch if R5 = 100
		ADD R7,R7,#1 		;increment Index
		STR R8, [R6,R7] 	;Storing changing values of X(row)
		ADD R8, R8, #1 		;increment X(row) value
		ADD R5, R5, #1 		;increment loop counter
		B VERTICAL
	

DRAWCROSSWIRE NOP

		;.................................... DATA ENCRYPTION ....................................
		
	;I will be using 5 values from the pixels value already stored above starting from 0x20000000 and do encryption on them
	
	; number - b8-b7-b6-b5-b4-b3-b2-b1, encoded data - d12-d11-d10-d9-d8-d7-d6-d5-d4-d3-d2-d1
		MOV r2, #0x20000000	;start reading data for encryption
		SUB r2,r2,#1		;Index hack
		LDR r3, =0x200000D0	;Start address for storing encrypted data
		SUB r3,r3,#1		;Index hack
		MOV r11, r3			;Saving the address of stored encrypted data for encoding later
		B ENCRYPT

ENCRYPT	MOV r5, #0x000000ff	;Initialization Vector
		MOV r6, #0; counter
loop1	LDRB r4, [r2,#0x1]!	;register store the current data to be processed
		EOR r4, r4, r5;
		STR r4, [r3,#0x1]!	;storing the encrypted data
		MOV r5, r4;
		ADD r6, r6, #1		;counter increment
		CMP r6, #5			;comparison for looping
		BLT loop1			;Jump if R6 < 5
		B HAMMINGENC
		
	;.................................... Hamming encoding Starts Here ....................................			

HAMMINGENC	MOV r3, r11;		;moving back the address of stored encrypted data from r11
		LDR r1, =0x200000ea ;address to Start storing the hamming encoded data
		SUB r1, r1, #1		;Index hack
		MOV r0, #0			;counter
loop2	LDRB r4, [r3,#0x1]!	;r4 to store current data to be encoded 
		AND r5, r4, #0xf0	;to get bits b8 to b5
		LSL r5, r5, #4		;left shifting so that we can get the bits where we want them to be at. d12-d11-d10-d9
	
		AND r9, r4, #0x00000010		;b5 - bit 5 
		LSR r9, #4					;because we want b5 value to be at the position of b1;
		AND r10, r4, #0x00000020	;b6
		LSR r10, #5
		AND r11, r4, #0x00000040	;b7
		LSR r11, #6
		AND r12, r4, #0x00000080	;b8
		LSR r12, #7
		EOR r6, r9,r10				;xor-ing the bits to get the value.
		EOR r6, r6, r11
		EOR r6, r6, r12
		LSL r6, #7
		ADD r5,r5,r6				;d12-d11-d10-d9-d8
	
		AND r6, r4, #0xe
		LSL r6,r6, #3
		ADD r5,r5,r6				;d12-d11-d10-d9-d8-d7-d6-d5
	
		AND r9, r4, #0x00000002		;b2
		LSR r9, #1
		AND r10, r4, #0x00000004	;b3
		LSR r10, #2
		AND r11, r4, #0x00000008	;b4
		LSR r11, #3
		EOR r6, r9,r10
		EOR r6, r6, r11
		EOR r6, r6, r12
		LSL r6, #3
		ADD r5, r6, r5				;d12-d11-d10-d9-d8-d7-d6-d5-d4
	
		AND r12, r4, #0x00000001	;b1
		LSL r12, #2
		ADD r5, r12, r5
		LSR r12, #2					;d12-d11-d10-d9-d8-d7-d6-d5-d4-d3
	
		AND r10, r4, #0x00000020	;b6
		LSR r10, #5
		AND r11, r4, #0x00000040	;b7
		LSR r11, #6
		AND r7, r4, #0x00000004		;b3
		LSR r7, #2
		AND r8, r4, #0x00000008		;b4
		LSR r8, #3
		EOR r6, r11,r10
		EOR r6, r6, r7
		EOR r6, r6, r8
		EOR r6, r6, r12
		LSL r6, #1
		ADD r5, r6, r5				;d12-d11-d10-d9-d8-d7-d6-d5-d4-d3-d2
	
		AND r10, r4, #0x00000002	;b2
		LSR r10, #1
		AND r9, r4, #0x00000010		;b5
		LSR r9, #4
		EOR r6, r12,r10
		EOR r6, r6, r8
		EOR r6, r6, r9
		EOR r6, r6, r11
		ADD r5, r6, r5				;d12-d11-d10-d9-d8-d7-d6-d5-d4-d3-d2-d1, r5 has the Hamming encoded value
		STRB r5, [r1, #0x1]!		;Since it is 12 bits, we need a way to store it in memory
		LSR r5, #8					; So 0x57D is stored as 7D 05
		STRB r5, [r1,#0x1]!		
		ADD r0, #1					;to help with the loop count
		CMP r0, #5
		BLT loop2
		
stop B stop ; stop program
	 ENDFUNC
	 END

	 PRESERVE8
	 THUMB
	 AREA appcode, CODE, READONLY
   EXPORT __main
	 ENTRY 
__main  FUNCTION ;The vertical and horizontal length of crosswire is 100 respectively
	;X and Y is input from user for origin which will be stored in R0 and R1
	;X is treated as Row and Y is treated as Column
	;For horizontal line, First X(row) is pushed and then Values of Y(column) is pushed which keeps on changing
	;For vertical line, First Y(column) is pushed and then Values of X(row) is pushed which keeps on changing
	MOV R0, #160 ;X
	MOV R1, #120 ;Y
	MOV R6, #0x20000000 ;start address of array
	MOV R7, #0 ; R7 is used for Indexing inside array
	STR R0,[R6,R7] ; First Value of X(row) is pushed which is fixed
	MOV R5, #0 ; Loop Counter
	SUB R8, R1, #50; R8 will have starting of horizontal line i.e Value of (R1 - 50)
	;Value of Y(column) will vary from R1-50 to R1+50
HORIZONTAL	CMP R5, #100 ; 
		BEQ LOADY
		ADD R7, R7, #1; increment Index
		STR R8, [R6,R7] ; storing changing values of Y(column)
		ADD R8, R8, #1; increment Y(column) value
		ADD R5, R5, #1; increment loop counter
		B HORIZONTAL

LOADY	ADD R7, R7, #1
		STR R1,[R6,R7] ; Now Value of Y(column) is pushed which is fixed
		B XVALUE

XVALUE	SUB R8, R0, #50; R8 will have starting of Vertical line i.e Value of (R0 - 50)
		;Value of X(row) will vary from R0-50 to R0+50
		MOV R5, #0 ; Loop Counter
VERTICAL	CMP R5, #100
		BEQ DRAWCROSSWIRE
		ADD R7,R7,#1 ;increment Index
		STR R8, [R6,R7] ; Storing changing values of X(row)
		ADD R8, R8, #1 ; increment X(row) value
		ADD R5, R5, #1 ; increment loop counter
		B VERTICAL
	

DRAWCROSSWIRE NOP

stop B stop ; stop program
     ENDFUNC
     END

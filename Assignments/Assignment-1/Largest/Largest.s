	AREA Largest, CODE, READONLY
	EXPORT __main
	ENTRY
__main  FUNCTION ; The result is stored in register R8 i.e. the largest number
        MOV r1,#3; a=3
		MOV r2,#2; b=2
		MOV r3,#1; c=1

		CMP r1,r2; check if a > b
		ITE GT; checking for condition
		MOVGT r4,r1; executed if a > b, r4 = a
		MOVLE r4,r2; executed if a <= b, r4 = b
		;r4 has greater among a and b
		CMP r4,r3 ; check if r4 > c
		ITE GT; checking for condition
		MOVGT r8,r4; executed if r4 > c, r8 = r4
		MOVLE r8,r3; executed if r4 <= c, r8 = r3

stop    B stop ; stop program
		ENDFUNC
		END

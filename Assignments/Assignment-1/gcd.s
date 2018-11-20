	THUMB
	AREA     GCD, CODE, READONLY
	EXPORT __main
	ENTRY
__main  FUNCTION
        MOV r2,#10 ; (a = 10)
        MOV r3,#2 ; (b = 2)
		CMP r2,#0 ; if anyone of a or b is zero, GCD is the non zero number
		BEQ stop ; jump to stop if a = 0
		CMP r3,#0 ;
		BEQ stop ; jump to stop if b = 0
loop    CMP r2,r3; (check if a has become equal to b, loop stops if they become equal)
        BEQ stop; jump to stop if they become equal
		SUBGT r2,r2,r3; executed if r2 > r3
		SUBLT r3,r3,r2; executed if r2 < r3
        BNE loop ; loop if a != b and finally r2 or r3 holds the result of GCD
stop    B stop ; stop program
     ENDFUNC
     END

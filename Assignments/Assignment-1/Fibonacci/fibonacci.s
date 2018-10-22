	THUMB
	AREA     Fibonacci, CODE, READONLY
	EXPORT __main
	ENTRY
__main  FUNCTION
        MOV r1,#0 ; (a = 0)
        MOV r2,#1 ; (b = 1)
		MOV r3,#5 ; (n=5, display first n numbers)
loop	CMP r3,#0 ; (counter check (n>0))
		SUBGT r3,r3,#1 ; (decrement counter by 1)
		BEQ stop; jump to stop once n=0
		MOV r8,r1 ; (store r1, it stores and displays the fibonacci numbers)
		ADD r4,r1,r2 ; (c = a+b)
		MOV r1,r2 ; (a = b)
		MOV r2,r4 ; (b = c)
		BGT loop; (loop if n>0)
stop    B stop ; stop program
     ENDFUNC
     END

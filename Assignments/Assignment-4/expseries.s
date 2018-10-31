   PRESERVE8
	 THUMB
	 AREA appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION
		;this program performs e^x
		;the result will be stored in S2
		VMOV.F32 S2, #1 ; Sum Variable
		VMOV.F32 S6, #10 ; 'n' variable - sequence size
		VMOV.F32 S1, #1 ; 'x' varaiable - in e^x
		VMOV.F32 S3, #1 ; constant
loop	VCMP.F32 S6, #0 
		VMRS.F32 APSR_nzcv,FPSCR ; copy flags from FPSCR to APSR
		BEQ stop
		VDIV.F32 S4, S2, S6 ; sum/i
		VMUL.F32 S5, S1, S4 ; x*sum/i
		VADD.F32 S2, S3, S5 ; sum = 1 + (x * (sum/i)) 
		VSUB.F32 S6, S6, S3
		B loop
stop B stop ; stop program
     ENDFUNC
     END

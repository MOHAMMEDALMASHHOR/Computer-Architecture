;***********************************************
;Lesson no. 3	- arithmetic operations
;Example no. 2	- addition of data from keyboard
;***********************************************
	LJMP	START
	ORG	100H
START:
	LCALL	LCD_CLR

	LCALL	WAIT_KEY	;read data from matrix keyboard
				;number from range 00h-0Fh
	MOV	R0,A		;save a copy to R0
	LCALL	WRITE_HEX	

	LCALL WAIT_KEY
	MOV R1,A

	LCALL	WAIT_KEY	;read second data
	CJNE 	A,#0CH,NO_ADD_C		;save a copy to R1
	MOV	A,#'+'
	LCALL WRITE_DATA
	MOV A,R1
	LCALL	WRITE_HEX	

	MOV	A,#'='		
	LCALL	WRITE_DATA	

	MOV	A,R0		;retrieve first number
	ADD	A,R1		;add the second number
	LCALL	WRITE_HEX
	LJMP	$

NO_ADD_C:
	CJNE 	A,#0DH,NO_SUBB_D
	MOV 	A,#'-'
	LCALL 	WRITE_DATA
	MOV	A,R1
	LCALL	WRITE_HEX
	MOV	A,R0
	CLR	C
	SUBB	A,R1
	LCALL	WRITE_HEX
	LJMP 	$

NO_SUBB_D:
	CJNE	A,#0AH,NO_MUL_A
	MOV 	A,'*'
	LCALL	WRITE_DATA
	MOV 	A,R1
	LCALL 	WRITE_HEX
	MOV	A,#'='
	LCALL	WRITE_DATA

	MOV	A,R0
	MOV	B,R1	
	MUL	AB
	LCALL 	WRITE_HEX
	LJMP	$

NO_MUL_A:
	CJNE	A,#0BH,NO_DIV_B
	MOV	A,#'/'
	LCALL	WRITE_DATA
	MOV	A,R1
	LCALL	WRITE_DATA
	MOV 	A,R0
	MOV	B,R1
	DIV	AB
	LCALL	WRITE_HEX
	LJMP 	$
NO_DIV_B:LJMP	$
	
	

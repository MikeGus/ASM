PUBLIC	PROC_SHOW_MENU
EXTRN	NEW_LINE:NEAR

Data	SEGMENT	PUBLIC
	menu	DB	10,13,'+----------------------------+',
		DB	10,13,'|   COMMANDS:		     |',
		DB	10,13,'+----------------------------+',
		DB	10,13,'|0) SHOW MENU                |',
		DB	10,13,'|1) ENTER INTEGER            |',
		DB	10,13,'|2) PRINT AS UNSIGNED BINARY |',
		DB	10,13,'|3) PRINT AS SIGNED BINARY   |',
		DB	10,13,'|4) PRINT AS UNSIGNED DECIMAL|',
		DB	10,13,'|5) PRINT AS SIGNED DECIMAL  |',
		DB	10,13,'|6) PRINT AS UNSIGNED HEX    |',
		DB	10,13,'|7) PRINT AS SIGNED HEX      |',
		DB	10,13,'|8) EXIT PROGRAM             |',
		DB	10,13,'+----------------------------+',10,13,'$'

Data 	ENDS

Code 	SEGMENT PUBLIC
	ASSUME	CS:Code, DS:Data

PROC_SHOW_MENU	PROC NEAR
	push	AX
	push	DX
	
	mov	AH,9

	mov	DX,OFFSET menu
	int	21h

	pop	DX
	pop	AX
	RET
PROC_SHOW_MENU	ENDP

Code	ENDS

END
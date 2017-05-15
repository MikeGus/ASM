;0 - show meny
;1 - enter x
;2 - unsigned 2
;3 - signed 2
;4 - unsigned 10
;5 - signed 10
;6 - unsigned 16
;7 - signed 16
;8 - exit program


EXTRN	PROC_SHOW_MENU:NEAR
EXTRN	PROC_INPUT:NEAR
EXTRN	PROC_PRINT_UNSIGNED_2:NEAR
EXTRN	PROC_PRINT_SIGNED_2:NEAR
EXTRN	PROC_PRINT_UNSIGNED_10:NEAR
EXTRN	PROC_PRINT_SIGNED_10:NEAR
EXTRN	PROC_PRINT_UNSIGNED_16:NEAR
EXTRN	PROC_PRINT_SIGNED_16:NEAR


PUBLIC NEW_LINE, arrow


Data 	SEGMENT PUBLIC
	func	DW	PROC_SHOW_MENU, PROC_INPUT, PROC_PRINT_UNSIGNED_2, PROC_PRINT_SIGNED_2, PROC_PRINT_UNSIGNED_10, PROC_PRINT_SIGNED_10, PROC_PRINT_UNSIGNED_16, PROC_PRINT_SIGNED_16
	arrow	EQU	'>'
	X	DW	9
Data  	ENDS


Stack	SEGMENT STACK
	DW	128h DUP (?)
Stack	ENDS


Code	SEGMENT PUBLIC
	ASSUME CS:Code, DS:Data, SS:Stack

;procedure to set a new line
;
NEW_LINE	PROC	NEAR
	push	AX
	push	DX
	
	mov	AH,2
	mov	DL,10
	int	21h
	mov	DL,13
	int	21h
	
	pop	DX
	pop	AX
	RET
NEW_LINE	ENDP


MAIN_PROC:
	mov	AX,Data
	mov	DS,AX

	mov	BX,0
	;print menu
	call	func[BX]

mainloop:
	call NEW_LINE
	mov	AH,2
	mov	DL, arrow 
	int 	21h ;display arrow

enter_symbol:
	mov	AH,8
	int	21h ;enter symbol

	cmp	AL,'8'
	je	exit	; if command is 8 - exit
	ja	enter_symbol; if command > 8 - repeat input
	cmp	AL,'0' 
	jb	enter_symbol; if command < 0 - repeat input 

	mov	AH,2
	mov	DL,AL
	int	21h

	mov	BL,AL
	sub	BL,'0'	; get number of command in BL

	cmp	BL,2
	jb	no_push
	push	X	; push X to stack to pass to function
no_push:
	add	BL,BL	; transform command to address of function
	mov	BH,0
	call	NEW_LINE

	call	func[BX]

	cmp	BX,4
	jb	no_pop
	add	SP,2 ; clear stack
no_pop:
	cmp	BX,2
	jne	mainloop
	mov	X,CX	; if number was entered - save it
	jmp	mainloop	
exit:
	mov	AH,2
	mov	DL,AL
	int	21h
	mov	AH,4Ch
	int	21h

Code	ENDS
	END	MAIN_PROC
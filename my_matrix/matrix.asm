;
Data   SEGMENT  'DATA'
M	DB	1,1,1,1,0,1,1,1,0,0,1,1,0,0,0,1
Data   ENDS
;
STEK  SEGMENT STACK 'STACK'
        DW      128h DUP (?)
STEK  ENDS
;
Code    SEGMENT
        ASSUME  CS:Code, DS:Data, SS:STEK
;
PP1	PROC 
        mov   	AX,Data 
        mov   	DS,AX
	;
	mov 	DH,0
	mov	DL,0
	mov	DI,DX; base range between elements
	mov	AL,4; position step
	mov	AH,3; shift val
	;
	mov	BH,15; base position
	mov	BL,5; dec value
	mov	CH,0 ; safety purpose
	;
init:
	clc	;remove carry flag
	add	DL,AH; increase range between elements
	sub	BH,AL; dec base
	jc	exit
	mov	CL,BH ;init CX
	;
mainloop:
	mov	SI,CL ;place position
	add	CL,DL;
	mov	DI,CL;
	sub	CL,DL;
	;
	push	AX
	push	DX
	mov	DL,M[SI] ;swap
	mov	AL,M[DI]
	mov	M[SI],AL
	mov	M[DI],DL
	pop	DX
	pop	AX
	;
	clc	;remove carry flag
	sub	CL,BL ;dec position
	jc	init
	jmp	mainloop;
	;
exit:
	mov	AX,0
	mov	SI,AX
	mov	CX,16
printloop:
	loop	print
	jmp 	todos
print:
	mov	DL,M[SI]
	add	DL,'0'
	mov	AH,2
	int	21h
	inc	SI
	jmp	printloop
todos:
	mov	DL,M[SI]
	add	DL,'0'
	mov	AH,2
	int	21h
	mov	AH,4Ch
	int	21h
	;
PP1	ENDP
;
Code    ENDS
        END   PP1
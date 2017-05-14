;
Data   SEGMENT  'DATA'
M	DB	1,1,1,1,1,1
	DB	0,1,1,1,1,1
	DB	0,0,1,1,1,1
	DB	0,0,0,1,1,1
	DB	0,0,0,0,1,1
	DB	0,0,0,0,0,1
N	DB	6
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
	mov	SI,0	;start src
		
	mov	AH,0
	mov	AL,N
	dec	AX	;base step
	mov	CX,0	;init CX
	PUSH	CX
init:
	POP	CX
	inc	CX	;inc start element
	cmp	CL,N
	je	exit	;end of cycle
	add	SI,CX
	mov	BX,AX	;init step
	mov	DI,SI	
	add	DI,BX	;init dest elem
	PUSH	CX

mainloop:
	mov	DL,M[SI]
	xchg	DL,M[DI]
	xchg	DL,M[SI]
	
	inc	SI
	add	BX,AX	;inc	step
	mov	DI,SI
	add	DI,BX

	inc	CX
	cmp	CL,N
	je	init
	jmp	mainloop;

exit:
	mov	SI,0
	mov	AL,N
	mul	N
	mov	CX,AX
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
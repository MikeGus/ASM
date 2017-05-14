;
Data   SEGMENT  'DATA'
A	DB	8,4,3,1,2,9,5,0
N	DB	8
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
	mov	SI,OFFSET A
	mov	DI,N
	add	DI,SI
	call PRINT
	dec	SI
	;
mainloop:
	inc	SI
	dec	DI
	cmp	SI,DI
	je	main_exit
	inc	DI
	CALL	MIN
	cmp	SI,BX
	je	mainloop
	push	DI
	mov	DI,BX
	xchg	CL,[SI]
	xchg	CL,[DI]
	pop	DI
	jmp	mainloop
main_exit:	
	inc	DI
        mov	SI,OFFSET A
	call	PRINT
	mov	AH,4Ch
	int	21h
PP1	ENDP
;IN: SI - beginning of array DI - position after
;ending of array
;
;OUT:	BX - position of minimum; CX - value of minimum  
MIN	PROC
	push	SI ; saving SI
	mov	BX,SI ;initial position of minimum
	mov	CL,[SI] ;initial minimum
minloop:
	inc	SI ; new position
	cmp	SI,DI ; check if end of cycle
	je	exit ; if end exit
	push	AX ; save ax
	mov	AL,[SI] 
	cmp	AL,CL ; check if new minimum
	ja	notfound
	mov	CL,AL ; if new minimum
	mov	BX,SI 
notfound:
	pop	AX
	jmp	minloop
exit:
	pop	SI
	RET
MIN	ENDP
;
;IN: SI - beginning of array DI - position after ending
;
PRINT	PROC
	push	AX
	push	DX
	push	SI
printloop:
	mov	AX,[SI]
	add	AX,'0'
	mov	DX,AX
	mov	AH,2
	int	21h
	mov	DX,' '
	int	21h
	inc	SI
	cmp	SI,DI
	jne	printloop
	;
	mov	DX,0dh
	int	21h
	mov	DX,0ah
	int	21h
	pop	SI
	pop	DX
	pop	AX
	RET
PRINT	ENDP
;
Code    ENDS
        END   PP1
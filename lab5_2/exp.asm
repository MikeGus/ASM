;
Data   SEGMENT  'DATA'
OP	DB	42 DUP(0) ;symbols before operations
	DB	1, 1, 0, 1, 0, 1 ; operations marked with 1
	DB	10 DUP(2) ; numbers marked with 2
	DB	198 DUP(0) ; symbols after table
;
E	DB	'-3+2-6+33-3-1+5','$'; expression
M	EQU	6 ; max num of oper
RESULT_1 	DB 	'AX = $'
RESULT_2	DB	10, 13,'SI = $'
Data   ENDS
;
;
STEK  SEGMENT STACK 'STACK'
        DW      128h DUP (?)
STEK  ENDS
;
;
Code    SEGMENT
        ASSUME  CS:Code, DS:Data, SS:STEK
;
PP1	PROC 
        mov   	AX,Data 
        mov   	DS,AX
	;
	mov	SI,OFFSET E ; set SI at begin of sentence
	mov	DI,SI ; remember beginning of sentence
	;
	mov	BX, OFFSET OP; set BX at beginning of table
	;
	;checking first symbol
	mov	AL,[SI] ; mov value to AL
	push	AX ; save AL
	XLAT	;coding AL
	mov	DL, AL ; DL contains previous symbol
	CMP	AL,2
	pop	AX
	je	first_number_ok
	;
	cmp	AL,'-'
	jne	err_1 ;if first symbol is not number or minus
	;
first_number_ok:
	mov	CX,0 ;save OP's count in CX
main_loop:
	inc	SI
	mov	AL,[SI]
	XLAT
	cmp	AL,1
	jb	err_3 ;if AL is garbage
	je	count_op ;if AL is operand
	mov	DL,AL
	inc	SI ; if AL is number check next symbol if it's end of string
	mov	AL,[SI]
	cmp	AL,'$' ; if it's end of string - ok
	je	err_0
	dec	SI ; else continue
	jmp	main_loop	
	;
count_op:
	cmp CX, M
	jae	err_2 ; if operand >= max_val
	cmp	DL,2
	jne	err_3 ; if before operand is other operand
	inc	CX
	mov	DL,AL
	jmp	main_loop
exit:
	push	AX
	mov	DX, OFFSET RESULT_1
	mov	AH,9
	int	21h
	pop	AX
	mov	DL,AL
	add	DL,'0'
	mov	AH,2
	int	21h ; print AX
	;
	mov	DX, OFFSET RESULT_2
	mov	AH,9
	int	21h
	mov	AX,SI
	AAM
	mov	CX,AX
	mov	DL,CH
	add	DL,'0'
	mov	AH,2
	int	21h 
	mov	DL,CL
	add	DL,'0'
	int	21h ; print SI
	;
	mov	AH,4Ch
	int	21h
err_0:
	mov	AL,0
	sub	SI,DI
	jmp	exit
err_1:
	mov	AL,1
	sub	SI,DI
	jmp	exit
err_2:
	mov	AL,2
	sub	SI,DI
	jmp	exit
err_3:	
	mov	AL,3
	sub	SI,DI
	jmp	exit
PP1	ENDP

Code    ENDS
        END   PP1
;
Data   SEGMENT  'DATA'
RES	DB	'RESULT:  $'  
F	DW	4
	DB	'$'
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
        mov	DX,OFFSET RES
        mov	AH,9    
        int	21h
	mov	CX,F
	PUSH	CX	
	CALL 	PP2
	AAM
	add	AH,'0'
	add	AL,'0'
	mov	BL,AH
	mov	BH,AL
	mov	F,BX
	mov	DX, OFFSET F
	mov	AH,9
	int	21h	
	mov	AH,4Ch
	int	21h
PP1	ENDP
;
PP2	PROC	
	PUSH BP ;save BP
	mov BP,SP ;BP = SP
	mov AX,[BP+4]
	;
	test AX,AX ;check AX
	jz f_ret_1
	;
	dec AX
	PUSH AX
	call PP2
	mov CX,[bp+4]
	mul CX
	jmp f_ret
f_ret_1:
	inc AX
f_ret:
	POP BP
	RET 2
PP2	ENDP
;
Code    ENDS
        END   PP1
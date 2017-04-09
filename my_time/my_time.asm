;
Data   SEGMENT  'DATA'
RES	DB	'TIME: $'
HH	Dw	?
MM	Dw	?
SEK	Dw	?
DEL	DB	':'
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
        int	21h	;TIME:  
	;
	mov	AH,2
	int	1Ah	;get time   
        ;
	mov	HH,CH
	mov	MM,CL
	mov	SEK,DH
	;
	mov	CL, 4	;shift val
	;WORK WITH HOURS
	mov	AH,0
	mov	AL,HH
	;
	shl	AX,CL
	shr	AL,CL
	add	AH,'0'
	add	AL,'0'
	;
	mov	HH,AH
	mov	HH[1],AL
	;
	mov	DL,HH
	mov	AH,2
	int	21h
	mov	DL,HH[1]
	int	21h
	;PUT ':'
	mov	DL,DEL
	int	21h
	;WORK WITH MINUTES
	mov	AH,0
	mov	AL,MM
	;
	shl	AX,CL
	shr	AL,CL
	add	AH,'0'
	add	AL,'0'
	;
	mov	MM,AH
	mov	MM[1],AL
	mov	AH,2
	mov	DL,MM
	int	21h
	mov	DL,MM[1]
	int	21h
	;PUT ':'
	mov	DL,DEL
	int	21h
	;WORK WITH SECONDS
	mov	AH,0
	mov	AL,SEK
	;
	shl	AX,CL
	shr	AL,CL
	add	AH,'0'
	add	AL,'0'
	;
	mov	SEK,AH
	mov	SEK[1],AL
	;
	mov	AH,2
	mov	DL,SEK
	int	21h
	mov	DL,SEK[1]
	int	21h
	;
	mov	AH,4Ch
	int	21h
	;
PP1	ENDP	
;
Code    ENDS
        END   PP1
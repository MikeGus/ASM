Code    SEGMENT WORD PUBLIC
        ASSUME  CS:Code, DS:Data
PP1	PROC FAR
	PUSH	DS
	MOV 	AX,0
	PUSH 	AX
        mov   	AX,Data                
        mov   	DS,AX                   
        mov   	DX,OFFSET A1   
        mov   	AH,9                     
        int   	21h                     
        mov   	AH,7                     
        INT   	21h            
        mov   	DX,OFFSET A2   
PP1	ENDP
Code    ENDS
;
Data   SEGMENT WORD
A1    DB   13, 10, 'A1$'
A2    DB   13, 10, 'A2$'

Data   ENDS
        END   PP1

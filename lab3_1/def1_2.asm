Data   SEGMENT 'DATA'
A2    DB   13, 10, 'A2$' 
Data   ENDS
;
Code    SEGMENT	BYTE
        ASSUME  CS:Code, DS:Data
PP2	PROC FAR
        MOV   AX,DATA         
        MOV   DS,AX           
        MOV   DX,OFFSET A2 
        MOV   AH,9         
        INT   21H          
        MOV   AH,7         
        INT   21h          
	RET
PP2	ENDP
Code    ENDS
        END
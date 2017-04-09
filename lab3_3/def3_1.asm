Code    SEGMENT WORD PUBLIC
        ASSUME  CS:Code, DS:Data, SS:STEK
PP1	PROC
	PUSH DS
	MOV AX,0
	PUSH AX
      	mov   AX,Data               
        mov   DS,AX                    
        mov   DX,OFFSET A1 
        mov   AH,9                     
        int   21h                
        mov   AH,7                  
        INT   21h                      
        mov   DX,OFFSET A2
PP1	ENDP
Code    ENDS
;
Data   SEGMENT 
A1    DB   13, 10, 'A1$'
A2    DB   13, 10, 'A2$'
Data   ENDS
;
STEK  SEGMENT PARA STACK 'STACK'
        DW      128h DUP (?)
STEK  ENDS
        END   PP1

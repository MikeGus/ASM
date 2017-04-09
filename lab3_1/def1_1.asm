Code    SEGMENT
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
PP1	ENDP
	
Code    ENDS
;
Data   SEGMENT  'DATA'
A1    DB   13    
      DB   10    
      DB   'A1'  
      
DB   '$'   
Data   ENDS
;
STEK  SEGMENT STACK 'STACK'
        DW      128h DUP (?)
STEK  ENDS
        END   PP1
Code    SEGMENT PUBLIC
        ASSUME  CS:Code, DS:Data
PP1	PROC 
        MOV   AX,DATA        
        MOV   DS,AX          
        MOV   DX,OFFSET A1   
        MOV   AH,9           
        INT   21H            
        MOV   AH,7           
        INT   21h            
PP1	ENDP
Code    ENDS
;
Data   SEGMENT PUBLIC 'DATA'
A1    DB   13, 10, 'A1$' 
Data   ENDS
       END   PP1

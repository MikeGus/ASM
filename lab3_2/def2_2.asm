Data   SEGMENT PUBLIC 'DATA'
A2    DB   13, 10, 'A2$' 
Data   ENDS
;
Code    SEGMENT BYTE PUBLIC
        ASSUME  CS:Code, DS:Data
PP2	PROC 
      MOV  	AX,DATA 
      MOV   DS,AX                 
      MOV   DX,OFFSET A2 
      MOV   AH,9            
      INT   21H             
      MOV   AH,7                  
      INT   21h           
	MOV	AH,4Ch
	INT 	21H
PP2	ENDP
Code    ENDS
END   

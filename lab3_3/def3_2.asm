Code    SEGMENT BYTE PUBLIC
        ASSUME  CS:Code
PP2	PROC FAR
        mov   AH,9   
        int   21h    
        mov   AH,7   
        INT   21h    
	RET
PP2	ENDP
Code    ENDS
        END   
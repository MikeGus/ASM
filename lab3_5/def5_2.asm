DSEG SEGMENT COMMON
	DB	12 DUP(?)
A	DB	?
DSEG ENDS
PUBLIC	M2
CSEG SEGMENT 
ASSUME CS:CSEG, DS:DSEG
M2:
	MOV AH,2
	MOV DL,A
	INT 21H
	MOV AH,4CH
	INT 21H
CSEG ENDS
        END 
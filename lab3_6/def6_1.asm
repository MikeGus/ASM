DSEG SEGMENT PUBLIC
D1 DB 'D'
DSEG ENDS
	PUBLIC D1
CSEG SEGMENT PUBLIC
ASSUME CS:CSEG, DS:DSEG
	EXTRN PP2:NEAR
PP1	PROC
	CALL PP2
	MOV	AH,4Ch
	INT	21h
PP1	ENDP
CSEG ENDS
END PP1

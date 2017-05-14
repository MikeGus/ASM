;
Data   SEGMENT  'DATA'
	ORG	1 ;U0 does not point to itself
U0	DW	0,'07',U1,U2
U1	DW	U0,'13',U3,U4
U2	DW	U0,'29',U5,U6	
U3	DW	U1,'31',U7,U8
U4	DW	U1,'45',U9,UA
U5	DW	U2,'58',0,0
U6	DW	U2,'6A',0,0
U7	DW	U3,'70',0,0
U8	DW	U3,'82',0,UB
U9	DW	U4,'94',0,0
UA	DW	U4,'A6',0,0
UB	DW	U8,'BB',0,0
Data   ENDS
;
;
STEK  SEGMENT STACK 'STACK'
        DW      128h DUP (?)
STEK  ENDS
;
;
Code    SEGMENT
        ASSUME  CS:Code, DS:Data, SS:STEK
;
PP1	PROC 
        mov   	AX,Data 
        mov   	DS,AX
	;
	mov	CX,OFFSET U0
	call TREE_BRANCH	
	;
	mov	AH,4Ch
	int	21h

PP1	ENDP
;
;CX contains adress of node
;in_order tree walk
TREE_BRANCH	PROC
	cmp	CX,0
	je	exit ; if node is zero - return from proc
	push	BX ;save BX
	mov	BX,CX ; save CX in BX to work with offsets
	mov	CX,[BX+4] ; move adress of left child to BX
	call	TREE_BRANCH
	;printing data
	mov	AH,2
	mov	DL,[BX+3]
	int	21h
	mov	DL,[BX+2]
	int	21h
	mov	DL,' '
	int	21h
	;
	mov	CX,[BX+6] ; move adress of left child to BX
	call	TREE_BRANCH
	pop	BX
exit:
	RET
TREE_BRANCH	ENDP
;
Code    ENDS
        END   PP1
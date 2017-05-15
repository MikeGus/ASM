PUBLIC	PROC_PRINT_SIGNED_10
EXTRN 	NEW_LINE:NEAR

Code	SEGMENT PUBLIC
	ASSUME	CS:Code

PROC_PRINT_SIGNED_10	PROC NEAR
	push	BP
	
	mov	BP,SP
	mov	AX,[BP+4] ; get data

	push	AX
	push	DX
	push	BX

	mov	BX,10 ; value for div

	cmp	AX,0
	jl	set_minus
	jmp	start_work

set_minus:
	mov	DL,'-'
	push	AX
	mov	AH,2
	int	21h
	pop	AX
	neg	AX ; set positive

start_work:
	push	AX ; save value
set_size:
	mov	DX,0
	div	BX
	push	AX ; save value

	mov	AH,2
	mov	DL,'b' ; print buffer val
	int	21h

	pop	AX
	test	AX,AX
	jnz	set_size	

	;get back 1 step
	mov	AH,2
	mov	DL,8
	int	21h

	pop	AX	; get value
maindiv:
	mov	DX,0
	div	BX
	push	AX

	mov	AH,2
	add	DL,'0'
	int	21h
	mov	DL,8
	int	21h
	int	21h

	pop	AX
	test	AX,AX
	jnz	maindiv

	pop	BX
	pop	DX
	pop	AX
	pop	BP
	RET
PROC_PRINT_SIGNED_10 ENDP

Code	ENDS
END
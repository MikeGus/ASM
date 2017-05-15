PUBLIC	PROC_PRINT_SIGNED_16
EXTRN 	NEW_LINE:NEAR

Code	SEGMENT PUBLIC
	ASSUME	CS:Code

PROC_PRINT_SIGNED_16	PROC NEAR
	push	BP
	
	mov	BP,SP
	push	AX
	mov	AX,[BP+4] ; get data

	push	DX
	push	BX
	push	CX

	cmp	AX,0
	jl	add_minus
	jmp	start_proc
	
add_minus:
	push	AX
	mov	AH,2
	mov	DL,'-'
	int	21h
	pop	AX
	neg	AX	

start_proc:
	mov	BX,16 ; value for div
	mov	CX,0
	push	AX ; save value for print
	
set_size:
	mov	DX,0
	div	BX
	push	AX ; save value

	mov	AH,2
	mov	DL,'b' ; print buffer val
	int	21h

	inc	CX ; count numbers

	pop	AX

	test	AX,AX
	jnz	set_size	

	;get back 1 step
	mov	AH,2
	mov	DL,8
	int	21h


	pop	AX	; get value
	mov	BX,15 ; mask
	inc	CX

mainloop:
	loop	shift
	jmp	exit
shift:
	push	AX

	and	AX,BX
	mov	DL,AL
	cmp	DL,9
	ja	add_a
	jmp	add_zero
add_a:
	add	DL,'A'
	sub	DL,10
	jmp	after_add
add_zero:
	add	DL,'0'
after_add:
	mov	AH,2
	int	21h
	mov	DL,8
	int	21h
	int	21h	

	pop	AX


	push	CX
	mov	CL,4
	shr	AX,CL
	pop	CX

	jmp	mainloop
		
exit:
	pop	CX
	pop	BX
	pop	DX
	pop	AX
	pop	BP
	RET
PROC_PRINT_SIGNED_16 ENDP

Code	ENDS
END
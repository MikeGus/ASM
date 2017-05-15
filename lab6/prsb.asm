PUBLIC	PROC_PRINT_SIGNED_2
EXTRN 	NEW_LINE:NEAR

Code	SEGMENT PUBLIC
	ASSUME	CS:Code

PROC_PRINT_SIGNED_2	PROC NEAR
	push	BP
	mov	BP,SP

	push	AX
	push	CX
	push	DX

	mov	AX,[BP+4] ; push data in AX
	mov	CX,16

	cmp	AX,0
	jl	set_minus
	jmp	dispose_zero

set_minus:
	mov	DL,'-'
	push	AX
	mov	AH,2
	int	21h
	pop	AX
	neg	AX ; set positive

dispose_zero:
	mov	DH,0
	shl	AX,1
	jnc	no_carry_flag
	mov	DH,1
	jmp	print
no_carry_flag:
	dec	CX
	jnz	dispose_zero
	jmp	print_zero

printloop:
	mov	DH,0
	shl	AX,1
	jnc	print
	mov	DH,1
print:
	mov	DL,'0'
	add	DL,DH
	push	AX
	mov	AH,2
	int	21h
	pop	AX
	dec	CX
	jnz	printloop

exit:
	pop	DX
	pop	CX
	pop	AX
	pop	BP
	RET

print_zero:
	mov	DL,'0'
	mov	AH,2
	int	21h
	jmp	exit

PROC_PRINT_SIGNED_2 ENDP

Code	ENDS
END
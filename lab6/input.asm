PUBLIC	PROC_INPUT


Code	SEGMENT PUBLIC
	ASSUME	CS:Code

;returns number in CX
PROC_INPUT	PROC NEAR
	push	AX
	push	DX
	push	SI ; flag for sign
	mov	CX,0 ; CX contains result
	mov	SI,0

	mov	AH,1
	int	21h
	cmp	AL,13
	je	exit
	cmp	AL,2Dh
	jne	add_to_result ; if not minus
	mov	SI,1	      ; else

inputloop:
	mov	AH,1
	int	21h ; read symbol

	cmp	AL,13 ; end of input markers
	je	exit
	
add_to_result:
	sub	AL,'0'
	push	AX
	mov	AX,CX

	push	BX
	mov	BX,10
	mul	BX
	pop	BX
	
	mov	CX,AX
	pop	AX
	mov	AH,0
	add	CX,AX ;add entered number to existing
	jmp	inputloop
		
exit:
	cmp	SI,1
	jne	not_neg
	neg	CX
not_neg:
	pop	SI
	pop	DX
	pop	AX
	RET
PROC_INPUT	ENDP

Code	ENDS

END
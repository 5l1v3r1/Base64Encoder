; mov  	eax, StreamLen		 ; Размер входных данных
;	mov		ecx, 3
;	xor		edx, edx
;	div		ecx
;	add		eax, edx
;	mov		ecx, 4
;	mul		ecx
;	add		eax, 10
;	mov		CodedLen, eax
;	
;	invoke	LocalAlloc, LMEM_FIXED, CodedLen ; создаем буффер
;	mov		pCodedBuff, eax



	mov		eax, StreamLen		 ; Размер входных данных
	mov		ecx, 3
	xor		edx, edx
	div		ecx
	add		eax, edx
	mov		ecx, 4
	mul		ecx
	add		eax, 10
	mov		CodedLen, eax
	
	invoke	LocalAlloc, LMEM_FIXED, CodedLen ; создаем буффер
	mov		pCodedBuff, eax


Base64Encode proto StrIn:DWORD, StrOut:DWORD, InLen:DWORD

.data

	CodedBuff		dd 0
	CodedBuffLen	dd 0

.code

Base64Encode proc uses esi edi StrIn, StrOut, InLen:DWORD

	LOCAL	Fills	: DWORD
	LOCAL	OutLen	: DWORD
	
	mov		OutLen, 0
	
	; Calculating cycle count and '=' amount

	mov		eax, InLen
	mov		ecx, 3
	xor		edx, edx
	div		ecx
	
	.If edx != 0
		
		xor		edx, 3
		inc		eax
		
	.endif

	mov		Fills, edx
	
	mov		esi, StrIn
	mov		edi, StrOut
	mov		ecx, InLen
	xor		ebx, ebx		; shift counter
	mov		bl, 6
	
	@EncCycle:
		
		dec		ecx
		lodsb
		
		xchg	ah, al
		xchg	edx, eax
	@@:	
		inc		OutLen
		push	ecx
		mov		cl, bl
		shld	ax, dx, cl
		pop		ecx
		shl		al, 2
		shr		al, 2
		sub		bl, 2
		
		call	Base64EncTrans	; TRANSLATE
		
		.if			bh == 0ffh
			
			jmp		@EndCycle
			
		.elseif		bl == 0
			
			mov		bl, 8
			jmp		@b
			
		.elseif		ecx == 0 && Fills != 0
			
			xor		edx, edx
			dec		bh
			jmp		@b
			
		.endif
		
		xchg	dl, dh
		
	test	ecx, ecx
	jnz		@EncCycle
@EndCycle:


	;	Add '='
	
	mov		ecx, Fills
	test	ecx, ecx
	jz		@f
	mov		al, '='
	
	.Repeat
		
		inc		OutLen
		stosb
		
	.Untilcxz

@@:
	mov		eax, OutLen

	ret
	
Base64Encode endp

Base64EncTrans proc
	
	.if	al < 26
		
		add		al, 'A'
		
	.elseif	al < 52
		
		add		al, 'a' - 26
		
	.elseif	al < 62
		
		add		al, '0' - 52
		
	.elseif	al == 62
		
		mov		al, '+'
		
	.else
		
		mov		al, '/'
		
	.endif
	
	stosb
	
	ret

Base64EncTrans endp

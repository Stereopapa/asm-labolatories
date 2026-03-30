public find_max
public fir_filter

.code
find_max PROC
	push rbx
	push rsi
	
	mov rbx, rcx
	mov rcx, rdx
	test rcx, rcx
	jz fm_end

	mov rsi, 0 ;index in array
	mov rax, [rbx + 8*rsi] ;first element

@@:
	dec rcx
	jz fm_end
	inc rsi
	cmp rax, [rbx + 8*rsi]
	jge next
	mov rax, [rbx + 8*rsi]
next: jmp @b

fm_end:

	pop rsi
	pop rbx
	ret
find_max ENDP

fir_filter PROC
	; RCX = N
	; RDX = L
	; R8 = input
	; R9 = output
	; [RBP+48] = coefs
	; [RBP+56] = delay

	push rbp
	mov rbp,rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	
	
	;   r8 =	 ;input
	;   r9 =	 ;output
	mov r10, rcx ;N
	mov r11, rdx ;L
	mov r12, [RBP+56] ;delay pos pointer
	mov r13, r12 ;delay base adress
	mov r14, [RBP+48] ;coefs
	;   r15 =    ;accumulator
	;	rcx=	 ;Convolution loop counter
	;	rax=	 ;temp1

	y_loop:
		;Delay pointer adjustment
		
		cmp r12, r13
		ja outer_delay_in_memory_range
		lea r12, [r13+4*r11]
		outer_delay_in_memory_range:
		sub r12, 4
		;Saving another sample into delay
		mov eax, [r8]
		add r8, 4
		mov dword ptr [r12], eax

		xor r15, r15
		xor rcx, rcx
		sum:
			;calculating convolution
			;there is adventage to not use rcx for addr of delay pointer calc 
			;because if we adjust it by the end of convolution loop 
			;we end up on correct memory addr to add another sample to delay
			mov eax, [r12] 
			imul eax, [r14+4*rcx]
			add r15d, eax
			;Delay pointer adjustment
			add r12, 4
			lea rax, [r13+r11*4]
			cmp r12, rax
			jb inner_delay_in_memory_range
			mov r12, r13 ;if on the end go back to start
			inner_delay_in_memory_range:

			inc rcx
			cmp rcx, r11
			jb sum ;i = 0, rcx = 1, i=15, rcx = L, rcx !< L 
		;Saving output to memory
		mov [r9], r15d
		add r9, 4
		
		;outer loop iteration
		dec r10
		jnz y_loop

	

	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
fir_filter ENDP

END
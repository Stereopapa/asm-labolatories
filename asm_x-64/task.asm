public find_max

.code
find_max PROC
	push rbx
	push rsi
	
	mov rbx, rcx
	mov rcx, rdx
	test rcx, rcx
	jz end

	mov rsi, 0 ;index in array
	mov rax, [rbx + 8*rsi] ;first element

@@:
	dec rcx
	jz end
	inc rsi
	cmp rax, [rbx + 8*rsi]
	jge next
	mov rax, [rbx + 8*rsi]
next: jmp @b

end:

	pop rsi
	pop rbx
	ret
find_max ENDP
END
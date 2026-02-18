.686
.model flat

extern __write : Proc
extern __read : Proc
extern _malloc : PROC
extern _MessageBoxW@16 : PROC ;Windows 1250
extern _MessageBoxA@16 : PROC ;UTF-16
extern _GetSystemInfo@4 : PROC

;small procedures
public _xor_equivalence
public _u2_to_sign_magnitude_conversion
public _rcl_three_registers
public _be_to_le_without_bswap
public _counting_set_bits_in_eax
public _mul_without_mul
public _mul_with_lea
public _saving_adress_var_in_same_var
public _misc
public _sum_of_digit_in_decimal
public _utf16_bytes_am_cnvrtd_from_utf8
public _free_days_display
public _xor_swap
public _utf16_cp_basic_ascii
public _rcl_1024b_mem_reg
public _u2_to_negbinary
public _save_5_specfic_bits
public _fixed_point_display
public _decimal_to_bcd
public _cmp_decimal_in_ascii
public _num64b_in_32b_mode
public _printing_win1250_and_unicode
public _display_eax_hex_task
public _read_eax_hex_task


;medium procedures
public _difference
public _copy_array
public _message
public _find_min
public _find_max
public _encrypt
public _square
public _iteration
public _to_double
public _circle_area
public _weighted_avg
public _cpu_count
public _sorting
public _ASCII_to_UTF16
public _shl_128
public _decrement
public _swap_elements
public _abs_med
public _sort_array
public _apply_abs
public _print_array
public _calc_roots_of_quadratic
public _exp_x
public _harmonical_mean
public _exp_x_taylor_series

;larger procedures
public _latin_to_capital_windows1250_converter
public _display_arithmetic_sequence
.code


;small procedures
_xor_equivalence PROC
	mov edi, 10
	mov esi, 5

	not esi
	mov eax, edi
	and eax, esi
	not edi
	not esi
	and edi, esi
	or edi, eax

	ret
_xor_equivalence ENDP

_u2_to_sign_magnitude_conversion PROC
	push ebx

	rcl ebx,1
	jnc dodatnia
	neg ebx 
dodatnia:
	rcr ebx, 1
	

	pop ebx
	ret
_u2_to_sign_magnitude_conversion ENDP


_rcl_three_registers PROC
push ebx

mov ebx, 0AFFFFFFAh
mov edx, 0AFFFFFFAh
mov eax, 0AFFFFFFAh

bt edx, 31
rcl eax, 1
rcl ebx, 1
rcl edx, 1

pop ebx
ret
_rcl_three_registers ENDP


_be_to_le_without_bswap PROC
.data
wyrazenie dq 78564312h
.code
push ebx

mov ebx, OFFSET wyrazenie
mov ecx, 4
xor eax, eax
ptl:
	shl eax, 8
	mov al, [ebx]
	inc ebx
loop ptl

sub ebx, 4
mov [ebx], eax

pop ebx
ret
_be_to_le_without_bswap ENDP

_counting_set_bits_in_eax PROC
.code
mov ecx, 32
mov eax, 0FFFFFFFFh
mov edx, 0
ptl:
	shl eax, 1
	jnc dalej
	add edx, 1
	dalej:
loop ptl
ret
_counting_set_bits_in_eax ENDP

_mul_without_mul PROC
mov eax, 0Ah
mov edx, eax
shl edx, 3
shl eax, 1
add eax, edx
ret
_mul_without_mul ENDP

_mul_with_lea PROC
mov eax, 0Ah
lea eax, [eax+4*eax]
lea eax, [eax*2]
ret
_mul_with_lea ENDP


_saving_adress_var_in_same_var PROC
.data	
wskaznik dd ?
.code
	mov eax, OFFSET wskaznik
	mov [eax], eax
	ret
_saving_adress_var_in_same_var ENDP

_misc PROC
.data
linie dd 421,422,443,442,444,427,432
napis db 'informatyka', 0, 4 dup(?)
obszar dw 2 dup(?)
.code
	push ebp
	push ebx
	push esi
	push edi
	
	mov esi, (OFFSET linie) + 4
	mov ebx, 4
	mov edx, [ebx][esi] ; [ebx+esi]

	mov ecx, 12
	mov eax, 0
przepisz:
	mov al, napis[ecx-1]
	mov napis[ecx+3], al
loop przepisz

	push 0 ;MB_OK
	push OFFSET napis ;title
	lea eax, napis[3]
	push eax; tekst
	push 0 ;hwnd device handle
	call _MessageBoxA@16

	;saving address of instruction to memory
	mov dword PTR obszar, $	
	
	;dividing by -2 without IDIV
	mov eax, 16
	sar eax, 1
	pushf
	neg eax
	popf


	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_misc ENDP

_sum_of_digit_in_decimal PROC
push ebx
mov edx, 0
mov ecx, 0
mov eax, 7Dh
mov ebx, 10
ptl:
	mov edx, 0
	div ebx
	add cl, dl
	and eax, eax
jnz ptl
pop ebx
ret
_sum_of_digit_in_decimal ENDP


_utf16_bytes_am_cnvrtd_from_utf8 PROC
.data
znaki	db 123, 110
		db 0C2h, 128+8 
		db 0C2h, 128+9
		db 0E1h, 128+8, 128+8
		db 0E1h, 128+9, 128+9
		db 12, 2
		db 0C2h + 10h, 3
		db 0
.code
push esi
push edi
push ebx
xor ecx, ecx
xor eax, eax
xor esi, esi
ptl:
	mov al, znaki[esi]
	and al, al
	jz zakoncz
	inc ecx
	inc esi
	rol al, 1
	jc bajty2
	jmp ptl
bajty2:
	inc esi
	rol al, 2
	jc bajty3
	jmp ptl
bajty3:
	inc esi
	jmp ptl
zakoncz:

lea eax, [ecx*2]
pop ebx
pop edi
pop esi
ret
_utf16_bytes_am_cnvrtd_from_utf8 ENDP


_display_eax PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	sub esp, 32

	lea edi, [esp+32]
	xor ecx, ecx
	mov ebx, 10

	cmp eax, 0
	jge positive_display_eax
	push 1
	neg eax
	jmp @f

positive_display_eax:
	push 0
@@:
	dec edi
	inc ecx

	xor edx, edx
	div ebx
	add dl, '0'
	mov [edi], dl
	test eax, eax
	jnz @b

	pop edx
	test edx, edx
	jz end_display_eax
	dec edi
	inc ecx
	mov byte ptr [edi], '-'


end_display_eax:
	push ecx
	push edi
	push 1
	call __write
	add esp, 12
	
	add esp, 32
	pop edi
	pop ebx
	pop ebp
	ret

_display_eax ENDP

_read_eax PROC
.data
    decimal_base dd 10

.code
    push ebx
    push edi

    sub esp, 12
    mov edi, esp

   
    push 12                 
    push edi 
    push 0
    call __read
    add esp, 12

    mov eax, 0 
    mov ebx, edi
	
	mov cl, [ebx]
	cmp cl, '-'
	jne positive_read_eax
	push 1
	inc ebx
	jmp @f
positive_read_eax:
	push 0
@@:
    mov cl, [ebx]
    inc ebx
    cmp cl, 0AH          
    je newline_found
    
    sub cl, 30H           
    movzx ecx, cl
    mul decimal_base     
    add eax, ecx           
    jmp @b

newline_found:
	pop edx
	test edx, edx
	jz end_read_eax
	neg eax
end_read_eax:

    add esp, 12             
    pop edi
    pop ebx

    ret
_read_eax ENDP

_display_char PROC	
	lea eax, [esp+4]

	push 1
	push eax
	push 1
	call __write
	add esp, 12
	ret
_display_char ENDP

_free_days_display PROC
.data
year_free_days dd 0, 0, 0, 0
	dd 0, 0, 0, 0
	dd 0, 0, 0, 43800000h

.code
	push ebp
	mov ebp, esp
	push edi
	push ebx
	push esi


	mov ebx, OFFSET year_free_days
	mov ecx, 12
	
	mov edi, ecx
	mov ebx, [ebx+edi*4-4]
	mov esi, 0

	mov ecx, 32
	ptl:
	inc esi
	shr ebx, 1
	jnc dalej

	push ecx
	mov eax, esi
	call _display_eax

	mov eax, '.'
	push eax
	call _display_char
	pop eax

	mov eax, edi
	call _display_eax

	mov eax, 0Ah
	push eax
	call _display_char
	pop eax

	pop ecx

dalej:
	loop ptl

	pop esi
	pop ebx
	pop edi
	pop ebp
	ret
_free_days_display ENDP

_xor_swap PROC
mov edx, 10
mov eax, 2
xor eax, edx ;eax = eax(+)edx
xor edx, eax ;edx = edx(+)eax(+)edx = eax
xor eax, edx ; eax = eax(+)edx(+)edx = edx
ret
_xor_swap ENDP



;procedure performs copying from utf16 input only 
;chars that are basic ascii code
;it also creates 8-bit control sum of xors of every
;coppied char
_utf16_cp_basic_ascii PROC
.data
input dw 127, 13, 0FFh, '0', '2', 'A', 0DEADh
output dw 7 dup(?)
.code
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, OFFSET input
mov edi, OFFSET output
xor eax, eax
xor edx, edx


ptl:
	mov ax, [esi]
	cmp eax, 0DEADh
	je zakoncz
	add esi ,2
	cmp eax, 7Fh
	ja ptl
	mov [edi], ax
	add edi, 2
	xor dl, al
	jmp ptl
zakoncz:

pop edi
pop esi
pop ebx
pop ebp
ret
_utf16_cp_basic_ascii ENDP

_rcl_1024b_mem_reg PROC
.data
rejestr1024 dd 32 dup(0F000000Fh)
.code
push ebp
mov ebp, esp
push ebx
push esi

xor esi, esi
mov ecx, 32

mov  eax, rejestr1024[124]
bt eax, 31

ptl:
	mov eax, rejestr1024[esi]
	rcl eax, 1
	mov rejestr1024[esi], eax
	lea esi, [esi+4]
loop ptl

pop esi
pop ebx
pop ebp
ret
_rcl_1024b_mem_reg ENDP


_u2_to_negbinary PROC
mov eax, -9
xor edx, edx
xor ecx, ecx


ptl:
	sar eax, 1
	rcr edx, 1
	inc ecx
	neg eax
	and eax, eax
	jnz ptl

rol edx, cl
ret
_u2_to_negbinary ENDP

;procedure takes 5 LS bits from al
;then saves it in memory starting from edi
;starting from bit number given in cl reg
;other bits in edi and edi + 1 stays the same
_save_5_specfic_bits PROC
.data
blob dd 0
.code
	push edi

	mov edi, (OFFSET blob) + 1
	mov al, 0F8h
	mov cl, 3

	and ax, 1Fh
	mov dx, [edi]
	ror dx, cl
	shr dx, 5
	shl dx, 5
	or dx, ax
	rol dx, cl
	mov word PTR [edi], dx

	pop edi
	ret
_save_5_specfic_bits ENDP

;al contains MS 2^-1 to LS 2^-8 this program
;display this fraction
_fixed_point_display PROC
	push ebp
	mov ebp, esp
	sub esp, 5
	push edi
	push ebx
	
	
	lea edi, [ebp-5]
	mov word ptr [edi], '.0'
	add edi, 2
	mov eax, 0C0h
	mov ebx, 10
	mov ecx, 3
	xor edx, edx
	ptl:
		mul bl
		mov dl, ah
		add dl, '0'
		mov byte ptr[edi], dl
		inc edi
	loop ptl

	push 5
	lea edi ,[ebp-5]
	push edi
	push 1
	call __write
	add esp, 12


	pop ebx
	pop edi
	add esp, 5
	pop ebp
	ret
_fixed_point_display ENDP

_decimal_to_bcd PROC
	push ebp
	mov ebp, esp
	sub esp, 3
	push edi

	lea edi, [ebp-3]
	mov al, 113
	mov ecx, 8
	movzx eax, al
	xor dx, dx
	ptl:
		mov dl, ah
		and dl, 0Fh
		cmp dl, 4
		jbe dalej1
		add eax, 300h
	dalej1:
		mov dl, ah
		shr dl, 4
		cmp dl, 4
		jbe dalej2
		add eax, 3000h
	dalej2:
	shl eax, 1
	loop ptl

	shr eax, 8
	ror eax, 8

	add al, '0'
	mov byte PTR[edi], al
	inc edi
	and al, 0h

	rol eax, 4
	add al, '0'
	mov byte PTR[edi], al
	inc edi
	and al, 0h

	rol eax, 4
	add al, '0'
	mov byte PTR[edi], al
	inc edi
	
	lea edi, [ebp-3]
	push 3
	push edi
	push 1
	call __write
	add esp, 12



	pop edi
	add esp, 3
	pop ebp
_decimal_to_bcd ENDP

_cmp_decimal_in_ascii PROC
.data
liczba1 db '2', '3', '4', '5', 0
liczba2 db '2', '3', '4', '5', 0, 0
.code
mov esi, OFFSET liczba1
mov edi, OFFSET liczba2
xor eax, eax
xor edx, edx
ptl:
	mov al, [esi]
	mov dl, [edi]
	inc esi
	inc edi
	or al, al
	jz zero1
	or dl, dl
	jz zero2
	jmp dalej
zero1:
	or dl, dl
	jz zakoncz
	cmp dl, 0FFh
	jmp zakoncz
zero2:
	cmp al, 0
	jmp zakoncz
dalej:
	sub al, '0'
	sub dl, '0'
	
	cmp al, dl
	jne zakoncz
	jmp ptl
zakoncz:
	ret
_cmp_decimal_in_ascii ENDP


_num64b_in_32b_mode PROC
.data
dw1 dword 0
dw0 dword 0

.code
	push ebp
	mov ebp,esp
	sub esp, 48
	push ebx
	push edi
	push esi
	
	mov eax, [ebp+8];L
	mov dw0, eax
	mov eax, [ebp+12];H
	mov dw1, eax
	
	mov ebx, 10 ;
	lea edi, [ebp-48]

	;saving values
	ptl:
		mov edx, 0
		mov eax, dw1
		div ebx 
		mov dw1, eax

		mov eax, dw0 
		div ebx
		mov dw0, eax

		add dl, '0'
		mov byte PTR[edi], dl

		inc edi
 		add eax, dw1
	jnz ptl

	mov esi, edi
	dec esi
	add edi, 48
	sub edi, ebp
	mov ecx, edi 

	lea edi, [ebp-24]
	odwrocCiag:
		mov eax, [esi]
		mov [edi], eax
		dec esi
		inc edi
	loop odwrocCiag
	
	mov byte PTR[edi], 0
	lea edi, [ebp-24]

	push 0
	push edi
	push edi
	push 0
	call _MessageBoxA@16

	pop esi
	pop edi
	pop ebx
	add esp, 48
	pop ebp
	ret
_num64b_in_32b_mode ENDP

_printing_win1250_and_unicode PROC
.data
    title_unicode dw 'U','n','i','c','o','d','e',' ','F','o','r','m','a','t', 0
    text_unicode  dw 'E','v','e','r','y',' ','c','h','a','r','a','c','t','e','r',' '
                  dw 'u','s','e','s',' ','1','6',' ','b','i','t','s','.', 0
    title_win1250 db 'Windows-1250 Standard', 0
    text_win1250  db 'Every character uses 8 bits.', 0

.code
    push 0
    push OFFSET title_win1250
    push OFFSET text_win1250
    push 0
    call _MessageBoxA@16

    push 0
    push OFFSET title_unicode
    push OFFSET text_unicode
    push 0
    call _MessageBoxW@16

    ret
_printing_win1250_and_unicode ENDP

_display_eax_hex PROC
.data
decoder db '0123456789ABCDEF'
.code
	push ebp
	mov ebp, esp
	sub esp, 10
	push ebx
	push edi
	push esi
	;decoding
	lea edi, [ebp-10]
	mov ecx, 8
	mov esi, 1
@@:
	dec ecx
	rol eax, 4
	mov ebx, eax
	and ebx, 0Fh
	jnz write_eax_hex_add_char
	test esi, esi
	jz write_eax_hex_add_char
	test ecx, ecx
	jz write_eax_only_zero
	jmp @b
write_eax_hex_add_char:
	mov esi, 0
	mov dl, decoder[ebx]
	mov [edi], dl
	inc edi 
	test ecx, ecx
	jnz @b
	jmp write_eax_hex_end

write_eax_only_zero:
	mov byte ptr [edi], '0'
	inc edi

write_eax_hex_end:
	;displaying result
	mov ecx, edi
	add ecx, 10
	sub ecx, ebp
	lea edi, [ebp-10]
	push ecx
	push edi
	push 1
	call __write
	add esp, 12

	
	pop esi
	pop edi
	pop ebx
	add esp, 10
	pop ebp
	ret
_display_eax_hex ENDP

_display_eax_hex_task PROC

.data
mess_in_decimal db 'type decimal number', 0AH
mess_in_decimal_len dd $ - OFFSET mess_in_decimal
.code
	;reading user input
	push mess_in_decimal_len
	push OFFSET mess_in_decimal
	push 1
	call __write
	add esp, 12
	call _read_eax
	call _display_eax_hex
	ret
_display_eax_hex_task ENDP

_read_eax_hex PROC
	push ebx
    push esi
    push edi
    push ebp
    sub esp, 12
    mov esi, esp

    push 10
    push esi
    push 0
    call __read
    add esp, 12

    xor eax, eax

read_eax_hex_start_conv:
    mov dl, [esi]
    inc esi
    cmp dl, 10
    je read_eax_hex_done
    cmp dl, '0'
    jb read_eax_hex_start_conv
    cmp dl, '9'
    ja read_eax_hex_check_more
    sub dl, '0'

read_eax_hex_append:
    shl eax, 4
    or al, dl
    jmp read_eax_hex_start_conv

read_eax_hex_check_more:
    cmp dl, 'A'
    jb read_eax_hex_start_conv
    cmp dl, 'F'
    ja read_eax_hex_check_more_2
    sub dl, 'A' - 10
    jmp read_eax_hex_append

read_eax_hex_check_more_2:
    cmp dl, 'a'
    jb read_eax_hex_start_conv
    cmp dl, 'f'
    ja read_eax_hex_start_conv
    sub dl, 'a' - 10
    jmp read_eax_hex_append

read_eax_hex_done:
    add esp, 12
    pop ebp
    pop edi
    pop esi
    pop ebx
    ret
_read_eax_hex ENDP

_read_eax_hex_task PROC
.data
	mess_in_hex db 'type hex value', 0AH
	mess_in_hex_len dd $ - mess_in_hex
.code
	push mess_in_hex_len
	push OFFSET mess_in_hex
	push 1
	call __write
	add esp, 12
	call _read_eax_hex
	call _display_eax
	ret
_read_eax_hex_task ENDP

;medium procedures
_difference PROC
.data

.code
push ebp
mov ebp, esp
push ebx
mov ebx, [ebp+8]  ; minuend address
mov eax, [ebx]
mov ebx, [ebp+12] ; address of subtrahend address
mov ebx, [ebx]    ; subtrahend address
sub eax, [ebx]

pop ebx
pop ebp
ret
_difference ENDP

_copy_array PROC
push ebp
mov ebp, esp
push esi
push edi

mov esi, [ebp+8]
mov ecx, [ebp+12]

push ecx
call _malloc
pop ecx
and eax, eax
jz finish
push eax
mov edi, eax
loop_start:
	mov eax, [esi]
	add esi, 4
	bt eax, 0
	jnc even_num
	mov dword ptr [edi], 0
	jmp next
even_num:
	mov [edi], eax
next:
	add edi, 4
	loop loop_start

finish:
pop eax
pop edi
pop esi
pop ebp
ret
_copy_array ENDP

_message PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, [ebp+8]
xor ecx, ecx
xor ebx, ebx
count_loop:
	inc ecx
	mov al, [esi][ebx]
	inc ebx
	cmp al, 0
	jne count_loop ; counting characters

add ecx, 5
push ecx
call _malloc
pop ecx
sub ecx, 5

and eax, eax
jz finish_msg

mov edi, eax
xor ebx, ebx
copy_loop:
	mov dl, [esi][ebx]
	mov [edi][ebx], dl
	inc ebx
loop copy_loop
dec ebx
; Appending "Fail." (Replacement for "Blad.") to match length
mov byte ptr [edi][ebx], 'F' 
inc ebx
mov byte ptr [edi][ebx], 'a'
inc ebx
mov byte ptr  [edi][ebx], 'i'
inc ebx
mov byte ptr  [edi][ebx], 'l'
inc ebx
mov byte ptr  [edi][ebx], '.'
inc ebx
mov byte ptr  [edi][ebx], 0


finish_msg:
pop edi
pop esi
pop ebx
pop ebp
ret
_message ENDP

_find_min PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]

	mov eax, ebx
	mov edx, [ebx]
	add ebx, 4
	dec ecx
loop_start:
	cmp edx, [ebx]
	jle next
	mov edx, [ebx]
	mov eax, ebx
next:
	add ebx, 4
	loop loop_start

	pop ebx
	pop ebp
	ret
_find_min ENDP

_find_max PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]

	mov eax, ebx
	mov edx, [ebx]
	add ebx, 4
	dec ecx
loop_start:
	cmp edx, [ebx]
	jge next
	mov edx, [ebx]
	mov eax, ebx
next:
	add ebx, 4
	loop loop_start

	pop ebx
	pop ebp
	ret
_find_max ENDP

_encrypt PROC
	push ebp
	mov ebp, esp
	push esi
	push ebx

	mov esi, [ebp+8] ; text address
	xor ebx, ebx
	xor ecx, ecx
length_loop:
	mov al, [esi][ebx]
	inc ecx
	inc ebx
	and al, al
	jnz length_loop

	dec ecx
	mov edx, 52525252h
	xor ebx, ebx
encrypt_loop:
	mov al, [esi]
	xor al, dl
	mov [esi], al
	inc esi


	mov eax, edx
	and eax, 80000000h
	mov ebx, edx
	and ebx, 40000000h
	shl ebx, 1
	xor eax, ebx
	rcl eax, 1
	rcl edx, 1
	loop encrypt_loop

	pop ebx
	pop esi
	pop ebp
	ret
_encrypt ENDP

_square PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp+8]
	cmp eax, 1 ; a=1
	je finish_sq
	and eax, eax ; a=0
	je finish_sq
	
	mov edx, eax
	add edx, edx
	add edx, edx
	sub edx, 4 ; 4*a-4
	mov ebx, edx
	sub eax, 2 ; a-2
	push eax
	call _square
	add esp, 4
	add eax, ebx

finish_sq:
	pop ebx
	pop ebp
	ret
_square ENDP

_iteration PROC
push ebp
mov ebp, esp
mov al, [ebp+8]
sal al, 1
jc terminate
inc al
push eax
call _iteration
add esp, 4
pop ebp
ret
terminate:
rcr al, 1
pop ebp
ret
_iteration ENDP


_to_double PROC
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov esi, [ebp+8]  ; float address
	mov edi, [ebp+12] ; double address
	; float 1S8E23M, double 1S11E52M (S=Sign, E=Exponent, M=Mantissa)
	; [edi+4]1S11E20M, [edi]32M (M split)
	mov eax, [esi]
	rol eax, 9 ; al E+127
	mov dl, al
	sub dl, 127
	movsx dx, dl
	add dx, 1023 ; dx E+1023
	shl edx, 21
	bt eax, 8 ; S
	rcr edx, 1 ; edx 1S11E0M
	mov ecx, eax
	; eax 23M1S8E
	shr eax, 12 ; 12U20M
	xor edx, eax; 1S11E20M
	mov [edi+4], edx

	shl ecx, 20 ; 3M1S8E
	and ecx, 70000000h ; 29U3M
	mov [edi], ecx


	pop edi
	pop esi
	pop ebp
	ret
_to_double ENDP

_circle_area PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]; float address

	finit
	fld dword ptr [ebx]; r
	fst st(1); r, r
	fmulp ; r^2
	fldpi ; pi, r^2
	fmulp ; pi*r^2
	fstp dword ptr [ebx]

	pop ebx
	pop ebp
	ret
_circle_area ENDP

_weighted_avg PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	xor ebx, ebx
	mov ecx, [ebp+8]  ; n
	mov esi, [ebp+12] ; array
	mov edi, [ebp+16] ; weights

	finit
	fldz ; 0
	fldz ; sumNum, sumWeights
loop_avg:
	fld dword ptr [esi][ebx]; xi, sumNum, sumWeights
	fld dword ptr [edi][ebx]; wi, xi, sumNum, sumWeights
	fadd st(3), st(0); wi, xi, sumNum, sumWeights+wi
	fmul ; wi*xi, sumNum, sumWeights+wi
	fadd ; sumNum+wi*xi, sumWeights+wi
	add ebx, 4
	loop loop_avg
	fxch st(1) ; sumWeights, sumNum
	fdiv ; sumNum/sumWeights

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_weighted_avg ENDP

_cpu_count PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, 40
	push eax
	call _malloc
	add esp, 4 ; systemInfo struct malloc
	mov ebx, eax

	push ebx
	call _GetSystemInfo@4
	
	mov eax, [ebx+20]

	pop ebx
	pop ebp
	ret
_cpu_count ENDP



_sorting PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]
	mov ecx, [ebp+12]

	dec ecx
	mov ebx, ecx
	dec ebx

sort_outer:
	push ecx
	push ebx
sort_inner:
	mov eax, [esi+8*ebx]    ; L1
	mov edx, [esi+8*ebx+4]  ; H1
	mov ebp, [esi+8*ebx+8]  ; L2
	mov edi, [esi+8*ebx+12] ; H2

	cmp edx, edi
	ja no_swap
	jb swap
	cmp eax, ebp
	jae no_swap
swap:
	; swapping places
	mov [esi+8*ebx], ebp    ; L1
	mov [esi+8*ebx+4], edi  ; H1
	mov [esi+8*ebx+8], eax  ; L2
	mov [esi+8*ebx+12], edx ; H2
no_swap:
	dec ebx
	loop sort_inner
	pop ebx
	pop ecx
	loop sort_outer

	mov eax, [esi]   ; Low part result
	mov edx, [esi+4] ; High part result

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_sorting ENDP

_ASCII_to_UTF16 PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	mov al, 122
	mov dl, -122
	cmp al, dl
	setle al
	mov ax, 0
	bts ax, 0
	btr ax, 2
	btc ax, 2
	bt ax, 2

	mov esi, [ebp+8]
	mov ecx, [ebp+12]
	lea ecx, [ecx*2]

	push ecx
	call _malloc
	add esp, 4
	mov ecx, [ebp+12]

	mov edi, eax

loop_utf:
	mov dl, byte ptr [esi]
	movzx dx, dl
	mov [edi], dx
	
	inc esi
	add edi, 2
	loop loop_utf

	pop edi
	pop esi
	pop ebp
	ret
_ASCII_to_UTF16 ENDP

_shl_128 PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp+8]  ; address of first element
	mov ecx, [ebp+12] ; amount of bits

loop_shl:

	mov eax, [ebx];0
	mov edx, [ebx+4];1
	shl eax, 1
	rcl edx, 1
	mov [ebx], eax;0
	mov [ebx+4], edx;1

	mov eax, [ebx+8];3
	mov edx, [ebx+12];4
	rcl eax, 1
	rcl edx, 1
	mov [ebx+8], eax;3
	mov [ebx+12], edx;4
	loop loop_shl

	pop esi
	pop edi
	pop ebx
	ret
_shl_128 ENDP

_decrement PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov ebx, [ebx]
	mov eax, [ebx]
	inc eax
	mov [ebx], eax


	pop ebx
	pop ebp
	ret
_decrement ENDP

_print_array PROC

push ebp
mov ebp, esp
push ebx
push esi

mov ecx, [ebp+12]
mov esi, [ebp+8]

@@:
	mov eax, [esi]
	push ecx
	call _display_eax
	push ' '
	call _display_char
	add esp, 4

	add esi, 4
	pop ecx
loop @b

push 0AH
call _display_char
add esp, 4
	
pop esi
pop ebx
pop ebp
ret
_print_array ENDP

_abs_med PROC
	
	push ebp
	mov ebp, esp
	push edx
	push ecx

	push [ebp+12]
	push [ebp+8]
	call _print_array
	add esp, 8

	push [ebp+12]
	push [ebp+8]
	call _apply_abs
	add esp, 8

	push [ebp+12]
	push [ebp+8]
	call _sort_array
	add esp, 8

	mov edx, 0
	mov eax, [ebp+12]
	mov ebx, 2
	div ebx
	mov ecx, eax

	mov ebx, [ebp+8]
	mov eax, [ebx]

	; middle value logic

middle_search_loop:
	add ebx, 4
	mov eax, [ebx]
	loop middle_search_loop

	cmp edx, 0
	je even_count
	jmp done_median
even_count:
	add eax, [ebx-4]
	mov ebx, 2
	div ebx
done_median:
	
	push eax
	push [ebp+12]
	push [ebp+8]
	call _print_array
	add esp, 8
	pop eax

	pop ecx
	pop edx
	pop ebp
	ret
_abs_med ENDP

_swap_elements PROC
	push ebp
	mov ebp, esp
	push ebx
	push edx
	push ecx

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	dec ecx
swap_loop:
	mov eax, [ebx]
	cmp eax, [ebx+4] ; next element in array
	jle skip_swap
	; swapping elements
	mov edx, [ebx+4]
	mov [ebx], edx
	mov [ebx+4], eax
skip_swap:
	add ebx, 4 ; next element in array
	loop swap_loop
	pop ecx
	pop edx
	pop ebx
	pop ebp
	ret
_swap_elements ENDP

_sort_array PROC
	push ebp
	mov ebp, esp
	push ebx
	push ecx

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]

sort_loop:
	push ecx
	push ebx
	call _swap_elements
	add esp, 8
	dec ecx
	cmp ecx, 1
	ja sort_loop ; for(n; n>1; n--)

	pop ecx
	pop ebx
	pop ebp
	ret
_sort_array ENDP

_apply_abs PROC
	push ebp
	mov ebp, esp
	push edx
	push ecx

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	dec ecx
	mov edx, 80000000h
abs_loop:
	mov eax, [ebx]
	mov edx, 80000000h
	and edx, eax
	cmp edx, 0
	jne negative_found
	jmp abs_done
negative_found:
	neg eax
abs_done:
	mov [ebx], eax
	add ebx, 4 ; next element in array
	loop abs_loop
	pop ecx
	pop edx
	pop ebp
	ret
_apply_abs ENDP

_calc_roots_of_quadratic PROC
.data
four dd 4.0
.code
	;roots pointer [ebp+8]
	;a [ebp+12] b [ebp+16] c [ebp+20]
	push ebp
	mov ebp, esp
	push ebx
	mov ebx, [ebp+8]

	finit
	fld dword ptr [ebp+12]
	fld dword ptr [ebp+16]
	fst st(2)
	; b, a, b
	fmul st(0), st(0)
	mov eax, 4
	fld four
	; 4, b^2, a, b
	fmul st(0), st(2)
	fmul dword ptr [ebp+20]
	; 4*a*c, b^2, a, b
	fsubp st(1), st(0)
	; b^2-4*a*c, a, b
	fldz 
	fcomi st(0), st(1)
	fstp st(0)
	ja negative_discriminant
	;b^2-4ac, a, b
	fxch st(1)
	;a, b^2-4ac, b
	fadd st(0), st(0)
	fstp st(3)
	;b^2-4ac, b, 2*a
	fsqrt
	fst st(3)
	;sqrtdel, b, 2*a, sqrtdel
	fchs
	fsub st(0), st(1)
	fdiv st(0), st(2)
	fstp dword ptr [ebx]
	;b, 2*a, sqrtdel
	fchs
	fadd st(0), st(2)
	fdiv st(0), st(1)
	fstp dword ptr [ebx+4]
	;czyszcesnie stous
	fstp st(0)
	fstp st(0)
	
negative_discriminant:
	pop ebx
	pop ebp
	ret
	
_calc_roots_of_quadratic ENDP

_exp_x PROC
	push ebp
	mov ebp, esp
	;x: [ebp+8]

	finit
	;e^x = 2^x*log2e = 2^[x*log2e]u*2^[x*log2e]c = 2^[x*log2e]c * ((2^[x*log2e]u-1)+1)
	; = fscale(f2xm1([xlog2e]u)+1 (st(0)), [xlog2e]c (2^st(1)) )
	fldl2e
	fld dword ptr [ebp+8]
	;x, log2e
	fmulp st(1), st(0)
	;x*log2e
	fst st(1)
	frndint ;st(1)
	;[x*log2e]c, x*log2e
	
	fsub st(1), st(0)
	;[x*log2e]c, [x*log2e]u
	fxch ;
	;[x*log2e]u, [x*log2e]c
	f2xm1 
	;2^[x*log2e]u+1, [x*log2e]c
	fld1
	faddp st(1), st(0)
	fscale
	fstp st(1)

	pop ebp
	ret
_exp_x ENDP

_harmonical_mean PROC
.data
one dd 1.0
.code
	push ebp
	mov ebp, esp
	push ebx
	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	finit
	
	push ecx
	fild dword ptr[esp]
	add esp, 4
	fldz
	;0, n
@@:
	fld one
	fld dword ptr[ebx]
	;ai, 1, sum, n
	fdivp st(1), st(0) 
	;1/ai, sum, n
	faddp st(1), st(0)
	;sum, n
	add ebx, 4
	loop @b
	fdivp st(1), st(0)
	;n/s
	pop ebx
	pop ebp
	ret
_harmonical_mean ENDP

_exp_x_taylor_series PROC
push ebp
mov ebp, esp
mov ecx , 2
finit

fld dword ptr [ebp+8]
fld1
fld1

;sum, silnia, x^(n-1)
@@:
	fld st(2);
	;x^(n-1), sum, factorial, x^(n-1)
	fdiv st(0), st(2)
	;x^(n-1)/silnia, factorial, silnia, x^(n-1)
	faddp st(1), st(0);
	;sum, factorial, x^(n-1)
	fld dword ptr [ebp+8]
	;x, sum, factorial, x^(n-1)
	fmulp st(3), st(0)
	;sum, factorial, x^(n-1)*x
	push ecx
	fild dword ptr [esp]
	add esp ,4
	;n-1, sum, factorial, x^(n-1)*x
	fmulp st(2), st(0)
	;sum, factorial*(n-1), x^(n-1)*x
	inc ecx
	cmp ecx, 20
	jbe @b
	fstp st(1)
	fstp st(1)
pop ebp
ret
_exp_x_taylor_series ENDP

_average PROC
	push ebp
	mov ebp, esp
	push ebx
	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	finit
	push ecx
	fldz
	ptl:
	fld qword ptr[ebx]
	faddp st(1), st(0)
	add ebx, 8
	loop ptl

	fild dword ptr [esp]
	add esp, 4
	fdivp st(1), st(0)

	pop ebx
	pop ebp
	ret
_average ENDP

_variance PROC
.data
intermediate_result dq 0.0
.code
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	finit

	push ecx
	fldz
	ptl:
	fld qword ptr[ebx]
	fld qword ptr[ebx]
	fmulp st(1), st(0)
	faddp st(1), st(0)
	add ebx, 8
	loop ptl

	fild dword ptr [esp]
	pop ecx
	fdivp st(1), st(0)

	fstp intermediate_result

	mov ebx, [ebp+8]

	push ecx
	push ebx
	call _average
	add esp, 8

	fst st(1)
	fmulp st(1), st(0)
	fld intermediate_result
	fxch st(1)
	fsubp st(1), st(0)

	pop ebx
	pop ebp
	ret
_variance ENDP

;larger procedures
_latin_to_capital_windows1250_converter PROC
.data
    win_title       db 'Windows-1250 Conversion', 0
    prompt_msg      db 10, 'Please write some text and press Enter.', 10
    prompt_end      db ?
    
    input_buffer    db 80 dup(?)        ; Buffer for console (Latin-2)
    ansi_buffer     db 80 dup(?)        ; Buffer for MessageBox (Win-1250)
    char_count      dd ?

.code
    ; --- Displaying the initial prompt ---
    mov ecx, (OFFSET prompt_end) - (OFFSET prompt_msg)
    push ecx
    push OFFSET prompt_msg
    push 1                              ; Stdout handle
    call __write
    add esp, 12

    ; --- Reading user input from keyboard ---
    push 80                             ; Max bytes to read
    push OFFSET input_buffer
    push 0                              ; Stdin handle
    call __read
    add esp, 12

    ; --- Initializing conversion loop ---
    ; __read returns number of characters in EAX
    mov char_count, eax
    mov ecx, eax                        ; Loop counter
    mov esi, 0                          ; Index register

conversion_loop:
    mov dl, input_buffer[esi]
    mov ansi_buffer[esi], dl            ; Default copy before conversion
    mov al, dl
    
    cmp dl, 128                         ; Check if character is standard ASCII
    jb basic_ascii_check

    ; --- Convert Polish Uppercase (Latin-2 to Windows-1250) ---
    cmp dl, 164 ; • (Latin-2)
    mov bl, 165 ; • (Win-1250)
    je handle_uppercase_polish

    cmp dl, 143 ; ∆ (Latin-2)
    mov bl, 198 ; ∆ (Win-1250)
    je handle_uppercase_polish

    cmp dl, 168 ;   (Latin-2)
    mov bl, 202 ;   (Win-1250)
    je handle_uppercase_polish

    cmp dl, 157 ; £ (Latin-2)
    mov bl, 163 ; £ (Win-1250)
    je handle_uppercase_polish

    cmp dl, 227 ; — (Latin-2)
    mov bl, 209 ; — (Win-1250)
    je handle_uppercase_polish

    cmp dl, 224 ; ” (Latin-2)
    mov bl, 211 ; ” (Win-1250)
    je handle_uppercase_polish

    cmp dl, 151 ; å (Latin-2)
    mov bl, 140 ; å (Win-1250)
    je handle_uppercase_polish

    cmp dl, 141 ; è (Latin-2)
    mov bl, 143 ; è (Win-1250)
    je handle_uppercase_polish

    cmp dl, 189 ; Ø (Latin-2)
    mov bl, 175 ; Ø (Win-1250)
    je handle_uppercase_polish

    mov bl, dl

handle_uppercase_polish:
    cmp bl, dl
    je check_lowercase_start
    mov ansi_buffer[esi], bl            ; Update ANSI buffer with correct Win-1250 code

    ; AL register stores Latin-2 codes, BL stores Win-1250 codes
check_lowercase_start:
    cmp dl, 165 ; π
    mov al, 164 ; Target: • (Latin-2)
    mov bl, 165 ; Target: • (Win-1250)
    je handle_lowercase_polish

    cmp dl, 134 ; Ê
    mov al, 143 ; Target: ∆ (Latin-2)
    mov bl, 198 ; Target: ∆ (Win-1250)
    je handle_lowercase_polish

    cmp dl, 169 ; Í
    mov al, 168 ; Target:   (Latin-2)
    mov bl, 202 ; Target:   (Win-1250)
    je handle_lowercase_polish

    cmp dl, 136 ; ≥
    mov al, 157 ; Target: £ (Latin-2)
    mov bl, 163 ; Target: £ (Win-1250)
    je handle_lowercase_polish

    cmp dl, 228 ; Ò
    mov al, 227 ; Target: — (Latin-2)
    mov bl, 209 ; Target: — (Win-1250)
    je handle_lowercase_polish

    cmp dl, 162 ; Û
    mov al, 224 ; Target: ” (Latin-2)
    mov bl, 211 ; Target: ” (Win-1250)
    je handle_lowercase_polish

    cmp dl, 152 ; ú
    mov al, 151 ; Target: å (Latin-2)
    mov bl, 140 ; Target: å (Win-1250)
    je handle_lowercase_polish

    cmp dl, 171 ; ü
    mov al, 141 ; Target: è (Latin-2)
    mov bl, 143 ; Target: è (Win-1250)
    je handle_lowercase_polish

    cmp dl, 190 ; ø
    mov al, 189 ; Target: Ø (Latin-2)
    mov bl, 175 ; Target: Ø (Win-1250)
    je handle_lowercase_polish

    mov al, dl

handle_lowercase_polish: 
    cmp dl, al
    je skip_char_update
    mov ansi_buffer[esi], bl            ; Store Win-1250 uppercase in ANSI buffer
    mov input_buffer[esi], al           ; Store Latin-2 uppercase in Input buffer
    

basic_ascii_check:
    cmp dl, 'a'                         ; Standard lowercase check (a-z)
    jb skip_char_update
    cmp dl, 'z'
    ja skip_char_update
    sub dl, 20h                         ; Standard ASCII uppercase conversion
    mov input_buffer[esi], dl
    mov ansi_buffer[esi], dl
    
skip_char_update:
    inc esi
    dec ecx
jnz conversion_loop


    ; --- Displaying the converted result in Console ---
    push char_count
    push OFFSET input_buffer
    push 1
    call __write
    add esp, 12

    ; --- Displaying the result in a Windows MessageBox ---
    push 0                              ; MB_OK
    push OFFSET win_title
    push OFFSET ansi_buffer
    push 0                              ; HWND Desktop
    call _MessageboxA@16

_latin_to_capital_windows1250_converter ENDP

;
;it takes as arguments string and displays it
_display_info PROC

_display_info ENDP

_display_arithmetic_sequence PROC
.data
	mess_n db "type number of terms",0Ah
	mess_n_len equ $ - mess_n
	mess_a1 db "type fisrt term", 0Ah
	mess_a1_len equ $ - mess_a1
	mess_r db "type common difference",  0AH
	mess_r_len equ $ - mess_r
.code
	push ebx
	push esi

	push mess_n_len
	push OFFSET mess_n
	push 1
	call __write
	add esp, 12
    call _read_eax
    mov ecx, eax

	push ecx

	push mess_r_len
	push OFFSET mess_r
	push 1
	call __write
	add esp, 12
    call _read_eax
    mov ebx, eax 
    
	push mess_a1_len
	push OFFSET mess_a1
	push 1
	call __write
	add esp, 12
    call _read_eax

	push eax
	push 0AH
	call _display_char
	add esp, 4
	pop eax

	pop ecx


    cmp ecx, 0
    je sequence_end

display_loop:
    push eax                
    push ecx                
    push ebx                
    
    call _display_eax 
	push 0AH
	call _display_char
	add esp, 4

    pop ebx
    pop ecx
    pop eax
    
    add eax, ebx            
    loop display_loop

sequence_end:

	pop esi
	pop ebx
	ret
_display_arithmetic_sequence ENDP

END
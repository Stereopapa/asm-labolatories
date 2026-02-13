.686
.model flat

extern __write : Proc
extern __read : Proc
extern _MessageBoxW@16 : PROC ;Windows 1250
extern _MessageBoxA@16 : PROC ;UTF-16

public _test
public _zadanie_3
public _zadanie_10
public _zadanie_18
public _zadanie_19
public _zadanie_21
public _zadanie_22
public _zadanie_23
public _zadanie_27
public _zadanie_30
public _zadanie_31
public _zadanie_32
public _zadanie_33
public _zadanie_34
public _zadanie_35
public _zadanie_35_1
public _zadanie_2_1
public _zadanie_3_1
public _zadanie_1_2
public _zadanie_3_2
public _zadanie_37
public _zadanie_37_1
public _zadanie_37_2
public _zadanie_38
public _zadanie_39
public _zadanie_40
public _zadanie_41

.code
_test PROC
pushf
mov eax, [esp]
bts eax, 21
mov [esp], eax
popfd
pushfd
mov eax, [esp]
and eax, 200000h
mov eax, 3

_test ENDP
_zadanie_3 PROC
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
_zadanie_3 ENDP

_zadanie_10 PROC
	push ebx

	rcl ebx,1
	jnc dodatnia
	neg ebx 
dodatnia:
	rcr ebx, 1
	

	pop ebx
	ret
_zadanie_10 ENDP

_zadanie_18 PROC
.data
qxy dw 254, 255, 256
.code
mov ebx, offset qxy
mov dword ptr [ebx+1], eax
ret
_zadanie_18 ENDP

_zadanie_19 PROC
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
_zadanie_19 ENDP

_zadanie_21 PROC
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
mov eax, [ebx]
bswap eax

pop ebx
ret
_zadanie_21 ENDP

_zadanie_22 PROC
.code
mov ecx, 32
mov eax, 0FEFEFEFEh
mov edx, 0
ptl:
	shl eax, 1
	jnc dalej
	add edx, 1
	dalej:
loop ptl
ret
_zadanie_22 ENDP

_zadanie_23 PROC
mov eax, 0FFh
mov edx, eax
shl edx, 3
shl eax, 1
add eax, edx
ret
_zadanie_23 ENDP

_zadanie_27 PROC
mov edx, 347
xchg [esp], edx
ret
_zadanie_27 ENDP

_zadanie_30 PROC
.data	
wskaznik dd ?
.code
	mov eax, OFFSET wskaznik
	mov dword ptr [eax], eax
	ret
_zadanie_30 ENDP

_zadanie_31 PROC
.data
linie dd 421,422,443,442,444,427,432
.code
	push ebx
	
	mov esi, (OFFSET linie) + 4
	mov ebx, 4
	mov edx, [ebx][esi]

	push ebx
	ret
_zadanie_31 ENDP

_zadanie_32 PROC
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
_zadanie_32 ENDP

_zadanie_33 PROC
.data
	napis db 'informatyka', 0, 4 dup(?)
.code
	mov ecx, 12
	mov eax, 0
przepisz:
	mov al, napis[ecx-1]
	mov napis[ecx+3], al
loop przepisz

	push 0 ;MB_OK
	push OFFSET napis ;Tytul
	lea eax, napis[3]
	push eax; tekst
	push 0 ;hwnd chwyt urzadzenia
	call _MessageBoxA@16

	ret
_zadanie_33 ENDP

_zadanie_34 PROC
.data
znaki db 123, 110, 0C2h, 8, 0C2h, 9, 0E1h, 8, 8, 0E1h, 9, 9, 12, 2, 0D2h, 3, 0 ;wyrazy: 9 + 1 '0'
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

shl ecx, 1
pop ebx
pop edi
pop esi
ret
_zadanie_34 ENDP

_zadanie_35 PROC
	mov esi, [esp]
	mov eax, [esi] ;odwolanie do adresu pamieci [slad call] = instrukcja wywo³uj¹ca program
	add eax, [esi+4]
	ret ;podprogram mo¿e odwo³aæ sie do pamiêci do której nie ma dostepu co wygeneruje b³ad
		;nalezy dodac 2 pushe przed z adresami liczb a po callu add esp, 8 oraz po dodaj PROC zwiekszyc esp o 4 a przed ret zmniejszyc o 4
_zadanie_35 ENDP

_zadanie_35_1 PROC
.data
listopad dd 400h

.code
	mov ebx, OFFSET listopad
	mov ecx, 0
	push ebp
	mov ebp, esp
	sub esp, 3
	push edi

	lea edi, [ebp-3]
	mov edx, [ebx][ecx*4]
	mov ebx, 0
	mov ecx, 32
	ptl:
	inc ebx
	shr edx, 1
	jnc dalej

	push edx
	push ebx

	xor edx, edx
	mov eax, ebx
	mov ebx, 10
	
	div bl
	mov dl, ah
	add dl, '0'
	mov [edi+1], dl
	
	mov ah, 0
	div bl
	mov dl, ah
	add dl, 0
	mov [edi], dl
	mov byte PTR[edi+2], 10

	push 3
	push edi
	push 1
	call __write
	add esp, 12

	pop ebx
	pop edx
dalej:
	loop ptl
	pop edi
	add esp, 3
	pop ebp
_zadanie_35_1 ENDP

_zadanie_2_1 PROC
mov edx, 10
mov eax, 2
xor eax, edx ;eax = eax+edx
xor edx, eax ;edx = edx+eax+edx = eax
xor eax, edx ; eax = eax+edx+edx = edx
ret
_zadanie_2_1 ENDP

_zadanie_3_1 PROC
mov ebx, 32
mov edx, 3
mov eax, 129
div ebx
push ebx
ret
_zadanie_3_1 ENDP

_zadanie_1_2 PROC
.data
obszar dw 2 dup(?)
.code
mov dword PTR obszar, $	
mov dword PTR obszar, eax
ret
_zadanie_1_2 ENDP

_zadanie_3_2 PROC
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
_zadanie_3_2 ENDP

_zadanie_37 PROC
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
_zadanie_37 ENDP

_zadanie_37_1 PROC
	push ebp
	mov ebp, esp
	mov eax, 17

	sar eax, 1
	pushf
	neg eax
	popf


	pop ebp
	ret
_zadanie_37_1 ENDP

_zadanie_37_2 PROC
push ebx
push edi

mov ebx, -2
mov eax, 9
xor edx, edx
xor ecx, ecx


ptl:
	sar eax, 1
	adc edx, 0
	ror edx, 1
	inc ecx
	neg eax
	or eax, eax
	jnz ptl

rol edx, cl
pop edi
pop ebx
ret
_zadanie_37_2 ENDP

_zadanie_38 PROC
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
_zadanie_38 ENDP

_zadanie_39 PROC
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
_zadanie_39 ENDP

_zadanie_40 PROC
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
_zadanie_40 ENDP

_zadanie_41 PROC
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
_zadanie_41 ENDP
END
	.intel_syntax noprefix
	.text
	.globl	f
f:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 10
	mov	eax, DWORD PTR -4[rbp]
	imul	eax, DWORD PTR -20[rbp]
	imul	eax, DWORD PTR -20[rbp]
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	pop	rbp
	ret
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"Wrong size!"
.LC2:
	.string	"%d "
	.text
	.globl	main
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	lea	r11, -77824[rsp]
.LPSRL0:
	sub	rsp, 4096
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11
	jne	.LPSRL0
	sub	rsp, 2208
	lea	rax, -80020[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR -80020[rbp]
	cmp	eax, 10000
	jg	.L4
	mov	eax, DWORD PTR -80020[rbp]
	test	eax, eax
	jns	.L5
.L4:
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, -1
	jmp	.L12
.L5:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L7
.L11:
	lea	rax, -40016[rbp]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	sal	rdx, 2
	add	rax, rdx
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	eax, DWORD PTR -40016[rbp+rax*4]
	test	eax, eax
	js	.L8
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	eax, DWORD PTR -40016[rbp+rax*4]
	cmp	eax, 10000
	jle	.L9
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	DWORD PTR -80016[rbp+rax*4], -1
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	eax, DWORD PTR -80016[rbp+rax*4]
	mov	esi, eax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L10
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	eax, DWORD PTR -40016[rbp+rax*4]
	mov	edi, eax
	call	f
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	mov	DWORD PTR -80016[rbp+rdx*4], eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	eax, DWORD PTR -80016[rbp+rax*4]
	mov	esi, eax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
.L10:
	add	DWORD PTR -4[rbp], 1
.L7:
	mov	eax, DWORD PTR -80020[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L11
	mov	eax, 0
.L12:
	leave
	ret

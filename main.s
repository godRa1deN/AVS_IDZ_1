	.file	"main.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	$10, -4(%rbp)
	movl	-4(%rbp), %eax
	imull	-20(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	f, .-f
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"Wrong size!"
.LC2:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-77824(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$2208, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-80024(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-80024(%rbp), %eax
	cmpl	$10000, %eax
	jg	.L4
	movl	-80024(%rbp), %eax
	testl	%eax, %eax
	jns	.L5
.L4:
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L12
.L5:
	movl	$0, -80020(%rbp)
	jmp	.L7
.L11:
	leaq	-80016(%rbp), %rax
	movl	-80020(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-80020(%rbp), %eax
	cltq
	movl	-80016(%rbp,%rax,4), %eax
	testl	%eax, %eax
	js	.L8
	movl	-80020(%rbp), %eax
	cltq
	movl	-80016(%rbp,%rax,4), %eax
	cmpl	$10000, %eax
	jle	.L9
.L8:
	movl	-80020(%rbp), %eax
	cltq
	movl	$-1, -40016(%rbp,%rax,4)
	movl	-80020(%rbp), %eax
	cltq
	movl	-40016(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L10
.L9:
	movl	-80020(%rbp), %eax
	cltq
	movl	-80016(%rbp,%rax,4), %eax
	movl	%eax, %edi
	call	f
	movl	-80020(%rbp), %edx
	movslq	%edx, %rdx
	movl	%eax, -40016(%rbp,%rdx,4)
	movl	-80020(%rbp), %eax
	cltq
	movl	-40016(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L10:
	addl	$1, -80020(%rbp)
.L7:
	movl	-80024(%rbp), %eax
	cmpl	%eax, -80020(%rbp)
	jl	.L11
	movl	$0, %eax
.L12:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

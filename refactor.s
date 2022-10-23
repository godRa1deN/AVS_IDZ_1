	.intel_syntax noprefix
	.text
	.globl	f
f:
	endbr64					#команда для защиты
	push	rbp
	mov	rbp, rsp				#6-7 стандартный пролог
	mov	r11d, edi				#r11d = edi = первый аргумент = t
	mov	DWORD PTR -4[rbp], 10			#создаем локальную переменную g с адресом rbp-4, g = 10
	mov	eax, DWORD PTR -4[rbp]			#eax = g
	imul	eax, r11d				#eax *= t = g * t
	imul	eax, r11d				#eax *= t = g * t * t
	mov	edx, eax				
	shr	edx, 31
	add	eax, edx
	sar	eax					#13-16 eax = g * t * t / 2
	pop	rbp					
	ret						#возвращаем eax
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"Wrong size!"
.LC3:
	.string	"%d "
	.text
	.globl	main
main:
	endbr64					#команда для зашиты
	push	rbp
	mov	rbp, rsp				#30-31 стандартный пролог
	sub	rsp, 80032				#выделяем память на стеке
	lea	r8, -80020[rbp]			#n adress = rbp - 80020
	mov	rsi, r8				#rsi = второй аргумент = &n
	lea	rdi, .LC0[rip]				#rdi = первый аргумент = форматная строка ввода "%d"
	mov	eax, 0					#подготовка к вызову __isoc99_scanf
	call	__isoc99_scanf@PLT			#вызов __isoc99_scanf
	mov	r14d, DWORD PTR -80020[rbp]		#r14d = n
	cmp	r14d, 10000				#сравниваем n и 10000
	jg	.L4					#если n > 10000 прыгаем в .L4
	test	r14d, r14d				#устанавливыаем флаги для  n
	jns	.L5					#если n >= 0, прыгаем в .L5
.L4:
	lea	rdi, .LC1[rip]				#rdi = первый аргумент = "Wrong size!"
	mov	eax, 0					#подготовка к вызову printf
	call	printf@PLT				#вызов printf
	mov	eax, -1				#eax = -1
	jmp	.L10					#прыгаем в .L10, где завершаем программу с кодом возврата = eax = -1
.L5:							#в .L5 попадаем, если размермассива корректный
	mov	DWORD PTR -4[rbp], 0			#i = 0, &i = rbp - 4
	mov	r15d, DWORD PTR -4[rbp]		#i = r15d, будем хранить i в регистре r15d
	movsx	r15, r15d				#сразу знаково расширим его в r15 для адресной арифметики
	lea	r12, -40016[rbp]			#&a[0] = r12 = rbp - 40016
	lea	r13, DWORD PTR -80016[rbp]		#&b[0] = r13 = rbp - 80016
	jmp	.L7					#прыгаем в .L7
.L9:							#тело цикла for
	mov	r9, r12				#используем регистр r9 для промежуточных вычислений, r9 = r12 = &a[0]
	mov	edx, r15d				#используем регистр edx для промежуточных вычислений, edx = r15d = i	
	movsx	rdx, edx				#знаково расширяем edx в rdx, чтобы его его размер был равен размеру адреса массива
	sal	rdx, 2					#знаковый сдвиг влево = умножение на 4 => r9 = i * 4 = смещение в байтах
	add	r9, rdx				#прибавляем к адресу массива посчитанное смещение и получаем r9 = &a[i]
	mov	rsi, r9     				#rsi = первый аргумент = &a[i]	
	lea	rdi, .LC0[rip]				#rdi = форматная строка ввода = второй аргумент = "%d"
	mov	eax, 0					#подготовка к вызову функции __isoc99_scanf
	call	__isoc99_scanf@PLT			#вызов __isoc99_scanf
	mov	r10d, DWORD PTR [r12+r15*4]		#&a[i] = r12 + r15 * 4, тогда a[i] = DWORD PTR [r12+r15*4]. r10d = a[i]
	cmp	r10d, 10000				#сравниваем r10d = a[i] и 10000
	jg	.L11					#если a[i] > 10000, прыгаем в .L11
	test	r10d, r10d				#выставим флаги для r10 = a[i]
	jns	.L8					#если a[i] >= 0, прыгаем в .L8
.L11:							#сюда попадем если a[i] > 100000 || a[i] < 0
	mov	DWORD PTR [r13+r15*4], -1		#DWORD PTR [r13+r15*4] = b[i]. b[i] = -1
	mov	esi, DWORD PTR [r13+r15*4]		#esi = второй аргумент = b[i]
	lea	rdi, .LC3[rip]				#rdi = первый аргумент = форматная строка вывода = "%d "
	mov	eax, 0					#подготовка к вызову printf
	call	printf@PLT				#вызов printf
	add	r15d, 1				#i++
	jmp .L7					#прыгаем в .L7
.L8:							#сюда попадаем при корректной значении a[i]
	mov	edi, DWORD PTR [r12+r15*4]		#edi = первый аргумент = a[i]
	call	f					#вызываем f с аргументом edi = a[i]
	mov	DWORD PTR [r13+r15*4], eax		#f(a[i]) = возвращаеммое занчение f = eax, b[i] = f(a[i])	
	mov	esi, DWORD PTR [r13+r15*4]		#второй аргумент = esi = b[i]
	lea	rdi, .LC3[rip]				#первый аргумент = форматная строка вывода = "%d "
	mov	eax, 0					#подготовка к вызову printf
	call	printf@PLT				#вызов printf
	add	r15d, 1				#i++
.L7:
	cmp	r15d, r14d				#сравниваем i с n
	jl	.L9					#если i < n, прыгаем в .L9 - тело цикла for
	mov	eax, 0					#сюда попадаем, когда for закончил свою работу, eax = код возврата = 0
.L10:
	leave						#стандартный эпилог
	ret						#завершаем программу с кодом возврата = eax

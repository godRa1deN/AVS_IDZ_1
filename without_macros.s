	.intel_syntax noprefix
	.text
	.globl	f
f:
	endbr64									#функция для защиты
	push	rbp
	mov	rbp, rsp							#6-7 стандартный пролог
	mov	DWORD PTR -20[rbp], edi				#первый аргумент - edi(переменная t) кладем по адресу rbp-20
	mov	DWORD PTR -4[rbp], 10				#локальную переменную g = 10 кладем по адресу rbp-4
	mov	eax, DWORD PTR -4[rbp]				#eax = g
	imul	eax, DWORD PTR -20[rbp]			#g *= t
	imul	eax, DWORD PTR -20[rbp]			#g *= t  получается g = g * t * t
	mov	edx, eax
	shr	edx, 31								#строки 13-14 подготовка к делению на 2
	add	eax, edx
	sar	eax									#деление(в eax возвращаемое значение)
	pop	rbp									
	ret										#17-18 стандартный эпилог, вернули eax = g * t * t / 2
	.section	.rodata
.LC0:
	.string	"%d"							#форматная строка для ввода
.LC1:
	.string	"%d "							#форматная строка для вывода
	.text
	.globl	main
main:
	endbr64									#функция для защиты
	push	rbp
	mov	rbp, rsp							#28-29 стандартный пролог
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx								#в строках 29-34 сохраняем регистры на стеке
	lea	r11, -397312[rsp]
.LPSRL0:
	sub	rsp, 4096							#выделяем на стеке блоки по 4096 байт
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11							#пока rsp != rsp - 397312 продолжаем выделять блоки по 4096 байт
	jne	.LPSRL0
	sub	rsp, 2744							#после выделения 397312 байт, выделяем еще 2744 байт, таким образом мы выделили на стеке 400056 байт, в которых будет храниться наш массив из 400000 байт
	lea	rax, -400084[rbp]			
	mov	rsi, rax							#rsi = второй аргумент scanf = переменная n будет записана по адресу rbp - 400084
	lea	rdi, .LC0[rip]						#rdi = первый аргумент scanf = форматная строка ввода
	mov	eax, 0
	call	__isoc99_scanf@PLT				#scanf(rdi, rsi) = scanf("%d", &n)
	mov	DWORD PTR -60[rbp], 0				#по адресу rbp - 60 лежит переменная i = 0
	jmp	.L4									#прыгаем в .L4
.L5:										#тело цикла for
	lea	rax, -400080[rbp]					#rax = rbp - 400080 = адрес первого элемента массива a (&a[0])
	mov	edx, DWORD PTR -60[rbp]				#edx = i
	movsx	rdx, edx						#знаковое расширение edx в rdx
	sal	rdx, 2								#edx *= 4 => i *= 4
	add	rax, rdx							#&a[0] + i * 4 = адрес элемента a[i]
	mov	rsi, rax							#rsi = второй аргумент scanf = &a[i]
	lea	rdi, .LC0[rip]						#rdi = первый аргумент = форматная строка ввода
	mov	eax, 0
	call	__isoc99_scanf@PLT				#вызов scanf = scanf("%d", &a[i])
	add	DWORD PTR -60[rbp], 1				#i++
.L4:
	mov	eax, DWORD PTR -400084[rbp]			#eax = n;
	cmp	DWORD PTR -60[rbp], eax				#сравниваем i c n
	jl	.L5									#если i < n, прыгаем в for
	mov	eax, DWORD PTR -400084[rbp]			#сюда попадем, если отработал for
	mov	rdx, rsp
	mov	rbx, rdx
	movsx	rdx, eax						
	sub	rdx, 1
	mov	QWORD PTR -72[rbp], rdx
	movsx	rdx, eax
	mov	r14, rdx
	mov	r15d, 0
	movsx	rdx, eax
	mov	r12, rdx
	mov	r13d, 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	ecx, 16
	mov	edx, 0
	div	rcx
	imul	rax, rax, 16
	mov	rdx, rax
	and	rdx, -4096							
	mov	rsi, rsp							
	sub	rsi, rdx
	mov	rdx, rsi
.L6:
	cmp	rsp, rdx
	je	.L7
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L6									
.L7:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L8
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0					#строки 64-107 - оптимизации компилятора, в них идет работа со стеком и в результате выделяется нужная нам память, в частности под массив b. 
											#К переменым и функциям из Си-программы данный фрагмент не относится, поэтому не будет прокомментирован.
.L8:
	mov	rax, rsp							
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -80[rbp], rax				#rbp - 80 = адрес первого элемента массива = &b[0]
	mov	DWORD PTR -56[rbp], 0				#rbp - 56 = &i, i = 0
	jmp	.L9									#прыгаем в .L9
.L10:										#тело второго цикла for
	mov	eax, DWORD PTR -56[rbp]				#eax = i
	cdqe									
	mov	eax, DWORD PTR -400080[rbp+rax*4]	#eax = a[i]
	mov	edi, eax							#edi = первый аргумент = a[i]
	call	f								#вызываем f с аргументом edi = a[i], результат работы функции будет лежать в eax
	mov	rdx, QWORD PTR -80[rbp]				#rdx = &b[0]
	mov	ecx, DWORD PTR -56[rbp]				#ecx = i
	movsx	rcx, ecx						#знаково расширяем ecx в rcx
	mov	DWORD PTR [rdx+rcx*4], eax			#b[i] = eax = f(a[i])
	add	DWORD PTR -56[rbp], 1				#i++
.L9:
	mov	eax, DWORD PTR -400084[rbp]			#eax = n
	cmp	DWORD PTR -56[rbp], eax				#сравниваем i с n
	jl	.L10								#если i < n прыгаем в for 
	mov	DWORD PTR -52[rbp], 0				#сюда попадаем после выхода из второго for. i = 0 из третьего for лежит по адресу rbp - 52
	jmp	.L11								#прыгаем в .L11
.L12:										#тело третьего цикла for
	mov	rax, QWORD PTR -80[rbp]				#rax = &b[0]
	mov	edx, DWORD PTR -52[rbp]				#edx = i
	movsx	rdx, edx						#знаково расширяем edx в rdx
	mov	eax, DWORD PTR [rax+rdx*4]			#eax = b[i]
	mov	esi, eax							#esi = второй аргумент printf = b[i]
	lea	rdi, .LC1[rip]						#rdi = первый аргумент printf = форматная строка вывода
	mov	eax, 0								
	call	printf@PLT						#вызов printf = printf("%d ", b[i]);
	add	DWORD PTR -52[rbp], 1				#i++
.L11:										
	mov	eax, DWORD PTR -400084[rbp]			#eax = n
	cmp	DWORD PTR -52[rbp], eax				#сравниваем i с n
	jl	.L12								#если i < n прыгаем в тело третьего цикла for
	mov	rsp, rbx							#сюда попадаем после завершения третьего for
	mov	eax, 0
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15									#восстанваливаем значение регистров и очищаем стек
	pop	rbp
	ret										#стандартный эпилог

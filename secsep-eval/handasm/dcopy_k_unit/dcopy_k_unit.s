	.text
	.globl	dcopy_k
	.type	dcopy_k,@function
dcopy_k:
	leaq (,%rdx,8), %rdx
	leaq (,%r8,8), %r8
	cmpq $0x8, %rdx
	jne .Ldcopy_k_3e0
	cmpq $0x8, %r8
	jne .Ldcopy_k_3e0
	testq $0x8, %rcx
	je .Ldcopy_k_50
	movsd (%rsi), %xmm0
	movsd %xmm0, (%rcx)
	addq $0x8, %rsi
	addq $0x8, %rcx
	decq %rdi
	jle .Ldcopy_k_1c8
.Ldcopy_k_50:
	subq $-0x80, %rsi
	subq $-0x80, %rcx
	testq $0x8, %rsi
	jne .Ldcopy_k_1d0
	movq %rdi, %rax
	sarq $0x4, %rax
	cmpq	$0, %rax
	jle .Ldcopy_k_128
	movups -0x80(%rsi), %xmm0
	movups -0x70(%rsi), %xmm1
	movups -0x60(%rsi), %xmm2
	movups -0x50(%rsi), %xmm3
	movups -0x40(%rsi), %xmm4
	movups -0x30(%rsi), %xmm5
	movups -0x20(%rsi), %xmm6
	movups -0x10(%rsi), %xmm7
	decq %rax
	jle .Ldcopy_k_100
.Ldcopy_k_98:
	movups %xmm0, -0x80(%rcx)
	movups (%rsi), %xmm0
	movups %xmm1, -0x70(%rcx)
	movups 0x10(%rsi), %xmm1
	movups %xmm2, -0x60(%rcx)
	movups 0x20(%rsi), %xmm2
	movups %xmm3, -0x50(%rcx)
	movups 0x30(%rsi), %xmm3
	movups %xmm4, -0x40(%rcx)
	movups 0x40(%rsi), %xmm4
	movups %xmm5, -0x30(%rcx)
	movups 0x50(%rsi), %xmm5
	movups %xmm6, -0x20(%rcx)
	movups 0x60(%rsi), %xmm6
	movups %xmm7, -0x10(%rcx)
	movups 0x70(%rsi), %xmm7
	subq $-0x80, %rcx
	subq $-0x80, %rsi
	decq %rax
	jg .Ldcopy_k_98
.Ldcopy_k_100:
	movups %xmm0, -0x80(%rcx)
	movups %xmm1, -0x70(%rcx)
	movups %xmm2, -0x60(%rcx)
	movups %xmm3, -0x50(%rcx)
	movups %xmm4, -0x40(%rcx)
	movups %xmm5, -0x30(%rcx)
	movups %xmm6, -0x20(%rcx)
	movups %xmm7, -0x10(%rcx)
	subq $-0x80, %rcx
	subq $-0x80, %rsi
.Ldcopy_k_128:
	testq $0x8, %rdi
	je .Ldcopy_k_160
	movups -0x80(%rsi), %xmm0
	movups -0x70(%rsi), %xmm1
	movups -0x60(%rsi), %xmm2
	movups -0x50(%rsi), %xmm3
	movups %xmm0, -0x80(%rcx)
	movups %xmm1, -0x70(%rcx)
	movups %xmm2, -0x60(%rcx)
	movups %xmm3, -0x50(%rcx)
	addq $0x40, %rsi
	addq $0x40, %rcx
.Ldcopy_k_160:
	testq $0x4, %rdi
	je .Ldcopy_k_188
	movups -0x80(%rsi), %xmm0
	movups -0x70(%rsi), %xmm1
	movups %xmm0, -0x80(%rcx)
	movups %xmm1, -0x70(%rcx)
	addq $0x20, %rsi
	addq $0x20, %rcx
.Ldcopy_k_188:
	testq $0x2, %rdi
	je .Ldcopy_k_1a8
	movups -0x80(%rsi), %xmm0
	movups %xmm0, -0x80(%rcx)
	addq $0x10, %rsi
	addq $0x10, %rcx
.Ldcopy_k_1a8:
	testq $0x1, %rdi
	je .Ldcopy_k_1c8
	movsd -0x80(%rsi), %xmm0
	movsd %xmm0, -0x80(%rcx)
.Ldcopy_k_1c8:
	xorq %rax, %rax
	retq
.Ldcopy_k_1d0:
	movsd -0x80(%rsi), %xmm0
	movq %rdi, %rax
	sarq $0x4, %rax
	cmpq	$0, %rax
	jle .Ldcopy_k_300
	movups -0x78(%rsi), %xmm1
	movups -0x68(%rsi), %xmm2
	movups -0x58(%rsi), %xmm3
	movups -0x48(%rsi), %xmm4
	movups -0x38(%rsi), %xmm5
	movups -0x28(%rsi), %xmm6
	movups -0x18(%rsi), %xmm7
	decq %rax
	jle .Ldcopy_k_2a8
.Ldcopy_k_210:
	shufpd $0x1, %xmm1, %xmm0
	movups %xmm0, -0x80(%rcx)
	movups -0x8(%rsi), %xmm0
	shufpd $0x1, %xmm2, %xmm1
	movups %xmm1, -0x70(%rcx)
	movups 0x8(%rsi), %xmm1
	shufpd $0x1, %xmm3, %xmm2
	movups %xmm2, -0x60(%rcx)
	movups 0x18(%rsi), %xmm2
	shufpd $0x1, %xmm4, %xmm3
	movups %xmm3, -0x50(%rcx)
	movups 0x28(%rsi), %xmm3
	shufpd $0x1, %xmm5, %xmm4
	movups %xmm4, -0x40(%rcx)
	movups 0x38(%rsi), %xmm4
	shufpd $0x1, %xmm6, %xmm5
	movups %xmm5, -0x30(%rcx)
	movups 0x48(%rsi), %xmm5
	shufpd $0x1, %xmm7, %xmm6
	movups %xmm6, -0x20(%rcx)
	movups 0x58(%rsi), %xmm6
	shufpd $0x1, %xmm0, %xmm7
	movups %xmm7, -0x10(%rcx)
	movups 0x68(%rsi), %xmm7
	subq $-0x80, %rsi
	subq $-0x80, %rcx
	decq %rax
	jg .Ldcopy_k_210
.Ldcopy_k_2a8:
	shufpd $0x1, %xmm1, %xmm0
	movups %xmm0, -0x80(%rcx)
	movups -0x8(%rsi), %xmm0
	shufpd $0x1, %xmm2, %xmm1
	movups %xmm1, -0x70(%rcx)
	shufpd $0x1, %xmm3, %xmm2
	movups %xmm2, -0x60(%rcx)
	shufpd $0x1, %xmm4, %xmm3
	movups %xmm3, -0x50(%rcx)
	shufpd $0x1, %xmm5, %xmm4
	movups %xmm4, -0x40(%rcx)
	shufpd $0x1, %xmm6, %xmm5
	movups %xmm5, -0x30(%rcx)
	shufpd $0x1, %xmm7, %xmm6
	movups %xmm6, -0x20(%rcx)
	shufpd $0x1, %xmm0, %xmm7
	movups %xmm7, -0x10(%rcx)
	subq $-0x80, %rsi
	subq $-0x80, %rcx
.Ldcopy_k_300:
	testq $0x8, %rdi
	je .Ldcopy_k_358
	movups -0x78(%rsi), %xmm1
	movups -0x68(%rsi), %xmm2
	movups -0x58(%rsi), %xmm3
	movups -0x48(%rsi), %xmm8
	shufpd $0x1, %xmm1, %xmm0
	movups %xmm0, -0x80(%rcx)
	shufpd $0x1, %xmm2, %xmm1
	movups %xmm1, -0x70(%rcx)
	shufpd $0x1, %xmm3, %xmm2
	movups %xmm2, -0x60(%rcx)
	shufpd $0x1, %xmm8, %xmm3
	movups %xmm3, -0x50(%rcx)
	movups %xmm8, %xmm0
	addq $0x40, %rsi
	addq $0x40, %rcx
.Ldcopy_k_358:
	testq $0x4, %rdi
	je .Ldcopy_k_390
	movups -0x78(%rsi), %xmm1
	movups -0x68(%rsi), %xmm2
	shufpd $0x1, %xmm1, %xmm0
	shufpd $0x1, %xmm2, %xmm1
	movups %xmm0, -0x80(%rcx)
	movups %xmm1, -0x70(%rcx)
	movups %xmm2, %xmm0
	addq $0x20, %rsi
	addq $0x20, %rcx
.Ldcopy_k_390:
	testq $0x2, %rdi
	je .Ldcopy_k_3b8
	movups -0x78(%rsi), %xmm1
	shufpd $0x1, %xmm1, %xmm0
	movups %xmm0, -0x80(%rcx)
	addq $0x10, %rsi
	addq $0x10, %rcx
.Ldcopy_k_3b8:
	testq $0x1, %rdi
	je .Ldcopy_k_3d8
	movsd -0x80(%rsi), %xmm0
	movsd %xmm0, -0x80(%rcx)
.Ldcopy_k_3d8:
	xorq %rax, %rax
	retq
.Ldcopy_k_3e0:
	movq %rdi, %rax
	sarq $0x3, %rax
	cmpq	$0, %rax
	jle .Ldcopy_k_460
.Ldcopy_k_3f0:
	movsd (%rsi), %xmm0
	addq %rdx, %rsi
	movsd (%rsi), %xmm0
	addq %rdx, %rsi
	movsd (%rsi), %xmm1
	addq %rdx, %rsi
	movsd (%rsi), %xmm1
	addq %rdx, %rsi
	movsd (%rsi), %xmm2
	addq %rdx, %rsi
	movsd (%rsi), %xmm2
	addq %rdx, %rsi
	movsd (%rsi), %xmm3
	addq %rdx, %rsi
	movsd (%rsi), %xmm3
	addq %rdx, %rsi
	movsd %xmm0, (%rcx)
	addq %r8, %rcx
	movsd %xmm0, (%rcx)
	addq %r8, %rcx
	movsd %xmm1, (%rcx)
	addq %r8, %rcx
	movsd %xmm1, (%rcx)
	addq %r8, %rcx
	movsd %xmm2, (%rcx)
	addq %r8, %rcx
	movsd %xmm2, (%rcx)
	addq %r8, %rcx
	movsd %xmm3, (%rcx)
	addq %r8, %rcx
	movsd %xmm3, (%rcx)
	addq %r8, %rcx
	decq %rax
	jg .Ldcopy_k_3f0
.Ldcopy_k_460:
	movq %rdi, %rax
	andq $0x7, %rax
	cmpq	$0, %rax
	jle .Ldcopy_k_488
.Ldcopy_k_470:
	movsd (%rsi), %xmm0
	addq %rdx, %rsi
	movsd %xmm0, (%rcx)
	addq %r8, %rcx
	decq %rax
	jg .Ldcopy_k_470
.Ldcopy_k_488:
	xorq %rax, %rax
	retq
	.size	dcopy_k, .-dcopy_k
	.globl	main
	.type	main,@function
main:
	pushq	%rax
	movq	$100, %rdi
	leaq	x_buf(%rip), %rsi
	movq	$1, %rdx
	leaq	y_buf(%rip), %rcx
	movq	$1, %r8
	callq	dcopy_k
	xorl	%eax, %eax
	popq	%rcx
	retq
	.size	main, .-main
	.type	x_buf,@object
	.data
	.globl	x_buf
	.p2align	4
x_buf:
	.zero	800
	.size	x_buf, 800
	.type	y_buf,@object
	.data
	.globl	y_buf
	.p2align	4
y_buf:
	.zero	800
	.size	y_buf, 800

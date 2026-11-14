	.text
	.globl	dasum_k
	.type	dasum_k,@function
dasum_k:
	xorps %xmm0, %xmm0
	cmpq	$0, %rdi
	jle .Ldasum_k_2d0
	cmpq	$0, %rdx
	jle .Ldasum_k_2d0
	xorps %xmm1, %xmm1
	xorps %xmm2, %xmm2
	xorps %xmm3, %xmm3
	xorps %xmm15, %xmm15
	psrlq $0x1, %xmm15
	shlq $0x3, %rdx
	subq $-0x80, %rsi
	cmpq $0x8, %rdx
	jne .Ldasum_k_210
	testq $0x8, %rsi
	je .Ldasum_k_60
	movsd -0x80(%rsi), %xmm0
	addq $0x8, %rsi
	xorps %xmm15, %xmm0
	subq $0x1, %rdi
	jle .Ldasum_k_2d0
.Ldasum_k_60:
	movq %rdi, %rax
	sarq $0x4, %rax
	cmpq	$0, %rax
	jle .Ldasum_k_168
	movaps -0x80(%rsi), %xmm4
	movaps -0x70(%rsi), %xmm5
	movaps -0x60(%rsi), %xmm6
	movaps -0x50(%rsi), %xmm7
	movaps -0x40(%rsi), %xmm8
	movaps -0x30(%rsi), %xmm9
	movaps -0x20(%rsi), %xmm10
	movaps -0x10(%rsi), %xmm11
	decq %rax
	jle .Ldasum_k_120
.Ldasum_k_a0:
	xorps %xmm15, %xmm4
	xorps %xmm4, %xmm0
	movaps (%rsi), %xmm4
	xorps %xmm15, %xmm5
	xorps %xmm5, %xmm1
	movaps 0x10(%rsi), %xmm5
	xorps %xmm15, %xmm6
	xorps %xmm6, %xmm2
	movaps 0x20(%rsi), %xmm6
	xorps %xmm15, %xmm7
	xorps %xmm7, %xmm3
	movaps 0x30(%rsi), %xmm7
	xorps %xmm15, %xmm8
	xorps %xmm8, %xmm0
	movaps 0x40(%rsi), %xmm8
	xorps %xmm15, %xmm9
	xorps %xmm9, %xmm1
	movaps 0x50(%rsi), %xmm9
	xorps %xmm15, %xmm10
	xorps %xmm10, %xmm2
	movaps 0x60(%rsi), %xmm10
	xorps %xmm15, %xmm11
	xorps %xmm11, %xmm3
	movaps 0x70(%rsi), %xmm11
	subq $-0x80, %rsi
	decq %rax
	jg .Ldasum_k_a0
.Ldasum_k_120:
	xorps %xmm15, %xmm4
	xorps %xmm15, %xmm5
	xorps %xmm15, %xmm6
	xorps %xmm15, %xmm7
	xorps %xmm4, %xmm0
	xorps %xmm5, %xmm1
	xorps %xmm6, %xmm2
	xorps %xmm7, %xmm3
	xorps %xmm15, %xmm8
	xorps %xmm15, %xmm9
	xorps %xmm15, %xmm10
	xorps %xmm15, %xmm11
	xorps %xmm8, %xmm0
	xorps %xmm9, %xmm1
	xorps %xmm10, %xmm2
	xorps %xmm11, %xmm3
	subq $-0x80, %rsi
.Ldasum_k_168:
	andq $0xf, %rdi
	cmpq	$0, %rdi
	jle .Ldasum_k_2c0
	testq $0x8, %rdi
	je .Ldasum_k_1b0
	movaps -0x80(%rsi), %xmm4
	movaps -0x70(%rsi), %xmm5
	movaps -0x60(%rsi), %xmm6
	movaps -0x50(%rsi), %xmm7
	xorps %xmm15, %xmm4
	xorps %xmm15, %xmm5
	xorps %xmm15, %xmm6
	xorps %xmm15, %xmm7
	xorps %xmm4, %xmm0
	xorps %xmm5, %xmm1
	xorps %xmm6, %xmm2
	xorps %xmm7, %xmm3
	addq $0x40, %rsi
.Ldasum_k_1b0:
	testq $0x4, %rdi
	je .Ldasum_k_1d8
	movaps -0x80(%rsi), %xmm4
	movaps -0x70(%rsi), %xmm5
	xorps %xmm15, %xmm4
	xorps %xmm15, %xmm5
	xorps %xmm4, %xmm0
	xorps %xmm5, %xmm1
	addq $0x20, %rsi
.Ldasum_k_1d8:
	testq $0x2, %rdi
	je .Ldasum_k_1f1
	movaps -0x80(%rsi), %xmm6
	xorps %xmm15, %xmm6
	xorps %xmm6, %xmm3
	addq $0x10, %rsi
.Ldasum_k_1f1:
	testq $0x1, %rdi
	je .Ldasum_k_2c0
	movsd -0x80(%rsi), %xmm4
	xorps %xmm15, %xmm4
	xorps %xmm4, %xmm0
	jmp .Ldasum_k_2c0
.Ldasum_k_210:
	movq %rdi, %rax
	sarq $0x3, %rax
	cmpq	$0, %rax
	jle .Ldasum_k_290
.Ldasum_k_220:
	movsd -0x80(%rsi), %xmm4
	addq %rdx, %rsi
	movsd -0x80(%rsi), %xmm4
	addq %rdx, %rsi
	xorps %xmm15, %xmm4
	xorps %xmm4, %xmm0
	movsd -0x80(%rsi), %xmm5
	addq %rdx, %rsi
	movsd -0x80(%rsi), %xmm5
	addq %rdx, %rsi
	xorps %xmm15, %xmm5
	xorps %xmm5, %xmm1
	movsd -0x80(%rsi), %xmm6
	addq %rdx, %rsi
	movsd -0x80(%rsi), %xmm6
	addq %rdx, %rsi
	xorps %xmm15, %xmm6
	xorps %xmm6, %xmm2
	movsd -0x80(%rsi), %xmm7
	addq %rdx, %rsi
	movsd -0x80(%rsi), %xmm7
	addq %rdx, %rsi
	xorps %xmm15, %xmm7
	xorps %xmm7, %xmm3
	decq %rax
	jg .Ldasum_k_220
.Ldasum_k_290:
	andq $0x7, %rdi
	cmpq	$0, %rdi
	jle .Ldasum_k_2c0
.Ldasum_k_2a0:
	movsd -0x80(%rsi), %xmm4
	xorps %xmm15, %xmm4
	xorps %xmm4, %xmm0
	addq %rdx, %rsi
	decq %rdi
	jg .Ldasum_k_2a0
.Ldasum_k_2c0:
	xorps %xmm1, %xmm0
	xorps %xmm3, %xmm2
	xorps %xmm2, %xmm0
.Ldasum_k_2d0:
	xorps %xmm0, %xmm0
	retq
	.size	dasum_k, .-dasum_k
	.globl	main
	.type	main,@function
main:
	pushq	%rax
	movq	$100, %rdi
	leaq	x_buf(%rip), %rsi
	movq	$1, %rdx
	callq	dasum_k
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

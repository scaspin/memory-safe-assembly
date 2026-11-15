	.text
rsaz_512_sqr:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x98, %rsp
movq	%rdx, %xmm1
movq	(%rsi), %rdx
movq	0x8(%rsi), %rax
movq	%rcx, 0x80(%rsp)
movl	$0x80100, %r11d
andl	OPENSSL_ia32cap_P+8(%rip), %r11d
cmpl	$0x80100, %r11d
je	L_480
jmp	L_60
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_60:
movl	%r8d, 0x88(%rsp)
movq	%rdx, %rbx
movq	%rax, %rbp
mulq	%rdx
movq	%rax, %r8
movq	0x10(%rsi), %rax
movq	%rdx, %r9
mulq	%rbx
addq	%rax, %r9
movq	0x18(%rsi), %rax
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r10
movq	0x20(%rsi), %rax
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r11
movq	0x28(%rsi), %rax
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%rbx
addq	%rax, %r12
movq	0x30(%rsi), %rax
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%rbx
addq	%rax, %r13
movq	0x38(%rsi), %rax
movq	%rdx, %r14
adcq	$0x0, %r14
mulq	%rbx
addq	%rax, %r14
movq	%rbx, %rax
adcq	$0x0, %rdx
xorq	%rcx, %rcx
addq	%r8, %r8
movq	%rdx, %r15
adcq	$0x0, %rcx
mulq	%rax
addq	%r8, %rdx
adcq	$0x0, %rcx
movq	%rax, (%rsp)
movq	%rdx, 0x8(%rsp)
movq	0x10(%rsi), %rax
mulq	%rbp
addq	%rax, %r10
movq	0x18(%rsi), %rax
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%rbp
addq	%rax, %r11
movq	0x20(%rsi), %rax
adcq	$0x0, %rdx
addq	%rbx, %r11
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%rbp
addq	%rax, %r12
movq	0x28(%rsi), %rax
adcq	$0x0, %rdx
addq	%rbx, %r12
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%rbp
addq	%rax, %r13
movq	0x30(%rsi), %rax
adcq	$0x0, %rdx
addq	%rbx, %r13
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%rbp
addq	%rax, %r14
movq	0x38(%rsi), %rax
adcq	$0x0, %rdx
addq	%rbx, %r14
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%rbp
addq	%rax, %r15
movq	%rbp, %rax
adcq	$0x0, %rdx
addq	%rbx, %r15
adcq	$0x0, %rdx
xorq	%rbx, %rbx
addq	%r9, %r9
movq	%rdx, %r8
adcq	%r10, %r10
adcq	$0x0, %rbx
mulq	%rax
addq	%rcx, %rax
movq	0x10(%rsi), %rbp
addq	%rax, %r9
movq	0x18(%rsi), %rax
adcq	%rdx, %r10
adcq	$0x0, %rbx
movq	%r9, 0x10(%rsp)
movq	%r10, 0x18(%rsp)
mulq	%rbp
addq	%rax, %r12
movq	0x20(%rsi), %rax
movq	%rdx, %rcx
adcq	$0x0, %rcx
mulq	%rbp
addq	%rax, %r13
movq	0x28(%rsi), %rax
adcq	$0x0, %rdx
addq	%rcx, %r13
movq	%rdx, %rcx
adcq	$0x0, %rcx
mulq	%rbp
addq	%rax, %r14
movq	0x30(%rsi), %rax
adcq	$0x0, %rdx
addq	%rcx, %r14
movq	%rdx, %rcx
adcq	$0x0, %rcx
mulq	%rbp
addq	%rax, %r15
movq	0x38(%rsi), %rax
adcq	$0x0, %rdx
addq	%rcx, %r15
movq	%rdx, %rcx
adcq	$0x0, %rcx
mulq	%rbp
addq	%rax, %r8
movq	%rbp, %rax
adcq	$0x0, %rdx
addq	%rcx, %r8
adcq	$0x0, %rdx
xorq	%rcx, %rcx
addq	%r11, %r11
movq	%rdx, %r9
adcq	%r12, %r12
adcq	$0x0, %rcx
mulq	%rax
addq	%rbx, %rax
movq	0x18(%rsi), %r10
addq	%rax, %r11
movq	0x20(%rsi), %rax
adcq	%rdx, %r12
adcq	$0x0, %rcx
movq	%r11, 0x20(%rsp)
movq	%r12, 0x28(%rsp)
movq	%rax, %r11
mulq	%r10
addq	%rax, %r14
movq	0x28(%rsi), %rax
movq	%rdx, %rbx
adcq	$0x0, %rbx
movq	%rax, %r12
mulq	%r10
addq	%rax, %r15
movq	0x30(%rsi), %rax
adcq	$0x0, %rdx
addq	%rbx, %r15
movq	%rdx, %rbx
adcq	$0x0, %rbx
movq	%rax, %rbp
mulq	%r10
addq	%rax, %r8
movq	0x38(%rsi), %rax
adcq	$0x0, %rdx
addq	%rbx, %r8
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%r10
addq	%rax, %r9
movq	%r10, %rax
adcq	$0x0, %rdx
addq	%rbx, %r9
adcq	$0x0, %rdx
xorq	%rbx, %rbx
addq	%r13, %r13
movq	%rdx, %r10
adcq	%r14, %r14
adcq	$0x0, %rbx
mulq	%rax
addq	%rcx, %rax
addq	%rax, %r13
movq	%r12, %rax
adcq	%rdx, %r14
adcq	$0x0, %rbx
movq	%r13, 0x30(%rsp)
movq	%r14, 0x38(%rsp)
mulq	%r11
addq	%rax, %r8
movq	%rbp, %rax
movq	%rdx, %rcx
adcq	$0x0, %rcx
mulq	%r11
addq	%rax, %r9
movq	0x38(%rsi), %rax
adcq	$0x0, %rdx
addq	%rcx, %r9
movq	%rdx, %rcx
adcq	$0x0, %rcx
movq	%rax, %r14
mulq	%r11
addq	%rax, %r10
movq	%r11, %rax
adcq	$0x0, %rdx
addq	%rcx, %r10
adcq	$0x0, %rdx
xorq	%rcx, %rcx
addq	%r15, %r15
movq	%rdx, %r11
adcq	%r8, %r8
adcq	$0x0, %rcx
mulq	%rax
addq	%rbx, %rax
addq	%rax, %r15
movq	%rbp, %rax
adcq	%rdx, %r8
adcq	$0x0, %rcx
movq	%r15, 0x40(%rsp)
movq	%r8, 0x48(%rsp)
mulq	%r12
addq	%rax, %r10
movq	%r14, %rax
movq	%rdx, %rbx
adcq	$0x0, %rbx
mulq	%r12
addq	%rax, %r11
movq	%r12, %rax
adcq	$0x0, %rdx
addq	%rbx, %r11
adcq	$0x0, %rdx
xorq	%rbx, %rbx
addq	%r9, %r9
movq	%rdx, %r12
adcq	%r10, %r10
adcq	$0x0, %rbx
mulq	%rax
addq	%rcx, %rax
addq	%rax, %r9
movq	%r14, %rax
adcq	%rdx, %r10
adcq	$0x0, %rbx
movq	%r9, 0x50(%rsp)
movq	%r10, 0x58(%rsp)
mulq	%rbp
addq	%rax, %r12
movq	%rbp, %rax
adcq	$0x0, %rdx
xorq	%rcx, %rcx
addq	%r11, %r11
movq	%rdx, %r13
adcq	%r12, %r12
adcq	$0x0, %rcx
mulq	%rax
addq	%rbx, %rax
addq	%rax, %r11
movq	%r14, %rax
adcq	%rdx, %r12
adcq	$0x0, %rcx
movq	%r11, 0x60(%rsp)
movq	%r12, 0x68(%rsp)
xorq	%rbx, %rbx
addq	%r13, %r13
adcq	$0x0, %rbx
mulq	%rax
addq	%rcx, %rax
addq	%r13, %rax
adcq	%rbx, %rdx
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
movq	%xmm1, %rbp
movq	%rax, 0x70(%rsp)
movq	%rdx, 0x78(%rsp)
callq	__rsaz_512_reduce
addq	0x40(%rsp), %r8
adcq	0x48(%rsp), %r9
adcq	0x50(%rsp), %r10
adcq	0x58(%rsp), %r11
adcq	0x60(%rsp), %r12
adcq	0x68(%rsp), %r13
adcq	0x70(%rsp), %r14
adcq	0x78(%rsp), %r15
sbbq	%rcx, %rcx
callq	__rsaz_512_subtract
movq	%r8, %rdx
movq	%r9, %rax
movl	0x88(%rsp), %r8d
movq	%rdi, %rsi
decl	%r8d
jne	L_60
jmp	L_90d
nopl	(%rax)
L_480:
movl	%r8d, 0x88(%rsp)
movq	%rdi, %xmm0
mulxq	%rax, %r8, %r9
movq	%rax, %rbx
mulxq	0x10(%rsi), %rcx, %r10
xorq	%rbp, %rbp
mulxq	0x18(%rsi), %rax, %r11
adcxq	%rcx, %r9
mulxq	0x20(%rsi), %rcx, %r12
adcxq	%rax, %r10
mulxq	0x28(%rsi), %rax, %r13
adcxq	%rcx, %r11
mulxq	0x30(%rsi), %rcx, %r14
adcxq	%rax, %r12
adcxq	%rcx, %r13
mulxq	0x38(%rsi), %rax, %r15
adcxq	%rax, %r14
adcxq	%rbp, %r15
mulxq	%rdx, %rax, %rdi
movq	%rbx, %rdx
xorq	%rcx, %rcx
adoxq	%r8, %r8
adcxq	%rdi, %r8
adoxq	%rbp, %rcx
adcxq	%rbp, %rcx
movq	%rax, (%rsp)
movq	%r8, 0x8(%rsp)
mulxq	0x10(%rsi), %rax, %rbx
adoxq	%rax, %r10
adcxq	%rbx, %r11
mulxq	0x18(%rsi), %rdi, %r8
adoxq	%rdi, %r11
adcxq	%r8, %r12
mulxq	0x20(%rsi), %rax, %rbx
adoxq	%rax, %r12
adcxq	%rbx, %r13
mulxq	0x28(%rsi), %rdi, %r8
adoxq	%rdi, %r13
adcxq	%r8, %r14
mulxq	0x30(%rsi), %rax, %rbx
adoxq	%rax, %r14
adcxq	%rbx, %r15
mulxq	0x38(%rsi), %rdi, %r8
adoxq	%rdi, %r15
adcxq	%rbp, %r8
mulxq	%rdx, %rax, %rdi
adoxq	%rbp, %r8
movq	0x10(%rsi), %rdx
xorq	%rbx, %rbx
adoxq	%r9, %r9
adcxq	%rcx, %rax
adoxq	%r10, %r10
adcxq	%rax, %r9
adoxq	%rbp, %rbx
adcxq	%rdi, %r10
adcxq	%rbp, %rbx
movq	%r9, 0x10(%rsp)
movq	%r10, 0x18(%rsp)
mulxq	0x18(%rsi), %rdi, %r9
adoxq	%rdi, %r12
adcxq	%r9, %r13
mulxq	0x20(%rsi), %rax, %rcx
adoxq	%rax, %r13
adcxq	%rcx, %r14
mulxq	0x28(%rsi), %rdi, %r9
adoxq	%rdi, %r14
adcxq	%r9, %r15
mulxq	0x30(%rsi), %rax, %rcx
adoxq	%rax, %r15
adcxq	%rcx, %r8
mulxq	0x38(%rsi), %rdi, %r9
adoxq	%rdi, %r8
adcxq	%rbp, %r9
mulxq	%rdx, %rax, %rdi
adoxq	%rbp, %r9
movq	0x18(%rsi), %rdx
xorq	%rcx, %rcx
adoxq	%r11, %r11
adcxq	%rbx, %rax
adoxq	%r12, %r12
adcxq	%rax, %r11
adoxq	%rbp, %rcx
adcxq	%rdi, %r12
adcxq	%rbp, %rcx
movq	%r11, 0x20(%rsp)
movq	%r12, 0x28(%rsp)
mulxq	0x20(%rsi), %rax, %rbx
adoxq	%rax, %r14
adcxq	%rbx, %r15
mulxq	0x28(%rsi), %rdi, %r10
adoxq	%rdi, %r15
adcxq	%r10, %r8
mulxq	0x30(%rsi), %rax, %rbx
adoxq	%rax, %r8
adcxq	%rbx, %r9
mulxq	0x38(%rsi), %rdi, %r10
adoxq	%rdi, %r9
adcxq	%rbp, %r10
mulxq	%rdx, %rax, %rdi
adoxq	%rbp, %r10
movq	0x20(%rsi), %rdx
xorq	%rbx, %rbx
adoxq	%r13, %r13
adcxq	%rcx, %rax
adoxq	%r14, %r14
adcxq	%rax, %r13
adoxq	%rbp, %rbx
adcxq	%rdi, %r14
adcxq	%rbp, %rbx
movq	%r13, 0x30(%rsp)
movq	%r14, 0x38(%rsp)
mulxq	0x28(%rsi), %rdi, %r11
adoxq	%rdi, %r8
adcxq	%r11, %r9
mulxq	0x30(%rsi), %rax, %rcx
adoxq	%rax, %r9
adcxq	%rcx, %r10
mulxq	0x38(%rsi), %rdi, %r11
adoxq	%rdi, %r10
adcxq	%rbp, %r11
mulxq	%rdx, %rax, %rdi
movq	0x28(%rsi), %rdx
adoxq	%rbp, %r11
xorq	%rcx, %rcx
adoxq	%r15, %r15
adcxq	%rbx, %rax
adoxq	%r8, %r8
adcxq	%rax, %r15
adoxq	%rbp, %rcx
adcxq	%rdi, %r8
adcxq	%rbp, %rcx
movq	%r15, 0x40(%rsp)
movq	%r8, 0x48(%rsp)
mulxq	0x30(%rsi), %rax, %rbx
adoxq	%rax, %r10
adcxq	%rbx, %r11
mulxq	0x38(%rsi), %rdi, %r12
adoxq	%rdi, %r11
adcxq	%rbp, %r12
mulxq	%rdx, %rax, %rdi
adoxq	%rbp, %r12
movq	0x30(%rsi), %rdx
xorq	%rbx, %rbx
adoxq	%r9, %r9
adcxq	%rcx, %rax
adoxq	%r10, %r10
adcxq	%rax, %r9
adcxq	%rdi, %r10
adoxq	%rbp, %rbx
adcxq	%rbp, %rbx
movq	%r9, 0x50(%rsp)
movq	%r10, 0x58(%rsp)
mulxq	0x38(%rsi), %rax, %r13
adoxq	%rax, %r12
adoxq	%rbp, %r13
mulxq	%rdx, %rax, %rdi
xorq	%rcx, %rcx
movq	0x38(%rsi), %rdx
adoxq	%r11, %r11
adcxq	%rbx, %rax
adoxq	%r12, %r12
adcxq	%rax, %r11
adoxq	%rbp, %rcx
adcxq	%rdi, %r12
adcxq	%rbp, %rcx
movq	%r11, 0x60(%rsp)
movq	%r12, 0x68(%rsp)
mulxq	%rdx, %rax, %rdx
xorq	%rbx, %rbx
adoxq	%r13, %r13
adcxq	%rcx, %rax
adoxq	%rbp, %rbx
adcxq	%r13, %rax
adcxq	%rdx, %rbx
movq	%xmm0, %rdi
movq	%xmm1, %rbp
movq	0x80(%rsp), %rdx
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
movq	%rax, 0x70(%rsp)
movq	%rbx, 0x78(%rsp)
callq	__rsaz_512_reducex
addq	0x40(%rsp), %r8
adcq	0x48(%rsp), %r9
adcq	0x50(%rsp), %r10
adcq	0x58(%rsp), %r11
adcq	0x60(%rsp), %r12
adcq	0x68(%rsp), %r13
adcq	0x70(%rsp), %r14
adcq	0x78(%rsp), %r15
sbbq	%rcx, %rcx
callq	__rsaz_512_subtract
movq	%r8, %rdx
movq	%r9, %rax
movl	0x88(%rsp), %r8d
movq	%rdi, %rsi
decl	%r8d
jne	L_480
L_90d:
leaq	0xc8(%rsp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
rsaz_512_mul:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x98, %rsp
movq	%rdi, %xmm0
movq	%rcx, %xmm1
movq	%r8, 0x80(%rsp)
movl	$0x80100, %r11d
andl	OPENSSL_ia32cap_P+8(%rip), %r11d
cmpl	$0x80100, %r11d
je	L_9c0
movq	(%rdx), %rbx
movq	%rdx, %rbp
callq	__rsaz_512_mul
movq	%xmm0, %rdi
movq	%xmm1, %rbp
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
callq	__rsaz_512_reduce
jmp	L_a09
nopl	(%rax)
L_9c0:
movq	%rdx, %rbp
movq	(%rdx), %rdx
callq	__rsaz_512_mulx
movq	%xmm0, %rdi
movq	%xmm1, %rbp
movq	0x80(%rsp), %rdx
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
callq	__rsaz_512_reducex
L_a09:
addq	0x40(%rsp), %r8
adcq	0x48(%rsp), %r9
adcq	0x50(%rsp), %r10
adcq	0x58(%rsp), %r11
adcq	0x60(%rsp), %r12
adcq	0x68(%rsp), %r13
adcq	0x70(%rsp), %r14
adcq	0x78(%rsp), %r15
sbbq	%rcx, %rcx
callq	__rsaz_512_subtract
leaq	0xc8(%rsp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nop
rsaz_512_mul_gather4:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x98, %rsp
movd	%r9d, %xmm8
movdqa	bums_rodata+16(%rip), %xmm1
movdqa	bums_rodata(%rip), %xmm0
pshufd	$0x0, %xmm8, %xmm8
movdqa	%xmm1, %xmm7
movdqa	%xmm1, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm8, %xmm0
movdqa	%xmm7, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm8, %xmm1
movdqa	%xmm7, %xmm4
paddd	%xmm2, %xmm3
pcmpeqd	%xmm8, %xmm2
movdqa	%xmm7, %xmm5
paddd	%xmm3, %xmm4
pcmpeqd	%xmm8, %xmm3
movdqa	%xmm7, %xmm6
paddd	%xmm4, %xmm5
pcmpeqd	%xmm8, %xmm4
paddd	%xmm5, %xmm6
pcmpeqd	%xmm8, %xmm5
paddd	%xmm6, %xmm7
pcmpeqd	%xmm8, %xmm6
pcmpeqd	%xmm8, %xmm7
movdqa	(%rdx), %xmm8
movdqa	0x10(%rdx), %xmm9
movdqa	0x20(%rdx), %xmm10
movdqa	0x30(%rdx), %xmm11
pand	%xmm0, %xmm8
movdqa	0x40(%rdx), %xmm12
pand	%xmm1, %xmm9
movdqa	0x50(%rdx), %xmm13
pand	%xmm2, %xmm10
movdqa	0x60(%rdx), %xmm14
pand	%xmm3, %xmm11
movdqa	0x70(%rdx), %xmm15
leaq	0x80(%rdx), %rbp
pand	%xmm4, %xmm12
pand	%xmm5, %xmm13
pand	%xmm6, %xmm14
pand	%xmm7, %xmm15
por	%xmm10, %xmm8
por	%xmm11, %xmm9
por	%xmm12, %xmm8
por	%xmm13, %xmm9
por	%xmm14, %xmm8
por	%xmm15, %xmm9
por	%xmm9, %xmm8
pshufd	$0x4e, %xmm8, %xmm9
por	%xmm9, %xmm8
movl	$0x80100, %r11d
andl	OPENSSL_ia32cap_P+8(%rip), %r11d
cmpl	$0x80100, %r11d
je	L_e20
movq	%xmm8, %rbx
movq	%r8, 0x80(%rsp)
movq	%rdi, 0x88(%rsp)
movq	%rcx, 0x90(%rsp)
movq	(%rsi), %rax
movq	0x8(%rsi), %rcx
mulq	%rbx
movq	%rax, (%rsp)
movq	%rcx, %rax
movq	%rdx, %r8
mulq	%rbx
addq	%rax, %r8
movq	0x10(%rsi), %rax
movq	%rdx, %r9
adcq	$0x0, %r9
mulq	%rbx
addq	%rax, %r9
movq	0x18(%rsi), %rax
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r10
movq	0x20(%rsi), %rax
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r11
movq	0x28(%rsi), %rax
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%rbx
addq	%rax, %r12
movq	0x30(%rsi), %rax
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%rbx
addq	%rax, %r13
movq	0x38(%rsi), %rax
movq	%rdx, %r14
adcq	$0x0, %r14
mulq	%rbx
addq	%rax, %r14
movq	(%rsi), %rax
movq	%rdx, %r15
adcq	$0x0, %r15
leaq	0x8(%rsp), %rdi
movl	$0x7, %ecx
jmp	L_c60
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_c60:
movdqa	(%rbp), %xmm8
movdqa	0x10(%rbp), %xmm9
movdqa	0x20(%rbp), %xmm10
movdqa	0x30(%rbp), %xmm11
pand	%xmm0, %xmm8
movdqa	0x40(%rbp), %xmm12
pand	%xmm1, %xmm9
movdqa	0x50(%rbp), %xmm13
pand	%xmm2, %xmm10
movdqa	0x60(%rbp), %xmm14
pand	%xmm3, %xmm11
movdqa	0x70(%rbp), %xmm15
leaq	0x80(%rbp), %rbp
pand	%xmm4, %xmm12
pand	%xmm5, %xmm13
pand	%xmm6, %xmm14
pand	%xmm7, %xmm15
por	%xmm10, %xmm8
por	%xmm11, %xmm9
por	%xmm12, %xmm8
por	%xmm13, %xmm9
por	%xmm14, %xmm8
por	%xmm15, %xmm9
por	%xmm9, %xmm8
pshufd	$0x4e, %xmm8, %xmm9
por	%xmm9, %xmm8
movq	%xmm8, %rbx
mulq	%rbx
addq	%rax, %r8
movq	0x8(%rsi), %rax
movq	%r8, (%rdi)
movq	%rdx, %r8
adcq	$0x0, %r8
mulq	%rbx
addq	%rax, %r9
movq	0x10(%rsi), %rax
adcq	$0x0, %rdx
addq	%r9, %r8
movq	%rdx, %r9
adcq	$0x0, %r9
mulq	%rbx
addq	%rax, %r10
movq	0x18(%rsi), %rax
adcq	$0x0, %rdx
addq	%r10, %r9
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r11
movq	0x20(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r12
movq	0x28(%rsi), %rax
adcq	$0x0, %rdx
addq	%r12, %r11
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%rbx
addq	%rax, %r13
movq	0x30(%rsi), %rax
adcq	$0x0, %rdx
addq	%r13, %r12
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%rbx
addq	%rax, %r14
movq	0x38(%rsi), %rax
adcq	$0x0, %rdx
addq	%r14, %r13
movq	%rdx, %r14
adcq	$0x0, %r14
mulq	%rbx
addq	%rax, %r15
movq	(%rsi), %rax
adcq	$0x0, %rdx
addq	%r15, %r14
movq	%rdx, %r15
adcq	$0x0, %r15
leaq	0x8(%rdi), %rdi
decl	%ecx
jne	L_c60
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
movq	0x88(%rsp), %rdi
movq	0x90(%rsp), %rbp
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
callq	__rsaz_512_reduce
jmp	L_106f
nopl	(%rax)
L_e20:
movq	%xmm8, %rdx
movq	%r8, 0x80(%rsp)
movq	%rdi, 0x88(%rsp)
movq	%rcx, 0x90(%rsp)
mulxq	(%rsi), %rbx, %r8
movq	%rbx, (%rsp)
xorl	%edi, %edi
mulxq	0x8(%rsi), %rax, %r9
mulxq	0x10(%rsi), %rbx, %r10
adcxq	%rax, %r8
mulxq	0x18(%rsi), %rax, %r11
adcxq	%rbx, %r9
mulxq	0x20(%rsi), %rbx, %r12
adcxq	%rax, %r10
mulxq	0x28(%rsi), %rax, %r13
adcxq	%rbx, %r11
mulxq	0x30(%rsi), %rbx, %r14
adcxq	%rax, %r12
mulxq	0x38(%rsi), %rax, %r15
adcxq	%rbx, %r13
adcxq	%rax, %r14
addr32	movq	%r8, %rbx
adcxq	%rdi, %r15
movq	$-0x7, %rcx
jmp	L_ec0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_ec0:
movdqa	(%rbp), %xmm8
movdqa	0x10(%rbp), %xmm9
movdqa	0x20(%rbp), %xmm10
movdqa	0x30(%rbp), %xmm11
pand	%xmm0, %xmm8
movdqa	0x40(%rbp), %xmm12
pand	%xmm1, %xmm9
movdqa	0x50(%rbp), %xmm13
pand	%xmm2, %xmm10
movdqa	0x60(%rbp), %xmm14
pand	%xmm3, %xmm11
movdqa	0x70(%rbp), %xmm15
leaq	0x80(%rbp), %rbp
pand	%xmm4, %xmm12
pand	%xmm5, %xmm13
pand	%xmm6, %xmm14
pand	%xmm7, %xmm15
por	%xmm10, %xmm8
por	%xmm11, %xmm9
por	%xmm12, %xmm8
por	%xmm13, %xmm9
por	%xmm14, %xmm8
por	%xmm15, %xmm9
por	%xmm9, %xmm8
pshufd	$0x4e, %xmm8, %xmm9
por	%xmm9, %xmm8
movq	%xmm8, %rdx
mulxq	(%rsi), %rax, %r8
adcxq	%rax, %rbx
adoxq	%r9, %r8
mulxq	0x8(%rsi), %rax, %r9
adcxq	%rax, %r8
adoxq	%r10, %r9
mulxq	0x10(%rsi), %rax, %r10
adcxq	%rax, %r9
adoxq	%r11, %r10
mulxq	0x18(%rsi), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x20(%rsi), %rax, %r12
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x28(%rsi), %rax, %r13
adcxq	%rax, %r12
adoxq	%r14, %r13
mulxq	0x30(%rsi), %rax, %r14
adcxq	%rax, %r13
addr32	adoxq	%r15, %r14
mulxq	0x38(%rsi), %rax, %r15
movq	%rbx, 0x40(%rsp,%rcx,8)
adcxq	%rax, %r14
adoxq	%rdi, %r15
movq	%r8, %rbx
adcxq	%rdi, %r15
incq	%rcx
jne	L_ec0
movq	%r8, 0x40(%rsp)
movq	%r9, 0x48(%rsp)
movq	%r10, 0x50(%rsp)
movq	%r11, 0x58(%rsp)
movq	%r12, 0x60(%rsp)
movq	%r13, 0x68(%rsp)
movq	%r14, 0x70(%rsp)
movq	%r15, 0x78(%rsp)
movq	0x80(%rsp), %rdx
movq	0x88(%rsp), %rdi
movq	0x90(%rsp), %rbp
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
callq	__rsaz_512_reducex
L_106f:
addq	0x40(%rsp), %r8
adcq	0x48(%rsp), %r9
adcq	0x50(%rsp), %r10
adcq	0x58(%rsp), %r11
adcq	0x60(%rsp), %r12
adcq	0x68(%rsp), %r13
adcq	0x70(%rsp), %r14
adcq	0x78(%rsp), %r15
sbbq	%rcx, %rcx
callq	__rsaz_512_subtract
leaq	0xc8(%rsp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
rsaz_512_mul_scatter4:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movl	%r9d, %r9d
subq	$0x98, %rsp
leaq	(%r8,%r9,8), %r8
movq	%rdi, %xmm0
movq	%rdx, %xmm1
movq	%r8, %xmm2
movq	%rcx, 0x80(%rsp)
movq	%rdi, %rbp
movl	$0x80100, %r11d
andl	OPENSSL_ia32cap_P+8(%rip), %r11d
cmpl	$0x80100, %r11d
je	L_1180
movq	(%rdi), %rbx
callq	__rsaz_512_mul
movq	%xmm0, %rdi
movq	%xmm1, %rbp
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
callq	__rsaz_512_reduce
jmp	L_11c6
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1180:
movq	(%rdi), %rdx
callq	__rsaz_512_mulx
movq	%xmm0, %rdi
movq	%xmm1, %rbp
movq	0x80(%rsp), %rdx
movq	(%rsp), %r8
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r11
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
callq	__rsaz_512_reducex
L_11c6:
addq	0x40(%rsp), %r8
adcq	0x48(%rsp), %r9
adcq	0x50(%rsp), %r10
adcq	0x58(%rsp), %r11
adcq	0x60(%rsp), %r12
adcq	0x68(%rsp), %r13
adcq	0x70(%rsp), %r14
adcq	0x78(%rsp), %r15
movq	%xmm2, %rsi
sbbq	%rcx, %rcx
callq	__rsaz_512_subtract
movq	%r8, (%rsi)
movq	%r9, 0x80(%rsi)
movq	%r10, 0x100(%rsi)
movq	%r11, 0x180(%rsi)
movq	%r12, 0x200(%rsi)
movq	%r13, 0x280(%rsi)
movq	%r14, 0x300(%rsi)
movq	%r15, 0x380(%rsi)
leaq	0xc8(%rsp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nop
rsaz_512_mul_by_one:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x98, %rsp
movl	OPENSSL_ia32cap_P+8(%rip), %eax
movq	%rdx, %rbp
movq	%rcx, 0x80(%rsp)
movq	(%rsi), %r8
pxor	%xmm0, %xmm0
movq	0x8(%rsi), %r9
movq	0x10(%rsi), %r10
movq	0x18(%rsi), %r11
movq	0x20(%rsi), %r12
movq	0x28(%rsi), %r13
movq	0x30(%rsi), %r14
movq	0x38(%rsi), %r15
movdqa	%xmm0, (%rsp)
movdqa	%xmm0, 0x10(%rsp)
movdqa	%xmm0, 0x20(%rsp)
movdqa	%xmm0, 0x30(%rsp)
movdqa	%xmm0, 0x40(%rsp)
movdqa	%xmm0, 0x50(%rsp)
movdqa	%xmm0, 0x60(%rsp)
andl	$0x80100, %eax
cmpl	$0x80100, %eax
je	L_1300
callq	__rsaz_512_reduce
jmp	L_130d
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_1300:
movq	0x80(%rsp), %rdx
callq	__rsaz_512_reducex
L_130d:
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
leaq	0xc8(%rsp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
__rsaz_512_reduce:
movq	%r8, %rbx
imulq	0x88(%rsp), %rbx
movq	(%rbp), %rax
movl	$0x8, %ecx
jmp	L_1380
nopw	(%rax,%rax)
L_1380:
mulq	%rbx
movq	0x8(%rbp), %rax
negq	%r8
movq	%rdx, %r8
adcq	$0x0, %r8
mulq	%rbx
addq	%rax, %r9
movq	0x10(%rbp), %rax
adcq	$0x0, %rdx
addq	%r9, %r8
movq	%rdx, %r9
adcq	$0x0, %r9
mulq	%rbx
addq	%rax, %r10
movq	0x18(%rbp), %rax
adcq	$0x0, %rdx
addq	%r10, %r9
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r11
movq	0x20(%rbp), %rax
adcq	$0x0, %rdx
addq	%r11, %r10
movq	0x88(%rsp), %rsi
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbx
addq	%rax, %r12
movq	0x28(%rbp), %rax
adcq	$0x0, %rdx
imulq	%r8, %rsi
addq	%r12, %r11
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%rbx
addq	%rax, %r13
movq	0x30(%rbp), %rax
adcq	$0x0, %rdx
addq	%r13, %r12
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%rbx
addq	%rax, %r14
movq	0x38(%rbp), %rax
adcq	$0x0, %rdx
addq	%r14, %r13
movq	%rdx, %r14
adcq	$0x0, %r14
mulq	%rbx
movq	%rsi, %rbx
addq	%rax, %r15
movq	(%rbp), %rax
adcq	$0x0, %rdx
addq	%r15, %r14
movq	%rdx, %r15
adcq	$0x0, %r15
decl	%ecx
jne	L_1380
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
__rsaz_512_reducex:
imulq	%r8, %rdx
xorq	%rsi, %rsi
movl	$0x8, %ecx
jmp	L_1480
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_1480:
movq	%r8, %rbx
mulxq	(%rbp), %rax, %r8
adcxq	%rbx, %rax
adoxq	%r9, %r8
mulxq	0x8(%rbp), %rax, %r9
adcxq	%rax, %r8
adoxq	%r10, %r9
mulxq	0x10(%rbp), %rbx, %r10
adcxq	%rbx, %r9
adoxq	%r11, %r10
mulxq	0x18(%rbp), %rbx, %r11
adcxq	%rbx, %r10
adoxq	%r12, %r11
mulxq	0x20(%rbp), %rbx, %r12
movq	%rdx, %rax
movq	%r8, %rdx
adcxq	%rbx, %r11
adoxq	%r13, %r12
mulxq	0x88(%rsp), %rbx, %rdx
movq	%rax, %rdx
mulxq	0x28(%rbp), %rax, %r13
adcxq	%rax, %r12
adoxq	%r14, %r13
mulxq	0x30(%rbp), %rax, %r14
adcxq	%rax, %r13
adoxq	%r15, %r14
mulxq	0x38(%rbp), %rax, %r15
movq	%rbx, %rdx
adcxq	%rax, %r14
adoxq	%rsi, %r15
adcxq	%rsi, %r15
decl	%ecx
jne	L_1480
rep	retq
nop
__rsaz_512_subtract:
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
movq	(%rbp), %r8
movq	0x8(%rbp), %r9
negq	%r8
notq	%r9
andq	%rcx, %r8
movq	0x10(%rbp), %r10
andq	%rcx, %r9
notq	%r10
movq	0x18(%rbp), %r11
andq	%rcx, %r10
notq	%r11
movq	0x20(%rbp), %r12
andq	%rcx, %r11
notq	%r12
movq	0x28(%rbp), %r13
andq	%rcx, %r12
notq	%r13
movq	0x30(%rbp), %r14
andq	%rcx, %r13
notq	%r14
movq	0x38(%rbp), %r15
andq	%rcx, %r14
notq	%r15
andq	%rcx, %r15
addq	(%rdi), %r8
adcq	0x8(%rdi), %r9
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
__rsaz_512_mul:
leaq	0x8(%rsp), %rdi
movq	(%rsi), %rax
mulq	%rbx
movq	%rax, (%rdi)
movq	0x8(%rsi), %rax
movq	%rdx, %r8
mulq	%rbx
addq	%rax, %r8
movq	0x10(%rsi), %rax
movq	%rdx, %r9
adcq	$0x0, %r9
mulq	%rbx
addq	%rax, %r9
movq	0x18(%rsi), %rax
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r10
movq	0x20(%rsi), %rax
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r11
movq	0x28(%rsi), %rax
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%rbx
addq	%rax, %r12
movq	0x30(%rsi), %rax
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%rbx
addq	%rax, %r13
movq	0x38(%rsi), %rax
movq	%rdx, %r14
adcq	$0x0, %r14
mulq	%rbx
addq	%rax, %r14
movq	(%rsi), %rax
movq	%rdx, %r15
adcq	$0x0, %r15
leaq	0x8(%rbp), %rbp
leaq	0x8(%rdi), %rdi
movl	$0x7, %ecx
jmp	L_16a0
nopw	(%rax,%rax)
L_16a0:
movq	(%rbp), %rbx
mulq	%rbx
addq	%rax, %r8
movq	0x8(%rsi), %rax
movq	%r8, (%rdi)
movq	%rdx, %r8
adcq	$0x0, %r8
mulq	%rbx
addq	%rax, %r9
movq	0x10(%rsi), %rax
adcq	$0x0, %rdx
addq	%r9, %r8
movq	%rdx, %r9
adcq	$0x0, %r9
mulq	%rbx
addq	%rax, %r10
movq	0x18(%rsi), %rax
adcq	$0x0, %rdx
addq	%r10, %r9
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r11
movq	0x20(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r12
movq	0x28(%rsi), %rax
adcq	$0x0, %rdx
addq	%r12, %r11
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%rbx
addq	%rax, %r13
movq	0x30(%rsi), %rax
adcq	$0x0, %rdx
addq	%r13, %r12
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%rbx
addq	%rax, %r14
movq	0x38(%rsi), %rax
adcq	$0x0, %rdx
addq	%r14, %r13
movq	%rdx, %r14
leaq	0x8(%rbp), %rbp
adcq	$0x0, %r14
mulq	%rbx
addq	%rax, %r15
movq	(%rsi), %rax
adcq	$0x0, %rdx
addq	%r15, %r14
movq	%rdx, %r15
adcq	$0x0, %r15
leaq	0x8(%rdi), %rdi
decl	%ecx
jne	L_16a0
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
__rsaz_512_mulx:
mulxq	(%rsi), %rbx, %r8
movq	$-0x6, %rcx
mulxq	0x8(%rsi), %rax, %r9
movq	%rbx, 0x8(%rsp)
mulxq	0x10(%rsi), %rbx, %r10
adcq	%rax, %r8
mulxq	0x18(%rsi), %rax, %r11
adcq	%rbx, %r9
mulxq	0x20(%rsi), %rbx, %r12
adcq	%rax, %r10
mulxq	0x28(%rsi), %rax, %r13
adcq	%rbx, %r11
mulxq	0x30(%rsi), %rbx, %r14
adcq	%rax, %r12
mulxq	0x38(%rsi), %rax, %r15
movq	0x8(%rbp), %rdx
adcq	%rbx, %r13
adcq	%rax, %r14
adcq	$0x0, %r15
xorq	%rdi, %rdi
jmp	L_1800
nopl	(%rax)
L_1800:
movq	%r8, %rbx
mulxq	(%rsi), %rax, %r8
adcxq	%rax, %rbx
adoxq	%r9, %r8
mulxq	0x8(%rsi), %rax, %r9
adcxq	%rax, %r8
adoxq	%r10, %r9
mulxq	0x10(%rsi), %rax, %r10
adcxq	%rax, %r9
adoxq	%r11, %r10
mulxq	0x18(%rsi), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	%ds:0x20(%rsi), %rax, %r12
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x28(%rsi), %rax, %r13
adcxq	%rax, %r12
adoxq	%r14, %r13
mulxq	0x30(%rsi), %rax, %r14
adcxq	%rax, %r13
adoxq	%r15, %r14
mulxq	0x38(%rsi), %rax, %r15
movq	0x40(%rbp,%rcx,8), %rdx
movq	%rbx, 0x40(%rsp,%rcx,8)
adcxq	%rax, %r14
adoxq	%rdi, %r15
adcxq	%rdi, %r15
incq	%rcx
jne	L_1800
movq	%r8, %rbx
mulxq	(%rsi), %rax, %r8
adcxq	%rax, %rbx
adoxq	%r9, %r8
mulxq	0x8(%rsi), %rax, %r9
adcxq	%rax, %r8
adoxq	%r10, %r9
mulxq	0x10(%rsi), %rax, %r10
adcxq	%rax, %r9
adoxq	%r11, %r10
mulxq	0x18(%rsi), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x20(%rsi), %rax, %r12
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x28(%rsi), %rax, %r13
adcxq	%rax, %r12
adoxq	%r14, %r13
mulxq	0x30(%rsi), %rax, %r14
adcxq	%rax, %r13
adoxq	%r15, %r14
mulxq	0x38(%rsi), %rax, %r15
adcxq	%rax, %r14
adoxq	%rdi, %r15
adcxq	%rdi, %r15
movq	%rbx, 0x40(%rsp)
movq	%r8, 0x48(%rsp)
movq	%r9, 0x50(%rsp)
movq	%r10, 0x58(%rsp)
movq	%r11, 0x60(%rsp)
movq	%r12, 0x68(%rsp)
movq	%r13, 0x70(%rsp)
movq	%r14, 0x78(%rsp)
movq	%r15, 0x80(%rsp)
rep	retq
nopw	%cs:(%rax,%rax)
nop
rsaz_512_scatter4:
leaq	(%rdi,%rdx,8), %rdi
movl	$0x8, %r9d
jmp	L_19a0
nopl	(%rax)
L_19a0:
movq	(%rsi), %rax
leaq	0x8(%rsi), %rsi
movq	%rax, (%rdi)
leaq	0x80(%rdi), %rdi
decl	%r9d
jne	L_19a0
rep	retq
nopl	(%rax,%rax)
rsaz_512_gather4:
movd	%edx, %xmm8
movdqa	bums_rodata+16(%rip), %xmm1
movdqa	bums_rodata(%rip), %xmm0
pshufd	$0x0, %xmm8, %xmm8
movdqa	%xmm1, %xmm7
movdqa	%xmm1, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm8, %xmm0
movdqa	%xmm7, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm8, %xmm1
movdqa	%xmm7, %xmm4
paddd	%xmm2, %xmm3
pcmpeqd	%xmm8, %xmm2
movdqa	%xmm7, %xmm5
paddd	%xmm3, %xmm4
pcmpeqd	%xmm8, %xmm3
movdqa	%xmm7, %xmm6
paddd	%xmm4, %xmm5
pcmpeqd	%xmm8, %xmm4
paddd	%xmm5, %xmm6
pcmpeqd	%xmm8, %xmm5
paddd	%xmm6, %xmm7
pcmpeqd	%xmm8, %xmm6
pcmpeqd	%xmm8, %xmm7
movl	$0x8, %r9d
jmp	L_1a40
nop
L_1a40:
movdqa	(%rsi), %xmm8
movdqa	0x10(%rsi), %xmm9
movdqa	0x20(%rsi), %xmm10
movdqa	0x30(%rsi), %xmm11
pand	%xmm0, %xmm8
movdqa	0x40(%rsi), %xmm12
pand	%xmm1, %xmm9
movdqa	0x50(%rsi), %xmm13
pand	%xmm2, %xmm10
movdqa	0x60(%rsi), %xmm14
pand	%xmm3, %xmm11
movdqa	0x70(%rsi), %xmm15
leaq	0x80(%rsi), %rsi
pand	%xmm4, %xmm12
pand	%xmm5, %xmm13
pand	%xmm6, %xmm14
pand	%xmm7, %xmm15
por	%xmm10, %xmm8
por	%xmm11, %xmm9
por	%xmm12, %xmm8
por	%xmm13, %xmm9
por	%xmm14, %xmm8
por	%xmm15, %xmm9
por	%xmm9, %xmm8
pshufd	$0x4e, %xmm8, %xmm9
por	%xmm9, %xmm8
movq	%xmm8, (%rdi)
leaq	0x8(%rdi), %rdi
decl	%r9d
jne	L_1a40
rep	retq
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0
	.byte 2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
# ---- x86_64cpuid.S, for OPENSSL_ia32cap_P
	.text
	.text
OPENSSL_atomic_add:
endbr64
movl	(%rdi), %eax
Lx86_64cpuid__6:
leaq	(%rsi,%rax), %r8
lock
cmpxchgl	%r8d, (%rdi)
jne	Lx86_64cpuid__6
movl	%r8d, %eax
cltq
rep	retq
nopl	(%rax,%rax)
OPENSSL_rdtsc:
endbr64
rdtsc
shlq	$0x20, %rdx
orq	%rdx, %rax
rep	retq
nop
OPENSSL_ia32_cpuid:
endbr64
movq	%rbx, %r8
xorl	%eax, %eax
movq	%rax, 0x8(%rdi)
cpuid
movl	%eax, %r11d
xorl	%eax, %eax
cmpl	$0x756e6547, %ebx
setne	%al
movl	%eax, %r9d
cmpl	$0x49656e69, %edx
setne	%al
orl	%eax, %r9d
cmpl	$0x6c65746e, %ecx
setne	%al
orl	%eax, %r9d
je	Lx86_64cpuid__f5
cmpl	$0x68747541, %ebx
setne	%al
movl	%eax, %r10d
cmpl	$0x69746e65, %edx
setne	%al
orl	%eax, %r10d
cmpl	$0x444d4163, %ecx
setne	%al
orl	%eax, %r10d
jne	Lx86_64cpuid__f5
movl	$0x80000000, %eax
cpuid
cmpl	$0x80000001, %eax
jb	Lx86_64cpuid__f5
movl	%eax, %r10d
movl	$0x80000001, %eax
cpuid
orl	%ecx, %r9d
andl	$0x801, %r9d
cmpl	$0x80000008, %r10d
jb	Lx86_64cpuid__f5
movl	$0x80000008, %eax
cpuid
movzbq	%cl, %r10
incq	%r10
movl	$0x1, %eax
cpuid
btl	$0x1c, %edx
jae	Lx86_64cpuid__18a
shrl	$0x10, %ebx
cmpb	%r10b, %bl
ja	Lx86_64cpuid__18a
andl	$0xefffffff, %edx
jmp	Lx86_64cpuid__18a
Lx86_64cpuid__f5:
cmpl	$0x4, %r11d
movl	$0xffffffff, %r10d
jb	Lx86_64cpuid__11b
movl	$0x4, %eax
movl	$0x0, %ecx
cpuid
movl	%eax, %r10d
shrl	$0xe, %r10d
andl	$0xfff, %r10d
Lx86_64cpuid__11b:
movl	$0x1, %eax
cpuid
movd	%eax, %xmm0
andl	$0xbfefffff, %edx
cmpl	$0x0, %r9d
jne	Lx86_64cpuid__164
orl	$0x40000000, %edx
andb	$0xf, %ah
cmpb	$0xf, %ah
jne	Lx86_64cpuid__146
orl	$0x100000, %edx
Lx86_64cpuid__146:
cmpb	$0x6, %ah
jne	Lx86_64cpuid__164
andl	$0xfff0ff0, %eax
cmpl	$0x50670, %eax
je	Lx86_64cpuid__15e
cmpl	$0x80650, %eax
jne	Lx86_64cpuid__164
Lx86_64cpuid__15e:
andl	$0xfbffffff, %ecx
Lx86_64cpuid__164:
btl	$0x1c, %edx
jae	Lx86_64cpuid__18a
andl	$0xefffffff, %edx
cmpl	$0x0, %r10d
je	Lx86_64cpuid__18a
orl	$0x10000000, %edx
shrl	$0x10, %ebx
cmpb	$0x1, %bl
ja	Lx86_64cpuid__18a
andl	$0xefffffff, %edx
Lx86_64cpuid__18a:
andl	$0x800, %r9d
andl	$0xfffff7ff, %ecx
orl	%ecx, %r9d
movl	%edx, %r10d
cmpl	$0x7, %r11d
jb	Lx86_64cpuid__217
movl	$0x7, %eax
xorl	%ecx, %ecx
cpuid
movd	%eax, %xmm1
btl	$0x1a, %r9d
jb	Lx86_64cpuid__1bd
andl	$0xfff7ffff, %ebx
Lx86_64cpuid__1bd:
movd	%xmm0, %eax
andl	$0xfff0ff0, %eax
cmpl	$0x50650, %eax
jne	Lx86_64cpuid__1d3
andl	$0xfffeffff, %ebx
Lx86_64cpuid__1d3:
movl	%ebx, 0x8(%rdi)
movl	%ecx, 0xc(%rdi)
movl	%edx, 0x10(%rdi)
movd	%xmm1, %eax
cmpl	$0x1, %eax
jb	Lx86_64cpuid__217
movl	$0x7, %eax
movl	$0x1, %ecx
cpuid
movl	%eax, 0x14(%rdi)
movl	%edx, 0x18(%rdi)
movl	%ebx, 0x1c(%rdi)
movl	%ecx, 0x20(%rdi)
andl	$0x80000, %edx
cmpl	$0x0, %edx
je	Lx86_64cpuid__217
movl	$0x24, %eax
movl	$0x0, %ecx
cpuid
movl	%ebx, 0x24(%rdi)
Lx86_64cpuid__217:
btl	$0x1b, %r9d
jae	Lx86_64cpuid__23e
xorl	%ecx, %ecx
xgetbv
andl	$0xe6, %eax
cmpl	$0xe6, %eax
je	Lx86_64cpuid__255
andl	$0x3fdeffff, 0x8(%rdi)
andl	$0x6, %eax
cmpl	$0x6, %eax
je	Lx86_64cpuid__255
Lx86_64cpuid__23e:
andl	$0xff7fffff, 0x14(%rdi)
movl	$0xefffe7ff, %eax
andl	%eax, %r9d
movl	$0x3fdeffdf, %eax
andl	%eax, 0x8(%rdi)
Lx86_64cpuid__255:
shlq	$0x20, %r9
movl	%r10d, %eax
movq	%r8, %rbx
orq	%r9, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nop
OPENSSL_cleanse:
endbr64
xorq	%rax, %rax
cmpq	$0xf, %rsi
jae	Lx86_64cpuid__2a0
cmpq	$0x0, %rsi
je	Lx86_64cpuid__28f
Lx86_64cpuid__283:
movb	%al, (%rdi)
subq	$0x1, %rsi
leaq	0x1(%rdi), %rdi
jne	Lx86_64cpuid__283
Lx86_64cpuid__28f:
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64cpuid__2a0:
testq	$0x7, %rdi
je	Lx86_64cpuid__2b5
movb	%al, (%rdi)
leaq	-0x1(%rsi), %rsi
leaq	0x1(%rdi), %rdi
jmp	Lx86_64cpuid__2a0
Lx86_64cpuid__2b5:
movq	%rax, (%rdi)
leaq	-0x8(%rsi), %rsi
testq	$-0x8, %rsi
leaq	0x8(%rdi), %rdi
jne	Lx86_64cpuid__2b5
cmpq	$0x0, %rsi
jne	Lx86_64cpuid__283
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
CRYPTO_memcmp:
endbr64
xorq	%rax, %rax
xorq	%r10, %r10
cmpq	$0x0, %rdx
je	Lx86_64cpuid__33d
cmpq	$0x10, %rdx
jne	Lx86_64cpuid__320
movq	(%rdi), %r10
movq	0x8(%rdi), %r11
movq	$0x1, %rdx
xorq	(%rsi), %r10
xorq	0x8(%rsi), %r11
orq	%r11, %r10
cmovneq	%rdx, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nop
Lx86_64cpuid__320:
movb	(%rdi), %r10b
leaq	0x1(%rdi), %rdi
xorb	(%rsi), %r10b
leaq	0x1(%rsi), %rsi
orb	%r10b, %al
decq	%rdx
jne	Lx86_64cpuid__320
negq	%rax
shrq	$0x3f, %rax
Lx86_64cpuid__33d:
rep	retq
nop
OPENSSL_instrument_bus:
endbr64
movq	%rdi, %r10
movq	%rsi, %rcx
movq	%rsi, %r11
rdtsc
movl	%eax, %r8d
movl	$0x0, %r9d
clflush	(%r10)
lock
addl	%r9d, (%r10)
jmp	Lx86_64cpuid__370
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Lx86_64cpuid__370:
rdtsc
movl	%eax, %edx
subl	%r8d, %eax
movl	%edx, %r8d
movl	%eax, %r9d
clflush	(%r10)
lock
addl	%eax, (%r10)
leaq	0x4(%r10), %r10
subq	$0x1, %rcx
jne	Lx86_64cpuid__370
movq	%r11, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nop
OPENSSL_instrument_bus2:
endbr64
movq	%rdi, %r10
movq	%rsi, %rcx
movq	%rdx, %r11
movq	%rcx, 0x8(%rsp)
rdtsc
movl	%eax, %r8d
movl	$0x0, %r9d
clflush	(%r10)
lock
addl	%r9d, (%r10)
rdtsc
movl	%eax, %edx
subl	%r8d, %eax
movl	%edx, %r8d
movl	%eax, %r9d
Lx86_64cpuid__3d2:
clflush	(%r10)
lock
addl	%eax, (%r10)
subq	$0x1, %r11
je	Lx86_64cpuid__401
rdtsc
movl	%eax, %edx
subl	%r8d, %eax
movl	%edx, %r8d
cmpl	%r9d, %eax
movl	%eax, %r9d
movl	$0x0, %edx
setne	%dl
subq	%rdx, %rcx
leaq	(%r10,%rdx,4), %r10
jne	Lx86_64cpuid__3d2
Lx86_64cpuid__401:
movq	0x8(%rsp), %rax
subq	%rcx, %rax
rep	retq
nopl	(%rax,%rax)
OPENSSL_ia32_rdrand_bytes:
endbr64
xorq	%rax, %rax
cmpq	$0x0, %rsi
je	Lx86_64cpuid__473
movq	$0x8, %r11
Lx86_64cpuid__424:
rdrandq	%r10
jb	Lx86_64cpuid__440
decq	%r11
jne	Lx86_64cpuid__424
jmp	Lx86_64cpuid__473
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64cpuid__440:
cmpq	$0x8, %rsi
jb	Lx86_64cpuid__460
movq	%r10, (%rdi)
leaq	0x8(%rdi), %rdi
addq	$0x8, %rax
subq	$0x8, %rsi
je	Lx86_64cpuid__473
movq	$0x8, %r11
jmp	Lx86_64cpuid__424
Lx86_64cpuid__460:
movb	%r10b, (%rdi)
leaq	0x1(%rdi), %rdi
incq	%rax
shrq	$0x8, %r10
decq	%rsi
jne	Lx86_64cpuid__460
Lx86_64cpuid__473:
xorq	%r10, %r10
rep	retq
nopl	(%rax,%rax)
OPENSSL_ia32_rdseed_bytes:
endbr64
xorq	%rax, %rax
cmpq	$0x0, %rsi
je	Lx86_64cpuid__4e3
movq	$0x8, %r11
Lx86_64cpuid__494:
rdseedq	%r10
jb	Lx86_64cpuid__4b0
decq	%r11
jne	Lx86_64cpuid__494
jmp	Lx86_64cpuid__4e3
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64cpuid__4b0:
cmpq	$0x8, %rsi
jb	Lx86_64cpuid__4d0
movq	%r10, (%rdi)
leaq	0x8(%rdi), %rdi
addq	$0x8, %rax
subq	$0x8, %rsi
je	Lx86_64cpuid__4e3
movq	$0x8, %r11
jmp	Lx86_64cpuid__494
Lx86_64cpuid__4d0:
movb	%r10b, (%rdi)
leaq	0x1(%rdi), %rdi
incq	%rax
shrq	$0x8, %r10
decq	%rsi
jne	Lx86_64cpuid__4d0
Lx86_64cpuid__4e3:
xorq	%r10, %r10
rep	retq
	.section *COM*
	.zero 40
OPENSSL_ia32cap_P:
	.size OPENSSL_ia32cap_P, 4
	.zero 4

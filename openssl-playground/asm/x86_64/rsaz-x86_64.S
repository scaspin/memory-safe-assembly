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
bums_rodata:
	.byte 0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0
	.byte 2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0

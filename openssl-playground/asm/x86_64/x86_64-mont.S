	.text
bn_mul_mont:
movl	%r9d, %r9d
movq	%rsp, %rax
testl	$0x3, %r9d
jne	L_40
cmpl	$0x8, %r9d
jb	L_40
movl	OPENSSL_ia32cap_P+8(%rip), %r11d
cmpq	%rsi, %rdx
jne	L_2a6
testl	$0x7, %r9d
je	L_803
jmp	L_2a6
nopw	(%rax,%rax)
L_40:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
negq	%r9
movq	%rsp, %r11
leaq	-0x10(%rsp,%r9,8), %r10
negq	%r9
andq	$-0x400, %r10
subq	%r10, %r11
andq	$-0x1000, %r11
leaq	(%r10,%r11), %rsp
movq	(%rsp), %r11
cmpq	%r10, %rsp
ja	L_80
jmp	L_91
nopl	(%rax,%rax)
L_80:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r11
cmpq	%r10, %rsp
ja	L_80
L_91:
movq	%rax, 0x8(%rsp,%r9,8)
movq	%rdx, %r12
movq	(%r8), %r8
movq	(%r12), %rbx
movq	(%rsi), %rax
xorq	%r14, %r14
xorq	%r15, %r15
movq	%r8, %rbp
mulq	%rbx
movq	%rax, %r10
movq	(%rcx), %rax
imulq	%r10, %rbp
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	$0x0, %rdx
movq	%rdx, %r13
leaq	0x1(%r15), %r15
jmp	L_fd
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_e0:
addq	%rax, %r13
movq	(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %r13
movq	%r10, %r11
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
L_fd:
mulq	%rbx
addq	%rax, %r11
movq	(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
leaq	0x1(%r15), %r15
movq	%rdx, %r10
mulq	%rbp
cmpq	%r9, %r15
jne	L_e0
addq	%rax, %r13
movq	(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
movq	%r10, %r11
xorq	%rdx, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%rsp,%r9,8)
movq	%rdx, (%rsp,%r9,8)
leaq	0x1(%r14), %r14
jmp	L_150
nop
L_150:
movq	(%r12,%r14,8), %rbx
xorq	%r15, %r15
movq	%r8, %rbp
movq	(%rsp), %r10
mulq	%rbx
addq	%rax, %r10
movq	(%rcx), %rax
adcq	$0x0, %rdx
imulq	%r10, %rbp
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	$0x0, %rdx
movq	0x8(%rsp), %r10
movq	%rdx, %r13
leaq	0x1(%r15), %r15
jmp	L_1ae
nop
L_190:
addq	%rax, %r13
movq	(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
movq	(%rsp,%r15,8), %r10
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
L_1ae:
mulq	%rbx
addq	%rax, %r11
movq	(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
leaq	0x1(%r15), %r15
mulq	%rbp
cmpq	%r9, %r15
jne	L_190
addq	%rax, %r13
movq	(%rsi), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
movq	(%rsp,%r15,8), %r10
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
xorq	%rdx, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%rsp,%r9,8)
movq	%rdx, (%rsp,%r9,8)
leaq	0x1(%r14), %r14
cmpq	%r9, %r14
jb	L_150
xorq	%r14, %r14
movq	(%rsp), %rax
movq	%r9, %r15
L_220:
sbbq	(%rcx,%r14,8), %rax
movq	%rax, (%rdi,%r14,8)
movq	0x8(%rsp,%r14,8), %rax
leaq	0x1(%r14), %r14
decq	%r15
jne	L_220
sbbq	$0x0, %rax
movq	$-0x1, %rbx
xorq	%rax, %rbx
xorq	%r14, %r14
movq	%r9, %r15
L_24a:
movq	(%rdi,%r14,8), %rcx
movq	(%rsp,%r14,8), %rdx
andq	%rbx, %rcx
andq	%rax, %rdx
movq	%r9, (%rsp,%r14,8)
orq	%rcx, %rdx
movq	%rdx, (%rdi,%r14,8)
leaq	0x1(%r14), %r14
subq	$0x1, %r15
jne	L_24a
movq	0x8(%rsp,%r9,8), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
bn_mul4x_mont:
movl	%r9d, %r9d
movq	%rsp, %rax
L_2a6:
andl	$0x80100, %r11d
cmpl	$0x80100, %r11d
je	L_a03
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
negq	%r9
movq	%rsp, %r11
leaq	-0x20(%rsp,%r9,8), %r10
negq	%r9
andq	$-0x400, %r10
subq	%r10, %r11
andq	$-0x1000, %r11
leaq	(%r10,%r11), %rsp
movq	(%rsp), %r11
cmpq	%r10, %rsp
ja	L_2f2
jmp	L_303
L_2f2:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r11
cmpq	%r10, %rsp
ja	L_2f2
L_303:
movq	%rax, 0x8(%rsp,%r9,8)
movq	%rdi, 0x10(%rsp,%r9,8)
movq	%rdx, %r12
movq	(%r8), %r8
movq	(%r12), %rbx
movq	(%rsi), %rax
xorq	%r14, %r14
xorq	%r15, %r15
movq	%r8, %rbp
mulq	%rbx
movq	%rax, %r10
movq	(%rcx), %rax
imulq	%r10, %rbp
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	$0x0, %rdx
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	0x10(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
leaq	0x4(%r15), %r15
adcq	$0x0, %rdx
movq	%rdi, (%rsp)
movq	%rdx, %r13
jmp	L_380
nopw	(%rax,%rax)
L_380:
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x18(%rsp,%r15,8)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
mulq	%rbx
addq	%rax, %r10
movq	(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	0x8(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%rsp,%r15,8)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
leaq	0x4(%r15), %r15
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	-0x10(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x20(%rsp,%r15,8)
movq	%rdx, %r13
cmpq	%r9, %r15
jb	L_380
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x18(%rsp,%r15,8)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
xorq	%rdi, %rdi
addq	%r10, %r13
adcq	$0x0, %rdi
movq	%r13, -0x8(%rsp,%r15,8)
movq	%rdi, (%rsp,%r15,8)
leaq	0x1(%r14), %r14
L_4c0:
movq	(%r12,%r14,8), %rbx
xorq	%r15, %r15
movq	(%rsp), %r10
movq	%r8, %rbp
mulq	%rbx
addq	%rax, %r10
movq	(%rcx), %rax
adcq	$0x0, %rdx
imulq	%r10, %rbp
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	$0x0, %rdx
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx), %rax
adcq	$0x0, %rdx
addq	0x8(%rsp), %r11
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	0x10(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
leaq	0x4(%r15), %r15
adcq	$0x0, %rdx
movq	%rdi, (%rsp)
movq	%rdx, %r13
jmp	L_530
nop
L_530:
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	-0x10(%rsp,%r15,8), %r10
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x18(%rsp,%r15,8)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	-0x8(%rsp,%r15,8), %r11
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
mulq	%rbx
addq	%rax, %r10
movq	(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	(%rsp,%r15,8), %r10
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	0x8(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%rsp,%r15,8)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	0x8(%rsp,%r15,8), %r11
adcq	$0x0, %rdx
leaq	0x4(%r15), %r15
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	-0x10(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x20(%rsp,%r15,8)
movq	%rdx, %r13
cmpq	%r9, %r15
jb	L_530
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	-0x10(%rsp,%r15,8), %r10
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x18(%rsp,%r15,8)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	-0x8(%rsp,%r15,8), %r11
adcq	$0x0, %rdx
leaq	0x1(%r14), %r14
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
xorq	%rdi, %rdi
addq	%r10, %r13
adcq	$0x0, %rdi
addq	(%rsp,%r9,8), %r13
adcq	$0x0, %rdi
movq	%r13, -0x8(%rsp,%r15,8)
movq	%rdi, (%rsp,%r15,8)
cmpq	%r9, %r14
jb	L_4c0
movq	0x10(%rsp,%r9,8), %rdi
leaq	-0x4(%r9), %r15
movq	(%rsp), %rax
movq	0x8(%rsp), %rdx
shrq	$0x2, %r15
leaq	(%rsp), %rsi
xorq	%r14, %r14
subq	(%rcx), %rax
movq	0x10(%rsi), %rbx
movq	0x18(%rsi), %rbp
sbbq	0x8(%rcx), %rdx
L_6e2:
movq	%rax, (%rdi,%r14,8)
movq	%rdx, 0x8(%rdi,%r14,8)
sbbq	0x10(%rcx,%r14,8), %rbx
movq	0x20(%rsi,%r14,8), %rax
movq	0x28(%rsi,%r14,8), %rdx
sbbq	0x18(%rcx,%r14,8), %rbp
movq	%rbx, 0x10(%rdi,%r14,8)
movq	%rbp, 0x18(%rdi,%r14,8)
sbbq	0x20(%rcx,%r14,8), %rax
movq	0x30(%rsi,%r14,8), %rbx
movq	0x38(%rsi,%r14,8), %rbp
sbbq	0x28(%rcx,%r14,8), %rdx
leaq	0x4(%r14), %r14
decq	%r15
jne	L_6e2
movq	%rax, (%rdi,%r14,8)
movq	0x20(%rsi,%r14,8), %rax
sbbq	0x10(%rcx,%r14,8), %rbx
movq	%rdx, 0x8(%rdi,%r14,8)
sbbq	0x18(%rcx,%r14,8), %rbp
movq	%rbx, 0x10(%rdi,%r14,8)
sbbq	$0x0, %rax
movq	%rbp, 0x18(%rdi,%r14,8)
pxor	%xmm0, %xmm0
movq	%rax, %xmm4
pcmpeqd	%xmm5, %xmm5
pshufd	$0x0, %xmm4, %xmm4
movq	%r9, %r15
pxor	%xmm4, %xmm5
shrq	$0x2, %r15
xorl	%eax, %eax
jmp	L_770
nopl	(%rax)
L_770:
movdqa	(%rsp,%rax), %xmm1
movdqu	(%rdi,%rax), %xmm2
pand	%xmm4, %xmm1
pand	%xmm5, %xmm2
movdqa	0x10(%rsp,%rax), %xmm3
movdqa	%xmm0, (%rsp,%rax)
por	%xmm2, %xmm1
movdqu	0x10(%rdi,%rax), %xmm2
movdqu	%xmm1, (%rdi,%rax)
pand	%xmm4, %xmm3
pand	%xmm5, %xmm2
movdqa	%xmm0, 0x10(%rsp,%rax)
por	%xmm2, %xmm3
movdqu	%xmm3, 0x10(%rdi,%rax)
leaq	0x20(%rax), %rax
decq	%r15
jne	L_770
movq	0x8(%rsp,%r9,8), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
bn_sqr8x_mont:
movq	%rsp, %rax
L_803:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movl	%r9d, %r10d
shll	$0x3, %r9d
shlq	$0x5, %r10
negq	%r9
leaq	-0x40(%rsp,%r9,2), %r11
movq	%rsp, %rbp
movq	(%r8), %r8
subq	%rsi, %r11
andq	$0xfff, %r11
cmpq	%r11, %r10
jb	L_840
subq	%r11, %rbp
leaq	-0x40(%rbp,%r9,2), %rbp
jmp	L_85e
nop
L_840:
leaq	0xfc0(,%r9,2), %r10
leaq	-0x40(%rbp,%r9,2), %rbp
subq	%r10, %r11
movq	$0x0, %r10
cmovbq	%r10, %r11
subq	%r11, %rbp
L_85e:
andq	$-0x40, %rbp
movq	%rsp, %r11
subq	%rbp, %r11
andq	$-0x1000, %r11
leaq	(%r11,%rbp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	L_880
jmp	L_891
nop
L_880:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	L_880
L_891:
movq	%r9, %r10
negq	%r9
movq	%r8, 0x20(%rsp)
movq	%rax, 0x28(%rsp)
movq	%rcx, %xmm2
pxor	%xmm0, %xmm0
movq	%rdi, %xmm1
movq	%r10, %xmm3
movl	OPENSSL_ia32cap_P+8(%rip), %eax
andl	$0x80100, %eax
cmpl	$0x80100, %eax
jne	L_8e0
callq	bn_sqrx8x_internal
leaq	(%r8,%rcx), %rbx
movq	%rcx, %r9
movq	%rcx, %rdx
movq	%xmm1, %rdi
sarq	$0x5, %rcx
jmp	L_900
L_8e0:
callq	bn_sqr8x_internal
leaq	(%rdi,%r9), %rbx
movq	%r9, %rcx
movq	%r9, %rdx
movq	%xmm1, %rdi
sarq	$0x5, %rcx
jmp	L_900
nopw	(%rax,%rax)
L_900:
movq	(%rbx), %r12
movq	0x8(%rbx), %r13
movq	0x10(%rbx), %r14
movq	0x18(%rbx), %r15
leaq	0x20(%rbx), %rbx
sbbq	(%rbp), %r12
sbbq	0x8(%rbp), %r13
sbbq	0x10(%rbp), %r14
sbbq	0x18(%rbp), %r15
leaq	0x20(%rbp), %rbp
movq	%r12, (%rdi)
movq	%r13, 0x8(%rdi)
movq	%r14, 0x10(%rdi)
movq	%r15, 0x18(%rdi)
leaq	0x20(%rdi), %rdi
incq	%rcx
jne	L_900
sbbq	$0x0, %rax
leaq	(%rbx,%r9), %rbx
leaq	(%rdi,%r9), %rdi
movq	%rax, %xmm1
pxor	%xmm0, %xmm0
pshufd	$0x0, %xmm1, %xmm1
movq	0x28(%rsp), %rsi
jmp	L_960
L_960:
movdqa	(%rbx), %xmm2
movdqa	0x10(%rbx), %xmm3
leaq	0x20(%rbx), %rbx
movdqu	(%rdi), %xmm4
movdqu	0x10(%rdi), %xmm5
leaq	0x20(%rdi), %rdi
movdqa	%xmm0, -0x20(%rbx)
movdqa	%xmm0, -0x10(%rbx)
movdqa	%xmm0, -0x20(%rbx,%rdx)
movdqa	%xmm0, -0x10(%rbx,%rdx)
pcmpeqd	%xmm1, %xmm0
pand	%xmm1, %xmm2
pand	%xmm1, %xmm3
pand	%xmm0, %xmm4
pand	%xmm0, %xmm5
pxor	%xmm0, %xmm0
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqu	%xmm4, -0x20(%rdi)
movdqu	%xmm5, -0x10(%rdi)
addq	$0x20, %r9
jne	L_960
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
bn_mulx4x_mont:
movq	%rsp, %rax
L_a03:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shll	$0x3, %r9d
xorq	%r10, %r10
subq	%r9, %r10
movq	(%r8), %r8
leaq	-0x48(%rsp,%r10), %rbp
andq	$-0x80, %rbp
movq	%rsp, %r11
subq	%rbp, %r11
andq	$-0x1000, %r11
leaq	(%r11,%rbp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	L_a40
jmp	L_a51
nop
L_a40:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	L_a40
L_a51:
leaq	(%rdx,%r9), %r10
movq	%r9, (%rsp)
shrq	$0x5, %r9
movq	%r10, 0x10(%rsp)
subq	$0x1, %r9
movq	%r8, 0x18(%rsp)
movq	%rdi, 0x20(%rsp)
movq	%rax, 0x28(%rsp)
movq	%r9, 0x30(%rsp)
jmp	L_a80
nopl	(%rax)
L_a80:
leaq	0x8(%rdx), %rdi
movq	(%rdx), %rdx
leaq	0x60(%rsp), %rbx
movq	%rdx, %r9
mulxq	(%rsi), %r8, %rax
mulxq	0x8(%rsi), %r11, %r14
addq	%rax, %r11
movq	%rdi, 0x8(%rsp)
mulxq	0x10(%rsi), %r12, %r13
adcq	%r14, %r12
adcq	$0x0, %r13
movq	%r8, %rdi
imulq	0x18(%rsp), %r8
xorq	%rbp, %rbp
mulxq	0x18(%rsi), %rax, %r14
movq	%r8, %rdx
leaq	0x20(%rsi), %rsi
adcxq	%rax, %r13
adcxq	%rbp, %r14
mulxq	(%rcx), %rax, %r10
adcxq	%rax, %rdi
adoxq	%r11, %r10
mulxq	0x8(%rcx), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x10(%rcx), %rax, %r12
movq	0x30(%rsp), %rdi
movq	%r10, -0x20(%rbx)
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	%r11, -0x18(%rbx)
adcxq	%rax, %r12
adoxq	%rbp, %r15
leaq	0x20(%rcx), %rcx
movq	%r12, -0x10(%rbx)
jmp	L_b40
nopl	(%rax,%rax)
L_b40:
adcxq	%rbp, %r15
mulxq	(%rsi), %r10, %rax
adcxq	%r14, %r10
mulxq	0x8(%rsi), %r11, %r14
adcxq	%rax, %r11
mulxq	0x10(%rsi), %r12, %rax
adcxq	%r14, %r12
mulxq	0x18(%rsi), %r13, %r14
addr32	movq	%r8, %rdx
adcxq	%rax, %r13
adcxq	%rbp, %r14
leaq	0x20(%rsi), %rsi
leaq	0x20(%rbx), %rbx
adoxq	%r15, %r10
mulxq	(%rcx), %rax, %r15
adcxq	%rax, %r10
adoxq	%r15, %r11
mulxq	0x8(%rcx), %rax, %r15
adcxq	%rax, %r11
adoxq	%r15, %r12
mulxq	0x10(%rcx), %rax, %r15
movq	%r10, -0x28(%rbx)
adcxq	%rax, %r12
movq	%r11, -0x20(%rbx)
adoxq	%r15, %r13
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	%r12, -0x18(%rbx)
adcxq	%rax, %r13
adoxq	%rbp, %r15
leaq	0x20(%rcx), %rcx
movq	%r13, -0x10(%rbx)
decq	%rdi
jne	L_b40
movq	(%rsp), %rax
movq	0x8(%rsp), %rdi
adcq	%rbp, %r15
addq	%r15, %r14
sbbq	%r15, %r15
movq	%r14, -0x8(%rbx)
jmp	L_c20
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_c20:
movq	(%rdi), %rdx
leaq	0x8(%rdi), %rdi
subq	%rax, %rsi
movq	%r15, (%rbx)
leaq	0x60(%rsp), %rbx
subq	%rax, %rcx
mulxq	(%rsi), %r8, %r11
xorl	%ebp, %ebp
movq	%rdx, %r9
mulxq	0x8(%rsi), %r14, %r12
adoxq	-0x20(%rbx), %r8
adcxq	%r14, %r11
mulxq	0x10(%rsi), %r15, %r13
adoxq	-0x18(%rbx), %r11
adcxq	%r15, %r12
adoxq	-0x10(%rbx), %r12
adcxq	%rbp, %r13
adoxq	%rbp, %r13
movq	%rdi, 0x8(%rsp)
movq	%r8, %r15
imulq	0x18(%rsp), %r8
xorl	%ebp, %ebp
mulxq	0x18(%rsi), %rax, %r14
movq	%r8, %rdx
adcxq	%rax, %r13
adoxq	-0x8(%rbx), %r13
adcxq	%rbp, %r14
leaq	0x20(%rsi), %rsi
adoxq	%rbp, %r14
mulxq	(%rcx), %rax, %r10
adcxq	%rax, %r15
adoxq	%r11, %r10
mulxq	0x8(%rcx), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x10(%rcx), %rax, %r12
movq	%r10, -0x20(%rbx)
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	%r11, -0x18(%rbx)
leaq	0x20(%rcx), %rcx
adcxq	%rax, %r12
adoxq	%rbp, %r15
movq	0x30(%rsp), %rdi
movq	%r12, -0x10(%rbx)
jmp	L_d20
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_d20:
mulxq	(%rsi), %r10, %rax
adcxq	%rbp, %r15
adoxq	%r14, %r10
mulxq	0x8(%rsi), %r11, %r14
adcxq	(%rbx), %r10
adoxq	%rax, %r11
mulxq	0x10(%rsi), %r12, %rax
adcxq	0x8(%rbx), %r11
adoxq	%r14, %r12
mulxq	0x18(%rsi), %r13, %r14
movq	%r8, %rdx
adcxq	0x10(%rbx), %r12
adoxq	%rax, %r13
adcxq	0x18(%rbx), %r13
adoxq	%rbp, %r14
leaq	0x20(%rsi), %rsi
leaq	0x20(%rbx), %rbx
adcxq	%rbp, %r14
adoxq	%r15, %r10
mulxq	(%rcx), %rax, %r15
adcxq	%rax, %r10
adoxq	%r15, %r11
mulxq	0x8(%rcx), %rax, %r15
adcxq	%rax, %r11
adoxq	%r15, %r12
mulxq	0x10(%rcx), %rax, %r15
movq	%r10, -0x28(%rbx)
adcxq	%rax, %r12
adoxq	%r15, %r13
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	%r11, -0x20(%rbx)
movq	%r12, -0x18(%rbx)
adcxq	%rax, %r13
adoxq	%rbp, %r15
leaq	0x20(%rcx), %rcx
movq	%r13, -0x10(%rbx)
decq	%rdi
jne	L_d20
movq	(%rsp), %rax
movq	0x8(%rsp), %rdi
adcq	%rbp, %r15
subq	(%rbx), %rbp
adcq	%r15, %r14
sbbq	%r15, %r15
movq	%r14, -0x8(%rbx)
cmpq	0x10(%rsp), %rdi
jne	L_c20
leaq	0x40(%rsp), %rbx
subq	%rax, %rcx
negq	%r15
movq	%rax, %rdx
shrq	$0x5, %rax
movq	0x20(%rsp), %rdi
jmp	L_e40
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_e40:
movq	(%rbx), %r11
movq	0x8(%rbx), %r12
movq	0x10(%rbx), %r13
movq	0x18(%rbx), %r14
leaq	0x20(%rbx), %rbx
sbbq	(%rcx), %r11
sbbq	0x8(%rcx), %r12
sbbq	0x10(%rcx), %r13
sbbq	0x18(%rcx), %r14
leaq	0x20(%rcx), %rcx
movq	%r11, (%rdi)
movq	%r12, 0x8(%rdi)
movq	%r13, 0x10(%rdi)
movq	%r14, 0x18(%rdi)
leaq	0x20(%rdi), %rdi
decq	%rax
jne	L_e40
sbbq	$0x0, %r15
leaq	0x40(%rsp), %rbx
subq	%rdx, %rdi
movq	%r15, %xmm1
pxor	%xmm0, %xmm0
pshufd	$0x0, %xmm1, %xmm1
movq	0x28(%rsp), %rsi
jmp	L_ea0
nop
L_ea0:
movdqa	(%rbx), %xmm2
movdqa	0x10(%rbx), %xmm3
leaq	0x20(%rbx), %rbx
movdqu	(%rdi), %xmm4
movdqu	0x10(%rdi), %xmm5
leaq	0x20(%rdi), %rdi
movdqa	%xmm0, -0x20(%rbx)
movdqa	%xmm0, -0x10(%rbx)
pcmpeqd	%xmm1, %xmm0
pand	%xmm1, %xmm2
pand	%xmm1, %xmm3
pand	%xmm0, %xmm4
pand	%xmm0, %xmm5
pxor	%xmm0, %xmm0
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqu	%xmm4, -0x20(%rdi)
movdqu	%xmm5, -0x10(%rdi)
subq	$0x20, %rdx
jne	L_ea0
movq	%rdx, (%rbx)
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopl	(%rax,%rax)
# ---- x86_64-mont5.S, for bn_sqr8x_internal, bn_sqrx8x_internal
	.text
	.text
bn_mul_mont_gather5:
movl	%r9d, %r9d
movq	%rsp, %rax
testl	$0x7, %r9d
jne	Lx86_64_mont5__20
movl	OPENSSL_ia32cap_P+8(%rip), %r11d
jmp	Lx86_64_mont5__664
nopl	(%rax,%rax)
Lx86_64_mont5__20:
movd	0x8(%rsp), %xmm5
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
negq	%r9
movq	%rsp, %r11
leaq	-0x118(%rsp,%r9,8), %r10
negq	%r9
andq	$-0x400, %r10
subq	%r10, %r11
andq	$-0x1000, %r11
leaq	(%r10,%r11), %rsp
movq	(%rsp), %r11
cmpq	%r10, %rsp
ja	Lx86_64_mont5__61
jmp	Lx86_64_mont5__72
Lx86_64_mont5__61:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r11
cmpq	%r10, %rsp
ja	Lx86_64_mont5__61
Lx86_64_mont5__72:
leaq	bums_rodata(%rip), %r10
movq	%rax, 0x8(%rsp,%r9,8)
leaq	0x80(%rdx), %r12
movdqa	(%r10), %xmm0
movdqa	0x10(%r10), %xmm1
leaq	-0x58(%rsp,%r9,8), %r10
andq	$-0x10, %r10
pshufd	$0x0, %xmm5, %xmm5
movdqa	%xmm1, %xmm4
movdqa	%xmm1, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
addr32	movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x70(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x80(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x90(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0xa0(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0xb0(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0xc0(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0xd0(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0xe0(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0xf0(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x100(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x110(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0x120(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x130(%r10)
paddd	%xmm2, %xmm3
addr32	pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x140(%r10)
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x150(%r10)
pand	0x40(%r12), %xmm0
pand	0x50(%r12), %xmm1
pand	0x60(%r12), %xmm2
movdqa	%xmm3, 0x160(%r10)
pand	0x70(%r12), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	-0x80(%r12), %xmm4
movdqa	-0x70(%r12), %xmm5
movdqa	-0x60(%r12), %xmm2
pand	0x70(%r10), %xmm4
movdqa	-0x50(%r12), %xmm3
pand	0x80(%r10), %xmm5
por	%xmm4, %xmm0
pand	0x90(%r10), %xmm2
por	%xmm5, %xmm1
pand	0xa0(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	-0x40(%r12), %xmm4
movdqa	-0x30(%r12), %xmm5
movdqa	-0x20(%r12), %xmm2
pand	0xb0(%r10), %xmm4
movdqa	-0x10(%r12), %xmm3
pand	0xc0(%r10), %xmm5
por	%xmm4, %xmm0
pand	0xd0(%r10), %xmm2
por	%xmm5, %xmm1
pand	0xe0(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	(%r12), %xmm4
movdqa	0x10(%r12), %xmm5
movdqa	0x20(%r12), %xmm2
pand	0xf0(%r10), %xmm4
movdqa	0x30(%r12), %xmm3
pand	0x100(%r10), %xmm5
por	%xmm4, %xmm0
pand	0x110(%r10), %xmm2
por	%xmm5, %xmm1
pand	0x120(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
por	%xmm1, %xmm0
pshufd	$0x4e, %xmm0, %xmm1
por	%xmm1, %xmm0
leaq	0x100(%r12), %r12
movq	%xmm0, %rbx
movq	(%r8), %r8
movq	(%rsi), %rax
xorq	%r14, %r14
xorq	%r15, %r15
movq	%r8, %rbp
mulq	%rbx
movq	%rax, %r10
movq	(%rcx), %rax
imulq	%r10, %rbp
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	$0x0, %rdx
movq	%rdx, %r13
leaq	0x1(%r15), %r15
jmp	Lx86_64_mont5__36d
nopw	%cs:(%rax,%rax)
nop
Lx86_64_mont5__350:
addq	%rax, %r13
movq	(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %r13
movq	%r10, %r11
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
Lx86_64_mont5__36d:
mulq	%rbx
addq	%rax, %r11
movq	(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
leaq	0x1(%r15), %r15
movq	%rdx, %r10
mulq	%rbp
cmpq	%r9, %r15
jne	Lx86_64_mont5__350
addq	%rax, %r13
adcq	$0x0, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r9,8)
movq	%rdx, %r13
movq	%r10, %r11
xorq	%rdx, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%rsp,%r9,8)
movq	%rdx, (%rsp,%r9,8)
leaq	0x1(%r14), %r14
jmp	Lx86_64_mont5__3c0
nopl	(%rax)
Lx86_64_mont5__3c0:
leaq	0x98(%rsp,%r9,8), %rdx
andq	$-0x10, %rdx
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
movdqa	-0x80(%r12), %xmm0
movdqa	-0x70(%r12), %xmm1
movdqa	-0x60(%r12), %xmm2
movdqa	-0x50(%r12), %xmm3
pand	-0x80(%rdx), %xmm0
pand	-0x70(%rdx), %xmm1
por	%xmm0, %xmm4
pand	-0x60(%rdx), %xmm2
por	%xmm1, %xmm5
pand	-0x50(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	-0x40(%r12), %xmm0
movdqa	-0x30(%r12), %xmm1
movdqa	-0x20(%r12), %xmm2
movdqa	-0x10(%r12), %xmm3
pand	-0x40(%rdx), %xmm0
pand	-0x30(%rdx), %xmm1
por	%xmm0, %xmm4
pand	-0x20(%rdx), %xmm2
por	%xmm1, %xmm5
pand	-0x10(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	(%r12), %xmm0
movdqa	0x10(%r12), %xmm1
movdqa	0x20(%r12), %xmm2
movdqa	0x30(%r12), %xmm3
pand	(%rdx), %xmm0
pand	0x10(%rdx), %xmm1
por	%xmm0, %xmm4
pand	0x20(%rdx), %xmm2
por	%xmm1, %xmm5
pand	0x30(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	0x40(%r12), %xmm0
movdqa	0x50(%r12), %xmm1
movdqa	0x60(%r12), %xmm2
movdqa	0x70(%r12), %xmm3
pand	0x40(%rdx), %xmm0
pand	0x50(%rdx), %xmm1
por	%xmm0, %xmm4
pand	0x60(%rdx), %xmm2
por	%xmm1, %xmm5
pand	0x70(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
por	%xmm5, %xmm4
pshufd	$0x4e, %xmm4, %xmm0
por	%xmm4, %xmm0
leaq	0x100(%r12), %r12
movq	(%rsi), %rax
movq	%xmm0, %rbx
xorq	%r15, %r15
movq	%r8, %rbp
movq	(%rsp), %r10
mulq	%rbx
addq	%rax, %r10
movq	(%rcx), %rax
adcq	$0x0, %rdx
imulq	%r10, %rbp
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	$0x0, %rdx
movq	0x8(%rsp), %r10
movq	%rdx, %r13
leaq	0x1(%r15), %r15
jmp	Lx86_64_mont5__54e
nopl	(%rax)
Lx86_64_mont5__530:
addq	%rax, %r13
movq	(%rsi,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
movq	(%rsp,%r15,8), %r10
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r15,8)
movq	%rdx, %r13
Lx86_64_mont5__54e:
mulq	%rbx
addq	%rax, %r11
movq	(%rcx,%r15,8), %rax
adcq	$0x0, %rdx
addq	%r11, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
leaq	0x1(%r15), %r15
mulq	%rbp
cmpq	%r9, %r15
jne	Lx86_64_mont5__530
addq	%rax, %r13
adcq	$0x0, %rdx
addq	%r10, %r13
movq	(%rsp,%r9,8), %r10
adcq	$0x0, %rdx
movq	%r13, -0x10(%rsp,%r9,8)
movq	%rdx, %r13
xorq	%rdx, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%rsp,%r9,8)
movq	%rdx, (%rsp,%r9,8)
leaq	0x1(%r14), %r14
cmpq	%r9, %r14
jb	Lx86_64_mont5__3c0
xorq	%r14, %r14
movq	(%rsp), %rax
leaq	(%rsp), %rsi
movq	%r9, %r15
jmp	Lx86_64_mont5__5d0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Lx86_64_mont5__5d0:
sbbq	(%rcx,%r14,8), %rax
movq	%rax, (%rdi,%r14,8)
movq	0x8(%rsi,%r14,8), %rax
leaq	0x1(%r14), %r14
decq	%r15
jne	Lx86_64_mont5__5d0
sbbq	$0x0, %rax
movq	$-0x1, %rbx
xorq	%rax, %rbx
xorq	%r14, %r14
movq	%r9, %r15
Lx86_64_mont5__5fa:
movq	(%rdi,%r14,8), %rcx
movq	(%rsp,%r14,8), %rdx
andq	%rbx, %rcx
andq	%rax, %rdx
movq	%r14, (%rsp,%r14,8)
orq	%rcx, %rdx
movq	%rdx, (%rdi,%r14,8)
leaq	0x1(%r14), %r14
subq	$0x1, %r15
jne	Lx86_64_mont5__5fa
movq	0x8(%rsp,%r9,8), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
bn_mul4x_mont_gather5:
addr32	movq	%rsp, %rax
Lx86_64_mont5__664:
andl	$0x80108, %r11d
cmpl	$0x80108, %r11d
je	Lx86_64_mont5__1a03
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
addr32	shll	$0x3, %r9d
leaq	(%r9,%r9,2), %r10
negq	%r9
leaq	-0x140(%rsp,%r9,2), %r11
movq	%rsp, %rbp
subq	%rdi, %r11
andq	$0xfff, %r11
cmpq	%r11, %r10
jb	Lx86_64_mont5__6c0
subq	%r11, %rbp
leaq	-0x140(%rbp,%r9,2), %rbp
jmp	Lx86_64_mont5__6e1
nopw	%cs:(%rax,%rax)
nop
Lx86_64_mont5__6c0:
leaq	0xec0(,%r9,2), %r10
leaq	-0x140(%rbp,%r9,2), %rbp
subq	%r10, %r11
movq	$0x0, %r10
cmovbq	%r10, %r11
subq	%r11, %rbp
Lx86_64_mont5__6e1:
andq	$-0x40, %rbp
movq	%rsp, %r11
subq	%rbp, %r11
andq	$-0x1000, %r11
leaq	(%r11,%rbp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__701
jmp	Lx86_64_mont5__712
Lx86_64_mont5__701:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__701
Lx86_64_mont5__712:
negq	%r9
movq	%rax, 0x28(%rsp)
callq	mul4x_internal
movq	0x28(%rsp), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
mul4x_internal:
shlq	$0x5, %r9
movd	0x8(%rax), %xmm5
leaq	bums_rodata(%rip), %rax
leaq	0x80(%rdx,%r9), %r13
shrq	$0x5, %r9
movdqa	(%rax), %xmm0
movdqa	0x10(%rax), %xmm1
leaq	-0x18(%rsp,%r9), %r10
leaq	0x80(%rdx), %r12
pshufd	$0x0, %xmm5, %xmm5
movdqa	%xmm1, %xmm4
addr32	movdqa	%xmm1, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
addr32	movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x70(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x80(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x90(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0xa0(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0xb0(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0xc0(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0xd0(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0xe0(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0xf0(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x100(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x110(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0x120(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x130(%r10)
paddd	%xmm2, %xmm3
addr32	pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x140(%r10)
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x150(%r10)
pand	0x40(%r12), %xmm0
pand	0x50(%r12), %xmm1
pand	0x60(%r12), %xmm2
movdqa	%xmm3, 0x160(%r10)
pand	0x70(%r12), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	-0x80(%r12), %xmm4
movdqa	-0x70(%r12), %xmm5
movdqa	-0x60(%r12), %xmm2
pand	0x70(%r10), %xmm4
movdqa	-0x50(%r12), %xmm3
pand	0x80(%r10), %xmm5
por	%xmm4, %xmm0
pand	0x90(%r10), %xmm2
por	%xmm5, %xmm1
pand	0xa0(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	-0x40(%r12), %xmm4
movdqa	-0x30(%r12), %xmm5
movdqa	-0x20(%r12), %xmm2
pand	0xb0(%r10), %xmm4
movdqa	-0x10(%r12), %xmm3
pand	0xc0(%r10), %xmm5
por	%xmm4, %xmm0
pand	0xd0(%r10), %xmm2
por	%xmm5, %xmm1
pand	0xe0(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	(%r12), %xmm4
movdqa	0x10(%r12), %xmm5
movdqa	0x20(%r12), %xmm2
pand	0xf0(%r10), %xmm4
movdqa	0x30(%r12), %xmm3
pand	0x100(%r10), %xmm5
por	%xmm4, %xmm0
pand	0x110(%r10), %xmm2
por	%xmm5, %xmm1
pand	0x120(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
por	%xmm1, %xmm0
pshufd	$0x4e, %xmm0, %xmm1
por	%xmm1, %xmm0
leaq	0x100(%r12), %r12
movq	%xmm0, %rbx
movq	%r13, 0x18(%rsp)
movq	%rdi, 0x40(%rsp)
movq	(%r8), %r8
movq	(%rsi), %rax
leaq	(%rsi,%r9), %rsi
negq	%r9
movq	%r8, %rbp
mulq	%rbx
movq	%rax, %r10
movq	(%rcx), %rax
imulq	%r10, %rbp
leaq	0x48(%rsp), %r14
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi,%r9), %rax
adcq	$0x0, %rdx
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	0x10(%rsi,%r9), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
leaq	0x20(%r9), %r15
leaq	0x20(%rcx), %rcx
adcq	$0x0, %rdx
movq	%rdi, (%r14)
movq	%rdx, %r13
jmp	Lx86_64_mont5__aa0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
Lx86_64_mont5__aa0:
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx), %rax
leaq	0x20(%r14), %r14
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x18(%r14)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x10(%r14)
movq	%rdx, %r13
mulq	%rbx
addq	%rax, %r10
movq	(%rcx), %rax
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	0x8(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x8(%r14)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	0x10(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
leaq	0x20(%rcx), %rcx
adcq	$0x0, %rdx
movq	%rdi, (%r14)
movq	%rdx, %r13
addq	$0x20, %r15
jne	Lx86_64_mont5__aa0
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx), %rax
leaq	0x20(%r14), %r14
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%r13, -0x18(%r14)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx), %rax
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi,%r9), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%rdi, -0x10(%r14)
movq	%rdx, %r13
leaq	(%rcx,%r9), %rcx
xorq	%rdi, %rdi
addq	%r10, %r13
adcq	$0x0, %rdi
movq	%r13, -0x8(%r14)
jmp	Lx86_64_mont5__be0
nopl	(%rax)
Lx86_64_mont5__be0:
leaq	0x90(%r14), %rdx
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
movdqa	-0x80(%r12), %xmm0
movdqa	-0x70(%r12), %xmm1
movdqa	-0x60(%r12), %xmm2
movdqa	-0x50(%r12), %xmm3
pand	-0x80(%rdx), %xmm0
pand	-0x70(%rdx), %xmm1
por	%xmm0, %xmm4
pand	-0x60(%rdx), %xmm2
por	%xmm1, %xmm5
pand	-0x50(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	-0x40(%r12), %xmm0
movdqa	-0x30(%r12), %xmm1
movdqa	-0x20(%r12), %xmm2
movdqa	-0x10(%r12), %xmm3
pand	-0x40(%rdx), %xmm0
pand	-0x30(%rdx), %xmm1
por	%xmm0, %xmm4
pand	-0x20(%rdx), %xmm2
por	%xmm1, %xmm5
pand	-0x10(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	(%r12), %xmm0
movdqa	0x10(%r12), %xmm1
movdqa	0x20(%r12), %xmm2
movdqa	0x30(%r12), %xmm3
pand	(%rdx), %xmm0
pand	0x10(%rdx), %xmm1
por	%xmm0, %xmm4
pand	0x20(%rdx), %xmm2
por	%xmm1, %xmm5
pand	0x30(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	0x40(%r12), %xmm0
movdqa	0x50(%r12), %xmm1
movdqa	0x60(%r12), %xmm2
movdqa	0x70(%r12), %xmm3
pand	0x40(%rdx), %xmm0
pand	0x50(%rdx), %xmm1
por	%xmm0, %xmm4
pand	0x60(%rdx), %xmm2
por	%xmm1, %xmm5
pand	0x70(%rdx), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
por	%xmm5, %xmm4
pshufd	$0x4e, %xmm4, %xmm0
por	%xmm4, %xmm0
leaq	0x100(%r12), %r12
movq	%xmm0, %rbx
movq	(%r14,%r9), %r10
movq	%r8, %rbp
mulq	%rbx
addq	%rax, %r10
movq	(%rcx), %rax
adcq	$0x0, %rdx
imulq	%r10, %rbp
movq	%rdx, %r11
movq	%rdi, (%r14)
leaq	(%r14,%r9), %r14
mulq	%rbp
addq	%rax, %r10
movq	0x8(%rsi,%r9), %rax
adcq	$0x0, %rdx
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx), %rax
adcq	$0x0, %rdx
addq	0x8(%r14), %r11
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	0x10(%rsi,%r9), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
leaq	0x20(%r9), %r15
leaq	0x20(%rcx), %rcx
adcq	$0x0, %rdx
movq	%rdx, %r13
jmp	Lx86_64_mont5__d80
nopw	(%rax,%rax)
Lx86_64_mont5__d80:
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx), %rax
adcq	$0x0, %rdx
addq	0x10(%r14), %r10
leaq	0x20(%r14), %r14
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%rdi, -0x20(%r14)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	-0x8(%rcx), %rax
adcq	$0x0, %rdx
addq	-0x8(%r14), %r11
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%r13, -0x18(%r14)
movq	%rdx, %r13
mulq	%rbx
addq	%rax, %r10
movq	(%rcx), %rax
adcq	$0x0, %rdx
addq	(%r14), %r10
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	0x8(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%rdi, -0x10(%r14)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	0x8(%rcx), %rax
adcq	$0x0, %rdx
addq	0x8(%r14), %r11
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	0x10(%rsi,%r15), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
leaq	0x20(%rcx), %rcx
adcq	$0x0, %rdx
movq	%r13, -0x8(%r14)
movq	%rdx, %r13
addq	$0x20, %r15
jne	Lx86_64_mont5__d80
mulq	%rbx
addq	%rax, %r10
movq	-0x10(%rcx), %rax
adcq	$0x0, %rdx
addq	0x10(%r14), %r10
leaq	0x20(%r14), %r14
adcq	$0x0, %rdx
movq	%rdx, %r11
mulq	%rbp
addq	%rax, %r13
movq	-0x8(%rsi), %rax
adcq	$0x0, %rdx
addq	%r10, %r13
adcq	$0x0, %rdx
movq	%rdi, -0x20(%r14)
movq	%rdx, %rdi
mulq	%rbx
addq	%rax, %r11
movq	%rbp, %rax
movq	-0x8(%rcx), %rbp
adcq	$0x0, %rdx
addq	-0x8(%r14), %r11
adcq	$0x0, %rdx
movq	%rdx, %r10
mulq	%rbp
addq	%rax, %rdi
movq	(%rsi,%r9), %rax
adcq	$0x0, %rdx
addq	%r11, %rdi
adcq	$0x0, %rdx
movq	%r13, -0x18(%r14)
movq	%rdx, %r13
movq	%rdi, -0x10(%r14)
leaq	(%rcx,%r9), %rcx
xorq	%rdi, %rdi
addq	%r10, %r13
adcq	$0x0, %rdi
addq	(%r14), %r13
adcq	$0x0, %rdi
movq	%r13, -0x8(%r14)
cmpq	0x18(%rsp), %r12
jb	Lx86_64_mont5__be0
xorq	%rax, %rax
subq	%r13, %rbp
adcq	%r15, %r15
orq	%r15, %rdi
subq	%rdi, %rax
leaq	(%r14,%r9), %rbx
movq	(%rcx), %r12
leaq	(%rcx), %rbp
movq	%r9, %rcx
sarq	$0x5, %rcx
movq	0x40(%rsp), %rdi
decq	%r12
xorq	%r10, %r10
movq	0x8(%rbp), %r13
movq	0x10(%rbp), %r14
movq	0x18(%rbp), %r15
jmp	Lx86_64_mont5__19a0
nopl	(%rax)
bn_power5:
movq	%rsp, %rax
movl	OPENSSL_ia32cap_P+8(%rip), %r11d
andl	$0x80108, %r11d
cmpl	$0x80108, %r11d
je	Lx86_64_mont5__22c3
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shll	$0x3, %r9d
leal	(%r9,%r9,2), %r10d
negq	%r9
movq	(%r8), %r8
leaq	-0x140(%rsp,%r9,2), %r11
movq	%rsp, %rbp
subq	%rdi, %r11
andq	$0xfff, %r11
cmpq	%r11, %r10
jb	Lx86_64_mont5__fa0
subq	%r11, %rbp
leaq	-0x140(%rbp,%r9,2), %rbp
jmp	Lx86_64_mont5__fc1
nopl	(%rax)
Lx86_64_mont5__fa0:
leaq	0xec0(,%r9,2), %r10
leaq	-0x140(%rbp,%r9,2), %rbp
subq	%r10, %r11
movq	$0x0, %r10
cmovbq	%r10, %r11
subq	%r11, %rbp
Lx86_64_mont5__fc1:
andq	$-0x40, %rbp
movq	%rsp, %r11
subq	%rbp, %r11
andq	$-0x1000, %r11
leaq	(%r11,%rbp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__fe1
jmp	Lx86_64_mont5__ff2
Lx86_64_mont5__fe1:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__fe1
Lx86_64_mont5__ff2:
movq	%r9, %r10
negq	%r9
movq	%r8, 0x20(%rsp)
movq	%rax, 0x28(%rsp)
movq	%rdi, %xmm1
movq	%rcx, %xmm2
movq	%r10, %xmm3
movq	%rdx, %xmm4
callq	__bn_sqr8x_internal
callq	__bn_post4x_internal
callq	__bn_sqr8x_internal
callq	__bn_post4x_internal
callq	__bn_sqr8x_internal
callq	__bn_post4x_internal
callq	__bn_sqr8x_internal
callq	__bn_post4x_internal
callq	__bn_sqr8x_internal
callq	__bn_post4x_internal
movq	%xmm2, %rcx
movq	%xmm4, %rdx
movq	%rsi, %rdi
movq	0x28(%rsp), %rax
leaq	0x20(%rsp), %r8
callq	mul4x_internal
movq	0x28(%rsp), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
__bn_sqr8x_internal:
bn_sqr8x_internal:
leaq	0x20(%r10), %rbp
leaq	(%rsi,%r9), %rsi
movq	%r9, %rcx
movq	-0x20(%rsi,%rbp), %r14
leaq	0x38(%rsp,%r9,2), %rdi
movq	-0x18(%rsi,%rbp), %rax
leaq	-0x20(%rdi,%rbp), %rdi
movq	-0x10(%rsi,%rbp), %rbx
movq	%rax, %r15
mulq	%r14
movq	%rax, %r10
movq	%rbx, %rax
movq	%rdx, %r11
movq	%r10, -0x18(%rdi,%rbp)
mulq	%r14
addq	%rax, %r11
movq	%rbx, %rax
adcq	$0x0, %rdx
movq	%r11, -0x10(%rdi,%rbp)
movq	%rdx, %r10
movq	-0x8(%rsi,%rbp), %rbx
mulq	%r15
movq	%rax, %r12
movq	%rbx, %rax
movq	%rdx, %r13
leaq	(%rbp), %rcx
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
movq	%rdx, %r11
adcq	$0x0, %r11
addq	%r12, %r10
adcq	$0x0, %r11
movq	%r10, -0x8(%rdi,%rcx)
jmp	Lx86_64_mont5__1120
Lx86_64_mont5__1120:
movq	(%rsi,%rcx), %rbx
mulq	%r15
addq	%rax, %r13
movq	%rbx, %rax
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%r14
addq	%rax, %r11
movq	%rbx, %rax
movq	0x8(%rsi,%rcx), %rbx
movq	%rdx, %r10
adcq	$0x0, %r10
addq	%r13, %r11
adcq	$0x0, %r10
mulq	%r15
addq	%rax, %r12
movq	%rbx, %rax
movq	%r11, (%rdi,%rcx)
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
movq	0x10(%rsi,%rcx), %rbx
movq	%rdx, %r11
adcq	$0x0, %r11
addq	%r12, %r10
adcq	$0x0, %r11
mulq	%r15
addq	%rax, %r13
movq	%rbx, %rax
movq	%r10, 0x8(%rdi,%rcx)
movq	%rdx, %r12
adcq	$0x0, %r12
mulq	%r14
addq	%rax, %r11
movq	%rbx, %rax
movq	0x18(%rsi,%rcx), %rbx
movq	%rdx, %r10
adcq	$0x0, %r10
addq	%r13, %r11
adcq	$0x0, %r10
mulq	%r15
addq	%rax, %r12
movq	%rbx, %rax
movq	%r11, 0x10(%rdi,%rcx)
movq	%rdx, %r13
adcq	$0x0, %r13
leaq	0x20(%rcx), %rcx
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
movq	%rdx, %r11
adcq	$0x0, %r11
addq	%r12, %r10
adcq	$0x0, %r11
movq	%r10, -0x8(%rdi,%rcx)
cmpq	$0x0, %rcx
jne	Lx86_64_mont5__1120
mulq	%r15
addq	%rax, %r13
leaq	0x10(%rbp), %rbp
adcq	$0x0, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, (%rdi)
movq	%rdx, %r12
movq	%rdx, 0x8(%rdi)
jmp	Lx86_64_mont5__1220
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64_mont5__1220:
movq	-0x20(%rsi,%rbp), %r14
leaq	0x38(%rsp,%r9,2), %rdi
movq	-0x18(%rsi,%rbp), %rax
leaq	-0x20(%rdi,%rbp), %rdi
movq	-0x10(%rsi,%rbp), %rbx
movq	%rax, %r15
mulq	%r14
movq	-0x18(%rdi,%rbp), %r10
addq	%rax, %r10
movq	%rbx, %rax
adcq	$0x0, %rdx
movq	%r10, -0x18(%rdi,%rbp)
movq	%rdx, %r11
mulq	%r14
addq	%rax, %r11
movq	%rbx, %rax
adcq	$0x0, %rdx
addq	-0x10(%rdi,%rbp), %r11
movq	%rdx, %r10
adcq	$0x0, %r10
movq	%r11, -0x10(%rdi,%rbp)
xorq	%r12, %r12
movq	-0x8(%rsi,%rbp), %rbx
mulq	%r15
addq	%rax, %r12
movq	%rbx, %rax
adcq	$0x0, %rdx
addq	-0x8(%rdi,%rbp), %r12
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
adcq	$0x0, %rdx
addq	%r12, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
movq	%r10, -0x8(%rdi,%rbp)
leaq	(%rbp), %rcx
jmp	Lx86_64_mont5__12c0
nopw	(%rax,%rax)
Lx86_64_mont5__12c0:
movq	(%rsi,%rcx), %rbx
mulq	%r15
addq	%rax, %r13
movq	%rbx, %rax
movq	%rdx, %r12
adcq	$0x0, %r12
addq	(%rdi,%rcx), %r13
adcq	$0x0, %r12
addr32	mulq	%r14
addq	%rax, %r11
movq	%rbx, %rax
movq	0x8(%rsi,%rcx), %rbx
movq	%rdx, %r10
adcq	$0x0, %r10
addq	%r13, %r11
adcq	$0x0, %r10
mulq	%r15
addq	%rax, %r12
movq	%r11, (%rdi,%rcx)
movq	%rbx, %rax
movq	%rdx, %r13
adcq	$0x0, %r13
addq	0x8(%rdi,%rcx), %r12
leaq	0x10(%rcx), %rcx
adcq	$0x0, %r13
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
adcq	$0x0, %rdx
addq	%r12, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
movq	%r10, -0x8(%rdi,%rcx)
cmpq	$0x0, %rcx
jne	Lx86_64_mont5__12c0
addr32	mulq	%r15
addq	%rax, %r13
adcq	$0x0, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, (%rdi)
movq	%rdx, %r12
movq	%rdx, 0x8(%rdi)
addq	$0x10, %rbp
jne	Lx86_64_mont5__1220
movq	-0x20(%rsi), %r14
leaq	0x38(%rsp,%r9,2), %rdi
movq	-0x18(%rsi), %rax
leaq	-0x20(%rdi,%rbp), %rdi
movq	-0x10(%rsi), %rbx
movq	%rax, %r15
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%r14
addq	%rax, %r11
movq	%rbx, %rax
movq	%r10, -0x18(%rdi)
movq	%rdx, %r10
adcq	$0x0, %r10
addq	%r13, %r11
movq	-0x8(%rsi), %rbx
adcq	$0x0, %r10
mulq	%r15
addq	%rax, %r12
movq	%rbx, %rax
movq	%r11, -0x10(%rdi)
movq	%rdx, %r13
adcq	$0x0, %r13
mulq	%r14
addq	%rax, %r10
movq	%rbx, %rax
movq	%rdx, %r11
adcq	$0x0, %r11
addq	%r12, %r10
adcq	$0x0, %r11
movq	%r10, -0x8(%rdi)
mulq	%r15
addq	%rax, %r13
movq	-0x10(%rsi), %rax
adcq	$0x0, %rdx
addq	%r11, %r13
adcq	$0x0, %rdx
movq	%r13, (%rdi)
movq	%rdx, %r12
movq	%rdx, 0x8(%rdi)
mulq	%rbx
addq	$0x10, %rbp
xorq	%r14, %r14
subq	%r9, %rbp
xorq	%r15, %r15
addq	%r12, %rax
adcq	$0x0, %rdx
movq	%rax, 0x8(%rdi)
movq	%rdx, 0x10(%rdi)
movq	%r15, 0x18(%rdi)
movq	-0x10(%rsi,%rbp), %rax
leaq	0x38(%rsp), %rdi
xorq	%r10, %r10
movq	0x8(%rdi), %r11
leaq	(%r14,%r10,2), %r12
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r13
shrq	$0x3f, %r11
orq	%r10, %r13
movq	0x10(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	0x18(%rdi), %r11
adcq	%rax, %r12
movq	-0x8(%rsi,%rbp), %rax
movq	%r12, (%rdi)
adcq	%rdx, %r13
leaq	(%r14,%r10,2), %rbx
movq	%r13, 0x8(%rdi)
sbbq	%r15, %r15
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r8
shrq	$0x3f, %r11
orq	%r10, %r8
movq	0x20(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	0x28(%rdi), %r11
adcq	%rax, %rbx
movq	(%rsi,%rbp), %rax
movq	%rbx, 0x10(%rdi)
adcq	%rdx, %r8
leaq	0x10(%rbp), %rbp
movq	%r8, 0x18(%rdi)
sbbq	%r15, %r15
leaq	0x40(%rdi), %rdi
jmp	Lx86_64_mont5__14c0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Lx86_64_mont5__14c0:
leaq	(%r14,%r10,2), %r12
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r13
shrq	$0x3f, %r11
orq	%r10, %r13
movq	-0x10(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	-0x8(%rdi), %r11
adcq	%rax, %r12
movq	-0x8(%rsi,%rbp), %rax
movq	%r12, -0x20(%rdi)
adcq	%rdx, %r13
leaq	(%r14,%r10,2), %rbx
movq	%r13, -0x18(%rdi)
sbbq	%r15, %r15
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r8
shrq	$0x3f, %r11
orq	%r10, %r8
movq	(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	0x8(%rdi), %r11
adcq	%rax, %rbx
movq	(%rsi,%rbp), %rax
movq	%rbx, -0x10(%rdi)
adcq	%rdx, %r8
leaq	(%r14,%r10,2), %r12
movq	%r8, -0x8(%rdi)
sbbq	%r15, %r15
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r13
shrq	$0x3f, %r11
orq	%r10, %r13
movq	0x10(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	0x18(%rdi), %r11
adcq	%rax, %r12
movq	0x8(%rsi,%rbp), %rax
movq	%r12, (%rdi)
adcq	%rdx, %r13
leaq	(%r14,%r10,2), %rbx
movq	%r13, 0x8(%rdi)
sbbq	%r15, %r15
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r8
shrq	$0x3f, %r11
orq	%r10, %r8
movq	0x20(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	0x28(%rdi), %r11
adcq	%rax, %rbx
movq	0x10(%rsi,%rbp), %rax
movq	%rbx, 0x10(%rdi)
adcq	%rdx, %r8
movq	%r8, 0x18(%rdi)
sbbq	%r15, %r15
leaq	0x40(%rdi), %rdi
addq	$0x20, %rbp
jne	Lx86_64_mont5__14c0
leaq	(%r14,%r10,2), %r12
addr32	shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r13
shrq	$0x3f, %r11
orq	%r10, %r13
movq	-0x10(%rdi), %r10
movq	%r11, %r14
mulq	%rax
negq	%r15
movq	-0x8(%rdi), %r11
adcq	%rax, %r12
movq	-0x8(%rsi), %rax
movq	%r12, -0x20(%rdi)
adcq	%rdx, %r13
leaq	(%r14,%r10,2), %rbx
movq	%r13, -0x18(%rdi)
sbbq	%r15, %r15
shrq	$0x3f, %r10
leaq	(%rcx,%r11,2), %r8
shrq	$0x3f, %r11
orq	%r10, %r8
mulq	%rax
negq	%r15
adcq	%rax, %rbx
adcq	%rdx, %r8
movq	%rbx, -0x10(%rdi)
movq	%r8, -0x8(%rdi)
movq	%xmm2, %rbp
__bn_sqr8x_reduction:
xorq	%rax, %rax
leaq	(%r9,%rbp), %rcx
leaq	0x38(%rsp,%r9,2), %rdx
movq	%rcx, 0x8(%rsp)
leaq	0x38(%rsp,%r9), %rdi
movq	%rdx, 0x10(%rsp)
negq	%r9
jmp	Lx86_64_mont5__1640
nopl	(%rax)
Lx86_64_mont5__1640:
leaq	(%rdi,%r9), %rdi
movq	(%rdi), %rbx
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movq	0x20(%rdi), %r12
movq	0x28(%rdi), %r13
movq	0x30(%rdi), %r14
movq	0x38(%rdi), %r15
movq	%rax, (%rdx)
leaq	0x40(%rdi), %rdi
addr32	movq	%rbx, %r8
imulq	0x28(%rsp), %rbx
movq	(%rbp), %rax
movl	$0x8, %ecx
jmp	Lx86_64_mont5__1680
Lx86_64_mont5__1680:
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
movq	%rbx, 0x30(%rsp,%rcx,8)
movq	%rdx, %r9
adcq	$0x0, %r9
mulq	%rbx
addq	%rax, %r10
movq	0x18(%rbp), %rax
adcq	$0x0, %rdx
addq	%r10, %r9
movq	0x28(%rsp), %rsi
movq	%rdx, %r10
adcq	$0x0, %r10
mulq	%rbx
addq	%rax, %r11
movq	0x20(%rbp), %rax
adcq	$0x0, %rdx
imulq	%r8, %rsi
addq	%r11, %r10
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r12
movq	0x28(%rbp), %rax
adcq	$0x0, %rdx
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
jne	Lx86_64_mont5__1680
leaq	0x40(%rbp), %rbp
xorq	%rax, %rax
movq	0x10(%rsp), %rdx
cmpq	0x8(%rsp), %rbp
jae	Lx86_64_mont5__18e9
addq	(%rdi), %r8
adcq	0x8(%rdi), %r9
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
sbbq	%rsi, %rsi
movq	0x70(%rsp), %rbx
movl	$0x8, %ecx
movq	(%rbp), %rax
jmp	Lx86_64_mont5__17a0
nopl	(%rax)
Lx86_64_mont5__17a0:
mulq	%rbx
addq	%rax, %r8
movq	0x8(%rbp), %rax
movq	%r8, (%rdi)
movq	%rdx, %r8
adcq	$0x0, %r8
mulq	%rbx
addq	%rax, %r9
movq	0x10(%rbp), %rax
adcq	$0x0, %rdx
addq	%r9, %r8
leaq	0x8(%rdi), %rdi
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
movq	%rdx, %r11
adcq	$0x0, %r11
mulq	%rbx
addq	%rax, %r12
movq	0x28(%rbp), %rax
adcq	$0x0, %rdx
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
movq	0x28(%rsp,%rcx,8), %rbx
addq	%rax, %r15
adcq	$0x0, %rdx
addq	%r15, %r14
movq	(%rbp), %rax
movq	%rdx, %r15
adcq	$0x0, %r15
decl	%ecx
jne	Lx86_64_mont5__17a0
leaq	0x40(%rbp), %rbp
movq	0x10(%rsp), %rdx
cmpq	0x8(%rsp), %rbp
jae	Lx86_64_mont5__18c0
movq	0x70(%rsp), %rbx
negq	%rsi
movq	(%rbp), %rax
adcq	(%rdi), %r8
adcq	0x8(%rdi), %r9
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
sbbq	%rsi, %rsi
movl	$0x8, %ecx
jmp	Lx86_64_mont5__17a0
nopw	%cs:(%rax,%rax)
nop
Lx86_64_mont5__18c0:
xorq	%rax, %rax
addq	(%rdx), %r8
adcq	$0x0, %r9
adcq	$0x0, %r10
adcq	$0x0, %r11
adcq	$0x0, %r12
adcq	$0x0, %r13
adcq	$0x0, %r14
adcq	$0x0, %r15
adcq	$0x0, %rax
negq	%rsi
Lx86_64_mont5__18e9:
adcq	(%rdi), %r8
adcq	0x8(%rdi), %r9
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
adcq	$0x0, %rax
movq	-0x8(%rbp), %rcx
xorq	%rsi, %rsi
movq	%xmm2, %rbp
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%xmm3, %r9
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
leaq	0x40(%rdi), %rdi
cmpq	%rdx, %rdi
jb	Lx86_64_mont5__1640
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
__bn_post4x_internal:
movq	(%rbp), %r12
leaq	(%rdi,%r9), %rbx
movq	%r9, %rcx
movq	%xmm1, %rdi
negq	%rax
movq	%xmm1, %rsi
sarq	$0x5, %rcx
decq	%r12
xorq	%r10, %r10
movq	0x8(%rbp), %r13
movq	0x10(%rbp), %r14
movq	0x18(%rbp), %r15
jmp	Lx86_64_mont5__19a0
Lx86_64_mont5__1990:
movq	(%rbp), %r12
movq	0x8(%rbp), %r13
movq	0x10(%rbp), %r14
movq	0x18(%rbp), %r15
Lx86_64_mont5__19a0:
leaq	0x20(%rbp), %rbp
notq	%r12
notq	%r13
notq	%r14
notq	%r15
andq	%rax, %r12
andq	%rax, %r13
andq	%rax, %r14
andq	%rax, %r15
negq	%r10
adcq	(%rbx), %r12
adcq	0x8(%rbx), %r13
adcq	0x10(%rbx), %r14
adcq	0x18(%rbx), %r15
movq	%r12, (%rdi)
leaq	0x20(%rbx), %rbx
movq	%r13, 0x8(%rdi)
sbbq	%r10, %r10
movq	%r14, 0x10(%rdi)
movq	%r15, 0x18(%rdi)
leaq	0x20(%rdi), %rdi
incq	%rcx
jne	Lx86_64_mont5__1990
movq	%r9, %r10
negq	%r9
rep	retq
nopw	%cs:(%rax,%rax)
nop
bn_mulx4x_mont_gather5:
movq	%rsp, %rax
Lx86_64_mont5__1a03:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shll	$0x3, %r9d
leaq	(%r9,%r9,2), %r10
negq	%r9
movq	(%r8), %r8
leaq	-0x140(%rsp,%r9,2), %r11
movq	%rsp, %rbp
subq	%rdi, %r11
andq	$0xfff, %r11
cmpq	%r11, %r10
jb	Lx86_64_mont5__1a42
subq	%r11, %rbp
leaq	-0x140(%rbp,%r9,2), %rbp
jmp	Lx86_64_mont5__1a63
Lx86_64_mont5__1a42:
leaq	0xec0(,%r9,2), %r10
leaq	-0x140(%rbp,%r9,2), %rbp
subq	%r10, %r11
movq	$0x0, %r10
cmovbq	%r10, %r11
subq	%r11, %rbp
Lx86_64_mont5__1a63:
andq	$-0x40, %rbp
movq	%rsp, %r11
subq	%rbp, %r11
andq	$-0x1000, %r11
leaq	(%r11,%rbp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__1a83
jmp	Lx86_64_mont5__1a94
Lx86_64_mont5__1a83:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__1a83
Lx86_64_mont5__1a94:
movq	%r8, 0x20(%rsp)
movq	%rax, 0x28(%rsp)
callq	mulx4x_internal
movq	0x28(%rsp), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
mulx4x_internal:
movq	%r9, 0x8(%rsp)
movq	%r9, %r10
negq	%r9
shlq	$0x5, %r9
negq	%r10
leaq	0x80(%rdx,%r9), %r13
shrq	$0xa, %r9
movd	0x8(%rax), %xmm5
subq	$0x1, %r9
leaq	bums_rodata(%rip), %rax
movq	%r13, 0x18(%rsp)
movq	%r9, 0x20(%rsp)
movq	%rdi, 0x40(%rsp)
movdqa	(%rax), %xmm0
movdqa	0x10(%rax), %xmm1
leaq	-0x18(%rsp,%r10), %r10
leaq	0x80(%rdx), %rdi
pshufd	$0x0, %xmm5, %xmm5
movdqa	%xmm1, %xmm4
addr32	movdqa	%xmm1, %xmm2
addr32	paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x70(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x80(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x90(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0xa0(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0xb0(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0xc0(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0xd0(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0xe0(%r10)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0xf0(%r10)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x100(%r10)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x110(%r10)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0x120(%r10)
movdqa	%xmm4, %xmm3
addr32	paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x130(%r10)
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x140(%r10)
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x150(%r10)
pand	0x40(%rdi), %xmm0
pand	0x50(%rdi), %xmm1
pand	0x60(%rdi), %xmm2
movdqa	%xmm3, 0x160(%r10)
pand	0x70(%rdi), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	-0x80(%rdi), %xmm4
movdqa	-0x70(%rdi), %xmm5
movdqa	-0x60(%rdi), %xmm2
pand	0x70(%r10), %xmm4
movdqa	-0x50(%rdi), %xmm3
pand	0x80(%r10), %xmm5
por	%xmm4, %xmm0
pand	0x90(%r10), %xmm2
por	%xmm5, %xmm1
pand	0xa0(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	-0x40(%rdi), %xmm4
movdqa	-0x30(%rdi), %xmm5
movdqa	-0x20(%rdi), %xmm2
pand	0xb0(%r10), %xmm4
movdqa	-0x10(%rdi), %xmm3
pand	0xc0(%r10), %xmm5
por	%xmm4, %xmm0
pand	0xd0(%r10), %xmm2
por	%xmm5, %xmm1
pand	0xe0(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
movdqa	(%rdi), %xmm4
movdqa	0x10(%rdi), %xmm5
movdqa	0x20(%rdi), %xmm2
pand	0xf0(%r10), %xmm4
movdqa	0x30(%rdi), %xmm3
pand	0x100(%r10), %xmm5
por	%xmm4, %xmm0
pand	0x110(%r10), %xmm2
por	%xmm5, %xmm1
pand	0x120(%r10), %xmm3
por	%xmm2, %xmm0
por	%xmm3, %xmm1
pxor	%xmm1, %xmm0
pshufd	$0x4e, %xmm0, %xmm1
por	%xmm1, %xmm0
leaq	0x100(%rdi), %rdi
movq	%xmm0, %rdx
leaq	0x68(%rsp), %rbx
movq	%rdx, %r9
mulxq	(%rsi), %r8, %rax
mulxq	0x8(%rsi), %r11, %r12
addq	%rax, %r11
mulxq	0x10(%rsi), %rax, %r13
adcq	%rax, %r12
adcq	$0x0, %r13
mulxq	0x18(%rsi), %rax, %r14
movq	%r8, %r15
imulq	0x28(%rsp), %r8
xorq	%rbp, %rbp
movq	%r8, %rdx
movq	%rdi, 0x10(%rsp)
leaq	0x20(%rsi), %rsi
adcxq	%rax, %r13
adcxq	%rbp, %r14
mulxq	(%rcx), %rax, %r10
adcxq	%rax, %r15
adoxq	%r11, %r10
mulxq	0x8(%rcx), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x10(%rcx), %rax, %r12
movq	0x20(%rsp), %rdi
movq	%r10, -0x20(%rbx)
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	%r11, -0x18(%rbx)
adcxq	%rax, %r12
adoxq	%rbp, %r15
leaq	0x20(%rcx), %rcx
movq	%r12, -0x10(%rbx)
jmp	Lx86_64_mont5__1e40
nopw	%cs:(%rax,%rax)
Lx86_64_mont5__1e40:
adcxq	%rbp, %r15
mulxq	(%rsi), %r10, %rax
adcxq	%r14, %r10
mulxq	0x8(%rsi), %r11, %r14
adcxq	%rax, %r11
mulxq	0x10(%rsi), %r12, %rax
adcxq	%r14, %r12
mulxq	0x18(%rsi), %r13, %r14
addr32	movq	%r8, %rdx
adcxq	%rax, %r13
adcxq	%rbp, %r14
leaq	0x20(%rsi), %rsi
leaq	0x20(%rbx), %rbx
adoxq	%r15, %r10
mulxq	(%rcx), %rax, %r15
adcxq	%rax, %r10
adoxq	%r15, %r11
mulxq	0x8(%rcx), %rax, %r15
adcxq	%rax, %r11
adoxq	%r15, %r12
mulxq	0x10(%rcx), %rax, %r15
movq	%r10, -0x28(%rbx)
adcxq	%rax, %r12
movq	%r11, -0x20(%rbx)
adoxq	%r15, %r13
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	%r12, -0x18(%rbx)
adcxq	%rax, %r13
adoxq	%rbp, %r15
leaq	0x20(%rcx), %rcx
movq	%r13, -0x10(%rbx)
decq	%rdi
jne	Lx86_64_mont5__1e40
movq	0x8(%rsp), %rax
adcq	%rbp, %r15
leaq	(%rsi,%rax), %rsi
addq	%r15, %r14
movq	0x10(%rsp), %rdi
adcq	%rbp, %rbp
movq	%r14, -0x8(%rbx)
jmp	Lx86_64_mont5__1f20
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Lx86_64_mont5__1f20:
leaq	-0xf0(%rbx), %r10
pxor	%xmm4, %xmm4
addr32	pxor	%xmm5, %xmm5
movdqa	-0x80(%rdi), %xmm0
movdqa	-0x70(%rdi), %xmm1
movdqa	-0x60(%rdi), %xmm2
pand	0x100(%r10), %xmm0
movdqa	-0x50(%rdi), %xmm3
pand	0x110(%r10), %xmm1
por	%xmm0, %xmm4
pand	0x120(%r10), %xmm2
por	%xmm1, %xmm5
pand	0x130(%r10), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	-0x40(%rdi), %xmm0
movdqa	-0x30(%rdi), %xmm1
movdqa	-0x20(%rdi), %xmm2
pand	0x140(%r10), %xmm0
movdqa	-0x10(%rdi), %xmm3
pand	0x150(%r10), %xmm1
por	%xmm0, %xmm4
pand	0x160(%r10), %xmm2
por	%xmm1, %xmm5
pand	0x170(%r10), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	(%rdi), %xmm0
movdqa	0x10(%rdi), %xmm1
movdqa	0x20(%rdi), %xmm2
pand	0x180(%r10), %xmm0
movdqa	0x30(%rdi), %xmm3
pand	0x190(%r10), %xmm1
por	%xmm0, %xmm4
pand	0x1a0(%r10), %xmm2
por	%xmm1, %xmm5
pand	0x1b0(%r10), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	0x40(%rdi), %xmm0
movdqa	0x50(%rdi), %xmm1
movdqa	0x60(%rdi), %xmm2
pand	0x1c0(%r10), %xmm0
movdqa	0x70(%rdi), %xmm3
pand	0x1d0(%r10), %xmm1
por	%xmm0, %xmm4
pand	0x1e0(%r10), %xmm2
por	%xmm1, %xmm5
pand	0x1f0(%r10), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
por	%xmm5, %xmm4
pshufd	$0x4e, %xmm4, %xmm0
por	%xmm4, %xmm0
leaq	0x100(%rdi), %rdi
movq	%xmm0, %rdx
movq	%rbp, (%rbx)
leaq	0x20(%rbx,%rax), %rbx
mulxq	(%rsi), %r8, %r11
xorq	%rbp, %rbp
movq	%rdx, %r9
mulxq	0x8(%rsi), %r14, %r12
adoxq	-0x20(%rbx), %r8
adcxq	%r14, %r11
mulxq	0x10(%rsi), %r15, %r13
adoxq	-0x18(%rbx), %r11
adcxq	%r15, %r12
mulxq	0x18(%rsi), %rdx, %r14
adoxq	-0x10(%rbx), %r12
adcxq	%rdx, %r13
leaq	(%rcx,%rax), %rcx
leaq	0x20(%rsi), %rsi
adoxq	-0x8(%rbx), %r13
adcxq	%rbp, %r14
adoxq	%rbp, %r14
movq	%r8, %r15
imulq	0x28(%rsp), %r8
movq	%r8, %rdx
xorq	%rbp, %rbp
movq	%rdi, 0x10(%rsp)
mulxq	(%rcx), %rax, %r10
adcxq	%rax, %r15
adoxq	%r11, %r10
mulxq	0x8(%rcx), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x10(%rcx), %rax, %r12
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
movq	0x20(%rsp), %rdi
movq	%r10, -0x20(%rbx)
adcxq	%rax, %r12
movq	%r11, -0x18(%rbx)
adoxq	%rbp, %r15
movq	%r12, -0x10(%rbx)
leaq	0x20(%rcx), %rcx
jmp	Lx86_64_mont5__2160
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Lx86_64_mont5__2160:
mulxq	(%rsi), %r10, %rax
adcxq	%rbp, %r15
adoxq	%r14, %r10
mulxq	0x8(%rsi), %r11, %r14
adcxq	(%rbx), %r10
adoxq	%rax, %r11
mulxq	0x10(%rsi), %r12, %rax
adcxq	0x8(%rbx), %r11
adoxq	%r14, %r12
mulxq	0x18(%rsi), %r13, %r14
movq	%r8, %rdx
adcxq	0x10(%rbx), %r12
adoxq	%rax, %r13
adcxq	0x18(%rbx), %r13
adoxq	%rbp, %r14
leaq	0x20(%rsi), %rsi
leaq	0x20(%rbx), %rbx
adcxq	%rbp, %r14
adoxq	%r15, %r10
mulxq	(%rcx), %rax, %r15
adcxq	%rax, %r10
adoxq	%r15, %r11
mulxq	0x8(%rcx), %rax, %r15
adcxq	%rax, %r11
adoxq	%r15, %r12
mulxq	0x10(%rcx), %rax, %r15
movq	%r10, -0x28(%rbx)
adcxq	%rax, %r12
adoxq	%r15, %r13
movq	%r11, -0x20(%rbx)
mulxq	0x18(%rcx), %rax, %r15
movq	%r9, %rdx
leaq	0x20(%rcx), %rcx
movq	%r12, -0x18(%rbx)
adcxq	%rax, %r13
adoxq	%rbp, %r15
movq	%r13, -0x10(%rbx)
decq	%rdi
jne	Lx86_64_mont5__2160
movq	0x8(%rsp), %rax
adcq	%rbp, %r15
subq	(%rbx), %rdi
movq	0x10(%rsp), %rdi
movq	0x18(%rsp), %r10
adcq	%r15, %r14
leaq	(%rsi,%rax), %rsi
adcq	%rbp, %rbp
movq	%r14, -0x8(%rbx)
cmpq	%r10, %rdi
jb	Lx86_64_mont5__1f20
movq	-0x8(%rcx), %r10
movq	%rbp, %r8
movq	(%rcx,%rax), %r12
leaq	(%rcx,%rax), %rbp
movq	%rax, %rcx
leaq	(%rbx,%rax), %rdi
xorl	%eax, %eax
xorq	%r15, %r15
subq	%r14, %r10
adcq	%r15, %r15
orq	%r15, %r8
sarq	$0x5, %rcx
subq	%r8, %rax
movq	0x40(%rsp), %rdx
decq	%r12
movq	0x8(%rbp), %r13
xorq	%r8, %r8
movq	0x10(%rbp), %r14
movq	0x18(%rbp), %r15
jmp	Lx86_64_mont5__2dc0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
bn_powerx5:
movq	%rsp, %rax
Lx86_64_mont5__22c3:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shll	$0x3, %r9d
leaq	(%r9,%r9,2), %r10
negq	%r9
movq	(%r8), %r8
leaq	-0x140(%rsp,%r9,2), %r11
movq	%rsp, %rbp
subq	%rdi, %r11
andq	$0xfff, %r11
cmpq	%r11, %r10
jb	Lx86_64_mont5__2320
subq	%r11, %rbp
leaq	-0x140(%rbp,%r9,2), %rbp
jmp	Lx86_64_mont5__2341
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
Lx86_64_mont5__2320:
leaq	0xec0(,%r9,2), %r10
leaq	-0x140(%rbp,%r9,2), %rbp
subq	%r10, %r11
movq	$0x0, %r10
cmovbq	%r10, %r11
subq	%r11, %rbp
Lx86_64_mont5__2341:
andq	$-0x40, %rbp
movq	%rsp, %r11
subq	%rbp, %r11
andq	$-0x1000, %r11
leaq	(%r11,%rbp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__2361
jmp	Lx86_64_mont5__2372
Lx86_64_mont5__2361:
leaq	-0x1000(%rsp), %rsp
movq	(%rsp), %r10
cmpq	%rbp, %rsp
ja	Lx86_64_mont5__2361
Lx86_64_mont5__2372:
movq	%r9, %r10
negq	%r9
pxor	%xmm0, %xmm0
movq	%rdi, %xmm1
movq	%rcx, %xmm2
movq	%r10, %xmm3
movq	%rdx, %xmm4
movq	%r8, 0x20(%rsp)
movq	%rax, 0x28(%rsp)
callq	__bn_sqrx8x_internal
callq	__bn_postx4x_internal
callq	__bn_sqrx8x_internal
callq	__bn_postx4x_internal
callq	__bn_sqrx8x_internal
callq	__bn_postx4x_internal
callq	__bn_sqrx8x_internal
callq	__bn_postx4x_internal
callq	__bn_sqrx8x_internal
callq	__bn_postx4x_internal
movq	%r10, %r9
movq	%rsi, %rdi
movq	%xmm2, %rcx
movq	%xmm4, %rdx
movq	0x28(%rsp), %rax
callq	mulx4x_internal
movq	0x28(%rsp), %rsi
movq	$0x1, %rax
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
__bn_sqrx8x_internal:
bn_sqrx8x_internal:
leaq	0x38(%rsp), %rdi
leaq	(%rsi,%r9), %rbp
movq	%r9, 0x8(%rsp)
movq	%rbp, 0x10(%rsp)
jmp	Lx86_64_mont5__2460
nopw	%cs:(%rax,%rax)
nop
nopw	%cs:(%rax,%rax)
Lx86_64_mont5__244c:
movdqa	%xmm0, %ds:(%rdi)
movdqa	%xmm0, 0x10(%rdi)
movdqa	%xmm0, 0x20(%rdi)
movdqa	%xmm0, 0x30(%rdi)
Lx86_64_mont5__2460:
movdqa	%xmm0, 0x40(%rdi)
movdqa	%xmm0, 0x50(%rdi)
movdqa	%xmm0, 0x60(%rdi)
movdqa	%xmm0, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
subq	$0x40, %r9
jne	Lx86_64_mont5__244c
movq	(%rsi), %rdx
xorq	%r10, %r10
xorq	%r11, %r11
xorq	%r12, %r12
xorq	%r13, %r13
xorq	%r14, %r14
xorq	%r15, %r15
leaq	0x38(%rsp), %rdi
xorq	%rbp, %rbp
jmp	Lx86_64_mont5__24a0
Lx86_64_mont5__24a0:
mulxq	0x8(%rsi), %r8, %rax
adcxq	%r9, %r8
adoxq	%rax, %r10
mulxq	0x10(%rsi), %r9, %rax
adcxq	%r10, %r9
adoxq	%rax, %r11
mulxq	0x18(%rsi), %r10, %rax
adcxq	%r11, %r10
adoxq	%rax, %r12
mulxq	0x20(%rsi), %r11, %rax
adcxq	%r12, %r11
adoxq	%rax, %r13
mulxq	0x28(%rsi), %r12, %rax
adcxq	%r13, %r12
adoxq	%rax, %r14
mulxq	0x30(%rsi), %r13, %rax
adcxq	%r14, %r13
adoxq	%r15, %rax
mulxq	0x38(%rsi), %r14, %r15
movq	0x8(%rsi), %rdx
adcxq	%rax, %r14
adoxq	%rbp, %r15
adcq	0x40(%rdi), %r15
movq	%r8, 0x8(%rdi)
movq	%r9, 0x10(%rdi)
sbbq	%rcx, %rcx
xorq	%rbp, %rbp
mulxq	0x10(%rsi), %r8, %rbx
mulxq	0x18(%rsi), %r9, %rax
adcxq	%r10, %r8
adoxq	%rbx, %r9
mulxq	0x20(%rsi), %r10, %rbx
adcxq	%r11, %r9
adoxq	%rax, %r10
mulxq	0x28(%rsi), %r11, %rax
adcxq	%r12, %r10
adoxq	%rbx, %r11
mulxq	0x30(%rsi), %r12, %rbx
adcxq	%r13, %r11
adoxq	%r14, %r12
mulxq	0x38(%rsi), %r13, %r14
movq	0x10(%rsi), %rdx
adcxq	%rax, %r12
adoxq	%rbx, %r13
adcxq	%r15, %r13
adoxq	%rbp, %r14
adcxq	%rbp, %r14
movq	%r8, 0x18(%rdi)
movq	%r9, 0x20(%rdi)
mulxq	0x18(%rsi), %r8, %rbx
mulxq	0x20(%rsi), %r9, %rax
adcxq	%r10, %r8
adoxq	%rbx, %r9
mulxq	0x28(%rsi), %r10, %rbx
adcxq	%r11, %r9
adoxq	%rax, %r10
mulxq	0x30(%rsi), %r11, %rax
adcxq	%r12, %r10
adoxq	%r13, %r11
mulxq	0x38(%rsi), %r12, %r13
movq	%ds:0x18(%rsi), %rdx
adcxq	%rbx, %r11
adoxq	%rax, %r12
adcxq	%r14, %r12
movq	%r8, 0x28(%rdi)
movq	%r9, 0x30(%rdi)
mulxq	0x20(%rsi), %r8, %rax
adoxq	%rbp, %r13
adcxq	%rbp, %r13
mulxq	0x28(%rsi), %r9, %rbx
adcxq	%r10, %r8
adoxq	%rax, %r9
mulxq	0x30(%rsi), %r10, %rax
adcxq	%r11, %r9
adoxq	%r12, %r10
mulxq	0x38(%rsi), %r11, %r12
movq	0x20(%rsi), %rdx
movq	0x28(%rsi), %r14
adcxq	%rbx, %r10
adoxq	%rax, %r11
movq	0x30(%rsi), %r15
adcxq	%r13, %r11
adoxq	%rbp, %r12
adcxq	%rbp, %r12
movq	%r8, 0x38(%rdi)
movq	%r9, 0x40(%rdi)
mulxq	%r14, %r9, %rax
movq	0x38(%rsi), %r8
adcxq	%r10, %r9
mulxq	%r15, %r10, %rbx
adoxq	%rax, %r10
adcxq	%r11, %r10
mulxq	%r8, %r11, %rax
movq	%r14, %rdx
adoxq	%rbx, %r11
adcxq	%r12, %r11
adcxq	%rbp, %rax
mulxq	%r15, %r14, %rbx
mulxq	%r8, %r12, %r13
movq	%r15, %rdx
leaq	0x40(%rsi), %rsi
adcxq	%r14, %r11
adoxq	%rbx, %r12
adcxq	%rax, %r12
adoxq	%rbp, %r13
addr32	mulxq	%r8, %r8, %r14
adcxq	%r8, %r13
adcxq	%rbp, %r14
cmpq	0x10(%rsp), %rsi
je	Lx86_64_mont5__2920
negq	%rcx
movq	$-0x8, %rcx
movq	%rbp, %r15
movq	0x40(%rdi), %r8
adcxq	0x48(%rdi), %r9
adcxq	0x50(%rdi), %r10
adcxq	0x58(%rdi), %r11
adcq	0x60(%rdi), %r12
adcq	0x68(%rdi), %r13
adcq	0x70(%rdi), %r14
adcq	0x78(%rdi), %r15
leaq	(%rsi), %rbp
leaq	0x80(%rdi), %rdi
sbbq	%rax, %rax
movq	-0x40(%rsi), %rdx
movq	%rax, 0x18(%rsp)
movq	%rdi, 0x20(%rsp)
xorl	%eax, %eax
jmp	Lx86_64_mont5__2780
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
Lx86_64_mont5__2780:
movq	%r8, %rbx
mulxq	(%rbp), %rax, %r8
adcxq	%rax, %rbx
adoxq	%r9, %r8
mulxq	0x8(%rbp), %rax, %r9
adcxq	%rax, %r8
adoxq	%r10, %r9
mulxq	0x10(%rbp), %rax, %r10
adcxq	%rax, %r9
adoxq	%r11, %r10
mulxq	0x18(%rbp), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x20(%rbp), %rax, %r12
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x28(%rbp), %rax, %r13
adcxq	%rax, %r12
adoxq	%r14, %r13
mulxq	0x30(%rbp), %rax, %r14
movq	%rbx, (%rdi,%rcx,8)
movl	$0x0, %ebx
adcxq	%rax, %r13
adoxq	%r15, %r14
mulxq	0x38(%rbp), %rax, %r15
movq	0x8(%rsi,%rcx,8), %rdx
adcxq	%rax, %r14
adoxq	%rbx, %r15
adcxq	%rbx, %r15
addr32	incq	%rcx
jne	Lx86_64_mont5__2780
leaq	0x40(%rbp), %rbp
movq	$-0x8, %rcx
cmpq	0x10(%rsp), %rbp
je	Lx86_64_mont5__28a0
subq	0x18(%rsp), %rbx
movq	-0x40(%rsi), %rdx
adcxq	(%rdi), %r8
adcxq	0x8(%rdi), %r9
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
leaq	0x40(%rdi), %rdi
addr32	sbbq	%rax, %rax
xorl	%ebx, %ebx
movq	%rax, 0x18(%rsp)
jmp	Lx86_64_mont5__2780
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
Lx86_64_mont5__28a0:
xorq	%rbp, %rbp
subq	0x18(%rsp), %rbx
adcxq	%rbp, %r8
movq	0x20(%rsp), %rcx
adcxq	%rbp, %r9
movq	(%rsi), %rdx
adcq	$0x0, %r10
movq	%r8, (%rdi)
adcq	$0x0, %r11
adcq	$0x0, %r12
adcq	$0x0, %r13
adcq	$0x0, %r14
adcq	$0x0, %r15
cmpq	%rcx, %rdi
je	Lx86_64_mont5__24a0
movq	%r9, 0x8(%rdi)
movq	0x8(%rcx), %r9
movq	%r10, 0x10(%rdi)
movq	0x10(%rcx), %r10
movq	%r11, 0x18(%rdi)
movq	0x18(%rcx), %r11
movq	%r12, 0x20(%rdi)
movq	0x20(%rcx), %r12
movq	%r13, 0x28(%rdi)
movq	0x28(%rcx), %r13
movq	%r14, 0x30(%rdi)
movq	0x30(%rcx), %r14
movq	%r15, 0x38(%rdi)
movq	0x38(%rcx), %r15
movq	%rcx, %rdi
jmp	Lx86_64_mont5__24a0
Lx86_64_mont5__2920:
movq	%r9, 0x48(%rdi)
movq	%xmm3, %rcx
movq	%r10, 0x50(%rdi)
movq	%r11, 0x58(%rdi)
movq	%r12, 0x60(%rdi)
movq	%r13, 0x68(%rdi)
movq	%r14, 0x70(%rdi)
leaq	0x38(%rsp), %rdi
movq	(%rsi,%rcx), %rdx
movq	0x8(%rdi), %r11
xorq	%r10, %r10
movq	0x8(%rsp), %r9
adoxq	%r11, %r11
movq	0x10(%rdi), %r12
movq	0x18(%rdi), %r13
Lx86_64_mont5__2960:
mulxq	%rdx, %rax, %rbx
adoxq	%r12, %r12
adcxq	%r10, %rax
movq	0x8(%rsi,%rcx), %rdx
movq	0x20(%rdi), %r10
adoxq	%r13, %r13
adcxq	%r11, %rbx
movq	0x28(%rdi), %r11
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
mulxq	%rdx, %rax, %rbx
adoxq	%r10, %r10
adcxq	%r12, %rax
movq	0x10(%rsi,%rcx), %rdx
movq	0x30(%rdi), %r12
adoxq	%r11, %r11
adcxq	%r13, %rbx
movq	0x38(%rdi), %r13
movq	%rax, 0x10(%rdi)
movq	%rbx, 0x18(%rdi)
mulxq	%rdx, %rax, %rbx
adoxq	%r12, %r12
adcxq	%r10, %rax
movq	0x18(%rsi,%rcx), %rdx
leaq	0x20(%rcx), %rcx
movq	0x40(%rdi), %r10
adoxq	%r13, %r13
adcxq	%r11, %rbx
movq	0x48(%rdi), %r11
movq	%rax, 0x20(%rdi)
movq	%rbx, 0x28(%rdi)
mulxq	%rdx, %rax, %rbx
adoxq	%r10, %r10
adcxq	%r12, %rax
jrcxz	Lx86_64_mont5__2a40
movq	(%rsi,%rcx), %rdx
adoxq	%r11, %r11
adcxq	%r13, %rbx
movq	0x50(%rdi), %r12
movq	0x58(%rdi), %r13
movq	%rax, 0x30(%rdi)
movq	%rbx, 0x38(%rdi)
leaq	0x40(%rdi), %rdi
nop
jmp	Lx86_64_mont5__2960
Lx86_64_mont5__2a40:
adcxq	%r13, %rbx
movq	%rax, 0x30(%rdi)
movq	%rbx, 0x38(%rdi)
leaq	0x40(%rdi), %rdi
movq	%xmm2, %rbp
__bn_sqrx8x_reduction:
xorl	%eax, %eax
movq	0x28(%rsp), %rbx
movq	0x38(%rsp), %rdx
leaq	-0x40(%rbp,%r9), %rcx
movq	%rcx, 0x8(%rsp)
movq	%rdi, 0x10(%rsp)
leaq	0x38(%rsp), %rdi
jmp	Lx86_64_mont5__2a80
nopl	(%rax)
Lx86_64_mont5__2a80:
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movq	0x20(%rdi), %r12
movq	%rdx, %r8
imulq	%rbx, %rdx
movq	0x28(%rdi), %r13
movq	0x30(%rdi), %r14
movq	0x38(%rdi), %r15
movq	%rax, 0x20(%rsp)
leaq	0x40(%rdi), %rdi
xorq	%rsi, %rsi
movq	$-0x8, %rcx
jmp	Lx86_64_mont5__2ac0
nopl	(%rax,%rax)
Lx86_64_mont5__2ac0:
movq	%r8, %rbx
mulxq	(%rbp), %rax, %r8
adcxq	%rbx, %rax
adoxq	%r9, %r8
mulxq	0x8(%rbp), %rbx, %r9
adcxq	%rbx, %r8
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
mulxq	0x28(%rsp), %rbx, %rdx
movq	%rax, %rdx
movq	%rax, 0x78(%rsp,%rcx,8)
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
addr32	incq	%rcx
jne	Lx86_64_mont5__2ac0
movq	%rsi, %rax
cmpq	0x8(%rsp), %rbp
jae	Lx86_64_mont5__2d0d
movq	0x38(%rsp), %rdx
addq	(%rdi), %r8
leaq	0x40(%rbp), %rbp
movq	$-0x8, %rcx
adcxq	0x8(%rdi), %r9
adcxq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
leaq	0x40(%rdi), %rdi
sbbq	%rax, %rax
xorq	%rsi, %rsi
movq	%rax, 0x18(%rsp)
jmp	Lx86_64_mont5__2be0
nopw	%cs:(%rax,%rax)
nop
Lx86_64_mont5__2be0:
movq	%r8, %rbx
mulxq	(%rbp), %rax, %r8
adcxq	%rax, %rbx
adoxq	%r9, %r8
mulxq	0x8(%rbp), %rax, %r9
adcxq	%rax, %r8
adoxq	%r10, %r9
mulxq	0x10(%rbp), %rax, %r10
adcxq	%rax, %r9
adoxq	%r11, %r10
mulxq	0x18(%rbp), %rax, %r11
adcxq	%rax, %r10
adoxq	%r12, %r11
mulxq	0x20(%rbp), %rax, %r12
adcxq	%rax, %r11
adoxq	%r13, %r12
mulxq	0x28(%rbp), %rax, %r13
adcxq	%rax, %r12
adoxq	%r14, %r13
mulxq	0x30(%rbp), %rax, %r14
adcxq	%rax, %r13
adoxq	%r15, %r14
mulxq	0x38(%rbp), %rax, %r15
movq	0x80(%rsp,%rcx,8), %rdx
adcxq	%rax, %r14
adoxq	%rsi, %r15
movq	%rbx, (%rdi,%rcx,8)
movq	%r8, %rbx
adcxq	%rsi, %r15
incq	%rcx
jne	Lx86_64_mont5__2be0
cmpq	0x8(%rsp), %rbp
jae	Lx86_64_mont5__2ce0
subq	0x18(%rsp), %rsi
movq	0x38(%rsp), %rdx
leaq	0x40(%rbp), %rbp
adcq	(%rdi), %r8
adcq	0x8(%rdi), %r9
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
leaq	0x40(%rdi), %rdi
sbbq	%rax, %rax
subq	$0x8, %rcx
xorq	%rsi, %rsi
movq	%rax, 0x18(%rsp)
jmp	Lx86_64_mont5__2be0
Lx86_64_mont5__2ce0:
xorq	%rax, %rax
addq	0x20(%rsp), %r8
adcq	$0x0, %r9
adcq	$0x0, %r10
adcq	$0x0, %r11
adcq	$0x0, %r12
adcq	$0x0, %r13
adcq	$0x0, %r14
adcq	$0x0, %r15
adcq	$0x0, %rax
subq	0x18(%rsp), %rsi
Lx86_64_mont5__2d0d:
adcq	(%rdi), %r8
movq	%xmm3, %rcx
adcq	0x8(%rdi), %r9
movq	0x38(%rbp), %rsi
movq	%xmm2, %rbp
adcq	0x10(%rdi), %r10
adcq	0x18(%rdi), %r11
adcq	0x20(%rdi), %r12
adcq	0x28(%rdi), %r13
adcq	0x30(%rdi), %r14
adcq	0x38(%rdi), %r15
adcq	$0x0, %rax
movq	0x28(%rsp), %rbx
movq	0x40(%rdi,%rcx), %rdx
movq	%r8, (%rdi)
leaq	0x40(%rdi), %r8
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r12, 0x20(%rdi)
movq	%r13, 0x28(%rdi)
movq	%r14, 0x30(%rdi)
movq	%r15, 0x38(%rdi)
leaq	0x40(%rdi,%rcx), %rdi
cmpq	0x10(%rsp), %r8
jb	Lx86_64_mont5__2a80
rep	retq
nopl	(%rax)
__bn_postx4x_internal:
movq	(%rbp), %r12
movq	%rcx, %r10
movq	%rcx, %r9
negq	%rax
sarq	$0x5, %rcx
movq	%xmm1, %rdx
movq	%xmm1, %rsi
decq	%r12
movq	0x8(%rbp), %r13
xorq	%r8, %r8
movq	0x10(%rbp), %r14
movq	0x18(%rbp), %r15
jmp	Lx86_64_mont5__2dc0
nop
Lx86_64_mont5__2db0:
movq	(%rbp), %r12
movq	0x8(%rbp), %r13
movq	0x10(%rbp), %r14
movq	0x18(%rbp), %r15
Lx86_64_mont5__2dc0:
andnq	%rax, %r12, %r12
leaq	0x20(%rbp), %rbp
andnq	%rax, %r13, %r13
andnq	%rax, %r14, %r14
andnq	%rax, %r15, %r15
negq	%r8
adcq	(%rdi), %r12
adcq	0x8(%rdi), %r13
adcq	0x10(%rdi), %r14
adcq	0x18(%rdi), %r15
movq	%r12, (%rdx)
leaq	0x20(%rdi), %rdi
movq	%r13, 0x8(%rdx)
sbbq	%r8, %r8
movq	%r14, 0x10(%rdx)
movq	%r15, 0x18(%rdx)
leaq	0x20(%rdx), %rdx
incq	%rcx
jne	Lx86_64_mont5__2db0
negq	%r9
rep	retq
nop
bn_get_bits5:
leaq	(%rdi), %r10
leaq	0x1(%rdi), %r11
movl	%esi, %ecx
shrl	$0x4, %esi
andl	$0xf, %ecx
leal	-0x8(%rcx), %eax
cmpl	$0xb, %ecx
cmovaq	%r11, %r10
cmoval	%eax, %ecx
movzwl	(%r10,%rsi,2), %eax
shrl	%cl, %eax
andl	$0x1f, %eax
rep	retq
nopl	(%rax,%rax)
bn_scatter5:
cmpl	$0x0, %esi
je	Lx86_64_mont5__2e5f
leaq	(%rdx,%rcx,8), %rdx
Lx86_64_mont5__2e49:
movq	(%rdi), %rax
leaq	0x8(%rdi), %rdi
movq	%rax, (%rdx)
leaq	0x100(%rdx), %rdx
subl	$0x1, %esi
jne	Lx86_64_mont5__2e49
Lx86_64_mont5__2e5f:
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
bn_gather5:
leaq	(%rsp), %r10
subq	$0x108, %rsp
leaq	bums_rodata(%rip), %rax
andq	$-0x10, %rsp
movd	%ecx, %xmm5
movdqa	(%rax), %xmm0
movdqa	0x10(%rax), %xmm1
leaq	0x80(%rdx), %r11
leaq	0x80(%rsp), %rax
pshufd	$0x0, %xmm5, %xmm5
movdqa	%xmm1, %xmm4
movdqa	%xmm1, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, -0x80(%rax)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, -0x70(%rax)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, -0x60(%rax)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, -0x50(%rax)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, -0x40(%rax)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, -0x30(%rax)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, -0x20(%rax)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, -0x10(%rax)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, (%rax)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x10(%rax)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x20(%rax)
movdqa	%xmm4, %xmm2
paddd	%xmm0, %xmm1
pcmpeqd	%xmm5, %xmm0
movdqa	%xmm3, 0x30(%rax)
movdqa	%xmm4, %xmm3
paddd	%xmm1, %xmm2
pcmpeqd	%xmm5, %xmm1
movdqa	%xmm0, 0x40(%rax)
movdqa	%xmm4, %xmm0
paddd	%xmm2, %xmm3
pcmpeqd	%xmm5, %xmm2
movdqa	%xmm1, 0x50(%rax)
movdqa	%xmm4, %xmm1
paddd	%xmm3, %xmm0
pcmpeqd	%xmm5, %xmm3
movdqa	%xmm2, 0x60(%rax)
movdqa	%xmm4, %xmm2
movdqa	%xmm3, 0x70(%rax)
jmp	Lx86_64_mont5__2fe0
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
Lx86_64_mont5__2fe0:
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
movdqa	-0x80(%r11), %xmm0
movdqa	-0x70(%r11), %xmm1
movdqa	-0x60(%r11), %xmm2
pand	-0x80(%rax), %xmm0
movdqa	-0x50(%r11), %xmm3
pand	-0x70(%rax), %xmm1
por	%xmm0, %xmm4
pand	-0x60(%rax), %xmm2
por	%xmm1, %xmm5
pand	-0x50(%rax), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	-0x40(%r11), %xmm0
movdqa	-0x30(%r11), %xmm1
movdqa	-0x20(%r11), %xmm2
pand	-0x40(%rax), %xmm0
movdqa	-0x10(%r11), %xmm3
pand	-0x30(%rax), %xmm1
por	%xmm0, %xmm4
pand	-0x20(%rax), %xmm2
por	%xmm1, %xmm5
pand	-0x10(%rax), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	(%r11), %xmm0
movdqa	0x10(%r11), %xmm1
movdqa	0x20(%r11), %xmm2
pand	(%rax), %xmm0
movdqa	0x30(%r11), %xmm3
pand	0x10(%rax), %xmm1
por	%xmm0, %xmm4
pand	0x20(%rax), %xmm2
por	%xmm1, %xmm5
pand	0x30(%rax), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
movdqa	0x40(%r11), %xmm0
movdqa	0x50(%r11), %xmm1
movdqa	0x60(%r11), %xmm2
pand	0x40(%rax), %xmm0
movdqa	0x70(%r11), %xmm3
pand	0x50(%rax), %xmm1
por	%xmm0, %xmm4
pand	0x60(%rax), %xmm2
por	%xmm1, %xmm5
pand	0x70(%rax), %xmm3
por	%xmm2, %xmm4
por	%xmm3, %xmm5
por	%xmm5, %xmm4
leaq	0x100(%r11), %r11
pshufd	$0x4e, %xmm4, %xmm0
por	%xmm4, %xmm0
movq	%xmm0, (%rdi)
leaq	0x8(%rdi), %rdi
subl	$0x1, %esi
jne	Lx86_64_mont5__2fe0
leaq	(%r10), %rsp
rep	retq
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0
	.byte 2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	.byte 77,111,110,116,103,111,109,101,114,121,32,77,117,108,116,105
	.byte 112,108,105,99,97,116,105,111,110,32,119,105,116,104,32,115
	.byte 99,97,116,116,101,114,47,103,97,116,104,101,114,32,102,111
	.byte 114,32,120,56,54,95,54,52,44,32,67,82,89,80,84,79
	.byte 71,65,77,83,32,98,121,32,60,104,116,116,112,115,58,47
	.byte 47,103,105,116,104,117,98,46,99,111,109,47,100,111,116,45
	.byte 97,115,109,62,0
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

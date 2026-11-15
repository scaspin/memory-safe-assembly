	.text
_aesni_ctr32_ghash_6x:
vmovdqu	0x20(%r11), %xmm2
subq	$0x6, %rdx
vpxor	%xmm4, %xmm4, %xmm4
vmovdqu	-0x80(%rcx), %xmm15
vpaddb	%xmm2, %xmm1, %xmm10
vpaddb	%xmm2, %xmm10, %xmm11
vpaddb	%xmm2, %xmm11, %xmm12
vpaddb	%xmm2, %xmm12, %xmm13
vpaddb	%xmm2, %xmm13, %xmm14
vpxor	%xmm1, %xmm15, %xmm9
vmovdqu	%xmm4, 0x18(%rsp)
jmp	L_40
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_40:
addl	$0x6000000, %ebx
jb	L_420
vmovdqu	-0x20(%r9), %xmm3
vpaddb	%xmm2, %xmm14, %xmm1
vpxor	%xmm15, %xmm10, %xmm10
vpxor	%xmm15, %xmm11, %xmm11
L_60:
vmovdqu	%xmm1, (%r8)
vpclmulqdq	$0x10, %xmm3, %xmm7, %xmm5
vpxor	%xmm15, %xmm12, %xmm12
vmovups	-0x70(%rcx), %xmm2
vpclmulqdq	$0x1, %xmm3, %xmm7, %xmm6
xorq	%r12, %r12
cmpq	%r14, %r15
vaesenc	%xmm2, %xmm9, %xmm9
vmovdqu	0x38(%rsp), %xmm0
vpxor	%xmm15, %xmm13, %xmm13
vpclmulqdq	$0x0, %xmm3, %xmm7, %xmm1
vaesenc	%xmm2, %xmm10, %xmm10
vpxor	%xmm15, %xmm14, %xmm14
setae	%r12b
vpclmulqdq	$0x11, %xmm3, %xmm7, %xmm7
vaesenc	%xmm2, %xmm11, %xmm11
vmovdqu	-0x10(%r9), %xmm3
negq	%r12
vaesenc	%xmm2, %xmm12, %xmm12
vpxor	%xmm5, %xmm6, %xmm6
vpclmulqdq	$0x0, %xmm3, %xmm0, %xmm5
vpxor	%xmm4, %xmm8, %xmm8
vaesenc	%xmm2, %xmm13, %xmm13
vpxor	%xmm5, %xmm1, %xmm4
andq	$0x60, %r12
vmovups	-0x60(%rcx), %xmm15
vpclmulqdq	$0x10, %xmm3, %xmm0, %xmm1
vaesenc	%xmm2, %xmm14, %xmm14
vpclmulqdq	$0x1, %xmm3, %xmm0, %xmm2
leaq	(%r14,%r12), %r14
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	0x18(%rsp), %xmm8, %xmm8
vpclmulqdq	$0x11, %xmm3, %xmm0, %xmm3
vmovdqu	0x48(%rsp), %xmm0
vaesenc	%xmm15, %xmm10, %xmm10
movbeq	0x58(%r14), %r13
vaesenc	%xmm15, %xmm11, %xmm11
movbeq	0x50(%r14), %r12
vaesenc	%xmm15, %xmm12, %xmm12
movq	%r13, 0x28(%rsp)
vaesenc	%xmm15, %xmm13, %xmm13
movq	%r12, 0x30(%rsp)
vmovdqu	0x10(%r9), %xmm5
vaesenc	%xmm15, %xmm14, %xmm14
vmovups	-0x50(%rcx), %xmm15
vpxor	%xmm1, %xmm6, %xmm6
vpclmulqdq	$0x0, %xmm5, %xmm0, %xmm1
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	%xmm2, %xmm6, %xmm6
vpclmulqdq	$0x10, %xmm5, %xmm0, %xmm2
vaesenc	%xmm15, %xmm10, %xmm10
vpxor	%xmm3, %xmm7, %xmm7
vpclmulqdq	$0x1, %xmm5, %xmm0, %xmm3
vaesenc	%xmm15, %xmm11, %xmm11
vpclmulqdq	$0x11, %xmm5, %xmm0, %xmm5
vmovdqu	0x58(%rsp), %xmm0
vaesenc	%xmm15, %xmm12, %xmm12
vaesenc	%xmm15, %xmm13, %xmm13
vpxor	%xmm1, %xmm4, %xmm4
vmovdqu	0x20(%r9), %xmm1
vaesenc	%xmm15, %xmm14, %xmm14
vmovups	-0x40(%rcx), %xmm15
vpxor	%xmm2, %xmm6, %xmm6
vpclmulqdq	$0x0, %xmm1, %xmm0, %xmm2
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	%xmm3, %xmm6, %xmm6
vpclmulqdq	$0x10, %xmm1, %xmm0, %xmm3
vaesenc	%xmm15, %xmm10, %xmm10
movbeq	0x48(%r14), %r13
vpxor	%xmm5, %xmm7, %xmm7
vpclmulqdq	$0x1, %xmm1, %xmm0, %xmm5
vaesenc	%xmm15, %xmm11, %xmm11
movbeq	0x40(%r14), %r12
vpclmulqdq	$0x11, %xmm1, %xmm0, %xmm1
vmovdqu	0x68(%rsp), %xmm0
vaesenc	%xmm15, %xmm12, %xmm12
movq	%r13, 0x38(%rsp)
vaesenc	%xmm15, %xmm13, %xmm13
movq	%r12, 0x40(%rsp)
vpxor	%xmm2, %xmm4, %xmm4
vmovdqu	0x40(%r9), %xmm2
vaesenc	%xmm15, %xmm14, %xmm14
vmovups	-0x30(%rcx), %xmm15
vpxor	%xmm3, %xmm6, %xmm6
vpclmulqdq	$0x0, %xmm2, %xmm0, %xmm3
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	%xmm5, %xmm6, %xmm6
vpclmulqdq	$0x10, %xmm2, %xmm0, %xmm5
vaesenc	%xmm15, %xmm10, %xmm10
movbeq	0x38(%r14), %r13
vpxor	%xmm1, %xmm7, %xmm7
vpclmulqdq	$0x1, %xmm2, %xmm0, %xmm1
vpxor	0x78(%rsp), %xmm8, %xmm8
vaesenc	%xmm15, %xmm11, %xmm11
movbeq	0x30(%r14), %r12
vpclmulqdq	$0x11, %xmm2, %xmm0, %xmm2
vaesenc	%xmm15, %xmm12, %xmm12
movq	%r13, 0x48(%rsp)
vaesenc	%xmm15, %xmm13, %xmm13
movq	%r12, 0x50(%rsp)
vpxor	%xmm3, %xmm4, %xmm4
vmovdqu	0x50(%r9), %xmm3
vaesenc	%xmm15, %xmm14, %xmm14
vmovups	-0x20(%rcx), %xmm15
vpxor	%xmm5, %xmm6, %xmm6
vpclmulqdq	$0x10, %xmm3, %xmm8, %xmm5
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	%xmm1, %xmm6, %xmm6
vpclmulqdq	$0x1, %xmm3, %xmm8, %xmm1
vaesenc	%xmm15, %xmm10, %xmm10
movbeq	0x28(%r14), %r13
vpxor	%xmm2, %xmm7, %xmm7
vpclmulqdq	$0x0, %xmm3, %xmm8, %xmm2
vaesenc	%xmm15, %xmm11, %xmm11
movbeq	0x20(%r14), %r12
vpclmulqdq	$0x11, %xmm3, %xmm8, %xmm8
vaesenc	%xmm15, %xmm12, %xmm12
movq	%r13, 0x58(%rsp)
vaesenc	%xmm15, %xmm13, %xmm13
movq	%r12, 0x60(%rsp)
vpxor	%xmm5, %xmm6, %xmm6
vaesenc	%xmm15, %xmm14, %xmm14
vpxor	%xmm1, %xmm6, %xmm6
vmovups	-0x10(%rcx), %xmm15
vpslldq	$0x8, %xmm6, %xmm5
vpxor	%xmm2, %xmm4, %xmm4
vmovdqu	0x10(%r11), %xmm3
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	%xmm7, %xmm8, %xmm7
vaesenc	%xmm15, %xmm10, %xmm10
vpxor	%xmm5, %xmm4, %xmm4
movbeq	0x18(%r14), %r13
vaesenc	%xmm15, %xmm11, %xmm11
movbeq	0x10(%r14), %r12
vpalignr	$0x8, %xmm4, %xmm4, %xmm0
vpclmulqdq	$0x10, %xmm3, %xmm4, %xmm4
movq	%r13, 0x68(%rsp)
vaesenc	%xmm15, %xmm12, %xmm12
movq	%r12, 0x70(%rsp)
vaesenc	%xmm15, %xmm13, %xmm13
vmovups	(%rcx), %xmm1
vaesenc	%xmm15, %xmm14, %xmm14
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	0x10(%rcx), %xmm15
vaesenc	%xmm1, %xmm10, %xmm10
vpsrldq	$0x8, %xmm6, %xmm6
vaesenc	%xmm1, %xmm11, %xmm11
vpxor	%xmm6, %xmm7, %xmm7
vaesenc	%xmm1, %xmm12, %xmm12
vpxor	%xmm0, %xmm4, %xmm4
movbeq	0x8(%r14), %r13
vaesenc	%xmm1, %xmm13, %xmm13
movbeq	(%r14), %r12
vaesenc	%xmm1, %xmm14, %xmm14
vmovups	0x20(%rcx), %xmm1
cmpl	$0xb, %ebp
jb	L_480
vaesenc	%xmm15, %xmm9, %xmm9
vaesenc	%xmm15, %xmm10, %xmm10
vaesenc	%xmm15, %xmm11, %xmm11
vaesenc	%xmm15, %xmm12, %xmm12
vaesenc	%xmm15, %xmm13, %xmm13
vaesenc	%xmm15, %xmm14, %xmm14
vaesenc	%xmm1, %xmm9, %xmm9
vaesenc	%xmm1, %xmm10, %xmm10
vaesenc	%xmm1, %xmm11, %xmm11
vaesenc	%xmm1, %xmm12, %xmm12
vaesenc	%xmm1, %xmm13, %xmm13
vmovups	0x30(%rcx), %xmm15
vaesenc	%xmm1, %xmm14, %xmm14
vmovups	0x40(%rcx), %xmm1
je	L_480
vaesenc	%xmm15, %xmm9, %xmm9
vaesenc	%xmm15, %xmm10, %xmm10
vaesenc	%xmm15, %xmm11, %xmm11
vaesenc	%xmm15, %xmm12, %xmm12
vaesenc	%xmm15, %xmm13, %xmm13
vaesenc	%xmm15, %xmm14, %xmm14
vaesenc	%xmm1, %xmm9, %xmm9
vaesenc	%xmm1, %xmm10, %xmm10
vaesenc	%xmm1, %xmm11, %xmm11
vaesenc	%xmm1, %xmm12, %xmm12
vaesenc	%xmm1, %xmm13, %xmm13
vmovups	0x50(%rcx), %xmm15
vaesenc	%xmm1, %xmm14, %xmm14
vmovups	0x60(%rcx), %xmm1
jmp	L_480
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_420:
vmovdqu	(%r11), %xmm0
vpshufb	%xmm0, %xmm1, %xmm6
vmovdqu	0x30(%r11), %xmm5
vpaddd	0x40(%r11), %xmm6, %xmm10
vpaddd	%xmm5, %xmm6, %xmm11
vmovdqu	-0x20(%r9), %xmm3
vpaddd	%xmm5, %xmm10, %xmm12
vpshufb	%xmm0, %xmm10, %xmm10
vpaddd	%xmm5, %xmm11, %xmm13
vpshufb	%xmm0, %xmm11, %xmm11
vpxor	%xmm15, %xmm10, %xmm10
vpaddd	%xmm5, %xmm12, %xmm14
vpshufb	%xmm0, %xmm12, %xmm12
vpxor	%xmm15, %xmm11, %xmm11
vpaddd	%xmm5, %xmm13, %xmm1
vpshufb	%xmm0, %xmm13, %xmm13
vpshufb	%xmm0, %xmm14, %xmm14
vpshufb	%xmm0, %xmm1, %xmm1
jmp	L_60
nopl	(%rax)
L_480:
vaesenc	%xmm15, %xmm9, %xmm9
vmovdqu	%xmm7, 0x18(%rsp)
vpalignr	$0x8, %xmm4, %xmm4, %xmm8
vaesenc	%xmm15, %xmm10, %xmm10
vpclmulqdq	$0x10, %xmm3, %xmm4, %xmm4
vpxor	(%rdi), %xmm1, %xmm2
vaesenc	%xmm15, %xmm11, %xmm11
vpxor	0x10(%rdi), %xmm1, %xmm0
vaesenc	%xmm15, %xmm12, %xmm12
vpxor	0x20(%rdi), %xmm1, %xmm5
vaesenc	%xmm15, %xmm13, %xmm13
vpxor	0x30(%rdi), %xmm1, %xmm6
vaesenc	%xmm15, %xmm14, %xmm14
vpxor	0x40(%rdi), %xmm1, %xmm7
vpxor	0x50(%rdi), %xmm1, %xmm3
vmovdqu	(%r8), %xmm1
vaesenclast	%xmm2, %xmm9, %xmm9
vmovdqu	0x20(%r11), %xmm2
vaesenclast	%xmm0, %xmm10, %xmm10
vpaddb	%xmm2, %xmm1, %xmm0
movq	%r13, 0x78(%rsp)
leaq	0x60(%rdi), %rdi
vaesenclast	%xmm5, %xmm11, %xmm11
vpaddb	%xmm2, %xmm0, %xmm5
movq	%r12, 0x80(%rsp)
leaq	0x60(%rsi), %rsi
vmovdqu	-0x80(%rcx), %xmm15
vaesenclast	%xmm6, %xmm12, %xmm12
vpaddb	%xmm2, %xmm5, %xmm6
vaesenclast	%xmm7, %xmm13, %xmm13
vpaddb	%xmm2, %xmm6, %xmm7
vaesenclast	%xmm3, %xmm14, %xmm14
vpaddb	%xmm2, %xmm7, %xmm3
addq	$0x60, %r10
subq	$0x6, %rdx
jb	L_56f
vmovups	%xmm9, -0x60(%rsi)
vpxor	%xmm1, %xmm15, %xmm9
vmovups	%xmm10, -0x50(%rsi)
vmovdqa	%xmm0, %xmm10
vmovups	%xmm11, -0x40(%rsi)
vmovdqa	%xmm5, %xmm11
vmovups	%xmm12, -0x30(%rsi)
vmovdqa	%xmm6, %xmm12
vmovups	%xmm13, -0x20(%rsi)
vmovdqa	%xmm7, %xmm13
vmovups	%xmm14, -0x10(%rsi)
vmovdqa	%xmm3, %xmm14
vmovdqu	0x28(%rsp), %xmm7
jmp	L_40
L_56f:
vpxor	0x18(%rsp), %xmm8, %xmm8
vpxor	%xmm4, %xmm8, %xmm8
rep	retq
nopl	(%rax,%rax)
aesni_gcm_decrypt:
xorq	%r10, %r10
cmpq	$0x60, %rdx
jb	L_6ac
leaq	(%rsp), %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vzeroupper
vmovdqu	(%r8), %xmm1
addq	$-0x80, %rsp
movl	0xc(%r8), %ebx
leaq	bums_rodata(%rip), %r11
leaq	-0x80(%rcx), %r14
movq	$0xf80, %r15
vmovdqu	(%r9), %xmm8
andq	$-0x80, %rsp
vmovdqu	(%r11), %xmm0
leaq	0x80(%rcx), %rcx
leaq	0x40(%r9), %r9
movl	0x70(%rcx), %ebp
vpshufb	%xmm0, %xmm8, %xmm8
andq	%r15, %r14
andq	%rsp, %r15
subq	%r14, %r15
jb	L_5f5
cmpq	$0x300, %r15
jae	L_5f5
subq	%r15, %rsp
L_5f5:
vmovdqu	0x50(%rdi), %xmm7
leaq	(%rdi), %r14
vmovdqu	0x40(%rdi), %xmm4
leaq	-0xc0(%rdi,%rdx), %r15
vmovdqu	0x30(%rdi), %xmm5
shrq	$0x4, %rdx
xorq	%r10, %r10
vmovdqu	0x20(%rdi), %xmm6
vpshufb	%xmm0, %xmm7, %xmm7
vmovdqu	0x10(%rdi), %xmm2
vpshufb	%xmm0, %xmm4, %xmm4
vmovdqu	(%rdi), %xmm3
vpshufb	%xmm0, %xmm5, %xmm5
vmovdqu	%xmm4, 0x30(%rsp)
vpshufb	%xmm0, %xmm6, %xmm6
vmovdqu	%xmm5, 0x40(%rsp)
vpshufb	%xmm0, %xmm2, %xmm2
vmovdqu	%xmm6, 0x50(%rsp)
vpshufb	%xmm0, %xmm3, %xmm3
vmovdqu	%xmm2, 0x60(%rsp)
vmovdqu	%xmm3, 0x70(%rsp)
callq	_aesni_ctr32_ghash_6x
vmovups	%xmm9, -0x60(%rsi)
vmovups	%xmm10, -0x50(%rsi)
vmovups	%xmm11, -0x40(%rsi)
vmovups	%xmm12, -0x30(%rsi)
vmovups	%xmm13, -0x20(%rsi)
vmovups	%xmm14, -0x10(%rsi)
vpshufb	(%r11), %xmm8, %xmm8
vmovdqu	%xmm8, -0x40(%r9)
vzeroupper
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
L_6ac:
movq	%r10, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
_aesni_ctr32_6x:
vmovdqu	-0x80(%rcx), %xmm4
vmovdqu	0x20(%r11), %xmm2
leaq	-0x1(%rbp), %r13
vmovups	-0x70(%rcx), %xmm15
leaq	-0x60(%rcx), %r12
vpxor	%xmm4, %xmm1, %xmm9
addl	$0x6000000, %ebx
jb	L_7e0
vpaddb	%xmm2, %xmm1, %xmm10
vpaddb	%xmm2, %xmm10, %xmm11
vpxor	%xmm4, %xmm10, %xmm10
vpaddb	%xmm2, %xmm11, %xmm12
vpxor	%xmm4, %xmm11, %xmm11
vpaddb	%xmm2, %xmm12, %xmm13
vpxor	%xmm4, %xmm12, %xmm12
vpaddb	%xmm2, %xmm13, %xmm14
vpxor	%xmm4, %xmm13, %xmm13
vpaddb	%xmm2, %xmm14, %xmm1
vpxor	%xmm4, %xmm14, %xmm14
jmp	L_720
nopw	%cs:(%rax,%rax)
L_720:
vaesenc	%xmm15, %xmm9, %xmm9
vaesenc	%xmm15, %xmm10, %xmm10
vaesenc	%xmm15, %xmm11, %xmm11
vaesenc	%xmm15, %xmm12, %xmm12
vaesenc	%xmm15, %xmm13, %xmm13
vaesenc	%xmm15, %xmm14, %xmm14
vmovups	(%r12), %xmm15
leaq	0x10(%r12), %r12
decl	%r13d
jne	L_720
vmovdqu	(%r12), %xmm3
vaesenc	%xmm15, %xmm9, %xmm9
vpxor	(%rdi), %xmm3, %xmm4
vaesenc	%xmm15, %xmm10, %xmm10
vpxor	0x10(%rdi), %xmm3, %xmm5
vaesenc	%xmm15, %xmm11, %xmm11
vpxor	0x20(%rdi), %xmm3, %xmm6
vaesenc	%xmm15, %xmm12, %xmm12
vpxor	0x30(%rdi), %xmm3, %xmm8
vaesenc	%xmm15, %xmm13, %xmm13
vpxor	0x40(%rdi), %xmm3, %xmm2
vaesenc	%xmm15, %xmm14, %xmm14
vpxor	0x50(%rdi), %xmm3, %xmm3
leaq	0x60(%rdi), %rdi
vaesenclast	%xmm4, %xmm9, %xmm9
vaesenclast	%xmm5, %xmm10, %xmm10
vaesenclast	%xmm6, %xmm11, %xmm11
vaesenclast	%xmm8, %xmm12, %xmm12
vaesenclast	%xmm2, %xmm13, %xmm13
vaesenclast	%xmm3, %xmm14, %xmm14
vmovups	%xmm9, (%rsi)
vmovups	%xmm10, 0x10(%rsi)
vmovups	%xmm11, 0x20(%rsi)
vmovups	%xmm12, 0x30(%rsi)
vmovups	%xmm13, 0x40(%rsi)
vmovups	%xmm14, 0x50(%rsi)
leaq	0x60(%rsi), %rsi
rep	retq
nopw	%cs:(%rax,%rax)
nop
L_7e0:
vpshufb	%xmm0, %xmm1, %xmm6
vmovdqu	0x30(%r11), %xmm5
vpaddd	0x40(%r11), %xmm6, %xmm10
vpaddd	%xmm5, %xmm6, %xmm11
vpaddd	%xmm5, %xmm10, %xmm12
vpshufb	%xmm0, %xmm10, %xmm10
vpaddd	%xmm5, %xmm11, %xmm13
vpshufb	%xmm0, %xmm11, %xmm11
vpxor	%xmm4, %xmm10, %xmm10
vpaddd	%xmm5, %xmm12, %xmm14
vpshufb	%xmm0, %xmm12, %xmm12
vpxor	%xmm4, %xmm11, %xmm11
vpaddd	%xmm5, %xmm13, %xmm1
vpshufb	%xmm0, %xmm13, %xmm13
vpxor	%xmm4, %xmm12, %xmm12
vpshufb	%xmm0, %xmm14, %xmm14
vpxor	%xmm4, %xmm13, %xmm13
vpshufb	%xmm0, %xmm1, %xmm1
vpxor	%xmm4, %xmm14, %xmm14
jmp	L_720
nopl	(%rax)
aesni_gcm_encrypt:
xorq	%r10, %r10
cmpq	$0x120, %rdx
jb	L_c66
leaq	(%rsp), %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vzeroupper
vmovdqu	(%r8), %xmm1
addq	$-0x80, %rsp
movl	0xc(%r8), %ebx
leaq	bums_rodata(%rip), %r11
leaq	-0x80(%rcx), %r14
movq	$0xf80, %r15
leaq	0x80(%rcx), %rcx
vmovdqu	(%r11), %xmm0
andq	$-0x80, %rsp
movl	0x70(%rcx), %ebp
andq	%r15, %r14
andq	%rsp, %r15
subq	%r14, %r15
jb	L_8aa
cmpq	$0x300, %r15
jae	L_8aa
subq	%r15, %rsp
L_8aa:
leaq	(%rsi), %r14
leaq	-0xc0(%rsi,%rdx), %r15
shrq	$0x4, %rdx
callq	_aesni_ctr32_6x
vpshufb	%xmm0, %xmm9, %xmm8
vpshufb	%xmm0, %xmm10, %xmm2
vmovdqu	%xmm8, 0x70(%rsp)
vpshufb	%xmm0, %xmm11, %xmm4
vmovdqu	%xmm2, 0x60(%rsp)
vpshufb	%xmm0, %xmm12, %xmm5
vmovdqu	%xmm4, 0x50(%rsp)
vpshufb	%xmm0, %xmm13, %xmm6
vmovdqu	%xmm5, 0x40(%rsp)
vpshufb	%xmm0, %xmm14, %xmm7
vmovdqu	%xmm6, 0x30(%rsp)
callq	_aesni_ctr32_6x
vmovdqu	(%r9), %xmm8
leaq	0x40(%r9), %r9
subq	$0xc, %rdx
movq	$0xc0, %r10
vpshufb	%xmm0, %xmm8, %xmm8
callq	_aesni_ctr32_ghash_6x
vmovdqu	0x20(%rsp), %xmm7
vmovdqu	(%r11), %xmm0
vmovdqu	-0x20(%r9), %xmm3
vpunpckhqdq	%xmm7, %xmm7, %xmm1
vmovdqu	(%r9), %xmm15
vmovups	%xmm9, -0x60(%rsi)
vpshufb	%xmm0, %xmm9, %xmm9
vpxor	%xmm7, %xmm1, %xmm1
vmovups	%xmm10, -0x50(%rsi)
vpshufb	%xmm0, %xmm10, %xmm10
vmovups	%xmm11, -0x40(%rsi)
vpshufb	%xmm0, %xmm11, %xmm11
vmovups	%xmm12, -0x30(%rsi)
vpshufb	%xmm0, %xmm12, %xmm12
vmovups	%xmm13, -0x20(%rsi)
vpshufb	%xmm0, %xmm13, %xmm13
vmovups	%xmm14, -0x10(%rsi)
vpshufb	%xmm0, %xmm14, %xmm14
vmovdqu	%xmm9, 0x10(%rsp)
vmovdqu	0x30(%rsp), %xmm6
vmovdqu	-0x10(%r9), %xmm0
vpunpckhqdq	%xmm6, %xmm6, %xmm2
vpclmulqdq	$0x0, %xmm3, %xmm7, %xmm5
vpxor	%xmm6, %xmm2, %xmm2
vpclmulqdq	$0x11, %xmm3, %xmm7, %xmm7
vpclmulqdq	$0x0, %xmm15, %xmm1, %xmm1
vmovdqu	0x40(%rsp), %xmm9
vpclmulqdq	$0x0, %xmm0, %xmm6, %xmm4
vmovdqu	0x10(%r9), %xmm3
vpxor	%xmm5, %xmm4, %xmm4
vpunpckhqdq	%xmm9, %xmm9, %xmm5
vpclmulqdq	$0x11, %xmm0, %xmm6, %xmm6
vpxor	%xmm5, %xmm9, %xmm5
vpxor	%xmm7, %xmm6, %xmm6
vpclmulqdq	$0x10, %xmm15, %xmm2, %xmm2
vmovdqu	0x30(%r9), %xmm15
vpxor	%xmm1, %xmm2, %xmm2
vmovdqu	0x50(%rsp), %xmm1
vpclmulqdq	$0x0, %xmm3, %xmm9, %xmm7
vmovdqu	0x20(%r9), %xmm0
vpxor	%xmm4, %xmm7, %xmm7
vpunpckhqdq	%xmm1, %xmm1, %xmm4
vpclmulqdq	$0x11, %xmm3, %xmm9, %xmm9
vpxor	%xmm1, %xmm4, %xmm4
vpxor	%xmm6, %xmm9, %xmm9
vpclmulqdq	$0x0, %xmm15, %xmm5, %xmm5
vpxor	%xmm2, %xmm5, %xmm5
vmovdqu	0x60(%rsp), %xmm2
vpclmulqdq	$0x0, %xmm0, %xmm1, %xmm6
vmovdqu	0x40(%r9), %xmm3
vpxor	%xmm7, %xmm6, %xmm6
vpunpckhqdq	%xmm2, %xmm2, %xmm7
vpclmulqdq	$0x11, %xmm0, %xmm1, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpxor	%xmm1, %xmm9, %xmm1
vpclmulqdq	$0x10, %xmm15, %xmm4, %xmm4
vmovdqu	0x60(%r9), %xmm15
vpxor	%xmm5, %xmm4, %xmm4
vpxor	0x70(%rsp), %xmm8, %xmm8
vpclmulqdq	$0x0, %xmm3, %xmm2, %xmm5
vmovdqu	0x50(%r9), %xmm0
vpunpckhqdq	%xmm8, %xmm8, %xmm9
vpxor	%xmm6, %xmm5, %xmm5
vpclmulqdq	$0x11, %xmm3, %xmm2, %xmm2
vpxor	%xmm8, %xmm9, %xmm9
vpxor	%xmm1, %xmm2, %xmm2
vpclmulqdq	$0x0, %xmm15, %xmm7, %xmm7
vpxor	%xmm4, %xmm7, %xmm4
vpclmulqdq	$0x0, %xmm0, %xmm8, %xmm6
vmovdqu	-0x20(%r9), %xmm3
vpunpckhqdq	%xmm14, %xmm14, %xmm1
vpclmulqdq	$0x11, %xmm0, %xmm8, %xmm8
vpxor	%xmm1, %xmm14, %xmm1
vpxor	%xmm5, %xmm6, %xmm5
vpclmulqdq	$0x10, %xmm15, %xmm9, %xmm9
vmovdqu	(%r9), %xmm15
vpxor	%xmm2, %xmm8, %xmm7
vpxor	%xmm4, %xmm9, %xmm6
vmovdqu	-0x10(%r9), %xmm0
vpxor	%xmm5, %xmm7, %xmm9
vpclmulqdq	$0x0, %xmm3, %xmm14, %xmm4
vpxor	%xmm6, %xmm9, %xmm6
vpunpckhqdq	%xmm13, %xmm13, %xmm2
vpclmulqdq	$0x11, %xmm3, %xmm14, %xmm14
vpxor	%xmm2, %xmm13, %xmm2
vpslldq	$0x8, %xmm6, %xmm9
vpclmulqdq	$0x0, %xmm15, %xmm1, %xmm1
vpxor	%xmm5, %xmm9, %xmm8
vpsrldq	$0x8, %xmm6, %xmm6
vpxor	%xmm6, %xmm7, %xmm7
vpclmulqdq	$0x0, %xmm0, %xmm13, %xmm5
vmovdqu	0x10(%r9), %xmm3
vpxor	%xmm4, %xmm5, %xmm5
vpunpckhqdq	%xmm12, %xmm12, %xmm9
vpclmulqdq	$0x11, %xmm0, %xmm13, %xmm13
vpxor	%xmm12, %xmm9, %xmm9
vpxor	%xmm14, %xmm13, %xmm13
vpalignr	$0x8, %xmm8, %xmm8, %xmm14
vpclmulqdq	$0x10, %xmm15, %xmm2, %xmm2
vmovdqu	0x30(%r9), %xmm15
vpxor	%xmm1, %xmm2, %xmm2
vpclmulqdq	$0x0, %xmm3, %xmm12, %xmm4
vmovdqu	0x20(%r9), %xmm0
vpxor	%xmm5, %xmm4, %xmm4
vpunpckhqdq	%xmm11, %xmm11, %xmm1
vpclmulqdq	$0x11, %xmm3, %xmm12, %xmm12
vpxor	%xmm1, %xmm11, %xmm1
vpxor	%xmm13, %xmm12, %xmm12
vxorps	0x10(%rsp), %xmm7, %xmm7
vpclmulqdq	$0x0, %xmm15, %xmm9, %xmm9
vpxor	%xmm2, %xmm9, %xmm9
vpclmulqdq	$0x10, 0x10(%r11), %xmm8, %xmm8
vxorps	%xmm14, %xmm8, %xmm8
vpclmulqdq	$0x0, %xmm0, %xmm11, %xmm5
vmovdqu	0x40(%r9), %xmm3
vpxor	%xmm4, %xmm5, %xmm5
vpunpckhqdq	%xmm10, %xmm10, %xmm2
vpclmulqdq	$0x11, %xmm0, %xmm11, %xmm11
vpxor	%xmm2, %xmm10, %xmm2
vpalignr	$0x8, %xmm8, %xmm8, %xmm14
vpxor	%xmm12, %xmm11, %xmm11
vpclmulqdq	$0x10, %xmm15, %xmm1, %xmm1
vmovdqu	0x60(%r9), %xmm15
vpxor	%xmm1, %xmm9, %xmm1
vxorps	%xmm7, %xmm14, %xmm14
vpclmulqdq	$0x10, 0x10(%r11), %xmm8, %xmm8
vxorps	%xmm14, %xmm8, %xmm8
vpclmulqdq	$0x0, %xmm3, %xmm10, %xmm4
vmovdqu	0x50(%r9), %xmm0
vpxor	%xmm5, %xmm4, %xmm4
vpunpckhqdq	%xmm8, %xmm8, %xmm9
vpclmulqdq	$0x11, %xmm3, %xmm10, %xmm10
vpxor	%xmm8, %xmm9, %xmm9
vpxor	%xmm11, %xmm10, %xmm10
vpclmulqdq	$0x0, %xmm15, %xmm2, %xmm2
vpxor	%xmm1, %xmm2, %xmm2
vpclmulqdq	$0x0, %xmm0, %xmm8, %xmm5
vpclmulqdq	$0x11, %xmm0, %xmm8, %xmm7
vpxor	%xmm4, %xmm5, %xmm5
vpclmulqdq	$0x10, %xmm15, %xmm9, %xmm6
vpxor	%xmm7, %xmm10, %xmm7
vpxor	%xmm2, %xmm6, %xmm6
vpxor	%xmm5, %xmm7, %xmm4
vpxor	%xmm4, %xmm6, %xmm6
vpslldq	$0x8, %xmm6, %xmm1
vmovdqu	0x10(%r11), %xmm3
vpsrldq	$0x8, %xmm6, %xmm6
vpxor	%xmm1, %xmm5, %xmm8
vpxor	%xmm6, %xmm7, %xmm7
vpalignr	$0x8, %xmm8, %xmm8, %xmm2
vpclmulqdq	$0x10, %xmm3, %xmm8, %xmm8
vpxor	%xmm2, %xmm8, %xmm8
vpalignr	$0x8, %xmm8, %xmm8, %xmm2
vpclmulqdq	$0x10, %xmm3, %xmm8, %xmm8
vpxor	%xmm7, %xmm2, %xmm2
vpxor	%xmm2, %xmm8, %xmm8
vpshufb	(%r11), %xmm8, %xmm8
vmovdqu	%xmm8, -0x40(%r9)
vzeroupper
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
L_c66:
movq	%r10, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,194
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	.byte 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 65,69,83,45,78,73,32,71,67,77,32,109,111,100,117,108
	.byte 101,32,102,111,114,32,120,56,54,95,54,52,44,32,67,82
	.byte 89,80,84,79,71,65,77,83,32,98,121,32,60,104,116,116
	.byte 112,115,58,47,47,103,105,116,104,117,98,46,99,111,109,47
	.byte 100,111,116,45,97,115,109,62,0

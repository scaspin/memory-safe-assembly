	.text
crc32_fold_pclmulqdq_reset:
movss	.LCPI0_1(%rip), %xmm0
movups	%xmm0, (%rdi)
xorps	%xmm0, %xmm0
movups	%xmm0, 0x10(%rdi)
movups	%xmm0, 0x20(%rdi)
movups	%xmm0, 0x30(%rdi)
xorl	%eax, %eax
retq
nopl	(%rax)
crc32_fold_pclmulqdq:
pushq	%r15
pushq	%r14
pushq	%r12
pushq	%rbx
subq	$0xc8, %rsp
movq	%rdx, %r14
movq	%rdi, %rbx
xorps	%xmm0, %xmm0
movaps	%xmm0, 0x40(%rsp)
movaps	%xmm0, 0x60(%rsp)
movdqa	(%rdi), %xmm14
movdqa	0x10(%rdi), %xmm0
movdqa	0x20(%rdi), %xmm15
movdqa	0x30(%rdi), %xmm5
movabsq	$0x1c6e41596, %r12
cmpq	$0xf, %rdx
ja	L_c5
testq	%r14, %r14
je	L_e09
leaq	0x60(%rsp), %rdi
movq	%rsi, %r15
movq	%r14, %rdx
movdqa	%xmm5, 0x10(%rsp)
movdqa	%xmm15, 0x30(%rsp)
movdqa	%xmm0, (%rsp)
movdqa	%xmm14, 0x20(%rsp)
callq	memcpy
movdqa	0x20(%rsp), %xmm14
movdqa	(%rsp), %xmm6
movdqa	0x30(%rsp), %xmm15
movdqa	0x10(%rsp), %xmm5
movq	%r15, %rsi
movdqa	0x60(%rsp), %xmm0
movdqa	%xmm0, 0x40(%rsp)
jmp	L_d1d
L_c5:
movdqa	%xmm0, (%rsp)
movd	%ecx, %xmm10
xorl	%eax, %eax
testl	%ecx, %ecx
setne	%dil
movl	%esi, %edx
negl	%edx
andl	$0xf, %edx
je	L_998
movdqu	(%rsi), %xmm6
testl	%ecx, %ecx
je	L_146
pxor	%xmm10, %xmm6
cmpl	$0x3, %edx
ja	L_146
addq	$0x10, %rsi
cmpq	$0x20, %r14
jb	L_c99
movq	%r12, %xmm0
pclmulqdq	$0x10, %xmm14, %xmm0
pclmulqdq	$0x10, .LCPI1_0(%rip), %xmm14
pxor	%xmm0, %xmm14
movdqa	%xmm14, %xmm0
pxor	%xmm6, %xmm0
movdqu	(%rsi), %xmm6
addq	$-0x10, %r14
movdqa	(%rsp), %xmm14
movdqa	%xmm15, (%rsp)
movdqa	%xmm5, %xmm15
movdqa	%xmm0, %xmm5
L_146:
movl	%edx, %eax
shll	$0x4, %eax
leaq	pshufb_shf_table(%rip), %rcx
movdqa	-0x10(%rax,%rcx), %xmm1
movdqa	%xmm14, %xmm0
pshufb	%xmm1, %xmm0
movdqa	.LCPI1_1(%rip), %xmm2
pxor	%xmm1, %xmm2
pshufb	%xmm2, %xmm14
movdqa	(%rsp), %xmm4
movdqa	%xmm4, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm14
pshufb	%xmm2, %xmm4
movdqa	%xmm15, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm4
movdqa	%xmm4, (%rsp)
pshufb	%xmm2, %xmm15
movdqa	%xmm5, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm15
pshufb	%xmm2, %xmm5
pshufb	%xmm1, %xmm6
movdqa	%xmm6, 0x40(%rsp)
por	%xmm5, %xmm6
movdqa	.LCPI1_0(%rip), %xmm1
pclmulqdq	$0x1, %xmm0, %xmm1
movq	%r12, %xmm5
pclmulqdq	$0x10, %xmm0, %xmm5
pxor	%xmm6, %xmm5
pxor	%xmm1, %xmm5
addq	%rdx, %rsi
subq	%rdx, %r14
xorl	%eax, %eax
cmpq	$0x2c0, %r14
jb	L_9a8
L_1fd:
pxor	%xmm8, %xmm8
testl	%eax, %eax
je	L_20b
movdqa	%xmm10, %xmm8
L_20b:
movdqa	%xmm10, 0x80(%rsp)
movl	$0xf5e48c85, %eax
movq	%rax, %xmm0
movdqa	%xmm0, 0x90(%rsp)
movq	%r12, %xmm3
movdqa	(%rsp), %xmm10
nopw	%cs:(%rax,%rax)
L_240:
movdqa	0x10(%rsi), %xmm6
movdqa	0x20(%rsi), %xmm4
movdqa	%xmm4, 0x20(%rsp)
movdqa	0x30(%rsi), %xmm9
movdqa	%xmm9, 0x30(%rsp)
movaps	0x40(%rsi), %xmm0
movaps	%xmm0, 0x70(%rsp)
movaps	0x50(%rsi), %xmm0
movaps	%xmm0, 0x10(%rsp)
movdqa	0x60(%rsi), %xmm13
movdqa	%xmm13, (%rsp)
movdqa	%xmm14, %xmm2
movdqa	%xmm14, %xmm0
movdqa	0x70(%rsi), %xmm7
movdqa	0x90(%rsp), %xmm11
pclmulqdq	$0x1, %xmm11, %xmm2
pmovsxdq	.LCPI1_3(%rip), %xmm12
pclmulqdq	$0x10, %xmm12, %xmm0
pxor	(%rsi), %xmm8
movdqa	%xmm10, %xmm1
pclmulqdq	$0x1, %xmm11, %xmm1
pclmulqdq	$0x10, %xmm12, %xmm10
pxor	0x80(%rsi), %xmm2
pxor	%xmm4, %xmm2
movdqa	%xmm7, %xmm14
pxor	%xmm0, %xmm2
movdqa	%xmm15, %xmm4
pclmulqdq	$0x1, %xmm11, %xmm15
pxor	%xmm8, %xmm13
pclmulqdq	$0x10, %xmm12, %xmm4
pxor	0x90(%rsi), %xmm1
pxor	%xmm8, %xmm1
movdqa	%xmm8, 0xa0(%rsp)
pxor	%xmm9, %xmm1
pxor	%xmm10, %xmm1
movdqa	%xmm5, %xmm0
pxor	%xmm6, %xmm14
pclmulqdq	$0x1, %xmm11, %xmm0
pclmulqdq	$0x10, %xmm12, %xmm5
pxor	0xa0(%rsi), %xmm15
pxor	%xmm8, %xmm15
pxor	0xb0(%rsi), %xmm0
movdqa	0x70(%rsp), %xmm9
pxor	%xmm9, %xmm15
pxor	%xmm6, %xmm15
pxor	%xmm6, %xmm0
pxor	0x10(%rsp), %xmm0
pxor	%xmm4, %xmm15
movdqa	0x20(%rsp), %xmm11
pxor	%xmm11, %xmm0
pxor	%xmm5, %xmm0
movdqa	%xmm2, %xmm4
pclmulqdq	$0x1, %xmm3, %xmm4
movdqa	.LCPI1_0(%rip), %xmm12
pclmulqdq	$0x10, %xmm12, %xmm2
movdqa	%xmm1, %xmm10
pclmulqdq	$0x10, %xmm12, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm10
pxor	0xc0(%rsi), %xmm4
pxor	%xmm11, %xmm2
pxor	%xmm4, %xmm2
movdqa	0x30(%rsp), %xmm8
movdqa	%xmm8, %xmm5
movdqa	%xmm13, 0x50(%rsp)
pxor	%xmm13, %xmm5
pxor	%xmm2, %xmm5
movdqa	%xmm15, %xmm4
pclmulqdq	$0x10, %xmm12, %xmm15
pxor	0xd0(%rsi), %xmm10
pxor	%xmm8, %xmm1
pxor	%xmm10, %xmm1
movdqa	%xmm9, %xmm2
pxor	%xmm14, %xmm2
movdqa	%xmm14, 0xb0(%rsp)
pclmulqdq	$0x1, %xmm3, %xmm4
pxor	%xmm1, %xmm2
movdqa	%xmm0, %xmm1
pclmulqdq	$0x10, %xmm12, %xmm0
pclmulqdq	$0x1, %xmm3, %xmm1
pxor	0xe0(%rsi), %xmm4
pxor	%xmm9, %xmm15
pxor	%xmm4, %xmm15
pxor	0xf0(%rsi), %xmm1
movdqa	0x10(%rsp), %xmm10
pxor	%xmm10, %xmm0
pxor	%xmm10, %xmm15
pxor	%xmm1, %xmm0
pxor	%xmm13, %xmm0
movdqa	%xmm5, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm1
pclmulqdq	$0x10, %xmm12, %xmm5
pxor	0x100(%rsi), %xmm1
movdqa	%xmm2, %xmm4
pclmulqdq	$0x10, %xmm12, %xmm2
movdqa	(%rsp), %xmm13
pxor	%xmm13, %xmm5
pxor	%xmm1, %xmm5
pclmulqdq	$0x1, %xmm3, %xmm4
movdqa	%xmm15, %xmm1
pclmulqdq	$0x10, %xmm12, %xmm15
pxor	0x110(%rsi), %xmm4
pxor	%xmm7, %xmm2
pxor	%xmm4, %xmm2
movdqa	%xmm0, %xmm4
pclmulqdq	$0x1, %xmm3, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm4
pclmulqdq	$0x10, %xmm12, %xmm0
pxor	0x120(%rsi), %xmm1
pxor	%xmm14, %xmm5
pxor	0x130(%rsi), %xmm4
movdqa	0x20(%rsp), %xmm8
pxor	%xmm8, %xmm15
pxor	%xmm1, %xmm15
movdqa	0x30(%rsp), %xmm14
pxor	%xmm14, %xmm0
movdqa	%xmm5, %xmm1
pxor	%xmm4, %xmm0
pclmulqdq	$0x1, %xmm3, %xmm1
pclmulqdq	$0x10, %xmm12, %xmm5
movdqa	%xmm2, %xmm4
pclmulqdq	$0x10, %xmm12, %xmm2
pxor	0x140(%rsi), %xmm1
movdqa	0xa0(%rsp), %xmm9
pxor	%xmm9, %xmm5
pclmulqdq	$0x1, %xmm3, %xmm4
pxor	%xmm1, %xmm5
movdqa	%xmm15, %xmm1
pxor	0x150(%rsi), %xmm4
pxor	%xmm6, %xmm2
pxor	%xmm4, %xmm2
pclmulqdq	$0x10, %xmm12, %xmm15
pxor	%xmm9, %xmm10
pxor	%xmm2, %xmm10
movdqa	%xmm0, %xmm2
pclmulqdq	$0x1, %xmm3, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm2
pclmulqdq	$0x10, %xmm12, %xmm0
pxor	0x160(%rsi), %xmm1
movdqa	0x70(%rsp), %xmm11
pxor	%xmm11, %xmm5
pxor	%xmm6, %xmm15
movdqa	%xmm8, %xmm12
movdqa	%xmm13, %xmm8
pxor	%xmm12, %xmm8
pxor	%xmm1, %xmm15
pxor	0x170(%rsi), %xmm2
pxor	%xmm12, %xmm0
pxor	%xmm15, %xmm8
movdqa	%xmm8, (%rsp)
pxor	%xmm2, %xmm0
movdqa	%xmm14, %xmm15
pxor	%xmm14, %xmm7
movdqa	%xmm5, %xmm4
pxor	%xmm0, %xmm7
pclmulqdq	$0x1, %xmm3, %xmm4
movdqa	.LCPI1_0(%rip), %xmm14
pclmulqdq	$0x10, %xmm14, %xmm5
movdqa	%xmm10, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm1
pclmulqdq	$0x10, %xmm14, %xmm10
pxor	0x180(%rsi), %xmm4
movdqa	%xmm9, %xmm13
pxor	%xmm9, %xmm5
movdqa	%xmm15, %xmm2
pxor	%xmm12, %xmm2
movdqa	%xmm2, %xmm0
pxor	%xmm4, %xmm5
movdqa	%xmm11, %xmm12
pxor	%xmm11, %xmm0
pxor	%xmm5, %xmm0
pxor	0x190(%rsi), %xmm1
pxor	%xmm9, %xmm10
movdqa	%xmm15, %xmm4
pxor	%xmm6, %xmm4
pxor	%xmm1, %xmm10
movdqa	%xmm4, %xmm1
pxor	%xmm11, %xmm1
movdqa	%xmm1, %xmm15
movdqa	0x10(%rsp), %xmm11
pxor	%xmm11, %xmm15
pxor	%xmm10, %xmm15
movdqa	(%rsp), %xmm8
movdqa	%xmm8, %xmm5
pclmulqdq	$0x10, %xmm14, %xmm8
pclmulqdq	$0x1, %xmm3, %xmm5
pxor	0x1a0(%rsi), %xmm5
pxor	%xmm6, %xmm8
pxor	%xmm5, %xmm8
movdqa	%xmm8, (%rsp)
movdqa	%xmm7, %xmm5
pclmulqdq	$0x1, %xmm3, %xmm5
pxor	0x1b0(%rsi), %xmm5
pclmulqdq	$0x10, %xmm14, %xmm7
pxor	%xmm9, %xmm7
pxor	%xmm11, %xmm2
pxor	%xmm5, %xmm7
pxor	0x50(%rsp), %xmm2
movdqa	%xmm2, %xmm5
movdqa	0xb0(%rsp), %xmm8
pxor	%xmm8, %xmm5
pxor	%xmm7, %xmm5
movdqa	%xmm0, %xmm10
pclmulqdq	$0x1, %xmm3, %xmm10
pxor	0x1c0(%rsi), %xmm10
pclmulqdq	$0x10, %xmm14, %xmm0
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm0
movdqa	%xmm15, %xmm10
pclmulqdq	$0x1, %xmm3, %xmm10
pclmulqdq	$0x10, %xmm14, %xmm15
movdqa	%xmm14, %xmm7
pxor	0x1d0(%rsi), %xmm10
pxor	%xmm6, %xmm15
pxor	%xmm10, %xmm15
movdqa	%xmm12, %xmm10
movdqa	0x20(%rsp), %xmm9
pxor	%xmm9, %xmm10
pxor	%xmm11, %xmm10
movdqa	%xmm10, %xmm14
pxor	%xmm8, %xmm10
pxor	%xmm15, %xmm10
movdqa	%xmm5, %xmm15
pclmulqdq	$0x1, %xmm3, %xmm15
pxor	0x1f0(%rsi), %xmm15
movdqa	%xmm7, %xmm11
pclmulqdq	$0x10, %xmm7, %xmm5
pxor	%xmm13, %xmm5
pxor	%xmm15, %xmm5
movdqa	0x50(%rsp), %xmm7
pxor	%xmm7, %xmm1
movdqa	%xmm8, %xmm15
pxor	%xmm8, %xmm1
pxor	%xmm1, %xmm0
pxor	%xmm1, %xmm5
movdqa	%xmm0, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm1
pclmulqdq	$0x10, %xmm11, %xmm0
pxor	0x200(%rsi), %xmm1
pxor	%xmm13, %xmm0
pxor	%xmm1, %xmm0
pxor	%xmm7, %xmm14
movdqa	%xmm7, %xmm1
pxor	(%rsp), %xmm14
pxor	%xmm12, %xmm6
movdqa	%xmm9, %xmm8
pxor	%xmm9, %xmm6
movdqa	0x10(%rsp), %xmm7
pxor	%xmm7, %xmm6
pxor	%xmm15, %xmm6
movdqa	%xmm15, %xmm11
pxor	%xmm0, %xmm6
movdqa	%xmm14, %xmm0
movdqa	.LCPI1_0(%rip), %xmm9
pclmulqdq	$0x10, %xmm9, %xmm14
pxor	%xmm13, %xmm14
pclmulqdq	$0x1, %xmm3, %xmm0
pxor	0x1e0(%rsi), %xmm0
pxor	%xmm0, %xmm14
movdqa	%xmm10, %xmm0
pclmulqdq	$0x1, %xmm3, %xmm0
pxor	0x210(%rsi), %xmm0
pclmulqdq	$0x10, %xmm9, %xmm10
pxor	%xmm8, %xmm10
pxor	%xmm0, %xmm10
pxor	%xmm2, %xmm14
pxor	%xmm7, %xmm4
pxor	%xmm1, %xmm4
pxor	%xmm10, %xmm4
movdqa	%xmm14, %xmm0
pclmulqdq	$0x1, %xmm3, %xmm0
movdqa	%xmm9, %xmm2
pclmulqdq	$0x10, %xmm9, %xmm14
pxor	0x220(%rsi), %xmm0
pxor	%xmm8, %xmm14
pxor	%xmm0, %xmm14
movdqa	%xmm5, %xmm0
pclmulqdq	$0x10, %xmm9, %xmm5
movdqa	0x30(%rsp), %xmm9
pxor	%xmm9, %xmm5
pxor	%xmm12, %xmm9
pxor	%xmm1, %xmm9
movdqa	%xmm1, %xmm10
pxor	%xmm15, %xmm9
pxor	%xmm14, %xmm9
pclmulqdq	$0x1, %xmm3, %xmm0
pxor	0x230(%rsi), %xmm0
pxor	%xmm5, %xmm0
movdqa	%xmm6, %xmm1
pclmulqdq	$0x10, %xmm2, %xmm6
pxor	%xmm12, %xmm6
movdqa	%xmm12, %xmm5
pxor	%xmm7, %xmm5
pxor	%xmm15, %xmm5
pxor	%xmm0, %xmm5
pclmulqdq	$0x1, %xmm3, %xmm1
pxor	0x240(%rsi), %xmm1
pxor	%xmm1, %xmm6
movdqa	%xmm4, %xmm0
pclmulqdq	$0x1, %xmm3, %xmm0
pclmulqdq	$0x10, %xmm2, %xmm4
movdqa	%xmm7, %xmm14
pxor	%xmm7, %xmm4
pxor	%xmm10, %xmm14
pxor	0x250(%rsi), %xmm0
pxor	%xmm6, %xmm14
pxor	%xmm4, %xmm0
movdqa	%xmm9, %xmm15
pclmulqdq	$0x10, %xmm2, %xmm9
pxor	%xmm10, %xmm9
pxor	%xmm11, %xmm10
pxor	%xmm0, %xmm10
pclmulqdq	$0x1, %xmm3, %xmm15
pxor	0x260(%rsi), %xmm15
pxor	%xmm9, %xmm15
movdqa	%xmm5, %xmm0
pclmulqdq	$0x1, %xmm3, %xmm0
pxor	0x270(%rsi), %xmm0
pclmulqdq	$0x10, %xmm2, %xmm5
pxor	%xmm11, %xmm5
pxor	%xmm0, %xmm5
pxor	%xmm11, %xmm15
addq	$-0x280, %r14
addq	$0x280, %rsi
pxor	%xmm8, %xmm8
cmpq	$0x2bf, %r14
ja	L_240
movdqa	%xmm10, (%rsp)
xorl	%eax, %eax
movdqa	0x80(%rsp), %xmm10
jmp	L_9b2
L_998:
movb	%dil, %al
cmpq	$0x2c0, %r14
jae	L_1fd
L_9a8:
cmpq	$0x40, %r14
jb	L_b31
L_9b2:
addq	$-0x40, %r14
movq	%r12, %xmm0
movdqa	%xmm14, %xmm2
pclmulqdq	$0x1, %xmm0, %xmm2
movdqa	.LCPI1_0(%rip), %xmm1
movdqa	%xmm14, %xmm6
pclmulqdq	$0x10, %xmm1, %xmm6
movdqa	(%rsp), %xmm7
movdqa	%xmm7, %xmm3
pclmulqdq	$0x1, %xmm0, %xmm3
pclmulqdq	$0x10, %xmm1, %xmm7
movdqa	%xmm15, %xmm4
pclmulqdq	$0x1, %xmm0, %xmm4
movdqa	%xmm15, %xmm8
pclmulqdq	$0x10, %xmm1, %xmm8
movdqa	%xmm5, %xmm9
pclmulqdq	$0x1, %xmm0, %xmm5
pclmulqdq	$0x10, %xmm1, %xmm9
pxor	%xmm14, %xmm14
testl	%eax, %eax
je	L_a25
movdqa	%xmm10, %xmm14
L_a25:
leaq	0x40(%rsi), %rcx
pxor	(%rsi), %xmm14
pxor	%xmm2, %xmm14
pxor	%xmm6, %xmm14
pxor	0x10(%rsi), %xmm3
pxor	%xmm7, %xmm3
movdqa	%xmm3, (%rsp)
pxor	0x20(%rsi), %xmm4
movdqa	%xmm4, %xmm15
pxor	%xmm8, %xmm15
pxor	0x30(%rsi), %xmm5
pxor	%xmm9, %xmm5
xorl	%eax, %eax
cmpq	$0x40, %r14
jb	L_b2e
movdqa	(%rsp), %xmm11
nopw	%cs:(%rax,%rax)
L_a80:
addq	$-0x40, %r14
movdqa	%xmm14, %xmm2
movdqa	%xmm14, %xmm3
pclmulqdq	$0x1, %xmm0, %xmm3
movdqa	%xmm11, %xmm4
movdqa	%xmm5, %xmm9
movdqa	%xmm11, %xmm5
pclmulqdq	$0x1, %xmm0, %xmm5
movdqa	%xmm15, %xmm6
movdqa	%xmm15, %xmm7
pclmulqdq	$0x1, %xmm0, %xmm7
movdqa	%xmm9, %xmm8
pclmulqdq	$0x1, %xmm0, %xmm9
pxor	(%rcx), %xmm3
pxor	0x10(%rcx), %xmm5
pxor	0x20(%rcx), %xmm7
pxor	0x30(%rcx), %xmm9
leaq	0x40(%rcx), %rcx
pclmulqdq	$0x10, %xmm1, %xmm2
pclmulqdq	$0x10, %xmm1, %xmm4
pclmulqdq	$0x10, %xmm1, %xmm6
pclmulqdq	$0x10, %xmm1, %xmm8
movdqa	%xmm3, %xmm14
pxor	%xmm2, %xmm14
movdqa	%xmm5, %xmm11
pxor	%xmm4, %xmm11
movdqa	%xmm7, %xmm15
pxor	%xmm6, %xmm15
movdqa	%xmm9, %xmm5
pxor	%xmm8, %xmm5
cmpq	$0x3f, %r14
ja	L_a80
movdqa	%xmm11, (%rsp)
L_b2e:
movq	%rcx, %rsi
L_b31:
cmpq	$0x30, %r14
jb	L_bc9
pxor	%xmm0, %xmm0
testl	%eax, %eax
je	L_b48
movdqa	%xmm10, %xmm0
L_b48:
addq	$-0x30, %r14
movq	%r12, %xmm2
movdqa	%xmm15, %xmm1
pclmulqdq	$0x1, %xmm2, %xmm1
movdqa	.LCPI1_0(%rip), %xmm3
pxor	0x20(%rsi), %xmm1
pclmulqdq	$0x10, %xmm3, %xmm15
pxor	%xmm15, %xmm1
movdqa	(%rsp), %xmm6
movdqa	%xmm6, %xmm4
pclmulqdq	$0x1, %xmm2, %xmm4
pxor	(%rsi), %xmm0
pxor	0x10(%rsi), %xmm4
leaq	0x30(%rsi), %rsi
pclmulqdq	$0x10, %xmm3, %xmm6
pclmulqdq	$0x10, %xmm14, %xmm2
pclmulqdq	$0x10, %xmm3, %xmm14
pxor	%xmm2, %xmm0
pxor	%xmm14, %xmm0
pxor	%xmm6, %xmm4
movdqa	%xmm5, %xmm14
movdqa	%xmm0, %xmm6
movdqa	%xmm4, %xmm15
movdqa	%xmm1, %xmm5
jmp	L_d14
L_bc9:
cmpq	$0x20, %r14
jb	L_c41
pxor	%xmm0, %xmm0
testl	%eax, %eax
je	L_bdc
movdqa	%xmm10, %xmm0
L_bdc:
addq	$-0x20, %r14
movq	%r12, %xmm1
movdqa	(%rsp), %xmm4
movdqa	%xmm4, %xmm2
pxor	(%rsi), %xmm0
pclmulqdq	$0x1, %xmm1, %xmm2
pxor	0x10(%rsi), %xmm2
addq	$0x20, %rsi
movdqa	.LCPI1_0(%rip), %xmm3
pclmulqdq	$0x10, %xmm3, %xmm4
pclmulqdq	$0x10, %xmm14, %xmm1
pclmulqdq	$0x10, %xmm3, %xmm14
pxor	%xmm1, %xmm0
pxor	%xmm14, %xmm0
pxor	%xmm4, %xmm2
movdqa	%xmm15, %xmm14
movdqa	%xmm5, %xmm6
movdqa	%xmm0, %xmm15
movdqa	%xmm2, %xmm5
jmp	L_d14
L_c41:
cmpq	$0x10, %r14
jb	L_c92
pxor	%xmm0, %xmm0
testl	%eax, %eax
je	L_c54
movdqa	%xmm10, %xmm0
L_c54:
addq	$-0x10, %r14
movq	%r12, %xmm1
pclmulqdq	$0x10, %xmm14, %xmm1
pxor	(%rsi), %xmm0
pclmulqdq	$0x10, .LCPI1_0(%rip), %xmm14
addq	$0x10, %rsi
pxor	%xmm1, %xmm0
pxor	%xmm14, %xmm0
movdqa	(%rsp), %xmm14
movdqa	%xmm15, %xmm6
movdqa	%xmm5, %xmm15
jmp	L_d10
L_c92:
movdqa	(%rsp), %xmm6
jmp	L_d14
L_c99:
addq	$-0x10, %r14
leaq	0x60(%rsp), %rdi
movq	%rsi, %r15
movq	%r14, %rdx
movdqa	%xmm5, 0x10(%rsp)
movdqa	%xmm15, 0x30(%rsp)
movdqa	%xmm14, 0x20(%rsp)
movdqa	%xmm6, 0x50(%rsp)
callq	memcpy
movq	%r15, %rsi
movaps	0x60(%rsp), %xmm0
movaps	%xmm0, 0x40(%rsp)
movq	%r12, %xmm0
movdqa	0x20(%rsp), %xmm1
pclmulqdq	$0x10, %xmm1, %xmm0
pclmulqdq	$0x10, .LCPI1_0(%rip), %xmm1
pxor	%xmm0, %xmm1
movdqa	%xmm1, %xmm0
pxor	0x50(%rsp), %xmm0
movdqa	(%rsp), %xmm14
movdqa	0x30(%rsp), %xmm6
movdqa	0x10(%rsp), %xmm15
L_d10:
movdqa	%xmm0, %xmm5
L_d14:
testq	%r14, %r14
je	L_df4
L_d1d:
movdqa	%xmm5, 0x10(%rsp)
movdqa	%xmm14, 0x20(%rsp)
movdqa	%xmm6, (%rsp)
movdqa	%xmm15, 0x30(%rsp)
leaq	0x40(%rsp), %rdi
movq	%r14, %rdx
callq	memcpy
movdqa	0x20(%rsp), %xmm14
movdqa	(%rsp), %xmm6
movdqa	0x30(%rsp), %xmm15
shlq	$0x4, %r14
leaq	pshufb_shf_table(%rip), %rax
movdqa	-0x10(%r14,%rax), %xmm1
movdqa	%xmm14, %xmm0
pshufb	%xmm1, %xmm0
movdqa	.LCPI1_1(%rip), %xmm2
pxor	%xmm1, %xmm2
pshufb	%xmm2, %xmm14
movdqa	%xmm6, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm14
pshufb	%xmm2, %xmm6
movdqa	%xmm15, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm6
pshufb	%xmm2, %xmm15
movdqa	0x10(%rsp), %xmm4
movdqa	%xmm4, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm15
pshufb	%xmm2, %xmm4
movdqa	0x40(%rsp), %xmm2
pshufb	%xmm1, %xmm2
por	%xmm4, %xmm2
movdqa	.LCPI1_0(%rip), %xmm1
pclmulqdq	$0x1, %xmm0, %xmm1
movq	%r12, %xmm5
pclmulqdq	$0x10, %xmm0, %xmm5
pxor	%xmm2, %xmm5
pxor	%xmm1, %xmm5
L_df4:
movdqu	%xmm14, (%rbx)
movdqu	%xmm6, 0x10(%rbx)
movdqu	%xmm15, 0x20(%rbx)
movdqu	%xmm5, 0x30(%rbx)
L_e09:
addq	$0xc8, %rsp
popq	%rbx
popq	%r12
popq	%r14
popq	%r15
retq
nopl	(%rax,%rax)
crc32_fold_pclmulqdq_copy:
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x60, %rsp
movq	%rcx, %r14
movq	%rdx, %r12
movq	%rsi, %r15
movq	%rdi, %rbx
pxor	%xmm0, %xmm0
movdqa	%xmm0, (%rsp)
movdqa	%xmm0, 0x10(%rsp)
movdqa	(%rdi), %xmm7
movdqa	0x10(%rdi), %xmm9
movdqa	0x20(%rdi), %xmm11
movdqa	0x30(%rdi), %xmm13
movabsq	$0x1c6e41596, %r13
cmpq	$0xf, %rcx
ja	L_edb
testq	%r14, %r14
je	L_1318
leaq	0x10(%rsp), %rdi
movq	%r12, %rsi
movq	%r14, %rdx
movdqa	%xmm13, 0x50(%rsp)
movdqa	%xmm11, 0x40(%rsp)
movdqa	%xmm9, 0x30(%rsp)
movdqa	%xmm7, 0x20(%rsp)
callq	memcpy
movdqa	0x10(%rsp), %xmm0
movdqa	%xmm0, (%rsp)
movq	%r15, %rdi
movq	%r12, %rsi
movq	%r14, %rdx
callq	memmove
movdqa	0x20(%rsp), %xmm7
movdqa	0x30(%rsp), %xmm9
movdqa	0x40(%rsp), %xmm11
movdqa	0x50(%rsp), %xmm13
jmp	L_120c
L_edb:
movl	%r12d, %eax
negl	%eax
andl	$0xf, %eax
je	L_f9a
movdqu	(%r12), %xmm0
movdqu	%xmm0, (%r15)
addq	%rax, %r15
movl	%eax, %ecx
shll	$0x4, %ecx
leaq	pshufb_shf_table(%rip), %rdx
movdqa	-0x10(%rcx,%rdx), %xmm2
movdqa	%xmm7, %xmm1
pshufb	%xmm2, %xmm1
movdqa	.LCPI2_0(%rip), %xmm3
pxor	%xmm2, %xmm3
pshufb	%xmm3, %xmm7
movdqa	%xmm9, %xmm4
pshufb	%xmm2, %xmm4
por	%xmm4, %xmm7
pshufb	%xmm3, %xmm9
movdqa	%xmm11, %xmm4
pshufb	%xmm2, %xmm4
por	%xmm4, %xmm9
pshufb	%xmm3, %xmm11
movdqa	%xmm13, %xmm4
pshufb	%xmm2, %xmm4
por	%xmm4, %xmm11
pshufb	%xmm3, %xmm13
pshufb	%xmm2, %xmm0
movdqa	%xmm0, (%rsp)
por	%xmm13, %xmm0
movdqa	.LCPI2_1(%rip), %xmm2
pclmulqdq	$0x1, %xmm1, %xmm2
movq	%r13, %xmm13
pclmulqdq	$0x10, %xmm1, %xmm13
pxor	%xmm0, %xmm13
pxor	%xmm2, %xmm13
addq	%rax, %r12
subq	%rax, %r14
L_f9a:
cmpq	$0x40, %r14
jb	L_1077
movq	%r13, %xmm0
movdqa	.LCPI2_1(%rip), %xmm1
nopw	%cs:(%rax,%rax)
L_fc0:
addq	$-0x40, %r14
movdqa	(%r12), %xmm5
movdqa	0x10(%r12), %xmm4
movdqa	0x20(%r12), %xmm3
movdqa	0x30(%r12), %xmm2
addq	$0x40, %r12
movdqa	%xmm7, %xmm6
pclmulqdq	$0x1, %xmm0, %xmm7
pclmulqdq	$0x10, %xmm1, %xmm6
movdqa	%xmm9, %xmm8
pclmulqdq	$0x1, %xmm0, %xmm9
pclmulqdq	$0x10, %xmm1, %xmm8
movdqa	%xmm11, %xmm10
pclmulqdq	$0x1, %xmm0, %xmm11
pclmulqdq	$0x10, %xmm1, %xmm10
movdqa	%xmm13, %xmm12
pclmulqdq	$0x1, %xmm0, %xmm13
pclmulqdq	$0x10, %xmm1, %xmm12
movdqu	%xmm5, (%r15)
movdqu	%xmm4, 0x10(%r15)
movdqu	%xmm3, 0x20(%r15)
movdqu	%xmm2, 0x30(%r15)
addq	$0x40, %r15
pxor	%xmm5, %xmm7
pxor	%xmm6, %xmm7
pxor	%xmm4, %xmm9
pxor	%xmm8, %xmm9
pxor	%xmm3, %xmm11
pxor	%xmm10, %xmm11
pxor	%xmm2, %xmm13
pxor	%xmm12, %xmm13
cmpq	$0x3f, %r14
ja	L_fc0
L_1077:
cmpq	$0x30, %r14
jb	L_1130
addq	$-0x30, %r14
movdqa	(%r12), %xmm0
movdqa	0x10(%r12), %xmm1
movdqa	0x20(%r12), %xmm2
addq	$0x30, %r12
movdqu	%xmm0, (%r15)
movdqu	%xmm1, 0x10(%r15)
movdqu	%xmm2, 0x20(%r15)
addq	$0x30, %r15
movq	%r13, %xmm3
movdqa	%xmm11, %xmm4
pclmulqdq	$0x1, %xmm3, %xmm4
movdqa	.LCPI2_1(%rip), %xmm5
pclmulqdq	$0x10, %xmm5, %xmm11
pxor	%xmm4, %xmm11
movdqa	%xmm9, %xmm4
pclmulqdq	$0x1, %xmm3, %xmm4
pclmulqdq	$0x10, %xmm5, %xmm9
pxor	%xmm4, %xmm9
pclmulqdq	$0x10, %xmm7, %xmm3
pclmulqdq	$0x10, %xmm5, %xmm7
pxor	%xmm3, %xmm7
movdqa	%xmm11, %xmm3
movdqa	%xmm9, %xmm4
movdqa	%xmm7, %xmm5
pxor	%xmm0, %xmm5
pxor	%xmm1, %xmm4
pxor	%xmm2, %xmm3
movdqa	%xmm4, %xmm11
movdqa	%xmm5, %xmm9
movdqa	%xmm13, %xmm7
movdqa	%xmm3, %xmm13
jmp	L_1203
L_1130:
cmpq	$0x20, %r14
jb	L_11b5
addq	$-0x20, %r14
movdqa	(%r12), %xmm0
movdqa	0x10(%r12), %xmm1
addq	$0x20, %r12
movdqu	%xmm0, (%r15)
movdqu	%xmm1, 0x10(%r15)
addq	$0x20, %r15
movq	%r13, %xmm2
movdqa	%xmm9, %xmm3
pclmulqdq	$0x1, %xmm2, %xmm3
movdqa	.LCPI2_1(%rip), %xmm4
pclmulqdq	$0x10, %xmm4, %xmm9
pxor	%xmm3, %xmm9
pclmulqdq	$0x10, %xmm7, %xmm2
pclmulqdq	$0x10, %xmm4, %xmm7
pxor	%xmm2, %xmm7
movdqa	%xmm7, %xmm2
pxor	%xmm0, %xmm2
movdqa	%xmm9, %xmm0
pxor	%xmm1, %xmm0
movdqa	%xmm11, %xmm7
movdqa	%xmm13, %xmm9
movdqa	%xmm2, %xmm11
movdqa	%xmm0, %xmm13
jmp	L_1203
L_11b5:
cmpq	$0x10, %r14
jb	L_1203
addq	$-0x10, %r14
movdqa	(%r12), %xmm0
addq	$0x10, %r12
movdqu	%xmm0, (%r15)
addq	$0x10, %r15
movq	%r13, %xmm1
pclmulqdq	$0x10, %xmm7, %xmm1
pclmulqdq	$0x10, .LCPI2_1(%rip), %xmm7
pxor	%xmm0, %xmm1
pxor	%xmm7, %xmm1
movdqa	%xmm9, %xmm7
movdqa	%xmm11, %xmm9
movdqa	%xmm13, %xmm11
movdqa	%xmm1, %xmm13
L_1203:
testq	%r14, %r14
je	L_1302
L_120c:
movdqa	%xmm13, 0x50(%rsp)
movdqa	%xmm7, 0x20(%rsp)
movdqa	%xmm9, 0x30(%rsp)
movdqa	%xmm11, 0x40(%rsp)
movq	%rsp, %rdi
movq	%r12, %rsi
movq	%r14, %rdx
callq	memcpy
movaps	(%rsp), %xmm0
movaps	%xmm0, 0x10(%rsp)
leaq	0x10(%rsp), %rsi
movq	%r15, %rdi
movq	%r14, %rdx
callq	memcpy
movdqa	0x20(%rsp), %xmm7
movdqa	0x30(%rsp), %xmm9
movdqa	0x40(%rsp), %xmm11
shlq	$0x4, %r14
leaq	pshufb_shf_table(%rip), %rax
movdqa	-0x10(%r14,%rax), %xmm1
movdqa	%xmm7, %xmm0
pshufb	%xmm1, %xmm0
movdqa	.LCPI2_0(%rip), %xmm2
pxor	%xmm1, %xmm2
pshufb	%xmm2, %xmm7
movdqa	%xmm9, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm7
pshufb	%xmm2, %xmm9
movdqa	%xmm11, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm9
pshufb	%xmm2, %xmm11
movdqa	0x50(%rsp), %xmm4
movdqa	%xmm4, %xmm3
pshufb	%xmm1, %xmm3
por	%xmm3, %xmm11
pshufb	%xmm2, %xmm4
movdqa	(%rsp), %xmm2
pshufb	%xmm1, %xmm2
por	%xmm4, %xmm2
movdqa	.LCPI2_1(%rip), %xmm1
pclmulqdq	$0x1, %xmm0, %xmm1
movq	%r13, %xmm13
pclmulqdq	$0x10, %xmm0, %xmm13
pxor	%xmm2, %xmm13
pxor	%xmm1, %xmm13
L_1302:
movdqu	%xmm7, (%rbx)
movdqu	%xmm9, 0x10(%rbx)
movdqu	%xmm11, 0x20(%rbx)
movdqu	%xmm13, 0x30(%rbx)
L_1318:
addq	$0x60, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
retq
nopw	%cs:(%rax,%rax)
crc32_fold_pclmulqdq_final:
movdqa	(%rdi), %xmm1
movdqa	.LCPI3_0(%rip), %xmm0
movdqa	%xmm1, %xmm2
pclmulqdq	$0x10, %xmm0, %xmm2
movl	$0xccaa009e, %eax
movq	%rax, %xmm3
pclmulqdq	$0x1, %xmm3, %xmm1
pxor	0x10(%rdi), %xmm2
pxor	%xmm1, %xmm2
movdqa	%xmm2, %xmm1
pclmulqdq	$0x10, %xmm0, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm2
pxor	0x20(%rdi), %xmm1
pxor	%xmm2, %xmm1
pclmulqdq	$0x1, %xmm1, %xmm0
pxor	0x30(%rdi), %xmm0
pclmulqdq	$0x1, %xmm3, %xmm1
pxor	%xmm1, %xmm0
pclmulqdq	$0x0, %xmm0, %xmm3
psrldq	$0x8, %xmm0
pxor	%xmm3, %xmm0
movdqa	%xmm0, %xmm1
psllq	$0x20, %xmm1
pclmulqdq	$0x10, .LCPI3_1(%rip), %xmm1
pxor	%xmm0, %xmm1
pxor	%xmm0, %xmm0
pblendw	$0xfc, %xmm1, %xmm0
movabsq	$0x1f7011640, %rax
movq	%rax, %xmm2
pclmulqdq	$0x0, %xmm0, %xmm2
pxor	%xmm0, %xmm2
movq	%xmm2, %xmm0
pclmulqdq	$0x10, .LCPI3_2(%rip), %xmm0
pxor	%xmm1, %xmm0
pextrd	$0x2, %xmm0, %eax
notl	%eax
movl	%eax, 0x40(%rdi)
retq
nopw	%cs:(%rax,%rax)
crc32_pclmulqdq:
subq	$0x48, %rsp
movl	%edi, %eax
cmpq	$0xf, %rdx
ja	L_1432
testq	%rdx, %rdx
je	L_1582
notl	%eax
testb	$0x1, %dl
jne	L_151e
movq	%rdx, %rcx
cmpq	$0x1, %rdx
jne	L_1543
jmp	L_1580
L_1432:
movss	.LCPI4_4(%rip), %xmm0
movaps	%xmm0, (%rsp)
xorps	%xmm0, %xmm0
movaps	%xmm0, 0x10(%rsp)
movaps	%xmm0, 0x20(%rsp)
movaps	%xmm0, 0x30(%rsp)
movq	%rsp, %rdi
movl	%eax, %ecx
callq	crc32_fold_pclmulqdq
movdqa	(%rsp), %xmm1
movdqa	.LCPI4_1(%rip), %xmm0
movdqa	%xmm1, %xmm2
pclmulqdq	$0x10, %xmm0, %xmm2
movl	$0xccaa009e, %eax
movq	%rax, %xmm3
pclmulqdq	$0x1, %xmm3, %xmm1
pxor	0x10(%rsp), %xmm2
pxor	%xmm1, %xmm2
movdqa	%xmm2, %xmm1
pclmulqdq	$0x10, %xmm0, %xmm1
pclmulqdq	$0x1, %xmm3, %xmm2
pxor	0x20(%rsp), %xmm1
pxor	%xmm2, %xmm1
pclmulqdq	$0x1, %xmm1, %xmm0
pxor	0x30(%rsp), %xmm0
pclmulqdq	$0x1, %xmm3, %xmm1
pxor	%xmm1, %xmm0
pclmulqdq	$0x0, %xmm0, %xmm3
psrldq	$0x8, %xmm0
pxor	%xmm3, %xmm0
movdqa	%xmm0, %xmm1
psllq	$0x20, %xmm1
pclmulqdq	$0x10, .LCPI4_2(%rip), %xmm1
pxor	%xmm0, %xmm1
pxor	%xmm2, %xmm2
pblendw	$0xfc, %xmm1, %xmm2
movabsq	$0x1f7011640, %rax
movq	%rax, %xmm0
pclmulqdq	$0x0, %xmm2, %xmm0
pxor	%xmm2, %xmm0
movq	%xmm0, %xmm0
pclmulqdq	$0x10, .LCPI4_3(%rip), %xmm0
pxor	%xmm1, %xmm0
pextrd	$0x2, %xmm0, %eax
jmp	L_1580
L_151e:
leaq	-0x1(%rdx), %rcx
movzbl	(%rsi), %edi
xorb	%al, %dil
incq	%rsi
movzbl	%dil, %edi
leaq	crc_table(%rip), %r8
shrl	$0x8, %eax
xorl	(%r8,%rdi,4), %eax
cmpq	$0x1, %rdx
je	L_1580
L_1543:
xorl	%edx, %edx
leaq	crc_table(%rip), %rdi
nopl	(%rax)
L_1550:
movzbl	(%rsi,%rdx), %r8d
xorb	%al, %r8b
movzbl	%r8b, %r8d
shrl	$0x8, %eax
xorl	(%rdi,%r8,4), %eax
movzbl	0x1(%rsi,%rdx), %r8d
xorb	%al, %r8b
movzbl	%r8b, %r8d
shrl	$0x8, %eax
xorl	(%rdi,%r8,4), %eax
addq	$0x2, %rdx
cmpq	%rdx, %rcx
jne	L_1550
L_1580:
notl	%eax
L_1582:
addq	$0x48, %rsp
retq
	.section .rodata
	.p2align 5
pshufb_shf_table:
	.size pshufb_shf_table, 240
	.byte 129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,0
	.byte 130,131,132,133,134,135,136,137,138,139,140,141,142,143,0,1
	.byte 131,132,133,134,135,136,137,138,139,140,141,142,143,0,1,2
	.byte 132,133,134,135,136,137,138,139,140,141,142,143,0,1,2,3
	.byte 133,134,135,136,137,138,139,140,141,142,143,0,1,2,3,4
	.byte 134,135,136,137,138,139,140,141,142,143,0,1,2,3,4,5
	.byte 135,136,137,138,139,140,141,142,143,0,1,2,3,4,5,6
	.byte 136,137,138,139,140,141,142,143,0,1,2,3,4,5,6,7
	.byte 137,138,139,140,141,142,143,0,1,2,3,4,5,6,7,8
	.byte 138,139,140,141,142,143,0,1,2,3,4,5,6,7,8,9
	.byte 139,140,141,142,143,0,1,2,3,4,5,6,7,8,9,10
	.byte 140,141,142,143,0,1,2,3,4,5,6,7,8,9,10,11
	.byte 141,142,143,0,1,2,3,4,5,6,7,8,9,10,11,12
	.byte 142,143,0,1,2,3,4,5,6,7,8,9,10,11,12,13
	.byte 143,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14
crc_table:
	.size crc_table, 1024
	.byte 0,0,0,0,150,48,7,119,44,97,14,238,186,81,9,153
	.byte 25,196,109,7,143,244,106,112,53,165,99,233,163,149,100,158
	.byte 50,136,219,14,164,184,220,121,30,233,213,224,136,217,210,151
	.byte 43,76,182,9,189,124,177,126,7,45,184,231,145,29,191,144
	.byte 100,16,183,29,242,32,176,106,72,113,185,243,222,65,190,132
	.byte 125,212,218,26,235,228,221,109,81,181,212,244,199,133,211,131
	.byte 86,152,108,19,192,168,107,100,122,249,98,253,236,201,101,138
	.byte 79,92,1,20,217,108,6,99,99,61,15,250,245,13,8,141
	.byte 200,32,110,59,94,16,105,76,228,65,96,213,114,113,103,162
	.byte 209,228,3,60,71,212,4,75,253,133,13,210,107,181,10,165
	.byte 250,168,181,53,108,152,178,66,214,201,187,219,64,249,188,172
	.byte 227,108,216,50,117,92,223,69,207,13,214,220,89,61,209,171
	.byte 172,48,217,38,58,0,222,81,128,81,215,200,22,97,208,191
	.byte 181,244,180,33,35,196,179,86,153,149,186,207,15,165,189,184
	.byte 158,184,2,40,8,136,5,95,178,217,12,198,36,233,11,177
	.byte 135,124,111,47,17,76,104,88,171,29,97,193,61,45,102,182
	.byte 144,65,220,118,6,113,219,1,188,32,210,152,42,16,213,239
	.byte 137,133,177,113,31,181,182,6,165,228,191,159,51,212,184,232
	.byte 162,201,7,120,52,249,0,15,142,168,9,150,24,152,14,225
	.byte 187,13,106,127,45,61,109,8,151,108,100,145,1,92,99,230
	.byte 244,81,107,107,98,97,108,28,216,48,101,133,78,0,98,242
	.byte 237,149,6,108,123,165,1,27,193,244,8,130,87,196,15,245
	.byte 198,217,176,101,80,233,183,18,234,184,190,139,124,136,185,252
	.byte 223,29,221,98,73,45,218,21,243,124,211,140,101,76,212,251
	.byte 88,97,178,77,206,81,181,58,116,0,188,163,226,48,187,212
	.byte 65,165,223,74,215,149,216,61,109,196,209,164,251,244,214,211
	.byte 106,233,105,67,252,217,110,52,70,136,103,173,208,184,96,218
	.byte 115,45,4,68,229,29,3,51,95,76,10,170,201,124,13,221
	.byte 60,113,5,80,170,65,2,39,16,16,11,190,134,32,12,201
	.byte 37,181,104,87,179,133,111,32,9,212,102,185,159,228,97,206
	.byte 14,249,222,94,152,201,217,41,34,152,208,176,180,168,215,199
	.byte 23,61,179,89,129,13,180,46,59,92,189,183,173,108,186,192
	.byte 32,131,184,237,182,179,191,154,12,226,182,3,154,210,177,116
	.byte 57,71,213,234,175,119,210,157,21,38,219,4,131,22,220,115
	.byte 18,11,99,227,132,59,100,148,62,106,109,13,168,90,106,122
	.byte 11,207,14,228,157,255,9,147,39,174,0,10,177,158,7,125
	.byte 68,147,15,240,210,163,8,135,104,242,1,30,254,194,6,105
	.byte 93,87,98,247,203,103,101,128,113,54,108,25,231,6,107,110
	.byte 118,27,212,254,224,43,211,137,90,122,218,16,204,74,221,103
	.byte 111,223,185,249,249,239,190,142,67,190,183,23,213,142,176,96
	.byte 232,163,214,214,126,147,209,161,196,194,216,56,82,242,223,79
	.byte 241,103,187,209,103,87,188,166,221,6,181,63,75,54,178,72
	.byte 218,43,13,216,76,27,10,175,246,74,3,54,96,122,4,65
	.byte 195,239,96,223,85,223,103,168,239,142,110,49,121,190,105,70
	.byte 140,179,97,203,26,131,102,188,160,210,111,37,54,226,104,82
	.byte 149,119,12,204,3,71,11,187,185,22,2,34,47,38,5,85
	.byte 190,59,186,197,40,11,189,178,146,90,180,43,4,106,179,92
	.byte 167,255,215,194,49,207,208,181,139,158,217,44,29,174,222,91
	.byte 176,194,100,155,38,242,99,236,156,163,106,117,10,147,109,2
	.byte 169,6,9,156,63,54,14,235,133,103,7,114,19,87,0,5
	.byte 130,74,191,149,20,122,184,226,174,43,177,123,56,27,182,12
	.byte 155,142,210,146,13,190,213,229,183,239,220,124,33,223,219,11
	.byte 212,210,211,134,66,226,212,241,248,179,221,104,110,131,218,31
	.byte 205,22,190,129,91,38,185,246,225,119,176,111,119,71,183,24
	.byte 230,90,8,136,112,106,15,255,202,59,6,102,92,11,1,17
	.byte 255,158,101,143,105,174,98,248,211,255,107,97,69,207,108,22
	.byte 120,226,10,160,238,210,13,215,84,131,4,78,194,179,3,57
	.byte 97,38,103,167,247,22,96,208,77,71,105,73,219,119,110,62
	.byte 74,106,209,174,220,90,214,217,102,11,223,64,240,59,216,55
	.byte 83,174,188,169,197,158,187,222,127,207,178,71,233,255,181,48
	.byte 28,242,189,189,138,194,186,202,48,147,179,83,166,163,180,36
	.byte 5,54,208,186,147,6,215,205,41,87,222,84,191,103,217,35
	.byte 46,122,102,179,184,74,97,196,2,27,104,93,148,43,111,42
	.byte 55,190,11,180,161,142,12,195,27,223,5,90,141,239,2,45
	.section .rodata.cst16
	.p2align 4
	.byte 135,36,180,157,0,0,0,0,0,0,0,0,0,0,0,0
.LCPI1_0:
	.byte 0,0,0,0,0,0,0,0,212,43,68,84,1,0,0,0
.LCPI1_1:
	.byte 128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
	.byte 0,0,0,0,0,0,0,0,129,141,108,89,0,0,0,0
.LCPI2_0:
	.byte 128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
.LCPI2_1:
	.byte 0,0,0,0,0,0,0,0,212,43,68,84,1,0,0,0
.LCPI3_0:
	.byte 0,0,0,0,0,0,0,0,208,151,25,117,1,0,0,0
.LCPI3_1:
	.byte 0,0,0,0,0,0,0,0,36,97,205,99,1,0,0,0
.LCPI3_2:
	.byte 0,0,0,0,0,0,0,0,64,6,113,219,1,0,0,0
	.byte 135,36,180,157,0,0,0,0,0,0,0,0,0,0,0,0
.LCPI4_1:
	.byte 0,0,0,0,0,0,0,0,208,151,25,117,1,0,0,0
.LCPI4_2:
	.byte 0,0,0,0,0,0,0,0,36,97,205,99,1,0,0,0
.LCPI4_3:
	.byte 0,0,0,0,0,0,0,0,64,6,113,219,1,0,0,0
	.section .rodata.cst4
	.p2align 2
.LCPI0_1:
	.byte 135,36,180,157
.LCPI4_4:
	.byte 135,36,180,157
	.section .rodata.cst8
	.p2align 2
.LCPI1_3:
	.byte 129,141,108,89,129,141,108,89
# ---- reference memcpy: copies (%rsi)[0..%rdx) to (%rdi)[0..%rdx)
	.text
memcpy:
movq	%rdi, %rax
testq	%rdx, %rdx
je	memcpy_done
memcpy_loop:
movb	(%rsi), %cl
movb	%cl, (%rdi)
incq	%rsi
incq	%rdi
decq	%rdx
jne	memcpy_loop
memcpy_done:
retq
# ---- reference memmove: reads (%rsi)[0..%rdx) and writes (%rdi)[0..%rdx), the bytes memcpy touches
	.text
memmove:
movq	%rdi, %rax
testq	%rdx, %rdx
je	memmove_done
memmove_loop:
movb	(%rsi), %cl
movb	%cl, (%rdi)
incq	%rsi
incq	%rdi
decq	%rdx
jne	memmove_loop
memmove_done:
retq

	.text
crc32_fold_vpclmulqdq_reset:
vmovss	.LCPI0_1(%rip), %xmm0
vmovups	%xmm0, (%rdi)
vxorps	%xmm0, %xmm0, %xmm0
vmovups	%ymm0, 0x10(%rdi)
vmovups	%ymm0, 0x20(%rdi)
xorl	%eax, %eax
vzeroupper
retq
crc32_fold_vpclmulqdq:
pushq	%r15
pushq	%r14
pushq	%r12
pushq	%rbx
subq	$0xb8, %rsp
movq	%rdx, %r14
movq	%rdi, %rbx
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa	%xmm0, (%rsp)
vmovdqa	%xmm0, 0x30(%rsp)
vmovdqa	(%rdi), %xmm10
vmovdqa	0x10(%rdi), %xmm9
vmovdqa	0x20(%rdi), %xmm8
vmovdqa	0x30(%rdi), %xmm11
movabsq	$0x1c6e41596, %r12
cmpq	$0xf, %rdx
ja	L_bd
testq	%r14, %r14
je	L_624
leaq	0x30(%rsp), %rdi
movq	%rsi, %r15
movq	%r14, %rdx
vmovdqu64	%zmm10, 0x70(%rsp)
vmovdqu	%ymm8, 0x40(%rsp)
vmovdqa	%xmm11, 0x20(%rsp)
vmovdqa	%xmm9, 0x10(%rsp)
vzeroupper
callq	memcpy
vmovdqu64	0x70(%rsp), %zmm6
movq	%r15, %rsi
vmovdqa	0x30(%rsp), %xmm0
vmovdqa	%xmm0, (%rsp)
jmp	L_55c
L_bd:
vmovd	%ecx, %xmm0
xorl	%eax, %eax
testl	%ecx, %ecx
setne	%dil
movl	%esi, %edx
negl	%edx
andl	$0xf, %edx
je	L_332
vmovdqu	(%rsi), %xmm6
testl	%ecx, %ecx
je	L_135
vpxor	%xmm0, %xmm6, %xmm6
cmpl	$0x3, %edx
ja	L_135
addq	$0x10, %rsi
cmpq	$0x20, %r14
jb	L_69d
vmovq	%r12, %xmm1
vpclmulqdq	$0x1, %xmm1, %xmm10, %xmm1
vpbroadcastq	.LCPI1_0(%rip), %xmm2
vpclmulqdq	$0x10, %xmm2, %xmm10, %xmm2
vmovdqa	%xmm9, %xmm10
vmovdqa	%xmm8, %xmm9
vmovdqa	%xmm11, %xmm8
vmovdqa	%xmm6, %xmm3
vmovdqu	(%rsi), %xmm6
vpternlogq	$0x96, %xmm2, %xmm1, %xmm3
addq	$-0x10, %r14
vmovdqa	%xmm3, %xmm11
L_135:
movl	%edx, %eax
shll	$0x4, %eax
leaq	pshufb_shf_table(%rip), %rcx
vmovdqa	-0x10(%rax,%rcx), %xmm1
vpshufb	%xmm1, %xmm10, %xmm2
vpxord	.LCPI1_5(%rip){1to4}, %xmm1, %xmm3
vpshufb	%xmm3, %xmm10, %xmm4
vpshufb	%xmm1, %xmm9, %xmm5
vpor	%xmm4, %xmm5, %xmm10
vpshufb	%xmm3, %xmm9, %xmm4
vpshufb	%xmm1, %xmm8, %xmm5
vpor	%xmm4, %xmm5, %xmm9
vpshufb	%xmm3, %xmm8, %xmm4
vpshufb	%xmm1, %xmm11, %xmm5
vpor	%xmm4, %xmm5, %xmm8
vpshufb	%xmm3, %xmm11, %xmm3
vpshufb	%xmm1, %xmm6, %xmm1
vmovdqa	%xmm1, (%rsp)
vpbroadcastq	.LCPI1_0(%rip), %xmm4
vpor	%xmm3, %xmm1, %xmm1
vpclmulqdq	$0x10, %xmm4, %xmm2, %xmm3
vmovq	%r12, %xmm4
vpclmulqdq	$0x1, %xmm4, %xmm2, %xmm11
vpternlogq	$0x96, %xmm1, %xmm3, %xmm11
addq	%rdx, %rsi
subq	%rdx, %r14
xorl	%eax, %eax
cmpq	$0x100, %r14
jae	L_342
L_1c9:
cmpq	$0x40, %r14
jb	L_4b5
L_1d3:
addq	$-0x40, %r14
vmovq	%r12, %xmm3
vpclmulqdq	$0x1, %xmm3, %xmm10, %xmm5
vpbroadcastq	.LCPI1_0(%rip), %xmm4
vpclmulqdq	$0x10, %xmm4, %xmm10, %xmm10
vpclmulqdq	$0x1, %xmm3, %xmm9, %xmm6
vpclmulqdq	$0x10, %xmm4, %xmm9, %xmm2
vpclmulqdq	$0x1, %xmm3, %xmm8, %xmm7
vpclmulqdq	$0x10, %xmm4, %xmm8, %xmm1
vpclmulqdq	$0x1, %xmm3, %xmm11, %xmm8
vpclmulqdq	$0x10, %xmm4, %xmm11, %xmm11
vpxor	%xmm9, %xmm9, %xmm9
testl	%eax, %eax
je	L_222
vmovdqa	%xmm0, %xmm9
L_222:
leaq	0x40(%rsi), %rcx
vpxor	(%rsi), %xmm9, %xmm9
vpternlogq	$0x96, %xmm5, %xmm9, %xmm10
vpternlogq	$0x96, 0x10(%rsi), %xmm6, %xmm2
vpternlogq	$0x96, 0x20(%rsi), %xmm7, %xmm1
vpternlogq	$0x96, 0x30(%rsi), %xmm8, %xmm11
xorl	%eax, %eax
cmpq	$0x40, %r14
jb	L_2bd
nopw	%cs:(%rax,%rax)
L_260:
addq	$-0x40, %r14
vpclmulqdq	$0x1, %xmm3, %xmm10, %xmm5
vpclmulqdq	$0x10, %xmm4, %xmm10, %xmm10
vpclmulqdq	$0x1, %xmm3, %xmm2, %xmm6
vpclmulqdq	$0x10, %xmm4, %xmm2, %xmm2
vpclmulqdq	$0x1, %xmm3, %xmm1, %xmm7
vpclmulqdq	$0x10, %xmm4, %xmm1, %xmm1
vpclmulqdq	$0x1, %xmm3, %xmm11, %xmm8
vpclmulqdq	$0x10, %xmm4, %xmm11, %xmm11
vpternlogq	$0x96, (%rcx), %xmm5, %xmm10
vpternlogq	$0x96, 0x10(%rcx), %xmm6, %xmm2
vpternlogq	$0x96, 0x20(%rcx), %xmm7, %xmm1
vpternlogq	$0x96, 0x30(%rcx), %xmm8, %xmm11
addq	$0x40, %rcx
cmpq	$0x3f, %r14
ja	L_260
L_2bd:
movq	%rcx, %rsi
cmpq	$0x30, %r14
jae	L_4c7
L_2ca:
cmpq	$0x20, %r14
jb	L_636
vpxor	%xmm3, %xmm3, %xmm3
testl	%eax, %eax
je	L_2e0
vmovdqa	%xmm0, %xmm3
L_2e0:
vmovq	%r12, %xmm0
vpclmulqdq	$0x1, %xmm0, %xmm2, %xmm4
vpbroadcastq	.LCPI1_0(%rip), %xmm5
vmovdqa	%xmm11, %xmm7
vpclmulqdq	$0x10, %xmm5, %xmm2, %xmm2
vpxor	(%rsi), %xmm3, %xmm8
vpternlogq	$0x96, 0x10(%rsi), %xmm4, %xmm2
addq	$-0x20, %r14
addq	$0x20, %rsi
vpclmulqdq	$0x1, %xmm0, %xmm10, %xmm0
vpclmulqdq	$0x10, %xmm5, %xmm10, %xmm3
vpternlogq	$0x96, %xmm0, %xmm3, %xmm8
vmovdqa	%xmm1, %xmm9
vmovdqa	%xmm2, %xmm11
jmp	L_531
L_332:
movb	%dil, %al
cmpq	$0x100, %r14
jb	L_1c9
L_342:
vpxor	%xmm1, %xmm1, %xmm1
testl	%eax, %eax
je	L_34e
vmovdqa	%xmm0, %xmm1
L_34e:
vpxorq	(%rsi), %zmm1, %zmm7
vmovdqu64	0x40(%rsi), %zmm3
vmovdqu64	0x80(%rsi), %zmm2
vmovdqu64	0xc0(%rsi), %zmm1
vinserti128	$0x1, %xmm11, %ymm8, %ymm5
vinserti128	$0x1, %xmm9, %ymm10, %ymm6
vpbroadcastq	.LCPI1_2(%rip), %zmm4
vinserti64x4	$0x1, %ymm5, %zmm6, %zmm6
vpclmulqdq	$0x1, %zmm4, %zmm6, %zmm8
vpbroadcastq	.LCPI1_0(%rip), %zmm5
vpclmulqdq	$0x10, %zmm5, %zmm6, %zmm6
vpternlogd	$0x96, %zmm7, %zmm8, %zmm6
leaq	-0x100(%r14), %rcx
cmpq	$0x100, %rcx
jb	L_44d
leaq	0x1c0(%rsi), %rax
vpbroadcastq	.LCPI1_3(%rip), %zmm7
vpbroadcastq	.LCPI1_4(%rip), %zmm8
nopw	%cs:(%rax,%rax)
L_3e0:
vpclmulqdq	$0x1, %zmm7, %zmm6, %zmm9
vpclmulqdq	$0x1, %zmm7, %zmm3, %zmm10
vpclmulqdq	$0x1, %zmm7, %zmm2, %zmm11
vpclmulqdq	$0x1, %zmm7, %zmm1, %zmm12
vpclmulqdq	$0x10, %zmm8, %zmm6, %zmm6
vpclmulqdq	$0x10, %zmm8, %zmm3, %zmm3
vpclmulqdq	$0x10, %zmm8, %zmm2, %zmm2
vpclmulqdq	$0x10, %zmm8, %zmm1, %zmm1
vpternlogd	$0x96, -0xc0(%rax), %zmm9, %zmm6
vpternlogd	$0x96, -0x80(%rax), %zmm10, %zmm3
vpternlogd	$0x96, -0x40(%rax), %zmm11, %zmm2
vpternlogd	$0x96, (%rax), %zmm12, %zmm1
addq	$-0x100, %rcx
addq	$0x100, %rax
cmpq	$0xff, %rcx
ja	L_3e0
L_44d:
vpclmulqdq	$0x1, %zmm4, %zmm6, %zmm7
vpclmulqdq	$0x10, %zmm5, %zmm6, %zmm6
vpternlogd	$0x96, %zmm3, %zmm7, %zmm6
vpclmulqdq	$0x1, %zmm4, %zmm6, %zmm3
vpclmulqdq	$0x10, %zmm5, %zmm6, %zmm6
vpternlogd	$0x96, %zmm2, %zmm3, %zmm6
vpclmulqdq	$0x1, %zmm4, %zmm6, %zmm2
vpclmulqdq	$0x10, %zmm5, %zmm6, %zmm10
vpternlogd	$0x96, %zmm1, %zmm2, %zmm10
vextracti128	$0x1, %ymm10, %xmm9
vextracti32x4	$0x2, %zmm10, %xmm8
vextracti32x4	$0x3, %zmm10, %xmm11
subq	%rcx, %r14
addq	%r14, %rsi
xorl	%eax, %eax
movq	%rcx, %r14
cmpq	$0x40, %r14
jae	L_1d3
L_4b5:
vmovdqa	%xmm9, %xmm2
vmovdqa	%xmm8, %xmm1
cmpq	$0x30, %r14
jb	L_2ca
L_4c7:
vpxor	%xmm3, %xmm3, %xmm3
testl	%eax, %eax
je	L_4d3
vmovdqa	%xmm0, %xmm3
L_4d3:
addq	$-0x30, %r14
vmovq	%r12, %xmm0
vpclmulqdq	$0x1, %xmm0, %xmm1, %xmm4
vpbroadcastq	.LCPI1_0(%rip), %xmm5
vmovdqa	%xmm11, %xmm9
vpclmulqdq	$0x10, %xmm5, %xmm1, %xmm1
vpclmulqdq	$0x1, %xmm0, %xmm2, %xmm6
vpclmulqdq	$0x10, %xmm5, %xmm2, %xmm8
vpxor	(%rsi), %xmm3, %xmm7
vpternlogq	$0x96, 0x10(%rsi), %xmm6, %xmm8
vpternlogq	$0x96, 0x20(%rsi), %xmm4, %xmm1
addq	$0x30, %rsi
vpclmulqdq	$0x1, %xmm0, %xmm10, %xmm0
vpclmulqdq	$0x10, %xmm5, %xmm10, %xmm2
vpternlogq	$0x96, %xmm0, %xmm2, %xmm7
vmovdqa	%xmm1, %xmm11
L_531:
vmovdqa	%xmm8, %xmm1
vmovdqa	%xmm7, %xmm0
vmovdqa	%xmm9, %xmm6
vmovdqa	%xmm11, 0x20(%rsp)
vmovdqa	%xmm8, %xmm2
vmovdqu	%ymm2, 0x40(%rsp)
vmovdqa	%xmm7, 0x10(%rsp)
testq	%r14, %r14
je	L_611
L_55c:
vmovdqu64	%zmm6, 0x70(%rsp)
movq	%rsp, %rdi
movq	%r14, %rdx
vzeroupper
callq	memcpy
shlq	$0x4, %r14
leaq	pshufb_shf_table(%rip), %rax
vmovdqa	-0x10(%r14,%rax), %xmm2
vpxord	.LCPI1_5(%rip){1to4}, %xmm2, %xmm3
vmovdqu64	0x70(%rsp), %zmm0
vpshufb	%xmm2, %xmm0, %xmm4
vpshufb	%xmm3, %xmm0, %xmm0
vmovdqa	0x10(%rsp), %xmm5
vpshufb	%xmm2, %xmm5, %xmm1
vpor	%xmm0, %xmm1, %xmm6
vpshufb	%xmm3, %xmm5, %xmm0
vmovdqu	0x40(%rsp), %ymm5
vpshufb	%xmm2, %xmm5, %xmm1
vpor	%xmm0, %xmm1, %xmm0
vpshufb	%xmm3, %xmm5, %xmm1
vmovdqa	0x20(%rsp), %xmm7
vpshufb	%xmm2, %xmm7, %xmm5
vpor	%xmm1, %xmm5, %xmm1
vpshufb	%xmm3, %xmm7, %xmm3
vmovdqa	(%rsp), %xmm5
vpshufb	%xmm2, %xmm5, %xmm2
vpor	%xmm3, %xmm2, %xmm2
vpbroadcastq	.LCPI1_0(%rip), %xmm3
vpclmulqdq	$0x10, %xmm3, %xmm4, %xmm3
vmovq	%r12, %xmm5
vpclmulqdq	$0x1, %xmm5, %xmm4, %xmm11
vpternlogq	$0x96, %xmm2, %xmm3, %xmm11
L_611:
vmovdqu	%xmm6, (%rbx)
vmovdqu	%xmm0, 0x10(%rbx)
vmovdqu	%xmm1, 0x20(%rbx)
vmovdqu	%xmm11, 0x30(%rbx)
L_624:
addq	$0xb8, %rsp
popq	%rbx
popq	%r12
popq	%r14
popq	%r15
vzeroupper
retq
L_636:
cmpq	$0x10, %r14
jb	L_68b
vpxor	%xmm3, %xmm3, %xmm3
testl	%eax, %eax
je	L_648
vmovdqa	%xmm0, %xmm3
L_648:
addq	$-0x10, %r14
vmovq	%r12, %xmm0
vpclmulqdq	$0x1, %xmm0, %xmm10, %xmm0
vpbroadcastq	.LCPI1_0(%rip), %xmm4
vpclmulqdq	$0x10, %xmm4, %xmm10, %xmm4
vmovdqa	%xmm11, %xmm8
vpxor	(%rsi), %xmm3, %xmm3
addq	$0x10, %rsi
vpternlogq	$0x96, %xmm0, %xmm4, %xmm3
vmovdqa	%xmm2, %xmm9
vmovdqa	%xmm1, %xmm7
vmovdqa	%xmm3, %xmm11
jmp	L_531
L_68b:
vmovdqa	%xmm10, %xmm9
vmovdqa	%xmm2, %xmm7
vmovdqa	%xmm1, %xmm8
jmp	L_531
L_69d:
addq	$-0x10, %r14
leaq	0x30(%rsp), %rdi
movq	%rsi, %r15
movq	%r14, %rdx
vmovdqu64	%zmm10, 0x70(%rsp)
vmovdqa	%xmm6, 0x60(%rsp)
vmovdqu	%ymm8, 0x40(%rsp)
vmovdqa	%xmm11, 0x20(%rsp)
vmovdqa	%xmm9, 0x10(%rsp)
vzeroupper
callq	memcpy
vmovdqa	0x10(%rsp), %xmm9
vmovdqa	0x20(%rsp), %xmm8
vmovdqu	0x40(%rsp), %ymm7
vmovdqa	0x60(%rsp), %xmm11
movq	%r15, %rsi
vmovaps	0x30(%rsp), %xmm0
vmovaps	%xmm0, (%rsp)
vmovq	%r12, %xmm0
vmovdqu64	0x70(%rsp), %zmm2
vpclmulqdq	$0x1, %xmm0, %xmm2, %xmm0
vpbroadcastq	.LCPI1_0(%rip), %xmm1
vpclmulqdq	$0x10, %xmm1, %xmm2, %xmm1
vpternlogq	$0x96, %xmm1, %xmm0, %xmm11
jmp	L_531
nop
crc32_fold_vpclmulqdq_copy:
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0xa0, %rsp
movq	%rcx, %r14
movq	%rdx, %r12
movq	%rsi, %r15
movq	%rdi, %rbx
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa	%xmm0, (%rsp)
vmovdqa	%xmm0, 0x10(%rsp)
vmovdqa	(%rdi), %xmm11
vmovdqa	0x10(%rdi), %xmm12
vmovdqa	0x20(%rdi), %xmm10
vmovdqa	0x30(%rdi), %xmm13
movabsq	$0x1c6e41596, %r13
cmpq	$0xf, %rcx
ja	L_7f2
testq	%r14, %r14
je	L_d5c
leaq	0x10(%rsp), %rdi
movq	%r12, %rsi
movq	%r14, %rdx
vmovdqu	%ymm10, 0x40(%rsp)
vmovdqu64	%zmm11, 0x60(%rsp)
vmovdqa	%xmm12, 0x30(%rsp)
vmovdqa	%xmm13, 0x20(%rsp)
vzeroupper
callq	memcpy
vmovdqa	0x10(%rsp), %xmm0
vmovdqa	%xmm0, (%rsp)
movq	%r15, %rdi
movq	%r12, %rsi
movq	%r14, %rdx
callq	memmove
vmovdqa	0x20(%rsp), %xmm13
vmovdqa	0x30(%rsp), %xmm12
vmovdqu64	0x60(%rsp), %zmm11
vmovdqu	0x40(%rsp), %ymm10
jmp	L_c64
L_7f2:
movl	%r12d, %edx
negl	%edx
andl	$0xf, %edx
je	L_8ad
vmovdqu	(%r12), %xmm0
vmovdqu	%xmm0, (%r15)
leaq	(%r15,%rdx), %rax
movl	%edx, %ecx
shll	$0x4, %ecx
leaq	pshufb_shf_table(%rip), %rsi
vmovdqa	-0x10(%rcx,%rsi), %xmm1
vpshufb	%xmm1, %xmm11, %xmm2
vpxord	.LCPI2_5(%rip){1to4}, %xmm1, %xmm3
vpshufb	%xmm3, %xmm11, %xmm4
vpshufb	%xmm1, %xmm12, %xmm5
vpor	%xmm4, %xmm5, %xmm11
vpshufb	%xmm3, %xmm12, %xmm4
vpshufb	%xmm1, %xmm10, %xmm5
vpor	%xmm4, %xmm5, %xmm12
vpshufb	%xmm3, %xmm10, %xmm4
vpshufb	%xmm1, %xmm13, %xmm5
vpor	%xmm4, %xmm5, %xmm10
vpshufb	%xmm3, %xmm13, %xmm3
vpshufb	%xmm1, %xmm0, %xmm0
vmovdqa	%xmm0, (%rsp)
vpor	%xmm3, %xmm0, %xmm0
vpbroadcastq	.LCPI2_1(%rip), %xmm1
vpclmulqdq	$0x10, %xmm1, %xmm2, %xmm1
vmovq	%r13, %xmm3
vpclmulqdq	$0x1, %xmm3, %xmm2, %xmm13
vpternlogq	$0x96, %xmm0, %xmm1, %xmm13
leaq	(%r12,%rdx), %rcx
subq	%rdx, %r14
cmpq	$0x100, %r14
jae	L_8bc
L_89e:
cmpq	$0x40, %r14
jae	L_a76
jmp	L_b18
L_8ad:
movq	%r12, %rcx
movq	%r15, %rax
cmpq	$0x100, %r14
jb	L_89e
L_8bc:
vmovdqu64	(%rcx), %zmm6
vmovdqu64	0x40(%rcx), %zmm2
vmovdqu64	0x80(%rcx), %zmm1
vmovdqu64	0xc0(%rcx), %zmm0
vinserti128	$0x1, %xmm13, %ymm10, %ymm4
vinserti128	$0x1, %xmm12, %ymm11, %ymm5
vpbroadcastq	.LCPI2_2(%rip), %zmm3
vinserti64x4	$0x1, %ymm4, %zmm5, %zmm5
vpclmulqdq	$0x1, %zmm3, %zmm5, %zmm7
vpbroadcastq	.LCPI2_1(%rip), %zmm4
vpclmulqdq	$0x10, %zmm4, %zmm5, %zmm5
vpternlogd	$0x96, %zmm6, %zmm7, %zmm5
vmovdqu64	%zmm6, (%rax)
vmovdqu64	%zmm2, 0x40(%rax)
vmovdqu64	%zmm1, 0x80(%rax)
vmovdqu64	%zmm0, 0xc0(%rax)
leaq	-0x100(%r14), %rsi
cmpq	$0x100, %rsi
jb	L_a0d
orq	$0x1c0, %rdx
vpbroadcastq	.LCPI2_3(%rip), %zmm6
vpbroadcastq	.LCPI2_4(%rip), %zmm7
nopl	(%rax)
L_960:
vmovdqu64	-0xc0(%r12,%rdx), %zmm8
vmovdqu64	-0x80(%r12,%rdx), %zmm9
vmovdqu64	-0x40(%r12,%rdx), %zmm10
vmovdqu64	(%r12,%rdx), %zmm11
vpclmulqdq	$0x1, %zmm6, %zmm5, %zmm12
vpclmulqdq	$0x1, %zmm6, %zmm2, %zmm13
vpclmulqdq	$0x1, %zmm6, %zmm1, %zmm14
vpclmulqdq	$0x1, %zmm6, %zmm0, %zmm15
vpclmulqdq	$0x10, %zmm7, %zmm5, %zmm5
vpclmulqdq	$0x10, %zmm7, %zmm2, %zmm2
vpclmulqdq	$0x10, %zmm7, %zmm1, %zmm1
vpclmulqdq	$0x10, %zmm7, %zmm0, %zmm0
vpternlogd	$0x96, %zmm8, %zmm12, %zmm5
vpternlogd	$0x96, %zmm9, %zmm13, %zmm2
vpternlogd	$0x96, %zmm10, %zmm14, %zmm1
vpternlogd	$0x96, %zmm11, %zmm15, %zmm0
vmovdqu64	%zmm8, -0xc0(%r15,%rdx)
vmovdqu64	%zmm9, -0x80(%r15,%rdx)
vmovdqu64	%zmm10, -0x40(%r15,%rdx)
vmovdqu64	%zmm11, (%r15,%rdx)
addq	$-0x100, %rsi
addq	$0x100, %rdx
cmpq	$0xff, %rsi
ja	L_960
L_a0d:
vpclmulqdq	$0x1, %zmm3, %zmm5, %zmm6
vpclmulqdq	$0x10, %zmm4, %zmm5, %zmm5
vpternlogd	$0x96, %zmm2, %zmm6, %zmm5
vpclmulqdq	$0x1, %zmm3, %zmm5, %zmm2
vpclmulqdq	$0x10, %zmm4, %zmm5, %zmm5
vpternlogd	$0x96, %zmm1, %zmm2, %zmm5
vpclmulqdq	$0x1, %zmm3, %zmm5, %zmm1
vpclmulqdq	$0x10, %zmm4, %zmm5, %zmm11
vpternlogd	$0x96, %zmm0, %zmm1, %zmm11
vextracti128	$0x1, %ymm11, %xmm12
vextracti32x4	$0x2, %zmm11, %xmm10
vextracti32x4	$0x3, %zmm11, %xmm13
subq	%rsi, %r14
addq	%r14, %rax
addq	%r14, %rcx
movq	%rsi, %r14
cmpq	$0x40, %r14
jb	L_b18
L_a76:
vmovq	%r13, %xmm0
vpbroadcastq	.LCPI2_1(%rip), %xmm1
nopw	%cs:(%rax,%rax)
L_a90:
addq	$-0x40, %r14
vmovdqa	(%rcx), %xmm2
vmovdqa	0x10(%rcx), %xmm3
vmovdqa	0x20(%rcx), %xmm4
vmovdqa	0x30(%rcx), %xmm5
addq	$0x40, %rcx
vpclmulqdq	$0x1, %xmm0, %xmm11, %xmm6
vpclmulqdq	$0x10, %xmm1, %xmm11, %xmm11
vpclmulqdq	$0x1, %xmm0, %xmm12, %xmm7
vpclmulqdq	$0x10, %xmm1, %xmm12, %xmm12
vpclmulqdq	$0x1, %xmm0, %xmm10, %xmm8
vpclmulqdq	$0x10, %xmm1, %xmm10, %xmm10
vpclmulqdq	$0x1, %xmm0, %xmm13, %xmm9
vpclmulqdq	$0x10, %xmm1, %xmm13, %xmm13
vmovdqu	%xmm2, (%rax)
vmovdqu	%xmm3, 0x10(%rax)
vmovdqu	%xmm4, 0x20(%rax)
vmovdqu	%xmm5, 0x30(%rax)
addq	$0x40, %rax
vpternlogq	$0x96, %xmm6, %xmm2, %xmm11
vpternlogq	$0x96, %xmm7, %xmm3, %xmm12
vpternlogq	$0x96, %xmm8, %xmm4, %xmm10
vpternlogq	$0x96, %xmm9, %xmm5, %xmm13
cmpq	$0x3f, %r14
ja	L_a90
L_b18:
cmpq	$0x30, %r14
jb	L_b9b
addq	$-0x30, %r14
vmovdqa	(%rcx), %xmm0
vmovdqa	0x10(%rcx), %xmm1
vmovdqa	0x20(%rcx), %xmm2
addq	$0x30, %rcx
vmovdqu	%xmm0, (%rax)
vmovdqu	%xmm1, 0x10(%rax)
vmovdqu	%xmm2, 0x20(%rax)
addq	$0x30, %rax
vmovq	%r13, %xmm3
vpclmulqdq	$0x1, %xmm3, %xmm10, %xmm4
vpbroadcastq	.LCPI2_1(%rip), %xmm5
vpclmulqdq	$0x10, %xmm5, %xmm10, %xmm6
vpclmulqdq	$0x1, %xmm3, %xmm12, %xmm7
vpclmulqdq	$0x10, %xmm5, %xmm12, %xmm10
vpclmulqdq	$0x1, %xmm3, %xmm11, %xmm3
vpclmulqdq	$0x10, %xmm5, %xmm11, %xmm12
vpternlogq	$0x96, %xmm3, %xmm0, %xmm12
vpternlogq	$0x96, %xmm7, %xmm1, %xmm10
vpternlogq	$0x96, %xmm4, %xmm2, %xmm6
vmovdqa	%xmm13, %xmm11
vmovdqa	%xmm6, %xmm13
jmp	L_c55
L_b9b:
cmpq	$0x20, %r14
jb	L_c07
addq	$-0x20, %r14
vmovdqa	(%rcx), %xmm0
vmovdqa	0x10(%rcx), %xmm1
addq	$0x20, %rcx
vmovdqu	%xmm0, (%rax)
vmovdqu	%xmm1, 0x10(%rax)
addq	$0x20, %rax
vmovq	%r13, %xmm2
vpclmulqdq	$0x1, %xmm2, %xmm12, %xmm3
vpbroadcastq	.LCPI2_1(%rip), %xmm4
vpclmulqdq	$0x10, %xmm4, %xmm12, %xmm5
vpclmulqdq	$0x1, %xmm2, %xmm11, %xmm2
vpclmulqdq	$0x10, %xmm4, %xmm11, %xmm4
vpternlogq	$0x96, %xmm2, %xmm0, %xmm4
vpternlogq	$0x96, %xmm3, %xmm1, %xmm5
vmovdqa	%xmm10, %xmm11
vmovdqa	%xmm13, %xmm12
vmovdqa	%xmm4, %xmm10
vmovdqa	%xmm5, %xmm13
jmp	L_c55
L_c07:
cmpq	$0x10, %r14
jb	L_c55
addq	$-0x10, %r14
vmovdqa	(%rcx), %xmm0
addq	$0x10, %rcx
vmovdqu	%xmm0, (%rax)
addq	$0x10, %rax
vmovq	%r13, %xmm1
vpclmulqdq	$0x1, %xmm1, %xmm11, %xmm1
vpbroadcastq	.LCPI2_1(%rip), %xmm2
vpclmulqdq	$0x10, %xmm2, %xmm11, %xmm2
vpternlogq	$0x96, %xmm1, %xmm0, %xmm2
vmovdqa	%xmm12, %xmm11
vmovdqa	%xmm10, %xmm12
vmovdqa	%xmm13, %xmm10
vmovdqa	%xmm2, %xmm13
L_c55:
movq	%rax, %r15
movq	%rcx, %r12
testq	%r14, %r14
je	L_d49
L_c64:
vmovdqu64	%zmm11, 0x60(%rsp)
vmovdqa	%xmm12, 0x30(%rsp)
vmovdqu	%ymm10, 0x40(%rsp)
vmovdqa	%xmm13, 0x20(%rsp)
movq	%rsp, %rdi
movq	%r12, %rsi
movq	%r14, %rdx
vzeroupper
callq	memcpy
vmovaps	(%rsp), %xmm0
vmovaps	%xmm0, 0x10(%rsp)
leaq	0x10(%rsp), %rsi
movq	%r15, %rdi
movq	%r14, %rdx
callq	memcpy
shlq	$0x4, %r14
leaq	pshufb_shf_table(%rip), %rax
vmovdqa	-0x10(%r14,%rax), %xmm0
vpxord	.LCPI2_5(%rip){1to4}, %xmm0, %xmm1
vmovdqu64	0x60(%rsp), %zmm3
vpshufb	%xmm0, %xmm3, %xmm2
vpshufb	%xmm1, %xmm3, %xmm3
vmovdqa	0x30(%rsp), %xmm5
vpshufb	%xmm0, %xmm5, %xmm4
vpor	%xmm3, %xmm4, %xmm11
vpshufb	%xmm1, %xmm5, %xmm3
vmovdqu	0x40(%rsp), %ymm5
vpshufb	%xmm0, %xmm5, %xmm4
vpor	%xmm3, %xmm4, %xmm12
vpshufb	%xmm1, %xmm5, %xmm3
vmovdqa	0x20(%rsp), %xmm5
vpshufb	%xmm0, %xmm5, %xmm4
vpor	%xmm3, %xmm4, %xmm10
vpshufb	%xmm1, %xmm5, %xmm1
vmovdqa	(%rsp), %xmm3
vpshufb	%xmm0, %xmm3, %xmm0
vpor	%xmm1, %xmm0, %xmm0
vpbroadcastq	.LCPI2_1(%rip), %xmm1
vpclmulqdq	$0x10, %xmm1, %xmm2, %xmm1
vmovq	%r13, %xmm3
vpclmulqdq	$0x1, %xmm3, %xmm2, %xmm13
vpternlogq	$0x96, %xmm0, %xmm1, %xmm13
L_d49:
vmovdqu	%xmm11, (%rbx)
vmovdqu	%xmm12, 0x10(%rbx)
vmovdqu	%xmm10, 0x20(%rbx)
vmovdqu	%xmm13, 0x30(%rbx)
L_d5c:
addq	$0xa0, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
vzeroupper
retq
crc32_fold_vpclmulqdq_final:
vpbroadcastq	.LCPI3_0(%rip), %xmm0
vmovdqa	(%rdi), %xmm1
vpclmulqdq	$0x10, %xmm0, %xmm1, %xmm2
movl	$0xccaa009e, %eax
vmovq	%rax, %xmm3
vpclmulqdq	$0x1, %xmm3, %xmm1, %xmm1
vpternlogq	$0x96, 0x10(%rdi), %xmm2, %xmm1
vpclmulqdq	$0x10, %xmm0, %xmm1, %xmm2
vpclmulqdq	$0x1, %xmm3, %xmm1, %xmm1
vpternlogq	$0x96, 0x20(%rdi), %xmm2, %xmm1
vpclmulqdq	$0x10, %xmm0, %xmm1, %xmm0
vpclmulqdq	$0x1, %xmm3, %xmm1, %xmm1
vpternlogq	$0x96, 0x30(%rdi), %xmm0, %xmm1
vpclmulqdq	$0x0, %xmm3, %xmm1, %xmm0
vpsrldq	$0x8, %xmm1, %xmm1
vpxor	%xmm1, %xmm0, %xmm0
vpbroadcastq	.LCPI3_1(%rip), %xmm1
vpsllq	$0x20, %xmm0, %xmm2
vpclmulqdq	$0x10, %xmm1, %xmm2, %xmm1
vpxor	%xmm1, %xmm0, %xmm0
vpxor	%xmm1, %xmm1, %xmm1
vpblendd	$0x1, %xmm1, %xmm0, %xmm1
movabsq	$0x1f7011640, %rax
vmovq	%rax, %xmm2
vpclmulqdq	$0x0, %xmm2, %xmm1, %xmm2
vpxor	%xmm2, %xmm1, %xmm1
vmovq	%xmm1, %xmm1
vpbroadcastq	.LCPI3_2(%rip), %xmm2
vpclmulqdq	$0x10, %xmm2, %xmm1, %xmm1
vpxor	%xmm1, %xmm0, %xmm0
vpextrd	$0x2, %xmm0, %eax
notl	%eax
movl	%eax, 0x40(%rdi)
retq
crc32_vpclmulqdq:
subq	$0x48, %rsp
movl	%edi, %eax
cmpq	$0xf, %rdx
ja	L_e62
testq	%rdx, %rdx
je	L_fb2
notl	%eax
testb	$0x1, %dl
jne	L_f4c
movq	%rdx, %rcx
cmpq	$0x1, %rdx
jne	L_f71
jmp	L_fb0
L_e62:
vmovss	.LCPI4_4(%rip), %xmm0
vmovaps	%xmm0, (%rsp)
vxorps	%xmm0, %xmm0, %xmm0
vmovups	%ymm0, 0x10(%rsp)
vmovups	%ymm0, 0x20(%rsp)
movq	%rsp, %rdi
movl	%eax, %ecx
vzeroupper
callq	crc32_fold_vpclmulqdq
vmovdqa	(%rsp), %xmm0
vpbroadcastq	.LCPI4_1(%rip), %xmm1
vpclmulqdq	$0x10, %xmm1, %xmm0, %xmm2
movl	$0xccaa009e, %eax
vmovq	%rax, %xmm3
vpclmulqdq	$0x1, %xmm3, %xmm0, %xmm0
vpternlogq	$0x96, 0x10(%rsp), %xmm2, %xmm0
vpclmulqdq	$0x10, %xmm1, %xmm0, %xmm2
vpclmulqdq	$0x1, %xmm3, %xmm0, %xmm0
vpternlogq	$0x96, 0x20(%rsp), %xmm2, %xmm0
vpclmulqdq	$0x10, %xmm1, %xmm0, %xmm1
vpclmulqdq	$0x1, %xmm3, %xmm0, %xmm0
vpternlogq	$0x96, 0x30(%rsp), %xmm1, %xmm0
vpclmulqdq	$0x0, %xmm3, %xmm0, %xmm1
vpsrldq	$0x8, %xmm0, %xmm0
vpxor	%xmm0, %xmm1, %xmm0
vpsllq	$0x20, %xmm0, %xmm1
vpbroadcastq	.LCPI4_2(%rip), %xmm2
vpclmulqdq	$0x10, %xmm2, %xmm1, %xmm1
vpxor	%xmm1, %xmm0, %xmm0
vpxor	%xmm1, %xmm1, %xmm1
vpblendd	$0x1, %xmm1, %xmm0, %xmm1
movabsq	$0x1f7011640, %rax
vmovq	%rax, %xmm2
vpclmulqdq	$0x0, %xmm2, %xmm1, %xmm2
vpxor	%xmm2, %xmm1, %xmm1
vmovq	%xmm1, %xmm1
vpbroadcastq	.LCPI4_3(%rip), %xmm2
vpclmulqdq	$0x10, %xmm2, %xmm1, %xmm1
vpxor	%xmm1, %xmm0, %xmm0
vpextrd	$0x2, %xmm0, %eax
jmp	L_fb0
L_f4c:
leaq	-0x1(%rdx), %rcx
movzbl	(%rsi), %edi
xorb	%al, %dil
incq	%rsi
movzbl	%dil, %edi
leaq	crc_table(%rip), %r8
shrl	$0x8, %eax
xorl	(%r8,%rdi,4), %eax
cmpq	$0x1, %rdx
je	L_fb0
L_f71:
xorl	%edx, %edx
leaq	crc_table(%rip), %rdi
nopw	(%rax,%rax)
L_f80:
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
jne	L_f80
L_fb0:
notl	%eax
L_fb2:
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
	.section .rodata.cst4
	.p2align 2
.LCPI0_1:
	.byte 135,36,180,157
.LCPI1_5:
	.byte 128,128,128,128
.LCPI2_5:
	.byte 128,128,128,128
.LCPI4_4:
	.byte 135,36,180,157
	.section .rodata.cst8
	.p2align 3
.LCPI1_0:
	.byte 212,43,68,84,1,0,0,0
.LCPI1_2:
	.byte 150,21,228,198,1,0,0,0
.LCPI1_3:
	.byte 48,20,45,50,1,0,0,0
.LCPI1_4:
	.byte 138,119,66,21,1,0,0,0
.LCPI2_1:
	.byte 212,43,68,84,1,0,0,0
.LCPI2_2:
	.byte 150,21,228,198,1,0,0,0
.LCPI2_3:
	.byte 48,20,45,50,1,0,0,0
.LCPI2_4:
	.byte 138,119,66,21,1,0,0,0
.LCPI3_0:
	.byte 208,151,25,117,1,0,0,0
.LCPI3_1:
	.byte 36,97,205,99,1,0,0,0
.LCPI3_2:
	.byte 64,6,113,219,1,0,0,0
.LCPI4_1:
	.byte 208,151,25,117,1,0,0,0
.LCPI4_2:
	.byte 36,97,205,99,1,0,0,0
.LCPI4_3:
	.byte 64,6,113,219,1,0,0,0
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

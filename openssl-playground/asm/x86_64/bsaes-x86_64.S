	.text
_bsaes_encrypt8:
leaq	_bsaes_const+48(%rip), %r11
movdqa	(%rax), %xmm8
leaq	0x10(%rax), %rax
movdqa	0x50(%r11), %xmm7
pxor	%xmm8, %xmm15
pxor	%xmm8, %xmm0
pxor	%xmm8, %xmm1
pxor	%xmm8, %xmm2
pshufb	%xmm7, %xmm15
pshufb	%xmm7, %xmm0
pxor	%xmm8, %xmm3
pxor	%xmm8, %xmm4
pshufb	%xmm7, %xmm1
pshufb	%xmm7, %xmm2
pxor	%xmm8, %xmm5
pxor	%xmm8, %xmm6
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm4
pshufb	%xmm7, %xmm5
pshufb	%xmm7, %xmm6
_bsaes_encrypt8_bitslice:
movdqa	(%r11), %xmm7
movdqa	0x10(%r11), %xmm8
movdqa	%xmm5, %xmm9
psrlq	$0x1, %xmm5
movdqa	%xmm3, %xmm10
psrlq	$0x1, %xmm3
pxor	%xmm6, %xmm5
pxor	%xmm4, %xmm3
pand	%xmm7, %xmm5
pand	%xmm7, %xmm3
pxor	%xmm5, %xmm6
psllq	$0x1, %xmm5
pxor	%xmm3, %xmm4
psllq	$0x1, %xmm3
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm3
movdqa	%xmm1, %xmm9
psrlq	$0x1, %xmm1
movdqa	%xmm15, %xmm10
psrlq	$0x1, %xmm15
pxor	%xmm2, %xmm1
pxor	%xmm0, %xmm15
pand	%xmm7, %xmm1
pand	%xmm7, %xmm15
pxor	%xmm1, %xmm2
psllq	$0x1, %xmm1
pxor	%xmm15, %xmm0
psllq	$0x1, %xmm15
pxor	%xmm9, %xmm1
pxor	%xmm10, %xmm15
movdqa	0x20(%r11), %xmm7
movdqa	%xmm4, %xmm9
psrlq	$0x2, %xmm4
movdqa	%xmm3, %xmm10
psrlq	$0x2, %xmm3
pxor	%xmm6, %xmm4
pxor	%xmm5, %xmm3
pand	%xmm8, %xmm4
pand	%xmm8, %xmm3
pxor	%xmm4, %xmm6
psllq	$0x2, %xmm4
pxor	%xmm3, %xmm5
psllq	$0x2, %xmm3
pxor	%xmm9, %xmm4
pxor	%xmm10, %xmm3
movdqa	%xmm0, %xmm9
psrlq	$0x2, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x2, %xmm15
pxor	%xmm2, %xmm0
pxor	%xmm1, %xmm15
pand	%xmm8, %xmm0
pand	%xmm8, %xmm15
pxor	%xmm0, %xmm2
psllq	$0x2, %xmm0
pxor	%xmm15, %xmm1
psllq	$0x2, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
movdqa	%xmm2, %xmm9
psrlq	$0x4, %xmm2
movdqa	%xmm1, %xmm10
psrlq	$0x4, %xmm1
pxor	%xmm6, %xmm2
pxor	%xmm5, %xmm1
pand	%xmm7, %xmm2
pand	%xmm7, %xmm1
pxor	%xmm2, %xmm6
psllq	$0x4, %xmm2
pxor	%xmm1, %xmm5
psllq	$0x4, %xmm1
pxor	%xmm9, %xmm2
pxor	%xmm10, %xmm1
movdqa	%xmm0, %xmm9
psrlq	$0x4, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x4, %xmm15
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm15
pand	%xmm7, %xmm0
pand	%xmm7, %xmm15
pxor	%xmm0, %xmm4
psllq	$0x4, %xmm0
pxor	%xmm15, %xmm3
psllq	$0x4, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
decl	%r10d
jmp	L_268
nop
L_210:
pxor	(%rax), %xmm15
pxor	0x10(%rax), %xmm0
pxor	0x20(%rax), %xmm1
pxor	0x30(%rax), %xmm2
pshufb	%xmm7, %xmm15
pshufb	%xmm7, %xmm0
pxor	0x40(%rax), %xmm3
pxor	0x50(%rax), %xmm4
pshufb	%xmm7, %xmm1
pshufb	%xmm7, %xmm2
pxor	0x60(%rax), %xmm5
pxor	0x70(%rax), %xmm6
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm4
pshufb	%xmm7, %xmm5
pshufb	%xmm7, %xmm6
leaq	0x80(%rax), %rax
L_268:
pxor	%xmm5, %xmm4
pxor	%xmm0, %xmm1
pxor	%xmm15, %xmm2
pxor	%xmm1, %xmm5
pxor	%xmm15, %xmm4
pxor	%xmm2, %xmm5
pxor	%xmm6, %xmm2
pxor	%xmm4, %xmm6
pxor	%xmm3, %xmm2
pxor	%xmm4, %xmm3
pxor	%xmm0, %xmm2
pxor	%xmm6, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm6, %xmm10
movdqa	%xmm0, %xmm9
movdqa	%xmm4, %xmm8
movdqa	%xmm1, %xmm12
movdqa	%xmm5, %xmm11
pxor	%xmm3, %xmm10
pxor	%xmm1, %xmm9
pxor	%xmm2, %xmm8
movdqa	%xmm10, %xmm13
pxor	%xmm3, %xmm12
movdqa	%xmm9, %xmm7
pxor	%xmm15, %xmm11
movdqa	%xmm10, %xmm14
por	%xmm8, %xmm9
por	%xmm11, %xmm10
pxor	%xmm7, %xmm14
pand	%xmm11, %xmm13
pxor	%xmm8, %xmm11
pand	%xmm8, %xmm7
pand	%xmm11, %xmm14
movdqa	%xmm2, %xmm11
pxor	%xmm15, %xmm11
pand	%xmm11, %xmm12
pxor	%xmm12, %xmm10
pxor	%xmm12, %xmm9
movdqa	%xmm6, %xmm12
movdqa	%xmm4, %xmm11
pxor	%xmm0, %xmm12
pxor	%xmm5, %xmm11
movdqa	%xmm12, %xmm8
pand	%xmm11, %xmm12
por	%xmm11, %xmm8
pxor	%xmm12, %xmm7
pxor	%xmm14, %xmm10
pxor	%xmm13, %xmm9
pxor	%xmm14, %xmm8
movdqa	%xmm1, %xmm11
pxor	%xmm13, %xmm7
movdqa	%xmm3, %xmm12
pxor	%xmm13, %xmm8
movdqa	%xmm0, %xmm13
pand	%xmm2, %xmm11
movdqa	%xmm6, %xmm14
pand	%xmm15, %xmm12
pand	%xmm4, %xmm13
por	%xmm5, %xmm14
pxor	%xmm11, %xmm10
pxor	%xmm12, %xmm9
pxor	%xmm13, %xmm8
pxor	%xmm14, %xmm7
movdqa	%xmm10, %xmm11
pand	%xmm8, %xmm10
pxor	%xmm9, %xmm11
movdqa	%xmm7, %xmm13
movdqa	%xmm11, %xmm14
pxor	%xmm10, %xmm13
pand	%xmm13, %xmm14
movdqa	%xmm8, %xmm12
pxor	%xmm9, %xmm14
pxor	%xmm7, %xmm12
pxor	%xmm9, %xmm10
pand	%xmm10, %xmm12
movdqa	%xmm13, %xmm9
pxor	%xmm7, %xmm12
pxor	%xmm12, %xmm9
pxor	%xmm12, %xmm8
pand	%xmm7, %xmm9
pxor	%xmm9, %xmm13
pxor	%xmm9, %xmm8
pand	%xmm14, %xmm13
pxor	%xmm11, %xmm13
movdqa	%xmm5, %xmm11
movdqa	%xmm4, %xmm7
movdqa	%xmm14, %xmm9
pxor	%xmm13, %xmm9
pand	%xmm5, %xmm9
pxor	%xmm4, %xmm5
pand	%xmm14, %xmm4
pand	%xmm13, %xmm5
pxor	%xmm4, %xmm5
pxor	%xmm9, %xmm4
pxor	%xmm15, %xmm11
pxor	%xmm2, %xmm7
pxor	%xmm12, %xmm14
pxor	%xmm8, %xmm13
movdqa	%xmm14, %xmm10
movdqa	%xmm12, %xmm9
pxor	%xmm13, %xmm10
pxor	%xmm8, %xmm9
pand	%xmm11, %xmm10
pand	%xmm15, %xmm9
pxor	%xmm7, %xmm11
pxor	%xmm2, %xmm15
pand	%xmm14, %xmm7
pand	%xmm12, %xmm2
pand	%xmm13, %xmm11
pand	%xmm8, %xmm15
pxor	%xmm11, %xmm7
pxor	%xmm2, %xmm15
pxor	%xmm10, %xmm11
pxor	%xmm9, %xmm2
pxor	%xmm11, %xmm5
pxor	%xmm11, %xmm15
pxor	%xmm7, %xmm4
pxor	%xmm7, %xmm2
movdqa	%xmm6, %xmm11
movdqa	%xmm0, %xmm7
pxor	%xmm3, %xmm11
pxor	%xmm1, %xmm7
movdqa	%xmm14, %xmm10
movdqa	%xmm12, %xmm9
pxor	%xmm13, %xmm10
pxor	%xmm8, %xmm9
pand	%xmm11, %xmm10
pand	%xmm3, %xmm9
pxor	%xmm7, %xmm11
pxor	%xmm1, %xmm3
pand	%xmm14, %xmm7
pand	%xmm12, %xmm1
pand	%xmm13, %xmm11
pand	%xmm8, %xmm3
pxor	%xmm11, %xmm7
pxor	%xmm1, %xmm3
pxor	%xmm10, %xmm11
pxor	%xmm9, %xmm1
pxor	%xmm12, %xmm14
pxor	%xmm8, %xmm13
movdqa	%xmm14, %xmm10
pxor	%xmm13, %xmm10
pand	%xmm6, %xmm10
pxor	%xmm0, %xmm6
pand	%xmm14, %xmm0
pand	%xmm13, %xmm6
pxor	%xmm0, %xmm6
pxor	%xmm10, %xmm0
pxor	%xmm11, %xmm6
pxor	%xmm11, %xmm3
pxor	%xmm7, %xmm0
pxor	%xmm7, %xmm1
pxor	%xmm15, %xmm6
pxor	%xmm5, %xmm0
pxor	%xmm6, %xmm3
pxor	%xmm15, %xmm5
pxor	%xmm0, %xmm15
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm4
pxor	%xmm2, %xmm1
pxor	%xmm4, %xmm2
pxor	%xmm4, %xmm3
pxor	%xmm2, %xmm5
decl	%r10d
jl	L_680
pshufd	$0x93, %xmm15, %xmm7
pshufd	$0x93, %xmm0, %xmm8
pxor	%xmm7, %xmm15
pshufd	$0x93, %xmm3, %xmm9
pxor	%xmm8, %xmm0
pshufd	$0x93, %xmm5, %xmm10
pxor	%xmm9, %xmm3
pshufd	$0x93, %xmm2, %xmm11
pxor	%xmm10, %xmm5
pshufd	$0x93, %xmm6, %xmm12
pxor	%xmm11, %xmm2
pshufd	$0x93, %xmm1, %xmm13
pxor	%xmm12, %xmm6
pshufd	$0x93, %xmm4, %xmm14
pxor	%xmm13, %xmm1
pxor	%xmm14, %xmm4
pxor	%xmm15, %xmm8
pxor	%xmm4, %xmm7
pxor	%xmm4, %xmm8
pshufd	$0x4e, %xmm15, %xmm15
pxor	%xmm0, %xmm9
pshufd	$0x4e, %xmm0, %xmm0
pxor	%xmm2, %xmm12
pxor	%xmm7, %xmm15
pxor	%xmm6, %xmm13
pxor	%xmm8, %xmm0
pxor	%xmm5, %xmm11
pshufd	$0x4e, %xmm2, %xmm7
pxor	%xmm1, %xmm14
pshufd	$0x4e, %xmm6, %xmm8
pxor	%xmm3, %xmm10
pshufd	$0x4e, %xmm5, %xmm2
pxor	%xmm4, %xmm10
pshufd	$0x4e, %xmm4, %xmm6
pxor	%xmm4, %xmm11
pshufd	$0x4e, %xmm1, %xmm5
pxor	%xmm11, %xmm7
pshufd	$0x4e, %xmm3, %xmm1
pxor	%xmm12, %xmm8
pxor	%xmm10, %xmm2
pxor	%xmm14, %xmm6
pxor	%xmm13, %xmm5
movdqa	%xmm7, %xmm3
pxor	%xmm9, %xmm1
movdqa	%xmm8, %xmm4
movdqa	0x30(%r11), %xmm7
jne	L_210
movdqa	0x40(%r11), %xmm7
jmp	L_210
nop
L_680:
movdqa	(%r11), %xmm7
movdqa	0x10(%r11), %xmm8
movdqa	%xmm1, %xmm9
psrlq	$0x1, %xmm1
movdqa	%xmm2, %xmm10
psrlq	$0x1, %xmm2
pxor	%xmm4, %xmm1
pxor	%xmm6, %xmm2
pand	%xmm7, %xmm1
pand	%xmm7, %xmm2
pxor	%xmm1, %xmm4
psllq	$0x1, %xmm1
pxor	%xmm2, %xmm6
psllq	$0x1, %xmm2
pxor	%xmm9, %xmm1
pxor	%xmm10, %xmm2
movdqa	%xmm3, %xmm9
psrlq	$0x1, %xmm3
movdqa	%xmm15, %xmm10
psrlq	$0x1, %xmm15
pxor	%xmm5, %xmm3
pxor	%xmm0, %xmm15
pand	%xmm7, %xmm3
pand	%xmm7, %xmm15
pxor	%xmm3, %xmm5
psllq	$0x1, %xmm3
pxor	%xmm15, %xmm0
psllq	$0x1, %xmm15
pxor	%xmm9, %xmm3
pxor	%xmm10, %xmm15
movdqa	0x20(%r11), %xmm7
movdqa	%xmm6, %xmm9
psrlq	$0x2, %xmm6
movdqa	%xmm2, %xmm10
psrlq	$0x2, %xmm2
pxor	%xmm4, %xmm6
pxor	%xmm1, %xmm2
pand	%xmm8, %xmm6
pand	%xmm8, %xmm2
pxor	%xmm6, %xmm4
psllq	$0x2, %xmm6
pxor	%xmm2, %xmm1
psllq	$0x2, %xmm2
pxor	%xmm9, %xmm6
pxor	%xmm10, %xmm2
movdqa	%xmm0, %xmm9
psrlq	$0x2, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x2, %xmm15
pxor	%xmm5, %xmm0
pxor	%xmm3, %xmm15
pand	%xmm8, %xmm0
pand	%xmm8, %xmm15
pxor	%xmm0, %xmm5
psllq	$0x2, %xmm0
pxor	%xmm15, %xmm3
psllq	$0x2, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
movdqa	%xmm5, %xmm9
psrlq	$0x4, %xmm5
movdqa	%xmm3, %xmm10
psrlq	$0x4, %xmm3
pxor	%xmm4, %xmm5
pxor	%xmm1, %xmm3
pand	%xmm7, %xmm5
pand	%xmm7, %xmm3
pxor	%xmm5, %xmm4
psllq	$0x4, %xmm5
pxor	%xmm3, %xmm1
psllq	$0x4, %xmm3
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm3
movdqa	%xmm0, %xmm9
psrlq	$0x4, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x4, %xmm15
pxor	%xmm6, %xmm0
pxor	%xmm2, %xmm15
pand	%xmm7, %xmm0
pand	%xmm7, %xmm15
pxor	%xmm0, %xmm6
psllq	$0x4, %xmm0
pxor	%xmm15, %xmm2
psllq	$0x4, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
movdqa	(%rax), %xmm7
pxor	%xmm7, %xmm3
pxor	%xmm7, %xmm5
pxor	%xmm7, %xmm2
pxor	%xmm7, %xmm6
pxor	%xmm7, %xmm1
pxor	%xmm7, %xmm4
pxor	%xmm7, %xmm15
pxor	%xmm7, %xmm0
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
_bsaes_decrypt8:
leaq	_bsaes_const+48(%rip), %r11
movdqa	(%rax), %xmm8
leaq	0x10(%rax), %rax
movdqa	-0x30(%r11), %xmm7
pxor	%xmm8, %xmm15
pxor	%xmm8, %xmm0
pxor	%xmm8, %xmm1
pxor	%xmm8, %xmm2
pshufb	%xmm7, %xmm15
pshufb	%xmm7, %xmm0
pxor	%xmm8, %xmm3
pxor	%xmm8, %xmm4
pshufb	%xmm7, %xmm1
pshufb	%xmm7, %xmm2
pxor	%xmm8, %xmm5
pxor	%xmm8, %xmm6
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm4
pshufb	%xmm7, %xmm5
pshufb	%xmm7, %xmm6
movdqa	(%r11), %xmm7
movdqa	0x10(%r11), %xmm8
movdqa	%xmm5, %xmm9
psrlq	$0x1, %xmm5
movdqa	%xmm3, %xmm10
psrlq	$0x1, %xmm3
pxor	%xmm6, %xmm5
pxor	%xmm4, %xmm3
pand	%xmm7, %xmm5
pand	%xmm7, %xmm3
pxor	%xmm5, %xmm6
psllq	$0x1, %xmm5
pxor	%xmm3, %xmm4
psllq	$0x1, %xmm3
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm3
movdqa	%xmm1, %xmm9
psrlq	$0x1, %xmm1
movdqa	%xmm15, %xmm10
psrlq	$0x1, %xmm15
pxor	%xmm2, %xmm1
pxor	%xmm0, %xmm15
pand	%xmm7, %xmm1
pand	%xmm7, %xmm15
pxor	%xmm1, %xmm2
psllq	$0x1, %xmm1
pxor	%xmm15, %xmm0
psllq	$0x1, %xmm15
pxor	%xmm9, %xmm1
pxor	%xmm10, %xmm15
movdqa	0x20(%r11), %xmm7
movdqa	%xmm4, %xmm9
psrlq	$0x2, %xmm4
movdqa	%xmm3, %xmm10
psrlq	$0x2, %xmm3
pxor	%xmm6, %xmm4
pxor	%xmm5, %xmm3
pand	%xmm8, %xmm4
pand	%xmm8, %xmm3
pxor	%xmm4, %xmm6
psllq	$0x2, %xmm4
pxor	%xmm3, %xmm5
psllq	$0x2, %xmm3
pxor	%xmm9, %xmm4
pxor	%xmm10, %xmm3
movdqa	%xmm0, %xmm9
psrlq	$0x2, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x2, %xmm15
pxor	%xmm2, %xmm0
pxor	%xmm1, %xmm15
pand	%xmm8, %xmm0
pand	%xmm8, %xmm15
pxor	%xmm0, %xmm2
psllq	$0x2, %xmm0
pxor	%xmm15, %xmm1
psllq	$0x2, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
movdqa	%xmm2, %xmm9
psrlq	$0x4, %xmm2
movdqa	%xmm1, %xmm10
psrlq	$0x4, %xmm1
pxor	%xmm6, %xmm2
pxor	%xmm5, %xmm1
pand	%xmm7, %xmm2
pand	%xmm7, %xmm1
pxor	%xmm2, %xmm6
psllq	$0x4, %xmm2
pxor	%xmm1, %xmm5
psllq	$0x4, %xmm1
pxor	%xmm9, %xmm2
pxor	%xmm10, %xmm1
movdqa	%xmm0, %xmm9
psrlq	$0x4, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x4, %xmm15
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm15
pand	%xmm7, %xmm0
pand	%xmm7, %xmm15
pxor	%xmm0, %xmm4
psllq	$0x4, %xmm0
pxor	%xmm15, %xmm3
psllq	$0x4, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
decl	%r10d
jmp	L_ae8
nop
L_a90:
pxor	(%rax), %xmm15
pxor	0x10(%rax), %xmm0
pxor	0x20(%rax), %xmm1
pxor	0x30(%rax), %xmm2
pshufb	%xmm7, %xmm15
pshufb	%xmm7, %xmm0
pxor	0x40(%rax), %xmm3
pxor	0x50(%rax), %xmm4
pshufb	%xmm7, %xmm1
pshufb	%xmm7, %xmm2
pxor	0x60(%rax), %xmm5
pxor	0x70(%rax), %xmm6
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm4
pshufb	%xmm7, %xmm5
pshufb	%xmm7, %xmm6
leaq	0x80(%rax), %rax
L_ae8:
pxor	%xmm3, %xmm2
pxor	%xmm6, %xmm3
pxor	%xmm6, %xmm1
pxor	%xmm3, %xmm5
pxor	%xmm5, %xmm6
pxor	%xmm6, %xmm0
pxor	%xmm0, %xmm15
pxor	%xmm4, %xmm1
pxor	%xmm15, %xmm2
pxor	%xmm15, %xmm4
pxor	%xmm2, %xmm0
movdqa	%xmm2, %xmm10
movdqa	%xmm6, %xmm9
movdqa	%xmm0, %xmm8
movdqa	%xmm3, %xmm12
movdqa	%xmm4, %xmm11
pxor	%xmm15, %xmm10
pxor	%xmm3, %xmm9
pxor	%xmm5, %xmm8
movdqa	%xmm10, %xmm13
pxor	%xmm15, %xmm12
movdqa	%xmm9, %xmm7
pxor	%xmm1, %xmm11
movdqa	%xmm10, %xmm14
por	%xmm8, %xmm9
por	%xmm11, %xmm10
pxor	%xmm7, %xmm14
pand	%xmm11, %xmm13
pxor	%xmm8, %xmm11
pand	%xmm8, %xmm7
pand	%xmm11, %xmm14
movdqa	%xmm5, %xmm11
pxor	%xmm1, %xmm11
pand	%xmm11, %xmm12
pxor	%xmm12, %xmm10
pxor	%xmm12, %xmm9
movdqa	%xmm2, %xmm12
movdqa	%xmm0, %xmm11
pxor	%xmm6, %xmm12
pxor	%xmm4, %xmm11
movdqa	%xmm12, %xmm8
pand	%xmm11, %xmm12
por	%xmm11, %xmm8
pxor	%xmm12, %xmm7
pxor	%xmm14, %xmm10
pxor	%xmm13, %xmm9
pxor	%xmm14, %xmm8
movdqa	%xmm3, %xmm11
pxor	%xmm13, %xmm7
movdqa	%xmm15, %xmm12
pxor	%xmm13, %xmm8
movdqa	%xmm6, %xmm13
pand	%xmm5, %xmm11
movdqa	%xmm2, %xmm14
pand	%xmm1, %xmm12
pand	%xmm0, %xmm13
por	%xmm4, %xmm14
pxor	%xmm11, %xmm10
pxor	%xmm12, %xmm9
pxor	%xmm13, %xmm8
pxor	%xmm14, %xmm7
movdqa	%xmm10, %xmm11
pand	%xmm8, %xmm10
pxor	%xmm9, %xmm11
movdqa	%xmm7, %xmm13
movdqa	%xmm11, %xmm14
pxor	%xmm10, %xmm13
pand	%xmm13, %xmm14
movdqa	%xmm8, %xmm12
pxor	%xmm9, %xmm14
pxor	%xmm7, %xmm12
pxor	%xmm9, %xmm10
pand	%xmm10, %xmm12
movdqa	%xmm13, %xmm9
pxor	%xmm7, %xmm12
pxor	%xmm12, %xmm9
pxor	%xmm12, %xmm8
pand	%xmm7, %xmm9
pxor	%xmm9, %xmm13
pxor	%xmm9, %xmm8
pand	%xmm14, %xmm13
pxor	%xmm11, %xmm13
movdqa	%xmm4, %xmm11
movdqa	%xmm0, %xmm7
movdqa	%xmm14, %xmm9
pxor	%xmm13, %xmm9
pand	%xmm4, %xmm9
pxor	%xmm0, %xmm4
pand	%xmm14, %xmm0
pand	%xmm13, %xmm4
pxor	%xmm0, %xmm4
pxor	%xmm9, %xmm0
pxor	%xmm1, %xmm11
pxor	%xmm5, %xmm7
pxor	%xmm12, %xmm14
pxor	%xmm8, %xmm13
movdqa	%xmm14, %xmm10
movdqa	%xmm12, %xmm9
pxor	%xmm13, %xmm10
pxor	%xmm8, %xmm9
pand	%xmm11, %xmm10
pand	%xmm1, %xmm9
pxor	%xmm7, %xmm11
pxor	%xmm5, %xmm1
pand	%xmm14, %xmm7
pand	%xmm12, %xmm5
pand	%xmm13, %xmm11
pand	%xmm8, %xmm1
pxor	%xmm11, %xmm7
pxor	%xmm5, %xmm1
pxor	%xmm10, %xmm11
pxor	%xmm9, %xmm5
pxor	%xmm11, %xmm4
pxor	%xmm11, %xmm1
pxor	%xmm7, %xmm0
pxor	%xmm7, %xmm5
movdqa	%xmm2, %xmm11
movdqa	%xmm6, %xmm7
pxor	%xmm15, %xmm11
pxor	%xmm3, %xmm7
movdqa	%xmm14, %xmm10
movdqa	%xmm12, %xmm9
pxor	%xmm13, %xmm10
pxor	%xmm8, %xmm9
pand	%xmm11, %xmm10
pand	%xmm15, %xmm9
pxor	%xmm7, %xmm11
pxor	%xmm3, %xmm15
pand	%xmm14, %xmm7
pand	%xmm12, %xmm3
pand	%xmm13, %xmm11
pand	%xmm8, %xmm15
pxor	%xmm11, %xmm7
pxor	%xmm3, %xmm15
pxor	%xmm10, %xmm11
pxor	%xmm9, %xmm3
pxor	%xmm12, %xmm14
pxor	%xmm8, %xmm13
movdqa	%xmm14, %xmm10
pxor	%xmm13, %xmm10
pand	%xmm2, %xmm10
pxor	%xmm6, %xmm2
pand	%xmm14, %xmm6
pand	%xmm13, %xmm2
pxor	%xmm6, %xmm2
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm2
pxor	%xmm11, %xmm15
pxor	%xmm7, %xmm6
pxor	%xmm7, %xmm3
pxor	%xmm6, %xmm0
pxor	%xmm4, %xmm5
pxor	%xmm0, %xmm3
pxor	%xmm6, %xmm1
pxor	%xmm6, %xmm4
pxor	%xmm1, %xmm3
pxor	%xmm15, %xmm6
pxor	%xmm4, %xmm3
pxor	%xmm5, %xmm2
pxor	%xmm0, %xmm5
pxor	%xmm3, %xmm2
pxor	%xmm15, %xmm3
pxor	%xmm2, %xmm6
decl	%r10d
jl	L_fb0
pshufd	$0x4e, %xmm15, %xmm7
pshufd	$0x4e, %xmm2, %xmm13
pxor	%xmm15, %xmm7
pshufd	$0x4e, %xmm4, %xmm14
pxor	%xmm2, %xmm13
pshufd	$0x4e, %xmm0, %xmm8
pxor	%xmm4, %xmm14
pshufd	$0x4e, %xmm5, %xmm9
pxor	%xmm0, %xmm8
pshufd	$0x4e, %xmm3, %xmm10
pxor	%xmm5, %xmm9
pxor	%xmm13, %xmm15
pxor	%xmm13, %xmm0
pshufd	$0x4e, %xmm1, %xmm11
pxor	%xmm3, %xmm10
pxor	%xmm7, %xmm5
pxor	%xmm8, %xmm3
pshufd	$0x4e, %xmm6, %xmm12
pxor	%xmm1, %xmm11
pxor	%xmm14, %xmm0
pxor	%xmm9, %xmm1
pxor	%xmm6, %xmm12
pxor	%xmm14, %xmm5
pxor	%xmm13, %xmm3
pxor	%xmm13, %xmm1
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm2
pxor	%xmm14, %xmm1
pxor	%xmm14, %xmm6
pxor	%xmm12, %xmm4
pshufd	$0x93, %xmm15, %xmm7
pshufd	$0x93, %xmm0, %xmm8
pxor	%xmm7, %xmm15
pshufd	$0x93, %xmm5, %xmm9
pxor	%xmm8, %xmm0
pshufd	$0x93, %xmm3, %xmm10
pxor	%xmm9, %xmm5
pshufd	$0x93, %xmm1, %xmm11
pxor	%xmm10, %xmm3
pshufd	$0x93, %xmm6, %xmm12
pxor	%xmm11, %xmm1
pshufd	$0x93, %xmm2, %xmm13
pxor	%xmm12, %xmm6
pshufd	$0x93, %xmm4, %xmm14
pxor	%xmm13, %xmm2
pxor	%xmm14, %xmm4
pxor	%xmm15, %xmm8
pxor	%xmm4, %xmm7
pxor	%xmm4, %xmm8
pshufd	$0x4e, %xmm15, %xmm15
pxor	%xmm0, %xmm9
pshufd	$0x4e, %xmm0, %xmm0
pxor	%xmm1, %xmm12
pxor	%xmm7, %xmm15
pxor	%xmm6, %xmm13
pxor	%xmm8, %xmm0
pxor	%xmm3, %xmm11
pshufd	$0x4e, %xmm1, %xmm7
pxor	%xmm2, %xmm14
pshufd	$0x4e, %xmm6, %xmm8
pxor	%xmm5, %xmm10
pshufd	$0x4e, %xmm3, %xmm1
pxor	%xmm4, %xmm10
pshufd	$0x4e, %xmm4, %xmm6
pxor	%xmm4, %xmm11
pshufd	$0x4e, %xmm2, %xmm3
pxor	%xmm11, %xmm7
pshufd	$0x4e, %xmm5, %xmm2
pxor	%xmm12, %xmm8
pxor	%xmm1, %xmm10
pxor	%xmm14, %xmm6
pxor	%xmm3, %xmm13
movdqa	%xmm7, %xmm3
pxor	%xmm9, %xmm2
movdqa	%xmm13, %xmm5
movdqa	%xmm8, %xmm4
movdqa	%xmm2, %xmm1
movdqa	%xmm10, %xmm2
movdqa	-0x10(%r11), %xmm7
jne	L_a90
movdqa	-0x20(%r11), %xmm7
jmp	L_a90
nopw	(%rax,%rax)
L_fb0:
movdqa	(%r11), %xmm7
movdqa	0x10(%r11), %xmm8
movdqa	%xmm2, %xmm9
psrlq	$0x1, %xmm2
movdqa	%xmm1, %xmm10
psrlq	$0x1, %xmm1
pxor	%xmm4, %xmm2
pxor	%xmm6, %xmm1
pand	%xmm7, %xmm2
pand	%xmm7, %xmm1
pxor	%xmm2, %xmm4
psllq	$0x1, %xmm2
pxor	%xmm1, %xmm6
psllq	$0x1, %xmm1
pxor	%xmm9, %xmm2
pxor	%xmm10, %xmm1
movdqa	%xmm5, %xmm9
psrlq	$0x1, %xmm5
movdqa	%xmm15, %xmm10
psrlq	$0x1, %xmm15
pxor	%xmm3, %xmm5
pxor	%xmm0, %xmm15
pand	%xmm7, %xmm5
pand	%xmm7, %xmm15
pxor	%xmm5, %xmm3
psllq	$0x1, %xmm5
pxor	%xmm15, %xmm0
psllq	$0x1, %xmm15
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm15
movdqa	0x20(%r11), %xmm7
movdqa	%xmm6, %xmm9
psrlq	$0x2, %xmm6
movdqa	%xmm1, %xmm10
psrlq	$0x2, %xmm1
pxor	%xmm4, %xmm6
pxor	%xmm2, %xmm1
pand	%xmm8, %xmm6
pand	%xmm8, %xmm1
pxor	%xmm6, %xmm4
psllq	$0x2, %xmm6
pxor	%xmm1, %xmm2
psllq	$0x2, %xmm1
pxor	%xmm9, %xmm6
pxor	%xmm10, %xmm1
movdqa	%xmm0, %xmm9
psrlq	$0x2, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x2, %xmm15
pxor	%xmm3, %xmm0
pxor	%xmm5, %xmm15
pand	%xmm8, %xmm0
pand	%xmm8, %xmm15
pxor	%xmm0, %xmm3
psllq	$0x2, %xmm0
pxor	%xmm15, %xmm5
psllq	$0x2, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
movdqa	%xmm3, %xmm9
psrlq	$0x4, %xmm3
movdqa	%xmm5, %xmm10
psrlq	$0x4, %xmm5
pxor	%xmm4, %xmm3
pxor	%xmm2, %xmm5
pand	%xmm7, %xmm3
pand	%xmm7, %xmm5
pxor	%xmm3, %xmm4
psllq	$0x4, %xmm3
pxor	%xmm5, %xmm2
psllq	$0x4, %xmm5
pxor	%xmm9, %xmm3
pxor	%xmm10, %xmm5
movdqa	%xmm0, %xmm9
psrlq	$0x4, %xmm0
movdqa	%xmm15, %xmm10
psrlq	$0x4, %xmm15
pxor	%xmm6, %xmm0
pxor	%xmm1, %xmm15
pand	%xmm7, %xmm0
pand	%xmm7, %xmm15
pxor	%xmm0, %xmm6
psllq	$0x4, %xmm0
pxor	%xmm15, %xmm1
psllq	$0x4, %xmm15
pxor	%xmm9, %xmm0
pxor	%xmm10, %xmm15
movdqa	(%rax), %xmm7
pxor	%xmm7, %xmm5
pxor	%xmm7, %xmm3
pxor	%xmm7, %xmm1
pxor	%xmm7, %xmm6
pxor	%xmm7, %xmm2
pxor	%xmm7, %xmm4
pxor	%xmm7, %xmm15
pxor	%xmm7, %xmm0
rep	retq
nopw	(%rax,%rax)
_bsaes_key_convert:
leaq	_bsaes_const+320(%rip), %r11
movdqu	(%rcx), %xmm7
leaq	0x10(%rcx), %rcx
movdqa	(%r11), %xmm0
movdqa	0x10(%r11), %xmm1
movdqa	0x20(%r11), %xmm2
movdqa	0x30(%r11), %xmm3
movdqa	0x40(%r11), %xmm4
pcmpeqd	%xmm5, %xmm5
movdqu	(%rcx), %xmm6
movdqa	%xmm7, (%rax)
leaq	0x10(%rax), %rax
decl	%r10d
jmp	L_11d0
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_11d0:
pshufb	%xmm4, %xmm6
movdqa	%xmm0, %xmm8
movdqa	%xmm1, %xmm9
pand	%xmm6, %xmm8
pand	%xmm6, %xmm9
movdqa	%xmm2, %xmm10
pcmpeqb	%xmm0, %xmm8
psllq	$0x4, %xmm0
movdqa	%xmm3, %xmm11
pcmpeqb	%xmm1, %xmm9
psllq	$0x4, %xmm1
pand	%xmm6, %xmm10
pand	%xmm6, %xmm11
movdqa	%xmm0, %xmm12
pcmpeqb	%xmm2, %xmm10
psllq	$0x4, %xmm2
movdqa	%xmm1, %xmm13
pcmpeqb	%xmm3, %xmm11
psllq	$0x4, %xmm3
movdqa	%xmm2, %xmm14
movdqa	%xmm3, %xmm15
pxor	%xmm5, %xmm8
pxor	%xmm5, %xmm9
pand	%xmm6, %xmm12
pand	%xmm6, %xmm13
movdqa	%xmm8, (%rax)
pcmpeqb	%xmm0, %xmm12
psrlq	$0x4, %xmm0
movdqa	%xmm9, 0x10(%rax)
pcmpeqb	%xmm1, %xmm13
psrlq	$0x4, %xmm1
leaq	0x10(%rcx), %rcx
pand	%xmm6, %xmm14
pand	%xmm6, %xmm15
movdqa	%xmm10, 0x20(%rax)
pcmpeqb	%xmm2, %xmm14
psrlq	$0x4, %xmm2
movdqa	%xmm11, 0x30(%rax)
pcmpeqb	%xmm3, %xmm15
psrlq	$0x4, %xmm3
movdqu	(%rcx), %xmm6
pxor	%xmm5, %xmm13
pxor	%xmm5, %xmm14
movdqa	%xmm12, 0x40(%rax)
movdqa	%xmm13, 0x50(%rax)
movdqa	%xmm14, 0x60(%rax)
movdqa	%xmm15, 0x70(%rax)
leaq	0x80(%rax), %rax
decl	%r10d
jne	L_11d0
movdqa	0x50(%r11), %xmm7
rep	retq
nopl	(%rax,%rax)
ossl_bsaes_cbc_encrypt:
endbr64
cmpl	$0x0, %r9d
jne	asm_AES_cbc_encrypt
cmpq	$0x80, %rdx
jb	asm_AES_cbc_encrypt
movq	%rsp, %rax
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x48(%rsp), %rsp
movq	%rsp, %rbp
movl	0xf0(%rcx), %eax
movq	%rdi, %r12
movq	%rsi, %r13
movq	%rdx, %r14
movq	%rcx, %r15
movq	%r8, %rbx
shrq	$0x4, %r14
movl	%eax, %edx
shlq	$0x7, %rax
subq	$0x60, %rax
subq	%rax, %rsp
movq	%rsp, %rax
movq	%r15, %rcx
movl	%edx, %r10d
callq	_bsaes_key_convert
pxor	(%rsp), %xmm7
movdqa	%xmm6, (%rax)
movdqa	%xmm7, (%rsp)
movdqu	(%rbx), %xmm14
subq	$0x8, %r14
L_135b:
movdqu	(%r12), %xmm15
movdqu	0x10(%r12), %xmm0
movdqu	0x20(%r12), %xmm1
movdqu	0x30(%r12), %xmm2
movdqu	0x40(%r12), %xmm3
movdqu	0x50(%r12), %xmm4
movq	%rsp, %rax
movdqu	0x60(%r12), %xmm5
movl	%edx, %r10d
movdqu	0x70(%r12), %xmm6
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm0
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm5
movdqu	0x30(%r12), %xmm10
pxor	%xmm9, %xmm3
movdqu	0x40(%r12), %xmm11
pxor	%xmm10, %xmm1
movdqu	0x50(%r12), %xmm12
pxor	%xmm11, %xmm6
movdqu	0x60(%r12), %xmm13
pxor	%xmm12, %xmm2
movdqu	0x70(%r12), %xmm14
pxor	%xmm13, %xmm4
movdqu	%xmm15, (%r13)
leaq	0x80(%r12), %r12
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
movdqu	%xmm3, 0x30(%r13)
movdqu	%xmm1, 0x40(%r13)
movdqu	%xmm6, 0x50(%r13)
movdqu	%xmm2, 0x60(%r13)
movdqu	%xmm4, 0x70(%r13)
leaq	0x80(%r13), %r13
subq	$0x8, %r14
jae	L_135b
addq	$0x8, %r14
je	L_1741
movdqu	(%r12), %xmm15
movq	%rsp, %rax
movl	%edx, %r10d
cmpq	$0x2, %r14
jb	L_1720
movdqu	0x10(%r12), %xmm0
je	L_16f0
movdqu	0x20(%r12), %xmm1
cmpq	$0x4, %r14
jb	L_16a0
movdqu	0x30(%r12), %xmm2
je	L_1640
movdqu	0x40(%r12), %xmm3
cmpq	$0x6, %r14
jb	L_15d0
movdqu	0x50(%r12), %xmm4
je	L_1550
movdqu	0x60(%r12), %xmm5
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm0
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm5
movdqu	0x30(%r12), %xmm10
pxor	%xmm9, %xmm3
movdqu	0x40(%r12), %xmm11
pxor	%xmm10, %xmm1
movdqu	0x50(%r12), %xmm12
pxor	%xmm11, %xmm6
movdqu	0x60(%r12), %xmm14
pxor	%xmm12, %xmm2
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
movdqu	%xmm3, 0x30(%r13)
movdqu	%xmm1, 0x40(%r13)
movdqu	%xmm6, 0x50(%r13)
movdqu	%xmm2, 0x60(%r13)
jmp	L_1741
nopl	(%rax,%rax)
L_1550:
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm0
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm5
movdqu	0x30(%r12), %xmm10
pxor	%xmm9, %xmm3
movdqu	0x40(%r12), %xmm11
pxor	%xmm10, %xmm1
movdqu	0x50(%r12), %xmm14
pxor	%xmm11, %xmm6
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
movdqu	%xmm3, 0x30(%r13)
movdqu	%xmm1, 0x40(%r13)
movdqu	%xmm6, 0x50(%r13)
jmp	L_1741
nopl	(%rax,%rax)
L_15d0:
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm0
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm5
movdqu	0x30(%r12), %xmm10
pxor	%xmm9, %xmm3
movdqu	0x40(%r12), %xmm14
pxor	%xmm10, %xmm1
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
movdqu	%xmm3, 0x30(%r13)
movdqu	%xmm1, 0x40(%r13)
jmp	L_1741
nopl	(%rax)
L_1640:
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm0
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm5
movdqu	0x30(%r12), %xmm14
pxor	%xmm9, %xmm3
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
movdqu	%xmm3, 0x30(%r13)
jmp	L_1741
nopw	(%rax,%rax)
L_16a0:
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm0
movdqu	0x20(%r12), %xmm14
pxor	%xmm8, %xmm5
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
jmp	L_1741
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_16f0:
movdqa	%xmm14, 0x20(%rbp)
callq	_bsaes_decrypt8
pxor	0x20(%rbp), %xmm15
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm14
pxor	%xmm7, %xmm0
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
jmp	L_1741
L_1720:
leaq	(%r12), %rdi
leaq	0x20(%rbp), %rsi
leaq	(%r15), %rdx
callq	asm_AES_decrypt
pxor	0x20(%rbp), %xmm14
movdqu	%xmm14, (%r13)
movdqa	%xmm15, %xmm14
L_1741:
movdqu	%xmm14, (%rbx)
leaq	(%rsp), %rax
pxor	%xmm0, %xmm0
L_174e:
movdqa	%xmm0, (%rax)
movdqa	%xmm0, 0x10(%rax)
leaq	0x20(%rax), %rax
cmpq	%rax, %rbp
ja	L_174e
leaq	0x78(%rbp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbx
movq	-0x8(%rax), %rbp
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
ossl_bsaes_ctr32_encrypt_blocks:
endbr64
movq	%rsp, %rax
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x48(%rsp), %rsp
movq	%rsp, %rbp
movdqu	(%r8), %xmm0
movl	0xf0(%rcx), %eax
movq	%rdi, %r12
movq	%rsi, %r13
movq	%rdx, %r14
movq	%rcx, %r15
movdqa	%xmm0, 0x20(%rbp)
cmpq	$0x8, %rdx
jb	L_1a60
movl	%eax, %ebx
shlq	$0x7, %rax
subq	$0x60, %rax
subq	%rax, %rsp
movq	%rsp, %rax
movq	%r15, %rcx
movl	%ebx, %r10d
callq	_bsaes_key_convert
pxor	%xmm6, %xmm7
movdqa	%xmm7, (%rax)
movdqa	(%rsp), %xmm8
leaq	_bsaes_const+176(%rip), %r11
movdqa	0x20(%rbp), %xmm15
movdqa	-0x20(%r11), %xmm7
pshufb	%xmm7, %xmm8
pshufb	%xmm7, %xmm15
movdqa	%xmm8, (%rsp)
jmp	L_1820
nop
L_1820:
movdqa	%xmm15, 0x20(%rbp)
movdqa	%xmm15, %xmm0
movdqa	%xmm15, %xmm1
paddd	(%r11), %xmm0
movdqa	%xmm15, %xmm2
paddd	0x10(%r11), %xmm1
movdqa	%xmm15, %xmm3
paddd	0x20(%r11), %xmm2
movdqa	%xmm15, %xmm4
paddd	0x30(%r11), %xmm3
movdqa	%xmm15, %xmm5
paddd	0x40(%r11), %xmm4
movdqa	%xmm15, %xmm6
paddd	0x50(%r11), %xmm5
paddd	0x60(%r11), %xmm6
movdqa	(%rsp), %xmm8
leaq	0x10(%rsp), %rax
movdqa	-0x10(%r11), %xmm7
pxor	%xmm8, %xmm15
pxor	%xmm8, %xmm0
pxor	%xmm8, %xmm1
pxor	%xmm8, %xmm2
pshufb	%xmm7, %xmm15
pshufb	%xmm7, %xmm0
pxor	%xmm8, %xmm3
pxor	%xmm8, %xmm4
pshufb	%xmm7, %xmm1
pshufb	%xmm7, %xmm2
pxor	%xmm8, %xmm5
pxor	%xmm8, %xmm6
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm4
pshufb	%xmm7, %xmm5
pshufb	%xmm7, %xmm6
leaq	_bsaes_const+48(%rip), %r11
movl	%ebx, %r10d
callq	_bsaes_encrypt8_bitslice
subq	$0x8, %r14
jb	L_19b0
movdqu	(%r12), %xmm7
movdqu	0x10(%r12), %xmm8
movdqu	0x20(%r12), %xmm9
movdqu	0x30(%r12), %xmm10
movdqu	0x40(%r12), %xmm11
movdqu	0x50(%r12), %xmm12
movdqu	0x60(%r12), %xmm13
movdqu	0x70(%r12), %xmm14
leaq	0x80(%r12), %r12
pxor	%xmm15, %xmm7
movdqa	0x20(%rbp), %xmm15
pxor	%xmm8, %xmm0
movdqu	%xmm7, (%r13)
pxor	%xmm9, %xmm3
movdqu	%xmm0, 0x10(%r13)
pxor	%xmm10, %xmm5
movdqu	%xmm3, 0x20(%r13)
pxor	%xmm11, %xmm2
movdqu	%xmm5, 0x30(%r13)
pxor	%xmm12, %xmm6
movdqu	%xmm2, 0x40(%r13)
pxor	%xmm13, %xmm1
movdqu	%xmm6, 0x50(%r13)
pxor	%xmm14, %xmm4
movdqu	%xmm1, 0x60(%r13)
leaq	_bsaes_const+176(%rip), %r11
movdqu	%xmm4, 0x70(%r13)
leaq	0x80(%r13), %r13
paddd	0x70(%r11), %xmm15
jne	L_1820
jmp	L_1a9c
nopl	(%rax)
L_19b0:
addq	$0x8, %r14
movdqu	(%r12), %xmm7
pxor	%xmm7, %xmm15
movdqu	%xmm15, (%r13)
cmpq	$0x2, %r14
jb	L_1a9c
movdqu	0x10(%r12), %xmm8
pxor	%xmm8, %xmm0
movdqu	%xmm0, 0x10(%r13)
je	L_1a9c
movdqu	0x20(%r12), %xmm9
pxor	%xmm9, %xmm3
movdqu	%xmm3, 0x20(%r13)
cmpq	$0x4, %r14
jb	L_1a9c
movdqu	0x30(%r12), %xmm10
pxor	%xmm10, %xmm5
movdqu	%xmm5, 0x30(%r13)
je	L_1a9c
movdqu	0x40(%r12), %xmm11
pxor	%xmm11, %xmm2
movdqu	%xmm2, 0x40(%r13)
cmpq	$0x6, %r14
jb	L_1a9c
movdqu	0x50(%r12), %xmm12
pxor	%xmm12, %xmm6
movdqu	%xmm6, 0x50(%r13)
je	L_1a9c
movdqu	0x60(%r12), %xmm13
pxor	%xmm13, %xmm1
movdqu	%xmm1, 0x60(%r13)
jmp	L_1a9c
nopl	(%rax,%rax)
L_1a60:
leaq	0x20(%rbp), %rdi
leaq	0x30(%rbp), %rsi
leaq	(%r15), %rdx
callq	asm_AES_encrypt
movdqu	(%r12), %xmm0
leaq	0x10(%r12), %r12
movl	0x2c(%rbp), %eax
bswapl	%eax
pxor	0x30(%rbp), %xmm0
incl	%eax
movdqu	%xmm0, (%r13)
bswapl	%eax
leaq	0x10(%r13), %r13
movl	%eax, 0x2c(%rsp)
decq	%r14
jne	L_1a60
L_1a9c:
leaq	(%rsp), %rax
pxor	%xmm0, %xmm0
L_1aa4:
movdqa	%xmm0, (%rax)
movdqa	%xmm0, 0x10(%rax)
leaq	0x20(%rax), %rax
cmpq	%rax, %rbp
ja	L_1aa4
leaq	0x78(%rbp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbx
movq	-0x8(%rax), %rbp
leaq	(%rax), %rsp
rep	retq
nopw	(%rax,%rax)
ossl_bsaes_xts_encrypt:
endbr64
movq	%rsp, %rax
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x48(%rsp), %rsp
movq	%rsp, %rbp
movq	%rdi, %r12
movq	%rsi, %r13
movq	%rdx, %r14
movq	%rcx, %r15
leaq	(%r9), %rdi
leaq	0x20(%rbp), %rsi
leaq	(%r8), %rdx
callq	asm_AES_encrypt
movl	0xf0(%r15), %eax
movq	%r14, %rbx
movl	%eax, %edx
shlq	$0x7, %rax
subq	$0x60, %rax
subq	%rax, %rsp
movq	%rsp, %rax
movq	%r15, %rcx
movl	%edx, %r10d
callq	_bsaes_key_convert
pxor	%xmm6, %xmm7
movdqa	%xmm7, (%rax)
andq	$-0x10, %r14
subq	$0x80, %rsp
movdqa	0x20(%rbp), %xmm6
pxor	%xmm14, %xmm14
movdqa	_bsaes_const+304(%rip), %xmm12
pcmpgtd	%xmm6, %xmm14
subq	$0x80, %r14
jb	L_1dc0
jmp	L_1b80
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1b80:
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm15
movdqa	%xmm6, (%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm0
movdqa	%xmm6, 0x10(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	(%r12), %xmm7
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm1
movdqa	%xmm6, 0x20(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm15
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm2
movdqa	%xmm6, 0x30(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm0
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm3
movdqa	%xmm6, 0x40(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x30(%r12), %xmm10
pxor	%xmm9, %xmm1
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm4
movdqa	%xmm6, 0x50(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x40(%r12), %xmm11
pxor	%xmm10, %xmm2
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm5
movdqa	%xmm6, 0x60(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x50(%r12), %xmm12
pxor	%xmm11, %xmm3
movdqu	0x60(%r12), %xmm13
pxor	%xmm12, %xmm4
movdqu	0x70(%r12), %xmm14
leaq	0x80(%r12), %r12
movdqa	%xmm6, 0x70(%rsp)
pxor	%xmm13, %xmm5
leaq	0x80(%rsp), %rax
pxor	%xmm14, %xmm6
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm3
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm5
movdqu	%xmm3, 0x20(%r13)
pxor	0x40(%rsp), %xmm2
movdqu	%xmm5, 0x30(%r13)
pxor	0x50(%rsp), %xmm6
movdqu	%xmm2, 0x40(%r13)
pxor	0x60(%rsp), %xmm1
movdqu	%xmm6, 0x50(%r13)
pxor	0x70(%rsp), %xmm4
movdqu	%xmm1, 0x60(%r13)
movdqu	%xmm4, 0x70(%r13)
leaq	0x80(%r13), %r13
movdqa	0x70(%rsp), %xmm6
pxor	%xmm14, %xmm14
movdqa	_bsaes_const+304(%rip), %xmm12
pcmpgtd	%xmm6, %xmm14
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
subq	$0x80, %r14
jae	L_1b80
L_1dc0:
addq	$0x80, %r14
je	L_2235
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm15
movdqa	%xmm6, (%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm0
movdqa	%xmm6, 0x10(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	(%r12), %xmm7
cmpq	$0x10, %r14
je	L_2200
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm1
movdqa	%xmm6, 0x20(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x10(%r12), %xmm8
cmpq	$0x20, %r14
je	L_21b0
pxor	%xmm7, %xmm15
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm2
movdqa	%xmm6, 0x30(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x20(%r12), %xmm9
cmpq	$0x30, %r14
je	L_2150
pxor	%xmm8, %xmm0
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm3
movdqa	%xmm6, 0x40(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x30(%r12), %xmm10
cmpq	$0x40, %r14
je	L_20f0
pxor	%xmm9, %xmm1
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm4
movdqa	%xmm6, 0x50(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x40(%r12), %xmm11
cmpq	$0x50, %r14
je	L_2080
pxor	%xmm10, %xmm2
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm5
movdqa	%xmm6, 0x60(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x50(%r12), %xmm12
cmpq	$0x60, %r14
je	L_2000
pxor	%xmm11, %xmm3
movdqu	0x60(%r12), %xmm13
pxor	%xmm12, %xmm4
movdqa	%xmm6, 0x70(%rsp)
leaq	0x70(%r12), %r12
pxor	%xmm13, %xmm5
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm3
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm5
movdqu	%xmm3, 0x20(%r13)
pxor	0x40(%rsp), %xmm2
movdqu	%xmm5, 0x30(%r13)
pxor	0x50(%rsp), %xmm6
movdqu	%xmm2, 0x40(%r13)
pxor	0x60(%rsp), %xmm1
movdqu	%xmm6, 0x50(%r13)
movdqu	%xmm1, 0x60(%r13)
leaq	0x70(%r13), %r13
movdqa	0x70(%rsp), %xmm6
jmp	L_2235
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2000:
pxor	%xmm11, %xmm3
leaq	0x60(%r12), %r12
pxor	%xmm12, %xmm4
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm3
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm5
movdqu	%xmm3, 0x20(%r13)
pxor	0x40(%rsp), %xmm2
movdqu	%xmm5, 0x30(%r13)
pxor	0x50(%rsp), %xmm6
movdqu	%xmm2, 0x40(%r13)
movdqu	%xmm6, 0x50(%r13)
leaq	0x60(%r13), %r13
movdqa	0x60(%rsp), %xmm6
jmp	L_2235
nopw	%cs:(%rax,%rax)
L_2080:
pxor	%xmm10, %xmm2
leaq	0x50(%r12), %r12
pxor	%xmm11, %xmm3
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm3
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm5
movdqu	%xmm3, 0x20(%r13)
pxor	0x40(%rsp), %xmm2
movdqu	%xmm5, 0x30(%r13)
movdqu	%xmm2, 0x40(%r13)
leaq	0x50(%r13), %r13
movdqa	0x50(%rsp), %xmm6
jmp	L_2235
nopw	(%rax,%rax)
L_20f0:
pxor	%xmm9, %xmm1
leaq	0x40(%r12), %r12
pxor	%xmm10, %xmm2
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm3
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm5
movdqu	%xmm3, 0x20(%r13)
movdqu	%xmm5, 0x30(%r13)
leaq	0x40(%r13), %r13
movdqa	0x40(%rsp), %xmm6
jmp	L_2235
nop
L_2150:
pxor	%xmm8, %xmm0
leaq	0x30(%r12), %r12
pxor	%xmm9, %xmm1
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm3
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm3, 0x20(%r13)
leaq	0x30(%r13), %r13
movdqa	0x30(%rsp), %xmm6
jmp	L_2235
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_21b0:
pxor	%xmm7, %xmm15
leaq	0x20(%r12), %r12
pxor	%xmm8, %xmm0
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_encrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
leaq	0x20(%r13), %r13
movdqa	0x20(%rsp), %xmm6
jmp	L_2235
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2200:
pxor	%xmm15, %xmm7
leaq	0x10(%r12), %r12
movdqa	%xmm7, 0x20(%rbp)
leaq	0x20(%rbp), %rdi
leaq	0x20(%rbp), %rsi
leaq	(%r15), %rdx
callq	asm_AES_encrypt
pxor	0x20(%rbp), %xmm15
movdqu	%xmm15, (%r13)
leaq	0x10(%r13), %r13
movdqa	0x10(%rsp), %xmm6
L_2235:
andl	$0xf, %ebx
je	L_2285
movq	%r13, %rdx
L_223d:
movzbl	(%r12), %eax
movzbl	-0x10(%rdx), %ecx
leaq	0x1(%r12), %r12
movb	%al, -0x10(%rdx)
movb	%cl, (%rdx)
leaq	0x1(%rdx), %rdx
subl	$0x1, %ebx
jne	L_223d
movdqu	-0x10(%r13), %xmm15
leaq	0x20(%rbp), %rdi
pxor	%xmm6, %xmm15
leaq	0x20(%rbp), %rsi
movdqa	%xmm15, 0x20(%rbp)
leaq	(%r15), %rdx
callq	asm_AES_encrypt
pxor	0x20(%rbp), %xmm6
movdqu	%xmm6, -0x10(%r13)
L_2285:
leaq	(%rsp), %rax
pxor	%xmm0, %xmm0
L_228d:
movdqa	%xmm0, (%rax)
movdqa	%xmm0, 0x10(%rax)
leaq	0x20(%rax), %rax
cmpq	%rax, %rbp
ja	L_228d
leaq	0x78(%rbp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbx
movq	-0x8(%rax), %rbp
leaq	(%rax), %rsp
rep	retq
ossl_bsaes_xts_decrypt:
endbr64
movq	%rsp, %rax
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x48(%rsp), %rsp
movq	%rsp, %rbp
movq	%rdi, %r12
movq	%rsi, %r13
movq	%rdx, %r14
movq	%rcx, %r15
leaq	(%r9), %rdi
leaq	0x20(%rbp), %rsi
leaq	(%r8), %rdx
callq	asm_AES_encrypt
movl	0xf0(%r15), %eax
movq	%r14, %rbx
movl	%eax, %edx
shlq	$0x7, %rax
subq	$0x60, %rax
subq	%rax, %rsp
movq	%rsp, %rax
movq	%r15, %rcx
movl	%edx, %r10d
callq	_bsaes_key_convert
pxor	(%rsp), %xmm7
movdqa	%xmm6, (%rax)
movdqa	%xmm7, (%rsp)
xorl	%eax, %eax
andq	$-0x10, %r14
testl	$0xf, %ebx
setne	%al
shlq	$0x4, %rax
subq	%rax, %r14
subq	$0x80, %rsp
movdqa	0x20(%rbp), %xmm6
pxor	%xmm14, %xmm14
movdqa	_bsaes_const+304(%rip), %xmm12
pcmpgtd	%xmm6, %xmm14
subq	$0x80, %r14
jb	L_25b0
jmp	L_2370
nopl	(%rax,%rax)
L_2370:
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm15
movdqa	%xmm6, (%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm0
movdqa	%xmm6, 0x10(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	(%r12), %xmm7
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm1
movdqa	%xmm6, 0x20(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x10(%r12), %xmm8
pxor	%xmm7, %xmm15
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm2
movdqa	%xmm6, 0x30(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x20(%r12), %xmm9
pxor	%xmm8, %xmm0
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm3
movdqa	%xmm6, 0x40(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x30(%r12), %xmm10
pxor	%xmm9, %xmm1
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm4
movdqa	%xmm6, 0x50(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x40(%r12), %xmm11
pxor	%xmm10, %xmm2
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm5
movdqa	%xmm6, 0x60(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x50(%r12), %xmm12
pxor	%xmm11, %xmm3
movdqu	0x60(%r12), %xmm13
pxor	%xmm12, %xmm4
movdqu	0x70(%r12), %xmm14
leaq	0x80(%r12), %r12
movdqa	%xmm6, 0x70(%rsp)
pxor	%xmm13, %xmm5
leaq	0x80(%rsp), %rax
pxor	%xmm14, %xmm6
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm5
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm3
movdqu	%xmm5, 0x20(%r13)
pxor	0x40(%rsp), %xmm1
movdqu	%xmm3, 0x30(%r13)
pxor	0x50(%rsp), %xmm6
movdqu	%xmm1, 0x40(%r13)
pxor	0x60(%rsp), %xmm2
movdqu	%xmm6, 0x50(%r13)
pxor	0x70(%rsp), %xmm4
movdqu	%xmm2, 0x60(%r13)
movdqu	%xmm4, 0x70(%r13)
leaq	0x80(%r13), %r13
movdqa	0x70(%rsp), %xmm6
pxor	%xmm14, %xmm14
movdqa	_bsaes_const+304(%rip), %xmm12
pcmpgtd	%xmm6, %xmm14
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
subq	$0x80, %r14
jae	L_2370
L_25b0:
addq	$0x80, %r14
je	L_2a25
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm15
movdqa	%xmm6, (%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm0
movdqa	%xmm6, 0x10(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	(%r12), %xmm7
cmpq	$0x10, %r14
je	L_29f0
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm1
movdqa	%xmm6, 0x20(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x10(%r12), %xmm8
cmpq	$0x20, %r14
je	L_29a0
pxor	%xmm7, %xmm15
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm2
movdqa	%xmm6, 0x30(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x20(%r12), %xmm9
cmpq	$0x30, %r14
je	L_2940
pxor	%xmm8, %xmm0
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm3
movdqa	%xmm6, 0x40(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x30(%r12), %xmm10
cmpq	$0x40, %r14
je	L_28e0
pxor	%xmm9, %xmm1
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm4
movdqa	%xmm6, 0x50(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x40(%r12), %xmm11
cmpq	$0x50, %r14
je	L_2870
pxor	%xmm10, %xmm2
pshufd	$0x13, %xmm14, %xmm13
pxor	%xmm14, %xmm14
movdqa	%xmm6, %xmm5
movdqa	%xmm6, 0x60(%rsp)
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
pcmpgtd	%xmm6, %xmm14
pxor	%xmm13, %xmm6
movdqu	0x50(%r12), %xmm12
cmpq	$0x60, %r14
je	L_27f0
pxor	%xmm11, %xmm3
movdqu	0x60(%r12), %xmm13
pxor	%xmm12, %xmm4
movdqa	%xmm6, 0x70(%rsp)
leaq	0x70(%r12), %r12
pxor	%xmm13, %xmm5
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm5
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm3
movdqu	%xmm5, 0x20(%r13)
pxor	0x40(%rsp), %xmm1
movdqu	%xmm3, 0x30(%r13)
pxor	0x50(%rsp), %xmm6
movdqu	%xmm1, 0x40(%r13)
pxor	0x60(%rsp), %xmm2
movdqu	%xmm6, 0x50(%r13)
movdqu	%xmm2, 0x60(%r13)
leaq	0x70(%r13), %r13
movdqa	0x70(%rsp), %xmm6
jmp	L_2a25
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_27f0:
pxor	%xmm11, %xmm3
leaq	0x60(%r12), %r12
pxor	%xmm12, %xmm4
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm5
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm3
movdqu	%xmm5, 0x20(%r13)
pxor	0x40(%rsp), %xmm1
movdqu	%xmm3, 0x30(%r13)
pxor	0x50(%rsp), %xmm6
movdqu	%xmm1, 0x40(%r13)
movdqu	%xmm6, 0x50(%r13)
leaq	0x60(%r13), %r13
movdqa	0x60(%rsp), %xmm6
jmp	L_2a25
nopw	%cs:(%rax,%rax)
L_2870:
pxor	%xmm10, %xmm2
leaq	0x50(%r12), %r12
pxor	%xmm11, %xmm3
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm5
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm3
movdqu	%xmm5, 0x20(%r13)
pxor	0x40(%rsp), %xmm1
movdqu	%xmm3, 0x30(%r13)
movdqu	%xmm1, 0x40(%r13)
leaq	0x50(%r13), %r13
movdqa	0x50(%rsp), %xmm6
jmp	L_2a25
nopw	(%rax,%rax)
L_28e0:
pxor	%xmm9, %xmm1
leaq	0x40(%r12), %r12
pxor	%xmm10, %xmm2
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm5
movdqu	%xmm0, 0x10(%r13)
pxor	0x30(%rsp), %xmm3
movdqu	%xmm5, 0x20(%r13)
movdqu	%xmm3, 0x30(%r13)
leaq	0x40(%r13), %r13
movdqa	0x40(%rsp), %xmm6
jmp	L_2a25
nop
L_2940:
pxor	%xmm8, %xmm0
leaq	0x30(%r12), %r12
pxor	%xmm9, %xmm1
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
pxor	0x20(%rsp), %xmm5
movdqu	%xmm0, 0x10(%r13)
movdqu	%xmm5, 0x20(%r13)
leaq	0x30(%r13), %r13
movdqa	0x30(%rsp), %xmm6
jmp	L_2a25
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_29a0:
pxor	%xmm7, %xmm15
leaq	0x20(%r12), %r12
pxor	%xmm8, %xmm0
leaq	0x80(%rsp), %rax
movl	%edx, %r10d
callq	_bsaes_decrypt8
pxor	(%rsp), %xmm15
pxor	0x10(%rsp), %xmm0
movdqu	%xmm15, (%r13)
movdqu	%xmm0, 0x10(%r13)
leaq	0x20(%r13), %r13
movdqa	0x20(%rsp), %xmm6
jmp	L_2a25
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_29f0:
pxor	%xmm15, %xmm7
leaq	0x10(%r12), %r12
movdqa	%xmm7, 0x20(%rbp)
leaq	0x20(%rbp), %rdi
leaq	0x20(%rbp), %rsi
leaq	(%r15), %rdx
callq	asm_AES_decrypt
pxor	0x20(%rbp), %xmm15
movdqu	%xmm15, (%r13)
leaq	0x10(%r13), %r13
movdqa	0x10(%rsp), %xmm6
L_2a25:
andl	$0xf, %ebx
je	L_2ad0
pxor	%xmm14, %xmm14
movdqa	_bsaes_const+304(%rip), %xmm12
pcmpgtd	%xmm6, %xmm14
pshufd	$0x13, %xmm14, %xmm13
movdqa	%xmm6, %xmm5
paddq	%xmm6, %xmm6
pand	%xmm12, %xmm13
movdqu	(%r12), %xmm15
pxor	%xmm13, %xmm6
leaq	0x20(%rbp), %rdi
pxor	%xmm6, %xmm15
leaq	0x20(%rbp), %rsi
movdqa	%xmm15, 0x20(%rbp)
leaq	(%r15), %rdx
callq	asm_AES_decrypt
pxor	0x20(%rbp), %xmm6
movq	%r13, %rdx
movdqu	%xmm6, (%r13)
L_2a88:
movzbl	0x10(%r12), %eax
movzbl	(%rdx), %ecx
leaq	0x1(%r12), %r12
movb	%al, (%rdx)
movb	%cl, 0x10(%rdx)
leaq	0x1(%rdx), %rdx
subl	$0x1, %ebx
jne	L_2a88
movdqu	(%r13), %xmm15
leaq	0x20(%rbp), %rdi
pxor	%xmm5, %xmm15
leaq	0x20(%rbp), %rsi
movdqa	%xmm15, 0x20(%rbp)
leaq	(%r15), %rdx
callq	asm_AES_decrypt
pxor	0x20(%rbp), %xmm5
movdqu	%xmm5, (%r13)
L_2ad0:
leaq	(%rsp), %rax
pxor	%xmm0, %xmm0
L_2ad8:
movdqa	%xmm0, (%rax)
movdqa	%xmm0, 0x10(%rax)
leaq	0x20(%rax), %rax
cmpq	%rax, %rbp
ja	L_2ad8
leaq	0x78(%rbp), %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbx
movq	-0x8(%rax), %rbp
leaq	(%rax), %rsp
rep	retq
	.section .rodata
	.p2align 6
_bsaes_const:
	.size _bsaes_const, 448
	.byte 3,15,11,7,6,2,14,10,9,5,1,13,12,8,4,0
	.byte 15,8,5,2,14,11,4,1,13,10,7,0,12,9,6,3
	.byte 3,0,1,2,6,7,4,5,9,10,11,8,12,13,14,15
	.byte 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	.byte 51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	.byte 1,2,3,0,6,7,4,5,11,8,9,10,12,13,14,15
	.byte 15,10,5,0,14,9,4,3,13,8,7,2,12,11,6,1
	.byte 11,7,3,15,6,2,14,10,1,13,9,5,12,8,4,0
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,15,14,13,12
	.byte 11,7,3,12,6,2,13,10,1,14,9,5,15,8,4,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0
	.byte 135,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	.byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	.byte 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	.byte 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	.byte 15,11,7,3,14,10,6,2,13,9,5,1,12,8,4,0
	.byte 99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 66,105,116,45,115,108,105,99,101,100,32,65,69,83,32,102
	.byte 111,114,32,120,56,54,95,54,52,47,83,83,83,69,51,44
	.byte 32,69,109,105,108,105,97,32,75,195,164,115,112,101,114,44
	.byte 32,80,101,116,101,114,32,83,99,104,119,97,98,101,44,32
	.byte 65,110,100,121,32,80,111,108,121,97,107,111,118,0
# ---- aes-x86_64.S, for asm_AES_cbc_encrypt, asm_AES_decrypt, asm_AES_encrypt
	.text
	.text
_x86_64_AES_encrypt:
xorl	(%r15), %eax
xorl	0x4(%r15), %ebx
xorl	0x8(%r15), %ecx
xorl	0xc(%r15), %edx
movl	0xf0(%r15), %r13d
subl	$0x1, %r13d
jmp	Laes_x86_64__20
nopl	(%rax)
Laes_x86_64__20:
movzbl	%al, %esi
movzbl	%bl, %edi
movzbl	%cl, %ebp
movl	(%r14,%rsi,8), %r10d
movl	(%r14,%rdi,8), %r11d
movl	(%r14,%rbp,8), %r12d
movzbl	%bh, %esi
movzbl	%ch, %edi
movzbl	%dl, %ebp
xorl	0x3(%r14,%rsi,8), %r10d
xorl	0x3(%r14,%rdi,8), %r11d
movl	(%r14,%rbp,8), %r8d
movzbl	%dh, %esi
shrl	$0x10, %ecx
movzbl	%ah, %ebp
xorl	0x3(%r14,%rsi,8), %r12d
shrl	$0x10, %edx
xorl	0x3(%r14,%rbp,8), %r8d
shrl	$0x10, %ebx
leaq	0x10(%r15), %r15
shrl	$0x10, %eax
movzbl	%cl, %esi
movzbl	%dl, %edi
movzbl	%al, %ebp
xorl	0x2(%r14,%rsi,8), %r10d
xorl	0x2(%r14,%rdi,8), %r11d
xorl	0x2(%r14,%rbp,8), %r12d
movzbl	%dh, %esi
movzbl	%ah, %edi
movzbl	%bl, %ebp
xorl	0x1(%r14,%rsi,8), %r10d
xorl	0x1(%r14,%rdi,8), %r11d
xorl	0x2(%r14,%rbp,8), %r8d
movl	0xc(%r15), %edx
movzbl	%bh, %edi
movzbl	%ch, %ebp
movl	(%r15), %eax
xorl	0x1(%r14,%rdi,8), %r12d
xorl	0x1(%r14,%rbp,8), %r8d
movl	0x4(%r15), %ebx
movl	0x8(%r15), %ecx
xorl	%r10d, %eax
xorl	%r11d, %ebx
xorl	%r12d, %ecx
xorl	%r8d, %edx
subl	$0x1, %r13d
jne	Laes_x86_64__20
movzbl	%al, %esi
movzbl	%bl, %edi
movzbl	%cl, %ebp
movzbl	0x2(%r14,%rsi,8), %r10d
movzbl	0x2(%r14,%rdi,8), %r11d
movzbl	0x2(%r14,%rbp,8), %r12d
movzbl	%dl, %esi
movzbl	%bh, %edi
movzbl	%ch, %ebp
movzbl	0x2(%r14,%rsi,8), %r8d
movl	(%r14,%rdi,8), %edi
movl	(%r14,%rbp,8), %ebp
andl	$0xff00, %edi
andl	$0xff00, %ebp
xorl	%edi, %r10d
xorl	%ebp, %r11d
shrl	$0x10, %ecx
movzbl	%dh, %esi
movzbl	%ah, %edi
shrl	$0x10, %edx
movl	(%r14,%rsi,8), %esi
movl	(%r14,%rdi,8), %edi
andl	$0xff00, %esi
andl	$0xff00, %edi
shrl	$0x10, %ebx
xorl	%esi, %r12d
xorl	%edi, %r8d
shrl	$0x10, %eax
movzbl	%cl, %esi
movzbl	%dl, %edi
movzbl	%al, %ebp
movl	(%r14,%rsi,8), %esi
movl	(%r14,%rdi,8), %edi
movl	(%r14,%rbp,8), %ebp
andl	$0xff0000, %esi
andl	$0xff0000, %edi
andl	$0xff0000, %ebp
xorl	%esi, %r10d
xorl	%edi, %r11d
xorl	%ebp, %r12d
movzbl	%bl, %esi
movzbl	%dh, %edi
movzbl	%ah, %ebp
movl	(%r14,%rsi,8), %esi
movl	0x2(%r14,%rdi,8), %edi
movl	0x2(%r14,%rbp,8), %ebp
andl	$0xff0000, %esi
andl	$0xff000000, %edi
andl	$0xff000000, %ebp
xorl	%esi, %r8d
xorl	%edi, %r10d
xorl	%ebp, %r11d
movzbl	%bh, %esi
movzbl	%ch, %edi
movl	0x1c(%r15), %edx
movl	0x2(%r14,%rsi,8), %esi
movl	0x2(%r14,%rdi,8), %edi
movl	0x10(%r15), %eax
andl	$0xff000000, %esi
andl	$0xff000000, %edi
xorl	%esi, %r12d
xorl	%edi, %r8d
movl	0x14(%r15), %ebx
movl	0x18(%r15), %ecx
xorl	%r10d, %eax
xorl	%r11d, %ebx
xorl	%r12d, %ecx
xorl	%r8d, %edx
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
_x86_64_AES_encrypt_compact:
leaq	0x80(%r14), %r8
movl	-0x80(%r8), %edi
movl	-0x60(%r8), %ebp
movl	-0x40(%r8), %r10d
movl	-0x20(%r8), %r11d
movl	(%r8), %edi
movl	0x20(%r8), %ebp
movl	0x40(%r8), %r10d
movl	0x60(%r8), %r11d
jmp	Laes_x86_64__220
nopl	(%rax,%rax)
Laes_x86_64__220:
xorl	(%r15), %eax
xorl	0x4(%r15), %ebx
xorl	0x8(%r15), %ecx
xorl	0xc(%r15), %edx
leaq	0x10(%r15), %r15
movzbl	%al, %r10d
movzbl	%bl, %r11d
movzbl	%cl, %r12d
movzbl	%dl, %r8d
movzbl	%bh, %esi
movzbl	%ch, %edi
shrl	$0x10, %ecx
movzbl	%dh, %ebp
movzbl	(%r14,%r10), %r10d
movzbl	(%r14,%r11), %r11d
movzbl	(%r14,%r12), %r12d
movzbl	(%r14,%r8), %r8d
movzbl	(%r14,%rsi), %r9d
movzbl	%ah, %esi
movzbl	(%r14,%rdi), %r13d
movzbl	%cl, %edi
movzbl	(%r14,%rbp), %ebp
movzbl	(%r14,%rsi), %esi
shll	$0x8, %r9d
shrl	$0x10, %edx
shll	$0x8, %r13d
xorl	%r9d, %r10d
shrl	$0x10, %eax
movzbl	%dl, %r9d
shrl	$0x10, %ebx
xorl	%r13d, %r11d
shll	$0x8, %ebp
movzbl	%al, %r13d
movzbl	(%r14,%rdi), %edi
xorl	%ebp, %r12d
shll	$0x8, %esi
movzbl	%bl, %ebp
shll	$0x10, %edi
xorl	%esi, %r8d
movzbl	(%r14,%r9), %r9d
movzbl	%dh, %esi
movzbl	(%r14,%r13), %r13d
xorl	%edi, %r10d
shrl	$0x8, %ecx
movzbl	%ah, %edi
shll	$0x10, %r9d
shrl	$0x8, %ebx
shll	$0x10, %r13d
xorl	%r9d, %r11d
movzbl	(%r14,%rbp), %ebp
movzbl	(%r14,%rsi), %esi
movzbl	(%r14,%rdi), %edi
movzbl	(%r14,%rcx), %edx
movzbl	(%r14,%rbx), %ecx
shll	$0x10, %ebp
xorl	%r13d, %r12d
shll	$0x18, %esi
xorl	%ebp, %r8d
shll	$0x18, %edi
xorl	%esi, %r10d
shll	$0x18, %edx
xorl	%edi, %r11d
shll	$0x18, %ecx
movl	%r10d, %eax
movl	%r11d, %ebx
xorl	%r12d, %ecx
xorl	%r8d, %edx
cmpq	0x10(%rsp), %r15
je	Laes_x86_64__440
movl	$0x80808080, %r10d
movl	$0x80808080, %r11d
andl	%eax, %r10d
andl	%ebx, %r11d
movl	%r10d, %esi
movl	%r11d, %edi
shrl	$0x7, %r10d
leal	(%rax,%rax), %r8d
shrl	$0x7, %r11d
leal	(%rbx,%rbx), %r9d
subl	%r10d, %esi
subl	%r11d, %edi
andl	$0xfefefefe, %r8d
andl	$0xfefefefe, %r9d
andl	$0x1b1b1b1b, %esi
andl	$0x1b1b1b1b, %edi
movl	%eax, %r10d
movl	%ebx, %r11d
xorl	%esi, %r8d
xorl	%edi, %r9d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movl	$0x80808080, %r12d
roll	$0x18, %eax
movl	$0x80808080, %ebp
roll	$0x18, %ebx
andl	%ecx, %r12d
andl	%edx, %ebp
xorl	%r8d, %eax
xorl	%r9d, %ebx
movl	%r12d, %esi
rorl	$0x10, %r10d
movl	%ebp, %edi
rorl	$0x10, %r11d
leal	(%rcx,%rcx), %r8d
shrl	$0x7, %r12d
xorl	%r10d, %eax
shrl	$0x7, %ebp
xorl	%r11d, %ebx
rorl	$0x8, %r10d
leal	(%rdx,%rdx), %r9d
rorl	$0x8, %r11d
subl	%r12d, %esi
subl	%ebp, %edi
xorl	%r10d, %eax
xorl	%r11d, %ebx
andl	$0xfefefefe, %r8d
andl	$0xfefefefe, %r9d
andl	$0x1b1b1b1b, %esi
andl	$0x1b1b1b1b, %edi
movl	%ecx, %r12d
movl	%edx, %ebp
xorl	%esi, %r8d
xorl	%edi, %r9d
rorl	$0x10, %r12d
xorl	%r8d, %ecx
rorl	$0x10, %ebp
xorl	%r9d, %edx
roll	$0x18, %ecx
movl	(%r14), %esi
roll	$0x18, %edx
xorl	%r8d, %ecx
movl	0x40(%r14), %edi
xorl	%r9d, %edx
movl	0x80(%r14), %r8d
xorl	%r12d, %ecx
rorl	$0x8, %r12d
xorl	%ebp, %edx
rorl	$0x8, %ebp
xorl	%r12d, %ecx
movl	0xc0(%r14), %r9d
xorl	%ebp, %edx
jmp	Laes_x86_64__220
nopw	%cs:(%rax,%rax)
Laes_x86_64__440:
xorl	(%r15), %eax
xorl	0x4(%r15), %ebx
xorl	0x8(%r15), %ecx
xorl	0xc(%r15), %edx
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
AES_encrypt:
asm_AES_encrypt:
endbr64
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x3f(%rdx), %rcx
andq	$-0x40, %rsp
subq	%rsp, %rcx
negq	%rcx
andq	$0x3c0, %rcx
subq	%rcx, %rsp
subq	$0x20, %rsp
movq	%rsi, 0x10(%rsp)
movq	%rax, 0x18(%rsp)
movq	%rdx, %r15
movl	0xf0(%r15), %r13d
movl	(%rdi), %eax
movl	0x4(%rdi), %ebx
movl	0x8(%rdi), %ecx
movl	0xc(%rdi), %edx
shll	$0x4, %r13d
leaq	(%r15,%r13), %rbp
movq	%r15, (%rsp)
movq	%rbp, 0x8(%rsp)
leaq	bums_rodata+2048(%rip), %r14
leaq	0x300(%rsp), %rbp
subq	%r14, %rbp
andq	$0x300, %rbp
leaq	(%r14,%rbp), %r14
callq	_x86_64_AES_encrypt_compact
movq	0x10(%rsp), %r9
movq	0x18(%rsp), %rsi
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nop
_x86_64_AES_decrypt:
xorl	(%r15), %eax
xorl	0x4(%r15), %ebx
xorl	0x8(%r15), %ecx
xorl	0xc(%r15), %edx
movl	0xf0(%r15), %r13d
subl	$0x1, %r13d
jmp	Laes_x86_64__540
nopl	(%rax)
Laes_x86_64__540:
movzbl	%al, %esi
movzbl	%bl, %edi
movzbl	%cl, %ebp
movl	(%r14,%rsi,8), %r10d
movl	(%r14,%rdi,8), %r11d
movl	(%r14,%rbp,8), %r12d
movzbl	%dh, %esi
movzbl	%ah, %edi
movzbl	%dl, %ebp
xorl	0x3(%r14,%rsi,8), %r10d
xorl	0x3(%r14,%rdi,8), %r11d
movl	(%r14,%rbp,8), %r8d
movzbl	%bh, %esi
shrl	$0x10, %eax
movzbl	%ch, %ebp
xorl	0x3(%r14,%rsi,8), %r12d
shrl	$0x10, %edx
xorl	0x3(%r14,%rbp,8), %r8d
shrl	$0x10, %ebx
leaq	0x10(%r15), %r15
shrl	$0x10, %ecx
movzbl	%cl, %esi
movzbl	%dl, %edi
movzbl	%al, %ebp
xorl	0x2(%r14,%rsi,8), %r10d
xorl	0x2(%r14,%rdi,8), %r11d
xorl	0x2(%r14,%rbp,8), %r12d
movzbl	%bh, %esi
movzbl	%ch, %edi
movzbl	%bl, %ebp
xorl	0x1(%r14,%rsi,8), %r10d
xorl	0x1(%r14,%rdi,8), %r11d
xorl	0x2(%r14,%rbp,8), %r8d
movzbl	%dh, %esi
movl	0xc(%r15), %edx
movzbl	%ah, %ebp
xorl	0x1(%r14,%rsi,8), %r12d
movl	(%r15), %eax
xorl	0x1(%r14,%rbp,8), %r8d
xorl	%r10d, %eax
movl	0x4(%r15), %ebx
movl	0x8(%r15), %ecx
xorl	%r12d, %ecx
xorl	%r11d, %ebx
xorl	%r8d, %edx
subl	$0x1, %r13d
jne	Laes_x86_64__540
leaq	0x800(%r14), %r14
movzbl	%al, %esi
movzbl	%bl, %edi
movzbl	%cl, %ebp
movzbl	(%r14,%rsi), %r10d
movzbl	(%r14,%rdi), %r11d
movzbl	(%r14,%rbp), %r12d
movzbl	%dl, %esi
movzbl	%dh, %edi
movzbl	%ah, %ebp
movzbl	(%r14,%rsi), %r8d
movzbl	(%r14,%rdi), %edi
movzbl	(%r14,%rbp), %ebp
shll	$0x8, %edi
shll	$0x8, %ebp
xorl	%edi, %r10d
xorl	%ebp, %r11d
shrl	$0x10, %edx
movzbl	%bh, %esi
movzbl	%ch, %edi
shrl	$0x10, %eax
movzbl	(%r14,%rsi), %esi
movzbl	(%r14,%rdi), %edi
shll	$0x8, %esi
shll	$0x8, %edi
shrl	$0x10, %ebx
xorl	%esi, %r12d
xorl	%edi, %r8d
shrl	$0x10, %ecx
movzbl	%cl, %esi
movzbl	%dl, %edi
movzbl	%al, %ebp
movzbl	(%r14,%rsi), %esi
movzbl	(%r14,%rdi), %edi
movzbl	(%r14,%rbp), %ebp
shll	$0x10, %esi
shll	$0x10, %edi
shll	$0x10, %ebp
xorl	%esi, %r10d
xorl	%edi, %r11d
xorl	%ebp, %r12d
movzbl	%bl, %esi
movzbl	%bh, %edi
movzbl	%ch, %ebp
movzbl	(%r14,%rsi), %esi
movzbl	(%r14,%rdi), %edi
movzbl	(%r14,%rbp), %ebp
shll	$0x10, %esi
shll	$0x18, %edi
shll	$0x18, %ebp
xorl	%esi, %r8d
xorl	%edi, %r10d
xorl	%ebp, %r11d
movzbl	%dh, %esi
movzbl	%ah, %edi
movl	0x1c(%r15), %edx
movzbl	(%r14,%rsi), %esi
movzbl	(%r14,%rdi), %edi
movl	0x10(%r15), %eax
shll	$0x18, %esi
shll	$0x18, %edi
xorl	%esi, %r12d
xorl	%edi, %r8d
movl	0x14(%r15), %ebx
movl	0x18(%r15), %ecx
leaq	-0x800(%r14), %r14
xorl	%r10d, %eax
xorl	%r11d, %ebx
xorl	%r12d, %ecx
xorl	%r8d, %edx
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
_x86_64_AES_decrypt_compact:
leaq	0x80(%r14), %r8
movl	-0x80(%r8), %edi
movl	-0x60(%r8), %ebp
movl	-0x40(%r8), %r10d
movl	-0x20(%r8), %r11d
movl	(%r8), %edi
movl	0x20(%r8), %ebp
movl	0x40(%r8), %r10d
movl	0x60(%r8), %r11d
jmp	Laes_x86_64__730
nopl	(%rax,%rax)
Laes_x86_64__730:
xorl	(%r15), %eax
xorl	0x4(%r15), %ebx
xorl	0x8(%r15), %ecx
xorl	0xc(%r15), %edx
leaq	0x10(%r15), %r15
movzbl	%al, %r10d
movzbl	%bl, %r11d
movzbl	%cl, %r12d
movzbl	%dl, %r8d
movzbl	%dh, %esi
movzbl	%ah, %edi
shrl	$0x10, %edx
movzbl	%bh, %ebp
movzbl	(%r14,%r10), %r10d
movzbl	(%r14,%r11), %r11d
movzbl	(%r14,%r12), %r12d
movzbl	(%r14,%r8), %r8d
movzbl	(%r14,%rsi), %r9d
movzbl	%ch, %esi
movzbl	(%r14,%rdi), %r13d
movzbl	(%r14,%rbp), %ebp
movzbl	(%r14,%rsi), %esi
shrl	$0x10, %ecx
shll	$0x8, %r13d
shll	$0x8, %r9d
movzbl	%cl, %edi
shrl	$0x10, %eax
xorl	%r9d, %r10d
shrl	$0x10, %ebx
movzbl	%dl, %r9d
shll	$0x8, %ebp
xorl	%r13d, %r11d
shll	$0x8, %esi
movzbl	%al, %r13d
movzbl	(%r14,%rdi), %edi
xorl	%ebp, %r12d
movzbl	%bl, %ebp
shll	$0x10, %edi
xorl	%esi, %r8d
movzbl	(%r14,%r9), %r9d
movzbl	%bh, %esi
movzbl	(%r14,%rbp), %ebp
xorl	%edi, %r10d
movzbl	(%r14,%r13), %r13d
movzbl	%ch, %edi
shll	$0x10, %ebp
shll	$0x10, %r9d
shll	$0x10, %r13d
xorl	%ebp, %r8d
movzbl	%dh, %ebp
xorl	%r9d, %r11d
shrl	$0x8, %eax
xorl	%r13d, %r12d
movzbl	(%r14,%rsi), %esi
movzbl	(%r14,%rdi), %ebx
movzbl	(%r14,%rbp), %ecx
movzbl	(%r14,%rax), %edx
movl	%r10d, %eax
shll	$0x18, %esi
shll	$0x18, %ebx
shll	$0x18, %ecx
xorl	%esi, %eax
shll	$0x18, %edx
xorl	%r11d, %ebx
xorl	%r12d, %ecx
xorl	%r8d, %edx
cmpq	0x10(%rsp), %r15
je	Laes_x86_64__9d0
movq	0x100(%r14), %rsi
shlq	$0x20, %rbx
shlq	$0x20, %rdx
movq	0x108(%r14), %rdi
orq	%rbx, %rax
orq	%rdx, %rcx
movq	0x110(%r14), %rbp
movq	%rsi, %r9
movq	%rsi, %r12
andq	%rax, %r9
andq	%rcx, %r12
movq	%r9, %rbx
movq	%r12, %rdx
shrq	$0x7, %r9
leaq	(%rax,%rax), %r8
shrq	$0x7, %r12
leaq	(%rcx,%rcx), %r11
subq	%r9, %rbx
subq	%r12, %rdx
andq	%rdi, %r8
andq	%rdi, %r11
andq	%rbp, %rbx
andq	%rbp, %rdx
xorq	%rbx, %r8
xorq	%rdx, %r11
movq	%rsi, %r10
movq	%rsi, %r13
andq	%r8, %r10
andq	%r11, %r13
movq	%r10, %rbx
movq	%r13, %rdx
shrq	$0x7, %r10
leaq	(%r8,%r8), %r9
shrq	$0x7, %r13
leaq	(%r11,%r11), %r12
subq	%r10, %rbx
subq	%r13, %rdx
andq	%rdi, %r9
andq	%rdi, %r12
andq	%rbp, %rbx
andq	%rbp, %rdx
xorq	%rbx, %r9
xorq	%rdx, %r12
movq	%rsi, %r10
movq	%rsi, %r13
andq	%r9, %r10
andq	%r12, %r13
movq	%r10, %rbx
movq	%r13, %rdx
shrq	$0x7, %r10
xorq	%rax, %r8
shrq	$0x7, %r13
xorq	%rcx, %r11
subq	%r10, %rbx
subq	%r13, %rdx
leaq	(%r9,%r9), %r10
leaq	(%r12,%r12), %r13
xorq	%rax, %r9
xorq	%rcx, %r12
andq	%rdi, %r10
andq	%rdi, %r13
andq	%rbp, %rbx
andq	%rbp, %rdx
xorq	%rbx, %r10
xorq	%rdx, %r13
xorq	%r10, %rax
xorq	%r13, %rcx
xorq	%r10, %r8
xorq	%r13, %r11
movq	%rax, %rbx
movq	%rcx, %rdx
xorq	%r10, %r9
shrq	$0x20, %rbx
xorq	%r13, %r12
shrq	$0x20, %rdx
xorq	%r8, %r10
roll	$0x8, %eax
xorq	%r11, %r13
roll	$0x8, %ecx
xorq	%r9, %r10
roll	$0x8, %ebx
xorq	%r12, %r13
roll	$0x8, %edx
xorl	%r10d, %eax
shrq	$0x20, %r10
xorl	%r13d, %ecx
shrq	$0x20, %r13
xorl	%r10d, %ebx
xorl	%r13d, %edx
movq	%r8, %r10
roll	$0x18, %r8d
movq	%r11, %r13
roll	$0x18, %r11d
shrq	$0x20, %r10
xorl	%r8d, %eax
shrq	$0x20, %r13
xorl	%r11d, %ecx
roll	$0x18, %r10d
movq	%r9, %r8
roll	$0x18, %r13d
movq	%r12, %r11
shrq	$0x20, %r8
xorl	%r10d, %ebx
shrq	$0x20, %r11
xorl	%r13d, %edx
movq	(%r14), %rsi
roll	$0x10, %r9d
movq	0x40(%r14), %rdi
roll	$0x10, %r12d
movq	0x80(%r14), %rbp
roll	$0x10, %r8d
movq	0xc0(%r14), %r10
xorl	%r9d, %eax
roll	$0x10, %r11d
xorl	%r12d, %ecx
movq	0x100(%r14), %r13
xorl	%r8d, %ebx
xorl	%r11d, %edx
jmp	Laes_x86_64__730
nopl	(%rax)
Laes_x86_64__9d0:
xorl	(%r15), %eax
xorl	0x4(%r15), %ebx
xorl	0x8(%r15), %ecx
xorl	0xc(%r15), %edx
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
AES_decrypt:
asm_AES_decrypt:
endbr64
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x3f(%rdx), %rcx
andq	$-0x40, %rsp
subq	%rsp, %rcx
negq	%rcx
andq	$0x3c0, %rcx
subq	%rcx, %rsp
subq	$0x20, %rsp
movq	%rsi, 0x10(%rsp)
movq	%rax, 0x18(%rsp)
movq	%rdx, %r15
movl	0xf0(%r15), %r13d
movl	(%rdi), %eax
movl	0x4(%rdi), %ebx
movl	0x8(%rdi), %ecx
movl	0xc(%rdi), %edx
shll	$0x4, %r13d
leaq	(%r15,%r13), %rbp
movq	%r15, (%rsp)
movq	%rbp, 0x8(%rsp)
leaq	bums_rodata+5184(%rip), %r14
leaq	0x300(%rsp), %rbp
subq	%r14, %rbp
andq	$0x300, %rbp
leaq	(%r14,%rbp), %r14
shrq	$0x3, %rbp
addq	%rbp, %r14
callq	_x86_64_AES_decrypt_compact
movq	0x10(%rsp), %r9
movq	0x18(%rsp), %rsi
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopl	(%rax)
AES_set_encrypt_key:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x8, %rsp
callq	_x86_64_AES_set_encrypt_key
movq	0x28(%rsp), %rbp
movq	0x30(%rsp), %rbx
addq	$0x38, %rsp
rep	retq
nopw	(%rax,%rax)
_x86_64_AES_set_encrypt_key:
movl	%esi, %ecx
movq	%rdi, %rsi
movq	%rdx, %rdi
testq	$-0x1, %rsi
je	Laes_x86_64__d60
testq	$-0x1, %rdi
je	Laes_x86_64__d60
leaq	bums_rodata(%rip), %rbp
leaq	0x880(%rbp), %rbp
movl	-0x80(%rbp), %eax
movl	-0x60(%rbp), %ebx
movl	-0x40(%rbp), %r8d
movl	-0x20(%rbp), %edx
movl	(%rbp), %eax
movl	0x20(%rbp), %ebx
movl	0x40(%rbp), %r8d
movl	0x60(%rbp), %edx
cmpl	$0x80, %ecx
je	Laes_x86_64__b56
cmpl	$0xc0, %ecx
je	Laes_x86_64__bdc
cmpl	$0x100, %ecx
je	Laes_x86_64__c7a
movq	$-0x2, %rax
jmp	Laes_x86_64__d67
Laes_x86_64__b56:
movq	(%rsi), %rax
movq	0x8(%rsi), %rdx
movq	%rax, (%rdi)
movq	%rdx, 0x8(%rdi)
shrq	$0x20, %rdx
xorl	%ecx, %ecx
jmp	Laes_x86_64__b71
Laes_x86_64__b6c:
movl	(%rdi), %eax
movl	0xc(%rdi), %edx
Laes_x86_64__b71:
movzbl	%dl, %esi
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x18, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shrl	$0x10, %edx
movzbl	%dl, %esi
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x8, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shll	$0x10, %ebx
xorl	%ebx, %eax
xorl	0x380(%rbp,%rcx,4), %eax
movl	%eax, 0x10(%rdi)
xorl	0x4(%rdi), %eax
movl	%eax, 0x14(%rdi)
xorl	0x8(%rdi), %eax
movl	%eax, 0x18(%rdi)
xorl	0xc(%rdi), %eax
movl	%eax, 0x1c(%rdi)
addl	$0x1, %ecx
leaq	0x10(%rdi), %rdi
cmpl	$0xa, %ecx
jl	Laes_x86_64__b6c
movl	$0xa, 0x50(%rdi)
xorq	%rax, %rax
jmp	Laes_x86_64__d67
Laes_x86_64__bdc:
movq	(%rsi), %rax
movq	0x8(%rsi), %rbx
movq	0x10(%rsi), %rdx
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rdx, 0x10(%rdi)
shrq	$0x20, %rdx
xorl	%ecx, %ecx
jmp	Laes_x86_64__c01
nop
Laes_x86_64__bfc:
movl	(%rdi), %eax
movl	0x14(%rdi), %edx
Laes_x86_64__c01:
movzbl	%dl, %esi
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x18, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shrl	$0x10, %edx
movzbl	%dl, %esi
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x8, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shll	$0x10, %ebx
xorl	%ebx, %eax
xorl	0x380(%rbp,%rcx,4), %eax
movl	%eax, 0x18(%rdi)
xorl	0x4(%rdi), %eax
movl	%eax, 0x1c(%rdi)
xorl	0x8(%rdi), %eax
movl	%eax, 0x20(%rdi)
xorl	0xc(%rdi), %eax
movl	%eax, 0x24(%rdi)
cmpl	$0x7, %ecx
je	Laes_x86_64__c6b
addl	$0x1, %ecx
xorl	0x10(%rdi), %eax
movl	%eax, 0x28(%rdi)
xorl	0x14(%rdi), %eax
movl	%eax, 0x2c(%rdi)
leaq	0x18(%rdi), %rdi
jmp	Laes_x86_64__bfc
Laes_x86_64__c6b:
movl	$0xc, 0x48(%rdi)
xorq	%rax, %rax
jmp	Laes_x86_64__d67
Laes_x86_64__c7a:
movq	(%rsi), %rax
movq	0x8(%rsi), %rbx
movq	0x10(%rsi), %rcx
movq	0x18(%rsi), %rdx
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rcx, 0x10(%rdi)
movq	%rdx, 0x18(%rdi)
shrq	$0x20, %rdx
xorl	%ecx, %ecx
jmp	Laes_x86_64__ca5
Laes_x86_64__ca0:
movl	(%rdi), %eax
movl	0x1c(%rdi), %edx
Laes_x86_64__ca5:
movzbl	%dl, %esi
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x18, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shrl	$0x10, %edx
movzbl	%dl, %esi
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x8, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shll	$0x10, %ebx
xorl	%ebx, %eax
xorl	0x380(%rbp,%rcx,4), %eax
movl	%eax, 0x20(%rdi)
xorl	0x4(%rdi), %eax
movl	%eax, 0x24(%rdi)
xorl	0x8(%rdi), %eax
movl	%eax, 0x28(%rdi)
xorl	0xc(%rdi), %eax
movl	%eax, 0x2c(%rdi)
cmpl	$0x6, %ecx
je	Laes_x86_64__d54
addl	$0x1, %ecx
movl	%eax, %edx
movl	0x10(%rdi), %eax
movzbl	%dl, %esi
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shrl	$0x10, %edx
shll	$0x8, %ebx
movzbl	%dl, %esi
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
movzbl	%dh, %esi
shll	$0x10, %ebx
xorl	%ebx, %eax
movzbl	-0x80(%rbp,%rsi), %ebx
shll	$0x18, %ebx
xorl	%ebx, %eax
movl	%eax, 0x30(%rdi)
xorl	0x14(%rdi), %eax
movl	%eax, 0x34(%rdi)
xorl	0x18(%rdi), %eax
movl	%eax, 0x38(%rdi)
xorl	0x1c(%rdi), %eax
movl	%eax, 0x3c(%rdi)
leaq	0x20(%rdi), %rdi
jmp	Laes_x86_64__ca0
Laes_x86_64__d54:
movl	$0xe, 0x30(%rdi)
xorq	%rax, %rax
jmp	Laes_x86_64__d67
Laes_x86_64__d60:
movq	$-0x1, %rax
Laes_x86_64__d67:
rep	retq
nopl	(%rax)
AES_set_decrypt_key:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
pushq	%rdx
callq	_x86_64_AES_set_encrypt_key
movq	(%rsp), %r8
cmpl	$0x0, %eax
jne	Laes_x86_64__f6d
movl	0xf0(%r8), %r14d
xorq	%rdi, %rdi
leaq	(%rdi,%r14,4), %rcx
movq	%r8, %rsi
leaq	(%r8,%rcx,4), %rdi
nop
Laes_x86_64__da8:
movq	(%rsi), %rax
movq	0x8(%rsi), %rbx
movq	(%rdi), %rcx
movq	0x8(%rdi), %rdx
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rcx, (%rsi)
movq	%rdx, 0x8(%rsi)
leaq	0x10(%rsi), %rsi
leaq	-0x10(%rdi), %rdi
cmpq	%rsi, %rdi
jne	Laes_x86_64__da8
leaq	bums_rodata+3072(%rip), %rax
movq	0x28(%rax), %rsi
movq	0x30(%rax), %rdi
movq	0x38(%rax), %rbp
movq	%r8, %r15
subl	$0x1, %r14d
nop
Laes_x86_64__dec:
leaq	0x10(%r15), %r15
movq	(%r15), %rax
movq	0x8(%r15), %rcx
movq	%rsi, %r9
movq	%rsi, %r12
andq	%rax, %r9
andq	%rcx, %r12
movq	%r9, %rbx
movq	%r12, %rdx
shrq	$0x7, %r9
leaq	(%rax,%rax), %r8
shrq	$0x7, %r12
leaq	(%rcx,%rcx), %r11
subq	%r9, %rbx
subq	%r12, %rdx
andq	%rdi, %r8
andq	%rdi, %r11
andq	%rbp, %rbx
andq	%rbp, %rdx
xorq	%rbx, %r8
xorq	%rdx, %r11
movq	%rsi, %r10
movq	%rsi, %r13
andq	%r8, %r10
andq	%r11, %r13
movq	%r10, %rbx
movq	%r13, %rdx
shrq	$0x7, %r10
leaq	(%r8,%r8), %r9
shrq	$0x7, %r13
leaq	(%r11,%r11), %r12
subq	%r10, %rbx
subq	%r13, %rdx
andq	%rdi, %r9
andq	%rdi, %r12
andq	%rbp, %rbx
andq	%rbp, %rdx
xorq	%rbx, %r9
xorq	%rdx, %r12
movq	%rsi, %r10
movq	%rsi, %r13
andq	%r9, %r10
andq	%r12, %r13
movq	%r10, %rbx
movq	%r13, %rdx
shrq	$0x7, %r10
xorq	%rax, %r8
shrq	$0x7, %r13
xorq	%rcx, %r11
subq	%r10, %rbx
subq	%r13, %rdx
leaq	(%r9,%r9), %r10
leaq	(%r12,%r12), %r13
xorq	%rax, %r9
xorq	%rcx, %r12
andq	%rdi, %r10
andq	%rdi, %r13
andq	%rbp, %rbx
andq	%rbp, %rdx
xorq	%rbx, %r10
xorq	%rdx, %r13
xorq	%r10, %rax
xorq	%r13, %rcx
xorq	%r10, %r8
xorq	%r13, %r11
movq	%rax, %rbx
movq	%rcx, %rdx
xorq	%r10, %r9
shrq	$0x20, %rbx
xorq	%r13, %r12
shrq	$0x20, %rdx
xorq	%r8, %r10
roll	$0x8, %eax
xorq	%r11, %r13
roll	$0x8, %ecx
xorq	%r9, %r10
roll	$0x8, %ebx
xorq	%r12, %r13
roll	$0x8, %edx
xorl	%r10d, %eax
shrq	$0x20, %r10
xorl	%r13d, %ecx
shrq	$0x20, %r13
xorl	%r10d, %ebx
xorl	%r13d, %edx
movq	%r8, %r10
roll	$0x18, %r8d
movq	%r11, %r13
roll	$0x18, %r11d
shrq	$0x20, %r10
xorl	%r8d, %eax
shrq	$0x20, %r13
xorl	%r11d, %ecx
roll	$0x18, %r10d
movq	%r9, %r8
roll	$0x18, %r13d
movq	%r12, %r11
shrq	$0x20, %r8
xorl	%r10d, %ebx
shrq	$0x20, %r11
xorl	%r13d, %edx
roll	$0x10, %r9d
roll	$0x10, %r12d
roll	$0x10, %r8d
xorl	%r9d, %eax
roll	$0x10, %r11d
xorl	%r12d, %ecx
xorl	%r8d, %ebx
xorl	%r11d, %edx
movl	%eax, (%r15)
movl	%ebx, 0x4(%r15)
movl	%ecx, 0x8(%r15)
movl	%edx, 0xc(%r15)
subl	$0x1, %r14d
jne	Laes_x86_64__dec
xorq	%rax, %rax
Laes_x86_64__f6d:
movq	0x8(%rsp), %r15
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r13
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %rbp
movq	0x30(%rsp), %rbx
addq	$0x38, %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
AES_cbc_encrypt:
asm_AES_cbc_encrypt:
endbr64
cmpq	$0x0, %rdx
je	Laes_x86_64__1531
pushfq
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
cld
movl	%r9d, %r9d
leaq	bums_rodata(%rip), %r14
leaq	bums_rodata+3136(%rip), %r10
cmpq	$0x0, %r9
cmoveq	%r10, %r14
movl	OPENSSL_ia32cap_P(%rip), %r10d
cmpq	$0x200, %rdx
jb	Laes_x86_64__12d0
testq	$0xf, %rdx
jne	Laes_x86_64__12d0
btl	$0x1c, %r10d
jb	Laes_x86_64__12d0
leaq	-0x150(%rsp), %r15
andq	$-0x40, %r15
movq	%r14, %r10
leaq	0x900(%r14), %r11
movq	%r15, %r12
andq	$0xfff, %r10
andq	$0xfff, %r11
andq	$0xfff, %r12
cmpq	%r11, %r12
jb	Laes_x86_64__103a
subq	%r11, %r12
subq	%r12, %r15
jmp	Laes_x86_64__1050
Laes_x86_64__103a:
subq	%r10, %r12
andq	$0xfff, %r12
addq	$0x140, %r12
subq	%r12, %r15
nop
Laes_x86_64__1050:
xchgq	%rsp, %r15
movq	%r15, 0x10(%rsp)
movq	%rdi, 0x18(%rsp)
movq	%rsi, 0x20(%rsp)
movq	%rdx, 0x28(%rsp)
movq	%rcx, 0x30(%rsp)
movq	%r8, 0x38(%rsp)
movl	$0x0, 0x140(%rsp)
movq	%r8, %rbp
movq	%r9, %rbx
movq	%rsi, %r9
movq	%rdi, %r8
movq	%rcx, %r15
movl	0xf0(%r15), %eax
movq	%r15, %r10
subq	%r14, %r10
andq	$0xfff, %r10
cmpq	$0x900, %r10
jb	Laes_x86_64__10b4
cmpq	$0xf08, %r10
jb	Laes_x86_64__10cc
nopl	(%rax)
Laes_x86_64__10b4:
movq	%r15, %rsi
leaq	0x50(%rsp), %rdi
leaq	0x50(%rsp), %r15
movl	$0x1e, %ecx
rep	movsq	(%rsi), %es:(%rdi)
nop
movl	%eax, (%rdi)
Laes_x86_64__10cc:
movq	%r15, (%rsp)
movl	$0x12, %ecx
nopl	(%rax)
Laes_x86_64__10d8:
movq	(%r14), %r10
movq	0x20(%r14), %r11
movq	0x40(%r14), %r12
movq	0x60(%r14), %r13
leaq	0x80(%r14), %r14
subl	$0x1, %ecx
jne	Laes_x86_64__10d8
leaq	-0x900(%r14), %r14
cmpq	$0x0, %rbx
je	Laes_x86_64__1180
movl	(%rbp), %eax
movl	0x4(%rbp), %ebx
movl	0x8(%rbp), %ecx
movl	0xc(%rbp), %edx
Laes_x86_64__1110:
xorl	(%r8), %eax
xorl	0x4(%r8), %ebx
xorl	0x8(%r8), %ecx
xorl	0xc(%r8), %edx
movq	(%rsp), %r15
movq	%r8, 0x18(%rsp)
callq	_x86_64_AES_encrypt
movq	0x18(%rsp), %r8
movq	0x28(%rsp), %r10
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
leaq	0x10(%r8), %r8
leaq	0x10(%r9), %r9
subq	$0x10, %r10
testq	$-0x10, %r10
movq	%r10, 0x28(%rsp)
jne	Laes_x86_64__1110
movq	0x38(%rsp), %rbp
movl	%eax, (%rbp)
movl	%ebx, 0x4(%rbp)
movl	%ecx, 0x8(%rbp)
movl	%edx, 0xc(%rbp)
jmp	Laes_x86_64__12ac
nopw	%cs:(%rax,%rax)
Laes_x86_64__1180:
cmpq	%r8, %r9
je	Laes_x86_64__1210
movq	%rbp, 0x40(%rsp)
nop
Laes_x86_64__1190:
movl	(%r8), %eax
movl	0x4(%r8), %ebx
movl	0x8(%r8), %ecx
movl	0xc(%r8), %edx
movq	(%rsp), %r15
movq	%r8, 0x18(%rsp)
callq	_x86_64_AES_decrypt
movq	0x40(%rsp), %rbp
movq	0x18(%rsp), %r8
movq	0x28(%rsp), %r10
xorl	(%rbp), %eax
xorl	0x4(%rbp), %ebx
xorl	0x8(%rbp), %ecx
xorl	0xc(%rbp), %edx
movq	%r8, %rbp
subq	$0x10, %r10
movq	%r10, 0x28(%rsp)
movq	%rbp, 0x40(%rsp)
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
leaq	0x10(%r8), %r8
leaq	0x10(%r9), %r9
jne	Laes_x86_64__1190
movq	0x38(%rsp), %r12
movq	(%rbp), %r10
movq	0x8(%rbp), %r11
movq	%r10, (%r12)
movq	%r11, 0x8(%r12)
jmp	Laes_x86_64__12ac
nopl	(%rax)
Laes_x86_64__1210:
movq	(%rbp), %r10
movq	0x8(%rbp), %r11
movq	%r10, 0x40(%rsp)
movq	%r11, 0x48(%rsp)
nop
Laes_x86_64__1224:
movl	(%r8), %eax
movl	0x4(%r8), %ebx
movl	0x8(%r8), %ecx
movl	0xc(%r8), %edx
movq	(%rsp), %r15
movq	%r8, 0x18(%rsp)
callq	_x86_64_AES_decrypt
movq	0x18(%rsp), %r8
movq	0x28(%rsp), %r10
xorl	0x40(%rsp), %eax
xorl	0x44(%rsp), %ebx
xorl	0x48(%rsp), %ecx
xorl	0x4c(%rsp), %edx
movq	(%r8), %r11
movq	0x8(%r8), %r12
subq	$0x10, %r10
je	Laes_x86_64__1290
movq	%r11, 0x40(%rsp)
movq	%r12, 0x48(%rsp)
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
leaq	0x10(%r8), %r8
leaq	0x10(%r9), %r9
movq	%r10, 0x28(%rsp)
jmp	Laes_x86_64__1224
Laes_x86_64__1290:
movq	0x38(%rsp), %rdi
movq	%r11, (%rdi)
movq	%r12, 0x8(%rdi)
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
nop
Laes_x86_64__12ac:
cmpl	$0x0, 0x140(%rsp)
leaq	0x50(%rsp), %rdi
je	Laes_x86_64__1510
movl	$0x1e, %ecx
xorq	%rax, %rax
rep	stosq	%rax, %es:(%rdi)
nop
jmp	Laes_x86_64__1510
Laes_x86_64__12d0:
leaq	-0x58(%rsp), %rbp
andq	$-0x40, %rbp
leaq	-0x97(%rcx), %r10
subq	%rbp, %r10
negq	%r10
andq	$0x3c0, %r10
subq	%r10, %rbp
xchgq	%rsp, %rbp
movq	%rbp, 0x10(%rsp)
movq	%r8, 0x38(%rsp)
movq	%r8, %rbp
movq	%r9, %rbx
movq	%rsi, %r9
movq	%rdi, %r8
movq	%rcx, %r15
movq	%rdx, %r10
movl	0xf0(%r15), %eax
movq	%r15, (%rsp)
shll	$0x4, %eax
leaq	(%r15,%rax), %rax
movq	%rax, 0x8(%rsp)
leaq	0x800(%r14), %r14
leaq	0x2f8(%rsp), %rax
subq	%r14, %rax
andq	$0x300, %rax
leaq	(%r14,%rax), %r14
cmpq	$0x0, %rbx
je	Laes_x86_64__1420
testq	$-0x10, %r10
movl	(%rbp), %eax
movl	0x4(%rbp), %ebx
movl	0x8(%rbp), %ecx
movl	0xc(%rbp), %edx
je	Laes_x86_64__13e0
nopl	(%rax)
Laes_x86_64__1364:
xorl	(%r8), %eax
xorl	0x4(%r8), %ebx
xorl	0x8(%r8), %ecx
xorl	0xc(%r8), %edx
movq	(%rsp), %r15
movq	%r8, 0x18(%rsp)
movq	%r9, 0x20(%rsp)
movq	%r10, 0x28(%rsp)
callq	_x86_64_AES_encrypt_compact
movq	0x18(%rsp), %r8
movq	0x20(%rsp), %r9
movq	0x28(%rsp), %r10
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
leaq	0x10(%r8), %r8
leaq	0x10(%r9), %r9
subq	$0x10, %r10
testq	$-0x10, %r10
jne	Laes_x86_64__1364
testq	$0xf, %r10
jne	Laes_x86_64__13e0
movq	0x38(%rsp), %rbp
movl	%eax, (%rbp)
movl	%ebx, 0x4(%rbp)
movl	%ecx, 0x8(%rbp)
movl	%edx, 0xc(%rbp)
jmp	Laes_x86_64__1510
nopl	(%rax)
Laes_x86_64__13e0:
movq	%rax, %r11
movq	%rcx, %r12
movq	%r10, %rcx
movq	%r8, %rsi
movq	%r9, %rdi
rep	movsb	(%rsi), %es:(%rdi)
nop
movq	$0x10, %rcx
subq	%r10, %rcx
xorq	%rax, %rax
rep	stosb	%al, %es:(%rdi)
nop
movq	%r9, %r8
movq	$0x10, %r10
movq	%r11, %rax
movq	%r12, %rcx
jmp	Laes_x86_64__1364
nopl	(%rax)
Laes_x86_64__1420:
shrq	$0x3, %rax
addq	%rax, %r14
movq	(%rbp), %r11
movq	0x8(%rbp), %r12
movq	%r11, 0x40(%rsp)
movq	%r12, 0x48(%rsp)
nopl	(%rax)
Laes_x86_64__143c:
movl	(%r8), %eax
movl	0x4(%r8), %ebx
movl	0x8(%r8), %ecx
movl	0xc(%r8), %edx
movq	(%rsp), %r15
movq	%r8, 0x18(%rsp)
movq	%r9, 0x20(%rsp)
movq	%r10, 0x28(%rsp)
callq	_x86_64_AES_decrypt_compact
movq	0x18(%rsp), %r8
movq	0x20(%rsp), %r9
movq	0x28(%rsp), %r10
xorl	0x40(%rsp), %eax
xorl	0x44(%rsp), %ebx
xorl	0x48(%rsp), %ecx
xorl	0x4c(%rsp), %edx
movq	(%r8), %r11
movq	0x8(%r8), %r12
subq	$0x10, %r10
jb	Laes_x86_64__14d4
je	Laes_x86_64__14b4
movq	%r11, 0x40(%rsp)
movq	%r12, 0x48(%rsp)
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
leaq	0x10(%r8), %r8
leaq	0x10(%r9), %r9
jmp	Laes_x86_64__143c
Laes_x86_64__14b4:
movq	0x38(%rsp), %rdi
movq	%r11, (%rdi)
movq	%r12, 0x8(%rdi)
movl	%eax, (%r9)
movl	%ebx, 0x4(%r9)
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
jmp	Laes_x86_64__1510
nopl	(%rax)
Laes_x86_64__14d4:
movq	0x38(%rsp), %rdi
movq	%r11, (%rdi)
movq	%r12, 0x8(%rdi)
movl	%eax, 0x40(%rsp)
movl	%ebx, 0x44(%rsp)
movl	%ecx, 0x48(%rsp)
movl	%edx, 0x4c(%rsp)
movq	%r9, %rdi
leaq	0x40(%rsp), %rsi
leaq	0x10(%r10), %rcx
rep	movsb	(%rsi), %es:(%rdi)
nop
jmp	Laes_x86_64__1510
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Laes_x86_64__1510:
movq	0x10(%rsp), %rsi
movq	(%rsi), %r15
movq	0x8(%rsi), %r14
movq	0x10(%rsi), %r13
movq	0x18(%rsi), %r12
movq	0x20(%rsi), %rbp
movq	0x28(%rsi), %rbx
leaq	0x30(%rsi), %rsp
popfq
Laes_x86_64__1531:
rep	retq
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 198,99,99,165,198,99,99,165,248,124,124,132,248,124,124,132
	.byte 238,119,119,153,238,119,119,153,246,123,123,141,246,123,123,141
	.byte 255,242,242,13,255,242,242,13,214,107,107,189,214,107,107,189
	.byte 222,111,111,177,222,111,111,177,145,197,197,84,145,197,197,84
	.byte 96,48,48,80,96,48,48,80,2,1,1,3,2,1,1,3
	.byte 206,103,103,169,206,103,103,169,86,43,43,125,86,43,43,125
	.byte 231,254,254,25,231,254,254,25,181,215,215,98,181,215,215,98
	.byte 77,171,171,230,77,171,171,230,236,118,118,154,236,118,118,154
	.byte 143,202,202,69,143,202,202,69,31,130,130,157,31,130,130,157
	.byte 137,201,201,64,137,201,201,64,250,125,125,135,250,125,125,135
	.byte 239,250,250,21,239,250,250,21,178,89,89,235,178,89,89,235
	.byte 142,71,71,201,142,71,71,201,251,240,240,11,251,240,240,11
	.byte 65,173,173,236,65,173,173,236,179,212,212,103,179,212,212,103
	.byte 95,162,162,253,95,162,162,253,69,175,175,234,69,175,175,234
	.byte 35,156,156,191,35,156,156,191,83,164,164,247,83,164,164,247
	.byte 228,114,114,150,228,114,114,150,155,192,192,91,155,192,192,91
	.byte 117,183,183,194,117,183,183,194,225,253,253,28,225,253,253,28
	.byte 61,147,147,174,61,147,147,174,76,38,38,106,76,38,38,106
	.byte 108,54,54,90,108,54,54,90,126,63,63,65,126,63,63,65
	.byte 245,247,247,2,245,247,247,2,131,204,204,79,131,204,204,79
	.byte 104,52,52,92,104,52,52,92,81,165,165,244,81,165,165,244
	.byte 209,229,229,52,209,229,229,52,249,241,241,8,249,241,241,8
	.byte 226,113,113,147,226,113,113,147,171,216,216,115,171,216,216,115
	.byte 98,49,49,83,98,49,49,83,42,21,21,63,42,21,21,63
	.byte 8,4,4,12,8,4,4,12,149,199,199,82,149,199,199,82
	.byte 70,35,35,101,70,35,35,101,157,195,195,94,157,195,195,94
	.byte 48,24,24,40,48,24,24,40,55,150,150,161,55,150,150,161
	.byte 10,5,5,15,10,5,5,15,47,154,154,181,47,154,154,181
	.byte 14,7,7,9,14,7,7,9,36,18,18,54,36,18,18,54
	.byte 27,128,128,155,27,128,128,155,223,226,226,61,223,226,226,61
	.byte 205,235,235,38,205,235,235,38,78,39,39,105,78,39,39,105
	.byte 127,178,178,205,127,178,178,205,234,117,117,159,234,117,117,159
	.byte 18,9,9,27,18,9,9,27,29,131,131,158,29,131,131,158
	.byte 88,44,44,116,88,44,44,116,52,26,26,46,52,26,26,46
	.byte 54,27,27,45,54,27,27,45,220,110,110,178,220,110,110,178
	.byte 180,90,90,238,180,90,90,238,91,160,160,251,91,160,160,251
	.byte 164,82,82,246,164,82,82,246,118,59,59,77,118,59,59,77
	.byte 183,214,214,97,183,214,214,97,125,179,179,206,125,179,179,206
	.byte 82,41,41,123,82,41,41,123,221,227,227,62,221,227,227,62
	.byte 94,47,47,113,94,47,47,113,19,132,132,151,19,132,132,151
	.byte 166,83,83,245,166,83,83,245,185,209,209,104,185,209,209,104
	.byte 0,0,0,0,0,0,0,0,193,237,237,44,193,237,237,44
	.byte 64,32,32,96,64,32,32,96,227,252,252,31,227,252,252,31
	.byte 121,177,177,200,121,177,177,200,182,91,91,237,182,91,91,237
	.byte 212,106,106,190,212,106,106,190,141,203,203,70,141,203,203,70
	.byte 103,190,190,217,103,190,190,217,114,57,57,75,114,57,57,75
	.byte 148,74,74,222,148,74,74,222,152,76,76,212,152,76,76,212
	.byte 176,88,88,232,176,88,88,232,133,207,207,74,133,207,207,74
	.byte 187,208,208,107,187,208,208,107,197,239,239,42,197,239,239,42
	.byte 79,170,170,229,79,170,170,229,237,251,251,22,237,251,251,22
	.byte 134,67,67,197,134,67,67,197,154,77,77,215,154,77,77,215
	.byte 102,51,51,85,102,51,51,85,17,133,133,148,17,133,133,148
	.byte 138,69,69,207,138,69,69,207,233,249,249,16,233,249,249,16
	.byte 4,2,2,6,4,2,2,6,254,127,127,129,254,127,127,129
	.byte 160,80,80,240,160,80,80,240,120,60,60,68,120,60,60,68
	.byte 37,159,159,186,37,159,159,186,75,168,168,227,75,168,168,227
	.byte 162,81,81,243,162,81,81,243,93,163,163,254,93,163,163,254
	.byte 128,64,64,192,128,64,64,192,5,143,143,138,5,143,143,138
	.byte 63,146,146,173,63,146,146,173,33,157,157,188,33,157,157,188
	.byte 112,56,56,72,112,56,56,72,241,245,245,4,241,245,245,4
	.byte 99,188,188,223,99,188,188,223,119,182,182,193,119,182,182,193
	.byte 175,218,218,117,175,218,218,117,66,33,33,99,66,33,33,99
	.byte 32,16,16,48,32,16,16,48,229,255,255,26,229,255,255,26
	.byte 253,243,243,14,253,243,243,14,191,210,210,109,191,210,210,109
	.byte 129,205,205,76,129,205,205,76,24,12,12,20,24,12,12,20
	.byte 38,19,19,53,38,19,19,53,195,236,236,47,195,236,236,47
	.byte 190,95,95,225,190,95,95,225,53,151,151,162,53,151,151,162
	.byte 136,68,68,204,136,68,68,204,46,23,23,57,46,23,23,57
	.byte 147,196,196,87,147,196,196,87,85,167,167,242,85,167,167,242
	.byte 252,126,126,130,252,126,126,130,122,61,61,71,122,61,61,71
	.byte 200,100,100,172,200,100,100,172,186,93,93,231,186,93,93,231
	.byte 50,25,25,43,50,25,25,43,230,115,115,149,230,115,115,149
	.byte 192,96,96,160,192,96,96,160,25,129,129,152,25,129,129,152
	.byte 158,79,79,209,158,79,79,209,163,220,220,127,163,220,220,127
	.byte 68,34,34,102,68,34,34,102,84,42,42,126,84,42,42,126
	.byte 59,144,144,171,59,144,144,171,11,136,136,131,11,136,136,131
	.byte 140,70,70,202,140,70,70,202,199,238,238,41,199,238,238,41
	.byte 107,184,184,211,107,184,184,211,40,20,20,60,40,20,20,60
	.byte 167,222,222,121,167,222,222,121,188,94,94,226,188,94,94,226
	.byte 22,11,11,29,22,11,11,29,173,219,219,118,173,219,219,118
	.byte 219,224,224,59,219,224,224,59,100,50,50,86,100,50,50,86
	.byte 116,58,58,78,116,58,58,78,20,10,10,30,20,10,10,30
	.byte 146,73,73,219,146,73,73,219,12,6,6,10,12,6,6,10
	.byte 72,36,36,108,72,36,36,108,184,92,92,228,184,92,92,228
	.byte 159,194,194,93,159,194,194,93,189,211,211,110,189,211,211,110
	.byte 67,172,172,239,67,172,172,239,196,98,98,166,196,98,98,166
	.byte 57,145,145,168,57,145,145,168,49,149,149,164,49,149,149,164
	.byte 211,228,228,55,211,228,228,55,242,121,121,139,242,121,121,139
	.byte 213,231,231,50,213,231,231,50,139,200,200,67,139,200,200,67
	.byte 110,55,55,89,110,55,55,89,218,109,109,183,218,109,109,183
	.byte 1,141,141,140,1,141,141,140,177,213,213,100,177,213,213,100
	.byte 156,78,78,210,156,78,78,210,73,169,169,224,73,169,169,224
	.byte 216,108,108,180,216,108,108,180,172,86,86,250,172,86,86,250
	.byte 243,244,244,7,243,244,244,7,207,234,234,37,207,234,234,37
	.byte 202,101,101,175,202,101,101,175,244,122,122,142,244,122,122,142
	.byte 71,174,174,233,71,174,174,233,16,8,8,24,16,8,8,24
	.byte 111,186,186,213,111,186,186,213,240,120,120,136,240,120,120,136
	.byte 74,37,37,111,74,37,37,111,92,46,46,114,92,46,46,114
	.byte 56,28,28,36,56,28,28,36,87,166,166,241,87,166,166,241
	.byte 115,180,180,199,115,180,180,199,151,198,198,81,151,198,198,81
	.byte 203,232,232,35,203,232,232,35,161,221,221,124,161,221,221,124
	.byte 232,116,116,156,232,116,116,156,62,31,31,33,62,31,31,33
	.byte 150,75,75,221,150,75,75,221,97,189,189,220,97,189,189,220
	.byte 13,139,139,134,13,139,139,134,15,138,138,133,15,138,138,133
	.byte 224,112,112,144,224,112,112,144,124,62,62,66,124,62,62,66
	.byte 113,181,181,196,113,181,181,196,204,102,102,170,204,102,102,170
	.byte 144,72,72,216,144,72,72,216,6,3,3,5,6,3,3,5
	.byte 247,246,246,1,247,246,246,1,28,14,14,18,28,14,14,18
	.byte 194,97,97,163,194,97,97,163,106,53,53,95,106,53,53,95
	.byte 174,87,87,249,174,87,87,249,105,185,185,208,105,185,185,208
	.byte 23,134,134,145,23,134,134,145,153,193,193,88,153,193,193,88
	.byte 58,29,29,39,58,29,29,39,39,158,158,185,39,158,158,185
	.byte 217,225,225,56,217,225,225,56,235,248,248,19,235,248,248,19
	.byte 43,152,152,179,43,152,152,179,34,17,17,51,34,17,17,51
	.byte 210,105,105,187,210,105,105,187,169,217,217,112,169,217,217,112
	.byte 7,142,142,137,7,142,142,137,51,148,148,167,51,148,148,167
	.byte 45,155,155,182,45,155,155,182,60,30,30,34,60,30,30,34
	.byte 21,135,135,146,21,135,135,146,201,233,233,32,201,233,233,32
	.byte 135,206,206,73,135,206,206,73,170,85,85,255,170,85,85,255
	.byte 80,40,40,120,80,40,40,120,165,223,223,122,165,223,223,122
	.byte 3,140,140,143,3,140,140,143,89,161,161,248,89,161,161,248
	.byte 9,137,137,128,9,137,137,128,26,13,13,23,26,13,13,23
	.byte 101,191,191,218,101,191,191,218,215,230,230,49,215,230,230,49
	.byte 132,66,66,198,132,66,66,198,208,104,104,184,208,104,104,184
	.byte 130,65,65,195,130,65,65,195,41,153,153,176,41,153,153,176
	.byte 90,45,45,119,90,45,45,119,30,15,15,17,30,15,15,17
	.byte 123,176,176,203,123,176,176,203,168,84,84,252,168,84,84,252
	.byte 109,187,187,214,109,187,187,214,44,22,22,58,44,22,22,58
	.byte 99,124,119,123,242,107,111,197,48,1,103,43,254,215,171,118
	.byte 202,130,201,125,250,89,71,240,173,212,162,175,156,164,114,192
	.byte 183,253,147,38,54,63,247,204,52,165,229,241,113,216,49,21
	.byte 4,199,35,195,24,150,5,154,7,18,128,226,235,39,178,117
	.byte 9,131,44,26,27,110,90,160,82,59,214,179,41,227,47,132
	.byte 83,209,0,237,32,252,177,91,106,203,190,57,74,76,88,207
	.byte 208,239,170,251,67,77,51,133,69,249,2,127,80,60,159,168
	.byte 81,163,64,143,146,157,56,245,188,182,218,33,16,255,243,210
	.byte 205,12,19,236,95,151,68,23,196,167,126,61,100,93,25,115
	.byte 96,129,79,220,34,42,144,136,70,238,184,20,222,94,11,219
	.byte 224,50,58,10,73,6,36,92,194,211,172,98,145,149,228,121
	.byte 231,200,55,109,141,213,78,169,108,86,244,234,101,122,174,8
	.byte 186,120,37,46,28,166,180,198,232,221,116,31,75,189,139,138
	.byte 112,62,181,102,72,3,246,14,97,53,87,185,134,193,29,158
	.byte 225,248,152,17,105,217,142,148,155,30,135,233,206,85,40,223
	.byte 140,161,137,13,191,230,66,104,65,153,45,15,176,84,187,22
	.byte 99,124,119,123,242,107,111,197,48,1,103,43,254,215,171,118
	.byte 202,130,201,125,250,89,71,240,173,212,162,175,156,164,114,192
	.byte 183,253,147,38,54,63,247,204,52,165,229,241,113,216,49,21
	.byte 4,199,35,195,24,150,5,154,7,18,128,226,235,39,178,117
	.byte 9,131,44,26,27,110,90,160,82,59,214,179,41,227,47,132
	.byte 83,209,0,237,32,252,177,91,106,203,190,57,74,76,88,207
	.byte 208,239,170,251,67,77,51,133,69,249,2,127,80,60,159,168
	.byte 81,163,64,143,146,157,56,245,188,182,218,33,16,255,243,210
	.byte 205,12,19,236,95,151,68,23,196,167,126,61,100,93,25,115
	.byte 96,129,79,220,34,42,144,136,70,238,184,20,222,94,11,219
	.byte 224,50,58,10,73,6,36,92,194,211,172,98,145,149,228,121
	.byte 231,200,55,109,141,213,78,169,108,86,244,234,101,122,174,8
	.byte 186,120,37,46,28,166,180,198,232,221,116,31,75,189,139,138
	.byte 112,62,181,102,72,3,246,14,97,53,87,185,134,193,29,158
	.byte 225,248,152,17,105,217,142,148,155,30,135,233,206,85,40,223
	.byte 140,161,137,13,191,230,66,104,65,153,45,15,176,84,187,22
	.byte 99,124,119,123,242,107,111,197,48,1,103,43,254,215,171,118
	.byte 202,130,201,125,250,89,71,240,173,212,162,175,156,164,114,192
	.byte 183,253,147,38,54,63,247,204,52,165,229,241,113,216,49,21
	.byte 4,199,35,195,24,150,5,154,7,18,128,226,235,39,178,117
	.byte 9,131,44,26,27,110,90,160,82,59,214,179,41,227,47,132
	.byte 83,209,0,237,32,252,177,91,106,203,190,57,74,76,88,207
	.byte 208,239,170,251,67,77,51,133,69,249,2,127,80,60,159,168
	.byte 81,163,64,143,146,157,56,245,188,182,218,33,16,255,243,210
	.byte 205,12,19,236,95,151,68,23,196,167,126,61,100,93,25,115
	.byte 96,129,79,220,34,42,144,136,70,238,184,20,222,94,11,219
	.byte 224,50,58,10,73,6,36,92,194,211,172,98,145,149,228,121
	.byte 231,200,55,109,141,213,78,169,108,86,244,234,101,122,174,8
	.byte 186,120,37,46,28,166,180,198,232,221,116,31,75,189,139,138
	.byte 112,62,181,102,72,3,246,14,97,53,87,185,134,193,29,158
	.byte 225,248,152,17,105,217,142,148,155,30,135,233,206,85,40,223
	.byte 140,161,137,13,191,230,66,104,65,153,45,15,176,84,187,22
	.byte 99,124,119,123,242,107,111,197,48,1,103,43,254,215,171,118
	.byte 202,130,201,125,250,89,71,240,173,212,162,175,156,164,114,192
	.byte 183,253,147,38,54,63,247,204,52,165,229,241,113,216,49,21
	.byte 4,199,35,195,24,150,5,154,7,18,128,226,235,39,178,117
	.byte 9,131,44,26,27,110,90,160,82,59,214,179,41,227,47,132
	.byte 83,209,0,237,32,252,177,91,106,203,190,57,74,76,88,207
	.byte 208,239,170,251,67,77,51,133,69,249,2,127,80,60,159,168
	.byte 81,163,64,143,146,157,56,245,188,182,218,33,16,255,243,210
	.byte 205,12,19,236,95,151,68,23,196,167,126,61,100,93,25,115
	.byte 96,129,79,220,34,42,144,136,70,238,184,20,222,94,11,219
	.byte 224,50,58,10,73,6,36,92,194,211,172,98,145,149,228,121
	.byte 231,200,55,109,141,213,78,169,108,86,244,234,101,122,174,8
	.byte 186,120,37,46,28,166,180,198,232,221,116,31,75,189,139,138
	.byte 112,62,181,102,72,3,246,14,97,53,87,185,134,193,29,158
	.byte 225,248,152,17,105,217,142,148,155,30,135,233,206,85,40,223
	.byte 140,161,137,13,191,230,66,104,65,153,45,15,176,84,187,22
	.byte 1,0,0,0,2,0,0,0,4,0,0,0,8,0,0,0
	.byte 16,0,0,0,32,0,0,0,64,0,0,0,128,0,0,0
	.byte 27,0,0,0,54,0,0,0,128,128,128,128,128,128,128,128
	.byte 254,254,254,254,254,254,254,254,27,27,27,27,27,27,27,27
	.byte 81,244,167,80,81,244,167,80,126,65,101,83,126,65,101,83
	.byte 26,23,164,195,26,23,164,195,58,39,94,150,58,39,94,150
	.byte 59,171,107,203,59,171,107,203,31,157,69,241,31,157,69,241
	.byte 172,250,88,171,172,250,88,171,75,227,3,147,75,227,3,147
	.byte 32,48,250,85,32,48,250,85,173,118,109,246,173,118,109,246
	.byte 136,204,118,145,136,204,118,145,245,2,76,37,245,2,76,37
	.byte 79,229,215,252,79,229,215,252,197,42,203,215,197,42,203,215
	.byte 38,53,68,128,38,53,68,128,181,98,163,143,181,98,163,143
	.byte 222,177,90,73,222,177,90,73,37,186,27,103,37,186,27,103
	.byte 69,234,14,152,69,234,14,152,93,254,192,225,93,254,192,225
	.byte 195,47,117,2,195,47,117,2,129,76,240,18,129,76,240,18
	.byte 141,70,151,163,141,70,151,163,107,211,249,198,107,211,249,198
	.byte 3,143,95,231,3,143,95,231,21,146,156,149,21,146,156,149
	.byte 191,109,122,235,191,109,122,235,149,82,89,218,149,82,89,218
	.byte 212,190,131,45,212,190,131,45,88,116,33,211,88,116,33,211
	.byte 73,224,105,41,73,224,105,41,142,201,200,68,142,201,200,68
	.byte 117,194,137,106,117,194,137,106,244,142,121,120,244,142,121,120
	.byte 153,88,62,107,153,88,62,107,39,185,113,221,39,185,113,221
	.byte 190,225,79,182,190,225,79,182,240,136,173,23,240,136,173,23
	.byte 201,32,172,102,201,32,172,102,125,206,58,180,125,206,58,180
	.byte 99,223,74,24,99,223,74,24,229,26,49,130,229,26,49,130
	.byte 151,81,51,96,151,81,51,96,98,83,127,69,98,83,127,69
	.byte 177,100,119,224,177,100,119,224,187,107,174,132,187,107,174,132
	.byte 254,129,160,28,254,129,160,28,249,8,43,148,249,8,43,148
	.byte 112,72,104,88,112,72,104,88,143,69,253,25,143,69,253,25
	.byte 148,222,108,135,148,222,108,135,82,123,248,183,82,123,248,183
	.byte 171,115,211,35,171,115,211,35,114,75,2,226,114,75,2,226
	.byte 227,31,143,87,227,31,143,87,102,85,171,42,102,85,171,42
	.byte 178,235,40,7,178,235,40,7,47,181,194,3,47,181,194,3
	.byte 134,197,123,154,134,197,123,154,211,55,8,165,211,55,8,165
	.byte 48,40,135,242,48,40,135,242,35,191,165,178,35,191,165,178
	.byte 2,3,106,186,2,3,106,186,237,22,130,92,237,22,130,92
	.byte 138,207,28,43,138,207,28,43,167,121,180,146,167,121,180,146
	.byte 243,7,242,240,243,7,242,240,78,105,226,161,78,105,226,161
	.byte 101,218,244,205,101,218,244,205,6,5,190,213,6,5,190,213
	.byte 209,52,98,31,209,52,98,31,196,166,254,138,196,166,254,138
	.byte 52,46,83,157,52,46,83,157,162,243,85,160,162,243,85,160
	.byte 5,138,225,50,5,138,225,50,164,246,235,117,164,246,235,117
	.byte 11,131,236,57,11,131,236,57,64,96,239,170,64,96,239,170
	.byte 94,113,159,6,94,113,159,6,189,110,16,81,189,110,16,81
	.byte 62,33,138,249,62,33,138,249,150,221,6,61,150,221,6,61
	.byte 221,62,5,174,221,62,5,174,77,230,189,70,77,230,189,70
	.byte 145,84,141,181,145,84,141,181,113,196,93,5,113,196,93,5
	.byte 4,6,212,111,4,6,212,111,96,80,21,255,96,80,21,255
	.byte 25,152,251,36,25,152,251,36,214,189,233,151,214,189,233,151
	.byte 137,64,67,204,137,64,67,204,103,217,158,119,103,217,158,119
	.byte 176,232,66,189,176,232,66,189,7,137,139,136,7,137,139,136
	.byte 231,25,91,56,231,25,91,56,121,200,238,219,121,200,238,219
	.byte 161,124,10,71,161,124,10,71,124,66,15,233,124,66,15,233
	.byte 248,132,30,201,248,132,30,201,0,0,0,0,0,0,0,0
	.byte 9,128,134,131,9,128,134,131,50,43,237,72,50,43,237,72
	.byte 30,17,112,172,30,17,112,172,108,90,114,78,108,90,114,78
	.byte 253,14,255,251,253,14,255,251,15,133,56,86,15,133,56,86
	.byte 61,174,213,30,61,174,213,30,54,45,57,39,54,45,57,39
	.byte 10,15,217,100,10,15,217,100,104,92,166,33,104,92,166,33
	.byte 155,91,84,209,155,91,84,209,36,54,46,58,36,54,46,58
	.byte 12,10,103,177,12,10,103,177,147,87,231,15,147,87,231,15
	.byte 180,238,150,210,180,238,150,210,27,155,145,158,27,155,145,158
	.byte 128,192,197,79,128,192,197,79,97,220,32,162,97,220,32,162
	.byte 90,119,75,105,90,119,75,105,28,18,26,22,28,18,26,22
	.byte 226,147,186,10,226,147,186,10,192,160,42,229,192,160,42,229
	.byte 60,34,224,67,60,34,224,67,18,27,23,29,18,27,23,29
	.byte 14,9,13,11,14,9,13,11,242,139,199,173,242,139,199,173
	.byte 45,182,168,185,45,182,168,185,20,30,169,200,20,30,169,200
	.byte 87,241,25,133,87,241,25,133,175,117,7,76,175,117,7,76
	.byte 238,153,221,187,238,153,221,187,163,127,96,253,163,127,96,253
	.byte 247,1,38,159,247,1,38,159,92,114,245,188,92,114,245,188
	.byte 68,102,59,197,68,102,59,197,91,251,126,52,91,251,126,52
	.byte 139,67,41,118,139,67,41,118,203,35,198,220,203,35,198,220
	.byte 182,237,252,104,182,237,252,104,184,228,241,99,184,228,241,99
	.byte 215,49,220,202,215,49,220,202,66,99,133,16,66,99,133,16
	.byte 19,151,34,64,19,151,34,64,132,198,17,32,132,198,17,32
	.byte 133,74,36,125,133,74,36,125,210,187,61,248,210,187,61,248
	.byte 174,249,50,17,174,249,50,17,199,41,161,109,199,41,161,109
	.byte 29,158,47,75,29,158,47,75,220,178,48,243,220,178,48,243
	.byte 13,134,82,236,13,134,82,236,119,193,227,208,119,193,227,208
	.byte 43,179,22,108,43,179,22,108,169,112,185,153,169,112,185,153
	.byte 17,148,72,250,17,148,72,250,71,233,100,34,71,233,100,34
	.byte 168,252,140,196,168,252,140,196,160,240,63,26,160,240,63,26
	.byte 86,125,44,216,86,125,44,216,34,51,144,239,34,51,144,239
	.byte 135,73,78,199,135,73,78,199,217,56,209,193,217,56,209,193
	.byte 140,202,162,254,140,202,162,254,152,212,11,54,152,212,11,54
	.byte 166,245,129,207,166,245,129,207,165,122,222,40,165,122,222,40
	.byte 218,183,142,38,218,183,142,38,63,173,191,164,63,173,191,164
	.byte 44,58,157,228,44,58,157,228,80,120,146,13,80,120,146,13
	.byte 106,95,204,155,106,95,204,155,84,126,70,98,84,126,70,98
	.byte 246,141,19,194,246,141,19,194,144,216,184,232,144,216,184,232
	.byte 46,57,247,94,46,57,247,94,130,195,175,245,130,195,175,245
	.byte 159,93,128,190,159,93,128,190,105,208,147,124,105,208,147,124
	.byte 111,213,45,169,111,213,45,169,207,37,18,179,207,37,18,179
	.byte 200,172,153,59,200,172,153,59,16,24,125,167,16,24,125,167
	.byte 232,156,99,110,232,156,99,110,219,59,187,123,219,59,187,123
	.byte 205,38,120,9,205,38,120,9,110,89,24,244,110,89,24,244
	.byte 236,154,183,1,236,154,183,1,131,79,154,168,131,79,154,168
	.byte 230,149,110,101,230,149,110,101,170,255,230,126,170,255,230,126
	.byte 33,188,207,8,33,188,207,8,239,21,232,230,239,21,232,230
	.byte 186,231,155,217,186,231,155,217,74,111,54,206,74,111,54,206
	.byte 234,159,9,212,234,159,9,212,41,176,124,214,41,176,124,214
	.byte 49,164,178,175,49,164,178,175,42,63,35,49,42,63,35,49
	.byte 198,165,148,48,198,165,148,48,53,162,102,192,53,162,102,192
	.byte 116,78,188,55,116,78,188,55,252,130,202,166,252,130,202,166
	.byte 224,144,208,176,224,144,208,176,51,167,216,21,51,167,216,21
	.byte 241,4,152,74,241,4,152,74,65,236,218,247,65,236,218,247
	.byte 127,205,80,14,127,205,80,14,23,145,246,47,23,145,246,47
	.byte 118,77,214,141,118,77,214,141,67,239,176,77,67,239,176,77
	.byte 204,170,77,84,204,170,77,84,228,150,4,223,228,150,4,223
	.byte 158,209,181,227,158,209,181,227,76,106,136,27,76,106,136,27
	.byte 193,44,31,184,193,44,31,184,70,101,81,127,70,101,81,127
	.byte 157,94,234,4,157,94,234,4,1,140,53,93,1,140,53,93
	.byte 250,135,116,115,250,135,116,115,251,11,65,46,251,11,65,46
	.byte 179,103,29,90,179,103,29,90,146,219,210,82,146,219,210,82
	.byte 233,16,86,51,233,16,86,51,109,214,71,19,109,214,71,19
	.byte 154,215,97,140,154,215,97,140,55,161,12,122,55,161,12,122
	.byte 89,248,20,142,89,248,20,142,235,19,60,137,235,19,60,137
	.byte 206,169,39,238,206,169,39,238,183,97,201,53,183,97,201,53
	.byte 225,28,229,237,225,28,229,237,122,71,177,60,122,71,177,60
	.byte 156,210,223,89,156,210,223,89,85,242,115,63,85,242,115,63
	.byte 24,20,206,121,24,20,206,121,115,199,55,191,115,199,55,191
	.byte 83,247,205,234,83,247,205,234,95,253,170,91,95,253,170,91
	.byte 223,61,111,20,223,61,111,20,120,68,219,134,120,68,219,134
	.byte 202,175,243,129,202,175,243,129,185,104,196,62,185,104,196,62
	.byte 56,36,52,44,56,36,52,44,194,163,64,95,194,163,64,95
	.byte 22,29,195,114,22,29,195,114,188,226,37,12,188,226,37,12
	.byte 40,60,73,139,40,60,73,139,255,13,149,65,255,13,149,65
	.byte 57,168,1,113,57,168,1,113,8,12,179,222,8,12,179,222
	.byte 216,180,228,156,216,180,228,156,100,86,193,144,100,86,193,144
	.byte 123,203,132,97,123,203,132,97,213,50,182,112,213,50,182,112
	.byte 72,108,92,116,72,108,92,116,208,184,87,66,208,184,87,66
	.byte 82,9,106,213,48,54,165,56,191,64,163,158,129,243,215,251
	.byte 124,227,57,130,155,47,255,135,52,142,67,68,196,222,233,203
	.byte 84,123,148,50,166,194,35,61,238,76,149,11,66,250,195,78
	.byte 8,46,161,102,40,217,36,178,118,91,162,73,109,139,209,37
	.byte 114,248,246,100,134,104,152,22,212,164,92,204,93,101,182,146
	.byte 108,112,72,80,253,237,185,218,94,21,70,87,167,141,157,132
	.byte 144,216,171,0,140,188,211,10,247,228,88,5,184,179,69,6
	.byte 208,44,30,143,202,63,15,2,193,175,189,3,1,19,138,107
	.byte 58,145,17,65,79,103,220,234,151,242,207,206,240,180,230,115
	.byte 150,172,116,34,231,173,53,133,226,249,55,232,28,117,223,110
	.byte 71,241,26,113,29,41,197,137,111,183,98,14,170,24,190,27
	.byte 252,86,62,75,198,210,121,32,154,219,192,254,120,205,90,244
	.byte 31,221,168,51,136,7,199,49,177,18,16,89,39,128,236,95
	.byte 96,81,127,169,25,181,74,13,45,229,122,159,147,201,156,239
	.byte 160,224,59,77,174,42,245,176,200,235,187,60,131,83,153,97
	.byte 23,43,4,126,186,119,214,38,225,105,20,99,85,33,12,125
	.byte 128,128,128,128,128,128,128,128,254,254,254,254,254,254,254,254
	.byte 27,27,27,27,27,27,27,27,0,0,0,0,0,0,0,0
	.byte 82,9,106,213,48,54,165,56,191,64,163,158,129,243,215,251
	.byte 124,227,57,130,155,47,255,135,52,142,67,68,196,222,233,203
	.byte 84,123,148,50,166,194,35,61,238,76,149,11,66,250,195,78
	.byte 8,46,161,102,40,217,36,178,118,91,162,73,109,139,209,37
	.byte 114,248,246,100,134,104,152,22,212,164,92,204,93,101,182,146
	.byte 108,112,72,80,253,237,185,218,94,21,70,87,167,141,157,132
	.byte 144,216,171,0,140,188,211,10,247,228,88,5,184,179,69,6
	.byte 208,44,30,143,202,63,15,2,193,175,189,3,1,19,138,107
	.byte 58,145,17,65,79,103,220,234,151,242,207,206,240,180,230,115
	.byte 150,172,116,34,231,173,53,133,226,249,55,232,28,117,223,110
	.byte 71,241,26,113,29,41,197,137,111,183,98,14,170,24,190,27
	.byte 252,86,62,75,198,210,121,32,154,219,192,254,120,205,90,244
	.byte 31,221,168,51,136,7,199,49,177,18,16,89,39,128,236,95
	.byte 96,81,127,169,25,181,74,13,45,229,122,159,147,201,156,239
	.byte 160,224,59,77,174,42,245,176,200,235,187,60,131,83,153,97
	.byte 23,43,4,126,186,119,214,38,225,105,20,99,85,33,12,125
	.byte 128,128,128,128,128,128,128,128,254,254,254,254,254,254,254,254
	.byte 27,27,27,27,27,27,27,27,0,0,0,0,0,0,0,0
	.byte 82,9,106,213,48,54,165,56,191,64,163,158,129,243,215,251
	.byte 124,227,57,130,155,47,255,135,52,142,67,68,196,222,233,203
	.byte 84,123,148,50,166,194,35,61,238,76,149,11,66,250,195,78
	.byte 8,46,161,102,40,217,36,178,118,91,162,73,109,139,209,37
	.byte 114,248,246,100,134,104,152,22,212,164,92,204,93,101,182,146
	.byte 108,112,72,80,253,237,185,218,94,21,70,87,167,141,157,132
	.byte 144,216,171,0,140,188,211,10,247,228,88,5,184,179,69,6
	.byte 208,44,30,143,202,63,15,2,193,175,189,3,1,19,138,107
	.byte 58,145,17,65,79,103,220,234,151,242,207,206,240,180,230,115
	.byte 150,172,116,34,231,173,53,133,226,249,55,232,28,117,223,110
	.byte 71,241,26,113,29,41,197,137,111,183,98,14,170,24,190,27
	.byte 252,86,62,75,198,210,121,32,154,219,192,254,120,205,90,244
	.byte 31,221,168,51,136,7,199,49,177,18,16,89,39,128,236,95
	.byte 96,81,127,169,25,181,74,13,45,229,122,159,147,201,156,239
	.byte 160,224,59,77,174,42,245,176,200,235,187,60,131,83,153,97
	.byte 23,43,4,126,186,119,214,38,225,105,20,99,85,33,12,125
	.byte 128,128,128,128,128,128,128,128,254,254,254,254,254,254,254,254
	.byte 27,27,27,27,27,27,27,27,0,0,0,0,0,0,0,0
	.byte 82,9,106,213,48,54,165,56,191,64,163,158,129,243,215,251
	.byte 124,227,57,130,155,47,255,135,52,142,67,68,196,222,233,203
	.byte 84,123,148,50,166,194,35,61,238,76,149,11,66,250,195,78
	.byte 8,46,161,102,40,217,36,178,118,91,162,73,109,139,209,37
	.byte 114,248,246,100,134,104,152,22,212,164,92,204,93,101,182,146
	.byte 108,112,72,80,253,237,185,218,94,21,70,87,167,141,157,132
	.byte 144,216,171,0,140,188,211,10,247,228,88,5,184,179,69,6
	.byte 208,44,30,143,202,63,15,2,193,175,189,3,1,19,138,107
	.byte 58,145,17,65,79,103,220,234,151,242,207,206,240,180,230,115
	.byte 150,172,116,34,231,173,53,133,226,249,55,232,28,117,223,110
	.byte 71,241,26,113,29,41,197,137,111,183,98,14,170,24,190,27
	.byte 252,86,62,75,198,210,121,32,154,219,192,254,120,205,90,244
	.byte 31,221,168,51,136,7,199,49,177,18,16,89,39,128,236,95
	.byte 96,81,127,169,25,181,74,13,45,229,122,159,147,201,156,239
	.byte 160,224,59,77,174,42,245,176,200,235,187,60,131,83,153,97
	.byte 23,43,4,126,186,119,214,38,225,105,20,99,85,33,12,125
	.byte 128,128,128,128,128,128,128,128,254,254,254,254,254,254,254,254
	.byte 27,27,27,27,27,27,27,27,0,0,0,0,0,0,0,0
	.byte 65,69,83,32,102,111,114,32,120,56,54,95,54,52,44,32
	.byte 67,82,89,80,84,79,71,65,77,83,32,98,121,32,60,104
	.byte 116,116,112,115,58,47,47,103,105,116,104,117,98,46,99,111
	.byte 109,47,100,111,116,45,97,115,109,62,0,0,0,0,0,0
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

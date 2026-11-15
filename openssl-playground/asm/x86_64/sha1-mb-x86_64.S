	.text
sha1_multi_block:
movq	OPENSSL_ia32cap_P+4(%rip), %rcx
btq	$0x3d, %rcx
jb	_shaext_shortcut
testl	$0x10000000, %ecx
jne	_avx_shortcut
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
subq	$0x120, %rsp
andq	$-0x100, %rsp
movq	%rax, 0x110(%rsp)
leaq	K_XX_XX(%rip), %rbp
leaq	0x100(%rsp), %rbx
L_48:
movl	%edx, 0x118(%rsp)
xorl	%edx, %edx
movq	(%rsi), %r8
movl	0x8(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, (%rbx)
cmovleq	%rbp, %r8
movq	0x10(%rsi), %r9
movl	0x18(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x4(%rbx)
cmovleq	%rbp, %r9
movq	0x20(%rsi), %r10
movl	0x28(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x8(%rbx)
cmovleq	%rbp, %r10
movq	0x30(%rsi), %r11
movl	0x38(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0xc(%rbx)
cmovleq	%rbp, %r11
testl	%edx, %edx
je	L_2a98
movdqu	(%rdi), %xmm10
leaq	0x80(%rsp), %rax
movdqu	0x20(%rdi), %xmm11
movdqu	0x40(%rdi), %xmm12
movdqu	0x60(%rdi), %xmm13
movdqu	0x80(%rdi), %xmm14
movdqa	0x60(%rbp), %xmm5
movdqa	-0x20(%rbp), %xmm15
jmp	L_e0
L_e0:
movd	(%r8), %xmm0
leaq	0x40(%r8), %r8
movd	(%r9), %xmm2
leaq	0x40(%r9), %r9
movd	(%r10), %xmm3
leaq	0x40(%r10), %r10
movd	(%r11), %xmm4
leaq	0x40(%r11), %r11
punpckldq	%xmm3, %xmm0
movd	-0x3c(%r8), %xmm1
punpckldq	%xmm4, %xmm2
movd	-0x3c(%r9), %xmm9
punpckldq	%xmm2, %xmm0
movd	-0x3c(%r10), %xmm8
pshufb	%xmm5, %xmm0
movd	-0x3c(%r11), %xmm7
punpckldq	%xmm8, %xmm1
movdqa	%xmm10, %xmm8
paddd	%xmm15, %xmm14
punpckldq	%xmm7, %xmm9
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm13, %xmm7
pand	%xmm12, %xmm6
punpckldq	%xmm9, %xmm1
movdqa	%xmm10, %xmm9
movdqa	%xmm0, -0x80(%rax)
paddd	%xmm0, %xmm14
movd	-0x38(%r8), %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm11, %xmm7
por	%xmm9, %xmm8
movd	-0x38(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
pshufb	%xmm5, %xmm1
movd	-0x38(%r10), %xmm8
por	%xmm7, %xmm11
movd	-0x38(%r11), %xmm7
punpckldq	%xmm8, %xmm2
movdqa	%xmm14, %xmm8
paddd	%xmm15, %xmm13
punpckldq	%xmm7, %xmm9
movdqa	%xmm10, %xmm7
movdqa	%xmm10, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm12, %xmm7
pand	%xmm11, %xmm6
punpckldq	%xmm9, %xmm2
movdqa	%xmm14, %xmm9
movdqa	%xmm1, -0x70(%rax)
paddd	%xmm1, %xmm13
movd	-0x34(%r8), %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm10, %xmm7
por	%xmm9, %xmm8
movd	-0x34(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
pshufb	%xmm5, %xmm2
movd	-0x34(%r10), %xmm8
por	%xmm7, %xmm10
movd	-0x34(%r11), %xmm7
punpckldq	%xmm8, %xmm3
movdqa	%xmm13, %xmm8
paddd	%xmm15, %xmm12
punpckldq	%xmm7, %xmm9
movdqa	%xmm14, %xmm7
movdqa	%xmm14, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm11, %xmm7
pand	%xmm10, %xmm6
punpckldq	%xmm9, %xmm3
movdqa	%xmm13, %xmm9
movdqa	%xmm2, -0x60(%rax)
paddd	%xmm2, %xmm12
movd	-0x30(%r8), %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm14, %xmm7
por	%xmm9, %xmm8
movd	-0x30(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
pshufb	%xmm5, %xmm3
movd	-0x30(%r10), %xmm8
por	%xmm7, %xmm14
movd	-0x30(%r11), %xmm7
punpckldq	%xmm8, %xmm4
movdqa	%xmm12, %xmm8
paddd	%xmm15, %xmm11
punpckldq	%xmm7, %xmm9
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm10, %xmm7
pand	%xmm14, %xmm6
punpckldq	%xmm9, %xmm4
movdqa	%xmm12, %xmm9
movdqa	%xmm3, -0x50(%rax)
paddd	%xmm3, %xmm11
movd	-0x2c(%r8), %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm13, %xmm7
por	%xmm9, %xmm8
movd	-0x2c(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
pshufb	%xmm5, %xmm4
movd	-0x2c(%r10), %xmm8
por	%xmm7, %xmm13
movd	-0x2c(%r11), %xmm7
punpckldq	%xmm8, %xmm0
movdqa	%xmm11, %xmm8
paddd	%xmm15, %xmm10
punpckldq	%xmm7, %xmm9
movdqa	%xmm12, %xmm7
movdqa	%xmm12, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm14, %xmm7
pand	%xmm13, %xmm6
punpckldq	%xmm9, %xmm0
movdqa	%xmm11, %xmm9
movdqa	%xmm4, -0x40(%rax)
paddd	%xmm4, %xmm10
movd	-0x28(%r8), %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm12, %xmm7
por	%xmm9, %xmm8
movd	-0x28(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
pshufb	%xmm5, %xmm0
movd	-0x28(%r10), %xmm8
por	%xmm7, %xmm12
movd	-0x28(%r11), %xmm7
punpckldq	%xmm8, %xmm1
movdqa	%xmm10, %xmm8
paddd	%xmm15, %xmm14
punpckldq	%xmm7, %xmm9
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm13, %xmm7
pand	%xmm12, %xmm6
punpckldq	%xmm9, %xmm1
movdqa	%xmm10, %xmm9
movdqa	%xmm0, -0x30(%rax)
paddd	%xmm0, %xmm14
movd	-0x24(%r8), %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm11, %xmm7
por	%xmm9, %xmm8
movd	-0x24(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
pshufb	%xmm5, %xmm1
movd	-0x24(%r10), %xmm8
por	%xmm7, %xmm11
movd	-0x24(%r11), %xmm7
punpckldq	%xmm8, %xmm2
movdqa	%xmm14, %xmm8
paddd	%xmm15, %xmm13
punpckldq	%xmm7, %xmm9
movdqa	%xmm10, %xmm7
movdqa	%xmm10, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm12, %xmm7
pand	%xmm11, %xmm6
punpckldq	%xmm9, %xmm2
movdqa	%xmm14, %xmm9
movdqa	%xmm1, -0x20(%rax)
paddd	%xmm1, %xmm13
movd	-0x20(%r8), %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm10, %xmm7
por	%xmm9, %xmm8
movd	-0x20(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
pshufb	%xmm5, %xmm2
movd	-0x20(%r10), %xmm8
por	%xmm7, %xmm10
movd	-0x20(%r11), %xmm7
punpckldq	%xmm8, %xmm3
movdqa	%xmm13, %xmm8
paddd	%xmm15, %xmm12
punpckldq	%xmm7, %xmm9
movdqa	%xmm14, %xmm7
movdqa	%xmm14, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm11, %xmm7
pand	%xmm10, %xmm6
punpckldq	%xmm9, %xmm3
movdqa	%xmm13, %xmm9
movdqa	%xmm2, -0x10(%rax)
paddd	%xmm2, %xmm12
movd	-0x1c(%r8), %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm14, %xmm7
por	%xmm9, %xmm8
movd	-0x1c(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
pshufb	%xmm5, %xmm3
movd	-0x1c(%r10), %xmm8
por	%xmm7, %xmm14
movd	-0x1c(%r11), %xmm7
punpckldq	%xmm8, %xmm4
movdqa	%xmm12, %xmm8
paddd	%xmm15, %xmm11
punpckldq	%xmm7, %xmm9
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm10, %xmm7
pand	%xmm14, %xmm6
punpckldq	%xmm9, %xmm4
movdqa	%xmm12, %xmm9
movdqa	%xmm3, (%rax)
paddd	%xmm3, %xmm11
movd	-0x18(%r8), %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm13, %xmm7
por	%xmm9, %xmm8
movd	-0x18(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
pshufb	%xmm5, %xmm4
movd	-0x18(%r10), %xmm8
por	%xmm7, %xmm13
movd	-0x18(%r11), %xmm7
punpckldq	%xmm8, %xmm0
movdqa	%xmm11, %xmm8
paddd	%xmm15, %xmm10
punpckldq	%xmm7, %xmm9
movdqa	%xmm12, %xmm7
movdqa	%xmm12, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm14, %xmm7
pand	%xmm13, %xmm6
punpckldq	%xmm9, %xmm0
movdqa	%xmm11, %xmm9
movdqa	%xmm4, 0x10(%rax)
paddd	%xmm4, %xmm10
movd	-0x14(%r8), %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm12, %xmm7
por	%xmm9, %xmm8
movd	-0x14(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
pshufb	%xmm5, %xmm0
movd	-0x14(%r10), %xmm8
por	%xmm7, %xmm12
movd	-0x14(%r11), %xmm7
punpckldq	%xmm8, %xmm1
movdqa	%xmm10, %xmm8
paddd	%xmm15, %xmm14
punpckldq	%xmm7, %xmm9
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm13, %xmm7
pand	%xmm12, %xmm6
punpckldq	%xmm9, %xmm1
movdqa	%xmm10, %xmm9
movdqa	%xmm0, 0x20(%rax)
paddd	%xmm0, %xmm14
movd	-0x10(%r8), %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm11, %xmm7
por	%xmm9, %xmm8
movd	-0x10(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
pshufb	%xmm5, %xmm1
movd	-0x10(%r10), %xmm8
por	%xmm7, %xmm11
movd	-0x10(%r11), %xmm7
punpckldq	%xmm8, %xmm2
movdqa	%xmm14, %xmm8
paddd	%xmm15, %xmm13
punpckldq	%xmm7, %xmm9
movdqa	%xmm10, %xmm7
movdqa	%xmm10, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm12, %xmm7
pand	%xmm11, %xmm6
punpckldq	%xmm9, %xmm2
movdqa	%xmm14, %xmm9
movdqa	%xmm1, 0x30(%rax)
paddd	%xmm1, %xmm13
movd	-0xc(%r8), %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm10, %xmm7
por	%xmm9, %xmm8
movd	-0xc(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
pshufb	%xmm5, %xmm2
movd	-0xc(%r10), %xmm8
por	%xmm7, %xmm10
movd	-0xc(%r11), %xmm7
punpckldq	%xmm8, %xmm3
movdqa	%xmm13, %xmm8
paddd	%xmm15, %xmm12
punpckldq	%xmm7, %xmm9
movdqa	%xmm14, %xmm7
movdqa	%xmm14, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm11, %xmm7
pand	%xmm10, %xmm6
punpckldq	%xmm9, %xmm3
movdqa	%xmm13, %xmm9
movdqa	%xmm2, 0x40(%rax)
paddd	%xmm2, %xmm12
movd	-0x8(%r8), %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm14, %xmm7
por	%xmm9, %xmm8
movd	-0x8(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
pshufb	%xmm5, %xmm3
movd	-0x8(%r10), %xmm8
por	%xmm7, %xmm14
movd	-0x8(%r11), %xmm7
punpckldq	%xmm8, %xmm4
movdqa	%xmm12, %xmm8
paddd	%xmm15, %xmm11
punpckldq	%xmm7, %xmm9
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm6
pslld	$0x5, %xmm8
pandn	%xmm10, %xmm7
pand	%xmm14, %xmm6
punpckldq	%xmm9, %xmm4
movdqa	%xmm12, %xmm9
movdqa	%xmm3, 0x50(%rax)
paddd	%xmm3, %xmm11
movd	-0x4(%r8), %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm13, %xmm7
por	%xmm9, %xmm8
movd	-0x4(%r9), %xmm9
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
pshufb	%xmm5, %xmm4
movd	-0x4(%r10), %xmm8
por	%xmm7, %xmm13
movdqa	-0x80(%rax), %xmm1
movd	-0x4(%r11), %xmm7
punpckldq	%xmm8, %xmm0
movdqa	%xmm11, %xmm8
paddd	%xmm15, %xmm10
punpckldq	%xmm7, %xmm9
movdqa	%xmm12, %xmm7
movdqa	%xmm12, %xmm6
pslld	$0x5, %xmm8
prefetcht0	0x3f(%r8)
pandn	%xmm14, %xmm7
pand	%xmm13, %xmm6
punpckldq	%xmm9, %xmm0
movdqa	%xmm11, %xmm9
movdqa	%xmm4, 0x60(%rax)
paddd	%xmm4, %xmm10
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm12, %xmm7
prefetcht0	0x3f(%r9)
por	%xmm9, %xmm8
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm10
prefetcht0	0x3f(%r10)
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
pshufb	%xmm5, %xmm0
prefetcht0	0x3f(%r11)
por	%xmm7, %xmm12
movdqa	-0x70(%rax), %xmm2
pxor	%xmm3, %xmm1
movdqa	-0x60(%rax), %xmm3
movdqa	%xmm10, %xmm8
pxor	(%rax), %xmm1
paddd	%xmm15, %xmm14
movdqa	%xmm11, %xmm7
pslld	$0x5, %xmm8
pxor	%xmm3, %xmm1
movdqa	%xmm11, %xmm6
pandn	%xmm13, %xmm7
movdqa	%xmm1, %xmm5
pand	%xmm12, %xmm6
movdqa	%xmm10, %xmm9
psrld	$0x1f, %xmm5
paddd	%xmm1, %xmm1
movdqa	%xmm0, 0x70(%rax)
paddd	%xmm0, %xmm14
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm11, %xmm7
por	%xmm9, %xmm8
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x50(%rax), %xmm4
movdqa	%xmm14, %xmm8
pxor	0x10(%rax), %xmm2
paddd	%xmm15, %xmm13
movdqa	%xmm10, %xmm7
pslld	$0x5, %xmm8
pxor	%xmm4, %xmm2
movdqa	%xmm10, %xmm6
pandn	%xmm12, %xmm7
movdqa	%xmm2, %xmm5
pand	%xmm11, %xmm6
movdqa	%xmm14, %xmm9
psrld	$0x1f, %xmm5
paddd	%xmm2, %xmm2
movdqa	%xmm1, -0x80(%rax)
paddd	%xmm1, %xmm13
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm10, %xmm7
por	%xmm9, %xmm8
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x40(%rax), %xmm0
movdqa	%xmm13, %xmm8
pxor	0x20(%rax), %xmm3
paddd	%xmm15, %xmm12
movdqa	%xmm14, %xmm7
pslld	$0x5, %xmm8
pxor	%xmm0, %xmm3
movdqa	%xmm14, %xmm6
pandn	%xmm11, %xmm7
movdqa	%xmm3, %xmm5
pand	%xmm10, %xmm6
movdqa	%xmm13, %xmm9
psrld	$0x1f, %xmm5
paddd	%xmm3, %xmm3
movdqa	%xmm2, -0x70(%rax)
paddd	%xmm2, %xmm12
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm14, %xmm7
por	%xmm9, %xmm8
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	-0x30(%rax), %xmm1
movdqa	%xmm12, %xmm8
pxor	0x30(%rax), %xmm4
paddd	%xmm15, %xmm11
movdqa	%xmm13, %xmm7
pslld	$0x5, %xmm8
pxor	%xmm1, %xmm4
movdqa	%xmm13, %xmm6
pandn	%xmm10, %xmm7
movdqa	%xmm4, %xmm5
pand	%xmm14, %xmm6
movdqa	%xmm12, %xmm9
psrld	$0x1f, %xmm5
paddd	%xmm4, %xmm4
movdqa	%xmm3, -0x60(%rax)
paddd	%xmm3, %xmm11
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm13, %xmm7
por	%xmm9, %xmm8
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	-0x20(%rax), %xmm2
movdqa	%xmm11, %xmm8
pxor	0x40(%rax), %xmm0
paddd	%xmm15, %xmm10
movdqa	%xmm12, %xmm7
pslld	$0x5, %xmm8
pxor	%xmm2, %xmm0
movdqa	%xmm12, %xmm6
pandn	%xmm14, %xmm7
movdqa	%xmm0, %xmm5
pand	%xmm13, %xmm6
movdqa	%xmm11, %xmm9
psrld	$0x1f, %xmm5
paddd	%xmm0, %xmm0
movdqa	%xmm4, -0x50(%rax)
paddd	%xmm4, %xmm10
psrld	$0x1b, %xmm9
pxor	%xmm7, %xmm6
movdqa	%xmm12, %xmm7
por	%xmm9, %xmm8
pslld	$0x1e, %xmm7
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
movdqa	(%rbp), %xmm15
pxor	%xmm3, %xmm1
movdqa	-0x10(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	0x50(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, -0x40(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	0x60(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, -0x30(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	0x10(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	0x70(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
movdqa	%xmm2, -0x20(%rax)
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	0x20(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	-0x80(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm3, -0x10(%rax)
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	0x30(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	-0x70(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
movdqa	%xmm4, (%rax)
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	0x40(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	-0x60(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, 0x10(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	0x50(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	-0x50(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, 0x20(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	0x60(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	-0x40(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
movdqa	%xmm2, 0x30(%rax)
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	0x70(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	-0x30(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm3, 0x40(%rax)
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	-0x80(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	-0x20(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
movdqa	%xmm4, 0x50(%rax)
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	-0x70(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	-0x10(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, 0x60(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x60(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, 0x70(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x50(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	0x10(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
movdqa	%xmm2, -0x80(%rax)
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	-0x40(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	0x20(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm3, -0x70(%rax)
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	-0x30(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	0x30(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
movdqa	%xmm4, -0x60(%rax)
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	-0x20(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	0x40(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, -0x50(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x10(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	0x50(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, -0x40(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	0x60(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
movdqa	%xmm2, -0x30(%rax)
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	0x10(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	0x70(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm3, -0x20(%rax)
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	0x20(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	-0x80(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
movdqa	%xmm4, -0x10(%rax)
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
movdqa	0x20(%rbp), %xmm15
pxor	%xmm3, %xmm1
movdqa	0x30(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm7
pxor	-0x70(%rax), %xmm1
pxor	%xmm3, %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
movdqa	%xmm10, %xmm9
pand	%xmm12, %xmm7
movdqa	%xmm13, %xmm6
movdqa	%xmm1, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm14
pxor	%xmm12, %xmm6
movdqa	%xmm0, (%rax)
paddd	%xmm0, %xmm14
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm11, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm1, %xmm1
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	0x40(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm7
pxor	-0x60(%rax), %xmm2
pxor	%xmm4, %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
movdqa	%xmm14, %xmm9
pand	%xmm11, %xmm7
movdqa	%xmm12, %xmm6
movdqa	%xmm2, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm13
pxor	%xmm11, %xmm6
movdqa	%xmm1, 0x10(%rax)
paddd	%xmm1, %xmm13
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm10, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm2, %xmm2
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	0x50(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm7
pxor	-0x50(%rax), %xmm3
pxor	%xmm0, %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
movdqa	%xmm13, %xmm9
pand	%xmm10, %xmm7
movdqa	%xmm11, %xmm6
movdqa	%xmm3, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm12
pxor	%xmm10, %xmm6
movdqa	%xmm2, 0x20(%rax)
paddd	%xmm2, %xmm12
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm14, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm3, %xmm3
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	0x60(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm7
pxor	-0x40(%rax), %xmm4
pxor	%xmm1, %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
movdqa	%xmm12, %xmm9
pand	%xmm14, %xmm7
movdqa	%xmm10, %xmm6
movdqa	%xmm4, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm11
pxor	%xmm14, %xmm6
movdqa	%xmm3, 0x30(%rax)
paddd	%xmm3, %xmm11
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm13, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm4, %xmm4
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	0x70(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm7
pxor	-0x30(%rax), %xmm0
pxor	%xmm2, %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
movdqa	%xmm11, %xmm9
pand	%xmm13, %xmm7
movdqa	%xmm14, %xmm6
movdqa	%xmm0, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm10
pxor	%xmm13, %xmm6
movdqa	%xmm4, 0x40(%rax)
paddd	%xmm4, %xmm10
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm12, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm0, %xmm0
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	-0x80(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm7
pxor	-0x20(%rax), %xmm1
pxor	%xmm3, %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
movdqa	%xmm10, %xmm9
pand	%xmm12, %xmm7
movdqa	%xmm13, %xmm6
movdqa	%xmm1, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm14
pxor	%xmm12, %xmm6
movdqa	%xmm0, 0x50(%rax)
paddd	%xmm0, %xmm14
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm11, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm1, %xmm1
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x70(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm7
pxor	-0x10(%rax), %xmm2
pxor	%xmm4, %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
movdqa	%xmm14, %xmm9
pand	%xmm11, %xmm7
movdqa	%xmm12, %xmm6
movdqa	%xmm2, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm13
pxor	%xmm11, %xmm6
movdqa	%xmm1, 0x60(%rax)
paddd	%xmm1, %xmm13
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm10, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm2, %xmm2
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x60(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm7
pxor	(%rax), %xmm3
pxor	%xmm0, %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
movdqa	%xmm13, %xmm9
pand	%xmm10, %xmm7
movdqa	%xmm11, %xmm6
movdqa	%xmm3, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm12
pxor	%xmm10, %xmm6
movdqa	%xmm2, 0x70(%rax)
paddd	%xmm2, %xmm12
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm14, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm3, %xmm3
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	-0x50(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm7
pxor	0x10(%rax), %xmm4
pxor	%xmm1, %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
movdqa	%xmm12, %xmm9
pand	%xmm14, %xmm7
movdqa	%xmm10, %xmm6
movdqa	%xmm4, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm11
pxor	%xmm14, %xmm6
movdqa	%xmm3, -0x80(%rax)
paddd	%xmm3, %xmm11
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm13, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm4, %xmm4
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	-0x40(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm7
pxor	0x20(%rax), %xmm0
pxor	%xmm2, %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
movdqa	%xmm11, %xmm9
pand	%xmm13, %xmm7
movdqa	%xmm14, %xmm6
movdqa	%xmm0, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm10
pxor	%xmm13, %xmm6
movdqa	%xmm4, -0x70(%rax)
paddd	%xmm4, %xmm10
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm12, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm0, %xmm0
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	-0x30(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm7
pxor	0x30(%rax), %xmm1
pxor	%xmm3, %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
movdqa	%xmm10, %xmm9
pand	%xmm12, %xmm7
movdqa	%xmm13, %xmm6
movdqa	%xmm1, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm14
pxor	%xmm12, %xmm6
movdqa	%xmm0, -0x60(%rax)
paddd	%xmm0, %xmm14
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm11, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm1, %xmm1
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x20(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm7
pxor	0x40(%rax), %xmm2
pxor	%xmm4, %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
movdqa	%xmm14, %xmm9
pand	%xmm11, %xmm7
movdqa	%xmm12, %xmm6
movdqa	%xmm2, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm13
pxor	%xmm11, %xmm6
movdqa	%xmm1, -0x50(%rax)
paddd	%xmm1, %xmm13
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm10, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm2, %xmm2
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x10(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm7
pxor	0x50(%rax), %xmm3
pxor	%xmm0, %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
movdqa	%xmm13, %xmm9
pand	%xmm10, %xmm7
movdqa	%xmm11, %xmm6
movdqa	%xmm3, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm12
pxor	%xmm10, %xmm6
movdqa	%xmm2, -0x40(%rax)
paddd	%xmm2, %xmm12
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm14, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm3, %xmm3
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm7
pxor	0x60(%rax), %xmm4
pxor	%xmm1, %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
movdqa	%xmm12, %xmm9
pand	%xmm14, %xmm7
movdqa	%xmm10, %xmm6
movdqa	%xmm4, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm11
pxor	%xmm14, %xmm6
movdqa	%xmm3, -0x30(%rax)
paddd	%xmm3, %xmm11
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm13, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm4, %xmm4
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	0x10(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm7
pxor	0x70(%rax), %xmm0
pxor	%xmm2, %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
movdqa	%xmm11, %xmm9
pand	%xmm13, %xmm7
movdqa	%xmm14, %xmm6
movdqa	%xmm0, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm10
pxor	%xmm13, %xmm6
movdqa	%xmm4, -0x20(%rax)
paddd	%xmm4, %xmm10
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm12, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm0, %xmm0
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	0x20(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm7
pxor	-0x80(%rax), %xmm1
pxor	%xmm3, %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
movdqa	%xmm10, %xmm9
pand	%xmm12, %xmm7
movdqa	%xmm13, %xmm6
movdqa	%xmm1, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm14
pxor	%xmm12, %xmm6
movdqa	%xmm0, -0x10(%rax)
paddd	%xmm0, %xmm14
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm11, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm1, %xmm1
paddd	%xmm6, %xmm14
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	0x30(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm7
pxor	-0x70(%rax), %xmm2
pxor	%xmm4, %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
movdqa	%xmm14, %xmm9
pand	%xmm11, %xmm7
movdqa	%xmm12, %xmm6
movdqa	%xmm2, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm13
pxor	%xmm11, %xmm6
movdqa	%xmm1, (%rax)
paddd	%xmm1, %xmm13
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm10, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm2, %xmm2
paddd	%xmm6, %xmm13
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	0x40(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm7
pxor	-0x60(%rax), %xmm3
pxor	%xmm0, %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
movdqa	%xmm13, %xmm9
pand	%xmm10, %xmm7
movdqa	%xmm11, %xmm6
movdqa	%xmm3, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm12
pxor	%xmm10, %xmm6
movdqa	%xmm2, 0x10(%rax)
paddd	%xmm2, %xmm12
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm14, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm3, %xmm3
paddd	%xmm6, %xmm12
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	0x50(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm7
pxor	-0x50(%rax), %xmm4
pxor	%xmm1, %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
movdqa	%xmm12, %xmm9
pand	%xmm14, %xmm7
movdqa	%xmm10, %xmm6
movdqa	%xmm4, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm11
pxor	%xmm14, %xmm6
movdqa	%xmm3, 0x20(%rax)
paddd	%xmm3, %xmm11
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm13, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm4, %xmm4
paddd	%xmm6, %xmm11
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	0x60(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm7
pxor	-0x40(%rax), %xmm0
pxor	%xmm2, %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
movdqa	%xmm11, %xmm9
pand	%xmm13, %xmm7
movdqa	%xmm14, %xmm6
movdqa	%xmm0, %xmm5
psrld	$0x1b, %xmm9
paddd	%xmm7, %xmm10
pxor	%xmm13, %xmm6
movdqa	%xmm4, 0x30(%rax)
paddd	%xmm4, %xmm10
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
pand	%xmm12, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
paddd	%xmm0, %xmm0
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
movdqa	0x40(%rbp), %xmm15
pxor	%xmm3, %xmm1
movdqa	0x70(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	-0x30(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, 0x40(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x80(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	-0x20(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, 0x50(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x70(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	-0x10(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
movdqa	%xmm2, 0x60(%rax)
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	-0x60(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm3, 0x70(%rax)
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	-0x50(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	0x10(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
movdqa	%xmm4, -0x80(%rax)
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	-0x40(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	0x20(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, -0x70(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	-0x30(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	0x30(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, -0x60(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x20(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	0x40(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
movdqa	%xmm2, -0x50(%rax)
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	-0x10(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	0x50(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm3, -0x40(%rax)
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	0x60(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
movdqa	%xmm4, -0x30(%rax)
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	0x10(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	0x70(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
movdqa	%xmm0, -0x20(%rax)
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	0x20(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	-0x80(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
movdqa	%xmm1, -0x10(%rax)
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	0x30(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	-0x70(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	0x40(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	-0x60(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
pxor	%xmm2, %xmm0
movdqa	0x50(%rax), %xmm2
movdqa	%xmm11, %xmm8
movdqa	%xmm14, %xmm6
pxor	-0x50(%rax), %xmm0
paddd	%xmm15, %xmm10
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
paddd	%xmm4, %xmm10
pxor	%xmm2, %xmm0
psrld	$0x1b, %xmm9
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm0, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm10
paddd	%xmm0, %xmm0
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm5, %xmm0
por	%xmm7, %xmm12
pxor	%xmm3, %xmm1
movdqa	0x60(%rax), %xmm3
movdqa	%xmm10, %xmm8
movdqa	%xmm13, %xmm6
pxor	-0x40(%rax), %xmm1
paddd	%xmm15, %xmm14
pslld	$0x5, %xmm8
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm9
paddd	%xmm0, %xmm14
pxor	%xmm3, %xmm1
psrld	$0x1b, %xmm9
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm1, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm14
paddd	%xmm1, %xmm1
psrld	$0x2, %xmm11
paddd	%xmm8, %xmm14
por	%xmm5, %xmm1
por	%xmm7, %xmm11
pxor	%xmm4, %xmm2
movdqa	0x70(%rax), %xmm4
movdqa	%xmm14, %xmm8
movdqa	%xmm12, %xmm6
pxor	-0x30(%rax), %xmm2
paddd	%xmm15, %xmm13
pslld	$0x5, %xmm8
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm9
paddd	%xmm1, %xmm13
pxor	%xmm4, %xmm2
psrld	$0x1b, %xmm9
pxor	%xmm11, %xmm6
movdqa	%xmm10, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm2, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm13
paddd	%xmm2, %xmm2
psrld	$0x2, %xmm10
paddd	%xmm8, %xmm13
por	%xmm5, %xmm2
por	%xmm7, %xmm10
pxor	%xmm0, %xmm3
movdqa	-0x80(%rax), %xmm0
movdqa	%xmm13, %xmm8
movdqa	%xmm11, %xmm6
pxor	-0x20(%rax), %xmm3
paddd	%xmm15, %xmm12
pslld	$0x5, %xmm8
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm9
paddd	%xmm2, %xmm12
pxor	%xmm0, %xmm3
psrld	$0x1b, %xmm9
pxor	%xmm10, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm3, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm12
paddd	%xmm3, %xmm3
psrld	$0x2, %xmm14
paddd	%xmm8, %xmm12
por	%xmm5, %xmm3
por	%xmm7, %xmm14
pxor	%xmm1, %xmm4
movdqa	-0x70(%rax), %xmm1
movdqa	%xmm12, %xmm8
movdqa	%xmm10, %xmm6
pxor	-0x10(%rax), %xmm4
paddd	%xmm15, %xmm11
pslld	$0x5, %xmm8
pxor	%xmm13, %xmm6
movdqa	%xmm12, %xmm9
paddd	%xmm3, %xmm11
pxor	%xmm1, %xmm4
psrld	$0x1b, %xmm9
pxor	%xmm14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0x1e, %xmm7
movdqa	%xmm4, %xmm5
por	%xmm9, %xmm8
psrld	$0x1f, %xmm5
paddd	%xmm6, %xmm11
paddd	%xmm4, %xmm4
psrld	$0x2, %xmm13
paddd	%xmm8, %xmm11
por	%xmm5, %xmm4
por	%xmm7, %xmm13
movdqa	%xmm11, %xmm8
paddd	%xmm15, %xmm10
movdqa	%xmm14, %xmm6
pslld	$0x5, %xmm8
pxor	%xmm12, %xmm6
movdqa	%xmm11, %xmm9
paddd	%xmm4, %xmm10
psrld	$0x1b, %xmm9
movdqa	%xmm12, %xmm7
pxor	%xmm13, %xmm6
pslld	$0x1e, %xmm7
por	%xmm9, %xmm8
paddd	%xmm6, %xmm10
psrld	$0x2, %xmm12
paddd	%xmm8, %xmm10
por	%xmm7, %xmm12
movdqa	(%rbx), %xmm0
movl	$0x1, %ecx
cmpl	(%rbx), %ecx
pxor	%xmm8, %xmm8
cmovgeq	%rbp, %r8
cmpl	0x4(%rbx), %ecx
movdqa	%xmm0, %xmm1
cmovgeq	%rbp, %r9
cmpl	0x8(%rbx), %ecx
pcmpgtd	%xmm8, %xmm1
cmovgeq	%rbp, %r10
cmpl	0xc(%rbx), %ecx
paddd	%xmm1, %xmm0
cmovgeq	%rbp, %r11
movdqu	(%rdi), %xmm6
pand	%xmm1, %xmm10
movdqu	0x20(%rdi), %xmm7
pand	%xmm1, %xmm11
paddd	%xmm6, %xmm10
movdqu	0x40(%rdi), %xmm8
pand	%xmm1, %xmm12
paddd	%xmm7, %xmm11
movdqu	0x60(%rdi), %xmm9
pand	%xmm1, %xmm13
paddd	%xmm8, %xmm12
movdqu	0x80(%rdi), %xmm5
pand	%xmm1, %xmm14
movdqu	%xmm10, (%rdi)
paddd	%xmm9, %xmm13
movdqu	%xmm11, 0x20(%rdi)
paddd	%xmm5, %xmm14
movdqu	%xmm12, 0x40(%rdi)
movdqu	%xmm13, 0x60(%rdi)
movdqu	%xmm14, 0x80(%rdi)
movdqa	%xmm0, (%rbx)
movdqa	0x60(%rbp), %xmm5
movdqa	-0x20(%rbp), %xmm15
decl	%edx
jne	L_e0
movl	0x118(%rsp), %edx
leaq	0x10(%rdi), %rdi
leaq	0x40(%rsi), %rsi
decl	%edx
jne	L_48
L_2a98:
movq	0x110(%rsp), %rax
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
_shaext_shortcut:
sha1_multi_block_shaext:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
subq	$0x120, %rsp
shll	%edx
andq	$-0x100, %rsp
leaq	0x40(%rdi), %rdi
movq	%rax, 0x110(%rsp)
leaq	0x100(%rsp), %rbx
movdqa	K_XX_XX+128(%rip), %xmm3
L_2af1:
movl	%edx, 0x118(%rsp)
xorl	%edx, %edx
movq	(%rsi), %r8
movl	0x8(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, (%rbx)
cmovleq	%rsp, %r8
movq	0x10(%rsi), %r9
movl	0x18(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x4(%rbx)
cmovleq	%rsp, %r9
testl	%edx, %edx
je	L_30d5
movq	-0x40(%rdi), %xmm0
movq	-0x20(%rdi), %xmm4
movq	(%rdi), %xmm5
movq	0x20(%rdi), %xmm6
movq	0x40(%rdi), %xmm7
punpckldq	%xmm4, %xmm0
punpckldq	%xmm6, %xmm5
movdqa	%xmm0, %xmm8
punpcklqdq	%xmm5, %xmm0
punpckhqdq	%xmm5, %xmm8
pshufd	$0x3f, %xmm7, %xmm1
pshufd	$0x7f, %xmm7, %xmm9
pshufd	$0x1b, %xmm0, %xmm0
pshufd	$0x1b, %xmm8, %xmm8
jmp	L_2b80
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_2b80:
movdqu	(%r8), %xmm4
movdqu	(%r9), %xmm11
movdqu	0x10(%r8), %xmm5
movdqu	0x10(%r9), %xmm12
movdqu	0x20(%r8), %xmm6
pshufb	%xmm3, %xmm4
movdqu	0x20(%r9), %xmm13
pshufb	%xmm3, %xmm11
movdqu	0x30(%r8), %xmm7
leaq	0x40(%r8), %r8
pshufb	%xmm3, %xmm5
movdqu	0x30(%r9), %xmm14
leaq	0x40(%r9), %r9
pshufb	%xmm3, %xmm12
movdqa	%xmm1, 0x50(%rsp)
paddd	%xmm4, %xmm1
movdqa	%xmm9, 0x70(%rsp)
paddd	%xmm11, %xmm9
movdqa	%xmm0, 0x40(%rsp)
movdqa	%xmm0, %xmm2
movdqa	%xmm8, 0x60(%rsp)
movdqa	%xmm8, %xmm10
sha1rnds4	$0x0, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
sha1rnds4	$0x0, %xmm9, %xmm8
sha1nexte	%xmm12, %xmm10
pshufb	%xmm3, %xmm6
prefetcht0	0x7f(%r8)
sha1msg1	%xmm5, %xmm4
pshufb	%xmm3, %xmm13
prefetcht0	0x7f(%r9)
sha1msg1	%xmm12, %xmm11
pshufb	%xmm3, %xmm7
movdqa	%xmm0, %xmm1
pshufb	%xmm3, %xmm14
movdqa	%xmm8, %xmm9
sha1rnds4	$0x0, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
sha1rnds4	$0x0, %xmm10, %xmm8
sha1nexte	%xmm13, %xmm9
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
pxor	%xmm13, %xmm11
sha1msg1	%xmm13, %xmm12
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x0, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
sha1rnds4	$0x0, %xmm9, %xmm8
sha1nexte	%xmm14, %xmm10
sha1msg2	%xmm7, %xmm4
sha1msg2	%xmm14, %xmm11
pxor	%xmm7, %xmm5
sha1msg1	%xmm7, %xmm6
pxor	%xmm14, %xmm12
sha1msg1	%xmm14, %xmm13
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x0, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
sha1rnds4	$0x0, %xmm10, %xmm8
sha1nexte	%xmm11, %xmm9
sha1msg2	%xmm4, %xmm5
sha1msg2	%xmm11, %xmm12
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
pxor	%xmm11, %xmm13
sha1msg1	%xmm11, %xmm14
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x0, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
sha1rnds4	$0x0, %xmm9, %xmm8
sha1nexte	%xmm12, %xmm10
sha1msg2	%xmm5, %xmm6
sha1msg2	%xmm12, %xmm13
pxor	%xmm5, %xmm7
sha1msg1	%xmm5, %xmm4
pxor	%xmm12, %xmm14
sha1msg1	%xmm12, %xmm11
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x1, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
sha1rnds4	$0x1, %xmm10, %xmm8
sha1nexte	%xmm13, %xmm9
sha1msg2	%xmm6, %xmm7
sha1msg2	%xmm13, %xmm14
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
pxor	%xmm13, %xmm11
sha1msg1	%xmm13, %xmm12
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x1, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
sha1rnds4	$0x1, %xmm9, %xmm8
sha1nexte	%xmm14, %xmm10
sha1msg2	%xmm7, %xmm4
sha1msg2	%xmm14, %xmm11
pxor	%xmm7, %xmm5
sha1msg1	%xmm7, %xmm6
pxor	%xmm14, %xmm12
sha1msg1	%xmm14, %xmm13
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x1, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
sha1rnds4	$0x1, %xmm10, %xmm8
sha1nexte	%xmm11, %xmm9
sha1msg2	%xmm4, %xmm5
sha1msg2	%xmm11, %xmm12
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
pxor	%xmm11, %xmm13
sha1msg1	%xmm11, %xmm14
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x1, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
sha1rnds4	$0x1, %xmm9, %xmm8
sha1nexte	%xmm12, %xmm10
sha1msg2	%xmm5, %xmm6
sha1msg2	%xmm12, %xmm13
pxor	%xmm5, %xmm7
sha1msg1	%xmm5, %xmm4
pxor	%xmm12, %xmm14
sha1msg1	%xmm12, %xmm11
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x1, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
sha1rnds4	$0x1, %xmm10, %xmm8
sha1nexte	%xmm13, %xmm9
sha1msg2	%xmm6, %xmm7
sha1msg2	%xmm13, %xmm14
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
pxor	%xmm13, %xmm11
sha1msg1	%xmm13, %xmm12
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x2, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
sha1rnds4	$0x2, %xmm9, %xmm8
sha1nexte	%xmm14, %xmm10
sha1msg2	%xmm7, %xmm4
sha1msg2	%xmm14, %xmm11
pxor	%xmm7, %xmm5
sha1msg1	%xmm7, %xmm6
pxor	%xmm14, %xmm12
sha1msg1	%xmm14, %xmm13
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x2, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
sha1rnds4	$0x2, %xmm10, %xmm8
sha1nexte	%xmm11, %xmm9
sha1msg2	%xmm4, %xmm5
sha1msg2	%xmm11, %xmm12
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
pxor	%xmm11, %xmm13
sha1msg1	%xmm11, %xmm14
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x2, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
sha1rnds4	$0x2, %xmm9, %xmm8
sha1nexte	%xmm12, %xmm10
sha1msg2	%xmm5, %xmm6
sha1msg2	%xmm12, %xmm13
pxor	%xmm5, %xmm7
sha1msg1	%xmm5, %xmm4
pxor	%xmm12, %xmm14
sha1msg1	%xmm12, %xmm11
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x2, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
sha1rnds4	$0x2, %xmm10, %xmm8
sha1nexte	%xmm13, %xmm9
sha1msg2	%xmm6, %xmm7
sha1msg2	%xmm13, %xmm14
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
pxor	%xmm13, %xmm11
sha1msg1	%xmm13, %xmm12
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x2, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
sha1rnds4	$0x2, %xmm9, %xmm8
sha1nexte	%xmm14, %xmm10
sha1msg2	%xmm7, %xmm4
sha1msg2	%xmm14, %xmm11
pxor	%xmm7, %xmm5
sha1msg1	%xmm7, %xmm6
pxor	%xmm14, %xmm12
sha1msg1	%xmm14, %xmm13
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x3, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
sha1rnds4	$0x3, %xmm10, %xmm8
sha1nexte	%xmm11, %xmm9
sha1msg2	%xmm4, %xmm5
sha1msg2	%xmm11, %xmm12
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
pxor	%xmm11, %xmm13
sha1msg1	%xmm11, %xmm14
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x3, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
sha1rnds4	$0x3, %xmm9, %xmm8
sha1nexte	%xmm12, %xmm10
sha1msg2	%xmm5, %xmm6
sha1msg2	%xmm12, %xmm13
pxor	%xmm5, %xmm7
pxor	%xmm12, %xmm14
movl	$0x1, %ecx
pxor	%xmm4, %xmm4
cmpl	(%rbx), %ecx
cmovgeq	%rsp, %r8
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x3, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
sha1rnds4	$0x3, %xmm10, %xmm8
sha1nexte	%xmm13, %xmm9
sha1msg2	%xmm6, %xmm7
sha1msg2	%xmm13, %xmm14
cmpl	0x4(%rbx), %ecx
cmovgeq	%rsp, %r9
movq	(%rbx), %xmm6
movdqa	%xmm0, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x3, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
sha1rnds4	$0x3, %xmm9, %xmm8
sha1nexte	%xmm14, %xmm10
pshufd	$0x0, %xmm6, %xmm11
pshufd	$0x55, %xmm6, %xmm12
movdqa	%xmm6, %xmm7
pcmpgtd	%xmm4, %xmm11
pcmpgtd	%xmm4, %xmm12
movdqa	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
sha1rnds4	$0x3, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
sha1rnds4	$0x3, %xmm10, %xmm8
sha1nexte	%xmm4, %xmm9
pcmpgtd	%xmm4, %xmm7
pand	%xmm11, %xmm0
pand	%xmm11, %xmm1
pand	%xmm12, %xmm8
pand	%xmm12, %xmm9
paddd	%xmm7, %xmm6
paddd	0x40(%rsp), %xmm0
paddd	0x50(%rsp), %xmm1
paddd	0x60(%rsp), %xmm8
paddd	0x70(%rsp), %xmm9
movq	%xmm6, (%rbx)
decl	%edx
jne	L_2b80
movl	0x118(%rsp), %edx
pshufd	$0x1b, %xmm0, %xmm0
pshufd	$0x1b, %xmm8, %xmm8
movdqa	%xmm0, %xmm6
punpckldq	%xmm8, %xmm0
punpckhdq	%xmm8, %xmm6
punpckhdq	%xmm9, %xmm1
movq	%xmm0, -0x40(%rdi)
psrldq	$0x8, %xmm0
movq	%xmm6, (%rdi)
psrldq	$0x8, %xmm6
movq	%xmm0, -0x20(%rdi)
psrldq	$0x8, %xmm1
movq	%xmm6, 0x20(%rdi)
movq	%xmm1, 0x40(%rdi)
leaq	0x8(%rdi), %rdi
leaq	0x20(%rsi), %rsi
decl	%edx
jne	L_2af1
L_30d5:
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
_avx_shortcut:
sha1_multi_block_avx:
shrq	$0x20, %rcx
cmpl	$0x2, %edx
jb	L_3120
testl	$0x20, %ecx
jne	_avx2_shortcut
jmp	L_3120
nopw	(%rax,%rax)
L_3120:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
subq	$0x120, %rsp
andq	$-0x100, %rsp
movq	%rax, 0x110(%rsp)
leaq	K_XX_XX(%rip), %rbp
leaq	0x100(%rsp), %rbx
vzeroupper
L_314d:
movl	%edx, 0x118(%rsp)
xorl	%edx, %edx
movq	(%rsi), %r8
movl	0x8(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, (%rbx)
cmovleq	%rbp, %r8
movq	0x10(%rsi), %r9
movl	0x18(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x4(%rbx)
cmovleq	%rbp, %r9
movq	0x20(%rsi), %r10
movl	0x28(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x8(%rbx)
cmovleq	%rbp, %r10
movq	0x30(%rsi), %r11
movl	0x38(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0xc(%rbx)
cmovleq	%rbp, %r11
testl	%edx, %edx
je	L_51f9
vmovdqu	(%rdi), %xmm10
leaq	0x80(%rsp), %rax
vmovdqu	0x20(%rdi), %xmm11
vmovdqu	0x40(%rdi), %xmm12
vmovdqu	0x60(%rdi), %xmm13
vmovdqu	0x80(%rdi), %xmm14
vmovdqu	0x60(%rbp), %xmm5
jmp	L_31e0
nopw	(%rax,%rax)
L_31e0:
vmovdqa	-0x20(%rbp), %xmm15
vmovd	(%r8), %xmm0
leaq	0x40(%r8), %r8
vmovd	(%r9), %xmm2
leaq	0x40(%r9), %r9
vpinsrd	$0x1, (%r10), %xmm0, %xmm0
leaq	0x40(%r10), %r10
vpinsrd	$0x1, (%r11), %xmm2, %xmm2
leaq	0x40(%r11), %r11
vmovd	-0x3c(%r8), %xmm1
vpunpckldq	%xmm2, %xmm0, %xmm0
vmovd	-0x3c(%r9), %xmm9
vpshufb	%xmm5, %xmm0, %xmm0
vpinsrd	$0x1, -0x3c(%r10), %xmm1, %xmm1
vpinsrd	$0x1, -0x3c(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpandn	%xmm13, %xmm11, %xmm7
vpand	%xmm12, %xmm11, %xmm6
vmovdqa	%xmm0, -0x80(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpunpckldq	%xmm9, %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x38(%r8), %xmm2
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x38(%r9), %xmm9
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpshufb	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpinsrd	$0x1, -0x38(%r10), %xmm2, %xmm2
vpinsrd	$0x1, -0x38(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpandn	%xmm12, %xmm10, %xmm7
vpand	%xmm11, %xmm10, %xmm6
vmovdqa	%xmm1, -0x70(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpunpckldq	%xmm9, %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x34(%r8), %xmm3
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x34(%r9), %xmm9
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpshufb	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpinsrd	$0x1, -0x34(%r10), %xmm3, %xmm3
vpinsrd	$0x1, -0x34(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpandn	%xmm11, %xmm14, %xmm7
vpand	%xmm10, %xmm14, %xmm6
vmovdqa	%xmm2, -0x60(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpunpckldq	%xmm9, %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x30(%r8), %xmm4
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x30(%r9), %xmm9
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpshufb	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpinsrd	$0x1, -0x30(%r10), %xmm4, %xmm4
vpinsrd	$0x1, -0x30(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpandn	%xmm10, %xmm13, %xmm7
vpand	%xmm14, %xmm13, %xmm6
vmovdqa	%xmm3, -0x50(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpunpckldq	%xmm9, %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x2c(%r8), %xmm0
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x2c(%r9), %xmm9
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpshufb	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpinsrd	$0x1, -0x2c(%r10), %xmm0, %xmm0
vpinsrd	$0x1, -0x2c(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpandn	%xmm14, %xmm12, %xmm7
vpand	%xmm13, %xmm12, %xmm6
vmovdqa	%xmm4, -0x40(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpunpckldq	%xmm9, %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x28(%r8), %xmm1
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x28(%r9), %xmm9
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpshufb	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpinsrd	$0x1, -0x28(%r10), %xmm1, %xmm1
vpinsrd	$0x1, -0x28(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpandn	%xmm13, %xmm11, %xmm7
vpand	%xmm12, %xmm11, %xmm6
vmovdqa	%xmm0, -0x30(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpunpckldq	%xmm9, %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x24(%r8), %xmm2
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x24(%r9), %xmm9
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpshufb	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpinsrd	$0x1, -0x24(%r10), %xmm2, %xmm2
vpinsrd	$0x1, -0x24(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpandn	%xmm12, %xmm10, %xmm7
vpand	%xmm11, %xmm10, %xmm6
vmovdqa	%xmm1, -0x20(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpunpckldq	%xmm9, %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x20(%r8), %xmm3
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x20(%r9), %xmm9
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpshufb	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpinsrd	$0x1, -0x20(%r10), %xmm3, %xmm3
vpinsrd	$0x1, -0x20(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpandn	%xmm11, %xmm14, %xmm7
vpand	%xmm10, %xmm14, %xmm6
vmovdqa	%xmm2, -0x10(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpunpckldq	%xmm9, %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x1c(%r8), %xmm4
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x1c(%r9), %xmm9
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpshufb	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpinsrd	$0x1, -0x1c(%r10), %xmm4, %xmm4
vpinsrd	$0x1, -0x1c(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpandn	%xmm10, %xmm13, %xmm7
vpand	%xmm14, %xmm13, %xmm6
vmovdqa	%xmm3, (%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpunpckldq	%xmm9, %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x18(%r8), %xmm0
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x18(%r9), %xmm9
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpshufb	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpinsrd	$0x1, -0x18(%r10), %xmm0, %xmm0
vpinsrd	$0x1, -0x18(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpandn	%xmm14, %xmm12, %xmm7
vpand	%xmm13, %xmm12, %xmm6
vmovdqa	%xmm4, 0x10(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpunpckldq	%xmm9, %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x14(%r8), %xmm1
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x14(%r9), %xmm9
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpshufb	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpinsrd	$0x1, -0x14(%r10), %xmm1, %xmm1
vpinsrd	$0x1, -0x14(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpandn	%xmm13, %xmm11, %xmm7
vpand	%xmm12, %xmm11, %xmm6
vmovdqa	%xmm0, 0x20(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpunpckldq	%xmm9, %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x10(%r8), %xmm2
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x10(%r9), %xmm9
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpshufb	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpinsrd	$0x1, -0x10(%r10), %xmm2, %xmm2
vpinsrd	$0x1, -0x10(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpandn	%xmm12, %xmm10, %xmm7
vpand	%xmm11, %xmm10, %xmm6
vmovdqa	%xmm1, 0x30(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpunpckldq	%xmm9, %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0xc(%r8), %xmm3
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0xc(%r9), %xmm9
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpshufb	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpinsrd	$0x1, -0xc(%r10), %xmm3, %xmm3
vpinsrd	$0x1, -0xc(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpandn	%xmm11, %xmm14, %xmm7
vpand	%xmm10, %xmm14, %xmm6
vmovdqa	%xmm2, 0x40(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpunpckldq	%xmm9, %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x8(%r8), %xmm4
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x8(%r9), %xmm9
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpshufb	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpinsrd	$0x1, -0x8(%r10), %xmm4, %xmm4
vpinsrd	$0x1, -0x8(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpandn	%xmm10, %xmm13, %xmm7
vpand	%xmm14, %xmm13, %xmm6
vmovdqa	%xmm3, 0x50(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpunpckldq	%xmm9, %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vmovd	-0x4(%r8), %xmm0
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vmovd	-0x4(%r9), %xmm9
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpshufb	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vmovdqa	-0x80(%rax), %xmm1
vpinsrd	$0x1, -0x4(%r10), %xmm0, %xmm0
vpinsrd	$0x1, -0x4(%r11), %xmm9, %xmm9
vpaddd	%xmm15, %xmm10, %xmm10
prefetcht0	0x3f(%r8)
vpslld	$0x5, %xmm11, %xmm8
vpandn	%xmm14, %xmm12, %xmm7
vpand	%xmm13, %xmm12, %xmm6
vmovdqa	%xmm4, 0x60(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpunpckldq	%xmm9, %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
prefetcht0	0x3f(%r9)
vpxor	%xmm7, %xmm6, %xmm6
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
prefetcht0	0x3f(%r10)
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
prefetcht0	0x3f(%r11)
vpshufb	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vmovdqa	-0x70(%rax), %xmm2
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x60(%rax), %xmm3
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpandn	%xmm13, %xmm11, %xmm7
vpand	%xmm12, %xmm11, %xmm6
vmovdqa	%xmm0, 0x70(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x50(%rax), %xmm4
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpandn	%xmm12, %xmm10, %xmm7
vpand	%xmm11, %xmm10, %xmm6
vmovdqa	%xmm1, -0x80(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	0x10(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x40(%rax), %xmm0
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpandn	%xmm11, %xmm14, %xmm7
vpand	%xmm10, %xmm14, %xmm6
vmovdqa	%xmm2, -0x70(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	0x20(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	-0x30(%rax), %xmm1
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpandn	%xmm10, %xmm13, %xmm7
vpand	%xmm14, %xmm13, %xmm6
vmovdqa	%xmm3, -0x60(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	0x30(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	-0x20(%rax), %xmm2
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpandn	%xmm14, %xmm12, %xmm7
vpand	%xmm13, %xmm12, %xmm6
vmovdqa	%xmm4, -0x50(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	0x40(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vmovdqa	(%rbp), %xmm15
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x10(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, -0x40(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	0x50(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, -0x30(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	0x60(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	0x10(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vmovdqa	%xmm2, -0x20(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	0x70(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	0x20(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vmovdqa	%xmm3, -0x10(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	-0x80(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	0x30(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vmovdqa	%xmm4, (%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	-0x70(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	0x40(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, 0x10(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	-0x60(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	0x50(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, 0x20(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	-0x50(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	0x60(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vmovdqa	%xmm2, 0x30(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	-0x40(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	0x70(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vmovdqa	%xmm3, 0x40(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	-0x30(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	-0x80(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vmovdqa	%xmm4, 0x50(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	-0x20(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x70(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, 0x60(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	-0x10(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x60(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, 0x70(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x50(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vmovdqa	%xmm2, -0x80(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	0x10(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	-0x40(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vmovdqa	%xmm3, -0x70(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	0x20(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	-0x30(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vmovdqa	%xmm4, -0x60(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	0x30(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x20(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, -0x50(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	0x40(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x10(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, -0x40(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	0x50(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vmovdqa	%xmm2, -0x30(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	0x60(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	0x10(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vmovdqa	%xmm3, -0x20(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	0x70(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	0x20(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vmovdqa	%xmm4, -0x10(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	-0x80(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vmovdqa	0x20(%rbp), %xmm15
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	0x30(%rax), %xmm3
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpand	%xmm12, %xmm13, %xmm7
vpxor	-0x70(%rax), %xmm1, %xmm1
vpaddd	%xmm7, %xmm14, %xmm14
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm12, %xmm13, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vmovdqu	%xmm0, (%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm1, %xmm5
vpand	%xmm6, %xmm11, %xmm6
vpaddd	%xmm1, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	0x40(%rax), %xmm4
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpand	%xmm11, %xmm12, %xmm7
vpxor	-0x60(%rax), %xmm2, %xmm2
vpaddd	%xmm7, %xmm13, %xmm13
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm11, %xmm12, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vmovdqu	%xmm1, 0x10(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm2, %xmm5
vpand	%xmm6, %xmm10, %xmm6
vpaddd	%xmm2, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	0x50(%rax), %xmm0
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpand	%xmm10, %xmm11, %xmm7
vpxor	-0x50(%rax), %xmm3, %xmm3
vpaddd	%xmm7, %xmm12, %xmm12
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm10, %xmm11, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	%xmm2, 0x20(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm3, %xmm5
vpand	%xmm6, %xmm14, %xmm6
vpaddd	%xmm3, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	0x60(%rax), %xmm1
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpand	%xmm14, %xmm10, %xmm7
vpxor	-0x40(%rax), %xmm4, %xmm4
vpaddd	%xmm7, %xmm11, %xmm11
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm14, %xmm10, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vmovdqu	%xmm3, 0x30(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm4, %xmm5
vpand	%xmm6, %xmm13, %xmm6
vpaddd	%xmm4, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	0x70(%rax), %xmm2
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpand	%xmm13, %xmm14, %xmm7
vpxor	-0x30(%rax), %xmm0, %xmm0
vpaddd	%xmm7, %xmm10, %xmm10
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm13, %xmm14, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vmovdqu	%xmm4, 0x40(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm0, %xmm5
vpand	%xmm6, %xmm12, %xmm6
vpaddd	%xmm0, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x80(%rax), %xmm3
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpand	%xmm12, %xmm13, %xmm7
vpxor	-0x20(%rax), %xmm1, %xmm1
vpaddd	%xmm7, %xmm14, %xmm14
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm12, %xmm13, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vmovdqu	%xmm0, 0x50(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm1, %xmm5
vpand	%xmm6, %xmm11, %xmm6
vpaddd	%xmm1, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x70(%rax), %xmm4
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpand	%xmm11, %xmm12, %xmm7
vpxor	-0x10(%rax), %xmm2, %xmm2
vpaddd	%xmm7, %xmm13, %xmm13
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm11, %xmm12, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vmovdqu	%xmm1, 0x60(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm2, %xmm5
vpand	%xmm6, %xmm10, %xmm6
vpaddd	%xmm2, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x60(%rax), %xmm0
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpand	%xmm10, %xmm11, %xmm7
vpxor	(%rax), %xmm3, %xmm3
vpaddd	%xmm7, %xmm12, %xmm12
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm10, %xmm11, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	%xmm2, 0x70(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm3, %xmm5
vpand	%xmm6, %xmm14, %xmm6
vpaddd	%xmm3, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	-0x50(%rax), %xmm1
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpand	%xmm14, %xmm10, %xmm7
vpxor	0x10(%rax), %xmm4, %xmm4
vpaddd	%xmm7, %xmm11, %xmm11
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm14, %xmm10, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vmovdqu	%xmm3, -0x80(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm4, %xmm5
vpand	%xmm6, %xmm13, %xmm6
vpaddd	%xmm4, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	-0x40(%rax), %xmm2
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpand	%xmm13, %xmm14, %xmm7
vpxor	0x20(%rax), %xmm0, %xmm0
vpaddd	%xmm7, %xmm10, %xmm10
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm13, %xmm14, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vmovdqu	%xmm4, -0x70(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm0, %xmm5
vpand	%xmm6, %xmm12, %xmm6
vpaddd	%xmm0, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x30(%rax), %xmm3
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpand	%xmm12, %xmm13, %xmm7
vpxor	0x30(%rax), %xmm1, %xmm1
vpaddd	%xmm7, %xmm14, %xmm14
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm12, %xmm13, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vmovdqu	%xmm0, -0x60(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm1, %xmm5
vpand	%xmm6, %xmm11, %xmm6
vpaddd	%xmm1, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x20(%rax), %xmm4
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpand	%xmm11, %xmm12, %xmm7
vpxor	0x40(%rax), %xmm2, %xmm2
vpaddd	%xmm7, %xmm13, %xmm13
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm11, %xmm12, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vmovdqu	%xmm1, -0x50(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm2, %xmm5
vpand	%xmm6, %xmm10, %xmm6
vpaddd	%xmm2, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x10(%rax), %xmm0
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpand	%xmm10, %xmm11, %xmm7
vpxor	0x50(%rax), %xmm3, %xmm3
vpaddd	%xmm7, %xmm12, %xmm12
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm10, %xmm11, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	%xmm2, -0x40(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm3, %xmm5
vpand	%xmm6, %xmm14, %xmm6
vpaddd	%xmm3, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	(%rax), %xmm1
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpand	%xmm14, %xmm10, %xmm7
vpxor	0x60(%rax), %xmm4, %xmm4
vpaddd	%xmm7, %xmm11, %xmm11
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm14, %xmm10, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vmovdqu	%xmm3, -0x30(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm4, %xmm5
vpand	%xmm6, %xmm13, %xmm6
vpaddd	%xmm4, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	0x10(%rax), %xmm2
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpand	%xmm13, %xmm14, %xmm7
vpxor	0x70(%rax), %xmm0, %xmm0
vpaddd	%xmm7, %xmm10, %xmm10
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm13, %xmm14, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vmovdqu	%xmm4, -0x20(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm0, %xmm5
vpand	%xmm6, %xmm12, %xmm6
vpaddd	%xmm0, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	0x20(%rax), %xmm3
vpaddd	%xmm15, %xmm14, %xmm14
vpslld	$0x5, %xmm10, %xmm8
vpand	%xmm12, %xmm13, %xmm7
vpxor	-0x80(%rax), %xmm1, %xmm1
vpaddd	%xmm7, %xmm14, %xmm14
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm12, %xmm13, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vmovdqu	%xmm0, -0x10(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm1, %xmm5
vpand	%xmm6, %xmm11, %xmm6
vpaddd	%xmm1, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	0x30(%rax), %xmm4
vpaddd	%xmm15, %xmm13, %xmm13
vpslld	$0x5, %xmm14, %xmm8
vpand	%xmm11, %xmm12, %xmm7
vpxor	-0x70(%rax), %xmm2, %xmm2
vpaddd	%xmm7, %xmm13, %xmm13
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm11, %xmm12, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vmovdqu	%xmm1, (%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm2, %xmm5
vpand	%xmm6, %xmm10, %xmm6
vpaddd	%xmm2, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	0x40(%rax), %xmm0
vpaddd	%xmm15, %xmm12, %xmm12
vpslld	$0x5, %xmm13, %xmm8
vpand	%xmm10, %xmm11, %xmm7
vpxor	-0x60(%rax), %xmm3, %xmm3
vpaddd	%xmm7, %xmm12, %xmm12
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm10, %xmm11, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	%xmm2, 0x10(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm3, %xmm5
vpand	%xmm6, %xmm14, %xmm6
vpaddd	%xmm3, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	0x50(%rax), %xmm1
vpaddd	%xmm15, %xmm11, %xmm11
vpslld	$0x5, %xmm12, %xmm8
vpand	%xmm14, %xmm10, %xmm7
vpxor	-0x50(%rax), %xmm4, %xmm4
vpaddd	%xmm7, %xmm11, %xmm11
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm14, %xmm10, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vmovdqu	%xmm3, 0x20(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm4, %xmm5
vpand	%xmm6, %xmm13, %xmm6
vpaddd	%xmm4, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	0x60(%rax), %xmm2
vpaddd	%xmm15, %xmm10, %xmm10
vpslld	$0x5, %xmm11, %xmm8
vpand	%xmm13, %xmm14, %xmm7
vpxor	-0x40(%rax), %xmm0, %xmm0
vpaddd	%xmm7, %xmm10, %xmm10
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm13, %xmm14, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vmovdqu	%xmm4, 0x30(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpor	%xmm9, %xmm8, %xmm8
vpsrld	$0x1f, %xmm0, %xmm5
vpand	%xmm6, %xmm12, %xmm6
vpaddd	%xmm0, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vmovdqa	0x40(%rbp), %xmm15
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	0x70(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, 0x40(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	-0x30(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x80(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, 0x50(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	-0x20(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x70(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vmovdqa	%xmm2, 0x60(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	-0x10(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	-0x60(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vmovdqa	%xmm3, 0x70(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	-0x50(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vmovdqa	%xmm4, -0x80(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	0x10(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	-0x40(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, -0x70(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	0x20(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	-0x30(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, -0x60(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	0x30(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x20(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vmovdqa	%xmm2, -0x50(%rax)
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	0x40(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	-0x10(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vmovdqa	%xmm3, -0x40(%rax)
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	0x50(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vmovdqa	%xmm4, -0x30(%rax)
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	0x60(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	0x10(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vmovdqa	%xmm0, -0x20(%rax)
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	0x70(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	0x20(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vmovdqa	%xmm1, -0x10(%rax)
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	-0x80(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	0x30(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	-0x70(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	0x40(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	-0x60(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpxor	%xmm2, %xmm0, %xmm0
vmovdqa	0x50(%rax), %xmm2
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	-0x50(%rax), %xmm0, %xmm0
vpsrld	$0x1b, %xmm11, %xmm9
vpxor	%xmm6, %xmm13, %xmm6
vpxor	%xmm2, %xmm0, %xmm0
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x1f, %xmm0, %xmm5
vpaddd	%xmm0, %xmm0, %xmm0
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm5, %xmm0, %xmm0
vpor	%xmm7, %xmm12, %xmm12
vpxor	%xmm3, %xmm1, %xmm1
vmovdqa	0x60(%rax), %xmm3
vpslld	$0x5, %xmm10, %xmm8
vpaddd	%xmm15, %xmm14, %xmm14
vpxor	%xmm11, %xmm13, %xmm6
vpaddd	%xmm0, %xmm14, %xmm14
vpxor	-0x40(%rax), %xmm1, %xmm1
vpsrld	$0x1b, %xmm10, %xmm9
vpxor	%xmm6, %xmm12, %xmm6
vpxor	%xmm3, %xmm1, %xmm1
vpslld	$0x1e, %xmm11, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm14, %xmm14
vpsrld	$0x1f, %xmm1, %xmm5
vpaddd	%xmm1, %xmm1, %xmm1
vpsrld	$0x2, %xmm11, %xmm11
vpaddd	%xmm8, %xmm14, %xmm14
vpor	%xmm5, %xmm1, %xmm1
vpor	%xmm7, %xmm11, %xmm11
vpxor	%xmm4, %xmm2, %xmm2
vmovdqa	0x70(%rax), %xmm4
vpslld	$0x5, %xmm14, %xmm8
vpaddd	%xmm15, %xmm13, %xmm13
vpxor	%xmm10, %xmm12, %xmm6
vpaddd	%xmm1, %xmm13, %xmm13
vpxor	-0x30(%rax), %xmm2, %xmm2
vpsrld	$0x1b, %xmm14, %xmm9
vpxor	%xmm6, %xmm11, %xmm6
vpxor	%xmm4, %xmm2, %xmm2
vpslld	$0x1e, %xmm10, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm13, %xmm13
vpsrld	$0x1f, %xmm2, %xmm5
vpaddd	%xmm2, %xmm2, %xmm2
vpsrld	$0x2, %xmm10, %xmm10
vpaddd	%xmm8, %xmm13, %xmm13
vpor	%xmm5, %xmm2, %xmm2
vpor	%xmm7, %xmm10, %xmm10
vpxor	%xmm0, %xmm3, %xmm3
vmovdqa	-0x80(%rax), %xmm0
vpslld	$0x5, %xmm13, %xmm8
vpaddd	%xmm15, %xmm12, %xmm12
vpxor	%xmm14, %xmm11, %xmm6
vpaddd	%xmm2, %xmm12, %xmm12
vpxor	-0x20(%rax), %xmm3, %xmm3
vpsrld	$0x1b, %xmm13, %xmm9
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm0, %xmm3, %xmm3
vpslld	$0x1e, %xmm14, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpsrld	$0x1f, %xmm3, %xmm5
vpaddd	%xmm3, %xmm3, %xmm3
vpsrld	$0x2, %xmm14, %xmm14
vpaddd	%xmm8, %xmm12, %xmm12
vpor	%xmm5, %xmm3, %xmm3
vpor	%xmm7, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vmovdqa	-0x70(%rax), %xmm1
vpslld	$0x5, %xmm12, %xmm8
vpaddd	%xmm15, %xmm11, %xmm11
vpxor	%xmm13, %xmm10, %xmm6
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	-0x10(%rax), %xmm4, %xmm4
vpsrld	$0x1b, %xmm12, %xmm9
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm1, %xmm4, %xmm4
vpslld	$0x1e, %xmm13, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm11, %xmm11
vpsrld	$0x1f, %xmm4, %xmm5
vpaddd	%xmm4, %xmm4, %xmm4
vpsrld	$0x2, %xmm13, %xmm13
vpaddd	%xmm8, %xmm11, %xmm11
vpor	%xmm5, %xmm4, %xmm4
vpor	%xmm7, %xmm13, %xmm13
vpslld	$0x5, %xmm11, %xmm8
vpaddd	%xmm15, %xmm10, %xmm10
vpxor	%xmm12, %xmm14, %xmm6
vpsrld	$0x1b, %xmm11, %xmm9
vpaddd	%xmm4, %xmm10, %xmm10
vpxor	%xmm6, %xmm13, %xmm6
vpslld	$0x1e, %xmm12, %xmm7
vpor	%xmm9, %xmm8, %xmm8
vpaddd	%xmm6, %xmm10, %xmm10
vpsrld	$0x2, %xmm12, %xmm12
vpaddd	%xmm8, %xmm10, %xmm10
vpor	%xmm7, %xmm12, %xmm12
movl	$0x1, %ecx
cmpl	(%rbx), %ecx
cmovgeq	%rbp, %r8
cmpl	0x4(%rbx), %ecx
cmovgeq	%rbp, %r9
cmpl	0x8(%rbx), %ecx
cmovgeq	%rbp, %r10
cmpl	0xc(%rbx), %ecx
cmovgeq	%rbp, %r11
vmovdqu	(%rbx), %xmm6
vpxor	%xmm8, %xmm8, %xmm8
vmovdqa	%xmm6, %xmm7
vpcmpgtd	%xmm8, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpand	%xmm7, %xmm10, %xmm10
vpand	%xmm7, %xmm11, %xmm11
vpaddd	(%rdi), %xmm10, %xmm10
vpand	%xmm7, %xmm12, %xmm12
vpaddd	0x20(%rdi), %xmm11, %xmm11
vpand	%xmm7, %xmm13, %xmm13
vpaddd	0x40(%rdi), %xmm12, %xmm12
vpand	%xmm7, %xmm14, %xmm14
vpaddd	0x60(%rdi), %xmm13, %xmm13
vpaddd	0x80(%rdi), %xmm14, %xmm14
vmovdqu	%xmm10, (%rdi)
vmovdqu	%xmm11, 0x20(%rdi)
vmovdqu	%xmm12, 0x40(%rdi)
vmovdqu	%xmm13, 0x60(%rdi)
vmovdqu	%xmm14, 0x80(%rdi)
vmovdqu	%xmm6, (%rbx)
vmovdqu	0x60(%rbp), %xmm5
decl	%edx
jne	L_31e0
movl	0x118(%rsp), %edx
leaq	0x10(%rdi), %rdi
leaq	0x40(%rsi), %rsi
decl	%edx
jne	L_314d
L_51f9:
movq	0x110(%rsp), %rax
vzeroupper
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
_avx2_shortcut:
sha1_multi_block_avx2:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x240, %rsp
andq	$-0x100, %rsp
movq	%rax, 0x220(%rsp)
leaq	K_XX_XX(%rip), %rbp
shrl	%edx
vzeroupper
movl	%edx, 0x228(%rsp)
xorl	%edx, %edx
leaq	0x200(%rsp), %rbx
movq	(%rsi), %r12
movl	0x8(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, (%rbx)
cmovleq	%rbp, %r12
movq	0x10(%rsi), %r13
movl	0x18(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x4(%rbx)
cmovleq	%rbp, %r13
movq	0x20(%rsi), %r14
movl	0x28(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x8(%rbx)
cmovleq	%rbp, %r14
movq	0x30(%rsi), %r15
movl	0x38(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0xc(%rbx)
cmovleq	%rbp, %r15
movq	0x40(%rsi), %r8
movl	0x48(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x10(%rbx)
cmovleq	%rbp, %r8
movq	0x50(%rsi), %r9
movl	0x58(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x14(%rbx)
cmovleq	%rbp, %r9
movq	0x60(%rsi), %r10
movl	0x68(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x18(%rbx)
cmovleq	%rbp, %r10
movq	0x70(%rsi), %r11
movl	0x78(%rsi), %ecx
cmpl	%edx, %ecx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movl	%ecx, 0x1c(%rbx)
cmovleq	%rbp, %r11
vmovdqu	(%rdi), %ymm0
leaq	0x80(%rsp), %rax
vmovdqu	0x20(%rdi), %ymm1
leaq	0x180(%rsp), %rbx
vmovdqu	0x40(%rdi), %ymm2
vmovdqu	0x60(%rdi), %ymm3
vmovdqu	0x80(%rdi), %ymm4
vmovdqu	0x60(%rbp), %ymm9
jmp	L_5340
nopl	(%rax,%rax)
L_5340:
vmovdqa	-0x20(%rbp), %ymm15
vmovd	(%r12), %xmm10
leaq	0x40(%r12), %r12
vmovd	(%r8), %xmm12
leaq	0x40(%r8), %r8
vmovd	(%r13), %xmm7
leaq	0x40(%r13), %r13
vmovd	(%r9), %xmm6
leaq	0x40(%r9), %r9
vpinsrd	$0x1, (%r14), %xmm10, %xmm10
leaq	0x40(%r14), %r14
vpinsrd	$0x1, (%r10), %xmm12, %xmm12
leaq	0x40(%r10), %r10
vpinsrd	$0x1, (%r15), %xmm7, %xmm7
leaq	0x40(%r15), %r15
vpunpckldq	%ymm7, %ymm10, %ymm10
vpinsrd	$0x1, (%r11), %xmm6, %xmm6
leaq	0x40(%r11), %r11
vpunpckldq	%ymm6, %ymm12, %ymm12
vmovd	-0x3c(%r12), %xmm11
vinserti128	$0x1, %xmm12, %ymm10, %ymm10
vmovd	-0x3c(%r8), %xmm8
vpshufb	%ymm9, %ymm10, %ymm10
vmovd	-0x3c(%r13), %xmm7
vmovd	-0x3c(%r9), %xmm6
vpinsrd	$0x1, -0x3c(%r14), %xmm11, %xmm11
vpinsrd	$0x1, -0x3c(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x3c(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm11, %ymm11
vpinsrd	$0x1, -0x3c(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpandn	%ymm3, %ymm1, %ymm6
vpand	%ymm2, %ymm1, %ymm5
vmovdqa	%ymm10, -0x80(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vinserti128	$0x1, %xmm8, %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x38(%r12), %xmm12
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x38(%r8), %xmm8
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpshufb	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vmovd	-0x38(%r13), %xmm7
vmovd	-0x38(%r9), %xmm6
vpinsrd	$0x1, -0x38(%r14), %xmm12, %xmm12
vpinsrd	$0x1, -0x38(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x38(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm12, %ymm12
vpinsrd	$0x1, -0x38(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpandn	%ymm2, %ymm0, %ymm6
vpand	%ymm1, %ymm0, %ymm5
vmovdqa	%ymm11, -0x60(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vinserti128	$0x1, %xmm8, %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x34(%r12), %xmm13
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x34(%r8), %xmm8
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpshufb	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vmovd	-0x34(%r13), %xmm7
vmovd	-0x34(%r9), %xmm6
vpinsrd	$0x1, -0x34(%r14), %xmm13, %xmm13
vpinsrd	$0x1, -0x34(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x34(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm13, %ymm13
vpinsrd	$0x1, -0x34(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpandn	%ymm1, %ymm4, %ymm6
vpand	%ymm0, %ymm4, %ymm5
vmovdqa	%ymm12, -0x40(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vinserti128	$0x1, %xmm8, %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x30(%r12), %xmm14
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x30(%r8), %xmm8
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpshufb	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vmovd	-0x30(%r13), %xmm7
vmovd	-0x30(%r9), %xmm6
vpinsrd	$0x1, -0x30(%r14), %xmm14, %xmm14
vpinsrd	$0x1, -0x30(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x30(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm14, %ymm14
vpinsrd	$0x1, -0x30(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpandn	%ymm0, %ymm3, %ymm6
vpand	%ymm4, %ymm3, %ymm5
vmovdqa	%ymm13, -0x20(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vinserti128	$0x1, %xmm8, %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x2c(%r12), %xmm10
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x2c(%r8), %xmm8
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpshufb	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vmovd	-0x2c(%r13), %xmm7
vmovd	-0x2c(%r9), %xmm6
vpinsrd	$0x1, -0x2c(%r14), %xmm10, %xmm10
vpinsrd	$0x1, -0x2c(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x2c(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm10, %ymm10
vpinsrd	$0x1, -0x2c(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpandn	%ymm4, %ymm2, %ymm6
vpand	%ymm3, %ymm2, %ymm5
vmovdqa	%ymm14, (%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vinserti128	$0x1, %xmm8, %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x28(%r12), %xmm11
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x28(%r8), %xmm8
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpshufb	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vmovd	-0x28(%r13), %xmm7
vmovd	-0x28(%r9), %xmm6
vpinsrd	$0x1, -0x28(%r14), %xmm11, %xmm11
vpinsrd	$0x1, -0x28(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x28(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm11, %ymm11
vpinsrd	$0x1, -0x28(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpandn	%ymm3, %ymm1, %ymm6
vpand	%ymm2, %ymm1, %ymm5
vmovdqa	%ymm10, 0x20(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vinserti128	$0x1, %xmm8, %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x24(%r12), %xmm12
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x24(%r8), %xmm8
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpshufb	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vmovd	-0x24(%r13), %xmm7
vmovd	-0x24(%r9), %xmm6
vpinsrd	$0x1, -0x24(%r14), %xmm12, %xmm12
vpinsrd	$0x1, -0x24(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x24(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm12, %ymm12
vpinsrd	$0x1, -0x24(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpandn	%ymm2, %ymm0, %ymm6
vpand	%ymm1, %ymm0, %ymm5
vmovdqa	%ymm11, 0x40(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vinserti128	$0x1, %xmm8, %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x20(%r12), %xmm13
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x20(%r8), %xmm8
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpshufb	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vmovd	-0x20(%r13), %xmm7
vmovd	-0x20(%r9), %xmm6
vpinsrd	$0x1, -0x20(%r14), %xmm13, %xmm13
vpinsrd	$0x1, -0x20(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x20(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm13, %ymm13
vpinsrd	$0x1, -0x20(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpandn	%ymm1, %ymm4, %ymm6
vpand	%ymm0, %ymm4, %ymm5
vmovdqa	%ymm12, 0x60(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vinserti128	$0x1, %xmm8, %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x1c(%r12), %xmm14
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x1c(%r8), %xmm8
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpshufb	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vmovd	-0x1c(%r13), %xmm7
vmovd	-0x1c(%r9), %xmm6
vpinsrd	$0x1, -0x1c(%r14), %xmm14, %xmm14
vpinsrd	$0x1, -0x1c(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x1c(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm14, %ymm14
vpinsrd	$0x1, -0x1c(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpandn	%ymm0, %ymm3, %ymm6
vpand	%ymm4, %ymm3, %ymm5
vmovdqa	%ymm13, -0x80(%rbx)
vpaddd	%ymm1, %ymm13, %ymm1
vinserti128	$0x1, %xmm8, %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x18(%r12), %xmm10
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x18(%r8), %xmm8
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpshufb	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vmovd	-0x18(%r13), %xmm7
vmovd	-0x18(%r9), %xmm6
vpinsrd	$0x1, -0x18(%r14), %xmm10, %xmm10
vpinsrd	$0x1, -0x18(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x18(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm10, %ymm10
vpinsrd	$0x1, -0x18(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpandn	%ymm4, %ymm2, %ymm6
vpand	%ymm3, %ymm2, %ymm5
vmovdqa	%ymm14, -0x60(%rbx)
vpaddd	%ymm0, %ymm14, %ymm0
vinserti128	$0x1, %xmm8, %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x14(%r12), %xmm11
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x14(%r8), %xmm8
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpshufb	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vmovd	-0x14(%r13), %xmm7
vmovd	-0x14(%r9), %xmm6
vpinsrd	$0x1, -0x14(%r14), %xmm11, %xmm11
vpinsrd	$0x1, -0x14(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x14(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm11, %ymm11
vpinsrd	$0x1, -0x14(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpandn	%ymm3, %ymm1, %ymm6
vpand	%ymm2, %ymm1, %ymm5
vmovdqa	%ymm10, -0x40(%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vinserti128	$0x1, %xmm8, %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x10(%r12), %xmm12
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x10(%r8), %xmm8
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpshufb	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vmovd	-0x10(%r13), %xmm7
vmovd	-0x10(%r9), %xmm6
vpinsrd	$0x1, -0x10(%r14), %xmm12, %xmm12
vpinsrd	$0x1, -0x10(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x10(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm12, %ymm12
vpinsrd	$0x1, -0x10(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpandn	%ymm2, %ymm0, %ymm6
vpand	%ymm1, %ymm0, %ymm5
vmovdqa	%ymm11, -0x20(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vinserti128	$0x1, %xmm8, %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0xc(%r12), %xmm13
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0xc(%r8), %xmm8
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpshufb	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vmovd	-0xc(%r13), %xmm7
vmovd	-0xc(%r9), %xmm6
vpinsrd	$0x1, -0xc(%r14), %xmm13, %xmm13
vpinsrd	$0x1, -0xc(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0xc(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm13, %ymm13
vpinsrd	$0x1, -0xc(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpandn	%ymm1, %ymm4, %ymm6
vpand	%ymm0, %ymm4, %ymm5
vmovdqa	%ymm12, (%rbx)
vpaddd	%ymm2, %ymm12, %ymm2
vinserti128	$0x1, %xmm8, %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x8(%r12), %xmm14
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x8(%r8), %xmm8
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpshufb	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vmovd	-0x8(%r13), %xmm7
vmovd	-0x8(%r9), %xmm6
vpinsrd	$0x1, -0x8(%r14), %xmm14, %xmm14
vpinsrd	$0x1, -0x8(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x8(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm14, %ymm14
vpinsrd	$0x1, -0x8(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpandn	%ymm0, %ymm3, %ymm6
vpand	%ymm4, %ymm3, %ymm5
vmovdqa	%ymm13, 0x20(%rbx)
vpaddd	%ymm1, %ymm13, %ymm1
vinserti128	$0x1, %xmm8, %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vmovd	-0x4(%r12), %xmm10
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vmovd	-0x4(%r8), %xmm8
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpshufb	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vmovdqa	-0x80(%rax), %ymm11
vmovd	-0x4(%r13), %xmm7
vmovd	-0x4(%r9), %xmm6
vpinsrd	$0x1, -0x4(%r14), %xmm10, %xmm10
vpinsrd	$0x1, -0x4(%r10), %xmm8, %xmm8
vpinsrd	$0x1, -0x4(%r15), %xmm7, %xmm7
vpunpckldq	%ymm7, %ymm10, %ymm10
vpinsrd	$0x1, -0x4(%r11), %xmm6, %xmm6
vpunpckldq	%ymm6, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm0
prefetcht0	0x3f(%r12)
vpslld	$0x5, %ymm1, %ymm7
vpandn	%ymm4, %ymm2, %ymm6
vpand	%ymm3, %ymm2, %ymm5
vmovdqa	%ymm14, 0x40(%rbx)
vpaddd	%ymm0, %ymm14, %ymm0
vinserti128	$0x1, %xmm8, %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
prefetcht0	0x3f(%r13)
vpxor	%ymm6, %ymm5, %ymm5
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
prefetcht0	0x3f(%r14)
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
prefetcht0	0x3f(%r15)
vpshufb	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vmovdqa	-0x60(%rax), %ymm12
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	-0x40(%rax), %ymm13
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpandn	%ymm3, %ymm1, %ymm6
prefetcht0	0x3f(%r8)
vpand	%ymm2, %ymm1, %ymm5
vmovdqa	%ymm10, 0x60(%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	-0x80(%rbx), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
prefetcht0	0x3f(%r9)
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
prefetcht0	0x3f(%r10)
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
prefetcht0	0x3f(%r11)
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x20(%rax), %ymm14
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpandn	%ymm2, %ymm0, %ymm6
vpand	%ymm1, %ymm0, %ymm5
vmovdqa	%ymm11, -0x80(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	-0x60(%rbx), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	(%rax), %ymm10
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpandn	%ymm1, %ymm4, %ymm6
vpand	%ymm0, %ymm4, %ymm5
vmovdqa	%ymm12, -0x60(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	-0x40(%rbx), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	0x20(%rax), %ymm11
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpandn	%ymm0, %ymm3, %ymm6
vpand	%ymm4, %ymm3, %ymm5
vmovdqa	%ymm13, -0x40(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	-0x20(%rbx), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	0x40(%rax), %ymm12
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpandn	%ymm4, %ymm2, %ymm6
vpand	%ymm3, %ymm2, %ymm5
vmovdqa	%ymm14, -0x20(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	(%rbx), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm6, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vmovdqa	(%rbp), %ymm15
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	0x60(%rax), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, (%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	0x20(%rbx), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x80(%rbx), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, 0x20(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	0x40(%rbx), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x60(%rbx), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vmovdqa	%ymm12, 0x40(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	0x60(%rbx), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	-0x40(%rbx), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vmovdqa	%ymm13, 0x60(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	-0x80(%rax), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	-0x20(%rbx), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vmovdqa	%ymm14, -0x80(%rbx)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	-0x60(%rax), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	(%rbx), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, -0x60(%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	-0x40(%rax), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	0x20(%rbx), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, -0x40(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	-0x20(%rax), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	0x40(%rbx), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vmovdqa	%ymm12, -0x20(%rbx)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	(%rax), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	0x60(%rbx), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vmovdqa	%ymm13, (%rbx)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	0x20(%rax), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	-0x80(%rax), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vmovdqa	%ymm14, 0x20(%rbx)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	0x40(%rax), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	-0x60(%rax), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, 0x40(%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	0x60(%rax), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x40(%rax), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, 0x60(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	-0x80(%rbx), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x20(%rax), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vmovdqa	%ymm12, -0x80(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	-0x60(%rbx), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	(%rax), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vmovdqa	%ymm13, -0x60(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	-0x40(%rbx), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	0x20(%rax), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vmovdqa	%ymm14, -0x40(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	-0x20(%rbx), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	0x40(%rax), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, -0x20(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	(%rbx), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	0x60(%rax), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, (%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	0x20(%rbx), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x80(%rbx), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vmovdqa	%ymm12, 0x20(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	0x40(%rbx), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	-0x60(%rbx), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vmovdqa	%ymm13, 0x40(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	0x60(%rbx), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	-0x40(%rbx), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vmovdqa	%ymm14, 0x60(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	-0x80(%rax), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vmovdqa	0x20(%rbp), %ymm15
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	-0x20(%rbx), %ymm13
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpand	%ymm2, %ymm3, %ymm6
vpxor	-0x60(%rax), %ymm11, %ymm11
vpaddd	%ymm6, %ymm4, %ymm4
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm3, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vmovdqu	%ymm10, -0x80(%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm11, %ymm9
vpand	%ymm1, %ymm5, %ymm5
vpaddd	%ymm11, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	(%rbx), %ymm14
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpand	%ymm1, %ymm2, %ymm6
vpxor	-0x40(%rax), %ymm12, %ymm12
vpaddd	%ymm6, %ymm3, %ymm3
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm2, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vmovdqu	%ymm11, -0x60(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm12, %ymm9
vpand	%ymm0, %ymm5, %ymm5
vpaddd	%ymm12, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	0x20(%rbx), %ymm10
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpand	%ymm0, %ymm1, %ymm6
vpxor	-0x20(%rax), %ymm13, %ymm13
vpaddd	%ymm6, %ymm2, %ymm2
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm1, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vmovdqu	%ymm12, -0x40(%rbx)
vpaddd	%ymm2, %ymm12, %ymm2
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm13, %ymm9
vpand	%ymm4, %ymm5, %ymm5
vpaddd	%ymm13, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	0x40(%rbx), %ymm11
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpand	%ymm4, %ymm0, %ymm6
vpxor	(%rax), %ymm14, %ymm14
vpaddd	%ymm6, %ymm1, %ymm1
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm0, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vmovdqu	%ymm13, -0x20(%rbx)
vpaddd	%ymm1, %ymm13, %ymm1
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm14, %ymm9
vpand	%ymm3, %ymm5, %ymm5
vpaddd	%ymm14, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	0x60(%rbx), %ymm12
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpand	%ymm3, %ymm4, %ymm6
vpxor	0x20(%rax), %ymm10, %ymm10
vpaddd	%ymm6, %ymm0, %ymm0
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm4, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vmovdqu	%ymm14, (%rbx)
vpaddd	%ymm0, %ymm14, %ymm0
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm10, %ymm9
vpand	%ymm2, %ymm5, %ymm5
vpaddd	%ymm10, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	-0x80(%rax), %ymm13
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpand	%ymm2, %ymm3, %ymm6
vpxor	0x40(%rax), %ymm11, %ymm11
vpaddd	%ymm6, %ymm4, %ymm4
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm3, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vmovdqu	%ymm10, 0x20(%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm11, %ymm9
vpand	%ymm1, %ymm5, %ymm5
vpaddd	%ymm11, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x60(%rax), %ymm14
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpand	%ymm1, %ymm2, %ymm6
vpxor	0x60(%rax), %ymm12, %ymm12
vpaddd	%ymm6, %ymm3, %ymm3
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm2, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vmovdqu	%ymm11, 0x40(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm12, %ymm9
vpand	%ymm0, %ymm5, %ymm5
vpaddd	%ymm12, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x40(%rax), %ymm10
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpand	%ymm0, %ymm1, %ymm6
vpxor	-0x80(%rbx), %ymm13, %ymm13
vpaddd	%ymm6, %ymm2, %ymm2
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm1, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vmovdqu	%ymm12, 0x60(%rbx)
vpaddd	%ymm2, %ymm12, %ymm2
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm13, %ymm9
vpand	%ymm4, %ymm5, %ymm5
vpaddd	%ymm13, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	-0x20(%rax), %ymm11
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpand	%ymm4, %ymm0, %ymm6
vpxor	-0x60(%rbx), %ymm14, %ymm14
vpaddd	%ymm6, %ymm1, %ymm1
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm0, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vmovdqu	%ymm13, -0x80(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm14, %ymm9
vpand	%ymm3, %ymm5, %ymm5
vpaddd	%ymm14, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	(%rax), %ymm12
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpand	%ymm3, %ymm4, %ymm6
vpxor	-0x40(%rbx), %ymm10, %ymm10
vpaddd	%ymm6, %ymm0, %ymm0
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm4, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vmovdqu	%ymm14, -0x60(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm10, %ymm9
vpand	%ymm2, %ymm5, %ymm5
vpaddd	%ymm10, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	0x20(%rax), %ymm13
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpand	%ymm2, %ymm3, %ymm6
vpxor	-0x20(%rbx), %ymm11, %ymm11
vpaddd	%ymm6, %ymm4, %ymm4
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm3, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vmovdqu	%ymm10, -0x40(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm11, %ymm9
vpand	%ymm1, %ymm5, %ymm5
vpaddd	%ymm11, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	0x40(%rax), %ymm14
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpand	%ymm1, %ymm2, %ymm6
vpxor	(%rbx), %ymm12, %ymm12
vpaddd	%ymm6, %ymm3, %ymm3
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm2, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vmovdqu	%ymm11, -0x20(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm12, %ymm9
vpand	%ymm0, %ymm5, %ymm5
vpaddd	%ymm12, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	0x60(%rax), %ymm10
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpand	%ymm0, %ymm1, %ymm6
vpxor	0x20(%rbx), %ymm13, %ymm13
vpaddd	%ymm6, %ymm2, %ymm2
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm1, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vmovdqu	%ymm12, (%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm13, %ymm9
vpand	%ymm4, %ymm5, %ymm5
vpaddd	%ymm13, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	-0x80(%rbx), %ymm11
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpand	%ymm4, %ymm0, %ymm6
vpxor	0x40(%rbx), %ymm14, %ymm14
vpaddd	%ymm6, %ymm1, %ymm1
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm0, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vmovdqu	%ymm13, 0x20(%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm14, %ymm9
vpand	%ymm3, %ymm5, %ymm5
vpaddd	%ymm14, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	-0x60(%rbx), %ymm12
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpand	%ymm3, %ymm4, %ymm6
vpxor	0x60(%rbx), %ymm10, %ymm10
vpaddd	%ymm6, %ymm0, %ymm0
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm4, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vmovdqu	%ymm14, 0x40(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm10, %ymm9
vpand	%ymm2, %ymm5, %ymm5
vpaddd	%ymm10, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	-0x40(%rbx), %ymm13
vpaddd	%ymm4, %ymm15, %ymm4
vpslld	$0x5, %ymm0, %ymm7
vpand	%ymm2, %ymm3, %ymm6
vpxor	-0x80(%rax), %ymm11, %ymm11
vpaddd	%ymm6, %ymm4, %ymm4
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm3, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vmovdqu	%ymm10, 0x60(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm11, %ymm9
vpand	%ymm1, %ymm5, %ymm5
vpaddd	%ymm11, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x20(%rbx), %ymm14
vpaddd	%ymm3, %ymm15, %ymm3
vpslld	$0x5, %ymm4, %ymm7
vpand	%ymm1, %ymm2, %ymm6
vpxor	-0x60(%rax), %ymm12, %ymm12
vpaddd	%ymm6, %ymm3, %ymm3
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm2, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vmovdqu	%ymm11, -0x80(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm12, %ymm9
vpand	%ymm0, %ymm5, %ymm5
vpaddd	%ymm12, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	(%rbx), %ymm10
vpaddd	%ymm2, %ymm15, %ymm2
vpslld	$0x5, %ymm3, %ymm7
vpand	%ymm0, %ymm1, %ymm6
vpxor	-0x40(%rax), %ymm13, %ymm13
vpaddd	%ymm6, %ymm2, %ymm2
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm1, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vmovdqu	%ymm12, -0x60(%rbx)
vpaddd	%ymm2, %ymm12, %ymm2
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm13, %ymm9
vpand	%ymm4, %ymm5, %ymm5
vpaddd	%ymm13, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	0x20(%rbx), %ymm11
vpaddd	%ymm1, %ymm15, %ymm1
vpslld	$0x5, %ymm2, %ymm7
vpand	%ymm4, %ymm0, %ymm6
vpxor	-0x20(%rax), %ymm14, %ymm14
vpaddd	%ymm6, %ymm1, %ymm1
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm0, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vmovdqu	%ymm13, -0x40(%rbx)
vpaddd	%ymm1, %ymm13, %ymm1
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm14, %ymm9
vpand	%ymm3, %ymm5, %ymm5
vpaddd	%ymm14, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	0x40(%rbx), %ymm12
vpaddd	%ymm0, %ymm15, %ymm0
vpslld	$0x5, %ymm1, %ymm7
vpand	%ymm3, %ymm4, %ymm6
vpxor	(%rax), %ymm10, %ymm10
vpaddd	%ymm6, %ymm0, %ymm0
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm4, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vmovdqu	%ymm14, -0x20(%rbx)
vpaddd	%ymm0, %ymm14, %ymm0
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm10, %ymm9
vpand	%ymm2, %ymm5, %ymm5
vpaddd	%ymm10, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vmovdqa	0x40(%rbp), %ymm15
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	0x60(%rbx), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, (%rbx)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	0x20(%rax), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x80(%rax), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, 0x20(%rbx)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	0x40(%rax), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x60(%rax), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vmovdqa	%ymm12, 0x40(%rbx)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	0x60(%rax), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	-0x40(%rax), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vmovdqa	%ymm13, 0x60(%rbx)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	-0x80(%rbx), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	-0x20(%rax), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vmovdqa	%ymm14, -0x80(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	-0x60(%rbx), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	(%rax), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, -0x60(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	-0x40(%rbx), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	0x20(%rax), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, -0x40(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	-0x20(%rbx), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	0x40(%rax), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vmovdqa	%ymm12, -0x20(%rax)
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	(%rbx), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	0x60(%rax), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vmovdqa	%ymm13, (%rax)
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	0x20(%rbx), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	-0x80(%rbx), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vmovdqa	%ymm14, 0x20(%rax)
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	0x40(%rbx), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	-0x60(%rbx), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vmovdqa	%ymm10, 0x40(%rax)
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	0x60(%rbx), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	-0x40(%rbx), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vmovdqa	%ymm11, 0x60(%rax)
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	-0x80(%rax), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x20(%rbx), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	-0x60(%rax), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	(%rbx), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	-0x40(%rax), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpxor	%ymm12, %ymm10, %ymm10
vmovdqa	0x20(%rbx), %ymm12
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	-0x20(%rax), %ymm10, %ymm10
vpsrld	$0x1b, %ymm1, %ymm8
vpxor	%ymm3, %ymm5, %ymm5
vpxor	%ymm12, %ymm10, %ymm10
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x1f, %ymm10, %ymm9
vpaddd	%ymm10, %ymm10, %ymm10
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm9, %ymm10, %ymm10
vpor	%ymm6, %ymm2, %ymm2
vpxor	%ymm13, %ymm11, %ymm11
vmovdqa	0x40(%rbx), %ymm13
vpslld	$0x5, %ymm0, %ymm7
vpaddd	%ymm4, %ymm15, %ymm4
vpxor	%ymm1, %ymm3, %ymm5
vpaddd	%ymm4, %ymm10, %ymm4
vpxor	(%rax), %ymm11, %ymm11
vpsrld	$0x1b, %ymm0, %ymm8
vpxor	%ymm2, %ymm5, %ymm5
vpxor	%ymm13, %ymm11, %ymm11
vpslld	$0x1e, %ymm1, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm4, %ymm4
vpsrld	$0x1f, %ymm11, %ymm9
vpaddd	%ymm11, %ymm11, %ymm11
vpsrld	$0x2, %ymm1, %ymm1
vpaddd	%ymm7, %ymm4, %ymm4
vpor	%ymm9, %ymm11, %ymm11
vpor	%ymm6, %ymm1, %ymm1
vpxor	%ymm14, %ymm12, %ymm12
vmovdqa	0x60(%rbx), %ymm14
vpslld	$0x5, %ymm4, %ymm7
vpaddd	%ymm3, %ymm15, %ymm3
vpxor	%ymm0, %ymm2, %ymm5
vpaddd	%ymm3, %ymm11, %ymm3
vpxor	0x20(%rax), %ymm12, %ymm12
vpsrld	$0x1b, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm14, %ymm12, %ymm12
vpslld	$0x1e, %ymm0, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm3, %ymm3
vpsrld	$0x1f, %ymm12, %ymm9
vpaddd	%ymm12, %ymm12, %ymm12
vpsrld	$0x2, %ymm0, %ymm0
vpaddd	%ymm7, %ymm3, %ymm3
vpor	%ymm9, %ymm12, %ymm12
vpor	%ymm6, %ymm0, %ymm0
vpxor	%ymm10, %ymm13, %ymm13
vmovdqa	-0x80(%rax), %ymm10
vpslld	$0x5, %ymm3, %ymm7
vpaddd	%ymm2, %ymm15, %ymm2
vpxor	%ymm4, %ymm1, %ymm5
vpaddd	%ymm2, %ymm12, %ymm2
vpxor	0x40(%rax), %ymm13, %ymm13
vpsrld	$0x1b, %ymm3, %ymm8
vpxor	%ymm0, %ymm5, %ymm5
vpxor	%ymm10, %ymm13, %ymm13
vpslld	$0x1e, %ymm4, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm2, %ymm2
vpsrld	$0x1f, %ymm13, %ymm9
vpaddd	%ymm13, %ymm13, %ymm13
vpsrld	$0x2, %ymm4, %ymm4
vpaddd	%ymm7, %ymm2, %ymm2
vpor	%ymm9, %ymm13, %ymm13
vpor	%ymm6, %ymm4, %ymm4
vpxor	%ymm11, %ymm14, %ymm14
vmovdqa	-0x60(%rax), %ymm11
vpslld	$0x5, %ymm2, %ymm7
vpaddd	%ymm1, %ymm15, %ymm1
vpxor	%ymm3, %ymm0, %ymm5
vpaddd	%ymm1, %ymm13, %ymm1
vpxor	0x60(%rax), %ymm14, %ymm14
vpsrld	$0x1b, %ymm2, %ymm8
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm11, %ymm14, %ymm14
vpslld	$0x1e, %ymm3, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm1, %ymm1
vpsrld	$0x1f, %ymm14, %ymm9
vpaddd	%ymm14, %ymm14, %ymm14
vpsrld	$0x2, %ymm3, %ymm3
vpaddd	%ymm7, %ymm1, %ymm1
vpor	%ymm9, %ymm14, %ymm14
vpor	%ymm6, %ymm3, %ymm3
vpslld	$0x5, %ymm1, %ymm7
vpaddd	%ymm0, %ymm15, %ymm0
vpxor	%ymm2, %ymm4, %ymm5
vpsrld	$0x1b, %ymm1, %ymm8
vpaddd	%ymm0, %ymm14, %ymm0
vpxor	%ymm3, %ymm5, %ymm5
vpslld	$0x1e, %ymm2, %ymm6
vpor	%ymm7, %ymm8, %ymm7
vpaddd	%ymm5, %ymm0, %ymm0
vpsrld	$0x2, %ymm2, %ymm2
vpaddd	%ymm7, %ymm0, %ymm0
vpor	%ymm6, %ymm2, %ymm2
movl	$0x1, %ecx
leaq	0x200(%rsp), %rbx
cmpl	(%rbx), %ecx
cmovgeq	%rbp, %r12
cmpl	0x4(%rbx), %ecx
cmovgeq	%rbp, %r13
cmpl	0x8(%rbx), %ecx
cmovgeq	%rbp, %r14
cmpl	0xc(%rbx), %ecx
cmovgeq	%rbp, %r15
cmpl	0x10(%rbx), %ecx
cmovgeq	%rbp, %r8
cmpl	0x14(%rbx), %ecx
cmovgeq	%rbp, %r9
cmpl	0x18(%rbx), %ecx
cmovgeq	%rbp, %r10
cmpl	0x1c(%rbx), %ecx
cmovgeq	%rbp, %r11
vmovdqu	(%rbx), %ymm5
vpxor	%ymm7, %ymm7, %ymm7
vmovdqa	%ymm5, %ymm6
vpcmpgtd	%ymm7, %ymm6, %ymm6
vpaddd	%ymm6, %ymm5, %ymm5
vpand	%ymm6, %ymm0, %ymm0
vpand	%ymm6, %ymm1, %ymm1
vpaddd	(%rdi), %ymm0, %ymm0
vpand	%ymm6, %ymm2, %ymm2
vpaddd	0x20(%rdi), %ymm1, %ymm1
vpand	%ymm6, %ymm3, %ymm3
vpaddd	0x40(%rdi), %ymm2, %ymm2
vpand	%ymm6, %ymm4, %ymm4
vpaddd	0x60(%rdi), %ymm3, %ymm3
vpaddd	0x80(%rdi), %ymm4, %ymm4
vmovdqu	%ymm0, (%rdi)
vmovdqu	%ymm1, 0x20(%rdi)
vmovdqu	%ymm2, 0x40(%rdi)
vmovdqu	%ymm3, 0x60(%rdi)
vmovdqu	%ymm4, 0x80(%rdi)
vmovdqu	%ymm5, (%rbx)
leaq	0x180(%rsp), %rbx
vmovdqu	0x60(%rbp), %ymm9
decl	%edx
jne	L_5340
movq	0x220(%rsp), %rax
vzeroupper
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
	.section .rodata
	.byte 153,121,130,90,153,121,130,90,153,121,130,90,153,121,130,90
	.byte 153,121,130,90,153,121,130,90,153,121,130,90,153,121,130,90
K_XX_XX:
	.byte 161,235,217,110,161,235,217,110,161,235,217,110,161,235,217,110
	.byte 161,235,217,110,161,235,217,110,161,235,217,110,161,235,217,110
	.byte 220,188,27,143,220,188,27,143,220,188,27,143,220,188,27,143
	.byte 220,188,27,143,220,188,27,143,220,188,27,143,220,188,27,143
	.byte 214,193,98,202,214,193,98,202,214,193,98,202,214,193,98,202
	.byte 214,193,98,202,214,193,98,202,214,193,98,202,214,193,98,202
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 83,72,65,49,32,109,117,108,116,105,45,98,108,111,99,107
	.byte 32,116,114,97,110,115,102,111,114,109,32,102,111,114,32,120
	.byte 56,54,95,54,52,44,32,67,82,89,80,84,79,71,65,77
	.byte 83,32,98,121,32,60,104,116,116,112,115,58,47,47,103,105
	.byte 116,104,117,98,46,99,111,109,47,100,111,116,45,97,115,109
	.byte 62,0

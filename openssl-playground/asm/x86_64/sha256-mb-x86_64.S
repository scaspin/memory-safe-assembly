	.text
sha256_multi_block:
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
leaq	K256+128(%rip), %rbp
leaq	0x100(%rsp), %rbx
leaq	0x80(%rdi), %rdi
L_4f:
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
je	L_27ce
movdqu	-0x80(%rdi), %xmm8
leaq	0x80(%rsp), %rax
movdqu	-0x60(%rdi), %xmm9
movdqu	-0x40(%rdi), %xmm10
movdqu	-0x20(%rdi), %xmm11
movdqu	(%rdi), %xmm12
movdqu	0x20(%rdi), %xmm13
movdqu	0x40(%rdi), %xmm14
movdqu	0x60(%rdi), %xmm15
movdqu	K256_shaext-32(%rip), %xmm6
jmp	L_100
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_100:
movdqa	%xmm10, %xmm4
pxor	%xmm9, %xmm4
movd	(%r8), %xmm5
movd	(%r9), %xmm0
movd	(%r10), %xmm1
movd	(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm12, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm12, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm12, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x80(%rax)
paddd	%xmm15, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x80(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm12, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm14, %xmm0
pand	%xmm13, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm8, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm9, %xmm3
movdqa	%xmm8, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm8, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm9, %xmm15
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm15
paddd	%xmm5, %xmm11
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm15
paddd	%xmm7, %xmm15
movd	0x4(%r8), %xmm5
movd	0x4(%r9), %xmm0
movd	0x4(%r10), %xmm1
movd	0x4(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm11, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x70(%rax)
paddd	%xmm14, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x60(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm11, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm13, %xmm0
pand	%xmm12, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm15, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm8, %xmm4
movdqa	%xmm15, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm15, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm8, %xmm14
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm14
paddd	%xmm5, %xmm10
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm14
paddd	%xmm7, %xmm14
movd	0x8(%r8), %xmm5
movd	0x8(%r9), %xmm0
movd	0x8(%r10), %xmm1
movd	0x8(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm10, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm10, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm10, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x60(%rax)
paddd	%xmm13, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm10, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm12, %xmm0
pand	%xmm11, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm14, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm15, %xmm3
movdqa	%xmm14, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm14, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm15, %xmm13
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm13
paddd	%xmm5, %xmm9
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm13
paddd	%xmm7, %xmm13
movd	0xc(%r8), %xmm5
movd	0xc(%r9), %xmm0
movd	0xc(%r10), %xmm1
movd	0xc(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm9, %xmm7
movdqa	%xmm9, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm9, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x50(%rax)
paddd	%xmm12, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x20(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm9, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm11, %xmm0
pand	%xmm10, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm13, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm14, %xmm4
movdqa	%xmm13, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm13, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm14, %xmm12
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm12
paddd	%xmm5, %xmm8
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm12
paddd	%xmm7, %xmm12
movd	0x10(%r8), %xmm5
movd	0x10(%r9), %xmm0
movd	0x10(%r10), %xmm1
movd	0x10(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm8, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm8, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm8, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x40(%rax)
paddd	%xmm11, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm8, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm10, %xmm0
pand	%xmm9, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm12, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm13, %xmm3
movdqa	%xmm12, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm12, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm13, %xmm11
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm11
paddd	%xmm5, %xmm15
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm11
paddd	%xmm7, %xmm11
movd	0x14(%r8), %xmm5
movd	0x14(%r9), %xmm0
movd	0x14(%r10), %xmm1
movd	0x14(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm15, %xmm7
movdqa	%xmm15, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm15, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x30(%rax)
paddd	%xmm10, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x20(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm15, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm9, %xmm0
pand	%xmm8, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm11, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm12, %xmm4
movdqa	%xmm11, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm11, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm12, %xmm10
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm10
paddd	%xmm5, %xmm14
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm10
paddd	%xmm7, %xmm10
movd	0x18(%r8), %xmm5
movd	0x18(%r9), %xmm0
movd	0x18(%r10), %xmm1
movd	0x18(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm14, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm14, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm14, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x20(%rax)
paddd	%xmm9, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm14, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm8, %xmm0
pand	%xmm15, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm10, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm11, %xmm3
movdqa	%xmm10, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm10, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm11, %xmm9
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm9
paddd	%xmm5, %xmm13
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm9
paddd	%xmm7, %xmm9
movd	0x1c(%r8), %xmm5
movd	0x1c(%r9), %xmm0
movd	0x1c(%r10), %xmm1
movd	0x1c(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm13, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x10(%rax)
paddd	%xmm8, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x60(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm13, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm15, %xmm0
pand	%xmm14, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm9, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm10, %xmm4
movdqa	%xmm9, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm9, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm10, %xmm8
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm8
paddd	%xmm5, %xmm12
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm8
paddd	%xmm7, %xmm8
leaq	0x100(%rbp), %rbp
movd	0x20(%r8), %xmm5
movd	0x20(%r9), %xmm0
movd	0x20(%r10), %xmm1
movd	0x20(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm12, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm12, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm12, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, (%rax)
paddd	%xmm15, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x80(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm12, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm14, %xmm0
pand	%xmm13, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm8, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm9, %xmm3
movdqa	%xmm8, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm8, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm9, %xmm15
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm15
paddd	%xmm5, %xmm11
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm15
paddd	%xmm7, %xmm15
movd	0x24(%r8), %xmm5
movd	0x24(%r9), %xmm0
movd	0x24(%r10), %xmm1
movd	0x24(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm11, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x10(%rax)
paddd	%xmm14, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x60(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm11, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm13, %xmm0
pand	%xmm12, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm15, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm8, %xmm4
movdqa	%xmm15, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm15, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm8, %xmm14
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm14
paddd	%xmm5, %xmm10
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm14
paddd	%xmm7, %xmm14
movd	0x28(%r8), %xmm5
movd	0x28(%r9), %xmm0
movd	0x28(%r10), %xmm1
movd	0x28(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm10, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm10, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm10, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x20(%rax)
paddd	%xmm13, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm10, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm12, %xmm0
pand	%xmm11, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm14, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm15, %xmm3
movdqa	%xmm14, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm14, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm15, %xmm13
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm13
paddd	%xmm5, %xmm9
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm13
paddd	%xmm7, %xmm13
movd	0x2c(%r8), %xmm5
movd	0x2c(%r9), %xmm0
movd	0x2c(%r10), %xmm1
movd	0x2c(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm9, %xmm7
movdqa	%xmm9, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm9, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x30(%rax)
paddd	%xmm12, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x20(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm9, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm11, %xmm0
pand	%xmm10, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm13, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm14, %xmm4
movdqa	%xmm13, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm13, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm14, %xmm12
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm12
paddd	%xmm5, %xmm8
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm12
paddd	%xmm7, %xmm12
movd	0x30(%r8), %xmm5
movd	0x30(%r9), %xmm0
movd	0x30(%r10), %xmm1
movd	0x30(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm8, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm8, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm8, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x40(%rax)
paddd	%xmm11, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm8, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm10, %xmm0
pand	%xmm9, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm12, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm13, %xmm3
movdqa	%xmm12, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm12, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm13, %xmm11
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm11
paddd	%xmm5, %xmm15
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm11
paddd	%xmm7, %xmm11
movd	0x34(%r8), %xmm5
movd	0x34(%r9), %xmm0
movd	0x34(%r10), %xmm1
movd	0x34(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm15, %xmm7
movdqa	%xmm15, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm15, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x50(%rax)
paddd	%xmm10, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x20(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm15, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm9, %xmm0
pand	%xmm8, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm11, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm12, %xmm4
movdqa	%xmm11, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm11, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm12, %xmm10
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm10
paddd	%xmm5, %xmm14
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm10
paddd	%xmm7, %xmm10
movd	0x38(%r8), %xmm5
movd	0x38(%r9), %xmm0
movd	0x38(%r10), %xmm1
movd	0x38(%r11), %xmm2
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm14, %xmm7
pshufb	%xmm6, %xmm5
movdqa	%xmm14, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm14, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x60(%rax)
paddd	%xmm9, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm14, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm8, %xmm0
pand	%xmm15, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm10, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm11, %xmm3
movdqa	%xmm10, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm10, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm11, %xmm9
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm9
paddd	%xmm5, %xmm13
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm9
paddd	%xmm7, %xmm9
movd	0x3c(%r8), %xmm5
leaq	0x40(%r8), %r8
movd	0x3c(%r9), %xmm0
leaq	0x40(%r9), %r9
movd	0x3c(%r10), %xmm1
leaq	0x40(%r10), %r10
movd	0x3c(%r11), %xmm2
leaq	0x40(%r11), %r11
punpckldq	%xmm1, %xmm5
punpckldq	%xmm2, %xmm0
punpckldq	%xmm0, %xmm5
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm2
pshufb	%xmm6, %xmm5
psrld	$0x6, %xmm7
movdqa	%xmm13, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x70(%rax)
paddd	%xmm8, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x60(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm13, %xmm0
prefetcht0	0x3f(%r8)
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm15, %xmm0
pand	%xmm14, %xmm4
pxor	%xmm1, %xmm7
prefetcht0	0x3f(%r9)
movdqa	%xmm9, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm4, %xmm0
movdqa	%xmm10, %xmm4
movdqa	%xmm9, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm9, %xmm4
prefetcht0	0x3f(%r10)
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
prefetcht0	0x3f(%r11)
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm10, %xmm8
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm8
paddd	%xmm5, %xmm12
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm8
paddd	%xmm7, %xmm8
leaq	0x100(%rbp), %rbp
movdqu	-0x80(%rax), %xmm5
movl	$0x3, %ecx
jmp	L_1160
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1160:
movdqa	-0x70(%rax), %xmm6
paddd	0x10(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	0x60(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm12, %xmm7
movdqa	%xmm12, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm12, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x80(%rax)
paddd	%xmm15, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x80(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm12, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm14, %xmm0
pand	%xmm13, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm8, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm9, %xmm3
movdqa	%xmm8, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm8, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm9, %xmm15
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm15
paddd	%xmm5, %xmm11
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm15
paddd	%xmm7, %xmm15
movdqa	-0x60(%rax), %xmm5
paddd	0x20(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	0x70(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm11, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, -0x70(%rax)
paddd	%xmm14, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x60(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm11, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm13, %xmm0
pand	%xmm12, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm15, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm8, %xmm4
movdqa	%xmm15, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm15, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm8, %xmm14
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm14
paddd	%xmm6, %xmm10
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm14
paddd	%xmm7, %xmm14
movdqa	-0x50(%rax), %xmm6
paddd	0x30(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x80(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm10, %xmm7
movdqa	%xmm10, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm10, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x60(%rax)
paddd	%xmm13, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm10, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm12, %xmm0
pand	%xmm11, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm14, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm15, %xmm3
movdqa	%xmm14, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm14, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm15, %xmm13
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm13
paddd	%xmm5, %xmm9
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm13
paddd	%xmm7, %xmm13
movdqa	-0x40(%rax), %xmm5
paddd	0x40(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x70(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm9, %xmm7
movdqa	%xmm9, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm9, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, -0x50(%rax)
paddd	%xmm12, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x20(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm9, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm11, %xmm0
pand	%xmm10, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm13, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm14, %xmm4
movdqa	%xmm13, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm13, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm14, %xmm12
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm12
paddd	%xmm6, %xmm8
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm12
paddd	%xmm7, %xmm12
movdqa	-0x30(%rax), %xmm6
paddd	0x50(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x60(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm8, %xmm7
movdqa	%xmm8, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm8, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x40(%rax)
paddd	%xmm11, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm8, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm10, %xmm0
pand	%xmm9, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm12, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm13, %xmm3
movdqa	%xmm12, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm12, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm13, %xmm11
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm11
paddd	%xmm5, %xmm15
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm11
paddd	%xmm7, %xmm11
movdqa	-0x20(%rax), %xmm5
paddd	0x60(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x50(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm15, %xmm7
movdqa	%xmm15, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm15, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, -0x30(%rax)
paddd	%xmm10, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x20(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm15, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm9, %xmm0
pand	%xmm8, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm11, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm12, %xmm4
movdqa	%xmm11, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm11, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm12, %xmm10
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm10
paddd	%xmm6, %xmm14
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm10
paddd	%xmm7, %xmm10
movdqa	-0x10(%rax), %xmm6
paddd	0x70(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x40(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm14, %xmm7
movdqa	%xmm14, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm14, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, -0x20(%rax)
paddd	%xmm9, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm14, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm8, %xmm0
pand	%xmm15, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm10, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm11, %xmm3
movdqa	%xmm10, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm10, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm11, %xmm9
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm9
paddd	%xmm5, %xmm13
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm9
paddd	%xmm7, %xmm9
movdqa	(%rax), %xmm5
paddd	-0x80(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x30(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm13, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, -0x10(%rax)
paddd	%xmm8, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x60(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm13, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm15, %xmm0
pand	%xmm14, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm9, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm10, %xmm4
movdqa	%xmm9, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm9, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm10, %xmm8
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm8
paddd	%xmm6, %xmm12
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm8
paddd	%xmm7, %xmm8
leaq	0x100(%rbp), %rbp
movdqa	0x10(%rax), %xmm6
paddd	-0x70(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x20(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm12, %xmm7
movdqa	%xmm12, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm12, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, (%rax)
paddd	%xmm15, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x80(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm12, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm14, %xmm0
pand	%xmm13, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm8, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm9, %xmm3
movdqa	%xmm8, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm8, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm9, %xmm15
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm15
paddd	%xmm5, %xmm11
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm15
paddd	%xmm7, %xmm15
movdqa	0x20(%rax), %xmm5
paddd	-0x60(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	-0x10(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm11, %xmm7
movdqa	%xmm11, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm11, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, 0x10(%rax)
paddd	%xmm14, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x60(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm11, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm13, %xmm0
pand	%xmm12, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm15, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm8, %xmm4
movdqa	%xmm15, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm15, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm8, %xmm14
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm14
paddd	%xmm6, %xmm10
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm14
paddd	%xmm7, %xmm14
movdqa	0x30(%rax), %xmm6
paddd	-0x50(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm10, %xmm7
movdqa	%xmm10, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm10, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x20(%rax)
paddd	%xmm13, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm10, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm12, %xmm0
pand	%xmm11, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm14, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm15, %xmm3
movdqa	%xmm14, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm14, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm15, %xmm13
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm13
paddd	%xmm5, %xmm9
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm13
paddd	%xmm7, %xmm13
movdqa	0x40(%rax), %xmm5
paddd	-0x40(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	0x10(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm9, %xmm7
movdqa	%xmm9, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm9, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, 0x30(%rax)
paddd	%xmm12, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	-0x20(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm9, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm11, %xmm0
pand	%xmm10, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm13, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm14, %xmm4
movdqa	%xmm13, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm13, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm14, %xmm12
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm12
paddd	%xmm6, %xmm8
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm12
paddd	%xmm7, %xmm12
movdqa	0x50(%rax), %xmm6
paddd	-0x30(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	0x20(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm8, %xmm7
movdqa	%xmm8, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm8, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x40(%rax)
paddd	%xmm11, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm8, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm8, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm10, %xmm0
pand	%xmm9, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm12, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm12, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm13, %xmm3
movdqa	%xmm12, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm12, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm13, %xmm11
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm11
paddd	%xmm5, %xmm15
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm11
paddd	%xmm7, %xmm11
movdqa	0x60(%rax), %xmm5
paddd	-0x20(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	0x30(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm15, %xmm7
movdqa	%xmm15, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm15, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, 0x50(%rax)
paddd	%xmm10, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x20(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm15, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm15, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm9, %xmm0
pand	%xmm8, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm11, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm11, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm12, %xmm4
movdqa	%xmm11, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm11, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm12, %xmm10
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm10
paddd	%xmm6, %xmm14
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm10
paddd	%xmm7, %xmm10
movdqa	0x70(%rax), %xmm6
paddd	-0x10(%rax), %xmm5
movdqa	%xmm6, %xmm7
movdqa	%xmm6, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm6, %xmm2
psrld	$0x7, %xmm1
movdqa	0x40(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm3, %xmm1
psrld	$0x11, %xmm3
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
psrld	$0x2, %xmm3
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm3, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm5
movdqa	%xmm14, %xmm7
movdqa	%xmm14, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm14, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm5, 0x60(%rax)
paddd	%xmm9, %xmm5
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x40(%rbp), %xmm5
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm14, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm14, %xmm3
pslld	$0x5, %xmm2
pandn	%xmm8, %xmm0
pand	%xmm15, %xmm3
pxor	%xmm1, %xmm7
movdqa	%xmm10, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm10, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm5
pxor	%xmm3, %xmm0
movdqa	%xmm11, %xmm3
movdqa	%xmm10, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm10, %xmm3
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm5
pslld	$0x9, %xmm2
pand	%xmm3, %xmm4
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm11, %xmm9
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm4, %xmm9
paddd	%xmm5, %xmm13
pxor	%xmm2, %xmm7
paddd	%xmm5, %xmm9
paddd	%xmm7, %xmm9
movdqa	-0x80(%rax), %xmm5
paddd	(%rax), %xmm6
movdqa	%xmm5, %xmm7
movdqa	%xmm5, %xmm1
psrld	$0x3, %xmm7
movdqa	%xmm5, %xmm2
psrld	$0x7, %xmm1
movdqa	0x50(%rax), %xmm0
pslld	$0xe, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xb, %xmm1
movdqa	%xmm0, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
psrld	$0xa, %xmm0
movdqa	%xmm4, %xmm1
psrld	$0x11, %xmm4
pxor	%xmm2, %xmm7
pslld	$0xd, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
psrld	$0x2, %xmm4
pxor	%xmm1, %xmm0
pslld	$0x2, %xmm1
pxor	%xmm4, %xmm0
pxor	%xmm1, %xmm0
paddd	%xmm0, %xmm6
movdqa	%xmm13, %xmm7
movdqa	%xmm13, %xmm2
psrld	$0x6, %xmm7
movdqa	%xmm13, %xmm1
pslld	$0x7, %xmm2
movdqa	%xmm6, 0x70(%rax)
paddd	%xmm8, %xmm6
psrld	$0xb, %xmm1
pxor	%xmm2, %xmm7
pslld	$0xe, %xmm2
paddd	0x60(%rbp), %xmm6
pxor	%xmm1, %xmm7
psrld	$0xe, %xmm1
movdqa	%xmm13, %xmm0
pxor	%xmm2, %xmm7
movdqa	%xmm13, %xmm4
pslld	$0x5, %xmm2
pandn	%xmm15, %xmm0
pand	%xmm14, %xmm4
pxor	%xmm1, %xmm7
movdqa	%xmm9, %xmm1
pxor	%xmm2, %xmm7
movdqa	%xmm9, %xmm2
psrld	$0x2, %xmm1
paddd	%xmm7, %xmm6
pxor	%xmm4, %xmm0
movdqa	%xmm10, %xmm4
movdqa	%xmm9, %xmm7
pslld	$0xa, %xmm2
pxor	%xmm9, %xmm4
psrld	$0xd, %xmm7
pxor	%xmm2, %xmm1
paddd	%xmm0, %xmm6
pslld	$0x9, %xmm2
pand	%xmm4, %xmm3
pxor	%xmm7, %xmm1
psrld	$0x9, %xmm7
pxor	%xmm2, %xmm1
movdqa	%xmm10, %xmm8
pslld	$0xb, %xmm2
pxor	%xmm1, %xmm7
pxor	%xmm3, %xmm8
paddd	%xmm6, %xmm12
pxor	%xmm2, %xmm7
paddd	%xmm6, %xmm8
paddd	%xmm7, %xmm8
leaq	0x100(%rbp), %rbp
decl	%ecx
jne	L_1160
movl	$0x1, %ecx
leaq	K256+128(%rip), %rbp
movdqa	(%rbx), %xmm7
cmpl	(%rbx), %ecx
pxor	%xmm0, %xmm0
cmovgeq	%rbp, %r8
cmpl	0x4(%rbx), %ecx
movdqa	%xmm7, %xmm6
cmovgeq	%rbp, %r9
cmpl	0x8(%rbx), %ecx
pcmpgtd	%xmm0, %xmm6
cmovgeq	%rbp, %r10
cmpl	0xc(%rbx), %ecx
paddd	%xmm6, %xmm7
cmovgeq	%rbp, %r11
movdqu	-0x80(%rdi), %xmm0
pand	%xmm6, %xmm8
movdqu	-0x60(%rdi), %xmm1
pand	%xmm6, %xmm9
movdqu	-0x40(%rdi), %xmm2
pand	%xmm6, %xmm10
movdqu	-0x20(%rdi), %xmm5
pand	%xmm6, %xmm11
paddd	%xmm0, %xmm8
movdqu	(%rdi), %xmm0
pand	%xmm6, %xmm12
paddd	%xmm1, %xmm9
movdqu	0x20(%rdi), %xmm1
pand	%xmm6, %xmm13
paddd	%xmm2, %xmm10
movdqu	0x40(%rdi), %xmm2
pand	%xmm6, %xmm14
paddd	%xmm5, %xmm11
movdqu	0x60(%rdi), %xmm5
pand	%xmm6, %xmm15
paddd	%xmm0, %xmm12
paddd	%xmm1, %xmm13
movdqu	%xmm8, -0x80(%rdi)
paddd	%xmm2, %xmm14
movdqu	%xmm9, -0x60(%rdi)
paddd	%xmm5, %xmm15
movdqu	%xmm10, -0x40(%rdi)
movdqu	%xmm11, -0x20(%rdi)
movdqu	%xmm12, (%rdi)
movdqu	%xmm13, 0x20(%rdi)
movdqu	%xmm14, 0x40(%rdi)
movdqu	%xmm15, 0x60(%rdi)
movdqa	%xmm7, (%rbx)
movdqa	K256_shaext-32(%rip), %xmm6
decl	%edx
jne	L_100
movl	0x118(%rsp), %edx
leaq	0x10(%rdi), %rdi
leaq	0x40(%rsi), %rsi
decl	%edx
jne	L_4f
L_27ce:
movq	0x110(%rsp), %rax
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
_shaext_shortcut:
sha256_multi_block_shaext:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
subq	$0x120, %rsp
shll	%edx
andq	$-0x100, %rsp
leaq	0x80(%rdi), %rdi
movq	%rax, 0x110(%rsp)
leaq	0x100(%rsp), %rbx
leaq	K256_shaext+128(%rip), %rbp
L_2833:
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
je	L_308d
movq	-0x80(%rdi), %xmm12
movq	-0x60(%rdi), %xmm4
movq	-0x40(%rdi), %xmm13
movq	-0x20(%rdi), %xmm5
movq	(%rdi), %xmm8
movq	0x20(%rdi), %xmm9
movq	0x40(%rdi), %xmm10
movq	0x60(%rdi), %xmm11
punpckldq	%xmm4, %xmm12
punpckldq	%xmm5, %xmm13
punpckldq	%xmm9, %xmm8
punpckldq	%xmm11, %xmm10
movdqa	K256_shaext-16(%rip), %xmm3
movdqa	%xmm12, %xmm14
movdqa	%xmm13, %xmm15
punpcklqdq	%xmm8, %xmm12
punpcklqdq	%xmm10, %xmm13
punpckhqdq	%xmm8, %xmm14
punpckhqdq	%xmm10, %xmm15
pshufd	$0x1b, %xmm12, %xmm12
pshufd	$0x1b, %xmm13, %xmm13
pshufd	$0x1b, %xmm14, %xmm14
pshufd	$0x1b, %xmm15, %xmm15
jmp	L_2900
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_2900:
movdqu	(%r8), %xmm4
movdqu	(%r9), %xmm8
movdqu	0x10(%r8), %xmm5
movdqu	0x10(%r9), %xmm9
movdqu	0x20(%r8), %xmm6
pshufb	%xmm3, %xmm4
movdqu	0x20(%r9), %xmm10
pshufb	%xmm3, %xmm8
movdqu	0x30(%r8), %xmm7
leaq	0x40(%r8), %r8
movdqu	0x30(%r9), %xmm11
leaq	0x40(%r9), %r9
movdqa	-0x80(%rbp), %xmm0
pshufb	%xmm3, %xmm5
paddd	%xmm4, %xmm0
pxor	%xmm12, %xmm4
movdqa	%xmm0, %xmm1
movdqa	-0x80(%rbp), %xmm2
pshufb	%xmm3, %xmm9
paddd	%xmm8, %xmm2
movdqa	%xmm13, 0x50(%rsp)
sha256rnds2	%xmm0, %xmm12, %xmm13
pxor	%xmm14, %xmm8
movdqa	%xmm2, %xmm0
movdqa	%xmm15, 0x70(%rsp)
sha256rnds2	%xmm0, %xmm14, %xmm15
pshufd	$0xe, %xmm1, %xmm0
pxor	%xmm12, %xmm4
movdqa	%xmm12, 0x40(%rsp)
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
pxor	%xmm14, %xmm8
movdqa	%xmm14, 0x60(%rsp)
movdqa	-0x70(%rbp), %xmm1
paddd	%xmm5, %xmm1
pshufb	%xmm3, %xmm6
sha256rnds2	%xmm0, %xmm15, %xmm14
movdqa	%xmm1, %xmm0
movdqa	-0x70(%rbp), %xmm2
paddd	%xmm9, %xmm2
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
prefetcht0	0x7f(%r8)
pshufb	%xmm3, %xmm7
pshufb	%xmm3, %xmm10
prefetcht0	0x7f(%r9)
sha256rnds2	%xmm0, %xmm14, %xmm15
pshufd	$0xe, %xmm1, %xmm0
pshufb	%xmm3, %xmm11
sha256msg1	%xmm5, %xmm4
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	-0x60(%rbp), %xmm1
paddd	%xmm6, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
movdqa	%xmm1, %xmm0
movdqa	-0x60(%rbp), %xmm2
paddd	%xmm10, %xmm2
sha256rnds2	%xmm0, %xmm12, %xmm13
sha256msg1	%xmm9, %xmm8
movdqa	%xmm2, %xmm0
movdqa	%xmm7, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
pshufd	$0xe, %xmm1, %xmm0
palignr	$0x4, %xmm6, %xmm3
paddd	%xmm3, %xmm4
movdqa	%xmm11, %xmm3
palignr	$0x4, %xmm10, %xmm3
sha256msg1	%xmm6, %xmm5
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	-0x50(%rbp), %xmm1
paddd	%xmm7, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm10, %xmm9
movdqa	%xmm1, %xmm0
movdqa	-0x50(%rbp), %xmm2
paddd	%xmm3, %xmm8
paddd	%xmm11, %xmm2
sha256msg2	%xmm7, %xmm4
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm4, %xmm3
palignr	$0x4, %xmm7, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm11, %xmm8
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm5
movdqa	%xmm8, %xmm3
palignr	$0x4, %xmm11, %xmm3
sha256msg1	%xmm7, %xmm6
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	-0x40(%rbp), %xmm1
paddd	%xmm4, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm11, %xmm10
movdqa	%xmm1, %xmm0
movdqa	-0x40(%rbp), %xmm2
paddd	%xmm3, %xmm9
paddd	%xmm8, %xmm2
sha256msg2	%xmm4, %xmm5
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm5, %xmm3
palignr	$0x4, %xmm4, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm8, %xmm9
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm6
movdqa	%xmm9, %xmm3
palignr	$0x4, %xmm8, %xmm3
sha256msg1	%xmm4, %xmm7
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	-0x30(%rbp), %xmm1
paddd	%xmm5, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm8, %xmm11
movdqa	%xmm1, %xmm0
movdqa	-0x30(%rbp), %xmm2
paddd	%xmm3, %xmm10
paddd	%xmm9, %xmm2
sha256msg2	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm6, %xmm3
palignr	$0x4, %xmm5, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm9, %xmm10
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm7
movdqa	%xmm10, %xmm3
palignr	$0x4, %xmm9, %xmm3
sha256msg1	%xmm5, %xmm4
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	-0x20(%rbp), %xmm1
paddd	%xmm6, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm9, %xmm8
movdqa	%xmm1, %xmm0
movdqa	-0x20(%rbp), %xmm2
paddd	%xmm3, %xmm11
paddd	%xmm10, %xmm2
sha256msg2	%xmm6, %xmm7
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm7, %xmm3
palignr	$0x4, %xmm6, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm10, %xmm11
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm4
movdqa	%xmm11, %xmm3
palignr	$0x4, %xmm10, %xmm3
sha256msg1	%xmm6, %xmm5
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	-0x10(%rbp), %xmm1
paddd	%xmm7, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm10, %xmm9
movdqa	%xmm1, %xmm0
movdqa	-0x10(%rbp), %xmm2
paddd	%xmm3, %xmm8
paddd	%xmm11, %xmm2
sha256msg2	%xmm7, %xmm4
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm4, %xmm3
palignr	$0x4, %xmm7, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm11, %xmm8
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm5
movdqa	%xmm8, %xmm3
palignr	$0x4, %xmm11, %xmm3
sha256msg1	%xmm7, %xmm6
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	(%rbp), %xmm1
paddd	%xmm4, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm11, %xmm10
movdqa	%xmm1, %xmm0
movdqa	(%rbp), %xmm2
paddd	%xmm3, %xmm9
paddd	%xmm8, %xmm2
sha256msg2	%xmm4, %xmm5
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm5, %xmm3
palignr	$0x4, %xmm4, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm8, %xmm9
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm6
movdqa	%xmm9, %xmm3
palignr	$0x4, %xmm8, %xmm3
sha256msg1	%xmm4, %xmm7
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x10(%rbp), %xmm1
paddd	%xmm5, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm8, %xmm11
movdqa	%xmm1, %xmm0
movdqa	0x10(%rbp), %xmm2
paddd	%xmm3, %xmm10
paddd	%xmm9, %xmm2
sha256msg2	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm6, %xmm3
palignr	$0x4, %xmm5, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm9, %xmm10
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm7
movdqa	%xmm10, %xmm3
palignr	$0x4, %xmm9, %xmm3
sha256msg1	%xmm5, %xmm4
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x20(%rbp), %xmm1
paddd	%xmm6, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm9, %xmm8
movdqa	%xmm1, %xmm0
movdqa	0x20(%rbp), %xmm2
paddd	%xmm3, %xmm11
paddd	%xmm10, %xmm2
sha256msg2	%xmm6, %xmm7
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm7, %xmm3
palignr	$0x4, %xmm6, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm10, %xmm11
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm4
movdqa	%xmm11, %xmm3
palignr	$0x4, %xmm10, %xmm3
sha256msg1	%xmm6, %xmm5
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x30(%rbp), %xmm1
paddd	%xmm7, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm10, %xmm9
movdqa	%xmm1, %xmm0
movdqa	0x30(%rbp), %xmm2
paddd	%xmm3, %xmm8
paddd	%xmm11, %xmm2
sha256msg2	%xmm7, %xmm4
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm4, %xmm3
palignr	$0x4, %xmm7, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm11, %xmm8
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm5
movdqa	%xmm8, %xmm3
palignr	$0x4, %xmm11, %xmm3
sha256msg1	%xmm7, %xmm6
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x40(%rbp), %xmm1
paddd	%xmm4, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm11, %xmm10
movdqa	%xmm1, %xmm0
movdqa	0x40(%rbp), %xmm2
paddd	%xmm3, %xmm9
paddd	%xmm8, %xmm2
sha256msg2	%xmm4, %xmm5
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm5, %xmm3
palignr	$0x4, %xmm4, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm8, %xmm9
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm6
movdqa	%xmm9, %xmm3
palignr	$0x4, %xmm8, %xmm3
sha256msg1	%xmm4, %xmm7
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x50(%rbp), %xmm1
paddd	%xmm5, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
sha256msg1	%xmm8, %xmm11
movdqa	%xmm1, %xmm0
movdqa	0x50(%rbp), %xmm2
paddd	%xmm3, %xmm10
paddd	%xmm9, %xmm2
sha256msg2	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movdqa	%xmm6, %xmm3
palignr	$0x4, %xmm5, %xmm3
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm9, %xmm10
pshufd	$0xe, %xmm1, %xmm0
paddd	%xmm3, %xmm7
movdqa	%xmm10, %xmm3
palignr	$0x4, %xmm9, %xmm3
nop
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x60(%rbp), %xmm1
paddd	%xmm6, %xmm1
sha256rnds2	%xmm0, %xmm15, %xmm14
movdqa	%xmm1, %xmm0
movdqa	0x60(%rbp), %xmm2
paddd	%xmm3, %xmm11
paddd	%xmm10, %xmm2
sha256msg2	%xmm6, %xmm7
nop
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
movl	$0x1, %ecx
pxor	%xmm6, %xmm6
sha256rnds2	%xmm0, %xmm14, %xmm15
sha256msg2	%xmm10, %xmm11
pshufd	$0xe, %xmm1, %xmm0
movdqa	0x70(%rbp), %xmm1
paddd	%xmm7, %xmm1
movq	(%rbx), %xmm7
nop
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
movdqa	0x70(%rbp), %xmm2
paddd	%xmm11, %xmm2
sha256rnds2	%xmm0, %xmm15, %xmm14
movdqa	%xmm1, %xmm0
cmpl	(%rbx), %ecx
cmovgeq	%rsp, %r8
cmpl	0x4(%rbx), %ecx
cmovgeq	%rsp, %r9
pshufd	$0x0, %xmm7, %xmm9
sha256rnds2	%xmm0, %xmm12, %xmm13
movdqa	%xmm2, %xmm0
pshufd	$0x55, %xmm7, %xmm10
movdqa	%xmm7, %xmm11
sha256rnds2	%xmm0, %xmm14, %xmm15
pshufd	$0xe, %xmm1, %xmm0
pcmpgtd	%xmm6, %xmm9
pcmpgtd	%xmm6, %xmm10
sha256rnds2	%xmm0, %xmm13, %xmm12
pshufd	$0xe, %xmm2, %xmm0
pcmpgtd	%xmm6, %xmm11
movdqa	K256_shaext-16(%rip), %xmm3
sha256rnds2	%xmm0, %xmm15, %xmm14
pand	%xmm9, %xmm13
pand	%xmm10, %xmm15
pand	%xmm9, %xmm12
pand	%xmm10, %xmm14
paddd	%xmm7, %xmm11
paddd	0x50(%rsp), %xmm13
paddd	0x70(%rsp), %xmm15
paddd	0x40(%rsp), %xmm12
paddd	0x60(%rsp), %xmm14
movq	%xmm11, (%rbx)
decl	%edx
jne	L_2900
movl	0x118(%rsp), %edx
pshufd	$0x1b, %xmm12, %xmm12
pshufd	$0x1b, %xmm13, %xmm13
pshufd	$0x1b, %xmm14, %xmm14
pshufd	$0x1b, %xmm15, %xmm15
movdqa	%xmm12, %xmm5
movdqa	%xmm13, %xmm6
punpckldq	%xmm14, %xmm12
punpckhdq	%xmm14, %xmm5
punpckldq	%xmm15, %xmm13
punpckhdq	%xmm15, %xmm6
movq	%xmm12, -0x80(%rdi)
psrldq	$0x8, %xmm12
movq	%xmm5, (%rdi)
psrldq	$0x8, %xmm5
movq	%xmm12, -0x60(%rdi)
movq	%xmm5, 0x20(%rdi)
movq	%xmm13, -0x40(%rdi)
psrldq	$0x8, %xmm13
movq	%xmm6, 0x40(%rdi)
psrldq	$0x8, %xmm6
movq	%xmm13, -0x20(%rdi)
movq	%xmm6, 0x60(%rdi)
leaq	0x8(%rdi), %rdi
leaq	0x20(%rsi), %rsi
decl	%edx
jne	L_2833
L_308d:
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	(%rax,%rax)
_avx_shortcut:
sha256_multi_block_avx:
shrq	$0x20, %rcx
cmpl	$0x2, %edx
jb	L_30c0
testl	$0x20, %ecx
jne	_avx2_shortcut
jmp	L_30c0
nopw	(%rax,%rax)
L_30c0:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
subq	$0x120, %rsp
andq	$-0x100, %rsp
movq	%rax, 0x110(%rsp)
leaq	K256+128(%rip), %rbp
leaq	0x100(%rsp), %rbx
leaq	0x80(%rdi), %rdi
L_30f1:
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
je	L_5146
vmovdqu	-0x80(%rdi), %xmm8
leaq	0x80(%rsp), %rax
vmovdqu	-0x60(%rdi), %xmm9
vmovdqu	-0x40(%rdi), %xmm10
vmovdqu	-0x20(%rdi), %xmm11
vmovdqu	(%rdi), %xmm12
vmovdqu	0x20(%rdi), %xmm13
vmovdqu	0x40(%rdi), %xmm14
vmovdqu	0x60(%rdi), %xmm15
vmovdqu	K256_shaext-32(%rip), %xmm6
jmp	L_31a0
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_31a0:
vpxor	%xmm9, %xmm10, %xmm4
vmovd	(%r8), %xmm5
vmovd	(%r9), %xmm0
vpinsrd	$0x1, (%r10), %xmm5, %xmm5
vpinsrd	$0x1, (%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm12, %xmm7
vpslld	$0x1a, %xmm12, %xmm2
vmovdqu	%xmm5, -0x80(%rax)
vpaddd	%xmm5, %xmm15, %xmm5
vpsrld	$0xb, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm12, %xmm2
vpaddd	-0x80(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm12, %xmm2
vpandn	%xmm14, %xmm12, %xmm0
vpand	%xmm13, %xmm12, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm8, %xmm15
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm8, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm8, %xmm9, %xmm3
vpxor	%xmm1, %xmm15, %xmm15
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm8, %xmm1
vpslld	$0x13, %xmm8, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm15, %xmm7
vpsrld	$0x16, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm8, %xmm2
vpxor	%xmm4, %xmm9, %xmm15
vpaddd	%xmm5, %xmm11, %xmm11
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm15, %xmm15
vpaddd	%xmm7, %xmm15, %xmm15
vmovd	0x4(%r8), %xmm5
vmovd	0x4(%r9), %xmm0
vpinsrd	$0x1, 0x4(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x4(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm11, %xmm7
vpslld	$0x1a, %xmm11, %xmm2
vmovdqu	%xmm5, -0x70(%rax)
vpaddd	%xmm5, %xmm14, %xmm5
vpsrld	$0xb, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm11, %xmm2
vpaddd	-0x60(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm11, %xmm2
vpandn	%xmm13, %xmm11, %xmm0
vpand	%xmm12, %xmm11, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm15, %xmm14
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm15, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm15, %xmm8, %xmm4
vpxor	%xmm1, %xmm14, %xmm14
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm15, %xmm1
vpslld	$0x13, %xmm15, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm14, %xmm7
vpsrld	$0x16, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm15, %xmm2
vpxor	%xmm3, %xmm8, %xmm14
vpaddd	%xmm5, %xmm10, %xmm10
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm14, %xmm14
vpaddd	%xmm7, %xmm14, %xmm14
vmovd	0x8(%r8), %xmm5
vmovd	0x8(%r9), %xmm0
vpinsrd	$0x1, 0x8(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x8(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm10, %xmm7
vpslld	$0x1a, %xmm10, %xmm2
vmovdqu	%xmm5, -0x60(%rax)
vpaddd	%xmm5, %xmm13, %xmm5
vpsrld	$0xb, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm10, %xmm2
vpaddd	-0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm10, %xmm2
vpandn	%xmm12, %xmm10, %xmm0
vpand	%xmm11, %xmm10, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm14, %xmm13
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm14, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm14, %xmm15, %xmm3
vpxor	%xmm1, %xmm13, %xmm13
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm14, %xmm1
vpslld	$0x13, %xmm14, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm13, %xmm7
vpsrld	$0x16, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm14, %xmm2
vpxor	%xmm4, %xmm15, %xmm13
vpaddd	%xmm5, %xmm9, %xmm9
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm13, %xmm13
vpaddd	%xmm7, %xmm13, %xmm13
vmovd	0xc(%r8), %xmm5
vmovd	0xc(%r9), %xmm0
vpinsrd	$0x1, 0xc(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0xc(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm9, %xmm7
vpslld	$0x1a, %xmm9, %xmm2
vmovdqu	%xmm5, -0x50(%rax)
vpaddd	%xmm5, %xmm12, %xmm5
vpsrld	$0xb, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm9, %xmm2
vpaddd	-0x20(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm9, %xmm2
vpandn	%xmm11, %xmm9, %xmm0
vpand	%xmm10, %xmm9, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm13, %xmm12
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm13, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm13, %xmm14, %xmm4
vpxor	%xmm1, %xmm12, %xmm12
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm13, %xmm1
vpslld	$0x13, %xmm13, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm12, %xmm7
vpsrld	$0x16, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm13, %xmm2
vpxor	%xmm3, %xmm14, %xmm12
vpaddd	%xmm5, %xmm8, %xmm8
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm12, %xmm12
vpaddd	%xmm7, %xmm12, %xmm12
vmovd	0x10(%r8), %xmm5
vmovd	0x10(%r9), %xmm0
vpinsrd	$0x1, 0x10(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x10(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm8, %xmm7
vpslld	$0x1a, %xmm8, %xmm2
vmovdqu	%xmm5, -0x40(%rax)
vpaddd	%xmm5, %xmm11, %xmm5
vpsrld	$0xb, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm8, %xmm2
vpaddd	(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm8, %xmm2
vpandn	%xmm10, %xmm8, %xmm0
vpand	%xmm9, %xmm8, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm12, %xmm11
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm12, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm12, %xmm13, %xmm3
vpxor	%xmm1, %xmm11, %xmm11
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm12, %xmm1
vpslld	$0x13, %xmm12, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm11, %xmm7
vpsrld	$0x16, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm12, %xmm2
vpxor	%xmm4, %xmm13, %xmm11
vpaddd	%xmm5, %xmm15, %xmm15
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm11, %xmm11
vpaddd	%xmm7, %xmm11, %xmm11
vmovd	0x14(%r8), %xmm5
vmovd	0x14(%r9), %xmm0
vpinsrd	$0x1, 0x14(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x14(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm15, %xmm7
vpslld	$0x1a, %xmm15, %xmm2
vmovdqu	%xmm5, -0x30(%rax)
vpaddd	%xmm5, %xmm10, %xmm5
vpsrld	$0xb, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm15, %xmm2
vpaddd	0x20(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm15, %xmm2
vpandn	%xmm9, %xmm15, %xmm0
vpand	%xmm8, %xmm15, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm11, %xmm10
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm11, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm11, %xmm12, %xmm4
vpxor	%xmm1, %xmm10, %xmm10
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm11, %xmm1
vpslld	$0x13, %xmm11, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm10, %xmm7
vpsrld	$0x16, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm11, %xmm2
vpxor	%xmm3, %xmm12, %xmm10
vpaddd	%xmm5, %xmm14, %xmm14
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm10, %xmm10
vpaddd	%xmm7, %xmm10, %xmm10
vmovd	0x18(%r8), %xmm5
vmovd	0x18(%r9), %xmm0
vpinsrd	$0x1, 0x18(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x18(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm14, %xmm7
vpslld	$0x1a, %xmm14, %xmm2
vmovdqu	%xmm5, -0x20(%rax)
vpaddd	%xmm5, %xmm9, %xmm5
vpsrld	$0xb, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm14, %xmm2
vpaddd	0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm14, %xmm2
vpandn	%xmm8, %xmm14, %xmm0
vpand	%xmm15, %xmm14, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm10, %xmm9
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm10, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm10, %xmm11, %xmm3
vpxor	%xmm1, %xmm9, %xmm9
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm10, %xmm1
vpslld	$0x13, %xmm10, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm7
vpsrld	$0x16, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm10, %xmm2
vpxor	%xmm4, %xmm11, %xmm9
vpaddd	%xmm5, %xmm13, %xmm13
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm9, %xmm9
vpaddd	%xmm7, %xmm9, %xmm9
vmovd	0x1c(%r8), %xmm5
vmovd	0x1c(%r9), %xmm0
vpinsrd	$0x1, 0x1c(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x1c(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm13, %xmm7
vpslld	$0x1a, %xmm13, %xmm2
vmovdqu	%xmm5, -0x10(%rax)
vpaddd	%xmm5, %xmm8, %xmm5
vpsrld	$0xb, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm13, %xmm2
vpaddd	0x60(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm13, %xmm2
vpandn	%xmm15, %xmm13, %xmm0
vpand	%xmm14, %xmm13, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm9, %xmm8
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm9, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm9, %xmm10, %xmm4
vpxor	%xmm1, %xmm8, %xmm8
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm9, %xmm1
vpslld	$0x13, %xmm9, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm8, %xmm7
vpsrld	$0x16, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm9, %xmm2
vpxor	%xmm3, %xmm10, %xmm8
vpaddd	%xmm5, %xmm12, %xmm12
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm8, %xmm8
vpaddd	%xmm7, %xmm8, %xmm8
addq	$0x100, %rbp
vmovd	0x20(%r8), %xmm5
vmovd	0x20(%r9), %xmm0
vpinsrd	$0x1, 0x20(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x20(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm12, %xmm7
vpslld	$0x1a, %xmm12, %xmm2
vmovdqu	%xmm5, (%rax)
vpaddd	%xmm5, %xmm15, %xmm5
vpsrld	$0xb, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm12, %xmm2
vpaddd	-0x80(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm12, %xmm2
vpandn	%xmm14, %xmm12, %xmm0
vpand	%xmm13, %xmm12, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm8, %xmm15
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm8, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm8, %xmm9, %xmm3
vpxor	%xmm1, %xmm15, %xmm15
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm8, %xmm1
vpslld	$0x13, %xmm8, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm15, %xmm7
vpsrld	$0x16, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm8, %xmm2
vpxor	%xmm4, %xmm9, %xmm15
vpaddd	%xmm5, %xmm11, %xmm11
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm15, %xmm15
vpaddd	%xmm7, %xmm15, %xmm15
vmovd	0x24(%r8), %xmm5
vmovd	0x24(%r9), %xmm0
vpinsrd	$0x1, 0x24(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x24(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm11, %xmm7
vpslld	$0x1a, %xmm11, %xmm2
vmovdqu	%xmm5, 0x10(%rax)
vpaddd	%xmm5, %xmm14, %xmm5
vpsrld	$0xb, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm11, %xmm2
vpaddd	-0x60(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm11, %xmm2
vpandn	%xmm13, %xmm11, %xmm0
vpand	%xmm12, %xmm11, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm15, %xmm14
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm15, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm15, %xmm8, %xmm4
vpxor	%xmm1, %xmm14, %xmm14
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm15, %xmm1
vpslld	$0x13, %xmm15, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm14, %xmm7
vpsrld	$0x16, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm15, %xmm2
vpxor	%xmm3, %xmm8, %xmm14
vpaddd	%xmm5, %xmm10, %xmm10
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm14, %xmm14
vpaddd	%xmm7, %xmm14, %xmm14
vmovd	0x28(%r8), %xmm5
vmovd	0x28(%r9), %xmm0
vpinsrd	$0x1, 0x28(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x28(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm10, %xmm7
vpslld	$0x1a, %xmm10, %xmm2
vmovdqu	%xmm5, 0x20(%rax)
vpaddd	%xmm5, %xmm13, %xmm5
vpsrld	$0xb, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm10, %xmm2
vpaddd	-0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm10, %xmm2
vpandn	%xmm12, %xmm10, %xmm0
vpand	%xmm11, %xmm10, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm14, %xmm13
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm14, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm14, %xmm15, %xmm3
vpxor	%xmm1, %xmm13, %xmm13
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm14, %xmm1
vpslld	$0x13, %xmm14, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm13, %xmm7
vpsrld	$0x16, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm14, %xmm2
vpxor	%xmm4, %xmm15, %xmm13
vpaddd	%xmm5, %xmm9, %xmm9
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm13, %xmm13
vpaddd	%xmm7, %xmm13, %xmm13
vmovd	0x2c(%r8), %xmm5
vmovd	0x2c(%r9), %xmm0
vpinsrd	$0x1, 0x2c(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x2c(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm9, %xmm7
vpslld	$0x1a, %xmm9, %xmm2
vmovdqu	%xmm5, 0x30(%rax)
vpaddd	%xmm5, %xmm12, %xmm5
vpsrld	$0xb, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm9, %xmm2
vpaddd	-0x20(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm9, %xmm2
vpandn	%xmm11, %xmm9, %xmm0
vpand	%xmm10, %xmm9, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm13, %xmm12
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm13, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm13, %xmm14, %xmm4
vpxor	%xmm1, %xmm12, %xmm12
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm13, %xmm1
vpslld	$0x13, %xmm13, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm12, %xmm7
vpsrld	$0x16, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm13, %xmm2
vpxor	%xmm3, %xmm14, %xmm12
vpaddd	%xmm5, %xmm8, %xmm8
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm12, %xmm12
vpaddd	%xmm7, %xmm12, %xmm12
vmovd	0x30(%r8), %xmm5
vmovd	0x30(%r9), %xmm0
vpinsrd	$0x1, 0x30(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x30(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm8, %xmm7
vpslld	$0x1a, %xmm8, %xmm2
vmovdqu	%xmm5, 0x40(%rax)
vpaddd	%xmm5, %xmm11, %xmm5
vpsrld	$0xb, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm8, %xmm2
vpaddd	(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm8, %xmm2
vpandn	%xmm10, %xmm8, %xmm0
vpand	%xmm9, %xmm8, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm12, %xmm11
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm12, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm12, %xmm13, %xmm3
vpxor	%xmm1, %xmm11, %xmm11
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm12, %xmm1
vpslld	$0x13, %xmm12, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm11, %xmm7
vpsrld	$0x16, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm12, %xmm2
vpxor	%xmm4, %xmm13, %xmm11
vpaddd	%xmm5, %xmm15, %xmm15
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm11, %xmm11
vpaddd	%xmm7, %xmm11, %xmm11
vmovd	0x34(%r8), %xmm5
vmovd	0x34(%r9), %xmm0
vpinsrd	$0x1, 0x34(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x34(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm15, %xmm7
vpslld	$0x1a, %xmm15, %xmm2
vmovdqu	%xmm5, 0x50(%rax)
vpaddd	%xmm5, %xmm10, %xmm5
vpsrld	$0xb, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm15, %xmm2
vpaddd	0x20(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm15, %xmm2
vpandn	%xmm9, %xmm15, %xmm0
vpand	%xmm8, %xmm15, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm11, %xmm10
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm11, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm11, %xmm12, %xmm4
vpxor	%xmm1, %xmm10, %xmm10
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm11, %xmm1
vpslld	$0x13, %xmm11, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm10, %xmm7
vpsrld	$0x16, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm11, %xmm2
vpxor	%xmm3, %xmm12, %xmm10
vpaddd	%xmm5, %xmm14, %xmm14
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm10, %xmm10
vpaddd	%xmm7, %xmm10, %xmm10
vmovd	0x38(%r8), %xmm5
vmovd	0x38(%r9), %xmm0
vpinsrd	$0x1, 0x38(%r10), %xmm5, %xmm5
vpinsrd	$0x1, 0x38(%r11), %xmm0, %xmm0
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm14, %xmm7
vpslld	$0x1a, %xmm14, %xmm2
vmovdqu	%xmm5, 0x60(%rax)
vpaddd	%xmm5, %xmm9, %xmm5
vpsrld	$0xb, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm14, %xmm2
vpaddd	0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm14, %xmm2
vpandn	%xmm8, %xmm14, %xmm0
vpand	%xmm15, %xmm14, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm10, %xmm9
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm10, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm10, %xmm11, %xmm3
vpxor	%xmm1, %xmm9, %xmm9
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm10, %xmm1
vpslld	$0x13, %xmm10, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm7
vpsrld	$0x16, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm10, %xmm2
vpxor	%xmm4, %xmm11, %xmm9
vpaddd	%xmm5, %xmm13, %xmm13
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm9, %xmm9
vpaddd	%xmm7, %xmm9, %xmm9
vmovd	0x3c(%r8), %xmm5
leaq	0x40(%r8), %r8
vmovd	0x3c(%r9), %xmm0
leaq	0x40(%r9), %r9
vpinsrd	$0x1, 0x3c(%r10), %xmm5, %xmm5
leaq	0x40(%r10), %r10
vpinsrd	$0x1, 0x3c(%r11), %xmm0, %xmm0
leaq	0x40(%r11), %r11
vpunpckldq	%xmm0, %xmm5, %xmm5
vpshufb	%xmm6, %xmm5, %xmm5
vpsrld	$0x6, %xmm13, %xmm7
vpslld	$0x1a, %xmm13, %xmm2
vmovdqu	%xmm5, 0x70(%rax)
vpaddd	%xmm5, %xmm8, %xmm5
vpsrld	$0xb, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm13, %xmm2
vpaddd	0x60(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
prefetcht0	0x3f(%r8)
vpslld	$0x7, %xmm13, %xmm2
vpandn	%xmm15, %xmm13, %xmm0
vpand	%xmm14, %xmm13, %xmm4
prefetcht0	0x3f(%r9)
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm9, %xmm8
vpxor	%xmm2, %xmm7, %xmm7
prefetcht0	0x3f(%r10)
vpslld	$0x1e, %xmm9, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm9, %xmm10, %xmm4
prefetcht0	0x3f(%r11)
vpxor	%xmm1, %xmm8, %xmm8
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm9, %xmm1
vpslld	$0x13, %xmm9, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm8, %xmm7
vpsrld	$0x16, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm9, %xmm2
vpxor	%xmm3, %xmm10, %xmm8
vpaddd	%xmm5, %xmm12, %xmm12
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm8, %xmm8
vpaddd	%xmm7, %xmm8, %xmm8
addq	$0x100, %rbp
vmovdqu	-0x80(%rax), %xmm5
movl	$0x3, %ecx
jmp	L_3ee0
nop
L_3ee0:
vmovdqu	-0x70(%rax), %xmm6
vpaddd	0x10(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	0x60(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm12, %xmm7
vpslld	$0x1a, %xmm12, %xmm2
vmovdqu	%xmm5, -0x80(%rax)
vpaddd	%xmm5, %xmm15, %xmm5
vpsrld	$0xb, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm12, %xmm2
vpaddd	-0x80(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm12, %xmm2
vpandn	%xmm14, %xmm12, %xmm0
vpand	%xmm13, %xmm12, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm8, %xmm15
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm8, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm8, %xmm9, %xmm3
vpxor	%xmm1, %xmm15, %xmm15
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm8, %xmm1
vpslld	$0x13, %xmm8, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm15, %xmm7
vpsrld	$0x16, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm8, %xmm2
vpxor	%xmm4, %xmm9, %xmm15
vpaddd	%xmm5, %xmm11, %xmm11
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm15, %xmm15
vpaddd	%xmm7, %xmm15, %xmm15
vmovdqu	-0x60(%rax), %xmm5
vpaddd	0x20(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	0x70(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm11, %xmm7
vpslld	$0x1a, %xmm11, %xmm2
vmovdqu	%xmm6, -0x70(%rax)
vpaddd	%xmm6, %xmm14, %xmm6
vpsrld	$0xb, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm11, %xmm2
vpaddd	-0x60(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm11, %xmm2
vpandn	%xmm13, %xmm11, %xmm0
vpand	%xmm12, %xmm11, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm15, %xmm14
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm15, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm15, %xmm8, %xmm4
vpxor	%xmm1, %xmm14, %xmm14
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm15, %xmm1
vpslld	$0x13, %xmm15, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm14, %xmm7
vpsrld	$0x16, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm15, %xmm2
vpxor	%xmm3, %xmm8, %xmm14
vpaddd	%xmm6, %xmm10, %xmm10
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm14, %xmm14
vpaddd	%xmm7, %xmm14, %xmm14
vmovdqu	-0x50(%rax), %xmm6
vpaddd	0x30(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	-0x80(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm10, %xmm7
vpslld	$0x1a, %xmm10, %xmm2
vmovdqu	%xmm5, -0x60(%rax)
vpaddd	%xmm5, %xmm13, %xmm5
vpsrld	$0xb, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm10, %xmm2
vpaddd	-0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm10, %xmm2
vpandn	%xmm12, %xmm10, %xmm0
vpand	%xmm11, %xmm10, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm14, %xmm13
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm14, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm14, %xmm15, %xmm3
vpxor	%xmm1, %xmm13, %xmm13
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm14, %xmm1
vpslld	$0x13, %xmm14, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm13, %xmm7
vpsrld	$0x16, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm14, %xmm2
vpxor	%xmm4, %xmm15, %xmm13
vpaddd	%xmm5, %xmm9, %xmm9
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm13, %xmm13
vpaddd	%xmm7, %xmm13, %xmm13
vmovdqu	-0x40(%rax), %xmm5
vpaddd	0x40(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	-0x70(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm9, %xmm7
vpslld	$0x1a, %xmm9, %xmm2
vmovdqu	%xmm6, -0x50(%rax)
vpaddd	%xmm6, %xmm12, %xmm6
vpsrld	$0xb, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm9, %xmm2
vpaddd	-0x20(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm9, %xmm2
vpandn	%xmm11, %xmm9, %xmm0
vpand	%xmm10, %xmm9, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm13, %xmm12
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm13, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm13, %xmm14, %xmm4
vpxor	%xmm1, %xmm12, %xmm12
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm13, %xmm1
vpslld	$0x13, %xmm13, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm12, %xmm7
vpsrld	$0x16, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm13, %xmm2
vpxor	%xmm3, %xmm14, %xmm12
vpaddd	%xmm6, %xmm8, %xmm8
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm12, %xmm12
vpaddd	%xmm7, %xmm12, %xmm12
vmovdqu	-0x30(%rax), %xmm6
vpaddd	0x50(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	-0x60(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm8, %xmm7
vpslld	$0x1a, %xmm8, %xmm2
vmovdqu	%xmm5, -0x40(%rax)
vpaddd	%xmm5, %xmm11, %xmm5
vpsrld	$0xb, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm8, %xmm2
vpaddd	(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm8, %xmm2
vpandn	%xmm10, %xmm8, %xmm0
vpand	%xmm9, %xmm8, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm12, %xmm11
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm12, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm12, %xmm13, %xmm3
vpxor	%xmm1, %xmm11, %xmm11
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm12, %xmm1
vpslld	$0x13, %xmm12, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm11, %xmm7
vpsrld	$0x16, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm12, %xmm2
vpxor	%xmm4, %xmm13, %xmm11
vpaddd	%xmm5, %xmm15, %xmm15
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm11, %xmm11
vpaddd	%xmm7, %xmm11, %xmm11
vmovdqu	-0x20(%rax), %xmm5
vpaddd	0x60(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	-0x50(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm15, %xmm7
vpslld	$0x1a, %xmm15, %xmm2
vmovdqu	%xmm6, -0x30(%rax)
vpaddd	%xmm6, %xmm10, %xmm6
vpsrld	$0xb, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm15, %xmm2
vpaddd	0x20(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm15, %xmm2
vpandn	%xmm9, %xmm15, %xmm0
vpand	%xmm8, %xmm15, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm11, %xmm10
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm11, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm11, %xmm12, %xmm4
vpxor	%xmm1, %xmm10, %xmm10
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm11, %xmm1
vpslld	$0x13, %xmm11, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm10, %xmm7
vpsrld	$0x16, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm11, %xmm2
vpxor	%xmm3, %xmm12, %xmm10
vpaddd	%xmm6, %xmm14, %xmm14
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm10, %xmm10
vpaddd	%xmm7, %xmm10, %xmm10
vmovdqu	-0x10(%rax), %xmm6
vpaddd	0x70(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	-0x40(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm14, %xmm7
vpslld	$0x1a, %xmm14, %xmm2
vmovdqu	%xmm5, -0x20(%rax)
vpaddd	%xmm5, %xmm9, %xmm5
vpsrld	$0xb, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm14, %xmm2
vpaddd	0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm14, %xmm2
vpandn	%xmm8, %xmm14, %xmm0
vpand	%xmm15, %xmm14, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm10, %xmm9
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm10, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm10, %xmm11, %xmm3
vpxor	%xmm1, %xmm9, %xmm9
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm10, %xmm1
vpslld	$0x13, %xmm10, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm7
vpsrld	$0x16, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm10, %xmm2
vpxor	%xmm4, %xmm11, %xmm9
vpaddd	%xmm5, %xmm13, %xmm13
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm9, %xmm9
vpaddd	%xmm7, %xmm9, %xmm9
vmovdqu	(%rax), %xmm5
vpaddd	-0x80(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	-0x30(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm13, %xmm7
vpslld	$0x1a, %xmm13, %xmm2
vmovdqu	%xmm6, -0x10(%rax)
vpaddd	%xmm6, %xmm8, %xmm6
vpsrld	$0xb, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm13, %xmm2
vpaddd	0x60(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm13, %xmm2
vpandn	%xmm15, %xmm13, %xmm0
vpand	%xmm14, %xmm13, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm9, %xmm8
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm9, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm9, %xmm10, %xmm4
vpxor	%xmm1, %xmm8, %xmm8
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm9, %xmm1
vpslld	$0x13, %xmm9, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm8, %xmm7
vpsrld	$0x16, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm9, %xmm2
vpxor	%xmm3, %xmm10, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm8, %xmm8
vpaddd	%xmm7, %xmm8, %xmm8
addq	$0x100, %rbp
vmovdqu	0x10(%rax), %xmm6
vpaddd	-0x70(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	-0x20(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm12, %xmm7
vpslld	$0x1a, %xmm12, %xmm2
vmovdqu	%xmm5, (%rax)
vpaddd	%xmm5, %xmm15, %xmm5
vpsrld	$0xb, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm12, %xmm2
vpaddd	-0x80(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm12, %xmm2
vpandn	%xmm14, %xmm12, %xmm0
vpand	%xmm13, %xmm12, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm8, %xmm15
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm8, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm8, %xmm9, %xmm3
vpxor	%xmm1, %xmm15, %xmm15
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm8, %xmm1
vpslld	$0x13, %xmm8, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm15, %xmm7
vpsrld	$0x16, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm8, %xmm2
vpxor	%xmm4, %xmm9, %xmm15
vpaddd	%xmm5, %xmm11, %xmm11
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm15, %xmm15
vpaddd	%xmm7, %xmm15, %xmm15
vmovdqu	0x20(%rax), %xmm5
vpaddd	-0x60(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	-0x10(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm11, %xmm7
vpslld	$0x1a, %xmm11, %xmm2
vmovdqu	%xmm6, 0x10(%rax)
vpaddd	%xmm6, %xmm14, %xmm6
vpsrld	$0xb, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm11, %xmm2
vpaddd	-0x60(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm11, %xmm2
vpandn	%xmm13, %xmm11, %xmm0
vpand	%xmm12, %xmm11, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm15, %xmm14
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm15, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm15, %xmm8, %xmm4
vpxor	%xmm1, %xmm14, %xmm14
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm15, %xmm1
vpslld	$0x13, %xmm15, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm14, %xmm7
vpsrld	$0x16, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm15, %xmm2
vpxor	%xmm3, %xmm8, %xmm14
vpaddd	%xmm6, %xmm10, %xmm10
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm14, %xmm14
vpaddd	%xmm7, %xmm14, %xmm14
vmovdqu	0x30(%rax), %xmm6
vpaddd	-0x50(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm10, %xmm7
vpslld	$0x1a, %xmm10, %xmm2
vmovdqu	%xmm5, 0x20(%rax)
vpaddd	%xmm5, %xmm13, %xmm5
vpsrld	$0xb, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm10, %xmm2
vpaddd	-0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm10, %xmm2
vpandn	%xmm12, %xmm10, %xmm0
vpand	%xmm11, %xmm10, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm14, %xmm13
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm14, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm14, %xmm15, %xmm3
vpxor	%xmm1, %xmm13, %xmm13
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm14, %xmm1
vpslld	$0x13, %xmm14, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm13, %xmm7
vpsrld	$0x16, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm14, %xmm2
vpxor	%xmm4, %xmm15, %xmm13
vpaddd	%xmm5, %xmm9, %xmm9
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm13, %xmm13
vpaddd	%xmm7, %xmm13, %xmm13
vmovdqu	0x40(%rax), %xmm5
vpaddd	-0x40(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	0x10(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm9, %xmm7
vpslld	$0x1a, %xmm9, %xmm2
vmovdqu	%xmm6, 0x30(%rax)
vpaddd	%xmm6, %xmm12, %xmm6
vpsrld	$0xb, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm9, %xmm2
vpaddd	-0x20(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm9, %xmm2
vpandn	%xmm11, %xmm9, %xmm0
vpand	%xmm10, %xmm9, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm13, %xmm12
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm13, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm13, %xmm14, %xmm4
vpxor	%xmm1, %xmm12, %xmm12
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm13, %xmm1
vpslld	$0x13, %xmm13, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm12, %xmm7
vpsrld	$0x16, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm13, %xmm2
vpxor	%xmm3, %xmm14, %xmm12
vpaddd	%xmm6, %xmm8, %xmm8
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm12, %xmm12
vpaddd	%xmm7, %xmm12, %xmm12
vmovdqu	0x50(%rax), %xmm6
vpaddd	-0x30(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	0x20(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm8, %xmm7
vpslld	$0x1a, %xmm8, %xmm2
vmovdqu	%xmm5, 0x40(%rax)
vpaddd	%xmm5, %xmm11, %xmm5
vpsrld	$0xb, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm8, %xmm2
vpaddd	(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm8, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm8, %xmm2
vpandn	%xmm10, %xmm8, %xmm0
vpand	%xmm9, %xmm8, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm12, %xmm11
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm12, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm12, %xmm13, %xmm3
vpxor	%xmm1, %xmm11, %xmm11
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm12, %xmm1
vpslld	$0x13, %xmm12, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm11, %xmm7
vpsrld	$0x16, %xmm12, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm12, %xmm2
vpxor	%xmm4, %xmm13, %xmm11
vpaddd	%xmm5, %xmm15, %xmm15
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm11, %xmm11
vpaddd	%xmm7, %xmm11, %xmm11
vmovdqu	0x60(%rax), %xmm5
vpaddd	-0x20(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	0x30(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm15, %xmm7
vpslld	$0x1a, %xmm15, %xmm2
vmovdqu	%xmm6, 0x50(%rax)
vpaddd	%xmm6, %xmm10, %xmm6
vpsrld	$0xb, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm15, %xmm2
vpaddd	0x20(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm15, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm15, %xmm2
vpandn	%xmm9, %xmm15, %xmm0
vpand	%xmm8, %xmm15, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm11, %xmm10
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm11, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm11, %xmm12, %xmm4
vpxor	%xmm1, %xmm10, %xmm10
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm11, %xmm1
vpslld	$0x13, %xmm11, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm10, %xmm7
vpsrld	$0x16, %xmm11, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm11, %xmm2
vpxor	%xmm3, %xmm12, %xmm10
vpaddd	%xmm6, %xmm14, %xmm14
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm10, %xmm10
vpaddd	%xmm7, %xmm10, %xmm10
vmovdqu	0x70(%rax), %xmm6
vpaddd	-0x10(%rax), %xmm5, %xmm5
vpsrld	$0x3, %xmm6, %xmm7
vpsrld	$0x7, %xmm6, %xmm1
vpslld	$0x19, %xmm6, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm6, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm6, %xmm2
vmovdqu	0x40(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm5, %xmm5
vpxor	%xmm1, %xmm3, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0x6, %xmm14, %xmm7
vpslld	$0x1a, %xmm14, %xmm2
vmovdqu	%xmm5, 0x60(%rax)
vpaddd	%xmm5, %xmm9, %xmm5
vpsrld	$0xb, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm14, %xmm2
vpaddd	0x40(%rbp), %xmm5, %xmm5
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm14, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm14, %xmm2
vpandn	%xmm8, %xmm14, %xmm0
vpand	%xmm15, %xmm14, %xmm3
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm10, %xmm9
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm10, %xmm1
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm10, %xmm11, %xmm3
vpxor	%xmm1, %xmm9, %xmm9
vpaddd	%xmm7, %xmm5, %xmm5
vpsrld	$0xd, %xmm10, %xmm1
vpslld	$0x13, %xmm10, %xmm2
vpaddd	%xmm0, %xmm5, %xmm5
vpand	%xmm3, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm7
vpsrld	$0x16, %xmm10, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm10, %xmm2
vpxor	%xmm4, %xmm11, %xmm9
vpaddd	%xmm5, %xmm13, %xmm13
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm5, %xmm9, %xmm9
vpaddd	%xmm7, %xmm9, %xmm9
vmovdqu	-0x80(%rax), %xmm5
vpaddd	(%rax), %xmm6, %xmm6
vpsrld	$0x3, %xmm5, %xmm7
vpsrld	$0x7, %xmm5, %xmm1
vpslld	$0x19, %xmm5, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x12, %xmm5, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xe, %xmm5, %xmm2
vmovdqu	0x50(%rax), %xmm0
vpsrld	$0xa, %xmm0, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x11, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xf, %xmm0, %xmm2
vpaddd	%xmm7, %xmm6, %xmm6
vpxor	%xmm1, %xmm4, %xmm7
vpsrld	$0x13, %xmm0, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xd, %xmm0, %xmm2
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0x6, %xmm13, %xmm7
vpslld	$0x1a, %xmm13, %xmm2
vmovdqu	%xmm6, 0x70(%rax)
vpaddd	%xmm6, %xmm8, %xmm6
vpsrld	$0xb, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x15, %xmm13, %xmm2
vpaddd	0x60(%rbp), %xmm6, %xmm6
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x19, %xmm13, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x7, %xmm13, %xmm2
vpandn	%xmm15, %xmm13, %xmm0
vpand	%xmm14, %xmm13, %xmm4
vpxor	%xmm1, %xmm7, %xmm7
vpsrld	$0x2, %xmm9, %xmm8
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0x1e, %xmm9, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm9, %xmm10, %xmm4
vpxor	%xmm1, %xmm8, %xmm8
vpaddd	%xmm7, %xmm6, %xmm6
vpsrld	$0xd, %xmm9, %xmm1
vpslld	$0x13, %xmm9, %xmm2
vpaddd	%xmm0, %xmm6, %xmm6
vpand	%xmm4, %xmm3, %xmm3
vpxor	%xmm1, %xmm8, %xmm7
vpsrld	$0x16, %xmm9, %xmm1
vpxor	%xmm2, %xmm7, %xmm7
vpslld	$0xa, %xmm9, %xmm2
vpxor	%xmm3, %xmm10, %xmm8
vpaddd	%xmm6, %xmm12, %xmm12
vpxor	%xmm1, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
vpaddd	%xmm6, %xmm8, %xmm8
vpaddd	%xmm7, %xmm8, %xmm8
addq	$0x100, %rbp
decl	%ecx
jne	L_3ee0
movl	$0x1, %ecx
leaq	K256+128(%rip), %rbp
cmpl	(%rbx), %ecx
cmovgeq	%rbp, %r8
cmpl	0x4(%rbx), %ecx
cmovgeq	%rbp, %r9
cmpl	0x8(%rbx), %ecx
cmovgeq	%rbp, %r10
cmpl	0xc(%rbx), %ecx
cmovgeq	%rbp, %r11
vmovdqa	(%rbx), %xmm7
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa	%xmm7, %xmm6
vpcmpgtd	%xmm0, %xmm6, %xmm6
vpaddd	%xmm6, %xmm7, %xmm7
vmovdqu	-0x80(%rdi), %xmm0
vpand	%xmm6, %xmm8, %xmm8
vmovdqu	-0x60(%rdi), %xmm1
vpand	%xmm6, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm2
vpand	%xmm6, %xmm10, %xmm10
vmovdqu	-0x20(%rdi), %xmm5
vpand	%xmm6, %xmm11, %xmm11
vpaddd	%xmm0, %xmm8, %xmm8
vmovdqu	(%rdi), %xmm0
vpand	%xmm6, %xmm12, %xmm12
vpaddd	%xmm1, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm1
vpand	%xmm6, %xmm13, %xmm13
vpaddd	%xmm2, %xmm10, %xmm10
vmovdqu	0x40(%rdi), %xmm2
vpand	%xmm6, %xmm14, %xmm14
vpaddd	%xmm5, %xmm11, %xmm11
vmovdqu	0x60(%rdi), %xmm5
vpand	%xmm6, %xmm15, %xmm15
vpaddd	%xmm0, %xmm12, %xmm12
vpaddd	%xmm1, %xmm13, %xmm13
vmovdqu	%xmm8, -0x80(%rdi)
vpaddd	%xmm2, %xmm14, %xmm14
vmovdqu	%xmm9, -0x60(%rdi)
vpaddd	%xmm5, %xmm15, %xmm15
vmovdqu	%xmm10, -0x40(%rdi)
vmovdqu	%xmm11, -0x20(%rdi)
vmovdqu	%xmm12, (%rdi)
vmovdqu	%xmm13, 0x20(%rdi)
vmovdqu	%xmm14, 0x40(%rdi)
vmovdqu	%xmm15, 0x60(%rdi)
vmovdqu	%xmm7, (%rbx)
vmovdqu	K256_shaext-32(%rip), %xmm6
decl	%edx
jne	L_31a0
movl	0x118(%rsp), %edx
leaq	0x10(%rdi), %rdi
leaq	0x40(%rsi), %rsi
decl	%edx
jne	L_30f1
L_5146:
movq	0x110(%rsp), %rax
vzeroupper
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nop
_avx2_shortcut:
sha256_multi_block_avx2:
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
leaq	K256+128(%rip), %rbp
leaq	0x80(%rdi), %rdi
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
vmovdqu	-0x80(%rdi), %ymm8
leaq	0x80(%rsp), %rax
vmovdqu	-0x60(%rdi), %ymm9
leaq	0x180(%rsp), %rbx
vmovdqu	-0x40(%rdi), %ymm10
vmovdqu	-0x20(%rdi), %ymm11
vmovdqu	(%rdi), %ymm12
vmovdqu	0x20(%rdi), %ymm13
vmovdqu	0x40(%rdi), %ymm14
vmovdqu	0x60(%rdi), %ymm15
vmovdqu	K256_shaext-32(%rip), %ymm6
jmp	L_52a0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_52a0:
vpxor	%ymm9, %ymm10, %ymm4
vmovd	(%r12), %xmm5
vmovd	(%r8), %xmm0
vmovd	(%r13), %xmm1
vmovd	(%r9), %xmm2
vpinsrd	$0x1, (%r14), %xmm5, %xmm5
vpinsrd	$0x1, (%r10), %xmm0, %xmm0
vpinsrd	$0x1, (%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, (%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm12, %ymm7
vpslld	$0x1a, %ymm12, %ymm2
vmovdqu	%ymm5, -0x80(%rax)
vpaddd	%ymm5, %ymm15, %ymm5
vpsrld	$0xb, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm12, %ymm2
vpaddd	-0x80(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm12, %ymm2
vpandn	%ymm14, %ymm12, %ymm0
vpand	%ymm13, %ymm12, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm8, %ymm15
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm8, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm8, %ymm9, %ymm3
vpxor	%ymm1, %ymm15, %ymm15
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm8, %ymm1
vpslld	$0x13, %ymm8, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm15, %ymm7
vpsrld	$0x16, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm8, %ymm2
vpxor	%ymm4, %ymm9, %ymm15
vpaddd	%ymm5, %ymm11, %ymm11
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm15, %ymm15
vpaddd	%ymm7, %ymm15, %ymm15
vmovd	0x4(%r12), %xmm5
vmovd	0x4(%r8), %xmm0
vmovd	0x4(%r13), %xmm1
vmovd	0x4(%r9), %xmm2
vpinsrd	$0x1, 0x4(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x4(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x4(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x4(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm11, %ymm7
vpslld	$0x1a, %ymm11, %ymm2
vmovdqu	%ymm5, -0x60(%rax)
vpaddd	%ymm5, %ymm14, %ymm5
vpsrld	$0xb, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm11, %ymm2
vpaddd	-0x60(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm11, %ymm2
vpandn	%ymm13, %ymm11, %ymm0
vpand	%ymm12, %ymm11, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm15, %ymm14
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm15, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm15, %ymm8, %ymm4
vpxor	%ymm1, %ymm14, %ymm14
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm15, %ymm1
vpslld	$0x13, %ymm15, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm14, %ymm7
vpsrld	$0x16, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm15, %ymm2
vpxor	%ymm3, %ymm8, %ymm14
vpaddd	%ymm5, %ymm10, %ymm10
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm14, %ymm14
vpaddd	%ymm7, %ymm14, %ymm14
vmovd	0x8(%r12), %xmm5
vmovd	0x8(%r8), %xmm0
vmovd	0x8(%r13), %xmm1
vmovd	0x8(%r9), %xmm2
vpinsrd	$0x1, 0x8(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x8(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x8(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x8(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm10, %ymm7
vpslld	$0x1a, %ymm10, %ymm2
vmovdqu	%ymm5, -0x40(%rax)
vpaddd	%ymm5, %ymm13, %ymm5
vpsrld	$0xb, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm10, %ymm2
vpaddd	-0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm10, %ymm2
vpandn	%ymm12, %ymm10, %ymm0
vpand	%ymm11, %ymm10, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm14, %ymm13
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm14, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm14, %ymm15, %ymm3
vpxor	%ymm1, %ymm13, %ymm13
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm14, %ymm1
vpslld	$0x13, %ymm14, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm13, %ymm7
vpsrld	$0x16, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm14, %ymm2
vpxor	%ymm4, %ymm15, %ymm13
vpaddd	%ymm5, %ymm9, %ymm9
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm13, %ymm13
vpaddd	%ymm7, %ymm13, %ymm13
vmovd	0xc(%r12), %xmm5
vmovd	0xc(%r8), %xmm0
vmovd	0xc(%r13), %xmm1
vmovd	0xc(%r9), %xmm2
vpinsrd	$0x1, 0xc(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0xc(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0xc(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0xc(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm9, %ymm7
vpslld	$0x1a, %ymm9, %ymm2
vmovdqu	%ymm5, -0x20(%rax)
vpaddd	%ymm5, %ymm12, %ymm5
vpsrld	$0xb, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm9, %ymm2
vpaddd	-0x20(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm9, %ymm2
vpandn	%ymm11, %ymm9, %ymm0
vpand	%ymm10, %ymm9, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm13, %ymm12
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm13, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm13, %ymm14, %ymm4
vpxor	%ymm1, %ymm12, %ymm12
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm13, %ymm1
vpslld	$0x13, %ymm13, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm12, %ymm7
vpsrld	$0x16, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm13, %ymm2
vpxor	%ymm3, %ymm14, %ymm12
vpaddd	%ymm5, %ymm8, %ymm8
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm12, %ymm12
vpaddd	%ymm7, %ymm12, %ymm12
vmovd	0x10(%r12), %xmm5
vmovd	0x10(%r8), %xmm0
vmovd	0x10(%r13), %xmm1
vmovd	0x10(%r9), %xmm2
vpinsrd	$0x1, 0x10(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x10(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x10(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x10(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm8, %ymm7
vpslld	$0x1a, %ymm8, %ymm2
vmovdqu	%ymm5, (%rax)
vpaddd	%ymm5, %ymm11, %ymm5
vpsrld	$0xb, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm8, %ymm2
vpaddd	(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm8, %ymm2
vpandn	%ymm10, %ymm8, %ymm0
vpand	%ymm9, %ymm8, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm12, %ymm11
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm12, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm12, %ymm13, %ymm3
vpxor	%ymm1, %ymm11, %ymm11
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm12, %ymm1
vpslld	$0x13, %ymm12, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm11, %ymm7
vpsrld	$0x16, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm12, %ymm2
vpxor	%ymm4, %ymm13, %ymm11
vpaddd	%ymm5, %ymm15, %ymm15
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm11, %ymm11
vpaddd	%ymm7, %ymm11, %ymm11
vmovd	0x14(%r12), %xmm5
vmovd	0x14(%r8), %xmm0
vmovd	0x14(%r13), %xmm1
vmovd	0x14(%r9), %xmm2
vpinsrd	$0x1, 0x14(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x14(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x14(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x14(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm15, %ymm7
vpslld	$0x1a, %ymm15, %ymm2
vmovdqu	%ymm5, 0x20(%rax)
vpaddd	%ymm5, %ymm10, %ymm5
vpsrld	$0xb, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm15, %ymm2
vpaddd	0x20(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm15, %ymm2
vpandn	%ymm9, %ymm15, %ymm0
vpand	%ymm8, %ymm15, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm11, %ymm10
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm11, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm11, %ymm12, %ymm4
vpxor	%ymm1, %ymm10, %ymm10
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm11, %ymm1
vpslld	$0x13, %ymm11, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm10, %ymm7
vpsrld	$0x16, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm11, %ymm2
vpxor	%ymm3, %ymm12, %ymm10
vpaddd	%ymm5, %ymm14, %ymm14
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm10, %ymm10
vpaddd	%ymm7, %ymm10, %ymm10
vmovd	0x18(%r12), %xmm5
vmovd	0x18(%r8), %xmm0
vmovd	0x18(%r13), %xmm1
vmovd	0x18(%r9), %xmm2
vpinsrd	$0x1, 0x18(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x18(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x18(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x18(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm14, %ymm7
vpslld	$0x1a, %ymm14, %ymm2
vmovdqu	%ymm5, 0x40(%rax)
vpaddd	%ymm5, %ymm9, %ymm5
vpsrld	$0xb, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm14, %ymm2
vpaddd	0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm14, %ymm2
vpandn	%ymm8, %ymm14, %ymm0
vpand	%ymm15, %ymm14, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm10, %ymm9
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm10, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm10, %ymm11, %ymm3
vpxor	%ymm1, %ymm9, %ymm9
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm10, %ymm1
vpslld	$0x13, %ymm10, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm9, %ymm7
vpsrld	$0x16, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm10, %ymm2
vpxor	%ymm4, %ymm11, %ymm9
vpaddd	%ymm5, %ymm13, %ymm13
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm9, %ymm9
vpaddd	%ymm7, %ymm9, %ymm9
vmovd	0x1c(%r12), %xmm5
vmovd	0x1c(%r8), %xmm0
vmovd	0x1c(%r13), %xmm1
vmovd	0x1c(%r9), %xmm2
vpinsrd	$0x1, 0x1c(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x1c(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x1c(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x1c(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm13, %ymm7
vpslld	$0x1a, %ymm13, %ymm2
vmovdqu	%ymm5, 0x60(%rax)
vpaddd	%ymm5, %ymm8, %ymm5
vpsrld	$0xb, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm13, %ymm2
vpaddd	0x60(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm13, %ymm2
vpandn	%ymm15, %ymm13, %ymm0
vpand	%ymm14, %ymm13, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm9, %ymm8
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm9, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm9, %ymm10, %ymm4
vpxor	%ymm1, %ymm8, %ymm8
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm9, %ymm1
vpslld	$0x13, %ymm9, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm8, %ymm7
vpsrld	$0x16, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm9, %ymm2
vpxor	%ymm3, %ymm10, %ymm8
vpaddd	%ymm5, %ymm12, %ymm12
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm8, %ymm8
vpaddd	%ymm7, %ymm8, %ymm8
addq	$0x100, %rbp
vmovd	0x20(%r12), %xmm5
vmovd	0x20(%r8), %xmm0
vmovd	0x20(%r13), %xmm1
vmovd	0x20(%r9), %xmm2
vpinsrd	$0x1, 0x20(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x20(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x20(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x20(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm12, %ymm7
vpslld	$0x1a, %ymm12, %ymm2
vmovdqu	%ymm5, -0x80(%rbx)
vpaddd	%ymm5, %ymm15, %ymm5
vpsrld	$0xb, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm12, %ymm2
vpaddd	-0x80(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm12, %ymm2
vpandn	%ymm14, %ymm12, %ymm0
vpand	%ymm13, %ymm12, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm8, %ymm15
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm8, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm8, %ymm9, %ymm3
vpxor	%ymm1, %ymm15, %ymm15
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm8, %ymm1
vpslld	$0x13, %ymm8, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm15, %ymm7
vpsrld	$0x16, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm8, %ymm2
vpxor	%ymm4, %ymm9, %ymm15
vpaddd	%ymm5, %ymm11, %ymm11
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm15, %ymm15
vpaddd	%ymm7, %ymm15, %ymm15
vmovd	0x24(%r12), %xmm5
vmovd	0x24(%r8), %xmm0
vmovd	0x24(%r13), %xmm1
vmovd	0x24(%r9), %xmm2
vpinsrd	$0x1, 0x24(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x24(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x24(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x24(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm11, %ymm7
vpslld	$0x1a, %ymm11, %ymm2
vmovdqu	%ymm5, -0x60(%rbx)
vpaddd	%ymm5, %ymm14, %ymm5
vpsrld	$0xb, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm11, %ymm2
vpaddd	-0x60(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm11, %ymm2
vpandn	%ymm13, %ymm11, %ymm0
vpand	%ymm12, %ymm11, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm15, %ymm14
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm15, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm15, %ymm8, %ymm4
vpxor	%ymm1, %ymm14, %ymm14
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm15, %ymm1
vpslld	$0x13, %ymm15, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm14, %ymm7
vpsrld	$0x16, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm15, %ymm2
vpxor	%ymm3, %ymm8, %ymm14
vpaddd	%ymm5, %ymm10, %ymm10
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm14, %ymm14
vpaddd	%ymm7, %ymm14, %ymm14
vmovd	0x28(%r12), %xmm5
vmovd	0x28(%r8), %xmm0
vmovd	0x28(%r13), %xmm1
vmovd	0x28(%r9), %xmm2
vpinsrd	$0x1, 0x28(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x28(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x28(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x28(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm10, %ymm7
vpslld	$0x1a, %ymm10, %ymm2
vmovdqu	%ymm5, -0x40(%rbx)
vpaddd	%ymm5, %ymm13, %ymm5
vpsrld	$0xb, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm10, %ymm2
vpaddd	-0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm10, %ymm2
vpandn	%ymm12, %ymm10, %ymm0
vpand	%ymm11, %ymm10, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm14, %ymm13
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm14, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm14, %ymm15, %ymm3
vpxor	%ymm1, %ymm13, %ymm13
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm14, %ymm1
vpslld	$0x13, %ymm14, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm13, %ymm7
vpsrld	$0x16, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm14, %ymm2
vpxor	%ymm4, %ymm15, %ymm13
vpaddd	%ymm5, %ymm9, %ymm9
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm13, %ymm13
vpaddd	%ymm7, %ymm13, %ymm13
vmovd	0x2c(%r12), %xmm5
vmovd	0x2c(%r8), %xmm0
vmovd	0x2c(%r13), %xmm1
vmovd	0x2c(%r9), %xmm2
vpinsrd	$0x1, 0x2c(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x2c(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x2c(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x2c(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm9, %ymm7
vpslld	$0x1a, %ymm9, %ymm2
vmovdqu	%ymm5, -0x20(%rbx)
vpaddd	%ymm5, %ymm12, %ymm5
vpsrld	$0xb, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm9, %ymm2
vpaddd	-0x20(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm9, %ymm2
vpandn	%ymm11, %ymm9, %ymm0
vpand	%ymm10, %ymm9, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm13, %ymm12
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm13, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm13, %ymm14, %ymm4
vpxor	%ymm1, %ymm12, %ymm12
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm13, %ymm1
vpslld	$0x13, %ymm13, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm12, %ymm7
vpsrld	$0x16, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm13, %ymm2
vpxor	%ymm3, %ymm14, %ymm12
vpaddd	%ymm5, %ymm8, %ymm8
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm12, %ymm12
vpaddd	%ymm7, %ymm12, %ymm12
vmovd	0x30(%r12), %xmm5
vmovd	0x30(%r8), %xmm0
vmovd	0x30(%r13), %xmm1
vmovd	0x30(%r9), %xmm2
vpinsrd	$0x1, 0x30(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x30(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x30(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x30(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm8, %ymm7
vpslld	$0x1a, %ymm8, %ymm2
vmovdqu	%ymm5, (%rbx)
vpaddd	%ymm5, %ymm11, %ymm5
vpsrld	$0xb, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm8, %ymm2
vpaddd	(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm8, %ymm2
vpandn	%ymm10, %ymm8, %ymm0
vpand	%ymm9, %ymm8, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm12, %ymm11
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm12, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm12, %ymm13, %ymm3
vpxor	%ymm1, %ymm11, %ymm11
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm12, %ymm1
vpslld	$0x13, %ymm12, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm11, %ymm7
vpsrld	$0x16, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm12, %ymm2
vpxor	%ymm4, %ymm13, %ymm11
vpaddd	%ymm5, %ymm15, %ymm15
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm11, %ymm11
vpaddd	%ymm7, %ymm11, %ymm11
vmovd	0x34(%r12), %xmm5
vmovd	0x34(%r8), %xmm0
vmovd	0x34(%r13), %xmm1
vmovd	0x34(%r9), %xmm2
vpinsrd	$0x1, 0x34(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x34(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x34(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x34(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm15, %ymm7
vpslld	$0x1a, %ymm15, %ymm2
vmovdqu	%ymm5, 0x20(%rbx)
vpaddd	%ymm5, %ymm10, %ymm5
vpsrld	$0xb, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm15, %ymm2
vpaddd	0x20(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm15, %ymm2
vpandn	%ymm9, %ymm15, %ymm0
vpand	%ymm8, %ymm15, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm11, %ymm10
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm11, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm11, %ymm12, %ymm4
vpxor	%ymm1, %ymm10, %ymm10
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm11, %ymm1
vpslld	$0x13, %ymm11, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm10, %ymm7
vpsrld	$0x16, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm11, %ymm2
vpxor	%ymm3, %ymm12, %ymm10
vpaddd	%ymm5, %ymm14, %ymm14
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm10, %ymm10
vpaddd	%ymm7, %ymm10, %ymm10
vmovd	0x38(%r12), %xmm5
vmovd	0x38(%r8), %xmm0
vmovd	0x38(%r13), %xmm1
vmovd	0x38(%r9), %xmm2
vpinsrd	$0x1, 0x38(%r14), %xmm5, %xmm5
vpinsrd	$0x1, 0x38(%r10), %xmm0, %xmm0
vpinsrd	$0x1, 0x38(%r15), %xmm1, %xmm1
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x38(%r11), %xmm2, %xmm2
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm14, %ymm7
vpslld	$0x1a, %ymm14, %ymm2
vmovdqu	%ymm5, 0x40(%rbx)
vpaddd	%ymm5, %ymm9, %ymm5
vpsrld	$0xb, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm14, %ymm2
vpaddd	0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm14, %ymm2
vpandn	%ymm8, %ymm14, %ymm0
vpand	%ymm15, %ymm14, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm10, %ymm9
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm10, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm10, %ymm11, %ymm3
vpxor	%ymm1, %ymm9, %ymm9
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm10, %ymm1
vpslld	$0x13, %ymm10, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm9, %ymm7
vpsrld	$0x16, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm10, %ymm2
vpxor	%ymm4, %ymm11, %ymm9
vpaddd	%ymm5, %ymm13, %ymm13
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm9, %ymm9
vpaddd	%ymm7, %ymm9, %ymm9
vmovd	0x3c(%r12), %xmm5
leaq	0x40(%r12), %r12
vmovd	0x3c(%r8), %xmm0
leaq	0x40(%r8), %r8
vmovd	0x3c(%r13), %xmm1
leaq	0x40(%r13), %r13
vmovd	0x3c(%r9), %xmm2
leaq	0x40(%r9), %r9
vpinsrd	$0x1, 0x3c(%r14), %xmm5, %xmm5
leaq	0x40(%r14), %r14
vpinsrd	$0x1, 0x3c(%r10), %xmm0, %xmm0
leaq	0x40(%r10), %r10
vpinsrd	$0x1, 0x3c(%r15), %xmm1, %xmm1
leaq	0x40(%r15), %r15
vpunpckldq	%ymm1, %ymm5, %ymm5
vpinsrd	$0x1, 0x3c(%r11), %xmm2, %xmm2
leaq	0x40(%r11), %r11
vpunpckldq	%ymm2, %ymm0, %ymm0
vinserti128	$0x1, %xmm0, %ymm5, %ymm5
vpshufb	%ymm6, %ymm5, %ymm5
vpsrld	$0x6, %ymm13, %ymm7
vpslld	$0x1a, %ymm13, %ymm2
vmovdqu	%ymm5, 0x60(%rbx)
vpaddd	%ymm5, %ymm8, %ymm5
vpsrld	$0xb, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm13, %ymm2
vpaddd	0x60(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
prefetcht0	0x3f(%r12)
vpslld	$0x7, %ymm13, %ymm2
vpandn	%ymm15, %ymm13, %ymm0
vpand	%ymm14, %ymm13, %ymm4
prefetcht0	0x3f(%r13)
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm9, %ymm8
vpxor	%ymm2, %ymm7, %ymm7
prefetcht0	0x3f(%r14)
vpslld	$0x1e, %ymm9, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm9, %ymm10, %ymm4
prefetcht0	0x3f(%r15)
vpxor	%ymm1, %ymm8, %ymm8
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm9, %ymm1
prefetcht0	0x3f(%r8)
vpslld	$0x13, %ymm9, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm4, %ymm3, %ymm3
prefetcht0	0x3f(%r9)
vpxor	%ymm1, %ymm8, %ymm7
vpsrld	$0x16, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
prefetcht0	0x3f(%r10)
vpslld	$0xa, %ymm9, %ymm2
vpxor	%ymm3, %ymm10, %ymm8
vpaddd	%ymm5, %ymm12, %ymm12
prefetcht0	0x3f(%r11)
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm8, %ymm8
vpaddd	%ymm7, %ymm8, %ymm8
addq	$0x100, %rbp
vmovdqu	-0x80(%rax), %ymm5
movl	$0x3, %ecx
jmp	L_6260
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_6260:
vmovdqu	-0x60(%rax), %ymm6
vpaddd	-0x60(%rbx), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	0x40(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm12, %ymm7
vpslld	$0x1a, %ymm12, %ymm2
vmovdqu	%ymm5, -0x80(%rax)
vpaddd	%ymm5, %ymm15, %ymm5
vpsrld	$0xb, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm12, %ymm2
vpaddd	-0x80(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm12, %ymm2
vpandn	%ymm14, %ymm12, %ymm0
vpand	%ymm13, %ymm12, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm8, %ymm15
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm8, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm8, %ymm9, %ymm3
vpxor	%ymm1, %ymm15, %ymm15
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm8, %ymm1
vpslld	$0x13, %ymm8, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm15, %ymm7
vpsrld	$0x16, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm8, %ymm2
vpxor	%ymm4, %ymm9, %ymm15
vpaddd	%ymm5, %ymm11, %ymm11
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm15, %ymm15
vpaddd	%ymm7, %ymm15, %ymm15
vmovdqu	-0x40(%rax), %ymm5
vpaddd	-0x40(%rbx), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	0x60(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm11, %ymm7
vpslld	$0x1a, %ymm11, %ymm2
vmovdqu	%ymm6, -0x60(%rax)
vpaddd	%ymm6, %ymm14, %ymm6
vpsrld	$0xb, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm11, %ymm2
vpaddd	-0x60(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm11, %ymm2
vpandn	%ymm13, %ymm11, %ymm0
vpand	%ymm12, %ymm11, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm15, %ymm14
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm15, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm15, %ymm8, %ymm4
vpxor	%ymm1, %ymm14, %ymm14
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm15, %ymm1
vpslld	$0x13, %ymm15, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm14, %ymm7
vpsrld	$0x16, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm15, %ymm2
vpxor	%ymm3, %ymm8, %ymm14
vpaddd	%ymm6, %ymm10, %ymm10
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm14, %ymm14
vpaddd	%ymm7, %ymm14, %ymm14
vmovdqu	-0x20(%rax), %ymm6
vpaddd	-0x20(%rbx), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	-0x80(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm10, %ymm7
vpslld	$0x1a, %ymm10, %ymm2
vmovdqu	%ymm5, -0x40(%rax)
vpaddd	%ymm5, %ymm13, %ymm5
vpsrld	$0xb, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm10, %ymm2
vpaddd	-0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm10, %ymm2
vpandn	%ymm12, %ymm10, %ymm0
vpand	%ymm11, %ymm10, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm14, %ymm13
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm14, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm14, %ymm15, %ymm3
vpxor	%ymm1, %ymm13, %ymm13
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm14, %ymm1
vpslld	$0x13, %ymm14, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm13, %ymm7
vpsrld	$0x16, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm14, %ymm2
vpxor	%ymm4, %ymm15, %ymm13
vpaddd	%ymm5, %ymm9, %ymm9
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm13, %ymm13
vpaddd	%ymm7, %ymm13, %ymm13
vmovdqu	(%rax), %ymm5
vpaddd	(%rbx), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	-0x60(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm9, %ymm7
vpslld	$0x1a, %ymm9, %ymm2
vmovdqu	%ymm6, -0x20(%rax)
vpaddd	%ymm6, %ymm12, %ymm6
vpsrld	$0xb, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm9, %ymm2
vpaddd	-0x20(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm9, %ymm2
vpandn	%ymm11, %ymm9, %ymm0
vpand	%ymm10, %ymm9, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm13, %ymm12
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm13, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm13, %ymm14, %ymm4
vpxor	%ymm1, %ymm12, %ymm12
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm13, %ymm1
vpslld	$0x13, %ymm13, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm12, %ymm7
vpsrld	$0x16, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm13, %ymm2
vpxor	%ymm3, %ymm14, %ymm12
vpaddd	%ymm6, %ymm8, %ymm8
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm12, %ymm12
vpaddd	%ymm7, %ymm12, %ymm12
vmovdqu	0x20(%rax), %ymm6
vpaddd	0x20(%rbx), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	-0x40(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm8, %ymm7
vpslld	$0x1a, %ymm8, %ymm2
vmovdqu	%ymm5, (%rax)
vpaddd	%ymm5, %ymm11, %ymm5
vpsrld	$0xb, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm8, %ymm2
vpaddd	(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm8, %ymm2
vpandn	%ymm10, %ymm8, %ymm0
vpand	%ymm9, %ymm8, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm12, %ymm11
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm12, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm12, %ymm13, %ymm3
vpxor	%ymm1, %ymm11, %ymm11
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm12, %ymm1
vpslld	$0x13, %ymm12, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm11, %ymm7
vpsrld	$0x16, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm12, %ymm2
vpxor	%ymm4, %ymm13, %ymm11
vpaddd	%ymm5, %ymm15, %ymm15
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm11, %ymm11
vpaddd	%ymm7, %ymm11, %ymm11
vmovdqu	0x40(%rax), %ymm5
vpaddd	0x40(%rbx), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	-0x20(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm15, %ymm7
vpslld	$0x1a, %ymm15, %ymm2
vmovdqu	%ymm6, 0x20(%rax)
vpaddd	%ymm6, %ymm10, %ymm6
vpsrld	$0xb, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm15, %ymm2
vpaddd	0x20(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm15, %ymm2
vpandn	%ymm9, %ymm15, %ymm0
vpand	%ymm8, %ymm15, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm11, %ymm10
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm11, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm11, %ymm12, %ymm4
vpxor	%ymm1, %ymm10, %ymm10
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm11, %ymm1
vpslld	$0x13, %ymm11, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm10, %ymm7
vpsrld	$0x16, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm11, %ymm2
vpxor	%ymm3, %ymm12, %ymm10
vpaddd	%ymm6, %ymm14, %ymm14
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm10, %ymm10
vpaddd	%ymm7, %ymm10, %ymm10
vmovdqu	0x60(%rax), %ymm6
vpaddd	0x60(%rbx), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm14, %ymm7
vpslld	$0x1a, %ymm14, %ymm2
vmovdqu	%ymm5, 0x40(%rax)
vpaddd	%ymm5, %ymm9, %ymm5
vpsrld	$0xb, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm14, %ymm2
vpaddd	0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm14, %ymm2
vpandn	%ymm8, %ymm14, %ymm0
vpand	%ymm15, %ymm14, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm10, %ymm9
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm10, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm10, %ymm11, %ymm3
vpxor	%ymm1, %ymm9, %ymm9
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm10, %ymm1
vpslld	$0x13, %ymm10, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm9, %ymm7
vpsrld	$0x16, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm10, %ymm2
vpxor	%ymm4, %ymm11, %ymm9
vpaddd	%ymm5, %ymm13, %ymm13
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm9, %ymm9
vpaddd	%ymm7, %ymm9, %ymm9
vmovdqu	-0x80(%rbx), %ymm5
vpaddd	-0x80(%rax), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	0x20(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm13, %ymm7
vpslld	$0x1a, %ymm13, %ymm2
vmovdqu	%ymm6, 0x60(%rax)
vpaddd	%ymm6, %ymm8, %ymm6
vpsrld	$0xb, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm13, %ymm2
vpaddd	0x60(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm13, %ymm2
vpandn	%ymm15, %ymm13, %ymm0
vpand	%ymm14, %ymm13, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm9, %ymm8
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm9, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm9, %ymm10, %ymm4
vpxor	%ymm1, %ymm8, %ymm8
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm9, %ymm1
vpslld	$0x13, %ymm9, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm8, %ymm7
vpsrld	$0x16, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm9, %ymm2
vpxor	%ymm3, %ymm10, %ymm8
vpaddd	%ymm6, %ymm12, %ymm12
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm8, %ymm8
vpaddd	%ymm7, %ymm8, %ymm8
addq	$0x100, %rbp
vmovdqu	-0x60(%rbx), %ymm6
vpaddd	-0x60(%rax), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	0x40(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm12, %ymm7
vpslld	$0x1a, %ymm12, %ymm2
vmovdqu	%ymm5, -0x80(%rbx)
vpaddd	%ymm5, %ymm15, %ymm5
vpsrld	$0xb, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm12, %ymm2
vpaddd	-0x80(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm12, %ymm2
vpandn	%ymm14, %ymm12, %ymm0
vpand	%ymm13, %ymm12, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm8, %ymm15
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm8, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm8, %ymm9, %ymm3
vpxor	%ymm1, %ymm15, %ymm15
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm8, %ymm1
vpslld	$0x13, %ymm8, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm15, %ymm7
vpsrld	$0x16, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm8, %ymm2
vpxor	%ymm4, %ymm9, %ymm15
vpaddd	%ymm5, %ymm11, %ymm11
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm15, %ymm15
vpaddd	%ymm7, %ymm15, %ymm15
vmovdqu	-0x40(%rbx), %ymm5
vpaddd	-0x40(%rax), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	0x60(%rax), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm11, %ymm7
vpslld	$0x1a, %ymm11, %ymm2
vmovdqu	%ymm6, -0x60(%rbx)
vpaddd	%ymm6, %ymm14, %ymm6
vpsrld	$0xb, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm11, %ymm2
vpaddd	-0x60(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm11, %ymm2
vpandn	%ymm13, %ymm11, %ymm0
vpand	%ymm12, %ymm11, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm15, %ymm14
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm15, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm15, %ymm8, %ymm4
vpxor	%ymm1, %ymm14, %ymm14
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm15, %ymm1
vpslld	$0x13, %ymm15, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm14, %ymm7
vpsrld	$0x16, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm15, %ymm2
vpxor	%ymm3, %ymm8, %ymm14
vpaddd	%ymm6, %ymm10, %ymm10
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm14, %ymm14
vpaddd	%ymm7, %ymm14, %ymm14
vmovdqu	-0x20(%rbx), %ymm6
vpaddd	-0x20(%rax), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	-0x80(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm10, %ymm7
vpslld	$0x1a, %ymm10, %ymm2
vmovdqu	%ymm5, -0x40(%rbx)
vpaddd	%ymm5, %ymm13, %ymm5
vpsrld	$0xb, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm10, %ymm2
vpaddd	-0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm10, %ymm2
vpandn	%ymm12, %ymm10, %ymm0
vpand	%ymm11, %ymm10, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm14, %ymm13
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm14, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm14, %ymm15, %ymm3
vpxor	%ymm1, %ymm13, %ymm13
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm14, %ymm1
vpslld	$0x13, %ymm14, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm13, %ymm7
vpsrld	$0x16, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm14, %ymm2
vpxor	%ymm4, %ymm15, %ymm13
vpaddd	%ymm5, %ymm9, %ymm9
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm13, %ymm13
vpaddd	%ymm7, %ymm13, %ymm13
vmovdqu	(%rbx), %ymm5
vpaddd	(%rax), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	-0x60(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm9, %ymm7
vpslld	$0x1a, %ymm9, %ymm2
vmovdqu	%ymm6, -0x20(%rbx)
vpaddd	%ymm6, %ymm12, %ymm6
vpsrld	$0xb, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm9, %ymm2
vpaddd	-0x20(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm9, %ymm2
vpandn	%ymm11, %ymm9, %ymm0
vpand	%ymm10, %ymm9, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm13, %ymm12
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm13, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm13, %ymm14, %ymm4
vpxor	%ymm1, %ymm12, %ymm12
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm13, %ymm1
vpslld	$0x13, %ymm13, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm12, %ymm7
vpsrld	$0x16, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm13, %ymm2
vpxor	%ymm3, %ymm14, %ymm12
vpaddd	%ymm6, %ymm8, %ymm8
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm12, %ymm12
vpaddd	%ymm7, %ymm12, %ymm12
vmovdqu	0x20(%rbx), %ymm6
vpaddd	0x20(%rax), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	-0x40(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm8, %ymm7
vpslld	$0x1a, %ymm8, %ymm2
vmovdqu	%ymm5, (%rbx)
vpaddd	%ymm5, %ymm11, %ymm5
vpsrld	$0xb, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm8, %ymm2
vpaddd	(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm8, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm8, %ymm2
vpandn	%ymm10, %ymm8, %ymm0
vpand	%ymm9, %ymm8, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm12, %ymm11
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm12, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm12, %ymm13, %ymm3
vpxor	%ymm1, %ymm11, %ymm11
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm12, %ymm1
vpslld	$0x13, %ymm12, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm11, %ymm7
vpsrld	$0x16, %ymm12, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm12, %ymm2
vpxor	%ymm4, %ymm13, %ymm11
vpaddd	%ymm5, %ymm15, %ymm15
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm11, %ymm11
vpaddd	%ymm7, %ymm11, %ymm11
vmovdqu	0x40(%rbx), %ymm5
vpaddd	0x40(%rax), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	-0x20(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm15, %ymm7
vpslld	$0x1a, %ymm15, %ymm2
vmovdqu	%ymm6, 0x20(%rbx)
vpaddd	%ymm6, %ymm10, %ymm6
vpsrld	$0xb, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm15, %ymm2
vpaddd	0x20(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm15, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm15, %ymm2
vpandn	%ymm9, %ymm15, %ymm0
vpand	%ymm8, %ymm15, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm11, %ymm10
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm11, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm11, %ymm12, %ymm4
vpxor	%ymm1, %ymm10, %ymm10
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm11, %ymm1
vpslld	$0x13, %ymm11, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm10, %ymm7
vpsrld	$0x16, %ymm11, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm11, %ymm2
vpxor	%ymm3, %ymm12, %ymm10
vpaddd	%ymm6, %ymm14, %ymm14
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm10, %ymm10
vpaddd	%ymm7, %ymm10, %ymm10
vmovdqu	0x60(%rbx), %ymm6
vpaddd	0x60(%rax), %ymm5, %ymm5
vpsrld	$0x3, %ymm6, %ymm7
vpsrld	$0x7, %ymm6, %ymm1
vpslld	$0x19, %ymm6, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm6, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm6, %ymm2
vmovdqu	(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm5, %ymm5
vpxor	%ymm1, %ymm3, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0x6, %ymm14, %ymm7
vpslld	$0x1a, %ymm14, %ymm2
vmovdqu	%ymm5, 0x40(%rbx)
vpaddd	%ymm5, %ymm9, %ymm5
vpsrld	$0xb, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm14, %ymm2
vpaddd	0x40(%rbp), %ymm5, %ymm5
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm14, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm14, %ymm2
vpandn	%ymm8, %ymm14, %ymm0
vpand	%ymm15, %ymm14, %ymm3
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm10, %ymm9
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm10, %ymm1
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm10, %ymm11, %ymm3
vpxor	%ymm1, %ymm9, %ymm9
vpaddd	%ymm7, %ymm5, %ymm5
vpsrld	$0xd, %ymm10, %ymm1
vpslld	$0x13, %ymm10, %ymm2
vpaddd	%ymm0, %ymm5, %ymm5
vpand	%ymm3, %ymm4, %ymm4
vpxor	%ymm1, %ymm9, %ymm7
vpsrld	$0x16, %ymm10, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm10, %ymm2
vpxor	%ymm4, %ymm11, %ymm9
vpaddd	%ymm5, %ymm13, %ymm13
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm5, %ymm9, %ymm9
vpaddd	%ymm7, %ymm9, %ymm9
vmovdqu	-0x80(%rax), %ymm5
vpaddd	-0x80(%rbx), %ymm6, %ymm6
vpsrld	$0x3, %ymm5, %ymm7
vpsrld	$0x7, %ymm5, %ymm1
vpslld	$0x19, %ymm5, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x12, %ymm5, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xe, %ymm5, %ymm2
vmovdqu	0x20(%rbx), %ymm0
vpsrld	$0xa, %ymm0, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x11, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xf, %ymm0, %ymm2
vpaddd	%ymm7, %ymm6, %ymm6
vpxor	%ymm1, %ymm4, %ymm7
vpsrld	$0x13, %ymm0, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xd, %ymm0, %ymm2
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0x6, %ymm13, %ymm7
vpslld	$0x1a, %ymm13, %ymm2
vmovdqu	%ymm6, 0x60(%rbx)
vpaddd	%ymm6, %ymm8, %ymm6
vpsrld	$0xb, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x15, %ymm13, %ymm2
vpaddd	0x60(%rbp), %ymm6, %ymm6
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x19, %ymm13, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x7, %ymm13, %ymm2
vpandn	%ymm15, %ymm13, %ymm0
vpand	%ymm14, %ymm13, %ymm4
vpxor	%ymm1, %ymm7, %ymm7
vpsrld	$0x2, %ymm9, %ymm8
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0x1e, %ymm9, %ymm1
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm9, %ymm10, %ymm4
vpxor	%ymm1, %ymm8, %ymm8
vpaddd	%ymm7, %ymm6, %ymm6
vpsrld	$0xd, %ymm9, %ymm1
vpslld	$0x13, %ymm9, %ymm2
vpaddd	%ymm0, %ymm6, %ymm6
vpand	%ymm4, %ymm3, %ymm3
vpxor	%ymm1, %ymm8, %ymm7
vpsrld	$0x16, %ymm9, %ymm1
vpxor	%ymm2, %ymm7, %ymm7
vpslld	$0xa, %ymm9, %ymm2
vpxor	%ymm3, %ymm10, %ymm8
vpaddd	%ymm6, %ymm12, %ymm12
vpxor	%ymm1, %ymm7, %ymm7
vpxor	%ymm2, %ymm7, %ymm7
vpaddd	%ymm6, %ymm8, %ymm8
vpaddd	%ymm7, %ymm8, %ymm8
addq	$0x100, %rbp
decl	%ecx
jne	L_6260
movl	$0x1, %ecx
leaq	0x200(%rsp), %rbx
leaq	K256+128(%rip), %rbp
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
vmovdqa	(%rbx), %ymm7
vpxor	%ymm0, %ymm0, %ymm0
vmovdqa	%ymm7, %ymm6
vpcmpgtd	%ymm0, %ymm6, %ymm6
vpaddd	%ymm6, %ymm7, %ymm7
vmovdqu	-0x80(%rdi), %ymm0
vpand	%ymm6, %ymm8, %ymm8
vmovdqu	-0x60(%rdi), %ymm1
vpand	%ymm6, %ymm9, %ymm9
vmovdqu	-0x40(%rdi), %ymm2
vpand	%ymm6, %ymm10, %ymm10
vmovdqu	-0x20(%rdi), %ymm5
vpand	%ymm6, %ymm11, %ymm11
vpaddd	%ymm0, %ymm8, %ymm8
vmovdqu	(%rdi), %ymm0
vpand	%ymm6, %ymm12, %ymm12
vpaddd	%ymm1, %ymm9, %ymm9
vmovdqu	0x20(%rdi), %ymm1
vpand	%ymm6, %ymm13, %ymm13
vpaddd	%ymm2, %ymm10, %ymm10
vmovdqu	0x40(%rdi), %ymm2
vpand	%ymm6, %ymm14, %ymm14
vpaddd	%ymm5, %ymm11, %ymm11
vmovdqu	0x60(%rdi), %ymm5
vpand	%ymm6, %ymm15, %ymm15
vpaddd	%ymm0, %ymm12, %ymm12
vpaddd	%ymm1, %ymm13, %ymm13
vmovdqu	%ymm8, -0x80(%rdi)
vpaddd	%ymm2, %ymm14, %ymm14
vmovdqu	%ymm9, -0x60(%rdi)
vpaddd	%ymm5, %ymm15, %ymm15
vmovdqu	%ymm10, -0x40(%rdi)
vmovdqu	%ymm11, -0x20(%rdi)
vmovdqu	%ymm12, (%rdi)
vmovdqu	%ymm13, 0x20(%rdi)
vmovdqu	%ymm14, 0x40(%rdi)
vmovdqu	%ymm15, 0x60(%rdi)
vmovdqu	%ymm7, (%rbx)
leaq	0x180(%rsp), %rbx
vmovdqu	K256_shaext-32(%rip), %ymm6
decl	%edx
jne	L_52a0
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
K256:
	.byte 152,47,138,66,152,47,138,66,152,47,138,66,152,47,138,66
	.byte 152,47,138,66,152,47,138,66,152,47,138,66,152,47,138,66
	.byte 145,68,55,113,145,68,55,113,145,68,55,113,145,68,55,113
	.byte 145,68,55,113,145,68,55,113,145,68,55,113,145,68,55,113
	.byte 207,251,192,181,207,251,192,181,207,251,192,181,207,251,192,181
	.byte 207,251,192,181,207,251,192,181,207,251,192,181,207,251,192,181
	.byte 165,219,181,233,165,219,181,233,165,219,181,233,165,219,181,233
	.byte 165,219,181,233,165,219,181,233,165,219,181,233,165,219,181,233
	.byte 91,194,86,57,91,194,86,57,91,194,86,57,91,194,86,57
	.byte 91,194,86,57,91,194,86,57,91,194,86,57,91,194,86,57
	.byte 241,17,241,89,241,17,241,89,241,17,241,89,241,17,241,89
	.byte 241,17,241,89,241,17,241,89,241,17,241,89,241,17,241,89
	.byte 164,130,63,146,164,130,63,146,164,130,63,146,164,130,63,146
	.byte 164,130,63,146,164,130,63,146,164,130,63,146,164,130,63,146
	.byte 213,94,28,171,213,94,28,171,213,94,28,171,213,94,28,171
	.byte 213,94,28,171,213,94,28,171,213,94,28,171,213,94,28,171
	.byte 152,170,7,216,152,170,7,216,152,170,7,216,152,170,7,216
	.byte 152,170,7,216,152,170,7,216,152,170,7,216,152,170,7,216
	.byte 1,91,131,18,1,91,131,18,1,91,131,18,1,91,131,18
	.byte 1,91,131,18,1,91,131,18,1,91,131,18,1,91,131,18
	.byte 190,133,49,36,190,133,49,36,190,133,49,36,190,133,49,36
	.byte 190,133,49,36,190,133,49,36,190,133,49,36,190,133,49,36
	.byte 195,125,12,85,195,125,12,85,195,125,12,85,195,125,12,85
	.byte 195,125,12,85,195,125,12,85,195,125,12,85,195,125,12,85
	.byte 116,93,190,114,116,93,190,114,116,93,190,114,116,93,190,114
	.byte 116,93,190,114,116,93,190,114,116,93,190,114,116,93,190,114
	.byte 254,177,222,128,254,177,222,128,254,177,222,128,254,177,222,128
	.byte 254,177,222,128,254,177,222,128,254,177,222,128,254,177,222,128
	.byte 167,6,220,155,167,6,220,155,167,6,220,155,167,6,220,155
	.byte 167,6,220,155,167,6,220,155,167,6,220,155,167,6,220,155
	.byte 116,241,155,193,116,241,155,193,116,241,155,193,116,241,155,193
	.byte 116,241,155,193,116,241,155,193,116,241,155,193,116,241,155,193
	.byte 193,105,155,228,193,105,155,228,193,105,155,228,193,105,155,228
	.byte 193,105,155,228,193,105,155,228,193,105,155,228,193,105,155,228
	.byte 134,71,190,239,134,71,190,239,134,71,190,239,134,71,190,239
	.byte 134,71,190,239,134,71,190,239,134,71,190,239,134,71,190,239
	.byte 198,157,193,15,198,157,193,15,198,157,193,15,198,157,193,15
	.byte 198,157,193,15,198,157,193,15,198,157,193,15,198,157,193,15
	.byte 204,161,12,36,204,161,12,36,204,161,12,36,204,161,12,36
	.byte 204,161,12,36,204,161,12,36,204,161,12,36,204,161,12,36
	.byte 111,44,233,45,111,44,233,45,111,44,233,45,111,44,233,45
	.byte 111,44,233,45,111,44,233,45,111,44,233,45,111,44,233,45
	.byte 170,132,116,74,170,132,116,74,170,132,116,74,170,132,116,74
	.byte 170,132,116,74,170,132,116,74,170,132,116,74,170,132,116,74
	.byte 220,169,176,92,220,169,176,92,220,169,176,92,220,169,176,92
	.byte 220,169,176,92,220,169,176,92,220,169,176,92,220,169,176,92
	.byte 218,136,249,118,218,136,249,118,218,136,249,118,218,136,249,118
	.byte 218,136,249,118,218,136,249,118,218,136,249,118,218,136,249,118
	.byte 82,81,62,152,82,81,62,152,82,81,62,152,82,81,62,152
	.byte 82,81,62,152,82,81,62,152,82,81,62,152,82,81,62,152
	.byte 109,198,49,168,109,198,49,168,109,198,49,168,109,198,49,168
	.byte 109,198,49,168,109,198,49,168,109,198,49,168,109,198,49,168
	.byte 200,39,3,176,200,39,3,176,200,39,3,176,200,39,3,176
	.byte 200,39,3,176,200,39,3,176,200,39,3,176,200,39,3,176
	.byte 199,127,89,191,199,127,89,191,199,127,89,191,199,127,89,191
	.byte 199,127,89,191,199,127,89,191,199,127,89,191,199,127,89,191
	.byte 243,11,224,198,243,11,224,198,243,11,224,198,243,11,224,198
	.byte 243,11,224,198,243,11,224,198,243,11,224,198,243,11,224,198
	.byte 71,145,167,213,71,145,167,213,71,145,167,213,71,145,167,213
	.byte 71,145,167,213,71,145,167,213,71,145,167,213,71,145,167,213
	.byte 81,99,202,6,81,99,202,6,81,99,202,6,81,99,202,6
	.byte 81,99,202,6,81,99,202,6,81,99,202,6,81,99,202,6
	.byte 103,41,41,20,103,41,41,20,103,41,41,20,103,41,41,20
	.byte 103,41,41,20,103,41,41,20,103,41,41,20,103,41,41,20
	.byte 133,10,183,39,133,10,183,39,133,10,183,39,133,10,183,39
	.byte 133,10,183,39,133,10,183,39,133,10,183,39,133,10,183,39
	.byte 56,33,27,46,56,33,27,46,56,33,27,46,56,33,27,46
	.byte 56,33,27,46,56,33,27,46,56,33,27,46,56,33,27,46
	.byte 252,109,44,77,252,109,44,77,252,109,44,77,252,109,44,77
	.byte 252,109,44,77,252,109,44,77,252,109,44,77,252,109,44,77
	.byte 19,13,56,83,19,13,56,83,19,13,56,83,19,13,56,83
	.byte 19,13,56,83,19,13,56,83,19,13,56,83,19,13,56,83
	.byte 84,115,10,101,84,115,10,101,84,115,10,101,84,115,10,101
	.byte 84,115,10,101,84,115,10,101,84,115,10,101,84,115,10,101
	.byte 187,10,106,118,187,10,106,118,187,10,106,118,187,10,106,118
	.byte 187,10,106,118,187,10,106,118,187,10,106,118,187,10,106,118
	.byte 46,201,194,129,46,201,194,129,46,201,194,129,46,201,194,129
	.byte 46,201,194,129,46,201,194,129,46,201,194,129,46,201,194,129
	.byte 133,44,114,146,133,44,114,146,133,44,114,146,133,44,114,146
	.byte 133,44,114,146,133,44,114,146,133,44,114,146,133,44,114,146
	.byte 161,232,191,162,161,232,191,162,161,232,191,162,161,232,191,162
	.byte 161,232,191,162,161,232,191,162,161,232,191,162,161,232,191,162
	.byte 75,102,26,168,75,102,26,168,75,102,26,168,75,102,26,168
	.byte 75,102,26,168,75,102,26,168,75,102,26,168,75,102,26,168
	.byte 112,139,75,194,112,139,75,194,112,139,75,194,112,139,75,194
	.byte 112,139,75,194,112,139,75,194,112,139,75,194,112,139,75,194
	.byte 163,81,108,199,163,81,108,199,163,81,108,199,163,81,108,199
	.byte 163,81,108,199,163,81,108,199,163,81,108,199,163,81,108,199
	.byte 25,232,146,209,25,232,146,209,25,232,146,209,25,232,146,209
	.byte 25,232,146,209,25,232,146,209,25,232,146,209,25,232,146,209
	.byte 36,6,153,214,36,6,153,214,36,6,153,214,36,6,153,214
	.byte 36,6,153,214,36,6,153,214,36,6,153,214,36,6,153,214
	.byte 133,53,14,244,133,53,14,244,133,53,14,244,133,53,14,244
	.byte 133,53,14,244,133,53,14,244,133,53,14,244,133,53,14,244
	.byte 112,160,106,16,112,160,106,16,112,160,106,16,112,160,106,16
	.byte 112,160,106,16,112,160,106,16,112,160,106,16,112,160,106,16
	.byte 22,193,164,25,22,193,164,25,22,193,164,25,22,193,164,25
	.byte 22,193,164,25,22,193,164,25,22,193,164,25,22,193,164,25
	.byte 8,108,55,30,8,108,55,30,8,108,55,30,8,108,55,30
	.byte 8,108,55,30,8,108,55,30,8,108,55,30,8,108,55,30
	.byte 76,119,72,39,76,119,72,39,76,119,72,39,76,119,72,39
	.byte 76,119,72,39,76,119,72,39,76,119,72,39,76,119,72,39
	.byte 181,188,176,52,181,188,176,52,181,188,176,52,181,188,176,52
	.byte 181,188,176,52,181,188,176,52,181,188,176,52,181,188,176,52
	.byte 179,12,28,57,179,12,28,57,179,12,28,57,179,12,28,57
	.byte 179,12,28,57,179,12,28,57,179,12,28,57,179,12,28,57
	.byte 74,170,216,78,74,170,216,78,74,170,216,78,74,170,216,78
	.byte 74,170,216,78,74,170,216,78,74,170,216,78,74,170,216,78
	.byte 79,202,156,91,79,202,156,91,79,202,156,91,79,202,156,91
	.byte 79,202,156,91,79,202,156,91,79,202,156,91,79,202,156,91
	.byte 243,111,46,104,243,111,46,104,243,111,46,104,243,111,46,104
	.byte 243,111,46,104,243,111,46,104,243,111,46,104,243,111,46,104
	.byte 238,130,143,116,238,130,143,116,238,130,143,116,238,130,143,116
	.byte 238,130,143,116,238,130,143,116,238,130,143,116,238,130,143,116
	.byte 111,99,165,120,111,99,165,120,111,99,165,120,111,99,165,120
	.byte 111,99,165,120,111,99,165,120,111,99,165,120,111,99,165,120
	.byte 20,120,200,132,20,120,200,132,20,120,200,132,20,120,200,132
	.byte 20,120,200,132,20,120,200,132,20,120,200,132,20,120,200,132
	.byte 8,2,199,140,8,2,199,140,8,2,199,140,8,2,199,140
	.byte 8,2,199,140,8,2,199,140,8,2,199,140,8,2,199,140
	.byte 250,255,190,144,250,255,190,144,250,255,190,144,250,255,190,144
	.byte 250,255,190,144,250,255,190,144,250,255,190,144,250,255,190,144
	.byte 235,108,80,164,235,108,80,164,235,108,80,164,235,108,80,164
	.byte 235,108,80,164,235,108,80,164,235,108,80,164,235,108,80,164
	.byte 247,163,249,190,247,163,249,190,247,163,249,190,247,163,249,190
	.byte 247,163,249,190,247,163,249,190,247,163,249,190,247,163,249,190
	.byte 242,120,113,198,242,120,113,198,242,120,113,198,242,120,113,198
	.byte 242,120,113,198,242,120,113,198,242,120,113,198,242,120,113,198
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
K256_shaext:
	.byte 152,47,138,66,145,68,55,113,207,251,192,181,165,219,181,233
	.byte 91,194,86,57,241,17,241,89,164,130,63,146,213,94,28,171
	.byte 152,170,7,216,1,91,131,18,190,133,49,36,195,125,12,85
	.byte 116,93,190,114,254,177,222,128,167,6,220,155,116,241,155,193
	.byte 193,105,155,228,134,71,190,239,198,157,193,15,204,161,12,36
	.byte 111,44,233,45,170,132,116,74,220,169,176,92,218,136,249,118
	.byte 82,81,62,152,109,198,49,168,200,39,3,176,199,127,89,191
	.byte 243,11,224,198,71,145,167,213,81,99,202,6,103,41,41,20
	.byte 133,10,183,39,56,33,27,46,252,109,44,77,19,13,56,83
	.byte 84,115,10,101,187,10,106,118,46,201,194,129,133,44,114,146
	.byte 161,232,191,162,75,102,26,168,112,139,75,194,163,81,108,199
	.byte 25,232,146,209,36,6,153,214,133,53,14,244,112,160,106,16
	.byte 22,193,164,25,8,108,55,30,76,119,72,39,181,188,176,52
	.byte 179,12,28,57,74,170,216,78,79,202,156,91,243,111,46,104
	.byte 238,130,143,116,111,99,165,120,20,120,200,132,8,2,199,140
	.byte 250,255,190,144,235,108,80,164,247,163,249,190,242,120,113,198
	.byte 83,72,65,50,53,54,32,109,117,108,116,105,45,98,108,111
	.byte 99,107,32,116,114,97,110,115,102,111,114,109,32,102,111,114
	.byte 32,120,56,54,95,54,52,44,32,67,82,89,80,84,79,71
	.byte 65,77,83,32,98,121,32,60,104,116,116,112,115,58,47,47
	.byte 103,105,116,104,117,98,46,99,111,109,47,100,111,116,45,97
	.byte 115,109,62,0

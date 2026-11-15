	.text
aesni_cbc_sha1_enc:
movl	OPENSSL_ia32cap_P(%rip), %r10d
movq	OPENSSL_ia32cap_P+4(%rip), %r11
btq	$0x3d, %r11
jb	aesni_cbc_sha1_enc_shaext
andl	$0x10000000, %r11d
andl	$0x40000000, %r10d
orl	%r11d, %r10d
cmpl	$0x50000000, %r10d
je	aesni_cbc_sha1_enc_avx
jmp	aesni_cbc_sha1_enc_ssse3
rep	retq
nopl	(%rax,%rax)
aesni_cbc_sha1_enc_ssse3:
movq	0x8(%rsp), %r10
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x68(%rsp), %rsp
movq	%rdi, %r12
movq	%rsi, %r13
movq	%rdx, %r14
leaq	0x70(%rcx), %r15
movdqu	(%r8), %xmm2
movq	%r8, 0x58(%rsp)
shlq	$0x6, %r14
subq	%r12, %r13
movl	0x80(%r15), %r8d
addq	%r10, %r14
leaq	K_XX_XX(%rip), %r11
movl	(%r9), %eax
movl	0x4(%r9), %ebx
movl	0x8(%r9), %ecx
movl	0xc(%r9), %edx
movl	%ebx, %esi
movl	0x10(%r9), %ebp
movl	%ecx, %edi
xorl	%edx, %edi
andl	%edi, %esi
movdqa	0x40(%r11), %xmm3
movdqa	(%r11), %xmm13
movdqu	(%r10), %xmm4
movdqu	0x10(%r10), %xmm5
movdqu	0x20(%r10), %xmm6
movdqu	0x30(%r10), %xmm7
pshufb	%xmm3, %xmm4
pshufb	%xmm3, %xmm5
pshufb	%xmm3, %xmm6
addq	$0x40, %r10
paddd	%xmm13, %xmm4
pshufb	%xmm3, %xmm7
paddd	%xmm13, %xmm5
paddd	%xmm13, %xmm6
movdqa	%xmm4, (%rsp)
psubd	%xmm13, %xmm4
movdqa	%xmm5, 0x10(%rsp)
psubd	%xmm13, %xmm5
movdqa	%xmm6, 0x20(%rsp)
psubd	%xmm13, %xmm6
movups	-0x70(%r15), %xmm15
movups	-0x60(%r15), %xmm0
jmp	L_120
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_120:
rorl	$0x2, %ebx
movups	(%r12), %xmm14
xorps	%xmm15, %xmm14
xorps	%xmm14, %xmm2
movups	-0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
pshufd	$0xee, %xmm4, %xmm8
xorl	%edx, %esi
movdqa	%xmm7, %xmm12
paddd	%xmm7, %xmm13
movl	%eax, %edi
addl	(%rsp), %ebp
punpcklqdq	%xmm5, %xmm8
xorl	%ecx, %ebx
roll	$0x5, %eax
addl	%esi, %ebp
psrldq	$0x4, %xmm12
andl	%ebx, %edi
xorl	%ecx, %ebx
pxor	%xmm4, %xmm8
addl	%eax, %ebp
rorl	$0x7, %eax
pxor	%xmm6, %xmm12
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x4(%rsp), %edx
pxor	%xmm12, %xmm8
xorl	%ebx, %eax
roll	$0x5, %ebp
movdqa	%xmm13, 0x30(%rsp)
addl	%edi, %edx
movups	-0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
andl	%eax, %esi
movdqa	%xmm8, %xmm3
xorl	%ebx, %eax
addl	%ebp, %edx
rorl	$0x7, %ebp
movdqa	%xmm8, %xmm12
xorl	%ebx, %esi
pslldq	$0xc, %xmm3
paddd	%xmm8, %xmm8
movl	%edx, %edi
addl	0x8(%rsp), %ecx
psrld	$0x1f, %xmm12
xorl	%eax, %ebp
roll	$0x5, %edx
addl	%esi, %ecx
movdqa	%xmm3, %xmm13
andl	%ebp, %edi
xorl	%eax, %ebp
psrld	$0x1e, %xmm3
addl	%edx, %ecx
rorl	$0x7, %edx
por	%xmm12, %xmm8
xorl	%eax, %edi
movl	%ecx, %esi
addl	0xc(%rsp), %ebx
movups	-0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
pslld	$0x2, %xmm13
pxor	%xmm3, %xmm8
xorl	%ebp, %edx
movdqa	(%r11), %xmm3
roll	$0x5, %ecx
addl	%edi, %ebx
andl	%edx, %esi
pxor	%xmm13, %xmm8
xorl	%ebp, %edx
addl	%ecx, %ebx
rorl	$0x7, %ecx
pshufd	$0xee, %xmm5, %xmm9
xorl	%ebp, %esi
movdqa	%xmm8, %xmm13
paddd	%xmm8, %xmm3
movl	%ebx, %edi
addl	0x10(%rsp), %eax
punpcklqdq	%xmm6, %xmm9
xorl	%edx, %ecx
roll	$0x5, %ebx
addl	%esi, %eax
psrldq	$0x4, %xmm13
andl	%ecx, %edi
xorl	%edx, %ecx
pxor	%xmm5, %xmm9
addl	%ebx, %eax
rorl	$0x7, %ebx
movups	-0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
pxor	%xmm7, %xmm13
xorl	%edx, %edi
movl	%eax, %esi
addl	0x14(%rsp), %ebp
pxor	%xmm13, %xmm9
xorl	%ecx, %ebx
roll	$0x5, %eax
movdqa	%xmm3, (%rsp)
addl	%edi, %ebp
andl	%ebx, %esi
movdqa	%xmm9, %xmm12
xorl	%ecx, %ebx
addl	%eax, %ebp
rorl	$0x7, %eax
movdqa	%xmm9, %xmm13
xorl	%ecx, %esi
pslldq	$0xc, %xmm12
paddd	%xmm9, %xmm9
movl	%ebp, %edi
addl	0x18(%rsp), %edx
psrld	$0x1f, %xmm13
xorl	%ebx, %eax
roll	$0x5, %ebp
addl	%esi, %edx
movups	-0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
movdqa	%xmm12, %xmm3
andl	%eax, %edi
xorl	%ebx, %eax
psrld	$0x1e, %xmm12
addl	%ebp, %edx
rorl	$0x7, %ebp
por	%xmm13, %xmm9
xorl	%ebx, %edi
movl	%edx, %esi
addl	0x1c(%rsp), %ecx
pslld	$0x2, %xmm3
pxor	%xmm12, %xmm9
xorl	%eax, %ebp
movdqa	0x10(%r11), %xmm12
roll	$0x5, %edx
addl	%edi, %ecx
andl	%ebp, %esi
pxor	%xmm3, %xmm9
xorl	%eax, %ebp
addl	%edx, %ecx
rorl	$0x7, %edx
pshufd	$0xee, %xmm6, %xmm10
xorl	%eax, %esi
movdqa	%xmm9, %xmm3
paddd	%xmm9, %xmm12
movl	%ecx, %edi
addl	0x20(%rsp), %ebx
movups	(%r15), %xmm0
aesenc	%xmm1, %xmm2
punpcklqdq	%xmm7, %xmm10
xorl	%ebp, %edx
roll	$0x5, %ecx
addl	%esi, %ebx
psrldq	$0x4, %xmm3
andl	%edx, %edi
xorl	%ebp, %edx
pxor	%xmm6, %xmm10
addl	%ecx, %ebx
rorl	$0x7, %ecx
pxor	%xmm8, %xmm3
xorl	%ebp, %edi
movl	%ebx, %esi
addl	0x24(%rsp), %eax
pxor	%xmm3, %xmm10
xorl	%edx, %ecx
roll	$0x5, %ebx
movdqa	%xmm12, 0x10(%rsp)
addl	%edi, %eax
andl	%ecx, %esi
movdqa	%xmm10, %xmm13
xorl	%edx, %ecx
addl	%ebx, %eax
rorl	$0x7, %ebx
movups	0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
movdqa	%xmm10, %xmm3
xorl	%edx, %esi
pslldq	$0xc, %xmm13
paddd	%xmm10, %xmm10
movl	%eax, %edi
addl	0x28(%rsp), %ebp
psrld	$0x1f, %xmm3
xorl	%ecx, %ebx
roll	$0x5, %eax
addl	%esi, %ebp
movdqa	%xmm13, %xmm12
andl	%ebx, %edi
xorl	%ecx, %ebx
psrld	$0x1e, %xmm13
addl	%eax, %ebp
rorl	$0x7, %eax
por	%xmm3, %xmm10
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x2c(%rsp), %edx
pslld	$0x2, %xmm12
pxor	%xmm13, %xmm10
xorl	%ebx, %eax
movdqa	0x10(%r11), %xmm13
roll	$0x5, %ebp
addl	%edi, %edx
movups	0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
andl	%eax, %esi
pxor	%xmm12, %xmm10
xorl	%ebx, %eax
addl	%ebp, %edx
rorl	$0x7, %ebp
pshufd	$0xee, %xmm7, %xmm11
xorl	%ebx, %esi
movdqa	%xmm10, %xmm12
paddd	%xmm10, %xmm13
movl	%edx, %edi
addl	0x30(%rsp), %ecx
punpcklqdq	%xmm8, %xmm11
xorl	%eax, %ebp
roll	$0x5, %edx
addl	%esi, %ecx
psrldq	$0x4, %xmm12
andl	%ebp, %edi
xorl	%eax, %ebp
pxor	%xmm7, %xmm11
addl	%edx, %ecx
rorl	$0x7, %edx
pxor	%xmm9, %xmm12
xorl	%eax, %edi
movl	%ecx, %esi
addl	0x34(%rsp), %ebx
movups	0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
pxor	%xmm12, %xmm11
xorl	%ebp, %edx
roll	$0x5, %ecx
movdqa	%xmm13, 0x20(%rsp)
addl	%edi, %ebx
andl	%edx, %esi
movdqa	%xmm11, %xmm3
xorl	%ebp, %edx
addl	%ecx, %ebx
rorl	$0x7, %ecx
movdqa	%xmm11, %xmm12
xorl	%ebp, %esi
pslldq	$0xc, %xmm3
paddd	%xmm11, %xmm11
movl	%ebx, %edi
addl	0x38(%rsp), %eax
psrld	$0x1f, %xmm12
xorl	%edx, %ecx
roll	$0x5, %ebx
addl	%esi, %eax
movdqa	%xmm3, %xmm13
andl	%ecx, %edi
xorl	%edx, %ecx
psrld	$0x1e, %xmm3
addl	%ebx, %eax
rorl	$0x7, %ebx
cmpl	$0xb, %r8d
jb	L_4c3
movups	0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
je	L_4c3
movups	0x60(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%r15), %xmm1
aesenc	%xmm0, %xmm2
L_4c3:
aesenclast	%xmm1, %xmm2
movups	-0x60(%r15), %xmm0
por	%xmm12, %xmm11
xorl	%edx, %edi
movl	%eax, %esi
addl	0x3c(%rsp), %ebp
pslld	$0x2, %xmm13
pxor	%xmm3, %xmm11
xorl	%ecx, %ebx
movdqa	0x10(%r11), %xmm3
roll	$0x5, %eax
addl	%edi, %ebp
andl	%ebx, %esi
pxor	%xmm13, %xmm11
pshufd	$0xee, %xmm10, %xmm13
xorl	%ecx, %ebx
addl	%eax, %ebp
rorl	$0x7, %eax
pxor	%xmm8, %xmm4
xorl	%ecx, %esi
movl	%ebp, %edi
addl	(%rsp), %edx
punpcklqdq	%xmm11, %xmm13
xorl	%ebx, %eax
roll	$0x5, %ebp
pxor	%xmm5, %xmm4
addl	%esi, %edx
movups	0x10(%r12), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm2, (%r12,%r13)
xorps	%xmm14, %xmm2
movups	-0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
andl	%eax, %edi
movdqa	%xmm3, %xmm12
xorl	%ebx, %eax
paddd	%xmm11, %xmm3
addl	%ebp, %edx
pxor	%xmm13, %xmm4
rorl	$0x7, %ebp
xorl	%ebx, %edi
movl	%edx, %esi
addl	0x4(%rsp), %ecx
movdqa	%xmm4, %xmm13
xorl	%eax, %ebp
roll	$0x5, %edx
movdqa	%xmm3, 0x30(%rsp)
addl	%edi, %ecx
andl	%ebp, %esi
xorl	%eax, %ebp
pslld	$0x2, %xmm4
addl	%edx, %ecx
rorl	$0x7, %edx
psrld	$0x1e, %xmm13
xorl	%eax, %esi
movl	%ecx, %edi
addl	0x8(%rsp), %ebx
movups	-0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
por	%xmm13, %xmm4
xorl	%ebp, %edx
roll	$0x5, %ecx
pshufd	$0xee, %xmm11, %xmm3
addl	%esi, %ebx
andl	%edx, %edi
xorl	%ebp, %edx
addl	%ecx, %ebx
addl	0xc(%rsp), %eax
xorl	%ebp, %edi
movl	%ebx, %esi
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%edx, %esi
rorl	$0x7, %ecx
addl	%ebx, %eax
pxor	%xmm9, %xmm5
addl	0x10(%rsp), %ebp
movups	-0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %esi
punpcklqdq	%xmm4, %xmm3
movl	%eax, %edi
roll	$0x5, %eax
pxor	%xmm6, %xmm5
addl	%esi, %ebp
xorl	%ecx, %edi
movdqa	%xmm12, %xmm13
rorl	$0x7, %ebx
paddd	%xmm4, %xmm12
addl	%eax, %ebp
pxor	%xmm3, %xmm5
addl	0x14(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
movdqa	%xmm5, %xmm3
addl	%edi, %edx
xorl	%ebx, %esi
movdqa	%xmm12, (%rsp)
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x18(%rsp), %ecx
pslld	$0x2, %xmm5
xorl	%eax, %esi
movl	%edx, %edi
psrld	$0x1e, %xmm3
roll	$0x5, %edx
addl	%esi, %ecx
movups	-0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %edi
rorl	$0x7, %ebp
por	%xmm3, %xmm5
addl	%edx, %ecx
addl	0x1c(%rsp), %ebx
pshufd	$0xee, %xmm4, %xmm12
xorl	%ebp, %edi
movl	%ecx, %esi
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
rorl	$0x7, %edx
addl	%ecx, %ebx
pxor	%xmm10, %xmm6
addl	0x20(%rsp), %eax
xorl	%edx, %esi
punpcklqdq	%xmm5, %xmm12
movl	%ebx, %edi
roll	$0x5, %ebx
pxor	%xmm7, %xmm6
addl	%esi, %eax
xorl	%edx, %edi
movdqa	0x20(%r11), %xmm3
rorl	$0x7, %ecx
paddd	%xmm5, %xmm13
addl	%ebx, %eax
pxor	%xmm12, %xmm6
addl	0x24(%rsp), %ebp
movups	-0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
movdqa	%xmm6, %xmm12
addl	%edi, %ebp
xorl	%ecx, %esi
movdqa	%xmm13, 0x10(%rsp)
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x28(%rsp), %edx
pslld	$0x2, %xmm6
xorl	%ebx, %esi
movl	%ebp, %edi
psrld	$0x1e, %xmm12
roll	$0x5, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
rorl	$0x7, %eax
por	%xmm12, %xmm6
addl	%ebp, %edx
addl	0x2c(%rsp), %ecx
pshufd	$0xee, %xmm5, %xmm13
xorl	%eax, %edi
movl	%edx, %esi
roll	$0x5, %edx
addl	%edi, %ecx
movups	(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %esi
rorl	$0x7, %ebp
addl	%edx, %ecx
pxor	%xmm11, %xmm7
addl	0x30(%rsp), %ebx
xorl	%ebp, %esi
punpcklqdq	%xmm6, %xmm13
movl	%ecx, %edi
roll	$0x5, %ecx
pxor	%xmm8, %xmm7
addl	%esi, %ebx
xorl	%ebp, %edi
movdqa	%xmm3, %xmm12
rorl	$0x7, %edx
paddd	%xmm6, %xmm3
addl	%ecx, %ebx
pxor	%xmm13, %xmm7
addl	0x34(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
roll	$0x5, %ebx
movdqa	%xmm7, %xmm13
addl	%edi, %eax
xorl	%edx, %esi
movdqa	%xmm3, 0x20(%rsp)
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x38(%rsp), %ebp
movups	0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
pslld	$0x2, %xmm7
xorl	%ecx, %esi
movl	%eax, %edi
psrld	$0x1e, %xmm13
roll	$0x5, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
rorl	$0x7, %ebx
por	%xmm13, %xmm7
addl	%eax, %ebp
addl	0x3c(%rsp), %edx
pshufd	$0xee, %xmm6, %xmm3
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
rorl	$0x7, %eax
addl	%ebp, %edx
pxor	%xmm4, %xmm8
addl	(%rsp), %ecx
xorl	%eax, %esi
punpcklqdq	%xmm7, %xmm3
movl	%edx, %edi
roll	$0x5, %edx
pxor	%xmm9, %xmm8
addl	%esi, %ecx
movups	0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %edi
movdqa	%xmm12, %xmm13
rorl	$0x7, %ebp
paddd	%xmm7, %xmm12
addl	%edx, %ecx
pxor	%xmm3, %xmm8
addl	0x4(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
roll	$0x5, %ecx
movdqa	%xmm8, %xmm3
addl	%edi, %ebx
xorl	%ebp, %esi
movdqa	%xmm12, 0x30(%rsp)
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	0x8(%rsp), %eax
pslld	$0x2, %xmm8
xorl	%edx, %esi
movl	%ebx, %edi
psrld	$0x1e, %xmm3
roll	$0x5, %ebx
addl	%esi, %eax
xorl	%edx, %edi
rorl	$0x7, %ecx
por	%xmm3, %xmm8
addl	%ebx, %eax
addl	0xc(%rsp), %ebp
movups	0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
pshufd	$0xee, %xmm7, %xmm12
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
rorl	$0x7, %ebx
addl	%eax, %ebp
pxor	%xmm5, %xmm9
addl	0x10(%rsp), %edx
xorl	%ebx, %esi
punpcklqdq	%xmm8, %xmm12
movl	%ebp, %edi
roll	$0x5, %ebp
pxor	%xmm10, %xmm9
addl	%esi, %edx
xorl	%ebx, %edi
movdqa	%xmm13, %xmm3
rorl	$0x7, %eax
paddd	%xmm8, %xmm13
addl	%ebp, %edx
pxor	%xmm12, %xmm9
addl	0x14(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
roll	$0x5, %edx
movdqa	%xmm9, %xmm12
addl	%edi, %ecx
cmpl	$0xb, %r8d
jb	L_8b0
movups	0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
je	L_8b0
movups	0x60(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%r15), %xmm1
aesenc	%xmm0, %xmm2
L_8b0:
aesenclast	%xmm1, %xmm2
movups	-0x60(%r15), %xmm0
xorl	%eax, %esi
movdqa	%xmm13, (%rsp)
rorl	$0x7, %ebp
addl	%edx, %ecx
addl	0x18(%rsp), %ebx
pslld	$0x2, %xmm9
xorl	%ebp, %esi
movl	%ecx, %edi
psrld	$0x1e, %xmm12
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
por	%xmm12, %xmm9
addl	%ecx, %ebx
addl	0x1c(%rsp), %eax
pshufd	$0xee, %xmm8, %xmm13
rorl	$0x7, %ecx
movl	%ebx, %esi
xorl	%edx, %edi
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%ecx, %esi
xorl	%edx, %ecx
addl	%ebx, %eax
pxor	%xmm6, %xmm10
addl	0x20(%rsp), %ebp
movups	0x20(%r12), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm2, 0x10(%r13,%r12)
xorps	%xmm14, %xmm2
movups	-0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
andl	%ecx, %esi
xorl	%edx, %ecx
rorl	$0x7, %ebx
punpcklqdq	%xmm9, %xmm13
movl	%eax, %edi
xorl	%ecx, %esi
pxor	%xmm11, %xmm10
roll	$0x5, %eax
addl	%esi, %ebp
movdqa	%xmm3, %xmm12
xorl	%ebx, %edi
paddd	%xmm9, %xmm3
xorl	%ecx, %ebx
pxor	%xmm13, %xmm10
addl	%eax, %ebp
addl	0x24(%rsp), %edx
andl	%ebx, %edi
xorl	%ecx, %ebx
rorl	$0x7, %eax
movdqa	%xmm10, %xmm13
movl	%ebp, %esi
xorl	%ebx, %edi
movdqa	%xmm3, 0x10(%rsp)
roll	$0x5, %ebp
addl	%edi, %edx
movups	-0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %esi
pslld	$0x2, %xmm10
xorl	%ebx, %eax
addl	%ebp, %edx
psrld	$0x1e, %xmm13
addl	0x28(%rsp), %ecx
andl	%eax, %esi
xorl	%ebx, %eax
por	%xmm13, %xmm10
rorl	$0x7, %ebp
movl	%edx, %edi
xorl	%eax, %esi
roll	$0x5, %edx
pshufd	$0xee, %xmm9, %xmm3
addl	%esi, %ecx
xorl	%ebp, %edi
xorl	%eax, %ebp
addl	%edx, %ecx
addl	0x2c(%rsp), %ebx
andl	%ebp, %edi
xorl	%eax, %ebp
rorl	$0x7, %edx
movups	-0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
movl	%ecx, %esi
xorl	%ebp, %edi
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%edx, %esi
xorl	%ebp, %edx
addl	%ecx, %ebx
pxor	%xmm7, %xmm11
addl	0x30(%rsp), %eax
andl	%edx, %esi
xorl	%ebp, %edx
rorl	$0x7, %ecx
punpcklqdq	%xmm10, %xmm3
movl	%ebx, %edi
xorl	%edx, %esi
pxor	%xmm4, %xmm11
roll	$0x5, %ebx
addl	%esi, %eax
movdqa	0x30(%r11), %xmm13
xorl	%ecx, %edi
paddd	%xmm10, %xmm12
xorl	%edx, %ecx
pxor	%xmm3, %xmm11
addl	%ebx, %eax
addl	0x34(%rsp), %ebp
movups	-0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
andl	%ecx, %edi
xorl	%edx, %ecx
rorl	$0x7, %ebx
movdqa	%xmm11, %xmm3
movl	%eax, %esi
xorl	%ecx, %edi
movdqa	%xmm12, 0x20(%rsp)
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ebx, %esi
pslld	$0x2, %xmm11
xorl	%ecx, %ebx
addl	%eax, %ebp
psrld	$0x1e, %xmm3
addl	0x38(%rsp), %edx
andl	%ebx, %esi
xorl	%ecx, %ebx
por	%xmm3, %xmm11
rorl	$0x7, %eax
movl	%ebp, %edi
xorl	%ebx, %esi
roll	$0x5, %ebp
pshufd	$0xee, %xmm10, %xmm12
addl	%esi, %edx
movups	-0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%eax, %edi
xorl	%ebx, %eax
addl	%ebp, %edx
addl	0x3c(%rsp), %ecx
andl	%eax, %edi
xorl	%ebx, %eax
rorl	$0x7, %ebp
movl	%edx, %esi
xorl	%eax, %edi
roll	$0x5, %edx
addl	%edi, %ecx
xorl	%ebp, %esi
xorl	%eax, %ebp
addl	%edx, %ecx
pxor	%xmm8, %xmm4
addl	(%rsp), %ebx
andl	%ebp, %esi
xorl	%eax, %ebp
rorl	$0x7, %edx
movups	(%r15), %xmm0
aesenc	%xmm1, %xmm2
punpcklqdq	%xmm11, %xmm12
movl	%ecx, %edi
xorl	%ebp, %esi
pxor	%xmm5, %xmm4
roll	$0x5, %ecx
addl	%esi, %ebx
movdqa	%xmm13, %xmm3
xorl	%edx, %edi
paddd	%xmm11, %xmm13
xorl	%ebp, %edx
pxor	%xmm12, %xmm4
addl	%ecx, %ebx
addl	0x4(%rsp), %eax
andl	%edx, %edi
xorl	%ebp, %edx
rorl	$0x7, %ecx
movdqa	%xmm4, %xmm12
movl	%ebx, %esi
xorl	%edx, %edi
movdqa	%xmm13, 0x30(%rsp)
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%ecx, %esi
pslld	$0x2, %xmm4
xorl	%edx, %ecx
addl	%ebx, %eax
psrld	$0x1e, %xmm12
addl	0x8(%rsp), %ebp
movups	0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
andl	%ecx, %esi
xorl	%edx, %ecx
por	%xmm12, %xmm4
rorl	$0x7, %ebx
movl	%eax, %edi
xorl	%ecx, %esi
roll	$0x5, %eax
pshufd	$0xee, %xmm11, %xmm13
addl	%esi, %ebp
xorl	%ebx, %edi
xorl	%ecx, %ebx
addl	%eax, %ebp
addl	0xc(%rsp), %edx
andl	%ebx, %edi
xorl	%ecx, %ebx
rorl	$0x7, %eax
movl	%ebp, %esi
xorl	%ebx, %edi
roll	$0x5, %ebp
addl	%edi, %edx
movups	0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %esi
xorl	%ebx, %eax
addl	%ebp, %edx
pxor	%xmm9, %xmm5
addl	0x10(%rsp), %ecx
andl	%eax, %esi
xorl	%ebx, %eax
rorl	$0x7, %ebp
punpcklqdq	%xmm4, %xmm13
movl	%edx, %edi
xorl	%eax, %esi
pxor	%xmm6, %xmm5
roll	$0x5, %edx
addl	%esi, %ecx
movdqa	%xmm3, %xmm12
xorl	%ebp, %edi
paddd	%xmm4, %xmm3
xorl	%eax, %ebp
pxor	%xmm13, %xmm5
addl	%edx, %ecx
addl	0x14(%rsp), %ebx
andl	%ebp, %edi
xorl	%eax, %ebp
rorl	$0x7, %edx
movups	0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
movdqa	%xmm5, %xmm13
movl	%ecx, %esi
xorl	%ebp, %edi
movdqa	%xmm3, (%rsp)
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%edx, %esi
pslld	$0x2, %xmm5
xorl	%ebp, %edx
addl	%ecx, %ebx
psrld	$0x1e, %xmm13
addl	0x18(%rsp), %eax
andl	%edx, %esi
xorl	%ebp, %edx
por	%xmm13, %xmm5
rorl	$0x7, %ecx
movl	%ebx, %edi
xorl	%edx, %esi
roll	$0x5, %ebx
pshufd	$0xee, %xmm4, %xmm3
addl	%esi, %eax
xorl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
addl	0x1c(%rsp), %ebp
cmpl	$0xb, %r8d
jb	L_c29
movups	0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
je	L_c29
movups	0x60(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%r15), %xmm1
aesenc	%xmm0, %xmm2
L_c29:
aesenclast	%xmm1, %xmm2
movups	-0x60(%r15), %xmm0
andl	%ecx, %edi
xorl	%edx, %ecx
rorl	$0x7, %ebx
movl	%eax, %esi
xorl	%ecx, %edi
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ebx, %esi
xorl	%ecx, %ebx
addl	%eax, %ebp
pxor	%xmm10, %xmm6
addl	0x20(%rsp), %edx
andl	%ebx, %esi
xorl	%ecx, %ebx
rorl	$0x7, %eax
punpcklqdq	%xmm5, %xmm3
movl	%ebp, %edi
xorl	%ebx, %esi
pxor	%xmm7, %xmm6
roll	$0x5, %ebp
addl	%esi, %edx
movups	0x30(%r12), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm2, 0x20(%r13,%r12)
xorps	%xmm14, %xmm2
movups	-0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
movdqa	%xmm12, %xmm13
xorl	%eax, %edi
paddd	%xmm5, %xmm12
xorl	%ebx, %eax
pxor	%xmm3, %xmm6
addl	%ebp, %edx
addl	0x24(%rsp), %ecx
andl	%eax, %edi
xorl	%ebx, %eax
rorl	$0x7, %ebp
movdqa	%xmm6, %xmm3
movl	%edx, %esi
xorl	%eax, %edi
movdqa	%xmm12, 0x10(%rsp)
roll	$0x5, %edx
addl	%edi, %ecx
xorl	%ebp, %esi
pslld	$0x2, %xmm6
xorl	%eax, %ebp
addl	%edx, %ecx
psrld	$0x1e, %xmm3
addl	0x28(%rsp), %ebx
andl	%ebp, %esi
xorl	%eax, %ebp
por	%xmm3, %xmm6
rorl	$0x7, %edx
movups	-0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
movl	%ecx, %edi
xorl	%ebp, %esi
roll	$0x5, %ecx
pshufd	$0xee, %xmm5, %xmm12
addl	%esi, %ebx
xorl	%edx, %edi
xorl	%ebp, %edx
addl	%ecx, %ebx
addl	0x2c(%rsp), %eax
andl	%edx, %edi
xorl	%ebp, %edx
rorl	$0x7, %ecx
movl	%ebx, %esi
xorl	%edx, %edi
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%edx, %esi
addl	%ebx, %eax
pxor	%xmm11, %xmm7
addl	0x30(%rsp), %ebp
movups	-0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %esi
punpcklqdq	%xmm6, %xmm12
movl	%eax, %edi
roll	$0x5, %eax
pxor	%xmm8, %xmm7
addl	%esi, %ebp
xorl	%ecx, %edi
movdqa	%xmm13, %xmm3
rorl	$0x7, %ebx
paddd	%xmm6, %xmm13
addl	%eax, %ebp
pxor	%xmm12, %xmm7
addl	0x34(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
movdqa	%xmm7, %xmm12
addl	%edi, %edx
xorl	%ebx, %esi
movdqa	%xmm13, 0x20(%rsp)
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x38(%rsp), %ecx
pslld	$0x2, %xmm7
xorl	%eax, %esi
movl	%edx, %edi
psrld	$0x1e, %xmm12
roll	$0x5, %edx
addl	%esi, %ecx
movups	-0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %edi
rorl	$0x7, %ebp
por	%xmm12, %xmm7
addl	%edx, %ecx
addl	0x3c(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
roll	$0x5, %ebx
paddd	%xmm7, %xmm3
addl	%esi, %eax
xorl	%edx, %edi
movdqa	%xmm3, 0x30(%rsp)
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x4(%rsp), %ebp
movups	-0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x8(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
roll	$0x5, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0xc(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
roll	$0x5, %edx
addl	%edi, %ecx
movups	(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %esi
rorl	$0x7, %ebp
addl	%edx, %ecx
cmpq	%r14, %r10
je	L_1011
movdqa	0x40(%r11), %xmm3
movdqa	(%r11), %xmm13
movdqu	(%r10), %xmm4
movdqu	0x10(%r10), %xmm5
movdqu	0x20(%r10), %xmm6
movdqu	0x30(%r10), %xmm7
pshufb	%xmm3, %xmm4
addq	$0x40, %r10
addl	0x10(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
pshufb	%xmm3, %xmm5
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
paddd	%xmm13, %xmm4
addl	%ecx, %ebx
addl	0x14(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
movdqa	%xmm4, (%rsp)
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%edx, %esi
rorl	$0x7, %ecx
psubd	%xmm13, %xmm4
addl	%ebx, %eax
addl	0x18(%rsp), %ebp
movups	0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %esi
movl	%eax, %edi
roll	$0x5, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x1c(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x20(%rsp), %ecx
xorl	%eax, %esi
movl	%edx, %edi
pshufb	%xmm3, %xmm6
roll	$0x5, %edx
addl	%esi, %ecx
movups	0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %edi
rorl	$0x7, %ebp
paddd	%xmm13, %xmm5
addl	%edx, %ecx
addl	0x24(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
movdqa	%xmm5, 0x10(%rsp)
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
rorl	$0x7, %edx
psubd	%xmm13, %xmm5
addl	%ecx, %ebx
addl	0x28(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
roll	$0x5, %ebx
addl	%esi, %eax
xorl	%edx, %edi
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x2c(%rsp), %ebp
movups	0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x30(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
pshufb	%xmm3, %xmm7
roll	$0x5, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
rorl	$0x7, %eax
paddd	%xmm13, %xmm6
addl	%ebp, %edx
addl	0x34(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
movdqa	%xmm6, 0x20(%rsp)
roll	$0x5, %edx
addl	%edi, %ecx
cmpl	$0xb, %r8d
jb	L_f97
movups	0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
je	L_f97
movups	0x60(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%r15), %xmm1
aesenc	%xmm0, %xmm2
L_f97:
aesenclast	%xmm1, %xmm2
movups	-0x60(%r15), %xmm0
xorl	%eax, %esi
rorl	$0x7, %ebp
psubd	%xmm13, %xmm6
addl	%edx, %ecx
addl	0x38(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	0x3c(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
roll	$0x5, %ebx
addl	%edi, %eax
rorl	$0x7, %ecx
addl	%ebx, %eax
movups	%xmm2, 0x30(%r13,%r12)
leaq	0x40(%r12), %r12
addl	(%r9), %eax
addl	0x4(%r9), %esi
addl	0x8(%r9), %ecx
addl	0xc(%r9), %edx
movl	%eax, (%r9)
addl	0x10(%r9), %ebp
movl	%esi, 0x4(%r9)
movl	%esi, %ebx
movl	%ecx, 0x8(%r9)
movl	%ecx, %edi
movl	%edx, 0xc(%r9)
xorl	%edx, %edi
movl	%ebp, 0x10(%r9)
andl	%edi, %esi
jmp	L_120
L_1011:
addl	0x10(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	0x14(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%edx, %esi
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x18(%rsp), %ebp
movups	0x10(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %esi
movl	%eax, %edi
roll	$0x5, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x1c(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x20(%rsp), %ecx
xorl	%eax, %esi
movl	%edx, %edi
roll	$0x5, %edx
addl	%esi, %ecx
movups	0x20(%r15), %xmm0
aesenc	%xmm1, %xmm2
xorl	%eax, %edi
rorl	$0x7, %ebp
addl	%edx, %ecx
addl	0x24(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	0x28(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
roll	$0x5, %ebx
addl	%esi, %eax
xorl	%edx, %edi
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x2c(%rsp), %ebp
movups	0x30(%r15), %xmm1
aesenc	%xmm0, %xmm2
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x30(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
roll	$0x5, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x34(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
roll	$0x5, %edx
addl	%edi, %ecx
cmpl	$0xb, %r8d
jb	L_1120
movups	0x40(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%r15), %xmm1
aesenc	%xmm0, %xmm2
je	L_1120
movups	0x60(%r15), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%r15), %xmm1
aesenc	%xmm0, %xmm2
L_1120:
aesenclast	%xmm1, %xmm2
movups	-0x60(%r15), %xmm0
xorl	%eax, %esi
rorl	$0x7, %ebp
addl	%edx, %ecx
addl	0x38(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	0x3c(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
roll	$0x5, %ebx
addl	%edi, %eax
rorl	$0x7, %ecx
addl	%ebx, %eax
movups	%xmm2, 0x30(%r13,%r12)
movq	0x58(%rsp), %r8
addl	(%r9), %eax
addl	0x4(%r9), %esi
addl	0x8(%r9), %ecx
movl	%eax, (%r9)
addl	0xc(%r9), %edx
movl	%esi, 0x4(%r9)
addl	0x10(%r9), %ebp
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
movl	%ebp, 0x10(%r9)
movups	%xmm2, (%r8)
leaq	0x68(%rsp), %rsi
movq	(%rsi), %r15
movq	0x8(%rsi), %r14
movq	0x10(%rsi), %r13
movq	0x18(%rsi), %r12
movq	0x20(%rsi), %rbp
movq	0x28(%rsi), %rbx
leaq	0x30(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
aesni_cbc_sha1_enc_avx:
movq	0x8(%rsp), %r10
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x68(%rsp), %rsp
vzeroall
movq	%rdi, %r12
movq	%rsi, %r13
movq	%rdx, %r14
leaq	0x70(%rcx), %r15
vmovdqu	(%r8), %xmm12
movq	%r8, 0x58(%rsp)
shlq	$0x6, %r14
subq	%r12, %r13
movl	0x80(%r15), %r8d
addq	%r10, %r14
leaq	K_XX_XX(%rip), %r11
movl	(%r9), %eax
movl	0x4(%r9), %ebx
movl	0x8(%r9), %ecx
movl	0xc(%r9), %edx
movl	%ebx, %esi
movl	0x10(%r9), %ebp
movl	%ecx, %edi
xorl	%edx, %edi
andl	%edi, %esi
vmovdqa	0x40(%r11), %xmm6
vmovdqa	(%r11), %xmm10
vmovdqu	(%r10), %xmm0
vmovdqu	0x10(%r10), %xmm1
vmovdqu	0x20(%r10), %xmm2
vmovdqu	0x30(%r10), %xmm3
vpshufb	%xmm6, %xmm0, %xmm0
addq	$0x40, %r10
vpshufb	%xmm6, %xmm1, %xmm1
vpshufb	%xmm6, %xmm2, %xmm2
vpshufb	%xmm6, %xmm3, %xmm3
vpaddd	%xmm0, %xmm10, %xmm4
vpaddd	%xmm1, %xmm10, %xmm5
vpaddd	%xmm2, %xmm10, %xmm6
vmovdqa	%xmm4, (%rsp)
vmovdqa	%xmm5, 0x10(%rsp)
vmovdqa	%xmm6, 0x20(%rsp)
vmovups	-0x70(%r15), %xmm15
vmovups	-0x60(%r15), %xmm14
jmp	L_12a0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_12a0:
shrdl	$0x2, %ebx, %ebx
vmovdqu	(%r12), %xmm13
vpxor	%xmm15, %xmm13, %xmm13
vpxor	%xmm13, %xmm12, %xmm12
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x50(%r15), %xmm15
xorl	%edx, %esi
vpalignr	$0x8, %xmm0, %xmm1, %xmm4
movl	%eax, %edi
addl	(%rsp), %ebp
vpaddd	%xmm3, %xmm10, %xmm9
xorl	%ecx, %ebx
shldl	$0x5, %eax, %eax
vpsrldq	$0x4, %xmm3, %xmm8
addl	%esi, %ebp
andl	%ebx, %edi
vpxor	%xmm0, %xmm4, %xmm4
xorl	%ecx, %ebx
addl	%eax, %ebp
vpxor	%xmm2, %xmm8, %xmm8
shrdl	$0x7, %eax, %eax
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x4(%rsp), %edx
vpxor	%xmm4, %xmm8, %xmm4
xorl	%ebx, %eax
shldl	$0x5, %ebp, %ebp
vmovdqa	%xmm9, 0x30(%rsp)
addl	%edi, %edx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x40(%r15), %xmm14
andl	%eax, %esi
vpsrld	$0x1f, %xmm4, %xmm8
xorl	%ebx, %eax
addl	%ebp, %edx
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %esi
vpslldq	$0xc, %xmm4, %xmm9
vpaddd	%xmm4, %xmm4, %xmm4
movl	%edx, %edi
addl	0x8(%rsp), %ecx
xorl	%eax, %ebp
shldl	$0x5, %edx, %edx
vpor	%xmm4, %xmm8, %xmm4
vpsrld	$0x1e, %xmm9, %xmm8
addl	%esi, %ecx
andl	%ebp, %edi
xorl	%eax, %ebp
addl	%edx, %ecx
vpslld	$0x2, %xmm9, %xmm9
vpxor	%xmm4, %xmm8, %xmm4
shrdl	$0x7, %edx, %edx
xorl	%eax, %edi
movl	%ecx, %esi
addl	0xc(%rsp), %ebx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x30(%r15), %xmm15
vpxor	%xmm4, %xmm9, %xmm4
xorl	%ebp, %edx
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
andl	%edx, %esi
xorl	%ebp, %edx
addl	%ecx, %ebx
shrdl	$0x7, %ecx, %ecx
xorl	%ebp, %esi
vpalignr	$0x8, %xmm1, %xmm2, %xmm5
movl	%ebx, %edi
addl	0x10(%rsp), %eax
vpaddd	%xmm4, %xmm10, %xmm9
xorl	%edx, %ecx
shldl	$0x5, %ebx, %ebx
vpsrldq	$0x4, %xmm4, %xmm8
addl	%esi, %eax
andl	%ecx, %edi
vpxor	%xmm1, %xmm5, %xmm5
xorl	%edx, %ecx
addl	%ebx, %eax
vpxor	%xmm3, %xmm8, %xmm8
shrdl	$0x7, %ebx, %ebx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x20(%r15), %xmm14
xorl	%edx, %edi
movl	%eax, %esi
addl	0x14(%rsp), %ebp
vpxor	%xmm5, %xmm8, %xmm5
xorl	%ecx, %ebx
shldl	$0x5, %eax, %eax
vmovdqa	%xmm9, (%rsp)
addl	%edi, %ebp
andl	%ebx, %esi
vpsrld	$0x1f, %xmm5, %xmm8
xorl	%ecx, %ebx
addl	%eax, %ebp
shrdl	$0x7, %eax, %eax
xorl	%ecx, %esi
vpslldq	$0xc, %xmm5, %xmm9
vpaddd	%xmm5, %xmm5, %xmm5
movl	%ebp, %edi
addl	0x18(%rsp), %edx
xorl	%ebx, %eax
shldl	$0x5, %ebp, %ebp
vpor	%xmm5, %xmm8, %xmm5
vpsrld	$0x1e, %xmm9, %xmm8
addl	%esi, %edx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x10(%r15), %xmm15
andl	%eax, %edi
xorl	%ebx, %eax
addl	%ebp, %edx
vpslld	$0x2, %xmm9, %xmm9
vpxor	%xmm5, %xmm8, %xmm5
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %edi
movl	%edx, %esi
addl	0x1c(%rsp), %ecx
vpxor	%xmm5, %xmm9, %xmm5
xorl	%eax, %ebp
shldl	$0x5, %edx, %edx
vmovdqa	0x10(%r11), %xmm10
addl	%edi, %ecx
andl	%ebp, %esi
xorl	%eax, %ebp
addl	%edx, %ecx
shrdl	$0x7, %edx, %edx
xorl	%eax, %esi
vpalignr	$0x8, %xmm2, %xmm3, %xmm6
movl	%ecx, %edi
addl	0x20(%rsp), %ebx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	(%r15), %xmm14
vpaddd	%xmm5, %xmm10, %xmm9
xorl	%ebp, %edx
shldl	$0x5, %ecx, %ecx
vpsrldq	$0x4, %xmm5, %xmm8
addl	%esi, %ebx
andl	%edx, %edi
vpxor	%xmm2, %xmm6, %xmm6
xorl	%ebp, %edx
addl	%ecx, %ebx
vpxor	%xmm4, %xmm8, %xmm8
shrdl	$0x7, %ecx, %ecx
xorl	%ebp, %edi
movl	%ebx, %esi
addl	0x24(%rsp), %eax
vpxor	%xmm6, %xmm8, %xmm6
xorl	%edx, %ecx
shldl	$0x5, %ebx, %ebx
vmovdqa	%xmm9, 0x10(%rsp)
addl	%edi, %eax
andl	%ecx, %esi
vpsrld	$0x1f, %xmm6, %xmm8
xorl	%edx, %ecx
addl	%ebx, %eax
shrdl	$0x7, %ebx, %ebx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x10(%r15), %xmm15
xorl	%edx, %esi
vpslldq	$0xc, %xmm6, %xmm9
vpaddd	%xmm6, %xmm6, %xmm6
movl	%eax, %edi
addl	0x28(%rsp), %ebp
xorl	%ecx, %ebx
shldl	$0x5, %eax, %eax
vpor	%xmm6, %xmm8, %xmm6
vpsrld	$0x1e, %xmm9, %xmm8
addl	%esi, %ebp
andl	%ebx, %edi
xorl	%ecx, %ebx
addl	%eax, %ebp
vpslld	$0x2, %xmm9, %xmm9
vpxor	%xmm6, %xmm8, %xmm6
shrdl	$0x7, %eax, %eax
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x2c(%rsp), %edx
vpxor	%xmm6, %xmm9, %xmm6
xorl	%ebx, %eax
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x20(%r15), %xmm14
andl	%eax, %esi
xorl	%ebx, %eax
addl	%ebp, %edx
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %esi
vpalignr	$0x8, %xmm3, %xmm4, %xmm7
movl	%edx, %edi
addl	0x30(%rsp), %ecx
vpaddd	%xmm6, %xmm10, %xmm9
xorl	%eax, %ebp
shldl	$0x5, %edx, %edx
vpsrldq	$0x4, %xmm6, %xmm8
addl	%esi, %ecx
andl	%ebp, %edi
vpxor	%xmm3, %xmm7, %xmm7
xorl	%eax, %ebp
addl	%edx, %ecx
vpxor	%xmm5, %xmm8, %xmm8
shrdl	$0x7, %edx, %edx
xorl	%eax, %edi
movl	%ecx, %esi
addl	0x34(%rsp), %ebx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x30(%r15), %xmm15
vpxor	%xmm7, %xmm8, %xmm7
xorl	%ebp, %edx
shldl	$0x5, %ecx, %ecx
vmovdqa	%xmm9, 0x20(%rsp)
addl	%edi, %ebx
andl	%edx, %esi
vpsrld	$0x1f, %xmm7, %xmm8
xorl	%ebp, %edx
addl	%ecx, %ebx
shrdl	$0x7, %ecx, %ecx
xorl	%ebp, %esi
vpslldq	$0xc, %xmm7, %xmm9
vpaddd	%xmm7, %xmm7, %xmm7
movl	%ebx, %edi
addl	0x38(%rsp), %eax
xorl	%edx, %ecx
shldl	$0x5, %ebx, %ebx
vpor	%xmm7, %xmm8, %xmm7
vpsrld	$0x1e, %xmm9, %xmm8
addl	%esi, %eax
andl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
vpslld	$0x2, %xmm9, %xmm9
vpxor	%xmm7, %xmm8, %xmm7
shrdl	$0x7, %ebx, %ebx
cmpl	$0xb, %r8d
jb	L_15ec
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x40(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x50(%r15), %xmm15
je	L_15ec
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x60(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x70(%r15), %xmm15
L_15ec:
vaesenclast	%xmm15, %xmm12, %xmm12
vmovups	-0x70(%r15), %xmm15
vmovups	-0x60(%r15), %xmm14
xorl	%edx, %edi
movl	%eax, %esi
addl	0x3c(%rsp), %ebp
vpxor	%xmm7, %xmm9, %xmm7
xorl	%ecx, %ebx
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
andl	%ebx, %esi
xorl	%ecx, %ebx
addl	%eax, %ebp
vpalignr	$0x8, %xmm6, %xmm7, %xmm8
vpxor	%xmm4, %xmm0, %xmm0
shrdl	$0x7, %eax, %eax
xorl	%ecx, %esi
movl	%ebp, %edi
addl	(%rsp), %edx
vpxor	%xmm1, %xmm0, %xmm0
xorl	%ebx, %eax
shldl	$0x5, %ebp, %ebp
vpaddd	%xmm7, %xmm10, %xmm9
addl	%esi, %edx
vmovdqu	0x10(%r12), %xmm13
vpxor	%xmm15, %xmm13, %xmm13
vmovups	%xmm12, (%r12,%r13)
vpxor	%xmm13, %xmm12, %xmm12
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x50(%r15), %xmm15
andl	%eax, %edi
vpxor	%xmm0, %xmm8, %xmm0
xorl	%ebx, %eax
addl	%ebp, %edx
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %edi
vpsrld	$0x1e, %xmm0, %xmm8
vmovdqa	%xmm9, 0x30(%rsp)
movl	%edx, %esi
addl	0x4(%rsp), %ecx
xorl	%eax, %ebp
shldl	$0x5, %edx, %edx
vpslld	$0x2, %xmm0, %xmm0
addl	%edi, %ecx
andl	%ebp, %esi
xorl	%eax, %ebp
addl	%edx, %ecx
shrdl	$0x7, %edx, %edx
xorl	%eax, %esi
movl	%ecx, %edi
addl	0x8(%rsp), %ebx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x40(%r15), %xmm14
vpor	%xmm0, %xmm8, %xmm0
xorl	%ebp, %edx
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
andl	%edx, %edi
xorl	%ebp, %edx
addl	%ecx, %ebx
addl	0xc(%rsp), %eax
xorl	%ebp, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%edx, %esi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vpalignr	$0x8, %xmm7, %xmm0, %xmm8
vpxor	%xmm5, %xmm1, %xmm1
addl	0x10(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x30(%r15), %xmm15
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
vpxor	%xmm2, %xmm1, %xmm1
addl	%esi, %ebp
xorl	%ecx, %edi
vpaddd	%xmm0, %xmm10, %xmm9
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
vpxor	%xmm1, %xmm8, %xmm1
addl	0x14(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
shldl	$0x5, %ebp, %ebp
vpsrld	$0x1e, %xmm1, %xmm8
vmovdqa	%xmm9, (%rsp)
addl	%edi, %edx
xorl	%ebx, %esi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vpslld	$0x2, %xmm1, %xmm1
addl	0x18(%rsp), %ecx
xorl	%eax, %esi
movl	%edx, %edi
shldl	$0x5, %edx, %edx
addl	%esi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x20(%r15), %xmm14
xorl	%eax, %edi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vpor	%xmm1, %xmm8, %xmm1
addl	0x1c(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
vpalignr	$0x8, %xmm0, %xmm1, %xmm8
vpxor	%xmm6, %xmm2, %xmm2
addl	0x20(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
shldl	$0x5, %ebx, %ebx
vpxor	%xmm3, %xmm2, %xmm2
addl	%esi, %eax
xorl	%edx, %edi
vpaddd	%xmm1, %xmm10, %xmm9
vmovdqa	0x20(%r11), %xmm10
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vpxor	%xmm2, %xmm8, %xmm2
addl	0x24(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x10(%r15), %xmm15
xorl	%ecx, %edi
movl	%eax, %esi
shldl	$0x5, %eax, %eax
vpsrld	$0x1e, %xmm2, %xmm8
vmovdqa	%xmm9, 0x10(%rsp)
addl	%edi, %ebp
xorl	%ecx, %esi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
vpslld	$0x2, %xmm2, %xmm2
addl	0x28(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
shldl	$0x5, %ebp, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vpor	%xmm2, %xmm8, %xmm2
addl	0x2c(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	(%r15), %xmm14
xorl	%eax, %esi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vpalignr	$0x8, %xmm1, %xmm2, %xmm8
vpxor	%xmm7, %xmm3, %xmm3
addl	0x30(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
vpxor	%xmm4, %xmm3, %xmm3
addl	%esi, %ebx
xorl	%ebp, %edi
vpaddd	%xmm2, %xmm10, %xmm9
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
vpxor	%xmm3, %xmm8, %xmm3
addl	0x34(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
vpsrld	$0x1e, %xmm3, %xmm8
vmovdqa	%xmm9, 0x20(%rsp)
addl	%edi, %eax
xorl	%edx, %esi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vpslld	$0x2, %xmm3, %xmm3
addl	0x38(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x10(%r15), %xmm15
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
vpor	%xmm3, %xmm8, %xmm3
addl	0x3c(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vpalignr	$0x8, %xmm2, %xmm3, %xmm8
vpxor	%xmm0, %xmm4, %xmm4
addl	(%rsp), %ecx
xorl	%eax, %esi
movl	%edx, %edi
shldl	$0x5, %edx, %edx
vpxor	%xmm5, %xmm4, %xmm4
addl	%esi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x20(%r15), %xmm14
xorl	%eax, %edi
vpaddd	%xmm3, %xmm10, %xmm9
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vpxor	%xmm4, %xmm8, %xmm4
addl	0x4(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
shldl	$0x5, %ecx, %ecx
vpsrld	$0x1e, %xmm4, %xmm8
vmovdqa	%xmm9, 0x30(%rsp)
addl	%edi, %ebx
xorl	%ebp, %esi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
vpslld	$0x2, %xmm4, %xmm4
addl	0x8(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
xorl	%edx, %edi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vpor	%xmm4, %xmm8, %xmm4
addl	0xc(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x30(%r15), %xmm15
xorl	%ecx, %edi
movl	%eax, %esi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
vpalignr	$0x8, %xmm3, %xmm4, %xmm8
vpxor	%xmm1, %xmm5, %xmm5
addl	0x10(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
shldl	$0x5, %ebp, %ebp
vpxor	%xmm6, %xmm5, %xmm5
addl	%esi, %edx
xorl	%ebx, %edi
vpaddd	%xmm4, %xmm10, %xmm9
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vpxor	%xmm5, %xmm8, %xmm5
addl	0x14(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
shldl	$0x5, %edx, %edx
vpsrld	$0x1e, %xmm5, %xmm8
vmovdqa	%xmm9, (%rsp)
addl	%edi, %ecx
cmpl	$0xb, %r8d
jb	L_19a1
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x40(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x50(%r15), %xmm15
je	L_19a1
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x60(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x70(%r15), %xmm15
L_19a1:
vaesenclast	%xmm15, %xmm12, %xmm12
vmovups	-0x70(%r15), %xmm15
vmovups	-0x60(%r15), %xmm14
xorl	%eax, %esi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vpslld	$0x2, %xmm5, %xmm5
addl	0x18(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
vpor	%xmm5, %xmm8, %xmm5
addl	0x1c(%rsp), %eax
shrdl	$0x7, %ecx, %ecx
movl	%ebx, %esi
xorl	%edx, %edi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%ecx, %esi
xorl	%edx, %ecx
addl	%ebx, %eax
vpalignr	$0x8, %xmm4, %xmm5, %xmm8
vpxor	%xmm2, %xmm6, %xmm6
addl	0x20(%rsp), %ebp
vmovdqu	0x20(%r12), %xmm13
vpxor	%xmm15, %xmm13, %xmm13
vmovups	%xmm12, 0x10(%r13,%r12)
vpxor	%xmm13, %xmm12, %xmm12
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x50(%r15), %xmm15
andl	%ecx, %esi
xorl	%edx, %ecx
shrdl	$0x7, %ebx, %ebx
vpxor	%xmm7, %xmm6, %xmm6
movl	%eax, %edi
xorl	%ecx, %esi
vpaddd	%xmm5, %xmm10, %xmm9
shldl	$0x5, %eax, %eax
addl	%esi, %ebp
vpxor	%xmm6, %xmm8, %xmm6
xorl	%ebx, %edi
xorl	%ecx, %ebx
addl	%eax, %ebp
addl	0x24(%rsp), %edx
vpsrld	$0x1e, %xmm6, %xmm8
vmovdqa	%xmm9, 0x10(%rsp)
andl	%ebx, %edi
xorl	%ecx, %ebx
shrdl	$0x7, %eax, %eax
movl	%ebp, %esi
vpslld	$0x2, %xmm6, %xmm6
xorl	%ebx, %edi
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x40(%r15), %xmm14
xorl	%eax, %esi
xorl	%ebx, %eax
addl	%ebp, %edx
addl	0x28(%rsp), %ecx
andl	%eax, %esi
vpor	%xmm6, %xmm8, %xmm6
xorl	%ebx, %eax
shrdl	$0x7, %ebp, %ebp
movl	%edx, %edi
xorl	%eax, %esi
shldl	$0x5, %edx, %edx
addl	%esi, %ecx
xorl	%ebp, %edi
xorl	%eax, %ebp
addl	%edx, %ecx
addl	0x2c(%rsp), %ebx
andl	%ebp, %edi
xorl	%eax, %ebp
shrdl	$0x7, %edx, %edx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x30(%r15), %xmm15
movl	%ecx, %esi
xorl	%ebp, %edi
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
xorl	%edx, %esi
xorl	%ebp, %edx
addl	%ecx, %ebx
vpalignr	$0x8, %xmm5, %xmm6, %xmm8
vpxor	%xmm3, %xmm7, %xmm7
addl	0x30(%rsp), %eax
andl	%edx, %esi
xorl	%ebp, %edx
shrdl	$0x7, %ecx, %ecx
vpxor	%xmm0, %xmm7, %xmm7
movl	%ebx, %edi
xorl	%edx, %esi
vpaddd	%xmm6, %xmm10, %xmm9
vmovdqa	0x30(%r11), %xmm10
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
vpxor	%xmm7, %xmm8, %xmm7
xorl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
addl	0x34(%rsp), %ebp
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x20(%r15), %xmm14
vpsrld	$0x1e, %xmm7, %xmm8
vmovdqa	%xmm9, 0x20(%rsp)
andl	%ecx, %edi
xorl	%edx, %ecx
shrdl	$0x7, %ebx, %ebx
movl	%eax, %esi
vpslld	$0x2, %xmm7, %xmm7
xorl	%ecx, %edi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ebx, %esi
xorl	%ecx, %ebx
addl	%eax, %ebp
addl	0x38(%rsp), %edx
andl	%ebx, %esi
vpor	%xmm7, %xmm8, %xmm7
xorl	%ecx, %ebx
shrdl	$0x7, %eax, %eax
movl	%ebp, %edi
xorl	%ebx, %esi
shldl	$0x5, %ebp, %ebp
addl	%esi, %edx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x10(%r15), %xmm15
xorl	%eax, %edi
xorl	%ebx, %eax
addl	%ebp, %edx
addl	0x3c(%rsp), %ecx
andl	%eax, %edi
xorl	%ebx, %eax
shrdl	$0x7, %ebp, %ebp
movl	%edx, %esi
xorl	%eax, %edi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
xorl	%ebp, %esi
xorl	%eax, %ebp
addl	%edx, %ecx
vpalignr	$0x8, %xmm6, %xmm7, %xmm8
vpxor	%xmm4, %xmm0, %xmm0
addl	(%rsp), %ebx
andl	%ebp, %esi
xorl	%eax, %ebp
shrdl	$0x7, %edx, %edx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	(%r15), %xmm14
vpxor	%xmm1, %xmm0, %xmm0
movl	%ecx, %edi
xorl	%ebp, %esi
vpaddd	%xmm7, %xmm10, %xmm9
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
vpxor	%xmm0, %xmm8, %xmm0
xorl	%edx, %edi
xorl	%ebp, %edx
addl	%ecx, %ebx
addl	0x4(%rsp), %eax
vpsrld	$0x1e, %xmm0, %xmm8
vmovdqa	%xmm9, 0x30(%rsp)
andl	%edx, %edi
xorl	%ebp, %edx
shrdl	$0x7, %ecx, %ecx
movl	%ebx, %esi
vpslld	$0x2, %xmm0, %xmm0
xorl	%edx, %edi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%ecx, %esi
xorl	%edx, %ecx
addl	%ebx, %eax
addl	0x8(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x10(%r15), %xmm15
andl	%ecx, %esi
vpor	%xmm0, %xmm8, %xmm0
xorl	%edx, %ecx
shrdl	$0x7, %ebx, %ebx
movl	%eax, %edi
xorl	%ecx, %esi
shldl	$0x5, %eax, %eax
addl	%esi, %ebp
xorl	%ebx, %edi
xorl	%ecx, %ebx
addl	%eax, %ebp
addl	0xc(%rsp), %edx
andl	%ebx, %edi
xorl	%ecx, %ebx
shrdl	$0x7, %eax, %eax
movl	%ebp, %esi
xorl	%ebx, %edi
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x20(%r15), %xmm14
xorl	%eax, %esi
xorl	%ebx, %eax
addl	%ebp, %edx
vpalignr	$0x8, %xmm7, %xmm0, %xmm8
vpxor	%xmm5, %xmm1, %xmm1
addl	0x10(%rsp), %ecx
andl	%eax, %esi
xorl	%ebx, %eax
shrdl	$0x7, %ebp, %ebp
vpxor	%xmm2, %xmm1, %xmm1
movl	%edx, %edi
xorl	%eax, %esi
vpaddd	%xmm0, %xmm10, %xmm9
shldl	$0x5, %edx, %edx
addl	%esi, %ecx
vpxor	%xmm1, %xmm8, %xmm1
xorl	%ebp, %edi
xorl	%eax, %ebp
addl	%edx, %ecx
addl	0x14(%rsp), %ebx
vpsrld	$0x1e, %xmm1, %xmm8
vmovdqa	%xmm9, (%rsp)
andl	%ebp, %edi
xorl	%eax, %ebp
shrdl	$0x7, %edx, %edx
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x30(%r15), %xmm15
movl	%ecx, %esi
vpslld	$0x2, %xmm1, %xmm1
xorl	%ebp, %edi
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
xorl	%edx, %esi
xorl	%ebp, %edx
addl	%ecx, %ebx
addl	0x18(%rsp), %eax
andl	%edx, %esi
vpor	%xmm1, %xmm8, %xmm1
xorl	%ebp, %edx
shrdl	$0x7, %ecx, %ecx
movl	%ebx, %edi
xorl	%edx, %esi
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
xorl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
addl	0x1c(%rsp), %ebp
cmpl	$0xb, %r8d
jb	L_1cf3
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x40(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x50(%r15), %xmm15
je	L_1cf3
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x60(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x70(%r15), %xmm15
L_1cf3:
vaesenclast	%xmm15, %xmm12, %xmm12
vmovups	-0x70(%r15), %xmm15
vmovups	-0x60(%r15), %xmm14
andl	%ecx, %edi
xorl	%edx, %ecx
shrdl	$0x7, %ebx, %ebx
movl	%eax, %esi
xorl	%ecx, %edi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ebx, %esi
xorl	%ecx, %ebx
addl	%eax, %ebp
vpalignr	$0x8, %xmm0, %xmm1, %xmm8
vpxor	%xmm6, %xmm2, %xmm2
addl	0x20(%rsp), %edx
andl	%ebx, %esi
xorl	%ecx, %ebx
shrdl	$0x7, %eax, %eax
vpxor	%xmm3, %xmm2, %xmm2
movl	%ebp, %edi
xorl	%ebx, %esi
vpaddd	%xmm1, %xmm10, %xmm9
shldl	$0x5, %ebp, %ebp
addl	%esi, %edx
vmovdqu	0x30(%r12), %xmm13
vpxor	%xmm15, %xmm13, %xmm13
vmovups	%xmm12, 0x20(%r13,%r12)
vpxor	%xmm13, %xmm12, %xmm12
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x50(%r15), %xmm15
vpxor	%xmm2, %xmm8, %xmm2
xorl	%eax, %edi
xorl	%ebx, %eax
addl	%ebp, %edx
addl	0x24(%rsp), %ecx
vpsrld	$0x1e, %xmm2, %xmm8
vmovdqa	%xmm9, 0x10(%rsp)
andl	%eax, %edi
xorl	%ebx, %eax
shrdl	$0x7, %ebp, %ebp
movl	%edx, %esi
vpslld	$0x2, %xmm2, %xmm2
xorl	%eax, %edi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
xorl	%ebp, %esi
xorl	%eax, %ebp
addl	%edx, %ecx
addl	0x28(%rsp), %ebx
andl	%ebp, %esi
vpor	%xmm2, %xmm8, %xmm2
xorl	%eax, %ebp
shrdl	$0x7, %edx, %edx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x40(%r15), %xmm14
movl	%ecx, %edi
xorl	%ebp, %esi
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
xorl	%edx, %edi
xorl	%ebp, %edx
addl	%ecx, %ebx
addl	0x2c(%rsp), %eax
andl	%edx, %edi
xorl	%ebp, %edx
shrdl	$0x7, %ecx, %ecx
movl	%ebx, %esi
xorl	%edx, %edi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%edx, %esi
addl	%ebx, %eax
vpalignr	$0x8, %xmm1, %xmm2, %xmm8
vpxor	%xmm7, %xmm3, %xmm3
addl	0x30(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x30(%r15), %xmm15
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
vpxor	%xmm4, %xmm3, %xmm3
addl	%esi, %ebp
xorl	%ecx, %edi
vpaddd	%xmm2, %xmm10, %xmm9
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
vpxor	%xmm3, %xmm8, %xmm3
addl	0x34(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
shldl	$0x5, %ebp, %ebp
vpsrld	$0x1e, %xmm3, %xmm8
vmovdqa	%xmm9, 0x20(%rsp)
addl	%edi, %edx
xorl	%ebx, %esi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vpslld	$0x2, %xmm3, %xmm3
addl	0x38(%rsp), %ecx
xorl	%eax, %esi
movl	%edx, %edi
shldl	$0x5, %edx, %edx
addl	%esi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	-0x20(%r15), %xmm14
xorl	%eax, %edi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vpor	%xmm3, %xmm8, %xmm3
addl	0x3c(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
addl	(%rsp), %eax
vpaddd	%xmm3, %xmm10, %xmm9
xorl	%edx, %esi
movl	%ebx, %edi
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
vmovdqa	%xmm9, 0x30(%rsp)
xorl	%edx, %edi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x4(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	-0x10(%r15), %xmm15
xorl	%ecx, %edi
movl	%eax, %esi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
addl	0x8(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
shldl	$0x5, %ebp, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
addl	0xc(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	(%r15), %xmm14
xorl	%eax, %esi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
cmpq	%r14, %r10
je	L_20fb
vmovdqa	0x40(%r11), %xmm9
vmovdqa	(%r11), %xmm10
vmovdqu	(%r10), %xmm0
vmovdqu	0x10(%r10), %xmm1
vmovdqu	0x20(%r10), %xmm2
vmovdqu	0x30(%r10), %xmm3
vpshufb	%xmm9, %xmm0, %xmm0
addq	$0x40, %r10
addl	0x10(%rsp), %ebx
xorl	%ebp, %esi
vpshufb	%xmm9, %xmm1, %xmm1
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
vpaddd	%xmm0, %xmm10, %xmm8
addl	%esi, %ebx
xorl	%ebp, %edi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
vmovdqa	%xmm8, (%rsp)
addl	0x14(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%edx, %esi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x18(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x10(%r15), %xmm15
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
addl	0x1c(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
addl	0x20(%rsp), %ecx
xorl	%eax, %esi
vpshufb	%xmm9, %xmm2, %xmm2
movl	%edx, %edi
shldl	$0x5, %edx, %edx
vpaddd	%xmm1, %xmm10, %xmm8
addl	%esi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x20(%r15), %xmm14
xorl	%eax, %edi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vmovdqa	%xmm8, 0x10(%rsp)
addl	0x24(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
addl	0x28(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
xorl	%edx, %edi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x2c(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x30(%r15), %xmm15
xorl	%ecx, %edi
movl	%eax, %esi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
addl	0x30(%rsp), %edx
xorl	%ebx, %esi
vpshufb	%xmm9, %xmm3, %xmm3
movl	%ebp, %edi
shldl	$0x5, %ebp, %ebp
vpaddd	%xmm2, %xmm10, %xmm8
addl	%esi, %edx
xorl	%ebx, %edi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vmovdqa	%xmm8, 0x20(%rsp)
addl	0x34(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
cmpl	$0xb, %r8d
jb	L_2079
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x40(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x50(%r15), %xmm15
je	L_2079
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x60(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x70(%r15), %xmm15
L_2079:
vaesenclast	%xmm15, %xmm12, %xmm12
vmovups	-0x70(%r15), %xmm15
vmovups	-0x60(%r15), %xmm14
xorl	%eax, %esi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
addl	0x38(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
addl	0x3c(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vmovups	%xmm12, 0x30(%r13,%r12)
leaq	0x40(%r12), %r12
addl	(%r9), %eax
addl	0x4(%r9), %esi
addl	0x8(%r9), %ecx
addl	0xc(%r9), %edx
movl	%eax, (%r9)
addl	0x10(%r9), %ebp
movl	%esi, 0x4(%r9)
movl	%esi, %ebx
movl	%ecx, 0x8(%r9)
movl	%ecx, %edi
movl	%edx, 0xc(%r9)
xorl	%edx, %edi
movl	%ebp, 0x10(%r9)
andl	%edi, %esi
jmp	L_12a0
L_20fb:
addl	0x10(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
addl	0x14(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%edx, %esi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x18(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x10(%r15), %xmm15
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
addl	0x1c(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
addl	0x20(%rsp), %ecx
xorl	%eax, %esi
movl	%edx, %edi
shldl	$0x5, %edx, %edx
addl	%esi, %ecx
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x20(%r15), %xmm14
xorl	%eax, %edi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
addl	0x24(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
shldl	$0x5, %ecx, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
addl	0x28(%rsp), %eax
xorl	%edx, %esi
movl	%ebx, %edi
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
xorl	%edx, %edi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x2c(%rsp), %ebp
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x30(%r15), %xmm15
xorl	%ecx, %edi
movl	%eax, %esi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
addl	0x30(%rsp), %edx
xorl	%ebx, %esi
movl	%ebp, %edi
shldl	$0x5, %ebp, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
addl	0x34(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
cmpl	$0xb, %r8d
jb	L_2224
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x40(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x50(%r15), %xmm15
je	L_2224
vaesenc	%xmm15, %xmm12, %xmm12
vmovups	0x60(%r15), %xmm14
vaesenc	%xmm14, %xmm12, %xmm12
vmovups	0x70(%r15), %xmm15
L_2224:
vaesenclast	%xmm15, %xmm12, %xmm12
vmovups	-0x70(%r15), %xmm15
vmovups	-0x60(%r15), %xmm14
xorl	%eax, %esi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
addl	0x38(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
addl	0x3c(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vmovups	%xmm12, 0x30(%r13,%r12)
movq	0x58(%rsp), %r8
addl	(%r9), %eax
addl	0x4(%r9), %esi
addl	0x8(%r9), %ecx
movl	%eax, (%r9)
addl	0xc(%r9), %edx
movl	%esi, 0x4(%r9)
addl	0x10(%r9), %ebp
movl	%ecx, 0x8(%r9)
movl	%edx, 0xc(%r9)
movl	%ebp, 0x10(%r9)
vmovups	%xmm12, (%r8)
vzeroall
leaq	0x68(%rsp), %rsi
movq	(%rsi), %r15
movq	0x8(%rsi), %r14
movq	0x10(%rsi), %r13
movq	0x18(%rsi), %r12
movq	0x20(%rsi), %rbp
movq	0x28(%rsi), %rbx
leaq	0x30(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
aesni_cbc_sha1_enc_shaext:
movq	0x8(%rsp), %r10
movdqu	(%r9), %xmm8
movd	0x10(%r9), %xmm9
movdqa	K_XX_XX+80(%rip), %xmm7
movl	0xf0(%rcx), %r11d
subq	%rdi, %rsi
movups	(%rcx), %xmm15
movups	(%r8), %xmm2
movups	0x10(%rcx), %xmm0
leaq	0x70(%rcx), %rcx
pshufd	$0x1b, %xmm8, %xmm8
pshufd	$0x1b, %xmm9, %xmm9
jmp	L_2320
L_2320:
movups	(%rdi), %xmm14
xorps	%xmm15, %xmm14
xorps	%xmm14, %xmm2
movups	-0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
movdqu	(%r10), %xmm3
movdqa	%xmm9, %xmm12
pshufb	%xmm7, %xmm3
movdqu	0x10(%r10), %xmm4
movdqa	%xmm8, %xmm11
movups	-0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
pshufb	%xmm7, %xmm4
paddd	%xmm3, %xmm9
movdqu	0x20(%r10), %xmm5
leaq	0x40(%r10), %r10
pxor	%xmm12, %xmm3
movups	-0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
pxor	%xmm12, %xmm3
movdqa	%xmm8, %xmm10
pshufb	%xmm7, %xmm5
sha1rnds4	$0x0, %xmm9, %xmm8
sha1nexte	%xmm4, %xmm10
movups	-0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
sha1msg1	%xmm4, %xmm3
movdqu	-0x10(%r10), %xmm6
movdqa	%xmm8, %xmm9
pshufb	%xmm7, %xmm6
movups	-0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1rnds4	$0x0, %xmm10, %xmm8
sha1nexte	%xmm5, %xmm9
pxor	%xmm5, %xmm3
sha1msg1	%xmm5, %xmm4
movups	(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x0, %xmm9, %xmm8
sha1nexte	%xmm6, %xmm10
movups	0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm6, %xmm3
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
movups	0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x0, %xmm10, %xmm8
sha1nexte	%xmm3, %xmm9
movups	0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm3, %xmm4
pxor	%xmm3, %xmm5
sha1msg1	%xmm3, %xmm6
cmpl	$0xb, %r11d
jb	L_2454
movups	0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
je	L_2454
movups	0x60(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%rcx), %xmm1
aesenc	%xmm0, %xmm2
L_2454:
aesenclast	%xmm1, %xmm2
movups	-0x60(%rcx), %xmm0
movdqa	%xmm8, %xmm10
sha1rnds4	$0x0, %xmm9, %xmm8
sha1nexte	%xmm4, %xmm10
movups	0x10(%rdi), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm2, (%rsi,%rdi)
xorps	%xmm14, %xmm2
movups	-0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm4, %xmm5
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm3
movups	-0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x1, %xmm10, %xmm8
sha1nexte	%xmm5, %xmm9
movups	-0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm5, %xmm6
pxor	%xmm5, %xmm3
sha1msg1	%xmm5, %xmm4
movups	-0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x1, %xmm9, %xmm8
sha1nexte	%xmm6, %xmm10
movups	-0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm6, %xmm3
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
movups	(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x1, %xmm10, %xmm8
sha1nexte	%xmm3, %xmm9
movups	0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm3, %xmm4
pxor	%xmm3, %xmm5
sha1msg1	%xmm3, %xmm6
movups	0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x1, %xmm9, %xmm8
sha1nexte	%xmm4, %xmm10
movups	0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm4, %xmm5
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm3
cmpl	$0xb, %r11d
jb	L_2576
movups	0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
je	L_2576
movups	0x60(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%rcx), %xmm1
aesenc	%xmm0, %xmm2
L_2576:
aesenclast	%xmm1, %xmm2
movups	-0x60(%rcx), %xmm0
movdqa	%xmm8, %xmm9
sha1rnds4	$0x1, %xmm10, %xmm8
sha1nexte	%xmm5, %xmm9
movups	0x20(%rdi), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm2, 0x10(%rsi,%rdi)
xorps	%xmm14, %xmm2
movups	-0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm5, %xmm6
pxor	%xmm5, %xmm3
sha1msg1	%xmm5, %xmm4
movups	-0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x2, %xmm9, %xmm8
sha1nexte	%xmm6, %xmm10
movups	-0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm6, %xmm3
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
movups	-0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x2, %xmm10, %xmm8
sha1nexte	%xmm3, %xmm9
movups	-0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm3, %xmm4
pxor	%xmm3, %xmm5
sha1msg1	%xmm3, %xmm6
movups	(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x2, %xmm9, %xmm8
sha1nexte	%xmm4, %xmm10
movups	0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm4, %xmm5
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm3
movups	0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x2, %xmm10, %xmm8
sha1nexte	%xmm5, %xmm9
movups	0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm5, %xmm6
pxor	%xmm5, %xmm3
sha1msg1	%xmm5, %xmm4
cmpl	$0xb, %r11d
jb	L_2699
movups	0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
je	L_2699
movups	0x60(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%rcx), %xmm1
aesenc	%xmm0, %xmm2
L_2699:
aesenclast	%xmm1, %xmm2
movups	-0x60(%rcx), %xmm0
movdqa	%xmm8, %xmm10
sha1rnds4	$0x2, %xmm9, %xmm8
sha1nexte	%xmm6, %xmm10
movups	0x30(%rdi), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm2, 0x20(%rsi,%rdi)
xorps	%xmm14, %xmm2
movups	-0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm6, %xmm3
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
movups	-0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x3, %xmm10, %xmm8
sha1nexte	%xmm3, %xmm9
movups	-0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
sha1msg2	%xmm3, %xmm4
pxor	%xmm3, %xmm5
sha1msg1	%xmm3, %xmm6
movups	-0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm8, %xmm10
sha1rnds4	$0x3, %xmm9, %xmm8
sha1nexte	%xmm4, %xmm10
sha1msg2	%xmm4, %xmm5
pxor	%xmm4, %xmm6
movups	-0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x3, %xmm10, %xmm8
sha1nexte	%xmm5, %xmm9
sha1msg2	%xmm5, %xmm6
movups	(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movdqa	%xmm12, %xmm5
movdqa	%xmm8, %xmm10
sha1rnds4	$0x3, %xmm9, %xmm8
sha1nexte	%xmm6, %xmm10
movups	0x10(%rcx), %xmm1
aesenc	%xmm0, %xmm2
movdqa	%xmm8, %xmm9
sha1rnds4	$0x3, %xmm10, %xmm8
sha1nexte	%xmm5, %xmm9
movups	0x20(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
cmpl	$0xb, %r11d
jb	L_27b9
movups	0x40(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
je	L_27b9
movups	0x60(%rcx), %xmm0
aesenc	%xmm1, %xmm2
movups	0x70(%rcx), %xmm1
aesenc	%xmm0, %xmm2
L_27b9:
aesenclast	%xmm1, %xmm2
movups	-0x60(%rcx), %xmm0
decq	%rdx
paddd	%xmm11, %xmm8
movups	%xmm2, 0x30(%rsi,%rdi)
leaq	0x40(%rdi), %rdi
jne	L_2320
pshufd	$0x1b, %xmm8, %xmm8
pshufd	$0x1b, %xmm9, %xmm9
movups	%xmm2, (%r8)
movdqu	%xmm8, (%r9)
movd	%xmm9, 0x10(%r9)
rep	retq
	.section .rodata
	.p2align 6
K_XX_XX:
	.byte 153,121,130,90,153,121,130,90,153,121,130,90,153,121,130,90
	.byte 161,235,217,110,161,235,217,110,161,235,217,110,161,235,217,110
	.byte 220,188,27,143,220,188,27,143,220,188,27,143,220,188,27,143
	.byte 214,193,98,202,214,193,98,202,214,193,98,202,214,193,98,202
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 65,69,83,78,73,45,67,66,67,43,83,72,65,49,32,115
	.byte 116,105,116,99,104,32,102,111,114,32,120,56,54,95,54,52
	.byte 44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32
	.byte 60,104,116,116,112,115,58,47,47,103,105,116,104,117,98,46
	.byte 99,111,109,47,100,111,116,45,97,115,109,62,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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

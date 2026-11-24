	.text
blake3_hash_many_sse41:
_blake3_hash_many_sse41:
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
pushq	%rbp
movq	%rsp, %rbp
subq	$0x168, %rsp
andq	$-0x40, %rsp
negl	%r9d
movd	%r9d, %xmm0
pshufd	$0x0, %xmm0, %xmm0
movdqa	%xmm0, 0x130(%rsp)
movdqa	%xmm0, %xmm1
pand	ADD0(%rip), %xmm1
pand	ADD1(%rip), %xmm0
movdqa	%xmm0, 0x150(%rsp)
movd	%r8d, %xmm0
pshufd	$0x0, %xmm0, %xmm0
paddd	%xmm1, %xmm0
movdqa	%xmm0, 0x110(%rsp)
pxor	CMP_MSB_MASK(%rip), %xmm0
pxor	CMP_MSB_MASK(%rip), %xmm1
pcmpgtd	%xmm0, %xmm1
shrq	$0x20, %r8
movd	%r8d, %xmm2
pshufd	$0x0, %xmm2, %xmm2
psubd	%xmm1, %xmm2
movdqa	%xmm2, 0x120(%rsp)
movq	0x50(%rbp), %rbx
movq	%rdx, %r15
shlq	$0x6, %r15
movzbl	0x38(%rbp), %r13d
movzbl	0x48(%rbp), %r12d
cmpq	$0x4, %rsi
jb	L_1f20
L_b0:
movdqu	(%rcx), %xmm3
pshufd	$0x0, %xmm3, %xmm0
pshufd	$0x55, %xmm3, %xmm1
pshufd	$0xaa, %xmm3, %xmm2
pshufd	$0xff, %xmm3, %xmm3
movdqu	0x10(%rcx), %xmm7
pshufd	$0x0, %xmm7, %xmm4
pshufd	$0x55, %xmm7, %xmm5
pshufd	$0xaa, %xmm7, %xmm6
pshufd	$0xff, %xmm7, %xmm7
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
L_f9:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movdqu	-0x40(%r8,%rdx), %xmm8
movdqu	-0x40(%r9,%rdx), %xmm9
movdqu	-0x40(%r10,%rdx), %xmm10
movdqu	-0x40(%r11,%rdx), %xmm11
movdqa	%xmm8, %xmm12
punpckldq	%xmm9, %xmm8
punpckhdq	%xmm9, %xmm12
movdqa	%xmm10, %xmm14
punpckldq	%xmm11, %xmm10
punpckhdq	%xmm11, %xmm14
movdqa	%xmm8, %xmm9
punpcklqdq	%xmm10, %xmm8
punpckhqdq	%xmm10, %xmm9
movdqa	%xmm12, %xmm13
punpcklqdq	%xmm14, %xmm12
punpckhqdq	%xmm14, %xmm13
movdqa	%xmm8, (%rsp)
movdqa	%xmm9, 0x10(%rsp)
movdqa	%xmm12, 0x20(%rsp)
movdqa	%xmm13, 0x30(%rsp)
movdqu	-0x30(%r8,%rdx), %xmm8
movdqu	-0x30(%r9,%rdx), %xmm9
movdqu	-0x30(%r10,%rdx), %xmm10
movdqu	-0x30(%r11,%rdx), %xmm11
movdqa	%xmm8, %xmm12
punpckldq	%xmm9, %xmm8
punpckhdq	%xmm9, %xmm12
movdqa	%xmm10, %xmm14
punpckldq	%xmm11, %xmm10
punpckhdq	%xmm11, %xmm14
movdqa	%xmm8, %xmm9
punpcklqdq	%xmm10, %xmm8
punpckhqdq	%xmm10, %xmm9
movdqa	%xmm12, %xmm13
punpcklqdq	%xmm14, %xmm12
punpckhqdq	%xmm14, %xmm13
movdqa	%xmm8, 0x40(%rsp)
movdqa	%xmm9, 0x50(%rsp)
movdqa	%xmm12, 0x60(%rsp)
movdqa	%xmm13, 0x70(%rsp)
movdqu	-0x20(%r8,%rdx), %xmm8
movdqu	-0x20(%r9,%rdx), %xmm9
movdqu	-0x20(%r10,%rdx), %xmm10
movdqu	-0x20(%r11,%rdx), %xmm11
movdqa	%xmm8, %xmm12
punpckldq	%xmm9, %xmm8
punpckhdq	%xmm9, %xmm12
movdqa	%xmm10, %xmm14
punpckldq	%xmm11, %xmm10
punpckhdq	%xmm11, %xmm14
movdqa	%xmm8, %xmm9
punpcklqdq	%xmm10, %xmm8
punpckhqdq	%xmm10, %xmm9
movdqa	%xmm12, %xmm13
punpcklqdq	%xmm14, %xmm12
punpckhqdq	%xmm14, %xmm13
movdqa	%xmm8, 0x80(%rsp)
movdqa	%xmm9, 0x90(%rsp)
movdqa	%xmm12, 0xa0(%rsp)
movdqa	%xmm13, 0xb0(%rsp)
movdqu	-0x10(%r8,%rdx), %xmm8
movdqu	-0x10(%r9,%rdx), %xmm9
movdqu	-0x10(%r10,%rdx), %xmm10
movdqu	-0x10(%r11,%rdx), %xmm11
movdqa	%xmm8, %xmm12
punpckldq	%xmm9, %xmm8
punpckhdq	%xmm9, %xmm12
movdqa	%xmm10, %xmm14
punpckldq	%xmm11, %xmm10
punpckhdq	%xmm11, %xmm14
movdqa	%xmm8, %xmm9
punpcklqdq	%xmm10, %xmm8
punpckhqdq	%xmm10, %xmm9
movdqa	%xmm12, %xmm13
punpcklqdq	%xmm14, %xmm12
punpckhqdq	%xmm14, %xmm13
movdqa	%xmm8, 0xc0(%rsp)
movdqa	%xmm9, 0xd0(%rsp)
movdqa	%xmm12, 0xe0(%rsp)
movdqa	%xmm13, 0xf0(%rsp)
movdqa	BLAKE3_IV_1(%rip), %xmm9
movdqa	BLAKE3_IV_2(%rip), %xmm10
movdqa	BLAKE3_IV_3(%rip), %xmm11
movdqa	0x110(%rsp), %xmm12
movdqa	0x120(%rsp), %xmm13
movdqa	BLAKE3_BLOCK_LEN(%rip), %xmm14
movd	%eax, %xmm15
pshufd	$0x0, %xmm15, %xmm15
prefetcht0	0x80(%r8,%rdx)
prefetcht0	0x80(%r9,%rdx)
prefetcht0	0x80(%r10,%rdx)
prefetcht0	0x80(%r11,%rdx)
paddd	(%rsp), %xmm0
paddd	0x20(%rsp), %xmm1
paddd	0x40(%rsp), %xmm2
paddd	0x60(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	BLAKE3_IV_0(%rip), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0x10(%rsp), %xmm0
paddd	0x30(%rsp), %xmm1
paddd	0x50(%rsp), %xmm2
paddd	0x70(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0x80(%rsp), %xmm0
paddd	0xa0(%rsp), %xmm1
paddd	0xc0(%rsp), %xmm2
paddd	0xe0(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	0x90(%rsp), %xmm0
paddd	0xb0(%rsp), %xmm1
paddd	0xd0(%rsp), %xmm2
paddd	0xf0(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
paddd	0x20(%rsp), %xmm0
paddd	0x30(%rsp), %xmm1
paddd	0x70(%rsp), %xmm2
paddd	0x40(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0x60(%rsp), %xmm0
paddd	0xa0(%rsp), %xmm1
paddd	(%rsp), %xmm2
paddd	0xd0(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0x10(%rsp), %xmm0
paddd	0xc0(%rsp), %xmm1
paddd	0x90(%rsp), %xmm2
paddd	0xf0(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	0xb0(%rsp), %xmm0
paddd	0x50(%rsp), %xmm1
paddd	0xe0(%rsp), %xmm2
paddd	0x80(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
paddd	0x30(%rsp), %xmm0
paddd	0xa0(%rsp), %xmm1
paddd	0xd0(%rsp), %xmm2
paddd	0x70(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0x40(%rsp), %xmm0
paddd	0xc0(%rsp), %xmm1
paddd	0x20(%rsp), %xmm2
paddd	0xe0(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0x60(%rsp), %xmm0
paddd	0x90(%rsp), %xmm1
paddd	0xb0(%rsp), %xmm2
paddd	0x80(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	0x50(%rsp), %xmm0
paddd	(%rsp), %xmm1
paddd	0xf0(%rsp), %xmm2
paddd	0x10(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
paddd	0xa0(%rsp), %xmm0
paddd	0xc0(%rsp), %xmm1
paddd	0xe0(%rsp), %xmm2
paddd	0xd0(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0x70(%rsp), %xmm0
paddd	0x90(%rsp), %xmm1
paddd	0x30(%rsp), %xmm2
paddd	0xf0(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0x40(%rsp), %xmm0
paddd	0xb0(%rsp), %xmm1
paddd	0x50(%rsp), %xmm2
paddd	0x10(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	(%rsp), %xmm0
paddd	0x20(%rsp), %xmm1
paddd	0x80(%rsp), %xmm2
paddd	0x60(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
paddd	0xc0(%rsp), %xmm0
paddd	0x90(%rsp), %xmm1
paddd	0xf0(%rsp), %xmm2
paddd	0xe0(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0xd0(%rsp), %xmm0
paddd	0xb0(%rsp), %xmm1
paddd	0xa0(%rsp), %xmm2
paddd	0x80(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0x70(%rsp), %xmm0
paddd	0x50(%rsp), %xmm1
paddd	(%rsp), %xmm2
paddd	0x60(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	0x20(%rsp), %xmm0
paddd	0x30(%rsp), %xmm1
paddd	0x10(%rsp), %xmm2
paddd	0x40(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
paddd	0x90(%rsp), %xmm0
paddd	0xb0(%rsp), %xmm1
paddd	0x80(%rsp), %xmm2
paddd	0xf0(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0xe0(%rsp), %xmm0
paddd	0x50(%rsp), %xmm1
paddd	0xc0(%rsp), %xmm2
paddd	0x10(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0xd0(%rsp), %xmm0
paddd	(%rsp), %xmm1
paddd	0x20(%rsp), %xmm2
paddd	0x40(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	0x30(%rsp), %xmm0
paddd	0xa0(%rsp), %xmm1
paddd	0x60(%rsp), %xmm2
paddd	0x70(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
paddd	0xb0(%rsp), %xmm0
paddd	0x50(%rsp), %xmm1
paddd	0x10(%rsp), %xmm2
paddd	0x80(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
paddd	0xf0(%rsp), %xmm0
paddd	(%rsp), %xmm1
paddd	0x90(%rsp), %xmm2
paddd	0x60(%rsp), %xmm3
paddd	%xmm4, %xmm0
paddd	%xmm5, %xmm1
paddd	%xmm6, %xmm2
paddd	%xmm7, %xmm3
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm13
pxor	%xmm2, %xmm14
pxor	%xmm3, %xmm15
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
pshufb	%xmm8, %xmm15
movdqa	0x100(%rsp), %xmm8
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
pxor	%xmm10, %xmm6
pxor	%xmm11, %xmm7
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
paddd	0xe0(%rsp), %xmm0
paddd	0x20(%rsp), %xmm1
paddd	0x30(%rsp), %xmm2
paddd	0x70(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT16(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
movdqa	%xmm8, 0x100(%rsp)
movdqa	%xmm5, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0xc, %xmm8
pslld	$0x14, %xmm4
por	%xmm8, %xmm4
paddd	0xa0(%rsp), %xmm0
paddd	0xc0(%rsp), %xmm1
paddd	0x40(%rsp), %xmm2
paddd	0xd0(%rsp), %xmm3
paddd	%xmm5, %xmm0
paddd	%xmm6, %xmm1
paddd	%xmm7, %xmm2
paddd	%xmm4, %xmm3
pxor	%xmm0, %xmm15
pxor	%xmm1, %xmm12
pxor	%xmm2, %xmm13
pxor	%xmm3, %xmm14
movdqa	ROT8(%rip), %xmm8
pshufb	%xmm8, %xmm15
pshufb	%xmm8, %xmm12
pshufb	%xmm8, %xmm13
pshufb	%xmm8, %xmm14
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
movdqa	0x100(%rsp), %xmm8
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm10, %xmm5
pxor	%xmm11, %xmm6
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm4
pxor	%xmm8, %xmm0
pxor	%xmm9, %xmm1
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm3
movdqa	%xmm5, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm5
por	%xmm8, %xmm5
movdqa	%xmm6, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm6
por	%xmm8, %xmm6
movdqa	%xmm7, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm7
por	%xmm8, %xmm7
movdqa	%xmm4, %xmm8
psrld	$0x7, %xmm8
pslld	$0x19, %xmm4
por	%xmm8, %xmm4
pxor	%xmm12, %xmm4
pxor	%xmm13, %xmm5
pxor	%xmm14, %xmm6
pxor	%xmm15, %xmm7
movl	%r13d, %eax
jne	L_f9
movdqa	%xmm0, %xmm9
punpckldq	%xmm1, %xmm0
punpckhdq	%xmm1, %xmm9
movdqa	%xmm2, %xmm11
punpckldq	%xmm3, %xmm2
punpckhdq	%xmm3, %xmm11
movdqa	%xmm0, %xmm1
punpcklqdq	%xmm2, %xmm0
punpckhqdq	%xmm2, %xmm1
movdqa	%xmm9, %xmm3
punpcklqdq	%xmm11, %xmm9
punpckhqdq	%xmm11, %xmm3
movdqu	%xmm0, (%rbx)
movdqu	%xmm1, 0x20(%rbx)
movdqu	%xmm9, 0x40(%rbx)
movdqu	%xmm3, 0x60(%rbx)
movdqa	%xmm4, %xmm9
punpckldq	%xmm5, %xmm4
punpckhdq	%xmm5, %xmm9
movdqa	%xmm6, %xmm11
punpckldq	%xmm7, %xmm6
punpckhdq	%xmm7, %xmm11
movdqa	%xmm4, %xmm5
punpcklqdq	%xmm6, %xmm4
punpckhqdq	%xmm6, %xmm5
movdqa	%xmm9, %xmm7
punpcklqdq	%xmm11, %xmm9
punpckhqdq	%xmm11, %xmm7
movdqu	%xmm4, 0x10(%rbx)
movdqu	%xmm5, 0x30(%rbx)
movdqu	%xmm9, 0x50(%rbx)
movdqu	%xmm7, 0x70(%rbx)
movdqa	0x110(%rsp), %xmm1
movdqa	%xmm1, %xmm0
paddd	0x150(%rsp), %xmm1
movdqa	%xmm1, 0x110(%rsp)
pxor	CMP_MSB_MASK(%rip), %xmm0
pxor	CMP_MSB_MASK(%rip), %xmm1
pcmpgtd	%xmm1, %xmm0
movdqa	0x120(%rsp), %xmm1
psubd	%xmm0, %xmm1
movdqa	%xmm1, 0x120(%rsp)
addq	$0x80, %rbx
addq	$0x20, %rdi
subq	$0x4, %rsi
cmpq	$0x4, %rsi
jae	L_b0
testq	%rsi, %rsi
jne	L_1f20
L_1f09:
movq	%rbp, %rsp
popq	%rbp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
retq
nopw	(%rax,%rax)
L_1f20:
testl	$0x2, %esi
je	L_238f
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
movaps	%xmm0, %xmm8
movaps	%xmm1, %xmm9
movd	0x110(%rsp), %xmm13
pinsrd	$0x1, 0x120(%rsp), %xmm13
pinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm13
movaps	%xmm13, (%rsp)
movd	0x114(%rsp), %xmm14
pinsrd	$0x1, 0x124(%rsp), %xmm14
pinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm14
movaps	%xmm14, 0x10(%rsp)
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
L_1f98:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movaps	BLAKE3_IV(%rip), %xmm2
movaps	%xmm2, %xmm10
movups	-0x40(%r8,%rdx), %xmm4
movups	-0x30(%r8,%rdx), %xmm5
movaps	%xmm4, %xmm3
shufps	$0x88, %xmm5, %xmm4
shufps	$0xdd, %xmm5, %xmm3
movaps	%xmm3, %xmm5
movups	-0x20(%r8,%rdx), %xmm6
movups	-0x10(%r8,%rdx), %xmm7
movaps	%xmm6, %xmm3
shufps	$0x88, %xmm7, %xmm6
pshufd	$0x93, %xmm6, %xmm6
shufps	$0xdd, %xmm7, %xmm3
pshufd	$0x93, %xmm3, %xmm7
movups	-0x40(%r9,%rdx), %xmm12
movups	-0x30(%r9,%rdx), %xmm13
movaps	%xmm12, %xmm11
shufps	$0x88, %xmm13, %xmm12
shufps	$0xdd, %xmm13, %xmm11
movaps	%xmm11, %xmm13
movups	-0x20(%r9,%rdx), %xmm14
movups	-0x10(%r9,%rdx), %xmm15
movaps	%xmm14, %xmm11
shufps	$0x88, %xmm15, %xmm14
pshufd	$0x93, %xmm14, %xmm14
shufps	$0xdd, %xmm15, %xmm11
pshufd	$0x93, %xmm11, %xmm15
movaps	(%rsp), %xmm3
movaps	0x10(%rsp), %xmm11
pinsrd	$0x3, %eax, %xmm3
pinsrd	$0x3, %eax, %xmm11
movb	$0x7, %al
L_204c:
paddd	%xmm4, %xmm0
paddd	%xmm12, %xmm8
movaps	%xmm4, 0x20(%rsp)
movaps	%xmm12, 0x30(%rsp)
paddd	%xmm1, %xmm0
paddd	%xmm9, %xmm8
pxor	%xmm0, %xmm3
pxor	%xmm8, %xmm11
movaps	ROT16(%rip), %xmm12
pshufb	%xmm12, %xmm3
pshufb	%xmm12, %xmm11
paddd	%xmm3, %xmm2
paddd	%xmm11, %xmm10
pxor	%xmm2, %xmm1
pxor	%xmm10, %xmm9
movdqa	%xmm1, %xmm4
pslld	$0x14, %xmm1
psrld	$0xc, %xmm4
por	%xmm4, %xmm1
movdqa	%xmm9, %xmm4
pslld	$0x14, %xmm9
psrld	$0xc, %xmm4
por	%xmm4, %xmm9
paddd	%xmm5, %xmm0
paddd	%xmm13, %xmm8
movaps	%xmm5, 0x40(%rsp)
movaps	%xmm13, 0x50(%rsp)
paddd	%xmm1, %xmm0
paddd	%xmm9, %xmm8
pxor	%xmm0, %xmm3
pxor	%xmm8, %xmm11
movaps	ROT8(%rip), %xmm13
pshufb	%xmm13, %xmm3
pshufb	%xmm13, %xmm11
paddd	%xmm3, %xmm2
paddd	%xmm11, %xmm10
pxor	%xmm2, %xmm1
pxor	%xmm10, %xmm9
movdqa	%xmm1, %xmm4
pslld	$0x19, %xmm1
psrld	$0x7, %xmm4
por	%xmm4, %xmm1
movdqa	%xmm9, %xmm4
pslld	$0x19, %xmm9
psrld	$0x7, %xmm4
por	%xmm4, %xmm9
pshufd	$0x93, %xmm0, %xmm0
pshufd	$0x93, %xmm8, %xmm8
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x4e, %xmm11, %xmm11
pshufd	$0x39, %xmm2, %xmm2
pshufd	$0x39, %xmm10, %xmm10
paddd	%xmm6, %xmm0
paddd	%xmm14, %xmm8
paddd	%xmm1, %xmm0
paddd	%xmm9, %xmm8
pxor	%xmm0, %xmm3
pxor	%xmm8, %xmm11
pshufb	%xmm12, %xmm3
pshufb	%xmm12, %xmm11
paddd	%xmm3, %xmm2
paddd	%xmm11, %xmm10
pxor	%xmm2, %xmm1
pxor	%xmm10, %xmm9
movdqa	%xmm1, %xmm4
pslld	$0x14, %xmm1
psrld	$0xc, %xmm4
por	%xmm4, %xmm1
movdqa	%xmm9, %xmm4
pslld	$0x14, %xmm9
psrld	$0xc, %xmm4
por	%xmm4, %xmm9
paddd	%xmm7, %xmm0
paddd	%xmm15, %xmm8
paddd	%xmm1, %xmm0
paddd	%xmm9, %xmm8
pxor	%xmm0, %xmm3
pxor	%xmm8, %xmm11
pshufb	%xmm13, %xmm3
pshufb	%xmm13, %xmm11
paddd	%xmm3, %xmm2
paddd	%xmm11, %xmm10
pxor	%xmm2, %xmm1
pxor	%xmm10, %xmm9
movdqa	%xmm1, %xmm4
pslld	$0x19, %xmm1
psrld	$0x7, %xmm4
por	%xmm4, %xmm1
movdqa	%xmm9, %xmm4
pslld	$0x19, %xmm9
psrld	$0x7, %xmm4
por	%xmm4, %xmm9
pshufd	$0x39, %xmm0, %xmm0
pshufd	$0x39, %xmm8, %xmm8
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x4e, %xmm11, %xmm11
pshufd	$0x93, %xmm2, %xmm2
pshufd	$0x93, %xmm10, %xmm10
decb	%al
je	L_230b
movdqa	0x20(%rsp), %xmm12
movdqa	0x40(%rsp), %xmm5
pshufd	$0xf, %xmm12, %xmm13
shufps	$0xd6, %xmm5, %xmm12
pshufd	$0x39, %xmm12, %xmm4
movdqa	%xmm6, %xmm12
shufps	$0xfa, %xmm7, %xmm12
pblendw	$0xcc, %xmm12, %xmm13
movdqa	%xmm7, %xmm12
punpcklqdq	%xmm5, %xmm12
pblendw	$0xc0, %xmm6, %xmm12
pshufd	$0x78, %xmm12, %xmm12
punpckhdq	%xmm7, %xmm5
punpckldq	%xmm5, %xmm6
pshufd	$0x1e, %xmm6, %xmm7
movdqa	%xmm13, 0x20(%rsp)
movdqa	%xmm12, 0x40(%rsp)
movdqa	0x30(%rsp), %xmm5
movdqa	0x50(%rsp), %xmm13
pshufd	$0xf, %xmm5, %xmm6
shufps	$0xd6, %xmm13, %xmm5
pshufd	$0x39, %xmm5, %xmm12
movdqa	%xmm14, %xmm5
shufps	$0xfa, %xmm15, %xmm5
pblendw	$0xcc, %xmm5, %xmm6
movdqa	%xmm15, %xmm5
punpcklqdq	%xmm13, %xmm5
pblendw	$0xc0, %xmm14, %xmm5
pshufd	$0x78, %xmm5, %xmm5
punpckhdq	%xmm15, %xmm13
punpckldq	%xmm13, %xmm14
pshufd	$0x1e, %xmm14, %xmm15
movdqa	%xmm6, %xmm13
movdqa	%xmm5, %xmm14
movdqa	0x20(%rsp), %xmm5
movdqa	0x40(%rsp), %xmm6
jmp	L_204c
L_230b:
pxor	%xmm2, %xmm0
pxor	%xmm3, %xmm1
pxor	%xmm10, %xmm8
pxor	%xmm11, %xmm9
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_1f98
movups	%xmm0, (%rbx)
movups	%xmm1, 0x10(%rbx)
movups	%xmm8, 0x20(%rbx)
movups	%xmm9, 0x30(%rbx)
movdqa	0x130(%rsp), %xmm0
movdqa	0x110(%rsp), %xmm1
movdqa	0x120(%rsp), %xmm2
movdqu	0x118(%rsp), %xmm3
movdqu	0x128(%rsp), %xmm4
blendvps	%xmm0, %xmm3, %xmm1
blendvps	%xmm0, %xmm4, %xmm2
movdqa	%xmm1, 0x110(%rsp)
movdqa	%xmm2, 0x120(%rsp)
addq	$0x10, %rdi
addq	$0x40, %rbx
subq	$0x2, %rsi
L_238f:
testl	$0x1, %esi
je	L_1f09
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
movd	0x110(%rsp), %xmm13
pinsrd	$0x1, 0x120(%rsp), %xmm13
pinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm13
movaps	ROT8(%rip), %xmm14
movaps	ROT16(%rip), %xmm15
movq	(%rdi), %r8
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
L_23df:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movaps	BLAKE3_IV(%rip), %xmm2
movaps	%xmm13, %xmm3
pinsrd	$0x3, %eax, %xmm3
movups	-0x40(%r8,%rdx), %xmm4
movups	-0x30(%r8,%rdx), %xmm5
movaps	%xmm4, %xmm8
shufps	$0x88, %xmm5, %xmm4
shufps	$0xdd, %xmm5, %xmm8
movaps	%xmm8, %xmm5
movups	-0x20(%r8,%rdx), %xmm6
movups	-0x10(%r8,%rdx), %xmm7
movaps	%xmm6, %xmm8
shufps	$0x88, %xmm7, %xmm6
pshufd	$0x93, %xmm6, %xmm6
shufps	$0xdd, %xmm7, %xmm8
pshufd	$0x93, %xmm8, %xmm7
movb	$0x7, %al
L_2444:
paddd	%xmm4, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm15, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x14, %xmm1
psrld	$0xc, %xmm11
por	%xmm11, %xmm1
paddd	%xmm5, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm14, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x19, %xmm1
psrld	$0x7, %xmm11
por	%xmm11, %xmm1
pshufd	$0x93, %xmm0, %xmm0
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x39, %xmm2, %xmm2
paddd	%xmm6, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm15, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x14, %xmm1
psrld	$0xc, %xmm11
por	%xmm11, %xmm1
paddd	%xmm7, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm14, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x19, %xmm1
psrld	$0x7, %xmm11
por	%xmm11, %xmm1
pshufd	$0x39, %xmm0, %xmm0
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_257c
movdqa	%xmm4, %xmm8
shufps	$0xd6, %xmm5, %xmm8
pshufd	$0xf, %xmm4, %xmm9
pshufd	$0x39, %xmm8, %xmm4
movdqa	%xmm6, %xmm8
shufps	$0xfa, %xmm7, %xmm8
pblendw	$0xcc, %xmm8, %xmm9
movdqa	%xmm7, %xmm8
punpcklqdq	%xmm5, %xmm8
pblendw	$0xc0, %xmm6, %xmm8
pshufd	$0x78, %xmm8, %xmm8
punpckhdq	%xmm7, %xmm5
punpckldq	%xmm5, %xmm6
pshufd	$0x1e, %xmm6, %xmm7
movdqa	%xmm9, %xmm5
movdqa	%xmm8, %xmm6
jmp	L_2444
L_257c:
pxor	%xmm2, %xmm0
pxor	%xmm3, %xmm1
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_23df
movups	%xmm0, (%rbx)
movups	%xmm1, 0x10(%rbx)
jmp	L_1f09
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
blake3_compress_in_place_sse41:
_blake3_compress_in_place_sse41:
movups	(%rdi), %xmm0
movups	0x10(%rdi), %xmm1
movaps	BLAKE3_IV(%rip), %xmm2
shlq	$0x20, %r8
addq	%r8, %rdx
movq	%rcx, %xmm3
movq	%rdx, %xmm4
punpcklqdq	%xmm4, %xmm3
movups	(%rsi), %xmm4
movups	0x10(%rsi), %xmm5
movaps	%xmm4, %xmm8
shufps	$0x88, %xmm5, %xmm4
shufps	$0xdd, %xmm5, %xmm8
movaps	%xmm8, %xmm5
movups	0x20(%rsi), %xmm6
movups	0x30(%rsi), %xmm7
movaps	%xmm6, %xmm8
shufps	$0x88, %xmm7, %xmm6
pshufd	$0x93, %xmm6, %xmm6
shufps	$0xdd, %xmm7, %xmm8
pshufd	$0x93, %xmm8, %xmm7
movaps	ROT8(%rip), %xmm14
movaps	ROT16(%rip), %xmm15
movb	$0x7, %al
L_262d:
paddd	%xmm4, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm15, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x14, %xmm1
psrld	$0xc, %xmm11
por	%xmm11, %xmm1
paddd	%xmm5, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm14, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x19, %xmm1
psrld	$0x7, %xmm11
por	%xmm11, %xmm1
pshufd	$0x93, %xmm0, %xmm0
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x39, %xmm2, %xmm2
paddd	%xmm6, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm15, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x14, %xmm1
psrld	$0xc, %xmm11
por	%xmm11, %xmm1
paddd	%xmm7, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm14, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x19, %xmm1
psrld	$0x7, %xmm11
por	%xmm11, %xmm1
pshufd	$0x39, %xmm0, %xmm0
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_2765
movdqa	%xmm4, %xmm8
shufps	$0xd6, %xmm5, %xmm8
pshufd	$0xf, %xmm4, %xmm9
pshufd	$0x39, %xmm8, %xmm4
movdqa	%xmm6, %xmm8
shufps	$0xfa, %xmm7, %xmm8
pblendw	$0xcc, %xmm8, %xmm9
movdqa	%xmm7, %xmm8
punpcklqdq	%xmm5, %xmm8
pblendw	$0xc0, %xmm6, %xmm8
pshufd	$0x78, %xmm8, %xmm8
punpckhdq	%xmm7, %xmm5
punpckldq	%xmm5, %xmm6
pshufd	$0x1e, %xmm6, %xmm7
movdqa	%xmm9, %xmm5
movdqa	%xmm8, %xmm6
jmp	L_262d
L_2765:
pxor	%xmm2, %xmm0
pxor	%xmm3, %xmm1
movups	%xmm0, (%rdi)
movups	%xmm1, 0x10(%rdi)
retq
nopw	%cs:(%rax,%rax)
nop
blake3_compress_xof_sse41:
_blake3_compress_xof_sse41:
movups	(%rdi), %xmm0
movups	0x10(%rdi), %xmm1
movaps	BLAKE3_IV(%rip), %xmm2
movzbl	%r8b, %eax
movzbl	%dl, %edx
shlq	$0x20, %rax
addq	%rax, %rdx
movq	%rcx, %xmm3
movq	%rdx, %xmm4
punpcklqdq	%xmm4, %xmm3
movups	(%rsi), %xmm4
movups	0x10(%rsi), %xmm5
movaps	%xmm4, %xmm8
shufps	$0x88, %xmm5, %xmm4
shufps	$0xdd, %xmm5, %xmm8
movaps	%xmm8, %xmm5
movups	0x20(%rsi), %xmm6
movups	0x30(%rsi), %xmm7
movaps	%xmm6, %xmm8
shufps	$0x88, %xmm7, %xmm6
pshufd	$0x93, %xmm6, %xmm6
shufps	$0xdd, %xmm7, %xmm8
pshufd	$0x93, %xmm8, %xmm7
movaps	ROT8(%rip), %xmm14
movaps	ROT16(%rip), %xmm15
movb	$0x7, %al
L_27f4:
paddd	%xmm4, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm15, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x14, %xmm1
psrld	$0xc, %xmm11
por	%xmm11, %xmm1
paddd	%xmm5, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm14, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x19, %xmm1
psrld	$0x7, %xmm11
por	%xmm11, %xmm1
pshufd	$0x93, %xmm0, %xmm0
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x39, %xmm2, %xmm2
paddd	%xmm6, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm15, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x14, %xmm1
psrld	$0xc, %xmm11
por	%xmm11, %xmm1
paddd	%xmm7, %xmm0
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm14, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm11
pslld	$0x19, %xmm1
psrld	$0x7, %xmm11
por	%xmm11, %xmm1
pshufd	$0x39, %xmm0, %xmm0
pshufd	$0x4e, %xmm3, %xmm3
pshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_292c
movdqa	%xmm4, %xmm8
shufps	$0xd6, %xmm5, %xmm8
pshufd	$0xf, %xmm4, %xmm9
pshufd	$0x39, %xmm8, %xmm4
movdqa	%xmm6, %xmm8
shufps	$0xfa, %xmm7, %xmm8
pblendw	$0xcc, %xmm8, %xmm9
movdqa	%xmm7, %xmm8
punpcklqdq	%xmm5, %xmm8
pblendw	$0xc0, %xmm6, %xmm8
pshufd	$0x78, %xmm8, %xmm8
punpckhdq	%xmm7, %xmm5
punpckldq	%xmm5, %xmm6
pshufd	$0x1e, %xmm6, %xmm7
movdqa	%xmm9, %xmm5
movdqa	%xmm8, %xmm6
jmp	L_27f4
L_292c:
movdqu	(%rdi), %xmm4
movdqu	0x10(%rdi), %xmm5
pxor	%xmm2, %xmm0
pxor	%xmm3, %xmm1
pxor	%xmm4, %xmm2
pxor	%xmm5, %xmm3
movups	%xmm0, (%r9)
movups	%xmm1, 0x10(%r9)
movups	%xmm2, 0x20(%r9)
movups	%xmm3, 0x30(%r9)
retq
	.section .rodata
BLAKE3_IV:
	.byte 103,230,9,106,133,174,103,187,114,243,110,60,58,245,79,165
ROT16:
	.byte 2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13
ROT8:
	.byte 1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12
ADD0:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
ADD1:
	.byte 4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0
BLAKE3_IV_0:
	.byte 103,230,9,106,103,230,9,106,103,230,9,106,103,230,9,106
BLAKE3_IV_1:
	.byte 133,174,103,187,133,174,103,187,133,174,103,187,133,174,103,187
BLAKE3_IV_2:
	.byte 114,243,110,60,114,243,110,60,114,243,110,60,114,243,110,60
BLAKE3_IV_3:
	.byte 58,245,79,165,58,245,79,165,58,245,79,165,58,245,79,165
BLAKE3_BLOCK_LEN:
	.byte 64,0,0,0,64,0,0,0,64,0,0,0,64,0,0,0
CMP_MSB_MASK:
	.byte 0,0,0,128,0,0,0,128,0,0,0,128,0,0,0,128

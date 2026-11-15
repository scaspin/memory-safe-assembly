	.text
ChaCha20_ctr32:
cmpq	$0x0, %rdx
je	L_39a
movq	OPENSSL_ia32cap_P+4(%rip), %r10
testl	$0x200, %r10d
jne	ChaCha20_ssse3
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x58, %rsp
movdqu	(%rcx), %xmm1
movdqu	0x10(%rcx), %xmm2
movdqu	(%r8), %xmm3
movdqa	bums_rodata+16(%rip), %xmm4
movdqa	%xmm1, 0x10(%rsp)
movdqa	%xmm2, 0x20(%rsp)
movdqa	%xmm3, 0x30(%rsp)
movq	%rdx, %rbp
jmp	L_60
nopl	(%rax)
L_60:
movl	$0x61707865, %eax
movl	$0x3320646e, %ebx
movl	$0x79622d32, %ecx
movl	$0x6b206574, %edx
movl	0x10(%rsp), %r8d
movl	0x14(%rsp), %r9d
movl	0x18(%rsp), %r10d
movl	0x1c(%rsp), %r11d
movd	%xmm3, %r12d
movl	0x34(%rsp), %r13d
movl	0x38(%rsp), %r14d
movl	0x3c(%rsp), %r15d
movq	%rbp, 0x40(%rsp)
movl	$0xa, %ebp
movq	%rsi, 0x48(%rsp)
movq	%xmm2, %rsi
movq	%rdi, 0x50(%rsp)
movq	%rsi, %rdi
shrq	$0x20, %rdi
jmp	L_c0
nop
L_c0:
addl	%r8d, %eax
xorl	%eax, %r12d
roll	$0x10, %r12d
addl	%r9d, %ebx
xorl	%ebx, %r13d
roll	$0x10, %r13d
addl	%r12d, %esi
xorl	%esi, %r8d
roll	$0xc, %r8d
addl	%r13d, %edi
xorl	%edi, %r9d
roll	$0xc, %r9d
addl	%r8d, %eax
xorl	%eax, %r12d
roll	$0x8, %r12d
addl	%r9d, %ebx
xorl	%ebx, %r13d
roll	$0x8, %r13d
addl	%r12d, %esi
xorl	%esi, %r8d
roll	$0x7, %r8d
addl	%r13d, %edi
xorl	%edi, %r9d
roll	$0x7, %r9d
movl	%esi, 0x20(%rsp)
movl	%edi, 0x24(%rsp)
movl	0x28(%rsp), %esi
movl	0x2c(%rsp), %edi
addl	%r10d, %ecx
xorl	%ecx, %r14d
roll	$0x10, %r14d
addl	%r11d, %edx
xorl	%edx, %r15d
roll	$0x10, %r15d
addl	%r14d, %esi
xorl	%esi, %r10d
roll	$0xc, %r10d
addl	%r15d, %edi
xorl	%edi, %r11d
roll	$0xc, %r11d
addl	%r10d, %ecx
xorl	%ecx, %r14d
roll	$0x8, %r14d
addl	%r11d, %edx
xorl	%edx, %r15d
roll	$0x8, %r15d
addl	%r14d, %esi
xorl	%esi, %r10d
roll	$0x7, %r10d
addl	%r15d, %edi
xorl	%edi, %r11d
roll	$0x7, %r11d
addl	%r9d, %eax
xorl	%eax, %r15d
roll	$0x10, %r15d
addl	%r10d, %ebx
xorl	%ebx, %r12d
roll	$0x10, %r12d
addl	%r15d, %esi
xorl	%esi, %r9d
roll	$0xc, %r9d
addl	%r12d, %edi
xorl	%edi, %r10d
roll	$0xc, %r10d
addl	%r9d, %eax
xorl	%eax, %r15d
roll	$0x8, %r15d
addl	%r10d, %ebx
xorl	%ebx, %r12d
roll	$0x8, %r12d
addl	%r15d, %esi
xorl	%esi, %r9d
roll	$0x7, %r9d
addl	%r12d, %edi
xorl	%edi, %r10d
roll	$0x7, %r10d
movl	%esi, 0x28(%rsp)
movl	%edi, 0x2c(%rsp)
movl	0x20(%rsp), %esi
movl	0x24(%rsp), %edi
addl	%r11d, %ecx
xorl	%ecx, %r13d
roll	$0x10, %r13d
addl	%r8d, %edx
xorl	%edx, %r14d
roll	$0x10, %r14d
addl	%r13d, %esi
xorl	%esi, %r11d
roll	$0xc, %r11d
addl	%r14d, %edi
xorl	%edi, %r8d
roll	$0xc, %r8d
addl	%r11d, %ecx
xorl	%ecx, %r13d
roll	$0x8, %r13d
addl	%r8d, %edx
xorl	%edx, %r14d
roll	$0x8, %r14d
addl	%r13d, %esi
xorl	%esi, %r11d
roll	$0x7, %r11d
addl	%r14d, %edi
xorl	%edi, %r8d
roll	$0x7, %r8d
decl	%ebp
jne	L_c0
movl	%edi, 0x24(%rsp)
movl	%esi, 0x20(%rsp)
movq	0x40(%rsp), %rbp
movdqa	%xmm2, %xmm1
movq	0x48(%rsp), %rsi
paddd	%xmm4, %xmm3
movq	0x50(%rsp), %rdi
addl	$0x61707865, %eax
addl	$0x3320646e, %ebx
addl	$0x79622d32, %ecx
addl	$0x6b206574, %edx
addl	0x10(%rsp), %r8d
addl	0x14(%rsp), %r9d
addl	0x18(%rsp), %r10d
addl	0x1c(%rsp), %r11d
addl	0x30(%rsp), %r12d
addl	0x34(%rsp), %r13d
addl	0x38(%rsp), %r14d
addl	0x3c(%rsp), %r15d
paddd	0x20(%rsp), %xmm1
cmpq	$0x40, %rbp
jb	L_320
xorl	(%rsi), %eax
xorl	0x4(%rsi), %ebx
xorl	0x8(%rsi), %ecx
xorl	0xc(%rsi), %edx
xorl	0x10(%rsi), %r8d
xorl	0x14(%rsi), %r9d
xorl	0x18(%rsi), %r10d
xorl	0x1c(%rsi), %r11d
movdqu	0x20(%rsi), %xmm0
xorl	0x30(%rsi), %r12d
xorl	0x34(%rsi), %r13d
xorl	0x38(%rsi), %r14d
xorl	0x3c(%rsi), %r15d
leaq	0x40(%rsi), %rsi
pxor	%xmm1, %xmm0
movdqa	%xmm2, 0x20(%rsp)
movd	%xmm3, 0x30(%rsp)
movl	%eax, (%rdi)
movl	%ebx, 0x4(%rdi)
movl	%ecx, 0x8(%rdi)
movl	%edx, 0xc(%rdi)
movl	%r8d, 0x10(%rdi)
movl	%r9d, 0x14(%rdi)
movl	%r10d, 0x18(%rdi)
movl	%r11d, 0x1c(%rdi)
movdqu	%xmm0, 0x20(%rdi)
movl	%r12d, 0x30(%rdi)
movl	%r13d, 0x34(%rdi)
movl	%r14d, 0x38(%rdi)
movl	%r15d, 0x3c(%rdi)
leaq	0x40(%rdi), %rdi
subq	$0x40, %rbp
jne	L_60
jmp	L_377
nopw	(%rax,%rax)
L_320:
movl	%eax, (%rsp)
movl	%ebx, 0x4(%rsp)
xorq	%rbx, %rbx
movl	%ecx, 0x8(%rsp)
movl	%edx, 0xc(%rsp)
movl	%r8d, 0x10(%rsp)
movl	%r9d, 0x14(%rsp)
movl	%r10d, 0x18(%rsp)
movl	%r11d, 0x1c(%rsp)
movdqa	%xmm1, 0x20(%rsp)
movl	%r12d, 0x30(%rsp)
movl	%r13d, 0x34(%rsp)
movl	%r14d, 0x38(%rsp)
movl	%r15d, 0x3c(%rsp)
L_360:
movzbl	(%rsi,%rbx), %eax
movzbl	(%rsp,%rbx), %edx
leaq	0x1(%rbx), %rbx
xorl	%edx, %eax
movb	%al, -0x1(%rdi,%rbx)
decq	%rbp
jne	L_360
L_377:
leaq	0x88(%rsp), %rsi
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
L_39a:
rep	retq
nopl	(%rax)
ChaCha20_ssse3:
movq	%rsp, %r9
testl	$0x800, %r10d
jne	ChaCha20_4xop
cmpq	$0x80, %rdx
je	ChaCha20_128
ja	ChaCha20_4x
L_3c3:
subq	$0x48, %rsp
movdqa	bums_rodata+448(%rip), %xmm0
movdqu	(%rcx), %xmm1
movdqu	0x10(%rcx), %xmm2
movdqu	(%r8), %xmm3
movdqa	bums_rodata+128(%rip), %xmm6
movdqa	bums_rodata+144(%rip), %xmm7
movdqa	%xmm0, (%rsp)
movdqa	%xmm1, 0x10(%rsp)
movdqa	%xmm2, 0x20(%rsp)
movdqa	%xmm3, 0x30(%rsp)
movq	$0xa, %r8
jmp	L_460
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_420:
movdqa	bums_rodata+16(%rip), %xmm3
movdqa	(%rsp), %xmm0
movdqa	0x10(%rsp), %xmm1
movdqa	0x20(%rsp), %xmm2
paddd	0x30(%rsp), %xmm3
movq	$0xa, %r8
movdqa	%xmm3, 0x30(%rsp)
jmp	L_460
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_460:
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm6, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm4
psrld	$0x14, %xmm1
pslld	$0xc, %xmm4
por	%xmm4, %xmm1
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm7, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm4
psrld	$0x19, %xmm1
pslld	$0x7, %xmm4
por	%xmm4, %xmm1
pshufd	$0x4e, %xmm2, %xmm2
pshufd	$0x39, %xmm1, %xmm1
pshufd	$0x93, %xmm3, %xmm3
nop
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm6, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm4
psrld	$0x14, %xmm1
pslld	$0xc, %xmm4
por	%xmm4, %xmm1
paddd	%xmm1, %xmm0
pxor	%xmm0, %xmm3
pshufb	%xmm7, %xmm3
paddd	%xmm3, %xmm2
pxor	%xmm2, %xmm1
movdqa	%xmm1, %xmm4
psrld	$0x19, %xmm1
pslld	$0x7, %xmm4
por	%xmm4, %xmm1
pshufd	$0x4e, %xmm2, %xmm2
pshufd	$0x93, %xmm1, %xmm1
pshufd	$0x39, %xmm3, %xmm3
decq	%r8
jne	L_460
paddd	(%rsp), %xmm0
paddd	0x10(%rsp), %xmm1
paddd	0x20(%rsp), %xmm2
paddd	0x30(%rsp), %xmm3
cmpq	$0x40, %rdx
jb	L_590
movdqu	(%rsi), %xmm4
movdqu	0x10(%rsi), %xmm5
pxor	%xmm4, %xmm0
movdqu	0x20(%rsi), %xmm4
pxor	%xmm5, %xmm1
movdqu	0x30(%rsi), %xmm5
leaq	0x40(%rsi), %rsi
pxor	%xmm4, %xmm2
pxor	%xmm5, %xmm3
movdqu	%xmm0, (%rdi)
movdqu	%xmm1, 0x10(%rdi)
movdqu	%xmm2, 0x20(%rdi)
movdqu	%xmm3, 0x30(%rdi)
leaq	0x40(%rdi), %rdi
subq	$0x40, %rdx
jne	L_420
jmp	L_5c4
nopl	(%rax,%rax)
L_590:
movdqa	%xmm0, (%rsp)
movdqa	%xmm1, 0x10(%rsp)
movdqa	%xmm2, 0x20(%rsp)
movdqa	%xmm3, 0x30(%rsp)
xorq	%r8, %r8
L_5aa:
movzbl	(%rsi,%r8), %eax
movzbl	(%rsp,%r8), %ecx
leaq	0x1(%r8), %r8
xorl	%ecx, %eax
movb	%al, -0x1(%rdi,%r8)
decq	%rdx
jne	L_5aa
L_5c4:
leaq	(%r9), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
ChaCha20_128:
movq	%rsp, %r9
subq	$0x48, %rsp
movdqa	bums_rodata+448(%rip), %xmm8
movdqu	(%rcx), %xmm9
movdqu	0x10(%rcx), %xmm2
movdqu	(%r8), %xmm3
movdqa	bums_rodata+16(%rip), %xmm1
movdqa	bums_rodata+128(%rip), %xmm6
movdqa	bums_rodata+144(%rip), %xmm7
movdqa	%xmm8, %xmm10
movdqa	%xmm8, (%rsp)
movdqa	%xmm9, %xmm11
movdqa	%xmm9, 0x10(%rsp)
movdqa	%xmm2, %xmm0
movdqa	%xmm2, 0x20(%rsp)
paddd	%xmm3, %xmm1
movdqa	%xmm3, 0x30(%rsp)
movq	$0xa, %r8
jmp	L_660
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_660:
paddd	%xmm9, %xmm8
pxor	%xmm8, %xmm3
paddd	%xmm11, %xmm10
pxor	%xmm10, %xmm1
pshufb	%xmm6, %xmm3
pshufb	%xmm6, %xmm1
paddd	%xmm3, %xmm2
paddd	%xmm1, %xmm0
pxor	%xmm2, %xmm9
pxor	%xmm0, %xmm11
movdqa	%xmm9, %xmm4
psrld	$0x14, %xmm9
movdqa	%xmm11, %xmm5
pslld	$0xc, %xmm4
psrld	$0x14, %xmm11
por	%xmm4, %xmm9
pslld	$0xc, %xmm5
por	%xmm5, %xmm11
paddd	%xmm9, %xmm8
pxor	%xmm8, %xmm3
paddd	%xmm11, %xmm10
pxor	%xmm10, %xmm1
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm1
paddd	%xmm3, %xmm2
paddd	%xmm1, %xmm0
pxor	%xmm2, %xmm9
pxor	%xmm0, %xmm11
movdqa	%xmm9, %xmm4
psrld	$0x19, %xmm9
movdqa	%xmm11, %xmm5
pslld	$0x7, %xmm4
psrld	$0x19, %xmm11
por	%xmm4, %xmm9
pslld	$0x7, %xmm5
por	%xmm5, %xmm11
pshufd	$0x4e, %xmm2, %xmm2
pshufd	$0x39, %xmm9, %xmm9
pshufd	$0x93, %xmm3, %xmm3
pshufd	$0x4e, %xmm0, %xmm0
pshufd	$0x39, %xmm11, %xmm11
pshufd	$0x93, %xmm1, %xmm1
paddd	%xmm9, %xmm8
pxor	%xmm8, %xmm3
paddd	%xmm11, %xmm10
pxor	%xmm10, %xmm1
pshufb	%xmm6, %xmm3
pshufb	%xmm6, %xmm1
paddd	%xmm3, %xmm2
paddd	%xmm1, %xmm0
pxor	%xmm2, %xmm9
pxor	%xmm0, %xmm11
movdqa	%xmm9, %xmm4
psrld	$0x14, %xmm9
movdqa	%xmm11, %xmm5
pslld	$0xc, %xmm4
psrld	$0x14, %xmm11
por	%xmm4, %xmm9
pslld	$0xc, %xmm5
por	%xmm5, %xmm11
paddd	%xmm9, %xmm8
pxor	%xmm8, %xmm3
paddd	%xmm11, %xmm10
pxor	%xmm10, %xmm1
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm1
paddd	%xmm3, %xmm2
paddd	%xmm1, %xmm0
pxor	%xmm2, %xmm9
pxor	%xmm0, %xmm11
movdqa	%xmm9, %xmm4
psrld	$0x19, %xmm9
movdqa	%xmm11, %xmm5
pslld	$0x7, %xmm4
psrld	$0x19, %xmm11
por	%xmm4, %xmm9
pslld	$0x7, %xmm5
por	%xmm5, %xmm11
pshufd	$0x4e, %xmm2, %xmm2
pshufd	$0x93, %xmm9, %xmm9
pshufd	$0x39, %xmm3, %xmm3
pshufd	$0x4e, %xmm0, %xmm0
pshufd	$0x93, %xmm11, %xmm11
pshufd	$0x39, %xmm1, %xmm1
decq	%r8
jne	L_660
paddd	(%rsp), %xmm8
paddd	0x10(%rsp), %xmm9
paddd	0x20(%rsp), %xmm2
paddd	0x30(%rsp), %xmm3
paddd	bums_rodata+16(%rip), %xmm1
paddd	(%rsp), %xmm10
paddd	0x10(%rsp), %xmm11
paddd	0x20(%rsp), %xmm0
paddd	0x30(%rsp), %xmm1
movdqu	(%rsi), %xmm4
movdqu	0x10(%rsi), %xmm5
pxor	%xmm4, %xmm8
movdqu	0x20(%rsi), %xmm4
pxor	%xmm5, %xmm9
movdqu	0x30(%rsi), %xmm5
pxor	%xmm4, %xmm2
movdqu	0x40(%rsi), %xmm4
pxor	%xmm5, %xmm3
movdqu	0x50(%rsi), %xmm5
pxor	%xmm4, %xmm10
movdqu	0x60(%rsi), %xmm4
pxor	%xmm5, %xmm11
movdqu	0x70(%rsi), %xmm5
pxor	%xmm4, %xmm0
pxor	%xmm5, %xmm1
movdqu	%xmm8, (%rdi)
movdqu	%xmm9, 0x10(%rdi)
movdqu	%xmm2, 0x20(%rdi)
movdqu	%xmm3, 0x30(%rdi)
movdqu	%xmm10, 0x40(%rdi)
movdqu	%xmm11, 0x50(%rdi)
movdqu	%xmm0, 0x60(%rdi)
movdqu	%xmm1, 0x70(%rdi)
leaq	(%r9), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
ChaCha20_4x:
movq	%rsp, %r9
movq	%r10, %r11
shrq	$0x20, %r10
testq	$0x20, %r10
jne	ChaCha20_8x
cmpq	$0xc0, %rdx
ja	L_914
andq	$0x4400000, %r11
cmpq	$0x400000, %r11
je	L_3c3
L_914:
subq	$0x148, %rsp
movdqa	bums_rodata+448(%rip), %xmm11
movdqu	(%rcx), %xmm15
movdqu	0x10(%rcx), %xmm7
movdqu	(%r8), %xmm3
leaq	0x100(%rsp), %rcx
leaq	bums_rodata+128(%rip), %r10
leaq	bums_rodata+144(%rip), %r11
pshufd	$0x0, %xmm11, %xmm8
pshufd	$0x55, %xmm11, %xmm9
movdqa	%xmm8, 0x40(%rsp)
pshufd	$0xaa, %xmm11, %xmm10
movdqa	%xmm9, 0x50(%rsp)
pshufd	$0xff, %xmm11, %xmm11
movdqa	%xmm10, 0x60(%rsp)
movdqa	%xmm11, 0x70(%rsp)
pshufd	$0x0, %xmm15, %xmm12
pshufd	$0x55, %xmm15, %xmm13
movdqa	%xmm12, -0x80(%rcx)
pshufd	$0xaa, %xmm15, %xmm14
movdqa	%xmm13, -0x70(%rcx)
pshufd	$0xff, %xmm15, %xmm15
movdqa	%xmm14, -0x60(%rcx)
movdqa	%xmm15, -0x50(%rcx)
pshufd	$0x0, %xmm7, %xmm4
pshufd	$0x55, %xmm7, %xmm5
movdqa	%xmm4, -0x40(%rcx)
pshufd	$0xaa, %xmm7, %xmm6
movdqa	%xmm5, -0x30(%rcx)
pshufd	$0xff, %xmm7, %xmm7
movdqa	%xmm6, -0x20(%rcx)
movdqa	%xmm7, -0x10(%rcx)
pshufd	$0x0, %xmm3, %xmm0
pshufd	$0x55, %xmm3, %xmm1
paddd	bums_rodata+32(%rip), %xmm0
pshufd	$0xaa, %xmm3, %xmm2
movdqa	%xmm1, 0x10(%rcx)
pshufd	$0xff, %xmm3, %xmm3
movdqa	%xmm2, 0x20(%rcx)
movdqa	%xmm3, 0x30(%rcx)
jmp	L_a83
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_a20:
movdqa	0x40(%rsp), %xmm8
movdqa	0x50(%rsp), %xmm9
movdqa	0x60(%rsp), %xmm10
movdqa	0x70(%rsp), %xmm11
movdqa	-0x80(%rcx), %xmm12
movdqa	-0x70(%rcx), %xmm13
movdqa	-0x60(%rcx), %xmm14
movdqa	-0x50(%rcx), %xmm15
movdqa	-0x40(%rcx), %xmm4
movdqa	-0x30(%rcx), %xmm5
movdqa	-0x20(%rcx), %xmm6
movdqa	-0x10(%rcx), %xmm7
movdqa	(%rcx), %xmm0
movdqa	0x10(%rcx), %xmm1
movdqa	0x20(%rcx), %xmm2
movdqa	0x30(%rcx), %xmm3
paddd	bums_rodata+48(%rip), %xmm0
L_a83:
movdqa	%xmm6, 0x20(%rsp)
movdqa	%xmm7, 0x30(%rsp)
movdqa	(%r10), %xmm7
movl	$0xa, %eax
movdqa	%xmm0, (%rcx)
jmp	L_aa0
nop
L_aa0:
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
pxor	%xmm8, %xmm0
pxor	%xmm9, %xmm1
pshufb	%xmm7, %xmm0
pshufb	%xmm7, %xmm1
paddd	%xmm0, %xmm4
paddd	%xmm1, %xmm5
pxor	%xmm4, %xmm12
pxor	%xmm5, %xmm13
movdqa	%xmm12, %xmm6
pslld	$0xc, %xmm12
psrld	$0x14, %xmm6
movdqa	%xmm13, %xmm7
pslld	$0xc, %xmm13
por	%xmm6, %xmm12
psrld	$0x14, %xmm7
movdqa	(%r11), %xmm6
por	%xmm7, %xmm13
paddd	%xmm12, %xmm8
paddd	%xmm13, %xmm9
pxor	%xmm8, %xmm0
pxor	%xmm9, %xmm1
pshufb	%xmm6, %xmm0
pshufb	%xmm6, %xmm1
paddd	%xmm0, %xmm4
paddd	%xmm1, %xmm5
pxor	%xmm4, %xmm12
pxor	%xmm5, %xmm13
movdqa	%xmm12, %xmm7
pslld	$0x7, %xmm12
psrld	$0x19, %xmm7
movdqa	%xmm13, %xmm6
pslld	$0x7, %xmm13
por	%xmm7, %xmm12
psrld	$0x19, %xmm6
movdqa	(%r10), %xmm7
por	%xmm6, %xmm13
movdqa	%xmm4, (%rsp)
movdqa	%xmm5, 0x10(%rsp)
movdqa	0x20(%rsp), %xmm4
movdqa	0x30(%rsp), %xmm5
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm3
pshufb	%xmm7, %xmm2
pshufb	%xmm7, %xmm3
paddd	%xmm2, %xmm4
paddd	%xmm3, %xmm5
pxor	%xmm4, %xmm14
pxor	%xmm5, %xmm15
movdqa	%xmm14, %xmm6
pslld	$0xc, %xmm14
psrld	$0x14, %xmm6
movdqa	%xmm15, %xmm7
pslld	$0xc, %xmm15
por	%xmm6, %xmm14
psrld	$0x14, %xmm7
movdqa	(%r11), %xmm6
por	%xmm7, %xmm15
paddd	%xmm14, %xmm10
paddd	%xmm15, %xmm11
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm3
pshufb	%xmm6, %xmm2
pshufb	%xmm6, %xmm3
paddd	%xmm2, %xmm4
paddd	%xmm3, %xmm5
pxor	%xmm4, %xmm14
pxor	%xmm5, %xmm15
movdqa	%xmm14, %xmm7
pslld	$0x7, %xmm14
psrld	$0x19, %xmm7
movdqa	%xmm15, %xmm6
pslld	$0x7, %xmm15
por	%xmm7, %xmm14
psrld	$0x19, %xmm6
movdqa	(%r10), %xmm7
por	%xmm6, %xmm15
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm8, %xmm3
pxor	%xmm9, %xmm0
pshufb	%xmm7, %xmm3
pshufb	%xmm7, %xmm0
paddd	%xmm3, %xmm4
paddd	%xmm0, %xmm5
pxor	%xmm4, %xmm13
pxor	%xmm5, %xmm14
movdqa	%xmm13, %xmm6
pslld	$0xc, %xmm13
psrld	$0x14, %xmm6
movdqa	%xmm14, %xmm7
pslld	$0xc, %xmm14
por	%xmm6, %xmm13
psrld	$0x14, %xmm7
movdqa	(%r11), %xmm6
por	%xmm7, %xmm14
paddd	%xmm13, %xmm8
paddd	%xmm14, %xmm9
pxor	%xmm8, %xmm3
pxor	%xmm9, %xmm0
pshufb	%xmm6, %xmm3
pshufb	%xmm6, %xmm0
paddd	%xmm3, %xmm4
paddd	%xmm0, %xmm5
pxor	%xmm4, %xmm13
pxor	%xmm5, %xmm14
movdqa	%xmm13, %xmm7
pslld	$0x7, %xmm13
psrld	$0x19, %xmm7
movdqa	%xmm14, %xmm6
pslld	$0x7, %xmm14
por	%xmm7, %xmm13
psrld	$0x19, %xmm6
movdqa	(%r10), %xmm7
por	%xmm6, %xmm14
movdqa	%xmm4, 0x20(%rsp)
movdqa	%xmm5, 0x30(%rsp)
movdqa	(%rsp), %xmm4
movdqa	0x10(%rsp), %xmm5
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
pxor	%xmm10, %xmm1
pxor	%xmm11, %xmm2
pshufb	%xmm7, %xmm1
pshufb	%xmm7, %xmm2
paddd	%xmm1, %xmm4
paddd	%xmm2, %xmm5
pxor	%xmm4, %xmm15
pxor	%xmm5, %xmm12
movdqa	%xmm15, %xmm6
pslld	$0xc, %xmm15
psrld	$0x14, %xmm6
movdqa	%xmm12, %xmm7
pslld	$0xc, %xmm12
por	%xmm6, %xmm15
psrld	$0x14, %xmm7
movdqa	(%r11), %xmm6
por	%xmm7, %xmm12
paddd	%xmm15, %xmm10
paddd	%xmm12, %xmm11
pxor	%xmm10, %xmm1
pxor	%xmm11, %xmm2
pshufb	%xmm6, %xmm1
pshufb	%xmm6, %xmm2
paddd	%xmm1, %xmm4
paddd	%xmm2, %xmm5
pxor	%xmm4, %xmm15
pxor	%xmm5, %xmm12
movdqa	%xmm15, %xmm7
pslld	$0x7, %xmm15
psrld	$0x19, %xmm7
movdqa	%xmm12, %xmm6
pslld	$0x7, %xmm12
por	%xmm7, %xmm15
psrld	$0x19, %xmm6
movdqa	(%r10), %xmm7
por	%xmm6, %xmm12
decl	%eax
jne	L_aa0
paddd	0x40(%rsp), %xmm8
paddd	0x50(%rsp), %xmm9
paddd	0x60(%rsp), %xmm10
paddd	0x70(%rsp), %xmm11
movdqa	%xmm8, %xmm6
punpckldq	%xmm9, %xmm8
movdqa	%xmm10, %xmm7
punpckldq	%xmm11, %xmm10
punpckhdq	%xmm9, %xmm6
punpckhdq	%xmm11, %xmm7
movdqa	%xmm8, %xmm9
punpcklqdq	%xmm10, %xmm8
movdqa	%xmm6, %xmm11
punpcklqdq	%xmm7, %xmm6
punpckhqdq	%xmm10, %xmm9
punpckhqdq	%xmm7, %xmm11
paddd	-0x80(%rcx), %xmm12
paddd	-0x70(%rcx), %xmm13
paddd	-0x60(%rcx), %xmm14
paddd	-0x50(%rcx), %xmm15
movdqa	%xmm8, (%rsp)
movdqa	%xmm9, 0x10(%rsp)
movdqa	0x20(%rsp), %xmm8
movdqa	0x30(%rsp), %xmm9
movdqa	%xmm12, %xmm10
punpckldq	%xmm13, %xmm12
movdqa	%xmm14, %xmm7
punpckldq	%xmm15, %xmm14
punpckhdq	%xmm13, %xmm10
punpckhdq	%xmm15, %xmm7
movdqa	%xmm12, %xmm13
punpcklqdq	%xmm14, %xmm12
movdqa	%xmm10, %xmm15
punpcklqdq	%xmm7, %xmm10
punpckhqdq	%xmm14, %xmm13
punpckhqdq	%xmm7, %xmm15
paddd	-0x40(%rcx), %xmm4
paddd	-0x30(%rcx), %xmm5
paddd	-0x20(%rcx), %xmm8
paddd	-0x10(%rcx), %xmm9
movdqa	%xmm6, 0x20(%rsp)
movdqa	%xmm11, 0x30(%rsp)
movdqa	%xmm4, %xmm14
punpckldq	%xmm5, %xmm4
movdqa	%xmm8, %xmm7
punpckldq	%xmm9, %xmm8
punpckhdq	%xmm5, %xmm14
punpckhdq	%xmm9, %xmm7
movdqa	%xmm4, %xmm5
punpcklqdq	%xmm8, %xmm4
movdqa	%xmm14, %xmm9
punpcklqdq	%xmm7, %xmm14
punpckhqdq	%xmm8, %xmm5
punpckhqdq	%xmm7, %xmm9
paddd	(%rcx), %xmm0
paddd	0x10(%rcx), %xmm1
paddd	0x20(%rcx), %xmm2
paddd	0x30(%rcx), %xmm3
movdqa	%xmm0, %xmm8
punpckldq	%xmm1, %xmm0
movdqa	%xmm2, %xmm7
punpckldq	%xmm3, %xmm2
punpckhdq	%xmm1, %xmm8
punpckhdq	%xmm3, %xmm7
movdqa	%xmm0, %xmm1
punpcklqdq	%xmm2, %xmm0
movdqa	%xmm8, %xmm3
punpcklqdq	%xmm7, %xmm8
punpckhqdq	%xmm2, %xmm1
punpckhqdq	%xmm7, %xmm3
cmpq	$0x100, %rdx
jb	L_1065
movdqu	(%rsi), %xmm6
movdqu	0x10(%rsi), %xmm11
movdqu	0x20(%rsi), %xmm2
movdqu	0x30(%rsi), %xmm7
pxor	(%rsp), %xmm6
pxor	%xmm12, %xmm11
pxor	%xmm4, %xmm2
pxor	%xmm0, %xmm7
movdqu	%xmm6, (%rdi)
movdqu	0x40(%rsi), %xmm6
movdqu	%xmm11, 0x10(%rdi)
movdqu	0x50(%rsi), %xmm11
movdqu	%xmm2, 0x20(%rdi)
movdqu	0x60(%rsi), %xmm2
movdqu	%xmm7, 0x30(%rdi)
movdqu	0x70(%rsi), %xmm7
leaq	0x80(%rsi), %rsi
pxor	0x10(%rsp), %xmm6
pxor	%xmm13, %xmm11
pxor	%xmm5, %xmm2
pxor	%xmm1, %xmm7
movdqu	%xmm6, 0x40(%rdi)
movdqu	(%rsi), %xmm6
movdqu	%xmm11, 0x50(%rdi)
movdqu	0x10(%rsi), %xmm11
movdqu	%xmm2, 0x60(%rdi)
movdqu	0x20(%rsi), %xmm2
movdqu	%xmm7, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
movdqu	0x30(%rsi), %xmm7
pxor	0x20(%rsp), %xmm6
pxor	%xmm10, %xmm11
pxor	%xmm14, %xmm2
pxor	%xmm8, %xmm7
movdqu	%xmm6, (%rdi)
movdqu	0x40(%rsi), %xmm6
movdqu	%xmm11, 0x10(%rdi)
movdqu	0x50(%rsi), %xmm11
movdqu	%xmm2, 0x20(%rdi)
movdqu	0x60(%rsi), %xmm2
movdqu	%xmm7, 0x30(%rdi)
movdqu	0x70(%rsi), %xmm7
leaq	0x80(%rsi), %rsi
pxor	0x30(%rsp), %xmm6
pxor	%xmm15, %xmm11
pxor	%xmm9, %xmm2
pxor	%xmm3, %xmm7
movdqu	%xmm6, 0x40(%rdi)
movdqu	%xmm11, 0x50(%rdi)
movdqu	%xmm2, 0x60(%rdi)
movdqu	%xmm7, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
subq	$0x100, %rdx
jne	L_a20
jmp	L_12ef
L_1065:
cmpq	$0xc0, %rdx
jae	L_11e0
cmpq	$0x80, %rdx
jae	L_1120
cmpq	$0x40, %rdx
jae	L_10a0
xorq	%r10, %r10
movdqa	%xmm12, 0x10(%rsp)
movdqa	%xmm4, 0x20(%rsp)
movdqa	%xmm0, 0x30(%rsp)
jmp	L_12d5
L_10a0:
movdqu	(%rsi), %xmm6
movdqu	0x10(%rsi), %xmm11
movdqu	0x20(%rsi), %xmm2
movdqu	0x30(%rsi), %xmm7
pxor	(%rsp), %xmm6
pxor	%xmm12, %xmm11
pxor	%xmm4, %xmm2
pxor	%xmm0, %xmm7
movdqu	%xmm6, (%rdi)
movdqu	%xmm11, 0x10(%rdi)
movdqu	%xmm2, 0x20(%rdi)
movdqu	%xmm7, 0x30(%rdi)
je	L_12ef
movdqa	0x10(%rsp), %xmm6
leaq	0x40(%rsi), %rsi
xorq	%r10, %r10
movdqa	%xmm6, (%rsp)
movdqa	%xmm13, 0x10(%rsp)
leaq	0x40(%rdi), %rdi
movdqa	%xmm5, 0x20(%rsp)
subq	$0x40, %rdx
movdqa	%xmm1, 0x30(%rsp)
jmp	L_12d5
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1120:
movdqu	(%rsi), %xmm6
movdqu	0x10(%rsi), %xmm11
movdqu	0x20(%rsi), %xmm2
movdqu	0x30(%rsi), %xmm7
pxor	(%rsp), %xmm6
pxor	%xmm12, %xmm11
pxor	%xmm4, %xmm2
pxor	%xmm0, %xmm7
movdqu	%xmm6, (%rdi)
movdqu	0x40(%rsi), %xmm6
movdqu	%xmm11, 0x10(%rdi)
movdqu	0x50(%rsi), %xmm11
movdqu	%xmm2, 0x20(%rdi)
movdqu	0x60(%rsi), %xmm2
movdqu	%xmm7, 0x30(%rdi)
movdqu	0x70(%rsi), %xmm7
pxor	0x10(%rsp), %xmm6
pxor	%xmm13, %xmm11
pxor	%xmm5, %xmm2
pxor	%xmm1, %xmm7
movdqu	%xmm6, 0x40(%rdi)
movdqu	%xmm11, 0x50(%rdi)
movdqu	%xmm2, 0x60(%rdi)
movdqu	%xmm7, 0x70(%rdi)
je	L_12ef
movdqa	0x20(%rsp), %xmm6
leaq	0x80(%rsi), %rsi
xorq	%r10, %r10
movdqa	%xmm6, (%rsp)
movdqa	%xmm10, 0x10(%rsp)
leaq	0x80(%rdi), %rdi
movdqa	%xmm14, 0x20(%rsp)
subq	$0x80, %rdx
movdqa	%xmm8, 0x30(%rsp)
jmp	L_12d5
nopw	(%rax,%rax)
L_11e0:
movdqu	(%rsi), %xmm6
movdqu	0x10(%rsi), %xmm11
movdqu	0x20(%rsi), %xmm2
movdqu	0x30(%rsi), %xmm7
pxor	(%rsp), %xmm6
pxor	%xmm12, %xmm11
pxor	%xmm4, %xmm2
pxor	%xmm0, %xmm7
movdqu	%xmm6, (%rdi)
movdqu	0x40(%rsi), %xmm6
movdqu	%xmm11, 0x10(%rdi)
movdqu	0x50(%rsi), %xmm11
movdqu	%xmm2, 0x20(%rdi)
movdqu	0x60(%rsi), %xmm2
movdqu	%xmm7, 0x30(%rdi)
movdqu	0x70(%rsi), %xmm7
leaq	0x80(%rsi), %rsi
pxor	0x10(%rsp), %xmm6
pxor	%xmm13, %xmm11
pxor	%xmm5, %xmm2
pxor	%xmm1, %xmm7
movdqu	%xmm6, 0x40(%rdi)
movdqu	(%rsi), %xmm6
movdqu	%xmm11, 0x50(%rdi)
movdqu	0x10(%rsi), %xmm11
movdqu	%xmm2, 0x60(%rdi)
movdqu	0x20(%rsi), %xmm2
movdqu	%xmm7, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
movdqu	0x30(%rsi), %xmm7
pxor	0x20(%rsp), %xmm6
pxor	%xmm10, %xmm11
pxor	%xmm14, %xmm2
pxor	%xmm8, %xmm7
movdqu	%xmm6, (%rdi)
movdqu	%xmm11, 0x10(%rdi)
movdqu	%xmm2, 0x20(%rdi)
movdqu	%xmm7, 0x30(%rdi)
je	L_12ef
movdqa	0x30(%rsp), %xmm6
leaq	0x40(%rsi), %rsi
xorq	%r10, %r10
movdqa	%xmm6, (%rsp)
movdqa	%xmm15, 0x10(%rsp)
leaq	0x40(%rdi), %rdi
movdqa	%xmm9, 0x20(%rsp)
subq	$0xc0, %rdx
movdqa	%xmm3, 0x30(%rsp)
L_12d5:
movzbl	(%rsi,%r10), %eax
movzbl	(%rsp,%r10), %ecx
leaq	0x1(%r10), %r10
xorl	%ecx, %eax
movb	%al, -0x1(%rdi,%r10)
decq	%rdx
jne	L_12d5
L_12ef:
leaq	(%r9), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nop
ChaCha20_4xop:
movq	%rsp, %r9
subq	$0x148, %rsp
vzeroupper
vmovdqa	bums_rodata+448(%rip), %xmm11
vmovdqu	(%rcx), %xmm3
vmovdqu	0x10(%rcx), %xmm15
vmovdqu	(%r8), %xmm7
leaq	0x100(%rsp), %rcx
vpshufd	$0x0, %xmm11, %xmm8
vpshufd	$0x55, %xmm11, %xmm9
vmovdqa	%xmm8, 0x40(%rsp)
vpshufd	$0xaa, %xmm11, %xmm10
vmovdqa	%xmm9, 0x50(%rsp)
vpshufd	$0xff, %xmm11, %xmm11
vmovdqa	%xmm10, 0x60(%rsp)
vmovdqa	%xmm11, 0x70(%rsp)
vpshufd	$0x0, %xmm3, %xmm0
vpshufd	$0x55, %xmm3, %xmm1
vmovdqa	%xmm0, -0x80(%rcx)
vpshufd	$0xaa, %xmm3, %xmm2
vmovdqa	%xmm1, -0x70(%rcx)
vpshufd	$0xff, %xmm3, %xmm3
vmovdqa	%xmm2, -0x60(%rcx)
vmovdqa	%xmm3, -0x50(%rcx)
vpshufd	$0x0, %xmm15, %xmm12
vpshufd	$0x55, %xmm15, %xmm13
vmovdqa	%xmm12, -0x40(%rcx)
vpshufd	$0xaa, %xmm15, %xmm14
vmovdqa	%xmm13, -0x30(%rcx)
vpshufd	$0xff, %xmm15, %xmm15
vmovdqa	%xmm14, -0x20(%rcx)
vmovdqa	%xmm15, -0x10(%rcx)
vpshufd	$0x0, %xmm7, %xmm4
vpshufd	$0x55, %xmm7, %xmm5
vpaddd	bums_rodata+32(%rip), %xmm4, %xmm4
vpshufd	$0xaa, %xmm7, %xmm6
vmovdqa	%xmm5, 0x10(%rcx)
vpshufd	$0xff, %xmm7, %xmm7
vmovdqa	%xmm6, 0x20(%rcx)
vmovdqa	%xmm7, 0x30(%rcx)
jmp	L_143b
nopl	(%rax)
L_13e0:
vmovdqa	0x40(%rsp), %xmm8
vmovdqa	0x50(%rsp), %xmm9
vmovdqa	0x60(%rsp), %xmm10
vmovdqa	0x70(%rsp), %xmm11
vmovdqa	-0x80(%rcx), %xmm0
vmovdqa	-0x70(%rcx), %xmm1
vmovdqa	-0x60(%rcx), %xmm2
vmovdqa	-0x50(%rcx), %xmm3
vmovdqa	-0x40(%rcx), %xmm12
vmovdqa	-0x30(%rcx), %xmm13
vmovdqa	-0x20(%rcx), %xmm14
vmovdqa	-0x10(%rcx), %xmm15
vmovdqa	(%rcx), %xmm4
vmovdqa	0x10(%rcx), %xmm5
vmovdqa	0x20(%rcx), %xmm6
vmovdqa	0x30(%rcx), %xmm7
vpaddd	bums_rodata+48(%rip), %xmm4, %xmm4
L_143b:
movl	$0xa, %eax
vmovdqa	%xmm4, (%rcx)
jmp	L_1460
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_1460:
vpaddd	%xmm0, %xmm8, %xmm8
vpaddd	%xmm1, %xmm9, %xmm9
vpaddd	%xmm2, %xmm10, %xmm10
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	%xmm4, %xmm8, %xmm4
vpxor	%xmm5, %xmm9, %xmm5
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm7, %xmm11, %xmm7
vprotd	$0x10, %xmm4, %xmm4
vprotd	$0x10, %xmm5, %xmm5
vprotd	$0x10, %xmm6, %xmm6
vprotd	$0x10, %xmm7, %xmm7
vpaddd	%xmm4, %xmm12, %xmm12
vpaddd	%xmm5, %xmm13, %xmm13
vpaddd	%xmm6, %xmm14, %xmm14
vpaddd	%xmm7, %xmm15, %xmm15
vpxor	%xmm0, %xmm12, %xmm0
vpxor	%xmm1, %xmm13, %xmm1
vpxor	%xmm2, %xmm14, %xmm2
vpxor	%xmm3, %xmm15, %xmm3
vprotd	$0xc, %xmm0, %xmm0
vprotd	$0xc, %xmm1, %xmm1
vprotd	$0xc, %xmm2, %xmm2
vprotd	$0xc, %xmm3, %xmm3
vpaddd	%xmm0, %xmm8, %xmm8
vpaddd	%xmm1, %xmm9, %xmm9
vpaddd	%xmm2, %xmm10, %xmm10
vpaddd	%xmm3, %xmm11, %xmm11
vpxor	%xmm4, %xmm8, %xmm4
vpxor	%xmm5, %xmm9, %xmm5
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm7, %xmm11, %xmm7
vprotd	$0x8, %xmm4, %xmm4
vprotd	$0x8, %xmm5, %xmm5
vprotd	$0x8, %xmm6, %xmm6
vprotd	$0x8, %xmm7, %xmm7
vpaddd	%xmm4, %xmm12, %xmm12
vpaddd	%xmm5, %xmm13, %xmm13
vpaddd	%xmm6, %xmm14, %xmm14
vpaddd	%xmm7, %xmm15, %xmm15
vpxor	%xmm0, %xmm12, %xmm0
vpxor	%xmm1, %xmm13, %xmm1
vpxor	%xmm2, %xmm14, %xmm2
vpxor	%xmm3, %xmm15, %xmm3
vprotd	$0x7, %xmm0, %xmm0
vprotd	$0x7, %xmm1, %xmm1
vprotd	$0x7, %xmm2, %xmm2
vprotd	$0x7, %xmm3, %xmm3
vpaddd	%xmm1, %xmm8, %xmm8
vpaddd	%xmm2, %xmm9, %xmm9
vpaddd	%xmm3, %xmm10, %xmm10
vpaddd	%xmm0, %xmm11, %xmm11
vpxor	%xmm7, %xmm8, %xmm7
vpxor	%xmm4, %xmm9, %xmm4
vpxor	%xmm5, %xmm10, %xmm5
vpxor	%xmm6, %xmm11, %xmm6
vprotd	$0x10, %xmm7, %xmm7
vprotd	$0x10, %xmm4, %xmm4
vprotd	$0x10, %xmm5, %xmm5
vprotd	$0x10, %xmm6, %xmm6
vpaddd	%xmm7, %xmm14, %xmm14
vpaddd	%xmm4, %xmm15, %xmm15
vpaddd	%xmm5, %xmm12, %xmm12
vpaddd	%xmm6, %xmm13, %xmm13
vpxor	%xmm1, %xmm14, %xmm1
vpxor	%xmm2, %xmm15, %xmm2
vpxor	%xmm3, %xmm12, %xmm3
vpxor	%xmm0, %xmm13, %xmm0
vprotd	$0xc, %xmm1, %xmm1
vprotd	$0xc, %xmm2, %xmm2
vprotd	$0xc, %xmm3, %xmm3
vprotd	$0xc, %xmm0, %xmm0
vpaddd	%xmm1, %xmm8, %xmm8
vpaddd	%xmm2, %xmm9, %xmm9
vpaddd	%xmm3, %xmm10, %xmm10
vpaddd	%xmm0, %xmm11, %xmm11
vpxor	%xmm7, %xmm8, %xmm7
vpxor	%xmm4, %xmm9, %xmm4
vpxor	%xmm5, %xmm10, %xmm5
vpxor	%xmm6, %xmm11, %xmm6
vprotd	$0x8, %xmm7, %xmm7
vprotd	$0x8, %xmm4, %xmm4
vprotd	$0x8, %xmm5, %xmm5
vprotd	$0x8, %xmm6, %xmm6
vpaddd	%xmm7, %xmm14, %xmm14
vpaddd	%xmm4, %xmm15, %xmm15
vpaddd	%xmm5, %xmm12, %xmm12
vpaddd	%xmm6, %xmm13, %xmm13
vpxor	%xmm1, %xmm14, %xmm1
vpxor	%xmm2, %xmm15, %xmm2
vpxor	%xmm3, %xmm12, %xmm3
vpxor	%xmm0, %xmm13, %xmm0
vprotd	$0x7, %xmm1, %xmm1
vprotd	$0x7, %xmm2, %xmm2
vprotd	$0x7, %xmm3, %xmm3
vprotd	$0x7, %xmm0, %xmm0
decl	%eax
jne	L_1460
vpaddd	0x40(%rsp), %xmm8, %xmm8
vpaddd	0x50(%rsp), %xmm9, %xmm9
vpaddd	0x60(%rsp), %xmm10, %xmm10
vpaddd	0x70(%rsp), %xmm11, %xmm11
vmovdqa	%xmm14, 0x20(%rsp)
vmovdqa	%xmm15, 0x30(%rsp)
vpunpckldq	%xmm9, %xmm8, %xmm14
vpunpckldq	%xmm11, %xmm10, %xmm15
vpunpckhdq	%xmm9, %xmm8, %xmm8
vpunpckhdq	%xmm11, %xmm10, %xmm10
vpunpcklqdq	%xmm15, %xmm14, %xmm9
vpunpckhqdq	%xmm15, %xmm14, %xmm14
vpunpcklqdq	%xmm10, %xmm8, %xmm11
vpunpckhqdq	%xmm10, %xmm8, %xmm8
vpaddd	-0x80(%rcx), %xmm0, %xmm0
vpaddd	-0x70(%rcx), %xmm1, %xmm1
vpaddd	-0x60(%rcx), %xmm2, %xmm2
vpaddd	-0x50(%rcx), %xmm3, %xmm3
vmovdqa	%xmm9, (%rsp)
vmovdqa	%xmm14, 0x10(%rsp)
vmovdqa	0x20(%rsp), %xmm9
vmovdqa	0x30(%rsp), %xmm14
vpunpckldq	%xmm1, %xmm0, %xmm10
vpunpckldq	%xmm3, %xmm2, %xmm15
vpunpckhdq	%xmm1, %xmm0, %xmm0
vpunpckhdq	%xmm3, %xmm2, %xmm2
vpunpcklqdq	%xmm15, %xmm10, %xmm1
vpunpckhqdq	%xmm15, %xmm10, %xmm10
vpunpcklqdq	%xmm2, %xmm0, %xmm3
vpunpckhqdq	%xmm2, %xmm0, %xmm0
vpaddd	-0x40(%rcx), %xmm12, %xmm12
vpaddd	-0x30(%rcx), %xmm13, %xmm13
vpaddd	-0x20(%rcx), %xmm9, %xmm9
vpaddd	-0x10(%rcx), %xmm14, %xmm14
vpunpckldq	%xmm13, %xmm12, %xmm2
vpunpckldq	%xmm14, %xmm9, %xmm15
vpunpckhdq	%xmm13, %xmm12, %xmm12
vpunpckhdq	%xmm14, %xmm9, %xmm9
vpunpcklqdq	%xmm15, %xmm2, %xmm13
vpunpckhqdq	%xmm15, %xmm2, %xmm2
vpunpcklqdq	%xmm9, %xmm12, %xmm14
vpunpckhqdq	%xmm9, %xmm12, %xmm12
vpaddd	(%rcx), %xmm4, %xmm4
vpaddd	0x10(%rcx), %xmm5, %xmm5
vpaddd	0x20(%rcx), %xmm6, %xmm6
vpaddd	0x30(%rcx), %xmm7, %xmm7
vpunpckldq	%xmm5, %xmm4, %xmm9
vpunpckldq	%xmm7, %xmm6, %xmm15
vpunpckhdq	%xmm5, %xmm4, %xmm4
vpunpckhdq	%xmm7, %xmm6, %xmm6
vpunpcklqdq	%xmm15, %xmm9, %xmm5
vpunpckhqdq	%xmm15, %xmm9, %xmm9
vpunpcklqdq	%xmm6, %xmm4, %xmm7
vpunpckhqdq	%xmm6, %xmm4, %xmm4
vmovdqa	(%rsp), %xmm6
vmovdqa	0x10(%rsp), %xmm15
cmpq	$0x100, %rdx
jb	L_1820
vpxor	(%rsi), %xmm6, %xmm6
vpxor	0x10(%rsi), %xmm1, %xmm1
vpxor	0x20(%rsi), %xmm13, %xmm13
vpxor	0x30(%rsi), %xmm5, %xmm5
vpxor	0x40(%rsi), %xmm15, %xmm15
vpxor	0x50(%rsi), %xmm10, %xmm10
vpxor	0x60(%rsi), %xmm2, %xmm2
vpxor	0x70(%rsi), %xmm9, %xmm9
leaq	0x80(%rsi), %rsi
vpxor	(%rsi), %xmm11, %xmm11
vpxor	0x10(%rsi), %xmm3, %xmm3
vpxor	0x20(%rsi), %xmm14, %xmm14
vpxor	0x30(%rsi), %xmm7, %xmm7
vpxor	0x40(%rsi), %xmm8, %xmm8
vpxor	0x50(%rsi), %xmm0, %xmm0
vpxor	0x60(%rsi), %xmm12, %xmm12
vpxor	0x70(%rsi), %xmm4, %xmm4
leaq	0x80(%rsi), %rsi
vmovdqu	%xmm6, (%rdi)
vmovdqu	%xmm1, 0x10(%rdi)
vmovdqu	%xmm13, 0x20(%rdi)
vmovdqu	%xmm5, 0x30(%rdi)
vmovdqu	%xmm15, 0x40(%rdi)
vmovdqu	%xmm10, 0x50(%rdi)
vmovdqu	%xmm2, 0x60(%rdi)
vmovdqu	%xmm9, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
vmovdqu	%xmm11, (%rdi)
vmovdqu	%xmm3, 0x10(%rdi)
vmovdqu	%xmm14, 0x20(%rdi)
vmovdqu	%xmm7, 0x30(%rdi)
vmovdqu	%xmm8, 0x40(%rdi)
vmovdqu	%xmm0, 0x50(%rdi)
vmovdqu	%xmm12, 0x60(%rdi)
vmovdqu	%xmm4, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
subq	$0x100, %rdx
jne	L_13e0
jmp	L_1a27
nopw	%cs:(%rax,%rax)
nop
L_1820:
cmpq	$0xc0, %rdx
jae	L_1960
cmpq	$0x80, %rdx
jae	L_18c0
cmpq	$0x40, %rdx
jae	L_1860
xorq	%r10, %r10
vmovdqa	%xmm6, (%rsp)
vmovdqa	%xmm1, 0x10(%rsp)
vmovdqa	%xmm13, 0x20(%rsp)
vmovdqa	%xmm5, 0x30(%rsp)
jmp	L_1a0d
nop
L_1860:
vpxor	(%rsi), %xmm6, %xmm6
vpxor	0x10(%rsi), %xmm1, %xmm1
vpxor	0x20(%rsi), %xmm13, %xmm13
vpxor	0x30(%rsi), %xmm5, %xmm5
vmovdqu	%xmm6, (%rdi)
vmovdqu	%xmm1, 0x10(%rdi)
vmovdqu	%xmm13, 0x20(%rdi)
vmovdqu	%xmm5, 0x30(%rdi)
je	L_1a27
leaq	0x40(%rsi), %rsi
vmovdqa	%xmm15, (%rsp)
xorq	%r10, %r10
vmovdqa	%xmm10, 0x10(%rsp)
leaq	0x40(%rdi), %rdi
vmovdqa	%xmm2, 0x20(%rsp)
subq	$0x40, %rdx
vmovdqa	%xmm9, 0x30(%rsp)
jmp	L_1a0d
nopw	(%rax,%rax)
L_18c0:
vpxor	(%rsi), %xmm6, %xmm6
vpxor	0x10(%rsi), %xmm1, %xmm1
vpxor	0x20(%rsi), %xmm13, %xmm13
vpxor	0x30(%rsi), %xmm5, %xmm5
vpxor	0x40(%rsi), %xmm15, %xmm15
vpxor	0x50(%rsi), %xmm10, %xmm10
vpxor	0x60(%rsi), %xmm2, %xmm2
vpxor	0x70(%rsi), %xmm9, %xmm9
vmovdqu	%xmm6, (%rdi)
vmovdqu	%xmm1, 0x10(%rdi)
vmovdqu	%xmm13, 0x20(%rdi)
vmovdqu	%xmm5, 0x30(%rdi)
vmovdqu	%xmm15, 0x40(%rdi)
vmovdqu	%xmm10, 0x50(%rdi)
vmovdqu	%xmm2, 0x60(%rdi)
vmovdqu	%xmm9, 0x70(%rdi)
je	L_1a27
leaq	0x80(%rsi), %rsi
vmovdqa	%xmm11, (%rsp)
xorq	%r10, %r10
vmovdqa	%xmm3, 0x10(%rsp)
leaq	0x80(%rdi), %rdi
vmovdqa	%xmm14, 0x20(%rsp)
subq	$0x80, %rdx
vmovdqa	%xmm7, 0x30(%rsp)
jmp	L_1a0d
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1960:
vpxor	(%rsi), %xmm6, %xmm6
vpxor	0x10(%rsi), %xmm1, %xmm1
vpxor	0x20(%rsi), %xmm13, %xmm13
vpxor	0x30(%rsi), %xmm5, %xmm5
vpxor	0x40(%rsi), %xmm15, %xmm15
vpxor	0x50(%rsi), %xmm10, %xmm10
vpxor	0x60(%rsi), %xmm2, %xmm2
vpxor	0x70(%rsi), %xmm9, %xmm9
leaq	0x80(%rsi), %rsi
vpxor	(%rsi), %xmm11, %xmm11
vpxor	0x10(%rsi), %xmm3, %xmm3
vpxor	0x20(%rsi), %xmm14, %xmm14
vpxor	0x30(%rsi), %xmm7, %xmm7
vmovdqu	%xmm6, (%rdi)
vmovdqu	%xmm1, 0x10(%rdi)
vmovdqu	%xmm13, 0x20(%rdi)
vmovdqu	%xmm5, 0x30(%rdi)
vmovdqu	%xmm15, 0x40(%rdi)
vmovdqu	%xmm10, 0x50(%rdi)
vmovdqu	%xmm2, 0x60(%rdi)
vmovdqu	%xmm9, 0x70(%rdi)
leaq	0x80(%rdi), %rdi
vmovdqu	%xmm11, (%rdi)
vmovdqu	%xmm3, 0x10(%rdi)
vmovdqu	%xmm14, 0x20(%rdi)
vmovdqu	%xmm7, 0x30(%rdi)
je	L_1a27
leaq	0x40(%rsi), %rsi
vmovdqa	%xmm8, (%rsp)
xorq	%r10, %r10
vmovdqa	%xmm0, 0x10(%rsp)
leaq	0x40(%rdi), %rdi
vmovdqa	%xmm12, 0x20(%rsp)
subq	$0xc0, %rdx
vmovdqa	%xmm4, 0x30(%rsp)
L_1a0d:
movzbl	(%rsi,%r10), %eax
movzbl	(%rsp,%r10), %ecx
leaq	0x1(%r10), %r10
xorl	%ecx, %eax
movb	%al, -0x1(%rdi,%r10)
decq	%rdx
jne	L_1a0d
L_1a27:
vzeroupper
leaq	(%r9), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
ChaCha20_8x:
movq	%rsp, %r9
subq	$0x288, %rsp
andq	$-0x20, %rsp
vzeroupper
vbroadcasti128	bums_rodata+448(%rip), %ymm11
vbroadcasti128	(%rcx), %ymm3
vbroadcasti128	0x10(%rcx), %ymm15
vbroadcasti128	(%r8), %ymm7
leaq	0x100(%rsp), %rcx
leaq	0x200(%rsp), %rax
leaq	bums_rodata+128(%rip), %r10
leaq	bums_rodata+144(%rip), %r11
vpshufd	$0x0, %ymm11, %ymm8
vpshufd	$0x55, %ymm11, %ymm9
vmovdqa	%ymm8, -0x80(%rcx)
vpshufd	$0xaa, %ymm11, %ymm10
vmovdqa	%ymm9, -0x60(%rcx)
vpshufd	$0xff, %ymm11, %ymm11
vmovdqa	%ymm10, -0x40(%rcx)
vmovdqa	%ymm11, -0x20(%rcx)
vpshufd	$0x0, %ymm3, %ymm0
vpshufd	$0x55, %ymm3, %ymm1
vmovdqa	%ymm0, (%rcx)
vpshufd	$0xaa, %ymm3, %ymm2
vmovdqa	%ymm1, 0x20(%rcx)
vpshufd	$0xff, %ymm3, %ymm3
vmovdqa	%ymm2, 0x40(%rcx)
vmovdqa	%ymm3, 0x60(%rcx)
vpshufd	$0x0, %ymm15, %ymm12
vpshufd	$0x55, %ymm15, %ymm13
vmovdqa	%ymm12, -0x80(%rax)
vpshufd	$0xaa, %ymm15, %ymm14
vmovdqa	%ymm13, -0x60(%rax)
vpshufd	$0xff, %ymm15, %ymm15
vmovdqa	%ymm14, -0x40(%rax)
vmovdqa	%ymm15, -0x20(%rax)
vpshufd	$0x0, %ymm7, %ymm4
vpshufd	$0x55, %ymm7, %ymm5
vpaddd	bums_rodata+64(%rip), %ymm4, %ymm4
vpshufd	$0xaa, %ymm7, %ymm6
vmovdqa	%ymm5, 0x20(%rax)
vpshufd	$0xff, %ymm7, %ymm7
vmovdqa	%ymm6, 0x40(%rax)
vmovdqa	%ymm7, 0x60(%rax)
jmp	L_1b96
nopw	%cs:(%rax,%rax)
nop
L_1b40:
vmovdqa	-0x80(%rcx), %ymm8
vmovdqa	-0x60(%rcx), %ymm9
vmovdqa	-0x40(%rcx), %ymm10
vmovdqa	-0x20(%rcx), %ymm11
vmovdqa	(%rcx), %ymm0
vmovdqa	0x20(%rcx), %ymm1
vmovdqa	0x40(%rcx), %ymm2
vmovdqa	0x60(%rcx), %ymm3
vmovdqa	-0x80(%rax), %ymm12
vmovdqa	-0x60(%rax), %ymm13
vmovdqa	-0x40(%rax), %ymm14
vmovdqa	-0x20(%rax), %ymm15
vmovdqa	(%rax), %ymm4
vmovdqa	0x20(%rax), %ymm5
vmovdqa	0x40(%rax), %ymm6
vmovdqa	0x60(%rax), %ymm7
vpaddd	bums_rodata+96(%rip), %ymm4, %ymm4
L_1b96:
vmovdqa	%ymm14, 0x40(%rsp)
vmovdqa	%ymm15, 0x60(%rsp)
vbroadcasti128	(%r10), %ymm15
vmovdqa	%ymm4, (%rax)
movl	$0xa, %eax
jmp	L_1bc0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1bc0:
vpaddd	%ymm0, %ymm8, %ymm8
vpxor	%ymm4, %ymm8, %ymm4
vpshufb	%ymm15, %ymm4, %ymm4
vpaddd	%ymm1, %ymm9, %ymm9
vpxor	%ymm5, %ymm9, %ymm5
vpshufb	%ymm15, %ymm5, %ymm5
vpaddd	%ymm4, %ymm12, %ymm12
vpxor	%ymm0, %ymm12, %ymm0
vpslld	$0xc, %ymm0, %ymm14
vpsrld	$0x14, %ymm0, %ymm0
vpor	%ymm0, %ymm14, %ymm0
vbroadcasti128	(%r11), %ymm14
vpaddd	%ymm5, %ymm13, %ymm13
vpxor	%ymm1, %ymm13, %ymm1
vpslld	$0xc, %ymm1, %ymm15
vpsrld	$0x14, %ymm1, %ymm1
vpor	%ymm1, %ymm15, %ymm1
vpaddd	%ymm0, %ymm8, %ymm8
vpxor	%ymm4, %ymm8, %ymm4
vpshufb	%ymm14, %ymm4, %ymm4
vpaddd	%ymm1, %ymm9, %ymm9
vpxor	%ymm5, %ymm9, %ymm5
vpshufb	%ymm14, %ymm5, %ymm5
vpaddd	%ymm4, %ymm12, %ymm12
vpxor	%ymm0, %ymm12, %ymm0
vpslld	$0x7, %ymm0, %ymm15
vpsrld	$0x19, %ymm0, %ymm0
vpor	%ymm0, %ymm15, %ymm0
vbroadcasti128	(%r10), %ymm15
vpaddd	%ymm5, %ymm13, %ymm13
vpxor	%ymm1, %ymm13, %ymm1
vpslld	$0x7, %ymm1, %ymm14
vpsrld	$0x19, %ymm1, %ymm1
vpor	%ymm1, %ymm14, %ymm1
vmovdqa	%ymm12, (%rsp)
vmovdqa	%ymm13, 0x20(%rsp)
vmovdqa	0x40(%rsp), %ymm12
vmovdqa	0x60(%rsp), %ymm13
vpaddd	%ymm2, %ymm10, %ymm10
vpxor	%ymm6, %ymm10, %ymm6
vpshufb	%ymm15, %ymm6, %ymm6
vpaddd	%ymm3, %ymm11, %ymm11
vpxor	%ymm7, %ymm11, %ymm7
vpshufb	%ymm15, %ymm7, %ymm7
vpaddd	%ymm6, %ymm12, %ymm12
vpxor	%ymm2, %ymm12, %ymm2
vpslld	$0xc, %ymm2, %ymm14
vpsrld	$0x14, %ymm2, %ymm2
vpor	%ymm2, %ymm14, %ymm2
vbroadcasti128	(%r11), %ymm14
vpaddd	%ymm7, %ymm13, %ymm13
vpxor	%ymm3, %ymm13, %ymm3
vpslld	$0xc, %ymm3, %ymm15
vpsrld	$0x14, %ymm3, %ymm3
vpor	%ymm3, %ymm15, %ymm3
vpaddd	%ymm2, %ymm10, %ymm10
vpxor	%ymm6, %ymm10, %ymm6
vpshufb	%ymm14, %ymm6, %ymm6
vpaddd	%ymm3, %ymm11, %ymm11
vpxor	%ymm7, %ymm11, %ymm7
vpshufb	%ymm14, %ymm7, %ymm7
vpaddd	%ymm6, %ymm12, %ymm12
vpxor	%ymm2, %ymm12, %ymm2
vpslld	$0x7, %ymm2, %ymm15
vpsrld	$0x19, %ymm2, %ymm2
vpor	%ymm2, %ymm15, %ymm2
vbroadcasti128	(%r10), %ymm15
vpaddd	%ymm7, %ymm13, %ymm13
vpxor	%ymm3, %ymm13, %ymm3
vpslld	$0x7, %ymm3, %ymm14
vpsrld	$0x19, %ymm3, %ymm3
vpor	%ymm3, %ymm14, %ymm3
vpaddd	%ymm1, %ymm8, %ymm8
vpxor	%ymm7, %ymm8, %ymm7
vpshufb	%ymm15, %ymm7, %ymm7
vpaddd	%ymm2, %ymm9, %ymm9
vpxor	%ymm4, %ymm9, %ymm4
vpshufb	%ymm15, %ymm4, %ymm4
vpaddd	%ymm7, %ymm12, %ymm12
vpxor	%ymm1, %ymm12, %ymm1
vpslld	$0xc, %ymm1, %ymm14
vpsrld	$0x14, %ymm1, %ymm1
vpor	%ymm1, %ymm14, %ymm1
vbroadcasti128	(%r11), %ymm14
vpaddd	%ymm4, %ymm13, %ymm13
vpxor	%ymm2, %ymm13, %ymm2
vpslld	$0xc, %ymm2, %ymm15
vpsrld	$0x14, %ymm2, %ymm2
vpor	%ymm2, %ymm15, %ymm2
vpaddd	%ymm1, %ymm8, %ymm8
vpxor	%ymm7, %ymm8, %ymm7
vpshufb	%ymm14, %ymm7, %ymm7
vpaddd	%ymm2, %ymm9, %ymm9
vpxor	%ymm4, %ymm9, %ymm4
vpshufb	%ymm14, %ymm4, %ymm4
vpaddd	%ymm7, %ymm12, %ymm12
vpxor	%ymm1, %ymm12, %ymm1
vpslld	$0x7, %ymm1, %ymm15
vpsrld	$0x19, %ymm1, %ymm1
vpor	%ymm1, %ymm15, %ymm1
vbroadcasti128	(%r10), %ymm15
vpaddd	%ymm4, %ymm13, %ymm13
vpxor	%ymm2, %ymm13, %ymm2
vpslld	$0x7, %ymm2, %ymm14
vpsrld	$0x19, %ymm2, %ymm2
vpor	%ymm2, %ymm14, %ymm2
vmovdqa	%ymm12, 0x40(%rsp)
vmovdqa	%ymm13, 0x60(%rsp)
vmovdqa	(%rsp), %ymm12
vmovdqa	0x20(%rsp), %ymm13
vpaddd	%ymm3, %ymm10, %ymm10
vpxor	%ymm5, %ymm10, %ymm5
vpshufb	%ymm15, %ymm5, %ymm5
vpaddd	%ymm0, %ymm11, %ymm11
vpxor	%ymm6, %ymm11, %ymm6
vpshufb	%ymm15, %ymm6, %ymm6
vpaddd	%ymm5, %ymm12, %ymm12
vpxor	%ymm3, %ymm12, %ymm3
vpslld	$0xc, %ymm3, %ymm14
vpsrld	$0x14, %ymm3, %ymm3
vpor	%ymm3, %ymm14, %ymm3
vbroadcasti128	(%r11), %ymm14
vpaddd	%ymm6, %ymm13, %ymm13
vpxor	%ymm0, %ymm13, %ymm0
vpslld	$0xc, %ymm0, %ymm15
vpsrld	$0x14, %ymm0, %ymm0
vpor	%ymm0, %ymm15, %ymm0
vpaddd	%ymm3, %ymm10, %ymm10
vpxor	%ymm5, %ymm10, %ymm5
vpshufb	%ymm14, %ymm5, %ymm5
vpaddd	%ymm0, %ymm11, %ymm11
vpxor	%ymm6, %ymm11, %ymm6
vpshufb	%ymm14, %ymm6, %ymm6
vpaddd	%ymm5, %ymm12, %ymm12
vpxor	%ymm3, %ymm12, %ymm3
vpslld	$0x7, %ymm3, %ymm15
vpsrld	$0x19, %ymm3, %ymm3
vpor	%ymm3, %ymm15, %ymm3
vbroadcasti128	(%r10), %ymm15
vpaddd	%ymm6, %ymm13, %ymm13
vpxor	%ymm0, %ymm13, %ymm0
vpslld	$0x7, %ymm0, %ymm14
vpsrld	$0x19, %ymm0, %ymm0
vpor	%ymm0, %ymm14, %ymm0
decl	%eax
jne	L_1bc0
leaq	0x200(%rsp), %rax
vpaddd	-0x80(%rcx), %ymm8, %ymm8
vpaddd	-0x60(%rcx), %ymm9, %ymm9
vpaddd	-0x40(%rcx), %ymm10, %ymm10
vpaddd	-0x20(%rcx), %ymm11, %ymm11
vpunpckldq	%ymm9, %ymm8, %ymm14
vpunpckldq	%ymm11, %ymm10, %ymm15
vpunpckhdq	%ymm9, %ymm8, %ymm8
vpunpckhdq	%ymm11, %ymm10, %ymm10
vpunpcklqdq	%ymm15, %ymm14, %ymm9
vpunpckhqdq	%ymm15, %ymm14, %ymm14
vpunpcklqdq	%ymm10, %ymm8, %ymm11
vpunpckhqdq	%ymm10, %ymm8, %ymm8
vpaddd	(%rcx), %ymm0, %ymm0
vpaddd	0x20(%rcx), %ymm1, %ymm1
vpaddd	0x40(%rcx), %ymm2, %ymm2
vpaddd	0x60(%rcx), %ymm3, %ymm3
vpunpckldq	%ymm1, %ymm0, %ymm10
vpunpckldq	%ymm3, %ymm2, %ymm15
vpunpckhdq	%ymm1, %ymm0, %ymm0
vpunpckhdq	%ymm3, %ymm2, %ymm2
vpunpcklqdq	%ymm15, %ymm10, %ymm1
vpunpckhqdq	%ymm15, %ymm10, %ymm10
vpunpcklqdq	%ymm2, %ymm0, %ymm3
vpunpckhqdq	%ymm2, %ymm0, %ymm0
vperm2i128	$0x20, %ymm1, %ymm9, %ymm15
vperm2i128	$0x31, %ymm1, %ymm9, %ymm1
vperm2i128	$0x20, %ymm10, %ymm14, %ymm9
vperm2i128	$0x31, %ymm10, %ymm14, %ymm10
vperm2i128	$0x20, %ymm3, %ymm11, %ymm14
vperm2i128	$0x31, %ymm3, %ymm11, %ymm3
vperm2i128	$0x20, %ymm0, %ymm8, %ymm11
vperm2i128	$0x31, %ymm0, %ymm8, %ymm0
vmovdqa	%ymm15, (%rsp)
vmovdqa	%ymm9, 0x20(%rsp)
vmovdqa	0x40(%rsp), %ymm15
vmovdqa	0x60(%rsp), %ymm9
vpaddd	-0x80(%rax), %ymm12, %ymm12
vpaddd	-0x60(%rax), %ymm13, %ymm13
vpaddd	-0x40(%rax), %ymm15, %ymm15
vpaddd	-0x20(%rax), %ymm9, %ymm9
vpunpckldq	%ymm13, %ymm12, %ymm2
vpunpckldq	%ymm9, %ymm15, %ymm8
vpunpckhdq	%ymm13, %ymm12, %ymm12
vpunpckhdq	%ymm9, %ymm15, %ymm15
vpunpcklqdq	%ymm8, %ymm2, %ymm13
vpunpckhqdq	%ymm8, %ymm2, %ymm2
vpunpcklqdq	%ymm15, %ymm12, %ymm9
vpunpckhqdq	%ymm15, %ymm12, %ymm12
vpaddd	(%rax), %ymm4, %ymm4
vpaddd	0x20(%rax), %ymm5, %ymm5
vpaddd	0x40(%rax), %ymm6, %ymm6
vpaddd	0x60(%rax), %ymm7, %ymm7
vpunpckldq	%ymm5, %ymm4, %ymm15
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm4
vpunpckhdq	%ymm7, %ymm6, %ymm6
vpunpcklqdq	%ymm8, %ymm15, %ymm5
vpunpckhqdq	%ymm8, %ymm15, %ymm15
vpunpcklqdq	%ymm6, %ymm4, %ymm7
vpunpckhqdq	%ymm6, %ymm4, %ymm4
vperm2i128	$0x20, %ymm5, %ymm13, %ymm8
vperm2i128	$0x31, %ymm5, %ymm13, %ymm5
vperm2i128	$0x20, %ymm15, %ymm2, %ymm13
vperm2i128	$0x31, %ymm15, %ymm2, %ymm15
vperm2i128	$0x20, %ymm7, %ymm9, %ymm2
vperm2i128	$0x31, %ymm7, %ymm9, %ymm7
vperm2i128	$0x20, %ymm4, %ymm12, %ymm9
vperm2i128	$0x31, %ymm4, %ymm12, %ymm4
vmovdqa	(%rsp), %ymm6
vmovdqa	0x20(%rsp), %ymm12
cmpq	$0x200, %rdx
jb	L_20a9
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
leaq	0x80(%rsi), %rsi
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
leaq	0x80(%rdi), %rdi
vpxor	(%rsi), %ymm12, %ymm12
vpxor	0x20(%rsi), %ymm13, %ymm13
vpxor	0x40(%rsi), %ymm10, %ymm10
vpxor	0x60(%rsi), %ymm15, %ymm15
leaq	0x80(%rsi), %rsi
vmovdqu	%ymm12, (%rdi)
vmovdqu	%ymm13, 0x20(%rdi)
vmovdqu	%ymm10, 0x40(%rdi)
vmovdqu	%ymm15, 0x60(%rdi)
leaq	0x80(%rdi), %rdi
vpxor	(%rsi), %ymm14, %ymm14
vpxor	0x20(%rsi), %ymm2, %ymm2
vpxor	0x40(%rsi), %ymm3, %ymm3
vpxor	0x60(%rsi), %ymm7, %ymm7
leaq	0x80(%rsi), %rsi
vmovdqu	%ymm14, (%rdi)
vmovdqu	%ymm2, 0x20(%rdi)
vmovdqu	%ymm3, 0x40(%rdi)
vmovdqu	%ymm7, 0x60(%rdi)
leaq	0x80(%rdi), %rdi
vpxor	(%rsi), %ymm11, %ymm11
vpxor	0x20(%rsi), %ymm9, %ymm9
vpxor	0x40(%rsi), %ymm0, %ymm0
vpxor	0x60(%rsi), %ymm4, %ymm4
leaq	0x80(%rsi), %rsi
vmovdqu	%ymm11, (%rdi)
vmovdqu	%ymm9, 0x20(%rdi)
vmovdqu	%ymm0, 0x40(%rdi)
vmovdqu	%ymm4, 0x60(%rdi)
leaq	0x80(%rdi), %rdi
subq	$0x200, %rdx
jne	L_1b40
jmp	L_2585
L_20a9:
cmpq	$0x1c0, %rdx
jae	L_2480
cmpq	$0x180, %rdx
jae	L_23a0
cmpq	$0x140, %rdx
jae	L_22e0
cmpq	$0x100, %rdx
jae	L_2240
cmpq	$0xc0, %rdx
jae	L_21c0
cmpq	$0x80, %rdx
jae	L_2160
cmpq	$0x40, %rdx
jae	L_2120
xorq	%r10, %r10
vmovdqa	%ymm6, (%rsp)
vmovdqa	%ymm8, 0x20(%rsp)
jmp	L_256b
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
L_2120:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
je	L_2585
leaq	0x40(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm1, (%rsp)
leaq	0x40(%rdi), %rdi
subq	$0x40, %rdx
vmovdqa	%ymm5, 0x20(%rsp)
jmp	L_256b
nopw	(%rax,%rax)
L_2160:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
je	L_2585
leaq	0x80(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm12, (%rsp)
leaq	0x80(%rdi), %rdi
subq	$0x80, %rdx
vmovdqa	%ymm13, 0x20(%rsp)
jmp	L_256b
nopw	%cs:(%rax,%rax)
nop
L_21c0:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
vpxor	0x80(%rsi), %ymm12, %ymm12
vpxor	0xa0(%rsi), %ymm13, %ymm13
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
vmovdqu	%ymm12, 0x80(%rdi)
vmovdqu	%ymm13, 0xa0(%rdi)
je	L_2585
leaq	0xc0(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm10, (%rsp)
leaq	0xc0(%rdi), %rdi
subq	$0xc0, %rdx
vmovdqa	%ymm15, 0x20(%rsp)
jmp	L_256b
nopw	%cs:(%rax,%rax)
nop
L_2240:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
vpxor	0x80(%rsi), %ymm12, %ymm12
vpxor	0xa0(%rsi), %ymm13, %ymm13
vpxor	0xc0(%rsi), %ymm10, %ymm10
vpxor	0xe0(%rsi), %ymm15, %ymm15
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
vmovdqu	%ymm12, 0x80(%rdi)
vmovdqu	%ymm13, 0xa0(%rdi)
vmovdqu	%ymm10, 0xc0(%rdi)
vmovdqu	%ymm15, 0xe0(%rdi)
je	L_2585
leaq	0x100(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm14, (%rsp)
leaq	0x100(%rdi), %rdi
subq	$0x100, %rdx
vmovdqa	%ymm2, 0x20(%rsp)
jmp	L_256b
nopw	%cs:(%rax,%rax)
nop
L_22e0:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
vpxor	0x80(%rsi), %ymm12, %ymm12
vpxor	0xa0(%rsi), %ymm13, %ymm13
vpxor	0xc0(%rsi), %ymm10, %ymm10
vpxor	0xe0(%rsi), %ymm15, %ymm15
vpxor	0x100(%rsi), %ymm14, %ymm14
vpxor	0x120(%rsi), %ymm2, %ymm2
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
vmovdqu	%ymm12, 0x80(%rdi)
vmovdqu	%ymm13, 0xa0(%rdi)
vmovdqu	%ymm10, 0xc0(%rdi)
vmovdqu	%ymm15, 0xe0(%rdi)
vmovdqu	%ymm14, 0x100(%rdi)
vmovdqu	%ymm2, 0x120(%rdi)
je	L_2585
leaq	0x140(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm3, (%rsp)
leaq	0x140(%rdi), %rdi
subq	$0x140, %rdx
vmovdqa	%ymm7, 0x20(%rsp)
jmp	L_256b
nopw	%cs:(%rax,%rax)
nop
L_23a0:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
vpxor	0x80(%rsi), %ymm12, %ymm12
vpxor	0xa0(%rsi), %ymm13, %ymm13
vpxor	0xc0(%rsi), %ymm10, %ymm10
vpxor	0xe0(%rsi), %ymm15, %ymm15
vpxor	0x100(%rsi), %ymm14, %ymm14
vpxor	0x120(%rsi), %ymm2, %ymm2
vpxor	0x140(%rsi), %ymm3, %ymm3
vpxor	0x160(%rsi), %ymm7, %ymm7
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
vmovdqu	%ymm12, 0x80(%rdi)
vmovdqu	%ymm13, 0xa0(%rdi)
vmovdqu	%ymm10, 0xc0(%rdi)
vmovdqu	%ymm15, 0xe0(%rdi)
vmovdqu	%ymm14, 0x100(%rdi)
vmovdqu	%ymm2, 0x120(%rdi)
vmovdqu	%ymm3, 0x140(%rdi)
vmovdqu	%ymm7, 0x160(%rdi)
je	L_2585
leaq	0x180(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm11, (%rsp)
leaq	0x180(%rdi), %rdi
subq	$0x180, %rdx
vmovdqa	%ymm9, 0x20(%rsp)
jmp	L_256b
nopw	%cs:(%rax,%rax)
nop
L_2480:
vpxor	(%rsi), %ymm6, %ymm6
vpxor	0x20(%rsi), %ymm8, %ymm8
vpxor	0x40(%rsi), %ymm1, %ymm1
vpxor	0x60(%rsi), %ymm5, %ymm5
vpxor	0x80(%rsi), %ymm12, %ymm12
vpxor	0xa0(%rsi), %ymm13, %ymm13
vpxor	0xc0(%rsi), %ymm10, %ymm10
vpxor	0xe0(%rsi), %ymm15, %ymm15
vpxor	0x100(%rsi), %ymm14, %ymm14
vpxor	0x120(%rsi), %ymm2, %ymm2
vpxor	0x140(%rsi), %ymm3, %ymm3
vpxor	0x160(%rsi), %ymm7, %ymm7
vpxor	0x180(%rsi), %ymm11, %ymm11
vpxor	0x1a0(%rsi), %ymm9, %ymm9
vmovdqu	%ymm6, (%rdi)
vmovdqu	%ymm8, 0x20(%rdi)
vmovdqu	%ymm1, 0x40(%rdi)
vmovdqu	%ymm5, 0x60(%rdi)
vmovdqu	%ymm12, 0x80(%rdi)
vmovdqu	%ymm13, 0xa0(%rdi)
vmovdqu	%ymm10, 0xc0(%rdi)
vmovdqu	%ymm15, 0xe0(%rdi)
vmovdqu	%ymm14, 0x100(%rdi)
vmovdqu	%ymm2, 0x120(%rdi)
vmovdqu	%ymm3, 0x140(%rdi)
vmovdqu	%ymm7, 0x160(%rdi)
vmovdqu	%ymm11, 0x180(%rdi)
vmovdqu	%ymm9, 0x1a0(%rdi)
je	L_2585
leaq	0x1c0(%rsi), %rsi
xorq	%r10, %r10
vmovdqa	%ymm0, (%rsp)
leaq	0x1c0(%rdi), %rdi
subq	$0x1c0, %rdx
vmovdqa	%ymm4, 0x20(%rsp)
L_256b:
movzbl	(%rsi,%r10), %eax
movzbl	(%rsp,%r10), %ecx
leaq	0x1(%r10), %r10
xorl	%ecx, %eax
movb	%al, -0x1(%rdi,%r10)
decq	%rdx
jne	L_256b
L_2585:
vzeroall
leaq	(%r9), %rsp
rep	retq
	.section .rodata
bums_rodata:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0
	.byte 0,0,0,0,2,0,0,0,4,0,0,0,6,0,0,0
	.byte 1,0,0,0,3,0,0,0,5,0,0,0,7,0,0,0
	.byte 8,0,0,0,8,0,0,0,8,0,0,0,8,0,0,0
	.byte 8,0,0,0,8,0,0,0,8,0,0,0,8,0,0,0
	.byte 2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13
	.byte 3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14
	.byte 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
	.byte 8,0,0,0,9,0,0,0,10,0,0,0,11,0,0,0
	.byte 12,0,0,0,13,0,0,0,14,0,0,0,15,0,0,0
	.byte 16,0,0,0,16,0,0,0,16,0,0,0,16,0,0,0
	.byte 16,0,0,0,16,0,0,0,16,0,0,0,16,0,0,0
	.byte 16,0,0,0,16,0,0,0,16,0,0,0,16,0,0,0
	.byte 16,0,0,0,16,0,0,0,16,0,0,0,16,0,0,0
	.byte 101,120,112,97,110,100,32,51,50,45,98,121,116,101,32,107
	.byte 0,67,104,97,67,104,97,50,48,32,102,111,114,32,120,56
	.byte 54,95,54,52,44,32,67,82,89,80,84,79,71,65,77,83
	.byte 32,98,121,32,60,104,116,116,112,115,58,47,47,103,105,116
	.byte 104,117,98,46,99,111,109,47,100,111,116,45,97,115,109,62
	.byte 0

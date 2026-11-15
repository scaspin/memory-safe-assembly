	.text
aesni_cbc_sha256_enc:
leaq	OPENSSL_ia32cap_P(%rip), %r11
movl	$0x1, %eax
cmpq	$0x0, %rdi
je	L_61
movl	(%r11), %eax
movq	0x4(%r11), %r10
btq	$0x3d, %r10
jb	aesni_cbc_sha256_enc_shaext
movq	%r10, %r11
shrq	$0x20, %r11
testl	$0x800, %r10d
jne	aesni_cbc_sha256_enc_xop
andl	$0x128, %r11d
cmpl	$0x128, %r11d
je	aesni_cbc_sha256_enc_avx2
andl	$0x10000000, %r10d
jne	aesni_cbc_sha256_enc_avx
ud2
xorl	%eax, %eax
cmpq	$0x0, %rdi
je	L_61
ud2
L_61:
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
aesni_cbc_sha256_enc_xop:
movq	0x8(%rsp), %r10
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x80, %rsp
andq	$-0x40, %rsp
shlq	$0x6, %rdx
subq	%rdi, %rsi
subq	%rdi, %r10
addq	%rdi, %rdx
movq	%rsi, 0x48(%rsp)
movq	%rdx, 0x50(%rsp)
movq	%r8, 0x60(%rsp)
movq	%r9, 0x68(%rsp)
movq	%r10, 0x70(%rsp)
movq	%rax, 0x78(%rsp)
vzeroall
movq	%rdi, %r12
leaq	0x80(%rcx), %rdi
leaq	K256+544(%rip), %r13
movl	0x70(%rdi), %r14d
movq	%r9, %r15
movq	%r10, %rsi
vmovdqu	(%r8), %xmm8
subq	$0x9, %r14
movl	(%r15), %eax
movl	0x4(%r15), %ebx
movl	0x8(%r15), %ecx
movl	0xc(%r15), %edx
movl	0x10(%r15), %r8d
movl	0x14(%r15), %r9d
movl	0x18(%r15), %r10d
movl	0x1c(%r15), %r11d
vmovdqa	(%r13,%r14,8), %xmm14
vmovdqa	0x10(%r13,%r14,8), %xmm13
vmovdqa	0x20(%r13,%r14,8), %xmm12
vmovdqu	-0x80(%rdi), %xmm10
jmp	L_130
nopw	(%rax,%rax)
L_130:
vmovdqa	K256+512(%rip), %xmm7
vmovdqu	(%rsi,%r12), %xmm0
vmovdqu	0x10(%rsi,%r12), %xmm1
vmovdqu	0x20(%rsi,%r12), %xmm2
vmovdqu	0x30(%rsi,%r12), %xmm3
vpshufb	%xmm7, %xmm0, %xmm0
leaq	K256(%rip), %rbp
vpshufb	%xmm7, %xmm1, %xmm1
vpshufb	%xmm7, %xmm2, %xmm2
vpaddd	(%rbp), %xmm0, %xmm4
vpshufb	%xmm7, %xmm3, %xmm3
vpaddd	0x20(%rbp), %xmm1, %xmm5
vpaddd	0x40(%rbp), %xmm2, %xmm6
vpaddd	0x60(%rbp), %xmm3, %xmm7
vmovdqa	%xmm4, (%rsp)
movl	%eax, %r14d
vmovdqa	%xmm5, 0x10(%rsp)
movl	%ebx, %esi
vmovdqa	%xmm6, 0x20(%rsp)
xorl	%ecx, %esi
vmovdqa	%xmm7, 0x30(%rsp)
movl	%r8d, %r13d
jmp	L_1b0
nopw	%cs:(%rax,%rax)
nop
L_1b0:
subq	$-0x80, %rbp
vmovdqu	(%r12), %xmm9
movq	%r12, 0x40(%rsp)
vpalignr	$0x4, %xmm0, %xmm1, %xmm4
rorl	$0xe, %r13d
movl	%r14d, %eax
vpalignr	$0x4, %xmm2, %xmm3, %xmm7
movl	%r9d, %r12d
xorl	%r8d, %r13d
vprotd	$0xe, %xmm4, %xmm5
rorl	$0x9, %r14d
xorl	%r10d, %r12d
vpsrld	$0x3, %xmm4, %xmm4
rorl	$0x5, %r13d
xorl	%eax, %r14d
vpaddd	%xmm7, %xmm0, %xmm0
andl	%r8d, %r12d
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
vprotd	$0xb, %xmm5, %xmm6
rorl	$0xb, %r14d
xorl	%r10d, %r12d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%ebx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
vprotd	$0xd, %xmm3, %xmm7
xorl	%eax, %r14d
addl	%r13d, %r11d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%ebx, %esi
addl	%r11d, %edx
vpsrld	$0xa, %xmm3, %xmm6
rorl	$0x2, %r14d
addl	%esi, %r11d
vpaddd	%xmm4, %xmm0, %xmm0
movl	%edx, %r13d
addl	%r11d, %r14d
vprotd	$0x2, %xmm7, %xmm5
rorl	$0xe, %r13d
movl	%r14d, %r11d
vpxor	%xmm6, %xmm7, %xmm7
movl	%r8d, %r12d
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %r12d
vpxor	%xmm5, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%edx, %r13d
vpsrldq	$0x8, %xmm7, %xmm7
addl	0x4(%rsp), %r10d
movl	%r11d, %esi
rorl	$0xb, %r14d
xorl	%r9d, %r12d
vpaddd	%xmm7, %xmm0, %xmm0
xorl	%eax, %esi
rorl	$0x6, %r13d
addl	%r12d, %r10d
andl	%esi, %r15d
vprotd	$0xd, %xmm0, %xmm7
xorl	%r11d, %r14d
addl	%r13d, %r10d
vpsrld	$0xa, %xmm0, %xmm6
xorl	%eax, %r15d
addl	%r10d, %ecx
vprotd	$0x2, %xmm7, %xmm5
rorl	$0x2, %r14d
addl	%r15d, %r10d
vpxor	%xmm6, %xmm7, %xmm7
movl	%ecx, %r13d
addl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r10d
vpxor	%xmm5, %xmm7, %xmm7
movl	%edx, %r12d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r12d
vpslldq	$0x8, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%ecx, %r13d
vpaddd	%xmm7, %xmm0, %xmm0
addl	0x8(%rsp), %r9d
movl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r12d
vpaddd	(%rbp), %xmm0, %xmm6
xorl	%r11d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r9d
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %esi
addl	%r9d, %ebx
rorl	$0x2, %r14d
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %esi
rorl	$0xb, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
rorl	$0x6, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
rorl	$0x2, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
vmovdqa	%xmm6, (%rsp)
vpalignr	$0x4, %xmm1, %xmm2, %xmm4
rorl	$0xe, %r13d
movl	%r14d, %r8d
vpalignr	$0x4, %xmm3, %xmm0, %xmm7
movl	%ebx, %r12d
xorl	%eax, %r13d
vprotd	$0xe, %xmm4, %xmm5
rorl	$0x9, %r14d
xorl	%ecx, %r12d
vpsrld	$0x3, %xmm4, %xmm4
rorl	$0x5, %r13d
xorl	%r8d, %r14d
vpaddd	%xmm7, %xmm1, %xmm1
andl	%eax, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
vprotd	$0xb, %xmm5, %xmm6
rorl	$0xb, %r14d
xorl	%ecx, %r12d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%r9d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
vprotd	$0xd, %xmm0, %xmm7
xorl	%r8d, %r14d
addl	%r13d, %edx
vpxor	%xmm6, %xmm4, %xmm4
xorl	%r9d, %esi
addl	%edx, %r11d
vpsrld	$0xa, %xmm0, %xmm6
rorl	$0x2, %r14d
addl	%esi, %edx
vpaddd	%xmm4, %xmm1, %xmm1
movl	%r11d, %r13d
addl	%edx, %r14d
vprotd	$0x2, %xmm7, %xmm5
rorl	$0xe, %r13d
movl	%r14d, %edx
vpxor	%xmm6, %xmm7, %xmm7
movl	%eax, %r12d
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %r12d
vpxor	%xmm5, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r11d, %r13d
vpsrldq	$0x8, %xmm7, %xmm7
addl	0x14(%rsp), %ecx
movl	%edx, %esi
rorl	$0xb, %r14d
xorl	%ebx, %r12d
vpaddd	%xmm7, %xmm1, %xmm1
xorl	%r8d, %esi
rorl	$0x6, %r13d
addl	%r12d, %ecx
andl	%esi, %r15d
vprotd	$0xd, %xmm1, %xmm7
xorl	%edx, %r14d
addl	%r13d, %ecx
vpsrld	$0xa, %xmm1, %xmm6
xorl	%r8d, %r15d
addl	%ecx, %r10d
vprotd	$0x2, %xmm7, %xmm5
rorl	$0x2, %r14d
addl	%r15d, %ecx
vpxor	%xmm6, %xmm7, %xmm7
movl	%r10d, %r13d
addl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ecx
vpxor	%xmm5, %xmm7, %xmm7
movl	%r11d, %r12d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r12d
vpslldq	$0x8, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r10d, %r13d
vpaddd	%xmm7, %xmm1, %xmm1
addl	0x18(%rsp), %ebx
movl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r12d
vpaddd	0x20(%rbp), %xmm1, %xmm6
xorl	%edx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %ebx
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %esi
addl	%ebx, %r9d
rorl	$0x2, %r14d
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %esi
rorl	$0xb, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
rorl	$0x6, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
rorl	$0x2, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
vmovdqa	%xmm6, 0x10(%rsp)
vpalignr	$0x4, %xmm2, %xmm3, %xmm4
rorl	$0xe, %r13d
movl	%r14d, %eax
vpalignr	$0x4, %xmm0, %xmm1, %xmm7
movl	%r9d, %r12d
xorl	%r8d, %r13d
vprotd	$0xe, %xmm4, %xmm5
rorl	$0x9, %r14d
xorl	%r10d, %r12d
vpsrld	$0x3, %xmm4, %xmm4
rorl	$0x5, %r13d
xorl	%eax, %r14d
vpaddd	%xmm7, %xmm2, %xmm2
andl	%r8d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
vprotd	$0xb, %xmm5, %xmm6
rorl	$0xb, %r14d
xorl	%r10d, %r12d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%ebx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
vprotd	$0xd, %xmm1, %xmm7
xorl	%eax, %r14d
addl	%r13d, %r11d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%ebx, %esi
addl	%r11d, %edx
vpsrld	$0xa, %xmm1, %xmm6
rorl	$0x2, %r14d
addl	%esi, %r11d
vpaddd	%xmm4, %xmm2, %xmm2
movl	%edx, %r13d
addl	%r11d, %r14d
vprotd	$0x2, %xmm7, %xmm5
rorl	$0xe, %r13d
movl	%r14d, %r11d
vpxor	%xmm6, %xmm7, %xmm7
movl	%r8d, %r12d
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %r12d
vpxor	%xmm5, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%edx, %r13d
vpsrldq	$0x8, %xmm7, %xmm7
addl	0x24(%rsp), %r10d
movl	%r11d, %esi
rorl	$0xb, %r14d
xorl	%r9d, %r12d
vpaddd	%xmm7, %xmm2, %xmm2
xorl	%eax, %esi
rorl	$0x6, %r13d
addl	%r12d, %r10d
andl	%esi, %r15d
vprotd	$0xd, %xmm2, %xmm7
xorl	%r11d, %r14d
addl	%r13d, %r10d
vpsrld	$0xa, %xmm2, %xmm6
xorl	%eax, %r15d
addl	%r10d, %ecx
vprotd	$0x2, %xmm7, %xmm5
rorl	$0x2, %r14d
addl	%r15d, %r10d
vpxor	%xmm6, %xmm7, %xmm7
movl	%ecx, %r13d
addl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r10d
vpxor	%xmm5, %xmm7, %xmm7
movl	%edx, %r12d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r12d
vpslldq	$0x8, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%ecx, %r13d
vpaddd	%xmm7, %xmm2, %xmm2
addl	0x28(%rsp), %r9d
movl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r12d
vpaddd	0x40(%rbp), %xmm2, %xmm6
xorl	%r11d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r9d
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %esi
addl	%r9d, %ebx
rorl	$0x2, %r14d
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %esi
rorl	$0xb, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
rorl	$0x6, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
rorl	$0x2, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
vmovdqa	%xmm6, 0x20(%rsp)
vpalignr	$0x4, %xmm3, %xmm0, %xmm4
rorl	$0xe, %r13d
movl	%r14d, %r8d
vpalignr	$0x4, %xmm1, %xmm2, %xmm7
movl	%ebx, %r12d
xorl	%eax, %r13d
vprotd	$0xe, %xmm4, %xmm5
rorl	$0x9, %r14d
xorl	%ecx, %r12d
vpsrld	$0x3, %xmm4, %xmm4
rorl	$0x5, %r13d
xorl	%r8d, %r14d
vpaddd	%xmm7, %xmm3, %xmm3
andl	%eax, %r12d
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
vprotd	$0xb, %xmm5, %xmm6
rorl	$0xb, %r14d
xorl	%ecx, %r12d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%r9d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
vprotd	$0xd, %xmm2, %xmm7
xorl	%r8d, %r14d
addl	%r13d, %edx
vpxor	%xmm6, %xmm4, %xmm4
xorl	%r9d, %esi
addl	%edx, %r11d
vpsrld	$0xa, %xmm2, %xmm6
rorl	$0x2, %r14d
addl	%esi, %edx
vpaddd	%xmm4, %xmm3, %xmm3
movl	%r11d, %r13d
addl	%edx, %r14d
vprotd	$0x2, %xmm7, %xmm5
rorl	$0xe, %r13d
movl	%r14d, %edx
vpxor	%xmm6, %xmm7, %xmm7
movl	%eax, %r12d
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %r12d
vpxor	%xmm5, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r11d, %r13d
vpsrldq	$0x8, %xmm7, %xmm7
addl	0x34(%rsp), %ecx
movl	%edx, %esi
rorl	$0xb, %r14d
xorl	%ebx, %r12d
vpaddd	%xmm7, %xmm3, %xmm3
xorl	%r8d, %esi
rorl	$0x6, %r13d
addl	%r12d, %ecx
andl	%esi, %r15d
vprotd	$0xd, %xmm3, %xmm7
xorl	%edx, %r14d
addl	%r13d, %ecx
vpsrld	$0xa, %xmm3, %xmm6
xorl	%r8d, %r15d
addl	%ecx, %r10d
vprotd	$0x2, %xmm7, %xmm5
rorl	$0x2, %r14d
addl	%r15d, %ecx
vpxor	%xmm6, %xmm7, %xmm7
movl	%r10d, %r13d
addl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ecx
vpxor	%xmm5, %xmm7, %xmm7
movl	%r11d, %r12d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r12d
vpslldq	$0x8, %xmm7, %xmm7
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r10d, %r13d
vpaddd	%xmm7, %xmm3, %xmm3
addl	0x38(%rsp), %ebx
movl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r12d
vpaddd	0x60(%rbp), %xmm3, %xmm6
xorl	%edx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %ebx
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %esi
addl	%ebx, %r9d
rorl	$0x2, %r14d
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %esi
rorl	$0xb, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
rorl	$0x6, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
rorl	$0x2, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
vmovdqa	%xmm6, 0x30(%rsp)
movq	0x40(%rsp), %r12
vpand	%xmm14, %xmm11, %xmm11
movq	0x48(%rsp), %r15
vpor	%xmm11, %xmm8, %xmm8
vmovdqu	%xmm8, (%r15,%r12)
leaq	0x10(%r12), %r12
cmpb	$0x0, 0x83(%rbp)
jne	L_1b0
vmovdqu	(%r12), %xmm9
movq	%r12, 0x40(%rsp)
rorl	$0xe, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
xorl	%r8d, %r13d
rorl	$0x9, %r14d
xorl	%r10d, %r12d
rorl	$0x5, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
rorl	$0xb, %r14d
xorl	%r10d, %r12d
xorl	%ebx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %esi
addl	%r11d, %edx
rorl	$0x2, %r14d
addl	%esi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %r12d
rorl	$0x5, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%edx, %r13d
addl	0x4(%rsp), %r10d
movl	%r11d, %esi
rorl	$0xb, %r14d
xorl	%r9d, %r12d
xorl	%eax, %esi
rorl	$0x6, %r13d
addl	%r12d, %r10d
andl	%esi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
addl	%r10d, %ecx
rorl	$0x2, %r14d
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r12d
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
movl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r12d
xorl	%r11d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r9d
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %esi
addl	%r9d, %ebx
rorl	$0x2, %r14d
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %esi
rorl	$0xb, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
rorl	$0x6, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
rorl	$0x2, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
xorl	%eax, %r13d
rorl	$0x9, %r14d
xorl	%ecx, %r12d
rorl	$0x5, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
rorl	$0xb, %r14d
xorl	%ecx, %r12d
xorl	%r9d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %esi
addl	%edx, %r11d
rorl	$0x2, %r14d
addl	%esi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %r12d
rorl	$0x5, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r11d, %r13d
addl	0x14(%rsp), %ecx
movl	%edx, %esi
rorl	$0xb, %r14d
xorl	%ebx, %r12d
xorl	%r8d, %esi
rorl	$0x6, %r13d
addl	%r12d, %ecx
andl	%esi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
addl	%ecx, %r10d
rorl	$0x2, %r14d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r12d
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
movl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r12d
xorl	%edx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %ebx
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %esi
addl	%ebx, %r9d
rorl	$0x2, %r14d
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %esi
rorl	$0xb, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
rorl	$0x6, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
rorl	$0x2, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
rorl	$0xe, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
xorl	%r8d, %r13d
rorl	$0x9, %r14d
xorl	%r10d, %r12d
rorl	$0x5, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
rorl	$0xb, %r14d
xorl	%r10d, %r12d
xorl	%ebx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %esi
addl	%r11d, %edx
rorl	$0x2, %r14d
addl	%esi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %r12d
rorl	$0x5, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%edx, %r13d
addl	0x24(%rsp), %r10d
movl	%r11d, %esi
rorl	$0xb, %r14d
xorl	%r9d, %r12d
xorl	%eax, %esi
rorl	$0x6, %r13d
addl	%r12d, %r10d
andl	%esi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
addl	%r10d, %ecx
rorl	$0x2, %r14d
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r12d
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
movl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r12d
xorl	%r11d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %r9d
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %esi
addl	%r9d, %ebx
rorl	$0x2, %r14d
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %esi
rorl	$0xb, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
rorl	$0x6, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
rorl	$0x2, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
xorl	%eax, %r13d
rorl	$0x9, %r14d
xorl	%ecx, %r12d
rorl	$0x5, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
rorl	$0xb, %r14d
xorl	%ecx, %r12d
xorl	%r9d, %r15d
rorl	$0x6, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %esi
addl	%edx, %r11d
rorl	$0x2, %r14d
addl	%esi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %r12d
rorl	$0x5, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r11d, %r13d
addl	0x34(%rsp), %ecx
movl	%edx, %esi
rorl	$0xb, %r14d
xorl	%ebx, %r12d
xorl	%r8d, %esi
rorl	$0x6, %r13d
addl	%r12d, %ecx
andl	%esi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
addl	%ecx, %r10d
rorl	$0x2, %r14d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r12d
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
movl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r12d
xorl	%edx, %r15d
rorl	$0x6, %r13d
addl	%r12d, %ebx
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %esi
addl	%ebx, %r9d
rorl	$0x2, %r14d
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %esi
rorl	$0xb, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
rorl	$0x6, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
rorl	$0x2, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
movq	0x40(%rsp), %r12
movq	0x48(%rsp), %r13
movq	0x68(%rsp), %r15
movq	0x70(%rsp), %rsi
vpand	%xmm14, %xmm11, %xmm11
movl	%r14d, %eax
vpor	%xmm11, %xmm8, %xmm8
vmovdqu	%xmm8, (%r12,%r13)
leaq	0x10(%r12), %r12
addl	(%r15), %eax
addl	0x4(%r15), %ebx
addl	0x8(%r15), %ecx
addl	0xc(%r15), %edx
addl	0x10(%r15), %r8d
addl	0x14(%r15), %r9d
addl	0x18(%r15), %r10d
addl	0x1c(%r15), %r11d
cmpq	0x50(%rsp), %r12
movl	%eax, (%r15)
movl	%ebx, 0x4(%r15)
movl	%ecx, 0x8(%r15)
movl	%edx, 0xc(%r15)
movl	%r8d, 0x10(%r15)
movl	%r9d, 0x14(%r15)
movl	%r10d, 0x18(%r15)
movl	%r11d, 0x1c(%r15)
jb	L_130
movq	0x60(%rsp), %r8
movq	0x78(%rsp), %rsi
vmovdqu	%xmm8, (%r8)
vzeroall
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopl	(%rax)
aesni_cbc_sha256_enc_avx:
movq	0x8(%rsp), %r10
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x80, %rsp
andq	$-0x40, %rsp
shlq	$0x6, %rdx
subq	%rdi, %rsi
subq	%rdi, %r10
addq	%rdi, %rdx
movq	%rsi, 0x48(%rsp)
movq	%rdx, 0x50(%rsp)
movq	%r8, 0x60(%rsp)
movq	%r9, 0x68(%rsp)
movq	%r10, 0x70(%rsp)
movq	%rax, 0x78(%rsp)
vzeroall
movq	%rdi, %r12
leaq	0x80(%rcx), %rdi
leaq	K256+544(%rip), %r13
movl	0x70(%rdi), %r14d
movq	%r9, %r15
movq	%r10, %rsi
vmovdqu	(%r8), %xmm8
subq	$0x9, %r14
movl	(%r15), %eax
movl	0x4(%r15), %ebx
movl	0x8(%r15), %ecx
movl	0xc(%r15), %edx
movl	0x10(%r15), %r8d
movl	0x14(%r15), %r9d
movl	0x18(%r15), %r10d
movl	0x1c(%r15), %r11d
vmovdqa	(%r13,%r14,8), %xmm14
vmovdqa	0x10(%r13,%r14,8), %xmm13
vmovdqa	0x20(%r13,%r14,8), %xmm12
vmovdqu	-0x80(%rdi), %xmm10
jmp	L_1130
nopw	(%rax,%rax)
L_1130:
vmovdqa	K256+512(%rip), %xmm7
vmovdqu	(%rsi,%r12), %xmm0
vmovdqu	0x10(%rsi,%r12), %xmm1
vmovdqu	0x20(%rsi,%r12), %xmm2
vmovdqu	0x30(%rsi,%r12), %xmm3
vpshufb	%xmm7, %xmm0, %xmm0
leaq	K256(%rip), %rbp
vpshufb	%xmm7, %xmm1, %xmm1
vpshufb	%xmm7, %xmm2, %xmm2
vpaddd	(%rbp), %xmm0, %xmm4
vpshufb	%xmm7, %xmm3, %xmm3
vpaddd	0x20(%rbp), %xmm1, %xmm5
vpaddd	0x40(%rbp), %xmm2, %xmm6
vpaddd	0x60(%rbp), %xmm3, %xmm7
vmovdqa	%xmm4, (%rsp)
movl	%eax, %r14d
vmovdqa	%xmm5, 0x10(%rsp)
movl	%ebx, %esi
vmovdqa	%xmm6, 0x20(%rsp)
xorl	%ecx, %esi
vmovdqa	%xmm7, 0x30(%rsp)
movl	%r8d, %r13d
jmp	L_11b0
nopw	%cs:(%rax,%rax)
nop
L_11b0:
subq	$-0x80, %rbp
vmovdqu	(%r12), %xmm9
movq	%r12, 0x40(%rsp)
vpalignr	$0x4, %xmm0, %xmm1, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
vpalignr	$0x4, %xmm2, %xmm3, %xmm7
xorl	%r8d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vpaddd	%xmm7, %xmm0, %xmm0
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
vpsrld	$0x3, %xmm4, %xmm7
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %r12d
xorl	%ebx, %r15d
vpslld	$0xe, %xmm4, %xmm5
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %esi
vpshufd	$0xfa, %xmm3, %xmm7
addl	%r11d, %edx
shrdl	$0x2, %r14d, %r14d
addl	%esi, %r11d
vpsrld	$0xb, %xmm6, %xmm6
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %r11d
movl	%r8d, %r12d
xorl	%edx, %r13d
vpslld	$0xb, %xmm5, %xmm5
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%r11d, %r14d
andl	%edx, %r12d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%edx, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x4(%rsp), %r10d
movl	%r11d, %esi
shrdl	$0xb, %r14d, %r14d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%r9d, %r12d
xorl	%eax, %esi
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
addl	%r12d, %r10d
andl	%esi, %r15d
xorl	%r11d, %r14d
vpaddd	%xmm4, %xmm0, %xmm0
addl	%r13d, %r10d
xorl	%eax, %r15d
addl	%r10d, %ecx
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r10d
movl	%ecx, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
vpxor	%xmm7, %xmm6, %xmm6
movl	%edx, %r12d
xorl	%ecx, %r13d
shrdl	$0x9, %r14d, %r14d
vpshufd	$0x84, %xmm6, %xmm6
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
vpsrldq	$0x8, %xmm6, %xmm6
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
vpaddd	%xmm6, %xmm0, %xmm0
movl	%r10d, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %r12d
vpshufd	$0x50, %xmm0, %xmm7
xorl	%r11d, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r9d
vpsrld	$0xa, %xmm7, %xmm6
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
vpsrlq	$0x11, %xmm7, %xmm7
xorl	%r11d, %esi
addl	%r9d, %ebx
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
vpsrlq	$0x2, %xmm7, %xmm7
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
vpxor	%xmm7, %xmm6, %xmm6
xorl	%ebx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%edx, %r12d
vpshufd	$0xe8, %xmm6, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vpslldq	$0x8, %xmm6, %xmm6
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %esi
vpaddd	%xmm6, %xmm0, %xmm0
shrdl	$0xb, %r14d, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
vpaddd	(%rbp), %xmm0, %xmm6
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
vmovdqa	%xmm6, (%rsp)
vpalignr	$0x4, %xmm1, %xmm2, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
vpalignr	$0x4, %xmm3, %xmm0, %xmm7
xorl	%eax, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vpaddd	%xmm7, %xmm1, %xmm1
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
vpsrld	$0x3, %xmm4, %xmm7
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %r12d
xorl	%r9d, %r15d
vpslld	$0xe, %xmm4, %xmm5
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %esi
vpshufd	$0xfa, %xmm0, %xmm7
addl	%edx, %r11d
shrdl	$0x2, %r14d, %r14d
addl	%esi, %edx
vpsrld	$0xb, %xmm6, %xmm6
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %edx
movl	%eax, %r12d
xorl	%r11d, %r13d
vpslld	$0xb, %xmm5, %xmm5
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r11d, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x14(%rsp), %ecx
movl	%edx, %esi
shrdl	$0xb, %r14d, %r14d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%ebx, %r12d
xorl	%r8d, %esi
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
addl	%r12d, %ecx
andl	%esi, %r15d
xorl	%edx, %r14d
vpaddd	%xmm4, %xmm1, %xmm1
addl	%r13d, %ecx
xorl	%r8d, %r15d
addl	%ecx, %r10d
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %ecx
movl	%r10d, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
vpxor	%xmm7, %xmm6, %xmm6
movl	%r11d, %r12d
xorl	%r10d, %r13d
shrdl	$0x9, %r14d, %r14d
vpshufd	$0x84, %xmm6, %xmm6
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
vpsrldq	$0x8, %xmm6, %xmm6
andl	%r10d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
vpaddd	%xmm6, %xmm1, %xmm1
movl	%ecx, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %r12d
vpshufd	$0x50, %xmm1, %xmm7
xorl	%edx, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %ebx
vpsrld	$0xa, %xmm7, %xmm6
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
vpsrlq	$0x11, %xmm7, %xmm7
xorl	%edx, %esi
addl	%ebx, %r9d
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
vpsrlq	$0x2, %xmm7, %xmm7
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
vpxor	%xmm7, %xmm6, %xmm6
xorl	%r9d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r11d, %r12d
vpshufd	$0xe8, %xmm6, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpslldq	$0x8, %xmm6, %xmm6
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %esi
vpaddd	%xmm6, %xmm1, %xmm1
shrdl	$0xb, %r14d, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
vpaddd	0x20(%rbp), %xmm1, %xmm6
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
vmovdqa	%xmm6, 0x10(%rsp)
vpalignr	$0x4, %xmm2, %xmm3, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
vpalignr	$0x4, %xmm0, %xmm1, %xmm7
xorl	%r8d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vpaddd	%xmm7, %xmm2, %xmm2
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
vpsrld	$0x3, %xmm4, %xmm7
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %r12d
xorl	%ebx, %r15d
vpslld	$0xe, %xmm4, %xmm5
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %esi
vpshufd	$0xfa, %xmm1, %xmm7
addl	%r11d, %edx
shrdl	$0x2, %r14d, %r14d
addl	%esi, %r11d
vpsrld	$0xb, %xmm6, %xmm6
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %r11d
movl	%r8d, %r12d
xorl	%edx, %r13d
vpslld	$0xb, %xmm5, %xmm5
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%r11d, %r14d
andl	%edx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%edx, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x24(%rsp), %r10d
movl	%r11d, %esi
shrdl	$0xb, %r14d, %r14d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%r9d, %r12d
xorl	%eax, %esi
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
addl	%r12d, %r10d
andl	%esi, %r15d
xorl	%r11d, %r14d
vpaddd	%xmm4, %xmm2, %xmm2
addl	%r13d, %r10d
xorl	%eax, %r15d
addl	%r10d, %ecx
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r10d
movl	%ecx, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
vpxor	%xmm7, %xmm6, %xmm6
movl	%edx, %r12d
xorl	%ecx, %r13d
shrdl	$0x9, %r14d, %r14d
vpshufd	$0x84, %xmm6, %xmm6
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
vpsrldq	$0x8, %xmm6, %xmm6
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
vpaddd	%xmm6, %xmm2, %xmm2
movl	%r10d, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %r12d
vpshufd	$0x50, %xmm2, %xmm7
xorl	%r11d, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r9d
vpsrld	$0xa, %xmm7, %xmm6
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
vpsrlq	$0x11, %xmm7, %xmm7
xorl	%r11d, %esi
addl	%r9d, %ebx
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
vpsrlq	$0x2, %xmm7, %xmm7
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
vpxor	%xmm7, %xmm6, %xmm6
xorl	%ebx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%edx, %r12d
vpshufd	$0xe8, %xmm6, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vpslldq	$0x8, %xmm6, %xmm6
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %esi
vpaddd	%xmm6, %xmm2, %xmm2
shrdl	$0xb, %r14d, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
vpaddd	0x40(%rbp), %xmm2, %xmm6
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
vmovdqa	%xmm6, 0x20(%rsp)
vpalignr	$0x4, %xmm3, %xmm0, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
vpalignr	$0x4, %xmm1, %xmm2, %xmm7
xorl	%eax, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vpaddd	%xmm7, %xmm3, %xmm3
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
vpsrld	$0x3, %xmm4, %xmm7
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %r12d
xorl	%r9d, %r15d
vpslld	$0xe, %xmm4, %xmm5
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %esi
vpshufd	$0xfa, %xmm2, %xmm7
addl	%edx, %r11d
shrdl	$0x2, %r14d, %r14d
addl	%esi, %edx
vpsrld	$0xb, %xmm6, %xmm6
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %edx
movl	%eax, %r12d
xorl	%r11d, %r13d
vpslld	$0xb, %xmm5, %xmm5
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r11d, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x34(%rsp), %ecx
movl	%edx, %esi
shrdl	$0xb, %r14d, %r14d
vpxor	%xmm5, %xmm4, %xmm4
xorl	%ebx, %r12d
xorl	%r8d, %esi
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
addl	%r12d, %ecx
andl	%esi, %r15d
xorl	%edx, %r14d
vpaddd	%xmm4, %xmm3, %xmm3
addl	%r13d, %ecx
xorl	%r8d, %r15d
addl	%ecx, %r10d
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %ecx
movl	%r10d, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
vpxor	%xmm7, %xmm6, %xmm6
movl	%r11d, %r12d
xorl	%r10d, %r13d
shrdl	$0x9, %r14d, %r14d
vpshufd	$0x84, %xmm6, %xmm6
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
vpsrldq	$0x8, %xmm6, %xmm6
andl	%r10d, %r12d
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
vpaddd	%xmm6, %xmm3, %xmm3
movl	%ecx, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %r12d
vpshufd	$0x50, %xmm3, %xmm7
xorl	%edx, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %ebx
vpsrld	$0xa, %xmm7, %xmm6
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
vpsrlq	$0x11, %xmm7, %xmm7
xorl	%edx, %esi
addl	%ebx, %r9d
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
vpsrlq	$0x2, %xmm7, %xmm7
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
vpxor	%xmm7, %xmm6, %xmm6
xorl	%r9d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r11d, %r12d
vpshufd	$0xe8, %xmm6, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpslldq	$0x8, %xmm6, %xmm6
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %esi
vpaddd	%xmm6, %xmm3, %xmm3
shrdl	$0xb, %r14d, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
vpaddd	0x60(%rbp), %xmm3, %xmm6
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
vmovdqa	%xmm6, 0x30(%rsp)
movq	0x40(%rsp), %r12
vpand	%xmm14, %xmm11, %xmm11
movq	0x48(%rsp), %r15
vpor	%xmm11, %xmm8, %xmm8
vmovdqu	%xmm8, (%r15,%r12)
leaq	0x10(%r12), %r12
cmpb	$0x0, 0x83(%rbp)
jne	L_11b0
vmovdqu	(%r12), %xmm9
movq	%r12, 0x40(%rsp)
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
xorl	%r8d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %r12d
xorl	%ebx, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %esi
addl	%r11d, %edx
shrdl	$0x2, %r14d, %r14d
addl	%esi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
xorl	%edx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%edx, %r13d
addl	0x4(%rsp), %r10d
movl	%r11d, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%r9d, %r12d
xorl	%eax, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r10d
andl	%esi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
addl	%r10d, %ecx
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
xorl	%ecx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
movl	%r10d, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %r12d
xorl	%r11d, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r9d
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %esi
addl	%r9d, %ebx
shrdl	$0x2, %r14d, %r14d
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
xorl	%ebx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%edx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
xorl	%eax, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %r12d
xorl	%r9d, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %esi
addl	%edx, %r11d
shrdl	$0x2, %r14d, %r14d
addl	%esi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
xorl	%r11d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r11d, %r13d
addl	0x14(%rsp), %ecx
movl	%edx, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%ebx, %r12d
xorl	%r8d, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %ecx
andl	%esi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
addl	%ecx, %r10d
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
xorl	%r10d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
movl	%ecx, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %r12d
xorl	%edx, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %ebx
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %esi
addl	%ebx, %r9d
shrdl	$0x2, %r14d, %r14d
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
xorl	%r9d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r11d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
xorl	%r8d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %r12d
xorl	%ebx, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r11d
andl	%r15d, %esi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %esi
addl	%r11d, %edx
shrdl	$0x2, %r14d, %r14d
addl	%esi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
xorl	%edx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%edx, %r13d
addl	0x24(%rsp), %r10d
movl	%r11d, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%r9d, %r12d
xorl	%eax, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r10d
andl	%esi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
addl	%r10d, %ecx
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
xorl	%ecx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
movl	%r10d, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %r12d
xorl	%r11d, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r9d
andl	%r15d, %esi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %esi
addl	%r9d, %ebx
shrdl	$0x2, %r14d, %r14d
addl	%esi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
xorl	%ebx, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%edx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%edx, %r12d
xorl	%r10d, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %r8d
andl	%esi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
addl	%r8d, %eax
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
xorl	%eax, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %r12d
xorl	%r9d, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %edx
andl	%r15d, %esi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %esi
addl	%edx, %r11d
shrdl	$0x2, %r14d, %r14d
addl	%esi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
xorl	%r11d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r11d, %r13d
addl	0x34(%rsp), %ecx
movl	%edx, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%ebx, %r12d
xorl	%r8d, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %ecx
andl	%esi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
addl	%ecx, %r10d
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
xorl	%r10d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
movl	%ecx, %r15d
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %r12d
xorl	%edx, %r15d
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %ebx
andl	%r15d, %esi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %esi
addl	%ebx, %r9d
shrdl	$0x2, %r14d, %r14d
addl	%esi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
xorl	%r9d, %r13d
shrdl	$0x9, %r14d, %r14d
xorl	%r11d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %esi
shrdl	$0xb, %r14d, %r14d
xorl	%r11d, %r12d
xorl	%ecx, %esi
shrdl	$0x6, %r13d, %r13d
addl	%r12d, %eax
andl	%esi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
addl	%eax, %r8d
shrdl	$0x2, %r14d, %r14d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
movq	0x40(%rsp), %r12
movq	0x48(%rsp), %r13
movq	0x68(%rsp), %r15
movq	0x70(%rsp), %rsi
vpand	%xmm14, %xmm11, %xmm11
movl	%r14d, %eax
vpor	%xmm11, %xmm8, %xmm8
vmovdqu	%xmm8, (%r12,%r13)
leaq	0x10(%r12), %r12
addl	(%r15), %eax
addl	0x4(%r15), %ebx
addl	0x8(%r15), %ecx
addl	0xc(%r15), %edx
addl	0x10(%r15), %r8d
addl	0x14(%r15), %r9d
addl	0x18(%r15), %r10d
addl	0x1c(%r15), %r11d
cmpq	0x50(%rsp), %r12
movl	%eax, (%r15)
movl	%ebx, 0x4(%r15)
movl	%ecx, 0x8(%r15)
movl	%edx, 0xc(%r15)
movl	%r8d, 0x10(%r15)
movl	%r9d, 0x14(%r15)
movl	%r10d, 0x18(%r15)
movl	%r11d, 0x1c(%r15)
jb	L_1130
movq	0x60(%rsp), %r8
movq	0x78(%rsp), %rsi
vmovdqu	%xmm8, (%r8)
vzeroall
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopl	(%rax)
aesni_cbc_sha256_enc_avx2:
movq	0x8(%rsp), %r10
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x240, %rsp
andq	$-0x400, %rsp
addq	$0x1c0, %rsp
shlq	$0x6, %rdx
subq	%rdi, %rsi
subq	%rdi, %r10
addq	%rdi, %rdx
movq	%rdx, 0x50(%rsp)
movq	%r8, 0x60(%rsp)
movq	%r9, 0x68(%rsp)
movq	%r10, 0x70(%rsp)
movq	%rax, 0x78(%rsp)
vzeroall
movq	%rdi, %r13
vpinsrq	$0x1, %rsi, %xmm15, %xmm15
leaq	0x80(%rcx), %rdi
leaq	K256+544(%rip), %r12
movl	0x70(%rdi), %r14d
movq	%r9, %r15
movq	%r10, %rsi
vmovdqu	(%r8), %xmm8
leaq	-0x9(%r14), %r14
vmovdqa	(%r12,%r14,8), %xmm14
vmovdqa	0x10(%r12,%r14,8), %xmm13
vmovdqa	0x20(%r12,%r14,8), %xmm12
subq	$-0x40, %r13
movl	(%r15), %eax
leaq	(%rsi,%r13), %r12
movl	0x4(%r15), %ebx
cmpq	%rdx, %r13
movl	0x8(%r15), %ecx
cmoveq	%rsp, %r12
movl	0xc(%r15), %edx
movl	0x10(%r15), %r8d
movl	0x14(%r15), %r9d
movl	0x18(%r15), %r10d
movl	0x1c(%r15), %r11d
vmovdqu	-0x80(%rdi), %xmm10
jmp	L_2290
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2290:
vmovdqa	K256+512(%rip), %ymm7
vmovdqu	-0x40(%rsi,%r13), %xmm0
vmovdqu	-0x30(%rsi,%r13), %xmm1
vmovdqu	-0x20(%rsi,%r13), %xmm2
vmovdqu	-0x10(%rsi,%r13), %xmm3
vinserti128	$0x1, (%r12), %ymm0, %ymm0
vinserti128	$0x1, 0x10(%r12), %ymm1, %ymm1
vpshufb	%ymm7, %ymm0, %ymm0
vinserti128	$0x1, 0x20(%r12), %ymm2, %ymm2
vpshufb	%ymm7, %ymm1, %ymm1
vinserti128	$0x1, 0x30(%r12), %ymm3, %ymm3
leaq	K256(%rip), %rbp
vpshufb	%ymm7, %ymm2, %ymm2
leaq	-0x40(%r13), %r13
vpaddd	(%rbp), %ymm0, %ymm4
vpshufb	%ymm7, %ymm3, %ymm3
vpaddd	0x20(%rbp), %ymm1, %ymm5
vpaddd	0x40(%rbp), %ymm2, %ymm6
vpaddd	0x60(%rbp), %ymm3, %ymm7
vmovdqa	%ymm4, (%rsp)
xorl	%r14d, %r14d
vmovdqa	%ymm5, 0x20(%rsp)
movq	0x78(%rsp), %rsi
leaq	-0x40(%rsp), %rsp
movq	%rsi, -0x8(%rsp)
movl	%ebx, %esi
vmovdqa	%ymm6, (%rsp)
xorl	%ecx, %esi
vmovdqa	%ymm7, 0x20(%rsp)
movl	%r9d, %r12d
subq	$-0x80, %rbp
jmp	L_2340
nopl	(%rax,%rax)
L_2340:
vmovdqu	(%r13), %xmm9
vpinsrq	$0x0, %r13, %xmm15, %xmm15
leaq	-0x40(%rsp), %rsp
pushq	0x38(%rsp)
leaq	0x8(%rsp), %rsp
vpalignr	$0x4, %ymm0, %ymm1, %ymm4
addl	0x80(%rsp), %r11d
andl	%r8d, %r12d
rorxl	$0x19, %r8d, %r13d
vpalignr	$0x4, %ymm2, %ymm3, %ymm7
rorxl	$0xb, %r8d, %r15d
leal	(%rax,%r14), %eax
leal	(%r11,%r12), %r11d
vpsrld	$0x7, %ymm4, %ymm6
andnl	%r10d, %r8d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r8d, %r14d
vpaddd	%ymm7, %ymm0, %ymm0
leal	(%r11,%r12), %r11d
xorl	%r14d, %r13d
movl	%eax, %r15d
vpsrld	$0x3, %ymm4, %ymm7
rorxl	$0x16, %eax, %r12d
leal	(%r11,%r13), %r11d
xorl	%ebx, %r15d
vpslld	$0xe, %ymm4, %ymm5
rorxl	$0xd, %eax, %r14d
rorxl	$0x2, %eax, %r13d
leal	(%rdx,%r11), %edx
vpxor	%ymm6, %ymm7, %ymm4
andl	%r15d, %esi
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ebx, %esi
vpshufd	$0xfa, %ymm3, %ymm7
xorl	%r13d, %r14d
leal	(%r11,%rsi), %r11d
movl	%r8d, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0x84(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %edx, %esi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
vpslld	$0xb, %ymm5, %ymm5
andnl	%r9d, %edx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %edx, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %esi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %esi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
vpsrlq	$0x11, %ymm7, %ymm7
andl	%esi, %r15d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%r12d, %r14d
xorl	%eax, %r15d
vpaddd	%ymm4, %ymm0, %ymm0
xorl	%r13d, %r14d
leal	(%r10,%r15), %r10d
movl	%edx, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0x88(%rsp), %r9d
andl	%ecx, %r12d
rorxl	$0x19, %ecx, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %ecx, %r15d
leal	(%r10,%r14), %r10d
leal	(%r9,%r12), %r9d
vpxor	%ymm7, %ymm6, %ymm6
andnl	%r8d, %ecx, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %ecx, %r14d
vpshufd	$0x84, %ymm6, %ymm6
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
vpsrldq	$0x8, %ymm6, %ymm6
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
vpaddd	%ymm6, %ymm0, %ymm0
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
vpshufd	$0x50, %ymm0, %ymm7
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r11d, %esi
vpsrld	$0xa, %ymm7, %ymm6
xorl	%r13d, %r14d
leal	(%r9,%rsi), %r9d
movl	%ecx, %r12d
vpsrlq	$0x11, %ymm7, %ymm7
addl	0x8c(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
vpxor	%ymm7, %ymm6, %ymm6
rorxl	$0xb, %ebx, %esi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
vpsrlq	$0x2, %ymm7, %ymm7
andnl	%edx, %ebx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %ebx, %r14d
vpxor	%ymm7, %ymm6, %ymm6
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %esi
vpshufd	$0xe8, %ymm6, %ymm6
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %esi
vpslldq	$0x8, %ymm6, %ymm6
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
vpaddd	%ymm6, %ymm0, %ymm0
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r10d, %r15d
vpaddd	(%rbp), %ymm0, %ymm6
xorl	%r13d, %r14d
leal	(%r8,%r15), %r8d
movl	%ebx, %r12d
vmovdqa	%ymm6, (%rsp)
vpalignr	$0x4, %ymm1, %ymm2, %ymm4
addl	0xa0(%rsp), %edx
andl	%eax, %r12d
rorxl	$0x19, %eax, %r13d
vpalignr	$0x4, %ymm3, %ymm0, %ymm7
rorxl	$0xb, %eax, %r15d
leal	(%r8,%r14), %r8d
leal	(%rdx,%r12), %edx
vpsrld	$0x7, %ymm4, %ymm6
andnl	%ecx, %eax, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %eax, %r14d
vpaddd	%ymm7, %ymm1, %ymm1
leal	(%rdx,%r12), %edx
xorl	%r14d, %r13d
movl	%r8d, %r15d
vpsrld	$0x3, %ymm4, %ymm7
rorxl	$0x16, %r8d, %r12d
leal	(%rdx,%r13), %edx
xorl	%r9d, %r15d
vpslld	$0xe, %ymm4, %ymm5
rorxl	$0xd, %r8d, %r14d
rorxl	$0x2, %r8d, %r13d
leal	(%r11,%rdx), %r11d
vpxor	%ymm6, %ymm7, %ymm4
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r9d, %esi
vpshufd	$0xfa, %ymm0, %ymm7
xorl	%r13d, %r14d
leal	(%rdx,%rsi), %edx
movl	%eax, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0xa4(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %r11d, %esi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
vpslld	$0xb, %ymm5, %ymm5
andnl	%ebx, %r11d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r11d, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %esi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %esi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
vpsrlq	$0x11, %ymm7, %ymm7
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r8d, %r15d
vpaddd	%ymm4, %ymm1, %ymm1
xorl	%r13d, %r14d
leal	(%rcx,%r15), %ecx
movl	%r11d, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0xa8(%rsp), %ebx
andl	%r10d, %r12d
rorxl	$0x19, %r10d, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %r10d, %r15d
leal	(%rcx,%r14), %ecx
leal	(%rbx,%r12), %ebx
vpxor	%ymm7, %ymm6, %ymm6
andnl	%eax, %r10d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r10d, %r14d
vpshufd	$0x84, %ymm6, %ymm6
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
vpsrldq	$0x8, %ymm6, %ymm6
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
vpaddd	%ymm6, %ymm1, %ymm1
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
vpshufd	$0x50, %ymm1, %ymm7
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%edx, %esi
vpsrld	$0xa, %ymm7, %ymm6
xorl	%r13d, %r14d
leal	(%rbx,%rsi), %ebx
movl	%r10d, %r12d
vpsrlq	$0x11, %ymm7, %ymm7
addl	0xac(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
vpxor	%ymm7, %ymm6, %ymm6
rorxl	$0xb, %r9d, %esi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
vpsrlq	$0x2, %ymm7, %ymm7
andnl	%r11d, %r9d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r9d, %r14d
vpxor	%ymm7, %ymm6, %ymm6
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %esi
vpshufd	$0xe8, %ymm6, %ymm6
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %esi
vpslldq	$0x8, %ymm6, %ymm6
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
vpaddd	%ymm6, %ymm1, %ymm1
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ecx, %r15d
vpaddd	0x20(%rbp), %ymm1, %ymm6
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
vmovdqa	%ymm6, 0x20(%rsp)
leaq	-0x40(%rsp), %rsp
pushq	0x38(%rsp)
leaq	0x8(%rsp), %rsp
vpalignr	$0x4, %ymm2, %ymm3, %ymm4
addl	0x80(%rsp), %r11d
andl	%r8d, %r12d
rorxl	$0x19, %r8d, %r13d
vpalignr	$0x4, %ymm0, %ymm1, %ymm7
rorxl	$0xb, %r8d, %r15d
leal	(%rax,%r14), %eax
leal	(%r11,%r12), %r11d
vpsrld	$0x7, %ymm4, %ymm6
andnl	%r10d, %r8d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r8d, %r14d
vpaddd	%ymm7, %ymm2, %ymm2
leal	(%r11,%r12), %r11d
xorl	%r14d, %r13d
movl	%eax, %r15d
vpsrld	$0x3, %ymm4, %ymm7
rorxl	$0x16, %eax, %r12d
leal	(%r11,%r13), %r11d
xorl	%ebx, %r15d
vpslld	$0xe, %ymm4, %ymm5
rorxl	$0xd, %eax, %r14d
rorxl	$0x2, %eax, %r13d
leal	(%rdx,%r11), %edx
vpxor	%ymm6, %ymm7, %ymm4
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ebx, %esi
vpshufd	$0xfa, %ymm1, %ymm7
xorl	%r13d, %r14d
leal	(%r11,%rsi), %r11d
movl	%r8d, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0x84(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %edx, %esi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
vpslld	$0xb, %ymm5, %ymm5
andnl	%r9d, %edx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %edx, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %esi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %esi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
vpsrlq	$0x11, %ymm7, %ymm7
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%eax, %r15d
vpaddd	%ymm4, %ymm2, %ymm2
xorl	%r13d, %r14d
leal	(%r10,%r15), %r10d
movl	%edx, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0x88(%rsp), %r9d
andl	%ecx, %r12d
rorxl	$0x19, %ecx, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %ecx, %r15d
leal	(%r10,%r14), %r10d
leal	(%r9,%r12), %r9d
vpxor	%ymm7, %ymm6, %ymm6
andnl	%r8d, %ecx, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %ecx, %r14d
vpshufd	$0x84, %ymm6, %ymm6
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
vpsrldq	$0x8, %ymm6, %ymm6
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
vpaddd	%ymm6, %ymm2, %ymm2
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
vpshufd	$0x50, %ymm2, %ymm7
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r11d, %esi
vpsrld	$0xa, %ymm7, %ymm6
xorl	%r13d, %r14d
leal	(%r9,%rsi), %r9d
movl	%ecx, %r12d
vpsrlq	$0x11, %ymm7, %ymm7
addl	0x8c(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
vpxor	%ymm7, %ymm6, %ymm6
rorxl	$0xb, %ebx, %esi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
vpsrlq	$0x2, %ymm7, %ymm7
andnl	%edx, %ebx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %ebx, %r14d
vpxor	%ymm7, %ymm6, %ymm6
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %esi
vpshufd	$0xe8, %ymm6, %ymm6
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %esi
vpslldq	$0x8, %ymm6, %ymm6
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
vpaddd	%ymm6, %ymm2, %ymm2
andl	%esi, %r15d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r10d, %r15d
vpaddd	0x40(%rbp), %ymm2, %ymm6
xorl	%r13d, %r14d
leal	(%r8,%r15), %r8d
movl	%ebx, %r12d
vmovdqa	%ymm6, (%rsp)
vpalignr	$0x4, %ymm3, %ymm0, %ymm4
addl	0xa0(%rsp), %edx
andl	%eax, %r12d
rorxl	$0x19, %eax, %r13d
vpalignr	$0x4, %ymm1, %ymm2, %ymm7
rorxl	$0xb, %eax, %r15d
leal	(%r8,%r14), %r8d
leal	(%rdx,%r12), %edx
vpsrld	$0x7, %ymm4, %ymm6
andnl	%ecx, %eax, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %eax, %r14d
vpaddd	%ymm7, %ymm3, %ymm3
leal	(%rdx,%r12), %edx
xorl	%r14d, %r13d
movl	%r8d, %r15d
vpsrld	$0x3, %ymm4, %ymm7
rorxl	$0x16, %r8d, %r12d
leal	(%rdx,%r13), %edx
xorl	%r9d, %r15d
vpslld	$0xe, %ymm4, %ymm5
rorxl	$0xd, %r8d, %r14d
rorxl	$0x2, %r8d, %r13d
leal	(%r11,%rdx), %r11d
vpxor	%ymm6, %ymm7, %ymm4
andl	%r15d, %esi
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r9d, %esi
vpshufd	$0xfa, %ymm2, %ymm7
xorl	%r13d, %r14d
leal	(%rdx,%rsi), %edx
movl	%eax, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0xa4(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %r11d, %esi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
vpslld	$0xb, %ymm5, %ymm5
andnl	%ebx, %r11d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r11d, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %esi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %esi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
vpsrlq	$0x11, %ymm7, %ymm7
andl	%esi, %r15d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r8d, %r15d
vpaddd	%ymm4, %ymm3, %ymm3
xorl	%r13d, %r14d
leal	(%rcx,%r15), %ecx
movl	%r11d, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0xa8(%rsp), %ebx
andl	%r10d, %r12d
rorxl	$0x19, %r10d, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %r10d, %r15d
leal	(%rcx,%r14), %ecx
leal	(%rbx,%r12), %ebx
vpxor	%ymm7, %ymm6, %ymm6
andnl	%eax, %r10d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r10d, %r14d
vpshufd	$0x84, %ymm6, %ymm6
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
vpsrldq	$0x8, %ymm6, %ymm6
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
vpaddd	%ymm6, %ymm3, %ymm3
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
vpshufd	$0x50, %ymm3, %ymm7
andl	%r15d, %esi
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%edx, %esi
vpsrld	$0xa, %ymm7, %ymm6
xorl	%r13d, %r14d
leal	(%rbx,%rsi), %ebx
movl	%r10d, %r12d
vpsrlq	$0x11, %ymm7, %ymm7
addl	0xac(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
vpxor	%ymm7, %ymm6, %ymm6
rorxl	$0xb, %r9d, %esi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
vpsrlq	$0x2, %ymm7, %ymm7
andnl	%r11d, %r9d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r9d, %r14d
vpxor	%ymm7, %ymm6, %ymm6
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %esi
vpshufd	$0xe8, %ymm6, %ymm6
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %esi
vpslldq	$0x8, %ymm6, %ymm6
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
vpaddd	%ymm6, %ymm3, %ymm3
andl	%esi, %r15d
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ecx, %r15d
vpaddd	0x60(%rbp), %ymm3, %ymm6
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
vmovdqa	%ymm6, 0x20(%rsp)
vmovq	%xmm15, %r13
vpextrq	$0x1, %xmm15, %r15
vpand	%xmm14, %xmm11, %xmm11
vpor	%xmm11, %xmm8, %xmm8
vmovdqu	%xmm8, (%r15,%r13)
leaq	0x10(%r13), %r13
leaq	0x80(%rbp), %rbp
cmpb	$0x0, 0x3(%rbp)
jne	L_2340
vmovdqu	(%r13), %xmm9
vpinsrq	$0x0, %r13, %xmm15, %xmm15
addl	0x40(%rsp), %r11d
andl	%r8d, %r12d
rorxl	$0x19, %r8d, %r13d
rorxl	$0xb, %r8d, %r15d
leal	(%rax,%r14), %eax
leal	(%r11,%r12), %r11d
andnl	%r10d, %r8d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r8d, %r14d
leal	(%r11,%r12), %r11d
xorl	%r14d, %r13d
movl	%eax, %r15d
rorxl	$0x16, %eax, %r12d
leal	(%r11,%r13), %r11d
xorl	%ebx, %r15d
rorxl	$0xd, %eax, %r14d
rorxl	$0x2, %eax, %r13d
leal	(%rdx,%r11), %edx
andl	%r15d, %esi
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ebx, %esi
xorl	%r13d, %r14d
leal	(%r11,%rsi), %r11d
movl	%r8d, %r12d
addl	0x44(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %esi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %esi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %esi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%esi, %r15d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%r12d, %r14d
xorl	%eax, %r15d
xorl	%r13d, %r14d
leal	(%r10,%r15), %r10d
movl	%edx, %r12d
addl	0x48(%rsp), %r9d
andl	%ecx, %r12d
rorxl	$0x19, %ecx, %r13d
rorxl	$0xb, %ecx, %r15d
leal	(%r10,%r14), %r10d
leal	(%r9,%r12), %r9d
andnl	%r8d, %ecx, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %ecx, %r14d
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r11d, %esi
xorl	%r13d, %r14d
leal	(%r9,%rsi), %r9d
movl	%ecx, %r12d
addl	0x4c(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %esi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %esi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %esi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r10d, %r15d
xorl	%r13d, %r14d
leal	(%r8,%r15), %r8d
movl	%ebx, %r12d
addl	0x60(%rsp), %edx
andl	%eax, %r12d
rorxl	$0x19, %eax, %r13d
rorxl	$0xb, %eax, %r15d
leal	(%r8,%r14), %r8d
leal	(%rdx,%r12), %edx
andnl	%ecx, %eax, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %eax, %r14d
leal	(%rdx,%r12), %edx
xorl	%r14d, %r13d
movl	%r8d, %r15d
rorxl	$0x16, %r8d, %r12d
leal	(%rdx,%r13), %edx
xorl	%r9d, %r15d
rorxl	$0xd, %r8d, %r14d
rorxl	$0x2, %r8d, %r13d
leal	(%r11,%rdx), %r11d
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r9d, %esi
xorl	%r13d, %r14d
leal	(%rdx,%rsi), %edx
movl	%eax, %r12d
addl	0x64(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %esi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %esi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %esi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r8d, %r15d
xorl	%r13d, %r14d
leal	(%rcx,%r15), %ecx
movl	%r11d, %r12d
addl	0x68(%rsp), %ebx
andl	%r10d, %r12d
rorxl	$0x19, %r10d, %r13d
rorxl	$0xb, %r10d, %r15d
leal	(%rcx,%r14), %ecx
leal	(%rbx,%r12), %ebx
andnl	%eax, %r10d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r10d, %r14d
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%edx, %esi
xorl	%r13d, %r14d
leal	(%rbx,%rsi), %ebx
movl	%r10d, %r12d
addl	0x6c(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %esi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %esi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %esi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
addl	(%rsp), %r11d
andl	%r8d, %r12d
rorxl	$0x19, %r8d, %r13d
rorxl	$0xb, %r8d, %r15d
leal	(%rax,%r14), %eax
leal	(%r11,%r12), %r11d
andnl	%r10d, %r8d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r8d, %r14d
leal	(%r11,%r12), %r11d
xorl	%r14d, %r13d
movl	%eax, %r15d
rorxl	$0x16, %eax, %r12d
leal	(%r11,%r13), %r11d
xorl	%ebx, %r15d
rorxl	$0xd, %eax, %r14d
rorxl	$0x2, %eax, %r13d
leal	(%rdx,%r11), %edx
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ebx, %esi
xorl	%r13d, %r14d
leal	(%r11,%rsi), %r11d
movl	%r8d, %r12d
addl	0x4(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %esi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %esi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %esi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%eax, %r15d
xorl	%r13d, %r14d
leal	(%r10,%r15), %r10d
movl	%edx, %r12d
addl	0x8(%rsp), %r9d
andl	%ecx, %r12d
rorxl	$0x19, %ecx, %r13d
rorxl	$0xb, %ecx, %r15d
leal	(%r10,%r14), %r10d
leal	(%r9,%r12), %r9d
andnl	%r8d, %ecx, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %ecx, %r14d
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r11d, %esi
xorl	%r13d, %r14d
leal	(%r9,%rsi), %r9d
movl	%ecx, %r12d
addl	0xc(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %esi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %esi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %esi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%esi, %r15d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r10d, %r15d
xorl	%r13d, %r14d
leal	(%r8,%r15), %r8d
movl	%ebx, %r12d
addl	0x20(%rsp), %edx
andl	%eax, %r12d
rorxl	$0x19, %eax, %r13d
rorxl	$0xb, %eax, %r15d
leal	(%r8,%r14), %r8d
leal	(%rdx,%r12), %edx
andnl	%ecx, %eax, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %eax, %r14d
leal	(%rdx,%r12), %edx
xorl	%r14d, %r13d
movl	%r8d, %r15d
rorxl	$0x16, %r8d, %r12d
leal	(%rdx,%r13), %edx
xorl	%r9d, %r15d
rorxl	$0xd, %r8d, %r14d
rorxl	$0x2, %r8d, %r13d
leal	(%r11,%rdx), %r11d
andl	%r15d, %esi
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r9d, %esi
xorl	%r13d, %r14d
leal	(%rdx,%rsi), %edx
movl	%eax, %r12d
addl	0x24(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %esi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %esi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %esi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%esi, %r15d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r8d, %r15d
xorl	%r13d, %r14d
leal	(%rcx,%r15), %ecx
movl	%r11d, %r12d
addl	0x28(%rsp), %ebx
andl	%r10d, %r12d
rorxl	$0x19, %r10d, %r13d
rorxl	$0xb, %r10d, %r15d
leal	(%rcx,%r14), %ecx
leal	(%rbx,%r12), %ebx
andnl	%eax, %r10d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r10d, %r14d
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
andl	%r15d, %esi
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%edx, %esi
xorl	%r13d, %r14d
leal	(%rbx,%rsi), %ebx
movl	%r10d, %r12d
addl	0x2c(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %esi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %esi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %esi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%esi, %r15d
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
vpextrq	$0x1, %xmm15, %r12
vmovq	%xmm15, %r13
movq	0x228(%rsp), %r15
addl	%r14d, %eax
leaq	0x1c0(%rsp), %rbp
vpand	%xmm14, %xmm11, %xmm11
vpor	%xmm11, %xmm8, %xmm8
vmovdqu	%xmm8, (%r12,%r13)
leaq	0x10(%r13), %r13
addl	(%r15), %eax
addl	0x4(%r15), %ebx
addl	0x8(%r15), %ecx
addl	0xc(%r15), %edx
addl	0x10(%r15), %r8d
addl	0x14(%r15), %r9d
addl	0x18(%r15), %r10d
addl	0x1c(%r15), %r11d
movl	%eax, (%r15)
movl	%ebx, 0x4(%r15)
movl	%ecx, 0x8(%r15)
movl	%edx, 0xc(%r15)
movl	%r8d, 0x10(%r15)
movl	%r9d, 0x14(%r15)
movl	%r10d, 0x18(%r15)
movl	%r11d, 0x1c(%r15)
cmpq	0x50(%rbp), %r13
je	L_3bfb
xorl	%r14d, %r14d
movl	%ebx, %esi
movl	%r9d, %r12d
xorl	%ecx, %esi
jmp	L_3480
nopl	(%rax)
L_3480:
vmovdqu	(%r13), %xmm9
vpinsrq	$0x0, %r13, %xmm15, %xmm15
addl	0x10(%rbp), %r11d
andl	%r8d, %r12d
rorxl	$0x19, %r8d, %r13d
rorxl	$0xb, %r8d, %r15d
leal	(%rax,%r14), %eax
leal	(%r11,%r12), %r11d
andnl	%r10d, %r8d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r8d, %r14d
leal	(%r11,%r12), %r11d
xorl	%r14d, %r13d
movl	%eax, %r15d
rorxl	$0x16, %eax, %r12d
leal	(%r11,%r13), %r11d
xorl	%ebx, %r15d
rorxl	$0xd, %eax, %r14d
rorxl	$0x2, %eax, %r13d
leal	(%rdx,%r11), %edx
andl	%r15d, %esi
vpxor	%xmm10, %xmm9, %xmm9
vmovdqu	-0x70(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ebx, %esi
xorl	%r13d, %r14d
leal	(%r11,%rsi), %r11d
movl	%r8d, %r12d
addl	0x14(%rbp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %esi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %esi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %esi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%esi, %r15d
vpxor	%xmm8, %xmm9, %xmm9
xorl	%r12d, %r14d
xorl	%eax, %r15d
xorl	%r13d, %r14d
leal	(%r10,%r15), %r10d
movl	%edx, %r12d
addl	0x18(%rbp), %r9d
andl	%ecx, %r12d
rorxl	$0x19, %ecx, %r13d
rorxl	$0xb, %ecx, %r15d
leal	(%r10,%r14), %r10d
leal	(%r9,%r12), %r9d
andnl	%r8d, %ecx, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %ecx, %r14d
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x60(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r11d, %esi
xorl	%r13d, %r14d
leal	(%r9,%rsi), %r9d
movl	%ecx, %r12d
addl	0x1c(%rbp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %esi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %esi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %esi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x50(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r10d, %r15d
xorl	%r13d, %r14d
leal	(%r8,%r15), %r8d
movl	%ebx, %r12d
addl	0x30(%rbp), %edx
andl	%eax, %r12d
rorxl	$0x19, %eax, %r13d
rorxl	$0xb, %eax, %r15d
leal	(%r8,%r14), %r8d
leal	(%rdx,%r12), %edx
andnl	%ecx, %eax, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %eax, %r14d
leal	(%rdx,%r12), %edx
xorl	%r14d, %r13d
movl	%r8d, %r15d
rorxl	$0x16, %r8d, %r12d
leal	(%rdx,%r13), %edx
xorl	%r9d, %r15d
rorxl	$0xd, %r8d, %r14d
rorxl	$0x2, %r8d, %r13d
leal	(%r11,%rdx), %r11d
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x40(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r9d, %esi
xorl	%r13d, %r14d
leal	(%rdx,%rsi), %edx
movl	%eax, %r12d
addl	0x34(%rbp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %esi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %esi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %esi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x30(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r8d, %r15d
xorl	%r13d, %r14d
leal	(%rcx,%r15), %ecx
movl	%r11d, %r12d
addl	0x38(%rbp), %ebx
andl	%r10d, %r12d
rorxl	$0x19, %r10d, %r13d
rorxl	$0xb, %r10d, %r15d
leal	(%rcx,%r14), %ecx
leal	(%rbx,%r12), %ebx
andnl	%eax, %r10d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r10d, %r14d
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x20(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%edx, %esi
xorl	%r13d, %r14d
leal	(%rbx,%rsi), %ebx
movl	%r10d, %r12d
addl	0x3c(%rbp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %esi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %esi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %esi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	-0x10(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
leaq	-0x40(%rbp), %rbp
addl	0x10(%rbp), %r11d
andl	%r8d, %r12d
rorxl	$0x19, %r8d, %r13d
rorxl	$0xb, %r8d, %r15d
leal	(%rax,%r14), %eax
leal	(%r11,%r12), %r11d
andnl	%r10d, %r8d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r8d, %r14d
leal	(%r11,%r12), %r11d
xorl	%r14d, %r13d
movl	%eax, %r15d
rorxl	$0x16, %eax, %r12d
leal	(%r11,%r13), %r11d
xorl	%ebx, %r15d
rorxl	$0xd, %eax, %r14d
rorxl	$0x2, %eax, %r13d
leal	(%rdx,%r11), %edx
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ebx, %esi
xorl	%r13d, %r14d
leal	(%r11,%rsi), %r11d
movl	%r8d, %r12d
addl	0x14(%rbp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %esi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %esi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %esi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%esi, %r15d
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x10(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%eax, %r15d
xorl	%r13d, %r14d
leal	(%r10,%r15), %r10d
movl	%edx, %r12d
addl	0x18(%rbp), %r9d
andl	%ecx, %r12d
rorxl	$0x19, %ecx, %r13d
rorxl	$0xb, %ecx, %r15d
leal	(%r10,%r14), %r10d
leal	(%r9,%r12), %r9d
andnl	%r8d, %ecx, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %ecx, %r14d
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
andl	%r15d, %esi
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x20(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r11d, %esi
xorl	%r13d, %r14d
leal	(%r9,%rsi), %r9d
movl	%ecx, %r12d
addl	0x1c(%rbp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %esi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %esi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %esi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%esi, %r15d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x30(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r10d, %r15d
xorl	%r13d, %r14d
leal	(%r8,%r15), %r8d
movl	%ebx, %r12d
addl	0x30(%rbp), %edx
andl	%eax, %r12d
rorxl	$0x19, %eax, %r13d
rorxl	$0xb, %eax, %r15d
leal	(%r8,%r14), %r8d
leal	(%rdx,%r12), %edx
andnl	%ecx, %eax, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %eax, %r14d
leal	(%rdx,%r12), %edx
xorl	%r14d, %r13d
movl	%r8d, %r15d
rorxl	$0x16, %r8d, %r12d
leal	(%rdx,%r13), %edx
xorl	%r9d, %r15d
rorxl	$0xd, %r8d, %r14d
rorxl	$0x2, %r8d, %r13d
leal	(%r11,%rdx), %r11d
andl	%r15d, %esi
vpand	%xmm12, %xmm11, %xmm8
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x40(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r9d, %esi
xorl	%r13d, %r14d
leal	(%rdx,%rsi), %edx
movl	%eax, %r12d
addl	0x34(%rbp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %esi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %esi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %esi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%esi, %r15d
vaesenclast	%xmm10, %xmm9, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x50(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%r8d, %r15d
xorl	%r13d, %r14d
leal	(%rcx,%r15), %ecx
movl	%r11d, %r12d
addl	0x38(%rbp), %ebx
andl	%r10d, %r12d
rorxl	$0x19, %r10d, %r13d
rorxl	$0xb, %r10d, %r15d
leal	(%rcx,%r14), %ecx
leal	(%rbx,%r12), %ebx
andnl	%eax, %r10d, %r12d
xorl	%r15d, %r13d
rorxl	$0x6, %r10d, %r14d
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
andl	%r15d, %esi
vpand	%xmm13, %xmm11, %xmm11
vaesenc	%xmm10, %xmm9, %xmm9
vmovdqu	0x60(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%edx, %esi
xorl	%r13d, %r14d
leal	(%rbx,%rsi), %ebx
movl	%r10d, %r12d
addl	0x3c(%rbp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %esi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%esi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %esi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %esi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%esi, %r15d
vpor	%xmm11, %xmm8, %xmm8
vaesenclast	%xmm10, %xmm9, %xmm11
vmovdqu	-0x80(%rdi), %xmm10
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
vmovq	%xmm15, %r13
vpextrq	$0x1, %xmm15, %r15
vpand	%xmm14, %xmm11, %xmm11
vpor	%xmm11, %xmm8, %xmm8
leaq	-0x40(%rbp), %rbp
vmovdqu	%xmm8, (%r15,%r13)
leaq	0x10(%r13), %r13
cmpq	%rsp, %rbp
jae	L_3480
movq	0x228(%rsp), %r15
leaq	0x40(%r13), %r13
movq	0x230(%rsp), %rsi
addl	%r14d, %eax
leaq	0x1c0(%rsp), %rsp
addl	(%r15), %eax
addl	0x4(%r15), %ebx
addl	0x8(%r15), %ecx
addl	0xc(%r15), %edx
addl	0x10(%r15), %r8d
addl	0x14(%r15), %r9d
addl	0x18(%r15), %r10d
leaq	(%rsi,%r13), %r12
addl	0x1c(%r15), %r11d
cmpq	0x50(%rsp), %r13
movl	%eax, (%r15)
cmoveq	%rsp, %r12
movl	%ebx, 0x4(%r15)
movl	%ecx, 0x8(%r15)
movl	%edx, 0xc(%r15)
movl	%r8d, 0x10(%r15)
movl	%r9d, 0x14(%r15)
movl	%r10d, 0x18(%r15)
movl	%r11d, 0x1c(%r15)
jbe	L_2290
leaq	(%rsp), %rbp
L_3bfb:
movq	0x60(%rbp), %r8
movq	0x78(%rbp), %rsi
vmovdqu	%xmm8, (%r8)
vzeroall
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
aesni_cbc_sha256_enc_shaext:
movq	0x8(%rsp), %r10
leaq	K256+128(%rip), %rax
movdqu	(%r9), %xmm1
movdqu	0x10(%r9), %xmm2
movdqa	0x180(%rax), %xmm3
movl	0xf0(%rcx), %r11d
subq	%rdi, %rsi
movups	(%rcx), %xmm15
movups	(%r8), %xmm6
movups	0x10(%rcx), %xmm4
leaq	0x70(%rcx), %rcx
pshufd	$0x1b, %xmm1, %xmm0
pshufd	$0xb1, %xmm1, %xmm1
pshufd	$0x1b, %xmm2, %xmm2
movdqa	%xmm3, %xmm7
palignr	$0x8, %xmm2, %xmm1
punpcklqdq	%xmm0, %xmm2
jmp	L_3ca0
nopl	(%rax,%rax)
L_3ca0:
movdqu	(%r10), %xmm10
movdqu	0x10(%r10), %xmm11
movdqu	0x20(%r10), %xmm12
pshufb	%xmm3, %xmm10
movdqu	0x30(%r10), %xmm13
movdqa	-0x80(%rax), %xmm0
paddd	%xmm10, %xmm0
pshufb	%xmm3, %xmm11
movdqa	%xmm2, %xmm9
movdqa	%xmm1, %xmm8
movups	(%rdi), %xmm14
xorps	%xmm15, %xmm14
xorps	%xmm14, %xmm6
movups	-0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movups	-0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	-0x60(%rax), %xmm0
paddd	%xmm11, %xmm0
pshufb	%xmm3, %xmm12
leaq	0x40(%r10), %r10
movups	-0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movups	-0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	-0x40(%rax), %xmm0
paddd	%xmm12, %xmm0
pshufb	%xmm3, %xmm13
sha256msg1	%xmm11, %xmm10
movups	-0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm13, %xmm3
palignr	$0x4, %xmm12, %xmm3
paddd	%xmm3, %xmm10
movups	(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	-0x20(%rax), %xmm0
paddd	%xmm13, %xmm0
sha256msg2	%xmm13, %xmm10
sha256msg1	%xmm12, %xmm11
movups	0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movups	0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movdqa	%xmm10, %xmm3
palignr	$0x4, %xmm13, %xmm3
paddd	%xmm3, %xmm11
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	(%rax), %xmm0
paddd	%xmm10, %xmm0
sha256msg2	%xmm10, %xmm11
sha256msg1	%xmm13, %xmm12
movups	0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm11, %xmm3
palignr	$0x4, %xmm10, %xmm3
paddd	%xmm3, %xmm12
cmpl	$0xb, %r11d
jb	L_3e1f
movups	0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
je	L_3e1f
movups	0x60(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x70(%rcx), %xmm5
aesenc	%xmm4, %xmm6
L_3e1f:
aesenclast	%xmm5, %xmm6
movups	-0x60(%rcx), %xmm4
nop
sha256rnds2	%xmm0, %xmm2, %xmm1
movups	0x10(%rdi), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm6, (%rsi,%rdi)
xorps	%xmm14, %xmm6
movups	-0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
movdqa	0x20(%rax), %xmm0
paddd	%xmm11, %xmm0
sha256msg2	%xmm11, %xmm12
sha256msg1	%xmm10, %xmm13
movups	-0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm12, %xmm3
palignr	$0x4, %xmm11, %xmm3
paddd	%xmm3, %xmm13
movups	-0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x40(%rax), %xmm0
paddd	%xmm12, %xmm0
sha256msg2	%xmm12, %xmm13
sha256msg1	%xmm11, %xmm10
movups	-0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm13, %xmm3
palignr	$0x4, %xmm12, %xmm3
paddd	%xmm3, %xmm10
movups	-0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x60(%rax), %xmm0
paddd	%xmm13, %xmm0
sha256msg2	%xmm13, %xmm10
sha256msg1	%xmm12, %xmm11
movups	(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm10, %xmm3
palignr	$0x4, %xmm13, %xmm3
paddd	%xmm3, %xmm11
movups	0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x80(%rax), %xmm0
paddd	%xmm10, %xmm0
sha256msg2	%xmm10, %xmm11
sha256msg1	%xmm13, %xmm12
movups	0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm11, %xmm3
palignr	$0x4, %xmm10, %xmm3
paddd	%xmm3, %xmm12
movups	0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
cmpl	$0xb, %r11d
jb	L_3f81
movups	0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
je	L_3f81
movups	0x60(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x70(%rcx), %xmm5
aesenc	%xmm4, %xmm6
L_3f81:
aesenclast	%xmm5, %xmm6
movups	-0x60(%rcx), %xmm4
nop
sha256rnds2	%xmm0, %xmm2, %xmm1
movups	0x20(%rdi), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm6, 0x10(%rsi,%rdi)
xorps	%xmm14, %xmm6
movups	-0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
movdqa	0xa0(%rax), %xmm0
paddd	%xmm11, %xmm0
sha256msg2	%xmm11, %xmm12
sha256msg1	%xmm10, %xmm13
movups	-0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm12, %xmm3
palignr	$0x4, %xmm11, %xmm3
paddd	%xmm3, %xmm13
movups	-0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0xc0(%rax), %xmm0
paddd	%xmm12, %xmm0
sha256msg2	%xmm12, %xmm13
sha256msg1	%xmm11, %xmm10
movups	-0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm13, %xmm3
palignr	$0x4, %xmm12, %xmm3
paddd	%xmm3, %xmm10
movups	-0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0xe0(%rax), %xmm0
paddd	%xmm13, %xmm0
sha256msg2	%xmm13, %xmm10
sha256msg1	%xmm12, %xmm11
movups	(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm10, %xmm3
palignr	$0x4, %xmm13, %xmm3
paddd	%xmm3, %xmm11
movups	0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x100(%rax), %xmm0
paddd	%xmm10, %xmm0
sha256msg2	%xmm10, %xmm11
sha256msg1	%xmm13, %xmm12
movups	0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm11, %xmm3
palignr	$0x4, %xmm10, %xmm3
paddd	%xmm3, %xmm12
movups	0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x120(%rax), %xmm0
paddd	%xmm11, %xmm0
sha256msg2	%xmm11, %xmm12
sha256msg1	%xmm10, %xmm13
cmpl	$0xb, %r11d
jb	L_4108
movups	0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
je	L_4108
movups	0x60(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x70(%rcx), %xmm5
aesenc	%xmm4, %xmm6
L_4108:
aesenclast	%xmm5, %xmm6
movups	-0x60(%rcx), %xmm4
nop
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm12, %xmm3
palignr	$0x4, %xmm11, %xmm3
paddd	%xmm3, %xmm13
movups	0x30(%rdi), %xmm14
xorps	%xmm15, %xmm14
movups	%xmm6, 0x20(%rsi,%rdi)
xorps	%xmm14, %xmm6
movups	-0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
movups	-0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x140(%rax), %xmm0
paddd	%xmm12, %xmm0
sha256msg2	%xmm12, %xmm13
movdqa	%xmm7, %xmm3
movups	-0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movups	-0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x160(%rax), %xmm0
paddd	%xmm13, %xmm0
movups	-0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
movups	(%rcx), %xmm4
aesenc	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movups	0x10(%rcx), %xmm5
aesenc	%xmm4, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movups	0x20(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x30(%rcx), %xmm5
aesenc	%xmm4, %xmm6
cmpl	$0xb, %r11d
jb	L_41fb
movups	0x40(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x50(%rcx), %xmm5
aesenc	%xmm4, %xmm6
je	L_41fb
movups	0x60(%rcx), %xmm4
aesenc	%xmm5, %xmm6
movups	0x70(%rcx), %xmm5
aesenc	%xmm4, %xmm6
L_41fb:
aesenclast	%xmm5, %xmm6
movups	-0x60(%rcx), %xmm4
nop
paddd	%xmm9, %xmm2
paddd	%xmm8, %xmm1
decq	%rdx
movups	%xmm6, 0x30(%rsi,%rdi)
leaq	0x40(%rdi), %rdi
jne	L_3ca0
pshufd	$0xb1, %xmm2, %xmm2
pshufd	$0x1b, %xmm1, %xmm3
pshufd	$0xb1, %xmm1, %xmm1
punpckhqdq	%xmm2, %xmm1
palignr	$0x8, %xmm3, %xmm2
movups	%xmm6, (%r8)
movdqu	%xmm1, (%r9)
movdqu	%xmm2, 0x10(%r9)
rep	retq
	.section .rodata
K256:
	.byte 152,47,138,66,145,68,55,113,207,251,192,181,165,219,181,233
	.byte 152,47,138,66,145,68,55,113,207,251,192,181,165,219,181,233
	.byte 91,194,86,57,241,17,241,89,164,130,63,146,213,94,28,171
	.byte 91,194,86,57,241,17,241,89,164,130,63,146,213,94,28,171
	.byte 152,170,7,216,1,91,131,18,190,133,49,36,195,125,12,85
	.byte 152,170,7,216,1,91,131,18,190,133,49,36,195,125,12,85
	.byte 116,93,190,114,254,177,222,128,167,6,220,155,116,241,155,193
	.byte 116,93,190,114,254,177,222,128,167,6,220,155,116,241,155,193
	.byte 193,105,155,228,134,71,190,239,198,157,193,15,204,161,12,36
	.byte 193,105,155,228,134,71,190,239,198,157,193,15,204,161,12,36
	.byte 111,44,233,45,170,132,116,74,220,169,176,92,218,136,249,118
	.byte 111,44,233,45,170,132,116,74,220,169,176,92,218,136,249,118
	.byte 82,81,62,152,109,198,49,168,200,39,3,176,199,127,89,191
	.byte 82,81,62,152,109,198,49,168,200,39,3,176,199,127,89,191
	.byte 243,11,224,198,71,145,167,213,81,99,202,6,103,41,41,20
	.byte 243,11,224,198,71,145,167,213,81,99,202,6,103,41,41,20
	.byte 133,10,183,39,56,33,27,46,252,109,44,77,19,13,56,83
	.byte 133,10,183,39,56,33,27,46,252,109,44,77,19,13,56,83
	.byte 84,115,10,101,187,10,106,118,46,201,194,129,133,44,114,146
	.byte 84,115,10,101,187,10,106,118,46,201,194,129,133,44,114,146
	.byte 161,232,191,162,75,102,26,168,112,139,75,194,163,81,108,199
	.byte 161,232,191,162,75,102,26,168,112,139,75,194,163,81,108,199
	.byte 25,232,146,209,36,6,153,214,133,53,14,244,112,160,106,16
	.byte 25,232,146,209,36,6,153,214,133,53,14,244,112,160,106,16
	.byte 22,193,164,25,8,108,55,30,76,119,72,39,181,188,176,52
	.byte 22,193,164,25,8,108,55,30,76,119,72,39,181,188,176,52
	.byte 179,12,28,57,74,170,216,78,79,202,156,91,243,111,46,104
	.byte 179,12,28,57,74,170,216,78,79,202,156,91,243,111,46,104
	.byte 238,130,143,116,111,99,165,120,20,120,200,132,8,2,199,140
	.byte 238,130,143,116,111,99,165,120,20,120,200,132,8,2,199,140
	.byte 250,255,190,144,235,108,80,164,247,163,249,190,242,120,113,198
	.byte 250,255,190,144,235,108,80,164,247,163,249,190,242,120,113,198
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 65,69,83,78,73,45,67,66,67,43,83,72,65,50,53,54
	.byte 32,115,116,105,116,99,104,32,102,111,114,32,120,56,54,95
	.byte 54,52,44,32,67,82,89,80,84,79,71,65,77,83,32,98
	.byte 121,32,60,104,116,116,112,115,58,47,47,103,105,116,104,117
	.byte 98,46,99,111,109,47,100,111,116,45,97,115,109,62,0,0

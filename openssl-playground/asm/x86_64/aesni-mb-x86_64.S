	.text
aesni_multi_cbc_encrypt:
cmpl	$0x2, %edx
jb	L_20
movl	OPENSSL_ia32cap_P+4(%rip), %ecx
testl	$0x10000000, %ecx
jne	_avx_cbc_enc_shortcut
jmp	L_20
nopl	(%rax)
L_20:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x30, %rsp
andq	$-0x40, %rsp
movq	%rax, 0x10(%rsp)
movdqu	(%rsi), %xmm12
leaq	0x78(%rsi), %rsi
leaq	0x50(%rdi), %rdi
L_47:
movl	%edx, 0x18(%rsp)
xorl	%edx, %edx
movl	-0x40(%rdi), %ecx
movq	-0x50(%rdi), %r8
cmpl	%edx, %ecx
movq	-0x48(%rdi), %r12
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	-0x38(%rdi), %xmm2
movl	%ecx, 0x20(%rsp)
cmovleq	%rsp, %r8
movl	-0x18(%rdi), %ecx
movq	-0x28(%rdi), %r9
cmpl	%edx, %ecx
movq	-0x20(%rdi), %r13
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	-0x10(%rdi), %xmm3
movl	%ecx, 0x24(%rsp)
cmovleq	%rsp, %r9
movl	0x10(%rdi), %ecx
movq	(%rdi), %r10
cmpl	%edx, %ecx
movq	0x8(%rdi), %r14
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	0x18(%rdi), %xmm4
movl	%ecx, 0x28(%rsp)
cmovleq	%rsp, %r10
movl	0x38(%rdi), %ecx
movq	0x28(%rdi), %r11
cmpl	%edx, %ecx
movq	0x30(%rdi), %r15
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	0x40(%rdi), %xmm5
movl	%ecx, 0x2c(%rsp)
cmovleq	%rsp, %r11
testl	%edx, %edx
je	L_3a8
movups	-0x68(%rsi), %xmm1
pxor	%xmm12, %xmm2
movups	-0x58(%rsi), %xmm0
pxor	%xmm12, %xmm3
movl	0x78(%rsi), %eax
pxor	%xmm12, %xmm4
movdqu	(%r8), %xmm6
pxor	%xmm12, %xmm5
movdqu	(%r9), %xmm7
pxor	%xmm6, %xmm2
movdqu	(%r10), %xmm8
pxor	%xmm7, %xmm3
movdqu	(%r11), %xmm9
pxor	%xmm8, %xmm4
pxor	%xmm9, %xmm5
movdqa	0x20(%rsp), %xmm10
xorq	%rbx, %rbx
jmp	L_140
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_140:
addq	$0x10, %rbx
leaq	0x10(%rsp), %rbp
movl	$0x1, %ecx
subq	%rbx, %rbp
aesenc	%xmm1, %xmm2
prefetcht0	0x1f(%r8,%rbx)
prefetcht0	0x1f(%r9,%rbx)
aesenc	%xmm1, %xmm3
prefetcht0	0x1f(%r10,%rbx)
prefetcht0	0x1f(%r10,%rbx)
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	-0x48(%rsi), %xmm1
cmpl	0x20(%rsp), %ecx
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
cmovgeq	%rbp, %r8
cmovgq	%rbp, %r12
aesenc	%xmm0, %xmm5
movups	-0x38(%rsi), %xmm0
cmpl	0x24(%rsp), %ecx
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
cmovgeq	%rbp, %r9
cmovgq	%rbp, %r13
aesenc	%xmm1, %xmm5
movups	-0x28(%rsi), %xmm1
cmpl	0x28(%rsp), %ecx
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
cmovgeq	%rbp, %r10
cmovgq	%rbp, %r14
aesenc	%xmm0, %xmm5
movups	-0x18(%rsi), %xmm0
cmpl	0x2c(%rsp), %ecx
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
cmovgeq	%rbp, %r11
cmovgq	%rbp, %r15
aesenc	%xmm1, %xmm5
movups	-0x8(%rsi), %xmm1
movdqa	%xmm10, %xmm11
aesenc	%xmm0, %xmm2
prefetcht0	0xf(%r12,%rbx)
prefetcht0	0xf(%r13,%rbx)
aesenc	%xmm0, %xmm3
prefetcht0	0xf(%r14,%rbx)
prefetcht0	0xf(%r15,%rbx)
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	0x8(%rsi), %xmm0
pxor	%xmm12, %xmm12
aesenc	%xmm1, %xmm2
pcmpgtd	%xmm12, %xmm11
movdqu	-0x78(%rsi), %xmm12
aesenc	%xmm1, %xmm3
paddd	%xmm11, %xmm10
movdqa	%xmm10, 0x20(%rsp)
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	0x18(%rsi), %xmm1
cmpl	$0xb, %eax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	0x28(%rsi), %xmm0
jb	L_300
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	0x38(%rsi), %xmm1
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	0x48(%rsi), %xmm0
je	L_300
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	0x58(%rsi), %xmm1
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	0x68(%rsi), %xmm0
jmp	L_300
nopl	(%rax,%rax)
L_300:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movdqu	(%r8,%rbx), %xmm6
movdqu	-0x68(%rsi), %xmm1
aesenclast	%xmm0, %xmm2
movdqu	(%r9,%rbx), %xmm7
pxor	%xmm12, %xmm6
aesenclast	%xmm0, %xmm3
movdqu	(%r10,%rbx), %xmm8
pxor	%xmm12, %xmm7
aesenclast	%xmm0, %xmm4
movdqu	(%r11,%rbx), %xmm9
pxor	%xmm12, %xmm8
aesenclast	%xmm0, %xmm5
movdqu	-0x58(%rsi), %xmm0
pxor	%xmm12, %xmm9
movups	%xmm2, -0x10(%r12,%rbx)
pxor	%xmm6, %xmm2
movups	%xmm3, -0x10(%r13,%rbx)
pxor	%xmm7, %xmm3
movups	%xmm4, -0x10(%r14,%rbx)
pxor	%xmm8, %xmm4
movups	%xmm5, -0x10(%r15,%rbx)
pxor	%xmm9, %xmm5
decl	%edx
jne	L_140
movq	0x10(%rsp), %rax
movl	0x18(%rsp), %edx
leaq	0xa0(%rdi), %rdi
decl	%edx
jne	L_47
L_3a8:
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
aesni_multi_cbc_decrypt:
cmpl	$0x2, %edx
jb	L_400
movl	OPENSSL_ia32cap_P+4(%rip), %ecx
testl	$0x10000000, %ecx
jne	_avx_cbc_dec_shortcut
jmp	L_400
nopl	(%rax)
L_400:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x30, %rsp
andq	$-0x40, %rsp
movq	%rax, 0x10(%rsp)
movdqu	(%rsi), %xmm12
leaq	0x78(%rsi), %rsi
leaq	0x50(%rdi), %rdi
L_427:
movl	%edx, 0x18(%rsp)
xorl	%edx, %edx
movl	-0x40(%rdi), %ecx
movq	-0x50(%rdi), %r8
cmpl	%edx, %ecx
movq	-0x48(%rdi), %r12
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	-0x38(%rdi), %xmm6
movl	%ecx, 0x20(%rsp)
cmovleq	%rsp, %r8
movl	-0x18(%rdi), %ecx
movq	-0x28(%rdi), %r9
cmpl	%edx, %ecx
movq	-0x20(%rdi), %r13
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	-0x10(%rdi), %xmm7
movl	%ecx, 0x24(%rsp)
cmovleq	%rsp, %r9
movl	0x10(%rdi), %ecx
movq	(%rdi), %r10
cmpl	%edx, %ecx
movq	0x8(%rdi), %r14
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	0x18(%rdi), %xmm8
movl	%ecx, 0x28(%rsp)
cmovleq	%rsp, %r10
movl	0x38(%rdi), %ecx
movq	0x28(%rdi), %r11
cmpl	%edx, %ecx
movq	0x30(%rdi), %r15
cmovgl	%ecx, %edx
testl	%ecx, %ecx
movdqu	0x40(%rdi), %xmm9
movl	%ecx, 0x2c(%rsp)
cmovleq	%rsp, %r11
testl	%edx, %edx
je	L_786
movups	-0x68(%rsi), %xmm1
movups	-0x58(%rsi), %xmm0
movl	0x78(%rsi), %eax
movdqu	(%r8), %xmm2
movdqu	(%r9), %xmm3
pxor	%xmm12, %xmm2
movdqu	(%r10), %xmm4
pxor	%xmm12, %xmm3
movdqu	(%r11), %xmm5
pxor	%xmm12, %xmm4
pxor	%xmm12, %xmm5
movdqa	0x20(%rsp), %xmm10
xorq	%rbx, %rbx
jmp	L_500
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_500:
addq	$0x10, %rbx
leaq	0x10(%rsp), %rbp
movl	$0x1, %ecx
subq	%rbx, %rbp
aesdec	%xmm1, %xmm2
prefetcht0	0x1f(%r8,%rbx)
prefetcht0	0x1f(%r9,%rbx)
aesdec	%xmm1, %xmm3
prefetcht0	0x1f(%r10,%rbx)
prefetcht0	0x1f(%r11,%rbx)
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	-0x48(%rsi), %xmm1
cmpl	0x20(%rsp), %ecx
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
cmovgeq	%rbp, %r8
cmovgq	%rbp, %r12
aesdec	%xmm0, %xmm5
movups	-0x38(%rsi), %xmm0
cmpl	0x24(%rsp), %ecx
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
cmovgeq	%rbp, %r9
cmovgq	%rbp, %r13
aesdec	%xmm1, %xmm5
movups	-0x28(%rsi), %xmm1
cmpl	0x28(%rsp), %ecx
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
cmovgeq	%rbp, %r10
cmovgq	%rbp, %r14
aesdec	%xmm0, %xmm5
movups	-0x18(%rsi), %xmm0
cmpl	0x2c(%rsp), %ecx
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
cmovgeq	%rbp, %r11
cmovgq	%rbp, %r15
aesdec	%xmm1, %xmm5
movups	-0x8(%rsi), %xmm1
movdqa	%xmm10, %xmm11
aesdec	%xmm0, %xmm2
prefetcht0	0xf(%r12,%rbx)
prefetcht0	0xf(%r13,%rbx)
aesdec	%xmm0, %xmm3
prefetcht0	0xf(%r14,%rbx)
prefetcht0	0xf(%r15,%rbx)
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	0x8(%rsi), %xmm0
pxor	%xmm12, %xmm12
aesdec	%xmm1, %xmm2
pcmpgtd	%xmm12, %xmm11
movdqu	-0x78(%rsi), %xmm12
aesdec	%xmm1, %xmm3
paddd	%xmm11, %xmm10
movdqa	%xmm10, 0x20(%rsp)
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	0x18(%rsi), %xmm1
cmpl	$0xb, %eax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	0x28(%rsi), %xmm0
jb	L_6c0
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	0x38(%rsi), %xmm1
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	0x48(%rsi), %xmm0
je	L_6c0
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	0x58(%rsi), %xmm1
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	0x68(%rsi), %xmm0
jmp	L_6c0
nopl	(%rax,%rax)
L_6c0:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
pxor	%xmm0, %xmm6
pxor	%xmm0, %xmm7
aesdec	%xmm1, %xmm5
movdqu	-0x68(%rsi), %xmm1
pxor	%xmm0, %xmm8
pxor	%xmm0, %xmm9
movdqu	-0x58(%rsi), %xmm0
aesdeclast	%xmm6, %xmm2
aesdeclast	%xmm7, %xmm3
movdqu	-0x10(%r8,%rbx), %xmm6
movdqu	-0x10(%r9,%rbx), %xmm7
aesdeclast	%xmm8, %xmm4
aesdeclast	%xmm9, %xmm5
movdqu	-0x10(%r10,%rbx), %xmm8
movdqu	-0x10(%r11,%rbx), %xmm9
movups	%xmm2, -0x10(%r12,%rbx)
movdqu	(%r8,%rbx), %xmm2
movups	%xmm3, -0x10(%r13,%rbx)
movdqu	(%r9,%rbx), %xmm3
pxor	%xmm12, %xmm2
movups	%xmm4, -0x10(%r14,%rbx)
movdqu	(%r10,%rbx), %xmm4
pxor	%xmm12, %xmm3
movups	%xmm5, -0x10(%r15,%rbx)
movdqu	(%r11,%rbx), %xmm5
pxor	%xmm12, %xmm4
pxor	%xmm12, %xmm5
decl	%edx
jne	L_500
movq	0x10(%rsp), %rax
movl	0x18(%rsp), %edx
leaq	0xa0(%rdi), %rdi
decl	%edx
jne	L_427
L_786:
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
_avx_cbc_enc_shortcut:
aesni_multi_cbc_encrypt_avx:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0xc0, %rsp
andq	$-0x80, %rsp
movq	%rax, 0x10(%rsp)
vzeroupper
vmovdqu	(%rsi), %xmm15
leaq	0x78(%rsi), %rsi
leaq	0xa0(%rdi), %rdi
shrl	%edx
xorl	%edx, %edx
movl	-0x90(%rdi), %ecx
movq	-0xa0(%rdi), %r8
cmpl	%edx, %ecx
movq	-0x98(%rdi), %rbx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x88(%rdi), %xmm2
movl	%ecx, 0x20(%rsp)
cmovleq	%rsp, %r8
subq	%r8, %rbx
movq	%rbx, 0x40(%rsp)
movl	-0x68(%rdi), %ecx
movq	-0x78(%rdi), %r9
cmpl	%edx, %ecx
movq	-0x70(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x60(%rdi), %xmm3
movl	%ecx, 0x24(%rsp)
cmovleq	%rsp, %r9
subq	%r9, %rbp
movq	%rbp, 0x48(%rsp)
movl	-0x40(%rdi), %ecx
movq	-0x50(%rdi), %r10
cmpl	%edx, %ecx
movq	-0x48(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x38(%rdi), %xmm4
movl	%ecx, 0x28(%rsp)
cmovleq	%rsp, %r10
subq	%r10, %rbp
movq	%rbp, 0x50(%rsp)
movl	-0x18(%rdi), %ecx
movq	-0x28(%rdi), %r11
cmpl	%edx, %ecx
movq	-0x20(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x10(%rdi), %xmm5
movl	%ecx, 0x2c(%rsp)
cmovleq	%rsp, %r11
subq	%r11, %rbp
movq	%rbp, 0x58(%rsp)
movl	0x10(%rdi), %ecx
movq	(%rdi), %r12
cmpl	%edx, %ecx
movq	0x8(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x18(%rdi), %xmm6
movl	%ecx, 0x30(%rsp)
cmovleq	%rsp, %r12
subq	%r12, %rbp
movq	%rbp, 0x60(%rsp)
movl	0x38(%rdi), %ecx
movq	0x28(%rdi), %r13
cmpl	%edx, %ecx
movq	0x30(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x40(%rdi), %xmm7
movl	%ecx, 0x34(%rsp)
cmovleq	%rsp, %r13
subq	%r13, %rbp
movq	%rbp, 0x68(%rsp)
movl	0x60(%rdi), %ecx
movq	0x50(%rdi), %r14
cmpl	%edx, %ecx
movq	0x58(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x68(%rdi), %xmm8
movl	%ecx, 0x38(%rsp)
cmovleq	%rsp, %r14
subq	%r14, %rbp
movq	%rbp, 0x70(%rsp)
movl	0x88(%rdi), %ecx
movq	0x78(%rdi), %r15
cmpl	%edx, %ecx
movq	0x80(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x90(%rdi), %xmm9
movl	%ecx, 0x3c(%rsp)
cmovleq	%rsp, %r15
subq	%r15, %rbp
movq	%rbp, 0x78(%rsp)
testl	%edx, %edx
je	L_ead
vmovups	-0x68(%rsi), %xmm1
vmovups	-0x58(%rsi), %xmm0
movl	0x78(%rsi), %eax
vpxor	(%r8), %xmm15, %xmm10
leaq	0x80(%rsp), %rbp
vpxor	(%r9), %xmm15, %xmm11
vpxor	(%r10), %xmm15, %xmm12
vpxor	(%r11), %xmm15, %xmm13
vpxor	%xmm2, %xmm10, %xmm2
vpxor	(%r12), %xmm15, %xmm10
vpxor	%xmm3, %xmm11, %xmm3
vpxor	(%r13), %xmm15, %xmm11
vpxor	%xmm4, %xmm12, %xmm4
vpxor	(%r14), %xmm15, %xmm12
vpxor	%xmm5, %xmm13, %xmm5
vpxor	(%r15), %xmm15, %xmm13
vpxor	%xmm6, %xmm10, %xmm6
movl	$0x1, %ecx
vpxor	%xmm7, %xmm11, %xmm7
vpxor	%xmm12, %xmm8, %xmm8
vpxor	%xmm13, %xmm9, %xmm9
jmp	L_9c0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_9c0:
vaesenc	%xmm1, %xmm2, %xmm2
cmpl	0x20(%rsp), %ecx
vaesenc	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r8)
vaesenc	%xmm1, %xmm4, %xmm4
vaesenc	%xmm1, %xmm5, %xmm5
leaq	(%r8,%rbx), %rbx
cmovgeq	%rsp, %r8
vaesenc	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm1, %xmm7, %xmm7
subq	%r8, %rbx
vaesenc	%xmm1, %xmm8, %xmm8
vpxor	0x10(%r8), %xmm15, %xmm10
movq	%rbx, 0x40(%rsp)
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	-0x48(%rsi), %xmm1
leaq	0x10(%r8,%rbx), %r8
vmovdqu	%xmm10, (%rbp)
vaesenc	%xmm0, %xmm2, %xmm2
cmpl	0x24(%rsp), %ecx
movq	0x48(%rsp), %rbx
vaesenc	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r9)
vaesenc	%xmm0, %xmm4, %xmm4
vaesenc	%xmm0, %xmm5, %xmm5
leaq	(%r9,%rbx), %rbx
cmovgeq	%rsp, %r9
vaesenc	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm0, %xmm7, %xmm7
subq	%r9, %rbx
vaesenc	%xmm0, %xmm8, %xmm8
vpxor	0x10(%r9), %xmm15, %xmm11
movq	%rbx, 0x48(%rsp)
vaesenc	%xmm0, %xmm9, %xmm9
vmovups	-0x38(%rsi), %xmm0
leaq	0x10(%r9,%rbx), %r9
vmovdqu	%xmm11, 0x10(%rbp)
vaesenc	%xmm1, %xmm2, %xmm2
cmpl	0x28(%rsp), %ecx
movq	0x50(%rsp), %rbx
vaesenc	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r10)
vaesenc	%xmm1, %xmm4, %xmm4
prefetcht0	0xf(%r8)
vaesenc	%xmm1, %xmm5, %xmm5
leaq	(%r10,%rbx), %rbx
cmovgeq	%rsp, %r10
vaesenc	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm1, %xmm7, %xmm7
subq	%r10, %rbx
vaesenc	%xmm1, %xmm8, %xmm8
vpxor	0x10(%r10), %xmm15, %xmm12
movq	%rbx, 0x50(%rsp)
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	-0x28(%rsi), %xmm1
leaq	0x10(%r10,%rbx), %r10
vmovdqu	%xmm12, 0x20(%rbp)
vaesenc	%xmm0, %xmm2, %xmm2
cmpl	0x2c(%rsp), %ecx
movq	0x58(%rsp), %rbx
vaesenc	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r11)
vaesenc	%xmm0, %xmm4, %xmm4
prefetcht0	0xf(%r9)
vaesenc	%xmm0, %xmm5, %xmm5
leaq	(%r11,%rbx), %rbx
cmovgeq	%rsp, %r11
vaesenc	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm0, %xmm7, %xmm7
subq	%r11, %rbx
vaesenc	%xmm0, %xmm8, %xmm8
vpxor	0x10(%r11), %xmm15, %xmm13
movq	%rbx, 0x58(%rsp)
vaesenc	%xmm0, %xmm9, %xmm9
vmovups	-0x18(%rsi), %xmm0
leaq	0x10(%r11,%rbx), %r11
vmovdqu	%xmm13, 0x30(%rbp)
vaesenc	%xmm1, %xmm2, %xmm2
cmpl	0x30(%rsp), %ecx
movq	0x60(%rsp), %rbx
vaesenc	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r12)
vaesenc	%xmm1, %xmm4, %xmm4
prefetcht0	0xf(%r10)
vaesenc	%xmm1, %xmm5, %xmm5
leaq	(%r12,%rbx), %rbx
cmovgeq	%rsp, %r12
vaesenc	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm1, %xmm7, %xmm7
subq	%r12, %rbx
vaesenc	%xmm1, %xmm8, %xmm8
vpxor	0x10(%r12), %xmm15, %xmm10
movq	%rbx, 0x60(%rsp)
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	-0x8(%rsi), %xmm1
leaq	0x10(%r12,%rbx), %r12
vaesenc	%xmm0, %xmm2, %xmm2
cmpl	0x34(%rsp), %ecx
movq	0x68(%rsp), %rbx
vaesenc	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r13)
vaesenc	%xmm0, %xmm4, %xmm4
prefetcht0	0xf(%r11)
vaesenc	%xmm0, %xmm5, %xmm5
leaq	(%rbx,%r13), %rbx
cmovgeq	%rsp, %r13
vaesenc	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm0, %xmm7, %xmm7
subq	%r13, %rbx
vaesenc	%xmm0, %xmm8, %xmm8
vpxor	0x10(%r13), %xmm15, %xmm11
movq	%rbx, 0x68(%rsp)
vaesenc	%xmm0, %xmm9, %xmm9
vmovups	0x8(%rsi), %xmm0
leaq	0x10(%r13,%rbx), %r13
vaesenc	%xmm1, %xmm2, %xmm2
cmpl	0x38(%rsp), %ecx
movq	0x70(%rsp), %rbx
vaesenc	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r14)
vaesenc	%xmm1, %xmm4, %xmm4
prefetcht0	0xf(%r12)
vaesenc	%xmm1, %xmm5, %xmm5
leaq	(%r14,%rbx), %rbx
cmovgeq	%rsp, %r14
vaesenc	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm1, %xmm7, %xmm7
subq	%r14, %rbx
vaesenc	%xmm1, %xmm8, %xmm8
vpxor	0x10(%r14), %xmm15, %xmm12
movq	%rbx, 0x70(%rsp)
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	0x18(%rsi), %xmm1
leaq	0x10(%r14,%rbx), %r14
vaesenc	%xmm0, %xmm2, %xmm2
cmpl	0x3c(%rsp), %ecx
movq	0x78(%rsp), %rbx
vaesenc	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r15)
vaesenc	%xmm0, %xmm4, %xmm4
prefetcht0	0xf(%r13)
vaesenc	%xmm0, %xmm5, %xmm5
leaq	(%r15,%rbx), %rbx
cmovgeq	%rsp, %r15
vaesenc	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesenc	%xmm0, %xmm7, %xmm7
subq	%r15, %rbx
vaesenc	%xmm0, %xmm8, %xmm8
vpxor	0x10(%r15), %xmm15, %xmm13
movq	%rbx, 0x78(%rsp)
vaesenc	%xmm0, %xmm9, %xmm9
vmovups	0x28(%rsi), %xmm0
leaq	0x10(%r15,%rbx), %r15
vmovdqu	0x20(%rsp), %xmm14
prefetcht0	0xf(%r14)
prefetcht0	0xf(%r15)
cmpl	$0xb, %eax
jb	L_d8f
vaesenc	%xmm1, %xmm2, %xmm2
vaesenc	%xmm1, %xmm3, %xmm3
vaesenc	%xmm1, %xmm4, %xmm4
vaesenc	%xmm1, %xmm5, %xmm5
vaesenc	%xmm1, %xmm6, %xmm6
vaesenc	%xmm1, %xmm7, %xmm7
vaesenc	%xmm1, %xmm8, %xmm8
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	0x38(%rsi), %xmm1
vaesenc	%xmm0, %xmm2, %xmm2
vaesenc	%xmm0, %xmm3, %xmm3
vaesenc	%xmm0, %xmm4, %xmm4
vaesenc	%xmm0, %xmm5, %xmm5
vaesenc	%xmm0, %xmm6, %xmm6
vaesenc	%xmm0, %xmm7, %xmm7
vaesenc	%xmm0, %xmm8, %xmm8
vaesenc	%xmm0, %xmm9, %xmm9
vmovups	0x48(%rsi), %xmm0
je	L_d8f
vaesenc	%xmm1, %xmm2, %xmm2
vaesenc	%xmm1, %xmm3, %xmm3
vaesenc	%xmm1, %xmm4, %xmm4
vaesenc	%xmm1, %xmm5, %xmm5
vaesenc	%xmm1, %xmm6, %xmm6
vaesenc	%xmm1, %xmm7, %xmm7
vaesenc	%xmm1, %xmm8, %xmm8
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	0x58(%rsi), %xmm1
vaesenc	%xmm0, %xmm2, %xmm2
vaesenc	%xmm0, %xmm3, %xmm3
vaesenc	%xmm0, %xmm4, %xmm4
vaesenc	%xmm0, %xmm5, %xmm5
vaesenc	%xmm0, %xmm6, %xmm6
vaesenc	%xmm0, %xmm7, %xmm7
vaesenc	%xmm0, %xmm8, %xmm8
vaesenc	%xmm0, %xmm9, %xmm9
vmovups	0x68(%rsi), %xmm0
L_d8f:
vaesenc	%xmm1, %xmm2, %xmm2
vpxor	%xmm15, %xmm15, %xmm15
vaesenc	%xmm1, %xmm3, %xmm3
vaesenc	%xmm1, %xmm4, %xmm4
vpcmpgtd	%xmm15, %xmm14, %xmm15
vaesenc	%xmm1, %xmm5, %xmm5
vaesenc	%xmm1, %xmm6, %xmm6
vpaddd	%xmm14, %xmm15, %xmm15
vmovdqu	0x30(%rsp), %xmm14
vaesenc	%xmm1, %xmm7, %xmm7
movq	0x40(%rsp), %rbx
vaesenc	%xmm1, %xmm8, %xmm8
vaesenc	%xmm1, %xmm9, %xmm9
vmovups	-0x68(%rsi), %xmm1
vaesenclast	%xmm0, %xmm2, %xmm2
vmovdqa	%xmm15, 0x20(%rsp)
vpxor	%xmm15, %xmm15, %xmm15
vaesenclast	%xmm0, %xmm3, %xmm3
vaesenclast	%xmm0, %xmm4, %xmm4
vpcmpgtd	%xmm15, %xmm14, %xmm15
vaesenclast	%xmm0, %xmm5, %xmm5
vaesenclast	%xmm0, %xmm6, %xmm6
vpaddd	%xmm15, %xmm14, %xmm14
vmovdqu	-0x78(%rsi), %xmm15
vaesenclast	%xmm0, %xmm7, %xmm7
vaesenclast	%xmm0, %xmm8, %xmm8
vmovdqa	%xmm14, 0x30(%rsp)
vaesenclast	%xmm0, %xmm9, %xmm9
vmovups	-0x58(%rsi), %xmm0
vmovups	%xmm2, -0x10(%r8)
subq	%rbx, %r8
vpxor	(%rbp), %xmm2, %xmm2
vmovups	%xmm3, -0x10(%r9)
subq	0x48(%rsp), %r9
vpxor	0x10(%rbp), %xmm3, %xmm3
vmovups	%xmm4, -0x10(%r10)
subq	0x50(%rsp), %r10
vpxor	0x20(%rbp), %xmm4, %xmm4
vmovups	%xmm5, -0x10(%r11)
subq	0x58(%rsp), %r11
vpxor	0x30(%rbp), %xmm5, %xmm5
vmovups	%xmm6, -0x10(%r12)
subq	0x60(%rsp), %r12
vpxor	%xmm6, %xmm10, %xmm6
vmovups	%xmm7, -0x10(%r13)
subq	0x68(%rsp), %r13
vpxor	%xmm7, %xmm11, %xmm7
vmovups	%xmm8, -0x10(%r14)
subq	0x70(%rsp), %r14
vpxor	%xmm12, %xmm8, %xmm8
vmovups	%xmm9, -0x10(%r15)
subq	0x78(%rsp), %r15
vpxor	%xmm13, %xmm9, %xmm9
decl	%edx
jne	L_9c0
movq	0x10(%rsp), %rax
L_ead:
vzeroupper
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
_avx_cbc_dec_shortcut:
aesni_multi_cbc_decrypt_avx:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x100, %rsp
andq	$-0x100, %rsp
subq	$0xc0, %rsp
movq	%rax, 0x10(%rsp)
vzeroupper
vmovdqu	(%rsi), %xmm15
leaq	0x78(%rsi), %rsi
leaq	0xa0(%rdi), %rdi
shrl	%edx
xorl	%edx, %edx
movl	-0x90(%rdi), %ecx
movq	-0xa0(%rdi), %r8
cmpl	%edx, %ecx
movq	-0x98(%rdi), %rbx
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x88(%rdi), %xmm2
movl	%ecx, 0x20(%rsp)
cmovleq	%rsp, %r8
subq	%r8, %rbx
movq	%rbx, 0x40(%rsp)
vmovdqu	%xmm2, 0xc0(%rsp)
movl	-0x68(%rdi), %ecx
movq	-0x78(%rdi), %r9
cmpl	%edx, %ecx
movq	-0x70(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x60(%rdi), %xmm3
movl	%ecx, 0x24(%rsp)
cmovleq	%rsp, %r9
subq	%r9, %rbp
movq	%rbp, 0x48(%rsp)
vmovdqu	%xmm3, 0xd0(%rsp)
movl	-0x40(%rdi), %ecx
movq	-0x50(%rdi), %r10
cmpl	%edx, %ecx
movq	-0x48(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x38(%rdi), %xmm4
movl	%ecx, 0x28(%rsp)
cmovleq	%rsp, %r10
subq	%r10, %rbp
movq	%rbp, 0x50(%rsp)
vmovdqu	%xmm4, 0xe0(%rsp)
movl	-0x18(%rdi), %ecx
movq	-0x28(%rdi), %r11
cmpl	%edx, %ecx
movq	-0x20(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	-0x10(%rdi), %xmm5
movl	%ecx, 0x2c(%rsp)
cmovleq	%rsp, %r11
subq	%r11, %rbp
movq	%rbp, 0x58(%rsp)
vmovdqu	%xmm5, 0xf0(%rsp)
movl	0x10(%rdi), %ecx
movq	(%rdi), %r12
cmpl	%edx, %ecx
movq	0x8(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x18(%rdi), %xmm6
movl	%ecx, 0x30(%rsp)
cmovleq	%rsp, %r12
subq	%r12, %rbp
movq	%rbp, 0x60(%rsp)
vmovdqu	%xmm6, 0x100(%rsp)
movl	0x38(%rdi), %ecx
movq	0x28(%rdi), %r13
cmpl	%edx, %ecx
movq	0x30(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x40(%rdi), %xmm7
movl	%ecx, 0x34(%rsp)
cmovleq	%rsp, %r13
subq	%r13, %rbp
movq	%rbp, 0x68(%rsp)
vmovdqu	%xmm7, 0x110(%rsp)
movl	0x60(%rdi), %ecx
movq	0x50(%rdi), %r14
cmpl	%edx, %ecx
movq	0x58(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x68(%rdi), %xmm8
movl	%ecx, 0x38(%rsp)
cmovleq	%rsp, %r14
subq	%r14, %rbp
movq	%rbp, 0x70(%rsp)
vmovdqu	%xmm8, 0x120(%rsp)
movl	0x88(%rdi), %ecx
movq	0x78(%rdi), %r15
cmpl	%edx, %ecx
movq	0x80(%rdi), %rbp
cmovgl	%ecx, %edx
testl	%ecx, %ecx
vmovdqu	0x90(%rdi), %xmm9
movl	%ecx, 0x3c(%rsp)
cmovleq	%rsp, %r15
subq	%r15, %rbp
movq	%rbp, 0x78(%rsp)
vmovdqu	%xmm9, 0x130(%rsp)
testl	%edx, %edx
je	L_16d6
vmovups	-0x68(%rsi), %xmm1
vmovups	-0x58(%rsi), %xmm0
movl	0x78(%rsi), %eax
leaq	0x140(%rsp), %rbp
vmovdqu	(%r8), %xmm2
vmovdqu	(%r9), %xmm3
vmovdqu	(%r10), %xmm4
vmovdqu	(%r11), %xmm5
vmovdqu	(%r12), %xmm6
vmovdqu	(%r13), %xmm7
vmovdqu	(%r14), %xmm8
vmovdqu	(%r15), %xmm9
vmovdqu	%xmm2, (%rbp)
vpxor	%xmm2, %xmm15, %xmm2
vmovdqu	%xmm3, 0x10(%rbp)
vpxor	%xmm3, %xmm15, %xmm3
vmovdqu	%xmm4, 0x20(%rbp)
vpxor	%xmm4, %xmm15, %xmm4
vmovdqu	%xmm5, 0x30(%rbp)
vpxor	%xmm5, %xmm15, %xmm5
vmovdqu	%xmm6, 0x40(%rbp)
vpxor	%xmm6, %xmm15, %xmm6
vmovdqu	%xmm7, 0x50(%rbp)
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	%xmm8, 0x60(%rbp)
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	%xmm9, 0x70(%rbp)
vpxor	%xmm15, %xmm9, %xmm9
xorq	$0x80, %rbp
movl	$0x1, %ecx
jmp	L_1160
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_1160:
vaesdec	%xmm1, %xmm2, %xmm2
cmpl	0x20(%rsp), %ecx
vaesdec	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r8)
vaesdec	%xmm1, %xmm4, %xmm4
vaesdec	%xmm1, %xmm5, %xmm5
leaq	(%r8,%rbx), %rbx
cmovgeq	%rsp, %r8
vaesdec	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm1, %xmm7, %xmm7
subq	%r8, %rbx
vaesdec	%xmm1, %xmm8, %xmm8
vmovdqu	0x10(%r8), %xmm10
movq	%rbx, 0x40(%rsp)
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	-0x48(%rsi), %xmm1
leaq	0x10(%r8,%rbx), %r8
vmovdqu	%xmm10, 0x80(%rsp)
vaesdec	%xmm0, %xmm2, %xmm2
cmpl	0x24(%rsp), %ecx
movq	0x48(%rsp), %rbx
vaesdec	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r9)
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
leaq	(%r9,%rbx), %rbx
cmovgeq	%rsp, %r9
vaesdec	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm0, %xmm7, %xmm7
subq	%r9, %rbx
vaesdec	%xmm0, %xmm8, %xmm8
vmovdqu	0x10(%r9), %xmm11
movq	%rbx, 0x48(%rsp)
vaesdec	%xmm0, %xmm9, %xmm9
vmovups	-0x38(%rsi), %xmm0
leaq	0x10(%r9,%rbx), %r9
vmovdqu	%xmm11, 0x90(%rsp)
vaesdec	%xmm1, %xmm2, %xmm2
cmpl	0x28(%rsp), %ecx
movq	0x50(%rsp), %rbx
vaesdec	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r10)
vaesdec	%xmm1, %xmm4, %xmm4
prefetcht0	0xf(%r8)
vaesdec	%xmm1, %xmm5, %xmm5
leaq	(%r10,%rbx), %rbx
cmovgeq	%rsp, %r10
vaesdec	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm1, %xmm7, %xmm7
subq	%r10, %rbx
vaesdec	%xmm1, %xmm8, %xmm8
vmovdqu	0x10(%r10), %xmm12
movq	%rbx, 0x50(%rsp)
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	-0x28(%rsi), %xmm1
leaq	0x10(%r10,%rbx), %r10
vmovdqu	%xmm12, 0xa0(%rsp)
vaesdec	%xmm0, %xmm2, %xmm2
cmpl	0x2c(%rsp), %ecx
movq	0x58(%rsp), %rbx
vaesdec	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r11)
vaesdec	%xmm0, %xmm4, %xmm4
prefetcht0	0xf(%r9)
vaesdec	%xmm0, %xmm5, %xmm5
leaq	(%r11,%rbx), %rbx
cmovgeq	%rsp, %r11
vaesdec	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm0, %xmm7, %xmm7
subq	%r11, %rbx
vaesdec	%xmm0, %xmm8, %xmm8
vmovdqu	0x10(%r11), %xmm13
movq	%rbx, 0x58(%rsp)
vaesdec	%xmm0, %xmm9, %xmm9
vmovups	-0x18(%rsi), %xmm0
leaq	0x10(%r11,%rbx), %r11
vmovdqu	%xmm13, 0xb0(%rsp)
vaesdec	%xmm1, %xmm2, %xmm2
cmpl	0x30(%rsp), %ecx
movq	0x60(%rsp), %rbx
vaesdec	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r12)
vaesdec	%xmm1, %xmm4, %xmm4
prefetcht0	0xf(%r10)
vaesdec	%xmm1, %xmm5, %xmm5
leaq	(%r12,%rbx), %rbx
cmovgeq	%rsp, %r12
vaesdec	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm1, %xmm7, %xmm7
subq	%r12, %rbx
vaesdec	%xmm1, %xmm8, %xmm8
vmovdqu	0x10(%r12), %xmm10
movq	%rbx, 0x60(%rsp)
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	-0x8(%rsi), %xmm1
leaq	0x10(%r12,%rbx), %r12
vaesdec	%xmm0, %xmm2, %xmm2
cmpl	0x34(%rsp), %ecx
movq	0x68(%rsp), %rbx
vaesdec	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r13)
vaesdec	%xmm0, %xmm4, %xmm4
prefetcht0	0xf(%r11)
vaesdec	%xmm0, %xmm5, %xmm5
leaq	(%rbx,%r13), %rbx
cmovgeq	%rsp, %r13
vaesdec	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm0, %xmm7, %xmm7
subq	%r13, %rbx
vaesdec	%xmm0, %xmm8, %xmm8
vmovdqu	0x10(%r13), %xmm11
movq	%rbx, 0x68(%rsp)
vaesdec	%xmm0, %xmm9, %xmm9
vmovups	0x8(%rsi), %xmm0
leaq	0x10(%r13,%rbx), %r13
vaesdec	%xmm1, %xmm2, %xmm2
cmpl	0x38(%rsp), %ecx
movq	0x70(%rsp), %rbx
vaesdec	%xmm1, %xmm3, %xmm3
prefetcht0	0x1f(%r14)
vaesdec	%xmm1, %xmm4, %xmm4
prefetcht0	0xf(%r12)
vaesdec	%xmm1, %xmm5, %xmm5
leaq	(%r14,%rbx), %rbx
cmovgeq	%rsp, %r14
vaesdec	%xmm1, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm1, %xmm7, %xmm7
subq	%r14, %rbx
vaesdec	%xmm1, %xmm8, %xmm8
vmovdqu	0x10(%r14), %xmm12
movq	%rbx, 0x70(%rsp)
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	0x18(%rsi), %xmm1
leaq	0x10(%r14,%rbx), %r14
vaesdec	%xmm0, %xmm2, %xmm2
cmpl	0x3c(%rsp), %ecx
movq	0x78(%rsp), %rbx
vaesdec	%xmm0, %xmm3, %xmm3
prefetcht0	0x1f(%r15)
vaesdec	%xmm0, %xmm4, %xmm4
prefetcht0	0xf(%r13)
vaesdec	%xmm0, %xmm5, %xmm5
leaq	(%r15,%rbx), %rbx
cmovgeq	%rsp, %r15
vaesdec	%xmm0, %xmm6, %xmm6
cmovgq	%rsp, %rbx
vaesdec	%xmm0, %xmm7, %xmm7
subq	%r15, %rbx
vaesdec	%xmm0, %xmm8, %xmm8
vmovdqu	0x10(%r15), %xmm13
movq	%rbx, 0x78(%rsp)
vaesdec	%xmm0, %xmm9, %xmm9
vmovups	0x28(%rsi), %xmm0
leaq	0x10(%r15,%rbx), %r15
vmovdqu	0x20(%rsp), %xmm14
prefetcht0	0xf(%r14)
prefetcht0	0xf(%r15)
cmpl	$0xb, %eax
jb	L_153f
vaesdec	%xmm1, %xmm2, %xmm2
vaesdec	%xmm1, %xmm3, %xmm3
vaesdec	%xmm1, %xmm4, %xmm4
vaesdec	%xmm1, %xmm5, %xmm5
vaesdec	%xmm1, %xmm6, %xmm6
vaesdec	%xmm1, %xmm7, %xmm7
vaesdec	%xmm1, %xmm8, %xmm8
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	0x38(%rsi), %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vaesdec	%xmm0, %xmm8, %xmm8
vaesdec	%xmm0, %xmm9, %xmm9
vmovups	0x48(%rsi), %xmm0
je	L_153f
vaesdec	%xmm1, %xmm2, %xmm2
vaesdec	%xmm1, %xmm3, %xmm3
vaesdec	%xmm1, %xmm4, %xmm4
vaesdec	%xmm1, %xmm5, %xmm5
vaesdec	%xmm1, %xmm6, %xmm6
vaesdec	%xmm1, %xmm7, %xmm7
vaesdec	%xmm1, %xmm8, %xmm8
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	0x58(%rsi), %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vaesdec	%xmm0, %xmm8, %xmm8
vaesdec	%xmm0, %xmm9, %xmm9
vmovups	0x68(%rsi), %xmm0
L_153f:
vaesdec	%xmm1, %xmm2, %xmm2
vpxor	%xmm15, %xmm15, %xmm15
vaesdec	%xmm1, %xmm3, %xmm3
vaesdec	%xmm1, %xmm4, %xmm4
vpcmpgtd	%xmm15, %xmm14, %xmm15
vaesdec	%xmm1, %xmm5, %xmm5
vaesdec	%xmm1, %xmm6, %xmm6
vpaddd	%xmm14, %xmm15, %xmm15
vmovdqu	0x30(%rsp), %xmm14
vaesdec	%xmm1, %xmm7, %xmm7
movq	0x40(%rsp), %rbx
vaesdec	%xmm1, %xmm8, %xmm8
vaesdec	%xmm1, %xmm9, %xmm9
vmovups	-0x68(%rsi), %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vmovdqa	%xmm15, 0x20(%rsp)
vpxor	%xmm15, %xmm15, %xmm15
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	(%rbp), %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm4, %xmm4
vpxor	0x10(%rbp), %xmm3, %xmm3
vpcmpgtd	%xmm15, %xmm14, %xmm15
vaesdeclast	%xmm0, %xmm5, %xmm5
vpxor	0x20(%rbp), %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm6, %xmm6
vpxor	0x30(%rbp), %xmm5, %xmm5
vpaddd	%xmm15, %xmm14, %xmm14
vmovdqu	-0x78(%rsi), %xmm15
vaesdeclast	%xmm0, %xmm7, %xmm7
vpxor	0x40(%rbp), %xmm6, %xmm6
vaesdeclast	%xmm0, %xmm8, %xmm8
vpxor	0x50(%rbp), %xmm7, %xmm7
vmovdqa	%xmm14, 0x30(%rsp)
vaesdeclast	%xmm0, %xmm9, %xmm9
vpxor	0x60(%rbp), %xmm8, %xmm8
vmovups	-0x58(%rsi), %xmm0
vmovups	%xmm2, -0x10(%r8)
subq	%rbx, %r8
vmovdqu	0x80(%rsp), %xmm2
vpxor	0x70(%rbp), %xmm9, %xmm9
vmovups	%xmm3, -0x10(%r9)
subq	0x48(%rsp), %r9
vmovdqu	%xmm2, (%rbp)
vpxor	%xmm2, %xmm15, %xmm2
vmovdqu	0x90(%rsp), %xmm3
vmovups	%xmm4, -0x10(%r10)
subq	0x50(%rsp), %r10
vmovdqu	%xmm3, 0x10(%rbp)
vpxor	%xmm3, %xmm15, %xmm3
vmovdqu	0xa0(%rsp), %xmm4
vmovups	%xmm5, -0x10(%r11)
subq	0x58(%rsp), %r11
vmovdqu	%xmm4, 0x20(%rbp)
vpxor	%xmm4, %xmm15, %xmm4
vmovdqu	0xb0(%rsp), %xmm5
vmovups	%xmm6, -0x10(%r12)
subq	0x60(%rsp), %r12
vmovdqu	%xmm5, 0x30(%rbp)
vpxor	%xmm5, %xmm15, %xmm5
vmovdqu	%xmm10, 0x40(%rbp)
vpxor	%xmm10, %xmm15, %xmm6
vmovups	%xmm7, -0x10(%r13)
subq	0x68(%rsp), %r13
vmovdqu	%xmm11, 0x50(%rbp)
vpxor	%xmm11, %xmm15, %xmm7
vmovups	%xmm8, -0x10(%r14)
subq	0x70(%rsp), %r14
vmovdqu	%xmm12, 0x60(%rbp)
vpxor	%xmm12, %xmm15, %xmm8
vmovups	%xmm9, -0x10(%r15)
subq	0x78(%rsp), %r15
vmovdqu	%xmm13, 0x70(%rbp)
vpxor	%xmm13, %xmm15, %xmm9
xorq	$0x80, %rbp
decl	%edx
jne	L_1160
movq	0x10(%rsp), %rax
L_16d6:
vzeroupper
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
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

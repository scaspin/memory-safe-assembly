	.text
sha512_block_data_order:
leaq	OPENSSL_ia32cap_P(%rip), %r10
movq	(%r10), %r9
movl	0x8(%r10), %r11d
movl	0x14(%r10), %r10d
btq	$0x2b, %r9
jb	sha512_block_data_order_xop
testl	$0x20, %r11d
je	L_47
testl	$0x1, %r10d
jne	L_4a84
andl	$0x108, %r11d
cmpl	$0x108, %r11d
je	sha512_block_data_order_avx2
L_47:
movabsq	$0x1000020040000000, %r11
andq	%r11, %r9
cmpq	%r11, %r9
je	sha512_block_data_order_avx
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shlq	$0x4, %rdx
subq	$0xa0, %rsp
leaq	(%rsi,%rdx,8), %rdx
andq	$-0x40, %rsp
movq	%rdi, 0x80(%rsp)
movq	%rsi, 0x88(%rsp)
movq	%rdx, 0x90(%rsp)
movq	%rax, 0x98(%rsp)
movq	(%rdi), %rax
movq	0x8(%rdi), %rbx
movq	0x10(%rdi), %rcx
movq	0x18(%rdi), %rdx
movq	0x20(%rdi), %r8
movq	0x28(%rdi), %r9
movq	0x30(%rdi), %r10
movq	0x38(%rdi), %r11
jmp	L_c0
nop
L_c0:
movq	%rbx, %rdi
leaq	K512(%rip), %rbp
xorq	%rcx, %rdi
movq	(%rsi), %r12
movq	%r8, %r13
movq	%rax, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r9, %r15
xorq	%r8, %r13
rorq	$0x5, %r14
xorq	%r10, %r15
movq	%r12, (%rsp)
xorq	%rax, %r14
andq	%r8, %r15
rorq	$0x4, %r13
addq	%r11, %r12
xorq	%r10, %r15
rorq	$0x6, %r14
xorq	%r8, %r13
addq	%r15, %r12
movq	%rax, %r15
addq	(%rbp), %r12
xorq	%rax, %r14
xorq	%rbx, %r15
rorq	$0xe, %r13
movq	%rbx, %r11
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r11
addq	%r12, %rdx
addq	%r12, %r11
leaq	0x8(%rbp), %rbp
addq	%r14, %r11
movq	0x8(%rsi), %r12
movq	%rdx, %r13
movq	%r11, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r8, %rdi
xorq	%rdx, %r13
rorq	$0x5, %r14
xorq	%r9, %rdi
movq	%r12, 0x8(%rsp)
xorq	%r11, %r14
andq	%rdx, %rdi
rorq	$0x4, %r13
addq	%r10, %r12
xorq	%r9, %rdi
rorq	$0x6, %r14
xorq	%rdx, %r13
addq	%rdi, %r12
movq	%r11, %rdi
addq	(%rbp), %r12
xorq	%r11, %r14
xorq	%rax, %rdi
rorq	$0xe, %r13
movq	%rax, %r10
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r10
addq	%r12, %rcx
addq	%r12, %r10
leaq	0x18(%rbp), %rbp
addq	%r14, %r10
movq	0x10(%rsi), %r12
movq	%rcx, %r13
movq	%r10, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rdx, %r15
xorq	%rcx, %r13
rorq	$0x5, %r14
xorq	%r8, %r15
movq	%r12, 0x10(%rsp)
xorq	%r10, %r14
andq	%rcx, %r15
rorq	$0x4, %r13
addq	%r9, %r12
xorq	%r8, %r15
rorq	$0x6, %r14
xorq	%rcx, %r13
addq	%r15, %r12
movq	%r10, %r15
addq	(%rbp), %r12
xorq	%r10, %r14
xorq	%r11, %r15
rorq	$0xe, %r13
movq	%r11, %r9
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r9
addq	%r12, %rbx
addq	%r12, %r9
leaq	0x8(%rbp), %rbp
addq	%r14, %r9
movq	0x18(%rsi), %r12
movq	%rbx, %r13
movq	%r9, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rcx, %rdi
xorq	%rbx, %r13
rorq	$0x5, %r14
xorq	%rdx, %rdi
movq	%r12, 0x18(%rsp)
xorq	%r9, %r14
andq	%rbx, %rdi
rorq	$0x4, %r13
addq	%r8, %r12
xorq	%rdx, %rdi
rorq	$0x6, %r14
xorq	%rbx, %r13
addq	%rdi, %r12
movq	%r9, %rdi
addq	(%rbp), %r12
xorq	%r9, %r14
xorq	%r10, %rdi
rorq	$0xe, %r13
movq	%r10, %r8
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r8
addq	%r12, %rax
addq	%r12, %r8
leaq	0x18(%rbp), %rbp
addq	%r14, %r8
movq	0x20(%rsi), %r12
movq	%rax, %r13
movq	%r8, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rbx, %r15
xorq	%rax, %r13
rorq	$0x5, %r14
xorq	%rcx, %r15
movq	%r12, 0x20(%rsp)
xorq	%r8, %r14
andq	%rax, %r15
rorq	$0x4, %r13
addq	%rdx, %r12
xorq	%rcx, %r15
rorq	$0x6, %r14
xorq	%rax, %r13
addq	%r15, %r12
movq	%r8, %r15
addq	(%rbp), %r12
xorq	%r8, %r14
xorq	%r9, %r15
rorq	$0xe, %r13
movq	%r9, %rdx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rdx
addq	%r12, %r11
addq	%r12, %rdx
leaq	0x8(%rbp), %rbp
addq	%r14, %rdx
movq	0x28(%rsi), %r12
movq	%r11, %r13
movq	%rdx, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rax, %rdi
xorq	%r11, %r13
rorq	$0x5, %r14
xorq	%rbx, %rdi
movq	%r12, 0x28(%rsp)
xorq	%rdx, %r14
andq	%r11, %rdi
rorq	$0x4, %r13
addq	%rcx, %r12
xorq	%rbx, %rdi
rorq	$0x6, %r14
xorq	%r11, %r13
addq	%rdi, %r12
movq	%rdx, %rdi
addq	(%rbp), %r12
xorq	%rdx, %r14
xorq	%r8, %rdi
rorq	$0xe, %r13
movq	%r8, %rcx
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rcx
addq	%r12, %r10
addq	%r12, %rcx
leaq	0x18(%rbp), %rbp
addq	%r14, %rcx
movq	0x30(%rsi), %r12
movq	%r10, %r13
movq	%rcx, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r11, %r15
xorq	%r10, %r13
rorq	$0x5, %r14
xorq	%rax, %r15
movq	%r12, 0x30(%rsp)
xorq	%rcx, %r14
andq	%r10, %r15
rorq	$0x4, %r13
addq	%rbx, %r12
xorq	%rax, %r15
rorq	$0x6, %r14
xorq	%r10, %r13
addq	%r15, %r12
movq	%rcx, %r15
addq	(%rbp), %r12
xorq	%rcx, %r14
xorq	%rdx, %r15
rorq	$0xe, %r13
movq	%rdx, %rbx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rbx
addq	%r12, %r9
addq	%r12, %rbx
leaq	0x8(%rbp), %rbp
addq	%r14, %rbx
movq	0x38(%rsi), %r12
movq	%r9, %r13
movq	%rbx, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r10, %rdi
xorq	%r9, %r13
rorq	$0x5, %r14
xorq	%r11, %rdi
movq	%r12, 0x38(%rsp)
xorq	%rbx, %r14
andq	%r9, %rdi
rorq	$0x4, %r13
addq	%rax, %r12
xorq	%r11, %rdi
rorq	$0x6, %r14
xorq	%r9, %r13
addq	%rdi, %r12
movq	%rbx, %rdi
addq	(%rbp), %r12
xorq	%rbx, %r14
xorq	%rcx, %rdi
rorq	$0xe, %r13
movq	%rcx, %rax
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rax
addq	%r12, %r8
addq	%r12, %rax
leaq	0x18(%rbp), %rbp
addq	%r14, %rax
movq	0x40(%rsi), %r12
movq	%r8, %r13
movq	%rax, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r9, %r15
xorq	%r8, %r13
rorq	$0x5, %r14
xorq	%r10, %r15
movq	%r12, 0x40(%rsp)
xorq	%rax, %r14
andq	%r8, %r15
rorq	$0x4, %r13
addq	%r11, %r12
xorq	%r10, %r15
rorq	$0x6, %r14
xorq	%r8, %r13
addq	%r15, %r12
movq	%rax, %r15
addq	(%rbp), %r12
xorq	%rax, %r14
xorq	%rbx, %r15
rorq	$0xe, %r13
movq	%rbx, %r11
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r11
addq	%r12, %rdx
addq	%r12, %r11
leaq	0x8(%rbp), %rbp
addq	%r14, %r11
movq	0x48(%rsi), %r12
movq	%rdx, %r13
movq	%r11, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r8, %rdi
xorq	%rdx, %r13
rorq	$0x5, %r14
xorq	%r9, %rdi
movq	%r12, 0x48(%rsp)
xorq	%r11, %r14
andq	%rdx, %rdi
rorq	$0x4, %r13
addq	%r10, %r12
xorq	%r9, %rdi
rorq	$0x6, %r14
xorq	%rdx, %r13
addq	%rdi, %r12
movq	%r11, %rdi
addq	(%rbp), %r12
xorq	%r11, %r14
xorq	%rax, %rdi
rorq	$0xe, %r13
movq	%rax, %r10
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r10
addq	%r12, %rcx
addq	%r12, %r10
leaq	0x18(%rbp), %rbp
addq	%r14, %r10
movq	0x50(%rsi), %r12
movq	%rcx, %r13
movq	%r10, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rdx, %r15
xorq	%rcx, %r13
rorq	$0x5, %r14
xorq	%r8, %r15
movq	%r12, 0x50(%rsp)
xorq	%r10, %r14
andq	%rcx, %r15
rorq	$0x4, %r13
addq	%r9, %r12
xorq	%r8, %r15
rorq	$0x6, %r14
xorq	%rcx, %r13
addq	%r15, %r12
movq	%r10, %r15
addq	(%rbp), %r12
xorq	%r10, %r14
xorq	%r11, %r15
rorq	$0xe, %r13
movq	%r11, %r9
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r9
addq	%r12, %rbx
addq	%r12, %r9
leaq	0x8(%rbp), %rbp
addq	%r14, %r9
movq	0x58(%rsi), %r12
movq	%rbx, %r13
movq	%r9, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rcx, %rdi
xorq	%rbx, %r13
rorq	$0x5, %r14
xorq	%rdx, %rdi
movq	%r12, 0x58(%rsp)
xorq	%r9, %r14
andq	%rbx, %rdi
rorq	$0x4, %r13
addq	%r8, %r12
xorq	%rdx, %rdi
rorq	$0x6, %r14
xorq	%rbx, %r13
addq	%rdi, %r12
movq	%r9, %rdi
addq	(%rbp), %r12
xorq	%r9, %r14
xorq	%r10, %rdi
rorq	$0xe, %r13
movq	%r10, %r8
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r8
addq	%r12, %rax
addq	%r12, %r8
leaq	0x18(%rbp), %rbp
addq	%r14, %r8
movq	0x60(%rsi), %r12
movq	%rax, %r13
movq	%r8, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rbx, %r15
xorq	%rax, %r13
rorq	$0x5, %r14
xorq	%rcx, %r15
movq	%r12, 0x60(%rsp)
xorq	%r8, %r14
andq	%rax, %r15
rorq	$0x4, %r13
addq	%rdx, %r12
xorq	%rcx, %r15
rorq	$0x6, %r14
xorq	%rax, %r13
addq	%r15, %r12
movq	%r8, %r15
addq	(%rbp), %r12
xorq	%r8, %r14
xorq	%r9, %r15
rorq	$0xe, %r13
movq	%r9, %rdx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rdx
addq	%r12, %r11
addq	%r12, %rdx
leaq	0x8(%rbp), %rbp
addq	%r14, %rdx
movq	0x68(%rsi), %r12
movq	%r11, %r13
movq	%rdx, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%rax, %rdi
xorq	%r11, %r13
rorq	$0x5, %r14
xorq	%rbx, %rdi
movq	%r12, 0x68(%rsp)
xorq	%rdx, %r14
andq	%r11, %rdi
rorq	$0x4, %r13
addq	%rcx, %r12
xorq	%rbx, %rdi
rorq	$0x6, %r14
xorq	%r11, %r13
addq	%rdi, %r12
movq	%rdx, %rdi
addq	(%rbp), %r12
xorq	%rdx, %r14
xorq	%r8, %rdi
rorq	$0xe, %r13
movq	%r8, %rcx
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rcx
addq	%r12, %r10
addq	%r12, %rcx
leaq	0x18(%rbp), %rbp
addq	%r14, %rcx
movq	0x70(%rsi), %r12
movq	%r10, %r13
movq	%rcx, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r11, %r15
xorq	%r10, %r13
rorq	$0x5, %r14
xorq	%rax, %r15
movq	%r12, 0x70(%rsp)
xorq	%rcx, %r14
andq	%r10, %r15
rorq	$0x4, %r13
addq	%rbx, %r12
xorq	%rax, %r15
rorq	$0x6, %r14
xorq	%r10, %r13
addq	%r15, %r12
movq	%rcx, %r15
addq	(%rbp), %r12
xorq	%rcx, %r14
xorq	%rdx, %r15
rorq	$0xe, %r13
movq	%rdx, %rbx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rbx
addq	%r12, %r9
addq	%r12, %rbx
leaq	0x8(%rbp), %rbp
addq	%r14, %rbx
movq	0x78(%rsi), %r12
movq	%r9, %r13
movq	%rbx, %r14
bswapq	%r12
rorq	$0x17, %r13
movq	%r10, %rdi
xorq	%r9, %r13
rorq	$0x5, %r14
xorq	%r11, %rdi
movq	%r12, 0x78(%rsp)
xorq	%rbx, %r14
andq	%r9, %rdi
rorq	$0x4, %r13
addq	%rax, %r12
xorq	%r11, %rdi
rorq	$0x6, %r14
xorq	%r9, %r13
addq	%rdi, %r12
movq	%rbx, %rdi
addq	(%rbp), %r12
xorq	%rbx, %r14
xorq	%rcx, %rdi
rorq	$0xe, %r13
movq	%rcx, %rax
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rax
addq	%r12, %r8
addq	%r12, %rax
leaq	0x18(%rbp), %rbp
jmp	L_780
nopw	(%rax,%rax)
L_780:
movq	0x8(%rsp), %r13
movq	0x70(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rax
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x48(%rsp), %r12
addq	(%rsp), %r12
movq	%r8, %r13
addq	%r15, %r12
movq	%rax, %r14
rorq	$0x17, %r13
movq	%r9, %r15
xorq	%r8, %r13
rorq	$0x5, %r14
xorq	%r10, %r15
movq	%r12, (%rsp)
xorq	%rax, %r14
andq	%r8, %r15
rorq	$0x4, %r13
addq	%r11, %r12
xorq	%r10, %r15
rorq	$0x6, %r14
xorq	%r8, %r13
addq	%r15, %r12
movq	%rax, %r15
addq	(%rbp), %r12
xorq	%rax, %r14
xorq	%rbx, %r15
rorq	$0xe, %r13
movq	%rbx, %r11
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r11
addq	%r12, %rdx
addq	%r12, %r11
leaq	0x8(%rbp), %rbp
movq	0x10(%rsp), %r13
movq	0x78(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r11
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x50(%rsp), %r12
addq	0x8(%rsp), %r12
movq	%rdx, %r13
addq	%rdi, %r12
movq	%r11, %r14
rorq	$0x17, %r13
movq	%r8, %rdi
xorq	%rdx, %r13
rorq	$0x5, %r14
xorq	%r9, %rdi
movq	%r12, 0x8(%rsp)
xorq	%r11, %r14
andq	%rdx, %rdi
rorq	$0x4, %r13
addq	%r10, %r12
xorq	%r9, %rdi
rorq	$0x6, %r14
xorq	%rdx, %r13
addq	%rdi, %r12
movq	%r11, %rdi
addq	(%rbp), %r12
xorq	%r11, %r14
xorq	%rax, %rdi
rorq	$0xe, %r13
movq	%rax, %r10
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r10
addq	%r12, %rcx
addq	%r12, %r10
leaq	0x18(%rbp), %rbp
movq	0x18(%rsp), %r13
movq	(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r10
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x58(%rsp), %r12
addq	0x10(%rsp), %r12
movq	%rcx, %r13
addq	%r15, %r12
movq	%r10, %r14
rorq	$0x17, %r13
movq	%rdx, %r15
xorq	%rcx, %r13
rorq	$0x5, %r14
xorq	%r8, %r15
movq	%r12, 0x10(%rsp)
xorq	%r10, %r14
andq	%rcx, %r15
rorq	$0x4, %r13
addq	%r9, %r12
xorq	%r8, %r15
rorq	$0x6, %r14
xorq	%rcx, %r13
addq	%r15, %r12
movq	%r10, %r15
addq	(%rbp), %r12
xorq	%r10, %r14
xorq	%r11, %r15
rorq	$0xe, %r13
movq	%r11, %r9
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r9
addq	%r12, %rbx
addq	%r12, %r9
leaq	0x8(%rbp), %rbp
movq	0x20(%rsp), %r13
movq	0x8(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r9
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x60(%rsp), %r12
addq	0x18(%rsp), %r12
movq	%rbx, %r13
addq	%rdi, %r12
movq	%r9, %r14
rorq	$0x17, %r13
movq	%rcx, %rdi
xorq	%rbx, %r13
rorq	$0x5, %r14
xorq	%rdx, %rdi
movq	%r12, 0x18(%rsp)
xorq	%r9, %r14
andq	%rbx, %rdi
rorq	$0x4, %r13
addq	%r8, %r12
xorq	%rdx, %rdi
rorq	$0x6, %r14
xorq	%rbx, %r13
addq	%rdi, %r12
movq	%r9, %rdi
addq	(%rbp), %r12
xorq	%r9, %r14
xorq	%r10, %rdi
rorq	$0xe, %r13
movq	%r10, %r8
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r8
addq	%r12, %rax
addq	%r12, %r8
leaq	0x18(%rbp), %rbp
movq	0x28(%rsp), %r13
movq	0x10(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r8
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x68(%rsp), %r12
addq	0x20(%rsp), %r12
movq	%rax, %r13
addq	%r15, %r12
movq	%r8, %r14
rorq	$0x17, %r13
movq	%rbx, %r15
xorq	%rax, %r13
rorq	$0x5, %r14
xorq	%rcx, %r15
movq	%r12, 0x20(%rsp)
xorq	%r8, %r14
andq	%rax, %r15
rorq	$0x4, %r13
addq	%rdx, %r12
xorq	%rcx, %r15
rorq	$0x6, %r14
xorq	%rax, %r13
addq	%r15, %r12
movq	%r8, %r15
addq	(%rbp), %r12
xorq	%r8, %r14
xorq	%r9, %r15
rorq	$0xe, %r13
movq	%r9, %rdx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rdx
addq	%r12, %r11
addq	%r12, %rdx
leaq	0x8(%rbp), %rbp
movq	0x30(%rsp), %r13
movq	0x18(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rdx
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x70(%rsp), %r12
addq	0x28(%rsp), %r12
movq	%r11, %r13
addq	%rdi, %r12
movq	%rdx, %r14
rorq	$0x17, %r13
movq	%rax, %rdi
xorq	%r11, %r13
rorq	$0x5, %r14
xorq	%rbx, %rdi
movq	%r12, 0x28(%rsp)
xorq	%rdx, %r14
andq	%r11, %rdi
rorq	$0x4, %r13
addq	%rcx, %r12
xorq	%rbx, %rdi
rorq	$0x6, %r14
xorq	%r11, %r13
addq	%rdi, %r12
movq	%rdx, %rdi
addq	(%rbp), %r12
xorq	%rdx, %r14
xorq	%r8, %rdi
rorq	$0xe, %r13
movq	%r8, %rcx
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rcx
addq	%r12, %r10
addq	%r12, %rcx
leaq	0x18(%rbp), %rbp
movq	0x38(%rsp), %r13
movq	0x20(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rcx
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x78(%rsp), %r12
addq	0x30(%rsp), %r12
movq	%r10, %r13
addq	%r15, %r12
movq	%rcx, %r14
rorq	$0x17, %r13
movq	%r11, %r15
xorq	%r10, %r13
rorq	$0x5, %r14
xorq	%rax, %r15
movq	%r12, 0x30(%rsp)
xorq	%rcx, %r14
andq	%r10, %r15
rorq	$0x4, %r13
addq	%rbx, %r12
xorq	%rax, %r15
rorq	$0x6, %r14
xorq	%r10, %r13
addq	%r15, %r12
movq	%rcx, %r15
addq	(%rbp), %r12
xorq	%rcx, %r14
xorq	%rdx, %r15
rorq	$0xe, %r13
movq	%rdx, %rbx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rbx
addq	%r12, %r9
addq	%r12, %rbx
leaq	0x8(%rbp), %rbp
movq	0x40(%rsp), %r13
movq	0x28(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rbx
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	(%rsp), %r12
addq	0x38(%rsp), %r12
movq	%r9, %r13
addq	%rdi, %r12
movq	%rbx, %r14
rorq	$0x17, %r13
movq	%r10, %rdi
xorq	%r9, %r13
rorq	$0x5, %r14
xorq	%r11, %rdi
movq	%r12, 0x38(%rsp)
xorq	%rbx, %r14
andq	%r9, %rdi
rorq	$0x4, %r13
addq	%rax, %r12
xorq	%r11, %rdi
rorq	$0x6, %r14
xorq	%r9, %r13
addq	%rdi, %r12
movq	%rbx, %rdi
addq	(%rbp), %r12
xorq	%rbx, %r14
xorq	%rcx, %rdi
rorq	$0xe, %r13
movq	%rcx, %rax
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rax
addq	%r12, %r8
addq	%r12, %rax
leaq	0x18(%rbp), %rbp
movq	0x48(%rsp), %r13
movq	0x30(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rax
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x8(%rsp), %r12
addq	0x40(%rsp), %r12
movq	%r8, %r13
addq	%r15, %r12
movq	%rax, %r14
rorq	$0x17, %r13
movq	%r9, %r15
xorq	%r8, %r13
rorq	$0x5, %r14
xorq	%r10, %r15
movq	%r12, 0x40(%rsp)
xorq	%rax, %r14
andq	%r8, %r15
rorq	$0x4, %r13
addq	%r11, %r12
xorq	%r10, %r15
rorq	$0x6, %r14
xorq	%r8, %r13
addq	%r15, %r12
movq	%rax, %r15
addq	(%rbp), %r12
xorq	%rax, %r14
xorq	%rbx, %r15
rorq	$0xe, %r13
movq	%rbx, %r11
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r11
addq	%r12, %rdx
addq	%r12, %r11
leaq	0x8(%rbp), %rbp
movq	0x50(%rsp), %r13
movq	0x38(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r11
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x10(%rsp), %r12
addq	0x48(%rsp), %r12
movq	%rdx, %r13
addq	%rdi, %r12
movq	%r11, %r14
rorq	$0x17, %r13
movq	%r8, %rdi
xorq	%rdx, %r13
rorq	$0x5, %r14
xorq	%r9, %rdi
movq	%r12, 0x48(%rsp)
xorq	%r11, %r14
andq	%rdx, %rdi
rorq	$0x4, %r13
addq	%r10, %r12
xorq	%r9, %rdi
rorq	$0x6, %r14
xorq	%rdx, %r13
addq	%rdi, %r12
movq	%r11, %rdi
addq	(%rbp), %r12
xorq	%r11, %r14
xorq	%rax, %rdi
rorq	$0xe, %r13
movq	%rax, %r10
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r10
addq	%r12, %rcx
addq	%r12, %r10
leaq	0x18(%rbp), %rbp
movq	0x58(%rsp), %r13
movq	0x40(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r10
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x18(%rsp), %r12
addq	0x50(%rsp), %r12
movq	%rcx, %r13
addq	%r15, %r12
movq	%r10, %r14
rorq	$0x17, %r13
movq	%rdx, %r15
xorq	%rcx, %r13
rorq	$0x5, %r14
xorq	%r8, %r15
movq	%r12, 0x50(%rsp)
xorq	%r10, %r14
andq	%rcx, %r15
rorq	$0x4, %r13
addq	%r9, %r12
xorq	%r8, %r15
rorq	$0x6, %r14
xorq	%rcx, %r13
addq	%r15, %r12
movq	%r10, %r15
addq	(%rbp), %r12
xorq	%r10, %r14
xorq	%r11, %r15
rorq	$0xe, %r13
movq	%r11, %r9
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %r9
addq	%r12, %rbx
addq	%r12, %r9
leaq	0x8(%rbp), %rbp
movq	0x60(%rsp), %r13
movq	0x48(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r9
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x20(%rsp), %r12
addq	0x58(%rsp), %r12
movq	%rbx, %r13
addq	%rdi, %r12
movq	%r9, %r14
rorq	$0x17, %r13
movq	%rcx, %rdi
xorq	%rbx, %r13
rorq	$0x5, %r14
xorq	%rdx, %rdi
movq	%r12, 0x58(%rsp)
xorq	%r9, %r14
andq	%rbx, %rdi
rorq	$0x4, %r13
addq	%r8, %r12
xorq	%rdx, %rdi
rorq	$0x6, %r14
xorq	%rbx, %r13
addq	%rdi, %r12
movq	%r9, %rdi
addq	(%rbp), %r12
xorq	%r9, %r14
xorq	%r10, %rdi
rorq	$0xe, %r13
movq	%r10, %r8
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %r8
addq	%r12, %rax
addq	%r12, %r8
leaq	0x18(%rbp), %rbp
movq	0x68(%rsp), %r13
movq	0x50(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %r8
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x28(%rsp), %r12
addq	0x60(%rsp), %r12
movq	%rax, %r13
addq	%r15, %r12
movq	%r8, %r14
rorq	$0x17, %r13
movq	%rbx, %r15
xorq	%rax, %r13
rorq	$0x5, %r14
xorq	%rcx, %r15
movq	%r12, 0x60(%rsp)
xorq	%r8, %r14
andq	%rax, %r15
rorq	$0x4, %r13
addq	%rdx, %r12
xorq	%rcx, %r15
rorq	$0x6, %r14
xorq	%rax, %r13
addq	%r15, %r12
movq	%r8, %r15
addq	(%rbp), %r12
xorq	%r8, %r14
xorq	%r9, %r15
rorq	$0xe, %r13
movq	%r9, %rdx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rdx
addq	%r12, %r11
addq	%r12, %rdx
leaq	0x8(%rbp), %rbp
movq	0x70(%rsp), %r13
movq	0x58(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rdx
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x30(%rsp), %r12
addq	0x68(%rsp), %r12
movq	%r11, %r13
addq	%rdi, %r12
movq	%rdx, %r14
rorq	$0x17, %r13
movq	%rax, %rdi
xorq	%r11, %r13
rorq	$0x5, %r14
xorq	%rbx, %rdi
movq	%r12, 0x68(%rsp)
xorq	%rdx, %r14
andq	%r11, %rdi
rorq	$0x4, %r13
addq	%rcx, %r12
xorq	%rbx, %rdi
rorq	$0x6, %r14
xorq	%r11, %r13
addq	%rdi, %r12
movq	%rdx, %rdi
addq	(%rbp), %r12
xorq	%rdx, %r14
xorq	%r8, %rdi
rorq	$0xe, %r13
movq	%r8, %rcx
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rcx
addq	%r12, %r10
addq	%r12, %rcx
leaq	0x18(%rbp), %rbp
movq	0x78(%rsp), %r13
movq	0x60(%rsp), %r15
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rcx
movq	%r15, %r14
rorq	$0x2a, %r15
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %r15
shrq	$0x6, %r14
rorq	$0x13, %r15
xorq	%r13, %r12
xorq	%r14, %r15
addq	0x38(%rsp), %r12
addq	0x70(%rsp), %r12
movq	%r10, %r13
addq	%r15, %r12
movq	%rcx, %r14
rorq	$0x17, %r13
movq	%r11, %r15
xorq	%r10, %r13
rorq	$0x5, %r14
xorq	%rax, %r15
movq	%r12, 0x70(%rsp)
xorq	%rcx, %r14
andq	%r10, %r15
rorq	$0x4, %r13
addq	%rbx, %r12
xorq	%rax, %r15
rorq	$0x6, %r14
xorq	%r10, %r13
addq	%r15, %r12
movq	%rcx, %r15
addq	(%rbp), %r12
xorq	%rcx, %r14
xorq	%rdx, %r15
rorq	$0xe, %r13
movq	%rdx, %rbx
andq	%r15, %rdi
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%rdi, %rbx
addq	%r12, %r9
addq	%r12, %rbx
leaq	0x8(%rbp), %rbp
movq	(%rsp), %r13
movq	0x68(%rsp), %rdi
movq	%r13, %r12
rorq	$0x7, %r13
addq	%r14, %rbx
movq	%rdi, %r14
rorq	$0x2a, %rdi
xorq	%r12, %r13
shrq	$0x7, %r12
rorq	%r13
xorq	%r14, %rdi
shrq	$0x6, %r14
rorq	$0x13, %rdi
xorq	%r13, %r12
xorq	%r14, %rdi
addq	0x40(%rsp), %r12
addq	0x78(%rsp), %r12
movq	%r9, %r13
addq	%rdi, %r12
movq	%rbx, %r14
rorq	$0x17, %r13
movq	%r10, %rdi
xorq	%r9, %r13
rorq	$0x5, %r14
xorq	%r11, %rdi
movq	%r12, 0x78(%rsp)
xorq	%rbx, %r14
andq	%r9, %rdi
rorq	$0x4, %r13
addq	%rax, %r12
xorq	%r11, %rdi
rorq	$0x6, %r14
xorq	%r9, %r13
addq	%rdi, %r12
movq	%rbx, %rdi
addq	(%rbp), %r12
xorq	%rbx, %r14
xorq	%rcx, %rdi
rorq	$0xe, %r13
movq	%rcx, %rax
andq	%rdi, %r15
rorq	$0x1c, %r14
addq	%r13, %r12
xorq	%r15, %rax
addq	%r12, %r8
addq	%r12, %rax
leaq	0x18(%rbp), %rbp
cmpb	$0x0, 0x7(%rbp)
jne	L_780
movq	0x80(%rsp), %rdi
addq	%r14, %rax
leaq	0x80(%rsi), %rsi
addq	(%rdi), %rax
addq	0x8(%rdi), %rbx
addq	0x10(%rdi), %rcx
addq	0x18(%rdi), %rdx
addq	0x20(%rdi), %r8
addq	0x28(%rdi), %r9
addq	0x30(%rdi), %r10
addq	0x38(%rdi), %r11
cmpq	0x90(%rsp), %rsi
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rcx, 0x10(%rdi)
movq	%rdx, 0x18(%rdi)
movq	%r8, 0x20(%rdi)
movq	%r9, 0x28(%rdi)
movq	%r10, 0x30(%rdi)
movq	%r11, 0x38(%rdi)
jb	L_c0
movq	0x98(%rsp), %rsi
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
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
sha512_block_data_order_xop:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shlq	$0x4, %rdx
subq	$0xa0, %rsp
leaq	(%rsi,%rdx,8), %rdx
andq	$-0x40, %rsp
movq	%rdi, 0x80(%rsp)
movq	%rsi, 0x88(%rsp)
movq	%rdx, 0x90(%rsp)
movq	%rax, 0x98(%rsp)
vzeroupper
movq	(%rdi), %rax
movq	0x8(%rdi), %rbx
movq	0x10(%rdi), %rcx
movq	0x18(%rdi), %rdx
movq	0x20(%rdi), %r8
movq	0x28(%rdi), %r9
movq	0x30(%rdi), %r10
movq	0x38(%rdi), %r11
jmp	L_12f0
nopw	%cs:(%rax,%rax)
nop
L_12f0:
vmovdqa	K512_single-128(%rip), %xmm11
vmovdqu	(%rsi), %xmm0
leaq	K512+128(%rip), %rbp
vmovdqu	0x10(%rsi), %xmm1
vmovdqu	0x20(%rsi), %xmm2
vpshufb	%xmm11, %xmm0, %xmm0
vmovdqu	0x30(%rsi), %xmm3
vpshufb	%xmm11, %xmm1, %xmm1
vmovdqu	0x40(%rsi), %xmm4
vpshufb	%xmm11, %xmm2, %xmm2
vmovdqu	0x50(%rsi), %xmm5
vpshufb	%xmm11, %xmm3, %xmm3
vmovdqu	0x60(%rsi), %xmm6
vpshufb	%xmm11, %xmm4, %xmm4
vmovdqu	0x70(%rsi), %xmm7
vpshufb	%xmm11, %xmm5, %xmm5
vpaddq	-0x80(%rbp), %xmm0, %xmm8
vpshufb	%xmm11, %xmm6, %xmm6
vpaddq	-0x60(%rbp), %xmm1, %xmm9
vpshufb	%xmm11, %xmm7, %xmm7
vpaddq	-0x40(%rbp), %xmm2, %xmm10
vpaddq	-0x20(%rbp), %xmm3, %xmm11
vmovdqa	%xmm8, (%rsp)
vpaddq	(%rbp), %xmm4, %xmm8
vmovdqa	%xmm9, 0x10(%rsp)
vpaddq	0x20(%rbp), %xmm5, %xmm9
vmovdqa	%xmm10, 0x20(%rsp)
vpaddq	0x40(%rbp), %xmm6, %xmm10
vmovdqa	%xmm11, 0x30(%rsp)
vpaddq	0x60(%rbp), %xmm7, %xmm11
vmovdqa	%xmm8, 0x40(%rsp)
movq	%rax, %r14
vmovdqa	%xmm9, 0x50(%rsp)
movq	%rbx, %rdi
vmovdqa	%xmm10, 0x60(%rsp)
xorq	%rcx, %rdi
vmovdqa	%xmm11, 0x70(%rsp)
movq	%r8, %r13
jmp	L_13c0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_13c0:
addq	$0x100, %rbp
vpalignr	$0x8, %xmm0, %xmm1, %xmm8
rorq	$0x17, %r13
movq	%r14, %rax
vpalignr	$0x8, %xmm4, %xmm5, %xmm11
movq	%r9, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%r8, %r13
xorq	%r10, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%rax, %r14
vpaddq	%xmm0, %xmm11, %xmm0
andq	%r8, %r12
xorq	%r8, %r13
addq	(%rsp), %r11
movq	%rax, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%r10, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%rbx, %r15
addq	%r12, %r11
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm7, %xmm11
xorq	%rax, %r14
addq	%r13, %r11
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rbx, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm7, %xmm10
addq	%r11, %rdx
addq	%rdi, %r11
vpaddq	%xmm0, %xmm8, %xmm0
movq	%rdx, %r13
addq	%r11, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %r11
vpxor	%xmm10, %xmm11, %xmm11
movq	%r8, %r12
rorq	$0x5, %r14
xorq	%rdx, %r13
xorq	%r9, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%r11, %r14
andq	%rdx, %r12
xorq	%rdx, %r13
vpaddq	%xmm0, %xmm11, %xmm0
addq	0x8(%rsp), %r10
movq	%r11, %rdi
xorq	%r9, %r12
rorq	$0x6, %r14
vpaddq	-0x80(%rbp), %xmm0, %xmm10
xorq	%rax, %rdi
addq	%r12, %r10
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r11, %r14
addq	%r13, %r10
xorq	%rax, %r15
rorq	$0x1c, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
vmovdqa	%xmm10, (%rsp)
vpalignr	$0x8, %xmm1, %xmm2, %xmm8
rorq	$0x17, %r13
movq	%r14, %r10
vpalignr	$0x8, %xmm5, %xmm6, %xmm11
movq	%rdx, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%rcx, %r13
xorq	%r8, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%r10, %r14
vpaddq	%xmm1, %xmm11, %xmm1
andq	%rcx, %r12
xorq	%rcx, %r13
addq	0x10(%rsp), %r9
movq	%r10, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%r8, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%r11, %r15
addq	%r12, %r9
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm0, %xmm11
xorq	%r10, %r14
addq	%r13, %r9
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r11, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm0, %xmm10
addq	%r9, %rbx
addq	%rdi, %r9
vpaddq	%xmm1, %xmm8, %xmm1
movq	%rbx, %r13
addq	%r9, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %r9
vpxor	%xmm10, %xmm11, %xmm11
movq	%rcx, %r12
rorq	$0x5, %r14
xorq	%rbx, %r13
xorq	%rdx, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%r9, %r14
andq	%rbx, %r12
xorq	%rbx, %r13
vpaddq	%xmm1, %xmm11, %xmm1
addq	0x18(%rsp), %r8
movq	%r9, %rdi
xorq	%rdx, %r12
rorq	$0x6, %r14
vpaddq	-0x60(%rbp), %xmm1, %xmm10
xorq	%r10, %rdi
addq	%r12, %r8
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r9, %r14
addq	%r13, %r8
xorq	%r10, %r15
rorq	$0x1c, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
vmovdqa	%xmm10, 0x10(%rsp)
vpalignr	$0x8, %xmm2, %xmm3, %xmm8
rorq	$0x17, %r13
movq	%r14, %r8
vpalignr	$0x8, %xmm6, %xmm7, %xmm11
movq	%rbx, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%rax, %r13
xorq	%rcx, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%r8, %r14
vpaddq	%xmm2, %xmm11, %xmm2
andq	%rax, %r12
xorq	%rax, %r13
addq	0x20(%rsp), %rdx
movq	%r8, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%rcx, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%r9, %r15
addq	%r12, %rdx
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm1, %xmm11
xorq	%r8, %r14
addq	%r13, %rdx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r9, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm1, %xmm10
addq	%rdx, %r11
addq	%rdi, %rdx
vpaddq	%xmm2, %xmm8, %xmm2
movq	%r11, %r13
addq	%rdx, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %rdx
vpxor	%xmm10, %xmm11, %xmm11
movq	%rax, %r12
rorq	$0x5, %r14
xorq	%r11, %r13
xorq	%rbx, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%rdx, %r14
andq	%r11, %r12
xorq	%r11, %r13
vpaddq	%xmm2, %xmm11, %xmm2
addq	0x28(%rsp), %rcx
movq	%rdx, %rdi
xorq	%rbx, %r12
rorq	$0x6, %r14
vpaddq	-0x40(%rbp), %xmm2, %xmm10
xorq	%r8, %rdi
addq	%r12, %rcx
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rdx, %r14
addq	%r13, %rcx
xorq	%r8, %r15
rorq	$0x1c, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
vmovdqa	%xmm10, 0x20(%rsp)
vpalignr	$0x8, %xmm3, %xmm4, %xmm8
rorq	$0x17, %r13
movq	%r14, %rcx
vpalignr	$0x8, %xmm7, %xmm0, %xmm11
movq	%r11, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%r10, %r13
xorq	%rax, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%rcx, %r14
vpaddq	%xmm3, %xmm11, %xmm3
andq	%r10, %r12
xorq	%r10, %r13
addq	0x30(%rsp), %rbx
movq	%rcx, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%rax, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%rdx, %r15
addq	%r12, %rbx
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm2, %xmm11
xorq	%rcx, %r14
addq	%r13, %rbx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rdx, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm2, %xmm10
addq	%rbx, %r9
addq	%rdi, %rbx
vpaddq	%xmm3, %xmm8, %xmm3
movq	%r9, %r13
addq	%rbx, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %rbx
vpxor	%xmm10, %xmm11, %xmm11
movq	%r10, %r12
rorq	$0x5, %r14
xorq	%r9, %r13
xorq	%r11, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%rbx, %r14
andq	%r9, %r12
xorq	%r9, %r13
vpaddq	%xmm3, %xmm11, %xmm3
addq	0x38(%rsp), %rax
movq	%rbx, %rdi
xorq	%r11, %r12
rorq	$0x6, %r14
vpaddq	-0x20(%rbp), %xmm3, %xmm10
xorq	%rcx, %rdi
addq	%r12, %rax
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rbx, %r14
addq	%r13, %rax
xorq	%rcx, %r15
rorq	$0x1c, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
vmovdqa	%xmm10, 0x30(%rsp)
vpalignr	$0x8, %xmm4, %xmm5, %xmm8
rorq	$0x17, %r13
movq	%r14, %rax
vpalignr	$0x8, %xmm0, %xmm1, %xmm11
movq	%r9, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%r8, %r13
xorq	%r10, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%rax, %r14
vpaddq	%xmm4, %xmm11, %xmm4
andq	%r8, %r12
xorq	%r8, %r13
addq	0x40(%rsp), %r11
movq	%rax, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%r10, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%rbx, %r15
addq	%r12, %r11
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm3, %xmm11
xorq	%rax, %r14
addq	%r13, %r11
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rbx, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm3, %xmm10
addq	%r11, %rdx
addq	%rdi, %r11
vpaddq	%xmm4, %xmm8, %xmm4
movq	%rdx, %r13
addq	%r11, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %r11
vpxor	%xmm10, %xmm11, %xmm11
movq	%r8, %r12
rorq	$0x5, %r14
xorq	%rdx, %r13
xorq	%r9, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%r11, %r14
andq	%rdx, %r12
xorq	%rdx, %r13
vpaddq	%xmm4, %xmm11, %xmm4
addq	0x48(%rsp), %r10
movq	%r11, %rdi
xorq	%r9, %r12
rorq	$0x6, %r14
vpaddq	(%rbp), %xmm4, %xmm10
xorq	%rax, %rdi
addq	%r12, %r10
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r11, %r14
addq	%r13, %r10
xorq	%rax, %r15
rorq	$0x1c, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
vmovdqa	%xmm10, 0x40(%rsp)
vpalignr	$0x8, %xmm5, %xmm6, %xmm8
rorq	$0x17, %r13
movq	%r14, %r10
vpalignr	$0x8, %xmm1, %xmm2, %xmm11
movq	%rdx, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%rcx, %r13
xorq	%r8, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%r10, %r14
vpaddq	%xmm5, %xmm11, %xmm5
andq	%rcx, %r12
xorq	%rcx, %r13
addq	0x50(%rsp), %r9
movq	%r10, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%r8, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%r11, %r15
addq	%r12, %r9
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm4, %xmm11
xorq	%r10, %r14
addq	%r13, %r9
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r11, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm4, %xmm10
addq	%r9, %rbx
addq	%rdi, %r9
vpaddq	%xmm5, %xmm8, %xmm5
movq	%rbx, %r13
addq	%r9, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %r9
vpxor	%xmm10, %xmm11, %xmm11
movq	%rcx, %r12
rorq	$0x5, %r14
xorq	%rbx, %r13
xorq	%rdx, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%r9, %r14
andq	%rbx, %r12
xorq	%rbx, %r13
vpaddq	%xmm5, %xmm11, %xmm5
addq	0x58(%rsp), %r8
movq	%r9, %rdi
xorq	%rdx, %r12
rorq	$0x6, %r14
vpaddq	0x20(%rbp), %xmm5, %xmm10
xorq	%r10, %rdi
addq	%r12, %r8
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r9, %r14
addq	%r13, %r8
xorq	%r10, %r15
rorq	$0x1c, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
vmovdqa	%xmm10, 0x50(%rsp)
vpalignr	$0x8, %xmm6, %xmm7, %xmm8
rorq	$0x17, %r13
movq	%r14, %r8
vpalignr	$0x8, %xmm2, %xmm3, %xmm11
movq	%rbx, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%rax, %r13
xorq	%rcx, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%r8, %r14
vpaddq	%xmm6, %xmm11, %xmm6
andq	%rax, %r12
xorq	%rax, %r13
addq	0x60(%rsp), %rdx
movq	%r8, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%rcx, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%r9, %r15
addq	%r12, %rdx
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm5, %xmm11
xorq	%r8, %r14
addq	%r13, %rdx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r9, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm5, %xmm10
addq	%rdx, %r11
addq	%rdi, %rdx
vpaddq	%xmm6, %xmm8, %xmm6
movq	%r11, %r13
addq	%rdx, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %rdx
vpxor	%xmm10, %xmm11, %xmm11
movq	%rax, %r12
rorq	$0x5, %r14
xorq	%r11, %r13
xorq	%rbx, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%rdx, %r14
andq	%r11, %r12
xorq	%r11, %r13
vpaddq	%xmm6, %xmm11, %xmm6
addq	0x68(%rsp), %rcx
movq	%rdx, %rdi
xorq	%rbx, %r12
rorq	$0x6, %r14
vpaddq	0x40(%rbp), %xmm6, %xmm10
xorq	%r8, %rdi
addq	%r12, %rcx
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rdx, %r14
addq	%r13, %rcx
xorq	%r8, %r15
rorq	$0x1c, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
vmovdqa	%xmm10, 0x60(%rsp)
vpalignr	$0x8, %xmm7, %xmm0, %xmm8
rorq	$0x17, %r13
movq	%r14, %rcx
vpalignr	$0x8, %xmm3, %xmm4, %xmm11
movq	%r11, %r12
rorq	$0x5, %r14
vprotq	$0x38, %xmm8, %xmm9
xorq	%r10, %r13
xorq	%rax, %r12
vpsrlq	$0x7, %xmm8, %xmm8
rorq	$0x4, %r13
xorq	%rcx, %r14
vpaddq	%xmm7, %xmm11, %xmm7
andq	%r10, %r12
xorq	%r10, %r13
addq	0x70(%rsp), %rbx
movq	%rcx, %r15
vprotq	$0x7, %xmm9, %xmm10
xorq	%rax, %r12
rorq	$0x6, %r14
vpxor	%xmm9, %xmm8, %xmm8
xorq	%rdx, %r15
addq	%r12, %rbx
rorq	$0xe, %r13
andq	%r15, %rdi
vprotq	$0x3, %xmm6, %xmm11
xorq	%rcx, %r14
addq	%r13, %rbx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rdx, %rdi
rorq	$0x1c, %r14
vpsrlq	$0x6, %xmm6, %xmm10
addq	%rbx, %r9
addq	%rdi, %rbx
vpaddq	%xmm7, %xmm8, %xmm7
movq	%r9, %r13
addq	%rbx, %r14
vprotq	$0x2a, %xmm11, %xmm9
rorq	$0x17, %r13
movq	%r14, %rbx
vpxor	%xmm10, %xmm11, %xmm11
movq	%r10, %r12
rorq	$0x5, %r14
xorq	%r9, %r13
xorq	%r11, %r12
vpxor	%xmm9, %xmm11, %xmm11
rorq	$0x4, %r13
xorq	%rbx, %r14
andq	%r9, %r12
xorq	%r9, %r13
vpaddq	%xmm7, %xmm11, %xmm7
addq	0x78(%rsp), %rax
movq	%rbx, %rdi
xorq	%r11, %r12
rorq	$0x6, %r14
vpaddq	0x60(%rbp), %xmm7, %xmm10
xorq	%rcx, %rdi
addq	%r12, %rax
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rbx, %r14
addq	%r13, %rax
xorq	%rcx, %r15
rorq	$0x1c, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
vmovdqa	%xmm10, 0x70(%rsp)
cmpb	$0x0, 0x87(%rbp)
jne	L_13c0
rorq	$0x17, %r13
movq	%r14, %rax
movq	%r9, %r12
rorq	$0x5, %r14
xorq	%r8, %r13
xorq	%r10, %r12
rorq	$0x4, %r13
xorq	%rax, %r14
andq	%r8, %r12
xorq	%r8, %r13
addq	(%rsp), %r11
movq	%rax, %r15
xorq	%r10, %r12
rorq	$0x6, %r14
xorq	%rbx, %r15
addq	%r12, %r11
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%rax, %r14
addq	%r13, %r11
xorq	%rbx, %rdi
rorq	$0x1c, %r14
addq	%r11, %rdx
addq	%rdi, %r11
movq	%rdx, %r13
addq	%r11, %r14
rorq	$0x17, %r13
movq	%r14, %r11
movq	%r8, %r12
rorq	$0x5, %r14
xorq	%rdx, %r13
xorq	%r9, %r12
rorq	$0x4, %r13
xorq	%r11, %r14
andq	%rdx, %r12
xorq	%rdx, %r13
addq	0x8(%rsp), %r10
movq	%r11, %rdi
xorq	%r9, %r12
rorq	$0x6, %r14
xorq	%rax, %rdi
addq	%r12, %r10
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r11, %r14
addq	%r13, %r10
xorq	%rax, %r15
rorq	$0x1c, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
rorq	$0x17, %r13
movq	%r14, %r10
movq	%rdx, %r12
rorq	$0x5, %r14
xorq	%rcx, %r13
xorq	%r8, %r12
rorq	$0x4, %r13
xorq	%r10, %r14
andq	%rcx, %r12
xorq	%rcx, %r13
addq	0x10(%rsp), %r9
movq	%r10, %r15
xorq	%r8, %r12
rorq	$0x6, %r14
xorq	%r11, %r15
addq	%r12, %r9
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%r10, %r14
addq	%r13, %r9
xorq	%r11, %rdi
rorq	$0x1c, %r14
addq	%r9, %rbx
addq	%rdi, %r9
movq	%rbx, %r13
addq	%r9, %r14
rorq	$0x17, %r13
movq	%r14, %r9
movq	%rcx, %r12
rorq	$0x5, %r14
xorq	%rbx, %r13
xorq	%rdx, %r12
rorq	$0x4, %r13
xorq	%r9, %r14
andq	%rbx, %r12
xorq	%rbx, %r13
addq	0x18(%rsp), %r8
movq	%r9, %rdi
xorq	%rdx, %r12
rorq	$0x6, %r14
xorq	%r10, %rdi
addq	%r12, %r8
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r9, %r14
addq	%r13, %r8
xorq	%r10, %r15
rorq	$0x1c, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
rorq	$0x17, %r13
movq	%r14, %r8
movq	%rbx, %r12
rorq	$0x5, %r14
xorq	%rax, %r13
xorq	%rcx, %r12
rorq	$0x4, %r13
xorq	%r8, %r14
andq	%rax, %r12
xorq	%rax, %r13
addq	0x20(%rsp), %rdx
movq	%r8, %r15
xorq	%rcx, %r12
rorq	$0x6, %r14
xorq	%r9, %r15
addq	%r12, %rdx
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%r8, %r14
addq	%r13, %rdx
xorq	%r9, %rdi
rorq	$0x1c, %r14
addq	%rdx, %r11
addq	%rdi, %rdx
movq	%r11, %r13
addq	%rdx, %r14
rorq	$0x17, %r13
movq	%r14, %rdx
movq	%rax, %r12
rorq	$0x5, %r14
xorq	%r11, %r13
xorq	%rbx, %r12
rorq	$0x4, %r13
xorq	%rdx, %r14
andq	%r11, %r12
xorq	%r11, %r13
addq	0x28(%rsp), %rcx
movq	%rdx, %rdi
xorq	%rbx, %r12
rorq	$0x6, %r14
xorq	%r8, %rdi
addq	%r12, %rcx
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rdx, %r14
addq	%r13, %rcx
xorq	%r8, %r15
rorq	$0x1c, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
rorq	$0x17, %r13
movq	%r14, %rcx
movq	%r11, %r12
rorq	$0x5, %r14
xorq	%r10, %r13
xorq	%rax, %r12
rorq	$0x4, %r13
xorq	%rcx, %r14
andq	%r10, %r12
xorq	%r10, %r13
addq	0x30(%rsp), %rbx
movq	%rcx, %r15
xorq	%rax, %r12
rorq	$0x6, %r14
xorq	%rdx, %r15
addq	%r12, %rbx
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%rcx, %r14
addq	%r13, %rbx
xorq	%rdx, %rdi
rorq	$0x1c, %r14
addq	%rbx, %r9
addq	%rdi, %rbx
movq	%r9, %r13
addq	%rbx, %r14
rorq	$0x17, %r13
movq	%r14, %rbx
movq	%r10, %r12
rorq	$0x5, %r14
xorq	%r9, %r13
xorq	%r11, %r12
rorq	$0x4, %r13
xorq	%rbx, %r14
andq	%r9, %r12
xorq	%r9, %r13
addq	0x38(%rsp), %rax
movq	%rbx, %rdi
xorq	%r11, %r12
rorq	$0x6, %r14
xorq	%rcx, %rdi
addq	%r12, %rax
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rbx, %r14
addq	%r13, %rax
xorq	%rcx, %r15
rorq	$0x1c, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
rorq	$0x17, %r13
movq	%r14, %rax
movq	%r9, %r12
rorq	$0x5, %r14
xorq	%r8, %r13
xorq	%r10, %r12
rorq	$0x4, %r13
xorq	%rax, %r14
andq	%r8, %r12
xorq	%r8, %r13
addq	0x40(%rsp), %r11
movq	%rax, %r15
xorq	%r10, %r12
rorq	$0x6, %r14
xorq	%rbx, %r15
addq	%r12, %r11
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%rax, %r14
addq	%r13, %r11
xorq	%rbx, %rdi
rorq	$0x1c, %r14
addq	%r11, %rdx
addq	%rdi, %r11
movq	%rdx, %r13
addq	%r11, %r14
rorq	$0x17, %r13
movq	%r14, %r11
movq	%r8, %r12
rorq	$0x5, %r14
xorq	%rdx, %r13
xorq	%r9, %r12
rorq	$0x4, %r13
xorq	%r11, %r14
andq	%rdx, %r12
xorq	%rdx, %r13
addq	0x48(%rsp), %r10
movq	%r11, %rdi
xorq	%r9, %r12
rorq	$0x6, %r14
xorq	%rax, %rdi
addq	%r12, %r10
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r11, %r14
addq	%r13, %r10
xorq	%rax, %r15
rorq	$0x1c, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
rorq	$0x17, %r13
movq	%r14, %r10
movq	%rdx, %r12
rorq	$0x5, %r14
xorq	%rcx, %r13
xorq	%r8, %r12
rorq	$0x4, %r13
xorq	%r10, %r14
andq	%rcx, %r12
xorq	%rcx, %r13
addq	0x50(%rsp), %r9
movq	%r10, %r15
xorq	%r8, %r12
rorq	$0x6, %r14
xorq	%r11, %r15
addq	%r12, %r9
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%r10, %r14
addq	%r13, %r9
xorq	%r11, %rdi
rorq	$0x1c, %r14
addq	%r9, %rbx
addq	%rdi, %r9
movq	%rbx, %r13
addq	%r9, %r14
rorq	$0x17, %r13
movq	%r14, %r9
movq	%rcx, %r12
rorq	$0x5, %r14
xorq	%rbx, %r13
xorq	%rdx, %r12
rorq	$0x4, %r13
xorq	%r9, %r14
andq	%rbx, %r12
xorq	%rbx, %r13
addq	0x58(%rsp), %r8
movq	%r9, %rdi
xorq	%rdx, %r12
rorq	$0x6, %r14
xorq	%r10, %rdi
addq	%r12, %r8
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%r9, %r14
addq	%r13, %r8
xorq	%r10, %r15
rorq	$0x1c, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
rorq	$0x17, %r13
movq	%r14, %r8
movq	%rbx, %r12
rorq	$0x5, %r14
xorq	%rax, %r13
xorq	%rcx, %r12
rorq	$0x4, %r13
xorq	%r8, %r14
andq	%rax, %r12
xorq	%rax, %r13
addq	0x60(%rsp), %rdx
movq	%r8, %r15
xorq	%rcx, %r12
rorq	$0x6, %r14
xorq	%r9, %r15
addq	%r12, %rdx
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%r8, %r14
addq	%r13, %rdx
xorq	%r9, %rdi
rorq	$0x1c, %r14
addq	%rdx, %r11
addq	%rdi, %rdx
movq	%r11, %r13
addq	%rdx, %r14
rorq	$0x17, %r13
movq	%r14, %rdx
movq	%rax, %r12
rorq	$0x5, %r14
xorq	%r11, %r13
xorq	%rbx, %r12
rorq	$0x4, %r13
xorq	%rdx, %r14
andq	%r11, %r12
xorq	%r11, %r13
addq	0x68(%rsp), %rcx
movq	%rdx, %rdi
xorq	%rbx, %r12
rorq	$0x6, %r14
xorq	%r8, %rdi
addq	%r12, %rcx
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rdx, %r14
addq	%r13, %rcx
xorq	%r8, %r15
rorq	$0x1c, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
rorq	$0x17, %r13
movq	%r14, %rcx
movq	%r11, %r12
rorq	$0x5, %r14
xorq	%r10, %r13
xorq	%rax, %r12
rorq	$0x4, %r13
xorq	%rcx, %r14
andq	%r10, %r12
xorq	%r10, %r13
addq	0x70(%rsp), %rbx
movq	%rcx, %r15
xorq	%rax, %r12
rorq	$0x6, %r14
xorq	%rdx, %r15
addq	%r12, %rbx
rorq	$0xe, %r13
andq	%r15, %rdi
xorq	%rcx, %r14
addq	%r13, %rbx
xorq	%rdx, %rdi
rorq	$0x1c, %r14
addq	%rbx, %r9
addq	%rdi, %rbx
movq	%r9, %r13
addq	%rbx, %r14
rorq	$0x17, %r13
movq	%r14, %rbx
movq	%r10, %r12
rorq	$0x5, %r14
xorq	%r9, %r13
xorq	%r11, %r12
rorq	$0x4, %r13
xorq	%rbx, %r14
andq	%r9, %r12
xorq	%r9, %r13
addq	0x78(%rsp), %rax
movq	%rbx, %rdi
xorq	%r11, %r12
rorq	$0x6, %r14
xorq	%rcx, %rdi
addq	%r12, %rax
rorq	$0xe, %r13
andq	%rdi, %r15
xorq	%rbx, %r14
addq	%r13, %rax
xorq	%rcx, %r15
rorq	$0x1c, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
movq	0x80(%rsp), %rdi
movq	%r14, %rax
addq	(%rdi), %rax
leaq	0x80(%rsi), %rsi
addq	0x8(%rdi), %rbx
addq	0x10(%rdi), %rcx
addq	0x18(%rdi), %rdx
addq	0x20(%rdi), %r8
addq	0x28(%rdi), %r9
addq	0x30(%rdi), %r10
addq	0x38(%rdi), %r11
cmpq	0x90(%rsp), %rsi
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rcx, 0x10(%rdi)
movq	%rdx, 0x18(%rdi)
movq	%r8, 0x20(%rdi)
movq	%r9, 0x28(%rdi)
movq	%r10, 0x30(%rdi)
movq	%r11, 0x38(%rdi)
jb	L_12f0
movq	0x98(%rsp), %rsi
vzeroupper
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
nopl	(%rax,%rax)
sha512_block_data_order_avx:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shlq	$0x4, %rdx
subq	$0xa0, %rsp
leaq	(%rsi,%rdx,8), %rdx
andq	$-0x40, %rsp
movq	%rdi, 0x80(%rsp)
movq	%rsi, 0x88(%rsp)
movq	%rdx, 0x90(%rsp)
movq	%rax, 0x98(%rsp)
vzeroupper
movq	(%rdi), %rax
movq	0x8(%rdi), %rbx
movq	0x10(%rdi), %rcx
movq	0x18(%rdi), %rdx
movq	0x20(%rdi), %r8
movq	0x28(%rdi), %r9
movq	0x30(%rdi), %r10
movq	0x38(%rdi), %r11
jmp	L_2270
nopw	%cs:(%rax,%rax)
nop
L_2270:
vmovdqa	K512_single-128(%rip), %xmm11
vmovdqu	(%rsi), %xmm0
leaq	K512+128(%rip), %rbp
vmovdqu	0x10(%rsi), %xmm1
vmovdqu	0x20(%rsi), %xmm2
vpshufb	%xmm11, %xmm0, %xmm0
vmovdqu	0x30(%rsi), %xmm3
vpshufb	%xmm11, %xmm1, %xmm1
vmovdqu	0x40(%rsi), %xmm4
vpshufb	%xmm11, %xmm2, %xmm2
vmovdqu	0x50(%rsi), %xmm5
vpshufb	%xmm11, %xmm3, %xmm3
vmovdqu	0x60(%rsi), %xmm6
vpshufb	%xmm11, %xmm4, %xmm4
vmovdqu	0x70(%rsi), %xmm7
vpshufb	%xmm11, %xmm5, %xmm5
vpaddq	-0x80(%rbp), %xmm0, %xmm8
vpshufb	%xmm11, %xmm6, %xmm6
vpaddq	-0x60(%rbp), %xmm1, %xmm9
vpshufb	%xmm11, %xmm7, %xmm7
vpaddq	-0x40(%rbp), %xmm2, %xmm10
vpaddq	-0x20(%rbp), %xmm3, %xmm11
vmovdqa	%xmm8, (%rsp)
vpaddq	(%rbp), %xmm4, %xmm8
vmovdqa	%xmm9, 0x10(%rsp)
vpaddq	0x20(%rbp), %xmm5, %xmm9
vmovdqa	%xmm10, 0x20(%rsp)
vpaddq	0x40(%rbp), %xmm6, %xmm10
vmovdqa	%xmm11, 0x30(%rsp)
vpaddq	0x60(%rbp), %xmm7, %xmm11
vmovdqa	%xmm8, 0x40(%rsp)
movq	%rax, %r14
vmovdqa	%xmm9, 0x50(%rsp)
movq	%rbx, %rdi
vmovdqa	%xmm10, 0x60(%rsp)
xorq	%rcx, %rdi
vmovdqa	%xmm11, 0x70(%rsp)
movq	%r8, %r13
jmp	L_2340
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2340:
addq	$0x100, %rbp
vpalignr	$0x8, %xmm0, %xmm1, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %rax
vpalignr	$0x8, %xmm4, %xmm5, %xmm11
movq	%r9, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%r8, %r13
xorq	%r10, %r12
vpaddq	%xmm0, %xmm11, %xmm0
shrdq	$0x4, %r13, %r13
xorq	%rax, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%r8, %r12
xorq	%r8, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	(%rsp), %r11
movq	%rax, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%r10, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%rbx, %r15
addq	%r12, %r11
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%rax, %r14
addq	%r13, %r11
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rbx, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm7, %xmm11
addq	%r11, %rdx
addq	%rdi, %r11
vpxor	%xmm9, %xmm8, %xmm8
movq	%rdx, %r13
addq	%r11, %r14
vpsllq	$0x3, %xmm7, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %r11
vpaddq	%xmm0, %xmm8, %xmm0
movq	%r8, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm7, %xmm9
xorq	%rdx, %r13
xorq	%r9, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%r11, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%rdx, %r12
xorq	%rdx, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x8(%rsp), %r10
movq	%r11, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%r9, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%rax, %rdi
addq	%r12, %r10
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm0, %xmm11, %xmm0
xorq	%r11, %r14
addq	%r13, %r10
vpaddq	-0x80(%rbp), %xmm0, %xmm10
xorq	%rax, %r15
shrdq	$0x1c, %r14, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
vmovdqa	%xmm10, (%rsp)
vpalignr	$0x8, %xmm1, %xmm2, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %r10
vpalignr	$0x8, %xmm5, %xmm6, %xmm11
movq	%rdx, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%rcx, %r13
xorq	%r8, %r12
vpaddq	%xmm1, %xmm11, %xmm1
shrdq	$0x4, %r13, %r13
xorq	%r10, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%rcx, %r12
xorq	%rcx, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x10(%rsp), %r9
movq	%r10, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%r8, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%r11, %r15
addq	%r12, %r9
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%r10, %r14
addq	%r13, %r9
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r11, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm0, %xmm11
addq	%r9, %rbx
addq	%rdi, %r9
vpxor	%xmm9, %xmm8, %xmm8
movq	%rbx, %r13
addq	%r9, %r14
vpsllq	$0x3, %xmm0, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %r9
vpaddq	%xmm1, %xmm8, %xmm1
movq	%rcx, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm0, %xmm9
xorq	%rbx, %r13
xorq	%rdx, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%r9, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%rbx, %r12
xorq	%rbx, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x18(%rsp), %r8
movq	%r9, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%rdx, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%r10, %rdi
addq	%r12, %r8
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm1, %xmm11, %xmm1
xorq	%r9, %r14
addq	%r13, %r8
vpaddq	-0x60(%rbp), %xmm1, %xmm10
xorq	%r10, %r15
shrdq	$0x1c, %r14, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
vmovdqa	%xmm10, 0x10(%rsp)
vpalignr	$0x8, %xmm2, %xmm3, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %r8
vpalignr	$0x8, %xmm6, %xmm7, %xmm11
movq	%rbx, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%rax, %r13
xorq	%rcx, %r12
vpaddq	%xmm2, %xmm11, %xmm2
shrdq	$0x4, %r13, %r13
xorq	%r8, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%rax, %r12
xorq	%rax, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x20(%rsp), %rdx
movq	%r8, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%rcx, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%r9, %r15
addq	%r12, %rdx
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%r8, %r14
addq	%r13, %rdx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r9, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm1, %xmm11
addq	%rdx, %r11
addq	%rdi, %rdx
vpxor	%xmm9, %xmm8, %xmm8
movq	%r11, %r13
addq	%rdx, %r14
vpsllq	$0x3, %xmm1, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %rdx
vpaddq	%xmm2, %xmm8, %xmm2
movq	%rax, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm1, %xmm9
xorq	%r11, %r13
xorq	%rbx, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%rdx, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%r11, %r12
xorq	%r11, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x28(%rsp), %rcx
movq	%rdx, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%rbx, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%r8, %rdi
addq	%r12, %rcx
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm2, %xmm11, %xmm2
xorq	%rdx, %r14
addq	%r13, %rcx
vpaddq	-0x40(%rbp), %xmm2, %xmm10
xorq	%r8, %r15
shrdq	$0x1c, %r14, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
vmovdqa	%xmm10, 0x20(%rsp)
vpalignr	$0x8, %xmm3, %xmm4, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %rcx
vpalignr	$0x8, %xmm7, %xmm0, %xmm11
movq	%r11, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%r10, %r13
xorq	%rax, %r12
vpaddq	%xmm3, %xmm11, %xmm3
shrdq	$0x4, %r13, %r13
xorq	%rcx, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%r10, %r12
xorq	%r10, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x30(%rsp), %rbx
movq	%rcx, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%rax, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%rdx, %r15
addq	%r12, %rbx
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%rcx, %r14
addq	%r13, %rbx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rdx, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm2, %xmm11
addq	%rbx, %r9
addq	%rdi, %rbx
vpxor	%xmm9, %xmm8, %xmm8
movq	%r9, %r13
addq	%rbx, %r14
vpsllq	$0x3, %xmm2, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %rbx
vpaddq	%xmm3, %xmm8, %xmm3
movq	%r10, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm2, %xmm9
xorq	%r9, %r13
xorq	%r11, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%rbx, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%r9, %r12
xorq	%r9, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x38(%rsp), %rax
movq	%rbx, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%r11, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%rcx, %rdi
addq	%r12, %rax
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm3, %xmm11, %xmm3
xorq	%rbx, %r14
addq	%r13, %rax
vpaddq	-0x20(%rbp), %xmm3, %xmm10
xorq	%rcx, %r15
shrdq	$0x1c, %r14, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
vmovdqa	%xmm10, 0x30(%rsp)
vpalignr	$0x8, %xmm4, %xmm5, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %rax
vpalignr	$0x8, %xmm0, %xmm1, %xmm11
movq	%r9, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%r8, %r13
xorq	%r10, %r12
vpaddq	%xmm4, %xmm11, %xmm4
shrdq	$0x4, %r13, %r13
xorq	%rax, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%r8, %r12
xorq	%r8, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x40(%rsp), %r11
movq	%rax, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%r10, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%rbx, %r15
addq	%r12, %r11
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%rax, %r14
addq	%r13, %r11
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rbx, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm3, %xmm11
addq	%r11, %rdx
addq	%rdi, %r11
vpxor	%xmm9, %xmm8, %xmm8
movq	%rdx, %r13
addq	%r11, %r14
vpsllq	$0x3, %xmm3, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %r11
vpaddq	%xmm4, %xmm8, %xmm4
movq	%r8, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm3, %xmm9
xorq	%rdx, %r13
xorq	%r9, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%r11, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%rdx, %r12
xorq	%rdx, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x48(%rsp), %r10
movq	%r11, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%r9, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%rax, %rdi
addq	%r12, %r10
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm4, %xmm11, %xmm4
xorq	%r11, %r14
addq	%r13, %r10
vpaddq	(%rbp), %xmm4, %xmm10
xorq	%rax, %r15
shrdq	$0x1c, %r14, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
vmovdqa	%xmm10, 0x40(%rsp)
vpalignr	$0x8, %xmm5, %xmm6, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %r10
vpalignr	$0x8, %xmm1, %xmm2, %xmm11
movq	%rdx, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%rcx, %r13
xorq	%r8, %r12
vpaddq	%xmm5, %xmm11, %xmm5
shrdq	$0x4, %r13, %r13
xorq	%r10, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%rcx, %r12
xorq	%rcx, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x50(%rsp), %r9
movq	%r10, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%r8, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%r11, %r15
addq	%r12, %r9
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%r10, %r14
addq	%r13, %r9
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r11, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm4, %xmm11
addq	%r9, %rbx
addq	%rdi, %r9
vpxor	%xmm9, %xmm8, %xmm8
movq	%rbx, %r13
addq	%r9, %r14
vpsllq	$0x3, %xmm4, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %r9
vpaddq	%xmm5, %xmm8, %xmm5
movq	%rcx, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm4, %xmm9
xorq	%rbx, %r13
xorq	%rdx, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%r9, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%rbx, %r12
xorq	%rbx, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x58(%rsp), %r8
movq	%r9, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%rdx, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%r10, %rdi
addq	%r12, %r8
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm5, %xmm11, %xmm5
xorq	%r9, %r14
addq	%r13, %r8
vpaddq	0x20(%rbp), %xmm5, %xmm10
xorq	%r10, %r15
shrdq	$0x1c, %r14, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
vmovdqa	%xmm10, 0x50(%rsp)
vpalignr	$0x8, %xmm6, %xmm7, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %r8
vpalignr	$0x8, %xmm2, %xmm3, %xmm11
movq	%rbx, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%rax, %r13
xorq	%rcx, %r12
vpaddq	%xmm6, %xmm11, %xmm6
shrdq	$0x4, %r13, %r13
xorq	%r8, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%rax, %r12
xorq	%rax, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x60(%rsp), %rdx
movq	%r8, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%rcx, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%r9, %r15
addq	%r12, %rdx
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%r8, %r14
addq	%r13, %rdx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%r9, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm5, %xmm11
addq	%rdx, %r11
addq	%rdi, %rdx
vpxor	%xmm9, %xmm8, %xmm8
movq	%r11, %r13
addq	%rdx, %r14
vpsllq	$0x3, %xmm5, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %rdx
vpaddq	%xmm6, %xmm8, %xmm6
movq	%rax, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm5, %xmm9
xorq	%r11, %r13
xorq	%rbx, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%rdx, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%r11, %r12
xorq	%r11, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x68(%rsp), %rcx
movq	%rdx, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%rbx, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%r8, %rdi
addq	%r12, %rcx
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm6, %xmm11, %xmm6
xorq	%rdx, %r14
addq	%r13, %rcx
vpaddq	0x40(%rbp), %xmm6, %xmm10
xorq	%r8, %r15
shrdq	$0x1c, %r14, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
vmovdqa	%xmm10, 0x60(%rsp)
vpalignr	$0x8, %xmm7, %xmm0, %xmm8
shrdq	$0x17, %r13, %r13
movq	%r14, %rcx
vpalignr	$0x8, %xmm3, %xmm4, %xmm11
movq	%r11, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x1, %xmm8, %xmm10
xorq	%r10, %r13
xorq	%rax, %r12
vpaddq	%xmm7, %xmm11, %xmm7
shrdq	$0x4, %r13, %r13
xorq	%rcx, %r14
vpsrlq	$0x7, %xmm8, %xmm11
andq	%r10, %r12
xorq	%r10, %r13
vpsllq	$0x38, %xmm8, %xmm9
addq	0x70(%rsp), %rbx
movq	%rcx, %r15
vpxor	%xmm10, %xmm11, %xmm8
xorq	%rax, %r12
shrdq	$0x6, %r14, %r14
vpsrlq	$0x7, %xmm10, %xmm10
xorq	%rdx, %r15
addq	%r12, %rbx
vpxor	%xmm9, %xmm8, %xmm8
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
vpsllq	$0x7, %xmm9, %xmm9
xorq	%rcx, %r14
addq	%r13, %rbx
vpxor	%xmm10, %xmm8, %xmm8
xorq	%rdx, %rdi
shrdq	$0x1c, %r14, %r14
vpsrlq	$0x6, %xmm6, %xmm11
addq	%rbx, %r9
addq	%rdi, %rbx
vpxor	%xmm9, %xmm8, %xmm8
movq	%r9, %r13
addq	%rbx, %r14
vpsllq	$0x3, %xmm6, %xmm10
shrdq	$0x17, %r13, %r13
movq	%r14, %rbx
vpaddq	%xmm7, %xmm8, %xmm7
movq	%r10, %r12
shrdq	$0x5, %r14, %r14
vpsrlq	$0x13, %xmm6, %xmm9
xorq	%r9, %r13
xorq	%r11, %r12
vpxor	%xmm10, %xmm11, %xmm11
shrdq	$0x4, %r13, %r13
xorq	%rbx, %r14
vpsllq	$0x2a, %xmm10, %xmm10
andq	%r9, %r12
xorq	%r9, %r13
vpxor	%xmm9, %xmm11, %xmm11
addq	0x78(%rsp), %rax
movq	%rbx, %rdi
vpsrlq	$0x2a, %xmm9, %xmm9
xorq	%r11, %r12
shrdq	$0x6, %r14, %r14
vpxor	%xmm10, %xmm11, %xmm11
xorq	%rcx, %rdi
addq	%r12, %rax
vpxor	%xmm9, %xmm11, %xmm11
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
vpaddq	%xmm7, %xmm11, %xmm7
xorq	%rbx, %r14
addq	%r13, %rax
vpaddq	0x60(%rbp), %xmm7, %xmm10
xorq	%rcx, %r15
shrdq	$0x1c, %r14, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
vmovdqa	%xmm10, 0x70(%rsp)
cmpb	$0x0, 0x87(%rbp)
jne	L_2340
shrdq	$0x17, %r13, %r13
movq	%r14, %rax
movq	%r9, %r12
shrdq	$0x5, %r14, %r14
xorq	%r8, %r13
xorq	%r10, %r12
shrdq	$0x4, %r13, %r13
xorq	%rax, %r14
andq	%r8, %r12
xorq	%r8, %r13
addq	(%rsp), %r11
movq	%rax, %r15
xorq	%r10, %r12
shrdq	$0x6, %r14, %r14
xorq	%rbx, %r15
addq	%r12, %r11
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%rax, %r14
addq	%r13, %r11
xorq	%rbx, %rdi
shrdq	$0x1c, %r14, %r14
addq	%r11, %rdx
addq	%rdi, %r11
movq	%rdx, %r13
addq	%r11, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r11
movq	%r8, %r12
shrdq	$0x5, %r14, %r14
xorq	%rdx, %r13
xorq	%r9, %r12
shrdq	$0x4, %r13, %r13
xorq	%r11, %r14
andq	%rdx, %r12
xorq	%rdx, %r13
addq	0x8(%rsp), %r10
movq	%r11, %rdi
xorq	%r9, %r12
shrdq	$0x6, %r14, %r14
xorq	%rax, %rdi
addq	%r12, %r10
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%r11, %r14
addq	%r13, %r10
xorq	%rax, %r15
shrdq	$0x1c, %r14, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r10
movq	%rdx, %r12
shrdq	$0x5, %r14, %r14
xorq	%rcx, %r13
xorq	%r8, %r12
shrdq	$0x4, %r13, %r13
xorq	%r10, %r14
andq	%rcx, %r12
xorq	%rcx, %r13
addq	0x10(%rsp), %r9
movq	%r10, %r15
xorq	%r8, %r12
shrdq	$0x6, %r14, %r14
xorq	%r11, %r15
addq	%r12, %r9
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%r10, %r14
addq	%r13, %r9
xorq	%r11, %rdi
shrdq	$0x1c, %r14, %r14
addq	%r9, %rbx
addq	%rdi, %r9
movq	%rbx, %r13
addq	%r9, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r9
movq	%rcx, %r12
shrdq	$0x5, %r14, %r14
xorq	%rbx, %r13
xorq	%rdx, %r12
shrdq	$0x4, %r13, %r13
xorq	%r9, %r14
andq	%rbx, %r12
xorq	%rbx, %r13
addq	0x18(%rsp), %r8
movq	%r9, %rdi
xorq	%rdx, %r12
shrdq	$0x6, %r14, %r14
xorq	%r10, %rdi
addq	%r12, %r8
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%r9, %r14
addq	%r13, %r8
xorq	%r10, %r15
shrdq	$0x1c, %r14, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r8
movq	%rbx, %r12
shrdq	$0x5, %r14, %r14
xorq	%rax, %r13
xorq	%rcx, %r12
shrdq	$0x4, %r13, %r13
xorq	%r8, %r14
andq	%rax, %r12
xorq	%rax, %r13
addq	0x20(%rsp), %rdx
movq	%r8, %r15
xorq	%rcx, %r12
shrdq	$0x6, %r14, %r14
xorq	%r9, %r15
addq	%r12, %rdx
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%r8, %r14
addq	%r13, %rdx
xorq	%r9, %rdi
shrdq	$0x1c, %r14, %r14
addq	%rdx, %r11
addq	%rdi, %rdx
movq	%r11, %r13
addq	%rdx, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rdx
movq	%rax, %r12
shrdq	$0x5, %r14, %r14
xorq	%r11, %r13
xorq	%rbx, %r12
shrdq	$0x4, %r13, %r13
xorq	%rdx, %r14
andq	%r11, %r12
xorq	%r11, %r13
addq	0x28(%rsp), %rcx
movq	%rdx, %rdi
xorq	%rbx, %r12
shrdq	$0x6, %r14, %r14
xorq	%r8, %rdi
addq	%r12, %rcx
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%rdx, %r14
addq	%r13, %rcx
xorq	%r8, %r15
shrdq	$0x1c, %r14, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rcx
movq	%r11, %r12
shrdq	$0x5, %r14, %r14
xorq	%r10, %r13
xorq	%rax, %r12
shrdq	$0x4, %r13, %r13
xorq	%rcx, %r14
andq	%r10, %r12
xorq	%r10, %r13
addq	0x30(%rsp), %rbx
movq	%rcx, %r15
xorq	%rax, %r12
shrdq	$0x6, %r14, %r14
xorq	%rdx, %r15
addq	%r12, %rbx
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%rcx, %r14
addq	%r13, %rbx
xorq	%rdx, %rdi
shrdq	$0x1c, %r14, %r14
addq	%rbx, %r9
addq	%rdi, %rbx
movq	%r9, %r13
addq	%rbx, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rbx
movq	%r10, %r12
shrdq	$0x5, %r14, %r14
xorq	%r9, %r13
xorq	%r11, %r12
shrdq	$0x4, %r13, %r13
xorq	%rbx, %r14
andq	%r9, %r12
xorq	%r9, %r13
addq	0x38(%rsp), %rax
movq	%rbx, %rdi
xorq	%r11, %r12
shrdq	$0x6, %r14, %r14
xorq	%rcx, %rdi
addq	%r12, %rax
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%rbx, %r14
addq	%r13, %rax
xorq	%rcx, %r15
shrdq	$0x1c, %r14, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rax
movq	%r9, %r12
shrdq	$0x5, %r14, %r14
xorq	%r8, %r13
xorq	%r10, %r12
shrdq	$0x4, %r13, %r13
xorq	%rax, %r14
andq	%r8, %r12
xorq	%r8, %r13
addq	0x40(%rsp), %r11
movq	%rax, %r15
xorq	%r10, %r12
shrdq	$0x6, %r14, %r14
xorq	%rbx, %r15
addq	%r12, %r11
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%rax, %r14
addq	%r13, %r11
xorq	%rbx, %rdi
shrdq	$0x1c, %r14, %r14
addq	%r11, %rdx
addq	%rdi, %r11
movq	%rdx, %r13
addq	%r11, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r11
movq	%r8, %r12
shrdq	$0x5, %r14, %r14
xorq	%rdx, %r13
xorq	%r9, %r12
shrdq	$0x4, %r13, %r13
xorq	%r11, %r14
andq	%rdx, %r12
xorq	%rdx, %r13
addq	0x48(%rsp), %r10
movq	%r11, %rdi
xorq	%r9, %r12
shrdq	$0x6, %r14, %r14
xorq	%rax, %rdi
addq	%r12, %r10
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%r11, %r14
addq	%r13, %r10
xorq	%rax, %r15
shrdq	$0x1c, %r14, %r14
addq	%r10, %rcx
addq	%r15, %r10
movq	%rcx, %r13
addq	%r10, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r10
movq	%rdx, %r12
shrdq	$0x5, %r14, %r14
xorq	%rcx, %r13
xorq	%r8, %r12
shrdq	$0x4, %r13, %r13
xorq	%r10, %r14
andq	%rcx, %r12
xorq	%rcx, %r13
addq	0x50(%rsp), %r9
movq	%r10, %r15
xorq	%r8, %r12
shrdq	$0x6, %r14, %r14
xorq	%r11, %r15
addq	%r12, %r9
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%r10, %r14
addq	%r13, %r9
xorq	%r11, %rdi
shrdq	$0x1c, %r14, %r14
addq	%r9, %rbx
addq	%rdi, %r9
movq	%rbx, %r13
addq	%r9, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r9
movq	%rcx, %r12
shrdq	$0x5, %r14, %r14
xorq	%rbx, %r13
xorq	%rdx, %r12
shrdq	$0x4, %r13, %r13
xorq	%r9, %r14
andq	%rbx, %r12
xorq	%rbx, %r13
addq	0x58(%rsp), %r8
movq	%r9, %rdi
xorq	%rdx, %r12
shrdq	$0x6, %r14, %r14
xorq	%r10, %rdi
addq	%r12, %r8
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%r9, %r14
addq	%r13, %r8
xorq	%r10, %r15
shrdq	$0x1c, %r14, %r14
addq	%r8, %rax
addq	%r15, %r8
movq	%rax, %r13
addq	%r8, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %r8
movq	%rbx, %r12
shrdq	$0x5, %r14, %r14
xorq	%rax, %r13
xorq	%rcx, %r12
shrdq	$0x4, %r13, %r13
xorq	%r8, %r14
andq	%rax, %r12
xorq	%rax, %r13
addq	0x60(%rsp), %rdx
movq	%r8, %r15
xorq	%rcx, %r12
shrdq	$0x6, %r14, %r14
xorq	%r9, %r15
addq	%r12, %rdx
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%r8, %r14
addq	%r13, %rdx
xorq	%r9, %rdi
shrdq	$0x1c, %r14, %r14
addq	%rdx, %r11
addq	%rdi, %rdx
movq	%r11, %r13
addq	%rdx, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rdx
movq	%rax, %r12
shrdq	$0x5, %r14, %r14
xorq	%r11, %r13
xorq	%rbx, %r12
shrdq	$0x4, %r13, %r13
xorq	%rdx, %r14
andq	%r11, %r12
xorq	%r11, %r13
addq	0x68(%rsp), %rcx
movq	%rdx, %rdi
xorq	%rbx, %r12
shrdq	$0x6, %r14, %r14
xorq	%r8, %rdi
addq	%r12, %rcx
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%rdx, %r14
addq	%r13, %rcx
xorq	%r8, %r15
shrdq	$0x1c, %r14, %r14
addq	%rcx, %r10
addq	%r15, %rcx
movq	%r10, %r13
addq	%rcx, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rcx
movq	%r11, %r12
shrdq	$0x5, %r14, %r14
xorq	%r10, %r13
xorq	%rax, %r12
shrdq	$0x4, %r13, %r13
xorq	%rcx, %r14
andq	%r10, %r12
xorq	%r10, %r13
addq	0x70(%rsp), %rbx
movq	%rcx, %r15
xorq	%rax, %r12
shrdq	$0x6, %r14, %r14
xorq	%rdx, %r15
addq	%r12, %rbx
shrdq	$0xe, %r13, %r13
andq	%r15, %rdi
xorq	%rcx, %r14
addq	%r13, %rbx
xorq	%rdx, %rdi
shrdq	$0x1c, %r14, %r14
addq	%rbx, %r9
addq	%rdi, %rbx
movq	%r9, %r13
addq	%rbx, %r14
shrdq	$0x17, %r13, %r13
movq	%r14, %rbx
movq	%r10, %r12
shrdq	$0x5, %r14, %r14
xorq	%r9, %r13
xorq	%r11, %r12
shrdq	$0x4, %r13, %r13
xorq	%rbx, %r14
andq	%r9, %r12
xorq	%r9, %r13
addq	0x78(%rsp), %rax
movq	%rbx, %rdi
xorq	%r11, %r12
shrdq	$0x6, %r14, %r14
xorq	%rcx, %rdi
addq	%r12, %rax
shrdq	$0xe, %r13, %r13
andq	%rdi, %r15
xorq	%rbx, %r14
addq	%r13, %rax
xorq	%rcx, %r15
shrdq	$0x1c, %r14, %r14
addq	%rax, %r8
addq	%r15, %rax
movq	%r8, %r13
addq	%rax, %r14
movq	0x80(%rsp), %rdi
movq	%r14, %rax
addq	(%rdi), %rax
leaq	0x80(%rsi), %rsi
addq	0x8(%rdi), %rbx
addq	0x10(%rdi), %rcx
addq	0x18(%rdi), %rdx
addq	0x20(%rdi), %r8
addq	0x28(%rdi), %r9
addq	0x30(%rdi), %r10
addq	0x38(%rdi), %r11
cmpq	0x90(%rsp), %rsi
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rcx, 0x10(%rdi)
movq	%rdx, 0x18(%rdi)
movq	%r8, 0x20(%rdi)
movq	%r9, 0x28(%rdi)
movq	%r10, 0x30(%rdi)
movq	%r11, 0x38(%rdi)
jb	L_2270
movq	0x98(%rsp), %rsi
vzeroupper
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	(%rax,%rax)
sha512_block_data_order_avx2:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x520, %rsp
shlq	$0x4, %rdx
andq	$-0x800, %rsp
leaq	(%rsi,%rdx,8), %rdx
addq	$0x480, %rsp
movq	%rdi, 0x80(%rsp)
movq	%rsi, 0x88(%rsp)
movq	%rdx, 0x90(%rsp)
movq	%rax, 0x98(%rsp)
vzeroupper
subq	$-0x80, %rsi
movq	(%rdi), %rax
movq	%rsi, %r12
movq	0x8(%rdi), %rbx
cmpq	%rdx, %rsi
movq	0x10(%rdi), %rcx
cmoveq	%rsp, %r12
movq	0x18(%rdi), %rdx
movq	0x20(%rdi), %r8
movq	0x28(%rdi), %r9
movq	0x30(%rdi), %r10
movq	0x38(%rdi), %r11
jmp	L_3400
nopl	(%rax)
L_3400:
vmovdqu	-0x80(%rsi), %xmm0
vmovdqu	-0x70(%rsi), %xmm1
vmovdqu	-0x60(%rsi), %xmm2
leaq	K512+128(%rip), %rbp
vmovdqu	-0x50(%rsi), %xmm3
vmovdqu	-0x40(%rsi), %xmm4
vmovdqu	-0x30(%rsi), %xmm5
vmovdqu	-0x20(%rsi), %xmm6
vmovdqu	-0x10(%rsi), %xmm7
vmovdqa	0x480(%rbp), %ymm10
vinserti128	$0x1, (%r12), %ymm0, %ymm0
vinserti128	$0x1, 0x10(%r12), %ymm1, %ymm1
vpshufb	%ymm10, %ymm0, %ymm0
vinserti128	$0x1, 0x20(%r12), %ymm2, %ymm2
vpshufb	%ymm10, %ymm1, %ymm1
vinserti128	$0x1, 0x30(%r12), %ymm3, %ymm3
vpshufb	%ymm10, %ymm2, %ymm2
vinserti128	$0x1, 0x40(%r12), %ymm4, %ymm4
vpshufb	%ymm10, %ymm3, %ymm3
vinserti128	$0x1, 0x50(%r12), %ymm5, %ymm5
vpshufb	%ymm10, %ymm4, %ymm4
vinserti128	$0x1, 0x60(%r12), %ymm6, %ymm6
vpshufb	%ymm10, %ymm5, %ymm5
vinserti128	$0x1, 0x70(%r12), %ymm7, %ymm7
vpaddq	-0x80(%rbp), %ymm0, %ymm8
vpshufb	%ymm10, %ymm6, %ymm6
vpaddq	-0x60(%rbp), %ymm1, %ymm9
vpshufb	%ymm10, %ymm7, %ymm7
vpaddq	-0x40(%rbp), %ymm2, %ymm10
vpaddq	-0x20(%rbp), %ymm3, %ymm11
vmovdqa	%ymm8, (%rsp)
vpaddq	(%rbp), %ymm4, %ymm8
vmovdqa	%ymm9, 0x20(%rsp)
vpaddq	0x20(%rbp), %ymm5, %ymm9
vmovdqa	%ymm10, 0x40(%rsp)
vpaddq	0x40(%rbp), %ymm6, %ymm10
vmovdqa	%ymm11, 0x60(%rsp)
movq	0x98(%rsp), %rdi
leaq	-0x80(%rsp), %rsp
movq	%rdi, -0x8(%rsp)
vpaddq	0x60(%rbp), %ymm7, %ymm11
vmovdqa	%ymm8, (%rsp)
xorq	%r14, %r14
vmovdqa	%ymm9, 0x20(%rsp)
movq	%rbx, %rdi
vmovdqa	%ymm10, 0x40(%rsp)
xorq	%rcx, %rdi
vmovdqa	%ymm11, 0x60(%rsp)
movq	%r9, %r12
addq	$0x100, %rbp
jmp	L_3520
nopl	(%rax,%rax)
L_3520:
leaq	-0x80(%rsp), %rsp
pushq	0x78(%rsp)
leaq	0x8(%rsp), %rsp
vpalignr	$0x8, %ymm0, %ymm1, %ymm8
addq	0x100(%rsp), %r11
andq	%r8, %r12
rorxq	$0x29, %r8, %r13
vpalignr	$0x8, %ymm4, %ymm5, %ymm11
rorxq	$0x12, %r8, %r15
leaq	(%rax,%r14), %rax
leaq	(%r11,%r12), %r11
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%r10, %r8, %r12
xorq	%r15, %r13
rorxq	$0xe, %r8, %r14
vpaddq	%ymm0, %ymm11, %ymm0
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%r11,%r12), %r11
xorq	%r14, %r13
movq	%rax, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %rax, %r12
leaq	(%r11,%r13), %r11
xorq	%rbx, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %rax, %r14
rorxq	$0x1c, %rax, %r13
leaq	(%rdx,%r11), %rdx
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rbx, %rdi
vpsrlq	$0x6, %ymm7, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%r11,%rdi), %r11
movq	%r8, %r12
vpsllq	$0x3, %ymm7, %ymm10
vpaddq	%ymm0, %ymm8, %ymm0
addq	0x108(%rsp), %r10
andq	%rdx, %r12
rorxq	$0x29, %rdx, %r13
vpsrlq	$0x13, %ymm7, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %rdx, %rdi
leaq	(%r11,%r14), %r11
leaq	(%r10,%r12), %r10
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%r9, %rdx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rdx, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%r10,%r12), %r10
xorq	%r14, %r13
movq	%r11, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %r11, %r12
leaq	(%r10,%r13), %r10
xorq	%rax, %rdi
vpaddq	%ymm0, %ymm11, %ymm0
rorxq	$0x22, %r11, %r14
rorxq	$0x1c, %r11, %r13
leaq	(%rcx,%r10), %rcx
vpaddq	-0x80(%rbp), %ymm0, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rax, %r15
xorq	%r13, %r14
leaq	(%r10,%r15), %r10
movq	%rdx, %r12
vmovdqa	%ymm10, (%rsp)
vpalignr	$0x8, %ymm1, %ymm2, %ymm8
addq	0x120(%rsp), %r9
andq	%rcx, %r12
rorxq	$0x29, %rcx, %r13
vpalignr	$0x8, %ymm5, %ymm6, %ymm11
rorxq	$0x12, %rcx, %r15
leaq	(%r10,%r14), %r10
leaq	(%r9,%r12), %r9
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%r8, %rcx, %r12
xorq	%r15, %r13
rorxq	$0xe, %rcx, %r14
vpaddq	%ymm1, %ymm11, %ymm1
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%r9,%r12), %r9
xorq	%r14, %r13
movq	%r10, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %r10, %r12
leaq	(%r9,%r13), %r9
xorq	%r11, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %r10, %r14
rorxq	$0x1c, %r10, %r13
leaq	(%rbx,%r9), %rbx
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r11, %rdi
vpsrlq	$0x6, %ymm0, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%r9,%rdi), %r9
movq	%rcx, %r12
vpsllq	$0x3, %ymm0, %ymm10
vpaddq	%ymm1, %ymm8, %ymm1
addq	0x128(%rsp), %r8
andq	%rbx, %r12
rorxq	$0x29, %rbx, %r13
vpsrlq	$0x13, %ymm0, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %rbx, %rdi
leaq	(%r9,%r14), %r9
leaq	(%r8,%r12), %r8
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%rdx, %rbx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rbx, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%r8,%r12), %r8
xorq	%r14, %r13
movq	%r9, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %r9, %r12
leaq	(%r8,%r13), %r8
xorq	%r10, %rdi
vpaddq	%ymm1, %ymm11, %ymm1
rorxq	$0x22, %r9, %r14
rorxq	$0x1c, %r9, %r13
leaq	(%rax,%r8), %rax
vpaddq	-0x60(%rbp), %ymm1, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r10, %r15
xorq	%r13, %r14
leaq	(%r8,%r15), %r8
movq	%rbx, %r12
vmovdqa	%ymm10, 0x20(%rsp)
vpalignr	$0x8, %ymm2, %ymm3, %ymm8
addq	0x140(%rsp), %rdx
andq	%rax, %r12
rorxq	$0x29, %rax, %r13
vpalignr	$0x8, %ymm6, %ymm7, %ymm11
rorxq	$0x12, %rax, %r15
leaq	(%r8,%r14), %r8
leaq	(%rdx,%r12), %rdx
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%rcx, %rax, %r12
xorq	%r15, %r13
rorxq	$0xe, %rax, %r14
vpaddq	%ymm2, %ymm11, %ymm2
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%rdx,%r12), %rdx
xorq	%r14, %r13
movq	%r8, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %r8, %r12
leaq	(%rdx,%r13), %rdx
xorq	%r9, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %r8, %r14
rorxq	$0x1c, %r8, %r13
leaq	(%r11,%rdx), %r11
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r9, %rdi
vpsrlq	$0x6, %ymm1, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%rdx,%rdi), %rdx
movq	%rax, %r12
vpsllq	$0x3, %ymm1, %ymm10
vpaddq	%ymm2, %ymm8, %ymm2
addq	0x148(%rsp), %rcx
andq	%r11, %r12
rorxq	$0x29, %r11, %r13
vpsrlq	$0x13, %ymm1, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %r11, %rdi
leaq	(%rdx,%r14), %rdx
leaq	(%rcx,%r12), %rcx
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%rbx, %r11, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r11, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%rcx,%r12), %rcx
xorq	%r14, %r13
movq	%rdx, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %rdx, %r12
leaq	(%rcx,%r13), %rcx
xorq	%r8, %rdi
vpaddq	%ymm2, %ymm11, %ymm2
rorxq	$0x22, %rdx, %r14
rorxq	$0x1c, %rdx, %r13
leaq	(%r10,%rcx), %r10
vpaddq	-0x40(%rbp), %ymm2, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r8, %r15
xorq	%r13, %r14
leaq	(%rcx,%r15), %rcx
movq	%r11, %r12
vmovdqa	%ymm10, 0x40(%rsp)
vpalignr	$0x8, %ymm3, %ymm4, %ymm8
addq	0x160(%rsp), %rbx
andq	%r10, %r12
rorxq	$0x29, %r10, %r13
vpalignr	$0x8, %ymm7, %ymm0, %ymm11
rorxq	$0x12, %r10, %r15
leaq	(%rcx,%r14), %rcx
leaq	(%rbx,%r12), %rbx
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%rax, %r10, %r12
xorq	%r15, %r13
rorxq	$0xe, %r10, %r14
vpaddq	%ymm3, %ymm11, %ymm3
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%rbx,%r12), %rbx
xorq	%r14, %r13
movq	%rcx, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %rcx, %r12
leaq	(%rbx,%r13), %rbx
xorq	%rdx, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %rcx, %r14
rorxq	$0x1c, %rcx, %r13
leaq	(%r9,%rbx), %r9
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rdx, %rdi
vpsrlq	$0x6, %ymm2, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%rbx,%rdi), %rbx
movq	%r10, %r12
vpsllq	$0x3, %ymm2, %ymm10
vpaddq	%ymm3, %ymm8, %ymm3
addq	0x168(%rsp), %rax
andq	%r9, %r12
rorxq	$0x29, %r9, %r13
vpsrlq	$0x13, %ymm2, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %r9, %rdi
leaq	(%rbx,%r14), %rbx
leaq	(%rax,%r12), %rax
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%r11, %r9, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r9, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%rax,%r12), %rax
xorq	%r14, %r13
movq	%rbx, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %rbx, %r12
leaq	(%rax,%r13), %rax
xorq	%rcx, %rdi
vpaddq	%ymm3, %ymm11, %ymm3
rorxq	$0x22, %rbx, %r14
rorxq	$0x1c, %rbx, %r13
leaq	(%r8,%rax), %r8
vpaddq	-0x20(%rbp), %ymm3, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rcx, %r15
xorq	%r13, %r14
leaq	(%rax,%r15), %rax
movq	%r9, %r12
vmovdqa	%ymm10, 0x60(%rsp)
leaq	-0x80(%rsp), %rsp
pushq	0x78(%rsp)
leaq	0x8(%rsp), %rsp
vpalignr	$0x8, %ymm4, %ymm5, %ymm8
addq	0x100(%rsp), %r11
andq	%r8, %r12
rorxq	$0x29, %r8, %r13
vpalignr	$0x8, %ymm0, %ymm1, %ymm11
rorxq	$0x12, %r8, %r15
leaq	(%rax,%r14), %rax
leaq	(%r11,%r12), %r11
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%r10, %r8, %r12
xorq	%r15, %r13
rorxq	$0xe, %r8, %r14
vpaddq	%ymm4, %ymm11, %ymm4
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%r11,%r12), %r11
xorq	%r14, %r13
movq	%rax, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %rax, %r12
leaq	(%r11,%r13), %r11
xorq	%rbx, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %rax, %r14
rorxq	$0x1c, %rax, %r13
leaq	(%rdx,%r11), %rdx
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rbx, %rdi
vpsrlq	$0x6, %ymm3, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%r11,%rdi), %r11
movq	%r8, %r12
vpsllq	$0x3, %ymm3, %ymm10
vpaddq	%ymm4, %ymm8, %ymm4
addq	0x108(%rsp), %r10
andq	%rdx, %r12
rorxq	$0x29, %rdx, %r13
vpsrlq	$0x13, %ymm3, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %rdx, %rdi
leaq	(%r11,%r14), %r11
leaq	(%r10,%r12), %r10
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%r9, %rdx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rdx, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%r10,%r12), %r10
xorq	%r14, %r13
movq	%r11, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %r11, %r12
leaq	(%r10,%r13), %r10
xorq	%rax, %rdi
vpaddq	%ymm4, %ymm11, %ymm4
rorxq	$0x22, %r11, %r14
rorxq	$0x1c, %r11, %r13
leaq	(%rcx,%r10), %rcx
vpaddq	(%rbp), %ymm4, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rax, %r15
xorq	%r13, %r14
leaq	(%r10,%r15), %r10
movq	%rdx, %r12
vmovdqa	%ymm10, (%rsp)
vpalignr	$0x8, %ymm5, %ymm6, %ymm8
addq	0x120(%rsp), %r9
andq	%rcx, %r12
rorxq	$0x29, %rcx, %r13
vpalignr	$0x8, %ymm1, %ymm2, %ymm11
rorxq	$0x12, %rcx, %r15
leaq	(%r10,%r14), %r10
leaq	(%r9,%r12), %r9
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%r8, %rcx, %r12
xorq	%r15, %r13
rorxq	$0xe, %rcx, %r14
vpaddq	%ymm5, %ymm11, %ymm5
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%r9,%r12), %r9
xorq	%r14, %r13
movq	%r10, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %r10, %r12
leaq	(%r9,%r13), %r9
xorq	%r11, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %r10, %r14
rorxq	$0x1c, %r10, %r13
leaq	(%rbx,%r9), %rbx
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r11, %rdi
vpsrlq	$0x6, %ymm4, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%r9,%rdi), %r9
movq	%rcx, %r12
vpsllq	$0x3, %ymm4, %ymm10
vpaddq	%ymm5, %ymm8, %ymm5
addq	0x128(%rsp), %r8
andq	%rbx, %r12
rorxq	$0x29, %rbx, %r13
vpsrlq	$0x13, %ymm4, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %rbx, %rdi
leaq	(%r9,%r14), %r9
leaq	(%r8,%r12), %r8
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%rdx, %rbx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rbx, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%r8,%r12), %r8
xorq	%r14, %r13
movq	%r9, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %r9, %r12
leaq	(%r8,%r13), %r8
xorq	%r10, %rdi
vpaddq	%ymm5, %ymm11, %ymm5
rorxq	$0x22, %r9, %r14
rorxq	$0x1c, %r9, %r13
leaq	(%rax,%r8), %rax
vpaddq	0x20(%rbp), %ymm5, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r10, %r15
xorq	%r13, %r14
leaq	(%r8,%r15), %r8
movq	%rbx, %r12
vmovdqa	%ymm10, 0x20(%rsp)
vpalignr	$0x8, %ymm6, %ymm7, %ymm8
addq	0x140(%rsp), %rdx
andq	%rax, %r12
rorxq	$0x29, %rax, %r13
vpalignr	$0x8, %ymm2, %ymm3, %ymm11
rorxq	$0x12, %rax, %r15
leaq	(%r8,%r14), %r8
leaq	(%rdx,%r12), %rdx
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%rcx, %rax, %r12
xorq	%r15, %r13
rorxq	$0xe, %rax, %r14
vpaddq	%ymm6, %ymm11, %ymm6
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%rdx,%r12), %rdx
xorq	%r14, %r13
movq	%r8, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %r8, %r12
leaq	(%rdx,%r13), %rdx
xorq	%r9, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %r8, %r14
rorxq	$0x1c, %r8, %r13
leaq	(%r11,%rdx), %r11
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r9, %rdi
vpsrlq	$0x6, %ymm5, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%rdx,%rdi), %rdx
movq	%rax, %r12
vpsllq	$0x3, %ymm5, %ymm10
vpaddq	%ymm6, %ymm8, %ymm6
addq	0x148(%rsp), %rcx
andq	%r11, %r12
rorxq	$0x29, %r11, %r13
vpsrlq	$0x13, %ymm5, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %r11, %rdi
leaq	(%rdx,%r14), %rdx
leaq	(%rcx,%r12), %rcx
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%rbx, %r11, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r11, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%rcx,%r12), %rcx
xorq	%r14, %r13
movq	%rdx, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %rdx, %r12
leaq	(%rcx,%r13), %rcx
xorq	%r8, %rdi
vpaddq	%ymm6, %ymm11, %ymm6
rorxq	$0x22, %rdx, %r14
rorxq	$0x1c, %rdx, %r13
leaq	(%r10,%rcx), %r10
vpaddq	0x40(%rbp), %ymm6, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r8, %r15
xorq	%r13, %r14
leaq	(%rcx,%r15), %rcx
movq	%r11, %r12
vmovdqa	%ymm10, 0x40(%rsp)
vpalignr	$0x8, %ymm7, %ymm0, %ymm8
addq	0x160(%rsp), %rbx
andq	%r10, %r12
rorxq	$0x29, %r10, %r13
vpalignr	$0x8, %ymm3, %ymm4, %ymm11
rorxq	$0x12, %r10, %r15
leaq	(%rcx,%r14), %rcx
leaq	(%rbx,%r12), %rbx
vpsrlq	$0x1, %ymm8, %ymm10
andnq	%rax, %r10, %r12
xorq	%r15, %r13
rorxq	$0xe, %r10, %r14
vpaddq	%ymm7, %ymm11, %ymm7
vpsrlq	$0x7, %ymm8, %ymm11
leaq	(%rbx,%r12), %rbx
xorq	%r14, %r13
movq	%rcx, %r15
vpsllq	$0x38, %ymm8, %ymm9
vpxor	%ymm10, %ymm11, %ymm8
rorxq	$0x27, %rcx, %r12
leaq	(%rbx,%r13), %rbx
xorq	%rdx, %r15
vpsrlq	$0x7, %ymm10, %ymm10
vpxor	%ymm9, %ymm8, %ymm8
rorxq	$0x22, %rcx, %r14
rorxq	$0x1c, %rcx, %r13
leaq	(%r9,%rbx), %r9
vpsllq	$0x7, %ymm9, %ymm9
vpxor	%ymm10, %ymm8, %ymm8
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rdx, %rdi
vpsrlq	$0x6, %ymm6, %ymm11
vpxor	%ymm9, %ymm8, %ymm8
xorq	%r13, %r14
leaq	(%rbx,%rdi), %rbx
movq	%r10, %r12
vpsllq	$0x3, %ymm6, %ymm10
vpaddq	%ymm7, %ymm8, %ymm7
addq	0x168(%rsp), %rax
andq	%r9, %r12
rorxq	$0x29, %r9, %r13
vpsrlq	$0x13, %ymm6, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
rorxq	$0x12, %r9, %rdi
leaq	(%rbx,%r14), %rbx
leaq	(%rax,%r12), %rax
vpsllq	$0x2a, %ymm10, %ymm10
vpxor	%ymm9, %ymm11, %ymm11
andnq	%r11, %r9, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r9, %r14
vpsrlq	$0x2a, %ymm9, %ymm9
vpxor	%ymm10, %ymm11, %ymm11
leaq	(%rax,%r12), %rax
xorq	%r14, %r13
movq	%rbx, %rdi
vpxor	%ymm9, %ymm11, %ymm11
rorxq	$0x27, %rbx, %r12
leaq	(%rax,%r13), %rax
xorq	%rcx, %rdi
vpaddq	%ymm7, %ymm11, %ymm7
rorxq	$0x22, %rbx, %r14
rorxq	$0x1c, %rbx, %r13
leaq	(%r8,%rax), %r8
vpaddq	0x60(%rbp), %ymm7, %ymm10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rcx, %r15
xorq	%r13, %r14
leaq	(%rax,%r15), %rax
movq	%r9, %r12
vmovdqa	%ymm10, 0x60(%rsp)
leaq	0x100(%rbp), %rbp
cmpb	$0x0, -0x79(%rbp)
jne	L_3520
addq	0x80(%rsp), %r11
andq	%r8, %r12
rorxq	$0x29, %r8, %r13
rorxq	$0x12, %r8, %r15
leaq	(%rax,%r14), %rax
leaq	(%r11,%r12), %r11
andnq	%r10, %r8, %r12
xorq	%r15, %r13
rorxq	$0xe, %r8, %r14
leaq	(%r11,%r12), %r11
xorq	%r14, %r13
movq	%rax, %r15
rorxq	$0x27, %rax, %r12
leaq	(%r11,%r13), %r11
xorq	%rbx, %r15
rorxq	$0x22, %rax, %r14
rorxq	$0x1c, %rax, %r13
leaq	(%rdx,%r11), %rdx
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rbx, %rdi
xorq	%r13, %r14
leaq	(%r11,%rdi), %r11
movq	%r8, %r12
addq	0x88(%rsp), %r10
andq	%rdx, %r12
rorxq	$0x29, %rdx, %r13
rorxq	$0x12, %rdx, %rdi
leaq	(%r11,%r14), %r11
leaq	(%r10,%r12), %r10
andnq	%r9, %rdx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rdx, %r14
leaq	(%r10,%r12), %r10
xorq	%r14, %r13
movq	%r11, %rdi
rorxq	$0x27, %r11, %r12
leaq	(%r10,%r13), %r10
xorq	%rax, %rdi
rorxq	$0x22, %r11, %r14
rorxq	$0x1c, %r11, %r13
leaq	(%rcx,%r10), %rcx
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rax, %r15
xorq	%r13, %r14
leaq	(%r10,%r15), %r10
movq	%rdx, %r12
addq	0xa0(%rsp), %r9
andq	%rcx, %r12
rorxq	$0x29, %rcx, %r13
rorxq	$0x12, %rcx, %r15
leaq	(%r10,%r14), %r10
leaq	(%r9,%r12), %r9
andnq	%r8, %rcx, %r12
xorq	%r15, %r13
rorxq	$0xe, %rcx, %r14
leaq	(%r9,%r12), %r9
xorq	%r14, %r13
movq	%r10, %r15
rorxq	$0x27, %r10, %r12
leaq	(%r9,%r13), %r9
xorq	%r11, %r15
rorxq	$0x22, %r10, %r14
rorxq	$0x1c, %r10, %r13
leaq	(%rbx,%r9), %rbx
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r11, %rdi
xorq	%r13, %r14
leaq	(%r9,%rdi), %r9
movq	%rcx, %r12
addq	0xa8(%rsp), %r8
andq	%rbx, %r12
rorxq	$0x29, %rbx, %r13
rorxq	$0x12, %rbx, %rdi
leaq	(%r9,%r14), %r9
leaq	(%r8,%r12), %r8
andnq	%rdx, %rbx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rbx, %r14
leaq	(%r8,%r12), %r8
xorq	%r14, %r13
movq	%r9, %rdi
rorxq	$0x27, %r9, %r12
leaq	(%r8,%r13), %r8
xorq	%r10, %rdi
rorxq	$0x22, %r9, %r14
rorxq	$0x1c, %r9, %r13
leaq	(%rax,%r8), %rax
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r10, %r15
xorq	%r13, %r14
leaq	(%r8,%r15), %r8
movq	%rbx, %r12
addq	0xc0(%rsp), %rdx
andq	%rax, %r12
rorxq	$0x29, %rax, %r13
rorxq	$0x12, %rax, %r15
leaq	(%r8,%r14), %r8
leaq	(%rdx,%r12), %rdx
andnq	%rcx, %rax, %r12
xorq	%r15, %r13
rorxq	$0xe, %rax, %r14
leaq	(%rdx,%r12), %rdx
xorq	%r14, %r13
movq	%r8, %r15
rorxq	$0x27, %r8, %r12
leaq	(%rdx,%r13), %rdx
xorq	%r9, %r15
rorxq	$0x22, %r8, %r14
rorxq	$0x1c, %r8, %r13
leaq	(%r11,%rdx), %r11
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r9, %rdi
xorq	%r13, %r14
leaq	(%rdx,%rdi), %rdx
movq	%rax, %r12
addq	0xc8(%rsp), %rcx
andq	%r11, %r12
rorxq	$0x29, %r11, %r13
rorxq	$0x12, %r11, %rdi
leaq	(%rdx,%r14), %rdx
leaq	(%rcx,%r12), %rcx
andnq	%rbx, %r11, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r11, %r14
leaq	(%rcx,%r12), %rcx
xorq	%r14, %r13
movq	%rdx, %rdi
rorxq	$0x27, %rdx, %r12
leaq	(%rcx,%r13), %rcx
xorq	%r8, %rdi
rorxq	$0x22, %rdx, %r14
rorxq	$0x1c, %rdx, %r13
leaq	(%r10,%rcx), %r10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r8, %r15
xorq	%r13, %r14
leaq	(%rcx,%r15), %rcx
movq	%r11, %r12
addq	0xe0(%rsp), %rbx
andq	%r10, %r12
rorxq	$0x29, %r10, %r13
rorxq	$0x12, %r10, %r15
leaq	(%rcx,%r14), %rcx
leaq	(%rbx,%r12), %rbx
andnq	%rax, %r10, %r12
xorq	%r15, %r13
rorxq	$0xe, %r10, %r14
leaq	(%rbx,%r12), %rbx
xorq	%r14, %r13
movq	%rcx, %r15
rorxq	$0x27, %rcx, %r12
leaq	(%rbx,%r13), %rbx
xorq	%rdx, %r15
rorxq	$0x22, %rcx, %r14
rorxq	$0x1c, %rcx, %r13
leaq	(%r9,%rbx), %r9
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rdx, %rdi
xorq	%r13, %r14
leaq	(%rbx,%rdi), %rbx
movq	%r10, %r12
addq	0xe8(%rsp), %rax
andq	%r9, %r12
rorxq	$0x29, %r9, %r13
rorxq	$0x12, %r9, %rdi
leaq	(%rbx,%r14), %rbx
leaq	(%rax,%r12), %rax
andnq	%r11, %r9, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r9, %r14
leaq	(%rax,%r12), %rax
xorq	%r14, %r13
movq	%rbx, %rdi
rorxq	$0x27, %rbx, %r12
leaq	(%rax,%r13), %rax
xorq	%rcx, %rdi
rorxq	$0x22, %rbx, %r14
rorxq	$0x1c, %rbx, %r13
leaq	(%r8,%rax), %r8
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rcx, %r15
xorq	%r13, %r14
leaq	(%rax,%r15), %rax
movq	%r9, %r12
addq	(%rsp), %r11
andq	%r8, %r12
rorxq	$0x29, %r8, %r13
rorxq	$0x12, %r8, %r15
leaq	(%rax,%r14), %rax
leaq	(%r11,%r12), %r11
andnq	%r10, %r8, %r12
xorq	%r15, %r13
rorxq	$0xe, %r8, %r14
leaq	(%r11,%r12), %r11
xorq	%r14, %r13
movq	%rax, %r15
rorxq	$0x27, %rax, %r12
leaq	(%r11,%r13), %r11
xorq	%rbx, %r15
rorxq	$0x22, %rax, %r14
rorxq	$0x1c, %rax, %r13
leaq	(%rdx,%r11), %rdx
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rbx, %rdi
xorq	%r13, %r14
leaq	(%r11,%rdi), %r11
movq	%r8, %r12
addq	0x8(%rsp), %r10
andq	%rdx, %r12
rorxq	$0x29, %rdx, %r13
rorxq	$0x12, %rdx, %rdi
leaq	(%r11,%r14), %r11
leaq	(%r10,%r12), %r10
andnq	%r9, %rdx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rdx, %r14
leaq	(%r10,%r12), %r10
xorq	%r14, %r13
movq	%r11, %rdi
rorxq	$0x27, %r11, %r12
leaq	(%r10,%r13), %r10
xorq	%rax, %rdi
rorxq	$0x22, %r11, %r14
rorxq	$0x1c, %r11, %r13
leaq	(%rcx,%r10), %rcx
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rax, %r15
xorq	%r13, %r14
leaq	(%r10,%r15), %r10
movq	%rdx, %r12
addq	0x20(%rsp), %r9
andq	%rcx, %r12
rorxq	$0x29, %rcx, %r13
rorxq	$0x12, %rcx, %r15
leaq	(%r10,%r14), %r10
leaq	(%r9,%r12), %r9
andnq	%r8, %rcx, %r12
xorq	%r15, %r13
rorxq	$0xe, %rcx, %r14
leaq	(%r9,%r12), %r9
xorq	%r14, %r13
movq	%r10, %r15
rorxq	$0x27, %r10, %r12
leaq	(%r9,%r13), %r9
xorq	%r11, %r15
rorxq	$0x22, %r10, %r14
rorxq	$0x1c, %r10, %r13
leaq	(%rbx,%r9), %rbx
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r11, %rdi
xorq	%r13, %r14
leaq	(%r9,%rdi), %r9
movq	%rcx, %r12
addq	0x28(%rsp), %r8
andq	%rbx, %r12
rorxq	$0x29, %rbx, %r13
rorxq	$0x12, %rbx, %rdi
leaq	(%r9,%r14), %r9
leaq	(%r8,%r12), %r8
andnq	%rdx, %rbx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rbx, %r14
leaq	(%r8,%r12), %r8
xorq	%r14, %r13
movq	%r9, %rdi
rorxq	$0x27, %r9, %r12
leaq	(%r8,%r13), %r8
xorq	%r10, %rdi
rorxq	$0x22, %r9, %r14
rorxq	$0x1c, %r9, %r13
leaq	(%rax,%r8), %rax
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r10, %r15
xorq	%r13, %r14
leaq	(%r8,%r15), %r8
movq	%rbx, %r12
addq	0x40(%rsp), %rdx
andq	%rax, %r12
rorxq	$0x29, %rax, %r13
rorxq	$0x12, %rax, %r15
leaq	(%r8,%r14), %r8
leaq	(%rdx,%r12), %rdx
andnq	%rcx, %rax, %r12
xorq	%r15, %r13
rorxq	$0xe, %rax, %r14
leaq	(%rdx,%r12), %rdx
xorq	%r14, %r13
movq	%r8, %r15
rorxq	$0x27, %r8, %r12
leaq	(%rdx,%r13), %rdx
xorq	%r9, %r15
rorxq	$0x22, %r8, %r14
rorxq	$0x1c, %r8, %r13
leaq	(%r11,%rdx), %r11
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r9, %rdi
xorq	%r13, %r14
leaq	(%rdx,%rdi), %rdx
movq	%rax, %r12
addq	0x48(%rsp), %rcx
andq	%r11, %r12
rorxq	$0x29, %r11, %r13
rorxq	$0x12, %r11, %rdi
leaq	(%rdx,%r14), %rdx
leaq	(%rcx,%r12), %rcx
andnq	%rbx, %r11, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r11, %r14
leaq	(%rcx,%r12), %rcx
xorq	%r14, %r13
movq	%rdx, %rdi
rorxq	$0x27, %rdx, %r12
leaq	(%rcx,%r13), %rcx
xorq	%r8, %rdi
rorxq	$0x22, %rdx, %r14
rorxq	$0x1c, %rdx, %r13
leaq	(%r10,%rcx), %r10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r8, %r15
xorq	%r13, %r14
leaq	(%rcx,%r15), %rcx
movq	%r11, %r12
addq	0x60(%rsp), %rbx
andq	%r10, %r12
rorxq	$0x29, %r10, %r13
rorxq	$0x12, %r10, %r15
leaq	(%rcx,%r14), %rcx
leaq	(%rbx,%r12), %rbx
andnq	%rax, %r10, %r12
xorq	%r15, %r13
rorxq	$0xe, %r10, %r14
leaq	(%rbx,%r12), %rbx
xorq	%r14, %r13
movq	%rcx, %r15
rorxq	$0x27, %rcx, %r12
leaq	(%rbx,%r13), %rbx
xorq	%rdx, %r15
rorxq	$0x22, %rcx, %r14
rorxq	$0x1c, %rcx, %r13
leaq	(%r9,%rbx), %r9
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rdx, %rdi
xorq	%r13, %r14
leaq	(%rbx,%rdi), %rbx
movq	%r10, %r12
addq	0x68(%rsp), %rax
andq	%r9, %r12
rorxq	$0x29, %r9, %r13
rorxq	$0x12, %r9, %rdi
leaq	(%rbx,%r14), %rbx
leaq	(%rax,%r12), %rax
andnq	%r11, %r9, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r9, %r14
leaq	(%rax,%r12), %rax
xorq	%r14, %r13
movq	%rbx, %rdi
rorxq	$0x27, %rbx, %r12
leaq	(%rax,%r13), %rax
xorq	%rcx, %rdi
rorxq	$0x22, %rbx, %r14
rorxq	$0x1c, %rbx, %r13
leaq	(%r8,%rax), %r8
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rcx, %r15
xorq	%r13, %r14
leaq	(%rax,%r15), %rax
movq	%r9, %r12
movq	0x500(%rsp), %rdi
addq	%r14, %rax
leaq	0x480(%rsp), %rbp
addq	(%rdi), %rax
addq	0x8(%rdi), %rbx
addq	0x10(%rdi), %rcx
addq	0x18(%rdi), %rdx
addq	0x20(%rdi), %r8
addq	0x28(%rdi), %r9
addq	0x30(%rdi), %r10
addq	0x38(%rdi), %r11
movq	%rax, (%rdi)
movq	%rbx, 0x8(%rdi)
movq	%rcx, 0x10(%rdi)
movq	%rdx, 0x18(%rdi)
movq	%r8, 0x20(%rdi)
movq	%r9, 0x28(%rdi)
movq	%r10, 0x30(%rdi)
movq	%r11, 0x38(%rdi)
cmpq	0x90(%rbp), %rsi
je	L_4a36
xorq	%r14, %r14
movq	%rbx, %rdi
xorq	%rcx, %rdi
movq	%r9, %r12
jmp	L_46a0
nop
L_46a0:
addq	0x10(%rbp), %r11
andq	%r8, %r12
rorxq	$0x29, %r8, %r13
rorxq	$0x12, %r8, %r15
leaq	(%rax,%r14), %rax
leaq	(%r11,%r12), %r11
andnq	%r10, %r8, %r12
xorq	%r15, %r13
rorxq	$0xe, %r8, %r14
leaq	(%r11,%r12), %r11
xorq	%r14, %r13
movq	%rax, %r15
rorxq	$0x27, %rax, %r12
leaq	(%r11,%r13), %r11
xorq	%rbx, %r15
rorxq	$0x22, %rax, %r14
rorxq	$0x1c, %rax, %r13
leaq	(%rdx,%r11), %rdx
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rbx, %rdi
xorq	%r13, %r14
leaq	(%r11,%rdi), %r11
movq	%r8, %r12
addq	0x18(%rbp), %r10
andq	%rdx, %r12
rorxq	$0x29, %rdx, %r13
rorxq	$0x12, %rdx, %rdi
leaq	(%r11,%r14), %r11
leaq	(%r10,%r12), %r10
andnq	%r9, %rdx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rdx, %r14
leaq	(%r10,%r12), %r10
xorq	%r14, %r13
movq	%r11, %rdi
rorxq	$0x27, %r11, %r12
leaq	(%r10,%r13), %r10
xorq	%rax, %rdi
rorxq	$0x22, %r11, %r14
rorxq	$0x1c, %r11, %r13
leaq	(%rcx,%r10), %rcx
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rax, %r15
xorq	%r13, %r14
leaq	(%r10,%r15), %r10
movq	%rdx, %r12
addq	0x30(%rbp), %r9
andq	%rcx, %r12
rorxq	$0x29, %rcx, %r13
rorxq	$0x12, %rcx, %r15
leaq	(%r10,%r14), %r10
leaq	(%r9,%r12), %r9
andnq	%r8, %rcx, %r12
xorq	%r15, %r13
rorxq	$0xe, %rcx, %r14
leaq	(%r9,%r12), %r9
xorq	%r14, %r13
movq	%r10, %r15
rorxq	$0x27, %r10, %r12
leaq	(%r9,%r13), %r9
xorq	%r11, %r15
rorxq	$0x22, %r10, %r14
rorxq	$0x1c, %r10, %r13
leaq	(%rbx,%r9), %rbx
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r11, %rdi
xorq	%r13, %r14
leaq	(%r9,%rdi), %r9
movq	%rcx, %r12
addq	0x38(%rbp), %r8
andq	%rbx, %r12
rorxq	$0x29, %rbx, %r13
rorxq	$0x12, %rbx, %rdi
leaq	(%r9,%r14), %r9
leaq	(%r8,%r12), %r8
andnq	%rdx, %rbx, %r12
xorq	%rdi, %r13
rorxq	$0xe, %rbx, %r14
leaq	(%r8,%r12), %r8
xorq	%r14, %r13
movq	%r9, %rdi
rorxq	$0x27, %r9, %r12
leaq	(%r8,%r13), %r8
xorq	%r10, %rdi
rorxq	$0x22, %r9, %r14
rorxq	$0x1c, %r9, %r13
leaq	(%rax,%r8), %rax
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r10, %r15
xorq	%r13, %r14
leaq	(%r8,%r15), %r8
movq	%rbx, %r12
addq	0x50(%rbp), %rdx
andq	%rax, %r12
rorxq	$0x29, %rax, %r13
rorxq	$0x12, %rax, %r15
leaq	(%r8,%r14), %r8
leaq	(%rdx,%r12), %rdx
andnq	%rcx, %rax, %r12
xorq	%r15, %r13
rorxq	$0xe, %rax, %r14
leaq	(%rdx,%r12), %rdx
xorq	%r14, %r13
movq	%r8, %r15
rorxq	$0x27, %r8, %r12
leaq	(%rdx,%r13), %rdx
xorq	%r9, %r15
rorxq	$0x22, %r8, %r14
rorxq	$0x1c, %r8, %r13
leaq	(%r11,%rdx), %r11
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%r9, %rdi
xorq	%r13, %r14
leaq	(%rdx,%rdi), %rdx
movq	%rax, %r12
addq	0x58(%rbp), %rcx
andq	%r11, %r12
rorxq	$0x29, %r11, %r13
rorxq	$0x12, %r11, %rdi
leaq	(%rdx,%r14), %rdx
leaq	(%rcx,%r12), %rcx
andnq	%rbx, %r11, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r11, %r14
leaq	(%rcx,%r12), %rcx
xorq	%r14, %r13
movq	%rdx, %rdi
rorxq	$0x27, %rdx, %r12
leaq	(%rcx,%r13), %rcx
xorq	%r8, %rdi
rorxq	$0x22, %rdx, %r14
rorxq	$0x1c, %rdx, %r13
leaq	(%r10,%rcx), %r10
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%r8, %r15
xorq	%r13, %r14
leaq	(%rcx,%r15), %rcx
movq	%r11, %r12
addq	0x70(%rbp), %rbx
andq	%r10, %r12
rorxq	$0x29, %r10, %r13
rorxq	$0x12, %r10, %r15
leaq	(%rcx,%r14), %rcx
leaq	(%rbx,%r12), %rbx
andnq	%rax, %r10, %r12
xorq	%r15, %r13
rorxq	$0xe, %r10, %r14
leaq	(%rbx,%r12), %rbx
xorq	%r14, %r13
movq	%rcx, %r15
rorxq	$0x27, %rcx, %r12
leaq	(%rbx,%r13), %rbx
xorq	%rdx, %r15
rorxq	$0x22, %rcx, %r14
rorxq	$0x1c, %rcx, %r13
leaq	(%r9,%rbx), %r9
andq	%r15, %rdi
xorq	%r12, %r14
xorq	%rdx, %rdi
xorq	%r13, %r14
leaq	(%rbx,%rdi), %rbx
movq	%r10, %r12
addq	0x78(%rbp), %rax
andq	%r9, %r12
rorxq	$0x29, %r9, %r13
rorxq	$0x12, %r9, %rdi
leaq	(%rbx,%r14), %rbx
leaq	(%rax,%r12), %rax
andnq	%r11, %r9, %r12
xorq	%rdi, %r13
rorxq	$0xe, %r9, %r14
leaq	(%rax,%r12), %rax
xorq	%r14, %r13
movq	%rbx, %rdi
rorxq	$0x27, %rbx, %r12
leaq	(%rax,%r13), %rax
xorq	%rcx, %rdi
rorxq	$0x22, %rbx, %r14
rorxq	$0x1c, %rbx, %r13
leaq	(%r8,%rax), %r8
andq	%rdi, %r15
xorq	%r12, %r14
xorq	%rcx, %r15
xorq	%r13, %r14
leaq	(%rax,%r15), %rax
movq	%r9, %r12
leaq	-0x80(%rbp), %rbp
cmpq	%rsp, %rbp
jae	L_46a0
movq	0x500(%rsp), %rdi
addq	%r14, %rax
leaq	0x480(%rsp), %rsp
addq	(%rdi), %rax
addq	0x8(%rdi), %rbx
addq	0x10(%rdi), %rcx
addq	0x18(%rdi), %rdx
addq	0x20(%rdi), %r8
addq	0x28(%rdi), %r9
leaq	0x100(%rsi), %rsi
addq	0x30(%rdi), %r10
movq	%rsi, %r12
addq	0x38(%rdi), %r11
cmpq	0x90(%rsp), %rsi
movq	%rax, (%rdi)
cmoveq	%rsp, %r12
movq	%rbx, 0x8(%rdi)
movq	%rcx, 0x10(%rdi)
movq	%rdx, 0x18(%rdi)
movq	%r8, 0x20(%rdi)
movq	%r9, 0x28(%rdi)
movq	%r10, 0x30(%rdi)
movq	%r11, 0x38(%rdi)
jbe	L_3400
leaq	(%rsp), %rbp
L_4a36:
movq	0x98(%rbp), %rsi
vzeroupper
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
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
sha512_block_data_order_sha512ext:
endbr64
L_4a84:
orq	%rdx, %rdx
je	L_4f16
vbroadcasti128	K512_single-128(%rip), %ymm15
vmovdqu	(%rdi), %ymm0
vmovdqu	0x20(%rdi), %ymm1
vperm2i128	$0x20, %ymm1, %ymm0, %ymm2
vperm2i128	$0x31, %ymm1, %ymm0, %ymm3
vpermq	$0x1b, %ymm2, %ymm13
vpermq	$0x1b, %ymm3, %ymm14
leaq	K512_single(%rip), %r9
nop
L_4ac0:
vmovdqa	%ymm13, %ymm11
vmovdqa	%ymm14, %ymm12
vmovdqu	(%rsi), %ymm0
vpshufb	%ymm15, %ymm0, %ymm3
vpaddq	(%r9), %ymm3, %ymm0
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vmovdqu	0x20(%rsi), %ymm0
vpshufb	%ymm15, %ymm0, %ymm4
vpaddq	0x20(%r9), %ymm4, %ymm0
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm4, %ymm3
vmovdqu	0x40(%rsi), %ymm0
vpshufb	%ymm15, %ymm0, %ymm5
vpaddq	0x40(%r9), %ymm5, %ymm0
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm5, %ymm4
vmovdqu	0x60(%rsi), %ymm0
vpshufb	%ymm15, %ymm0, %ymm6
vpaddq	0x60(%r9), %ymm6, %ymm0
vpermq	$0x1b, %ymm6, %ymm8
vpermq	$0x39, %ymm5, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm8
vpaddq	%ymm3, %ymm8, %ymm3
vsha512msg2	%ymm6, %ymm3
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm6, %ymm5
vpaddq	0x80(%r9), %ymm3, %ymm0
vpermq	$0x1b, %ymm3, %ymm8
vpermq	$0x39, %ymm6, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm4, %ymm4
vsha512msg2	%ymm3, %ymm4
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm3, %ymm6
vpaddq	0xa0(%r9), %ymm4, %ymm0
vpermq	$0x1b, %ymm4, %ymm8
vpermq	$0x39, %ymm3, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm5, %ymm5
vsha512msg2	%ymm4, %ymm5
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm4, %ymm3
vpaddq	0xc0(%r9), %ymm5, %ymm0
vpermq	$0x1b, %ymm5, %ymm8
vpermq	$0x39, %ymm4, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm6, %ymm6
vsha512msg2	%ymm5, %ymm6
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm5, %ymm4
vpaddq	0xe0(%r9), %ymm6, %ymm0
vpermq	$0x1b, %ymm6, %ymm8
vpermq	$0x39, %ymm5, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm3, %ymm3
vsha512msg2	%ymm6, %ymm3
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm6, %ymm5
vpaddq	0x100(%r9), %ymm3, %ymm0
vpermq	$0x1b, %ymm3, %ymm8
vpermq	$0x39, %ymm6, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm4, %ymm4
vsha512msg2	%ymm3, %ymm4
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm3, %ymm6
vpaddq	0x120(%r9), %ymm4, %ymm0
vpermq	$0x1b, %ymm4, %ymm8
vpermq	$0x39, %ymm3, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm5, %ymm5
vsha512msg2	%ymm4, %ymm5
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm4, %ymm3
vpaddq	0x140(%r9), %ymm5, %ymm0
vpermq	$0x1b, %ymm5, %ymm8
vpermq	$0x39, %ymm4, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm6, %ymm6
vsha512msg2	%ymm5, %ymm6
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm5, %ymm4
vpaddq	0x160(%r9), %ymm6, %ymm0
vpermq	$0x1b, %ymm6, %ymm8
vpermq	$0x39, %ymm5, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm3, %ymm3
vsha512msg2	%ymm6, %ymm3
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm6, %ymm5
vpaddq	0x180(%r9), %ymm3, %ymm0
vpermq	$0x1b, %ymm3, %ymm8
vpermq	$0x39, %ymm6, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm4, %ymm4
vsha512msg2	%ymm3, %ymm4
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm3, %ymm6
vpaddq	0x1a0(%r9), %ymm4, %ymm0
vpermq	$0x1b, %ymm4, %ymm8
vpermq	$0x39, %ymm3, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm5, %ymm5
vsha512msg2	%ymm4, %ymm5
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm4, %ymm3
vpaddq	0x1c0(%r9), %ymm5, %ymm0
vpermq	$0x1b, %ymm5, %ymm8
vpermq	$0x39, %ymm4, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm6, %ymm6
vsha512msg2	%ymm5, %ymm6
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm5, %ymm4
vpaddq	0x1e0(%r9), %ymm6, %ymm0
vpermq	$0x1b, %ymm6, %ymm8
vpermq	$0x39, %ymm5, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm3, %ymm3
vsha512msg2	%ymm6, %ymm3
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm6, %ymm5
vpaddq	0x200(%r9), %ymm3, %ymm0
vpermq	$0x1b, %ymm3, %ymm8
vpermq	$0x39, %ymm6, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm4, %ymm4
vsha512msg2	%ymm3, %ymm4
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vsha512msg1	%xmm3, %ymm6
vpaddq	0x220(%r9), %ymm4, %ymm0
vpermq	$0x1b, %ymm4, %ymm8
vpermq	$0x39, %ymm3, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm5, %ymm5
vsha512msg2	%ymm4, %ymm5
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vpaddq	0x240(%r9), %ymm5, %ymm0
vpermq	$0x1b, %ymm5, %ymm8
vpermq	$0x39, %ymm4, %ymm9
vpblendd	$0x3f, %ymm9, %ymm8, %ymm7
vpaddq	%ymm7, %ymm6, %ymm6
vsha512msg2	%ymm5, %ymm6
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vpaddq	0x260(%r9), %ymm6, %ymm0
vsha512rnds2	%xmm0, %ymm11, %ymm12
vperm2i128	$0x1, %ymm0, %ymm0, %ymm0
vsha512rnds2	%xmm0, %ymm12, %ymm11
vpaddq	%ymm12, %ymm14, %ymm14
vpaddq	%ymm11, %ymm13, %ymm13
addq	$0x80, %rsi
decq	%rdx
jne	L_4ac0
vperm2i128	$0x31, %ymm14, %ymm13, %ymm1
vperm2i128	$0x20, %ymm14, %ymm13, %ymm2
vpermq	$0xb1, %ymm1, %ymm1
vpermq	$0xb1, %ymm2, %ymm2
vmovdqu	%ymm1, (%rdi)
vmovdqu	%ymm2, 0x20(%rdi)
vzeroupper
L_4f16:
rep	retq
	.section .rodata
	.p2align 6
K512:
	.byte 34,174,40,215,152,47,138,66,205,101,239,35,145,68,55,113
	.byte 34,174,40,215,152,47,138,66,205,101,239,35,145,68,55,113
	.byte 47,59,77,236,207,251,192,181,188,219,137,129,165,219,181,233
	.byte 47,59,77,236,207,251,192,181,188,219,137,129,165,219,181,233
	.byte 56,181,72,243,91,194,86,57,25,208,5,182,241,17,241,89
	.byte 56,181,72,243,91,194,86,57,25,208,5,182,241,17,241,89
	.byte 155,79,25,175,164,130,63,146,24,129,109,218,213,94,28,171
	.byte 155,79,25,175,164,130,63,146,24,129,109,218,213,94,28,171
	.byte 66,2,3,163,152,170,7,216,190,111,112,69,1,91,131,18
	.byte 66,2,3,163,152,170,7,216,190,111,112,69,1,91,131,18
	.byte 140,178,228,78,190,133,49,36,226,180,255,213,195,125,12,85
	.byte 140,178,228,78,190,133,49,36,226,180,255,213,195,125,12,85
	.byte 111,137,123,242,116,93,190,114,177,150,22,59,254,177,222,128
	.byte 111,137,123,242,116,93,190,114,177,150,22,59,254,177,222,128
	.byte 53,18,199,37,167,6,220,155,148,38,105,207,116,241,155,193
	.byte 53,18,199,37,167,6,220,155,148,38,105,207,116,241,155,193
	.byte 210,74,241,158,193,105,155,228,227,37,79,56,134,71,190,239
	.byte 210,74,241,158,193,105,155,228,227,37,79,56,134,71,190,239
	.byte 181,213,140,139,198,157,193,15,101,156,172,119,204,161,12,36
	.byte 181,213,140,139,198,157,193,15,101,156,172,119,204,161,12,36
	.byte 117,2,43,89,111,44,233,45,131,228,166,110,170,132,116,74
	.byte 117,2,43,89,111,44,233,45,131,228,166,110,170,132,116,74
	.byte 212,251,65,189,220,169,176,92,181,83,17,131,218,136,249,118
	.byte 212,251,65,189,220,169,176,92,181,83,17,131,218,136,249,118
	.byte 171,223,102,238,82,81,62,152,16,50,180,45,109,198,49,168
	.byte 171,223,102,238,82,81,62,152,16,50,180,45,109,198,49,168
	.byte 63,33,251,152,200,39,3,176,228,14,239,190,199,127,89,191
	.byte 63,33,251,152,200,39,3,176,228,14,239,190,199,127,89,191
	.byte 194,143,168,61,243,11,224,198,37,167,10,147,71,145,167,213
	.byte 194,143,168,61,243,11,224,198,37,167,10,147,71,145,167,213
	.byte 111,130,3,224,81,99,202,6,112,110,14,10,103,41,41,20
	.byte 111,130,3,224,81,99,202,6,112,110,14,10,103,41,41,20
	.byte 252,47,210,70,133,10,183,39,38,201,38,92,56,33,27,46
	.byte 252,47,210,70,133,10,183,39,38,201,38,92,56,33,27,46
	.byte 237,42,196,90,252,109,44,77,223,179,149,157,19,13,56,83
	.byte 237,42,196,90,252,109,44,77,223,179,149,157,19,13,56,83
	.byte 222,99,175,139,84,115,10,101,168,178,119,60,187,10,106,118
	.byte 222,99,175,139,84,115,10,101,168,178,119,60,187,10,106,118
	.byte 230,174,237,71,46,201,194,129,59,53,130,20,133,44,114,146
	.byte 230,174,237,71,46,201,194,129,59,53,130,20,133,44,114,146
	.byte 100,3,241,76,161,232,191,162,1,48,66,188,75,102,26,168
	.byte 100,3,241,76,161,232,191,162,1,48,66,188,75,102,26,168
	.byte 145,151,248,208,112,139,75,194,48,190,84,6,163,81,108,199
	.byte 145,151,248,208,112,139,75,194,48,190,84,6,163,81,108,199
	.byte 24,82,239,214,25,232,146,209,16,169,101,85,36,6,153,214
	.byte 24,82,239,214,25,232,146,209,16,169,101,85,36,6,153,214
	.byte 42,32,113,87,133,53,14,244,184,209,187,50,112,160,106,16
	.byte 42,32,113,87,133,53,14,244,184,209,187,50,112,160,106,16
	.byte 200,208,210,184,22,193,164,25,83,171,65,81,8,108,55,30
	.byte 200,208,210,184,22,193,164,25,83,171,65,81,8,108,55,30
	.byte 153,235,142,223,76,119,72,39,168,72,155,225,181,188,176,52
	.byte 153,235,142,223,76,119,72,39,168,72,155,225,181,188,176,52
	.byte 99,90,201,197,179,12,28,57,203,138,65,227,74,170,216,78
	.byte 99,90,201,197,179,12,28,57,203,138,65,227,74,170,216,78
	.byte 115,227,99,119,79,202,156,91,163,184,178,214,243,111,46,104
	.byte 115,227,99,119,79,202,156,91,163,184,178,214,243,111,46,104
	.byte 252,178,239,93,238,130,143,116,96,47,23,67,111,99,165,120
	.byte 252,178,239,93,238,130,143,116,96,47,23,67,111,99,165,120
	.byte 114,171,240,161,20,120,200,132,236,57,100,26,8,2,199,140
	.byte 114,171,240,161,20,120,200,132,236,57,100,26,8,2,199,140
	.byte 40,30,99,35,250,255,190,144,233,189,130,222,235,108,80,164
	.byte 40,30,99,35,250,255,190,144,233,189,130,222,235,108,80,164
	.byte 21,121,198,178,247,163,249,190,43,83,114,227,242,120,113,198
	.byte 21,121,198,178,247,163,249,190,43,83,114,227,242,120,113,198
	.byte 156,97,38,234,206,62,39,202,7,194,192,33,199,184,134,209
	.byte 156,97,38,234,206,62,39,202,7,194,192,33,199,184,134,209
	.byte 30,235,224,205,214,125,218,234,120,209,110,238,127,79,125,245
	.byte 30,235,224,205,214,125,218,234,120,209,110,238,127,79,125,245
	.byte 186,111,23,114,170,103,240,6,166,152,200,162,197,125,99,10
	.byte 186,111,23,114,170,103,240,6,166,152,200,162,197,125,99,10
	.byte 174,13,249,190,4,152,63,17,27,71,28,19,53,11,113,27
	.byte 174,13,249,190,4,152,63,17,27,71,28,19,53,11,113,27
	.byte 132,125,4,35,245,119,219,40,147,36,199,64,123,171,202,50
	.byte 132,125,4,35,245,119,219,40,147,36,199,64,123,171,202,50
	.byte 188,190,201,21,10,190,158,60,76,13,16,156,196,103,29,67
	.byte 188,190,201,21,10,190,158,60,76,13,16,156,196,103,29,67
	.byte 182,66,62,203,190,212,197,76,42,126,101,252,156,41,127,89
	.byte 182,66,62,203,190,212,197,76,42,126,101,252,156,41,127,89
	.byte 236,250,214,58,171,111,203,95,23,88,71,74,140,25,68,108
	.byte 236,250,214,58,171,111,203,95,23,88,71,74,140,25,68,108
	.byte 7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8
	.byte 7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8
	.byte 83,72,65,53,49,50,32,98,108,111,99,107,32,116,114,97
	.byte 110,115,102,111,114,109,32,102,111,114,32,120,56,54,95,54
	.byte 52,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121
	.byte 32,60,104,116,116,112,115,58,47,47,103,105,116,104,117,98
	.byte 46,99,111,109,47,100,111,116,45,97,115,109,62,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
K512_single:
	.byte 34,174,40,215,152,47,138,66,205,101,239,35,145,68,55,113
	.byte 47,59,77,236,207,251,192,181,188,219,137,129,165,219,181,233
	.byte 56,181,72,243,91,194,86,57,25,208,5,182,241,17,241,89
	.byte 155,79,25,175,164,130,63,146,24,129,109,218,213,94,28,171
	.byte 66,2,3,163,152,170,7,216,190,111,112,69,1,91,131,18
	.byte 140,178,228,78,190,133,49,36,226,180,255,213,195,125,12,85
	.byte 111,137,123,242,116,93,190,114,177,150,22,59,254,177,222,128
	.byte 53,18,199,37,167,6,220,155,148,38,105,207,116,241,155,193
	.byte 210,74,241,158,193,105,155,228,227,37,79,56,134,71,190,239
	.byte 181,213,140,139,198,157,193,15,101,156,172,119,204,161,12,36
	.byte 117,2,43,89,111,44,233,45,131,228,166,110,170,132,116,74
	.byte 212,251,65,189,220,169,176,92,181,83,17,131,218,136,249,118
	.byte 171,223,102,238,82,81,62,152,16,50,180,45,109,198,49,168
	.byte 63,33,251,152,200,39,3,176,228,14,239,190,199,127,89,191
	.byte 194,143,168,61,243,11,224,198,37,167,10,147,71,145,167,213
	.byte 111,130,3,224,81,99,202,6,112,110,14,10,103,41,41,20
	.byte 252,47,210,70,133,10,183,39,38,201,38,92,56,33,27,46
	.byte 237,42,196,90,252,109,44,77,223,179,149,157,19,13,56,83
	.byte 222,99,175,139,84,115,10,101,168,178,119,60,187,10,106,118
	.byte 230,174,237,71,46,201,194,129,59,53,130,20,133,44,114,146
	.byte 100,3,241,76,161,232,191,162,1,48,66,188,75,102,26,168
	.byte 145,151,248,208,112,139,75,194,48,190,84,6,163,81,108,199
	.byte 24,82,239,214,25,232,146,209,16,169,101,85,36,6,153,214
	.byte 42,32,113,87,133,53,14,244,184,209,187,50,112,160,106,16
	.byte 200,208,210,184,22,193,164,25,83,171,65,81,8,108,55,30
	.byte 153,235,142,223,76,119,72,39,168,72,155,225,181,188,176,52
	.byte 99,90,201,197,179,12,28,57,203,138,65,227,74,170,216,78
	.byte 115,227,99,119,79,202,156,91,163,184,178,214,243,111,46,104
	.byte 252,178,239,93,238,130,143,116,96,47,23,67,111,99,165,120
	.byte 114,171,240,161,20,120,200,132,236,57,100,26,8,2,199,140
	.byte 40,30,99,35,250,255,190,144,233,189,130,222,235,108,80,164
	.byte 21,121,198,178,247,163,249,190,43,83,114,227,242,120,113,198
	.byte 156,97,38,234,206,62,39,202,7,194,192,33,199,184,134,209
	.byte 30,235,224,205,214,125,218,234,120,209,110,238,127,79,125,245
	.byte 186,111,23,114,170,103,240,6,166,152,200,162,197,125,99,10
	.byte 174,13,249,190,4,152,63,17,27,71,28,19,53,11,113,27
	.byte 132,125,4,35,245,119,219,40,147,36,199,64,123,171,202,50
	.byte 188,190,201,21,10,190,158,60,76,13,16,156,196,103,29,67
	.byte 182,66,62,203,190,212,197,76,42,126,101,252,156,41,127,89
	.byte 236,250,214,58,171,111,203,95,23,88,71,74,140,25,68,108
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

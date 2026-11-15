	.text
sha256_block_data_order:
leaq	OPENSSL_ia32cap_P(%rip), %r10
movq	(%r10), %r9
movl	0x8(%r10), %r11d
testl	$0x20000000, %r11d
jne	_shaext_shortcut
andl	$0x128, %r11d
cmpl	$0x128, %r11d
je	sha256_block_data_order_avx2
movabsq	$0x1000020040000000, %r11
andq	%r11, %r9
cmpq	%r11, %r9
je	sha256_block_data_order_avx
btq	$0x29, %r9
jb	sha256_block_data_order_ssse3
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shlq	$0x4, %rdx
subq	$0x60, %rsp
leaq	(%rsi,%rdx,4), %rdx
andq	$-0x40, %rsp
movq	%rdi, 0x40(%rsp)
movq	%rsi, 0x48(%rsp)
movq	%rdx, 0x50(%rsp)
movq	%rax, 0x58(%rsp)
movl	(%rdi), %eax
movl	0x4(%rdi), %ebx
movl	0x8(%rdi), %ecx
movl	0xc(%rdi), %edx
movl	0x10(%rdi), %r8d
movl	0x14(%rdi), %r9d
movl	0x18(%rdi), %r10d
movl	0x1c(%rdi), %r11d
jmp	L_a0
nop
L_a0:
movl	%ebx, %edi
leaq	K256(%rip), %rbp
xorl	%ecx, %edi
movl	(%rsi), %r12d
movl	%r8d, %r13d
movl	%eax, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r9d, %r15d
xorl	%r8d, %r13d
rorl	$0x9, %r14d
xorl	%r10d, %r15d
movl	%r12d, (%rsp)
xorl	%eax, %r14d
andl	%r8d, %r15d
rorl	$0x5, %r13d
addl	%r11d, %r12d
xorl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r13d
addl	%r15d, %r12d
movl	%eax, %r15d
addl	(%rbp), %r12d
xorl	%eax, %r14d
xorl	%ebx, %r15d
rorl	$0x6, %r13d
movl	%ebx, %r11d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r11d
addl	%r12d, %edx
addl	%r12d, %r11d
leaq	0x4(%rbp), %rbp
addl	%r14d, %r11d
movl	0x4(%rsi), %r12d
movl	%edx, %r13d
movl	%r11d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r8d, %edi
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %edi
movl	%r12d, 0x4(%rsp)
xorl	%r11d, %r14d
andl	%edx, %edi
rorl	$0x5, %r13d
addl	%r10d, %r12d
xorl	%r9d, %edi
rorl	$0xb, %r14d
xorl	%edx, %r13d
addl	%edi, %r12d
movl	%r11d, %edi
addl	(%rbp), %r12d
xorl	%r11d, %r14d
xorl	%eax, %edi
rorl	$0x6, %r13d
movl	%eax, %r10d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r10d
addl	%r12d, %ecx
addl	%r12d, %r10d
leaq	0x4(%rbp), %rbp
addl	%r14d, %r10d
movl	0x8(%rsi), %r12d
movl	%ecx, %r13d
movl	%r10d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%edx, %r15d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r15d
movl	%r12d, 0x8(%rsp)
xorl	%r10d, %r14d
andl	%ecx, %r15d
rorl	$0x5, %r13d
addl	%r9d, %r12d
xorl	%r8d, %r15d
rorl	$0xb, %r14d
xorl	%ecx, %r13d
addl	%r15d, %r12d
movl	%r10d, %r15d
addl	(%rbp), %r12d
xorl	%r10d, %r14d
xorl	%r11d, %r15d
rorl	$0x6, %r13d
movl	%r11d, %r9d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r9d
addl	%r12d, %ebx
addl	%r12d, %r9d
leaq	0x4(%rbp), %rbp
addl	%r14d, %r9d
movl	0xc(%rsi), %r12d
movl	%ebx, %r13d
movl	%r9d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%ecx, %edi
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %edi
movl	%r12d, 0xc(%rsp)
xorl	%r9d, %r14d
andl	%ebx, %edi
rorl	$0x5, %r13d
addl	%r8d, %r12d
xorl	%edx, %edi
rorl	$0xb, %r14d
xorl	%ebx, %r13d
addl	%edi, %r12d
movl	%r9d, %edi
addl	(%rbp), %r12d
xorl	%r9d, %r14d
xorl	%r10d, %edi
rorl	$0x6, %r13d
movl	%r10d, %r8d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r8d
addl	%r12d, %eax
addl	%r12d, %r8d
leaq	0x14(%rbp), %rbp
addl	%r14d, %r8d
movl	0x10(%rsi), %r12d
movl	%eax, %r13d
movl	%r8d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%ebx, %r15d
xorl	%eax, %r13d
rorl	$0x9, %r14d
xorl	%ecx, %r15d
movl	%r12d, 0x10(%rsp)
xorl	%r8d, %r14d
andl	%eax, %r15d
rorl	$0x5, %r13d
addl	%edx, %r12d
xorl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r13d
addl	%r15d, %r12d
movl	%r8d, %r15d
addl	(%rbp), %r12d
xorl	%r8d, %r14d
xorl	%r9d, %r15d
rorl	$0x6, %r13d
movl	%r9d, %edx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %edx
addl	%r12d, %r11d
addl	%r12d, %edx
leaq	0x4(%rbp), %rbp
addl	%r14d, %edx
movl	0x14(%rsi), %r12d
movl	%r11d, %r13d
movl	%edx, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%eax, %edi
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %edi
movl	%r12d, 0x14(%rsp)
xorl	%edx, %r14d
andl	%r11d, %edi
rorl	$0x5, %r13d
addl	%ecx, %r12d
xorl	%ebx, %edi
rorl	$0xb, %r14d
xorl	%r11d, %r13d
addl	%edi, %r12d
movl	%edx, %edi
addl	(%rbp), %r12d
xorl	%edx, %r14d
xorl	%r8d, %edi
rorl	$0x6, %r13d
movl	%r8d, %ecx
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %ecx
addl	%r12d, %r10d
addl	%r12d, %ecx
leaq	0x4(%rbp), %rbp
addl	%r14d, %ecx
movl	0x18(%rsi), %r12d
movl	%r10d, %r13d
movl	%ecx, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r11d, %r15d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r15d
movl	%r12d, 0x18(%rsp)
xorl	%ecx, %r14d
andl	%r10d, %r15d
rorl	$0x5, %r13d
addl	%ebx, %r12d
xorl	%eax, %r15d
rorl	$0xb, %r14d
xorl	%r10d, %r13d
addl	%r15d, %r12d
movl	%ecx, %r15d
addl	(%rbp), %r12d
xorl	%ecx, %r14d
xorl	%edx, %r15d
rorl	$0x6, %r13d
movl	%edx, %ebx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %ebx
addl	%r12d, %r9d
addl	%r12d, %ebx
leaq	0x4(%rbp), %rbp
addl	%r14d, %ebx
movl	0x1c(%rsi), %r12d
movl	%r9d, %r13d
movl	%ebx, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r10d, %edi
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %edi
movl	%r12d, 0x1c(%rsp)
xorl	%ebx, %r14d
andl	%r9d, %edi
rorl	$0x5, %r13d
addl	%eax, %r12d
xorl	%r11d, %edi
rorl	$0xb, %r14d
xorl	%r9d, %r13d
addl	%edi, %r12d
movl	%ebx, %edi
addl	(%rbp), %r12d
xorl	%ebx, %r14d
xorl	%ecx, %edi
rorl	$0x6, %r13d
movl	%ecx, %eax
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %eax
addl	%r12d, %r8d
addl	%r12d, %eax
leaq	0x14(%rbp), %rbp
addl	%r14d, %eax
movl	0x20(%rsi), %r12d
movl	%r8d, %r13d
movl	%eax, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r9d, %r15d
xorl	%r8d, %r13d
rorl	$0x9, %r14d
xorl	%r10d, %r15d
movl	%r12d, 0x20(%rsp)
xorl	%eax, %r14d
andl	%r8d, %r15d
rorl	$0x5, %r13d
addl	%r11d, %r12d
xorl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r13d
addl	%r15d, %r12d
movl	%eax, %r15d
addl	(%rbp), %r12d
xorl	%eax, %r14d
xorl	%ebx, %r15d
rorl	$0x6, %r13d
movl	%ebx, %r11d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r11d
addl	%r12d, %edx
addl	%r12d, %r11d
leaq	0x4(%rbp), %rbp
addl	%r14d, %r11d
movl	0x24(%rsi), %r12d
movl	%edx, %r13d
movl	%r11d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r8d, %edi
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %edi
movl	%r12d, 0x24(%rsp)
xorl	%r11d, %r14d
andl	%edx, %edi
rorl	$0x5, %r13d
addl	%r10d, %r12d
xorl	%r9d, %edi
rorl	$0xb, %r14d
xorl	%edx, %r13d
addl	%edi, %r12d
movl	%r11d, %edi
addl	(%rbp), %r12d
xorl	%r11d, %r14d
xorl	%eax, %edi
rorl	$0x6, %r13d
movl	%eax, %r10d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r10d
addl	%r12d, %ecx
addl	%r12d, %r10d
leaq	0x4(%rbp), %rbp
addl	%r14d, %r10d
movl	0x28(%rsi), %r12d
movl	%ecx, %r13d
movl	%r10d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%edx, %r15d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r15d
movl	%r12d, 0x28(%rsp)
xorl	%r10d, %r14d
andl	%ecx, %r15d
rorl	$0x5, %r13d
addl	%r9d, %r12d
xorl	%r8d, %r15d
rorl	$0xb, %r14d
xorl	%ecx, %r13d
addl	%r15d, %r12d
movl	%r10d, %r15d
addl	(%rbp), %r12d
xorl	%r10d, %r14d
xorl	%r11d, %r15d
rorl	$0x6, %r13d
movl	%r11d, %r9d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r9d
addl	%r12d, %ebx
addl	%r12d, %r9d
leaq	0x4(%rbp), %rbp
addl	%r14d, %r9d
movl	0x2c(%rsi), %r12d
movl	%ebx, %r13d
movl	%r9d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%ecx, %edi
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %edi
movl	%r12d, 0x2c(%rsp)
xorl	%r9d, %r14d
andl	%ebx, %edi
rorl	$0x5, %r13d
addl	%r8d, %r12d
xorl	%edx, %edi
rorl	$0xb, %r14d
xorl	%ebx, %r13d
addl	%edi, %r12d
movl	%r9d, %edi
addl	(%rbp), %r12d
xorl	%r9d, %r14d
xorl	%r10d, %edi
rorl	$0x6, %r13d
movl	%r10d, %r8d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r8d
addl	%r12d, %eax
addl	%r12d, %r8d
leaq	0x14(%rbp), %rbp
addl	%r14d, %r8d
movl	0x30(%rsi), %r12d
movl	%eax, %r13d
movl	%r8d, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%ebx, %r15d
xorl	%eax, %r13d
rorl	$0x9, %r14d
xorl	%ecx, %r15d
movl	%r12d, 0x30(%rsp)
xorl	%r8d, %r14d
andl	%eax, %r15d
rorl	$0x5, %r13d
addl	%edx, %r12d
xorl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r13d
addl	%r15d, %r12d
movl	%r8d, %r15d
addl	(%rbp), %r12d
xorl	%r8d, %r14d
xorl	%r9d, %r15d
rorl	$0x6, %r13d
movl	%r9d, %edx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %edx
addl	%r12d, %r11d
addl	%r12d, %edx
leaq	0x4(%rbp), %rbp
addl	%r14d, %edx
movl	0x34(%rsi), %r12d
movl	%r11d, %r13d
movl	%edx, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%eax, %edi
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %edi
movl	%r12d, 0x34(%rsp)
xorl	%edx, %r14d
andl	%r11d, %edi
rorl	$0x5, %r13d
addl	%ecx, %r12d
xorl	%ebx, %edi
rorl	$0xb, %r14d
xorl	%r11d, %r13d
addl	%edi, %r12d
movl	%edx, %edi
addl	(%rbp), %r12d
xorl	%edx, %r14d
xorl	%r8d, %edi
rorl	$0x6, %r13d
movl	%r8d, %ecx
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %ecx
addl	%r12d, %r10d
addl	%r12d, %ecx
leaq	0x4(%rbp), %rbp
addl	%r14d, %ecx
movl	0x38(%rsi), %r12d
movl	%r10d, %r13d
movl	%ecx, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r11d, %r15d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r15d
movl	%r12d, 0x38(%rsp)
xorl	%ecx, %r14d
andl	%r10d, %r15d
rorl	$0x5, %r13d
addl	%ebx, %r12d
xorl	%eax, %r15d
rorl	$0xb, %r14d
xorl	%r10d, %r13d
addl	%r15d, %r12d
movl	%ecx, %r15d
addl	(%rbp), %r12d
xorl	%ecx, %r14d
xorl	%edx, %r15d
rorl	$0x6, %r13d
movl	%edx, %ebx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %ebx
addl	%r12d, %r9d
addl	%r12d, %ebx
leaq	0x4(%rbp), %rbp
addl	%r14d, %ebx
movl	0x3c(%rsi), %r12d
movl	%r9d, %r13d
movl	%ebx, %r14d
bswapl	%r12d
rorl	$0xe, %r13d
movl	%r10d, %edi
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %edi
movl	%r12d, 0x3c(%rsp)
xorl	%ebx, %r14d
andl	%r9d, %edi
rorl	$0x5, %r13d
addl	%eax, %r12d
xorl	%r11d, %edi
rorl	$0xb, %r14d
xorl	%r9d, %r13d
addl	%edi, %r12d
movl	%ebx, %edi
addl	(%rbp), %r12d
xorl	%ebx, %r14d
xorl	%ecx, %edi
rorl	$0x6, %r13d
movl	%ecx, %eax
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %eax
addl	%r12d, %r8d
addl	%r12d, %eax
leaq	0x14(%rbp), %rbp
jmp	L_740
nopl	(%rax,%rax)
L_740:
movl	0x4(%rsp), %r13d
movl	0x38(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %eax
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x24(%rsp), %r12d
addl	(%rsp), %r12d
movl	%r8d, %r13d
addl	%r15d, %r12d
movl	%eax, %r14d
rorl	$0xe, %r13d
movl	%r9d, %r15d
xorl	%r8d, %r13d
rorl	$0x9, %r14d
xorl	%r10d, %r15d
movl	%r12d, (%rsp)
xorl	%eax, %r14d
andl	%r8d, %r15d
rorl	$0x5, %r13d
addl	%r11d, %r12d
xorl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r13d
addl	%r15d, %r12d
movl	%eax, %r15d
addl	(%rbp), %r12d
xorl	%eax, %r14d
xorl	%ebx, %r15d
rorl	$0x6, %r13d
movl	%ebx, %r11d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r11d
addl	%r12d, %edx
addl	%r12d, %r11d
leaq	0x4(%rbp), %rbp
movl	0x8(%rsp), %r13d
movl	0x3c(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r11d
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x28(%rsp), %r12d
addl	0x4(%rsp), %r12d
movl	%edx, %r13d
addl	%edi, %r12d
movl	%r11d, %r14d
rorl	$0xe, %r13d
movl	%r8d, %edi
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %edi
movl	%r12d, 0x4(%rsp)
xorl	%r11d, %r14d
andl	%edx, %edi
rorl	$0x5, %r13d
addl	%r10d, %r12d
xorl	%r9d, %edi
rorl	$0xb, %r14d
xorl	%edx, %r13d
addl	%edi, %r12d
movl	%r11d, %edi
addl	(%rbp), %r12d
xorl	%r11d, %r14d
xorl	%eax, %edi
rorl	$0x6, %r13d
movl	%eax, %r10d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r10d
addl	%r12d, %ecx
addl	%r12d, %r10d
leaq	0x4(%rbp), %rbp
movl	0xc(%rsp), %r13d
movl	(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r10d
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x2c(%rsp), %r12d
addl	0x8(%rsp), %r12d
movl	%ecx, %r13d
addl	%r15d, %r12d
movl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%edx, %r15d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r15d
movl	%r12d, 0x8(%rsp)
xorl	%r10d, %r14d
andl	%ecx, %r15d
rorl	$0x5, %r13d
addl	%r9d, %r12d
xorl	%r8d, %r15d
rorl	$0xb, %r14d
xorl	%ecx, %r13d
addl	%r15d, %r12d
movl	%r10d, %r15d
addl	(%rbp), %r12d
xorl	%r10d, %r14d
xorl	%r11d, %r15d
rorl	$0x6, %r13d
movl	%r11d, %r9d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r9d
addl	%r12d, %ebx
addl	%r12d, %r9d
leaq	0x4(%rbp), %rbp
movl	0x10(%rsp), %r13d
movl	0x4(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r9d
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x30(%rsp), %r12d
addl	0xc(%rsp), %r12d
movl	%ebx, %r13d
addl	%edi, %r12d
movl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%ecx, %edi
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %edi
movl	%r12d, 0xc(%rsp)
xorl	%r9d, %r14d
andl	%ebx, %edi
rorl	$0x5, %r13d
addl	%r8d, %r12d
xorl	%edx, %edi
rorl	$0xb, %r14d
xorl	%ebx, %r13d
addl	%edi, %r12d
movl	%r9d, %edi
addl	(%rbp), %r12d
xorl	%r9d, %r14d
xorl	%r10d, %edi
rorl	$0x6, %r13d
movl	%r10d, %r8d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r8d
addl	%r12d, %eax
addl	%r12d, %r8d
leaq	0x14(%rbp), %rbp
movl	0x14(%rsp), %r13d
movl	0x8(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r8d
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x34(%rsp), %r12d
addl	0x10(%rsp), %r12d
movl	%eax, %r13d
addl	%r15d, %r12d
movl	%r8d, %r14d
rorl	$0xe, %r13d
movl	%ebx, %r15d
xorl	%eax, %r13d
rorl	$0x9, %r14d
xorl	%ecx, %r15d
movl	%r12d, 0x10(%rsp)
xorl	%r8d, %r14d
andl	%eax, %r15d
rorl	$0x5, %r13d
addl	%edx, %r12d
xorl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r13d
addl	%r15d, %r12d
movl	%r8d, %r15d
addl	(%rbp), %r12d
xorl	%r8d, %r14d
xorl	%r9d, %r15d
rorl	$0x6, %r13d
movl	%r9d, %edx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %edx
addl	%r12d, %r11d
addl	%r12d, %edx
leaq	0x4(%rbp), %rbp
movl	0x18(%rsp), %r13d
movl	0xc(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %edx
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x38(%rsp), %r12d
addl	0x14(%rsp), %r12d
movl	%r11d, %r13d
addl	%edi, %r12d
movl	%edx, %r14d
rorl	$0xe, %r13d
movl	%eax, %edi
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %edi
movl	%r12d, 0x14(%rsp)
xorl	%edx, %r14d
andl	%r11d, %edi
rorl	$0x5, %r13d
addl	%ecx, %r12d
xorl	%ebx, %edi
rorl	$0xb, %r14d
xorl	%r11d, %r13d
addl	%edi, %r12d
movl	%edx, %edi
addl	(%rbp), %r12d
xorl	%edx, %r14d
xorl	%r8d, %edi
rorl	$0x6, %r13d
movl	%r8d, %ecx
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %ecx
addl	%r12d, %r10d
addl	%r12d, %ecx
leaq	0x4(%rbp), %rbp
movl	0x1c(%rsp), %r13d
movl	0x10(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %ecx
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x3c(%rsp), %r12d
addl	0x18(%rsp), %r12d
movl	%r10d, %r13d
addl	%r15d, %r12d
movl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r11d, %r15d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r15d
movl	%r12d, 0x18(%rsp)
xorl	%ecx, %r14d
andl	%r10d, %r15d
rorl	$0x5, %r13d
addl	%ebx, %r12d
xorl	%eax, %r15d
rorl	$0xb, %r14d
xorl	%r10d, %r13d
addl	%r15d, %r12d
movl	%ecx, %r15d
addl	(%rbp), %r12d
xorl	%ecx, %r14d
xorl	%edx, %r15d
rorl	$0x6, %r13d
movl	%edx, %ebx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %ebx
addl	%r12d, %r9d
addl	%r12d, %ebx
leaq	0x4(%rbp), %rbp
movl	0x20(%rsp), %r13d
movl	0x14(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %ebx
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	(%rsp), %r12d
addl	0x1c(%rsp), %r12d
movl	%r9d, %r13d
addl	%edi, %r12d
movl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r10d, %edi
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %edi
movl	%r12d, 0x1c(%rsp)
xorl	%ebx, %r14d
andl	%r9d, %edi
rorl	$0x5, %r13d
addl	%eax, %r12d
xorl	%r11d, %edi
rorl	$0xb, %r14d
xorl	%r9d, %r13d
addl	%edi, %r12d
movl	%ebx, %edi
addl	(%rbp), %r12d
xorl	%ebx, %r14d
xorl	%ecx, %edi
rorl	$0x6, %r13d
movl	%ecx, %eax
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %eax
addl	%r12d, %r8d
addl	%r12d, %eax
leaq	0x14(%rbp), %rbp
movl	0x24(%rsp), %r13d
movl	0x18(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %eax
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x4(%rsp), %r12d
addl	0x20(%rsp), %r12d
movl	%r8d, %r13d
addl	%r15d, %r12d
movl	%eax, %r14d
rorl	$0xe, %r13d
movl	%r9d, %r15d
xorl	%r8d, %r13d
rorl	$0x9, %r14d
xorl	%r10d, %r15d
movl	%r12d, 0x20(%rsp)
xorl	%eax, %r14d
andl	%r8d, %r15d
rorl	$0x5, %r13d
addl	%r11d, %r12d
xorl	%r10d, %r15d
rorl	$0xb, %r14d
xorl	%r8d, %r13d
addl	%r15d, %r12d
movl	%eax, %r15d
addl	(%rbp), %r12d
xorl	%eax, %r14d
xorl	%ebx, %r15d
rorl	$0x6, %r13d
movl	%ebx, %r11d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r11d
addl	%r12d, %edx
addl	%r12d, %r11d
leaq	0x4(%rbp), %rbp
movl	0x28(%rsp), %r13d
movl	0x1c(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r11d
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x8(%rsp), %r12d
addl	0x24(%rsp), %r12d
movl	%edx, %r13d
addl	%edi, %r12d
movl	%r11d, %r14d
rorl	$0xe, %r13d
movl	%r8d, %edi
xorl	%edx, %r13d
rorl	$0x9, %r14d
xorl	%r9d, %edi
movl	%r12d, 0x24(%rsp)
xorl	%r11d, %r14d
andl	%edx, %edi
rorl	$0x5, %r13d
addl	%r10d, %r12d
xorl	%r9d, %edi
rorl	$0xb, %r14d
xorl	%edx, %r13d
addl	%edi, %r12d
movl	%r11d, %edi
addl	(%rbp), %r12d
xorl	%r11d, %r14d
xorl	%eax, %edi
rorl	$0x6, %r13d
movl	%eax, %r10d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r10d
addl	%r12d, %ecx
addl	%r12d, %r10d
leaq	0x4(%rbp), %rbp
movl	0x2c(%rsp), %r13d
movl	0x20(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r10d
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0xc(%rsp), %r12d
addl	0x28(%rsp), %r12d
movl	%ecx, %r13d
addl	%r15d, %r12d
movl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%edx, %r15d
xorl	%ecx, %r13d
rorl	$0x9, %r14d
xorl	%r8d, %r15d
movl	%r12d, 0x28(%rsp)
xorl	%r10d, %r14d
andl	%ecx, %r15d
rorl	$0x5, %r13d
addl	%r9d, %r12d
xorl	%r8d, %r15d
rorl	$0xb, %r14d
xorl	%ecx, %r13d
addl	%r15d, %r12d
movl	%r10d, %r15d
addl	(%rbp), %r12d
xorl	%r10d, %r14d
xorl	%r11d, %r15d
rorl	$0x6, %r13d
movl	%r11d, %r9d
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %r9d
addl	%r12d, %ebx
addl	%r12d, %r9d
leaq	0x4(%rbp), %rbp
movl	0x30(%rsp), %r13d
movl	0x24(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r9d
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x10(%rsp), %r12d
addl	0x2c(%rsp), %r12d
movl	%ebx, %r13d
addl	%edi, %r12d
movl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%ecx, %edi
xorl	%ebx, %r13d
rorl	$0x9, %r14d
xorl	%edx, %edi
movl	%r12d, 0x2c(%rsp)
xorl	%r9d, %r14d
andl	%ebx, %edi
rorl	$0x5, %r13d
addl	%r8d, %r12d
xorl	%edx, %edi
rorl	$0xb, %r14d
xorl	%ebx, %r13d
addl	%edi, %r12d
movl	%r9d, %edi
addl	(%rbp), %r12d
xorl	%r9d, %r14d
xorl	%r10d, %edi
rorl	$0x6, %r13d
movl	%r10d, %r8d
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %r8d
addl	%r12d, %eax
addl	%r12d, %r8d
leaq	0x14(%rbp), %rbp
movl	0x34(%rsp), %r13d
movl	0x28(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %r8d
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x14(%rsp), %r12d
addl	0x30(%rsp), %r12d
movl	%eax, %r13d
addl	%r15d, %r12d
movl	%r8d, %r14d
rorl	$0xe, %r13d
movl	%ebx, %r15d
xorl	%eax, %r13d
rorl	$0x9, %r14d
xorl	%ecx, %r15d
movl	%r12d, 0x30(%rsp)
xorl	%r8d, %r14d
andl	%eax, %r15d
rorl	$0x5, %r13d
addl	%edx, %r12d
xorl	%ecx, %r15d
rorl	$0xb, %r14d
xorl	%eax, %r13d
addl	%r15d, %r12d
movl	%r8d, %r15d
addl	(%rbp), %r12d
xorl	%r8d, %r14d
xorl	%r9d, %r15d
rorl	$0x6, %r13d
movl	%r9d, %edx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %edx
addl	%r12d, %r11d
addl	%r12d, %edx
leaq	0x4(%rbp), %rbp
movl	0x38(%rsp), %r13d
movl	0x2c(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %edx
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x18(%rsp), %r12d
addl	0x34(%rsp), %r12d
movl	%r11d, %r13d
addl	%edi, %r12d
movl	%edx, %r14d
rorl	$0xe, %r13d
movl	%eax, %edi
xorl	%r11d, %r13d
rorl	$0x9, %r14d
xorl	%ebx, %edi
movl	%r12d, 0x34(%rsp)
xorl	%edx, %r14d
andl	%r11d, %edi
rorl	$0x5, %r13d
addl	%ecx, %r12d
xorl	%ebx, %edi
rorl	$0xb, %r14d
xorl	%r11d, %r13d
addl	%edi, %r12d
movl	%edx, %edi
addl	(%rbp), %r12d
xorl	%edx, %r14d
xorl	%r8d, %edi
rorl	$0x6, %r13d
movl	%r8d, %ecx
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %ecx
addl	%r12d, %r10d
addl	%r12d, %ecx
leaq	0x4(%rbp), %rbp
movl	0x3c(%rsp), %r13d
movl	0x30(%rsp), %r15d
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %ecx
movl	%r15d, %r14d
rorl	$0x2, %r15d
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %r15d
shrl	$0xa, %r14d
rorl	$0x11, %r15d
xorl	%r13d, %r12d
xorl	%r14d, %r15d
addl	0x1c(%rsp), %r12d
addl	0x38(%rsp), %r12d
movl	%r10d, %r13d
addl	%r15d, %r12d
movl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r11d, %r15d
xorl	%r10d, %r13d
rorl	$0x9, %r14d
xorl	%eax, %r15d
movl	%r12d, 0x38(%rsp)
xorl	%ecx, %r14d
andl	%r10d, %r15d
rorl	$0x5, %r13d
addl	%ebx, %r12d
xorl	%eax, %r15d
rorl	$0xb, %r14d
xorl	%r10d, %r13d
addl	%r15d, %r12d
movl	%ecx, %r15d
addl	(%rbp), %r12d
xorl	%ecx, %r14d
xorl	%edx, %r15d
rorl	$0x6, %r13d
movl	%edx, %ebx
andl	%r15d, %edi
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%edi, %ebx
addl	%r12d, %r9d
addl	%r12d, %ebx
leaq	0x4(%rbp), %rbp
movl	(%rsp), %r13d
movl	0x34(%rsp), %edi
movl	%r13d, %r12d
rorl	$0xb, %r13d
addl	%r14d, %ebx
movl	%edi, %r14d
rorl	$0x2, %edi
xorl	%r12d, %r13d
shrl	$0x3, %r12d
rorl	$0x7, %r13d
xorl	%r14d, %edi
shrl	$0xa, %r14d
rorl	$0x11, %edi
xorl	%r13d, %r12d
xorl	%r14d, %edi
addl	0x20(%rsp), %r12d
addl	0x3c(%rsp), %r12d
movl	%r9d, %r13d
addl	%edi, %r12d
movl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r10d, %edi
xorl	%r9d, %r13d
rorl	$0x9, %r14d
xorl	%r11d, %edi
movl	%r12d, 0x3c(%rsp)
xorl	%ebx, %r14d
andl	%r9d, %edi
rorl	$0x5, %r13d
addl	%eax, %r12d
xorl	%r11d, %edi
rorl	$0xb, %r14d
xorl	%r9d, %r13d
addl	%edi, %r12d
movl	%ebx, %edi
addl	(%rbp), %r12d
xorl	%ebx, %r14d
xorl	%ecx, %edi
rorl	$0x6, %r13d
movl	%ecx, %eax
andl	%edi, %r15d
rorl	$0x2, %r14d
addl	%r13d, %r12d
xorl	%r15d, %eax
addl	%r12d, %r8d
addl	%r12d, %eax
leaq	0x14(%rbp), %rbp
cmpb	$0x0, 0x3(%rbp)
jne	L_740
movq	0x40(%rsp), %rdi
addl	%r14d, %eax
leaq	0x40(%rsi), %rsi
addl	(%rdi), %eax
addl	0x4(%rdi), %ebx
addl	0x8(%rdi), %ecx
addl	0xc(%rdi), %edx
addl	0x10(%rdi), %r8d
addl	0x14(%rdi), %r9d
addl	0x18(%rdi), %r10d
addl	0x1c(%rdi), %r11d
cmpq	0x50(%rsp), %rsi
movl	%eax, (%rdi)
movl	%ebx, 0x4(%rdi)
movl	%ecx, 0x8(%rdi)
movl	%edx, 0xc(%rdi)
movl	%r8d, 0x10(%rdi)
movl	%r9d, 0x14(%rdi)
movl	%r10d, 0x18(%rdi)
movl	%r11d, 0x1c(%rdi)
jb	L_a0
movq	0x58(%rsp), %rsi
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
nop
_shaext_shortcut:
sha256_block_data_order_shaext:
leaq	K256+128(%rip), %rcx
movdqu	(%rdi), %xmm1
movdqu	0x10(%rdi), %xmm2
movdqa	0x180(%rcx), %xmm7
pshufd	$0x1b, %xmm1, %xmm0
pshufd	$0xb1, %xmm1, %xmm1
pshufd	$0x1b, %xmm2, %xmm2
movdqa	%xmm7, %xmm8
palignr	$0x8, %xmm2, %xmm1
punpcklqdq	%xmm0, %xmm2
jmp	L_1240
nopl	(%rax,%rax)
L_1240:
movdqu	(%rsi), %xmm3
movdqu	0x10(%rsi), %xmm4
movdqu	0x20(%rsi), %xmm5
pshufb	%xmm7, %xmm3
movdqu	0x30(%rsi), %xmm6
movdqa	-0x80(%rcx), %xmm0
paddd	%xmm3, %xmm0
pshufb	%xmm7, %xmm4
movdqa	%xmm2, %xmm10
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
nop
movdqa	%xmm1, %xmm9
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	-0x60(%rcx), %xmm0
paddd	%xmm4, %xmm0
pshufb	%xmm7, %xmm5
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
leaq	0x40(%rsi), %rsi
sha256msg1	%xmm4, %xmm3
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	-0x40(%rcx), %xmm0
paddd	%xmm5, %xmm0
pshufb	%xmm7, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm6, %xmm7
palignr	$0x4, %xmm5, %xmm7
nop
paddd	%xmm7, %xmm3
sha256msg1	%xmm5, %xmm4
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	-0x20(%rcx), %xmm0
paddd	%xmm6, %xmm0
sha256msg2	%xmm6, %xmm3
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm3, %xmm7
palignr	$0x4, %xmm6, %xmm7
nop
paddd	%xmm7, %xmm4
sha256msg1	%xmm6, %xmm5
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	(%rcx), %xmm0
paddd	%xmm3, %xmm0
sha256msg2	%xmm3, %xmm4
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm4, %xmm7
palignr	$0x4, %xmm3, %xmm7
nop
paddd	%xmm7, %xmm5
sha256msg1	%xmm3, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x20(%rcx), %xmm0
paddd	%xmm4, %xmm0
sha256msg2	%xmm4, %xmm5
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm5, %xmm7
palignr	$0x4, %xmm4, %xmm7
nop
paddd	%xmm7, %xmm6
sha256msg1	%xmm4, %xmm3
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x40(%rcx), %xmm0
paddd	%xmm5, %xmm0
sha256msg2	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm6, %xmm7
palignr	$0x4, %xmm5, %xmm7
nop
paddd	%xmm7, %xmm3
sha256msg1	%xmm5, %xmm4
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x60(%rcx), %xmm0
paddd	%xmm6, %xmm0
sha256msg2	%xmm6, %xmm3
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm3, %xmm7
palignr	$0x4, %xmm6, %xmm7
nop
paddd	%xmm7, %xmm4
sha256msg1	%xmm6, %xmm5
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x80(%rcx), %xmm0
paddd	%xmm3, %xmm0
sha256msg2	%xmm3, %xmm4
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm4, %xmm7
palignr	$0x4, %xmm3, %xmm7
nop
paddd	%xmm7, %xmm5
sha256msg1	%xmm3, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0xa0(%rcx), %xmm0
paddd	%xmm4, %xmm0
sha256msg2	%xmm4, %xmm5
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm5, %xmm7
palignr	$0x4, %xmm4, %xmm7
nop
paddd	%xmm7, %xmm6
sha256msg1	%xmm4, %xmm3
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0xc0(%rcx), %xmm0
paddd	%xmm5, %xmm0
sha256msg2	%xmm5, %xmm6
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm6, %xmm7
palignr	$0x4, %xmm5, %xmm7
nop
paddd	%xmm7, %xmm3
sha256msg1	%xmm5, %xmm4
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0xe0(%rcx), %xmm0
paddd	%xmm6, %xmm0
sha256msg2	%xmm6, %xmm3
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm3, %xmm7
palignr	$0x4, %xmm6, %xmm7
nop
paddd	%xmm7, %xmm4
sha256msg1	%xmm6, %xmm5
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x100(%rcx), %xmm0
paddd	%xmm3, %xmm0
sha256msg2	%xmm3, %xmm4
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm4, %xmm7
palignr	$0x4, %xmm3, %xmm7
nop
paddd	%xmm7, %xmm5
sha256msg1	%xmm3, %xmm6
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x120(%rcx), %xmm0
paddd	%xmm4, %xmm0
sha256msg2	%xmm4, %xmm5
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
movdqa	%xmm5, %xmm7
palignr	$0x4, %xmm4, %xmm7
sha256rnds2	%xmm0, %xmm2, %xmm1
paddd	%xmm7, %xmm6
movdqa	0x140(%rcx), %xmm0
paddd	%xmm5, %xmm0
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
sha256msg2	%xmm5, %xmm6
movdqa	%xmm8, %xmm7
sha256rnds2	%xmm0, %xmm2, %xmm1
movdqa	0x160(%rcx), %xmm0
paddd	%xmm6, %xmm0
nop
sha256rnds2	%xmm0, %xmm1, %xmm2
pshufd	$0xe, %xmm0, %xmm0
decq	%rdx
nop
sha256rnds2	%xmm0, %xmm2, %xmm1
paddd	%xmm10, %xmm2
paddd	%xmm9, %xmm1
jne	L_1240
pshufd	$0xb1, %xmm2, %xmm2
pshufd	$0x1b, %xmm1, %xmm7
pshufd	$0xb1, %xmm1, %xmm1
punpckhqdq	%xmm2, %xmm1
palignr	$0x8, %xmm7, %xmm2
movdqu	%xmm1, (%rdi)
movdqu	%xmm2, 0x10(%rdi)
rep	retq
nop
sha256_block_data_order_ssse3:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shlq	$0x4, %rdx
subq	$0x60, %rsp
leaq	(%rsi,%rdx,4), %rdx
andq	$-0x40, %rsp
movq	%rdi, 0x40(%rsp)
movq	%rsi, 0x48(%rsp)
movq	%rdx, 0x50(%rsp)
movq	%rax, 0x58(%rsp)
movl	(%rdi), %eax
movl	0x4(%rdi), %ebx
movl	0x8(%rdi), %ecx
movl	0xc(%rdi), %edx
movl	0x10(%rdi), %r8d
movl	0x14(%rdi), %r9d
movl	0x18(%rdi), %r10d
movl	0x1c(%rdi), %r11d
jmp	L_1590
nop
L_1590:
movdqa	K256+512(%rip), %xmm7
movdqu	(%rsi), %xmm0
movdqu	0x10(%rsi), %xmm1
movdqu	0x20(%rsi), %xmm2
pshufb	%xmm7, %xmm0
movdqu	0x30(%rsi), %xmm3
leaq	K256(%rip), %rbp
pshufb	%xmm7, %xmm1
movdqa	(%rbp), %xmm4
movdqa	0x20(%rbp), %xmm5
pshufb	%xmm7, %xmm2
paddd	%xmm0, %xmm4
movdqa	0x40(%rbp), %xmm6
pshufb	%xmm7, %xmm3
movdqa	0x60(%rbp), %xmm7
paddd	%xmm1, %xmm5
paddd	%xmm2, %xmm6
paddd	%xmm3, %xmm7
movdqa	%xmm4, (%rsp)
movl	%eax, %r14d
movdqa	%xmm5, 0x10(%rsp)
movl	%ebx, %edi
movdqa	%xmm6, 0x20(%rsp)
xorl	%ecx, %edi
movdqa	%xmm7, 0x30(%rsp)
movl	%r8d, %r13d
jmp	L_1610
nopl	(%rax)
L_1610:
subq	$-0x80, %rbp
rorl	$0xe, %r13d
movdqa	%xmm1, %xmm4
movl	%r14d, %eax
movl	%r9d, %r12d
movdqa	%xmm3, %xmm7
rorl	$0x9, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
rorl	$0x5, %r13d
xorl	%eax, %r14d
palignr	$0x4, %xmm0, %xmm4
andl	%r8d, %r12d
xorl	%r8d, %r13d
palignr	$0x4, %xmm2, %xmm7
addl	(%rsp), %r11d
movl	%eax, %r15d
xorl	%r10d, %r12d
rorl	$0xb, %r14d
movdqa	%xmm4, %xmm5
xorl	%ebx, %r15d
addl	%r12d, %r11d
movdqa	%xmm4, %xmm6
rorl	$0x6, %r13d
andl	%r15d, %edi
psrld	$0x3, %xmm4
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
paddd	%xmm7, %xmm0
rorl	$0x2, %r14d
addl	%r11d, %edx
psrld	$0x7, %xmm6
addl	%edi, %r11d
movl	%edx, %r13d
pshufd	$0xfa, %xmm3, %xmm7
addl	%r11d, %r14d
rorl	$0xe, %r13d
pslld	$0xe, %xmm5
movl	%r14d, %r11d
movl	%r8d, %r12d
pxor	%xmm6, %xmm4
rorl	$0x9, %r14d
xorl	%edx, %r13d
xorl	%r9d, %r12d
rorl	$0x5, %r13d
psrld	$0xb, %xmm6
xorl	%r11d, %r14d
pxor	%xmm5, %xmm4
andl	%edx, %r12d
xorl	%edx, %r13d
pslld	$0xb, %xmm5
addl	0x4(%rsp), %r10d
movl	%r11d, %edi
pxor	%xmm6, %xmm4
xorl	%r9d, %r12d
rorl	$0xb, %r14d
movdqa	%xmm7, %xmm6
xorl	%eax, %edi
addl	%r12d, %r10d
pxor	%xmm5, %xmm4
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
psrld	$0xa, %xmm7
addl	%r13d, %r10d
xorl	%eax, %r15d
paddd	%xmm4, %xmm0
rorl	$0x2, %r14d
addl	%r10d, %ecx
psrlq	$0x11, %xmm6
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
pxor	%xmm6, %xmm7
rorl	$0xe, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
rorl	$0x9, %r14d
psrlq	$0x2, %xmm6
xorl	%ecx, %r13d
xorl	%r8d, %r12d
pxor	%xmm6, %xmm7
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
pshufd	$0x80, %xmm7, %xmm7
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
movl	%r10d, %r15d
psrldq	$0x8, %xmm7
xorl	%r8d, %r12d
rorl	$0xb, %r14d
xorl	%r11d, %r15d
addl	%r12d, %r9d
rorl	$0x6, %r13d
paddd	%xmm7, %xmm0
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
pshufd	$0x50, %xmm0, %xmm7
xorl	%r11d, %edi
rorl	$0x2, %r14d
addl	%r9d, %ebx
movdqa	%xmm7, %xmm6
addl	%edi, %r9d
movl	%ebx, %r13d
psrld	$0xa, %xmm7
addl	%r9d, %r14d
rorl	$0xe, %r13d
psrlq	$0x11, %xmm6
movl	%r14d, %r9d
movl	%ecx, %r12d
pxor	%xmm6, %xmm7
rorl	$0x9, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
psrlq	$0x2, %xmm6
andl	%ebx, %r12d
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
pxor	%xmm6, %xmm7
movl	%r9d, %edi
xorl	%edx, %r12d
rorl	$0xb, %r14d
pshufd	$0x8, %xmm7, %xmm7
xorl	%r10d, %edi
addl	%r12d, %r8d
movdqa	(%rbp), %xmm6
rorl	$0x6, %r13d
andl	%edi, %r15d
pslldq	$0x8, %xmm7
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
paddd	%xmm7, %xmm0
rorl	$0x2, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
paddd	%xmm0, %xmm6
movl	%eax, %r13d
addl	%r8d, %r14d
movdqa	%xmm6, (%rsp)
rorl	$0xe, %r13d
movdqa	%xmm2, %xmm4
movl	%r14d, %r8d
movl	%ebx, %r12d
movdqa	%xmm0, %xmm7
rorl	$0x9, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
rorl	$0x5, %r13d
xorl	%r8d, %r14d
palignr	$0x4, %xmm1, %xmm4
andl	%eax, %r12d
xorl	%eax, %r13d
palignr	$0x4, %xmm3, %xmm7
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
xorl	%ecx, %r12d
rorl	$0xb, %r14d
movdqa	%xmm4, %xmm5
xorl	%r9d, %r15d
addl	%r12d, %edx
movdqa	%xmm4, %xmm6
rorl	$0x6, %r13d
andl	%r15d, %edi
psrld	$0x3, %xmm4
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
paddd	%xmm7, %xmm1
rorl	$0x2, %r14d
addl	%edx, %r11d
psrld	$0x7, %xmm6
addl	%edi, %edx
movl	%r11d, %r13d
pshufd	$0xfa, %xmm0, %xmm7
addl	%edx, %r14d
rorl	$0xe, %r13d
pslld	$0xe, %xmm5
movl	%r14d, %edx
movl	%eax, %r12d
pxor	%xmm6, %xmm4
rorl	$0x9, %r14d
xorl	%r11d, %r13d
xorl	%ebx, %r12d
rorl	$0x5, %r13d
psrld	$0xb, %xmm6
xorl	%edx, %r14d
pxor	%xmm5, %xmm4
andl	%r11d, %r12d
xorl	%r11d, %r13d
pslld	$0xb, %xmm5
addl	0x14(%rsp), %ecx
movl	%edx, %edi
pxor	%xmm6, %xmm4
xorl	%ebx, %r12d
rorl	$0xb, %r14d
movdqa	%xmm7, %xmm6
xorl	%r8d, %edi
addl	%r12d, %ecx
pxor	%xmm5, %xmm4
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
psrld	$0xa, %xmm7
addl	%r13d, %ecx
xorl	%r8d, %r15d
paddd	%xmm4, %xmm1
rorl	$0x2, %r14d
addl	%ecx, %r10d
psrlq	$0x11, %xmm6
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
pxor	%xmm6, %xmm7
rorl	$0xe, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
rorl	$0x9, %r14d
psrlq	$0x2, %xmm6
xorl	%r10d, %r13d
xorl	%eax, %r12d
pxor	%xmm6, %xmm7
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
pshufd	$0x80, %xmm7, %xmm7
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
movl	%ecx, %r15d
psrldq	$0x8, %xmm7
xorl	%eax, %r12d
rorl	$0xb, %r14d
xorl	%edx, %r15d
addl	%r12d, %ebx
rorl	$0x6, %r13d
paddd	%xmm7, %xmm1
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
pshufd	$0x50, %xmm1, %xmm7
xorl	%edx, %edi
rorl	$0x2, %r14d
addl	%ebx, %r9d
movdqa	%xmm7, %xmm6
addl	%edi, %ebx
movl	%r9d, %r13d
psrld	$0xa, %xmm7
addl	%ebx, %r14d
rorl	$0xe, %r13d
psrlq	$0x11, %xmm6
movl	%r14d, %ebx
movl	%r10d, %r12d
pxor	%xmm6, %xmm7
rorl	$0x9, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
psrlq	$0x2, %xmm6
andl	%r9d, %r12d
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
pxor	%xmm6, %xmm7
movl	%ebx, %edi
xorl	%r11d, %r12d
rorl	$0xb, %r14d
pshufd	$0x8, %xmm7, %xmm7
xorl	%ecx, %edi
addl	%r12d, %eax
movdqa	0x20(%rbp), %xmm6
rorl	$0x6, %r13d
andl	%edi, %r15d
pslldq	$0x8, %xmm7
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
paddd	%xmm7, %xmm1
rorl	$0x2, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
paddd	%xmm1, %xmm6
movl	%r8d, %r13d
addl	%eax, %r14d
movdqa	%xmm6, 0x10(%rsp)
rorl	$0xe, %r13d
movdqa	%xmm3, %xmm4
movl	%r14d, %eax
movl	%r9d, %r12d
movdqa	%xmm1, %xmm7
rorl	$0x9, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
rorl	$0x5, %r13d
xorl	%eax, %r14d
palignr	$0x4, %xmm2, %xmm4
andl	%r8d, %r12d
xorl	%r8d, %r13d
palignr	$0x4, %xmm0, %xmm7
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
xorl	%r10d, %r12d
rorl	$0xb, %r14d
movdqa	%xmm4, %xmm5
xorl	%ebx, %r15d
addl	%r12d, %r11d
movdqa	%xmm4, %xmm6
rorl	$0x6, %r13d
andl	%r15d, %edi
psrld	$0x3, %xmm4
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
paddd	%xmm7, %xmm2
rorl	$0x2, %r14d
addl	%r11d, %edx
psrld	$0x7, %xmm6
addl	%edi, %r11d
movl	%edx, %r13d
pshufd	$0xfa, %xmm1, %xmm7
addl	%r11d, %r14d
rorl	$0xe, %r13d
pslld	$0xe, %xmm5
movl	%r14d, %r11d
movl	%r8d, %r12d
pxor	%xmm6, %xmm4
rorl	$0x9, %r14d
xorl	%edx, %r13d
xorl	%r9d, %r12d
rorl	$0x5, %r13d
psrld	$0xb, %xmm6
xorl	%r11d, %r14d
pxor	%xmm5, %xmm4
andl	%edx, %r12d
xorl	%edx, %r13d
pslld	$0xb, %xmm5
addl	0x24(%rsp), %r10d
movl	%r11d, %edi
pxor	%xmm6, %xmm4
xorl	%r9d, %r12d
rorl	$0xb, %r14d
movdqa	%xmm7, %xmm6
xorl	%eax, %edi
addl	%r12d, %r10d
pxor	%xmm5, %xmm4
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
psrld	$0xa, %xmm7
addl	%r13d, %r10d
xorl	%eax, %r15d
paddd	%xmm4, %xmm2
rorl	$0x2, %r14d
addl	%r10d, %ecx
psrlq	$0x11, %xmm6
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
pxor	%xmm6, %xmm7
rorl	$0xe, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
rorl	$0x9, %r14d
psrlq	$0x2, %xmm6
xorl	%ecx, %r13d
xorl	%r8d, %r12d
pxor	%xmm6, %xmm7
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
pshufd	$0x80, %xmm7, %xmm7
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
movl	%r10d, %r15d
psrldq	$0x8, %xmm7
xorl	%r8d, %r12d
rorl	$0xb, %r14d
xorl	%r11d, %r15d
addl	%r12d, %r9d
rorl	$0x6, %r13d
paddd	%xmm7, %xmm2
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
pshufd	$0x50, %xmm2, %xmm7
xorl	%r11d, %edi
rorl	$0x2, %r14d
addl	%r9d, %ebx
movdqa	%xmm7, %xmm6
addl	%edi, %r9d
movl	%ebx, %r13d
psrld	$0xa, %xmm7
addl	%r9d, %r14d
rorl	$0xe, %r13d
psrlq	$0x11, %xmm6
movl	%r14d, %r9d
movl	%ecx, %r12d
pxor	%xmm6, %xmm7
rorl	$0x9, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
psrlq	$0x2, %xmm6
andl	%ebx, %r12d
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
pxor	%xmm6, %xmm7
movl	%r9d, %edi
xorl	%edx, %r12d
rorl	$0xb, %r14d
pshufd	$0x8, %xmm7, %xmm7
xorl	%r10d, %edi
addl	%r12d, %r8d
movdqa	0x40(%rbp), %xmm6
rorl	$0x6, %r13d
andl	%edi, %r15d
pslldq	$0x8, %xmm7
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
paddd	%xmm7, %xmm2
rorl	$0x2, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
paddd	%xmm2, %xmm6
movl	%eax, %r13d
addl	%r8d, %r14d
movdqa	%xmm6, 0x20(%rsp)
rorl	$0xe, %r13d
movdqa	%xmm0, %xmm4
movl	%r14d, %r8d
movl	%ebx, %r12d
movdqa	%xmm2, %xmm7
rorl	$0x9, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
rorl	$0x5, %r13d
xorl	%r8d, %r14d
palignr	$0x4, %xmm3, %xmm4
andl	%eax, %r12d
xorl	%eax, %r13d
palignr	$0x4, %xmm1, %xmm7
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
xorl	%ecx, %r12d
rorl	$0xb, %r14d
movdqa	%xmm4, %xmm5
xorl	%r9d, %r15d
addl	%r12d, %edx
movdqa	%xmm4, %xmm6
rorl	$0x6, %r13d
andl	%r15d, %edi
psrld	$0x3, %xmm4
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
paddd	%xmm7, %xmm3
rorl	$0x2, %r14d
addl	%edx, %r11d
psrld	$0x7, %xmm6
addl	%edi, %edx
movl	%r11d, %r13d
pshufd	$0xfa, %xmm2, %xmm7
addl	%edx, %r14d
rorl	$0xe, %r13d
pslld	$0xe, %xmm5
movl	%r14d, %edx
movl	%eax, %r12d
pxor	%xmm6, %xmm4
rorl	$0x9, %r14d
xorl	%r11d, %r13d
xorl	%ebx, %r12d
rorl	$0x5, %r13d
psrld	$0xb, %xmm6
xorl	%edx, %r14d
pxor	%xmm5, %xmm4
andl	%r11d, %r12d
xorl	%r11d, %r13d
pslld	$0xb, %xmm5
addl	0x34(%rsp), %ecx
movl	%edx, %edi
pxor	%xmm6, %xmm4
xorl	%ebx, %r12d
rorl	$0xb, %r14d
movdqa	%xmm7, %xmm6
xorl	%r8d, %edi
addl	%r12d, %ecx
pxor	%xmm5, %xmm4
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
psrld	$0xa, %xmm7
addl	%r13d, %ecx
xorl	%r8d, %r15d
paddd	%xmm4, %xmm3
rorl	$0x2, %r14d
addl	%ecx, %r10d
psrlq	$0x11, %xmm6
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
pxor	%xmm6, %xmm7
rorl	$0xe, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
rorl	$0x9, %r14d
psrlq	$0x2, %xmm6
xorl	%r10d, %r13d
xorl	%eax, %r12d
pxor	%xmm6, %xmm7
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
pshufd	$0x80, %xmm7, %xmm7
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
movl	%ecx, %r15d
psrldq	$0x8, %xmm7
xorl	%eax, %r12d
rorl	$0xb, %r14d
xorl	%edx, %r15d
addl	%r12d, %ebx
rorl	$0x6, %r13d
paddd	%xmm7, %xmm3
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
pshufd	$0x50, %xmm3, %xmm7
xorl	%edx, %edi
rorl	$0x2, %r14d
addl	%ebx, %r9d
movdqa	%xmm7, %xmm6
addl	%edi, %ebx
movl	%r9d, %r13d
psrld	$0xa, %xmm7
addl	%ebx, %r14d
rorl	$0xe, %r13d
psrlq	$0x11, %xmm6
movl	%r14d, %ebx
movl	%r10d, %r12d
pxor	%xmm6, %xmm7
rorl	$0x9, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
psrlq	$0x2, %xmm6
andl	%r9d, %r12d
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
pxor	%xmm6, %xmm7
movl	%ebx, %edi
xorl	%r11d, %r12d
rorl	$0xb, %r14d
pshufd	$0x8, %xmm7, %xmm7
xorl	%ecx, %edi
addl	%r12d, %eax
movdqa	0x60(%rbp), %xmm6
rorl	$0x6, %r13d
andl	%edi, %r15d
pslldq	$0x8, %xmm7
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
paddd	%xmm7, %xmm3
rorl	$0x2, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
paddd	%xmm3, %xmm6
movl	%r8d, %r13d
addl	%eax, %r14d
movdqa	%xmm6, 0x30(%rsp)
cmpb	$0x0, 0x83(%rbp)
jne	L_1610
rorl	$0xe, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
rorl	$0x9, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
rorl	$0x5, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
xorl	%r10d, %r12d
rorl	$0xb, %r14d
xorl	%ebx, %r15d
addl	%r12d, %r11d
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
rorl	$0x2, %r14d
addl	%r11d, %edx
addl	%edi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
rorl	$0x9, %r14d
xorl	%edx, %r13d
xorl	%r9d, %r12d
rorl	$0x5, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
xorl	%edx, %r13d
addl	0x4(%rsp), %r10d
movl	%r11d, %edi
xorl	%r9d, %r12d
rorl	$0xb, %r14d
xorl	%eax, %edi
addl	%r12d, %r10d
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
rorl	$0x2, %r14d
addl	%r10d, %ecx
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
rorl	$0x9, %r14d
xorl	%ecx, %r13d
xorl	%r8d, %r12d
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
movl	%r10d, %r15d
xorl	%r8d, %r12d
rorl	$0xb, %r14d
xorl	%r11d, %r15d
addl	%r12d, %r9d
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %edi
rorl	$0x2, %r14d
addl	%r9d, %ebx
addl	%edi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
rorl	$0x9, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %edi
xorl	%edx, %r12d
rorl	$0xb, %r14d
xorl	%r10d, %edi
addl	%r12d, %r8d
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
rorl	$0x2, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
rorl	$0x9, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
rorl	$0x5, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
xorl	%ecx, %r12d
rorl	$0xb, %r14d
xorl	%r9d, %r15d
addl	%r12d, %edx
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
rorl	$0x2, %r14d
addl	%edx, %r11d
addl	%edi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
rorl	$0x9, %r14d
xorl	%r11d, %r13d
xorl	%ebx, %r12d
rorl	$0x5, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
xorl	%r11d, %r13d
addl	0x14(%rsp), %ecx
movl	%edx, %edi
xorl	%ebx, %r12d
rorl	$0xb, %r14d
xorl	%r8d, %edi
addl	%r12d, %ecx
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
rorl	$0x2, %r14d
addl	%ecx, %r10d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
rorl	$0x9, %r14d
xorl	%r10d, %r13d
xorl	%eax, %r12d
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
movl	%ecx, %r15d
xorl	%eax, %r12d
rorl	$0xb, %r14d
xorl	%edx, %r15d
addl	%r12d, %ebx
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %edi
rorl	$0x2, %r14d
addl	%ebx, %r9d
addl	%edi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
rorl	$0x9, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %edi
xorl	%r11d, %r12d
rorl	$0xb, %r14d
xorl	%ecx, %edi
addl	%r12d, %eax
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
rorl	$0x2, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
rorl	$0xe, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
rorl	$0x9, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
rorl	$0x5, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
xorl	%r10d, %r12d
rorl	$0xb, %r14d
xorl	%ebx, %r15d
addl	%r12d, %r11d
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
rorl	$0x2, %r14d
addl	%r11d, %edx
addl	%edi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
rorl	$0x9, %r14d
xorl	%edx, %r13d
xorl	%r9d, %r12d
rorl	$0x5, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
xorl	%edx, %r13d
addl	0x24(%rsp), %r10d
movl	%r11d, %edi
xorl	%r9d, %r12d
rorl	$0xb, %r14d
xorl	%eax, %edi
addl	%r12d, %r10d
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
rorl	$0x2, %r14d
addl	%r10d, %ecx
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
rorl	$0x9, %r14d
xorl	%ecx, %r13d
xorl	%r8d, %r12d
rorl	$0x5, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
movl	%r10d, %r15d
xorl	%r8d, %r12d
rorl	$0xb, %r14d
xorl	%r11d, %r15d
addl	%r12d, %r9d
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %edi
rorl	$0x2, %r14d
addl	%r9d, %ebx
addl	%edi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
rorl	$0x9, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
rorl	$0x5, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %edi
xorl	%edx, %r12d
rorl	$0xb, %r14d
xorl	%r10d, %edi
addl	%r12d, %r8d
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
rorl	$0x2, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
rorl	$0xe, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
rorl	$0x9, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
rorl	$0x5, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
xorl	%ecx, %r12d
rorl	$0xb, %r14d
xorl	%r9d, %r15d
addl	%r12d, %edx
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
rorl	$0x2, %r14d
addl	%edx, %r11d
addl	%edi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
rorl	$0x9, %r14d
xorl	%r11d, %r13d
xorl	%ebx, %r12d
rorl	$0x5, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
xorl	%r11d, %r13d
addl	0x34(%rsp), %ecx
movl	%edx, %edi
xorl	%ebx, %r12d
rorl	$0xb, %r14d
xorl	%r8d, %edi
addl	%r12d, %ecx
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
rorl	$0x2, %r14d
addl	%ecx, %r10d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
rorl	$0x9, %r14d
xorl	%r10d, %r13d
xorl	%eax, %r12d
rorl	$0x5, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
movl	%ecx, %r15d
xorl	%eax, %r12d
rorl	$0xb, %r14d
xorl	%edx, %r15d
addl	%r12d, %ebx
rorl	$0x6, %r13d
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %edi
rorl	$0x2, %r14d
addl	%ebx, %r9d
addl	%edi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
rorl	$0xe, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
rorl	$0x9, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
rorl	$0x5, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %edi
xorl	%r11d, %r12d
rorl	$0xb, %r14d
xorl	%ecx, %edi
addl	%r12d, %eax
rorl	$0x6, %r13d
andl	%edi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
rorl	$0x2, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
movq	0x40(%rsp), %rdi
movl	%r14d, %eax
addl	(%rdi), %eax
leaq	0x40(%rsi), %rsi
addl	0x4(%rdi), %ebx
addl	0x8(%rdi), %ecx
addl	0xc(%rdi), %edx
addl	0x10(%rdi), %r8d
addl	0x14(%rdi), %r9d
addl	0x18(%rdi), %r10d
addl	0x1c(%rdi), %r11d
cmpq	0x50(%rsp), %rsi
movl	%eax, (%rdi)
movl	%ebx, 0x4(%rdi)
movl	%ecx, 0x8(%rdi)
movl	%edx, 0xc(%rdi)
movl	%r8d, 0x10(%rdi)
movl	%r9d, 0x14(%rdi)
movl	%r10d, 0x18(%rdi)
movl	%r11d, 0x1c(%rdi)
jb	L_1590
movq	0x58(%rsp), %rsi
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopl	(%rax)
sha256_block_data_order_avx:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
shlq	$0x4, %rdx
subq	$0x60, %rsp
leaq	(%rsi,%rdx,4), %rdx
andq	$-0x40, %rsp
movq	%rdi, 0x40(%rsp)
movq	%rsi, 0x48(%rsp)
movq	%rdx, 0x50(%rsp)
movq	%rax, 0x58(%rsp)
vzeroupper
movl	(%rdi), %eax
movl	0x4(%rdi), %ebx
movl	0x8(%rdi), %ecx
movl	0xc(%rdi), %edx
movl	0x10(%rdi), %r8d
movl	0x14(%rdi), %r9d
movl	0x18(%rdi), %r10d
movl	0x1c(%rdi), %r11d
vmovdqa	K256+544(%rip), %xmm8
vmovdqa	K256+576(%rip), %xmm9
jmp	L_2470
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_2470:
vmovdqa	K256+512(%rip), %xmm7
vmovdqu	(%rsi), %xmm0
vmovdqu	0x10(%rsi), %xmm1
vmovdqu	0x20(%rsi), %xmm2
vmovdqu	0x30(%rsi), %xmm3
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
movl	%ebx, %edi
vmovdqa	%xmm6, 0x20(%rsp)
xorl	%ecx, %edi
vmovdqa	%xmm7, 0x30(%rsp)
movl	%r8d, %r13d
jmp	L_24e0
nopl	(%rax)
L_24e0:
subq	$-0x80, %rbp
vpalignr	$0x4, %xmm0, %xmm1, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
vpalignr	$0x4, %xmm2, %xmm3, %xmm7
shrdl	$0x9, %r14d, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vpaddd	%xmm7, %xmm0, %xmm0
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
vpsrld	$0x3, %xmm4, %xmm7
xorl	%r10d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ebx, %r15d
vpslld	$0xe, %xmm4, %xmm5
addl	%r12d, %r11d
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
vpshufd	$0xfa, %xmm3, %xmm7
shrdl	$0x2, %r14d, %r14d
addl	%r11d, %edx
addl	%edi, %r11d
vpsrld	$0xb, %xmm6, %xmm6
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %r11d
movl	%r8d, %r12d
shrdl	$0x9, %r14d, %r14d
vpslld	$0xb, %xmm5, %xmm5
xorl	%edx, %r13d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%r11d, %r14d
andl	%edx, %r12d
xorl	%edx, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x4(%rsp), %r10d
movl	%r11d, %edi
xorl	%r9d, %r12d
vpxor	%xmm5, %xmm4, %xmm4
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %edi
addl	%r12d, %r10d
vpsrlq	$0x11, %xmm7, %xmm7
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
vpaddd	%xmm4, %xmm0, %xmm0
addl	%r13d, %r10d
xorl	%eax, %r15d
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%r10d, %ecx
addl	%r15d, %r10d
movl	%ecx, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
vpxor	%xmm7, %xmm6, %xmm6
movl	%edx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r13d
vpshufb	%xmm8, %xmm6, %xmm6
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
vpaddd	%xmm6, %xmm0, %xmm0
andl	%ecx, %r12d
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
vpshufd	$0x50, %xmm0, %xmm7
movl	%r10d, %r15d
xorl	%r8d, %r12d
shrdl	$0xb, %r14d, %r14d
vpsrld	$0xa, %xmm7, %xmm6
xorl	%r11d, %r15d
addl	%r12d, %r9d
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
vpxor	%xmm7, %xmm6, %xmm6
xorl	%r11d, %edi
shrdl	$0x2, %r14d, %r14d
addl	%r9d, %ebx
vpsrlq	$0x2, %xmm7, %xmm7
addl	%edi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
vpshufb	%xmm9, %xmm6, %xmm6
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
vpaddd	%xmm6, %xmm0, %xmm0
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vpaddd	(%rbp), %xmm0, %xmm6
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %edi
xorl	%edx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %edi
addl	%r12d, %r8d
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
vmovdqa	%xmm6, (%rsp)
vpalignr	$0x4, %xmm1, %xmm2, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
vpalignr	$0x4, %xmm3, %xmm0, %xmm7
shrdl	$0x9, %r14d, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vpaddd	%xmm7, %xmm1, %xmm1
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
vpsrld	$0x3, %xmm4, %xmm7
xorl	%ecx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r9d, %r15d
vpslld	$0xe, %xmm4, %xmm5
addl	%r12d, %edx
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
vpshufd	$0xfa, %xmm0, %xmm7
shrdl	$0x2, %r14d, %r14d
addl	%edx, %r11d
addl	%edi, %edx
vpsrld	$0xb, %xmm6, %xmm6
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %edx
movl	%eax, %r12d
shrdl	$0x9, %r14d, %r14d
vpslld	$0xb, %xmm5, %xmm5
xorl	%r11d, %r13d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%edx, %r14d
andl	%r11d, %r12d
xorl	%r11d, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x14(%rsp), %ecx
movl	%edx, %edi
xorl	%ebx, %r12d
vpxor	%xmm5, %xmm4, %xmm4
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %edi
addl	%r12d, %ecx
vpsrlq	$0x11, %xmm7, %xmm7
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
vpaddd	%xmm4, %xmm1, %xmm1
addl	%r13d, %ecx
xorl	%r8d, %r15d
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%ecx, %r10d
addl	%r15d, %ecx
movl	%r10d, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
vpxor	%xmm7, %xmm6, %xmm6
movl	%r11d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r13d
vpshufb	%xmm8, %xmm6, %xmm6
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
vpaddd	%xmm6, %xmm1, %xmm1
andl	%r10d, %r12d
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
vpshufd	$0x50, %xmm1, %xmm7
movl	%ecx, %r15d
xorl	%eax, %r12d
shrdl	$0xb, %r14d, %r14d
vpsrld	$0xa, %xmm7, %xmm6
xorl	%edx, %r15d
addl	%r12d, %ebx
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
vpxor	%xmm7, %xmm6, %xmm6
xorl	%edx, %edi
shrdl	$0x2, %r14d, %r14d
addl	%ebx, %r9d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%edi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
vpshufb	%xmm9, %xmm6, %xmm6
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
vpaddd	%xmm6, %xmm1, %xmm1
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpaddd	0x20(%rbp), %xmm1, %xmm6
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %edi
xorl	%r11d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %edi
addl	%r12d, %eax
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
vmovdqa	%xmm6, 0x10(%rsp)
vpalignr	$0x4, %xmm2, %xmm3, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
vpalignr	$0x4, %xmm0, %xmm1, %xmm7
shrdl	$0x9, %r14d, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
vpaddd	%xmm7, %xmm2, %xmm2
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
vpsrld	$0x3, %xmm4, %xmm7
xorl	%r10d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ebx, %r15d
vpslld	$0xe, %xmm4, %xmm5
addl	%r12d, %r11d
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
vpshufd	$0xfa, %xmm1, %xmm7
shrdl	$0x2, %r14d, %r14d
addl	%r11d, %edx
addl	%edi, %r11d
vpsrld	$0xb, %xmm6, %xmm6
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %r11d
movl	%r8d, %r12d
shrdl	$0x9, %r14d, %r14d
vpslld	$0xb, %xmm5, %xmm5
xorl	%edx, %r13d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%r11d, %r14d
andl	%edx, %r12d
xorl	%edx, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x24(%rsp), %r10d
movl	%r11d, %edi
xorl	%r9d, %r12d
vpxor	%xmm5, %xmm4, %xmm4
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %edi
addl	%r12d, %r10d
vpsrlq	$0x11, %xmm7, %xmm7
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
vpaddd	%xmm4, %xmm2, %xmm2
addl	%r13d, %r10d
xorl	%eax, %r15d
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%r10d, %ecx
addl	%r15d, %r10d
movl	%ecx, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
vpxor	%xmm7, %xmm6, %xmm6
movl	%edx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r13d
vpshufb	%xmm8, %xmm6, %xmm6
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
vpaddd	%xmm6, %xmm2, %xmm2
andl	%ecx, %r12d
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
vpshufd	$0x50, %xmm2, %xmm7
movl	%r10d, %r15d
xorl	%r8d, %r12d
shrdl	$0xb, %r14d, %r14d
vpsrld	$0xa, %xmm7, %xmm6
xorl	%r11d, %r15d
addl	%r12d, %r9d
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
vpxor	%xmm7, %xmm6, %xmm6
xorl	%r11d, %edi
shrdl	$0x2, %r14d, %r14d
addl	%r9d, %ebx
vpsrlq	$0x2, %xmm7, %xmm7
addl	%edi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
vpshufb	%xmm9, %xmm6, %xmm6
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
vpaddd	%xmm6, %xmm2, %xmm2
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
vpaddd	0x40(%rbp), %xmm2, %xmm6
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %edi
xorl	%edx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %edi
addl	%r12d, %r8d
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
vmovdqa	%xmm6, 0x20(%rsp)
vpalignr	$0x4, %xmm3, %xmm0, %xmm4
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
vpalignr	$0x4, %xmm1, %xmm2, %xmm7
shrdl	$0x9, %r14d, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
vpsrld	$0x7, %xmm4, %xmm6
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
vpaddd	%xmm7, %xmm3, %xmm3
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
vpsrld	$0x3, %xmm4, %xmm7
xorl	%ecx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r9d, %r15d
vpslld	$0xe, %xmm4, %xmm5
addl	%r12d, %edx
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
vpxor	%xmm6, %xmm7, %xmm4
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
vpshufd	$0xfa, %xmm2, %xmm7
shrdl	$0x2, %r14d, %r14d
addl	%edx, %r11d
addl	%edi, %edx
vpsrld	$0xb, %xmm6, %xmm6
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
vpxor	%xmm5, %xmm4, %xmm4
movl	%r14d, %edx
movl	%eax, %r12d
shrdl	$0x9, %r14d, %r14d
vpslld	$0xb, %xmm5, %xmm5
xorl	%r11d, %r13d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
vpxor	%xmm6, %xmm4, %xmm4
xorl	%edx, %r14d
andl	%r11d, %r12d
xorl	%r11d, %r13d
vpsrld	$0xa, %xmm7, %xmm6
addl	0x34(%rsp), %ecx
movl	%edx, %edi
xorl	%ebx, %r12d
vpxor	%xmm5, %xmm4, %xmm4
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %edi
addl	%r12d, %ecx
vpsrlq	$0x11, %xmm7, %xmm7
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
vpaddd	%xmm4, %xmm3, %xmm3
addl	%r13d, %ecx
xorl	%r8d, %r15d
shrdl	$0x2, %r14d, %r14d
vpxor	%xmm7, %xmm6, %xmm6
addl	%ecx, %r10d
addl	%r15d, %ecx
movl	%r10d, %r13d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
vpxor	%xmm7, %xmm6, %xmm6
movl	%r11d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r13d
vpshufb	%xmm8, %xmm6, %xmm6
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
vpaddd	%xmm6, %xmm3, %xmm3
andl	%r10d, %r12d
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
vpshufd	$0x50, %xmm3, %xmm7
movl	%ecx, %r15d
xorl	%eax, %r12d
shrdl	$0xb, %r14d, %r14d
vpsrld	$0xa, %xmm7, %xmm6
xorl	%edx, %r15d
addl	%r12d, %ebx
shrdl	$0x6, %r13d, %r13d
vpsrlq	$0x11, %xmm7, %xmm7
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
vpxor	%xmm7, %xmm6, %xmm6
xorl	%edx, %edi
shrdl	$0x2, %r14d, %r14d
addl	%ebx, %r9d
vpsrlq	$0x2, %xmm7, %xmm7
addl	%edi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
vpxor	%xmm7, %xmm6, %xmm6
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
vpshufb	%xmm9, %xmm6, %xmm6
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
vpaddd	%xmm6, %xmm3, %xmm3
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
vpaddd	0x60(%rbp), %xmm3, %xmm6
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %edi
xorl	%r11d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %edi
addl	%r12d, %eax
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
vmovdqa	%xmm6, 0x30(%rsp)
cmpb	$0x0, 0x83(%rbp)
jne	L_24e0
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
xorl	%r8d, %r13d
addl	(%rsp), %r11d
movl	%eax, %r15d
xorl	%r10d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ebx, %r15d
addl	%r12d, %r11d
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
shrdl	$0x2, %r14d, %r14d
addl	%r11d, %edx
addl	%edi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%edx, %r13d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
xorl	%edx, %r13d
addl	0x4(%rsp), %r10d
movl	%r11d, %edi
xorl	%r9d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %edi
addl	%r12d, %r10d
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%r10d, %ecx
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r13d
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
xorl	%ecx, %r13d
addl	0x8(%rsp), %r9d
movl	%r10d, %r15d
xorl	%r8d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r11d, %r15d
addl	%r12d, %r9d
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %edi
shrdl	$0x2, %r14d, %r14d
addl	%r9d, %ebx
addl	%edi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
xorl	%ebx, %r13d
addl	0xc(%rsp), %r8d
movl	%r9d, %edi
xorl	%edx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %edi
addl	%r12d, %r8d
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
xorl	%eax, %r13d
addl	0x10(%rsp), %edx
movl	%r8d, %r15d
xorl	%ecx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r9d, %r15d
addl	%r12d, %edx
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
shrdl	$0x2, %r14d, %r14d
addl	%edx, %r11d
addl	%edi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r11d, %r13d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
xorl	%r11d, %r13d
addl	0x14(%rsp), %ecx
movl	%edx, %edi
xorl	%ebx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %edi
addl	%r12d, %ecx
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%ecx, %r10d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r13d
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
xorl	%r10d, %r13d
addl	0x18(%rsp), %ebx
movl	%ecx, %r15d
xorl	%eax, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%edx, %r15d
addl	%r12d, %ebx
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %edi
shrdl	$0x2, %r14d, %r14d
addl	%ebx, %r9d
addl	%edi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
xorl	%r9d, %r13d
addl	0x1c(%rsp), %eax
movl	%ebx, %edi
xorl	%r11d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %edi
addl	%r12d, %eax
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %eax
movl	%r9d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r8d, %r13d
xorl	%r10d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%eax, %r14d
andl	%r8d, %r12d
xorl	%r8d, %r13d
addl	0x20(%rsp), %r11d
movl	%eax, %r15d
xorl	%r10d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ebx, %r15d
addl	%r12d, %r11d
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%eax, %r14d
addl	%r13d, %r11d
xorl	%ebx, %edi
shrdl	$0x2, %r14d, %r14d
addl	%r11d, %edx
addl	%edi, %r11d
movl	%edx, %r13d
addl	%r11d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r11d
movl	%r8d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%edx, %r13d
xorl	%r9d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r11d, %r14d
andl	%edx, %r12d
xorl	%edx, %r13d
addl	0x24(%rsp), %r10d
movl	%r11d, %edi
xorl	%r9d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%eax, %edi
addl	%r12d, %r10d
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r11d, %r14d
addl	%r13d, %r10d
xorl	%eax, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%r10d, %ecx
addl	%r15d, %r10d
movl	%ecx, %r13d
addl	%r10d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r10d
movl	%edx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%ecx, %r13d
xorl	%r8d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r10d, %r14d
andl	%ecx, %r12d
xorl	%ecx, %r13d
addl	0x28(%rsp), %r9d
movl	%r10d, %r15d
xorl	%r8d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r11d, %r15d
addl	%r12d, %r9d
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%r10d, %r14d
addl	%r13d, %r9d
xorl	%r11d, %edi
shrdl	$0x2, %r14d, %r14d
addl	%r9d, %ebx
addl	%edi, %r9d
movl	%ebx, %r13d
addl	%r9d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r9d
movl	%ecx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%ebx, %r13d
xorl	%edx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r9d, %r14d
andl	%ebx, %r12d
xorl	%ebx, %r13d
addl	0x2c(%rsp), %r8d
movl	%r9d, %edi
xorl	%edx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r10d, %edi
addl	%r12d, %r8d
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%r9d, %r14d
addl	%r13d, %r8d
xorl	%r10d, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%r8d, %eax
addl	%r15d, %r8d
movl	%eax, %r13d
addl	%r8d, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %r8d
movl	%ebx, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%eax, %r13d
xorl	%ecx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%r8d, %r14d
andl	%eax, %r12d
xorl	%eax, %r13d
addl	0x30(%rsp), %edx
movl	%r8d, %r15d
xorl	%ecx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r9d, %r15d
addl	%r12d, %edx
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%r8d, %r14d
addl	%r13d, %edx
xorl	%r9d, %edi
shrdl	$0x2, %r14d, %r14d
addl	%edx, %r11d
addl	%edi, %edx
movl	%r11d, %r13d
addl	%edx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %edx
movl	%eax, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r11d, %r13d
xorl	%ebx, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%edx, %r14d
andl	%r11d, %r12d
xorl	%r11d, %r13d
addl	0x34(%rsp), %ecx
movl	%edx, %edi
xorl	%ebx, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%r8d, %edi
addl	%r12d, %ecx
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%edx, %r14d
addl	%r13d, %ecx
xorl	%r8d, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%ecx, %r10d
addl	%r15d, %ecx
movl	%r10d, %r13d
addl	%ecx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ecx
movl	%r11d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r10d, %r13d
xorl	%eax, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ecx, %r14d
andl	%r10d, %r12d
xorl	%r10d, %r13d
addl	0x38(%rsp), %ebx
movl	%ecx, %r15d
xorl	%eax, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%edx, %r15d
addl	%r12d, %ebx
shrdl	$0x6, %r13d, %r13d
andl	%r15d, %edi
xorl	%ecx, %r14d
addl	%r13d, %ebx
xorl	%edx, %edi
shrdl	$0x2, %r14d, %r14d
addl	%ebx, %r9d
addl	%edi, %ebx
movl	%r9d, %r13d
addl	%ebx, %r14d
shrdl	$0xe, %r13d, %r13d
movl	%r14d, %ebx
movl	%r10d, %r12d
shrdl	$0x9, %r14d, %r14d
xorl	%r9d, %r13d
xorl	%r11d, %r12d
shrdl	$0x5, %r13d, %r13d
xorl	%ebx, %r14d
andl	%r9d, %r12d
xorl	%r9d, %r13d
addl	0x3c(%rsp), %eax
movl	%ebx, %edi
xorl	%r11d, %r12d
shrdl	$0xb, %r14d, %r14d
xorl	%ecx, %edi
addl	%r12d, %eax
shrdl	$0x6, %r13d, %r13d
andl	%edi, %r15d
xorl	%ebx, %r14d
addl	%r13d, %eax
xorl	%ecx, %r15d
shrdl	$0x2, %r14d, %r14d
addl	%eax, %r8d
addl	%r15d, %eax
movl	%r8d, %r13d
addl	%eax, %r14d
movq	0x40(%rsp), %rdi
movl	%r14d, %eax
addl	(%rdi), %eax
leaq	0x40(%rsi), %rsi
addl	0x4(%rdi), %ebx
addl	0x8(%rdi), %ecx
addl	0xc(%rdi), %edx
addl	0x10(%rdi), %r8d
addl	0x14(%rdi), %r9d
addl	0x18(%rdi), %r10d
addl	0x1c(%rdi), %r11d
cmpq	0x50(%rsp), %rsi
movl	%eax, (%rdi)
movl	%ebx, 0x4(%rdi)
movl	%ecx, 0x8(%rdi)
movl	%edx, 0xc(%rdi)
movl	%r8d, 0x10(%rdi)
movl	%r9d, 0x14(%rdi)
movl	%r10d, 0x18(%rdi)
movl	%r11d, 0x1c(%rdi)
jb	L_2470
movq	0x58(%rsp), %rsi
vzeroupper
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopl	(%rax,%rax)
sha256_block_data_order_avx2:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x220, %rsp
shlq	$0x4, %rdx
andq	$-0x400, %rsp
leaq	(%rsi,%rdx,4), %rdx
addq	$0x1c0, %rsp
movq	%rdi, 0x40(%rsp)
movq	%rsi, 0x48(%rsp)
movq	%rdx, 0x50(%rsp)
movq	%rax, 0x58(%rsp)
vzeroupper
subq	$-0x40, %rsi
movl	(%rdi), %eax
movq	%rsi, %r12
movl	0x4(%rdi), %ebx
cmpq	%rdx, %rsi
movl	0x8(%rdi), %ecx
cmoveq	%rsp, %r12
movl	0xc(%rdi), %edx
movl	0x10(%rdi), %r8d
movl	0x14(%rdi), %r9d
movl	0x18(%rdi), %r10d
movl	0x1c(%rdi), %r11d
vmovdqa	K256+544(%rip), %ymm8
vmovdqa	K256+576(%rip), %ymm9
jmp	L_3380
nopl	(%rax)
L_3380:
vmovdqa	K256+512(%rip), %ymm7
vmovdqu	-0x40(%rsi), %xmm0
vmovdqu	-0x30(%rsi), %xmm1
vmovdqu	-0x20(%rsi), %xmm2
vmovdqu	-0x10(%rsi), %xmm3
vinserti128	$0x1, (%r12), %ymm0, %ymm0
vinserti128	$0x1, 0x10(%r12), %ymm1, %ymm1
vpshufb	%ymm7, %ymm0, %ymm0
vinserti128	$0x1, 0x20(%r12), %ymm2, %ymm2
vpshufb	%ymm7, %ymm1, %ymm1
vinserti128	$0x1, 0x30(%r12), %ymm3, %ymm3
leaq	K256(%rip), %rbp
vpshufb	%ymm7, %ymm2, %ymm2
vpaddd	(%rbp), %ymm0, %ymm4
vpshufb	%ymm7, %ymm3, %ymm3
vpaddd	0x20(%rbp), %ymm1, %ymm5
vpaddd	0x40(%rbp), %ymm2, %ymm6
vpaddd	0x60(%rbp), %ymm3, %ymm7
vmovdqa	%ymm4, (%rsp)
xorl	%r14d, %r14d
vmovdqa	%ymm5, 0x20(%rsp)
movq	0x58(%rsp), %rdi
leaq	-0x40(%rsp), %rsp
movq	%rdi, -0x8(%rsp)
movl	%ebx, %edi
vmovdqa	%ymm6, (%rsp)
xorl	%ecx, %edi
vmovdqa	%ymm7, 0x20(%rsp)
movl	%r9d, %r12d
subq	$-0x80, %rbp
jmp	L_3420
nop
L_3420:
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%ebx, %edi
vpshufd	$0xfa, %ymm3, %ymm7
xorl	%r13d, %r14d
leal	(%r11,%rdi), %r11d
movl	%r8d, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0x84(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %edx, %edi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
vpslld	$0xb, %ymm5, %ymm5
andnl	%r9d, %edx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %edx, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %edi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %edi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
vpsrlq	$0x11, %ymm7, %ymm7
andl	%edi, %r15d
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
vpshufb	%ymm8, %ymm6, %ymm6
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
vpaddd	%ymm6, %ymm0, %ymm0
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
vpshufd	$0x50, %ymm0, %ymm7
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
vpsrld	$0xa, %ymm7, %ymm6
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r11d, %edi
vpsrlq	$0x11, %ymm7, %ymm7
xorl	%r13d, %r14d
leal	(%r9,%rdi), %r9d
movl	%ecx, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0x8c(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %ebx, %edi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
vpxor	%ymm7, %ymm6, %ymm6
andnl	%edx, %ebx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %ebx, %r14d
vpshufb	%ymm9, %ymm6, %ymm6
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %edi
vpaddd	%ymm6, %ymm0, %ymm0
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %edi
vpaddd	(%rbp), %ymm0, %ymm6
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%edi, %r15d
xorl	%r12d, %r14d
xorl	%r10d, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r9d, %edi
vpshufd	$0xfa, %ymm0, %ymm7
xorl	%r13d, %r14d
leal	(%rdx,%rdi), %edx
movl	%eax, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0xa4(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %r11d, %edi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
vpslld	$0xb, %ymm5, %ymm5
andnl	%ebx, %r11d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r11d, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %edi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %edi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
vpsrlq	$0x11, %ymm7, %ymm7
andl	%edi, %r15d
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
vpshufb	%ymm8, %ymm6, %ymm6
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
vpaddd	%ymm6, %ymm1, %ymm1
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
vpshufd	$0x50, %ymm1, %ymm7
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
vpsrld	$0xa, %ymm7, %ymm6
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%edx, %edi
vpsrlq	$0x11, %ymm7, %ymm7
xorl	%r13d, %r14d
leal	(%rbx,%rdi), %ebx
movl	%r10d, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0xac(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %r9d, %edi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
vpxor	%ymm7, %ymm6, %ymm6
andnl	%r11d, %r9d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r9d, %r14d
vpshufb	%ymm9, %ymm6, %ymm6
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %edi
vpaddd	%ymm6, %ymm1, %ymm1
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %edi
vpaddd	0x20(%rbp), %ymm1, %ymm6
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%edi, %r15d
xorl	%r12d, %r14d
xorl	%ecx, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%ebx, %edi
vpshufd	$0xfa, %ymm1, %ymm7
xorl	%r13d, %r14d
leal	(%r11,%rdi), %r11d
movl	%r8d, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0x84(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %edx, %edi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
vpslld	$0xb, %ymm5, %ymm5
andnl	%r9d, %edx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %edx, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %edi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %edi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
vpsrlq	$0x11, %ymm7, %ymm7
andl	%edi, %r15d
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
vpshufb	%ymm8, %ymm6, %ymm6
leal	(%r9,%r12), %r9d
xorl	%r14d, %r13d
movl	%r10d, %r15d
vpaddd	%ymm6, %ymm2, %ymm2
rorxl	$0x16, %r10d, %r12d
leal	(%r9,%r13), %r9d
xorl	%r11d, %r15d
vpshufd	$0x50, %ymm2, %ymm7
rorxl	$0xd, %r10d, %r14d
rorxl	$0x2, %r10d, %r13d
leal	(%rbx,%r9), %ebx
vpsrld	$0xa, %ymm7, %ymm6
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r11d, %edi
vpsrlq	$0x11, %ymm7, %ymm7
xorl	%r13d, %r14d
leal	(%r9,%rdi), %r9d
movl	%ecx, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0x8c(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %ebx, %edi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
vpxor	%ymm7, %ymm6, %ymm6
andnl	%edx, %ebx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %ebx, %r14d
vpshufb	%ymm9, %ymm6, %ymm6
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %edi
vpaddd	%ymm6, %ymm2, %ymm2
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %edi
vpaddd	0x40(%rbp), %ymm2, %ymm6
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%edi, %r15d
xorl	%r12d, %r14d
xorl	%r10d, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r9d, %edi
vpshufd	$0xfa, %ymm2, %ymm7
xorl	%r13d, %r14d
leal	(%rdx,%rdi), %edx
movl	%eax, %r12d
vpsrld	$0xb, %ymm6, %ymm6
addl	0xa4(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xb, %r11d, %edi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
vpslld	$0xb, %ymm5, %ymm5
andnl	%ebx, %r11d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r11d, %r14d
vpxor	%ymm6, %ymm4, %ymm4
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %edi
vpsrld	$0xa, %ymm7, %ymm6
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %edi
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
vpsrlq	$0x11, %ymm7, %ymm7
andl	%edi, %r15d
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
vpshufb	%ymm8, %ymm6, %ymm6
leal	(%rbx,%r12), %ebx
xorl	%r14d, %r13d
movl	%ecx, %r15d
vpaddd	%ymm6, %ymm3, %ymm3
rorxl	$0x16, %ecx, %r12d
leal	(%rbx,%r13), %ebx
xorl	%edx, %r15d
vpshufd	$0x50, %ymm3, %ymm7
rorxl	$0xd, %ecx, %r14d
rorxl	$0x2, %ecx, %r13d
leal	(%r9,%rbx), %r9d
vpsrld	$0xa, %ymm7, %ymm6
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%edx, %edi
vpsrlq	$0x11, %ymm7, %ymm7
xorl	%r13d, %r14d
leal	(%rbx,%rdi), %ebx
movl	%r10d, %r12d
vpxor	%ymm7, %ymm6, %ymm6
addl	0xac(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
vpsrlq	$0x2, %ymm7, %ymm7
rorxl	$0xb, %r9d, %edi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
vpxor	%ymm7, %ymm6, %ymm6
andnl	%r11d, %r9d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r9d, %r14d
vpshufb	%ymm9, %ymm6, %ymm6
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %edi
vpaddd	%ymm6, %ymm3, %ymm3
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %edi
vpaddd	0x60(%rbp), %ymm3, %ymm6
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%edi, %r15d
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
vmovdqa	%ymm6, 0x20(%rsp)
leaq	0x80(%rbp), %rbp
cmpb	$0x0, 0x3(%rbp)
jne	L_3420
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%ebx, %edi
xorl	%r13d, %r14d
leal	(%r11,%rdi), %r11d
movl	%r8d, %r12d
addl	0x44(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %edi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %edi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %edi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r11d, %edi
xorl	%r13d, %r14d
leal	(%r9,%rdi), %r9d
movl	%ecx, %r12d
addl	0x4c(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %edi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %edi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %edi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r9d, %edi
xorl	%r13d, %r14d
leal	(%rdx,%rdi), %edx
movl	%eax, %r12d
addl	0x64(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %edi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %edi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %edi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%edx, %edi
xorl	%r13d, %r14d
leal	(%rbx,%rdi), %ebx
movl	%r10d, %r12d
addl	0x6c(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %edi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %edi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %edi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%ebx, %edi
xorl	%r13d, %r14d
leal	(%r11,%rdi), %r11d
movl	%r8d, %r12d
addl	0x4(%rsp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %edi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %edi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %edi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r11d, %edi
xorl	%r13d, %r14d
leal	(%r9,%rdi), %r9d
movl	%ecx, %r12d
addl	0xc(%rsp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %edi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %edi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %edi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r9d, %edi
xorl	%r13d, %r14d
leal	(%rdx,%rdi), %edx
movl	%eax, %r12d
addl	0x24(%rsp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %edi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %edi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %edi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%edx, %edi
xorl	%r13d, %r14d
leal	(%rbx,%rdi), %ebx
movl	%r10d, %r12d
addl	0x2c(%rsp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %edi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %edi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %edi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%edi, %r15d
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
movq	0x200(%rsp), %rdi
addl	%r14d, %eax
leaq	0x1c0(%rsp), %rbp
addl	(%rdi), %eax
addl	0x4(%rdi), %ebx
addl	0x8(%rdi), %ecx
addl	0xc(%rdi), %edx
addl	0x10(%rdi), %r8d
addl	0x14(%rdi), %r9d
addl	0x18(%rdi), %r10d
addl	0x1c(%rdi), %r11d
movl	%eax, (%rdi)
movl	%ebx, 0x4(%rdi)
movl	%ecx, 0x8(%rdi)
movl	%edx, 0xc(%rdi)
movl	%r8d, 0x10(%rdi)
movl	%r9d, 0x14(%rdi)
movl	%r10d, 0x18(%rdi)
movl	%r11d, 0x1c(%rdi)
cmpq	0x50(%rbp), %rsi
je	L_46ff
xorl	%r14d, %r14d
movl	%ebx, %edi
xorl	%ecx, %edi
movl	%r9d, %r12d
jmp	L_4380
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_4380:
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%ebx, %edi
xorl	%r13d, %r14d
leal	(%r11,%rdi), %r11d
movl	%r8d, %r12d
addl	0x14(%rbp), %r10d
andl	%edx, %r12d
rorxl	$0x19, %edx, %r13d
rorxl	$0xb, %edx, %edi
leal	(%r11,%r14), %r11d
leal	(%r10,%r12), %r10d
andnl	%r9d, %edx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %edx, %r14d
leal	(%r10,%r12), %r10d
xorl	%r14d, %r13d
movl	%r11d, %edi
rorxl	$0x16, %r11d, %r12d
leal	(%r10,%r13), %r10d
xorl	%eax, %edi
rorxl	$0xd, %r11d, %r14d
rorxl	$0x2, %r11d, %r13d
leal	(%rcx,%r10), %ecx
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r11d, %edi
xorl	%r13d, %r14d
leal	(%r9,%rdi), %r9d
movl	%ecx, %r12d
addl	0x1c(%rbp), %r8d
andl	%ebx, %r12d
rorxl	$0x19, %ebx, %r13d
rorxl	$0xb, %ebx, %edi
leal	(%r9,%r14), %r9d
leal	(%r8,%r12), %r8d
andnl	%edx, %ebx, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %ebx, %r14d
leal	(%r8,%r12), %r8d
xorl	%r14d, %r13d
movl	%r9d, %edi
rorxl	$0x16, %r9d, %r12d
leal	(%r8,%r13), %r8d
xorl	%r10d, %edi
rorxl	$0xd, %r9d, %r14d
rorxl	$0x2, %r9d, %r13d
leal	(%rax,%r8), %eax
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%r9d, %edi
xorl	%r13d, %r14d
leal	(%rdx,%rdi), %edx
movl	%eax, %r12d
addl	0x34(%rbp), %ecx
andl	%r11d, %r12d
rorxl	$0x19, %r11d, %r13d
rorxl	$0xb, %r11d, %edi
leal	(%rdx,%r14), %edx
leal	(%rcx,%r12), %ecx
andnl	%ebx, %r11d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r11d, %r14d
leal	(%rcx,%r12), %ecx
xorl	%r14d, %r13d
movl	%edx, %edi
rorxl	$0x16, %edx, %r12d
leal	(%rcx,%r13), %ecx
xorl	%r8d, %edi
rorxl	$0xd, %edx, %r14d
rorxl	$0x2, %edx, %r13d
leal	(%r10,%rcx), %r10d
andl	%edi, %r15d
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
andl	%r15d, %edi
xorl	%r12d, %r14d
xorl	%edx, %edi
xorl	%r13d, %r14d
leal	(%rbx,%rdi), %ebx
movl	%r10d, %r12d
addl	0x3c(%rbp), %eax
andl	%r9d, %r12d
rorxl	$0x19, %r9d, %r13d
rorxl	$0xb, %r9d, %edi
leal	(%rbx,%r14), %ebx
leal	(%rax,%r12), %eax
andnl	%r11d, %r9d, %r12d
xorl	%edi, %r13d
rorxl	$0x6, %r9d, %r14d
leal	(%rax,%r12), %eax
xorl	%r14d, %r13d
movl	%ebx, %edi
rorxl	$0x16, %ebx, %r12d
leal	(%rax,%r13), %eax
xorl	%ecx, %edi
rorxl	$0xd, %ebx, %r14d
rorxl	$0x2, %ebx, %r13d
leal	(%r8,%rax), %r8d
andl	%edi, %r15d
xorl	%r12d, %r14d
xorl	%ecx, %r15d
xorl	%r13d, %r14d
leal	(%rax,%r15), %eax
movl	%r9d, %r12d
leaq	-0x40(%rbp), %rbp
cmpq	%rsp, %rbp
jae	L_4380
movq	0x200(%rsp), %rdi
addl	%r14d, %eax
leaq	0x1c0(%rsp), %rsp
addl	(%rdi), %eax
addl	0x4(%rdi), %ebx
addl	0x8(%rdi), %ecx
addl	0xc(%rdi), %edx
addl	0x10(%rdi), %r8d
addl	0x14(%rdi), %r9d
leaq	0x80(%rsi), %rsi
addl	0x18(%rdi), %r10d
movq	%rsi, %r12
addl	0x1c(%rdi), %r11d
cmpq	0x50(%rsp), %rsi
movl	%eax, (%rdi)
cmoveq	%rsp, %r12
movl	%ebx, 0x4(%rdi)
movl	%ecx, 0x8(%rdi)
movl	%edx, 0xc(%rdi)
movl	%r8d, 0x10(%rdi)
movl	%r9d, 0x14(%rdi)
movl	%r10d, 0x18(%rdi)
movl	%r11d, 0x1c(%rdi)
jbe	L_3380
leaq	(%rsp), %rbp
L_46ff:
movq	0x58(%rbp), %rsi
vzeroupper
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
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
	.byte 0,1,2,3,8,9,10,11,255,255,255,255,255,255,255,255
	.byte 0,1,2,3,8,9,10,11,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,0,1,2,3,8,9,10,11
	.byte 255,255,255,255,255,255,255,255,0,1,2,3,8,9,10,11
	.byte 83,72,65,50,53,54,32,98,108,111,99,107,32,116,114,97
	.byte 110,115,102,111,114,109,32,102,111,114,32,120,56,54,95,54
	.byte 52,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121
	.byte 32,60,104,116,116,112,115,58,47,47,103,105,116,104,117,98
	.byte 46,99,111,109,47,100,111,116,45,97,115,109,62,0

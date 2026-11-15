	.text
sha1_block_data_order:
movl	OPENSSL_ia32cap_P(%rip), %r9d
movl	OPENSSL_ia32cap_P+4(%rip), %r8d
movl	OPENSSL_ia32cap_P+8(%rip), %r10d
testl	$0x200, %r8d
je	L_70
testl	$0x20000000, %r10d
jne	_shaext_shortcut
andl	$0x128, %r10d
cmpl	$0x128, %r10d
je	_avx2_shortcut
andl	$0x10000000, %r8d
andl	$0x40000000, %r9d
orl	%r9d, %r8d
cmpl	$0x50000000, %r8d
je	_avx_shortcut
jmp	_ssse3_shortcut
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_70:
movq	%rsp, %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
movq	%rdi, %r8
subq	$0x48, %rsp
movq	%rsi, %r9
andq	$-0x40, %rsp
movq	%rdx, %r10
movq	%rax, 0x40(%rsp)
movl	(%r8), %esi
movl	0x4(%r8), %edi
movl	0x8(%r8), %r11d
movl	0xc(%r8), %r12d
movl	0x10(%r8), %r13d
jmp	L_b0
nopw	%cs:(%rax,%rax)
L_b0:
movl	(%r9), %edx
bswapl	%edx
movl	0x4(%r9), %ebp
movl	%r12d, %eax
movl	%edx, (%rsp)
movl	%esi, %ecx
bswapl	%ebp
xorl	%r11d, %eax
roll	$0x5, %ecx
andl	%edi, %eax
leal	0x5a827999(%rdx,%r13), %r13d
addl	%ecx, %r13d
xorl	%r12d, %eax
roll	$0x1e, %edi
addl	%eax, %r13d
movl	0x8(%r9), %r14d
movl	%r11d, %eax
movl	%ebp, 0x4(%rsp)
movl	%r13d, %ecx
bswapl	%r14d
xorl	%edi, %eax
roll	$0x5, %ecx
andl	%esi, %eax
leal	0x5a827999(%rbp,%r12), %r12d
addl	%ecx, %r12d
xorl	%r11d, %eax
roll	$0x1e, %esi
addl	%eax, %r12d
movl	0xc(%r9), %edx
movl	%edi, %eax
movl	%r14d, 0x8(%rsp)
movl	%r12d, %ecx
bswapl	%edx
xorl	%esi, %eax
roll	$0x5, %ecx
andl	%r13d, %eax
leal	0x5a827999(%r14,%r11), %r11d
addl	%ecx, %r11d
xorl	%edi, %eax
roll	$0x1e, %r13d
addl	%eax, %r11d
movl	0x10(%r9), %ebp
movl	%esi, %eax
movl	%edx, 0xc(%rsp)
movl	%r11d, %ecx
bswapl	%ebp
xorl	%r13d, %eax
roll	$0x5, %ecx
andl	%r12d, %eax
leal	0x5a827999(%rdx,%rdi), %edi
addl	%ecx, %edi
xorl	%esi, %eax
roll	$0x1e, %r12d
addl	%eax, %edi
movl	0x14(%r9), %r14d
movl	%r13d, %eax
movl	%ebp, 0x10(%rsp)
movl	%edi, %ecx
bswapl	%r14d
xorl	%r12d, %eax
roll	$0x5, %ecx
andl	%r11d, %eax
leal	0x5a827999(%rbp,%rsi), %esi
addl	%ecx, %esi
xorl	%r13d, %eax
roll	$0x1e, %r11d
addl	%eax, %esi
movl	0x18(%r9), %edx
movl	%r12d, %eax
movl	%r14d, 0x14(%rsp)
movl	%esi, %ecx
bswapl	%edx
xorl	%r11d, %eax
roll	$0x5, %ecx
andl	%edi, %eax
leal	0x5a827999(%r14,%r13), %r13d
addl	%ecx, %r13d
xorl	%r12d, %eax
roll	$0x1e, %edi
addl	%eax, %r13d
movl	0x1c(%r9), %ebp
movl	%r11d, %eax
movl	%edx, 0x18(%rsp)
movl	%r13d, %ecx
bswapl	%ebp
xorl	%edi, %eax
roll	$0x5, %ecx
andl	%esi, %eax
leal	0x5a827999(%rdx,%r12), %r12d
addl	%ecx, %r12d
xorl	%r11d, %eax
roll	$0x1e, %esi
addl	%eax, %r12d
movl	0x20(%r9), %r14d
movl	%edi, %eax
movl	%ebp, 0x1c(%rsp)
movl	%r12d, %ecx
bswapl	%r14d
xorl	%esi, %eax
roll	$0x5, %ecx
andl	%r13d, %eax
leal	0x5a827999(%rbp,%r11), %r11d
addl	%ecx, %r11d
xorl	%edi, %eax
roll	$0x1e, %r13d
addl	%eax, %r11d
movl	0x24(%r9), %edx
movl	%esi, %eax
movl	%r14d, 0x20(%rsp)
movl	%r11d, %ecx
bswapl	%edx
xorl	%r13d, %eax
roll	$0x5, %ecx
andl	%r12d, %eax
leal	0x5a827999(%r14,%rdi), %edi
addl	%ecx, %edi
xorl	%esi, %eax
roll	$0x1e, %r12d
addl	%eax, %edi
movl	0x28(%r9), %ebp
movl	%r13d, %eax
movl	%edx, 0x24(%rsp)
movl	%edi, %ecx
bswapl	%ebp
xorl	%r12d, %eax
roll	$0x5, %ecx
andl	%r11d, %eax
leal	0x5a827999(%rdx,%rsi), %esi
addl	%ecx, %esi
xorl	%r13d, %eax
roll	$0x1e, %r11d
addl	%eax, %esi
movl	0x2c(%r9), %r14d
movl	%r12d, %eax
movl	%ebp, 0x28(%rsp)
movl	%esi, %ecx
bswapl	%r14d
xorl	%r11d, %eax
roll	$0x5, %ecx
andl	%edi, %eax
leal	0x5a827999(%rbp,%r13), %r13d
addl	%ecx, %r13d
xorl	%r12d, %eax
roll	$0x1e, %edi
addl	%eax, %r13d
movl	0x30(%r9), %edx
movl	%r11d, %eax
movl	%r14d, 0x2c(%rsp)
movl	%r13d, %ecx
bswapl	%edx
xorl	%edi, %eax
roll	$0x5, %ecx
andl	%esi, %eax
leal	0x5a827999(%r14,%r12), %r12d
addl	%ecx, %r12d
xorl	%r11d, %eax
roll	$0x1e, %esi
addl	%eax, %r12d
movl	0x34(%r9), %ebp
movl	%edi, %eax
movl	%edx, 0x30(%rsp)
movl	%r12d, %ecx
bswapl	%ebp
xorl	%esi, %eax
roll	$0x5, %ecx
andl	%r13d, %eax
leal	0x5a827999(%rdx,%r11), %r11d
addl	%ecx, %r11d
xorl	%edi, %eax
roll	$0x1e, %r13d
addl	%eax, %r11d
movl	0x38(%r9), %r14d
movl	%esi, %eax
movl	%ebp, 0x34(%rsp)
movl	%r11d, %ecx
bswapl	%r14d
xorl	%r13d, %eax
roll	$0x5, %ecx
andl	%r12d, %eax
leal	0x5a827999(%rbp,%rdi), %edi
addl	%ecx, %edi
xorl	%esi, %eax
roll	$0x1e, %r12d
addl	%eax, %edi
movl	0x3c(%r9), %edx
movl	%r13d, %eax
movl	%r14d, 0x38(%rsp)
movl	%edi, %ecx
bswapl	%edx
xorl	%r12d, %eax
roll	$0x5, %ecx
andl	%r11d, %eax
leal	0x5a827999(%r14,%rsi), %esi
addl	%ecx, %esi
xorl	%r13d, %eax
roll	$0x1e, %r11d
addl	%eax, %esi
xorl	(%rsp), %ebp
movl	%r12d, %eax
movl	%edx, 0x3c(%rsp)
movl	%esi, %ecx
xorl	0x8(%rsp), %ebp
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x20(%rsp), %ebp
andl	%edi, %eax
leal	0x5a827999(%rdx,%r13), %r13d
roll	$0x1e, %edi
xorl	%r12d, %eax
addl	%ecx, %r13d
roll	%ebp
addl	%eax, %r13d
xorl	0x4(%rsp), %r14d
movl	%r11d, %eax
movl	%ebp, (%rsp)
movl	%r13d, %ecx
xorl	0xc(%rsp), %r14d
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x24(%rsp), %r14d
andl	%esi, %eax
leal	0x5a827999(%rbp,%r12), %r12d
roll	$0x1e, %esi
xorl	%r11d, %eax
addl	%ecx, %r12d
roll	%r14d
addl	%eax, %r12d
xorl	0x8(%rsp), %edx
movl	%edi, %eax
movl	%r14d, 0x4(%rsp)
movl	%r12d, %ecx
xorl	0x10(%rsp), %edx
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x28(%rsp), %edx
andl	%r13d, %eax
leal	0x5a827999(%r14,%r11), %r11d
roll	$0x1e, %r13d
xorl	%edi, %eax
addl	%ecx, %r11d
roll	%edx
addl	%eax, %r11d
xorl	0xc(%rsp), %ebp
movl	%esi, %eax
movl	%edx, 0x8(%rsp)
movl	%r11d, %ecx
xorl	0x14(%rsp), %ebp
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0x2c(%rsp), %ebp
andl	%r12d, %eax
leal	0x5a827999(%rdx,%rdi), %edi
roll	$0x1e, %r12d
xorl	%esi, %eax
addl	%ecx, %edi
roll	%ebp
addl	%eax, %edi
xorl	0x10(%rsp), %r14d
movl	%r13d, %eax
movl	%ebp, 0xc(%rsp)
movl	%edi, %ecx
xorl	0x18(%rsp), %r14d
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x30(%rsp), %r14d
andl	%r11d, %eax
leal	0x5a827999(%rbp,%rsi), %esi
roll	$0x1e, %r11d
xorl	%r13d, %eax
addl	%ecx, %esi
roll	%r14d
addl	%eax, %esi
xorl	0x14(%rsp), %edx
movl	%edi, %eax
movl	%r14d, 0x10(%rsp)
movl	%esi, %ecx
xorl	0x1c(%rsp), %edx
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x34(%rsp), %edx
leal	0x6ed9eba1(%r14,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%edx
xorl	0x18(%rsp), %ebp
movl	%esi, %eax
movl	%edx, 0x14(%rsp)
movl	%r13d, %ecx
xorl	0x20(%rsp), %ebp
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x38(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%ebp
xorl	0x1c(%rsp), %r14d
movl	%r13d, %eax
movl	%ebp, 0x18(%rsp)
movl	%r12d, %ecx
xorl	0x24(%rsp), %r14d
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x3c(%rsp), %r14d
leal	0x6ed9eba1(%rbp,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%r14d
xorl	0x20(%rsp), %edx
movl	%r12d, %eax
movl	%r14d, 0x1c(%rsp)
movl	%r11d, %ecx
xorl	0x28(%rsp), %edx
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	(%rsp), %edx
leal	0x6ed9eba1(%r14,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%edx
xorl	0x24(%rsp), %ebp
movl	%r11d, %eax
movl	%edx, 0x20(%rsp)
movl	%edi, %ecx
xorl	0x2c(%rsp), %ebp
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0x4(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%ebp
xorl	0x28(%rsp), %r14d
movl	%edi, %eax
movl	%ebp, 0x24(%rsp)
movl	%esi, %ecx
xorl	0x30(%rsp), %r14d
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x8(%rsp), %r14d
leal	0x6ed9eba1(%rbp,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%r14d
xorl	0x2c(%rsp), %edx
movl	%esi, %eax
movl	%r14d, 0x28(%rsp)
movl	%r13d, %ecx
xorl	0x34(%rsp), %edx
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0xc(%rsp), %edx
leal	0x6ed9eba1(%r14,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%edx
xorl	0x30(%rsp), %ebp
movl	%r13d, %eax
movl	%edx, 0x2c(%rsp)
movl	%r12d, %ecx
xorl	0x38(%rsp), %ebp
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x10(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%ebp
xorl	0x34(%rsp), %r14d
movl	%r12d, %eax
movl	%ebp, 0x30(%rsp)
movl	%r11d, %ecx
xorl	0x3c(%rsp), %r14d
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x14(%rsp), %r14d
leal	0x6ed9eba1(%rbp,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%r14d
xorl	0x38(%rsp), %edx
movl	%r11d, %eax
movl	%r14d, 0x34(%rsp)
movl	%edi, %ecx
xorl	(%rsp), %edx
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0x18(%rsp), %edx
leal	0x6ed9eba1(%r14,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%edx
xorl	0x3c(%rsp), %ebp
movl	%edi, %eax
movl	%edx, 0x38(%rsp)
movl	%esi, %ecx
xorl	0x4(%rsp), %ebp
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x1c(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%ebp
xorl	(%rsp), %r14d
movl	%esi, %eax
movl	%ebp, 0x3c(%rsp)
movl	%r13d, %ecx
xorl	0x8(%rsp), %r14d
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x20(%rsp), %r14d
leal	0x6ed9eba1(%rbp,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%r14d
xorl	0x4(%rsp), %edx
movl	%r13d, %eax
movl	%r14d, (%rsp)
movl	%r12d, %ecx
xorl	0xc(%rsp), %edx
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x24(%rsp), %edx
leal	0x6ed9eba1(%r14,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%edx
xorl	0x8(%rsp), %ebp
movl	%r12d, %eax
movl	%edx, 0x4(%rsp)
movl	%r11d, %ecx
xorl	0x10(%rsp), %ebp
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x28(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%ebp
xorl	0xc(%rsp), %r14d
movl	%r11d, %eax
movl	%ebp, 0x8(%rsp)
movl	%edi, %ecx
xorl	0x14(%rsp), %r14d
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0x2c(%rsp), %r14d
leal	0x6ed9eba1(%rbp,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%r14d
xorl	0x10(%rsp), %edx
movl	%edi, %eax
movl	%r14d, 0xc(%rsp)
movl	%esi, %ecx
xorl	0x18(%rsp), %edx
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x30(%rsp), %edx
leal	0x6ed9eba1(%r14,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%edx
xorl	0x14(%rsp), %ebp
movl	%esi, %eax
movl	%edx, 0x10(%rsp)
movl	%r13d, %ecx
xorl	0x1c(%rsp), %ebp
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x34(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%ebp
xorl	0x18(%rsp), %r14d
movl	%r13d, %eax
movl	%ebp, 0x14(%rsp)
movl	%r12d, %ecx
xorl	0x20(%rsp), %r14d
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x38(%rsp), %r14d
leal	0x6ed9eba1(%rbp,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%r14d
xorl	0x1c(%rsp), %edx
movl	%r12d, %eax
movl	%r14d, 0x18(%rsp)
movl	%r11d, %ecx
xorl	0x24(%rsp), %edx
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x3c(%rsp), %edx
leal	0x6ed9eba1(%r14,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%edx
xorl	0x20(%rsp), %ebp
movl	%r11d, %eax
movl	%edx, 0x1c(%rsp)
movl	%edi, %ecx
xorl	0x28(%rsp), %ebp
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	(%rsp), %ebp
leal	0x6ed9eba1(%rdx,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%ebp
xorl	0x24(%rsp), %r14d
movl	%r12d, %eax
movl	%ebp, 0x20(%rsp)
movl	%r12d, %ebx
xorl	0x2c(%rsp), %r14d
andl	%r11d, %eax
movl	%esi, %ecx
xorl	0x4(%rsp), %r14d
leal	-0x70e44324(%rbp,%r13), %r13d
xorl	%r11d, %ebx
roll	$0x5, %ecx
addl	%eax, %r13d
roll	%r14d
andl	%edi, %ebx
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%ebx, %r13d
xorl	0x28(%rsp), %edx
movl	%r11d, %eax
movl	%r14d, 0x24(%rsp)
movl	%r11d, %ebx
xorl	0x30(%rsp), %edx
andl	%edi, %eax
movl	%r13d, %ecx
xorl	0x8(%rsp), %edx
leal	-0x70e44324(%r14,%r12), %r12d
xorl	%edi, %ebx
roll	$0x5, %ecx
addl	%eax, %r12d
roll	%edx
andl	%esi, %ebx
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%ebx, %r12d
xorl	0x2c(%rsp), %ebp
movl	%edi, %eax
movl	%edx, 0x28(%rsp)
movl	%edi, %ebx
xorl	0x34(%rsp), %ebp
andl	%esi, %eax
movl	%r12d, %ecx
xorl	0xc(%rsp), %ebp
leal	-0x70e44324(%rdx,%r11), %r11d
xorl	%esi, %ebx
roll	$0x5, %ecx
addl	%eax, %r11d
roll	%ebp
andl	%r13d, %ebx
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%ebx, %r11d
xorl	0x30(%rsp), %r14d
movl	%esi, %eax
movl	%ebp, 0x2c(%rsp)
movl	%esi, %ebx
xorl	0x38(%rsp), %r14d
andl	%r13d, %eax
movl	%r11d, %ecx
xorl	0x10(%rsp), %r14d
leal	-0x70e44324(%rbp,%rdi), %edi
xorl	%r13d, %ebx
roll	$0x5, %ecx
addl	%eax, %edi
roll	%r14d
andl	%r12d, %ebx
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%ebx, %edi
xorl	0x34(%rsp), %edx
movl	%r13d, %eax
movl	%r14d, 0x30(%rsp)
movl	%r13d, %ebx
xorl	0x3c(%rsp), %edx
andl	%r12d, %eax
movl	%edi, %ecx
xorl	0x14(%rsp), %edx
leal	-0x70e44324(%r14,%rsi), %esi
xorl	%r12d, %ebx
roll	$0x5, %ecx
addl	%eax, %esi
roll	%edx
andl	%r11d, %ebx
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%ebx, %esi
xorl	0x38(%rsp), %ebp
movl	%r12d, %eax
movl	%edx, 0x34(%rsp)
movl	%r12d, %ebx
xorl	(%rsp), %ebp
andl	%r11d, %eax
movl	%esi, %ecx
xorl	0x18(%rsp), %ebp
leal	-0x70e44324(%rdx,%r13), %r13d
xorl	%r11d, %ebx
roll	$0x5, %ecx
addl	%eax, %r13d
roll	%ebp
andl	%edi, %ebx
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%ebx, %r13d
xorl	0x3c(%rsp), %r14d
movl	%r11d, %eax
movl	%ebp, 0x38(%rsp)
movl	%r11d, %ebx
xorl	0x4(%rsp), %r14d
andl	%edi, %eax
movl	%r13d, %ecx
xorl	0x1c(%rsp), %r14d
leal	-0x70e44324(%rbp,%r12), %r12d
xorl	%edi, %ebx
roll	$0x5, %ecx
addl	%eax, %r12d
roll	%r14d
andl	%esi, %ebx
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%ebx, %r12d
xorl	(%rsp), %edx
movl	%edi, %eax
movl	%r14d, 0x3c(%rsp)
movl	%edi, %ebx
xorl	0x8(%rsp), %edx
andl	%esi, %eax
movl	%r12d, %ecx
xorl	0x20(%rsp), %edx
leal	-0x70e44324(%r14,%r11), %r11d
xorl	%esi, %ebx
roll	$0x5, %ecx
addl	%eax, %r11d
roll	%edx
andl	%r13d, %ebx
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%ebx, %r11d
xorl	0x4(%rsp), %ebp
movl	%esi, %eax
movl	%edx, (%rsp)
movl	%esi, %ebx
xorl	0xc(%rsp), %ebp
andl	%r13d, %eax
movl	%r11d, %ecx
xorl	0x24(%rsp), %ebp
leal	-0x70e44324(%rdx,%rdi), %edi
xorl	%r13d, %ebx
roll	$0x5, %ecx
addl	%eax, %edi
roll	%ebp
andl	%r12d, %ebx
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%ebx, %edi
xorl	0x8(%rsp), %r14d
movl	%r13d, %eax
movl	%ebp, 0x4(%rsp)
movl	%r13d, %ebx
xorl	0x10(%rsp), %r14d
andl	%r12d, %eax
movl	%edi, %ecx
xorl	0x28(%rsp), %r14d
leal	-0x70e44324(%rbp,%rsi), %esi
xorl	%r12d, %ebx
roll	$0x5, %ecx
addl	%eax, %esi
roll	%r14d
andl	%r11d, %ebx
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%ebx, %esi
xorl	0xc(%rsp), %edx
movl	%r12d, %eax
movl	%r14d, 0x8(%rsp)
movl	%r12d, %ebx
xorl	0x14(%rsp), %edx
andl	%r11d, %eax
movl	%esi, %ecx
xorl	0x2c(%rsp), %edx
leal	-0x70e44324(%r14,%r13), %r13d
xorl	%r11d, %ebx
roll	$0x5, %ecx
addl	%eax, %r13d
roll	%edx
andl	%edi, %ebx
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%ebx, %r13d
xorl	0x10(%rsp), %ebp
movl	%r11d, %eax
movl	%edx, 0xc(%rsp)
movl	%r11d, %ebx
xorl	0x18(%rsp), %ebp
andl	%edi, %eax
movl	%r13d, %ecx
xorl	0x30(%rsp), %ebp
leal	-0x70e44324(%rdx,%r12), %r12d
xorl	%edi, %ebx
roll	$0x5, %ecx
addl	%eax, %r12d
roll	%ebp
andl	%esi, %ebx
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%ebx, %r12d
xorl	0x14(%rsp), %r14d
movl	%edi, %eax
movl	%ebp, 0x10(%rsp)
movl	%edi, %ebx
xorl	0x1c(%rsp), %r14d
andl	%esi, %eax
movl	%r12d, %ecx
xorl	0x34(%rsp), %r14d
leal	-0x70e44324(%rbp,%r11), %r11d
xorl	%esi, %ebx
roll	$0x5, %ecx
addl	%eax, %r11d
roll	%r14d
andl	%r13d, %ebx
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%ebx, %r11d
xorl	0x18(%rsp), %edx
movl	%esi, %eax
movl	%r14d, 0x14(%rsp)
movl	%esi, %ebx
xorl	0x20(%rsp), %edx
andl	%r13d, %eax
movl	%r11d, %ecx
xorl	0x38(%rsp), %edx
leal	-0x70e44324(%r14,%rdi), %edi
xorl	%r13d, %ebx
roll	$0x5, %ecx
addl	%eax, %edi
roll	%edx
andl	%r12d, %ebx
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%ebx, %edi
xorl	0x1c(%rsp), %ebp
movl	%r13d, %eax
movl	%edx, 0x18(%rsp)
movl	%r13d, %ebx
xorl	0x24(%rsp), %ebp
andl	%r12d, %eax
movl	%edi, %ecx
xorl	0x3c(%rsp), %ebp
leal	-0x70e44324(%rdx,%rsi), %esi
xorl	%r12d, %ebx
roll	$0x5, %ecx
addl	%eax, %esi
roll	%ebp
andl	%r11d, %ebx
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%ebx, %esi
xorl	0x20(%rsp), %r14d
movl	%r12d, %eax
movl	%ebp, 0x1c(%rsp)
movl	%r12d, %ebx
xorl	0x28(%rsp), %r14d
andl	%r11d, %eax
movl	%esi, %ecx
xorl	(%rsp), %r14d
leal	-0x70e44324(%rbp,%r13), %r13d
xorl	%r11d, %ebx
roll	$0x5, %ecx
addl	%eax, %r13d
roll	%r14d
andl	%edi, %ebx
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%ebx, %r13d
xorl	0x24(%rsp), %edx
movl	%r11d, %eax
movl	%r14d, 0x20(%rsp)
movl	%r11d, %ebx
xorl	0x2c(%rsp), %edx
andl	%edi, %eax
movl	%r13d, %ecx
xorl	0x4(%rsp), %edx
leal	-0x70e44324(%r14,%r12), %r12d
xorl	%edi, %ebx
roll	$0x5, %ecx
addl	%eax, %r12d
roll	%edx
andl	%esi, %ebx
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%ebx, %r12d
xorl	0x28(%rsp), %ebp
movl	%edi, %eax
movl	%edx, 0x24(%rsp)
movl	%edi, %ebx
xorl	0x30(%rsp), %ebp
andl	%esi, %eax
movl	%r12d, %ecx
xorl	0x8(%rsp), %ebp
leal	-0x70e44324(%rdx,%r11), %r11d
xorl	%esi, %ebx
roll	$0x5, %ecx
addl	%eax, %r11d
roll	%ebp
andl	%r13d, %ebx
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%ebx, %r11d
xorl	0x2c(%rsp), %r14d
movl	%esi, %eax
movl	%ebp, 0x28(%rsp)
movl	%esi, %ebx
xorl	0x34(%rsp), %r14d
andl	%r13d, %eax
movl	%r11d, %ecx
xorl	0xc(%rsp), %r14d
leal	-0x70e44324(%rbp,%rdi), %edi
xorl	%r13d, %ebx
roll	$0x5, %ecx
addl	%eax, %edi
roll	%r14d
andl	%r12d, %ebx
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%ebx, %edi
xorl	0x30(%rsp), %edx
movl	%r13d, %eax
movl	%r14d, 0x2c(%rsp)
movl	%r13d, %ebx
xorl	0x38(%rsp), %edx
andl	%r12d, %eax
movl	%edi, %ecx
xorl	0x10(%rsp), %edx
leal	-0x70e44324(%r14,%rsi), %esi
xorl	%r12d, %ebx
roll	$0x5, %ecx
addl	%eax, %esi
roll	%edx
andl	%r11d, %ebx
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%ebx, %esi
xorl	0x34(%rsp), %ebp
movl	%edi, %eax
movl	%edx, 0x30(%rsp)
movl	%esi, %ecx
xorl	0x3c(%rsp), %ebp
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x14(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%ebp
xorl	0x38(%rsp), %r14d
movl	%esi, %eax
movl	%ebp, 0x34(%rsp)
movl	%r13d, %ecx
xorl	(%rsp), %r14d
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x18(%rsp), %r14d
leal	-0x359d3e2a(%rbp,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%r14d
xorl	0x3c(%rsp), %edx
movl	%r13d, %eax
movl	%r14d, 0x38(%rsp)
movl	%r12d, %ecx
xorl	0x4(%rsp), %edx
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x1c(%rsp), %edx
leal	-0x359d3e2a(%r14,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%edx
xorl	(%rsp), %ebp
movl	%r12d, %eax
movl	%edx, 0x3c(%rsp)
movl	%r11d, %ecx
xorl	0x8(%rsp), %ebp
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x20(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%ebp
xorl	0x4(%rsp), %r14d
movl	%r11d, %eax
movl	%ebp, (%rsp)
movl	%edi, %ecx
xorl	0xc(%rsp), %r14d
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0x24(%rsp), %r14d
leal	-0x359d3e2a(%rbp,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%r14d
xorl	0x8(%rsp), %edx
movl	%edi, %eax
movl	%r14d, 0x4(%rsp)
movl	%esi, %ecx
xorl	0x10(%rsp), %edx
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x28(%rsp), %edx
leal	-0x359d3e2a(%r14,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%edx
xorl	0xc(%rsp), %ebp
movl	%esi, %eax
movl	%edx, 0x8(%rsp)
movl	%r13d, %ecx
xorl	0x14(%rsp), %ebp
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x2c(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%ebp
xorl	0x10(%rsp), %r14d
movl	%r13d, %eax
movl	%ebp, 0xc(%rsp)
movl	%r12d, %ecx
xorl	0x18(%rsp), %r14d
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x30(%rsp), %r14d
leal	-0x359d3e2a(%rbp,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%r14d
xorl	0x14(%rsp), %edx
movl	%r12d, %eax
movl	%r14d, 0x10(%rsp)
movl	%r11d, %ecx
xorl	0x1c(%rsp), %edx
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x34(%rsp), %edx
leal	-0x359d3e2a(%r14,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%edx
xorl	0x18(%rsp), %ebp
movl	%r11d, %eax
movl	%edx, 0x14(%rsp)
movl	%edi, %ecx
xorl	0x20(%rsp), %ebp
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0x38(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%ebp
xorl	0x1c(%rsp), %r14d
movl	%edi, %eax
movl	%ebp, 0x18(%rsp)
movl	%esi, %ecx
xorl	0x24(%rsp), %r14d
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x3c(%rsp), %r14d
leal	-0x359d3e2a(%rbp,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%r14d
xorl	0x20(%rsp), %edx
movl	%esi, %eax
movl	%r14d, 0x1c(%rsp)
movl	%r13d, %ecx
xorl	0x28(%rsp), %edx
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	(%rsp), %edx
leal	-0x359d3e2a(%r14,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%edx
xorl	0x24(%rsp), %ebp
movl	%r13d, %eax
movl	%r12d, %ecx
xorl	0x2c(%rsp), %ebp
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x4(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%ebp
xorl	0x28(%rsp), %r14d
movl	%r12d, %eax
movl	%r11d, %ecx
xorl	0x30(%rsp), %r14d
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x8(%rsp), %r14d
leal	-0x359d3e2a(%rbp,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%r14d
xorl	0x2c(%rsp), %edx
movl	%r11d, %eax
movl	%edi, %ecx
xorl	0x34(%rsp), %edx
xorl	%r13d, %eax
roll	$0x5, %ecx
xorl	0xc(%rsp), %edx
leal	-0x359d3e2a(%r14,%rsi), %esi
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
roll	%edx
xorl	0x30(%rsp), %ebp
movl	%edi, %eax
movl	%esi, %ecx
xorl	0x38(%rsp), %ebp
xorl	%r12d, %eax
roll	$0x5, %ecx
xorl	0x10(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%r13), %r13d
xorl	%r11d, %eax
addl	%ecx, %r13d
roll	$0x1e, %edi
addl	%eax, %r13d
roll	%ebp
xorl	0x34(%rsp), %r14d
movl	%esi, %eax
movl	%r13d, %ecx
xorl	0x3c(%rsp), %r14d
xorl	%r11d, %eax
roll	$0x5, %ecx
xorl	0x14(%rsp), %r14d
leal	-0x359d3e2a(%rbp,%r12), %r12d
xorl	%edi, %eax
addl	%ecx, %r12d
roll	$0x1e, %esi
addl	%eax, %r12d
roll	%r14d
xorl	0x38(%rsp), %edx
movl	%r13d, %eax
movl	%r12d, %ecx
xorl	(%rsp), %edx
xorl	%edi, %eax
roll	$0x5, %ecx
xorl	0x18(%rsp), %edx
leal	-0x359d3e2a(%r14,%r11), %r11d
xorl	%esi, %eax
addl	%ecx, %r11d
roll	$0x1e, %r13d
addl	%eax, %r11d
roll	%edx
xorl	0x3c(%rsp), %ebp
movl	%r12d, %eax
movl	%r11d, %ecx
xorl	0x4(%rsp), %ebp
xorl	%esi, %eax
roll	$0x5, %ecx
xorl	0x1c(%rsp), %ebp
leal	-0x359d3e2a(%rdx,%rdi), %edi
xorl	%r13d, %eax
addl	%ecx, %edi
roll	$0x1e, %r12d
addl	%eax, %edi
roll	%ebp
movl	%r11d, %eax
movl	%edi, %ecx
xorl	%r13d, %eax
leal	-0x359d3e2a(%rbp,%rsi), %esi
roll	$0x5, %ecx
xorl	%r12d, %eax
addl	%ecx, %esi
roll	$0x1e, %r11d
addl	%eax, %esi
addl	(%r8), %esi
addl	0x4(%r8), %edi
addl	0x8(%r8), %r11d
addl	0xc(%r8), %r12d
addl	0x10(%r8), %r13d
movl	%esi, (%r8)
movl	%edi, 0x4(%r8)
movl	%r11d, 0x8(%r8)
movl	%r12d, 0xc(%r8)
movl	%r13d, 0x10(%r8)
subq	$0x1, %r10
leaq	0x40(%r9), %r9
jne	L_b0
movq	0x40(%rsp), %rsi
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
_shaext_shortcut:
sha1_block_data_order_shaext:
movdqu	(%rdi), %xmm0
movd	0x10(%rdi), %xmm1
movdqa	K_XX_XX+160(%rip), %xmm3
movdqu	(%rsi), %xmm4
pshufd	$0x1b, %xmm0, %xmm0
movdqu	0x10(%rsi), %xmm5
pshufd	$0x1b, %xmm1, %xmm1
movdqu	0x20(%rsi), %xmm6
pshufb	%xmm3, %xmm4
movdqu	0x30(%rsi), %xmm7
pshufb	%xmm3, %xmm5
pshufb	%xmm3, %xmm6
movdqa	%xmm1, %xmm9
pshufb	%xmm3, %xmm7
jmp	L_10f0
nopl	(%rax)
L_10f0:
decq	%rdx
leaq	0x40(%rsi), %r8
paddd	%xmm4, %xmm1
cmovneq	%r8, %rsi
movdqa	%xmm0, %xmm8
sha1msg1	%xmm5, %xmm4
movdqa	%xmm0, %xmm2
sha1rnds4	$0x0, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
sha1msg2	%xmm7, %xmm4
movdqa	%xmm0, %xmm1
sha1rnds4	$0x0, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
pxor	%xmm7, %xmm5
sha1msg2	%xmm4, %xmm5
sha1msg1	%xmm7, %xmm6
movdqa	%xmm0, %xmm2
sha1rnds4	$0x0, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
sha1msg2	%xmm5, %xmm6
movdqa	%xmm0, %xmm1
sha1rnds4	$0x0, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
pxor	%xmm5, %xmm7
sha1msg2	%xmm6, %xmm7
sha1msg1	%xmm5, %xmm4
movdqa	%xmm0, %xmm2
sha1rnds4	$0x0, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
sha1msg2	%xmm7, %xmm4
movdqa	%xmm0, %xmm1
sha1rnds4	$0x1, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
pxor	%xmm7, %xmm5
sha1msg2	%xmm4, %xmm5
sha1msg1	%xmm7, %xmm6
movdqa	%xmm0, %xmm2
sha1rnds4	$0x1, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
sha1msg2	%xmm5, %xmm6
movdqa	%xmm0, %xmm1
sha1rnds4	$0x1, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
pxor	%xmm5, %xmm7
sha1msg2	%xmm6, %xmm7
sha1msg1	%xmm5, %xmm4
movdqa	%xmm0, %xmm2
sha1rnds4	$0x1, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
sha1msg2	%xmm7, %xmm4
movdqa	%xmm0, %xmm1
sha1rnds4	$0x1, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
pxor	%xmm7, %xmm5
sha1msg2	%xmm4, %xmm5
sha1msg1	%xmm7, %xmm6
movdqa	%xmm0, %xmm2
sha1rnds4	$0x2, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
sha1msg2	%xmm5, %xmm6
movdqa	%xmm0, %xmm1
sha1rnds4	$0x2, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
pxor	%xmm5, %xmm7
sha1msg2	%xmm6, %xmm7
sha1msg1	%xmm5, %xmm4
movdqa	%xmm0, %xmm2
sha1rnds4	$0x2, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
pxor	%xmm6, %xmm4
sha1msg1	%xmm6, %xmm5
sha1msg2	%xmm7, %xmm4
movdqa	%xmm0, %xmm1
sha1rnds4	$0x2, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
pxor	%xmm7, %xmm5
sha1msg2	%xmm4, %xmm5
sha1msg1	%xmm7, %xmm6
movdqa	%xmm0, %xmm2
sha1rnds4	$0x2, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
pxor	%xmm4, %xmm6
sha1msg1	%xmm4, %xmm7
sha1msg2	%xmm5, %xmm6
movdqa	%xmm0, %xmm1
sha1rnds4	$0x3, %xmm2, %xmm0
sha1nexte	%xmm4, %xmm1
pxor	%xmm5, %xmm7
sha1msg2	%xmm6, %xmm7
movdqu	(%rsi), %xmm4
movdqa	%xmm0, %xmm2
sha1rnds4	$0x3, %xmm1, %xmm0
sha1nexte	%xmm5, %xmm2
movdqu	0x10(%rsi), %xmm5
pshufb	%xmm3, %xmm4
movdqa	%xmm0, %xmm1
sha1rnds4	$0x3, %xmm2, %xmm0
sha1nexte	%xmm6, %xmm1
movdqu	0x20(%rsi), %xmm6
pshufb	%xmm3, %xmm5
movdqa	%xmm0, %xmm2
sha1rnds4	$0x3, %xmm1, %xmm0
sha1nexte	%xmm7, %xmm2
movdqu	0x30(%rsi), %xmm7
pshufb	%xmm3, %xmm6
movdqa	%xmm0, %xmm1
sha1rnds4	$0x3, %xmm2, %xmm0
sha1nexte	%xmm9, %xmm1
pshufb	%xmm3, %xmm7
paddd	%xmm8, %xmm0
movdqa	%xmm1, %xmm9
jne	L_10f0
pshufd	$0x1b, %xmm0, %xmm0
pshufd	$0x1b, %xmm1, %xmm1
movdqu	%xmm0, (%rdi)
movd	%xmm1, 0x10(%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nop
_ssse3_shortcut:
sha1_block_data_order_ssse3:
movq	%rsp, %r11
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
leaq	-0x40(%rsp), %rsp
andq	$-0x40, %rsp
movq	%rdi, %r8
movq	%rsi, %r9
movq	%rdx, %r10
shlq	$0x6, %r10
addq	%r9, %r10
leaq	K_XX_XX+64(%rip), %r14
movl	(%r8), %eax
movl	0x4(%r8), %ebx
movl	0x8(%r8), %ecx
movl	0xc(%r8), %edx
movl	%ebx, %esi
movl	0x10(%r8), %ebp
movl	%ecx, %edi
xorl	%edx, %edi
andl	%edi, %esi
movdqa	0x40(%r14), %xmm6
movdqa	-0x40(%r14), %xmm9
movdqu	(%r9), %xmm0
movdqu	0x10(%r9), %xmm1
movdqu	0x20(%r9), %xmm2
movdqu	0x30(%r9), %xmm3
pshufb	%xmm6, %xmm0
pshufb	%xmm6, %xmm1
pshufb	%xmm6, %xmm2
addq	$0x40, %r9
paddd	%xmm9, %xmm0
pshufb	%xmm6, %xmm3
paddd	%xmm9, %xmm1
paddd	%xmm9, %xmm2
movdqa	%xmm0, (%rsp)
psubd	%xmm9, %xmm0
movdqa	%xmm1, 0x10(%rsp)
psubd	%xmm9, %xmm1
movdqa	%xmm2, 0x20(%rsp)
psubd	%xmm9, %xmm2
jmp	L_13e0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_13e0:
rorl	$0x2, %ebx
pshufd	$0xee, %xmm0, %xmm4
xorl	%edx, %esi
movdqa	%xmm3, %xmm8
paddd	%xmm3, %xmm9
movl	%eax, %edi
addl	(%rsp), %ebp
punpcklqdq	%xmm1, %xmm4
xorl	%ecx, %ebx
roll	$0x5, %eax
addl	%esi, %ebp
psrldq	$0x4, %xmm8
andl	%ebx, %edi
xorl	%ecx, %ebx
pxor	%xmm0, %xmm4
addl	%eax, %ebp
rorl	$0x7, %eax
pxor	%xmm2, %xmm8
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x4(%rsp), %edx
pxor	%xmm8, %xmm4
xorl	%ebx, %eax
roll	$0x5, %ebp
movdqa	%xmm9, 0x30(%rsp)
addl	%edi, %edx
andl	%eax, %esi
movdqa	%xmm4, %xmm10
xorl	%ebx, %eax
addl	%ebp, %edx
rorl	$0x7, %ebp
movdqa	%xmm4, %xmm8
xorl	%ebx, %esi
pslldq	$0xc, %xmm10
paddd	%xmm4, %xmm4
movl	%edx, %edi
addl	0x8(%rsp), %ecx
psrld	$0x1f, %xmm8
xorl	%eax, %ebp
roll	$0x5, %edx
addl	%esi, %ecx
movdqa	%xmm10, %xmm9
andl	%ebp, %edi
xorl	%eax, %ebp
psrld	$0x1e, %xmm10
addl	%edx, %ecx
rorl	$0x7, %edx
por	%xmm8, %xmm4
xorl	%eax, %edi
movl	%ecx, %esi
addl	0xc(%rsp), %ebx
pslld	$0x2, %xmm9
pxor	%xmm10, %xmm4
xorl	%ebp, %edx
movdqa	-0x40(%r14), %xmm10
roll	$0x5, %ecx
addl	%edi, %ebx
andl	%edx, %esi
pxor	%xmm9, %xmm4
xorl	%ebp, %edx
addl	%ecx, %ebx
rorl	$0x7, %ecx
pshufd	$0xee, %xmm1, %xmm5
xorl	%ebp, %esi
movdqa	%xmm4, %xmm9
paddd	%xmm4, %xmm10
movl	%ebx, %edi
addl	0x10(%rsp), %eax
punpcklqdq	%xmm2, %xmm5
xorl	%edx, %ecx
roll	$0x5, %ebx
addl	%esi, %eax
psrldq	$0x4, %xmm9
andl	%ecx, %edi
xorl	%edx, %ecx
pxor	%xmm1, %xmm5
addl	%ebx, %eax
rorl	$0x7, %ebx
pxor	%xmm3, %xmm9
xorl	%edx, %edi
movl	%eax, %esi
addl	0x14(%rsp), %ebp
pxor	%xmm9, %xmm5
xorl	%ecx, %ebx
roll	$0x5, %eax
movdqa	%xmm10, (%rsp)
addl	%edi, %ebp
andl	%ebx, %esi
movdqa	%xmm5, %xmm8
xorl	%ecx, %ebx
addl	%eax, %ebp
rorl	$0x7, %eax
movdqa	%xmm5, %xmm9
xorl	%ecx, %esi
pslldq	$0xc, %xmm8
paddd	%xmm5, %xmm5
movl	%ebp, %edi
addl	0x18(%rsp), %edx
psrld	$0x1f, %xmm9
xorl	%ebx, %eax
roll	$0x5, %ebp
addl	%esi, %edx
movdqa	%xmm8, %xmm10
andl	%eax, %edi
xorl	%ebx, %eax
psrld	$0x1e, %xmm8
addl	%ebp, %edx
rorl	$0x7, %ebp
por	%xmm9, %xmm5
xorl	%ebx, %edi
movl	%edx, %esi
addl	0x1c(%rsp), %ecx
pslld	$0x2, %xmm10
pxor	%xmm8, %xmm5
xorl	%eax, %ebp
movdqa	-0x20(%r14), %xmm8
roll	$0x5, %edx
addl	%edi, %ecx
andl	%ebp, %esi
pxor	%xmm10, %xmm5
xorl	%eax, %ebp
addl	%edx, %ecx
rorl	$0x7, %edx
pshufd	$0xee, %xmm2, %xmm6
xorl	%eax, %esi
movdqa	%xmm5, %xmm10
paddd	%xmm5, %xmm8
movl	%ecx, %edi
addl	0x20(%rsp), %ebx
punpcklqdq	%xmm3, %xmm6
xorl	%ebp, %edx
roll	$0x5, %ecx
addl	%esi, %ebx
psrldq	$0x4, %xmm10
andl	%edx, %edi
xorl	%ebp, %edx
pxor	%xmm2, %xmm6
addl	%ecx, %ebx
rorl	$0x7, %ecx
pxor	%xmm4, %xmm10
xorl	%ebp, %edi
movl	%ebx, %esi
addl	0x24(%rsp), %eax
pxor	%xmm10, %xmm6
xorl	%edx, %ecx
roll	$0x5, %ebx
movdqa	%xmm8, 0x10(%rsp)
addl	%edi, %eax
andl	%ecx, %esi
movdqa	%xmm6, %xmm9
xorl	%edx, %ecx
addl	%ebx, %eax
rorl	$0x7, %ebx
movdqa	%xmm6, %xmm10
xorl	%edx, %esi
pslldq	$0xc, %xmm9
paddd	%xmm6, %xmm6
movl	%eax, %edi
addl	0x28(%rsp), %ebp
psrld	$0x1f, %xmm10
xorl	%ecx, %ebx
roll	$0x5, %eax
addl	%esi, %ebp
movdqa	%xmm9, %xmm8
andl	%ebx, %edi
xorl	%ecx, %ebx
psrld	$0x1e, %xmm9
addl	%eax, %ebp
rorl	$0x7, %eax
por	%xmm10, %xmm6
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x2c(%rsp), %edx
pslld	$0x2, %xmm8
pxor	%xmm9, %xmm6
xorl	%ebx, %eax
movdqa	-0x20(%r14), %xmm9
roll	$0x5, %ebp
addl	%edi, %edx
andl	%eax, %esi
pxor	%xmm8, %xmm6
xorl	%ebx, %eax
addl	%ebp, %edx
rorl	$0x7, %ebp
pshufd	$0xee, %xmm3, %xmm7
xorl	%ebx, %esi
movdqa	%xmm6, %xmm8
paddd	%xmm6, %xmm9
movl	%edx, %edi
addl	0x30(%rsp), %ecx
punpcklqdq	%xmm4, %xmm7
xorl	%eax, %ebp
roll	$0x5, %edx
addl	%esi, %ecx
psrldq	$0x4, %xmm8
andl	%ebp, %edi
xorl	%eax, %ebp
pxor	%xmm3, %xmm7
addl	%edx, %ecx
rorl	$0x7, %edx
pxor	%xmm5, %xmm8
xorl	%eax, %edi
movl	%ecx, %esi
addl	0x34(%rsp), %ebx
pxor	%xmm8, %xmm7
xorl	%ebp, %edx
roll	$0x5, %ecx
movdqa	%xmm9, 0x20(%rsp)
addl	%edi, %ebx
andl	%edx, %esi
movdqa	%xmm7, %xmm10
xorl	%ebp, %edx
addl	%ecx, %ebx
rorl	$0x7, %ecx
movdqa	%xmm7, %xmm8
xorl	%ebp, %esi
pslldq	$0xc, %xmm10
paddd	%xmm7, %xmm7
movl	%ebx, %edi
addl	0x38(%rsp), %eax
psrld	$0x1f, %xmm8
xorl	%edx, %ecx
roll	$0x5, %ebx
addl	%esi, %eax
movdqa	%xmm10, %xmm9
andl	%ecx, %edi
xorl	%edx, %ecx
psrld	$0x1e, %xmm10
addl	%ebx, %eax
rorl	$0x7, %ebx
por	%xmm8, %xmm7
xorl	%edx, %edi
movl	%eax, %esi
addl	0x3c(%rsp), %ebp
pslld	$0x2, %xmm9
pxor	%xmm10, %xmm7
xorl	%ecx, %ebx
movdqa	-0x20(%r14), %xmm10
roll	$0x5, %eax
addl	%edi, %ebp
andl	%ebx, %esi
pxor	%xmm9, %xmm7
pshufd	$0xee, %xmm6, %xmm9
xorl	%ecx, %ebx
addl	%eax, %ebp
rorl	$0x7, %eax
pxor	%xmm4, %xmm0
xorl	%ecx, %esi
movl	%ebp, %edi
addl	(%rsp), %edx
punpcklqdq	%xmm7, %xmm9
xorl	%ebx, %eax
roll	$0x5, %ebp
pxor	%xmm1, %xmm0
addl	%esi, %edx
andl	%eax, %edi
movdqa	%xmm10, %xmm8
xorl	%ebx, %eax
paddd	%xmm7, %xmm10
addl	%ebp, %edx
pxor	%xmm9, %xmm0
rorl	$0x7, %ebp
xorl	%ebx, %edi
movl	%edx, %esi
addl	0x4(%rsp), %ecx
movdqa	%xmm0, %xmm9
xorl	%eax, %ebp
roll	$0x5, %edx
movdqa	%xmm10, 0x30(%rsp)
addl	%edi, %ecx
andl	%ebp, %esi
xorl	%eax, %ebp
pslld	$0x2, %xmm0
addl	%edx, %ecx
rorl	$0x7, %edx
psrld	$0x1e, %xmm9
xorl	%eax, %esi
movl	%ecx, %edi
addl	0x8(%rsp), %ebx
por	%xmm9, %xmm0
xorl	%ebp, %edx
roll	$0x5, %ecx
pshufd	$0xee, %xmm7, %xmm10
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
pxor	%xmm5, %xmm1
addl	0x10(%rsp), %ebp
xorl	%ecx, %esi
punpcklqdq	%xmm0, %xmm10
movl	%eax, %edi
roll	$0x5, %eax
pxor	%xmm2, %xmm1
addl	%esi, %ebp
xorl	%ecx, %edi
movdqa	%xmm8, %xmm9
rorl	$0x7, %ebx
paddd	%xmm0, %xmm8
addl	%eax, %ebp
pxor	%xmm10, %xmm1
addl	0x14(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
movdqa	%xmm1, %xmm10
addl	%edi, %edx
xorl	%ebx, %esi
movdqa	%xmm8, (%rsp)
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x18(%rsp), %ecx
pslld	$0x2, %xmm1
xorl	%eax, %esi
movl	%edx, %edi
psrld	$0x1e, %xmm10
roll	$0x5, %edx
addl	%esi, %ecx
xorl	%eax, %edi
rorl	$0x7, %ebp
por	%xmm10, %xmm1
addl	%edx, %ecx
addl	0x1c(%rsp), %ebx
pshufd	$0xee, %xmm0, %xmm8
xorl	%ebp, %edi
movl	%ecx, %esi
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
rorl	$0x7, %edx
addl	%ecx, %ebx
pxor	%xmm6, %xmm2
addl	0x20(%rsp), %eax
xorl	%edx, %esi
punpcklqdq	%xmm1, %xmm8
movl	%ebx, %edi
roll	$0x5, %ebx
pxor	%xmm3, %xmm2
addl	%esi, %eax
xorl	%edx, %edi
movdqa	(%r14), %xmm10
rorl	$0x7, %ecx
paddd	%xmm1, %xmm9
addl	%ebx, %eax
pxor	%xmm8, %xmm2
addl	0x24(%rsp), %ebp
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
movdqa	%xmm2, %xmm8
addl	%edi, %ebp
xorl	%ecx, %esi
movdqa	%xmm9, 0x10(%rsp)
rorl	$0x7, %ebx
addl	%eax, %ebp
addl	0x28(%rsp), %edx
pslld	$0x2, %xmm2
xorl	%ebx, %esi
movl	%ebp, %edi
psrld	$0x1e, %xmm8
roll	$0x5, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
rorl	$0x7, %eax
por	%xmm8, %xmm2
addl	%ebp, %edx
addl	0x2c(%rsp), %ecx
pshufd	$0xee, %xmm1, %xmm9
xorl	%eax, %edi
movl	%edx, %esi
roll	$0x5, %edx
addl	%edi, %ecx
xorl	%eax, %esi
rorl	$0x7, %ebp
addl	%edx, %ecx
pxor	%xmm7, %xmm3
addl	0x30(%rsp), %ebx
xorl	%ebp, %esi
punpcklqdq	%xmm2, %xmm9
movl	%ecx, %edi
roll	$0x5, %ecx
pxor	%xmm4, %xmm3
addl	%esi, %ebx
xorl	%ebp, %edi
movdqa	%xmm10, %xmm8
rorl	$0x7, %edx
paddd	%xmm2, %xmm10
addl	%ecx, %ebx
pxor	%xmm9, %xmm3
addl	0x34(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
roll	$0x5, %ebx
movdqa	%xmm3, %xmm9
addl	%edi, %eax
xorl	%edx, %esi
movdqa	%xmm10, 0x20(%rsp)
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x38(%rsp), %ebp
pslld	$0x2, %xmm3
xorl	%ecx, %esi
movl	%eax, %edi
psrld	$0x1e, %xmm9
roll	$0x5, %eax
addl	%esi, %ebp
xorl	%ecx, %edi
rorl	$0x7, %ebx
por	%xmm9, %xmm3
addl	%eax, %ebp
addl	0x3c(%rsp), %edx
pshufd	$0xee, %xmm2, %xmm10
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
addl	%edi, %edx
xorl	%ebx, %esi
rorl	$0x7, %eax
addl	%ebp, %edx
pxor	%xmm0, %xmm4
addl	(%rsp), %ecx
xorl	%eax, %esi
punpcklqdq	%xmm3, %xmm10
movl	%edx, %edi
roll	$0x5, %edx
pxor	%xmm5, %xmm4
addl	%esi, %ecx
xorl	%eax, %edi
movdqa	%xmm8, %xmm9
rorl	$0x7, %ebp
paddd	%xmm3, %xmm8
addl	%edx, %ecx
pxor	%xmm10, %xmm4
addl	0x4(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
roll	$0x5, %ecx
movdqa	%xmm4, %xmm10
addl	%edi, %ebx
xorl	%ebp, %esi
movdqa	%xmm8, 0x30(%rsp)
rorl	$0x7, %edx
addl	%ecx, %ebx
addl	0x8(%rsp), %eax
pslld	$0x2, %xmm4
xorl	%edx, %esi
movl	%ebx, %edi
psrld	$0x1e, %xmm10
roll	$0x5, %ebx
addl	%esi, %eax
xorl	%edx, %edi
rorl	$0x7, %ecx
por	%xmm10, %xmm4
addl	%ebx, %eax
addl	0xc(%rsp), %ebp
pshufd	$0xee, %xmm3, %xmm8
xorl	%ecx, %edi
movl	%eax, %esi
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
rorl	$0x7, %ebx
addl	%eax, %ebp
pxor	%xmm1, %xmm5
addl	0x10(%rsp), %edx
xorl	%ebx, %esi
punpcklqdq	%xmm4, %xmm8
movl	%ebp, %edi
roll	$0x5, %ebp
pxor	%xmm6, %xmm5
addl	%esi, %edx
xorl	%ebx, %edi
movdqa	%xmm9, %xmm10
rorl	$0x7, %eax
paddd	%xmm4, %xmm9
addl	%ebp, %edx
pxor	%xmm8, %xmm5
addl	0x14(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
roll	$0x5, %edx
movdqa	%xmm5, %xmm8
addl	%edi, %ecx
xorl	%eax, %esi
movdqa	%xmm9, (%rsp)
rorl	$0x7, %ebp
addl	%edx, %ecx
addl	0x18(%rsp), %ebx
pslld	$0x2, %xmm5
xorl	%ebp, %esi
movl	%ecx, %edi
psrld	$0x1e, %xmm8
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
por	%xmm8, %xmm5
addl	%ecx, %ebx
addl	0x1c(%rsp), %eax
pshufd	$0xee, %xmm4, %xmm9
rorl	$0x7, %ecx
movl	%ebx, %esi
xorl	%edx, %edi
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%ecx, %esi
xorl	%edx, %ecx
addl	%ebx, %eax
pxor	%xmm2, %xmm6
addl	0x20(%rsp), %ebp
andl	%ecx, %esi
xorl	%edx, %ecx
rorl	$0x7, %ebx
punpcklqdq	%xmm5, %xmm9
movl	%eax, %edi
xorl	%ecx, %esi
pxor	%xmm7, %xmm6
roll	$0x5, %eax
addl	%esi, %ebp
movdqa	%xmm10, %xmm8
xorl	%ebx, %edi
paddd	%xmm5, %xmm10
xorl	%ecx, %ebx
pxor	%xmm9, %xmm6
addl	%eax, %ebp
addl	0x24(%rsp), %edx
andl	%ebx, %edi
xorl	%ecx, %ebx
rorl	$0x7, %eax
movdqa	%xmm6, %xmm9
movl	%ebp, %esi
xorl	%ebx, %edi
movdqa	%xmm10, 0x10(%rsp)
roll	$0x5, %ebp
addl	%edi, %edx
xorl	%eax, %esi
pslld	$0x2, %xmm6
xorl	%ebx, %eax
addl	%ebp, %edx
psrld	$0x1e, %xmm9
addl	0x28(%rsp), %ecx
andl	%eax, %esi
xorl	%ebx, %eax
por	%xmm9, %xmm6
rorl	$0x7, %ebp
movl	%edx, %edi
xorl	%eax, %esi
roll	$0x5, %edx
pshufd	$0xee, %xmm5, %xmm10
addl	%esi, %ecx
xorl	%ebp, %edi
xorl	%eax, %ebp
addl	%edx, %ecx
addl	0x2c(%rsp), %ebx
andl	%ebp, %edi
xorl	%eax, %ebp
rorl	$0x7, %edx
movl	%ecx, %esi
xorl	%ebp, %edi
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%edx, %esi
xorl	%ebp, %edx
addl	%ecx, %ebx
pxor	%xmm3, %xmm7
addl	0x30(%rsp), %eax
andl	%edx, %esi
xorl	%ebp, %edx
rorl	$0x7, %ecx
punpcklqdq	%xmm6, %xmm10
movl	%ebx, %edi
xorl	%edx, %esi
pxor	%xmm0, %xmm7
roll	$0x5, %ebx
addl	%esi, %eax
movdqa	0x20(%r14), %xmm9
xorl	%ecx, %edi
paddd	%xmm6, %xmm8
xorl	%edx, %ecx
pxor	%xmm10, %xmm7
addl	%ebx, %eax
addl	0x34(%rsp), %ebp
andl	%ecx, %edi
xorl	%edx, %ecx
rorl	$0x7, %ebx
movdqa	%xmm7, %xmm10
movl	%eax, %esi
xorl	%ecx, %edi
movdqa	%xmm8, 0x20(%rsp)
roll	$0x5, %eax
addl	%edi, %ebp
xorl	%ebx, %esi
pslld	$0x2, %xmm7
xorl	%ecx, %ebx
addl	%eax, %ebp
psrld	$0x1e, %xmm10
addl	0x38(%rsp), %edx
andl	%ebx, %esi
xorl	%ecx, %ebx
por	%xmm10, %xmm7
rorl	$0x7, %eax
movl	%ebp, %edi
xorl	%ebx, %esi
roll	$0x5, %ebp
pshufd	$0xee, %xmm6, %xmm8
addl	%esi, %edx
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
pxor	%xmm4, %xmm0
addl	(%rsp), %ebx
andl	%ebp, %esi
xorl	%eax, %ebp
rorl	$0x7, %edx
punpcklqdq	%xmm7, %xmm8
movl	%ecx, %edi
xorl	%ebp, %esi
pxor	%xmm1, %xmm0
roll	$0x5, %ecx
addl	%esi, %ebx
movdqa	%xmm9, %xmm10
xorl	%edx, %edi
paddd	%xmm7, %xmm9
xorl	%ebp, %edx
pxor	%xmm8, %xmm0
addl	%ecx, %ebx
addl	0x4(%rsp), %eax
andl	%edx, %edi
xorl	%ebp, %edx
rorl	$0x7, %ecx
movdqa	%xmm0, %xmm8
movl	%ebx, %esi
xorl	%edx, %edi
movdqa	%xmm9, 0x30(%rsp)
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%ecx, %esi
pslld	$0x2, %xmm0
xorl	%edx, %ecx
addl	%ebx, %eax
psrld	$0x1e, %xmm8
addl	0x8(%rsp), %ebp
andl	%ecx, %esi
xorl	%edx, %ecx
por	%xmm8, %xmm0
rorl	$0x7, %ebx
movl	%eax, %edi
xorl	%ecx, %esi
roll	$0x5, %eax
pshufd	$0xee, %xmm7, %xmm9
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
xorl	%eax, %esi
xorl	%ebx, %eax
addl	%ebp, %edx
pxor	%xmm5, %xmm1
addl	0x10(%rsp), %ecx
andl	%eax, %esi
xorl	%ebx, %eax
rorl	$0x7, %ebp
punpcklqdq	%xmm0, %xmm9
movl	%edx, %edi
xorl	%eax, %esi
pxor	%xmm2, %xmm1
roll	$0x5, %edx
addl	%esi, %ecx
movdqa	%xmm10, %xmm8
xorl	%ebp, %edi
paddd	%xmm0, %xmm10
xorl	%eax, %ebp
pxor	%xmm9, %xmm1
addl	%edx, %ecx
addl	0x14(%rsp), %ebx
andl	%ebp, %edi
xorl	%eax, %ebp
rorl	$0x7, %edx
movdqa	%xmm1, %xmm9
movl	%ecx, %esi
xorl	%ebp, %edi
movdqa	%xmm10, (%rsp)
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%edx, %esi
pslld	$0x2, %xmm1
xorl	%ebp, %edx
addl	%ecx, %ebx
psrld	$0x1e, %xmm9
addl	0x18(%rsp), %eax
andl	%edx, %esi
xorl	%ebp, %edx
por	%xmm9, %xmm1
rorl	$0x7, %ecx
movl	%ebx, %edi
xorl	%edx, %esi
roll	$0x5, %ebx
pshufd	$0xee, %xmm0, %xmm10
addl	%esi, %eax
xorl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
addl	0x1c(%rsp), %ebp
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
pxor	%xmm6, %xmm2
addl	0x20(%rsp), %edx
andl	%ebx, %esi
xorl	%ecx, %ebx
rorl	$0x7, %eax
punpcklqdq	%xmm1, %xmm10
movl	%ebp, %edi
xorl	%ebx, %esi
pxor	%xmm3, %xmm2
roll	$0x5, %ebp
addl	%esi, %edx
movdqa	%xmm8, %xmm9
xorl	%eax, %edi
paddd	%xmm1, %xmm8
xorl	%ebx, %eax
pxor	%xmm10, %xmm2
addl	%ebp, %edx
addl	0x24(%rsp), %ecx
andl	%eax, %edi
xorl	%ebx, %eax
rorl	$0x7, %ebp
movdqa	%xmm2, %xmm10
movl	%edx, %esi
xorl	%eax, %edi
movdqa	%xmm8, 0x10(%rsp)
roll	$0x5, %edx
addl	%edi, %ecx
xorl	%ebp, %esi
pslld	$0x2, %xmm2
xorl	%eax, %ebp
addl	%edx, %ecx
psrld	$0x1e, %xmm10
addl	0x28(%rsp), %ebx
andl	%ebp, %esi
xorl	%eax, %ebp
por	%xmm10, %xmm2
rorl	$0x7, %edx
movl	%ecx, %edi
xorl	%ebp, %esi
roll	$0x5, %ecx
pshufd	$0xee, %xmm1, %xmm8
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
pxor	%xmm7, %xmm3
addl	0x30(%rsp), %ebp
xorl	%ecx, %esi
punpcklqdq	%xmm2, %xmm8
movl	%eax, %edi
roll	$0x5, %eax
pxor	%xmm4, %xmm3
addl	%esi, %ebp
xorl	%ecx, %edi
movdqa	%xmm9, %xmm10
rorl	$0x7, %ebx
paddd	%xmm2, %xmm9
addl	%eax, %ebp
pxor	%xmm8, %xmm3
addl	0x34(%rsp), %edx
xorl	%ebx, %edi
movl	%ebp, %esi
roll	$0x5, %ebp
movdqa	%xmm3, %xmm8
addl	%edi, %edx
xorl	%ebx, %esi
movdqa	%xmm9, 0x20(%rsp)
rorl	$0x7, %eax
addl	%ebp, %edx
addl	0x38(%rsp), %ecx
pslld	$0x2, %xmm3
xorl	%eax, %esi
movl	%edx, %edi
psrld	$0x1e, %xmm8
roll	$0x5, %edx
addl	%esi, %ecx
xorl	%eax, %edi
rorl	$0x7, %ebp
por	%xmm8, %xmm3
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
paddd	%xmm3, %xmm10
addl	%esi, %eax
xorl	%edx, %edi
movdqa	%xmm10, 0x30(%rsp)
rorl	$0x7, %ecx
addl	%ebx, %eax
addl	0x4(%rsp), %ebp
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
xorl	%eax, %esi
rorl	$0x7, %ebp
addl	%edx, %ecx
cmpq	%r10, %r9
je	L_2030
movdqa	0x40(%r14), %xmm6
movdqa	-0x40(%r14), %xmm9
movdqu	(%r9), %xmm0
movdqu	0x10(%r9), %xmm1
movdqu	0x20(%r9), %xmm2
movdqu	0x30(%r9), %xmm3
pshufb	%xmm6, %xmm0
addq	$0x40, %r9
addl	0x10(%rsp), %ebx
xorl	%ebp, %esi
movl	%ecx, %edi
pshufb	%xmm6, %xmm1
roll	$0x5, %ecx
addl	%esi, %ebx
xorl	%ebp, %edi
rorl	$0x7, %edx
paddd	%xmm9, %xmm0
addl	%ecx, %ebx
addl	0x14(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
movdqa	%xmm0, (%rsp)
roll	$0x5, %ebx
addl	%edi, %eax
xorl	%edx, %esi
rorl	$0x7, %ecx
psubd	%xmm9, %xmm0
addl	%ebx, %eax
addl	0x18(%rsp), %ebp
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
pshufb	%xmm6, %xmm2
roll	$0x5, %edx
addl	%esi, %ecx
xorl	%eax, %edi
rorl	$0x7, %ebp
paddd	%xmm9, %xmm1
addl	%edx, %ecx
addl	0x24(%rsp), %ebx
xorl	%ebp, %edi
movl	%ecx, %esi
movdqa	%xmm1, 0x10(%rsp)
roll	$0x5, %ecx
addl	%edi, %ebx
xorl	%ebp, %esi
rorl	$0x7, %edx
psubd	%xmm9, %xmm1
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
pshufb	%xmm6, %xmm3
roll	$0x5, %ebp
addl	%esi, %edx
xorl	%ebx, %edi
rorl	$0x7, %eax
paddd	%xmm9, %xmm2
addl	%ebp, %edx
addl	0x34(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
movdqa	%xmm2, 0x20(%rsp)
roll	$0x5, %edx
addl	%edi, %ecx
xorl	%eax, %esi
rorl	$0x7, %ebp
psubd	%xmm9, %xmm2
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
addl	(%r8), %eax
addl	0x4(%r8), %esi
addl	0x8(%r8), %ecx
addl	0xc(%r8), %edx
movl	%eax, (%r8)
addl	0x10(%r8), %ebp
movl	%esi, 0x4(%r8)
movl	%esi, %ebx
movl	%ecx, 0x8(%r8)
movl	%ecx, %edi
movl	%edx, 0xc(%r8)
xorl	%edx, %edi
movl	%ebp, 0x10(%r8)
andl	%edi, %esi
jmp	L_13e0
nopl	(%rax)
L_2030:
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
addl	(%r8), %eax
addl	0x4(%r8), %esi
addl	0x8(%r8), %ecx
movl	%eax, (%r8)
addl	0xc(%r8), %edx
movl	%esi, 0x4(%r8)
addl	0x10(%r8), %ebp
movl	%ecx, 0x8(%r8)
movl	%edx, 0xc(%r8)
movl	%ebp, 0x10(%r8)
movq	-0x28(%r11), %r14
movq	-0x20(%r11), %r13
movq	-0x18(%r11), %r12
movq	-0x10(%r11), %rbp
movq	-0x8(%r11), %rbx
leaq	(%r11), %rsp
rep	retq
nopl	(%rax)
_avx_shortcut:
sha1_block_data_order_avx:
movq	%rsp, %r11
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
leaq	-0x40(%rsp), %rsp
vzeroupper
andq	$-0x40, %rsp
movq	%rdi, %r8
movq	%rsi, %r9
movq	%rdx, %r10
shlq	$0x6, %r10
addq	%r9, %r10
leaq	K_XX_XX+64(%rip), %r14
movl	(%r8), %eax
movl	0x4(%r8), %ebx
movl	0x8(%r8), %ecx
movl	0xc(%r8), %edx
movl	%ebx, %esi
movl	0x10(%r8), %ebp
movl	%ecx, %edi
xorl	%edx, %edi
andl	%edi, %esi
vmovdqa	0x40(%r14), %xmm6
vmovdqa	-0x40(%r14), %xmm11
vmovdqu	(%r9), %xmm0
vmovdqu	0x10(%r9), %xmm1
vmovdqu	0x20(%r9), %xmm2
vmovdqu	0x30(%r9), %xmm3
vpshufb	%xmm6, %xmm0, %xmm0
addq	$0x40, %r9
vpshufb	%xmm6, %xmm1, %xmm1
vpshufb	%xmm6, %xmm2, %xmm2
vpshufb	%xmm6, %xmm3, %xmm3
vpaddd	%xmm0, %xmm11, %xmm4
vpaddd	%xmm1, %xmm11, %xmm5
vpaddd	%xmm2, %xmm11, %xmm6
vmovdqa	%xmm4, (%rsp)
vmovdqa	%xmm5, 0x10(%rsp)
vmovdqa	%xmm6, 0x20(%rsp)
jmp	L_2210
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2210:
shrdl	$0x2, %ebx, %ebx
xorl	%edx, %esi
vpalignr	$0x8, %xmm0, %xmm1, %xmm4
movl	%eax, %edi
addl	(%rsp), %ebp
vpaddd	%xmm3, %xmm11, %xmm9
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
andl	%eax, %esi
vpsrld	$0x1f, %xmm4, %xmm8
xorl	%ebx, %eax
addl	%ebp, %edx
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %esi
vpslldq	$0xc, %xmm4, %xmm10
vpaddd	%xmm4, %xmm4, %xmm4
movl	%edx, %edi
addl	0x8(%rsp), %ecx
xorl	%eax, %ebp
shldl	$0x5, %edx, %edx
vpsrld	$0x1e, %xmm10, %xmm9
vpor	%xmm4, %xmm8, %xmm4
addl	%esi, %ecx
andl	%ebp, %edi
xorl	%eax, %ebp
addl	%edx, %ecx
vpslld	$0x2, %xmm10, %xmm10
vpxor	%xmm4, %xmm9, %xmm4
shrdl	$0x7, %edx, %edx
xorl	%eax, %edi
movl	%ecx, %esi
addl	0xc(%rsp), %ebx
vpxor	%xmm4, %xmm10, %xmm4
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
vpaddd	%xmm4, %xmm11, %xmm9
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
vpslldq	$0xc, %xmm5, %xmm10
vpaddd	%xmm5, %xmm5, %xmm5
movl	%ebp, %edi
addl	0x18(%rsp), %edx
xorl	%ebx, %eax
shldl	$0x5, %ebp, %ebp
vpsrld	$0x1e, %xmm10, %xmm9
vpor	%xmm5, %xmm8, %xmm5
addl	%esi, %edx
andl	%eax, %edi
xorl	%ebx, %eax
addl	%ebp, %edx
vpslld	$0x2, %xmm10, %xmm10
vpxor	%xmm5, %xmm9, %xmm5
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %edi
movl	%edx, %esi
addl	0x1c(%rsp), %ecx
vpxor	%xmm5, %xmm10, %xmm5
xorl	%eax, %ebp
shldl	$0x5, %edx, %edx
vmovdqa	-0x20(%r14), %xmm11
addl	%edi, %ecx
andl	%ebp, %esi
xorl	%eax, %ebp
addl	%edx, %ecx
shrdl	$0x7, %edx, %edx
xorl	%eax, %esi
vpalignr	$0x8, %xmm2, %xmm3, %xmm6
movl	%ecx, %edi
addl	0x20(%rsp), %ebx
vpaddd	%xmm5, %xmm11, %xmm9
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
xorl	%edx, %esi
vpslldq	$0xc, %xmm6, %xmm10
vpaddd	%xmm6, %xmm6, %xmm6
movl	%eax, %edi
addl	0x28(%rsp), %ebp
xorl	%ecx, %ebx
shldl	$0x5, %eax, %eax
vpsrld	$0x1e, %xmm10, %xmm9
vpor	%xmm6, %xmm8, %xmm6
addl	%esi, %ebp
andl	%ebx, %edi
xorl	%ecx, %ebx
addl	%eax, %ebp
vpslld	$0x2, %xmm10, %xmm10
vpxor	%xmm6, %xmm9, %xmm6
shrdl	$0x7, %eax, %eax
xorl	%ecx, %edi
movl	%ebp, %esi
addl	0x2c(%rsp), %edx
vpxor	%xmm6, %xmm10, %xmm6
xorl	%ebx, %eax
shldl	$0x5, %ebp, %ebp
addl	%edi, %edx
andl	%eax, %esi
xorl	%ebx, %eax
addl	%ebp, %edx
shrdl	$0x7, %ebp, %ebp
xorl	%ebx, %esi
vpalignr	$0x8, %xmm3, %xmm4, %xmm7
movl	%edx, %edi
addl	0x30(%rsp), %ecx
vpaddd	%xmm6, %xmm11, %xmm9
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
vpslldq	$0xc, %xmm7, %xmm10
vpaddd	%xmm7, %xmm7, %xmm7
movl	%ebx, %edi
addl	0x38(%rsp), %eax
xorl	%edx, %ecx
shldl	$0x5, %ebx, %ebx
vpsrld	$0x1e, %xmm10, %xmm9
vpor	%xmm7, %xmm8, %xmm7
addl	%esi, %eax
andl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
vpslld	$0x2, %xmm10, %xmm10
vpxor	%xmm7, %xmm9, %xmm7
shrdl	$0x7, %ebx, %ebx
xorl	%edx, %edi
movl	%eax, %esi
addl	0x3c(%rsp), %ebp
vpxor	%xmm7, %xmm10, %xmm7
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
vpaddd	%xmm7, %xmm11, %xmm9
addl	%esi, %edx
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
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
vpxor	%xmm2, %xmm1, %xmm1
addl	%esi, %ebp
xorl	%ecx, %edi
vpaddd	%xmm0, %xmm11, %xmm9
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
vpaddd	%xmm1, %xmm11, %xmm9
vmovdqa	(%r14), %xmm11
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
vpxor	%xmm2, %xmm8, %xmm2
addl	0x24(%rsp), %ebp
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
vpaddd	%xmm2, %xmm11, %xmm9
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
xorl	%eax, %edi
vpaddd	%xmm3, %xmm11, %xmm9
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
vpaddd	%xmm4, %xmm11, %xmm9
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
andl	%ecx, %esi
xorl	%edx, %ecx
shrdl	$0x7, %ebx, %ebx
vpxor	%xmm7, %xmm6, %xmm6
movl	%eax, %edi
xorl	%ecx, %esi
vpaddd	%xmm5, %xmm11, %xmm9
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
vpaddd	%xmm6, %xmm11, %xmm9
vmovdqa	0x20(%r14), %xmm11
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
vpxor	%xmm7, %xmm8, %xmm7
xorl	%ecx, %edi
xorl	%edx, %ecx
addl	%ebx, %eax
addl	0x34(%rsp), %ebp
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
vpxor	%xmm1, %xmm0, %xmm0
movl	%ecx, %edi
xorl	%ebp, %esi
vpaddd	%xmm7, %xmm11, %xmm9
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
vpaddd	%xmm0, %xmm11, %xmm9
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
vpaddd	%xmm1, %xmm11, %xmm9
shldl	$0x5, %ebp, %ebp
addl	%esi, %edx
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
xorl	%ecx, %esi
movl	%eax, %edi
shldl	$0x5, %eax, %eax
vpxor	%xmm4, %xmm3, %xmm3
addl	%esi, %ebp
xorl	%ecx, %edi
vpaddd	%xmm2, %xmm11, %xmm9
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
vpaddd	%xmm3, %xmm11, %xmm9
xorl	%edx, %esi
movl	%ebx, %edi
shldl	$0x5, %ebx, %ebx
addl	%esi, %eax
vmovdqa	%xmm9, 0x30(%rsp)
xorl	%edx, %edi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x4(%rsp), %ebp
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
xorl	%eax, %esi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
cmpq	%r10, %r9
je	L_2d70
vmovdqa	0x40(%r14), %xmm6
vmovdqa	-0x40(%r14), %xmm11
vmovdqu	(%r9), %xmm0
vmovdqu	0x10(%r9), %xmm1
vmovdqu	0x20(%r9), %xmm2
vmovdqu	0x30(%r9), %xmm3
vpshufb	%xmm6, %xmm0, %xmm0
addq	$0x40, %r9
addl	0x10(%rsp), %ebx
xorl	%ebp, %esi
vpshufb	%xmm6, %xmm1, %xmm1
movl	%ecx, %edi
shldl	$0x5, %ecx, %ecx
vpaddd	%xmm0, %xmm11, %xmm4
addl	%esi, %ebx
xorl	%ebp, %edi
shrdl	$0x7, %edx, %edx
addl	%ecx, %ebx
vmovdqa	%xmm4, (%rsp)
addl	0x14(%rsp), %eax
xorl	%edx, %edi
movl	%ebx, %esi
shldl	$0x5, %ebx, %ebx
addl	%edi, %eax
xorl	%edx, %esi
shrdl	$0x7, %ecx, %ecx
addl	%ebx, %eax
addl	0x18(%rsp), %ebp
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
vpshufb	%xmm6, %xmm2, %xmm2
movl	%edx, %edi
shldl	$0x5, %edx, %edx
vpaddd	%xmm1, %xmm11, %xmm5
addl	%esi, %ecx
xorl	%eax, %edi
shrdl	$0x7, %ebp, %ebp
addl	%edx, %ecx
vmovdqa	%xmm5, 0x10(%rsp)
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
xorl	%ecx, %edi
movl	%eax, %esi
shldl	$0x5, %eax, %eax
addl	%edi, %ebp
xorl	%ecx, %esi
shrdl	$0x7, %ebx, %ebx
addl	%eax, %ebp
addl	0x30(%rsp), %edx
xorl	%ebx, %esi
vpshufb	%xmm6, %xmm3, %xmm3
movl	%ebp, %edi
shldl	$0x5, %ebp, %ebp
vpaddd	%xmm2, %xmm11, %xmm6
addl	%esi, %edx
xorl	%ebx, %edi
shrdl	$0x7, %eax, %eax
addl	%ebp, %edx
vmovdqa	%xmm6, 0x20(%rsp)
addl	0x34(%rsp), %ecx
xorl	%eax, %edi
movl	%edx, %esi
shldl	$0x5, %edx, %edx
addl	%edi, %ecx
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
addl	(%r8), %eax
addl	0x4(%r8), %esi
addl	0x8(%r8), %ecx
addl	0xc(%r8), %edx
movl	%eax, (%r8)
addl	0x10(%r8), %ebp
movl	%esi, 0x4(%r8)
movl	%esi, %ebx
movl	%ecx, 0x8(%r8)
movl	%ecx, %edi
movl	%edx, 0xc(%r8)
xorl	%edx, %edi
movl	%ebp, 0x10(%r8)
andl	%edi, %esi
jmp	L_2210
nopl	(%rax)
L_2d70:
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
vzeroupper
addl	(%r8), %eax
addl	0x4(%r8), %esi
addl	0x8(%r8), %ecx
movl	%eax, (%r8)
addl	0xc(%r8), %edx
movl	%esi, 0x4(%r8)
addl	0x10(%r8), %ebp
movl	%ecx, 0x8(%r8)
movl	%edx, 0xc(%r8)
movl	%ebp, 0x10(%r8)
movq	-0x28(%r11), %r14
movq	-0x20(%r11), %r13
movq	-0x18(%r11), %r12
movq	-0x10(%r11), %rbp
movq	-0x8(%r11), %rbx
leaq	(%r11), %rsp
rep	retq
nopl	(%rax,%rax)
_avx2_shortcut:
sha1_block_data_order_avx2:
movq	%rsp, %r11
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
vzeroupper
movq	%rdi, %r8
movq	%rsi, %r9
movq	%rdx, %r10
leaq	-0x280(%rsp), %rsp
shlq	$0x6, %r10
leaq	0x40(%r9), %r13
andq	$-0x80, %rsp
addq	%r9, %r10
leaq	K_XX_XX+64(%rip), %r14
movl	(%r8), %eax
cmpq	%r10, %r13
cmovaeq	%r9, %r13
movl	0x4(%r8), %ebp
movl	0x8(%r8), %ecx
movl	0xc(%r8), %edx
movl	0x10(%r8), %esi
vmovdqu	0x40(%r14), %ymm6
vmovdqu	(%r9), %xmm0
vmovdqu	0x10(%r9), %xmm1
vmovdqu	0x20(%r9), %xmm2
vmovdqu	0x30(%r9), %xmm3
leaq	0x40(%r9), %r9
vinserti128	$0x1, (%r13), %ymm0, %ymm0
vinserti128	$0x1, 0x10(%r13), %ymm1, %ymm1
vpshufb	%ymm6, %ymm0, %ymm0
vinserti128	$0x1, 0x20(%r13), %ymm2, %ymm2
vpshufb	%ymm6, %ymm1, %ymm1
vinserti128	$0x1, 0x30(%r13), %ymm3, %ymm3
vpshufb	%ymm6, %ymm2, %ymm2
vmovdqu	-0x40(%r14), %ymm11
vpshufb	%ymm6, %ymm3, %ymm3
vpaddd	%ymm0, %ymm11, %ymm4
vpaddd	%ymm1, %ymm11, %ymm5
vmovdqu	%ymm4, (%rsp)
vpaddd	%ymm2, %ymm11, %ymm6
vmovdqu	%ymm5, 0x20(%rsp)
vpaddd	%ymm3, %ymm11, %ymm7
vmovdqu	%ymm6, 0x40(%rsp)
vmovdqu	%ymm7, 0x60(%rsp)
vpalignr	$0x8, %ymm0, %ymm1, %ymm4
vpsrldq	$0x4, %ymm3, %ymm8
vpxor	%ymm0, %ymm4, %ymm4
vpxor	%ymm2, %ymm8, %ymm8
vpxor	%ymm4, %ymm8, %ymm4
vpsrld	$0x1f, %ymm4, %ymm8
vpslldq	$0xc, %ymm4, %ymm10
vpaddd	%ymm4, %ymm4, %ymm4
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm4, %ymm8, %ymm4
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm4, %ymm9, %ymm4
vpxor	%ymm4, %ymm10, %ymm4
vpaddd	%ymm4, %ymm11, %ymm9
vmovdqu	%ymm9, 0x80(%rsp)
vpalignr	$0x8, %ymm1, %ymm2, %ymm5
vpsrldq	$0x4, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm3, %ymm8, %ymm8
vpxor	%ymm5, %ymm8, %ymm5
vpsrld	$0x1f, %ymm5, %ymm8
vmovdqu	-0x20(%r14), %ymm11
vpslldq	$0xc, %ymm5, %ymm10
vpaddd	%ymm5, %ymm5, %ymm5
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm5, %ymm8, %ymm5
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm5, %ymm10, %ymm5
vpaddd	%ymm5, %ymm11, %ymm9
vmovdqu	%ymm9, 0xa0(%rsp)
vpalignr	$0x8, %ymm2, %ymm3, %ymm6
vpsrldq	$0x4, %ymm5, %ymm8
vpxor	%ymm2, %ymm6, %ymm6
vpxor	%ymm4, %ymm8, %ymm8
vpxor	%ymm6, %ymm8, %ymm6
vpsrld	$0x1f, %ymm6, %ymm8
vpslldq	$0xc, %ymm6, %ymm10
vpaddd	%ymm6, %ymm6, %ymm6
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm6, %ymm8, %ymm6
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm6, %ymm9, %ymm6
vpxor	%ymm6, %ymm10, %ymm6
vpaddd	%ymm6, %ymm11, %ymm9
vmovdqu	%ymm9, 0xc0(%rsp)
vpalignr	$0x8, %ymm3, %ymm4, %ymm7
vpsrldq	$0x4, %ymm6, %ymm8
vpxor	%ymm3, %ymm7, %ymm7
vpxor	%ymm5, %ymm8, %ymm8
vpxor	%ymm7, %ymm8, %ymm7
vpsrld	$0x1f, %ymm7, %ymm8
vpslldq	$0xc, %ymm7, %ymm10
vpaddd	%ymm7, %ymm7, %ymm7
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm7, %ymm8, %ymm7
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm7, %ymm9, %ymm7
vpxor	%ymm7, %ymm10, %ymm7
vpaddd	%ymm7, %ymm11, %ymm9
vmovdqu	%ymm9, 0xe0(%rsp)
leaq	0x80(%rsp), %r13
jmp	L_30e0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_30e0:
rorxl	$0x2, %ebp, %ebx
andnl	%edx, %ebp, %edi
andl	%ecx, %ebp
xorl	%edi, %ebp
jmp	L_3100
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_3100:
vpalignr	$0x8, %ymm6, %ymm7, %ymm8
vpxor	%ymm4, %ymm0, %ymm0
addl	-0x80(%r13), %esi
andnl	%ecx, %eax, %edi
vpxor	%ymm1, %ymm0, %ymm0
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
vpxor	%ymm0, %ymm8, %ymm0
andl	%ebx, %eax
addl	%r12d, %esi
xorl	%edi, %eax
vpsrld	$0x1e, %ymm0, %ymm8
vpslld	$0x2, %ymm0, %ymm0
addl	-0x7c(%r13), %edx
andnl	%ebx, %esi, %edi
addl	%eax, %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
andl	%ebp, %esi
vpor	%ymm0, %ymm8, %ymm0
addl	%r12d, %edx
xorl	%edi, %esi
addl	-0x78(%r13), %ecx
andnl	%ebp, %edx, %edi
vpaddd	%ymm0, %ymm11, %ymm9
addl	%esi, %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
andl	%eax, %edx
vmovdqu	%ymm9, 0x100(%rsp)
addl	%r12d, %ecx
xorl	%edi, %edx
addl	-0x74(%r13), %ebx
andnl	%eax, %ecx, %edi
addl	%edx, %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
andl	%esi, %ecx
addl	%r12d, %ebx
xorl	%edi, %ecx
addl	-0x60(%r13), %ebp
andnl	%esi, %ebx, %edi
addl	%ecx, %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
andl	%edx, %ebx
addl	%r12d, %ebp
xorl	%edi, %ebx
vpalignr	$0x8, %ymm7, %ymm0, %ymm8
vpxor	%ymm5, %ymm1, %ymm1
addl	-0x5c(%r13), %eax
andnl	%edx, %ebp, %edi
vpxor	%ymm2, %ymm1, %ymm1
addl	%ebx, %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
vpxor	%ymm1, %ymm8, %ymm1
andl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edi, %ebp
vpsrld	$0x1e, %ymm1, %ymm8
vpslld	$0x2, %ymm1, %ymm1
addl	-0x58(%r13), %esi
andnl	%ecx, %eax, %edi
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
vpor	%ymm1, %ymm8, %ymm1
addl	%r12d, %esi
xorl	%edi, %eax
addl	-0x54(%r13), %edx
andnl	%ebx, %esi, %edi
vpaddd	%ymm1, %ymm11, %ymm9
addl	%eax, %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
andl	%ebp, %esi
vmovdqu	%ymm9, 0x120(%rsp)
addl	%r12d, %edx
xorl	%edi, %esi
addl	-0x40(%r13), %ecx
andnl	%ebp, %edx, %edi
addl	%esi, %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
andl	%eax, %edx
addl	%r12d, %ecx
xorl	%edi, %edx
addl	-0x3c(%r13), %ebx
andnl	%eax, %ecx, %edi
addl	%edx, %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
andl	%esi, %ecx
addl	%r12d, %ebx
xorl	%edi, %ecx
vpalignr	$0x8, %ymm0, %ymm1, %ymm8
vpxor	%ymm6, %ymm2, %ymm2
addl	-0x38(%r13), %ebp
andnl	%esi, %ebx, %edi
vpxor	%ymm3, %ymm2, %ymm2
vmovdqu	(%r14), %ymm11
addl	%ecx, %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
vpxor	%ymm2, %ymm8, %ymm2
andl	%edx, %ebx
addl	%r12d, %ebp
xorl	%edi, %ebx
vpsrld	$0x1e, %ymm2, %ymm8
vpslld	$0x2, %ymm2, %ymm2
addl	-0x34(%r13), %eax
andnl	%edx, %ebp, %edi
addl	%ebx, %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
andl	%ecx, %ebp
vpor	%ymm2, %ymm8, %ymm2
addl	%r12d, %eax
xorl	%edi, %ebp
addl	-0x20(%r13), %esi
andnl	%ecx, %eax, %edi
vpaddd	%ymm2, %ymm11, %ymm9
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
vmovdqu	%ymm9, 0x140(%rsp)
addl	%r12d, %esi
xorl	%edi, %eax
addl	-0x1c(%r13), %edx
andnl	%ebx, %esi, %edi
addl	%eax, %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
andl	%ebp, %esi
addl	%r12d, %edx
xorl	%edi, %esi
addl	-0x18(%r13), %ecx
andnl	%ebp, %edx, %edi
addl	%esi, %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
andl	%eax, %edx
addl	%r12d, %ecx
xorl	%edi, %edx
vpalignr	$0x8, %ymm1, %ymm2, %ymm8
vpxor	%ymm7, %ymm3, %ymm3
addl	-0x14(%r13), %ebx
andnl	%eax, %ecx, %edi
vpxor	%ymm4, %ymm3, %ymm3
addl	%edx, %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
vpxor	%ymm3, %ymm8, %ymm3
andl	%esi, %ecx
addl	%r12d, %ebx
xorl	%edi, %ecx
vpsrld	$0x1e, %ymm3, %ymm8
vpslld	$0x2, %ymm3, %ymm3
addl	(%r13), %ebp
andnl	%esi, %ebx, %edi
addl	%ecx, %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
andl	%edx, %ebx
vpor	%ymm3, %ymm8, %ymm3
addl	%r12d, %ebp
xorl	%edi, %ebx
addl	0x4(%r13), %eax
andnl	%edx, %ebp, %edi
vpaddd	%ymm3, %ymm11, %ymm9
addl	%ebx, %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
andl	%ecx, %ebp
vmovdqu	%ymm9, 0x160(%rsp)
addl	%r12d, %eax
xorl	%edi, %ebp
addl	0x8(%r13), %esi
andnl	%ecx, %eax, %edi
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
addl	%r12d, %esi
xorl	%edi, %eax
addl	0xc(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
vpalignr	$0x8, %ymm2, %ymm3, %ymm8
vpxor	%ymm0, %ymm4, %ymm4
addl	0x20(%r13), %ecx
leal	(%rcx,%rsi), %ecx
vpxor	%ymm5, %ymm4, %ymm4
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
vpxor	%ymm4, %ymm8, %ymm4
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	0x24(%r13), %ebx
vpsrld	$0x1e, %ymm4, %ymm8
vpslld	$0x2, %ymm4, %ymm4
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
vpor	%ymm4, %ymm8, %ymm4
addl	0x28(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
vpaddd	%ymm4, %ymm11, %ymm9
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	0x2c(%r13), %eax
vmovdqu	%ymm9, 0x180(%rsp)
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	0x40(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
vpalignr	$0x8, %ymm3, %ymm4, %ymm8
vpxor	%ymm1, %ymm5, %ymm5
addl	0x44(%r13), %edx
leal	(%rdx,%rax), %edx
vpxor	%ymm6, %ymm5, %ymm5
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
vpxor	%ymm5, %ymm8, %ymm5
addl	%r12d, %edx
xorl	%ebx, %esi
addl	0x48(%r13), %ecx
vpsrld	$0x1e, %ymm5, %ymm8
vpslld	$0x2, %ymm5, %ymm5
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
vpor	%ymm5, %ymm8, %ymm5
addl	0x4c(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
vpaddd	%ymm5, %ymm11, %ymm9
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	0x60(%r13), %ebp
vmovdqu	%ymm9, 0x1a0(%rsp)
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	0x64(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
vpalignr	$0x8, %ymm4, %ymm5, %ymm8
vpxor	%ymm2, %ymm6, %ymm6
addl	0x68(%r13), %esi
leal	(%rsi,%rbp), %esi
vpxor	%ymm7, %ymm6, %ymm6
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
vpxor	%ymm6, %ymm8, %ymm6
addl	%r12d, %esi
xorl	%ecx, %eax
addl	0x6c(%r13), %edx
leaq	0x100(%r13), %r13
vpsrld	$0x1e, %ymm6, %ymm8
vpslld	$0x2, %ymm6, %ymm6
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
vpor	%ymm6, %ymm8, %ymm6
addl	-0x80(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
vpaddd	%ymm6, %ymm11, %ymm9
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x7c(%r13), %ebx
vmovdqu	%ymm9, 0x1c0(%rsp)
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	-0x78(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
vpalignr	$0x8, %ymm5, %ymm6, %ymm8
vpxor	%ymm3, %ymm7, %ymm7
addl	-0x74(%r13), %eax
leal	(%rax,%rbx), %eax
vpxor	%ymm0, %ymm7, %ymm7
vmovdqu	0x20(%r14), %ymm11
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
vpxor	%ymm7, %ymm8, %ymm7
addl	%r12d, %eax
xorl	%edx, %ebp
addl	-0x60(%r13), %esi
vpsrld	$0x1e, %ymm7, %ymm8
vpslld	$0x2, %ymm7, %ymm7
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
vpor	%ymm7, %ymm8, %ymm7
addl	-0x5c(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
vpaddd	%ymm7, %ymm11, %ymm9
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	-0x58(%r13), %ecx
vmovdqu	%ymm9, 0x1e0(%rsp)
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x54(%r13), %ebx
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
andl	%edi, %ecx
jmp	L_36e0
nopl	(%rax)
L_36e0:
vpalignr	$0x8, %ymm6, %ymm7, %ymm8
vpxor	%ymm4, %ymm0, %ymm0
addl	-0x40(%r13), %ebp
xorl	%esi, %ecx
vpxor	%ymm1, %ymm0, %ymm0
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
vpxor	%ymm0, %ymm8, %ymm0
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
vpsrld	$0x1e, %ymm0, %ymm8
vpslld	$0x2, %ymm0, %ymm0
addl	%r12d, %ebp
andl	%edi, %ebx
addl	-0x3c(%r13), %eax
xorl	%edx, %ebx
movl	%ecx, %edi
xorl	%edx, %edi
vpor	%ymm0, %ymm8, %ymm0
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
vpaddd	%ymm0, %ymm11, %ymm9
addl	%r12d, %eax
andl	%edi, %ebp
addl	-0x38(%r13), %esi
xorl	%ecx, %ebp
vmovdqu	%ymm9, 0x200(%rsp)
movl	%ebx, %edi
xorl	%ecx, %edi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
andl	%edi, %eax
addl	-0x34(%r13), %edx
xorl	%ebx, %eax
movl	%ebp, %edi
xorl	%ebx, %edi
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
andl	%edi, %esi
addl	-0x20(%r13), %ecx
xorl	%ebp, %esi
movl	%eax, %edi
xorl	%ebp, %edi
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
andl	%edi, %edx
vpalignr	$0x8, %ymm7, %ymm0, %ymm8
vpxor	%ymm5, %ymm1, %ymm1
addl	-0x1c(%r13), %ebx
xorl	%eax, %edx
vpxor	%ymm2, %ymm1, %ymm1
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
vpxor	%ymm1, %ymm8, %ymm1
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
vpsrld	$0x1e, %ymm1, %ymm8
vpslld	$0x2, %ymm1, %ymm1
addl	%r12d, %ebx
andl	%edi, %ecx
addl	-0x18(%r13), %ebp
xorl	%esi, %ecx
movl	%edx, %edi
xorl	%esi, %edi
vpor	%ymm1, %ymm8, %ymm1
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
vpaddd	%ymm1, %ymm11, %ymm9
addl	%r12d, %ebp
andl	%edi, %ebx
addl	-0x14(%r13), %eax
xorl	%edx, %ebx
vmovdqu	%ymm9, 0x220(%rsp)
movl	%ecx, %edi
xorl	%edx, %edi
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
andl	%edi, %ebp
addl	(%r13), %esi
xorl	%ecx, %ebp
movl	%ebx, %edi
xorl	%ecx, %edi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
andl	%edi, %eax
addl	0x4(%r13), %edx
xorl	%ebx, %eax
movl	%ebp, %edi
xorl	%ebx, %edi
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
andl	%edi, %esi
vpalignr	$0x8, %ymm0, %ymm1, %ymm8
vpxor	%ymm6, %ymm2, %ymm2
addl	0x8(%r13), %ecx
xorl	%ebp, %esi
vpxor	%ymm3, %ymm2, %ymm2
movl	%eax, %edi
xorl	%ebp, %edi
leal	(%rcx,%rsi), %ecx
vpxor	%ymm2, %ymm8, %ymm2
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
vpsrld	$0x1e, %ymm2, %ymm8
vpslld	$0x2, %ymm2, %ymm2
addl	%r12d, %ecx
andl	%edi, %edx
addl	0xc(%r13), %ebx
xorl	%eax, %edx
movl	%esi, %edi
xorl	%eax, %edi
vpor	%ymm2, %ymm8, %ymm2
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
vpaddd	%ymm2, %ymm11, %ymm9
addl	%r12d, %ebx
andl	%edi, %ecx
addl	0x20(%r13), %ebp
xorl	%esi, %ecx
vmovdqu	%ymm9, 0x240(%rsp)
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
andl	%edi, %ebx
addl	0x24(%r13), %eax
xorl	%edx, %ebx
movl	%ecx, %edi
xorl	%edx, %edi
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
andl	%edi, %ebp
addl	0x28(%r13), %esi
xorl	%ecx, %ebp
movl	%ebx, %edi
xorl	%ecx, %edi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
andl	%edi, %eax
vpalignr	$0x8, %ymm1, %ymm2, %ymm8
vpxor	%ymm7, %ymm3, %ymm3
addl	0x2c(%r13), %edx
xorl	%ebx, %eax
vpxor	%ymm4, %ymm3, %ymm3
movl	%ebp, %edi
xorl	%ebx, %edi
leal	(%rdx,%rax), %edx
vpxor	%ymm3, %ymm8, %ymm3
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
vpsrld	$0x1e, %ymm3, %ymm8
vpslld	$0x2, %ymm3, %ymm3
addl	%r12d, %edx
andl	%edi, %esi
addl	0x40(%r13), %ecx
xorl	%ebp, %esi
movl	%eax, %edi
xorl	%ebp, %edi
vpor	%ymm3, %ymm8, %ymm3
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
vpaddd	%ymm3, %ymm11, %ymm9
addl	%r12d, %ecx
andl	%edi, %edx
addl	0x44(%r13), %ebx
xorl	%eax, %edx
vmovdqu	%ymm9, 0x260(%rsp)
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
andl	%edi, %ecx
addl	0x48(%r13), %ebp
xorl	%esi, %ecx
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
andl	%edi, %ebx
addl	0x4c(%r13), %eax
xorl	%edx, %ebx
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	0x60(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	0x64(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	0x68(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	0x6c(%r13), %ebx
leaq	0x100(%r13), %r13
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	-0x80(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	-0x7c(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	-0x78(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	-0x74(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	-0x60(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x5c(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	-0x58(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	-0x54(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	-0x40(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	-0x3c(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	-0x38(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x34(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	-0x20(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	-0x1c(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	-0x18(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	-0x14(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
addl	%r12d, %edx
leaq	0x80(%r9), %r13
leaq	0x80(%r9), %rdi
cmpq	%r10, %r13
cmovaeq	%r9, %r13
addl	(%r8), %edx
addl	0x4(%r8), %esi
addl	0x8(%r8), %ebp
movl	%edx, (%r8)
addl	0xc(%r8), %ebx
movl	%esi, 0x4(%r8)
movl	%edx, %eax
addl	0x10(%r8), %ecx
movl	%ebp, %r12d
movl	%ebp, 0x8(%r8)
movl	%ebx, %edx
movl	%ebx, 0xc(%r8)
movl	%esi, %ebp
movl	%ecx, 0x10(%r8)
movl	%ecx, %esi
movl	%r12d, %ecx
cmpq	%r10, %r9
je	L_4784
vmovdqu	0x40(%r14), %ymm6
cmpq	%r10, %rdi
ja	L_3cc0
vmovdqu	-0x40(%rdi), %xmm0
vmovdqu	-0x30(%rdi), %xmm1
vmovdqu	-0x20(%rdi), %xmm2
vmovdqu	-0x10(%rdi), %xmm3
vinserti128	$0x1, (%r13), %ymm0, %ymm0
vinserti128	$0x1, 0x10(%r13), %ymm1, %ymm1
vinserti128	$0x1, 0x20(%r13), %ymm2, %ymm2
vinserti128	$0x1, 0x30(%r13), %ymm3, %ymm3
jmp	L_3cc0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_3cc0:
leaq	0x90(%rsp), %r13
rorxl	$0x2, %ebp, %ebx
andnl	%edx, %ebp, %edi
andl	%ecx, %ebp
xorl	%edi, %ebp
subq	$-0x80, %r9
addl	-0x80(%r13), %esi
andnl	%ecx, %eax, %edi
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
addl	%r12d, %esi
xorl	%edi, %eax
addl	-0x7c(%r13), %edx
andnl	%ebx, %esi, %edi
addl	%eax, %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
andl	%ebp, %esi
addl	%r12d, %edx
xorl	%edi, %esi
addl	-0x78(%r13), %ecx
andnl	%ebp, %edx, %edi
addl	%esi, %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
andl	%eax, %edx
addl	%r12d, %ecx
xorl	%edi, %edx
addl	-0x74(%r13), %ebx
andnl	%eax, %ecx, %edi
addl	%edx, %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
andl	%esi, %ecx
addl	%r12d, %ebx
xorl	%edi, %ecx
addl	-0x60(%r13), %ebp
andnl	%esi, %ebx, %edi
addl	%ecx, %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
andl	%edx, %ebx
addl	%r12d, %ebp
xorl	%edi, %ebx
addl	-0x5c(%r13), %eax
andnl	%edx, %ebp, %edi
addl	%ebx, %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
andl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edi, %ebp
addl	-0x58(%r13), %esi
andnl	%ecx, %eax, %edi
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
addl	%r12d, %esi
xorl	%edi, %eax
addl	-0x54(%r13), %edx
andnl	%ebx, %esi, %edi
addl	%eax, %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
andl	%ebp, %esi
addl	%r12d, %edx
xorl	%edi, %esi
addl	-0x40(%r13), %ecx
andnl	%ebp, %edx, %edi
addl	%esi, %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
andl	%eax, %edx
addl	%r12d, %ecx
xorl	%edi, %edx
addl	-0x3c(%r13), %ebx
andnl	%eax, %ecx, %edi
addl	%edx, %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
andl	%esi, %ecx
addl	%r12d, %ebx
xorl	%edi, %ecx
addl	-0x38(%r13), %ebp
andnl	%esi, %ebx, %edi
addl	%ecx, %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
andl	%edx, %ebx
addl	%r12d, %ebp
xorl	%edi, %ebx
addl	-0x34(%r13), %eax
andnl	%edx, %ebp, %edi
addl	%ebx, %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
andl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edi, %ebp
addl	-0x20(%r13), %esi
andnl	%ecx, %eax, %edi
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
addl	%r12d, %esi
xorl	%edi, %eax
addl	-0x1c(%r13), %edx
andnl	%ebx, %esi, %edi
addl	%eax, %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
andl	%ebp, %esi
addl	%r12d, %edx
xorl	%edi, %esi
addl	-0x18(%r13), %ecx
andnl	%ebp, %edx, %edi
addl	%esi, %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
andl	%eax, %edx
addl	%r12d, %ecx
xorl	%edi, %edx
addl	-0x14(%r13), %ebx
andnl	%eax, %ecx, %edi
addl	%edx, %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
andl	%esi, %ecx
addl	%r12d, %ebx
xorl	%edi, %ecx
addl	(%r13), %ebp
andnl	%esi, %ebx, %edi
addl	%ecx, %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
andl	%edx, %ebx
addl	%r12d, %ebp
xorl	%edi, %ebx
addl	0x4(%r13), %eax
andnl	%edx, %ebp, %edi
addl	%ebx, %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
andl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edi, %ebp
addl	0x8(%r13), %esi
andnl	%ecx, %eax, %edi
addl	%ebp, %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
andl	%ebx, %eax
addl	%r12d, %esi
xorl	%edi, %eax
addl	0xc(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	0x20(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	0x24(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	0x28(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	0x2c(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	0x40(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
vmovdqu	-0x40(%r14), %ymm11
vpshufb	%ymm6, %ymm0, %ymm0
addl	0x44(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	0x48(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	0x4c(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	0x60(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	0x64(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
vpshufb	%ymm6, %ymm1, %ymm1
vpaddd	%ymm0, %ymm11, %ymm8
addl	0x68(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	0x6c(%r13), %edx
leaq	0x100(%r13), %r13
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	-0x80(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x7c(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	-0x78(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
vmovdqu	%ymm8, (%rsp)
vpshufb	%ymm6, %ymm2, %ymm2
vpaddd	%ymm1, %ymm11, %ymm9
addl	-0x74(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	-0x60(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	-0x5c(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
addl	-0x58(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x54(%r13), %ebx
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
andl	%edi, %ecx
vmovdqu	%ymm9, 0x20(%rsp)
vpshufb	%ymm6, %ymm3, %ymm3
vpaddd	%ymm2, %ymm11, %ymm6
addl	-0x40(%r13), %ebp
xorl	%esi, %ecx
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
andl	%edi, %ebx
addl	-0x3c(%r13), %eax
xorl	%edx, %ebx
movl	%ecx, %edi
xorl	%edx, %edi
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
andl	%edi, %ebp
addl	-0x38(%r13), %esi
xorl	%ecx, %ebp
movl	%ebx, %edi
xorl	%ecx, %edi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
andl	%edi, %eax
addl	-0x34(%r13), %edx
xorl	%ebx, %eax
movl	%ebp, %edi
xorl	%ebx, %edi
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
andl	%edi, %esi
addl	-0x20(%r13), %ecx
xorl	%ebp, %esi
movl	%eax, %edi
xorl	%ebp, %edi
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
andl	%edi, %edx
jmp	L_4220
nopw	%cs:(%rax,%rax)
nop
L_4220:
vmovdqu	%ymm6, 0x40(%rsp)
vpaddd	%ymm3, %ymm11, %ymm7
addl	-0x1c(%r13), %ebx
xorl	%eax, %edx
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
andl	%edi, %ecx
addl	-0x18(%r13), %ebp
xorl	%esi, %ecx
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
andl	%edi, %ebx
addl	-0x14(%r13), %eax
xorl	%edx, %ebx
movl	%ecx, %edi
xorl	%edx, %edi
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
andl	%edi, %ebp
addl	(%r13), %esi
xorl	%ecx, %ebp
movl	%ebx, %edi
xorl	%ecx, %edi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
andl	%edi, %eax
addl	0x4(%r13), %edx
xorl	%ebx, %eax
movl	%ebp, %edi
xorl	%ebx, %edi
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
andl	%edi, %esi
vmovdqu	%ymm7, 0x60(%rsp)
addl	0x8(%r13), %ecx
xorl	%ebp, %esi
movl	%eax, %edi
xorl	%ebp, %edi
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
andl	%edi, %edx
addl	0xc(%r13), %ebx
xorl	%eax, %edx
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
andl	%edi, %ecx
addl	0x20(%r13), %ebp
xorl	%esi, %ecx
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
andl	%edi, %ebx
addl	0x24(%r13), %eax
xorl	%edx, %ebx
movl	%ecx, %edi
xorl	%edx, %edi
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
andl	%edi, %ebp
addl	0x28(%r13), %esi
xorl	%ecx, %ebp
movl	%ebx, %edi
xorl	%ecx, %edi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
andl	%edi, %eax
vpalignr	$0x8, %ymm0, %ymm1, %ymm4
addl	0x2c(%r13), %edx
xorl	%ebx, %eax
movl	%ebp, %edi
xorl	%ebx, %edi
vpsrldq	$0x4, %ymm3, %ymm8
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
vpxor	%ymm0, %ymm4, %ymm4
vpxor	%ymm2, %ymm8, %ymm8
xorl	%ebp, %esi
addl	%r12d, %edx
vpxor	%ymm4, %ymm8, %ymm4
andl	%edi, %esi
addl	0x40(%r13), %ecx
xorl	%ebp, %esi
movl	%eax, %edi
vpsrld	$0x1f, %ymm4, %ymm8
xorl	%ebp, %edi
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
vpslldq	$0xc, %ymm4, %ymm10
vpaddd	%ymm4, %ymm4, %ymm4
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm4, %ymm8, %ymm4
addl	%r12d, %ecx
andl	%edi, %edx
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm4, %ymm9, %ymm4
addl	0x44(%r13), %ebx
xorl	%eax, %edx
vpxor	%ymm4, %ymm10, %ymm4
movl	%esi, %edi
xorl	%eax, %edi
leal	(%rbx,%rdx), %ebx
vpaddd	%ymm4, %ymm11, %ymm9
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
vmovdqu	%ymm9, 0x80(%rsp)
addl	%r12d, %ebx
andl	%edi, %ecx
addl	0x48(%r13), %ebp
xorl	%esi, %ecx
movl	%edx, %edi
xorl	%esi, %edi
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
andl	%edi, %ebx
addl	0x4c(%r13), %eax
xorl	%edx, %ebx
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
vpalignr	$0x8, %ymm1, %ymm2, %ymm5
addl	0x60(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
vpsrldq	$0x4, %ymm4, %ymm8
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
vpxor	%ymm1, %ymm5, %ymm5
vpxor	%ymm3, %ymm8, %ymm8
addl	0x64(%r13), %edx
leal	(%rdx,%rax), %edx
vpxor	%ymm5, %ymm8, %ymm5
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
xorl	%ebp, %esi
addl	%r12d, %edx
vpsrld	$0x1f, %ymm5, %ymm8
vmovdqu	-0x20(%r14), %ymm11
xorl	%ebx, %esi
addl	0x68(%r13), %ecx
leal	(%rcx,%rsi), %ecx
vpslldq	$0xc, %ymm5, %ymm10
vpaddd	%ymm5, %ymm5, %ymm5
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm5, %ymm8, %ymm5
xorl	%eax, %edx
addl	%r12d, %ecx
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm5, %ymm9, %ymm5
xorl	%ebp, %edx
addl	0x6c(%r13), %ebx
leaq	0x100(%r13), %r13
vpxor	%ymm5, %ymm10, %ymm5
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
vpaddd	%ymm5, %ymm11, %ymm9
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
vmovdqu	%ymm9, 0xa0(%rsp)
addl	-0x80(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
vpalignr	$0x8, %ymm2, %ymm3, %ymm6
addl	-0x7c(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
vpsrldq	$0x4, %ymm5, %ymm8
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
vpxor	%ymm2, %ymm6, %ymm6
vpxor	%ymm4, %ymm8, %ymm8
addl	-0x78(%r13), %esi
leal	(%rsi,%rbp), %esi
vpxor	%ymm6, %ymm8, %ymm6
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
vpsrld	$0x1f, %ymm6, %ymm8
xorl	%ecx, %eax
addl	-0x74(%r13), %edx
leal	(%rdx,%rax), %edx
vpslldq	$0xc, %ymm6, %ymm10
vpaddd	%ymm6, %ymm6, %ymm6
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm6, %ymm8, %ymm6
xorl	%ebp, %esi
addl	%r12d, %edx
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm6, %ymm9, %ymm6
xorl	%ebx, %esi
addl	-0x60(%r13), %ecx
vpxor	%ymm6, %ymm10, %ymm6
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
vpaddd	%ymm6, %ymm11, %ymm9
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
vmovdqu	%ymm9, 0xc0(%rsp)
addl	-0x5c(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
vpalignr	$0x8, %ymm3, %ymm4, %ymm7
addl	-0x58(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
vpsrldq	$0x4, %ymm6, %ymm8
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
vpxor	%ymm3, %ymm7, %ymm7
vpxor	%ymm5, %ymm8, %ymm8
addl	-0x54(%r13), %eax
leal	(%rax,%rbx), %eax
vpxor	%ymm7, %ymm8, %ymm7
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
vpsrld	$0x1f, %ymm7, %ymm8
xorl	%edx, %ebp
addl	-0x40(%r13), %esi
leal	(%rsi,%rbp), %esi
vpslldq	$0xc, %ymm7, %ymm10
vpaddd	%ymm7, %ymm7, %ymm7
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
vpsrld	$0x1e, %ymm10, %ymm9
vpor	%ymm7, %ymm8, %ymm7
xorl	%ebx, %eax
addl	%r12d, %esi
vpslld	$0x2, %ymm10, %ymm10
vpxor	%ymm7, %ymm9, %ymm7
xorl	%ecx, %eax
addl	-0x3c(%r13), %edx
vpxor	%ymm7, %ymm10, %ymm7
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
rorxl	$0x2, %esi, %eax
vpaddd	%ymm7, %ymm11, %ymm9
xorl	%ebp, %esi
addl	%r12d, %edx
xorl	%ebx, %esi
vmovdqu	%ymm9, 0xe0(%rsp)
addl	-0x38(%r13), %ecx
leal	(%rcx,%rsi), %ecx
rorxl	$0x1b, %edx, %r12d
rorxl	$0x2, %edx, %esi
xorl	%eax, %edx
addl	%r12d, %ecx
xorl	%ebp, %edx
addl	-0x34(%r13), %ebx
leal	(%rbx,%rdx), %ebx
rorxl	$0x1b, %ecx, %r12d
rorxl	$0x2, %ecx, %edx
xorl	%esi, %ecx
addl	%r12d, %ebx
xorl	%eax, %ecx
addl	-0x20(%r13), %ebp
leal	(%rcx,%rbp), %ebp
rorxl	$0x1b, %ebx, %r12d
rorxl	$0x2, %ebx, %ecx
xorl	%edx, %ebx
addl	%r12d, %ebp
xorl	%esi, %ebx
addl	-0x1c(%r13), %eax
leal	(%rax,%rbx), %eax
rorxl	$0x1b, %ebp, %r12d
rorxl	$0x2, %ebp, %ebx
xorl	%ecx, %ebp
addl	%r12d, %eax
xorl	%edx, %ebp
addl	-0x18(%r13), %esi
leal	(%rsi,%rbp), %esi
rorxl	$0x1b, %eax, %r12d
rorxl	$0x2, %eax, %ebp
xorl	%ebx, %eax
addl	%r12d, %esi
xorl	%ecx, %eax
addl	-0x14(%r13), %edx
leal	(%rdx,%rax), %edx
rorxl	$0x1b, %esi, %r12d
addl	%r12d, %edx
leaq	0x80(%rsp), %r13
addl	(%r8), %edx
addl	0x4(%r8), %esi
addl	0x8(%r8), %ebp
movl	%edx, (%r8)
addl	0xc(%r8), %ebx
movl	%esi, 0x4(%r8)
movl	%edx, %eax
addl	0x10(%r8), %ecx
movl	%ebp, %r12d
movl	%ebp, 0x8(%r8)
movl	%ebx, %edx
movl	%ebx, 0xc(%r8)
movl	%esi, %ebp
movl	%ecx, 0x10(%r8)
movl	%ecx, %esi
movl	%r12d, %ecx
cmpq	%r10, %r9
jbe	L_30e0
L_4784:
vzeroupper
movq	-0x28(%r11), %r14
movq	-0x20(%r11), %r13
movq	-0x18(%r11), %r12
movq	-0x10(%r11), %rbp
movq	-0x8(%r11), %rbx
leaq	(%r11), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
	.section .rodata
	.p2align 6
K_XX_XX:
	.byte 153,121,130,90,153,121,130,90,153,121,130,90,153,121,130,90
	.byte 153,121,130,90,153,121,130,90,153,121,130,90,153,121,130,90
	.byte 161,235,217,110,161,235,217,110,161,235,217,110,161,235,217,110
	.byte 161,235,217,110,161,235,217,110,161,235,217,110,161,235,217,110
	.byte 220,188,27,143,220,188,27,143,220,188,27,143,220,188,27,143
	.byte 220,188,27,143,220,188,27,143,220,188,27,143,220,188,27,143
	.byte 214,193,98,202,214,193,98,202,214,193,98,202,214,193,98,202
	.byte 214,193,98,202,214,193,98,202,214,193,98,202,214,193,98,202
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 83,72,65,49,32,98,108,111,99,107,32,116,114,97,110,115
	.byte 102,111,114,109,32,102,111,114,32,120,56,54,95,54,52,44
	.byte 32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60
	.byte 104,116,116,112,115,58,47,47,103,105,116,104,117,98,46,99
	.byte 111,109,47,100,111,116,45,97,115,109,62,0
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

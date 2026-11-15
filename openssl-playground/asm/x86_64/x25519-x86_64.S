	.text
x25519_fe51_mul:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x28(%rsp), %rsp
movq	(%rsi), %rax
movq	(%rdx), %r11
movq	0x8(%rdx), %r12
movq	0x10(%rdx), %r13
movq	0x18(%rdx), %rbp
movq	0x20(%rdx), %r14
movq	%rdi, 0x20(%rsp)
movq	%rax, %rdi
mulq	%r11
movq	%r11, (%rsp)
movq	%rax, %rbx
movq	%rdi, %rax
movq	%rdx, %rcx
mulq	%r12
movq	%r12, 0x8(%rsp)
movq	%rax, %r8
movq	%rdi, %rax
leaq	(%r14,%r14,8), %r15
movq	%rdx, %r9
mulq	%r13
movq	%r13, 0x10(%rsp)
movq	%rax, %r10
movq	%rdi, %rax
leaq	(%r14,%r15,2), %rdi
movq	%rdx, %r11
mulq	%rbp
movq	%rax, %r12
movq	(%rsi), %rax
movq	%rdx, %r13
mulq	%r14
movq	%rax, %r14
movq	0x8(%rsi), %rax
movq	%rdx, %r15
mulq	%rdi
addq	%rax, %rbx
movq	0x10(%rsi), %rax
adcq	%rdx, %rcx
mulq	%rdi
addq	%rax, %r8
movq	0x18(%rsi), %rax
adcq	%rdx, %r9
mulq	%rdi
addq	%rax, %r10
movq	0x20(%rsi), %rax
adcq	%rdx, %r11
mulq	%rdi
imulq	$0x13, %rbp, %rdi
addq	%rax, %r12
movq	0x8(%rsi), %rax
adcq	%rdx, %r13
mulq	%rbp
movq	0x10(%rsp), %rbp
addq	%rax, %r14
movq	0x10(%rsi), %rax
adcq	%rdx, %r15
mulq	%rdi
addq	%rax, %rbx
movq	0x18(%rsi), %rax
adcq	%rdx, %rcx
mulq	%rdi
addq	%rax, %r8
movq	0x20(%rsi), %rax
adcq	%rdx, %r9
mulq	%rdi
imulq	$0x13, %rbp, %rdi
addq	%rax, %r10
movq	0x8(%rsi), %rax
adcq	%rdx, %r11
mulq	%rbp
addq	%rax, %r12
movq	0x10(%rsi), %rax
adcq	%rdx, %r13
mulq	%rbp
movq	0x8(%rsp), %rbp
addq	%rax, %r14
movq	0x18(%rsi), %rax
adcq	%rdx, %r15
mulq	%rdi
addq	%rax, %rbx
movq	0x20(%rsi), %rax
adcq	%rdx, %rcx
mulq	%rdi
addq	%rax, %r8
movq	0x8(%rsi), %rax
adcq	%rdx, %r9
mulq	%rbp
imulq	$0x13, %rbp, %rdi
addq	%rax, %r10
movq	0x10(%rsi), %rax
adcq	%rdx, %r11
mulq	%rbp
addq	%rax, %r12
movq	0x18(%rsi), %rax
adcq	%rdx, %r13
mulq	%rbp
movq	(%rsp), %rbp
addq	%rax, %r14
movq	0x20(%rsi), %rax
adcq	%rdx, %r15
mulq	%rdi
addq	%rax, %rbx
movq	0x8(%rsi), %rax
adcq	%rdx, %rcx
mulq	%rbp
addq	%rax, %r8
movq	0x10(%rsi), %rax
adcq	%rdx, %r9
mulq	%rbp
addq	%rax, %r10
movq	0x18(%rsi), %rax
adcq	%rdx, %r11
mulq	%rbp
addq	%rax, %r12
movq	0x20(%rsi), %rax
adcq	%rdx, %r13
mulq	%rbp
addq	%rax, %r14
adcq	%rdx, %r15
movq	0x20(%rsp), %rdi
jmp	L_2c0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
x25519_fe51_sqr:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x28(%rsp), %rsp
movq	(%rsi), %rax
movq	0x10(%rsi), %r15
movq	0x20(%rsi), %rbp
movq	%rdi, 0x20(%rsp)
leaq	(%rax,%rax), %r14
mulq	%rax
movq	%rax, %rbx
movq	0x8(%rsi), %rax
movq	%rdx, %rcx
mulq	%r14
movq	%rax, %r8
movq	%r15, %rax
movq	%r15, (%rsp)
movq	%rdx, %r9
mulq	%r14
movq	%rax, %r10
movq	0x18(%rsi), %rax
movq	%rdx, %r11
imulq	$0x13, %rbp, %rdi
mulq	%r14
movq	%rax, %r12
movq	%rbp, %rax
movq	%rdx, %r13
mulq	%r14
movq	%rax, %r14
movq	%rbp, %rax
movq	%rdx, %r15
mulq	%rdi
addq	%rax, %r12
movq	0x8(%rsi), %rax
adcq	%rdx, %r13
movq	0x18(%rsi), %rsi
leaq	(%rax,%rax), %rbp
mulq	%rax
addq	%rax, %r10
movq	(%rsp), %rax
adcq	%rdx, %r11
mulq	%rbp
addq	%rax, %r12
movq	%rbp, %rax
adcq	%rdx, %r13
mulq	%rsi
addq	%rax, %r14
movq	%rbp, %rax
adcq	%rdx, %r15
imulq	$0x13, %rsi, %rbp
mulq	%rdi
addq	%rax, %rbx
leaq	(%rsi,%rsi), %rax
adcq	%rdx, %rcx
mulq	%rdi
addq	%rax, %r10
movq	%rsi, %rax
adcq	%rdx, %r11
mulq	%rbp
addq	%rax, %r8
movq	(%rsp), %rax
adcq	%rdx, %r9
leaq	(%rax,%rax), %rsi
mulq	%rax
addq	%rax, %r14
movq	%rbp, %rax
adcq	%rdx, %r15
mulq	%rsi
addq	%rax, %rbx
movq	%rsi, %rax
adcq	%rdx, %rcx
mulq	%rdi
addq	%rax, %r8
adcq	%rdx, %r9
movq	0x20(%rsp), %rdi
jmp	L_2c0
nopl	(%rax)
L_2c0:
movabsq	$0x7ffffffffffff, %rbp
movq	%r10, %rdx
shrq	$0x33, %r10
shlq	$0xd, %r11
andq	%rbp, %rdx
orq	%r10, %r11
addq	%r11, %r12
adcq	$0x0, %r13
movq	%rbx, %rax
shrq	$0x33, %rbx
shlq	$0xd, %rcx
andq	%rbp, %rax
orq	%rbx, %rcx
addq	%rcx, %r8
adcq	$0x0, %r9
movq	%r12, %rbx
shrq	$0x33, %r12
shlq	$0xd, %r13
andq	%rbp, %rbx
orq	%r12, %r13
addq	%r13, %r14
adcq	$0x0, %r15
movq	%r8, %rcx
shrq	$0x33, %r8
shlq	$0xd, %r9
andq	%rbp, %rcx
orq	%r8, %r9
addq	%r9, %rdx
movq	%r14, %r10
shrq	$0x33, %r14
shlq	$0xd, %r15
andq	%rbp, %r10
orq	%r14, %r15
leaq	(%r15,%r15,8), %r14
leaq	(%r15,%r14,2), %r15
addq	%r15, %rax
movq	%rdx, %r8
andq	%rbp, %rdx
shrq	$0x33, %r8
addq	%r8, %rbx
movq	%rax, %r9
andq	%rbp, %rax
shrq	$0x33, %r9
addq	%r9, %rcx
movq	%rax, (%rdi)
movq	%rcx, 0x8(%rdi)
movq	%rdx, 0x10(%rdi)
movq	%rbx, 0x18(%rdi)
movq	%r10, 0x20(%rdi)
movq	0x28(%rsp), %r15
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r13
movq	0x40(%rsp), %r12
movq	0x48(%rsp), %rbx
movq	0x50(%rsp), %rbp
leaq	0x58(%rsp), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nop
x25519_fe51_mul121666:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	-0x28(%rsp), %rsp
movl	$0x1db42, %eax
mulq	(%rsi)
movq	%rax, %rbx
movl	$0x1db42, %eax
movq	%rdx, %rcx
mulq	0x8(%rsi)
movq	%rax, %r8
movl	$0x1db42, %eax
movq	%rdx, %r9
mulq	0x10(%rsi)
movq	%rax, %r10
movl	$0x1db42, %eax
movq	%rdx, %r11
mulq	0x18(%rsi)
movq	%rax, %r12
movl	$0x1db42, %eax
movq	%rdx, %r13
mulq	0x20(%rsi)
movq	%rax, %r14
movq	%rdx, %r15
jmp	L_2c0
nop
x25519_fe64_eligible:
movl	OPENSSL_ia32cap_P+8(%rip), %ecx
xorl	%eax, %eax
andl	$0x80100, %ecx
cmpl	$0x80100, %ecx
cmovel	%ecx, %eax
rep	retq
nopl	(%rax)
x25519_fe64_mul:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
pushq	%rdi
leaq	-0x10(%rsp), %rsp
movq	%rdx, %rax
movq	(%rdx), %rbp
movq	(%rsi), %rdx
movq	0x8(%rax), %rcx
movq	0x10(%rax), %r14
movq	0x18(%rax), %r15
mulxq	%rbp, %r8, %rax
xorl	%edi, %edi
mulxq	%rcx, %r9, %rbx
adcxq	%rax, %r9
mulxq	%r14, %r10, %rax
adcxq	%rbx, %r10
mulxq	%r15, %r11, %r12
movq	0x8(%rsi), %rdx
adcxq	%rax, %r11
movq	%r14, (%rsp)
adcxq	%rdi, %r12
mulxq	%rbp, %rax, %rbx
adoxq	%rax, %r9
adcxq	%rbx, %r10
mulxq	%rcx, %rax, %rbx
adoxq	%rax, %r10
adcxq	%rbx, %r11
mulxq	%r14, %rax, %rbx
adoxq	%rax, %r11
adcxq	%rbx, %r12
mulxq	%r15, %rax, %r13
movq	0x10(%rsi), %rdx
adoxq	%rax, %r12
adcxq	%rdi, %r13
adoxq	%rdi, %r13
mulxq	%rbp, %rax, %rbx
adcxq	%rax, %r10
adoxq	%rbx, %r11
mulxq	%rcx, %rax, %rbx
adcxq	%rax, %r11
adoxq	%rbx, %r12
mulxq	%r14, %rax, %rbx
adcxq	%rax, %r12
adoxq	%rbx, %r13
mulxq	%r15, %rax, %r14
movq	0x18(%rsi), %rdx
adcxq	%rax, %r13
adoxq	%rdi, %r14
adcxq	%rdi, %r14
mulxq	%rbp, %rax, %rbx
adoxq	%rax, %r11
adcxq	%rbx, %r12
mulxq	%rcx, %rax, %rbx
adoxq	%rax, %r12
adcxq	%rbx, %r13
mulxq	(%rsp), %rax, %rbx
adoxq	%rax, %r13
adcxq	%rbx, %r14
mulxq	%r15, %rax, %r15
movl	$0x26, %edx
adoxq	%rax, %r14
adcxq	%rdi, %r15
adoxq	%rdi, %r15
jmp	L_680
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
x25519_fe64_sqr:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
pushq	%rdi
leaq	-0x10(%rsp), %rsp
movq	(%rsi), %rdx
movq	0x8(%rsi), %rcx
movq	0x10(%rsi), %rbp
movq	0x18(%rsi), %rsi
mulxq	%rdx, %r8, %r15
mulxq	%rcx, %r9, %rax
xorl	%edi, %edi
mulxq	%rbp, %r10, %rbx
adcxq	%rax, %r10
mulxq	%rsi, %r11, %r12
movq	%rcx, %rdx
adcxq	%rbx, %r11
adcxq	%rdi, %r12
mulxq	%rbp, %rax, %rbx
adoxq	%rax, %r11
adcxq	%rbx, %r12
mulxq	%rsi, %rax, %r13
movq	%rbp, %rdx
adoxq	%rax, %r12
adcxq	%rdi, %r13
mulxq	%rsi, %rax, %r14
movq	%rcx, %rdx
adoxq	%rax, %r13
adcxq	%rdi, %r14
adoxq	%rdi, %r14
adcxq	%r9, %r9
adoxq	%r15, %r9
adcxq	%r10, %r10
mulxq	%rdx, %rax, %rbx
movq	%rbp, %rdx
adcxq	%r11, %r11
adoxq	%rax, %r10
adcxq	%r12, %r12
adoxq	%rbx, %r11
mulxq	%rdx, %rax, %rbx
movq	%rsi, %rdx
adcxq	%r13, %r13
adoxq	%rax, %r12
adcxq	%r14, %r14
adoxq	%rbx, %r13
mulxq	%rdx, %rax, %r15
movl	$0x26, %edx
adoxq	%rax, %r14
adcxq	%rdi, %r15
adoxq	%rdi, %r15
jmp	L_680
nopl	(%rax)
L_680:
mulxq	%r12, %rax, %rbx
adcxq	%rax, %r8
adoxq	%rbx, %r9
mulxq	%r13, %rax, %rbx
adcxq	%rax, %r9
adoxq	%rbx, %r10
mulxq	%r14, %rax, %rbx
adcxq	%rax, %r10
adoxq	%rbx, %r11
mulxq	%r15, %rax, %r12
adcxq	%rax, %r11
adoxq	%rdi, %r12
adcxq	%rdi, %r12
movq	0x10(%rsp), %rdi
imulq	%rdx, %r12
addq	%r12, %r8
adcq	$0x0, %r9
adcq	$0x0, %r10
adcq	$0x0, %r11
sbbq	%rax, %rax
andq	$0x26, %rax
addq	%rax, %r8
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r8, (%rdi)
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %r14
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r12
movq	0x38(%rsp), %rbx
movq	0x40(%rsp), %rbp
leaq	0x48(%rsp), %rsp
rep	retq
x25519_fe64_mul121666:
movl	$0x1db42, %edx
mulxq	(%rsi), %r8, %rcx
mulxq	0x8(%rsi), %r9, %rax
addq	%rcx, %r9
mulxq	0x10(%rsi), %r10, %rcx
adcq	%rax, %r10
mulxq	0x18(%rsi), %r11, %rax
adcq	%rcx, %r11
adcq	$0x0, %rax
imulq	$0x26, %rax, %rax
addq	%rax, %r8
adcq	$0x0, %r9
adcq	$0x0, %r10
adcq	$0x0, %r11
sbbq	%rax, %rax
andq	$0x26, %rax
addq	%rax, %r8
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
movq	%r8, (%rdi)
rep	retq
nopw	(%rax,%rax)
x25519_fe64_add:
movq	(%rsi), %r8
movq	0x8(%rsi), %r9
movq	0x10(%rsi), %r10
movq	0x18(%rsi), %r11
addq	(%rdx), %r8
adcq	0x8(%rdx), %r9
adcq	0x10(%rdx), %r10
adcq	0x18(%rdx), %r11
sbbq	%rax, %rax
andq	$0x26, %rax
addq	%rax, %r8
adcq	$0x0, %r9
adcq	$0x0, %r10
movq	%r9, 0x8(%rdi)
adcq	$0x0, %r11
movq	%r10, 0x10(%rdi)
sbbq	%rax, %rax
movq	%r11, 0x18(%rdi)
andq	$0x26, %rax
addq	%rax, %r8
movq	%r8, (%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
x25519_fe64_sub:
movq	(%rsi), %r8
movq	0x8(%rsi), %r9
movq	0x10(%rsi), %r10
movq	0x18(%rsi), %r11
subq	(%rdx), %r8
sbbq	0x8(%rdx), %r9
sbbq	0x10(%rdx), %r10
sbbq	0x18(%rdx), %r11
sbbq	%rax, %rax
andq	$0x26, %rax
subq	%rax, %r8
sbbq	$0x0, %r9
sbbq	$0x0, %r10
movq	%r9, 0x8(%rdi)
sbbq	$0x0, %r11
movq	%r10, 0x10(%rdi)
sbbq	%rax, %rax
movq	%r11, 0x18(%rdi)
andq	$0x26, %rax
subq	%rax, %r8
movq	%r8, (%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
	.section .rodata_in_text
x25519_fe64_tobytes:
	.size x25519_fe64_tobytes, 172
	.byte 76,139,6,76,139,78,8,76,139,86,16,76,139,94,24,75
	.byte 141,4,27,73,193,251,63,72,209,232,73,131,227,19,73,131
	.byte 195,19,77,1,216,73,131,209,0,73,131,210,0,72,131,208
	.byte 0,76,141,28,0,72,193,248,63,73,209,235,72,247,208,72
	.byte 131,224,19,73,41,192,73,131,217,0,73,131,218,0,73,131
	.byte 219,0,76,137,7,76,137,79,8,76,137,87,16,76,137,95
	.byte 24,243,195,88,50,53,53,49,57,32,112,114,105,109,105,116
	.byte 105,118,101,115,32,102,111,114,32,120,56,54,95,54,52,44
	.byte 32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60
	.byte 104,116,116,112,115,58,47,47,103,105,116,104,117,98,46,99
	.byte 111,109,47,100,111,116,45,97,115,109,62,0

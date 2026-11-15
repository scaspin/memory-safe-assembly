	.text
__KeccakF1600:
movq	0x3c(%rdi), %rax
movq	0x44(%rdi), %rbx
movq	0x4c(%rdi), %rcx
movq	0x54(%rdi), %rdx
movq	0x5c(%rdi), %rbp
jmp	L_20
nopw	%cs:(%rax,%rax)
L_20:
movq	-0x64(%rdi), %r8
movq	-0x34(%rdi), %r9
movq	-0x4(%rdi), %r10
movq	0x2c(%rdi), %r11
xorq	-0x54(%rdi), %rcx
xorq	-0x4c(%rdi), %rdx
xorq	%r8, %rax
xorq	-0x5c(%rdi), %rbx
xorq	-0x2c(%rdi), %rcx
xorq	-0x3c(%rdi), %rax
movq	%rbp, %r12
xorq	-0x44(%rdi), %rbp
xorq	%r10, %rcx
xorq	-0x14(%rdi), %rax
xorq	-0x24(%rdi), %rdx
xorq	%r9, %rbx
xorq	-0x1c(%rdi), %rbp
xorq	0x24(%rdi), %rcx
xorq	0x14(%rdi), %rax
xorq	0x4(%rdi), %rdx
xorq	-0xc(%rdi), %rbx
xorq	0xc(%rdi), %rbp
movq	%rcx, %r13
rolq	%rcx
xorq	%rax, %rcx
xorq	%r11, %rdx
rolq	%rax
xorq	%rdx, %rax
xorq	0x1c(%rdi), %rbx
rolq	%rdx
xorq	%rbx, %rdx
xorq	0x34(%rdi), %rbp
rolq	%rbx
xorq	%rbp, %rbx
rolq	%rbp
xorq	%r13, %rbp
xorq	%rcx, %r9
xorq	%rdx, %r10
rolq	$0x2c, %r9
xorq	%rbp, %r11
xorq	%rax, %r12
rolq	$0x2b, %r10
xorq	%rbx, %r8
movq	%r9, %r13
rolq	$0x15, %r11
orq	%r10, %r9
xorq	%r8, %r9
rolq	$0xe, %r12
xorq	(%r15), %r9
leaq	0x8(%r15), %r15
movq	%r12, %r14
andq	%r11, %r12
movq	%r9, -0x64(%rsi)
xorq	%r10, %r12
notq	%r10
movq	%r12, -0x54(%rsi)
orq	%r11, %r10
movq	0x4c(%rdi), %r12
xorq	%r13, %r10
movq	%r10, -0x5c(%rsi)
andq	%r8, %r13
movq	-0x1c(%rdi), %r9
xorq	%r14, %r13
movq	-0x14(%rdi), %r10
movq	%r13, -0x44(%rsi)
orq	%r8, %r14
movq	-0x4c(%rdi), %r8
xorq	%r11, %r14
movq	0x1c(%rdi), %r11
movq	%r14, -0x4c(%rsi)
xorq	%rbp, %r8
xorq	%rdx, %r12
rolq	$0x1c, %r8
xorq	%rcx, %r11
xorq	%rax, %r9
rolq	$0x3d, %r12
rolq	$0x2d, %r11
xorq	%rbx, %r10
rolq	$0x14, %r9
movq	%r8, %r13
orq	%r12, %r8
rolq	$0x3, %r10
xorq	%r11, %r8
movq	%r8, -0x24(%rsi)
movq	%r9, %r14
andq	%r13, %r9
movq	-0x5c(%rdi), %r8
xorq	%r12, %r9
notq	%r12
movq	%r9, -0x1c(%rsi)
orq	%r11, %r12
movq	-0x2c(%rdi), %r9
xorq	%r10, %r12
movq	%r12, -0x2c(%rsi)
andq	%r10, %r11
movq	0x3c(%rdi), %r12
xorq	%r14, %r11
movq	%r11, -0x34(%rsi)
orq	%r10, %r14
movq	0x4(%rdi), %r10
xorq	%r13, %r14
movq	0x34(%rdi), %r11
movq	%r14, -0x3c(%rsi)
xorq	%rbp, %r10
xorq	%rax, %r11
rolq	$0x19, %r10
xorq	%rdx, %r9
rolq	$0x8, %r11
xorq	%rbx, %r12
rolq	$0x6, %r9
xorq	%rcx, %r8
rolq	$0x12, %r12
movq	%r10, %r13
andq	%r11, %r10
rolq	%r8
notq	%r11
xorq	%r9, %r10
movq	%r10, -0xc(%rsi)
movq	%r12, %r14
andq	%r11, %r12
movq	-0xc(%rdi), %r10
xorq	%r13, %r12
movq	%r12, -0x4(%rsi)
orq	%r9, %r13
movq	0x54(%rdi), %r12
xorq	%r8, %r13
movq	%r13, -0x14(%rsi)
andq	%r8, %r9
xorq	%r14, %r9
movq	%r9, 0xc(%rsi)
orq	%r8, %r14
movq	-0x3c(%rdi), %r9
xorq	%r11, %r14
movq	0x24(%rdi), %r11
movq	%r14, 0x4(%rsi)
movq	-0x44(%rdi), %r8
xorq	%rcx, %r10
xorq	%rdx, %r11
rolq	$0xa, %r10
xorq	%rbx, %r9
rolq	$0xf, %r11
xorq	%rbp, %r12
rolq	$0x24, %r9
xorq	%rax, %r8
rolq	$0x38, %r12
movq	%r10, %r13
orq	%r11, %r10
rolq	$0x1b, %r8
notq	%r11
xorq	%r9, %r10
movq	%r10, 0x1c(%rsi)
movq	%r12, %r14
orq	%r11, %r12
xorq	%r13, %r12
movq	%r12, 0x24(%rsi)
andq	%r9, %r13
xorq	%r8, %r13
movq	%r13, 0x14(%rsi)
orq	%r8, %r9
xorq	%r14, %r9
movq	%r9, 0x34(%rsi)
andq	%r14, %r8
xorq	%r11, %r8
movq	%r8, 0x2c(%rsi)
xorq	-0x54(%rdi), %rdx
xorq	-0x24(%rdi), %rbp
rolq	$0x3e, %rdx
xorq	0x44(%rdi), %rcx
rolq	$0x37, %rbp
xorq	0xc(%rdi), %rax
rolq	$0x2, %rcx
xorq	0x14(%rdi), %rbx
xchgq	%rsi, %rdi
rolq	$0x27, %rax
rolq	$0x29, %rbx
movq	%rdx, %r13
andq	%rbp, %rdx
notq	%rbp
xorq	%rcx, %rdx
movq	%rdx, 0x5c(%rdi)
movq	%rax, %r14
andq	%rbp, %rax
xorq	%r13, %rax
movq	%rax, 0x3c(%rdi)
orq	%rcx, %r13
xorq	%rbx, %r13
movq	%r13, 0x54(%rdi)
andq	%rbx, %rcx
xorq	%r14, %rcx
movq	%rcx, 0x4c(%rdi)
orq	%r14, %rbx
xorq	%rbp, %rbx
movq	%rbx, 0x44(%rdi)
movq	%rdx, %rbp
movq	%r13, %rdx
testq	$0xff, %r15
jne	L_20
leaq	-0xc0(%r15), %r15
rep	retq
nopl	(%rax,%rax)
KeccakF1600:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	0x64(%rdi), %rdi
subq	$0xc8, %rsp
notq	-0x5c(%rdi)
notq	-0x54(%rdi)
notq	-0x24(%rdi)
notq	-0x4(%rdi)
notq	0x24(%rdi)
notq	0x3c(%rdi)
leaq	iotas(%rip), %r15
leaq	0x64(%rsp), %rsi
callq	__KeccakF1600
notq	-0x5c(%rdi)
notq	-0x54(%rdi)
notq	-0x24(%rdi)
notq	-0x4(%rdi)
notq	0x24(%rdi)
notq	0x3c(%rdi)
leaq	-0x64(%rdi), %rdi
addq	$0xc8, %rsp
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbp
popq	%rbx
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
SHA3_absorb:
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
leaq	0x64(%rdi), %rdi
subq	$0xe8, %rsp
movq	%rsi, %r9
leaq	0x64(%rsp), %rsi
notq	-0x5c(%rdi)
notq	-0x54(%rdi)
notq	-0x24(%rdi)
notq	-0x4(%rdi)
notq	0x24(%rdi)
notq	0x3c(%rdi)
leaq	iotas(%rip), %r15
movq	%rcx, 0x74(%rsi)
L_3a0:
cmpq	%rcx, %rdx
jb	L_400
shrq	$0x3, %rcx
leaq	-0x64(%rdi), %r8
L_3ad:
movq	(%r9), %rax
leaq	0x8(%r9), %r9
xorq	(%r8), %rax
leaq	0x8(%r8), %r8
subq	$0x8, %rdx
movq	%rax, -0x8(%r8)
subq	$0x1, %rcx
jne	L_3ad
movq	%r9, 0x64(%rsi)
movq	%rdx, 0x6c(%rsi)
callq	__KeccakF1600
movq	0x64(%rsi), %r9
movq	0x6c(%rsi), %rdx
movq	0x74(%rsi), %rcx
jmp	L_3a0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_400:
movq	%rdx, %rax
notq	-0x5c(%rdi)
notq	-0x54(%rdi)
notq	-0x24(%rdi)
notq	-0x4(%rdi)
notq	0x24(%rdi)
notq	0x3c(%rdi)
addq	$0xe8, %rsp
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbp
popq	%rbx
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
SHA3_squeeze:
pushq	%r12
pushq	%r13
pushq	%r14
shrq	$0x3, %rcx
movq	%rdi, %r9
movq	%rsi, %r12
movq	%rdx, %r13
movq	%rcx, %r14
btl	$0x0, %r8d
jb	L_482
jmp	L_460
nop
L_460:
cmpq	$0x8, %r13
jb	L_48f
movq	(%r9), %rax
leaq	0x8(%r9), %r9
movq	%rax, (%r12)
leaq	0x8(%r12), %r12
subq	$0x8, %r13
je	L_49a
subq	$0x1, %rcx
jne	L_460
L_482:
callq	KeccakF1600
movq	%rdi, %r9
movq	%r14, %rcx
jmp	L_460
L_48f:
movq	%r9, %rsi
movq	%r12, %rdi
movq	%r13, %rcx
rep	movsb	(%rsi), %es:(%rdi)
L_49a:
popq	%r14
popq	%r13
popq	%r12
rep	retq
	.section .rodata
	.p2align 8
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
iotas:
	.size iotas, 192
	.byte 1,0,0,0,0,0,0,0,130,128,0,0,0,0,0,0
	.byte 138,128,0,0,0,0,0,128,0,128,0,128,0,0,0,128
	.byte 139,128,0,0,0,0,0,0,1,0,0,128,0,0,0,0
	.byte 129,128,0,128,0,0,0,128,9,128,0,0,0,0,0,128
	.byte 138,0,0,0,0,0,0,0,136,0,0,0,0,0,0,0
	.byte 9,128,0,128,0,0,0,0,10,0,0,128,0,0,0,0
	.byte 139,128,0,128,0,0,0,0,139,0,0,0,0,0,0,128
	.byte 137,128,0,0,0,0,0,128,3,128,0,0,0,0,0,128
	.byte 2,128,0,0,0,0,0,128,128,0,0,0,0,0,0,128
	.byte 10,128,0,0,0,0,0,0,10,0,0,128,0,0,0,128
	.byte 129,128,0,128,0,0,0,128,128,128,0,0,0,0,0,128
	.byte 1,0,0,128,0,0,0,0,8,128,0,128,0,0,0,128
	.byte 75,101,99,99,97,107,45,49,54,48,48,32,97,98,115,111
	.byte 114,98,32,97,110,100,32,115,113,117,101,101,122,101,32,102
	.byte 111,114,32,120,56,54,95,54,52,44,32,67,82,89,80,84
	.byte 79,71,65,77,83,32,98,121,32,60,104,116,116,112,115,58
	.byte 47,47,103,105,116,104,117,98,46,99,111,109,47,100,111,116
	.byte 45,97,115,109,62,0

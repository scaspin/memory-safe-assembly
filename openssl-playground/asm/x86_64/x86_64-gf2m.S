	.text
_mul_1x1:
subq	$0x88, %rsp
movq	$-0x1, %r9
leaq	(%rax,%rax), %rsi
shrq	$0x3, %r9
leaq	(,%rax,4), %rdi
andq	%rax, %r9
leaq	(,%rax,8), %r12
sarq	$0x3f, %rax
leaq	(%r9,%r9), %r10
sarq	$0x3f, %rsi
leaq	(,%r9,4), %r11
andq	%rbp, %rax
sarq	$0x3f, %rdi
movq	%rax, %rdx
shlq	$0x3f, %rax
andq	%rbp, %rsi
shrq	%rdx
movq	%rsi, %rcx
shlq	$0x3e, %rsi
andq	%rbp, %rdi
shrq	$0x2, %rcx
xorq	%rsi, %rax
movq	%rdi, %rbx
shlq	$0x3d, %rdi
xorq	%rcx, %rdx
shrq	$0x3, %rbx
xorq	%rdi, %rax
xorq	%rbx, %rdx
movq	%r9, %r13
movq	$0x0, (%rsp)
xorq	%r10, %r13
movq	%r9, 0x8(%rsp)
movq	%r11, %r14
movq	%r10, 0x10(%rsp)
xorq	%r12, %r14
movq	%r13, 0x18(%rsp)
xorq	%r11, %r9
movq	%r11, 0x20(%rsp)
xorq	%r11, %r10
movq	%r9, 0x28(%rsp)
xorq	%r11, %r13
movq	%r10, 0x30(%rsp)
xorq	%r14, %r9
movq	%r13, 0x38(%rsp)
xorq	%r14, %r10
movq	%r12, 0x40(%rsp)
xorq	%r14, %r13
movq	%r9, 0x48(%rsp)
xorq	%r11, %r9
movq	%r10, 0x50(%rsp)
xorq	%r11, %r10
movq	%r13, 0x58(%rsp)
xorq	%r11, %r13
movq	%r14, 0x60(%rsp)
movq	%r8, %rsi
movq	%r9, 0x68(%rsp)
andq	%rbp, %rsi
movq	%r10, 0x70(%rsp)
shrq	$0x4, %rbp
movq	%r13, 0x78(%rsp)
movq	%r8, %rdi
andq	%rbp, %rdi
shrq	$0x4, %rbp
movq	(%rsp,%rsi,8), %xmm0
movq	%r8, %rsi
andq	%rbp, %rsi
shrq	$0x4, %rbp
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0x4, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0x3c, %rbx
xorq	%rcx, %rax
pslldq	$0x1, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0xc, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0x34, %rbx
xorq	%rcx, %rax
pslldq	$0x2, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0x14, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0x2c, %rbx
xorq	%rcx, %rax
pslldq	$0x3, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0x1c, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0x24, %rbx
xorq	%rcx, %rax
pslldq	$0x4, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0x24, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0x1c, %rbx
xorq	%rcx, %rax
pslldq	$0x5, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0x2c, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0x14, %rbx
xorq	%rcx, %rax
pslldq	$0x6, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%r8, %rdi
movq	%rcx, %rbx
shlq	$0x34, %rcx
andq	%rbp, %rdi
movq	(%rsp,%rsi,8), %xmm1
shrq	$0xc, %rbx
xorq	%rcx, %rax
pslldq	$0x7, %xmm1
movq	%r8, %rsi
shrq	$0x4, %rbp
xorq	%rbx, %rdx
andq	%rbp, %rsi
shrq	$0x4, %rbp
pxor	%xmm1, %xmm0
movq	(%rsp,%rdi,8), %rcx
movq	%rcx, %rbx
shlq	$0x3c, %rcx
movq	%xmm0, %rsi
shrq	$0x4, %rbx
xorq	%rcx, %rax
psrldq	$0x8, %xmm0
xorq	%rbx, %rdx
movq	%xmm0, %rdi
xorq	%rsi, %rax
xorq	%rdi, %rdx
addq	$0x88, %rsp
rep	retq
nopw	(%rax,%rax)
bn_GF2m_mul_2x2:
movq	%rsp, %rax
movq	OPENSSL_ia32cap_P(%rip), %r10
btq	$0x21, %r10
jae	L_340
movq	%rsi, %xmm0
movq	%rcx, %xmm1
movq	%rdx, %xmm2
movq	%r8, %xmm3
movdqa	%xmm0, %xmm4
movdqa	%xmm1, %xmm5
pclmulqdq	$0x0, %xmm1, %xmm0
pxor	%xmm2, %xmm4
pxor	%xmm3, %xmm5
pclmulqdq	$0x0, %xmm3, %xmm2
pclmulqdq	$0x0, %xmm5, %xmm4
xorps	%xmm0, %xmm4
xorps	%xmm2, %xmm4
movdqa	%xmm4, %xmm5
pslldq	$0x8, %xmm4
psrldq	$0x8, %xmm5
pxor	%xmm4, %xmm2
pxor	%xmm5, %xmm0
movdqu	%xmm2, (%rdi)
movdqu	%xmm0, 0x10(%rdi)
rep	retq
nop
L_340:
leaq	-0x88(%rsp), %rsp
movq	%r14, 0x50(%rsp)
movq	%r13, 0x58(%rsp)
movq	%r12, 0x60(%rsp)
movq	%rbp, 0x68(%rsp)
movq	%rbx, 0x70(%rsp)
movq	%rdi, 0x20(%rsp)
movq	%rsi, 0x28(%rsp)
movq	%rdx, 0x30(%rsp)
movq	%rcx, 0x38(%rsp)
movq	%r8, 0x40(%rsp)
movq	$0xf, %r8
movq	%rsi, %rax
movq	%rcx, %rbp
callq	_mul_1x1
movq	%rax, 0x10(%rsp)
movq	%rdx, 0x18(%rsp)
movq	0x30(%rsp), %rax
movq	0x40(%rsp), %rbp
callq	_mul_1x1
movq	%rax, (%rsp)
movq	%rdx, 0x8(%rsp)
movq	0x28(%rsp), %rax
movq	0x38(%rsp), %rbp
xorq	0x30(%rsp), %rax
xorq	0x40(%rsp), %rbp
callq	_mul_1x1
movq	(%rsp), %rbx
movq	0x8(%rsp), %rcx
movq	0x10(%rsp), %rdi
movq	0x18(%rsp), %rsi
movq	0x20(%rsp), %rbp
xorq	%rdx, %rax
xorq	%rcx, %rdx
xorq	%rbx, %rax
movq	%rbx, (%rbp)
xorq	%rdi, %rdx
movq	%rsi, 0x18(%rbp)
xorq	%rsi, %rax
xorq	%rsi, %rdx
xorq	%rdx, %rax
movq	%rdx, 0x10(%rbp)
movq	%rax, 0x8(%rbp)
movq	0x50(%rsp), %r14
movq	0x58(%rsp), %r13
movq	0x60(%rsp), %r12
movq	0x68(%rsp), %rbp
movq	0x70(%rsp), %rbx
leaq	0x88(%rsp), %rsp
rep	retq
nopw	(%rax,%rax)
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

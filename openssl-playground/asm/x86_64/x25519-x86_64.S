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
x25519_fe64_tobytes:
movq	(%rsi), %r8
movq	0x8(%rsi), %r9
movq	0x10(%rsi), %r10
movq	0x18(%rsi), %r11
leaq	(%r11,%r11), %rax
sarq	$0x3f, %r11
shrq	%rax
andq	$0x13, %r11
addq	$0x13, %r11
addq	%r11, %r8
adcq	$0x0, %r9
adcq	$0x0, %r10
adcq	$0x0, %rax
leaq	(%rax,%rax), %r11
sarq	$0x3f, %rax
shrq	%r11
notq	%rax
andq	$0x13, %rax
subq	%rax, %r8
sbbq	$0x0, %r9
sbbq	$0x0, %r10
sbbq	$0x0, %r11
movq	%r8, (%rdi)
movq	%r9, 0x8(%rdi)
movq	%r10, 0x10(%rdi)
movq	%r11, 0x18(%rdi)
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

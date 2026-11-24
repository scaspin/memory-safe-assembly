	.text
compare256_avx512:
vmovdqu	(%rdi), %xmm0
vpcmpeqb	(%rsi), %xmm0, %k0
kortestw	%k0, %k0
jb	L_1e
kmovd	%k0, %eax
movzwl	%ax, %eax
notl	%eax
tzcntl	%eax, %eax
retq
L_1e:
vmovdqu64	0x10(%rdi), %zmm0
vpcmpeqb	0x10(%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_4d
kmovq	%k0, %rax
notq	%rax
tzcntq	%rax, %rax
addl	$0x10, %eax
vzeroupper
retq
L_4d:
vmovdqu64	0x50(%rdi), %zmm0
vpcmpeqb	0x50(%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_7c
kmovq	%k0, %rax
notq	%rax
tzcntq	%rax, %rax
addl	$0x50, %eax
vzeroupper
retq
L_7c:
vmovdqu64	0x90(%rdi), %zmm0
vpcmpeqb	0x90(%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_ad
kmovq	%k0, %rax
notq	%rax
tzcntq	%rax, %rax
addl	$0x90, %eax
vzeroupper
retq
L_ad:
vmovdqu64	0xc0(%rdi), %zmm0
vpcmpeqb	0xc0(%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_d8
kmovq	%k0, %rax
notq	%rax
tzcntq	%rax, %rax
orl	$0xc0, %eax
vzeroupper
retq
L_d8:
movl	$0x100, %eax
vzeroupper
retq
nopw	%cs:(%rax,%rax)
longest_match_avx512:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
movl	0x84(%rdi), %ecx
movq	0x58(%rdi), %rdx
movl	0x8c(%rdi), %r8d
testl	%r8d, %r8d
movl	$0x2, %eax
cmovnel	%r8d, %eax
leaq	(%rdx,%rcx), %r10
xorl	%r8d, %r8d
cmpl	$0x8, %eax
setb	%r8b
shll	$0x2, %r8d
orl	$-0x7, %r8d
cmpl	$0x4, %eax
movl	$0xffffffff, %r9d
cmovael	%r8d, %r9d
addl	%eax, %r9d
movq	%r10, -0x18(%rsp)
movq	(%r9,%r10), %r11
movl	%r11d, %r15d
shrl	$0x10, %r15d
movq	%r11, %r8
shrq	$0x20, %r8
movq	%r8, -0x8(%rsp)
addq	%rdx, %r9
movl	0x90(%rdi), %r8d
movl	%r8d, %r10d
shrl	$0x2, %r10d
cmpl	0xb8(%rdi), %eax
cmovbl	%r8d, %r10d
movl	$0xfffffefa, %r8d
addl	0x40(%rdi), %r8d
movl	0x48(%rdi), %ebx
xorl	%r14d, %r14d
movl	%ecx, %ebp
subl	%r8d, %ebp
movl	0x4c(%rdi), %r8d
movl	%r8d, -0x1c(%rsp)
cmovbl	%r14d, %ebp
movq	0x60(%rdi), %r12
movq	(%rdx,%rcx), %r13
movl	0xbc(%rdi), %r8d
movl	%r8d, -0x10(%rsp)
movl	0xb0(%rdi), %r8d
movl	%r8d, -0xc(%rsp)
L_1b6:
movzwl	%si, %r8d
cmpl	%r8d, %ecx
jbe	L_422
cmpl	$0x3, %eax
ja	L_210
movq	-0x18(%rsp), %r8
nopl	(%rax)
L_1d0:
movzwl	%si, %esi
cmpw	%r11w, (%r9,%rsi)
jne	L_1e5
cmpw	%r13w, (%rdx,%rsi)
je	L_2a2
L_1e5:
cmpl	$0x1, %r10d
je	L_422
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
decl	%r10d
cmpw	%bp, %si
ja	L_1d0
jmp	L_422
nopw	%cs:(%rax,%rax)
L_210:
movzwl	%r11w, %r14d
cmpl	$0x7, %eax
jbe	L_260
movl	%r15d, %r8d
shll	$0x10, %r8d
orq	%r8, %r14
movq	-0x8(%rsp), %r8
shlq	$0x20, %r8
orq	%r14, %r8
nop
L_230:
movzwl	%si, %esi
cmpq	%r8, (%r9,%rsi)
jne	L_23f
cmpq	%r13, (%rdx,%rsi)
je	L_29d
L_23f:
cmpl	$0x1, %r10d
je	L_422
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
decl	%r10d
cmpw	%bp, %si
ja	L_230
jmp	L_422
nopl	(%rax)
L_260:
movl	%r15d, %r8d
shll	$0x10, %r8d
orl	%r14d, %r8d
nopw	(%rax,%rax)
L_270:
movzwl	%si, %esi
cmpl	%r8d, (%r9,%rsi)
jne	L_27f
cmpl	%r13d, (%rdx,%rsi)
je	L_29d
L_27f:
cmpl	$0x1, %r10d
je	L_422
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
decl	%r10d
cmpw	%bp, %si
ja	L_270
jmp	L_422
L_29d:
movq	-0x18(%rsp), %r8
L_2a2:
vmovdqu	0x2(%r8), %xmm0
vpcmpeqb	0x2(%rdx,%rsi), %xmm0, %k0
kortestw	%k0, %k0
jb	L_2ce
kmovd	%k0, %r8d
movzwl	%r8w, %r8d
notl	%r8d
tzcntl	%r8d, %r8d
jmp	L_399
L_2ce:
vmovdqu64	0x12(%r8), %zmm0
vpcmpeqb	0x12(%rdx,%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_300
kmovq	%k0, %r8
notq	%r8
tzcntq	%r8, %r8
addl	$0x10, %r8d
jmp	L_399
L_300:
vmovdqu64	0x52(%r8), %zmm0
vpcmpeqb	0x52(%rdx,%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_32f
kmovq	%k0, %r8
notq	%r8
tzcntq	%r8, %r8
addl	$0x50, %r8d
jmp	L_399
L_32f:
vmovdqu64	0x92(%r8), %zmm0
vpcmpeqb	0x92(%rdx,%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_361
kmovq	%k0, %r8
notq	%r8
tzcntq	%r8, %r8
addl	$0x90, %r8d
jmp	L_399
L_361:
vmovdqu64	0xc2(%r8), %zmm0
vpcmpeqb	0xc2(%rdx,%rsi), %zmm0, %k0
kortestq	%k0, %k0
jb	L_393
kmovq	%k0, %r8
notq	%r8
tzcntq	%r8, %r8
orl	$0xc0, %r8d
jmp	L_399
L_393:
movl	$0x100, %r8d
L_399:
leal	0x2(%r8), %r14d
cmpl	%eax, %r14d
jbe	L_3fb
movl	%esi, 0x88(%rdi)
cmpl	-0x1c(%rsp), %r14d
jae	L_419
cmpl	-0x10(%rsp), %r14d
jae	L_41f
cmpl	$0x6, %r8d
movl	$0x0, %r9d
sbbl	%r9d, %r9d
orl	$-0x5, %r9d
cmpl	$0x2, %r8d
movl	$0x1, %eax
cmovbl	%eax, %r9d
addl	%r8d, %r9d
movq	-0x18(%rsp), %rax
movq	(%rax,%r9), %r11
movl	%r11d, %r15d
shrl	$0x10, %r15d
movq	%r11, %rax
shrq	$0x20, %rax
movq	%rax, -0x8(%rsp)
addq	%rdx, %r9
movl	%r14d, %eax
jmp	L_402
L_3fb:
cmpl	$0x5, -0xc(%rsp)
jl	L_422
L_402:
decl	%r10d
je	L_422
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
cmpw	%bp, %si
ja	L_1b6
jmp	L_422
L_419:
movl	-0x1c(%rsp), %eax
jmp	L_422
L_41f:
movl	%r14d, %eax
L_422:
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
vzeroupper
retq
longest_match_slow_avx512:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x88, %rsp
movl	%esi, %r14d
movq	%rdi, %rbx
movl	0x84(%rdi), %r8d
movl	0x48(%rdi), %r9d
movq	0x58(%rdi), %r10
leaq	(%r10,%r8), %r13
movl	0x8c(%rdi), %eax
testl	%eax, %eax
movl	$0x2, %edx
cmovnel	%eax, %edx
xorl	%eax, %eax
cmpl	$0x8, %edx
setb	%al
shll	$0x2, %eax
orl	$-0x7, %eax
cmpl	$0x4, %edx
movl	$0xffffffff, %edi
cmovael	%eax, %edi
addl	%edx, %edi
movq	(%rdi,%r13), %rax
movq	%rax, 0x48(%rsp)
addq	%r10, %rdi
movl	0x90(%rbx), %eax
movl	%eax, %r15d
shrl	$0x2, %r15d
cmpl	0xb8(%rbx), %edx
movl	0x4c(%rbx), %r11d
cmovbl	%eax, %r15d
movl	$0xfffffefa, %eax
addl	0x40(%rbx), %eax
xorl	%r12d, %r12d
movl	%r8d, %esi
subl	%eax, %esi
cmovbel	%r12d, %esi
movq	0x60(%rbx), %rax
movq	%rax, 0x38(%rsp)
movq	(%r10,%r8), %rax
movl	0xbc(%rbx), %ecx
movl	%ecx, 0x64(%rsp)
movl	%edx, (%rsp)
cmpl	$0x3, %edx
movq	%rax, 0x58(%rsp)
movl	%r11d, 0x44(%rsp)
jb	L_5b0
movl	%r15d, 0x1c(%rsp)
movq	%rsi, 0x10(%rsp)
movq	%rdi, 0x30(%rsp)
movq	%r10, 0x50(%rsp)
movl	%r9d, 0xc(%rsp)
movq	%r8, 0x28(%rsp)
movzbl	%ah, %esi
xorl	%r12d, %r12d
xorl	%edi, %edi
callq	*0x98(%rbx)
movzbl	0x2(%r13), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movq	%r13, %rbp
movl	$0x3, %r13d
movl	(%rsp), %r15d
nopw	%cs:(%rax,%rax)
L_540:
movl	%r13d, %ecx
movzbl	(%rbp,%rcx), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movq	0x68(%rbx), %rcx
movl	%eax, %edx
movzwl	(%rcx,%rdx,2), %ecx
leal	-0x2(%r13), %edx
cmpw	%r14w, %cx
cmovbl	%edx, %r12d
cmovbl	%ecx, %r14d
incl	%r13d
cmpl	%r15d, %r13d
jbe	L_540
movq	0x10(%rsp), %rsi
leal	(%r12,%rsi), %r11d
cmpw	%r11w, %r14w
movq	0x30(%rsp), %rdi
jbe	L_9ed
movzwl	%r12w, %edx
movq	0x50(%rsp), %r10
movq	%r10, %rcx
subq	%rdx, %rcx
subq	%rdx, %rdi
movq	0x28(%rsp), %r8
movl	0xc(%rsp), %r9d
movq	%rbp, %r13
movl	0x1c(%rsp), %r15d
jmp	L_5b6
L_5b0:
movl	%esi, %r11d
movq	%r10, %rcx
L_5b6:
movzwl	%r14w, %edx
cmpl	%edx, %r8d
jbe	L_9e8
movq	0x48(%rsp), %rdx
movl	%edx, %eax
shrl	$0x10, %eax
movl	%eax, 0x30(%rsp)
shrq	$0x20, %rdx
movq	%rdx, 0x80(%rsp)
movzwl	%si, %eax
movq	%rax, 0x78(%rsp)
movl	(%rsp), %eax
movq	%rbx, 0x20(%rsp)
L_5ed:
cmpl	$0x3, %eax
movl	%eax, %ebx
ja	L_650
movl	%ebx, %eax
movq	0x20(%rsp), %rbx
nopl	(%rax,%rax)
L_600:
movzwl	%r14w, %edx
movq	0x48(%rsp), %rbp
cmpw	%bp, (%rdi,%rdx)
jne	L_61e
movq	0x58(%rsp), %rbp
cmpw	%bp, (%rcx,%rdx)
je	L_70d
L_61e:
cmpl	$0x1, %r15d
je	L_9f8
andl	%r9d, %edx
movq	0x38(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%r11w, %r14w
ja	L_600
jmp	L_9f8
nopw	%cs:(%rax,%rax)
L_650:
movq	%rsi, 0x10(%rsp)
movzwl	0x48(%rsp), %edx
movl	%ebx, %eax
cmpl	$0x7, %ebx
jbe	L_6ba
movl	0x30(%rsp), %esi
shll	$0x10, %esi
orq	%rsi, %rdx
movq	0x80(%rsp), %rsi
shlq	$0x20, %rsi
orq	%rdx, %rsi
movq	0x20(%rsp), %rbx
nop
L_680:
movzwl	%r14w, %edx
cmpq	%rsi, (%rdi,%rdx)
jne	L_695
movq	0x58(%rsp), %rbp
cmpq	%rbp, (%rcx,%rdx)
je	L_708
L_695:
cmpl	$0x1, %r15d
je	L_9f8
andl	%r9d, %edx
movq	0x38(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%r11w, %r14w
ja	L_680
jmp	L_9f8
L_6ba:
movl	0x30(%rsp), %esi
shll	$0x10, %esi
orl	%edx, %esi
movq	0x20(%rsp), %rbx
nopl	(%rax,%rax)
L_6d0:
movzwl	%r14w, %edx
cmpl	%esi, (%rdi,%rdx)
jne	L_6e3
movq	0x58(%rsp), %rbp
cmpl	%ebp, (%rcx,%rdx)
je	L_708
L_6e3:
cmpl	$0x1, %r15d
je	L_9f8
andl	%r9d, %edx
movq	0x38(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%r11w, %r14w
ja	L_6d0
jmp	L_9f8
L_708:
movq	0x10(%rsp), %rsi
L_70d:
vmovdqu	0x2(%r13), %xmm0
vpcmpeqb	0x2(%rcx,%rdx), %xmm0, %k0
kortestw	%k0, %k0
movq	%rsi, 0x10(%rsp)
jb	L_73b
kmovd	%k0, %edx
movzwl	%dx, %edx
notl	%edx
tzcntl	%edx, %edx
jmp	L_801
L_73b:
vmovdqu64	0x12(%r13), %zmm0
vpcmpeqb	0x12(%rcx,%rdx), %zmm0, %k0
kortestq	%k0, %k0
jb	L_76c
kmovq	%k0, %rdx
notq	%rdx
tzcntq	%rdx, %rdx
addl	$0x10, %edx
jmp	L_801
L_76c:
vmovdqu64	0x52(%r13), %zmm0
vpcmpeqb	0x52(%rcx,%rdx), %zmm0, %k0
kortestq	%k0, %k0
jb	L_79a
kmovq	%k0, %rdx
notq	%rdx
tzcntq	%rdx, %rdx
addl	$0x50, %edx
jmp	L_801
L_79a:
vmovdqu64	0x92(%r13), %zmm0
vpcmpeqb	0x92(%rcx,%rdx), %zmm0, %k0
kortestq	%k0, %k0
jb	L_7cb
kmovq	%k0, %rdx
notq	%rdx
tzcntq	%rdx, %rdx
addl	$0x90, %edx
jmp	L_801
L_7cb:
vmovdqu64	0xc2(%r13), %zmm0
vpcmpeqb	0xc2(%rcx,%rdx), %zmm0, %k0
kortestq	%k0, %k0
jb	L_7fc
kmovq	%k0, %rdx
notq	%rdx
tzcntq	%rdx, %rdx
orl	$0xc0, %edx
jmp	L_801
L_7fc:
movl	$0x100, %edx
L_801:
movl	%edx, %ebp
addq	$0x2, %rbp
movzwl	%r14w, %esi
cmpl	%eax, %ebp
jbe	L_8aa
movq	%rdx, 0x70(%rsp)
movzwl	%r12w, %edx
movl	%esi, %r14d
subl	%edx, %r14d
movl	%r14d, 0x88(%rbx)
cmpl	0x44(%rsp), %ebp
jae	L_a0d
cmpl	0x64(%rsp), %ebp
jae	L_a13
movq	%rsi, 0x28(%rsp)
movq	%rbp, (%rsp)
movq	0x70(%rsp), %rsi
leal	0x1(%rsi), %edi
leal	-0x1(%rsi), %eax
leal	-0x5(%rsi), %ebp
cmpl	$0x6, %esi
movl	%eax, 0xc(%rsp)
cmovbl	%eax, %ebp
cmpl	$0x2, %esi
cmovbl	%edi, %ebp
movq	%rbp, %rdi
movq	(%r13,%rbp), %rdx
movl	%edx, %eax
shrl	$0x10, %eax
movl	%eax, 0x30(%rsp)
movq	%rdx, 0x48(%rsp)
shrq	$0x20, %rdx
movq	%rdx, 0x80(%rsp)
cmpl	$0x2, %esi
jb	L_89e
movq	%rdi, %rbp
movq	(%rsp), %rax
leal	(%rax,%r14), %edi
cmpl	%r8d, %edi
movq	%rbp, %rdi
jb	L_8e5
L_89e:
addq	%rcx, %rdi
movq	(%rsp), %rax
movq	0x28(%rsp), %rsi
L_8aa:
decl	%r15d
je	L_9f8
andl	%r9d, %esi
movq	0x38(%rsp), %rdx
movzwl	(%rdx,%rsi,2), %r14d
movl	%eax, %ebp
cmpw	%r11w, %r14w
movq	0x10(%rsp), %rsi
jbe	L_9f8
L_8d1:
movzwl	%r14w, %edx
movl	%ebp, %eax
cmpl	%edx, %r8d
ja	L_5ed
jmp	L_9f8
L_8e5:
movl	%r15d, 0x1c(%rsp)
movq	%r13, 0x68(%rsp)
movq	%r10, 0x50(%rsp)
movq	%r8, 0x28(%rsp)
movzwl	%r14w, %eax
xorl	%ecx, %ecx
xorl	%r12d, %r12d
movq	0x78(%rsp), %rdx
movl	0xc(%rsp), %r10d
jmp	L_915
L_90e:
incl	%ecx
cmpl	%r10d, %ecx
ja	L_942
L_915:
leal	(%rax,%rcx), %esi
andl	%r9d, %esi
movq	0x38(%rsp), %rdi
movzwl	(%rdi,%rsi,2), %esi
cmpw	%r14w, %si
jae	L_90e
movzwl	%si, %edi
leal	(%rdx,%rcx), %r8d
cmpl	%edi, %r8d
jae	L_a17
movl	%ecx, %r12d
movl	%esi, %r14d
jmp	L_90e
L_942:
movl	%r9d, 0xc(%rsp)
movq	0x68(%rsp), %r15
movq	(%rsp), %r13
movzbl	-0x4(%r15,%r13), %esi
xorl	%edi, %edi
movq	0x20(%rsp), %rbx
vzeroupper
callq	*0x98(%rbx)
movzbl	-0x3(%r15,%r13), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movzbl	-0x2(%r15,%r13), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movq	0x68(%rbx), %rcx
movl	%eax, %eax
movzwl	(%rcx,%rax,2), %eax
cmpw	%r14w, %ax
jae	L_9ad
movzwl	%ax, %ecx
movq	0x70(%rsp), %r12
addl	$-0x2, %r12d
movzwl	%r12w, %edx
addl	0x78(%rsp), %edx
movl	%eax, %r14d
cmpl	%ecx, %edx
jae	L_a17
L_9ad:
movq	0x10(%rsp), %rsi
leal	(%r12,%rsi), %r11d
movzwl	%r12w, %edx
movq	0x50(%rsp), %r10
movq	%r10, %rcx
subq	%rdx, %rcx
movq	%rbp, %rdi
addq	%rcx, %rdi
movq	0x28(%rsp), %r8
movl	0xc(%rsp), %r9d
movq	0x68(%rsp), %r13
movl	0x1c(%rsp), %r15d
movq	(%rsp), %rbp
jmp	L_8d1
L_9e8:
movl	(%rsp), %eax
jmp	L_9f8
L_9ed:
movl	(%rsp), %ecx
L_9f0:
movl	0x4c(%rbx), %eax
cmpl	%eax, %ecx
cmovbl	%ecx, %eax
L_9f8:
addq	$0x88, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
vzeroupper
retq
L_a0d:
movl	0x44(%rsp), %eax
jmp	L_9f8
L_a13:
movl	%ebp, %eax
jmp	L_9f8
L_a17:
movq	(%rsp), %rax
movl	%eax, %ecx
movq	0x20(%rsp), %rbx
jmp	L_9f0

	.text
compare256_avx2:
vmovdqu	(%rdi), %ymm0
vpcmpeqb	(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
xorl	%ecx, %ecx
cmpl	$-0x1, %eax
je	L_1f
L_13:
notl	%eax
tzcntl	%eax, %eax
orl	%ecx, %eax
vzeroupper
retq
L_1f:
vmovdqu	0x20(%rdi), %ymm0
vpcmpeqb	0x20(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
xorl	%ecx, %ecx
cmpl	$-0x1, %eax
je	L_43
L_34:
notl	%eax
tzcntl	%eax, %eax
addl	%ecx, %eax
addl	$0x20, %eax
vzeroupper
retq
L_43:
vmovdqu	0x40(%rdi), %ymm0
vpcmpeqb	0x40(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
movl	$0x40, %ecx
cmpl	$-0x1, %eax
jne	L_13
vmovdqu	0x60(%rdi), %ymm0
vpcmpeqb	0x60(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
movl	$0x40, %ecx
cmpl	$-0x1, %eax
jne	L_34
vmovdqu	0x80(%rdi), %ymm0
vpcmpeqb	0x80(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
movl	$0x80, %ecx
cmpl	$-0x1, %eax
jne	L_13
vmovdqu	0xa0(%rdi), %ymm0
vpcmpeqb	0xa0(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
movl	$0x80, %ecx
cmpl	$-0x1, %eax
jne	L_34
vmovdqu	0xc0(%rdi), %ymm0
vpcmpeqb	0xc0(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
movl	$0xc0, %ecx
cmpl	$-0x1, %eax
jne	L_13
vmovdqu	0xe0(%rdi), %ymm0
vpcmpeqb	0xe0(%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %eax
movl	$0xc0, %ecx
cmpl	$-0x1, %eax
jne	L_34
movl	$0x100, %eax
vzeroupper
retq
nopl	(%rax)
longest_match_avx2:
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
L_1c6:
movzwl	%si, %r8d
cmpl	%r8d, %ecx
jbe	L_4be
cmpl	$0x3, %eax
ja	L_220
movq	-0x18(%rsp), %r14
nopl	(%rax)
L_1e0:
movzwl	%si, %esi
cmpw	%r11w, (%r9,%rsi)
jne	L_1f5
cmpw	%r13w, (%rdx,%rsi)
je	L_2b2
L_1f5:
cmpl	$0x1, %r10d
je	L_4be
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
decl	%r10d
cmpw	%bp, %si
ja	L_1e0
jmp	L_4be
nopw	%cs:(%rax,%rax)
L_220:
movzwl	%r11w, %r14d
cmpl	$0x7, %eax
jbe	L_270
movl	%r15d, %r8d
shll	$0x10, %r8d
orq	%r8, %r14
movq	-0x8(%rsp), %r8
shlq	$0x20, %r8
orq	%r14, %r8
nop
L_240:
movzwl	%si, %esi
cmpq	%r8, (%r9,%rsi)
jne	L_24f
cmpq	%r13, (%rdx,%rsi)
je	L_2ad
L_24f:
cmpl	$0x1, %r10d
je	L_4be
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
decl	%r10d
cmpw	%bp, %si
ja	L_240
jmp	L_4be
nopl	(%rax)
L_270:
movl	%r15d, %r8d
shll	$0x10, %r8d
orl	%r14d, %r8d
nopw	(%rax,%rax)
L_280:
movzwl	%si, %esi
cmpl	%r8d, (%r9,%rsi)
jne	L_28f
cmpl	%r13d, (%rdx,%rsi)
je	L_2ad
L_28f:
cmpl	$0x1, %r10d
je	L_4be
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
decl	%r10d
cmpw	%bp, %si
ja	L_280
jmp	L_4be
L_2ad:
movq	-0x18(%rsp), %r14
L_2b2:
vmovdqu	0x2(%r14), %ymm0
vpcmpeqb	0x2(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	$0x0, -0x28(%rsp)
cmpl	$-0x1, %r8d
je	L_2df
L_2d0:
notl	%r8d
tzcntl	%r8d, %r14d
orl	-0x28(%rsp), %r14d
jmp	L_316
L_2df:
vmovdqu	0x22(%r14), %ymm0
vpcmpeqb	0x22(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movq	$0x0, -0x28(%rsp)
cmpl	$-0x1, %r8d
je	L_3a9
L_302:
notl	%r8d
tzcntl	%r8d, %r8d
movq	-0x28(%rsp), %r14
addl	%r8d, %r14d
addl	$0x20, %r14d
L_316:
leal	0x2(%r14), %r8d
cmpl	%eax, %r8d
jbe	L_380
movl	%esi, 0x88(%rdi)
cmpl	-0x1c(%rsp), %r8d
jae	L_4b5
cmpl	-0x10(%rsp), %r8d
jae	L_4bb
cmpl	$0x6, %r14d
movl	$0x0, %r9d
sbbl	%r9d, %r9d
orl	$-0x5, %r9d
cmpl	$0x2, %r14d
movl	$0x1, %eax
cmovbl	%eax, %r9d
addl	%r14d, %r9d
movq	-0x18(%rsp), %rax
movq	(%rax,%r9), %r11
movl	%r11d, %r15d
shrl	$0x10, %r15d
movq	%r11, %rax
shrq	$0x20, %rax
movq	%rax, -0x8(%rsp)
addq	%rdx, %r9
movl	%r8d, %eax
jmp	L_38b
L_380:
cmpl	$0x5, -0xc(%rsp)
jl	L_4be
L_38b:
decl	%r10d
je	L_4be
andl	%ebx, %esi
movzwl	(%r12,%rsi,2), %esi
cmpw	%bp, %si
ja	L_1c6
jmp	L_4be
L_3a9:
vmovdqu	0x42(%r14), %ymm0
vpcmpeqb	0x42(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	$0x40, -0x28(%rsp)
cmpl	$-0x1, %r8d
jne	L_2d0
vmovdqu	0x62(%r14), %ymm0
vpcmpeqb	0x62(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	%r8d, -0x20(%rsp)
movl	$0x40, %r8d
movq	%r8, -0x28(%rsp)
movl	-0x20(%rsp), %r8d
cmpl	$-0x1, %r8d
jne	L_302
vmovdqu	0x82(%r14), %ymm0
vpcmpeqb	0x82(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	$0x80, -0x28(%rsp)
cmpl	$-0x1, %r8d
jne	L_2d0
vmovdqu	0xa2(%r14), %ymm0
vpcmpeqb	0xa2(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	%r8d, -0x20(%rsp)
movl	$0x80, %r8d
movq	%r8, -0x28(%rsp)
movl	-0x20(%rsp), %r8d
cmpl	$-0x1, %r8d
jne	L_302
vmovdqu	0xc2(%r14), %ymm0
vpcmpeqb	0xc2(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	$0xc0, -0x28(%rsp)
cmpl	$-0x1, %r8d
jne	L_2d0
vmovdqu	0xe2(%r14), %ymm0
vpcmpeqb	0xe2(%rdx,%rsi), %ymm0, %ymm0
vpmovmskb	%ymm0, %r8d
movl	$0xc0, %r14d
movq	%r14, -0x28(%rsp)
cmpl	$-0x1, %r8d
jne	L_302
movl	$0x100, %r14d
jmp	L_316
L_4b5:
movl	-0x1c(%rsp), %eax
jmp	L_4be
L_4bb:
movl	%r8d, %eax
L_4be:
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
vzeroupper
retq
nopl	(%rax)
longest_match_slow_avx2:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x78, %rsp
movl	%esi, %r14d
movq	%rdi, %rbx
movl	0x84(%rdi), %r8d
movl	0x48(%rdi), %r9d
movq	0x58(%rdi), %r10
leaq	(%r10,%r8), %rdx
movl	0x8c(%rdi), %eax
testl	%eax, %eax
movl	$0x2, %r13d
cmovnel	%eax, %r13d
xorl	%eax, %eax
cmpl	$0x8, %r13d
setb	%al
shll	$0x2, %eax
orl	$-0x7, %eax
cmpl	$0x4, %r13d
movl	$0xffffffff, %ebp
cmovael	%eax, %ebp
addl	%r13d, %ebp
movq	(%rbp,%rdx), %r11
addq	%r10, %rbp
movl	0x90(%rdi), %eax
movl	%eax, %r15d
shrl	$0x2, %r15d
cmpl	0xb8(%rdi), %r13d
movl	0x4c(%rdi), %esi
cmovbl	%eax, %r15d
movl	$0xfffffefa, %eax
addl	0x40(%rdi), %eax
xorl	%r12d, %r12d
movl	%r8d, %edi
subl	%eax, %edi
cmovbel	%r12d, %edi
movq	0x60(%rbx), %rax
movq	%rax, 0x28(%rsp)
movq	(%r10,%r8), %rax
movl	0xbc(%rbx), %ecx
movl	%ecx, 0x58(%rsp)
cmpl	$0x3, %r13d
movq	%rax, 0x50(%rsp)
movl	%esi, 0x5c(%rsp)
jb	L_665
movl	%r15d, 0x24(%rsp)
movq	%r11, 0x30(%rsp)
movq	%rdi, 0x18(%rsp)
movq	%rbp, 0x38(%rsp)
movq	%r10, 0x40(%rsp)
movl	%r9d, 0x14(%rsp)
movq	%r8, 0x48(%rsp)
movzbl	%ah, %esi
xorl	%r12d, %r12d
xorl	%edi, %edi
movq	%rdx, %rbp
callq	*0x98(%rbx)
movzbl	0x2(%rbp), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movl	%r13d, %r15d
movl	$0x3, %r13d
nopw	%cs:(%rax,%rax)
L_5e0:
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
jbe	L_5e0
movq	%rbx, (%rsp)
movq	0x18(%rsp), %rdi
leal	(%r12,%rdi), %eax
cmpw	%ax, %r14w
jbe	L_adf
movzwl	%r12w, %edx
movq	0x40(%rsp), %r10
movq	%r10, %rcx
subq	%rdx, %rcx
movq	0x38(%rsp), %rsi
subq	%rdx, %rsi
movq	0x48(%rsp), %r8
movl	0x14(%rsp), %r9d
movq	%rbp, 0x8(%rsp)
movq	%rsi, %rbp
movq	0x30(%rsp), %r11
movl	%r15d, %r13d
movq	(%rsp), %rbx
movl	0x24(%rsp), %r15d
jmp	L_66f
L_665:
movq	%rdx, 0x8(%rsp)
movl	%edi, %eax
movq	%r10, %rcx
L_66f:
movzwl	%r14w, %edx
cmpl	%edx, %r8d
jbe	L_ad5
movl	%r11d, %edx
shrl	$0x10, %edx
movl	%edx, 0x20(%rsp)
movq	%r11, %rdx
shrq	$0x20, %rdx
movq	%rdx, 0x70(%rsp)
movzwl	%di, %edx
movq	%rdx, 0x68(%rsp)
L_69a:
cmpl	$0x3, %r13d
ja	L_6e0
L_6a0:
movzwl	%r14w, %edx
cmpw	%r11w, (%rbp,%rdx)
jne	L_6bb
movq	0x50(%rsp), %rsi
cmpw	%si, (%rcx,%rdx)
je	L_79a
L_6bb:
cmpl	$0x1, %r15d
je	L_ad5
andl	%r9d, %edx
movq	0x28(%rsp), %rsi
movzwl	(%rsi,%rdx,2), %r14d
decl	%r15d
cmpw	%ax, %r14w
ja	L_6a0
jmp	L_ad5
L_6e0:
movzwl	%r11w, %edx
movl	%r13d, (%rsp)
cmpl	$0x7, %r13d
movq	%r11, %r13
jbe	L_74b
movl	0x20(%rsp), %esi
shll	$0x10, %esi
orq	%rsi, %rdx
movq	0x70(%rsp), %rsi
shlq	$0x20, %rsi
orq	%rdx, %rsi
nopw	(%rax,%rax)
L_710:
movzwl	%r14w, %edx
cmpq	%rsi, (%rbp,%rdx)
jne	L_726
movq	0x50(%rsp), %r11
cmpq	%r11, (%rcx,%rdx)
je	L_7a1
L_726:
cmpl	$0x1, %r15d
je	L_ad1
andl	%r9d, %edx
movq	0x28(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%ax, %r14w
ja	L_710
jmp	L_ad1
L_74b:
movl	0x20(%rsp), %esi
shll	$0x10, %esi
orl	%edx, %esi
nopw	%cs:(%rax,%rax)
L_760:
movzwl	%r14w, %edx
cmpl	%esi, (%rbp,%rdx)
jne	L_775
movq	0x50(%rsp), %r11
cmpl	%r11d, (%rcx,%rdx)
je	L_7a1
L_775:
cmpl	$0x1, %r15d
je	L_ad1
andl	%r9d, %edx
movq	0x28(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%ax, %r14w
ja	L_760
jmp	L_ad1
L_79a:
movq	%rdi, 0x18(%rsp)
jmp	L_7ad
L_7a1:
movq	%r13, %r11
movq	%rdi, 0x18(%rsp)
movl	(%rsp), %r13d
L_7ad:
movq	0x8(%rsp), %rsi
vmovdqu	0x2(%rsi), %ymm0
vpcmpeqb	0x2(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
xorl	%edi, %edi
cmpl	$-0x1, %esi
je	L_7d2
L_7c8:
notl	%esi
tzcntl	%esi, %edx
orl	%edi, %edx
jmp	L_7fc
L_7d2:
movq	0x8(%rsp), %rsi
vmovdqu	0x22(%rsi), %ymm0
vpcmpeqb	0x22(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
xorl	%edi, %edi
cmpl	$-0x1, %esi
je	L_8d7
L_7f1:
notl	%esi
tzcntl	%esi, %edx
addl	%edi, %edx
addl	$0x20, %edx
L_7fc:
movq	%rdx, 0x60(%rsp)
movl	%edx, %edx
addq	$0x2, %rdx
movzwl	%r14w, %esi
cmpl	%r13d, %edx
movq	0x18(%rsp), %rdi
jbe	L_89f
movzwl	%r12w, %edi
movl	%esi, %r14d
subl	%edi, %r14d
movl	%r14d, 0x88(%rbx)
movl	0x5c(%rsp), %r13d
cmpl	%r13d, %edx
jae	L_ad5
movq	%rdx, %r13
cmpl	0x58(%rsp), %edx
jae	L_ada
movq	0x60(%rsp), %rdx
leal	0x1(%rdx), %edi
leal	-0x1(%rdx), %r11d
leal	-0x5(%rdx), %ebp
cmpl	$0x6, %edx
movl	%r11d, 0x14(%rsp)
cmovbl	%r11d, %ebp
cmpl	$0x2, %edx
cmovbl	%edi, %ebp
movq	0x8(%rsp), %rdi
movq	(%rdi,%rbp), %r11
movl	%r11d, %edi
shrl	$0x10, %edi
movl	%edi, 0x20(%rsp)
movq	%r11, %rdi
shrq	$0x20, %rdi
movq	%rdi, 0x70(%rsp)
cmpl	$0x2, %edx
jb	L_897
leal	(%r14,%r13), %edi
cmpl	%r8d, %edi
jb	L_9c5
L_897:
addq	%rcx, %rbp
movq	0x18(%rsp), %rdi
L_89f:
decl	%r15d
je	L_ad5
andl	%r9d, %esi
movq	0x28(%rsp), %rdx
movzwl	(%rdx,%rsi,2), %r14d
movl	%r13d, %esi
cmpw	%ax, %r14w
jbe	L_ad5
L_8c2:
movzwl	%r14w, %edx
movl	%esi, %r13d
cmpl	%edx, %r8d
ja	L_69a
jmp	L_ad5
L_8d7:
movq	0x8(%rsp), %rsi
vmovdqu	0x42(%rsi), %ymm0
vpcmpeqb	0x42(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
movl	$0x40, %edi
cmpl	$-0x1, %esi
jne	L_7c8
movq	0x8(%rsp), %rsi
vmovdqu	0x62(%rsi), %ymm0
vpcmpeqb	0x62(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
movl	$0x40, %edi
cmpl	$-0x1, %esi
jne	L_7f1
movq	0x8(%rsp), %rsi
vmovdqu	0x82(%rsi), %ymm0
vpcmpeqb	0x82(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
movl	$0x80, %edi
cmpl	$-0x1, %esi
jne	L_7c8
movq	0x8(%rsp), %rsi
vmovdqu	0xa2(%rsi), %ymm0
vpcmpeqb	0xa2(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
movl	$0x80, %edi
cmpl	$-0x1, %esi
jne	L_7f1
movq	0x8(%rsp), %rsi
vmovdqu	0xc2(%rsi), %ymm0
vpcmpeqb	0xc2(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
movl	$0xc0, %edi
cmpl	$-0x1, %esi
jne	L_7c8
movq	0x8(%rsp), %rsi
vmovdqu	0xe2(%rsi), %ymm0
vpcmpeqb	0xe2(%rcx,%rdx), %ymm0, %ymm0
vpmovmskb	%ymm0, %esi
movl	$0xc0, %edi
cmpl	$-0x1, %esi
jne	L_7f1
movl	$0x100, %edx
jmp	L_7fc
L_9c5:
movl	%r15d, 0x24(%rsp)
movq	%rbx, (%rsp)
movq	%r11, 0x30(%rsp)
movq	%rbp, 0x38(%rsp)
movq	0x8(%rsp), %r15
movq	%r10, 0x40(%rsp)
movq	%r8, 0x48(%rsp)
movzwl	%r14w, %eax
xorl	%ecx, %ecx
xorl	%r12d, %r12d
movq	0x68(%rsp), %r10
movl	0x14(%rsp), %edx
jmp	L_a07
L_9fb:
movl	%ecx, %r12d
movl	%esi, %r14d
L_a01:
incl	%ecx
cmpl	%edx, %ecx
ja	L_a2d
L_a07:
leal	(%rax,%rcx), %esi
andl	%r9d, %esi
movq	0x28(%rsp), %rdi
movzwl	(%rdi,%rsi,2), %esi
cmpw	%r14w, %si
jae	L_a01
movzwl	%si, %edi
leal	(%r10,%rcx), %r8d
cmpl	%edi, %r8d
jb	L_9fb
jmp	L_adc
L_a2d:
movl	%r9d, 0x14(%rsp)
movzbl	-0x4(%r15,%r13), %esi
xorl	%edi, %edi
movq	(%rsp), %rbx
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
jae	L_a8e
movzwl	%ax, %ecx
movq	0x60(%rsp), %r12
addl	$-0x2, %r12d
movzwl	%r12w, %edx
addl	0x68(%rsp), %edx
movl	%eax, %r14d
cmpl	%ecx, %edx
jae	L_adc
L_a8e:
movq	0x18(%rsp), %rdi
leal	(%r12,%rdi), %eax
movzwl	%r12w, %edx
movq	0x40(%rsp), %r10
movq	%r10, %rcx
subq	%rdx, %rcx
movq	0x38(%rsp), %rdx
addq	%rcx, %rdx
movq	0x48(%rsp), %r8
movl	0x14(%rsp), %r9d
movq	%rdx, %rbp
movq	0x30(%rsp), %r11
movq	(%rsp), %rbx
movl	0x24(%rsp), %r15d
movq	%r13, %rsi
jmp	L_8c2
L_ad1:
movl	(%rsp), %r13d
L_ad5:
movl	%r13d, %eax
jmp	L_aed
L_ada:
jmp	L_ad5
L_adc:
movl	%r13d, %r15d
L_adf:
movq	(%rsp), %rax
movl	0x4c(%rax), %eax
cmpl	%eax, %r15d
cmovbl	%r15d, %eax
L_aed:
addq	$0x78, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
vzeroupper
retq

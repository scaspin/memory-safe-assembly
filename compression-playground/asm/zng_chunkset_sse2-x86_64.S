	.text
chunkmemset_safe_sse2:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x18, %rsp
movq	%rdi, %rbx
cmpl	%ecx, %edx
movl	%ecx, %r13d
cmovbl	%edx, %r13d
cmpl	$0xf, %ecx
jbe	L_1e0
testl	%edx, %edx
je	L_1ce
movq	%rbx, %rax
subq	%rsi, %rax
movq	%rax, %rdi
negq	%rdi
cmovsq	%rax, %rdi
testq	%rax, %rax
jns	L_5b
movl	%r13d, %r15d
cmpq	%r15, %rdi
jae	L_5b
movq	%rbx, %rdi
movq	%r15, %rdx
callq	memmove
addq	%r15, %rbx
jmp	L_1ce
L_5b:
cmpq	$0x1, %rdi
jne	L_7a
movl	%r13d, %r15d
movzbl	(%rsi), %esi
movq	%rbx, %rdi
movq	%r15, %rdx
callq	memset
addq	%r15, %rbx
jmp	L_1ce
L_7a:
cmpq	$0x10, %rdi
jb	L_ca
leal	-0x1(%r13), %eax
andl	$0xf, %eax
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%rbx)
movl	%eax, %edi
notl	%edi
addl	%r13d, %edi
je	L_ea
incq	%rax
movl	%ecx, %edi
movl	%edx, %ecx
cmpq	%rcx, %rdi
cmovbq	%rdi, %rcx
nopw	%cs:(%rax,%rax)
L_b0:
movdqu	(%rsi,%rax), %xmm0
movdqu	%xmm0, (%rbx,%rax)
addq	$0x10, %rax
cmpl	%eax, %ecx
jne	L_b0
L_c2:
addq	%rax, %rbx
jmp	L_1ce
L_ca:
cmpq	$0x8, %rdi
je	L_100
cmpq	$0x4, %rdi
je	L_f5
cmpq	$0x2, %rdi
jne	L_11e
movzwl	(%rsi), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_f9
L_ea:
addq	%rax, %rbx
incq	%rbx
jmp	L_1ce
L_f5:
movd	(%rsi), %xmm0
L_f9:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_109
L_100:
movq	(%rsi), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_109:
movdqa	%xmm0, (%rsp)
movl	$0x10, %eax
cmpl	$0x20, %r13d
jae	L_170
jmp	L_195
L_11e:
movl	$0x10, %r14d
movq	%rsp, %r15
movq	%rdi, 0x10(%rsp)
nopl	(%rax)
L_130:
cmpq	%rdi, %r14
movq	%rdi, %r12
cmovbq	%r14, %r12
movq	%r15, %rdi
movq	%r12, %rdx
movq	%rsi, %rbp
callq	memcpy
movq	0x10(%rsp), %rdi
movq	%rbp, %rsi
addq	%r12, %r15
subq	%r12, %r14
jne	L_130
movdqa	(%rsp), %xmm0
movdqa	%xmm0, (%rsp)
movl	$0x10, %eax
subl	%r12d, %eax
cmpl	$0x20, %r13d
jb	L_195
L_170:
movl	%eax, %ecx
leal	(%rax,%rax), %edx
nopw	%cs:(%rax,%rax)
L_180:
movdqu	%xmm0, (%rbx)
movdqu	%xmm0, (%rbx,%rcx)
addq	%rdx, %rbx
subl	%edx, %r13d
cmpl	$0x1f, %r13d
ja	L_180
L_195:
cmpl	$0x10, %r13d
jb	L_1b5
movl	%eax, %ecx
nopl	(%rax)
L_1a0:
movdqa	(%rsp), %xmm0
movdqu	%xmm0, (%rbx)
subl	%eax, %r13d
addq	%rcx, %rbx
cmpl	$0xf, %r13d
ja	L_1a0
L_1b5:
testl	%r13d, %r13d
je	L_1ce
movl	%r13d, %r14d
movq	%rsp, %rsi
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memcpy
addq	%r14, %rbx
L_1ce:
movq	%rbx, %rax
addq	$0x18, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
L_1e0:
testl	%r13d, %r13d
je	L_1ce
movl	%r13d, %eax
testb	$0x7, %r13b
je	L_219
andl	$0x7, %eax
xorl	%r8d, %r8d
L_1f4:
movzbl	(%rsi,%r8), %edi
movb	%dil, (%rbx,%r8)
incq	%r8
cmpl	%r8d, %eax
jne	L_1f4
movl	%ecx, %ecx
movl	%edx, %eax
cmpq	%rax, %rcx
cmovbq	%rcx, %rax
subl	%r8d, %eax
addq	%r8, %rsi
addq	%r8, %rbx
L_219:
cmpl	$0x8, %r13d
jb	L_1ce
movl	%eax, %ecx
xorl	%eax, %eax
L_223:
movzbl	(%rsi,%rax), %edx
movb	%dl, (%rbx,%rax)
movzbl	0x1(%rsi,%rax), %edx
movb	%dl, 0x1(%rbx,%rax)
movzbl	0x2(%rsi,%rax), %edx
movb	%dl, 0x2(%rbx,%rax)
movzbl	0x3(%rsi,%rax), %edx
movb	%dl, 0x3(%rbx,%rax)
movzbl	0x4(%rsi,%rax), %edx
movb	%dl, 0x4(%rbx,%rax)
movzbl	0x5(%rsi,%rax), %edx
movb	%dl, 0x5(%rbx,%rax)
movzbl	0x6(%rsi,%rax), %edx
movb	%dl, 0x6(%rbx,%rax)
movzbl	0x7(%rsi,%rax), %edx
movb	%dl, 0x7(%rbx,%rax)
addq	$0x8, %rax
cmpl	%eax, %ecx
jne	L_223
jmp	L_c2
nopw	%cs:(%rax,%rax)
inflate_fast_sse2:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0xa8, %rsp
movq	%rdi, %r14
movq	0x38(%rdi), %r15
movq	(%rdi), %r8
movl	0x8(%rdi), %r11d
addl	$-0xe, %r11d
movq	0x18(%rdi), %r12
movl	0x20(%rdi), %edi
subl	%edi, %esi
movq	%r12, %rax
subq	%rsi, %rax
movq	%rax, 0x80(%rsp)
leal	-0x103(%rdi), %r10d
movl	0x40(%r15), %esi
movzbl	0x64(%r15), %ecx
movl	$0xffffffff, %eax
movl	$0xffffffff, %edx
shll	%cl, %edx
movzbl	0x78(%r15), %ecx
shll	%cl, %eax
movq	0x50(%r15), %r9
notl	%edx
notl	%eax
movl	%esi, 0x40(%rsp)
testl	%esi, %esi
sete	%cl
cmpq	%r9, %r12
setb	%sil
orb	%cl, %sil
movq	%r9, 0x60(%rsp)
je	L_309
movl	$0x0, 0x24(%rsp)
jmp	L_322
L_309:
leaq	0x104(%r12), %rcx
movl	0x44(%r15), %esi
addq	%r9, %rsi
cmpq	%rsi, %rcx
setbe	%cl
movl	%ecx, 0x24(%rsp)
L_322:
addq	%r8, %r11
addq	%r12, %r10
addq	%r12, %rdi
movq	%rdi, 0x28(%rsp)
movl	0x48(%r15), %ecx
movl	%ecx, 0x6c(%rsp)
movl	0x4c(%r15), %ecx
movl	%ecx, 0x44(%rsp)
movq	0x58(%r15), %rbx
movl	0x60(%r15), %ebp
movq	0x68(%r15), %r9
movq	0x70(%r15), %rcx
movq	%rcx, 0xa0(%rsp)
movl	%edx, %edx
movl	%eax, %eax
movq	%rax, 0x88(%rsp)
movq	%r11, 0x10(%rsp)
movq	%r10, 0x18(%rsp)
movq	%r9, 0x98(%rsp)
movq	%rdx, 0x90(%rsp)
L_37e:
movq	(%r8), %r13
movl	%ebp, %ecx
shlq	%cl, %r13
orq	%rbx, %r13
movl	%ebp, %eax
shrl	$0x3, %eax
andl	$0x7, %eax
subq	%rax, %r8
addq	$0x7, %r8
orl	$0x38, %ebp
movl	%r13d, %eax
andl	%edx, %eax
leaq	(%r9,%rax,4), %rsi
movzbl	(%r9,%rax,4), %eax
testb	%al, %al
jne	L_3da
movq	%rdx, %rbx
movzbl	0x2(%rsi), %eax
movb	%al, (%r12)
movzbl	0x1(%rsi), %ecx
shrq	%cl, %r13
subl	%ecx, %ebp
movl	%r13d, %eax
andl	%ebx, %eax
leaq	(%r9,%rax,4), %rsi
movzbl	(%r9,%rax,4), %eax
testb	%al, %al
je	L_5ae
incq	%r12
L_3da:
movzbl	0x1(%rsi), %ecx
shrq	%cl, %r13
subl	%ecx, %ebp
movq	%r12, %rdi
movl	%eax, %ecx
L_3e8:
movq	0xa0(%rsp), %r12
L_3f0:
testb	$0x10, %cl
jne	L_460
testb	$0x40, %cl
jne	L_1342
movzwl	0x2(%rsi), %eax
movl	$0xffffffff, %edx
shll	%cl, %edx
leaq	(%r9,%rax,4), %rax
notl	%edx
andl	%r13d, %edx
movzbl	0x1(%rax,%rdx,4), %ecx
shrq	%cl, %r13
leaq	(%rax,%rdx,4), %rsi
subl	%ecx, %ebp
movzbl	(%rax,%rdx,4), %ecx
testb	%cl, %cl
jne	L_3f0
L_428:
movzbl	0x2(%rsi), %eax
movb	%al, (%rdi)
incq	%rdi
movq	%r13, %rbx
L_434:
movq	%rdi, %r12
L_437:
cmpq	%r11, %r8
jae	L_1387
cmpq	%r10, %r12
movq	0x98(%rsp), %r9
movq	0x90(%rsp), %rdx
jb	L_37e
jmp	L_1387
nop
L_460:
movzbl	%cl, %ecx
andl	$0xf, %ecx
movl	$0xffffffff, %eax
shll	%cl, %eax
movq	%r13, %rdx
shrq	%cl, %rdx
subl	%ecx, %ebp
cmpl	$0x1b, %ebp
ja	L_49b
movq	(%r8), %rbx
movl	%ebp, %ecx
shlq	%cl, %rbx
orq	%rdx, %rbx
movl	%ebp, %ecx
shrl	$0x3, %ecx
subq	%rcx, %r8
addq	$0x7, %r8
movq	%r8, 0x8(%rsp)
orl	$0x38, %ebp
jmp	L_4a3
L_49b:
movq	%r8, 0x8(%rsp)
movq	%rdx, %rbx
L_4a3:
andl	0x88(%rsp), %edx
leaq	(%r12,%rdx,4), %r8
movzbl	0x1(%r8), %ecx
shrq	%cl, %rbx
movzwl	0x2(%rsi), %edx
subl	%ecx, %ebp
movzbl	(%r8), %ecx
testb	$0x10, %cl
jne	L_50a
nopw	%cs:(%rax,%rax)
L_4d0:
testb	$0x40, %cl
jne	L_136c
movzwl	0x2(%r8), %esi
movl	$0xffffffff, %r9d
shll	%cl, %r9d
leaq	(%r12,%rsi,4), %rsi
notl	%r9d
andl	%ebx, %r9d
movzbl	0x1(%rsi,%r9,4), %ecx
shrq	%cl, %rbx
leaq	(%rsi,%r9,4), %r8
subl	%ecx, %ebp
movzbl	(%rsi,%r9,4), %ecx
testb	$0x10, %cl
je	L_4d0
L_50a:
notl	%eax
andl	%eax, %r13d
addq	%rdx, %r13
movzwl	0x2(%r8), %eax
andl	$0xf, %ecx
movl	$0xffffffff, %edx
shll	%cl, %edx
notl	%edx
andl	%ebx, %edx
addq	%rax, %rdx
shrq	%cl, %rbx
subl	%ecx, %ebp
movl	%edi, %ecx
subl	0x80(%rsp), %ecx
movq	%rdx, 0x38(%rsp)
movl	%edx, %eax
subl	%ecx, %eax
jbe	L_5f3
cmpl	0x6c(%rsp), %eax
movq	0x8(%rsp), %r8
ja	L_13d9
movl	0x44(%rsp), %ecx
testl	%ecx, %ecx
movq	%r14, 0x30(%rsp)
je	L_6d2
movl	%ecx, %esi
subl	%eax, %esi
jae	L_6d8
subl	%ecx, %eax
movl	0x40(%rsp), %esi
subl	%eax, %esi
movq	0x60(%rsp), %r12
addq	%r12, %rsi
movl	%r13d, %r14d
subl	%eax, %r14d
jbe	L_6dd
movl	%eax, %edx
movq	0x28(%rsp), %rcx
callq	CHUNKCOPY_SAFE
movq	0x10(%rsp), %r11
movq	%rax, %rdi
movl	%r14d, %r13d
movl	0x44(%rsp), %eax
movq	%r12, %rsi
jmp	L_6dd
L_5ae:
movzbl	0x2(%rsi), %eax
movb	%al, 0x1(%r12)
addq	$0x2, %r12
movzbl	0x1(%rsi), %eax
movl	%eax, %ecx
shrq	%cl, %r13
movl	%r13d, %ecx
andl	%ebx, %ecx
leaq	(%r9,%rcx,4), %rsi
movzbl	(%r9,%rcx,4), %edi
movzbl	0x1(%r9,%rcx,4), %edx
movl	%edx, %ecx
shrq	%cl, %r13
movl	%edi, %ecx
addl	%edx, %eax
subl	%eax, %ebp
movq	%r12, %rdi
testb	%cl, %cl
jne	L_3e8
jmp	L_428
L_5f3:
cmpb	$0x0, 0x24(%rsp)
movq	0x8(%rsp), %r8
je	L_660
movq	0x38(%rsp), %rcx
movq	%rcx, %rax
negq	%rax
movq	%rdi, %rsi
subq	%rcx, %rsi
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %r13
cmovbq	%r13, %rdx
movq	%rcx, %r13
testq	%rcx, %rcx
sete	%cl
leaq	(%rdi,%rdx), %r12
cmpq	%rax, %rdx
setg	%al
testb	%al, %cl
jne	L_7ac
leaq	(%rsi,%rdx), %rax
cmpq	%rax, %rdi
jb	L_7ac
callq	memcpy
movq	0x8(%rsp), %r8
movq	0x18(%rsp), %r10
movq	0x10(%rsp), %r11
jmp	L_437
L_660:
movq	%rbx, 0x48(%rsp)
movq	%rdi, %rbx
movq	0x38(%rsp), %rax
subq	%rax, %rbx
cmpl	%eax, %r13d
jbe	L_9ef
cmpl	$0x10, %eax
jae	L_9ef
decq	%rax
cmpq	$0x7, %rax
ja	L_122e
leaq	bums_jump_table_rodata_0(%rip), %rcx
movslq	(%rcx,%rax,4), %rax
addq	%rcx, %rax
jmpq	*%rax
L_69f:
movzbl	(%rbx), %esi
movq	%r14, %r12
movq	%rdi, %r14
movq	%r13, %rdx
callq	memset
movq	0x8(%rsp), %r8
movq	0x18(%rsp), %r10
movq	0x10(%rsp), %r11
movq	%r14, %rdi
movq	%r12, %r14
addq	%r13, %rdi
movq	0x48(%rsp), %rbx
jmp	L_434
L_6d2:
movl	0x40(%rsp), %esi
subl	%eax, %esi
L_6d8:
addq	0x60(%rsp), %rsi
L_6dd:
movl	%r13d, %r14d
subl	%eax, %r14d
jbe	L_748
movl	%eax, %eax
cmpb	$0x0, 0x24(%rsp)
je	L_a3a
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
movq	%rsi, %rcx
subq	%rdi, %rcx
setae	%r9b
leaq	(%rdi,%rdx), %r12
cmpq	%r12, %rsi
setb	%r10b
cmpq	%rsi, %rdi
setae	%al
leaq	(%rsi,%rdx), %r8
cmpq	%r8, %rdi
setb	%r8b
testb	%r10b, %r9b
movq	0x38(%rsp), %r13
jne	L_abe
andb	%r8b, %al
jne	L_abe
callq	memcpy
jmp	L_ad9
L_748:
movl	%r13d, %eax
cmpb	$0x0, 0x24(%rsp)
je	L_a9f
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
movq	%rsi, %rcx
subq	%rdi, %rcx
setae	%r9b
leaq	(%rdi,%rdx), %r12
cmpq	%r12, %rsi
setb	%r10b
cmpq	%rsi, %rdi
setae	%al
leaq	(%rsi,%rdx), %r8
cmpq	%r8, %rdi
setb	%r8b
testb	%r10b, %r9b
movq	0x30(%rsp), %r14
jne	L_f6f
andb	%r8b, %al
jne	L_f6f
callq	memcpy
jmp	L_11e1
L_7ac:
testq	%r13, %r13
je	L_437
testq	%rdx, %rdx
jne	L_7dc
jmp	L_434
nop
L_7c0:
movq	%rsi, %r8
movq	%r10, %rdi
L_7c6:
movq	%r8, %rsi
subq	%rax, %rdx
movq	0x18(%rsp), %r10
movq	0x8(%rsp), %r8
je	L_434
L_7dc:
cmpq	%rdx, %r13
movq	%rdx, %rax
cmovbq	%r13, %rax
cmpq	$0x10, %rax
jb	L_800
leaq	-0x10(%rax), %r8
movl	%r8d, %ecx
notl	%ecx
testb	$0x30, %cl
jne	L_810
movq	%rax, %rcx
jmp	L_845
nop
L_800:
movq	%rax, %rcx
jmp	L_882
nopw	%cs:(%rax,%rax)
L_810:
movl	%r8d, %r9d
shrl	$0x4, %r9d
incl	%r9d
andl	$0x3, %r9d
movl	%r9d, %r10d
shll	$0x4, %r10d
movq	%rax, %rcx
subq	%r10, %rcx
nopl	(%rax,%rax)
L_830:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r9
jne	L_830
L_845:
cmpq	$0x30, %r8
jb	L_882
nopl	(%rax,%rax)
L_850:
movups	(%rsi), %xmm0
movups	%xmm0, (%rdi)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%rdi)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%rdi)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %rcx
cmpq	$0xf, %rcx
ja	L_850
L_882:
cmpq	$0x8, %rcx
jb	L_89a
movq	(%rsi), %r8
movq	%r8, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %rcx
L_89a:
cmpq	$0x4, %rcx
jb	L_8b2
movl	(%rsi), %r8d
movl	%r8d, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %rcx
L_8b2:
movq	%rdi, %r10
testq	%rcx, %rcx
je	L_7c0
cmpq	$0x20, %rcx
jb	L_930
movq	%r10, %rdi
subq	%rsi, %rdi
cmpq	$0x20, %rdi
jb	L_930
movq	%r14, %r12
movq	%rcx, %r11
andq	$-0x20, %r11
movl	%ecx, %r9d
andl	$0x1f, %r9d
leaq	(%r10,%r11), %rdi
leaq	(%rsi,%r11), %r8
xorl	%r14d, %r14d
nopl	(%rax)
L_8f0:
movdqu	(%rsi,%r14), %xmm0
movups	0x10(%rsi,%r14), %xmm1
movdqu	%xmm0, (%r10,%r14)
movups	%xmm1, 0x10(%r10,%r14)
addq	$0x20, %r14
cmpq	%r14, %r11
jne	L_8f0
cmpq	%r11, %rcx
movq	%r12, %r14
movq	0x10(%rsp), %r11
je	L_7c6
jmp	L_939
nopw	%cs:(%rax,%rax)
L_930:
movq	%rcx, %r9
movq	%r10, %rdi
movq	%rsi, %r8
L_939:
movq	%r9, %rcx
andq	$0x7, %rcx
je	L_96f
xorl	%esi, %esi
nopw	%cs:(%rax,%rax)
L_950:
movzbl	(%r8,%rsi), %r10d
movb	%r10b, (%rdi,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_950
movq	%r9, %rcx
subq	%rsi, %rcx
addq	%rsi, %rdi
addq	%rsi, %r8
jmp	L_972
L_96f:
movq	%r9, %rcx
L_972:
movq	%rdi, %rsi
movq	%r8, %r10
decq	%r9
cmpq	$0x7, %r9
jb	L_7c6
nopw	%cs:(%rax,%rax)
L_990:
movzbl	(%r10), %edi
movb	%dil, (%rsi)
movzbl	0x1(%r10), %edi
movb	%dil, 0x1(%rsi)
movzbl	0x2(%r10), %edi
movb	%dil, 0x2(%rsi)
movzbl	0x3(%r10), %edi
movb	%dil, 0x3(%rsi)
movzbl	0x4(%r10), %edi
movb	%dil, 0x4(%rsi)
movzbl	0x5(%r10), %edi
movb	%dil, 0x5(%rsi)
movzbl	0x6(%r10), %edi
movb	%dil, 0x6(%rsi)
leaq	0x8(%r10), %r8
leaq	0x8(%rsi), %rdi
movzbl	0x7(%r10), %r9d
movb	%r9b, 0x7(%rsi)
movq	%rdi, %rsi
movq	%r8, %r10
addq	$-0x8, %rcx
jne	L_990
jmp	L_7c6
L_9ef:
leal	-0x1(%r13), %eax
andl	$0xf, %eax
movdqu	(%rbx), %xmm0
movdqu	%xmm0, (%rdi)
leaq	(%rax,%rdi), %r12
incq	%r12
notl	%eax
addl	%r13d, %eax
je	L_11f5
movq	0x38(%rsp), %rcx
negq	%rcx
movq	0x48(%rsp), %rbx
nopl	(%rax)
L_a20:
movdqu	(%r12,%rcx), %xmm0
movdqu	%xmm0, (%r12)
addq	$0x10, %r12
addl	$-0x10, %eax
jne	L_a20
jmp	L_437
L_a3a:
movq	%rax, %rdx
movq	0x28(%rsp), %rcx
callq	CHUNKCOPY_SAFE
movq	0x38(%rsp), %r8
cmpq	$0xf, %r8
ja	L_11af
cmpl	%r8d, %r14d
jbe	L_11af
movq	%r8, %rcx
negq	%rcx
movq	%rax, %rdi
nopl	(%rax,%rax)
L_a70:
movq	%rdi, %rdx
movl	%r8d, %esi
movdqu	(%rax,%rcx), %xmm0
movdqu	%xmm0, (%rdi)
movl	%r8d, %edi
addq	%rdx, %rdi
subl	%r8d, %r14d
leal	(%rsi,%rsi), %r8d
cmpl	$0x7, %esi
ja	L_11b2
cmpl	%r14d, %r8d
jb	L_a70
jmp	L_11b2
L_a9f:
movq	%rax, %rdx
movq	0x28(%rsp), %rcx
callq	CHUNKCOPY_SAFE
movq	0x10(%rsp), %r11
movq	%rax, %r12
movq	0x30(%rsp), %r14
jmp	L_11e6
L_abe:
cmpq	%rsi, %rdi
je	L_ad9
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
movq	%rdi, %r12
testq	%rdx, %rdx
jne	L_d64
L_ad9:
movq	%r12, %rsi
subq	%r13, %rsi
movl	%r14d, %eax
movq	0x28(%rsp), %rdx
subq	%r12, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
leaq	(%rsi,%rdx), %rax
cmpq	%rax, %r12
jae	L_11cd
testq	%rdx, %rdx
movq	0x30(%rsp), %r14
movq	0x10(%rsp), %r11
movq	0x18(%rsp), %r10
jmp	L_b2c
nopw	%cs:(%rax,%rax)
L_b20:
movq	%rsi, %rdi
movq	%r9, %r12
L_b26:
movq	%rdi, %rsi
subq	%rax, %rdx
L_b2c:
movq	0x8(%rsp), %r8
je	L_437
cmpq	%rdx, %r13
movq	%rdx, %rax
cmovbq	%r13, %rax
cmpq	$0x10, %rax
jb	L_b60
leaq	-0x10(%rax), %rdi
movl	%edi, %ecx
notl	%ecx
testb	$0x30, %cl
jne	L_b65
movq	%rax, %rcx
jmp	L_b97
nopl	(%rax)
L_b60:
movq	%rax, %rcx
jmp	L_bda
L_b65:
movl	%edi, %r8d
shrl	$0x4, %r8d
incl	%r8d
andl	$0x3, %r8d
movl	%r8d, %r9d
shll	$0x4, %r9d
movq	%rax, %rcx
subq	%r9, %rcx
L_b80:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r12)
addq	$0x10, %r12
addq	$0x10, %rsi
decq	%r8
jne	L_b80
L_b97:
cmpq	$0x30, %rdi
jb	L_bda
nopl	(%rax)
L_ba0:
movups	(%rsi), %xmm0
movups	%xmm0, (%r12)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%r12)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%r12)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%r12)
addq	$0x40, %r12
addq	$0x40, %rsi
addq	$-0x40, %rcx
cmpq	$0xf, %rcx
ja	L_ba0
L_bda:
cmpq	$0x8, %rcx
jb	L_bf3
movq	(%rsi), %rdi
movq	%rdi, (%r12)
addq	$0x8, %r12
addq	$0x8, %rsi
addq	$-0x8, %rcx
L_bf3:
cmpq	$0x4, %rcx
jb	L_c0b
movl	(%rsi), %edi
movl	%edi, (%r12)
addq	$0x4, %r12
addq	$0x4, %rsi
addq	$-0x4, %rcx
L_c0b:
movq	%r12, %r9
testq	%rcx, %rcx
je	L_b20
cmpq	$0x20, %rcx
jb	L_c90
movq	%r9, %rdi
subq	%rsi, %rdi
cmpq	$0x20, %rdi
jb	L_c90
movq	%rcx, %r10
andq	$-0x20, %r10
movl	%ecx, %r8d
andl	$0x1f, %r8d
leaq	(%r9,%r10), %r12
leaq	(%rsi,%r10), %rdi
xorl	%r11d, %r11d
nopw	%cs:(%rax,%rax)
L_c50:
movdqu	(%rsi,%r11), %xmm0
movups	0x10(%rsi,%r11), %xmm1
movdqu	%xmm0, (%r9,%r11)
movups	%xmm1, 0x10(%r9,%r11)
addq	$0x20, %r11
cmpq	%r11, %r10
jne	L_c50
cmpq	%r10, %rcx
movq	0x10(%rsp), %r11
movq	0x18(%rsp), %r10
je	L_b26
jmp	L_c99
nopw	%cs:(%rax,%rax)
L_c90:
movq	%rcx, %r8
movq	%r9, %r12
movq	%rsi, %rdi
L_c99:
movq	%r8, %rcx
andq	$0x7, %rcx
je	L_ccf
xorl	%esi, %esi
nopw	%cs:(%rax,%rax)
L_cb0:
movzbl	(%rdi,%rsi), %r9d
movb	%r9b, (%r12,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_cb0
movq	%r8, %rcx
subq	%rsi, %rcx
addq	%rsi, %r12
addq	%rsi, %rdi
jmp	L_cd2
L_ccf:
movq	%r8, %rcx
L_cd2:
movq	%r12, %rsi
movq	%rdi, %r9
decq	%r8
cmpq	$0x7, %r8
jb	L_b26
nopw	%cs:(%rax,%rax)
L_cf0:
movzbl	(%r9), %edi
movb	%dil, (%rsi)
movzbl	0x1(%r9), %edi
movb	%dil, 0x1(%rsi)
movzbl	0x2(%r9), %edi
movb	%dil, 0x2(%rsi)
movzbl	0x3(%r9), %edi
movb	%dil, 0x3(%rsi)
movzbl	0x4(%r9), %edi
movb	%dil, 0x4(%rsi)
movzbl	0x5(%r9), %edi
movb	%dil, 0x5(%rsi)
movzbl	0x6(%r9), %edi
movb	%dil, 0x6(%rsi)
leaq	0x8(%r9), %rdi
leaq	0x8(%rsi), %r12
movzbl	0x7(%r9), %r8d
movb	%r8b, 0x7(%rsi)
movq	%r12, %rsi
movq	%rdi, %r9
addq	$-0x8, %rcx
jne	L_cf0
jmp	L_b26
L_d4f:
movq	%rsi, %r9
movq	%rdi, %r12
L_d55:
movq	%r12, %rdi
movq	%r9, %rsi
subq	%rcx, %rdx
je	L_ad9
L_d64:
cmpq	%rdx, %rax
movq	%rdx, %rcx
cmovbq	%rax, %rcx
cmpq	$0x10, %rcx
jb	L_d90
leaq	-0x10(%rcx), %r9
movl	%r9d, %r8d
notl	%r8d
testb	$0x30, %r8b
jne	L_d95
movq	%rcx, %r8
jmp	L_dc5
nopl	(%rax)
L_d90:
movq	%rcx, %r8
jmp	L_e02
L_d95:
movl	%r9d, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x3, %r10d
movl	%r10d, %r11d
shll	$0x4, %r11d
movq	%rcx, %r8
subq	%r11, %r8
L_db0:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r10
jne	L_db0
L_dc5:
cmpq	$0x30, %r9
jb	L_e02
nopl	(%rax,%rax)
L_dd0:
movups	(%rsi), %xmm0
movups	%xmm0, (%rdi)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%rdi)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%rdi)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %r8
cmpq	$0xf, %r8
ja	L_dd0
L_e02:
cmpq	$0x8, %r8
jb	L_e30
movq	(%rsi), %r9
movq	%r9, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %r8
cmpq	$0x4, %r8
jae	L_e36
L_e20:
testq	%r8, %r8
jne	L_e51
jmp	L_d4f
nopw	(%rax,%rax)
L_e30:
cmpq	$0x4, %r8
jb	L_e20
L_e36:
movl	(%rsi), %r9d
movl	%r9d, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %r8
testq	%r8, %r8
je	L_d4f
L_e51:
cmpq	$0x20, %r8
jb	L_eb4
movq	%rdi, %r9
subq	%rsi, %r9
cmpq	$0x20, %r9
jb	L_eb4
movq	%r15, %r13
movq	%r8, %r11
andq	$-0x20, %r11
movl	%r8d, %r10d
andl	$0x1f, %r10d
leaq	(%rdi,%r11), %r12
leaq	(%rsi,%r11), %r9
xorl	%r15d, %r15d
nop
L_e80:
movdqu	(%rsi,%r15), %xmm0
movups	0x10(%rsi,%r15), %xmm1
movdqu	%xmm0, (%rdi,%r15)
movups	%xmm1, 0x10(%rdi,%r15)
addq	$0x20, %r15
cmpq	%r15, %r11
jne	L_e80
cmpq	%r11, %r8
movq	%r13, %r15
movq	0x38(%rsp), %r13
je	L_d55
jmp	L_ebd
L_eb4:
movq	%r8, %r10
movq	%rdi, %r12
movq	%rsi, %r9
L_ebd:
movq	%r10, %rsi
andq	$0x7, %rsi
je	L_eef
xorl	%edi, %edi
nopl	(%rax,%rax)
L_ed0:
movzbl	(%r9,%rdi), %r8d
movb	%r8b, (%r12,%rdi)
incq	%rdi
cmpq	%rdi, %rsi
jne	L_ed0
movq	%r10, %rsi
subq	%rdi, %rsi
addq	%rdi, %r12
addq	%rdi, %r9
jmp	L_ef2
L_eef:
movq	%r10, %rsi
L_ef2:
movq	%r12, %rdi
movq	%r9, %r8
decq	%r10
cmpq	$0x7, %r10
jb	L_d55
nopw	%cs:(%rax,%rax)
L_f10:
movzbl	(%r8), %r9d
movb	%r9b, (%rdi)
movzbl	0x1(%r8), %r9d
movb	%r9b, 0x1(%rdi)
movzbl	0x2(%r8), %r9d
movb	%r9b, 0x2(%rdi)
movzbl	0x3(%r8), %r9d
movb	%r9b, 0x3(%rdi)
movzbl	0x4(%r8), %r9d
movb	%r9b, 0x4(%rdi)
movzbl	0x5(%r8), %r9d
movb	%r9b, 0x5(%rdi)
movzbl	0x6(%r8), %r9d
movb	%r9b, 0x6(%rdi)
leaq	0x8(%r8), %r9
leaq	0x8(%rdi), %r12
movzbl	0x7(%r8), %r8d
movb	%r8b, 0x7(%rdi)
movq	%r12, %rdi
movq	%r9, %r8
addq	$-0x8, %rsi
jne	L_f10
jmp	L_d55
L_f6f:
cmpq	%rsi, %rdi
movq	0x18(%rsp), %r10
je	L_1338
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
testq	%rdx, %rdx
jne	L_fb1
L_f8c:
movq	%rdi, %r12
movq	0x8(%rsp), %r8
jmp	L_437
L_f99:
movq	%rsi, %r9
movq	%r11, %rdi
L_f9f:
movq	%r9, %rsi
subq	%rcx, %rdx
movq	0x10(%rsp), %r11
movq	0x18(%rsp), %r10
je	L_f8c
L_fb1:
cmpq	%rdx, %rax
movq	%rdx, %rcx
cmovbq	%rax, %rcx
cmpq	$0x10, %rcx
jb	L_fe0
leaq	-0x10(%rcx), %r9
movl	%r9d, %r8d
notl	%r8d
testb	$0x30, %r8b
jne	L_fe5
movq	%rcx, %r8
jmp	L_1015
nopw	%cs:(%rax,%rax)
L_fe0:
movq	%rcx, %r8
jmp	L_1052
L_fe5:
movl	%r9d, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x3, %r10d
movl	%r10d, %r11d
shll	$0x4, %r11d
movq	%rcx, %r8
subq	%r11, %r8
L_1000:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r10
jne	L_1000
L_1015:
cmpq	$0x30, %r9
jb	L_1052
nopl	(%rax,%rax)
L_1020:
movups	(%rsi), %xmm0
movups	%xmm0, (%rdi)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%rdi)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%rdi)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %r8
cmpq	$0xf, %r8
ja	L_1020
L_1052:
cmpq	$0x8, %r8
jb	L_106a
movq	(%rsi), %r9
movq	%r9, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %r8
L_106a:
cmpq	$0x4, %r8
jb	L_1082
movl	(%rsi), %r9d
movl	%r9d, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %r8
L_1082:
movq	%rdi, %r11
testq	%r8, %r8
je	L_f99
cmpq	$0x20, %r8
jb	L_10f2
movq	%r11, %rdi
subq	%rsi, %rdi
cmpq	$0x20, %rdi
jb	L_10f2
movq	%r14, %r13
movq	%r15, %r12
movq	%r8, %r14
andq	$-0x20, %r14
movl	%r8d, %r10d
andl	$0x1f, %r10d
leaq	(%r11,%r14), %rdi
leaq	(%rsi,%r14), %r9
xorl	%r15d, %r15d
nop
L_10c0:
movdqu	(%rsi,%r15), %xmm0
movups	0x10(%rsi,%r15), %xmm1
movdqu	%xmm0, (%r11,%r15)
movups	%xmm1, 0x10(%r11,%r15)
addq	$0x20, %r15
cmpq	%r15, %r14
jne	L_10c0
cmpq	%r14, %r8
movq	%r12, %r15
movq	%r13, %r14
je	L_f9f
jmp	L_10fb
L_10f2:
movq	%r8, %r10
movq	%r11, %rdi
movq	%rsi, %r9
L_10fb:
movq	%r10, %rsi
andq	$0x7, %rsi
je	L_112f
xorl	%r8d, %r8d
nopw	(%rax,%rax)
L_1110:
movzbl	(%r9,%r8), %r11d
movb	%r11b, (%rdi,%r8)
incq	%r8
cmpq	%r8, %rsi
jne	L_1110
movq	%r10, %rsi
subq	%r8, %rsi
addq	%r8, %rdi
addq	%r8, %r9
jmp	L_1132
L_112f:
movq	%r10, %rsi
L_1132:
movq	%rdi, %r8
movq	%r9, %r11
decq	%r10
cmpq	$0x7, %r10
jb	L_f9f
nopw	%cs:(%rax,%rax)
L_1150:
movzbl	(%r11), %edi
movb	%dil, (%r8)
movzbl	0x1(%r11), %edi
movb	%dil, 0x1(%r8)
movzbl	0x2(%r11), %edi
movb	%dil, 0x2(%r8)
movzbl	0x3(%r11), %edi
movb	%dil, 0x3(%r8)
movzbl	0x4(%r11), %edi
movb	%dil, 0x4(%r8)
movzbl	0x5(%r11), %edi
movb	%dil, 0x5(%r8)
movzbl	0x6(%r11), %edi
movb	%dil, 0x6(%r8)
leaq	0x8(%r11), %r9
leaq	0x8(%r8), %rdi
movzbl	0x7(%r11), %r10d
movb	%r10b, 0x7(%r8)
movq	%rdi, %r8
movq	%r9, %r11
addq	$-0x8, %rsi
jne	L_1150
jmp	L_f9f
L_11af:
movq	%rax, %rdi
L_11b2:
movl	%r8d, %eax
movq	%rdi, %rsi
subq	%rax, %rsi
movl	%r14d, %edx
movq	0x28(%rsp), %rcx
callq	CHUNKCOPY_SAFE
movq	%rax, %r12
jmp	L_11dc
L_11cd:
leaq	(%r12,%rdx), %r14
movq	%r12, %rdi
callq	memcpy
movq	%r14, %r12
L_11dc:
movq	0x30(%rsp), %r14
L_11e1:
movq	0x10(%rsp), %r11
L_11e6:
movq	0x18(%rsp), %r10
movq	0x8(%rsp), %r8
jmp	L_437
L_11f5:
movq	0x48(%rsp), %rbx
jmp	L_437
L_11ff:
movd	(%rbx), %xmm0
jmp	L_1211
L_1205:
movzwl	(%rbx), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
L_1211:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_1221
L_1218:
movq	(%rbx), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_1221:
movdqa	%xmm0, 0x50(%rsp)
movl	$0x10, %eax
jmp	L_12a4
L_122e:
movq	%r14, 0x30(%rsp)
movq	%r15, 0x70(%rsp)
movq	%rdi, 0x78(%rsp)
movl	$0x10, %r12d
leaq	0x50(%rsp), %r15
nopl	(%rax,%rax)
L_1250:
movq	0x38(%rsp), %r14
cmpq	%r14, %r12
cmovbq	%r12, %r14
movq	%r15, %rdi
movq	%rbx, %rsi
movq	%r14, %rdx
callq	memcpy
addq	%r14, %r15
subq	%r14, %r12
jne	L_1250
movdqa	0x50(%rsp), %xmm0
movdqa	%xmm0, 0x50(%rsp)
movl	$0x10, %eax
subl	%r14d, %eax
movq	0x78(%rsp), %rdi
movq	0x70(%rsp), %r15
movq	0x30(%rsp), %r14
movq	0x10(%rsp), %r11
movq	0x18(%rsp), %r10
movq	0x8(%rsp), %r8
L_12a4:
movl	%eax, %ecx
cmpl	$0x20, %r13d
movq	0x48(%rsp), %rbx
jb	L_12d5
leal	(%rax,%rax), %edx
nopw	%cs:(%rax,%rax)
L_12c0:
movdqu	%xmm0, (%rdi)
movdqu	%xmm0, (%rdi,%rcx)
addq	%rdx, %rdi
subl	%edx, %r13d
cmpl	$0x1f, %r13d
ja	L_12c0
L_12d5:
cmpl	$0x10, %r13d
jb	L_12f6
nopl	(%rax,%rax)
L_12e0:
movdqa	0x50(%rsp), %xmm0
movdqu	%xmm0, (%rdi)
subl	%eax, %r13d
addq	%rcx, %rdi
cmpl	$0xf, %r13d
ja	L_12e0
L_12f6:
testl	%r13d, %r13d
je	L_434
movq	%r15, %r12
movl	%r13d, %r15d
movq	%r14, %r13
movq	%rdi, %r14
leaq	0x50(%rsp), %rsi
movq	%r15, %rdx
callq	memcpy
movq	0x8(%rsp), %r8
movq	0x18(%rsp), %r10
movq	0x10(%rsp), %r11
movq	%r14, %rdi
movq	%r13, %r14
addq	%r15, %rdi
movq	%r12, %r15
jmp	L_434
L_1338:
movq	0x8(%rsp), %r8
jmp	L_437
L_1342:
testb	$0x20, %cl
jne	L_135c
movl	$0x3f51, 0x8(%r15)
leaq	.L.str.2(%rip), %rax
movq	%rax, 0x30(%r14)
jmp	L_1364
L_135c:
movl	$0x3f3f, 0x8(%r15)
L_1364:
movq	%r13, %rbx
movq	%rdi, %r12
jmp	L_1387
L_136c:
movl	$0x3f51, 0x8(%r15)
leaq	.L.str.1(%rip), %rax
movq	%rax, 0x30(%r14)
movq	%rdi, %r12
movq	0x8(%rsp), %r8
L_1387:
movl	%ebp, %eax
shrl	$0x3, %eax
subq	%rax, %r8
movq	%r8, (%r14)
movq	%r12, 0x18(%r14)
subl	%r8d, %r11d
addl	$0xe, %r11d
andl	$0x7, %ebp
movl	$0xffffffff, %eax
movl	%ebp, %ecx
shll	%cl, %eax
movl	%r11d, 0x8(%r14)
subl	%r12d, %r10d
notl	%eax
andl	%eax, %ebx
addl	$0x103, %r10d
movl	%r10d, 0x20(%r14)
movq	%rbx, 0x58(%r15)
movl	%ebp, 0x60(%r15)
addq	$0xa8, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
L_13d9:
movl	$0x3f51, 0x8(%r15)
leaq	.L.str(%rip), %rax
movq	%rax, 0x30(%r14)
movq	%rdi, %r12
jmp	L_1387
nopw	%cs:(%rax,%rax)
CHUNKCOPY_SAFE:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x18, %rsp
movq	%rdi, %rbx
movq	%rdi, %rax
subq	%rsi, %rax
je	L_147a
movq	%rsi, %r14
movq	%rcx, %rdi
subq	%rbx, %rdi
cmpq	%rdi, %rdx
cmovaeq	%rdi, %rdx
subq	%rsi, %rcx
movq	%rcx, %rsi
negq	%rsi
cmovsq	%rcx, %rsi
cmpq	$0x10, %rdi
jb	L_15ed
cmpq	$0xf, %rsi
jbe	L_15ed
movq	%rax, %r13
negq	%r13
cmovsq	%rax, %r13
testq	%rax, %rax
sets	%al
cmpq	%rdx, %r13
setb	%cl
andb	%al, %cl
cmpb	$0x1, %cl
jne	L_1482
movq	%rbx, %rdi
movq	%r14, %rsi
movq	%rdx, %r14
callq	memmove
jmp	L_15d8
L_147a:
addq	%rdx, %rbx
jmp	L_15db
L_1482:
cmpq	$0x1, %r13
jne	L_149c
movzbl	(%r14), %esi
movq	%rbx, %rdi
movq	%rdx, %r14
callq	memset
jmp	L_15d8
L_149c:
cmpq	$0x10, %r13
jb	L_14db
leal	-0x1(%rdx), %eax
andl	$0xf, %eax
movdqu	(%r14), %xmm0
movdqu	%xmm0, (%rbx)
movl	%eax, %ecx
notl	%ecx
addl	%edx, %ecx
je	L_14fc
incq	%rax
nopl	(%rax)
L_14c0:
movdqu	(%r14,%rax), %xmm0
movdqu	%xmm0, (%rbx,%rax)
addq	$0x10, %rax
cmpl	%eax, %edx
jne	L_14c0
addq	%rax, %rbx
jmp	L_15db
L_14db:
cmpq	$0x8, %r13
je	L_1513
cmpq	$0x4, %r13
je	L_1507
cmpq	$0x2, %r13
jne	L_152f
movzwl	(%r14), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_150c
L_14fc:
addq	%rax, %rbx
incq	%rbx
jmp	L_15db
L_1507:
movd	(%r14), %xmm0
L_150c:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_151d
L_1513:
movq	(%r14), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_151d:
movdqa	%xmm0, (%rsp)
movl	$0x10, %eax
cmpq	$0x20, %rdx
jae	L_157d
jmp	L_15a3
L_152f:
movq	%rdx, 0x10(%rsp)
movl	$0x10, %ebp
movq	%rsp, %r15
nopl	(%rax)
L_1540:
cmpq	%r13, %rbp
movq	%r13, %r12
cmovbq	%rbp, %r12
movq	%r15, %rdi
movq	%r14, %rsi
movq	%r12, %rdx
callq	memcpy
addq	%r12, %r15
subq	%r12, %rbp
jne	L_1540
movdqa	(%rsp), %xmm0
movdqa	%xmm0, (%rsp)
movl	$0x10, %eax
subl	%r12d, %eax
movq	0x10(%rsp), %rdx
cmpq	$0x20, %rdx
jb	L_15a3
L_157d:
movl	%eax, %ecx
leal	(%rax,%rax), %esi
nopw	%cs:(%rax,%rax)
L_1590:
movdqu	%xmm0, (%rbx)
movdqu	%xmm0, (%rbx,%rcx)
addq	%rsi, %rbx
subl	%esi, %edx
cmpl	$0x1f, %edx
ja	L_1590
L_15a3:
cmpl	$0x10, %edx
jb	L_15c3
movl	%eax, %ecx
nopw	(%rax,%rax)
L_15b0:
movdqa	(%rsp), %xmm0
movdqu	%xmm0, (%rbx)
subl	%eax, %edx
addq	%rcx, %rbx
cmpl	$0xf, %edx
ja	L_15b0
L_15c3:
testl	%edx, %edx
je	L_15db
movl	%edx, %r14d
movq	%rsp, %rsi
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memcpy
L_15d8:
addq	%r14, %rbx
L_15db:
movq	%rbx, %rax
L_15de:
addq	$0x18, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
L_15ed:
testq	%rdx, %rdx
je	L_15db
cmpq	$0x20, %rdx
setb	%cl
cmpq	$0x20, %rax
setb	%al
orb	%cl, %al
je	L_160f
movq	%rbx, %rax
movq	%r14, %rcx
movq	%rdx, %rsi
jmp	L_164a
L_160f:
movl	%edx, %edi
andl	$-0x20, %edi
leaq	(%rbx,%rdi), %rax
leaq	(%r14,%rdi), %rcx
movl	%edx, %esi
andl	$0x1f, %esi
xorl	%r8d, %r8d
L_1624:
movdqu	(%r14,%r8), %xmm0
movups	0x10(%r14,%r8), %xmm1
movdqu	%xmm0, (%rbx,%r8)
movups	%xmm1, 0x10(%rbx,%r8)
addq	$0x20, %r8
cmpq	%r8, %rdi
jne	L_1624
cmpq	%rdi, %rdx
je	L_15de
L_164a:
leaq	-0x1(%rsi), %rdx
movq	%rsi, %r8
andq	$0x7, %r8
je	L_1673
xorl	%edi, %edi
L_1659:
movzbl	(%rcx,%rdi), %r9d
movb	%r9b, (%rax,%rdi)
incq	%rdi
cmpq	%rdi, %r8
jne	L_1659
addq	%rdi, %rax
addq	%rdi, %rcx
subq	%rdi, %rsi
L_1673:
cmpq	$0x7, %rdx
jb	L_15de
xorl	%edx, %edx
L_167f:
movzbl	(%rcx,%rdx), %edi
movb	%dil, (%rax,%rdx)
movzbl	0x1(%rcx,%rdx), %edi
movb	%dil, 0x1(%rax,%rdx)
movzbl	0x2(%rcx,%rdx), %edi
movb	%dil, 0x2(%rax,%rdx)
movzbl	0x3(%rcx,%rdx), %edi
movb	%dil, 0x3(%rax,%rdx)
movzbl	0x4(%rcx,%rdx), %edi
movb	%dil, 0x4(%rax,%rdx)
movzbl	0x5(%rcx,%rdx), %edi
movb	%dil, 0x5(%rax,%rdx)
movzbl	0x6(%rcx,%rdx), %edi
movb	%dil, 0x6(%rax,%rdx)
movzbl	0x7(%rcx,%rdx), %edi
movb	%dil, 0x7(%rax,%rdx)
addq	$0x8, %rdx
cmpq	%rdx, %rsi
jne	L_167f
addq	%rdx, %rax
jmp	L_15de
	.section .rodata
bums_jump_table_rodata_0:
	.size bums_jump_table_rodata_0, 32
	.long L_69f - bums_jump_table_rodata_0
	.long L_1205 - bums_jump_table_rodata_0
	.long L_122e - bums_jump_table_rodata_0
	.long L_11ff - bums_jump_table_rodata_0
	.long L_122e - bums_jump_table_rodata_0
	.long L_122e - bums_jump_table_rodata_0
	.long L_122e - bums_jump_table_rodata_0
	.long L_1218 - bums_jump_table_rodata_0
	.section .rodata.str1.1
.L.str:
	.size .L.str, 30
	.byte 105,110,118,97,108,105,100,32,100,105,115,116,97,110,99,101
	.byte 32,116,111,111,32,102,97,114,32,98,97,99,107,0
.L.str.1:
	.size .L.str.1, 22
	.byte 105,110,118,97,108,105,100,32,100,105,115,116,97,110,99,101
	.byte 32,99,111,100,101,0
.L.str.2:
	.size .L.str.2, 28
	.byte 105,110,118,97,108,105,100,32,108,105,116,101,114,97,108,47
	.byte 108,101,110,103,116,104,32,99,111,100,101,0
# ---- reference memcpy: copies (%rsi)[0..%rdx) to (%rdi)[0..%rdx)
	.text
memcpy:
movq	%rdi, %rax
testq	%rdx, %rdx
je	memcpy_done
memcpy_loop:
movb	(%rsi), %cl
movb	%cl, (%rdi)
incq	%rsi
incq	%rdi
decq	%rdx
jne	memcpy_loop
memcpy_done:
retq
# ---- reference memmove: reads (%rsi)[0..%rdx) and writes (%rdi)[0..%rdx), the bytes memcpy touches
	.text
memmove:
movq	%rdi, %rax
testq	%rdx, %rdx
je	memmove_done
memmove_loop:
movb	(%rsi), %cl
movb	%cl, (%rdi)
incq	%rsi
incq	%rdi
decq	%rdx
jne	memmove_loop
memmove_done:
retq
# ---- reference memset: stores %sil to (%rdi)[0..%rdx)
	.text
memset:
movq	%rdi, %rax
testq	%rdx, %rdx
je	memset_done
memset_loop:
movb	%sil, (%rdi)
incq	%rdi
decq	%rdx
jne	memset_loop
memset_done:
retq

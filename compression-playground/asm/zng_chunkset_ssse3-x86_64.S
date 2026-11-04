	.text
chunkmemset_safe_ssse3:
pushq	%r14
pushq	%rbx
subq	$0x18, %rsp
movq	%rdi, %rbx
cmpl	%ecx, %edx
movl	%ecx, %eax
cmovbl	%edx, %eax
cmpl	$0xf, %ecx
jbe	L_1a6
testl	%edx, %edx
je	L_19b
movq	%rbx, %r8
subq	%rsi, %r8
movq	%r8, %rdi
negq	%rdi
cmovsq	%r8, %rdi
testq	%r8, %r8
jns	L_4f
movl	%eax, %r14d
cmpq	%r14, %rdi
jae	L_4f
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memmove
jmp	L_198
L_4f:
cmpq	$0x1, %rdi
jne	L_6b
movl	%eax, %r14d
movzbl	(%rsi), %esi
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memset
jmp	L_198
L_6b:
cmpq	$0x10, %rdi
jb	L_ba
leal	-0x1(%rax), %edi
andl	$0xf, %edi
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%rbx)
movl	%edi, %r8d
notl	%r8d
addl	%eax, %r8d
je	L_da
leaq	0x1(%rdi), %rax
movl	%ecx, %edi
movl	%edx, %ecx
cmpq	%rcx, %rdi
cmovbq	%rdi, %rcx
nopl	(%rax)
L_a0:
movdqu	(%rsi,%rax), %xmm0
movdqu	%xmm0, (%rbx,%rax)
addq	$0x10, %rax
cmpl	%eax, %ecx
jne	L_a0
L_b2:
addq	%rax, %rbx
jmp	L_19b
L_ba:
cmpq	$0x8, %rdi
je	L_f0
cmpq	$0x4, %rdi
je	L_e5
cmpq	$0x2, %rdi
jne	L_10a
movzwl	(%rsi), %ecx
movd	%ecx, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_e9
L_da:
addq	%rdi, %rbx
incq	%rbx
jmp	L_19b
L_e5:
movd	(%rsi), %xmm0
L_e9:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_f9
L_f0:
movq	(%rsi), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_f9:
movdqa	%xmm0, (%rsp)
movl	$0x10, %ecx
cmpl	$0x20, %eax
jae	L_13f
jmp	L_163
L_10a:
addl	$-0x3, %edi
leaq	perm_idx_lut(%rip), %rcx
movzwl	(%rcx,%rdi,4), %edx
movdqu	(%rsi), %xmm0
leaq	permute_table(%rip), %rsi
pshufb	(%rdx,%rsi), %xmm0
movzwl	0x2(%rcx,%rdi,4), %edx
movdqa	%xmm0, (%rsp)
movl	$0x10, %ecx
subl	%edx, %ecx
cmpl	$0x20, %eax
jb	L_163
L_13f:
movl	%ecx, %edx
leal	(%rcx,%rcx), %esi
nopw	%cs:(%rax,%rax)
L_150:
movdqu	%xmm0, (%rbx)
movdqu	%xmm0, (%rbx,%rdx)
addq	%rsi, %rbx
subl	%esi, %eax
cmpl	$0x1f, %eax
ja	L_150
L_163:
cmpl	$0x10, %eax
jb	L_183
movl	%ecx, %edx
nopw	(%rax,%rax)
L_170:
movdqa	(%rsp), %xmm0
movdqu	%xmm0, (%rbx)
subl	%ecx, %eax
addq	%rdx, %rbx
cmpl	$0xf, %eax
ja	L_170
L_183:
testl	%eax, %eax
je	L_19b
movl	%eax, %r14d
movq	%rsp, %rsi
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memcpy
L_198:
addq	%r14, %rbx
L_19b:
movq	%rbx, %rax
addq	$0x18, %rsp
popq	%rbx
popq	%r14
retq
L_1a6:
testl	%eax, %eax
je	L_19b
testb	$0x7, %al
je	L_1de
movl	%eax, %r8d
andl	$0x7, %r8d
xorl	%edi, %edi
L_1b7:
movzbl	(%rsi,%rdi), %r9d
movb	%r9b, (%rbx,%rdi)
incq	%rdi
cmpl	%edi, %r8d
jne	L_1b7
movl	%ecx, %r8d
movl	%edx, %ecx
cmpq	%rcx, %r8
cmovbq	%r8, %rcx
subl	%edi, %ecx
addq	%rdi, %rsi
addq	%rdi, %rbx
jmp	L_1e0
L_1de:
movl	%eax, %ecx
L_1e0:
cmpl	$0x8, %eax
jb	L_19b
movl	%ecx, %ecx
xorl	%eax, %eax
L_1e9:
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
jne	L_1e9
jmp	L_b2
nopl	(%rax)
inflate_fast_ssse3:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x98, %rsp
movq	0x38(%rdi), %r11
movq	(%rdi), %r10
movl	0x8(%rdi), %r8d
addl	$-0xe, %r8d
movq	0x18(%rdi), %r12
movl	0x20(%rdi), %ebx
subl	%ebx, %esi
movq	%r12, %rax
subq	%rsi, %rax
movq	%rax, 0x80(%rsp)
leal	-0x103(%rbx), %r9d
movl	0x40(%r11), %esi
movzbl	0x64(%r11), %ecx
movl	$0xffffffff, %eax
movl	$0xffffffff, %edx
shll	%cl, %edx
movzbl	0x78(%r11), %ecx
shll	%cl, %eax
movq	0x50(%r11), %r14
notl	%edx
notl	%eax
movl	%esi, 0x60(%rsp)
testl	%esi, %esi
sete	%cl
cmpq	%r14, %r12
setb	%sil
orb	%cl, %sil
je	L_2c1
movl	$0x0, 0x44(%rsp)
jmp	L_2da
L_2c1:
leaq	0x104(%r12), %rcx
movl	0x44(%r11), %esi
addq	%r14, %rsi
cmpq	%rsi, %rcx
setbe	%cl
movl	%ecx, 0x44(%rsp)
L_2da:
movq	%r14, %rcx
addq	%r10, %r8
movq	%r8, 0x70(%rsp)
addq	%r12, %r9
movq	%r9, 0x68(%rsp)
addq	%r12, %rbx
movq	%rbx, 0x50(%rsp)
movl	0x48(%r11), %esi
movl	%esi, 0x64(%rsp)
movl	0x4c(%r11), %esi
movl	%esi, 0x18(%rsp)
movq	0x58(%r11), %r14
movl	0x60(%r11), %ebx
movq	0x68(%r11), %rbp
movq	0x70(%r11), %rsi
movq	%rsi, 0x90(%rsp)
movl	%edx, %r15d
movl	%eax, %eax
movq	%rax, 0x88(%rsp)
movq	%rcx, 0x38(%rsp)
leaq	0x10(%rcx), %rax
movq	%rax, 0x78(%rsp)
movq	%r11, 0x8(%rsp)
movq	%r15, 0x10(%rsp)
L_342:
movq	(%r10), %r13
movl	%ebx, %ecx
shlq	%cl, %r13
orq	%r14, %r13
movl	%ebx, %eax
shrl	$0x3, %eax
andl	$0x7, %eax
subq	%rax, %r10
addq	$0x7, %r10
orl	$0x38, %ebx
movl	%r13d, %eax
andl	%r15d, %eax
leaq	(,%rax,4), %rsi
addq	%rbp, %rsi
movzbl	(%rbp,%rax,4), %eax
testb	%al, %al
jne	L_3ab
movzbl	0x2(%rsi), %eax
movb	%al, (%r12)
movzbl	0x1(%rsi), %ecx
shrq	%cl, %r13
subl	%ecx, %ebx
movl	%r13d, %eax
andl	%r15d, %eax
leaq	(,%rax,4), %rsi
addq	%rbp, %rsi
movzbl	(%rbp,%rax,4), %eax
testb	%al, %al
je	L_5ce
incq	%r12
L_3ab:
movzbl	0x1(%rsi), %ecx
shrq	%cl, %r13
subl	%ecx, %ebx
movq	%r12, %r15
movl	%eax, %ecx
L_3b9:
movq	0x90(%rsp), %r12
nopw	%cs:(%rax,%rax)
L_3d0:
testb	$0x10, %cl
jne	L_440
testb	$0x40, %cl
jne	L_1e53
movzwl	0x2(%rsi), %eax
movl	$0xffffffff, %edx
shll	%cl, %edx
leaq	(,%rax,4), %rax
addq	%rbp, %rax
notl	%edx
andl	%r13d, %edx
movzbl	0x1(%rax,%rdx,4), %ecx
shrq	%cl, %r13
leaq	(%rax,%rdx,4), %rsi
subl	%ecx, %ebx
movzbl	(%rax,%rdx,4), %ecx
testb	%cl, %cl
jne	L_3d0
L_40f:
movzbl	0x2(%rsi), %eax
movb	%al, (%r15)
incq	%r15
movq	%r13, %r14
L_41c:
movq	%r15, %r12
L_41f:
movq	0x10(%rsp), %r15
L_424:
cmpq	0x70(%rsp), %r10
jae	L_1e90
cmpq	0x68(%rsp), %r12
jb	L_342
jmp	L_1e90
nop
L_440:
movzbl	%cl, %ecx
andl	$0xf, %ecx
movl	$0xffffffff, %eax
shll	%cl, %eax
movq	%r13, %rdx
shrq	%cl, %rdx
subl	%ecx, %ebx
cmpl	$0x1b, %ebx
ja	L_476
movq	(%r10), %r14
movl	%ebx, %ecx
shlq	%cl, %r14
orq	%rdx, %r14
movl	%ebx, %ecx
shrl	$0x3, %ecx
subq	%rcx, %r10
addq	$0x7, %r10
orl	$0x38, %ebx
jmp	L_479
L_476:
movq	%rdx, %r14
L_479:
andl	0x88(%rsp), %edx
leaq	(%r12,%rdx,4), %r8
movzbl	0x1(%r8), %ecx
shrq	%cl, %r14
movzwl	0x2(%rsi), %edx
subl	%ecx, %ebx
movzbl	(%r8), %ecx
testb	$0x10, %cl
jne	L_4da
nopl	(%rax,%rax)
L_4a0:
testb	$0x40, %cl
jne	L_1e7a
movzwl	0x2(%r8), %esi
movl	$0xffffffff, %r9d
shll	%cl, %r9d
leaq	(%r12,%rsi,4), %rsi
notl	%r9d
andl	%r14d, %r9d
movzbl	0x1(%rsi,%r9,4), %ecx
shrq	%cl, %r14
leaq	(%rsi,%r9,4), %r8
subl	%ecx, %ebx
movzbl	(%rsi,%r9,4), %ecx
testb	$0x10, %cl
je	L_4a0
L_4da:
notl	%eax
andl	%eax, %r13d
addq	%rdx, %r13
movzwl	0x2(%r8), %eax
andl	$0xf, %ecx
movl	$0xffffffff, %edx
shll	%cl, %edx
notl	%edx
andl	%r14d, %edx
addq	%rax, %rdx
shrq	%cl, %r14
subl	%ecx, %ebx
movl	%r15d, %ecx
subl	0x80(%rsp), %ecx
movq	%rdx, 0x58(%rsp)
movl	%edx, %eax
subl	%ecx, %eax
movq	%r10, (%rsp)
jbe	L_61d
cmpl	0x64(%rsp), %eax
movl	0x18(%rsp), %ecx
ja	L_1ee9
testl	%ecx, %ecx
je	L_6e3
movl	%ecx, %esi
subl	%eax, %esi
jae	L_6e9
subl	%ecx, %eax
movl	0x60(%rsp), %edx
subl	%eax, %edx
movq	0x38(%rsp), %rcx
leaq	(%rcx,%rdx), %rsi
movl	%r13d, %r8d
subl	%eax, %r8d
jbe	L_6ee
movl	%eax, %r12d
movq	%r15, %rcx
subq	%rsi, %rcx
je	L_1288
movl	%r8d, 0x1c(%rsp)
movq	0x50(%rsp), %r9
movq	%r9, %r8
subq	%r15, %r8
cmpq	%r8, %r12
cmovaeq	%r8, %r12
subq	%rsi, %r9
movq	%r9, %rax
negq	%rax
cmovsq	%r9, %rax
cmpq	$0x10, %r8
jb	L_1adc
cmpq	$0xf, %rax
jbe	L_1adc
movq	%rdi, %r13
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
testq	%rcx, %rcx
jns	L_138a
cmpq	%r12, %rax
jae	L_138a
movq	%r15, %rdi
movq	%r12, %rdx
callq	memmove
jmp	L_1972
L_5ce:
movzbl	0x2(%rsi), %eax
movb	%al, 0x1(%r12)
addq	$0x2, %r12
movzbl	0x1(%rsi), %eax
movl	%eax, %ecx
shrq	%cl, %r13
movl	%r13d, %ecx
andl	%r15d, %ecx
leaq	(,%rcx,4), %rsi
addq	%rbp, %rsi
movzbl	(%rbp,%rcx,4), %r8d
movzbl	0x1(%rbp,%rcx,4), %edx
movl	%edx, %ecx
shrq	%cl, %r13
movl	%r8d, %ecx
addl	%edx, %eax
subl	%eax, %ebx
movq	%r12, %r15
testb	%r8b, %r8b
jne	L_3b9
jmp	L_40f
L_61d:
cmpb	$0x0, 0x44(%rsp)
je	L_685
movq	0x58(%rsp), %rcx
movq	%rcx, %rax
negq	%rax
movq	%r15, %rsi
subq	%rcx, %rsi
movq	0x50(%rsp), %rdx
subq	%r15, %rdx
cmpq	%rdx, %r13
cmovbq	%r13, %rdx
testq	%rcx, %rcx
sete	%cl
leaq	(%r15,%rdx), %r12
cmpq	%rax, %rdx
setg	%al
testb	%al, %cl
jne	L_7cd
leaq	(%rsi,%rdx), %rax
cmpq	%rax, %r15
jb	L_7cd
movq	%rdi, %r13
movq	%r15, %rdi
callq	memcpy
movq	(%rsp), %r10
movq	0x8(%rsp), %r11
movq	%r13, %rdi
jmp	L_41f
L_685:
movq	0x58(%rsp), %rcx
movq	%rcx, %rax
negq	%rax
cmpl	%ecx, %r13d
jbe	L_a1f
cmpl	$0x10, %ecx
jae	L_a1f
decq	%rcx
cmpq	$0x7, %rcx
ja	L_12ce
leaq	bums_jump_table_rodata_0(%rip), %rdx
movslq	(%rdx,%rcx,4), %rcx
addq	%rdx, %rcx
jmpq	*%rcx
L_6bf:
movzbl	(%r15,%rax), %esi
movq	%rdi, %r12
movq	%r15, %rdi
movq	%r13, %rdx
callq	memset
movq	(%rsp), %r10
movq	0x8(%rsp), %r11
movq	%r12, %rdi
jmp	L_b44
L_6e3:
movl	0x60(%rsp), %esi
subl	%eax, %esi
L_6e9:
addq	0x38(%rsp), %rsi
L_6ee:
movl	%r13d, %r8d
L_6f1:
movl	%r8d, %r13d
subl	%eax, %r13d
jbe	L_760
movl	%eax, %r12d
cmpb	$0x0, 0x44(%rsp)
je	L_a6a
movq	0x50(%rsp), %rdx
subq	%r15, %rdx
cmpq	%rdx, %r12
cmovbq	%r12, %rdx
movq	%rsi, %rcx
subq	%r15, %rcx
setae	%r9b
leaq	(%r15,%rdx), %r12
cmpq	%r12, %rsi
setb	%r10b
cmpq	%rsi, %r15
setae	%al
leaq	(%rsi,%rdx), %r8
cmpq	%r8, %r15
setb	%r8b
testb	%r10b, %r9b
movq	%rdi, 0x48(%rsp)
jne	L_b4c
andb	%r8b, %al
jne	L_b4c
movq	%r15, %rdi
callq	memcpy
jmp	L_b67
L_760:
movl	%r8d, %r13d
cmpb	$0x0, 0x44(%rsp)
je	L_ada
movq	0x50(%rsp), %rdx
subq	%r15, %rdx
cmpq	%rdx, %r13
cmovbq	%r13, %rdx
movq	%rsi, %rcx
subq	%r15, %rcx
setae	%r9b
leaq	(%r15,%rdx), %r12
cmpq	%r12, %rsi
setb	%r10b
cmpq	%rsi, %r15
setae	%al
leaq	(%rsi,%rdx), %r8
cmpq	%r8, %r15
setb	%r8b
testb	%r10b, %r9b
jne	L_fef
andb	%r8b, %al
jne	L_fef
movq	%rdi, %r13
movq	%r15, %rdi
callq	memcpy
movq	0x8(%rsp), %r11
movq	%r13, %rdi
jmp	L_1238
L_7cd:
cmpq	$0x0, 0x58(%rsp)
je	L_41f
testq	%rdx, %rdx
jne	L_806
jmp	L_41c
nopw	%cs:(%rax,%rax)
L_7f0:
movq	%rsi, %r8
movq	%r10, %r15
L_7f6:
movq	%r8, %rsi
subq	%rax, %rdx
movq	(%rsp), %r10
je	L_41c
L_806:
movq	0x58(%rsp), %rcx
cmpq	%rdx, %rcx
movq	%rdx, %rax
cmovbq	%rcx, %rax
cmpq	$0x10, %rax
jb	L_830
leaq	-0x10(%rax), %r8
movl	%r8d, %ecx
notl	%ecx
testb	$0x30, %cl
jne	L_840
movq	%rax, %rcx
jmp	L_876
nop
L_830:
movq	%rax, %rcx
jmp	L_8b6
nopl	(%rax,%rax)
L_840:
movl	%r8d, %r9d
shrl	$0x4, %r9d
incl	%r9d
andl	$0x3, %r9d
movl	%r9d, %r10d
shll	$0x4, %r10d
movq	%rax, %rcx
subq	%r10, %rcx
nopl	(%rax,%rax)
L_860:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r15)
addq	$0x10, %r15
addq	$0x10, %rsi
decq	%r9
jne	L_860
L_876:
cmpq	$0x30, %r8
jb	L_8b6
nopl	(%rax)
L_880:
movups	(%rsi), %xmm0
movups	%xmm0, (%r15)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%r15)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%r15)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%r15)
addq	$0x40, %r15
addq	$0x40, %rsi
addq	$-0x40, %rcx
cmpq	$0xf, %rcx
ja	L_880
L_8b6:
cmpq	$0x8, %rcx
jb	L_8ce
movq	(%rsi), %r8
movq	%r8, (%r15)
addq	$0x8, %r15
addq	$0x8, %rsi
addq	$-0x8, %rcx
L_8ce:
cmpq	$0x4, %rcx
jb	L_8e6
movl	(%rsi), %r8d
movl	%r8d, (%r15)
addq	$0x4, %r15
addq	$0x4, %rsi
addq	$-0x4, %rcx
L_8e6:
movq	%r15, %r10
testq	%rcx, %rcx
je	L_7f0
cmpq	$0x20, %rcx
jb	L_960
movq	%r10, %r8
subq	%rsi, %r8
cmpq	$0x20, %r8
jb	L_960
movq	%rcx, %r11
andq	$-0x20, %r11
movl	%ecx, %r9d
andl	$0x1f, %r9d
leaq	(%r10,%r11), %r15
leaq	(%rsi,%r11), %r8
xorl	%r12d, %r12d
nopl	(%rax)
L_920:
movdqu	(%rsi,%r12), %xmm0
movups	0x10(%rsi,%r12), %xmm1
movdqu	%xmm0, (%r10,%r12)
movups	%xmm1, 0x10(%r10,%r12)
addq	$0x20, %r12
cmpq	%r12, %r11
jne	L_920
cmpq	%r11, %rcx
movq	0x8(%rsp), %r11
je	L_7f6
jmp	L_969
nopw	%cs:(%rax,%rax)
L_960:
movq	%rcx, %r9
movq	%r10, %r15
movq	%rsi, %r8
L_969:
movq	%r9, %rcx
andq	$0x7, %rcx
je	L_99f
xorl	%esi, %esi
nopw	%cs:(%rax,%rax)
L_980:
movzbl	(%r8,%rsi), %r10d
movb	%r10b, (%r15,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_980
movq	%r9, %rcx
subq	%rsi, %rcx
addq	%rsi, %r15
addq	%rsi, %r8
jmp	L_9a2
L_99f:
movq	%r9, %rcx
L_9a2:
movq	%r15, %rsi
movq	%r8, %r10
decq	%r9
cmpq	$0x7, %r9
jb	L_7f6
nopw	%cs:(%rax,%rax)
L_9c0:
movzbl	(%r10), %r8d
movb	%r8b, (%rsi)
movzbl	0x1(%r10), %r8d
movb	%r8b, 0x1(%rsi)
movzbl	0x2(%r10), %r8d
movb	%r8b, 0x2(%rsi)
movzbl	0x3(%r10), %r8d
movb	%r8b, 0x3(%rsi)
movzbl	0x4(%r10), %r8d
movb	%r8b, 0x4(%rsi)
movzbl	0x5(%r10), %r8d
movb	%r8b, 0x5(%rsi)
movzbl	0x6(%r10), %r8d
movb	%r8b, 0x6(%rsi)
leaq	0x8(%r10), %r8
leaq	0x8(%rsi), %r15
movzbl	0x7(%r10), %r9d
movb	%r9b, 0x7(%rsi)
movq	%r15, %rsi
movq	%r8, %r10
addq	$-0x8, %rcx
jne	L_9c0
jmp	L_7f6
L_a1f:
leal	-0x1(%r13), %ecx
andl	$0xf, %ecx
movdqu	(%r15,%rax), %xmm0
movdqu	%xmm0, (%r15)
leaq	(%rcx,%r15), %r12
incq	%r12
notl	%ecx
addl	%r13d, %ecx
je	L_41f
movq	0x10(%rsp), %r15
nopl	(%rax,%rax)
L_a50:
movdqu	(%r12,%rax), %xmm0
movdqu	%xmm0, (%r12)
addq	$0x10, %r12
addl	$-0x10, %ecx
jne	L_a50
jmp	L_424
L_a6a:
movq	%r15, %rdx
subq	%rsi, %rdx
je	L_1241
movq	0x50(%rsp), %r8
movq	%r8, %rcx
subq	%r15, %rcx
cmpq	%rcx, %r12
cmovaeq	%rcx, %r12
subq	%rsi, %r8
movq	%r8, %rax
negq	%rax
cmovsq	%r8, %rax
cmpq	$0x10, %rcx
jb	L_1996
cmpq	$0xf, %rax
jbe	L_1996
movq	%rdx, %rax
negq	%rax
cmovsq	%rdx, %rax
testq	%rdx, %rdx
jns	L_1249
cmpq	%r12, %rax
jae	L_1249
movq	%rdi, 0x48(%rsp)
movq	%r15, %rdi
movq	%r12, %rdx
callq	memmove
jmp	L_1612
L_ada:
movq	%r15, %rcx
subq	%rsi, %rcx
je	L_b44
movq	0x50(%rsp), %r8
movq	%r8, %rdx
subq	%r15, %rdx
cmpq	%rdx, %r13
cmovaeq	%rdx, %r13
subq	%rsi, %r8
movq	%r8, %rax
negq	%rax
cmovsq	%r8, %rax
cmpq	$0x10, %rdx
jb	L_1a09
cmpq	$0xf, %rax
jbe	L_1a09
movq	%rdi, %r12
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
testq	%rcx, %rcx
jns	L_126b
cmpq	%r13, %rax
jae	L_126b
movq	%r15, %rdi
movq	%r13, %rdx
callq	memmove
jmp	L_18a2
L_b44:
addq	%r13, %r15
jmp	L_41c
L_b4c:
cmpq	%rsi, %r15
je	L_b67
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
movq	%r15, %r12
testq	%rdx, %rdx
jne	L_df4
L_b67:
movq	%r12, %rsi
subq	0x58(%rsp), %rsi
movl	%r13d, %eax
movq	0x50(%rsp), %rdx
subq	%r12, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
leaq	(%rsi,%rdx), %rax
cmpq	%rax, %r12
jae	L_121f
testq	%rdx, %rdx
movq	0x48(%rsp), %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
movq	0x10(%rsp), %r15
jne	L_bc6
jmp	L_424
nopl	(%rax,%rax)
L_bb0:
movq	%rsi, %r8
movq	%r10, %r12
L_bb6:
movq	%r8, %rsi
subq	%rax, %rdx
movq	(%rsp), %r10
je	L_424
L_bc6:
movq	0x58(%rsp), %rcx
cmpq	%rdx, %rcx
movq	%rdx, %rax
cmovbq	%rcx, %rax
cmpq	$0x10, %rax
jb	L_bf0
leaq	-0x10(%rax), %r8
movl	%r8d, %ecx
notl	%ecx
testb	$0x30, %cl
jne	L_bf5
movq	%rax, %rcx
jmp	L_c27
nop
L_bf0:
movq	%rax, %rcx
jmp	L_c6a
L_bf5:
movl	%r8d, %r9d
shrl	$0x4, %r9d
incl	%r9d
andl	$0x3, %r9d
movl	%r9d, %r10d
shll	$0x4, %r10d
movq	%rax, %rcx
subq	%r10, %rcx
L_c10:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r12)
addq	$0x10, %r12
addq	$0x10, %rsi
decq	%r9
jne	L_c10
L_c27:
cmpq	$0x30, %r8
jb	L_c6a
nopl	(%rax)
L_c30:
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
ja	L_c30
L_c6a:
cmpq	$0x8, %rcx
jb	L_c83
movq	(%rsi), %r8
movq	%r8, (%r12)
addq	$0x8, %r12
addq	$0x8, %rsi
addq	$-0x8, %rcx
L_c83:
cmpq	$0x4, %rcx
jb	L_c9c
movl	(%rsi), %r8d
movl	%r8d, (%r12)
addq	$0x4, %r12
addq	$0x4, %rsi
addq	$-0x4, %rcx
L_c9c:
movq	%r12, %r10
testq	%rcx, %rcx
je	L_bb0
cmpq	$0x20, %rcx
jb	L_d20
movq	%r10, %r8
subq	%rsi, %r8
cmpq	$0x20, %r8
jb	L_d20
movq	%rcx, %r11
andq	$-0x20, %r11
movl	%ecx, %r9d
andl	$0x1f, %r9d
leaq	(%r10,%r11), %r12
leaq	(%rsi,%r11), %r8
xorl	%r15d, %r15d
nopw	%cs:(%rax,%rax)
L_ce0:
movdqu	(%rsi,%r15), %xmm0
movups	0x10(%rsi,%r15), %xmm1
movdqu	%xmm0, (%r10,%r15)
movups	%xmm1, 0x10(%r10,%r15)
addq	$0x20, %r15
cmpq	%r15, %r11
jne	L_ce0
cmpq	%r11, %rcx
movq	0x8(%rsp), %r11
movq	0x10(%rsp), %r15
je	L_bb6
jmp	L_d29
nopw	%cs:(%rax,%rax)
L_d20:
movq	%rcx, %r9
movq	%r10, %r12
movq	%rsi, %r8
L_d29:
movq	%r9, %rcx
andq	$0x7, %rcx
je	L_d5f
xorl	%esi, %esi
nopw	%cs:(%rax,%rax)
L_d40:
movzbl	(%r8,%rsi), %r10d
movb	%r10b, (%r12,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_d40
movq	%r9, %rcx
subq	%rsi, %rcx
addq	%rsi, %r12
addq	%rsi, %r8
jmp	L_d62
L_d5f:
movq	%r9, %rcx
L_d62:
movq	%r12, %rsi
movq	%r8, %r10
decq	%r9
cmpq	$0x7, %r9
jb	L_bb6
nopw	%cs:(%rax,%rax)
L_d80:
movzbl	(%r10), %r8d
movb	%r8b, (%rsi)
movzbl	0x1(%r10), %r8d
movb	%r8b, 0x1(%rsi)
movzbl	0x2(%r10), %r8d
movb	%r8b, 0x2(%rsi)
movzbl	0x3(%r10), %r8d
movb	%r8b, 0x3(%rsi)
movzbl	0x4(%r10), %r8d
movb	%r8b, 0x4(%rsi)
movzbl	0x5(%r10), %r8d
movb	%r8b, 0x5(%rsi)
movzbl	0x6(%r10), %r8d
movb	%r8b, 0x6(%rsi)
leaq	0x8(%r10), %r8
leaq	0x8(%rsi), %r12
movzbl	0x7(%r10), %r9d
movb	%r9b, 0x7(%rsi)
movq	%r12, %rsi
movq	%r8, %r10
addq	$-0x8, %rcx
jne	L_d80
jmp	L_bb6
L_ddf:
movq	%rsi, %r8
movq	%r15, %r12
L_de5:
movq	%r12, %r15
movq	%r8, %rsi
subq	%rcx, %rdx
je	L_b67
L_df4:
cmpq	%rdx, %rax
movq	%rdx, %rcx
cmovbq	%rax, %rcx
cmpq	$0x10, %rcx
jb	L_e20
leaq	-0x10(%rcx), %r8
movl	%r8d, %edi
notl	%edi
testb	$0x30, %dil
jne	L_e25
movq	%rcx, %rdi
jmp	L_e56
nopl	(%rax,%rax)
L_e20:
movq	%rcx, %rdi
jmp	L_e96
L_e25:
movl	%r8d, %r9d
shrl	$0x4, %r9d
incl	%r9d
andl	$0x3, %r9d
movl	%r9d, %r10d
shll	$0x4, %r10d
movq	%rcx, %rdi
subq	%r10, %rdi
L_e40:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r15)
addq	$0x10, %r15
addq	$0x10, %rsi
decq	%r9
jne	L_e40
L_e56:
cmpq	$0x30, %r8
jb	L_e96
nopl	(%rax)
L_e60:
movups	(%rsi), %xmm0
movups	%xmm0, (%r15)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%r15)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%r15)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%r15)
addq	$0x40, %r15
addq	$0x40, %rsi
addq	$-0x40, %rdi
cmpq	$0xf, %rdi
ja	L_e60
L_e96:
cmpq	$0x8, %rdi
jb	L_ec0
movq	(%rsi), %r8
movq	%r8, (%r15)
addq	$0x8, %r15
addq	$0x8, %rsi
addq	$-0x8, %rdi
cmpq	$0x4, %rdi
jae	L_ec6
L_eb4:
testq	%rdi, %rdi
jne	L_ee1
jmp	L_ddf
nop
L_ec0:
cmpq	$0x4, %rdi
jb	L_eb4
L_ec6:
movl	(%rsi), %r8d
movl	%r8d, (%r15)
addq	$0x4, %r15
addq	$0x4, %rsi
addq	$-0x4, %rdi
testq	%rdi, %rdi
je	L_ddf
L_ee1:
cmpq	$0x20, %rdi
jb	L_f3c
movq	%r15, %r8
subq	%rsi, %r8
cmpq	$0x20, %r8
jb	L_f3c
movq	%rdi, %r10
andq	$-0x20, %r10
movl	%edi, %r9d
andl	$0x1f, %r9d
leaq	(%r15,%r10), %r12
leaq	(%rsi,%r10), %r8
xorl	%r11d, %r11d
nopl	(%rax)
L_f10:
movdqu	(%rsi,%r11), %xmm0
movups	0x10(%rsi,%r11), %xmm1
movdqu	%xmm0, (%r15,%r11)
movups	%xmm1, 0x10(%r15,%r11)
addq	$0x20, %r11
cmpq	%r11, %r10
jne	L_f10
cmpq	%r10, %rdi
je	L_de5
jmp	L_f45
L_f3c:
movq	%rdi, %r9
movq	%r15, %r12
movq	%rsi, %r8
L_f45:
movq	%r9, %rsi
andq	$0x7, %rsi
je	L_f6f
xorl	%edi, %edi
L_f50:
movzbl	(%r8,%rdi), %r10d
movb	%r10b, (%r12,%rdi)
incq	%rdi
cmpq	%rdi, %rsi
jne	L_f50
movq	%r9, %rsi
subq	%rdi, %rsi
addq	%rdi, %r12
addq	%rdi, %r8
jmp	L_f72
L_f6f:
movq	%r9, %rsi
L_f72:
movq	%r12, %rdi
movq	%r8, %r10
decq	%r9
cmpq	$0x7, %r9
jb	L_de5
nopw	%cs:(%rax,%rax)
L_f90:
movzbl	(%r10), %r8d
movb	%r8b, (%rdi)
movzbl	0x1(%r10), %r8d
movb	%r8b, 0x1(%rdi)
movzbl	0x2(%r10), %r8d
movb	%r8b, 0x2(%rdi)
movzbl	0x3(%r10), %r8d
movb	%r8b, 0x3(%rdi)
movzbl	0x4(%r10), %r8d
movb	%r8b, 0x4(%rdi)
movzbl	0x5(%r10), %r8d
movb	%r8b, 0x5(%rdi)
movzbl	0x6(%r10), %r8d
movb	%r8b, 0x6(%rdi)
leaq	0x8(%r10), %r8
leaq	0x8(%rdi), %r12
movzbl	0x7(%r10), %r9d
movb	%r9b, 0x7(%rdi)
movq	%r12, %rdi
movq	%r8, %r10
addq	$-0x8, %rsi
jne	L_f90
jmp	L_de5
L_fef:
cmpq	%rsi, %r15
movq	(%rsp), %r10
je	L_41f
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
testq	%rdx, %rdx
jne	L_102b
jmp	L_41c
L_1010:
movq	%rsi, %r9
movq	%r11, %r15
L_1016:
movq	%r9, %rsi
subq	%rcx, %rdx
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
je	L_41c
L_102b:
cmpq	%rdx, %rax
movq	%rdx, %rcx
cmovbq	%rax, %rcx
cmpq	$0x10, %rcx
jb	L_1050
leaq	-0x10(%rcx), %r9
movl	%r9d, %r8d
notl	%r8d
testb	$0x30, %r8b
jne	L_1055
movq	%rcx, %r8
jmp	L_1086
L_1050:
movq	%rcx, %r8
jmp	L_10c6
L_1055:
movl	%r9d, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x3, %r10d
movl	%r10d, %r11d
shll	$0x4, %r11d
movq	%rcx, %r8
subq	%r11, %r8
L_1070:
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r15)
addq	$0x10, %r15
addq	$0x10, %rsi
decq	%r10
jne	L_1070
L_1086:
cmpq	$0x30, %r9
jb	L_10c6
nopl	(%rax)
L_1090:
movups	(%rsi), %xmm0
movups	%xmm0, (%r15)
movups	0x10(%rsi), %xmm0
movups	%xmm0, 0x10(%r15)
movups	0x20(%rsi), %xmm0
movups	%xmm0, 0x20(%r15)
movdqu	0x30(%rsi), %xmm0
movdqu	%xmm0, 0x30(%r15)
addq	$0x40, %r15
addq	$0x40, %rsi
addq	$-0x40, %r8
cmpq	$0xf, %r8
ja	L_1090
L_10c6:
cmpq	$0x8, %r8
jb	L_10de
movq	(%rsi), %r9
movq	%r9, (%r15)
addq	$0x8, %r15
addq	$0x8, %rsi
addq	$-0x8, %r8
L_10de:
cmpq	$0x4, %r8
jb	L_10f6
movl	(%rsi), %r9d
movl	%r9d, (%r15)
addq	$0x4, %r15
addq	$0x4, %rsi
addq	$-0x4, %r8
L_10f6:
movq	%r15, %r11
testq	%r8, %r8
je	L_1010
cmpq	$0x20, %r8
jb	L_115c
movq	%r11, %r9
subq	%rsi, %r9
cmpq	$0x20, %r9
jb	L_115c
movq	%r8, %r12
andq	$-0x20, %r12
movl	%r8d, %r10d
andl	$0x1f, %r10d
leaq	(%r11,%r12), %r15
leaq	(%rsi,%r12), %r9
xorl	%r13d, %r13d
nopl	(%rax)
L_1130:
movdqu	(%rsi,%r13), %xmm0
movups	0x10(%rsi,%r13), %xmm1
movdqu	%xmm0, (%r11,%r13)
movups	%xmm1, 0x10(%r11,%r13)
addq	$0x20, %r13
cmpq	%r13, %r12
jne	L_1130
cmpq	%r12, %r8
je	L_1016
jmp	L_1165
L_115c:
movq	%r8, %r10
movq	%r11, %r15
movq	%rsi, %r9
L_1165:
movq	%r10, %rsi
andq	$0x7, %rsi
je	L_119f
xorl	%r8d, %r8d
nopw	%cs:(%rax,%rax)
L_1180:
movzbl	(%r9,%r8), %r11d
movb	%r11b, (%r15,%r8)
incq	%r8
cmpq	%r8, %rsi
jne	L_1180
movq	%r10, %rsi
subq	%r8, %rsi
addq	%r8, %r15
addq	%r8, %r9
jmp	L_11a2
L_119f:
movq	%r10, %rsi
L_11a2:
movq	%r15, %r8
movq	%r9, %r11
decq	%r10
cmpq	$0x7, %r10
jb	L_1016
nopw	%cs:(%rax,%rax)
L_11c0:
movzbl	(%r11), %r9d
movb	%r9b, (%r8)
movzbl	0x1(%r11), %r9d
movb	%r9b, 0x1(%r8)
movzbl	0x2(%r11), %r9d
movb	%r9b, 0x2(%r8)
movzbl	0x3(%r11), %r9d
movb	%r9b, 0x3(%r8)
movzbl	0x4(%r11), %r9d
movb	%r9b, 0x4(%r8)
movzbl	0x5(%r11), %r9d
movb	%r9b, 0x5(%r8)
movzbl	0x6(%r11), %r9d
movb	%r9b, 0x6(%r8)
leaq	0x8(%r11), %r9
leaq	0x8(%r8), %r15
movzbl	0x7(%r11), %r10d
movb	%r10b, 0x7(%r8)
movq	%r15, %r8
movq	%r9, %r11
addq	$-0x8, %rsi
jne	L_11c0
jmp	L_1016
L_121f:
leaq	(%r12,%rdx), %r15
movq	%r12, %rdi
callq	memcpy
movq	%r15, %r12
movq	0x48(%rsp), %rdi
L_1233:
movq	0x8(%rsp), %r11
L_1238:
movq	(%rsp), %r10
jmp	L_41f
L_1241:
addq	%r12, %r15
jmp	L_1623
L_1249:
cmpq	$0x1, %rax
jne	L_13a7
movzbl	(%rsi), %esi
movq	%rdi, 0x48(%rsp)
movq	%r15, %rdi
movq	%r12, %rdx
callq	memset
jmp	L_1612
L_126b:
cmpq	$0x1, %rax
jne	L_13f2
movzbl	(%rsi), %esi
movq	%r15, %rdi
movq	%r13, %rdx
callq	memset
jmp	L_18a2
L_1288:
addq	%r12, %r15
movl	0x18(%rsp), %eax
movq	0x38(%rsp), %rsi
jmp	L_6f1
L_1299:
movd	(%r15,%rax), %xmm0
jmp	L_12af
L_12a1:
movzwl	(%r15,%rax), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
L_12af:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_12c1
L_12b6:
movq	(%r15,%rax), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_12c1:
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
jmp	L_130a
L_12ce:
movl	$0xfffffffd, %ecx
movq	0x58(%rsp), %rsi
addl	%ecx, %esi
leaq	perm_idx_lut(%rip), %rdx
movzwl	(%rdx,%rsi,4), %ecx
movdqu	(%r15,%rax), %xmm0
leaq	permute_table(%rip), %rax
pshufb	(%rcx,%rax), %xmm0
movzwl	0x2(%rdx,%rsi,4), %ecx
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
subl	%ecx, %eax
L_130a:
movl	%eax, %ecx
cmpl	$0x20, %r13d
jb	L_1337
leal	(%rax,%rax), %edx
nopw	%cs:(%rax,%rax)
L_1320:
movdqu	%xmm0, (%r15)
movdqu	%xmm0, (%r15,%rcx)
addq	%rdx, %r15
subl	%edx, %r13d
cmpl	$0x1f, %r13d
ja	L_1320
L_1337:
cmpl	$0x10, %r13d
jb	L_1357
nopl	(%rax)
L_1340:
movdqa	0x20(%rsp), %xmm0
movdqu	%xmm0, (%r15)
subl	%eax, %r13d
addq	%rcx, %r15
cmpl	$0xf, %r13d
ja	L_1340
L_1357:
testl	%r13d, %r13d
je	L_41c
movl	%r13d, %r12d
movq	%rdi, %r13
movq	%r15, %rdi
leaq	0x20(%rsp), %rsi
movq	%r12, %rdx
callq	memcpy
movq	(%rsp), %r10
movq	0x8(%rsp), %r11
movq	%r13, %rdi
addq	%r12, %r15
jmp	L_41c
L_138a:
cmpq	$0x1, %rax
jne	L_1444
movzbl	(%rsi), %esi
movq	%r15, %rdi
movq	%r12, %rdx
callq	memset
jmp	L_1972
L_13a7:
cmpq	$0x10, %rax
jb	L_14a0
leal	-0x1(%r12), %eax
andl	$0xf, %eax
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r15)
movl	%eax, %ecx
notl	%ecx
addl	%r12d, %ecx
movq	(%rsp), %r10
je	L_1523
incq	%rax
L_13d6:
movdqu	(%rsi,%rax), %xmm0
movdqu	%xmm0, (%r15,%rax)
addq	$0x10, %rax
cmpl	%eax, %r12d
jne	L_13d6
addq	%rax, %r15
jmp	L_1623
L_13f2:
cmpq	$0x10, %rax
jb	L_14cc
leal	-0x1(%r13), %eax
andl	$0xf, %eax
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r15)
movl	%eax, %ecx
notl	%ecx
addl	%r13d, %ecx
movq	%r12, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
je	L_152e
incq	%rax
L_1428:
movdqu	(%rsi,%rax), %xmm0
movdqu	%xmm0, (%r15,%rax)
addq	$0x10, %rax
cmpl	%eax, %r13d
jne	L_1428
addq	%rax, %r15
jmp	L_41c
L_1444:
cmpq	$0x10, %rax
jb	L_14f4
leal	-0x1(%r12), %eax
andl	$0xf, %eax
movdqu	(%rsi), %xmm0
movdqu	%xmm0, (%r15)
movl	%eax, %ecx
notl	%ecx
addl	%r12d, %ecx
movq	%r13, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
movl	0x1c(%rsp), %r8d
je	L_18b6
incq	%rax
movl	0x18(%rsp), %ecx
L_1484:
movdqu	(%rsi,%rax), %xmm0
movdqu	%xmm0, (%r15,%rax)
addq	$0x10, %rax
cmpl	%eax, %r12d
jne	L_1484
addq	%rax, %r15
jmp	L_198a
L_14a0:
cmpq	$0x8, %rax
je	L_1550
cmpq	$0x4, %rax
je	L_153a
cmpq	$0x2, %rax
jne	L_157f
movzwl	(%rsi), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_153e
L_14cc:
cmpq	$0x8, %rax
je	L_1566
cmpq	$0x4, %rax
je	L_1545
cmpq	$0x2, %rax
jne	L_1814
movzwl	(%rsi), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_1549
L_14f4:
cmpq	$0x8, %rax
je	L_18d0
cmpq	$0x4, %rax
je	L_18c5
cmpq	$0x2, %rax
jne	L_18e6
movzwl	(%rsi), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_18c9
L_1523:
addq	%rax, %r15
incq	%r15
jmp	L_1623
L_152e:
leaq	(%r15,%rax), %r12
incq	%r12
jmp	L_41f
L_153a:
movd	(%rsi), %xmm0
L_153e:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_1559
L_1545:
movd	(%rsi), %xmm0
L_1549:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_156f
L_1550:
movq	(%rsi), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_1559:
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
jmp	L_15b4
L_1566:
movq	(%rsi), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_156f:
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
jmp	L_1849
L_157f:
movl	$0xfffffffd, %ecx
addl	%ecx, %eax
leaq	perm_idx_lut(%rip), %rdx
movzwl	(%rdx,%rax,4), %ecx
movdqu	(%rsi), %xmm0
leaq	permute_table(%rip), %rsi
pshufb	(%rcx,%rsi), %xmm0
movzwl	0x2(%rdx,%rax,4), %ecx
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
subl	%ecx, %eax
L_15b4:
cmpq	$0x20, %r12
jb	L_15d6
movl	%eax, %ecx
leal	(%rax,%rax), %edx
L_15bf:
movdqu	%xmm0, (%r15)
movdqu	%xmm0, (%r15,%rcx)
addq	%rdx, %r15
subl	%edx, %r12d
cmpl	$0x1f, %r12d
ja	L_15bf
L_15d6:
cmpl	$0x10, %r12d
jb	L_15f5
movl	%eax, %ecx
L_15de:
movdqa	0x20(%rsp), %xmm0
movdqu	%xmm0, (%r15)
subl	%eax, %r12d
addq	%rcx, %r15
cmpl	$0xf, %r12d
ja	L_15de
L_15f5:
testl	%r12d, %r12d
je	L_161f
movl	%r12d, %r12d
movq	%rdi, 0x48(%rsp)
movq	%r15, %rdi
leaq	0x20(%rsp), %rsi
movq	%r12, %rdx
callq	memcpy
L_1612:
movq	0x8(%rsp), %r11
movq	0x48(%rsp), %rdi
addq	%r12, %r15
L_161f:
movq	(%rsp), %r10
L_1623:
movq	%r15, %rax
L_1626:
movq	0x58(%rsp), %r8
cmpq	$0xf, %r8
ja	L_166a
cmpl	%r8d, %r13d
jbe	L_166a
movq	%r8, %rcx
negq	%rcx
movq	%rax, %r12
nop
L_1640:
movq	%r12, %rdx
movl	%r8d, %esi
movdqu	(%rax,%rcx), %xmm0
movdqu	%xmm0, (%r12)
movl	%r8d, %r12d
addq	%rdx, %r12
subl	%r8d, %r13d
leal	(%rsi,%rsi), %r8d
cmpl	$0x7, %esi
ja	L_166d
cmpl	%r13d, %r8d
jb	L_1640
jmp	L_166d
L_166a:
movq	%rax, %r12
L_166d:
movl	%r13d, %r15d
testl	%r8d, %r8d
je	L_16d2
movl	%r8d, %ecx
movq	%rcx, %rdx
negq	%rdx
movq	%r12, %rax
subq	%rcx, %rax
movq	0x50(%rsp), %r9
movq	%r9, %r8
subq	%r12, %r8
cmpq	%r8, %r15
cmovaeq	%r8, %r15
subq	%rax, %r9
movq	%r9, %rsi
negq	%rsi
cmovsq	%r9, %rsi
cmpq	$0x10, %r8
jb	L_1a6c
cmpq	$0xf, %rsi
jbe	L_1a6c
cmpl	$0x1, %ecx
jne	L_16da
movzbl	(%rax), %esi
movq	%rdi, %r13
movq	%r12, %rdi
movq	%r15, %rdx
callq	memset
jmp	L_1800
L_16d2:
addq	%r15, %r12
jmp	L_41f
L_16da:
cmpl	$0x10, %ecx
jb	L_172a
leal	-0x1(%r15), %ecx
andl	$0xf, %ecx
movdqu	(%rax), %xmm0
movdqu	%xmm0, (%r12)
addq	%rcx, %r12
incq	%r12
notl	%ecx
addl	%r15d, %ecx
je	L_41f
movq	0x10(%rsp), %r15
nopw	%cs:(%rax,%rax)
L_1710:
movdqu	(%r12,%rdx), %xmm0
movdqu	%xmm0, (%r12)
addq	$0x10, %r12
addl	$-0x10, %ecx
jne	L_1710
jmp	L_424
L_172a:
cmpq	$0x8, %rcx
je	L_1753
cmpl	$0x4, %ecx
je	L_1748
cmpl	$0x2, %ecx
jne	L_1769
movzwl	(%rax), %eax
movd	%eax, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
jmp	L_174c
L_1748:
movd	(%rax), %xmm0
L_174c:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_175c
L_1753:
movq	(%rax), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_175c:
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
jmp	L_179e
L_1769:
movl	$0xfffffffd, %edx
addl	%edx, %ecx
leaq	perm_idx_lut(%rip), %rsi
movzwl	(%rsi,%rcx,4), %edx
movdqu	(%rax), %xmm0
leaq	permute_table(%rip), %rax
pshufb	(%rdx,%rax), %xmm0
movzwl	0x2(%rsi,%rcx,4), %ecx
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
subl	%ecx, %eax
L_179e:
cmpq	$0x20, %r15
jb	L_17c1
movl	%eax, %ecx
leal	(%rax,%rax), %edx
L_17a9:
movdqu	%xmm0, (%r12)
movdqu	%xmm0, (%r12,%rcx)
addq	%rdx, %r12
subl	%edx, %r15d
cmpl	$0x1f, %r15d
ja	L_17a9
L_17c1:
cmpl	$0x10, %r15d
jb	L_17e1
movl	%eax, %ecx
L_17c9:
movdqa	0x20(%rsp), %xmm0
movdqu	%xmm0, (%r12)
subl	%eax, %r15d
addq	%rcx, %r12
cmpl	$0xf, %r15d
ja	L_17c9
L_17e1:
testl	%r15d, %r15d
je	L_41f
movl	%r15d, %r15d
movq	%rdi, %r13
movq	%r12, %rdi
leaq	0x20(%rsp), %rsi
movq	%r15, %rdx
callq	memcpy
L_1800:
movq	(%rsp), %r10
movq	0x8(%rsp), %r11
movq	%r13, %rdi
addq	%r15, %r12
jmp	L_41f
L_1814:
movl	$0xfffffffd, %ecx
addl	%ecx, %eax
leaq	perm_idx_lut(%rip), %rdx
movzwl	(%rdx,%rax,4), %ecx
movdqu	(%rsi), %xmm0
leaq	permute_table(%rip), %rsi
pshufb	(%rcx,%rsi), %xmm0
movzwl	0x2(%rdx,%rax,4), %ecx
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
subl	%ecx, %eax
L_1849:
cmpq	$0x20, %r13
jb	L_186b
movl	%eax, %ecx
leal	(%rax,%rax), %edx
L_1854:
movdqu	%xmm0, (%r15)
movdqu	%xmm0, (%r15,%rcx)
addq	%rdx, %r15
subl	%edx, %r13d
cmpl	$0x1f, %r13d
ja	L_1854
L_186b:
cmpl	$0x10, %r13d
jb	L_188a
movl	%eax, %ecx
L_1873:
movdqa	0x20(%rsp), %xmm0
movdqu	%xmm0, (%r15)
subl	%eax, %r13d
addq	%rcx, %r15
cmpl	$0xf, %r13d
ja	L_1873
L_188a:
testl	%r13d, %r13d
je	L_18a5
movl	%r13d, %r13d
movq	%r15, %rdi
leaq	0x20(%rsp), %rsi
movq	%r13, %rdx
callq	memcpy
L_18a2:
addq	%r13, %r15
L_18a5:
movq	%r12, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
jmp	L_41c
L_18b6:
addq	%rax, %r15
incq	%r15
movl	0x18(%rsp), %ecx
jmp	L_198a
L_18c5:
movd	(%rsi), %xmm0
L_18c9:
pshufd	$0x0, %xmm0, %xmm0
jmp	L_18d9
L_18d0:
movq	(%rsi), %xmm0
pshufd	$0x44, %xmm0, %xmm0
L_18d9:
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
jmp	L_191b
L_18e6:
movl	$0xfffffffd, %ecx
addl	%ecx, %eax
leaq	perm_idx_lut(%rip), %rdx
movzwl	(%rdx,%rax,4), %ecx
movdqu	(%rsi), %xmm0
leaq	permute_table(%rip), %rsi
pshufb	(%rcx,%rsi), %xmm0
movzwl	0x2(%rdx,%rax,4), %ecx
movdqa	%xmm0, 0x20(%rsp)
movl	$0x10, %eax
subl	%ecx, %eax
L_191b:
movl	%eax, %ecx
cmpq	$0x20, %r12
jb	L_193d
leal	(%rax,%rax), %edx
L_1926:
movdqu	%xmm0, (%r15)
movdqu	%xmm0, (%r15,%rcx)
addq	%rdx, %r15
subl	%edx, %r12d
cmpl	$0x1f, %r12d
ja	L_1926
L_193d:
cmpl	$0x10, %r12d
jb	L_195a
L_1943:
movdqa	0x20(%rsp), %xmm0
movdqu	%xmm0, (%r15)
subl	%eax, %r12d
addq	%rcx, %r15
cmpl	$0xf, %r12d
ja	L_1943
L_195a:
testl	%r12d, %r12d
je	L_1975
movl	%r12d, %r12d
movq	%r15, %rdi
leaq	0x20(%rsp), %rsi
movq	%r12, %rdx
callq	memcpy
L_1972:
addq	%r12, %r15
L_1975:
movq	%r13, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
movl	0x18(%rsp), %ecx
movl	0x1c(%rsp), %r8d
L_198a:
movl	%ecx, %eax
movq	0x38(%rsp), %rsi
jmp	L_6f1
L_1996:
movq	%rdi, %rcx
testq	%r12, %r12
je	L_1b3e
cmpq	$0x20, %r12
jb	L_1b4e
cmpq	$0x20, %rdx
jb	L_1b4e
movl	%r12d, %edi
andl	$-0x20, %edi
leaq	(%r15,%rdi), %rax
leaq	(%rsi,%rdi), %rdx
movl	%r12d, %r8d
andl	$0x1f, %r8d
xorl	%r9d, %r9d
L_19ce:
movdqu	(%rsi,%r9), %xmm0
movups	0x10(%rsi,%r9), %xmm1
movdqu	%xmm0, (%r15,%r9)
movups	%xmm1, 0x10(%r15,%r9)
addq	$0x20, %r9
cmpq	%r9, %rdi
jne	L_19ce
cmpq	%rdi, %r12
movq	%rcx, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
je	L_1626
jmp	L_1b57
L_1a09:
testq	%r13, %r13
je	L_1b46
cmpq	$0x20, %r13
jb	L_1b85
cmpq	$0x20, %rcx
jb	L_1b85
movl	%r13d, %edx
andl	$-0x20, %edx
leaq	(%r15,%rdx), %r12
leaq	(%rsi,%rdx), %rax
movl	%r13d, %ecx
andl	$0x1f, %ecx
xorl	%r8d, %r8d
L_1a3d:
movdqu	(%rsi,%r8), %xmm0
movups	0x10(%rsi,%r8), %xmm1
movdqu	%xmm0, (%r15,%r8)
movups	%xmm1, 0x10(%r15,%r8)
addq	$0x20, %r8
cmpq	%r8, %rdx
jne	L_1a3d
cmpq	%rdx, %r13
je	L_1233
jmp	L_1b8e
L_1a6c:
testq	%r15, %r15
je	L_1233
cmpq	$0x20, %r15
jb	L_1bbf
cmpl	$0x20, %ecx
jb	L_1bbf
movl	%r15d, %r8d
andl	$-0x20, %r8d
leaq	(%r12,%r8), %rcx
addq	%r8, %rax
movl	%r15d, %esi
andl	$0x1f, %esi
addq	%r12, %rdx
addq	$0x10, %rdx
addq	$0x10, %r12
xorl	%r9d, %r9d
L_1aaa:
movdqu	-0x10(%rdx,%r9), %xmm0
movups	(%rdx,%r9), %xmm1
movdqu	%xmm0, -0x10(%r12,%r9)
movups	%xmm1, (%r12,%r9)
addq	$0x20, %r9
cmpq	%r9, %r8
jne	L_1aaa
cmpq	%r8, %r15
jne	L_1bc5
movq	%rcx, %r12
jmp	L_1233
L_1adc:
testq	%r12, %r12
je	L_1e37
cmpq	$0x20, %r12
jb	L_1b03
movq	0x38(%rsp), %rax
addq	%rdx, %rax
movq	%r15, %rcx
subq	%rax, %rcx
cmpq	$0x20, %rcx
jae	L_1dee
L_1b03:
movq	%r15, %rax
movq	%r12, %rcx
L_1b09:
movq	%rcx, %rdx
andq	$0x7, %rdx
je	L_1d78
xorl	%r8d, %r8d
L_1b19:
movzbl	(%rsi,%r8), %r9d
movb	%r9b, (%rax,%r8)
incq	%r8
cmpq	%r8, %rdx
jne	L_1b19
addq	%r8, %rax
addq	%r8, %rsi
movq	%rcx, %rdx
subq	%r8, %rdx
movq	%rax, %r15
jmp	L_1d7b
L_1b3e:
movq	%r15, %rax
jmp	L_1c7a
L_1b46:
movq	%r15, %r12
jmp	L_1233
L_1b4e:
movq	%r15, %rax
movq	%rsi, %rdx
movq	%r12, %r8
L_1b57:
movq	%r8, %rsi
andq	$0x7, %rsi
je	L_1bfa
xorl	%edi, %edi
L_1b66:
movzbl	(%rdx,%rdi), %r9d
movb	%r9b, (%rax,%rdi)
incq	%rdi
cmpq	%rdi, %rsi
jne	L_1b66
addq	%rdi, %rax
addq	%rdi, %rdx
movq	%r8, %rsi
subq	%rdi, %rsi
jmp	L_1bfd
L_1b85:
movq	%r15, %r12
movq	%rsi, %rax
movq	%r13, %rcx
L_1b8e:
movq	%rcx, %rdx
andq	$0x7, %rdx
je	L_1c8b
xorl	%esi, %esi
L_1b9d:
movzbl	(%rax,%rsi), %r8d
movb	%r8b, (%r12,%rsi)
incq	%rsi
cmpq	%rsi, %rdx
jne	L_1b9d
addq	%rsi, %r12
addq	%rsi, %rax
movq	%rcx, %rdx
subq	%rsi, %rdx
jmp	L_1c8e
L_1bbf:
movq	%r12, %rcx
movq	%r15, %rsi
L_1bc5:
movq	%rsi, %rdx
andq	$0x7, %rdx
je	L_1cfc
xorl	%r8d, %r8d
L_1bd5:
movzbl	(%rax,%r8), %r9d
movb	%r9b, (%rcx,%r8)
incq	%r8
cmpq	%r8, %rdx
jne	L_1bd5
addq	%r8, %rcx
addq	%r8, %rax
movq	%rsi, %rdx
subq	%r8, %rdx
movq	%rcx, %r12
jmp	L_1cff
L_1bfa:
movq	%r8, %rsi
L_1bfd:
decq	%r8
cmpq	$0x7, %r8
movq	%rcx, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
jb	L_1626
xorl	%edi, %edi
L_1c18:
movzbl	(%rdx,%rdi), %r8d
movb	%r8b, (%rax,%rdi)
movzbl	0x1(%rdx,%rdi), %r8d
movb	%r8b, 0x1(%rax,%rdi)
movzbl	0x2(%rdx,%rdi), %r8d
movb	%r8b, 0x2(%rax,%rdi)
movzbl	0x3(%rdx,%rdi), %r8d
movb	%r8b, 0x3(%rax,%rdi)
movzbl	0x4(%rdx,%rdi), %r8d
movb	%r8b, 0x4(%rax,%rdi)
movzbl	0x5(%rdx,%rdi), %r8d
movb	%r8b, 0x5(%rax,%rdi)
movzbl	0x6(%rdx,%rdi), %r8d
movb	%r8b, 0x6(%rax,%rdi)
movzbl	0x7(%rdx,%rdi), %r8d
movb	%r8b, 0x7(%rax,%rdi)
addq	$0x8, %rdi
cmpq	%rdi, %rsi
jne	L_1c18
addq	%rdi, %rax
L_1c7a:
movq	%rcx, %rdi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
jmp	L_1626
L_1c8b:
movq	%rcx, %rdx
L_1c8e:
decq	%rcx
cmpq	$0x7, %rcx
jb	L_1233
xorl	%ecx, %ecx
L_1c9d:
movzbl	(%rax,%rcx), %esi
movb	%sil, (%r12,%rcx)
movzbl	0x1(%rax,%rcx), %esi
movb	%sil, 0x1(%r12,%rcx)
movzbl	0x2(%rax,%rcx), %esi
movb	%sil, 0x2(%r12,%rcx)
movzbl	0x3(%rax,%rcx), %esi
movb	%sil, 0x3(%r12,%rcx)
movzbl	0x4(%rax,%rcx), %esi
movb	%sil, 0x4(%r12,%rcx)
movzbl	0x5(%rax,%rcx), %esi
movb	%sil, 0x5(%r12,%rcx)
movzbl	0x6(%rax,%rcx), %esi
movb	%sil, 0x6(%r12,%rcx)
movzbl	0x7(%rax,%rcx), %esi
movb	%sil, 0x7(%r12,%rcx)
addq	$0x8, %rcx
cmpq	%rcx, %rdx
jne	L_1c9d
addq	%rcx, %r12
jmp	L_1233
L_1cfc:
movq	%rsi, %rdx
L_1cff:
decq	%rsi
cmpq	$0x7, %rsi
jb	L_1233
xorl	%esi, %esi
L_1d0e:
movzbl	(%rax,%rsi), %r8d
movb	%r8b, (%rcx,%rsi)
movzbl	0x1(%rax,%rsi), %r8d
movb	%r8b, 0x1(%rcx,%rsi)
movzbl	0x2(%rax,%rsi), %r8d
movb	%r8b, 0x2(%rcx,%rsi)
movzbl	0x3(%rax,%rsi), %r8d
movb	%r8b, 0x3(%rcx,%rsi)
movzbl	0x4(%rax,%rsi), %r8d
movb	%r8b, 0x4(%rcx,%rsi)
movzbl	0x5(%rax,%rsi), %r8d
movb	%r8b, 0x5(%rcx,%rsi)
movzbl	0x6(%rax,%rsi), %r8d
movb	%r8b, 0x6(%rcx,%rsi)
movzbl	0x7(%rax,%rsi), %r8d
movb	%r8b, 0x7(%rcx,%rsi)
addq	$0x8, %rsi
cmpq	%rsi, %rdx
jne	L_1d0e
addq	%rsi, %rcx
movq	%rcx, %r12
jmp	L_1233
L_1d78:
movq	%rcx, %rdx
L_1d7b:
decq	%rcx
cmpq	$0x7, %rcx
jb	L_1e37
xorl	%ecx, %ecx
L_1d8a:
movzbl	(%rsi,%rcx), %r8d
movb	%r8b, (%rax,%rcx)
movzbl	0x1(%rsi,%rcx), %r8d
movb	%r8b, 0x1(%rax,%rcx)
movzbl	0x2(%rsi,%rcx), %r8d
movb	%r8b, 0x2(%rax,%rcx)
movzbl	0x3(%rsi,%rcx), %r8d
movb	%r8b, 0x3(%rax,%rcx)
movzbl	0x4(%rsi,%rcx), %r8d
movb	%r8b, 0x4(%rax,%rcx)
movzbl	0x5(%rsi,%rcx), %r8d
movb	%r8b, 0x5(%rax,%rcx)
movzbl	0x6(%rsi,%rcx), %r8d
movb	%r8b, 0x6(%rax,%rcx)
movzbl	0x7(%rsi,%rcx), %r8d
movb	%r8b, 0x7(%rax,%rcx)
addq	$0x8, %rcx
cmpq	%rcx, %rdx
jne	L_1d8a
addq	%rcx, %rax
jmp	L_1e34
L_1dee:
movl	%r12d, %r8d
andl	$-0x20, %r8d
leaq	(%r15,%r8), %rax
addq	%r8, %rsi
movl	%r12d, %ecx
andl	$0x1f, %ecx
addq	0x78(%rsp), %rdx
xorl	%r9d, %r9d
L_1e0a:
movdqu	-0x10(%rdx,%r9), %xmm0
movups	(%rdx,%r9), %xmm1
movdqu	%xmm0, (%r15,%r9)
movups	%xmm1, 0x10(%r15,%r9)
addq	$0x20, %r9
cmpq	%r9, %r8
jne	L_1e0a
cmpq	%r8, %r12
jne	L_1b09
L_1e34:
movq	%rax, %r15
L_1e37:
movl	0x18(%rsp), %eax
movq	0x38(%rsp), %rsi
movq	0x8(%rsp), %r11
movq	(%rsp), %r10
movl	0x1c(%rsp), %r8d
jmp	L_6f1
L_1e53:
testb	$0x20, %cl
jne	L_1e6d
movl	$0x3f51, 0x8(%r11)
leaq	.L.str.2(%rip), %rax
movq	%rax, 0x30(%rdi)
jmp	L_1e75
L_1e6d:
movl	$0x3f3f, 0x8(%r11)
L_1e75:
movq	%r13, %r14
jmp	L_1e8d
L_1e7a:
movl	$0x3f51, 0x8(%r11)
leaq	.L.str.1(%rip), %rax
L_1e89:
movq	%rax, 0x30(%rdi)
L_1e8d:
movq	%r15, %r12
L_1e90:
movl	%ebx, %eax
shrl	$0x3, %eax
subq	%rax, %r10
movq	%r10, (%rdi)
movq	%r12, 0x18(%rdi)
movq	0x70(%rsp), %rdx
subl	%r10d, %edx
addl	$0xe, %edx
andl	$0x7, %ebx
movl	$0xffffffff, %eax
movl	%ebx, %ecx
shll	%cl, %eax
movl	%edx, 0x8(%rdi)
movq	0x68(%rsp), %rcx
subl	%r12d, %ecx
notl	%eax
andl	%eax, %r14d
addl	$0x103, %ecx
movl	%ecx, 0x20(%rdi)
movq	%r14, 0x58(%r11)
movl	%ebx, 0x60(%r11)
addq	$0x98, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
L_1ee9:
movl	$0x3f51, 0x8(%r11)
leaq	.L.str(%rip), %rax
jmp	L_1e89
	.section .rodata
bums_jump_table_rodata_0:
	.size bums_jump_table_rodata_0, 32
	.long L_6bf - bums_jump_table_rodata_0
	.long L_12a1 - bums_jump_table_rodata_0
	.long L_12ce - bums_jump_table_rodata_0
	.long L_1299 - bums_jump_table_rodata_0
	.long L_12ce - bums_jump_table_rodata_0
	.long L_12ce - bums_jump_table_rodata_0
	.long L_12ce - bums_jump_table_rodata_0
	.long L_12b6 - bums_jump_table_rodata_0
perm_idx_lut:
	.size perm_idx_lut, 52
	.byte 0,0,1,0,0,0,0,0,32,0,1,0,64,0,4,0
	.byte 96,0,2,0,0,0,0,0,128,0,7,0,160,0,6,0
	.byte 192,0,5,0,224,0,4,0,0,1,3,0,32,1,2,0
	.byte 64,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
permute_table:
	.size permute_table, 832
	.byte 0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0
	.byte 1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1
	.byte 0,1,2,3,4,0,1,2,3,4,0,1,2,3,4,0
	.byte 1,2,3,4,0,1,2,3,4,0,1,2,3,4,0,1
	.byte 0,1,2,3,4,5,0,1,2,3,4,5,0,1,2,3
	.byte 4,5,0,1,2,3,4,5,0,1,2,3,4,5,0,1
	.byte 0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1
	.byte 2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3
	.byte 0,1,2,3,4,5,6,7,8,0,1,2,3,4,5,6
	.byte 7,8,0,1,2,3,4,5,6,7,8,0,1,2,3,4
	.byte 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5
	.byte 6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1
	.byte 0,1,2,3,4,5,6,7,8,9,10,0,1,2,3,4
	.byte 5,6,7,8,9,10,0,1,2,3,4,5,6,7,8,9
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,0,1,2,3
	.byte 4,5,6,7,8,9,10,11,0,1,2,3,4,5,6,7
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,0,1,2
	.byte 3,4,5,6,7,8,9,10,11,12,0,1,2,3,4,5
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,0,1
	.byte 2,3,4,5,6,7,8,9,10,11,12,13,0,1,2,3
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,0
	.byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,0,1
	.byte 16,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14
	.byte 16,17,0,1,2,3,4,5,6,7,8,9,10,11,12,13
	.byte 16,17,18,0,1,2,3,4,5,6,7,8,9,10,11,12
	.byte 16,17,18,19,0,1,2,3,4,5,6,7,8,9,10,11
	.byte 16,17,18,19,20,0,1,2,3,4,5,6,7,8,9,10
	.byte 16,17,18,19,20,21,0,1,2,3,4,5,6,7,8,9
	.byte 16,17,18,19,20,21,22,0,1,2,3,4,5,6,7,8
	.byte 16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7
	.byte 16,17,18,19,20,21,22,23,24,0,1,2,3,4,5,6
	.byte 16,17,18,19,20,21,22,23,24,25,0,1,2,3,4,5
	.byte 16,17,18,19,20,21,22,23,24,25,26,0,1,2,3,4
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,0,1,2,3
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,28,0,1,2
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,28,29,0,1
	.byte 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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

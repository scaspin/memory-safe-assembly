	.text
chunkmemset_safe_avx2:
movl	%edx, %r8d
cmpl	%ecx, %edx
movl	%ecx, %edx
cmovbl	%r8d, %edx
cmpl	$0x1f, %ecx
jbe	L_1a
testl	%r8d, %r8d
je	L_45
jmp	chunkmemset_avx2
L_1a:
testl	%edx, %edx
je	L_45
cmpl	%r8d, %ecx
cmovbl	%ecx, %r8d
cmpl	$0x8, %r8d
setb	%al
movq	%rdi, %rcx
subq	%rsi, %rcx
cmpq	$0x8, %rcx
setb	%cl
orb	%al, %cl
je	L_49
movq	%rsi, %rcx
movq	%rdi, %rax
jmp	L_78
L_45:
movq	%rdi, %rax
retq
L_49:
movl	%r8d, %r9d
andl	$0x18, %r9d
subl	%r9d, %edx
leaq	(%rsi,%r9), %rcx
leaq	(%rdi,%r9), %rax
xorl	%r10d, %r10d
L_5e:
movq	(%rsi,%r10), %r11
movq	%r11, (%rdi,%r10)
addq	$0x8, %r10
cmpq	%r10, %r9
jne	L_5e
cmpl	%r8d, %r9d
je	L_104
L_78:
leal	-0x1(%rdx), %esi
testb	$0x7, %dl
je	L_a2
movl	%edx, %r8d
andl	$0x7, %r8d
xorl	%edi, %edi
L_89:
movzbl	(%rcx,%rdi), %r9d
movb	%r9b, (%rax,%rdi)
incq	%rdi
cmpl	%edi, %r8d
jne	L_89
subl	%edi, %edx
addq	%rdi, %rcx
addq	%rdi, %rax
L_a2:
cmpl	$0x7, %esi
jb	L_104
movl	%edx, %esi
xorl	%edx, %edx
L_ab:
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
cmpl	%edx, %esi
jne	L_ab
addq	%rdx, %rax
L_104:
retq
nopw	%cs:(%rax,%rax)
chunkmemset_avx2:
pushq	%rbp
movq	%rsp, %rbp
pushq	%r14
pushq	%rbx
andq	$-0x20, %rsp
subq	$0x20, %rsp
movq	%rdi, %rbx
movq	%rdi, %rcx
subq	%rsi, %rcx
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
testq	%rcx, %rcx
jns	L_14c
movl	%edx, %r14d
cmpq	%r14, %rax
jae	L_14c
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memmove
jmp	L_163
L_14c:
cmpq	$0x1, %rax
jne	L_175
movl	%edx, %r14d
movzbl	(%rsi), %esi
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memset
L_163:
addq	%r14, %rbx
L_166:
movq	%rbx, %rax
leaq	-0x10(%rbp), %rsp
popq	%rbx
popq	%r14
popq	%rbp
vzeroupper
retq
L_175:
cmpq	$0x20, %rax
jb	L_1b7
leal	-0x1(%rdx), %eax
andl	$0x1f, %eax
vmovdqu	(%rsi), %ymm0
vmovdqu	%ymm0, (%rbx)
movl	%eax, %ecx
notl	%ecx
addl	%edx, %ecx
je	L_204
incq	%rax
movl	%edx, %ecx
nopw	%cs:(%rax,%rax)
L_1a0:
vmovdqu	(%rsi,%rax), %ymm0
vmovdqu	%ymm0, (%rbx,%rax)
addq	$0x20, %rax
cmpl	%eax, %ecx
jne	L_1a0
L_1b2:
addq	%rax, %rbx
jmp	L_166
L_1b7:
cmpl	$0x10, %edx
ja	L_267
cmpq	$0x10, %rax
jb	L_20f
leal	-0x1(%rdx), %eax
andl	$0xf, %eax
vmovdqu	(%rsi), %xmm0
vmovdqu	%xmm0, (%rbx)
movl	%eax, %ecx
notl	%ecx
addl	%edx, %ecx
je	L_204
incq	%rax
movl	%edx, %ecx
nopw	%cs:(%rax,%rax)
L_1f0:
vmovdqu	(%rsi,%rax), %xmm0
vmovdqu	%xmm0, (%rbx,%rax)
addq	$0x10, %rax
cmpl	%eax, %ecx
jne	L_1f0
jmp	L_1b2
L_204:
addq	%rax, %rbx
incq	%rbx
jmp	L_166
L_20f:
testb	$0x1, %al
sete	%cl
cmpq	$0x6, %rax
setne	%dil
testb	%cl, %dil
jne	L_267
movl	$0xfffffffd, %ecx
addl	%ecx, %eax
leaq	perm_idx_lut(%rip), %rcx
movzwl	(%rcx,%rax,4), %eax
vmovdqu	(%rsi), %xmm0
leaq	permute_table(%rip), %rcx
vpshufb	(%rax,%rcx), %xmm0, %xmm0
cmpl	$0x10, %edx
jne	L_253
vmovdqu	%xmm0, (%rbx)
addq	$0x10, %rbx
xorl	%edx, %edx
L_253:
vpxor	%xmm1, %xmm1, %xmm1
vmovdqa	%xmm1, 0x10(%rsp)
vmovdqa	%xmm0, (%rsp)
jmp	L_2f3
L_267:
leaq	-0x2(%rax), %rcx
rorxq	$0x1, %rcx, %rcx
cmpq	$0x7, %rcx
ja	L_314
leaq	bums_jump_table_rodata_0(%rip), %rdi
movslq	(%rdi,%rcx,4), %rcx
addq	%rdi, %rcx
jmpq	*%rcx
L_28b:
vpbroadcastw	(%rsi), %ymm0
jmp	L_2a5
L_292:
vpbroadcastq	(%rsi), %ymm0
jmp	L_2a5
L_299:
vpbroadcastd	(%rsi), %ymm0
jmp	L_2a5
L_2a0:
vbroadcasti128	(%rsi), %ymm0
L_2a5:
vmovdqa	%ymm0, (%rsp)
movl	$0x20, %eax
L_2af:
movl	%eax, %ecx
cmpl	$0x40, %edx
jb	L_2d3
leal	(%rax,%rax), %esi
nopl	(%rax)
L_2c0:
vmovdqu	%ymm0, (%rbx)
vmovdqu	%ymm0, (%rbx,%rcx)
addq	%rsi, %rbx
subl	%esi, %edx
cmpl	$0x3f, %edx
ja	L_2c0
L_2d3:
cmpl	$0x20, %edx
jb	L_2f3
nopl	(%rax,%rax)
L_2e0:
vmovdqa	(%rsp), %ymm0
vmovdqu	%ymm0, (%rbx)
subl	%eax, %edx
addq	%rcx, %rbx
cmpl	$0x1f, %edx
ja	L_2e0
L_2f3:
testl	%edx, %edx
je	L_166
movl	%edx, %r14d
movq	%rsp, %rsi
movq	%rbx, %rdi
movq	%r14, %rdx
vzeroupper
callq	memcpy
jmp	L_163
L_314:
movl	$0xfffffffd, %ecx
addl	%eax, %ecx
leaq	perm_idx_lut(%rip), %r8
movzwl	(%r8,%rcx,4), %edi
movzwl	0x2(%r8,%rcx,4), %ecx
cmpq	$0xf, %rax
ja	L_353
leaq	permute_table(%rip), %rax
vmovdqa	(%rdi,%rax), %ymm0
vpaddb	.LCPI1_1(%rip), %ymm0, %ymm0
vbroadcasti128	(%rsi), %ymm1
vpshufb	%ymm0, %ymm1, %ymm0
jmp	L_37d
L_353:
vmovdqu	(%rsi), %xmm0
leaq	permute_table(%rip), %rax
vmovdqa	(%rdi,%rax), %xmm1
vpcmpgtb	.LCPI1_0(%rip), %xmm1, %xmm2
vpshufb	%xmm1, %xmm0, %xmm1
vpblendvb	%xmm2, 0x10(%rsi), %xmm1, %xmm1
vinserti128	$0x1, %xmm1, %ymm0, %ymm0
L_37d:
vmovdqa	%ymm0, (%rsp)
movl	$0x20, %eax
subl	%ecx, %eax
jmp	L_2af
nop
inflate_fast_avx2:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x88, %rsp
movq	%rdi, %r15
movq	0x38(%rdi), %rbp
movq	(%rdi), %r8
movl	0x8(%rdi), %r11d
addl	$-0xe, %r11d
movq	0x18(%rdi), %r14
movl	0x20(%rdi), %r9d
subl	%r9d, %esi
movq	%r14, %rax
subq	%rsi, %rax
movq	%rax, 0x70(%rsp)
leal	-0x103(%r9), %edi
movl	0x40(%rbp), %esi
movq	0x50(%rbp), %r10
movzbl	0x64(%rbp), %eax
movl	$0xffffffff, %ecx
shlxl	%eax, %ecx, %eax
notl	%eax
movzbl	0x78(%rbp), %edx
shlxl	%edx, %ecx, %ecx
notl	%ecx
movl	%esi, 0x50(%rsp)
testl	%esi, %esi
sete	%dl
cmpq	%r10, %r14
setb	%sil
orb	%dl, %sil
je	L_411
movl	$0x0, 0x3c(%rsp)
jmp	L_428
L_411:
leaq	0x104(%r14), %rdx
movl	0x44(%rbp), %esi
addq	%r10, %rsi
cmpq	%rsi, %rdx
setbe	%dl
movl	%edx, 0x3c(%rsp)
L_428:
addq	%r8, %r11
addq	%r14, %rdi
movq	%rdi, 0x58(%rsp)
addq	%r14, %r9
movq	%r9, 0x40(%rsp)
movl	0x48(%rbp), %edx
movl	%edx, 0x54(%rsp)
movl	0x4c(%rbp), %edx
movl	%edx, 0x2c(%rsp)
movq	0x58(%rbp), %r12
movl	0x60(%rbp), %r13d
movq	0x68(%rbp), %rbx
movq	0x70(%rbp), %rdx
movq	%rdx, 0x80(%rsp)
movl	%eax, %esi
movl	%ecx, %eax
movq	%rax, 0x78(%rsp)
movq	%r10, 0x30(%rsp)
leaq	0x60(%r10), %rax
movq	%rax, 0x68(%rsp)
movq	%r11, 0x10(%rsp)
movq	%rsi, 0x18(%rsp)
L_482:
shlxq	%r13, (%r8), %rdx
orq	%r12, %rdx
movl	%r13d, %eax
shrl	$0x3, %eax
andl	$0x7, %eax
subq	%rax, %r8
addq	$0x7, %r8
orl	$0x38, %r13d
movl	%edx, %ecx
andl	%esi, %ecx
leaq	(%rbx,%rcx,4), %rax
movzbl	(%rbx,%rcx,4), %ecx
testb	%cl, %cl
jne	L_4d8
movzbl	0x2(%rax), %ecx
movb	%cl, (%r14)
movzbl	0x1(%rax), %eax
shrxq	%rax, %rdx, %rdx
subl	%eax, %r13d
movl	%edx, %ecx
andl	%esi, %ecx
leaq	(%rbx,%rcx,4), %rax
movzbl	(%rbx,%rcx,4), %ecx
testb	%cl, %cl
je	L_6c1
incq	%r14
L_4d8:
movzbl	0x1(%rax), %esi
shrxq	%rsi, %rdx, %r12
subl	%esi, %r13d
movq	%r14, %rdi
L_4e7:
movq	0x80(%rsp), %r14
nop
L_4f0:
testb	$0x10, %cl
jne	L_540
testb	$0x40, %cl
jne	L_1924
movzwl	0x2(%rax), %eax
leaq	(%rbx,%rax,4), %rdx
bzhil	%ecx, %r12d, %ecx
leaq	(%rdx,%rcx,4), %rax
movzbl	0x1(%rdx,%rcx,4), %esi
shrxq	%rsi, %r12, %r12
subl	%esi, %r13d
movzbl	(%rdx,%rcx,4), %ecx
testb	%cl, %cl
jne	L_4f0
L_524:
movzbl	0x2(%rax), %eax
movb	%al, (%rdi)
incq	%rdi
L_52d:
movq	%rdi, %r14
jmp	L_13f5
nopw	%cs:(%rax,%rax)
L_540:
movzbl	%cl, %ecx
andl	$0xf, %ecx
shrxq	%rcx, %r12, %rdx
subl	%ecx, %r13d
cmpl	$0x1b, %r13d
ja	L_577
movq	%r8, %r9
shlxq	%r13, (%r8), %r8
orq	%rdx, %r8
movl	%r13d, %esi
shrl	$0x3, %esi
subq	%rsi, %r9
addq	$0x7, %r9
movq	%r9, 0x8(%rsp)
orl	$0x38, %r13d
jmp	L_57f
L_577:
movq	%r8, 0x8(%rsp)
movq	%rdx, %r8
L_57f:
movzwl	0x2(%rax), %esi
andl	0x78(%rsp), %edx
leaq	(%r14,%rdx,4), %r9
movzbl	0x1(%r9), %eax
shrxq	%rax, %r8, %rdx
subl	%eax, %r13d
movzbl	(%r9), %r8d
testb	$0x10, %r8b
jne	L_5e5
nopw	%cs:(%rax,%rax)
L_5b0:
testb	$0x40, %r8b
jne	L_1949
movzwl	0x2(%r9), %eax
leaq	(%r14,%rax,4), %rax
bzhil	%r8d, %edx, %r8d
leaq	(%rax,%r8,4), %r9
movzbl	0x1(%rax,%r8,4), %r10d
shrxq	%r10, %rdx, %rdx
subl	%r10d, %r13d
movzbl	(%rax,%r8,4), %r8d
testb	$0x10, %r8b
je	L_5b0
L_5e5:
movq	%r15, 0x20(%rsp)
bzhil	%ecx, %r12d, %eax
addq	%rsi, %rax
movzwl	0x2(%r9), %ecx
andl	$0xf, %r8d
bzhil	%r8d, %edx, %r15d
addq	%rcx, %r15
shrxq	%r8, %rdx, %r12
subl	%r8d, %r13d
movl	%edi, %edx
subl	0x70(%rsp), %edx
movl	%r15d, %ecx
subl	%edx, %ecx
jbe	L_704
cmpl	0x54(%rsp), %ecx
movq	0x8(%rsp), %r8
ja	L_19b9
movl	0x2c(%rsp), %edx
testl	%edx, %edx
movq	%rbp, 0x48(%rsp)
je	L_78f
movl	%edx, %esi
subl	%ecx, %esi
jae	L_795
subl	%edx, %ecx
movl	0x50(%rsp), %r8d
subl	%ecx, %r8d
movq	0x30(%rsp), %rdx
leaq	(%rdx,%r8), %rsi
movl	%eax, %ebp
subl	%ecx, %ebp
jbe	L_a6c
movl	%ecx, %edx
cmpq	%rsi, %rdi
je	L_a5e
movq	0x40(%rsp), %r9
movq	%r9, %rcx
subq	%rdi, %rcx
cmpq	%rcx, %rdx
cmovaeq	%rcx, %rdx
subq	%rsi, %r9
movq	%r9, %rax
negq	%rax
cmovsq	%r9, %rax
cmpq	$0x20, %rcx
jb	L_15d1
cmpq	$0x1f, %rax
jbe	L_15d1
vzeroupper
callq	chunkmemset_avx2
movq	%rax, %rdi
L_6ac:
movl	%ebp, %eax
L_6ae:
movl	0x2c(%rsp), %ecx
movq	0x30(%rsp), %rsi
movq	0x10(%rsp), %r11
jmp	L_a6c
L_6c1:
movzbl	0x2(%rax), %ecx
movb	%cl, 0x1(%r14)
addq	$0x2, %r14
movq	%rsi, %rcx
movzbl	0x1(%rax), %esi
shrxq	%rsi, %rdx, %rdx
movl	%edx, %edi
andl	%ecx, %edi
leaq	(%rbx,%rdi,4), %rax
movzbl	(%rbx,%rdi,4), %ecx
movzbl	0x1(%rbx,%rdi,4), %edi
shrxq	%rdi, %rdx, %r12
addl	%edi, %esi
subl	%esi, %r13d
movq	%r14, %rdi
testb	%cl, %cl
jne	L_4e7
jmp	L_524
L_704:
cmpb	$0x0, 0x3c(%rsp)
je	L_75a
movq	%r15, %rcx
negq	%rcx
movq	%rdi, %rsi
subq	%r15, %rsi
movq	0x40(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
testq	%r15, %r15
sete	%al
leaq	(%rdi,%rdx), %r14
cmpq	%rcx, %rdx
setg	%cl
testb	%cl, %al
jne	L_79f
leaq	(%rsi,%rdx), %rax
cmpq	%rax, %rdi
jb	L_79f
vzeroupper
callq	memcpy
movq	0x10(%rsp), %r11
movq	0x20(%rsp), %r15
jmp	L_13f0
L_75a:
movq	%rdi, %rsi
subq	%r15, %rsi
cmpl	%r15d, %eax
jbe	L_a0f
cmpl	$0x20, %r15d
jae	L_a0f
movl	%eax, %edx
vzeroupper
callq	chunkmemset_avx2
movq	0x10(%rsp), %r11
movq	%rax, %r14
movq	0x20(%rsp), %r15
jmp	L_13f0
L_78f:
movl	0x50(%rsp), %esi
subl	%ecx, %esi
L_795:
addq	0x30(%rsp), %rsi
jmp	L_a71
L_79f:
testq	%r15, %r15
movq	0x8(%rsp), %r8
je	L_10b7
testq	%rdx, %rdx
jne	L_7d3
L_7b2:
movq	%rdi, %r14
jmp	L_10b7
nopw	(%rax,%rax)
L_7c0:
movq	%rsi, %r8
movq	%r10, %rdi
L_7c6:
movq	%r8, %rsi
subq	%rax, %rdx
movq	0x8(%rsp), %r8
je	L_7b2
L_7d3:
cmpq	%rdx, %r15
movq	%rdx, %rax
cmovbq	%r15, %rax
cmpq	$0x10, %rax
jb	L_800
leaq	-0x10(%rax), %r8
movl	%r8d, %ecx
notl	%ecx
testb	$0x30, %cl
jne	L_810
movq	%rax, %rcx
jmp	L_845
nopw	%cs:(%rax,%rax)
L_800:
movq	%rax, %rcx
jmp	L_888
nopl	(%rax,%rax)
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
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r9
jne	L_830
L_845:
cmpq	$0x30, %r8
jb	L_888
nopl	(%rax,%rax)
L_850:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
vmovups	0x10(%rsi), %xmm0
vmovups	%xmm0, 0x10(%rdi)
vmovups	0x20(%rsi), %xmm0
vmovups	%xmm0, 0x20(%rdi)
vmovups	0x30(%rsi), %xmm0
vmovups	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %rcx
cmpq	$0xf, %rcx
ja	L_850
L_888:
cmpq	$0x8, %rcx
jb	L_8a0
movq	(%rsi), %r8
movq	%r8, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %rcx
L_8a0:
cmpq	$0x4, %rcx
jb	L_8b8
movl	(%rsi), %r8d
movl	%r8d, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %rcx
L_8b8:
movq	%rdi, %r10
testq	%rcx, %rcx
je	L_7c0
cmpq	$0x80, %rcx
jb	L_950
movq	%r10, %rdi
subq	%rsi, %rdi
cmpq	$0x80, %rdi
jb	L_950
movq	%rcx, %r11
andq	$-0x80, %r11
movl	%ecx, %r9d
andl	$0x7f, %r9d
leaq	(%r10,%r11), %rdi
leaq	(%rsi,%r11), %r8
xorl	%r14d, %r14d
nopl	(%rax)
L_900:
vmovups	(%rsi,%r14), %ymm0
vmovups	0x20(%rsi,%r14), %ymm1
vmovups	0x40(%rsi,%r14), %ymm2
vmovups	0x60(%rsi,%r14), %ymm3
vmovups	%ymm0, (%r10,%r14)
vmovups	%ymm1, 0x20(%r10,%r14)
vmovups	%ymm2, 0x40(%r10,%r14)
vmovups	%ymm3, 0x60(%r10,%r14)
subq	$-0x80, %r14
cmpq	%r14, %r11
jne	L_900
cmpq	%r11, %rcx
movq	0x10(%rsp), %r11
je	L_7c6
jmp	L_959
nop
L_950:
movq	%rcx, %r9
movq	%r10, %rdi
movq	%rsi, %r8
L_959:
movq	%r9, %rcx
andq	$0x7, %rcx
je	L_98f
xorl	%esi, %esi
nopw	%cs:(%rax,%rax)
L_970:
movzbl	(%r8,%rsi), %r10d
movb	%r10b, (%rdi,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_970
movq	%r9, %rcx
subq	%rsi, %rcx
addq	%rsi, %rdi
addq	%rsi, %r8
jmp	L_992
L_98f:
movq	%r9, %rcx
L_992:
movq	%rdi, %rsi
movq	%r8, %r10
decq	%r9
cmpq	$0x7, %r9
jb	L_7c6
nopw	%cs:(%rax,%rax)
L_9b0:
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
jne	L_9b0
jmp	L_7c6
L_a0f:
leal	-0x1(%rax), %ecx
andl	$0x1f, %ecx
vmovups	(%rsi), %ymm0
vmovups	%ymm0, (%rdi)
leaq	(%rcx,%rdi), %r14
incq	%r14
notl	%ecx
addl	%eax, %ecx
movq	0x8(%rsp), %r8
je	L_10b7
negq	%r15
movq	0x18(%rsp), %rsi
nopl	(%rax,%rax)
L_a40:
vmovups	(%r14,%r15), %ymm0
vmovups	%ymm0, (%r14)
addq	$0x20, %r14
addl	$-0x20, %ecx
jne	L_a40
movq	0x20(%rsp), %r15
jmp	L_13fa
L_a5e:
addq	%rdx, %rdi
movl	%ebp, %eax
movl	0x2c(%rsp), %ecx
movq	0x30(%rsp), %rsi
L_a6c:
movq	0x8(%rsp), %r8
L_a71:
movl	%eax, %ebp
subl	%ecx, %ebp
jbe	L_ad8
movl	%ecx, %ecx
cmpb	$0x0, 0x3c(%rsp)
je	L_b43
movq	0x40(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rcx
cmovbq	%rcx, %rdx
movq	%rsi, %rcx
subq	%rdi, %rcx
setae	%r9b
leaq	(%rdi,%rdx), %r14
cmpq	%r14, %rsi
setb	%r10b
cmpq	%rsi, %rdi
setae	%al
leaq	(%rsi,%rdx), %r8
cmpq	%r8, %rdi
setb	%r8b
testb	%r10b, %r9b
jne	L_bf1
andb	%r8b, %al
jne	L_bf1
vzeroupper
callq	memcpy
jmp	L_c11
L_ad8:
movl	%eax, %eax
cmpb	$0x0, 0x3c(%rsp)
je	L_b96
movq	0x40(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
movq	%rsi, %rcx
subq	%rdi, %rcx
setae	%r9b
leaq	(%rdi,%rdx), %r14
cmpq	%r14, %rsi
setb	%r10b
cmpq	%rsi, %rdi
setae	%al
leaq	(%rsi,%rdx), %r8
cmpq	%r8, %rdi
setb	%r8b
testb	%r10b, %r9b
movq	0x48(%rsp), %rbp
movq	0x20(%rsp), %r15
jne	L_10c1
andb	%r8b, %al
jne	L_10c1
vzeroupper
callq	memcpy
jmp	L_13eb
L_b43:
movq	%rdi, %rax
subq	%rsi, %rax
je	L_133b
movq	0x40(%rsp), %r9
movq	%r9, %r8
subq	%rdi, %r8
cmpq	%r8, %rcx
cmovaeq	%r8, %rcx
subq	%rsi, %r9
movq	%r9, %rdx
negq	%rdx
cmovsq	%r9, %rdx
cmpq	$0x20, %r8
jb	L_142a
cmpq	$0x1f, %rdx
jbe	L_142a
movl	%ecx, %edx
vzeroupper
callq	chunkmemset_avx2
L_b8c:
movq	0x10(%rsp), %r11
jmp	L_1341
L_b96:
movq	%rdi, %rcx
subq	%rsi, %rcx
movq	0x48(%rsp), %rbp
movq	0x20(%rsp), %r15
je	L_1413
movq	0x40(%rsp), %r9
movq	%r9, %r8
subq	%rdi, %r8
cmpq	%r8, %rax
cmovaeq	%r8, %rax
subq	%rsi, %r9
movq	%r9, %rdx
negq	%rdx
cmovsq	%r9, %rdx
cmpq	$0x20, %r8
jb	L_14b7
cmpq	$0x1f, %rdx
jbe	L_14b7
movl	%eax, %edx
vzeroupper
callq	chunkmemset_avx2
movq	%rax, %r14
jmp	L_13eb
L_bf1:
cmpq	%rsi, %rdi
je	L_c11
movq	%rcx, %r11
negq	%r11
cmovsq	%rcx, %r11
movq	%rdi, %r14
testq	%rdx, %rdx
movq	%r11, 0x60(%rsp)
jne	L_ea4
L_c11:
movq	%r14, %rsi
subq	%r15, %rsi
movl	%ebp, %eax
movq	0x40(%rsp), %rdx
subq	%r14, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
leaq	(%rsi,%rdx), %rax
cmpq	%rax, %r14
jae	L_131f
testq	%rdx, %rdx
movq	0x48(%rsp), %rbp
movq	0x10(%rsp), %r11
jmp	L_c5c
nopw	%cs:(%rax,%rax)
L_c50:
movq	%rsi, %rdi
movq	%r9, %r14
L_c56:
movq	%rdi, %rsi
subq	%rax, %rdx
L_c5c:
movq	0x8(%rsp), %r8
je	L_10b7
cmpq	%rdx, %r15
movq	%rdx, %rax
cmovbq	%r15, %rax
cmpq	$0x10, %rax
jb	L_c90
leaq	-0x10(%rax), %rdi
movl	%edi, %ecx
notl	%ecx
testb	$0x30, %cl
jne	L_c95
movq	%rax, %rcx
jmp	L_cc6
nopl	(%rax)
L_c90:
movq	%rax, %rcx
jmp	L_d0c
L_c95:
movl	%edi, %r8d
shrl	$0x4, %r8d
incl	%r8d
andl	$0x3, %r8d
movl	%r8d, %r9d
shll	$0x4, %r9d
movq	%rax, %rcx
subq	%r9, %rcx
L_cb0:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%r14)
addq	$0x10, %r14
addq	$0x10, %rsi
decq	%r8
jne	L_cb0
L_cc6:
cmpq	$0x30, %rdi
jb	L_d0c
nopl	(%rax)
L_cd0:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%r14)
vmovups	0x10(%rsi), %xmm0
vmovups	%xmm0, 0x10(%r14)
vmovups	0x20(%rsi), %xmm0
vmovups	%xmm0, 0x20(%r14)
vmovups	0x30(%rsi), %xmm0
vmovups	%xmm0, 0x30(%r14)
addq	$0x40, %r14
addq	$0x40, %rsi
addq	$-0x40, %rcx
cmpq	$0xf, %rcx
ja	L_cd0
L_d0c:
cmpq	$0x8, %rcx
jb	L_d24
movq	(%rsi), %rdi
movq	%rdi, (%r14)
addq	$0x8, %r14
addq	$0x8, %rsi
addq	$-0x8, %rcx
L_d24:
cmpq	$0x4, %rcx
jb	L_d3b
movl	(%rsi), %edi
movl	%edi, (%r14)
addq	$0x4, %r14
addq	$0x4, %rsi
addq	$-0x4, %rcx
L_d3b:
movq	%r14, %r9
testq	%rcx, %rcx
je	L_c50
cmpq	$0x80, %rcx
jb	L_dd0
movq	%r9, %rdi
subq	%rsi, %rdi
cmpq	$0x80, %rdi
jb	L_dd0
movq	%rcx, %r10
andq	$-0x80, %r10
movl	%ecx, %r8d
andl	$0x7f, %r8d
leaq	(%r9,%r10), %r14
leaq	(%rsi,%r10), %rdi
xorl	%r11d, %r11d
nopl	(%rax)
L_d80:
vmovups	(%rsi,%r11), %ymm0
vmovups	0x20(%rsi,%r11), %ymm1
vmovups	0x40(%rsi,%r11), %ymm2
vmovups	0x60(%rsi,%r11), %ymm3
vmovups	%ymm0, (%r9,%r11)
vmovups	%ymm1, 0x20(%r9,%r11)
vmovups	%ymm2, 0x40(%r9,%r11)
vmovups	%ymm3, 0x60(%r9,%r11)
subq	$-0x80, %r11
cmpq	%r11, %r10
jne	L_d80
cmpq	%r10, %rcx
movq	0x10(%rsp), %r11
je	L_c56
jmp	L_dd9
nop
L_dd0:
movq	%rcx, %r8
movq	%r9, %r14
movq	%rsi, %rdi
L_dd9:
movq	%r8, %rcx
andq	$0x7, %rcx
je	L_e0f
xorl	%esi, %esi
nopw	%cs:(%rax,%rax)
L_df0:
movzbl	(%rdi,%rsi), %r9d
movb	%r9b, (%r14,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_df0
movq	%r8, %rcx
subq	%rsi, %rcx
addq	%rsi, %r14
addq	%rsi, %rdi
jmp	L_e12
L_e0f:
movq	%r8, %rcx
L_e12:
movq	%r14, %rsi
movq	%rdi, %r9
decq	%r8
cmpq	$0x7, %r8
jb	L_c56
nopw	%cs:(%rax,%rax)
L_e30:
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
leaq	0x8(%rsi), %r14
movzbl	0x7(%r9), %r8d
movb	%r8b, 0x7(%rsi)
movq	%r14, %rsi
movq	%rdi, %r9
addq	$-0x8, %rcx
jne	L_e30
jmp	L_c56
L_e8f:
movq	%rsi, %r9
movq	%rdi, %r14
L_e95:
movq	%r14, %rdi
movq	%r9, %rsi
subq	%rcx, %rdx
je	L_c11
L_ea4:
cmpq	%rdx, %r11
movq	%rdx, %rcx
cmovbq	%r11, %rcx
cmpq	$0x10, %rcx
jb	L_ed0
leaq	-0x10(%rcx), %r9
movl	%r9d, %eax
notl	%eax
testb	$0x30, %al
jne	L_ed5
movq	%rcx, %r8
jmp	L_f05
nopw	%cs:(%rax,%rax)
L_ed0:
movq	%rcx, %r8
jmp	L_f48
L_ed5:
movl	%r9d, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x3, %r10d
movl	%r10d, %eax
shll	$0x4, %eax
movq	%rcx, %r8
subq	%rax, %r8
nop
L_ef0:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r10
jne	L_ef0
L_f05:
cmpq	$0x30, %r9
jb	L_f48
nopl	(%rax,%rax)
L_f10:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
vmovups	0x10(%rsi), %xmm0
vmovups	%xmm0, 0x10(%rdi)
vmovups	0x20(%rsi), %xmm0
vmovups	%xmm0, 0x20(%rdi)
vmovups	0x30(%rsi), %xmm0
vmovups	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %r8
cmpq	$0xf, %r8
ja	L_f10
L_f48:
cmpq	$0x8, %r8
jb	L_f70
movq	(%rsi), %rax
movq	%rax, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %r8
cmpq	$0x4, %r8
jae	L_f76
L_f66:
testq	%r8, %r8
jne	L_f8f
jmp	L_e8f
L_f70:
cmpq	$0x4, %r8
jb	L_f66
L_f76:
movl	(%rsi), %eax
movl	%eax, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %r8
testq	%r8, %r8
je	L_e8f
L_f8f:
cmpq	$0x80, %r8
jb	L_1007
movq	%rdi, %rax
subq	%rsi, %rax
cmpq	$0x80, %rax
jb	L_1007
movq	%r8, %r11
andq	$-0x80, %r11
movl	%r8d, %r10d
andl	$0x7f, %r10d
leaq	(%rdi,%r11), %r14
leaq	(%rsi,%r11), %r9
xorl	%eax, %eax
nop
L_fc0:
vmovups	(%rsi,%rax), %ymm0
vmovups	0x20(%rsi,%rax), %ymm1
vmovups	0x40(%rsi,%rax), %ymm2
vmovups	0x60(%rsi,%rax), %ymm3
vmovups	%ymm0, (%rdi,%rax)
vmovups	%ymm1, 0x20(%rdi,%rax)
vmovups	%ymm2, 0x40(%rdi,%rax)
vmovups	%ymm3, 0x60(%rdi,%rax)
subq	$-0x80, %rax
cmpq	%rax, %r11
jne	L_fc0
cmpq	%r11, %r8
movq	0x60(%rsp), %r11
je	L_e95
jmp	L_1010
L_1007:
movq	%r8, %r10
movq	%rdi, %r14
movq	%rsi, %r9
L_1010:
movq	%r10, %rax
andq	$0x7, %rax
je	L_103f
xorl	%edi, %edi
nopl	(%rax,%rax)
L_1020:
movzbl	(%r9,%rdi), %esi
movb	%sil, (%r14,%rdi)
incq	%rdi
cmpq	%rdi, %rax
jne	L_1020
movq	%r10, %rsi
subq	%rdi, %rsi
addq	%rdi, %r14
addq	%rdi, %r9
jmp	L_1042
L_103f:
movq	%r10, %rsi
L_1042:
movq	%r14, %rdi
movq	%r9, %r8
decq	%r10
cmpq	$0x7, %r10
jb	L_e95
nopw	%cs:(%rax,%rax)
L_1060:
movzbl	(%r8), %eax
movb	%al, (%rdi)
movzbl	0x1(%r8), %eax
movb	%al, 0x1(%rdi)
movzbl	0x2(%r8), %eax
movb	%al, 0x2(%rdi)
movzbl	0x3(%r8), %eax
movb	%al, 0x3(%rdi)
movzbl	0x4(%r8), %eax
movb	%al, 0x4(%rdi)
movzbl	0x5(%r8), %eax
movb	%al, 0x5(%rdi)
movzbl	0x6(%r8), %eax
movb	%al, 0x6(%rdi)
leaq	0x8(%r8), %r9
leaq	0x8(%rdi), %r14
movzbl	0x7(%r8), %eax
movb	%al, 0x7(%rdi)
movq	%r14, %rdi
movq	%r9, %r8
addq	$-0x8, %rsi
jne	L_1060
jmp	L_e95
L_10b7:
movq	0x20(%rsp), %r15
jmp	L_13f5
L_10c1:
cmpq	%rsi, %rdi
je	L_13f0
movq	%rcx, %rax
negq	%rax
cmovsq	%rcx, %rax
testq	%rdx, %rdx
jne	L_10f4
L_10d9:
movq	%rdi, %r14
jmp	L_13f0
L_10e1:
movq	%rsi, %r9
movq	%r11, %rdi
L_10e7:
movq	%r9, %rsi
subq	%rcx, %rdx
movq	0x10(%rsp), %r11
je	L_10d9
L_10f4:
cmpq	%rdx, %rax
movq	%rdx, %rcx
cmovbq	%rax, %rcx
cmpq	$0x10, %rcx
jb	L_1120
leaq	-0x10(%rcx), %r9
movl	%r9d, %r8d
notl	%r8d
testb	$0x30, %r8b
jne	L_1125
movq	%rcx, %r8
jmp	L_1155
nopl	(%rax)
L_1120:
movq	%rcx, %r8
jmp	L_1198
L_1125:
movl	%r9d, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x3, %r10d
movl	%r10d, %r11d
shll	$0x4, %r11d
movq	%rcx, %r8
subq	%r11, %r8
L_1140:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r10
jne	L_1140
L_1155:
cmpq	$0x30, %r9
jb	L_1198
nopl	(%rax,%rax)
L_1160:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
vmovups	0x10(%rsi), %xmm0
vmovups	%xmm0, 0x10(%rdi)
vmovups	0x20(%rsi), %xmm0
vmovups	%xmm0, 0x20(%rdi)
vmovups	0x30(%rsi), %xmm0
vmovups	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %r8
cmpq	$0xf, %r8
ja	L_1160
L_1198:
cmpq	$0x8, %r8
jb	L_11b0
movq	(%rsi), %r9
movq	%r9, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %r8
L_11b0:
cmpq	$0x4, %r8
jb	L_11c8
movl	(%rsi), %r9d
movl	%r9d, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %r8
L_11c8:
movq	%rdi, %r11
testq	%r8, %r8
je	L_10e1
cmpq	$0x80, %r8
jb	L_125f
movq	%r11, %rdi
subq	%rsi, %rdi
cmpq	$0x80, %rdi
jb	L_125f
movq	%r8, %r14
andq	$-0x80, %r14
movl	%r8d, %r10d
andl	$0x7f, %r10d
leaq	(%r11,%r14), %rdi
leaq	(%rsi,%r14), %r9
xorl	%r15d, %r15d
nopl	(%rax)
L_1210:
vmovups	(%rsi,%r15), %ymm0
vmovups	0x20(%rsi,%r15), %ymm1
vmovups	0x40(%rsi,%r15), %ymm2
vmovups	0x60(%rsi,%r15), %ymm3
vmovups	%ymm0, (%r11,%r15)
vmovups	%ymm1, 0x20(%r11,%r15)
vmovups	%ymm2, 0x40(%r11,%r15)
vmovups	%ymm3, 0x60(%r11,%r15)
subq	$-0x80, %r15
cmpq	%r15, %r14
jne	L_1210
cmpq	%r14, %r8
movq	0x20(%rsp), %r15
je	L_10e7
jmp	L_1268
L_125f:
movq	%r8, %r10
movq	%r11, %rdi
movq	%rsi, %r9
L_1268:
movq	%r10, %rsi
andq	$0x7, %rsi
je	L_129f
xorl	%r8d, %r8d
nopw	%cs:(%rax,%rax)
L_1280:
movzbl	(%r9,%r8), %r11d
movb	%r11b, (%rdi,%r8)
incq	%r8
cmpq	%r8, %rsi
jne	L_1280
movq	%r10, %rsi
subq	%r8, %rsi
addq	%r8, %rdi
addq	%r8, %r9
jmp	L_12a2
L_129f:
movq	%r10, %rsi
L_12a2:
movq	%rdi, %r8
movq	%r9, %r11
decq	%r10
cmpq	$0x7, %r10
jb	L_10e7
nopw	%cs:(%rax,%rax)
L_12c0:
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
jne	L_12c0
jmp	L_10e7
L_131f:
leaq	(%r14,%rdx), %r15
movq	%r14, %rdi
vzeroupper
callq	memcpy
movq	%r15, %r14
movq	0x48(%rsp), %rbp
jmp	L_13e6
L_133b:
addq	%rcx, %rdi
movq	%rdi, %rax
L_1341:
cmpq	$0x1f, %r15
ja	L_1389
cmpl	%r15d, %ebp
jbe	L_1389
movq	%r15, %rcx
negq	%rcx
movq	%rax, %r14
nopw	%cs:(%rax,%rax)
L_1360:
movq	%r14, %rdx
movl	%r15d, %esi
vmovups	(%rax,%rcx), %ymm0
vmovups	%ymm0, (%r14)
movl	%r15d, %r14d
addq	%rdx, %r14
subl	%r15d, %ebp
leal	(%rsi,%rsi), %r15d
cmpl	$0xf, %esi
ja	L_138c
cmpl	%ebp, %r15d
jb	L_1360
jmp	L_138c
L_1389:
movq	%rax, %r14
L_138c:
movl	%ebp, %edx
testl	%r15d, %r15d
je	L_141b
movl	%r15d, %edi
movq	%r14, %rsi
subq	%rdi, %rsi
movq	0x40(%rsp), %r8
movq	%r8, %rcx
subq	%r14, %rcx
cmpq	%rcx, %rdx
cmovaeq	%rcx, %rdx
subq	%rsi, %r8
movq	%r8, %rax
negq	%rax
cmovsq	%r8, %rax
cmpq	$0x20, %rcx
movq	0x48(%rsp), %rbp
jb	L_153d
cmpq	$0x1f, %rax
jbe	L_153d
movq	%r14, %rdi
vzeroupper
callq	chunkmemset_avx2
L_13e3:
movq	%rax, %r14
L_13e6:
movq	0x20(%rsp), %r15
L_13eb:
movq	0x10(%rsp), %r11
L_13f0:
movq	0x8(%rsp), %r8
L_13f5:
movq	0x18(%rsp), %rsi
L_13fa:
cmpq	%r11, %r8
jae	L_1966
cmpq	0x58(%rsp), %r14
jb	L_482
jmp	L_1966
L_1413:
addq	%rax, %rdi
jmp	L_52d
L_141b:
addq	%rdx, %r14
movq	0x48(%rsp), %rbp
movq	0x20(%rsp), %r15
jmp	L_13f0
L_142a:
testq	%rcx, %rcx
je	L_1638
cmpq	$0x80, %rcx
jb	L_1648
cmpq	$0x80, %rax
jb	L_1648
movl	%ecx, %r9d
andl	$-0x80, %r9d
leaq	(%rdi,%r9), %rax
leaq	(%rsi,%r9), %rdx
movl	%ecx, %r8d
andl	$0x7f, %r8d
xorl	%r10d, %r10d
L_1465:
vmovups	(%rsi,%r10), %ymm0
vmovups	0x20(%rsi,%r10), %ymm1
vmovups	0x40(%rsi,%r10), %ymm2
vmovups	0x60(%rsi,%r10), %ymm3
vmovups	%ymm0, (%rdi,%r10)
vmovups	%ymm1, 0x20(%rdi,%r10)
vmovups	%ymm2, 0x40(%rdi,%r10)
vmovups	%ymm3, 0x60(%rdi,%r10)
subq	$-0x80, %r10
cmpq	%r10, %r9
jne	L_1465
cmpq	%r9, %rcx
movq	0x10(%rsp), %r11
je	L_1341
jmp	L_1651
L_14b7:
testq	%rax, %rax
je	L_1640
cmpq	$0x80, %rax
jb	L_167e
cmpq	$0x80, %rcx
jb	L_167e
movl	%eax, %r8d
andl	$-0x80, %r8d
leaq	(%rdi,%r8), %r14
leaq	(%rsi,%r8), %rcx
movl	%eax, %edx
andl	$0x7f, %edx
xorl	%r9d, %r9d
L_14f0:
vmovups	(%rsi,%r9), %ymm0
vmovups	0x20(%rsi,%r9), %ymm1
vmovups	0x40(%rsi,%r9), %ymm2
vmovups	0x60(%rsi,%r9), %ymm3
vmovups	%ymm0, (%rdi,%r9)
vmovups	%ymm1, 0x20(%rdi,%r9)
vmovups	%ymm2, 0x40(%rdi,%r9)
vmovups	%ymm3, 0x60(%rdi,%r9)
subq	$-0x80, %r9
cmpq	%r9, %r8
jne	L_14f0
cmpq	%r8, %rax
je	L_13e6
jmp	L_1687
L_153d:
testq	%rdx, %rdx
je	L_13e6
cmpq	$0x80, %rdx
jb	L_16b7
cmpl	$0x80, %r15d
jb	L_16b7
negq	%rdi
movl	%edx, %r8d
andl	$-0x80, %r8d
leaq	(%r14,%r8), %rax
addq	%r8, %rsi
movl	%edx, %ecx
andl	$0x7f, %ecx
addq	%r14, %rdi
addq	$0x60, %rdi
addq	$0x60, %r14
xorl	%r9d, %r9d
L_1584:
vmovups	-0x60(%rdi,%r9), %ymm0
vmovups	-0x40(%rdi,%r9), %ymm1
vmovups	-0x20(%rdi,%r9), %ymm2
vmovups	(%rdi,%r9), %ymm3
vmovups	%ymm0, -0x60(%r14,%r9)
vmovups	%ymm1, -0x40(%r14,%r9)
vmovups	%ymm2, -0x20(%r14,%r9)
vmovups	%ymm3, (%r14,%r9)
subq	$-0x80, %r9
cmpq	%r9, %r8
jne	L_1584
cmpq	%r8, %rdx
je	L_13e3
jmp	L_16bd
L_15d1:
testq	%rdx, %rdx
je	L_6ac
cmpq	$0x80, %rdx
jb	L_15fe
movq	0x30(%rsp), %rax
addq	%r8, %rax
movq	%rdi, %rcx
subq	%rax, %rcx
cmpq	$0x80, %rcx
jae	L_18b7
L_15fe:
movq	%rdi, %rcx
movq	%rdx, %rax
L_1604:
movq	%rax, %rdx
andq	$0x7, %rdx
je	L_1849
xorl	%edi, %edi
L_1613:
movzbl	(%rsi,%rdi), %r8d
movb	%r8b, (%rcx,%rdi)
incq	%rdi
cmpq	%rdi, %rdx
jne	L_1613
addq	%rdi, %rcx
addq	%rdi, %rsi
movq	%rax, %rdx
subq	%rdi, %rdx
movq	%rcx, %rdi
jmp	L_184c
L_1638:
movq	%rdi, %rax
jmp	L_b8c
L_1640:
movq	%rdi, %r14
jmp	L_13e6
L_1648:
movq	%rdi, %rax
movq	%rsi, %rdx
movq	%rcx, %r8
L_1651:
movq	%r8, %rcx
andq	$0x7, %rcx
je	L_16f1
xorl	%esi, %esi
L_1660:
movzbl	(%rdx,%rsi), %edi
movb	%dil, (%rax,%rsi)
incq	%rsi
cmpq	%rsi, %rcx
jne	L_1660
addq	%rsi, %rax
addq	%rsi, %rdx
movq	%r8, %rcx
subq	%rsi, %rcx
jmp	L_16f4
L_167e:
movq	%rdi, %r14
movq	%rsi, %rcx
movq	%rax, %rdx
L_1687:
movq	%rdx, %rax
andq	$0x7, %rax
je	L_1767
xorl	%esi, %esi
L_1696:
movzbl	(%rcx,%rsi), %edi
movb	%dil, (%r14,%rsi)
incq	%rsi
cmpq	%rsi, %rax
jne	L_1696
addq	%rsi, %r14
addq	%rsi, %rcx
movq	%rdx, %rax
subq	%rsi, %rax
jmp	L_176a
L_16b7:
movq	%r14, %rax
movq	%rdx, %rcx
L_16bd:
movq	%rcx, %rdx
andq	$0x7, %rdx
je	L_17d8
xorl	%edi, %edi
L_16cc:
movzbl	(%rsi,%rdi), %r8d
movb	%r8b, (%rax,%rdi)
incq	%rdi
cmpq	%rdi, %rdx
jne	L_16cc
addq	%rdi, %rax
addq	%rdi, %rsi
movq	%rcx, %rdx
subq	%rdi, %rdx
movq	%rax, %r14
jmp	L_17db
L_16f1:
movq	%r8, %rcx
L_16f4:
decq	%r8
cmpq	$0x7, %r8
movq	0x10(%rsp), %r11
jb	L_1341
xorl	%esi, %esi
L_1708:
movzbl	(%rdx,%rsi), %edi
movb	%dil, (%rax,%rsi)
movzbl	0x1(%rdx,%rsi), %edi
movb	%dil, 0x1(%rax,%rsi)
movzbl	0x2(%rdx,%rsi), %edi
movb	%dil, 0x2(%rax,%rsi)
movzbl	0x3(%rdx,%rsi), %edi
movb	%dil, 0x3(%rax,%rsi)
movzbl	0x4(%rdx,%rsi), %edi
movb	%dil, 0x4(%rax,%rsi)
movzbl	0x5(%rdx,%rsi), %edi
movb	%dil, 0x5(%rax,%rsi)
movzbl	0x6(%rdx,%rsi), %edi
movb	%dil, 0x6(%rax,%rsi)
movzbl	0x7(%rdx,%rsi), %edi
movb	%dil, 0x7(%rax,%rsi)
addq	$0x8, %rsi
cmpq	%rsi, %rcx
jne	L_1708
addq	%rsi, %rax
jmp	L_b8c
L_1767:
movq	%rdx, %rax
L_176a:
decq	%rdx
cmpq	$0x7, %rdx
jb	L_13e6
xorl	%edx, %edx
L_1779:
movzbl	(%rcx,%rdx), %esi
movb	%sil, (%r14,%rdx)
movzbl	0x1(%rcx,%rdx), %esi
movb	%sil, 0x1(%r14,%rdx)
movzbl	0x2(%rcx,%rdx), %esi
movb	%sil, 0x2(%r14,%rdx)
movzbl	0x3(%rcx,%rdx), %esi
movb	%sil, 0x3(%r14,%rdx)
movzbl	0x4(%rcx,%rdx), %esi
movb	%sil, 0x4(%r14,%rdx)
movzbl	0x5(%rcx,%rdx), %esi
movb	%sil, 0x5(%r14,%rdx)
movzbl	0x6(%rcx,%rdx), %esi
movb	%sil, 0x6(%r14,%rdx)
movzbl	0x7(%rcx,%rdx), %esi
movb	%sil, 0x7(%r14,%rdx)
addq	$0x8, %rdx
cmpq	%rdx, %rax
jne	L_1779
addq	%rdx, %r14
jmp	L_13e6
L_17d8:
movq	%rcx, %rdx
L_17db:
decq	%rcx
cmpq	$0x7, %rcx
jb	L_13e6
xorl	%ecx, %ecx
L_17ea:
movzbl	(%rsi,%rcx), %edi
movb	%dil, (%rax,%rcx)
movzbl	0x1(%rsi,%rcx), %edi
movb	%dil, 0x1(%rax,%rcx)
movzbl	0x2(%rsi,%rcx), %edi
movb	%dil, 0x2(%rax,%rcx)
movzbl	0x3(%rsi,%rcx), %edi
movb	%dil, 0x3(%rax,%rcx)
movzbl	0x4(%rsi,%rcx), %edi
movb	%dil, 0x4(%rax,%rcx)
movzbl	0x5(%rsi,%rcx), %edi
movb	%dil, 0x5(%rax,%rcx)
movzbl	0x6(%rsi,%rcx), %edi
movb	%dil, 0x6(%rax,%rcx)
movzbl	0x7(%rsi,%rcx), %edi
movb	%dil, 0x7(%rax,%rcx)
addq	$0x8, %rcx
cmpq	%rcx, %rdx
jne	L_17ea
addq	%rcx, %rax
jmp	L_13e3
L_1849:
movq	%rax, %rdx
L_184c:
decq	%rax
cmpq	$0x7, %rax
jb	L_6ac
xorl	%eax, %eax
L_185b:
movzbl	(%rsi,%rax), %edi
movb	%dil, (%rcx,%rax)
movzbl	0x1(%rsi,%rax), %edi
movb	%dil, 0x1(%rcx,%rax)
movzbl	0x2(%rsi,%rax), %edi
movb	%dil, 0x2(%rcx,%rax)
movzbl	0x3(%rsi,%rax), %edi
movb	%dil, 0x3(%rcx,%rax)
movzbl	0x4(%rsi,%rax), %edi
movb	%dil, 0x4(%rcx,%rax)
movzbl	0x5(%rsi,%rax), %edi
movb	%dil, 0x5(%rcx,%rax)
movzbl	0x6(%rsi,%rax), %edi
movb	%dil, 0x6(%rcx,%rax)
movzbl	0x7(%rsi,%rax), %edi
movb	%dil, 0x7(%rcx,%rax)
addq	$0x8, %rax
cmpq	%rax, %rdx
jne	L_185b
addq	%rax, %rcx
jmp	L_191a
L_18b7:
movl	%edx, %r9d
andl	$-0x80, %r9d
leaq	(%rdi,%r9), %rcx
addq	%r9, %rsi
movl	%edx, %eax
andl	$0x7f, %eax
addq	0x68(%rsp), %r8
xorl	%r10d, %r10d
L_18d2:
vmovups	-0x60(%r8,%r10), %ymm0
vmovups	-0x40(%r8,%r10), %ymm1
vmovups	-0x20(%r8,%r10), %ymm2
vmovups	(%r8,%r10), %ymm3
vmovups	%ymm0, (%rdi,%r10)
vmovups	%ymm1, 0x20(%rdi,%r10)
vmovups	%ymm2, 0x40(%rdi,%r10)
vmovups	%ymm3, 0x60(%rdi,%r10)
subq	$-0x80, %r10
cmpq	%r10, %r9
jne	L_18d2
cmpq	%r9, %rdx
jne	L_1604
L_191a:
movl	%ebp, %eax
movq	%rcx, %rdi
jmp	L_6ae
L_1924:
testb	$0x20, %cl
jne	L_193d
movl	$0x3f51, 0x8(%rbp)
leaq	.L.str.2(%rip), %rax
L_1937:
movq	%rax, 0x30(%r15)
jmp	L_1944
L_193d:
movl	$0x3f3f, 0x8(%rbp)
L_1944:
movq	%rdi, %r14
jmp	L_1966
L_1949:
movl	$0x3f51, 0x8(%rbp)
leaq	.L.str.1(%rip), %rax
movq	%rax, 0x30(%r15)
movq	%rdx, %r12
movq	%rdi, %r14
movq	0x8(%rsp), %r8
L_1966:
movl	%r13d, %eax
shrl	$0x3, %eax
subq	%rax, %r8
movq	%r8, (%r15)
movq	%r14, 0x18(%r15)
subl	%r8d, %r11d
addl	$0xe, %r11d
movl	%r11d, 0x8(%r15)
movq	0x58(%rsp), %rcx
subl	%r14d, %ecx
andl	$0x7, %r13d
bzhil	%r13d, %r12d, %eax
addl	$0x103, %ecx
movl	%ecx, 0x20(%r15)
movq	%rax, 0x58(%rbp)
movl	%r13d, 0x60(%rbp)
addq	$0x88, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
vzeroupper
retq
L_19b9:
movl	$0x3f51, 0x8(%rbp)
leaq	.L.str(%rip), %rax
movq	0x20(%rsp), %r15
jmp	L_1937
	.section .rodata
bums_jump_table_rodata_0:
	.size bums_jump_table_rodata_0, 32
	.long L_28b - bums_jump_table_rodata_0
	.long L_299 - bums_jump_table_rodata_0
	.long L_314 - bums_jump_table_rodata_0
	.long L_292 - bums_jump_table_rodata_0
	.long L_314 - bums_jump_table_rodata_0
	.long L_314 - bums_jump_table_rodata_0
	.long L_314 - bums_jump_table_rodata_0
	.long L_2a0 - bums_jump_table_rodata_0
perm_idx_lut:
	.size perm_idx_lut, 116
	.byte 0,0,2,0,0,0,0,0,32,0,2,0,64,0,2,0
	.byte 96,0,4,0,0,0,0,0,128,0,5,0,160,0,22,0
	.byte 192,0,21,0,224,0,20,0,0,1,6,0,32,1,4,0
	.byte 64,1,2,0,0,0,0,0,96,1,15,0,112,1,14,0
	.byte 128,1,13,0,144,1,12,0,160,1,11,0,176,1,10,0
	.byte 192,1,9,0,208,1,8,0,224,1,7,0,240,1,6,0
	.byte 0,2,5,0,16,2,4,0,32,2,3,0,48,2,2,0
	.byte 64,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0
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
	.section .rodata.cst16
.LCPI1_0:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	.section .rodata.cst32
.LCPI1_1:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
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

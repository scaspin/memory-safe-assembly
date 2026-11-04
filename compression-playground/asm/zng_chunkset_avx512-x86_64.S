	.text
chunkmemset_safe_avx512:
cmpl	%ecx, %edx
cmovbl	%edx, %ecx
testl	%ecx, %ecx
je	L_d
movl	%ecx, %edx
jmp	chunkmemset_avx512
L_d:
movq	%rdi, %rax
retq
nopw	%cs:(%rax,%rax)
chunkmemset_avx512:
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
jns	L_6c
movl	%edx, %r14d
cmpq	%r14, %rax
jae	L_6c
cmpl	$0x20, %edx
ja	L_13a
jne	L_1dd
vmovdqu	(%rsi), %ymm0
vmovdqu	%ymm0, (%rbx)
addq	$0x20, %rbx
jmp	L_86
L_6c:
cmpq	$0x1, %rax
jne	L_95
movl	%edx, %r14d
movzbl	(%rsi), %esi
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memset
L_83:
addq	%r14, %rbx
L_86:
movq	%rbx, %rax
leaq	-0x10(%rbp), %rsp
popq	%rbx
popq	%r14
popq	%rbp
vzeroupper
retq
L_95:
cmpq	$0x20, %rax
jb	L_c6
movl	%edx, %ecx
andl	$0x1f, %ecx
cmpl	$0x1f, %edx
ja	L_ff
movl	$0xffffffff, %eax
bzhil	%ecx, %eax, %eax
kmovd	%eax, %k1
vmovdqu8	(%rsi), %ymm0 {%k1} {z}
vmovdqu8	%ymm0, (%rbx) {%k1}
movl	%ecx, %eax
addq	%rax, %rbx
jmp	L_86
L_c6:
cmpl	$0x10, %edx
ja	L_1b2
cmpq	$0x10, %rax
jb	L_14a
andl	$0xf, %edx
movl	$0x10, %eax
cmovnel	%edx, %eax
movl	$0xffff, %ecx
bzhil	%eax, %ecx, %ecx
kmovd	%ecx, %k1
vmovdqu8	(%rsi), %xmm0 {%k1} {z}
vmovdqu8	%xmm0, (%rbx) {%k1}
addq	%rax, %rbx
jmp	L_86
L_ff:
vmovdqu	(%rsi), %ymm0
testl	%ecx, %ecx
movl	$0x20, %eax
cmovnel	%ecx, %eax
vmovdqu	%ymm0, (%rbx)
cmpl	%eax, %edx
je	L_132
movl	%edx, %ecx
nopw	(%rax,%rax)
L_120:
vmovdqu	(%rsi,%rax), %ymm0
vmovdqu	%ymm0, (%rbx,%rax)
addq	$0x20, %rax
cmpl	%eax, %ecx
jne	L_120
L_132:
addq	%rax, %rbx
jmp	L_86
L_13a:
movq	%rbx, %rdi
movq	%r14, %rdx
callq	memmove
jmp	L_83
L_14a:
testb	$0x1, %al
sete	%cl
cmpq	$0x6, %rax
setne	%dil
testb	%cl, %dil
jne	L_1b2
movl	$0xfffffffd, %ecx
addl	%eax, %ecx
leaq	perm_idx_lut(%rip), %rdi
movzwl	(%rdi,%rcx,4), %ecx
movl	$0xffff, %edi
bzhil	%eax, %edi, %eax
kmovd	%eax, %k1
vmovdqu8	(%rsi), %xmm0 {%k1} {z}
leaq	permute_table(%rip), %rax
vpshufb	(%rcx,%rax), %xmm0, %xmm0
cmpl	$0x10, %edx
jne	L_19e
vmovdqu	%xmm0, (%rbx)
addq	$0x10, %rbx
xorl	%edx, %edx
L_19e:
vpxor	%xmm1, %xmm1, %xmm1
vmovdqa	%xmm1, 0x10(%rsp)
vmovdqa	%xmm0, (%rsp)
jmp	L_263
L_1b2:
leaq	-0x2(%rax), %rcx
rorxq	$0x1, %rcx, %rcx
cmpq	$0x7, %rcx
ja	L_284
leaq	bums_jump_table_rodata_0(%rip), %rdi
movslq	(%rdi,%rcx,4), %rcx
addq	%rdi, %rcx
jmpq	*%rcx
L_1d6:
vpbroadcastw	(%rsi), %ymm0
jmp	L_215
L_1dd:
andl	$0x1f, %edx
movl	$0xffffffff, %eax
bzhil	%edx, %eax, %eax
kmovd	%eax, %k1
vmovdqu8	(%rsi), %ymm0 {%k1} {z}
vmovdqu8	%ymm0, (%rbx) {%k1}
addq	%rdx, %rbx
jmp	L_86
L_202:
vpbroadcastq	(%rsi), %ymm0
jmp	L_215
L_209:
vpbroadcastd	(%rsi), %ymm0
jmp	L_215
L_210:
vbroadcasti128	(%rsi), %ymm0
L_215:
vmovdqa	%ymm0, (%rsp)
movl	$0x20, %eax
L_21f:
movl	%eax, %ecx
cmpl	$0x40, %edx
jb	L_243
leal	(%rax,%rax), %esi
nopl	(%rax)
L_230:
vmovdqu	%ymm0, (%rbx)
vmovdqu	%ymm0, (%rbx,%rcx)
addq	%rsi, %rbx
subl	%esi, %edx
cmpl	$0x3f, %edx
ja	L_230
L_243:
cmpl	$0x20, %edx
jb	L_263
nopl	(%rax,%rax)
L_250:
vmovdqa	(%rsp), %ymm0
vmovdqu	%ymm0, (%rbx)
subl	%eax, %edx
addq	%rcx, %rbx
cmpl	$0x1f, %edx
ja	L_250
L_263:
testl	%edx, %edx
je	L_86
movl	%edx, %r14d
movq	%rsp, %rsi
movq	%rbx, %rdi
movq	%r14, %rdx
vzeroupper
callq	memcpy
jmp	L_83
L_284:
movl	$0xfffffffd, %ecx
addl	%eax, %ecx
leaq	perm_idx_lut(%rip), %r8
movzwl	(%r8,%rcx,4), %edi
movzwl	0x2(%r8,%rcx,4), %ecx
cmpq	$0xf, %rax
ja	L_2d9
leaq	permute_table(%rip), %r8
vmovdqa	(%rdi,%r8), %ymm0
movl	$0xffff, %edi
bzhil	%eax, %edi, %eax
kmovd	%eax, %k1
vmovdqu8	(%rsi), %xmm1 {%k1} {z}
vpaddb	.LCPI1_1(%rip), %ymm0, %ymm0
vinserti128	$0x1, %xmm1, %ymm1, %ymm1
vpshufb	%ymm0, %ymm1, %ymm0
jmp	L_319
L_2d9:
addl	$-0x10, %eax
movl	$0xffff, %r8d
bzhil	%eax, %r8d, %eax
vmovdqu	(%rsi), %xmm0
kmovd	%eax, %k1
vmovdqu8	0x10(%rsi), %xmm1 {%k1} {z}
leaq	permute_table(%rip), %rax
vmovdqa	(%rdi,%rax), %xmm2
vpcmpltb	.LCPI1_0(%rip), %xmm2, %k1
vpshufb	%xmm2, %xmm0, %xmm1 {%k1}
vinserti128	$0x1, %xmm1, %ymm0, %ymm0
L_319:
vmovdqa	%ymm0, (%rsp)
movl	$0x20, %eax
subl	%ecx, %eax
jmp	L_21f
nopw	(%rax,%rax)
inflate_fast_avx512:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x78, %rsp
movq	%rdi, %r11
movq	0x38(%rdi), %r14
movq	(%rdi), %r13
movl	0x8(%rdi), %r15d
addl	$-0xe, %r15d
movq	0x18(%rdi), %rax
movl	0x20(%rdi), %r9d
subl	%r9d, %esi
movq	%rax, %rcx
subq	%rsi, %rcx
movq	%rcx, 0x68(%rsp)
leal	-0x103(%r9), %r8d
movl	0x40(%r14), %esi
movq	0x50(%r14), %r10
movzbl	0x64(%r14), %ecx
movl	$0xffffffff, %edi
shlxl	%ecx, %edi, %ecx
notl	%ecx
movzbl	0x78(%r14), %edx
shlxl	%edx, %edi, %edx
notl	%edx
movl	%esi, 0x40(%rsp)
testl	%esi, %esi
sete	%sil
cmpq	%r10, %rax
setb	%dil
orb	%sil, %dil
movq	%r10, 0x30(%rsp)
je	L_3b7
movl	$0x0, 0x3c(%rsp)
jmp	L_3d0
L_3b7:
leaq	0x104(%rax), %rsi
movl	0x44(%r14), %edi
addq	%r10, %rdi
cmpq	%rdi, %rsi
setbe	%sil
movl	%esi, 0x3c(%rsp)
L_3d0:
addq	%r13, %r15
addq	%rax, %r8
addq	%rax, %r9
movq	%r9, 0x28(%rsp)
movl	0x48(%r14), %esi
movl	%esi, 0x54(%rsp)
movl	0x4c(%r14), %esi
movl	%esi, 0x44(%rsp)
movq	0x58(%r14), %rbx
movl	0x60(%r14), %ebp
movq	0x68(%r14), %r12
movq	0x70(%r14), %rsi
movq	%rsi, 0x58(%rsp)
movl	%ecx, %r9d
movl	%edx, %ecx
movq	%rcx, 0x70(%rsp)
movq	%r8, 0x10(%rsp)
movq	%r9, 0x18(%rsp)
L_417:
shlxq	%rbp, (%r13), %rsi
orq	%rbx, %rsi
movl	%ebp, %ecx
shrl	$0x3, %ecx
andl	$0x7, %ecx
subq	%rcx, %r13
addq	$0x7, %r13
orl	$0x38, %ebp
movl	%esi, %edx
andl	%r9d, %edx
leaq	(%r12,%rdx,4), %rcx
movzbl	(%r12,%rdx,4), %edx
testb	%dl, %dl
jne	L_46a
movzbl	0x2(%rcx), %edx
movb	%dl, (%rax)
movzbl	0x1(%rcx), %ecx
shrxq	%rcx, %rsi, %rsi
subl	%ecx, %ebp
movl	%esi, %edx
andl	%r9d, %edx
leaq	(%r12,%rdx,4), %rcx
movzbl	(%r12,%rdx,4), %edx
testb	%dl, %dl
je	L_47a
incq	%rax
L_46a:
movzbl	0x1(%rcx), %edi
shrxq	%rdi, %rsi, %rbx
subl	%edi, %ebp
movq	%rax, %rdi
jmp	L_4c0
L_47a:
movzbl	0x2(%rcx), %edx
movb	%dl, 0x1(%rax)
addq	$0x2, %rax
movzbl	0x1(%rcx), %edi
shrxq	%rdi, %rsi, %rsi
movl	%esi, %r8d
andl	%r9d, %r8d
leaq	(%r12,%r8,4), %rcx
movzbl	(%r12,%r8,4), %edx
movzbl	0x1(%r12,%r8,4), %r8d
shrxq	%r8, %rsi, %rbx
addl	%r8d, %edi
movq	0x10(%rsp), %r8
subl	%edi, %ebp
movq	%rax, %rdi
jmp	L_4ef
nopw	(%rax,%rax)
L_4c0:
testb	$0x10, %dl
jne	L_510
testb	$0x40, %dl
jne	L_daa
movzwl	0x2(%rcx), %eax
leaq	(%r12,%rax,4), %rax
bzhil	%edx, %ebx, %edx
leaq	(%rax,%rdx,4), %rcx
movzbl	0x1(%rax,%rdx,4), %esi
shrxq	%rsi, %rbx, %rbx
subl	%esi, %ebp
movzbl	(%rax,%rdx,4), %edx
L_4ef:
testb	%dl, %dl
jne	L_4c0
movzbl	0x2(%rcx), %eax
movb	%al, (%rdi)
incq	%rdi
movq	%rdi, %rax
jmp	L_d7d
nopw	%cs:(%rax,%rax)
L_510:
movzbl	%dl, %eax
andl	$0xf, %eax
shrxq	%rax, %rbx, %rdx
subl	%eax, %ebp
cmpl	$0x1b, %ebp
ja	L_53c
shlxq	%rbp, (%r13), %r8
orq	%rdx, %r8
movl	%ebp, %esi
shrl	$0x3, %esi
subq	%rsi, %r13
addq	$0x7, %r13
orl	$0x38, %ebp
jmp	L_53f
L_53c:
movq	%rdx, %r8
L_53f:
movzwl	0x2(%rcx), %esi
andl	0x70(%rsp), %edx
movq	0x58(%rsp), %rcx
leaq	(%rcx,%rdx,4), %r9
movzbl	0x1(%r9), %edx
shrxq	%rdx, %r8, %rcx
subl	%edx, %ebp
movzbl	(%r9), %r8d
testb	$0x10, %r8b
jne	L_5aa
nopw	%cs:(%rax,%rax)
L_570:
testb	$0x40, %r8b
jne	L_dd1
movzwl	0x2(%r9), %edx
movq	0x58(%rsp), %r9
leaq	(%r9,%rdx,4), %rdx
bzhil	%r8d, %ecx, %r8d
leaq	(%rdx,%r8,4), %r9
movzbl	0x1(%rdx,%r8,4), %r10d
shrxq	%r10, %rcx, %rcx
subl	%r10d, %ebp
movzbl	(%rdx,%r8,4), %r8d
testb	$0x10, %r8b
je	L_570
L_5aa:
movq	%r15, (%rsp)
movq	%r11, 0x8(%rsp)
bzhil	%eax, %ebx, %edx
addq	%rsi, %rdx
movzwl	0x2(%r9), %eax
andl	$0xf, %r8d
bzhil	%r8d, %ecx, %r15d
addq	%rax, %r15
shrxq	%r8, %rcx, %rbx
subl	%r8d, %ebp
movl	%edi, %ecx
subl	0x68(%rsp), %ecx
movl	%r15d, %eax
subl	%ecx, %eax
jbe	L_65e
cmpl	0x54(%rsp), %eax
movq	0x10(%rsp), %r8
movl	0x44(%rsp), %r9d
ja	L_e39
testl	%r9d, %r9d
movq	%r14, 0x20(%rsp)
je	L_6b0
movl	%r9d, %esi
subl	%eax, %esi
jae	L_6b6
subl	%r9d, %eax
movl	0x40(%rsp), %esi
subl	%eax, %esi
addq	0x30(%rsp), %rsi
movl	%edx, %r14d
subl	%eax, %r14d
jbe	L_6bb
movl	%eax, %eax
cmpq	%rsi, %rdi
je	L_d8d
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
vzeroupper
callq	chunkmemset_avx512
movq	0x10(%rsp), %r8
movq	%rax, %rdi
movl	%r14d, %edx
movl	0x44(%rsp), %eax
jmp	L_d96
L_65e:
movq	%rdi, %rsi
subq	%r15, %rsi
cmpl	%r15d, %edx
jbe	L_673
cmpl	$0x20, %r15d
jb	L_d62
L_673:
movl	%edx, %ecx
andl	$0x1f, %ecx
cmpl	$0x1f, %edx
movq	0x10(%rsp), %r8
movq	0x18(%rsp), %r9
ja	L_75a
movl	$0xffffffff, %eax
bzhil	%ecx, %eax, %eax
kmovd	%eax, %k1
vmovdqu8	(%rsi), %ymm0 {%k1} {z}
vmovdqu8	%ymm0, (%rdi) {%k1}
addq	%rdi, %rdx
movq	%rdx, %rax
jmp	L_793
L_6b0:
movl	0x40(%rsp), %esi
subl	%eax, %esi
L_6b6:
addq	0x30(%rsp), %rsi
L_6bb:
movl	%edx, %r14d
subl	%eax, %r14d
jbe	L_72e
movl	%eax, %eax
cmpb	$0x0, 0x3c(%rsp)
je	L_7a1
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
movq	%rsi, %r8
subq	%rdi, %r8
setae	%r10b
leaq	(%rdi,%rdx), %rax
cmpq	%rax, %rsi
setb	%r11b
cmpq	%rsi, %rdi
setae	%cl
leaq	(%rsi,%rdx), %r9
cmpq	%r9, %rdi
setb	%r9b
testb	%r11b, %r10b
jne	L_7ec
andb	%r9b, %cl
jne	L_7ec
movq	%rax, 0x48(%rsp)
vzeroupper
callq	memcpy
movq	0x48(%rsp), %rax
jmp	L_80f
L_72e:
movl	%edx, %eax
cmpq	%rsi, %rdi
je	L_7d3
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
vzeroupper
callq	chunkmemset_avx512
movq	0x10(%rsp), %r8
jmp	L_7d9
L_75a:
testl	%ecx, %ecx
movl	$0x20, %eax
cmovel	%eax, %ecx
vmovdqu	(%rsi), %ymm0
vmovdqu	%ymm0, (%rdi)
leaq	(%rcx,%rdi), %rax
subl	%ecx, %edx
je	L_793
negq	%r15
nopw	(%rax,%rax)
L_780:
vmovdqu	(%rax,%r15), %ymm0
vmovdqu	%ymm0, (%rax)
addq	$0x20, %rax
addl	$-0x20, %edx
jne	L_780
L_793:
movq	0x8(%rsp), %r11
movq	(%rsp), %r15
jmp	L_d7d
L_7a1:
cmpq	%rsi, %rdi
je	L_cf1
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rax
cmovbq	%rax, %rdx
vzeroupper
callq	chunkmemset_avx512
movq	%rax, %rdi
cmpq	$0x1f, %r15
jbe	L_cfa
jmp	L_d42
L_7d3:
addq	%rax, %rdi
movq	%rdi, %rax
L_7d9:
movq	0x20(%rsp), %r14
movq	0x8(%rsp), %r11
movq	(%rsp), %r15
jmp	L_d78
L_7ec:
cmpq	%rsi, %rdi
je	L_80f
movq	%r8, %rax
negq	%rax
cmovsq	%r8, %rax
movq	%rax, %r8
movq	%rdi, %rax
testq	%rdx, %rdx
movq	%r8, 0x60(%rsp)
jne	L_a9f
L_80f:
movq	%rax, %rsi
subq	%r15, %rsi
movl	%r14d, %ecx
movq	0x28(%rsp), %rdx
subq	%rax, %rdx
cmpq	%rdx, %rcx
cmovbq	%rcx, %rdx
leaq	(%rsi,%rdx), %rcx
cmpq	%rcx, %rax
jae	L_cc7
testq	%rdx, %rdx
movq	0x20(%rsp), %r14
jmp	L_84c
nop
L_840:
movq	%rsi, %r8
movq	%r10, %rax
L_846:
movq	%r8, %rsi
subq	%rcx, %rdx
L_84c:
movq	0x18(%rsp), %r9
je	L_cde
cmpq	%rdx, %r15
movq	%rdx, %rcx
cmovbq	%r15, %rcx
cmpq	$0x10, %rcx
jb	L_880
leaq	-0x10(%rcx), %r8
movl	%r8d, %edi
notl	%edi
testb	$0x30, %dil
jne	L_885
movq	%rcx, %rdi
jmp	L_8b5
nopl	(%rax,%rax)
L_880:
movq	%rcx, %rdi
jmp	L_8f8
L_885:
movl	%r8d, %r9d
shrl	$0x4, %r9d
incl	%r9d
andl	$0x3, %r9d
movl	%r9d, %r10d
shll	$0x4, %r10d
movq	%rcx, %rdi
subq	%r10, %rdi
L_8a0:
vmovdqu	(%rsi), %xmm0
vmovdqu	%xmm0, (%rax)
addq	$0x10, %rax
addq	$0x10, %rsi
decq	%r9
jne	L_8a0
L_8b5:
cmpq	$0x30, %r8
jb	L_8f8
nopl	(%rax,%rax)
L_8c0:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rax)
vmovups	0x10(%rsi), %xmm0
vmovups	%xmm0, 0x10(%rax)
vmovups	0x20(%rsi), %xmm0
vmovups	%xmm0, 0x20(%rax)
vmovdqu	0x30(%rsi), %xmm0
vmovdqu	%xmm0, 0x30(%rax)
addq	$0x40, %rax
addq	$0x40, %rsi
addq	$-0x40, %rdi
cmpq	$0xf, %rdi
ja	L_8c0
L_8f8:
cmpq	$0x8, %rdi
jb	L_910
movq	(%rsi), %r8
movq	%r8, (%rax)
addq	$0x8, %rax
addq	$0x8, %rsi
addq	$-0x8, %rdi
L_910:
cmpq	$0x4, %rdi
jb	L_928
movl	(%rsi), %r8d
movl	%r8d, (%rax)
addq	$0x4, %rax
addq	$0x4, %rsi
addq	$-0x4, %rdi
L_928:
movq	%rax, %r10
testq	%rdi, %rdi
je	L_840
cmpq	$0x100, %rdi
jb	L_9d0
movq	%r10, %rax
subq	%rsi, %rax
cmpq	$0x100, %rax
jb	L_9d0
movq	%rdi, %r11
andq	$-0x100, %r11
movzbl	%dil, %r9d
leaq	(%r10,%r11), %rax
leaq	(%rsi,%r11), %r8
xorl	%r14d, %r14d
nopl	(%rax)
L_970:
vmovdqu64	(%rsi,%r14), %zmm0
vmovups	0x40(%rsi,%r14), %zmm1
vmovups	0x80(%rsi,%r14), %zmm2
vmovups	0xc0(%rsi,%r14), %zmm3
vmovdqu64	%zmm0, (%r10,%r14)
vmovups	%zmm1, 0x40(%r10,%r14)
vmovups	%zmm2, 0x80(%r10,%r14)
vmovups	%zmm3, 0xc0(%r10,%r14)
addq	$0x100, %r14
cmpq	%r14, %r11
jne	L_970
cmpq	%r11, %rdi
movq	0x20(%rsp), %r14
je	L_846
jmp	L_9d9
nopw	(%rax,%rax)
L_9d0:
movq	%rdi, %r9
movq	%r10, %rax
movq	%rsi, %r8
L_9d9:
movq	%r9, %rsi
andq	$0x7, %rsi
je	L_a0f
xorl	%edi, %edi
nopw	%cs:(%rax,%rax)
L_9f0:
movzbl	(%r8,%rdi), %r10d
movb	%r10b, (%rax,%rdi)
incq	%rdi
cmpq	%rdi, %rsi
jne	L_9f0
movq	%r9, %rsi
subq	%rdi, %rsi
addq	%rdi, %rax
addq	%rdi, %r8
jmp	L_a12
L_a0f:
movq	%r9, %rsi
L_a12:
movq	%rax, %rdi
movq	%r8, %r10
decq	%r9
cmpq	$0x7, %r9
jb	L_846
nopw	%cs:(%rax,%rax)
L_a30:
movzbl	(%r10), %eax
movb	%al, (%rdi)
movzbl	0x1(%r10), %eax
movb	%al, 0x1(%rdi)
movzbl	0x2(%r10), %eax
movb	%al, 0x2(%rdi)
movzbl	0x3(%r10), %eax
movb	%al, 0x3(%rdi)
movzbl	0x4(%r10), %eax
movb	%al, 0x4(%rdi)
movzbl	0x5(%r10), %eax
movb	%al, 0x5(%rdi)
movzbl	0x6(%r10), %eax
movb	%al, 0x6(%rdi)
leaq	0x8(%r10), %r8
leaq	0x8(%rdi), %rax
movzbl	0x7(%r10), %r9d
movb	%r9b, 0x7(%rdi)
movq	%rax, %rdi
movq	%r8, %r10
addq	$-0x8, %rsi
jne	L_a30
jmp	L_846
L_a88:
movq	%rsi, %r10
movq	%rdi, %rax
L_a8e:
movq	%rax, %rdi
movq	%r10, %rsi
subq	0x48(%rsp), %rdx
je	L_80f
L_a9f:
cmpq	%rdx, %r8
movq	%rdx, %r9
cmovbq	%r8, %r9
cmpq	$0x10, %r9
movq	%r9, 0x48(%rsp)
jb	L_b38
leaq	-0x10(%r9), %rax
movl	%eax, %ecx
notl	%ecx
testb	$0x30, %cl
je	L_af5
movl	%eax, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x3, %r10d
movl	%r10d, %ecx
shll	$0x4, %ecx
subq	%rcx, %r9
nopl	(%rax)
L_ae0:
vmovdqu	(%rsi), %xmm0
vmovdqu	%xmm0, (%rdi)
addq	$0x10, %rdi
addq	$0x10, %rsi
decq	%r10
jne	L_ae0
L_af5:
cmpq	$0x30, %rax
jb	L_b38
nopl	(%rax,%rax)
L_b00:
vmovups	(%rsi), %xmm0
vmovups	%xmm0, (%rdi)
vmovups	0x10(%rsi), %xmm0
vmovups	%xmm0, 0x10(%rdi)
vmovups	0x20(%rsi), %xmm0
vmovups	%xmm0, 0x20(%rdi)
vmovdqu	0x30(%rsi), %xmm0
vmovdqu	%xmm0, 0x30(%rdi)
addq	$0x40, %rdi
addq	$0x40, %rsi
addq	$-0x40, %r9
cmpq	$0xf, %r9
ja	L_b00
L_b38:
cmpq	$0x8, %r9
jb	L_b60
movq	(%rsi), %rax
movq	%rax, (%rdi)
addq	$0x8, %rdi
addq	$0x8, %rsi
addq	$-0x8, %r9
cmpq	$0x4, %r9
jae	L_b66
L_b56:
testq	%r9, %r9
jne	L_b7f
jmp	L_a88
L_b60:
cmpq	$0x4, %r9
jb	L_b56
L_b66:
movl	(%rsi), %eax
movl	%eax, (%rdi)
addq	$0x4, %rdi
addq	$0x4, %rsi
addq	$-0x4, %r9
testq	%r9, %r9
je	L_a88
L_b7f:
cmpq	$0x100, %r9
jb	L_c1a
movq	%rdi, %rax
subq	%rsi, %rax
cmpq	$0x100, %rax
jb	L_c1a
movq	%r9, %rcx
andq	$-0x100, %rcx
movzbl	%r9b, %r11d
leaq	(%rdi,%rcx), %rax
leaq	(%rsi,%rcx), %r10
xorl	%r8d, %r8d
nopw	(%rax,%rax)
L_bc0:
vmovdqu64	(%rsi,%r8), %zmm0
vmovups	0x40(%rsi,%r8), %zmm1
vmovups	0x80(%rsi,%r8), %zmm2
vmovups	0xc0(%rsi,%r8), %zmm3
vmovdqu64	%zmm0, (%rdi,%r8)
vmovups	%zmm1, 0x40(%rdi,%r8)
vmovups	%zmm2, 0x80(%rdi,%r8)
vmovups	%zmm3, 0xc0(%rdi,%r8)
addq	$0x100, %r8
cmpq	%r8, %rcx
jne	L_bc0
cmpq	%rcx, %r9
movq	0x60(%rsp), %r8
je	L_a8e
jmp	L_c23
L_c1a:
movq	%r9, %r11
movq	%rdi, %rax
movq	%rsi, %r10
L_c23:
movq	%r11, %rsi
andq	$0x7, %rsi
je	L_c4f
xorl	%ecx, %ecx
nop
L_c30:
movzbl	(%r10,%rcx), %edi
movb	%dil, (%rax,%rcx)
incq	%rcx
cmpq	%rcx, %rsi
jne	L_c30
movq	%r11, %rsi
subq	%rcx, %rsi
addq	%rcx, %rax
addq	%rcx, %r10
jmp	L_c52
L_c4f:
movq	%r11, %rsi
L_c52:
movq	%rax, %rdi
movq	%r10, %r9
decq	%r11
cmpq	$0x7, %r11
jb	L_a8e
nopw	%cs:(%rax,%rax)
L_c70:
movzbl	(%r9), %eax
movb	%al, (%rdi)
movzbl	0x1(%r9), %eax
movb	%al, 0x1(%rdi)
movzbl	0x2(%r9), %eax
movb	%al, 0x2(%rdi)
movzbl	0x3(%r9), %eax
movb	%al, 0x3(%rdi)
movzbl	0x4(%r9), %eax
movb	%al, 0x4(%rdi)
movzbl	0x5(%r9), %eax
movb	%al, 0x5(%rdi)
movzbl	0x6(%r9), %eax
movb	%al, 0x6(%rdi)
leaq	0x8(%r9), %r10
leaq	0x8(%rdi), %rax
movzbl	0x7(%r9), %ecx
movb	%cl, 0x7(%rdi)
movq	%rax, %rdi
movq	%r10, %r9
addq	$-0x8, %rsi
jne	L_c70
jmp	L_a8e
L_cc7:
leaq	(%rax,%rdx), %r14
movq	%rax, %rdi
vzeroupper
callq	memcpy
movq	%r14, %rax
jmp	L_da3
L_cde:
movq	0x8(%rsp), %r11
movq	(%rsp), %r15
movq	0x10(%rsp), %r8
jmp	L_d7d
L_cf1:
addq	%rax, %rdi
cmpq	$0x1f, %r15
ja	L_d42
L_cfa:
cmpl	%r15d, %r14d
jbe	L_d42
movq	%r15, %rcx
negq	%rcx
movq	%rdi, %rax
nopl	(%rax,%rax)
L_d10:
movq	%rax, %rsi
movl	%r15d, %edx
vmovdqu	(%rdi,%rcx), %ymm0
vmovdqu	%ymm0, (%rax)
movl	%r15d, %eax
addq	%rsi, %rax
subl	%r15d, %r14d
leal	(%rdx,%rdx), %r15d
cmpl	$0xf, %edx
ja	L_d36
cmpl	%r14d, %r15d
jb	L_d10
L_d36:
movl	%r14d, %ecx
testl	%edx, %edx
je	L_da0
movq	%rax, %rdi
jmp	L_d45
L_d42:
movl	%r14d, %ecx
L_d45:
movq	0x20(%rsp), %r14
movl	%r15d, %eax
movq	%rdi, %rsi
subq	%rax, %rsi
movq	0x28(%rsp), %rdx
subq	%rdi, %rdx
cmpq	%rdx, %rcx
cmovbq	%rcx, %rdx
L_d62:
vzeroupper
callq	chunkmemset_avx512
L_d6a:
movq	0x8(%rsp), %r11
movq	(%rsp), %r15
movq	0x10(%rsp), %r8
L_d78:
movq	0x18(%rsp), %r9
L_d7d:
cmpq	%r15, %r13
jae	L_def
cmpq	%r8, %rax
jb	L_417
jmp	L_def
L_d8d:
addq	%rax, %rdi
movl	%r14d, %edx
movl	%r9d, %eax
L_d96:
movq	0x30(%rsp), %rsi
jmp	L_6bb
L_da0:
addq	%rcx, %rax
L_da3:
movq	0x20(%rsp), %r14
jmp	L_d6a
L_daa:
testb	$0x20, %dl
jne	L_dc4
movl	$0x3f51, 0x8(%r14)
leaq	.L.str.2(%rip), %rax
movq	%rax, 0x30(%r11)
jmp	L_dcc
L_dc4:
movl	$0x3f3f, 0x8(%r14)
L_dcc:
movq	%rdi, %rax
jmp	L_def
L_dd1:
movl	$0x3f51, 0x8(%r14)
leaq	.L.str.1(%rip), %rax
movq	%rax, 0x30(%r11)
movq	%rcx, %rbx
movq	%rdi, %rax
movq	0x10(%rsp), %r8
L_def:
movl	%ebp, %ecx
shrl	$0x3, %ecx
subq	%rcx, %r13
movq	%r13, (%r11)
movq	%rax, 0x18(%r11)
subl	%r13d, %r15d
addl	$0xe, %r15d
movl	%r15d, 0x8(%r11)
subl	%eax, %r8d
andl	$0x7, %ebp
bzhil	%ebp, %ebx, %eax
addl	$0x103, %r8d
movl	%r8d, 0x20(%r11)
movq	%rax, 0x58(%r14)
movl	%ebp, 0x60(%r14)
addq	$0x78, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
vzeroupper
retq
L_e39:
movl	$0x3f51, 0x8(%r14)
leaq	.L.str(%rip), %rax
movq	0x8(%rsp), %r11
movq	%rax, 0x30(%r11)
movq	%rdi, %rax
movq	(%rsp), %r15
jmp	L_def
	.section .rodata
bums_jump_table_rodata_0:
	.size bums_jump_table_rodata_0, 32
	.long L_1d6 - bums_jump_table_rodata_0
	.long L_209 - bums_jump_table_rodata_0
	.long L_284 - bums_jump_table_rodata_0
	.long L_202 - bums_jump_table_rodata_0
	.long L_284 - bums_jump_table_rodata_0
	.long L_284 - bums_jump_table_rodata_0
	.long L_284 - bums_jump_table_rodata_0
	.long L_210 - bums_jump_table_rodata_0
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
	.byte 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
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

	.text
crc32_chorba_sse41:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x8088, %rsp
movq	%rdx, %rbx
notl	%edi
movl	%esi, %r15d
negl	%r15d
andl	$0xf, %r15d
leaq	0x48(%r15), %rax
cmpq	%rax, %rdx
jbe	L_5b
testq	%r15, %r15
je	L_41
movq	%rsi, %r14
movq	%r15, %rdx
callq	crc32_braid_internal
movq	%r14, %rsi
movl	%eax, %edi
subq	%r15, %rbx
L_41:
leaq	(%rsi,%r15), %r14
cmpq	$0x80001, %rbx
jb	L_77
movq	%r14, %rsi
movq	%rbx, %rdx
callq	crc32_chorba_118960_nondestructive
jmp	L_63
L_5b:
movq	%rbx, %rdx
callq	crc32_braid_internal
L_63:
notl	%eax
addq	$0x8088, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
L_77:
leaq	-0x2001(%rbx), %rax
cmpq	$0x5fff, %rax
ja	L_2fd
movq	%rsi, 0x10(%rsp)
xorps	%xmm0, %xmm0
movaps	%xmm0, 0x4f0(%rsp)
movaps	%xmm0, 0x4e0(%rsp)
movaps	%xmm0, 0x4d0(%rsp)
movaps	%xmm0, 0x4c0(%rsp)
movaps	%xmm0, 0x4b0(%rsp)
movaps	%xmm0, 0x4a0(%rsp)
movaps	%xmm0, 0x490(%rsp)
movaps	%xmm0, 0x480(%rsp)
leaq	0x580(%rsp), %r12
movd	%edi, %xmm0
movdqa	%xmm0, (%rsp)
movl	$0x190, %edx
movq	%r12, %rdi
xorl	%esi, %esi
callq	memset
movdqa	0x10(%r14), %xmm1
movdqa	0x20(%r14), %xmm2
movdqa	0x30(%r14), %xmm0
movdqa	(%rsp), %xmm5
pxor	(%r14), %xmm5
movdqa	%xmm5, %xmm3
pslldq	$0x8, %xmm3
movdqa	%xmm1, %xmm4
palignr	$0x8, %xmm5, %xmm4
movdqa	%xmm5, %xmm7
movdqa	%xmm2, %xmm5
palignr	$0x8, %xmm1, %xmm5
movdqa	%xmm0, %xmm6
palignr	$0x8, %xmm2, %xmm6
movdqa	%xmm3, 0x500(%rsp)
movdqa	%xmm4, 0x510(%rsp)
movdqa	%xmm5, 0x520(%rsp)
movdqa	%xmm6, 0x530(%rsp)
movdqa	%xmm3, 0x630(%rsp)
movdqa	%xmm4, 0x640(%rsp)
movdqa	%xmm5, 0x650(%rsp)
movdqa	%xmm6, 0x660(%rsp)
movdqa	%xmm3, 0x710(%rsp)
movdqa	%xmm4, 0x720(%rsp)
movdqa	%xmm5, 0x730(%rsp)
movdqa	%xmm6, 0x740(%rsp)
movdqa	%xmm7, 0x9e0(%rsp)
movdqa	%xmm1, 0x9f0(%rsp)
movdqa	%xmm2, 0xa00(%rsp)
movdqa	%xmm0, 0xa10(%rsp)
psrldq	$0x8, %xmm0
movdqa	0x40(%r14), %xmm1
movdqa	0x50(%r14), %xmm2
movdqa	0x60(%r14), %xmm3
movdqa	0x70(%r14), %xmm4
movdqa	%xmm1, %xmm5
pslldq	$0x8, %xmm5
pxor	%xmm0, %xmm5
movdqa	%xmm2, %xmm0
palignr	$0x8, %xmm1, %xmm0
movdqa	%xmm3, %xmm6
palignr	$0x8, %xmm2, %xmm6
movdqa	%xmm4, %xmm7
palignr	$0x8, %xmm3, %xmm7
movdqa	%xmm5, 0x540(%rsp)
movdqa	%xmm0, 0x550(%rsp)
movdqa	%xmm6, 0x560(%rsp)
movdqa	%xmm7, 0x570(%rsp)
movdqa	%xmm5, 0x670(%rsp)
movdqa	%xmm0, 0x680(%rsp)
movdqa	%xmm6, 0x690(%rsp)
movdqa	%xmm7, 0x6a0(%rsp)
movdqa	%xmm5, 0x750(%rsp)
movdqa	%xmm0, 0x760(%rsp)
movdqa	%xmm6, 0x770(%rsp)
movdqa	%xmm7, 0x780(%rsp)
movdqa	%xmm1, 0xa20(%rsp)
movdqa	%xmm2, 0xa30(%rsp)
movdqa	%xmm3, 0xa40(%rsp)
movdqa	%xmm4, 0xa50(%rsp)
movdqa	%xmm4, %xmm0
psrldq	$0x8, %xmm0
cmpq	$0xa20, %rbx
ja	L_30d
leaq	0x80(%r14), %rsi
leaq	0x6b0(%rsp), %rcx
leaq	0x790(%rsp), %rax
leaq	0xa60(%rsp), %rdx
movl	$0x80, %r13d
movl	$0xa20, %r8d
cmpq	%rbx, %r8
jb	L_436
L_2e7:
movdqa	%xmm0, %xmm1
cmpq	%rbx, %r8
jb	L_65f
L_2f4:
movdqa	%xmm1, %xmm2
jmp	L_7dd
L_2fd:
movq	%r14, %rsi
movq	%rbx, %rdx
callq	chorba_small_nondestructive_sse2
jmp	L_63
L_30d:
leaq	0xc0(%r14), %rsi
movdqa	0x80(%r14), %xmm2
movdqa	0x90(%r14), %xmm3
movdqa	0xa0(%r14), %xmm4
movdqa	0xb0(%r14), %xmm1
movdqa	%xmm2, %xmm5
pslldq	$0x8, %xmm5
movdqa	%xmm3, %xmm6
palignr	$0x8, %xmm2, %xmm6
movdqa	%xmm4, %xmm7
palignr	$0x8, %xmm3, %xmm7
movdqa	%xmm1, %xmm8
palignr	$0x8, %xmm4, %xmm8
pxor	%xmm5, %xmm0
movdqa	%xmm0, 0x580(%rsp)
movdqa	%xmm6, 0x590(%rsp)
movdqa	%xmm7, 0x5a0(%rsp)
movdqa	%xmm8, 0x5b0(%rsp)
movdqa	%xmm0, 0x6b0(%rsp)
movdqa	%xmm6, 0x6c0(%rsp)
movdqa	%xmm7, 0x6d0(%rsp)
movdqa	%xmm8, 0x6e0(%rsp)
movdqa	%xmm0, 0x790(%rsp)
movdqa	%xmm6, 0x7a0(%rsp)
movdqa	%xmm7, 0x7b0(%rsp)
movdqa	%xmm8, 0x7c0(%rsp)
movdqa	%xmm2, 0xa60(%rsp)
movdqa	%xmm3, 0xa70(%rsp)
movdqa	%xmm4, 0xa80(%rsp)
movdqa	%xmm1, 0xa90(%rsp)
psrldq	$0x8, %xmm1
leaq	0x5c0(%rsp), %r12
leaq	0x6f0(%rsp), %rcx
leaq	0x7d0(%rsp), %rax
leaq	0xaa0(%rsp), %rdx
movl	$0xc0, %r13d
movl	$0xa60, %r8d
movdqa	%xmm1, %xmm0
cmpq	%rbx, %r8
jae	L_2e7
L_436:
cmpq	$0xa21, %rbx
setae	%r8b
movdqa	(%r14,%r13), %xmm2
movdqa	0x10(%rsi), %xmm3
movdqa	0x20(%rsi), %xmm4
movdqa	0x30(%rsi), %xmm1
movdqa	%xmm2, %xmm5
pslldq	$0x8, %xmm5
movdqa	%xmm3, %xmm6
palignr	$0x8, %xmm2, %xmm6
movdqa	%xmm4, %xmm7
palignr	$0x8, %xmm3, %xmm7
movdqa	%xmm1, %xmm8
palignr	$0x8, %xmm4, %xmm8
movdqa	%xmm0, %xmm9
pxor	%xmm5, %xmm9
movdqa	%xmm9, (%r12)
movdqa	%xmm6, 0x10(%r12)
movdqa	%xmm7, 0x20(%r12)
movdqa	%xmm8, 0x30(%r12)
movdqa	0x10(%rcx), %xmm5
pxor	%xmm6, %xmm5
movdqa	0x20(%rcx), %xmm10
pxor	%xmm7, %xmm10
movdqa	0x30(%rcx), %xmm11
pxor	%xmm8, %xmm11
movdqa	0x40(%rcx), %xmm0
movdqa	%xmm9, (%rcx)
movdqa	%xmm5, 0x10(%rcx)
movdqa	%xmm10, 0x20(%rcx)
movdqa	%xmm11, 0x30(%rcx)
movdqa	%xmm9, (%rax)
movdqa	%xmm6, 0x10(%rax)
movdqa	%xmm7, 0x20(%rax)
movdqa	%xmm8, 0x30(%rax)
movdqa	%xmm2, (%rdx)
movdqa	%xmm3, 0x10(%rdx)
movdqa	%xmm4, 0x20(%rdx)
movdqa	%xmm1, 0x30(%rdx)
psrldq	$0x8, %xmm1
pxor	%xmm1, %xmm0
leaq	0x40(%r13), %rdi
leaq	0x9e0(%r13), %r9
cmpq	%rbx, %r9
setae	%r9b
orb	%r8b, %r9b
jne	L_635
movdqa	0x40(%rsi), %xmm3
movdqa	0x50(%rsi), %xmm4
movdqa	0x60(%rsi), %xmm5
movdqa	0x70(%rsi), %xmm2
addq	$0x80, %rsi
movdqa	%xmm3, %xmm9
pslldq	$0x8, %xmm9
movdqa	%xmm4, %xmm6
palignr	$0x8, %xmm3, %xmm6
movdqa	%xmm5, %xmm7
palignr	$0x8, %xmm4, %xmm7
movdqa	%xmm2, %xmm8
palignr	$0x8, %xmm5, %xmm8
pxor	%xmm9, %xmm1
movdqa	%xmm1, 0x40(%r12)
movdqa	%xmm6, 0x50(%r12)
movdqa	%xmm7, 0x60(%r12)
movdqa	%xmm8, 0x70(%r12)
pxor	%xmm9, %xmm0
movdqa	0x50(%rcx), %xmm9
pxor	%xmm6, %xmm9
movdqa	0x60(%rcx), %xmm10
pxor	%xmm7, %xmm10
movdqa	0x70(%rcx), %xmm11
pxor	%xmm8, %xmm11
movdqa	0x80(%rcx), %xmm12
movdqa	%xmm0, 0x40(%rcx)
movdqa	%xmm9, 0x50(%rcx)
movdqa	%xmm10, 0x60(%rcx)
movdqa	%xmm11, 0x70(%rcx)
movdqa	%xmm1, 0x40(%rax)
movdqa	%xmm6, 0x50(%rax)
movdqa	%xmm7, 0x60(%rax)
movdqa	%xmm8, 0x70(%rax)
movdqa	%xmm3, 0x40(%rdx)
movdqa	%xmm4, 0x50(%rdx)
movdqa	%xmm5, 0x60(%rdx)
movdqa	%xmm2, 0x70(%rdx)
psrldq	$0x8, %xmm2
subq	$-0x80, %r12
addq	$0x80, %rcx
pxor	%xmm2, %xmm12
subq	$-0x80, %rax
subq	$-0x80, %rdx
movq	%r13, %r8
subq	$-0x80, %r8
movq	%rdi, %r13
movdqa	%xmm2, %xmm1
movdqa	%xmm12, %xmm0
movq	%r8, %rdi
jmp	L_649
L_635:
addq	$0x40, %rsi
addq	$0x40, %r12
addq	$0x40, %rcx
addq	$0x40, %rax
addq	$0x40, %rdx
L_649:
addq	$0x9e0, %r13
movq	%r13, %r8
movq	%rdi, %r13
cmpq	%rbx, %r8
jae	L_2f4
L_65f:
xorl	%edi, %edi
movdqa	%xmm1, %xmm2
nopw	%cs:(%rax,%rax)
L_670:
movdqa	%xmm2, %xmm6
movdqa	(%rsi,%rdi), %xmm3
movdqa	0x10(%rsi,%rdi), %xmm4
movdqa	0x20(%rsi,%rdi), %xmm5
movdqa	0x30(%rsi,%rdi), %xmm2
movdqa	%xmm3, %xmm7
pslldq	$0x8, %xmm7
movdqa	%xmm4, %xmm8
palignr	$0x8, %xmm3, %xmm8
movdqa	%xmm5, %xmm9
palignr	$0x8, %xmm4, %xmm9
movdqa	%xmm2, %xmm10
palignr	$0x8, %xmm5, %xmm10
movdqa	%xmm1, %xmm11
pxor	%xmm7, %xmm11
movdqa	0x10(%r12,%rdi), %xmm12
pxor	%xmm8, %xmm12
movdqa	0x20(%r12,%rdi), %xmm13
pxor	%xmm9, %xmm13
movdqa	0x30(%r12,%rdi), %xmm14
pxor	%xmm10, %xmm14
movdqa	0x40(%r12,%rdi), %xmm1
movdqa	%xmm11, (%r12,%rdi)
movdqa	%xmm12, 0x10(%r12,%rdi)
movdqa	%xmm13, 0x20(%r12,%rdi)
movdqa	%xmm14, 0x30(%r12,%rdi)
movdqa	%xmm0, %xmm11
pxor	%xmm7, %xmm11
movdqa	0x10(%rcx,%rdi), %xmm12
pxor	%xmm8, %xmm12
movdqa	0x20(%rcx,%rdi), %xmm13
pxor	%xmm9, %xmm13
movdqa	0x30(%rcx,%rdi), %xmm14
pxor	%xmm10, %xmm14
movdqa	0x40(%rcx,%rdi), %xmm0
movdqa	%xmm11, (%rcx,%rdi)
movdqa	%xmm12, 0x10(%rcx,%rdi)
movdqa	%xmm13, 0x20(%rcx,%rdi)
movdqa	%xmm14, 0x30(%rcx,%rdi)
pxor	%xmm6, %xmm7
movdqa	%xmm7, (%rax,%rdi)
movdqa	%xmm8, 0x10(%rax,%rdi)
movdqa	%xmm9, 0x20(%rax,%rdi)
movdqa	%xmm10, 0x30(%rax,%rdi)
movdqa	%xmm3, (%rdx,%rdi)
movdqa	%xmm4, 0x10(%rdx,%rdi)
movdqa	%xmm5, 0x20(%rdx,%rdi)
movdqa	%xmm2, 0x30(%rdx,%rdi)
psrldq	$0x8, %xmm2
pxor	%xmm2, %xmm1
pxor	%xmm2, %xmm0
leaq	(%rdi,%r13), %r8
addq	$0x9e0, %r8
leaq	0x40(%rdi), %r9
cmpq	%rbx, %r8
jae	L_7c0
addq	%r13, %rdi
cmpq	$0x260, %rdi
movq	%r9, %rdi
jb	L_670
L_7c0:
leaq	(%r9,%r13), %r8
addq	$0x9a0, %r8
addq	%r9, %r13
addq	%r9, %r12
addq	%r9, %rcx
addq	%r9, %rax
addq	%r9, %rdx
addq	%r9, %rsi
L_7dd:
leaq	0x9e0(%rsp), %rdi
cmpq	%rbx, %r8
jae	L_9be
leaq	0x480(%rsp), %r8
xorl	%r10d, %r10d
jmp	L_853
nopl	(%rax,%rax)
L_800:
pxor	%xmm8, %xmm2
movdqa	%xmm2, (%rax,%r10)
movdqa	%xmm9, 0x10(%rax,%r10)
movdqa	%xmm10, 0x20(%rax,%r10)
movdqa	%xmm11, 0x30(%rax,%r10)
movdqa	%xmm4, (%rdx,%r10)
movdqa	%xmm5, 0x10(%rdx,%r10)
movdqa	%xmm6, 0x20(%rdx,%r10)
movdqa	%xmm7, 0x30(%rdx,%r10)
addq	$0x40, %r10
addq	$0x9e0, %r9
movdqa	%xmm3, %xmm2
cmpq	%rbx, %r9
jae	L_9c4
L_853:
leaq	(%r10,%r13), %r9
movdqa	(%rsi,%r10), %xmm4
cmpq	$0x3ff, %r9
ja	L_880
movdqa	0x10(%rsi,%r10), %xmm5
movdqa	0x20(%rsi,%r10), %xmm6
movdqa	0x30(%rsi,%r10), %xmm7
jmp	L_8b0
nopl	(%rax)
L_880:
pxor	(%r8), %xmm4
movdqa	0x10(%r8), %xmm5
movdqa	0x20(%r8), %xmm6
pxor	0x10(%rsi,%r10), %xmm5
pxor	0x20(%rsi,%r10), %xmm6
movdqa	0x30(%r8), %xmm7
addq	$0x40, %r8
pxor	0x30(%rsi,%r10), %xmm7
L_8b0:
movdqa	%xmm4, %xmm8
pslldq	$0x8, %xmm8
movdqa	%xmm5, %xmm9
palignr	$0x8, %xmm4, %xmm9
movdqa	%xmm6, %xmm10
palignr	$0x8, %xmm5, %xmm10
movdqa	%xmm7, %xmm11
palignr	$0x8, %xmm6, %xmm11
movdqa	%xmm7, %xmm3
psrldq	$0x8, %xmm3
movdqa	%xmm1, %xmm12
pxor	%xmm8, %xmm12
movdqa	0x10(%r12,%r10), %xmm13
pxor	%xmm9, %xmm13
movdqa	0x20(%r12,%r10), %xmm14
pxor	%xmm10, %xmm14
movdqa	0x30(%r12,%r10), %xmm15
pxor	%xmm11, %xmm15
movdqa	0x40(%r12,%r10), %xmm1
pxor	%xmm3, %xmm1
movdqa	%xmm12, (%r12,%r10)
movdqa	%xmm13, 0x10(%r12,%r10)
movdqa	%xmm14, 0x20(%r12,%r10)
movdqa	%xmm15, 0x30(%r12,%r10)
movdqa	%xmm0, %xmm12
pxor	%xmm8, %xmm12
movdqa	0x10(%rcx,%r10), %xmm13
pxor	%xmm9, %xmm13
movdqa	0x20(%rcx,%r10), %xmm14
pxor	%xmm10, %xmm14
movdqa	0x30(%rcx,%r10), %xmm15
pxor	%xmm11, %xmm15
movdqa	0x40(%rcx,%r10), %xmm0
pxor	%xmm3, %xmm0
movdqa	%xmm12, (%rcx,%r10)
movdqa	%xmm13, 0x10(%rcx,%r10)
movdqa	%xmm14, 0x20(%rcx,%r10)
movdqa	%xmm15, 0x30(%rcx,%r10)
cmpq	$0x2a0, %r9
jb	L_800
pxor	0x10(%rax,%r10), %xmm9
pxor	0x20(%rax,%r10), %xmm10
pxor	0x30(%rax,%r10), %xmm11
pxor	0x40(%rax,%r10), %xmm3
jmp	L_800
L_9be:
movdqa	%xmm2, %xmm3
jmp	L_9d0
L_9c4:
addq	%r10, %r12
addq	%r10, %rcx
addq	%r10, %rax
addq	%r10, %r13
L_9d0:
movdqa	%xmm1, (%r12)
movdqa	%xmm0, (%rcx)
movdqa	%xmm3, (%rax)
movq	%rbx, %rbp
subq	%r13, %rbp
leaq	-0x960(%rbp), %r12
addq	%r13, %rdi
cmpq	$0x40, %r12
jb	L_a29
addq	$-0x9a0, %rbp
movq	%rbp, %r12
andq	$-0x40, %r12
leaq	0x40(%r12), %rdx
xorl	%esi, %esi
callq	memset
leaq	(%rsp,%r13), %rax
addq	$0x80, %rax
leaq	(%r12,%rax), %rdi
addq	$0x9a0, %rdi
andl	$0x3f, %ebp
movq	%rbp, %r12
L_a29:
cmpq	$0x10, %r12
jb	L_a54
movl	%r12d, %ebp
andl	$0x30, %ebp
xorl	%esi, %esi
movq	%rbp, %rdx
movq	%r14, (%rsp)
movq	%rdi, %r14
callq	memset
movq	%r14, %rdi
movq	(%rsp), %r14
addq	%rbp, %rdi
andl	$0xf, %r12d
L_a54:
movq	0x10(%rsp), %rax
testq	%r12, %r12
je	L_a6d
xorl	%esi, %esi
movq	%r12, %rdx
callq	memset
movq	0x10(%rsp), %rax
L_a6d:
pxor	%xmm6, %xmm6
movdqa	%xmm6, 0x50(%rsp)
movdqa	%xmm6, 0x40(%rsp)
movdqa	%xmm6, 0x30(%rsp)
movdqa	%xmm6, 0x20(%rsp)
movq	$0x0, 0x60(%rsp)
leaq	0x48(%r13), %rcx
cmpq	%rbx, %rcx
jae	L_be3
addq	%r15, %rax
addq	$0x10, %rax
pxor	%xmm7, %xmm7
pxor	%xmm0, %xmm0
nop
L_ab0:
pxor	-0x10(%rax,%r13), %xmm6
pxor	0x80(%rsp,%r13), %xmm6
movdqa	%xmm6, %xmm2
psllq	$0x11, %xmm2
movdqa	%xmm6, %xmm3
psllq	$0x37, %xmm3
movdqa	%xmm6, %xmm1
psrlq	$0x2f, %xmm1
movdqa	%xmm6, %xmm4
psrlq	$0x9, %xmm4
pxor	%xmm1, %xmm4
movdqa	%xmm6, %xmm1
psllq	$0x13, %xmm1
pxor	%xmm4, %xmm1
movdqa	%xmm6, %xmm4
psrlq	$0x2d, %xmm4
movdqa	%xmm6, %xmm5
psllq	$0x2c, %xmm5
por	%xmm4, %xmm5
pxor	%xmm7, %xmm5
psrlq	$0x14, %xmm6
movdqa	%xmm1, %xmm4
pslldq	$0x8, %xmm4
pxor	(%rax,%r13), %xmm0
pxor	0x90(%rsp,%r13), %xmm0
pxor	%xmm3, %xmm0
pxor	%xmm2, %xmm0
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm3
psllq	$0x11, %xmm3
movdqa	%xmm0, %xmm2
psllq	$0x37, %xmm2
pxor	%xmm5, %xmm2
pxor	%xmm3, %xmm2
movdqa	%xmm0, %xmm3
psrlq	$0x2f, %xmm3
movdqa	%xmm0, %xmm4
psrlq	$0x9, %xmm4
pxor	%xmm3, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x13, %xmm3
pxor	%xmm4, %xmm3
movdqa	%xmm0, %xmm4
psrlq	$0x2d, %xmm4
movdqa	%xmm0, %xmm5
psllq	$0x2c, %xmm5
por	%xmm4, %xmm5
psrlq	$0x14, %xmm0
movdqa	%xmm3, %xmm4
palignr	$0x8, %xmm1, %xmm4
movdqa	%xmm0, %xmm1
palignr	$0x8, %xmm6, %xmm1
pslldq	$0x8, %xmm6
pxor	%xmm4, %xmm6
pxor	%xmm2, %xmm6
psrldq	$0x8, %xmm3
pxor	%xmm5, %xmm1
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm7
psrldq	$0x8, %xmm7
leaq	0x20(%r13), %r15
addq	$0x68, %r13
movdqa	%xmm1, %xmm0
cmpq	%rbx, %r13
movq	%r15, %r13
jb	L_ab0
jmp	L_bee
L_be3:
pxor	%xmm1, %xmm1
pxor	%xmm7, %xmm7
movq	%r13, %r15
L_bee:
movdqa	%xmm6, 0x70(%rsp)
movdqa	%xmm1, (%rsp)
movdqa	%xmm7, 0x10(%rsp)
addq	%r15, %r14
movq	%rbx, %rdx
subq	%r15, %rdx
leaq	0x20(%rsp), %rdi
movq	%r14, %rsi
callq	memcpy
xorl	%eax, %eax
movq	%rbx, %rcx
movaps	0x70(%rsp), %xmm0
xorps	0x20(%rsp), %xmm0
movaps	%xmm0, 0x20(%rsp)
movaps	(%rsp), %xmm0
xorps	0x30(%rsp), %xmm0
movaps	%xmm0, 0x30(%rsp)
movaps	0x10(%rsp), %xmm0
xorps	0x40(%rsp), %xmm0
movaps	%xmm0, 0x40(%rsp)
subq	%r15, %rcx
je	L_63
leaq	0x1(%r15), %rax
cmpq	%rax, %rbx
jne	L_c5e
xorl	%edx, %edx
xorl	%eax, %eax
jmp	L_cba
L_c5e:
movq	%rcx, %rsi
andq	$-0x2, %rsi
leaq	(%rsp,%rax), %rdi
addq	$0x80, %rdi
xorl	%edx, %edx
leaq	crc_table(%rip), %r8
xorl	%eax, %eax
nopl	(%rax,%rax)
L_c80:
movzbl	0x20(%rsp,%rdx), %r9d
xorb	%al, %r9b
xorb	-0x1(%rdi,%rdx), %r9b
movzbl	%r9b, %r9d
shrl	$0x8, %eax
xorl	(%r8,%r9,4), %eax
movzbl	0x21(%rsp,%rdx), %r9d
xorb	%al, %r9b
xorb	(%rdi,%rdx), %r9b
movzbl	%r9b, %r9d
shrl	$0x8, %eax
xorl	(%r8,%r9,4), %eax
addq	$0x2, %rdx
cmpq	%rdx, %rsi
jne	L_c80
L_cba:
testb	$0x1, %cl
je	L_63
leaq	(%rsp,%r15), %rcx
addq	$0x80, %rcx
movzbl	0x20(%rsp,%rdx), %esi
xorb	%al, %sil
xorb	(%rcx,%rdx), %sil
movzbl	%sil, %ecx
leaq	crc_table(%rip), %rdx
shrl	$0x8, %eax
xorl	(%rdx,%rcx,4), %eax
jmp	L_63
	.section .rodata
crc_table:
	.size crc_table, 1024
	.byte 0,0,0,0,150,48,7,119,44,97,14,238,186,81,9,153
	.byte 25,196,109,7,143,244,106,112,53,165,99,233,163,149,100,158
	.byte 50,136,219,14,164,184,220,121,30,233,213,224,136,217,210,151
	.byte 43,76,182,9,189,124,177,126,7,45,184,231,145,29,191,144
	.byte 100,16,183,29,242,32,176,106,72,113,185,243,222,65,190,132
	.byte 125,212,218,26,235,228,221,109,81,181,212,244,199,133,211,131
	.byte 86,152,108,19,192,168,107,100,122,249,98,253,236,201,101,138
	.byte 79,92,1,20,217,108,6,99,99,61,15,250,245,13,8,141
	.byte 200,32,110,59,94,16,105,76,228,65,96,213,114,113,103,162
	.byte 209,228,3,60,71,212,4,75,253,133,13,210,107,181,10,165
	.byte 250,168,181,53,108,152,178,66,214,201,187,219,64,249,188,172
	.byte 227,108,216,50,117,92,223,69,207,13,214,220,89,61,209,171
	.byte 172,48,217,38,58,0,222,81,128,81,215,200,22,97,208,191
	.byte 181,244,180,33,35,196,179,86,153,149,186,207,15,165,189,184
	.byte 158,184,2,40,8,136,5,95,178,217,12,198,36,233,11,177
	.byte 135,124,111,47,17,76,104,88,171,29,97,193,61,45,102,182
	.byte 144,65,220,118,6,113,219,1,188,32,210,152,42,16,213,239
	.byte 137,133,177,113,31,181,182,6,165,228,191,159,51,212,184,232
	.byte 162,201,7,120,52,249,0,15,142,168,9,150,24,152,14,225
	.byte 187,13,106,127,45,61,109,8,151,108,100,145,1,92,99,230
	.byte 244,81,107,107,98,97,108,28,216,48,101,133,78,0,98,242
	.byte 237,149,6,108,123,165,1,27,193,244,8,130,87,196,15,245
	.byte 198,217,176,101,80,233,183,18,234,184,190,139,124,136,185,252
	.byte 223,29,221,98,73,45,218,21,243,124,211,140,101,76,212,251
	.byte 88,97,178,77,206,81,181,58,116,0,188,163,226,48,187,212
	.byte 65,165,223,74,215,149,216,61,109,196,209,164,251,244,214,211
	.byte 106,233,105,67,252,217,110,52,70,136,103,173,208,184,96,218
	.byte 115,45,4,68,229,29,3,51,95,76,10,170,201,124,13,221
	.byte 60,113,5,80,170,65,2,39,16,16,11,190,134,32,12,201
	.byte 37,181,104,87,179,133,111,32,9,212,102,185,159,228,97,206
	.byte 14,249,222,94,152,201,217,41,34,152,208,176,180,168,215,199
	.byte 23,61,179,89,129,13,180,46,59,92,189,183,173,108,186,192
	.byte 32,131,184,237,182,179,191,154,12,226,182,3,154,210,177,116
	.byte 57,71,213,234,175,119,210,157,21,38,219,4,131,22,220,115
	.byte 18,11,99,227,132,59,100,148,62,106,109,13,168,90,106,122
	.byte 11,207,14,228,157,255,9,147,39,174,0,10,177,158,7,125
	.byte 68,147,15,240,210,163,8,135,104,242,1,30,254,194,6,105
	.byte 93,87,98,247,203,103,101,128,113,54,108,25,231,6,107,110
	.byte 118,27,212,254,224,43,211,137,90,122,218,16,204,74,221,103
	.byte 111,223,185,249,249,239,190,142,67,190,183,23,213,142,176,96
	.byte 232,163,214,214,126,147,209,161,196,194,216,56,82,242,223,79
	.byte 241,103,187,209,103,87,188,166,221,6,181,63,75,54,178,72
	.byte 218,43,13,216,76,27,10,175,246,74,3,54,96,122,4,65
	.byte 195,239,96,223,85,223,103,168,239,142,110,49,121,190,105,70
	.byte 140,179,97,203,26,131,102,188,160,210,111,37,54,226,104,82
	.byte 149,119,12,204,3,71,11,187,185,22,2,34,47,38,5,85
	.byte 190,59,186,197,40,11,189,178,146,90,180,43,4,106,179,92
	.byte 167,255,215,194,49,207,208,181,139,158,217,44,29,174,222,91
	.byte 176,194,100,155,38,242,99,236,156,163,106,117,10,147,109,2
	.byte 169,6,9,156,63,54,14,235,133,103,7,114,19,87,0,5
	.byte 130,74,191,149,20,122,184,226,174,43,177,123,56,27,182,12
	.byte 155,142,210,146,13,190,213,229,183,239,220,124,33,223,219,11
	.byte 212,210,211,134,66,226,212,241,248,179,221,104,110,131,218,31
	.byte 205,22,190,129,91,38,185,246,225,119,176,111,119,71,183,24
	.byte 230,90,8,136,112,106,15,255,202,59,6,102,92,11,1,17
	.byte 255,158,101,143,105,174,98,248,211,255,107,97,69,207,108,22
	.byte 120,226,10,160,238,210,13,215,84,131,4,78,194,179,3,57
	.byte 97,38,103,167,247,22,96,208,77,71,105,73,219,119,110,62
	.byte 74,106,209,174,220,90,214,217,102,11,223,64,240,59,216,55
	.byte 83,174,188,169,197,158,187,222,127,207,178,71,233,255,181,48
	.byte 28,242,189,189,138,194,186,202,48,147,179,83,166,163,180,36
	.byte 5,54,208,186,147,6,215,205,41,87,222,84,191,103,217,35
	.byte 46,122,102,179,184,74,97,196,2,27,104,93,148,43,111,42
	.byte 55,190,11,180,161,142,12,195,27,223,5,90,141,239,2,45
# ---- chorba_sse2.S, for chorba_small_nondestructive_sse2
	.text
	.text
chorba_small_nondestructive_sse2:
pushq	%rbx
subq	$0x10, %rsp
pxor	%xmm4, %xmm4
movdqa	%xmm4, -0x40(%rsp)
movdqa	%xmm4, -0x50(%rsp)
movdqa	%xmm4, -0x60(%rsp)
movdqa	%xmm4, -0x70(%rsp)
movq	$0x0, -0x30(%rsp)
movd	%edi, %xmm9
cmpq	$0x169, %rdx
jb	Lchorba_sse2__a73
xorps	%xmm1, %xmm1
xorl	%eax, %eax
xorps	%xmm6, %xmm6
nopw	%cs:(%rax,%rax)
Lchorba_sse2__50:
pxor	(%rsi,%rax), %xmm9
xorps	0x10(%rsi,%rax), %xmm1
movdqa	0x30(%rsi,%rax), %xmm4
movdqa	%xmm4, (%rsp)
xorps	0x20(%rsi,%rax), %xmm6
pxor	%xmm9, %xmm4
movaps	%xmm1, %xmm0
shufps	$0x4e, %xmm6, %xmm0
movaps	%xmm0, -0x10(%rsp)
movdqa	%xmm9, %xmm10
shufps	$0x4e, %xmm1, %xmm10
movdqa	%xmm9, %xmm7
pslldq	$0x8, %xmm7
movdqa	0x40(%rsi,%rax), %xmm11
pxor	%xmm7, %xmm11
pxor	%xmm1, %xmm11
movdqa	%xmm11, %xmm3
psllq	$0x11, %xmm3
movdqa	%xmm11, %xmm8
psllq	$0x37, %xmm8
movdqa	%xmm11, %xmm2
psrlq	$0x2f, %xmm2
movdqa	%xmm11, %xmm5
psrlq	$0x9, %xmm5
pxor	%xmm2, %xmm5
movdqa	%xmm11, %xmm2
psllq	$0x13, %xmm2
pxor	%xmm5, %xmm2
movdqa	%xmm11, %xmm12
psrlq	$0x2d, %xmm12
movdqa	%xmm11, %xmm5
psllq	$0x2c, %xmm5
por	%xmm12, %xmm5
psrlq	$0x14, %xmm11
movdqa	%xmm2, %xmm13
pslldq	$0x8, %xmm13
pxor	0x50(%rsi,%rax), %xmm8
pxor	%xmm3, %xmm13
pxor	%xmm9, %xmm13
pxor	%xmm6, %xmm13
pxor	%xmm8, %xmm13
pxor	%xmm10, %xmm13
movdqa	%xmm13, %xmm8
psllq	$0x11, %xmm8
movdqa	%xmm13, %xmm3
psrlq	$0x2f, %xmm3
movdqa	%xmm13, %xmm12
psrlq	$0x9, %xmm12
pxor	%xmm3, %xmm12
movdqa	%xmm13, %xmm3
psllq	$0x13, %xmm3
pxor	%xmm12, %xmm3
movdqa	%xmm13, %xmm12
psrlq	$0x2d, %xmm12
movdqa	%xmm13, %xmm14
psllq	$0x2c, %xmm14
por	%xmm12, %xmm14
movdqa	%xmm13, %xmm12
psllq	$0x37, %xmm12
psrlq	$0x14, %xmm13
shufps	$0x4e, %xmm3, %xmm2
psrldq	$0x8, %xmm3
pxor	%xmm14, %xmm3
movdqa	%xmm11, %xmm14
pslldq	$0x8, %xmm14
shufps	$0x4e, %xmm13, %xmm11
pxor	0x60(%rsi,%rax), %xmm14
pxor	%xmm5, %xmm14
pxor	%xmm12, %xmm14
pxor	%xmm8, %xmm14
pxor	%xmm1, %xmm14
pxor	%xmm2, %xmm14
movaps	%xmm0, %xmm5
pxor	%xmm4, %xmm5
pxor	%xmm14, %xmm5
movdqa	%xmm5, %xmm12
psllq	$0x11, %xmm12
movdqa	%xmm5, %xmm14
psllq	$0x37, %xmm14
pxor	%xmm3, %xmm14
movdqa	%xmm5, %xmm2
psrlq	$0x2f, %xmm2
movdqa	%xmm5, %xmm3
psrlq	$0x9, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm5, %xmm2
psllq	$0x13, %xmm2
pxor	%xmm3, %xmm2
movdqa	%xmm5, %xmm3
psrlq	$0x2d, %xmm3
movdqa	%xmm5, %xmm8
psllq	$0x2c, %xmm8
por	%xmm3, %xmm8
movdqa	%xmm6, %xmm15
xorps	0x70(%rsi,%rax), %xmm11
shufps	$0x4e, %xmm4, %xmm15
movaps	%xmm15, -0x20(%rsp)
pxor	%xmm14, %xmm11
movdqa	%xmm2, %xmm3
pslldq	$0x8, %xmm3
pxor	%xmm12, %xmm11
pxor	%xmm3, %xmm11
movdqa	%xmm6, %xmm0
pxor	%xmm15, %xmm0
movdqa	%xmm0, -0x80(%rsp)
pxor	%xmm0, %xmm11
movdqa	%xmm11, %xmm3
psrlq	$0x2f, %xmm3
movdqa	%xmm11, %xmm12
psrlq	$0x9, %xmm12
pxor	%xmm3, %xmm12
movdqa	%xmm11, %xmm14
psllq	$0x13, %xmm14
pxor	%xmm12, %xmm14
movdqa	%xmm11, %xmm3
psrlq	$0x2d, %xmm3
movdqa	%xmm11, %xmm12
psllq	$0x2c, %xmm12
por	%xmm3, %xmm12
psrlq	$0x14, %xmm5
movdqa	%xmm11, %xmm3
movdqa	%xmm11, %xmm15
psrlq	$0x14, %xmm11
shufps	$0x4e, %xmm14, %xmm2
movdqa	%xmm5, %xmm0
shufps	$0x4e, %xmm11, %xmm5
psrldq	$0x8, %xmm14
pxor	%xmm5, %xmm14
psrldq	$0x8, %xmm13
pxor	0x80(%rsi,%rax), %xmm13
pxor	%xmm8, %xmm13
pslldq	$0x8, %xmm0
pxor	%xmm0, %xmm13
psllq	$0x37, %xmm15
pxor	%xmm15, %xmm13
psllq	$0x11, %xmm3
pxor	%xmm3, %xmm13
movdqa	%xmm4, %xmm8
psrldq	$0x8, %xmm8
pxor	(%rsp), %xmm13
pxor	%xmm2, %xmm13
pxor	%xmm8, %xmm13
movdqa	%xmm13, %xmm0
psllq	$0x37, %xmm0
pxor	%xmm14, %xmm0
movdqa	%xmm13, %xmm2
psrlq	$0x2f, %xmm2
movdqa	%xmm13, %xmm3
psrlq	$0x9, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm13, %xmm5
psllq	$0x13, %xmm5
pxor	%xmm3, %xmm5
movdqa	%xmm13, %xmm2
psrlq	$0x2d, %xmm2
movdqa	%xmm13, %xmm14
psllq	$0x2c, %xmm14
por	%xmm2, %xmm14
pxor	0x90(%rsi,%rax), %xmm12
pxor	%xmm0, %xmm12
movdqa	%xmm13, %xmm0
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm12
movdqa	%xmm5, %xmm0
pslldq	$0x8, %xmm0
pxor	%xmm0, %xmm12
pxor	%xmm1, %xmm12
movdqa	%xmm12, %xmm0
psrlq	$0x2f, %xmm0
movdqa	%xmm12, %xmm2
psrlq	$0x9, %xmm2
pxor	%xmm0, %xmm2
movdqa	%xmm12, %xmm3
psllq	$0x13, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm12, %xmm0
psrlq	$0x2d, %xmm0
movdqa	%xmm12, %xmm2
psllq	$0x2c, %xmm2
por	%xmm0, %xmm2
psrlq	$0x14, %xmm13
movdqa	%xmm12, %xmm0
psllq	$0x37, %xmm0
shufps	$0x4e, %xmm13, %xmm11
pxor	%xmm0, %xmm11
movdqa	%xmm12, %xmm0
psrlq	$0x14, %xmm12
shufps	$0x4e, %xmm3, %xmm5
shufps	$0x4e, %xmm12, %xmm13
psrldq	$0x8, %xmm3
pxor	%xmm13, %xmm3
pxor	0xa0(%rsi,%rax), %xmm14
pxor	%xmm11, %xmm14
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm14
pxor	%xmm5, %xmm14
movdqa	%xmm1, %xmm15
pxor	%xmm9, %xmm15
movdqa	%xmm7, %xmm11
pxor	%xmm10, %xmm11
movdqa	%xmm10, %xmm5
pxor	%xmm9, %xmm10
pxor	%xmm6, %xmm9
pxor	%xmm7, %xmm9
pxor	%xmm14, %xmm9
movdqa	%xmm9, %xmm0
psllq	$0x37, %xmm0
pxor	%xmm3, %xmm0
movdqa	%xmm9, %xmm3
psrlq	$0x2f, %xmm3
movdqa	%xmm9, %xmm14
psrlq	$0x9, %xmm14
pxor	%xmm3, %xmm14
movdqa	%xmm9, %xmm13
psllq	$0x13, %xmm13
pxor	%xmm14, %xmm13
movdqa	%xmm9, %xmm3
psrlq	$0x2d, %xmm3
movdqa	%xmm9, %xmm14
psllq	$0x2c, %xmm14
por	%xmm3, %xmm14
pxor	0xb0(%rsi,%rax), %xmm2
pxor	%xmm0, %xmm2
movdqa	%xmm9, %xmm0
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm2
movdqa	%xmm13, %xmm0
pslldq	$0x8, %xmm0
pxor	%xmm0, %xmm2
pxor	%xmm15, %xmm5
pxor	%xmm4, %xmm5
pxor	%xmm2, %xmm5
movdqa	%xmm5, %xmm0
psrlq	$0x2f, %xmm0
movdqa	%xmm5, %xmm2
psrlq	$0x9, %xmm2
pxor	%xmm0, %xmm2
movdqa	%xmm5, %xmm0
psllq	$0x13, %xmm0
pxor	%xmm2, %xmm0
movdqa	%xmm5, %xmm2
psrlq	$0x2d, %xmm2
movdqa	%xmm5, %xmm3
psllq	$0x2c, %xmm3
por	%xmm2, %xmm3
psrlq	$0x14, %xmm9
movdqa	%xmm5, %xmm2
psllq	$0x37, %xmm2
shufps	$0x4e, %xmm9, %xmm12
pxor	%xmm2, %xmm12
movdqa	%xmm5, %xmm2
psrlq	$0x14, %xmm5
shufps	$0x4e, %xmm0, %xmm13
shufps	$0x4e, %xmm5, %xmm9
psrldq	$0x8, %xmm0
pxor	%xmm9, %xmm0
pxor	0xc0(%rsi,%rax), %xmm14
pxor	%xmm12, %xmm14
psllq	$0x11, %xmm2
pxor	%xmm2, %xmm14
pxor	%xmm13, %xmm14
movdqa	-0x10(%rsp), %xmm12
pxor	%xmm6, %xmm12
pxor	%xmm7, %xmm15
pxor	%xmm12, %xmm15
pxor	%xmm14, %xmm15
movdqa	%xmm15, %xmm9
psllq	$0x37, %xmm9
pxor	%xmm0, %xmm9
movdqa	%xmm15, %xmm0
psrlq	$0x2f, %xmm0
movdqa	%xmm15, %xmm2
psrlq	$0x9, %xmm2
pxor	%xmm0, %xmm2
movdqa	%xmm15, %xmm13
psllq	$0x13, %xmm13
pxor	%xmm2, %xmm13
movdqa	%xmm15, %xmm0
psrlq	$0x2d, %xmm0
movdqa	%xmm15, %xmm2
psllq	$0x2c, %xmm2
pxor	0xd0(%rsi,%rax), %xmm3
por	%xmm0, %xmm2
pxor	%xmm9, %xmm3
movdqa	%xmm15, %xmm0
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm3
movdqa	%xmm13, %xmm0
pslldq	$0x8, %xmm0
pxor	%xmm0, %xmm3
pxor	%xmm4, %xmm11
movdqa	%xmm6, %xmm9
pxor	%xmm1, %xmm9
pxor	%xmm9, %xmm11
pxor	-0x20(%rsp), %xmm11
pxor	%xmm3, %xmm11
movdqa	%xmm11, %xmm0
psrlq	$0x2f, %xmm0
movdqa	%xmm11, %xmm14
psrlq	$0x9, %xmm14
pxor	%xmm0, %xmm14
movdqa	%xmm11, %xmm3
psllq	$0x13, %xmm3
pxor	%xmm14, %xmm3
movdqa	%xmm11, %xmm0
psrlq	$0x2d, %xmm0
movdqa	%xmm11, %xmm14
psllq	$0x2c, %xmm14
por	%xmm0, %xmm14
psrlq	$0x14, %xmm15
movdqa	%xmm11, %xmm0
psllq	$0x37, %xmm0
shufps	$0x4e, %xmm15, %xmm5
pxor	%xmm0, %xmm5
movdqa	%xmm11, %xmm0
psrlq	$0x14, %xmm11
shufps	$0x4e, %xmm3, %xmm13
shufps	$0x4e, %xmm11, %xmm15
psrldq	$0x8, %xmm3
pxor	%xmm15, %xmm3
pxor	0xe0(%rsi,%rax), %xmm2
pxor	%xmm5, %xmm2
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm2
pxor	%xmm13, %xmm2
pxor	%xmm4, %xmm6
movdqa	-0x80(%rsp), %xmm15
pxor	%xmm4, %xmm15
pxor	%xmm8, %xmm4
movdqa	%xmm4, -0x80(%rsp)
movdqa	%xmm4, %xmm5
pxor	%xmm10, %xmm5
pxor	%xmm12, %xmm5
pxor	%xmm2, %xmm5
movdqa	%xmm5, %xmm4
psllq	$0x37, %xmm4
pxor	%xmm3, %xmm4
movdqa	%xmm5, %xmm2
psrlq	$0x2f, %xmm2
movdqa	%xmm5, %xmm3
psrlq	$0x9, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm5, %xmm2
psllq	$0x13, %xmm2
pxor	%xmm3, %xmm2
movdqa	%xmm5, %xmm12
psrlq	$0x2d, %xmm12
movdqa	%xmm5, %xmm3
psllq	$0x2c, %xmm3
por	%xmm12, %xmm3
movdqa	-0x10(%rsp), %xmm13
pxor	%xmm1, %xmm13
pxor	0xf0(%rsi,%rax), %xmm14
pxor	%xmm4, %xmm14
movdqa	%xmm5, %xmm1
psllq	$0x11, %xmm1
psrlq	$0x14, %xmm5
pxor	%xmm1, %xmm14
movdqa	%xmm2, %xmm1
pslldq	$0x8, %xmm1
pxor	%xmm1, %xmm14
movdqa	%xmm7, %xmm4
pxor	(%rsp), %xmm4
movdqa	-0x20(%rsp), %xmm7
pxor	%xmm7, %xmm4
pxor	%xmm13, %xmm4
pxor	%xmm14, %xmm4
movdqa	%xmm4, %xmm1
psrlq	$0x2f, %xmm1
movdqa	%xmm4, %xmm14
psrlq	$0x9, %xmm14
pxor	%xmm1, %xmm14
movdqa	%xmm4, %xmm12
psllq	$0x13, %xmm12
pxor	%xmm14, %xmm12
movdqa	%xmm4, %xmm14
psrlq	$0x2d, %xmm14
movdqa	%xmm4, %xmm1
psllq	$0x2c, %xmm1
por	%xmm14, %xmm1
movdqa	%xmm4, %xmm14
psllq	$0x37, %xmm14
shufps	$0x4e, %xmm5, %xmm11
pxor	%xmm14, %xmm11
movdqa	%xmm4, %xmm0
psrlq	$0x14, %xmm4
shufps	$0x4e, %xmm12, %xmm2
shufps	$0x4e, %xmm4, %xmm5
movdqa	%xmm4, %xmm14
psrldq	$0x8, %xmm12
pxor	%xmm5, %xmm12
pxor	0x100(%rsi,%rax), %xmm3
pxor	%xmm11, %xmm3
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm3
pxor	%xmm2, %xmm3
pxor	%xmm8, %xmm10
pxor	%xmm9, %xmm10
pxor	%xmm7, %xmm10
pxor	%xmm3, %xmm10
movdqa	%xmm10, %xmm4
psllq	$0x37, %xmm4
pxor	%xmm12, %xmm4
movdqa	%xmm10, %xmm2
psrlq	$0x2f, %xmm2
movdqa	%xmm10, %xmm3
psrlq	$0x9, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm10, %xmm2
psllq	$0x13, %xmm2
pxor	%xmm3, %xmm2
movdqa	%xmm10, %xmm5
psrlq	$0x2d, %xmm5
movdqa	%xmm10, %xmm3
psllq	$0x2c, %xmm3
por	%xmm5, %xmm3
pxor	0x110(%rsi,%rax), %xmm1
pxor	%xmm4, %xmm1
movdqa	%xmm10, %xmm4
psllq	$0x11, %xmm4
pxor	%xmm4, %xmm1
movdqa	%xmm2, %xmm4
pslldq	$0x8, %xmm4
pxor	%xmm4, %xmm1
psrlq	$0x14, %xmm10
pxor	%xmm8, %xmm6
pxor	%xmm13, %xmm6
pxor	%xmm1, %xmm6
movdqa	%xmm6, %xmm1
psrlq	$0x2f, %xmm1
movdqa	%xmm6, %xmm4
psrlq	$0x9, %xmm4
pxor	%xmm1, %xmm4
movdqa	%xmm6, %xmm1
psllq	$0x13, %xmm1
pxor	%xmm4, %xmm1
movdqa	%xmm6, %xmm5
psrlq	$0x2d, %xmm5
movdqa	%xmm6, %xmm4
psllq	$0x2c, %xmm4
por	%xmm5, %xmm4
movdqa	%xmm6, %xmm5
psllq	$0x37, %xmm5
shufps	$0x4e, %xmm10, %xmm14
pxor	%xmm5, %xmm14
movdqa	%xmm6, %xmm5
psrlq	$0x14, %xmm6
shufps	$0x4e, %xmm1, %xmm2
shufps	$0x4e, %xmm6, %xmm10
psrldq	$0x8, %xmm1
pxor	%xmm10, %xmm1
pxor	0x120(%rsi,%rax), %xmm3
pxor	%xmm14, %xmm3
psllq	$0x11, %xmm5
pxor	%xmm5, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm15, %xmm5
pxor	%xmm3, %xmm5
movdqa	%xmm5, %xmm3
psllq	$0x37, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm5, %xmm1
psrlq	$0x2f, %xmm1
movdqa	%xmm5, %xmm2
psrlq	$0x9, %xmm2
pxor	%xmm1, %xmm2
movdqa	%xmm5, %xmm9
psllq	$0x13, %xmm9
pxor	%xmm2, %xmm9
movdqa	%xmm5, %xmm1
psrlq	$0x2d, %xmm1
movdqa	%xmm5, %xmm2
psllq	$0x2c, %xmm2
por	%xmm1, %xmm2
movdqa	%xmm5, %xmm1
psllq	$0x11, %xmm1
pxor	0x130(%rsi,%rax), %xmm4
pxor	%xmm3, %xmm4
movdqa	%xmm9, %xmm3
pslldq	$0x8, %xmm3
pxor	%xmm1, %xmm4
pxor	%xmm3, %xmm4
pxor	-0x80(%rsp), %xmm4
movdqa	%xmm4, %xmm0
psrlq	$0x2f, %xmm0
movdqa	%xmm4, %xmm3
psrlq	$0x9, %xmm3
pxor	%xmm0, %xmm3
movdqa	%xmm4, %xmm1
psllq	$0x13, %xmm1
pxor	%xmm3, %xmm1
movdqa	%xmm4, %xmm0
psrlq	$0x2d, %xmm0
movdqa	%xmm4, %xmm3
psllq	$0x2c, %xmm3
por	%xmm0, %xmm3
psrlq	$0x14, %xmm5
shufps	$0x4e, %xmm5, %xmm6
pxor	%xmm2, %xmm6
movdqa	%xmm4, %xmm0
psllq	$0x37, %xmm0
pxor	%xmm0, %xmm6
movdqa	%xmm4, %xmm0
psllq	$0x11, %xmm0
pxor	%xmm0, %xmm6
shufps	$0x4e, %xmm1, %xmm9
pxor	%xmm6, %xmm9
psrlq	$0x14, %xmm4
shufps	$0x4e, %xmm4, %xmm5
pxor	%xmm3, %xmm5
psrldq	$0x8, %xmm1
pxor	%xmm5, %xmm1
psrldq	$0x8, %xmm4
leaq	0x140(%rax), %rcx
addq	$0x2a8, %rax
movdqa	%xmm4, %xmm6
cmpq	%rdx, %rax
movq	%rcx, %rax
jb	Lchorba_sse2__50
jmp	Lchorba_sse2__a78
Lchorba_sse2__a73:
xorl	%ecx, %ecx
xorps	%xmm1, %xmm1
Lchorba_sse2__a78:
leaq	0x48(%rcx), %rax
cmpq	%rdx, %rax
jae	Lchorba_sse2__bb7
nopw	%cs:(%rax,%rax)
Lchorba_sse2__a90:
pxor	(%rsi,%rcx), %xmm9
movdqa	%xmm9, %xmm0
psllq	$0x11, %xmm0
movdqa	%xmm9, %xmm5
psllq	$0x37, %xmm5
movdqa	%xmm9, %xmm2
psrlq	$0x2f, %xmm2
movdqa	%xmm9, %xmm3
psrlq	$0x9, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm9, %xmm2
psllq	$0x13, %xmm2
pxor	%xmm3, %xmm2
movdqa	%xmm9, %xmm6
psrlq	$0x2d, %xmm6
movdqa	%xmm9, %xmm3
psllq	$0x2c, %xmm3
por	%xmm6, %xmm3
psrlq	$0x14, %xmm9
movdqa	%xmm2, %xmm6
pslldq	$0x8, %xmm6
xorps	0x10(%rsi,%rcx), %xmm1
xorps	%xmm5, %xmm1
xorps	%xmm0, %xmm1
xorps	%xmm6, %xmm1
movaps	%xmm1, %xmm5
psllq	$0x11, %xmm5
movaps	%xmm1, %xmm7
psllq	$0x37, %xmm7
movaps	%xmm1, %xmm0
psrlq	$0x2f, %xmm0
movaps	%xmm1, %xmm8
psrlq	$0x9, %xmm8
pxor	%xmm0, %xmm8
movaps	%xmm1, %xmm6
psllq	$0x13, %xmm6
pxor	%xmm8, %xmm6
movaps	%xmm1, %xmm0
psrlq	$0x2d, %xmm0
movaps	%xmm1, %xmm8
psllq	$0x2c, %xmm8
por	%xmm0, %xmm8
psrlq	$0x14, %xmm1
shufps	$0x4e, %xmm6, %xmm2
movdqa	%xmm9, %xmm0
pslldq	$0x8, %xmm0
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm0
pxor	%xmm7, %xmm0
pxor	%xmm5, %xmm0
pxor	%xmm2, %xmm0
psrldq	$0x8, %xmm6
shufps	$0x4e, %xmm1, %xmm9
pxor	%xmm8, %xmm9
movdqa	%xmm9, %xmm2
pxor	%xmm6, %xmm2
movdqa	%xmm1, %xmm4
psrldq	$0x8, %xmm4
leaq	0x20(%rcx), %rax
addq	$0x68, %rcx
movdqa	%xmm0, %xmm9
movdqa	%xmm2, %xmm1
cmpq	%rdx, %rcx
movq	%rax, %rcx
jb	Lchorba_sse2__a90
jmp	Lchorba_sse2__bc2
Lchorba_sse2__bb7:
movq	%rcx, %rax
movaps	%xmm1, %xmm2
movdqa	%xmm9, %xmm0
Lchorba_sse2__bc2:
movq	%rdx, %rcx
subq	%rax, %rcx
addq	%rax, %rsi
leaq	-0x70(%rsp), %rdi
movq	%rcx, %r8
cmpq	$0x40, %rcx
jb	Lchorba_sse2__c12
nopl	(%rax)
Lchorba_sse2__be0:
movaps	(%rsi), %xmm1
movaps	%xmm1, (%rdi)
movaps	0x10(%rsi), %xmm1
movaps	%xmm1, 0x10(%rdi)
movaps	0x20(%rsi), %xmm1
movaps	%xmm1, 0x20(%rdi)
movdqa	0x30(%rsi), %xmm1
addq	$0x40, %rsi
movdqa	%xmm1, 0x30(%rdi)
addq	$0x40, %rdi
addq	$-0x40, %r8
cmpq	$0x3f, %r8
ja	Lchorba_sse2__be0
Lchorba_sse2__c12:
cmpq	$0x10, %r8
jb	Lchorba_sse2__cd2
leaq	-0x10(%r8), %r9
movl	%r9d, %r10d
notl	%r10d
testb	$0x70, %r10b
je	Lchorba_sse2__c6e
movl	%r9d, %r10d
shrl	$0x4, %r10d
incl	%r10d
andl	$0x7, %r10d
shll	$0x4, %r10d
xorl	%r11d, %r11d
nopw	%cs:(%rax,%rax)
Lchorba_sse2__c50:
movdqa	(%rsi,%r11), %xmm1
movdqa	%xmm1, (%rdi,%r11)
addq	$0x10, %r11
cmpq	%r11, %r10
jne	Lchorba_sse2__c50
addq	%r11, %rsi
addq	%r11, %rdi
subq	%r11, %r8
Lchorba_sse2__c6e:
cmpq	$0x70, %r9
jb	Lchorba_sse2__cd2
nopw	%cs:(%rax,%rax)
Lchorba_sse2__c80:
movaps	(%rsi), %xmm1
movaps	%xmm1, (%rdi)
movaps	0x10(%rsi), %xmm1
movaps	%xmm1, 0x10(%rdi)
movaps	0x20(%rsi), %xmm1
movaps	%xmm1, 0x20(%rdi)
movaps	0x30(%rsi), %xmm1
movaps	%xmm1, 0x30(%rdi)
movaps	0x40(%rsi), %xmm1
movaps	%xmm1, 0x40(%rdi)
movaps	0x50(%rsi), %xmm1
movaps	%xmm1, 0x50(%rdi)
movaps	0x60(%rsi), %xmm1
movaps	%xmm1, 0x60(%rdi)
movdqa	0x70(%rsi), %xmm1
subq	$-0x80, %rsi
movdqa	%xmm1, 0x70(%rdi)
subq	$-0x80, %rdi
addq	$-0x80, %r8
cmpq	$0xf, %r8
ja	Lchorba_sse2__c80
Lchorba_sse2__cd2:
movq	%xmm4, %r9
testq	%r8, %r8
je	Lchorba_sse2__d8f
movq	%r8, %r10
andq	$0x7, %r10
je	Lchorba_sse2__d15
xorl	%r11d, %r11d
nopl	(%rax)
Lchorba_sse2__cf0:
movzbl	(%rsi,%r11), %ebx
movb	%bl, (%rdi,%r11)
incq	%r11
cmpq	%r11, %r10
jne	Lchorba_sse2__cf0
addq	%r11, %rdi
addq	%r11, %rsi
movq	%r8, %r10
subq	%r11, %r10
cmpq	$0x8, %r8
jae	Lchorba_sse2__d1e
jmp	Lchorba_sse2__d8f
Lchorba_sse2__d15:
movq	%r8, %r10
cmpq	$0x8, %r8
jb	Lchorba_sse2__d8f
Lchorba_sse2__d1e:
xorl	%r8d, %r8d
nopw	%cs:(%rax,%rax)
Lchorba_sse2__d30:
movzbl	(%rsi,%r8), %r11d
movb	%r11b, (%rdi,%r8)
movzbl	0x1(%rsi,%r8), %r11d
movb	%r11b, 0x1(%rdi,%r8)
movzbl	0x2(%rsi,%r8), %r11d
movb	%r11b, 0x2(%rdi,%r8)
movzbl	0x3(%rsi,%r8), %r11d
movb	%r11b, 0x3(%rdi,%r8)
movzbl	0x4(%rsi,%r8), %r11d
movb	%r11b, 0x4(%rdi,%r8)
movzbl	0x5(%rsi,%r8), %r11d
movb	%r11b, 0x5(%rdi,%r8)
movzbl	0x6(%rsi,%r8), %r11d
movb	%r11b, 0x6(%rdi,%r8)
movzbl	0x7(%rsi,%r8), %r11d
movb	%r11b, 0x7(%rdi,%r8)
addq	$0x8, %r8
cmpq	%r8, %r10
jne	Lchorba_sse2__d30
Lchorba_sse2__d8f:
pxor	-0x70(%rsp), %xmm0
movdqa	%xmm0, -0x70(%rsp)
pxor	-0x60(%rsp), %xmm2
movdqa	%xmm2, -0x60(%rsp)
xorq	%r9, -0x50(%rsp)
testq	%rcx, %rcx
je	Lchorba_sse2__dc2
incq	%rax
cmpq	%rax, %rdx
jne	Lchorba_sse2__dc6
xorl	%eax, %eax
leaq	-0x70(%rsp), %rdx
jmp	Lchorba_sse2__e0f
Lchorba_sse2__dc2:
xorl	%eax, %eax
jmp	Lchorba_sse2__e29
Lchorba_sse2__dc6:
movq	%rcx, %rsi
andq	$-0x2, %rsi
xorl	%eax, %eax
leaq	-0x70(%rsp), %rdx
leaq	chorba_sse2__crc_table(%rip), %rdi
nopl	(%rax,%rax)
Lchorba_sse2__de0:
movzbl	(%rdx), %r8d
xorb	%al, %r8b
movzbl	%r8b, %r8d
shrl	$0x8, %eax
xorl	(%rdi,%r8,4), %eax
movzbl	0x1(%rdx), %r8d
xorb	%al, %r8b
addq	$0x2, %rdx
movzbl	%r8b, %r8d
shrl	$0x8, %eax
xorl	(%rdi,%r8,4), %eax
addq	$-0x2, %rsi
jne	Lchorba_sse2__de0
Lchorba_sse2__e0f:
testb	$0x1, %cl
je	Lchorba_sse2__e29
movzbl	(%rdx), %ecx
xorb	%al, %cl
movzbl	%cl, %ecx
leaq	chorba_sse2__crc_table(%rip), %rdx
shrl	$0x8, %eax
xorl	(%rdx,%rcx,4), %eax
Lchorba_sse2__e29:
addq	$0x10, %rsp
popq	%rbx
retq
nop
crc32_chorba_sse2:
pushq	%r15
pushq	%r14
pushq	%rbx
notl	%edi
movl	%esi, %ebx
negl	%ebx
andl	$0xf, %ebx
leaq	0x48(%rbx), %rax
cmpq	%rax, %rdx
jbe	Lchorba_sse2__e78
testq	%rbx, %rbx
je	Lchorba_sse2__e65
movq	%rsi, %r14
movq	%rdx, %r15
movq	%rbx, %rdx
callq	crc32_braid_internal
movq	%r14, %rsi
movq	%r15, %rdx
movl	%eax, %edi
subq	%rbx, %rdx
Lchorba_sse2__e65:
addq	%rbx, %rsi
cmpq	$0x80001, %rdx
jb	Lchorba_sse2__e7f
callq	crc32_chorba_118960_nondestructive
jmp	Lchorba_sse2__e84
Lchorba_sse2__e78:
callq	crc32_braid_internal
jmp	Lchorba_sse2__e84
Lchorba_sse2__e7f:
callq	chorba_small_nondestructive_sse2
Lchorba_sse2__e84:
notl	%eax
popq	%rbx
popq	%r14
popq	%r15
retq
	.section .rodata
chorba_sse2__crc_table:
	.size chorba_sse2__crc_table, 1024
	.byte 0,0,0,0,150,48,7,119,44,97,14,238,186,81,9,153
	.byte 25,196,109,7,143,244,106,112,53,165,99,233,163,149,100,158
	.byte 50,136,219,14,164,184,220,121,30,233,213,224,136,217,210,151
	.byte 43,76,182,9,189,124,177,126,7,45,184,231,145,29,191,144
	.byte 100,16,183,29,242,32,176,106,72,113,185,243,222,65,190,132
	.byte 125,212,218,26,235,228,221,109,81,181,212,244,199,133,211,131
	.byte 86,152,108,19,192,168,107,100,122,249,98,253,236,201,101,138
	.byte 79,92,1,20,217,108,6,99,99,61,15,250,245,13,8,141
	.byte 200,32,110,59,94,16,105,76,228,65,96,213,114,113,103,162
	.byte 209,228,3,60,71,212,4,75,253,133,13,210,107,181,10,165
	.byte 250,168,181,53,108,152,178,66,214,201,187,219,64,249,188,172
	.byte 227,108,216,50,117,92,223,69,207,13,214,220,89,61,209,171
	.byte 172,48,217,38,58,0,222,81,128,81,215,200,22,97,208,191
	.byte 181,244,180,33,35,196,179,86,153,149,186,207,15,165,189,184
	.byte 158,184,2,40,8,136,5,95,178,217,12,198,36,233,11,177
	.byte 135,124,111,47,17,76,104,88,171,29,97,193,61,45,102,182
	.byte 144,65,220,118,6,113,219,1,188,32,210,152,42,16,213,239
	.byte 137,133,177,113,31,181,182,6,165,228,191,159,51,212,184,232
	.byte 162,201,7,120,52,249,0,15,142,168,9,150,24,152,14,225
	.byte 187,13,106,127,45,61,109,8,151,108,100,145,1,92,99,230
	.byte 244,81,107,107,98,97,108,28,216,48,101,133,78,0,98,242
	.byte 237,149,6,108,123,165,1,27,193,244,8,130,87,196,15,245
	.byte 198,217,176,101,80,233,183,18,234,184,190,139,124,136,185,252
	.byte 223,29,221,98,73,45,218,21,243,124,211,140,101,76,212,251
	.byte 88,97,178,77,206,81,181,58,116,0,188,163,226,48,187,212
	.byte 65,165,223,74,215,149,216,61,109,196,209,164,251,244,214,211
	.byte 106,233,105,67,252,217,110,52,70,136,103,173,208,184,96,218
	.byte 115,45,4,68,229,29,3,51,95,76,10,170,201,124,13,221
	.byte 60,113,5,80,170,65,2,39,16,16,11,190,134,32,12,201
	.byte 37,181,104,87,179,133,111,32,9,212,102,185,159,228,97,206
	.byte 14,249,222,94,152,201,217,41,34,152,208,176,180,168,215,199
	.byte 23,61,179,89,129,13,180,46,59,92,189,183,173,108,186,192
	.byte 32,131,184,237,182,179,191,154,12,226,182,3,154,210,177,116
	.byte 57,71,213,234,175,119,210,157,21,38,219,4,131,22,220,115
	.byte 18,11,99,227,132,59,100,148,62,106,109,13,168,90,106,122
	.byte 11,207,14,228,157,255,9,147,39,174,0,10,177,158,7,125
	.byte 68,147,15,240,210,163,8,135,104,242,1,30,254,194,6,105
	.byte 93,87,98,247,203,103,101,128,113,54,108,25,231,6,107,110
	.byte 118,27,212,254,224,43,211,137,90,122,218,16,204,74,221,103
	.byte 111,223,185,249,249,239,190,142,67,190,183,23,213,142,176,96
	.byte 232,163,214,214,126,147,209,161,196,194,216,56,82,242,223,79
	.byte 241,103,187,209,103,87,188,166,221,6,181,63,75,54,178,72
	.byte 218,43,13,216,76,27,10,175,246,74,3,54,96,122,4,65
	.byte 195,239,96,223,85,223,103,168,239,142,110,49,121,190,105,70
	.byte 140,179,97,203,26,131,102,188,160,210,111,37,54,226,104,82
	.byte 149,119,12,204,3,71,11,187,185,22,2,34,47,38,5,85
	.byte 190,59,186,197,40,11,189,178,146,90,180,43,4,106,179,92
	.byte 167,255,215,194,49,207,208,181,139,158,217,44,29,174,222,91
	.byte 176,194,100,155,38,242,99,236,156,163,106,117,10,147,109,2
	.byte 169,6,9,156,63,54,14,235,133,103,7,114,19,87,0,5
	.byte 130,74,191,149,20,122,184,226,174,43,177,123,56,27,182,12
	.byte 155,142,210,146,13,190,213,229,183,239,220,124,33,223,219,11
	.byte 212,210,211,134,66,226,212,241,248,179,221,104,110,131,218,31
	.byte 205,22,190,129,91,38,185,246,225,119,176,111,119,71,183,24
	.byte 230,90,8,136,112,106,15,255,202,59,6,102,92,11,1,17
	.byte 255,158,101,143,105,174,98,248,211,255,107,97,69,207,108,22
	.byte 120,226,10,160,238,210,13,215,84,131,4,78,194,179,3,57
	.byte 97,38,103,167,247,22,96,208,77,71,105,73,219,119,110,62
	.byte 74,106,209,174,220,90,214,217,102,11,223,64,240,59,216,55
	.byte 83,174,188,169,197,158,187,222,127,207,178,71,233,255,181,48
	.byte 28,242,189,189,138,194,186,202,48,147,179,83,166,163,180,36
	.byte 5,54,208,186,147,6,215,205,41,87,222,84,191,103,217,35
	.byte 46,122,102,179,184,74,97,196,2,27,104,93,148,43,111,42
	.byte 55,190,11,180,161,142,12,195,27,223,5,90,141,239,2,45
# ---- crc32_braid_c.S, for crc32_braid_internal
	.text
	.text
crc32_braid_internal:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
movq	%rdx, %r9
movq	%rsi, %r15
cmpq	$0x2f, %rdx
jb	Lcrc32_braid_c__727
testb	$0x7, %r15b
je	Lcrc32_braid_c__1aa
movzbl	(%r15), %eax
xorb	%dil, %al
movzbl	%al, %ecx
leaq	crc32_braid_c__crc_table(%rip), %rax
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x1(%r15), %rcx
movq	%r9, %rdx
decq	%rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
movzbl	0x1(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x2(%r15), %rcx
movq	%r9, %rdx
addq	$-0x2, %rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
movzbl	0x2(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x3(%r15), %rcx
movq	%r9, %rdx
addq	$-0x3, %rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
movzbl	0x3(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x4(%r15), %rcx
movq	%r9, %rdx
addq	$-0x4, %rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
movzbl	0x4(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x5(%r15), %rcx
movq	%r9, %rdx
addq	$-0x5, %rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
movzbl	0x5(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x6(%r15), %rcx
movq	%r9, %rdx
addq	$-0x6, %rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
movzbl	0x6(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
leaq	0x7(%r15), %rcx
movq	%r9, %rdx
addq	$-0x7, %rdx
setne	%sil
testb	$0x7, %cl
setne	%r8b
andb	%sil, %r8b
cmpb	$0x1, %r8b
jne	Lcrc32_braid_c__1a4
addq	$-0x8, %r9
movzbl	0x7(%r15), %ecx
xorb	%dil, %cl
addq	$0x8, %r15
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
jmp	Lcrc32_braid_c__1aa
Lcrc32_braid_c__1a4:
movq	%rdx, %r9
movq	%rcx, %r15
Lcrc32_braid_c__1aa:
movabsq	$-0x3333333333333333, %rcx
movq	%r9, %rax
mulq	%rcx
shrq	$0x5, %rdx
leaq	(,%rdx,8), %rax
leaq	(%rax,%rax,4), %r8
movl	%edi, %eax
decq	%rdx
je	Lcrc32_braid_c__4b6
movq	%r8, -0x28(%rsp)
movq	%r9, -0x18(%rsp)
xorl	%r10d, %r10d
leaq	crc_braid_table(%rip), %rdi
xorl	%r11d, %r11d
xorl	%ecx, %ecx
xorl	%ebx, %ebx
movq	%r15, -0x20(%rsp)
nopw	%cs:(%rax,%rax)
Lcrc32_braid_c__200:
movq	%r15, -0x30(%rsp)
movq	%rdx, -0x8(%rsp)
movq	(%r15), %rdx
movq	%rdx, -0x10(%rsp)
xorl	%edx, %eax
movzbl	%al, %esi
movl	(%rdi,%rsi,4), %ebp
movzbl	%ah, %esi
xorl	0x400(%rdi,%rsi,4), %ebp
movl	%eax, %esi
shrl	$0xe, %esi
andl	$0x3fc, %esi
xorl	0x800(%rsi,%rdi), %ebp
shrl	$0x18, %eax
xorl	0xc00(%rdi,%rax,4), %ebp
movq	-0x30(%rsp), %rax
movq	0x8(%rax), %r15
xorl	%r15d, %ebx
movzbl	%bl, %edx
movl	(%rdi,%rdx,4), %r12d
movzbl	%bh, %edx
xorl	0x400(%rdi,%rdx,4), %r12d
movl	%ebx, %edx
shrl	$0xe, %edx
andl	$0x3fc, %edx
xorl	0x800(%rdx,%rdi), %r12d
shrl	$0x18, %ebx
xorl	0xc00(%rdi,%rbx,4), %r12d
movq	-0x30(%rsp), %rax
movq	0x10(%rax), %r9
xorl	%r9d, %ecx
movq	-0x30(%rsp), %rax
movq	0x18(%rax), %r8
xorl	%r8d, %r11d
movq	-0x30(%rsp), %rax
movq	0x20(%rax), %r13
movq	%r10, %rax
xorl	%r13d, %eax
movzbl	%cl, %edx
movl	(%rdi,%rdx,4), %esi
movzbl	%r11b, %edx
movl	(%rdi,%rdx,4), %r14d
movzbl	%ch, %edx
xorl	0x400(%rdi,%rdx,4), %esi
movzbl	%al, %edx
movq	%r11, %rbx
movzbl	%bh, %ebx
xorl	0x400(%rdi,%rbx,4), %r14d
movl	(%rdi,%rdx,4), %r10d
movzbl	%ah, %edx
xorl	0x400(%rdi,%rdx,4), %r10d
movl	%ecx, %edx
shrl	$0xe, %edx
andl	$0x3fc, %edx
xorl	0x800(%rdx,%rdi), %esi
movl	%r11d, %edx
shrl	$0xe, %edx
andl	$0x3fc, %edx
xorl	0x800(%rdx,%rdi), %r14d
movl	%eax, %edx
shrl	$0xe, %edx
andl	$0x3fc, %edx
xorl	0x800(%rdx,%rdi), %r10d
shrl	$0x18, %ecx
xorl	0xc00(%rdi,%rcx,4), %esi
shrl	$0x18, %r11d
xorl	0xc00(%rdi,%r11,4), %r14d
shrl	$0x18, %eax
xorl	0xc00(%rdi,%rax,4), %r10d
movq	-0x10(%rsp), %rcx
movq	%rcx, %rax
shrq	$0x20, %rax
movzbl	%al, %eax
xorl	0x1000(%rdi,%rax,4), %ebp
movq	%r15, %rax
shrq	$0x20, %rax
movzbl	%al, %eax
xorl	0x1000(%rdi,%rax,4), %r12d
movq	%r9, %rax
shrq	$0x20, %rax
movzbl	%al, %eax
xorl	0x1000(%rdi,%rax,4), %esi
movq	%r8, %rax
shrq	$0x20, %rax
movzbl	%al, %eax
xorl	0x1000(%rdi,%rax,4), %r14d
movq	%r13, %rax
shrq	$0x20, %rax
movzbl	%al, %eax
xorl	0x1000(%rdi,%rax,4), %r10d
movq	%rcx, %rax
shrq	$0x28, %rax
movzbl	%al, %eax
xorl	0x1400(%rdi,%rax,4), %ebp
movq	%r15, %rax
shrq	$0x28, %rax
movzbl	%al, %eax
xorl	0x1400(%rdi,%rax,4), %r12d
movq	%r9, %rax
shrq	$0x28, %rax
movzbl	%al, %eax
xorl	0x1400(%rdi,%rax,4), %esi
movq	%r8, %rax
shrq	$0x28, %rax
movzbl	%al, %eax
xorl	0x1400(%rdi,%rax,4), %r14d
movq	%r13, %rax
shrq	$0x28, %rax
movzbl	%al, %eax
xorl	0x1400(%rdi,%rax,4), %r10d
movq	%rcx, %rax
shrq	$0x30, %rax
movzbl	%al, %eax
xorl	0x1800(%rdi,%rax,4), %ebp
movq	%r15, %rax
shrq	$0x30, %rax
movzbl	%al, %eax
xorl	0x1800(%rdi,%rax,4), %r12d
movq	%r9, %rax
shrq	$0x30, %rax
movzbl	%al, %eax
xorl	0x1800(%rdi,%rax,4), %esi
movq	%r8, %rax
shrq	$0x30, %rax
movzbl	%al, %eax
xorl	0x1800(%rdi,%rax,4), %r14d
movq	%r13, %rax
shrq	$0x30, %rax
movzbl	%al, %eax
xorl	0x1800(%rdi,%rax,4), %r10d
shrq	$0x38, %rcx
movl	%ebp, %eax
xorl	0x1c00(%rdi,%rcx,4), %eax
shrq	$0x38, %r15
movl	%r12d, %ebx
xorl	0x1c00(%rdi,%r15,4), %ebx
shrq	$0x38, %r9
movl	%esi, %ecx
movq	-0x30(%rsp), %r15
movq	-0x8(%rsp), %rdx
xorl	0x1c00(%rdi,%r9,4), %ecx
shrq	$0x38, %r8
movl	%r14d, %r11d
xorl	0x1c00(%rdi,%r8,4), %r11d
shrq	$0x38, %r13
xorl	0x1c00(%rdi,%r13,4), %r10d
addq	$0x28, %r15
decq	%rdx
jne	Lcrc32_braid_c__200
movq	-0x20(%rsp), %r15
movq	-0x28(%rsp), %r8
addq	%r8, %r15
addq	$-0x28, %r15
movq	-0x18(%rsp), %r9
jmp	Lcrc32_braid_c__4c0
Lcrc32_braid_c__4b6:
xorl	%ebx, %ebx
xorl	%ecx, %ecx
xorl	%r11d, %r11d
xorl	%r10d, %r10d
Lcrc32_braid_c__4c0:
xorq	(%r15), %rax
movq	%rax, %rsi
movzbl	%al, %edx
shrq	$0x8, %rsi
leaq	crc32_braid_c__crc_table(%rip), %r14
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
xorl	(%r14,%rsi,4), %edx
xorq	0x8(%r15), %rbx
xorq	%rdx, %rbx
movq	%rbx, %rdx
movzbl	%bl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
movl	(%r14,%rdx,4), %edx
xorq	%rsi, %rdx
movzbl	%dl, %esi
shrq	$0x8, %rdx
movl	(%r14,%rsi,4), %esi
xorq	%rdx, %rsi
movzbl	%sil, %edx
shrq	$0x8, %rsi
xorl	(%r14,%rdx,4), %esi
xorq	0x10(%r15), %rcx
xorq	%rsi, %rcx
movq	%rcx, %rdx
movzbl	%cl, %ecx
shrq	$0x8, %rdx
movl	(%r14,%rcx,4), %ecx
xorq	%rdx, %rcx
movzbl	%cl, %edx
shrq	$0x8, %rcx
movl	(%r14,%rdx,4), %edx
xorq	%rcx, %rdx
movzbl	%dl, %ecx
shrq	$0x8, %rdx
movl	(%r14,%rcx,4), %ecx
xorq	%rdx, %rcx
movzbl	%cl, %edx
shrq	$0x8, %rcx
movl	(%r14,%rdx,4), %edx
xorq	%rcx, %rdx
movzbl	%dl, %ecx
shrq	$0x8, %rdx
movl	(%r14,%rcx,4), %ecx
xorq	%rdx, %rcx
movzbl	%cl, %edx
shrq	$0x8, %rcx
movl	(%r14,%rdx,4), %edx
xorq	%rcx, %rdx
movzbl	%dl, %ecx
shrq	$0x8, %rdx
movl	(%r14,%rcx,4), %ecx
xorq	%rdx, %rcx
movzbl	%cl, %edx
shrq	$0x8, %rcx
xorl	(%r14,%rdx,4), %ecx
xorq	0x18(%r15), %r11
xorq	%rcx, %r11
movq	%r11, %rcx
movzbl	%r11b, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %ecx
xorq	%rax, %rcx
movzbl	%cl, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %ecx
xorq	%rax, %rcx
movzbl	%cl, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %ecx
xorq	%rax, %rcx
movzbl	%cl, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
xorl	(%r14,%rcx,4), %eax
xorq	0x20(%r15), %r10
xorq	%rax, %r10
movq	%r10, %rax
movzbl	%r10b, %ecx
subq	%r8, %r9
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %ecx
xorq	%rax, %rcx
movzbl	%cl, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %ecx
xorq	%rax, %rcx
movzbl	%cl, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %ecx
xorq	%rax, %rcx
movzbl	%cl, %eax
shrq	$0x8, %rcx
movl	(%r14,%rax,4), %eax
xorq	%rcx, %rax
movzbl	%al, %ecx
shrq	$0x8, %rax
movl	(%r14,%rcx,4), %edi
xorq	%rax, %rdi
movzbl	%dil, %eax
shrq	$0x8, %rdi
xorl	(%r14,%rax,4), %edi
addq	$0x28, %r15
Lcrc32_braid_c__727:
cmpq	$0x8, %r9
jb	Lcrc32_braid_c__7d9
leaq	crc32_braid_c__crc_table(%rip), %rax
nopl	(%rax,%rax)
Lcrc32_braid_c__740:
addq	$-0x8, %r9
movzbl	(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x1(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x2(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x3(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x4(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x5(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x6(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
movzbl	0x7(%r15), %ecx
xorb	%dil, %cl
addq	$0x8, %r15
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x7, %r9
ja	Lcrc32_braid_c__740
Lcrc32_braid_c__7d9:
testq	%r9, %r9
je	Lcrc32_braid_c__887
movzbl	(%r15), %eax
xorb	%dil, %al
movzbl	%al, %ecx
leaq	crc32_braid_c__crc_table(%rip), %rax
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x1, %r9
je	Lcrc32_braid_c__887
movzbl	0x1(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x2, %r9
je	Lcrc32_braid_c__887
movzbl	0x2(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x3, %r9
je	Lcrc32_braid_c__887
movzbl	0x3(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x4, %r9
je	Lcrc32_braid_c__887
movzbl	0x4(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x5, %r9
je	Lcrc32_braid_c__887
movzbl	0x5(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
cmpq	$0x6, %r9
je	Lcrc32_braid_c__887
movzbl	0x6(%r15), %ecx
xorb	%dil, %cl
movzbl	%cl, %ecx
shrl	$0x8, %edi
xorl	(%rax,%rcx,4), %edi
Lcrc32_braid_c__887:
movl	%edi, %eax
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
nopw	%cs:(%rax,%rax)
crc32_braid:
pushq	%rax
notl	%edi
callq	crc32_braid_internal
notl	%eax
popq	%rcx
retq
	.section .rodata
crc32_braid_c__crc_table:
	.size crc32_braid_c__crc_table, 1024
	.byte 0,0,0,0,150,48,7,119,44,97,14,238,186,81,9,153
	.byte 25,196,109,7,143,244,106,112,53,165,99,233,163,149,100,158
	.byte 50,136,219,14,164,184,220,121,30,233,213,224,136,217,210,151
	.byte 43,76,182,9,189,124,177,126,7,45,184,231,145,29,191,144
	.byte 100,16,183,29,242,32,176,106,72,113,185,243,222,65,190,132
	.byte 125,212,218,26,235,228,221,109,81,181,212,244,199,133,211,131
	.byte 86,152,108,19,192,168,107,100,122,249,98,253,236,201,101,138
	.byte 79,92,1,20,217,108,6,99,99,61,15,250,245,13,8,141
	.byte 200,32,110,59,94,16,105,76,228,65,96,213,114,113,103,162
	.byte 209,228,3,60,71,212,4,75,253,133,13,210,107,181,10,165
	.byte 250,168,181,53,108,152,178,66,214,201,187,219,64,249,188,172
	.byte 227,108,216,50,117,92,223,69,207,13,214,220,89,61,209,171
	.byte 172,48,217,38,58,0,222,81,128,81,215,200,22,97,208,191
	.byte 181,244,180,33,35,196,179,86,153,149,186,207,15,165,189,184
	.byte 158,184,2,40,8,136,5,95,178,217,12,198,36,233,11,177
	.byte 135,124,111,47,17,76,104,88,171,29,97,193,61,45,102,182
	.byte 144,65,220,118,6,113,219,1,188,32,210,152,42,16,213,239
	.byte 137,133,177,113,31,181,182,6,165,228,191,159,51,212,184,232
	.byte 162,201,7,120,52,249,0,15,142,168,9,150,24,152,14,225
	.byte 187,13,106,127,45,61,109,8,151,108,100,145,1,92,99,230
	.byte 244,81,107,107,98,97,108,28,216,48,101,133,78,0,98,242
	.byte 237,149,6,108,123,165,1,27,193,244,8,130,87,196,15,245
	.byte 198,217,176,101,80,233,183,18,234,184,190,139,124,136,185,252
	.byte 223,29,221,98,73,45,218,21,243,124,211,140,101,76,212,251
	.byte 88,97,178,77,206,81,181,58,116,0,188,163,226,48,187,212
	.byte 65,165,223,74,215,149,216,61,109,196,209,164,251,244,214,211
	.byte 106,233,105,67,252,217,110,52,70,136,103,173,208,184,96,218
	.byte 115,45,4,68,229,29,3,51,95,76,10,170,201,124,13,221
	.byte 60,113,5,80,170,65,2,39,16,16,11,190,134,32,12,201
	.byte 37,181,104,87,179,133,111,32,9,212,102,185,159,228,97,206
	.byte 14,249,222,94,152,201,217,41,34,152,208,176,180,168,215,199
	.byte 23,61,179,89,129,13,180,46,59,92,189,183,173,108,186,192
	.byte 32,131,184,237,182,179,191,154,12,226,182,3,154,210,177,116
	.byte 57,71,213,234,175,119,210,157,21,38,219,4,131,22,220,115
	.byte 18,11,99,227,132,59,100,148,62,106,109,13,168,90,106,122
	.byte 11,207,14,228,157,255,9,147,39,174,0,10,177,158,7,125
	.byte 68,147,15,240,210,163,8,135,104,242,1,30,254,194,6,105
	.byte 93,87,98,247,203,103,101,128,113,54,108,25,231,6,107,110
	.byte 118,27,212,254,224,43,211,137,90,122,218,16,204,74,221,103
	.byte 111,223,185,249,249,239,190,142,67,190,183,23,213,142,176,96
	.byte 232,163,214,214,126,147,209,161,196,194,216,56,82,242,223,79
	.byte 241,103,187,209,103,87,188,166,221,6,181,63,75,54,178,72
	.byte 218,43,13,216,76,27,10,175,246,74,3,54,96,122,4,65
	.byte 195,239,96,223,85,223,103,168,239,142,110,49,121,190,105,70
	.byte 140,179,97,203,26,131,102,188,160,210,111,37,54,226,104,82
	.byte 149,119,12,204,3,71,11,187,185,22,2,34,47,38,5,85
	.byte 190,59,186,197,40,11,189,178,146,90,180,43,4,106,179,92
	.byte 167,255,215,194,49,207,208,181,139,158,217,44,29,174,222,91
	.byte 176,194,100,155,38,242,99,236,156,163,106,117,10,147,109,2
	.byte 169,6,9,156,63,54,14,235,133,103,7,114,19,87,0,5
	.byte 130,74,191,149,20,122,184,226,174,43,177,123,56,27,182,12
	.byte 155,142,210,146,13,190,213,229,183,239,220,124,33,223,219,11
	.byte 212,210,211,134,66,226,212,241,248,179,221,104,110,131,218,31
	.byte 205,22,190,129,91,38,185,246,225,119,176,111,119,71,183,24
	.byte 230,90,8,136,112,106,15,255,202,59,6,102,92,11,1,17
	.byte 255,158,101,143,105,174,98,248,211,255,107,97,69,207,108,22
	.byte 120,226,10,160,238,210,13,215,84,131,4,78,194,179,3,57
	.byte 97,38,103,167,247,22,96,208,77,71,105,73,219,119,110,62
	.byte 74,106,209,174,220,90,214,217,102,11,223,64,240,59,216,55
	.byte 83,174,188,169,197,158,187,222,127,207,178,71,233,255,181,48
	.byte 28,242,189,189,138,194,186,202,48,147,179,83,166,163,180,36
	.byte 5,54,208,186,147,6,215,205,41,87,222,84,191,103,217,35
	.byte 46,122,102,179,184,74,97,196,2,27,104,93,148,43,111,42
	.byte 55,190,11,180,161,142,12,195,27,223,5,90,141,239,2,45
crc_braid_table:
	.size crc_braid_table, 8192
	.byte 0,0,0,0,71,146,68,175,207,34,248,133,136,176,188,42
	.byte 223,67,129,208,152,209,197,127,16,97,121,85,87,243,61,250
	.byte 255,129,115,122,184,19,55,213,48,163,139,255,119,49,207,80
	.byte 32,194,242,170,103,80,182,5,239,224,10,47,168,114,78,128
	.byte 254,3,231,244,185,145,163,91,49,33,31,113,118,179,91,222
	.byte 33,64,102,36,102,210,34,139,238,98,158,161,169,240,218,14
	.byte 1,130,148,142,70,16,208,33,206,160,108,11,137,50,40,164
	.byte 222,193,21,94,153,83,81,241,17,227,237,219,86,113,169,116
	.byte 189,1,191,50,250,147,251,157,114,35,71,183,53,177,3,24
	.byte 98,66,62,226,37,208,122,77,173,96,198,103,234,242,130,200
	.byte 66,128,204,72,5,18,136,231,141,162,52,205,202,48,112,98
	.byte 157,195,77,152,218,81,9,55,82,225,181,29,21,115,241,178
	.byte 67,2,88,198,4,144,28,105,140,32,160,67,203,178,228,236
	.byte 156,65,217,22,219,211,157,185,83,99,33,147,20,241,101,60
	.byte 188,131,43,188,251,17,111,19,115,161,211,57,52,51,151,150
	.byte 99,192,170,108,36,82,238,195,172,226,82,233,235,112,22,70
	.byte 122,3,126,101,61,145,58,202,181,33,134,224,242,179,194,79
	.byte 165,64,255,181,226,210,187,26,106,98,7,48,45,240,67,159
	.byte 133,130,13,31,194,16,73,176,74,160,245,154,13,50,177,53
	.byte 90,193,140,207,29,83,200,96,149,227,116,74,210,113,48,229
	.byte 132,0,153,145,195,146,221,62,75,34,97,20,12,176,37,187
	.byte 91,67,24,65,28,209,92,238,148,97,224,196,211,243,164,107
	.byte 123,129,234,235,60,19,174,68,180,163,18,110,243,49,86,193
	.byte 164,194,107,59,227,80,47,148,107,224,147,190,44,114,215,17
	.byte 199,2,193,87,128,144,133,248,8,32,57,210,79,178,125,125
	.byte 24,65,64,135,95,211,4,40,215,99,184,2,144,241,252,173
	.byte 56,131,178,45,127,17,246,130,247,161,74,168,176,51,14,7
	.byte 231,192,51,253,160,82,119,82,40,226,203,120,111,112,143,215
	.byte 57,1,38,163,126,147,98,12,246,35,222,38,177,177,154,137
	.byte 230,66,167,115,161,208,227,220,41,96,95,246,110,242,27,89
	.byte 198,128,85,217,129,18,17,118,9,162,173,92,78,48,233,243
	.byte 25,195,212,9,94,81,144,166,214,225,44,140,145,115,104,35
	.byte 244,6,252,202,179,148,184,101,59,36,4,79,124,182,64,224
	.byte 43,69,125,26,108,215,57,181,228,103,133,159,163,245,193,48
	.byte 11,135,143,176,76,21,203,31,196,165,119,53,131,55,51,154
	.byte 212,196,14,96,147,86,74,207,27,230,246,229,92,116,178,74
	.byte 10,5,27,62,77,151,95,145,197,39,227,187,130,181,167,20
	.byte 213,70,154,238,146,212,222,65,26,100,98,107,93,246,38,196
	.byte 245,132,104,68,178,22,44,235,58,166,144,193,125,52,212,110
	.byte 42,199,233,148,109,85,173,59,229,229,17,17,162,119,85,190
	.byte 73,7,67,248,14,149,7,87,134,37,187,125,193,183,255,210
	.byte 150,68,194,40,209,214,134,135,89,102,58,173,30,244,126,2
	.byte 182,134,48,130,241,20,116,45,121,164,200,7,62,54,140,168
	.byte 105,197,177,82,46,87,245,253,166,231,73,215,225,117,13,120
	.byte 183,4,164,12,240,150,224,163,120,38,92,137,63,180,24,38
	.byte 104,71,37,220,47,213,97,115,167,101,221,89,224,247,153,246
	.byte 72,133,215,118,15,23,147,217,135,167,47,243,192,53,107,92
	.byte 151,198,86,166,208,84,18,9,88,228,174,35,31,118,234,140
	.byte 142,5,130,175,201,151,198,0,65,39,122,42,6,181,62,133
	.byte 81,70,3,127,22,212,71,208,158,100,251,250,217,246,191,85
	.byte 113,132,241,213,54,22,181,122,190,166,9,80,249,52,77,255
	.byte 174,199,112,5,233,85,52,170,97,229,136,128,38,119,204,47
	.byte 112,6,101,91,55,148,33,244,191,36,157,222,248,182,217,113
	.byte 175,69,228,139,232,215,160,36,96,103,28,14,39,245,88,161
	.byte 143,135,22,33,200,21,82,142,64,165,238,164,7,55,170,11
	.byte 80,196,151,241,23,86,211,94,159,230,111,116,216,116,43,219
	.byte 51,4,61,157,116,150,121,50,252,38,197,24,187,180,129,183
	.byte 236,71,188,77,171,213,248,226,35,101,68,200,100,247,0,103
	.byte 204,133,78,231,139,23,10,72,3,167,182,98,68,53,242,205
	.byte 19,198,207,55,84,84,139,152,220,228,55,178,155,118,115,29
	.byte 205,7,218,105,138,149,158,198,2,37,34,236,69,183,102,67
	.byte 18,68,91,185,85,214,31,22,221,102,163,60,154,244,231,147
	.byte 50,134,169,19,117,20,237,188,253,164,81,150,186,54,21,57
	.byte 237,197,40,195,170,87,108,108,34,231,208,70,101,117,148,233
	.byte 0,0,0,0,169,11,137,78,82,23,18,157,251,28,155,211
	.byte 229,40,85,225,76,35,220,175,183,63,71,124,30,52,206,50
	.byte 139,87,219,25,34,92,82,87,217,64,201,132,112,75,64,202
	.byte 110,127,142,248,199,116,7,182,60,104,156,101,149,99,21,43
	.byte 22,175,182,51,191,164,63,125,68,184,164,174,237,179,45,224
	.byte 243,135,227,210,90,140,106,156,161,144,241,79,8,155,120,1
	.byte 157,248,109,42,52,243,228,100,207,239,127,183,102,228,246,249
	.byte 120,208,56,203,209,219,177,133,42,199,42,86,131,204,163,24
	.byte 44,94,109,103,133,85,228,41,126,73,127,250,215,66,246,180
	.byte 201,118,56,134,96,125,177,200,155,97,42,27,50,106,163,85
	.byte 167,9,182,126,14,2,63,48,245,30,164,227,92,21,45,173
	.byte 66,33,227,159,235,42,106,209,16,54,241,2,185,61,120,76
	.byte 58,241,219,84,147,250,82,26,104,230,201,201,193,237,64,135
	.byte 223,217,142,181,118,210,7,251,141,206,156,40,36,197,21,102
	.byte 177,166,0,77,24,173,137,3,227,177,18,208,74,186,155,158
	.byte 84,142,85,172,253,133,220,226,6,153,71,49,175,146,206,127
	.byte 88,188,218,206,241,183,83,128,10,171,200,83,163,160,65,29
	.byte 189,148,143,47,20,159,6,97,239,131,157,178,70,136,20,252
	.byte 211,235,1,215,122,224,136,153,129,252,19,74,40,247,154,4
	.byte 54,195,84,54,159,200,221,120,100,212,70,171,205,223,207,229
	.byte 78,19,108,253,231,24,229,179,28,4,126,96,181,15,247,46
	.byte 171,59,57,28,2,48,176,82,249,44,43,129,80,39,162,207
	.byte 197,68,183,228,108,79,62,170,151,83,165,121,62,88,44,55
	.byte 32,108,226,5,137,103,107,75,114,123,240,152,219,112,121,214
	.byte 116,226,183,169,221,233,62,231,38,245,165,52,143,254,44,122
	.byte 145,202,226,72,56,193,107,6,195,221,240,213,106,214,121,155
	.byte 255,181,108,176,86,190,229,254,173,162,126,45,4,169,247,99
	.byte 26,157,57,81,179,150,176,31,72,138,43,204,225,129,162,130
	.byte 98,77,1,154,203,70,136,212,48,90,19,7,153,81,154,73
	.byte 135,101,84,123,46,110,221,53,213,114,70,230,124,121,207,168
	.byte 233,26,218,131,64,17,83,205,187,13,200,30,18,6,65,80
	.byte 12,50,143,98,165,57,6,44,94,37,157,255,247,46,20,177
	.byte 241,126,196,70,88,117,77,8,163,105,214,219,10,98,95,149
	.byte 20,86,145,167,189,93,24,233,70,65,131,58,239,74,10,116
	.byte 122,41,31,95,211,34,150,17,40,62,13,194,129,53,132,140
	.byte 159,1,74,190,54,10,195,240,205,22,88,35,100,29,209,109
	.byte 231,209,114,117,78,218,251,59,181,198,96,232,28,205,233,166
	.byte 2,249,39,148,171,242,174,218,80,238,53,9,249,229,188,71
	.byte 108,134,169,108,197,141,32,34,62,145,187,241,151,154,50,191
	.byte 137,174,252,141,32,165,117,195,219,185,238,16,114,178,103,94
	.byte 221,32,169,33,116,43,32,111,143,55,187,188,38,60,50,242
	.byte 56,8,252,192,145,3,117,142,106,31,238,93,195,20,103,19
	.byte 86,119,114,56,255,124,251,118,4,96,96,165,173,107,233,235
	.byte 179,95,39,217,26,84,174,151,225,72,53,68,72,67,188,10
	.byte 203,143,31,18,98,132,150,92,153,152,13,143,48,147,132,193
	.byte 46,167,74,243,135,172,195,189,124,176,88,110,213,187,209,32
	.byte 64,216,196,11,233,211,77,69,18,207,214,150,187,196,95,216
	.byte 165,240,145,234,12,251,24,164,247,231,131,119,94,236,10,57
	.byte 169,194,30,136,0,201,151,198,251,213,12,21,82,222,133,91
	.byte 76,234,75,105,229,225,194,39,30,253,89,244,183,246,208,186
	.byte 34,149,197,145,139,158,76,223,112,130,215,12,217,137,94,66
	.byte 199,189,144,112,110,182,25,62,149,170,130,237,60,161,11,163
	.byte 191,109,168,187,22,102,33,245,237,122,186,38,68,113,51,104
	.byte 90,69,253,90,243,78,116,20,8,82,239,199,161,89,102,137
	.byte 52,58,115,162,157,49,250,236,102,45,97,63,207,38,232,113
	.byte 209,18,38,67,120,25,175,13,131,5,52,222,42,14,189,144
	.byte 133,156,115,239,44,151,250,161,215,139,97,114,126,128,232,60
	.byte 96,180,38,14,201,191,175,64,50,163,52,147,155,168,189,221
	.byte 14,203,168,246,167,192,33,184,92,220,186,107,245,215,51,37
	.byte 235,227,253,23,66,232,116,89,185,244,239,138,16,255,102,196
	.byte 147,51,197,220,58,56,76,146,193,36,215,65,104,47,94,15
	.byte 118,27,144,61,223,16,25,115,36,12,130,160,141,7,11,238
	.byte 24,100,30,197,177,111,151,139,74,115,12,88,227,120,133,22
	.byte 253,76,75,36,84,71,194,106,175,91,89,185,6,80,208,247
	.byte 0,0,0,0,226,253,136,141,133,253,96,192,103,0,232,77
	.byte 75,253,176,91,169,0,56,214,206,0,208,155,44,253,88,22
	.byte 150,250,97,183,116,7,233,58,19,7,1,119,241,250,137,250
	.byte 221,7,209,236,63,250,89,97,88,250,177,44,186,7,57,161
	.byte 109,243,178,181,143,14,58,56,232,14,210,117,10,243,90,248
	.byte 38,14,2,238,196,243,138,99,163,243,98,46,65,14,234,163
	.byte 251,9,211,2,25,244,91,143,126,244,179,194,156,9,59,79
	.byte 176,244,99,89,82,9,235,212,53,9,3,153,215,244,139,20
	.byte 155,224,20,176,121,29,156,61,30,29,116,112,252,224,252,253
	.byte 208,29,164,235,50,224,44,102,85,224,196,43,183,29,76,166
	.byte 13,26,117,7,239,231,253,138,136,231,21,199,106,26,157,74
	.byte 70,231,197,92,164,26,77,209,195,26,165,156,33,231,45,17
	.byte 246,19,166,5,20,238,46,136,115,238,198,197,145,19,78,72
	.byte 189,238,22,94,95,19,158,211,56,19,118,158,218,238,254,19
	.byte 96,233,199,178,130,20,79,63,229,20,167,114,7,233,47,255
	.byte 43,20,119,233,201,233,255,100,174,233,23,41,76,20,159,164
	.byte 119,199,88,187,149,58,208,54,242,58,56,123,16,199,176,246
	.byte 60,58,232,224,222,199,96,109,185,199,136,32,91,58,0,173
	.byte 225,61,57,12,3,192,177,129,100,192,89,204,134,61,209,65
	.byte 170,192,137,87,72,61,1,218,47,61,233,151,205,192,97,26
	.byte 26,52,234,14,248,201,98,131,159,201,138,206,125,52,2,67
	.byte 81,201,90,85,179,52,210,216,212,52,58,149,54,201,178,24
	.byte 140,206,139,185,110,51,3,52,9,51,235,121,235,206,99,244
	.byte 199,51,59,226,37,206,179,111,66,206,91,34,160,51,211,175
	.byte 236,39,76,11,14,218,196,134,105,218,44,203,139,39,164,70
	.byte 167,218,252,80,69,39,116,221,34,39,156,144,192,218,20,29
	.byte 122,221,45,188,152,32,165,49,255,32,77,124,29,221,197,241
	.byte 49,32,157,231,211,221,21,106,180,221,253,39,86,32,117,170
	.byte 129,212,254,190,99,41,118,51,4,41,158,126,230,212,22,243
	.byte 202,41,78,229,40,212,198,104,79,212,46,37,173,41,166,168
	.byte 23,46,159,9,245,211,23,132,146,211,255,201,112,46,119,68
	.byte 92,211,47,82,190,46,167,223,217,46,79,146,59,211,199,31
	.byte 175,136,192,173,77,117,72,32,42,117,160,109,200,136,40,224
	.byte 228,117,112,246,6,136,248,123,97,136,16,54,131,117,152,187
	.byte 57,114,161,26,219,143,41,151,188,143,193,218,94,114,73,87
	.byte 114,143,17,65,144,114,153,204,247,114,113,129,21,143,249,12
	.byte 194,123,114,24,32,134,250,149,71,134,18,216,165,123,154,85
	.byte 137,134,194,67,107,123,74,206,12,123,162,131,238,134,42,14
	.byte 84,129,19,175,182,124,155,34,209,124,115,111,51,129,251,226
	.byte 31,124,163,244,253,129,43,121,154,129,195,52,120,124,75,185
	.byte 52,104,212,29,214,149,92,144,177,149,180,221,83,104,60,80
	.byte 127,149,100,70,157,104,236,203,250,104,4,134,24,149,140,11
	.byte 162,146,181,170,64,111,61,39,39,111,213,106,197,146,93,231
	.byte 233,111,5,241,11,146,141,124,108,146,101,49,142,111,237,188
	.byte 89,155,102,168,187,102,238,37,220,102,6,104,62,155,142,229
	.byte 18,102,214,243,240,155,94,126,151,155,182,51,117,102,62,190
	.byte 207,97,7,31,45,156,143,146,74,156,103,223,168,97,239,82
	.byte 132,156,183,68,102,97,63,201,1,97,215,132,227,156,95,9
	.byte 216,79,152,22,58,178,16,155,93,178,248,214,191,79,112,91
	.byte 147,178,40,77,113,79,160,192,22,79,72,141,244,178,192,0
	.byte 78,181,249,161,172,72,113,44,203,72,153,97,41,181,17,236
	.byte 5,72,73,250,231,181,193,119,128,181,41,58,98,72,161,183
	.byte 181,188,42,163,87,65,162,46,48,65,74,99,210,188,194,238
	.byte 254,65,154,248,28,188,18,117,123,188,250,56,153,65,114,181
	.byte 35,70,75,20,193,187,195,153,166,187,43,212,68,70,163,89
	.byte 104,187,251,79,138,70,115,194,237,70,155,143,15,187,19,2
	.byte 67,175,140,166,161,82,4,43,198,82,236,102,36,175,100,235
	.byte 8,82,60,253,234,175,180,112,141,175,92,61,111,82,212,176
	.byte 213,85,237,17,55,168,101,156,80,168,141,209,178,85,5,92
	.byte 158,168,93,74,124,85,213,199,27,85,61,138,249,168,181,7
	.byte 46,92,62,19,204,161,182,158,171,161,94,211,73,92,214,94
	.byte 101,161,142,72,135,92,6,197,224,92,238,136,2,161,102,5
	.byte 184,166,95,164,90,91,215,41,61,91,63,100,223,166,183,233
	.byte 243,91,239,255,17,166,103,114,118,166,143,63,148,91,7,178
	.byte 0,0,0,0,31,23,240,128,127,40,145,218,96,63,97,90
	.byte 191,86,83,110,160,65,163,238,192,126,194,180,223,105,50,52
	.byte 126,173,166,220,97,186,86,92,1,133,55,6,30,146,199,134
	.byte 193,251,245,178,222,236,5,50,190,211,100,104,161,196,148,232
	.byte 189,92,60,98,162,75,204,226,194,116,173,184,221,99,93,56
	.byte 2,10,111,12,29,29,159,140,125,34,254,214,98,53,14,86
	.byte 195,241,154,190,220,230,106,62,188,217,11,100,163,206,251,228
	.byte 124,167,201,208,99,176,57,80,3,143,88,10,28,152,168,138
	.byte 122,185,120,196,101,174,136,68,5,145,233,30,26,134,25,158
	.byte 197,239,43,170,218,248,219,42,186,199,186,112,165,208,74,240
	.byte 4,20,222,24,27,3,46,152,123,60,79,194,100,43,191,66
	.byte 187,66,141,118,164,85,125,246,196,106,28,172,219,125,236,44
	.byte 199,229,68,166,216,242,180,38,184,205,213,124,167,218,37,252
	.byte 120,179,23,200,103,164,231,72,7,155,134,18,24,140,118,146
	.byte 185,72,226,122,166,95,18,250,198,96,115,160,217,119,131,32
	.byte 6,30,177,20,25,9,65,148,121,54,32,206,102,33,208,78
	.byte 181,116,128,83,170,99,112,211,202,92,17,137,213,75,225,9
	.byte 10,34,211,61,21,53,35,189,117,10,66,231,106,29,178,103
	.byte 203,217,38,143,212,206,214,15,180,241,183,85,171,230,71,213
	.byte 116,143,117,225,107,152,133,97,11,167,228,59,20,176,20,187
	.byte 8,40,188,49,23,63,76,177,119,0,45,235,104,23,221,107
	.byte 183,126,239,95,168,105,31,223,200,86,126,133,215,65,142,5
	.byte 118,133,26,237,105,146,234,109,9,173,139,55,22,186,123,183
	.byte 201,211,73,131,214,196,185,3,182,251,216,89,169,236,40,217
	.byte 207,205,248,151,208,218,8,23,176,229,105,77,175,242,153,205
	.byte 112,155,171,249,111,140,91,121,15,179,58,35,16,164,202,163
	.byte 177,96,94,75,174,119,174,203,206,72,207,145,209,95,63,17
	.byte 14,54,13,37,17,33,253,165,113,30,156,255,110,9,108,127
	.byte 114,145,196,245,109,134,52,117,13,185,85,47,18,174,165,175
	.byte 205,199,151,155,210,208,103,27,178,239,6,65,173,248,246,193
	.byte 12,60,98,41,19,43,146,169,115,20,243,243,108,3,3,115
	.byte 179,106,49,71,172,125,193,199,204,66,160,157,211,85,80,29
	.byte 106,233,0,167,117,254,240,39,21,193,145,125,10,214,97,253
	.byte 213,191,83,201,202,168,163,73,170,151,194,19,181,128,50,147
	.byte 20,68,166,123,11,83,86,251,107,108,55,161,116,123,199,33
	.byte 171,18,245,21,180,5,5,149,212,58,100,207,203,45,148,79
	.byte 215,181,60,197,200,162,204,69,168,157,173,31,183,138,93,159
	.byte 104,227,111,171,119,244,159,43,23,203,254,113,8,220,14,241
	.byte 169,24,154,25,182,15,106,153,214,48,11,195,201,39,251,67
	.byte 22,78,201,119,9,89,57,247,105,102,88,173,118,113,168,45
	.byte 16,80,120,99,15,71,136,227,111,120,233,185,112,111,25,57
	.byte 175,6,43,13,176,17,219,141,208,46,186,215,207,57,74,87
	.byte 110,253,222,191,113,234,46,63,17,213,79,101,14,194,191,229
	.byte 209,171,141,209,206,188,125,81,174,131,28,11,177,148,236,139
	.byte 173,12,68,1,178,27,180,129,210,36,213,219,205,51,37,91
	.byte 18,90,23,111,13,77,231,239,109,114,134,181,114,101,118,53
	.byte 211,161,226,221,204,182,18,93,172,137,115,7,179,158,131,135
	.byte 108,247,177,179,115,224,65,51,19,223,32,105,12,200,208,233
	.byte 223,157,128,244,192,138,112,116,160,181,17,46,191,162,225,174
	.byte 96,203,211,154,127,220,35,26,31,227,66,64,0,244,178,192
	.byte 161,48,38,40,190,39,214,168,222,24,183,242,193,15,71,114
	.byte 30,102,117,70,1,113,133,198,97,78,228,156,126,89,20,28
	.byte 98,193,188,150,125,214,76,22,29,233,45,76,2,254,221,204
	.byte 221,151,239,248,194,128,31,120,162,191,126,34,189,168,142,162
	.byte 28,108,26,74,3,123,234,202,99,68,139,144,124,83,123,16
	.byte 163,58,73,36,188,45,185,164,220,18,216,254,195,5,40,126
	.byte 165,36,248,48,186,51,8,176,218,12,105,234,197,27,153,106
	.byte 26,114,171,94,5,101,91,222,101,90,58,132,122,77,202,4
	.byte 219,137,94,236,196,158,174,108,164,161,207,54,187,182,63,182
	.byte 100,223,13,130,123,200,253,2,27,247,156,88,4,224,108,216
	.byte 24,120,196,82,7,111,52,210,103,80,85,136,120,71,165,8
	.byte 167,46,151,60,184,57,103,188,216,6,6,230,199,17,246,102
	.byte 102,213,98,142,121,194,146,14,25,253,243,84,6,234,3,212
	.byte 217,131,49,224,198,148,193,96,166,171,160,58,185,188,80,186
	.byte 0,0,0,0,149,212,112,149,107,175,144,241,254,123,224,100
	.byte 151,88,80,56,2,140,32,173,252,247,192,201,105,35,176,92
	.byte 46,177,160,112,187,101,208,229,69,30,48,129,208,202,64,20
	.byte 185,233,240,72,44,61,128,221,210,70,96,185,71,146,16,44
	.byte 92,98,65,225,201,182,49,116,55,205,209,16,162,25,161,133
	.byte 203,58,17,217,94,238,97,76,160,149,129,40,53,65,241,189
	.byte 114,211,225,145,231,7,145,4,25,124,113,96,140,168,1,245
	.byte 229,139,177,169,112,95,193,60,142,36,33,88,27,240,81,205
	.byte 249,194,243,25,108,22,131,140,146,109,99,232,7,185,19,125
	.byte 110,154,163,33,251,78,211,180,5,53,51,208,144,225,67,69
	.byte 215,115,83,105,66,167,35,252,188,220,195,152,41,8,179,13
	.byte 64,43,3,81,213,255,115,196,43,132,147,160,190,80,227,53
	.byte 165,160,178,248,48,116,194,109,206,15,34,9,91,219,82,156
	.byte 50,248,226,192,167,44,146,85,89,87,114,49,204,131,2,164
	.byte 139,17,18,136,30,197,98,29,224,190,130,121,117,106,242,236
	.byte 28,73,66,176,137,157,50,37,119,230,210,65,226,50,162,212
	.byte 242,133,231,51,103,81,151,166,153,42,119,194,12,254,7,87
	.byte 101,221,183,11,240,9,199,158,14,114,39,250,155,166,87,111
	.byte 220,52,71,67,73,224,55,214,183,155,215,178,34,79,167,39
	.byte 75,108,23,123,222,184,103,238,32,195,135,138,181,23,247,31
	.byte 174,231,166,210,59,51,214,71,197,72,54,35,80,156,70,182
	.byte 57,191,246,234,172,107,134,127,82,16,102,27,199,196,22,142
	.byte 128,86,6,162,21,130,118,55,235,249,150,83,126,45,230,198
	.byte 23,14,86,154,130,218,38,15,124,161,198,107,233,117,182,254
	.byte 11,71,20,42,158,147,100,191,96,232,132,219,245,60,244,78
	.byte 156,31,68,18,9,203,52,135,247,176,212,227,98,100,164,118
	.byte 37,246,180,90,176,34,196,207,78,89,36,171,219,141,84,62
	.byte 178,174,228,98,39,122,148,247,217,1,116,147,76,213,4,6
	.byte 87,37,85,203,194,241,37,94,60,138,197,58,169,94,181,175
	.byte 192,125,5,243,85,169,117,102,171,210,149,2,62,6,229,151
	.byte 121,148,245,187,236,64,133,46,18,59,101,74,135,239,21,223
	.byte 238,204,165,131,123,24,213,22,133,99,53,114,16,183,69,231
	.byte 228,11,207,103,113,223,191,242,143,164,95,150,26,112,47,3
	.byte 115,83,159,95,230,135,239,202,24,252,15,174,141,40,127,59
	.byte 202,186,111,23,95,110,31,130,161,21,255,230,52,193,143,115
	.byte 93,226,63,47,200,54,79,186,54,77,175,222,163,153,223,75
	.byte 184,105,142,134,45,189,254,19,211,198,30,119,70,18,110,226
	.byte 47,49,222,190,186,229,174,43,68,158,78,79,209,74,62,218
	.byte 150,216,46,246,3,12,94,99,253,119,190,7,104,163,206,146
	.byte 1,128,126,206,148,84,14,91,106,47,238,63,255,251,158,170
	.byte 29,201,60,126,136,29,76,235,118,102,172,143,227,178,220,26
	.byte 138,145,108,70,31,69,28,211,225,62,252,183,116,234,140,34
	.byte 51,120,156,14,166,172,236,155,88,215,12,255,205,3,124,106
	.byte 164,32,204,54,49,244,188,163,207,143,92,199,90,91,44,82
	.byte 65,171,125,159,212,127,13,10,42,4,237,110,191,208,157,251
	.byte 214,243,45,167,67,39,93,50,189,92,189,86,40,136,205,195
	.byte 111,26,221,239,250,206,173,122,4,181,77,30,145,97,61,139
	.byte 248,66,141,215,109,150,253,66,147,237,29,38,6,57,109,179
	.byte 22,142,40,84,131,90,88,193,125,33,184,165,232,245,200,48
	.byte 129,214,120,108,20,2,8,249,234,121,232,157,127,173,152,8
	.byte 56,63,136,36,173,235,248,177,83,144,24,213,198,68,104,64
	.byte 175,103,216,28,58,179,168,137,196,200,72,237,81,28,56,120
	.byte 74,236,105,181,223,56,25,32,33,67,249,68,180,151,137,209
	.byte 221,180,57,141,72,96,73,24,182,27,169,124,35,207,217,233
	.byte 100,93,201,197,241,137,185,80,15,242,89,52,154,38,41,161
	.byte 243,5,153,253,102,209,233,104,152,170,9,12,13,126,121,153
	.byte 239,76,219,77,122,152,171,216,132,227,75,188,17,55,59,41
	.byte 120,20,139,117,237,192,251,224,19,187,27,132,134,111,107,17
	.byte 193,253,123,61,84,41,11,168,170,82,235,204,63,134,155,89
	.byte 86,165,43,5,195,113,91,144,61,10,187,244,168,222,203,97
	.byte 179,46,154,172,38,250,234,57,216,129,10,93,77,85,122,200
	.byte 36,118,202,148,177,162,186,1,79,217,90,101,218,13,42,240
	.byte 157,159,58,220,8,75,74,73,246,48,170,45,99,228,218,184
	.byte 10,199,106,228,159,19,26,113,97,104,250,21,244,188,138,128
	.byte 0,0,0,0,200,23,158,207,209,41,77,68,25,62,211,139
	.byte 162,83,154,136,106,68,4,71,115,122,215,204,187,109,73,3
	.byte 5,161,69,202,205,182,219,5,212,136,8,142,28,159,150,65
	.byte 167,242,223,66,111,229,65,141,118,219,146,6,190,204,12,201
	.byte 75,68,250,79,131,83,100,128,154,109,183,11,82,122,41,196
	.byte 233,23,96,199,33,0,254,8,56,62,45,131,240,41,179,76
	.byte 78,229,191,133,134,242,33,74,159,204,242,193,87,219,108,14
	.byte 236,182,37,13,36,161,187,194,61,159,104,73,245,136,246,134
	.byte 150,136,244,159,94,159,106,80,71,161,185,219,143,182,39,20
	.byte 52,219,110,23,252,204,240,216,229,242,35,83,45,229,189,156
	.byte 147,41,177,85,91,62,47,154,66,0,252,17,138,23,98,222
	.byte 49,122,43,221,249,109,181,18,224,83,102,153,40,68,248,86
	.byte 221,204,14,208,21,219,144,31,12,229,67,148,196,242,221,91
	.byte 127,159,148,88,183,136,10,151,174,182,217,28,102,161,71,211
	.byte 216,109,75,26,16,122,213,213,9,68,6,94,193,83,152,145
	.byte 122,62,209,146,178,41,79,93,171,23,156,214,99,0,2,25
	.byte 109,23,152,228,165,0,6,43,188,62,213,160,116,41,75,111
	.byte 207,68,2,108,7,83,156,163,30,109,79,40,214,122,209,231
	.byte 104,182,221,46,160,161,67,225,185,159,144,106,113,136,14,165
	.byte 202,229,71,166,2,242,217,105,27,204,10,226,211,219,148,45
	.byte 38,83,98,171,238,68,252,100,247,122,47,239,63,109,177,32
	.byte 132,0,248,35,76,23,102,236,85,41,181,103,157,62,43,168
	.byte 35,242,39,97,235,229,185,174,242,219,106,37,58,204,244,234
	.byte 129,161,189,233,73,182,35,38,80,136,240,173,152,159,110,98
	.byte 251,159,108,123,51,136,242,180,42,182,33,63,226,161,191,240
	.byte 89,204,246,243,145,219,104,60,136,229,187,183,64,242,37,120
	.byte 254,62,41,177,54,41,183,126,47,23,100,245,231,0,250,58
	.byte 92,109,179,57,148,122,45,246,141,68,254,125,69,83,96,178
	.byte 176,219,150,52,120,204,8,251,97,242,219,112,169,229,69,191
	.byte 18,136,12,188,218,159,146,115,195,161,65,248,11,182,223,55
	.byte 181,122,211,254,125,109,77,49,100,83,158,186,172,68,0,117
	.byte 23,41,73,118,223,62,215,185,198,0,4,50,14,23,154,253
	.byte 155,40,65,18,83,63,223,221,74,1,12,86,130,22,146,153
	.byte 57,123,219,154,241,108,69,85,232,82,150,222,32,69,8,17
	.byte 158,137,4,216,86,158,154,23,79,160,73,156,135,183,215,83
	.byte 60,218,158,80,244,205,0,159,237,243,211,20,37,228,77,219
	.byte 208,108,187,93,24,123,37,146,1,69,246,25,201,82,104,214
	.byte 114,63,33,213,186,40,191,26,163,22,108,145,107,1,242,94
	.byte 213,205,254,151,29,218,96,88,4,228,179,211,204,243,45,28
	.byte 119,158,100,31,191,137,250,208,166,183,41,91,110,160,183,148
	.byte 13,160,181,141,197,183,43,66,220,137,248,201,20,158,102,6
	.byte 175,243,47,5,103,228,177,202,126,218,98,65,182,205,252,142
	.byte 8,1,240,71,192,22,110,136,217,40,189,3,17,63,35,204
	.byte 170,82,106,207,98,69,244,0,123,123,39,139,179,108,185,68
	.byte 70,228,79,194,142,243,209,13,151,205,2,134,95,218,156,73
	.byte 228,183,213,74,44,160,75,133,53,158,152,14,253,137,6,193
	.byte 67,69,10,8,139,82,148,199,146,108,71,76,90,123,217,131
	.byte 225,22,144,128,41,1,14,79,48,63,221,196,248,40,67,11
	.byte 246,63,217,246,62,40,71,57,39,22,148,178,239,1,10,125
	.byte 84,108,67,126,156,123,221,177,133,69,14,58,77,82,144,245
	.byte 243,158,156,60,59,137,2,243,34,183,209,120,234,160,79,183
	.byte 81,205,6,180,153,218,152,123,128,228,75,240,72,243,213,63
	.byte 189,123,35,185,117,108,189,118,108,82,110,253,164,69,240,50
	.byte 31,40,185,49,215,63,39,254,206,1,244,117,6,22,106,186
	.byte 184,218,102,115,112,205,248,188,105,243,43,55,161,228,181,248
	.byte 26,137,252,251,210,158,98,52,203,160,177,191,3,183,47,112
	.byte 96,183,45,105,168,160,179,166,177,158,96,45,121,137,254,226
	.byte 194,228,183,225,10,243,41,46,19,205,250,165,219,218,100,106
	.byte 101,22,104,163,173,1,246,108,180,63,37,231,124,40,187,40
	.byte 199,69,242,43,15,82,108,228,22,108,191,111,222,123,33,160
	.byte 43,243,215,38,227,228,73,233,250,218,154,98,50,205,4,173
	.byte 137,160,77,174,65,183,211,97,88,137,0,234,144,158,158,37
	.byte 46,82,146,236,230,69,12,35,255,123,223,168,55,108,65,103
	.byte 140,1,8,100,68,22,150,171,93,40,69,32,149,63,219,239
	.byte 0,0,0,0,54,81,130,36,108,162,4,73,90,243,134,109
	.byte 216,68,9,146,238,21,139,182,180,230,13,219,130,183,143,255
	.byte 241,143,99,255,199,222,225,219,157,45,103,182,171,124,229,146
	.byte 41,203,106,109,31,154,232,73,69,105,110,36,115,56,236,0
	.byte 163,25,182,37,149,72,52,1,207,187,178,108,249,234,48,72
	.byte 123,93,191,183,77,12,61,147,23,255,187,254,33,174,57,218
	.byte 82,150,213,218,100,199,87,254,62,52,209,147,8,101,83,183
	.byte 138,210,220,72,188,131,94,108,230,112,216,1,208,33,90,37
	.byte 70,51,108,75,112,98,238,111,42,145,104,2,28,192,234,38
	.byte 158,119,101,217,168,38,231,253,242,213,97,144,196,132,227,180
	.byte 183,188,15,180,129,237,141,144,219,30,11,253,237,79,137,217
	.byte 111,248,6,38,89,169,132,2,3,90,2,111,53,11,128,75
	.byte 229,42,218,110,211,123,88,74,137,136,222,39,191,217,92,3
	.byte 61,110,211,252,11,63,81,216,81,204,215,181,103,157,85,145
	.byte 20,165,185,145,34,244,59,181,120,7,189,216,78,86,63,252
	.byte 204,225,176,3,250,176,50,39,160,67,180,74,150,18,54,110
	.byte 140,102,216,150,186,55,90,178,224,196,220,223,214,149,94,251
	.byte 84,34,209,4,98,115,83,32,56,128,213,77,14,209,87,105
	.byte 125,233,187,105,75,184,57,77,17,75,191,32,39,26,61,4
	.byte 165,173,178,251,147,252,48,223,201,15,182,178,255,94,52,150
	.byte 47,127,110,179,25,46,236,151,67,221,106,250,117,140,232,222
	.byte 247,59,103,33,193,106,229,5,155,153,99,104,173,200,225,76
	.byte 222,240,13,76,232,161,143,104,178,82,9,5,132,3,139,33
	.byte 6,180,4,222,48,229,134,250,106,22,0,151,92,71,130,179
	.byte 202,85,180,221,252,4,54,249,166,247,176,148,144,166,50,176
	.byte 18,17,189,79,36,64,63,107,126,179,185,6,72,226,59,34
	.byte 59,218,215,34,13,139,85,6,87,120,211,107,97,41,81,79
	.byte 227,158,222,176,213,207,92,148,143,60,218,249,185,109,88,221
	.byte 105,76,2,248,95,29,128,220,5,238,6,177,51,191,132,149
	.byte 177,8,11,106,135,89,137,78,221,170,15,35,235,251,141,7
	.byte 152,195,97,7,174,146,227,35,244,97,101,78,194,48,231,106
	.byte 64,135,104,149,118,214,234,177,44,37,108,220,26,116,238,248
	.byte 89,203,193,246,111,154,67,210,53,105,197,191,3,56,71,155
	.byte 129,143,200,100,183,222,74,64,237,45,204,45,219,124,78,9
	.byte 168,68,162,9,158,21,32,45,196,230,166,64,242,183,36,100
	.byte 112,0,171,155,70,81,41,191,28,162,175,210,42,243,45,246
	.byte 250,210,119,211,204,131,245,247,150,112,115,154,160,33,241,190
	.byte 34,150,126,65,20,199,252,101,78,52,122,8,120,101,248,44
	.byte 11,93,20,44,61,12,150,8,103,255,16,101,81,174,146,65
	.byte 211,25,29,190,229,72,159,154,191,187,25,247,137,234,155,211
	.byte 31,248,173,189,41,169,47,153,115,90,169,244,69,11,43,208
	.byte 199,188,164,47,241,237,38,11,171,30,160,102,157,79,34,66
	.byte 238,119,206,66,216,38,76,102,130,213,202,11,180,132,72,47
	.byte 54,51,199,208,0,98,69,244,90,145,195,153,108,192,65,189
	.byte 188,225,27,152,138,176,153,188,208,67,31,209,230,18,157,245
	.byte 100,165,18,10,82,244,144,46,8,7,22,67,62,86,148,103
	.byte 77,110,120,103,123,63,250,67,33,204,124,46,23,157,254,10
	.byte 149,42,113,245,163,123,243,209,249,136,117,188,207,217,247,152
	.byte 213,173,25,96,227,252,155,68,185,15,29,41,143,94,159,13
	.byte 13,233,16,242,59,184,146,214,97,75,20,187,87,26,150,159
	.byte 36,34,122,159,18,115,248,187,72,128,126,214,126,209,252,242
	.byte 252,102,115,13,202,55,241,41,144,196,119,68,166,149,245,96
	.byte 118,180,175,69,64,229,45,97,26,22,171,12,44,71,41,40
	.byte 174,240,166,215,152,161,36,243,194,82,162,158,244,3,32,186
	.byte 135,59,204,186,177,106,78,158,235,153,200,243,221,200,74,215
	.byte 95,127,197,40,105,46,71,12,51,221,193,97,5,140,67,69
	.byte 147,158,117,43,165,207,247,15,255,60,113,98,201,109,243,70
	.byte 75,218,124,185,125,139,254,157,39,120,120,240,17,41,250,212
	.byte 98,17,22,212,84,64,148,240,14,179,18,157,56,226,144,185
	.byte 186,85,31,70,140,4,157,98,214,247,27,15,224,166,153,43
	.byte 48,135,195,14,6,214,65,42,92,37,199,71,106,116,69,99
	.byte 232,195,202,156,222,146,72,184,132,97,206,213,178,48,76,241
	.byte 193,8,160,241,247,89,34,213,173,170,164,184,155,251,38,156
	.byte 25,76,169,99,47,29,43,71,117,238,173,42,67,191,47,14
	.byte 0,0,0,0,243,144,242,54,230,33,229,109,21,177,23,91
	.byte 204,67,202,219,63,211,56,237,42,98,47,182,217,242,221,128
	.byte 217,129,229,108,42,17,23,90,63,160,0,1,204,48,242,55
	.byte 21,194,47,183,230,82,221,129,243,227,202,218,0,115,56,236
	.byte 178,3,203,217,65,147,57,239,84,34,46,180,167,178,220,130
	.byte 126,64,1,2,141,208,243,52,152,97,228,111,107,241,22,89
	.byte 107,130,46,181,152,18,220,131,141,163,203,216,126,51,57,238
	.byte 167,193,228,110,84,81,22,88,65,224,1,3,178,112,243,53
	.byte 37,1,231,104,214,145,21,94,195,32,2,5,48,176,240,51
	.byte 233,66,45,179,26,210,223,133,15,99,200,222,252,243,58,232
	.byte 252,128,2,4,15,16,240,50,26,161,231,105,233,49,21,95
	.byte 48,195,200,223,195,83,58,233,214,226,45,178,37,114,223,132
	.byte 151,2,44,177,100,146,222,135,113,35,201,220,130,179,59,234
	.byte 91,65,230,106,168,209,20,92,189,96,3,7,78,240,241,49
	.byte 78,131,201,221,189,19,59,235,168,162,44,176,91,50,222,134
	.byte 130,192,3,6,113,80,241,48,100,225,230,107,151,113,20,93
	.byte 74,2,206,209,185,146,60,231,172,35,43,188,95,179,217,138
	.byte 134,65,4,10,117,209,246,60,96,96,225,103,147,240,19,81
	.byte 147,131,43,189,96,19,217,139,117,162,206,208,134,50,60,230
	.byte 95,192,225,102,172,80,19,80,185,225,4,11,74,113,246,61
	.byte 248,1,5,8,11,145,247,62,30,32,224,101,237,176,18,83
	.byte 52,66,207,211,199,210,61,229,210,99,42,190,33,243,216,136
	.byte 33,128,224,100,210,16,18,82,199,161,5,9,52,49,247,63
	.byte 237,195,42,191,30,83,216,137,11,226,207,210,248,114,61,228
	.byte 111,3,41,185,156,147,219,143,137,34,204,212,122,178,62,226
	.byte 163,64,227,98,80,208,17,84,69,97,6,15,182,241,244,57
	.byte 182,130,204,213,69,18,62,227,80,163,41,184,163,51,219,142
	.byte 122,193,6,14,137,81,244,56,156,224,227,99,111,112,17,85
	.byte 221,0,226,96,46,144,16,86,59,33,7,13,200,177,245,59
	.byte 17,67,40,187,226,211,218,141,247,98,205,214,4,242,63,224
	.byte 4,129,7,12,247,17,245,58,226,160,226,97,17,48,16,87
	.byte 200,194,205,215,59,82,63,225,46,227,40,186,221,115,218,140
	.byte 213,2,237,120,38,146,31,78,51,35,8,21,192,179,250,35
	.byte 25,65,39,163,234,209,213,149,255,96,194,206,12,240,48,248
	.byte 12,131,8,20,255,19,250,34,234,162,237,121,25,50,31,79
	.byte 192,192,194,207,51,80,48,249,38,225,39,162,213,113,213,148
	.byte 103,1,38,161,148,145,212,151,129,32,195,204,114,176,49,250
	.byte 171,66,236,122,88,210,30,76,77,99,9,23,190,243,251,33
	.byte 190,128,195,205,77,16,49,251,88,161,38,160,171,49,212,150
	.byte 114,195,9,22,129,83,251,32,148,226,236,123,103,114,30,77
	.byte 240,3,10,16,3,147,248,38,22,34,239,125,229,178,29,75
	.byte 60,64,192,203,207,208,50,253,218,97,37,166,41,241,215,144
	.byte 41,130,239,124,218,18,29,74,207,163,10,17,60,51,248,39
	.byte 229,193,37,167,22,81,215,145,3,224,192,202,240,112,50,252
	.byte 66,0,193,201,177,144,51,255,164,33,36,164,87,177,214,146
	.byte 142,67,11,18,125,211,249,36,104,98,238,127,155,242,28,73
	.byte 155,129,36,165,104,17,214,147,125,160,193,200,142,48,51,254
	.byte 87,194,238,126,164,82,28,72,177,227,11,19,66,115,249,37
	.byte 159,0,35,169,108,144,209,159,121,33,198,196,138,177,52,242
	.byte 83,67,233,114,160,211,27,68,181,98,12,31,70,242,254,41
	.byte 70,129,198,197,181,17,52,243,160,160,35,168,83,48,209,158
	.byte 138,194,12,30,121,82,254,40,108,227,233,115,159,115,27,69
	.byte 45,3,232,112,222,147,26,70,203,34,13,29,56,178,255,43
	.byte 225,64,34,171,18,208,208,157,7,97,199,198,244,241,53,240
	.byte 244,130,13,28,7,18,255,42,18,163,232,113,225,51,26,71
	.byte 56,193,199,199,203,81,53,241,222,224,34,170,45,112,208,156
	.byte 186,1,196,193,73,145,54,247,92,32,33,172,175,176,211,154
	.byte 118,66,14,26,133,210,252,44,144,99,235,119,99,243,25,65
	.byte 99,128,33,173,144,16,211,155,133,161,196,192,118,49,54,246
	.byte 175,195,235,118,92,83,25,64,73,226,14,27,186,114,252,45
	.byte 8,2,15,24,251,146,253,46,238,35,234,117,29,179,24,67
	.byte 196,65,197,195,55,209,55,245,34,96,32,174,209,240,210,152
	.byte 209,131,234,116,34,19,24,66,55,162,15,25,196,50,253,47
	.byte 29,192,32,175,238,80,210,153,251,225,197,194,8,113,55,244
# ---- crc32_chorba_c.S, for crc32_chorba_118960_nondestructive
	.text
	.text
crc32_chorba_118960_nondestructive:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x20158, %rsp
movq	%rdx, 0xd0(%rsp)
movq	%rsi, %r12
movl	%edi, %ebp
movq	$-0x100, %r13
movl	$0x3a20, %r11d
xorl	%esi, %esi
movq	$0x0, 0x38(%rsp)
xorl	%r8d, %r8d
xorl	%eax, %eax
xorl	%r9d, %r9d
xorl	%r10d, %r10d
xorl	%r14d, %r14d
movq	$0x0, 0x10(%rsp)
movq	$0x0, 0x18(%rsp)
xorl	%edi, %edi
xorl	%ecx, %ecx
xorl	%r15d, %r15d
movq	$0x0, 0x80(%rsp)
movq	$0x0, 0x20(%rsp)
movq	$0x0, 0x8(%rsp)
movq	$0x0, 0x30(%rsp)
movq	$0x0, 0x28(%rsp)
movq	$0x0, 0xa8(%rsp)
movq	$0x0, 0x40(%rsp)
movq	$0x0, 0x50(%rsp)
movq	$0x0, 0x98(%rsp)
movq	%r12, 0xd8(%rsp)
nop
Lcrc32_chorba_c__c0:
movq	%r11, 0x88(%rsp)
xorq	0x100(%r12,%r13), %rbp
movq	%rsi, %rbx
xorq	0x108(%r12,%r13), %rbx
movq	0x8(%rsp), %rsi
movq	0x38(%rsp), %rdx
xorq	0x110(%r12,%r13), %rdx
xorq	0x118(%r12,%r13), %r8
movq	%r8, 0xb0(%rsp)
xorq	0x120(%r12,%r13), %rax
movq	%rax, 0xf8(%rsp)
xorq	0x128(%r12,%r13), %r9
movq	%r9, 0x78(%rsp)
xorq	0x130(%r12,%r13), %r10
movq	%r10, 0xb8(%rsp)
xorq	0x138(%r12,%r13), %r14
leal	-0x20(%r11), %eax
andl	$0x3fe0, %eax
movq	0x10(%rsp), %r9
xorq	0x140(%r12,%r13), %r9
xorq	%rbp, %r14
movq	%r14, 0xf0(%rsp)
movq	%r9, 0x38(%rsp)
movq	0x18(%rsp), %r8
xorq	0x148(%r12,%r13), %r8
movq	%r8, 0x60(%rsp)
xorq	0x150(%r12,%r13), %rdi
movq	%rdi, 0x48(%rsp)
xorq	0x158(%r12,%r13), %rcx
xorq	0x160(%r12,%r13), %r15
movq	0x80(%rsp), %r10
xorq	0x168(%r12,%r13), %r10
movq	0x20(%rsp), %r11
xorq	0x170(%r12,%r13), %r11
movq	%r11, 0x20(%rsp)
xorq	0x178(%r12,%r13), %rsi
movq	%rsi, 0x8(%rsp)
movq	0x30(%rsp), %r8
xorq	0x180(%r12,%r13), %r8
movq	%r8, 0x30(%rsp)
movq	0x28(%rsp), %rsi
xorq	0x188(%r12,%r13), %rsi
movq	%rsi, 0x28(%rsp)
movq	0xa8(%rsp), %rdi
xorq	0x190(%r12,%r13), %rdi
movq	%rdi, 0xa8(%rsp)
movq	0x40(%rsp), %rdi
xorq	0x198(%r12,%r13), %rdi
movq	%rdi, 0x40(%rsp)
movq	0x50(%rsp), %r11
xorq	0x1a0(%r12,%r13), %r11
xorq	%rbp, %rcx
movq	%rcx, 0xc8(%rsp)
movq	0x98(%rsp), %r14
xorq	0x1a8(%r12,%r13), %r14
movq	%r14, 0x80(%rsp)
movq	0x1b0(%r12,%r13), %rsi
xorq	%rbp, %rsi
movq	%rsi, 0x50(%rsp)
movq	0x1b8(%r12,%r13), %r8
movq	0x1c0(%r12,%r13), %rcx
movq	0x1c8(%r12,%r13), %rdi
movq	%rdi, 0xa0(%rsp)
movq	0x1d0(%r12,%r13), %rdi
movq	%rdi, 0x68(%rsp)
movq	0x1d8(%r12,%r13), %rdi
movq	%rdi, 0xc0(%rsp)
movq	0x1e0(%r12,%r13), %rdi
movq	%rdi, 0x70(%rsp)
movq	0x1e8(%r12,%r13), %rdi
movq	%rdi, 0x10(%rsp)
movq	0x1f0(%r12,%r13), %rdi
movq	%rdi, 0x18(%rsp)
movq	0x1f8(%r12,%r13), %rdi
movq	%rdi, 0x58(%rsp)
movq	%rbp, 0x200(%rsp,%rax,8)
movq	0x38(%rsp), %rbp
xorq	%rbx, %rbp
movq	%rbp, 0x38(%rsp)
xorq	%rbx, %r15
xorq	%rbx, %r8
movq	%r8, 0xe0(%rsp)
movq	%rbx, 0x208(%rsp,%rax,8)
movq	0x60(%rsp), %rbx
xorq	%rdx, %rbx
xorq	%rdx, %r10
xorq	%rdx, %rcx
movq	%rcx, 0xe8(%rsp)
movq	%rdx, 0x210(%rsp,%rax,8)
movq	0xb0(%rsp), %r14
movq	%r14, 0x218(%rsp,%rax,8)
movq	0xf8(%rsp), %r12
movq	%r12, 0x220(%rsp,%rax,8)
movq	0x78(%rsp), %rsi
movq	%rsi, 0x228(%rsp,%rax,8)
movq	0xb8(%rsp), %rdi
movq	%rdi, 0x230(%rsp,%rax,8)
movq	0xf0(%rsp), %r9
movq	%r9, 0x238(%rsp,%rax,8)
movq	%rbp, 0x240(%rsp,%rax,8)
movq	%rbx, 0x248(%rsp,%rax,8)
movq	0x48(%rsp), %rax
xorq	%r14, %rax
movq	0xc8(%rsp), %rdx
xorq	%r12, %rdx
xorq	%rsi, %r15
movq	%rsi, %rbp
xorq	%rdi, %r10
movq	0x20(%rsp), %rsi
xorq	%r14, %rsi
movq	%rsi, 0x48(%rsp)
movq	0x28(%rsp), %rsi
xorq	%rdi, %rsi
xorq	%rax, %rsi
movq	%rsi, 0x28(%rsp)
movq	%rax, %rdi
movq	%rbx, %r14
movq	%rbx, 0x60(%rsp)
xorq	%rbx, %r11
movq	%r11, %rbx
xorq	%r10, %rbx
xorq	%rsi, %rcx
xorq	%r10, %rcx
movq	%rcx, 0x20(%rsp)
movq	0x88(%rsp), %rax
leal	(,%rax,8), %eax
andl	$0x1ff00, %eax
movq	%rdi, 0x150(%rsp,%rax)
movq	%rdx, 0x158(%rsp,%rax)
movq	%r15, 0x160(%rsp,%rax)
movq	%r10, 0x168(%rsp,%rax)
movq	0x30(%rsp), %r11
xorq	%rbp, %r11
movq	0xa8(%rsp), %rcx
movq	0x40(%rsp), %rbp
xorq	%r14, %r11
movq	0x38(%rsp), %rsi
xorq	%rsi, %rbp
xorq	%r15, %rbp
movq	%r8, %r10
xorq	%r11, %r10
movq	%r11, %r14
movq	%r11, 0x30(%rsp)
xorq	%r15, %r10
movq	0x8(%rsp), %r11
xorq	%r12, %r11
xorq	%rsi, %r11
movq	%r9, %rsi
xorq	%r9, %rcx
movq	%rcx, %r9
xorq	%rdx, %r9
movq	0x50(%rsp), %rcx
xorq	%r11, %rcx
xorq	%rdx, %rcx
movq	%rcx, 0x90(%rsp)
movq	0x80(%rsp), %r15
xorq	%rdi, %r15
movq	0xa0(%rsp), %rdx
xorq	0xb0(%rsp), %rdx
movq	%rdx, 0xa0(%rsp)
movq	0x68(%rsp), %rdi
xorq	%r12, %rdi
movq	%rdi, 0x68(%rsp)
movq	0xc0(%rsp), %r12
xorq	0x78(%rsp), %r12
movq	%r12, 0xc0(%rsp)
movq	0xb8(%rsp), %rcx
xorq	%rcx, 0x70(%rsp)
movq	%rsi, %rcx
movq	0x48(%rsp), %rsi
xorq	%rcx, %rsi
movq	%rsi, 0x48(%rsp)
xorq	%rcx, 0x10(%rsp)
movq	0x38(%rsp), %rcx
xorq	%rcx, 0x18(%rsp)
movq	0x58(%rsp), %rcx
xorq	0x60(%rsp), %rcx
xorq	%rbx, %r12
xorq	0x20(%rsp), %rcx
movq	%rcx, 0x58(%rsp)
movq	%rcx, %r8
xorq	%rbx, %r8
movq	%r8, 0x98(%rsp)
movq	%rsi, 0x170(%rsp,%rax)
movq	%r11, 0x178(%rsp,%rax)
movq	%r14, 0x180(%rsp,%rax)
movq	0x28(%rsp), %rcx
movq	%rcx, 0x188(%rsp,%rax)
movq	%r9, 0x190(%rsp,%rax)
movq	%rbp, 0x198(%rsp,%rax)
movq	%rbx, 0x1a0(%rsp,%rax)
movq	%rdi, %rsi
xorq	%rbp, %rsi
movq	0x18(%rsp), %r14
xorq	%r10, %r14
movq	%r14, 0x18(%rsp)
xorq	%rbp, %r14
movq	%rdx, %rcx
xorq	%r9, %rcx
movq	0x10(%rsp), %rdi
movq	0x90(%rsp), %r8
xorq	%r8, %rdi
movq	%rdi, 0x10(%rsp)
xorq	%r9, %rdi
xorq	0x48(%rsp), %r15
movq	0x70(%rsp), %r9
xorq	%r15, %r9
movq	%r9, 0x70(%rsp)
xorq	0x28(%rsp), %r9
movq	%r12, %rdx
xorq	0x30(%rsp), %rdx
movq	%rsi, %rbx
xorq	%r11, %rbx
movq	%rcx, %rbp
xorq	0x48(%rsp), %rbp
movq	0x20(%rsp), %r11
xorq	0x80(%rsp), %rcx
xorq	0x50(%rsp), %rsi
xorq	0xe0(%rsp), %r12
movq	%r12, 0x38(%rsp)
movq	%r15, 0x1a8(%rsp,%rax)
movq	%r8, 0x1b0(%rsp,%rax)
movq	%r10, 0x80(%rsp)
movq	%r10, 0x1b8(%rsp,%rax)
movq	%r11, 0x1c0(%rsp,%rax)
movq	0xd8(%rsp), %r12
movq	%rbp, 0x8(%rsp)
movq	%rbp, 0x1c8(%rsp,%rax)
movq	%rcx, %rbp
movq	%rbx, 0x30(%rsp)
movq	%rbx, 0x1d0(%rsp,%rax)
movq	%rdx, 0x28(%rsp)
movq	%rdx, 0x1d8(%rsp,%rax)
movq	%r9, 0xa8(%rsp)
movq	0xe8(%rsp), %r8
movq	%r9, 0x1e0(%rsp,%rax)
movq	%rdi, 0x40(%rsp)
movq	%rdi, 0x1e8(%rsp,%rax)
movq	0x58(%rsp), %rdi
movq	%r14, 0x50(%rsp)
movq	%r14, 0x1f0(%rsp,%rax)
movq	0x98(%rsp), %rcx
movq	%rcx, 0x1f8(%rsp,%rax)
movq	0x88(%rsp), %r11
movq	%r15, %rcx
movq	0x90(%rsp), %r15
movq	0xa0(%rsp), %rax
movq	0x70(%rsp), %rdx
movq	%rdx, %r14
xorq	%rdx, %r8
movq	0x10(%rsp), %rdx
xorq	%rdx, %rax
movq	0x18(%rsp), %rdx
movq	0x68(%rsp), %r9
xorq	%rdx, %r9
movq	0xc0(%rsp), %r10
xorq	%rdi, %r10
addq	$0x100, %r13
addl	$0x20, %r11d
cmpq	$0x1cf00, %r13
jb	Lcrc32_chorba_c__c0
xorq	0x1d000(%r12), %rbp
movq	%rbp, 0x78(%rsp)
xorq	0x1d008(%r12), %rsi
movq	%rsi, 0xb0(%rsp)
movq	0x38(%rsp), %rbp
xorq	0x1d010(%r12), %rbp
xorq	0x1d018(%r12), %r8
xorq	0x1d020(%r12), %rax
movq	%rax, 0xa0(%rsp)
xorq	0x1d028(%r12), %r9
movq	%r9, 0x68(%rsp)
xorq	0x1d030(%r12), %r10
movq	%r10, 0xc0(%rsp)
xorq	0x1d038(%r12), %r14
movq	%r14, %r9
movq	0x10(%rsp), %rbx
xorq	0x1d040(%r12), %rbx
movq	%rbx, 0x10(%rsp)
movq	0x18(%rsp), %rsi
xorq	0x1d048(%r12), %rsi
movq	%rsi, 0x18(%rsp)
xorq	0x1d050(%r12), %rdi
movq	%rdi, 0x58(%rsp)
movq	%rcx, %rsi
xorq	0x1d058(%r12), %rsi
xorq	0x1d060(%r12), %r15
movq	%r15, 0x90(%rsp)
movq	0x80(%rsp), %r10
xorq	0x1d068(%r12), %r10
movq	%r10, 0x80(%rsp)
movq	0x20(%rsp), %r11
xorq	0x1d070(%r12), %r11
movq	%r11, 0x20(%rsp)
movq	0x8(%rsp), %rax
xorq	0x1d078(%r12), %rax
movq	%rax, 0x8(%rsp)
movq	0x30(%rsp), %rax
xorq	0x1d080(%r12), %rax
movq	%rax, 0x30(%rsp)
movq	0x28(%rsp), %r13
xorq	0x1d088(%r12), %r13
movq	%r13, 0x28(%rsp)
movq	0xa8(%rsp), %rax
xorq	0x1d090(%r12), %rax
movq	%rax, 0xa8(%rsp)
movq	0x40(%rsp), %rax
xorq	0x1d098(%r12), %rax
movq	%rax, 0x40(%rsp)
movq	0x50(%rsp), %r14
xorq	0x1d0a0(%r12), %r14
movq	%r14, 0x50(%rsp)
movq	0x98(%rsp), %r15
xorq	0x1d0a8(%r12), %r15
movq	%r15, 0x98(%rsp)
movq	0x1d0b0(%r12), %r10
xorq	0x1d200(%rsp), %r10
movq	%r10, %rbx
movq	0x1d0b8(%r12), %r10
xorq	0x1d208(%rsp), %r10
movq	%r10, %rdi
movq	0x1d0c0(%r12), %rcx
xorq	0x1d210(%rsp), %rcx
movq	0x1d0c8(%r12), %r10
xorq	0x1d218(%rsp), %r10
movq	%r10, 0x60(%rsp)
movq	0x1d0d0(%r12), %r10
xorq	0x1d220(%rsp), %r10
movq	%r10, 0x88(%rsp)
movq	0x1d0d8(%r12), %r13
xorq	0x1d228(%rsp), %r13
movq	0x1d0e0(%r12), %r10
xorq	0x1d230(%rsp), %r10
movq	%r10, 0x38(%rsp)
movq	0x78(%rsp), %r15
xorq	%r15, %r9
movq	%r9, 0x70(%rsp)
movq	0x1d0e8(%r12), %rax
xorq	0x1d238(%rsp), %rax
movq	%rax, 0x48(%rsp)
xorq	%r15, %rsi
movq	%rsi, 0xc8(%rsp)
movq	0x1d0f0(%r12), %r11
xorq	0x1d240(%rsp), %r11
xorq	%r15, %rbx
movq	%rbx, 0xb8(%rsp)
movq	0x1d0f8(%r12), %r10
xorq	0x1d248(%rsp), %r10
movq	%r15, 0x1a200(%rsp)
movq	0x10(%rsp), %r9
movq	0xb0(%rsp), %rdx
xorq	%rdx, %r9
movq	0x90(%rsp), %rbx
xorq	%rdx, %rbx
xorq	%rdx, %rdi
movq	%rdi, 0x10(%rsp)
movq	%rdx, 0x1a208(%rsp)
movq	0x18(%rsp), %rdi
xorq	%rbp, %rdi
movq	0x80(%rsp), %r14
xorq	%rbp, %r14
xorq	%rbp, %rcx
movq	%rcx, 0xb0(%rsp)
movq	%rbp, 0x1a210(%rsp)
movq	0x58(%rsp), %rbp
xorq	%r8, %rbp
movq	0x20(%rsp), %rsi
xorq	%r8, %rsi
movq	0x60(%rsp), %rax
xorq	%r8, %rax
movq	%rax, 0x60(%rsp)
movq	%r8, 0x1a218(%rsp)
movq	0xc8(%rsp), %r12
movq	0xa0(%rsp), %rdx
xorq	%rdx, %r12
movq	0x8(%rsp), %r8
xorq	%rdx, %r8
movq	0x88(%rsp), %rcx
xorq	%rdx, %rcx
movq	%rcx, 0x88(%rsp)
movq	%rdx, 0x1a220(%rsp)
movq	0x68(%rsp), %rdx
xorq	%rdx, %rbx
movq	%rbx, 0x90(%rsp)
movq	0x30(%rsp), %r15
xorq	%rdx, %r15
xorq	%rdx, %r13
movq	%r13, 0x58(%rsp)
movq	%rdx, 0x1a228(%rsp)
movq	0xc0(%rsp), %rdx
xorq	%rdx, %r14
movq	%r14, 0x80(%rsp)
movq	0x28(%rsp), %r13
xorq	%rdx, %r13
xorq	%rdx, 0x38(%rsp)
movq	%rdx, 0x1a230(%rsp)
movq	0x70(%rsp), %rdx
xorq	%rdx, %rsi
movq	0xa8(%rsp), %rbx
xorq	%rdx, %rbx
xorq	%rdx, 0x48(%rsp)
movq	%rdx, 0x1a238(%rsp)
xorq	%r9, %r8
movq	%r8, 0x8(%rsp)
movq	0x40(%rsp), %r14
xorq	%r9, %r14
xorq	%r9, %r11
movq	%r11, 0x18(%rsp)
movq	%r9, 0x1a240(%rsp)
movq	%rdi, %rdx
xorq	%rdi, %r15
movq	%r15, 0x30(%rsp)
movq	0x50(%rsp), %rdi
xorq	%rdx, %rdi
xorq	%rdx, %r10
movq	%rdx, 0x1a248(%rsp)
xorq	%rbp, %r13
movq	%r13, 0x28(%rsp)
xorq	%r12, %rbx
movq	%rsi, 0x20(%rsp)
xorq	%rbx, %rax
movq	%rax, 0x70(%rsp)
movq	0x98(%rsp), %r9
xorq	%r9, %rax
movq	%rax, 0x78(%rsp)
xorq	%rsi, %r9
xorq	%rbp, %r9
movq	%rbp, 0x1a250(%rsp)
movq	%r14, %r13
movq	0x90(%rsp), %r8
xorq	%r8, %r13
movq	%rdi, %rbp
xorq	%r13, %rcx
movq	%rcx, %r15
movq	0xb8(%rsp), %rsi
xorq	%rsi, %rcx
movq	%rcx, 0x50(%rsp)
xorq	%r12, %rsi
movq	%r12, 0x1a258(%rsp)
movq	%r10, %r14
movq	0x80(%rsp), %rdx
xorq	%rdx, %rbp
movq	0x58(%rsp), %r12
movq	%r12, %rax
xorq	%rbp, %rax
movq	%rax, %r10
movq	0x10(%rsp), %rdi
xorq	%rdi, %rax
movq	%rax, 0x98(%rsp)
xorq	%r8, %rdi
movq	%r8, 0x1a260(%rsp)
movq	0x38(%rsp), %r8
movq	0x48(%rsp), %r11
movq	0xb0(%rsp), %rax
xorq	%rdx, %rax
movq	%rdx, 0x1a268(%rsp)
movq	0x20(%rsp), %rdx
xorq	%rdx, 0x70(%rsp)
movq	%rdx, 0x1a270(%rsp)
movq	0x8(%rsp), %rcx
xorq	%rcx, %rsi
xorq	%rcx, %r15
movq	%r15, 0x40(%rsp)
movq	%rcx, 0x1a278(%rsp)
movq	%r9, %r15
movq	0x30(%rsp), %rdx
xorq	%rdx, %rdi
xorq	%rdx, %r10
movq	%r10, 0x8(%rsp)
movq	%rdx, 0x1a280(%rsp)
movq	0x28(%rsp), %rdx
xorq	%rdx, %rax
xorq	%r9, %r8
movq	%r8, %rcx
xorq	%rdx, %rcx
movq	%rdx, 0x1a288(%rsp)
xorq	%rsi, %r11
movq	%r11, %r10
xorq	%rbx, %r10
movq	%rbx, 0x1a290(%rsp)
movq	0x18(%rsp), %rdx
xorq	%rdi, %rdx
movq	%rdx, %rbx
xorq	%r13, %rbx
movq	%r13, 0x1a298(%rsp)
movq	%rsi, %r13
xorq	%rax, %r14
movq	%r14, %r9
xorq	%rbp, %r9
movq	%rbp, 0x1a2a0(%rsp)
movq	%rax, %rsi
movq	0x60(%rsp), %rax
movq	0xb0(%rsp), %rbp
movq	%r8, 0x38(%rsp)
xorq	%r8, %rbp
movq	%rdx, %r8
xorq	%r11, %rax
xorq	%rdx, 0x88(%rsp)
movq	%rdi, %rdx
movq	%r14, 0x30(%rsp)
xorq	%r14, %r12
movq	%r12, 0x58(%rsp)
movq	%r15, 0xa0(%rsp)
movq	%r15, 0x1a2a8(%rsp)
movq	%r10, %rdi
movq	0x40(%rsp), %r12
movq	%r13, 0x90(%rsp)
movq	%r13, 0x1a2b0(%rsp)
movq	%rcx, %r13
movq	0x70(%rsp), %rcx
movq	%rdx, 0x1a2b8(%rsp)
movq	%rsi, 0x1a2c0(%rsp)
movq	%rcx, 0x1a2c8(%rsp)
movq	%r12, 0x1a2d0(%rsp)
movq	0x8(%rsp), %rcx
movq	%rcx, 0x1a2d8(%rsp)
movq	%rbx, %r14
movq	%r13, 0x1a2e0(%rsp)
movq	%r10, 0x1a2e8(%rsp)
movq	%rbx, 0x1a2f0(%rsp)
movq	%r9, 0x68(%rsp)
movq	%r9, 0x1a2f8(%rsp)
movl	$0x1d100, %r10d
movq	0xd0(%rsp), %r15
cmpq	$0x3a3b1, %r15
jb	Lcrc32_chorba_c__142e
movl	$0x3a3b0, %r10d
movq	%r10, 0xb8(%rsp)
movl	$0x3a20, %r10d
movq	%rdi, 0xa8(%rsp)
movq	0x90(%rsp), %rbx
movq	0x58(%rsp), %rdi
movq	%r13, 0x28(%rsp)
movq	%r14, %r12
movq	%r8, 0x18(%rsp)
movq	%rbp, %r13
movq	%rsi, 0x10(%rsp)
movq	0x30(%rsp), %r8
movq	0x88(%rsp), %rsi
movq	0x98(%rsp), %r14
movq	0x50(%rsp), %r9
movq	0x78(%rsp), %rcx
nopl	(%rax,%rax)
Lcrc32_chorba_c__cd0:
movq	%rdx, 0x20(%rsp)
movq	%rax, %rdx
movl	%r10d, %eax
andl	$0x3fe0, %eax
movq	0xd8(%rsp), %rbp
xorq	(%rbp,%r10,8), %rcx
xorq	0x150(%rsp,%rax,8), %rcx
movq	%rcx, 0x78(%rsp)
xorq	0x8(%rbp,%r10,8), %r9
xorq	0x158(%rsp,%rax,8), %r9
movq	%r9, 0xc8(%rsp)
xorq	0x10(%rbp,%r10,8), %r14
xorq	0x160(%rsp,%rax,8), %r14
movq	%r14, 0xf8(%rsp)
xorq	0x18(%rbp,%r10,8), %r13
xorq	0x168(%rsp,%rax,8), %r13
movq	%r13, 0x80(%rsp)
xorq	0x20(%rbp,%r10,8), %rdx
xorq	0x170(%rsp,%rax,8), %rdx
movq	%rdx, 0x58(%rsp)
xorq	0x28(%rbp,%r10,8), %rsi
xorq	0x178(%rsp,%rax,8), %rsi
movq	%rsi, 0xf0(%rsp)
xorq	0x30(%rbp,%r10,8), %rdi
xorq	0x180(%rsp,%rax,8), %rdi
movq	%rdi, 0x98(%rsp)
movq	0x38(%rsp), %r15
xorq	0x38(%rbp,%r10,8), %r15
xorq	0x188(%rsp,%rax,8), %r15
xorq	0x40(%rbp,%r10,8), %r11
xorq	0x190(%rsp,%rax,8), %r11
movq	0x18(%rsp), %r13
xorq	0x48(%rbp,%r10,8), %r13
xorq	0x198(%rsp,%rax,8), %r13
movq	%r8, %rcx
xorq	0x50(%rbp,%r10,8), %rcx
xorq	0x1a0(%rsp,%rax,8), %rcx
movq	%r11, %rdi
movq	0xa0(%rsp), %r11
xorq	0x58(%rbp,%r10,8), %r11
xorq	0x1a8(%rsp,%rax,8), %r11
xorq	0x60(%rbp,%r10,8), %rbx
xorq	0x1b0(%rsp,%rax,8), %rbx
movq	0x20(%rsp), %rdx
xorq	0x68(%rbp,%r10,8), %rdx
xorq	0x1b8(%rsp,%rax,8), %rdx
movq	%rdx, 0x20(%rsp)
movq	0x10(%rsp), %rdx
xorq	0x70(%rbp,%r10,8), %rdx
xorq	0x1c0(%rsp,%rax,8), %rdx
movq	%rdx, 0x10(%rsp)
movq	0x70(%rsp), %rdx
xorq	0x78(%rbp,%r10,8), %rdx
xorq	0x1c8(%rsp,%rax,8), %rdx
movq	%rdx, 0x70(%rsp)
movq	0x40(%rsp), %rdx
xorq	0x80(%rbp,%r10,8), %rdx
xorq	0x1d0(%rsp,%rax,8), %rdx
movq	%rdx, 0x40(%rsp)
movq	0x8(%rsp), %rdx
xorq	0x88(%rbp,%r10,8), %rdx
xorq	0x1d8(%rsp,%rax,8), %rdx
movq	%rdx, 0x8(%rsp)
movq	0x28(%rsp), %rdx
xorq	0x90(%rbp,%r10,8), %rdx
xorq	0x1e0(%rsp,%rax,8), %rdx
movq	%rdx, 0x28(%rsp)
movq	0xa8(%rsp), %rdx
xorq	0x98(%rbp,%r10,8), %rdx
xorq	0x1e8(%rsp,%rax,8), %rdx
movq	%rdx, 0xa8(%rsp)
xorq	0xa0(%rbp,%r10,8), %r12
xorq	0x1f0(%rsp,%rax,8), %r12
movq	%r12, 0xc0(%rsp)
movq	0x68(%rsp), %rsi
xorq	0xa8(%rbp,%r10,8), %rsi
xorq	0x1f8(%rsp,%rax,8), %rsi
movq	%rsi, 0x90(%rsp)
movq	0xb0(%rbp,%r10,8), %rsi
xorq	0x200(%rsp,%rax,8), %rsi
movq	%rsi, %r12
movq	0xb8(%rbp,%r10,8), %rsi
xorq	0x208(%rsp,%rax,8), %rsi
movq	0xc0(%rbp,%r10,8), %rdx
xorq	0x210(%rsp,%rax,8), %rdx
movq	%rdx, 0xb0(%rsp)
movq	0xc8(%rbp,%r10,8), %rdx
xorq	0x218(%rsp,%rax,8), %rdx
movq	%rdx, 0x60(%rsp)
movq	0xd0(%rbp,%r10,8), %rdx
xorq	0x220(%rsp,%rax,8), %rdx
movq	%rdx, 0x88(%rsp)
movq	%rdi, %r14
movq	0xd8(%rbp,%r10,8), %rdx
xorq	0x228(%rsp,%rax,8), %rdx
movq	%rdx, %rdi
movq	%r13, %r8
movq	0xe0(%rbp,%r10,8), %rdx
xorq	0x230(%rsp,%rax,8), %rdx
movq	%rdx, 0x38(%rsp)
movq	%rcx, 0x68(%rsp)
movq	0xe8(%rbp,%r10,8), %rcx
xorq	0x238(%rsp,%rax,8), %rcx
movq	%rcx, 0x48(%rsp)
movq	0xf0(%rbp,%r10,8), %rcx
xorq	0x240(%rsp,%rax,8), %rcx
movq	%rcx, 0x18(%rsp)
movq	0xf8(%rbp,%r10,8), %rcx
xorq	0x248(%rsp,%rax,8), %rcx
movq	%rcx, 0x30(%rsp)
leal	0x3a00(%r10), %eax
andl	$0x3fe0, %eax
movq	0x78(%rsp), %rcx
xorq	%rcx, %r15
movq	%r15, %r9
movq	%r15, 0xe0(%rsp)
xorq	%rcx, %r11
xorq	%rcx, %r12
movq	%r12, 0x50(%rsp)
movq	%rcx, 0x200(%rsp,%rax,8)
movq	0xc8(%rsp), %rcx
movq	%r14, %r15
xorq	%rcx, %r15
movq	%r15, 0x78(%rsp)
movq	%rbx, %r12
xorq	%rcx, %r12
xorq	%rcx, %rsi
movq	%rsi, %r13
movq	%rsi, 0xe8(%rsp)
movq	%rcx, 0x208(%rsp,%rax,8)
movq	0xf8(%rsp), %rcx
movq	%r8, %r14
xorq	%rcx, %r14
movq	0x20(%rsp), %rdx
xorq	%rcx, %rdx
movq	0xb0(%rsp), %rbx
xorq	%rcx, %rbx
movq	%rbx, 0xb0(%rsp)
movq	%rcx, 0x210(%rsp,%rax,8)
movq	0x80(%rsp), %r8
movq	%r8, 0x218(%rsp,%rax,8)
movq	0x58(%rsp), %rcx
movq	%rcx, 0x220(%rsp,%rax,8)
movq	0xf0(%rsp), %rsi
movq	%rsi, 0x228(%rsp,%rax,8)
movq	0x98(%rsp), %rbp
movq	%rbp, 0x230(%rsp,%rax,8)
movq	%r9, 0x238(%rsp,%rax,8)
movq	%r15, 0x240(%rsp,%rax,8)
movq	%r14, 0x248(%rsp,%rax,8)
leal	0x3a20(%r10), %eax
andl	$0x3fe0, %eax
movq	%r10, %r9
movq	0x68(%rsp), %r10
xorq	%r8, %r10
xorq	%rcx, %r11
movq	0x70(%rsp), %r15
movq	%r12, %rcx
xorq	%rsi, %rcx
movq	%rsi, %r12
movq	%rdx, %rsi
xorq	%rbp, %rsi
movq	0x10(%rsp), %rdx
xorq	%r8, %rdx
movq	%rdx, 0xa0(%rsp)
movq	0x8(%rsp), %rdx
xorq	%rbp, %rdx
movq	%rdx, %r8
movq	%r10, %rdx
movq	%r10, 0x68(%rsp)
movq	%r9, %r10
xorq	%rdx, %r8
movq	%r8, 0x8(%rsp)
movq	0xc0(%rsp), %r9
movq	%r14, 0xc8(%rsp)
xorq	%r14, %r9
xorq	%rsi, %r9
xorq	%r8, %rbx
xorq	%rsi, %rbx
movq	%rbx, 0x10(%rsp)
movq	%rdx, 0x150(%rsp,%rax,8)
movq	%r11, 0x158(%rsp,%rax,8)
movq	%rcx, 0x160(%rsp,%rax,8)
movq	%rsi, 0x168(%rsp,%rax,8)
movq	0x40(%rsp), %rdx
xorq	%r12, %rdx
movq	%r12, %rbp
movq	%rdx, %r8
xorq	%r14, %r8
movq	%r8, 0x40(%rsp)
movq	0xa8(%rsp), %r12
movq	0x78(%rsp), %rsi
xorq	%rsi, %r12
xorq	%rcx, %r12
movq	%r13, %rdx
xorq	%r8, %rdx
xorq	%rcx, %rdx
movq	0x58(%rsp), %r14
xorq	%r14, %r15
movq	%r15, %r8
xorq	%rsi, %r8
movq	0x28(%rsp), %r15
movq	0xe0(%rsp), %rbx
xorq	%rbx, %r15
xorq	%r11, %r15
movq	0x50(%rsp), %r13
xorq	%r8, %r13
xorq	%r11, %r13
movq	0x90(%rsp), %rsi
xorq	0x68(%rsp), %rsi
movq	0x60(%rsp), %r11
xorq	0x80(%rsp), %r11
movq	%r11, 0x60(%rsp)
movq	0x88(%rsp), %rcx
xorq	%r14, %rcx
movq	%rcx, 0x88(%rsp)
xorq	%rbp, %rdi
movq	%rdi, 0x58(%rsp)
movq	0x98(%rsp), %r14
xorq	%r14, 0x38(%rsp)
movq	0xa0(%rsp), %rbp
xorq	%rbx, %rbp
xorq	%rbx, 0x48(%rsp)
movq	0x78(%rsp), %rbx
xorq	%rbx, 0x18(%rsp)
movq	0x30(%rsp), %rbx
xorq	0xc8(%rsp), %rbx
movq	%rdi, %r14
xorq	%r9, %r14
xorq	0x10(%rsp), %rbx
movq	%rbx, 0x30(%rsp)
movq	%rbx, %rdi
xorq	%r9, %rdi
movq	%rdi, 0x68(%rsp)
movq	0x58(%rsp), %rdi
movq	%rbp, %rbx
movq	%rbp, 0xa0(%rsp)
movq	%rbp, 0x170(%rsp,%rax,8)
movq	%r8, 0x178(%rsp,%rax,8)
movq	0x40(%rsp), %rbp
movq	%rbp, 0x180(%rsp,%rax,8)
movq	0x8(%rsp), %rbp
movq	%rbp, 0x188(%rsp,%rax,8)
movq	%r15, 0x190(%rsp,%rax,8)
movq	%r12, 0x198(%rsp,%rax,8)
movq	%r9, 0x1a0(%rsp,%rax,8)
movq	%rcx, %r9
xorq	%r12, %r9
movq	0x18(%rsp), %rcx
xorq	%rdx, %rcx
movq	%rcx, 0x18(%rsp)
xorq	%r12, %rcx
movq	%rcx, 0xc0(%rsp)
movq	%r11, %rcx
xorq	%r15, %rcx
movq	0x48(%rsp), %r12
xorq	%r13, %r12
movq	%r12, 0x48(%rsp)
xorq	%r15, %r12
movq	0x38(%rsp), %r15
xorq	%rbx, %rsi
xorq	%rsi, %r15
movq	%r15, %rbp
xorq	0x8(%rsp), %rbp
movq	%r14, %r11
xorq	0x40(%rsp), %r11
movq	%r9, %rbx
xorq	%r8, %rbx
movq	%rdx, 0x20(%rsp)
movq	%rcx, %r8
xorq	0xa0(%rsp), %r8
xorq	0x90(%rsp), %rcx
xorq	0x50(%rsp), %r9
xorq	0xe8(%rsp), %r14
movq	%rsi, 0xa0(%rsp)
movq	%rsi, 0x1a8(%rsp,%rax,8)
movq	0x88(%rsp), %rsi
movq	%r13, 0x1b0(%rsp,%rax,8)
movq	%rdx, 0x1b8(%rsp,%rax,8)
movq	0x10(%rsp), %rdx
movq	%rdx, 0x1c0(%rsp,%rax,8)
movq	%r8, 0x70(%rsp)
movq	%r8, 0x1c8(%rsp,%rax,8)
movq	%rbx, 0x40(%rsp)
movq	%rbx, 0x1d0(%rsp,%rax,8)
movq	%r13, %rbx
movq	0xb0(%rsp), %r13
movq	%r11, 0x8(%rsp)
movq	%r11, 0x1d8(%rsp,%rax,8)
movq	0x48(%rsp), %r11
movq	%rbp, 0x28(%rsp)
movq	%rbp, 0x1e0(%rsp,%rax,8)
movq	0xc0(%rsp), %rbp
movq	%r12, 0xa8(%rsp)
movq	%r12, 0x1e8(%rsp,%rax,8)
movq	%rbp, %r12
movq	%rbp, 0x1f0(%rsp,%rax,8)
movq	0x68(%rsp), %rdx
movq	%rdx, 0x1f8(%rsp,%rax,8)
movq	0x60(%rsp), %rax
movq	%r15, 0x38(%rsp)
xorq	%r15, %r13
movq	0xd0(%rsp), %r15
xorq	%r11, %rax
xorq	0x18(%rsp), %rsi
movq	0x30(%rsp), %rdx
movq	%rdx, %r8
xorq	%rdx, %rdi
movq	0xb8(%rsp), %rdx
addq	$0x100, %rdx
addq	$0x20, %r10
movq	%rdx, 0xb8(%rsp)
cmpq	%r15, %rdx
movq	0x20(%rsp), %rdx
jb	Lcrc32_chorba_c__cd0
movq	%rcx, 0x78(%rsp)
movq	%r9, 0x50(%rsp)
movq	%r14, 0x98(%rsp)
movq	%rsi, 0x88(%rsp)
movq	%rax, 0x60(%rsp)
movq	0xb8(%rsp), %r10
addq	$-0x1d2b0, %r10
movq	0x18(%rsp), %r9
movq	%r13, %rbp
movq	0x10(%rsp), %rsi
movq	%rbx, 0x90(%rsp)
movq	%r12, %rbx
movq	0x40(%rsp), %r12
movq	%rdi, %r11
movq	0x28(%rsp), %r13
movq	0xa8(%rsp), %rdi
movq	%rbx, %r14
jmp	Lcrc32_chorba_c__1445
Lcrc32_chorba_c__142e:
movq	%rdx, 0x20(%rsp)
movq	%rax, 0x60(%rsp)
movq	%r11, 0x48(%rsp)
movq	%r8, %r9
movq	0x58(%rsp), %r11
Lcrc32_chorba_c__1445:
movq	%r10, %rax
shrq	$0x3, %rax
movl	%eax, %edx
andl	$0x3fe0, %edx
movq	0x78(%rsp), %rcx
xorq	%rcx, 0x150(%rsp,%rdx,8)
movq	0x50(%rsp), %rcx
xorq	%rcx, 0x158(%rsp,%rdx,8)
movq	0x98(%rsp), %rcx
xorq	%rcx, 0x160(%rsp,%rdx,8)
xorq	%rbp, 0x168(%rsp,%rdx,8)
movq	0x60(%rsp), %r8
xorq	%r8, 0x170(%rsp,%rdx,8)
movq	0x88(%rsp), %rcx
xorq	%rcx, 0x178(%rsp,%rdx,8)
xorq	%r11, 0x180(%rsp,%rdx,8)
movq	0x38(%rsp), %rcx
xorq	%rcx, 0x188(%rsp,%rdx,8)
movq	0x48(%rsp), %r8
xorq	%r8, 0x190(%rsp,%rdx,8)
xorq	%r9, 0x198(%rsp,%rdx,8)
movq	0x30(%rsp), %rcx
xorq	%rcx, 0x1a0(%rsp,%rdx,8)
movq	0xa0(%rsp), %rcx
xorq	%rcx, 0x1a8(%rsp,%rdx,8)
movq	0x90(%rsp), %rcx
xorq	%rcx, 0x1b0(%rsp,%rdx,8)
movq	0x20(%rsp), %rcx
xorq	%rcx, 0x1b8(%rsp,%rdx,8)
xorq	%rsi, 0x1c0(%rsp,%rdx,8)
movq	0x70(%rsp), %rcx
xorq	%rcx, 0x1c8(%rsp,%rdx,8)
xorq	%r12, 0x1d0(%rsp,%rdx,8)
movq	0x8(%rsp), %rcx
xorq	%rcx, 0x1d8(%rsp,%rdx,8)
xorq	%r13, 0x1e0(%rsp,%rdx,8)
xorq	%rdi, 0x1e8(%rsp,%rdx,8)
xorq	%r14, 0x1f0(%rsp,%rdx,8)
movq	0x68(%rsp), %rcx
xorq	%rcx, 0x1f8(%rsp,%rdx,8)
leal	0x3a16(%rax), %ecx
andl	$0x3fff, %ecx
leal	0x3a55(%rax), %edx
andl	$0x3fff, %edx
cmpw	%cx, %dx
jae	Lcrc32_chorba_c__15f2
addq	$0x3a19, %rax
movl	$0x40, %ecx
movq	%r15, %rdi
nopw	%cs:(%rax,%rax)
Lcrc32_chorba_c__1590:
leal	-0x3(%rax), %edx
andl	$0x3fff, %edx
movq	$0x0, 0x150(%rsp,%rdx,8)
leal	-0x2(%rax), %edx
andl	$0x3fff, %edx
movq	$0x0, 0x150(%rsp,%rdx,8)
leal	-0x1(%rax), %edx
andl	$0x3fff, %edx
movq	$0x0, 0x150(%rsp,%rdx,8)
movl	%eax, %edx
andl	$0x3fff, %edx
movq	$0x0, 0x150(%rsp,%rdx,8)
addq	$0x4, %rax
addq	$-0x4, %rcx
jne	Lcrc32_chorba_c__1590
jmp	Lcrc32_chorba_c__17b6
Lcrc32_chorba_c__15f2:
leal	0x3a16(%rax), %ecx
andl	$0x3fff, %ecx
xorps	%xmm0, %xmm0
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a1a(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a1e(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a22(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a26(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a2a(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a2e(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a32(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a36(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a3a(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a3e(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a42(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a46(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a4a(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
leal	0x3a4e(%rax), %ecx
andl	$0x3fff, %ecx
movups	%xmm0, 0x150(%rsp,%rcx,8)
movups	%xmm0, 0x160(%rsp,%rcx,8)
addl	$0x3a52, %eax
andl	$0x3fff, %eax
movups	%xmm0, 0x150(%rsp,%rax,8)
movups	%xmm0, 0x160(%rsp,%rax,8)
movq	%r15, %rdi
Lcrc32_chorba_c__17b6:
xorps	%xmm0, %xmm0
movaps	%xmm0, 0x130(%rsp)
movaps	%xmm0, 0x120(%rsp)
movaps	%xmm0, 0x110(%rsp)
movaps	%xmm0, 0x100(%rsp)
movq	$0x0, 0x140(%rsp)
leaq	0x48(%r10), %rax
xorl	%r14d, %r14d
cmpq	%rdi, %rax
jae	Lcrc32_chorba_c__19cb
xorl	%r15d, %r15d
movq	%r10, %rax
xorl	%edx, %edx
xorl	%r13d, %r13d
xorl	%ecx, %ecx
xorl	%ebx, %ebx
nopw	%cs:(%rax,%rax)
Lcrc32_chorba_c__1810:
movq	%rax, %rsi
shrq	$0x3, %rsi
movl	%esi, %edi
andl	$0x3ffc, %edi
movq	0xd8(%rsp), %r9
xorq	(%r9,%rax), %r15
xorq	0x150(%rsp,%rdi,8), %r15
xorq	0x8(%r9,%rsi,8), %rbx
movq	%r15, %rdi
shrq	$0x2f, %rdi
movq	%r15, %r8
shrq	$0x9, %r8
xorq	%r13, %r8
movq	%r15, %r12
shlq	$0x13, %r12
xorq	%rdi, %r12
xorq	%r8, %r12
movq	%rsi, %rdi
movq	%rsi, %r8
xorq	0x10(%r9,%rsi,8), %rcx
xorq	0x18(%r9,%rsi,8), %r12
orq	$0x1, %rsi
andl	$0x3fff, %esi
xorq	0x150(%rsp,%rsi,8), %rbx
movq	%r15, %rsi
shlq	$0x11, %rsi
movq	%r15, %r9
shrq	$0x2d, %r9
movq	%r15, %r10
shlq	$0x2c, %r10
orq	%r9, %r10
xorq	%rdx, %r10
movq	%rbx, %rdx
shlq	$0x11, %rdx
movq	%rbx, %r9
shlq	$0x37, %r9
xorq	%rdx, %r9
movq	%rbx, %rdx
shrq	$0x2f, %rdx
movq	%rbx, %r11
shrq	$0x9, %r11
xorq	%rdx, %r11
xorq	%r10, %r11
movq	%rbx, %r10
shlq	$0x13, %r10
xorq	%r11, %r10
movq	%rbx, %r11
shrq	$0x2d, %r11
movq	%rbx, %rdx
shlq	$0x2c, %rdx
orq	%r11, %rdx
movq	%r15, %r11
shlq	$0x37, %r11
shrq	$0x14, %r15
xorq	%r15, %rdx
shrq	$0x14, %rbx
orq	$0x2, %rdi
andl	$0x3fff, %edi
orq	$0x3, %r8
andl	$0x3fff, %r8d
xorq	%r11, %rcx
xorq	%rsi, %rcx
xorq	0x150(%rsp,%rdi,8), %rcx
xorq	%r9, %r12
xorq	0x150(%rsp,%r8,8), %r12
movq	%rcx, %rsi
shlq	$0x11, %rsi
movq	%rcx, %r15
shlq	$0x37, %r15
xorq	%r10, %r15
xorq	%rsi, %r15
movq	%rcx, %rsi
shrq	$0x2f, %rsi
movq	%rcx, %rdi
shrq	$0x9, %rdi
xorq	%rdx, %rdi
movq	%rcx, %rdx
shlq	$0x13, %rdx
xorq	%rsi, %rdx
xorq	%rdi, %rdx
movq	%rcx, %rsi
shrq	$0x2d, %rsi
movq	%rcx, %rdi
shlq	$0x2c, %rdi
orq	%rsi, %rdi
xorq	%rbx, %rdi
shrq	$0x14, %rcx
movq	%r12, %rsi
shlq	$0x11, %rsi
movq	%r12, %rbx
shlq	$0x37, %rbx
xorq	%rdx, %rbx
xorq	%rsi, %rbx
movq	%r12, %rdx
shrq	$0x2f, %rdx
movq	%r12, %rsi
shrq	$0x9, %rsi
xorq	%rdi, %rsi
movq	0xd0(%rsp), %rdi
movq	%r12, %rbp
shlq	$0x13, %rbp
xorq	%rdx, %rbp
xorq	%rsi, %rbp
movq	%r12, %rdx
shrq	$0x2d, %rdx
movq	%r12, %r13
shlq	$0x2c, %r13
orq	%rdx, %r13
xorq	%rcx, %r13
shrq	$0x14, %r12
leaq	0x20(%rax), %r10
addq	$0x68, %rax
movq	%r12, %rdx
movq	%rbp, %rcx
cmpq	%rdi, %rax
movq	%r10, %rax
jb	Lcrc32_chorba_c__1810
jmp	Lcrc32_chorba_c__19d8
Lcrc32_chorba_c__19cb:
xorl	%ebx, %ebx
xorl	%ebp, %ebp
xorl	%r13d, %r13d
xorl	%r12d, %r12d
xorl	%r15d, %r15d
Lcrc32_chorba_c__19d8:
movq	%r10, 0xb8(%rsp)
movq	0xd8(%rsp), %rsi
addq	%r10, %rsi
movq	%rdi, %rdx
subq	%r10, %rdx
leaq	0x100(%rsp), %rdi
callq	memcpy
movq	0xb8(%rsp), %r10
movq	0xd0(%rsp), %rcx
xorq	%r15, 0x100(%rsp)
xorq	%rbx, 0x108(%rsp)
xorq	%rbp, 0x110(%rsp)
xorq	%r13, 0x118(%rsp)
xorq	%r12, 0x120(%rsp)
movq	%rcx, %rax
subq	%r10, %rax
je	Lcrc32_chorba_c__1b02
leaq	0x1(%r10), %rdx
cmpq	%rdx, %rcx
jne	Lcrc32_chorba_c__1a52
xorl	%ecx, %ecx
xorl	%r14d, %r14d
jmp	Lcrc32_chorba_c__1acf
Lcrc32_chorba_c__1a52:
movq	%rax, %rsi
andq	$-0x2, %rsi
xorl	%ecx, %ecx
leaq	crc32_chorba_c__crc_table(%rip), %rdi
xorl	%r14d, %r14d
nopw	%cs:(%rax,%rax)
Lcrc32_chorba_c__1a70:
leal	(%r10,%rcx), %r8d
andl	$0x1ffff, %r8d
movzbl	0x100(%rsp,%rcx), %r9d
xorb	%r14b, %r9b
xorb	0x150(%rsp,%r8), %r9b
movzbl	%r9b, %r8d
shrl	$0x8, %r14d
xorl	(%rdi,%r8,4), %r14d
leal	(%rdx,%rcx), %r8d
andl	$0x1ffff, %r8d
movzbl	0x101(%rsp,%rcx), %r9d
xorb	%r14b, %r9b
xorb	0x150(%rsp,%r8), %r9b
movzbl	%r9b, %r8d
shrl	$0x8, %r14d
xorl	(%rdi,%r8,4), %r14d
addq	$0x2, %rcx
cmpq	%rcx, %rsi
jne	Lcrc32_chorba_c__1a70
Lcrc32_chorba_c__1acf:
testb	$0x1, %al
je	Lcrc32_chorba_c__1b02
addl	%ecx, %r10d
andl	$0x1ffff, %r10d
movzbl	0x100(%rsp,%rcx), %eax
xorb	%r14b, %al
xorb	0x150(%rsp,%r10), %al
movzbl	%al, %eax
leaq	crc32_chorba_c__crc_table(%rip), %rcx
shrl	$0x8, %r14d
xorl	(%rcx,%rax,4), %r14d
Lcrc32_chorba_c__1b02:
movl	%r14d, %eax
addq	$0x20158, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
nopw	(%rax,%rax)
crc32_chorba_32768_nondestructive:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0x8068, %rsp
movq	%rdx, %rbx
movq	%rsi, %r14
movl	%edi, %ebp
leaq	0x60(%rsp), %rdi
xorl	%r12d, %r12d
movl	$0x8000, %edx
xorl	%esi, %esi
callq	memset
movq	%rbx, %r9
movl	%ebp, %eax
movq	%rax, 0x60(%rsp)
cmpq	$0x9a1, %rbx
jb	Lcrc32_chorba_c__1ceb
xorl	%eax, %eax
nopw	%cs:(%rax,%rax)
Lcrc32_chorba_c__1b70:
movdqu	(%r14,%rax), %xmm0
pxor	0x60(%rsp,%rax), %xmm0
movdqu	0x4e8(%rsp,%rax), %xmm1
movdqu	0x4f8(%rsp,%rax), %xmm2
movdqu	0x508(%rsp,%rax), %xmm3
movdqu	0x518(%rsp,%rax), %xmm4
pxor	%xmm0, %xmm1
movdqu	%xmm1, 0x4e8(%rsp,%rax)
movdqu	0x10(%r14,%rax), %xmm1
pxor	0x70(%rsp,%rax), %xmm1
pxor	%xmm1, %xmm2
movdqu	%xmm2, 0x4f8(%rsp,%rax)
movdqu	0x20(%r14,%rax), %xmm2
pxor	0x80(%rsp,%rax), %xmm2
pxor	%xmm2, %xmm3
movdqu	%xmm3, 0x508(%rsp,%rax)
movdqu	0x30(%r14,%rax), %xmm3
pxor	0x90(%rsp,%rax), %xmm3
pxor	%xmm3, %xmm4
movdqu	%xmm4, 0x518(%rsp,%rax)
movdqu	0x618(%rsp,%rax), %xmm4
pxor	%xmm0, %xmm4
movdqu	%xmm4, 0x618(%rsp,%rax)
movdqu	0x628(%rsp,%rax), %xmm4
pxor	%xmm1, %xmm4
movdqu	%xmm4, 0x628(%rsp,%rax)
movdqu	0x638(%rsp,%rax), %xmm4
pxor	%xmm2, %xmm4
movdqu	%xmm4, 0x638(%rsp,%rax)
movdqu	0x648(%rsp,%rax), %xmm4
pxor	%xmm3, %xmm4
movdqu	%xmm4, 0x648(%rsp,%rax)
movdqu	0x6f8(%rsp,%rax), %xmm4
pxor	%xmm0, %xmm4
movdqu	%xmm4, 0x6f8(%rsp,%rax)
movdqu	0x708(%rsp,%rax), %xmm4
pxor	%xmm1, %xmm4
movdqu	%xmm4, 0x708(%rsp,%rax)
movdqu	0x718(%rsp,%rax), %xmm4
pxor	%xmm2, %xmm4
movdqu	%xmm4, 0x718(%rsp,%rax)
movdqu	0x728(%rsp,%rax), %xmm4
pxor	%xmm3, %xmm4
movdqu	%xmm4, 0x728(%rsp,%rax)
movdqa	%xmm0, 0x9c0(%rsp,%rax)
movdqa	%xmm1, 0x9d0(%rsp,%rax)
movdqa	%xmm2, 0x9e0(%rsp,%rax)
movdqa	%xmm3, 0x9f0(%rsp,%rax)
leaq	0x40(%rax), %r12
addq	$0x9e0, %rax
cmpq	%r9, %rax
movq	%r12, %rax
jb	Lcrc32_chorba_c__1b70
Lcrc32_chorba_c__1ceb:
pxor	%xmm5, %xmm5
movdqa	%xmm5, 0x30(%rsp)
movdqa	%xmm5, 0x20(%rsp)
movdqa	%xmm5, 0x10(%rsp)
movdqa	%xmm5, (%rsp)
movq	$0x0, 0x40(%rsp)
leaq	0x48(%r12), %rax
xorl	%r15d, %r15d
cmpq	%r9, %rax
jae	Lcrc32_chorba_c__1e8c
xorl	%ebx, %ebx
movq	%r12, %rax
xorl	%ebp, %ebp
xorl	%ecx, %ecx
nopl	(%rax)
Lcrc32_chorba_c__1d30:
movdqu	(%r14,%rax), %xmm1
pxor	%xmm5, %xmm1
movdqu	0x10(%r14,%rax), %xmm2
movdqu	0x60(%rsp,%rax), %xmm0
pxor	%xmm1, %xmm0
movdqu	0x70(%rsp,%rax), %xmm1
movq	%xmm0, %rdx
movq	%rdx, %rsi
shrq	$0x2f, %rsi
movq	%rdx, %rdi
shrq	$0x9, %rdi
xorq	%rbp, %rdi
shlq	$0x13, %rdx
xorq	%rsi, %rdx
xorq	%rdi, %rdx
movdqa	%xmm0, %xmm3
psllq	$0x11, %xmm3
movdqa	%xmm0, %xmm4
psllq	$0x37, %xmm4
pxor	%xmm2, %xmm4
pxor	%xmm3, %xmm4
pxor	%xmm1, %xmm4
movdqa	%xmm0, %xmm2
psrlq	$0x2d, %xmm2
movdqa	%xmm0, %xmm1
psllq	$0x2c, %xmm1
por	%xmm2, %xmm1
pshufd	$0xee, %xmm0, %xmm2
movq	%xmm2, %rsi
shrq	$0x14, %rsi
movq	%rdx, %xmm3
movq	%rbx, %xmm2
punpcklqdq	%xmm3, %xmm2
pxor	%xmm4, %xmm2
movdqa	%xmm0, %xmm3
shufps	$0x4e, %xmm2, %xmm3
movaps	%xmm3, %xmm5
psrlq	$0x2f, %xmm5
movaps	%xmm3, %xmm4
psrlq	$0x9, %xmm4
psllq	$0x13, %xmm3
pxor	%xmm5, %xmm3
movq	%xmm2, %rdx
movq	%rdx, %rdi
shrq	$0x2d, %rdi
movq	%rdx, %r8
shlq	$0x2c, %r8
orq	%rdi, %r8
xorq	%rsi, %r8
shrq	$0x14, %rdx
movdqa	%xmm2, %xmm5
psllq	$0x11, %xmm5
pshufd	$0xee, %xmm2, %xmm6
psllq	$0x37, %xmm2
pxor	%xmm5, %xmm2
movq	%xmm6, %r13
movq	%r13, %rsi
shrq	$0x2f, %rsi
movq	%r13, %rdi
shrq	$0x9, %rdi
xorq	%rsi, %rdi
xorq	%r8, %rdi
movq	%r13, %rbx
shlq	$0x13, %rbx
xorq	%rdi, %rbx
movq	%r13, %rsi
shrq	$0x2d, %rsi
movq	%r13, %rbp
shlq	$0x2c, %rbp
orq	%rsi, %rbp
xorq	%rdx, %rbp
shrq	$0x14, %r13
psrlq	$0x14, %xmm0
movq	%rcx, %xmm5
punpcklqdq	%xmm0, %xmm5
pxor	%xmm1, %xmm5
pxor	%xmm4, %xmm5
pxor	%xmm3, %xmm5
pxor	%xmm2, %xmm5
leaq	0x20(%rax), %r12
addq	$0x68, %rax
movq	%r13, %rcx
cmpq	%r9, %rax
movq	%r12, %rax
jb	Lcrc32_chorba_c__1d30
jmp	Lcrc32_chorba_c__1e93
Lcrc32_chorba_c__1e8c:
xorl	%r13d, %r13d
xorl	%ebp, %ebp
xorl	%ebx, %ebx
Lcrc32_chorba_c__1e93:
movdqa	%xmm5, 0x50(%rsp)
addq	%r12, %r14
movq	%r9, %rdx
subq	%r12, %rdx
movq	%rsp, %rdi
movq	%r14, %rsi
movq	%r9, %r14
callq	memcpy
xorq	%rbx, 0x10(%rsp)
xorq	%rbp, 0x18(%rsp)
xorq	%r13, 0x20(%rsp)
movq	%r14, %rax
movaps	0x50(%rsp), %xmm0
xorps	(%rsp), %xmm0
movaps	%xmm0, (%rsp)
subq	%r12, %rax
je	Lcrc32_chorba_c__1f73
leaq	0x1(%r12), %rcx
cmpq	%rcx, %r14
jne	Lcrc32_chorba_c__1ee9
xorl	%ecx, %ecx
xorl	%r15d, %r15d
jmp	Lcrc32_chorba_c__1f4b
Lcrc32_chorba_c__1ee9:
movq	%rax, %rdx
andq	$-0x2, %rdx
leaq	(%rsp,%rcx), %rsi
addq	$0x60, %rsi
xorl	%ecx, %ecx
leaq	crc32_chorba_c__crc_table(%rip), %rdi
xorl	%r15d, %r15d
nopw	%cs:(%rax,%rax)
Lcrc32_chorba_c__1f10:
movzbl	(%rsp,%rcx), %r8d
xorb	%r15b, %r8b
xorb	-0x1(%rsi,%rcx), %r8b
movzbl	%r8b, %r8d
shrl	$0x8, %r15d
xorl	(%rdi,%r8,4), %r15d
movzbl	0x1(%rsp,%rcx), %r8d
xorb	%r15b, %r8b
xorb	(%rsi,%rcx), %r8b
movzbl	%r8b, %r8d
shrl	$0x8, %r15d
xorl	(%rdi,%r8,4), %r15d
addq	$0x2, %rcx
cmpq	%rcx, %rdx
jne	Lcrc32_chorba_c__1f10
Lcrc32_chorba_c__1f4b:
testb	$0x1, %al
je	Lcrc32_chorba_c__1f73
leaq	(%rsp,%r12), %rax
addq	$0x60, %rax
movzbl	(%rsp,%rcx), %edx
xorb	%r15b, %dl
xorb	(%rax,%rcx), %dl
movzbl	%dl, %eax
leaq	crc32_chorba_c__crc_table(%rip), %rcx
shrl	$0x8, %r15d
xorl	(%rcx,%rax,4), %r15d
Lcrc32_chorba_c__1f73:
movl	%r15d, %eax
addq	$0x8068, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
nopl	(%rax,%rax)
crc32_chorba_small_nondestructive:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0xd8, %rsp
xorps	%xmm0, %xmm0
movaps	%xmm0, 0xc0(%rsp)
movaps	%xmm0, 0xb0(%rsp)
movaps	%xmm0, 0xa0(%rsp)
movaps	%xmm0, 0x90(%rsp)
movq	$0x0, 0xd0(%rsp)
movl	%edi, %r14d
movq	%rdx, 0x80(%rsp)
cmpq	$0x169, %rdx
jb	Lcrc32_chorba_c__2df2
xorl	%r12d, %r12d
xorl	%r9d, %r9d
xorl	%r13d, %r13d
xorl	%edx, %edx
xorl	%ecx, %ecx
movq	%rsi, 0x8(%rsp)
nopw	(%rax,%rax)
Lcrc32_chorba_c__2000:
movq	%rsi, %rbp
xorq	(%rsi,%rcx), %r14
xorq	0x8(%rsi,%rcx), %r12
xorq	0x10(%rsi,%rcx), %r9
xorq	0x18(%rsi,%rcx), %r13
movq	%r13, 0x10(%rsp)
xorq	0x20(%rsi,%rcx), %rdx
movq	0x28(%rsi,%rcx), %rax
movq	%rax, 0x28(%rsp)
movq	0x40(%rsi,%rcx), %rsi
xorq	%r9, %rsi
movq	%rdx, %rbx
movq	%rdx, 0x58(%rsp)
movq	0x48(%rbp,%rcx), %rdx
xorq	%r14, %rdx
xorq	%r13, %rdx
movq	%rsi, %rax
shlq	$0x11, %rax
movq	%rsi, %r8
shlq	$0x37, %r8
xorq	%rax, %r8
movq	%rsi, %rax
shrq	$0x2f, %rax
movq	%rcx, %r13
movq	%rsi, %rcx
shrq	$0x9, %rcx
xorq	%rax, %rcx
movq	%r9, %r15
movq	%r9, 0x20(%rsp)
movq	%rsi, %r9
shlq	$0x13, %r9
xorq	%rcx, %r9
movq	%rsi, %rax
shrq	$0x2d, %rax
movq	%rsi, %rdi
shlq	$0x2c, %rdi
orq	%rax, %rdi
shrq	$0x14, %rsi
movq	%rdx, %rax
shlq	$0x11, %rax
movq	%rdx, %rcx
shlq	$0x37, %rcx
xorq	%rax, %rcx
movq	%rdx, %r10
shrq	$0x2f, %r10
movq	%rdx, %r11
shrq	$0x9, %r11
xorq	%rdi, %r11
movq	%rdx, %rax
shlq	$0x13, %rax
xorq	%r10, %rax
xorq	%r11, %rax
movq	%rdx, %r10
shrq	$0x2d, %r10
movq	%rdx, %rdi
shlq	$0x2c, %rdi
orq	%r10, %rdi
xorq	%rsi, %rdi
xorq	0x50(%rbp,%r13), %r8
movq	%r14, %r11
xorq	%rbx, %r11
movq	%r11, 0x78(%rsp)
xorq	%r12, %r11
xorq	%r8, %r11
xorq	0x58(%rbp,%r13), %r9
xorq	%r12, %rcx
xorq	%r15, %rcx
xorq	0x28(%rsp), %rcx
xorq	%r9, %rcx
movq	%r11, %rsi
shrq	$0x2f, %rsi
movq	%r11, %r10
shlq	$0x13, %r10
xorq	%rsi, %r10
movq	%r11, %rsi
shrq	$0x2d, %rsi
movq	%r11, %r8
shlq	$0x2c, %r8
orq	%rsi, %r8
movq	%r8, 0x38(%rsp)
movq	%rcx, %rsi
shlq	$0x11, %rsi
movq	%r14, %r8
movq	%r14, 0x48(%rsp)
movq	%rcx, %r14
shlq	$0x37, %r14
xorq	%rsi, %r14
movq	%rcx, %rsi
shrq	$0x2f, %rsi
movq	%rcx, %r9
shrq	$0x9, %r9
xorq	%rsi, %r9
movq	%r9, 0x88(%rsp)
movq	%rcx, %rsi
shrq	$0x2d, %rsi
movq	%rcx, %rbx
shlq	$0x2c, %rbx
orq	%rsi, %rbx
movq	%r11, %rsi
shlq	$0x37, %rsi
xorq	0x60(%rbp,%r13), %rax
xorq	%rsi, %rax
movq	%r11, %r15
shlq	$0x11, %r15
xorq	0x20(%rsp), %r15
xorq	%rax, %r15
movq	0x30(%rbp,%r13), %rax
movq	%rax, 0x40(%rsp)
xorq	%r8, %rax
movq	%rax, 0x30(%rsp)
movq	0x10(%rsp), %r9
movq	%r9, %rsi
xorq	%rax, %rsi
xorq	%r15, %rsi
movq	%r11, %rax
shrq	$0x9, %rax
movq	%r13, 0x18(%rsp)
xorq	0x68(%rbp,%r13), %rdi
xorq	%rax, %rdi
xorq	%r10, %rdi
xorq	%r14, %rdi
movq	0x38(%rbp,%r13), %r8
movq	%r8, 0x68(%rsp)
xorq	%r12, %r8
movq	%r8, 0x50(%rsp)
movq	0x58(%rsp), %rbp
xorq	%rbp, %r9
movq	%r9, 0x70(%rsp)
movq	%r9, %rax
xorq	%r8, %rax
xorq	%rdi, %rax
movq	%rsi, %r15
shrq	$0x9, %r15
xorq	%rbx, %r15
movq	%rsi, %rdi
shrq	$0x2f, %rdi
movq	%rsi, %rbx
shlq	$0x13, %rbx
xorq	%rdi, %rbx
movq	%rsi, %rdi
shrq	$0x2d, %rdi
movq	%rsi, %r13
shlq	$0x2c, %r13
orq	%rdi, %r13
movq	%rax, %r10
shlq	$0x37, %r10
xorq	%rbx, %r10
movq	%rax, %rdi
shrq	$0x9, %rdi
xorq	%r13, %rdi
movq	%rdi, 0x60(%rsp)
movq	%rax, %rdi
shrq	$0x2f, %rdi
movq	%rax, %r14
shlq	$0x13, %r14
xorq	%rdi, %r14
shrq	$0x14, %rdx
movq	%rax, %r13
shrq	$0x2d, %r13
movq	%rax, %rbx
shlq	$0x2c, %rbx
movq	0x8(%rsp), %r8
movq	0x18(%rsp), %rdi
xorq	0x70(%r8,%rdi), %rdx
orq	%r13, %rbx
xorq	0x38(%rsp), %rdx
xorq	0x88(%rsp), %rdx
movq	%rcx, %r8
shlq	$0x13, %r8
xorq	%r8, %rdx
movq	%rsi, %r8
shlq	$0x37, %r8
xorq	%r8, %rdx
movq	%rsi, %r8
shlq	$0x11, %r8
movq	0x28(%rsp), %r9
xorq	%r9, %r8
xorq	%rdx, %r8
shrq	$0x14, %r11
movq	0x8(%rsp), %rdx
xorq	0x78(%rdx,%rdi), %r11
xorq	%r15, %r11
xorq	%r10, %r11
movq	%rax, %r15
shlq	$0x11, %r15
xorq	%r9, %r15
xorq	0x30(%rsp), %r15
xorq	%r11, %r15
xorq	%rbp, %r8
movq	%r8, %r9
shrq	$0x9, %r9
xorq	%rbx, %r9
movq	%r8, %rdx
shrq	$0x2f, %rdx
movq	%r8, %r10
shlq	$0x13, %r10
xorq	%rdx, %r10
movq	%r8, %rdx
shrq	$0x2d, %rdx
movq	%r8, %r11
shlq	$0x2c, %r11
orq	%rdx, %r11
movq	%r15, %rdi
shlq	$0x37, %rdi
xorq	%r10, %rdi
movq	%r15, %r10
shrq	$0x9, %r10
xorq	%r11, %r10
movq	%r15, %rdx
shrq	$0x2f, %rdx
movq	%r15, %r11
shlq	$0x13, %r11
xorq	%rdx, %r11
movq	%r15, %rdx
shrq	$0x2d, %rdx
movq	%r15, %r13
shlq	$0x2c, %r13
orq	%rdx, %r13
shrq	$0x14, %rcx
movq	0x8(%rsp), %rdx
movq	0x18(%rsp), %rbp
xorq	0x80(%rdx,%rbp), %rcx
xorq	0x60(%rsp), %rcx
xorq	%r14, %rcx
movq	%r8, %rdx
shlq	$0x37, %rdx
xorq	%rdx, %rcx
movq	%r8, %rdx
shlq	$0x11, %rdx
xorq	0x40(%rsp), %rdx
xorq	%rcx, %rdx
shrq	$0x14, %rsi
movq	0x8(%rsp), %rcx
xorq	0x88(%rcx,%rbp), %rsi
xorq	%r9, %rsi
xorq	%rdi, %rsi
movq	%r15, %r14
shlq	$0x11, %r14
xorq	0x68(%rsp), %r14
xorq	%rsi, %r14
xorq	0x50(%rsp), %rdx
movq	%rdx, %rcx
shrq	$0x9, %rcx
xorq	%r13, %rcx
movq	%rdx, %rsi
shrq	$0x2f, %rsi
movq	%rdx, %rdi
shlq	$0x13, %rdi
xorq	%rsi, %rdi
movq	%rdx, %rsi
shrq	$0x2d, %rsi
movq	%rdx, %r9
shlq	$0x2c, %r9
orq	%rsi, %r9
movq	%r14, %rbx
shlq	$0x37, %rbx
xorq	%rdi, %rbx
movq	%r14, %rdi
shrq	$0x2f, %rdi
movq	%r14, %rsi
shrq	$0x9, %rsi
xorq	%rdi, %rsi
movq	%rsi, 0x40(%rsp)
movq	%r14, %rdi
shlq	$0x13, %rdi
xorq	%r9, %rdi
movq	%r14, %r13
shrq	$0x2d, %r13
movq	%r14, %r9
shlq	$0x2c, %r9
orq	%r13, %r9
shrq	$0x14, %rax
movq	0x8(%rsp), %rsi
xorq	0x90(%rsi,%rbp), %rax
xorq	%r10, %rax
xorq	%r11, %rax
movq	%rdx, %r10
shlq	$0x37, %r10
xorq	%r10, %rax
movq	%rdx, %r11
shlq	$0x11, %r11
xorq	0x20(%rsp), %r11
xorq	%rax, %r11
shrq	$0x14, %r8
movq	0x8(%rsp), %rax
xorq	0x98(%rax,%rbp), %r8
xorq	%rcx, %r8
xorq	%rbx, %r8
movq	%r14, %r13
shlq	$0x11, %r13
xorq	0x10(%rsp), %r13
xorq	%r8, %r13
movq	%r11, %rax
shlq	$0x11, %rax
movq	%r11, %r8
shlq	$0x37, %r8
xorq	%rax, %r8
movq	%r11, %rax
shrq	$0x9, %rax
xorq	%r9, %rax
movq	%r11, %r9
shrq	$0x2f, %r9
xorq	%r9, %rax
movq	%r11, %r9
shrq	$0x2d, %r9
movq	%r11, %r10
shlq	$0x2c, %r10
orq	%r9, %r10
movq	%r11, %r9
shlq	$0x13, %r9
movq	%r13, %rsi
shlq	$0x37, %rsi
xorq	%r9, %rsi
movq	%r13, %rcx
shrq	$0x9, %rcx
xorq	%r10, %rcx
movq	%rcx, 0x38(%rsp)
movq	%r13, %rbx
shrq	$0x2f, %rbx
movq	%r13, %r9
shlq	$0x13, %r9
xorq	%rbx, %r9
movq	%r13, %rcx
shrq	$0x2d, %rcx
movq	%r13, %rbx
shlq	$0x2c, %rbx
orq	%rcx, %rbx
shrq	$0x14, %r15
movq	0x8(%rsp), %rcx
xorq	0xa0(%rcx,%rbp), %r15
xorq	0x40(%rsp), %r15
xorq	%rdi, %r15
xorq	%r8, %r15
shrq	$0x14, %rdx
movq	0x8(%rsp), %rcx
xorq	0xa8(%rcx,%rbp), %rdx
xorq	0x78(%rsp), %r15
xorq	%rax, %rdx
xorq	%rsi, %rdx
movq	%r13, %rax
shlq	$0x11, %rax
movq	0x48(%rsp), %rbp
xorq	%rbp, %rax
xorq	%r12, %rax
xorq	%rdx, %rax
movq	%r15, %rcx
shlq	$0x11, %rcx
movq	%r15, %rdx
shlq	$0x37, %rdx
xorq	%rcx, %rdx
movq	%r15, %r10
shrq	$0x9, %r10
xorq	%rbx, %r10
movq	%r15, %rcx
shrq	$0x2f, %rcx
movq	%r15, %rdi
shlq	$0x13, %rdi
xorq	%rcx, %rdi
movq	%r15, %rcx
shrq	$0x2d, %rcx
movq	%r15, %rsi
shlq	$0x2c, %rsi
orq	%rcx, %rsi
movq	%rsi, 0x68(%rsp)
xorq	0x28(%rsp), %rax
movq	%rax, %rcx
shrq	$0x2f, %rcx
movq	%rax, %rbx
shrq	$0x9, %rbx
xorq	%rcx, %rbx
movq	%rax, %rcx
shrq	$0x2d, %rcx
movq	%rax, %r8
shlq	$0x2c, %r8
orq	%rcx, %r8
shrq	$0x14, %r14
movq	0x8(%rsp), %rcx
movq	0x18(%rsp), %rsi
xorq	0xb0(%rcx,%rsi), %r14
xorq	0x38(%rsp), %r14
xorq	%r9, %r14
xorq	%rdx, %r14
shrq	$0x14, %r11
movq	%rbp, %rdx
xorq	%r12, %rdx
movq	%rdx, 0x40(%rsp)
movq	0x20(%rsp), %r9
xorq	%r9, %rdx
movq	%rdx, 0x78(%rsp)
xorq	0x30(%rsp), %rdx
movq	0x8(%rsp), %rcx
xorq	0xb8(%rcx,%rsi), %r11
xorq	%r14, %rdx
xorq	%r10, %r11
xorq	%rdi, %r11
movq	%rax, %rcx
shlq	$0x37, %rcx
xorq	%rcx, %r11
movq	%rax, %rcx
shlq	$0x11, %rcx
xorq	%r12, %rcx
xorq	%r11, %rcx
movq	%r9, %r10
xorq	0x10(%rsp), %r10
movq	%r10, %r9
xorq	0x50(%rsp), %r9
xorq	%rcx, %r9
movq	%rax, %rcx
shlq	$0x13, %rcx
movq	%rdx, %r11
shlq	$0x37, %r11
xorq	%rcx, %r11
movq	%rdx, %rbp
shrq	$0x9, %rbp
xorq	%r8, %rbp
movq	%rdx, %rcx
shrq	$0x2f, %rcx
movq	%rdx, %rdi
shlq	$0x13, %rdi
xorq	%rcx, %rdi
movq	%rdx, %rcx
shrq	$0x2d, %rcx
movq	%rdx, %r8
shlq	$0x2c, %r8
orq	%rcx, %r8
movq	%r9, %rcx
shrq	$0x9, %rcx
xorq	%r8, %rcx
movq	%rcx, 0x60(%rsp)
movq	%r9, %rcx
shrq	$0x2f, %rcx
movq	%r9, %rsi
shlq	$0x13, %rsi
xorq	%rcx, %rsi
movq	%rsi, 0x88(%rsp)
shrq	$0x14, %r13
movq	%r9, %rcx
shrq	$0x2d, %rcx
movq	%r9, %r8
shlq	$0x2c, %r8
movq	0x8(%rsp), %r14
movq	0x18(%rsp), %rsi
xorq	0xc0(%r14,%rsi), %r13
orq	%rcx, %r8
movq	%r8, 0x38(%rsp)
xorq	0x68(%rsp), %r13
xorq	%rbx, %r13
xorq	%r11, %r13
movq	%rdx, %r11
shlq	$0x11, %r11
movq	0x48(%rsp), %r8
xorq	%r8, %r11
xorq	0x20(%rsp), %r11
xorq	%r13, %r11
shrq	$0x14, %r15
movq	0x8(%rsp), %rcx
xorq	0xc8(%rcx,%rsi), %r15
xorq	0x70(%rsp), %r11
xorq	%rbp, %r15
xorq	%rdi, %r15
movq	%r9, %rcx
shlq	$0x37, %rcx
xorq	%rcx, %r15
movq	%r9, %rcx
shlq	$0x11, %rcx
xorq	%r8, %rcx
xorq	%r15, %rcx
movq	%r12, %rbx
xorq	0x10(%rsp), %rbx
xorq	0x28(%rsp), %rbx
movq	0x58(%rsp), %r8
xorq	%r8, %rbx
xorq	%rcx, %rbx
movq	%r11, %rcx
shlq	$0x11, %rcx
movq	%r11, %r15
shlq	$0x37, %r15
xorq	%rcx, %r15
movq	%r11, %rcx
shrq	$0x2f, %rcx
movq	%r11, %rsi
shrq	$0x9, %rsi
xorq	%rcx, %rsi
movq	%r11, %rcx
shrq	$0x2d, %rcx
movq	%r11, %rdi
shlq	$0x2c, %rdi
orq	%rcx, %rdi
movq	%rbx, %r13
shlq	$0x11, %r13
movq	%rbx, %rcx
shlq	$0x37, %rcx
xorq	%r13, %rcx
movq	%rbx, %r14
shrq	$0x9, %r14
xorq	%rdi, %r14
movq	%r14, 0x70(%rsp)
movq	%rbx, %rdi
shrq	$0x2f, %rdi
movq	%rbx, %r14
shlq	$0x13, %r14
xorq	%rdi, %r14
movq	%r14, 0x68(%rsp)
movq	%rbx, %r13
shrq	$0x2d, %r13
movq	%rbx, %rdi
shlq	$0x2c, %rdi
orq	%r13, %rdi
shrq	$0x14, %rax
movq	0x8(%rsp), %r14
movq	0x18(%rsp), %r13
xorq	0xd0(%r14,%r13), %rax
xorq	0x60(%rsp), %rax
xorq	0x88(%rsp), %rax
xorq	%r15, %rax
movq	0x20(%rsp), %rbp
xorq	%rbp, %r12
movq	%r12, 0x60(%rsp)
movq	%r12, %r15
movq	0x28(%rsp), %r14
xorq	%r14, %r15
xorq	%r8, %r15
movq	0x30(%rsp), %r8
xorq	%r8, %r15
xorq	%rax, %r15
shrq	$0x14, %rdx
movq	0x8(%rsp), %rax
xorq	0xd8(%rax,%r13), %rdx
xorq	0x38(%rsp), %rdx
xorq	%rsi, %rdx
movq	%r11, %rax
shlq	$0x13, %rax
xorq	%rax, %rdx
xorq	%rcx, %rdx
xorq	0x48(%rsp), %rbp
xorq	0x10(%rsp), %rbp
xorq	%r14, %rbp
xorq	%r8, %rbp
movq	%rbp, 0x20(%rsp)
movq	%rbp, %r8
xorq	0x50(%rsp), %r8
xorq	%rdx, %r8
movq	%r15, %rax
shlq	$0x11, %rax
movq	%r15, %r14
shlq	$0x37, %r14
xorq	%rax, %r14
movq	%r15, %rbp
shrq	$0x9, %rbp
xorq	%rdi, %rbp
movq	%r15, %rax
shrq	$0x2f, %rax
movq	%r15, %rsi
shlq	$0x13, %rsi
xorq	%rax, %rsi
movq	%r15, %rax
shrq	$0x2d, %rax
movq	%r15, %rdi
shlq	$0x2c, %rdi
orq	%rax, %rdi
movq	%r8, %rax
shlq	$0x11, %rax
movq	%r8, %rcx
shlq	$0x37, %rcx
xorq	%rax, %rcx
movq	%r8, %rax
shrq	$0x9, %rax
xorq	%rdi, %rax
movq	%rax, 0x48(%rsp)
movq	%r8, %rax
shrq	$0x2f, %rax
movq	%r8, %rdx
shlq	$0x13, %rdx
xorq	%rax, %rdx
movq	%rdx, 0x38(%rsp)
movq	%r8, %r13
shrq	$0x2d, %r13
movq	%r8, %rax
shlq	$0x2c, %rax
orq	%r13, %rax
shrq	$0x14, %r9
movq	0x8(%rsp), %rdx
movq	0x18(%rsp), %rdi
xorq	0xe0(%rdx,%rdi), %r9
xorq	0x70(%rsp), %r9
xorq	0x68(%rsp), %r9
shrq	$0x14, %r11
movq	0x8(%rsp), %rdx
xorq	0xe8(%rdx,%rdi), %r11
xorq	%r14, %r9
xorq	%rbp, %r11
xorq	%rsi, %r11
xorq	%rcx, %r11
movq	%r12, %rcx
movq	0x58(%rsp), %rdx
xorq	%rdx, %rcx
xorq	0x28(%rsp), %rcx
movq	0x50(%rsp), %rsi
xorq	%rsi, %rcx
xorq	%r11, %rcx
movq	0x40(%rsp), %rdi
xorq	0x10(%rsp), %rdi
xorq	%rdx, %rdi
xorq	0x30(%rsp), %rdi
xorq	%rsi, %rdi
movq	%rdi, 0x40(%rsp)
xorq	%rdi, %r9
movq	%r9, %rsi
shlq	$0x11, %rsi
movq	%r9, %rdx
shlq	$0x37, %rdx
xorq	%rsi, %rdx
movq	%r9, %rsi
shrq	$0x9, %rsi
xorq	%rax, %rsi
movq	%r9, %rax
shrq	$0x2f, %rax
movq	%r9, %rbp
shlq	$0x13, %rbp
xorq	%rax, %rbp
movq	%r9, %rax
shrq	$0x2d, %rax
movq	%r9, %r14
shlq	$0x2c, %r14
orq	%rax, %r14
movq	%rcx, %rax
shlq	$0x11, %rax
movq	%rcx, %r13
shlq	$0x37, %r13
xorq	%rax, %r13
movq	%rcx, %rax
shrq	$0x2f, %rax
movq	%rcx, %rdi
shrq	$0x9, %rdi
xorq	%rax, %rdi
movq	%rdi, 0x70(%rsp)
movq	%rcx, %r11
shlq	$0x13, %r11
xorq	%r14, %r11
shrq	$0x14, %rbx
movq	%rcx, %r14
shrq	$0x2d, %r14
movq	%rcx, %rax
shlq	$0x2c, %rax
movq	0x8(%rsp), %rdi
movq	0x18(%rsp), %r12
xorq	0xf0(%rdi,%r12), %rbx
orq	%r14, %rax
xorq	0x48(%rsp), %rbx
xorq	0x38(%rsp), %rbx
xorq	%rdx, %rbx
xorq	0x20(%rsp), %rbx
shrq	$0x14, %r15
movq	0x8(%rsp), %rdx
xorq	0xf8(%rdx,%r12), %r15
xorq	%rsi, %r15
xorq	%rbp, %r15
xorq	%r13, %r15
xorq	0x40(%rsp), %r15
movq	%rbx, %rdx
shlq	$0x11, %rdx
movq	%rbx, %r13
shlq	$0x37, %r13
xorq	%rdx, %r13
movq	%rbx, %rsi
shrq	$0x9, %rsi
xorq	%rax, %rsi
movq	%rbx, %rax
shrq	$0x2f, %rax
movq	%rbx, %rdi
shlq	$0x13, %rdi
xorq	%rax, %rdi
movq	%rbx, %rax
shrq	$0x2d, %rax
movq	%rbx, %r14
shlq	$0x2c, %r14
orq	%rax, %r14
movq	%r15, %rax
shlq	$0x11, %rax
movq	%r15, %rdx
shlq	$0x37, %rdx
xorq	%rax, %rdx
movq	%r15, %rax
shrq	$0x9, %rax
xorq	%r14, %rax
movq	%rax, 0x20(%rsp)
movq	%r15, %rax
shrq	$0x2f, %rax
movq	%r15, %r14
shlq	$0x13, %r14
xorq	%rax, %r14
movq	%r14, 0x48(%rsp)
movq	%r15, %rax
shrq	$0x2d, %rax
movq	%r15, %rbp
shlq	$0x2c, %rbp
orq	%rax, %rbp
shrq	$0x14, %r8
movq	0x8(%rsp), %rax
xorq	0x100(%rax,%r12), %r8
xorq	0x70(%rsp), %r8
xorq	%r11, %r8
xorq	%r13, %r8
shrq	$0x14, %r9
movq	0x28(%rsp), %rax
movq	0x78(%rsp), %r13
xorq	%rax, %r13
xorq	0x58(%rsp), %r13
xorq	0x50(%rsp), %r13
movq	0x8(%rsp), %r11
xorq	0x108(%r11,%r12), %r9
xorq	%r8, %r13
xorq	%rsi, %r9
xorq	%rdi, %r9
xorq	%rdx, %r9
movq	0x60(%rsp), %r12
xorq	0x10(%rsp), %r12
xorq	%rax, %r12
xorq	0x30(%rsp), %r12
xorq	%r9, %r12
movq	%r13, %rax
shlq	$0x11, %rax
movq	%r13, %r11
shlq	$0x37, %r11
xorq	%rax, %r11
movq	%r13, %rax
shrq	$0x9, %rax
xorq	%rbp, %rax
movq	%r13, %rdx
shrq	$0x2f, %rdx
movq	%r13, %rsi
shlq	$0x13, %rsi
xorq	%rdx, %rsi
movq	%r13, %rdx
movq	%r13, %r9
movq	%r13, 0x78(%rsp)
shrq	$0x2d, %rdx
shlq	$0x2c, %r9
orq	%rdx, %r9
movq	%r12, %rdi
shlq	$0x11, %rdi
movq	%r12, %rdx
shlq	$0x37, %rdx
xorq	%rdi, %rdx
movq	%r12, %r8
shrq	$0x2f, %r8
movq	%r12, %rdi
shrq	$0x9, %rdi
xorq	%r8, %rdi
movq	%r12, %r8
shlq	$0x13, %r8
xorq	%r9, %r8
movq	%r12, %r9
shrq	$0x2d, %r9
movq	%r12, %r14
shlq	$0x2c, %r14
orq	%r9, %r14
shrq	$0x14, %rcx
movq	0x18(%rsp), %r9
movq	0x8(%rsp), %r13
xorq	0x110(%r13,%r9), %rcx
xorq	0x20(%rsp), %rcx
xorq	0x48(%rsp), %rcx
xorq	%r11, %rcx
shrq	$0x14, %rbx
movq	0x58(%rsp), %rbp
xorq	%rbp, %r10
xorq	0x30(%rsp), %r10
movq	0x50(%rsp), %r11
xorq	%r11, %r10
xorq	0x118(%r13,%r9), %rbx
xorq	%rcx, %r10
xorq	%rax, %rbx
xorq	%rsi, %rbx
xorq	%rdx, %rbx
movq	0x10(%rsp), %rsi
xorq	0x28(%rsp), %rsi
xorq	%rbp, %rsi
xorq	%r11, %rsi
xorq	%rbx, %rsi
movq	%r10, %rax
shlq	$0x11, %rax
movq	%r10, %r9
shlq	$0x37, %r9
xorq	%rax, %r9
movq	%r10, %rdx
shrq	$0x9, %rdx
xorq	%r14, %rdx
movq	%r10, %rax
shrq	$0x2f, %rax
movq	%r10, %rbp
shlq	$0x13, %rbp
xorq	%rax, %rbp
movq	%r10, %rax
shrq	$0x2d, %rax
movq	%r10, %rcx
shlq	$0x2c, %rcx
orq	%rax, %rcx
movq	%rsi, %rax
shlq	$0x11, %rax
movq	%rsi, %rbx
shlq	$0x37, %rbx
xorq	%rax, %rbx
movq	%rsi, %rax
shrq	$0x9, %rax
xorq	%rcx, %rax
movq	%rax, 0x10(%rsp)
movq	%rsi, %r11
shrq	$0x2f, %r11
movq	%rsi, %rcx
shlq	$0x13, %rcx
xorq	%r11, %rcx
movq	%rsi, %r14
shrq	$0x2d, %r14
movq	%rsi, %r11
shlq	$0x2c, %r11
orq	%r14, %r11
shrq	$0x14, %r15
movq	0x18(%rsp), %r14
xorq	0x120(%r13,%r14), %r15
xorq	%rdi, %r15
xorq	%r8, %r15
xorq	%r9, %r15
movq	0x58(%rsp), %r9
movq	0x28(%rsp), %r8
xorq	%r8, %r9
movq	0x30(%rsp), %rax
xorq	%rax, %r9
xorq	%r15, %r9
movq	0x78(%rsp), %rdi
shrq	$0x14, %rdi
xorq	0x128(%r13,%r14), %rdi
xorq	%rdx, %rdi
xorq	%rbp, %rdi
xorq	%rbx, %rdi
movq	%r8, %rbp
xorq	%rax, %rbp
movq	0x50(%rsp), %r13
xorq	%r13, %rbp
xorq	%rdi, %rbp
movq	%r9, %rdx
shlq	$0x11, %rdx
movq	%r9, %rdi
shlq	$0x37, %rdi
xorq	%rdx, %rdi
movq	%r9, %r8
shrq	$0x2f, %r8
movq	%r9, %rdx
shrq	$0x9, %rdx
xorq	%r11, %rdx
movq	%r9, %r15
shlq	$0x13, %r15
xorq	%r8, %r15
movq	%r9, %r8
shrq	$0x2d, %r8
movq	%r9, %r11
movq	%r9, %rax
shlq	$0x2c, %r11
orq	%r8, %r11
movq	%rbp, %r9
shlq	$0x11, %r9
movq	%rbp, %r8
shlq	$0x37, %r8
xorq	%r9, %r8
shrq	$0x14, %rsi
movq	%rbp, %rbx
shrq	$0x9, %rbx
xorq	%rsi, %rbx
movq	%rbp, %r14
shrq	$0x2f, %r14
movq	%rbp, %r9
shlq	$0x13, %r9
xorq	%r14, %r9
xorq	%rbx, %r9
xorq	%r11, %r9
movq	%rbp, %rbx
shrq	$0x2d, %rbx
movq	%rbp, %r11
shlq	$0x2c, %r11
orq	%rbx, %r11
shrq	$0x14, %rax
xorq	%rax, %r11
shrq	$0x14, %r12
movq	0x18(%rsp), %rbx
movq	0x8(%rsp), %rax
xorq	0x130(%rax,%rbx), %r12
xorq	0x10(%rsp), %r12
xorq	%rcx, %r12
xorq	%rdi, %r12
movq	0x30(%rsp), %rdi
xorq	%r13, %rdi
xorq	%r12, %rdi
shrq	$0x14, %r10
movq	%rax, %rsi
xorq	0x138(%rax,%rbx), %r10
xorq	%rdx, %r10
xorq	%r15, %r10
shrq	$0x14, %rbp
xorq	%r8, %r10
xorq	%r13, %r10
movq	%rdi, %rax
shlq	$0x11, %rax
movq	%rdi, %r14
shlq	$0x37, %r14
xorq	%rax, %r14
xorq	%r9, %r14
movq	%rdi, %rax
shrq	$0x2f, %rax
movq	%rdi, %rcx
shrq	$0x9, %rcx
xorq	%r11, %rcx
movq	%rdi, %rdx
shlq	$0x13, %rdx
xorq	%rax, %rdx
xorq	%rcx, %rdx
movq	%rdi, %rax
shrq	$0x2d, %rax
movq	%rdi, %rcx
shlq	$0x2c, %rcx
orq	%rax, %rcx
xorq	%rbp, %rcx
shrq	$0x14, %rdi
movq	%r10, %rax
shlq	$0x11, %rax
movq	%r10, %r12
shlq	$0x37, %r12
xorq	%rdx, %r12
xorq	%rax, %r12
movq	%r10, %rax
shrq	$0x2f, %rax
movq	%r10, %rdx
shrq	$0x9, %rdx
xorq	%rcx, %rdx
movq	%r10, %r9
shlq	$0x13, %r9
xorq	%rax, %r9
xorq	%rdx, %r9
movq	%r10, %rax
shrq	$0x2d, %rax
movq	%r10, %r13
shlq	$0x2c, %r13
orq	%rax, %r13
xorq	%rdi, %r13
shrq	$0x14, %r10
movq	%rbx, %rcx
leaq	0x140(%rbx), %rax
addq	$0x2a8, %rcx
movq	%r10, %rdx
cmpq	0x80(%rsp), %rcx
movq	%rax, %rcx
jb	Lcrc32_chorba_c__2000
jmp	Lcrc32_chorba_c__2e00
Lcrc32_chorba_c__2df2:
xorl	%eax, %eax
xorl	%r10d, %r10d
xorl	%r13d, %r13d
xorl	%r9d, %r9d
xorl	%r12d, %r12d
Lcrc32_chorba_c__2e00:
leaq	0x48(%rax), %rcx
cmpq	0x80(%rsp), %rcx
jae	Lcrc32_chorba_c__2f79
nopw	%cs:(%rax,%rax)
Lcrc32_chorba_c__2e20:
xorq	(%rsi,%rax), %r14
xorq	0x8(%rsi,%rax), %r12
movq	%r14, %rdx
shlq	$0x11, %rdx
movq	%r14, %rcx
shlq	$0x37, %rcx
xorq	%r9, %rcx
xorq	%rdx, %rcx
movq	%r14, %rdx
shrq	$0x2f, %rdx
movq	%r14, %r8
shrq	$0x9, %r8
xorq	%r13, %r8
movq	%r14, %rdi
shlq	$0x13, %rdi
xorq	%rdx, %rdi
xorq	%r8, %rdi
movq	%r14, %rdx
shrq	$0x2d, %rdx
movq	%r14, %r9
shlq	$0x2c, %r9
orq	%rdx, %r9
shrq	$0x14, %r14
movq	%r12, %rdx
shlq	$0x11, %rdx
movq	%r12, %r15
shlq	$0x37, %r15
xorq	%rdx, %r15
xorq	%rdi, %r15
movq	%r12, %rdx
shrq	$0x2f, %rdx
movq	%r12, %rdi
shrq	$0x9, %rdi
xorq	%r10, %rdi
movq	%r12, %r8
shlq	$0x13, %r8
xorq	%rdx, %r8
xorq	%rdi, %r8
xorq	%r9, %r8
movq	%r12, %rdx
shrq	$0x2d, %rdx
movq	%r12, %r9
shlq	$0x2c, %r9
orq	%rdx, %r9
xorq	%r14, %r9
xorq	0x10(%rsi,%rax), %rcx
shrq	$0x14, %r12
xorq	0x18(%rsi,%rax), %r15
movq	%rcx, %rdx
shlq	$0x11, %rdx
movq	%rcx, %r14
shlq	$0x37, %r14
xorq	%r8, %r14
xorq	%rdx, %r14
movq	%rcx, %rdx
shrq	$0x2f, %rdx
movq	%rcx, %rdi
shrq	$0x9, %rdi
xorq	%r9, %rdi
movq	%rcx, %r8
shlq	$0x13, %r8
xorq	%rdx, %r8
xorq	%rdi, %r8
movq	%rcx, %rdx
shrq	$0x2d, %rdx
movq	%rcx, %rdi
shlq	$0x2c, %rdi
orq	%rdx, %rdi
xorq	%r12, %rdi
shrq	$0x14, %rcx
movq	%r15, %rdx
shlq	$0x11, %rdx
movq	%r15, %r12
shlq	$0x37, %r12
xorq	%rdx, %r12
xorq	%r8, %r12
movq	%r15, %rdx
shrq	$0x2f, %rdx
movq	%r15, %r8
shrq	$0x9, %r8
xorq	%rdx, %r8
xorq	%rdi, %r8
movq	%r15, %r9
shlq	$0x13, %r9
xorq	%r8, %r9
movq	%r15, %rdx
shrq	$0x2d, %rdx
movq	%r15, %r13
shlq	$0x2c, %r13
orq	%rdx, %r13
xorq	%rcx, %r13
shrq	$0x14, %r15
leaq	0x20(%rax), %rcx
addq	$0x68, %rax
movq	%r15, %r10
cmpq	0x80(%rsp), %rax
movq	%rcx, %rax
jb	Lcrc32_chorba_c__2e20
jmp	Lcrc32_chorba_c__2f7f
Lcrc32_chorba_c__2f79:
movq	%rax, %rcx
movq	%r10, %r15
Lcrc32_chorba_c__2f7f:
addq	%rcx, %rsi
movq	%r14, %rbx
movq	0x80(%rsp), %r14
subq	%rcx, %r14
leaq	0x90(%rsp), %rdi
movq	%r14, %rdx
movq	%r9, %rbp
callq	memcpy
xorq	%rbx, 0x90(%rsp)
xorq	%r12, 0x98(%rsp)
xorq	%rbp, 0xa0(%rsp)
xorq	%r13, 0xa8(%rsp)
xorq	%r15, 0xb0(%rsp)
xorl	%edi, %edi
leaq	0x90(%rsp), %rsi
movq	%r14, %rdx
callq	crc32_braid_internal
addq	$0xd8, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
nop
crc32_chorba:
pushq	%r15
pushq	%r14
pushq	%rbx
notl	%edi
movl	%esi, %ebx
negl	%ebx
andl	$0x7, %ebx
leaq	0x48(%rbx), %rax
cmpq	%rax, %rdx
jbe	Lcrc32_chorba_c__3038
testq	%rbx, %rbx
je	Lcrc32_chorba_c__3025
movq	%rsi, %r14
movq	%rdx, %r15
movq	%rbx, %rdx
callq	crc32_braid_internal
movq	%r14, %rsi
movq	%r15, %rdx
movl	%eax, %edi
subq	%rbx, %rdx
Lcrc32_chorba_c__3025:
addq	%rbx, %rsi
cmpq	$0x80001, %rdx
jb	Lcrc32_chorba_c__3045
callq	crc32_chorba_118960_nondestructive
jmp	Lcrc32_chorba_c__303d
Lcrc32_chorba_c__3038:
callq	crc32_braid_internal
Lcrc32_chorba_c__303d:
notl	%eax
popq	%rbx
popq	%r14
popq	%r15
retq
Lcrc32_chorba_c__3045:
leaq	-0x2001(%rdx), %rax
cmpq	$0x5fff, %rax
ja	Lcrc32_chorba_c__305b
callq	crc32_chorba_32768_nondestructive
jmp	Lcrc32_chorba_c__303d
Lcrc32_chorba_c__305b:
callq	crc32_chorba_small_nondestructive
jmp	Lcrc32_chorba_c__303d
	.section .rodata
crc32_chorba_c__crc_table:
	.size crc32_chorba_c__crc_table, 1024
	.byte 0,0,0,0,150,48,7,119,44,97,14,238,186,81,9,153
	.byte 25,196,109,7,143,244,106,112,53,165,99,233,163,149,100,158
	.byte 50,136,219,14,164,184,220,121,30,233,213,224,136,217,210,151
	.byte 43,76,182,9,189,124,177,126,7,45,184,231,145,29,191,144
	.byte 100,16,183,29,242,32,176,106,72,113,185,243,222,65,190,132
	.byte 125,212,218,26,235,228,221,109,81,181,212,244,199,133,211,131
	.byte 86,152,108,19,192,168,107,100,122,249,98,253,236,201,101,138
	.byte 79,92,1,20,217,108,6,99,99,61,15,250,245,13,8,141
	.byte 200,32,110,59,94,16,105,76,228,65,96,213,114,113,103,162
	.byte 209,228,3,60,71,212,4,75,253,133,13,210,107,181,10,165
	.byte 250,168,181,53,108,152,178,66,214,201,187,219,64,249,188,172
	.byte 227,108,216,50,117,92,223,69,207,13,214,220,89,61,209,171
	.byte 172,48,217,38,58,0,222,81,128,81,215,200,22,97,208,191
	.byte 181,244,180,33,35,196,179,86,153,149,186,207,15,165,189,184
	.byte 158,184,2,40,8,136,5,95,178,217,12,198,36,233,11,177
	.byte 135,124,111,47,17,76,104,88,171,29,97,193,61,45,102,182
	.byte 144,65,220,118,6,113,219,1,188,32,210,152,42,16,213,239
	.byte 137,133,177,113,31,181,182,6,165,228,191,159,51,212,184,232
	.byte 162,201,7,120,52,249,0,15,142,168,9,150,24,152,14,225
	.byte 187,13,106,127,45,61,109,8,151,108,100,145,1,92,99,230
	.byte 244,81,107,107,98,97,108,28,216,48,101,133,78,0,98,242
	.byte 237,149,6,108,123,165,1,27,193,244,8,130,87,196,15,245
	.byte 198,217,176,101,80,233,183,18,234,184,190,139,124,136,185,252
	.byte 223,29,221,98,73,45,218,21,243,124,211,140,101,76,212,251
	.byte 88,97,178,77,206,81,181,58,116,0,188,163,226,48,187,212
	.byte 65,165,223,74,215,149,216,61,109,196,209,164,251,244,214,211
	.byte 106,233,105,67,252,217,110,52,70,136,103,173,208,184,96,218
	.byte 115,45,4,68,229,29,3,51,95,76,10,170,201,124,13,221
	.byte 60,113,5,80,170,65,2,39,16,16,11,190,134,32,12,201
	.byte 37,181,104,87,179,133,111,32,9,212,102,185,159,228,97,206
	.byte 14,249,222,94,152,201,217,41,34,152,208,176,180,168,215,199
	.byte 23,61,179,89,129,13,180,46,59,92,189,183,173,108,186,192
	.byte 32,131,184,237,182,179,191,154,12,226,182,3,154,210,177,116
	.byte 57,71,213,234,175,119,210,157,21,38,219,4,131,22,220,115
	.byte 18,11,99,227,132,59,100,148,62,106,109,13,168,90,106,122
	.byte 11,207,14,228,157,255,9,147,39,174,0,10,177,158,7,125
	.byte 68,147,15,240,210,163,8,135,104,242,1,30,254,194,6,105
	.byte 93,87,98,247,203,103,101,128,113,54,108,25,231,6,107,110
	.byte 118,27,212,254,224,43,211,137,90,122,218,16,204,74,221,103
	.byte 111,223,185,249,249,239,190,142,67,190,183,23,213,142,176,96
	.byte 232,163,214,214,126,147,209,161,196,194,216,56,82,242,223,79
	.byte 241,103,187,209,103,87,188,166,221,6,181,63,75,54,178,72
	.byte 218,43,13,216,76,27,10,175,246,74,3,54,96,122,4,65
	.byte 195,239,96,223,85,223,103,168,239,142,110,49,121,190,105,70
	.byte 140,179,97,203,26,131,102,188,160,210,111,37,54,226,104,82
	.byte 149,119,12,204,3,71,11,187,185,22,2,34,47,38,5,85
	.byte 190,59,186,197,40,11,189,178,146,90,180,43,4,106,179,92
	.byte 167,255,215,194,49,207,208,181,139,158,217,44,29,174,222,91
	.byte 176,194,100,155,38,242,99,236,156,163,106,117,10,147,109,2
	.byte 169,6,9,156,63,54,14,235,133,103,7,114,19,87,0,5
	.byte 130,74,191,149,20,122,184,226,174,43,177,123,56,27,182,12
	.byte 155,142,210,146,13,190,213,229,183,239,220,124,33,223,219,11
	.byte 212,210,211,134,66,226,212,241,248,179,221,104,110,131,218,31
	.byte 205,22,190,129,91,38,185,246,225,119,176,111,119,71,183,24
	.byte 230,90,8,136,112,106,15,255,202,59,6,102,92,11,1,17
	.byte 255,158,101,143,105,174,98,248,211,255,107,97,69,207,108,22
	.byte 120,226,10,160,238,210,13,215,84,131,4,78,194,179,3,57
	.byte 97,38,103,167,247,22,96,208,77,71,105,73,219,119,110,62
	.byte 74,106,209,174,220,90,214,217,102,11,223,64,240,59,216,55
	.byte 83,174,188,169,197,158,187,222,127,207,178,71,233,255,181,48
	.byte 28,242,189,189,138,194,186,202,48,147,179,83,166,163,180,36
	.byte 5,54,208,186,147,6,215,205,41,87,222,84,191,103,217,35
	.byte 46,122,102,179,184,74,97,196,2,27,104,93,148,43,111,42
	.byte 55,190,11,180,161,142,12,195,27,223,5,90,141,239,2,45
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

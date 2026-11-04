	.text
slide_hash_sse2:
movl	0x40(%rdi), %ecx
movzwl	%cx, %eax
movd	%ecx, %xmm0
pshuflw	$0x0, %xmm0, %xmm0
pshufd	$0x0, %xmm0, %xmm0
movq	0x60(%rdi), %rcx
movl	$0x1fff0, %edx
addq	0x68(%rdi), %rdx
movl	$0xffff0000, %esi
nopw	%cs:(%rax,%rax)
L_30:
movdqa	-0x30(%rdx), %xmm1
movdqa	-0x20(%rdx), %xmm2
movdqa	-0x10(%rdx), %xmm3
movdqa	(%rdx), %xmm4
psubusw	%xmm0, %xmm3
psubusw	%xmm0, %xmm4
movdqa	%xmm3, -0x10(%rdx)
movdqa	%xmm4, (%rdx)
psubusw	%xmm0, %xmm1
psubusw	%xmm0, %xmm2
movdqa	%xmm1, -0x30(%rdx)
movdqa	%xmm2, -0x20(%rdx)
addq	$-0x40, %rdx
addl	$0x20, %esi
jne	L_30
leaq	(%rcx,%rax,2), %rcx
leal	-0x10(%rax), %edx
testb	$0x10, %dl
jne	L_9d
movdqa	-0x20(%rcx), %xmm1
movdqa	-0x10(%rcx), %xmm2
psubusw	%xmm0, %xmm1
psubusw	%xmm0, %xmm2
movdqa	%xmm1, -0x20(%rcx)
movdqa	%xmm2, -0x10(%rcx)
addq	$-0x20, %rcx
movl	%edx, %eax
L_9d:
cmpl	$0x10, %edx
jb	L_ef
addq	$-0x10, %rcx
nopw	%cs:(%rax,%rax)
L_b0:
movdqa	-0x30(%rcx), %xmm1
movdqa	-0x20(%rcx), %xmm2
movdqa	-0x10(%rcx), %xmm3
movdqa	(%rcx), %xmm4
psubusw	%xmm0, %xmm3
psubusw	%xmm0, %xmm4
movdqa	%xmm3, -0x10(%rcx)
movdqa	%xmm4, (%rcx)
psubusw	%xmm0, %xmm1
psubusw	%xmm0, %xmm2
movdqa	%xmm1, -0x30(%rcx)
movdqa	%xmm2, -0x20(%rcx)
addq	$-0x40, %rcx
addl	$-0x20, %eax
jne	L_b0
L_ef:
retq

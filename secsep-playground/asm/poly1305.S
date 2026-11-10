	.text
	.file	"bench_poly1305.c"
	.globl	CRYPTO_poly1305_init            # -- Begin function CRYPTO_poly1305_init
	.p2align	4, 0x90
	.type	CRYPTO_poly1305_init,@function
CRYPTO_poly1305_init:                   # @CRYPTO_poly1305_init
# %bb.0:
	movl	4(%rsi), %ecx
	movl	8(%rsi), %edx
	movl	12(%rsi), %eax
	movl	%eax, %r8d
	shldl	$18, %edx, %r8d
	shldl	$12, %ecx, %edx
	movl	(%rsi), %r9d
	shldl	$6, %r9d, %ecx
	andl	$67108863, %r9d                 # imm = 0x3FFFFFF
	movl	%r9d, (%rdi)
	andl	$67108611, %ecx                 # imm = 0x3FFFF03
	movl	%ecx, 4(%rdi)
	andl	$67092735, %edx                 # imm = 0x3FFC0FF
	movl	%edx, 8(%rdi)
	andl	$66076671, %r8d                 # imm = 0x3F03FFF
	movl	%r8d, 12(%rdi)
	shrl	$8, %eax
	andl	$1048575, %eax                  # imm = 0xFFFFF
	movl	%eax, 16(%rdi)
	leal	(%rcx,%rcx,4), %ecx
	movl	%ecx, 20(%rdi)
	leal	(%rdx,%rdx,4), %ecx
	movl	%ecx, 24(%rdi)
	leal	(%r8,%r8,4), %ecx
	movl	%ecx, 28(%rdi)
	leal	(%rax,%rax,4), %eax
	movl	%eax, 32(%rdi)
	movq	$0, 72(%rdi)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 36(%rdi)
	movl	$0, 52(%rdi)
	movups	16(%rsi), %xmm0
	movups	%xmm0, 80(%rdi)
	retq
.Lfunc_end0:
	.size	CRYPTO_poly1305_init, .Lfunc_end0-CRYPTO_poly1305_init
                                        # -- End function
	.globl	CRYPTO_poly1305_update          # -- Begin function CRYPTO_poly1305_update
	.p2align	4, 0x90
	.type	CRYPTO_poly1305_update,@function
CRYPTO_poly1305_update:                 # @CRYPTO_poly1305_update
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	testq	%rdx, %rdx
	je	.LBB1_24
# %bb.1:
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	movq	72(%rdi), %rcx
	testq	%rcx, %rcx
	je	.LBB1_13
# %bb.2:
	movl	$16, %eax
	subq	%rcx, %rax
	cmpq	%rbx, %rax
	cmovaeq	%rbx, %rax
	testq	%rax, %rax
	je	.LBB1_11
# %bb.3:
	movl	%eax, %ecx
	andl	$3, %ecx
	cmpq	$4, %rax
	jae	.LBB1_5
# %bb.4:
	xorl	%edx, %edx
	jmp	.LBB1_7
.LBB1_5:
	movq	%rax, %rsi
	andq	$-4, %rsi
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rdx), %edi
	movq	72(%r14), %r8
	addq	%r14, %r8
	movb	%dil, 56(%rdx,%r8)
	movzbl	1(%r15,%rdx), %edi
	movq	72(%r14), %r8
	addq	%r14, %r8
	movb	%dil, 57(%rdx,%r8)
	movzbl	2(%r15,%rdx), %edi
	movq	72(%r14), %r8
	addq	%r14, %r8
	movb	%dil, 58(%rdx,%r8)
	movzbl	3(%r15,%rdx), %edi
	movq	72(%r14), %r8
	addq	%r14, %r8
	movb	%dil, 59(%rdx,%r8)
	addq	$4, %rdx
	cmpq	%rdx, %rsi
	jne	.LBB1_6
.LBB1_7:
	testq	%rcx, %rcx
	je	.LBB1_10
# %bb.8:                                # %.preheader2
	leaq	(%rdx,%r14), %rsi
	addq	$56, %rsi
	addq	%r15, %rdx
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB1_9:                                # =>This Inner Loop Header: Depth=1
	movzbl	(%rdx,%rdi), %r8d
	movq	72(%r14), %r9
	addq	%rsi, %r9
	movb	%r8b, (%rdi,%r9)
	incq	%rdi
	cmpq	%rdi, %rcx
	jne	.LBB1_9
.LBB1_10:
	movq	72(%r14), %rcx
.LBB1_11:
	addq	%rax, %rcx
	movq	%rcx, 72(%r14)
	subq	%rax, %rbx
	addq	%rax, %r15
	cmpq	$16, %rcx
	jne	.LBB1_13
# %bb.12:
	leaq	56(%r14), %rsi
	movl	$16, %edx
	movq	%r14, %rdi
	callq	poly1305_update
	movq	$0, 72(%r14)
.LBB1_13:
	cmpq	$16, %rbx
	jb	.LBB1_15
# %bb.14:
	movq	%rbx, %r12
	andq	$-16, %r12
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	poly1305_update
	addq	%r12, %r15
	andl	$15, %ebx
.LBB1_15:
	testq	%rbx, %rbx
	je	.LBB1_24
# %bb.16:
	movl	%ebx, %eax
	andl	$3, %eax
	cmpq	$4, %rbx
	jae	.LBB1_18
# %bb.17:
	xorl	%ecx, %ecx
	jmp	.LBB1_20
.LBB1_18:
	movl	%ebx, %edx
	andl	$12, %edx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_19:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rcx), %esi
	movb	%sil, 56(%r14,%rcx)
	movzbl	1(%r15,%rcx), %esi
	movb	%sil, 57(%r14,%rcx)
	movzbl	2(%r15,%rcx), %esi
	movb	%sil, 58(%r14,%rcx)
	movzbl	3(%r15,%rcx), %esi
	movb	%sil, 59(%r14,%rcx)
	addq	$4, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB1_19
.LBB1_20:
	testq	%rax, %rax
	je	.LBB1_23
# %bb.21:                               # %.preheader
	leaq	(%rcx,%r14), %rdx
	addq	$56, %rdx
	addq	%rcx, %r15
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_22:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rcx), %esi
	movb	%sil, (%rdx,%rcx)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB1_22
.LBB1_23:
	movq	%rbx, 72(%r14)
.LBB1_24:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end1:
	.size	CRYPTO_poly1305_update, .Lfunc_end1-CRYPTO_poly1305_update
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function poly1305_update
.LCPI2_0:
	.long	67108863                        # 0x3ffffff
	.long	67108863                        # 0x3ffffff
	.long	67108863                        # 0x3ffffff
	.long	67108863                        # 0x3ffffff
	.text
	.p2align	4, 0x90
	.type	poly1305_update,@function
poly1305_update:                        # @poly1305_update
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	cmpq	$16, %rdx
	jb	.LBB2_2
	.p2align	4, 0x90
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	movl	(%r15), %ecx
	movl	4(%r15), %edx
	movl	8(%r15), %esi
	movl	12(%r15), %eax
	addq	$16, %r15
	addq	$-16, %r14
	movq	%rax, %rdi
	shlq	$32, %rdi
	orq	%rsi, %rdi
	shlq	$32, %rsi
	orq	%rdx, %rsi
	shlq	$32, %rdx
	orq	%rcx, %rdx
	shrq	$26, %rdx
	shrq	$20, %rsi
	shrq	$14, %rdi
	movdqu	36(%rbx), %xmm0
	movd	%edi, %xmm1
	movd	%esi, %xmm2
	punpckldq	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	movd	%edx, %xmm1
	movd	%ecx, %xmm3
	punpckldq	%xmm1, %xmm3            # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	punpcklqdq	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0]
	pand	.LCPI2_0(%rip), %xmm3
	paddd	%xmm0, %xmm3
	movdqu	%xmm3, 36(%rbx)
	shrl	$8, %eax
	movl	52(%rbx), %ecx
	addl	%ecx, %eax
	addl	$16777216, %eax                 # imm = 0x1000000
	movl	%eax, 52(%rbx)
	movq	%rbx, %rdi
	callq	poly1305_donna_mul
	cmpq	$15, %r14
	ja	.LBB2_1
.LBB2_2:
	testq	%r14, %r14
	je	.LBB2_15
# %bb.3:
	movq	%rsp, %rax
	xorl	%ecx, %ecx
	cmpq	$8, %r14
	jb	.LBB2_8
# %bb.4:
	movq	%rax, %rdx
	subq	%r15, %rdx
	cmpq	$32, %rdx
	jb	.LBB2_8
# %bb.5:
	movl	%r14d, %ecx
	andl	$8, %ecx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_6:                                # =>This Inner Loop Header: Depth=1
	movq	(%r15,%rdx), %rsi
	movq	%rsi, (%rsp,%rdx)
	addq	$8, %rdx
	cmpq	%rdx, %rcx
	jne	.LBB2_6
# %bb.7:
	cmpq	%rcx, %r14
	je	.LBB2_12
.LBB2_8:
	movq	%rcx, %rdx
	notq	%rdx
	addq	%r14, %rdx
	movq	%r14, %rsi
	andq	$3, %rsi
	je	.LBB2_10
	.p2align	4, 0x90
.LBB2_9:                                # =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rcx), %edi
	movb	%dil, (%rsp,%rcx)
	incq	%rcx
	decq	%rsi
	jne	.LBB2_9
.LBB2_10:
	cmpq	$3, %rdx
	jb	.LBB2_12
	.p2align	4, 0x90
.LBB2_11:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rcx), %edx
	movb	%dl, (%rsp,%rcx)
	movzbl	1(%r15,%rcx), %edx
	movb	%dl, 1(%rsp,%rcx)
	movzbl	2(%r15,%rcx), %edx
	movb	%dl, 2(%rsp,%rcx)
	movzbl	3(%r15,%rcx), %edx
	movb	%dl, 3(%rsp,%rcx)
	addq	$4, %rcx
	cmpq	%rcx, %r14
	jne	.LBB2_11
.LBB2_12:
	movb	$1, (%rsp,%r14)
	cmpq	$15, %r14
	je	.LBB2_14
# %bb.13:
	leaq	(%r14,%rax), %rdi
	incq	%rdi
	xorq	$15, %r14
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB2_14:
	movl	(%rsp), %ecx
	movl	4(%rsp), %edx
	movl	8(%rsp), %esi
	movl	12(%rsp), %eax
	movq	%rax, %rdi
	shlq	$32, %rdi
	orq	%rsi, %rdi
	shlq	$32, %rsi
	orq	%rdx, %rsi
	shlq	$32, %rdx
	orq	%rcx, %rdx
	shrq	$26, %rdx
	shrq	$20, %rsi
	shrq	$14, %rdi
	movdqu	36(%rbx), %xmm0
	movd	%edi, %xmm1
	movd	%esi, %xmm2
	punpckldq	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	movd	%edx, %xmm1
	movd	%ecx, %xmm3
	punpckldq	%xmm1, %xmm3            # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	punpcklqdq	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0]
	pand	.LCPI2_0(%rip), %xmm3
	paddd	%xmm0, %xmm3
	movdqu	%xmm3, 36(%rbx)
	shrl	$8, %eax
	addl	%eax, 52(%rbx)
	movq	%rbx, %rdi
	callq	poly1305_donna_mul
.LBB2_15:
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end2:
	.size	poly1305_update, .Lfunc_end2-poly1305_update
                                        # -- End function
	.globl	CRYPTO_poly1305_finish          # -- Begin function CRYPTO_poly1305_finish
	.p2align	4, 0x90
	.type	CRYPTO_poly1305_finish,@function
CRYPTO_poly1305_finish:                 # @CRYPTO_poly1305_finish
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	72(%rdi), %rdx
	testq	%rdx, %rdx
	je	.LBB3_2
# %bb.1:
	leaq	56(%r14), %rsi
	movq	%r14, %rdi
	callq	poly1305_update
.LBB3_2:
	movl	36(%r14), %edx
	movl	%edx, %eax
	shrl	$26, %eax
	andl	$67108863, %edx                 # imm = 0x3FFFFFF
	addl	40(%r14), %eax
	movl	%eax, %ecx
	shrl	$26, %ecx
	andl	$67108863, %eax                 # imm = 0x3FFFFFF
	addl	44(%r14), %ecx
	movl	%ecx, %esi
	shrl	$26, %esi
	addl	48(%r14), %esi
	andl	$67108863, %ecx                 # imm = 0x3FFFFFF
	movl	%esi, %edi
	shrl	$26, %edi
	andl	$67108863, %esi                 # imm = 0x3FFFFFF
	addl	52(%r14), %edi
	movq	%rdi, %r8
	shrq	$26, %r8
	leaq	(%r8,%r8,4), %r11
	leaq	(%rdx,%r11), %r10
	addq	$5, %r10
	movq	%r10, %r8
	shrq	$26, %r8
	addl	%eax, %r8d
	movl	%r8d, %r9d
	shrl	$26, %r9d
	addl	%ecx, %r9d
	movl	%r9d, %ebp
	shrl	$26, %ebp
	addl	%esi, %ebp
	movl	%ebp, %r15d
	shrl	$26, %r15d
	movl	%edi, %r12d
	orl	$-67108864, %r12d               # imm = 0xFC000000
	addl	%r15d, %r12d
	addq	%rdx, %r11
	movl	%r12d, %edx
	shrl	$31, %edx
	decl	%edx
	movl	%edx, %r15d
	andl	%r12d, %edx
	sarl	$31, %r12d
	andl	%r12d, %r11d
	andl	$67108863, %r15d                # imm = 0x3FFFFFF
	andl	%r15d, %r10d
	orl	%r11d, %r10d
	andl	%r12d, %eax
	andl	%r15d, %r8d
	orl	%eax, %r8d
	andl	%r12d, %ecx
	andl	%r15d, %r9d
	orl	%ecx, %r9d
	andl	%r12d, %edi
	andl	%esi, %r12d
	andl	%ebp, %r15d
	orl	%r12d, %r15d
	movl	84(%r14), %eax
	movl	%r10d, 36(%r14)
	movl	%r8d, 40(%r14)
	movl	%r9d, 44(%r14)
	movl	%r15d, 48(%r14)
	andl	$67108863, %edi                 # imm = 0x3FFFFFF
	orl	%edi, %edx
	movl	%edx, 52(%r14)
	movl	%r8d, %ecx
	shll	$26, %ecx
	orl	%r10d, %ecx
	shrq	$6, %r8
	movl	%r9d, %esi
	shll	$20, %esi
	orq	%r8, %rsi
	shrl	$12, %r9d
	movl	%r15d, %edi
	shll	$14, %edi
	orl	%r9d, %edi
	movl	88(%r14), %r8d
	addq	%rdi, %r8
	shrl	$18, %r15d
	shll	$8, %edx
	orl	%r15d, %edx
	addl	92(%r14), %edx
	addl	80(%r14), %ecx
	adcq	%rsi, %rax
	movl	%ecx, (%rbx)
	movl	%eax, 4(%rbx)
	shrq	$32, %rax
	addq	%r8, %rax
	movl	%eax, 8(%rbx)
	shrq	$32, %rax
	addl	%edx, %eax
	movl	%eax, 12(%rbx)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end3:
	.size	CRYPTO_poly1305_finish, .Lfunc_end3-CRYPTO_poly1305_finish
                                        # -- End function
	.globl	benchmark                       # -- Begin function benchmark
	.p2align	4, 0x90
	.type	benchmark,@function
benchmark:                              # @benchmark
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$120, %rsp
	leaq	key(%rip), %r12
	leaq	24(%rsp), %rbx
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	CRYPTO_poly1305_init
	leaq	message(%rip), %r15
	movl	$13, %edx
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	CRYPTO_poly1305_update
	movq	%rsp, %r14
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	CRYPTO_poly1305_finish
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	CRYPTO_poly1305_init
	movl	$17, %edx
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	CRYPTO_poly1305_update
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	CRYPTO_poly1305_finish
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	CRYPTO_poly1305_init
	movl	$16, %edx
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	CRYPTO_poly1305_update
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	CRYPTO_poly1305_finish
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	CRYPTO_poly1305_init
	movl	$32, %edx
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	CRYPTO_poly1305_update
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	CRYPTO_poly1305_finish
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	CRYPTO_poly1305_init
	movl	$2048, %edx                     # imm = 0x800
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	CRYPTO_poly1305_update
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	CRYPTO_poly1305_finish
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	CRYPTO_poly1305_init
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	CRYPTO_poly1305_update
	leaq	message+1(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+2(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+3(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+4(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+5(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+6(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+7(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+8(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+9(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+10(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+11(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+12(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+13(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+14(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	leaq	message+15(%rip), %rsi
	movl	$1, %edx
	movq	%rbx, %rdi
	callq	CRYPTO_poly1305_update
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	CRYPTO_poly1305_finish
	addq	$120, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end4:
	.size	benchmark, .Lfunc_end4-benchmark
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rax
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	callq	benchmark
	xorl	%eax, %eax
	popq	%rcx
	retq
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function poly1305_donna_mul
	.type	poly1305_donna_mul,@function
poly1305_donna_mul:                     # @poly1305_donna_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %r14
	movl	4(%rdi), %esi
	movl	40(%rdi), %r12d
	movl	32(%rdi), %ecx
	movq	%rcx, %rdx
	imulq	%r12, %rdx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movl	44(%rdi), %r11d
	movl	28(%rdi), %eax
	movq	%rax, %rdi
	movq	%rax, %r9
	imulq	%r11, %rdi
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	movl	48(%r14), %r10d
	movl	24(%r14), %edx
	movq	%rdx, %rdi
	imulq	%r10, %rdi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	movl	52(%r14), %ebp
	movl	20(%r14), %ebx
	imulq	%rbp, %rbx
	movl	8(%r14), %edi
	movq	%rsi, %rax
	imulq	%r12, %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	imulq	%r12, %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movl	12(%r14), %eax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	imulq	%r12, %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movl	(%r14), %eax
	imulq	%rax, %r12
	movq	%rsi, %r8
	imulq	%r11, %r8
	movq	%rdi, %r13
	imulq	%r11, %rdi
	movq	%rdi, -64(%rsp)                 # 8-byte Spill
	movq	%r11, %r15
	movq	%r11, %rdi
	imulq	%rcx, %rdi
	movq	%r10, %r11
	imulq	%r9, %r11
	imulq	%rbp, %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	imulq	%rax, %r15
	movq	%r10, %rdx
	imulq	%rcx, %rdx
	imulq	%rbp, %r9
	movq	%r9, -88(%rsp)                  # 8-byte Spill
	movq	%rsi, %r9
	imulq	%r10, %rsi
	movq	%rsi, -72(%rsp)                 # 8-byte Spill
	imulq	%rax, %r10
	imulq	%rbp, %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	imulq	%rax, %rbp
	movq	%rax, %rsi
	movl	36(%r14), %eax
	imulq	%rax, %rsi
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	addq	%rsi, %rcx
	movq	-24(%rsp), %rsi                 # 8-byte Reload
	addq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%rcx, %rsi
	addq	%rsi, %rbx
	addq	%r12, %rdi
	movq	-96(%rsp), %rcx                 # 8-byte Reload
	addq	%r11, %rcx
	addq	%rdi, %rcx
	imulq	%rax, %r9
	addq	%r9, %rcx
	movq	%rcx, %rdi
	addq	%r15, %rdx
	movq	-88(%rsp), %rcx                 # 8-byte Reload
	addq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rdx, %rcx
	imulq	%rax, %r13
	addq	%r13, %rcx
	movq	%rcx, %rdx
	addq	-48(%rsp), %r8                  # 8-byte Folded Reload
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	addq	%r10, %rcx
	addq	%r8, %rcx
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	imulq	%rax, %rsi
	addq	%rsi, %rcx
	movq	%rcx, %rsi
	movl	16(%r14), %ecx
	imulq	%rax, %rcx
	movq	-64(%rsp), %rax                 # 8-byte Reload
	addq	-56(%rsp), %rax                 # 8-byte Folded Reload
	addq	-72(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%rax, %rbp
	addq	%rcx, %rbp
	movl	%ebx, %eax
	shrq	$26, %rbx
	addq	%rdi, %rbx
	movl	%ebx, %ecx
	andl	$67108863, %ecx                 # imm = 0x3FFFFFF
	movl	%ecx, 40(%r14)
	shrq	$26, %rbx
	movl	%ebx, %ecx
	addq	%rdx, %rcx
	movl	%ecx, %edx
	andl	$67108863, %edx                 # imm = 0x3FFFFFF
	movl	%edx, 44(%r14)
	shrq	$26, %rcx
	movl	%ecx, %ecx
	addq	%rsi, %rcx
	movl	%ecx, %edx
	andl	$67108863, %edx                 # imm = 0x3FFFFFF
	movl	%edx, 48(%r14)
	shrq	$26, %rcx
	movl	%ecx, %ecx
	addq	%rbp, %rcx
	movl	%ecx, %edx
	andl	$67108863, %edx                 # imm = 0x3FFFFFF
	movl	%edx, 52(%r14)
	andl	$67108863, %eax                 # imm = 0x3FFFFFF
	shrq	$26, %rcx
	leal	(%rcx,%rcx,4), %ecx
	addl	%eax, %ecx
	movl	%ecx, 36(%r14)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end6:
	.size	poly1305_donna_mul, .Lfunc_end6-poly1305_donna_mul
                                        # -- End function
	.type	key,@object                     # @key
	.section	.secsep.secret,"aw",@progbits
	.globl	key
	.p2align	4, 0x90
key:
	.ascii	"\000\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037"
	.size	key, 32

	.type	message,@object                 # @message
	.globl	message
	.p2align	4, 0x90
message:
	.ascii	"$\212\303\020\205\266\302\255\252\243\202Y\240\327\031,\\5\321\273N\363\232\331L8\321\310$y\342\335!Y\240w\002K\005\211\274\212 \020\033Po\n\032\320\273\253v\350:\203\361\271K\346\276\256t\350t\312\266\222\305\226:uCkwa!\354\237b9\232>f\262\322'\007\332\350\0313\266'\177<\205\026\274\276&\333\275\206\363s\020=|\364\312\321\210\214\225!\030\373\373\320\327\264\276\334J\344\223j\377\221\025~z\244|TD.\247\215j\302Q\323$\240\373\344\235\211\3145!\266m\026\351\306j7\t\211NN\260\244\356\334J\341\224h\346k\201\362q5\033\035\222\036\245Q\004z\274\306\270z\220\037\336}\267\237\241\201\214\0213m\274\007$J@\353\024\317w\275\343^x\256\232\327\323\365~\327\347\3629&\311\027/\202\327v\204\352^\327\327N\274o\024+\231p6\274\267\314\350\337\033\274\r[5\244e\t\311T\374\224i\322\024\326#\217\026l\277\207!V\264\304\035z\254YB\317\373\027P#\007\202R\243\363n1\\]L\340\343\231(\240\030%(b\276\312\316\371j\031\360;\334\364muXB\231\321\370\260<\001i\351\344\007\3317\024[^P$\023\236p\"\241\227\217\021O$\315\372#x\n\021\2275\304\035\250\373u\233\273?\002\\n\303\016ln\233\316\206\025\276h\343\222\374\345\237\322j\216jl\305\306\006\343\204\201\026\344\320\035)VZ\037\254\373RKm)d;\202n\356\036B\206\237\307m\362)\335y\263\232+\035\362\213\2635\303\245\361Z\205]\001!\344\246\3324\265\344\325\267\265\325tj\003\354\377p\201\036\025\026\374\354\033\367F.\210v\242\322\027\020\252\026\214x\364Zj\025\001YP\342!\332\205\323\354\202*\326\320\246\223\033%\240k{\265\363\301\013\263l\324\326G\371V\031\202\375\351\201\215\345\324\277\215\267\370lS\264\377\024\222\212\301_y\002;a\206\036s\344B\026T\013\263\002\0257p\332%3\336\227\225%*\265\373w\255\222L\2238\310\024L#\324\311\r\253\232\030\376\254\032\025t\324T^\0245\353@^lLC\237\307$\374\351\222\256\205\272\3374[\255\026\330_\2753\217\004C7\003aGT\320\347\345LL\315\342g\005\207\325.\317\265\247\n\024\245\001\272\314rw\"d\2311\330Q[\023\320 \247\216Q\037\3416\324_\277\227\371\307\366\211\374\306w\317\263h7#\207\203P\377\351\320\2010\314nV{ay\340\033~\262\263\273\317\bs\3410\216\354\001\216\336\270\314\351F3\216\025\325\277h\307\031\026\250:\2315\2009\357\007\036\000\225F\242\337\223hy\337\373\2729z\223\222]\"\232F\237\321}q\267\365$\340:0\332n\351'T/\2136\233\355G4\376%\333\326=$\377\322\242\"\365\370Ou\330X\253\230\233\351%\257W\n\326\324[\322\214\346\033Q9\341\335/\013w\225\376\007.n\203\254\273^{wzp\306A\344\312\262\257@\356\326\232\2743L\322p<2s O\254X\fj=f\200B~_}\005\036\203\200\245?\223\241\200\364Un\316\244S\013\232-YH\332\326=A[ht\366\271\016v}m&[\350cQ\265;\246\220x\013\265|!\265t\030\305\271uY\350@\306\202W\3709\347X:K\367\307d\\Y\207\324\f\301\272y\242\030\303^\337\254\332\276X\035\225\016K\267\244\201\353\346Ma\320\016u\261\362_\034\345\365F#4\245\271\003\212iz\240\223z?\200\027\340],\234\005\334\260\\\013\002P\215\352a\233\023\177TD\266\360\210\353<\262\306g\210\370\212\375\373\272\217\252\034I\004\205bL\210\256\021\345sG\246v\220.uS\360V\030\204\223 \233\333\263\n\314c\311\344\036\026\251\326\300\tAkR\nv\2728\365v(\027\fCbk\\\264ay\334[\366]\350e\b_\204\277t\034\"?\276GM-\031\330\3649\024\373\326XcQ\b\236s\272\2774O\230\213yc\376DR\204W\327\252\323\305d\366\274\275\rw*L\237\323(\346\002-\034|\237\206ro\215Z#y}0\234\017e:\261\254hx3\353'\000\361V)`b\250\263w\007\217E\366\266\214=\007\312\341\221;\250\325\246\371\277u%\243C\236\2712\324\316\374K\370\341\260{H\312\023\354\343f\313\303\3408\211\025\221]\027WGQ\003\251\351EN~cU\336-j\313\364q\017\232c\344\366\323\315p\302\326\374\250\215\330\241DH\375\266<\3515\017\332\257\276\013\213\321\305\323\007\332\347m\376\327\231\256\362\330\362=V\b\323}\0230\3358\271H`\220]\276\353\367\215{s\030\267\324*\355@\323\371\211\236\237B\f\275\222\246\356\2560&\367rV\224\340\344\276\340\026\2724o\355,!\027+\333JF\034\353\340\317\343\216vdR&\254\022z%\234\0312d\3275\316\214\212W\341}\323\360W\236.\206\334)Z\321\364[\242\330]\263PD\332a\367\324\001'K1\356\373\3534\350\322\256Yn\233EA\252\341\027\275\254^\320\263$\302\0059\302|\007\244\021\325(\213\013_o\241n\232}\370]\303\031\372kq\315\b\250Y\300j?{\002\211\341u\n\333\361\202\371u\017\352\226\376\245\253z\243G3@`|\327\355,boS\202I\034&\325\325\276\246\024\001\336\3471\234\224\324\030\362\227\346\034\352\310\362X\356\214#\203\033\332\b\025\221\365\251\030\351hUwM\336\337\374Q\345\261\200\361\227\030\006\324/\3033\002\013sJ\353E\255\260\274G2]\f\352_g\023\247\206U\200\"\257\303\235W8\222\25265\357\277\330\274\261\034W\363\006\307!F\257\350\264S\210\022\\\267\277\236\317\226Z{\244\367h\307{\343fG\r\315\317!K\177jZ\224`\355O\344J\345Y\330^/\334 \224\336\203\377\361.\250\200M\261!\\L\250e\207\033\335\177\216\363*\267\231\277\222?\373\002\301\336\327\321)\276\255\255F\305\355\243\032\261\246\364=\240^\240\213\377\177\372\210\330\226cS\320\0300U\2149\2710\260\035\027^Cq$\330\355\320\322i\217\330\223/+,\233\024tnR\207\234W\243\225S\201P\363\220&O\000\346\rG\007\021 /A\224I\237\367\2207\312\230\205\334\215i_}\221z0\206\312\210\350\370\320$>\376\340\223\002\3179\3409\353|\310\335\031\322\201 \325\376S;W'\3159\0231\201\307)\312o\220\240\025\3550\276vh\325\313^\3143\245>\346\233\367\321\245\354\275\261S\2007C\306\255\252\253\323k\370N[\343\215?\004\245\325\333\375g\275\315;\027ne\275\023\221\255\347u\3142\316C\250G\373lg*?\351z]@\201\304\230iY\354_\270\230\364*\223\227\272+>\302\301\001\217\215v\320W\3626k\320\344FU\024\255e`\305\231fO\270V!\376w\036\000\364=9\265\221\262\246\243!\020\017M\036\362:7mZ\343\356\355\277\342=\247=\377\016\344\321k4\353\335\330\365\360S\333\230$\020_\3070\r\276\347\352j\365k\021#\031\343\342\025\240\374y\256\224okR'E>\307\374\257\027\317vQ\367\024\231\245\r\201\"\024\004\325\361)\254P\352u(\377\016\000i\354J\270\254\267\221\235\201t\232\263z\207\f^\362\314Z\025\317\226p\235<e\264\255\334w\347AhG\026\013\312\273\224\35267~\016\367\033\350\013\\\305>\377\325DH\210\004J55t\307,\222K\272*\213N\203T\030\216\277\355"
	.size	message, 2048

	.ident	"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"
	.section	".note.GNU-stack","",@progbits

/*
 * bn_add_words, bn_sub_words and friends for x86-64: aws-lc implements these as inline
 * assembly in crypto/fipsmodule/bn/asm/x86_64-gcc.c rather than as perlasm. Compiled with
 *   clang -S -O2 -target x86_64-unknown-linux-gnu -fno-asynchronous-unwind-tables -fno-stack-protector
 * from aws-lc as vendored by aws-lc-sys 0.44.0 (C headers from the macOS SDK; the file
 * only needs fixed-width integer types from them).
 */
	.file	"x86_64-gcc.c"
	.text
	.globl	bn_mul_add_words                # -- Begin function bn_mul_add_words
	.p2align	4
	.type	bn_mul_add_words,@function
bn_mul_add_words:                       # @bn_mul_add_words
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB0_1
# %bb.3:
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	cmpq	$4, %rdx
	jb	.LBB0_6
	.p2align	4
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	movq	%rcx, %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, (%rdi)
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r9
	movq	%rcx, %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, 8(%rdi)
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r9
	movq	%rcx, %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, 16(%rdi)
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r9
	movq	%rcx, %rax
	#APP
	mulq	24(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, 24(%rdi)
	adcq	$0, %rdx
	#NO_APP
	addq	$32, %rsi
	addq	$32, %rdi
	addq	$-4, %r8
	movq	%rdx, %r9
	cmpq	$3, %r8
	ja	.LBB0_4
# %bb.5:
	testq	%r8, %r8
	je	.LBB0_2
.LBB0_6:
	movq	%rcx, %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, (%rdi)
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r9
	cmpq	$1, %r8
	je	.LBB0_2
# %bb.7:
	movq	%rcx, %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, 8(%rdi)
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r9
	cmpq	$2, %r8
	je	.LBB0_2
# %bb.8:
	movq	%rcx, %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	#APP
	addq	%r9, 16(%rdi)
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %rax
	retq
.LBB0_1:
	xorl	%r9d, %r9d
.LBB0_2:
	movq	%r9, %rax
	retq
.Lfunc_end0:
	.size	bn_mul_add_words, .Lfunc_end0-bn_mul_add_words
                                        # -- End function
	.globl	bn_mul_words                    # -- Begin function bn_mul_words
	.p2align	4
	.type	bn_mul_words,@function
bn_mul_words:                           # @bn_mul_words
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB1_1
# %bb.3:
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	cmpq	$4, %rdx
	jb	.LBB1_6
	.p2align	4
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
	movq	(%rsi), %rax
	movq	%rax, -8(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-8(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r10
	movq	%r9, (%rdi)
	movq	8(%rsi), %rax
	movq	%rax, -16(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-16(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r9
	movq	%r10, 8(%rdi)
	movq	16(%rsi), %rax
	movq	%rax, -24(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-24(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	movq	%rdx, %r10
	movq	%r9, 16(%rdi)
	movq	24(%rsi), %rax
	movq	%rax, -32(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-32(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	$0, %rdx
	#NO_APP
	movq	%r10, 24(%rdi)
	addq	$32, %rsi
	addq	$32, %rdi
	addq	$-4, %r8
	movq	%rdx, %r9
	cmpq	$3, %r8
	ja	.LBB1_4
# %bb.5:
	testq	%r8, %r8
	je	.LBB1_2
.LBB1_6:
	movq	(%rsi), %rax
	movq	%rax, -40(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-40(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	movq	%r9, (%rdi)
	movq	%rdx, %r9
	cmpq	$1, %r8
	je	.LBB1_2
# %bb.7:
	movq	8(%rsi), %rax
	movq	%rax, -48(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-48(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	movq	%r9, 8(%rdi)
	movq	%rdx, %r9
	cmpq	$2, %r8
	je	.LBB1_2
# %bb.8:
	movq	16(%rsi), %rax
	movq	%rax, -56(%rsp)
	movq	%rcx, %rax
	#APP
	mulq	-56(%rsp)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	$0, %rdx
	#NO_APP
	movq	%r9, 16(%rdi)
	movq	%rdx, %rax
	retq
.LBB1_1:
	xorl	%r9d, %r9d
.LBB1_2:
	movq	%r9, %rax
	retq
.Lfunc_end1:
	.size	bn_mul_words, .Lfunc_end1-bn_mul_words
                                        # -- End function
	.globl	bn_sqr_words                    # -- Begin function bn_sqr_words
	.p2align	4
	.type	bn_sqr_words,@function
bn_sqr_words:                           # @bn_sqr_words
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB2_7
# %bb.1:
	movq	%rdx, %rcx
	cmpq	$4, %rdx
	jb	.LBB2_4
	.p2align	4
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	movq	(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	8(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, 16(%rdi)
	movq	%rdx, 24(%rdi)
	movq	16(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, 32(%rdi)
	movq	%rdx, 40(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, 48(%rdi)
	movq	%rdx, 56(%rdi)
	addq	$32, %rsi
	addq	$64, %rdi
	addq	$-4, %rcx
	cmpq	$3, %rcx
	ja	.LBB2_2
# %bb.3:
	testq	%rcx, %rcx
	je	.LBB2_7
.LBB2_4:
	movq	(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	cmpq	$1, %rcx
	je	.LBB2_7
# %bb.5:
	movq	8(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, 16(%rdi)
	movq	%rdx, 24(%rdi)
	cmpq	$2, %rcx
	je	.LBB2_7
# %bb.6:
	movq	16(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	movq	%rax, 32(%rdi)
	movq	%rdx, 40(%rdi)
.LBB2_7:
	retq
.Lfunc_end2:
	.size	bn_sqr_words, .Lfunc_end2-bn_sqr_words
                                        # -- End function
	.globl	bn_add_words                    # -- Begin function bn_add_words
	.p2align	4
	.type	bn_add_words,@function
bn_add_words:                           # @bn_add_words
# %bb.0:
	testq	%rcx, %rcx
	je	.LBB3_1
# %bb.3:
	xorl	%r8d, %r8d
	#APP
	subq	%rax, %rax
	jmp	.Ltmp0
	.p2align	4
.Ltmp0:
	movq	(%rsi,%r8,8), %rax
	adcq	(%rdx,%r8,8), %rax
	movq	%rax, (%rdi,%r8,8)
	leaq	1(%r8), %r8
	decq	%rcx
	jne	.Ltmp0
	sbbq	%rax, %rax

	#NO_APP
	andl	$1, %eax
	retq
.LBB3_1:
	xorl	%eax, %eax
	retq
.Lfunc_end3:
	.size	bn_add_words, .Lfunc_end3-bn_add_words
                                        # -- End function
	.globl	bn_sub_words                    # -- Begin function bn_sub_words
	.p2align	4
	.type	bn_sub_words,@function
bn_sub_words:                           # @bn_sub_words
# %bb.0:
	testq	%rcx, %rcx
	je	.LBB4_1
# %bb.3:
	xorl	%r8d, %r8d
	#APP
	subq	%rax, %rax
	jmp	.Ltmp1
	.p2align	4
.Ltmp1:
	movq	(%rsi,%r8,8), %rax
	sbbq	(%rdx,%r8,8), %rax
	movq	%rax, (%rdi,%r8,8)
	leaq	1(%r8), %r8
	decq	%rcx
	jne	.Ltmp1
	sbbq	%rax, %rax

	#NO_APP
	andl	$1, %eax
	retq
.LBB4_1:
	xorl	%eax, %eax
	retq
.Lfunc_end4:
	.size	bn_sub_words, .Lfunc_end4-bn_sub_words
                                        # -- End function
	.globl	bn_mul_comba8                   # -- Begin function bn_mul_comba8
	.p2align	4
	.type	bn_mul_comba8,@function
bn_mul_comba8:                          # @bn_mul_comba8
# %bb.0:
	movq	%rdx, %rcx
	movq	(%rsi), %rax
	#APP
	mulq	(%rdx)
	#NO_APP
	xorl	%r8d, %r8d
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, (%rdi)
	movq	(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 8(%rdi)
	movq	16(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 16(%rdi)
	movq	(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 24(%rdi)
	movq	32(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 32(%rdi)
	movq	(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 40(%rdi)
	movq	48(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 48(%rdi)
	movq	(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	56(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 56(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 64(%rdi)
	movq	16(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	56(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 72(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 80(%rdi)
	movq	32(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	56(%rsi), %rax
	#APP
	mulq	32(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 88(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	40(%rcx)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 96(%rdi)
	movq	48(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	56(%rsi), %rax
	#APP
	mulq	48(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 104(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	56(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
	#NO_APP
	movq	%r9, 112(%rdi)
	movq	%r10, 120(%rdi)
	retq
.Lfunc_end5:
	.size	bn_mul_comba8, .Lfunc_end5-bn_mul_comba8
                                        # -- End function
	.globl	bn_mul_comba4                   # -- Begin function bn_mul_comba4
	.p2align	4
	.type	bn_mul_comba4,@function
bn_mul_comba4:                          # @bn_mul_comba4
# %bb.0:
	movq	%rdx, %rcx
	movq	(%rsi), %rax
	#APP
	mulq	(%rdx)
	#NO_APP
	xorl	%r8d, %r8d
	xorl	%r10d, %r10d
	xorl	%r9d, %r9d
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	%r10, (%rdi)
	movq	(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	%r9, 8(%rdi)
	movq	16(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	%r11, 16(%rdi)
	movq	(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	%r10, 24(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	8(%rcx)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	8(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	%r9, 32(%rdi)
	movq	16(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	16(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	%r11, 40(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	24(%rcx)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r8
	#NO_APP
	movq	%r10, 48(%rdi)
	movq	%r9, 56(%rdi)
	retq
.Lfunc_end6:
	.size	bn_mul_comba4, .Lfunc_end6-bn_mul_comba4
                                        # -- End function
	.globl	bn_sqr_comba8                   # -- Begin function bn_sqr_comba8
	.p2align	4
	.type	bn_sqr_comba8,@function
bn_sqr_comba8:                          # @bn_sqr_comba8
# %bb.0:
	movq	(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	xorl	%r11d, %r11d
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %rcx
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%rcx, (%rdi)
	movq	8(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 8(%rdi)
	movq	8(%rsi), %rax
	movq	16(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 16(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 24(%rdi)
	movq	16(%rsi), %rax
	movq	24(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 32(%rdi)
	movq	40(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	24(%rsi), %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 40(%rdi)
	movq	24(%rsi), %rax
	movq	32(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 48(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	32(%rsi), %rax
	#APP
	mulq	24(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 56(%rdi)
	movq	32(%rsi), %rax
	movq	40(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	24(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	56(%rsi), %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 64(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	24(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	40(%rsi), %rax
	#APP
	mulq	32(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 72(%rdi)
	movq	40(%rsi), %rax
	movq	48(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	32(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	56(%rsi), %rax
	#APP
	mulq	24(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	#NO_APP
	movq	%r11, 80(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	32(%rsi)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	48(%rsi), %rax
	#APP
	mulq	40(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	#NO_APP
	movq	%r9, 88(%rdi)
	movq	48(%rsi), %rax
	movq	56(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	40(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	#NO_APP
	movq	%r10, 96(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	48(%rsi)
	#NO_APP
	xorl	%ecx, %ecx
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %rcx
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %rcx
	#NO_APP
	movq	%r11, 104(%rdi)
	movq	56(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %rcx
	adcq	$0, %r8
	#NO_APP
	movq	%r9, 112(%rdi)
	movq	%rcx, 120(%rdi)
	retq
.Lfunc_end7:
	.size	bn_sqr_comba8, .Lfunc_end7-bn_sqr_comba8
                                        # -- End function
	.globl	bn_sqr_comba4                   # -- Begin function bn_sqr_comba4
	.p2align	4
	.type	bn_sqr_comba4,@function
bn_sqr_comba4:                          # @bn_sqr_comba4
# %bb.0:
	movq	(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	xorl	%r9d, %r9d
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %rcx
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	%rcx, (%rdi)
	movq	8(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	%r9, 8(%rdi)
	movq	8(%rsi), %rax
	movq	16(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r9d, %r9d
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	#NO_APP
	movq	%r11, 16(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	(%rsi)
	#NO_APP
	xorl	%r11d, %r11d
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	16(%rsi), %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	#NO_APP
	movq	%r10, 24(%rdi)
	movq	16(%rsi), %rax
	movq	24(%rsi), %rcx
	#APP
	mulq	%rax
	#NO_APP
	xorl	%r10d, %r10d
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	%rcx, %rax
	#APP
	mulq	8(%rsi)
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	#APP
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	#NO_APP
	movq	%r9, 32(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	16(%rsi)
	#NO_APP
	xorl	%ecx, %ecx
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %rcx
	#NO_APP
	#APP
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %rcx
	#NO_APP
	movq	%r11, 40(%rdi)
	movq	24(%rsi), %rax
	#APP
	mulq	%rax
	#NO_APP
	#APP
	addq	%rax, %r10
	adcq	%rdx, %rcx
	adcq	$0, %r8
	#NO_APP
	movq	%r10, 48(%rdi)
	movq	%rcx, 56(%rdi)
	retq
.Lfunc_end8:
	.size	bn_sqr_comba4, .Lfunc_end8-bn_sqr_comba4
                                        # -- End function
	.ident	"Homebrew clang version 20.1.2"
	.section	".note.GNU-stack","",@progbits
	.addrsig

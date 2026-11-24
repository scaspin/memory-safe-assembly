/*
 * bn_add_words, bn_sub_words and friends for x86-64: aws-lc implements these as inline
 * assembly in crypto/fipsmodule/bn/asm/x86_64-gcc.c rather than as perlasm. Compiled with
 *   clang -S -O2 -target x86_64-apple-darwin -fno-asynchronous-unwind-tables -fno-stack-protector
 * from aws-lc as vendored by aws-lc-sys 0.44.0.
 */
	.build_version macos, 16, 0	sdk_version 27, 0
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_bn_mul_add_words               ## -- Begin function bn_mul_add_words
	.p2align	4
_bn_mul_add_words:                      ## @bn_mul_add_words
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	testq	%rdx, %rdx
	je	LBB0_1
## %bb.3:
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	cmpq	$4, %rdx
	jb	LBB0_6
	.p2align	4
LBB0_4:                                 ## =>This Inner Loop Header: Depth=1
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, (%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r9
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, 8(%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r9
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, 16(%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r9
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	24(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, 24(%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	addq	$32, %rsi
	addq	$32, %rdi
	addq	$-4, %r8
	movq	%rdx, %r9
	cmpq	$3, %r8
	ja	LBB0_4
## %bb.5:
	testq	%r8, %r8
	je	LBB0_2
LBB0_6:
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, (%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r9
	cmpq	$1, %r8
	je	LBB0_2
## %bb.7:
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, 8(%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r9
	cmpq	$2, %r8
	je	LBB0_2
## %bb.8:
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	## InlineAsm Start
	addq	%r9, 16(%rdi)
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %rax
	popq	%rbp
	retq
LBB0_1:
	xorl	%r9d, %r9d
LBB0_2:
	movq	%r9, %rax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_bn_mul_words                   ## -- Begin function bn_mul_words
	.p2align	4
_bn_mul_words:                          ## @bn_mul_words
## %bb.0:
	testq	%rdx, %rdx
	je	LBB1_1
## %bb.3:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	cmpq	$4, %rdx
	jb	LBB1_6
	.p2align	4
LBB1_4:                                 ## =>This Inner Loop Header: Depth=1
	movq	(%rsi), %rax
	movq	%rax, -56(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-56(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r10
	movq	%r9, (%rdi)
	movq	8(%rsi), %rax
	movq	%rax, -48(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-48(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r9
	movq	%r10, 8(%rdi)
	movq	16(%rsi), %rax
	movq	%rax, -40(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-40(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	movq	%rdx, %r10
	movq	%r9, 16(%rdi)
	movq	24(%rsi), %rax
	movq	%rax, -32(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-32(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	$0, %rdx
	## InlineAsm End
	movq	%r10, 24(%rdi)
	addq	$32, %rsi
	addq	$32, %rdi
	addq	$-4, %r8
	movq	%rdx, %r9
	cmpq	$3, %r8
	ja	LBB1_4
## %bb.5:
	testq	%r8, %r8
	je	LBB1_9
LBB1_6:
	movq	(%rsi), %rax
	movq	%rax, -24(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-24(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	movq	%r9, (%rdi)
	movq	%rdx, %r9
	cmpq	$1, %r8
	je	LBB1_9
## %bb.7:
	movq	8(%rsi), %rax
	movq	%rax, -16(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-16(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	movq	%r9, 8(%rdi)
	movq	%rdx, %r9
	cmpq	$2, %r8
	je	LBB1_9
## %bb.8:
	movq	16(%rsi), %rax
	movq	%rax, -8(%rbp)
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	-8(%rbp)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	$0, %rdx
	## InlineAsm End
	movq	%r9, 16(%rdi)
	movq	%rdx, %r9
LBB1_9:
	popq	%rbp
	movq	%r9, %rax
	retq
LBB1_1:
	xorl	%r9d, %r9d
	movq	%r9, %rax
	retq
                                        ## -- End function
	.globl	_bn_sqr_words                   ## -- Begin function bn_sqr_words
	.p2align	4
_bn_sqr_words:                          ## @bn_sqr_words
## %bb.0:
	testq	%rdx, %rdx
	je	LBB2_8
## %bb.1:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdx, %rcx
	cmpq	$4, %rdx
	jb	LBB2_4
	.p2align	4
LBB2_2:                                 ## =>This Inner Loop Header: Depth=1
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, 16(%rdi)
	movq	%rdx, 24(%rdi)
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, 32(%rdi)
	movq	%rdx, 40(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, 48(%rdi)
	movq	%rdx, 56(%rdi)
	addq	$32, %rsi
	addq	$64, %rdi
	addq	$-4, %rcx
	cmpq	$3, %rcx
	ja	LBB2_2
## %bb.3:
	testq	%rcx, %rcx
	je	LBB2_7
LBB2_4:
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	cmpq	$1, %rcx
	je	LBB2_7
## %bb.5:
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, 16(%rdi)
	movq	%rdx, 24(%rdi)
	cmpq	$2, %rcx
	je	LBB2_7
## %bb.6:
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	movq	%rax, 32(%rdi)
	movq	%rdx, 40(%rdi)
LBB2_7:
	popq	%rbp
LBB2_8:
	retq
                                        ## -- End function
	.globl	_bn_add_words                   ## -- Begin function bn_add_words
	.p2align	4
_bn_add_words:                          ## @bn_add_words
## %bb.0:
	testq	%rcx, %rcx
	je	LBB3_1
## %bb.3:
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%r8d, %r8d
	## InlineAsm Start
	subq	%rax, %rax
	jmp	Ltmp0
	.p2align	4
Ltmp0:
	movq	(%rsi,%r8,8), %rax
	adcq	(%rdx,%r8,8), %rax
	movq	%rax, (%rdi,%r8,8)
	leaq	1(%r8), %r8
	decq	%rcx
	jne	Ltmp0
	sbbq	%rax, %rax

	## InlineAsm End
	andl	$1, %eax
	popq	%rbp
	retq
LBB3_1:
	xorl	%eax, %eax
	retq
                                        ## -- End function
	.globl	_bn_sub_words                   ## -- Begin function bn_sub_words
	.p2align	4
_bn_sub_words:                          ## @bn_sub_words
## %bb.0:
	testq	%rcx, %rcx
	je	LBB4_1
## %bb.3:
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%r8d, %r8d
	## InlineAsm Start
	subq	%rax, %rax
	jmp	Ltmp1
	.p2align	4
Ltmp1:
	movq	(%rsi,%r8,8), %rax
	sbbq	(%rdx,%r8,8), %rax
	movq	%rax, (%rdi,%r8,8)
	leaq	1(%r8), %r8
	decq	%rcx
	jne	Ltmp1
	sbbq	%rax, %rax

	## InlineAsm End
	andl	$1, %eax
	popq	%rbp
	retq
LBB4_1:
	xorl	%eax, %eax
	retq
                                        ## -- End function
	.globl	_bn_mul_comba8                  ## -- Begin function bn_mul_comba8
	.p2align	4
_bn_mul_comba8:                         ## @bn_mul_comba8
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdx, %rcx
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	(%rdx)
	## InlineAsm End
	xorl	%r8d, %r8d
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, (%rdi)
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 8(%rdi)
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 16(%rdi)
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 24(%rdi)
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 32(%rdi)
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 40(%rdi)
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 48(%rdi)
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 56(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 64(%rdi)
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 72(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 80(%rdi)
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 88(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rcx)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 96(%rdi)
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 104(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	56(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
	## InlineAsm End
	movq	%r9, 112(%rdi)
	movq	%r10, 120(%rdi)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_bn_mul_comba4                  ## -- Begin function bn_mul_comba4
	.p2align	4
_bn_mul_comba4:                         ## @bn_mul_comba4
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdx, %rcx
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	(%rdx)
	## InlineAsm End
	xorl	%r8d, %r8d
	xorl	%r10d, %r10d
	xorl	%r9d, %r9d
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	%r10, (%rdi)
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	%r9, 8(%rdi)
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	%r11, 16(%rdi)
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	%r10, 24(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rcx)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	%r9, 32(%rdi)
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	%r11, 40(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rcx)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r8
	## InlineAsm End
	movq	%r10, 48(%rdi)
	movq	%r9, 56(%rdi)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_bn_sqr_comba8                  ## -- Begin function bn_sqr_comba8
	.p2align	4
_bn_sqr_comba8:                         ## @bn_sqr_comba8
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r8d, %r8d
	xorl	%r10d, %r10d
	xorl	%ecx, %ecx
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %rcx
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, (%rdi)
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %rcx
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %rcx
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%rcx, 8(%rdi)
	movq	8(%rsi), %rax
	movq	16(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 16(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 24(%rdi)
	movq	16(%rsi), %rax
	movq	24(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 32(%rdi)
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 40(%rdi)
	movq	24(%rsi), %rax
	movq	32(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 48(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	32(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 56(%rdi)
	movq	32(%rsi), %rax
	movq	40(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	24(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 64(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	40(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 72(%rdi)
	movq	40(%rsi), %rax
	movq	48(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	32(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	24(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %r10
	## InlineAsm End
	movq	%r11, 80(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	32(%rsi)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	48(%rsi), %rax
	## InlineAsm Start
	mulq	40(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, 88(%rdi)
	movq	48(%rsi), %rax
	movq	56(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	40(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r9
	## InlineAsm End
	movq	%r10, 96(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	48(%rsi)
	## InlineAsm End
	xorl	%ecx, %ecx
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %rcx
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r9
	adcq	$0, %rcx
	## InlineAsm End
	movq	%r11, 104(%rdi)
	movq	56(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %rcx
	adcq	$0, %r8
	## InlineAsm End
	movq	%r9, 112(%rdi)
	movq	%rcx, 120(%rdi)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_bn_sqr_comba4                  ## -- Begin function bn_sqr_comba4
	.p2align	4
_bn_sqr_comba4:                         ## @bn_sqr_comba4
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	xorl	%ecx, %ecx
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %rcx
	adcq	$0, %r11
	## InlineAsm End
	movq	%r9, (%rdi)
	movq	8(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %rcx
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %rcx
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	%rcx, 8(%rdi)
	movq	8(%rsi), %rax
	movq	16(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r9d, %r9d
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %r9
	## InlineAsm End
	movq	%r11, 16(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	(%rsi)
	## InlineAsm End
	xorl	%r11d, %r11d
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	16(%rsi), %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %r9
	adcq	$0, %r11
	## InlineAsm End
	movq	%r10, 24(%rdi)
	movq	16(%rsi), %rax
	movq	24(%rsi), %rcx
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	xorl	%r10d, %r10d
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	%rcx, %rax
	## InlineAsm Start
	mulq	8(%rsi)
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r9
	adcq	%rdx, %r11
	adcq	$0, %r10
	## InlineAsm End
	movq	%r9, 32(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	16(%rsi)
	## InlineAsm End
	xorl	%ecx, %ecx
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %rcx
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r11
	adcq	%rdx, %r10
	adcq	$0, %rcx
	## InlineAsm End
	movq	%r11, 40(%rdi)
	movq	24(%rsi), %rax
	## InlineAsm Start
	mulq	%rax
	## InlineAsm End
	## InlineAsm Start
	addq	%rax, %r10
	adcq	%rdx, %rcx
	adcq	$0, %r8
	## InlineAsm End
	movq	%r10, 48(%rdi)
	movq	%rcx, 56(%rdi)
	popq	%rbp
	retq
                                        ## -- End function
.subsections_via_symbols

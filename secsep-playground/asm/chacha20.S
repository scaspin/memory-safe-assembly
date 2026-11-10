	.text
	.file	"bench_chacha20.c"
	.globl	CRYPTO_hchacha20                # -- Begin function CRYPTO_hchacha20
	.p2align	4, 0x90
	.type	CRYPTO_hchacha20,@function
CRYPTO_hchacha20:                       # @CRYPTO_hchacha20
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movl	(%rsi), %eax
	movl	4(%rsi), %ecx
	movl	8(%rsi), %r8d
	movl	12(%rsi), %r11d
	movl	16(%rsi), %edi
	movl	%edi, -28(%rsp)                 # 4-byte Spill
	movl	20(%rsi), %ebp
	movl	24(%rsi), %r14d
	movl	28(%rsi), %r15d
	movl	(%rdx), %esi
	movl	4(%rdx), %r9d
	movl	8(%rdx), %r10d
	movl	12(%rdx), %edx
	movl	$1797285236, %r12d              # imm = 0x6B206574
	movl	$2036477234, %r13d              # imm = 0x79622D32
	movl	$857760878, %ebx                # imm = 0x3320646E
	movl	$1634760805, %edi               # imm = 0x61707865
	movq	$-2, -16(%rsp)                  # 8-byte Folded Spill
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movl	%r15d, -24(%rsp)                # 4-byte Spill
	addl	%eax, %edi
	xorl	%edi, %esi
	roll	$16, %esi
	movl	-28(%rsp), %r15d                # 4-byte Reload
	addl	%esi, %r15d
	xorl	%r15d, %eax
	roll	$12, %eax
	addl	%eax, %edi
	xorl	%edi, %esi
	roll	$8, %esi
	addl	%esi, %r15d
	movl	%r15d, -28(%rsp)                # 4-byte Spill
	xorl	%r15d, %eax
	movl	-24(%rsp), %r15d                # 4-byte Reload
	roll	$7, %eax
	addl	%ecx, %ebx
	xorl	%ebx, %r9d
	roll	$16, %r9d
	addl	%r9d, %ebp
	xorl	%ebp, %ecx
	roll	$12, %ecx
	addl	%ecx, %ebx
	xorl	%ebx, %r9d
	roll	$8, %r9d
	addl	%r9d, %ebp
	xorl	%ebp, %ecx
	roll	$7, %ecx
	addl	%r8d, %r13d
	xorl	%r13d, %r10d
	roll	$16, %r10d
	addl	%r10d, %r14d
	xorl	%r14d, %r8d
	roll	$12, %r8d
	addl	%r8d, %r13d
	xorl	%r13d, %r10d
	roll	$8, %r10d
	addl	%r10d, %r14d
	xorl	%r14d, %r8d
	roll	$7, %r8d
	addl	%r11d, %r12d
	xorl	%r12d, %edx
	roll	$16, %edx
	addl	%edx, %r15d
	xorl	%r15d, %r11d
	roll	$12, %r11d
	addl	%r11d, %r12d
	xorl	%r12d, %edx
	roll	$8, %edx
	addl	%edx, %r15d
	xorl	%r15d, %r11d
	roll	$7, %r11d
	addl	%ecx, %edi
	xorl	%edi, %edx
	roll	$16, %edx
	addl	%edx, %r14d
	xorl	%r14d, %ecx
	roll	$12, %ecx
	addl	%ecx, %edi
	xorl	%edi, %edx
	roll	$8, %edx
	addl	%edx, %r14d
	movl	%r14d, -20(%rsp)                # 4-byte Spill
	xorl	%r14d, %ecx
	roll	$7, %ecx
	addl	%r8d, %ebx
	xorl	%ebx, %esi
	roll	$16, %esi
	addl	%esi, %r15d
	xorl	%r15d, %r8d
	roll	$12, %r8d
	addl	%r8d, %ebx
	xorl	%ebx, %esi
	roll	$8, %esi
	addl	%esi, %r15d
	xorl	%r15d, %r8d
	roll	$7, %r8d
	addl	%r11d, %r13d
	xorl	%r13d, %r9d
	roll	$16, %r9d
	movl	-28(%rsp), %r14d                # 4-byte Reload
	addl	%r9d, %r14d
	xorl	%r14d, %r11d
	roll	$12, %r11d
	addl	%r11d, %r13d
	xorl	%r13d, %r9d
	roll	$8, %r9d
	addl	%r9d, %r14d
	movl	%r14d, -28(%rsp)                # 4-byte Spill
	xorl	%r14d, %r11d
	movl	-20(%rsp), %r14d                # 4-byte Reload
	roll	$7, %r11d
	addl	%eax, %r12d
	xorl	%r12d, %r10d
	roll	$16, %r10d
	addl	%r10d, %ebp
	xorl	%ebp, %eax
	roll	$12, %eax
	addl	%eax, %r12d
	xorl	%r12d, %r10d
	roll	$8, %r10d
	addl	%r10d, %ebp
	movl	%ebp, -24(%rsp)                 # 4-byte Spill
	xorl	%ebp, %eax
	roll	$7, %eax
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	addq	$2, %rbp
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	cmpq	$18, %rbp
	movl	-24(%rsp), %ebp                 # 4-byte Reload
	jb	.LBB0_1
# %bb.2:
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movl	%edi, (%rax)
	movl	%ebx, 4(%rax)
	movl	%r13d, 8(%rax)
	movl	%r12d, 12(%rax)
	movl	%esi, 16(%rax)
	movl	%r9d, 20(%rax)
	movl	%r10d, 24(%rax)
	movl	%edx, 28(%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end0:
	.size	CRYPTO_hchacha20, .Lfunc_end0-CRYPTO_hchacha20
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function CRYPTO_chacha_20
.LCPI1_0:
	.long	1634760805                      # 0x61707865
	.long	857760878                       # 0x3320646e
	.long	2036477234                      # 0x79622d32
	.long	1797285236                      # 0x6b206574
	.text
	.globl	CRYPTO_chacha_20
	.p2align	4, 0x90
	.type	CRYPTO_chacha_20,@function
CRYPTO_chacha_20:                       # @CRYPTO_chacha_20
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$136, %rsp
	movaps	.LCPI1_0(%rip), %xmm0           # xmm0 = [1634760805,857760878,2036477234,1797285236]
	movaps	%xmm0, 64(%rsp)
	movups	(%rcx), %xmm0
	movaps	%xmm0, 80(%rsp)
	movups	16(%rcx), %xmm0
	movaps	%xmm0, 96(%rsp)
	movl	%r9d, 112(%rsp)
	movq	(%r8), %rax
	movq	%rax, 116(%rsp)
	movl	8(%r8), %eax
	movl	%eax, 124(%rsp)
	testq	%rdx, %rdx
	je	.LBB1_19
# %bb.1:                                # %.preheader3
	movl	%r9d, %ebx
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	leaq	64(%rsp), %rbp
	jmp	.LBB1_2
	.p2align	4, 0x90
.LBB1_18:                               #   in Loop: Header=BB1_2 Depth=1
	addq	%r13, %r12
	addq	%r13, %r15
	incl	%ebx
	movl	%ebx, 112(%rsp)
	subq	%r13, %r14
	je	.LBB1_19
.LBB1_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_8 Depth 2
                                        #     Child Loop BB1_12 Depth 2
                                        #     Child Loop BB1_15 Depth 2
                                        #     Child Loop BB1_17 Depth 2
	cmpq	$64, %r14
	movl	$64, %r13d
	cmovbq	%r14, %r13
	movq	%rsp, %rdi
	movq	%rbp, %rsi
	callq	chacha_core
	cmpq	$8, %r13
	jb	.LBB1_3
# %bb.4:                                #   in Loop: Header=BB1_2 Depth=1
	movq	%r12, %rcx
	subq	%r15, %rcx
	movl	$0, %eax
	cmpq	$32, %rcx
	jb	.LBB1_14
# %bb.5:                                #   in Loop: Header=BB1_2 Depth=1
	cmpq	$32, %r13
	jae	.LBB1_7
# %bb.6:                                #   in Loop: Header=BB1_2 Depth=1
	xorl	%eax, %eax
	jmp	.LBB1_11
	.p2align	4, 0x90
.LBB1_3:                                #   in Loop: Header=BB1_2 Depth=1
	xorl	%eax, %eax
	jmp	.LBB1_14
	.p2align	4, 0x90
.LBB1_7:                                #   in Loop: Header=BB1_2 Depth=1
	movl	%r13d, %eax
	andl	$96, %eax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_8:                                #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	(%r15,%rcx), %xmm0
	movups	16(%r15,%rcx), %xmm1
	xorps	(%rsp,%rcx), %xmm0
	xorps	16(%rsp,%rcx), %xmm1
	movups	%xmm0, (%r12,%rcx)
	movups	%xmm1, 16(%r12,%rcx)
	addq	$32, %rcx
	cmpq	%rcx, %rax
	jne	.LBB1_8
# %bb.9:                                #   in Loop: Header=BB1_2 Depth=1
	cmpq	%rax, %r13
	je	.LBB1_18
# %bb.10:                               #   in Loop: Header=BB1_2 Depth=1
	testb	$24, %r13b
	je	.LBB1_14
.LBB1_11:                               #   in Loop: Header=BB1_2 Depth=1
	movq	%rax, %rcx
	movl	%r13d, %eax
	andl	$120, %eax
	.p2align	4, 0x90
.LBB1_12:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rsp,%rcx), %rdx
	xorq	(%r15,%rcx), %rdx
	movq	%rdx, (%r12,%rcx)
	addq	$8, %rcx
	cmpq	%rcx, %rax
	jne	.LBB1_12
# %bb.13:                               #   in Loop: Header=BB1_2 Depth=1
	cmpq	%rax, %r13
	je	.LBB1_18
.LBB1_14:                               #   in Loop: Header=BB1_2 Depth=1
	movq	%rax, %rcx
	notq	%rcx
	addq	%r13, %rcx
	movq	%r13, %rdx
	andq	$3, %rdx
	je	.LBB1_16
	.p2align	4, 0x90
.LBB1_15:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rsp,%rax), %esi
	xorb	(%r15,%rax), %sil
	movb	%sil, (%r12,%rax)
	incq	%rax
	decq	%rdx
	jne	.LBB1_15
.LBB1_16:                               #   in Loop: Header=BB1_2 Depth=1
	cmpq	$3, %rcx
	jb	.LBB1_18
	.p2align	4, 0x90
.LBB1_17:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rsp,%rax), %ecx
	xorb	(%r15,%rax), %cl
	movb	%cl, (%r12,%rax)
	movzbl	1(%rsp,%rax), %ecx
	xorb	1(%r15,%rax), %cl
	movb	%cl, 1(%r12,%rax)
	movzbl	2(%rsp,%rax), %ecx
	xorb	2(%r15,%rax), %cl
	movb	%cl, 2(%r12,%rax)
	movzbl	3(%rsp,%rax), %ecx
	xorb	3(%r15,%rax), %cl
	movb	%cl, 3(%r12,%rax)
	addq	$4, %rax
	cmpq	%rax, %r13
	jne	.LBB1_17
	jmp	.LBB1_18
.LBB1_19:
	addq	$136, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end1:
	.size	CRYPTO_chacha_20, .Lfunc_end1-CRYPTO_chacha_20
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function chacha_core
	.type	chacha_core,@function
chacha_core:                            # @chacha_core
# %bb.0:
	movdqu	(%rsi), %xmm3
	movdqu	16(%rsi), %xmm2
	movdqu	32(%rsi), %xmm0
	movdqu	48(%rsi), %xmm1
	movl	$22, %eax
	.p2align	4, 0x90
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	paddd	%xmm2, %xmm3
	pxor	%xmm3, %xmm1
	movdqa	%xmm1, %xmm4
	psrld	$16, %xmm4
	pslld	$16, %xmm1
	por	%xmm4, %xmm1
	paddd	%xmm1, %xmm0
	pxor	%xmm0, %xmm2
	movdqa	%xmm2, %xmm4
	psrld	$20, %xmm4
	pslld	$12, %xmm2
	por	%xmm4, %xmm2
	paddd	%xmm2, %xmm3
	pxor	%xmm3, %xmm1
	movdqa	%xmm1, %xmm4
	psrld	$24, %xmm4
	pslld	$8, %xmm1
	por	%xmm4, %xmm1
	paddd	%xmm1, %xmm0
	pxor	%xmm0, %xmm2
	pshufd	$147, %xmm2, %xmm2              # xmm2 = xmm2[3,0,1,2]
	movdqa	%xmm2, %xmm4
	psrld	$25, %xmm4
	pslld	$7, %xmm2
	por	%xmm4, %xmm2
	pshufd	$78, %xmm3, %xmm4               # xmm4 = xmm3[2,3,0,1]
	paddd	%xmm2, %xmm4
	pshufd	$57, %xmm1, %xmm1               # xmm1 = xmm1[1,2,3,0]
	pxor	%xmm4, %xmm1
	movdqa	%xmm1, %xmm3
	psrld	$16, %xmm3
	pslld	$16, %xmm1
	por	%xmm3, %xmm1
	paddd	%xmm1, %xmm0
	pxor	%xmm0, %xmm2
	movdqa	%xmm2, %xmm3
	psrld	$20, %xmm3
	pslld	$12, %xmm2
	por	%xmm3, %xmm2
	paddd	%xmm2, %xmm4
	pxor	%xmm4, %xmm1
	movdqa	%xmm1, %xmm3
	psrld	$24, %xmm3
	pslld	$8, %xmm1
	por	%xmm3, %xmm1
	paddd	%xmm1, %xmm0
	pxor	%xmm0, %xmm2
	movdqa	%xmm2, %xmm3
	psrld	$25, %xmm3
	pslld	$7, %xmm2
	por	%xmm3, %xmm2
	pshufd	$57, %xmm2, %xmm2               # xmm2 = xmm2[1,2,3,0]
	pshufd	$147, %xmm1, %xmm1              # xmm1 = xmm1[3,0,1,2]
	pshufd	$78, %xmm4, %xmm3               # xmm3 = xmm4[2,3,0,1]
	addl	$-2, %eax
	cmpl	$2, %eax
	ja	.LBB2_1
# %bb.2:
	pshufd	$78, %xmm4, %xmm3               # xmm3 = xmm4[2,3,0,1]
	movdqu	(%rsi), %xmm4
	paddd	%xmm3, %xmm4
	movdqu	16(%rsi), %xmm3
	movdqu	32(%rsi), %xmm5
	movdqu	48(%rsi), %xmm6
	paddd	%xmm3, %xmm2
	paddd	%xmm5, %xmm0
	paddd	%xmm6, %xmm1
	movdqu	%xmm4, (%rdi)
	movdqu	%xmm2, 16(%rdi)
	movdqu	%xmm0, 32(%rdi)
	movdqu	%xmm1, 48(%rdi)
	retq
.Lfunc_end2:
	.size	chacha_core, .Lfunc_end2-chacha_core
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	xorl	%ebp, %ebp
	leaq	output(%rip), %rbx
	leaq	input(%rip), %r14
	leaq	key(%rip), %r15
	leaq	nonce(%rip), %r12
	.p2align	4, 0x90
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	movl	%ebp, %eax
	andl	$15, %eax
	movl	$1024, %edx                     # imm = 0x400
	subl	%eax, %edx
	movl	counter(%rip), %r9d
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r15, %rcx
	movq	%r12, %r8
	callq	CRYPTO_chacha_20
	incl	%ebp
	cmpl	$100, %ebp
	jne	.LBB3_1
# %bb.2:
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	key,@object                     # @key
	.section	.secsep.secret,"aw",@progbits
	.globl	key
	.p2align	4, 0x90
key:
	.ascii	"\230\276\361F\233\347&\2307\244[\373\311*Zj\307bP|\371dC\2773\271k\033\324\306\370\366"
	.size	key, 32

	.type	nonce,@object                   # @nonce
	.globl	nonce
nonce:
	.ascii	"D\347\222\32635\253\261X.\222S"
	.size	nonce, 12

	.type	counter,@object                 # @counter
	.globl	counter
	.p2align	2, 0x90
counter:
	.long	42                              # 0x2a
	.size	counter, 4

	.type	input,@object                   # @input
	.globl	input
	.p2align	4, 0x90
input:
	.ascii	"X(\32506,`U)\370\341\214\256\025\025&\362:s\240\363\022\243\210_+t#=\311\005#\306TI\036D\210\024\331\3327\025\334\267\344#\263\235~\026h5\374\002m\314\212\345\335_\344\322Vo\022\234\234}j8H\275\337\331\254\033\242M\305C\004<\327\231\341\247\023\234Q\302m\371\317\007;\344\277\223\243\251\264\305\360\032\344\215_\306\304|iz\336\032\301\311\317\302Nz%,2\351\027\272h\3617]b\204F\365\200\177\032q\367\276rK\270\034\376>\275\256\rs\r\207J1\303=Fo\263\327k\343\270p\027\216zj\016\277\250\274+\333\372O\266& \356c\360m&\254j\0307nY\201\321`\346@\325mh\272\213eJ\371\361\256V$\217\343\216\347~o\317\222\337\251u:\326.\034\257\362\326\2139\255\322]\373\327\337\005W\r\367\366\217-\024\260N\032<w\004\315<\\XR\020o\317\\\003\310_\205+\005\202`\332\314\315\326\210\277\300\020\263oTTB\274Kw!M\356\207E\006L`8\322~\0350lU\3608\200\034\336=\352h>\366>Y\317\r\b\256\214\002\013\301rj\264m\363\367\263\357:\261\006\362\364\326i{>\242\02611y\2663\251\312\212\250\276\363\3518(\321\341;N.G5\244a\024\036B,IU\352\343\263\3169\323\263\357JMxI\275\366|\n,\323&\313\331j\255c\223\247)\222\334\037\257a\202\200t\262\234J\206sP\330\321\377\356\032\342\335\242a\275\020\303_g\237)\344\323p\345g:\322 \000\314%\025\226TE\205\355\202\210;\237;\303\004\324#\261\r\334\310&\235(\263%MR\3453\363\355,\270\032\317\303R\264/\307y\226\024}r'r\205\352mA\240\"\023m\006\203\244\335\017i\322\001\315\306\270d\\,y\321\307\3231\333,\377\332\320i1\255\203_\355j\227\344\000C\260.\227\256\000_\\\271\3509\200\020\312\f\372\360\265\315\252'\021`\331!\206\223\221\237-\032\216\336\013\265\313\005$0EM\021u\375\345\240\251N:\214;RZ7\030\005Jz\tj\346\325\251\246qGLP\341>\212!+O\016\343\313r\305(>Z3\354H\222.\241$W\t\017\001\205;49~\307\220b\342\334]\n,Q&\225:\225\222\2459\217\f\203\013\2358\253\230*\304\001\304\rw\023\313\312\361(1Ru',\360\004\206\310\363=\362\235\217UR@?\252\"\177\347i;\356D\t\336\377\260i:\256t\351\2353\256\213m`\004\377S?\210\351c\233\261m,\"\025Z\025\331\345\313\003x<\312Y\214\310\302\206\377\322y\326\306\354[\273\240\256\001 \t.8]\332]\340YN\345\213\204\217\266\340V\237!\241\317\262\017,\223\370\3177\301\2372\230!eRfn\323q\230U\271F\237\0325\304GibpKw\236\344!\3462Z&\005\272WS\327\233U<\273Sy`\234\310M\367\365\035T\002\221h\016\252\312Zx\f(\232\303\254I\300\364\205\356Yv~(N\361\\c\367\316\016,!\240X\351\001\375\353\321\257\346\357\223\263\225Q`\242t@\025\345\364\n\312m\2327BMZXI\017\351\002\374w\330Y\336\335\255K\231.ds\255B/\363,\rI\344.l\244su\030\024\205\273d\264\241\260n\001\300\317\027\234\305(\303-l\027*=\006\\\363\264Iu\255\027i\324\312e\256Dq\245\366\r\017\2167\307C\316k\b\351\3214H\217\311\374\363]-\354b\323\360\263\376.@UvT\307\264a\026\314|\034\031$\346M\324\303wg\037<ty\241\370\205\210\035o\244~,!\237I\365\252N\363J\372\235\276\366\316\332\265\2539\275\026A\251J\254\t\001\312"
	.size	input, 1024

	.type	output,@object                  # @output
	.globl	output
	.p2align	4, 0x90
output:
	.zero	1024
	.size	output, 1024

	.ident	"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"
	.section	".note.GNU-stack","",@progbits

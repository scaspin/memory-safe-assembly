	.text
	.file	"bench_salsa20.c"
	.globl	salsa20_words                   # -- Begin function salsa20_words
	.p2align	4, 0x90
	.type	salsa20_words,@function
salsa20_words:                          # @salsa20_words
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -64(%rsp)                 # 8-byte Spill
	movl	(%rsi), %r12d
	movl	4(%rsi), %r11d
	movl	8(%rsi), %r9d
	movl	12(%rsi), %eax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movl	16(%rsi), %eax
	movl	20(%rsi), %r15d
	movl	24(%rsi), %r10d
	movl	28(%rsi), %ecx
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movl	32(%rsi), %edi
	movl	36(%rsi), %edx
	movl	40(%rsi), %r14d
	movl	44(%rsi), %r8d
	movl	48(%rsi), %ecx
	movl	52(%rsi), %r13d
	movl	56(%rsi), %ebp
	movq	%rsi, -72(%rsp)                 # 8-byte Spill
	movl	60(%rsi), %ebx
	movl	$10, -76(%rsp)                  # 4-byte Folded Spill
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	leal	(%r12,%rcx), %esi
	roll	$7, %esi
	xorl	%eax, %esi
	movq	%rsi, -32(%rsp)                 # 8-byte Spill
	leal	(%rsi,%r12), %eax
	roll	$9, %eax
	xorl	%edi, %eax
	movq	%rax, %rdi
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	addl	%esi, %eax
	roll	$13, %eax
	xorl	%ecx, %eax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	addl	%edi, %eax
	roll	$18, %eax
	xorl	%r12d, %eax
	leal	(%r15,%r11), %ecx
	roll	$7, %ecx
	xorl	%edx, %ecx
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	leal	(%rcx,%r15), %edx
	roll	$9, %edx
	xorl	%r13d, %edx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	leal	(%rdx,%rcx), %esi
	roll	$13, %esi
	xorl	%r11d, %esi
	leal	(%rsi,%rdx), %ecx
	roll	$18, %ecx
	xorl	%r15d, %ecx
	leal	(%r14,%r10), %edx
	roll	$7, %edx
	xorl	%ebp, %edx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	leal	(%rdx,%r14), %r15d
	roll	$9, %r15d
	xorl	%r9d, %r15d
	leal	(%r15,%rdx), %edi
	roll	$13, %edi
	xorl	%r10d, %edi
	leal	(%rdi,%r15), %r13d
	roll	$18, %r13d
	xorl	%r14d, %r13d
	leal	(%rbx,%r8), %r10d
	roll	$7, %r10d
	xorl	-88(%rsp), %r10d                # 4-byte Folded Reload
	leal	(%r10,%rbx), %ebp
	roll	$9, %ebp
	xorl	-96(%rsp), %ebp                 # 4-byte Folded Reload
	leal	(%r10,%rbp), %r14d
	roll	$13, %r14d
	xorl	%r8d, %r14d
	leal	(%r14,%rbp), %edx
	roll	$18, %edx
	xorl	%ebx, %edx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	leal	(%r10,%rax), %r11d
	roll	$7, %r11d
	xorl	%esi, %r11d
	leal	(%r11,%rax), %r9d
	roll	$9, %r9d
	xorl	%r15d, %r9d
	leal	(%r9,%r11), %edx
	roll	$13, %edx
	xorl	%r10d, %edx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	leal	(%rdx,%r9), %r12d
	roll	$18, %r12d
	xorl	%eax, %r12d
	movq	-32(%rsp), %r8                  # 8-byte Reload
	leal	(%rcx,%r8), %r10d
	roll	$7, %r10d
	xorl	%edi, %r10d
	leal	(%r10,%rcx), %edx
	roll	$9, %edx
	xorl	%ebp, %edx
	leal	(%rdx,%r10), %eax
	roll	$13, %eax
	xorl	%r8d, %eax
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	leal	(%rax,%rdx), %r15d
	roll	$18, %r15d
	xorl	%ecx, %r15d
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	leal	(%rcx,%r13), %r8d
	roll	$7, %r8d
	xorl	%r14d, %r8d
	leal	(%r8,%r13), %edi
	roll	$9, %edi
	xorl	-16(%rsp), %edi                 # 4-byte Folded Reload
	leal	(%rdi,%r8), %edx
	roll	$13, %edx
	xorl	%ecx, %edx
	leal	(%rdx,%rdi), %r14d
	roll	$18, %r14d
	xorl	%r13d, %r14d
	movq	-48(%rsp), %rbx                 # 8-byte Reload
	movq	-56(%rsp), %rsi                 # 8-byte Reload
	leal	(%rsi,%rbx), %ecx
	roll	$7, %ecx
	xorl	-8(%rsp), %ecx                  # 4-byte Folded Reload
	leal	(%rcx,%rsi), %r13d
	roll	$9, %r13d
	xorl	-24(%rsp), %r13d                # 4-byte Folded Reload
	leal	(%rcx,%r13), %ebp
	roll	$13, %ebp
	xorl	%ebx, %ebp
	leal	(%rbp,%r13), %ebx
	roll	$18, %ebx
	xorl	%esi, %ebx
	decl	-76(%rsp)                       # 4-byte Folded Spill
	jne	.LBB0_1
# %bb.2:
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	addl	(%rsi), %r12d
	movq	-64(%rsp), %rsi                 # 8-byte Reload
	movl	%r12d, (%rsi)
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	addl	4(%rsi), %r11d
	movq	-64(%rsp), %r12                 # 8-byte Reload
	movl	%r11d, 4(%r12)
	addl	8(%rsi), %r9d
	movl	%r9d, 8(%r12)
	movq	-88(%rsp), %r9                  # 8-byte Reload
	addl	12(%rsi), %r9d
	movl	%r9d, 12(%r12)
	addl	16(%rsi), %eax
	movl	%eax, 16(%r12)
	addl	20(%rsi), %r15d
	movl	%r15d, 20(%r12)
	addl	24(%rsi), %r10d
	movl	%r10d, 24(%r12)
	movq	-96(%rsp), %rax                 # 8-byte Reload
	addl	28(%rsi), %eax
	movl	%eax, 28(%r12)
	addl	32(%rsi), %edi
	movl	%edi, 32(%r12)
	addl	36(%rsi), %edx
	movl	%edx, 36(%r12)
	addl	40(%rsi), %r14d
	movl	%r14d, 40(%r12)
	addl	44(%rsi), %r8d
	movl	%r8d, 44(%r12)
	addl	48(%rsi), %ecx
	movl	%ecx, 48(%r12)
	addl	52(%rsi), %r13d
	movl	%r13d, 52(%r12)
	addl	56(%rsi), %ebp
	movl	%ebp, 56(%r12)
	addl	60(%rsi), %ebx
	movl	%ebx, 60(%r12)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end0:
	.size	salsa20_words, .Lfunc_end0-salsa20_words
                                        # -- End function
	.globl	salsa20_block                   # -- Begin function salsa20_block
	.p2align	4, 0x90
	.type	salsa20_block,@function
salsa20_block:                          # @salsa20_block
# %bb.0:
	pushq	%rbx
	subq	$128, %rsp
	movq	%rdi, %rbx
	movl	$1634760805, (%rsp)             # imm = 0x61707865
	movups	(%rsi), %xmm0
	movups	%xmm0, 4(%rsp)
	movl	$857760878, 20(%rsp)            # imm = 0x3320646E
	movl	%edx, 24(%rsp)
	shrq	$32, %rdx
	movl	%edx, 28(%rsp)
	movl	%ecx, 32(%rsp)
	shrq	$32, %rcx
	movl	%ecx, 36(%rsp)
	movl	$2036477234, 40(%rsp)           # imm = 0x79622D32
	movups	16(%rsi), %xmm0
	movups	%xmm0, 44(%rsp)
	movl	$1797285236, 60(%rsp)           # imm = 0x6B206574
	leaq	64(%rsp), %rdi
	movq	%rsp, %rsi
	callq	salsa20_words
	movl	$8, %eax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movl	%edx, %esi
	andl	$-4, %esi
	movl	64(%rsp,%rsi), %edi
	leal	-8(%rax), %ecx
	andb	$16, %cl
                                        # kill: def $cl killed $cl killed $ecx
	shrl	%cl, %edi
	movb	%dil, (%rbx,%rdx)
	movl	64(%rsp,%rsi), %esi
	movl	%eax, %ecx
	andb	$24, %cl
	shrl	%cl, %esi
	movb	%sil, 1(%rbx,%rdx)
	addq	$2, %rdx
	addl	$16, %eax
	cmpq	$64, %rdx
	jne	.LBB1_1
# %bb.2:
	addq	$128, %rsp
	popq	%rbx
	retq
.Lfunc_end1:
	.size	salsa20_block, .Lfunc_end1-salsa20_block
                                        # -- End function
	.globl	salsa20                         # -- Begin function salsa20
	.p2align	4, 0x90
	.type	salsa20,@function
salsa20:                                # @salsa20
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$200, %rsp
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm0, 96(%rsp)
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm0, 64(%rsp)
	testq	%rsi, %rsi
	je	.LBB2_6
# %bb.1:
	movq	%rcx, %r13
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movq	%rcx, %rbx
	shrq	$32, %rbx
	xorl	%ebp, %ebp
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_5:                                #   in Loop: Header=BB2_2 Depth=1
	movl	%ebp, %eax
	andl	$63, %eax
	movzbl	64(%rsp,%rax), %eax
	xorb	%al, (%r12,%rbp)
	incq	%rbp
	cmpq	%r15, %rbp
	je	.LBB2_6
.LBB2_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_4 Depth 2
	testb	$63, %bpl
	jne	.LBB2_5
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	movl	%ebp, %eax
	shrl	$6, %eax
	movl	$1634760805, (%rsp)             # imm = 0x61707865
	movups	(%r14), %xmm0
	movups	%xmm0, 4(%rsp)
	movl	$857760878, 20(%rsp)            # imm = 0x3320646E
	movl	%r13d, 24(%rsp)
	movl	%ebx, 28(%rsp)
	movl	%eax, 32(%rsp)
	movabsq	$8746603119078539264, %rax      # imm = 0x79622D3200000000
	movq	%rax, 36(%rsp)
	movups	16(%r14), %xmm0
	movups	%xmm0, 44(%rsp)
	movl	$1797285236, 60(%rsp)           # imm = 0x6B206574
	leaq	128(%rsp), %rdi
	movq	%rsp, %rsi
	callq	salsa20_words
	movl	$8, %eax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_4:                                #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%edx, %ecx
	andl	$-4, %ecx
	movl	128(%rsp,%rcx), %esi
	leal	-8(%rax), %ecx
	andb	$16, %cl
	movl	%esi, %edi
                                        # kill: def $cl killed $cl killed $ecx
	shrl	%cl, %edi
	movb	%dil, 64(%rsp,%rdx)
	movl	%eax, %ecx
	andb	$24, %cl
	shrl	%cl, %esi
	movb	%sil, 65(%rsp,%rdx)
	addq	$2, %rdx
	addl	$16, %eax
	cmpq	$64, %rdx
	jne	.LBB2_4
	jmp	.LBB2_5
.LBB2_6:
	addq	$200, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end2:
	.size	salsa20, .Lfunc_end2-salsa20
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	xorl	%ebp, %ebp
	movq	nonce(%rip), %rbx
	leaq	msg(%rip), %r14
	leaq	key(%rip), %r15
	.p2align	4, 0x90
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	movl	%ebp, %eax
	andl	$15, %eax
	movl	$128, %esi
	subl	%eax, %esi
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %rcx
	callq	salsa20
	incl	%ebp
	cmpl	$100, %ebp
	jne	.LBB3_1
# %bb.2:
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
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
	.ascii	"\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b"
	.size	key, 32

	.type	nonce,@object                   # @nonce
	.globl	nonce
	.p2align	3, 0x90
nonce:
	.quad	0                               # 0x0
	.size	nonce, 8

	.type	msg,@object                     # @msg
	.globl	msg
	.p2align	4, 0x90
msg:
	.ascii	"\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b\b\001\002\003\004\005\006\007\007\006\005\004\003\002\001\b"
	.size	msg, 128

	.ident	"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"
	.section	".note.GNU-stack","",@progbits

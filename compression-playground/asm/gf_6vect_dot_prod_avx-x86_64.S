	.text
gf_6vect_dot_prod_avx:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x10, %rdi
jl	gf_6vect_dot_prod_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm15
movq	%rsi, %r14
imulq	$0x20, %r14, %r14
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	(%r8), %r13
movq	0x8(%r8), %r12
gf_6vect_dot_prod_avx.loop16:
movq	%rdx, %r11
xorq	%r10, %r10
vpxor	%xmm2, %xmm2, %xmm2
vpxor	%xmm3, %xmm3, %xmm3
vpxor	%xmm4, %xmm4, %xmm4
vpxor	%xmm5, %xmm5, %xmm5
vpxor	%xmm6, %xmm6, %xmm6
vpxor	%xmm7, %xmm7, %xmm7
gf_6vect_dot_prod_avx.next_vect:
movq	(%rcx,%r10), %r9
addq	$0x8, %r10
vmovdqu	(%r9,%rax), %xmm0
vmovdqu	(%r11), %xmm14
vmovdqu	0x10(%r11), %xmm13
vmovdqu	(%r11,%r14), %xmm12
vmovdqu	0x10(%r11,%r14), %xmm11
vmovdqu	(%r11,%r14,2), %xmm10
vmovdqu	0x10(%r11,%r14,2), %xmm9
leaq	(%r14,%r14,4), %r9
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm13, %xmm13
vpshufb	%xmm1, %xmm14, %xmm14
vpxor	%xmm14, %xmm13, %xmm13
vpxor	%xmm13, %xmm2, %xmm2
vpshufb	%xmm0, %xmm11, %xmm11
vpshufb	%xmm1, %xmm12, %xmm12
vpxor	%xmm12, %xmm11, %xmm11
vpxor	%xmm11, %xmm3, %xmm3
vpshufb	%xmm0, %xmm9, %xmm9
vpshufb	%xmm1, %xmm10, %xmm10
vpxor	%xmm10, %xmm9, %xmm9
vpxor	%xmm9, %xmm4, %xmm4
vmovdqu	(%r11,%r15), %xmm14
vmovdqu	0x10(%r11,%r15), %xmm13
vmovdqu	(%r11,%r14,4), %xmm12
vmovdqu	0x10(%r11,%r14,4), %xmm11
vmovdqu	(%r11,%r9), %xmm10
vmovdqu	0x10(%r11,%r9), %xmm9
addq	$0x20, %r11
vpshufb	%xmm0, %xmm13, %xmm13
vpshufb	%xmm1, %xmm14, %xmm14
vpxor	%xmm14, %xmm13, %xmm13
vpxor	%xmm13, %xmm5, %xmm5
vpshufb	%xmm0, %xmm11, %xmm11
vpshufb	%xmm1, %xmm12, %xmm12
vpxor	%xmm12, %xmm11, %xmm11
vpxor	%xmm11, %xmm6, %xmm6
vpshufb	%xmm0, %xmm9, %xmm9
vpshufb	%xmm1, %xmm10, %xmm10
vpxor	%xmm10, %xmm9, %xmm9
vpxor	%xmm9, %xmm7, %xmm7
cmpq	%rsi, %r10
jl	gf_6vect_dot_prod_avx.next_vect
movq	0x10(%r8), %r11
movq	0x18(%r8), %r9
movq	0x20(%r8), %r10
vmovdqu	%xmm2, (%r13,%rax)
vmovdqu	%xmm3, (%r12,%rax)
vmovdqu	%xmm4, (%r11,%rax)
movq	0x28(%r8), %r11
vmovdqu	%xmm5, (%r9,%rax)
vmovdqu	%xmm6, (%r10,%rax)
vmovdqu	%xmm7, (%r11,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_6vect_dot_prod_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_6vect_dot_prod_avx.return_pass
movq	%rdi, %rax
jmp	gf_6vect_dot_prod_avx.loop16
gf_6vect_dot_prod_avx.return_pass:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_6vect_dot_prod_avx.return_fail:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x1, %eax
retq
	.section .data
	.p2align 4
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

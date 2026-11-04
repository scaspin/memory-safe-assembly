	.text
gf_4vect_dot_prod_avx:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x10, %rdi
jl	gf_4vect_dot_prod_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm14
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	(%r8), %r8
gf_4vect_dot_prod_avx.loop16:
vpxor	%xmm2, %xmm2, %xmm2
vpxor	%xmm3, %xmm3, %xmm3
vpxor	%xmm4, %xmm4, %xmm4
vpxor	%xmm5, %xmm5, %xmm5
movq	%rdx, %r11
xorq	%r10, %r10
gf_4vect_dot_prod_avx.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r11), %xmm13
vmovdqu	0x10(%r11), %xmm12
vmovdqu	(%r11,%rsi,4), %xmm11
vmovdqu	0x10(%r11,%rsi,4), %xmm10
vmovdqu	(%r11,%rsi,8), %xmm9
vmovdqu	0x10(%r11,%rsi,8), %xmm8
vmovdqu	(%r11,%r15), %xmm7
vmovdqu	0x10(%r11,%r15), %xmm6
vmovdqu	(%r9,%rax), %xmm0
addq	$0x20, %r11
addq	$0x8, %r10
vpand	%xmm14, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm14, %xmm0, %xmm0
vpshufb	%xmm0, %xmm12, %xmm12
vpshufb	%xmm1, %xmm13, %xmm13
vpxor	%xmm13, %xmm12, %xmm12
vpxor	%xmm12, %xmm2, %xmm2
vpshufb	%xmm0, %xmm10, %xmm10
vpshufb	%xmm1, %xmm11, %xmm11
vpxor	%xmm11, %xmm10, %xmm10
vpxor	%xmm10, %xmm3, %xmm3
vpshufb	%xmm0, %xmm8, %xmm8
vpshufb	%xmm1, %xmm9, %xmm9
vpxor	%xmm9, %xmm8, %xmm8
vpxor	%xmm8, %xmm4, %xmm4
vpshufb	%xmm0, %xmm6, %xmm6
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm5, %xmm5
cmpq	%rsi, %r10
jl	gf_4vect_dot_prod_avx.next_vect
vmovdqu	%xmm2, (%r8,%rax)
vmovdqu	%xmm3, (%r13,%rax)
vmovdqu	%xmm4, (%r12,%rax)
vmovdqu	%xmm5, (%r14,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_4vect_dot_prod_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_dot_prod_avx.return_pass
movq	%rdi, %rax
jmp	gf_4vect_dot_prod_avx.loop16
gf_4vect_dot_prod_avx.return_pass:
movl	$0x0, %eax
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq
gf_4vect_dot_prod_avx.return_fail:
movl	$0x1, %eax
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

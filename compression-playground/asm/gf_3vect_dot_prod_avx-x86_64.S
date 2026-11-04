	.text
gf_3vect_dot_prod_avx:
endbr64
pushq	%r12
pushq	%r13
subq	$0x10, %rdi
jl	gf_3vect_dot_prod_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm11
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	(%r8), %r8
gf_3vect_dot_prod_avx.loop16:
vpxor	%xmm2, %xmm2, %xmm2
vpxor	%xmm3, %xmm3, %xmm3
vpxor	%xmm4, %xmm4, %xmm4
movq	%rdx, %r11
xorq	%r10, %r10
gf_3vect_dot_prod_avx.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r11), %xmm10
vmovdqu	0x10(%r11), %xmm9
vmovdqu	(%r11,%rsi,4), %xmm8
vmovdqu	0x10(%r11,%rsi,4), %xmm7
vmovdqu	(%r11,%rsi,8), %xmm6
vmovdqu	0x10(%r11,%rsi,8), %xmm5
addq	$0x20, %r11
addq	$0x8, %r10
vmovdqu	(%r9,%rax), %xmm0
vpand	%xmm11, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm11, %xmm0, %xmm0
vpshufb	%xmm0, %xmm9, %xmm9
vpshufb	%xmm1, %xmm10, %xmm10
vpxor	%xmm10, %xmm9, %xmm9
vpxor	%xmm9, %xmm2, %xmm2
vpshufb	%xmm0, %xmm7, %xmm7
vpshufb	%xmm1, %xmm8, %xmm8
vpxor	%xmm8, %xmm7, %xmm7
vpxor	%xmm7, %xmm3, %xmm3
vpshufb	%xmm0, %xmm5, %xmm5
vpshufb	%xmm1, %xmm6, %xmm6
vpxor	%xmm6, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
cmpq	%rsi, %r10
jl	gf_3vect_dot_prod_avx.next_vect
vmovdqu	%xmm2, (%r8,%rax)
vmovdqu	%xmm3, (%r13,%rax)
vmovdqu	%xmm4, (%r12,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_3vect_dot_prod_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_3vect_dot_prod_avx.return_pass
movq	%rdi, %rax
jmp	gf_3vect_dot_prod_avx.loop16
gf_3vect_dot_prod_avx.return_pass:
movl	$0x0, %eax
popq	%r13
popq	%r12
retq
gf_3vect_dot_prod_avx.return_fail:
movl	$0x1, %eax
popq	%r13
popq	%r12
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

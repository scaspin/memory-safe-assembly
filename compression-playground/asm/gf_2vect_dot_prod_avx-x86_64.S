	.text
gf_2vect_dot_prod_avx:
endbr64
pushq	%r12
subq	$0x10, %rdi
jl	gf_2vect_dot_prod_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm8
shlq	$0x3, %rsi
movq	0x8(%r8), %r12
movq	(%r8), %r8
gf_2vect_dot_prod_avx.loop16:
vpxor	%xmm2, %xmm2, %xmm2
vpxor	%xmm3, %xmm3, %xmm3
movq	%rdx, %r11
xorq	%r10, %r10
gf_2vect_dot_prod_avx.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r11), %xmm7
vmovdqu	0x10(%r11), %xmm6
vmovdqu	(%r11,%rsi,4), %xmm5
vmovdqu	0x10(%r11,%rsi,4), %xmm4
addq	$0x20, %r11
addq	$0x8, %r10
vmovdqu	(%r9,%rax), %xmm0
vpand	%xmm8, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm8, %xmm0, %xmm0
vpshufb	%xmm0, %xmm6, %xmm6
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm2, %xmm2
vpshufb	%xmm0, %xmm4, %xmm4
vpshufb	%xmm1, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
cmpq	%rsi, %r10
jl	gf_2vect_dot_prod_avx.next_vect
vmovdqu	%xmm2, (%r8,%rax)
vmovdqu	%xmm3, (%r12,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_2vect_dot_prod_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_dot_prod_avx.return_pass
movq	%rdi, %rax
jmp	gf_2vect_dot_prod_avx.loop16
gf_2vect_dot_prod_avx.return_pass:
movl	$0x0, %eax
popq	%r12
retq
gf_2vect_dot_prod_avx.return_fail:
movl	$0x1, %eax
popq	%r12
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

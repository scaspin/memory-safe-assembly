	.text
gf_vect_dot_prod_avx:
endbr64
subq	$0x10, %rdi
jl	gf_vect_dot_prod_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm5
gf_vect_dot_prod_avx.loop16:
vpxor	%xmm2, %xmm2, %xmm2
movq	%rdx, %r11
xorq	%r10, %r10
gf_vect_dot_prod_avx.next_vect:
movq	(%rcx,%r10,8), %r9
vmovdqu	(%r11), %xmm4
vmovdqu	0x10(%r11), %xmm3
vmovdqu	(%r9,%rax), %xmm0
addq	$0x20, %r11
addq	$0x1, %r10
vpand	%xmm5, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm5, %xmm0, %xmm0
vpshufb	%xmm0, %xmm3, %xmm3
vpshufb	%xmm1, %xmm4, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
cmpq	%rsi, %r10
jl	gf_vect_dot_prod_avx.next_vect
vmovdqu	%xmm2, (%r8,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_vect_dot_prod_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_dot_prod_avx.return_pass
movq	%rdi, %rax
jmp	gf_vect_dot_prod_avx.loop16
gf_vect_dot_prod_avx.return_pass:
movl	$0x0, %eax
retq
gf_vect_dot_prod_avx.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

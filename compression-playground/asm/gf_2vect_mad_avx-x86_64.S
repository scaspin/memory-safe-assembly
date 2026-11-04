	.text
gf_2vect_mad_avx:
endbr64
subq	$0x10, %rdi
jl	gf_2vect_mad_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm14
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vmovdqu	(%r11), %xmm13
vmovdqu	0x10(%r11), %xmm12
vmovdqu	(%r11,%rsi), %xmm11
vmovdqu	0x10(%r11,%rsi), %xmm10
movq	0x8(%r9), %r10
movq	(%r9), %r9
vmovdqu	(%r9,%rdi), %xmm8
vmovdqu	(%r10,%rdi), %xmm9
gf_2vect_mad_avx.loop16:
vmovdqu	(%r9,%rax), %xmm6
vmovdqu	(%r10,%rax), %xmm7
gf_2vect_mad_avx.loop16_overlap:
vmovdqu	(%r8,%rax), %xmm0
vpand	%xmm14, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm14, %xmm0, %xmm0
vpshufb	%xmm0, %xmm12, %xmm2
vpshufb	%xmm1, %xmm13, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm6, %xmm6
vpshufb	%xmm0, %xmm10, %xmm4
vpshufb	%xmm1, %xmm11, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm7, %xmm7
vmovdqu	%xmm6, (%r9,%rax)
vmovdqu	%xmm7, (%r10,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_2vect_mad_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_mad_avx.return_pass
movq	%rdi, %rax
vmovdqa	%xmm8, %xmm6
vmovdqa	%xmm9, %xmm7
jmp	gf_2vect_mad_avx.loop16_overlap
gf_2vect_mad_avx.return_pass:
movl	$0x0, %eax
retq
gf_2vect_mad_avx.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

	.text
gf_vect_mad_avx:
endbr64
subq	$0x10, %rdi
jl	gf_vect_mad_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm8
shlq	$0x5, %rdx
vmovdqu	(%rdx,%rcx), %xmm7
vmovdqu	0x10(%rdx,%rcx), %xmm6
vmovdqu	(%r9,%rdi), %xmm5
gf_vect_mad_avx.loop16:
vmovdqu	(%r9,%rax), %xmm4
gf_vect_mad_avx.loop16_overlap:
vmovdqu	(%r8,%rax), %xmm0
vpand	%xmm8, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm8, %xmm0, %xmm0
vpshufb	%xmm0, %xmm6, %xmm2
vpshufb	%xmm1, %xmm7, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm4, %xmm4
vmovdqu	%xmm4, (%r9,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_vect_mad_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_mad_avx.return_pass
movq	%rdi, %rax
vmovdqa	%xmm5, %xmm4
jmp	gf_vect_mad_avx.loop16_overlap
gf_vect_mad_avx.return_pass:
movl	$0x0, %eax
retq
gf_vect_mad_avx.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

	.text
gf_3vect_mad_avx:
endbr64
subq	$0x10, %rdi
jl	gf_3vect_mad_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm15
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vmovdqu	(%r11), %xmm14
vmovdqu	0x10(%r11), %xmm13
vmovdqu	(%r11,%rsi), %xmm12
vmovdqu	0x10(%r11,%rsi), %xmm11
vmovdqu	(%r11,%rsi,2), %xmm10
vmovdqu	0x10(%r11,%rsi,2), %xmm9
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	(%r9), %r9
gf_3vect_mad_avx.loop16:
vmovdqu	(%r8,%rax), %xmm0
vmovdqu	(%r9,%rax), %xmm8
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm13, %xmm2
vpshufb	%xmm1, %xmm14, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm8, %xmm8
vmovdqu	(%rcx,%rax), %xmm3
vmovdqu	(%rdx,%rax), %xmm2
vpshufb	%xmm0, %xmm11, %xmm4
vpshufb	%xmm1, %xmm12, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
vpshufb	%xmm0, %xmm9, %xmm6
vpshufb	%xmm1, %xmm10, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm2, %xmm2
vmovdqu	%xmm8, (%r9,%rax)
vmovdqu	%xmm3, (%rcx,%rax)
vmovdqu	%xmm2, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_3vect_mad_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_3vect_mad_avx.return_pass
gf_3vect_mad_avx.lessthan16:
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %xmm0
vmovdqu	(%r9,%r11), %xmm8
vmovdqu	(%rcx,%r11), %xmm3
vmovdqu	(%rdx,%r11), %xmm2
subq	%rax, %rdi
vmovdqa	constip16(%rip), %xmm6
vpinsrb	$0xf, %edi, %xmm7, %xmm7
vpshufb	%xmm15, %xmm7, %xmm7
vpcmpgtb	%xmm6, %xmm7, %xmm7
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm13, %xmm13
vpshufb	%xmm1, %xmm14, %xmm14
vpxor	%xmm14, %xmm13, %xmm13
vpand	%xmm7, %xmm13, %xmm13
vpxor	%xmm13, %xmm8, %xmm8
vpshufb	%xmm0, %xmm11, %xmm11
vpshufb	%xmm1, %xmm12, %xmm12
vpxor	%xmm12, %xmm11, %xmm11
vpand	%xmm7, %xmm11, %xmm11
vpxor	%xmm11, %xmm3, %xmm3
vpshufb	%xmm0, %xmm9, %xmm9
vpshufb	%xmm1, %xmm10, %xmm10
vpxor	%xmm10, %xmm9, %xmm9
vpand	%xmm7, %xmm9, %xmm9
vpxor	%xmm9, %xmm2, %xmm2
vmovdqu	%xmm8, (%r9,%r11)
vmovdqu	%xmm3, (%rcx,%r11)
vmovdqu	%xmm2, (%rdx,%r11)
gf_3vect_mad_avx.return_pass:
movl	$0x0, %eax
retq
gf_3vect_mad_avx.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

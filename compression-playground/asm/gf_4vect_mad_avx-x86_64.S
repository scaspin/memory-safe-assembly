	.text
gf_4vect_mad_avx:
endbr64
pushq	%r12
subq	$0x10, %rdi
jl	gf_4vect_mad_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm15
movq	%rsi, %r11
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r12
shlq	$0x6, %r11
vmovdqu	0x10(%r12,%r11), %xmm14
shlq	$0x5, %rsi
addq	%rsi, %r11
vmovdqu	(%r12,%r11), %xmm12
vmovdqu	0x10(%r12,%r11), %xmm13
movq	0x8(%r9), %rcx
movq	0x10(%r9), %r10
movq	0x18(%r9), %rdx
movq	(%r9), %r9
gf_4vect_mad_avx.loop16:
vmovdqu	(%r8,%rax), %xmm0
vmovdqu	0x10(%r12), %xmm2
vmovdqu	(%r12), %xmm3
vmovdqu	0x10(%r12,%rsi), %xmm4
vmovdqu	(%r12,%rsi), %xmm5
vmovdqu	(%r12,%rsi,2), %xmm7
vmovdqu	(%r9,%rax), %xmm10
vmovdqu	(%rcx,%rax), %xmm11
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm2, %xmm2
vpshufb	%xmm1, %xmm3, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm10, %xmm10
vmovdqu	(%r10,%rax), %xmm2
vmovdqu	(%rdx,%rax), %xmm3
vpshufb	%xmm0, %xmm4, %xmm4
vpshufb	%xmm1, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm11, %xmm11
vpshufb	%xmm0, %xmm14, %xmm6
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm2, %xmm2
vpshufb	%xmm0, %xmm13, %xmm8
vpshufb	%xmm1, %xmm12, %xmm9
vpxor	%xmm9, %xmm8, %xmm8
vpxor	%xmm8, %xmm3, %xmm3
vmovdqu	%xmm10, (%r9,%rax)
vmovdqu	%xmm11, (%rcx,%rax)
vmovdqu	%xmm2, (%r10,%rax)
vmovdqu	%xmm3, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_4vect_mad_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_mad_avx.return_pass
gf_4vect_mad_avx.lessthan16:
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %xmm0
vmovdqu	0x10(%r12), %xmm2
vmovdqu	(%r12), %xmm3
vmovdqu	0x10(%r12,%rsi), %xmm4
vmovdqu	(%r12,%rsi), %xmm5
vmovdqu	(%r12,%rsi,2), %xmm7
vmovdqu	(%r9,%r11), %xmm10
vmovdqu	(%rcx,%r11), %xmm11
vmovdqu	(%r10,%r11), %xmm8
subq	%rax, %rdi
vmovdqa	constip16(%rip), %xmm9
vpinsrb	$0xf, %edi, %xmm6, %xmm6
vpshufb	%xmm15, %xmm6, %xmm6
vpcmpgtb	%xmm9, %xmm6, %xmm6
vmovdqu	(%rdx,%r11), %xmm9
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm2, %xmm2
vpshufb	%xmm1, %xmm3, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpand	%xmm6, %xmm2, %xmm2
vpxor	%xmm2, %xmm10, %xmm10
vpshufb	%xmm0, %xmm4, %xmm4
vpshufb	%xmm1, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpand	%xmm6, %xmm4, %xmm4
vpxor	%xmm4, %xmm11, %xmm11
vpshufb	%xmm0, %xmm14, %xmm14
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm14, %xmm14
vpand	%xmm6, %xmm14, %xmm14
vpxor	%xmm14, %xmm8, %xmm8
vpshufb	%xmm0, %xmm13, %xmm13
vpshufb	%xmm1, %xmm12, %xmm12
vpxor	%xmm12, %xmm13, %xmm13
vpand	%xmm6, %xmm13, %xmm13
vpxor	%xmm13, %xmm9, %xmm9
vmovdqu	%xmm10, (%r9,%r11)
vmovdqu	%xmm11, (%rcx,%r11)
vmovdqu	%xmm8, (%r10,%r11)
vmovdqu	%xmm9, (%rdx,%r11)
gf_4vect_mad_avx.return_pass:
movl	$0x0, %eax
popq	%r12
retq
gf_4vect_mad_avx.return_fail:
movl	$0x1, %eax
popq	%r12
retq
	.section .data
	.p2align 4
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

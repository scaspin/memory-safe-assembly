	.text
gf_5vect_mad_avx:
endbr64
pushq	%r12
pushq	%r13
subq	$0x10, %rdi
jl	gf_5vect_mad_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm15
movq	%rsi, %r11
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r12
shlq	$0x6, %r11
vmovdqu	0x10(%r12,%r11,2), %xmm14
shlq	$0x5, %rsi
addq	%rsi, %r11
vmovdqu	0x10(%r12,%r11), %xmm12
vmovdqu	(%r12,%r11), %xmm13
movq	0x10(%r9), %rcx
movq	0x18(%r9), %r10
movq	0x20(%r9), %rdx
movq	0x8(%r9), %r13
movq	(%r9), %r9
gf_5vect_mad_avx.loop16:
vmovdqu	(%r8,%rax), %xmm0
vmovdqu	0x10(%r12), %xmm2
vmovdqu	(%r12), %xmm3
vmovdqu	0x10(%r12,%rsi), %xmm4
vmovdqu	(%r12,%rsi), %xmm5
vmovdqu	0x10(%r12,%rsi,2), %xmm6
vmovdqu	(%r12,%rsi,2), %xmm7
vmovdqu	(%r12,%rsi,4), %xmm9
vmovdqu	(%r9,%rax), %xmm10
vmovdqu	(%r13,%rax), %xmm11
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm2, %xmm2
vpshufb	%xmm1, %xmm3, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm10, %xmm10
vmovdqu	(%rcx,%rax), %xmm3
vmovdqu	(%r10,%rax), %xmm2
vpshufb	%xmm0, %xmm4, %xmm4
vpshufb	%xmm1, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm11, %xmm11
vmovdqu	(%rdx,%rax), %xmm5
vpshufb	%xmm0, %xmm6, %xmm6
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm3, %xmm3
vpshufb	%xmm0, %xmm12, %xmm4
vpshufb	%xmm1, %xmm13, %xmm7
vpxor	%xmm7, %xmm4, %xmm4
vpxor	%xmm4, %xmm2, %xmm2
vpshufb	%xmm0, %xmm14, %xmm8
vpshufb	%xmm1, %xmm9, %xmm9
vpxor	%xmm9, %xmm8, %xmm8
vpxor	%xmm8, %xmm5, %xmm5
vmovdqu	%xmm10, (%r9,%rax)
vmovdqu	%xmm11, (%r13,%rax)
vmovdqu	%xmm3, (%rcx,%rax)
vmovdqu	%xmm2, (%r10,%rax)
vmovdqu	%xmm5, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_5vect_mad_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_5vect_mad_avx.return_pass
gf_5vect_mad_avx.lessthan16:
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %xmm0
subq	%rax, %rdi
vmovdqa	constip16(%rip), %xmm2
vpinsrb	$0xf, %edi, %xmm8, %xmm8
vpshufb	%xmm15, %xmm8, %xmm8
vpcmpgtb	%xmm2, %xmm8, %xmm8
vmovdqu	0x10(%r12), %xmm2
vmovdqu	(%r12), %xmm3
vmovdqu	0x10(%r12,%rsi), %xmm4
vmovdqu	(%r12,%rsi), %xmm5
vmovdqu	0x10(%r12,%rsi,2), %xmm6
vmovdqu	(%r12,%rsi,2), %xmm7
vmovdqu	(%r12,%rsi,4), %xmm9
vmovdqu	(%r9,%r11), %xmm10
vmovdqu	(%r13,%r11), %xmm11
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm2, %xmm2
vpshufb	%xmm1, %xmm3, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpand	%xmm8, %xmm2, %xmm2
vpxor	%xmm2, %xmm10, %xmm10
vmovdqu	(%rcx,%r11), %xmm3
vmovdqu	(%r10,%r11), %xmm2
vpshufb	%xmm0, %xmm4, %xmm4
vpshufb	%xmm1, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpand	%xmm8, %xmm4, %xmm4
vpxor	%xmm4, %xmm11, %xmm11
vmovdqu	(%rdx,%r11), %xmm5
vpshufb	%xmm0, %xmm6, %xmm6
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpand	%xmm8, %xmm6, %xmm6
vpxor	%xmm6, %xmm3, %xmm3
vpshufb	%xmm0, %xmm12, %xmm12
vpshufb	%xmm1, %xmm13, %xmm13
vpxor	%xmm13, %xmm12, %xmm12
vpand	%xmm8, %xmm12, %xmm12
vpxor	%xmm12, %xmm2, %xmm2
vpshufb	%xmm0, %xmm14, %xmm14
vpshufb	%xmm1, %xmm9, %xmm9
vpxor	%xmm9, %xmm14, %xmm14
vpand	%xmm8, %xmm14, %xmm14
vpxor	%xmm14, %xmm5, %xmm5
vmovdqu	%xmm10, (%r9,%r11)
vmovdqu	%xmm11, (%r13,%r11)
vmovdqu	%xmm3, (%rcx,%r11)
vmovdqu	%xmm2, (%r10,%r11)
vmovdqu	%xmm5, (%rdx,%r11)
gf_5vect_mad_avx.return_pass:
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_5vect_mad_avx.return_fail:
popq	%r13
popq	%r12
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

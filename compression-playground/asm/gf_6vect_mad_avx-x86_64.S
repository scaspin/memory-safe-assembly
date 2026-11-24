	.text
gf_6vect_mad_avx:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
subq	$0x10, %rdi
jl	gf_6vect_mad_avx.return_fail
xorq	%rax, %rax
vmovdqa	mask0f(%rip), %xmm15
movq	%rsi, %r11
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r12
shlq	$0x6, %r11
shlq	$0x5, %rsi
leaq	(%r11,%rsi), %rdx
leaq	(%r11,%rdx), %rcx
vmovdqu	(%r12,%r11,2), %xmm12
vmovdqu	0x10(%r12,%r11,2), %xmm11
vmovdqu	(%r12,%rdx), %xmm14
vmovdqu	0x10(%r12,%rdx), %xmm13
vmovdqu	(%r12,%rcx), %xmm10
vmovdqu	0x10(%r12,%rcx), %xmm9
movq	0x8(%r9), %r13
movq	0x10(%r9), %r10
movq	0x18(%r9), %rcx
movq	0x20(%r9), %r14
movq	0x28(%r9), %rdx
movq	(%r9), %r9
gf_6vect_mad_avx.loop16:
vmovdqu	(%r8,%rax), %xmm0
vmovdqu	(%r12), %xmm3
vmovdqu	0x10(%r12), %xmm2
vmovdqu	(%r12,%rsi), %xmm5
vmovdqu	0x10(%r12,%rsi), %xmm4
vmovdqu	(%r12,%rsi,2), %xmm7
vmovdqu	0x10(%r12,%rsi,2), %xmm6
vmovdqu	(%r9,%rax), %xmm8
vpand	%xmm15, %xmm0, %xmm1
vpsraw	$0x4, %xmm0, %xmm0
vpand	%xmm15, %xmm0, %xmm0
vpshufb	%xmm0, %xmm2, %xmm2
vpshufb	%xmm1, %xmm3, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm8, %xmm8
vmovdqu	(%r13,%rax), %xmm3
vmovdqu	(%r10,%rax), %xmm2
vpshufb	%xmm0, %xmm4, %xmm4
vpshufb	%xmm1, %xmm5, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
vpshufb	%xmm0, %xmm6, %xmm6
vpshufb	%xmm1, %xmm7, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm2, %xmm2
vmovdqu	%xmm8, (%r9,%rax)
vmovdqu	%xmm3, (%r13,%rax)
vmovdqu	%xmm2, (%r10,%rax)
vmovdqu	(%rcx,%rax), %xmm8
vpshufb	%xmm0, %xmm13, %xmm2
vpshufb	%xmm1, %xmm14, %xmm3
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm8, %xmm8
vmovdqu	(%r14,%rax), %xmm3
vmovdqu	(%rdx,%rax), %xmm2
vpshufb	%xmm0, %xmm11, %xmm4
vpshufb	%xmm1, %xmm12, %xmm5
vpxor	%xmm5, %xmm4, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
vpshufb	%xmm0, %xmm9, %xmm6
vpshufb	%xmm1, %xmm10, %xmm7
vpxor	%xmm7, %xmm6, %xmm6
vpxor	%xmm6, %xmm2, %xmm2
vmovdqu	%xmm8, (%rcx,%rax)
vmovdqu	%xmm3, (%r14,%rax)
vmovdqu	%xmm2, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_6vect_mad_avx.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_6vect_mad_avx.return_pass
gf_6vect_mad_avx.lessthan16:
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %xmm0
vmovdqu	(%rcx,%r11), %xmm8
vmovdqu	(%r14,%r11), %xmm3
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
vmovdqu	%xmm8, (%rcx,%r11)
vmovdqu	%xmm3, (%r14,%r11)
vmovdqu	%xmm2, (%rdx,%r11)
vmovdqu	(%r12), %xmm14
vmovdqu	0x10(%r12), %xmm13
vmovdqu	(%r12,%rsi), %xmm12
vmovdqu	0x10(%r12,%rsi), %xmm11
vmovdqu	(%r12,%rsi,2), %xmm10
vmovdqu	0x10(%r12,%rsi,2), %xmm9
vmovdqu	(%r9,%r11), %xmm8
vmovdqu	(%r13,%r11), %xmm3
vmovdqu	(%r10,%r11), %xmm2
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
vmovdqu	%xmm3, (%r13,%r11)
vmovdqu	%xmm2, (%r10,%r11)
gf_6vect_mad_avx.return_pass:
popq	%r14
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_6vect_mad_avx.return_fail:
popq	%r14
popq	%r13
popq	%r12
movl	$0x1, %eax
retq
	.section .data
	.p2align 4
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

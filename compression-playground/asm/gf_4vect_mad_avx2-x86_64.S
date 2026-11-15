	.text
gf_4vect_mad_avx2:
endbr64
pushq	%r12
pushq	%r13
subq	$0x20, %rdi
jl	gf_4vect_mad_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm15, %xmm15
vpbroadcastb	%xmm15, %ymm15
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r11
movq	%r11, %r10
shlq	$0x5, %rsi
movq	%rsi, %r12
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rsi
movq	0x18(%r9), %rdx
movq	(%r9), %r9
leaq	(%r12,%r12,2), %r13
gf_4vect_mad_avx2.loop32:
vmovdqu	(%r8,%rax), %ymm0
vmovdqu	(%r9,%rax), %ymm7
vmovdqu	(%rcx,%rax), %ymm8
vmovdqu	(%rsi,%rax), %ymm9
vmovdqu	(%rdx,%rax), %ymm10
vpand	%ymm15, %ymm0, %ymm2
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vbroadcasti128	(%r11), %ymm14
vbroadcasti128	0x10(%r11), %ymm3
vbroadcasti128	(%r11,%r12), %ymm13
vbroadcasti128	0x10(%r11,%r12), %ymm4
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm14, %ymm14
vpxor	%ymm14, %ymm3, %ymm3
vpxor	%ymm3, %ymm7, %ymm7
vbroadcasti128	(%r11,%r12,2), %ymm12
vbroadcasti128	0x10(%r11,%r12,2), %ymm5
vpshufb	%ymm0, %ymm4, %ymm4
vpshufb	%ymm2, %ymm13, %ymm13
vpxor	%ymm13, %ymm4, %ymm4
vpxor	%ymm4, %ymm8, %ymm8
vbroadcasti128	(%r11,%r13), %ymm11
vbroadcasti128	0x10(%r11,%r13), %ymm6
vpshufb	%ymm0, %ymm5, %ymm5
vpshufb	%ymm2, %ymm12, %ymm12
vpxor	%ymm12, %ymm5, %ymm5
vpxor	%ymm5, %ymm9, %ymm9
vpshufb	%ymm0, %ymm6, %ymm6
vpshufb	%ymm2, %ymm11, %ymm11
vpxor	%ymm11, %ymm6, %ymm6
vpxor	%ymm6, %ymm10, %ymm10
vmovdqu	%ymm7, (%r9,%rax)
vmovdqu	%ymm8, (%rcx,%rax)
vmovdqu	%ymm9, (%rsi,%rax)
vmovdqu	%ymm10, (%rdx,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_4vect_mad_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_mad_avx2.return_pass
gf_4vect_mad_avx2.lessthan32:
movb	$0x1f, %r11b
vpinsrb	$0x0, %r11d, %xmm3, %xmm3
vpbroadcastb	%xmm3, %ymm3
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %ymm0
vmovdqu	(%r9,%r11), %ymm7
vmovdqu	(%rcx,%r11), %ymm8
vmovdqu	(%rsi,%r11), %ymm9
vmovdqu	(%rdx,%r11), %ymm10
subq	%rax, %rdi
vmovdqa	constip32(%rip), %ymm4
vpinsrb	$0xf, %edi, %xmm2, %xmm2
vinserti128	$0x1, %xmm2, %ymm2, %ymm2
vpshufb	%ymm3, %ymm2, %ymm2
vpcmpgtb	%ymm4, %ymm2, %ymm2
vpand	%ymm15, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vbroadcasti128	(%r10), %ymm14
vbroadcasti128	0x10(%r10), %ymm3
vbroadcasti128	(%r10,%r12), %ymm13
vbroadcasti128	0x10(%r10,%r12), %ymm4
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm14, %ymm14
vpxor	%ymm14, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm7, %ymm7
vbroadcasti128	(%r10,%r12,2), %ymm12
vbroadcasti128	0x10(%r10,%r12,2), %ymm5
vpshufb	%ymm0, %ymm4, %ymm4
vpshufb	%ymm1, %ymm13, %ymm13
vpxor	%ymm13, %ymm4, %ymm4
vpand	%ymm2, %ymm4, %ymm4
vpxor	%ymm4, %ymm8, %ymm8
vbroadcasti128	(%r10,%r13), %ymm11
vbroadcasti128	0x10(%r10,%r13), %ymm6
vpshufb	%ymm0, %ymm5, %ymm5
vpshufb	%ymm1, %ymm12, %ymm12
vpxor	%ymm12, %ymm5, %ymm5
vpand	%ymm2, %ymm5, %ymm5
vpxor	%ymm5, %ymm9, %ymm9
vpshufb	%ymm0, %ymm6, %ymm6
vpshufb	%ymm1, %ymm11, %ymm11
vpxor	%ymm11, %ymm6, %ymm6
vpand	%ymm2, %ymm6, %ymm6
vpxor	%ymm6, %ymm10, %ymm10
vmovdqu	%ymm7, (%r9,%r11)
vmovdqu	%ymm8, (%rcx,%r11)
vmovdqu	%ymm9, (%rsi,%r11)
vmovdqu	%ymm10, (%rdx,%r11)
gf_4vect_mad_avx2.return_pass:
movl	$0x0, %eax
popq	%r13
popq	%r12
retq
gf_4vect_mad_avx2.return_fail:
movl	$0x1, %eax
popq	%r13
popq	%r12
retq
	.section .data
	.p2align 5
constip32:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240
	.byte 239,238,237,236,235,234,233,232,231,230,229,228,227,226,225,224

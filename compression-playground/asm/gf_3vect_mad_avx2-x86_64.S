	.text
gf_3vect_mad_avx2:
endbr64
subq	$0x20, %rdi
jl	gf_3vect_mad_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm15, %xmm15
vpbroadcastb	%xmm15, %ymm15
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r11
movq	%r11, %r10
shlq	$0x5, %rsi
vbroadcasti128	(%r11), %ymm14
vbroadcasti128	0x10(%r11), %ymm13
vbroadcasti128	(%r11,%rsi), %ymm12
vbroadcasti128	0x10(%r11,%rsi), %ymm11
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	(%r9), %r9
gf_3vect_mad_avx2.loop32:
vmovdqu	(%r8,%rax), %ymm0
vmovdqu	(%r9,%rax), %ymm8
vmovdqu	(%rcx,%rax), %ymm9
vmovdqu	(%rdx,%rax), %ymm10
vbroadcasti128	(%r11,%rsi,2), %ymm7
vbroadcasti128	0x10(%r11,%rsi,2), %ymm6
vpand	%ymm15, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vpshufb	%ymm0, %ymm13, %ymm2
vpshufb	%ymm1, %ymm14, %ymm3
vpxor	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm8, %ymm8
vpshufb	%ymm0, %ymm11, %ymm4
vpshufb	%ymm1, %ymm12, %ymm5
vpxor	%ymm5, %ymm4, %ymm4
vpxor	%ymm4, %ymm9, %ymm9
vpshufb	%ymm0, %ymm6, %ymm6
vpshufb	%ymm1, %ymm7, %ymm7
vpxor	%ymm7, %ymm6, %ymm6
vpxor	%ymm6, %ymm10, %ymm10
vmovdqu	%ymm8, (%r9,%rax)
vmovdqu	%ymm9, (%rcx,%rax)
vmovdqu	%ymm10, (%rdx,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_3vect_mad_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_3vect_mad_avx2.return_pass
gf_3vect_mad_avx2.lessthan32:
movb	$0x1f, %r11b
vpinsrb	$0x0, %r11d, %xmm5, %xmm5
vpbroadcastb	%xmm5, %ymm5
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %ymm0
vmovdqu	(%r9,%r11), %ymm8
vmovdqu	(%rcx,%r11), %ymm9
vmovdqu	(%rdx,%r11), %ymm10
subq	%rax, %rdi
vmovdqa	constip32(%rip), %ymm6
vpinsrb	$0xf, %edi, %xmm7, %xmm7
vinserti128	$0x1, %xmm7, %ymm7, %ymm7
vpshufb	%ymm5, %ymm7, %ymm7
vpcmpgtb	%ymm6, %ymm7, %ymm7
vbroadcasti128	(%r10,%rsi), %ymm12
vbroadcasti128	0x10(%r10,%rsi), %ymm4
vbroadcasti128	(%r10,%rsi,2), %ymm11
vbroadcasti128	0x10(%r10,%rsi,2), %ymm6
vpand	%ymm15, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vpshufb	%ymm0, %ymm13, %ymm2
vpshufb	%ymm1, %ymm14, %ymm3
vpxor	%ymm3, %ymm2, %ymm2
vpand	%ymm7, %ymm2, %ymm2
vpxor	%ymm2, %ymm8, %ymm8
vpshufb	%ymm0, %ymm4, %ymm4
vpshufb	%ymm1, %ymm12, %ymm12
vpxor	%ymm12, %ymm4, %ymm4
vpand	%ymm7, %ymm4, %ymm4
vpxor	%ymm4, %ymm9, %ymm9
vpshufb	%ymm0, %ymm6, %ymm6
vpshufb	%ymm1, %ymm11, %ymm11
vpxor	%ymm11, %ymm6, %ymm6
vpand	%ymm7, %ymm6, %ymm6
vpxor	%ymm6, %ymm10, %ymm10
vmovdqu	%ymm8, (%r9,%r11)
vmovdqu	%ymm9, (%rcx,%r11)
vmovdqu	%ymm10, (%rdx,%r11)
gf_3vect_mad_avx2.return_pass:
movl	$0x0, %eax
retq
gf_3vect_mad_avx2.return_fail:
movl	$0x1, %eax
retq
	.section .data
	.p2align 5
constip32:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240
	.byte 239,238,237,236,235,234,233,232,231,230,229,228,227,226,225,224

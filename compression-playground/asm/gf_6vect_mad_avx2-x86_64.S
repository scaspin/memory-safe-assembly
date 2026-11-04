	.text
gf_6vect_mad_avx2:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x20, %rdi
jl	gf_6vect_mad_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm15, %xmm15
vpbroadcastb	%xmm15, %ymm15
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
movq	%r11, %r15
movq	%rsi, %rdx
movq	%rsi, %rcx
shlq	%rdx
shlq	%rcx
addq	%rsi, %rdx
addq	%rdx, %rcx
movq	%rsi, %r13
movq	0x8(%r9), %r12
movq	0x10(%r9), %r10
movq	0x18(%r9), %rcx
movq	0x20(%r9), %rsi
movq	0x28(%r9), %rdx
movq	(%r9), %r9
gf_6vect_mad_avx2.loop32:
vmovdqu	(%r8,%rax), %ymm0
vmovdqu	(%r9,%rax), %ymm4
vmovdqu	(%r12,%rax), %ymm5
vmovdqu	(%r10,%rax), %ymm6
vmovdqu	(%rcx,%rax), %ymm7
vmovdqu	(%rsi,%rax), %ymm8
leaq	(%r13,%r13,2), %r14
vpand	%ymm15, %ymm0, %ymm2
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vbroadcasti128	(%r11), %ymm14
vbroadcasti128	0x10(%r11), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm14, %ymm14
vpxor	%ymm14, %ymm3, %ymm3
vpxor	%ymm3, %ymm4, %ymm4
vmovdqu	%ymm4, (%r9,%rax)
vmovdqu	(%rdx,%rax), %ymm4
vbroadcasti128	(%r11,%r13), %ymm13
vbroadcasti128	0x10(%r11,%r13), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm13, %ymm13
vpxor	%ymm13, %ymm3, %ymm3
vpxor	%ymm3, %ymm5, %ymm5
vbroadcasti128	(%r11,%r13,2), %ymm12
vbroadcasti128	0x10(%r11,%r13,2), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm12, %ymm12
vpxor	%ymm12, %ymm3, %ymm3
vpxor	%ymm3, %ymm6, %ymm6
vbroadcasti128	(%r11,%r14), %ymm11
vbroadcasti128	0x10(%r11,%r14), %ymm3
leaq	(%r14,%r13,2), %r14
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm11, %ymm11
vpxor	%ymm11, %ymm3, %ymm3
vpxor	%ymm3, %ymm7, %ymm7
vbroadcasti128	(%r11,%r13,4), %ymm10
vbroadcasti128	0x10(%r11,%r13,4), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm10, %ymm10
vpxor	%ymm10, %ymm3, %ymm3
vpxor	%ymm3, %ymm8, %ymm8
vbroadcasti128	(%r11,%r14), %ymm9
vbroadcasti128	0x10(%r11,%r14), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm2, %ymm9, %ymm9
vpxor	%ymm9, %ymm3, %ymm3
vpxor	%ymm3, %ymm4, %ymm4
vmovdqu	%ymm5, (%r12,%rax)
vmovdqu	%ymm6, (%r10,%rax)
vmovdqu	%ymm7, (%rcx,%rax)
vmovdqu	%ymm8, (%rsi,%rax)
vmovdqu	%ymm4, (%rdx,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_6vect_mad_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_6vect_mad_avx2.return_pass
gf_6vect_mad_avx2.lessthan32:
movb	$0x1f, %r11b
vpinsrb	$0x0, %r11d, %xmm3, %xmm3
vpbroadcastb	%xmm3, %ymm3
movq	%rdi, %r11
vmovdqu	(%r8,%r11), %ymm0
vmovdqu	(%r9,%r11), %ymm4
vmovdqu	(%r12,%r11), %ymm5
vmovdqu	(%r10,%r11), %ymm6
vmovdqu	(%rcx,%r11), %ymm7
vmovdqu	(%rsi,%r11), %ymm8
subq	%rax, %rdi
leaq	(%r13,%r13,2), %r14
vpinsrb	$0xf, %edi, %xmm2, %xmm2
vinserti128	$0x1, %xmm2, %ymm2, %ymm2
vpshufb	%ymm3, %ymm2, %ymm2
vpcmpgtb	constip32(%rip), %ymm2, %ymm2
vpand	%ymm15, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vbroadcasti128	(%r15), %ymm14
vbroadcasti128	0x10(%r15), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm14, %ymm14
vpxor	%ymm14, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm4, %ymm4
vmovdqu	%ymm4, (%r9,%r11)
vmovdqu	(%rdx,%r11), %ymm4
vbroadcasti128	(%r15,%r13), %ymm13
vbroadcasti128	0x10(%r15,%r13), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm13, %ymm13
vpxor	%ymm13, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm5, %ymm5
vbroadcasti128	(%r15,%r13,2), %ymm12
vbroadcasti128	0x10(%r15,%r13,2), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm12, %ymm12
vpxor	%ymm12, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm6, %ymm6
vbroadcasti128	(%r15,%r14), %ymm11
vbroadcasti128	0x10(%r15,%r14), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm11, %ymm11
vpxor	%ymm11, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm7, %ymm7
leaq	(%r14,%r13,2), %r14
vbroadcasti128	(%r15,%r13,4), %ymm10
vbroadcasti128	0x10(%r15,%r13,4), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm10, %ymm10
vpxor	%ymm10, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm8, %ymm8
vbroadcasti128	(%r15,%r14), %ymm9
vbroadcasti128	0x10(%r15,%r14), %ymm3
vpshufb	%ymm0, %ymm3, %ymm3
vpshufb	%ymm1, %ymm9, %ymm9
vpxor	%ymm9, %ymm3, %ymm3
vpand	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm4, %ymm4
vmovdqu	%ymm5, (%r12,%r11)
vmovdqu	%ymm6, (%r10,%r11)
vmovdqu	%ymm7, (%rcx,%r11)
vmovdqu	%ymm8, (%rsi,%r11)
vmovdqu	%ymm4, (%rdx,%r11)
gf_6vect_mad_avx2.return_pass:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_6vect_mad_avx2.return_fail:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x1, %eax
retq
	.section .data
constip32:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240
	.byte 239,238,237,236,235,234,233,232,231,230,229,228,227,226,225,224

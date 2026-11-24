	.text
gf_2vect_mad_avx2:
endbr64
subq	$0x20, %rdi
jl	gf_2vect_mad_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm14, %xmm14
vpbroadcastb	%xmm14, %ymm14
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r11
shlq	$0x5, %rsi
vbroadcasti128	(%r11), %ymm13
vbroadcasti128	0x10(%r11), %ymm12
vbroadcasti128	(%r11,%rsi), %ymm11
vbroadcasti128	0x10(%r11,%rsi), %ymm10
movq	0x8(%r9), %r10
movq	(%r9), %r9
vmovdqu	(%r9,%rdi), %ymm8
vmovdqu	(%r10,%rdi), %ymm9
gf_2vect_mad_avx2.loop32:
vmovdqu	(%r9,%rax), %ymm6
vmovdqu	(%r10,%rax), %ymm7
gf_2vect_mad_avx2.loop32_overlap:
vmovdqu	(%r8,%rax), %ymm0
vpand	%ymm14, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm14, %ymm0, %ymm0
vpshufb	%ymm0, %ymm12, %ymm2
vpshufb	%ymm1, %ymm13, %ymm3
vpxor	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm6, %ymm6
vpshufb	%ymm0, %ymm10, %ymm4
vpshufb	%ymm1, %ymm11, %ymm5
vpxor	%ymm5, %ymm4, %ymm4
vpxor	%ymm4, %ymm7, %ymm7
vmovdqu	%ymm6, (%r9,%rax)
vmovdqu	%ymm7, (%r10,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_2vect_mad_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_mad_avx2.return_pass
movq	%rdi, %rax
vmovdqa	%ymm8, %ymm6
vmovdqa	%ymm9, %ymm7
jmp	gf_2vect_mad_avx2.loop32_overlap
gf_2vect_mad_avx2.return_pass:
movl	$0x0, %eax
retq
gf_2vect_mad_avx2.return_fail:
movl	$0x1, %eax
retq

	.text
gf_5vect_mad_avx512:
endbr64
subq	$0x40, %rdi
jl	gf_5vect_mad_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm21
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vmovdqu	(%r11), %ymm7
vmovdqu	(%r11,%rsi), %ymm9
vmovdqu	(%r11,%rsi,2), %ymm11
vmovdqu	(%r11,%rsi,4), %ymm15
addq	%rsi, %r11
vmovdqu	(%r11,%rsi,2), %ymm13
vshufi64x2	$0x55, %zmm7, %zmm7, %zmm6
vshufi64x2	$0x0, %zmm7, %zmm7, %zmm7
vshufi64x2	$0x55, %zmm9, %zmm9, %zmm8
vshufi64x2	$0x0, %zmm9, %zmm9, %zmm9
vshufi64x2	$0x55, %zmm11, %zmm11, %zmm10
vshufi64x2	$0x0, %zmm11, %zmm11, %zmm11
vshufi64x2	$0x55, %zmm13, %zmm13, %zmm12
vshufi64x2	$0x0, %zmm13, %zmm13, %zmm13
vshufi64x2	$0x55, %zmm15, %zmm15, %zmm14
vshufi64x2	$0x0, %zmm15, %zmm15, %zmm15
movq	0x8(%r9), %r10
movq	0x10(%r9), %rcx
movq	0x18(%r9), %rsi
movq	0x20(%r9), %rdx
movq	(%r9), %r9
movq	$-0x1, %r11
kmovq	%r11, %k1
gf_5vect_mad_avx512.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm16
vmovdqu8	(%r10,%rax), %zmm17
vmovdqu8	(%rcx,%rax), %zmm18
vmovdqu8	(%rsi,%rax), %zmm19
vmovdqu8	(%rdx,%rax), %zmm20
vpandq	%zmm21, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm21, %zmm0, %zmm0
vpshufb	%zmm0, %zmm6, %zmm3 {%k1} {z}
vpshufb	%zmm1, %zmm7, %zmm2 {%k1} {z}
vpxorq	%zmm2, %zmm3, %zmm3
vpxorq	%zmm3, %zmm16, %zmm16
vpshufb	%zmm0, %zmm8, %zmm4 {%k1} {z}
vpshufb	%zmm1, %zmm9, %zmm22 {%k1} {z}
vpxorq	%zmm22, %zmm4, %zmm4
vpxorq	%zmm4, %zmm17, %zmm17
vpshufb	%zmm0, %zmm10, %zmm5 {%k1} {z}
vpshufb	%zmm1, %zmm11, %zmm23 {%k1} {z}
vpxorq	%zmm23, %zmm5, %zmm5
vpxorq	%zmm5, %zmm18, %zmm18
vpshufb	%zmm0, %zmm12, %zmm26 {%k1} {z}
vpshufb	%zmm1, %zmm13, %zmm24 {%k1} {z}
vpxorq	%zmm24, %zmm26, %zmm26
vpxorq	%zmm26, %zmm19, %zmm19
vpshufb	%zmm0, %zmm14, %zmm27 {%k1} {z}
vpshufb	%zmm1, %zmm15, %zmm25 {%k1} {z}
vpxorq	%zmm25, %zmm27, %zmm27
vpxorq	%zmm27, %zmm20, %zmm20
vmovdqu8	%zmm16, (%r9,%rax)
vmovdqu8	%zmm17, (%r10,%rax)
vmovdqu8	%zmm18, (%rcx,%rax)
vmovdqu8	%zmm19, (%rsi,%rax)
vmovdqu8	%zmm20, (%rdx,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_5vect_mad_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_5vect_mad_avx512.return_pass
movabsq	$-0x8000000000000000, %rax
leaq	0x3f(%rdi), %r11
andq	$0x3f, %r11
sarxq	%r11, %rax, %rax
kmovq	%rax, %k1
movq	%rdi, %rax
jmp	gf_5vect_mad_avx512.loop64
gf_5vect_mad_avx512.return_pass:
movl	$0x0, %eax
retq
gf_5vect_mad_avx512.return_fail:
movl	$0x1, %eax
retq

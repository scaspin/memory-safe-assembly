	.text
gf_4vect_mad_avx512:
endbr64
subq	$0x40, %rdi
jl	gf_4vect_mad_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm19
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vmovdqu	(%r11), %ymm8
vmovdqu	(%r11,%rsi), %ymm10
vmovdqu	(%r11,%rsi,2), %ymm12
addq	%rsi, %r11
vmovdqu	(%r11,%rsi,2), %ymm14
vshufi64x2	$0x55, %zmm8, %zmm8, %zmm7
vshufi64x2	$0x0, %zmm8, %zmm8, %zmm8
vshufi64x2	$0x55, %zmm10, %zmm10, %zmm9
vshufi64x2	$0x0, %zmm10, %zmm10, %zmm10
vshufi64x2	$0x55, %zmm12, %zmm12, %zmm11
vshufi64x2	$0x0, %zmm12, %zmm12, %zmm12
vshufi64x2	$0x55, %zmm14, %zmm14, %zmm13
vshufi64x2	$0x0, %zmm14, %zmm14, %zmm14
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rsi
movq	0x18(%r9), %rdx
movq	(%r9), %r9
movq	$-0x1, %r11
kmovq	%r11, %k1
gf_4vect_mad_avx512.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm15
vmovdqu8	(%rcx,%rax), %zmm16
vmovdqu8	(%rsi,%rax), %zmm17
vmovdqu8	(%rdx,%rax), %zmm18
vpandq	%zmm19, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm19, %zmm0, %zmm0
vpshufb	%zmm0, %zmm7, %zmm3 {%k1} {z}
vpshufb	%zmm1, %zmm8, %zmm2 {%k1} {z}
vpxorq	%zmm2, %zmm3, %zmm3
vpxorq	%zmm3, %zmm15, %zmm15
vpshufb	%zmm0, %zmm9, %zmm4 {%k1} {z}
vpshufb	%zmm1, %zmm10, %zmm20 {%k1} {z}
vpxorq	%zmm20, %zmm4, %zmm4
vpxorq	%zmm4, %zmm16, %zmm16
vpshufb	%zmm0, %zmm11, %zmm5 {%k1} {z}
vpshufb	%zmm1, %zmm12, %zmm21 {%k1} {z}
vpxorq	%zmm21, %zmm5, %zmm5
vpxorq	%zmm5, %zmm17, %zmm17
vpshufb	%zmm0, %zmm13, %zmm6 {%k1} {z}
vpshufb	%zmm1, %zmm14, %zmm22 {%k1} {z}
vpxorq	%zmm22, %zmm6, %zmm6
vpxorq	%zmm6, %zmm18, %zmm18
vmovdqu8	%zmm15, (%r9,%rax)
vmovdqu8	%zmm16, (%rcx,%rax)
vmovdqu8	%zmm17, (%rsi,%rax)
vmovdqu8	%zmm18, (%rdx,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_4vect_mad_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_mad_avx512.return_pass
movabsq	$-0x8000000000000000, %rax
leaq	0x3f(%rdi), %r11
andq	$0x3f, %r11
sarxq	%r11, %rax, %rax
kmovq	%rax, %k1
movq	%rdi, %rax
jmp	gf_4vect_mad_avx512.loop64
gf_4vect_mad_avx512.return_pass:
movl	$0x0, %eax
retq
gf_4vect_mad_avx512.return_fail:
movl	$0x1, %eax
retq

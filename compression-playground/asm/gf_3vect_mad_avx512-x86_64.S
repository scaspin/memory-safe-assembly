	.text
gf_3vect_mad_avx512:
endbr64
subq	$0x40, %rdi
jl	gf_3vect_mad_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm17
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vmovdqu	(%r11), %ymm9
vmovdqu	(%r11,%rsi), %ymm11
vmovdqu	(%r11,%rsi,2), %ymm13
vshufi64x2	$0x55, %zmm9, %zmm9, %zmm8
vshufi64x2	$0x0, %zmm9, %zmm9, %zmm9
vshufi64x2	$0x55, %zmm11, %zmm11, %zmm10
vshufi64x2	$0x0, %zmm11, %zmm11, %zmm11
vshufi64x2	$0x55, %zmm13, %zmm13, %zmm12
vshufi64x2	$0x0, %zmm13, %zmm13, %zmm13
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	(%r9), %r9
movq	$-0x1, %r11
kmovq	%r11, %k1
gf_3vect_mad_avx512.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm14
vmovdqu8	(%rcx,%rax), %zmm15
vmovdqu8	(%rdx,%rax), %zmm16
vpandq	%zmm17, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm17, %zmm0, %zmm0
vpshufb	%zmm0, %zmm8, %zmm2 {%k1} {z}
vpshufb	%zmm1, %zmm9, %zmm3 {%k1} {z}
vpxorq	%zmm3, %zmm2, %zmm2
vpxorq	%zmm2, %zmm14, %zmm14
vpshufb	%zmm0, %zmm10, %zmm4 {%k1} {z}
vpshufb	%zmm1, %zmm11, %zmm5 {%k1} {z}
vpxorq	%zmm5, %zmm4, %zmm4
vpxorq	%zmm4, %zmm15, %zmm15
vpshufb	%zmm0, %zmm12, %zmm6 {%k1} {z}
vpshufb	%zmm1, %zmm13, %zmm7 {%k1} {z}
vpxorq	%zmm7, %zmm6, %zmm6
vpxorq	%zmm6, %zmm16, %zmm16
vmovdqu8	%zmm14, (%r9,%rax)
vmovdqu8	%zmm15, (%rcx,%rax)
vmovdqu8	%zmm16, (%rdx,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_3vect_mad_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_3vect_mad_avx512.return_pass
movabsq	$-0x8000000000000000, %rax
leaq	0x3f(%rdi), %r11
andq	$0x3f, %r11
sarxq	%r11, %rax, %rax
kmovq	%rax, %k1
movq	%rdi, %rax
jmp	gf_3vect_mad_avx512.loop64
gf_3vect_mad_avx512.return_pass:
movl	$0x0, %eax
retq
gf_3vect_mad_avx512.return_fail:
movl	$0x1, %eax
retq

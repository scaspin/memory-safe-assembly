	.text
gf_vect_mad_avx512:
endbr64
subq	$0x40, %rdi
jl	gf_vect_mad_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm8
shlq	$0x5, %rdx
vmovdqu8	(%rdx,%rcx), %ymm7
vshufi64x2	$0x55, %zmm7, %zmm7, %zmm6
vshufi64x2	$0x0, %zmm7, %zmm7, %zmm7
movq	$-0x1, %r11
kmovq	%r11, %k1
gf_vect_mad_avx512.loop64:
vmovdqu8	(%r9,%rax), %zmm4
vmovdqu8	(%r8,%rax), %zmm0
vpandq	%zmm8, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm8, %zmm0, %zmm0
vpshufb	%zmm0, %zmm6, %zmm2 {%k1} {z}
vpshufb	%zmm1, %zmm7, %zmm3 {%k1} {z}
vpxorq	%zmm3, %zmm2, %zmm2
vpxorq	%zmm2, %zmm4, %zmm4
vmovdqu8	%zmm4, (%r9,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_vect_mad_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_mad_avx512.return_pass
movabsq	$-0x8000000000000000, %rax
leaq	0x3f(%rdi), %r11
andq	$0x3f, %r11
sarxq	%r11, %rax, %rax
kmovq	%rax, %k1
movq	%rdi, %rax
jmp	gf_vect_mad_avx512.loop64
gf_vect_mad_avx512.return_pass:
movl	$0x0, %eax
retq
gf_vect_mad_avx512.return_fail:
movl	$0x1, %eax
retq

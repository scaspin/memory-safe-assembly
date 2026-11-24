	.text
gf_4vect_mad_avx512_gfni:
endbr64
xorq	%rax, %rax
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vpbroadcastq	(%r11), %zmm5
vpbroadcastq	(%r11,%rsi), %zmm6
vpbroadcastq	(%r11,%rsi,2), %zmm7
addq	%rsi, %r11
vpbroadcastq	(%r11,%rsi,2), %zmm8
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rsi
movq	0x18(%r9), %rdx
movq	(%r9), %r9
cmpq	$0x40, %rdi
jl	gf_4vect_mad_avx512_gfni.len_lt_64
gf_4vect_mad_avx512_gfni.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm1
vmovdqu8	(%rcx,%rax), %zmm2
vmovdqu8	(%rsi,%rax), %zmm3
vmovdqu8	(%rdx,%rax), %zmm4
vgf2p8affineqb	$0x0, %zmm5, %zmm0, %zmm9
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm10
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm11
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm12
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vmovdqu8	%zmm1, (%r9,%rax)
vmovdqu8	%zmm2, (%rcx,%rax)
vmovdqu8	%zmm3, (%rsi,%rax)
vmovdqu8	%zmm4, (%rdx,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_4vect_mad_avx512_gfni.loop64
gf_4vect_mad_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_4vect_mad_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%r8,%rax), %zmm0 {%k1}
vmovdqu8	(%r9,%rax), %zmm1 {%k1}
vmovdqu8	(%rcx,%rax), %zmm2 {%k1}
vmovdqu8	(%rsi,%rax), %zmm3 {%k1}
vmovdqu8	(%rdx,%rax), %zmm4 {%k1}
vgf2p8affineqb	$0x0, %zmm5, %zmm0, %zmm9
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm10
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm11
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm12
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vmovdqu8	%zmm1, (%r9,%rax) {%k1}
vmovdqu8	%zmm2, (%rcx,%rax) {%k1}
vmovdqu8	%zmm3, (%rsi,%rax) {%k1}
vmovdqu8	%zmm4, (%rdx,%rax) {%k1}
gf_4vect_mad_avx512_gfni.exit:
vzeroupper
retq

	.text
gf_3vect_mad_avx512_gfni:
endbr64
xorq	%rax, %rax
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vpbroadcastq	(%r11), %zmm1
vpbroadcastq	(%r11,%rsi), %zmm2
vpbroadcastq	(%r11,%rsi,2), %zmm3
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	(%r9), %r9
cmpq	$0x40, %rdi
jl	gf_3vect_mad_avx512_gfni.len_lt_64
gf_3vect_mad_avx512_gfni.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm4
vmovdqu8	(%rcx,%rax), %zmm5
vmovdqu8	(%rdx,%rax), %zmm6
vgf2p8affineqb	$0x0, %zmm1, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm2, %zmm0, %zmm8
vgf2p8affineqb	$0x0, %zmm3, %zmm0, %zmm9
vpxorq	%zmm7, %zmm4, %zmm4
vpxorq	%zmm8, %zmm5, %zmm5
vpxorq	%zmm9, %zmm6, %zmm6
vmovdqu8	%zmm4, (%r9,%rax)
vmovdqu8	%zmm5, (%rcx,%rax)
vmovdqu8	%zmm6, (%rdx,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_3vect_mad_avx512_gfni.loop64
gf_3vect_mad_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_3vect_mad_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%r8,%rax), %zmm0 {%k1}
vmovdqu8	(%r9,%rax), %zmm4 {%k1}
vmovdqu8	(%rcx,%rax), %zmm5 {%k1}
vmovdqu8	(%rdx,%rax), %zmm6 {%k1}
vgf2p8affineqb	$0x0, %zmm1, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm2, %zmm0, %zmm8
vgf2p8affineqb	$0x0, %zmm3, %zmm0, %zmm9
vpxorq	%zmm7, %zmm4, %zmm4
vpxorq	%zmm8, %zmm5, %zmm5
vpxorq	%zmm9, %zmm6, %zmm6
vmovdqu8	%zmm4, (%r9,%rax) {%k1}
vmovdqu8	%zmm5, (%rcx,%rax) {%k1}
vmovdqu8	%zmm6, (%rdx,%rax) {%k1}
gf_3vect_mad_avx512_gfni.exit:
vzeroupper
retq

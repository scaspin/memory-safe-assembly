	.text
gf_2vect_mad_avx512_gfni:
endbr64
xorq	%rax, %rax
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vpbroadcastq	(%r11), %zmm3
vpbroadcastq	(%r11,%rsi), %zmm4
movq	0x8(%r9), %r10
movq	(%r9), %r9
cmpq	$0x40, %rdi
jl	gf_2vect_mad_avx512_gfni.len_lt_64
gf_2vect_mad_avx512_gfni.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm1
vmovdqu8	(%r10,%rax), %zmm2
vgf2p8affineqb	$0x0, %zmm3, %zmm0, %zmm5
vgf2p8affineqb	$0x0, %zmm4, %zmm0, %zmm6
vpxorq	%zmm5, %zmm1, %zmm1
vpxorq	%zmm6, %zmm2, %zmm2
vmovdqu8	%zmm1, (%r9,%rax)
vmovdqu8	%zmm2, (%r10,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_2vect_mad_avx512_gfni.loop64
gf_2vect_mad_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_2vect_mad_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%r8,%rax), %zmm0 {%k1}
vmovdqu8	(%r9,%rax), %zmm1 {%k1}
vmovdqu8	(%r10,%rax), %zmm2 {%k1}
vgf2p8affineqb	$0x0, %zmm3, %zmm0, %zmm5
vgf2p8affineqb	$0x0, %zmm4, %zmm0, %zmm6
vpxorq	%zmm5, %zmm1, %zmm1
vpxorq	%zmm6, %zmm2, %zmm2
vmovdqu8	%zmm1, (%r9,%rax) {%k1}
vmovdqu8	%zmm2, (%r10,%rax) {%k1}
gf_2vect_mad_avx512_gfni.exit:
vzeroupper
retq

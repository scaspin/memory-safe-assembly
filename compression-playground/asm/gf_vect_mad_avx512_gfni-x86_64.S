	.text
gf_vect_mad_avx512_gfni:
endbr64
xorq	%rax, %rax
shlq	$0x5, %rdx
vpbroadcastq	(%rdx,%rcx), %zmm2
cmpq	$0x40, %rdi
jl	gf_vect_mad_avx512_gfni.len_lt_64
gf_vect_mad_avx512_gfni.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm1
vgf2p8affineqb	$0x0, %zmm2, %zmm0, %zmm3
vpxorq	%zmm3, %zmm1, %zmm1
vmovdqu8	%zmm1, (%r9,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_vect_mad_avx512_gfni.loop64
gf_vect_mad_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_vect_mad_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%r8,%rax), %zmm0 {%k1}
vmovdqu8	(%r9,%rax), %zmm1 {%k1}
vgf2p8affineqb	$0x0, %zmm2, %zmm0, %zmm3
vpxorq	%zmm3, %zmm1, %zmm1
vmovdqu8	%zmm1, (%r9,%rax) {%k1}
gf_vect_mad_avx512_gfni.exit:
vzeroupper
retq

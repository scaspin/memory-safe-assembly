	.text
gf_6vect_mad_avx512_gfni:
endbr64
pushq	%r12
xorq	%rax, %rax
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vpbroadcastq	(%r11), %zmm7
vpbroadcastq	(%r11,%rsi), %zmm8
vpbroadcastq	(%r11,%rsi,2), %zmm9
vpbroadcastq	(%r11,%rsi,4), %zmm11
addq	%rsi, %r11
vpbroadcastq	(%r11,%rsi,2), %zmm10
vpbroadcastq	(%r11,%rsi,4), %zmm12
movq	0x8(%r9), %r12
movq	0x10(%r9), %r10
movq	0x18(%r9), %rcx
movq	0x20(%r9), %rsi
movq	0x28(%r9), %rdx
movq	(%r9), %r9
cmpq	$0x40, %rdi
jl	gf_6vect_mad_avx512_gfni.len_lt_64
gf_6vect_mad_avx512_gfni.loop64:
vmovdqu8	(%r8,%rax), %zmm0
vmovdqu8	(%r9,%rax), %zmm1
vmovdqu8	(%r12,%rax), %zmm2
vmovdqu8	(%r10,%rax), %zmm3
vmovdqu8	(%rcx,%rax), %zmm4
vmovdqu8	(%rsi,%rax), %zmm5
vmovdqu8	(%rdx,%rax), %zmm6
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm13
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm14
vgf2p8affineqb	$0x0, %zmm9, %zmm0, %zmm15
vgf2p8affineqb	$0x0, %zmm10, %zmm0, %zmm16
vgf2p8affineqb	$0x0, %zmm11, %zmm0, %zmm17
vgf2p8affineqb	$0x0, %zmm12, %zmm0, %zmm18
vpxorq	%zmm13, %zmm1, %zmm1
vpxorq	%zmm14, %zmm2, %zmm2
vpxorq	%zmm15, %zmm3, %zmm3
vpxorq	%zmm16, %zmm4, %zmm4
vpxorq	%zmm17, %zmm5, %zmm5
vpxorq	%zmm18, %zmm6, %zmm6
vmovdqu8	%zmm1, (%r9,%rax)
vmovdqu8	%zmm2, (%r12,%rax)
vmovdqu8	%zmm3, (%r10,%rax)
vmovdqu8	%zmm4, (%rcx,%rax)
vmovdqu8	%zmm5, (%rsi,%rax)
vmovdqu8	%zmm6, (%rdx,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_6vect_mad_avx512_gfni.loop64
gf_6vect_mad_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_6vect_mad_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%r8,%rax), %zmm0 {%k1}
vmovdqu8	(%r9,%rax), %zmm1 {%k1}
vmovdqu8	(%r12,%rax), %zmm2 {%k1}
vmovdqu8	(%r10,%rax), %zmm3 {%k1}
vmovdqu8	(%rcx,%rax), %zmm4 {%k1}
vmovdqu8	(%rsi,%rax), %zmm5 {%k1}
vmovdqu8	(%rdx,%rax), %zmm6 {%k1}
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm13
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm14
vgf2p8affineqb	$0x0, %zmm9, %zmm0, %zmm15
vgf2p8affineqb	$0x0, %zmm10, %zmm0, %zmm16
vgf2p8affineqb	$0x0, %zmm11, %zmm0, %zmm17
vgf2p8affineqb	$0x0, %zmm12, %zmm0, %zmm18
vpxorq	%zmm13, %zmm1, %zmm1
vpxorq	%zmm14, %zmm2, %zmm2
vpxorq	%zmm15, %zmm3, %zmm3
vpxorq	%zmm16, %zmm4, %zmm4
vpxorq	%zmm17, %zmm5, %zmm5
vpxorq	%zmm18, %zmm6, %zmm6
vmovdqu8	%zmm1, (%r9,%rax) {%k1}
vmovdqu8	%zmm2, (%r12,%rax) {%k1}
vmovdqu8	%zmm3, (%r10,%rax) {%k1}
vmovdqu8	%zmm4, (%rcx,%rax) {%k1}
vmovdqu8	%zmm5, (%rsi,%rax) {%k1}
vmovdqu8	%zmm6, (%rdx,%rax) {%k1}
gf_6vect_mad_avx512_gfni.exit:
vzeroupper
popq	%r12
retq

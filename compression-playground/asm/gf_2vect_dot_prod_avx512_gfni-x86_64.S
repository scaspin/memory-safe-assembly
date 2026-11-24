	.text
gf_2vect_dot_prod_avx512_gfni:
endbr64
pushq	%r12
xorq	%rax, %rax
shlq	$0x3, %rsi
movq	0x8(%r8), %r12
movq	(%r8), %r8
cmpq	$0x40, %rdi
jl	gf_2vect_dot_prod_avx512_gfni.len_lt_64
gf_2vect_dot_prod_avx512_gfni.loop64:
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm3
vpbroadcastq	(%r11,%rsi,4), %zmm4
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm3, %zmm0, %zmm3
vgf2p8affineqb	$0x0, %zmm4, %zmm0, %zmm4
vpxorq	%zmm3, %zmm1, %zmm1
vpxorq	%zmm4, %zmm2, %zmm2
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu8	%zmm1, (%r8,%rax)
vmovdqu8	%zmm2, (%r12,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_2vect_dot_prod_avx512_gfni.loop64
gf_2vect_dot_prod_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_2vect_dot_prod_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
movq	%rdx, %r11
xorq	%r10, %r10
..@11.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0 {%k1}
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm3
vpbroadcastq	(%r11,%rsi,4), %zmm4
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm3, %zmm0, %zmm3
vgf2p8affineqb	$0x0, %zmm4, %zmm0, %zmm4
vpxorq	%zmm3, %zmm1, %zmm1
vpxorq	%zmm4, %zmm2, %zmm2
cmpq	%rsi, %r10
jl	..@11.next_vect
vmovdqu8	%zmm1, (%r8,%rax) {%k1}
vmovdqu8	%zmm2, (%r12,%rax) {%k1}
gf_2vect_dot_prod_avx512_gfni.exit:
vzeroupper
popq	%r12
retq

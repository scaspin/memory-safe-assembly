	.text
gf_vect_dot_prod_avx512_gfni:
endbr64
xorq	%rax, %rax
shlq	$0x3, %rsi
cmpq	$0x40, %rdi
jl	gf_vect_dot_prod_avx512_gfni.len_lt_64
gf_vect_dot_prod_avx512_gfni.loop64:
vpxorq	%zmm1, %zmm1, %zmm1
movq	%rdx, %r11
xorq	%r10, %r10
..@8.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm2
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm2, %zmm0, %zmm2
vpxorq	%zmm2, %zmm1, %zmm1
cmpq	%rsi, %r10
jl	..@8.next_vect
vmovdqu8	%zmm1, (%r8,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_vect_dot_prod_avx512_gfni.loop64
gf_vect_dot_prod_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_vect_dot_prod_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vpxorq	%zmm1, %zmm1, %zmm1
movq	%rdx, %r11
xorq	%r10, %r10
..@10.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0 {%k1}
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm2
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm2, %zmm0, %zmm2
vpxorq	%zmm2, %zmm1, %zmm1
cmpq	%rsi, %r10
jl	..@10.next_vect
vmovdqu8	%zmm1, (%r8,%rax) {%k1}
gf_vect_dot_prod_avx512_gfni.exit:
vzeroupper
retq

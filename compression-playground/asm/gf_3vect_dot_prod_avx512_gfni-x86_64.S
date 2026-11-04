	.text
gf_3vect_dot_prod_avx512_gfni:
endbr64
pushq	%r12
pushq	%r13
xorq	%rax, %rax
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	(%r8), %r8
cmpq	$0x40, %rdi
jl	gf_3vect_dot_prod_avx512_gfni.len_lt_64
gf_3vect_dot_prod_avx512_gfni.loop64:
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm4
vpbroadcastq	(%r11,%rsi,4), %zmm5
vpbroadcastq	(%r11,%rsi,8), %zmm6
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm4, %zmm0, %zmm4
vgf2p8affineqb	$0x0, %zmm5, %zmm0, %zmm5
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm6
vpxorq	%zmm4, %zmm1, %zmm1
vpxorq	%zmm5, %zmm2, %zmm2
vpxorq	%zmm6, %zmm3, %zmm3
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu8	%zmm1, (%r8,%rax)
vmovdqu8	%zmm2, (%r13,%rax)
vmovdqu8	%zmm3, (%r12,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_3vect_dot_prod_avx512_gfni.loop64
gf_3vect_dot_prod_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_3vect_dot_prod_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
movq	%rdx, %r11
xorq	%r10, %r10
..@11.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0 {%k1}
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm4
vpbroadcastq	(%r11,%rsi,4), %zmm5
vpbroadcastq	(%r11,%rsi,8), %zmm6
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm4, %zmm0, %zmm4
vgf2p8affineqb	$0x0, %zmm5, %zmm0, %zmm5
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm6
vpxorq	%zmm4, %zmm1, %zmm1
vpxorq	%zmm5, %zmm2, %zmm2
vpxorq	%zmm6, %zmm3, %zmm3
cmpq	%rsi, %r10
jl	..@11.next_vect
vmovdqu8	%zmm1, (%r8,%rax) {%k1}
vmovdqu8	%zmm2, (%r13,%rax) {%k1}
vmovdqu8	%zmm3, (%r12,%rax) {%k1}
gf_3vect_dot_prod_avx512_gfni.exit:
vzeroupper
popq	%r13
popq	%r12
retq

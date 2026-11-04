	.text
gf_4vect_dot_prod_avx512_gfni:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
xorq	%rax, %rax
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	(%r8), %r8
cmpq	$0x40, %rdi
jl	gf_4vect_dot_prod_avx512_gfni.len_lt_64
gf_4vect_dot_prod_avx512_gfni.loop64:
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm5
vpbroadcastq	(%r11,%rsi,4), %zmm6
vpbroadcastq	(%r11,%rsi,8), %zmm7
vpbroadcastq	(%r11,%r15), %zmm8
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm5, %zmm0, %zmm5
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm6
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm8
vpxorq	%zmm5, %zmm1, %zmm1
vpxorq	%zmm6, %zmm2, %zmm2
vpxorq	%zmm7, %zmm3, %zmm3
vpxorq	%zmm8, %zmm4, %zmm4
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu8	%zmm1, (%r8,%rax)
vmovdqu8	%zmm2, (%r13,%rax)
vmovdqu8	%zmm3, (%r12,%rax)
vmovdqu8	%zmm4, (%r14,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_4vect_dot_prod_avx512_gfni.loop64
gf_4vect_dot_prod_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_4vect_dot_prod_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
movq	%rdx, %r11
xorq	%r10, %r10
..@11.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0 {%k1}
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm5
vpbroadcastq	(%r11,%rsi,4), %zmm6
vpbroadcastq	(%r11,%rsi,8), %zmm7
vpbroadcastq	(%r11,%r15), %zmm8
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm5, %zmm0, %zmm5
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm6
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm8
vpxorq	%zmm5, %zmm1, %zmm1
vpxorq	%zmm6, %zmm2, %zmm2
vpxorq	%zmm7, %zmm3, %zmm3
vpxorq	%zmm8, %zmm4, %zmm4
cmpq	%rsi, %r10
jl	..@11.next_vect
vmovdqu8	%zmm1, (%r8,%rax) {%k1}
vmovdqu8	%zmm2, (%r13,%rax) {%k1}
vmovdqu8	%zmm3, (%r12,%rax) {%k1}
vmovdqu8	%zmm4, (%r14,%rax) {%k1}
gf_4vect_dot_prod_avx512_gfni.exit:
vzeroupper
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq

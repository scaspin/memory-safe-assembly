	.text
gf_6vect_dot_prod_avx512_gfni:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
pushq	%rbp
pushq	%rbx
xorq	%rax, %rax
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
movq	%rsi, %rbx
imulq	$0xa0, %rbx, %rbx
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	0x20(%r8), %rbp
cmpq	$0x40, %rdi
jl	gf_6vect_dot_prod_avx512_gfni.len_lt_64
gf_6vect_dot_prod_avx512_gfni.loop64:
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm5, %zmm5, %zmm5
vpxorq	%zmm6, %zmm6, %zmm6
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm7
vpbroadcastq	(%r11,%rsi,4), %zmm8
vpbroadcastq	(%r11,%rsi,8), %zmm9
vpbroadcastq	(%r11,%r15), %zmm10
shlq	$0x4, %rsi
vpbroadcastq	(%r11,%rsi), %zmm11
shrq	$0x4, %rsi
vpbroadcastq	(%r11,%rbx), %zmm12
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm8
vgf2p8affineqb	$0x0, %zmm9, %zmm0, %zmm9
vgf2p8affineqb	$0x0, %zmm10, %zmm0, %zmm10
vgf2p8affineqb	$0x0, %zmm11, %zmm0, %zmm11
vgf2p8affineqb	$0x0, %zmm12, %zmm0, %zmm12
vpxorq	%zmm7, %zmm1, %zmm1
vpxorq	%zmm8, %zmm2, %zmm2
vpxorq	%zmm9, %zmm3, %zmm3
vpxorq	%zmm10, %zmm4, %zmm4
vpxorq	%zmm11, %zmm5, %zmm5
vpxorq	%zmm12, %zmm6, %zmm6
cmpq	%rsi, %r10
jl	..@9.next_vect
movq	(%r8), %r9
movq	0x28(%r8), %r11
vmovdqu8	%zmm2, (%r13,%rax)
vmovdqu8	%zmm3, (%r12,%rax)
vmovdqu8	%zmm4, (%r14,%rax)
vmovdqu8	%zmm5, (%rbp,%rax)
vmovdqu8	%zmm1, (%r9,%rax)
vmovdqu8	%zmm6, (%r11,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_6vect_dot_prod_avx512_gfni.loop64
gf_6vect_dot_prod_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_6vect_dot_prod_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm5, %zmm5, %zmm5
vpxorq	%zmm6, %zmm6, %zmm6
movq	%rdx, %r11
xorq	%r10, %r10
..@11.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0 {%k1}
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm7
vpbroadcastq	(%r11,%rsi,4), %zmm8
vpbroadcastq	(%r11,%rsi,8), %zmm9
vpbroadcastq	(%r11,%r15), %zmm10
shlq	$0x4, %rsi
vpbroadcastq	(%r11,%rsi), %zmm11
shrq	$0x4, %rsi
vpbroadcastq	(%r11,%rbx), %zmm12
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm8
vgf2p8affineqb	$0x0, %zmm9, %zmm0, %zmm9
vgf2p8affineqb	$0x0, %zmm10, %zmm0, %zmm10
vgf2p8affineqb	$0x0, %zmm11, %zmm0, %zmm11
vgf2p8affineqb	$0x0, %zmm12, %zmm0, %zmm12
vpxorq	%zmm7, %zmm1, %zmm1
vpxorq	%zmm8, %zmm2, %zmm2
vpxorq	%zmm9, %zmm3, %zmm3
vpxorq	%zmm10, %zmm4, %zmm4
vpxorq	%zmm11, %zmm5, %zmm5
vpxorq	%zmm12, %zmm6, %zmm6
cmpq	%rsi, %r10
jl	..@11.next_vect
movq	(%r8), %r9
movq	0x28(%r8), %r11
vmovdqu8	%zmm2, (%r13,%rax) {%k1}
vmovdqu8	%zmm3, (%r12,%rax) {%k1}
vmovdqu8	%zmm4, (%r14,%rax) {%k1}
vmovdqu8	%zmm5, (%rbp,%rax) {%k1}
vmovdqu8	%zmm1, (%r9,%rax) {%k1}
vmovdqu8	%zmm6, (%r11,%rax) {%k1}
gf_6vect_dot_prod_avx512_gfni.exit:
vzeroupper
popq	%rbx
popq	%rbp
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq

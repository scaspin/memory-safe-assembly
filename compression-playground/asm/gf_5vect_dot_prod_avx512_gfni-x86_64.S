	.text
gf_5vect_dot_prod_avx512_gfni:
endbr64
subq	$0x30, %rsp
movq	%r12, (%rsp)
movq	%r13, 0x8(%rsp)
movq	%r14, 0x10(%rsp)
movq	%r15, 0x18(%rsp)
movq	%rbp, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
xorq	%rax, %rax
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
movq	%rsi, %rbx
imulq	$0x80, %rbx, %rbx
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	0x20(%r8), %rbp
movq	(%r8), %r8
cmpq	$0x40, %rdi
jl	gf_5vect_dot_prod_avx512_gfni.len_lt_64
gf_5vect_dot_prod_avx512_gfni.loop64:
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm5, %zmm5, %zmm5
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm6
vpbroadcastq	(%r11,%rsi,4), %zmm7
vpbroadcastq	(%r11,%rsi,8), %zmm8
vpbroadcastq	(%r11,%r15), %zmm9
vpbroadcastq	(%r11,%rbx), %zmm10
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm6
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm8
vgf2p8affineqb	$0x0, %zmm9, %zmm0, %zmm9
vgf2p8affineqb	$0x0, %zmm10, %zmm0, %zmm10
vpxorq	%zmm6, %zmm1, %zmm1
vpxorq	%zmm7, %zmm2, %zmm2
vpxorq	%zmm8, %zmm3, %zmm3
vpxorq	%zmm9, %zmm4, %zmm4
vpxorq	%zmm10, %zmm5, %zmm5
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu8	%zmm1, (%r8,%rax)
vmovdqu8	%zmm2, (%r13,%rax)
vmovdqu8	%zmm3, (%r12,%rax)
vmovdqu8	%zmm4, (%r14,%rax)
vmovdqu8	%zmm5, (%rbp,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_5vect_dot_prod_avx512_gfni.loop64
gf_5vect_dot_prod_avx512_gfni.len_lt_64:
cmpq	$0x0, %rdi
jle	gf_5vect_dot_prod_avx512_gfni.exit
xorq	%r11, %r11
btsq	%rdi, %r11
decq	%r11
kmovq	%r11, %k1
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm5, %zmm5, %zmm5
movq	%rdx, %r11
xorq	%r10, %r10
..@11.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0 {%k1}
addq	$0x8, %r10
vpbroadcastq	(%r11), %zmm6
vpbroadcastq	(%r11,%rsi,4), %zmm7
vpbroadcastq	(%r11,%rsi,8), %zmm8
vpbroadcastq	(%r11,%r15), %zmm9
vpbroadcastq	(%r11,%rbx), %zmm10
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %zmm6, %zmm0, %zmm6
vgf2p8affineqb	$0x0, %zmm7, %zmm0, %zmm7
vgf2p8affineqb	$0x0, %zmm8, %zmm0, %zmm8
vgf2p8affineqb	$0x0, %zmm9, %zmm0, %zmm9
vgf2p8affineqb	$0x0, %zmm10, %zmm0, %zmm10
vpxorq	%zmm6, %zmm1, %zmm1
vpxorq	%zmm7, %zmm2, %zmm2
vpxorq	%zmm8, %zmm3, %zmm3
vpxorq	%zmm9, %zmm4, %zmm4
vpxorq	%zmm10, %zmm5, %zmm5
cmpq	%rsi, %r10
jl	..@11.next_vect
vmovdqu8	%zmm1, (%r8,%rax) {%k1}
vmovdqu8	%zmm2, (%r13,%rax) {%k1}
vmovdqu8	%zmm3, (%r12,%rax) {%k1}
vmovdqu8	%zmm4, (%r14,%rax) {%k1}
vmovdqu8	%zmm5, (%rbp,%rax) {%k1}
gf_5vect_dot_prod_avx512_gfni.exit:
vzeroupper
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
addq	$0x30, %rsp
retq

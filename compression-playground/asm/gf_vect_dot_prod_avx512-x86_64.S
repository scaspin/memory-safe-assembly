	.text
gf_vect_dot_prod_avx512:
endbr64
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm5
shlq	$0x3, %rsi
subq	$0x40, %rdi
jl	gf_vect_dot_prod_avx512.len_lt_64
gf_vect_dot_prod_avx512.loop64:
vpxorq	%zmm2, %zmm2, %zmm2
movq	%rdx, %r11
xorq	%r10, %r10
gf_vect_dot_prod_avx512.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpandq	%zmm5, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm5, %zmm0, %zmm0
vmovdqu8	(%r11), %ymm4
addq	$0x20, %r11
vshufi64x2	$0x55, %zmm4, %zmm4, %zmm3
vshufi64x2	$0x0, %zmm4, %zmm4, %zmm4
vpshufb	%zmm0, %zmm3, %zmm3
vpshufb	%zmm1, %zmm4, %zmm4
vpxorq	%zmm4, %zmm3, %zmm3
vpxorq	%zmm3, %zmm2, %zmm2
cmpq	%rsi, %r10
jl	gf_vect_dot_prod_avx512.next_vect
vmovdqu8	%zmm2, (%r8,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_vect_dot_prod_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_dot_prod_avx512.return_pass
movq	%rdi, %rax
jmp	gf_vect_dot_prod_avx512.loop64
gf_vect_dot_prod_avx512.len_lt_64:
addq	$0x20, %rdi
jl	gf_vect_dot_prod_avx512.return_fail
gf_vect_dot_prod_avx512.loop32:
vpxorq	%zmm2, %zmm2, %zmm2
movq	%rdx, %r11
xorq	%r10, %r10
gf_vect_dot_prod_avx512.next_vect2:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %ymm0
addq	$0x8, %r10
vpsraw	$0x4, %zmm0, %zmm1
vshufi64x2	$0x44, %zmm1, %zmm0, %zmm0
vpandq	%zmm5, %zmm0, %zmm0
vmovdqu8	(%r11), %ymm4
addq	$0x20, %r11
vshufi64x2	$0x50, %zmm4, %zmm4, %zmm4
vpshufb	%zmm0, %zmm4, %zmm4
vshufi64x2	$0xe, %zmm4, %zmm4, %zmm3
vpxorq	%zmm4, %zmm3, %zmm3
vpxorq	%zmm3, %zmm2, %zmm2
cmpq	%rsi, %r10
jl	gf_vect_dot_prod_avx512.next_vect2
vmovdqu8	%ymm2, (%r8,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_vect_dot_prod_avx512.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_dot_prod_avx512.return_pass
movq	%rdi, %rax
jmp	gf_vect_dot_prod_avx512.loop32
gf_vect_dot_prod_avx512.return_pass:
movl	$0x0, %eax
retq
gf_vect_dot_prod_avx512.return_fail:
movl	$0x1, %eax
retq

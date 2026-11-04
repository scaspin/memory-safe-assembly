	.text
gf_2vect_dot_prod_avx512:
endbr64
pushq	%r12
subq	$0x40, %rdi
jl	gf_2vect_dot_prod_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm8
shlq	$0x3, %rsi
movq	0x8(%r8), %r12
movq	(%r8), %r8
gf_2vect_dot_prod_avx512.loop64:
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
movq	%rdx, %r11
xorq	%r10, %r10
gf_2vect_dot_prod_avx512.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpandq	%zmm8, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm8, %zmm0, %zmm0
vmovdqu8	(%r11), %ymm7
vmovdqu8	(%r11,%rsi,4), %ymm5
addq	$0x20, %r11
vshufi64x2	$0x55, %zmm7, %zmm7, %zmm6
vshufi64x2	$0x0, %zmm7, %zmm7, %zmm7
vshufi64x2	$0x55, %zmm5, %zmm5, %zmm4
vshufi64x2	$0x0, %zmm5, %zmm5, %zmm5
vpshufb	%zmm0, %zmm6, %zmm6
vpshufb	%zmm1, %zmm7, %zmm7
vpxorq	%zmm7, %zmm6, %zmm6
vpxorq	%zmm6, %zmm2, %zmm2
vpshufb	%zmm0, %zmm4, %zmm4
vpshufb	%zmm1, %zmm5, %zmm5
vpxorq	%zmm5, %zmm4, %zmm4
vpxorq	%zmm4, %zmm3, %zmm3
cmpq	%rsi, %r10
jl	gf_2vect_dot_prod_avx512.next_vect
vmovdqu8	%zmm2, (%r8,%rax)
vmovdqu8	%zmm3, (%r12,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_2vect_dot_prod_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_dot_prod_avx512.return_pass
movq	%rdi, %rax
jmp	gf_2vect_dot_prod_avx512.loop64
gf_2vect_dot_prod_avx512.return_pass:
movl	$0x0, %eax
popq	%r12
retq
gf_2vect_dot_prod_avx512.return_fail:
movl	$0x1, %eax
popq	%r12
retq

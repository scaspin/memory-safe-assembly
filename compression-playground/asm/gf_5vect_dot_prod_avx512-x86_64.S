	.text
gf_5vect_dot_prod_avx512:
endbr64
subq	$0x30, %rsp
movq	%r12, (%rsp)
movq	%r13, 0x8(%rsp)
movq	%r14, 0x10(%rsp)
movq	%r15, 0x18(%rsp)
movq	%rbp, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
subq	$0x40, %rdi
jl	gf_5vect_dot_prod_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm17
movq	%rsi, %rbx
imulq	$0x20, %rbx, %rbx
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	0x20(%r8), %rbp
movq	(%r8), %r8
gf_5vect_dot_prod_avx512.loop64:
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm5, %zmm5, %zmm5
vpxorq	%zmm6, %zmm6, %zmm6
movq	%rdx, %r11
xorq	%r10, %r10
gf_5vect_dot_prod_avx512.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpandq	%zmm17, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm17, %zmm0, %zmm0
vmovdqu8	(%r11), %ymm16
vmovdqu8	(%r11,%rsi,4), %ymm14
vmovdqu8	(%r11,%rsi,8), %ymm12
vmovdqu8	(%r11,%r15), %ymm10
vmovdqu8	(%r11,%rbx,4), %ymm8
addq	$0x20, %r11
vshufi64x2	$0x55, %zmm16, %zmm16, %zmm15
vshufi64x2	$0x0, %zmm16, %zmm16, %zmm16
vshufi64x2	$0x55, %zmm14, %zmm14, %zmm13
vshufi64x2	$0x0, %zmm14, %zmm14, %zmm14
vpshufb	%zmm0, %zmm15, %zmm15
vpshufb	%zmm1, %zmm16, %zmm16
vpxorq	%zmm16, %zmm15, %zmm15
vpxorq	%zmm15, %zmm2, %zmm2
vpshufb	%zmm0, %zmm13, %zmm13
vpshufb	%zmm1, %zmm14, %zmm14
vpxorq	%zmm14, %zmm13, %zmm13
vpxorq	%zmm13, %zmm3, %zmm3
vshufi64x2	$0x55, %zmm12, %zmm12, %zmm11
vshufi64x2	$0x0, %zmm12, %zmm12, %zmm12
vshufi64x2	$0x55, %zmm10, %zmm10, %zmm9
vshufi64x2	$0x0, %zmm10, %zmm10, %zmm10
vpshufb	%zmm0, %zmm11, %zmm11
vpshufb	%zmm1, %zmm12, %zmm12
vpxorq	%zmm12, %zmm11, %zmm11
vpxorq	%zmm11, %zmm4, %zmm4
vpshufb	%zmm0, %zmm9, %zmm9
vpshufb	%zmm1, %zmm10, %zmm10
vpxorq	%zmm10, %zmm9, %zmm9
vpxorq	%zmm9, %zmm5, %zmm5
vshufi64x2	$0x55, %zmm8, %zmm8, %zmm7
vshufi64x2	$0x0, %zmm8, %zmm8, %zmm8
vpshufb	%zmm0, %zmm7, %zmm7
vpshufb	%zmm1, %zmm8, %zmm8
vpxorq	%zmm8, %zmm7, %zmm7
vpxorq	%zmm7, %zmm6, %zmm6
cmpq	%rsi, %r10
jl	gf_5vect_dot_prod_avx512.next_vect
vmovdqu8	%zmm2, (%r8,%rax)
vmovdqu8	%zmm3, (%r13,%rax)
vmovdqu8	%zmm4, (%r12,%rax)
vmovdqu8	%zmm5, (%r14,%rax)
vmovdqu8	%zmm6, (%rbp,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_5vect_dot_prod_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_5vect_dot_prod_avx512.return_pass
movq	%rdi, %rax
jmp	gf_5vect_dot_prod_avx512.loop64
gf_5vect_dot_prod_avx512.return_pass:
movl	$0x0, %eax
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
addq	$0x30, %rsp
retq
gf_5vect_dot_prod_avx512.return_fail:
movl	$0x1, %eax
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
addq	$0x30, %rsp
retq

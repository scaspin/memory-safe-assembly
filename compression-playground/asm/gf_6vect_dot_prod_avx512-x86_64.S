	.text
gf_6vect_dot_prod_avx512:
endbr64
subq	$0x30, %rsp
movq	%r12, (%rsp)
movq	%r13, 0x8(%rsp)
movq	%r14, 0x10(%rsp)
movq	%r15, 0x18(%rsp)
movq	%rbp, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
subq	$0x40, %rdi
jl	gf_6vect_dot_prod_avx512.return_fail
xorq	%rax, %rax
movl	$0xf, %r11d
vpbroadcastb	%r11d, %zmm20
movq	%rsi, %rbx
imulq	$0x20, %rbx, %rbx
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	0x20(%r8), %rbp
gf_6vect_dot_prod_avx512.loop64:
vpxorq	%zmm2, %zmm2, %zmm2
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm5, %zmm5, %zmm5
vpxorq	%zmm6, %zmm6, %zmm6
vpxorq	%zmm7, %zmm7, %zmm7
movq	%rdx, %r11
xorq	%r10, %r10
gf_6vect_dot_prod_avx512.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu8	(%r9,%rax), %zmm0
addq	$0x8, %r10
vpandq	%zmm20, %zmm0, %zmm1
vpsraw	$0x4, %zmm0, %zmm0
vpandq	%zmm20, %zmm0, %zmm0
vmovdqu8	(%r11), %ymm19
vmovdqu8	(%r11,%rsi,4), %ymm17
vmovdqu8	(%r11,%rsi,8), %ymm15
vmovdqu8	(%r11,%r15), %ymm13
vmovdqu8	(%r11,%rbx,4), %ymm11
leaq	(%rbx,%rbx,4), %r9
vmovdqu8	(%r11,%r9), %ymm9
addq	$0x20, %r11
vshufi64x2	$0x55, %zmm19, %zmm19, %zmm18
vshufi64x2	$0x0, %zmm19, %zmm19, %zmm19
vshufi64x2	$0x55, %zmm17, %zmm17, %zmm16
vshufi64x2	$0x0, %zmm17, %zmm17, %zmm17
vpshufb	%zmm0, %zmm18, %zmm18
vpshufb	%zmm1, %zmm19, %zmm19
vpxorq	%zmm19, %zmm18, %zmm18
vpxorq	%zmm18, %zmm2, %zmm2
vpshufb	%zmm0, %zmm16, %zmm16
vpshufb	%zmm1, %zmm17, %zmm17
vpxorq	%zmm17, %zmm16, %zmm16
vpxorq	%zmm16, %zmm3, %zmm3
vshufi64x2	$0x55, %zmm15, %zmm15, %zmm14
vshufi64x2	$0x0, %zmm15, %zmm15, %zmm15
vshufi64x2	$0x55, %zmm13, %zmm13, %zmm12
vshufi64x2	$0x0, %zmm13, %zmm13, %zmm13
vpshufb	%zmm0, %zmm14, %zmm14
vpshufb	%zmm1, %zmm15, %zmm15
vpxorq	%zmm15, %zmm14, %zmm14
vpxorq	%zmm14, %zmm4, %zmm4
vpshufb	%zmm0, %zmm12, %zmm12
vpshufb	%zmm1, %zmm13, %zmm13
vpxorq	%zmm13, %zmm12, %zmm12
vpxorq	%zmm12, %zmm5, %zmm5
vshufi64x2	$0x55, %zmm11, %zmm11, %zmm10
vshufi64x2	$0x0, %zmm11, %zmm11, %zmm11
vpshufb	%zmm0, %zmm10, %zmm10
vpshufb	%zmm1, %zmm11, %zmm11
vpxorq	%zmm11, %zmm10, %zmm10
vpxorq	%zmm10, %zmm6, %zmm6
vshufi64x2	$0x55, %zmm9, %zmm9, %zmm8
vshufi64x2	$0x0, %zmm9, %zmm9, %zmm9
vpshufb	%zmm0, %zmm8, %zmm8
vpshufb	%zmm1, %zmm9, %zmm9
vpxorq	%zmm9, %zmm8, %zmm8
vpxorq	%zmm8, %zmm7, %zmm7
cmpq	%rsi, %r10
jl	gf_6vect_dot_prod_avx512.next_vect
movq	(%r8), %r9
movq	0x28(%r8), %r11
vmovdqu8	%zmm3, (%r13,%rax)
vmovdqu8	%zmm4, (%r12,%rax)
vmovdqu8	%zmm5, (%r14,%rax)
vmovdqu8	%zmm6, (%rbp,%rax)
vmovdqu8	%zmm2, (%r9,%rax)
vmovdqu8	%zmm7, (%r11,%rax)
addq	$0x40, %rax
cmpq	%rdi, %rax
jle	gf_6vect_dot_prod_avx512.loop64
leaq	0x40(%rdi), %r11
cmpq	%r11, %rax
je	gf_6vect_dot_prod_avx512.return_pass
movq	%rdi, %rax
jmp	gf_6vect_dot_prod_avx512.loop64
gf_6vect_dot_prod_avx512.return_pass:
movl	$0x0, %eax
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
addq	$0x30, %rsp
retq
gf_6vect_dot_prod_avx512.return_fail:
movl	$0x1, %eax
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
addq	$0x30, %rsp
retq

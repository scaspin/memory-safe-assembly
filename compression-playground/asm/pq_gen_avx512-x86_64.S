	.text
pq_gen_avx512:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0x1f, %rsi
jne	return_fail
xorl	%eax, %eax
movl	$0x1d, %r11d
vpbroadcastb	%r11d, %zmm9
vpxorq	%zmm8, %zmm8, %zmm8
cmpq	$0x80, %rsi
jl	loop32
len_aligned_32bytes:
subq	$0x80, %rsi
loop128:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovdqu8	(%rcx,%rax), %zmm3
vmovdqu8	0x40(%rcx,%rax), %zmm7
vpxorq	%zmm0, %zmm0, %zmm0
vpxorq	%zmm4, %zmm4, %zmm4
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm5, %zmm5, %zmm5
next_vect:
movq	(%rdx,%r11,8), %rcx
vpxorq	%zmm3, %zmm1, %zmm1
vpxorq	%zmm7, %zmm5, %zmm5
vpxorq	%zmm3, %zmm0, %zmm0
vpxorq	%zmm7, %zmm4, %zmm4
vpcmpltb	%zmm8, %zmm1, %k1
vpcmpltb	%zmm8, %zmm5, %k2
vpblendmb	%zmm9, %zmm8, %zmm2 {%k1}
vpblendmb	%zmm9, %zmm8, %zmm6 {%k2}
vmovdqu8	(%rcx,%rax), %zmm3
vmovdqu8	0x40(%rcx,%rax), %zmm7
vpaddb	%zmm1, %zmm1, %zmm1
vpaddb	%zmm5, %zmm5, %zmm5
vpxorq	%zmm2, %zmm1, %zmm1
vpxorq	%zmm6, %zmm5, %zmm5
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxorq	%zmm3, %zmm0, %zmm0
vpxorq	%zmm3, %zmm1, %zmm1
vpxorq	%zmm7, %zmm4, %zmm4
vpxorq	%zmm7, %zmm5, %zmm5
vmovdqu8	%zmm0, (%rcx,%rax)
vmovdqu8	%zmm4, 0x40(%rcx,%rax)
vmovdqu8	%zmm1, (%r11,%rax)
vmovdqu8	%zmm5, 0x40(%r11,%rax)
addq	$0x80, %rax
cmpq	%rsi, %rax
jle	loop128
addq	$0x80, %rsi
cmpq	%rsi, %rax
je	return_pass
loop32:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovdqu8	(%rcx,%rax), %ymm3
vpxorq	%ymm0, %ymm0, %ymm0
vpxorq	%ymm1, %ymm1, %ymm1
next_vect32:
movq	(%rdx,%r11,8), %rcx
vpxorq	%ymm3, %ymm1, %ymm1
vpblendvb	%ymm1, %ymm9, %ymm8, %ymm2
vpxorq	%ymm3, %ymm0, %ymm0
vpaddb	%ymm1, %ymm1, %ymm1
vpxorq	%ymm2, %ymm1, %ymm1
vmovdqu8	(%rcx,%rax), %ymm3
subq	$0x1, %r11
jae	next_vect32
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxorq	%ymm3, %ymm0, %ymm0
vpxorq	%ymm3, %ymm1, %ymm1
vmovdqu8	%ymm0, (%rcx,%rax)
vmovdqu8	%ymm1, (%r11,%rax)
addq	$0x20, %rax
cmpq	%rsi, %rax
jl	loop32
return_pass:
xorl	%eax, %eax
retq
return_fail:
movl	$0x1, %eax
retq

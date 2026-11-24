	.text
pq_gen_avx512_gfni:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0x1f, %rsi
jne	return_fail
vmovdqa64	gf_matrix(%rip), %zmm6
xorl	%eax, %eax
cmpq	$0x80, %rsi
jl	loop32
len_aligned_32bytes:
subq	$0x80, %rsi
loop128:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovdqu8	(%rcx,%rax), %zmm2
vmovdqu8	0x40(%rcx,%rax), %zmm5
vpxorq	%zmm0, %zmm0, %zmm0
vpxorq	%zmm3, %zmm3, %zmm3
vpxorq	%zmm1, %zmm1, %zmm1
vpxorq	%zmm4, %zmm4, %zmm4
next_vect:
movq	(%rdx,%r11,8), %rcx
vpxorq	%zmm2, %zmm1, %zmm1
vpxorq	%zmm5, %zmm4, %zmm4
vpxorq	%zmm2, %zmm0, %zmm0
vpxorq	%zmm5, %zmm3, %zmm3
vmovdqu8	(%rcx,%rax), %zmm2
vmovdqu8	0x40(%rcx,%rax), %zmm5
vgf2p8affineqb	$0x0, %zmm6, %zmm1, %zmm1
vgf2p8affineqb	$0x0, %zmm6, %zmm4, %zmm4
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxorq	%zmm2, %zmm0, %zmm0
vpxorq	%zmm2, %zmm1, %zmm1
vpxorq	%zmm5, %zmm3, %zmm3
vpxorq	%zmm5, %zmm4, %zmm4
vmovdqu8	%zmm0, (%rcx,%rax)
vmovdqu8	%zmm3, 0x40(%rcx,%rax)
vmovdqu8	%zmm1, (%r11,%rax)
vmovdqu8	%zmm4, 0x40(%r11,%rax)
addq	$0x80, %rax
cmpq	%rsi, %rax
jle	loop128
addq	$0x80, %rsi
cmpq	%rsi, %rax
je	return_pass
loop32:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovdqu8	(%rcx,%rax), %ymm2
vpxorq	%ymm0, %ymm0, %ymm0
vpxorq	%ymm1, %ymm1, %ymm1
next_vect32:
movq	(%rdx,%r11,8), %rcx
vpxorq	%ymm2, %ymm1, %ymm1
vgf2p8affineqb	$0x0, %ymm6, %ymm1, %ymm1
vpxorq	%ymm2, %ymm0, %ymm0
vmovdqu8	(%rcx,%rax), %ymm2
subq	$0x1, %r11
jae	next_vect32
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxorq	%ymm2, %ymm0, %ymm0
vpxorq	%ymm2, %ymm1, %ymm1
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
	.section .rodata_in_text
gf_matrix:
	.size gf_matrix, 64
	.byte 64,32,16,136,132,130,1,128,64,32,16,136,132,130,1,128
	.byte 64,32,16,136,132,130,1,128,64,32,16,136,132,130,1,128
	.byte 64,32,16,136,132,130,1,128,64,32,16,136,132,130,1,128
	.byte 64,32,16,136,132,130,1,128,64,32,16,136,132,130,1,128

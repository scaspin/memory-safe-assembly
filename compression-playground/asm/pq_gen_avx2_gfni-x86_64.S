	.text
pq_gen_avx2_gfni:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0x1f, %rsi
jne	return_fail
vmovdqa	gf_matrix(%rip), %ymm6
xorl	%eax, %eax
cmpq	$0x40, %rsi
jb	loop32
len_aligned_32bytes:
subq	$0x40, %rsi
loop64:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovdqu	(%rcx,%rax), %ymm2
vmovdqu	0x20(%rcx,%rax), %ymm5
vpxor	%ymm0, %ymm0, %ymm0
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm1, %ymm1, %ymm1
vpxor	%ymm4, %ymm4, %ymm4
next_vect:
movq	(%rdx,%r11,8), %rcx
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm5, %ymm4, %ymm4
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm5, %ymm3, %ymm3
vmovdqu	(%rcx,%rax), %ymm2
vmovdqu	0x20(%rcx,%rax), %ymm5
vgf2p8affineqb	$0x0, %ymm6, %ymm1, %ymm1
vgf2p8affineqb	$0x0, %ymm6, %ymm4, %ymm4
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm5, %ymm3, %ymm3
vpxor	%ymm5, %ymm4, %ymm4
vmovdqu	%ymm0, (%rcx,%rax)
vmovdqu	%ymm3, 0x20(%rcx,%rax)
vmovdqu	%ymm1, (%r11,%rax)
vmovdqu	%ymm4, 0x20(%r11,%rax)
addq	$0x40, %rax
cmpq	%rsi, %rax
jle	loop64
addq	$0x40, %rsi
cmpq	%rsi, %rax
je	return_pass
loop32:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovdqu	(%rcx,%rax), %ymm2
vpxor	%ymm0, %ymm0, %ymm0
vpxor	%ymm1, %ymm1, %ymm1
next_vect32:
movq	(%rdx,%r11,8), %rcx
vpxor	%ymm2, %ymm1, %ymm1
vgf2p8affineqb	$0x0, %ymm6, %ymm1, %ymm1
vpxor	%ymm2, %ymm0, %ymm0
vmovdqu	(%rcx,%rax), %ymm2
subq	$0x1, %r11
jae	next_vect32
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm2, %ymm1, %ymm1
vmovdqu	%ymm0, (%rcx,%rax)
vmovdqu	%ymm1, (%r11,%rax)
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
	.size gf_matrix, 32
	.byte 64,32,16,136,132,130,1,128,64,32,16,136,132,130,1,128
	.byte 64,32,16,136,132,130,1,128,64,32,16,136,132,130,1,128

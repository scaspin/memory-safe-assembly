	.text
pq_gen_avx2:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0x1f, %rsi
jne	return_fail
xorl	%eax, %eax
vmovdqa	poly(%rip), %ymm15
vpxor	%ymm14, %ymm14, %ymm14
cmpq	$0x60, %rsi
jl	loop32
len_aligned_32bytes:
subq	$0x60, %rsi
loop96:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovntdqa	(%rcx,%rax), %ymm3
vmovntdqa	0x20(%rcx,%rax), %ymm7
vmovntdqa	0x40(%rcx,%rax), %ymm11
vpxor	%ymm0, %ymm0, %ymm0
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm8, %ymm8, %ymm8
vpxor	%ymm1, %ymm1, %ymm1
vpxor	%ymm5, %ymm5, %ymm5
vpxor	%ymm9, %ymm9, %ymm9
next_vect:
movq	(%rdx,%r11,8), %rcx
vpxor	%ymm3, %ymm1, %ymm1
vpxor	%ymm7, %ymm5, %ymm5
vpxor	%ymm11, %ymm9, %ymm9
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm7, %ymm4, %ymm4
vpxor	%ymm11, %ymm8, %ymm8
vpblendvb	%ymm1, %ymm15, %ymm14, %ymm2
vpblendvb	%ymm5, %ymm15, %ymm14, %ymm6
vpblendvb	%ymm9, %ymm15, %ymm14, %ymm10
vmovntdqa	(%rcx,%rax), %ymm3
vmovntdqa	0x20(%rcx,%rax), %ymm7
vmovntdqa	0x40(%rcx,%rax), %ymm11
vpaddb	%ymm1, %ymm1, %ymm1
vpaddb	%ymm5, %ymm5, %ymm5
vpaddb	%ymm9, %ymm9, %ymm9
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm6, %ymm5, %ymm5
vpxor	%ymm10, %ymm9, %ymm9
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm3, %ymm1, %ymm1
vpxor	%ymm7, %ymm4, %ymm4
vpxor	%ymm7, %ymm5, %ymm5
vpxor	%ymm11, %ymm8, %ymm8
vpxor	%ymm11, %ymm9, %ymm9
vmovntdq	%ymm0, (%rcx,%rax)
vmovntdq	%ymm4, 0x20(%rcx,%rax)
vmovntdq	%ymm8, 0x40(%rcx,%rax)
vmovntdq	%ymm1, (%r11,%rax)
vmovntdq	%ymm5, 0x20(%r11,%rax)
vmovntdq	%ymm9, 0x40(%r11,%rax)
addq	$0x60, %rax
cmpq	%rsi, %rax
jle	loop96
addq	$0x60, %rsi
cmpq	%rsi, %rax
je	return_pass
loop32:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovntdqa	(%rcx,%rax), %ymm3
vpxor	%ymm0, %ymm0, %ymm0
vpxor	%ymm1, %ymm1, %ymm1
next_vect32:
movq	(%rdx,%r11,8), %rcx
vpxor	%ymm3, %ymm1, %ymm1
vpblendvb	%ymm1, %ymm15, %ymm14, %ymm2
vpxor	%ymm3, %ymm0, %ymm0
vpaddb	%ymm1, %ymm1, %ymm1
vpxor	%ymm2, %ymm1, %ymm1
vmovntdqa	(%rcx,%rax), %ymm3
subq	$0x1, %r11
jae	next_vect32
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxor	%ymm3, %ymm0, %ymm0
vpxor	%ymm3, %ymm1, %ymm1
vmovntdq	%ymm0, (%rcx,%rax)
vmovntdq	%ymm1, (%r11,%rax)
addq	$0x20, %rax
cmpq	%rsi, %rax
jl	loop32
return_pass:
xorl	%eax, %eax
retq
return_fail:
movl	$0x1, %eax
retq
	.section .data
poly:
	.byte 29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29
	.byte 29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29

	.text
pq_gen_avx:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0xf, %rsi
jne	return_fail
xorl	%eax, %eax
vmovdqa	poly(%rip), %xmm15
vpxor	%xmm14, %xmm14, %xmm14
cmpq	$0x30, %rsi
jl	loop16
len_aligned_32bytes:
subq	$0x30, %rsi
loop48:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovntdqa	(%rcx,%rax), %xmm3
vmovntdqa	0x10(%rcx,%rax), %xmm7
vmovntdqa	0x20(%rcx,%rax), %xmm11
vpxor	%xmm0, %xmm0, %xmm0
vpxor	%xmm4, %xmm4, %xmm4
vpxor	%xmm8, %xmm8, %xmm8
vpxor	%xmm1, %xmm1, %xmm1
vpxor	%xmm5, %xmm5, %xmm5
vpxor	%xmm9, %xmm9, %xmm9
next_vect:
movq	(%rdx,%r11,8), %rcx
vpxor	%xmm3, %xmm1, %xmm1
vpxor	%xmm7, %xmm5, %xmm5
vpxor	%xmm11, %xmm9, %xmm9
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm7, %xmm4, %xmm4
vpxor	%xmm11, %xmm8, %xmm8
vpblendvb	%xmm1, %xmm15, %xmm14, %xmm2
vpblendvb	%xmm5, %xmm15, %xmm14, %xmm6
vpblendvb	%xmm9, %xmm15, %xmm14, %xmm10
vmovntdqa	(%rcx,%rax), %xmm3
vmovntdqa	0x10(%rcx,%rax), %xmm7
vmovntdqa	0x20(%rcx,%rax), %xmm11
vpaddb	%xmm1, %xmm1, %xmm1
vpaddb	%xmm5, %xmm5, %xmm5
vpaddb	%xmm9, %xmm9, %xmm9
vpxor	%xmm2, %xmm1, %xmm1
vpxor	%xmm6, %xmm5, %xmm5
vpxor	%xmm10, %xmm9, %xmm9
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vpxor	%xmm7, %xmm4, %xmm4
vpxor	%xmm7, %xmm5, %xmm5
vpxor	%xmm11, %xmm8, %xmm8
vpxor	%xmm11, %xmm9, %xmm9
vmovntdq	%xmm0, (%rcx,%rax)
vmovntdq	%xmm4, 0x10(%rcx,%rax)
vmovntdq	%xmm8, 0x20(%rcx,%rax)
vmovntdq	%xmm1, (%r11,%rax)
vmovntdq	%xmm5, 0x10(%r11,%rax)
vmovntdq	%xmm9, 0x20(%r11,%rax)
addq	$0x30, %rax
cmpq	%rsi, %rax
jle	loop48
addq	$0x30, %rsi
cmpq	%rsi, %rax
je	return_pass
loop16:
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
vmovntdqa	(%rcx,%rax), %xmm3
vpxor	%xmm0, %xmm0, %xmm0
vpxor	%xmm1, %xmm1, %xmm1
next_vect16:
movq	(%rdx,%r11,8), %rcx
vpxor	%xmm3, %xmm1, %xmm1
vpblendvb	%xmm1, %xmm15, %xmm14, %xmm2
vpxor	%xmm3, %xmm0, %xmm0
vpaddb	%xmm1, %xmm1, %xmm1
vpxor	%xmm2, %xmm1, %xmm1
vmovntdqa	(%rcx,%rax), %xmm3
subq	$0x1, %r11
jae	next_vect16
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vmovntdq	%xmm0, (%rcx,%rax)
vmovntdq	%xmm1, (%r11,%rax)
addq	$0x10, %rax
cmpq	%rsi, %rax
jl	loop16
return_pass:
xorl	%eax, %eax
retq
return_fail:
movl	$0x1, %eax
retq
	.section .data
	.p2align 4
poly:
	.byte 29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29

	.text
pq_gen_sse:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0xf, %rsi
jne	return_fail
movl	$0x0, %eax
movdqa	poly(%rip), %xmm15
cmpq	$0x30, %rsi
jl	loop16
len_aligned_32bytes:
subq	$0x30, %rsi
loop48:
movq	(%rdx,%rdi,8), %rcx
movq	%rdi, %r11
movntdqa	(%rcx,%rax), %xmm3
movntdqa	0x10(%rcx,%rax), %xmm7
movntdqa	0x20(%rcx,%rax), %xmm11
pxor	%xmm0, %xmm0
pxor	%xmm4, %xmm4
pxor	%xmm8, %xmm8
pxor	%xmm1, %xmm1
pxor	%xmm5, %xmm5
pxor	%xmm9, %xmm9
next_vect:
subq	$0x1, %r11
movq	(%rdx,%r11,8), %rcx
pxor	%xmm3, %xmm1
pxor	%xmm7, %xmm5
pxor	%xmm11, %xmm9
pxor	%xmm3, %xmm0
pxor	%xmm7, %xmm4
pxor	%xmm11, %xmm8
pxor	%xmm2, %xmm2
pxor	%xmm6, %xmm6
pxor	%xmm10, %xmm10
pcmpgtb	%xmm1, %xmm2
pcmpgtb	%xmm5, %xmm6
pcmpgtb	%xmm9, %xmm10
pand	%xmm15, %xmm2
pand	%xmm15, %xmm6
pand	%xmm15, %xmm10
movntdqa	(%rcx,%rax), %xmm3
movntdqa	0x10(%rcx,%rax), %xmm7
movntdqa	0x20(%rcx,%rax), %xmm11
paddb	%xmm1, %xmm1
paddb	%xmm5, %xmm5
paddb	%xmm9, %xmm9
pxor	%xmm2, %xmm1
pxor	%xmm6, %xmm5
pxor	%xmm10, %xmm9
jg	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
pxor	%xmm3, %xmm0
pxor	%xmm3, %xmm1
pxor	%xmm7, %xmm4
pxor	%xmm7, %xmm5
pxor	%xmm11, %xmm8
pxor	%xmm11, %xmm9
movntdq	%xmm0, (%rcx,%rax)
movntdq	%xmm4, 0x10(%rcx,%rax)
movntdq	%xmm8, 0x20(%rcx,%rax)
movntdq	%xmm1, (%r11,%rax)
movntdq	%xmm5, 0x10(%r11,%rax)
movntdq	%xmm9, 0x20(%r11,%rax)
addq	$0x30, %rax
cmpq	%rsi, %rax
jle	loop48
addq	$0x30, %rsi
cmpq	%rsi, %rax
je	return_pass
loop16:
movq	(%rdx,%rdi,8), %rcx
movq	%rdi, %r11
movntdqa	(%rcx,%rax), %xmm3
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
next_vect16:
subq	$0x1, %r11
movq	(%rdx,%r11,8), %rcx
pxor	%xmm3, %xmm1
pxor	%xmm2, %xmm2
pcmpgtb	%xmm1, %xmm2
pand	%xmm15, %xmm2
pxor	%xmm3, %xmm0
paddb	%xmm1, %xmm1
pxor	%xmm2, %xmm1
movntdqa	(%rcx,%rax), %xmm3
jg	next_vect16
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
pxor	%xmm3, %xmm0
pxor	%xmm3, %xmm1
movntdq	%xmm0, (%rcx,%rax)
movntdq	%xmm1, (%r11,%rax)
addq	$0x10, %rax
cmpq	%rsi, %rax
jl	loop16
return_pass:
movl	$0x0, %eax
retq
return_fail:
movl	$0x1, %eax
retq
	.section .data
	.p2align 4
poly:
	.byte 29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29

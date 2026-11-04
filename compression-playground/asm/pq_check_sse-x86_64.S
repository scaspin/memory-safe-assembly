	.text
pq_check_sse:
endbr64
subq	$0x3, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0xf, %rsi
jne	return_fail
xorl	%eax, %eax
movdqa	poly(%rip), %xmm15
cmpq	$0x30, %rsi
jl	loop16
len_aligned_32bytes:
subq	$0x30, %rsi
loop48:
movq	0x8(%rdx,%rdi,8), %rcx
movdqa	(%rcx,%rax), %xmm0
movdqa	0x10(%rcx,%rax), %xmm4
movdqa	0x20(%rcx,%rax), %xmm8
pxor	%xmm1, %xmm1
pxor	%xmm5, %xmm5
pxor	%xmm9, %xmm9
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
movdqa	(%rcx,%rax), %xmm3
movdqa	0x10(%rcx,%rax), %xmm7
movdqa	0x20(%rcx,%rax), %xmm11
next_vect:
movq	(%rdx,%r11,8), %rcx
pxor	%xmm3, %xmm0
pxor	%xmm7, %xmm4
pxor	%xmm11, %xmm8
pxor	%xmm3, %xmm1
pxor	%xmm7, %xmm5
pxor	%xmm11, %xmm9
pxor	%xmm2, %xmm2
pxor	%xmm6, %xmm6
pxor	%xmm10, %xmm10
pcmpgtb	%xmm1, %xmm2
pcmpgtb	%xmm5, %xmm6
pcmpgtb	%xmm9, %xmm10
pand	%xmm15, %xmm2
pand	%xmm15, %xmm6
pand	%xmm15, %xmm10
movdqa	(%rcx,%rax), %xmm3
movdqa	0x10(%rcx,%rax), %xmm7
movdqa	0x20(%rcx,%rax), %xmm11
paddb	%xmm1, %xmm1
paddb	%xmm5, %xmm5
paddb	%xmm9, %xmm9
pxor	%xmm2, %xmm1
pxor	%xmm6, %xmm5
pxor	%xmm10, %xmm9
subq	$0x1, %r11
jae	next_vect
pxor	%xmm3, %xmm0
pxor	%xmm3, %xmm1
pxor	%xmm7, %xmm4
pxor	%xmm7, %xmm5
pxor	%xmm11, %xmm8
pxor	%xmm11, %xmm9
movq	0x10(%rdx,%rdi,8), %r11
movdqa	(%r11,%rax), %xmm2
movdqa	0x10(%r11,%rax), %xmm6
movdqa	0x20(%r11,%rax), %xmm10
pxor	%xmm2, %xmm1
pxor	%xmm6, %xmm5
pxor	%xmm10, %xmm9
por	%xmm1, %xmm0
por	%xmm4, %xmm0
por	%xmm5, %xmm0
por	%xmm8, %xmm0
por	%xmm9, %xmm0
ptest	%xmm0, %xmm0
jne	return_fail
addq	$0x30, %rax
cmpq	%rsi, %rax
jle	loop48
addq	$0x30, %rsi
cmpq	%rsi, %rax
je	return_pass
loop16:
movq	0x8(%rdx,%rdi,8), %rcx
movq	0x10(%rdx,%rdi,8), %r11
movdqa	(%rcx,%rax), %xmm0
pxor	%xmm1, %xmm1
movq	(%rdx,%rdi,8), %rcx
leaq	-0x1(%rdi), %r11
movdqa	(%rcx,%rax), %xmm3
next_vect16:
movq	(%rdx,%r11,8), %rcx
pxor	%xmm3, %xmm1
pxor	%xmm2, %xmm2
pcmpgtb	%xmm1, %xmm2
pand	%xmm15, %xmm2
pxor	%xmm3, %xmm0
paddb	%xmm1, %xmm1
pxor	%xmm2, %xmm1
movdqa	(%rcx,%rax), %xmm3
subq	$0x1, %r11
jae	next_vect16
pxor	%xmm3, %xmm0
pxor	%xmm3, %xmm1
movq	0x10(%rdx,%rdi,8), %r11
movdqa	(%r11,%rax), %xmm2
pxor	%xmm2, %xmm1
por	%xmm1, %xmm0
ptest	%xmm0, %xmm0
jne	return_fail
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
poly:
	.byte 29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29

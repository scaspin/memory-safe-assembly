	.text
xor_gen_sse:
endbr64
subq	$0x2, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0x7f, %rsi
jne	len_not_aligned
len_aligned_128bytes:
subq	$0x80, %rsi
xorl	%r8d, %r8d
loop128:
movq	(%rdx,%rdi,8), %rax
leaq	-0x1(%rdi), %r11
movntdqa	(%rax,%r8), %xmm0
movntdqa	0x10(%rax,%r8), %xmm1
movntdqa	0x20(%rax,%r8), %xmm2
movntdqa	0x30(%rax,%r8), %xmm3
movntdqa	0x40(%rax,%r8), %xmm4
movntdqa	0x50(%rax,%r8), %xmm5
movntdqa	0x60(%rax,%r8), %xmm6
movntdqa	0x70(%rax,%r8), %xmm7
next_vect:
movq	(%rdx,%r11,8), %rcx
xorpd	(%rcx,%r8), %xmm0
xorpd	0x10(%rcx,%r8), %xmm1
xorpd	0x20(%rcx,%r8), %xmm2
xorpd	0x30(%rcx,%r8), %xmm3
xorpd	0x40(%rcx,%r8), %xmm4
xorpd	0x50(%rcx,%r8), %xmm5
xorpd	0x60(%rcx,%r8), %xmm6
xorpd	0x70(%rcx,%r8), %xmm7
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
movntdq	%xmm0, (%rcx,%r8)
movntdq	%xmm1, 0x10(%rcx,%r8)
movntdq	%xmm2, 0x20(%rcx,%r8)
movntdq	%xmm3, 0x30(%rcx,%r8)
movntdq	%xmm4, 0x40(%rcx,%r8)
movntdq	%xmm5, 0x50(%rcx,%r8)
movntdq	%xmm6, 0x60(%rcx,%r8)
movntdq	%xmm7, 0x70(%rcx,%r8)
addq	$0x80, %r8
cmpq	%rsi, %r8
jle	loop128
return_pass:
xorl	%eax, %eax
retq
xor_gen_byte:
movq	%rdi, %r11
loop_1byte:
movq	(%rdx,%r11,8), %rcx
movb	-0x1(%rcx,%rsi), %al
subq	$0x1, %r11
nextvect_1byte:
movq	(%rdx,%r11,8), %rcx
xorb	-0x1(%rcx,%rsi), %al
subq	$0x1, %r11
jge	nextvect_1byte
movq	%rdi, %r11
movq	0x8(%rdx,%r11,8), %rcx
movb	%al, -0x1(%rcx,%rsi)
subq	$0x1, %rsi
testq	$0x7, %rsi
jne	loop_1byte
cmpq	$0x0, %rsi
je	return_pass
testq	$0x7f, %rsi
je	len_aligned_128bytes
len_not_aligned:
testq	$0x7, %rsi
jne	xor_gen_byte
movq	%rsi, %r8
andq	$0x7f, %r8
movq	%rdi, %r11
loopN_bytes:
movq	(%rdx,%r11,8), %rcx
movq	-0x8(%rcx,%rsi), %rax
subq	$0x1, %r11
nextvect_Nbytes:
movq	(%rdx,%r11,8), %rcx
xorq	-0x8(%rcx,%rsi), %rax
subq	$0x1, %r11
jge	nextvect_Nbytes
movq	%rdi, %r11
movq	0x8(%rdx,%r11,8), %rcx
movq	%rax, -0x8(%rcx,%rsi)
subq	$0x8, %rsi
subq	$0x8, %r8
jg	loopN_bytes
cmpq	$0x80, %rsi
jge	len_aligned_128bytes
cmpq	$0x0, %rsi
je	return_pass
return_fail:
movl	$0x1, %eax
retq

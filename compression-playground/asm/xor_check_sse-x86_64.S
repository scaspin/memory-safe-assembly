	.text
xor_check_sse:
endbr64
subq	$0x1, %rdi
jle	return_fail
cmpq	$0x0, %rsi
je	return_pass
testq	$0x7f, %rsi
jne	len_not_aligned
len_aligned_128bytes:
subq	$0x80, %rsi
movl	$0x0, %r8d
movq	%rdi, %r11
loop128:
movq	(%rdx,%r11,8), %rax
subq	$0x1, %r11
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
subq	$0x1, %r11
xorpd	(%rcx,%r8), %xmm0
xorpd	0x10(%rcx,%r8), %xmm1
xorpd	0x20(%rcx,%r8), %xmm2
xorpd	0x30(%rcx,%r8), %xmm3
xorpd	0x40(%rcx,%r8), %xmm4
xorpd	0x50(%rcx,%r8), %xmm5
xorpd	0x60(%rcx,%r8), %xmm6
xorpd	0x70(%rcx,%r8), %xmm7
jge	next_vect
movq	%rdi, %r11
por	%xmm1, %xmm0
por	%xmm3, %xmm2
por	%xmm5, %xmm4
por	%xmm7, %xmm6
por	%xmm2, %xmm0
por	%xmm6, %xmm4
por	%xmm4, %xmm0
ptest	%xmm0, %xmm0
jne	return_fail
addq	$0x80, %r8
cmpq	%rsi, %r8
jle	loop128
return_pass:
movl	$0x0, %eax
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
cmpb	$0x0, %al
jne	return_fail
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
cmpq	$0x0, %rax
jne	return_fail
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

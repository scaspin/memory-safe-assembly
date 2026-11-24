	.text
xor_gen_avx512:
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
vmovdqu8	(%rax,%r8), %zmm0
vmovdqu8	0x40(%rax,%r8), %zmm1
next_vect:
movq	(%rdx,%r11,8), %rcx
vmovdqu8	(%rcx,%r8), %zmm4
vmovdqu8	0x40(%rcx,%r8), %zmm5
vpxorq	%zmm4, %zmm0, %zmm0
vpxorq	%zmm5, %zmm1, %zmm1
subq	$0x1, %r11
jae	next_vect
movq	0x8(%rdx,%rdi,8), %rcx
vmovdqu8	%zmm0, (%rcx,%r8)
vmovdqu8	%zmm1, 0x40(%rcx,%r8)
addq	$0x80, %r8
cmpq	%rsi, %r8
jle	loop128
return_pass:
xorl	%eax, %eax
retq
loop_1byte:
movq	%rdi, %r11
movq	(%rdx,%rdi,8), %rcx
movb	-0x1(%rcx,%rsi), %al
subq	$0x1, %r11
nextvect_1byte:
movq	(%rdx,%r11,8), %rcx
xorb	-0x1(%rcx,%rsi), %al
subq	$0x1, %r11
jge	nextvect_1byte
movq	%rdi, %r11
addq	$0x1, %r11
movq	(%rdx,%r11,8), %rcx
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
jne	loop_1byte
movq	%rsi, %r8
andq	$0x7f, %r8
loop8_bytes:
movq	%rdi, %r11
movq	(%rdx,%rdi,8), %rcx
movq	-0x8(%rcx,%rsi), %rax
subq	$0x1, %r11
nextvect_8bytes:
movq	(%rdx,%r11,8), %rcx
xorq	-0x8(%rcx,%rsi), %rax
subq	$0x1, %r11
jge	nextvect_8bytes
movq	%rdi, %r11
addq	$0x1, %r11
movq	(%rdx,%r11,8), %rcx
movq	%rax, -0x8(%rcx,%rsi)
subq	$0x8, %rsi
subq	$0x8, %r8
jg	loop8_bytes
cmpq	$0x80, %rsi
jge	len_aligned_128bytes
cmpq	$0x0, %rsi
je	return_pass
return_fail:
movl	$0x1, %eax
retq

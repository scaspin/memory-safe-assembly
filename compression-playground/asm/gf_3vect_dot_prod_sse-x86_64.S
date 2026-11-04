	.text
gf_3vect_dot_prod_sse:
endbr64
pushq	%r12
pushq	%r13
subq	$0x10, %rdi
jl	gf_3vect_dot_prod_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm11
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	(%r8), %r8
gf_3vect_dot_prod_sse.loop16:
pxor	%xmm10, %xmm10
pxor	%xmm9, %xmm9
pxor	%xmm8, %xmm8
movq	%rdx, %r11
xorq	%r10, %r10
gf_3vect_dot_prod_sse.next_vect:
movq	(%rcx,%r10), %r9
movdqu	(%r11), %xmm2
movdqu	0x10(%r11), %xmm3
movdqu	(%r11,%rsi,4), %xmm4
movdqu	0x10(%r11,%rsi,4), %xmm7
movdqu	(%r11,%rsi,8), %xmm6
movdqu	0x10(%r11,%rsi,8), %xmm5
addq	$0x20, %r11
addq	$0x8, %r10
movdqu	(%r9,%rax), %xmm0
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm11, %xmm0
pand	%xmm11, %xmm1
pshufb	%xmm0, %xmm3
pshufb	%xmm1, %xmm2
pxor	%xmm2, %xmm3
pxor	%xmm3, %xmm10
pshufb	%xmm0, %xmm7
pshufb	%xmm1, %xmm4
pxor	%xmm4, %xmm7
pxor	%xmm7, %xmm9
pshufb	%xmm0, %xmm5
pshufb	%xmm1, %xmm6
pxor	%xmm6, %xmm5
pxor	%xmm5, %xmm8
cmpq	%rsi, %r10
jl	gf_3vect_dot_prod_sse.next_vect
movdqu	%xmm10, (%r8,%rax)
movdqu	%xmm9, (%r13,%rax)
movdqu	%xmm8, (%r12,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_3vect_dot_prod_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_3vect_dot_prod_sse.return_pass
movq	%rdi, %rax
jmp	gf_3vect_dot_prod_sse.loop16
gf_3vect_dot_prod_sse.return_pass:
movl	$0x0, %eax
popq	%r13
popq	%r12
retq
gf_3vect_dot_prod_sse.return_fail:
movl	$0x1, %eax
popq	%r13
popq	%r12
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

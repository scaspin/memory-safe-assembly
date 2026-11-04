	.text
gf_6vect_dot_prod_sse:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x10, %rdi
jl	gf_6vect_dot_prod_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm15
movq	%rsi, %r14
imulq	$0x20, %r14, %r14
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	(%r8), %r13
movq	0x8(%r8), %r12
gf_6vect_dot_prod_sse.loop16:
movq	%rdx, %r11
xorq	%r10, %r10
pxor	%xmm8, %xmm8
pxor	%xmm9, %xmm9
pxor	%xmm10, %xmm10
pxor	%xmm11, %xmm11
pxor	%xmm12, %xmm12
pxor	%xmm13, %xmm13
gf_6vect_dot_prod_sse.next_vect:
movq	(%rcx,%r10), %r9
addq	$0x8, %r10
movdqu	(%r9,%rax), %xmm0
movdqu	(%r11), %xmm2
movdqu	0x10(%r11), %xmm3
movdqu	(%r11,%r14), %xmm4
movdqu	0x10(%r11,%r14), %xmm5
movdqu	(%r11,%r14,2), %xmm6
movdqu	0x10(%r11,%r14,2), %xmm7
leaq	(%r14,%r14,4), %r9
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm3
pshufb	%xmm1, %xmm2
pxor	%xmm2, %xmm3
pxor	%xmm3, %xmm8
pshufb	%xmm0, %xmm5
pshufb	%xmm1, %xmm4
pxor	%xmm4, %xmm5
pxor	%xmm5, %xmm9
pshufb	%xmm0, %xmm7
pshufb	%xmm1, %xmm6
pxor	%xmm6, %xmm7
pxor	%xmm7, %xmm10
movdqu	(%r11,%r15), %xmm2
movdqu	0x10(%r11,%r15), %xmm3
movdqu	(%r11,%r14,4), %xmm4
movdqu	0x10(%r11,%r14,4), %xmm5
movdqu	(%r11,%r9), %xmm6
movdqu	0x10(%r11,%r9), %xmm7
addq	$0x20, %r11
pshufb	%xmm0, %xmm3
pshufb	%xmm1, %xmm2
pxor	%xmm2, %xmm3
pxor	%xmm3, %xmm11
pshufb	%xmm0, %xmm5
pshufb	%xmm1, %xmm4
pxor	%xmm4, %xmm5
pxor	%xmm5, %xmm12
pshufb	%xmm0, %xmm7
pshufb	%xmm1, %xmm6
pxor	%xmm6, %xmm7
pxor	%xmm7, %xmm13
cmpq	%rsi, %r10
jl	gf_6vect_dot_prod_sse.next_vect
movq	0x10(%r8), %r11
movq	0x18(%r8), %r9
movq	0x20(%r8), %r10
movdqu	%xmm8, (%r13,%rax)
movdqu	%xmm9, (%r12,%rax)
movdqu	%xmm10, (%r11,%rax)
movq	0x28(%r8), %r11
movdqu	%xmm11, (%r9,%rax)
movdqu	%xmm12, (%r10,%rax)
movdqu	%xmm13, (%r11,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_6vect_dot_prod_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_6vect_dot_prod_sse.return_pass
movq	%rdi, %rax
jmp	gf_6vect_dot_prod_sse.loop16
gf_6vect_dot_prod_sse.return_pass:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_6vect_dot_prod_sse.return_fail:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

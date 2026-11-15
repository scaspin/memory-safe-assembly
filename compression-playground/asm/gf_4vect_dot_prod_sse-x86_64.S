	.text
gf_4vect_dot_prod_sse:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x10, %rdi
jl	gf_4vect_dot_prod_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm14
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	(%r8), %r8
gf_4vect_dot_prod_sse.loop16:
pxor	%xmm8, %xmm8
pxor	%xmm10, %xmm10
pxor	%xmm12, %xmm12
pxor	%xmm13, %xmm13
movq	%rdx, %r11
xorq	%r10, %r10
gf_4vect_dot_prod_sse.next_vect:
movq	(%rcx,%r10), %r9
movdqu	(%r11), %xmm2
movdqu	0x10(%r11), %xmm3
movdqu	(%r11,%rsi,4), %xmm11
movdqu	0x10(%r11,%rsi,4), %xmm4
movdqu	(%r11,%rsi,8), %xmm9
movdqu	0x10(%r11,%rsi,8), %xmm5
movdqu	(%r11,%r15), %xmm7
movdqu	0x10(%r11,%r15), %xmm6
movdqu	(%r9,%rax), %xmm0
addq	$0x20, %r11
addq	$0x8, %r10
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm14, %xmm0
pand	%xmm14, %xmm1
pshufb	%xmm0, %xmm3
pshufb	%xmm1, %xmm2
pxor	%xmm2, %xmm3
pxor	%xmm3, %xmm8
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm11
pxor	%xmm11, %xmm4
pxor	%xmm4, %xmm10
pshufb	%xmm0, %xmm5
pshufb	%xmm1, %xmm9
pxor	%xmm9, %xmm5
pxor	%xmm5, %xmm12
pshufb	%xmm0, %xmm6
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm6
pxor	%xmm6, %xmm13
cmpq	%rsi, %r10
jl	gf_4vect_dot_prod_sse.next_vect
movdqu	%xmm8, (%r8,%rax)
movdqu	%xmm10, (%r13,%rax)
movdqu	%xmm12, (%r12,%rax)
movdqu	%xmm13, (%r14,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_4vect_dot_prod_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_dot_prod_sse.return_pass
movq	%rdi, %rax
jmp	gf_4vect_dot_prod_sse.loop16
gf_4vect_dot_prod_sse.return_pass:
movl	$0x0, %eax
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq
gf_4vect_dot_prod_sse.return_fail:
movl	$0x1, %eax
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq
	.section .data
	.p2align 4
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

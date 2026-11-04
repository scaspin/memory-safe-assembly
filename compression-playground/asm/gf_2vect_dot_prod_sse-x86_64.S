	.text
gf_2vect_dot_prod_sse:
endbr64
pushq	%r12
subq	$0x10, %rdi
jl	gf_2vect_dot_prod_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm8
shlq	$0x3, %rsi
movq	0x8(%r8), %r12
movq	(%r8), %r8
gf_2vect_dot_prod_sse.loop16:
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
movq	%rdx, %r11
xorq	%r10, %r10
gf_2vect_dot_prod_sse.next_vect:
movq	(%rcx,%r10), %r9
movdqu	(%r11), %xmm7
movdqu	0x10(%r11), %xmm6
movdqu	(%r11,%rsi,4), %xmm5
movdqu	0x10(%r11,%rsi,4), %xmm4
addq	$0x20, %r11
addq	$0x8, %r10
movdqu	(%r9,%rax), %xmm0
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm8, %xmm0
pand	%xmm8, %xmm1
pshufb	%xmm0, %xmm6
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm6
pxor	%xmm6, %xmm2
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pxor	%xmm4, %xmm3
cmpq	%rsi, %r10
jl	gf_2vect_dot_prod_sse.next_vect
movdqu	%xmm2, (%r8,%rax)
movdqu	%xmm3, (%r12,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_2vect_dot_prod_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_dot_prod_sse.return_pass
movq	%rdi, %rax
jmp	gf_2vect_dot_prod_sse.loop16
gf_2vect_dot_prod_sse.return_pass:
movl	$0x0, %eax
popq	%r12
retq
gf_2vect_dot_prod_sse.return_fail:
movl	$0x1, %eax
popq	%r12
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

	.text
gf_vect_dot_prod_sse:
endbr64
subq	$0x10, %rdi
jl	gf_vect_dot_prod_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm5
gf_vect_dot_prod_sse.loop16:
pxor	%xmm2, %xmm2
movq	%rdx, %r11
xorq	%r10, %r10
gf_vect_dot_prod_sse.next_vect:
movq	(%rcx,%r10,8), %r9
movdqu	(%r11), %xmm4
movdqu	0x10(%r11), %xmm3
movdqu	(%r9,%rax), %xmm0
addq	$0x20, %r11
addq	$0x1, %r10
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm5, %xmm0
pand	%xmm5, %xmm1
pshufb	%xmm0, %xmm3
pshufb	%xmm1, %xmm4
pxor	%xmm4, %xmm3
pxor	%xmm3, %xmm2
cmpq	%rsi, %r10
jl	gf_vect_dot_prod_sse.next_vect
movdqu	%xmm2, (%r8,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_vect_dot_prod_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_dot_prod_sse.return_pass
movq	%rdi, %rax
jmp	gf_vect_dot_prod_sse.loop16
gf_vect_dot_prod_sse.return_pass:
movl	$0x0, %eax
retq
gf_vect_dot_prod_sse.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

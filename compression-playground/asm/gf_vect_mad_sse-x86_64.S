	.text
gf_vect_mad_sse:
endbr64
subq	$0x10, %rdi
jl	gf_vect_mad_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm8
shlq	$0x5, %rdx
movdqu	(%rdx,%rcx), %xmm7
movdqu	0x10(%rdx,%rcx), %xmm6
movdqu	(%r9,%rdi), %xmm5
gf_vect_mad_sse.loop16:
movdqu	(%r9,%rax), %xmm4
gf_vect_mad_sse.loop16_overlap:
movdqu	(%r8,%rax), %xmm0
movdqa	%xmm6, %xmm2
movdqa	%xmm7, %xmm3
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm8, %xmm0
pand	%xmm8, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm4
movdqu	%xmm4, (%r9,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_vect_mad_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_mad_sse.return_pass
movq	%rdi, %rax
movdqa	%xmm5, %xmm4
jmp	gf_vect_mad_sse.loop16_overlap
gf_vect_mad_sse.return_pass:
movl	$0x0, %eax
retq
gf_vect_mad_sse.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

	.text
gf_2vect_mad_sse:
endbr64
subq	$0x10, %rdi
jl	gf_2vect_mad_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm14
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
movdqu	(%r11), %xmm13
movdqu	0x10(%r11), %xmm12
movdqu	(%r11,%rsi), %xmm11
movdqu	0x10(%r11,%rsi), %xmm10
movq	0x8(%r9), %r10
movq	(%r9), %r9
movdqu	(%r9,%rdi), %xmm8
movdqu	(%r10,%rdi), %xmm9
gf_2vect_mad_sse.loop16:
movdqu	(%r9,%rax), %xmm6
movdqu	(%r10,%rax), %xmm7
gf_2vect_mad_sse.loop16_overlap:
movdqu	(%r8,%rax), %xmm0
movdqa	%xmm12, %xmm2
movdqa	%xmm13, %xmm3
movdqa	%xmm10, %xmm4
movdqa	%xmm11, %xmm5
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm14, %xmm0
pand	%xmm14, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm6
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pxor	%xmm4, %xmm7
movdqu	%xmm6, (%r9,%rax)
movdqu	%xmm7, (%r10,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_2vect_mad_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_mad_sse.return_pass
movq	%rdi, %rax
movdqa	%xmm8, %xmm6
movdqa	%xmm9, %xmm7
jmp	gf_2vect_mad_sse.loop16_overlap
gf_2vect_mad_sse.return_pass:
movl	$0x0, %eax
retq
gf_2vect_mad_sse.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

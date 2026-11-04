	.text
gf_4vect_mad_sse:
endbr64
pushq	%r12
subq	$0x10, %rdi
jl	gf_4vect_mad_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm15
movq	%rsi, %r11
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r12
shlq	$0x6, %r11
movdqu	0x10(%r12,%r11), %xmm14
shlq	$0x5, %rsi
addq	%rsi, %r11
movdqu	(%r12,%r11), %xmm12
movdqu	0x10(%r12,%r11), %xmm13
movq	0x8(%r9), %rcx
movq	0x10(%r9), %r10
movq	0x18(%r9), %rdx
movq	(%r9), %r9
gf_4vect_mad_sse.loop16:
movdqu	(%r8,%rax), %xmm0
movdqu	0x10(%r12), %xmm2
movdqu	(%r12), %xmm3
movdqu	0x10(%r12,%rsi), %xmm4
movdqu	(%r12,%rsi), %xmm5
movdqu	(%r12,%rsi,2), %xmm7
movdqa	%xmm14, %xmm6
movdqa	%xmm12, %xmm9
movdqa	%xmm13, %xmm8
movdqu	(%r9,%rax), %xmm10
movdqu	(%rcx,%rax), %xmm11
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm10
movdqu	(%r10,%rax), %xmm2
movdqu	(%rdx,%rax), %xmm3
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pxor	%xmm4, %xmm11
pshufb	%xmm0, %xmm6
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm6
pxor	%xmm6, %xmm2
pshufb	%xmm0, %xmm8
pshufb	%xmm1, %xmm9
pxor	%xmm9, %xmm8
pxor	%xmm8, %xmm3
movdqu	%xmm10, (%r9,%rax)
movdqu	%xmm11, (%rcx,%rax)
movdqu	%xmm2, (%r10,%rax)
movdqu	%xmm3, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_4vect_mad_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_mad_sse.return_pass
gf_4vect_mad_sse.lessthan16:
movq	%rdi, %r11
movdqu	(%r8,%r11), %xmm0
movdqu	0x10(%r12), %xmm2
movdqu	(%r12), %xmm3
movdqu	0x10(%r12,%rsi), %xmm4
movdqu	(%r12,%rsi), %xmm5
movdqu	(%r12,%rsi,2), %xmm7
movdqu	(%r9,%r11), %xmm10
movdqu	(%rcx,%r11), %xmm11
movdqu	(%r10,%r11), %xmm8
subq	%rax, %rdi
movdqa	constip16(%rip), %xmm9
pinsrb	$0xf, %edi, %xmm6
pshufb	%xmm15, %xmm6
pcmpgtb	%xmm9, %xmm6
movdqu	(%rdx,%r11), %xmm9
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pand	%xmm6, %xmm2
pxor	%xmm2, %xmm10
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pand	%xmm6, %xmm4
pxor	%xmm4, %xmm11
pshufb	%xmm0, %xmm14
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm14
pand	%xmm6, %xmm14
pxor	%xmm14, %xmm8
pshufb	%xmm0, %xmm13
pshufb	%xmm1, %xmm12
pxor	%xmm12, %xmm13
pand	%xmm6, %xmm13
pxor	%xmm13, %xmm9
movdqu	%xmm10, (%r9,%r11)
movdqu	%xmm11, (%rcx,%r11)
movdqu	%xmm8, (%r10,%r11)
movdqu	%xmm9, (%rdx,%r11)
gf_4vect_mad_sse.return_pass:
popq	%r12
movl	$0x0, %eax
retq
gf_4vect_mad_sse.return_fail:
popq	%r12
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

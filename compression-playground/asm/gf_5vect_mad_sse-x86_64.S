	.text
gf_5vect_mad_sse:
endbr64
pushq	%r12
pushq	%r13
subq	$0x10, %rdi
jl	gf_5vect_mad_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm15
movq	%rsi, %r11
shlq	$0x5, %rdx
leaq	(%rcx,%rdx), %r12
shlq	$0x6, %r11
movdqu	0x10(%r12,%r11,2), %xmm14
shlq	$0x5, %rsi
addq	%rsi, %r11
movdqu	0x10(%r12,%r11), %xmm12
movdqu	(%r12,%r11), %xmm13
movq	0x10(%r9), %rcx
movq	0x18(%r9), %r10
movq	0x20(%r9), %rdx
movq	0x8(%r9), %r13
movq	(%r9), %r9
gf_5vect_mad_sse.loop16:
movdqu	(%r8,%rax), %xmm0
movdqu	0x10(%r12), %xmm2
movdqu	(%r12), %xmm3
movdqu	0x10(%r12,%rsi), %xmm4
movdqu	(%r12,%rsi), %xmm5
movdqu	0x10(%r12,%rsi,2), %xmm6
movdqu	(%r12,%rsi,2), %xmm7
movdqu	(%r12,%rsi,4), %xmm9
movdqa	%xmm14, %xmm8
movdqu	(%r9,%rax), %xmm10
movdqu	(%r13,%rax), %xmm11
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm10
movdqu	(%rcx,%rax), %xmm3
movdqu	(%r10,%rax), %xmm2
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pxor	%xmm4, %xmm11
movdqu	(%rdx,%rax), %xmm5
pshufb	%xmm0, %xmm6
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm6
pxor	%xmm6, %xmm3
movdqa	%xmm12, %xmm4
movdqa	%xmm13, %xmm7
pshufb	%xmm0, %xmm8
pshufb	%xmm1, %xmm9
pxor	%xmm9, %xmm8
pxor	%xmm8, %xmm5
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm4
pxor	%xmm4, %xmm2
movdqu	%xmm10, (%r9,%rax)
movdqu	%xmm11, (%r13,%rax)
movdqu	%xmm3, (%rcx,%rax)
movdqu	%xmm2, (%r10,%rax)
movdqu	%xmm5, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_5vect_mad_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_5vect_mad_sse.return_pass
gf_5vect_mad_sse.lessthan16:
movq	%rdi, %r11
movdqu	(%r8,%r11), %xmm0
subq	%rax, %rdi
movdqa	constip16(%rip), %xmm3
pinsrb	$0xf, %edi, %xmm8
pshufb	%xmm15, %xmm8
pcmpgtb	%xmm3, %xmm8
movdqu	0x10(%r12), %xmm2
movdqu	(%r12), %xmm3
movdqu	0x10(%r12,%rsi), %xmm4
movdqu	(%r12,%rsi), %xmm5
movdqu	0x10(%r12,%rsi,2), %xmm6
movdqu	(%r12,%rsi,2), %xmm7
movdqu	(%r12,%rsi,4), %xmm9
movdqu	(%r9,%r11), %xmm10
movdqu	(%r13,%r11), %xmm11
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pand	%xmm8, %xmm2
pxor	%xmm2, %xmm10
movdqu	(%rcx,%r11), %xmm3
movdqu	(%r10,%r11), %xmm2
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pand	%xmm8, %xmm4
pxor	%xmm4, %xmm11
movdqu	(%rdx,%r11), %xmm5
pshufb	%xmm0, %xmm6
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm6
pand	%xmm8, %xmm6
pxor	%xmm6, %xmm3
pshufb	%xmm0, %xmm12
pshufb	%xmm1, %xmm13
pxor	%xmm13, %xmm12
pand	%xmm8, %xmm12
pxor	%xmm12, %xmm2
pshufb	%xmm0, %xmm14
pshufb	%xmm1, %xmm9
pxor	%xmm9, %xmm14
pand	%xmm8, %xmm14
pxor	%xmm14, %xmm5
movdqu	%xmm10, (%r9,%r11)
movdqu	%xmm11, (%r13,%r11)
movdqu	%xmm3, (%rcx,%r11)
movdqu	%xmm2, (%r10,%r11)
movdqu	%xmm5, (%rdx,%r11)
gf_5vect_mad_sse.return_pass:
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_5vect_mad_sse.return_fail:
popq	%r13
popq	%r12
movl	$0x1, %eax
retq
	.section .data
	.p2align 4
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

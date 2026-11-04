	.text
gf_3vect_mad_sse:
endbr64
subq	$0x10, %rdi
jl	gf_3vect_mad_sse.return_fail
xorq	%rax, %rax
movdqa	mask0f(%rip), %xmm15
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
movdqu	(%r11), %xmm14
movdqu	0x10(%r11), %xmm13
movdqu	(%r11,%rsi), %xmm12
movdqu	0x10(%r11,%rsi), %xmm11
movdqu	(%r11,%rsi,2), %xmm10
movdqu	0x10(%r11,%rsi,2), %xmm9
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	(%r9), %r9
gf_3vect_mad_sse.loop16:
movdqu	(%r8,%rax), %xmm0
movdqa	%xmm13, %xmm2
movdqa	%xmm14, %xmm3
movdqa	%xmm11, %xmm4
movdqa	%xmm12, %xmm5
movdqa	%xmm9, %xmm6
movdqa	%xmm10, %xmm7
movdqu	(%r9,%rax), %xmm8
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm8
movdqu	(%rcx,%rax), %xmm3
movdqu	(%rdx,%rax), %xmm2
pshufb	%xmm0, %xmm4
pshufb	%xmm1, %xmm5
pxor	%xmm5, %xmm4
pxor	%xmm4, %xmm3
pshufb	%xmm0, %xmm6
pshufb	%xmm1, %xmm7
pxor	%xmm7, %xmm6
pxor	%xmm6, %xmm2
movdqu	%xmm8, (%r9,%rax)
movdqu	%xmm3, (%rcx,%rax)
movdqu	%xmm2, (%rdx,%rax)
addq	$0x10, %rax
cmpq	%rdi, %rax
jle	gf_3vect_mad_sse.loop16
leaq	0x10(%rdi), %r11
cmpq	%r11, %rax
je	gf_3vect_mad_sse.return_pass
gf_3vect_mad_sse.lessthan16:
movq	%rdi, %r11
movdqu	(%r8,%r11), %xmm0
movdqu	(%r9,%r11), %xmm8
movdqu	(%rcx,%r11), %xmm3
movdqu	(%rdx,%r11), %xmm2
subq	%rax, %rdi
movdqa	constip16(%rip), %xmm6
pinsrb	$0xf, %edi, %xmm7
pshufb	%xmm15, %xmm7
pcmpgtb	%xmm6, %xmm7
movdqa	%xmm0, %xmm1
psraw	$0x4, %xmm0
pand	%xmm15, %xmm0
pand	%xmm15, %xmm1
pshufb	%xmm0, %xmm13
pshufb	%xmm1, %xmm14
pxor	%xmm14, %xmm13
pand	%xmm7, %xmm13
pxor	%xmm13, %xmm8
pshufb	%xmm0, %xmm11
pshufb	%xmm1, %xmm12
pxor	%xmm12, %xmm11
pand	%xmm7, %xmm11
pxor	%xmm11, %xmm3
pshufb	%xmm0, %xmm9
pshufb	%xmm1, %xmm10
pxor	%xmm10, %xmm9
pand	%xmm7, %xmm9
pxor	%xmm9, %xmm2
movdqu	%xmm8, (%r9,%r11)
movdqu	%xmm3, (%rcx,%r11)
movdqu	%xmm2, (%rdx,%r11)
gf_3vect_mad_sse.return_pass:
movl	$0x0, %eax
retq
gf_3vect_mad_sse.return_fail:
movl	$0x1, %eax
retq
	.section .data
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
constip16:
	.byte 255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240

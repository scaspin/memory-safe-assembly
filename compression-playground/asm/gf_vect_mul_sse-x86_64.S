	.text
gf_vect_mul_sse:
endbr64
movq	%rdi, %r11
andq	$0x1f, %r11
jne	return_fail
movl	$0x0, %eax
movdqa	mask0f(%rip), %xmm15
movdqu	(%rsi), %xmm14
movdqu	0x10(%rsi), %xmm13
loop32:
movntdqa	(%rdx,%rax), %xmm0
movntdqa	0x10(%rdx,%rax), %xmm4
movdqa	%xmm13, %xmm2
movdqa	%xmm14, %xmm3
movdqa	%xmm13, %xmm6
movdqa	%xmm14, %xmm7
movdqa	%xmm0, %xmm1
movdqa	%xmm4, %xmm5
psraw	$0x4, %xmm0
psraw	$0x4, %xmm4
pand	%xmm15, %xmm1
pand	%xmm15, %xmm5
pand	%xmm15, %xmm0
pand	%xmm15, %xmm4
pshufb	%xmm0, %xmm2
pshufb	%xmm1, %xmm3
pshufb	%xmm4, %xmm6
pshufb	%xmm5, %xmm7
pxor	%xmm3, %xmm2
pxor	%xmm7, %xmm6
movntdq	%xmm2, (%rcx,%rax)
movntdq	%xmm6, 0x10(%rcx,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jl	loop32
return_pass:
xorq	%rax, %rax
retq
return_fail:
movl	$0x1, %eax
retq
	.section .data
	.p2align 4
mask0f:
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15

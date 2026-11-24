	.text
gf_vect_mul_avx:
endbr64
movq	%rdi, %r11
andq	$0x1f, %r11
jne	return_fail
movl	$0x0, %eax
vmovdqa	mask0f(%rip), %xmm15
vmovdqu	(%rsi), %xmm14
vmovdqu	0x10(%rsi), %xmm13
loop32:
vmovntdqa	(%rdx,%rax), %xmm0
vmovntdqa	0x10(%rdx,%rax), %xmm4
addq	$0x20, %rax
cmpq	%rdi, %rax
vpand	%xmm15, %xmm0, %xmm1
vpand	%xmm15, %xmm4, %xmm5
vpsraw	$0x4, %xmm0, %xmm0
vpsraw	$0x4, %xmm4, %xmm4
vpand	%xmm15, %xmm0, %xmm0
vpand	%xmm15, %xmm4, %xmm4
vpshufb	%xmm0, %xmm13, %xmm2
vpshufb	%xmm1, %xmm14, %xmm3
vpshufb	%xmm4, %xmm13, %xmm6
vpshufb	%xmm5, %xmm14, %xmm7
vpxor	%xmm3, %xmm2, %xmm2
vpxor	%xmm7, %xmm6, %xmm6
vmovntdq	%xmm2, -0x20(%rcx,%rax)
vmovntdq	%xmm6, -0x10(%rcx,%rax)
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

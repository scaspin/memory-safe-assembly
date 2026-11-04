	.text
gf_vect_mul_avx2_gfni:
endbr64
testq	$0x1f, %rdi
jne	return_fail
movl	$0x0, %eax
vmovdqu	(%rsi), %ymm8
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
loop32:
vmovntdqa	(%rdx,%rax), %ymm6
vgf2p8affineqb	$0x0, %ymm8, %ymm6, %ymm7
vmovntdq	%ymm7, (%rcx,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jb	loop32
return_pass:
xorq	%rax, %rax
retq
return_fail:
movl	$0x1, %eax
retq

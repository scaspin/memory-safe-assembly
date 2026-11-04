	.text
gf_vect_mad_avx2:
endbr64
subq	$0x20, %rdi
jl	gf_vect_mad_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm8, %xmm8
vpbroadcastb	%xmm8, %ymm8
shlq	$0x5, %rdx
vbroadcasti128	(%rdx,%rcx), %ymm7
vbroadcasti128	0x10(%rdx,%rcx), %ymm6
vmovdqu	(%r9,%rdi), %ymm5
gf_vect_mad_avx2.loop32:
vmovdqu	(%r9,%rax), %ymm4
gf_vect_mad_avx2.loop32_overlap:
vmovdqu	(%r8,%rax), %ymm0
vpand	%ymm8, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm8, %ymm0, %ymm0
vpshufb	%ymm0, %ymm6, %ymm2
vpshufb	%ymm1, %ymm7, %ymm3
vpxor	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm4, %ymm4
vmovdqu	%ymm4, (%r9,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_vect_mad_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_mad_avx2.return_pass
movq	%rdi, %rax
vmovdqa	%ymm5, %ymm4
jmp	gf_vect_mad_avx2.loop32_overlap
gf_vect_mad_avx2.return_pass:
movl	$0x0, %eax
retq
gf_vect_mad_avx2.return_fail:
movl	$0x1, %eax
retq

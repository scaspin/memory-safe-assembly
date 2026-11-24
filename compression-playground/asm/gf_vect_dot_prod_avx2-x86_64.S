	.text
gf_vect_dot_prod_avx2:
endbr64
subq	$0x20, %rdi
jl	gf_vect_dot_prod_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm3, %xmm3
vpbroadcastb	%xmm3, %ymm3
gf_vect_dot_prod_avx2.loop32:
vpxor	%ymm2, %ymm2, %ymm2
movq	%rdx, %r11
xorq	%r10, %r10
gf_vect_dot_prod_avx2.next_vect:
movq	(%rcx,%r10,8), %r9
vbroadcasti128	(%r11), %ymm4
vbroadcasti128	0x10(%r11), %ymm5
vmovdqu	(%r9,%rax), %ymm0
addq	$0x20, %r11
addq	$0x1, %r10
vpand	%ymm3, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm3, %ymm0, %ymm0
vpshufb	%ymm0, %ymm5, %ymm5
vpshufb	%ymm1, %ymm4, %ymm4
vpxor	%ymm4, %ymm5, %ymm5
vpxor	%ymm5, %ymm2, %ymm2
cmpq	%rsi, %r10
jl	gf_vect_dot_prod_avx2.next_vect
vmovdqu	%ymm2, (%r8,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_vect_dot_prod_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_vect_dot_prod_avx2.return_pass
movq	%rdi, %rax
jmp	gf_vect_dot_prod_avx2.loop32
gf_vect_dot_prod_avx2.return_pass:
movl	$0x0, %eax
retq
gf_vect_dot_prod_avx2.return_fail:
movl	$0x1, %eax
retq

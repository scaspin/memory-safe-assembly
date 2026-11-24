	.text
gf_2vect_dot_prod_avx2:
endbr64
pushq	%r12
subq	$0x20, %rdi
jl	gf_2vect_dot_prod_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm8, %xmm8
vpbroadcastb	%xmm8, %ymm8
shlq	$0x3, %rsi
movq	0x8(%r8), %r12
movq	(%r8), %r8
gf_2vect_dot_prod_avx2.loop32:
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
movq	%rdx, %r11
xorq	%r10, %r10
gf_2vect_dot_prod_avx2.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
vpand	%ymm8, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm8, %ymm0, %ymm0
vbroadcasti128	(%r11), %ymm7
vbroadcasti128	0x10(%r11), %ymm6
addq	$0x8, %r10
vbroadcasti128	(%r11,%rsi,4), %ymm5
vbroadcasti128	0x10(%r11,%rsi,4), %ymm4
addq	$0x20, %r11
vpshufb	%ymm0, %ymm6, %ymm6
vpshufb	%ymm1, %ymm7, %ymm7
vpxor	%ymm7, %ymm6, %ymm6
vpxor	%ymm6, %ymm2, %ymm2
vpshufb	%ymm0, %ymm4, %ymm4
vpshufb	%ymm1, %ymm5, %ymm5
vpxor	%ymm5, %ymm4, %ymm4
vpxor	%ymm4, %ymm3, %ymm3
cmpq	%rsi, %r10
jl	gf_2vect_dot_prod_avx2.next_vect
vmovdqu	%ymm2, (%r8,%rax)
vmovdqu	%ymm3, (%r12,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_2vect_dot_prod_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_2vect_dot_prod_avx2.return_pass
movq	%rdi, %rax
jmp	gf_2vect_dot_prod_avx2.loop32
gf_2vect_dot_prod_avx2.return_pass:
movl	$0x0, %eax
popq	%r12
retq
gf_2vect_dot_prod_avx2.return_fail:
movl	$0x1, %eax
popq	%r12
retq

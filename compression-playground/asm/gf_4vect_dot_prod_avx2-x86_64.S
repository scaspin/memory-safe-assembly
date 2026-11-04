	.text
gf_4vect_dot_prod_avx2:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x20, %rdi
jl	gf_4vect_dot_prod_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm14, %xmm14
vpbroadcastb	%xmm14, %ymm14
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	(%r8), %r8
gf_4vect_dot_prod_avx2.loop32:
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm5, %ymm5, %ymm5
movq	%rdx, %r11
xorq	%r10, %r10
gf_4vect_dot_prod_avx2.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
vpand	%ymm14, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm14, %ymm0, %ymm0
vbroadcasti128	(%r11), %ymm13
vbroadcasti128	0x10(%r11), %ymm12
vbroadcasti128	(%r11,%rsi,4), %ymm11
vbroadcasti128	0x10(%r11,%rsi,4), %ymm10
addq	$0x8, %r10
vbroadcasti128	(%r11,%rsi,8), %ymm9
vbroadcasti128	0x10(%r11,%rsi,8), %ymm8
vbroadcasti128	(%r11,%r15), %ymm7
vbroadcasti128	0x10(%r11,%r15), %ymm6
addq	$0x20, %r11
vpshufb	%ymm0, %ymm12, %ymm12
vpshufb	%ymm1, %ymm13, %ymm13
vpxor	%ymm13, %ymm12, %ymm12
vpxor	%ymm12, %ymm2, %ymm2
vpshufb	%ymm0, %ymm10, %ymm10
vpshufb	%ymm1, %ymm11, %ymm11
vpxor	%ymm11, %ymm10, %ymm10
vpxor	%ymm10, %ymm3, %ymm3
vpshufb	%ymm0, %ymm8, %ymm8
vpshufb	%ymm1, %ymm9, %ymm9
vpxor	%ymm9, %ymm8, %ymm8
vpxor	%ymm8, %ymm4, %ymm4
vpshufb	%ymm0, %ymm6, %ymm6
vpshufb	%ymm1, %ymm7, %ymm7
vpxor	%ymm7, %ymm6, %ymm6
vpxor	%ymm6, %ymm5, %ymm5
cmpq	%rsi, %r10
jl	gf_4vect_dot_prod_avx2.next_vect
vmovdqu	%ymm2, (%r8,%rax)
vmovdqu	%ymm3, (%r13,%rax)
vmovdqu	%ymm4, (%r12,%rax)
vmovdqu	%ymm5, (%r14,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_4vect_dot_prod_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_4vect_dot_prod_avx2.return_pass
movq	%rdi, %rax
jmp	gf_4vect_dot_prod_avx2.loop32
gf_4vect_dot_prod_avx2.return_pass:
movl	$0x0, %eax
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq
gf_4vect_dot_prod_avx2.return_fail:
movl	$0x1, %eax
popq	%r15
popq	%r14
popq	%r13
popq	%r12
retq

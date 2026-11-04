	.text
gf_5vect_dot_prod_avx2:
endbr64
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x20, %rdi
jl	gf_5vect_dot_prod_avx2.return_fail
xorq	%rax, %rax
movb	$0xf, %r11b
vpinsrb	$0x0, %r11d, %xmm15, %xmm15
vpbroadcastb	%xmm15, %ymm15
movq	%rsi, %r14
imulq	$0x20, %r14, %r14
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
shlq	$0x3, %rsi
movq	(%r8), %r13
movq	0x8(%r8), %r12
gf_5vect_dot_prod_avx2.loop32:
movq	%rdx, %r11
xorq	%r10, %r10
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm5, %ymm5, %ymm5
vpxor	%ymm6, %ymm6, %ymm6
gf_5vect_dot_prod_avx2.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
vpand	%ymm15, %ymm0, %ymm1
vpsraw	$0x4, %ymm0, %ymm0
vpand	%ymm15, %ymm0, %ymm0
vbroadcasti128	(%r11), %ymm14
vbroadcasti128	0x10(%r11), %ymm13
vbroadcasti128	(%r11,%r14), %ymm12
vbroadcasti128	0x10(%r11,%r14), %ymm11
addq	$0x8, %r10
vbroadcasti128	(%r11,%r14,2), %ymm10
vbroadcasti128	0x10(%r11,%r14,2), %ymm9
vbroadcasti128	(%r11,%r15), %ymm8
vbroadcasti128	0x10(%r11,%r15), %ymm7
vpshufb	%ymm0, %ymm13, %ymm13
vpshufb	%ymm1, %ymm14, %ymm14
vpxor	%ymm14, %ymm13, %ymm13
vpxor	%ymm13, %ymm2, %ymm2
vbroadcasti128	(%r11,%r14,4), %ymm14
vbroadcasti128	0x10(%r11,%r14,4), %ymm13
addq	$0x20, %r11
vpshufb	%ymm0, %ymm11, %ymm11
vpshufb	%ymm1, %ymm12, %ymm12
vpxor	%ymm12, %ymm11, %ymm11
vpxor	%ymm11, %ymm3, %ymm3
vpshufb	%ymm0, %ymm9, %ymm9
vpshufb	%ymm1, %ymm10, %ymm10
vpxor	%ymm10, %ymm9, %ymm9
vpxor	%ymm9, %ymm4, %ymm4
vpshufb	%ymm0, %ymm7, %ymm7
vpshufb	%ymm1, %ymm8, %ymm8
vpxor	%ymm8, %ymm7, %ymm7
vpxor	%ymm7, %ymm5, %ymm5
vpshufb	%ymm0, %ymm13, %ymm13
vpshufb	%ymm1, %ymm14, %ymm14
vpxor	%ymm14, %ymm13, %ymm13
vpxor	%ymm13, %ymm6, %ymm6
cmpq	%rsi, %r10
jl	gf_5vect_dot_prod_avx2.next_vect
movq	0x10(%r8), %r11
movq	0x18(%r8), %r9
movq	0x20(%r8), %r10
vmovdqu	%ymm2, (%r13,%rax)
vmovdqu	%ymm3, (%r12,%rax)
vmovdqu	%ymm4, (%r11,%rax)
vmovdqu	%ymm5, (%r9,%rax)
vmovdqu	%ymm6, (%r10,%rax)
addq	$0x20, %rax
cmpq	%rdi, %rax
jle	gf_5vect_dot_prod_avx2.loop32
leaq	0x20(%rdi), %r11
cmpq	%r11, %rax
je	gf_5vect_dot_prod_avx2.return_pass
movq	%rdi, %rax
jmp	gf_5vect_dot_prod_avx2.loop32
gf_5vect_dot_prod_avx2.return_pass:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x0, %eax
retq
gf_5vect_dot_prod_avx2.return_fail:
popq	%r15
popq	%r14
popq	%r13
popq	%r12
movl	$0x1, %eax
retq

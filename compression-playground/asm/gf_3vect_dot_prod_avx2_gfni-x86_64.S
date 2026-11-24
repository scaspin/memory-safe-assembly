	.text
gf_3vect_dot_prod_avx2_gfni:
endbr64
subq	$0x20, %rsp
movq	%r12, (%rsp)
movq	%r13, 0x8(%rsp)
movq	%r14, 0x10(%rsp)
movq	%r15, 0x18(%rsp)
xorq	%rax, %rax
shlq	$0x3, %rsi
movq	(%r8), %r14
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
cmpq	$0x40, %rdi
jl	gf_3vect_dot_prod_avx2_gfni.len_lt_64
gf_3vect_dot_prod_avx2_gfni.loop64:
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm5, %ymm5, %ymm5
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm6, %ymm6, %ymm6
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm7, %ymm7, %ymm7
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
vmovdqu	0x20(%r9,%rax), %ymm1
addq	$0x8, %r10
vmovdqu	(%r11), %ymm8
vmovdqu	(%r11,%rsi,4), %ymm9
vmovdqu	(%r11,%rsi,8), %ymm10
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm11
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm12
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm13
vpxor	%ymm11, %ymm2, %ymm2
vpxor	%ymm12, %ymm3, %ymm3
vpxor	%ymm13, %ymm4, %ymm4
vgf2p8affineqb	$0x0, %ymm8, %ymm1, %ymm8
vgf2p8affineqb	$0x0, %ymm9, %ymm1, %ymm9
vgf2p8affineqb	$0x0, %ymm10, %ymm1, %ymm10
vpxor	%ymm8, %ymm5, %ymm5
vpxor	%ymm9, %ymm6, %ymm6
vpxor	%ymm10, %ymm7, %ymm7
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu	%ymm2, (%r14,%rax)
vmovdqu	%ymm5, 0x20(%r14,%rax)
vmovdqu	%ymm3, (%r13,%rax)
vmovdqu	%ymm6, 0x20(%r13,%rax)
vmovdqu	%ymm4, (%r12,%rax)
vmovdqu	%ymm7, 0x20(%r12,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_3vect_dot_prod_avx2_gfni.loop64
gf_3vect_dot_prod_avx2_gfni.len_lt_64:
cmpq	$0x20, %rdi
jl	gf_3vect_dot_prod_avx2_gfni.len_lt_32
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
movq	%rdx, %r11
xorq	%r10, %r10
..@12.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
addq	$0x8, %r10
vmovdqu	(%r11), %ymm8
vmovdqu	(%r11,%rsi,4), %ymm9
vmovdqu	(%r11,%rsi,8), %ymm10
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm8
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm9
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm10
vpxor	%ymm8, %ymm2, %ymm2
vpxor	%ymm9, %ymm3, %ymm3
vpxor	%ymm10, %ymm4, %ymm4
cmpq	%rsi, %r10
jl	..@12.next_vect
vmovdqu	%ymm2, (%r14,%rax)
vmovdqu	%ymm3, (%r13,%rax)
vmovdqu	%ymm4, (%r12,%rax)
addq	$0x20, %rax
subq	$0x20, %rdi
gf_3vect_dot_prod_avx2_gfni.len_lt_32:
orq	%rdi, %rdi
je	..@19.end
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
xorq	%r10, %r10
..@14.next_vect:
movq	(%rcx,%r10), %r9
testq	$0x20, %rdi
je	..@15._skip_32
vmovdqu	(%r9,%rax), %ymm0
jmp	..@15.end_load
..@15._skip_32:
vpxor	%ymm0, %ymm0, %ymm0
orq	%rdi, %rdi
je	..@15.end_load
leaq	(%r9,%rax), %r11
movq	%rdi, %r15
cmpq	$0x10, %rdi
jle	..@15._check_size
addq	$0x10, %r11
subq	$0x10, %r15
..@15._check_size:
cmpq	$0x2, %r15
jb	..@15._size_1
je	..@15._size_2
cmpq	$0x4, %r15
jb	..@15._size_3
je	..@15._size_4
cmpq	$0x6, %r15
jb	..@15._size_5
je	..@15._size_6
cmpq	$0x8, %r15
jb	..@15._size_7
je	..@15._size_8
cmpq	$0xa, %r15
jb	..@15._size_9
je	..@15._size_10
cmpq	$0xc, %r15
jb	..@15._size_11
je	..@15._size_12
cmpq	$0xe, %r15
jb	..@15._size_13
je	..@15._size_14
cmpq	$0xf, %r15
je	..@15._size_15
..@15._size_16:
vmovdqu	(%r11), %xmm0
jmp	..@15.end_load
..@15._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm0, %xmm0
..@15._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm0, %xmm0
..@15._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm0, %xmm0
..@15._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm0, %xmm0
..@15._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm0, %xmm0
..@15._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm0, %xmm0
..@15._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm0, %xmm0
..@15._size_8:
vpinsrq	$0x0, (%r11), %xmm0, %xmm0
jmp	..@15._check_higher_16
..@15._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm0, %xmm0
..@15._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm0, %xmm0
..@15._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm0, %xmm0
..@15._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm0, %xmm0
..@15._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm0, %xmm0
..@15._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm0, %xmm0
..@15._size_1:
vpinsrb	$0x0, (%r11), %xmm0, %xmm0
..@15._check_higher_16:
testq	$0x10, %rdi
je	..@15.end_load
vinserti128	$0x1, %xmm0, %ymm0, %ymm0
vinserti128	$0x0, (%r9,%rax), %ymm0, %ymm0
..@15.end_load:
leaq	(%rdx,%r10,4), %r11
addq	$0x8, %r10
vmovdqu	(%r11), %ymm8
vmovdqu	(%r11,%rsi,4), %ymm9
vmovdqu	(%r11,%rsi,8), %ymm10
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm8
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm9
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm10
vpxor	%ymm8, %ymm2, %ymm2
vpxor	%ymm9, %ymm3, %ymm3
vpxor	%ymm10, %ymm4, %ymm4
cmpq	%rsi, %r10
jl	..@14.next_vect
leaq	(%r14,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@17.lt32
vmovdqu	%ymm2, (%r9)
jmp	..@17.end
..@17.lt32:
testq	$0x10, %rdi
je	..@17.lt16
vmovdqu	%xmm2, (%r9)
vperm2i128	$0x81, %ymm2, %ymm2, %ymm2
addq	$0x10, %r10
..@17.lt16:
testq	$0x8, %rdi
je	..@17.lt8
vmovq	%xmm2, (%r9,%r10)
vpsrldq	$0x8, %xmm2, %xmm2
addq	$0x8, %r10
..@17.lt8:
vmovq	%xmm2, %r11
testq	$0x4, %rdi
je	..@17.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@17.lt4:
testq	$0x2, %rdi
je	..@17.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@17.lt2:
testq	$0x1, %rdi
je	..@17.end
movb	%r11b, (%r9,%r10)
..@17.end:
leaq	(%r13,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@18.lt32
vmovdqu	%ymm3, (%r9)
jmp	..@18.end
..@18.lt32:
testq	$0x10, %rdi
je	..@18.lt16
vmovdqu	%xmm3, (%r9)
vperm2i128	$0x81, %ymm3, %ymm3, %ymm3
addq	$0x10, %r10
..@18.lt16:
testq	$0x8, %rdi
je	..@18.lt8
vmovq	%xmm3, (%r9,%r10)
vpsrldq	$0x8, %xmm3, %xmm3
addq	$0x8, %r10
..@18.lt8:
vmovq	%xmm3, %r11
testq	$0x4, %rdi
je	..@18.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@18.lt4:
testq	$0x2, %rdi
je	..@18.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@18.lt2:
testq	$0x1, %rdi
je	..@18.end
movb	%r11b, (%r9,%r10)
..@18.end:
leaq	(%r12,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@19.lt32
vmovdqu	%ymm4, (%r9)
jmp	..@19.end
..@19.lt32:
testq	$0x10, %rdi
je	..@19.lt16
vmovdqu	%xmm4, (%r9)
vperm2i128	$0x81, %ymm4, %ymm4, %ymm4
addq	$0x10, %r10
..@19.lt16:
testq	$0x8, %rdi
je	..@19.lt8
vmovq	%xmm4, (%r9,%r10)
vpsrldq	$0x8, %xmm4, %xmm4
addq	$0x8, %r10
..@19.lt8:
vmovq	%xmm4, %r11
testq	$0x4, %rdi
je	..@19.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@19.lt4:
testq	$0x2, %rdi
je	..@19.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@19.lt2:
testq	$0x1, %rdi
je	..@19.end
movb	%r11b, (%r9,%r10)
..@19.end:
gf_3vect_dot_prod_avx2_gfni.exit:
vzeroupper
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
addq	$0x20, %rsp
retq

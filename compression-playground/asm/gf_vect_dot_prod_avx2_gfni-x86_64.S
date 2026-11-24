	.text
gf_vect_dot_prod_avx2_gfni:
endbr64
subq	$0x8, %rsp
movq	%r12, (%rsp)
xorq	%rax, %rax
shlq	$0x3, %rsi
cmpq	$0x60, %rdi
jl	gf_vect_dot_prod_avx2_gfni.len_lt_96
gf_vect_dot_prod_avx2_gfni.loop96:
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm5, %ymm5, %ymm5
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
vmovdqu	0x20(%r9,%rax), %ymm1
vmovdqu	0x40(%r9,%rax), %ymm2
addq	$0x8, %r10
vmovdqu	(%r11), %ymm6
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %ymm6, %ymm0, %ymm7
vpxor	%ymm7, %ymm3, %ymm3
vgf2p8affineqb	$0x0, %ymm6, %ymm1, %ymm7
vpxor	%ymm7, %ymm4, %ymm4
vgf2p8affineqb	$0x0, %ymm6, %ymm2, %ymm7
vpxor	%ymm7, %ymm5, %ymm5
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu	%ymm3, (%r8,%rax)
vmovdqu	%ymm4, 0x20(%r8,%rax)
vmovdqu	%ymm5, 0x40(%r8,%rax)
addq	$0x60, %rax
subq	$0x60, %rdi
cmpq	$0x60, %rdi
jge	gf_vect_dot_prod_avx2_gfni.loop96
gf_vect_dot_prod_avx2_gfni.len_lt_96:
cmpq	$0x40, %rdi
jl	gf_vect_dot_prod_avx2_gfni.len_lt_64
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
movq	%rdx, %r11
xorq	%r10, %r10
..@13.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
vmovdqu	0x20(%r9,%rax), %ymm1
addq	$0x8, %r10
vmovdqu	(%r11), %ymm6
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %ymm6, %ymm0, %ymm7
vpxor	%ymm7, %ymm3, %ymm3
vgf2p8affineqb	$0x0, %ymm6, %ymm1, %ymm6
vpxor	%ymm6, %ymm4, %ymm4
cmpq	%rsi, %r10
jl	..@13.next_vect
vmovdqu	%ymm3, (%r8,%rax)
vmovdqu	%ymm4, 0x20(%r8,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
gf_vect_dot_prod_avx2_gfni.len_lt_64:
cmpq	$0x20, %rdi
jl	gf_vect_dot_prod_avx2_gfni.len_lt_32
vpxor	%ymm3, %ymm3, %ymm3
movq	%rdx, %r11
xorq	%r10, %r10
..@16.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
addq	$0x8, %r10
vmovdqu	(%r11), %ymm6
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %ymm6, %ymm0, %ymm6
vpxor	%ymm6, %ymm3, %ymm3
cmpq	%rsi, %r10
jl	..@16.next_vect
vmovdqu	%ymm3, (%r8,%rax)
addq	$0x20, %rax
subq	$0x20, %rdi
gf_vect_dot_prod_avx2_gfni.len_lt_32:
cmpq	$0x0, %rdi
jle	..@21.end
vpxor	%ymm3, %ymm3, %ymm3
xorq	%r10, %r10
..@18.next_vect:
movq	(%rcx,%r10), %r9
testq	$0x20, %rdi
je	..@19._skip_32
vmovdqu	(%r9,%rax), %ymm0
jmp	..@19.end_load
..@19._skip_32:
vpxor	%ymm0, %ymm0, %ymm0
orq	%rdi, %rdi
je	..@19.end_load
leaq	(%r9,%rax), %r11
movq	%rdi, %r12
cmpq	$0x10, %rdi
jle	..@19._check_size
addq	$0x10, %r11
subq	$0x10, %r12
..@19._check_size:
cmpq	$0x2, %r12
jb	..@19._size_1
je	..@19._size_2
cmpq	$0x4, %r12
jb	..@19._size_3
je	..@19._size_4
cmpq	$0x6, %r12
jb	..@19._size_5
je	..@19._size_6
cmpq	$0x8, %r12
jb	..@19._size_7
je	..@19._size_8
cmpq	$0xa, %r12
jb	..@19._size_9
je	..@19._size_10
cmpq	$0xc, %r12
jb	..@19._size_11
je	..@19._size_12
cmpq	$0xe, %r12
jb	..@19._size_13
je	..@19._size_14
cmpq	$0xf, %r12
je	..@19._size_15
..@19._size_16:
vmovdqu	(%r11), %xmm0
jmp	..@19.end_load
..@19._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm0, %xmm0
..@19._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm0, %xmm0
..@19._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm0, %xmm0
..@19._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm0, %xmm0
..@19._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm0, %xmm0
..@19._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm0, %xmm0
..@19._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm0, %xmm0
..@19._size_8:
vpinsrq	$0x0, (%r11), %xmm0, %xmm0
jmp	..@19._check_higher_16
..@19._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm0, %xmm0
..@19._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm0, %xmm0
..@19._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm0, %xmm0
..@19._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm0, %xmm0
..@19._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm0, %xmm0
..@19._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm0, %xmm0
..@19._size_1:
vpinsrb	$0x0, (%r11), %xmm0, %xmm0
..@19._check_higher_16:
testq	$0x10, %rdi
je	..@19.end_load
vinserti128	$0x1, %xmm0, %ymm0, %ymm0
vinserti128	$0x0, (%r9,%rax), %ymm0, %ymm0
..@19.end_load:
vmovdqu	(%rdx,%r10,4), %ymm6
addq	$0x8, %r10
vgf2p8affineqb	$0x0, %ymm6, %ymm0, %ymm6
vpxor	%ymm6, %ymm3, %ymm3
cmpq	%rsi, %r10
jl	..@18.next_vect
leaq	(%r8,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@21.lt32
vmovdqu	%ymm3, (%r9)
jmp	..@21.end
..@21.lt32:
testq	$0x10, %rdi
je	..@21.lt16
vmovdqu	%xmm3, (%r9)
vperm2i128	$0x81, %ymm3, %ymm3, %ymm3
addq	$0x10, %r10
..@21.lt16:
testq	$0x8, %rdi
je	..@21.lt8
vmovq	%xmm3, (%r9,%r10)
vpsrldq	$0x8, %xmm3, %xmm3
addq	$0x8, %r10
..@21.lt8:
vmovq	%xmm3, %r11
testq	$0x4, %rdi
je	..@21.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@21.lt4:
testq	$0x2, %rdi
je	..@21.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@21.lt2:
testq	$0x1, %rdi
je	..@21.end
movb	%r11b, (%r9,%r10)
..@21.end:
gf_vect_dot_prod_avx2_gfni.exit:
vzeroupper
movq	(%rsp), %r12
addq	$0x8, %rsp
retq

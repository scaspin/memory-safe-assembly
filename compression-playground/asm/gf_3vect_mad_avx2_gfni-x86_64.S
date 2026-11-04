	.text
gf_3vect_mad_avx2_gfni:
endbr64
xorq	%rax, %rax
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vbroadcastsd	(%r11), %ymm1
vbroadcastsd	(%r11,%rsi), %ymm2
vbroadcastsd	(%r11,%rsi,2), %ymm3
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	(%r9), %r9
cmpq	$0x40, %rdi
jl	gf_3vect_mad_avx2_gfni.len_lt_64
gf_3vect_mad_avx2_gfni.loop64:
vmovdqu	(%r8,%rax), %ymm0
vmovdqu	(%r9,%rax), %ymm4
vmovdqu	0x20(%r9,%rax), %ymm5
vmovdqu	(%rcx,%rax), %ymm6
vmovdqu	0x20(%rcx,%rax), %ymm7
vmovdqu	(%rdx,%rax), %ymm8
vmovdqu	0x20(%rdx,%rax), %ymm9
vgf2p8affineqb	$0x0, %ymm1, %ymm0, %ymm10
vgf2p8affineqb	$0x0, %ymm2, %ymm0, %ymm12
vgf2p8affineqb	$0x0, %ymm3, %ymm0, %ymm14
vpxor	%ymm10, %ymm4, %ymm4
vpxor	%ymm12, %ymm6, %ymm6
vpxor	%ymm14, %ymm8, %ymm8
vmovdqu	0x20(%r8,%rax), %ymm0
vgf2p8affineqb	$0x0, %ymm1, %ymm0, %ymm11
vgf2p8affineqb	$0x0, %ymm2, %ymm0, %ymm13
vgf2p8affineqb	$0x0, %ymm3, %ymm0, %ymm15
vpxor	%ymm11, %ymm5, %ymm5
vpxor	%ymm13, %ymm7, %ymm7
vpxor	%ymm15, %ymm9, %ymm9
vmovdqu	%ymm4, (%r9,%rax)
vmovdqu	%ymm5, 0x20(%r9,%rax)
vmovdqu	%ymm6, (%rcx,%rax)
vmovdqu	%ymm7, 0x20(%rcx,%rax)
vmovdqu	%ymm8, (%rdx,%rax)
vmovdqu	%ymm9, 0x20(%rdx,%rax)
addq	$0x40, %rax
subq	$0x40, %rdi
cmpq	$0x40, %rdi
jge	gf_3vect_mad_avx2_gfni.loop64
gf_3vect_mad_avx2_gfni.len_lt_64:
cmpq	$0x20, %rdi
jl	gf_3vect_mad_avx2_gfni.len_lt_32
vmovdqu	(%r8,%rax), %ymm0
vmovdqu	(%r9,%rax), %ymm4
vmovdqu	(%rcx,%rax), %ymm6
vmovdqu	(%rdx,%rax), %ymm8
vgf2p8affineqb	$0x0, %ymm1, %ymm0, %ymm10
vgf2p8affineqb	$0x0, %ymm2, %ymm0, %ymm12
vgf2p8affineqb	$0x0, %ymm3, %ymm0, %ymm14
vpxor	%ymm10, %ymm4, %ymm4
vpxor	%ymm12, %ymm6, %ymm6
vpxor	%ymm14, %ymm8, %ymm8
vmovdqu	%ymm4, (%r9,%rax)
vmovdqu	%ymm6, (%rcx,%rax)
vmovdqu	%ymm8, (%rdx,%rax)
addq	$0x20, %rax
subq	$0x20, %rdi
gf_3vect_mad_avx2_gfni.len_lt_32:
cmpq	$0x0, %rdi
jle	..@21.end
testq	$0x20, %rdi
je	..@14._skip_32
vmovdqu	(%r8,%rax), %ymm0
jmp	..@14.end_load
..@14._skip_32:
vpxor	%ymm0, %ymm0, %ymm0
orq	%rdi, %rdi
je	..@14.end_load
leaq	(%r8,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@14._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@14._check_size:
cmpq	$0x2, %r10
jb	..@14._size_1
je	..@14._size_2
cmpq	$0x4, %r10
jb	..@14._size_3
je	..@14._size_4
cmpq	$0x6, %r10
jb	..@14._size_5
je	..@14._size_6
cmpq	$0x8, %r10
jb	..@14._size_7
je	..@14._size_8
cmpq	$0xa, %r10
jb	..@14._size_9
je	..@14._size_10
cmpq	$0xc, %r10
jb	..@14._size_11
je	..@14._size_12
cmpq	$0xe, %r10
jb	..@14._size_13
je	..@14._size_14
cmpq	$0xf, %r10
je	..@14._size_15
..@14._size_16:
vmovdqu	(%r11), %xmm0
jmp	..@14.end_load
..@14._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm0, %xmm0
..@14._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm0, %xmm0
..@14._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm0, %xmm0
..@14._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm0, %xmm0
..@14._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm0, %xmm0
..@14._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm0, %xmm0
..@14._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm0, %xmm0
..@14._size_8:
vpinsrq	$0x0, (%r11), %xmm0, %xmm0
jmp	..@14._check_higher_16
..@14._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm0, %xmm0
..@14._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm0, %xmm0
..@14._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm0, %xmm0
..@14._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm0, %xmm0
..@14._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm0, %xmm0
..@14._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm0, %xmm0
..@14._size_1:
vpinsrb	$0x0, (%r11), %xmm0, %xmm0
..@14._check_higher_16:
testq	$0x10, %rdi
je	..@14.end_load
vinserti128	$0x1, %xmm0, %ymm0, %ymm0
vinserti128	$0x0, (%r8,%rax), %ymm0, %ymm0
..@14.end_load:
testq	$0x20, %rdi
je	..@15._skip_32
vmovdqu	(%r9,%rax), %ymm4
jmp	..@15.end_load
..@15._skip_32:
vpxor	%ymm4, %ymm4, %ymm4
orq	%rdi, %rdi
je	..@15.end_load
leaq	(%r9,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@15._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@15._check_size:
cmpq	$0x2, %r10
jb	..@15._size_1
je	..@15._size_2
cmpq	$0x4, %r10
jb	..@15._size_3
je	..@15._size_4
cmpq	$0x6, %r10
jb	..@15._size_5
je	..@15._size_6
cmpq	$0x8, %r10
jb	..@15._size_7
je	..@15._size_8
cmpq	$0xa, %r10
jb	..@15._size_9
je	..@15._size_10
cmpq	$0xc, %r10
jb	..@15._size_11
je	..@15._size_12
cmpq	$0xe, %r10
jb	..@15._size_13
je	..@15._size_14
cmpq	$0xf, %r10
je	..@15._size_15
..@15._size_16:
vmovdqu	(%r11), %xmm4
jmp	..@15.end_load
..@15._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm4, %xmm4
..@15._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm4, %xmm4
..@15._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm4, %xmm4
..@15._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm4, %xmm4
..@15._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm4, %xmm4
..@15._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm4, %xmm4
..@15._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm4, %xmm4
..@15._size_8:
vpinsrq	$0x0, (%r11), %xmm4, %xmm4
jmp	..@15._check_higher_16
..@15._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm4, %xmm4
..@15._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm4, %xmm4
..@15._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm4, %xmm4
..@15._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm4, %xmm4
..@15._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm4, %xmm4
..@15._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm4, %xmm4
..@15._size_1:
vpinsrb	$0x0, (%r11), %xmm4, %xmm4
..@15._check_higher_16:
testq	$0x10, %rdi
je	..@15.end_load
vinserti128	$0x1, %xmm4, %ymm4, %ymm4
vinserti128	$0x0, (%r9,%rax), %ymm4, %ymm4
..@15.end_load:
testq	$0x20, %rdi
je	..@16._skip_32
vmovdqu	(%rcx,%rax), %ymm6
jmp	..@16.end_load
..@16._skip_32:
vpxor	%ymm6, %ymm6, %ymm6
orq	%rdi, %rdi
je	..@16.end_load
leaq	(%rcx,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@16._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@16._check_size:
cmpq	$0x2, %r10
jb	..@16._size_1
je	..@16._size_2
cmpq	$0x4, %r10
jb	..@16._size_3
je	..@16._size_4
cmpq	$0x6, %r10
jb	..@16._size_5
je	..@16._size_6
cmpq	$0x8, %r10
jb	..@16._size_7
je	..@16._size_8
cmpq	$0xa, %r10
jb	..@16._size_9
je	..@16._size_10
cmpq	$0xc, %r10
jb	..@16._size_11
je	..@16._size_12
cmpq	$0xe, %r10
jb	..@16._size_13
je	..@16._size_14
cmpq	$0xf, %r10
je	..@16._size_15
..@16._size_16:
vmovdqu	(%r11), %xmm6
jmp	..@16.end_load
..@16._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm6, %xmm6
..@16._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm6, %xmm6
..@16._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm6, %xmm6
..@16._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm6, %xmm6
..@16._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm6, %xmm6
..@16._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm6, %xmm6
..@16._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm6, %xmm6
..@16._size_8:
vpinsrq	$0x0, (%r11), %xmm6, %xmm6
jmp	..@16._check_higher_16
..@16._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm6, %xmm6
..@16._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm6, %xmm6
..@16._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm6, %xmm6
..@16._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm6, %xmm6
..@16._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm6, %xmm6
..@16._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm6, %xmm6
..@16._size_1:
vpinsrb	$0x0, (%r11), %xmm6, %xmm6
..@16._check_higher_16:
testq	$0x10, %rdi
je	..@16.end_load
vinserti128	$0x1, %xmm6, %ymm6, %ymm6
vinserti128	$0x0, (%rcx,%rax), %ymm6, %ymm6
..@16.end_load:
testq	$0x20, %rdi
je	..@17._skip_32
vmovdqu	(%rdx,%rax), %ymm8
jmp	..@17.end_load
..@17._skip_32:
vpxor	%ymm8, %ymm8, %ymm8
orq	%rdi, %rdi
je	..@17.end_load
leaq	(%rdx,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@17._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@17._check_size:
cmpq	$0x2, %r10
jb	..@17._size_1
je	..@17._size_2
cmpq	$0x4, %r10
jb	..@17._size_3
je	..@17._size_4
cmpq	$0x6, %r10
jb	..@17._size_5
je	..@17._size_6
cmpq	$0x8, %r10
jb	..@17._size_7
je	..@17._size_8
cmpq	$0xa, %r10
jb	..@17._size_9
je	..@17._size_10
cmpq	$0xc, %r10
jb	..@17._size_11
je	..@17._size_12
cmpq	$0xe, %r10
jb	..@17._size_13
je	..@17._size_14
cmpq	$0xf, %r10
je	..@17._size_15
..@17._size_16:
vmovdqu	(%r11), %xmm8
jmp	..@17.end_load
..@17._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm8, %xmm8
..@17._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm8, %xmm8
..@17._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm8, %xmm8
..@17._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm8, %xmm8
..@17._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm8, %xmm8
..@17._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm8, %xmm8
..@17._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm8, %xmm8
..@17._size_8:
vpinsrq	$0x0, (%r11), %xmm8, %xmm8
jmp	..@17._check_higher_16
..@17._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm8, %xmm8
..@17._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm8, %xmm8
..@17._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm8, %xmm8
..@17._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm8, %xmm8
..@17._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm8, %xmm8
..@17._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm8, %xmm8
..@17._size_1:
vpinsrb	$0x0, (%r11), %xmm8, %xmm8
..@17._check_higher_16:
testq	$0x10, %rdi
je	..@17.end_load
vinserti128	$0x1, %xmm8, %ymm8, %ymm8
vinserti128	$0x0, (%rdx,%rax), %ymm8, %ymm8
..@17.end_load:
vgf2p8affineqb	$0x0, %ymm1, %ymm0, %ymm10
vgf2p8affineqb	$0x0, %ymm2, %ymm0, %ymm12
vgf2p8affineqb	$0x0, %ymm3, %ymm0, %ymm14
vpxor	%ymm10, %ymm4, %ymm4
vpxor	%ymm12, %ymm6, %ymm6
vpxor	%ymm14, %ymm8, %ymm8
leaq	(%r9,%rax), %r9
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
leaq	(%rcx,%rax), %rcx
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@20.lt32
vmovdqu	%ymm6, (%rcx)
jmp	..@20.end
..@20.lt32:
testq	$0x10, %rdi
je	..@20.lt16
vmovdqu	%xmm6, (%rcx)
vperm2i128	$0x81, %ymm6, %ymm6, %ymm6
addq	$0x10, %r10
..@20.lt16:
testq	$0x8, %rdi
je	..@20.lt8
vmovq	%xmm6, (%rcx,%r10)
vpsrldq	$0x8, %xmm6, %xmm6
addq	$0x8, %r10
..@20.lt8:
vmovq	%xmm6, %r11
testq	$0x4, %rdi
je	..@20.lt4
movl	%r11d, (%rcx,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@20.lt4:
testq	$0x2, %rdi
je	..@20.lt2
movw	%r11w, (%rcx,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@20.lt2:
testq	$0x1, %rdi
je	..@20.end
movb	%r11b, (%rcx,%r10)
..@20.end:
leaq	(%rdx,%rax), %rdx
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@21.lt32
vmovdqu	%ymm8, (%rdx)
jmp	..@21.end
..@21.lt32:
testq	$0x10, %rdi
je	..@21.lt16
vmovdqu	%xmm8, (%rdx)
vperm2i128	$0x81, %ymm8, %ymm8, %ymm8
addq	$0x10, %r10
..@21.lt16:
testq	$0x8, %rdi
je	..@21.lt8
vmovq	%xmm8, (%rdx,%r10)
vpsrldq	$0x8, %xmm8, %xmm8
addq	$0x8, %r10
..@21.lt8:
vmovq	%xmm8, %r11
testq	$0x4, %rdi
je	..@21.lt4
movl	%r11d, (%rdx,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@21.lt4:
testq	$0x2, %rdi
je	..@21.lt2
movw	%r11w, (%rdx,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@21.lt2:
testq	$0x1, %rdi
je	..@21.end
movb	%r11b, (%rdx,%r10)
..@21.end:
gf_3vect_mad_avx2_gfni.exit:
vzeroupper
retq

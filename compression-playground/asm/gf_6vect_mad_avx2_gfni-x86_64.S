	.text
gf_6vect_mad_avx2_gfni:
endbr64
subq	$0x10, %rsp
movq	%r12, (%rsp)
movq	%r13, 0x8(%rsp)
xorq	%rax, %rax
shlq	$0x5, %rdx
shlq	$0x5, %rsi
leaq	(%rcx,%rdx), %r11
vbroadcastsd	(%r11), %ymm7
vbroadcastsd	(%r11,%rsi), %ymm8
vbroadcastsd	(%r11,%rsi,2), %ymm9
vbroadcastsd	(%r11,%rsi,4), %ymm11
addq	%rsi, %r11
vbroadcastsd	(%r11,%rsi,2), %ymm10
vbroadcastsd	(%r11,%rsi,4), %ymm12
movq	0x8(%r9), %rcx
movq	0x10(%r9), %rdx
movq	0x18(%r9), %r12
movq	0x20(%r9), %r13
movq	0x28(%r9), %rsi
movq	(%r9), %r9
cmpq	$0x20, %rdi
jl	gf_6vect_mad_avx2_gfni.len_lt_32
gf_6vect_mad_avx2_gfni.loop32:
vmovdqu	(%r8,%rax), %ymm0
vmovdqu	(%r9,%rax), %ymm1
vmovdqu	(%rcx,%rax), %ymm2
vmovdqu	(%rdx,%rax), %ymm3
vmovdqu	(%r12,%rax), %ymm4
vmovdqu	(%r13,%rax), %ymm5
vmovdqu	(%rsi,%rax), %ymm6
vgf2p8affineqb	$0x0, %ymm7, %ymm0, %ymm13
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm14
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm15
vpxor	%ymm13, %ymm1, %ymm1
vpxor	%ymm14, %ymm2, %ymm2
vpxor	%ymm15, %ymm3, %ymm3
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm13
vgf2p8affineqb	$0x0, %ymm11, %ymm0, %ymm14
vgf2p8affineqb	$0x0, %ymm12, %ymm0, %ymm15
vpxor	%ymm13, %ymm4, %ymm4
vpxor	%ymm14, %ymm5, %ymm5
vpxor	%ymm15, %ymm6, %ymm6
vmovdqu	%ymm1, (%r9,%rax)
vmovdqu	%ymm2, (%rcx,%rax)
vmovdqu	%ymm3, (%rdx,%rax)
vmovdqu	%ymm4, (%r12,%rax)
vmovdqu	%ymm5, (%r13,%rax)
vmovdqu	%ymm6, (%rsi,%rax)
addq	$0x20, %rax
subq	$0x20, %rdi
cmpq	$0x20, %rdi
jge	gf_6vect_mad_avx2_gfni.loop32
gf_6vect_mad_avx2_gfni.len_lt_32:
cmpq	$0x0, %rdi
jle	..@27.end
testq	$0x20, %rdi
je	..@13._skip_32
vmovdqu	(%r8,%rax), %ymm0
jmp	..@13.end_load
..@13._skip_32:
vpxor	%ymm0, %ymm0, %ymm0
orq	%rdi, %rdi
je	..@13.end_load
leaq	(%r8,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@13._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@13._check_size:
cmpq	$0x2, %r10
jb	..@13._size_1
je	..@13._size_2
cmpq	$0x4, %r10
jb	..@13._size_3
je	..@13._size_4
cmpq	$0x6, %r10
jb	..@13._size_5
je	..@13._size_6
cmpq	$0x8, %r10
jb	..@13._size_7
je	..@13._size_8
cmpq	$0xa, %r10
jb	..@13._size_9
je	..@13._size_10
cmpq	$0xc, %r10
jb	..@13._size_11
je	..@13._size_12
cmpq	$0xe, %r10
jb	..@13._size_13
je	..@13._size_14
cmpq	$0xf, %r10
je	..@13._size_15
..@13._size_16:
vmovdqu	(%r11), %xmm0
jmp	..@13.end_load
..@13._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm0, %xmm0
..@13._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm0, %xmm0
..@13._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm0, %xmm0
..@13._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm0, %xmm0
..@13._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm0, %xmm0
..@13._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm0, %xmm0
..@13._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm0, %xmm0
..@13._size_8:
vpinsrq	$0x0, (%r11), %xmm0, %xmm0
jmp	..@13._check_higher_16
..@13._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm0, %xmm0
..@13._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm0, %xmm0
..@13._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm0, %xmm0
..@13._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm0, %xmm0
..@13._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm0, %xmm0
..@13._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm0, %xmm0
..@13._size_1:
vpinsrb	$0x0, (%r11), %xmm0, %xmm0
..@13._check_higher_16:
testq	$0x10, %rdi
je	..@13.end_load
vinserti128	$0x1, %xmm0, %ymm0, %ymm0
vinserti128	$0x0, (%r8,%rax), %ymm0, %ymm0
..@13.end_load:
testq	$0x20, %rdi
je	..@14._skip_32
vmovdqu	(%r9,%rax), %ymm1
jmp	..@14.end_load
..@14._skip_32:
vpxor	%ymm1, %ymm1, %ymm1
orq	%rdi, %rdi
je	..@14.end_load
leaq	(%r9,%rax), %r11
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
vmovdqu	(%r11), %xmm1
jmp	..@14.end_load
..@14._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm1, %xmm1
..@14._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm1, %xmm1
..@14._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm1, %xmm1
..@14._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm1, %xmm1
..@14._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm1, %xmm1
..@14._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm1, %xmm1
..@14._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm1, %xmm1
..@14._size_8:
vpinsrq	$0x0, (%r11), %xmm1, %xmm1
jmp	..@14._check_higher_16
..@14._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm1, %xmm1
..@14._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm1, %xmm1
..@14._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm1, %xmm1
..@14._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm1, %xmm1
..@14._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm1, %xmm1
..@14._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm1, %xmm1
..@14._size_1:
vpinsrb	$0x0, (%r11), %xmm1, %xmm1
..@14._check_higher_16:
testq	$0x10, %rdi
je	..@14.end_load
vinserti128	$0x1, %xmm1, %ymm1, %ymm1
vinserti128	$0x0, (%r9,%rax), %ymm1, %ymm1
..@14.end_load:
testq	$0x20, %rdi
je	..@15._skip_32
vmovdqu	(%rcx,%rax), %ymm2
jmp	..@15.end_load
..@15._skip_32:
vpxor	%ymm2, %ymm2, %ymm2
orq	%rdi, %rdi
je	..@15.end_load
leaq	(%rcx,%rax), %r11
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
vmovdqu	(%r11), %xmm2
jmp	..@15.end_load
..@15._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm2, %xmm2
..@15._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm2, %xmm2
..@15._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm2, %xmm2
..@15._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm2, %xmm2
..@15._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm2, %xmm2
..@15._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm2, %xmm2
..@15._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm2, %xmm2
..@15._size_8:
vpinsrq	$0x0, (%r11), %xmm2, %xmm2
jmp	..@15._check_higher_16
..@15._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm2, %xmm2
..@15._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm2, %xmm2
..@15._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm2, %xmm2
..@15._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm2, %xmm2
..@15._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm2, %xmm2
..@15._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm2, %xmm2
..@15._size_1:
vpinsrb	$0x0, (%r11), %xmm2, %xmm2
..@15._check_higher_16:
testq	$0x10, %rdi
je	..@15.end_load
vinserti128	$0x1, %xmm2, %ymm2, %ymm2
vinserti128	$0x0, (%rcx,%rax), %ymm2, %ymm2
..@15.end_load:
testq	$0x20, %rdi
je	..@16._skip_32
vmovdqu	(%rdx,%rax), %ymm3
jmp	..@16.end_load
..@16._skip_32:
vpxor	%ymm3, %ymm3, %ymm3
orq	%rdi, %rdi
je	..@16.end_load
leaq	(%rdx,%rax), %r11
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
vmovdqu	(%r11), %xmm3
jmp	..@16.end_load
..@16._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm3, %xmm3
..@16._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm3, %xmm3
..@16._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm3, %xmm3
..@16._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm3, %xmm3
..@16._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm3, %xmm3
..@16._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm3, %xmm3
..@16._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm3, %xmm3
..@16._size_8:
vpinsrq	$0x0, (%r11), %xmm3, %xmm3
jmp	..@16._check_higher_16
..@16._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm3, %xmm3
..@16._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm3, %xmm3
..@16._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm3, %xmm3
..@16._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm3, %xmm3
..@16._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm3, %xmm3
..@16._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm3, %xmm3
..@16._size_1:
vpinsrb	$0x0, (%r11), %xmm3, %xmm3
..@16._check_higher_16:
testq	$0x10, %rdi
je	..@16.end_load
vinserti128	$0x1, %xmm3, %ymm3, %ymm3
vinserti128	$0x0, (%rdx,%rax), %ymm3, %ymm3
..@16.end_load:
testq	$0x20, %rdi
je	..@17._skip_32
vmovdqu	(%r12,%rax), %ymm4
jmp	..@17.end_load
..@17._skip_32:
vpxor	%ymm4, %ymm4, %ymm4
orq	%rdi, %rdi
je	..@17.end_load
leaq	(%r12,%rax), %r11
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
vmovdqu	(%r11), %xmm4
jmp	..@17.end_load
..@17._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm4, %xmm4
..@17._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm4, %xmm4
..@17._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm4, %xmm4
..@17._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm4, %xmm4
..@17._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm4, %xmm4
..@17._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm4, %xmm4
..@17._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm4, %xmm4
..@17._size_8:
vpinsrq	$0x0, (%r11), %xmm4, %xmm4
jmp	..@17._check_higher_16
..@17._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm4, %xmm4
..@17._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm4, %xmm4
..@17._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm4, %xmm4
..@17._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm4, %xmm4
..@17._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm4, %xmm4
..@17._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm4, %xmm4
..@17._size_1:
vpinsrb	$0x0, (%r11), %xmm4, %xmm4
..@17._check_higher_16:
testq	$0x10, %rdi
je	..@17.end_load
vinserti128	$0x1, %xmm4, %ymm4, %ymm4
vinserti128	$0x0, (%r12,%rax), %ymm4, %ymm4
..@17.end_load:
testq	$0x20, %rdi
je	..@18._skip_32
vmovdqu	(%r13,%rax), %ymm5
jmp	..@18.end_load
..@18._skip_32:
vpxor	%ymm5, %ymm5, %ymm5
orq	%rdi, %rdi
je	..@18.end_load
leaq	(%r13,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@18._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@18._check_size:
cmpq	$0x2, %r10
jb	..@18._size_1
je	..@18._size_2
cmpq	$0x4, %r10
jb	..@18._size_3
je	..@18._size_4
cmpq	$0x6, %r10
jb	..@18._size_5
je	..@18._size_6
cmpq	$0x8, %r10
jb	..@18._size_7
je	..@18._size_8
cmpq	$0xa, %r10
jb	..@18._size_9
je	..@18._size_10
cmpq	$0xc, %r10
jb	..@18._size_11
je	..@18._size_12
cmpq	$0xe, %r10
jb	..@18._size_13
je	..@18._size_14
cmpq	$0xf, %r10
je	..@18._size_15
..@18._size_16:
vmovdqu	(%r11), %xmm5
jmp	..@18.end_load
..@18._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm5, %xmm5
..@18._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm5, %xmm5
..@18._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm5, %xmm5
..@18._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm5, %xmm5
..@18._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm5, %xmm5
..@18._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm5, %xmm5
..@18._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm5, %xmm5
..@18._size_8:
vpinsrq	$0x0, (%r11), %xmm5, %xmm5
jmp	..@18._check_higher_16
..@18._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm5, %xmm5
..@18._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm5, %xmm5
..@18._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm5, %xmm5
..@18._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm5, %xmm5
..@18._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm5, %xmm5
..@18._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm5, %xmm5
..@18._size_1:
vpinsrb	$0x0, (%r11), %xmm5, %xmm5
..@18._check_higher_16:
testq	$0x10, %rdi
je	..@18.end_load
vinserti128	$0x1, %xmm5, %ymm5, %ymm5
vinserti128	$0x0, (%r13,%rax), %ymm5, %ymm5
..@18.end_load:
testq	$0x20, %rdi
je	..@19._skip_32
vmovdqu	(%rsi,%rax), %ymm6
jmp	..@19.end_load
..@19._skip_32:
vpxor	%ymm6, %ymm6, %ymm6
orq	%rdi, %rdi
je	..@19.end_load
leaq	(%rsi,%rax), %r11
movq	%rdi, %r10
cmpq	$0x10, %rdi
jle	..@19._check_size
addq	$0x10, %r11
subq	$0x10, %r10
..@19._check_size:
cmpq	$0x2, %r10
jb	..@19._size_1
je	..@19._size_2
cmpq	$0x4, %r10
jb	..@19._size_3
je	..@19._size_4
cmpq	$0x6, %r10
jb	..@19._size_5
je	..@19._size_6
cmpq	$0x8, %r10
jb	..@19._size_7
je	..@19._size_8
cmpq	$0xa, %r10
jb	..@19._size_9
je	..@19._size_10
cmpq	$0xc, %r10
jb	..@19._size_11
je	..@19._size_12
cmpq	$0xe, %r10
jb	..@19._size_13
je	..@19._size_14
cmpq	$0xf, %r10
je	..@19._size_15
..@19._size_16:
vmovdqu	(%r11), %xmm6
jmp	..@19.end_load
..@19._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm6, %xmm6
..@19._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm6, %xmm6
..@19._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm6, %xmm6
..@19._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm6, %xmm6
..@19._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm6, %xmm6
..@19._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm6, %xmm6
..@19._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm6, %xmm6
..@19._size_8:
vpinsrq	$0x0, (%r11), %xmm6, %xmm6
jmp	..@19._check_higher_16
..@19._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm6, %xmm6
..@19._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm6, %xmm6
..@19._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm6, %xmm6
..@19._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm6, %xmm6
..@19._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm6, %xmm6
..@19._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm6, %xmm6
..@19._size_1:
vpinsrb	$0x0, (%r11), %xmm6, %xmm6
..@19._check_higher_16:
testq	$0x10, %rdi
je	..@19.end_load
vinserti128	$0x1, %xmm6, %ymm6, %ymm6
vinserti128	$0x0, (%rsi,%rax), %ymm6, %ymm6
..@19.end_load:
vgf2p8affineqb	$0x0, %ymm7, %ymm0, %ymm13
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm14
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm15
vpxor	%ymm13, %ymm1, %ymm1
vpxor	%ymm14, %ymm2, %ymm2
vpxor	%ymm15, %ymm3, %ymm3
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm13
vgf2p8affineqb	$0x0, %ymm11, %ymm0, %ymm14
vgf2p8affineqb	$0x0, %ymm12, %ymm0, %ymm15
vpxor	%ymm13, %ymm4, %ymm4
vpxor	%ymm14, %ymm5, %ymm5
vpxor	%ymm15, %ymm6, %ymm6
leaq	(%r9,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@22.lt32
vmovdqu	%ymm1, (%r9)
jmp	..@22.end
..@22.lt32:
testq	$0x10, %rdi
je	..@22.lt16
vmovdqu	%xmm1, (%r9)
vperm2i128	$0x81, %ymm1, %ymm1, %ymm1
addq	$0x10, %r10
..@22.lt16:
testq	$0x8, %rdi
je	..@22.lt8
vmovq	%xmm1, (%r9,%r10)
vpsrldq	$0x8, %xmm1, %xmm1
addq	$0x8, %r10
..@22.lt8:
vmovq	%xmm1, %r11
testq	$0x4, %rdi
je	..@22.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@22.lt4:
testq	$0x2, %rdi
je	..@22.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@22.lt2:
testq	$0x1, %rdi
je	..@22.end
movb	%r11b, (%r9,%r10)
..@22.end:
leaq	(%rcx,%rax), %rcx
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@23.lt32
vmovdqu	%ymm2, (%rcx)
jmp	..@23.end
..@23.lt32:
testq	$0x10, %rdi
je	..@23.lt16
vmovdqu	%xmm2, (%rcx)
vperm2i128	$0x81, %ymm2, %ymm2, %ymm2
addq	$0x10, %r10
..@23.lt16:
testq	$0x8, %rdi
je	..@23.lt8
vmovq	%xmm2, (%rcx,%r10)
vpsrldq	$0x8, %xmm2, %xmm2
addq	$0x8, %r10
..@23.lt8:
vmovq	%xmm2, %r11
testq	$0x4, %rdi
je	..@23.lt4
movl	%r11d, (%rcx,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@23.lt4:
testq	$0x2, %rdi
je	..@23.lt2
movw	%r11w, (%rcx,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@23.lt2:
testq	$0x1, %rdi
je	..@23.end
movb	%r11b, (%rcx,%r10)
..@23.end:
leaq	(%rdx,%rax), %rdx
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@24.lt32
vmovdqu	%ymm3, (%rdx)
jmp	..@24.end
..@24.lt32:
testq	$0x10, %rdi
je	..@24.lt16
vmovdqu	%xmm3, (%rdx)
vperm2i128	$0x81, %ymm3, %ymm3, %ymm3
addq	$0x10, %r10
..@24.lt16:
testq	$0x8, %rdi
je	..@24.lt8
vmovq	%xmm3, (%rdx,%r10)
vpsrldq	$0x8, %xmm3, %xmm3
addq	$0x8, %r10
..@24.lt8:
vmovq	%xmm3, %r11
testq	$0x4, %rdi
je	..@24.lt4
movl	%r11d, (%rdx,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@24.lt4:
testq	$0x2, %rdi
je	..@24.lt2
movw	%r11w, (%rdx,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@24.lt2:
testq	$0x1, %rdi
je	..@24.end
movb	%r11b, (%rdx,%r10)
..@24.end:
leaq	(%r12,%rax), %r12
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@25.lt32
vmovdqu	%ymm4, (%r12)
jmp	..@25.end
..@25.lt32:
testq	$0x10, %rdi
je	..@25.lt16
vmovdqu	%xmm4, (%r12)
vperm2i128	$0x81, %ymm4, %ymm4, %ymm4
addq	$0x10, %r10
..@25.lt16:
testq	$0x8, %rdi
je	..@25.lt8
vmovq	%xmm4, (%r12,%r10)
vpsrldq	$0x8, %xmm4, %xmm4
addq	$0x8, %r10
..@25.lt8:
vmovq	%xmm4, %r11
testq	$0x4, %rdi
je	..@25.lt4
movl	%r11d, (%r12,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@25.lt4:
testq	$0x2, %rdi
je	..@25.lt2
movw	%r11w, (%r12,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@25.lt2:
testq	$0x1, %rdi
je	..@25.end
movb	%r11b, (%r12,%r10)
..@25.end:
leaq	(%r13,%rax), %r13
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@26.lt32
vmovdqu	%ymm5, (%r13)
jmp	..@26.end
..@26.lt32:
testq	$0x10, %rdi
je	..@26.lt16
vmovdqu	%xmm5, (%r13)
vperm2i128	$0x81, %ymm5, %ymm5, %ymm5
addq	$0x10, %r10
..@26.lt16:
testq	$0x8, %rdi
je	..@26.lt8
vmovq	%xmm5, (%r13,%r10)
vpsrldq	$0x8, %xmm5, %xmm5
addq	$0x8, %r10
..@26.lt8:
vmovq	%xmm5, %r11
testq	$0x4, %rdi
je	..@26.lt4
movl	%r11d, (%r13,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@26.lt4:
testq	$0x2, %rdi
je	..@26.lt2
movw	%r11w, (%r13,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@26.lt2:
testq	$0x1, %rdi
je	..@26.end
movb	%r11b, (%r13,%r10)
..@26.end:
leaq	(%rsi,%rax), %rsi
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@27.lt32
vmovdqu	%ymm6, (%rsi)
jmp	..@27.end
..@27.lt32:
testq	$0x10, %rdi
je	..@27.lt16
vmovdqu	%xmm6, (%rsi)
vperm2i128	$0x81, %ymm6, %ymm6, %ymm6
addq	$0x10, %r10
..@27.lt16:
testq	$0x8, %rdi
je	..@27.lt8
vmovq	%xmm6, (%rsi,%r10)
vpsrldq	$0x8, %xmm6, %xmm6
addq	$0x8, %r10
..@27.lt8:
vmovq	%xmm6, %r11
testq	$0x4, %rdi
je	..@27.lt4
movl	%r11d, (%rsi,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@27.lt4:
testq	$0x2, %rdi
je	..@27.lt2
movw	%r11w, (%rsi,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@27.lt2:
testq	$0x1, %rdi
je	..@27.end
movb	%r11b, (%rsi,%r10)
..@27.end:
gf_6vect_mad_avx2_gfni.exit:
vzeroupper
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
addq	$0x10, %rsp
retq

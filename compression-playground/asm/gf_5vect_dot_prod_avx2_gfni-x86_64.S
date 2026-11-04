	.text
gf_5vect_dot_prod_avx2_gfni:
endbr64
subq	$0x30, %rsp
movq	%r12, (%rsp)
movq	%r13, 0x8(%rsp)
movq	%r14, 0x10(%rsp)
movq	%r15, 0x18(%rsp)
movq	%rbp, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
xorq	%rax, %rax
movq	%rsi, %r15
imulq	$0x60, %r15, %r15
movq	%rsi, %rbx
imulq	$0x80, %rbx, %rbx
shlq	$0x3, %rsi
movq	0x8(%r8), %r13
movq	0x10(%r8), %r12
movq	0x18(%r8), %r14
movq	0x20(%r8), %rbp
movq	(%r8), %r8
cmpq	$0x20, %rdi
jl	gf_5vect_dot_prod_avx2_gfni.len_lt_32
gf_5vect_dot_prod_avx2_gfni.loop32:
vpxor	%ymm1, %ymm1, %ymm1
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm5, %ymm5, %ymm5
movq	%rdx, %r11
xorq	%r10, %r10
..@9.next_vect:
movq	(%rcx,%r10), %r9
vmovdqu	(%r9,%rax), %ymm0
addq	$0x8, %r10
vmovdqu	(%r11), %ymm6
vmovdqu	(%r11,%rsi,4), %ymm7
vmovdqu	(%r11,%rsi,8), %ymm8
vmovdqu	(%r11,%r15), %ymm9
vmovdqu	(%r11,%rbx), %ymm10
addq	$0x20, %r11
vgf2p8affineqb	$0x0, %ymm6, %ymm0, %ymm6
vgf2p8affineqb	$0x0, %ymm7, %ymm0, %ymm7
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm8
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm9
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm10
vpxor	%ymm6, %ymm1, %ymm1
vpxor	%ymm7, %ymm2, %ymm2
vpxor	%ymm8, %ymm3, %ymm3
vpxor	%ymm9, %ymm4, %ymm4
vpxor	%ymm10, %ymm5, %ymm5
cmpq	%rsi, %r10
jl	..@9.next_vect
vmovdqu	%ymm1, (%r8,%rax)
vmovdqu	%ymm2, (%r13,%rax)
vmovdqu	%ymm3, (%r12,%rax)
vmovdqu	%ymm4, (%r14,%rax)
vmovdqu	%ymm5, (%rbp,%rax)
addq	$0x20, %rax
subq	$0x20, %rdi
cmpq	$0x20, %rdi
jge	gf_5vect_dot_prod_avx2_gfni.loop32
gf_5vect_dot_prod_avx2_gfni.len_lt_32:
orq	%rdi, %rdi
je	..@18.end
vpxor	%ymm1, %ymm1, %ymm1
vpxor	%ymm2, %ymm2, %ymm2
vpxor	%ymm3, %ymm3, %ymm3
vpxor	%ymm4, %ymm4, %ymm4
vpxor	%ymm5, %ymm5, %ymm5
xorq	%r10, %r10
..@11.next_vect:
movq	(%rcx,%r10), %r9
testq	$0x20, %rdi
je	..@12._skip_32
vmovdqu	(%r9,%rax), %ymm0
jmp	..@12.end_load
..@12._skip_32:
vpxor	%ymm0, %ymm0, %ymm0
orq	%rdi, %rdi
je	..@12.end_load
leaq	(%r9,%rax), %r11
movq	%rdi, %r15
cmpq	$0x10, %rdi
jle	..@12._check_size
addq	$0x10, %r11
subq	$0x10, %r15
..@12._check_size:
cmpq	$0x2, %r15
jb	..@12._size_1
je	..@12._size_2
cmpq	$0x4, %r15
jb	..@12._size_3
je	..@12._size_4
cmpq	$0x6, %r15
jb	..@12._size_5
je	..@12._size_6
cmpq	$0x8, %r15
jb	..@12._size_7
je	..@12._size_8
cmpq	$0xa, %r15
jb	..@12._size_9
je	..@12._size_10
cmpq	$0xc, %r15
jb	..@12._size_11
je	..@12._size_12
cmpq	$0xe, %r15
jb	..@12._size_13
je	..@12._size_14
cmpq	$0xf, %r15
je	..@12._size_15
..@12._size_16:
vmovdqu	(%r11), %xmm0
jmp	..@12.end_load
..@12._size_15:
vpinsrb	$0xe, 0xe(%r11), %xmm0, %xmm0
..@12._size_14:
vpinsrb	$0xd, 0xd(%r11), %xmm0, %xmm0
..@12._size_13:
vpinsrb	$0xc, 0xc(%r11), %xmm0, %xmm0
..@12._size_12:
vpinsrb	$0xb, 0xb(%r11), %xmm0, %xmm0
..@12._size_11:
vpinsrb	$0xa, 0xa(%r11), %xmm0, %xmm0
..@12._size_10:
vpinsrb	$0x9, 0x9(%r11), %xmm0, %xmm0
..@12._size_9:
vpinsrb	$0x8, 0x8(%r11), %xmm0, %xmm0
..@12._size_8:
vpinsrq	$0x0, (%r11), %xmm0, %xmm0
jmp	..@12._check_higher_16
..@12._size_7:
vpinsrb	$0x6, 0x6(%r11), %xmm0, %xmm0
..@12._size_6:
vpinsrb	$0x5, 0x5(%r11), %xmm0, %xmm0
..@12._size_5:
vpinsrb	$0x4, 0x4(%r11), %xmm0, %xmm0
..@12._size_4:
vpinsrb	$0x3, 0x3(%r11), %xmm0, %xmm0
..@12._size_3:
vpinsrb	$0x2, 0x2(%r11), %xmm0, %xmm0
..@12._size_2:
vpinsrb	$0x1, 0x1(%r11), %xmm0, %xmm0
..@12._size_1:
vpinsrb	$0x0, (%r11), %xmm0, %xmm0
..@12._check_higher_16:
testq	$0x10, %rdi
je	..@12.end_load
vinserti128	$0x1, %xmm0, %ymm0, %ymm0
vinserti128	$0x0, (%r9,%rax), %ymm0, %ymm0
..@12.end_load:
imulq	$0xc, %rsi, %r15
leaq	(%rdx,%r10,4), %r11
addq	$0x8, %r10
vmovdqu	(%r11), %ymm6
vmovdqu	(%r11,%rsi,4), %ymm7
vmovdqu	(%r11,%rsi,8), %ymm8
vmovdqu	(%r11,%r15), %ymm9
vmovdqu	(%r11,%rbx), %ymm10
vgf2p8affineqb	$0x0, %ymm6, %ymm0, %ymm6
vgf2p8affineqb	$0x0, %ymm7, %ymm0, %ymm7
vgf2p8affineqb	$0x0, %ymm8, %ymm0, %ymm8
vgf2p8affineqb	$0x0, %ymm9, %ymm0, %ymm9
vgf2p8affineqb	$0x0, %ymm10, %ymm0, %ymm10
vpxor	%ymm6, %ymm1, %ymm1
vpxor	%ymm7, %ymm2, %ymm2
vpxor	%ymm8, %ymm3, %ymm3
vpxor	%ymm9, %ymm4, %ymm4
vpxor	%ymm10, %ymm5, %ymm5
cmpq	%rsi, %r10
jl	..@11.next_vect
leaq	(%r8,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@14.lt32
vmovdqu	%ymm1, (%r9)
jmp	..@14.end
..@14.lt32:
testq	$0x10, %rdi
je	..@14.lt16
vmovdqu	%xmm1, (%r9)
vperm2i128	$0x81, %ymm1, %ymm1, %ymm1
addq	$0x10, %r10
..@14.lt16:
testq	$0x8, %rdi
je	..@14.lt8
vmovq	%xmm1, (%r9,%r10)
vpsrldq	$0x8, %xmm1, %xmm1
addq	$0x8, %r10
..@14.lt8:
vmovq	%xmm1, %r11
testq	$0x4, %rdi
je	..@14.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@14.lt4:
testq	$0x2, %rdi
je	..@14.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@14.lt2:
testq	$0x1, %rdi
je	..@14.end
movb	%r11b, (%r9,%r10)
..@14.end:
leaq	(%r13,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@15.lt32
vmovdqu	%ymm2, (%r9)
jmp	..@15.end
..@15.lt32:
testq	$0x10, %rdi
je	..@15.lt16
vmovdqu	%xmm2, (%r9)
vperm2i128	$0x81, %ymm2, %ymm2, %ymm2
addq	$0x10, %r10
..@15.lt16:
testq	$0x8, %rdi
je	..@15.lt8
vmovq	%xmm2, (%r9,%r10)
vpsrldq	$0x8, %xmm2, %xmm2
addq	$0x8, %r10
..@15.lt8:
vmovq	%xmm2, %r11
testq	$0x4, %rdi
je	..@15.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@15.lt4:
testq	$0x2, %rdi
je	..@15.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@15.lt2:
testq	$0x1, %rdi
je	..@15.end
movb	%r11b, (%r9,%r10)
..@15.end:
leaq	(%r12,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@16.lt32
vmovdqu	%ymm3, (%r9)
jmp	..@16.end
..@16.lt32:
testq	$0x10, %rdi
je	..@16.lt16
vmovdqu	%xmm3, (%r9)
vperm2i128	$0x81, %ymm3, %ymm3, %ymm3
addq	$0x10, %r10
..@16.lt16:
testq	$0x8, %rdi
je	..@16.lt8
vmovq	%xmm3, (%r9,%r10)
vpsrldq	$0x8, %xmm3, %xmm3
addq	$0x8, %r10
..@16.lt8:
vmovq	%xmm3, %r11
testq	$0x4, %rdi
je	..@16.lt4
movl	%r11d, (%r9,%r10)
shrq	$0x20, %r11
addq	$0x4, %r10
..@16.lt4:
testq	$0x2, %rdi
je	..@16.lt2
movw	%r11w, (%r9,%r10)
shrq	$0x10, %r11
addq	$0x2, %r10
..@16.lt2:
testq	$0x1, %rdi
je	..@16.end
movb	%r11b, (%r9,%r10)
..@16.end:
leaq	(%r14,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@17.lt32
vmovdqu	%ymm4, (%r9)
jmp	..@17.end
..@17.lt32:
testq	$0x10, %rdi
je	..@17.lt16
vmovdqu	%xmm4, (%r9)
vperm2i128	$0x81, %ymm4, %ymm4, %ymm4
addq	$0x10, %r10
..@17.lt16:
testq	$0x8, %rdi
je	..@17.lt8
vmovq	%xmm4, (%r9,%r10)
vpsrldq	$0x8, %xmm4, %xmm4
addq	$0x8, %r10
..@17.lt8:
vmovq	%xmm4, %r11
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
leaq	(%rbp,%rax), %r9
xorq	%r10, %r10
testq	$0x20, %rdi
je	..@18.lt32
vmovdqu	%ymm5, (%r9)
jmp	..@18.end
..@18.lt32:
testq	$0x10, %rdi
je	..@18.lt16
vmovdqu	%xmm5, (%r9)
vperm2i128	$0x81, %ymm5, %ymm5, %ymm5
addq	$0x10, %r10
..@18.lt16:
testq	$0x8, %rdi
je	..@18.lt8
vmovq	%xmm5, (%r9,%r10)
vpsrldq	$0x8, %xmm5, %xmm5
addq	$0x8, %r10
..@18.lt8:
vmovq	%xmm5, %r11
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
gf_5vect_dot_prod_avx2_gfni.exit:
vzeroupper
movq	(%rsp), %r12
movq	0x8(%rsp), %r13
movq	0x10(%rsp), %r14
movq	0x18(%rsp), %r15
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
addq	$0x30, %rsp
retq

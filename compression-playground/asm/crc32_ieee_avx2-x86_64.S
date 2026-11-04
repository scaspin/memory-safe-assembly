	.text
crc32_ieee_avx2:
endbr64
leaq	crc32_ieee_const(%rip), %r10
notl	%edi
cmpq	$0x100, %rdx
jb	_less_than_256
vmovd	%edi, %xmm10
vpslldq	$0xc, %xmm10, %xmm10
vbroadcasti128	bswap_shuf_mask(%rip), %ymm11
vmovdqu	(%rsi), %ymm0
vmovdqu	0x20(%rsi), %ymm1
vmovdqu	0x40(%rsi), %ymm2
vmovdqu	0x60(%rsi), %ymm3
vpshufb	%ymm11, %ymm0, %ymm0
vpxor	%ymm10, %ymm0, %ymm0
vpshufb	%ymm11, %ymm1, %ymm1
vpshufb	%ymm11, %ymm2, %ymm2
vpshufb	%ymm11, %ymm3, %ymm3
vbroadcasti128	0x20(%r10), %ymm10
subq	$0x100, %rdx
cmpq	$0x100, %rdx
jb	_fold_128_B_loop
vmovdqu	0x80(%rsi), %ymm8
vmovdqu	0xa0(%rsi), %ymm9
vmovdqu	0xc0(%rsi), %ymm12
vmovdqu	0xe0(%rsi), %ymm13
vpshufb	%ymm11, %ymm8, %ymm8
vpshufb	%ymm11, %ymm9, %ymm9
vpshufb	%ymm11, %ymm12, %ymm12
vpshufb	%ymm11, %ymm13, %ymm13
vbroadcasti128	(%r10), %ymm15
subq	$0x100, %rdx
cmpq	$0x1100, %rdx
jb	_fold_256_B_loop
_fold_and_prefetch_256_B_loop:
addq	$0x100, %rsi
prefetcht1	0x1000(%rsi)
vmovdqu	(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm0, %ymm4
vpclmulqdq	$0x11, %ymm15, %ymm0, %ymm0
vpxor	%ymm14, %ymm0, %ymm0
vpxor	%ymm4, %ymm0, %ymm0
vmovdqu	0x20(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm1, %ymm5
vpclmulqdq	$0x11, %ymm15, %ymm1, %ymm1
vpxor	%ymm14, %ymm1, %ymm1
vpxor	%ymm5, %ymm1, %ymm1
prefetcht1	0x1040(%rsi)
vmovdqu	0x40(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm2, %ymm4
vpclmulqdq	$0x11, %ymm15, %ymm2, %ymm2
vpxor	%ymm14, %ymm2, %ymm2
vpxor	%ymm4, %ymm2, %ymm2
vmovdqu	0x60(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm3, %ymm5
vpclmulqdq	$0x11, %ymm15, %ymm3, %ymm3
vpxor	%ymm14, %ymm3, %ymm3
vpxor	%ymm5, %ymm3, %ymm3
prefetcht1	0x1080(%rsi)
vmovdqu	0x80(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm8, %ymm6
vpclmulqdq	$0x11, %ymm15, %ymm8, %ymm8
vpxor	%ymm14, %ymm8, %ymm8
vpxor	%ymm6, %ymm8, %ymm8
vmovdqu	0xa0(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm9, %ymm7
vpclmulqdq	$0x11, %ymm15, %ymm9, %ymm9
vpxor	%ymm14, %ymm9, %ymm9
vpxor	%ymm7, %ymm9, %ymm9
prefetcht1	0x10c0(%rsi)
vmovdqu	0xc0(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm12, %ymm6
vpclmulqdq	$0x11, %ymm15, %ymm12, %ymm12
vpxor	%ymm14, %ymm12, %ymm12
vpxor	%ymm6, %ymm12, %ymm12
vmovdqu	0xe0(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm13, %ymm7
vpclmulqdq	$0x11, %ymm15, %ymm13, %ymm13
vpxor	%ymm14, %ymm13, %ymm13
vpxor	%ymm7, %ymm13, %ymm13
subq	$0x100, %rdx
cmpq	$0x1100, %rdx
jge	_fold_and_prefetch_256_B_loop
nop
nop
nop
nop
nop
nop
_fold_256_B_loop:
addq	$0x100, %rsi
vmovdqu	(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm0, %ymm4
vpclmulqdq	$0x11, %ymm15, %ymm0, %ymm0
vpxor	%ymm14, %ymm0, %ymm0
vpxor	%ymm4, %ymm0, %ymm0
vmovdqu	0x20(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm1, %ymm5
vpclmulqdq	$0x11, %ymm15, %ymm1, %ymm1
vpxor	%ymm14, %ymm1, %ymm1
vpxor	%ymm5, %ymm1, %ymm1
vmovdqu	0x40(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm2, %ymm4
vpclmulqdq	$0x11, %ymm15, %ymm2, %ymm2
vpxor	%ymm14, %ymm2, %ymm2
vpxor	%ymm4, %ymm2, %ymm2
vmovdqu	0x60(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm3, %ymm5
vpclmulqdq	$0x11, %ymm15, %ymm3, %ymm3
vpxor	%ymm14, %ymm3, %ymm3
vpxor	%ymm5, %ymm3, %ymm3
vmovdqu	0x80(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm8, %ymm6
vpclmulqdq	$0x11, %ymm15, %ymm8, %ymm8
vpxor	%ymm14, %ymm8, %ymm8
vpxor	%ymm6, %ymm8, %ymm8
vmovdqu	0xa0(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm9, %ymm7
vpclmulqdq	$0x11, %ymm15, %ymm9, %ymm9
vpxor	%ymm14, %ymm9, %ymm9
vpxor	%ymm7, %ymm9, %ymm9
vmovdqu	0xc0(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm12, %ymm6
vpclmulqdq	$0x11, %ymm15, %ymm12, %ymm12
vpxor	%ymm14, %ymm12, %ymm12
vpxor	%ymm6, %ymm12, %ymm12
vmovdqu	0xe0(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm15, %ymm13, %ymm7
vpclmulqdq	$0x11, %ymm15, %ymm13, %ymm13
vpxor	%ymm14, %ymm13, %ymm13
vpxor	%ymm7, %ymm13, %ymm13
subq	$0x100, %rdx
jge	_fold_256_B_loop
addq	$0x80, %rsi
vpclmulqdq	$0x0, %ymm10, %ymm0, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm0, %ymm0
vpxor	%ymm4, %ymm0, %ymm0
vpxor	%ymm8, %ymm0, %ymm0
vpclmulqdq	$0x0, %ymm10, %ymm1, %ymm5
vpclmulqdq	$0x11, %ymm10, %ymm1, %ymm1
vpxor	%ymm5, %ymm1, %ymm1
vpxor	%ymm9, %ymm1, %ymm1
vpclmulqdq	$0x0, %ymm10, %ymm2, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm2, %ymm2
vpxor	%ymm4, %ymm2, %ymm2
vpxor	%ymm12, %ymm2, %ymm2
vpclmulqdq	$0x0, %ymm10, %ymm3, %ymm5
vpclmulqdq	$0x11, %ymm10, %ymm3, %ymm3
vpxor	%ymm5, %ymm3, %ymm3
vpxor	%ymm13, %ymm3, %ymm3
addq	$0x80, %rdx
cmpq	$0x80, %rdx
jl	_fold_less_than_128_B
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
_fold_128_B_loop:
addq	$0x80, %rsi
vmovdqu	(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm10, %ymm0, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm0, %ymm0
vpxor	%ymm14, %ymm0, %ymm0
vpxor	%ymm4, %ymm0, %ymm0
vmovdqu	0x20(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm10, %ymm1, %ymm5
vpclmulqdq	$0x11, %ymm10, %ymm1, %ymm1
vpxor	%ymm14, %ymm1, %ymm1
vpxor	%ymm5, %ymm1, %ymm1
vmovdqu	0x40(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm10, %ymm2, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm2, %ymm2
vpxor	%ymm14, %ymm2, %ymm2
vpxor	%ymm4, %ymm2, %ymm2
vmovdqu	0x60(%rsi), %ymm14
vpshufb	%ymm11, %ymm14, %ymm14
vpclmulqdq	$0x0, %ymm10, %ymm3, %ymm5
vpclmulqdq	$0x11, %ymm10, %ymm3, %ymm3
vpxor	%ymm14, %ymm3, %ymm3
vpxor	%ymm5, %ymm3, %ymm3
subq	$0x80, %rdx
jge	_fold_128_B_loop
nop
_fold_less_than_128_B:
addq	$0x80, %rsi
vextracti128	$0x1, %ymm3, %xmm7
vmovdqu	0x50(%r10), %ymm10
vpclmulqdq	$0x0, %ymm10, %ymm0, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm0, %ymm12
vpxor	%ymm4, %ymm12, %ymm12
vmovdqu	0x70(%r10), %ymm10
vpclmulqdq	$0x0, %ymm10, %ymm1, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm1, %ymm5
vpxor	%ymm4, %ymm12, %ymm12
vpxor	%ymm5, %ymm12, %ymm12
vmovdqu	0x90(%r10), %ymm10
vpclmulqdq	$0x0, %ymm10, %ymm2, %ymm4
vpclmulqdq	$0x11, %ymm10, %ymm2, %ymm5
vpxor	%ymm4, %ymm12, %ymm12
vpxor	%ymm5, %ymm12, %ymm12
vmovdqa	0x10(%r10), %xmm10
vpclmulqdq	$0x0, %xmm10, %xmm3, %xmm4
vpclmulqdq	$0x11, %xmm10, %xmm3, %xmm5
vpxor	%ymm4, %ymm12, %ymm12
vpxor	%ymm5, %ymm12, %ymm12
vextracti128	$0x1, %ymm12, %xmm4
vpxor	%xmm4, %xmm7, %xmm7
vpxor	%xmm12, %xmm7, %xmm7
addq	$0x70, %rdx
jl	_final_reduction_for_128
nop
nop
nop
nop
nop
nop
nop
_16B_reduction_loop:
vmovdqa	%xmm7, %xmm8
vpclmulqdq	$0x11, %xmm10, %xmm7, %xmm7
vpclmulqdq	$0x0, %xmm10, %xmm8, %xmm8
vpxor	%xmm8, %xmm7, %xmm7
vmovdqu	(%rsi), %xmm0
vpshufb	%xmm11, %xmm0, %xmm0
vpxor	%xmm0, %xmm7, %xmm7
addq	$0x10, %rsi
subq	$0x10, %rdx
jge	_16B_reduction_loop
nop
nop
nop
nop
_final_reduction_for_128:
addq	$0x10, %rdx
je	_128_done
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
_get_last_two_xmms:
vmovdqa	%xmm7, %xmm2
vmovdqu	-0x10(%rsi,%rdx), %xmm1
vpshufb	%xmm11, %xmm1, %xmm1
leaq	shf_table_refl+16(%rip), %rax
subq	%rdx, %rax
vmovdqu	(%rax), %xmm0
vpshufb	%xmm0, %xmm2, %xmm2
vpxor	shf_xor_mask(%rip), %xmm0, %xmm0
vpshufb	%xmm0, %xmm7, %xmm7
vpblendvb	%xmm0, %xmm2, %xmm1, %xmm1
vmovdqa	%xmm1, %xmm2
vmovdqa	%xmm7, %xmm8
vpclmulqdq	$0x11, %xmm10, %xmm7, %xmm7
vpclmulqdq	$0x0, %xmm10, %xmm8, %xmm8
vpxor	%xmm8, %xmm7, %xmm7
vpxor	%xmm2, %xmm7, %xmm7
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
_128_done:
vmovdqa	0x30(%r10), %xmm10
vmovdqa	%xmm7, %xmm0
vpclmulqdq	$0x1, %xmm10, %xmm7, %xmm7
vpslldq	$0x8, %xmm0, %xmm0
vpxor	%xmm0, %xmm7, %xmm7
vmovdqa	%xmm7, %xmm0
vpand	hi32_clr_mask(%rip), %xmm0, %xmm0
vpsrldq	$0xc, %xmm7, %xmm7
vpclmulqdq	$0x10, %xmm10, %xmm7, %xmm7
vpxor	%xmm0, %xmm7, %xmm7
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
_barrett:
vmovdqa	0x40(%r10), %xmm10
vmovdqa	%xmm7, %xmm0
vpclmulqdq	$0x1, %xmm10, %xmm7, %xmm7
vpslldq	$0x4, %xmm7, %xmm7
vpclmulqdq	$0x11, %xmm10, %xmm7, %xmm7
vpslldq	$0x4, %xmm7, %xmm7
vpxor	%xmm0, %xmm7, %xmm7
vpextrd	$0x1, %xmm7, %eax
_cleanup:
notl	%eax
retq
nop
nop
nop
_less_than_256:
cmpq	$0x20, %rdx
jb	_less_than_32
vmovdqa	bswap_shuf_mask(%rip), %xmm11
vmovdqa	0x10(%r10), %xmm10
vmovd	%edi, %xmm0
vpslldq	$0xc, %xmm0, %xmm0
vmovdqu	(%rsi), %xmm7
vpshufb	%xmm11, %xmm7, %xmm7
vpxor	%xmm0, %xmm7, %xmm7
addq	$0x10, %rsi
subq	$0x20, %rdx
jmp	_16B_reduction_loop
nop
nop
nop
nop
nop
nop
nop
nop
nop
_less_than_32:
movl	%edi, %eax
testq	%rdx, %rdx
je	_cleanup
vmovdqa	bswap_shuf_mask(%rip), %xmm11
vmovd	%edi, %xmm0
vpslldq	$0xc, %xmm0, %xmm0
cmpq	$0x10, %rdx
je	_exact_16_left
jb	_less_than_16_left
vmovdqu	(%rsi), %xmm7
vpshufb	%xmm11, %xmm7, %xmm7
vpxor	%xmm0, %xmm7, %xmm7
addq	$0x10, %rsi
subq	$0x10, %rdx
vmovdqa	0x10(%r10), %xmm10
jmp	_get_last_two_xmms
_exact_16_left:
vmovdqu	(%rsi), %xmm7
vpshufb	%xmm11, %xmm7, %xmm7
vpxor	%xmm0, %xmm7, %xmm7
jmp	_128_done
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
_less_than_16_left:
vpxor	%xmm7, %xmm7, %xmm7
cmpq	$0x2, %rdx
jb	..@38._size_1
je	..@38._size_2
cmpq	$0x4, %rdx
jb	..@38._size_3
je	..@38._size_4
cmpq	$0x6, %rdx
jb	..@38._size_5
je	..@38._size_6
cmpq	$0x8, %rdx
jb	..@38._size_7
je	..@38._size_8
cmpq	$0xa, %rdx
jb	..@38._size_9
je	..@38._size_10
cmpq	$0xc, %rdx
jb	..@38._size_11
je	..@38._size_12
cmpq	$0xe, %rdx
jb	..@38._size_13
je	..@38._size_14
..@38._size_15:
vpinsrb	$0xe, 0xe(%rsi), %xmm7, %xmm7
..@38._size_14:
vpinsrb	$0xd, 0xd(%rsi), %xmm7, %xmm7
..@38._size_13:
vpinsrb	$0xc, 0xc(%rsi), %xmm7, %xmm7
..@38._size_12:
vpinsrb	$0xb, 0xb(%rsi), %xmm7, %xmm7
..@38._size_11:
vpinsrb	$0xa, 0xa(%rsi), %xmm7, %xmm7
..@38._size_10:
vpinsrb	$0x9, 0x9(%rsi), %xmm7, %xmm7
..@38._size_9:
vpinsrb	$0x8, 0x8(%rsi), %xmm7, %xmm7
..@38._size_8:
vpinsrq	$0x0, (%rsi), %xmm7, %xmm7
jmp	..@38.end_load
..@38._size_7:
vpinsrb	$0x6, 0x6(%rsi), %xmm7, %xmm7
..@38._size_6:
vpinsrb	$0x5, 0x5(%rsi), %xmm7, %xmm7
..@38._size_5:
vpinsrb	$0x4, 0x4(%rsi), %xmm7, %xmm7
..@38._size_4:
vpinsrb	$0x3, 0x3(%rsi), %xmm7, %xmm7
..@38._size_3:
vpinsrb	$0x2, 0x2(%rsi), %xmm7, %xmm7
..@38._size_2:
vpinsrb	$0x1, 0x1(%rsi), %xmm7, %xmm7
..@38._size_1:
vpinsrb	$0x0, (%rsi), %xmm7, %xmm7
..@38.end_load:
vpshufb	%xmm11, %xmm7, %xmm7
vpxor	%xmm0, %xmm7, %xmm7
cmpq	$0x4, %rdx
jb	_only_less_than_4
leaq	shf_table_refl+16(%rip), %rax
subq	%rdx, %rax
vmovdqu	(%rax), %xmm0
vpxor	shf_xor_mask(%rip), %xmm0, %xmm0
vpshufb	%xmm0, %xmm7, %xmm7
jmp	_128_done
_only_less_than_4:
movl	$0x3, %eax
subq	%rdx, %rax
leaq	tail_shuf_norm(%rip), %r11
addq	%rax, %r11
vmovdqu	(%r11), %xmm0
vpshufb	%xmm0, %xmm7, %xmm7
jmp	_barrett
# ---- crc_const.S, for bswap_shuf_mask, crc32_ieee_const, hi32_clr_mask, shf_table_refl, shf_xor_mask, tail_shuf_norm
	.text
	.text
	.section .rodata
crc32_gzip_refl_const:
	.byte 113,18,92,233,0,0,0,0,203,113,51,206,0,0,0,0
	.byte 158,0,170,204,0,0,0,0,208,151,25,117,1,0,0,0
	.byte 128,232,127,74,1,0,0,0,114,243,142,232,1,0,0,0
	.byte 158,0,170,204,0,0,0,0,36,97,205,99,1,0,0,0
	.byte 64,22,1,247,1,0,0,0,64,6,113,219,1,0,0,0
	.byte 172,198,207,215,1,0,0,0,126,54,137,234,1,0,0,0
	.byte 88,78,180,140,1,0,0,0,194,141,6,223,0,0,0,0
	.byte 148,83,11,174,0,0,0,0,84,158,86,199,1,0,0,0
	.byte 150,21,228,198,1,0,0,0,212,43,68,84,1,0,0,0
	.byte 6,148,53,116,1,0,0,0,220,236,177,61,0,0,0,0
	.byte 102,99,84,90,1,0,0,0,170,5,218,241,0,0,0,0
	.byte 158,0,170,204,0,0,0,0,208,151,25,117,1,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc32_ieee_const:
	.byte 0,0,0,0,153,104,81,24,0,0,0,0,81,133,220,163
	.byte 0,0,0,0,102,170,0,242,0,0,0,0,93,49,211,23
	.byte 0,0,0,0,165,252,47,2,0,0,0,0,47,226,158,157
	.byte 0,0,0,0,102,170,0,242,0,0,0,0,141,103,13,73
	.byte 223,1,209,4,1,0,0,0,183,29,193,4,1,0,0,0
	.byte 0,0,0,0,215,231,199,106,0,0,0,0,175,34,217,252
	.byte 0,0,0,0,99,90,228,52,0,0,0,0,246,193,98,135
	.byte 0,0,0,0,234,160,149,83,0,0,0,0,199,213,242,84
	.byte 0,0,0,0,199,78,80,211,0,0,0,0,85,68,168,87
	.byte 0,0,0,0,93,88,83,192,0,0,0,0,120,27,111,118
	.byte 0,0,0,0,181,84,140,205,0,0,0,0,30,183,64,171
	.byte 0,0,0,0,102,170,0,242,0,0,0,0,93,49,211,23
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc32_iscsi_const:
	.byte 134,43,224,185,0,0,0,0,164,122,177,220,0,0,0,0
	.byte 39,125,60,73,0,0,0,0,80,140,6,193,14,0,0,0
	.byte 112,141,227,6,2,0,0,0,162,206,146,105,0,0,0,0
	.byte 39,125,60,73,0,0,0,0,184,170,69,221,0,0,0,0
	.byte 240,19,167,222,0,0,0,0,240,118,236,5,1,0,0,0
	.byte 23,131,219,71,0,0,0,0,48,28,217,42,0,0,0,0
	.byte 83,206,21,7,0,0,0,0,103,79,159,196,0,0,0,0
	.byte 150,178,211,57,0,0,0,0,236,110,58,8,0,0,0,0
	.byte 248,221,74,158,0,0,0,0,2,239,14,116,0,0,0,0
	.byte 43,21,192,221,0,0,0,0,4,29,41,28,0,0,0,0
	.byte 142,194,79,186,0,0,0,0,203,208,166,61,0,0,0,0
	.byte 39,125,60,73,0,0,0,0,80,140,6,193,14,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc16_t10dif_const:
	.byte 0,0,0,0,0,0,207,220,0,0,0,0,0,0,11,75
	.byte 0,0,0,0,0,0,86,45,0,0,0,0,0,0,223,6
	.byte 0,0,0,0,0,0,157,157,0,0,0,0,0,0,245,124
	.byte 0,0,0,0,0,0,86,45,0,0,0,0,0,0,104,19
	.byte 248,87,90,246,1,0,0,0,0,0,183,139,1,0,0,0
	.byte 0,0,0,0,0,0,174,206,0,0,0,0,0,0,214,191
	.byte 0,0,0,0,0,0,22,30,0,0,0,0,0,0,60,113
	.byte 0,0,0,0,0,0,249,247,0,0,0,0,0,0,166,128
	.byte 0,0,0,0,0,0,76,4,0,0,0,0,0,0,88,230
	.byte 0,0,0,0,0,0,24,173,0,0,0,0,0,0,151,164
	.byte 0,0,0,0,0,0,227,110,0,0,0,0,0,0,181,231
	.byte 0,0,0,0,0,0,86,45,0,0,0,0,0,0,223,6
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc16_t10dif_copy_const:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,86,45,0,0,0,0,0,0,223,6
	.byte 0,0,0,0,0,0,76,4,0,0,0,0,0,0,88,230
	.byte 0,0,0,0,0,0,86,45,0,0,0,0,0,0,104,19
	.byte 248,87,90,246,1,0,0,0,0,0,183,139,1,0,0,0
crc64_iso_norm_const:
	.byte 68,1,0,0,26,0,0,0,172,29,0,0,94,1,0,0
	.byte 69,1,0,0,0,0,0,0,183,29,0,0,0,0,0,0
	.byte 26,0,1,0,0,0,1,0,94,1,27,0,0,0,27,0
	.byte 69,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 27,0,0,0,0,0,0,0,27,0,0,0,0,0,0,0
	.byte 21,80,20,69,81,20,80,1,199,113,219,182,109,219,113,28
	.byte 17,1,17,16,1,17,1,0,171,26,171,177,26,171,26,0
	.byte 69,68,1,69,68,1,0,0,183,170,29,183,170,29,0,0
	.byte 1,1,0,1,1,0,0,0,27,27,0,27,27,0,0,0
	.byte 21,69,81,1,0,0,0,0,199,182,109,28,0,0,0,0
	.byte 17,16,1,0,0,0,0,0,171,177,26,0,0,0,0,0
	.byte 69,1,0,0,0,0,0,0,183,29,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_iso_refl_const:
	.byte 0,0,0,176,0,0,0,69,0,0,0,245,0,0,112,107
	.byte 1,0,0,0,0,0,0,245,1,0,0,0,0,0,112,107
	.byte 0,0,1,0,0,0,1,176,0,176,1,0,0,176,1,245
	.byte 1,0,0,0,0,0,0,245,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,176,0,0,0,0,0,0,0,176
	.byte 1,21,80,20,69,81,20,224,113,28,183,109,219,182,29,119
	.byte 1,0,17,1,17,16,1,161,1,176,170,177,26,171,177,26
	.byte 1,0,0,69,68,1,69,244,1,0,112,171,218,113,171,106
	.byte 1,0,0,0,1,1,0,177,1,0,0,176,177,1,176,1
	.byte 1,0,0,0,0,21,69,225,1,0,0,0,112,108,219,118
	.byte 1,0,0,0,0,0,17,160,1,0,0,0,0,176,26,27
	.byte 1,0,0,0,0,0,0,245,1,0,0,0,0,0,112,107
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_ecma_norm_const:
	.byte 13,199,221,96,26,105,82,127,130,12,106,159,56,176,54,112
	.byte 182,250,82,235,199,195,245,5,14,116,87,210,167,56,185,78
	.byte 214,55,172,169,222,121,207,5,194,213,215,113,229,103,16,0
	.byte 182,250,82,235,199,195,245,5,0,0,0,0,0,0,0,0
	.byte 114,248,196,108,208,41,141,87,147,54,234,169,235,225,240,66
	.byte 193,10,182,95,223,244,100,228,242,156,117,90,179,197,73,182
	.byte 221,208,130,255,30,78,240,154,232,143,127,41,9,230,130,110
	.byte 115,46,189,152,110,81,124,9,123,46,226,49,123,71,118,11
	.byte 32,240,13,84,202,67,104,95,63,184,5,18,152,182,244,221
	.byte 44,139,117,19,135,157,129,84,90,175,176,62,7,144,107,74
	.byte 43,249,126,34,10,238,27,87,12,32,181,1,162,242,190,68
	.byte 182,250,82,235,199,195,245,5,14,116,87,210,167,56,185,78
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_ecma_refl_const:
	.byte 121,139,34,30,39,217,31,243,28,216,26,56,242,173,96,130
	.byte 64,95,135,199,175,149,190,218,228,58,57,202,151,212,93,224
	.byte 64,231,61,247,42,107,216,215,0,16,204,79,29,215,87,135
	.byte 64,95,135,199,175,149,190,218,0,0,0,0,0,0,0,0
	.byte 213,99,41,23,108,70,62,156,132,30,14,175,43,175,216,146
	.byte 203,82,80,89,222,116,120,148,218,36,71,155,181,92,115,158
	.byte 55,0,234,95,213,44,206,228,236,130,206,32,41,253,227,47
	.byte 165,99,26,66,25,213,49,14,37,195,202,18,50,32,48,46
	.byte 244,45,132,167,84,96,31,8,243,65,212,157,187,239,227,106
	.byte 84,2,115,195,145,93,163,105,164,172,19,192,249,26,234,181
	.byte 81,175,225,15,163,83,230,59,68,250,158,138,0,91,9,96
	.byte 64,95,135,199,175,149,190,218,228,58,57,202,151,212,93,224
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_jones_norm_const:
	.byte 82,28,75,57,18,82,255,68,178,34,33,88,176,108,109,149
	.byte 56,112,1,80,39,237,69,68,54,215,251,124,21,116,139,105
	.byte 117,183,196,1,81,251,252,12,102,200,190,124,212,63,64,101
	.byte 56,112,1,80,39,237,69,68,0,0,0,0,0,0,0,0
	.byte 248,108,190,152,178,238,243,221,169,53,201,148,53,210,147,173
	.byte 180,39,165,43,142,32,220,216,197,43,187,118,236,207,50,240
	.byte 56,66,127,53,79,4,54,181,122,166,139,147,77,16,191,253
	.byte 231,67,168,151,146,173,221,238,115,100,70,41,230,188,80,53
	.byte 94,210,67,202,88,30,80,78,67,246,39,143,88,97,201,19
	.byte 188,153,16,203,13,208,96,59,163,185,83,140,70,31,191,68
	.byte 238,121,113,49,110,35,242,150,172,75,214,13,170,57,8,240
	.byte 56,112,1,80,39,237,69,68,54,215,251,124,21,116,139,105
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_jones_refl_const:
	.byte 68,254,149,144,56,165,113,148,82,109,109,26,52,8,137,154
	.byte 68,68,111,201,21,0,29,56,44,163,93,80,125,190,215,217
	.byte 11,237,41,77,82,97,131,118,76,5,248,87,124,250,38,204
	.byte 68,68,111,201,21,0,29,56,0,0,0,0,0,0,0,0
	.byte 119,159,239,154,50,250,108,62,106,147,151,88,83,38,89,43
	.byte 54,118,8,226,168,75,201,91,117,11,113,55,143,156,240,108
	.byte 90,217,64,228,89,253,133,56,126,251,17,100,147,163,203,188
	.byte 133,229,252,203,129,13,221,228,51,134,237,150,123,227,21,183
	.byte 228,20,240,52,166,132,151,244,251,180,154,109,177,239,134,175
	.byte 184,13,22,96,167,17,50,123,47,105,102,157,49,178,98,160
	.byte 210,158,136,237,24,29,61,239,30,32,56,171,96,215,164,107
	.byte 68,68,111,201,21,0,29,56,44,163,93,80,125,190,215,217
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_rocksoft_norm_const:
	.byte 83,178,202,246,213,239,91,33,216,103,150,15,5,44,167,122
	.byte 8,47,221,240,72,201,8,107,174,118,4,127,169,139,87,8
	.byte 244,67,233,219,240,98,147,118,10,167,44,240,156,249,115,4
	.byte 8,47,221,240,72,201,8,107,0,0,0,0,0,0,0,0
	.byte 200,111,190,152,178,238,243,221,89,54,201,148,53,210,147,173
	.byte 82,76,35,4,120,165,118,122,79,180,190,161,80,1,139,222
	.byte 88,94,139,228,136,214,236,18,33,126,60,97,79,214,214,37
	.byte 217,239,241,28,250,28,128,226,188,161,26,97,23,62,32,255
	.byte 140,72,136,4,106,78,65,180,96,152,102,155,241,48,42,164
	.byte 211,201,190,100,26,252,59,15,122,215,107,224,14,75,10,30
	.byte 14,15,186,115,69,215,75,100,26,122,232,52,146,64,94,1
	.byte 8,47,221,240,72,201,8,107,174,118,4,127,169,139,87,8
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
crc64_rocksoft_refl_const:
	.byte 99,38,120,15,140,128,67,160,188,202,105,64,225,211,204,55
	.byte 172,33,38,37,30,118,233,33,32,212,163,43,253,65,220,234
	.byte 220,146,141,30,182,47,133,95,64,156,63,115,30,104,202,161
	.byte 172,33,38,37,30,118,233,33,0,0,0,0,0,0,0,0
	.byte 119,159,239,154,50,250,236,39,106,147,151,88,83,38,217,52
	.byte 188,220,74,61,64,136,101,148,157,49,150,77,89,221,131,208
	.byte 144,110,214,34,78,162,245,52,35,68,65,188,94,95,37,60
	.byte 229,145,231,230,35,56,54,3,254,9,248,208,13,177,10,123
	.byte 90,4,229,172,64,34,36,98,74,168,24,30,179,205,50,12
	.byte 139,42,232,232,31,220,255,163,240,160,164,225,14,172,215,189
	.byte 76,164,215,69,157,187,224,225,0,245,4,146,88,46,188,176
	.byte 172,33,38,37,30,118,233,33,32,212,163,43,253,65,220,234
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hi64_mask:
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
shf_xor_mask:
	.byte 128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
lo32_clr_mask:
	.byte 0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255
hi32_clr_mask:
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0
bswap_shuf_mask:
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
lo64_mask:
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
zero128:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
shf_table_refl:
	.byte 0,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,0
tail_shuf_refl:
	.byte 255,255,255,255,255,255,255,255,0,1,2,3,4,5,6,7
	.byte 8,9,10,144,144,144,144,144,144,144,144,144,144,144,144,144
tail_shuf_norm:
	.byte 5,6,7,8,9,10,11,12,13,14,15,255,255,255,255,255
	.byte 255,255,144,144,144,144,144,144,144,144,144,144,144,144,144,144
shf_table_norm:
	.byte 0,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	.byte 128,128,128,128,128,128,128,128,8,9,10,11,12,13,14,15
	.byte 128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
byte_len_mask_table:
	.byte 0,0,1,0,3,0,7,0,15,0,31,0,63,0,127,0
	.byte 255,0,255,1,255,3,255,7,255,15,255,31,255,63,255,127

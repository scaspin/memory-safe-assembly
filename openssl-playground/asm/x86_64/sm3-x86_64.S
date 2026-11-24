	.text
ossl_hwsm3_block_data_order:
endbr64
pushq	%rbp
orq	%rdx, %rdx
je	.done_hash
vmovdqu	(%rdi), %xmm6
vmovdqu	0x10(%rdi), %xmm7
vpshufd	$0x1b, %xmm6, %xmm0
vpshufd	$0x1b, %xmm7, %xmm1
vpunpckhqdq	%xmm0, %xmm1, %xmm6
vpunpcklqdq	%xmm0, %xmm1, %xmm7
vpsrld	$0x9, %xmm7, %xmm2
vpslld	$0x17, %xmm7, %xmm3
vpxor	%xmm3, %xmm2, %xmm1
vpsrld	$0x13, %xmm7, %xmm4
vpslld	$0xd, %xmm7, %xmm5
vpxor	%xmm5, %xmm4, %xmm0
vpblendd	$0x3, %xmm0, %xmm1, %xmm7
vmovdqa	SHUFF_MASK(%rip), %xmm12
nopw	%cs:(%rax,%rax)
nopl	(%rax)
.block_loop:
vmovdqa	%xmm6, %xmm10
vmovdqa	%xmm7, %xmm11
vmovdqu	(%rsi), %xmm2
vmovdqu	0x10(%rsi), %xmm3
vmovdqu	0x20(%rsi), %xmm4
vmovdqu	0x30(%rsi), %xmm5
vpshufb	%xmm12, %xmm2, %xmm2
vpshufb	%xmm12, %xmm3, %xmm3
vpshufb	%xmm12, %xmm4, %xmm4
vpshufb	%xmm12, %xmm5, %xmm5
vpalignr	$0xc, %xmm3, %xmm4, %xmm8
vpsrldq	$0x4, %xmm5, %xmm9
vsm3msg1	%xmm2, %xmm9, %xmm8
vpalignr	$0xc, %xmm2, %xmm3, %xmm9
vpalignr	$0x8, %xmm4, %xmm5, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x0, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x2, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm2
vpalignr	$0xc, %xmm4, %xmm5, %xmm8
vpsrldq	$0x4, %xmm2, %xmm9
vsm3msg1	%xmm3, %xmm9, %xmm8
vpalignr	$0xc, %xmm3, %xmm4, %xmm9
vpalignr	$0x8, %xmm5, %xmm2, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x4, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x6, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm3
vpalignr	$0xc, %xmm5, %xmm2, %xmm8
vpsrldq	$0x4, %xmm3, %xmm9
vsm3msg1	%xmm4, %xmm9, %xmm8
vpalignr	$0xc, %xmm4, %xmm5, %xmm9
vpalignr	$0x8, %xmm2, %xmm3, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x8, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0xa, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm4
vpalignr	$0xc, %xmm2, %xmm3, %xmm8
vpsrldq	$0x4, %xmm4, %xmm9
vsm3msg1	%xmm5, %xmm9, %xmm8
vpalignr	$0xc, %xmm5, %xmm2, %xmm9
vpalignr	$0x8, %xmm3, %xmm4, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0xc, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0xe, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm5
vpalignr	$0xc, %xmm3, %xmm4, %xmm8
vpsrldq	$0x4, %xmm5, %xmm9
vsm3msg1	%xmm2, %xmm9, %xmm8
vpalignr	$0xc, %xmm2, %xmm3, %xmm9
vpalignr	$0x8, %xmm4, %xmm5, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x10, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x12, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm2
vpalignr	$0xc, %xmm4, %xmm5, %xmm8
vpsrldq	$0x4, %xmm2, %xmm9
vsm3msg1	%xmm3, %xmm9, %xmm8
vpalignr	$0xc, %xmm3, %xmm4, %xmm9
vpalignr	$0x8, %xmm5, %xmm2, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x14, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x16, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm3
vpalignr	$0xc, %xmm5, %xmm2, %xmm8
vpsrldq	$0x4, %xmm3, %xmm9
vsm3msg1	%xmm4, %xmm9, %xmm8
vpalignr	$0xc, %xmm4, %xmm5, %xmm9
vpalignr	$0x8, %xmm2, %xmm3, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x18, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x1a, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm4
vpalignr	$0xc, %xmm2, %xmm3, %xmm8
vpsrldq	$0x4, %xmm4, %xmm9
vsm3msg1	%xmm5, %xmm9, %xmm8
vpalignr	$0xc, %xmm5, %xmm2, %xmm9
vpalignr	$0x8, %xmm3, %xmm4, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0x1c, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0x1e, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm5
vpalignr	$0xc, %xmm3, %xmm4, %xmm8
vpsrldq	$0x4, %xmm5, %xmm9
vsm3msg1	%xmm2, %xmm9, %xmm8
vpalignr	$0xc, %xmm2, %xmm3, %xmm9
vpalignr	$0x8, %xmm4, %xmm5, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x20, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x22, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm2
vpalignr	$0xc, %xmm4, %xmm5, %xmm8
vpsrldq	$0x4, %xmm2, %xmm9
vsm3msg1	%xmm3, %xmm9, %xmm8
vpalignr	$0xc, %xmm3, %xmm4, %xmm9
vpalignr	$0x8, %xmm5, %xmm2, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x24, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x26, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm3
vpalignr	$0xc, %xmm5, %xmm2, %xmm8
vpsrldq	$0x4, %xmm3, %xmm9
vsm3msg1	%xmm4, %xmm9, %xmm8
vpalignr	$0xc, %xmm4, %xmm5, %xmm9
vpalignr	$0x8, %xmm2, %xmm3, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x28, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x2a, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm4
vpalignr	$0xc, %xmm2, %xmm3, %xmm8
vpsrldq	$0x4, %xmm4, %xmm9
vsm3msg1	%xmm5, %xmm9, %xmm8
vpalignr	$0xc, %xmm5, %xmm2, %xmm9
vpalignr	$0x8, %xmm3, %xmm4, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0x2c, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0x2e, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm5
vpalignr	$0xc, %xmm3, %xmm4, %xmm8
vpsrldq	$0x4, %xmm5, %xmm9
vsm3msg1	%xmm2, %xmm9, %xmm8
vpalignr	$0xc, %xmm2, %xmm3, %xmm9
vpalignr	$0x8, %xmm4, %xmm5, %xmm1
vsm3msg2	%xmm1, %xmm9, %xmm8
vpunpcklqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x30, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm3, %xmm2, %xmm1
vsm3rnds2	$0x32, %xmm1, %xmm7, %xmm6
vmovdqa	%xmm8, %xmm2
vpunpcklqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x34, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm4, %xmm3, %xmm1
vsm3rnds2	$0x36, %xmm1, %xmm7, %xmm6
vpunpcklqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x38, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm5, %xmm4, %xmm1
vsm3rnds2	$0x3a, %xmm1, %xmm7, %xmm6
vpunpcklqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0x3c, %xmm1, %xmm6, %xmm7
vpunpckhqdq	%xmm2, %xmm5, %xmm1
vsm3rnds2	$0x3e, %xmm1, %xmm7, %xmm6
vpxor	%xmm6, %xmm10, %xmm6
vpxor	%xmm7, %xmm11, %xmm7
addq	$0x40, %rsi
decq	%rdx
jne	.block_loop
vpslld	$0x9, %xmm7, %xmm2
vpsrld	$0x17, %xmm7, %xmm3
vpxor	%xmm3, %xmm2, %xmm1
vpslld	$0x13, %xmm7, %xmm4
vpsrld	$0xd, %xmm7, %xmm5
vpxor	%xmm5, %xmm4, %xmm0
vpblendd	$0x3, %xmm0, %xmm1, %xmm7
vpshufd	$0x1b, %xmm6, %xmm0
vpshufd	$0x1b, %xmm7, %xmm1
vpunpcklqdq	%xmm1, %xmm0, %xmm6
vpunpckhqdq	%xmm1, %xmm0, %xmm7
vmovdqu	%xmm6, (%rdi)
vmovdqu	%xmm7, 0x10(%rdi)
.done_hash:
popq	%rbp
rep	retq
	.section .data
	.p2align 4
SHUFF_MASK:
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12

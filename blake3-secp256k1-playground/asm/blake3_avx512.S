	.text
_blake3_hash_many_avx512:
blake3_hash_many_avx512:
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
pushq	%rbp
movq	%rsp, %rbp
subq	$0x90, %rsp
andq	$-0x40, %rsp
negq	%r9
kmovw	%r9d, %k1
vmovd	%r8d, %xmm0
vpbroadcastd	%xmm0, %ymm0
shrq	$0x20, %r8
vmovd	%r8d, %xmm1
vpbroadcastd	%xmm1, %ymm1
vmovdqa	%ymm1, %ymm4
vmovdqa	%ymm1, %ymm5
vpaddd	ADD0(%rip), %ymm0, %ymm2
vpaddd	ADD0+32(%rip), %ymm0, %ymm3
vpcmpltud	%ymm0, %ymm2, %k2
vpcmpltud	%ymm0, %ymm3, %k3
vpaddd	ADD1(%rip){1to8}, %ymm4, %ymm4 {%k2}
vpaddd	ADD1(%rip){1to8}, %ymm5, %ymm5 {%k3}
knotw	%k1, %k2
vmovdqa32	%ymm0, %ymm2 {%k2}
vmovdqa32	%ymm0, %ymm3 {%k2}
vmovdqa32	%ymm1, %ymm4 {%k2}
vmovdqa32	%ymm1, %ymm5 {%k2}
vmovdqa	%ymm2, (%rsp)
vmovdqa	%ymm3, 0x20(%rsp)
vmovdqa	%ymm4, 0x40(%rsp)
vmovdqa	%ymm5, 0x60(%rsp)
shlq	$0x6, %rdx
movq	%rdx, 0x80(%rsp)
cmpq	$0x10, %rsi
jb	L_1a00
L_bb:
vpbroadcastd	(%rcx), %zmm0
vpbroadcastd	0x4(%rcx), %zmm1
vpbroadcastd	0x8(%rcx), %zmm2
vpbroadcastd	0xc(%rcx), %zmm3
vpbroadcastd	0x10(%rcx), %zmm4
vpbroadcastd	0x14(%rcx), %zmm5
vpbroadcastd	0x18(%rcx), %zmm6
vpbroadcastd	0x1c(%rcx), %zmm7
movzbl	0x38(%rbp), %eax
movzbl	0x40(%rbp), %ebx
orl	%ebx, %eax
xorl	%edx, %edx
nop
L_100:
movzbl	0x48(%rbp), %ebx
orl	%eax, %ebx
addq	$0x40, %rdx
cmpq	0x80(%rsp), %rdx
cmovel	%ebx, %eax
movl	%eax, 0x88(%rsp)
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movq	0x40(%rdi), %r12
movq	0x48(%rdi), %r13
movq	0x50(%rdi), %r14
movq	0x58(%rdi), %r15
vmovdqu32	-0x40(%rdx,%r8), %ymm16
vinserti64x4	$0x1, -0x40(%rdx,%r12), %zmm16, %zmm16
vmovdqu32	-0x40(%rdx,%r9), %ymm17
vinserti64x4	$0x1, -0x40(%rdx,%r13), %zmm17, %zmm17
vpunpcklqdq	%zmm17, %zmm16, %zmm8
vpunpckhqdq	%zmm17, %zmm16, %zmm9
vmovdqu32	-0x40(%rdx,%r10), %ymm18
vinserti64x4	$0x1, -0x40(%rdx,%r14), %zmm18, %zmm18
vmovdqu32	-0x40(%rdx,%r11), %ymm19
vinserti64x4	$0x1, -0x40(%rdx,%r15), %zmm19, %zmm19
vpunpcklqdq	%zmm19, %zmm18, %zmm10
vpunpckhqdq	%zmm19, %zmm18, %zmm11
movq	0x20(%rdi), %r8
movq	0x28(%rdi), %r9
movq	0x30(%rdi), %r10
movq	0x38(%rdi), %r11
movq	0x60(%rdi), %r12
movq	0x68(%rdi), %r13
movq	0x70(%rdi), %r14
movq	0x78(%rdi), %r15
vmovdqu32	-0x40(%rdx,%r8), %ymm16
vinserti64x4	$0x1, -0x40(%rdx,%r12), %zmm16, %zmm16
vmovdqu32	-0x40(%rdx,%r9), %ymm17
vinserti64x4	$0x1, -0x40(%rdx,%r13), %zmm17, %zmm17
vpunpcklqdq	%zmm17, %zmm16, %zmm12
vpunpckhqdq	%zmm17, %zmm16, %zmm13
vmovdqu32	-0x40(%rdx,%r10), %ymm18
vinserti64x4	$0x1, -0x40(%rdx,%r14), %zmm18, %zmm18
vmovdqu32	-0x40(%rdx,%r11), %ymm19
vinserti64x4	$0x1, -0x40(%rdx,%r15), %zmm19, %zmm19
vpunpcklqdq	%zmm19, %zmm18, %zmm14
vpunpckhqdq	%zmm19, %zmm18, %zmm15
vmovdqa32	INDEX0(%rip), %zmm27
vmovdqa32	INDEX1(%rip), %zmm31
vshufps	$0x88, %zmm10, %zmm8, %zmm16
vshufps	$0x88, %zmm14, %zmm12, %zmm17
vmovdqa32	%zmm16, %zmm20
vpermt2d	%zmm17, %zmm27, %zmm16
vpermt2d	%zmm17, %zmm31, %zmm20
vshufps	$0xdd, %zmm10, %zmm8, %zmm17
vshufps	$0xdd, %zmm14, %zmm12, %zmm30
vmovdqa32	%zmm17, %zmm21
vpermt2d	%zmm30, %zmm27, %zmm17
vpermt2d	%zmm30, %zmm31, %zmm21
vshufps	$0x88, %zmm11, %zmm9, %zmm18
vshufps	$0x88, %zmm15, %zmm13, %zmm8
vmovdqa32	%zmm18, %zmm22
vpermt2d	%zmm8, %zmm27, %zmm18
vpermt2d	%zmm8, %zmm31, %zmm22
vshufps	$0xdd, %zmm11, %zmm9, %zmm19
vshufps	$0xdd, %zmm15, %zmm13, %zmm8
vmovdqa32	%zmm19, %zmm23
vpermt2d	%zmm8, %zmm27, %zmm19
vpermt2d	%zmm8, %zmm31, %zmm23
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movq	0x40(%rdi), %r12
movq	0x48(%rdi), %r13
movq	0x50(%rdi), %r14
movq	0x58(%rdi), %r15
vmovdqu32	-0x20(%r8,%rdx), %ymm24
vinserti64x4	$0x1, -0x20(%r12,%rdx), %zmm24, %zmm24
vmovdqu32	-0x20(%r9,%rdx), %ymm25
vinserti64x4	$0x1, -0x20(%r13,%rdx), %zmm25, %zmm25
vpunpcklqdq	%zmm25, %zmm24, %zmm8
vpunpckhqdq	%zmm25, %zmm24, %zmm9
vmovdqu32	-0x20(%r10,%rdx), %ymm24
vinserti64x4	$0x1, -0x20(%r14,%rdx), %zmm24, %zmm24
vmovdqu32	-0x20(%r11,%rdx), %ymm25
vinserti64x4	$0x1, -0x20(%r15,%rdx), %zmm25, %zmm25
vpunpcklqdq	%zmm25, %zmm24, %zmm10
vpunpckhqdq	%zmm25, %zmm24, %zmm11
prefetcht0	0x80(%r8,%rdx)
prefetcht0	0x80(%r12,%rdx)
prefetcht0	0x80(%r9,%rdx)
prefetcht0	0x80(%r13,%rdx)
prefetcht0	0x80(%r10,%rdx)
prefetcht0	0x80(%r14,%rdx)
prefetcht0	0x80(%r11,%rdx)
prefetcht0	0x80(%r15,%rdx)
movq	0x20(%rdi), %r8
movq	0x28(%rdi), %r9
movq	0x30(%rdi), %r10
movq	0x38(%rdi), %r11
movq	0x60(%rdi), %r12
movq	0x68(%rdi), %r13
movq	0x70(%rdi), %r14
movq	0x78(%rdi), %r15
vmovdqu32	-0x20(%r8,%rdx), %ymm24
vinserti64x4	$0x1, -0x20(%r12,%rdx), %zmm24, %zmm24
vmovdqu32	-0x20(%r9,%rdx), %ymm25
vinserti64x4	$0x1, -0x20(%r13,%rdx), %zmm25, %zmm25
vpunpcklqdq	%zmm25, %zmm24, %zmm12
vpunpckhqdq	%zmm25, %zmm24, %zmm13
vmovdqu32	-0x20(%r10,%rdx), %ymm24
vinserti64x4	$0x1, -0x20(%r14,%rdx), %zmm24, %zmm24
vmovdqu32	-0x20(%r11,%rdx), %ymm25
vinserti64x4	$0x1, -0x20(%r15,%rdx), %zmm25, %zmm25
vpunpcklqdq	%zmm25, %zmm24, %zmm14
vpunpckhqdq	%zmm25, %zmm24, %zmm15
prefetcht0	0x80(%r8,%rdx)
prefetcht0	0x80(%r12,%rdx)
prefetcht0	0x80(%r9,%rdx)
prefetcht0	0x80(%r13,%rdx)
prefetcht0	0x80(%r10,%rdx)
prefetcht0	0x80(%r14,%rdx)
prefetcht0	0x80(%r11,%rdx)
prefetcht0	0x80(%r15,%rdx)
vshufps	$0x88, %zmm10, %zmm8, %zmm24
vshufps	$0x88, %zmm14, %zmm12, %zmm30
vmovdqa32	%zmm24, %zmm28
vpermt2d	%zmm30, %zmm27, %zmm24
vpermt2d	%zmm30, %zmm31, %zmm28
vshufps	$0xdd, %zmm10, %zmm8, %zmm25
vshufps	$0xdd, %zmm14, %zmm12, %zmm30
vmovdqa32	%zmm25, %zmm29
vpermt2d	%zmm30, %zmm27, %zmm25
vpermt2d	%zmm30, %zmm31, %zmm29
vshufps	$0x88, %zmm11, %zmm9, %zmm26
vshufps	$0x88, %zmm15, %zmm13, %zmm8
vmovdqa32	%zmm26, %zmm30
vpermt2d	%zmm8, %zmm27, %zmm26
vpermt2d	%zmm8, %zmm31, %zmm30
vshufps	$0xdd, %zmm11, %zmm9, %zmm8
vshufps	$0xdd, %zmm15, %zmm13, %zmm10
vpermi2d	%zmm10, %zmm8, %zmm27
vpermi2d	%zmm10, %zmm8, %zmm31
vpbroadcastd	BLAKE3_IV_0(%rip), %zmm8
vpbroadcastd	BLAKE3_IV_1(%rip), %zmm9
vpbroadcastd	BLAKE3_IV_2(%rip), %zmm10
vpbroadcastd	BLAKE3_IV_3(%rip), %zmm11
vmovdqa32	(%rsp), %zmm12
vmovdqa32	0x40(%rsp), %zmm13
vpbroadcastd	BLAKE3_BLOCK_LEN(%rip), %zmm14
vpbroadcastd	0x88(%rsp), %zmm15
vpaddd	%zmm16, %zmm0, %zmm0
vpaddd	%zmm18, %zmm1, %zmm1
vpaddd	%zmm20, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm17, %zmm0, %zmm0
vpaddd	%zmm19, %zmm1, %zmm1
vpaddd	%zmm21, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm24, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm28, %zmm2, %zmm2
vpaddd	%zmm30, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm25, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm29, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm18, %zmm0, %zmm0
vpaddd	%zmm19, %zmm1, %zmm1
vpaddd	%zmm23, %zmm2, %zmm2
vpaddd	%zmm20, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm22, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm16, %zmm2, %zmm2
vpaddd	%zmm29, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm17, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm25, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm27, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm30, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm19, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm29, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm20, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm18, %zmm2, %zmm2
vpaddd	%zmm30, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm22, %zmm0, %zmm0
vpaddd	%zmm25, %zmm1, %zmm1
vpaddd	%zmm27, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm21, %zmm0, %zmm0
vpaddd	%zmm16, %zmm1, %zmm1
vpaddd	%zmm31, %zmm2, %zmm2
vpaddd	%zmm17, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm26, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm30, %zmm2, %zmm2
vpaddd	%zmm29, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm23, %zmm0, %zmm0
vpaddd	%zmm25, %zmm1, %zmm1
vpaddd	%zmm19, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm20, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm21, %zmm2, %zmm2
vpaddd	%zmm17, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm16, %zmm0, %zmm0
vpaddd	%zmm18, %zmm1, %zmm1
vpaddd	%zmm24, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm28, %zmm0, %zmm0
vpaddd	%zmm25, %zmm1, %zmm1
vpaddd	%zmm31, %zmm2, %zmm2
vpaddd	%zmm30, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm29, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm26, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm23, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm16, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm18, %zmm0, %zmm0
vpaddd	%zmm19, %zmm1, %zmm1
vpaddd	%zmm17, %zmm2, %zmm2
vpaddd	%zmm20, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm25, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm24, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm30, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm28, %zmm2, %zmm2
vpaddd	%zmm17, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm29, %zmm0, %zmm0
vpaddd	%zmm16, %zmm1, %zmm1
vpaddd	%zmm18, %zmm2, %zmm2
vpaddd	%zmm20, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm19, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm22, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm27, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm17, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm31, %zmm0, %zmm0
vpaddd	%zmm16, %zmm1, %zmm1
vpaddd	%zmm25, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm30, %zmm0, %zmm0
vpaddd	%zmm18, %zmm1, %zmm1
vpaddd	%zmm19, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm26, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm20, %zmm2, %zmm2
vpaddd	%zmm29, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpxord	%zmm8, %zmm0, %zmm0
vpxord	%zmm9, %zmm1, %zmm1
vpxord	%zmm10, %zmm2, %zmm2
vpxord	%zmm11, %zmm3, %zmm3
vpxord	%zmm12, %zmm4, %zmm4
vpxord	%zmm13, %zmm5, %zmm5
vpxord	%zmm14, %zmm6, %zmm6
vpxord	%zmm15, %zmm7, %zmm7
movzbl	0x38(%rbp), %eax
jne	L_100
movq	0x50(%rbp), %rbx
vpunpckldq	%zmm1, %zmm0, %zmm16
vpunpckhdq	%zmm1, %zmm0, %zmm17
vpunpckldq	%zmm3, %zmm2, %zmm18
vpunpckhdq	%zmm3, %zmm2, %zmm19
vpunpckldq	%zmm5, %zmm4, %zmm20
vpunpckhdq	%zmm5, %zmm4, %zmm21
vpunpckldq	%zmm7, %zmm6, %zmm22
vpunpckhdq	%zmm7, %zmm6, %zmm23
vpunpcklqdq	%zmm18, %zmm16, %zmm0
vpunpckhqdq	%zmm18, %zmm16, %zmm1
vpunpcklqdq	%zmm19, %zmm17, %zmm2
vpunpckhqdq	%zmm19, %zmm17, %zmm3
vpunpcklqdq	%zmm22, %zmm20, %zmm4
vpunpckhqdq	%zmm22, %zmm20, %zmm5
vpunpcklqdq	%zmm23, %zmm21, %zmm6
vpunpckhqdq	%zmm23, %zmm21, %zmm7
vshufi32x4	$0x88, %zmm4, %zmm0, %zmm16
vshufi32x4	$0x88, %zmm5, %zmm1, %zmm17
vshufi32x4	$0x88, %zmm6, %zmm2, %zmm18
vshufi32x4	$0x88, %zmm7, %zmm3, %zmm19
vshufi32x4	$0xdd, %zmm4, %zmm0, %zmm20
vshufi32x4	$0xdd, %zmm5, %zmm1, %zmm21
vshufi32x4	$0xdd, %zmm6, %zmm2, %zmm22
vshufi32x4	$0xdd, %zmm7, %zmm3, %zmm23
vshufi32x4	$0x88, %zmm17, %zmm16, %zmm0
vshufi32x4	$0x88, %zmm19, %zmm18, %zmm1
vshufi32x4	$0x88, %zmm21, %zmm20, %zmm2
vshufi32x4	$0x88, %zmm23, %zmm22, %zmm3
vshufi32x4	$0xdd, %zmm17, %zmm16, %zmm4
vshufi32x4	$0xdd, %zmm19, %zmm18, %zmm5
vshufi32x4	$0xdd, %zmm21, %zmm20, %zmm6
vshufi32x4	$0xdd, %zmm23, %zmm22, %zmm7
vmovdqu32	%zmm0, (%rbx)
vmovdqu32	%zmm1, 0x40(%rbx)
vmovdqu32	%zmm2, 0x80(%rbx)
vmovdqu32	%zmm3, 0xc0(%rbx)
vmovdqu32	%zmm4, 0x100(%rbx)
vmovdqu32	%zmm5, 0x140(%rbx)
vmovdqu32	%zmm6, 0x180(%rbx)
vmovdqu32	%zmm7, 0x1c0(%rbx)
vmovdqa32	(%rsp), %zmm0
vmovdqa32	0x40(%rsp), %zmm1
vmovdqa32	%zmm0, %zmm2
vpaddd	ADD16(%rip){1to16}, %zmm0, %zmm2 {%k1}
vpcmpltud	%zmm0, %zmm2, %k2
vpaddd	ADD1(%rip){1to16}, %zmm1, %zmm1 {%k2}
vmovdqa32	%zmm2, (%rsp)
vmovdqa32	%zmm1, 0x40(%rsp)
addq	$0x80, %rdi
addq	$0x200, %rbx
movq	%rbx, 0x50(%rbp)
subq	$0x10, %rsi
cmpq	$0x10, %rsi
jae	L_bb
testq	%rsi, %rsi
jne	L_1a00
L_19da:
vzeroupper
movq	%rbp, %rsp
popq	%rbp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_1a00:
testl	$0x8, %esi
je	L_2f95
vpbroadcastd	(%rcx), %ymm0
vpbroadcastd	0x4(%rcx), %ymm1
vpbroadcastd	0x8(%rcx), %ymm2
vpbroadcastd	0xc(%rcx), %ymm3
vpbroadcastd	0x10(%rcx), %ymm4
vpbroadcastd	0x14(%rcx), %ymm5
vpbroadcastd	0x18(%rcx), %ymm6
vpbroadcastd	0x1c(%rcx), %ymm7
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movq	0x20(%rdi), %r12
movq	0x28(%rdi), %r13
movq	0x30(%rdi), %r14
movq	0x38(%rdi), %r15
movzbl	0x38(%rbp), %eax
movzbl	0x40(%rbp), %ebx
orl	%ebx, %eax
xorl	%edx, %edx
L_1a66:
movzbl	0x48(%rbp), %ebx
orl	%eax, %ebx
addq	$0x40, %rdx
cmpq	0x80(%rsp), %rdx
cmovel	%ebx, %eax
movl	%eax, 0x88(%rsp)
vmovups	-0x40(%r8,%rdx), %xmm8
vinsertf128	$0x1, -0x40(%r12,%rdx), %ymm8, %ymm8
vmovups	-0x40(%r9,%rdx), %xmm9
vinsertf128	$0x1, -0x40(%r13,%rdx), %ymm9, %ymm9
vunpcklpd	%ymm9, %ymm8, %ymm12
vunpckhpd	%ymm9, %ymm8, %ymm13
vmovups	-0x40(%r10,%rdx), %xmm10
vinsertf128	$0x1, -0x40(%r14,%rdx), %ymm10, %ymm10
vmovups	-0x40(%r11,%rdx), %xmm11
vinsertf128	$0x1, -0x40(%r15,%rdx), %ymm11, %ymm11
vunpcklpd	%ymm11, %ymm10, %ymm14
vunpckhpd	%ymm11, %ymm10, %ymm15
vshufps	$0x88, %ymm14, %ymm12, %ymm16
vshufps	$0xdd, %ymm14, %ymm12, %ymm17
vshufps	$0x88, %ymm15, %ymm13, %ymm18
vshufps	$0xdd, %ymm15, %ymm13, %ymm19
vmovups	-0x30(%r8,%rdx), %xmm8
vinsertf128	$0x1, -0x30(%r12,%rdx), %ymm8, %ymm8
vmovups	-0x30(%r9,%rdx), %xmm9
vinsertf128	$0x1, -0x30(%r13,%rdx), %ymm9, %ymm9
vunpcklpd	%ymm9, %ymm8, %ymm12
vunpckhpd	%ymm9, %ymm8, %ymm13
vmovups	-0x30(%r10,%rdx), %xmm10
vinsertf128	$0x1, -0x30(%r14,%rdx), %ymm10, %ymm10
vmovups	-0x30(%r11,%rdx), %xmm11
vinsertf128	$0x1, -0x30(%r15,%rdx), %ymm11, %ymm11
vunpcklpd	%ymm11, %ymm10, %ymm14
vunpckhpd	%ymm11, %ymm10, %ymm15
vshufps	$0x88, %ymm14, %ymm12, %ymm20
vshufps	$0xdd, %ymm14, %ymm12, %ymm21
vshufps	$0x88, %ymm15, %ymm13, %ymm22
vshufps	$0xdd, %ymm15, %ymm13, %ymm23
vmovups	-0x20(%r8,%rdx), %xmm8
vinsertf128	$0x1, -0x20(%r12,%rdx), %ymm8, %ymm8
vmovups	-0x20(%r9,%rdx), %xmm9
vinsertf128	$0x1, -0x20(%r13,%rdx), %ymm9, %ymm9
vunpcklpd	%ymm9, %ymm8, %ymm12
vunpckhpd	%ymm9, %ymm8, %ymm13
vmovups	-0x20(%r10,%rdx), %xmm10
vinsertf128	$0x1, -0x20(%r14,%rdx), %ymm10, %ymm10
vmovups	-0x20(%r11,%rdx), %xmm11
vinsertf128	$0x1, -0x20(%r15,%rdx), %ymm11, %ymm11
vunpcklpd	%ymm11, %ymm10, %ymm14
vunpckhpd	%ymm11, %ymm10, %ymm15
vshufps	$0x88, %ymm14, %ymm12, %ymm24
vshufps	$0xdd, %ymm14, %ymm12, %ymm25
vshufps	$0x88, %ymm15, %ymm13, %ymm26
vshufps	$0xdd, %ymm15, %ymm13, %ymm27
vmovups	-0x10(%r8,%rdx), %xmm8
vinsertf128	$0x1, -0x10(%r12,%rdx), %ymm8, %ymm8
vmovups	-0x10(%r9,%rdx), %xmm9
vinsertf128	$0x1, -0x10(%r13,%rdx), %ymm9, %ymm9
vunpcklpd	%ymm9, %ymm8, %ymm12
vunpckhpd	%ymm9, %ymm8, %ymm13
vmovups	-0x10(%r10,%rdx), %xmm10
vinsertf128	$0x1, -0x10(%r14,%rdx), %ymm10, %ymm10
vmovups	-0x10(%r11,%rdx), %xmm11
vinsertf128	$0x1, -0x10(%r15,%rdx), %ymm11, %ymm11
vunpcklpd	%ymm11, %ymm10, %ymm14
vunpckhpd	%ymm11, %ymm10, %ymm15
vshufps	$0x88, %ymm14, %ymm12, %ymm28
vshufps	$0xdd, %ymm14, %ymm12, %ymm29
vshufps	$0x88, %ymm15, %ymm13, %ymm30
vshufps	$0xdd, %ymm15, %ymm13, %ymm31
vpbroadcastd	BLAKE3_IV_0(%rip), %ymm8
vpbroadcastd	BLAKE3_IV_1(%rip), %ymm9
vpbroadcastd	BLAKE3_IV_2(%rip), %ymm10
vpbroadcastd	BLAKE3_IV_3(%rip), %ymm11
vmovdqa	(%rsp), %ymm12
vmovdqa	0x40(%rsp), %ymm13
vpbroadcastd	BLAKE3_BLOCK_LEN(%rip), %ymm14
vpbroadcastd	0x88(%rsp), %ymm15
vpaddd	%ymm16, %ymm0, %ymm0
vpaddd	%ymm18, %ymm1, %ymm1
vpaddd	%ymm20, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm17, %ymm0, %ymm0
vpaddd	%ymm19, %ymm1, %ymm1
vpaddd	%ymm21, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm24, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm28, %ymm2, %ymm2
vpaddd	%ymm30, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm25, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm29, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm18, %ymm0, %ymm0
vpaddd	%ymm19, %ymm1, %ymm1
vpaddd	%ymm23, %ymm2, %ymm2
vpaddd	%ymm20, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm22, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm16, %ymm2, %ymm2
vpaddd	%ymm29, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm17, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm25, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm27, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm30, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm19, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm29, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm20, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm18, %ymm2, %ymm2
vpaddd	%ymm30, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm22, %ymm0, %ymm0
vpaddd	%ymm25, %ymm1, %ymm1
vpaddd	%ymm27, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm21, %ymm0, %ymm0
vpaddd	%ymm16, %ymm1, %ymm1
vpaddd	%ymm31, %ymm2, %ymm2
vpaddd	%ymm17, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm26, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm30, %ymm2, %ymm2
vpaddd	%ymm29, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm23, %ymm0, %ymm0
vpaddd	%ymm25, %ymm1, %ymm1
vpaddd	%ymm19, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm20, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm21, %ymm2, %ymm2
vpaddd	%ymm17, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm16, %ymm0, %ymm0
vpaddd	%ymm18, %ymm1, %ymm1
vpaddd	%ymm24, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm28, %ymm0, %ymm0
vpaddd	%ymm25, %ymm1, %ymm1
vpaddd	%ymm31, %ymm2, %ymm2
vpaddd	%ymm30, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm29, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm26, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm23, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm16, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm18, %ymm0, %ymm0
vpaddd	%ymm19, %ymm1, %ymm1
vpaddd	%ymm17, %ymm2, %ymm2
vpaddd	%ymm20, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm25, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm24, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm30, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm28, %ymm2, %ymm2
vpaddd	%ymm17, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm29, %ymm0, %ymm0
vpaddd	%ymm16, %ymm1, %ymm1
vpaddd	%ymm18, %ymm2, %ymm2
vpaddd	%ymm20, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm19, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm22, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm27, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm17, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm31, %ymm0, %ymm0
vpaddd	%ymm16, %ymm1, %ymm1
vpaddd	%ymm25, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm30, %ymm0, %ymm0
vpaddd	%ymm18, %ymm1, %ymm1
vpaddd	%ymm19, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm26, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm20, %ymm2, %ymm2
vpaddd	%ymm29, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpxor	%ymm0, %ymm8, %ymm0
vpxor	%ymm1, %ymm9, %ymm1
vpxor	%ymm2, %ymm10, %ymm2
vpxor	%ymm3, %ymm11, %ymm3
vpxor	%ymm4, %ymm12, %ymm4
vpxor	%ymm5, %ymm13, %ymm5
vpxor	%ymm6, %ymm14, %ymm6
vpxor	%ymm7, %ymm15, %ymm7
movzbl	0x38(%rbp), %eax
jne	L_1a66
movq	0x50(%rbp), %rbx
vunpcklps	%ymm1, %ymm0, %ymm8
vunpcklps	%ymm3, %ymm2, %ymm9
vunpckhps	%ymm1, %ymm0, %ymm10
vunpcklps	%ymm5, %ymm4, %ymm11
vunpcklps	%ymm7, %ymm6, %ymm0
vshufps	$0x4e, %ymm9, %ymm8, %ymm12
vblendps	$0xcc, %ymm12, %ymm8, %ymm1
vshufps	$0x4e, %ymm0, %ymm11, %ymm8
vunpckhps	%ymm3, %ymm2, %ymm13
vblendps	$0xcc, %ymm8, %ymm11, %ymm2
vblendps	$0xcc, %ymm9, %ymm12, %ymm3
vperm2f128	$0x20, %ymm2, %ymm1, %ymm12
vmovups	%ymm12, (%rbx)
vunpckhps	%ymm5, %ymm4, %ymm14
vblendps	$0xcc, %ymm0, %ymm8, %ymm4
vunpckhps	%ymm7, %ymm6, %ymm15
vperm2f128	$0x20, %ymm4, %ymm3, %ymm7
vmovups	%ymm7, 0x20(%rbx)
vshufps	$0x4e, %ymm13, %ymm10, %ymm5
vblendps	$0xcc, %ymm13, %ymm5, %ymm6
vshufps	$0x4e, %ymm15, %ymm14, %ymm13
vblendps	$0xcc, %ymm5, %ymm10, %ymm10
vblendps	$0xcc, %ymm13, %ymm14, %ymm14
vperm2f128	$0x20, %ymm14, %ymm10, %ymm8
vmovups	%ymm8, 0x40(%rbx)
vblendps	$0xcc, %ymm15, %ymm13, %ymm15
vperm2f128	$0x20, %ymm15, %ymm6, %ymm13
vmovups	%ymm13, 0x60(%rbx)
vperm2f128	$0x31, %ymm2, %ymm1, %ymm9
vperm2f128	$0x31, %ymm4, %ymm3, %ymm11
vmovups	%ymm9, 0x80(%rbx)
vperm2f128	$0x31, %ymm14, %ymm10, %ymm14
vperm2f128	$0x31, %ymm15, %ymm6, %ymm15
vmovups	%ymm11, 0xa0(%rbx)
vmovups	%ymm14, 0xc0(%rbx)
vmovups	%ymm15, 0xe0(%rbx)
vmovdqa	(%rsp), %ymm0
vmovdqa	0x40(%rsp), %ymm2
vmovdqa32	0x20(%rsp), %ymm0 {%k1}
vmovdqa32	0x60(%rsp), %ymm2 {%k1}
vmovdqa	%ymm0, (%rsp)
vmovdqa	%ymm2, 0x40(%rsp)
addq	$0x100, %rbx
movq	%rbx, 0x50(%rbp)
addq	$0x40, %rdi
subq	$0x8, %rsi
L_2f95:
movq	0x50(%rbp), %rbx
movq	0x80(%rsp), %r15
movzbq	0x38(%rbp), %r13
movzbq	0x48(%rbp), %r12
testl	$0x4, %esi
je	L_32e8
vbroadcasti32x4	(%rcx), %zmm0
vbroadcasti32x4	0x10(%rcx), %zmm1
vmovdqa	(%rsp), %xmm12
vmovdqa	0x40(%rsp), %xmm13
vpunpckldq	%xmm13, %xmm12, %xmm14
vpunpckhdq	%xmm13, %xmm12, %xmm15
vpermq	$0xdc, %ymm14, %ymm14
vpermq	$0xdc, %ymm15, %ymm15
vpbroadcastd	BLAKE3_BLOCK_LEN(%rip), %zmm12
vinserti64x4	$0x1, %ymm15, %zmm14, %zmm13
movl	$0x4444, %eax
kmovw	%eax, %k2
vpblendmd	%zmm12, %zmm13, %zmm13 {%k2}
vbroadcasti32x4	BLAKE3_IV_0(%rip), %zmm15
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movl	$0xaaaa, %eax
kmovw	%eax, %k3
movl	$0x8888, %eax
kmovw	%eax, %k4
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
nopl	(%rax)
L_3040:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movl	%eax, 0x88(%rsp)
vmovdqa32	%zmm15, %zmm2
vpbroadcastd	0x88(%rsp), %zmm8
vpblendmd	%zmm8, %zmm13, %zmm3 {%k4}
vmovups	-0x40(%r8,%rdx), %zmm8
vinserti32x4	$0x1, -0x40(%r9,%rdx), %zmm8, %zmm8
vinserti32x4	$0x2, -0x40(%r10,%rdx), %zmm8, %zmm8
vinserti32x4	$0x3, -0x40(%r11,%rdx), %zmm8, %zmm8
vmovups	-0x30(%r8,%rdx), %zmm9
vinserti32x4	$0x1, -0x30(%r9,%rdx), %zmm9, %zmm9
vinserti32x4	$0x2, -0x30(%r10,%rdx), %zmm9, %zmm9
vinserti32x4	$0x3, -0x30(%r11,%rdx), %zmm9, %zmm9
vshufps	$0x88, %zmm9, %zmm8, %zmm4
vshufps	$0xdd, %zmm9, %zmm8, %zmm5
vmovups	-0x20(%r8,%rdx), %zmm8
vinserti32x4	$0x1, -0x20(%r9,%rdx), %zmm8, %zmm8
vinserti32x4	$0x2, -0x20(%r10,%rdx), %zmm8, %zmm8
vinserti32x4	$0x3, -0x20(%r11,%rdx), %zmm8, %zmm8
vmovups	-0x10(%r8,%rdx), %zmm9
vinserti32x4	$0x1, -0x10(%r9,%rdx), %zmm9, %zmm9
vinserti32x4	$0x2, -0x10(%r10,%rdx), %zmm9, %zmm9
vinserti32x4	$0x3, -0x10(%r11,%rdx), %zmm9, %zmm9
vshufps	$0x88, %zmm9, %zmm8, %zmm6
vshufps	$0xdd, %zmm9, %zmm8, %zmm7
vpshufd	$0x93, %zmm6, %zmm6
vpshufd	$0x93, %zmm7, %zmm7
movb	$0x7, %al
L_312d:
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x10, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0xc, %zmm1, %zmm1
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x8, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0x7, %zmm1, %zmm1
vpshufd	$0x93, %zmm0, %zmm0
vpshufd	$0x4e, %zmm3, %zmm3
vpshufd	$0x39, %zmm2, %zmm2
vpaddd	%zmm6, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x10, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0xc, %zmm1, %zmm1
vpaddd	%zmm7, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x8, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0x7, %zmm1, %zmm1
vpshufd	$0x39, %zmm0, %zmm0
vpshufd	$0x4e, %zmm3, %zmm3
vpshufd	$0x93, %zmm2, %zmm2
decb	%al
je	L_3264
vshufps	$0xd6, %zmm5, %zmm4, %zmm8
vpshufd	$0xf, %zmm4, %zmm9
vpshufd	$0x39, %zmm8, %zmm4
vshufps	$0xfa, %zmm7, %zmm6, %zmm8
vpblendmd	%zmm8, %zmm9, %zmm9 {%k3}
vpunpcklqdq	%zmm5, %zmm7, %zmm8
vpblendmd	%zmm6, %zmm8, %zmm8 {%k4}
vpshufd	$0x78, %zmm8, %zmm8
vpunpckhdq	%zmm7, %zmm5, %zmm5
vpunpckldq	%zmm5, %zmm6, %zmm6
vpshufd	$0x1e, %zmm6, %zmm7
vmovdqa32	%zmm9, %zmm5
vmovdqa32	%zmm8, %zmm6
jmp	L_312d
L_3264:
vpxord	%zmm2, %zmm0, %zmm0
vpxord	%zmm3, %zmm1, %zmm1
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_3040
vmovdqu	%xmm0, (%rbx)
vmovdqu	%xmm1, 0x10(%rbx)
vextracti128	$0x1, %ymm0, 0x20(%rbx)
vextracti128	$0x1, %ymm1, 0x30(%rbx)
vextracti32x4	$0x2, %zmm0, 0x40(%rbx)
vextracti32x4	$0x2, %zmm1, 0x50(%rbx)
vextracti32x4	$0x3, %zmm0, 0x60(%rbx)
vextracti32x4	$0x3, %zmm1, 0x70(%rbx)
vmovdqa	(%rsp), %xmm0
vmovdqa	0x40(%rsp), %xmm2
vmovdqa32	0x10(%rsp), %xmm0 {%k1}
vmovdqa32	0x50(%rsp), %xmm2 {%k1}
vmovdqa	%xmm0, (%rsp)
vmovdqa	%xmm2, 0x40(%rsp)
addq	$0x80, %rbx
addq	$0x20, %rdi
subq	$0x4, %rsi
L_32e8:
testl	$0x2, %esi
je	L_3553
vbroadcasti128	(%rcx), %ymm0
vbroadcasti128	0x10(%rcx), %ymm1
vmovd	(%rsp), %xmm13
vpinsrd	$0x1, 0x40(%rsp), %xmm13, %xmm13
vpinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm13, %xmm13
vmovd	0x4(%rsp), %xmm14
vpinsrd	$0x1, 0x44(%rsp), %xmm14, %xmm14
vpinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm14, %xmm14
vinserti128	$0x1, %xmm14, %ymm13, %ymm13
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_3360:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movl	%eax, 0x88(%rsp)
vbroadcasti128	BLAKE3_IV_0(%rip), %ymm2
vpbroadcastd	0x88(%rsp), %ymm8
vpblendd	$0x88, %ymm8, %ymm13, %ymm3
vmovups	-0x40(%r8,%rdx), %ymm8
vinsertf128	$0x1, -0x40(%r9,%rdx), %ymm8, %ymm8
vmovups	-0x30(%r8,%rdx), %ymm9
vinsertf128	$0x1, -0x30(%r9,%rdx), %ymm9, %ymm9
vshufps	$0x88, %ymm9, %ymm8, %ymm4
vshufps	$0xdd, %ymm9, %ymm8, %ymm5
vmovups	-0x20(%r8,%rdx), %ymm8
vinsertf128	$0x1, -0x20(%r9,%rdx), %ymm8, %ymm8
vmovups	-0x10(%r8,%rdx), %ymm9
vinsertf128	$0x1, -0x10(%r9,%rdx), %ymm9, %ymm9
vshufps	$0x88, %ymm9, %ymm8, %ymm6
vshufps	$0xdd, %ymm9, %ymm8, %ymm7
vpshufd	$0x93, %ymm6, %ymm6
vpshufd	$0x93, %ymm7, %ymm7
movb	$0x7, %al
L_33f1:
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x10, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0xc, %ymm1, %ymm1
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x8, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0x7, %ymm1, %ymm1
vpshufd	$0x93, %ymm0, %ymm0
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x39, %ymm2, %ymm2
vpaddd	%ymm6, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x10, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0xc, %ymm1, %ymm1
vpaddd	%ymm7, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x8, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0x7, %ymm1, %ymm1
vpshufd	$0x39, %ymm0, %ymm0
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x93, %ymm2, %ymm2
decb	%al
je	L_34f0
vshufps	$0xd6, %ymm5, %ymm4, %ymm8
vpshufd	$0xf, %ymm4, %ymm9
vpshufd	$0x39, %ymm8, %ymm4
vshufps	$0xfa, %ymm7, %ymm6, %ymm8
vpblendd	$0xaa, %ymm8, %ymm9, %ymm9
vpunpcklqdq	%ymm5, %ymm7, %ymm8
vpblendd	$0x88, %ymm6, %ymm8, %ymm8
vpshufd	$0x78, %ymm8, %ymm8
vpunpckhdq	%ymm7, %ymm5, %ymm5
vpunpckldq	%ymm5, %ymm6, %ymm6
vpshufd	$0x1e, %ymm6, %ymm7
vmovdqa	%ymm9, %ymm5
vmovdqa	%ymm8, %ymm6
jmp	L_33f1
L_34f0:
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm3, %ymm1, %ymm1
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_3360
vmovdqu	%xmm0, (%rbx)
vmovdqu	%xmm1, 0x10(%rbx)
vextracti128	$0x1, %ymm0, 0x20(%rbx)
vextracti128	$0x1, %ymm1, 0x30(%rbx)
vmovdqa	(%rsp), %xmm0
vmovdqa	0x40(%rsp), %xmm2
vmovdqu32	0x8(%rsp), %xmm0 {%k1}
vmovdqu32	0x48(%rsp), %xmm2 {%k1}
vmovdqa	%xmm0, (%rsp)
vmovdqa	%xmm2, 0x40(%rsp)
addq	$0x40, %rbx
addq	$0x10, %rdi
subq	$0x2, %rsi
L_3553:
testl	$0x1, %esi
je	L_19da
vmovdqu	(%rcx), %xmm0
vmovdqu	0x10(%rcx), %xmm1
vmovd	(%rsp), %xmm14
vpinsrd	$0x1, 0x40(%rsp), %xmm14, %xmm14
vpinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm14, %xmm14
vmovdqa	BLAKE3_IV_0(%rip), %xmm15
movq	(%rdi), %r8
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_35a0:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
vpinsrd	$0x3, %eax, %xmm14, %xmm3
vmovdqa	%xmm15, %xmm2
vmovups	-0x40(%r8,%rdx), %xmm8
vmovups	-0x30(%r8,%rdx), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm4
vshufps	$0xdd, %xmm9, %xmm8, %xmm5
vmovups	-0x20(%r8,%rdx), %xmm8
vmovups	-0x10(%r8,%rdx), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm6
vshufps	$0xdd, %xmm9, %xmm8, %xmm7
vpshufd	$0x93, %xmm6, %xmm6
vpshufd	$0x93, %xmm7, %xmm7
movb	$0x7, %al
L_35fb:
vpaddd	%xmm4, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm5, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x93, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x39, %xmm2, %xmm2
vpaddd	%xmm6, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm7, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x39, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_36fa
vshufps	$0xd6, %xmm5, %xmm4, %xmm8
vpshufd	$0xf, %xmm4, %xmm9
vpshufd	$0x39, %xmm8, %xmm4
vshufps	$0xfa, %xmm7, %xmm6, %xmm8
vpblendd	$0xaa, %xmm8, %xmm9, %xmm9
vpunpcklqdq	%xmm5, %xmm7, %xmm8
vpblendd	$0x88, %xmm6, %xmm8, %xmm8
vpshufd	$0x78, %xmm8, %xmm8
vpunpckhdq	%xmm7, %xmm5, %xmm5
vpunpckldq	%xmm5, %xmm6, %xmm6
vpshufd	$0x1e, %xmm6, %xmm7
vmovdqa	%xmm9, %xmm5
vmovdqa	%xmm8, %xmm6
jmp	L_35fb
L_36fa:
vpxor	%xmm2, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_35a0
vmovdqu	%xmm0, (%rbx)
vmovdqu	%xmm1, 0x10(%rbx)
jmp	L_19da
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
blake3_compress_in_place_avx512:
_blake3_compress_in_place_avx512:
vmovdqu	(%rdi), %xmm0
vmovdqu	0x10(%rdi), %xmm1
movzbl	%r8b, %eax
movzbl	%dl, %edx
shlq	$0x20, %rax
addq	%rax, %rdx
vmovq	%rcx, %xmm3
vmovq	%rdx, %xmm4
vpunpcklqdq	%xmm4, %xmm3, %xmm3
vmovaps	BLAKE3_IV_0(%rip), %xmm2
vmovups	(%rsi), %xmm8
vmovups	0x10(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm4
vshufps	$0xdd, %xmm9, %xmm8, %xmm5
vmovups	0x20(%rsi), %xmm8
vmovups	0x30(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm6
vshufps	$0xdd, %xmm9, %xmm8, %xmm7
vpshufd	$0x93, %xmm6, %xmm6
vpshufd	$0x93, %xmm7, %xmm7
movb	$0x7, %al
L_37a4:
vpaddd	%xmm4, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm5, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x93, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x39, %xmm2, %xmm2
vpaddd	%xmm6, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm7, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x39, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_38a3
vshufps	$0xd6, %xmm5, %xmm4, %xmm8
vpshufd	$0xf, %xmm4, %xmm9
vpshufd	$0x39, %xmm8, %xmm4
vshufps	$0xfa, %xmm7, %xmm6, %xmm8
vpblendd	$0xaa, %xmm8, %xmm9, %xmm9
vpunpcklqdq	%xmm5, %xmm7, %xmm8
vpblendd	$0x88, %xmm6, %xmm8, %xmm8
vpshufd	$0x78, %xmm8, %xmm8
vpunpckhdq	%xmm7, %xmm5, %xmm5
vpunpckldq	%xmm5, %xmm6, %xmm6
vpshufd	$0x1e, %xmm6, %xmm7
vmovdqa	%xmm9, %xmm5
vmovdqa	%xmm8, %xmm6
jmp	L_37a4
L_38a3:
vpxor	%xmm2, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vmovdqu	%xmm0, (%rdi)
vmovdqu	%xmm1, 0x10(%rdi)
retq
nopw	%cs:(%rax,%rax)
nop
blake3_compress_xof_avx512:
_blake3_compress_xof_avx512:
vmovdqu	(%rdi), %xmm0
vmovdqu	0x10(%rdi), %xmm1
movzbl	%r8b, %eax
movzbl	%dl, %edx
shlq	$0x20, %rax
addq	%rax, %rdx
vmovq	%rcx, %xmm3
vmovq	%rdx, %xmm4
vpunpcklqdq	%xmm4, %xmm3, %xmm3
vmovaps	BLAKE3_IV_0(%rip), %xmm2
vmovups	(%rsi), %xmm8
vmovups	0x10(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm4
vshufps	$0xdd, %xmm9, %xmm8, %xmm5
vmovups	0x20(%rsi), %xmm8
vmovups	0x30(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm6
vshufps	$0xdd, %xmm9, %xmm8, %xmm7
vpshufd	$0x93, %xmm6, %xmm6
vpshufd	$0x93, %xmm7, %xmm7
movb	$0x7, %al
L_3924:
vpaddd	%xmm4, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm5, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x93, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x39, %xmm2, %xmm2
vpaddd	%xmm6, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm7, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x39, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_3a23
vshufps	$0xd6, %xmm5, %xmm4, %xmm8
vpshufd	$0xf, %xmm4, %xmm9
vpshufd	$0x39, %xmm8, %xmm4
vshufps	$0xfa, %xmm7, %xmm6, %xmm8
vpblendd	$0xaa, %xmm8, %xmm9, %xmm9
vpunpcklqdq	%xmm5, %xmm7, %xmm8
vpblendd	$0x88, %xmm6, %xmm8, %xmm8
vpshufd	$0x78, %xmm8, %xmm8
vpunpckhdq	%xmm7, %xmm5, %xmm5
vpunpckldq	%xmm5, %xmm6, %xmm6
vpshufd	$0x1e, %xmm6, %xmm7
vmovdqa	%xmm9, %xmm5
vmovdqa	%xmm8, %xmm6
jmp	L_3924
L_3a23:
vpxor	%xmm2, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vpxor	(%rdi), %xmm2, %xmm2
vpxor	0x10(%rdi), %xmm3, %xmm3
vmovdqu	%xmm0, (%r9)
vmovdqu	%xmm1, 0x10(%r9)
vmovdqu	%xmm2, 0x20(%r9)
vmovdqu	%xmm3, 0x30(%r9)
retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
blake3_xof_many_avx512:
_blake3_xof_many_avx512:
movq	0x8(%rsp), %r10
cmpq	$0x1, %r10
ja	L_3c40
vmovdqu	(%rdi), %xmm0
vmovdqu	0x10(%rdi), %xmm1
movzbl	%r8b, %eax
movzbl	%dl, %edx
shlq	$0x20, %rax
addq	%rax, %rdx
vmovq	%rcx, %xmm3
vmovq	%rdx, %xmm4
vpunpcklqdq	%xmm4, %xmm3, %xmm3
vmovaps	BLAKE3_IV_0(%rip), %xmm2
vmovups	(%rsi), %xmm8
vmovups	0x10(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm4
vshufps	$0xdd, %xmm9, %xmm8, %xmm5
vmovups	0x20(%rsi), %xmm8
vmovups	0x30(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm6
vshufps	$0xdd, %xmm9, %xmm8, %xmm7
vpshufd	$0x93, %xmm6, %xmm6
vpshufd	$0x93, %xmm7, %xmm7
movb	$0x7, %al
L_3af3:
vpaddd	%xmm4, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm5, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x93, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x39, %xmm2, %xmm2
vpaddd	%xmm6, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm7, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x39, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_3bf2
vshufps	$0xd6, %xmm5, %xmm4, %xmm8
vpshufd	$0xf, %xmm4, %xmm9
vpshufd	$0x39, %xmm8, %xmm4
vshufps	$0xfa, %xmm7, %xmm6, %xmm8
vpblendd	$0xaa, %xmm8, %xmm9, %xmm9
vpunpcklqdq	%xmm5, %xmm7, %xmm8
vpblendd	$0x88, %xmm6, %xmm8, %xmm8
vpshufd	$0x78, %xmm8, %xmm8
vpunpckhdq	%xmm7, %xmm5, %xmm5
vpunpckldq	%xmm5, %xmm6, %xmm6
vpshufd	$0x1e, %xmm6, %xmm7
vmovdqa	%xmm9, %xmm5
vmovdqa	%xmm8, %xmm6
jmp	L_3af3
L_3bf2:
vpxor	%xmm2, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vpxor	(%rdi), %xmm2, %xmm2
vpxor	0x10(%rdi), %xmm3, %xmm3
vmovdqu	%xmm0, (%r9)
vmovdqu	%xmm1, 0x10(%r9)
vmovdqu	%xmm2, 0x20(%r9)
vmovdqu	%xmm3, 0x30(%r9)
retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_3c40:
pushq	%rbp
movq	%rsp, %rbp
subq	$0x90, %rsp
andq	$-0x40, %rsp
vpbroadcastd	%ecx, %zmm0
shrq	$0x20, %rcx
vpbroadcastd	%ecx, %zmm1
vpaddd	ADD0(%rip), %zmm0, %zmm2
vpcmpltud	%zmm0, %zmm2, %k1
vpaddd	ADD1(%rip){1to16}, %zmm1, %zmm1 {%k1}
vmovdqa32	%zmm2, (%rsp)
vmovdqa32	%zmm1, 0x40(%rsp)
cmpq	$0x10, %r10
jb	L_538d
L_3c93:
vpbroadcastd	(%rsi), %zmm16
vpbroadcastd	0x4(%rsi), %zmm17
vpbroadcastd	0x8(%rsi), %zmm18
vpbroadcastd	0xc(%rsi), %zmm19
vpbroadcastd	0x10(%rsi), %zmm20
vpbroadcastd	0x14(%rsi), %zmm21
vpbroadcastd	0x18(%rsi), %zmm22
vpbroadcastd	0x1c(%rsi), %zmm23
vpbroadcastd	0x20(%rsi), %zmm24
vpbroadcastd	0x24(%rsi), %zmm25
vpbroadcastd	0x28(%rsi), %zmm26
vpbroadcastd	0x2c(%rsi), %zmm27
vpbroadcastd	0x30(%rsi), %zmm28
vpbroadcastd	0x34(%rsi), %zmm29
vpbroadcastd	0x38(%rsi), %zmm30
vpbroadcastd	0x3c(%rsi), %zmm31
vpbroadcastd	(%rdi), %zmm0
vpbroadcastd	0x4(%rdi), %zmm1
vpbroadcastd	0x8(%rdi), %zmm2
vpbroadcastd	0xc(%rdi), %zmm3
vpbroadcastd	0x10(%rdi), %zmm4
vpbroadcastd	0x14(%rdi), %zmm5
vpbroadcastd	0x18(%rdi), %zmm6
vpbroadcastd	0x1c(%rdi), %zmm7
vpbroadcastd	BLAKE3_IV_0(%rip), %zmm8
vpbroadcastd	BLAKE3_IV_1(%rip), %zmm9
vpbroadcastd	BLAKE3_IV_2(%rip), %zmm10
vpbroadcastd	BLAKE3_IV_3(%rip), %zmm11
vmovdqa32	(%rsp), %zmm12
vmovdqa32	0x40(%rsp), %zmm13
vpbroadcastd	%edx, %zmm14
vpbroadcastd	%r8d, %zmm15
vpaddd	%zmm16, %zmm0, %zmm0
vpaddd	%zmm18, %zmm1, %zmm1
vpaddd	%zmm20, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm17, %zmm0, %zmm0
vpaddd	%zmm19, %zmm1, %zmm1
vpaddd	%zmm21, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm24, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm28, %zmm2, %zmm2
vpaddd	%zmm30, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm25, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm29, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm18, %zmm0, %zmm0
vpaddd	%zmm19, %zmm1, %zmm1
vpaddd	%zmm23, %zmm2, %zmm2
vpaddd	%zmm20, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm22, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm16, %zmm2, %zmm2
vpaddd	%zmm29, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm17, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm25, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm27, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm30, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm19, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm29, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm20, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm18, %zmm2, %zmm2
vpaddd	%zmm30, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm22, %zmm0, %zmm0
vpaddd	%zmm25, %zmm1, %zmm1
vpaddd	%zmm27, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm21, %zmm0, %zmm0
vpaddd	%zmm16, %zmm1, %zmm1
vpaddd	%zmm31, %zmm2, %zmm2
vpaddd	%zmm17, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm26, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm30, %zmm2, %zmm2
vpaddd	%zmm29, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm23, %zmm0, %zmm0
vpaddd	%zmm25, %zmm1, %zmm1
vpaddd	%zmm19, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm20, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm21, %zmm2, %zmm2
vpaddd	%zmm17, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm16, %zmm0, %zmm0
vpaddd	%zmm18, %zmm1, %zmm1
vpaddd	%zmm24, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm28, %zmm0, %zmm0
vpaddd	%zmm25, %zmm1, %zmm1
vpaddd	%zmm31, %zmm2, %zmm2
vpaddd	%zmm30, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm29, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm26, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm23, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm16, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm18, %zmm0, %zmm0
vpaddd	%zmm19, %zmm1, %zmm1
vpaddd	%zmm17, %zmm2, %zmm2
vpaddd	%zmm20, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm25, %zmm0, %zmm0
vpaddd	%zmm27, %zmm1, %zmm1
vpaddd	%zmm24, %zmm2, %zmm2
vpaddd	%zmm31, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm30, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm28, %zmm2, %zmm2
vpaddd	%zmm17, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm29, %zmm0, %zmm0
vpaddd	%zmm16, %zmm1, %zmm1
vpaddd	%zmm18, %zmm2, %zmm2
vpaddd	%zmm20, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm19, %zmm0, %zmm0
vpaddd	%zmm26, %zmm1, %zmm1
vpaddd	%zmm22, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpaddd	%zmm27, %zmm0, %zmm0
vpaddd	%zmm21, %zmm1, %zmm1
vpaddd	%zmm17, %zmm2, %zmm2
vpaddd	%zmm24, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vpaddd	%zmm31, %zmm0, %zmm0
vpaddd	%zmm16, %zmm1, %zmm1
vpaddd	%zmm25, %zmm2, %zmm2
vpaddd	%zmm22, %zmm3, %zmm3
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm5, %zmm1, %zmm1
vpaddd	%zmm6, %zmm2, %zmm2
vpaddd	%zmm7, %zmm3, %zmm3
vpxord	%zmm0, %zmm12, %zmm12
vpxord	%zmm1, %zmm13, %zmm13
vpxord	%zmm2, %zmm14, %zmm14
vpxord	%zmm3, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vpaddd	%zmm12, %zmm8, %zmm8
vpaddd	%zmm13, %zmm9, %zmm9
vpaddd	%zmm14, %zmm10, %zmm10
vpaddd	%zmm15, %zmm11, %zmm11
vpxord	%zmm8, %zmm4, %zmm4
vpxord	%zmm9, %zmm5, %zmm5
vpxord	%zmm10, %zmm6, %zmm6
vpxord	%zmm11, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vpaddd	%zmm30, %zmm0, %zmm0
vpaddd	%zmm18, %zmm1, %zmm1
vpaddd	%zmm19, %zmm2, %zmm2
vpaddd	%zmm23, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x10, %zmm15, %zmm15
vprord	$0x10, %zmm12, %zmm12
vprord	$0x10, %zmm13, %zmm13
vprord	$0x10, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0xc, %zmm5, %zmm5
vprord	$0xc, %zmm6, %zmm6
vprord	$0xc, %zmm7, %zmm7
vprord	$0xc, %zmm4, %zmm4
vpaddd	%zmm26, %zmm0, %zmm0
vpaddd	%zmm28, %zmm1, %zmm1
vpaddd	%zmm20, %zmm2, %zmm2
vpaddd	%zmm29, %zmm3, %zmm3
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm6, %zmm1, %zmm1
vpaddd	%zmm7, %zmm2, %zmm2
vpaddd	%zmm4, %zmm3, %zmm3
vpxord	%zmm0, %zmm15, %zmm15
vpxord	%zmm1, %zmm12, %zmm12
vpxord	%zmm2, %zmm13, %zmm13
vpxord	%zmm3, %zmm14, %zmm14
vprord	$0x8, %zmm15, %zmm15
vprord	$0x8, %zmm12, %zmm12
vprord	$0x8, %zmm13, %zmm13
vprord	$0x8, %zmm14, %zmm14
vpaddd	%zmm15, %zmm10, %zmm10
vpaddd	%zmm12, %zmm11, %zmm11
vpaddd	%zmm13, %zmm8, %zmm8
vpaddd	%zmm14, %zmm9, %zmm9
vpxord	%zmm10, %zmm5, %zmm5
vpxord	%zmm11, %zmm6, %zmm6
vpxord	%zmm8, %zmm7, %zmm7
vpxord	%zmm9, %zmm4, %zmm4
vprord	$0x7, %zmm5, %zmm5
vprord	$0x7, %zmm6, %zmm6
vprord	$0x7, %zmm7, %zmm7
vprord	$0x7, %zmm4, %zmm4
vpxord	%zmm8, %zmm0, %zmm0
vpxord	%zmm9, %zmm1, %zmm1
vpxord	%zmm10, %zmm2, %zmm2
vpxord	%zmm11, %zmm3, %zmm3
vpxord	%zmm12, %zmm4, %zmm4
vpxord	%zmm13, %zmm5, %zmm5
vpxord	%zmm14, %zmm6, %zmm6
vpxord	%zmm15, %zmm7, %zmm7
vpxord	(%rdi){1to16}, %zmm8, %zmm8
vpxord	0x4(%rdi){1to16}, %zmm9, %zmm9
vpxord	0x8(%rdi){1to16}, %zmm10, %zmm10
vpxord	0xc(%rdi){1to16}, %zmm11, %zmm11
vpxord	0x10(%rdi){1to16}, %zmm12, %zmm12
vpxord	0x14(%rdi){1to16}, %zmm13, %zmm13
vpxord	0x18(%rdi){1to16}, %zmm14, %zmm14
vpxord	0x1c(%rdi){1to16}, %zmm15, %zmm15
vpunpckldq	%zmm1, %zmm0, %zmm16
vpunpckhdq	%zmm1, %zmm0, %zmm17
vpunpckldq	%zmm3, %zmm2, %zmm18
vpunpckhdq	%zmm3, %zmm2, %zmm19
vpunpckldq	%zmm5, %zmm4, %zmm20
vpunpckhdq	%zmm5, %zmm4, %zmm21
vpunpckldq	%zmm7, %zmm6, %zmm22
vpunpckhdq	%zmm7, %zmm6, %zmm23
vpunpckldq	%zmm9, %zmm8, %zmm24
vpunpckhdq	%zmm9, %zmm8, %zmm25
vpunpckldq	%zmm11, %zmm10, %zmm26
vpunpckhdq	%zmm11, %zmm10, %zmm27
vpunpckldq	%zmm13, %zmm12, %zmm28
vpunpckhdq	%zmm13, %zmm12, %zmm29
vpunpckldq	%zmm15, %zmm14, %zmm30
vpunpckhdq	%zmm15, %zmm14, %zmm31
vpunpcklqdq	%zmm18, %zmm16, %zmm0
vpunpckhqdq	%zmm18, %zmm16, %zmm1
vpunpcklqdq	%zmm19, %zmm17, %zmm2
vpunpckhqdq	%zmm19, %zmm17, %zmm3
vpunpcklqdq	%zmm22, %zmm20, %zmm4
vpunpckhqdq	%zmm22, %zmm20, %zmm5
vpunpcklqdq	%zmm23, %zmm21, %zmm6
vpunpckhqdq	%zmm23, %zmm21, %zmm7
vpunpcklqdq	%zmm26, %zmm24, %zmm8
vpunpckhqdq	%zmm26, %zmm24, %zmm9
vpunpcklqdq	%zmm27, %zmm25, %zmm10
vpunpckhqdq	%zmm27, %zmm25, %zmm11
vpunpcklqdq	%zmm30, %zmm28, %zmm12
vpunpckhqdq	%zmm30, %zmm28, %zmm13
vpunpcklqdq	%zmm31, %zmm29, %zmm14
vpunpckhqdq	%zmm31, %zmm29, %zmm15
vshufi32x4	$0x88, %zmm4, %zmm0, %zmm16
vshufi32x4	$0x88, %zmm5, %zmm1, %zmm17
vshufi32x4	$0x88, %zmm6, %zmm2, %zmm18
vshufi32x4	$0x88, %zmm7, %zmm3, %zmm19
vshufi32x4	$0xdd, %zmm4, %zmm0, %zmm20
vshufi32x4	$0xdd, %zmm5, %zmm1, %zmm21
vshufi32x4	$0xdd, %zmm6, %zmm2, %zmm22
vshufi32x4	$0xdd, %zmm7, %zmm3, %zmm23
vshufi32x4	$0x88, %zmm12, %zmm8, %zmm24
vshufi32x4	$0x88, %zmm13, %zmm9, %zmm25
vshufi32x4	$0x88, %zmm14, %zmm10, %zmm26
vshufi32x4	$0x88, %zmm15, %zmm11, %zmm27
vshufi32x4	$0xdd, %zmm12, %zmm8, %zmm28
vshufi32x4	$0xdd, %zmm13, %zmm9, %zmm29
vshufi32x4	$0xdd, %zmm14, %zmm10, %zmm30
vshufi32x4	$0xdd, %zmm15, %zmm11, %zmm31
vshufi32x4	$0x88, %zmm24, %zmm16, %zmm0
vshufi32x4	$0x88, %zmm25, %zmm17, %zmm1
vshufi32x4	$0x88, %zmm26, %zmm18, %zmm2
vshufi32x4	$0x88, %zmm27, %zmm19, %zmm3
vshufi32x4	$0x88, %zmm28, %zmm20, %zmm4
vshufi32x4	$0x88, %zmm29, %zmm21, %zmm5
vshufi32x4	$0x88, %zmm30, %zmm22, %zmm6
vshufi32x4	$0x88, %zmm31, %zmm23, %zmm7
vshufi32x4	$0xdd, %zmm24, %zmm16, %zmm8
vshufi32x4	$0xdd, %zmm25, %zmm17, %zmm9
vshufi32x4	$0xdd, %zmm26, %zmm18, %zmm10
vshufi32x4	$0xdd, %zmm27, %zmm19, %zmm11
vshufi32x4	$0xdd, %zmm28, %zmm20, %zmm12
vshufi32x4	$0xdd, %zmm29, %zmm21, %zmm13
vshufi32x4	$0xdd, %zmm30, %zmm22, %zmm14
vshufi32x4	$0xdd, %zmm31, %zmm23, %zmm15
vmovdqu32	%zmm0, (%r9)
vmovdqu32	%zmm1, 0x40(%r9)
vmovdqu32	%zmm2, 0x80(%r9)
vmovdqu32	%zmm3, 0xc0(%r9)
vmovdqu32	%zmm4, 0x100(%r9)
vmovdqu32	%zmm5, 0x140(%r9)
vmovdqu32	%zmm6, 0x180(%r9)
vmovdqu32	%zmm7, 0x1c0(%r9)
vmovdqu32	%zmm8, 0x200(%r9)
vmovdqu32	%zmm9, 0x240(%r9)
vmovdqu32	%zmm10, 0x280(%r9)
vmovdqu32	%zmm11, 0x2c0(%r9)
vmovdqu32	%zmm12, 0x300(%r9)
vmovdqu32	%zmm13, 0x340(%r9)
vmovdqu32	%zmm14, 0x380(%r9)
vmovdqu32	%zmm15, 0x3c0(%r9)
vmovdqa32	(%rsp), %zmm0
vmovdqa32	0x40(%rsp), %zmm1
vpaddd	ADD16(%rip){1to16}, %zmm0, %zmm2
vpcmpltud	%zmm0, %zmm2, %k1
vpaddd	ADD1(%rip){1to16}, %zmm1, %zmm1 {%k1}
vmovdqa32	%zmm2, (%rsp)
vmovdqa32	%zmm1, 0x40(%rsp)
addq	$0x400, %r9
subq	$0x10, %r10
cmpq	$0x10, %r10
jae	L_3c93
testq	%r10, %r10
jne	L_538d
L_5385:
vzeroupper
movq	%rbp, %rsp
popq	%rbp
retq
L_538d:
testq	$0x8, %r10
je	L_687b
vpbroadcastd	(%rsi), %ymm16
vpbroadcastd	0x4(%rsi), %ymm17
vpbroadcastd	0x8(%rsi), %ymm18
vpbroadcastd	0xc(%rsi), %ymm19
vpbroadcastd	0x10(%rsi), %ymm20
vpbroadcastd	0x14(%rsi), %ymm21
vpbroadcastd	0x18(%rsi), %ymm22
vpbroadcastd	0x1c(%rsi), %ymm23
vpbroadcastd	0x20(%rsi), %ymm24
vpbroadcastd	0x24(%rsi), %ymm25
vpbroadcastd	0x28(%rsi), %ymm26
vpbroadcastd	0x2c(%rsi), %ymm27
vpbroadcastd	0x30(%rsi), %ymm28
vpbroadcastd	0x34(%rsi), %ymm29
vpbroadcastd	0x38(%rsi), %ymm30
vpbroadcastd	0x3c(%rsi), %ymm31
vpbroadcastd	(%rdi), %ymm0
vpbroadcastd	0x4(%rdi), %ymm1
vpbroadcastd	0x8(%rdi), %ymm2
vpbroadcastd	0xc(%rdi), %ymm3
vpbroadcastd	0x10(%rdi), %ymm4
vpbroadcastd	0x14(%rdi), %ymm5
vpbroadcastd	0x18(%rdi), %ymm6
vpbroadcastd	0x1c(%rdi), %ymm7
vpbroadcastd	BLAKE3_IV_0(%rip), %ymm8
vpbroadcastd	BLAKE3_IV_1(%rip), %ymm9
vpbroadcastd	BLAKE3_IV_2(%rip), %ymm10
vpbroadcastd	BLAKE3_IV_3(%rip), %ymm11
vmovdqa	(%rsp), %ymm12
vmovdqa	0x40(%rsp), %ymm13
vpbroadcastd	%edx, %ymm14
vpbroadcastd	%r8d, %ymm15
vpaddd	%ymm16, %ymm0, %ymm0
vpaddd	%ymm18, %ymm1, %ymm1
vpaddd	%ymm20, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm17, %ymm0, %ymm0
vpaddd	%ymm19, %ymm1, %ymm1
vpaddd	%ymm21, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm24, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm28, %ymm2, %ymm2
vpaddd	%ymm30, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm25, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm29, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm18, %ymm0, %ymm0
vpaddd	%ymm19, %ymm1, %ymm1
vpaddd	%ymm23, %ymm2, %ymm2
vpaddd	%ymm20, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm22, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm16, %ymm2, %ymm2
vpaddd	%ymm29, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm17, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm25, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm27, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm30, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm19, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm29, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm20, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm18, %ymm2, %ymm2
vpaddd	%ymm30, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm22, %ymm0, %ymm0
vpaddd	%ymm25, %ymm1, %ymm1
vpaddd	%ymm27, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm21, %ymm0, %ymm0
vpaddd	%ymm16, %ymm1, %ymm1
vpaddd	%ymm31, %ymm2, %ymm2
vpaddd	%ymm17, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm26, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm30, %ymm2, %ymm2
vpaddd	%ymm29, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm23, %ymm0, %ymm0
vpaddd	%ymm25, %ymm1, %ymm1
vpaddd	%ymm19, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm20, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm21, %ymm2, %ymm2
vpaddd	%ymm17, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm16, %ymm0, %ymm0
vpaddd	%ymm18, %ymm1, %ymm1
vpaddd	%ymm24, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm28, %ymm0, %ymm0
vpaddd	%ymm25, %ymm1, %ymm1
vpaddd	%ymm31, %ymm2, %ymm2
vpaddd	%ymm30, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm29, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm26, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm23, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm16, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm18, %ymm0, %ymm0
vpaddd	%ymm19, %ymm1, %ymm1
vpaddd	%ymm17, %ymm2, %ymm2
vpaddd	%ymm20, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm25, %ymm0, %ymm0
vpaddd	%ymm27, %ymm1, %ymm1
vpaddd	%ymm24, %ymm2, %ymm2
vpaddd	%ymm31, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm30, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm28, %ymm2, %ymm2
vpaddd	%ymm17, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm29, %ymm0, %ymm0
vpaddd	%ymm16, %ymm1, %ymm1
vpaddd	%ymm18, %ymm2, %ymm2
vpaddd	%ymm20, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm19, %ymm0, %ymm0
vpaddd	%ymm26, %ymm1, %ymm1
vpaddd	%ymm22, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpaddd	%ymm27, %ymm0, %ymm0
vpaddd	%ymm21, %ymm1, %ymm1
vpaddd	%ymm17, %ymm2, %ymm2
vpaddd	%ymm24, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vpaddd	%ymm31, %ymm0, %ymm0
vpaddd	%ymm16, %ymm1, %ymm1
vpaddd	%ymm25, %ymm2, %ymm2
vpaddd	%ymm22, %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxord	%ymm0, %ymm12, %ymm12
vpxord	%ymm1, %ymm13, %ymm13
vpxord	%ymm2, %ymm14, %ymm14
vpxord	%ymm3, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vpaddd	%ymm12, %ymm8, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxord	%ymm8, %ymm4, %ymm4
vpxord	%ymm9, %ymm5, %ymm5
vpxord	%ymm10, %ymm6, %ymm6
vpxord	%ymm11, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vpaddd	%ymm30, %ymm0, %ymm0
vpaddd	%ymm18, %ymm1, %ymm1
vpaddd	%ymm19, %ymm2, %ymm2
vpaddd	%ymm23, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x10, %ymm15, %ymm15
vprord	$0x10, %ymm12, %ymm12
vprord	$0x10, %ymm13, %ymm13
vprord	$0x10, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0xc, %ymm5, %ymm5
vprord	$0xc, %ymm6, %ymm6
vprord	$0xc, %ymm7, %ymm7
vprord	$0xc, %ymm4, %ymm4
vpaddd	%ymm26, %ymm0, %ymm0
vpaddd	%ymm28, %ymm1, %ymm1
vpaddd	%ymm20, %ymm2, %ymm2
vpaddd	%ymm29, %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxord	%ymm0, %ymm15, %ymm15
vpxord	%ymm1, %ymm12, %ymm12
vpxord	%ymm2, %ymm13, %ymm13
vpxord	%ymm3, %ymm14, %ymm14
vprord	$0x8, %ymm15, %ymm15
vprord	$0x8, %ymm12, %ymm12
vprord	$0x8, %ymm13, %ymm13
vprord	$0x8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxord	%ymm10, %ymm5, %ymm5
vpxord	%ymm11, %ymm6, %ymm6
vpxord	%ymm8, %ymm7, %ymm7
vpxord	%ymm9, %ymm4, %ymm4
vprord	$0x7, %ymm5, %ymm5
vprord	$0x7, %ymm6, %ymm6
vprord	$0x7, %ymm7, %ymm7
vprord	$0x7, %ymm4, %ymm4
vpxor	%ymm0, %ymm8, %ymm0
vpxor	%ymm1, %ymm9, %ymm1
vpxor	%ymm2, %ymm10, %ymm2
vpxor	%ymm3, %ymm11, %ymm3
vpxor	%ymm4, %ymm12, %ymm4
vpxor	%ymm5, %ymm13, %ymm5
vpxor	%ymm6, %ymm14, %ymm6
vpxor	%ymm7, %ymm15, %ymm7
vpxord	(%rdi){1to8}, %ymm8, %ymm8
vpxord	0x4(%rdi){1to8}, %ymm9, %ymm9
vpxord	0x8(%rdi){1to8}, %ymm10, %ymm10
vpxord	0xc(%rdi){1to8}, %ymm11, %ymm11
vpxord	0x10(%rdi){1to8}, %ymm12, %ymm12
vpxord	0x14(%rdi){1to8}, %ymm13, %ymm13
vpxord	0x18(%rdi){1to8}, %ymm14, %ymm14
vpxord	0x1c(%rdi){1to8}, %ymm15, %ymm15
vpunpckldq	%ymm1, %ymm0, %ymm16
vpunpckhdq	%ymm1, %ymm0, %ymm17
vpunpckldq	%ymm3, %ymm2, %ymm18
vpunpckhdq	%ymm3, %ymm2, %ymm19
vpunpckldq	%ymm5, %ymm4, %ymm20
vpunpckhdq	%ymm5, %ymm4, %ymm21
vpunpckldq	%ymm7, %ymm6, %ymm22
vpunpckhdq	%ymm7, %ymm6, %ymm23
vpunpckldq	%ymm9, %ymm8, %ymm24
vpunpckhdq	%ymm9, %ymm8, %ymm25
vpunpckldq	%ymm11, %ymm10, %ymm26
vpunpckhdq	%ymm11, %ymm10, %ymm27
vpunpckldq	%ymm13, %ymm12, %ymm28
vpunpckhdq	%ymm13, %ymm12, %ymm29
vpunpckldq	%ymm15, %ymm14, %ymm30
vpunpckhdq	%ymm15, %ymm14, %ymm31
vpunpcklqdq	%ymm18, %ymm16, %ymm0
vpunpckhqdq	%ymm18, %ymm16, %ymm1
vpunpcklqdq	%ymm19, %ymm17, %ymm2
vpunpckhqdq	%ymm19, %ymm17, %ymm3
vpunpcklqdq	%ymm22, %ymm20, %ymm4
vpunpckhqdq	%ymm22, %ymm20, %ymm5
vpunpcklqdq	%ymm23, %ymm21, %ymm6
vpunpckhqdq	%ymm23, %ymm21, %ymm7
vpunpcklqdq	%ymm26, %ymm24, %ymm8
vpunpckhqdq	%ymm26, %ymm24, %ymm9
vpunpcklqdq	%ymm27, %ymm25, %ymm10
vpunpckhqdq	%ymm27, %ymm25, %ymm11
vpunpcklqdq	%ymm30, %ymm28, %ymm12
vpunpckhqdq	%ymm30, %ymm28, %ymm13
vpunpcklqdq	%ymm31, %ymm29, %ymm14
vpunpckhqdq	%ymm31, %ymm29, %ymm15
vshufi32x4	$0x0, %ymm4, %ymm0, %ymm16
vshufi32x4	$0x0, %ymm12, %ymm8, %ymm17
vshufi32x4	$0x0, %ymm5, %ymm1, %ymm18
vshufi32x4	$0x0, %ymm13, %ymm9, %ymm19
vshufi32x4	$0x0, %ymm6, %ymm2, %ymm20
vshufi32x4	$0x0, %ymm14, %ymm10, %ymm21
vshufi32x4	$0x0, %ymm7, %ymm3, %ymm22
vshufi32x4	$0x0, %ymm15, %ymm11, %ymm23
vshufi32x4	$0x3, %ymm4, %ymm0, %ymm24
vshufi32x4	$0x3, %ymm12, %ymm8, %ymm25
vshufi32x4	$0x3, %ymm5, %ymm1, %ymm26
vshufi32x4	$0x3, %ymm13, %ymm9, %ymm27
vshufi32x4	$0x3, %ymm6, %ymm2, %ymm28
vshufi32x4	$0x3, %ymm14, %ymm10, %ymm29
vshufi32x4	$0x3, %ymm7, %ymm3, %ymm30
vshufi32x4	$0x3, %ymm15, %ymm11, %ymm31
vmovdqu32	%ymm16, (%r9)
vmovdqu32	%ymm17, 0x20(%r9)
vmovdqu32	%ymm18, 0x40(%r9)
vmovdqu32	%ymm19, 0x60(%r9)
vmovdqu32	%ymm20, 0x80(%r9)
vmovdqu32	%ymm21, 0xa0(%r9)
vmovdqu32	%ymm22, 0xc0(%r9)
vmovdqu32	%ymm23, 0xe0(%r9)
vmovdqu32	%ymm24, 0x100(%r9)
vmovdqu32	%ymm25, 0x120(%r9)
vmovdqu32	%ymm26, 0x140(%r9)
vmovdqu32	%ymm27, 0x160(%r9)
vmovdqu32	%ymm28, 0x180(%r9)
vmovdqu32	%ymm29, 0x1a0(%r9)
vmovdqu32	%ymm30, 0x1c0(%r9)
vmovdqu32	%ymm31, 0x1e0(%r9)
vmovdqa	0x20(%rsp), %ymm0
vmovdqa	0x60(%rsp), %ymm1
vmovdqa	%ymm0, (%rsp)
vmovdqa	%ymm1, 0x40(%rsp)
addq	$0x200, %r9
subq	$0x8, %r10
L_687b:
testq	$0x4, %r10
je	L_6b32
vbroadcasti32x4	(%rdi), %zmm0
vbroadcasti32x4	0x10(%rdi), %zmm1
vbroadcasti32x4	BLAKE3_IV_0(%rip), %zmm2
vmovdqa	(%rsp), %xmm12
vmovdqa	0x40(%rsp), %xmm13
vpunpckldq	%xmm13, %xmm12, %xmm14
vpunpckhdq	%xmm13, %xmm12, %xmm15
vpermq	$0xdc, %ymm14, %ymm14
vpermq	$0xdc, %ymm15, %ymm15
vpbroadcastd	%edx, %zmm12
vinserti64x4	$0x1, %ymm15, %zmm14, %zmm13
movl	$0x4444, %eax
kmovw	%eax, %k2
vpblendmd	%zmm12, %zmm13, %zmm13 {%k2}
vpbroadcastd	%r8d, %zmm15
movl	$0x8888, %eax
kmovw	%eax, %k4
vpblendmd	%zmm15, %zmm13, %zmm3 {%k4}
movl	$0xaaaa, %eax
kmovw	%eax, %k3
vbroadcasti32x4	(%rsi), %zmm8
vbroadcasti32x4	0x10(%rsi), %zmm9
vshufps	$0x88, %zmm9, %zmm8, %zmm4
vshufps	$0xdd, %zmm9, %zmm8, %zmm5
vbroadcasti32x4	0x20(%rsi), %zmm8
vbroadcasti32x4	0x30(%rsi), %zmm9
vshufps	$0x88, %zmm9, %zmm8, %zmm6
vshufps	$0xdd, %zmm9, %zmm8, %zmm7
vpshufd	$0x93, %zmm6, %zmm6
vpshufd	$0x93, %zmm7, %zmm7
movb	$0x7, %al
L_6941:
vpaddd	%zmm4, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x10, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0xc, %zmm1, %zmm1
vpaddd	%zmm5, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x8, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0x7, %zmm1, %zmm1
vpshufd	$0x93, %zmm0, %zmm0
vpshufd	$0x4e, %zmm3, %zmm3
vpshufd	$0x39, %zmm2, %zmm2
vpaddd	%zmm6, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x10, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0xc, %zmm1, %zmm1
vpaddd	%zmm7, %zmm0, %zmm0
vpaddd	%zmm1, %zmm0, %zmm0
vpxord	%zmm0, %zmm3, %zmm3
vprord	$0x8, %zmm3, %zmm3
vpaddd	%zmm3, %zmm2, %zmm2
vpxord	%zmm2, %zmm1, %zmm1
vprord	$0x7, %zmm1, %zmm1
vpshufd	$0x39, %zmm0, %zmm0
vpshufd	$0x4e, %zmm3, %zmm3
vpshufd	$0x93, %zmm2, %zmm2
decb	%al
je	L_6a78
vshufps	$0xd6, %zmm5, %zmm4, %zmm8
vpshufd	$0xf, %zmm4, %zmm9
vpshufd	$0x39, %zmm8, %zmm4
vshufps	$0xfa, %zmm7, %zmm6, %zmm8
vpblendmd	%zmm8, %zmm9, %zmm9 {%k3}
vpunpcklqdq	%zmm5, %zmm7, %zmm8
vpblendmd	%zmm6, %zmm8, %zmm8 {%k4}
vpshufd	$0x78, %zmm8, %zmm8
vpunpckhdq	%zmm7, %zmm5, %zmm5
vpunpckldq	%zmm5, %zmm6, %zmm6
vpshufd	$0x1e, %zmm6, %zmm7
vmovdqa32	%zmm9, %zmm5
vmovdqa32	%zmm8, %zmm6
jmp	L_6941
L_6a78:
vpxord	%zmm2, %zmm0, %zmm0
vpxord	%zmm3, %zmm1, %zmm1
vbroadcasti32x4	(%rdi), %zmm8
vbroadcasti32x4	0x10(%rdi), %zmm9
vpxord	%zmm8, %zmm2, %zmm2
vpxord	%zmm9, %zmm3, %zmm3
vmovdqu	%xmm0, (%r9)
vmovdqu	%xmm1, 0x10(%r9)
vmovdqu	%xmm2, 0x20(%r9)
vmovdqu	%xmm3, 0x30(%r9)
vextracti128	$0x1, %ymm0, 0x40(%r9)
vextracti128	$0x1, %ymm1, 0x50(%r9)
vextracti128	$0x1, %ymm2, 0x60(%r9)
vextracti128	$0x1, %ymm3, 0x70(%r9)
vextracti32x4	$0x2, %zmm0, 0x80(%r9)
vextracti32x4	$0x2, %zmm1, 0x90(%r9)
vextracti32x4	$0x2, %zmm2, 0xa0(%r9)
vextracti32x4	$0x2, %zmm3, 0xb0(%r9)
vextracti32x4	$0x3, %zmm0, 0xc0(%r9)
vextracti32x4	$0x3, %zmm1, 0xd0(%r9)
vextracti32x4	$0x3, %zmm2, 0xe0(%r9)
vextracti32x4	$0x3, %zmm3, 0xf0(%r9)
vmovdqa	0x10(%rsp), %xmm0
vmovdqa	0x50(%rsp), %xmm1
vmovdqa	%xmm0, (%rsp)
vmovdqa	%xmm1, 0x40(%rsp)
addq	$0x100, %r9
subq	$0x4, %r10
L_6b32:
testq	$0x2, %r10
je	L_6d36
vbroadcasti128	(%rdi), %ymm0
vbroadcasti128	0x10(%rdi), %ymm1
vmovd	(%rsp), %xmm13
vpinsrd	$0x1, 0x40(%rsp), %xmm13, %xmm13
vpinsrd	$0x2, %edx, %xmm13, %xmm13
vmovd	0x4(%rsp), %xmm14
vpinsrd	$0x1, 0x44(%rsp), %xmm14, %xmm14
vpinsrd	$0x2, %edx, %xmm14, %xmm14
vinserti128	$0x1, %xmm14, %ymm13, %ymm13
vbroadcasti128	BLAKE3_IV_0(%rip), %ymm2
vpbroadcastd	%r8d, %ymm8
vpblendd	$0x88, %ymm8, %ymm13, %ymm3
vbroadcasti128	(%rsi), %ymm8
vbroadcasti128	0x10(%rsi), %ymm9
vshufps	$0x88, %ymm9, %ymm8, %ymm4
vshufps	$0xdd, %ymm9, %ymm8, %ymm5
vbroadcasti128	0x20(%rsi), %ymm8
vbroadcasti128	0x30(%rsi), %ymm9
vshufps	$0x88, %ymm9, %ymm8, %ymm6
vshufps	$0xdd, %ymm9, %ymm8, %ymm7
vpshufd	$0x93, %ymm6, %ymm6
vpshufd	$0x93, %ymm7, %ymm7
movb	$0x7, %al
L_6bc7:
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x10, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0xc, %ymm1, %ymm1
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x8, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0x7, %ymm1, %ymm1
vpshufd	$0x93, %ymm0, %ymm0
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x39, %ymm2, %ymm2
vpaddd	%ymm6, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x10, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0xc, %ymm1, %ymm1
vpaddd	%ymm7, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxord	%ymm0, %ymm3, %ymm3
vprord	$0x8, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxord	%ymm2, %ymm1, %ymm1
vprord	$0x7, %ymm1, %ymm1
vpshufd	$0x39, %ymm0, %ymm0
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x93, %ymm2, %ymm2
decb	%al
je	L_6cc6
vshufps	$0xd6, %ymm5, %ymm4, %ymm8
vpshufd	$0xf, %ymm4, %ymm9
vpshufd	$0x39, %ymm8, %ymm4
vshufps	$0xfa, %ymm7, %ymm6, %ymm8
vpblendd	$0xaa, %ymm8, %ymm9, %ymm9
vpunpcklqdq	%ymm5, %ymm7, %ymm8
vpblendd	$0x88, %ymm6, %ymm8, %ymm8
vpshufd	$0x78, %ymm8, %ymm8
vpunpckhdq	%ymm7, %ymm5, %ymm5
vpunpckldq	%ymm5, %ymm6, %ymm6
vpshufd	$0x1e, %ymm6, %ymm7
vmovdqa	%ymm9, %ymm5
vmovdqa	%ymm8, %ymm6
jmp	L_6bc7
L_6cc6:
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm3, %ymm1, %ymm1
vbroadcasti128	(%rdi), %ymm8
vbroadcasti128	0x10(%rdi), %ymm9
vpxor	%ymm2, %ymm8, %ymm2
vpxor	%ymm3, %ymm9, %ymm3
vmovdqu	%xmm0, (%r9)
vmovdqu	%xmm1, 0x10(%r9)
vmovdqu	%xmm2, 0x20(%r9)
vmovdqu	%xmm3, 0x30(%r9)
vextracti128	$0x1, %ymm0, 0x40(%r9)
vextracti128	$0x1, %ymm1, 0x50(%r9)
vextracti128	$0x1, %ymm2, 0x60(%r9)
vextracti128	$0x1, %ymm3, 0x70(%r9)
vmovdqu	0x8(%rsp), %xmm0
vmovdqu	0x48(%rsp), %xmm1
vmovdqa	%xmm0, (%rsp)
vmovdqa	%xmm1, 0x40(%rsp)
addq	$0x80, %r9
subq	$0x2, %r10
L_6d36:
testq	$0x1, %r10
je	L_5385
vmovdqu	(%rdi), %xmm0
vmovdqu	0x10(%rdi), %xmm1
vmovd	(%rsp), %xmm14
vpinsrd	$0x1, 0x40(%rsp), %xmm14, %xmm14
vpinsrd	$0x2, %edx, %xmm14, %xmm14
vmovdqa	BLAKE3_IV_0(%rip), %xmm2
vpinsrd	$0x3, %r8d, %xmm14, %xmm3
vmovups	(%rsi), %xmm8
vmovups	0x10(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm4
vshufps	$0xdd, %xmm9, %xmm8, %xmm5
vmovups	0x20(%rsi), %xmm8
vmovups	0x30(%rsi), %xmm9
vshufps	$0x88, %xmm9, %xmm8, %xmm6
vshufps	$0xdd, %xmm9, %xmm8, %xmm7
vpshufd	$0x93, %xmm6, %xmm6
vpshufd	$0x93, %xmm7, %xmm7
movb	$0x7, %al
L_6da4:
vpaddd	%xmm4, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm5, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x93, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x39, %xmm2, %xmm2
vpaddd	%xmm6, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x10, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0xc, %xmm1, %xmm1
vpaddd	%xmm7, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxord	%xmm0, %xmm3, %xmm3
vprord	$0x8, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxord	%xmm2, %xmm1, %xmm1
vprord	$0x7, %xmm1, %xmm1
vpshufd	$0x39, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_6ea3
vshufps	$0xd6, %xmm5, %xmm4, %xmm8
vpshufd	$0xf, %xmm4, %xmm9
vpshufd	$0x39, %xmm8, %xmm4
vshufps	$0xfa, %xmm7, %xmm6, %xmm8
vpblendd	$0xaa, %xmm8, %xmm9, %xmm9
vpunpcklqdq	%xmm5, %xmm7, %xmm8
vpblendd	$0x88, %xmm6, %xmm8, %xmm8
vpshufd	$0x78, %xmm8, %xmm8
vpunpckhdq	%xmm7, %xmm5, %xmm5
vpunpckldq	%xmm5, %xmm6, %xmm6
vpshufd	$0x1e, %xmm6, %xmm7
vmovdqa	%xmm9, %xmm5
vmovdqa	%xmm8, %xmm6
jmp	L_6da4
L_6ea3:
vpxor	%xmm2, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vpxor	(%rdi), %xmm2, %xmm2
vpxor	0x10(%rdi), %xmm3, %xmm3
vmovdqu	%xmm0, (%r9)
vmovdqu	%xmm1, 0x10(%r9)
vmovdqu	%xmm2, 0x20(%r9)
vmovdqu	%xmm3, 0x30(%r9)
jmp	L_5385
	.section .rodata
INDEX0:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 16,0,0,0,17,0,0,0,18,0,0,0,19,0,0,0
	.byte 8,0,0,0,9,0,0,0,10,0,0,0,11,0,0,0
	.byte 24,0,0,0,25,0,0,0,26,0,0,0,27,0,0,0
INDEX1:
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
	.byte 20,0,0,0,21,0,0,0,22,0,0,0,23,0,0,0
	.byte 12,0,0,0,13,0,0,0,14,0,0,0,15,0,0,0
	.byte 28,0,0,0,29,0,0,0,30,0,0,0,31,0,0,0
ADD0:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
	.byte 8,0,0,0,9,0,0,0,10,0,0,0,11,0,0,0
	.byte 12,0,0,0,13,0,0,0,14,0,0,0,15,0,0,0
ADD1:
	.byte 1,0,0,0
ADD16:
	.byte 16,0,0,0
BLAKE3_BLOCK_LEN:
	.byte 64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0
BLAKE3_IV_0:
BLAKE3_IV:
	.byte 103,230,9,106
BLAKE3_IV_1:
	.byte 133,174,103,187
BLAKE3_IV_2:
	.byte 114,243,110,60
BLAKE3_IV_3:
	.byte 58,245,79,165

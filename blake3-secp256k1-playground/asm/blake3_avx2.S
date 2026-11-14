	.text
_blake3_hash_many_avx2:
blake3_hash_many_avx2:
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
pushq	%rbp
movq	%rsp, %rbp
subq	$0x2a8, %rsp
andq	$-0x40, %rsp
negl	%r9d
vmovd	%r9d, %xmm0
vpbroadcastd	%xmm0, %ymm0
vmovdqa	%ymm0, 0x280(%rsp)
vpand	ADD0(%rip), %ymm0, %ymm1
vpand	ADD1(%rip), %ymm0, %ymm2
vmovdqa	%ymm2, 0x220(%rsp)
vmovd	%r8d, %xmm2
vpbroadcastd	%xmm2, %ymm2
vpaddd	%ymm1, %ymm2, %ymm2
vmovdqa	%ymm2, 0x240(%rsp)
vpxor	CMP_MSB_MASK(%rip), %ymm1, %ymm1
vpxor	CMP_MSB_MASK(%rip), %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm1, %ymm2
shrq	$0x20, %r8
vmovd	%r8d, %xmm3
vpbroadcastd	%xmm3, %ymm3
vpsubd	%ymm2, %ymm3, %ymm3
vmovdqa	%ymm3, 0x260(%rsp)
shlq	$0x6, %rdx
movq	%rdx, 0x2a0(%rsp)
cmpq	$0x8, %rsi
jb	L_1ae0
L_a3:
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
nopl	(%rax)
L_100:
movzbl	0x48(%rbp), %ebx
orl	%eax, %ebx
addq	$0x40, %rdx
cmpq	0x2a0(%rsp), %rdx
cmovel	%ebx, %eax
movl	%eax, 0x200(%rsp)
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
vshufps	$0x88, %ymm14, %ymm12, %ymm8
vmovaps	%ymm8, (%rsp)
vshufps	$0xdd, %ymm14, %ymm12, %ymm9
vmovaps	%ymm9, 0x20(%rsp)
vshufps	$0x88, %ymm15, %ymm13, %ymm10
vmovaps	%ymm10, 0x40(%rsp)
vshufps	$0xdd, %ymm15, %ymm13, %ymm11
vmovaps	%ymm11, 0x60(%rsp)
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
vshufps	$0x88, %ymm14, %ymm12, %ymm8
vmovaps	%ymm8, 0x80(%rsp)
vshufps	$0xdd, %ymm14, %ymm12, %ymm9
vmovaps	%ymm9, 0xa0(%rsp)
vshufps	$0x88, %ymm15, %ymm13, %ymm10
vmovaps	%ymm10, 0xc0(%rsp)
vshufps	$0xdd, %ymm15, %ymm13, %ymm11
vmovaps	%ymm11, 0xe0(%rsp)
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
vshufps	$0x88, %ymm14, %ymm12, %ymm8
vmovaps	%ymm8, 0x100(%rsp)
vshufps	$0xdd, %ymm14, %ymm12, %ymm9
vmovaps	%ymm9, 0x120(%rsp)
vshufps	$0x88, %ymm15, %ymm13, %ymm10
vmovaps	%ymm10, 0x140(%rsp)
vshufps	$0xdd, %ymm15, %ymm13, %ymm11
vmovaps	%ymm11, 0x160(%rsp)
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
vshufps	$0x88, %ymm14, %ymm12, %ymm8
vmovaps	%ymm8, 0x180(%rsp)
vshufps	$0xdd, %ymm14, %ymm12, %ymm9
vmovaps	%ymm9, 0x1a0(%rsp)
vshufps	$0x88, %ymm15, %ymm13, %ymm10
vmovaps	%ymm10, 0x1c0(%rsp)
vshufps	$0xdd, %ymm15, %ymm13, %ymm11
vmovaps	%ymm11, 0x1e0(%rsp)
vpbroadcastd	0x200(%rsp), %ymm15
prefetcht0	0x80(%r8,%rdx)
prefetcht0	0x80(%r12,%rdx)
prefetcht0	0x80(%r9,%rdx)
prefetcht0	0x80(%r13,%rdx)
prefetcht0	0x80(%r10,%rdx)
prefetcht0	0x80(%r14,%rdx)
prefetcht0	0x80(%r11,%rdx)
prefetcht0	0x80(%r15,%rdx)
vpaddd	(%rsp), %ymm0, %ymm0
vpaddd	0x40(%rsp), %ymm1, %ymm1
vpaddd	0x80(%rsp), %ymm2, %ymm2
vpaddd	0xc0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	0x240(%rsp), %ymm0, %ymm12
vpxor	0x260(%rsp), %ymm1, %ymm13
vpxor	BLAKE3_BLOCK_LEN(%rip), %ymm2, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	BLAKE3_IV_0(%rip), %ymm12, %ymm8
vpaddd	BLAKE3_IV_1(%rip), %ymm13, %ymm9
vpaddd	BLAKE3_IV_2(%rip), %ymm14, %ymm10
vpaddd	BLAKE3_IV_3(%rip), %ymm15, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x20(%rsp), %ymm0, %ymm0
vpaddd	0x60(%rsp), %ymm1, %ymm1
vpaddd	0xa0(%rsp), %ymm2, %ymm2
vpaddd	0xe0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x100(%rsp), %ymm0, %ymm0
vpaddd	0x140(%rsp), %ymm1, %ymm1
vpaddd	0x180(%rsp), %ymm2, %ymm2
vpaddd	0x1c0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x120(%rsp), %ymm0, %ymm0
vpaddd	0x160(%rsp), %ymm1, %ymm1
vpaddd	0x1a0(%rsp), %ymm2, %ymm2
vpaddd	0x1e0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x40(%rsp), %ymm0, %ymm0
vpaddd	0x60(%rsp), %ymm1, %ymm1
vpaddd	0xe0(%rsp), %ymm2, %ymm2
vpaddd	0x80(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0xc0(%rsp), %ymm0, %ymm0
vpaddd	0x140(%rsp), %ymm1, %ymm1
vpaddd	(%rsp), %ymm2, %ymm2
vpaddd	0x1a0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x20(%rsp), %ymm0, %ymm0
vpaddd	0x180(%rsp), %ymm1, %ymm1
vpaddd	0x120(%rsp), %ymm2, %ymm2
vpaddd	0x1e0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x160(%rsp), %ymm0, %ymm0
vpaddd	0xa0(%rsp), %ymm1, %ymm1
vpaddd	0x1c0(%rsp), %ymm2, %ymm2
vpaddd	0x100(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x60(%rsp), %ymm0, %ymm0
vpaddd	0x140(%rsp), %ymm1, %ymm1
vpaddd	0x1a0(%rsp), %ymm2, %ymm2
vpaddd	0xe0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x80(%rsp), %ymm0, %ymm0
vpaddd	0x180(%rsp), %ymm1, %ymm1
vpaddd	0x40(%rsp), %ymm2, %ymm2
vpaddd	0x1c0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0xc0(%rsp), %ymm0, %ymm0
vpaddd	0x120(%rsp), %ymm1, %ymm1
vpaddd	0x160(%rsp), %ymm2, %ymm2
vpaddd	0x100(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0xa0(%rsp), %ymm0, %ymm0
vpaddd	(%rsp), %ymm1, %ymm1
vpaddd	0x1e0(%rsp), %ymm2, %ymm2
vpaddd	0x20(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x140(%rsp), %ymm0, %ymm0
vpaddd	0x180(%rsp), %ymm1, %ymm1
vpaddd	0x1c0(%rsp), %ymm2, %ymm2
vpaddd	0x1a0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0xe0(%rsp), %ymm0, %ymm0
vpaddd	0x120(%rsp), %ymm1, %ymm1
vpaddd	0x60(%rsp), %ymm2, %ymm2
vpaddd	0x1e0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x80(%rsp), %ymm0, %ymm0
vpaddd	0x160(%rsp), %ymm1, %ymm1
vpaddd	0xa0(%rsp), %ymm2, %ymm2
vpaddd	0x20(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	(%rsp), %ymm0, %ymm0
vpaddd	0x40(%rsp), %ymm1, %ymm1
vpaddd	0x100(%rsp), %ymm2, %ymm2
vpaddd	0xc0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x180(%rsp), %ymm0, %ymm0
vpaddd	0x120(%rsp), %ymm1, %ymm1
vpaddd	0x1e0(%rsp), %ymm2, %ymm2
vpaddd	0x1c0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x1a0(%rsp), %ymm0, %ymm0
vpaddd	0x160(%rsp), %ymm1, %ymm1
vpaddd	0x140(%rsp), %ymm2, %ymm2
vpaddd	0x100(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0xe0(%rsp), %ymm0, %ymm0
vpaddd	0xa0(%rsp), %ymm1, %ymm1
vpaddd	(%rsp), %ymm2, %ymm2
vpaddd	0xc0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x40(%rsp), %ymm0, %ymm0
vpaddd	0x60(%rsp), %ymm1, %ymm1
vpaddd	0x20(%rsp), %ymm2, %ymm2
vpaddd	0x80(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x120(%rsp), %ymm0, %ymm0
vpaddd	0x160(%rsp), %ymm1, %ymm1
vpaddd	0x100(%rsp), %ymm2, %ymm2
vpaddd	0x1e0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x1c0(%rsp), %ymm0, %ymm0
vpaddd	0xa0(%rsp), %ymm1, %ymm1
vpaddd	0x180(%rsp), %ymm2, %ymm2
vpaddd	0x20(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x1a0(%rsp), %ymm0, %ymm0
vpaddd	(%rsp), %ymm1, %ymm1
vpaddd	0x40(%rsp), %ymm2, %ymm2
vpaddd	0x80(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x60(%rsp), %ymm0, %ymm0
vpaddd	0x140(%rsp), %ymm1, %ymm1
vpaddd	0xc0(%rsp), %ymm2, %ymm2
vpaddd	0xe0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x160(%rsp), %ymm0, %ymm0
vpaddd	0xa0(%rsp), %ymm1, %ymm1
vpaddd	0x20(%rsp), %ymm2, %ymm2
vpaddd	0x100(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x1e0(%rsp), %ymm0, %ymm0
vpaddd	(%rsp), %ymm1, %ymm1
vpaddd	0x120(%rsp), %ymm2, %ymm2
vpaddd	0xc0(%rsp), %ymm3, %ymm3
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm1
vpaddd	%ymm6, %ymm2, %ymm2
vpaddd	%ymm7, %ymm3, %ymm3
vpxor	%ymm0, %ymm12, %ymm12
vpxor	%ymm1, %ymm13, %ymm13
vpxor	%ymm2, %ymm14, %ymm14
vpxor	%ymm3, %ymm15, %ymm15
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpshufb	%ymm8, %ymm15, %ymm15
vpaddd	0x200(%rsp), %ymm12, %ymm8
vpaddd	%ymm13, %ymm9, %ymm9
vpaddd	%ymm14, %ymm10, %ymm10
vpaddd	%ymm15, %ymm11, %ymm11
vpxor	%ymm4, %ymm8, %ymm4
vpxor	%ymm5, %ymm9, %ymm5
vpxor	%ymm6, %ymm10, %ymm6
vpxor	%ymm7, %ymm11, %ymm7
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpaddd	0x1c0(%rsp), %ymm0, %ymm0
vpaddd	0x40(%rsp), %ymm1, %ymm1
vpaddd	0x60(%rsp), %ymm2, %ymm2
vpaddd	0xe0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT16(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vmovdqa	%ymm8, 0x200(%rsp)
vpsrld	$0xc, %ymm5, %ymm8
vpslld	$0x14, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0xc, %ymm6, %ymm8
vpslld	$0x14, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0xc, %ymm7, %ymm8
vpslld	$0x14, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0xc, %ymm4, %ymm8
vpslld	$0x14, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpaddd	0x140(%rsp), %ymm0, %ymm0
vpaddd	0x180(%rsp), %ymm1, %ymm1
vpaddd	0x80(%rsp), %ymm2, %ymm2
vpaddd	0x1a0(%rsp), %ymm3, %ymm3
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm6, %ymm1, %ymm1
vpaddd	%ymm7, %ymm2, %ymm2
vpaddd	%ymm4, %ymm3, %ymm3
vpxor	%ymm0, %ymm15, %ymm15
vpxor	%ymm1, %ymm12, %ymm12
vpxor	%ymm2, %ymm13, %ymm13
vpxor	%ymm3, %ymm14, %ymm14
vbroadcasti128	ROT8(%rip), %ymm8
vpshufb	%ymm8, %ymm15, %ymm15
vpshufb	%ymm8, %ymm12, %ymm12
vpshufb	%ymm8, %ymm13, %ymm13
vpshufb	%ymm8, %ymm14, %ymm14
vpaddd	%ymm15, %ymm10, %ymm10
vpaddd	%ymm12, %ymm11, %ymm11
vpaddd	0x200(%rsp), %ymm13, %ymm8
vpaddd	%ymm14, %ymm9, %ymm9
vpxor	%ymm5, %ymm10, %ymm5
vpxor	%ymm6, %ymm11, %ymm6
vpxor	%ymm7, %ymm8, %ymm7
vpxor	%ymm4, %ymm9, %ymm4
vpxor	%ymm0, %ymm8, %ymm0
vpxor	%ymm1, %ymm9, %ymm1
vpxor	%ymm2, %ymm10, %ymm2
vpxor	%ymm3, %ymm11, %ymm3
vpsrld	$0x7, %ymm5, %ymm8
vpslld	$0x19, %ymm5, %ymm5
vpor	%ymm5, %ymm8, %ymm5
vpsrld	$0x7, %ymm6, %ymm8
vpslld	$0x19, %ymm6, %ymm6
vpor	%ymm6, %ymm8, %ymm6
vpsrld	$0x7, %ymm7, %ymm8
vpslld	$0x19, %ymm7, %ymm7
vpor	%ymm7, %ymm8, %ymm7
vpsrld	$0x7, %ymm4, %ymm8
vpslld	$0x19, %ymm4, %ymm4
vpor	%ymm4, %ymm8, %ymm4
vpxor	%ymm4, %ymm12, %ymm4
vpxor	%ymm5, %ymm13, %ymm5
vpxor	%ymm6, %ymm14, %ymm6
vpxor	%ymm7, %ymm15, %ymm7
movzbl	0x38(%rbp), %eax
jne	L_100
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
vmovdqa	0x220(%rsp), %ymm0
vpaddd	0x240(%rsp), %ymm0, %ymm1
vmovdqa	%ymm1, 0x240(%rsp)
vpxor	CMP_MSB_MASK(%rip), %ymm0, %ymm0
vpxor	CMP_MSB_MASK(%rip), %ymm1, %ymm2
vpcmpgtd	%ymm2, %ymm0, %ymm2
vmovdqa	0x260(%rsp), %ymm0
vpsubd	%ymm2, %ymm0, %ymm2
vmovdqa	%ymm2, 0x260(%rsp)
addq	$0x40, %rdi
addq	$0x100, %rbx
movq	%rbx, 0x50(%rbp)
subq	$0x8, %rsi
cmpq	$0x8, %rsi
jae	L_a3
testq	%rsi, %rsi
jne	L_1ae0
L_1aba:
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
L_1ae0:
movq	0x50(%rbp), %rbx
movq	0x2a0(%rsp), %r15
movzbl	0x38(%rbp), %r13d
movzbl	0x48(%rbp), %r12d
testq	$0x4, %rsi
je	L_1fed
vbroadcasti128	(%rcx), %ymm0
vbroadcasti128	0x10(%rcx), %ymm1
vmovdqa	%ymm0, %ymm8
vmovdqa	%ymm1, %ymm9
vbroadcasti128	0x240(%rsp), %ymm12
vbroadcasti128	0x260(%rsp), %ymm13
vpunpckldq	%ymm13, %ymm12, %ymm14
vpunpckhdq	%ymm13, %ymm12, %ymm15
vpermq	$0x50, %ymm14, %ymm14
vpermq	$0x50, %ymm15, %ymm15
vbroadcasti128	BLAKE3_BLOCK_LEN(%rip), %ymm12
vpblendd	$0x44, %ymm12, %ymm14, %ymm14
vpblendd	$0x44, %ymm12, %ymm15, %ymm15
vmovdqa	%ymm14, (%rsp)
vmovdqa	%ymm15, 0x20(%rsp)
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movq	0x10(%rdi), %r10
movq	0x18(%rdi), %r11
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
nopl	(%rax,%rax)
L_1b80:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movl	%eax, 0x200(%rsp)
vmovups	-0x40(%r8,%rdx), %ymm2
vinsertf128	$0x1, -0x40(%r9,%rdx), %ymm2, %ymm2
vmovups	-0x30(%r8,%rdx), %ymm3
vinsertf128	$0x1, -0x30(%r9,%rdx), %ymm3, %ymm3
vshufps	$0x88, %ymm3, %ymm2, %ymm4
vshufps	$0xdd, %ymm3, %ymm2, %ymm5
vmovups	-0x20(%r8,%rdx), %ymm2
vinsertf128	$0x1, -0x20(%r9,%rdx), %ymm2, %ymm2
vmovups	-0x10(%r8,%rdx), %ymm3
vinsertf128	$0x1, -0x10(%r9,%rdx), %ymm3, %ymm3
vshufps	$0x88, %ymm3, %ymm2, %ymm6
vshufps	$0xdd, %ymm3, %ymm2, %ymm7
vpshufd	$0x93, %ymm6, %ymm6
vpshufd	$0x93, %ymm7, %ymm7
vmovups	-0x40(%r10,%rdx), %ymm10
vinsertf128	$0x1, -0x40(%r11,%rdx), %ymm10, %ymm10
vmovups	-0x30(%r10,%rdx), %ymm11
vinsertf128	$0x1, -0x30(%r11,%rdx), %ymm11, %ymm11
vshufps	$0x88, %ymm11, %ymm10, %ymm12
vshufps	$0xdd, %ymm11, %ymm10, %ymm13
vmovups	-0x20(%r10,%rdx), %ymm10
vinsertf128	$0x1, -0x20(%r11,%rdx), %ymm10, %ymm10
vmovups	-0x10(%r10,%rdx), %ymm11
vinsertf128	$0x1, -0x10(%r11,%rdx), %ymm11, %ymm11
vshufps	$0x88, %ymm11, %ymm10, %ymm14
vshufps	$0xdd, %ymm11, %ymm10, %ymm15
vpshufd	$0x93, %ymm14, %ymm14
vpshufd	$0x93, %ymm15, %ymm15
prefetcht0	0x80(%r8,%rdx)
prefetcht0	0x80(%r9,%rdx)
prefetcht0	0x80(%r10,%rdx)
prefetcht0	0x80(%r11,%rdx)
vpbroadcastd	0x200(%rsp), %ymm2
vmovdqa	(%rsp), %ymm3
vmovdqa	0x20(%rsp), %ymm11
vpblendd	$0x88, %ymm2, %ymm3, %ymm3
vpblendd	$0x88, %ymm2, %ymm11, %ymm11
vbroadcasti128	BLAKE3_IV(%rip), %ymm2
vmovdqa	%ymm2, %ymm10
movb	$0x7, %al
L_1ca6:
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm12, %ymm8, %ymm8
vmovdqa	%ymm4, 0x40(%rsp)
nop
vmovdqa	%ymm12, 0x60(%rsp)
nop
vpaddd	%ymm1, %ymm0, %ymm0
vpaddd	%ymm9, %ymm8, %ymm8
vpxor	%ymm0, %ymm3, %ymm3
vpxor	%ymm8, %ymm11, %ymm11
vbroadcasti128	ROT16(%rip), %ymm4
vpshufb	%ymm4, %ymm3, %ymm3
vpshufb	%ymm4, %ymm11, %ymm11
vpaddd	%ymm3, %ymm2, %ymm2
vpaddd	%ymm11, %ymm10, %ymm10
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm10, %ymm9, %ymm9
vpsrld	$0xc, %ymm1, %ymm4
vpslld	$0x14, %ymm1, %ymm1
vpor	%ymm4, %ymm1, %ymm1
vpsrld	$0xc, %ymm9, %ymm4
vpslld	$0x14, %ymm9, %ymm9
vpor	%ymm4, %ymm9, %ymm9
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm13, %ymm8, %ymm8
vpaddd	%ymm1, %ymm0, %ymm0
vpaddd	%ymm9, %ymm8, %ymm8
vmovdqa	%ymm5, 0x80(%rsp)
vmovdqa	%ymm13, 0xa0(%rsp)
vpxor	%ymm0, %ymm3, %ymm3
vpxor	%ymm8, %ymm11, %ymm11
vbroadcasti128	ROT8(%rip), %ymm4
vpshufb	%ymm4, %ymm3, %ymm3
vpshufb	%ymm4, %ymm11, %ymm11
vpaddd	%ymm3, %ymm2, %ymm2
vpaddd	%ymm11, %ymm10, %ymm10
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm10, %ymm9, %ymm9
vpsrld	$0x7, %ymm1, %ymm4
vpslld	$0x19, %ymm1, %ymm1
vpor	%ymm4, %ymm1, %ymm1
vpsrld	$0x7, %ymm9, %ymm4
vpslld	$0x19, %ymm9, %ymm9
vpor	%ymm4, %ymm9, %ymm9
vpshufd	$0x93, %ymm0, %ymm0
vpshufd	$0x93, %ymm8, %ymm8
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x4e, %ymm11, %ymm11
vpshufd	$0x39, %ymm2, %ymm2
vpshufd	$0x39, %ymm10, %ymm10
vpaddd	%ymm6, %ymm0, %ymm0
vpaddd	%ymm14, %ymm8, %ymm8
vpaddd	%ymm1, %ymm0, %ymm0
vpaddd	%ymm9, %ymm8, %ymm8
vpxor	%ymm0, %ymm3, %ymm3
vpxor	%ymm8, %ymm11, %ymm11
vbroadcasti128	ROT16(%rip), %ymm4
vpshufb	%ymm4, %ymm3, %ymm3
vpshufb	%ymm4, %ymm11, %ymm11
vpaddd	%ymm3, %ymm2, %ymm2
vpaddd	%ymm11, %ymm10, %ymm10
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm10, %ymm9, %ymm9
vpsrld	$0xc, %ymm1, %ymm4
vpslld	$0x14, %ymm1, %ymm1
vpor	%ymm4, %ymm1, %ymm1
vpsrld	$0xc, %ymm9, %ymm4
vpslld	$0x14, %ymm9, %ymm9
vpor	%ymm4, %ymm9, %ymm9
vpaddd	%ymm7, %ymm0, %ymm0
vpaddd	%ymm15, %ymm8, %ymm8
vpaddd	%ymm1, %ymm0, %ymm0
vpaddd	%ymm9, %ymm8, %ymm8
vpxor	%ymm0, %ymm3, %ymm3
vpxor	%ymm8, %ymm11, %ymm11
vbroadcasti128	ROT8(%rip), %ymm4
vpshufb	%ymm4, %ymm3, %ymm3
vpshufb	%ymm4, %ymm11, %ymm11
vpaddd	%ymm3, %ymm2, %ymm2
vpaddd	%ymm11, %ymm10, %ymm10
vpxor	%ymm2, %ymm1, %ymm1
vpxor	%ymm10, %ymm9, %ymm9
vpsrld	$0x7, %ymm1, %ymm4
vpslld	$0x19, %ymm1, %ymm1
vpor	%ymm4, %ymm1, %ymm1
vpsrld	$0x7, %ymm9, %ymm4
vpslld	$0x19, %ymm9, %ymm9
vpor	%ymm4, %ymm9, %ymm9
vpshufd	$0x39, %ymm0, %ymm0
vpshufd	$0x39, %ymm8, %ymm8
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x4e, %ymm11, %ymm11
vpshufd	$0x93, %ymm2, %ymm2
vpshufd	$0x93, %ymm10, %ymm10
decb	%al
je	L_1f46
vmovdqa	0x40(%rsp), %ymm4
vmovdqa	0x80(%rsp), %ymm5
vshufps	$0xd6, %ymm5, %ymm4, %ymm12
vpshufd	$0xf, %ymm4, %ymm13
vpshufd	$0x39, %ymm12, %ymm4
vshufps	$0xfa, %ymm7, %ymm6, %ymm12
vpblendd	$0xaa, %ymm12, %ymm13, %ymm13
vpunpcklqdq	%ymm5, %ymm7, %ymm12
vpblendd	$0x88, %ymm6, %ymm12, %ymm12
vpshufd	$0x78, %ymm12, %ymm12
vpunpckhdq	%ymm7, %ymm5, %ymm5
vpunpckldq	%ymm5, %ymm6, %ymm6
vpshufd	$0x1e, %ymm6, %ymm7
vmovdqa	%ymm13, 0x40(%rsp)
vmovdqa	%ymm12, 0x80(%rsp)
vmovdqa	0x60(%rsp), %ymm12
vmovdqa	0xa0(%rsp), %ymm13
vshufps	$0xd6, %ymm13, %ymm12, %ymm5
vpshufd	$0xf, %ymm12, %ymm6
vpshufd	$0x39, %ymm5, %ymm12
vshufps	$0xfa, %ymm15, %ymm14, %ymm5
vpblendd	$0xaa, %ymm5, %ymm6, %ymm6
vpunpcklqdq	%ymm13, %ymm15, %ymm5
vpblendd	$0x88, %ymm14, %ymm5, %ymm5
vpshufd	$0x78, %ymm5, %ymm5
vpunpckhdq	%ymm15, %ymm13, %ymm13
vpunpckldq	%ymm13, %ymm14, %ymm14
vpshufd	$0x1e, %ymm14, %ymm15
vmovdqa	%ymm6, %ymm13
vmovdqa	%ymm5, %ymm14
vmovdqa	0x40(%rsp), %ymm5
vmovdqa	0x80(%rsp), %ymm6
jmp	L_1ca6
L_1f46:
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm3, %ymm1, %ymm1
vpxor	%ymm10, %ymm8, %ymm8
vpxor	%ymm11, %ymm9, %ymm9
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_1b80
vmovdqu	%xmm0, (%rbx)
vmovdqu	%xmm1, 0x10(%rbx)
vextracti128	$0x1, %ymm0, 0x20(%rbx)
vextracti128	$0x1, %ymm1, 0x30(%rbx)
vmovdqu	%xmm8, 0x40(%rbx)
vmovdqu	%xmm9, 0x50(%rbx)
vextracti128	$0x1, %ymm8, 0x60(%rbx)
vextracti128	$0x1, %ymm9, 0x70(%rbx)
vmovaps	0x280(%rsp), %xmm8
vmovaps	0x240(%rsp), %xmm0
vmovaps	0x250(%rsp), %xmm1
vmovaps	0x260(%rsp), %xmm2
vmovaps	0x270(%rsp), %xmm3
vblendvps	%xmm8, %xmm1, %xmm0, %xmm0
vblendvps	%xmm8, %xmm3, %xmm2, %xmm2
vmovaps	%xmm0, 0x240(%rsp)
vmovaps	%xmm2, 0x260(%rsp)
addq	$0x80, %rbx
addq	$0x20, %rdi
subq	$0x4, %rsi
L_1fed:
testq	$0x2, %rsi
je	L_2296
vbroadcasti128	(%rcx), %ymm0
vbroadcasti128	0x10(%rcx), %ymm1
vmovd	0x240(%rsp), %xmm13
vpinsrd	$0x1, 0x260(%rsp), %xmm13, %xmm13
vpinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm13, %xmm13
vmovd	0x244(%rsp), %xmm14
vpinsrd	$0x1, 0x264(%rsp), %xmm14, %xmm14
vpinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm14, %xmm14
vinserti128	$0x1, %xmm14, %ymm13, %ymm13
vbroadcasti128	ROT16(%rip), %ymm14
vbroadcasti128	ROT8(%rip), %ymm15
movq	(%rdi), %r8
movq	0x8(%rdi), %r9
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2080:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
movl	%eax, 0x200(%rsp)
vbroadcasti128	BLAKE3_IV(%rip), %ymm2
vpbroadcastd	0x200(%rsp), %ymm8
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
L_2111:
vpaddd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxor	%ymm0, %ymm3, %ymm3
vpshufb	%ymm14, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm1, %ymm1
vpsrld	$0xc, %ymm1, %ymm8
vpslld	$0x14, %ymm1, %ymm1
vpor	%ymm1, %ymm8, %ymm1
vpaddd	%ymm5, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxor	%ymm0, %ymm3, %ymm3
vpshufb	%ymm15, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm1, %ymm1
vpsrld	$0x7, %ymm1, %ymm8
vpslld	$0x19, %ymm1, %ymm1
vpor	%ymm1, %ymm8, %ymm1
vpshufd	$0x93, %ymm0, %ymm0
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x39, %ymm2, %ymm2
vpaddd	%ymm6, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxor	%ymm0, %ymm3, %ymm3
vpshufb	%ymm14, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm1, %ymm1
vpsrld	$0xc, %ymm1, %ymm8
vpslld	$0x14, %ymm1, %ymm1
vpor	%ymm1, %ymm8, %ymm1
vpaddd	%ymm7, %ymm0, %ymm0
vpaddd	%ymm1, %ymm0, %ymm0
vpxor	%ymm0, %ymm3, %ymm3
vpshufb	%ymm15, %ymm3, %ymm3
vpaddd	%ymm3, %ymm2, %ymm2
vpxor	%ymm2, %ymm1, %ymm1
vpsrld	$0x7, %ymm1, %ymm8
vpslld	$0x19, %ymm1, %ymm1
vpor	%ymm1, %ymm8, %ymm1
vpshufd	$0x39, %ymm0, %ymm0
vpshufd	$0x4e, %ymm3, %ymm3
vpshufd	$0x93, %ymm2, %ymm2
decb	%al
je	L_2214
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
jmp	L_2111
L_2214:
vpxor	%ymm2, %ymm0, %ymm0
vpxor	%ymm3, %ymm1, %ymm1
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_2080
vmovdqu	%xmm0, (%rbx)
vmovdqu	%xmm1, 0x10(%rbx)
vextracti128	$0x1, %ymm0, 0x20(%rbx)
vextracti128	$0x1, %ymm1, 0x30(%rbx)
vmovaps	0x280(%rsp), %ymm8
vmovaps	0x240(%rsp), %ymm0
vmovups	0x248(%rsp), %ymm1
vmovaps	0x260(%rsp), %ymm2
vmovups	0x268(%rsp), %ymm3
vblendvps	%ymm8, %ymm1, %ymm0, %ymm0
vblendvps	%ymm8, %ymm3, %ymm2, %ymm2
vmovaps	%ymm0, 0x240(%rsp)
vmovaps	%ymm2, 0x260(%rsp)
addq	$0x40, %rbx
addq	$0x10, %rdi
subq	$0x2, %rsi
L_2296:
testq	$0x1, %rsi
je	L_1aba
vmovdqu	(%rcx), %xmm0
vmovdqu	0x10(%rcx), %xmm1
vmovd	0x240(%rsp), %xmm3
vpinsrd	$0x1, 0x260(%rsp), %xmm3, %xmm3
vpinsrd	$0x2, BLAKE3_BLOCK_LEN(%rip), %xmm3, %xmm13
vmovdqa	ROT16(%rip), %xmm14
vmovdqa	ROT8(%rip), %xmm15
movq	(%rdi), %r8
movzbl	0x40(%rbp), %eax
orl	%r13d, %eax
xorl	%edx, %edx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_2300:
movl	%eax, %r14d
orl	%r12d, %eax
addq	$0x40, %rdx
cmpq	%r15, %rdx
cmovnel	%r14d, %eax
vmovdqa	BLAKE3_IV(%rip), %xmm2
vmovdqa	%xmm13, %xmm3
vpinsrd	$0x3, %eax, %xmm3, %xmm3
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
L_2363:
vpaddd	%xmm4, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxor	%xmm0, %xmm3, %xmm3
vpshufb	%xmm14, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm1, %xmm1
vpsrld	$0xc, %xmm1, %xmm8
vpslld	$0x14, %xmm1, %xmm1
vpor	%xmm1, %xmm8, %xmm1
vpaddd	%xmm5, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxor	%xmm0, %xmm3, %xmm3
vpshufb	%xmm15, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm1, %xmm1
vpsrld	$0x7, %xmm1, %xmm8
vpslld	$0x19, %xmm1, %xmm1
vpor	%xmm1, %xmm8, %xmm1
vpshufd	$0x93, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x39, %xmm2, %xmm2
vpaddd	%xmm6, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxor	%xmm0, %xmm3, %xmm3
vpshufb	%xmm14, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm1, %xmm1
vpsrld	$0xc, %xmm1, %xmm8
vpslld	$0x14, %xmm1, %xmm1
vpor	%xmm1, %xmm8, %xmm1
vpaddd	%xmm7, %xmm0, %xmm0
vpaddd	%xmm1, %xmm0, %xmm0
vpxor	%xmm0, %xmm3, %xmm3
vpshufb	%xmm15, %xmm3, %xmm3
vpaddd	%xmm3, %xmm2, %xmm2
vpxor	%xmm2, %xmm1, %xmm1
vpsrld	$0x7, %xmm1, %xmm8
vpslld	$0x19, %xmm1, %xmm1
vpor	%xmm1, %xmm8, %xmm1
vpshufd	$0x39, %xmm0, %xmm0
vpshufd	$0x4e, %xmm3, %xmm3
vpshufd	$0x93, %xmm2, %xmm2
decb	%al
je	L_2466
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
jmp	L_2363
L_2466:
vpxor	%xmm2, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
movl	%r13d, %eax
cmpq	%r15, %rdx
jne	L_2300
vmovdqu	%xmm0, (%rbx)
vmovdqu	%xmm1, 0x10(%rbx)
jmp	L_1aba
	.section .rodata
ADD0:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
ADD1:
	.byte 8,0,0,0,8,0,0,0,8,0,0,0,8,0,0,0
	.byte 8,0,0,0,8,0,0,0,8,0,0,0,8,0,0,0
BLAKE3_IV_0:
	.byte 103,230,9,106,103,230,9,106,103,230,9,106,103,230,9,106
	.byte 103,230,9,106,103,230,9,106,103,230,9,106,103,230,9,106
BLAKE3_IV_1:
	.byte 133,174,103,187,133,174,103,187,133,174,103,187,133,174,103,187
	.byte 133,174,103,187,133,174,103,187,133,174,103,187,133,174,103,187
BLAKE3_IV_2:
	.byte 114,243,110,60,114,243,110,60,114,243,110,60,114,243,110,60
	.byte 114,243,110,60,114,243,110,60,114,243,110,60,114,243,110,60
BLAKE3_IV_3:
	.byte 58,245,79,165,58,245,79,165,58,245,79,165,58,245,79,165
	.byte 58,245,79,165,58,245,79,165,58,245,79,165,58,245,79,165
BLAKE3_BLOCK_LEN:
	.byte 64,0,0,0,64,0,0,0,64,0,0,0,64,0,0,0
	.byte 64,0,0,0,64,0,0,0,64,0,0,0,64,0,0,0
ROT16:
	.byte 2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13
ROT8:
	.byte 1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12
CMP_MSB_MASK:
	.byte 0,0,0,128,0,0,0,128,0,0,0,128,0,0,0,128
	.byte 0,0,0,128,0,0,0,128,0,0,0,128,0,0,0,128
BLAKE3_IV:
	.byte 103,230,9,106,133,174,103,187,114,243,110,60,58,245,79,165

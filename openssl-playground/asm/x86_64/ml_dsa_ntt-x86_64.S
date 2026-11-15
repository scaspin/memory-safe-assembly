	.text
ml_dsa_ntt_avx2_capable:
movq	OPENSSL_ia32cap_P+8(%rip), %rcx
xorl	%eax, %eax
andl	$0x20, %ecx
cmovnel	%ecx, %eax
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
ml_dsa_poly_ntt_mult_avx2:
vpbroadcastq	ml_dsa_q_neg_inv(%rip), %ymm14
vpbroadcastd	ml_dsa_q(%rip), %ymm15
xorl	%r10d, %r10d
nopw	%cs:(%rax,%rax)
nop
L_40:
vmovdqu	(%rdi,%r10), %ymm0
vmovdqu	(%rsi,%r10), %ymm1
vpmuludq	%ymm0, %ymm1, %ymm8
vmovshdup	%ymm0, %ymm9
vmovshdup	%ymm1, %ymm10
vpmuludq	%ymm9, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm8, %ymm0
vpmuludq	%ymm14, %ymm9, %ymm10
vpmuludq	%ymm0, %ymm15, %ymm0
vpmuludq	%ymm10, %ymm15, %ymm10
vpaddq	%ymm0, %ymm8, %ymm0
vpaddq	%ymm10, %ymm9, %ymm9
vmovshdup	%ymm0, %ymm0
vpblendd	$0xaa, %ymm9, %ymm0, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpandn	%ymm15, %ymm8, %ymm8
vpsubd	%ymm8, %ymm0, %ymm0
vmovdqu	%ymm0, (%rdx,%r10)
addl	$0x20, %r10d
cmpl	$0x400, %r10d
jb	L_40
vzeroall
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
ml_dsa_poly_ntt_avx2:
movq	%rsi, %r11
vpbroadcastq	ml_dsa_q_neg_inv(%rip), %ymm14
vpbroadcastd	ml_dsa_q(%rip), %ymm15
vmovdqu	(%rdi), %ymm0
vmovdqu	0x80(%rdi), %ymm1
vmovdqu	0x100(%rdi), %ymm2
vmovdqu	0x180(%rdi), %ymm3
vmovdqu	0x200(%rdi), %ymm4
vmovdqu	0x280(%rdi), %ymm5
vmovdqu	0x300(%rdi), %ymm6
vmovdqu	0x380(%rdi), %ymm7
vpbroadcastd	0x4(%r11), %ymm13
vpmuludq	%ymm4, %ymm13, %ymm9
vmovshdup	%ymm4, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm4
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm5, %ymm5
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm3, %ymm8, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm3, %ymm3
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x8(%r11), %ymm13
vpmuludq	%ymm2, %ymm13, %ymm9
vmovshdup	%ymm2, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm2
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0xc(%r11), %ymm13
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm5, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm5, %ymm8, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm5, %ymm5
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x10(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm9
vmovshdup	%ymm1, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm1
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm1, %ymm1
vpbroadcastd	0x14(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0x18(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm5, %ymm5
vpbroadcastd	0x1c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm6, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm6, %ymm8, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm6, %ymm6
vpsubd	%ymm9, %ymm7, %ymm7
vmovdqu	%ymm0, (%rdi)
vmovdqu	%ymm1, 0x80(%rdi)
vmovdqu	%ymm2, 0x100(%rdi)
vmovdqu	%ymm3, 0x180(%rdi)
vmovdqu	%ymm4, 0x200(%rdi)
vmovdqu	%ymm5, 0x280(%rdi)
vmovdqu	%ymm6, 0x300(%rdi)
vmovdqu	%ymm7, 0x380(%rdi)
vmovdqu	0x20(%rdi), %ymm0
vmovdqu	0xa0(%rdi), %ymm1
vmovdqu	0x120(%rdi), %ymm2
vmovdqu	0x1a0(%rdi), %ymm3
vmovdqu	0x220(%rdi), %ymm4
vmovdqu	0x2a0(%rdi), %ymm5
vmovdqu	0x320(%rdi), %ymm6
vmovdqu	0x3a0(%rdi), %ymm7
vpbroadcastd	0x4(%r11), %ymm13
vpmuludq	%ymm4, %ymm13, %ymm9
vmovshdup	%ymm4, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm4
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm5, %ymm5
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm3, %ymm8, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm3, %ymm3
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x8(%r11), %ymm13
vpmuludq	%ymm2, %ymm13, %ymm9
vmovshdup	%ymm2, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm2
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0xc(%r11), %ymm13
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm5, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm5, %ymm8, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm5, %ymm5
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x10(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm9
vmovshdup	%ymm1, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm1
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm1, %ymm1
vpbroadcastd	0x14(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0x18(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm5, %ymm5
vpbroadcastd	0x1c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm6, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm6, %ymm8, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm6, %ymm6
vpsubd	%ymm9, %ymm7, %ymm7
vmovdqu	%ymm0, 0x20(%rdi)
vmovdqu	%ymm1, 0xa0(%rdi)
vmovdqu	%ymm2, 0x120(%rdi)
vmovdqu	%ymm3, 0x1a0(%rdi)
vmovdqu	%ymm4, 0x220(%rdi)
vmovdqu	%ymm5, 0x2a0(%rdi)
vmovdqu	%ymm6, 0x320(%rdi)
vmovdqu	%ymm7, 0x3a0(%rdi)
vmovdqu	0x40(%rdi), %ymm0
vmovdqu	0xc0(%rdi), %ymm1
vmovdqu	0x140(%rdi), %ymm2
vmovdqu	0x1c0(%rdi), %ymm3
vmovdqu	0x240(%rdi), %ymm4
vmovdqu	0x2c0(%rdi), %ymm5
vmovdqu	0x340(%rdi), %ymm6
vmovdqu	0x3c0(%rdi), %ymm7
vpbroadcastd	0x4(%r11), %ymm13
vpmuludq	%ymm4, %ymm13, %ymm9
vmovshdup	%ymm4, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm4
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm5, %ymm5
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm3, %ymm8, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm3, %ymm3
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x8(%r11), %ymm13
vpmuludq	%ymm2, %ymm13, %ymm9
vmovshdup	%ymm2, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm2
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0xc(%r11), %ymm13
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm5, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm5, %ymm8, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm5, %ymm5
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x10(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm9
vmovshdup	%ymm1, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm1
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm1, %ymm1
vpbroadcastd	0x14(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0x18(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm5, %ymm5
vpbroadcastd	0x1c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm6, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm6, %ymm8, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm6, %ymm6
vpsubd	%ymm9, %ymm7, %ymm7
vmovdqu	%ymm0, 0x40(%rdi)
vmovdqu	%ymm1, 0xc0(%rdi)
vmovdqu	%ymm2, 0x140(%rdi)
vmovdqu	%ymm3, 0x1c0(%rdi)
vmovdqu	%ymm4, 0x240(%rdi)
vmovdqu	%ymm5, 0x2c0(%rdi)
vmovdqu	%ymm6, 0x340(%rdi)
vmovdqu	%ymm7, 0x3c0(%rdi)
vmovdqu	0x60(%rdi), %ymm0
vmovdqu	0xe0(%rdi), %ymm1
vmovdqu	0x160(%rdi), %ymm2
vmovdqu	0x1e0(%rdi), %ymm3
vmovdqu	0x260(%rdi), %ymm4
vmovdqu	0x2e0(%rdi), %ymm5
vmovdqu	0x360(%rdi), %ymm6
vmovdqu	0x3e0(%rdi), %ymm7
vpbroadcastd	0x4(%r11), %ymm13
vpmuludq	%ymm4, %ymm13, %ymm9
vmovshdup	%ymm4, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm4
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm5, %ymm5
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm3, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm3, %ymm8, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm3, %ymm3
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x8(%r11), %ymm13
vpmuludq	%ymm2, %ymm13, %ymm9
vmovshdup	%ymm2, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm2
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm1, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm1, %ymm8, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm1, %ymm1
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0xc(%r11), %ymm13
vpmuludq	%ymm6, %ymm13, %ymm9
vmovshdup	%ymm6, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm6
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm5, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm5, %ymm8, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm5, %ymm5
vpsubd	%ymm9, %ymm7, %ymm7
vpbroadcastd	0x10(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm9
vmovshdup	%ymm1, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm0, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm1
vpaddd	%ymm0, %ymm8, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm8
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm0, %ymm0
vpsubd	%ymm9, %ymm1, %ymm1
vpbroadcastd	0x14(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm9
vmovshdup	%ymm3, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm2, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm3
vpaddd	%ymm2, %ymm8, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm8
vpcmpgtd	%ymm3, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm2, %ymm2
vpsubd	%ymm9, %ymm3, %ymm3
vpbroadcastd	0x18(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm9
vmovshdup	%ymm5, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm4, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm5
vpaddd	%ymm4, %ymm8, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm8
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm4, %ymm4
vpsubd	%ymm9, %ymm5, %ymm5
vpbroadcastd	0x1c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm9
vmovshdup	%ymm7, %ymm10
vpmuludq	%ymm10, %ymm13, %ymm10
vpmuludq	%ymm14, %ymm9, %ymm8
vpmuludq	%ymm14, %ymm10, %ymm11
vpmuludq	%ymm8, %ymm15, %ymm8
vpmuludq	%ymm11, %ymm15, %ymm11
vpaddq	%ymm8, %ymm9, %ymm8
vpaddq	%ymm11, %ymm10, %ymm10
vmovshdup	%ymm8, %ymm8
vpblendd	$0xaa, %ymm10, %ymm8, %ymm8
vpcmpgtd	%ymm8, %ymm15, %ymm9
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm9, %ymm8, %ymm8
vpaddd	%ymm6, %ymm15, %ymm9
vpsubd	%ymm8, %ymm9, %ymm7
vpaddd	%ymm6, %ymm8, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm8
vpcmpgtd	%ymm7, %ymm15, %ymm9
vpandn	%ymm15, %ymm8, %ymm8
vpandn	%ymm15, %ymm9, %ymm9
vpsubd	%ymm8, %ymm6, %ymm6
vpsubd	%ymm9, %ymm7, %ymm7
vmovdqu	%ymm0, 0x60(%rdi)
vmovdqu	%ymm1, 0xe0(%rdi)
vmovdqu	%ymm2, 0x160(%rdi)
vmovdqu	%ymm3, 0x1e0(%rdi)
vmovdqu	%ymm4, 0x260(%rdi)
vmovdqu	%ymm5, 0x2e0(%rdi)
vmovdqu	%ymm6, 0x360(%rdi)
vmovdqu	%ymm7, 0x3e0(%rdi)
vpbroadcastd	0x20(%r11), %ymm13
vmovdqu	(%rdi), %ymm0
vmovdqu	0x20(%rdi), %ymm1
vmovdqu	0x40(%rdi), %ymm2
vmovdqu	0x60(%rdi), %ymm3
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm2
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm1, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm1, %ymm9, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm1, %ymm1
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x24(%r11), %ymm13
vmovdqu	0x80(%rdi), %ymm4
vmovdqu	0xa0(%rdi), %ymm5
vmovdqu	0xc0(%rdi), %ymm6
vmovdqu	0xe0(%rdi), %ymm7
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm6
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm5, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm5, %ymm9, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm5, %ymm5
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x40(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x44(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x48(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x4c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x80(%r11), %ymm13
vpbroadcastd	0x84(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x88(%r11), %ymm13
vpbroadcastd	0x8c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x90(%r11), %ymm13
vpbroadcastd	0x94(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x98(%r11), %ymm13
vpbroadcastd	0x9c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	0x100(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm1, %ymm0, %ymm8
vpunpckhqdq	%ymm1, %ymm0, %ymm1
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x110(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm3, %ymm2, %ymm8
vpunpckhqdq	%ymm3, %ymm2, %ymm3
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x120(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm5, %ymm4, %ymm8
vpunpckhqdq	%ymm5, %ymm4, %ymm5
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x130(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm7, %ymm6, %ymm8
vpunpckhqdq	%ymm7, %ymm6, %ymm7
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vmovdqu	0x200(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x220(%r11), %ymm13
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x240(%r11), %ymm13
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x260(%r11), %ymm13
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, (%rdi)
vmovdqu	%ymm11, 0x20(%rdi)
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x40(%rdi)
vmovdqu	%ymm11, 0x60(%rdi)
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x80(%rdi)
vmovdqu	%ymm11, 0xa0(%rdi)
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0xc0(%rdi)
vmovdqu	%ymm11, 0xe0(%rdi)
vpbroadcastd	0x28(%r11), %ymm13
vmovdqu	0x100(%rdi), %ymm0
vmovdqu	0x120(%rdi), %ymm1
vmovdqu	0x140(%rdi), %ymm2
vmovdqu	0x160(%rdi), %ymm3
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm2
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm1, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm1, %ymm9, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm1, %ymm1
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x2c(%r11), %ymm13
vmovdqu	0x180(%rdi), %ymm4
vmovdqu	0x1a0(%rdi), %ymm5
vmovdqu	0x1c0(%rdi), %ymm6
vmovdqu	0x1e0(%rdi), %ymm7
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm6
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm5, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm5, %ymm9, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm5, %ymm5
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x50(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x54(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x58(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x5c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0xa0(%r11), %ymm13
vpbroadcastd	0xa4(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0xa8(%r11), %ymm13
vpbroadcastd	0xac(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0xb0(%r11), %ymm13
vpbroadcastd	0xb4(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0xb8(%r11), %ymm13
vpbroadcastd	0xbc(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	0x140(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm1, %ymm0, %ymm8
vpunpckhqdq	%ymm1, %ymm0, %ymm1
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x150(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm3, %ymm2, %ymm8
vpunpckhqdq	%ymm3, %ymm2, %ymm3
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x160(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm5, %ymm4, %ymm8
vpunpckhqdq	%ymm5, %ymm4, %ymm5
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x170(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm7, %ymm6, %ymm8
vpunpckhqdq	%ymm7, %ymm6, %ymm7
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vmovdqu	0x280(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x2a0(%r11), %ymm13
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x2c0(%r11), %ymm13
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x2e0(%r11), %ymm13
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x100(%rdi)
vmovdqu	%ymm11, 0x120(%rdi)
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x140(%rdi)
vmovdqu	%ymm11, 0x160(%rdi)
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x180(%rdi)
vmovdqu	%ymm11, 0x1a0(%rdi)
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x1c0(%rdi)
vmovdqu	%ymm11, 0x1e0(%rdi)
vpbroadcastd	0x30(%r11), %ymm13
vmovdqu	0x200(%rdi), %ymm0
vmovdqu	0x220(%rdi), %ymm1
vmovdqu	0x240(%rdi), %ymm2
vmovdqu	0x260(%rdi), %ymm3
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm2
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm1, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm1, %ymm9, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm1, %ymm1
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x34(%r11), %ymm13
vmovdqu	0x280(%rdi), %ymm4
vmovdqu	0x2a0(%rdi), %ymm5
vmovdqu	0x2c0(%rdi), %ymm6
vmovdqu	0x2e0(%rdi), %ymm7
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm6
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm5, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm5, %ymm9, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm5, %ymm5
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x60(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x64(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x68(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x6c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0xc0(%r11), %ymm13
vpbroadcastd	0xc4(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0xc8(%r11), %ymm13
vpbroadcastd	0xcc(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0xd0(%r11), %ymm13
vpbroadcastd	0xd4(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0xd8(%r11), %ymm13
vpbroadcastd	0xdc(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	0x180(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm1, %ymm0, %ymm8
vpunpckhqdq	%ymm1, %ymm0, %ymm1
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x190(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm3, %ymm2, %ymm8
vpunpckhqdq	%ymm3, %ymm2, %ymm3
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x1a0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm5, %ymm4, %ymm8
vpunpckhqdq	%ymm5, %ymm4, %ymm5
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x1b0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm7, %ymm6, %ymm8
vpunpckhqdq	%ymm7, %ymm6, %ymm7
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vmovdqu	0x300(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x320(%r11), %ymm13
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x340(%r11), %ymm13
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x360(%r11), %ymm13
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x200(%rdi)
vmovdqu	%ymm11, 0x220(%rdi)
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x240(%rdi)
vmovdqu	%ymm11, 0x260(%rdi)
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x280(%rdi)
vmovdqu	%ymm11, 0x2a0(%rdi)
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x2c0(%rdi)
vmovdqu	%ymm11, 0x2e0(%rdi)
vpbroadcastd	0x38(%r11), %ymm13
vmovdqu	0x300(%rdi), %ymm0
vmovdqu	0x320(%rdi), %ymm1
vmovdqu	0x340(%rdi), %ymm2
vmovdqu	0x360(%rdi), %ymm3
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm2
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm1, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm1, %ymm9, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm1, %ymm1
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3c(%r11), %ymm13
vmovdqu	0x380(%rdi), %ymm4
vmovdqu	0x3a0(%rdi), %ymm5
vmovdqu	0x3c0(%rdi), %ymm6
vmovdqu	0x3e0(%rdi), %ymm7
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm6
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm5, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm5, %ymm9, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm5, %ymm5
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x70(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x74(%r11), %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x78(%r11), %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x7c(%r11), %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0xe0(%r11), %ymm13
vpbroadcastd	0xe4(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0xe8(%r11), %ymm13
vpbroadcastd	0xec(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0xf0(%r11), %ymm13
vpbroadcastd	0xf4(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0xf8(%r11), %ymm13
vpbroadcastd	0xfc(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	0x1c0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm1, %ymm0, %ymm8
vpunpckhqdq	%ymm1, %ymm0, %ymm1
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm8, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x1d0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm3, %ymm2, %ymm8
vpunpckhqdq	%ymm3, %ymm2, %ymm3
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm8, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x1e0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm5, %ymm4, %ymm8
vpunpckhqdq	%ymm5, %ymm4, %ymm5
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm8, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x1f0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpunpcklqdq	%ymm7, %ymm6, %ymm8
vpunpckhqdq	%ymm7, %ymm6, %ymm7
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm15, %ymm8, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm8, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vmovdqu	0x380(%r11), %ymm13
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm0, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm1
vpaddd	%ymm0, %ymm9, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm9
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm0, %ymm0
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x3a0(%r11), %ymm13
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm2, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm3
vpaddd	%ymm2, %ymm9, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm9
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm2, %ymm2
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x3c0(%r11), %ymm13
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm4, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm5
vpaddd	%ymm4, %ymm9, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm9
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm4, %ymm4
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x3e0(%r11), %ymm13
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm9
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm9, %ymm15, %ymm9
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm9, %ymm10, %ymm9
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm9, %ymm9
vpblendd	$0xaa, %ymm11, %ymm9, %ymm9
vpcmpgtd	%ymm9, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm9, %ymm9
vpaddd	%ymm6, %ymm15, %ymm10
vpsubd	%ymm9, %ymm10, %ymm7
vpaddd	%ymm6, %ymm9, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm9
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm9, %ymm9
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm9, %ymm6, %ymm6
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x300(%rdi)
vmovdqu	%ymm11, 0x320(%rdi)
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x340(%rdi)
vmovdqu	%ymm11, 0x360(%rdi)
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x380(%rdi)
vmovdqu	%ymm11, 0x3a0(%rdi)
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vperm2i128	$0x20, %ymm9, %ymm8, %ymm10
vperm2i128	$0x31, %ymm9, %ymm8, %ymm11
vmovdqu	%ymm10, 0x3c0(%rdi)
vmovdqu	%ymm11, 0x3e0(%rdi)
vzeroall
rep	retq
nop
ml_dsa_poly_ntt_inverse_avx2:
leaq	zetas_inverse(%rip), %r11
vpbroadcastq	ml_dsa_q_neg_inv(%rip), %ymm14
vpbroadcastd	ml_dsa_q(%rip), %ymm15
vmovdqu	(%rdi), %ymm8
vmovdqu	0x20(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm0
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm1
vmovdqu	(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x40(%rdi), %ymm8
vmovdqu	0x60(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm2
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm3
vmovdqu	0x20(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x80(%rdi), %ymm8
vmovdqu	0xa0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm4
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm5
vmovdqu	0x40(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0xc0(%rdi), %ymm8
vmovdqu	0xe0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm6
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm7
vmovdqu	0x60(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vmovdqu	0x200(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vmovdqu	0x210(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vmovdqu	0x220(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vmovdqu	0x230(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vshufps	$0x44, %ymm1, %ymm0, %ymm8
vshufps	$0xee, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x300(%r11), %ymm13
vpbroadcastd	0x304(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vshufps	$0x44, %ymm3, %ymm2, %ymm8
vshufps	$0xee, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x308(%r11), %ymm13
vpbroadcastd	0x30c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vshufps	$0x44, %ymm5, %ymm4, %ymm8
vshufps	$0xee, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x310(%r11), %ymm13
vpbroadcastd	0x314(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vshufps	$0x44, %ymm7, %ymm6, %ymm8
vshufps	$0xee, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x318(%r11), %ymm13
vpbroadcastd	0x31c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x380(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x384(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x388(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x38c(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3c0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3c4(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, (%rdi)
vmovdqu	%ymm1, 0x20(%rdi)
vmovdqu	%ymm2, 0x40(%rdi)
vmovdqu	%ymm3, 0x60(%rdi)
vmovdqu	%ymm4, 0x80(%rdi)
vmovdqu	%ymm5, 0xa0(%rdi)
vmovdqu	%ymm6, 0xc0(%rdi)
vmovdqu	%ymm7, 0xe0(%rdi)
vmovdqu	0x100(%rdi), %ymm8
vmovdqu	0x120(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm0
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm1
vmovdqu	0x80(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x140(%rdi), %ymm8
vmovdqu	0x160(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm2
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm3
vmovdqu	0xa0(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x180(%rdi), %ymm8
vmovdqu	0x1a0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm4
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm5
vmovdqu	0xc0(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x1c0(%rdi), %ymm8
vmovdqu	0x1e0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm6
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm7
vmovdqu	0xe0(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vmovdqu	0x240(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vmovdqu	0x250(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vmovdqu	0x260(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vmovdqu	0x270(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vshufps	$0x44, %ymm1, %ymm0, %ymm8
vshufps	$0xee, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x320(%r11), %ymm13
vpbroadcastd	0x324(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vshufps	$0x44, %ymm3, %ymm2, %ymm8
vshufps	$0xee, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x328(%r11), %ymm13
vpbroadcastd	0x32c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vshufps	$0x44, %ymm5, %ymm4, %ymm8
vshufps	$0xee, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x330(%r11), %ymm13
vpbroadcastd	0x334(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vshufps	$0x44, %ymm7, %ymm6, %ymm8
vshufps	$0xee, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x338(%r11), %ymm13
vpbroadcastd	0x33c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x390(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x394(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x398(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x39c(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3c8(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3cc(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, 0x100(%rdi)
vmovdqu	%ymm1, 0x120(%rdi)
vmovdqu	%ymm2, 0x140(%rdi)
vmovdqu	%ymm3, 0x160(%rdi)
vmovdqu	%ymm4, 0x180(%rdi)
vmovdqu	%ymm5, 0x1a0(%rdi)
vmovdqu	%ymm6, 0x1c0(%rdi)
vmovdqu	%ymm7, 0x1e0(%rdi)
vmovdqu	0x200(%rdi), %ymm8
vmovdqu	0x220(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm0
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm1
vmovdqu	0x100(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x240(%rdi), %ymm8
vmovdqu	0x260(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm2
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm3
vmovdqu	0x120(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x280(%rdi), %ymm8
vmovdqu	0x2a0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm4
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm5
vmovdqu	0x140(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x2c0(%rdi), %ymm8
vmovdqu	0x2e0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm6
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm7
vmovdqu	0x160(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vmovdqu	0x280(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vmovdqu	0x290(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vmovdqu	0x2a0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vmovdqu	0x2b0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vshufps	$0x44, %ymm1, %ymm0, %ymm8
vshufps	$0xee, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x340(%r11), %ymm13
vpbroadcastd	0x344(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vshufps	$0x44, %ymm3, %ymm2, %ymm8
vshufps	$0xee, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x348(%r11), %ymm13
vpbroadcastd	0x34c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vshufps	$0x44, %ymm5, %ymm4, %ymm8
vshufps	$0xee, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x350(%r11), %ymm13
vpbroadcastd	0x354(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vshufps	$0x44, %ymm7, %ymm6, %ymm8
vshufps	$0xee, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x358(%r11), %ymm13
vpbroadcastd	0x35c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x3a0(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x3a4(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x3a8(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x3ac(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3d0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3d4(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, 0x200(%rdi)
vmovdqu	%ymm1, 0x220(%rdi)
vmovdqu	%ymm2, 0x240(%rdi)
vmovdqu	%ymm3, 0x260(%rdi)
vmovdqu	%ymm4, 0x280(%rdi)
vmovdqu	%ymm5, 0x2a0(%rdi)
vmovdqu	%ymm6, 0x2c0(%rdi)
vmovdqu	%ymm7, 0x2e0(%rdi)
vmovdqu	0x300(%rdi), %ymm8
vmovdqu	0x320(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm0
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm1
vmovdqu	0x180(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vmovdqu	0x340(%rdi), %ymm8
vmovdqu	0x360(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm2
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm3
vmovdqu	0x1a0(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vmovdqu	0x380(%rdi), %ymm8
vmovdqu	0x3a0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm4
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm5
vmovdqu	0x1c0(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vmovdqu	0x3c0(%rdi), %ymm8
vmovdqu	0x3e0(%rdi), %ymm9
vmovdqa	idx_even(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm6
vmovdqa	idx_odd(%rip), %ymm13
vpermd	%ymm8, %ymm13, %ymm10
vpermd	%ymm9, %ymm13, %ymm11
vpblendd	$0xf0, %ymm11, %ymm10, %ymm7
vmovdqu	0x1e0(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vmovshdup	%ymm13, %ymm12
vpmuludq	%ymm11, %ymm12, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpunpckldq	%ymm1, %ymm0, %ymm8
vpunpckhdq	%ymm1, %ymm0, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm0
vshufps	$0xee, %ymm9, %ymm8, %ymm1
vmovdqu	0x2c0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpunpckldq	%ymm3, %ymm2, %ymm8
vpunpckhdq	%ymm3, %ymm2, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm2
vshufps	$0xee, %ymm9, %ymm8, %ymm3
vmovdqu	0x2d0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpunpckldq	%ymm5, %ymm4, %ymm8
vpunpckhdq	%ymm5, %ymm4, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm4
vshufps	$0xee, %ymm9, %ymm8, %ymm5
vmovdqu	0x2e0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpunpckldq	%ymm7, %ymm6, %ymm8
vpunpckhdq	%ymm7, %ymm6, %ymm9
vshufps	$0x44, %ymm9, %ymm8, %ymm6
vshufps	$0xee, %ymm9, %ymm8, %ymm7
vmovdqu	0x2f0(%r11), %xmm13
vpmovzxdq	%xmm13, %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vshufps	$0x44, %ymm1, %ymm0, %ymm8
vshufps	$0xee, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x360(%r11), %ymm13
vpbroadcastd	0x364(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vshufps	$0x44, %ymm3, %ymm2, %ymm8
vshufps	$0xee, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x368(%r11), %ymm13
vpbroadcastd	0x36c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vshufps	$0x44, %ymm5, %ymm4, %ymm8
vshufps	$0xee, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x370(%r11), %ymm13
vpbroadcastd	0x374(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vshufps	$0x44, %ymm7, %ymm6, %ymm8
vshufps	$0xee, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x378(%r11), %ymm13
vpbroadcastd	0x37c(%r11), %ymm12
vpblendd	$0xf0, %ymm12, %ymm13, %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vperm2i128	$0x20, %ymm1, %ymm0, %ymm8
vperm2i128	$0x31, %ymm1, %ymm0, %ymm1
vpbroadcastd	0x3b0(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm1, %ymm8, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vperm2i128	$0x20, %ymm3, %ymm2, %ymm8
vperm2i128	$0x31, %ymm3, %ymm2, %ymm3
vpbroadcastd	0x3b4(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm3, %ymm8, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vperm2i128	$0x20, %ymm5, %ymm4, %ymm8
vperm2i128	$0x31, %ymm5, %ymm4, %ymm5
vpbroadcastd	0x3b8(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm5, %ymm8, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vperm2i128	$0x20, %ymm7, %ymm6, %ymm8
vperm2i128	$0x31, %ymm7, %ymm6, %ymm7
vpbroadcastd	0x3bc(%r11), %ymm13
vpaddd	%ymm15, %ymm8, %ymm11
vpaddd	%ymm7, %ymm8, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3d8(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3dc(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, 0x300(%rdi)
vmovdqu	%ymm1, 0x320(%rdi)
vmovdqu	%ymm2, 0x340(%rdi)
vmovdqu	%ymm3, 0x360(%rdi)
vmovdqu	%ymm4, 0x380(%rdi)
vmovdqu	%ymm5, 0x3a0(%rdi)
vmovdqu	%ymm6, 0x3c0(%rdi)
vmovdqu	%ymm7, 0x3e0(%rdi)
vmovdqu	(%rdi), %ymm0
vmovdqu	0x80(%rdi), %ymm1
vmovdqu	0x100(%rdi), %ymm2
vmovdqu	0x180(%rdi), %ymm3
vmovdqu	0x200(%rdi), %ymm4
vmovdqu	0x280(%rdi), %ymm5
vmovdqu	0x300(%rdi), %ymm6
vmovdqu	0x380(%rdi), %ymm7
vpbroadcastd	0x3e0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x3e4(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3e8(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x3ec(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3f4(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f8(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm4, %ymm0
vpsubd	%ymm4, %ymm11, %ymm4
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm5, %ymm1
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm6, %ymm2
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm3, %ymm15, %ymm11
vpaddd	%ymm3, %ymm7, %ymm3
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	ml_dsa_inverse_degree_montgomery(%rip), %ymm13
vpmuludq	%ymm0, %ymm13, %ymm10
vmovshdup	%ymm0, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm0
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm0, %ymm15, %ymm0
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm0, %ymm10, %ymm0
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm0, %ymm0
vpblendd	$0xaa, %ymm11, %ymm0, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, (%rdi)
vmovdqu	%ymm1, 0x80(%rdi)
vmovdqu	%ymm2, 0x100(%rdi)
vmovdqu	%ymm3, 0x180(%rdi)
vmovdqu	%ymm4, 0x200(%rdi)
vmovdqu	%ymm5, 0x280(%rdi)
vmovdqu	%ymm6, 0x300(%rdi)
vmovdqu	%ymm7, 0x380(%rdi)
vmovdqu	0x20(%rdi), %ymm0
vmovdqu	0xa0(%rdi), %ymm1
vmovdqu	0x120(%rdi), %ymm2
vmovdqu	0x1a0(%rdi), %ymm3
vmovdqu	0x220(%rdi), %ymm4
vmovdqu	0x2a0(%rdi), %ymm5
vmovdqu	0x320(%rdi), %ymm6
vmovdqu	0x3a0(%rdi), %ymm7
vpbroadcastd	0x3e0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x3e4(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3e8(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x3ec(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3f4(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f8(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm4, %ymm0
vpsubd	%ymm4, %ymm11, %ymm4
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm5, %ymm1
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm6, %ymm2
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm3, %ymm15, %ymm11
vpaddd	%ymm3, %ymm7, %ymm3
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	ml_dsa_inverse_degree_montgomery(%rip), %ymm13
vpmuludq	%ymm0, %ymm13, %ymm10
vmovshdup	%ymm0, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm0
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm0, %ymm15, %ymm0
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm0, %ymm10, %ymm0
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm0, %ymm0
vpblendd	$0xaa, %ymm11, %ymm0, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, 0x20(%rdi)
vmovdqu	%ymm1, 0xa0(%rdi)
vmovdqu	%ymm2, 0x120(%rdi)
vmovdqu	%ymm3, 0x1a0(%rdi)
vmovdqu	%ymm4, 0x220(%rdi)
vmovdqu	%ymm5, 0x2a0(%rdi)
vmovdqu	%ymm6, 0x320(%rdi)
vmovdqu	%ymm7, 0x3a0(%rdi)
vmovdqu	0x40(%rdi), %ymm0
vmovdqu	0xc0(%rdi), %ymm1
vmovdqu	0x140(%rdi), %ymm2
vmovdqu	0x1c0(%rdi), %ymm3
vmovdqu	0x240(%rdi), %ymm4
vmovdqu	0x2c0(%rdi), %ymm5
vmovdqu	0x340(%rdi), %ymm6
vmovdqu	0x3c0(%rdi), %ymm7
vpbroadcastd	0x3e0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x3e4(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3e8(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x3ec(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3f4(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f8(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm4, %ymm0
vpsubd	%ymm4, %ymm11, %ymm4
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm5, %ymm1
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm6, %ymm2
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm3, %ymm15, %ymm11
vpaddd	%ymm3, %ymm7, %ymm3
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	ml_dsa_inverse_degree_montgomery(%rip), %ymm13
vpmuludq	%ymm0, %ymm13, %ymm10
vmovshdup	%ymm0, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm0
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm0, %ymm15, %ymm0
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm0, %ymm10, %ymm0
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm0, %ymm0
vpblendd	$0xaa, %ymm11, %ymm0, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, 0x40(%rdi)
vmovdqu	%ymm1, 0xc0(%rdi)
vmovdqu	%ymm2, 0x140(%rdi)
vmovdqu	%ymm3, 0x1c0(%rdi)
vmovdqu	%ymm4, 0x240(%rdi)
vmovdqu	%ymm5, 0x2c0(%rdi)
vmovdqu	%ymm6, 0x340(%rdi)
vmovdqu	%ymm7, 0x3c0(%rdi)
vmovdqu	0x60(%rdi), %ymm0
vmovdqu	0xe0(%rdi), %ymm1
vmovdqu	0x160(%rdi), %ymm2
vmovdqu	0x1e0(%rdi), %ymm3
vmovdqu	0x260(%rdi), %ymm4
vmovdqu	0x2e0(%rdi), %ymm5
vmovdqu	0x360(%rdi), %ymm6
vmovdqu	0x3e0(%rdi), %ymm7
vpbroadcastd	0x3e0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm1, %ymm0
vpsubd	%ymm1, %ymm11, %ymm1
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpbroadcastd	0x3e4(%r11), %ymm13
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm3, %ymm2
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3e8(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm5, %ymm4
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpbroadcastd	0x3ec(%r11), %ymm13
vpaddd	%ymm6, %ymm15, %ymm11
vpaddd	%ymm6, %ymm7, %ymm6
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f0(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm2, %ymm0
vpsubd	%ymm2, %ymm11, %ymm2
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm3, %ymm1
vpsubd	%ymm3, %ymm11, %ymm3
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpbroadcastd	0x3f4(%r11), %ymm13
vpaddd	%ymm4, %ymm15, %ymm11
vpaddd	%ymm4, %ymm6, %ymm4
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm5, %ymm15, %ymm11
vpaddd	%ymm5, %ymm7, %ymm5
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	0x3f8(%r11), %ymm13
vpaddd	%ymm0, %ymm15, %ymm11
vpaddd	%ymm0, %ymm4, %ymm0
vpsubd	%ymm4, %ymm11, %ymm4
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpaddd	%ymm1, %ymm15, %ymm11
vpaddd	%ymm1, %ymm5, %ymm1
vpsubd	%ymm5, %ymm11, %ymm5
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpaddd	%ymm2, %ymm15, %ymm11
vpaddd	%ymm2, %ymm6, %ymm2
vpsubd	%ymm6, %ymm11, %ymm6
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpaddd	%ymm3, %ymm15, %ymm11
vpaddd	%ymm3, %ymm7, %ymm3
vpsubd	%ymm7, %ymm11, %ymm7
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vpbroadcastd	ml_dsa_inverse_degree_montgomery(%rip), %ymm13
vpmuludq	%ymm0, %ymm13, %ymm10
vmovshdup	%ymm0, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm0
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm0, %ymm15, %ymm0
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm0, %ymm10, %ymm0
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm0, %ymm0
vpblendd	$0xaa, %ymm11, %ymm0, %ymm0
vpcmpgtd	%ymm0, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm0, %ymm0
vpmuludq	%ymm4, %ymm13, %ymm10
vmovshdup	%ymm4, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm4
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm4, %ymm15, %ymm4
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm4, %ymm10, %ymm4
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm4, %ymm4
vpblendd	$0xaa, %ymm11, %ymm4, %ymm4
vpcmpgtd	%ymm4, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm4, %ymm4
vpmuludq	%ymm1, %ymm13, %ymm10
vmovshdup	%ymm1, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm1
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm1, %ymm15, %ymm1
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm1, %ymm10, %ymm1
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm1, %ymm1
vpblendd	$0xaa, %ymm11, %ymm1, %ymm1
vpcmpgtd	%ymm1, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm1, %ymm1
vpmuludq	%ymm5, %ymm13, %ymm10
vmovshdup	%ymm5, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm5
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm5, %ymm15, %ymm5
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm5, %ymm10, %ymm5
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm5, %ymm5
vpblendd	$0xaa, %ymm11, %ymm5, %ymm5
vpcmpgtd	%ymm5, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm5, %ymm5
vpmuludq	%ymm2, %ymm13, %ymm10
vmovshdup	%ymm2, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm2
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm2, %ymm15, %ymm2
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm2, %ymm10, %ymm2
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm2, %ymm2
vpblendd	$0xaa, %ymm11, %ymm2, %ymm2
vpcmpgtd	%ymm2, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm2, %ymm2
vpmuludq	%ymm6, %ymm13, %ymm10
vmovshdup	%ymm6, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm6
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm6, %ymm15, %ymm6
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm6, %ymm10, %ymm6
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm6, %ymm6
vpblendd	$0xaa, %ymm11, %ymm6, %ymm6
vpcmpgtd	%ymm6, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm6, %ymm6
vpmuludq	%ymm3, %ymm13, %ymm10
vmovshdup	%ymm3, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm3
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm3, %ymm15, %ymm3
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm3, %ymm3
vpblendd	$0xaa, %ymm11, %ymm3, %ymm3
vpcmpgtd	%ymm3, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm3, %ymm3
vpmuludq	%ymm7, %ymm13, %ymm10
vmovshdup	%ymm7, %ymm11
vpmuludq	%ymm11, %ymm13, %ymm11
vpmuludq	%ymm14, %ymm10, %ymm7
vpmuludq	%ymm14, %ymm11, %ymm12
vpmuludq	%ymm7, %ymm15, %ymm7
vpmuludq	%ymm12, %ymm15, %ymm12
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm12, %ymm11, %ymm11
vmovshdup	%ymm7, %ymm7
vpblendd	$0xaa, %ymm11, %ymm7, %ymm7
vpcmpgtd	%ymm7, %ymm15, %ymm10
vpandn	%ymm15, %ymm10, %ymm10
vpsubd	%ymm10, %ymm7, %ymm7
vmovdqu	%ymm0, 0x60(%rdi)
vmovdqu	%ymm1, 0xe0(%rdi)
vmovdqu	%ymm2, 0x160(%rdi)
vmovdqu	%ymm3, 0x1e0(%rdi)
vmovdqu	%ymm4, 0x260(%rdi)
vmovdqu	%ymm5, 0x2e0(%rdi)
vmovdqu	%ymm6, 0x360(%rdi)
vmovdqu	%ymm7, 0x3e0(%rdi)
vzeroall
rep	retq
	.section .rodata
zetas_inverse:
	.byte 51,182,97,0,74,233,12,0,153,129,106,0,55,202,67,0
	.byte 33,201,20,0,178,188,0,0,213,16,68,0,176,117,8,0
	.byte 87,26,54,0,215,67,103,0,251,231,14,0,110,19,125,0
	.byte 247,226,34,0,35,108,6,0,81,30,34,0,156,216,44,0
	.byte 37,128,58,0,38,250,3,0,205,217,16,0,104,113,25,0
	.byte 153,185,98,0,82,131,27,0,49,147,101,0,187,130,6,0
	.byte 243,171,120,0,26,170,101,0,12,228,14,0,10,27,94,0
	.byte 65,194,123,0,236,222,68,0,200,26,74,0,196,94,46,0
	.byte 195,115,27,0,153,94,56,0,103,168,102,0,92,131,115,0
	.byte 144,226,81,0,249,53,103,0,229,99,125,0,66,147,48,0
	.byte 89,108,18,0,70,11,125,0,105,119,76,0,105,2,98,0
	.byte 113,131,2,0,74,108,90,0,118,194,90,0,168,185,30,0
	.byte 225,161,57,0,41,207,118,0,238,211,56,0,229,110,39,0
	.byte 169,46,28,0,8,128,25,0,244,53,43,0,204,70,8,0
	.byte 50,231,75,0,25,194,93,0,26,4,116,0,252,251,104,0
	.byte 83,250,20,0,136,218,38,0,104,159,98,0,173,134,19,0
	.byte 146,242,29,0,126,109,77,0,58,217,107,0,28,226,6,0
	.byte 209,210,21,0,194,161,50,0,230,254,108,0,66,87,20,0
	.byte 90,9,16,0,182,212,98,0,194,90,99,0,119,175,45,0
	.byte 112,36,54,0,112,167,87,0,67,203,108,0,232,122,57,0
	.byte 187,133,103,0,176,239,89,0,125,214,108,0,229,254,65,0
	.byte 144,146,108,0,198,133,39,0,104,206,86,0,28,129,84,0
	.byte 221,198,124,0,58,99,101,0,197,255,50,0,26,109,75,0
	.byte 230,47,65,0,191,50,37,0,245,126,123,0,232,166,122,0
	.byte 62,222,54,0,110,186,11,0,42,3,8,0,131,70,54,0
	.byte 123,240,78,0,125,223,96,0,10,165,47,0,223,255,9,0
	.byte 4,249,7,0,252,168,0,0,118,157,24,0,126,80,120,0
	.byte 167,96,115,0,27,255,113,0,231,129,99,0,163,33,114,0
	.byte 34,186,48,0,170,68,18,0,4,93,57,0,96,183,53,0
	.byte 164,68,74,0,16,219,18,0,122,186,90,0,12,205,123,0
	.byte 222,91,54,0,97,84,37,0,6,162,93,0,142,0,51,0
	.byte 9,158,69,0,45,135,92,0,167,224,75,0,110,245,95,0
	.byte 40,72,69,0,169,95,55,0,100,56,59,0,94,17,46,0
	.byte 254,247,21,0,188,102,12,0,32,47,24,0,220,65,108,0
	.byte 111,104,107,0,252,204,107,0,32,181,2,0,109,195,36,0
	.byte 10,64,28,0,63,169,79,0,248,55,54,0,149,251,124,0
	.byte 248,23,20,0,96,71,116,0,33,56,3,0,149,106,91,0
	.byte 64,150,49,0,185,166,102,0,130,33,0,0,54,212,56,0
	.byte 167,120,67,0,189,18,114,0,66,201,16,0,1,51,127,0
	.byte 121,154,80,0,234,27,120,0,17,213,123,0,23,4,51,0
	.byte 158,211,21,0,158,154,99,0,45,74,107,0,35,212,5,0
	.byte 9,246,19,0,197,89,0,0,237,190,18,0,126,61,10,0
	.byte 247,203,37,0,147,69,6,0,181,91,56,0,93,72,45,0
	.byte 98,113,86,0,201,25,95,0,123,1,15,0,15,207,75,0
	.byte 55,240,125,0,32,111,55,0,82,45,48,0,128,173,48,0
	.byte 10,67,15,0,142,79,62,0,143,72,98,0,139,48,19,0
	.byte 69,48,24,0,58,170,94,0,19,214,74,0,163,41,22,0
	.byte 231,103,46,0,49,30,56,0,127,83,23,0,27,249,59,0
	.byte 211,176,42,0,173,66,96,0,208,3,39,0,205,90,68,0
	.byte 174,167,68,0,139,80,113,0,103,196,119,0,89,124,115,0
	.byte 117,108,71,0,164,107,24,0,233,169,32,0,194,91,74,0
	.byte 167,80,58,0,227,97,74,0,42,21,25,0,195,237,25,0
	.byte 163,58,8,0,101,9,92,0,179,149,4,0,1,220,73,0
	.byte 191,193,43,0,107,85,73,0,132,113,46,0,123,234,58,0
	.byte 82,33,68,0,44,184,38,0,212,207,54,0,253,90,25,0
	.byte 60,1,74,0,52,235,80,0,225,105,126,0,154,149,86,0
	.byte 60,154,123,0,0,174,66,0,222,75,0,0,204,15,101,0
	.byte 104,3,50,0,9,91,21,0,25,229,58,0,42,82,32,0
	.byte 133,44,32,0,153,230,87,0,96,21,17,0,112,98,8,0
	.byte 121,40,73,0,92,122,16,0,145,63,112,0,169,73,86,0
	.byte 218,250,86,0,184,101,80,0,247,4,44,0,140,69,80,0
	.byte 129,235,31,0,83,123,5,0,214,246,91,0,214,1,100,0
	.byte 221,193,120,0,216,94,13,0,232,222,11,0,189,65,124,0
	.byte 253,234,7,0,254,206,39,0,10,123,127,0,1,226,63,0
idx_even:
	.byte 0,0,0,0,2,0,0,0,4,0,0,0,6,0,0,0
	.byte 0,0,0,0,2,0,0,0,4,0,0,0,6,0,0,0
idx_odd:
	.byte 1,0,0,0,3,0,0,0,5,0,0,0,7,0,0,0
	.byte 1,0,0,0,3,0,0,0,5,0,0,0,7,0,0,0
ml_dsa_q:
	.byte 1,224,127,0,0,0,0,0
ml_dsa_q_neg_inv:
	.byte 255,223,127,252,0,0,0,0
ml_dsa_inverse_degree_montgomery:
	.byte 250,163,0,0,0,0,0,0

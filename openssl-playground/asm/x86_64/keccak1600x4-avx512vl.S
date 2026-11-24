	.text
SHA3_avx512vl_capable:
movl	OPENSSL_ia32cap_P+8(%rip), %ecx
xorl	%eax, %eax
andl	$0xc0030000, %ecx
cmpl	$0xc0030000, %ecx
cmovel	%ecx, %eax
rep	retq
nopl	(%rax)
keccak_1600_permute:
movl	$0x18, %r13d
leaq	iotas(%rip), %r14
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_40:
vmovdqa64	%ymm0, %ymm25
vpternlogq	$0x96, %ymm5, %ymm10, %ymm25
vmovdqa64	%ymm1, %ymm26
vpternlogq	$0x96, %ymm11, %ymm6, %ymm26
vmovdqa64	%ymm2, %ymm27
vpternlogq	$0x96, %ymm12, %ymm7, %ymm27
vmovdqa64	%ymm3, %ymm28
vpternlogq	$0x96, %ymm13, %ymm8, %ymm28
vmovdqa64	%ymm4, %ymm29
vpternlogq	$0x96, %ymm14, %ymm9, %ymm29
vpternlogq	$0x96, %ymm20, %ymm15, %ymm25
vpternlogq	$0x96, %ymm21, %ymm16, %ymm26
vpternlogq	$0x96, %ymm22, %ymm17, %ymm27
vpternlogq	$0x96, %ymm23, %ymm18, %ymm28
vprolq	$0x1, %ymm26, %ymm30
vprolq	$0x1, %ymm27, %ymm31
vpternlogq	$0x96, %ymm24, %ymm19, %ymm29
vpternlogq	$0x96, %ymm30, %ymm29, %ymm0
vpternlogq	$0x96, %ymm30, %ymm29, %ymm10
vpternlogq	$0x96, %ymm30, %ymm29, %ymm20
vpternlogq	$0x96, %ymm30, %ymm29, %ymm5
vpternlogq	$0x96, %ymm30, %ymm29, %ymm15
vprolq	$0x1, %ymm28, %ymm30
vpternlogq	$0x96, %ymm31, %ymm25, %ymm6
vpternlogq	$0x96, %ymm31, %ymm25, %ymm16
vpternlogq	$0x96, %ymm31, %ymm25, %ymm1
vpternlogq	$0x96, %ymm31, %ymm25, %ymm11
vpternlogq	$0x96, %ymm31, %ymm25, %ymm21
vprolq	$0x1, %ymm29, %ymm31
vpbroadcastq	(%r14), %ymm29
addq	$0x8, %r14
vpternlogq	$0x96, %ymm30, %ymm26, %ymm12
vpternlogq	$0x96, %ymm30, %ymm26, %ymm7
vpternlogq	$0x96, %ymm30, %ymm26, %ymm22
vpternlogq	$0x96, %ymm30, %ymm26, %ymm17
vpternlogq	$0x96, %ymm30, %ymm26, %ymm2
vprolq	$0x1, %ymm25, %ymm30
vpternlogq	$0x96, %ymm31, %ymm27, %ymm3
vpternlogq	$0x96, %ymm31, %ymm27, %ymm13
vpternlogq	$0x96, %ymm31, %ymm27, %ymm23
vprolq	$0x2c, %ymm6, %ymm6
vpternlogq	$0x96, %ymm31, %ymm27, %ymm18
vpternlogq	$0x96, %ymm31, %ymm27, %ymm8
vprolq	$0x2b, %ymm12, %ymm12
vprolq	$0x15, %ymm18, %ymm18
vpternlogq	$0x96, %ymm30, %ymm28, %ymm24
vprolq	$0xe, %ymm24, %ymm24
vprolq	$0x1c, %ymm3, %ymm3
vpternlogq	$0x96, %ymm30, %ymm28, %ymm9
vprolq	$0x14, %ymm9, %ymm9
vprolq	$0x3, %ymm10, %ymm10
vpternlogq	$0x96, %ymm30, %ymm28, %ymm19
vprolq	$0x2d, %ymm16, %ymm16
vprolq	$0x3d, %ymm22, %ymm22
vpternlogq	$0x96, %ymm30, %ymm28, %ymm4
vprolq	$0x1, %ymm1, %ymm1
vprolq	$0x6, %ymm7, %ymm7
vpternlogq	$0x96, %ymm30, %ymm28, %ymm14
vprolq	$0x19, %ymm13, %ymm13
vprolq	$0x8, %ymm19, %ymm19
vmovdqa64	%ymm0, %ymm30
vpternlogq	$0xd2, %ymm12, %ymm6, %ymm30
vprolq	$0x12, %ymm20, %ymm20
vprolq	$0x1b, %ymm4, %ymm4
vpxorq	%ymm29, %ymm30, %ymm30
vprolq	$0x24, %ymm5, %ymm5
vprolq	$0xa, %ymm11, %ymm11
vmovdqa64	%ymm6, %ymm31
vpternlogq	$0xd2, %ymm18, %ymm12, %ymm31
vprolq	$0xf, %ymm17, %ymm17
vprolq	$0x38, %ymm23, %ymm23
vpternlogq	$0xd2, %ymm24, %ymm18, %ymm12
vprolq	$0x3e, %ymm2, %ymm2
vprolq	$0x37, %ymm8, %ymm8
vpternlogq	$0xd2, %ymm0, %ymm24, %ymm18
vprolq	$0x27, %ymm14, %ymm14
vprolq	$0x29, %ymm15, %ymm15
vpternlogq	$0xd2, %ymm6, %ymm0, %ymm24
vmovdqa64	%ymm30, %ymm0
vmovdqa64	%ymm31, %ymm6
vprolq	$0x2, %ymm21, %ymm21
vmovdqa64	%ymm3, %ymm30
vpternlogq	$0xd2, %ymm10, %ymm9, %ymm30
vmovdqa64	%ymm9, %ymm31
vpternlogq	$0xd2, %ymm16, %ymm10, %ymm31
vpternlogq	$0xd2, %ymm22, %ymm16, %ymm10
vpternlogq	$0xd2, %ymm3, %ymm22, %ymm16
vpternlogq	$0xd2, %ymm9, %ymm3, %ymm22
vmovdqa64	%ymm30, %ymm3
vmovdqa64	%ymm31, %ymm9
vmovdqa64	%ymm1, %ymm30
vpternlogq	$0xd2, %ymm13, %ymm7, %ymm30
vmovdqa64	%ymm7, %ymm31
vpternlogq	$0xd2, %ymm19, %ymm13, %ymm31
vpternlogq	$0xd2, %ymm20, %ymm19, %ymm13
vpternlogq	$0xd2, %ymm1, %ymm20, %ymm19
vpternlogq	$0xd2, %ymm7, %ymm1, %ymm20
vmovdqa64	%ymm30, %ymm1
vmovdqa64	%ymm31, %ymm7
vmovdqa64	%ymm4, %ymm30
vpternlogq	$0xd2, %ymm11, %ymm5, %ymm30
vmovdqa64	%ymm5, %ymm31
vpternlogq	$0xd2, %ymm17, %ymm11, %ymm31
vpternlogq	$0xd2, %ymm23, %ymm17, %ymm11
vpternlogq	$0xd2, %ymm4, %ymm23, %ymm17
vpternlogq	$0xd2, %ymm5, %ymm4, %ymm23
vmovdqa64	%ymm30, %ymm4
vmovdqa64	%ymm31, %ymm5
vmovdqa64	%ymm2, %ymm30
vpternlogq	$0xd2, %ymm14, %ymm8, %ymm30
vmovdqa64	%ymm8, %ymm31
vpternlogq	$0xd2, %ymm15, %ymm14, %ymm31
vpternlogq	$0xd2, %ymm21, %ymm15, %ymm14
vpternlogq	$0xd2, %ymm2, %ymm21, %ymm15
vpternlogq	$0xd2, %ymm8, %ymm2, %ymm21
vmovdqa64	%ymm30, %ymm2
vmovdqa64	%ymm31, %ymm8
vmovdqa64	%ymm3, %ymm30
vmovdqa64	%ymm18, %ymm3
vmovdqa64	%ymm17, %ymm18
vmovdqa64	%ymm11, %ymm17
vmovdqa64	%ymm7, %ymm11
vmovdqa64	%ymm10, %ymm7
vmovdqa64	%ymm1, %ymm10
vmovdqa64	%ymm6, %ymm1
vmovdqa64	%ymm9, %ymm6
vmovdqa64	%ymm22, %ymm9
vmovdqa64	%ymm14, %ymm22
vmovdqa64	%ymm20, %ymm14
vmovdqa64	%ymm2, %ymm20
vmovdqa64	%ymm12, %ymm2
vmovdqa64	%ymm13, %ymm12
vmovdqa64	%ymm19, %ymm13
vmovdqa64	%ymm23, %ymm19
vmovdqa64	%ymm15, %ymm23
vmovdqa64	%ymm4, %ymm15
vmovdqa64	%ymm24, %ymm4
vmovdqa64	%ymm21, %ymm24
vmovdqa64	%ymm8, %ymm21
vmovdqa64	%ymm16, %ymm8
vmovdqa64	%ymm5, %ymm16
vmovdqa64	%ymm30, %ymm5
decl	%r13d
jne	L_40
rep	retq
nopw	%cs:(%rax,%rax)
keccak_1600_init_state:
vpxorq	%ymm0, %ymm0, %ymm0
vmovdqa64	%ymm0, %ymm1
vmovdqa64	%ymm0, %ymm2
vmovdqa64	%ymm0, %ymm3
vmovdqa64	%ymm0, %ymm4
vmovdqa64	%ymm0, %ymm5
vmovdqa64	%ymm0, %ymm6
vmovdqa64	%ymm0, %ymm7
vmovdqa64	%ymm0, %ymm8
vmovdqa64	%ymm0, %ymm9
vmovdqa64	%ymm0, %ymm10
vmovdqa64	%ymm0, %ymm11
vmovdqa64	%ymm0, %ymm12
vmovdqa64	%ymm0, %ymm13
vmovdqa64	%ymm0, %ymm14
vmovdqa64	%ymm0, %ymm15
vmovdqa64	%ymm0, %ymm16
vmovdqa64	%ymm0, %ymm17
vmovdqa64	%ymm0, %ymm18
vmovdqa64	%ymm0, %ymm19
vmovdqa64	%ymm0, %ymm20
vmovdqa64	%ymm0, %ymm21
vmovdqa64	%ymm0, %ymm22
vmovdqa64	%ymm0, %ymm23
vmovdqa64	%ymm0, %ymm24
rep	retq
nopl	(%rax,%rax)
keccak_1600_load_state_x4:
vmovdqu64	(%rdi), %ymm0
vmovdqu64	0x20(%rdi), %ymm1
vmovdqu64	0x40(%rdi), %ymm2
vmovdqu64	0x60(%rdi), %ymm3
vmovdqu64	0x80(%rdi), %ymm4
vmovdqu64	0xa0(%rdi), %ymm5
vmovdqu64	0xc0(%rdi), %ymm6
vmovdqu64	0xe0(%rdi), %ymm7
vmovdqu64	0x100(%rdi), %ymm8
vmovdqu64	0x120(%rdi), %ymm9
vmovdqu64	0x140(%rdi), %ymm10
vmovdqu64	0x160(%rdi), %ymm11
vmovdqu64	0x180(%rdi), %ymm12
vmovdqu64	0x1a0(%rdi), %ymm13
vmovdqu64	0x1c0(%rdi), %ymm14
vmovdqu64	0x1e0(%rdi), %ymm15
vmovdqu64	0x200(%rdi), %ymm16
vmovdqu64	0x220(%rdi), %ymm17
vmovdqu64	0x240(%rdi), %ymm18
vmovdqu64	0x260(%rdi), %ymm19
vmovdqu64	0x280(%rdi), %ymm20
vmovdqu64	0x2a0(%rdi), %ymm21
vmovdqu64	0x2c0(%rdi), %ymm22
vmovdqu64	0x2e0(%rdi), %ymm23
vmovdqu64	0x300(%rdi), %ymm24
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
keccak_1600_save_state_x4:
vmovdqu64	%ymm0, (%rdi)
vmovdqu64	%ymm1, 0x20(%rdi)
vmovdqu64	%ymm2, 0x40(%rdi)
vmovdqu64	%ymm3, 0x60(%rdi)
vmovdqu64	%ymm4, 0x80(%rdi)
vmovdqu64	%ymm5, 0xa0(%rdi)
vmovdqu64	%ymm6, 0xc0(%rdi)
vmovdqu64	%ymm7, 0xe0(%rdi)
vmovdqu64	%ymm8, 0x100(%rdi)
vmovdqu64	%ymm9, 0x120(%rdi)
vmovdqu64	%ymm10, 0x140(%rdi)
vmovdqu64	%ymm11, 0x160(%rdi)
vmovdqu64	%ymm12, 0x180(%rdi)
vmovdqu64	%ymm13, 0x1a0(%rdi)
vmovdqu64	%ymm14, 0x1c0(%rdi)
vmovdqu64	%ymm15, 0x1e0(%rdi)
vmovdqu64	%ymm16, 0x200(%rdi)
vmovdqu64	%ymm17, 0x220(%rdi)
vmovdqu64	%ymm18, 0x240(%rdi)
vmovdqu64	%ymm19, 0x260(%rdi)
vmovdqu64	%ymm20, 0x280(%rdi)
vmovdqu64	%ymm21, 0x2a0(%rdi)
vmovdqu64	%ymm22, 0x2c0(%rdi)
vmovdqu64	%ymm23, 0x2e0(%rdi)
vmovdqu64	%ymm24, 0x300(%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
keccak_1600_partial_add_x4:
movq	0x320(%r10), %r9
testl	$0x7, %r9d
je	L_70a
movq	%r9, %r15
andl	$0x7, %r9d
negl	%r9d
addl	$0x8, %r9d
cmpl	%r9d, %r12d
cmovbl	%r12d, %r9d
leaq	byte_kmask_0_to_7(%rip), %rbx
kmovb	(%rbx,%r9), %k1
movq	%r15, %rbx
andl	$-0x8, %ebx
leaq	(%r10,%rbx,4), %r10
movq	%r15, %rbx
andl	$0x7, %ebx
vmovdqu8	(%r10), %ymm31
vmovdqu8	%ymm31, (%r10)
vmovdqu8	(%rsi), %xmm31 {%k1} {z}
vmovdqu8	(%r10,%rbx), %xmm30 {%k1} {z}
vpxorq	%xmm30, %xmm31, %xmm31
vmovdqu8	%xmm31, (%r10,%rbx) {%k1}
vmovdqu8	(%rdx), %xmm31 {%k1} {z}
vmovdqu8	0x8(%r10,%rbx), %xmm30 {%k1} {z}
vpxorq	%xmm30, %xmm31, %xmm31
vmovdqu8	%xmm31, 0x8(%r10,%rbx) {%k1}
vmovdqu8	(%rcx), %xmm31 {%k1} {z}
vmovdqu8	0x10(%r10,%rbx), %xmm30 {%k1} {z}
vpxorq	%xmm30, %xmm31, %xmm31
vmovdqu8	%xmm31, 0x10(%r10,%rbx) {%k1}
vmovdqu8	(%r8), %xmm31 {%k1} {z}
vmovdqu8	0x18(%r10,%rbx), %xmm30 {%k1} {z}
vpxorq	%xmm30, %xmm31, %xmm31
vmovdqu8	%xmm31, 0x18(%r10,%rbx) {%k1}
subq	%r9, %r12
je	L_780
addq	%r9, %rsi
addq	%r9, %rdx
addq	%r9, %rcx
addq	%r9, %r8
addq	$0x20, %r10
xorq	%r9, %r9
jmp	L_720
L_70a:
leaq	(%r10,%r9,4), %r10
xorq	%r9, %r9
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_720:
cmpl	$0x8, %r12d
jb	L_7a0
vmovq	(%rsi,%r9), %xmm31
vpinsrq	$0x1, (%rdx,%r9), %xmm31, %xmm31
vmovq	(%rcx,%r9), %xmm30
vpinsrq	$0x1, (%r8,%r9), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	(%r10,%r9,4), %ymm31, %ymm31
vmovdqu64	%ymm31, (%r10,%r9,4)
addq	$0x8, %r9
subq	$0x8, %r12
je	L_780
jmp	L_720
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_780:
addq	%r9, %rsi
addq	%r9, %rdx
addq	%r9, %rcx
addq	%r9, %r8
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_7a0:
addq	%r9, %rsi
addq	%r9, %rdx
addq	%r9, %rcx
addq	%r9, %r8
leaq	(%r10,%r9,4), %r10
leaq	byte_kmask_0_to_7(%rip), %rbx
kmovb	(%rbx,%r12), %k1
vmovdqu8	(%rsi), %xmm31 {%k1} {z}
vmovdqu8	(%rdx), %xmm30 {%k1} {z}
vpunpcklqdq	%xmm30, %xmm31, %xmm31
vmovdqu8	(%rcx), %xmm30 {%k1} {z}
vmovdqu8	(%r8), %xmm29 {%k1} {z}
vpunpcklqdq	%xmm29, %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	(%r10), %ymm31, %ymm31
vmovdqu64	%ymm31, (%r10)
addq	%r12, %rsi
addq	%r12, %rdx
addq	%r12, %rcx
addq	%r12, %r8
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
keccak_1600_extract_bytes_x4:
orq	%r12, %r12
je	L_94c
testl	$0x7, %r11d
je	L_8c3
movq	%r11, %r9
andl	$0x7, %r9d
negl	%r9d
addl	$0x8, %r9d
cmpl	%r9d, %r12d
cmovbl	%r12d, %r9d
leaq	byte_kmask_0_to_7(%rip), %rbx
kmovb	(%rbx,%r9), %k1
movq	%r11, %rbx
andl	$-0x8, %ebx
leaq	(%r10,%rbx,4), %r10
movq	%r11, %rbx
andl	$0x7, %ebx
vmovdqu8	(%r10,%rbx), %xmm31 {%k1} {z}
vmovdqu8	%xmm31, (%rdi) {%k1}
vmovdqu8	0x8(%r10,%rbx), %xmm31 {%k1} {z}
vmovdqu8	%xmm31, (%rsi) {%k1}
vmovdqu8	0x10(%r10,%rbx), %xmm31 {%k1} {z}
vmovdqu8	%xmm31, (%rdx) {%k1}
vmovdqu8	0x18(%r10,%rbx), %xmm31 {%k1} {z}
vmovdqu8	%xmm31, (%rcx) {%k1}
addq	%r9, %rdi
addq	%r9, %rsi
addq	%r9, %rdx
addq	%r9, %rcx
subq	%r9, %r12
je	L_94c
addq	$0x20, %r10
xorq	%r9, %r9
jmp	L_8e0
L_8c3:
leaq	(%r10,%r11,4), %r10
xorq	%r9, %r9
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_8e0:
cmpq	$0x8, %r12
jb	L_960
vmovdqu64	(%r10), %xmm31
vmovdqu64	0x10(%r10), %xmm30
vmovq	%xmm31, (%rdi,%r9)
vpextrq	$0x1, %xmm31, (%rsi,%r9)
vmovq	%xmm30, (%rdx,%r9)
vpextrq	$0x1, %xmm30, (%rcx,%r9)
addq	$0x8, %r9
subq	$0x8, %r12
je	L_940
addq	$0x20, %r10
jmp	L_8e0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_940:
addq	%r9, %rdi
addq	%r9, %rsi
addq	%r9, %rdx
addq	%r9, %rcx
L_94c:
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_960:
addq	%r9, %rdi
addq	%r9, %rsi
addq	%r9, %rdx
addq	%r9, %rcx
leaq	byte_kmask_0_to_7(%rip), %r9
kmovb	(%r9,%r12), %k1
vmovq	(%r10), %xmm31
vmovdqu8	%xmm31, (%rdi) {%k1}
vmovq	0x8(%r10), %xmm31
vmovdqu8	%xmm31, (%rsi) {%k1}
vmovq	0x10(%r10), %xmm31
vmovdqu8	%xmm31, (%rdx) {%k1}
vmovq	0x18(%r10), %xmm31
vmovdqu8	%xmm31, (%rcx) {%k1}
addq	%r12, %rdi
addq	%r12, %rsi
addq	%r12, %rdx
addq	%r12, %rcx
rep	retq
nopw	(%rax,%rax)
SHA3_shake128_x4_avx512vl:
pushq	%rbp
movq	%rsp, %rbp
pushq	%rbx
subq	$0x358, %rsp
movq	%rsp, %rbx
movq	%rdi, (%rbx)
movq	%rsi, 0x8(%rbx)
movq	%rdx, 0x10(%rbx)
movq	%rcx, 0x18(%rbx)
movq	%r8, 0x20(%rbx)
leaq	0x30(%rbx), %rdi
movq	%rdi, 0x28(%rbx)
callq	keccak_1600_init_state
callq	keccak_1600_save_state_x4
movq	$0x0, 0x320(%rdi)
movq	0x28(%rbx), %rdi
movq	%r9, %rsi
movq	0x10(%rbp), %rdx
movq	0x18(%rbp), %rcx
movq	0x20(%rbp), %r8
movq	0x28(%rbp), %r9
callq	SHA3_shake128_x4_inc_absorb_avx512vl
movq	0x28(%rbx), %rdi
callq	SHA3_shake128_x4_inc_finalize_avx512vl
movq	(%rbx), %rdi
movq	0x8(%rbx), %rsi
movq	0x10(%rbx), %rdx
movq	0x18(%rbx), %rcx
movq	0x20(%rbx), %r8
movq	0x28(%rbx), %r9
callq	SHA3_shake128_x4_inc_squeeze_avx512vl
leaq	0x30(%rbx), %r9
vpxorq	%ymm31, %ymm31, %ymm31
vmovdqu64	%ymm31, (%r9)
vmovdqu64	%ymm31, 0x20(%r9)
vmovdqu64	%ymm31, 0x40(%r9)
vmovdqu64	%ymm31, 0x60(%r9)
vmovdqu64	%ymm31, 0x80(%r9)
vmovdqu64	%ymm31, 0xa0(%r9)
vmovdqu64	%ymm31, 0xc0(%r9)
vmovdqu64	%ymm31, 0xe0(%r9)
vmovdqu64	%ymm31, 0x100(%r9)
vmovdqu64	%ymm31, 0x120(%r9)
vmovdqu64	%ymm31, 0x140(%r9)
vmovdqu64	%ymm31, 0x160(%r9)
vmovdqu64	%ymm31, 0x180(%r9)
vmovdqu64	%ymm31, 0x1a0(%r9)
vmovdqu64	%ymm31, 0x1c0(%r9)
vmovdqu64	%ymm31, 0x1e0(%r9)
vmovdqu64	%ymm31, 0x200(%r9)
vmovdqu64	%ymm31, 0x220(%r9)
vmovdqu64	%ymm31, 0x240(%r9)
vmovdqu64	%ymm31, 0x260(%r9)
vmovdqu64	%ymm31, 0x280(%r9)
vmovdqu64	%ymm31, 0x2a0(%r9)
vmovdqu64	%ymm31, 0x2c0(%r9)
vmovdqu64	%ymm31, 0x2e0(%r9)
vmovdqu64	%ymm31, 0x300(%r9)
vmovq	%xmm31, 0x320(%r9)
addq	$0x358, %rsp
popq	%rbx
popq	%rbp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
SHA3_shake128_x4_inc_absorb_avx512vl:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movq	0x320(%rdi), %r14
orq	%r14, %r14
je	L_baf
movq	$0xa8, %r12
subq	%r14, %r12
cmpq	%r12, %r9
jbe	L_b6a
subq	%r12, %r9
movq	%r9, %r11
movq	%rdi, %r10
callq	keccak_1600_partial_add_x4
callq	keccak_1600_load_state_x4
callq	keccak_1600_permute
movq	$0x0, 0x320(%rdi)
jmp	L_bb7
L_b6a:
movq	%rdi, %r10
movq	%r9, %r12
movq	%r9, %r11
callq	keccak_1600_partial_add_x4
leaq	(%r11,%r14), %r15
movq	%r15, 0x320(%rdi)
cmpq	$0xa8, %r15
jb	L_ffa
callq	keccak_1600_load_state_x4
callq	keccak_1600_permute
callq	keccak_1600_save_state_x4
movq	$0x0, 0x320(%rdi)
jmp	L_ffa
L_baf:
callq	keccak_1600_load_state_x4
movq	%r9, %r11
L_bb7:
xorq	%r12, %r12
nopw	(%rax,%rax)
L_bc0:
cmpq	$0xa8, %r11
jb	L_fc0
vmovq	(%rsi,%r12), %xmm31
vpinsrq	$0x1, (%rdx,%r12), %xmm31, %xmm31
vmovq	(%rcx,%r12), %xmm30
vpinsrq	$0x1, (%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm0, %ymm0
vmovq	0x8(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x8(%rdx,%r12), %xmm31, %xmm31
vmovq	0x8(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x8(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm1, %ymm1
vmovq	0x10(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x10(%rdx,%r12), %xmm31, %xmm31
vmovq	0x10(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x10(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm2, %ymm2
vmovq	0x18(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x18(%rdx,%r12), %xmm31, %xmm31
vmovq	0x18(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x18(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm3, %ymm3
vmovq	0x20(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x20(%rdx,%r12), %xmm31, %xmm31
vmovq	0x20(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x20(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm4, %ymm4
vmovq	0x28(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x28(%rdx,%r12), %xmm31, %xmm31
vmovq	0x28(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x28(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm5, %ymm5
vmovq	0x30(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x30(%rdx,%r12), %xmm31, %xmm31
vmovq	0x30(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x30(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm6, %ymm6
vmovq	0x38(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x38(%rdx,%r12), %xmm31, %xmm31
vmovq	0x38(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x38(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm7, %ymm7
vmovq	0x40(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x40(%rdx,%r12), %xmm31, %xmm31
vmovq	0x40(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x40(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm8, %ymm8
vmovq	0x48(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x48(%rdx,%r12), %xmm31, %xmm31
vmovq	0x48(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x48(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm9, %ymm9
vmovq	0x50(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x50(%rdx,%r12), %xmm31, %xmm31
vmovq	0x50(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x50(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm10, %ymm10
vmovq	0x58(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x58(%rdx,%r12), %xmm31, %xmm31
vmovq	0x58(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x58(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm11, %ymm11
vmovq	0x60(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x60(%rdx,%r12), %xmm31, %xmm31
vmovq	0x60(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x60(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm12, %ymm12
vmovq	0x68(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x68(%rdx,%r12), %xmm31, %xmm31
vmovq	0x68(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x68(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm13, %ymm13
vmovq	0x70(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x70(%rdx,%r12), %xmm31, %xmm31
vmovq	0x70(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x70(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm14, %ymm14
vmovq	0x78(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x78(%rdx,%r12), %xmm31, %xmm31
vmovq	0x78(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x78(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm15, %ymm15
vmovq	0x80(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x80(%rdx,%r12), %xmm31, %xmm31
vmovq	0x80(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x80(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm16, %ymm16
vmovq	0x88(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x88(%rdx,%r12), %xmm31, %xmm31
vmovq	0x88(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x88(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm17, %ymm17
vmovq	0x90(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x90(%rdx,%r12), %xmm31, %xmm31
vmovq	0x90(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x90(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm18, %ymm18
vmovq	0x98(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x98(%rdx,%r12), %xmm31, %xmm31
vmovq	0x98(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x98(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm19, %ymm19
vmovq	0xa0(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0xa0(%rdx,%r12), %xmm31, %xmm31
vmovq	0xa0(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0xa0(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm20, %ymm20
subq	$0xa8, %r11
addq	$0xa8, %r12
callq	keccak_1600_permute
jmp	L_bc0
nopl	(%rax)
L_fc0:
callq	keccak_1600_save_state_x4
movq	%r11, 0x320(%rdi)
orq	%r11, %r11
je	L_ffa
movq	$0x0, 0x320(%rdi)
movq	%rdi, %r10
addq	%r12, %rsi
addq	%r12, %rdx
addq	%r12, %rcx
addq	%r12, %r8
movq	%r11, %r12
callq	keccak_1600_partial_add_x4
movq	%r11, 0x320(%rdi)
L_ffa:
vpxorq	%xmm16, %xmm16, %xmm16
vmovdqa64	%ymm16, %ymm17
vmovdqa64	%ymm16, %ymm18
vmovdqa64	%ymm16, %ymm19
vmovdqa64	%ymm16, %ymm20
vmovdqa64	%ymm16, %ymm21
vmovdqa64	%ymm16, %ymm22
vmovdqa64	%ymm16, %ymm23
vmovdqa64	%ymm16, %ymm24
vmovdqa64	%ymm16, %ymm25
vmovdqa64	%ymm16, %ymm26
vmovdqa64	%ymm16, %ymm27
vmovdqa64	%ymm16, %ymm28
vmovdqa64	%ymm16, %ymm29
vmovdqa64	%ymm16, %ymm30
vmovdqa64	%ymm16, %ymm31
vzeroall
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbx
popq	%rbp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
SHA3_shake128_x4_inc_finalize_avx512vl:
movq	0x320(%rdi), %r11
movq	%r11, %r10
andl	$-0x8, %r10d
andl	$0x7, %r11d
vmovdqu32	(%rdi,%r10,4), %ymm31
leaq	shake_msg_pad_x4(%rip), %r9
subq	%r11, %r9
vmovdqu32	(%r9), %ymm30
vpxorq	%ymm30, %ymm31, %ymm31
vmovdqu32	%ymm31, (%rdi,%r10,4)
vmovdqu32	0x280(%rdi), %ymm31
vmovdqa32	shake_terminator_byte_x4(%rip), %ymm30
vpxorq	%ymm30, %ymm31, %ymm31
vmovdqu32	%ymm31, 0x280(%rdi)
movq	$0x0, 0x320(%rdi)
vpxorq	%ymm31, %ymm31, %ymm31
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
SHA3_shake128_x4_inc_squeeze_avx512vl:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
orq	%r8, %r8
je	L_1557
movq	0x320(%r9), %r15
orq	%r15, %r15
jne	L_1140
movq	%rdi, %r14
movq	%r9, %rdi
callq	keccak_1600_load_state_x4
movq	%r14, %rdi
xorq	%rbp, %rbp
jmp	L_11a0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1140:
movq	%r9, %r10
movq	%r9, %r14
movq	%r15, %r12
cmpq	%r15, %r8
cmovbq	%r8, %r12
subq	%r12, %r8
movl	$0xa8, %r11d
subq	%r15, %r11
subq	%r12, %r15
movq	%r15, 0x320(%r9)
callq	keccak_1600_extract_bytes_x4
movq	%r14, %r9
orq	%r15, %r15
jne	L_1557
movq	%rdi, %r13
movq	%r14, %rdi
callq	keccak_1600_load_state_x4
movq	%r13, %rdi
xorq	%rbp, %rbp
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_11a0:
cmpq	$0xa8, %r8
jb	L_1500
callq	keccak_1600_permute
vextracti64x2	$0x1, %ymm0, %xmm31
vmovq	%xmm0, (%rdi,%rbp)
vpextrq	$0x1, %xmm0, (%rsi,%rbp)
vmovq	%xmm31, (%rdx,%rbp)
vpextrq	$0x1, %xmm31, (%rcx,%rbp)
vextracti64x2	$0x1, %ymm1, %xmm31
vmovq	%xmm1, 0x8(%rdi,%rbp)
vpextrq	$0x1, %xmm1, 0x8(%rsi,%rbp)
vmovq	%xmm31, 0x8(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x8(%rcx,%rbp)
vextracti64x2	$0x1, %ymm2, %xmm31
vmovq	%xmm2, 0x10(%rdi,%rbp)
vpextrq	$0x1, %xmm2, 0x10(%rsi,%rbp)
vmovq	%xmm31, 0x10(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x10(%rcx,%rbp)
vextracti64x2	$0x1, %ymm3, %xmm31
vmovq	%xmm3, 0x18(%rdi,%rbp)
vpextrq	$0x1, %xmm3, 0x18(%rsi,%rbp)
vmovq	%xmm31, 0x18(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x18(%rcx,%rbp)
vextracti64x2	$0x1, %ymm4, %xmm31
vmovq	%xmm4, 0x20(%rdi,%rbp)
vpextrq	$0x1, %xmm4, 0x20(%rsi,%rbp)
vmovq	%xmm31, 0x20(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x20(%rcx,%rbp)
vextracti64x2	$0x1, %ymm5, %xmm31
vmovq	%xmm5, 0x28(%rdi,%rbp)
vpextrq	$0x1, %xmm5, 0x28(%rsi,%rbp)
vmovq	%xmm31, 0x28(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x28(%rcx,%rbp)
vextracti64x2	$0x1, %ymm6, %xmm31
vmovq	%xmm6, 0x30(%rdi,%rbp)
vpextrq	$0x1, %xmm6, 0x30(%rsi,%rbp)
vmovq	%xmm31, 0x30(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x30(%rcx,%rbp)
vextracti64x2	$0x1, %ymm7, %xmm31
vmovq	%xmm7, 0x38(%rdi,%rbp)
vpextrq	$0x1, %xmm7, 0x38(%rsi,%rbp)
vmovq	%xmm31, 0x38(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x38(%rcx,%rbp)
vextracti64x2	$0x1, %ymm8, %xmm31
vmovq	%xmm8, 0x40(%rdi,%rbp)
vpextrq	$0x1, %xmm8, 0x40(%rsi,%rbp)
vmovq	%xmm31, 0x40(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x40(%rcx,%rbp)
vextracti64x2	$0x1, %ymm9, %xmm31
vmovq	%xmm9, 0x48(%rdi,%rbp)
vpextrq	$0x1, %xmm9, 0x48(%rsi,%rbp)
vmovq	%xmm31, 0x48(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x48(%rcx,%rbp)
vextracti64x2	$0x1, %ymm10, %xmm31
vmovq	%xmm10, 0x50(%rdi,%rbp)
vpextrq	$0x1, %xmm10, 0x50(%rsi,%rbp)
vmovq	%xmm31, 0x50(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x50(%rcx,%rbp)
vextracti64x2	$0x1, %ymm11, %xmm31
vmovq	%xmm11, 0x58(%rdi,%rbp)
vpextrq	$0x1, %xmm11, 0x58(%rsi,%rbp)
vmovq	%xmm31, 0x58(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x58(%rcx,%rbp)
vextracti64x2	$0x1, %ymm12, %xmm31
vmovq	%xmm12, 0x60(%rdi,%rbp)
vpextrq	$0x1, %xmm12, 0x60(%rsi,%rbp)
vmovq	%xmm31, 0x60(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x60(%rcx,%rbp)
vextracti64x2	$0x1, %ymm13, %xmm31
vmovq	%xmm13, 0x68(%rdi,%rbp)
vpextrq	$0x1, %xmm13, 0x68(%rsi,%rbp)
vmovq	%xmm31, 0x68(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x68(%rcx,%rbp)
vextracti64x2	$0x1, %ymm14, %xmm31
vmovq	%xmm14, 0x70(%rdi,%rbp)
vpextrq	$0x1, %xmm14, 0x70(%rsi,%rbp)
vmovq	%xmm31, 0x70(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x70(%rcx,%rbp)
vextracti64x2	$0x1, %ymm15, %xmm31
vmovq	%xmm15, 0x78(%rdi,%rbp)
vpextrq	$0x1, %xmm15, 0x78(%rsi,%rbp)
vmovq	%xmm31, 0x78(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x78(%rcx,%rbp)
vextracti64x2	$0x1, %ymm16, %xmm31
vmovq	%xmm16, 0x80(%rdi,%rbp)
vpextrq	$0x1, %xmm16, 0x80(%rsi,%rbp)
vmovq	%xmm31, 0x80(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x80(%rcx,%rbp)
vextracti64x2	$0x1, %ymm17, %xmm31
vmovq	%xmm17, 0x88(%rdi,%rbp)
vpextrq	$0x1, %xmm17, 0x88(%rsi,%rbp)
vmovq	%xmm31, 0x88(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x88(%rcx,%rbp)
vextracti64x2	$0x1, %ymm18, %xmm31
vmovq	%xmm18, 0x90(%rdi,%rbp)
vpextrq	$0x1, %xmm18, 0x90(%rsi,%rbp)
vmovq	%xmm31, 0x90(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x90(%rcx,%rbp)
vextracti64x2	$0x1, %ymm19, %xmm31
vmovq	%xmm19, 0x98(%rdi,%rbp)
vpextrq	$0x1, %xmm19, 0x98(%rsi,%rbp)
vmovq	%xmm31, 0x98(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x98(%rcx,%rbp)
vextracti64x2	$0x1, %ymm20, %xmm31
vmovq	%xmm20, 0xa0(%rdi,%rbp)
vpextrq	$0x1, %xmm20, 0xa0(%rsi,%rbp)
vmovq	%xmm31, 0xa0(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0xa0(%rcx,%rbp)
addq	$0xa8, %rbp
subq	$0xa8, %r8
jmp	L_11a0
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_1500:
orq	%r8, %r8
je	L_1544
addq	%rbp, %rdi
addq	%rbp, %rsi
addq	%rbp, %rdx
addq	%rbp, %rcx
movl	$0xa8, %r15d
subq	%r8, %r15
movq	%r15, 0x320(%r9)
callq	keccak_1600_permute
movq	%rdi, %r14
movq	%r9, %rdi
callq	keccak_1600_save_state_x4
movq	%r14, %rdi
movq	%r9, %r10
movq	%r8, %r12
xorq	%r11, %r11
callq	keccak_1600_extract_bytes_x4
jmp	L_1557
L_1544:
movq	$0x0, 0x320(%r9)
movq	%r9, %rdi
callq	keccak_1600_save_state_x4
L_1557:
vpxorq	%xmm16, %xmm16, %xmm16
vmovdqa64	%ymm16, %ymm17
vmovdqa64	%ymm16, %ymm18
vmovdqa64	%ymm16, %ymm19
vmovdqa64	%ymm16, %ymm20
vmovdqa64	%ymm16, %ymm21
vmovdqa64	%ymm16, %ymm22
vmovdqa64	%ymm16, %ymm23
vmovdqa64	%ymm16, %ymm24
vmovdqa64	%ymm16, %ymm25
vmovdqa64	%ymm16, %ymm26
vmovdqa64	%ymm16, %ymm27
vmovdqa64	%ymm16, %ymm28
vmovdqa64	%ymm16, %ymm29
vmovdqa64	%ymm16, %ymm30
vmovdqa64	%ymm16, %ymm31
vzeroall
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbx
popq	%rbp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
SHA3_shake256_x4_avx512vl:
pushq	%rbp
movq	%rsp, %rbp
pushq	%rbx
subq	$0x358, %rsp
movq	%rsp, %rbx
movq	%rdi, (%rbx)
movq	%rsi, 0x8(%rbx)
movq	%rdx, 0x10(%rbx)
movq	%rcx, 0x18(%rbx)
movq	%r8, 0x20(%rbx)
leaq	0x30(%rbx), %rdi
movq	%rdi, 0x28(%rbx)
callq	keccak_1600_init_state
callq	keccak_1600_save_state_x4
movq	$0x0, 0x320(%rdi)
movq	0x28(%rbx), %rdi
movq	%r9, %rsi
movq	0x10(%rbp), %rdx
movq	0x18(%rbp), %rcx
movq	0x20(%rbp), %r8
movq	0x28(%rbp), %r9
callq	SHA3_shake256_x4_inc_absorb_avx512vl
movq	0x28(%rbx), %rdi
callq	SHA3_shake256_x4_inc_finalize_avx512vl
movq	(%rbx), %rdi
movq	0x8(%rbx), %rsi
movq	0x10(%rbx), %rdx
movq	0x18(%rbx), %rcx
movq	0x20(%rbx), %r8
movq	0x28(%rbx), %r9
callq	SHA3_shake256_x4_inc_squeeze_avx512vl
leaq	0x30(%rbx), %r9
vpxorq	%ymm31, %ymm31, %ymm31
vmovdqu64	%ymm31, (%r9)
vmovdqu64	%ymm31, 0x20(%r9)
vmovdqu64	%ymm31, 0x40(%r9)
vmovdqu64	%ymm31, 0x60(%r9)
vmovdqu64	%ymm31, 0x80(%r9)
vmovdqu64	%ymm31, 0xa0(%r9)
vmovdqu64	%ymm31, 0xc0(%r9)
vmovdqu64	%ymm31, 0xe0(%r9)
vmovdqu64	%ymm31, 0x100(%r9)
vmovdqu64	%ymm31, 0x120(%r9)
vmovdqu64	%ymm31, 0x140(%r9)
vmovdqu64	%ymm31, 0x160(%r9)
vmovdqu64	%ymm31, 0x180(%r9)
vmovdqu64	%ymm31, 0x1a0(%r9)
vmovdqu64	%ymm31, 0x1c0(%r9)
vmovdqu64	%ymm31, 0x1e0(%r9)
vmovdqu64	%ymm31, 0x200(%r9)
vmovdqu64	%ymm31, 0x220(%r9)
vmovdqu64	%ymm31, 0x240(%r9)
vmovdqu64	%ymm31, 0x260(%r9)
vmovdqu64	%ymm31, 0x280(%r9)
vmovdqu64	%ymm31, 0x2a0(%r9)
vmovdqu64	%ymm31, 0x2c0(%r9)
vmovdqu64	%ymm31, 0x2e0(%r9)
vmovdqu64	%ymm31, 0x300(%r9)
vmovq	%xmm31, 0x320(%r9)
addq	$0x358, %rsp
popq	%rbx
popq	%rbp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
SHA3_shake256_x4_inc_absorb_avx512vl:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movq	0x320(%rdi), %r14
orq	%r14, %r14
je	L_17cf
movq	$0x88, %r12
subq	%r14, %r12
cmpq	%r12, %r9
jbe	L_178a
subq	%r12, %r9
movq	%r9, %r11
movq	%rdi, %r10
callq	keccak_1600_partial_add_x4
callq	keccak_1600_load_state_x4
callq	keccak_1600_permute
movq	$0x0, 0x320(%rdi)
jmp	L_17d7
L_178a:
movq	%rdi, %r10
movq	%r9, %r12
movq	%r9, %r11
callq	keccak_1600_partial_add_x4
leaq	(%r11,%r14), %r15
movq	%r15, 0x320(%rdi)
cmpq	$0x88, %r15
jb	L_1b5a
callq	keccak_1600_load_state_x4
callq	keccak_1600_permute
callq	keccak_1600_save_state_x4
movq	$0x0, 0x320(%rdi)
jmp	L_1b5a
L_17cf:
callq	keccak_1600_load_state_x4
movq	%r9, %r11
L_17d7:
xorq	%r12, %r12
nopw	(%rax,%rax)
L_17e0:
cmpq	$0x88, %r11
jb	L_1b20
vmovq	(%rsi,%r12), %xmm31
vpinsrq	$0x1, (%rdx,%r12), %xmm31, %xmm31
vmovq	(%rcx,%r12), %xmm30
vpinsrq	$0x1, (%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm0, %ymm0
vmovq	0x8(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x8(%rdx,%r12), %xmm31, %xmm31
vmovq	0x8(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x8(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm1, %ymm1
vmovq	0x10(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x10(%rdx,%r12), %xmm31, %xmm31
vmovq	0x10(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x10(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm2, %ymm2
vmovq	0x18(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x18(%rdx,%r12), %xmm31, %xmm31
vmovq	0x18(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x18(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm3, %ymm3
vmovq	0x20(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x20(%rdx,%r12), %xmm31, %xmm31
vmovq	0x20(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x20(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm4, %ymm4
vmovq	0x28(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x28(%rdx,%r12), %xmm31, %xmm31
vmovq	0x28(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x28(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm5, %ymm5
vmovq	0x30(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x30(%rdx,%r12), %xmm31, %xmm31
vmovq	0x30(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x30(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm6, %ymm6
vmovq	0x38(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x38(%rdx,%r12), %xmm31, %xmm31
vmovq	0x38(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x38(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm7, %ymm7
vmovq	0x40(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x40(%rdx,%r12), %xmm31, %xmm31
vmovq	0x40(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x40(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm8, %ymm8
vmovq	0x48(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x48(%rdx,%r12), %xmm31, %xmm31
vmovq	0x48(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x48(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm9, %ymm9
vmovq	0x50(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x50(%rdx,%r12), %xmm31, %xmm31
vmovq	0x50(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x50(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm10, %ymm10
vmovq	0x58(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x58(%rdx,%r12), %xmm31, %xmm31
vmovq	0x58(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x58(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm11, %ymm11
vmovq	0x60(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x60(%rdx,%r12), %xmm31, %xmm31
vmovq	0x60(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x60(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm12, %ymm12
vmovq	0x68(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x68(%rdx,%r12), %xmm31, %xmm31
vmovq	0x68(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x68(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm13, %ymm13
vmovq	0x70(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x70(%rdx,%r12), %xmm31, %xmm31
vmovq	0x70(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x70(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm14, %ymm14
vmovq	0x78(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x78(%rdx,%r12), %xmm31, %xmm31
vmovq	0x78(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x78(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm15, %ymm15
vmovq	0x80(%rsi,%r12), %xmm31
vpinsrq	$0x1, 0x80(%rdx,%r12), %xmm31, %xmm31
vmovq	0x80(%rcx,%r12), %xmm30
vpinsrq	$0x1, 0x80(%r8,%r12), %xmm30, %xmm30
vinserti32x4	$0x1, %xmm30, %ymm31, %ymm31
vpxorq	%ymm31, %ymm16, %ymm16
subq	$0x88, %r11
addq	$0x88, %r12
callq	keccak_1600_permute
jmp	L_17e0
L_1b20:
callq	keccak_1600_save_state_x4
movq	%r11, 0x320(%rdi)
orq	%r11, %r11
je	L_1b5a
movq	$0x0, 0x320(%rdi)
movq	%rdi, %r10
addq	%r12, %rsi
addq	%r12, %rdx
addq	%r12, %rcx
addq	%r12, %r8
movq	%r11, %r12
callq	keccak_1600_partial_add_x4
movq	%r11, 0x320(%rdi)
L_1b5a:
vpxorq	%xmm16, %xmm16, %xmm16
vmovdqa64	%ymm16, %ymm17
vmovdqa64	%ymm16, %ymm18
vmovdqa64	%ymm16, %ymm19
vmovdqa64	%ymm16, %ymm20
vmovdqa64	%ymm16, %ymm21
vmovdqa64	%ymm16, %ymm22
vmovdqa64	%ymm16, %ymm23
vmovdqa64	%ymm16, %ymm24
vmovdqa64	%ymm16, %ymm25
vmovdqa64	%ymm16, %ymm26
vmovdqa64	%ymm16, %ymm27
vmovdqa64	%ymm16, %ymm28
vmovdqa64	%ymm16, %ymm29
vmovdqa64	%ymm16, %ymm30
vmovdqa64	%ymm16, %ymm31
vzeroall
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbx
popq	%rbp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
SHA3_shake256_x4_inc_finalize_avx512vl:
movq	0x320(%rdi), %r11
movq	%r11, %r10
andl	$-0x8, %r10d
andl	$0x7, %r11d
vmovdqu32	(%rdi,%r10,4), %ymm31
leaq	shake_msg_pad_x4(%rip), %r9
subq	%r11, %r9
vmovdqu32	(%r9), %ymm30
vpxorq	%ymm30, %ymm31, %ymm31
vmovdqu32	%ymm31, (%rdi,%r10,4)
vmovdqu32	0x200(%rdi), %ymm31
vmovdqa32	shake_terminator_byte_x4(%rip), %ymm30
vpxorq	%ymm30, %ymm31, %ymm31
vmovdqu32	%ymm31, 0x200(%rdi)
movq	$0x0, 0x320(%rdi)
vpxorq	%ymm31, %ymm31, %ymm31
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
SHA3_shake256_x4_inc_squeeze_avx512vl:
pushq	%rbp
pushq	%rbx
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
orq	%r8, %r8
je	L_2017
movq	0x320(%r9), %r15
orq	%r15, %r15
jne	L_1ca0
movq	%rdi, %r14
movq	%r9, %rdi
callq	keccak_1600_load_state_x4
movq	%r14, %rdi
xorq	%rbp, %rbp
jmp	L_1d00
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1ca0:
movq	%r9, %r10
movq	%r9, %r14
movq	%r15, %r12
cmpq	%r15, %r8
cmovbq	%r8, %r12
subq	%r12, %r8
movl	$0x88, %r11d
subq	%r15, %r11
subq	%r12, %r15
movq	%r15, 0x320(%r9)
callq	keccak_1600_extract_bytes_x4
movq	%r14, %r9
orq	%r15, %r15
jne	L_2017
movq	%rdi, %r13
movq	%r14, %rdi
callq	keccak_1600_load_state_x4
movq	%r13, %rdi
xorq	%rbp, %rbp
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1d00:
cmpq	$0x88, %r8
jb	L_1fc0
callq	keccak_1600_permute
vextracti64x2	$0x1, %ymm0, %xmm31
vmovq	%xmm0, (%rdi,%rbp)
vpextrq	$0x1, %xmm0, (%rsi,%rbp)
vmovq	%xmm31, (%rdx,%rbp)
vpextrq	$0x1, %xmm31, (%rcx,%rbp)
vextracti64x2	$0x1, %ymm1, %xmm31
vmovq	%xmm1, 0x8(%rdi,%rbp)
vpextrq	$0x1, %xmm1, 0x8(%rsi,%rbp)
vmovq	%xmm31, 0x8(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x8(%rcx,%rbp)
vextracti64x2	$0x1, %ymm2, %xmm31
vmovq	%xmm2, 0x10(%rdi,%rbp)
vpextrq	$0x1, %xmm2, 0x10(%rsi,%rbp)
vmovq	%xmm31, 0x10(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x10(%rcx,%rbp)
vextracti64x2	$0x1, %ymm3, %xmm31
vmovq	%xmm3, 0x18(%rdi,%rbp)
vpextrq	$0x1, %xmm3, 0x18(%rsi,%rbp)
vmovq	%xmm31, 0x18(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x18(%rcx,%rbp)
vextracti64x2	$0x1, %ymm4, %xmm31
vmovq	%xmm4, 0x20(%rdi,%rbp)
vpextrq	$0x1, %xmm4, 0x20(%rsi,%rbp)
vmovq	%xmm31, 0x20(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x20(%rcx,%rbp)
vextracti64x2	$0x1, %ymm5, %xmm31
vmovq	%xmm5, 0x28(%rdi,%rbp)
vpextrq	$0x1, %xmm5, 0x28(%rsi,%rbp)
vmovq	%xmm31, 0x28(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x28(%rcx,%rbp)
vextracti64x2	$0x1, %ymm6, %xmm31
vmovq	%xmm6, 0x30(%rdi,%rbp)
vpextrq	$0x1, %xmm6, 0x30(%rsi,%rbp)
vmovq	%xmm31, 0x30(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x30(%rcx,%rbp)
vextracti64x2	$0x1, %ymm7, %xmm31
vmovq	%xmm7, 0x38(%rdi,%rbp)
vpextrq	$0x1, %xmm7, 0x38(%rsi,%rbp)
vmovq	%xmm31, 0x38(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x38(%rcx,%rbp)
vextracti64x2	$0x1, %ymm8, %xmm31
vmovq	%xmm8, 0x40(%rdi,%rbp)
vpextrq	$0x1, %xmm8, 0x40(%rsi,%rbp)
vmovq	%xmm31, 0x40(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x40(%rcx,%rbp)
vextracti64x2	$0x1, %ymm9, %xmm31
vmovq	%xmm9, 0x48(%rdi,%rbp)
vpextrq	$0x1, %xmm9, 0x48(%rsi,%rbp)
vmovq	%xmm31, 0x48(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x48(%rcx,%rbp)
vextracti64x2	$0x1, %ymm10, %xmm31
vmovq	%xmm10, 0x50(%rdi,%rbp)
vpextrq	$0x1, %xmm10, 0x50(%rsi,%rbp)
vmovq	%xmm31, 0x50(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x50(%rcx,%rbp)
vextracti64x2	$0x1, %ymm11, %xmm31
vmovq	%xmm11, 0x58(%rdi,%rbp)
vpextrq	$0x1, %xmm11, 0x58(%rsi,%rbp)
vmovq	%xmm31, 0x58(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x58(%rcx,%rbp)
vextracti64x2	$0x1, %ymm12, %xmm31
vmovq	%xmm12, 0x60(%rdi,%rbp)
vpextrq	$0x1, %xmm12, 0x60(%rsi,%rbp)
vmovq	%xmm31, 0x60(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x60(%rcx,%rbp)
vextracti64x2	$0x1, %ymm13, %xmm31
vmovq	%xmm13, 0x68(%rdi,%rbp)
vpextrq	$0x1, %xmm13, 0x68(%rsi,%rbp)
vmovq	%xmm31, 0x68(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x68(%rcx,%rbp)
vextracti64x2	$0x1, %ymm14, %xmm31
vmovq	%xmm14, 0x70(%rdi,%rbp)
vpextrq	$0x1, %xmm14, 0x70(%rsi,%rbp)
vmovq	%xmm31, 0x70(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x70(%rcx,%rbp)
vextracti64x2	$0x1, %ymm15, %xmm31
vmovq	%xmm15, 0x78(%rdi,%rbp)
vpextrq	$0x1, %xmm15, 0x78(%rsi,%rbp)
vmovq	%xmm31, 0x78(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x78(%rcx,%rbp)
vextracti64x2	$0x1, %ymm16, %xmm31
vmovq	%xmm16, 0x80(%rdi,%rbp)
vpextrq	$0x1, %xmm16, 0x80(%rsi,%rbp)
vmovq	%xmm31, 0x80(%rdx,%rbp)
vpextrq	$0x1, %xmm31, 0x80(%rcx,%rbp)
addq	$0x88, %rbp
subq	$0x88, %r8
jmp	L_1d00
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_1fc0:
orq	%r8, %r8
je	L_2004
addq	%rbp, %rdi
addq	%rbp, %rsi
addq	%rbp, %rdx
addq	%rbp, %rcx
movl	$0x88, %r15d
subq	%r8, %r15
movq	%r15, 0x320(%r9)
callq	keccak_1600_permute
movq	%rdi, %r14
movq	%r9, %rdi
callq	keccak_1600_save_state_x4
movq	%r14, %rdi
movq	%r9, %r10
movq	%r8, %r12
xorq	%r11, %r11
callq	keccak_1600_extract_bytes_x4
jmp	L_2017
L_2004:
movq	$0x0, 0x320(%r9)
movq	%r9, %rdi
callq	keccak_1600_save_state_x4
L_2017:
vpxorq	%xmm16, %xmm16, %xmm16
vmovdqa64	%ymm16, %ymm17
vmovdqa64	%ymm16, %ymm18
vmovdqa64	%ymm16, %ymm19
vmovdqa64	%ymm16, %ymm20
vmovdqa64	%ymm16, %ymm21
vmovdqa64	%ymm16, %ymm22
vmovdqa64	%ymm16, %ymm23
vmovdqa64	%ymm16, %ymm24
vmovdqa64	%ymm16, %ymm25
vmovdqa64	%ymm16, %ymm26
vmovdqa64	%ymm16, %ymm27
vmovdqa64	%ymm16, %ymm28
vmovdqa64	%ymm16, %ymm29
vmovdqa64	%ymm16, %ymm30
vmovdqa64	%ymm16, %ymm31
vzeroall
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbx
popq	%rbp
rep	retq
	.section .rodata
	.p2align 7
iotas:
	.size iotas, 192
	.byte 1,0,0,0,0,0,0,0,130,128,0,0,0,0,0,0
	.byte 138,128,0,0,0,0,0,128,0,128,0,128,0,0,0,128
	.byte 139,128,0,0,0,0,0,0,1,0,0,128,0,0,0,0
	.byte 129,128,0,128,0,0,0,128,9,128,0,0,0,0,0,128
	.byte 138,0,0,0,0,0,0,0,136,0,0,0,0,0,0,0
	.byte 9,128,0,128,0,0,0,0,10,0,0,128,0,0,0,0
	.byte 139,128,0,128,0,0,0,0,139,0,0,0,0,0,0,128
	.byte 137,128,0,0,0,0,0,128,3,128,0,0,0,0,0,128
	.byte 2,128,0,0,0,0,0,128,128,0,0,0,0,0,0,128
	.byte 10,128,0,0,0,0,0,0,10,0,0,128,0,0,0,128
	.byte 129,128,0,128,0,0,0,128,128,128,0,0,0,0,0,128
	.byte 1,0,0,128,0,0,0,0,8,128,0,128,0,0,0,128
byte_kmask_0_to_7:
	.byte 0,1,3,7,15,31,63,127,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
shake_terminator_byte_x4:
	.byte 0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,128
	.byte 0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,128
	.byte 0,0,0,0,0,0,0,0
shake_msg_pad_x4:
	.byte 31,0,0,0,0,0,0,0,31,0,0,0,0,0,0,0
	.byte 31,0,0,0,0,0,0,0,31,0,0,0,0,0,0,0
	.byte 75,101,99,99,97,107,45,49,54,48,48,32,97,98,115,111
	.byte 114,98,32,97,110,100,32,115,113,117,101,101,122,101,32,102
	.byte 111,114,32,65,86,88,53,49,50,86,76,44,32,67,82,89
	.byte 80,84,79,71,65,77,83,32,98,121,32,60,97,112,112,114
	.byte 111,64,111,112,101,110,115,115,108,46,111,114,103,62,0
# ---- x86_64cpuid.S, for OPENSSL_ia32cap_P
	.text
	.text
OPENSSL_atomic_add:
endbr64
movl	(%rdi), %eax
Lx86_64cpuid__6:
leaq	(%rsi,%rax), %r8
lock
cmpxchgl	%r8d, (%rdi)
jne	Lx86_64cpuid__6
movl	%r8d, %eax
cltq
rep	retq
nopl	(%rax,%rax)
OPENSSL_rdtsc:
endbr64
rdtsc
shlq	$0x20, %rdx
orq	%rdx, %rax
rep	retq
nop
OPENSSL_ia32_cpuid:
endbr64
movq	%rbx, %r8
xorl	%eax, %eax
movq	%rax, 0x8(%rdi)
cpuid
movl	%eax, %r11d
xorl	%eax, %eax
cmpl	$0x756e6547, %ebx
setne	%al
movl	%eax, %r9d
cmpl	$0x49656e69, %edx
setne	%al
orl	%eax, %r9d
cmpl	$0x6c65746e, %ecx
setne	%al
orl	%eax, %r9d
je	Lx86_64cpuid__f5
cmpl	$0x68747541, %ebx
setne	%al
movl	%eax, %r10d
cmpl	$0x69746e65, %edx
setne	%al
orl	%eax, %r10d
cmpl	$0x444d4163, %ecx
setne	%al
orl	%eax, %r10d
jne	Lx86_64cpuid__f5
movl	$0x80000000, %eax
cpuid
cmpl	$0x80000001, %eax
jb	Lx86_64cpuid__f5
movl	%eax, %r10d
movl	$0x80000001, %eax
cpuid
orl	%ecx, %r9d
andl	$0x801, %r9d
cmpl	$0x80000008, %r10d
jb	Lx86_64cpuid__f5
movl	$0x80000008, %eax
cpuid
movzbq	%cl, %r10
incq	%r10
movl	$0x1, %eax
cpuid
btl	$0x1c, %edx
jae	Lx86_64cpuid__18a
shrl	$0x10, %ebx
cmpb	%r10b, %bl
ja	Lx86_64cpuid__18a
andl	$0xefffffff, %edx
jmp	Lx86_64cpuid__18a
Lx86_64cpuid__f5:
cmpl	$0x4, %r11d
movl	$0xffffffff, %r10d
jb	Lx86_64cpuid__11b
movl	$0x4, %eax
movl	$0x0, %ecx
cpuid
movl	%eax, %r10d
shrl	$0xe, %r10d
andl	$0xfff, %r10d
Lx86_64cpuid__11b:
movl	$0x1, %eax
cpuid
movd	%eax, %xmm0
andl	$0xbfefffff, %edx
cmpl	$0x0, %r9d
jne	Lx86_64cpuid__164
orl	$0x40000000, %edx
andb	$0xf, %ah
cmpb	$0xf, %ah
jne	Lx86_64cpuid__146
orl	$0x100000, %edx
Lx86_64cpuid__146:
cmpb	$0x6, %ah
jne	Lx86_64cpuid__164
andl	$0xfff0ff0, %eax
cmpl	$0x50670, %eax
je	Lx86_64cpuid__15e
cmpl	$0x80650, %eax
jne	Lx86_64cpuid__164
Lx86_64cpuid__15e:
andl	$0xfbffffff, %ecx
Lx86_64cpuid__164:
btl	$0x1c, %edx
jae	Lx86_64cpuid__18a
andl	$0xefffffff, %edx
cmpl	$0x0, %r10d
je	Lx86_64cpuid__18a
orl	$0x10000000, %edx
shrl	$0x10, %ebx
cmpb	$0x1, %bl
ja	Lx86_64cpuid__18a
andl	$0xefffffff, %edx
Lx86_64cpuid__18a:
andl	$0x800, %r9d
andl	$0xfffff7ff, %ecx
orl	%ecx, %r9d
movl	%edx, %r10d
cmpl	$0x7, %r11d
jb	Lx86_64cpuid__217
movl	$0x7, %eax
xorl	%ecx, %ecx
cpuid
movd	%eax, %xmm1
btl	$0x1a, %r9d
jb	Lx86_64cpuid__1bd
andl	$0xfff7ffff, %ebx
Lx86_64cpuid__1bd:
movd	%xmm0, %eax
andl	$0xfff0ff0, %eax
cmpl	$0x50650, %eax
jne	Lx86_64cpuid__1d3
andl	$0xfffeffff, %ebx
Lx86_64cpuid__1d3:
movl	%ebx, 0x8(%rdi)
movl	%ecx, 0xc(%rdi)
movl	%edx, 0x10(%rdi)
movd	%xmm1, %eax
cmpl	$0x1, %eax
jb	Lx86_64cpuid__217
movl	$0x7, %eax
movl	$0x1, %ecx
cpuid
movl	%eax, 0x14(%rdi)
movl	%edx, 0x18(%rdi)
movl	%ebx, 0x1c(%rdi)
movl	%ecx, 0x20(%rdi)
andl	$0x80000, %edx
cmpl	$0x0, %edx
je	Lx86_64cpuid__217
movl	$0x24, %eax
movl	$0x0, %ecx
cpuid
movl	%ebx, 0x24(%rdi)
Lx86_64cpuid__217:
btl	$0x1b, %r9d
jae	Lx86_64cpuid__23e
xorl	%ecx, %ecx
xgetbv
andl	$0xe6, %eax
cmpl	$0xe6, %eax
je	Lx86_64cpuid__255
andl	$0x3fdeffff, 0x8(%rdi)
andl	$0x6, %eax
cmpl	$0x6, %eax
je	Lx86_64cpuid__255
Lx86_64cpuid__23e:
andl	$0xff7fffff, 0x14(%rdi)
movl	$0xefffe7ff, %eax
andl	%eax, %r9d
movl	$0x3fdeffdf, %eax
andl	%eax, 0x8(%rdi)
Lx86_64cpuid__255:
shlq	$0x20, %r9
movl	%r10d, %eax
movq	%r8, %rbx
orq	%r9, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nop
OPENSSL_cleanse:
endbr64
xorq	%rax, %rax
cmpq	$0xf, %rsi
jae	Lx86_64cpuid__2a0
cmpq	$0x0, %rsi
je	Lx86_64cpuid__28f
Lx86_64cpuid__283:
movb	%al, (%rdi)
subq	$0x1, %rsi
leaq	0x1(%rdi), %rdi
jne	Lx86_64cpuid__283
Lx86_64cpuid__28f:
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64cpuid__2a0:
testq	$0x7, %rdi
je	Lx86_64cpuid__2b5
movb	%al, (%rdi)
leaq	-0x1(%rsi), %rsi
leaq	0x1(%rdi), %rdi
jmp	Lx86_64cpuid__2a0
Lx86_64cpuid__2b5:
movq	%rax, (%rdi)
leaq	-0x8(%rsi), %rsi
testq	$-0x8, %rsi
leaq	0x8(%rdi), %rdi
jne	Lx86_64cpuid__2b5
cmpq	$0x0, %rsi
jne	Lx86_64cpuid__283
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
CRYPTO_memcmp:
endbr64
xorq	%rax, %rax
xorq	%r10, %r10
cmpq	$0x0, %rdx
je	Lx86_64cpuid__33d
cmpq	$0x10, %rdx
jne	Lx86_64cpuid__320
movq	(%rdi), %r10
movq	0x8(%rdi), %r11
movq	$0x1, %rdx
xorq	(%rsi), %r10
xorq	0x8(%rsi), %r11
orq	%r11, %r10
cmovneq	%rdx, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nop
Lx86_64cpuid__320:
movb	(%rdi), %r10b
leaq	0x1(%rdi), %rdi
xorb	(%rsi), %r10b
leaq	0x1(%rsi), %rsi
orb	%r10b, %al
decq	%rdx
jne	Lx86_64cpuid__320
negq	%rax
shrq	$0x3f, %rax
Lx86_64cpuid__33d:
rep	retq
nop
OPENSSL_instrument_bus:
endbr64
movq	%rdi, %r10
movq	%rsi, %rcx
movq	%rsi, %r11
rdtsc
movl	%eax, %r8d
movl	$0x0, %r9d
clflush	(%r10)
lock
addl	%r9d, (%r10)
jmp	Lx86_64cpuid__370
nopw	%cs:(%rax,%rax)
nopl	(%rax)
Lx86_64cpuid__370:
rdtsc
movl	%eax, %edx
subl	%r8d, %eax
movl	%edx, %r8d
movl	%eax, %r9d
clflush	(%r10)
lock
addl	%eax, (%r10)
leaq	0x4(%r10), %r10
subq	$0x1, %rcx
jne	Lx86_64cpuid__370
movq	%r11, %rax
rep	retq
nopw	%cs:(%rax,%rax)
nop
OPENSSL_instrument_bus2:
endbr64
movq	%rdi, %r10
movq	%rsi, %rcx
movq	%rdx, %r11
movq	%rcx, 0x8(%rsp)
rdtsc
movl	%eax, %r8d
movl	$0x0, %r9d
clflush	(%r10)
lock
addl	%r9d, (%r10)
rdtsc
movl	%eax, %edx
subl	%r8d, %eax
movl	%edx, %r8d
movl	%eax, %r9d
Lx86_64cpuid__3d2:
clflush	(%r10)
lock
addl	%eax, (%r10)
subq	$0x1, %r11
je	Lx86_64cpuid__401
rdtsc
movl	%eax, %edx
subl	%r8d, %eax
movl	%edx, %r8d
cmpl	%r9d, %eax
movl	%eax, %r9d
movl	$0x0, %edx
setne	%dl
subq	%rdx, %rcx
leaq	(%r10,%rdx,4), %r10
jne	Lx86_64cpuid__3d2
Lx86_64cpuid__401:
movq	0x8(%rsp), %rax
subq	%rcx, %rax
rep	retq
nopl	(%rax,%rax)
OPENSSL_ia32_rdrand_bytes:
endbr64
xorq	%rax, %rax
cmpq	$0x0, %rsi
je	Lx86_64cpuid__473
movq	$0x8, %r11
Lx86_64cpuid__424:
rdrandq	%r10
jb	Lx86_64cpuid__440
decq	%r11
jne	Lx86_64cpuid__424
jmp	Lx86_64cpuid__473
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64cpuid__440:
cmpq	$0x8, %rsi
jb	Lx86_64cpuid__460
movq	%r10, (%rdi)
leaq	0x8(%rdi), %rdi
addq	$0x8, %rax
subq	$0x8, %rsi
je	Lx86_64cpuid__473
movq	$0x8, %r11
jmp	Lx86_64cpuid__424
Lx86_64cpuid__460:
movb	%r10b, (%rdi)
leaq	0x1(%rdi), %rdi
incq	%rax
shrq	$0x8, %r10
decq	%rsi
jne	Lx86_64cpuid__460
Lx86_64cpuid__473:
xorq	%r10, %r10
rep	retq
nopl	(%rax,%rax)
OPENSSL_ia32_rdseed_bytes:
endbr64
xorq	%rax, %rax
cmpq	$0x0, %rsi
je	Lx86_64cpuid__4e3
movq	$0x8, %r11
Lx86_64cpuid__494:
rdseedq	%r10
jb	Lx86_64cpuid__4b0
decq	%r11
jne	Lx86_64cpuid__494
jmp	Lx86_64cpuid__4e3
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Lx86_64cpuid__4b0:
cmpq	$0x8, %rsi
jb	Lx86_64cpuid__4d0
movq	%r10, (%rdi)
leaq	0x8(%rdi), %rdi
addq	$0x8, %rax
subq	$0x8, %rsi
je	Lx86_64cpuid__4e3
movq	$0x8, %r11
jmp	Lx86_64cpuid__494
Lx86_64cpuid__4d0:
movb	%r10b, (%rdi)
leaq	0x1(%rdi), %rdi
incq	%rax
shrq	$0x8, %r10
decq	%rsi
jne	Lx86_64cpuid__4d0
Lx86_64cpuid__4e3:
xorq	%r10, %r10
rep	retq
	.section *COM*
	.zero 40
OPENSSL_ia32cap_P:
	.size OPENSSL_ia32cap_P, 4
	.zero 4

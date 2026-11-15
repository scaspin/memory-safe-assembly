	.text
aesni_xts_avx512_eligible:
movl	OPENSSL_ia32cap_P+8(%rip), %ecx
xorl	%eax, %eax
andl	$0xc0030000, %ecx
cmpl	$0xc0030000, %ecx
jne	L_2b
movl	OPENSSL_ia32cap_P+12(%rip), %ecx
andl	$0x640, %ecx
cmpl	$0x640, %ecx
cmovel	%ecx, %eax
L_2b:
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
aesni_xts_128_encrypt_avx512:
endbr64
pushq	%rbp
movq	%rsp, %rbp
subq	$0x88, %rsp
andq	$-0x40, %rsp
movq	%rbx, 0x80(%rsp)
movq	$0x87, %r10
vmovdqu	(%r9), %xmm1
vpxor	(%r8), %xmm1, %xmm1
vaesenc	0x10(%r8), %xmm1, %xmm1
vaesenc	0x20(%r8), %xmm1, %xmm1
vaesenc	0x30(%r8), %xmm1, %xmm1
vaesenc	0x40(%r8), %xmm1, %xmm1
vaesenc	0x50(%r8), %xmm1, %xmm1
vaesenc	0x60(%r8), %xmm1, %xmm1
vaesenc	0x70(%r8), %xmm1, %xmm1
vaesenc	0x80(%r8), %xmm1, %xmm1
vaesenc	0x90(%r8), %xmm1, %xmm1
vaesenclast	0xa0(%r8), %xmm1, %xmm1
vmovdqa	%xmm1, (%rsp)
cmpq	$0x80, %rdx
jl	L_d1e
vpbroadcastq	%r10, %zmm25
cmpq	$0x100, %rdx
jge	L_76b
cmpq	$0x80, %rdx
jge	L_a87
L_e3:
cmpq	$0x0, %rdx
je	L_cfc
cmpq	$0x70, %rdx
jge	L_13c
cmpq	$0x60, %rdx
jge	L_268
cmpq	$0x50, %rdx
jge	L_385
cmpq	$0x40, %rdx
jge	L_49b
cmpq	$0x30, %rdx
jge	L_560
cmpq	$0x20, %rdx
jge	L_636
cmpq	$0x10, %rdx
jge	L_6f0
vmovdqa	%xmm0, %xmm8
vmovdqa	%xmm9, %xmm0
jmp	L_c60
L_13c:
movabsq	$0xffffffffffff, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2 {%k1}
addq	$0x70, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
addq	$0x70, %rsi
vextracti32x4	$0x2, %zmm2, %xmm8
vextracti32x4	$0x3, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_268:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %ymm2
addq	$0x60, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
addq	$0x60, %rsi
vextracti32x4	$0x1, %zmm2, %xmm8
vextracti32x4	$0x2, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_385:
vmovdqu8	(%rdi), %zmm1
vmovdqu	0x40(%rdi), %xmm2
addq	$0x50, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu	%xmm2, 0x40(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm2, %xmm8
vextracti32x4	$0x1, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_49b:
vmovdqu8	(%rdi), %zmm1
addq	$0x40, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi)
addq	$0x40, %rsi
vextracti32x4	$0x3, %zmm1, %xmm8
vmovdqa64	%xmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_560:
movq	$-0x1, %r8
shrq	$0x10, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1 {%k1}
addq	$0x30, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi) {%k1}
addq	$0x30, %rsi
vextracti32x4	$0x2, %zmm1, %xmm8
vextracti32x4	$0x3, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_636:
vmovdqu8	(%rdi), %ymm1
addq	$0x20, %rdi
vbroadcasti32x4	(%rcx), %ymm0
vpternlogq	$0x96, %ymm0, %ymm9, %ymm1
vbroadcasti32x4	0x10(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x20(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x30(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x40(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x50(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x60(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x70(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x80(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x90(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xa0(%rcx), %ymm0
vaesenclast	%ymm0, %ymm1, %ymm1
vpxorq	%ymm9, %ymm1, %ymm1
vmovdqu	%ymm1, (%rsi)
addq	$0x20, %rsi
vextracti32x4	$0x1, %zmm1, %xmm8
vextracti32x4	$0x2, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_6f0:
vmovdqu	(%rdi), %xmm1
addq	$0x10, %rdi
vpxor	%xmm1, %xmm9, %xmm1
vpxor	(%rcx), %xmm1, %xmm1
vaesenc	0x10(%rcx), %xmm1, %xmm1
vaesenc	0x20(%rcx), %xmm1, %xmm1
vaesenc	0x30(%rcx), %xmm1, %xmm1
vaesenc	0x40(%rcx), %xmm1, %xmm1
vaesenc	0x50(%rcx), %xmm1, %xmm1
vaesenc	0x60(%rcx), %xmm1, %xmm1
vaesenc	0x70(%rcx), %xmm1, %xmm1
vaesenc	0x80(%rcx), %xmm1, %xmm1
vaesenc	0x90(%rcx), %xmm1, %xmm1
vaesenclast	0xa0(%rcx), %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	%xmm1, (%rsi)
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
vextracti32x4	$0x1, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_76b:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm11
vpxord	%zmm14, %zmm11, %zmm11
vpsrldq	$0xf, %zmm10, %zmm15
vpclmulqdq	$0x0, %zmm25, %zmm15, %zmm16
vpslldq	$0x1, %zmm10, %zmm12
vpxord	%zmm16, %zmm12, %zmm12
L_812:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
vmovdqu8	0x80(%rdi), %zmm3
vmovdqu8	0xc0(%rdi), %zmm4
addq	$0x100, %rdi
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vpxorq	%zmm0, %zmm3, %zmm3
vpxorq	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm11, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm11, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm12, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm12, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm15, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm15, %zmm17
vpxord	%zmm14, %zmm17, %zmm17
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm16, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm16, %zmm18
vpxord	%zmm14, %zmm18, %zmm18
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vaesenclast	%zmm0, %zmm3, %zmm3
vaesenclast	%zmm0, %zmm4, %zmm4
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqa32	%zmm17, %zmm11
vmovdqa32	%zmm18, %zmm12
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
vmovdqu8	%zmm3, 0x80(%rsi)
vmovdqu8	%zmm4, 0xc0(%rsi)
addq	$0x100, %rsi
subq	$0x100, %rdx
cmpq	$0x100, %rdx
jae	L_812
cmpq	$0x80, %rdx
jae	L_af8
vextracti32x4	$0x3, %zmm4, %xmm0
jmp	L_e3
L_a87:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
L_af8:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
addq	$0x80, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vpsrldq	$0xf, %zmm10, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm10, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
addq	$0x80, %rsi
subq	$0x80, %rdx
cmpq	$0x80, %rdx
jae	L_af8
vextracti32x4	$0x3, %zmm2, %xmm0
jmp	L_e3
L_c60:
vmovdqa	%xmm8, %xmm2
leaq	vpshufb_shf_table(%rip), %rax
vmovdqu	(%rax,%rdx), %xmm10
vpshufb	%xmm10, %xmm8, %xmm8
vmovdqu	-0x10(%rdi,%rdx), %xmm3
vmovdqu	%xmm8, -0x10(%rsi,%rdx)
leaq	vpshufb_shf_table(%rip), %rax
addq	$0x10, %rax
subq	%rdx, %rax
vmovdqu	(%rax), %xmm10
vpxor	mask1(%rip), %xmm10, %xmm10
vpshufb	%xmm10, %xmm3, %xmm3
vpblendvb	%xmm10, %xmm2, %xmm3, %xmm3
vpxor	%xmm0, %xmm3, %xmm8
vpxor	(%rcx), %xmm8, %xmm8
vaesenc	0x10(%rcx), %xmm8, %xmm8
vaesenc	0x20(%rcx), %xmm8, %xmm8
vaesenc	0x30(%rcx), %xmm8, %xmm8
vaesenc	0x40(%rcx), %xmm8, %xmm8
vaesenc	0x50(%rcx), %xmm8, %xmm8
vaesenc	0x60(%rcx), %xmm8, %xmm8
vaesenc	0x70(%rcx), %xmm8, %xmm8
vaesenc	0x80(%rcx), %xmm8, %xmm8
vaesenc	0x90(%rcx), %xmm8, %xmm8
vaesenclast	0xa0(%rcx), %xmm8, %xmm8
vpxor	%xmm0, %xmm8, %xmm8
vmovdqu	%xmm8, -0x10(%rsi)
L_cfc:
movq	0x80(%rsp), %rbx
xorq	%r8, %r8
movq	%r8, 0x80(%rsp)
vpxorq	%zmm0, %zmm0, %zmm0
movq	%rbp, %rsp
popq	%rbp
vzeroupper
rep	retq
L_d1e:
vpbroadcastq	%r10, %zmm25
cmpq	$0x10, %rdx
jb	L_cfc
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movl	$0xaa, %r8d
kmovq	%r8, %k2
movq	%rdx, %r8
andq	$0x70, %r8
cmpq	$0x60, %r8
je	L_f09
cmpq	$0x50, %r8
je	L_107a
cmpq	$0x40, %r8
je	L_11e8
cmpq	$0x30, %r8
je	L_12ff
cmpq	$0x20, %r8
je	L_1401
cmpq	$0x10, %r8
je	L_14ea
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
movabsq	$0xffffffffffff, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2 {%k1}
addq	$0x70, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
addq	$0x70, %rsi
vextracti32x4	$0x2, %zmm2, %xmm8
vextracti32x4	$0x3, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_f09:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %ymm2
addq	$0x60, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
addq	$0x60, %rsi
vextracti32x4	$0x1, %ymm2, %xmm8
vextracti32x4	$0x2, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_107a:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %xmm2
addq	$0x50, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%xmm2, 0x40(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm2, %xmm8
vextracti32x4	$0x1, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_11e8:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vmovdqu8	(%rdi), %zmm1
addq	$0x40, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi)
addq	$0x40, %rsi
vextracti32x4	$0x3, %zmm1, %xmm8
vmovdqa	%xmm10, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_12ff:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
movabsq	$0xffffffffffff, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1 {%k1}
addq	$0x30, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi) {%k1}
addq	$0x30, %rsi
vextracti32x4	$0x2, %zmm1, %xmm8
vextracti32x4	$0x3, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_1401:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vmovdqu8	(%rdi), %ymm1
addq	$0x20, %rdi
vbroadcasti32x4	(%rcx), %ymm0
vpternlogq	$0x96, %ymm0, %ymm9, %ymm1
vbroadcasti32x4	0x10(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x20(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x30(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x40(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x50(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x60(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x70(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x80(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x90(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xa0(%rcx), %ymm0
vaesenclast	%ymm0, %ymm1, %ymm1
vpxorq	%ymm9, %ymm1, %ymm1
vmovdqu8	%ymm1, (%rsi)
addq	$0x20, %rsi
vextracti32x4	$0x1, %ymm1, %xmm8
vextracti32x4	$0x2, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
L_14ea:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vmovdqu8	(%rdi), %xmm1
addq	$0x10, %rdi
vbroadcasti32x4	(%rcx), %ymm0
vpternlogq	$0x96, %ymm0, %ymm9, %ymm1
vbroadcasti32x4	0x10(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x20(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x30(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x40(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x50(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x60(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x70(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x80(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x90(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xa0(%rcx), %ymm0
vaesenclast	%ymm0, %ymm1, %ymm1
vpxorq	%ymm9, %ymm1, %ymm1
vmovdqu8	%xmm1, (%rsi)
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
vextracti32x4	$0x1, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_cfc
jmp	L_c60
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
aesni_xts_128_decrypt_avx512:
endbr64
pushq	%rbp
movq	%rsp, %rbp
subq	$0x88, %rsp
andq	$-0x40, %rsp
movq	%rbx, 0x80(%rsp)
movq	$0x87, %r10
vmovdqu	(%r9), %xmm1
vpxor	(%r8), %xmm1, %xmm1
vaesenc	0x10(%r8), %xmm1, %xmm1
vaesenc	0x20(%r8), %xmm1, %xmm1
vaesenc	0x30(%r8), %xmm1, %xmm1
vaesenc	0x40(%r8), %xmm1, %xmm1
vaesenc	0x50(%r8), %xmm1, %xmm1
vaesenc	0x60(%r8), %xmm1, %xmm1
vaesenc	0x70(%r8), %xmm1, %xmm1
vaesenc	0x80(%r8), %xmm1, %xmm1
vaesenc	0x90(%r8), %xmm1, %xmm1
vaesenclast	0xa0(%r8), %xmm1, %xmm1
vmovdqa	%xmm1, (%rsp)
cmpq	$0x80, %rdx
jb	L_2bc3
vpbroadcastq	%r10, %zmm25
cmpq	$0x100, %rdx
jge	L_2606
jmp	L_2922
L_167b:
cmpq	$0x0, %rdx
je	L_2ba1
cmpq	$0x70, %rdx
jge	L_1798
cmpq	$0x60, %rdx
jge	L_19f3
cmpq	$0x50, %rdx
jge	L_1c3e
cmpq	$0x40, %rdx
jge	L_1e79
cmpq	$0x30, %rdx
jge	L_20a8
cmpq	$0x20, %rdx
jge	L_230b
cmpq	$0x10, %rdx
jge	L_24d5
vmovdqu	%xmm5, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	%xmm1, -0x10(%rsi)
vmovdqa	%xmm1, %xmm8
movq	$0x1, %r8
kmovq	%r8, %k1
vpsllq	$0x3f, %xmm9, %xmm13
vpsraq	$0x3f, %xmm13, %xmm14
vpandq	%xmm25, %xmm14, %xmm5
vpxorq	%xmm5, %xmm9, %xmm9 {%k1}
vpsrldq	$0x8, %xmm9, %xmm10
vpshrdq	$0x1, %xmm10, %xmm9, %xmm0
vpslldq	$0x8, %xmm13, %xmm13
vpxorq	%xmm13, %xmm0, %xmm0
jmp	L_2b05
L_1798:
movq	$-0x1, %r8
shrq	$0x10, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2 {%k1}
addq	$0x70, %rdi
andq	$0xf, %rdx
je	L_18ed
vextracti32x4	$0x2, %zmm10, %xmm12
vextracti32x4	$0x3, %zmm10, %xmm13
vinserti32x4	$0x2, %xmm13, %zmm10, %zmm10
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
addq	$0x70, %rsi
vextracti32x4	$0x2, %zmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_2b05
L_18ed:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
jmp	L_2ba1
L_19f3:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %ymm2
addq	$0x60, %rdi
andq	$0xf, %rdx
je	L_1b38
vextracti32x4	$0x1, %zmm10, %xmm12
vextracti32x4	$0x2, %zmm10, %xmm13
vinserti32x4	$0x1, %xmm13, %zmm10, %zmm10
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
addq	$0x60, %rsi
vextracti32x4	$0x1, %zmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_2b05
L_1b38:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
jmp	L_2ba1
L_1c3e:
vmovdqu8	(%rdi), %zmm1
vmovdqu	0x40(%rdi), %xmm2
addq	$0x50, %rdi
andq	$0xf, %rdx
je	L_1d73
vmovdqa	%xmm10, %xmm12
vextracti32x4	$0x1, %zmm10, %xmm10
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu	%xmm2, 0x40(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_2b05
L_1d73:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%xmm2, 0x40(%rsi)
jmp	L_2ba1
L_1e79:
vmovdqu8	(%rdi), %zmm1
addq	$0x40, %rdi
andq	$0xf, %rdx
je	L_1fa9
vextracti32x4	$0x3, %zmm9, %xmm12
vinserti32x4	$0x3, %xmm10, %zmm9, %zmm9
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
addq	$0x40, %rsi
vextracti32x4	$0x3, %zmm1, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_2b05
L_1fa9:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
jmp	L_2ba1
L_20a8:
vmovdqu	(%rdi), %xmm1
vmovdqu	0x10(%rdi), %xmm2
vmovdqu	0x20(%rdi), %xmm3
addq	$0x30, %rdi
andq	$0xf, %rdx
je	L_21f1
vextracti32x4	$0x2, %zmm9, %xmm13
vextracti32x4	$0x1, %zmm9, %xmm10
vextracti32x4	$0x3, %zmm9, %xmm11
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
addq	$0x30, %rsi
vmovdqa	%xmm3, %xmm8
vmovdqa	%xmm13, %xmm0
jmp	L_2b05
L_21f1:
vextracti32x4	$0x1, %zmm9, %xmm10
vextracti32x4	$0x2, %zmm9, %xmm11
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
jmp	L_2ba1
L_230b:
vmovdqu	(%rdi), %xmm1
vmovdqu	0x10(%rdi), %xmm2
addq	$0x20, %rdi
andq	$0xf, %rdx
je	L_2405
vextracti32x4	$0x2, %zmm9, %xmm10
vextracti32x4	$0x1, %zmm9, %xmm12
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
addq	$0x20, %rsi
vmovdqa	%xmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_2b05
L_2405:
vextracti32x4	$0x1, %zmm9, %xmm10
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
jmp	L_2ba1
L_24d5:
vmovdqu	(%rdi), %xmm1
addq	$0x10, %rdi
andq	$0xf, %rdx
je	L_2580
vextracti32x4	$0x1, %zmm9, %xmm11
vpxor	%xmm1, %xmm11, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm11, %xmm1
vmovdqu	%xmm1, (%rsi)
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
vmovdqa	%xmm9, %xmm0
jmp	L_2b05
L_2580:
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	%xmm1, (%rsi)
jmp	L_2ba1
L_2606:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm11
vpxord	%zmm14, %zmm11, %zmm11
vpsrldq	$0xf, %zmm10, %zmm15
vpclmulqdq	$0x0, %zmm25, %zmm15, %zmm16
vpslldq	$0x1, %zmm10, %zmm12
vpxord	%zmm16, %zmm12, %zmm12
L_26ad:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
vmovdqu8	0x80(%rdi), %zmm3
vmovdqu8	0xc0(%rdi), %zmm4
vmovdqu8	0xf0(%rdi), %xmm5
addq	$0x100, %rdi
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vpxorq	%zmm0, %zmm3, %zmm3
vpxorq	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm11, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm11, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm12, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm12, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm15, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm15, %zmm17
vpxord	%zmm14, %zmm17, %zmm17
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm16, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm16, %zmm18
vpxord	%zmm14, %zmm18, %zmm18
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vaesdeclast	%zmm0, %zmm3, %zmm3
vaesdeclast	%zmm0, %zmm4, %zmm4
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqa32	%zmm17, %zmm11
vmovdqa32	%zmm18, %zmm12
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
vmovdqu8	%zmm3, 0x80(%rsi)
vmovdqu8	%zmm4, 0xc0(%rsi)
addq	$0x100, %rsi
subq	$0x100, %rdx
cmpq	$0x100, %rdx
jge	L_26ad
cmpq	$0x80, %rdx
jge	L_2993
jmp	L_167b
L_2922:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
L_2993:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
vmovdqu8	0x70(%rdi), %xmm5
addq	$0x80, %rdi
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vpsrldq	$0xf, %zmm10, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm10, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
addq	$0x80, %rsi
subq	$0x80, %rdx
cmpq	$0x80, %rdx
jge	L_2993
jmp	L_167b
L_2b05:
vmovdqa	%xmm8, %xmm2
leaq	vpshufb_shf_table(%rip), %rax
vmovdqu	(%rax,%rdx), %xmm10
vpshufb	%xmm10, %xmm8, %xmm8
vmovdqu	-0x10(%rdi,%rdx), %xmm3
vmovdqu	%xmm8, -0x10(%rsi,%rdx)
leaq	vpshufb_shf_table(%rip), %rax
addq	$0x10, %rax
subq	%rdx, %rax
vmovdqu	(%rax), %xmm10
vpxor	mask1(%rip), %xmm10, %xmm10
vpshufb	%xmm10, %xmm3, %xmm3
vpblendvb	%xmm10, %xmm2, %xmm3, %xmm3
vpxor	%xmm0, %xmm3, %xmm8
vpxor	(%rcx), %xmm8, %xmm8
vaesdec	0x10(%rcx), %xmm8, %xmm8
vaesdec	0x20(%rcx), %xmm8, %xmm8
vaesdec	0x30(%rcx), %xmm8, %xmm8
vaesdec	0x40(%rcx), %xmm8, %xmm8
vaesdec	0x50(%rcx), %xmm8, %xmm8
vaesdec	0x60(%rcx), %xmm8, %xmm8
vaesdec	0x70(%rcx), %xmm8, %xmm8
vaesdec	0x80(%rcx), %xmm8, %xmm8
vaesdec	0x90(%rcx), %xmm8, %xmm8
vaesdeclast	0xa0(%rcx), %xmm8, %xmm8
vpxor	%xmm0, %xmm8, %xmm8
L_2b9c:
vmovdqu	%xmm8, -0x10(%rsi)
L_2ba1:
movq	0x80(%rsp), %rbx
xorq	%r8, %r8
movq	%r8, 0x80(%rsp)
vpxorq	%zmm0, %zmm0, %zmm0
movq	%rbp, %rsp
popq	%rbp
vzeroupper
rep	retq
L_2bc3:
cmpq	$0x10, %rdx
jb	L_2ba1
movq	%rdx, %r8
andq	$0x70, %r8
cmpq	$0x60, %r8
je	L_316c
cmpq	$0x50, %r8
je	L_361f
cmpq	$0x40, %r8
je	L_3a27
cmpq	$0x30, %r8
je	L_3d84
cmpq	$0x20, %r8
je	L_4036
cmpq	$0x10, %r8
je	L_423d
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x40(%rsp)
movq	%rbx, 0x48(%rsp)
vmovdqa	0x40(%rsp), %xmm13
vmovdqu	0x40(%rdi), %xmm5
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x50(%rsp)
movq	%rbx, 0x58(%rsp)
vmovdqa	0x50(%rsp), %xmm14
vmovdqu	0x50(%rdi), %xmm6
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x60(%rsp)
movq	%rbx, 0x68(%rsp)
vmovdqa	0x60(%rsp), %xmm15
vmovdqu	0x60(%rdi), %xmm7
addq	$0x70, %rdi
andq	$0xf, %rdx
je	L_2f51
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm15, %xmm16
vmovdqa	0x10(%rsp), %xmm15
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vpxor	%xmm0, %xmm7, %xmm7
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vaesdeclast	%xmm0, %xmm7, %xmm7
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
vmovdqu	%xmm6, 0x50(%rsi)
addq	$0x70, %rsi
vmovdqa64	%xmm16, %xmm0
vmovdqa	%xmm7, %xmm8
jmp	L_2b05
L_2f51:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vpxor	%xmm0, %xmm7, %xmm7
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vaesdeclast	%xmm0, %xmm7, %xmm7
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
vmovdqu	%xmm6, 0x50(%rsi)
addq	$0x70, %rsi
vmovdqa	%xmm7, %xmm8
jmp	L_2b9c
L_316c:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x40(%rsp)
movq	%rbx, 0x48(%rsp)
vmovdqa	0x40(%rsp), %xmm13
vmovdqu	0x40(%rdi), %xmm5
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x50(%rsp)
movq	%rbx, 0x58(%rsp)
vmovdqa	0x50(%rsp), %xmm14
vmovdqu	0x50(%rdi), %xmm6
addq	$0x60, %rdi
andq	$0xf, %rdx
je	L_3447
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm14, %xmm15
vmovdqa	0x10(%rsp), %xmm14
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
addq	$0x60, %rsi
vmovdqa	%xmm15, %xmm0
vmovdqa	%xmm6, %xmm8
jmp	L_2b05
L_3447:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
addq	$0x60, %rsi
vmovdqa	%xmm6, %xmm8
jmp	L_2b9c
L_361f:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x40(%rsp)
movq	%rbx, 0x48(%rsp)
vmovdqa	0x40(%rsp), %xmm13
vmovdqu	0x40(%rdi), %xmm5
addq	$0x50, %rdi
andq	$0xf, %rdx
je	L_3892
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm13, %xmm14
vmovdqa	0x10(%rsp), %xmm13
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm14, %xmm0
vmovdqa	%xmm5, %xmm8
jmp	L_2b05
L_3892:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm5, %xmm8
jmp	L_2b9c
L_3a27:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
addq	$0x40, %rdi
andq	$0xf, %rdx
je	L_3c32
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm12, %xmm13
vmovdqa	0x10(%rsp), %xmm12
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
addq	$0x40, %rsi
vmovdqa	%xmm13, %xmm0
vmovdqa	%xmm4, %xmm8
jmp	L_2b05
L_3c32:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
addq	$0x40, %rsi
vmovdqa	%xmm4, %xmm8
jmp	L_2b9c
L_3d84:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
addq	$0x30, %rdi
andq	$0xf, %rdx
je	L_3f27
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm11, %xmm12
vmovdqa	0x10(%rsp), %xmm11
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
addq	$0x30, %rsi
vmovdqa	%xmm12, %xmm0
vmovdqa	%xmm3, %xmm8
jmp	L_2b05
L_3f27:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
addq	$0x30, %rsi
vmovdqa	%xmm3, %xmm8
jmp	L_2b9c
L_4036:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
addq	$0x20, %rdi
andq	$0xf, %rdx
je	L_4171
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm10, %xmm11
vmovdqa	0x10(%rsp), %xmm10
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
addq	$0x20, %rsi
vmovdqa	%xmm11, %xmm0
vmovdqa	%xmm2, %xmm8
jmp	L_2b05
L_4171:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
addq	$0x20, %rsi
vmovdqa	%xmm2, %xmm8
jmp	L_2b9c
L_423d:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
addq	$0x10, %rdi
andq	$0xf, %rdx
je	L_4311
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm9, %xmm10
vmovdqa	0x10(%rsp), %xmm9
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
addq	$0x10, %rsi
vmovdqa	%xmm10, %xmm0
vmovdqa	%xmm1, %xmm8
jmp	L_2b05
L_4311:
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
jmp	L_2b9c
nopl	(%rax,%rax)
aesni_xts_256_encrypt_avx512:
endbr64
pushq	%rbp
movq	%rsp, %rbp
subq	$0x88, %rsp
andq	$-0x40, %rsp
movq	%rbx, 0x80(%rsp)
movq	$0x87, %r10
vmovdqu	(%r9), %xmm1
vpxor	(%r8), %xmm1, %xmm1
vaesenc	0x10(%r8), %xmm1, %xmm1
vaesenc	0x20(%r8), %xmm1, %xmm1
vaesenc	0x30(%r8), %xmm1, %xmm1
vaesenc	0x40(%r8), %xmm1, %xmm1
vaesenc	0x50(%r8), %xmm1, %xmm1
vaesenc	0x60(%r8), %xmm1, %xmm1
vaesenc	0x70(%r8), %xmm1, %xmm1
vaesenc	0x80(%r8), %xmm1, %xmm1
vaesenc	0x90(%r8), %xmm1, %xmm1
vaesenc	0xa0(%r8), %xmm1, %xmm1
vaesenc	0xb0(%r8), %xmm1, %xmm1
vaesenc	0xc0(%r8), %xmm1, %xmm1
vaesenc	0xd0(%r8), %xmm1, %xmm1
vaesenclast	0xe0(%r8), %xmm1, %xmm1
vmovdqa	%xmm1, (%rsp)
cmpq	$0x80, %rdx
jl	L_532e
vpbroadcastq	%r10, %zmm25
cmpq	$0x100, %rdx
jge	L_4c8f
cmpq	$0x80, %rdx
jge	L_5027
L_4467:
cmpq	$0x0, %rdx
je	L_530c
cmpq	$0x70, %rdx
jge	L_44c0
cmpq	$0x60, %rdx
jge	L_4638
cmpq	$0x50, %rdx
jge	L_47a1
cmpq	$0x40, %rdx
jge	L_4903
cmpq	$0x30, %rdx
jge	L_49fc
cmpq	$0x20, %rdx
jge	L_4b06
cmpq	$0x10, %rdx
jge	L_4bf0
vmovdqa	%xmm0, %xmm8
vmovdqa	%xmm9, %xmm0
jmp	L_524c
L_44c0:
movabsq	$0xffffffffffff, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2 {%k1}
addq	$0x70, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
addq	$0x70, %rsi
vextracti32x4	$0x2, %zmm2, %xmm8
vextracti32x4	$0x3, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_4638:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %ymm2
addq	$0x60, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
addq	$0x60, %rsi
vextracti32x4	$0x1, %zmm2, %xmm8
vextracti32x4	$0x2, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_47a1:
vmovdqu8	(%rdi), %zmm1
vmovdqu	0x40(%rdi), %xmm2
addq	$0x50, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu	%xmm2, 0x40(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm2, %xmm8
vextracti32x4	$0x1, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_4903:
vmovdqu8	(%rdi), %zmm1
addq	$0x40, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi)
addq	$0x40, %rsi
vextracti32x4	$0x3, %zmm1, %xmm8
vmovdqa64	%xmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_49fc:
movq	$-0x1, %r8
shrq	$0x10, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1 {%k1}
addq	$0x30, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi) {%k1}
addq	$0x30, %rsi
vextracti32x4	$0x2, %zmm1, %xmm8
vextracti32x4	$0x3, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_4b06:
vmovdqu8	(%rdi), %ymm1
addq	$0x20, %rdi
vbroadcasti32x4	(%rcx), %ymm0
vpternlogq	$0x96, %ymm0, %ymm9, %ymm1
vbroadcasti32x4	0x10(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x20(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x30(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x40(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x50(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x60(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x70(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x80(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x90(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xa0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xb0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xc0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xd0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xe0(%rcx), %ymm0
vaesenclast	%ymm0, %ymm1, %ymm1
vpxorq	%ymm9, %ymm1, %ymm1
vmovdqu	%ymm1, (%rsi)
addq	$0x20, %rsi
vextracti32x4	$0x1, %zmm1, %xmm8
vextracti32x4	$0x2, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_4bf0:
vmovdqu	(%rdi), %xmm1
addq	$0x10, %rdi
vpxor	%xmm1, %xmm9, %xmm1
vpxor	(%rcx), %xmm1, %xmm1
vaesenc	0x10(%rcx), %xmm1, %xmm1
vaesenc	0x20(%rcx), %xmm1, %xmm1
vaesenc	0x30(%rcx), %xmm1, %xmm1
vaesenc	0x40(%rcx), %xmm1, %xmm1
vaesenc	0x50(%rcx), %xmm1, %xmm1
vaesenc	0x60(%rcx), %xmm1, %xmm1
vaesenc	0x70(%rcx), %xmm1, %xmm1
vaesenc	0x80(%rcx), %xmm1, %xmm1
vaesenc	0x90(%rcx), %xmm1, %xmm1
vaesenc	0xa0(%rcx), %xmm1, %xmm1
vaesenc	0xb0(%rcx), %xmm1, %xmm1
vaesenc	0xc0(%rcx), %xmm1, %xmm1
vaesenc	0xd0(%rcx), %xmm1, %xmm1
vaesenclast	0xe0(%rcx), %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	%xmm1, (%rsi)
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
vextracti32x4	$0x1, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_4c8f:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm11
vpxord	%zmm14, %zmm11, %zmm11
vpsrldq	$0xf, %zmm10, %zmm15
vpclmulqdq	$0x0, %zmm25, %zmm15, %zmm16
vpslldq	$0x1, %zmm10, %zmm12
vpxord	%zmm16, %zmm12, %zmm12
L_4d36:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
vmovdqu8	0x80(%rdi), %zmm3
vmovdqu8	0xc0(%rdi), %zmm4
addq	$0x100, %rdi
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vpxorq	%zmm0, %zmm3, %zmm3
vpxorq	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm11, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm11, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm12, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm12, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm15, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm15, %zmm17
vpxord	%zmm14, %zmm17, %zmm17
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm16, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm16, %zmm18
vpxord	%zmm14, %zmm18, %zmm18
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vaesenc	%zmm0, %zmm3, %zmm3
vaesenc	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vaesenclast	%zmm0, %zmm3, %zmm3
vaesenclast	%zmm0, %zmm4, %zmm4
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqa32	%zmm17, %zmm11
vmovdqa32	%zmm18, %zmm12
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
vmovdqu8	%zmm3, 0x80(%rsi)
vmovdqu8	%zmm4, 0xc0(%rsi)
addq	$0x100, %rsi
subq	$0x100, %rdx
cmpq	$0x100, %rdx
jae	L_4d36
cmpq	$0x80, %rdx
jae	L_5098
vextracti32x4	$0x3, %zmm4, %xmm0
jmp	L_4467
L_5027:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
L_5098:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
addq	$0x80, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vpsrldq	$0xf, %zmm10, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm10, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
addq	$0x80, %rsi
subq	$0x80, %rdx
cmpq	$0x80, %rdx
jae	L_5098
vextracti32x4	$0x3, %zmm2, %xmm0
jmp	L_4467
L_524c:
vmovdqa	%xmm8, %xmm2
leaq	vpshufb_shf_table(%rip), %rax
vmovdqu	(%rax,%rdx), %xmm10
vpshufb	%xmm10, %xmm8, %xmm8
vmovdqu	-0x10(%rdi,%rdx), %xmm3
vmovdqu	%xmm8, -0x10(%rsi,%rdx)
leaq	vpshufb_shf_table(%rip), %rax
addq	$0x10, %rax
subq	%rdx, %rax
vmovdqu	(%rax), %xmm10
vpxor	mask1(%rip), %xmm10, %xmm10
vpshufb	%xmm10, %xmm3, %xmm3
vpblendvb	%xmm10, %xmm2, %xmm3, %xmm3
vpxor	%xmm0, %xmm3, %xmm8
vpxor	(%rcx), %xmm8, %xmm8
vaesenc	0x10(%rcx), %xmm8, %xmm8
vaesenc	0x20(%rcx), %xmm8, %xmm8
vaesenc	0x30(%rcx), %xmm8, %xmm8
vaesenc	0x40(%rcx), %xmm8, %xmm8
vaesenc	0x50(%rcx), %xmm8, %xmm8
vaesenc	0x60(%rcx), %xmm8, %xmm8
vaesenc	0x70(%rcx), %xmm8, %xmm8
vaesenc	0x80(%rcx), %xmm8, %xmm8
vaesenc	0x90(%rcx), %xmm8, %xmm8
vaesenc	0xa0(%rcx), %xmm8, %xmm8
vaesenc	0xb0(%rcx), %xmm8, %xmm8
vaesenc	0xc0(%rcx), %xmm8, %xmm8
vaesenc	0xd0(%rcx), %xmm8, %xmm8
vaesenclast	0xe0(%rcx), %xmm8, %xmm8
vpxor	%xmm0, %xmm8, %xmm8
vmovdqu	%xmm8, -0x10(%rsi)
L_530c:
movq	0x80(%rsp), %rbx
xorq	%r8, %r8
movq	%r8, 0x80(%rsp)
vpxorq	%zmm0, %zmm0, %zmm0
movq	%rbp, %rsp
popq	%rbp
vzeroupper
rep	retq
L_532e:
vpbroadcastq	%r10, %zmm25
cmpq	$0x10, %rdx
jb	L_530c
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movl	$0xaa, %r8d
kmovq	%r8, %k2
movq	%rdx, %r8
andq	$0x70, %r8
cmpq	$0x60, %r8
je	L_5565
cmpq	$0x50, %r8
je	L_5722
cmpq	$0x40, %r8
je	L_58dc
cmpq	$0x30, %r8
je	L_5a27
cmpq	$0x20, %r8
je	L_5b5d
cmpq	$0x10, %r8
je	L_5c76
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
movabsq	$0xffffffffffff, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2 {%k1}
addq	$0x70, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
addq	$0x70, %rsi
vextracti32x4	$0x2, %zmm2, %xmm8
vextracti32x4	$0x3, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_5565:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %ymm2
addq	$0x60, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
addq	$0x60, %rsi
vextracti32x4	$0x1, %ymm2, %xmm8
vextracti32x4	$0x2, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_5722:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %xmm2
addq	$0x50, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vpternlogq	$0x96, %zmm0, %zmm10, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vaesenc	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vaesenclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%xmm2, 0x40(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm2, %xmm8
vextracti32x4	$0x1, %zmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_58dc:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vmovdqu8	(%rdi), %zmm1
addq	$0x40, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi)
addq	$0x40, %rsi
vextracti32x4	$0x3, %zmm1, %xmm8
vmovdqa	%xmm10, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_5a27:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
movabsq	$0xffffffffffff, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1 {%k1}
addq	$0x30, %rdi
vbroadcasti32x4	(%rcx), %zmm0
vpternlogq	$0x96, %zmm0, %zmm9, %zmm1
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesenc	%zmm0, %zmm1, %zmm1
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesenclast	%zmm0, %zmm1, %zmm1
vpxorq	%zmm9, %zmm1, %zmm1
vmovdqu8	%zmm1, (%rsi) {%k1}
addq	$0x30, %rsi
vextracti32x4	$0x2, %zmm1, %xmm8
vextracti32x4	$0x3, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_5b5d:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vmovdqu8	(%rdi), %ymm1
addq	$0x20, %rdi
vbroadcasti32x4	(%rcx), %ymm0
vpternlogq	$0x96, %ymm0, %ymm9, %ymm1
vbroadcasti32x4	0x10(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x20(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x30(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x40(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x50(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x60(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x70(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x80(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x90(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xa0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xb0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xc0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xd0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xe0(%rcx), %ymm0
vaesenclast	%ymm0, %ymm1, %ymm1
vpxorq	%ymm9, %ymm1, %ymm1
vmovdqu8	%ymm1, (%rsi)
addq	$0x20, %rsi
vextracti32x4	$0x1, %ymm1, %xmm8
vextracti32x4	$0x2, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
L_5c76:
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vmovdqu8	(%rdi), %xmm1
addq	$0x10, %rdi
vbroadcasti32x4	(%rcx), %ymm0
vpternlogq	$0x96, %ymm0, %ymm9, %ymm1
vbroadcasti32x4	0x10(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x20(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x30(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x40(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x50(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x60(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x70(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x80(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0x90(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xa0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xb0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xc0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xd0(%rcx), %ymm0
vaesenc	%ymm0, %ymm1, %ymm1
vbroadcasti32x4	0xe0(%rcx), %ymm0
vaesenclast	%ymm0, %ymm1, %ymm1
vpxorq	%ymm9, %ymm1, %ymm1
vmovdqu8	%xmm1, (%rsi)
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
vextracti32x4	$0x1, %zmm9, %xmm0
andq	$0xf, %rdx
je	L_530c
jmp	L_524c
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
aesni_xts_256_decrypt_avx512:
endbr64
pushq	%rbp
movq	%rsp, %rbp
subq	$0x88, %rsp
andq	$-0x40, %rsp
movq	%rbx, 0x80(%rsp)
movq	$0x87, %r10
vmovdqu	(%r9), %xmm1
vpxor	(%r8), %xmm1, %xmm1
vaesenc	0x10(%r8), %xmm1, %xmm1
vaesenc	0x20(%r8), %xmm1, %xmm1
vaesenc	0x30(%r8), %xmm1, %xmm1
vaesenc	0x40(%r8), %xmm1, %xmm1
vaesenc	0x50(%r8), %xmm1, %xmm1
vaesenc	0x60(%r8), %xmm1, %xmm1
vaesenc	0x70(%r8), %xmm1, %xmm1
vaesenc	0x80(%r8), %xmm1, %xmm1
vaesenc	0x90(%r8), %xmm1, %xmm1
vaesenc	0xa0(%r8), %xmm1, %xmm1
vaesenc	0xb0(%r8), %xmm1, %xmm1
vaesenc	0xc0(%r8), %xmm1, %xmm1
vaesenc	0xd0(%r8), %xmm1, %xmm1
vaesenclast	0xe0(%r8), %xmm1, %xmm1
vmovdqa	%xmm1, (%rsp)
cmpq	$0x80, %rdx
jb	L_78d7
vpbroadcastq	%r10, %zmm25
cmpq	$0x100, %rdx
jge	L_722e
jmp	L_75c6
L_5e5f:
cmpq	$0x0, %rdx
je	L_78b5
cmpq	$0x70, %rdx
jge	L_5fb0
cmpq	$0x60, %rdx
jge	L_62a3
cmpq	$0x50, %rdx
jge	L_6586
cmpq	$0x40, %rdx
jge	L_6859
cmpq	$0x30, %rdx
jge	L_6b20
cmpq	$0x20, %rdx
jge	L_6e3b
cmpq	$0x10, %rdx
jge	L_7095
vmovdqu	%xmm5, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	%xmm1, -0x10(%rsi)
vmovdqa	%xmm1, %xmm8
movq	$0x1, %r8
kmovq	%r8, %k1
vpsllq	$0x3f, %xmm9, %xmm13
vpsraq	$0x3f, %xmm13, %xmm14
vpandq	%xmm25, %xmm14, %xmm5
vpxorq	%xmm5, %xmm9, %xmm9 {%k1}
vpsrldq	$0x8, %xmm9, %xmm10
vpshrdq	$0x1, %xmm10, %xmm9, %xmm0
vpslldq	$0x8, %xmm13, %xmm13
vpxorq	%xmm13, %xmm0, %xmm0
jmp	L_77f5
L_5fb0:
movq	$-0x1, %r8
shrq	$0x10, %r8
kmovq	%r8, %k1
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2 {%k1}
addq	$0x70, %rdi
andq	$0xf, %rdx
je	L_6151
vextracti32x4	$0x2, %zmm10, %xmm12
vextracti32x4	$0x3, %zmm10, %xmm13
vinserti32x4	$0x2, %xmm13, %zmm10, %zmm10
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
addq	$0x70, %rsi
vextracti32x4	$0x2, %zmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_77f5
L_6151:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi) {%k1}
jmp	L_78b5
L_62a3:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %ymm2
addq	$0x60, %rdi
andq	$0xf, %rdx
je	L_6434
vextracti32x4	$0x1, %zmm10, %xmm12
vextracti32x4	$0x2, %zmm10, %xmm13
vinserti32x4	$0x1, %xmm13, %zmm10, %zmm10
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
addq	$0x60, %rsi
vextracti32x4	$0x1, %zmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_77f5
L_6434:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%ymm2, 0x40(%rsi)
jmp	L_78b5
L_6586:
vmovdqu8	(%rdi), %zmm1
vmovdqu	0x40(%rdi), %xmm2
addq	$0x50, %rdi
andq	$0xf, %rdx
je	L_6707
vmovdqa	%xmm10, %xmm12
vextracti32x4	$0x1, %zmm10, %xmm10
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu	%xmm2, 0x40(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_77f5
L_6707:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%xmm2, 0x40(%rsi)
jmp	L_78b5
L_6859:
vmovdqu8	(%rdi), %zmm1
addq	$0x40, %rdi
andq	$0xf, %rdx
je	L_69d5
vextracti32x4	$0x3, %zmm9, %xmm12
vinserti32x4	$0x3, %xmm10, %zmm9, %zmm9
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
addq	$0x40, %rsi
vextracti32x4	$0x3, %zmm1, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_77f5
L_69d5:
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
jmp	L_78b5
L_6b20:
vmovdqu	(%rdi), %xmm1
vmovdqu	0x10(%rdi), %xmm2
vmovdqu	0x20(%rdi), %xmm3
addq	$0x30, %rdi
andq	$0xf, %rdx
je	L_6cc5
vextracti32x4	$0x2, %zmm9, %xmm13
vextracti32x4	$0x1, %zmm9, %xmm10
vextracti32x4	$0x3, %zmm9, %xmm11
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
addq	$0x30, %rsi
vmovdqa	%xmm3, %xmm8
vmovdqa	%xmm13, %xmm0
jmp	L_77f5
L_6cc5:
vextracti32x4	$0x1, %zmm9, %xmm10
vextracti32x4	$0x2, %zmm9, %xmm11
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
jmp	L_78b5
L_6e3b:
vmovdqu	(%rdi), %xmm1
vmovdqu	0x10(%rdi), %xmm2
addq	$0x20, %rdi
andq	$0xf, %rdx
je	L_6f7d
vextracti32x4	$0x2, %zmm9, %xmm10
vextracti32x4	$0x1, %zmm9, %xmm12
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
addq	$0x20, %rsi
vmovdqa	%xmm2, %xmm8
vmovdqa	%xmm12, %xmm0
jmp	L_77f5
L_6f7d:
vextracti32x4	$0x1, %zmm9, %xmm10
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
jmp	L_78b5
L_7095:
vmovdqu	(%rdi), %xmm1
addq	$0x10, %rdi
andq	$0xf, %rdx
je	L_7174
vextracti32x4	$0x1, %zmm9, %xmm11
vpxor	%xmm1, %xmm11, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm11, %xmm1
vmovdqu	%xmm1, (%rsi)
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
vmovdqa	%xmm9, %xmm0
jmp	L_77f5
L_7174:
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	%xmm1, (%rsi)
jmp	L_78b5
L_722e:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm11
vpxord	%zmm14, %zmm11, %zmm11
vpsrldq	$0xf, %zmm10, %zmm15
vpclmulqdq	$0x0, %zmm25, %zmm15, %zmm16
vpslldq	$0x1, %zmm10, %zmm12
vpxord	%zmm16, %zmm12, %zmm12
L_72d5:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
vmovdqu8	0x80(%rdi), %zmm3
vmovdqu8	0xc0(%rdi), %zmm4
vmovdqu8	0xf0(%rdi), %xmm5
addq	$0x100, %rdi
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vpxorq	%zmm0, %zmm3, %zmm3
vpxorq	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm11, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm11, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm12, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm12, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm15, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm15, %zmm17
vpxord	%zmm14, %zmm17, %zmm17
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vpsrldq	$0xf, %zmm16, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm16, %zmm18
vpxord	%zmm14, %zmm18, %zmm18
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vaesdec	%zmm0, %zmm3, %zmm3
vaesdec	%zmm0, %zmm4, %zmm4
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vaesdeclast	%zmm0, %zmm3, %zmm3
vaesdeclast	%zmm0, %zmm4, %zmm4
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vpxorq	%zmm11, %zmm3, %zmm3
vpxorq	%zmm12, %zmm4, %zmm4
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqa32	%zmm17, %zmm11
vmovdqa32	%zmm18, %zmm12
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
vmovdqu8	%zmm3, 0x80(%rsi)
vmovdqu8	%zmm4, 0xc0(%rsi)
addq	$0x100, %rsi
subq	$0x100, %rdx
cmpq	$0x100, %rdx
jge	L_72d5
cmpq	$0x80, %rdx
jge	L_7637
jmp	L_5e5f
L_75c6:
vbroadcasti32x4	(%rsp), %zmm0
vbroadcasti32x4	shufb_15_7(%rip), %zmm8
movq	$0xaa, %r8
kmovq	%r8, %k2
vpshufb	%zmm8, %zmm0, %zmm1
vpsllvq	const_dq3210(%rip), %zmm0, %zmm4
vpsrlvq	const_dq5678(%rip), %zmm1, %zmm2
vpclmulqdq	$0x0, %zmm25, %zmm2, %zmm3
vpxorq	%zmm2, %zmm4, %zmm4 {%k2}
vpxord	%zmm4, %zmm3, %zmm9
vpsllvq	const_dq7654(%rip), %zmm0, %zmm5
vpsrlvq	const_dq1234(%rip), %zmm1, %zmm6
vpclmulqdq	$0x0, %zmm25, %zmm6, %zmm7
vpxorq	%zmm6, %zmm5, %zmm5 {%k2}
vpxord	%zmm5, %zmm7, %zmm10
L_7637:
vmovdqu8	(%rdi), %zmm1
vmovdqu8	0x40(%rdi), %zmm2
vmovdqu8	0x70(%rdi), %xmm5
addq	$0x80, %rdi
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vbroadcasti32x4	(%rcx), %zmm0
vpxorq	%zmm0, %zmm1, %zmm1
vpxorq	%zmm0, %zmm2, %zmm2
vpsrldq	$0xf, %zmm9, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm9, %zmm15
vpxord	%zmm14, %zmm15, %zmm15
vbroadcasti32x4	0x10(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x20(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x30(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vpsrldq	$0xf, %zmm10, %zmm13
vpclmulqdq	$0x0, %zmm25, %zmm13, %zmm14
vpslldq	$0x1, %zmm10, %zmm16
vpxord	%zmm14, %zmm16, %zmm16
vbroadcasti32x4	0x40(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x50(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x60(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x70(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x80(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0x90(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xa0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xb0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xc0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xd0(%rcx), %zmm0
vaesdec	%zmm0, %zmm1, %zmm1
vaesdec	%zmm0, %zmm2, %zmm2
vbroadcasti32x4	0xe0(%rcx), %zmm0
vaesdeclast	%zmm0, %zmm1, %zmm1
vaesdeclast	%zmm0, %zmm2, %zmm2
vpxorq	%zmm9, %zmm1, %zmm1
vpxorq	%zmm10, %zmm2, %zmm2
vmovdqa32	%zmm15, %zmm9
vmovdqa32	%zmm16, %zmm10
vmovdqu8	%zmm1, (%rsi)
vmovdqu8	%zmm2, 0x40(%rsi)
addq	$0x80, %rsi
subq	$0x80, %rdx
cmpq	$0x80, %rdx
jge	L_7637
jmp	L_5e5f
L_77f5:
vmovdqa	%xmm8, %xmm2
leaq	vpshufb_shf_table(%rip), %rax
vmovdqu	(%rax,%rdx), %xmm10
vpshufb	%xmm10, %xmm8, %xmm8
vmovdqu	-0x10(%rdi,%rdx), %xmm3
vmovdqu	%xmm8, -0x10(%rsi,%rdx)
leaq	vpshufb_shf_table(%rip), %rax
addq	$0x10, %rax
subq	%rdx, %rax
vmovdqu	(%rax), %xmm10
vpxor	mask1(%rip), %xmm10, %xmm10
vpshufb	%xmm10, %xmm3, %xmm3
vpblendvb	%xmm10, %xmm2, %xmm3, %xmm3
vpxor	%xmm0, %xmm3, %xmm8
vpxor	(%rcx), %xmm8, %xmm8
vaesdec	0x10(%rcx), %xmm8, %xmm8
vaesdec	0x20(%rcx), %xmm8, %xmm8
vaesdec	0x30(%rcx), %xmm8, %xmm8
vaesdec	0x40(%rcx), %xmm8, %xmm8
vaesdec	0x50(%rcx), %xmm8, %xmm8
vaesdec	0x60(%rcx), %xmm8, %xmm8
vaesdec	0x70(%rcx), %xmm8, %xmm8
vaesdec	0x80(%rcx), %xmm8, %xmm8
vaesdec	0x90(%rcx), %xmm8, %xmm8
vaesdec	0xa0(%rcx), %xmm8, %xmm8
vaesdec	0xb0(%rcx), %xmm8, %xmm8
vaesdec	0xc0(%rcx), %xmm8, %xmm8
vaesdec	0xd0(%rcx), %xmm8, %xmm8
vaesdeclast	0xe0(%rcx), %xmm8, %xmm8
vpxor	%xmm0, %xmm8, %xmm8
L_78b0:
vmovdqu	%xmm8, -0x10(%rsi)
L_78b5:
movq	0x80(%rsp), %rbx
xorq	%r8, %r8
movq	%r8, 0x80(%rsp)
vpxorq	%zmm0, %zmm0, %zmm0
movq	%rbp, %rsp
popq	%rbp
vzeroupper
rep	retq
L_78d7:
cmpq	$0x10, %rdx
jb	L_78b5
movq	%rdx, %r8
andq	$0x70, %r8
cmpq	$0x60, %r8
je	L_7fd8
cmpq	$0x50, %r8
je	L_85bb
cmpq	$0x40, %r8
je	L_8acb
cmpq	$0x30, %r8
je	L_8f08
cmpq	$0x20, %r8
je	L_9272
cmpq	$0x10, %r8
je	L_9509
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x40(%rsp)
movq	%rbx, 0x48(%rsp)
vmovdqa	0x40(%rsp), %xmm13
vmovdqu	0x40(%rdi), %xmm5
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x50(%rsp)
movq	%rbx, 0x58(%rsp)
vmovdqa	0x50(%rsp), %xmm14
vmovdqu	0x50(%rdi), %xmm6
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x60(%rsp)
movq	%rbx, 0x68(%rsp)
vmovdqa	0x60(%rsp), %xmm15
vmovdqu	0x60(%rdi), %xmm7
addq	$0x70, %rdi
andq	$0xf, %rdx
je	L_7d11
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm15, %xmm16
vmovdqa	0x10(%rsp), %xmm15
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vpxor	%xmm0, %xmm7, %xmm7
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vaesdeclast	%xmm0, %xmm7, %xmm7
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
vmovdqu	%xmm6, 0x50(%rsi)
addq	$0x70, %rsi
vmovdqa64	%xmm16, %xmm0
vmovdqa	%xmm7, %xmm8
jmp	L_77f5
L_7d11:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vpxor	%xmm0, %xmm7, %xmm7
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vaesdec	%xmm0, %xmm7, %xmm7
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vaesdeclast	%xmm0, %xmm7, %xmm7
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vpxor	%xmm7, %xmm15, %xmm7
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
vmovdqu	%xmm6, 0x50(%rsi)
addq	$0x70, %rsi
vmovdqa	%xmm7, %xmm8
jmp	L_78b0
L_7fd8:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x40(%rsp)
movq	%rbx, 0x48(%rsp)
vmovdqa	0x40(%rsp), %xmm13
vmovdqu	0x40(%rdi), %xmm5
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x50(%rsp)
movq	%rbx, 0x58(%rsp)
vmovdqa	0x50(%rsp), %xmm14
vmovdqu	0x50(%rdi), %xmm6
addq	$0x60, %rdi
andq	$0xf, %rdx
je	L_834b
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm14, %xmm15
vmovdqa	0x10(%rsp), %xmm14
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
addq	$0x60, %rsi
vmovdqa	%xmm15, %xmm0
vmovdqa	%xmm6, %xmm8
jmp	L_77f5
L_834b:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vpxor	%xmm0, %xmm6, %xmm6
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vaesdec	%xmm0, %xmm6, %xmm6
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vaesdeclast	%xmm0, %xmm6, %xmm6
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vpxor	%xmm6, %xmm14, %xmm6
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
vmovdqu	%xmm5, 0x40(%rsi)
addq	$0x60, %rsi
vmovdqa	%xmm6, %xmm8
jmp	L_78b0
L_85bb:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x40(%rsp)
movq	%rbx, 0x48(%rsp)
vmovdqa	0x40(%rsp), %xmm13
vmovdqu	0x40(%rdi), %xmm5
addq	$0x50, %rdi
andq	$0xf, %rdx
je	L_88b2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm13, %xmm14
vmovdqa	0x10(%rsp), %xmm13
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm14, %xmm0
vmovdqa	%xmm5, %xmm8
jmp	L_77f5
L_88b2:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vpxor	%xmm0, %xmm5, %xmm5
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vaesdec	%xmm0, %xmm5, %xmm5
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vaesdeclast	%xmm0, %xmm5, %xmm5
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vpxor	%xmm5, %xmm13, %xmm5
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
vmovdqu	%xmm4, 0x30(%rsi)
addq	$0x50, %rsi
vmovdqa	%xmm5, %xmm8
jmp	L_78b0
L_8acb:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x30(%rsp)
movq	%rbx, 0x38(%rsp)
vmovdqa	0x30(%rsp), %xmm12
vmovdqu	0x30(%rdi), %xmm4
addq	$0x40, %rdi
andq	$0xf, %rdx
je	L_8d46
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm12, %xmm13
vmovdqa	0x10(%rsp), %xmm12
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
addq	$0x40, %rsi
vmovdqa	%xmm13, %xmm0
vmovdqa	%xmm4, %xmm8
jmp	L_77f5
L_8d46:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm0, %xmm4, %xmm4
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vaesdec	%xmm0, %xmm4, %xmm4
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vaesdeclast	%xmm0, %xmm4, %xmm4
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vpxor	%xmm4, %xmm12, %xmm4
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
vmovdqu	%xmm3, 0x20(%rsi)
addq	$0x40, %rsi
vmovdqa	%xmm4, %xmm8
jmp	L_78b0
L_8f08:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x20(%rsp)
movq	%rbx, 0x28(%rsp)
vmovdqa	0x20(%rsp), %xmm11
vmovdqu	0x20(%rdi), %xmm3
addq	$0x30, %rdi
andq	$0xf, %rdx
je	L_9107
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm11, %xmm12
vmovdqa	0x10(%rsp), %xmm11
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
addq	$0x30, %rsi
vmovdqa	%xmm12, %xmm0
vmovdqa	%xmm3, %xmm8
jmp	L_77f5
L_9107:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vpxor	%xmm0, %xmm3, %xmm3
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vaesdec	%xmm0, %xmm3, %xmm3
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vaesdeclast	%xmm0, %xmm3, %xmm3
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vpxor	%xmm3, %xmm11, %xmm3
vmovdqu	%xmm1, (%rsi)
vmovdqu	%xmm2, 0x10(%rsi)
addq	$0x30, %rsi
vmovdqa	%xmm3, %xmm8
jmp	L_78b0
L_9272:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa	0x10(%rsp), %xmm10
vmovdqu	0x10(%rdi), %xmm2
addq	$0x20, %rdi
andq	$0xf, %rdx
je	L_93f5
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm10, %xmm11
vmovdqa	0x10(%rsp), %xmm10
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
addq	$0x20, %rsi
vmovdqa	%xmm11, %xmm0
vmovdqa	%xmm2, %xmm8
jmp	L_77f5
L_93f5:
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm0, %xmm2, %xmm2
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vaesdec	%xmm0, %xmm2, %xmm2
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vaesdeclast	%xmm0, %xmm2, %xmm2
vpxor	%xmm1, %xmm9, %xmm1
vpxor	%xmm2, %xmm10, %xmm2
vmovdqu	%xmm1, (%rsi)
addq	$0x20, %rsi
vmovdqa	%xmm2, %xmm8
jmp	L_78b0
L_9509:
vmovdqa	(%rsp), %xmm9
movq	(%rsp), %rax
movq	0x8(%rsp), %rbx
vmovdqu	(%rdi), %xmm1
addq	$0x10, %rdi
andq	$0xf, %rdx
je	L_9611
xorq	%r11, %r11
shlq	%rax
adcq	%rbx, %rbx
cmovbq	%r10, %r11
xorq	%r11, %rax
movq	%rax, 0x10(%rsp)
movq	%rbx, 0x18(%rsp)
vmovdqa64	%xmm9, %xmm10
vmovdqa	0x10(%rsp), %xmm9
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
addq	$0x10, %rsi
vmovdqa	%xmm10, %xmm0
vmovdqa	%xmm1, %xmm8
jmp	L_77f5
L_9611:
vpxor	%xmm1, %xmm9, %xmm1
vmovdqu	(%rcx), %xmm0
vpxor	%xmm0, %xmm1, %xmm1
vmovdqu	0x10(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x20(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x30(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x40(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x50(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x60(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x70(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x80(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0x90(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xa0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xb0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xc0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xd0(%rcx), %xmm0
vaesdec	%xmm0, %xmm1, %xmm1
vmovdqu	0xe0(%rcx), %xmm0
vaesdeclast	%xmm0, %xmm1, %xmm1
vpxor	%xmm1, %xmm9, %xmm1
addq	$0x10, %rsi
vmovdqa	%xmm1, %xmm8
jmp	L_78b0
	.section .rodata
	.p2align 4
vpshufb_shf_table:
	.byte 0,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,0
mask1:
	.byte 128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
const_dq3210:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 2,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	.byte 3,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0
const_dq5678:
	.byte 8,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0
	.byte 7,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0
	.byte 6,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0
	.byte 5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0
const_dq7654:
	.byte 4,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0
	.byte 5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0
	.byte 6,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0
	.byte 7,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0
const_dq1234:
	.byte 4,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0
	.byte 3,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0
	.byte 2,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
shufb_15_7:
	.byte 15,255,255,255,255,255,255,255,7,255,255,255,255,255,255,255
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

	.text
ossl_aes_cfb128_vaes_eligible:
endbr64
movl	OPENSSL_ia32cap_P+8(%rip), %ecx
xorl	%eax, %eax
andl	$0x40030000, %ecx
cmpl	$0x40030000, %ecx
jne	L_2f
movl	OPENSSL_ia32cap_P+12(%rip), %ecx
andl	$0x200, %ecx
cmpl	$0x200, %ecx
cmovel	%ecx, %eax
L_2f:
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
ossl_aes_cfb128_vaes_enc:
endbr64
movq	(%r9), %r11
testq	%rdx, %rdx
je	L_33d
testq	%r11, %r11
je	L_b5
movq	%rcx, %r10
movq	$0x10, %rcx
subq	%r11, %rcx
cmpq	%rdx, %rcx
cmovaq	%rdx, %rcx
movq	$0x1, %rax
shlq	%cl, %rax
decq	%rax
kmovq	%rax, %k1
movq	%r11, %rax
addq	%rcx, %rax
andb	$0xf, %al
leaq	(%r11,%r8), %r11
vmovdqu8	(%r11), %xmm0 {%k1} {z}
vmovdqu8	(%rdi), %xmm1 {%k1} {z}
vpxor	%xmm0, %xmm1, %xmm2
vmovdqu8	%xmm2, (%rsi) {%k1}
vmovdqu8	%xmm2, (%r11) {%k1}
addq	%rcx, %rdi
addq	%rcx, %rsi
subq	%rcx, %rdx
je	L_32b
movq	%r10, %rcx
L_b5:
vmovdqu8	(%rcx), %xmm17
vmovdqu8	0x10(%rcx), %xmm18
vmovdqu8	0x20(%rcx), %xmm19
vmovdqu8	0x30(%rcx), %xmm20
vmovdqu8	0x40(%rcx), %xmm21
vmovdqu8	0x50(%rcx), %xmm22
vmovdqu8	0x60(%rcx), %xmm23
vmovdqu8	0x70(%rcx), %xmm24
vmovdqu8	0x80(%rcx), %xmm25
vmovdqu8	0x90(%rcx), %xmm26
vmovdqu8	0xa0(%rcx), %xmm27
vmovdqu8	0xb0(%rcx), %xmm28
vmovdqu8	0xc0(%rcx), %xmm29
vmovdqu8	0xd0(%rcx), %xmm30
vmovdqu8	0xe0(%rcx), %xmm31
movl	0xf0(%rcx), %r11d
vmovdqu	(%r8), %xmm2
cmpq	$0x10, %rdx
jb	L_1fd
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_140:
subq	$0x10, %rdx
vmovdqu	(%rdi), %xmm3
leaq	0x10(%rdi), %rdi
vpxord	%xmm17, %xmm2, %xmm2
vaesenc	%xmm18, %xmm2, %xmm2
vaesenc	%xmm19, %xmm2, %xmm2
vaesenc	%xmm20, %xmm2, %xmm2
vaesenc	%xmm21, %xmm2, %xmm2
vaesenc	%xmm22, %xmm2, %xmm2
vaesenc	%xmm23, %xmm2, %xmm2
vaesenc	%xmm24, %xmm2, %xmm2
vaesenc	%xmm25, %xmm2, %xmm2
vaesenc	%xmm26, %xmm2, %xmm2
cmpl	$0x9, %r11d
ja	L_1a0
vaesenclast	%xmm27, %xmm2, %xmm2
jmp	L_1e0
nopw	%cs:(%rax,%rax)
L_1a0:
vaesenc	%xmm27, %xmm2, %xmm2
vaesenc	%xmm28, %xmm2, %xmm2
cmpl	$0xb, %r11d
ja	L_1c0
vaesenclast	%xmm29, %xmm2, %xmm2
jmp	L_1e0
nopw	(%rax,%rax)
L_1c0:
vaesenc	%xmm29, %xmm2, %xmm2
vaesenc	%xmm30, %xmm2, %xmm2
vaesenclast	%xmm31, %xmm2, %xmm2
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1e0:
vpxor	%xmm3, %xmm2, %xmm2
cmpq	$0x10, %rdx
vmovdqu	%xmm2, (%rsi)
leaq	0x10(%rsi), %rsi
jae	L_140
xorl	%eax, %eax
vmovdqu	%xmm2, (%r8)
L_1fd:
testq	%rdx, %rdx
je	L_2cd
vpxord	%xmm17, %xmm2, %xmm2
vaesenc	%xmm18, %xmm2, %xmm2
vaesenc	%xmm19, %xmm2, %xmm2
vaesenc	%xmm20, %xmm2, %xmm2
vaesenc	%xmm21, %xmm2, %xmm2
vaesenc	%xmm22, %xmm2, %xmm2
vaesenc	%xmm23, %xmm2, %xmm2
vaesenc	%xmm24, %xmm2, %xmm2
vaesenc	%xmm25, %xmm2, %xmm2
vaesenc	%xmm26, %xmm2, %xmm2
cmpl	$0x9, %r11d
ja	L_260
vaesenclast	%xmm27, %xmm2, %xmm2
jmp	L_2a0
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_260:
vaesenc	%xmm27, %xmm2, %xmm2
vaesenc	%xmm28, %xmm2, %xmm2
cmpl	$0xb, %r11d
ja	L_280
vaesenclast	%xmm29, %xmm2, %xmm2
jmp	L_2a0
nopw	(%rax,%rax)
L_280:
vaesenc	%xmm29, %xmm2, %xmm2
vaesenc	%xmm30, %xmm2, %xmm2
vaesenclast	%xmm31, %xmm2, %xmm2
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2a0:
movq	%rdx, %rax
movq	$0x1, %r11
movb	%dl, %cl
shlq	%cl, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%rdi), %xmm1 {%k1} {z}
vpxor	%xmm2, %xmm1, %xmm0
vmovdqu8	%xmm0, (%rsi) {%k1}
vmovdqu8	%xmm0, (%r8)
L_2cd:
vpxord	%xmm17, %xmm17, %xmm17
vpxord	%xmm18, %xmm18, %xmm18
vpxord	%xmm19, %xmm19, %xmm19
vpxord	%xmm20, %xmm20, %xmm20
vpxord	%xmm21, %xmm21, %xmm21
vpxord	%xmm22, %xmm22, %xmm22
vpxord	%xmm23, %xmm23, %xmm23
vpxord	%xmm24, %xmm24, %xmm24
vpxord	%xmm25, %xmm25, %xmm25
vpxord	%xmm26, %xmm26, %xmm26
vpxord	%xmm27, %xmm27, %xmm27
vpxord	%xmm28, %xmm28, %xmm28
vpxord	%xmm29, %xmm29, %xmm29
vpxord	%xmm30, %xmm30, %xmm30
vpxord	%xmm31, %xmm31, %xmm31
vpxor	%xmm3, %xmm3, %xmm3
L_32b:
vpxor	%xmm0, %xmm0, %xmm0
vpxor	%xmm1, %xmm1, %xmm1
vpxor	%xmm2, %xmm2, %xmm2
movq	%rax, (%r9)
vzeroupper
L_33d:
rep	retq
nop
ossl_aes_cfb128_vaes_dec:
endbr64
movq	(%r9), %r11
testq	%rdx, %rdx
je	L_9e3
testq	%r11, %r11
je	L_3b3
movq	%rcx, %r10
movq	$0x10, %rcx
subq	%r11, %rcx
cmpq	%rdx, %rcx
cmovaq	%rdx, %rcx
movq	$0x1, %rax
shlq	%cl, %rax
decq	%rax
kmovq	%rax, %k1
leaq	(%r11,%rcx), %rax
andb	$0xf, %al
leaq	(%r11,%r8), %r11
vmovdqu8	(%r11), %xmm0 {%k1} {z}
vmovdqu8	(%rdi), %xmm1 {%k1} {z}
vpxor	%xmm0, %xmm1, %xmm2
vmovdqu8	%xmm2, (%rsi) {%k1}
vmovdqu8	%xmm1, (%r11) {%k1}
addq	%rcx, %rdi
addq	%rcx, %rsi
subq	%rcx, %rdx
je	L_9cb
movq	%r10, %rcx
L_3b3:
vbroadcasti32x4	(%rcx), %zmm17
vbroadcasti32x4	0x10(%rcx), %zmm18
vbroadcasti32x4	0x20(%rcx), %zmm19
vbroadcasti32x4	0x30(%rcx), %zmm20
vbroadcasti32x4	0x40(%rcx), %zmm21
vbroadcasti32x4	0x50(%rcx), %zmm22
vbroadcasti32x4	0x60(%rcx), %zmm23
vbroadcasti32x4	0x70(%rcx), %zmm24
vbroadcasti32x4	0x80(%rcx), %zmm25
vbroadcasti32x4	0x90(%rcx), %zmm26
vbroadcasti32x4	0xa0(%rcx), %zmm27
vbroadcasti32x4	0xb0(%rcx), %zmm28
vbroadcasti32x4	0xc0(%rcx), %zmm29
vbroadcasti32x4	0xd0(%rcx), %zmm30
vbroadcasti32x4	0xe0(%rcx), %zmm31
movl	0xf0(%rcx), %r11d
vbroadcasti32x4	(%r8), %zmm2
cmpq	$0x100, %rdx
jb	L_6c2
nopw	%cs:(%rax,%rax)
nop
L_440:
subq	$0x100, %rdx
vmovdqu32	(%rdi), %zmm3
vmovdqu32	0x40(%rdi), %zmm5
vmovdqu32	0x80(%rdi), %zmm1
vmovdqu32	0xc0(%rdi), %zmm16
valignq	$0x6, %zmm2, %zmm3, %zmm2
valignq	$0x6, %zmm3, %zmm5, %zmm4
valignq	$0x6, %zmm5, %zmm1, %zmm0
valignq	$0x6, %zmm1, %zmm16, %zmm6
leaq	0x100(%rdi), %rdi
vpxord	%zmm17, %zmm2, %zmm2
vpxord	%zmm17, %zmm4, %zmm4
vpxord	%zmm17, %zmm0, %zmm0
vpxord	%zmm17, %zmm6, %zmm6
vaesenc	%zmm18, %zmm2, %zmm2
vaesenc	%zmm18, %zmm4, %zmm4
vaesenc	%zmm18, %zmm0, %zmm0
vaesenc	%zmm18, %zmm6, %zmm6
vaesenc	%zmm19, %zmm2, %zmm2
vaesenc	%zmm19, %zmm4, %zmm4
vaesenc	%zmm19, %zmm0, %zmm0
vaesenc	%zmm19, %zmm6, %zmm6
vaesenc	%zmm20, %zmm2, %zmm2
vaesenc	%zmm20, %zmm4, %zmm4
vaesenc	%zmm20, %zmm0, %zmm0
vaesenc	%zmm20, %zmm6, %zmm6
vaesenc	%zmm21, %zmm2, %zmm2
vaesenc	%zmm21, %zmm4, %zmm4
vaesenc	%zmm21, %zmm0, %zmm0
vaesenc	%zmm21, %zmm6, %zmm6
vaesenc	%zmm22, %zmm2, %zmm2
vaesenc	%zmm22, %zmm4, %zmm4
vaesenc	%zmm22, %zmm0, %zmm0
vaesenc	%zmm22, %zmm6, %zmm6
vaesenc	%zmm23, %zmm2, %zmm2
vaesenc	%zmm23, %zmm4, %zmm4
vaesenc	%zmm23, %zmm0, %zmm0
vaesenc	%zmm23, %zmm6, %zmm6
vaesenc	%zmm24, %zmm2, %zmm2
vaesenc	%zmm24, %zmm4, %zmm4
vaesenc	%zmm24, %zmm0, %zmm0
vaesenc	%zmm24, %zmm6, %zmm6
vaesenc	%zmm25, %zmm2, %zmm2
vaesenc	%zmm25, %zmm4, %zmm4
vaesenc	%zmm25, %zmm0, %zmm0
vaesenc	%zmm25, %zmm6, %zmm6
vaesenc	%zmm26, %zmm2, %zmm2
vaesenc	%zmm26, %zmm4, %zmm4
vaesenc	%zmm26, %zmm0, %zmm0
vaesenc	%zmm26, %zmm6, %zmm6
cmpl	$0x9, %r11d
ja	L_5a0
vaesenclast	%zmm27, %zmm2, %zmm2
vaesenclast	%zmm27, %zmm4, %zmm4
vaesenclast	%zmm27, %zmm0, %zmm0
vaesenclast	%zmm27, %zmm6, %zmm6
jmp	L_660
nopl	(%rax,%rax)
L_5a0:
vaesenc	%zmm27, %zmm2, %zmm2
vaesenc	%zmm27, %zmm4, %zmm4
vaesenc	%zmm27, %zmm0, %zmm0
vaesenc	%zmm27, %zmm6, %zmm6
vaesenc	%zmm28, %zmm2, %zmm2
vaesenc	%zmm28, %zmm4, %zmm4
vaesenc	%zmm28, %zmm0, %zmm0
vaesenc	%zmm28, %zmm6, %zmm6
cmpl	$0xb, %r11d
ja	L_600
vaesenclast	%zmm29, %zmm2, %zmm2
vaesenclast	%zmm29, %zmm4, %zmm4
vaesenclast	%zmm29, %zmm0, %zmm0
vaesenclast	%zmm29, %zmm6, %zmm6
jmp	L_660
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_600:
vaesenc	%zmm29, %zmm2, %zmm2
vaesenc	%zmm29, %zmm4, %zmm4
vaesenc	%zmm29, %zmm0, %zmm0
vaesenc	%zmm29, %zmm6, %zmm6
vaesenc	%zmm30, %zmm2, %zmm2
vaesenc	%zmm30, %zmm4, %zmm4
vaesenc	%zmm30, %zmm0, %zmm0
vaesenc	%zmm30, %zmm6, %zmm6
vaesenclast	%zmm31, %zmm2, %zmm2
vaesenclast	%zmm31, %zmm4, %zmm4
vaesenclast	%zmm31, %zmm0, %zmm0
vaesenclast	%zmm31, %zmm6, %zmm6
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_660:
vpxord	%zmm3, %zmm2, %zmm2
vpxord	%zmm5, %zmm4, %zmm4
vpxord	%zmm1, %zmm0, %zmm0
vpxord	%zmm16, %zmm6, %zmm6
cmpq	$0x100, %rdx
vmovdqu32	%zmm2, (%rsi)
vmovdqu32	%zmm4, 0x40(%rsi)
vmovdqu32	%zmm0, 0x80(%rsi)
vmovdqu32	%zmm6, 0xc0(%rsi)
vmovdqu8	%zmm16, %zmm2
leaq	0x100(%rsi), %rsi
jae	L_440
vextracti64x2	$0x3, %zmm16, %xmm2
vinserti32x4	$0x3, %xmm2, %zmm2, %zmm2
xorl	%eax, %eax
vmovdqu	%xmm2, (%r8)
L_6c2:
cmpq	$0x40, %rdx
jb	L_7ae
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
L_6e0:
subq	$0x40, %rdx
vmovdqu32	(%rdi), %zmm3
valignq	$0x6, %zmm2, %zmm3, %zmm2
leaq	0x40(%rdi), %rdi
vpxord	%zmm17, %zmm2, %zmm2
vaesenc	%zmm18, %zmm2, %zmm2
vaesenc	%zmm19, %zmm2, %zmm2
vaesenc	%zmm20, %zmm2, %zmm2
vaesenc	%zmm21, %zmm2, %zmm2
vaesenc	%zmm22, %zmm2, %zmm2
vaesenc	%zmm23, %zmm2, %zmm2
vaesenc	%zmm24, %zmm2, %zmm2
vaesenc	%zmm25, %zmm2, %zmm2
vaesenc	%zmm26, %zmm2, %zmm2
cmpl	$0x9, %r11d
ja	L_740
vaesenclast	%zmm27, %zmm2, %zmm2
jmp	L_780
nop
L_740:
vaesenc	%zmm27, %zmm2, %zmm2
vaesenc	%zmm28, %zmm2, %zmm2
cmpl	$0xb, %r11d
ja	L_760
vaesenclast	%zmm29, %zmm2, %zmm2
jmp	L_780
nopw	(%rax,%rax)
L_760:
vaesenc	%zmm29, %zmm2, %zmm2
vaesenc	%zmm30, %zmm2, %zmm2
vaesenclast	%zmm31, %zmm2, %zmm2
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_780:
vpxord	%zmm3, %zmm2, %zmm2
cmpq	$0x40, %rdx
vmovdqu32	%zmm2, (%rsi)
vmovdqu8	%zmm3, %zmm2
leaq	0x40(%rsi), %rsi
jae	L_6e0
vextracti64x2	$0x3, %zmm2, %xmm2
xorl	%eax, %eax
vmovdqu	%xmm2, (%r8)
L_7ae:
cmpq	$0x10, %rdx
jb	L_883
nopl	(%rax,%rax)
L_7c0:
subq	$0x10, %rdx
vmovdqu	(%rdi), %xmm3
leaq	0x10(%rdi), %rdi
vpxord	%xmm17, %xmm2, %xmm2
vaesenc	%xmm18, %xmm2, %xmm2
vaesenc	%xmm19, %xmm2, %xmm2
vaesenc	%xmm20, %xmm2, %xmm2
vaesenc	%xmm21, %xmm2, %xmm2
vaesenc	%xmm22, %xmm2, %xmm2
vaesenc	%xmm23, %xmm2, %xmm2
vaesenc	%xmm24, %xmm2, %xmm2
vaesenc	%xmm25, %xmm2, %xmm2
vaesenc	%xmm26, %xmm2, %xmm2
cmpl	$0x9, %r11d
ja	L_820
vaesenclast	%xmm27, %xmm2, %xmm2
jmp	L_860
nopw	%cs:(%rax,%rax)
L_820:
vaesenc	%xmm27, %xmm2, %xmm2
vaesenc	%xmm28, %xmm2, %xmm2
cmpl	$0xb, %r11d
ja	L_840
vaesenclast	%xmm29, %xmm2, %xmm2
jmp	L_860
nopw	(%rax,%rax)
L_840:
vaesenc	%xmm29, %xmm2, %xmm2
vaesenc	%xmm30, %xmm2, %xmm2
vaesenclast	%xmm31, %xmm2, %xmm2
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_860:
vpxor	%xmm3, %xmm2, %xmm2
cmpq	$0x10, %rdx
vmovdqu	%xmm2, (%rsi)
vmovdqu8	%xmm3, %xmm2
leaq	0x10(%rsi), %rsi
jae	L_7c0
xorl	%eax, %eax
vmovdqu	%xmm2, (%r8)
L_883:
testq	%rdx, %rdx
je	L_953
vpxord	%xmm17, %xmm2, %xmm2
vaesenc	%xmm18, %xmm2, %xmm2
vaesenc	%xmm19, %xmm2, %xmm2
vaesenc	%xmm20, %xmm2, %xmm2
vaesenc	%xmm21, %xmm2, %xmm2
vaesenc	%xmm22, %xmm2, %xmm2
vaesenc	%xmm23, %xmm2, %xmm2
vaesenc	%xmm24, %xmm2, %xmm2
vaesenc	%xmm25, %xmm2, %xmm2
vaesenc	%xmm26, %xmm2, %xmm2
cmpl	$0x9, %r11d
ja	L_8e0
vaesenclast	%xmm27, %xmm2, %xmm2
jmp	L_920
nopw	%cs:(%rax,%rax)
L_8e0:
vaesenc	%xmm27, %xmm2, %xmm2
vaesenc	%xmm28, %xmm2, %xmm2
cmpl	$0xb, %r11d
ja	L_900
vaesenclast	%xmm29, %xmm2, %xmm2
jmp	L_920
nopw	(%rax,%rax)
L_900:
vaesenc	%xmm29, %xmm2, %xmm2
vaesenc	%xmm30, %xmm2, %xmm2
vaesenclast	%xmm31, %xmm2, %xmm2
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_920:
movq	%rdx, %rax
movq	$0x1, %r11
movb	%dl, %cl
shlq	%cl, %r11
decq	%r11
kmovq	%r11, %k1
vmovdqu8	(%rdi), %xmm1 {%k1} {z}
vpxor	%xmm2, %xmm1, %xmm0
vmovdqu8	%xmm0, (%rsi) {%k1}
vpblendmb	%xmm1, %xmm2, %xmm2 {%k1}
vmovdqu8	%xmm2, (%r8)
L_953:
vpxord	%xmm17, %xmm17, %xmm17
vpxord	%xmm18, %xmm18, %xmm18
vpxord	%xmm19, %xmm19, %xmm19
vpxord	%xmm20, %xmm20, %xmm20
vpxord	%xmm21, %xmm21, %xmm21
vpxord	%xmm22, %xmm22, %xmm22
vpxord	%xmm23, %xmm23, %xmm23
vpxord	%xmm24, %xmm24, %xmm24
vpxord	%xmm25, %xmm25, %xmm25
vpxord	%xmm26, %xmm26, %xmm26
vpxord	%xmm27, %xmm27, %xmm27
vpxord	%xmm28, %xmm28, %xmm28
vpxord	%xmm29, %xmm29, %xmm29
vpxord	%xmm30, %xmm30, %xmm30
vpxord	%xmm31, %xmm31, %xmm31
vpxord	%xmm3, %xmm3, %xmm3
vpxord	%xmm4, %xmm4, %xmm4
vpxord	%xmm5, %xmm5, %xmm5
vpxord	%xmm6, %xmm6, %xmm6
vpxord	%xmm16, %xmm16, %xmm16
L_9cb:
vpxord	%xmm0, %xmm0, %xmm0
vpxord	%xmm1, %xmm1, %xmm1
vpxord	%xmm2, %xmm2, %xmm2
vzeroupper
movq	%rax, (%r9)
L_9e3:
rep	retq

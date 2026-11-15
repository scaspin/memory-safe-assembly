	.text
ossl_rsaz_avx512ifma_eligible:
movl	OPENSSL_ia32cap_P+8(%rip), %ecx
xorl	%eax, %eax
andl	$0x80230000, %ecx
cmpl	$0x80230000, %ecx
cmovel	%ecx, %eax
rep	retq
nopl	(%rax)
ossl_rsaz_amm52x20_x1_ifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxord	%ymm0, %ymm0, %ymm0
vmovdqa64	%ymm0, %ymm3
vmovdqa64	%ymm0, %ymm16
vmovdqa64	%ymm0, %ymm17
vmovdqa64	%ymm0, %ymm18
vmovdqa64	%ymm0, %ymm19
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x5, %ebx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_80:
movq	(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
vpmadd52luq	(%rsi), %ymm1, %ymm3
vpmadd52luq	0x20(%rsi), %ymm1, %ymm16
vpmadd52luq	0x40(%rsi), %ymm1, %ymm17
vpmadd52luq	0x60(%rsi), %ymm1, %ymm18
vpmadd52luq	0x80(%rsi), %ymm1, %ymm19
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm16
vpmadd52luq	0x40(%rcx), %ymm2, %ymm17
vpmadd52luq	0x60(%rcx), %ymm2, %ymm18
vpmadd52luq	0x80(%rcx), %ymm2, %ymm19
valignq	$0x1, %ymm3, %ymm16, %ymm3
valignq	$0x1, %ymm16, %ymm17, %ymm16
valignq	$0x1, %ymm17, %ymm18, %ymm17
valignq	$0x1, %ymm18, %ymm19, %ymm18
valignq	$0x1, %ymm19, %ymm0, %ymm19
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm16
vpmadd52huq	0x40(%rsi), %ymm1, %ymm17
vpmadd52huq	0x60(%rsi), %ymm1, %ymm18
vpmadd52huq	0x80(%rsi), %ymm1, %ymm19
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm16
vpmadd52huq	0x40(%rcx), %ymm2, %ymm17
vpmadd52huq	0x60(%rcx), %ymm2, %ymm18
vpmadd52huq	0x80(%rcx), %ymm2, %ymm19
movq	0x8(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
vpmadd52luq	(%rsi), %ymm1, %ymm3
vpmadd52luq	0x20(%rsi), %ymm1, %ymm16
vpmadd52luq	0x40(%rsi), %ymm1, %ymm17
vpmadd52luq	0x60(%rsi), %ymm1, %ymm18
vpmadd52luq	0x80(%rsi), %ymm1, %ymm19
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm16
vpmadd52luq	0x40(%rcx), %ymm2, %ymm17
vpmadd52luq	0x60(%rcx), %ymm2, %ymm18
vpmadd52luq	0x80(%rcx), %ymm2, %ymm19
valignq	$0x1, %ymm3, %ymm16, %ymm3
valignq	$0x1, %ymm16, %ymm17, %ymm16
valignq	$0x1, %ymm17, %ymm18, %ymm17
valignq	$0x1, %ymm18, %ymm19, %ymm18
valignq	$0x1, %ymm19, %ymm0, %ymm19
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm16
vpmadd52huq	0x40(%rsi), %ymm1, %ymm17
vpmadd52huq	0x60(%rsi), %ymm1, %ymm18
vpmadd52huq	0x80(%rsi), %ymm1, %ymm19
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm16
vpmadd52huq	0x40(%rcx), %ymm2, %ymm17
vpmadd52huq	0x60(%rcx), %ymm2, %ymm18
vpmadd52huq	0x80(%rcx), %ymm2, %ymm19
movq	0x10(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
vpmadd52luq	(%rsi), %ymm1, %ymm3
vpmadd52luq	0x20(%rsi), %ymm1, %ymm16
vpmadd52luq	0x40(%rsi), %ymm1, %ymm17
vpmadd52luq	0x60(%rsi), %ymm1, %ymm18
vpmadd52luq	0x80(%rsi), %ymm1, %ymm19
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm16
vpmadd52luq	0x40(%rcx), %ymm2, %ymm17
vpmadd52luq	0x60(%rcx), %ymm2, %ymm18
vpmadd52luq	0x80(%rcx), %ymm2, %ymm19
valignq	$0x1, %ymm3, %ymm16, %ymm3
valignq	$0x1, %ymm16, %ymm17, %ymm16
valignq	$0x1, %ymm17, %ymm18, %ymm17
valignq	$0x1, %ymm18, %ymm19, %ymm18
valignq	$0x1, %ymm19, %ymm0, %ymm19
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm16
vpmadd52huq	0x40(%rsi), %ymm1, %ymm17
vpmadd52huq	0x60(%rsi), %ymm1, %ymm18
vpmadd52huq	0x80(%rsi), %ymm1, %ymm19
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm16
vpmadd52huq	0x40(%rcx), %ymm2, %ymm17
vpmadd52huq	0x60(%rcx), %ymm2, %ymm18
vpmadd52huq	0x80(%rcx), %ymm2, %ymm19
movq	0x18(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
vpmadd52luq	(%rsi), %ymm1, %ymm3
vpmadd52luq	0x20(%rsi), %ymm1, %ymm16
vpmadd52luq	0x40(%rsi), %ymm1, %ymm17
vpmadd52luq	0x60(%rsi), %ymm1, %ymm18
vpmadd52luq	0x80(%rsi), %ymm1, %ymm19
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm16
vpmadd52luq	0x40(%rcx), %ymm2, %ymm17
vpmadd52luq	0x60(%rcx), %ymm2, %ymm18
vpmadd52luq	0x80(%rcx), %ymm2, %ymm19
valignq	$0x1, %ymm3, %ymm16, %ymm3
valignq	$0x1, %ymm16, %ymm17, %ymm16
valignq	$0x1, %ymm17, %ymm18, %ymm17
valignq	$0x1, %ymm18, %ymm19, %ymm18
valignq	$0x1, %ymm19, %ymm0, %ymm19
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm16
vpmadd52huq	0x40(%rsi), %ymm1, %ymm17
vpmadd52huq	0x60(%rsi), %ymm1, %ymm18
vpmadd52huq	0x80(%rsi), %ymm1, %ymm19
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm16
vpmadd52huq	0x40(%rcx), %ymm2, %ymm17
vpmadd52huq	0x60(%rcx), %ymm2, %ymm18
vpmadd52huq	0x80(%rcx), %ymm2, %ymm19
leaq	0x20(%r11), %r11
decl	%ebx
jne	L_80
vpbroadcastq	%r9, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm16, %ymm1
vpsrlq	$0x34, %ymm17, %ymm2
vpsrlq	$0x34, %ymm18, %ymm25
vpsrlq	$0x34, %ymm19, %ymm26
valignq	$0x3, %ymm25, %ymm26, %ymm26
valignq	$0x3, %ymm2, %ymm25, %ymm25
valignq	$0x3, %ymm1, %ymm2, %ymm2
valignq	$0x3, %ymm0, %ymm1, %ymm1
valignq	$0x3, bums_rodata+64(%rip), %ymm0, %ymm0
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm16, %ymm16
vpandq	bums_rodata(%rip), %ymm17, %ymm17
vpandq	bums_rodata(%rip), %ymm18, %ymm18
vpandq	bums_rodata(%rip), %ymm19, %ymm19
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm16, %ymm16
vpaddq	%ymm2, %ymm17, %ymm17
vpaddq	%ymm25, %ymm18, %ymm18
vpaddq	%ymm26, %ymm19, %ymm19
vpcmpnleuq	bums_rodata(%rip), %ymm3, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm16, %k2
vpcmpnleuq	bums_rodata(%rip), %ymm17, %k3
vpcmpnleuq	bums_rodata(%rip), %ymm18, %k4
vpcmpnleuq	bums_rodata(%rip), %ymm19, %k5
kmovb	%k1, %r14d
kmovb	%k2, %r13d
kmovb	%k3, %r12d
kmovb	%k4, %r11d
kmovb	%k5, %r10d
vpcmpequq	bums_rodata(%rip), %ymm3, %k1
vpcmpequq	bums_rodata(%rip), %ymm16, %k2
vpcmpequq	bums_rodata(%rip), %ymm17, %k3
vpcmpequq	bums_rodata(%rip), %ymm18, %k4
vpcmpequq	bums_rodata(%rip), %ymm19, %k5
kmovb	%k1, %r9d
kmovb	%k2, %r8d
kmovb	%k3, %ebx
kmovb	%k4, %ecx
kmovb	%k5, %edx
shlb	$0x4, %r13b
orb	%r13b, %r14b
shlb	$0x4, %r11b
orb	%r11b, %r12b
addb	%r14b, %r14b
adcb	%r12b, %r12b
adcb	%r10b, %r10b
shlb	$0x4, %r8b
orb	%r8b, %r9b
shlb	$0x4, %cl
orb	%cl, %bl
addb	%r9b, %r14b
adcb	%bl, %r12b
adcb	%dl, %r10b
xorb	%r9b, %r14b
xorb	%bl, %r12b
xorb	%dl, %r10b
kmovb	%r14d, %k1
shrb	$0x4, %r14b
kmovb	%r14d, %k2
kmovb	%r12d, %k3
shrb	$0x4, %r12b
kmovb	%r12d, %k4
kmovb	%r10d, %k5
vpsubq	bums_rodata(%rip), %ymm3, %ymm3 {%k1}
vpsubq	bums_rodata(%rip), %ymm16, %ymm16 {%k2}
vpsubq	bums_rodata(%rip), %ymm17, %ymm17 {%k3}
vpsubq	bums_rodata(%rip), %ymm18, %ymm18 {%k4}
vpsubq	bums_rodata(%rip), %ymm19, %ymm19 {%k5}
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm16, %ymm16
vpandq	bums_rodata(%rip), %ymm17, %ymm17
vpandq	bums_rodata(%rip), %ymm18, %ymm18
vpandq	bums_rodata(%rip), %ymm19, %ymm19
vmovdqu64	%ymm3, (%rdi)
vmovdqu64	%ymm16, 0x20(%rdi)
vmovdqu64	%ymm17, 0x40(%rdi)
vmovdqu64	%ymm18, 0x60(%rdi)
vmovdqu64	%ymm19, 0x80(%rdi)
vzeroupper
movq	(%rsp), %r15
movq	0x8(%rsp), %r14
movq	0x10(%rsp), %r13
movq	0x18(%rsp), %r12
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
leaq	0x30(%rsp), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
ossl_rsaz_amm52x20_x2_ifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxord	%ymm0, %ymm0, %ymm0
vmovdqa64	%ymm0, %ymm3
vmovdqa64	%ymm0, %ymm16
vmovdqa64	%ymm0, %ymm17
vmovdqa64	%ymm0, %ymm18
vmovdqa64	%ymm0, %ymm19
vmovdqa64	%ymm0, %ymm4
vmovdqa64	%ymm0, %ymm20
vmovdqa64	%ymm0, %ymm21
vmovdqa64	%ymm0, %ymm22
vmovdqa64	%ymm0, %ymm23
xorl	%r9d, %r9d
xorl	%r15d, %r15d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x14, %ebx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_740:
movq	(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	(%r8), %r13
imulq	%r9, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
vpmadd52luq	(%rsi), %ymm1, %ymm3
vpmadd52luq	0x20(%rsi), %ymm1, %ymm16
vpmadd52luq	0x40(%rsi), %ymm1, %ymm17
vpmadd52luq	0x60(%rsi), %ymm1, %ymm18
vpmadd52luq	0x80(%rsi), %ymm1, %ymm19
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm16
vpmadd52luq	0x40(%rcx), %ymm2, %ymm17
vpmadd52luq	0x60(%rcx), %ymm2, %ymm18
vpmadd52luq	0x80(%rcx), %ymm2, %ymm19
valignq	$0x1, %ymm3, %ymm16, %ymm3
valignq	$0x1, %ymm16, %ymm17, %ymm16
valignq	$0x1, %ymm17, %ymm18, %ymm17
valignq	$0x1, %ymm18, %ymm19, %ymm18
valignq	$0x1, %ymm19, %ymm0, %ymm19
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm16
vpmadd52huq	0x40(%rsi), %ymm1, %ymm17
vpmadd52huq	0x60(%rsi), %ymm1, %ymm18
vpmadd52huq	0x80(%rsi), %ymm1, %ymm19
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm16
vpmadd52huq	0x40(%rcx), %ymm2, %ymm17
vpmadd52huq	0x60(%rcx), %ymm2, %ymm18
vpmadd52huq	0x80(%rcx), %ymm2, %ymm19
movq	0xa0(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	0xa0(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r15
movq	%r12, %r10
adcq	$0x0, %r10
movq	0x8(%r8), %r13
imulq	%r15, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	0xa0(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r15
adcq	%r12, %r10
shrq	$0x34, %r15
shlq	$0xc, %r10
orq	%r10, %r15
vpmadd52luq	0xa0(%rsi), %ymm1, %ymm4
vpmadd52luq	0xc0(%rsi), %ymm1, %ymm20
vpmadd52luq	0xe0(%rsi), %ymm1, %ymm21
vpmadd52luq	0x100(%rsi), %ymm1, %ymm22
vpmadd52luq	0x120(%rsi), %ymm1, %ymm23
vpmadd52luq	0xa0(%rcx), %ymm2, %ymm4
vpmadd52luq	0xc0(%rcx), %ymm2, %ymm20
vpmadd52luq	0xe0(%rcx), %ymm2, %ymm21
vpmadd52luq	0x100(%rcx), %ymm2, %ymm22
vpmadd52luq	0x120(%rcx), %ymm2, %ymm23
valignq	$0x1, %ymm4, %ymm20, %ymm4
valignq	$0x1, %ymm20, %ymm21, %ymm20
valignq	$0x1, %ymm21, %ymm22, %ymm21
valignq	$0x1, %ymm22, %ymm23, %ymm22
valignq	$0x1, %ymm23, %ymm0, %ymm23
vmovq	%xmm4, %r13
addq	%r13, %r15
vpmadd52huq	0xa0(%rsi), %ymm1, %ymm4
vpmadd52huq	0xc0(%rsi), %ymm1, %ymm20
vpmadd52huq	0xe0(%rsi), %ymm1, %ymm21
vpmadd52huq	0x100(%rsi), %ymm1, %ymm22
vpmadd52huq	0x120(%rsi), %ymm1, %ymm23
vpmadd52huq	0xa0(%rcx), %ymm2, %ymm4
vpmadd52huq	0xc0(%rcx), %ymm2, %ymm20
vpmadd52huq	0xe0(%rcx), %ymm2, %ymm21
vpmadd52huq	0x100(%rcx), %ymm2, %ymm22
vpmadd52huq	0x120(%rcx), %ymm2, %ymm23
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_740
vpbroadcastq	%r9, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm16, %ymm1
vpsrlq	$0x34, %ymm17, %ymm2
vpsrlq	$0x34, %ymm18, %ymm25
vpsrlq	$0x34, %ymm19, %ymm26
valignq	$0x3, %ymm25, %ymm26, %ymm26
valignq	$0x3, %ymm2, %ymm25, %ymm25
valignq	$0x3, %ymm1, %ymm2, %ymm2
valignq	$0x3, %ymm0, %ymm1, %ymm1
valignq	$0x3, bums_rodata+64(%rip), %ymm0, %ymm0
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm16, %ymm16
vpandq	bums_rodata(%rip), %ymm17, %ymm17
vpandq	bums_rodata(%rip), %ymm18, %ymm18
vpandq	bums_rodata(%rip), %ymm19, %ymm19
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm16, %ymm16
vpaddq	%ymm2, %ymm17, %ymm17
vpaddq	%ymm25, %ymm18, %ymm18
vpaddq	%ymm26, %ymm19, %ymm19
vpcmpnleuq	bums_rodata(%rip), %ymm3, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm16, %k2
vpcmpnleuq	bums_rodata(%rip), %ymm17, %k3
vpcmpnleuq	bums_rodata(%rip), %ymm18, %k4
vpcmpnleuq	bums_rodata(%rip), %ymm19, %k5
kmovb	%k1, %r14d
kmovb	%k2, %r13d
kmovb	%k3, %r12d
kmovb	%k4, %r11d
kmovb	%k5, %r10d
vpcmpequq	bums_rodata(%rip), %ymm3, %k1
vpcmpequq	bums_rodata(%rip), %ymm16, %k2
vpcmpequq	bums_rodata(%rip), %ymm17, %k3
vpcmpequq	bums_rodata(%rip), %ymm18, %k4
vpcmpequq	bums_rodata(%rip), %ymm19, %k5
kmovb	%k1, %r9d
kmovb	%k2, %r8d
kmovb	%k3, %ebx
kmovb	%k4, %ecx
kmovb	%k5, %edx
shlb	$0x4, %r13b
orb	%r13b, %r14b
shlb	$0x4, %r11b
orb	%r11b, %r12b
addb	%r14b, %r14b
adcb	%r12b, %r12b
adcb	%r10b, %r10b
shlb	$0x4, %r8b
orb	%r8b, %r9b
shlb	$0x4, %cl
orb	%cl, %bl
addb	%r9b, %r14b
adcb	%bl, %r12b
adcb	%dl, %r10b
xorb	%r9b, %r14b
xorb	%bl, %r12b
xorb	%dl, %r10b
kmovb	%r14d, %k1
shrb	$0x4, %r14b
kmovb	%r14d, %k2
kmovb	%r12d, %k3
shrb	$0x4, %r12b
kmovb	%r12d, %k4
kmovb	%r10d, %k5
vpsubq	bums_rodata(%rip), %ymm3, %ymm3 {%k1}
vpsubq	bums_rodata(%rip), %ymm16, %ymm16 {%k2}
vpsubq	bums_rodata(%rip), %ymm17, %ymm17 {%k3}
vpsubq	bums_rodata(%rip), %ymm18, %ymm18 {%k4}
vpsubq	bums_rodata(%rip), %ymm19, %ymm19 {%k5}
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm16, %ymm16
vpandq	bums_rodata(%rip), %ymm17, %ymm17
vpandq	bums_rodata(%rip), %ymm18, %ymm18
vpandq	bums_rodata(%rip), %ymm19, %ymm19
vpbroadcastq	%r15, %ymm0
vpblendd	$0x3, %ymm0, %ymm4, %ymm4
vpsrlq	$0x34, %ymm4, %ymm0
vpsrlq	$0x34, %ymm20, %ymm1
vpsrlq	$0x34, %ymm21, %ymm2
vpsrlq	$0x34, %ymm22, %ymm25
vpsrlq	$0x34, %ymm23, %ymm26
valignq	$0x3, %ymm25, %ymm26, %ymm26
valignq	$0x3, %ymm2, %ymm25, %ymm25
valignq	$0x3, %ymm1, %ymm2, %ymm2
valignq	$0x3, %ymm0, %ymm1, %ymm1
valignq	$0x3, bums_rodata+64(%rip), %ymm0, %ymm0
vpandq	bums_rodata(%rip), %ymm4, %ymm4
vpandq	bums_rodata(%rip), %ymm20, %ymm20
vpandq	bums_rodata(%rip), %ymm21, %ymm21
vpandq	bums_rodata(%rip), %ymm22, %ymm22
vpandq	bums_rodata(%rip), %ymm23, %ymm23
vpaddq	%ymm0, %ymm4, %ymm4
vpaddq	%ymm1, %ymm20, %ymm20
vpaddq	%ymm2, %ymm21, %ymm21
vpaddq	%ymm25, %ymm22, %ymm22
vpaddq	%ymm26, %ymm23, %ymm23
vpcmpnleuq	bums_rodata(%rip), %ymm4, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm20, %k2
vpcmpnleuq	bums_rodata(%rip), %ymm21, %k3
vpcmpnleuq	bums_rodata(%rip), %ymm22, %k4
vpcmpnleuq	bums_rodata(%rip), %ymm23, %k5
kmovb	%k1, %r14d
kmovb	%k2, %r13d
kmovb	%k3, %r12d
kmovb	%k4, %r11d
kmovb	%k5, %r10d
vpcmpequq	bums_rodata(%rip), %ymm4, %k1
vpcmpequq	bums_rodata(%rip), %ymm20, %k2
vpcmpequq	bums_rodata(%rip), %ymm21, %k3
vpcmpequq	bums_rodata(%rip), %ymm22, %k4
vpcmpequq	bums_rodata(%rip), %ymm23, %k5
kmovb	%k1, %r9d
kmovb	%k2, %r8d
kmovb	%k3, %ebx
kmovb	%k4, %ecx
kmovb	%k5, %edx
shlb	$0x4, %r13b
orb	%r13b, %r14b
shlb	$0x4, %r11b
orb	%r11b, %r12b
addb	%r14b, %r14b
adcb	%r12b, %r12b
adcb	%r10b, %r10b
shlb	$0x4, %r8b
orb	%r8b, %r9b
shlb	$0x4, %cl
orb	%cl, %bl
addb	%r9b, %r14b
adcb	%bl, %r12b
adcb	%dl, %r10b
xorb	%r9b, %r14b
xorb	%bl, %r12b
xorb	%dl, %r10b
kmovb	%r14d, %k1
shrb	$0x4, %r14b
kmovb	%r14d, %k2
kmovb	%r12d, %k3
shrb	$0x4, %r12b
kmovb	%r12d, %k4
kmovb	%r10d, %k5
vpsubq	bums_rodata(%rip), %ymm4, %ymm4 {%k1}
vpsubq	bums_rodata(%rip), %ymm20, %ymm20 {%k2}
vpsubq	bums_rodata(%rip), %ymm21, %ymm21 {%k3}
vpsubq	bums_rodata(%rip), %ymm22, %ymm22 {%k4}
vpsubq	bums_rodata(%rip), %ymm23, %ymm23 {%k5}
vpandq	bums_rodata(%rip), %ymm4, %ymm4
vpandq	bums_rodata(%rip), %ymm20, %ymm20
vpandq	bums_rodata(%rip), %ymm21, %ymm21
vpandq	bums_rodata(%rip), %ymm22, %ymm22
vpandq	bums_rodata(%rip), %ymm23, %ymm23
vmovdqu64	%ymm3, (%rdi)
vmovdqu64	%ymm16, 0x20(%rdi)
vmovdqu64	%ymm17, 0x40(%rdi)
vmovdqu64	%ymm18, 0x60(%rdi)
vmovdqu64	%ymm19, 0x80(%rdi)
vmovdqu64	%ymm4, 0xa0(%rdi)
vmovdqu64	%ymm20, 0xc0(%rdi)
vmovdqu64	%ymm21, 0xe0(%rdi)
vmovdqu64	%ymm22, 0x100(%rdi)
vmovdqu64	%ymm23, 0x120(%rdi)
vzeroupper
movq	(%rsp), %r15
movq	0x8(%rsp), %r14
movq	0x10(%rsp), %r13
movq	0x18(%rsp), %r12
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
leaq	0x30(%rsp), %rsp
rep	retq
nopl	(%rax,%rax)
ossl_extract_multiplier_2x20_win5:
endbr64
vmovdqa64	bums_rodata+32(%rip), %ymm24
vpbroadcastq	%rdx, %ymm22
vpbroadcastq	%rcx, %ymm23
leaq	0x2800(%rsi), %rax
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa64	%ymm0, %ymm21
vmovdqa64	%ymm0, %ymm1
vmovdqa64	%ymm0, %ymm2
vmovdqa64	%ymm0, %ymm3
vmovdqa64	%ymm0, %ymm4
vmovdqa64	%ymm0, %ymm5
vmovdqa64	%ymm0, %ymm16
vmovdqa64	%ymm0, %ymm17
vmovdqa64	%ymm0, %ymm18
vmovdqa64	%ymm0, %ymm19
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_e20:
vpcmpeqq	%ymm21, %ymm22, %k1
vpcmpeqq	%ymm21, %ymm23, %k2
vmovdqu64	(%rsi), %ymm20
vpblendmq	%ymm20, %ymm0, %ymm0 {%k1}
vmovdqu64	0x20(%rsi), %ymm20
vpblendmq	%ymm20, %ymm1, %ymm1 {%k1}
vmovdqu64	0x40(%rsi), %ymm20
vpblendmq	%ymm20, %ymm2, %ymm2 {%k1}
vmovdqu64	0x60(%rsi), %ymm20
vpblendmq	%ymm20, %ymm3, %ymm3 {%k1}
vmovdqu64	0x80(%rsi), %ymm20
vpblendmq	%ymm20, %ymm4, %ymm4 {%k1}
vmovdqu64	0xa0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm5, %ymm5 {%k2}
vmovdqu64	0xc0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm16, %ymm16 {%k2}
vmovdqu64	0xe0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm17, %ymm17 {%k2}
vmovdqu64	0x100(%rsi), %ymm20
vpblendmq	%ymm20, %ymm18, %ymm18 {%k2}
vmovdqu64	0x120(%rsi), %ymm20
vpblendmq	%ymm20, %ymm19, %ymm19 {%k2}
vpaddq	%ymm24, %ymm21, %ymm21
addq	$0x140, %rsi
cmpq	%rsi, %rax
jne	L_e20
vmovdqu64	%ymm0, (%rdi)
vmovdqu64	%ymm1, 0x20(%rdi)
vmovdqu64	%ymm2, 0x40(%rdi)
vmovdqu64	%ymm3, 0x60(%rdi)
vmovdqu64	%ymm4, 0x80(%rdi)
vmovdqu64	%ymm5, 0xa0(%rdi)
vmovdqu64	%ymm16, 0xc0(%rdi)
vmovdqu64	%ymm17, 0xe0(%rdi)
vmovdqu64	%ymm18, 0x100(%rdi)
vmovdqu64	%ymm19, 0x120(%rdi)
rep	retq
	.section .rodata
bums_rodata:
	.byte 255,255,255,255,255,255,15,0,255,255,255,255,255,255,15,0
	.byte 255,255,255,255,255,255,15,0,255,255,255,255,255,255,15,0
	.byte 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

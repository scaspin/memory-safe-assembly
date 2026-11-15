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
	.p2align 5
bums_rodata:
	.byte 255,255,255,255,255,255,15,0,255,255,255,255,255,255,15,0
	.byte 255,255,255,255,255,255,15,0,255,255,255,255,255,255,15,0
	.byte 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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

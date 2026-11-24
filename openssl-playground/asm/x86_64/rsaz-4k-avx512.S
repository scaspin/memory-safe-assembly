	.text
ossl_rsaz_amm52x40_x1_ifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxord	%ymm0, %ymm0, %ymm0
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
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0xa, %ebx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
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
vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
valignq	$0x1, %ymm3, %ymm4, %ymm3
valignq	$0x1, %ymm4, %ymm5, %ymm4
valignq	$0x1, %ymm5, %ymm6, %ymm5
valignq	$0x1, %ymm6, %ymm7, %ymm6
valignq	$0x1, %ymm7, %ymm8, %ymm7
valignq	$0x1, %ymm8, %ymm9, %ymm8
valignq	$0x1, %ymm9, %ymm10, %ymm9
valignq	$0x1, %ymm10, %ymm11, %ymm10
valignq	$0x1, %ymm11, %ymm12, %ymm11
valignq	$0x1, %ymm12, %ymm0, %ymm12
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
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
vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
valignq	$0x1, %ymm3, %ymm4, %ymm3
valignq	$0x1, %ymm4, %ymm5, %ymm4
valignq	$0x1, %ymm5, %ymm6, %ymm5
valignq	$0x1, %ymm6, %ymm7, %ymm6
valignq	$0x1, %ymm7, %ymm8, %ymm7
valignq	$0x1, %ymm8, %ymm9, %ymm8
valignq	$0x1, %ymm9, %ymm10, %ymm9
valignq	$0x1, %ymm10, %ymm11, %ymm10
valignq	$0x1, %ymm11, %ymm12, %ymm11
valignq	$0x1, %ymm12, %ymm0, %ymm12
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
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
vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
valignq	$0x1, %ymm3, %ymm4, %ymm3
valignq	$0x1, %ymm4, %ymm5, %ymm4
valignq	$0x1, %ymm5, %ymm6, %ymm5
valignq	$0x1, %ymm6, %ymm7, %ymm6
valignq	$0x1, %ymm7, %ymm8, %ymm7
valignq	$0x1, %ymm8, %ymm9, %ymm8
valignq	$0x1, %ymm9, %ymm10, %ymm9
valignq	$0x1, %ymm10, %ymm11, %ymm10
valignq	$0x1, %ymm11, %ymm12, %ymm11
valignq	$0x1, %ymm12, %ymm0, %ymm12
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
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
vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
valignq	$0x1, %ymm3, %ymm4, %ymm3
valignq	$0x1, %ymm4, %ymm5, %ymm4
valignq	$0x1, %ymm5, %ymm6, %ymm5
valignq	$0x1, %ymm6, %ymm7, %ymm6
valignq	$0x1, %ymm7, %ymm8, %ymm7
valignq	$0x1, %ymm8, %ymm9, %ymm8
valignq	$0x1, %ymm9, %ymm10, %ymm9
valignq	$0x1, %ymm10, %ymm11, %ymm10
valignq	$0x1, %ymm11, %ymm12, %ymm11
valignq	$0x1, %ymm12, %ymm0, %ymm12
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0x20(%r11), %r11
decl	%ebx
jne	L_80
vpbroadcastq	%r9, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm4, %ymm1
vpsrlq	$0x34, %ymm5, %ymm2
vpsrlq	$0x34, %ymm6, %ymm23
vpsrlq	$0x34, %ymm7, %ymm24
vpsrlq	$0x34, %ymm8, %ymm25
vpsrlq	$0x34, %ymm9, %ymm26
vpsrlq	$0x34, %ymm10, %ymm27
vpsrlq	$0x34, %ymm11, %ymm28
vpsrlq	$0x34, %ymm12, %ymm29
valignq	$0x3, %ymm28, %ymm29, %ymm29
valignq	$0x3, %ymm27, %ymm28, %ymm28
valignq	$0x3, %ymm26, %ymm27, %ymm27
valignq	$0x3, %ymm25, %ymm26, %ymm26
valignq	$0x3, %ymm24, %ymm25, %ymm25
valignq	$0x3, %ymm23, %ymm24, %ymm24
valignq	$0x3, %ymm2, %ymm23, %ymm23
valignq	$0x3, %ymm1, %ymm2, %ymm2
valignq	$0x3, %ymm0, %ymm1, %ymm1
valignq	$0x3, bums_rodata+64(%rip), %ymm0, %ymm0
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm4, %ymm4
vpandq	bums_rodata(%rip), %ymm5, %ymm5
vpandq	bums_rodata(%rip), %ymm6, %ymm6
vpandq	bums_rodata(%rip), %ymm7, %ymm7
vpandq	bums_rodata(%rip), %ymm8, %ymm8
vpandq	bums_rodata(%rip), %ymm9, %ymm9
vpandq	bums_rodata(%rip), %ymm10, %ymm10
vpandq	bums_rodata(%rip), %ymm11, %ymm11
vpandq	bums_rodata(%rip), %ymm12, %ymm12
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm4, %ymm4
vpaddq	%ymm2, %ymm5, %ymm5
vpaddq	%ymm23, %ymm6, %ymm6
vpaddq	%ymm24, %ymm7, %ymm7
vpaddq	%ymm25, %ymm8, %ymm8
vpaddq	%ymm26, %ymm9, %ymm9
vpaddq	%ymm27, %ymm10, %ymm10
vpaddq	%ymm28, %ymm11, %ymm11
vpaddq	%ymm29, %ymm12, %ymm12
vpcmpnleuq	bums_rodata(%rip), %ymm3, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm4, %k2
kmovb	%k1, %r14d
kmovb	%k2, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpnleuq	bums_rodata(%rip), %ymm5, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm6, %k2
kmovb	%k1, %r13d
kmovb	%k2, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpnleuq	bums_rodata(%rip), %ymm7, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm8, %k2
kmovb	%k1, %r12d
kmovb	%k2, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpnleuq	bums_rodata(%rip), %ymm9, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm10, %k2
kmovb	%k1, %r11d
kmovb	%k2, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
vpcmpnleuq	bums_rodata(%rip), %ymm11, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm12, %k2
kmovb	%k1, %r10d
kmovb	%k2, %r9d
shlb	$0x4, %r9b
orb	%r9b, %r10b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
adcb	%r10b, %r10b
vpcmpequq	bums_rodata(%rip), %ymm3, %k1
vpcmpequq	bums_rodata(%rip), %ymm4, %k2
kmovb	%k1, %r9d
kmovb	%k2, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpequq	bums_rodata(%rip), %ymm5, %k1
vpcmpequq	bums_rodata(%rip), %ymm6, %k2
kmovb	%k1, %r8d
kmovb	%k2, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpequq	bums_rodata(%rip), %ymm7, %k1
vpcmpequq	bums_rodata(%rip), %ymm8, %k2
kmovb	%k1, %edx
kmovb	%k2, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpequq	bums_rodata(%rip), %ymm9, %k1
vpcmpequq	bums_rodata(%rip), %ymm10, %k2
kmovb	%k1, %ecx
kmovb	%k2, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
vpcmpequq	bums_rodata(%rip), %ymm11, %k1
vpcmpequq	bums_rodata(%rip), %ymm12, %k2
kmovb	%k1, %ebx
kmovb	%k2, %eax
shlb	$0x4, %al
orb	%al, %bl
addb	%r9b, %r14b
adcb	%r8b, %r13b
adcb	%dl, %r12b
adcb	%cl, %r11b
adcb	%bl, %r10b
xorb	%r9b, %r14b
xorb	%r8b, %r13b
xorb	%dl, %r12b
xorb	%cl, %r11b
xorb	%bl, %r10b
kmovb	%r14d, %k1
shrb	$0x4, %r14b
kmovb	%r14d, %k2
kmovb	%r13d, %k3
shrb	$0x4, %r13b
kmovb	%r13d, %k4
kmovb	%r12d, %k5
shrb	$0x4, %r12b
kmovb	%r12d, %k6
kmovb	%r11d, %k7
vpsubq	bums_rodata(%rip), %ymm3, %ymm3 {%k1}
vpsubq	bums_rodata(%rip), %ymm4, %ymm4 {%k2}
vpsubq	bums_rodata(%rip), %ymm5, %ymm5 {%k3}
vpsubq	bums_rodata(%rip), %ymm6, %ymm6 {%k4}
vpsubq	bums_rodata(%rip), %ymm7, %ymm7 {%k5}
vpsubq	bums_rodata(%rip), %ymm8, %ymm8 {%k6}
vpsubq	bums_rodata(%rip), %ymm9, %ymm9 {%k7}
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm4, %ymm4
vpandq	bums_rodata(%rip), %ymm5, %ymm5
vpandq	bums_rodata(%rip), %ymm6, %ymm6
vpandq	bums_rodata(%rip), %ymm7, %ymm7
vpandq	bums_rodata(%rip), %ymm8, %ymm8
vpandq	bums_rodata(%rip), %ymm9, %ymm9
shrb	$0x4, %r11b
kmovb	%r11d, %k1
kmovb	%r10d, %k2
shrb	$0x4, %r10b
kmovb	%r10d, %k3
vpsubq	bums_rodata(%rip), %ymm10, %ymm10 {%k1}
vpsubq	bums_rodata(%rip), %ymm11, %ymm11 {%k2}
vpsubq	bums_rodata(%rip), %ymm12, %ymm12 {%k3}
vpandq	bums_rodata(%rip), %ymm10, %ymm10
vpandq	bums_rodata(%rip), %ymm11, %ymm11
vpandq	bums_rodata(%rip), %ymm12, %ymm12
vmovdqu64	%ymm3, (%rdi)
vmovdqu64	%ymm4, 0x20(%rdi)
vmovdqu64	%ymm5, 0x40(%rdi)
vmovdqu64	%ymm6, 0x60(%rdi)
vmovdqu64	%ymm7, 0x80(%rdi)
vmovdqu64	%ymm8, 0xa0(%rdi)
vmovdqu64	%ymm9, 0xc0(%rdi)
vmovdqu64	%ymm10, 0xe0(%rdi)
vmovdqu64	%ymm11, 0x100(%rdi)
vmovdqu64	%ymm12, 0x120(%rdi)
vzeroupper
leaq	(%rsp), %rax
movq	(%rax), %r15
movq	0x8(%rax), %r14
movq	0x10(%rax), %r13
movq	0x18(%rax), %r12
movq	0x20(%rax), %rbp
movq	0x28(%rax), %rbx
leaq	0x30(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
ossl_rsaz_amm52x40_x2_ifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxord	%ymm0, %ymm0, %ymm0
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
xorl	%r9d, %r9d
xorl	%r15d, %r15d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x28, %ebx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_c40:
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
vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
vpmadd52luq	(%rcx), %ymm2, %ymm3
vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
valignq	$0x1, %ymm3, %ymm4, %ymm3
valignq	$0x1, %ymm4, %ymm5, %ymm4
valignq	$0x1, %ymm5, %ymm6, %ymm5
valignq	$0x1, %ymm6, %ymm7, %ymm6
valignq	$0x1, %ymm7, %ymm8, %ymm7
valignq	$0x1, %ymm8, %ymm9, %ymm8
valignq	$0x1, %ymm9, %ymm10, %ymm9
valignq	$0x1, %ymm10, %ymm11, %ymm10
valignq	$0x1, %ymm11, %ymm12, %ymm11
valignq	$0x1, %ymm12, %ymm0, %ymm12
vmovq	%xmm3, %r13
addq	%r13, %r9
vpmadd52huq	(%rsi), %ymm1, %ymm3
vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
vpmadd52huq	(%rcx), %ymm2, %ymm3
vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
movq	0x140(%r11), %r13
vpbroadcastq	%r13, %ymm1
movq	0x140(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r15
movq	%r12, %r10
adcq	$0x0, %r10
movq	0x8(%r8), %r13
imulq	%r15, %r13
andq	%rax, %r13
vpbroadcastq	%r13, %ymm2
movq	0x140(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r15
adcq	%r12, %r10
shrq	$0x34, %r15
shlq	$0xc, %r10
orq	%r10, %r15
vpmadd52luq	0x140(%rsi), %ymm1, %ymm13
vpmadd52luq	0x160(%rsi), %ymm1, %ymm14
vpmadd52luq	0x180(%rsi), %ymm1, %ymm15
vpmadd52luq	0x1a0(%rsi), %ymm1, %ymm16
vpmadd52luq	0x1c0(%rsi), %ymm1, %ymm17
vpmadd52luq	0x1e0(%rsi), %ymm1, %ymm18
vpmadd52luq	0x200(%rsi), %ymm1, %ymm19
vpmadd52luq	0x220(%rsi), %ymm1, %ymm20
vpmadd52luq	0x240(%rsi), %ymm1, %ymm21
vpmadd52luq	0x260(%rsi), %ymm1, %ymm22
vpmadd52luq	0x140(%rcx), %ymm2, %ymm13
vpmadd52luq	0x160(%rcx), %ymm2, %ymm14
vpmadd52luq	0x180(%rcx), %ymm2, %ymm15
vpmadd52luq	0x1a0(%rcx), %ymm2, %ymm16
vpmadd52luq	0x1c0(%rcx), %ymm2, %ymm17
vpmadd52luq	0x1e0(%rcx), %ymm2, %ymm18
vpmadd52luq	0x200(%rcx), %ymm2, %ymm19
vpmadd52luq	0x220(%rcx), %ymm2, %ymm20
vpmadd52luq	0x240(%rcx), %ymm2, %ymm21
vpmadd52luq	0x260(%rcx), %ymm2, %ymm22
valignq	$0x1, %ymm13, %ymm14, %ymm13
valignq	$0x1, %ymm14, %ymm15, %ymm14
valignq	$0x1, %ymm15, %ymm16, %ymm15
valignq	$0x1, %ymm16, %ymm17, %ymm16
valignq	$0x1, %ymm17, %ymm18, %ymm17
valignq	$0x1, %ymm18, %ymm19, %ymm18
valignq	$0x1, %ymm19, %ymm20, %ymm19
valignq	$0x1, %ymm20, %ymm21, %ymm20
valignq	$0x1, %ymm21, %ymm22, %ymm21
valignq	$0x1, %ymm22, %ymm0, %ymm22
vmovq	%xmm13, %r13
addq	%r13, %r15
vpmadd52huq	0x140(%rsi), %ymm1, %ymm13
vpmadd52huq	0x160(%rsi), %ymm1, %ymm14
vpmadd52huq	0x180(%rsi), %ymm1, %ymm15
vpmadd52huq	0x1a0(%rsi), %ymm1, %ymm16
vpmadd52huq	0x1c0(%rsi), %ymm1, %ymm17
vpmadd52huq	0x1e0(%rsi), %ymm1, %ymm18
vpmadd52huq	0x200(%rsi), %ymm1, %ymm19
vpmadd52huq	0x220(%rsi), %ymm1, %ymm20
vpmadd52huq	0x240(%rsi), %ymm1, %ymm21
vpmadd52huq	0x260(%rsi), %ymm1, %ymm22
vpmadd52huq	0x140(%rcx), %ymm2, %ymm13
vpmadd52huq	0x160(%rcx), %ymm2, %ymm14
vpmadd52huq	0x180(%rcx), %ymm2, %ymm15
vpmadd52huq	0x1a0(%rcx), %ymm2, %ymm16
vpmadd52huq	0x1c0(%rcx), %ymm2, %ymm17
vpmadd52huq	0x1e0(%rcx), %ymm2, %ymm18
vpmadd52huq	0x200(%rcx), %ymm2, %ymm19
vpmadd52huq	0x220(%rcx), %ymm2, %ymm20
vpmadd52huq	0x240(%rcx), %ymm2, %ymm21
vpmadd52huq	0x260(%rcx), %ymm2, %ymm22
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_c40
vpbroadcastq	%r9, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm4, %ymm1
vpsrlq	$0x34, %ymm5, %ymm2
vpsrlq	$0x34, %ymm6, %ymm23
vpsrlq	$0x34, %ymm7, %ymm24
vpsrlq	$0x34, %ymm8, %ymm25
vpsrlq	$0x34, %ymm9, %ymm26
vpsrlq	$0x34, %ymm10, %ymm27
vpsrlq	$0x34, %ymm11, %ymm28
vpsrlq	$0x34, %ymm12, %ymm29
valignq	$0x3, %ymm28, %ymm29, %ymm29
valignq	$0x3, %ymm27, %ymm28, %ymm28
valignq	$0x3, %ymm26, %ymm27, %ymm27
valignq	$0x3, %ymm25, %ymm26, %ymm26
valignq	$0x3, %ymm24, %ymm25, %ymm25
valignq	$0x3, %ymm23, %ymm24, %ymm24
valignq	$0x3, %ymm2, %ymm23, %ymm23
valignq	$0x3, %ymm1, %ymm2, %ymm2
valignq	$0x3, %ymm0, %ymm1, %ymm1
valignq	$0x3, bums_rodata+64(%rip), %ymm0, %ymm0
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm4, %ymm4
vpandq	bums_rodata(%rip), %ymm5, %ymm5
vpandq	bums_rodata(%rip), %ymm6, %ymm6
vpandq	bums_rodata(%rip), %ymm7, %ymm7
vpandq	bums_rodata(%rip), %ymm8, %ymm8
vpandq	bums_rodata(%rip), %ymm9, %ymm9
vpandq	bums_rodata(%rip), %ymm10, %ymm10
vpandq	bums_rodata(%rip), %ymm11, %ymm11
vpandq	bums_rodata(%rip), %ymm12, %ymm12
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm4, %ymm4
vpaddq	%ymm2, %ymm5, %ymm5
vpaddq	%ymm23, %ymm6, %ymm6
vpaddq	%ymm24, %ymm7, %ymm7
vpaddq	%ymm25, %ymm8, %ymm8
vpaddq	%ymm26, %ymm9, %ymm9
vpaddq	%ymm27, %ymm10, %ymm10
vpaddq	%ymm28, %ymm11, %ymm11
vpaddq	%ymm29, %ymm12, %ymm12
vpcmpnleuq	bums_rodata(%rip), %ymm3, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm4, %k2
kmovb	%k1, %r14d
kmovb	%k2, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpnleuq	bums_rodata(%rip), %ymm5, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm6, %k2
kmovb	%k1, %r13d
kmovb	%k2, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpnleuq	bums_rodata(%rip), %ymm7, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm8, %k2
kmovb	%k1, %r12d
kmovb	%k2, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpnleuq	bums_rodata(%rip), %ymm9, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm10, %k2
kmovb	%k1, %r11d
kmovb	%k2, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
vpcmpnleuq	bums_rodata(%rip), %ymm11, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm12, %k2
kmovb	%k1, %r10d
kmovb	%k2, %r9d
shlb	$0x4, %r9b
orb	%r9b, %r10b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
adcb	%r10b, %r10b
vpcmpequq	bums_rodata(%rip), %ymm3, %k1
vpcmpequq	bums_rodata(%rip), %ymm4, %k2
kmovb	%k1, %r9d
kmovb	%k2, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpequq	bums_rodata(%rip), %ymm5, %k1
vpcmpequq	bums_rodata(%rip), %ymm6, %k2
kmovb	%k1, %r8d
kmovb	%k2, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpequq	bums_rodata(%rip), %ymm7, %k1
vpcmpequq	bums_rodata(%rip), %ymm8, %k2
kmovb	%k1, %edx
kmovb	%k2, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpequq	bums_rodata(%rip), %ymm9, %k1
vpcmpequq	bums_rodata(%rip), %ymm10, %k2
kmovb	%k1, %ecx
kmovb	%k2, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
vpcmpequq	bums_rodata(%rip), %ymm11, %k1
vpcmpequq	bums_rodata(%rip), %ymm12, %k2
kmovb	%k1, %ebx
kmovb	%k2, %eax
shlb	$0x4, %al
orb	%al, %bl
addb	%r9b, %r14b
adcb	%r8b, %r13b
adcb	%dl, %r12b
adcb	%cl, %r11b
adcb	%bl, %r10b
xorb	%r9b, %r14b
xorb	%r8b, %r13b
xorb	%dl, %r12b
xorb	%cl, %r11b
xorb	%bl, %r10b
kmovb	%r14d, %k1
shrb	$0x4, %r14b
kmovb	%r14d, %k2
kmovb	%r13d, %k3
shrb	$0x4, %r13b
kmovb	%r13d, %k4
kmovb	%r12d, %k5
shrb	$0x4, %r12b
kmovb	%r12d, %k6
kmovb	%r11d, %k7
vpsubq	bums_rodata(%rip), %ymm3, %ymm3 {%k1}
vpsubq	bums_rodata(%rip), %ymm4, %ymm4 {%k2}
vpsubq	bums_rodata(%rip), %ymm5, %ymm5 {%k3}
vpsubq	bums_rodata(%rip), %ymm6, %ymm6 {%k4}
vpsubq	bums_rodata(%rip), %ymm7, %ymm7 {%k5}
vpsubq	bums_rodata(%rip), %ymm8, %ymm8 {%k6}
vpsubq	bums_rodata(%rip), %ymm9, %ymm9 {%k7}
vpandq	bums_rodata(%rip), %ymm3, %ymm3
vpandq	bums_rodata(%rip), %ymm4, %ymm4
vpandq	bums_rodata(%rip), %ymm5, %ymm5
vpandq	bums_rodata(%rip), %ymm6, %ymm6
vpandq	bums_rodata(%rip), %ymm7, %ymm7
vpandq	bums_rodata(%rip), %ymm8, %ymm8
vpandq	bums_rodata(%rip), %ymm9, %ymm9
shrb	$0x4, %r11b
kmovb	%r11d, %k1
kmovb	%r10d, %k2
shrb	$0x4, %r10b
kmovb	%r10d, %k3
vpsubq	bums_rodata(%rip), %ymm10, %ymm10 {%k1}
vpsubq	bums_rodata(%rip), %ymm11, %ymm11 {%k2}
vpsubq	bums_rodata(%rip), %ymm12, %ymm12 {%k3}
vpandq	bums_rodata(%rip), %ymm10, %ymm10
vpandq	bums_rodata(%rip), %ymm11, %ymm11
vpandq	bums_rodata(%rip), %ymm12, %ymm12
vpbroadcastq	%r15, %ymm0
vpblendd	$0x3, %ymm0, %ymm13, %ymm13
vpsrlq	$0x34, %ymm13, %ymm0
vpsrlq	$0x34, %ymm14, %ymm1
vpsrlq	$0x34, %ymm15, %ymm2
vpsrlq	$0x34, %ymm16, %ymm23
vpsrlq	$0x34, %ymm17, %ymm24
vpsrlq	$0x34, %ymm18, %ymm25
vpsrlq	$0x34, %ymm19, %ymm26
vpsrlq	$0x34, %ymm20, %ymm27
vpsrlq	$0x34, %ymm21, %ymm28
vpsrlq	$0x34, %ymm22, %ymm29
valignq	$0x3, %ymm28, %ymm29, %ymm29
valignq	$0x3, %ymm27, %ymm28, %ymm28
valignq	$0x3, %ymm26, %ymm27, %ymm27
valignq	$0x3, %ymm25, %ymm26, %ymm26
valignq	$0x3, %ymm24, %ymm25, %ymm25
valignq	$0x3, %ymm23, %ymm24, %ymm24
valignq	$0x3, %ymm2, %ymm23, %ymm23
valignq	$0x3, %ymm1, %ymm2, %ymm2
valignq	$0x3, %ymm0, %ymm1, %ymm1
valignq	$0x3, bums_rodata+64(%rip), %ymm0, %ymm0
vpandq	bums_rodata(%rip), %ymm13, %ymm13
vpandq	bums_rodata(%rip), %ymm14, %ymm14
vpandq	bums_rodata(%rip), %ymm15, %ymm15
vpandq	bums_rodata(%rip), %ymm16, %ymm16
vpandq	bums_rodata(%rip), %ymm17, %ymm17
vpandq	bums_rodata(%rip), %ymm18, %ymm18
vpandq	bums_rodata(%rip), %ymm19, %ymm19
vpandq	bums_rodata(%rip), %ymm20, %ymm20
vpandq	bums_rodata(%rip), %ymm21, %ymm21
vpandq	bums_rodata(%rip), %ymm22, %ymm22
vpaddq	%ymm0, %ymm13, %ymm13
vpaddq	%ymm1, %ymm14, %ymm14
vpaddq	%ymm2, %ymm15, %ymm15
vpaddq	%ymm23, %ymm16, %ymm16
vpaddq	%ymm24, %ymm17, %ymm17
vpaddq	%ymm25, %ymm18, %ymm18
vpaddq	%ymm26, %ymm19, %ymm19
vpaddq	%ymm27, %ymm20, %ymm20
vpaddq	%ymm28, %ymm21, %ymm21
vpaddq	%ymm29, %ymm22, %ymm22
vpcmpnleuq	bums_rodata(%rip), %ymm13, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm14, %k2
kmovb	%k1, %r14d
kmovb	%k2, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpnleuq	bums_rodata(%rip), %ymm15, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm16, %k2
kmovb	%k1, %r13d
kmovb	%k2, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpnleuq	bums_rodata(%rip), %ymm17, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm18, %k2
kmovb	%k1, %r12d
kmovb	%k2, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpnleuq	bums_rodata(%rip), %ymm19, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm20, %k2
kmovb	%k1, %r11d
kmovb	%k2, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
vpcmpnleuq	bums_rodata(%rip), %ymm21, %k1
vpcmpnleuq	bums_rodata(%rip), %ymm22, %k2
kmovb	%k1, %r10d
kmovb	%k2, %r9d
shlb	$0x4, %r9b
orb	%r9b, %r10b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
adcb	%r10b, %r10b
vpcmpequq	bums_rodata(%rip), %ymm13, %k1
vpcmpequq	bums_rodata(%rip), %ymm14, %k2
kmovb	%k1, %r9d
kmovb	%k2, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpequq	bums_rodata(%rip), %ymm15, %k1
vpcmpequq	bums_rodata(%rip), %ymm16, %k2
kmovb	%k1, %r8d
kmovb	%k2, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpequq	bums_rodata(%rip), %ymm17, %k1
vpcmpequq	bums_rodata(%rip), %ymm18, %k2
kmovb	%k1, %edx
kmovb	%k2, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpequq	bums_rodata(%rip), %ymm19, %k1
vpcmpequq	bums_rodata(%rip), %ymm20, %k2
kmovb	%k1, %ecx
kmovb	%k2, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
vpcmpequq	bums_rodata(%rip), %ymm21, %k1
vpcmpequq	bums_rodata(%rip), %ymm22, %k2
kmovb	%k1, %ebx
kmovb	%k2, %eax
shlb	$0x4, %al
orb	%al, %bl
addb	%r9b, %r14b
adcb	%r8b, %r13b
adcb	%dl, %r12b
adcb	%cl, %r11b
adcb	%bl, %r10b
xorb	%r9b, %r14b
xorb	%r8b, %r13b
xorb	%dl, %r12b
xorb	%cl, %r11b
xorb	%bl, %r10b
kmovb	%r14d, %k1
shrb	$0x4, %r14b
kmovb	%r14d, %k2
kmovb	%r13d, %k3
shrb	$0x4, %r13b
kmovb	%r13d, %k4
kmovb	%r12d, %k5
shrb	$0x4, %r12b
kmovb	%r12d, %k6
kmovb	%r11d, %k7
vpsubq	bums_rodata(%rip), %ymm13, %ymm13 {%k1}
vpsubq	bums_rodata(%rip), %ymm14, %ymm14 {%k2}
vpsubq	bums_rodata(%rip), %ymm15, %ymm15 {%k3}
vpsubq	bums_rodata(%rip), %ymm16, %ymm16 {%k4}
vpsubq	bums_rodata(%rip), %ymm17, %ymm17 {%k5}
vpsubq	bums_rodata(%rip), %ymm18, %ymm18 {%k6}
vpsubq	bums_rodata(%rip), %ymm19, %ymm19 {%k7}
vpandq	bums_rodata(%rip), %ymm13, %ymm13
vpandq	bums_rodata(%rip), %ymm14, %ymm14
vpandq	bums_rodata(%rip), %ymm15, %ymm15
vpandq	bums_rodata(%rip), %ymm16, %ymm16
vpandq	bums_rodata(%rip), %ymm17, %ymm17
vpandq	bums_rodata(%rip), %ymm18, %ymm18
vpandq	bums_rodata(%rip), %ymm19, %ymm19
shrb	$0x4, %r11b
kmovb	%r11d, %k1
kmovb	%r10d, %k2
shrb	$0x4, %r10b
kmovb	%r10d, %k3
vpsubq	bums_rodata(%rip), %ymm20, %ymm20 {%k1}
vpsubq	bums_rodata(%rip), %ymm21, %ymm21 {%k2}
vpsubq	bums_rodata(%rip), %ymm22, %ymm22 {%k3}
vpandq	bums_rodata(%rip), %ymm20, %ymm20
vpandq	bums_rodata(%rip), %ymm21, %ymm21
vpandq	bums_rodata(%rip), %ymm22, %ymm22
vmovdqu64	%ymm3, (%rdi)
vmovdqu64	%ymm4, 0x20(%rdi)
vmovdqu64	%ymm5, 0x40(%rdi)
vmovdqu64	%ymm6, 0x60(%rdi)
vmovdqu64	%ymm7, 0x80(%rdi)
vmovdqu64	%ymm8, 0xa0(%rdi)
vmovdqu64	%ymm9, 0xc0(%rdi)
vmovdqu64	%ymm10, 0xe0(%rdi)
vmovdqu64	%ymm11, 0x100(%rdi)
vmovdqu64	%ymm12, 0x120(%rdi)
vmovdqu64	%ymm13, 0x140(%rdi)
vmovdqu64	%ymm14, 0x160(%rdi)
vmovdqu64	%ymm15, 0x180(%rdi)
vmovdqu64	%ymm16, 0x1a0(%rdi)
vmovdqu64	%ymm17, 0x1c0(%rdi)
vmovdqu64	%ymm18, 0x1e0(%rdi)
vmovdqu64	%ymm19, 0x200(%rdi)
vmovdqu64	%ymm20, 0x220(%rdi)
vmovdqu64	%ymm21, 0x240(%rdi)
vmovdqu64	%ymm22, 0x260(%rdi)
vzeroupper
leaq	(%rsp), %rax
movq	(%rax), %r15
movq	0x8(%rax), %r14
movq	0x10(%rax), %r13
movq	0x18(%rax), %r12
movq	0x20(%rax), %rbp
movq	0x28(%rax), %rbx
leaq	0x30(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
ossl_extract_multiplier_2x40_win5:
endbr64
vmovdqa64	bums_rodata+32(%rip), %ymm24
vpbroadcastq	%rdx, %ymm22
vpbroadcastq	%rcx, %ymm23
leaq	0x5000(%rsi), %rax
movq	%rsi, %r10
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa64	%ymm0, %ymm1
vmovdqa64	%ymm0, %ymm2
vmovdqa64	%ymm0, %ymm3
vmovdqa64	%ymm0, %ymm4
vmovdqa64	%ymm0, %ymm5
vmovdqa64	%ymm0, %ymm16
vmovdqa64	%ymm0, %ymm17
vmovdqa64	%ymm0, %ymm18
vmovdqa64	%ymm0, %ymm19
vpxorq	%ymm21, %ymm21, %ymm21
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_18a0:
vpcmpeqq	%ymm21, %ymm22, %k1
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
vpblendmq	%ymm20, %ymm5, %ymm5 {%k1}
vmovdqu64	0xc0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm16, %ymm16 {%k1}
vmovdqu64	0xe0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm17, %ymm17 {%k1}
vmovdqu64	0x100(%rsi), %ymm20
vpblendmq	%ymm20, %ymm18, %ymm18 {%k1}
vmovdqu64	0x120(%rsi), %ymm20
vpblendmq	%ymm20, %ymm19, %ymm19 {%k1}
vpaddq	%ymm24, %ymm21, %ymm21
addq	$0x280, %rsi
cmpq	%rsi, %rax
jne	L_18a0
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
movq	%r10, %rsi
vpxorq	%ymm21, %ymm21, %ymm21
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
L_19a0:
vpcmpeqq	%ymm21, %ymm23, %k1
vmovdqu64	0x140(%rsi), %ymm20
vpblendmq	%ymm20, %ymm0, %ymm0 {%k1}
vmovdqu64	0x160(%rsi), %ymm20
vpblendmq	%ymm20, %ymm1, %ymm1 {%k1}
vmovdqu64	0x180(%rsi), %ymm20
vpblendmq	%ymm20, %ymm2, %ymm2 {%k1}
vmovdqu64	0x1a0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm3, %ymm3 {%k1}
vmovdqu64	0x1c0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm4, %ymm4 {%k1}
vmovdqu64	0x1e0(%rsi), %ymm20
vpblendmq	%ymm20, %ymm5, %ymm5 {%k1}
vmovdqu64	0x200(%rsi), %ymm20
vpblendmq	%ymm20, %ymm16, %ymm16 {%k1}
vmovdqu64	0x220(%rsi), %ymm20
vpblendmq	%ymm20, %ymm17, %ymm17 {%k1}
vmovdqu64	0x240(%rsi), %ymm20
vpblendmq	%ymm20, %ymm18, %ymm18 {%k1}
vmovdqu64	0x260(%rsi), %ymm20
vpblendmq	%ymm20, %ymm19, %ymm19 {%k1}
vpaddq	%ymm24, %ymm21, %ymm21
addq	$0x280, %rsi
cmpq	%rsi, %rax
jne	L_19a0
vmovdqu64	%ymm0, 0x140(%rdi)
vmovdqu64	%ymm1, 0x160(%rdi)
vmovdqu64	%ymm2, 0x180(%rdi)
vmovdqu64	%ymm3, 0x1a0(%rdi)
vmovdqu64	%ymm4, 0x1c0(%rdi)
vmovdqu64	%ymm5, 0x1e0(%rdi)
vmovdqu64	%ymm16, 0x200(%rdi)
vmovdqu64	%ymm17, 0x220(%rdi)
vmovdqu64	%ymm18, 0x240(%rdi)
vmovdqu64	%ymm19, 0x260(%rdi)
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

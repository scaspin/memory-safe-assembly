	.text
ossl_rsaz_avxifma_eligible:
movl	OPENSSL_ia32cap_P+20(%rip), %ecx
xorl	%eax, %eax
andl	$0x800000, %ecx
cmpl	$0x800000, %ecx
cmovel	%ecx, %eax
rep	retq
nopl	(%rax)
ossl_rsaz_amm52x20_x1_avxifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxor	%ymm0, %ymm0, %ymm0
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x5, %ebx
nopl	(%rax,%rax)
L_60:
movq	(%r11), %r13
vpbroadcastq	(%r11), %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0xa8(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm8
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm5, 0x20(%rsp)
vmovdqu	%ymm6, 0x40(%rsp)
vmovdqu	%ymm7, 0x60(%rsp)
vmovdqu	%ymm8, 0x80(%rsp)
movq	$0x0, 0xa0(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm5
vmovdqu	0x48(%rsp), %ymm6
vmovdqu	0x68(%rsp), %ymm7
vmovdqu	0x88(%rsp), %ymm8
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm8
leaq	0xa8(%rsp), %rsp
movq	0x8(%r11), %r13
vpbroadcastq	0x8(%r11), %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0xa8(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm8
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm5, 0x20(%rsp)
vmovdqu	%ymm6, 0x40(%rsp)
vmovdqu	%ymm7, 0x60(%rsp)
vmovdqu	%ymm8, 0x80(%rsp)
movq	$0x0, 0xa0(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm5
vmovdqu	0x48(%rsp), %ymm6
vmovdqu	0x68(%rsp), %ymm7
vmovdqu	0x88(%rsp), %ymm8
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm8
leaq	0xa8(%rsp), %rsp
movq	0x10(%r11), %r13
vpbroadcastq	0x10(%r11), %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0xa8(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm8
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm5, 0x20(%rsp)
vmovdqu	%ymm6, 0x40(%rsp)
vmovdqu	%ymm7, 0x60(%rsp)
vmovdqu	%ymm8, 0x80(%rsp)
movq	$0x0, 0xa0(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm5
vmovdqu	0x48(%rsp), %ymm6
vmovdqu	0x68(%rsp), %ymm7
vmovdqu	0x88(%rsp), %ymm8
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm8
leaq	0xa8(%rsp), %rsp
movq	0x18(%r11), %r13
vpbroadcastq	0x18(%r11), %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	%r8, %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0xa8(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm8
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm5, 0x20(%rsp)
vmovdqu	%ymm6, 0x40(%rsp)
vmovdqu	%ymm7, 0x60(%rsp)
vmovdqu	%ymm8, 0x80(%rsp)
movq	$0x0, 0xa0(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm5
vmovdqu	0x48(%rsp), %ymm6
vmovdqu	0x68(%rsp), %ymm7
vmovdqu	0x88(%rsp), %ymm8
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm8
leaq	0xa8(%rsp), %rsp
leaq	0x20(%r11), %r11
decl	%ebx
jne	L_60
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm5, %ymm1
vpsrlq	$0x34, %ymm6, %ymm2
vpsrlq	$0x34, %ymm7, %ymm13
vpsrlq	$0x34, %ymm8, %ymm14
vpermq	$0x90, %ymm14, %ymm14
vpermq	$0x3, %ymm13, %ymm15
vblendpd	$0x1, %ymm15, %ymm14, %ymm14
vpermq	$0x90, %ymm13, %ymm13
vpermq	$0x3, %ymm2, %ymm15
vblendpd	$0x1, %ymm15, %ymm13, %ymm13
vpermq	$0x90, %ymm2, %ymm2
vpermq	$0x3, %ymm1, %ymm15
vblendpd	$0x1, %ymm15, %ymm2, %ymm2
vpermq	$0x90, %ymm1, %ymm1
vpermq	$0x3, %ymm0, %ymm15
vblendpd	$0x1, %ymm15, %ymm1, %ymm1
vpermq	$0x90, %ymm0, %ymm0
vpand	bums_rodata+32(%rip), %ymm0, %ymm0
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm5, %ymm5
vpaddq	%ymm2, %ymm6, %ymm6
vpaddq	%ymm7, %ymm13, %ymm7
vpaddq	%ymm14, %ymm8, %ymm8
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm1
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm2
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm13
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm14
vmovmskpd	%ymm0, %r14d
vmovmskpd	%ymm1, %r13d
vmovmskpd	%ymm2, %r12d
vmovmskpd	%ymm13, %r11d
vmovmskpd	%ymm14, %r10d
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm1
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm2
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm13
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm14
vmovmskpd	%ymm0, %r9d
vmovmskpd	%ymm1, %r8d
vmovmskpd	%ymm2, %ebx
vmovmskpd	%ymm13, %ecx
vmovmskpd	%ymm14, %edx
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
leaq	bums_rodata+64(%rip), %rdx
movb	%r14b, %r13b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm0
shlq	$0x5, %r14
vmovapd	(%rdx,%r14), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm3, %ymm3
shrb	$0x4, %r13b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm0
shlq	$0x5, %r13
vmovapd	(%rdx,%r13), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm5, %ymm5
movb	%r12b, %r11b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm6, %ymm0
shlq	$0x5, %r12
vmovapd	(%rdx,%r12), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm6, %ymm6
shrb	$0x4, %r11b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm7, %ymm0
shlq	$0x5, %r11
vmovapd	(%rdx,%r11), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm7, %ymm7
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm8, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vmovdqu	%ymm3, (%rdi)
vmovdqu	%ymm5, 0x20(%rdi)
vmovdqu	%ymm6, 0x40(%rdi)
vmovdqu	%ymm7, 0x60(%rdi)
vmovdqu	%ymm8, 0x80(%rdi)
vzeroupper
movq	(%rsp), %r15
movq	0x8(%rsp), %r14
movq	0x10(%rsp), %r13
movq	0x18(%rsp), %r12
movq	0x20(%rsp), %rbp
movq	0x28(%rsp), %rbx
leaq	0x30(%rsp), %rsp
rep	retq
nopl	(%rax)
ossl_rsaz_amm52x20_x2_avxifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxor	%ymm0, %ymm0, %ymm0
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm10
vmovapd	%ymm0, %ymm11
vmovapd	%ymm0, %ymm12
xorl	%r9d, %r9d
xorl	%r15d, %r15d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x14, %ebx
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_800:
movq	(%r11), %r13
vpbroadcastq	(%r11), %ymm1
movq	(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	(%r8), %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0xa8(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm8
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm5, 0x20(%rsp)
vmovdqu	%ymm6, 0x40(%rsp)
vmovdqu	%ymm7, 0x60(%rsp)
vmovdqu	%ymm8, 0x80(%rsp)
movq	$0x0, 0xa0(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm5
vmovdqu	0x48(%rsp), %ymm6
vmovdqu	0x68(%rsp), %ymm7
vmovdqu	0x88(%rsp), %ymm8
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm8
leaq	0xa8(%rsp), %rsp
movq	0xa0(%r11), %r13
vpbroadcastq	0xa0(%r11), %ymm1
movq	0xa0(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r15
movq	%r12, %r10
adcq	$0x0, %r10
movq	0x8(%r8), %r13
imulq	%r15, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	0xa0(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r15
adcq	%r12, %r10
shrq	$0x34, %r15
shlq	$0xc, %r10
orq	%r10, %r15
leaq	-0xa8(%rsp), %rsp
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
vmovdqu	%ymm4, (%rsp)
vmovdqu	%ymm9, 0x20(%rsp)
vmovdqu	%ymm10, 0x40(%rsp)
vmovdqu	%ymm11, 0x60(%rsp)
vmovdqu	%ymm12, 0x80(%rsp)
movq	$0x0, 0xa0(%rsp)
vmovdqu	0x8(%rsp), %ymm4
vmovdqu	0x28(%rsp), %ymm9
vmovdqu	0x48(%rsp), %ymm10
vmovdqu	0x68(%rsp), %ymm11
vmovdqu	0x88(%rsp), %ymm12
addq	0x8(%rsp), %r15
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0xa8(%rsp), %rsp
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_800
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm5, %ymm1
vpsrlq	$0x34, %ymm6, %ymm2
vpsrlq	$0x34, %ymm7, %ymm13
vpsrlq	$0x34, %ymm8, %ymm14
vpermq	$0x90, %ymm14, %ymm14
vpermq	$0x3, %ymm13, %ymm15
vblendpd	$0x1, %ymm15, %ymm14, %ymm14
vpermq	$0x90, %ymm13, %ymm13
vpermq	$0x3, %ymm2, %ymm15
vblendpd	$0x1, %ymm15, %ymm13, %ymm13
vpermq	$0x90, %ymm2, %ymm2
vpermq	$0x3, %ymm1, %ymm15
vblendpd	$0x1, %ymm15, %ymm2, %ymm2
vpermq	$0x90, %ymm1, %ymm1
vpermq	$0x3, %ymm0, %ymm15
vblendpd	$0x1, %ymm15, %ymm1, %ymm1
vpermq	$0x90, %ymm0, %ymm0
vpand	bums_rodata+32(%rip), %ymm0, %ymm0
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm5, %ymm5
vpaddq	%ymm2, %ymm6, %ymm6
vpaddq	%ymm7, %ymm13, %ymm7
vpaddq	%ymm14, %ymm8, %ymm8
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm1
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm2
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm13
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm14
vmovmskpd	%ymm0, %r14d
vmovmskpd	%ymm1, %r13d
vmovmskpd	%ymm2, %r12d
vmovmskpd	%ymm13, %r11d
vmovmskpd	%ymm14, %r10d
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm1
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm2
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm13
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm14
vmovmskpd	%ymm0, %r9d
vmovmskpd	%ymm1, %r8d
vmovmskpd	%ymm2, %ebx
vmovmskpd	%ymm13, %ecx
vmovmskpd	%ymm14, %edx
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
leaq	bums_rodata+64(%rip), %rdx
movb	%r14b, %r13b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm0
shlq	$0x5, %r14
vmovapd	(%rdx,%r14), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm3, %ymm3
shrb	$0x4, %r13b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm0
shlq	$0x5, %r13
vmovapd	(%rdx,%r13), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm5, %ymm5
movb	%r12b, %r11b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm6, %ymm0
shlq	$0x5, %r12
vmovapd	(%rdx,%r12), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm6, %ymm6
shrb	$0x4, %r11b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm7, %ymm0
shlq	$0x5, %r11
vmovapd	(%rdx,%r11), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm7, %ymm7
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm8, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vmovq	%r15, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm4, %ymm4
vpsrlq	$0x34, %ymm4, %ymm0
vpsrlq	$0x34, %ymm9, %ymm1
vpsrlq	$0x34, %ymm10, %ymm2
vpsrlq	$0x34, %ymm11, %ymm13
vpsrlq	$0x34, %ymm12, %ymm14
vpermq	$0x90, %ymm14, %ymm14
vpermq	$0x3, %ymm13, %ymm15
vblendpd	$0x1, %ymm15, %ymm14, %ymm14
vpermq	$0x90, %ymm13, %ymm13
vpermq	$0x3, %ymm2, %ymm15
vblendpd	$0x1, %ymm15, %ymm13, %ymm13
vpermq	$0x90, %ymm2, %ymm2
vpermq	$0x3, %ymm1, %ymm15
vblendpd	$0x1, %ymm15, %ymm2, %ymm2
vpermq	$0x90, %ymm1, %ymm1
vpermq	$0x3, %ymm0, %ymm15
vblendpd	$0x1, %ymm15, %ymm1, %ymm1
vpermq	$0x90, %ymm0, %ymm0
vpand	bums_rodata+32(%rip), %ymm0, %ymm0
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vpaddq	%ymm0, %ymm4, %ymm4
vpaddq	%ymm1, %ymm9, %ymm9
vpaddq	%ymm2, %ymm10, %ymm10
vpaddq	%ymm13, %ymm11, %ymm11
vpaddq	%ymm14, %ymm12, %ymm12
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm0
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm1
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm2
vpcmpgtq	bums_rodata(%rip), %ymm11, %ymm13
vpcmpgtq	bums_rodata(%rip), %ymm12, %ymm14
vmovmskpd	%ymm0, %r14d
vmovmskpd	%ymm1, %r13d
vmovmskpd	%ymm2, %r12d
vmovmskpd	%ymm13, %r11d
vmovmskpd	%ymm14, %r10d
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm0
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm1
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm2
vpcmpeqq	bums_rodata(%rip), %ymm11, %ymm13
vpcmpeqq	bums_rodata(%rip), %ymm12, %ymm14
vmovmskpd	%ymm0, %r9d
vmovmskpd	%ymm1, %r8d
vmovmskpd	%ymm2, %ebx
vmovmskpd	%ymm13, %ecx
vmovmskpd	%ymm14, %edx
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
leaq	bums_rodata+64(%rip), %rdx
movb	%r14b, %r13b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm4, %ymm0
shlq	$0x5, %r14
vmovapd	(%rdx,%r14), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm4, %ymm4
shrb	$0x4, %r13b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm9, %ymm0
shlq	$0x5, %r13
vmovapd	(%rdx,%r13), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm9, %ymm9
movb	%r12b, %r11b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm10, %ymm0
shlq	$0x5, %r12
vmovapd	(%rdx,%r12), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm10, %ymm10
shrb	$0x4, %r11b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm11, %ymm0
shlq	$0x5, %r11
vmovapd	(%rdx,%r11), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm11, %ymm11
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm12, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm12, %ymm12
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vmovdqu	%ymm3, (%rdi)
vmovdqu	%ymm5, 0x20(%rdi)
vmovdqu	%ymm6, 0x40(%rdi)
vmovdqu	%ymm7, 0x60(%rdi)
vmovdqu	%ymm8, 0x80(%rdi)
vmovdqu	%ymm4, 0xa0(%rdi)
vmovdqu	%ymm9, 0xc0(%rdi)
vmovdqu	%ymm10, 0xe0(%rdi)
vmovdqu	%ymm11, 0x100(%rdi)
vmovdqu	%ymm12, 0x120(%rdi)
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
nopl	(%rax)
ossl_extract_multiplier_2x20_win5_avx:
endbr64
vmovapd	bums_rodata+576(%rip), %ymm14
vmovq	%rdx, %xmm10
vpbroadcastq	%xmm10, %ymm12
vmovq	%rcx, %xmm10
vpbroadcastq	%xmm10, %ymm13
leaq	0x2800(%rsi), %rax
vpxor	%xmm0, %xmm0, %xmm0
vmovapd	%ymm0, %ymm11
vmovapd	%ymm0, %ymm1
vmovapd	%ymm0, %ymm2
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm9
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1000:
vpcmpeqq	%ymm11, %ymm12, %ymm15
vmovdqu	(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm0, %ymm0
vmovdqu	0x20(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm1, %ymm1
vmovdqu	0x40(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm2, %ymm2
vmovdqu	0x60(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm3, %ymm3
vmovdqu	0x80(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm4, %ymm4
vpcmpeqq	%ymm11, %ymm13, %ymm15
vmovdqu	0xa0(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm5, %ymm5
vmovdqu	0xc0(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm6, %ymm6
vmovdqu	0xe0(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm7, %ymm7
vmovdqu	0x100(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm8, %ymm8
vmovdqu	0x120(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm9, %ymm9
vpaddq	%ymm14, %ymm11, %ymm11
addq	$0x140, %rsi
cmpq	%rsi, %rax
jne	L_1000
vmovdqu	%ymm0, (%rdi)
vmovdqu	%ymm1, 0x20(%rdi)
vmovdqu	%ymm2, 0x40(%rdi)
vmovdqu	%ymm3, 0x60(%rdi)
vmovdqu	%ymm4, 0x80(%rdi)
vmovdqu	%ymm5, 0xa0(%rdi)
vmovdqu	%ymm6, 0xc0(%rdi)
vmovdqu	%ymm7, 0xe0(%rdi)
vmovdqu	%ymm8, 0x100(%rdi)
vmovdqu	%ymm9, 0x120(%rdi)
vzeroupper
rep	retq
	.section .rodata
	.p2align 5
bums_rodata:
	.byte 255,255,255,255,255,255,15,0,255,255,255,255,255,255,15,0
	.byte 255,255,255,255,255,255,15,0,255,255,255,255,255,255,15,0
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
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

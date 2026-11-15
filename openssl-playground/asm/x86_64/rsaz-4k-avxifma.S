	.text
ossl_rsaz_amm52x40_x1_avxifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxor	%ymm0, %ymm0, %ymm0
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm10
vmovapd	%ymm0, %ymm11
vmovapd	%ymm0, %ymm12
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0xa, %ebx
nopw	%cs:(%rax,%rax)
nopl	(%rax)
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
leaq	-0x148(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
vmovdqu	%ymm11, 0x100(%rsp)
vmovdqu	%ymm12, 0x120(%rsp)
movq	$0x0, 0x140(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
vmovdqu	0x108(%rsp), %ymm11
vmovdqu	0x128(%rsp), %ymm12
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0x148(%rsp), %rsp
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
leaq	-0x148(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
vmovdqu	%ymm11, 0x100(%rsp)
vmovdqu	%ymm12, 0x120(%rsp)
movq	$0x0, 0x140(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
vmovdqu	0x108(%rsp), %ymm11
vmovdqu	0x128(%rsp), %ymm12
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0x148(%rsp), %rsp
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
leaq	-0x148(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
vmovdqu	%ymm11, 0x100(%rsp)
vmovdqu	%ymm12, 0x120(%rsp)
movq	$0x0, 0x140(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
vmovdqu	0x108(%rsp), %ymm11
vmovdqu	0x128(%rsp), %ymm12
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0x148(%rsp), %rsp
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
leaq	-0x148(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
vmovdqu	%ymm11, 0x100(%rsp)
vmovdqu	%ymm12, 0x120(%rsp)
movq	$0x0, 0x140(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
vmovdqu	0x108(%rsp), %ymm11
vmovdqu	0x128(%rsp), %ymm12
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0x148(%rsp), %rsp
leaq	0x20(%r11), %r11
decl	%ebx
jne	L_60
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
leaq	-0x280(%rsp), %rsp
vmovupd	%ymm3, (%rsp)
vmovupd	%ymm4, 0x20(%rsp)
vmovupd	%ymm5, 0x40(%rsp)
vmovupd	%ymm6, 0x60(%rsp)
vmovupd	%ymm7, 0x80(%rsp)
vmovupd	%ymm8, 0xa0(%rsp)
vmovupd	%ymm9, 0xc0(%rsp)
vmovupd	%ymm10, 0xe0(%rsp)
vmovupd	%ymm11, 0x100(%rsp)
vmovupd	%ymm12, 0x120(%rsp)
vpsrlq	$0x34, %ymm3, %ymm3
vpsrlq	$0x34, %ymm4, %ymm4
vpsrlq	$0x34, %ymm5, %ymm5
vpsrlq	$0x34, %ymm6, %ymm6
vpsrlq	$0x34, %ymm7, %ymm7
vpsrlq	$0x34, %ymm8, %ymm8
vpsrlq	$0x34, %ymm9, %ymm9
vpsrlq	$0x34, %ymm10, %ymm10
vpsrlq	$0x34, %ymm11, %ymm11
vpsrlq	$0x34, %ymm12, %ymm12
vpermq	$0x90, %ymm12, %ymm12
vpermq	$0x3, %ymm11, %ymm13
vblendpd	$0x1, %ymm13, %ymm12, %ymm12
vpermq	$0x90, %ymm11, %ymm11
vpermq	$0x3, %ymm10, %ymm13
vblendpd	$0x1, %ymm13, %ymm11, %ymm11
vpermq	$0x90, %ymm10, %ymm10
vpermq	$0x3, %ymm9, %ymm13
vblendpd	$0x1, %ymm13, %ymm10, %ymm10
vpermq	$0x90, %ymm9, %ymm9
vpermq	$0x3, %ymm8, %ymm13
vblendpd	$0x1, %ymm13, %ymm9, %ymm9
vpermq	$0x90, %ymm8, %ymm8
vpermq	$0x3, %ymm7, %ymm13
vblendpd	$0x1, %ymm13, %ymm8, %ymm8
vpermq	$0x90, %ymm7, %ymm7
vpermq	$0x3, %ymm6, %ymm13
vblendpd	$0x1, %ymm13, %ymm7, %ymm7
vpermq	$0x90, %ymm6, %ymm6
vpermq	$0x3, %ymm5, %ymm13
vblendpd	$0x1, %ymm13, %ymm6, %ymm6
vpermq	$0x90, %ymm5, %ymm5
vpermq	$0x3, %ymm4, %ymm13
vblendpd	$0x1, %ymm13, %ymm5, %ymm5
vpermq	$0x90, %ymm4, %ymm4
vpermq	$0x3, %ymm3, %ymm13
vblendpd	$0x1, %ymm13, %ymm4, %ymm4
vpermq	$0x90, %ymm3, %ymm3
vpand	bums_rodata+32(%rip), %ymm3, %ymm3
vmovupd	%ymm3, 0x140(%rsp)
vmovupd	%ymm4, 0x160(%rsp)
vmovupd	%ymm5, 0x180(%rsp)
vmovupd	%ymm6, 0x1a0(%rsp)
vmovupd	%ymm7, 0x1c0(%rsp)
vmovupd	%ymm8, 0x1e0(%rsp)
vmovupd	%ymm9, 0x200(%rsp)
vmovupd	%ymm10, 0x220(%rsp)
vmovupd	%ymm11, 0x240(%rsp)
vmovupd	%ymm12, 0x260(%rsp)
vmovupd	(%rsp), %ymm3
vmovupd	0x20(%rsp), %ymm4
vmovupd	0x40(%rsp), %ymm5
vmovupd	0x60(%rsp), %ymm6
vmovupd	0x80(%rsp), %ymm7
vmovupd	0xa0(%rsp), %ymm8
vmovupd	0xc0(%rsp), %ymm9
vmovupd	0xe0(%rsp), %ymm10
vmovupd	0x100(%rsp), %ymm11
vmovupd	0x120(%rsp), %ymm12
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vpaddq	0x140(%rsp), %ymm3, %ymm3
vpaddq	0x160(%rsp), %ymm4, %ymm4
vpaddq	0x180(%rsp), %ymm5, %ymm5
vpaddq	0x1a0(%rsp), %ymm6, %ymm6
vpaddq	0x1c0(%rsp), %ymm7, %ymm7
vpaddq	0x1e0(%rsp), %ymm8, %ymm8
vpaddq	0x200(%rsp), %ymm9, %ymm9
vpaddq	0x220(%rsp), %ymm10, %ymm10
vpaddq	0x240(%rsp), %ymm11, %ymm11
vpaddq	0x260(%rsp), %ymm12, %ymm12
leaq	0x280(%rsp), %rsp
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm13
vmovmskpd	%ymm13, %r14d
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm13
vmovmskpd	%ymm13, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm13
vmovmskpd	%ymm13, %r13d
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm13
vmovmskpd	%ymm13, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm13
vmovmskpd	%ymm13, %r12d
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm13, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm13
vmovmskpd	%ymm13, %r11d
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm13
vmovmskpd	%ymm13, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
vpcmpgtq	bums_rodata(%rip), %ymm11, %ymm13
vmovmskpd	%ymm13, %r10d
vpcmpgtq	bums_rodata(%rip), %ymm12, %ymm13
vmovmskpd	%ymm13, %r9d
shlb	$0x4, %r9b
orb	%r9b, %r10b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
adcb	%r10b, %r10b
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm13
vmovmskpd	%ymm13, %r9d
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm13
vmovmskpd	%ymm13, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm13
vmovmskpd	%ymm13, %r8d
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm13
vmovmskpd	%ymm13, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm13
vmovmskpd	%ymm13, %edx
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm13, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm13
vmovmskpd	%ymm13, %ecx
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm13
vmovmskpd	%ymm13, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
vpcmpeqq	bums_rodata(%rip), %ymm11, %ymm13
vmovmskpd	%ymm13, %ebx
vpcmpeqq	bums_rodata(%rip), %ymm12, %ymm13
vmovmskpd	%ymm13, %eax
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
pushq	%r9
pushq	%r8
leaq	bums_rodata+64(%rip), %r8
movb	%r14b, %r9b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm13
shlq	$0x5, %r14
vmovapd	(%r8,%r14), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm3, %ymm3
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm4, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm4, %ymm4
movb	%r13b, %r9b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm13
shlq	$0x5, %r13
vmovapd	(%r8,%r13), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm5, %ymm5
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm6, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm6, %ymm6
movb	%r12b, %r9b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm7, %ymm13
shlq	$0x5, %r12
vmovapd	(%r8,%r12), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm7, %ymm7
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm8, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm8, %ymm8
movb	%r11b, %r9b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm9, %ymm13
shlq	$0x5, %r11
vmovapd	(%r8,%r11), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm9, %ymm9
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm10, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm10, %ymm10
movb	%r10b, %r9b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm11, %ymm13
shlq	$0x5, %r10
vmovapd	(%r8,%r10), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm11, %ymm11
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm12, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm12, %ymm12
popq	%r8
popq	%r9
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vmovdqu	%ymm3, (%rdi)
vmovdqu	%ymm4, 0x20(%rdi)
vmovdqu	%ymm5, 0x40(%rdi)
vmovdqu	%ymm6, 0x60(%rdi)
vmovdqu	%ymm7, 0x80(%rdi)
vmovdqu	%ymm8, 0xa0(%rdi)
vmovdqu	%ymm9, 0xc0(%rdi)
vmovdqu	%ymm10, 0xe0(%rdi)
vmovdqu	%ymm11, 0x100(%rdi)
vmovdqu	%ymm12, 0x120(%rdi)
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
nopl	(%rax,%rax)
ossl_rsaz_amm52x40_x2_avxifma256:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vpxor	%ymm0, %ymm0, %ymm0
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm10
vmovapd	%ymm0, %ymm11
vmovapd	%ymm0, %ymm12
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x28, %ebx
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_fe0:
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
leaq	-0x148(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm12
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
vmovdqu	%ymm11, 0x100(%rsp)
vmovdqu	%ymm12, 0x120(%rsp)
movq	$0x0, 0x140(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
vmovdqu	0x108(%rsp), %ymm11
vmovdqu	0x128(%rsp), %ymm12
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm12
leaq	0x148(%rsp), %rsp
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_fe0
pushq	%r11
pushq	%rsi
pushq	%rcx
pushq	%r8
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
leaq	-0x280(%rsp), %rsp
vmovupd	%ymm3, (%rsp)
vmovupd	%ymm4, 0x20(%rsp)
vmovupd	%ymm5, 0x40(%rsp)
vmovupd	%ymm6, 0x60(%rsp)
vmovupd	%ymm7, 0x80(%rsp)
vmovupd	%ymm8, 0xa0(%rsp)
vmovupd	%ymm9, 0xc0(%rsp)
vmovupd	%ymm10, 0xe0(%rsp)
vmovupd	%ymm11, 0x100(%rsp)
vmovupd	%ymm12, 0x120(%rsp)
vpsrlq	$0x34, %ymm3, %ymm3
vpsrlq	$0x34, %ymm4, %ymm4
vpsrlq	$0x34, %ymm5, %ymm5
vpsrlq	$0x34, %ymm6, %ymm6
vpsrlq	$0x34, %ymm7, %ymm7
vpsrlq	$0x34, %ymm8, %ymm8
vpsrlq	$0x34, %ymm9, %ymm9
vpsrlq	$0x34, %ymm10, %ymm10
vpsrlq	$0x34, %ymm11, %ymm11
vpsrlq	$0x34, %ymm12, %ymm12
vpermq	$0x90, %ymm12, %ymm12
vpermq	$0x3, %ymm11, %ymm13
vblendpd	$0x1, %ymm13, %ymm12, %ymm12
vpermq	$0x90, %ymm11, %ymm11
vpermq	$0x3, %ymm10, %ymm13
vblendpd	$0x1, %ymm13, %ymm11, %ymm11
vpermq	$0x90, %ymm10, %ymm10
vpermq	$0x3, %ymm9, %ymm13
vblendpd	$0x1, %ymm13, %ymm10, %ymm10
vpermq	$0x90, %ymm9, %ymm9
vpermq	$0x3, %ymm8, %ymm13
vblendpd	$0x1, %ymm13, %ymm9, %ymm9
vpermq	$0x90, %ymm8, %ymm8
vpermq	$0x3, %ymm7, %ymm13
vblendpd	$0x1, %ymm13, %ymm8, %ymm8
vpermq	$0x90, %ymm7, %ymm7
vpermq	$0x3, %ymm6, %ymm13
vblendpd	$0x1, %ymm13, %ymm7, %ymm7
vpermq	$0x90, %ymm6, %ymm6
vpermq	$0x3, %ymm5, %ymm13
vblendpd	$0x1, %ymm13, %ymm6, %ymm6
vpermq	$0x90, %ymm5, %ymm5
vpermq	$0x3, %ymm4, %ymm13
vblendpd	$0x1, %ymm13, %ymm5, %ymm5
vpermq	$0x90, %ymm4, %ymm4
vpermq	$0x3, %ymm3, %ymm13
vblendpd	$0x1, %ymm13, %ymm4, %ymm4
vpermq	$0x90, %ymm3, %ymm3
vpand	bums_rodata+32(%rip), %ymm3, %ymm3
vmovupd	%ymm3, 0x140(%rsp)
vmovupd	%ymm4, 0x160(%rsp)
vmovupd	%ymm5, 0x180(%rsp)
vmovupd	%ymm6, 0x1a0(%rsp)
vmovupd	%ymm7, 0x1c0(%rsp)
vmovupd	%ymm8, 0x1e0(%rsp)
vmovupd	%ymm9, 0x200(%rsp)
vmovupd	%ymm10, 0x220(%rsp)
vmovupd	%ymm11, 0x240(%rsp)
vmovupd	%ymm12, 0x260(%rsp)
vmovupd	(%rsp), %ymm3
vmovupd	0x20(%rsp), %ymm4
vmovupd	0x40(%rsp), %ymm5
vmovupd	0x60(%rsp), %ymm6
vmovupd	0x80(%rsp), %ymm7
vmovupd	0xa0(%rsp), %ymm8
vmovupd	0xc0(%rsp), %ymm9
vmovupd	0xe0(%rsp), %ymm10
vmovupd	0x100(%rsp), %ymm11
vmovupd	0x120(%rsp), %ymm12
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vpaddq	0x140(%rsp), %ymm3, %ymm3
vpaddq	0x160(%rsp), %ymm4, %ymm4
vpaddq	0x180(%rsp), %ymm5, %ymm5
vpaddq	0x1a0(%rsp), %ymm6, %ymm6
vpaddq	0x1c0(%rsp), %ymm7, %ymm7
vpaddq	0x1e0(%rsp), %ymm8, %ymm8
vpaddq	0x200(%rsp), %ymm9, %ymm9
vpaddq	0x220(%rsp), %ymm10, %ymm10
vpaddq	0x240(%rsp), %ymm11, %ymm11
vpaddq	0x260(%rsp), %ymm12, %ymm12
leaq	0x280(%rsp), %rsp
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm13
vmovmskpd	%ymm13, %r14d
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm13
vmovmskpd	%ymm13, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm13
vmovmskpd	%ymm13, %r13d
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm13
vmovmskpd	%ymm13, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm13
vmovmskpd	%ymm13, %r12d
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm13, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm13
vmovmskpd	%ymm13, %r11d
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm13
vmovmskpd	%ymm13, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
vpcmpgtq	bums_rodata(%rip), %ymm11, %ymm13
vmovmskpd	%ymm13, %r10d
vpcmpgtq	bums_rodata(%rip), %ymm12, %ymm13
vmovmskpd	%ymm13, %r9d
shlb	$0x4, %r9b
orb	%r9b, %r10b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
adcb	%r10b, %r10b
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm13
vmovmskpd	%ymm13, %r9d
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm13
vmovmskpd	%ymm13, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm13
vmovmskpd	%ymm13, %r8d
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm13
vmovmskpd	%ymm13, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm13
vmovmskpd	%ymm13, %edx
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm13, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm13
vmovmskpd	%ymm13, %ecx
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm13
vmovmskpd	%ymm13, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
vpcmpeqq	bums_rodata(%rip), %ymm11, %ymm13
vmovmskpd	%ymm13, %ebx
vpcmpeqq	bums_rodata(%rip), %ymm12, %ymm13
vmovmskpd	%ymm13, %eax
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
pushq	%r9
pushq	%r8
leaq	bums_rodata+64(%rip), %r8
movb	%r14b, %r9b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm13
shlq	$0x5, %r14
vmovapd	(%r8,%r14), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm3, %ymm3
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm4, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm4, %ymm4
movb	%r13b, %r9b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm13
shlq	$0x5, %r13
vmovapd	(%r8,%r13), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm5, %ymm5
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm6, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm6, %ymm6
movb	%r12b, %r9b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm7, %ymm13
shlq	$0x5, %r12
vmovapd	(%r8,%r12), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm7, %ymm7
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm8, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm8, %ymm8
movb	%r11b, %r9b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm9, %ymm13
shlq	$0x5, %r11
vmovapd	(%r8,%r11), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm9, %ymm9
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm10, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm10, %ymm10
movb	%r10b, %r9b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm11, %ymm13
shlq	$0x5, %r10
vmovapd	(%r8,%r10), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm11, %ymm11
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm12, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm12, %ymm12
popq	%r8
popq	%r9
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
popq	%r8
popq	%rcx
popq	%rsi
popq	%r11
vmovdqu	%ymm3, (%rdi)
vmovdqu	%ymm4, 0x20(%rdi)
vmovdqu	%ymm5, 0x40(%rdi)
vmovdqu	%ymm6, 0x60(%rdi)
vmovdqu	%ymm7, 0x80(%rdi)
vmovdqu	%ymm8, 0xa0(%rdi)
vmovdqu	%ymm9, 0xc0(%rdi)
vmovdqu	%ymm10, 0xe0(%rdi)
vmovdqu	%ymm11, 0x100(%rdi)
vmovdqu	%ymm12, 0x120(%rdi)
xorl	%r9d, %r9d
movabsq	$0xfffffffffffff, %rax
movl	$0x28, %ebx
vpxor	%ymm0, %ymm0, %ymm0
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm10
vmovapd	%ymm0, %ymm11
vmovapd	%ymm0, %ymm12
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1880:
movq	(%r11), %r13
vpbroadcastq	(%r11), %ymm1
movq	0x140(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	0x8(%r8), %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	0x140(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0x148(%rsp), %rsp
{vex}	vpmadd52luq	0x140(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x160(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x180(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x1a0(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x1c0(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x1e0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0x200(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0x220(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x240(%rsi), %ymm1, %ymm11
{vex}	vpmadd52luq	0x260(%rsi), %ymm1, %ymm12
{vex}	vpmadd52luq	0x140(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x160(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x180(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x1a0(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x1c0(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x1e0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0x200(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0x220(%rcx), %ymm2, %ymm10
{vex}	vpmadd52luq	0x240(%rcx), %ymm2, %ymm11
{vex}	vpmadd52luq	0x260(%rcx), %ymm2, %ymm12
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
vmovdqu	%ymm11, 0x100(%rsp)
vmovdqu	%ymm12, 0x120(%rsp)
movq	$0x0, 0x140(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
vmovdqu	0x108(%rsp), %ymm11
vmovdqu	0x128(%rsp), %ymm12
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	0x140(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x160(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x180(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x1a0(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x1c0(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x1e0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0x200(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0x220(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x240(%rsi), %ymm1, %ymm11
{vex}	vpmadd52huq	0x260(%rsi), %ymm1, %ymm12
{vex}	vpmadd52huq	0x140(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x160(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x180(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x1a0(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x1c0(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x1e0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0x200(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0x220(%rcx), %ymm2, %ymm10
{vex}	vpmadd52huq	0x240(%rcx), %ymm2, %ymm11
{vex}	vpmadd52huq	0x260(%rcx), %ymm2, %ymm12
leaq	0x148(%rsp), %rsp
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_1880
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
leaq	-0x280(%rsp), %rsp
vmovupd	%ymm3, (%rsp)
vmovupd	%ymm4, 0x20(%rsp)
vmovupd	%ymm5, 0x40(%rsp)
vmovupd	%ymm6, 0x60(%rsp)
vmovupd	%ymm7, 0x80(%rsp)
vmovupd	%ymm8, 0xa0(%rsp)
vmovupd	%ymm9, 0xc0(%rsp)
vmovupd	%ymm10, 0xe0(%rsp)
vmovupd	%ymm11, 0x100(%rsp)
vmovupd	%ymm12, 0x120(%rsp)
vpsrlq	$0x34, %ymm3, %ymm3
vpsrlq	$0x34, %ymm4, %ymm4
vpsrlq	$0x34, %ymm5, %ymm5
vpsrlq	$0x34, %ymm6, %ymm6
vpsrlq	$0x34, %ymm7, %ymm7
vpsrlq	$0x34, %ymm8, %ymm8
vpsrlq	$0x34, %ymm9, %ymm9
vpsrlq	$0x34, %ymm10, %ymm10
vpsrlq	$0x34, %ymm11, %ymm11
vpsrlq	$0x34, %ymm12, %ymm12
vpermq	$0x90, %ymm12, %ymm12
vpermq	$0x3, %ymm11, %ymm13
vblendpd	$0x1, %ymm13, %ymm12, %ymm12
vpermq	$0x90, %ymm11, %ymm11
vpermq	$0x3, %ymm10, %ymm13
vblendpd	$0x1, %ymm13, %ymm11, %ymm11
vpermq	$0x90, %ymm10, %ymm10
vpermq	$0x3, %ymm9, %ymm13
vblendpd	$0x1, %ymm13, %ymm10, %ymm10
vpermq	$0x90, %ymm9, %ymm9
vpermq	$0x3, %ymm8, %ymm13
vblendpd	$0x1, %ymm13, %ymm9, %ymm9
vpermq	$0x90, %ymm8, %ymm8
vpermq	$0x3, %ymm7, %ymm13
vblendpd	$0x1, %ymm13, %ymm8, %ymm8
vpermq	$0x90, %ymm7, %ymm7
vpermq	$0x3, %ymm6, %ymm13
vblendpd	$0x1, %ymm13, %ymm7, %ymm7
vpermq	$0x90, %ymm6, %ymm6
vpermq	$0x3, %ymm5, %ymm13
vblendpd	$0x1, %ymm13, %ymm6, %ymm6
vpermq	$0x90, %ymm5, %ymm5
vpermq	$0x3, %ymm4, %ymm13
vblendpd	$0x1, %ymm13, %ymm5, %ymm5
vpermq	$0x90, %ymm4, %ymm4
vpermq	$0x3, %ymm3, %ymm13
vblendpd	$0x1, %ymm13, %ymm4, %ymm4
vpermq	$0x90, %ymm3, %ymm3
vpand	bums_rodata+32(%rip), %ymm3, %ymm3
vmovupd	%ymm3, 0x140(%rsp)
vmovupd	%ymm4, 0x160(%rsp)
vmovupd	%ymm5, 0x180(%rsp)
vmovupd	%ymm6, 0x1a0(%rsp)
vmovupd	%ymm7, 0x1c0(%rsp)
vmovupd	%ymm8, 0x1e0(%rsp)
vmovupd	%ymm9, 0x200(%rsp)
vmovupd	%ymm10, 0x220(%rsp)
vmovupd	%ymm11, 0x240(%rsp)
vmovupd	%ymm12, 0x260(%rsp)
vmovupd	(%rsp), %ymm3
vmovupd	0x20(%rsp), %ymm4
vmovupd	0x40(%rsp), %ymm5
vmovupd	0x60(%rsp), %ymm6
vmovupd	0x80(%rsp), %ymm7
vmovupd	0xa0(%rsp), %ymm8
vmovupd	0xc0(%rsp), %ymm9
vmovupd	0xe0(%rsp), %ymm10
vmovupd	0x100(%rsp), %ymm11
vmovupd	0x120(%rsp), %ymm12
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vpaddq	0x140(%rsp), %ymm3, %ymm3
vpaddq	0x160(%rsp), %ymm4, %ymm4
vpaddq	0x180(%rsp), %ymm5, %ymm5
vpaddq	0x1a0(%rsp), %ymm6, %ymm6
vpaddq	0x1c0(%rsp), %ymm7, %ymm7
vpaddq	0x1e0(%rsp), %ymm8, %ymm8
vpaddq	0x200(%rsp), %ymm9, %ymm9
vpaddq	0x220(%rsp), %ymm10, %ymm10
vpaddq	0x240(%rsp), %ymm11, %ymm11
vpaddq	0x260(%rsp), %ymm12, %ymm12
leaq	0x280(%rsp), %rsp
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm13
vmovmskpd	%ymm13, %r14d
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm13
vmovmskpd	%ymm13, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm13
vmovmskpd	%ymm13, %r13d
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm13
vmovmskpd	%ymm13, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm13
vmovmskpd	%ymm13, %r12d
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm13, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm13
vmovmskpd	%ymm13, %r11d
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm13
vmovmskpd	%ymm13, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
vpcmpgtq	bums_rodata(%rip), %ymm11, %ymm13
vmovmskpd	%ymm13, %r10d
vpcmpgtq	bums_rodata(%rip), %ymm12, %ymm13
vmovmskpd	%ymm13, %r9d
shlb	$0x4, %r9b
orb	%r9b, %r10b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
adcb	%r10b, %r10b
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm13
vmovmskpd	%ymm13, %r9d
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm13
vmovmskpd	%ymm13, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm13
vmovmskpd	%ymm13, %r8d
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm13
vmovmskpd	%ymm13, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm13
vmovmskpd	%ymm13, %edx
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm13, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm13
vmovmskpd	%ymm13, %ecx
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm13
vmovmskpd	%ymm13, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
vpcmpeqq	bums_rodata(%rip), %ymm11, %ymm13
vmovmskpd	%ymm13, %ebx
vpcmpeqq	bums_rodata(%rip), %ymm12, %ymm13
vmovmskpd	%ymm13, %eax
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
pushq	%r9
pushq	%r8
leaq	bums_rodata+64(%rip), %r8
movb	%r14b, %r9b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm13
shlq	$0x5, %r14
vmovapd	(%r8,%r14), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm3, %ymm3
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm4, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm4, %ymm4
movb	%r13b, %r9b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm13
shlq	$0x5, %r13
vmovapd	(%r8,%r13), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm5, %ymm5
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm6, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm6, %ymm6
movb	%r12b, %r9b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm7, %ymm13
shlq	$0x5, %r12
vmovapd	(%r8,%r12), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm7, %ymm7
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm8, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm8, %ymm8
movb	%r11b, %r9b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm9, %ymm13
shlq	$0x5, %r11
vmovapd	(%r8,%r11), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm9, %ymm9
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm10, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm10, %ymm10
movb	%r10b, %r9b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm11, %ymm13
shlq	$0x5, %r10
vmovapd	(%r8,%r10), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm11, %ymm11
shrb	$0x4, %r9b
andq	$0xf, %r9
vpsubq	bums_rodata(%rip), %ymm12, %ymm13
shlq	$0x5, %r9
vmovapd	(%r8,%r9), %ymm14
vblendvpd	%ymm14, %ymm13, %ymm12, %ymm12
popq	%r8
popq	%r9
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm11, %ymm11
vpand	bums_rodata(%rip), %ymm12, %ymm12
vmovdqu	%ymm3, 0x140(%rdi)
vmovdqu	%ymm4, 0x160(%rdi)
vmovdqu	%ymm5, 0x180(%rdi)
vmovdqu	%ymm6, 0x1a0(%rdi)
vmovdqu	%ymm7, 0x1c0(%rdi)
vmovdqu	%ymm8, 0x1e0(%rdi)
vmovdqu	%ymm9, 0x200(%rdi)
vmovdqu	%ymm10, 0x220(%rdi)
vmovdqu	%ymm11, 0x240(%rdi)
vmovdqu	%ymm12, 0x260(%rdi)
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
nopw	(%rax,%rax)
ossl_extract_multiplier_2x40_win5_avx:
endbr64
vmovapd	bums_rodata+576(%rip), %ymm14
vmovq	%rdx, %xmm10
vpbroadcastq	%xmm10, %ymm12
vmovq	%rcx, %xmm10
vpbroadcastq	%xmm10, %ymm13
leaq	0x5000(%rsi), %rax
movq	%rsi, %r10
vpxor	%xmm0, %xmm0, %xmm0
vmovapd	%ymm0, %ymm1
vmovapd	%ymm0, %ymm2
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm9
vpxor	%ymm11, %ymm11, %ymm11
nopw	(%rax,%rax)
L_21a0:
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
addq	$0x280, %rsi
cmpq	%rsi, %rax
jne	L_21a0
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
movq	%r10, %rsi
vpxor	%ymm11, %ymm11, %ymm11
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_22a0:
vpcmpeqq	%ymm11, %ymm13, %ymm15
vmovdqu	0x140(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm0, %ymm0
vmovdqu	0x160(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm1, %ymm1
vmovdqu	0x180(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm2, %ymm2
vmovdqu	0x1a0(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm3, %ymm3
vmovdqu	0x1c0(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm4, %ymm4
vmovdqu	0x1e0(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm5, %ymm5
vmovdqu	0x200(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm6, %ymm6
vmovdqu	0x220(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm7, %ymm7
vmovdqu	0x240(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm8, %ymm8
vmovdqu	0x260(%rsi), %ymm10
vblendvpd	%ymm15, %ymm10, %ymm9, %ymm9
vpaddq	%ymm14, %ymm11, %ymm11
addq	$0x280, %rsi
cmpq	%rsi, %rax
jne	L_22a0
vmovdqu	%ymm0, 0x140(%rdi)
vmovdqu	%ymm1, 0x160(%rdi)
vmovdqu	%ymm2, 0x180(%rdi)
vmovdqu	%ymm3, 0x1a0(%rdi)
vmovdqu	%ymm4, 0x1c0(%rdi)
vmovdqu	%ymm5, 0x1e0(%rdi)
vmovdqu	%ymm6, 0x200(%rdi)
vmovdqu	%ymm7, 0x220(%rdi)
vmovdqu	%ymm8, 0x240(%rdi)
vmovdqu	%ymm9, 0x260(%rdi)
vzeroupper
rep	retq
	.section .rodata
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

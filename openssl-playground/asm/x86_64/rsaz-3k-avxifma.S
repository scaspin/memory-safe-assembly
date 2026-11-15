	.text
ossl_rsaz_amm52x30_x1_avxifma256:
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
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x7, %ebx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
leaq	0x20(%r11), %r11
decl	%ebx
jne	L_60
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm4, %ymm1
vpsrlq	$0x34, %ymm5, %ymm2
vpsrlq	$0x34, %ymm6, %ymm11
vpsrlq	$0x34, %ymm7, %ymm12
vpsrlq	$0x34, %ymm8, %ymm13
vpsrlq	$0x34, %ymm9, %ymm14
vpsrlq	$0x34, %ymm10, %ymm15
leaq	-0x20(%rsp), %rsp
vmovupd	%ymm3, (%rsp)
vpermq	$0x90, %ymm15, %ymm15
vpermq	$0x3, %ymm14, %ymm3
vblendpd	$0x1, %ymm3, %ymm15, %ymm15
vpermq	$0x90, %ymm14, %ymm14
vpermq	$0x3, %ymm13, %ymm3
vblendpd	$0x1, %ymm3, %ymm14, %ymm14
vpermq	$0x90, %ymm13, %ymm13
vpermq	$0x3, %ymm12, %ymm3
vblendpd	$0x1, %ymm3, %ymm13, %ymm13
vpermq	$0x90, %ymm12, %ymm12
vpermq	$0x3, %ymm11, %ymm3
vblendpd	$0x1, %ymm3, %ymm12, %ymm12
vpermq	$0x90, %ymm11, %ymm11
vpermq	$0x3, %ymm2, %ymm3
vblendpd	$0x1, %ymm3, %ymm11, %ymm11
vpermq	$0x90, %ymm2, %ymm2
vpermq	$0x3, %ymm1, %ymm3
vblendpd	$0x1, %ymm3, %ymm2, %ymm2
vpermq	$0x90, %ymm1, %ymm1
vpermq	$0x3, %ymm0, %ymm3
vblendpd	$0x1, %ymm3, %ymm1, %ymm1
vpermq	$0x90, %ymm0, %ymm0
vpand	bums_rodata+32(%rip), %ymm0, %ymm0
vmovupd	(%rsp), %ymm3
leaq	0x20(%rsp), %rsp
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm4, %ymm4
vpaddq	%ymm2, %ymm5, %ymm5
vpaddq	%ymm6, %ymm11, %ymm6
vpaddq	%ymm7, %ymm12, %ymm7
vpaddq	%ymm13, %ymm8, %ymm8
vpaddq	%ymm14, %ymm9, %ymm9
vpaddq	%ymm15, %ymm10, %ymm10
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm1
vmovmskpd	%ymm0, %r14d
vmovmskpd	%ymm1, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm2
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm11
vmovmskpd	%ymm2, %r13d
vmovmskpd	%ymm11, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm12
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm12, %r12d
vmovmskpd	%ymm13, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm14
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm15
vmovmskpd	%ymm14, %r11d
vmovmskpd	%ymm15, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm1
vmovmskpd	%ymm0, %r9d
vmovmskpd	%ymm1, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm2
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm11
vmovmskpd	%ymm2, %r8d
vmovmskpd	%ymm11, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm12
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm12, %edx
vmovmskpd	%ymm13, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm14
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm15
vmovmskpd	%ymm14, %ecx
vmovmskpd	%ymm15, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
addb	%r9b, %r14b
adcb	%r8b, %r13b
adcb	%dl, %r12b
adcb	%cl, %r11b
xorb	%r9b, %r14b
xorb	%r8b, %r13b
xorb	%dl, %r12b
xorb	%cl, %r11b
leaq	bums_rodata+64(%rip), %rdx
movb	%r14b, %r10b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm0
shlq	$0x5, %r14
vmovapd	(%rdx,%r14), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm3, %ymm3
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm4, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm4, %ymm4
movb	%r13b, %r10b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm0
shlq	$0x5, %r13
vmovapd	(%rdx,%r13), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm5, %ymm5
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm6, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm6, %ymm6
movb	%r12b, %r10b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm7, %ymm0
shlq	$0x5, %r12
vmovapd	(%rdx,%r12), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm7, %ymm7
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm8, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm8, %ymm8
movb	%r11b, %r10b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm9, %ymm0
shlq	$0x5, %r11
vmovapd	(%rdx,%r11), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm9, %ymm9
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm10, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vmovdqu	%ymm3, (%rdi)
vmovdqu	%ymm4, 0x20(%rdi)
vmovdqu	%ymm5, 0x40(%rdi)
vmovdqu	%ymm6, 0x60(%rdi)
vmovdqu	%ymm7, 0x80(%rdi)
vmovdqu	%ymm8, 0xa0(%rdi)
vmovdqu	%ymm9, 0xc0(%rdi)
vmovdqu	%ymm10, 0xe0(%rdi)
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
nop
ossl_rsaz_amm52x30_x2_avxifma256:
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
xorl	%r9d, %r9d
movq	%rdx, %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x1e, %ebx
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_fa0:
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
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0xe0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x20(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x40(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x60(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x80(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0xa0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0xc0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0xe0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x20(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x40(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x60(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x80(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0xa0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0xc0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0xe0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_fa0
pushq	%r11
pushq	%rsi
pushq	%rcx
pushq	%r8
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm4, %ymm1
vpsrlq	$0x34, %ymm5, %ymm2
vpsrlq	$0x34, %ymm6, %ymm11
vpsrlq	$0x34, %ymm7, %ymm12
vpsrlq	$0x34, %ymm8, %ymm13
vpsrlq	$0x34, %ymm9, %ymm14
vpsrlq	$0x34, %ymm10, %ymm15
leaq	-0x20(%rsp), %rsp
vmovupd	%ymm3, (%rsp)
vpermq	$0x90, %ymm15, %ymm15
vpermq	$0x3, %ymm14, %ymm3
vblendpd	$0x1, %ymm3, %ymm15, %ymm15
vpermq	$0x90, %ymm14, %ymm14
vpermq	$0x3, %ymm13, %ymm3
vblendpd	$0x1, %ymm3, %ymm14, %ymm14
vpermq	$0x90, %ymm13, %ymm13
vpermq	$0x3, %ymm12, %ymm3
vblendpd	$0x1, %ymm3, %ymm13, %ymm13
vpermq	$0x90, %ymm12, %ymm12
vpermq	$0x3, %ymm11, %ymm3
vblendpd	$0x1, %ymm3, %ymm12, %ymm12
vpermq	$0x90, %ymm11, %ymm11
vpermq	$0x3, %ymm2, %ymm3
vblendpd	$0x1, %ymm3, %ymm11, %ymm11
vpermq	$0x90, %ymm2, %ymm2
vpermq	$0x3, %ymm1, %ymm3
vblendpd	$0x1, %ymm3, %ymm2, %ymm2
vpermq	$0x90, %ymm1, %ymm1
vpermq	$0x3, %ymm0, %ymm3
vblendpd	$0x1, %ymm3, %ymm1, %ymm1
vpermq	$0x90, %ymm0, %ymm0
vpand	bums_rodata+32(%rip), %ymm0, %ymm0
vmovupd	(%rsp), %ymm3
leaq	0x20(%rsp), %rsp
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm4, %ymm4
vpaddq	%ymm2, %ymm5, %ymm5
vpaddq	%ymm6, %ymm11, %ymm6
vpaddq	%ymm7, %ymm12, %ymm7
vpaddq	%ymm13, %ymm8, %ymm8
vpaddq	%ymm14, %ymm9, %ymm9
vpaddq	%ymm15, %ymm10, %ymm10
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm1
vmovmskpd	%ymm0, %r14d
vmovmskpd	%ymm1, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm2
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm11
vmovmskpd	%ymm2, %r13d
vmovmskpd	%ymm11, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm12
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm12, %r12d
vmovmskpd	%ymm13, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm14
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm15
vmovmskpd	%ymm14, %r11d
vmovmskpd	%ymm15, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm1
vmovmskpd	%ymm0, %r9d
vmovmskpd	%ymm1, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm2
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm11
vmovmskpd	%ymm2, %r8d
vmovmskpd	%ymm11, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm12
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm12, %edx
vmovmskpd	%ymm13, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm14
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm15
vmovmskpd	%ymm14, %ecx
vmovmskpd	%ymm15, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
addb	%r9b, %r14b
adcb	%r8b, %r13b
adcb	%dl, %r12b
adcb	%cl, %r11b
xorb	%r9b, %r14b
xorb	%r8b, %r13b
xorb	%dl, %r12b
xorb	%cl, %r11b
leaq	bums_rodata+64(%rip), %rdx
movb	%r14b, %r10b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm0
shlq	$0x5, %r14
vmovapd	(%rdx,%r14), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm3, %ymm3
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm4, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm4, %ymm4
movb	%r13b, %r10b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm0
shlq	$0x5, %r13
vmovapd	(%rdx,%r13), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm5, %ymm5
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm6, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm6, %ymm6
movb	%r12b, %r10b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm7, %ymm0
shlq	$0x5, %r12
vmovapd	(%rdx,%r12), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm7, %ymm7
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm8, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm8, %ymm8
movb	%r11b, %r10b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm9, %ymm0
shlq	$0x5, %r11
vmovapd	(%rdx,%r11), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm9, %ymm9
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm10, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
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
xorl	%r9d, %r9d
leaq	0x10(%r11), %r11
movabsq	$0xfffffffffffff, %rax
movl	$0x1e, %ebx
vpxor	%ymm0, %ymm0, %ymm0
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
vmovapd	%ymm0, %ymm8
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm10
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
L_15c0:
movq	(%r11), %r13
vpbroadcastq	(%r11), %ymm1
movq	0x100(%rsi), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
movq	%r12, %r10
adcq	$0x0, %r10
movq	0x8(%r8), %r13
imulq	%r9, %r13
andq	%rax, %r13
vmovq	%r13, %xmm2
vpbroadcastq	%xmm2, %ymm2
movq	0x100(%rcx), %rdx
mulxq	%r13, %r13, %r12
addq	%r13, %r9
adcq	%r12, %r10
shrq	$0x34, %r9
shlq	$0xc, %r10
orq	%r10, %r9
leaq	-0x108(%rsp), %rsp
{vex}	vpmadd52luq	0x100(%rsi), %ymm1, %ymm3
{vex}	vpmadd52luq	0x120(%rsi), %ymm1, %ymm4
{vex}	vpmadd52luq	0x140(%rsi), %ymm1, %ymm5
{vex}	vpmadd52luq	0x160(%rsi), %ymm1, %ymm6
{vex}	vpmadd52luq	0x180(%rsi), %ymm1, %ymm7
{vex}	vpmadd52luq	0x1a0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52luq	0x1c0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52luq	0x1e0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52luq	0x100(%rcx), %ymm2, %ymm3
{vex}	vpmadd52luq	0x120(%rcx), %ymm2, %ymm4
{vex}	vpmadd52luq	0x140(%rcx), %ymm2, %ymm5
{vex}	vpmadd52luq	0x160(%rcx), %ymm2, %ymm6
{vex}	vpmadd52luq	0x180(%rcx), %ymm2, %ymm7
{vex}	vpmadd52luq	0x1a0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52luq	0x1c0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52luq	0x1e0(%rcx), %ymm2, %ymm10
vmovdqu	%ymm3, (%rsp)
vmovdqu	%ymm4, 0x20(%rsp)
vmovdqu	%ymm5, 0x40(%rsp)
vmovdqu	%ymm6, 0x60(%rsp)
vmovdqu	%ymm7, 0x80(%rsp)
vmovdqu	%ymm8, 0xa0(%rsp)
vmovdqu	%ymm9, 0xc0(%rsp)
vmovdqu	%ymm10, 0xe0(%rsp)
movq	$0x0, 0x100(%rsp)
vmovdqu	0x8(%rsp), %ymm3
vmovdqu	0x28(%rsp), %ymm4
vmovdqu	0x48(%rsp), %ymm5
vmovdqu	0x68(%rsp), %ymm6
vmovdqu	0x88(%rsp), %ymm7
vmovdqu	0xa8(%rsp), %ymm8
vmovdqu	0xc8(%rsp), %ymm9
vmovdqu	0xe8(%rsp), %ymm10
addq	0x8(%rsp), %r9
{vex}	vpmadd52huq	0x100(%rsi), %ymm1, %ymm3
{vex}	vpmadd52huq	0x120(%rsi), %ymm1, %ymm4
{vex}	vpmadd52huq	0x140(%rsi), %ymm1, %ymm5
{vex}	vpmadd52huq	0x160(%rsi), %ymm1, %ymm6
{vex}	vpmadd52huq	0x180(%rsi), %ymm1, %ymm7
{vex}	vpmadd52huq	0x1a0(%rsi), %ymm1, %ymm8
{vex}	vpmadd52huq	0x1c0(%rsi), %ymm1, %ymm9
{vex}	vpmadd52huq	0x1e0(%rsi), %ymm1, %ymm10
{vex}	vpmadd52huq	0x100(%rcx), %ymm2, %ymm3
{vex}	vpmadd52huq	0x120(%rcx), %ymm2, %ymm4
{vex}	vpmadd52huq	0x140(%rcx), %ymm2, %ymm5
{vex}	vpmadd52huq	0x160(%rcx), %ymm2, %ymm6
{vex}	vpmadd52huq	0x180(%rcx), %ymm2, %ymm7
{vex}	vpmadd52huq	0x1a0(%rcx), %ymm2, %ymm8
{vex}	vpmadd52huq	0x1c0(%rcx), %ymm2, %ymm9
{vex}	vpmadd52huq	0x1e0(%rcx), %ymm2, %ymm10
leaq	0x108(%rsp), %rsp
leaq	0x8(%r11), %r11
decl	%ebx
jne	L_15c0
vmovq	%r9, %xmm0
vpbroadcastq	%xmm0, %ymm0
vpblendd	$0x3, %ymm0, %ymm3, %ymm3
vpsrlq	$0x34, %ymm3, %ymm0
vpsrlq	$0x34, %ymm4, %ymm1
vpsrlq	$0x34, %ymm5, %ymm2
vpsrlq	$0x34, %ymm6, %ymm11
vpsrlq	$0x34, %ymm7, %ymm12
vpsrlq	$0x34, %ymm8, %ymm13
vpsrlq	$0x34, %ymm9, %ymm14
vpsrlq	$0x34, %ymm10, %ymm15
leaq	-0x20(%rsp), %rsp
vmovupd	%ymm3, (%rsp)
vpermq	$0x90, %ymm15, %ymm15
vpermq	$0x3, %ymm14, %ymm3
vblendpd	$0x1, %ymm3, %ymm15, %ymm15
vpermq	$0x90, %ymm14, %ymm14
vpermq	$0x3, %ymm13, %ymm3
vblendpd	$0x1, %ymm3, %ymm14, %ymm14
vpermq	$0x90, %ymm13, %ymm13
vpermq	$0x3, %ymm12, %ymm3
vblendpd	$0x1, %ymm3, %ymm13, %ymm13
vpermq	$0x90, %ymm12, %ymm12
vpermq	$0x3, %ymm11, %ymm3
vblendpd	$0x1, %ymm3, %ymm12, %ymm12
vpermq	$0x90, %ymm11, %ymm11
vpermq	$0x3, %ymm2, %ymm3
vblendpd	$0x1, %ymm3, %ymm11, %ymm11
vpermq	$0x90, %ymm2, %ymm2
vpermq	$0x3, %ymm1, %ymm3
vblendpd	$0x1, %ymm3, %ymm2, %ymm2
vpermq	$0x90, %ymm1, %ymm1
vpermq	$0x3, %ymm0, %ymm3
vblendpd	$0x1, %ymm3, %ymm1, %ymm1
vpermq	$0x90, %ymm0, %ymm0
vpand	bums_rodata+32(%rip), %ymm0, %ymm0
vmovupd	(%rsp), %ymm3
leaq	0x20(%rsp), %rsp
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vpaddq	%ymm0, %ymm3, %ymm3
vpaddq	%ymm1, %ymm4, %ymm4
vpaddq	%ymm2, %ymm5, %ymm5
vpaddq	%ymm6, %ymm11, %ymm6
vpaddq	%ymm7, %ymm12, %ymm7
vpaddq	%ymm13, %ymm8, %ymm8
vpaddq	%ymm14, %ymm9, %ymm9
vpaddq	%ymm15, %ymm10, %ymm10
vpcmpgtq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpgtq	bums_rodata(%rip), %ymm4, %ymm1
vmovmskpd	%ymm0, %r14d
vmovmskpd	%ymm1, %r13d
shlb	$0x4, %r13b
orb	%r13b, %r14b
vpcmpgtq	bums_rodata(%rip), %ymm5, %ymm2
vpcmpgtq	bums_rodata(%rip), %ymm6, %ymm11
vmovmskpd	%ymm2, %r13d
vmovmskpd	%ymm11, %r12d
shlb	$0x4, %r12b
orb	%r12b, %r13b
vpcmpgtq	bums_rodata(%rip), %ymm7, %ymm12
vpcmpgtq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm12, %r12d
vmovmskpd	%ymm13, %r11d
shlb	$0x4, %r11b
orb	%r11b, %r12b
vpcmpgtq	bums_rodata(%rip), %ymm9, %ymm14
vpcmpgtq	bums_rodata(%rip), %ymm10, %ymm15
vmovmskpd	%ymm14, %r11d
vmovmskpd	%ymm15, %r10d
shlb	$0x4, %r10b
orb	%r10b, %r11b
addb	%r14b, %r14b
adcb	%r13b, %r13b
adcb	%r12b, %r12b
adcb	%r11b, %r11b
vpcmpeqq	bums_rodata(%rip), %ymm3, %ymm0
vpcmpeqq	bums_rodata(%rip), %ymm4, %ymm1
vmovmskpd	%ymm0, %r9d
vmovmskpd	%ymm1, %r8d
shlb	$0x4, %r8b
orb	%r8b, %r9b
vpcmpeqq	bums_rodata(%rip), %ymm5, %ymm2
vpcmpeqq	bums_rodata(%rip), %ymm6, %ymm11
vmovmskpd	%ymm2, %r8d
vmovmskpd	%ymm11, %edx
shlb	$0x4, %dl
orb	%dl, %r8b
vpcmpeqq	bums_rodata(%rip), %ymm7, %ymm12
vpcmpeqq	bums_rodata(%rip), %ymm8, %ymm13
vmovmskpd	%ymm12, %edx
vmovmskpd	%ymm13, %ecx
shlb	$0x4, %cl
orb	%cl, %dl
vpcmpeqq	bums_rodata(%rip), %ymm9, %ymm14
vpcmpeqq	bums_rodata(%rip), %ymm10, %ymm15
vmovmskpd	%ymm14, %ecx
vmovmskpd	%ymm15, %ebx
shlb	$0x4, %bl
orb	%bl, %cl
addb	%r9b, %r14b
adcb	%r8b, %r13b
adcb	%dl, %r12b
adcb	%cl, %r11b
xorb	%r9b, %r14b
xorb	%r8b, %r13b
xorb	%dl, %r12b
xorb	%cl, %r11b
leaq	bums_rodata+64(%rip), %rdx
movb	%r14b, %r10b
andq	$0xf, %r14
vpsubq	bums_rodata(%rip), %ymm3, %ymm0
shlq	$0x5, %r14
vmovapd	(%rdx,%r14), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm3, %ymm3
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm4, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm4, %ymm4
movb	%r13b, %r10b
andq	$0xf, %r13
vpsubq	bums_rodata(%rip), %ymm5, %ymm0
shlq	$0x5, %r13
vmovapd	(%rdx,%r13), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm5, %ymm5
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm6, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm6, %ymm6
movb	%r12b, %r10b
andq	$0xf, %r12
vpsubq	bums_rodata(%rip), %ymm7, %ymm0
shlq	$0x5, %r12
vmovapd	(%rdx,%r12), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm7, %ymm7
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm8, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm8, %ymm8
movb	%r11b, %r10b
andq	$0xf, %r11
vpsubq	bums_rodata(%rip), %ymm9, %ymm0
shlq	$0x5, %r11
vmovapd	(%rdx,%r11), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm9, %ymm9
shrb	$0x4, %r10b
andq	$0xf, %r10
vpsubq	bums_rodata(%rip), %ymm10, %ymm0
shlq	$0x5, %r10
vmovapd	(%rdx,%r10), %ymm2
vblendvpd	%ymm2, %ymm0, %ymm10, %ymm10
vpand	bums_rodata(%rip), %ymm3, %ymm3
vpand	bums_rodata(%rip), %ymm4, %ymm4
vpand	bums_rodata(%rip), %ymm5, %ymm5
vpand	bums_rodata(%rip), %ymm6, %ymm6
vpand	bums_rodata(%rip), %ymm7, %ymm7
vpand	bums_rodata(%rip), %ymm8, %ymm8
vpand	bums_rodata(%rip), %ymm9, %ymm9
vpand	bums_rodata(%rip), %ymm10, %ymm10
vmovdqu	%ymm3, 0x100(%rdi)
vmovdqu	%ymm4, 0x120(%rdi)
vmovdqu	%ymm5, 0x140(%rdi)
vmovdqu	%ymm6, 0x160(%rdi)
vmovdqu	%ymm7, 0x180(%rdi)
vmovdqu	%ymm8, 0x1a0(%rdi)
vmovdqu	%ymm9, 0x1c0(%rdi)
vmovdqu	%ymm10, 0x1e0(%rdi)
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
nop
ossl_extract_multiplier_2x30_win5_avx:
endbr64
vmovapd	bums_rodata+576(%rip), %ymm12
vmovq	%rdx, %xmm8
vpbroadcastq	%xmm8, %ymm10
vmovq	%rcx, %xmm8
vpbroadcastq	%xmm8, %ymm11
leaq	0x4000(%rsi), %rax
vpxor	%xmm0, %xmm0, %xmm0
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm1
vmovapd	%ymm0, %ymm2
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_1c60:
vpcmpeqq	%ymm9, %ymm10, %ymm13
vmovdqu	(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm0, %ymm0
vmovdqu	0x20(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm1, %ymm1
vmovdqu	0x40(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm2, %ymm2
vmovdqu	0x60(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm3, %ymm3
vmovdqu	0x80(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm4, %ymm4
vmovdqu	0xa0(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm5, %ymm5
vmovdqu	0xc0(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm6, %ymm6
vmovdqu	0xe0(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm7, %ymm7
vpaddq	%ymm12, %ymm9, %ymm9
addq	$0x200, %rsi
cmpq	%rsi, %rax
jne	L_1c60
vmovdqu	%ymm0, (%rdi)
vmovdqu	%ymm1, 0x20(%rdi)
vmovdqu	%ymm2, 0x40(%rdi)
vmovdqu	%ymm3, 0x60(%rdi)
vmovdqu	%ymm4, 0x80(%rdi)
vmovdqu	%ymm5, 0xa0(%rdi)
vmovdqu	%ymm6, 0xc0(%rdi)
vmovdqu	%ymm7, 0xe0(%rdi)
leaq	-0x4000(%rax), %rsi
vpxor	%xmm0, %xmm0, %xmm0
vmovapd	%ymm0, %ymm9
vmovapd	%ymm0, %ymm0
vmovapd	%ymm0, %ymm1
vmovapd	%ymm0, %ymm2
vmovapd	%ymm0, %ymm3
vmovapd	%ymm0, %ymm4
vmovapd	%ymm0, %ymm5
vmovapd	%ymm0, %ymm6
vmovapd	%ymm0, %ymm7
nopl	(%rax,%rax)
L_1d40:
vpcmpeqq	%ymm9, %ymm11, %ymm13
vmovdqu	0x100(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm0, %ymm0
vmovdqu	0x120(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm1, %ymm1
vmovdqu	0x140(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm2, %ymm2
vmovdqu	0x160(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm3, %ymm3
vmovdqu	0x180(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm4, %ymm4
vmovdqu	0x1a0(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm5, %ymm5
vmovdqu	0x1c0(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm6, %ymm6
vmovdqu	0x1e0(%rsi), %ymm8
vblendvpd	%ymm13, %ymm8, %ymm7, %ymm7
vpaddq	%ymm12, %ymm9, %ymm9
addq	$0x200, %rsi
cmpq	%rsi, %rax
jne	L_1d40
vmovdqu	%ymm0, 0x100(%rdi)
vmovdqu	%ymm1, 0x120(%rdi)
vmovdqu	%ymm2, 0x140(%rdi)
vmovdqu	%ymm3, 0x160(%rdi)
vmovdqu	%ymm4, 0x180(%rdi)
vmovdqu	%ymm5, 0x1a0(%rdi)
vmovdqu	%ymm6, 0x1c0(%rdi)
vmovdqu	%ymm7, 0x1e0(%rdi)
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

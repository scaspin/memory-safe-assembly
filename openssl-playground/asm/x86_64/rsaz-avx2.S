	.text
rsaz_1024_sqr_avx2:
leaq	(%rsp), %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
vzeroupper
movq	%rax, %rbp
movq	%rdx, %r13
subq	$0x340, %rsp
movq	%r13, %r15
subq	$-0x80, %rdi
subq	$-0x80, %rsi
subq	$-0x80, %r13
andq	$0xfff, %r15
addq	$0x140, %r15
shrq	$0xc, %r15
vpxor	%ymm9, %ymm9, %ymm9
je	L_db
subq	$0x140, %rsp
vmovdqu	-0x80(%r13), %ymm0
andq	$-0x800, %rsp
vmovdqu	-0x60(%r13), %ymm1
vmovdqu	-0x40(%r13), %ymm2
vmovdqu	-0x20(%r13), %ymm3
vmovdqu	(%r13), %ymm4
vmovdqu	0x20(%r13), %ymm5
vmovdqu	0x40(%r13), %ymm6
vmovdqu	0x60(%r13), %ymm7
vmovdqu	0x80(%r13), %ymm8
leaq	0x3c0(%rsp), %r13
vmovdqu	%ymm0, -0x80(%r13)
vmovdqu	%ymm1, -0x60(%r13)
vmovdqu	%ymm2, -0x40(%r13)
vmovdqu	%ymm3, -0x20(%r13)
vmovdqu	%ymm4, (%r13)
vmovdqu	%ymm5, 0x20(%r13)
vmovdqu	%ymm6, 0x40(%r13)
vmovdqu	%ymm7, 0x60(%r13)
vmovdqu	%ymm8, 0x80(%r13)
vmovdqu	%ymm9, 0xa0(%r13)
L_db:
andq	$-0x400, %rsp
vmovdqu	-0x60(%rsi), %ymm1
vmovdqu	-0x40(%rsi), %ymm2
vmovdqu	-0x20(%rsi), %ymm3
vmovdqu	(%rsi), %ymm4
vmovdqu	0x20(%rsi), %ymm5
vmovdqu	0x40(%rsi), %ymm6
vmovdqu	0x60(%rsi), %ymm7
vmovdqu	0x80(%rsi), %ymm8
leaq	0xc0(%rsp), %rbx
vmovdqu	bums_rodata(%rip), %ymm15
jmp	L_120
nop
L_120:
leaq	0x2c0(%rsp), %r9
leaq	0x1c0(%rsp), %r12
vpaddq	%ymm1, %ymm1, %ymm1
vpbroadcastq	-0x80(%rsi), %ymm10
vpaddq	%ymm2, %ymm2, %ymm2
vmovdqa	%ymm1, -0x80(%r9)
vpaddq	%ymm3, %ymm3, %ymm3
vmovdqa	%ymm2, -0x60(%r9)
vpaddq	%ymm4, %ymm4, %ymm4
vmovdqa	%ymm3, -0x40(%r9)
vpaddq	%ymm5, %ymm5, %ymm5
vmovdqa	%ymm4, -0x20(%r9)
vpaddq	%ymm6, %ymm6, %ymm6
vmovdqa	%ymm5, (%r9)
vpaddq	%ymm7, %ymm7, %ymm7
vmovdqa	%ymm6, 0x20(%r9)
vpaddq	%ymm8, %ymm8, %ymm8
vmovdqa	%ymm7, 0x40(%r9)
vpxor	%ymm9, %ymm9, %ymm9
vmovdqa	%ymm8, 0x60(%r9)
vpmuludq	-0x80(%rsi), %ymm10, %ymm0
vpbroadcastq	-0x60(%rsi), %ymm11
vmovdqu	%ymm9, 0x60(%rbx)
vpmuludq	%ymm1, %ymm10, %ymm1
vmovdqu	%ymm9, -0x80(%r12)
vpmuludq	%ymm2, %ymm10, %ymm2
vmovdqu	%ymm9, -0x60(%r12)
vpmuludq	%ymm3, %ymm10, %ymm3
vmovdqu	%ymm9, -0x40(%r12)
vpmuludq	%ymm4, %ymm10, %ymm4
vmovdqu	%ymm9, -0x20(%r12)
vpmuludq	%ymm5, %ymm10, %ymm5
vmovdqu	%ymm9, (%r12)
vpmuludq	%ymm6, %ymm10, %ymm6
vmovdqu	%ymm9, 0x20(%r12)
vpmuludq	%ymm7, %ymm10, %ymm7
vmovdqu	%ymm9, 0x40(%r12)
vpmuludq	%ymm10, %ymm8, %ymm8
vpbroadcastq	-0x40(%rsi), %ymm10
vmovdqu	%ymm9, 0x60(%r12)
movq	%rsi, %r15
movl	$0x4, %r14d
jmp	L_292
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_220:
vpbroadcastq	-0x60(%r15), %ymm11
vpmuludq	-0x80(%rsi), %ymm10, %ymm0
vpaddq	-0xc0(%rbx), %ymm0, %ymm0
vpmuludq	-0x80(%r9), %ymm10, %ymm1
vpaddq	-0xa0(%rbx), %ymm1, %ymm1
vpmuludq	-0x60(%r9), %ymm10, %ymm2
vpaddq	-0x80(%rbx), %ymm2, %ymm2
vpmuludq	-0x40(%r9), %ymm10, %ymm3
vpaddq	-0x60(%rbx), %ymm3, %ymm3
vpmuludq	-0x20(%r9), %ymm10, %ymm4
vpaddq	-0x40(%rbx), %ymm4, %ymm4
vpmuludq	(%r9), %ymm10, %ymm5
vpaddq	-0x20(%rbx), %ymm5, %ymm5
vpmuludq	0x20(%r9), %ymm10, %ymm6
vpaddq	(%rbx), %ymm6, %ymm6
vpmuludq	0x40(%r9), %ymm10, %ymm7
vpaddq	0x20(%rbx), %ymm7, %ymm7
vpmuludq	0x60(%r9), %ymm10, %ymm8
vpbroadcastq	-0x40(%r15), %ymm10
vpaddq	0x40(%rbx), %ymm8, %ymm8
L_292:
vmovdqu	%ymm0, -0xc0(%rbx)
vmovdqu	%ymm1, -0xa0(%rbx)
vpmuludq	-0x60(%rsi), %ymm11, %ymm12
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	-0x60(%r9), %ymm11, %ymm14
vpaddq	%ymm3, %ymm14, %ymm3
vpmuludq	-0x40(%r9), %ymm11, %ymm13
vpaddq	%ymm4, %ymm13, %ymm4
vpmuludq	-0x20(%r9), %ymm11, %ymm12
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	(%r9), %ymm11, %ymm14
vpaddq	%ymm6, %ymm14, %ymm6
vpmuludq	0x20(%r9), %ymm11, %ymm13
vpaddq	%ymm7, %ymm13, %ymm7
vpmuludq	0x40(%r9), %ymm11, %ymm12
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	0x60(%r9), %ymm11, %ymm0
vpbroadcastq	-0x20(%r15), %ymm11
vpaddq	0x60(%rbx), %ymm0, %ymm0
vmovdqu	%ymm2, -0x80(%rbx)
vmovdqu	%ymm3, -0x60(%rbx)
vpmuludq	-0x40(%rsi), %ymm10, %ymm13
vpaddq	%ymm4, %ymm13, %ymm4
vpmuludq	-0x40(%r9), %ymm10, %ymm12
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	-0x20(%r9), %ymm10, %ymm14
vpaddq	%ymm6, %ymm14, %ymm6
vpmuludq	(%r9), %ymm10, %ymm13
vpaddq	%ymm7, %ymm13, %ymm7
vpmuludq	0x20(%r9), %ymm10, %ymm12
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	0x40(%r9), %ymm10, %ymm14
vpaddq	%ymm0, %ymm14, %ymm0
vpmuludq	0x60(%r9), %ymm10, %ymm1
vpbroadcastq	(%r15), %ymm10
vpaddq	-0x80(%r12), %ymm1, %ymm1
vmovdqu	%ymm4, -0x40(%rbx)
vmovdqu	%ymm5, -0x20(%rbx)
vpmuludq	-0x20(%rsi), %ymm11, %ymm12
vpaddq	%ymm6, %ymm12, %ymm6
vpmuludq	-0x20(%r9), %ymm11, %ymm14
vpaddq	%ymm7, %ymm14, %ymm7
vpmuludq	(%r9), %ymm11, %ymm13
vpaddq	%ymm13, %ymm8, %ymm8
vpmuludq	0x20(%r9), %ymm11, %ymm12
vpaddq	%ymm0, %ymm12, %ymm0
vpmuludq	0x40(%r9), %ymm11, %ymm14
vpaddq	%ymm1, %ymm14, %ymm1
vpmuludq	0x60(%r9), %ymm11, %ymm2
vpbroadcastq	0x20(%r15), %ymm11
vpaddq	-0x60(%r12), %ymm2, %ymm2
vmovdqu	%ymm6, (%rbx)
vmovdqu	%ymm7, 0x20(%rbx)
vpmuludq	(%rsi), %ymm10, %ymm12
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	(%r9), %ymm10, %ymm14
vpaddq	%ymm0, %ymm14, %ymm0
vpmuludq	0x20(%r9), %ymm10, %ymm13
vpaddq	%ymm1, %ymm13, %ymm1
vpmuludq	0x40(%r9), %ymm10, %ymm12
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	0x60(%r9), %ymm10, %ymm3
vpbroadcastq	0x40(%r15), %ymm10
vpaddq	-0x40(%r12), %ymm3, %ymm3
vmovdqu	%ymm8, 0x40(%rbx)
vmovdqu	%ymm0, 0x60(%rbx)
leaq	0x8(%rbx), %rbx
vpmuludq	0x20(%rsi), %ymm11, %ymm13
vpaddq	%ymm1, %ymm13, %ymm1
vpmuludq	0x20(%r9), %ymm11, %ymm12
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	0x40(%r9), %ymm11, %ymm14
vpaddq	%ymm3, %ymm14, %ymm3
vpmuludq	0x60(%r9), %ymm11, %ymm4
vpbroadcastq	0x60(%r15), %ymm11
vpaddq	-0x20(%r12), %ymm4, %ymm4
vmovdqu	%ymm1, -0x80(%r12)
vmovdqu	%ymm2, -0x60(%r12)
vpmuludq	0x40(%rsi), %ymm10, %ymm12
vpaddq	%ymm3, %ymm12, %ymm3
vpmuludq	0x40(%r9), %ymm10, %ymm14
vpbroadcastq	0x80(%r15), %ymm0
vpaddq	%ymm4, %ymm14, %ymm4
vpmuludq	0x60(%r9), %ymm10, %ymm5
vpbroadcastq	-0x78(%r15), %ymm10
vpaddq	(%r12), %ymm5, %ymm5
vmovdqu	%ymm3, -0x40(%r12)
vmovdqu	%ymm4, -0x20(%r12)
leaq	0x8(%r15), %r15
vpmuludq	0x60(%rsi), %ymm11, %ymm12
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	0x60(%r9), %ymm11, %ymm6
vpaddq	0x20(%r12), %ymm6, %ymm6
vpmuludq	0x80(%rsi), %ymm0, %ymm7
vmovdqu	%ymm5, (%r12)
vpaddq	0x40(%r12), %ymm7, %ymm7
vmovdqu	%ymm6, 0x20(%r12)
vmovdqu	%ymm7, 0x40(%r12)
leaq	0x8(%r12), %r12
decl	%r14d
jne	L_220
vmovdqu	0x100(%rsp), %ymm8
vmovdqu	0x120(%rsp), %ymm1
vmovdqu	0x140(%rsp), %ymm2
leaq	0xc0(%rsp), %rbx
vpsrlq	$0x1d, %ymm8, %ymm14
vpand	%ymm15, %ymm8, %ymm8
vpsrlq	$0x1d, %ymm1, %ymm11
vpand	%ymm1, %ymm15, %ymm1
vpermq	$0x93, %ymm14, %ymm14
vpxor	%ymm9, %ymm9, %ymm9
vpermq	$0x93, %ymm11, %ymm11
vpblendd	$0x3, %ymm9, %ymm14, %ymm10
vpblendd	$0x3, %ymm14, %ymm11, %ymm14
vpaddq	%ymm10, %ymm8, %ymm8
vpblendd	$0x3, %ymm11, %ymm9, %ymm11
vpaddq	%ymm1, %ymm14, %ymm1
vpaddq	%ymm2, %ymm11, %ymm2
vmovdqu	%ymm1, 0x60(%rbx)
vmovdqu	%ymm2, 0x80(%rbx)
movq	(%rsp), %rax
movq	0x8(%rsp), %r10
movq	0x10(%rsp), %r11
movq	0x18(%rsp), %r12
vmovdqu	0x20(%rsp), %ymm1
vmovdqu	-0x80(%rbx), %ymm2
vmovdqu	-0x60(%rbx), %ymm3
vmovdqu	-0x40(%rbx), %ymm4
vmovdqu	-0x20(%rbx), %ymm5
vmovdqu	(%rbx), %ymm6
vmovdqu	0x20(%rbx), %ymm7
movq	%rax, %r9
imull	%ecx, %eax
andl	$0x1fffffff, %eax
vmovd	%eax, %xmm12
movq	%rax, %rdx
imulq	-0x80(%r13), %rax
vpbroadcastq	%xmm12, %ymm12
addq	%rax, %r9
movq	%rdx, %rax
imulq	-0x78(%r13), %rax
shrq	$0x1d, %r9
addq	%rax, %r10
movq	%rdx, %rax
imulq	-0x70(%r13), %rax
addq	%r9, %r10
addq	%rax, %r11
imulq	-0x68(%r13), %rdx
addq	%rdx, %r12
movq	%r10, %rax
imull	%ecx, %eax
andl	$0x1fffffff, %eax
movl	$0x9, %r14d
jmp	L_5c0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_5c0:
vmovd	%eax, %xmm13
vpbroadcastq	%xmm13, %ymm13
vpmuludq	-0x60(%r13), %ymm12, %ymm10
movq	%rax, %rdx
imulq	-0x80(%r13), %rax
vpaddq	%ymm1, %ymm10, %ymm1
addq	%rax, %r10
vpmuludq	-0x40(%r13), %ymm12, %ymm14
movq	%rdx, %rax
imulq	-0x78(%r13), %rax
vpaddq	%ymm2, %ymm14, %ymm2
vpmuludq	-0x20(%r13), %ymm12, %ymm11
addr32	addq	%rax, %r11
addr32	movq	%rdx, %rax
imulq	-0x70(%r13), %rax
shrq	$0x1d, %r10
vpaddq	%ymm3, %ymm11, %ymm3
vpmuludq	(%r13), %ymm12, %ymm10
addq	%rax, %r12
addq	%r10, %r11
vpaddq	%ymm4, %ymm10, %ymm4
vpmuludq	0x20(%r13), %ymm12, %ymm14
movq	%r11, %rax
imull	%ecx, %eax
vpaddq	%ymm5, %ymm14, %ymm5
vpmuludq	0x40(%r13), %ymm12, %ymm11
andl	$0x1fffffff, %eax
vpaddq	%ymm6, %ymm11, %ymm6
vpmuludq	0x60(%r13), %ymm12, %ymm10
vpaddq	%ymm7, %ymm10, %ymm7
vpmuludq	0x80(%r13), %ymm12, %ymm14
vmovd	%eax, %xmm12
vpaddq	%ymm14, %ymm8, %ymm8
vpbroadcastq	%xmm12, %ymm12
vpmuludq	-0x68(%r13), %ymm13, %ymm11
vmovdqu	-0x28(%r13), %ymm14
movq	%rax, %rdx
imulq	-0x80(%r13), %rax
vpaddq	%ymm1, %ymm11, %ymm1
vpmuludq	-0x48(%r13), %ymm13, %ymm10
vmovdqu	-0x8(%r13), %ymm11
addq	%rax, %r11
movq	%rdx, %rax
imulq	-0x78(%r13), %rax
vpaddq	%ymm2, %ymm10, %ymm2
addq	%r12, %rax
shrq	$0x1d, %r11
vpmuludq	%ymm13, %ymm14, %ymm14
vmovdqu	0x18(%r13), %ymm10
addq	%r11, %rax
vpaddq	%ymm3, %ymm14, %ymm3
vpmuludq	%ymm13, %ymm11, %ymm11
vmovdqu	0x38(%r13), %ymm14
addr32	movq	%rax, %r12
imull	%ecx, %eax
vpaddq	%ymm4, %ymm11, %ymm4
vpmuludq	%ymm13, %ymm10, %ymm10
vmovdqu	0x58(%r13), %ymm11
andl	$0x1fffffff, %eax
vpaddq	%ymm5, %ymm10, %ymm5
vpmuludq	%ymm13, %ymm14, %ymm14
vmovdqu	0x78(%r13), %ymm10
vpaddq	%ymm6, %ymm14, %ymm6
vpmuludq	%ymm13, %ymm11, %ymm11
vmovdqu	0x98(%r13), %ymm9
vmovd	%eax, %xmm0
imulq	-0x80(%r13), %rax
vpaddq	%ymm7, %ymm11, %ymm7
vpmuludq	%ymm13, %ymm10, %ymm10
vmovdqu	-0x70(%r13), %ymm14
vpbroadcastq	%xmm0, %ymm0
vpaddq	%ymm10, %ymm8, %ymm8
vpmuludq	%ymm13, %ymm9, %ymm9
vmovdqu	-0x50(%r13), %ymm11
addq	%rax, %r12
vmovdqu	-0x78(%r13), %ymm13
vpmuludq	%ymm12, %ymm14, %ymm14
vmovdqu	-0x30(%r13), %ymm10
vpaddq	%ymm1, %ymm14, %ymm1
vpmuludq	%ymm0, %ymm13, %ymm13
vpmuludq	%ymm12, %ymm11, %ymm11
vmovdqu	-0x10(%r13), %ymm14
vpaddq	%ymm1, %ymm13, %ymm13
vpaddq	%ymm2, %ymm11, %ymm2
vpmuludq	%ymm12, %ymm10, %ymm10
vmovdqu	0x10(%r13), %ymm11
addr32	vmovq	%xmm13, %rax
vmovdqu	%ymm13, (%rsp)
vpaddq	%ymm3, %ymm10, %ymm3
vpmuludq	%ymm12, %ymm14, %ymm14
vmovdqu	0x30(%r13), %ymm10
vpaddq	%ymm4, %ymm14, %ymm4
vpmuludq	%ymm12, %ymm11, %ymm11
vmovdqu	0x50(%r13), %ymm14
vpaddq	%ymm5, %ymm11, %ymm5
vpmuludq	%ymm12, %ymm10, %ymm10
vmovdqu	0x70(%r13), %ymm11
vpaddq	%ymm6, %ymm10, %ymm6
vpmuludq	%ymm12, %ymm14, %ymm14
shrq	$0x1d, %r12
vmovdqu	0x90(%r13), %ymm10
addq	%r12, %rax
vpaddq	%ymm7, %ymm14, %ymm7
vpmuludq	%ymm12, %ymm11, %ymm11
movq	%rax, %r9
imull	%ecx, %eax
vpaddq	%ymm11, %ymm8, %ymm8
vpmuludq	%ymm12, %ymm10, %ymm10
andl	$0x1fffffff, %eax
vmovd	%eax, %xmm12
vmovdqu	-0x38(%r13), %ymm11
addr32	vpaddq	%ymm10, %ymm9, %ymm9
vpbroadcastq	%xmm12, %ymm12
vpmuludq	-0x58(%r13), %ymm0, %ymm14
vmovdqu	-0x18(%r13), %ymm10
movq	%rax, %rdx
imulq	-0x80(%r13), %rax
movq	0x8(%rsp), %r10
vpaddq	%ymm2, %ymm14, %ymm1
vpmuludq	%ymm0, %ymm11, %ymm11
vmovdqu	0x8(%r13), %ymm14
addq	%rax, %r9
movq	%rdx, %rax
imulq	-0x78(%r13), %rax
addr32	shrq	$0x1d, %r9
movq	0x10(%rsp), %r11
vpaddq	%ymm3, %ymm11, %ymm2
vpmuludq	%ymm0, %ymm10, %ymm10
vmovdqu	0x28(%r13), %ymm11
addq	%rax, %r10
movq	%rdx, %rax
imulq	-0x70(%r13), %rax
vpaddq	%ymm4, %ymm10, %ymm3
vpmuludq	%ymm0, %ymm14, %ymm14
vmovdqu	0x48(%r13), %ymm10
imulq	-0x68(%r13), %rdx
addq	%rax, %r11
leaq	(%r9,%r10), %rax
vpaddq	%ymm5, %ymm14, %ymm4
vpmuludq	%ymm0, %ymm11, %ymm11
vmovdqu	0x68(%r13), %ymm14
movq	%rax, %r10
imull	%ecx, %eax
vpmuludq	%ymm0, %ymm10, %ymm10
vpaddq	%ymm6, %ymm11, %ymm5
vmovdqu	0x88(%r13), %ymm11
andl	$0x1fffffff, %eax
vpaddq	%ymm7, %ymm10, %ymm6
vpmuludq	%ymm0, %ymm14, %ymm14
addq	0x18(%rsp), %rdx
vpaddq	%ymm14, %ymm8, %ymm7
vpmuludq	%ymm0, %ymm11, %ymm11
vpaddq	%ymm11, %ymm9, %ymm8
vmovq	%r12, %xmm9
movq	%rdx, %r12
decl	%r14d
jne	L_5c0
leaq	0x1c0(%rsp), %r12
vpaddq	%ymm9, %ymm13, %ymm0
vpxor	%ymm9, %ymm9, %ymm9
vpaddq	0x60(%rbx), %ymm0, %ymm0
vpaddq	-0x80(%r12), %ymm1, %ymm1
vpaddq	-0x60(%r12), %ymm2, %ymm2
vpaddq	-0x40(%r12), %ymm3, %ymm3
vpaddq	-0x20(%r12), %ymm4, %ymm4
vpaddq	(%r12), %ymm5, %ymm5
vpaddq	0x20(%r12), %ymm6, %ymm6
vpaddq	0x40(%r12), %ymm7, %ymm7
vpaddq	0x60(%r12), %ymm8, %ymm8
vpsrlq	$0x1d, %ymm0, %ymm14
vpand	%ymm0, %ymm15, %ymm0
vpsrlq	$0x1d, %ymm1, %ymm11
vpand	%ymm1, %ymm15, %ymm1
vpsrlq	$0x1d, %ymm2, %ymm12
vpermq	$0x93, %ymm14, %ymm14
vpand	%ymm2, %ymm15, %ymm2
vpsrlq	$0x1d, %ymm3, %ymm13
vpermq	$0x93, %ymm11, %ymm11
vpand	%ymm3, %ymm15, %ymm3
vpermq	$0x93, %ymm12, %ymm12
vpblendd	$0x3, %ymm9, %ymm14, %ymm10
vpermq	$0x93, %ymm13, %ymm13
vpblendd	$0x3, %ymm14, %ymm11, %ymm14
vpaddq	%ymm0, %ymm10, %ymm0
vpblendd	$0x3, %ymm11, %ymm12, %ymm11
vpaddq	%ymm1, %ymm14, %ymm1
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm2, %ymm11, %ymm2
vpblendd	$0x3, %ymm13, %ymm9, %ymm13
vpaddq	%ymm3, %ymm12, %ymm3
vpaddq	%ymm4, %ymm13, %ymm4
vpsrlq	$0x1d, %ymm0, %ymm14
vpand	%ymm0, %ymm15, %ymm0
vpsrlq	$0x1d, %ymm1, %ymm11
vpand	%ymm1, %ymm15, %ymm1
vpsrlq	$0x1d, %ymm2, %ymm12
vpermq	$0x93, %ymm14, %ymm14
vpand	%ymm2, %ymm15, %ymm2
vpsrlq	$0x1d, %ymm3, %ymm13
vpermq	$0x93, %ymm11, %ymm11
vpand	%ymm3, %ymm15, %ymm3
vpermq	$0x93, %ymm12, %ymm12
vpblendd	$0x3, %ymm9, %ymm14, %ymm10
vpermq	$0x93, %ymm13, %ymm13
vpblendd	$0x3, %ymm14, %ymm11, %ymm14
vpaddq	%ymm0, %ymm10, %ymm0
vpblendd	$0x3, %ymm11, %ymm12, %ymm11
vpaddq	%ymm1, %ymm14, %ymm1
vmovdqu	%ymm0, -0x80(%rdi)
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm2, %ymm11, %ymm2
vmovdqu	%ymm1, -0x60(%rdi)
vpblendd	$0x3, %ymm13, %ymm9, %ymm13
vpaddq	%ymm3, %ymm12, %ymm3
vmovdqu	%ymm2, -0x40(%rdi)
vpaddq	%ymm4, %ymm13, %ymm4
vmovdqu	%ymm3, -0x20(%rdi)
vpsrlq	$0x1d, %ymm4, %ymm14
vpand	%ymm4, %ymm15, %ymm4
vpsrlq	$0x1d, %ymm5, %ymm11
vpand	%ymm5, %ymm15, %ymm5
vpsrlq	$0x1d, %ymm6, %ymm12
vpermq	$0x93, %ymm14, %ymm14
vpand	%ymm6, %ymm15, %ymm6
vpsrlq	$0x1d, %ymm7, %ymm13
vpermq	$0x93, %ymm11, %ymm11
vpand	%ymm7, %ymm15, %ymm7
vpsrlq	$0x1d, %ymm8, %ymm0
vpermq	$0x93, %ymm12, %ymm12
vpand	%ymm15, %ymm8, %ymm8
vpermq	$0x93, %ymm13, %ymm13
vpblendd	$0x3, %ymm9, %ymm14, %ymm10
vpermq	$0x93, %ymm0, %ymm0
vpblendd	$0x3, %ymm14, %ymm11, %ymm14
vpaddq	%ymm4, %ymm10, %ymm4
vpblendd	$0x3, %ymm11, %ymm12, %ymm11
vpaddq	%ymm5, %ymm14, %ymm5
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm6, %ymm11, %ymm6
vpblendd	$0x3, %ymm13, %ymm0, %ymm13
vpaddq	%ymm7, %ymm12, %ymm7
vpaddq	%ymm13, %ymm8, %ymm8
vpsrlq	$0x1d, %ymm4, %ymm14
vpand	%ymm4, %ymm15, %ymm4
vpsrlq	$0x1d, %ymm5, %ymm11
vpand	%ymm5, %ymm15, %ymm5
vpsrlq	$0x1d, %ymm6, %ymm12
vpermq	$0x93, %ymm14, %ymm14
vpand	%ymm6, %ymm15, %ymm6
vpsrlq	$0x1d, %ymm7, %ymm13
vpermq	$0x93, %ymm11, %ymm11
vpand	%ymm7, %ymm15, %ymm7
vpsrlq	$0x1d, %ymm8, %ymm0
vpermq	$0x93, %ymm12, %ymm12
vpand	%ymm15, %ymm8, %ymm8
vpermq	$0x93, %ymm13, %ymm13
vpblendd	$0x3, %ymm9, %ymm14, %ymm10
vpermq	$0x93, %ymm0, %ymm0
vpblendd	$0x3, %ymm14, %ymm11, %ymm14
vpaddq	%ymm4, %ymm10, %ymm4
vpblendd	$0x3, %ymm11, %ymm12, %ymm11
vpaddq	%ymm5, %ymm14, %ymm5
vmovdqu	%ymm4, (%rdi)
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm6, %ymm11, %ymm6
vmovdqu	%ymm5, 0x20(%rdi)
vpblendd	$0x3, %ymm13, %ymm0, %ymm13
vpaddq	%ymm7, %ymm12, %ymm7
vmovdqu	%ymm6, 0x40(%rdi)
vpaddq	%ymm13, %ymm8, %ymm8
vmovdqu	%ymm7, 0x60(%rdi)
vmovdqu	%ymm8, 0x80(%rdi)
movq	%rdi, %rsi
decl	%r8d
jne	L_120
vzeroall
movq	%rbp, %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
rsaz_1024_mul_avx2:
leaq	(%rsp), %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movq	%rax, %rbp
vzeroall
movq	%rdx, %r13
subq	$0x40, %rsp
addr32	movq	%rsi, %r15
andq	$0xfff, %r15
addq	$0x140, %r15
shrq	$0xc, %r15
movq	%rsi, %r15
cmovneq	%r13, %rsi
cmovneq	%r15, %r13
movq	%rcx, %r15
subq	$-0x80, %rsi
subq	$-0x80, %rcx
subq	$-0x80, %rdi
andq	$0xfff, %r15
addq	$0x140, %r15
addr32	shrq	$0xc, %r15
je	L_c46
subq	$0x140, %rsp
vmovdqu	-0x80(%rcx), %ymm0
andq	$-0x200, %rsp
vmovdqu	-0x60(%rcx), %ymm1
vmovdqu	-0x40(%rcx), %ymm2
vmovdqu	-0x20(%rcx), %ymm3
vmovdqu	(%rcx), %ymm4
vmovdqu	0x20(%rcx), %ymm5
vmovdqu	0x40(%rcx), %ymm6
vmovdqu	0x60(%rcx), %ymm7
vmovdqu	0x80(%rcx), %ymm8
leaq	0xc0(%rsp), %rcx
vmovdqu	%ymm0, -0x80(%rcx)
vpxor	%ymm0, %ymm0, %ymm0
vmovdqu	%ymm1, -0x60(%rcx)
vpxor	%ymm1, %ymm1, %ymm1
vmovdqu	%ymm2, -0x40(%rcx)
vpxor	%ymm2, %ymm2, %ymm2
vmovdqu	%ymm3, -0x20(%rcx)
vpxor	%ymm3, %ymm3, %ymm3
vmovdqu	%ymm4, (%rcx)
vpxor	%ymm4, %ymm4, %ymm4
vmovdqu	%ymm5, 0x20(%rcx)
vpxor	%ymm5, %ymm5, %ymm5
vmovdqu	%ymm6, 0x40(%rcx)
vpxor	%ymm6, %ymm6, %ymm6
vmovdqu	%ymm7, 0x60(%rcx)
vpxor	%ymm7, %ymm7, %ymm7
vmovdqu	%ymm8, 0x80(%rcx)
vmovdqa	%ymm0, %ymm8
vmovdqu	%ymm9, 0xa0(%rcx)
L_c46:
andq	$-0x40, %rsp
movq	(%r13), %rbx
vpbroadcastq	(%r13), %ymm10
vmovdqu	%ymm0, (%rsp)
xorq	%r9, %r9
addr32	xorq	%r10, %r10
xorq	%r11, %r11
xorq	%r12, %r12
vmovdqu	bums_rodata(%rip), %ymm15
movl	$0x9, %r14d
vmovdqu	%ymm9, 0xa0(%rdi)
jmp	L_c80
nop
L_c80:
vpsrlq	$0x1d, %ymm3, %ymm9
movq	%rbx, %rax
imulq	-0x80(%rsi), %rax
addq	%r9, %rax
movq	%rbx, %r10
imulq	-0x78(%rsi), %r10
addq	0x8(%rsp), %r10
movq	%rax, %r9
imull	%r8d, %eax
andl	$0x1fffffff, %eax
movq	%rbx, %r11
imulq	-0x70(%rsi), %r11
addq	0x10(%rsp), %r11
movq	%rbx, %r12
imulq	-0x68(%rsi), %r12
addq	0x18(%rsp), %r12
vpmuludq	-0x60(%rsi), %ymm10, %ymm0
vmovd	%eax, %xmm11
vpaddq	%ymm0, %ymm1, %ymm1
vpmuludq	-0x40(%rsi), %ymm10, %ymm12
vpbroadcastq	%xmm11, %ymm11
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	-0x20(%rsi), %ymm10, %ymm13
vpand	%ymm3, %ymm15, %ymm3
vpaddq	%ymm3, %ymm13, %ymm3
vpmuludq	(%rsi), %ymm10, %ymm0
vpaddq	%ymm0, %ymm4, %ymm4
vpmuludq	0x20(%rsi), %ymm10, %ymm12
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	0x40(%rsi), %ymm10, %ymm13
vpaddq	%ymm6, %ymm13, %ymm6
vpmuludq	0x60(%rsi), %ymm10, %ymm0
vpermq	$0x93, %ymm9, %ymm9
vpaddq	%ymm0, %ymm7, %ymm7
vpmuludq	0x80(%rsi), %ymm10, %ymm12
vpbroadcastq	0x8(%r13), %ymm10
vpaddq	%ymm12, %ymm8, %ymm8
movq	%rax, %rdx
imulq	-0x80(%rcx), %rax
addq	%rax, %r9
movq	%rdx, %rax
imulq	-0x78(%rcx), %rax
addq	%rax, %r10
movq	%rdx, %rax
imulq	-0x70(%rcx), %rax
addq	%rax, %r11
shrq	$0x1d, %r9
imulq	-0x68(%rcx), %rdx
addq	%rdx, %r12
addq	%r9, %r10
vpmuludq	-0x60(%rcx), %ymm11, %ymm13
vmovq	%xmm10, %rbx
vpaddq	%ymm1, %ymm13, %ymm1
vpmuludq	-0x40(%rcx), %ymm11, %ymm0
vpaddq	%ymm0, %ymm2, %ymm2
vpmuludq	-0x20(%rcx), %ymm11, %ymm12
vpaddq	%ymm3, %ymm12, %ymm3
vpmuludq	(%rcx), %ymm11, %ymm13
vpaddq	%ymm4, %ymm13, %ymm4
vpmuludq	0x20(%rcx), %ymm11, %ymm0
vpaddq	%ymm0, %ymm5, %ymm5
vpmuludq	0x40(%rcx), %ymm11, %ymm12
vpaddq	%ymm6, %ymm12, %ymm6
vpmuludq	0x60(%rcx), %ymm11, %ymm13
vpblendd	$0x3, %ymm14, %ymm9, %ymm12
vpaddq	%ymm7, %ymm13, %ymm7
vpmuludq	0x80(%rcx), %ymm11, %ymm0
vpaddq	%ymm3, %ymm12, %ymm3
vpaddq	%ymm0, %ymm8, %ymm8
movq	%rbx, %rax
imulq	-0x80(%rsi), %rax
addq	%rax, %r10
vmovdqu	-0x68(%rsi), %ymm12
movq	%rbx, %rax
imulq	-0x78(%rsi), %rax
addq	%rax, %r11
vmovdqu	-0x48(%rsi), %ymm13
movq	%r10, %rax
vpblendd	$0xfc, %ymm14, %ymm9, %ymm9
imull	%r8d, %eax
vpaddq	%ymm4, %ymm9, %ymm4
andl	$0x1fffffff, %eax
imulq	-0x70(%rsi), %rbx
addq	%rbx, %r12
vpmuludq	%ymm10, %ymm12, %ymm12
vmovd	%eax, %xmm11
vmovdqu	-0x28(%rsi), %ymm0
vpaddq	%ymm1, %ymm12, %ymm1
vpmuludq	%ymm10, %ymm13, %ymm13
vpbroadcastq	%xmm11, %ymm11
vmovdqu	-0x8(%rsi), %ymm12
vpaddq	%ymm2, %ymm13, %ymm2
vpmuludq	%ymm0, %ymm10, %ymm0
vmovdqu	0x18(%rsi), %ymm13
vpaddq	%ymm0, %ymm3, %ymm3
vpmuludq	%ymm10, %ymm12, %ymm12
vmovdqu	0x38(%rsi), %ymm0
vpaddq	%ymm4, %ymm12, %ymm4
vpmuludq	%ymm10, %ymm13, %ymm13
vmovdqu	0x58(%rsi), %ymm12
vpaddq	%ymm5, %ymm13, %ymm5
vpmuludq	%ymm0, %ymm10, %ymm0
vmovdqu	0x78(%rsi), %ymm13
vpaddq	%ymm0, %ymm6, %ymm6
vpmuludq	%ymm10, %ymm12, %ymm12
vmovdqu	0x98(%rsi), %ymm9
vpaddq	%ymm7, %ymm12, %ymm7
vpmuludq	%ymm10, %ymm13, %ymm13
vpaddq	%ymm13, %ymm8, %ymm8
vpmuludq	%ymm10, %ymm9, %ymm9
vpbroadcastq	0x10(%r13), %ymm10
movq	%rax, %rdx
imulq	-0x80(%rcx), %rax
addq	%rax, %r10
vmovdqu	-0x68(%rcx), %ymm0
movq	%rdx, %rax
imulq	-0x78(%rcx), %rax
addq	%rax, %r11
vmovdqu	-0x48(%rcx), %ymm12
shrq	$0x1d, %r10
imulq	-0x70(%rcx), %rdx
addq	%rdx, %r12
addq	%r10, %r11
vpmuludq	%ymm0, %ymm11, %ymm0
vmovq	%xmm10, %rbx
vmovdqu	-0x28(%rcx), %ymm13
vpaddq	%ymm0, %ymm1, %ymm1
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	-0x8(%rcx), %ymm0
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	0x18(%rcx), %ymm12
vpaddq	%ymm3, %ymm13, %ymm3
vpmuludq	%ymm0, %ymm11, %ymm0
vmovdqu	0x38(%rcx), %ymm13
vpaddq	%ymm0, %ymm4, %ymm4
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	0x58(%rcx), %ymm0
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	0x78(%rcx), %ymm12
vpaddq	%ymm6, %ymm13, %ymm6
vpmuludq	%ymm0, %ymm11, %ymm0
vmovdqu	0x98(%rcx), %ymm13
vpaddq	%ymm0, %ymm7, %ymm7
vpmuludq	%ymm11, %ymm12, %ymm12
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	%ymm11, %ymm13, %ymm13
vpaddq	%ymm13, %ymm9, %ymm9
vmovdqu	-0x70(%rsi), %ymm0
movq	%rbx, %rax
imulq	-0x80(%rsi), %rax
addq	%r11, %rax
vmovdqu	-0x50(%rsi), %ymm12
movq	%rax, %r11
imull	%r8d, %eax
andl	$0x1fffffff, %eax
imulq	-0x78(%rsi), %rbx
addq	%rbx, %r12
vpmuludq	%ymm0, %ymm10, %ymm0
vmovd	%eax, %xmm11
vmovdqu	-0x30(%rsi), %ymm13
vpaddq	%ymm0, %ymm1, %ymm1
vpmuludq	%ymm10, %ymm12, %ymm12
vpbroadcastq	%xmm11, %ymm11
vmovdqu	-0x10(%rsi), %ymm0
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	%ymm10, %ymm13, %ymm13
vmovdqu	0x10(%rsi), %ymm12
vpaddq	%ymm3, %ymm13, %ymm3
vpmuludq	%ymm0, %ymm10, %ymm0
vmovdqu	0x30(%rsi), %ymm13
vpaddq	%ymm0, %ymm4, %ymm4
vpmuludq	%ymm10, %ymm12, %ymm12
vmovdqu	0x50(%rsi), %ymm0
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	%ymm10, %ymm13, %ymm13
vmovdqu	0x70(%rsi), %ymm12
vpaddq	%ymm6, %ymm13, %ymm6
vpmuludq	%ymm0, %ymm10, %ymm0
vmovdqu	0x90(%rsi), %ymm13
vpaddq	%ymm0, %ymm7, %ymm7
vpmuludq	%ymm10, %ymm12, %ymm12
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	%ymm10, %ymm13, %ymm13
vpbroadcastq	0x18(%r13), %ymm10
vpaddq	%ymm13, %ymm9, %ymm9
vmovdqu	-0x70(%rcx), %ymm0
movq	%rax, %rdx
imulq	-0x80(%rcx), %rax
addq	%rax, %r11
vmovdqu	-0x50(%rcx), %ymm12
imulq	-0x78(%rcx), %rdx
addq	%rdx, %r12
shrq	$0x1d, %r11
vpmuludq	%ymm0, %ymm11, %ymm0
vmovq	%xmm10, %rbx
vmovdqu	-0x30(%rcx), %ymm13
vpaddq	%ymm0, %ymm1, %ymm1
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	-0x10(%rcx), %ymm0
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	0x10(%rcx), %ymm12
vpaddq	%ymm3, %ymm13, %ymm3
vpmuludq	%ymm0, %ymm11, %ymm0
vmovdqu	0x30(%rcx), %ymm13
vpaddq	%ymm0, %ymm4, %ymm4
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	0x50(%rcx), %ymm0
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	0x70(%rcx), %ymm12
vpaddq	%ymm6, %ymm13, %ymm6
vpmuludq	%ymm0, %ymm11, %ymm0
vmovdqu	0x90(%rcx), %ymm13
vpaddq	%ymm0, %ymm7, %ymm7
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	-0x78(%rsi), %ymm0
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	-0x58(%rsi), %ymm12
vpaddq	%ymm13, %ymm9, %ymm9
addq	%r11, %r12
imulq	-0x80(%rsi), %rbx
addq	%rbx, %r12
movq	%r12, %rax
imull	%r8d, %eax
andl	$0x1fffffff, %eax
vpmuludq	%ymm0, %ymm10, %ymm0
vmovd	%eax, %xmm11
vmovdqu	-0x38(%rsi), %ymm13
vpaddq	%ymm0, %ymm1, %ymm1
vpmuludq	%ymm10, %ymm12, %ymm12
vpbroadcastq	%xmm11, %ymm11
vmovdqu	-0x18(%rsi), %ymm0
vpaddq	%ymm2, %ymm12, %ymm2
vpmuludq	%ymm10, %ymm13, %ymm13
vmovdqu	0x8(%rsi), %ymm12
vpaddq	%ymm3, %ymm13, %ymm3
vpmuludq	%ymm0, %ymm10, %ymm0
vmovdqu	0x28(%rsi), %ymm13
vpaddq	%ymm0, %ymm4, %ymm4
vpmuludq	%ymm10, %ymm12, %ymm12
vmovdqu	0x48(%rsi), %ymm0
vpaddq	%ymm5, %ymm12, %ymm5
vpmuludq	%ymm10, %ymm13, %ymm13
vmovdqu	0x68(%rsi), %ymm12
vpaddq	%ymm6, %ymm13, %ymm6
vpmuludq	%ymm0, %ymm10, %ymm0
vmovdqu	0x88(%rsi), %ymm13
vpaddq	%ymm0, %ymm7, %ymm7
vpmuludq	%ymm10, %ymm12, %ymm12
vpaddq	%ymm12, %ymm8, %ymm8
vpmuludq	%ymm10, %ymm13, %ymm13
vpbroadcastq	0x20(%r13), %ymm10
vpaddq	%ymm13, %ymm9, %ymm9
addq	$0x20, %r13
vmovdqu	-0x78(%rcx), %ymm0
imulq	-0x80(%rcx), %rax
addq	%rax, %r12
shrq	$0x1d, %r12
vmovdqu	-0x58(%rcx), %ymm12
vpmuludq	%ymm0, %ymm11, %ymm0
vmovq	%xmm10, %rbx
vmovdqu	-0x38(%rcx), %ymm13
vpaddq	%ymm0, %ymm1, %ymm0
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	%ymm0, (%rsp)
vpaddq	%ymm2, %ymm12, %ymm1
vmovdqu	-0x18(%rcx), %ymm0
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	0x8(%rcx), %ymm12
vpaddq	%ymm3, %ymm13, %ymm2
vpmuludq	%ymm0, %ymm11, %ymm0
vmovdqu	0x28(%rcx), %ymm13
vpaddq	%ymm0, %ymm4, %ymm3
vpmuludq	%ymm11, %ymm12, %ymm12
vmovdqu	0x48(%rcx), %ymm0
vpaddq	%ymm5, %ymm12, %ymm4
vpmuludq	%ymm11, %ymm13, %ymm13
vmovdqu	0x68(%rcx), %ymm12
vpaddq	%ymm6, %ymm13, %ymm5
vpmuludq	%ymm0, %ymm11, %ymm0
vmovdqu	0x88(%rcx), %ymm13
movq	%r12, %r9
vpaddq	%ymm0, %ymm7, %ymm6
vpmuludq	%ymm11, %ymm12, %ymm12
addq	(%rsp), %r9
vpaddq	%ymm12, %ymm8, %ymm7
vpmuludq	%ymm11, %ymm13, %ymm13
vmovq	%r12, %xmm12
vpaddq	%ymm13, %ymm9, %ymm8
decl	%r14d
jne	L_c80
vpaddq	(%rsp), %ymm12, %ymm0
vpsrlq	$0x1d, %ymm0, %ymm12
vpand	%ymm0, %ymm15, %ymm0
vpsrlq	$0x1d, %ymm1, %ymm13
vpand	%ymm1, %ymm15, %ymm1
vpsrlq	$0x1d, %ymm2, %ymm10
vpermq	$0x93, %ymm12, %ymm12
vpand	%ymm2, %ymm15, %ymm2
vpsrlq	$0x1d, %ymm3, %ymm11
vpermq	$0x93, %ymm13, %ymm13
vpand	%ymm3, %ymm15, %ymm3
vpblendd	$0x3, %ymm14, %ymm12, %ymm9
vpermq	$0x93, %ymm10, %ymm10
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpermq	$0x93, %ymm11, %ymm11
vpaddq	%ymm0, %ymm9, %ymm0
vpblendd	$0x3, %ymm13, %ymm10, %ymm13
vpaddq	%ymm1, %ymm12, %ymm1
vpblendd	$0x3, %ymm10, %ymm11, %ymm10
vpaddq	%ymm2, %ymm13, %ymm2
vpblendd	$0x3, %ymm11, %ymm14, %ymm11
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm4, %ymm11, %ymm4
vpsrlq	$0x1d, %ymm0, %ymm12
vpand	%ymm0, %ymm15, %ymm0
vpsrlq	$0x1d, %ymm1, %ymm13
vpand	%ymm1, %ymm15, %ymm1
vpsrlq	$0x1d, %ymm2, %ymm10
vpermq	$0x93, %ymm12, %ymm12
vpand	%ymm2, %ymm15, %ymm2
vpsrlq	$0x1d, %ymm3, %ymm11
vpermq	$0x93, %ymm13, %ymm13
vpand	%ymm3, %ymm15, %ymm3
vpermq	$0x93, %ymm10, %ymm10
vpblendd	$0x3, %ymm14, %ymm12, %ymm9
vpermq	$0x93, %ymm11, %ymm11
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm0, %ymm9, %ymm0
vpblendd	$0x3, %ymm13, %ymm10, %ymm13
vpaddq	%ymm1, %ymm12, %ymm1
vpblendd	$0x3, %ymm10, %ymm11, %ymm10
vpaddq	%ymm2, %ymm13, %ymm2
vpblendd	$0x3, %ymm11, %ymm14, %ymm11
vpaddq	%ymm3, %ymm10, %ymm3
vpaddq	%ymm4, %ymm11, %ymm4
vmovdqu	%ymm0, -0x80(%rdi)
vmovdqu	%ymm1, -0x60(%rdi)
vmovdqu	%ymm2, -0x40(%rdi)
vmovdqu	%ymm3, -0x20(%rdi)
vpsrlq	$0x1d, %ymm4, %ymm12
vpand	%ymm4, %ymm15, %ymm4
vpsrlq	$0x1d, %ymm5, %ymm13
vpand	%ymm5, %ymm15, %ymm5
vpsrlq	$0x1d, %ymm6, %ymm10
vpermq	$0x93, %ymm12, %ymm12
vpand	%ymm6, %ymm15, %ymm6
vpsrlq	$0x1d, %ymm7, %ymm11
vpermq	$0x93, %ymm13, %ymm13
vpand	%ymm7, %ymm15, %ymm7
vpsrlq	$0x1d, %ymm8, %ymm0
vpermq	$0x93, %ymm10, %ymm10
vpand	%ymm15, %ymm8, %ymm8
vpermq	$0x93, %ymm11, %ymm11
vpblendd	$0x3, %ymm14, %ymm12, %ymm9
vpermq	$0x93, %ymm0, %ymm0
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm4, %ymm9, %ymm4
vpblendd	$0x3, %ymm13, %ymm10, %ymm13
vpaddq	%ymm5, %ymm12, %ymm5
vpblendd	$0x3, %ymm10, %ymm11, %ymm10
vpaddq	%ymm6, %ymm13, %ymm6
vpblendd	$0x3, %ymm11, %ymm0, %ymm11
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm11, %ymm8, %ymm8
vpsrlq	$0x1d, %ymm4, %ymm12
vpand	%ymm4, %ymm15, %ymm4
vpsrlq	$0x1d, %ymm5, %ymm13
vpand	%ymm5, %ymm15, %ymm5
vpsrlq	$0x1d, %ymm6, %ymm10
vpermq	$0x93, %ymm12, %ymm12
vpand	%ymm6, %ymm15, %ymm6
vpsrlq	$0x1d, %ymm7, %ymm11
vpermq	$0x93, %ymm13, %ymm13
vpand	%ymm7, %ymm15, %ymm7
vpsrlq	$0x1d, %ymm8, %ymm0
vpermq	$0x93, %ymm10, %ymm10
vpand	%ymm15, %ymm8, %ymm8
vpermq	$0x93, %ymm11, %ymm11
vpblendd	$0x3, %ymm14, %ymm12, %ymm9
vpermq	$0x93, %ymm0, %ymm0
vpblendd	$0x3, %ymm12, %ymm13, %ymm12
vpaddq	%ymm4, %ymm9, %ymm4
vpblendd	$0x3, %ymm13, %ymm10, %ymm13
vpaddq	%ymm5, %ymm12, %ymm5
vpblendd	$0x3, %ymm10, %ymm11, %ymm10
vpaddq	%ymm6, %ymm13, %ymm6
vpblendd	$0x3, %ymm11, %ymm0, %ymm11
vpaddq	%ymm7, %ymm10, %ymm7
vpaddq	%ymm11, %ymm8, %ymm8
vmovdqu	%ymm4, (%rdi)
vmovdqu	%ymm5, 0x20(%rdi)
vmovdqu	%ymm6, 0x40(%rdi)
vmovdqu	%ymm7, 0x60(%rdi)
vmovdqu	%ymm8, 0x80(%rdi)
vzeroupper
movq	%rbp, %rax
movq	-0x30(%rax), %r15
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
rsaz_1024_red2norm_avx2:
subq	$-0x80, %rsi
xorq	%rax, %rax
movq	-0x80(%rsi), %r8
movq	-0x78(%rsi), %r9
movq	-0x70(%rsi), %r10
shlq	$0x0, %r8
shlq	$0x1d, %r9
movq	%r10, %r11
shlq	$0x3a, %r10
shrq	$0x6, %r11
addq	%r8, %rax
addq	%r9, %rax
addq	%r10, %rax
adcq	$0x0, %r11
movq	%rax, (%rdi)
movq	%r11, %rax
movq	-0x68(%rsi), %r8
movq	-0x60(%rsi), %r9
shlq	$0x17, %r8
movq	%r9, %r10
shlq	$0x34, %r9
shrq	$0xc, %r10
addq	%r8, %rax
addq	%r9, %rax
adcq	$0x0, %r10
movq	%rax, 0x8(%rdi)
movq	%r10, %rax
movq	-0x58(%rsi), %r11
movq	-0x50(%rsi), %r8
shlq	$0x11, %r11
movq	%r8, %r9
shlq	$0x2e, %r8
shrq	$0x12, %r9
addq	%r11, %rax
addq	%r8, %rax
adcq	$0x0, %r9
movq	%rax, 0x10(%rdi)
movq	%r9, %rax
movq	-0x48(%rsi), %r10
movq	-0x40(%rsi), %r11
shlq	$0xb, %r10
movq	%r11, %r8
shlq	$0x28, %r11
shrq	$0x18, %r8
addq	%r10, %rax
addq	%r11, %rax
adcq	$0x0, %r8
movq	%rax, 0x18(%rdi)
movq	%r8, %rax
movq	-0x38(%rsi), %r9
movq	-0x30(%rsi), %r10
movq	-0x28(%rsi), %r11
shlq	$0x5, %r9
shlq	$0x22, %r10
movq	%r11, %r8
shlq	$0x3f, %r11
shrq	%r8
addq	%r9, %rax
addq	%r10, %rax
addq	%r11, %rax
adcq	$0x0, %r8
movq	%rax, 0x20(%rdi)
movq	%r8, %rax
movq	-0x20(%rsi), %r9
movq	-0x18(%rsi), %r10
shlq	$0x1c, %r9
movq	%r10, %r11
shlq	$0x39, %r10
shrq	$0x7, %r11
addq	%r9, %rax
addq	%r10, %rax
adcq	$0x0, %r11
movq	%rax, 0x28(%rdi)
movq	%r11, %rax
movq	-0x10(%rsi), %r8
movq	-0x8(%rsi), %r9
shlq	$0x16, %r8
movq	%r9, %r10
shlq	$0x33, %r9
shrq	$0xd, %r10
addq	%r8, %rax
addq	%r9, %rax
adcq	$0x0, %r10
movq	%rax, 0x30(%rdi)
movq	%r10, %rax
movq	(%rsi), %r11
movq	0x8(%rsi), %r8
shlq	$0x10, %r11
movq	%r8, %r9
shlq	$0x2d, %r8
shrq	$0x13, %r9
addq	%r11, %rax
addq	%r8, %rax
adcq	$0x0, %r9
movq	%rax, 0x38(%rdi)
movq	%r9, %rax
movq	0x10(%rsi), %r10
movq	0x18(%rsi), %r11
shlq	$0xa, %r10
movq	%r11, %r8
shlq	$0x27, %r11
shrq	$0x19, %r8
addq	%r10, %rax
addq	%r11, %rax
adcq	$0x0, %r8
movq	%rax, 0x40(%rdi)
movq	%r8, %rax
movq	0x20(%rsi), %r9
movq	0x28(%rsi), %r10
movq	0x30(%rsi), %r11
shlq	$0x4, %r9
shlq	$0x21, %r10
movq	%r11, %r8
shlq	$0x3e, %r11
shrq	$0x2, %r8
addq	%r9, %rax
addq	%r10, %rax
addq	%r11, %rax
adcq	$0x0, %r8
movq	%rax, 0x48(%rdi)
movq	%r8, %rax
movq	0x38(%rsi), %r9
movq	0x40(%rsi), %r10
shlq	$0x1b, %r9
movq	%r10, %r11
shlq	$0x38, %r10
shrq	$0x8, %r11
addq	%r9, %rax
addq	%r10, %rax
adcq	$0x0, %r11
movq	%rax, 0x50(%rdi)
movq	%r11, %rax
movq	0x48(%rsi), %r8
movq	0x50(%rsi), %r9
shlq	$0x15, %r8
movq	%r9, %r10
shlq	$0x32, %r9
shrq	$0xe, %r10
addq	%r8, %rax
addq	%r9, %rax
adcq	$0x0, %r10
movq	%rax, 0x58(%rdi)
movq	%r10, %rax
movq	0x58(%rsi), %r11
movq	0x60(%rsi), %r8
shlq	$0xf, %r11
movq	%r8, %r9
shlq	$0x2c, %r8
shrq	$0x14, %r9
addq	%r11, %rax
addq	%r8, %rax
adcq	$0x0, %r9
movq	%rax, 0x60(%rdi)
movq	%r9, %rax
movq	0x68(%rsi), %r10
movq	0x70(%rsi), %r11
shlq	$0x9, %r10
movq	%r11, %r8
shlq	$0x26, %r11
shrq	$0x1a, %r8
addq	%r10, %rax
addq	%r11, %rax
adcq	$0x0, %r8
movq	%rax, 0x68(%rdi)
movq	%r8, %rax
movq	0x78(%rsi), %r9
movq	0x80(%rsi), %r10
movq	0x88(%rsi), %r11
shlq	$0x3, %r9
shlq	$0x20, %r10
movq	%r11, %r8
shlq	$0x3d, %r11
shrq	$0x3, %r8
addq	%r9, %rax
addq	%r10, %rax
addq	%r11, %rax
adcq	$0x0, %r8
movq	%rax, 0x70(%rdi)
movq	%r8, %rax
movq	0x90(%rsi), %r9
movq	0x98(%rsi), %r10
shlq	$0x1a, %r9
movq	%r10, %r11
shlq	$0x37, %r10
shrq	$0x9, %r11
addq	%r9, %rax
addq	%r10, %rax
adcq	$0x0, %r11
movq	%rax, 0x78(%rdi)
movq	%r11, %rax
rep	retq
nop
rsaz_1024_norm2red_avx2:
subq	$-0x80, %rdi
movq	(%rsi), %r8
movl	$0x1fffffff, %eax
movq	0x8(%rsi), %r9
movq	%r8, %r11
shrq	$0x0, %r11
andq	%rax, %r11
movq	%r11, -0x80(%rdi)
movq	%r8, %r10
shrq	$0x1d, %r10
andq	%rax, %r10
movq	%r10, -0x78(%rdi)
shrdq	$0x3a, %r9, %r8
andq	%rax, %r8
movq	%r8, -0x70(%rdi)
movq	0x10(%rsi), %r10
movq	%r9, %r8
shrq	$0x17, %r8
andq	%rax, %r8
movq	%r8, -0x68(%rdi)
shrdq	$0x34, %r10, %r9
andq	%rax, %r9
movq	%r9, -0x60(%rdi)
movq	0x18(%rsi), %r11
movq	%r10, %r9
shrq	$0x11, %r9
andq	%rax, %r9
movq	%r9, -0x58(%rdi)
shrdq	$0x2e, %r11, %r10
andq	%rax, %r10
movq	%r10, -0x50(%rdi)
movq	0x20(%rsi), %r8
movq	%r11, %r10
shrq	$0xb, %r10
andq	%rax, %r10
movq	%r10, -0x48(%rdi)
shrdq	$0x28, %r8, %r11
andq	%rax, %r11
movq	%r11, -0x40(%rdi)
movq	0x28(%rsi), %r9
movq	%r8, %r11
shrq	$0x5, %r11
andq	%rax, %r11
movq	%r11, -0x38(%rdi)
movq	%r8, %r10
shrq	$0x22, %r10
andq	%rax, %r10
movq	%r10, -0x30(%rdi)
shrdq	$0x3f, %r9, %r8
andq	%rax, %r8
movq	%r8, -0x28(%rdi)
movq	0x30(%rsi), %r10
movq	%r9, %r8
shrq	$0x1c, %r8
andq	%rax, %r8
movq	%r8, -0x20(%rdi)
shrdq	$0x39, %r10, %r9
andq	%rax, %r9
movq	%r9, -0x18(%rdi)
movq	0x38(%rsi), %r11
movq	%r10, %r9
shrq	$0x16, %r9
andq	%rax, %r9
movq	%r9, -0x10(%rdi)
shrdq	$0x33, %r11, %r10
andq	%rax, %r10
movq	%r10, -0x8(%rdi)
movq	0x40(%rsi), %r8
movq	%r11, %r10
shrq	$0x10, %r10
andq	%rax, %r10
movq	%r10, (%rdi)
shrdq	$0x2d, %r8, %r11
andq	%rax, %r11
movq	%r11, 0x8(%rdi)
movq	0x48(%rsi), %r9
movq	%r8, %r11
shrq	$0xa, %r11
andq	%rax, %r11
movq	%r11, 0x10(%rdi)
shrdq	$0x27, %r9, %r8
andq	%rax, %r8
movq	%r8, 0x18(%rdi)
movq	0x50(%rsi), %r10
movq	%r9, %r8
shrq	$0x4, %r8
andq	%rax, %r8
movq	%r8, 0x20(%rdi)
movq	%r9, %r11
shrq	$0x21, %r11
andq	%rax, %r11
movq	%r11, 0x28(%rdi)
shrdq	$0x3e, %r10, %r9
andq	%rax, %r9
movq	%r9, 0x30(%rdi)
movq	0x58(%rsi), %r11
movq	%r10, %r9
shrq	$0x1b, %r9
andq	%rax, %r9
movq	%r9, 0x38(%rdi)
shrdq	$0x38, %r11, %r10
andq	%rax, %r10
movq	%r10, 0x40(%rdi)
movq	0x60(%rsi), %r8
movq	%r11, %r10
shrq	$0x15, %r10
andq	%rax, %r10
movq	%r10, 0x48(%rdi)
shrdq	$0x32, %r8, %r11
andq	%rax, %r11
movq	%r11, 0x50(%rdi)
movq	0x68(%rsi), %r9
movq	%r8, %r11
shrq	$0xf, %r11
andq	%rax, %r11
movq	%r11, 0x58(%rdi)
shrdq	$0x2c, %r9, %r8
andq	%rax, %r8
movq	%r8, 0x60(%rdi)
movq	0x70(%rsi), %r10
movq	%r9, %r8
shrq	$0x9, %r8
andq	%rax, %r8
movq	%r8, 0x68(%rdi)
shrdq	$0x26, %r10, %r9
andq	%rax, %r9
movq	%r9, 0x70(%rdi)
movq	0x78(%rsi), %r11
movq	%r10, %r9
shrq	$0x3, %r9
andq	%rax, %r9
movq	%r9, 0x78(%rdi)
movq	%r10, %r8
shrq	$0x20, %r8
andq	%rax, %r8
movq	%r8, 0x80(%rdi)
shrdq	$0x3d, %r11, %r10
andq	%rax, %r10
movq	%r10, 0x88(%rdi)
xorq	%r8, %r8
movq	%r11, %r10
shrq	$0x1a, %r10
andq	%rax, %r10
movq	%r10, 0x90(%rdi)
shrdq	$0x37, %r8, %r11
andq	%rax, %r11
movq	%r11, 0x98(%rdi)
movq	%r8, 0xa0(%rdi)
movq	%r8, 0xa8(%rdi)
movq	%r8, 0xb0(%rdi)
movq	%r8, 0xb8(%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
rsaz_1024_scatter5_avx2:
vzeroupper
vmovdqu	bums_rodata+32(%rip), %ymm5
shll	$0x4, %edx
leaq	(%rdi,%rdx), %rdi
movl	$0x9, %eax
jmp	L_1940
nopl	(%rax)
L_1940:
vmovdqu	(%rsi), %ymm0
leaq	0x20(%rsi), %rsi
vpermd	%ymm0, %ymm5, %ymm0
vmovdqu	%xmm0, (%rdi)
leaq	0x200(%rdi), %rdi
decl	%eax
jne	L_1940
vzeroupper
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
rsaz_1024_gather5_avx2:
vzeroupper
movq	%rsp, %r11
leaq	-0x100(%rsp), %rsp
andq	$-0x20, %rsp
leaq	bums_rodata+96(%rip), %r10
leaq	-0x80(%rsp), %rax
vmovd	%edx, %xmm4
vmovdqa	(%r10), %ymm0
vmovdqa	0x20(%r10), %ymm1
vmovdqa	0x40(%r10), %ymm5
vpbroadcastd	%xmm4, %ymm4
vpaddd	%ymm5, %ymm0, %ymm2
vpcmpeqd	%ymm4, %ymm0, %ymm0
vpaddd	%ymm5, %ymm1, %ymm3
vpcmpeqd	%ymm4, %ymm1, %ymm1
vmovdqa	%ymm0, 0x80(%rax)
vpaddd	%ymm5, %ymm2, %ymm0
vpcmpeqd	%ymm4, %ymm2, %ymm2
vmovdqa	%ymm1, 0xa0(%rax)
vpaddd	%ymm5, %ymm3, %ymm1
vpcmpeqd	%ymm4, %ymm3, %ymm3
vmovdqa	%ymm2, 0xc0(%rax)
vpaddd	%ymm5, %ymm0, %ymm2
vpcmpeqd	%ymm4, %ymm0, %ymm0
vmovdqa	%ymm3, 0xe0(%rax)
vpaddd	%ymm5, %ymm1, %ymm3
vpcmpeqd	%ymm4, %ymm1, %ymm1
vmovdqa	%ymm0, 0x100(%rax)
vpaddd	%ymm5, %ymm2, %ymm8
vpcmpeqd	%ymm4, %ymm2, %ymm2
vmovdqa	%ymm1, 0x120(%rax)
vpaddd	%ymm5, %ymm3, %ymm9
vpcmpeqd	%ymm4, %ymm3, %ymm3
vmovdqa	%ymm2, 0x140(%rax)
vpaddd	%ymm5, %ymm8, %ymm10
vpcmpeqd	%ymm4, %ymm8, %ymm8
vmovdqa	%ymm3, 0x160(%rax)
vpaddd	%ymm5, %ymm9, %ymm11
vpcmpeqd	%ymm4, %ymm9, %ymm9
vpaddd	%ymm5, %ymm10, %ymm12
vpcmpeqd	%ymm4, %ymm10, %ymm10
vpaddd	%ymm5, %ymm11, %ymm13
vpcmpeqd	%ymm4, %ymm11, %ymm11
vpaddd	%ymm5, %ymm12, %ymm14
vpcmpeqd	%ymm4, %ymm12, %ymm12
vpaddd	%ymm5, %ymm13, %ymm15
vpcmpeqd	%ymm4, %ymm13, %ymm13
vpcmpeqd	%ymm4, %ymm14, %ymm14
vpcmpeqd	%ymm4, %ymm15, %ymm15
vmovdqa	-0x20(%r10), %ymm7
leaq	0x80(%rsi), %rsi
movl	$0x9, %edx
L_1a82:
vmovdqa	-0x80(%rsi), %ymm0
vmovdqa	-0x60(%rsi), %ymm1
vmovdqa	-0x40(%rsi), %ymm2
vmovdqa	-0x20(%rsi), %ymm3
vpand	0x80(%rax), %ymm0, %ymm0
vpand	0xa0(%rax), %ymm1, %ymm1
vpand	0xc0(%rax), %ymm2, %ymm2
vpor	%ymm0, %ymm1, %ymm4
vpand	0xe0(%rax), %ymm3, %ymm3
vmovdqa	(%rsi), %ymm0
vmovdqa	0x20(%rsi), %ymm1
vpor	%ymm2, %ymm3, %ymm5
vmovdqa	0x40(%rsi), %ymm2
vmovdqa	0x60(%rsi), %ymm3
vpand	0x100(%rax), %ymm0, %ymm0
vpand	0x120(%rax), %ymm1, %ymm1
vpand	0x140(%rax), %ymm2, %ymm2
vpor	%ymm0, %ymm4, %ymm4
vpand	0x160(%rax), %ymm3, %ymm3
vpand	0x80(%rsi), %ymm8, %ymm0
vpor	%ymm1, %ymm5, %ymm5
vpand	0xa0(%rsi), %ymm9, %ymm1
vpor	%ymm2, %ymm4, %ymm4
vpand	0xc0(%rsi), %ymm10, %ymm2
vpor	%ymm3, %ymm5, %ymm5
vpand	0xe0(%rsi), %ymm11, %ymm3
vpor	%ymm0, %ymm4, %ymm4
vpand	0x100(%rsi), %ymm12, %ymm0
vpor	%ymm1, %ymm5, %ymm5
vpand	0x120(%rsi), %ymm13, %ymm1
vpor	%ymm2, %ymm4, %ymm4
vpand	0x140(%rsi), %ymm14, %ymm2
vpor	%ymm3, %ymm5, %ymm5
vpand	0x160(%rsi), %ymm15, %ymm3
leaq	0x200(%rsi), %rsi
vpor	%ymm0, %ymm4, %ymm4
vpor	%ymm1, %ymm5, %ymm5
vpor	%ymm2, %ymm4, %ymm4
vpor	%ymm3, %ymm5, %ymm5
vpor	%ymm5, %ymm4, %ymm4
vextracti128	$0x1, %ymm4, %xmm5
vpor	%xmm4, %xmm5, %xmm5
vpermd	%ymm5, %ymm7, %ymm5
vmovdqu	%ymm5, (%rdi)
leaq	0x20(%rdi), %rdi
decl	%edx
jne	L_1a82
vpxor	%ymm0, %ymm0, %ymm0
vmovdqu	%ymm0, (%rdi)
vzeroupper
leaq	(%r11), %rsp
rep	retq
nopl	(%rax,%rax)
rsaz_avx2_eligible:
movl	OPENSSL_ia32cap_P+8(%rip), %eax
movl	$0x80100, %ecx
movl	$0x0, %edx
andl	%eax, %ecx
cmpl	$0x80100, %ecx
cmovel	%edx, %eax
andl	$0x20, %eax
shrl	$0x5, %eax
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
	.section .rodata
bums_rodata:
	.byte 255,255,255,31,0,0,0,0,255,255,255,31,0,0,0,0
	.byte 255,255,255,31,0,0,0,0,255,255,255,31,0,0,0,0
	.byte 0,0,0,0,2,0,0,0,4,0,0,0,6,0,0,0
	.byte 7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0
	.byte 0,0,0,0,7,0,0,0,1,0,0,0,7,0,0,0
	.byte 2,0,0,0,7,0,0,0,3,0,0,0,7,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0
	.byte 2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	.byte 3,0,0,0,3,0,0,0,3,0,0,0,3,0,0,0
	.byte 4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0
	.byte 4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0

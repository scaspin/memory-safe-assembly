	.text
..@8.end:
mem_zero_detect_avx512:
endbr64
orq	$-0x1, %rcx
movl	%edi, %eax
andl	$0x3f, %eax
negq	%rax
addq	$0x40, %rax
cmpq	%rsi, %rax
cmovael	%esi, %eax
bzhiq	%rax, %rcx, %rcx
kmovq	%rcx, %k1
vmovdqu8	(%rdi), %zmm0 {%k1} {z}
addq	%rax, %rdi
subq	%rax, %rsi
vptestmb	%zmm0, %zmm0, %k1
xorl	%edx, %edx
ktestq	%k1, %k1
setne	%dl
movl	%esi, %r8d
xorl	%eax, %eax
shrq	$0x7, %rsi
sete	%al
addl	%edx, %eax
jne	..@16.end
..@13.end:
mem_zero_detect_avx512.mem_z_loop:
vmovdqa64	(%rdi), %zmm0
vporq	0x40(%rdi), %zmm0, %zmm0
xorq	%rcx, %rcx
subq	$0x1, %rsi
setne	%cl
addq	$0x80, %rdi
vptestmb	%zmm0, %zmm0, %k1
kmovq	%k1, %rdx
cmpq	%rcx, %rdx
jb	..@13.end
nop
..@16.end:
mem_zero_detect_avx512.mem_z_small_block:
xorl	%eax, %eax
leaq	-0x1(%rax), %rcx
movl	%r8d, %esi
andl	$0x7f, %esi
andl	$0x3f, %r8d
bzhiq	%r8, %rcx, %r11
cmpl	$0x40, %esi
cmovbq	%r11, %rcx
cmovbq	%rax, %r11
kmovq	%rcx, %k1
kmovq	%r11, %k2
vmovdqu8	(%rdi), %zmm0 {%k1} {z}
vmovdqu8	0x40(%rdi), %zmm1 {%k2} {z}
vporq	%zmm1, %zmm0, %zmm0
vptestmb	%zmm0, %zmm0, %k1
kmovq	%k1, %rcx
orq	%rcx, %rdx
setne	%al
retq

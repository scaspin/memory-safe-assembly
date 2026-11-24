	.text
..@8.end:
mem_zero_detect_avx2:
endbr64
cmpq	$0x7f, %rsi
jbe	..@16.end
vpxor	%xmm2, %xmm2, %xmm2
vmovdqu	(%rdi), %ymm0
vpor	0x20(%rdi), %ymm0, %ymm0
vmovdqu	0x40(%rdi), %ymm1
vpor	0x60(%rdi), %ymm1, %ymm1
vpor	%ymm1, %ymm0, %ymm0
vpcmpeqb	%ymm0, %ymm2, %ymm0
vpmovmskb	%ymm0, %edx
notl	%edx
movl	%esi, %ecx
andl	$0x7f, %ecx
addq	%rcx, %rdi
xorl	%eax, %eax
shrq	$0x7, %rsi
testq	%rsi, %rsi
sete	%al
addl	%edx, %eax
jne	mem_zero_detect_avx2.return
xorl	%eax, %eax
nopl	(%rax)
..@13.end:
mem_zero_detect_avx2.mem_z_loop:
vmovdqu	(%rdi), %ymm0
vpor	0x20(%rdi), %ymm0, %ymm0
vmovdqu	0x40(%rdi), %ymm1
vpor	0x60(%rdi), %ymm1, %ymm1
addq	$0x80, %rdi
xorl	%ecx, %ecx
subq	$0x1, %rsi
setne	%cl
vpor	%ymm1, %ymm0, %ymm0
vpcmpeqb	%ymm0, %ymm2, %ymm0
vpmovmskb	%ymm0, %edx
notl	%edx
cmpl	%ecx, %edx
jb	..@13.end
mem_zero_detect_avx2.return:
xorl	%eax, %eax
testq	%rdx, %rdx
setne	%al
retq
nop
..@16.end:
mem_zero_detect_avx2.mem_z_small_block:
xorl	%edx, %edx
movzbl	%sil, %ecx
cmpl	$0x10, %esi
jb	mem_zero_detect_avx2.mem_z_small_check_zero
shrl	$0x4, %esi
xorl	%eax, %eax
mem_zero_detect_avx2.mem_z_small_block_loop:
xorl	%eax, %eax
movq	(%rdi), %rdx
orq	0x8(%rdi), %rdx
subl	$0x1, %esi
setne	%al
addq	$0x10, %rdi
cmpq	%rax, %rdx
jb	mem_zero_detect_avx2.mem_z_small_block_loop
testq	%rdx, %rdx
jne	mem_zero_detect_avx2.return_small
movzbl	%cl, %esi
mem_zero_detect_avx2.mem_z_small_check_zero:
xorl	%edx, %edx
andl	$0xf, %esi
je	mem_zero_detect_avx2.return_small
mem_zero_detect_avx2.mem_z_small_byte_loop:
movzbl	(%rdi), %eax
addq	$0x1, %rdi
orl	%eax, %edx
subl	$0x1, %esi
jne	mem_zero_detect_avx2.mem_z_small_byte_loop
mem_zero_detect_avx2.return_small:
xorl	%eax, %eax
testq	%rdx, %rdx
setne	%al
retq

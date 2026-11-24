	.text
slide_hash_avx2:
movl	0x40(%rdi), %eax
movzwl	%ax, %eax
vmovd	%eax, %xmm0
vpbroadcastw	%xmm0, %ymm0
movl	$0x1ffe0, %ecx
addq	0x68(%rdi), %rcx
movl	$0xffff0000, %edx
nopl	(%rax)
L_20:
vmovdqa	-0x60(%rcx), %ymm1
vmovdqa	-0x40(%rcx), %ymm2
vmovdqa	-0x20(%rcx), %ymm3
vmovdqa	(%rcx), %ymm4
vpsubusw	%ymm0, %ymm4, %ymm4
vmovdqa	%ymm4, (%rcx)
vpsubusw	%ymm0, %ymm3, %ymm3
vmovdqa	%ymm3, -0x20(%rcx)
vpsubusw	%ymm0, %ymm2, %ymm2
vmovdqa	%ymm2, -0x40(%rcx)
vpsubusw	%ymm0, %ymm1, %ymm1
vmovdqa	%ymm1, -0x60(%rcx)
addq	$-0x80, %rcx
addl	$0x40, %edx
jne	L_20
leal	(%rax,%rax), %ecx
addq	0x60(%rdi), %rcx
leal	-0x10(%rax), %edx
movl	%edx, %esi
notl	%esi
testb	$0x30, %sil
je	L_a6
movl	%edx, %esi
shrl	$0x4, %esi
incl	%esi
andl	$0x3, %esi
movl	%esi, %edi
shll	$0x4, %edi
subl	%edi, %eax
nopw	%cs:(%rax,%rax)
L_90:
vmovdqa	-0x20(%rcx), %ymm1
vpsubusw	%ymm0, %ymm1, %ymm1
vmovdqa	%ymm1, -0x20(%rcx)
addq	$-0x20, %rcx
decl	%esi
jne	L_90
L_a6:
cmpl	$0x30, %edx
jb	L_ef
addq	$-0x20, %rcx
nop
L_b0:
vmovdqa	-0x60(%rcx), %ymm1
vmovdqa	-0x40(%rcx), %ymm2
vmovdqa	-0x20(%rcx), %ymm3
vmovdqa	(%rcx), %ymm4
vpsubusw	%ymm0, %ymm4, %ymm4
vmovdqa	%ymm4, (%rcx)
vpsubusw	%ymm0, %ymm3, %ymm3
vmovdqa	%ymm3, -0x20(%rcx)
vpsubusw	%ymm0, %ymm2, %ymm2
vmovdqa	%ymm2, -0x40(%rcx)
vpsubusw	%ymm0, %ymm1, %ymm1
vmovdqa	%ymm1, -0x60(%rcx)
addq	$-0x80, %rcx
addl	$-0x40, %eax
jne	L_b0
L_ef:
vzeroupper
retq

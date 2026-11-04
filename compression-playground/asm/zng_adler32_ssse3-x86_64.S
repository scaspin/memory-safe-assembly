	.text
adler32_ssse3:
pushq	%rbx
movzwl	%di, %ecx
movl	%edi, %eax
shrl	$0x10, %eax
cmpq	$0x1, %rdx
je	L_f6
testq	%rsi, %rsi
je	L_124
cmpq	$0xf, %rdx
jbe	L_12b
movl	%esi, %r8d
movl	$0x15b0, %edi
andl	$0xf, %r8d
je	L_1a5
movl	$0x20, %edi
subq	%r8, %rdi
cmpq	%rdi, %rdx
jae	L_5f
addq	$-0x10, %rdx
movd	%ecx, %xmm2
movd	%eax, %xmm0
pxor	%xmm1, %xmm1
xorl	%edi, %edi
movq	%rdx, %r8
jmp	L_398
L_5f:
movl	$0x10, %edi
subq	%r8, %rdi
movl	%r8d, %r10d
xorl	$0xf, %r10d
movl	%edi, %r9d
andl	$0x3, %r9d
cmpl	$0x3, %r10d
jae	L_80
movq	%rsi, %r10
jmp	L_bd
L_80:
movl	%edi, %r11d
andl	$-0x4, %r11d
movq	%rsi, %r10
nopw	(%rax,%rax)
L_90:
movzbl	(%r10), %ebx
addl	%ecx, %ebx
addl	%ebx, %eax
movzbl	0x1(%r10), %ecx
addl	%ebx, %ecx
addl	%ecx, %eax
movzbl	0x2(%r10), %ebx
addl	%ecx, %ebx
addl	%ebx, %eax
movzbl	0x3(%r10), %ecx
addq	$0x4, %r10
addl	%ebx, %ecx
addl	%ecx, %eax
addq	$-0x4, %r11
jne	L_90
L_bd:
testq	%r9, %r9
je	L_e1
xorl	%r11d, %r11d
nopw	%cs:(%rax,%rax)
L_d0:
movzbl	(%r10,%r11), %ebx
addl	%ebx, %ecx
addl	%ecx, %eax
incq	%r11
cmpq	%r11, %r9
jne	L_d0
L_e1:
addq	%rdi, %rsi
subq	%rdi, %rdx
orq	$0x15a0, %r8
movq	%r8, %rdi
jmp	L_1a5
L_f6:
movzbl	(%rsi), %edx
addl	%edx, %ecx
movl	%ecx, %edx
subl	$0xfff1, %edx
cmovbl	%ecx, %edx
addl	%edx, %eax
movl	$0x80078071, %ecx
imulq	%rax, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %eax
shll	$0x10, %eax
addl	%edx, %eax
popq	%rbx
retq
L_124:
movl	$0x1, %eax
popq	%rbx
retq
L_12b:
testq	%rdx, %rdx
je	L_364
movq	%rdx, %rdi
andq	$0x3, %rdi
je	L_15d
xorl	%r8d, %r8d
L_140:
movzbl	(%rsi,%r8), %r9d
addl	%r9d, %ecx
addl	%ecx, %eax
incq	%r8
cmpq	%r8, %rdi
jne	L_140
movq	%rdx, %rdi
subq	%r8, %rdi
addq	%r8, %rsi
jmp	L_160
L_15d:
movq	%rdx, %rdi
L_160:
cmpq	$0x4, %rdx
jb	L_364
xorl	%edx, %edx
L_16c:
movzbl	(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x1(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
movzbl	0x2(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x3(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
addq	$0x4, %rdx
cmpq	%rdx, %rdi
jne	L_16c
jmp	L_364
L_1a5:
cmpq	$0x10, %rdx
jb	L_2e2
movd	%ecx, %xmm2
movd	%eax, %xmm3
cmpq	%rdi, %rdx
cmovbq	%rdx, %rdi
andq	$-0x10, %rdi
movq	%rdx, %r8
subq	%rdi, %r8
pxor	%xmm1, %xmm1
cmpq	$0x20, %rdx
jb	L_267
pxor	%xmm5, %xmm5
movdqa	.LCPI0_0(%rip), %xmm6
movdqa	.LCPI0_1(%rip), %xmm7
movdqa	.LCPI0_2(%rip), %xmm8
pxor	%xmm4, %xmm4
pxor	%xmm0, %xmm0
nopl	(%rax,%rax)
L_200:
movdqa	%xmm2, %xmm9
movdqa	(%rsi), %xmm10
movdqa	0x10(%rsi), %xmm11
addq	$0x20, %rsi
addq	$-0x20, %rdi
movdqa	%xmm10, %xmm2
psadbw	%xmm5, %xmm2
movdqa	%xmm11, %xmm12
psadbw	%xmm5, %xmm12
paddd	%xmm9, %xmm2
paddd	%xmm12, %xmm2
paddd	%xmm9, %xmm0
pmaddubsw	%xmm6, %xmm10
pmaddwd	%xmm7, %xmm10
paddd	%xmm10, %xmm3
pmaddubsw	%xmm8, %xmm11
pmaddwd	%xmm7, %xmm11
paddd	%xmm11, %xmm4
cmpq	$0x1f, %rdi
ja	L_200
pslld	$0x5, %xmm0
jmp	L_26f
L_267:
pxor	%xmm0, %xmm0
pxor	%xmm4, %xmm4
L_26f:
paddd	%xmm4, %xmm0
paddd	%xmm3, %xmm0
cmpq	$0x10, %rdi
jae	L_394
L_281:
pslld	$0x4, %xmm1
paddd	%xmm1, %xmm0
pshufd	$0xee, %xmm2, %xmm1
paddd	%xmm2, %xmm1
movd	%xmm1, %ecx
movl	$0x80078071, %edx
movq	%rcx, %rax
imulq	%rdx, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %ecx
pshufd	$0xee, %xmm0, %xmm1
paddd	%xmm0, %xmm1
pshufd	$0x55, %xmm1, %xmm0
paddd	%xmm1, %xmm0
movd	%xmm0, %eax
imulq	%rax, %rdx
shrq	$0x2f, %rdx
imull	$0xfff1, %edx, %edx
subl	%edx, %eax
movq	%r8, %rdx
movl	$0x15b0, %edi
jmp	L_1a5
L_2e2:
testq	%rdx, %rdx
je	L_364
movq	%rdx, %rdi
andq	$0x3, %rdi
je	L_323
xorl	%r8d, %r8d
nopw	%cs:(%rax,%rax)
L_300:
movzbl	(%rsi,%r8), %r9d
addl	%r9d, %ecx
addl	%ecx, %eax
incq	%r8
cmpq	%r8, %rdi
jne	L_300
movq	%rdx, %rdi
subq	%r8, %rdi
addq	%r8, %rsi
cmpq	$0x4, %rdx
jae	L_32c
jmp	L_364
L_323:
movq	%rdx, %rdi
cmpq	$0x4, %rdx
jb	L_364
L_32c:
xorl	%edx, %edx
nop
L_330:
movzbl	(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x1(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
movzbl	0x2(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x3(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
addq	$0x4, %rdx
cmpq	%rdx, %rdi
jne	L_330
L_364:
movl	%ecx, %edx
movl	$0x80078071, %esi
imulq	%rsi, %rdx
shrq	$0x2f, %rdx
imull	$0xfff1, %edx, %edx
subl	%edx, %ecx
movl	%eax, %edx
imulq	%rsi, %rdx
shrq	$0x2f, %rdx
imull	$0xfff1, %edx, %edx
subl	%edx, %eax
shll	$0x10, %eax
orl	%ecx, %eax
popq	%rbx
retq
L_394:
addq	$-0x10, %rdi
L_398:
movdqu	(%rsi), %xmm3
addq	$0x10, %rsi
pxor	%xmm4, %xmm4
psadbw	%xmm3, %xmm4
paddd	%xmm2, %xmm4
paddd	%xmm2, %xmm1
pmaddubsw	.LCPI0_2(%rip), %xmm3
pmaddwd	.LCPI0_1(%rip), %xmm3
paddd	%xmm3, %xmm0
movdqa	%xmm4, %xmm2
cmpq	$0x10, %rdi
jb	L_281
jmp	L_394
	.section .rodata.cst16
.LCPI0_0:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
.LCPI0_1:
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
.LCPI0_2:
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1

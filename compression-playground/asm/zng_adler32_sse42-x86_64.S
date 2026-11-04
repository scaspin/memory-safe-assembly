	.text
adler32_fold_copy_sse42:
movzwl	%di, %r9d
movl	%edi, %eax
shrl	$0x10, %eax
pxor	%xmm0, %xmm0
movdqa	.LCPI0_0(%rip), %xmm1
movdqa	.LCPI0_1(%rip), %xmm2
pmovsxbw	.LCPI0_3(%rip), %xmm3
movl	$0x80078071, %edi
jmp	L_39
nopl	(%rax)
L_30:
testq	%rcx, %rcx
je	L_29b
L_39:
cmpq	$0x10, %rcx
jae	L_bf
jmp	L_256
nopl	(%rax,%rax)
L_50:
movdqa	%xmm6, %xmm5
L_54:
pslld	$0x4, %xmm5
movdqa	%xmm5, %xmm6
movdqa	%xmm7, %xmm5
L_61:
paddd	%xmm4, %xmm6
subq	%r8, %rcx
pshufd	$0xee, %xmm5, %xmm4
paddd	%xmm5, %xmm4
movd	%xmm4, %r9d
movq	%r9, %rax
imulq	%rdi, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %r9d
pshufd	$0xee, %xmm6, %xmm4
paddd	%xmm6, %xmm4
pshufd	$0x55, %xmm4, %xmm5
paddd	%xmm4, %xmm5
movd	%xmm5, %eax
movq	%rax, %r8
imulq	%rdi, %r8
shrq	$0x2f, %r8
imull	$0xfff1, %r8d, %r8d
subl	%r8d, %eax
cmpq	$0xf, %rcx
jbe	L_30
L_bf:
cmpq	$0x15b0, %rcx
movl	$0x15b0, %r8d
cmovbq	%rcx, %r8
andl	$0x1ff0, %r8d
movd	%r9d, %xmm5
movd	%eax, %xmm4
cmpq	$0x20, %rcx
jb	L_190
pxor	%xmm6, %xmm6
movq	%r8, %rax
pxor	%xmm7, %xmm7
nopw	%cs:(%rax,%rax)
L_100:
movdqa	%xmm5, %xmm8
movdqu	(%rdx), %xmm9
movdqu	0x10(%rdx), %xmm10
addq	$0x20, %rdx
addq	$-0x20, %rax
movdqa	%xmm9, %xmm5
psadbw	%xmm0, %xmm5
movdqa	%xmm10, %xmm11
psadbw	%xmm0, %xmm11
movdqu	%xmm9, (%rsi)
movdqu	%xmm10, 0x10(%rsi)
addq	$0x20, %rsi
pmaddubsw	%xmm1, %xmm9
pmaddubsw	%xmm2, %xmm10
paddd	%xmm8, %xmm5
paddd	%xmm11, %xmm5
paddd	%xmm8, %xmm7
pmaddwd	%xmm3, %xmm9
paddd	%xmm9, %xmm4
pmaddwd	%xmm3, %xmm10
paddd	%xmm10, %xmm6
cmpq	$0x1f, %rax
ja	L_100
pslld	$0x5, %xmm7
paddd	%xmm7, %xmm4
paddd	%xmm6, %xmm4
testq	%rax, %rax
jne	L_193
pxor	%xmm6, %xmm6
jmp	L_61
nopw	(%rax,%rax)
L_190:
movq	%r8, %rax
L_193:
leaq	-0x10(%rax), %r9
pxor	%xmm6, %xmm6
testb	$0x10, %r9b
jne	L_1e0
movdqu	(%rdx), %xmm7
addq	$0x10, %rdx
movdqa	%xmm7, %xmm6
movdqu	%xmm7, (%rsi)
psadbw	%xmm0, %xmm7
pmaddubsw	%xmm2, %xmm6
paddd	%xmm5, %xmm7
pmaddwd	%xmm3, %xmm6
paddd	%xmm6, %xmm4
addq	$0x10, %rsi
movq	%r9, %rax
movdqa	%xmm5, %xmm6
cmpq	$0x10, %r9
jae	L_1f0
jmp	L_54
nopl	(%rax)
L_1e0:
movdqa	%xmm5, %xmm7
cmpq	$0x10, %r9
jb	L_54
nop
L_1f0:
movdqu	(%rdx), %xmm8
movdqa	%xmm8, %xmm5
movdqu	%xmm8, (%rsi)
psadbw	%xmm0, %xmm8
pmaddubsw	%xmm2, %xmm5
paddd	%xmm7, %xmm8
paddd	%xmm7, %xmm6
pmaddwd	%xmm3, %xmm5
paddd	%xmm4, %xmm5
movdqu	0x10(%rdx), %xmm7
addq	$0x20, %rdx
movdqu	%xmm7, 0x10(%rsi)
addq	$0x20, %rsi
movdqa	%xmm7, %xmm4
psadbw	%xmm0, %xmm7
pmaddubsw	%xmm2, %xmm4
paddd	%xmm8, %xmm7
paddd	%xmm8, %xmm6
pmaddwd	%xmm3, %xmm4
paddd	%xmm5, %xmm4
addq	$-0x20, %rax
jne	L_1f0
jmp	L_50
L_256:
testq	%rcx, %rcx
je	L_2fb
movq	%rcx, %rdi
andq	$0x3, %rdi
je	L_2a5
xorl	%r8d, %r8d
nopl	(%rax,%rax)
L_270:
movzbl	(%rdx,%r8), %r10d
movb	%r10b, (%rsi,%r8)
addl	%r10d, %r9d
addl	%r9d, %eax
incq	%r8
cmpq	%r8, %rdi
jne	L_270
movq	%rcx, %rdi
subq	%r8, %rdi
addq	%r8, %rsi
addq	%r8, %rdx
cmpq	$0x4, %rcx
jae	L_2ae
jmp	L_2fb
L_29b:
shll	$0x10, %eax
orl	%eax, %r9d
movl	%r9d, %eax
retq
L_2a5:
movq	%rcx, %rdi
cmpq	$0x4, %rcx
jb	L_2fb
L_2ae:
xorl	%ecx, %ecx
L_2b0:
movzbl	(%rdx,%rcx), %r8d
movb	%r8b, (%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
movzbl	0x1(%rdx,%rcx), %r8d
movb	%r8b, 0x1(%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
movzbl	0x2(%rdx,%rcx), %r8d
movb	%r8b, 0x2(%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
movzbl	0x3(%rdx,%rcx), %r8d
movb	%r8b, 0x3(%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
addq	$0x4, %rcx
cmpq	%rcx, %rdi
jne	L_2b0
L_2fb:
movl	%r9d, %ecx
movl	$0x80078071, %edx
imulq	%rdx, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %r9d
movl	%eax, %ecx
imulq	%rdx, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %eax
shll	$0x10, %eax
orl	%r9d, %eax
retq
	.section .rodata.cst16
.LCPI0_0:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
.LCPI0_1:
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.section .rodata.cst8
.LCPI0_3:
	.byte 1,1,1,1,1,1,1,1

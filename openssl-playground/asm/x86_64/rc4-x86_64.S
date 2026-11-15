	.text
RC4:
endbr64
orq	%rsi, %rsi
jne	L_b
rep	retq
L_b:
pushq	%rbx
pushq	%r12
pushq	%r13
movq	%rsi, %r11
movq	%rdx, %r12
movq	%rcx, %r13
xorq	%r10, %r10
xorq	%rcx, %rcx
leaq	0x8(%rdi), %rdi
movb	-0x8(%rdi), %r10b
movb	-0x4(%rdi), %cl
cmpl	$-0x1, 0x100(%rdi)
je	L_460
movl	OPENSSL_ia32cap_P(%rip), %r8d
xorq	%rbx, %rbx
incb	%r10b
subq	%r10, %rbx
subq	%r12, %r13
movl	(%rdi,%r10,4), %eax
testq	$-0x10, %r11
je	L_430
btl	$0x1e, %r8d
jb	L_1c0
andq	$0x7, %rbx
leaq	0x1(%r10), %rsi
je	L_b0
subq	%rbx, %r11
L_73:
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	%edx, (%rdi,%r10,4)
addb	%dl, %al
incb	%r10b
movl	(%rdi,%rax,4), %edx
movl	(%rdi,%r10,4), %eax
xorb	(%r12), %dl
movb	%dl, (%r12,%r13)
leaq	0x1(%r12), %r12
decq	%rbx
jne	L_73
leaq	0x1(%r10), %rsi
jmp	L_b0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_b0:
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	(%rdi,%rsi,4), %ebx
rorq	$0x8, %r8
movl	%edx, (%rdi,%r10,4)
addb	%al, %dl
movb	(%rdi,%rdx,4), %r8b
addb	%bl, %cl
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
movl	0x4(%rdi,%rsi,4), %eax
rorq	$0x8, %r8
movl	%edx, 0x4(%rdi,%r10,4)
addb	%bl, %dl
movb	(%rdi,%rdx,4), %r8b
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	0x8(%rdi,%rsi,4), %ebx
rorq	$0x8, %r8
movl	%edx, 0x8(%rdi,%r10,4)
addb	%al, %dl
movb	(%rdi,%rdx,4), %r8b
addb	%bl, %cl
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
movl	0xc(%rdi,%rsi,4), %eax
rorq	$0x8, %r8
movl	%edx, 0xc(%rdi,%r10,4)
addb	%bl, %dl
movb	(%rdi,%rdx,4), %r8b
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	0x10(%rdi,%rsi,4), %ebx
rorq	$0x8, %r8
movl	%edx, 0x10(%rdi,%r10,4)
addb	%al, %dl
movb	(%rdi,%rdx,4), %r8b
addb	%bl, %cl
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
movl	0x14(%rdi,%rsi,4), %eax
rorq	$0x8, %r8
movl	%edx, 0x14(%rdi,%r10,4)
addb	%bl, %dl
movb	(%rdi,%rdx,4), %r8b
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	0x18(%rdi,%rsi,4), %ebx
rorq	$0x8, %r8
movl	%edx, 0x18(%rdi,%r10,4)
addb	%al, %dl
movb	(%rdi,%rdx,4), %r8b
addb	$0x8, %sil
addb	%bl, %cl
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
movl	-0x4(%rdi,%rsi,4), %eax
rorq	$0x8, %r8
movl	%edx, 0x1c(%rdi,%r10,4)
addb	%bl, %dl
movb	(%rdi,%rdx,4), %r8b
addb	$0x8, %r10b
rorq	$0x8, %r8
subq	$0x8, %r11
xorq	(%r12), %r8
movq	%r8, (%r12,%r13)
leaq	0x8(%r12), %r12
testq	$-0x8, %r11
jne	L_b0
cmpq	$0x0, %r11
jne	L_430
jmp	L_650
nop
L_1c0:
testq	$-0x20, %r11
je	L_430
andq	$0xf, %rbx
je	L_208
subq	%rbx, %r11
L_1d6:
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	%edx, (%rdi,%r10,4)
addb	%dl, %al
incb	%r10b
movl	(%rdi,%rax,4), %edx
movl	(%rdi,%r10,4), %eax
xorb	(%r12), %dl
movb	%dl, (%r12,%r13)
leaq	0x1(%r12), %r12
decq	%rbx
jne	L_1d6
movq	%rcx, %rbx
xorq	%rcx, %rcx
movb	%bl, %cl
L_208:
leaq	(%rdi,%r10,4), %rsi
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
pxor	%xmm0, %xmm0
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x4(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, (%rsi)
addb	%bl, %cl
pinsrw	$0x0, (%rdi,%rax,4), %xmm0
jmp	L_266
nopl	(%rax)
L_230:
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
pxor	%xmm0, %xmm2
psllq	$0x8, %xmm1
pxor	%xmm0, %xmm0
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x4(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, (%rsi)
pxor	%xmm1, %xmm2
addb	%bl, %cl
pinsrw	$0x0, (%rdi,%rax,4), %xmm0
movdqu	%xmm2, (%r12,%r13)
leaq	0x10(%r12), %r12
L_266:
movl	(%rdi,%rcx,4), %edx
pxor	%xmm1, %xmm1
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x8(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0x4(%rsi)
addb	%al, %cl
pinsrw	$0x0, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0xc(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x8(%rsi)
addb	%bl, %cl
pinsrw	$0x1, (%rdi,%rax,4), %xmm0
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x10(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0xc(%rsi)
addb	%al, %cl
pinsrw	$0x1, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x14(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x10(%rsi)
addb	%bl, %cl
pinsrw	$0x2, (%rdi,%rax,4), %xmm0
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x18(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0x14(%rsi)
addb	%al, %cl
pinsrw	$0x2, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x1c(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x18(%rsi)
addb	%bl, %cl
pinsrw	$0x3, (%rdi,%rax,4), %xmm0
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x20(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0x1c(%rsi)
addb	%al, %cl
pinsrw	$0x3, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x24(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x20(%rsi)
addb	%bl, %cl
pinsrw	$0x4, (%rdi,%rax,4), %xmm0
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x28(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0x24(%rsi)
addb	%al, %cl
pinsrw	$0x4, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x2c(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x28(%rsi)
addb	%bl, %cl
pinsrw	$0x5, (%rdi,%rax,4), %xmm0
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x30(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0x2c(%rsi)
addb	%al, %cl
pinsrw	$0x5, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x34(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x30(%rsi)
addb	%bl, %cl
pinsrw	$0x6, (%rdi,%rax,4), %xmm0
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movl	0x38(%rsi), %eax
movzbl	%bl, %ebx
movl	%edx, 0x34(%rsi)
addb	%al, %cl
pinsrw	$0x6, (%rdi,%rbx,4), %xmm1
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
addb	%dl, %al
movl	0x3c(%rsi), %ebx
movzbl	%al, %eax
movl	%edx, 0x38(%rsi)
addb	%bl, %cl
pinsrw	$0x7, (%rdi,%rax,4), %xmm0
addb	$0x10, %r10b
movdqu	(%r12), %xmm2
movl	(%rdi,%rcx,4), %edx
movl	%ebx, (%rdi,%rcx,4)
addb	%dl, %bl
movzbl	%bl, %ebx
movl	%edx, 0x3c(%rsi)
leaq	(%rdi,%r10,4), %rsi
pinsrw	$0x7, (%rdi,%rbx,4), %xmm1
movl	(%rsi), %eax
movq	%rcx, %rbx
xorq	%rcx, %rcx
subq	$0x10, %r11
movb	%bl, %cl
testq	$-0x10, %r11
jne	L_230
psllq	$0x8, %xmm1
pxor	%xmm0, %xmm2
pxor	%xmm1, %xmm2
movdqu	%xmm2, (%r12,%r13)
leaq	0x10(%r12), %r12
cmpq	$0x0, %r11
jne	L_430
jmp	L_650
nopl	(%rax,%rax)
L_430:
addb	%al, %cl
movl	(%rdi,%rcx,4), %edx
movl	%eax, (%rdi,%rcx,4)
movl	%edx, (%rdi,%r10,4)
addb	%dl, %al
incb	%r10b
movl	(%rdi,%rax,4), %edx
movl	(%rdi,%r10,4), %eax
xorb	(%r12), %dl
movb	%dl, (%r12,%r13)
leaq	0x1(%r12), %r12
decq	%r11
jne	L_430
jmp	L_650
nop
L_460:
addb	$0x1, %r10b
movzbl	(%rdi,%r10), %eax
testq	$-0x8, %r11
je	L_610
jmp	L_480
nopl	(%rax,%rax)
L_480:
movl	(%r12), %r8d
movl	0x4(%r12), %r9d
addb	%al, %cl
leaq	0x1(%r10), %rsi
movzbl	(%rdi,%rcx), %edx
movzbl	%sil, %esi
movzbl	(%rdi,%rsi), %ebx
movb	%al, (%rdi,%rcx)
cmpq	%rsi, %rcx
movb	%dl, (%rdi,%r10)
jne	L_4aa
movq	%rax, %rbx
L_4aa:
addb	%al, %dl
xorb	(%rdi,%rdx), %r8b
rorl	$0x8, %r8d
addb	%bl, %cl
leaq	0x1(%rsi), %r10
movzbl	(%rdi,%rcx), %edx
movzbl	%r10b, %r10d
movzbl	(%rdi,%r10), %eax
movb	%bl, (%rdi,%rcx)
cmpq	%r10, %rcx
movb	%dl, (%rdi,%rsi)
jne	L_4d5
movq	%rbx, %rax
L_4d5:
addb	%bl, %dl
xorb	(%rdi,%rdx), %r8b
rorl	$0x8, %r8d
addb	%al, %cl
leaq	0x1(%r10), %rsi
movzbl	(%rdi,%rcx), %edx
movzbl	%sil, %esi
movzbl	(%rdi,%rsi), %ebx
movb	%al, (%rdi,%rcx)
cmpq	%rsi, %rcx
movb	%dl, (%rdi,%r10)
jne	L_500
movq	%rax, %rbx
L_500:
addb	%al, %dl
xorb	(%rdi,%rdx), %r8b
rorl	$0x8, %r8d
addb	%bl, %cl
leaq	0x1(%rsi), %r10
movzbl	(%rdi,%rcx), %edx
movzbl	%r10b, %r10d
movzbl	(%rdi,%r10), %eax
movb	%bl, (%rdi,%rcx)
cmpq	%r10, %rcx
movb	%dl, (%rdi,%rsi)
jne	L_52b
movq	%rbx, %rax
L_52b:
addb	%bl, %dl
xorb	(%rdi,%rdx), %r8b
rorl	$0x8, %r8d
addb	%al, %cl
leaq	0x1(%r10), %rsi
movzbl	(%rdi,%rcx), %edx
movzbl	%sil, %esi
movzbl	(%rdi,%rsi), %ebx
movb	%al, (%rdi,%rcx)
cmpq	%rsi, %rcx
movb	%dl, (%rdi,%r10)
jne	L_556
movq	%rax, %rbx
L_556:
addb	%al, %dl
xorb	(%rdi,%rdx), %r9b
rorl	$0x8, %r9d
addb	%bl, %cl
leaq	0x1(%rsi), %r10
movzbl	(%rdi,%rcx), %edx
movzbl	%r10b, %r10d
movzbl	(%rdi,%r10), %eax
movb	%bl, (%rdi,%rcx)
cmpq	%r10, %rcx
movb	%dl, (%rdi,%rsi)
jne	L_581
movq	%rbx, %rax
L_581:
addb	%bl, %dl
xorb	(%rdi,%rdx), %r9b
rorl	$0x8, %r9d
addb	%al, %cl
leaq	0x1(%r10), %rsi
movzbl	(%rdi,%rcx), %edx
movzbl	%sil, %esi
movzbl	(%rdi,%rsi), %ebx
movb	%al, (%rdi,%rcx)
cmpq	%rsi, %rcx
movb	%dl, (%rdi,%r10)
jne	L_5ac
movq	%rax, %rbx
L_5ac:
addb	%al, %dl
xorb	(%rdi,%rdx), %r9b
rorl	$0x8, %r9d
addb	%bl, %cl
leaq	0x1(%rsi), %r10
movzbl	(%rdi,%rcx), %edx
movzbl	%r10b, %r10d
movzbl	(%rdi,%r10), %eax
movb	%bl, (%rdi,%rcx)
cmpq	%r10, %rcx
movb	%dl, (%rdi,%rsi)
jne	L_5d7
movq	%rbx, %rax
L_5d7:
addb	%bl, %dl
xorb	(%rdi,%rdx), %r9b
rorl	$0x8, %r9d
leaq	-0x8(%r11), %r11
movl	%r8d, (%r13)
leaq	0x8(%r12), %r12
movl	%r9d, 0x4(%r13)
leaq	0x8(%r13), %r13
testq	$-0x8, %r11
jne	L_480
cmpq	$0x0, %r11
jne	L_610
jmp	L_650
nopl	(%rax,%rax)
L_610:
addb	%al, %cl
movzbl	%cl, %ecx
movzbl	(%rdi,%rcx), %edx
movb	%al, (%rdi,%rcx)
movb	%dl, (%rdi,%r10)
addb	%al, %dl
addb	$0x1, %r10b
movzbl	%dl, %edx
movzbl	%r10b, %r10d
movzbl	(%rdi,%rdx), %edx
movzbl	(%rdi,%r10), %eax
xorb	(%r12), %dl
leaq	0x1(%r12), %r12
movb	%dl, (%r13)
leaq	0x1(%r13), %r13
subq	$0x1, %r11
jne	L_610
jmp	L_650
nop
L_650:
subb	$0x1, %r10b
movl	%r10d, -0x8(%rdi)
movl	%ecx, -0x4(%rdi)
movq	(%rsp), %r13
movq	0x8(%rsp), %r12
movq	0x10(%rsp), %rbx
addq	$0x18, %rsp
rep	retq
nop
RC4_set_key:
endbr64
leaq	0x8(%rdi), %rdi
leaq	(%rdx,%rsi), %rdx
negq	%rsi
movq	%rsi, %rcx
xorl	%eax, %eax
xorq	%r9, %r9
xorq	%r10, %r10
xorq	%r11, %r11
movl	OPENSSL_ia32cap_P(%rip), %r8d
btl	$0x14, %r8d
jb	L_6e0
jmp	L_6a0
nopl	(%rax)
L_6a0:
movl	%eax, (%rdi,%rax,4)
addb	$0x1, %al
jae	L_6a0
xorq	%r9, %r9
xorq	%r8, %r8
nopl	(%rax)
L_6b0:
movl	(%rdi,%r9,4), %r10d
addb	(%rdx,%rsi), %r8b
addb	%r10b, %r8b
addq	$0x1, %rsi
movl	(%rdi,%r8,4), %r11d
cmoveq	%rcx, %rsi
movl	%r10d, (%rdi,%r8,4)
movl	%r11d, (%rdi,%r9,4)
addb	$0x1, %r9b
jae	L_6b0
jmp	L_720
nopw	(%rax,%rax)
L_6e0:
movb	%al, (%rdi,%rax)
addb	$0x1, %al
jae	L_6e0
xorq	%r9, %r9
xorq	%r8, %r8
nopl	(%rax)
L_6f0:
movb	(%rdi,%r9), %r10b
addb	(%rdx,%rsi), %r8b
addb	%r10b, %r8b
addq	$0x1, %rsi
movb	(%rdi,%r8), %r11b
jne	L_708
movq	%rcx, %rsi
L_708:
movb	%r10b, (%rdi,%r8)
movb	%r11b, (%rdi,%r9)
addb	$0x1, %r9b
jae	L_6f0
movl	$0xffffffff, 0x100(%rdi)
L_720:
xorl	%eax, %eax
movl	%eax, -0x8(%rdi)
movl	%eax, -0x4(%rdi)
rep	retq
nopw	OPENSSL_ia32cap_P
	.section .rodata_in_text
RC4_options:
	.size RC4_options, 208
	.byte 243,15,30,250,72,141,5,69,0,0,0,139,21,0,0,0
	.byte 0,15,186,226,20,114,12,15,186,226,30,115,10,72,131,192
	.byte 25,243,195,72,131,192,12,243,195,102,46,15,31,132,0,0
	.byte 0,0,0,102,46,15,31,132,0,0,0,0,0,102,46,15
	.byte 31,132,0,0,0,0,0,102,15,31,132,0,0,0,0,0
	.byte 114,99,52,40,56,120,44,105,110,116,41,0,114,99,52,40
	.byte 56,120,44,99,104,97,114,41,0,114,99,52,40,49,54,120
	.byte 44,105,110,116,41,0,82,67,52,32,102,111,114,32,120,56
	.byte 54,95,54,52,44,32,67,82,89,80,84,79,71,65,77,83
	.byte 32,98,121,32,60,104,116,116,112,115,58,47,47,103,105,116
	.byte 104,117,98,46,99,111,109,47,100,111,116,45,97,115,109,62
	.byte 0,102,46,15,31,132,0,0,0,0,0,102,46,15,31,132
	.byte 0,0,0,0,0,102,46,15,31,132,0,0,0,0,0,144

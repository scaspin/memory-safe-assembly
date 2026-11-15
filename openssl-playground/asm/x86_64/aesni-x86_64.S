	.text
aesni_encrypt:
endbr64
movups	(%rdi), %xmm2
movl	0xf0(%rdx), %eax
movups	(%rdx), %xmm0
movups	0x10(%rdx), %xmm1
leaq	0x20(%rdx), %rdx
xorps	%xmm0, %xmm2
L_1b:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%rdx), %xmm1
leaq	0x10(%rdx), %rdx
jne	L_1b
aesenclast	%xmm1, %xmm2
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
aesni_decrypt:
endbr64
movups	(%rdi), %xmm2
movl	0xf0(%rdx), %eax
movups	(%rdx), %xmm0
movups	0x10(%rdx), %xmm1
leaq	0x20(%rdx), %rdx
xorps	%xmm0, %xmm2
L_6b:
aesdec	%xmm1, %xmm2
decl	%eax
movups	(%rdx), %xmm1
leaq	0x10(%rdx), %rdx
jne	L_6b
aesdeclast	%xmm1, %xmm2
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
_aesni_encrypt2:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
movups	0x20(%rcx), %xmm0
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
addq	$0x10, %rax
L_c0:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
movups	-0x10(%rcx,%rax), %xmm0
jne	L_c0
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
rep	retq
nopl	(%rax)
_aesni_decrypt2:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
movups	0x20(%rcx), %xmm0
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
addq	$0x10, %rax
L_120:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
movups	-0x10(%rcx,%rax), %xmm0
jne	L_120
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdeclast	%xmm0, %xmm2
aesdeclast	%xmm0, %xmm3
rep	retq
nopl	(%rax)
_aesni_encrypt3:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
xorps	%xmm0, %xmm4
movups	0x20(%rcx), %xmm0
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
addq	$0x10, %rax
L_183:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
movups	-0x10(%rcx,%rax), %xmm0
jne	L_183
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
aesenclast	%xmm0, %xmm4
rep	retq
_aesni_decrypt3:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
xorps	%xmm0, %xmm4
movups	0x20(%rcx), %xmm0
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
addq	$0x10, %rax
L_1f3:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
movups	-0x10(%rcx,%rax), %xmm0
jne	L_1f3
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdeclast	%xmm0, %xmm2
aesdeclast	%xmm0, %xmm3
aesdeclast	%xmm0, %xmm4
rep	retq
_aesni_encrypt4:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
xorps	%xmm0, %xmm4
xorps	%xmm0, %xmm5
movups	0x20(%rcx), %xmm0
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
nopl	(%rax)
addq	$0x10, %rax
L_269:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	-0x10(%rcx,%rax), %xmm0
jne	L_269
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
aesenclast	%xmm0, %xmm4
aesenclast	%xmm0, %xmm5
rep	retq
nopw	(%rax,%rax)
_aesni_decrypt4:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
xorps	%xmm0, %xmm4
xorps	%xmm0, %xmm5
movups	0x20(%rcx), %xmm0
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
nopl	(%rax)
addq	$0x10, %rax
L_2f9:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	-0x10(%rcx,%rax), %xmm0
jne	L_2f9
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdeclast	%xmm0, %xmm2
aesdeclast	%xmm0, %xmm3
aesdeclast	%xmm0, %xmm4
aesdeclast	%xmm0, %xmm5
rep	retq
nopw	(%rax,%rax)
_aesni_encrypt6:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
pxor	%xmm0, %xmm3
pxor	%xmm0, %xmm4
aesenc	%xmm1, %xmm2
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
aesenc	%xmm1, %xmm3
pxor	%xmm0, %xmm5
pxor	%xmm0, %xmm6
aesenc	%xmm1, %xmm4
pxor	%xmm0, %xmm7
movups	(%rcx,%rax), %xmm0
addq	$0x10, %rax
jmp	L_3bf
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_3b0:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
L_3bf:
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
movups	-0x10(%rcx,%rax), %xmm0
jne	L_3b0
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
aesenclast	%xmm0, %xmm4
aesenclast	%xmm0, %xmm5
aesenclast	%xmm0, %xmm6
aesenclast	%xmm0, %xmm7
rep	retq
nopl	(%rax)
_aesni_decrypt6:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
pxor	%xmm0, %xmm3
pxor	%xmm0, %xmm4
aesdec	%xmm1, %xmm2
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
aesdec	%xmm1, %xmm3
pxor	%xmm0, %xmm5
pxor	%xmm0, %xmm6
aesdec	%xmm1, %xmm4
pxor	%xmm0, %xmm7
movups	(%rcx,%rax), %xmm0
addq	$0x10, %rax
jmp	L_49f
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_490:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
L_49f:
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
movups	-0x10(%rcx,%rax), %xmm0
jne	L_490
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdeclast	%xmm0, %xmm2
aesdeclast	%xmm0, %xmm3
aesdeclast	%xmm0, %xmm4
aesdeclast	%xmm0, %xmm5
aesdeclast	%xmm0, %xmm6
aesdeclast	%xmm0, %xmm7
rep	retq
nopl	(%rax)
_aesni_encrypt8:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
pxor	%xmm0, %xmm4
pxor	%xmm0, %xmm5
pxor	%xmm0, %xmm6
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
aesenc	%xmm1, %xmm2
pxor	%xmm0, %xmm7
pxor	%xmm0, %xmm8
aesenc	%xmm1, %xmm3
pxor	%xmm0, %xmm9
movups	(%rcx,%rax), %xmm0
addq	$0x10, %rax
jmp	L_57a
nopw	%cs:(%rax,%rax)
L_570:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
L_57a:
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
L_59a:
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	-0x10(%rcx,%rax), %xmm0
jne	L_570
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
aesenclast	%xmm0, %xmm4
aesenclast	%xmm0, %xmm5
aesenclast	%xmm0, %xmm6
aesenclast	%xmm0, %xmm7
aesenclast	%xmm0, %xmm8
aesenclast	%xmm0, %xmm9
rep	retq
nopl	(%rax)
_aesni_decrypt8:
movups	(%rcx), %xmm0
shll	$0x4, %eax
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm2
xorps	%xmm0, %xmm3
pxor	%xmm0, %xmm4
pxor	%xmm0, %xmm5
pxor	%xmm0, %xmm6
leaq	0x20(%rcx,%rax), %rcx
negq	%rax
aesdec	%xmm1, %xmm2
pxor	%xmm0, %xmm7
pxor	%xmm0, %xmm8
aesdec	%xmm1, %xmm3
pxor	%xmm0, %xmm9
movups	(%rcx,%rax), %xmm0
addq	$0x10, %rax
jmp	L_68a
nopw	%cs:(%rax,%rax)
L_680:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
L_68a:
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	-0x10(%rcx,%rax), %xmm0
jne	L_680
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
aesdeclast	%xmm0, %xmm2
aesdeclast	%xmm0, %xmm3
aesdeclast	%xmm0, %xmm4
aesdeclast	%xmm0, %xmm5
aesdeclast	%xmm0, %xmm6
aesdeclast	%xmm0, %xmm7
aesdeclast	%xmm0, %xmm8
aesdeclast	%xmm0, %xmm9
rep	retq
nopl	(%rax)
aesni_ecb_encrypt:
endbr64
andq	$-0x10, %rdx
je	L_c94
movl	0xf0(%rcx), %eax
movups	(%rcx), %xmm0
movq	%rcx, %r11
movl	%eax, %r10d
testl	%r8d, %r8d
je	L_9b0
cmpq	$0x80, %rdx
jb	L_857
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqu	0x20(%rdi), %xmm4
movdqu	0x30(%rdi), %xmm5
movdqu	0x40(%rdi), %xmm6
movdqu	0x50(%rdi), %xmm7
movdqu	0x60(%rdi), %xmm8
movdqu	0x70(%rdi), %xmm9
leaq	0x80(%rdi), %rdi
subq	$0x80, %rdx
jmp	L_80e
nopl	(%rax)
L_7b0:
movups	%xmm2, (%rsi)
movq	%r11, %rcx
movdqu	(%rdi), %xmm2
movl	%r10d, %eax
movups	%xmm3, 0x10(%rsi)
movdqu	0x10(%rdi), %xmm3
movups	%xmm4, 0x20(%rsi)
movdqu	0x20(%rdi), %xmm4
movups	%xmm5, 0x30(%rsi)
movdqu	0x30(%rdi), %xmm5
movups	%xmm6, 0x40(%rsi)
movdqu	0x40(%rdi), %xmm6
movups	%xmm7, 0x50(%rsi)
movdqu	0x50(%rdi), %xmm7
movups	%xmm8, 0x60(%rsi)
movdqu	0x60(%rdi), %xmm8
movups	%xmm9, 0x70(%rsi)
leaq	0x80(%rsi), %rsi
movdqu	0x70(%rdi), %xmm9
leaq	0x80(%rdi), %rdi
L_80e:
callq	_aesni_encrypt8
subq	$0x80, %rdx
jae	L_7b0
movups	%xmm2, (%rsi)
movq	%r11, %rcx
movups	%xmm3, 0x10(%rsi)
movl	%r10d, %eax
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
movups	%xmm6, 0x40(%rsi)
movups	%xmm7, 0x50(%rsi)
movups	%xmm8, 0x60(%rsi)
movups	%xmm9, 0x70(%rsi)
leaq	0x80(%rsi), %rsi
addq	$0x80, %rdx
je	L_c94
L_857:
movups	(%rdi), %xmm2
cmpq	$0x20, %rdx
jb	L_8d0
movups	0x10(%rdi), %xmm3
je	L_900
movups	0x20(%rdi), %xmm4
cmpq	$0x40, %rdx
jb	L_920
movups	0x30(%rdi), %xmm5
je	L_940
movups	0x40(%rdi), %xmm6
cmpq	$0x60, %rdx
jb	L_960
movups	0x50(%rdi), %xmm7
je	L_980
movdqu	0x60(%rdi), %xmm8
xorps	%xmm9, %xmm9
callq	_aesni_encrypt8
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
movups	%xmm6, 0x40(%rsi)
movups	%xmm7, 0x50(%rsi)
movups	%xmm8, 0x60(%rsi)
jmp	L_c94
nopw	(%rax,%rax)
L_8d0:
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_8de:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_8de
aesenclast	%xmm1, %xmm2
movups	%xmm2, (%rsi)
jmp	L_c94
nopl	(%rax,%rax)
L_900:
callq	_aesni_encrypt2
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
jmp	L_c94
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_920:
callq	_aesni_encrypt3
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
jmp	L_c94
nopw	%cs:(%rax,%rax)
nop
L_940:
callq	_aesni_encrypt4
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
jmp	L_c94
nopl	(%rax)
L_960:
xorps	%xmm7, %xmm7
callq	_aesni_encrypt6
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
movups	%xmm6, 0x40(%rsi)
jmp	L_c94
L_980:
callq	_aesni_encrypt6
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
movups	%xmm6, 0x40(%rsi)
movups	%xmm7, 0x50(%rsi)
jmp	L_c94
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_9b0:
cmpq	$0x80, %rdx
jb	L_acd
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqu	0x20(%rdi), %xmm4
movdqu	0x30(%rdi), %xmm5
movdqu	0x40(%rdi), %xmm6
movdqu	0x50(%rdi), %xmm7
movdqu	0x60(%rdi), %xmm8
movdqu	0x70(%rdi), %xmm9
leaq	0x80(%rdi), %rdi
subq	$0x80, %rdx
jmp	L_a5e
nopw	%cs:(%rax,%rax)
L_a00:
movups	%xmm2, (%rsi)
movq	%r11, %rcx
movdqu	(%rdi), %xmm2
movl	%r10d, %eax
movups	%xmm3, 0x10(%rsi)
movdqu	0x10(%rdi), %xmm3
movups	%xmm4, 0x20(%rsi)
movdqu	0x20(%rdi), %xmm4
movups	%xmm5, 0x30(%rsi)
movdqu	0x30(%rdi), %xmm5
movups	%xmm6, 0x40(%rsi)
movdqu	0x40(%rdi), %xmm6
movups	%xmm7, 0x50(%rsi)
movdqu	0x50(%rdi), %xmm7
movups	%xmm8, 0x60(%rsi)
movdqu	0x60(%rdi), %xmm8
movups	%xmm9, 0x70(%rsi)
leaq	0x80(%rsi), %rsi
movdqu	0x70(%rdi), %xmm9
leaq	0x80(%rdi), %rdi
L_a5e:
callq	_aesni_decrypt8
movups	(%r11), %xmm0
subq	$0x80, %rdx
jae	L_a00
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movq	%r11, %rcx
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movl	%r10d, %eax
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
movups	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm6
movups	%xmm7, 0x50(%rsi)
pxor	%xmm7, %xmm7
movups	%xmm8, 0x60(%rsi)
pxor	%xmm8, %xmm8
movups	%xmm9, 0x70(%rsi)
pxor	%xmm9, %xmm9
leaq	0x80(%rsi), %rsi
addq	$0x80, %rdx
je	L_c94
L_acd:
movups	(%rdi), %xmm2
cmpq	$0x20, %rdx
jb	L_b70
movups	0x10(%rdi), %xmm3
je	L_ba0
movups	0x20(%rdi), %xmm4
cmpq	$0x40, %rdx
jb	L_bc0
movups	0x30(%rdi), %xmm5
je	L_bf0
movups	0x40(%rdi), %xmm6
cmpq	$0x60, %rdx
jb	L_c20
movups	0x50(%rdi), %xmm7
je	L_c60
movups	0x60(%rdi), %xmm8
movups	(%rcx), %xmm0
xorps	%xmm9, %xmm9
callq	_aesni_decrypt8
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
movups	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm6
movups	%xmm7, 0x50(%rsi)
pxor	%xmm7, %xmm7
movups	%xmm8, 0x60(%rsi)
pxor	%xmm8, %xmm8
pxor	%xmm9, %xmm9
jmp	L_c94
nopl	(%rax,%rax)
L_b70:
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_b7e:
aesdec	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_b7e
aesdeclast	%xmm1, %xmm2
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
jmp	L_c94
nop
L_ba0:
callq	_aesni_decrypt2
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
jmp	L_c94
nopl	(%rax)
L_bc0:
callq	_aesni_decrypt3
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
jmp	L_c94
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_bf0:
callq	_aesni_decrypt4
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
jmp	L_c94
nopw	%cs:(%rax,%rax)
L_c20:
xorps	%xmm7, %xmm7
callq	_aesni_decrypt6
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
movups	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
jmp	L_c94
nopw	%cs:(%rax,%rax)
nop
L_c60:
callq	_aesni_decrypt6
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
movups	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm6
movups	%xmm7, 0x50(%rsi)
pxor	%xmm7, %xmm7
L_c94:
xorps	%xmm0, %xmm0
pxor	%xmm1, %xmm1
rep	retq
nopl	(%rax)
aesni_ccm64_encrypt_blocks:
endbr64
movl	0xf0(%rcx), %eax
movdqu	(%r8), %xmm6
movdqa	bums_rodata+32(%rip), %xmm9
movdqa	bums_rodata(%rip), %xmm7
shll	$0x4, %eax
movl	$0x10, %r10d
leaq	(%rcx), %r11
movdqu	(%r9), %xmm3
movdqa	%xmm6, %xmm2
leaq	0x20(%rcx,%rax), %rcx
pshufb	%xmm7, %xmm6
subq	%rax, %r10
jmp	L_cf0
nopw	%cs:(%rax,%rax)
nop
L_cf0:
movups	(%r11), %xmm0
movq	%r10, %rax
movups	(%rdi), %xmm8
xorps	%xmm0, %xmm2
movups	0x10(%r11), %xmm1
xorps	%xmm8, %xmm0
xorps	%xmm0, %xmm3
movups	0x20(%r11), %xmm0
L_d0f:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
movups	-0x10(%rcx,%rax), %xmm0
jne	L_d0f
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
paddq	%xmm9, %xmm6
decq	%rdx
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
leaq	0x10(%rdi), %rdi
xorps	%xmm2, %xmm8
movdqa	%xmm6, %xmm2
movups	%xmm8, (%rsi)
pshufb	%xmm7, %xmm2
leaq	0x10(%rsi), %rsi
jne	L_cf0
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
movups	%xmm3, (%r9)
pxor	%xmm3, %xmm3
pxor	%xmm8, %xmm8
pxor	%xmm6, %xmm6
rep	retq
nopl	(%rax,%rax)
aesni_ccm64_decrypt_blocks:
endbr64
movl	0xf0(%rcx), %eax
movups	(%r8), %xmm6
movdqu	(%r9), %xmm3
movdqa	bums_rodata+32(%rip), %xmm9
movdqa	bums_rodata(%rip), %xmm7
movaps	%xmm6, %xmm2
movl	%eax, %r10d
movq	%rcx, %r11
pshufb	%xmm7, %xmm6
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_dd0:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_dd0
aesenclast	%xmm1, %xmm2
shll	$0x4, %r10d
movl	$0x10, %eax
movups	(%rdi), %xmm8
paddq	%xmm9, %xmm6
leaq	0x10(%rdi), %rdi
subq	%r10, %rax
leaq	0x20(%r11,%r10), %rcx
movq	%rax, %r10
jmp	L_e10
nopl	(%rax,%rax)
L_e10:
xorps	%xmm2, %xmm8
movdqa	%xmm6, %xmm2
movups	%xmm8, (%rsi)
leaq	0x10(%rsi), %rsi
pshufb	%xmm7, %xmm2
subq	$0x1, %rdx
je	L_ea0
movups	(%r11), %xmm0
movq	%r10, %rax
movups	0x10(%r11), %xmm1
xorps	%xmm0, %xmm8
xorps	%xmm0, %xmm2
xorps	%xmm8, %xmm3
movups	0x20(%r11), %xmm0
jmp	L_e50
nopl	(%rax)
L_e50:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
movups	-0x10(%rcx,%rax), %xmm0
jne	L_e50
movups	(%rdi), %xmm8
paddq	%xmm9, %xmm6
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenclast	%xmm0, %xmm2
aesenclast	%xmm0, %xmm3
leaq	0x10(%rdi), %rdi
jmp	L_e10
nopl	(%rax)
L_ea0:
movl	0xf0(%r11), %eax
movups	(%r11), %xmm0
movups	0x10(%r11), %xmm1
xorps	%xmm0, %xmm8
leaq	0x20(%r11), %r11
xorps	%xmm8, %xmm3
L_ebc:
aesenc	%xmm1, %xmm3
decl	%eax
movups	(%r11), %xmm1
leaq	0x10(%r11), %r11
jne	L_ebc
aesenclast	%xmm1, %xmm3
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
movups	%xmm3, (%r9)
pxor	%xmm3, %xmm3
pxor	%xmm8, %xmm8
pxor	%xmm6, %xmm6
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
aesni_ctr32_encrypt_blocks:
endbr64
cmpq	$0x1, %rdx
jne	L_f60
movups	(%r8), %xmm2
movups	(%rdi), %xmm3
movl	0xf0(%rcx), %edx
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_f25:
aesenc	%xmm1, %xmm2
decl	%edx
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_f25
aesenclast	%xmm1, %xmm2
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
xorps	%xmm3, %xmm2
pxor	%xmm3, %xmm3
movups	%xmm2, (%rsi)
xorps	%xmm2, %xmm2
jmp	L_184d
nopw	%cs:(%rax,%rax)
nop
L_f60:
leaq	(%rsp), %r11
pushq	%rbp
subq	$0x80, %rsp
andq	$-0x10, %rsp
movdqu	(%r8), %xmm2
movdqu	(%rcx), %xmm0
movl	0xc(%r8), %r8d
pxor	%xmm0, %xmm2
movl	0xc(%rcx), %ebp
movdqa	%xmm2, (%rsp)
bswapl	%r8d
movdqa	%xmm2, %xmm3
movdqa	%xmm2, %xmm4
movdqa	%xmm2, %xmm5
movdqa	%xmm2, 0x40(%rsp)
movdqa	%xmm2, 0x50(%rsp)
movdqa	%xmm2, 0x60(%rsp)
movq	%rdx, %r10
movdqa	%xmm2, 0x70(%rsp)
leaq	0x1(%r8), %rax
leaq	0x2(%r8), %rdx
bswapl	%eax
bswapl	%edx
xorl	%ebp, %eax
xorl	%ebp, %edx
pinsrd	$0x3, %eax, %xmm3
leaq	0x3(%r8), %rax
movdqa	%xmm3, 0x10(%rsp)
pinsrd	$0x3, %edx, %xmm4
bswapl	%eax
movq	%r10, %rdx
leaq	0x4(%r8), %r10
movdqa	%xmm4, 0x20(%rsp)
xorl	%ebp, %eax
bswapl	%r10d
pinsrd	$0x3, %eax, %xmm5
xorl	%ebp, %r10d
movdqa	%xmm5, 0x30(%rsp)
leaq	0x5(%r8), %r9
movl	%r10d, 0x4c(%rsp)
bswapl	%r9d
leaq	0x6(%r8), %r10
movl	0xf0(%rcx), %eax
xorl	%ebp, %r9d
bswapl	%r10d
movl	%r9d, 0x5c(%rsp)
xorl	%ebp, %r10d
leaq	0x7(%r8), %r9
movl	%r10d, 0x6c(%rsp)
bswapl	%r9d
movl	OPENSSL_ia32cap_P+4(%rip), %r10d
xorl	%ebp, %r9d
andl	$0x4400000, %r10d
movl	%r9d, 0x7c(%rsp)
movups	0x10(%rcx), %xmm1
movdqa	0x40(%rsp), %xmm6
movdqa	0x50(%rsp), %xmm7
cmpq	$0x8, %rdx
jb	L_161a
subq	$0x6, %rdx
cmpl	$0x400000, %r10d
je	L_1080
leaq	0x80(%rcx), %rcx
subq	$0x2, %rdx
jmp	L_1200
nopl	(%rax)
L_1080:
shll	$0x4, %eax
movl	$0x30, %r10d
bswapl	%ebp
leaq	0x20(%rcx,%rax), %rcx
subq	%rax, %r10
jmp	L_10a0
nopw	%cs:(%rax,%rax)
nop
L_10a0:
addl	$0x6, %r8d
movups	-0x30(%rcx,%r10), %xmm0
aesenc	%xmm1, %xmm2
movl	%r8d, %eax
xorl	%ebp, %eax
aesenc	%xmm1, %xmm3
movbel	%eax, 0xc(%rsp)
leal	0x1(%r8), %eax
aesenc	%xmm1, %xmm4
xorl	%ebp, %eax
movbel	%eax, 0x1c(%rsp)
aesenc	%xmm1, %xmm5
leal	0x2(%r8), %eax
xorl	%ebp, %eax
aesenc	%xmm1, %xmm6
movbel	%eax, 0x2c(%rsp)
leal	0x3(%r8), %eax
aesenc	%xmm1, %xmm7
movups	-0x20(%rcx,%r10), %xmm1
xorl	%ebp, %eax
aesenc	%xmm0, %xmm2
movbel	%eax, 0x3c(%rsp)
leal	0x4(%r8), %eax
aesenc	%xmm0, %xmm3
xorl	%ebp, %eax
movbel	%eax, 0x4c(%rsp)
aesenc	%xmm0, %xmm4
leal	0x5(%r8), %eax
xorl	%ebp, %eax
aesenc	%xmm0, %xmm5
movbel	%eax, 0x5c(%rsp)
movq	%r10, %rax
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
movups	-0x10(%rcx,%r10), %xmm0
callq	L_3b0
movdqu	(%rdi), %xmm8
movdqu	0x10(%rdi), %xmm9
movdqu	0x20(%rdi), %xmm10
movdqu	0x30(%rdi), %xmm11
movdqu	0x40(%rdi), %xmm12
movdqu	0x50(%rdi), %xmm13
leaq	0x60(%rdi), %rdi
movups	-0x40(%rcx,%r10), %xmm1
pxor	%xmm2, %xmm8
movaps	(%rsp), %xmm2
pxor	%xmm3, %xmm9
movaps	0x10(%rsp), %xmm3
pxor	%xmm4, %xmm10
movaps	0x20(%rsp), %xmm4
pxor	%xmm5, %xmm11
movaps	0x30(%rsp), %xmm5
pxor	%xmm6, %xmm12
movaps	0x40(%rsp), %xmm6
pxor	%xmm7, %xmm13
movaps	0x50(%rsp), %xmm7
movdqu	%xmm8, (%rsi)
movdqu	%xmm9, 0x10(%rsi)
movdqu	%xmm10, 0x20(%rsi)
movdqu	%xmm11, 0x30(%rsi)
movdqu	%xmm12, 0x40(%rsi)
movdqu	%xmm13, 0x50(%rsi)
leaq	0x60(%rsi), %rsi
subq	$0x6, %rdx
jae	L_10a0
addq	$0x6, %rdx
je	L_17d6
leal	-0x30(%r10), %eax
leaq	-0x50(%rcx,%r10), %rcx
negl	%eax
shrl	$0x4, %eax
jmp	L_161a
nopw	(%rax,%rax)
L_1200:
addl	$0x8, %r8d
movdqa	0x60(%rsp), %xmm8
aesenc	%xmm1, %xmm2
movl	%r8d, %r9d
movdqa	0x70(%rsp), %xmm9
aesenc	%xmm1, %xmm3
bswapl	%r9d
movups	-0x60(%rcx), %xmm0
aesenc	%xmm1, %xmm4
xorl	%ebp, %r9d
nop
aesenc	%xmm1, %xmm5
movl	%r9d, 0xc(%rsp)
leaq	0x1(%r8), %r9
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movups	-0x50(%rcx), %xmm1
bswapl	%r9d
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
xorl	%ebp, %r9d
nop
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movl	%r9d, 0x1c(%rsp)
leaq	0x2(%r8), %r9
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	-0x40(%rcx), %xmm0
bswapl	%r9d
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
xorl	%ebp, %r9d
nop
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movl	%r9d, 0x2c(%rsp)
leaq	0x3(%r8), %r9
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movups	-0x30(%rcx), %xmm1
bswapl	%r9d
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
xorl	%ebp, %r9d
nop
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movl	%r9d, 0x3c(%rsp)
leaq	0x4(%r8), %r9
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	-0x20(%rcx), %xmm0
bswapl	%r9d
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
xorl	%ebp, %r9d
nop
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movl	%r9d, 0x4c(%rsp)
leaq	0x5(%r8), %r9
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movups	-0x10(%rcx), %xmm1
bswapl	%r9d
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
xorl	%ebp, %r9d
nop
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movl	%r9d, 0x5c(%rsp)
leaq	0x6(%r8), %r9
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	(%rcx), %xmm0
bswapl	%r9d
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
xorl	%ebp, %r9d
nop
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movl	%r9d, 0x6c(%rsp)
leaq	0x7(%r8), %r9
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movups	0x10(%rcx), %xmm1
bswapl	%r9d
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
xorl	%ebp, %r9d
movdqu	(%rdi), %xmm10
aesenc	%xmm0, %xmm5
movl	%r9d, 0x7c(%rsp)
cmpl	$0xb, %eax
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	0x20(%rcx), %xmm0
jb	L_14e0
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movups	0x30(%rcx), %xmm1
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	0x40(%rcx), %xmm0
je	L_14e0
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movups	0x50(%rcx), %xmm1
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
aesenc	%xmm0, %xmm8
aesenc	%xmm0, %xmm9
movups	0x60(%rcx), %xmm0
jmp	L_14e0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_14e0:
movdqu	0x10(%rdi), %xmm11
pxor	%xmm0, %xmm10
movdqu	0x20(%rdi), %xmm12
pxor	%xmm0, %xmm11
movdqu	0x30(%rdi), %xmm13
pxor	%xmm0, %xmm12
movdqu	0x40(%rdi), %xmm14
pxor	%xmm0, %xmm13
movdqu	0x50(%rdi), %xmm15
pxor	%xmm0, %xmm14
pxor	%xmm0, %xmm15
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
aesenc	%xmm1, %xmm9
movdqu	0x60(%rdi), %xmm1
leaq	0x80(%rdi), %rdi
aesenclast	%xmm10, %xmm2
pxor	%xmm0, %xmm1
movdqu	-0x10(%rdi), %xmm10
aesenclast	%xmm11, %xmm3
pxor	%xmm0, %xmm10
movdqa	(%rsp), %xmm11
aesenclast	%xmm12, %xmm4
aesenclast	%xmm13, %xmm5
movdqa	0x10(%rsp), %xmm12
movdqa	0x20(%rsp), %xmm13
aesenclast	%xmm14, %xmm6
aesenclast	%xmm15, %xmm7
movdqa	0x30(%rsp), %xmm14
movdqa	0x40(%rsp), %xmm15
aesenclast	%xmm1, %xmm8
movdqa	0x50(%rsp), %xmm0
movups	-0x70(%rcx), %xmm1
aesenclast	%xmm10, %xmm9
movups	%xmm2, (%rsi)
movdqa	%xmm11, %xmm2
movups	%xmm3, 0x10(%rsi)
movdqa	%xmm12, %xmm3
movups	%xmm4, 0x20(%rsi)
movdqa	%xmm13, %xmm4
movups	%xmm5, 0x30(%rsi)
movdqa	%xmm14, %xmm5
movups	%xmm6, 0x40(%rsi)
movdqa	%xmm15, %xmm6
movups	%xmm7, 0x50(%rsi)
movdqa	%xmm0, %xmm7
movups	%xmm8, 0x60(%rsi)
movups	%xmm9, 0x70(%rsi)
leaq	0x80(%rsi), %rsi
subq	$0x8, %rdx
jae	L_1200
addq	$0x8, %rdx
je	L_17d6
leaq	-0x80(%rcx), %rcx
L_161a:
leaq	0x10(%rcx), %rcx
cmpq	$0x4, %rdx
jb	L_1780
je	L_1700
shll	$0x4, %eax
movdqa	0x60(%rsp), %xmm8
pxor	%xmm9, %xmm9
movups	0x10(%rcx), %xmm0
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
leaq	0x10(%rcx,%rax), %rcx
negq	%rax
aesenc	%xmm1, %xmm4
addq	$0x10, %rax
movups	(%rdi), %xmm10
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
movups	0x10(%rdi), %xmm11
movups	0x20(%rdi), %xmm12
aesenc	%xmm1, %xmm7
aesenc	%xmm1, %xmm8
callq	L_59a
movdqu	0x30(%rdi), %xmm13
pxor	%xmm10, %xmm2
movdqu	0x40(%rdi), %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm13, %xmm5
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm10, %xmm6
movdqu	%xmm5, 0x30(%rsi)
movdqu	%xmm6, 0x40(%rsi)
cmpq	$0x6, %rdx
jb	L_17d6
movups	0x50(%rdi), %xmm11
xorps	%xmm11, %xmm7
movups	%xmm7, 0x50(%rsi)
je	L_17d6
movups	0x60(%rdi), %xmm12
xorps	%xmm12, %xmm8
movups	%xmm8, 0x60(%rsi)
jmp	L_17d6
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_1700:
aesenc	%xmm1, %xmm2
leaq	0x10(%rcx), %rcx
decl	%eax
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	(%rcx), %xmm1
jne	L_1700
aesenclast	%xmm1, %xmm2
aesenclast	%xmm1, %xmm3
movups	(%rdi), %xmm10
movups	0x10(%rdi), %xmm11
aesenclast	%xmm1, %xmm4
aesenclast	%xmm1, %xmm5
movups	0x20(%rdi), %xmm12
movups	0x30(%rdi), %xmm13
xorps	%xmm10, %xmm2
movups	%xmm2, (%rsi)
xorps	%xmm11, %xmm3
movups	%xmm3, 0x10(%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm13, %xmm5
movdqu	%xmm5, 0x30(%rsi)
jmp	L_17d6
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_1780:
aesenc	%xmm1, %xmm2
leaq	0x10(%rcx), %rcx
decl	%eax
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
movups	(%rcx), %xmm1
jne	L_1780
aesenclast	%xmm1, %xmm2
aesenclast	%xmm1, %xmm3
aesenclast	%xmm1, %xmm4
movups	(%rdi), %xmm10
xorps	%xmm10, %xmm2
movups	%xmm2, (%rsi)
cmpq	$0x2, %rdx
jb	L_17d6
movups	0x10(%rdi), %xmm11
xorps	%xmm11, %xmm3
movups	%xmm3, 0x10(%rsi)
je	L_17d6
movups	0x20(%rdi), %xmm12
xorps	%xmm12, %xmm4
movups	%xmm4, 0x20(%rsi)
L_17d6:
xorps	%xmm0, %xmm0
xorl	%ebp, %ebp
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
movaps	%xmm0, (%rsp)
pxor	%xmm8, %xmm8
movaps	%xmm0, 0x10(%rsp)
pxor	%xmm9, %xmm9
movaps	%xmm0, 0x20(%rsp)
pxor	%xmm10, %xmm10
movaps	%xmm0, 0x30(%rsp)
pxor	%xmm11, %xmm11
movaps	%xmm0, 0x40(%rsp)
pxor	%xmm12, %xmm12
movaps	%xmm0, 0x50(%rsp)
pxor	%xmm13, %xmm13
movaps	%xmm0, 0x60(%rsp)
pxor	%xmm14, %xmm14
movaps	%xmm0, 0x70(%rsp)
pxor	%xmm15, %xmm15
movq	-0x8(%r11), %rbp
leaq	(%r11), %rsp
L_184d:
rep	retq
nop
aesni_xts_encrypt:
endbr64
leaq	(%rsp), %r11
pushq	%rbp
subq	$0x70, %rsp
andq	$-0x10, %rsp
movups	(%r9), %xmm2
movl	0xf0(%r8), %eax
movl	0xf0(%rcx), %r10d
movups	(%r8), %xmm0
movups	0x10(%r8), %xmm1
leaq	0x20(%r8), %r8
xorps	%xmm0, %xmm2
L_1883:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%r8), %xmm1
leaq	0x10(%r8), %r8
jne	L_1883
aesenclast	%xmm1, %xmm2
movups	(%rcx), %xmm0
movq	%rcx, %rbp
movl	%r10d, %eax
shll	$0x4, %r10d
movq	%rdx, %r9
andq	$-0x10, %rdx
movups	0x10(%rcx,%r10), %xmm1
movdqa	bums_rodata+48(%rip), %xmm8
movdqa	%xmm2, %xmm15
pshufd	$0x5f, %xmm2, %xmm9
pxor	%xmm0, %xmm1
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm10
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm10
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm11
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm11
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm12
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm12
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm13
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm13
pxor	%xmm14, %xmm15
movdqa	%xmm15, %xmm14
psrad	$0x1f, %xmm9
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm9
pxor	%xmm0, %xmm14
pxor	%xmm9, %xmm15
movaps	%xmm1, 0x60(%rsp)
subq	$0x60, %rdx
jb	L_1ce0
movl	$0x70, %eax
leaq	0x20(%rbp,%r10), %rcx
subq	%r10, %rax
movups	0x10(%rbp), %xmm1
movq	%rax, %r10
leaq	bums_rodata+48(%rip), %r8
jmp	L_19c0
nopw	(%rax,%rax)
L_19c0:
movdqu	(%rdi), %xmm2
movdqa	%xmm0, %xmm8
movdqu	0x10(%rdi), %xmm3
pxor	%xmm10, %xmm2
movdqu	0x20(%rdi), %xmm4
pxor	%xmm11, %xmm3
aesenc	%xmm1, %xmm2
movdqu	0x30(%rdi), %xmm5
pxor	%xmm12, %xmm4
aesenc	%xmm1, %xmm3
movdqu	0x40(%rdi), %xmm6
pxor	%xmm13, %xmm5
aesenc	%xmm1, %xmm4
movdqu	0x50(%rdi), %xmm7
pxor	%xmm15, %xmm8
movdqa	0x60(%rsp), %xmm9
pxor	%xmm14, %xmm6
aesenc	%xmm1, %xmm5
movups	0x20(%rbp), %xmm0
leaq	0x60(%rdi), %rdi
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm10
aesenc	%xmm1, %xmm6
pxor	%xmm9, %xmm11
movdqa	%xmm10, (%rsp)
aesenc	%xmm1, %xmm7
movups	0x30(%rbp), %xmm1
pxor	%xmm9, %xmm12
aesenc	%xmm0, %xmm2
pxor	%xmm9, %xmm13
movdqa	%xmm11, 0x10(%rsp)
aesenc	%xmm0, %xmm3
pxor	%xmm9, %xmm14
movdqa	%xmm12, 0x20(%rsp)
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
pxor	%xmm9, %xmm8
movdqa	%xmm14, 0x40(%rsp)
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
movups	0x40(%rbp), %xmm0
movdqa	%xmm8, 0x50(%rsp)
pshufd	$0x5f, %xmm15, %xmm9
jmp	L_1aa0
L_1aa0:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
movups	-0x40(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
movups	-0x50(%rcx,%rax), %xmm0
jne	L_1aa0
movdqa	(%r8), %xmm8
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
aesenc	%xmm1, %xmm2
paddq	%xmm15, %xmm15
psrad	$0x1f, %xmm14
aesenc	%xmm1, %xmm3
pand	%xmm8, %xmm14
movups	(%rbp), %xmm10
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
pxor	%xmm14, %xmm15
movaps	%xmm10, %xmm11
aesenc	%xmm1, %xmm7
movups	-0x40(%rcx), %xmm1
movdqa	%xmm9, %xmm14
aesenc	%xmm0, %xmm2
paddd	%xmm9, %xmm9
pxor	%xmm15, %xmm10
aesenc	%xmm0, %xmm3
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
pand	%xmm8, %xmm14
movaps	%xmm11, %xmm12
aesenc	%xmm0, %xmm6
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
aesenc	%xmm0, %xmm7
movups	-0x30(%rcx), %xmm0
paddd	%xmm9, %xmm9
aesenc	%xmm1, %xmm2
pxor	%xmm15, %xmm11
psrad	$0x1f, %xmm14
aesenc	%xmm1, %xmm3
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movdqa	%xmm13, 0x30(%rsp)
pxor	%xmm14, %xmm15
aesenc	%xmm1, %xmm6
movaps	%xmm12, %xmm13
movdqa	%xmm9, %xmm14
aesenc	%xmm1, %xmm7
movups	-0x20(%rcx), %xmm1
paddd	%xmm9, %xmm9
aesenc	%xmm0, %xmm2
pxor	%xmm15, %xmm12
psrad	$0x1f, %xmm14
aesenc	%xmm0, %xmm3
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
pxor	%xmm14, %xmm15
movaps	%xmm13, %xmm14
aesenc	%xmm0, %xmm7
movdqa	%xmm9, %xmm0
paddd	%xmm9, %xmm9
aesenc	%xmm1, %xmm2
pxor	%xmm15, %xmm13
psrad	$0x1f, %xmm0
aesenc	%xmm1, %xmm3
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm0
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
pxor	%xmm0, %xmm15
movups	(%rbp), %xmm0
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
movups	0x10(%rbp), %xmm1
pxor	%xmm15, %xmm14
aesenclast	(%rsp), %xmm2
psrad	$0x1f, %xmm9
paddq	%xmm15, %xmm15
aesenclast	0x10(%rsp), %xmm3
aesenclast	0x20(%rsp), %xmm4
pand	%xmm8, %xmm9
movq	%r10, %rax
aesenclast	0x30(%rsp), %xmm5
aesenclast	0x40(%rsp), %xmm6
aesenclast	0x50(%rsp), %xmm7
pxor	%xmm9, %xmm15
leaq	0x60(%rsi), %rsi
movups	%xmm2, -0x60(%rsi)
movups	%xmm3, -0x50(%rsi)
movups	%xmm4, -0x40(%rsi)
movups	%xmm5, -0x30(%rsi)
movups	%xmm6, -0x20(%rsi)
movups	%xmm7, -0x10(%rsi)
subq	$0x60, %rdx
jae	L_19c0
movl	$0x70, %eax
subl	%r10d, %eax
movq	%rbp, %rcx
shrl	$0x4, %eax
L_1ce0:
movl	%eax, %r10d
pxor	%xmm0, %xmm10
addq	$0x60, %rdx
je	L_1ee0
pxor	%xmm0, %xmm11
cmpq	$0x20, %rdx
jb	L_1da0
pxor	%xmm0, %xmm12
je	L_1df0
pxor	%xmm0, %xmm13
cmpq	$0x40, %rdx
jb	L_1e30
pxor	%xmm0, %xmm14
je	L_1e80
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqu	0x20(%rdi), %xmm4
pxor	%xmm10, %xmm2
movdqu	0x30(%rdi), %xmm5
pxor	%xmm11, %xmm3
movdqu	0x40(%rdi), %xmm6
leaq	0x50(%rdi), %rdi
pxor	%xmm12, %xmm4
pxor	%xmm13, %xmm5
pxor	%xmm14, %xmm6
pxor	%xmm7, %xmm7
callq	_aesni_encrypt6
xorps	%xmm10, %xmm2
movdqa	%xmm15, %xmm10
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
movdqu	%xmm2, (%rsi)
xorps	%xmm13, %xmm5
movdqu	%xmm3, 0x10(%rsi)
xorps	%xmm14, %xmm6
movdqu	%xmm4, 0x20(%rsi)
movdqu	%xmm5, 0x30(%rsi)
movdqu	%xmm6, 0x40(%rsi)
leaq	0x50(%rsi), %rsi
jmp	L_1ee0
nop
L_1da0:
movups	(%rdi), %xmm2
leaq	0x10(%rdi), %rdi
xorps	%xmm10, %xmm2
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_1db9:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_1db9
aesenclast	%xmm1, %xmm2
xorps	%xmm10, %xmm2
movdqa	%xmm11, %xmm10
movups	%xmm2, (%rsi)
leaq	0x10(%rsi), %rsi
jmp	L_1ee0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1df0:
movups	(%rdi), %xmm2
movups	0x10(%rdi), %xmm3
leaq	0x20(%rdi), %rdi
xorps	%xmm10, %xmm2
xorps	%xmm11, %xmm3
callq	_aesni_encrypt2
xorps	%xmm10, %xmm2
movdqa	%xmm12, %xmm10
xorps	%xmm11, %xmm3
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
leaq	0x20(%rsi), %rsi
jmp	L_1ee0
nopw	%cs:(%rax,%rax)
nop
L_1e30:
movups	(%rdi), %xmm2
movups	0x10(%rdi), %xmm3
movups	0x20(%rdi), %xmm4
leaq	0x30(%rdi), %rdi
xorps	%xmm10, %xmm2
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
callq	_aesni_encrypt3
xorps	%xmm10, %xmm2
movdqa	%xmm13, %xmm10
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
leaq	0x30(%rsi), %rsi
jmp	L_1ee0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_1e80:
movups	(%rdi), %xmm2
movups	0x10(%rdi), %xmm3
movups	0x20(%rdi), %xmm4
xorps	%xmm10, %xmm2
movups	0x30(%rdi), %xmm5
leaq	0x40(%rdi), %rdi
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
xorps	%xmm13, %xmm5
callq	_aesni_encrypt4
pxor	%xmm10, %xmm2
movdqa	%xmm14, %xmm10
pxor	%xmm11, %xmm3
pxor	%xmm12, %xmm4
movdqu	%xmm2, (%rsi)
pxor	%xmm13, %xmm5
movdqu	%xmm3, 0x10(%rsi)
movdqu	%xmm4, 0x20(%rsi)
movdqu	%xmm5, 0x30(%rsi)
leaq	0x40(%rsi), %rsi
jmp	L_1ee0
nopw	(%rax,%rax)
L_1ee0:
andq	$0xf, %r9
je	L_1f3f
movq	%r9, %rdx
L_1ee9:
movzbl	(%rdi), %eax
movzbl	-0x10(%rsi), %ecx
leaq	0x1(%rdi), %rdi
movb	%al, -0x10(%rsi)
movb	%cl, (%rsi)
leaq	0x1(%rsi), %rsi
subq	$0x1, %rdx
jne	L_1ee9
subq	%r9, %rsi
movq	%rbp, %rcx
movl	%r10d, %eax
movups	-0x10(%rsi), %xmm2
xorps	%xmm10, %xmm2
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_1f22:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_1f22
aesenclast	%xmm1, %xmm2
xorps	%xmm10, %xmm2
movups	%xmm2, -0x10(%rsi)
L_1f3f:
xorps	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
movaps	%xmm0, (%rsp)
pxor	%xmm8, %xmm8
movaps	%xmm0, 0x10(%rsp)
pxor	%xmm9, %xmm9
movaps	%xmm0, 0x20(%rsp)
pxor	%xmm10, %xmm10
movaps	%xmm0, 0x30(%rsp)
pxor	%xmm11, %xmm11
movaps	%xmm0, 0x40(%rsp)
pxor	%xmm12, %xmm12
movaps	%xmm0, 0x50(%rsp)
pxor	%xmm13, %xmm13
movaps	%xmm0, 0x60(%rsp)
pxor	%xmm14, %xmm14
pxor	%xmm15, %xmm15
movq	-0x8(%r11), %rbp
leaq	(%r11), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
aesni_xts_decrypt:
endbr64
leaq	(%rsp), %r11
pushq	%rbp
subq	$0x70, %rsp
andq	$-0x10, %rsp
movups	(%r9), %xmm2
movl	0xf0(%r8), %eax
movl	0xf0(%rcx), %r10d
movups	(%r8), %xmm0
movups	0x10(%r8), %xmm1
leaq	0x20(%r8), %r8
xorps	%xmm0, %xmm2
L_1ff3:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%r8), %xmm1
leaq	0x10(%r8), %r8
jne	L_1ff3
aesenclast	%xmm1, %xmm2
xorl	%eax, %eax
testq	$0xf, %rdx
setne	%al
shlq	$0x4, %rax
subq	%rax, %rdx
movups	(%rcx), %xmm0
movq	%rcx, %rbp
movl	%r10d, %eax
shll	$0x4, %r10d
movq	%rdx, %r9
andq	$-0x10, %rdx
movups	0x10(%rcx,%r10), %xmm1
movdqa	bums_rodata+48(%rip), %xmm8
movdqa	%xmm2, %xmm15
pshufd	$0x5f, %xmm2, %xmm9
pxor	%xmm0, %xmm1
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm10
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm10
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm11
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm11
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm12
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm12
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
movdqa	%xmm15, %xmm13
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
pxor	%xmm0, %xmm13
pxor	%xmm14, %xmm15
movdqa	%xmm15, %xmm14
psrad	$0x1f, %xmm9
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm9
pxor	%xmm0, %xmm14
pxor	%xmm9, %xmm15
movaps	%xmm1, 0x60(%rsp)
subq	$0x60, %rdx
jb	L_2460
movl	$0x70, %eax
leaq	0x20(%rbp,%r10), %rcx
subq	%r10, %rax
movups	0x10(%rbp), %xmm1
movq	%rax, %r10
leaq	bums_rodata+48(%rip), %r8
jmp	L_2140
nopl	(%rax)
L_2140:
movdqu	(%rdi), %xmm2
movdqa	%xmm0, %xmm8
movdqu	0x10(%rdi), %xmm3
pxor	%xmm10, %xmm2
movdqu	0x20(%rdi), %xmm4
pxor	%xmm11, %xmm3
aesdec	%xmm1, %xmm2
movdqu	0x30(%rdi), %xmm5
pxor	%xmm12, %xmm4
aesdec	%xmm1, %xmm3
movdqu	0x40(%rdi), %xmm6
pxor	%xmm13, %xmm5
aesdec	%xmm1, %xmm4
movdqu	0x50(%rdi), %xmm7
pxor	%xmm15, %xmm8
movdqa	0x60(%rsp), %xmm9
pxor	%xmm14, %xmm6
aesdec	%xmm1, %xmm5
movups	0x20(%rbp), %xmm0
leaq	0x60(%rdi), %rdi
pxor	%xmm8, %xmm7
pxor	%xmm9, %xmm10
aesdec	%xmm1, %xmm6
pxor	%xmm9, %xmm11
movdqa	%xmm10, (%rsp)
aesdec	%xmm1, %xmm7
movups	0x30(%rbp), %xmm1
pxor	%xmm9, %xmm12
aesdec	%xmm0, %xmm2
pxor	%xmm9, %xmm13
movdqa	%xmm11, 0x10(%rsp)
aesdec	%xmm0, %xmm3
pxor	%xmm9, %xmm14
movdqa	%xmm12, 0x20(%rsp)
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
pxor	%xmm9, %xmm8
movdqa	%xmm14, 0x40(%rsp)
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
movups	0x40(%rbp), %xmm0
movdqa	%xmm8, 0x50(%rsp)
pshufd	$0x5f, %xmm15, %xmm9
jmp	L_2220
L_2220:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
movups	-0x40(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
movups	-0x50(%rcx,%rax), %xmm0
jne	L_2220
movdqa	(%r8), %xmm8
movdqa	%xmm9, %xmm14
paddd	%xmm9, %xmm9
aesdec	%xmm1, %xmm2
paddq	%xmm15, %xmm15
psrad	$0x1f, %xmm14
aesdec	%xmm1, %xmm3
pand	%xmm8, %xmm14
movups	(%rbp), %xmm10
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
pxor	%xmm14, %xmm15
movaps	%xmm10, %xmm11
aesdec	%xmm1, %xmm7
movups	-0x40(%rcx), %xmm1
movdqa	%xmm9, %xmm14
aesdec	%xmm0, %xmm2
paddd	%xmm9, %xmm9
pxor	%xmm15, %xmm10
aesdec	%xmm0, %xmm3
psrad	$0x1f, %xmm14
paddq	%xmm15, %xmm15
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
pand	%xmm8, %xmm14
movaps	%xmm11, %xmm12
aesdec	%xmm0, %xmm6
pxor	%xmm14, %xmm15
movdqa	%xmm9, %xmm14
aesdec	%xmm0, %xmm7
movups	-0x30(%rcx), %xmm0
paddd	%xmm9, %xmm9
aesdec	%xmm1, %xmm2
pxor	%xmm15, %xmm11
psrad	$0x1f, %xmm14
aesdec	%xmm1, %xmm3
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movdqa	%xmm13, 0x30(%rsp)
pxor	%xmm14, %xmm15
aesdec	%xmm1, %xmm6
movaps	%xmm12, %xmm13
movdqa	%xmm9, %xmm14
aesdec	%xmm1, %xmm7
movups	-0x20(%rcx), %xmm1
paddd	%xmm9, %xmm9
aesdec	%xmm0, %xmm2
pxor	%xmm15, %xmm12
psrad	$0x1f, %xmm14
aesdec	%xmm0, %xmm3
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm14
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
pxor	%xmm14, %xmm15
movaps	%xmm13, %xmm14
aesdec	%xmm0, %xmm7
movdqa	%xmm9, %xmm0
paddd	%xmm9, %xmm9
aesdec	%xmm1, %xmm2
pxor	%xmm15, %xmm13
psrad	$0x1f, %xmm0
aesdec	%xmm1, %xmm3
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm0
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
pxor	%xmm0, %xmm15
movups	(%rbp), %xmm0
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
movups	0x10(%rbp), %xmm1
pxor	%xmm15, %xmm14
aesdeclast	(%rsp), %xmm2
psrad	$0x1f, %xmm9
paddq	%xmm15, %xmm15
aesdeclast	0x10(%rsp), %xmm3
aesdeclast	0x20(%rsp), %xmm4
pand	%xmm8, %xmm9
movq	%r10, %rax
aesdeclast	0x30(%rsp), %xmm5
aesdeclast	0x40(%rsp), %xmm6
aesdeclast	0x50(%rsp), %xmm7
pxor	%xmm9, %xmm15
leaq	0x60(%rsi), %rsi
movups	%xmm2, -0x60(%rsi)
movups	%xmm3, -0x50(%rsi)
movups	%xmm4, -0x40(%rsi)
movups	%xmm5, -0x30(%rsi)
movups	%xmm6, -0x20(%rsi)
movups	%xmm7, -0x10(%rsi)
subq	$0x60, %rdx
jae	L_2140
movl	$0x70, %eax
subl	%r10d, %eax
movq	%rbp, %rcx
shrl	$0x4, %eax
L_2460:
movl	%eax, %r10d
pxor	%xmm0, %xmm10
pxor	%xmm0, %xmm11
addq	$0x60, %rdx
je	L_2690
pxor	%xmm0, %xmm12
cmpq	$0x20, %rdx
jb	L_2550
pxor	%xmm0, %xmm13
je	L_25a0
pxor	%xmm0, %xmm14
cmpq	$0x40, %rdx
jb	L_25e0
je	L_2630
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqu	0x20(%rdi), %xmm4
pxor	%xmm10, %xmm2
movdqu	0x30(%rdi), %xmm5
pxor	%xmm11, %xmm3
movdqu	0x40(%rdi), %xmm6
leaq	0x50(%rdi), %rdi
pxor	%xmm12, %xmm4
pxor	%xmm13, %xmm5
pxor	%xmm14, %xmm6
callq	_aesni_decrypt6
xorps	%xmm10, %xmm2
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
movdqu	%xmm2, (%rsi)
xorps	%xmm13, %xmm5
movdqu	%xmm3, 0x10(%rsi)
xorps	%xmm14, %xmm6
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm14, %xmm14
movdqu	%xmm5, 0x30(%rsi)
pcmpgtd	%xmm15, %xmm14
movdqu	%xmm6, 0x40(%rsi)
leaq	0x50(%rsi), %rsi
pshufd	$0x13, %xmm14, %xmm11
andq	$0xf, %r9
je	L_2728
movdqa	%xmm15, %xmm10
paddq	%xmm15, %xmm15
pand	%xmm8, %xmm11
pxor	%xmm15, %xmm11
jmp	L_269a
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2550:
movups	(%rdi), %xmm2
leaq	0x10(%rdi), %rdi
xorps	%xmm10, %xmm2
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_2569:
aesdec	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_2569
aesdeclast	%xmm1, %xmm2
xorps	%xmm10, %xmm2
movdqa	%xmm11, %xmm10
movups	%xmm2, (%rsi)
movdqa	%xmm12, %xmm11
leaq	0x10(%rsi), %rsi
jmp	L_2690
nopl	(%rax,%rax)
L_25a0:
movups	(%rdi), %xmm2
movups	0x10(%rdi), %xmm3
leaq	0x20(%rdi), %rdi
xorps	%xmm10, %xmm2
xorps	%xmm11, %xmm3
callq	_aesni_decrypt2
xorps	%xmm10, %xmm2
movdqa	%xmm12, %xmm10
xorps	%xmm11, %xmm3
movdqa	%xmm13, %xmm11
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
leaq	0x20(%rsi), %rsi
jmp	L_2690
nopw	(%rax,%rax)
L_25e0:
movups	(%rdi), %xmm2
movups	0x10(%rdi), %xmm3
movups	0x20(%rdi), %xmm4
leaq	0x30(%rdi), %rdi
xorps	%xmm10, %xmm2
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
callq	_aesni_decrypt3
xorps	%xmm10, %xmm2
movdqa	%xmm13, %xmm10
xorps	%xmm11, %xmm3
movdqa	%xmm14, %xmm11
xorps	%xmm12, %xmm4
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
leaq	0x30(%rsi), %rsi
jmp	L_2690
nopw	(%rax,%rax)
L_2630:
movups	(%rdi), %xmm2
movups	0x10(%rdi), %xmm3
movups	0x20(%rdi), %xmm4
xorps	%xmm10, %xmm2
movups	0x30(%rdi), %xmm5
leaq	0x40(%rdi), %rdi
xorps	%xmm11, %xmm3
xorps	%xmm12, %xmm4
xorps	%xmm13, %xmm5
callq	_aesni_decrypt4
pxor	%xmm10, %xmm2
movdqa	%xmm14, %xmm10
pxor	%xmm11, %xmm3
movdqa	%xmm15, %xmm11
pxor	%xmm12, %xmm4
movdqu	%xmm2, (%rsi)
pxor	%xmm13, %xmm5
movdqu	%xmm3, 0x10(%rsi)
movdqu	%xmm4, 0x20(%rsi)
movdqu	%xmm5, 0x30(%rsi)
leaq	0x40(%rsi), %rsi
jmp	L_2690
nop
L_2690:
andq	$0xf, %r9
je	L_2728
L_269a:
movq	%r9, %rdx
movq	%rbp, %rcx
movl	%r10d, %eax
movups	(%rdi), %xmm2
xorps	%xmm11, %xmm2
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_26b8:
aesdec	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_26b8
aesdeclast	%xmm1, %xmm2
xorps	%xmm11, %xmm2
movups	%xmm2, (%rsi)
L_26d4:
movzbl	0x10(%rdi), %eax
movzbl	(%rsi), %ecx
leaq	0x1(%rdi), %rdi
movb	%al, (%rsi)
movb	%cl, 0x10(%rsi)
leaq	0x1(%rsi), %rsi
subq	$0x1, %rdx
jne	L_26d4
subq	%r9, %rsi
movq	%rbp, %rcx
movl	%r10d, %eax
movups	(%rsi), %xmm2
xorps	%xmm10, %xmm2
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_270c:
aesdec	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_270c
aesdeclast	%xmm1, %xmm2
xorps	%xmm10, %xmm2
movups	%xmm2, (%rsi)
L_2728:
xorps	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
movaps	%xmm0, (%rsp)
pxor	%xmm8, %xmm8
movaps	%xmm0, 0x10(%rsp)
pxor	%xmm9, %xmm9
movaps	%xmm0, 0x20(%rsp)
pxor	%xmm10, %xmm10
movaps	%xmm0, 0x30(%rsp)
pxor	%xmm11, %xmm11
movaps	%xmm0, 0x40(%rsp)
pxor	%xmm12, %xmm12
movaps	%xmm0, 0x50(%rsp)
pxor	%xmm13, %xmm13
movaps	%xmm0, 0x60(%rsp)
pxor	%xmm14, %xmm14
pxor	%xmm15, %xmm15
movq	-0x8(%r11), %rbp
leaq	(%r11), %rsp
rep	retq
nopw	(%rax,%rax)
aesni_ocb_encrypt:
endbr64
leaq	(%rsp), %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
movq	0x8(%rax), %rbx
movq	0x10(%rax), %rbp
movl	0xf0(%rcx), %r10d
movq	%rcx, %r11
shll	$0x4, %r10d
movups	(%rcx), %xmm9
movups	0x10(%rcx,%r10), %xmm1
movdqu	(%r9), %xmm15
pxor	%xmm1, %xmm9
pxor	%xmm1, %xmm15
movl	$0x30, %eax
leaq	0x20(%r11,%r10), %rcx
movups	0x10(%r11), %xmm1
subq	%r10, %rax
movq	%rax, %r10
movdqu	(%rbx), %xmm10
movdqu	(%rbp), %xmm8
testq	$0x1, %r8
jne	L_283d
bsfq	%r8, %r12
addq	$0x1, %r8
shlq	$0x4, %r12
movdqu	(%rbx,%r12), %xmm7
movdqu	(%rdi), %xmm2
leaq	0x10(%rdi), %rdi
callq	__ocb_encrypt1
movdqa	%xmm7, %xmm15
movups	%xmm2, (%rsi)
leaq	0x10(%rsi), %rsi
subq	$0x1, %rdx
je	L_29a9
L_283d:
leaq	0x1(%r8), %r12
leaq	0x3(%r8), %r13
leaq	0x5(%r8), %r14
leaq	0x6(%r8), %r8
bsfq	%r12, %r12
bsfq	%r13, %r13
bsfq	%r14, %r14
shlq	$0x4, %r12
shlq	$0x4, %r13
shlq	$0x4, %r14
subq	$0x6, %rdx
jb	L_28c7
jmp	L_2880
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_2880:
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqu	0x20(%rdi), %xmm4
movdqu	0x30(%rdi), %xmm5
movdqu	0x40(%rdi), %xmm6
movdqu	0x50(%rdi), %xmm7
leaq	0x60(%rdi), %rdi
callq	__ocb_encrypt6
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
movups	%xmm6, 0x40(%rsi)
movups	%xmm7, 0x50(%rsi)
leaq	0x60(%rsi), %rsi
subq	$0x6, %rdx
jae	L_2880
L_28c7:
addq	$0x6, %rdx
je	L_29a9
movdqu	(%rdi), %xmm2
cmpq	$0x2, %rdx
jb	L_2930
movdqu	0x10(%rdi), %xmm3
je	L_2950
movdqu	0x20(%rdi), %xmm4
cmpq	$0x4, %rdx
jb	L_2970
movdqu	0x30(%rdi), %xmm5
je	L_2990
movdqu	0x40(%rdi), %xmm6
pxor	%xmm7, %xmm7
callq	__ocb_encrypt6
movdqa	%xmm14, %xmm15
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
movups	%xmm6, 0x40(%rsi)
jmp	L_29a9
nopw	(%rax,%rax)
L_2930:
movdqa	%xmm10, %xmm7
callq	__ocb_encrypt1
movdqa	%xmm7, %xmm15
movups	%xmm2, (%rsi)
jmp	L_29a9
nopw	%cs:(%rax,%rax)
nop
L_2950:
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
callq	__ocb_encrypt4
movdqa	%xmm11, %xmm15
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
jmp	L_29a9
nopl	(%rax,%rax)
L_2970:
pxor	%xmm5, %xmm5
callq	__ocb_encrypt4
movdqa	%xmm12, %xmm15
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
jmp	L_29a9
nopl	(%rax,%rax)
L_2990:
callq	__ocb_encrypt4
movdqa	%xmm13, %xmm15
movups	%xmm2, (%rsi)
movups	%xmm3, 0x10(%rsi)
movups	%xmm4, 0x20(%rsi)
movups	%xmm5, 0x30(%rsi)
L_29a9:
pxor	%xmm0, %xmm15
movdqu	%xmm8, (%rbp)
movdqu	%xmm15, (%r9)
xorps	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
pxor	%xmm8, %xmm8
pxor	%xmm9, %xmm9
pxor	%xmm10, %xmm10
pxor	%xmm11, %xmm11
pxor	%xmm12, %xmm12
pxor	%xmm13, %xmm13
pxor	%xmm14, %xmm14
pxor	%xmm15, %xmm15
leaq	0x28(%rsp), %rax
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nop
__ocb_encrypt6:
pxor	%xmm9, %xmm15
movdqu	(%rbx,%r12), %xmm11
movdqa	%xmm10, %xmm12
movdqu	(%rbx,%r13), %xmm13
movdqa	%xmm10, %xmm14
pxor	%xmm15, %xmm10
movdqu	(%rbx,%r14), %xmm15
pxor	%xmm10, %xmm11
pxor	%xmm2, %xmm8
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm12
pxor	%xmm3, %xmm8
pxor	%xmm11, %xmm3
pxor	%xmm12, %xmm13
pxor	%xmm4, %xmm8
pxor	%xmm12, %xmm4
pxor	%xmm13, %xmm14
pxor	%xmm5, %xmm8
pxor	%xmm13, %xmm5
pxor	%xmm14, %xmm15
pxor	%xmm6, %xmm8
pxor	%xmm14, %xmm6
pxor	%xmm7, %xmm8
pxor	%xmm15, %xmm7
movups	0x20(%r11), %xmm0
leaq	0x1(%r8), %r12
leaq	0x3(%r8), %r13
leaq	0x5(%r8), %r14
addq	$0x6, %r8
pxor	%xmm9, %xmm10
bsfq	%r12, %r12
bsfq	%r13, %r13
bsfq	%r14, %r14
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
pxor	%xmm9, %xmm11
pxor	%xmm9, %xmm12
aesenc	%xmm1, %xmm6
pxor	%xmm9, %xmm13
pxor	%xmm9, %xmm14
aesenc	%xmm1, %xmm7
movups	0x30(%r11), %xmm1
pxor	%xmm9, %xmm15
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
movups	0x40(%r11), %xmm0
shlq	$0x4, %r12
shlq	$0x4, %r13
jmp	L_2b40
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_2b40:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
aesenc	%xmm0, %xmm6
aesenc	%xmm0, %xmm7
movups	-0x10(%rcx,%rax), %xmm0
jne	L_2b40
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
aesenc	%xmm1, %xmm6
aesenc	%xmm1, %xmm7
movups	0x10(%r11), %xmm1
shlq	$0x4, %r14
aesenclast	%xmm10, %xmm2
movdqu	(%rbx), %xmm10
movq	%r10, %rax
aesenclast	%xmm11, %xmm3
aesenclast	%xmm12, %xmm4
aesenclast	%xmm13, %xmm5
aesenclast	%xmm14, %xmm6
aesenclast	%xmm15, %xmm7
rep	retq
__ocb_encrypt4:
pxor	%xmm9, %xmm15
movdqu	(%rbx,%r12), %xmm11
movdqa	%xmm10, %xmm12
movdqu	(%rbx,%r13), %xmm13
pxor	%xmm15, %xmm10
pxor	%xmm10, %xmm11
pxor	%xmm2, %xmm8
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm12
pxor	%xmm3, %xmm8
pxor	%xmm11, %xmm3
pxor	%xmm12, %xmm13
pxor	%xmm4, %xmm8
pxor	%xmm12, %xmm4
pxor	%xmm5, %xmm8
pxor	%xmm13, %xmm5
movups	0x20(%r11), %xmm0
pxor	%xmm9, %xmm10
pxor	%xmm9, %xmm11
pxor	%xmm9, %xmm12
pxor	%xmm9, %xmm13
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	0x30(%r11), %xmm1
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	0x40(%r11), %xmm0
jmp	L_2c80
nop
L_2c80:
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
aesenc	%xmm0, %xmm3
aesenc	%xmm0, %xmm4
aesenc	%xmm0, %xmm5
movups	-0x10(%rcx,%rax), %xmm0
jne	L_2c80
aesenc	%xmm1, %xmm2
aesenc	%xmm1, %xmm3
aesenc	%xmm1, %xmm4
aesenc	%xmm1, %xmm5
movups	0x10(%r11), %xmm1
movq	%r10, %rax
aesenclast	%xmm10, %xmm2
aesenclast	%xmm11, %xmm3
aesenclast	%xmm12, %xmm4
aesenclast	%xmm13, %xmm5
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
__ocb_encrypt1:
pxor	%xmm15, %xmm7
pxor	%xmm9, %xmm7
pxor	%xmm2, %xmm8
pxor	%xmm7, %xmm2
movups	0x20(%r11), %xmm0
aesenc	%xmm1, %xmm2
movups	0x30(%r11), %xmm1
pxor	%xmm9, %xmm7
aesenc	%xmm0, %xmm2
movups	0x40(%r11), %xmm0
jmp	L_2d40
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2d40:
aesenc	%xmm1, %xmm2
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesenc	%xmm0, %xmm2
movups	-0x10(%rcx,%rax), %xmm0
jne	L_2d40
aesenc	%xmm1, %xmm2
movups	0x10(%r11), %xmm1
movq	%r10, %rax
aesenclast	%xmm7, %xmm2
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
aesni_ocb_decrypt:
endbr64
leaq	(%rsp), %rax
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
movq	0x8(%rax), %rbx
movq	0x10(%rax), %rbp
movl	0xf0(%rcx), %r10d
movq	%rcx, %r11
shll	$0x4, %r10d
movups	(%rcx), %xmm9
movups	0x10(%rcx,%r10), %xmm1
movdqu	(%r9), %xmm15
pxor	%xmm1, %xmm9
pxor	%xmm1, %xmm15
movl	$0x30, %eax
leaq	0x20(%r11,%r10), %rcx
movups	0x10(%r11), %xmm1
subq	%r10, %rax
movq	%rax, %r10
movdqu	(%rbx), %xmm10
movdqu	(%rbp), %xmm8
testq	$0x1, %r8
jne	L_2e21
bsfq	%r8, %r12
addq	$0x1, %r8
shlq	$0x4, %r12
movdqu	(%rbx,%r12), %xmm7
movdqu	(%rdi), %xmm2
leaq	0x10(%rdi), %rdi
callq	__ocb_decrypt1
movdqa	%xmm7, %xmm15
movups	%xmm2, (%rsi)
xorps	%xmm2, %xmm8
leaq	0x10(%rsi), %rsi
subq	$0x1, %rdx
je	L_2ffd
L_2e21:
leaq	0x1(%r8), %r12
leaq	0x3(%r8), %r13
leaq	0x5(%r8), %r14
leaq	0x6(%r8), %r8
bsfq	%r12, %r12
bsfq	%r13, %r13
bsfq	%r14, %r14
shlq	$0x4, %r12
shlq	$0x4, %r13
shlq	$0x4, %r14
subq	$0x6, %rdx
jb	L_2ec5
jmp	L_2e60
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_2e60:
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqu	0x20(%rdi), %xmm4
movdqu	0x30(%rdi), %xmm5
movdqu	0x40(%rdi), %xmm6
movdqu	0x50(%rdi), %xmm7
leaq	0x60(%rdi), %rdi
callq	__ocb_decrypt6
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm8
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm8
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm8
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm8
movups	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm8
movups	%xmm7, 0x50(%rsi)
pxor	%xmm7, %xmm8
leaq	0x60(%rsi), %rsi
subq	$0x6, %rdx
jae	L_2e60
L_2ec5:
addq	$0x6, %rdx
je	L_2ffd
movdqu	(%rdi), %xmm2
cmpq	$0x2, %rdx
jb	L_2f50
movdqu	0x10(%rdi), %xmm3
je	L_2f70
movdqu	0x20(%rdi), %xmm4
cmpq	$0x4, %rdx
jb	L_2fa0
movdqu	0x30(%rdi), %xmm5
je	L_2fd0
movdqu	0x40(%rdi), %xmm6
pxor	%xmm7, %xmm7
callq	__ocb_decrypt6
movdqa	%xmm14, %xmm15
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm8
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm8
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm8
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm8
movups	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm8
jmp	L_2ffd
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2f50:
movdqa	%xmm10, %xmm7
callq	__ocb_decrypt1
movdqa	%xmm7, %xmm15
movups	%xmm2, (%rsi)
xorps	%xmm2, %xmm8
jmp	L_2ffd
nopl	(%rax,%rax)
L_2f70:
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
callq	__ocb_decrypt4
movdqa	%xmm11, %xmm15
movups	%xmm2, (%rsi)
xorps	%xmm2, %xmm8
movups	%xmm3, 0x10(%rsi)
xorps	%xmm3, %xmm8
jmp	L_2ffd
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_2fa0:
pxor	%xmm5, %xmm5
callq	__ocb_decrypt4
movdqa	%xmm12, %xmm15
movups	%xmm2, (%rsi)
xorps	%xmm2, %xmm8
movups	%xmm3, 0x10(%rsi)
xorps	%xmm3, %xmm8
movups	%xmm4, 0x20(%rsi)
xorps	%xmm4, %xmm8
jmp	L_2ffd
nopw	(%rax,%rax)
L_2fd0:
callq	__ocb_decrypt4
movdqa	%xmm13, %xmm15
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm8
movups	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm8
movups	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm8
movups	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm8
L_2ffd:
pxor	%xmm0, %xmm15
movdqu	%xmm8, (%rbp)
movdqu	%xmm15, (%r9)
xorps	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
pxor	%xmm8, %xmm8
pxor	%xmm9, %xmm9
pxor	%xmm10, %xmm10
pxor	%xmm11, %xmm11
pxor	%xmm12, %xmm12
pxor	%xmm13, %xmm13
pxor	%xmm14, %xmm14
pxor	%xmm15, %xmm15
leaq	0x28(%rsp), %rax
movq	-0x28(%rax), %r14
movq	-0x20(%rax), %r13
movq	-0x18(%rax), %r12
movq	-0x10(%rax), %rbp
movq	-0x8(%rax), %rbx
leaq	(%rax), %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
__ocb_decrypt6:
pxor	%xmm9, %xmm15
movdqu	(%rbx,%r12), %xmm11
movdqa	%xmm10, %xmm12
movdqu	(%rbx,%r13), %xmm13
movdqa	%xmm10, %xmm14
pxor	%xmm15, %xmm10
movdqu	(%rbx,%r14), %xmm15
pxor	%xmm10, %xmm11
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm12
pxor	%xmm11, %xmm3
pxor	%xmm12, %xmm13
pxor	%xmm12, %xmm4
pxor	%xmm13, %xmm14
pxor	%xmm13, %xmm5
pxor	%xmm14, %xmm15
pxor	%xmm14, %xmm6
pxor	%xmm15, %xmm7
movups	0x20(%r11), %xmm0
leaq	0x1(%r8), %r12
leaq	0x3(%r8), %r13
leaq	0x5(%r8), %r14
addq	$0x6, %r8
pxor	%xmm9, %xmm10
bsfq	%r12, %r12
bsfq	%r13, %r13
bsfq	%r14, %r14
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
pxor	%xmm9, %xmm11
pxor	%xmm9, %xmm12
aesdec	%xmm1, %xmm6
pxor	%xmm9, %xmm13
pxor	%xmm9, %xmm14
aesdec	%xmm1, %xmm7
movups	0x30(%r11), %xmm1
pxor	%xmm9, %xmm15
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
movups	0x40(%r11), %xmm0
shlq	$0x4, %r12
shlq	$0x4, %r13
jmp	L_3180
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
L_3180:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
movups	-0x10(%rcx,%rax), %xmm0
jne	L_3180
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
movups	0x10(%r11), %xmm1
shlq	$0x4, %r14
aesdeclast	%xmm10, %xmm2
movdqu	(%rbx), %xmm10
movq	%r10, %rax
aesdeclast	%xmm11, %xmm3
aesdeclast	%xmm12, %xmm4
aesdeclast	%xmm13, %xmm5
aesdeclast	%xmm14, %xmm6
aesdeclast	%xmm15, %xmm7
rep	retq
__ocb_decrypt4:
pxor	%xmm9, %xmm15
movdqu	(%rbx,%r12), %xmm11
movdqa	%xmm10, %xmm12
movdqu	(%rbx,%r13), %xmm13
pxor	%xmm15, %xmm10
pxor	%xmm10, %xmm11
pxor	%xmm10, %xmm2
pxor	%xmm11, %xmm12
pxor	%xmm11, %xmm3
pxor	%xmm12, %xmm13
pxor	%xmm12, %xmm4
pxor	%xmm13, %xmm5
movups	0x20(%r11), %xmm0
pxor	%xmm9, %xmm10
pxor	%xmm9, %xmm11
pxor	%xmm9, %xmm12
pxor	%xmm9, %xmm13
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	0x30(%r11), %xmm1
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	0x40(%r11), %xmm0
jmp	L_32c0
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_32c0:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
movups	-0x10(%rcx,%rax), %xmm0
jne	L_32c0
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
movups	0x10(%r11), %xmm1
movq	%r10, %rax
aesdeclast	%xmm10, %xmm2
aesdeclast	%xmm11, %xmm3
aesdeclast	%xmm12, %xmm4
aesdeclast	%xmm13, %xmm5
rep	retq
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
__ocb_decrypt1:
pxor	%xmm15, %xmm7
pxor	%xmm9, %xmm7
pxor	%xmm7, %xmm2
movups	0x20(%r11), %xmm0
aesdec	%xmm1, %xmm2
movups	0x30(%r11), %xmm1
pxor	%xmm9, %xmm7
aesdec	%xmm0, %xmm2
movups	0x40(%r11), %xmm0
jmp	L_3380
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_3380:
aesdec	%xmm1, %xmm2
movups	(%rcx,%rax), %xmm1
addq	$0x20, %rax
aesdec	%xmm0, %xmm2
movups	-0x10(%rcx,%rax), %xmm0
jne	L_3380
aesdec	%xmm1, %xmm2
movups	0x10(%r11), %xmm1
movq	%r10, %rax
aesdeclast	%xmm7, %xmm2
rep	retq
nopl	(%rax)
aesni_cbc_encrypt:
endbr64
testq	%rdx, %rdx
je	L_3d10
movl	0xf0(%rcx), %r10d
movq	%rcx, %r11
testl	%r9d, %r9d
je	L_3480
movups	(%r8), %xmm2
movl	%r10d, %eax
cmpq	$0x10, %rdx
jb	L_344f
subq	$0x10, %rdx
jmp	L_33f0
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_33f0:
movups	(%rdi), %xmm3
leaq	0x10(%rdi), %rdi
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
xorps	%xmm0, %xmm3
leaq	0x20(%rcx), %rcx
xorps	%xmm3, %xmm2
L_3408:
aesenc	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_3408
aesenclast	%xmm1, %xmm2
movl	%r10d, %eax
movq	%r11, %rcx
movups	%xmm2, (%rsi)
leaq	0x10(%rsi), %rsi
subq	$0x10, %rdx
jae	L_33f0
addq	$0x10, %rdx
jne	L_344f
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
movups	%xmm2, (%r8)
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
jmp	L_3d10
L_344f:
movq	%rdx, %rcx
xchgq	%rdi, %rsi
rep	movsb	(%rsi), %es:(%rdi)
nop
movl	$0x10, %ecx
subq	%rdx, %rcx
xorl	%eax, %eax
rep	stosb	%al, %es:(%rdi)
nop
leaq	-0x10(%rdi), %rdi
movl	%r10d, %eax
movq	%rdi, %rsi
movq	%r11, %rcx
xorq	%rdx, %rdx
jmp	L_33f0
nopl	(%rax)
L_3480:
cmpq	$0x10, %rdx
jne	L_34e0
movdqu	(%rdi), %xmm2
movdqu	(%r8), %xmm3
movdqa	%xmm2, %xmm4
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_34a1:
aesdec	%xmm1, %xmm2
decl	%r10d
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_34a1
aesdeclast	%xmm1, %xmm2
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
movdqu	%xmm4, (%r8)
xorps	%xmm3, %xmm2
pxor	%xmm3, %xmm3
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
jmp	L_3d10
nopw	(%rax,%rax)
L_34e0:
leaq	(%rsp), %r11
pushq	%rbp
subq	$0x10, %rsp
andq	$-0x10, %rsp
movq	%rcx, %rbp
movups	(%r8), %xmm10
movl	%r10d, %eax
cmpq	$0x50, %rdx
jbe	L_3aef
movups	(%rcx), %xmm0
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqa	%xmm2, %xmm11
movdqu	0x20(%rdi), %xmm4
movdqa	%xmm3, %xmm12
movdqu	0x30(%rdi), %xmm5
movdqa	%xmm4, %xmm13
movdqu	0x40(%rdi), %xmm6
movdqa	%xmm5, %xmm14
movdqu	0x50(%rdi), %xmm7
movdqa	%xmm6, %xmm15
movl	OPENSSL_ia32cap_P+4(%rip), %r9d
cmpq	$0x70, %rdx
jbe	L_3946
andl	$0x4400000, %r9d
subq	$0x50, %rdx
cmpl	$0x400000, %r9d
je	L_3a7d
subq	$0x20, %rdx
leaq	0x70(%rcx), %rcx
jmp	L_3578
nopl	(%rax)
L_3570:
movups	%xmm9, (%rsi)
leaq	0x10(%rsi), %rsi
L_3578:
movdqu	0x60(%rdi), %xmm8
pxor	%xmm0, %xmm2
movdqu	0x70(%rdi), %xmm9
pxor	%xmm0, %xmm3
movups	-0x60(%rcx), %xmm1
pxor	%xmm0, %xmm4
movq	$-0x1, %rbp
cmpq	$0x70, %rdx
pxor	%xmm0, %xmm5
pxor	%xmm0, %xmm6
pxor	%xmm0, %xmm7
pxor	%xmm0, %xmm8
aesdec	%xmm1, %xmm2
pxor	%xmm0, %xmm9
movups	-0x50(%rcx), %xmm0
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
adcq	$0x0, %rbp
andq	$0x80, %rbp
aesdec	%xmm1, %xmm9
addq	%rdi, %rbp
movups	-0x40(%rcx), %xmm1
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	-0x30(%rcx), %xmm0
nop
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movups	-0x20(%rcx), %xmm1
nop
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	-0x10(%rcx), %xmm0
nop
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movups	(%rcx), %xmm1
nop
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	0x10(%rcx), %xmm0
nop
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movups	0x20(%rcx), %xmm1
cmpl	$0xb, %eax
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	0x30(%rcx), %xmm0
jb	L_3810
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movups	0x40(%rcx), %xmm1
nop
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	0x50(%rcx), %xmm0
je	L_3810
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movups	0x60(%rcx), %xmm1
nop
aesdec	%xmm0, %xmm2
aesdec	%xmm0, %xmm3
aesdec	%xmm0, %xmm4
aesdec	%xmm0, %xmm5
aesdec	%xmm0, %xmm6
aesdec	%xmm0, %xmm7
aesdec	%xmm0, %xmm8
aesdec	%xmm0, %xmm9
movups	0x70(%rcx), %xmm0
jmp	L_3810
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_3810:
aesdec	%xmm1, %xmm2
aesdec	%xmm1, %xmm3
pxor	%xmm0, %xmm10
pxor	%xmm0, %xmm11
aesdec	%xmm1, %xmm4
aesdec	%xmm1, %xmm5
pxor	%xmm0, %xmm12
pxor	%xmm0, %xmm13
aesdec	%xmm1, %xmm6
aesdec	%xmm1, %xmm7
pxor	%xmm0, %xmm14
pxor	%xmm0, %xmm15
aesdec	%xmm1, %xmm8
aesdec	%xmm1, %xmm9
movdqu	0x50(%rdi), %xmm1
aesdeclast	%xmm10, %xmm2
movdqu	0x60(%rdi), %xmm10
pxor	%xmm0, %xmm1
aesdeclast	%xmm11, %xmm3
pxor	%xmm0, %xmm10
movdqu	0x70(%rdi), %xmm0
aesdeclast	%xmm12, %xmm4
leaq	0x80(%rdi), %rdi
movdqu	(%rbp), %xmm11
aesdeclast	%xmm13, %xmm5
aesdeclast	%xmm14, %xmm6
movdqu	0x10(%rbp), %xmm12
movdqu	0x20(%rbp), %xmm13
aesdeclast	%xmm15, %xmm7
aesdeclast	%xmm1, %xmm8
movdqu	0x30(%rbp), %xmm14
movdqu	0x40(%rbp), %xmm15
aesdeclast	%xmm10, %xmm9
movdqa	%xmm0, %xmm10
movdqu	0x50(%rbp), %xmm1
movups	-0x70(%rcx), %xmm0
movups	%xmm2, (%rsi)
movdqa	%xmm11, %xmm2
movups	%xmm3, 0x10(%rsi)
movdqa	%xmm12, %xmm3
movups	%xmm4, 0x20(%rsi)
movdqa	%xmm13, %xmm4
movups	%xmm5, 0x30(%rsi)
movdqa	%xmm14, %xmm5
movups	%xmm6, 0x40(%rsi)
movdqa	%xmm15, %xmm6
movups	%xmm7, 0x50(%rsi)
movdqa	%xmm1, %xmm7
movups	%xmm8, 0x60(%rsi)
leaq	0x70(%rsi), %rsi
subq	$0x80, %rdx
ja	L_3570
movaps	%xmm9, %xmm2
leaq	-0x70(%rcx), %rcx
addq	$0x70, %rdx
jle	L_3ca0
movups	%xmm9, (%rsi)
leaq	0x10(%rsi), %rsi
cmpq	$0x50, %rdx
jbe	L_3aef
movaps	%xmm11, %xmm2
L_3946:
cmpq	$0x60, %rdx
ja	L_39b0
movaps	%xmm7, %xmm8
callq	_aesni_decrypt6
pxor	%xmm10, %xmm2
movaps	%xmm8, %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
pxor	%xmm13, %xmm5
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
pxor	%xmm14, %xmm6
movdqu	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
pxor	%xmm15, %xmm7
movdqu	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm6
leaq	0x50(%rsi), %rsi
movdqa	%xmm7, %xmm2
pxor	%xmm7, %xmm7
jmp	L_3cbe
L_39b0:
movups	0x60(%rdi), %xmm8
xorps	%xmm9, %xmm9
callq	_aesni_decrypt8
movups	0x50(%rdi), %xmm9
pxor	%xmm10, %xmm2
movups	0x60(%rdi), %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
pxor	%xmm13, %xmm5
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
pxor	%xmm14, %xmm6
movdqu	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
pxor	%xmm15, %xmm7
movdqu	%xmm6, 0x40(%rsi)
pxor	%xmm6, %xmm6
pxor	%xmm9, %xmm8
movdqu	%xmm7, 0x50(%rsi)
pxor	%xmm7, %xmm7
leaq	0x60(%rsi), %rsi
movdqa	%xmm8, %xmm2
pxor	%xmm8, %xmm8
pxor	%xmm9, %xmm9
jmp	L_3cbe
nopw	%cs:(%rax,%rax)
nop
L_3a40:
movups	%xmm7, (%rsi)
leaq	0x10(%rsi), %rsi
movdqu	(%rdi), %xmm2
movdqu	0x10(%rdi), %xmm3
movdqa	%xmm2, %xmm11
movdqu	0x20(%rdi), %xmm4
movdqa	%xmm3, %xmm12
movdqu	0x30(%rdi), %xmm5
movdqa	%xmm4, %xmm13
movdqu	0x40(%rdi), %xmm6
movdqa	%xmm5, %xmm14
movdqu	0x50(%rdi), %xmm7
movdqa	%xmm6, %xmm15
L_3a7d:
leaq	0x60(%rdi), %rdi
movdqa	%xmm7, %xmm8
callq	_aesni_decrypt6
pxor	%xmm10, %xmm2
movdqa	%xmm8, %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm13, %xmm5
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm14, %xmm6
movq	%rbp, %rcx
movdqu	%xmm5, 0x30(%rsi)
pxor	%xmm15, %xmm7
movl	%r10d, %eax
movdqu	%xmm6, 0x40(%rsi)
leaq	0x50(%rsi), %rsi
subq	$0x60, %rdx
ja	L_3a40
movdqa	%xmm7, %xmm2
addq	$0x50, %rdx
jle	L_3ca0
movups	%xmm7, (%rsi)
leaq	0x10(%rsi), %rsi
L_3aef:
movups	(%rdi), %xmm2
subq	$0x10, %rdx
jbe	L_3ba0
movups	0x10(%rdi), %xmm3
movaps	%xmm2, %xmm11
subq	$0x10, %rdx
jbe	L_3be0
movups	0x20(%rdi), %xmm4
movaps	%xmm3, %xmm12
subq	$0x10, %rdx
jbe	L_3c10
movups	0x30(%rdi), %xmm5
movaps	%xmm4, %xmm13
subq	$0x10, %rdx
jbe	L_3c50
movups	0x40(%rdi), %xmm6
movaps	%xmm5, %xmm14
movaps	%xmm6, %xmm15
xorps	%xmm7, %xmm7
callq	_aesni_decrypt6
pxor	%xmm10, %xmm2
movaps	%xmm15, %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
pxor	%xmm13, %xmm5
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
pxor	%xmm14, %xmm6
movdqu	%xmm5, 0x30(%rsi)
pxor	%xmm5, %xmm5
leaq	0x40(%rsi), %rsi
movdqa	%xmm6, %xmm2
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
subq	$0x10, %rdx
jmp	L_3cbe
nopl	(%rax,%rax)
L_3ba0:
movaps	%xmm2, %xmm11
movups	(%rcx), %xmm0
movups	0x10(%rcx), %xmm1
leaq	0x20(%rcx), %rcx
xorps	%xmm0, %xmm2
L_3bb2:
aesdec	%xmm1, %xmm2
decl	%eax
movups	(%rcx), %xmm1
leaq	0x10(%rcx), %rcx
jne	L_3bb2
aesdeclast	%xmm1, %xmm2
xorps	%xmm10, %xmm2
movaps	%xmm11, %xmm10
jmp	L_3cbe
nopw	%cs:(%rax,%rax)
nop
L_3be0:
movaps	%xmm3, %xmm12
callq	_aesni_decrypt2
pxor	%xmm10, %xmm2
movaps	%xmm12, %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
movdqa	%xmm3, %xmm2
pxor	%xmm3, %xmm3
leaq	0x10(%rsi), %rsi
jmp	L_3cbe
nopl	(%rax)
L_3c10:
movaps	%xmm4, %xmm13
callq	_aesni_decrypt3
pxor	%xmm10, %xmm2
movaps	%xmm13, %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
movdqa	%xmm4, %xmm2
pxor	%xmm4, %xmm4
leaq	0x20(%rsi), %rsi
jmp	L_3cbe
nopw	(%rax,%rax)
L_3c50:
movaps	%xmm5, %xmm14
callq	_aesni_decrypt4
pxor	%xmm10, %xmm2
movaps	%xmm14, %xmm10
pxor	%xmm11, %xmm3
movdqu	%xmm2, (%rsi)
pxor	%xmm12, %xmm4
movdqu	%xmm3, 0x10(%rsi)
pxor	%xmm3, %xmm3
pxor	%xmm13, %xmm5
movdqu	%xmm4, 0x20(%rsi)
pxor	%xmm4, %xmm4
movdqa	%xmm5, %xmm2
pxor	%xmm5, %xmm5
leaq	0x30(%rsi), %rsi
jmp	L_3cbe
nopw	%cs:(%rax,%rax)
nop
L_3ca0:
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
pxor	%xmm8, %xmm8
pxor	%xmm9, %xmm9
L_3cbe:
movups	%xmm10, (%r8)
andq	$0xf, %rdx
jne	L_3ce0
movups	%xmm2, (%rsi)
pxor	%xmm2, %xmm2
jmp	L_3d02
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_3ce0:
movaps	%xmm2, (%rsp)
pxor	%xmm2, %xmm2
movq	$0x10, %rcx
movq	%rsi, %rdi
subq	%rdx, %rcx
leaq	(%rsp), %rsi
rep	movsb	(%rsi), %es:(%rdi)
nop
movdqa	%xmm2, (%rsp)
L_3d02:
xorps	%xmm0, %xmm0
pxor	%xmm1, %xmm1
movq	-0x8(%r11), %rbp
leaq	(%r11), %rsp
L_3d10:
rep	retq
nopw	%cs:(%rax,%rax)
nopl	(%rax)
aesni_set_decrypt_key:
subq	$0x8, %rsp
callq	__aesni_set_encrypt_key
shll	$0x4, %esi
testl	%eax, %eax
jne	L_3d81
leaq	0x10(%rdx,%rsi), %rdi
movups	(%rdx), %xmm0
movups	(%rdi), %xmm1
movups	%xmm0, (%rdi)
movups	%xmm1, (%rdx)
leaq	0x10(%rdx), %rdx
leaq	-0x10(%rdi), %rdi
L_3d49:
movups	(%rdx), %xmm0
movups	(%rdi), %xmm1
aesimc	%xmm0, %xmm0
aesimc	%xmm1, %xmm1
leaq	0x10(%rdx), %rdx
leaq	-0x10(%rdi), %rdi
movups	%xmm0, 0x10(%rdi)
movups	%xmm1, -0x10(%rdx)
cmpq	%rdx, %rdi
ja	L_3d49
movups	(%rdx), %xmm0
aesimc	%xmm0, %xmm0
pxor	%xmm1, %xmm1
movups	%xmm0, (%rdi)
pxor	%xmm0, %xmm0
L_3d81:
addq	$0x8, %rsp
rep	retq
nopw	(%rax,%rax)
__aesni_set_encrypt_key:
aesni_set_encrypt_key:
subq	$0x8, %rsp
movq	$-0x1, %rax
testq	%rdi, %rdi
je	L_4207
testq	%rdx, %rdx
je	L_4207
movl	$0x10000800, %r10d
movups	(%rdi), %xmm0
xorps	%xmm4, %xmm4
andl	OPENSSL_ia32cap_P+4(%rip), %r10d
leaq	0x10(%rdx), %rax
cmpl	$0x100, %esi
je	L_4080
cmpl	$0xc0, %esi
je	L_3f70
cmpl	$0x80, %esi
jne	L_4200
movl	$0x9, %esi
cmpl	$0x10000000, %r10d
je	L_3e80
movups	%xmm0, (%rdx)
aeskeygenassist	$0x1, %xmm0, %xmm1
callq	L_4237
aeskeygenassist	$0x2, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x4, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x8, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x10, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x20, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x40, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x80, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x1b, %xmm0, %xmm1
callq	L_4230
aeskeygenassist	$0x36, %xmm0, %xmm1
callq	L_4230
movups	%xmm0, (%rax)
movl	%esi, 0x50(%rax)
xorl	%eax, %eax
jmp	L_4207
nopl	(%rax,%rax)
L_3e80:
movdqa	bums_rodata+80(%rip), %xmm5
movl	$0x8, %r10d
movdqa	bums_rodata+112(%rip), %xmm4
movdqa	%xmm0, %xmm2
movdqu	%xmm0, (%rdx)
jmp	L_3ea0
L_3ea0:
pshufb	%xmm5, %xmm0
aesenclast	%xmm4, %xmm0
pslld	$0x1, %xmm4
leaq	0x10(%rax), %rax
movdqa	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm0
movdqu	%xmm0, -0x10(%rax)
movdqa	%xmm0, %xmm2
decl	%r10d
jne	L_3ea0
movdqa	bums_rodata+128(%rip), %xmm4
pshufb	%xmm5, %xmm0
aesenclast	%xmm4, %xmm0
pslld	$0x1, %xmm4
movdqa	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm0
movdqu	%xmm0, (%rax)
movdqa	%xmm0, %xmm2
pshufb	%xmm5, %xmm0
aesenclast	%xmm4, %xmm0
movdqa	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm2, %xmm3
pslldq	$0x4, %xmm2
pxor	%xmm3, %xmm2
pxor	%xmm2, %xmm0
movdqu	%xmm0, 0x10(%rax)
movl	%esi, 0x60(%rax)
xorl	%eax, %eax
jmp	L_4207
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_3f70:
movq	0x10(%rdi), %xmm2
movl	$0xb, %esi
cmpl	$0x10000000, %r10d
je	L_3ff0
movups	%xmm0, (%rdx)
aeskeygenassist	$0x1, %xmm2, %xmm1
callq	L_4257
aeskeygenassist	$0x2, %xmm2, %xmm1
callq	L_4290
aeskeygenassist	$0x4, %xmm2, %xmm1
callq	L_4250
aeskeygenassist	$0x8, %xmm2, %xmm1
callq	L_4290
aeskeygenassist	$0x10, %xmm2, %xmm1
callq	L_4250
aeskeygenassist	$0x20, %xmm2, %xmm1
callq	L_4290
aeskeygenassist	$0x40, %xmm2, %xmm1
callq	L_4250
aeskeygenassist	$0x80, %xmm2, %xmm1
callq	L_4290
movups	%xmm0, (%rax)
movl	%esi, 0x30(%rax)
xorq	%rax, %rax
jmp	L_4207
nopl	(%rax)
L_3ff0:
movdqa	bums_rodata+96(%rip), %xmm5
movdqa	bums_rodata+112(%rip), %xmm4
movl	$0x8, %r10d
movdqu	%xmm0, (%rdx)
jmp	L_4010
nopl	(%rax)
L_4010:
movq	%xmm2, (%rax)
movdqa	%xmm2, %xmm1
pshufb	%xmm5, %xmm2
aesenclast	%xmm4, %xmm2
pslld	$0x1, %xmm4
leaq	0x18(%rax), %rax
movdqa	%xmm0, %xmm3
pslldq	$0x4, %xmm0
pxor	%xmm0, %xmm3
pslldq	$0x4, %xmm0
pxor	%xmm0, %xmm3
pslldq	$0x4, %xmm0
pxor	%xmm3, %xmm0
pshufd	$0xff, %xmm0, %xmm3
pxor	%xmm1, %xmm3
pslldq	$0x4, %xmm1
pxor	%xmm1, %xmm3
pxor	%xmm2, %xmm0
pxor	%xmm3, %xmm2
movdqu	%xmm0, -0x10(%rax)
decl	%r10d
jne	L_4010
movl	%esi, 0x20(%rax)
xorl	%eax, %eax
jmp	L_4207
nopl	(%rax,%rax)
L_4080:
movups	0x10(%rdi), %xmm2
movl	$0xd, %esi
leaq	0x10(%rax), %rax
cmpl	$0x10000000, %r10d
je	L_4140
movups	%xmm0, (%rdx)
movups	%xmm2, 0x10(%rdx)
aeskeygenassist	$0x1, %xmm2, %xmm1
callq	L_42b7
aeskeygenassist	$0x1, %xmm0, %xmm1
callq	L_42d0
aeskeygenassist	$0x2, %xmm2, %xmm1
callq	L_42b0
aeskeygenassist	$0x2, %xmm0, %xmm1
callq	L_42d0
aeskeygenassist	$0x4, %xmm2, %xmm1
callq	L_42b0
aeskeygenassist	$0x4, %xmm0, %xmm1
callq	L_42d0
aeskeygenassist	$0x8, %xmm2, %xmm1
callq	L_42b0
aeskeygenassist	$0x8, %xmm0, %xmm1
callq	L_42d0
aeskeygenassist	$0x10, %xmm2, %xmm1
callq	L_42b0
aeskeygenassist	$0x10, %xmm0, %xmm1
callq	L_42d0
aeskeygenassist	$0x20, %xmm2, %xmm1
callq	L_42b0
aeskeygenassist	$0x20, %xmm0, %xmm1
callq	L_42d0
aeskeygenassist	$0x40, %xmm2, %xmm1
callq	L_42b0
movups	%xmm0, (%rax)
movl	%esi, 0x10(%rax)
xorq	%rax, %rax
jmp	L_4207
nop
L_4140:
movdqa	bums_rodata+80(%rip), %xmm5
movdqa	bums_rodata+112(%rip), %xmm4
movl	$0x7, %r10d
movdqu	%xmm0, (%rdx)
movdqa	%xmm2, %xmm1
movdqu	%xmm2, 0x10(%rdx)
jmp	L_4170
nopw	%cs:(%rax,%rax)
nop
L_4170:
pshufb	%xmm5, %xmm2
aesenclast	%xmm4, %xmm2
movdqa	%xmm0, %xmm3
pslldq	$0x4, %xmm0
pxor	%xmm0, %xmm3
pslldq	$0x4, %xmm0
pxor	%xmm0, %xmm3
pslldq	$0x4, %xmm0
pxor	%xmm3, %xmm0
pslld	$0x1, %xmm4
pxor	%xmm2, %xmm0
movdqu	%xmm0, (%rax)
decl	%r10d
je	L_41eb
pshufd	$0xff, %xmm0, %xmm2
pxor	%xmm3, %xmm3
aesenclast	%xmm3, %xmm2
movdqa	%xmm1, %xmm3
pslldq	$0x4, %xmm1
pxor	%xmm1, %xmm3
pslldq	$0x4, %xmm1
pxor	%xmm1, %xmm3
pslldq	$0x4, %xmm1
pxor	%xmm3, %xmm1
pxor	%xmm1, %xmm2
movdqu	%xmm2, 0x10(%rax)
leaq	0x20(%rax), %rax
movdqa	%xmm2, %xmm1
jmp	L_4170
L_41eb:
movl	%esi, 0x10(%rax)
xorl	%eax, %eax
jmp	L_4207
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_4200:
movq	$-0x2, %rax
L_4207:
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
addq	$0x8, %rsp
rep	retq
nopw	%cs:(%rax,%rax)
nop
L_4230:
movups	%xmm0, (%rax)
leaq	0x10(%rax), %rax
L_4237:
shufps	$0x10, %xmm0, %xmm4
xorps	%xmm4, %xmm0
shufps	$0x8c, %xmm0, %xmm4
xorps	%xmm4, %xmm0
shufps	$0xff, %xmm1, %xmm1
xorps	%xmm1, %xmm0
rep	retq
nop
L_4250:
movups	%xmm0, (%rax)
leaq	0x10(%rax), %rax
L_4257:
movaps	%xmm2, %xmm5
L_425a:
shufps	$0x10, %xmm0, %xmm4
movdqa	%xmm2, %xmm3
xorps	%xmm4, %xmm0
shufps	$0x8c, %xmm0, %xmm4
pslldq	$0x4, %xmm3
xorps	%xmm4, %xmm0
pshufd	$0x55, %xmm1, %xmm1
pxor	%xmm3, %xmm2
pxor	%xmm1, %xmm0
pshufd	$0xff, %xmm0, %xmm3
pxor	%xmm3, %xmm2
rep	retq
nopl	(%rax)
L_4290:
movaps	%xmm0, %xmm3
shufps	$0x44, %xmm0, %xmm5
movups	%xmm5, (%rax)
shufps	$0x4e, %xmm2, %xmm3
movups	%xmm3, 0x10(%rax)
leaq	0x20(%rax), %rax
jmp	L_425a
nopl	(%rax,%rax)
L_42b0:
movups	%xmm2, (%rax)
leaq	0x10(%rax), %rax
L_42b7:
shufps	$0x10, %xmm0, %xmm4
xorps	%xmm4, %xmm0
shufps	$0x8c, %xmm0, %xmm4
xorps	%xmm4, %xmm0
shufps	$0xff, %xmm1, %xmm1
xorps	%xmm1, %xmm0
rep	retq
nop
L_42d0:
movups	%xmm0, (%rax)
leaq	0x10(%rax), %rax
shufps	$0x10, %xmm2, %xmm4
xorps	%xmm4, %xmm2
shufps	$0x8c, %xmm2, %xmm4
xorps	%xmm4, %xmm2
shufps	$0xaa, %xmm1, %xmm1
xorps	%xmm1, %xmm2
rep	retq
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 6,0,0,0,6,0,0,0,6,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 135,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
	.byte 13,14,15,12,13,14,15,12,13,14,15,12,13,14,15,12
	.byte 5,6,7,4,5,6,7,4,5,6,7,4,5,6,7,4
	.byte 1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0
	.byte 27,0,0,0,27,0,0,0,27,0,0,0,27,0,0,0
	.byte 65,69,83,32,102,111,114,32,73,110,116,101,108,32,65,69
	.byte 83,45,78,73,44,32,67,82,89,80,84,79,71,65,77,83
	.byte 32,98,121,32,60,104,116,116,112,115,58,47,47,103,105,116
	.byte 104,117,98,46,99,111,109,47,100,111,116,45,97,115,109,62
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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

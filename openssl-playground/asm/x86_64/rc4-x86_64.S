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
nopw	(%rax,%rax)
RC4_options:
endbr64
leaq	bums_rodata_in_text(%rip), %rax
movl	OPENSSL_ia32cap_P(%rip), %edx
btl	$0x14, %edx
jb	L_753
btl	$0x1e, %edx
jae	L_757
addq	$0x19, %rax
rep	retq
L_753:
addq	$0xc, %rax
L_757:
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
	.section .rodata_in_text
bums_rodata_in_text:
	.byte 114,99,52,40,56,120,44,105,110,116,41,0,114,99,52,40
	.byte 56,120,44,99,104,97,114,41,0,114,99,52,40,49,54,120
	.byte 44,105,110,116,41,0,102,46,15,31,132,0,0,0,0,0
	.byte 102,46,15,31,132,0,0,0,0,0,102,15,31,68,0,0
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

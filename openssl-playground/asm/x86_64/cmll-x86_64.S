	.text
Camellia_EncryptBlock:
movl	$0x80, %eax
subl	%edi, %eax
movl	$0x3, %edi
adcl	$0x0, %edi
jmp	Camellia_EncryptBlock_Rounds
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Camellia_EncryptBlock_Rounds:
pushq	%rbx
pushq	%rbp
pushq	%r13
pushq	%r14
pushq	%r15
movq	%rcx, %r13
movq	%rdx, %r14
shll	$0x6, %edi
leaq	bums_rodata+64(%rip), %rbp
leaq	(%r14,%rdi), %r15
movl	(%rsi), %r8d
movl	0x4(%rsi), %r9d
movl	0x8(%rsi), %r10d
bswapl	%r8d
movl	0xc(%rsi), %r11d
bswapl	%r9d
bswapl	%r10d
bswapl	%r11d
callq	_x86_64_Camellia_encrypt
bswapl	%r8d
bswapl	%r9d
bswapl	%r10d
movl	%r8d, (%r13)
bswapl	%r11d
movl	%r9d, 0x4(%r13)
movl	%r10d, 0x8(%r13)
movl	%r11d, 0xc(%r13)
movq	(%rsp), %r15
movq	0x8(%rsp), %r14
movq	0x10(%rsp), %r13
movq	0x18(%rsp), %rbp
movq	0x20(%rsp), %rbx
leaq	0x28(%rsp), %rsp
rep	retq
nopw	(%rax,%rax)
_x86_64_Camellia_encrypt:
xorl	(%r14), %r9d
xorl	0x4(%r14), %r8d
xorl	0x8(%r14), %r11d
xorl	0xc(%r14), %r10d
nop
L_b0:
movl	0x10(%r14), %ebx
movl	0x14(%r14), %eax
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x18(%r14), %ebx
movl	0x1c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x20(%r14), %ebx
movl	0x24(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x28(%r14), %ebx
movl	0x2c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x30(%r14), %ebx
movl	0x34(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x38(%r14), %ebx
movl	0x3c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x40(%r14), %ebx
movl	0x44(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
leaq	0x40(%r14), %r14
cmpq	%r15, %r14
movl	0x8(%r14), %edx
movl	0xc(%r14), %ecx
je	L_350
andl	%r8d, %eax
orl	%r11d, %edx
roll	%eax
xorl	%edx, %r10d
xorl	%eax, %r9d
andl	%r10d, %ecx
orl	%r9d, %ebx
roll	%ecx
xorl	%ebx, %r8d
xorl	%ecx, %r11d
jmp	L_b0
nop
L_350:
xorl	%r10d, %eax
xorl	%r11d, %ebx
xorl	%r8d, %ecx
xorl	%r9d, %edx
movl	%eax, %r8d
movl	%ebx, %r9d
movl	%ecx, %r10d
movl	%edx, %r11d
rep	retq
nopw	(%rax,%rax)
Camellia_DecryptBlock:
movl	$0x80, %eax
subl	%edi, %eax
movl	$0x3, %edi
adcl	$0x0, %edi
jmp	Camellia_DecryptBlock_Rounds
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
Camellia_DecryptBlock_Rounds:
pushq	%rbx
pushq	%rbp
pushq	%r13
pushq	%r14
pushq	%r15
movq	%rcx, %r13
movq	%rdx, %r15
shll	$0x6, %edi
leaq	bums_rodata+64(%rip), %rbp
leaq	(%r15,%rdi), %r14
movl	(%rsi), %r8d
movl	0x4(%rsi), %r9d
movl	0x8(%rsi), %r10d
bswapl	%r8d
movl	0xc(%rsi), %r11d
bswapl	%r9d
bswapl	%r10d
bswapl	%r11d
callq	_x86_64_Camellia_decrypt
bswapl	%r8d
bswapl	%r9d
bswapl	%r10d
movl	%r8d, (%r13)
bswapl	%r11d
movl	%r9d, 0x4(%r13)
movl	%r10d, 0x8(%r13)
movl	%r11d, 0xc(%r13)
movq	(%rsp), %r15
movq	0x8(%rsp), %r14
movq	0x10(%rsp), %r13
movq	0x18(%rsp), %rbp
movq	0x20(%rsp), %rbx
leaq	0x28(%rsp), %rsp
rep	retq
nopw	(%rax,%rax)
_x86_64_Camellia_decrypt:
xorl	(%r14), %r9d
xorl	0x4(%r14), %r8d
xorl	0x8(%r14), %r11d
xorl	0xc(%r14), %r10d
nop
L_420:
movl	-0x8(%r14), %ebx
movl	-0x4(%r14), %eax
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	-0x10(%r14), %ebx
movl	-0xc(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	-0x18(%r14), %ebx
movl	-0x14(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	-0x20(%r14), %ebx
movl	-0x1c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	-0x28(%r14), %ebx
movl	-0x24(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	-0x30(%r14), %ebx
movl	-0x2c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	-0x38(%r14), %ebx
movl	-0x34(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
leaq	-0x40(%r14), %r14
cmpq	%r15, %r14
movl	(%r14), %edx
movl	0x4(%r14), %ecx
je	L_6c0
andl	%r8d, %eax
orl	%r11d, %edx
roll	%eax
xorl	%edx, %r10d
xorl	%eax, %r9d
andl	%r10d, %ecx
orl	%r9d, %ebx
roll	%ecx
xorl	%ebx, %r8d
xorl	%ecx, %r11d
jmp	L_420
nopl	(%rax)
L_6c0:
xorl	%r10d, %ecx
xorl	%r11d, %edx
xorl	%r8d, %eax
xorl	%r9d, %ebx
movl	%ecx, %r8d
movl	%edx, %r9d
movl	%eax, %r10d
movl	%ebx, %r11d
rep	retq
nopw	(%rax,%rax)
Camellia_Ekeygen:
pushq	%rbx
pushq	%rbp
pushq	%r13
pushq	%r14
pushq	%r15
movl	%edi, %r15d
movq	%rdx, %r13
movl	(%rsi), %r8d
movl	0x4(%rsi), %r9d
movl	0x8(%rsi), %r10d
movl	0xc(%rsi), %r11d
bswapl	%r8d
bswapl	%r9d
bswapl	%r10d
bswapl	%r11d
movl	%r9d, (%r13)
movl	%r8d, 0x4(%r13)
movl	%r11d, 0x8(%r13)
movl	%r10d, 0xc(%r13)
cmpq	$0x80, %r15
je	L_775
movl	0x10(%rsi), %r8d
movl	0x14(%rsi), %r9d
cmpq	$0xc0, %r15
je	L_73d
movl	0x18(%rsi), %r10d
movl	0x1c(%rsi), %r11d
jmp	L_749
L_73d:
movl	%r8d, %r10d
movl	%r9d, %r11d
notl	%r10d
notl	%r11d
L_749:
bswapl	%r8d
bswapl	%r9d
bswapl	%r10d
bswapl	%r11d
movl	%r9d, 0x20(%r13)
movl	%r8d, 0x24(%r13)
movl	%r11d, 0x28(%r13)
movl	%r10d, 0x2c(%r13)
xorl	(%r13), %r9d
xorl	0x4(%r13), %r8d
xorl	0x8(%r13), %r11d
xorl	0xc(%r13), %r10d
L_775:
leaq	bums_rodata(%rip), %r14
leaq	bums_rodata+64(%rip), %rbp
movl	(%r14), %ebx
movl	0x4(%r14), %eax
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x8(%r14), %ebx
movl	0xc(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x10(%r14), %ebx
movl	0x14(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
xorl	(%r13), %r9d
xorl	0x4(%r13), %r8d
xorl	0x8(%r13), %r11d
xorl	0xc(%r13), %r10d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x18(%r14), %ebx
movl	0x1c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x20(%r14), %ebx
movl	0x24(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
cmpq	$0x80, %r15
jne	L_b20
leaq	0x80(%r13), %r13
shlq	$0x20, %r8
shlq	$0x20, %r10
orq	%r9, %r8
orq	%r11, %r10
movq	-0x80(%r13), %rax
movq	-0x78(%r13), %rbx
movq	%r8, -0x70(%r13)
movq	%r10, -0x68(%r13)
movq	%rax, %r11
shlq	$0xf, %rax
movq	%rbx, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %rax
shlq	$0xf, %rbx
orq	%r11, %rbx
movq	%rax, -0x60(%r13)
movq	%rbx, -0x58(%r13)
movq	%r8, %r11
shlq	$0xf, %r8
movq	%r10, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %r8
shlq	$0xf, %r10
orq	%r11, %r10
movq	%r8, -0x50(%r13)
movq	%r10, -0x48(%r13)
movq	%r8, %r11
shlq	$0xf, %r8
movq	%r10, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %r8
shlq	$0xf, %r10
orq	%r11, %r10
movq	%r8, -0x40(%r13)
movq	%r10, -0x38(%r13)
movq	%rax, %r11
shlq	$0x1e, %rax
movq	%rbx, %r9
shrq	$0x22, %r9
shrq	$0x22, %r11
orq	%r9, %rax
shlq	$0x1e, %rbx
orq	%r11, %rbx
movq	%rax, -0x30(%r13)
movq	%rbx, -0x28(%r13)
movq	%r8, %r11
shlq	$0xf, %r8
movq	%r10, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %r8
shlq	$0xf, %r10
orq	%r11, %r10
movq	%r8, -0x20(%r13)
movq	%rax, %r11
shlq	$0xf, %rax
movq	%rbx, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %rax
shlq	$0xf, %rbx
orq	%r11, %rbx
movq	%rbx, -0x18(%r13)
movq	%r8, %r11
shlq	$0xf, %r8
movq	%r10, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %r8
shlq	$0xf, %r10
orq	%r11, %r10
movq	%r8, -0x10(%r13)
movq	%r10, -0x8(%r13)
movq	%rax, %r11
shlq	$0x11, %rax
movq	%rbx, %r9
shrq	$0x2f, %r9
shrq	$0x2f, %r11
orq	%r9, %rax
shlq	$0x11, %rbx
orq	%r11, %rbx
movq	%rax, (%r13)
movq	%rbx, 0x8(%r13)
movq	%rax, %r11
shlq	$0x11, %rax
movq	%rbx, %r9
shrq	$0x2f, %r9
shrq	$0x2f, %r11
orq	%r9, %rax
shlq	$0x11, %rbx
orq	%r11, %rbx
movq	%rax, 0x10(%r13)
movq	%rbx, 0x18(%r13)
movq	%r8, %r11
shlq	$0x22, %r8
movq	%r10, %r9
shrq	$0x1e, %r9
shrq	$0x1e, %r11
orq	%r9, %r8
shlq	$0x22, %r10
orq	%r11, %r10
movq	%r8, 0x20(%r13)
movq	%r10, 0x28(%r13)
movq	%rax, %r11
shlq	$0x11, %rax
movq	%rbx, %r9
shrq	$0x2f, %r9
shrq	$0x2f, %r11
orq	%r9, %rax
shlq	$0x11, %rbx
orq	%r11, %rbx
movq	%rax, 0x30(%r13)
movq	%rbx, 0x38(%r13)
movq	%r8, %r11
shlq	$0x11, %r8
movq	%r10, %r9
shrq	$0x2f, %r9
shrq	$0x2f, %r11
orq	%r9, %r8
shlq	$0x11, %r10
orq	%r11, %r10
movq	%r8, 0x40(%r13)
movq	%r10, 0x48(%r13)
movl	$0x3, %eax
jmp	L_e68
nopw	%cs:(%rax,%rax)
L_b20:
movl	%r9d, 0x30(%r13)
movl	%r8d, 0x34(%r13)
movl	%r11d, 0x38(%r13)
movl	%r10d, 0x3c(%r13)
xorl	0x20(%r13), %r9d
xorl	0x24(%r13), %r8d
xorl	0x28(%r13), %r11d
xorl	0x2c(%r13), %r10d
xorl	%r8d, %eax
xorl	%r9d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x28(%r14), %ebx
movl	0x2c(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r10d
xorl	%ecx, %r11d
xorl	%edx, %r11d
xorl	%r10d, %eax
xorl	%r11d, %ebx
movzbl	%ah, %esi
movzbl	%bl, %edi
movl	0x804(%rbp,%rsi,8), %edx
movl	(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
shrl	$0x10, %eax
movzbl	%bh, %edi
xorl	0x4(%rbp,%rsi,8), %edx
shrl	$0x10, %ebx
xorl	0x4(%rbp,%rdi,8), %ecx
movzbl	%ah, %esi
movzbl	%bl, %edi
xorl	(%rbp,%rsi,8), %edx
xorl	0x804(%rbp,%rdi,8), %ecx
movzbl	%al, %esi
movzbl	%bh, %edi
xorl	0x800(%rbp,%rsi,8), %edx
xorl	0x800(%rbp,%rdi,8), %ecx
movl	0x30(%r14), %ebx
movl	0x34(%r14), %eax
xorl	%edx, %ecx
rorl	$0x8, %edx
xorl	%ecx, %r8d
xorl	%ecx, %r9d
xorl	%edx, %r9d
movq	(%r13), %rax
movq	0x8(%r13), %rbx
movq	0x20(%r13), %rcx
movq	0x28(%r13), %rdx
movq	0x30(%r13), %r14
movq	0x38(%r13), %r15
leaq	0x80(%r13), %r13
shlq	$0x20, %r8
shlq	$0x20, %r10
orq	%r9, %r8
orq	%r11, %r10
movq	%r8, -0x70(%r13)
movq	%r10, -0x68(%r13)
movq	%rcx, %r11
shlq	$0xf, %rcx
movq	%rdx, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %rcx
shlq	$0xf, %rdx
orq	%r11, %rdx
movq	%rcx, -0x60(%r13)
movq	%rdx, -0x58(%r13)
movq	%r14, %r11
shlq	$0xf, %r14
movq	%r15, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %r14
shlq	$0xf, %r15
orq	%r11, %r15
movq	%r14, -0x50(%r13)
movq	%r15, -0x48(%r13)
movq	%rcx, %r11
shlq	$0xf, %rcx
movq	%rdx, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %rcx
shlq	$0xf, %rdx
orq	%r11, %rdx
movq	%rcx, -0x40(%r13)
movq	%rdx, -0x38(%r13)
movq	%r8, %r11
shlq	$0x1e, %r8
movq	%r10, %r9
shrq	$0x22, %r9
shrq	$0x22, %r11
orq	%r9, %r8
shlq	$0x1e, %r10
orq	%r11, %r10
movq	%r8, -0x30(%r13)
movq	%r10, -0x28(%r13)
movq	%rax, %r11
shlq	$0x2d, %rax
movq	%rbx, %r9
shrq	$0x13, %r9
shrq	$0x13, %r11
orq	%r9, %rax
shlq	$0x2d, %rbx
orq	%r11, %rbx
movq	%rax, -0x20(%r13)
movq	%rbx, -0x18(%r13)
movq	%r14, %r11
shlq	$0x1e, %r14
movq	%r15, %r9
shrq	$0x22, %r9
shrq	$0x22, %r11
orq	%r9, %r14
shlq	$0x1e, %r15
orq	%r11, %r15
movq	%r14, -0x10(%r13)
movq	%r15, -0x8(%r13)
movq	%rax, %r11
shlq	$0xf, %rax
movq	%rbx, %r9
shrq	$0x31, %r9
shrq	$0x31, %r11
orq	%r9, %rax
shlq	$0xf, %rbx
orq	%r11, %rbx
movq	%rax, (%r13)
movq	%rbx, 0x8(%r13)
movq	%rcx, %r11
shlq	$0x1e, %rcx
movq	%rdx, %r9
shrq	$0x22, %r9
shrq	$0x22, %r11
orq	%r9, %rcx
shlq	$0x1e, %rdx
orq	%r11, %rdx
movq	%rcx, 0x10(%r13)
movq	%rdx, 0x18(%r13)
movq	%r8, %r11
shlq	$0x1e, %r8
movq	%r10, %r9
shrq	$0x22, %r9
shrq	$0x22, %r11
orq	%r9, %r8
shlq	$0x1e, %r10
orq	%r11, %r10
movq	%r8, 0x20(%r13)
movq	%r10, 0x28(%r13)
movq	%rax, %r11
shlq	$0x11, %rax
movq	%rbx, %r9
shrq	$0x2f, %r9
shrq	$0x2f, %r11
orq	%r9, %rax
shlq	$0x11, %rbx
orq	%r11, %rbx
movq	%rax, 0x30(%r13)
movq	%rbx, 0x38(%r13)
movq	%r14, %r11
shlq	$0x20, %r14
movq	%r15, %r9
shrq	$0x20, %r9
shrq	$0x20, %r11
orq	%r9, %r14
shlq	$0x20, %r15
orq	%r11, %r15
movq	%r14, 0x40(%r13)
movq	%r15, 0x48(%r13)
movq	%rcx, %r11
shlq	$0x22, %rcx
movq	%rdx, %r9
shrq	$0x1e, %r9
shrq	$0x1e, %r11
orq	%r9, %rcx
shlq	$0x22, %rdx
orq	%r11, %rdx
movq	%rcx, 0x50(%r13)
movq	%rdx, 0x58(%r13)
movq	%r14, %r11
shlq	$0x11, %r14
movq	%r15, %r9
shrq	$0x2f, %r9
shrq	$0x2f, %r11
orq	%r9, %r14
shlq	$0x11, %r15
orq	%r11, %r15
movq	%r14, 0x60(%r13)
movq	%r15, 0x68(%r13)
movq	%rax, %r11
shlq	$0x22, %rax
movq	%rbx, %r9
shrq	$0x1e, %r9
shrq	$0x1e, %r11
orq	%r9, %rax
shlq	$0x22, %rbx
orq	%r11, %rbx
movq	%rax, 0x70(%r13)
movq	%rbx, 0x78(%r13)
movq	%r8, %r11
shlq	$0x33, %r8
movq	%r10, %r9
shrq	$0xd, %r9
shrq	$0xd, %r11
orq	%r9, %r8
shlq	$0x33, %r10
orq	%r11, %r10
movq	%r8, 0x80(%r13)
movq	%r10, 0x88(%r13)
movl	$0x4, %eax
L_e68:
movq	(%rsp), %r15
movq	0x8(%rsp), %r14
movq	0x10(%rsp), %r13
movq	0x18(%rsp), %rbp
movq	0x20(%rsp), %rbx
leaq	0x28(%rsp), %rsp
rep	retq
nopw	(%rax,%rax)
Camellia_cbc_encrypt:
endbr64
cmpq	$0x0, %rdx
je	L_1160
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movq	%rsp, %rbp
subq	$0x40, %rsp
andq	$-0x40, %rsp
leaq	-0x7f(%rcx), %r10
subq	%rsp, %r10
negq	%r10
andq	$0x3c0, %r10
subq	%r10, %rsp
movq	%rdi, %r12
movq	%rsi, %r13
movq	%r8, %rbx
movq	%rcx, %r14
movl	0x110(%rcx), %r15d
movq	%r8, 0x28(%rsp)
movq	%rbp, 0x30(%rsp)
leaq	bums_rodata+64(%rip), %rbp
movl	$0x20, %ecx
L_ef0:
movq	(%rbp), %rax
movq	0x20(%rbp), %rsi
movq	0x40(%rbp), %rdi
movq	0x60(%rbp), %r11
leaq	0x80(%rbp), %rbp
loop	L_ef0
subq	$0x1000, %rbp
shlq	$0x6, %r15
movq	%rdx, %rcx
leaq	(%r14,%r15), %r15
cmpl	$0x0, %r9d
je	L_1020
andq	$-0x10, %rdx
andq	$0xf, %rcx
leaq	(%r12,%rdx), %rdx
movq	%r14, (%rsp)
movq	%rdx, 0x8(%rsp)
movq	%rcx, 0x10(%rsp)
cmpq	%r12, %rdx
movl	(%rbx), %r8d
movl	0x4(%rbx), %r9d
movl	0x8(%rbx), %r10d
movl	0xc(%rbx), %r11d
je	L_fe0
jmp	L_f60
nopl	(%rax)
L_f60:
xorl	(%r12), %r8d
xorl	0x4(%r12), %r9d
xorl	0x8(%r12), %r10d
bswapl	%r8d
xorl	0xc(%r12), %r11d
bswapl	%r9d
bswapl	%r10d
bswapl	%r11d
callq	_x86_64_Camellia_encrypt
movq	(%rsp), %r14
bswapl	%r8d
movq	0x8(%rsp), %rdx
bswapl	%r9d
movq	0x10(%rsp), %rcx
bswapl	%r10d
movl	%r8d, (%r13)
bswapl	%r11d
movl	%r9d, 0x4(%r13)
movl	%r10d, 0x8(%r13)
leaq	0x10(%r12), %r12
movl	%r11d, 0xc(%r13)
cmpq	%rdx, %r12
leaq	0x10(%r13), %r13
jne	L_f60
cmpq	$0x0, %rcx
jne	L_fe0
movq	0x28(%rsp), %r13
movl	%r8d, (%r13)
movl	%r9d, 0x4(%r13)
movl	%r10d, 0x8(%r13)
movl	%r11d, 0xc(%r13)
jmp	L_1140
nopl	(%rax)
L_fe0:
xorq	%rax, %rax
movq	%rax, 0x18(%rsp)
movq	%rax, 0x20(%rsp)
movq	%rax, 0x10(%rsp)
pushfq
cld
movq	%r12, %rsi
leaq	0x20(%rsp), %rdi
rep	movsb	(%rsi), %es:(%rdi)
nop
popfq
leaq	0x18(%rsp), %r12
leaq	0x28(%rsp), %rax
movq	%rax, 0x8(%rsp)
jmp	L_f60
nopw	%cs:(%rax,%rax)
nop
L_1020:
xchgq	%r14, %r15
addq	$0xf, %rdx
andq	$0xf, %rcx
andq	$-0x10, %rdx
movq	%r14, (%rsp)
leaq	(%r12,%rdx), %rdx
movq	%rdx, 0x8(%rsp)
movq	%rcx, 0x10(%rsp)
movq	(%rbx), %rax
movq	0x8(%rbx), %rbx
jmp	L_1050
nopw	(%rax,%rax)
L_1050:
movl	(%r12), %r8d
movl	0x4(%r12), %r9d
movl	0x8(%r12), %r10d
bswapl	%r8d
movl	0xc(%r12), %r11d
bswapl	%r9d
movq	%rax, 0x18(%rsp)
bswapl	%r10d
movq	%rbx, 0x20(%rsp)
bswapl	%r11d
callq	_x86_64_Camellia_decrypt
movq	(%rsp), %r14
movq	0x8(%rsp), %rdx
movq	0x10(%rsp), %rcx
bswapl	%r8d
movq	(%r12), %rax
bswapl	%r9d
movq	0x8(%r12), %rbx
bswapl	%r10d
xorl	0x18(%rsp), %r8d
bswapl	%r11d
xorl	0x1c(%rsp), %r9d
xorl	0x20(%rsp), %r10d
leaq	0x10(%r12), %r12
xorl	0x24(%rsp), %r11d
cmpq	%rdx, %r12
je	L_10e0
movl	%r8d, (%r13)
movl	%r9d, 0x4(%r13)
movl	%r10d, 0x8(%r13)
movl	%r11d, 0xc(%r13)
leaq	0x10(%r13), %r13
jmp	L_1050
nopl	(%rax,%rax)
L_10e0:
movq	0x28(%rsp), %rdx
cmpq	$0x0, %rcx
jne	L_1110
movl	%r8d, (%r13)
movl	%r9d, 0x4(%r13)
movl	%r10d, 0x8(%r13)
movl	%r11d, 0xc(%r13)
movq	%rax, (%rdx)
movq	%rbx, 0x8(%rdx)
jmp	L_1140
nopw	%cs:(%rax,%rax)
nop
L_1110:
movl	%r8d, 0x18(%rsp)
movl	%r9d, 0x1c(%rsp)
movl	%r10d, 0x20(%rsp)
movl	%r11d, 0x24(%rsp)
pushfq
cld
leaq	0x20(%rsp), %rsi
leaq	(%r13), %rdi
rep	movsb	(%rsi), %es:(%rdi)
nop
popfq
movq	%rax, (%rdx)
movq	%rbx, 0x8(%rdx)
jmp	L_1140
nopl	(%rax)
L_1140:
movq	0x30(%rsp), %rcx
movq	(%rcx), %r15
movq	0x8(%rcx), %r14
movq	0x10(%rcx), %r13
movq	0x18(%rcx), %r12
movq	0x20(%rcx), %rbp
movq	0x28(%rcx), %rbx
leaq	0x30(%rcx), %rsp
L_1160:
rep	retq
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 139,144,204,59,127,102,158,160,178,115,170,76,88,232,122,182
	.byte 190,130,79,233,47,55,239,198,28,111,211,241,165,83,255,84
	.byte 29,45,104,222,250,39,229,16,253,193,230,179,194,136,86,176
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,112,112,112,112,0,112,112,0,130,130,130,44,0,44,44
	.byte 0,44,44,44,179,0,179,179,0,236,236,236,192,0,192,192
	.byte 0,179,179,179,228,0,228,228,0,39,39,39,87,0,87,87
	.byte 0,192,192,192,234,0,234,234,0,229,229,229,174,0,174,174
	.byte 0,228,228,228,35,0,35,35,0,133,133,133,107,0,107,107
	.byte 0,87,87,87,69,0,69,69,0,53,53,53,165,0,165,165
	.byte 0,234,234,234,237,0,237,237,0,12,12,12,79,0,79,79
	.byte 0,174,174,174,29,0,29,29,0,65,65,65,146,0,146,146
	.byte 0,35,35,35,134,0,134,134,0,239,239,239,175,0,175,175
	.byte 0,107,107,107,124,0,124,124,0,147,147,147,31,0,31,31
	.byte 0,69,69,69,62,0,62,62,0,25,25,25,220,0,220,220
	.byte 0,165,165,165,94,0,94,94,0,33,33,33,11,0,11,11
	.byte 0,237,237,237,166,0,166,166,0,14,14,14,57,0,57,57
	.byte 0,79,79,79,213,0,213,213,0,78,78,78,93,0,93,93
	.byte 0,29,29,29,217,0,217,217,0,101,101,101,90,0,90,90
	.byte 0,146,146,146,81,0,81,81,0,189,189,189,108,0,108,108
	.byte 0,134,134,134,139,0,139,139,0,184,184,184,154,0,154,154
	.byte 0,175,175,175,251,0,251,251,0,143,143,143,176,0,176,176
	.byte 0,124,124,124,116,0,116,116,0,235,235,235,43,0,43,43
	.byte 0,31,31,31,240,0,240,240,0,206,206,206,132,0,132,132
	.byte 0,62,62,62,223,0,223,223,0,48,48,48,203,0,203,203
	.byte 0,220,220,220,52,0,52,52,0,95,95,95,118,0,118,118
	.byte 0,94,94,94,109,0,109,109,0,197,197,197,169,0,169,169
	.byte 0,11,11,11,209,0,209,209,0,26,26,26,4,0,4,4
	.byte 0,166,166,166,20,0,20,20,0,225,225,225,58,0,58,58
	.byte 0,57,57,57,222,0,222,222,0,202,202,202,17,0,17,17
	.byte 0,213,213,213,50,0,50,50,0,71,71,71,156,0,156,156
	.byte 0,93,93,93,83,0,83,83,0,61,61,61,242,0,242,242
	.byte 0,217,217,217,254,0,254,254,0,1,1,1,207,0,207,207
	.byte 0,90,90,90,195,0,195,195,0,214,214,214,122,0,122,122
	.byte 0,81,81,81,36,0,36,36,0,86,86,86,232,0,232,232
	.byte 0,108,108,108,96,0,96,96,0,77,77,77,105,0,105,105
	.byte 0,139,139,139,170,0,170,170,0,13,13,13,160,0,160,160
	.byte 0,154,154,154,161,0,161,161,0,102,102,102,98,0,98,98
	.byte 0,251,251,251,84,0,84,84,0,204,204,204,30,0,30,30
	.byte 0,176,176,176,224,0,224,224,0,45,45,45,100,0,100,100
	.byte 0,116,116,116,16,0,16,16,0,18,18,18,0,0,0,0
	.byte 0,43,43,43,163,0,163,163,0,32,32,32,117,0,117,117
	.byte 0,240,240,240,138,0,138,138,0,177,177,177,230,0,230,230
	.byte 0,132,132,132,9,0,9,9,0,153,153,153,221,0,221,221
	.byte 0,223,223,223,135,0,135,135,0,76,76,76,131,0,131,131
	.byte 0,203,203,203,205,0,205,205,0,194,194,194,144,0,144,144
	.byte 0,52,52,52,115,0,115,115,0,126,126,126,246,0,246,246
	.byte 0,118,118,118,157,0,157,157,0,5,5,5,191,0,191,191
	.byte 0,109,109,109,82,0,82,82,0,183,183,183,216,0,216,216
	.byte 0,169,169,169,200,0,200,200,0,49,49,49,198,0,198,198
	.byte 0,209,209,209,129,0,129,129,0,23,23,23,111,0,111,111
	.byte 0,4,4,4,19,0,19,19,0,215,215,215,99,0,99,99
	.byte 0,20,20,20,233,0,233,233,0,88,88,88,167,0,167,167
	.byte 0,58,58,58,159,0,159,159,0,97,97,97,188,0,188,188
	.byte 0,222,222,222,41,0,41,41,0,27,27,27,249,0,249,249
	.byte 0,17,17,17,47,0,47,47,0,28,28,28,180,0,180,180
	.byte 0,50,50,50,120,0,120,120,0,15,15,15,6,0,6,6
	.byte 0,156,156,156,231,0,231,231,0,22,22,22,113,0,113,113
	.byte 0,83,83,83,212,0,212,212,0,24,24,24,171,0,171,171
	.byte 0,242,242,242,136,0,136,136,0,34,34,34,141,0,141,141
	.byte 0,254,254,254,114,0,114,114,0,68,68,68,185,0,185,185
	.byte 0,207,207,207,248,0,248,248,0,178,178,178,172,0,172,172
	.byte 0,195,195,195,54,0,54,54,0,181,181,181,42,0,42,42
	.byte 0,122,122,122,60,0,60,60,0,145,145,145,241,0,241,241
	.byte 0,36,36,36,64,0,64,64,0,8,8,8,211,0,211,211
	.byte 0,232,232,232,187,0,187,187,0,168,168,168,67,0,67,67
	.byte 0,96,96,96,21,0,21,21,0,252,252,252,173,0,173,173
	.byte 0,105,105,105,119,0,119,119,0,80,80,80,128,0,128,128
	.byte 0,170,170,170,130,0,130,130,0,208,208,208,236,0,236,236
	.byte 0,160,160,160,39,0,39,39,0,125,125,125,229,0,229,229
	.byte 0,161,161,161,133,0,133,133,0,137,137,137,53,0,53,53
	.byte 0,98,98,98,12,0,12,12,0,151,151,151,65,0,65,65
	.byte 0,84,84,84,239,0,239,239,0,91,91,91,147,0,147,147
	.byte 0,30,30,30,25,0,25,25,0,149,149,149,33,0,33,33
	.byte 0,224,224,224,14,0,14,14,0,255,255,255,78,0,78,78
	.byte 0,100,100,100,101,0,101,101,0,210,210,210,189,0,189,189
	.byte 0,16,16,16,184,0,184,184,0,196,196,196,143,0,143,143
	.byte 0,0,0,0,235,0,235,235,0,72,72,72,206,0,206,206
	.byte 0,163,163,163,48,0,48,48,0,247,247,247,95,0,95,95
	.byte 0,117,117,117,197,0,197,197,0,219,219,219,26,0,26,26
	.byte 0,138,138,138,225,0,225,225,0,3,3,3,202,0,202,202
	.byte 0,230,230,230,71,0,71,71,0,218,218,218,61,0,61,61
	.byte 0,9,9,9,1,0,1,1,0,63,63,63,214,0,214,214
	.byte 0,221,221,221,86,0,86,86,0,148,148,148,77,0,77,77
	.byte 0,135,135,135,13,0,13,13,0,92,92,92,102,0,102,102
	.byte 0,131,131,131,204,0,204,204,0,2,2,2,45,0,45,45
	.byte 0,205,205,205,18,0,18,18,0,74,74,74,32,0,32,32
	.byte 0,144,144,144,177,0,177,177,0,51,51,51,153,0,153,153
	.byte 0,115,115,115,76,0,76,76,0,103,103,103,194,0,194,194
	.byte 0,246,246,246,126,0,126,126,0,243,243,243,5,0,5,5
	.byte 0,157,157,157,183,0,183,183,0,127,127,127,49,0,49,49
	.byte 0,191,191,191,23,0,23,23,0,226,226,226,215,0,215,215
	.byte 0,82,82,82,88,0,88,88,0,155,155,155,97,0,97,97
	.byte 0,216,216,216,27,0,27,27,0,38,38,38,28,0,28,28
	.byte 0,200,200,200,15,0,15,15,0,55,55,55,22,0,22,22
	.byte 0,198,198,198,24,0,24,24,0,59,59,59,34,0,34,34
	.byte 0,129,129,129,68,0,68,68,0,150,150,150,178,0,178,178
	.byte 0,111,111,111,181,0,181,181,0,75,75,75,145,0,145,145
	.byte 0,19,19,19,8,0,8,8,0,190,190,190,168,0,168,168
	.byte 0,99,99,99,252,0,252,252,0,46,46,46,80,0,80,80
	.byte 0,233,233,233,208,0,208,208,0,121,121,121,125,0,125,125
	.byte 0,167,167,167,137,0,137,137,0,140,140,140,151,0,151,151
	.byte 0,159,159,159,91,0,91,91,0,110,110,110,149,0,149,149
	.byte 0,188,188,188,255,0,255,255,0,142,142,142,210,0,210,210
	.byte 0,41,41,41,196,0,196,196,0,245,245,245,72,0,72,72
	.byte 0,249,249,249,247,0,247,247,0,182,182,182,219,0,219,219
	.byte 0,47,47,47,3,0,3,3,0,253,253,253,218,0,218,218
	.byte 0,180,180,180,63,0,63,63,0,89,89,89,148,0,148,148
	.byte 0,120,120,120,92,0,92,92,0,152,152,152,2,0,2,2
	.byte 0,6,6,6,74,0,74,74,0,106,106,106,51,0,51,51
	.byte 0,231,231,231,103,0,103,103,0,70,70,70,243,0,243,243
	.byte 0,113,113,113,127,0,127,127,0,186,186,186,226,0,226,226
	.byte 0,212,212,212,155,0,155,155,0,37,37,37,38,0,38,38
	.byte 0,171,171,171,55,0,55,55,0,66,66,66,59,0,59,59
	.byte 0,136,136,136,150,0,150,150,0,162,162,162,75,0,75,75
	.byte 0,141,141,141,190,0,190,190,0,250,250,250,46,0,46,46
	.byte 0,114,114,114,121,0,121,121,0,7,7,7,140,0,140,140
	.byte 0,185,185,185,110,0,110,110,0,85,85,85,142,0,142,142
	.byte 0,248,248,248,245,0,245,245,0,238,238,238,182,0,182,182
	.byte 0,172,172,172,253,0,253,253,0,10,10,10,89,0,89,89
	.byte 0,54,54,54,152,0,152,152,0,73,73,73,106,0,106,106
	.byte 0,42,42,42,70,0,70,70,0,104,104,104,186,0,186,186
	.byte 0,60,60,60,37,0,37,37,0,56,56,56,66,0,66,66
	.byte 0,241,241,241,162,0,162,162,0,164,164,164,250,0,250,250
	.byte 0,64,64,64,7,0,7,7,0,40,40,40,85,0,85,85
	.byte 0,211,211,211,238,0,238,238,0,123,123,123,10,0,10,10
	.byte 0,187,187,187,73,0,73,73,0,201,201,201,104,0,104,104
	.byte 0,67,67,67,56,0,56,56,0,193,193,193,164,0,164,164
	.byte 0,21,21,21,40,0,40,40,0,227,227,227,123,0,123,123
	.byte 0,173,173,173,201,0,201,201,0,244,244,244,193,0,193,193
	.byte 0,119,119,119,227,0,227,227,0,199,199,199,244,0,244,244
	.byte 0,128,128,128,199,0,199,199,0,158,158,158,158,0,158,158
	.byte 224,224,224,0,56,56,0,56,5,5,5,0,65,65,0,65
	.byte 88,88,88,0,22,22,0,22,217,217,217,0,118,118,0,118
	.byte 103,103,103,0,217,217,0,217,78,78,78,0,147,147,0,147
	.byte 129,129,129,0,96,96,0,96,203,203,203,0,242,242,0,242
	.byte 201,201,201,0,114,114,0,114,11,11,11,0,194,194,0,194
	.byte 174,174,174,0,171,171,0,171,106,106,106,0,154,154,0,154
	.byte 213,213,213,0,117,117,0,117,24,24,24,0,6,6,0,6
	.byte 93,93,93,0,87,87,0,87,130,130,130,0,160,160,0,160
	.byte 70,70,70,0,145,145,0,145,223,223,223,0,247,247,0,247
	.byte 214,214,214,0,181,181,0,181,39,39,39,0,201,201,0,201
	.byte 138,138,138,0,162,162,0,162,50,50,50,0,140,140,0,140
	.byte 75,75,75,0,210,210,0,210,66,66,66,0,144,144,0,144
	.byte 219,219,219,0,246,246,0,246,28,28,28,0,7,7,0,7
	.byte 158,158,158,0,167,167,0,167,156,156,156,0,39,39,0,39
	.byte 58,58,58,0,142,142,0,142,202,202,202,0,178,178,0,178
	.byte 37,37,37,0,73,73,0,73,123,123,123,0,222,222,0,222
	.byte 13,13,13,0,67,67,0,67,113,113,113,0,92,92,0,92
	.byte 95,95,95,0,215,215,0,215,31,31,31,0,199,199,0,199
	.byte 248,248,248,0,62,62,0,62,215,215,215,0,245,245,0,245
	.byte 62,62,62,0,143,143,0,143,157,157,157,0,103,103,0,103
	.byte 124,124,124,0,31,31,0,31,96,96,96,0,24,24,0,24
	.byte 185,185,185,0,110,110,0,110,190,190,190,0,175,175,0,175
	.byte 188,188,188,0,47,47,0,47,139,139,139,0,226,226,0,226
	.byte 22,22,22,0,133,133,0,133,52,52,52,0,13,13,0,13
	.byte 77,77,77,0,83,83,0,83,195,195,195,0,240,240,0,240
	.byte 114,114,114,0,156,156,0,156,149,149,149,0,101,101,0,101
	.byte 171,171,171,0,234,234,0,234,142,142,142,0,163,163,0,163
	.byte 186,186,186,0,174,174,0,174,122,122,122,0,158,158,0,158
	.byte 179,179,179,0,236,236,0,236,2,2,2,0,128,128,0,128
	.byte 180,180,180,0,45,45,0,45,173,173,173,0,107,107,0,107
	.byte 162,162,162,0,168,168,0,168,172,172,172,0,43,43,0,43
	.byte 216,216,216,0,54,54,0,54,154,154,154,0,166,166,0,166
	.byte 23,23,23,0,197,197,0,197,26,26,26,0,134,134,0,134
	.byte 53,53,53,0,77,77,0,77,204,204,204,0,51,51,0,51
	.byte 247,247,247,0,253,253,0,253,153,153,153,0,102,102,0,102
	.byte 97,97,97,0,88,88,0,88,90,90,90,0,150,150,0,150
	.byte 232,232,232,0,58,58,0,58,36,36,36,0,9,9,0,9
	.byte 86,86,86,0,149,149,0,149,64,64,64,0,16,16,0,16
	.byte 225,225,225,0,120,120,0,120,99,99,99,0,216,216,0,216
	.byte 9,9,9,0,66,66,0,66,51,51,51,0,204,204,0,204
	.byte 191,191,191,0,239,239,0,239,152,152,152,0,38,38,0,38
	.byte 151,151,151,0,229,229,0,229,133,133,133,0,97,97,0,97
	.byte 104,104,104,0,26,26,0,26,252,252,252,0,63,63,0,63
	.byte 236,236,236,0,59,59,0,59,10,10,10,0,130,130,0,130
	.byte 218,218,218,0,182,182,0,182,111,111,111,0,219,219,0,219
	.byte 83,83,83,0,212,212,0,212,98,98,98,0,152,152,0,152
	.byte 163,163,163,0,232,232,0,232,46,46,46,0,139,139,0,139
	.byte 8,8,8,0,2,2,0,2,175,175,175,0,235,235,0,235
	.byte 40,40,40,0,10,10,0,10,176,176,176,0,44,44,0,44
	.byte 116,116,116,0,29,29,0,29,194,194,194,0,176,176,0,176
	.byte 189,189,189,0,111,111,0,111,54,54,54,0,141,141,0,141
	.byte 34,34,34,0,136,136,0,136,56,56,56,0,14,14,0,14
	.byte 100,100,100,0,25,25,0,25,30,30,30,0,135,135,0,135
	.byte 57,57,57,0,78,78,0,78,44,44,44,0,11,11,0,11
	.byte 166,166,166,0,169,169,0,169,48,48,48,0,12,12,0,12
	.byte 229,229,229,0,121,121,0,121,68,68,68,0,17,17,0,17
	.byte 253,253,253,0,127,127,0,127,136,136,136,0,34,34,0,34
	.byte 159,159,159,0,231,231,0,231,101,101,101,0,89,89,0,89
	.byte 135,135,135,0,225,225,0,225,107,107,107,0,218,218,0,218
	.byte 244,244,244,0,61,61,0,61,35,35,35,0,200,200,0,200
	.byte 72,72,72,0,18,18,0,18,16,16,16,0,4,4,0,4
	.byte 209,209,209,0,116,116,0,116,81,81,81,0,84,84,0,84
	.byte 192,192,192,0,48,48,0,48,249,249,249,0,126,126,0,126
	.byte 210,210,210,0,180,180,0,180,160,160,160,0,40,40,0,40
	.byte 85,85,85,0,85,85,0,85,161,161,161,0,104,104,0,104
	.byte 65,65,65,0,80,80,0,80,250,250,250,0,190,190,0,190
	.byte 67,67,67,0,208,208,0,208,19,19,19,0,196,196,0,196
	.byte 196,196,196,0,49,49,0,49,47,47,47,0,203,203,0,203
	.byte 168,168,168,0,42,42,0,42,182,182,182,0,173,173,0,173
	.byte 60,60,60,0,15,15,0,15,43,43,43,0,202,202,0,202
	.byte 193,193,193,0,112,112,0,112,255,255,255,0,255,255,0,255
	.byte 200,200,200,0,50,50,0,50,165,165,165,0,105,105,0,105
	.byte 32,32,32,0,8,8,0,8,137,137,137,0,98,98,0,98
	.byte 0,0,0,0,0,0,0,0,144,144,144,0,36,36,0,36
	.byte 71,71,71,0,209,209,0,209,239,239,239,0,251,251,0,251
	.byte 234,234,234,0,186,186,0,186,183,183,183,0,237,237,0,237
	.byte 21,21,21,0,69,69,0,69,6,6,6,0,129,129,0,129
	.byte 205,205,205,0,115,115,0,115,181,181,181,0,109,109,0,109
	.byte 18,18,18,0,132,132,0,132,126,126,126,0,159,159,0,159
	.byte 187,187,187,0,238,238,0,238,41,41,41,0,74,74,0,74
	.byte 15,15,15,0,195,195,0,195,184,184,184,0,46,46,0,46
	.byte 7,7,7,0,193,193,0,193,4,4,4,0,1,1,0,1
	.byte 155,155,155,0,230,230,0,230,148,148,148,0,37,37,0,37
	.byte 33,33,33,0,72,72,0,72,102,102,102,0,153,153,0,153
	.byte 230,230,230,0,185,185,0,185,206,206,206,0,179,179,0,179
	.byte 237,237,237,0,123,123,0,123,231,231,231,0,249,249,0,249
	.byte 59,59,59,0,206,206,0,206,254,254,254,0,191,191,0,191
	.byte 127,127,127,0,223,223,0,223,197,197,197,0,113,113,0,113
	.byte 164,164,164,0,41,41,0,41,55,55,55,0,205,205,0,205
	.byte 177,177,177,0,108,108,0,108,76,76,76,0,19,19,0,19
	.byte 145,145,145,0,100,100,0,100,110,110,110,0,155,155,0,155
	.byte 141,141,141,0,99,99,0,99,118,118,118,0,157,157,0,157
	.byte 3,3,3,0,192,192,0,192,45,45,45,0,75,75,0,75
	.byte 222,222,222,0,183,183,0,183,150,150,150,0,165,165,0,165
	.byte 38,38,38,0,137,137,0,137,125,125,125,0,95,95,0,95
	.byte 198,198,198,0,177,177,0,177,92,92,92,0,23,23,0,23
	.byte 211,211,211,0,244,244,0,244,242,242,242,0,188,188,0,188
	.byte 79,79,79,0,211,211,0,211,25,25,25,0,70,70,0,70
	.byte 63,63,63,0,207,207,0,207,220,220,220,0,55,55,0,55
	.byte 121,121,121,0,94,94,0,94,29,29,29,0,71,71,0,71
	.byte 82,82,82,0,148,148,0,148,235,235,235,0,250,250,0,250
	.byte 243,243,243,0,252,252,0,252,109,109,109,0,91,91,0,91
	.byte 94,94,94,0,151,151,0,151,251,251,251,0,254,254,0,254
	.byte 105,105,105,0,90,90,0,90,178,178,178,0,172,172,0,172
	.byte 240,240,240,0,60,60,0,60,49,49,49,0,76,76,0,76
	.byte 12,12,12,0,3,3,0,3,212,212,212,0,53,53,0,53
	.byte 207,207,207,0,243,243,0,243,140,140,140,0,35,35,0,35
	.byte 226,226,226,0,184,184,0,184,117,117,117,0,93,93,0,93
	.byte 169,169,169,0,106,106,0,106,74,74,74,0,146,146,0,146
	.byte 87,87,87,0,213,213,0,213,132,132,132,0,33,33,0,33
	.byte 17,17,17,0,68,68,0,68,69,69,69,0,81,81,0,81
	.byte 27,27,27,0,198,198,0,198,245,245,245,0,125,125,0,125
	.byte 228,228,228,0,57,57,0,57,14,14,14,0,131,131,0,131
	.byte 115,115,115,0,220,220,0,220,170,170,170,0,170,170,0,170
	.byte 241,241,241,0,124,124,0,124,221,221,221,0,119,119,0,119
	.byte 89,89,89,0,86,86,0,86,20,20,20,0,5,5,0,5
	.byte 108,108,108,0,27,27,0,27,146,146,146,0,164,164,0,164
	.byte 84,84,84,0,21,21,0,21,208,208,208,0,52,52,0,52
	.byte 120,120,120,0,30,30,0,30,112,112,112,0,28,28,0,28
	.byte 227,227,227,0,248,248,0,248,73,73,73,0,82,82,0,82
	.byte 128,128,128,0,32,32,0,32,80,80,80,0,20,20,0,20
	.byte 167,167,167,0,233,233,0,233,246,246,246,0,189,189,0,189
	.byte 119,119,119,0,221,221,0,221,147,147,147,0,228,228,0,228
	.byte 134,134,134,0,161,161,0,161,131,131,131,0,224,224,0,224
	.byte 42,42,42,0,138,138,0,138,199,199,199,0,241,241,0,241
	.byte 91,91,91,0,214,214,0,214,233,233,233,0,122,122,0,122
	.byte 238,238,238,0,187,187,0,187,143,143,143,0,227,227,0,227
	.byte 1,1,1,0,64,64,0,64,61,61,61,0,79,79,0,79
	.byte 67,97,109,101,108,108,105,97,32,102,111,114,32,120,56,54
	.byte 95,54,52,32,98,121,32,60,104,116,116,112,115,58,47,47
	.byte 103,105,116,104,117,98,46,99,111,109,47,100,111,116,45,97
	.byte 115,109,62,0

	.text
gcm_gmult_4bit:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x118, %rsp
movzbq	0xf(%rdi), %r8
leaq	bums_rodata+64(%rip), %r11
xorq	%rax, %rax
xorq	%rbx, %rbx
movb	%r8b, %al
movb	%r8b, %bl
shlb	$0x4, %al
movq	$0xe, %rcx
movq	0x8(%rsi,%rax), %r8
movq	(%rsi,%rax), %r9
andb	$-0x10, %bl
movq	%r8, %rdx
jmp	L_50
nopl	(%rax,%rax)
L_50:
shrq	$0x4, %r8
andq	$0xf, %rdx
movq	%r9, %r10
movb	(%rdi,%rcx), %al
shrq	$0x4, %r9
xorq	0x8(%rsi,%rbx), %r8
shlq	$0x3c, %r10
xorq	(%rsi,%rbx), %r9
movb	%al, %bl
xorq	(%r11,%rdx,8), %r9
movq	%r8, %rdx
shlb	$0x4, %al
xorq	%r10, %r8
decq	%rcx
js	L_b0
shrq	$0x4, %r8
andq	$0xf, %rdx
movq	%r9, %r10
shrq	$0x4, %r9
xorq	0x8(%rsi,%rax), %r8
shlq	$0x3c, %r10
xorq	(%rsi,%rax), %r9
andb	$-0x10, %bl
xorq	(%r11,%rdx,8), %r9
movq	%r8, %rdx
xorq	%r10, %r8
jmp	L_50
nop
L_b0:
shrq	$0x4, %r8
andq	$0xf, %rdx
movq	%r9, %r10
shrq	$0x4, %r9
xorq	0x8(%rsi,%rax), %r8
shlq	$0x3c, %r10
xorq	(%rsi,%rax), %r9
andb	$-0x10, %bl
xorq	(%r11,%rdx,8), %r9
movq	%r8, %rdx
xorq	%r10, %r8
shrq	$0x4, %r8
andq	$0xf, %rdx
movq	%r9, %r10
shrq	$0x4, %r9
xorq	0x8(%rsi,%rbx), %r8
shlq	$0x3c, %r10
xorq	(%rsi,%rbx), %r9
xorq	%r10, %r8
xorq	(%r11,%rdx,8), %r9
bswapq	%r8
bswapq	%r9
movq	%r8, 0x8(%rdi)
movq	%r9, (%rdi)
leaq	0x148(%rsp), %rsi
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
nopw	(%rax,%rax)
gcm_ghash_4bit:
endbr64
pushq	%rbx
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x118, %rsp
movq	%rdx, %r14
movq	%rcx, %r15
subq	$-0x80, %rsi
leaq	0x90(%rsp), %rbp
xorl	%edx, %edx
movq	-0x80(%rsi), %r8
movq	-0x78(%rsi), %rax
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	-0x70(%rsi), %r9
shlb	$0x4, %dl
movq	-0x68(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, (%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, (%rbp)
movq	-0x60(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x80(%rbp)
movq	-0x58(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0x1(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x8(%rbp)
movq	-0x50(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x78(%rbp)
movq	-0x48(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0x2(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x10(%rbp)
movq	-0x40(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x70(%rbp)
movq	-0x38(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0x3(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x18(%rbp)
movq	-0x30(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x68(%rbp)
movq	-0x28(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0x4(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x20(%rbp)
movq	-0x20(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x60(%rbp)
movq	-0x18(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0x5(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x28(%rbp)
movq	-0x10(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x58(%rbp)
movq	-0x8(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0x6(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x30(%rbp)
movq	(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x50(%rbp)
movq	0x8(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0x7(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x38(%rbp)
movq	0x10(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x48(%rbp)
movq	0x18(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0x8(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x40(%rbp)
movq	0x20(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x40(%rbp)
movq	0x28(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0x9(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x48(%rbp)
movq	0x30(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x38(%rbp)
movq	0x38(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0xa(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x50(%rbp)
movq	0x40(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x30(%rbp)
movq	0x48(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0xb(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x58(%rbp)
movq	0x50(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x28(%rbp)
movq	0x58(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0xc(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x60(%rbp)
movq	0x60(%rsi), %r8
shlb	$0x4, %dl
movq	%rax, -0x20(%rbp)
movq	0x68(%rsi), %rax
shlq	$0x3c, %r10
movb	%dl, 0xd(%rsp)
orq	%r10, %rbx
movb	%al, %dl
shrq	$0x4, %rax
movq	%r8, %r10
shrq	$0x4, %r8
movq	%r9, 0x68(%rbp)
movq	0x70(%rsi), %r9
shlb	$0x4, %dl
movq	%rbx, -0x18(%rbp)
movq	0x78(%rsi), %rbx
shlq	$0x3c, %r10
movb	%dl, 0xe(%rsp)
orq	%r10, %rax
movb	%bl, %dl
shrq	$0x4, %rbx
movq	%r9, %r10
shrq	$0x4, %r9
movq	%r8, 0x70(%rbp)
shlb	$0x4, %dl
movq	%rax, -0x10(%rbp)
shlq	$0x3c, %r10
movb	%dl, 0xf(%rsp)
orq	%r10, %rbx
movq	%r9, 0x78(%rbp)
movq	%rbx, -0x8(%rbp)
addq	$-0x80, %rsi
movq	0x8(%rdi), %r8
movq	(%rdi), %r9
addq	%r14, %r15
leaq	bums_rodata+192(%rip), %r11
jmp	L_410
nop
L_410:
xorq	(%r14), %r9
movq	0x8(%r14), %rdx
leaq	0x10(%r14), %r14
xorq	%r8, %rdx
movq	%r9, (%rdi)
movq	%rdx, 0x8(%rdi)
shrq	$0x20, %rdx
xorq	%rax, %rax
roll	$0x8, %edx
movb	%dl, %al
movzbl	%dl, %ebx
shlb	$0x4, %al
shrl	$0x4, %ebx
roll	$0x8, %edx
movq	0x8(%rsi,%rax), %r8
movq	(%rsi,%rax), %r9
movb	%dl, %al
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
xorq	%r8, %r12
movq	%r9, %r10
shrq	$0x8, %r8
movzbq	%r12b, %r12
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
movl	0x8(%rdi), %edx
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
movl	0x4(%rdi), %edx
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
movl	(%rdi), %edx
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
shrl	$0x4, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r12,2), %r12
movzbl	%dl, %ebx
shlb	$0x4, %al
movzbq	(%rsp,%rcx), %r13
shrl	$0x4, %ebx
shlq	$0x30, %r12
xorq	%r8, %r13
movq	%r9, %r10
xorq	%r12, %r9
shrq	$0x8, %r8
movzbq	%r13b, %r13
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rcx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rcx,8), %r9
roll	$0x8, %edx
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
movb	%dl, %al
xorq	%r10, %r8
movzwq	(%r11,%r13,2), %r13
movzbl	%dl, %ecx
shlb	$0x4, %al
movzbq	(%rsp,%rbx), %r12
andl	$0xf0, %ecx
shlq	$0x30, %r13
xorq	%r8, %r12
movq	%r9, %r10
xorq	%r13, %r9
shrq	$0x8, %r8
movzbq	%r12b, %r12
movl	-0x4(%rdi), %edx
shrq	$0x8, %r9
xorq	-0x80(%rbp,%rbx,8), %r8
shlq	$0x38, %r10
xorq	(%rbp,%rbx,8), %r9
movzwq	(%r11,%r12,2), %r12
xorq	0x8(%rsi,%rax), %r8
xorq	(%rsi,%rax), %r9
shlq	$0x30, %r12
xorq	%r10, %r8
xorq	%r12, %r9
movzbq	%r8b, %r13
shrq	$0x4, %r8
movq	%r9, %r10
shlb	$0x4, %r13b
shrq	$0x4, %r9
xorq	0x8(%rsi,%rcx), %r8
movzwq	(%r11,%r13,2), %r13
shlq	$0x3c, %r10
xorq	(%rsi,%rcx), %r9
xorq	%r10, %r8
shlq	$0x30, %r13
bswapq	%r8
xorq	%r13, %r9
bswapq	%r9
cmpq	%r15, %r14
jb	L_410
movq	%r8, 0x8(%rdi)
movq	%r9, (%rdi)
leaq	0x148(%rsp), %rsi
movq	-0x30(%rsi), %r15
movq	-0x28(%rsi), %r14
movq	-0x20(%rsi), %r13
movq	-0x18(%rsi), %r12
movq	-0x10(%rsi), %rbp
movq	-0x8(%rsi), %rbx
leaq	(%rsi), %rsp
rep	retq
gcm_init_clmul:
endbr64
movdqu	(%rsi), %xmm2
pshufd	$0x4e, %xmm2, %xmm2
pshufd	$0xff, %xmm2, %xmm4
movdqa	%xmm2, %xmm3
psllq	$0x1, %xmm2
pxor	%xmm5, %xmm5
psrlq	$0x3f, %xmm3
pcmpgtd	%xmm4, %xmm5
pslldq	$0x8, %xmm3
por	%xmm3, %xmm2
pand	bums_rodata+16(%rip), %xmm5
pxor	%xmm5, %xmm2
pshufd	$0x4e, %xmm2, %xmm6
movdqa	%xmm2, %xmm0
pxor	%xmm2, %xmm6
movdqa	%xmm0, %xmm1
pshufd	$0x4e, %xmm0, %xmm3
pxor	%xmm0, %xmm3
pclmulqdq	$0x0, %xmm2, %xmm0
pclmulqdq	$0x11, %xmm2, %xmm1
pclmulqdq	$0x0, %xmm6, %xmm3
pxor	%xmm0, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm3, %xmm4
psrldq	$0x8, %xmm3
pslldq	$0x8, %xmm4
pxor	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
pshufd	$0x4e, %xmm2, %xmm3
pshufd	$0x4e, %xmm0, %xmm4
pxor	%xmm2, %xmm3
movdqu	%xmm2, (%rdi)
pxor	%xmm0, %xmm4
movdqu	%xmm0, 0x10(%rdi)
palignr	$0x8, %xmm3, %xmm4
movdqu	%xmm4, 0x20(%rdi)
movdqa	%xmm0, %xmm1
pshufd	$0x4e, %xmm0, %xmm3
pxor	%xmm0, %xmm3
pclmulqdq	$0x0, %xmm2, %xmm0
pclmulqdq	$0x11, %xmm2, %xmm1
pclmulqdq	$0x0, %xmm6, %xmm3
pxor	%xmm0, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm3, %xmm4
psrldq	$0x8, %xmm3
pslldq	$0x8, %xmm4
pxor	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
movdqa	%xmm0, %xmm5
movdqa	%xmm0, %xmm1
pshufd	$0x4e, %xmm0, %xmm3
pxor	%xmm0, %xmm3
pclmulqdq	$0x0, %xmm2, %xmm0
pclmulqdq	$0x11, %xmm2, %xmm1
pclmulqdq	$0x0, %xmm6, %xmm3
pxor	%xmm0, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm3, %xmm4
psrldq	$0x8, %xmm3
pslldq	$0x8, %xmm4
pxor	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
pshufd	$0x4e, %xmm5, %xmm3
pshufd	$0x4e, %xmm0, %xmm4
pxor	%xmm5, %xmm3
movdqu	%xmm5, 0x30(%rdi)
pxor	%xmm0, %xmm4
movdqu	%xmm0, 0x40(%rdi)
palignr	$0x8, %xmm3, %xmm4
movdqu	%xmm4, 0x50(%rdi)
rep	retq
nopl	(%rax)
gcm_gmult_clmul:
endbr64
L_b84:
movdqu	(%rdi), %xmm0
movdqa	bums_rodata(%rip), %xmm5
movdqu	(%rsi), %xmm2
movdqu	0x20(%rsi), %xmm4
pshufb	%xmm5, %xmm0
movdqa	%xmm0, %xmm1
pshufd	$0x4e, %xmm0, %xmm3
pxor	%xmm0, %xmm3
pclmulqdq	$0x0, %xmm2, %xmm0
pclmulqdq	$0x11, %xmm2, %xmm1
pclmulqdq	$0x0, %xmm4, %xmm3
pxor	%xmm0, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm3, %xmm4
psrldq	$0x8, %xmm3
pslldq	$0x8, %xmm4
pxor	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
pshufb	%xmm5, %xmm0
movdqu	%xmm0, (%rdi)
rep	retq
nop
gcm_ghash_clmul:
endbr64
movdqa	bums_rodata(%rip), %xmm10
movdqu	(%rdi), %xmm0
movdqu	(%rsi), %xmm2
movdqu	0x20(%rsi), %xmm7
pshufb	%xmm10, %xmm0
subq	$0x10, %rcx
je	L_11d5
movdqu	0x10(%rsi), %xmm6
movl	OPENSSL_ia32cap_P+4(%rip), %eax
cmpq	$0x30, %rcx
jb	L_fc1
andl	$0x4400000, %eax
cmpl	$0x400000, %eax
je	L_fc1
subq	$0x30, %rcx
movabsq	$-0x5fbf9f7fdf3f2000, %rax
movdqu	0x30(%rsi), %xmm14
movdqu	0x40(%rsi), %xmm15
movdqu	0x30(%rdx), %xmm3
movdqu	0x20(%rdx), %xmm11
pshufb	%xmm10, %xmm3
pshufb	%xmm10, %xmm11
movdqa	%xmm3, %xmm5
pshufd	$0x4e, %xmm3, %xmm4
pxor	%xmm3, %xmm4
pclmulqdq	$0x0, %xmm2, %xmm3
pclmulqdq	$0x11, %xmm2, %xmm5
pclmulqdq	$0x0, %xmm7, %xmm4
movdqa	%xmm11, %xmm13
pshufd	$0x4e, %xmm11, %xmm12
pxor	%xmm11, %xmm12
pclmulqdq	$0x0, %xmm6, %xmm11
pclmulqdq	$0x11, %xmm6, %xmm13
pclmulqdq	$0x10, %xmm7, %xmm12
xorps	%xmm11, %xmm3
xorps	%xmm13, %xmm5
movups	0x50(%rsi), %xmm7
xorps	%xmm12, %xmm4
movdqu	0x10(%rdx), %xmm11
movdqu	(%rdx), %xmm8
pshufb	%xmm10, %xmm11
pshufb	%xmm10, %xmm8
movdqa	%xmm11, %xmm13
pshufd	$0x4e, %xmm11, %xmm12
pxor	%xmm8, %xmm0
pxor	%xmm11, %xmm12
pclmulqdq	$0x0, %xmm14, %xmm11
movdqa	%xmm0, %xmm1
pshufd	$0x4e, %xmm0, %xmm8
pxor	%xmm0, %xmm8
pclmulqdq	$0x11, %xmm14, %xmm13
pclmulqdq	$0x0, %xmm7, %xmm12
xorps	%xmm11, %xmm3
xorps	%xmm13, %xmm5
leaq	0x40(%rdx), %rdx
subq	$0x40, %rcx
jb	L_f04
jmp	L_d80
nopl	(%rax)
L_d80:
pclmulqdq	$0x0, %xmm15, %xmm0
xorps	%xmm12, %xmm4
movdqu	0x30(%rdx), %xmm11
pshufb	%xmm10, %xmm11
pclmulqdq	$0x11, %xmm15, %xmm1
xorps	%xmm3, %xmm0
movdqu	0x20(%rdx), %xmm3
movdqa	%xmm11, %xmm13
pclmulqdq	$0x10, %xmm7, %xmm8
pshufd	$0x4e, %xmm11, %xmm12
xorps	%xmm5, %xmm1
pxor	%xmm11, %xmm12
pshufb	%xmm10, %xmm3
movups	0x20(%rsi), %xmm7
xorps	%xmm4, %xmm8
pclmulqdq	$0x0, %xmm2, %xmm11
pshufd	$0x4e, %xmm3, %xmm4
pxor	%xmm0, %xmm8
movdqa	%xmm3, %xmm5
pxor	%xmm1, %xmm8
pxor	%xmm3, %xmm4
movdqa	%xmm8, %xmm9
pclmulqdq	$0x11, %xmm2, %xmm13
pslldq	$0x8, %xmm8
psrldq	$0x8, %xmm9
pxor	%xmm8, %xmm0
movdqa	bums_rodata+32(%rip), %xmm8
pxor	%xmm9, %xmm1
movq	%rax, %xmm9
pand	%xmm0, %xmm8
pshufb	%xmm8, %xmm9
pxor	%xmm0, %xmm9
pclmulqdq	$0x0, %xmm7, %xmm12
psllq	$0x39, %xmm9
movdqa	%xmm9, %xmm8
pslldq	$0x8, %xmm9
pclmulqdq	$0x0, %xmm6, %xmm3
psrldq	$0x8, %xmm8
pxor	%xmm9, %xmm0
pxor	%xmm8, %xmm1
movdqu	(%rdx), %xmm8
movdqa	%xmm0, %xmm9
psrlq	$0x1, %xmm0
pclmulqdq	$0x11, %xmm6, %xmm5
xorps	%xmm11, %xmm3
movdqu	0x10(%rdx), %xmm11
pshufb	%xmm10, %xmm11
pclmulqdq	$0x10, %xmm7, %xmm4
xorps	%xmm13, %xmm5
movups	0x50(%rsi), %xmm7
pshufb	%xmm10, %xmm8
pxor	%xmm9, %xmm1
pxor	%xmm0, %xmm9
psrlq	$0x5, %xmm0
movdqa	%xmm11, %xmm13
pxor	%xmm12, %xmm4
pshufd	$0x4e, %xmm11, %xmm12
pxor	%xmm9, %xmm0
pxor	%xmm8, %xmm1
pxor	%xmm11, %xmm12
pclmulqdq	$0x0, %xmm14, %xmm11
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
movdqa	%xmm0, %xmm1
pclmulqdq	$0x11, %xmm14, %xmm13
xorps	%xmm11, %xmm3
pshufd	$0x4e, %xmm0, %xmm8
pxor	%xmm0, %xmm8
pclmulqdq	$0x0, %xmm7, %xmm12
xorps	%xmm13, %xmm5
leaq	0x40(%rdx), %rdx
subq	$0x40, %rcx
jae	L_d80
L_f04:
pclmulqdq	$0x0, %xmm15, %xmm0
pclmulqdq	$0x11, %xmm15, %xmm1
pclmulqdq	$0x10, %xmm7, %xmm8
xorps	%xmm12, %xmm4
xorps	%xmm3, %xmm0
xorps	%xmm5, %xmm1
pxor	%xmm0, %xmm1
pxor	%xmm4, %xmm8
pxor	%xmm1, %xmm8
pxor	%xmm0, %xmm1
movdqa	%xmm8, %xmm9
psrldq	$0x8, %xmm8
pslldq	$0x8, %xmm9
pxor	%xmm8, %xmm1
pxor	%xmm9, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
addq	$0x40, %rcx
je	L_127a
movdqu	0x20(%rsi), %xmm7
subq	$0x10, %rcx
je	L_11d5
L_fc1:
movdqu	(%rdx), %xmm8
movdqu	0x10(%rdx), %xmm3
pshufb	%xmm10, %xmm8
pshufb	%xmm10, %xmm3
pxor	%xmm8, %xmm0
movdqa	%xmm3, %xmm5
pshufd	$0x4e, %xmm3, %xmm4
pxor	%xmm3, %xmm4
pclmulqdq	$0x0, %xmm2, %xmm3
pclmulqdq	$0x11, %xmm2, %xmm5
pclmulqdq	$0x0, %xmm7, %xmm4
leaq	0x20(%rdx), %rdx
nop
subq	$0x20, %rcx
jbe	L_1120
nop
jmp	L_1020
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_1020:
movdqa	%xmm0, %xmm1
movdqa	%xmm4, %xmm8
pshufd	$0x4e, %xmm0, %xmm4
pxor	%xmm0, %xmm4
pclmulqdq	$0x0, %xmm6, %xmm0
pclmulqdq	$0x11, %xmm6, %xmm1
pclmulqdq	$0x10, %xmm7, %xmm4
pxor	%xmm3, %xmm0
pxor	%xmm5, %xmm1
movdqu	(%rdx), %xmm9
pxor	%xmm0, %xmm8
pshufb	%xmm10, %xmm9
movdqu	0x10(%rdx), %xmm3
pxor	%xmm1, %xmm8
pxor	%xmm9, %xmm1
pxor	%xmm8, %xmm4
pshufb	%xmm10, %xmm3
movdqa	%xmm4, %xmm8
psrldq	$0x8, %xmm8
pslldq	$0x8, %xmm4
pxor	%xmm8, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm3, %xmm5
movdqa	%xmm0, %xmm9
movdqa	%xmm0, %xmm8
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm8
pclmulqdq	$0x0, %xmm2, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm8, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm8
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm8
pxor	%xmm9, %xmm0
pshufd	$0x4e, %xmm5, %xmm4
pxor	%xmm8, %xmm1
pxor	%xmm5, %xmm4
movdqa	%xmm0, %xmm9
psrlq	$0x1, %xmm0
pclmulqdq	$0x11, %xmm2, %xmm5
pxor	%xmm9, %xmm1
pxor	%xmm0, %xmm9
psrlq	$0x5, %xmm0
pxor	%xmm9, %xmm0
leaq	0x20(%rdx), %rdx
psrlq	$0x1, %xmm0
pclmulqdq	$0x0, %xmm7, %xmm4
pxor	%xmm1, %xmm0
subq	$0x20, %rcx
ja	L_1020
L_1120:
movdqa	%xmm0, %xmm1
movdqa	%xmm4, %xmm8
pshufd	$0x4e, %xmm0, %xmm4
pxor	%xmm0, %xmm4
pclmulqdq	$0x0, %xmm6, %xmm0
pclmulqdq	$0x11, %xmm6, %xmm1
pclmulqdq	$0x10, %xmm7, %xmm4
pxor	%xmm3, %xmm0
pxor	%xmm5, %xmm1
pxor	%xmm0, %xmm8
pxor	%xmm1, %xmm8
pxor	%xmm8, %xmm4
movdqa	%xmm4, %xmm8
psrldq	$0x8, %xmm8
pslldq	$0x8, %xmm4
pxor	%xmm8, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
testq	%rcx, %rcx
jne	L_127a
L_11d5:
movdqu	(%rdx), %xmm8
pshufb	%xmm10, %xmm8
pxor	%xmm8, %xmm0
movdqa	%xmm0, %xmm1
pshufd	$0x4e, %xmm0, %xmm3
pxor	%xmm0, %xmm3
pclmulqdq	$0x0, %xmm2, %xmm0
pclmulqdq	$0x11, %xmm2, %xmm1
pclmulqdq	$0x0, %xmm7, %xmm3
pxor	%xmm0, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm3, %xmm4
psrldq	$0x8, %xmm3
pslldq	$0x8, %xmm4
pxor	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	%xmm0, %xmm4
movdqa	%xmm0, %xmm3
psllq	$0x5, %xmm0
pxor	%xmm0, %xmm3
psllq	$0x1, %xmm0
pxor	%xmm3, %xmm0
psllq	$0x39, %xmm0
movdqa	%xmm0, %xmm3
pslldq	$0x8, %xmm0
psrldq	$0x8, %xmm3
pxor	%xmm4, %xmm0
pxor	%xmm3, %xmm1
movdqa	%xmm0, %xmm4
psrlq	$0x1, %xmm0
pxor	%xmm4, %xmm1
pxor	%xmm0, %xmm4
psrlq	$0x5, %xmm0
pxor	%xmm4, %xmm0
psrlq	$0x1, %xmm0
pxor	%xmm1, %xmm0
L_127a:
pshufb	%xmm10, %xmm0
movdqu	%xmm0, (%rdi)
rep	retq
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
gcm_init_avx:
endbr64
vzeroupper
vmovdqu	(%rsi), %xmm2
vpshufd	$0x4e, %xmm2, %xmm2
vpshufd	$0xff, %xmm2, %xmm4
vpsrlq	$0x3f, %xmm2, %xmm3
vpsllq	$0x1, %xmm2, %xmm2
vpxor	%xmm5, %xmm5, %xmm5
vpcmpgtd	%xmm4, %xmm5, %xmm5
vpslldq	$0x8, %xmm3, %xmm3
vpor	%xmm3, %xmm2, %xmm2
vpand	bums_rodata+16(%rip), %xmm5, %xmm5
vpxor	%xmm5, %xmm2, %xmm2
vpunpckhqdq	%xmm2, %xmm2, %xmm6
vmovdqa	%xmm2, %xmm0
vpxor	%xmm2, %xmm6, %xmm6
movq	$0x4, %r10
jmp	L_1387
nopw	%cs:(%rax,%rax)
nop
L_1300:
vpalignr	$0x8, %xmm3, %xmm4, %xmm5
vmovdqu	%xmm5, -0x10(%rdi)
vpunpckhqdq	%xmm0, %xmm0, %xmm3
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x11, %xmm2, %xmm0, %xmm1
vpclmulqdq	$0x0, %xmm2, %xmm0, %xmm0
vpclmulqdq	$0x0, %xmm6, %xmm3, %xmm3
vpxor	%xmm0, %xmm1, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
vpslldq	$0x8, %xmm3, %xmm4
vpsrldq	$0x8, %xmm3, %xmm3
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vpsllq	$0x39, %xmm0, %xmm3
vpsllq	$0x3e, %xmm0, %xmm4
vpxor	%xmm3, %xmm4, %xmm4
vpsllq	$0x3f, %xmm0, %xmm3
vpxor	%xmm3, %xmm4, %xmm4
vpslldq	$0x8, %xmm4, %xmm3
vpsrldq	$0x8, %xmm4, %xmm4
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm4, %xmm1, %xmm1
vpsrlq	$0x1, %xmm0, %xmm4
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpsrlq	$0x5, %xmm4, %xmm4
vpxor	%xmm4, %xmm0, %xmm0
vpsrlq	$0x1, %xmm0, %xmm0
vpxor	%xmm1, %xmm0, %xmm0
L_1387:
vmovdqa	%xmm0, %xmm5
vpunpckhqdq	%xmm0, %xmm0, %xmm3
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x11, %xmm2, %xmm0, %xmm1
vpclmulqdq	$0x0, %xmm2, %xmm0, %xmm0
vpclmulqdq	$0x0, %xmm6, %xmm3, %xmm3
vpxor	%xmm0, %xmm1, %xmm4
vpxor	%xmm4, %xmm3, %xmm3
vpslldq	$0x8, %xmm3, %xmm4
vpsrldq	$0x8, %xmm3, %xmm3
vpxor	%xmm4, %xmm0, %xmm0
vpxor	%xmm3, %xmm1, %xmm1
vpsllq	$0x39, %xmm0, %xmm3
vpsllq	$0x3e, %xmm0, %xmm4
vpxor	%xmm3, %xmm4, %xmm4
vpsllq	$0x3f, %xmm0, %xmm3
vpxor	%xmm3, %xmm4, %xmm4
vpslldq	$0x8, %xmm4, %xmm3
vpsrldq	$0x8, %xmm4, %xmm4
vpxor	%xmm3, %xmm0, %xmm0
vpxor	%xmm4, %xmm1, %xmm1
vpsrlq	$0x1, %xmm0, %xmm4
vpxor	%xmm0, %xmm1, %xmm1
vpxor	%xmm4, %xmm0, %xmm0
vpsrlq	$0x5, %xmm4, %xmm4
vpxor	%xmm4, %xmm0, %xmm0
vpsrlq	$0x1, %xmm0, %xmm0
vpxor	%xmm1, %xmm0, %xmm0
vpshufd	$0x4e, %xmm5, %xmm3
vpshufd	$0x4e, %xmm0, %xmm4
vpxor	%xmm5, %xmm3, %xmm3
vmovdqu	%xmm5, (%rdi)
vpxor	%xmm0, %xmm4, %xmm4
vmovdqu	%xmm0, 0x10(%rdi)
leaq	0x30(%rdi), %rdi
subq	$0x1, %r10
jne	L_1300
vpalignr	$0x8, %xmm4, %xmm3, %xmm5
vmovdqu	%xmm5, -0x10(%rdi)
vzeroupper
rep	retq
gcm_gmult_avx:
endbr64
jmp	L_b84
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax)
gcm_ghash_avx:
endbr64
vzeroupper
vmovdqu	(%rdi), %xmm10
leaq	bums_rodata+16(%rip), %r10
leaq	0x40(%rsi), %rsi
vmovdqu	bums_rodata(%rip), %xmm13
vpshufb	%xmm13, %xmm10, %xmm10
cmpq	$0x80, %rcx
jb	L_18a0
subq	$0x80, %rcx
vmovdqu	0x70(%rdx), %xmm14
vmovdqu	-0x40(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm14
vmovdqu	-0x20(%rsi), %xmm7
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vmovdqu	0x60(%rdx), %xmm15
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpxor	%xmm14, %xmm9, %xmm9
vpshufb	%xmm13, %xmm15, %xmm15
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	-0x30(%rsi), %xmm6
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vmovdqu	0x50(%rdx), %xmm14
vpclmulqdq	$0x0, %xmm7, %xmm9, %xmm2
vpxor	%xmm15, %xmm8, %xmm8
vpshufb	%xmm13, %xmm14, %xmm14
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm3
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm4
vmovdqu	-0x10(%rsi), %xmm6
vpxor	%xmm14, %xmm9, %xmm9
vmovdqu	0x40(%rdx), %xmm15
vpclmulqdq	$0x10, %xmm7, %xmm8, %xmm5
vmovdqu	0x10(%rsi), %xmm7
vpshufb	%xmm13, %xmm15, %xmm15
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpxor	%xmm1, %xmm4, %xmm4
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	(%rsi), %xmm6
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm9, %xmm2
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	0x30(%rdx), %xmm14
vpxor	%xmm3, %xmm0, %xmm0
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm3
vpxor	%xmm4, %xmm1, %xmm1
vpshufb	%xmm13, %xmm14, %xmm14
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm4
vmovdqu	0x20(%rsi), %xmm6
vpxor	%xmm5, %xmm2, %xmm2
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpclmulqdq	$0x10, %xmm7, %xmm8, %xmm5
vmovdqu	0x40(%rsi), %xmm7
vpxor	%xmm14, %xmm9, %xmm9
vmovdqu	0x20(%rdx), %xmm15
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpxor	%xmm1, %xmm4, %xmm4
vpshufb	%xmm13, %xmm15, %xmm15
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	0x30(%rsi), %xmm6
vpxor	%xmm2, %xmm5, %xmm5
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpclmulqdq	$0x0, %xmm7, %xmm9, %xmm2
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	0x10(%rdx), %xmm14
vpxor	%xmm3, %xmm0, %xmm0
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm3
vpxor	%xmm4, %xmm1, %xmm1
vpshufb	%xmm13, %xmm14, %xmm14
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm4
vmovdqu	0x50(%rsi), %xmm6
vpxor	%xmm5, %xmm2, %xmm2
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpclmulqdq	$0x10, %xmm7, %xmm8, %xmm5
vmovdqu	0x70(%rsi), %xmm7
vpxor	%xmm14, %xmm9, %xmm9
vmovdqu	(%rdx), %xmm15
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpxor	%xmm1, %xmm4, %xmm4
vpshufb	%xmm13, %xmm15, %xmm15
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	0x60(%rsi), %xmm6
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x10, %xmm7, %xmm9, %xmm2
leaq	0x80(%rdx), %rdx
cmpq	$0x80, %rcx
jb	L_1a80
vpxor	%xmm10, %xmm15, %xmm15
subq	$0x80, %rcx
jmp	L_1660
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	(%rax,%rax)
L_1660:
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vmovdqu	0x70(%rdx), %xmm14
vpxor	%xmm0, %xmm3, %xmm3
vpxor	%xmm15, %xmm8, %xmm8
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm10
vpshufb	%xmm13, %xmm14, %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm11
vmovdqu	-0x40(%rsi), %xmm6
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm12
vmovdqu	-0x20(%rsi), %xmm7
vpxor	%xmm14, %xmm9, %xmm9
vmovdqu	0x60(%rdx), %xmm15
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpxor	%xmm3, %xmm10, %xmm10
vpshufb	%xmm13, %xmm15, %xmm15
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vxorps	%xmm4, %xmm11, %xmm11
vmovdqu	-0x30(%rsi), %xmm6
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpclmulqdq	$0x0, %xmm7, %xmm9, %xmm2
vpxor	%xmm5, %xmm12, %xmm12
vxorps	%xmm15, %xmm8, %xmm8
vmovdqu	0x50(%rdx), %xmm14
vpxor	%xmm10, %xmm12, %xmm12
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm3
vpxor	%xmm11, %xmm12, %xmm12
vpslldq	$0x8, %xmm12, %xmm9
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm4
vpsrldq	$0x8, %xmm12, %xmm12
vpxor	%xmm9, %xmm10, %xmm10
vmovdqu	-0x10(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm14
vxorps	%xmm12, %xmm11, %xmm11
vpxor	%xmm1, %xmm4, %xmm4
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpclmulqdq	$0x10, %xmm7, %xmm8, %xmm5
vmovdqu	0x10(%rsi), %xmm7
vpxor	%xmm14, %xmm9, %xmm9
vpxor	%xmm2, %xmm5, %xmm5
vmovdqu	0x40(%rdx), %xmm15
vpalignr	$0x8, %xmm10, %xmm10, %xmm12
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpshufb	%xmm13, %xmm15, %xmm15
vpxor	%xmm3, %xmm0, %xmm0
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	(%rsi), %xmm6
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm4, %xmm1, %xmm1
vpclmulqdq	$0x0, %xmm7, %xmm9, %xmm2
vxorps	%xmm15, %xmm8, %xmm8
vpxor	%xmm5, %xmm2, %xmm2
vmovdqu	0x30(%rdx), %xmm14
vpclmulqdq	$0x10, (%r10), %xmm10, %xmm10
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm3
vpshufb	%xmm13, %xmm14, %xmm14
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm4
vmovdqu	0x20(%rsi), %xmm6
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x10, %xmm7, %xmm8, %xmm5
vmovdqu	0x40(%rsi), %xmm7
vpxor	%xmm14, %xmm9, %xmm9
vpxor	%xmm2, %xmm5, %xmm5
vmovdqu	0x20(%rdx), %xmm15
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpshufb	%xmm13, %xmm15, %xmm15
vpxor	%xmm3, %xmm0, %xmm0
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	0x30(%rsi), %xmm6
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm4, %xmm1, %xmm1
vpclmulqdq	$0x0, %xmm7, %xmm9, %xmm2
vpxor	%xmm15, %xmm8, %xmm8
vpxor	%xmm5, %xmm2, %xmm2
vxorps	%xmm12, %xmm10, %xmm10
vmovdqu	0x10(%rdx), %xmm14
vpalignr	$0x8, %xmm10, %xmm10, %xmm12
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm3
vpshufb	%xmm13, %xmm14, %xmm14
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm4
vmovdqu	0x50(%rsi), %xmm6
vpclmulqdq	$0x10, (%r10), %xmm10, %xmm10
vxorps	%xmm11, %xmm12, %xmm12
vpunpckhqdq	%xmm14, %xmm14, %xmm9
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x10, %xmm7, %xmm8, %xmm5
vmovdqu	0x70(%rsi), %xmm7
vpxor	%xmm14, %xmm9, %xmm9
vpxor	%xmm2, %xmm5, %xmm5
vmovdqu	(%rdx), %xmm15
vpclmulqdq	$0x0, %xmm6, %xmm14, %xmm0
vpshufb	%xmm13, %xmm15, %xmm15
vpclmulqdq	$0x11, %xmm6, %xmm14, %xmm1
vmovdqu	0x60(%rsi), %xmm6
vpxor	%xmm12, %xmm15, %xmm15
vpclmulqdq	$0x10, %xmm7, %xmm9, %xmm2
vpxor	%xmm10, %xmm15, %xmm15
leaq	0x80(%rdx), %rdx
subq	$0x80, %rcx
jae	L_1660
addq	$0x80, %rcx
jmp	L_1a85
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_18a0:
vmovdqu	-0x10(%rdx,%rcx), %xmm14
leaq	(%rdx,%rcx), %rdx
vmovdqu	-0x40(%rsi), %xmm6
vmovdqu	-0x20(%rsi), %xmm7
vpshufb	%xmm13, %xmm14, %xmm15
vmovdqa	%xmm0, %xmm3
vmovdqa	%xmm1, %xmm4
vmovdqa	%xmm2, %xmm5
subq	$0x10, %rcx
je	L_1a80
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	-0x20(%rdx), %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vmovdqu	-0x30(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm15
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vpsrldq	$0x8, %xmm7, %xmm7
subq	$0x10, %rcx
je	L_1a80
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	-0x30(%rdx), %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vmovdqu	-0x10(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm15
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vmovdqu	0x10(%rsi), %xmm7
subq	$0x10, %rcx
je	L_1a80
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	-0x40(%rdx), %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vmovdqu	(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm15
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vpsrldq	$0x8, %xmm7, %xmm7
subq	$0x10, %rcx
je	L_1a80
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	-0x50(%rdx), %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vmovdqu	0x20(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm15
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vmovdqu	0x40(%rsi), %xmm7
subq	$0x10, %rcx
je	L_1a80
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	-0x60(%rdx), %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vmovdqu	0x30(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm15
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vpsrldq	$0x8, %xmm7, %xmm7
subq	$0x10, %rcx
je	L_1a80
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vmovdqu	-0x70(%rdx), %xmm14
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vmovdqu	0x50(%rsi), %xmm6
vpshufb	%xmm13, %xmm14, %xmm15
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vmovq	0x78(%rsi), %xmm7
subq	$0x10, %rcx
jmp	L_1a80
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nop
L_1a80:
vpxor	%xmm10, %xmm15, %xmm15
L_1a85:
vpunpckhqdq	%xmm15, %xmm15, %xmm8
vpxor	%xmm0, %xmm3, %xmm3
vpclmulqdq	$0x0, %xmm6, %xmm15, %xmm0
vpxor	%xmm15, %xmm8, %xmm8
vpxor	%xmm1, %xmm4, %xmm4
vpclmulqdq	$0x11, %xmm6, %xmm15, %xmm1
vpxor	%xmm2, %xmm5, %xmm5
vpclmulqdq	$0x0, %xmm7, %xmm8, %xmm2
vmovdqu	(%r10), %xmm12
vpxor	%xmm0, %xmm3, %xmm10
vpxor	%xmm1, %xmm4, %xmm11
vpxor	%xmm2, %xmm5, %xmm5
vpxor	%xmm5, %xmm10, %xmm5
vpxor	%xmm5, %xmm11, %xmm5
vpslldq	$0x8, %xmm5, %xmm9
vpsrldq	$0x8, %xmm5, %xmm5
vpxor	%xmm9, %xmm10, %xmm10
vpxor	%xmm5, %xmm11, %xmm11
vpclmulqdq	$0x10, %xmm12, %xmm10, %xmm9
vpalignr	$0x8, %xmm10, %xmm10, %xmm10
vpxor	%xmm9, %xmm10, %xmm10
vpclmulqdq	$0x10, %xmm12, %xmm10, %xmm9
vpalignr	$0x8, %xmm10, %xmm10, %xmm10
vpxor	%xmm11, %xmm10, %xmm10
vpxor	%xmm9, %xmm10, %xmm10
cmpq	$0x0, %rcx
jne	L_18a0
vpshufb	%xmm13, %xmm10, %xmm10
vmovdqu	%xmm10, (%rdi)
vzeroupper
rep	retq
	.section .rodata
	.p2align 6
bums_rodata:
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,194
	.byte 7,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0
	.byte 7,0,0,0,0,0,0,0,194,1,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,28
	.byte 0,0,0,0,0,0,64,56,0,0,0,0,0,0,96,36
	.byte 0,0,0,0,0,0,128,112,0,0,0,0,0,0,160,108
	.byte 0,0,0,0,0,0,192,72,0,0,0,0,0,0,224,84
	.byte 0,0,0,0,0,0,0,225,0,0,0,0,0,0,32,253
	.byte 0,0,0,0,0,0,64,217,0,0,0,0,0,0,96,197
	.byte 0,0,0,0,0,0,128,145,0,0,0,0,0,0,160,141
	.byte 0,0,0,0,0,0,192,169,0,0,0,0,0,0,224,181
	.byte 0,0,194,1,132,3,70,2,8,7,202,6,140,4,78,5
	.byte 16,14,210,15,148,13,86,12,24,9,218,8,156,10,94,11
	.byte 32,28,226,29,164,31,102,30,40,27,234,26,172,24,110,25
	.byte 48,18,242,19,180,17,118,16,56,21,250,20,188,22,126,23
	.byte 64,56,130,57,196,59,6,58,72,63,138,62,204,60,14,61
	.byte 80,54,146,55,212,53,22,52,88,49,154,48,220,50,30,51
	.byte 96,36,162,37,228,39,38,38,104,35,170,34,236,32,46,33
	.byte 112,42,178,43,244,41,54,40,120,45,186,44,252,46,62,47
	.byte 128,112,66,113,4,115,198,114,136,119,74,118,12,116,206,117
	.byte 144,126,82,127,20,125,214,124,152,121,90,120,28,122,222,123
	.byte 160,108,98,109,36,111,230,110,168,107,106,106,44,104,238,105
	.byte 176,98,114,99,52,97,246,96,184,101,122,100,60,102,254,103
	.byte 192,72,2,73,68,75,134,74,200,79,10,78,76,76,142,77
	.byte 208,70,18,71,84,69,150,68,216,65,26,64,92,66,158,67
	.byte 224,84,34,85,100,87,166,86,232,83,42,82,108,80,174,81
	.byte 240,90,50,91,116,89,182,88,248,93,58,92,124,94,190,95
	.byte 0,225,194,224,132,226,70,227,8,230,202,231,140,229,78,228
	.byte 16,239,210,238,148,236,86,237,24,232,218,233,156,235,94,234
	.byte 32,253,226,252,164,254,102,255,40,250,234,251,172,249,110,248
	.byte 48,243,242,242,180,240,118,241,56,244,250,245,188,247,126,246
	.byte 64,217,130,216,196,218,6,219,72,222,138,223,204,221,14,220
	.byte 80,215,146,214,212,212,22,213,88,208,154,209,220,211,30,210
	.byte 96,197,162,196,228,198,38,199,104,194,170,195,236,193,46,192
	.byte 112,203,178,202,244,200,54,201,120,204,186,205,252,207,62,206
	.byte 128,145,66,144,4,146,198,147,136,150,74,151,12,149,206,148
	.byte 144,159,82,158,20,156,214,157,152,152,90,153,28,155,222,154
	.byte 160,141,98,140,36,142,230,143,168,138,106,139,44,137,238,136
	.byte 176,131,114,130,52,128,246,129,184,132,122,133,60,135,254,134
	.byte 192,169,2,168,68,170,134,171,200,174,10,175,76,173,142,172
	.byte 208,167,18,166,84,164,150,165,216,160,26,161,92,163,158,162
	.byte 224,181,34,180,100,182,166,183,232,178,42,179,108,177,174,176
	.byte 240,187,50,186,116,184,182,185,248,188,58,189,124,191,190,190
	.byte 71,72,65,83,72,32,102,111,114,32,120,56,54,95,54,52
	.byte 44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32
	.byte 60,104,116,116,112,115,58,47,47,103,105,116,104,117,98,46
	.byte 99,111,109,47,100,111,116,45,97,115,109,62,0,0,0,0
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

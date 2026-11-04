	.text
compare256_sse2:
movdqu	(%rdi), %xmm0
movdqu	(%rsi), %xmm1
pcmpeqb	%xmm0, %xmm1
pmovmskb	%xmm1, %eax
cmpl	$0xffff, %eax
je	L_21
movzwl	%ax, %eax
notl	%eax
tzcntl	%eax, %eax
retq
L_21:
movl	%edi, %edx
andl	$0xf, %edx
movl	%edx, %eax
movl	$0x10, %ecx
subq	%rax, %rcx
movdqu	(%rsi,%rcx), %xmm0
pcmpeqb	(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
jne	L_235
movdqu	0x10(%rsi,%rcx), %xmm0
pcmpeqb	0x10(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_6a
movl	$0x20, %ecx
jmp	L_233
L_6a:
movdqu	0x20(%rsi,%rcx), %xmm0
pcmpeqb	0x20(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_8b
movl	$0x30, %ecx
jmp	L_233
L_8b:
movdqu	0x30(%rsi,%rcx), %xmm0
pcmpeqb	0x30(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_ac
movl	$0x40, %ecx
jmp	L_233
L_ac:
movdqu	0x40(%rsi,%rcx), %xmm0
pcmpeqb	0x40(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_cd
movl	$0x50, %ecx
jmp	L_233
L_cd:
movdqu	0x50(%rsi,%rcx), %xmm0
pcmpeqb	0x50(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_ee
movl	$0x60, %ecx
jmp	L_233
L_ee:
movdqu	0x60(%rsi,%rcx), %xmm0
pcmpeqb	0x60(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_10f
movl	$0x70, %ecx
jmp	L_233
L_10f:
movdqu	0x70(%rsi,%rcx), %xmm0
pcmpeqb	0x70(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_130
movl	$0x80, %ecx
jmp	L_233
L_130:
movdqu	0x80(%rsi,%rcx), %xmm0
pcmpeqb	0x80(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_157
movl	$0x90, %ecx
jmp	L_233
L_157:
movdqu	0x90(%rsi,%rcx), %xmm0
pcmpeqb	0x90(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_17e
movl	$0xa0, %ecx
jmp	L_233
L_17e:
movdqu	0xa0(%rsi,%rcx), %xmm0
pcmpeqb	0xa0(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_1a5
movl	$0xb0, %ecx
jmp	L_233
L_1a5:
movdqu	0xb0(%rsi,%rcx), %xmm0
pcmpeqb	0xb0(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_1c9
movl	$0xc0, %ecx
jmp	L_233
L_1c9:
movdqu	0xc0(%rsi,%rcx), %xmm0
pcmpeqb	0xc0(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_1ed
movl	$0xd0, %ecx
jmp	L_233
L_1ed:
movdqu	0xd0(%rsi,%rcx), %xmm0
pcmpeqb	0xd0(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_211
movl	$0xe0, %ecx
jmp	L_233
L_211:
movdqu	0xe0(%rsi,%rcx), %xmm0
pcmpeqb	0xe0(%rdi,%rcx), %xmm0
pmovmskb	%xmm0, %eax
cmpl	$0xffff, %eax
je	L_241
movl	$0xf0, %ecx
L_233:
subl	%edx, %ecx
L_235:
movzwl	%ax, %eax
notl	%eax
tzcntl	%eax, %eax
addl	%ecx, %eax
retq
L_241:
movl	$0x100, %eax
testl	%edx, %edx
je	L_278
movdqu	0xf0(%rdi), %xmm0
movdqu	0xf0(%rsi), %xmm1
pcmpeqb	%xmm0, %xmm1
pmovmskb	%xmm1, %ecx
cmpl	$0xffff, %ecx
je	L_278
movzwl	%cx, %eax
notl	%eax
tzcntl	%eax, %eax
addl	$0xf0, %eax
L_278:
retq
nopl	(%rax)
longest_match_sse2:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
pushq	%rax
movl	0x84(%rdi), %r12d
movq	0x58(%rdi), %rdx
movl	0x8c(%rdi), %ecx
testl	%ecx, %ecx
movl	$0x2, %eax
cmovnel	%ecx, %eax
leaq	(%rdx,%r12), %r8
xorl	%ecx, %ecx
cmpl	$0x8, %eax
setb	%cl
shll	$0x2, %ecx
orl	$-0x7, %ecx
cmpl	$0x4, %eax
movl	$0xffffffff, %r9d
cmovael	%ecx, %r9d
addl	%eax, %r9d
movq	%r8, -0x8(%rsp)
movq	(%r9,%r8), %r11
movl	%r11d, %ecx
shrl	$0x10, %ecx
movl	%ecx, -0x64(%rsp)
movq	%r11, %rcx
shrq	$0x20, %rcx
movq	%rcx, (%rsp)
addq	%rdx, %r9
movl	0x90(%rdi), %ecx
movl	%ecx, %r10d
shrl	$0x2, %r10d
cmpl	0xb8(%rdi), %eax
cmovbl	%ecx, %r10d
movl	$0xfffffefa, %ecx
addl	0x40(%rdi), %ecx
xorl	%r8d, %r8d
movl	%r12d, %ebx
subl	%ecx, %ebx
cmovbl	%r8d, %ebx
leaq	(%rdx,%r12), %rbp
addq	$0x2, %rbp
movl	%ebp, %r15d
andl	$0xf, %r15d
movl	$0x10, %ecx
subq	%r15, %rcx
movq	%rcx, -0x78(%rsp)
movl	$0x20, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x1c(%rsp)
movl	$0x30, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x20(%rsp)
movl	$0x40, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x24(%rsp)
movl	$0x50, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x28(%rsp)
movl	$0x60, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x2c(%rsp)
movl	$0x70, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x30(%rsp)
movl	$0x80, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x34(%rsp)
movl	$0x90, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x38(%rsp)
movl	$0xa0, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x3c(%rsp)
movl	$0xb0, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x40(%rsp)
movl	$0xc0, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x44(%rsp)
movl	$0xd0, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x48(%rsp)
movl	$0xe0, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x4c(%rsp)
movl	$0xf0, %ecx
subl	%r15d, %ecx
movl	%ecx, -0x50(%rsp)
movl	0x48(%rdi), %r14d
movl	0x4c(%rdi), %ecx
movl	%ecx, -0x54(%rsp)
movq	0x60(%rdi), %r8
movq	(%rdx,%r12), %r13
movl	0xbc(%rdi), %ecx
movl	%ecx, -0x18(%rsp)
movl	0xb0(%rdi), %ecx
movl	%ecx, -0x14(%rsp)
L_3ff:
movzwl	%si, %ecx
cmpl	%ecx, %r12d
jbe	L_962
cmpl	$0x3, %eax
ja	L_450
L_410:
movzwl	%si, %esi
cmpw	%r11w, (%r9,%rsi)
jne	L_425
cmpw	%r13w, (%rdx,%rsi)
je	L_4f6
L_425:
cmpl	$0x1, %r10d
je	L_962
andl	%r14d, %esi
movzwl	(%r8,%rsi,2), %esi
decl	%r10d
cmpw	%bx, %si
ja	L_410
jmp	L_962
nopw	%cs:(%rax,%rax)
L_450:
movq	%rbp, -0x60(%rsp)
movzwl	%r11w, %ecx
cmpl	$0x7, %eax
jbe	L_4b0
movq	%r12, %rbp
movl	-0x64(%rsp), %r12d
shll	$0x10, %r12d
orq	%r12, %rcx
movq	(%rsp), %r12
shlq	$0x20, %r12
orq	%rcx, %r12
nopl	(%rax,%rax)
L_480:
movzwl	%si, %esi
cmpq	%r12, (%r9,%rsi)
jne	L_48f
cmpq	%r13, (%rdx,%rsi)
je	L_4ee
L_48f:
cmpl	$0x1, %r10d
je	L_962
andl	%r14d, %esi
movzwl	(%r8,%rsi,2), %esi
decl	%r10d
cmpw	%bx, %si
ja	L_480
jmp	L_962
nop
L_4b0:
movl	-0x64(%rsp), %ebp
shll	$0x10, %ebp
orl	%ecx, %ebp
nopl	(%rax)
L_4c0:
movzwl	%si, %esi
cmpl	%ebp, (%r9,%rsi)
jne	L_4cf
cmpl	%r13d, (%rdx,%rsi)
je	L_4f1
L_4cf:
cmpl	$0x1, %r10d
je	L_962
andl	%r14d, %esi
movzwl	(%r8,%rsi,2), %esi
decl	%r10d
cmpw	%bx, %si
ja	L_4c0
jmp	L_962
L_4ee:
movq	%rbp, %r12
L_4f1:
movq	-0x60(%rsp), %rbp
L_4f6:
movdqu	(%rbp), %xmm0
movdqu	0x2(%rdx,%rsi), %xmm1
pcmpeqb	%xmm0, %xmm1
pmovmskb	%xmm1, %ecx
cmpl	$0xffff, %ecx
movq	%r12, -0x10(%rsp)
movq	%rbp, -0x60(%rsp)
je	L_52a
movzwl	%cx, %ecx
notl	%ecx
tzcntl	%ecx, %r12d
jmp	L_86a
L_52a:
leaq	(%rdx,%rsi), %r12
addq	$0x2, %r12
movq	-0x78(%rsp), %rcx
movq	%r12, -0x70(%rsp)
movdqu	(%r12,%rcx), %xmm0
pcmpeqb	(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x10(%r12,%rcx), %xmm0
pcmpeqb	0x10(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x1c(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x20(%r12,%rcx), %xmm0
pcmpeqb	0x20(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x20(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x30(%r12,%rcx), %xmm0
pcmpeqb	0x30(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x24(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x40(%r12,%rcx), %xmm0
pcmpeqb	0x40(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x28(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x50(%r12,%rcx), %xmm0
pcmpeqb	0x50(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x2c(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x60(%r12,%rcx), %xmm0
pcmpeqb	0x60(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x30(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x70(%r12,%rcx), %xmm0
pcmpeqb	0x70(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x34(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x80(%r12,%rcx), %xmm0
pcmpeqb	0x80(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x38(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0x90(%r12,%rcx), %xmm0
pcmpeqb	0x90(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x3c(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0xa0(%r12,%rcx), %xmm0
pcmpeqb	0xa0(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x40(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0xb0(%r12,%rcx), %xmm0
pcmpeqb	0xb0(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x44(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0xc0(%r12,%rcx), %xmm0
pcmpeqb	0xc0(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x48(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0xd0(%r12,%rcx), %xmm0
pcmpeqb	0xd0(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x4c(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
jne	L_85b
movq	-0x78(%rsp), %rcx
movq	-0x70(%rsp), %r12
movdqu	0xe0(%r12,%rcx), %xmm0
pcmpeqb	0xe0(%rbp,%rcx), %xmm0
pmovmskb	%xmm0, %r12d
movl	-0x50(%rsp), %ecx
movl	%ecx, -0x7c(%rsp)
movl	%r12d, %ecx
cmpl	$0xffff, %r12d
je	L_906
L_85b:
movzwl	%cx, %ecx
notl	%ecx
tzcntl	%ecx, %r12d
addl	-0x7c(%rsp), %r12d
L_86a:
leal	0x2(%r12), %ebp
cmpl	%eax, %ebp
jbe	L_8dd
movl	%esi, 0x88(%rdi)
cmpl	-0x54(%rsp), %ebp
jae	L_95a
cmpl	-0x18(%rsp), %ebp
jae	L_960
cmpl	$0x6, %r12d
movl	$0x0, %r9d
sbbl	%r9d, %r9d
orl	$-0x5, %r9d
cmpl	$0x2, %r12d
movl	$0x1, %eax
cmovbl	%eax, %r9d
addl	%r12d, %r9d
movq	-0x8(%rsp), %rax
movq	(%rax,%r9), %r11
movl	%r11d, %eax
shrl	$0x10, %eax
movl	%eax, -0x64(%rsp)
movq	%r11, %rax
shrq	$0x20, %rax
movq	%rax, (%rsp)
addq	%rdx, %r9
movl	%ebp, %eax
movq	-0x10(%rsp), %r12
movq	-0x60(%rsp), %rbp
jmp	L_8ee
L_8dd:
cmpl	$0x5, -0x14(%rsp)
movq	-0x10(%rsp), %r12
movq	-0x60(%rsp), %rbp
jl	L_962
L_8ee:
decl	%r10d
je	L_962
andl	%r14d, %esi
movzwl	(%r8,%rsi,2), %esi
cmpw	%bx, %si
ja	L_3ff
jmp	L_962
L_906:
movl	$0x100, %r12d
testl	%r15d, %r15d
je	L_86a
movq	%rsi, %rcx
addq	%rdx, %rcx
movq	-0x8(%rsp), %rbp
movdqu	0xf2(%rbp), %xmm0
movdqu	0xf2(%rcx), %xmm1
pcmpeqb	%xmm0, %xmm1
pmovmskb	%xmm1, %ecx
cmpl	$0xffff, %ecx
je	L_86a
movzwl	%cx, %ecx
notl	%ecx
tzcntl	%ecx, %r12d
addl	$0xf0, %r12d
jmp	L_86a
L_95a:
movl	-0x54(%rsp), %eax
jmp	L_962
L_960:
movl	%ebp, %eax
L_962:
addq	$0x8, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
nopw	%cs:(%rax,%rax)
longest_match_slow_sse2:
pushq	%rbp
pushq	%r15
pushq	%r14
pushq	%r13
pushq	%r12
pushq	%rbx
subq	$0xd8, %rsp
movl	%esi, %r14d
movq	%rdi, %rbx
movl	0x84(%rdi), %r9d
movl	0x48(%rdi), %r10d
movq	0x58(%rdi), %r11
leaq	(%r11,%r9), %rsi
movl	0x8c(%rdi), %eax
testl	%eax, %eax
movl	$0x2, %edx
cmovnel	%eax, %edx
xorl	%eax, %eax
cmpl	$0x8, %edx
setb	%al
shll	$0x2, %eax
orl	$-0x7, %eax
cmpl	$0x4, %edx
movl	$0xffffffff, %r8d
cmovael	%eax, %r8d
addl	%edx, %r8d
movq	(%r8,%rsi), %rbp
addq	%r11, %r8
movl	0x90(%rdi), %eax
movl	%eax, %r15d
shrl	$0x2, %r15d
cmpl	0xb8(%rdi), %edx
movl	0x4c(%rdi), %r13d
cmovbl	%eax, %r15d
movl	$0xfffffefa, %eax
addl	0x40(%rdi), %eax
xorl	%r12d, %r12d
movl	%r9d, %edi
subl	%eax, %edi
cmovbel	%r12d, %edi
movq	0x60(%rbx), %rax
movq	%rax, 0x48(%rsp)
movq	(%r11,%r9), %rax
movl	0xbc(%rbx), %ecx
movl	%ecx, 0xb4(%rsp)
movl	%edx, 0x8(%rsp)
cmpl	$0x3, %edx
movq	%rax, 0x70(%rsp)
movl	%r13d, 0x54(%rsp)
jb	L_b05
movl	%r15d, 0x44(%rsp)
movq	%rbp, 0x28(%rsp)
movq	%rdi, 0x20(%rsp)
movq	%r8, 0x38(%rsp)
movq	%r11, 0x60(%rsp)
movl	%r10d, 0x1c(%rsp)
movq	%r9, 0x68(%rsp)
movq	%rsi, %rbp
movzbl	%ah, %esi
xorl	%r12d, %r12d
xorl	%edi, %edi
callq	*0x98(%rbx)
movzbl	0x2(%rbp), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movl	$0x3, %r13d
movl	0x8(%rsp), %r15d
nopw	(%rax,%rax)
L_a90:
movl	%r13d, %ecx
movzbl	(%rbp,%rcx), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movq	0x68(%rbx), %rcx
movl	%eax, %edx
movzwl	(%rcx,%rdx,2), %ecx
leal	-0x2(%r13), %edx
cmpw	%r14w, %cx
cmovbl	%edx, %r12d
cmovbl	%ecx, %r14d
incl	%r13d
cmpl	%r15d, %r13d
jbe	L_a90
movq	0x20(%rsp), %rdi
leal	(%r12,%rdi), %ecx
cmpw	%cx, %r14w
movq	0x38(%rsp), %r8
jbe	L_12e2
movzwl	%r12w, %edx
movq	0x60(%rsp), %r11
movq	%r11, %r13
subq	%rdx, %r13
subq	%rdx, %r8
movq	0x68(%rsp), %r9
movl	0x1c(%rsp), %r10d
movq	%rbp, %rsi
movq	0x28(%rsp), %rbp
movl	0x44(%rsp), %r15d
jmp	L_b0a
L_b05:
movl	%edi, %ecx
movq	%r11, %r13
L_b0a:
movzwl	%r14w, %edx
cmpl	%edx, %r9d
jbe	L_12dc
movl	%ebp, %eax
shrl	$0x10, %eax
movl	%eax, 0x40(%rsp)
movq	%rbp, %rax
shrq	$0x20, %rax
movq	%rax, 0xc0(%rsp)
movq	%rsi, 0x58(%rsp)
leaq	0x2(%rsi), %rdx
movl	%edx, %eax
andl	$0xf, %eax
movl	$0x10, %esi
subq	%rax, %rsi
movq	%rsi, 0xd0(%rsp)
movl	$0x20, %esi
subl	%eax, %esi
movl	%esi, 0xb0(%rsp)
movl	$0x30, %esi
subl	%eax, %esi
movl	%esi, 0xac(%rsp)
movl	$0x40, %esi
subl	%eax, %esi
movl	%esi, 0xa8(%rsp)
movl	$0x50, %esi
subl	%eax, %esi
movl	%esi, 0xa4(%rsp)
movl	$0x60, %esi
subl	%eax, %esi
movl	%esi, 0xa0(%rsp)
movl	$0x70, %esi
subl	%eax, %esi
movl	%esi, 0x9c(%rsp)
movl	$0x80, %esi
subl	%eax, %esi
movl	%esi, 0x98(%rsp)
movl	$0x90, %esi
subl	%eax, %esi
movl	%esi, 0x94(%rsp)
movl	$0xa0, %esi
subl	%eax, %esi
movl	%esi, 0x90(%rsp)
movl	$0xb0, %esi
subl	%eax, %esi
movl	%esi, 0x8c(%rsp)
movl	$0xc0, %esi
subl	%eax, %esi
movl	%esi, 0x88(%rsp)
movl	$0xd0, %esi
subl	%eax, %esi
movl	%esi, 0x84(%rsp)
movl	$0xe0, %esi
subl	%eax, %esi
movl	%esi, 0x80(%rsp)
movl	$0xf0, %esi
movq	%rax, 0xc8(%rsp)
subl	%eax, %esi
movl	%esi, 0x7c(%rsp)
movzwl	%di, %eax
movq	%rax, 0xb8(%rsp)
movl	0x8(%rsp), %eax
movq	%rdx, 0x10(%rsp)
L_c2a:
cmpl	$0x3, %eax
movq	%rbp, 0x28(%rsp)
movl	%eax, %esi
ja	L_c90
movl	%esi, %eax
nopl	(%rax,%rax)
L_c40:
movzwl	%r14w, %edx
cmpw	%bp, (%r8,%rdx)
jne	L_c5c
movq	0x70(%rsp), %rsi
cmpw	%si, (%r13,%rdx)
je	L_d50
L_c5c:
cmpl	$0x1, %r15d
je	L_12ee
andl	%r10d, %edx
movq	0x48(%rsp), %rsi
movzwl	(%rsi,%rdx,2), %r14d
decl	%r15d
cmpw	%cx, %r14w
ja	L_c40
jmp	L_12ee
nopw	%cs:(%rax,%rax)
L_c90:
movzwl	%bp, %edx
movl	%esi, %eax
cmpl	$0x7, %esi
jbe	L_d00
movl	0x40(%rsp), %esi
shll	$0x10, %esi
orq	%rsi, %rdx
movq	0xc0(%rsp), %rsi
shlq	$0x20, %rsi
orq	%rdx, %rsi
nopw	%cs:(%rax,%rax)
L_cc0:
movzwl	%r14w, %edx
cmpq	%rsi, (%r8,%rdx)
jne	L_cdb
movq	0x70(%rsp), %rbp
cmpq	%rbp, (%r13,%rdx)
movq	0x28(%rsp), %rbp
je	L_d50
L_cdb:
cmpl	$0x1, %r15d
je	L_12ee
andl	%r10d, %edx
movq	0x48(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%cx, %r14w
ja	L_cc0
jmp	L_12ee
L_d00:
movl	0x40(%rsp), %esi
shll	$0x10, %esi
orl	%edx, %esi
nopl	(%rax)
L_d10:
movzwl	%r14w, %edx
cmpl	%esi, (%r8,%rdx)
jne	L_d2b
movq	0x70(%rsp), %rbp
cmpl	%ebp, (%r13,%rdx)
movq	0x28(%rsp), %rbp
je	L_d50
L_d2b:
cmpl	$0x1, %r15d
je	L_12ee
andl	%r10d, %edx
movq	0x48(%rsp), %r14
movzwl	(%r14,%rdx,2), %r14d
decl	%r15d
cmpw	%cx, %r14w
ja	L_d10
jmp	L_12ee
L_d50:
movq	0x10(%rsp), %rsi
movdqu	(%rsi), %xmm0
movdqu	0x2(%r13,%rdx), %xmm1
pcmpeqb	%xmm0, %xmm1
pmovmskb	%xmm1, %esi
cmpl	$0xffff, %esi
je	L_d7e
movzwl	%si, %edx
notl	%edx
tzcntl	%edx, %esi
jmp	L_1078
L_d7e:
movq	%rdi, 0x20(%rsp)
movq	%r8, 0x38(%rsp)
leaq	(%rdx,%r13), %rdi
addq	$0x2, %rdi
movq	0xd0(%rsp), %rsi
movq	%rdi, 0x8(%rsp)
movdqu	(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	%esi, %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x10(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x10(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0xb0(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x20(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x20(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0xac(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x30(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x30(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0xa8(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x40(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x40(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0xa4(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x50(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x50(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0xa0(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x60(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x60(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x9c(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x70(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x70(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x98(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x80(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x80(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x94(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0x90(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0x90(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x90(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0xa0(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0xa0(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x8c(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0xb0(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0xb0(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x88(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0xc0(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0xc0(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x84(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0xd0(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0xd0(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x80(%rsp), %r8d
cmpl	$0xffff, %edi
jne	L_1062
movq	0x8(%rsp), %rdi
movdqu	0xe0(%rdi,%rsi), %xmm0
movq	0x10(%rsp), %rdi
pcmpeqb	0xe0(%rdi,%rsi), %xmm0
pmovmskb	%xmm0, %edi
movl	0x7c(%rsp), %r8d
cmpl	$0xffff, %edi
je	L_1265
L_1062:
movzwl	%di, %edx
notl	%edx
tzcntl	%edx, %esi
addl	%r8d, %esi
movq	0x38(%rsp), %r8
movq	0x20(%rsp), %rdi
L_1078:
movq	%rsi, 0x8(%rsp)
movl	%esi, %edx
addq	$0x2, %rdx
movzwl	%r14w, %esi
cmpl	%eax, %edx
jbe	L_1123
movzwl	%r12w, %eax
movl	%esi, %r14d
subl	%eax, %r14d
movl	%r14d, 0x88(%rbx)
cmpl	0x54(%rsp), %edx
jae	L_1300
movq	%rdx, 0x30(%rsp)
cmpl	0xb4(%rsp), %edx
jae	L_1306
movq	%rdi, 0x20(%rsp)
movq	0x8(%rsp), %rdx
leal	0x1(%rdx), %edi
leal	-0x1(%rdx), %eax
leal	-0x5(%rdx), %r8d
cmpl	$0x6, %edx
movl	%eax, 0x1c(%rsp)
cmovbl	%eax, %r8d
cmpl	$0x2, %edx
cmovbl	%edi, %r8d
movq	0x58(%rsp), %rax
movq	(%rax,%r8), %rbp
movl	%ebp, %eax
shrl	$0x10, %eax
movl	%eax, 0x40(%rsp)
movq	%rbp, %rax
shrq	$0x20, %rax
movq	%rax, 0xc0(%rsp)
cmpl	$0x2, %edx
jb	L_1116
movq	0x30(%rsp), %rax
leal	(%rax,%r14), %edi
cmpl	%r9d, %edi
jb	L_1159
L_1116:
addq	%r13, %r8
movq	0x30(%rsp), %rax
movq	0x20(%rsp), %rdi
L_1123:
decl	%r15d
je	L_12ee
andl	%r10d, %esi
movq	0x48(%rsp), %rdx
movzwl	(%rdx,%rsi,2), %r14d
movl	%eax, %esi
cmpw	%cx, %r14w
jbe	L_12ee
L_1145:
movzwl	%r14w, %edx
movl	%esi, %eax
cmpl	%edx, %r9d
ja	L_c2a
jmp	L_12ee
L_1159:
movl	%r15d, 0x44(%rsp)
movq	%rbp, 0x28(%rsp)
movq	%r8, 0x38(%rsp)
movq	0x58(%rsp), %r13
movq	%r11, 0x60(%rsp)
movq	%r9, 0x68(%rsp)
movzwl	%r14w, %eax
xorl	%ecx, %ecx
xorl	%r12d, %r12d
movq	0xb8(%rsp), %r9
movl	0x1c(%rsp), %edx
jmp	L_1194
L_118e:
incl	%ecx
cmpl	%edx, %ecx
ja	L_11c1
L_1194:
leal	(%rax,%rcx), %esi
andl	%r10d, %esi
movq	0x48(%rsp), %rdi
movzwl	(%rdi,%rsi,2), %esi
cmpw	%r14w, %si
jae	L_118e
movzwl	%si, %edi
leal	(%r9,%rcx), %r8d
cmpl	%edi, %r8d
jae	L_130d
movl	%ecx, %r12d
movl	%esi, %r14d
jmp	L_118e
L_11c1:
movl	%r10d, 0x1c(%rsp)
movq	0x30(%rsp), %rbp
movzbl	-0x4(%r13,%rbp), %esi
xorl	%edi, %edi
callq	*0x98(%rbx)
movzbl	-0x3(%r13,%rbp), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movzbl	-0x2(%r13,%rbp), %esi
movl	%eax, %edi
callq	*0x98(%rbx)
movq	0x68(%rbx), %rcx
movl	%eax, %eax
movzwl	(%rcx,%rax,2), %eax
cmpw	%r14w, %ax
jae	L_1227
movzwl	%ax, %ecx
movq	0x8(%rsp), %r12
addl	$-0x2, %r12d
movzwl	%r12w, %edx
addl	0xb8(%rsp), %edx
movl	%eax, %r14d
cmpl	%ecx, %edx
jae	L_130d
L_1227:
movq	0x20(%rsp), %rdi
leal	(%r12,%rdi), %ecx
movzwl	%r12w, %edx
movq	0x60(%rsp), %r11
movq	%r11, %r13
subq	%rdx, %r13
movq	0x38(%rsp), %r8
addq	%r13, %r8
movq	0x68(%rsp), %r9
movl	0x1c(%rsp), %r10d
movq	0x28(%rsp), %rbp
movl	0x44(%rsp), %r15d
movq	0x30(%rsp), %rsi
jmp	L_1145
L_1265:
movq	0x58(%rsp), %rsi
cmpl	$0x0, 0xc8(%rsp)
je	L_12c3
addq	%r13, %rdx
movdqu	0xf2(%rsi), %xmm0
movdqu	0xf2(%rdx), %xmm1
pcmpeqb	%xmm0, %xmm1
pmovmskb	%xmm1, %edx
cmpl	$0xffff, %edx
movq	0x38(%rsp), %r8
movq	0x20(%rsp), %rdi
movq	0x28(%rsp), %rbp
movl	$0x100, %esi
je	L_1078
movzwl	%dx, %edx
notl	%edx
tzcntl	%edx, %esi
addl	$0xf0, %esi
jmp	L_1078
L_12c3:
movq	0x38(%rsp), %r8
movq	0x20(%rsp), %rdi
movq	0x28(%rsp), %rbp
movl	$0x100, %esi
jmp	L_1078
L_12dc:
movl	0x8(%rsp), %eax
jmp	L_12ee
L_12e2:
movl	0x8(%rsp), %ecx
L_12e6:
movl	0x4c(%rbx), %eax
cmpl	%eax, %ecx
cmovbl	%ecx, %eax
L_12ee:
addq	$0xd8, %rsp
popq	%rbx
popq	%r12
popq	%r13
popq	%r14
popq	%r15
popq	%rbp
retq
L_1300:
movl	0x54(%rsp), %eax
jmp	L_12ee
L_1306:
movq	0x30(%rsp), %rax
jmp	L_12ee
L_130d:
movq	0x30(%rsp), %rax
movl	%eax, %ecx
jmp	L_12e6

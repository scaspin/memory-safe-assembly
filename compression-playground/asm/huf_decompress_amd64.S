	.text
HUF_decompress4X1_usingDTable_internal_fast_asm_loop:
_HUF_decompress4X1_usingDTable_internal_fast_asm_loop:
pushq	%rax
pushq	%rbx
pushq	%rcx
pushq	%rdx
pushq	%rbp
pushq	%rsi
pushq	%rdi
pushq	%r8
pushq	%r9
pushq	%r10
pushq	%r11
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movq	%rdi, %rax
movq	(%rax), %r8
movq	0x8(%rax), %r9
movq	0x10(%rax), %r10
movq	0x18(%rax), %r11
movq	0x20(%rax), %rsi
movq	0x28(%rax), %rbx
movq	0x30(%rax), %rcx
movq	0x38(%rax), %rdi
movq	0x40(%rax), %rbp
movq	0x48(%rax), %rdx
movq	0x50(%rax), %r12
movq	0x58(%rax), %r13
movq	0x60(%rax), %r14
pushq	%rax
pushq	0x68(%rax)
pushq	0x70(%rax)
pushq	%r15
subq	$0x18, %rsp
L_5a:
movq	%rbx, (%rsp)
movq	%rdx, 0x8(%rsp)
movq	0x20(%rsp), %rax
subq	%rdi, %rax
movabsq	$-0x3333333333333333, %rdx
mulq	%rdx
movq	%rdx, %r15
shrq	$0x2, %r15
movq	%r8, %rax
movq	0x28(%rsp), %rdx
subq	%rdx, %rax
movq	%rax, %rbx
movabsq	$0x2492492492492493, %rdx
mulq	%rdx
subq	%rdx, %rbx
shrq	%rbx
addq	%rbx, %rdx
shrq	$0x2, %rdx
cmpq	%rdx, %r15
cmovaq	%rdx, %r15
leaq	(%r15,%r15,4), %r15
addq	%rdi, %r15
movq	0x8(%rsp), %rdx
movq	(%rsp), %rbx
movq	%rdi, %rax
cmpq	%rax, %r15
je	L_42e
cmpq	%r8, %r9
jb	L_42e
cmpq	%r9, %r10
jb	L_42e
cmpq	%r10, %r11
jb	L_42e
movq	%r15, 0x18(%rsp)
movq	%r9, (%rsp)
movq	%r10, 0x8(%rsp)
movq	%r11, 0x10(%rsp)
movq	$0x35, %r15
shrxq	%r15, %rbp, %r15
movzwl	(%r14,%r15,2), %r15d
movq	$0x35, %r9
shrxq	%r9, %rdx, %r9
movzwl	(%r14,%r9,2), %r9d
movq	$0x35, %r10
shrxq	%r10, %r12, %r10
movzwl	(%r14,%r10,2), %r10d
movq	$0x35, %r11
shrxq	%r11, %r13, %r11
movzwl	(%r14,%r11,2), %r11d
nopl	(%rax)
L_140:
movq	%r15, %rax
shlxq	%r15, %rbp, %rbp
movb	%ah, (%rsi)
movq	$0x35, %r15
shrxq	%r15, %rbp, %r15
movzwl	(%r14,%r15,2), %r15d
movq	%r9, %rax
shlxq	%r9, %rdx, %rdx
movb	%ah, (%rbx)
movq	$0x35, %r9
shrxq	%r9, %rdx, %r9
movzwl	(%r14,%r9,2), %r9d
movq	%r10, %rax
shlxq	%r10, %r12, %r12
movb	%ah, (%rcx)
movq	$0x35, %r10
shrxq	%r10, %r12, %r10
movzwl	(%r14,%r10,2), %r10d
movq	%r11, %rax
shlxq	%r11, %r13, %r13
movb	%ah, (%rdi)
movq	$0x35, %r11
shrxq	%r11, %r13, %r11
movzwl	(%r14,%r11,2), %r11d
movq	%r15, %rax
shlxq	%r15, %rbp, %rbp
movb	%ah, 0x1(%rsi)
movq	$0x35, %r15
shrxq	%r15, %rbp, %r15
movzwl	(%r14,%r15,2), %r15d
movq	%r9, %rax
shlxq	%r9, %rdx, %rdx
movb	%ah, 0x1(%rbx)
movq	$0x35, %r9
shrxq	%r9, %rdx, %r9
movzwl	(%r14,%r9,2), %r9d
movq	%r10, %rax
shlxq	%r10, %r12, %r12
movb	%ah, 0x1(%rcx)
movq	$0x35, %r10
shrxq	%r10, %r12, %r10
movzwl	(%r14,%r10,2), %r10d
movq	%r11, %rax
shlxq	%r11, %r13, %r13
movb	%ah, 0x1(%rdi)
movq	$0x35, %r11
shrxq	%r11, %r13, %r11
movzwl	(%r14,%r11,2), %r11d
movq	%r15, %rax
shlxq	%r15, %rbp, %rbp
movb	%ah, 0x2(%rsi)
movq	$0x35, %r15
shrxq	%r15, %rbp, %r15
movzwl	(%r14,%r15,2), %r15d
movq	%r9, %rax
shlxq	%r9, %rdx, %rdx
movb	%ah, 0x2(%rbx)
movq	$0x35, %r9
shrxq	%r9, %rdx, %r9
movzwl	(%r14,%r9,2), %r9d
movq	%r10, %rax
shlxq	%r10, %r12, %r12
movb	%ah, 0x2(%rcx)
movq	$0x35, %r10
shrxq	%r10, %r12, %r10
movzwl	(%r14,%r10,2), %r10d
movq	%r11, %rax
shlxq	%r11, %r13, %r13
movb	%ah, 0x2(%rdi)
movq	$0x35, %r11
shrxq	%r11, %r13, %r11
movzwl	(%r14,%r11,2), %r11d
movq	%r15, %rax
shlxq	%r15, %rbp, %rbp
movb	%ah, 0x3(%rsi)
movq	$0x35, %r15
shrxq	%r15, %rbp, %r15
movzwl	(%r14,%r15,2), %r15d
movq	%r9, %rax
shlxq	%r9, %rdx, %rdx
movb	%ah, 0x3(%rbx)
movq	$0x35, %r9
shrxq	%r9, %rdx, %r9
movzwl	(%r14,%r9,2), %r9d
movq	%r10, %rax
shlxq	%r10, %r12, %r12
movb	%ah, 0x3(%rcx)
movq	$0x35, %r10
shrxq	%r10, %r12, %r10
movzwl	(%r14,%r10,2), %r10d
movq	%r11, %rax
shlxq	%r11, %r13, %r13
movb	%ah, 0x3(%rdi)
movq	$0x35, %r11
shrxq	%r11, %r13, %r11
movzwl	(%r14,%r11,2), %r11d
movq	%r15, %rax
shlxq	%r15, %rbp, %rbp
movb	%ah, 0x4(%rsi)
movq	%r9, %rax
shlxq	%r9, %rdx, %rdx
movb	%ah, 0x4(%rbx)
movq	%r10, %rax
shlxq	%r10, %r12, %r12
movb	%ah, 0x4(%rcx)
movq	%r11, %rax
shlxq	%r11, %r13, %r13
movb	%ah, 0x4(%rdi)
movq	(%rsp), %r9
movq	0x8(%rsp), %r10
movq	0x10(%rsp), %r11
bsfq	%rbp, %rbp
movq	%rbp, %rax
andq	$0x7, %rax
shrq	$0x3, %rbp
leaq	0x5(%rsi), %rsi
subq	%rbp, %r8
movq	(%r8), %rbp
orq	$0x1, %rbp
shlxq	%rax, %rbp, %rbp
movq	$0x35, %r15
shrxq	%r15, %rbp, %r15
movzwl	(%r14,%r15,2), %r15d
bsfq	%rdx, %rdx
movq	%rdx, %rax
andq	$0x7, %rax
shrq	$0x3, %rdx
leaq	0x5(%rbx), %rbx
subq	%rdx, %r9
movq	(%r9), %rdx
orq	$0x1, %rdx
shlxq	%rax, %rdx, %rdx
movq	%r9, (%rsp)
movq	$0x35, %r9
shrxq	%r9, %rdx, %r9
movzwl	(%r14,%r9,2), %r9d
bsfq	%r12, %r12
movq	%r12, %rax
andq	$0x7, %rax
shrq	$0x3, %r12
leaq	0x5(%rcx), %rcx
subq	%r12, %r10
movq	(%r10), %r12
orq	$0x1, %r12
shlxq	%rax, %r12, %r12
movq	%r10, 0x8(%rsp)
movq	$0x35, %r10
shrxq	%r10, %r12, %r10
movzwl	(%r14,%r10,2), %r10d
bsfq	%r13, %r13
movq	%r13, %rax
andq	$0x7, %rax
shrq	$0x3, %r13
leaq	0x5(%rdi), %rdi
subq	%r13, %r11
movq	(%r11), %r13
orq	$0x1, %r13
shlxq	%rax, %r13, %r13
movq	%r11, 0x10(%rsp)
movq	$0x35, %r11
shrxq	%r11, %r13, %r11
movzwl	(%r14,%r11,2), %r11d
cmpq	%rdi, 0x18(%rsp)
ja	L_140
movq	(%rsp), %r9
movq	0x8(%rsp), %r10
movq	0x10(%rsp), %r11
jmp	L_5a
L_42e:
addq	$0x18, %rsp
popq	%rax
popq	%rax
popq	%rax
popq	%rax
movq	%r8, (%rax)
movq	%r9, 0x8(%rax)
movq	%r10, 0x10(%rax)
movq	%r11, 0x18(%rax)
movq	%rsi, 0x20(%rax)
movq	%rbx, 0x28(%rax)
movq	%rcx, 0x30(%rax)
movq	%rdi, 0x38(%rax)
movq	%rbp, 0x40(%rax)
movq	%rdx, 0x48(%rax)
movq	%r12, 0x50(%rax)
movq	%r13, 0x58(%rax)
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%r11
popq	%r10
popq	%r9
popq	%r8
popq	%rdi
popq	%rsi
popq	%rbp
popq	%rdx
popq	%rcx
popq	%rbx
popq	%rax
retq
HUF_decompress4X2_usingDTable_internal_fast_asm_loop:
_HUF_decompress4X2_usingDTable_internal_fast_asm_loop:
pushq	%rax
pushq	%rbx
pushq	%rcx
pushq	%rdx
pushq	%rbp
pushq	%rsi
pushq	%rdi
pushq	%r8
pushq	%r9
pushq	%r10
pushq	%r11
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
movq	%rdi, %rax
movq	(%rax), %r8
movq	0x8(%rax), %r9
movq	0x10(%rax), %r10
movq	0x18(%rax), %r11
movq	0x20(%rax), %rsi
movq	0x28(%rax), %rbx
movq	0x30(%rax), %rcx
movq	0x38(%rax), %rdi
movq	0x40(%rax), %rbp
movq	0x48(%rax), %rdx
movq	0x50(%rax), %r12
movq	0x58(%rax), %r13
movq	0x60(%rax), %r14
pushq	%rax
pushq	%rax
pushq	0x68(%rax)
movq	0x70(%rax), %rax
pushq	%rax
movq	%rdi, %rax
pushq	%rax
movq	%rcx, %rax
pushq	%rax
movq	%rbx, %rax
pushq	%rax
subq	$0x8, %rsp
L_4e4:
movq	%rdx, (%rsp)
movq	%r8, %rax
movq	0x28(%rsp), %rdx
subq	%rdx, %rax
movq	%rax, %r15
movabsq	$0x2492492492492493, %rdx
mulq	%rdx
subq	%rdx, %r15
shrq	%r15
addq	%r15, %rdx
shrq	$0x2, %rdx
movq	%rdx, %r15
movq	0x8(%rsp), %rax
subq	%rsi, %rax
movq	0x10(%rsp), %rdx
subq	%rbx, %rdx
cmpq	%rax, %rdx
cmovaq	%rax, %rdx
movq	0x18(%rsp), %rax
subq	%rcx, %rax
cmpq	%rax, %rdx
cmovaq	%rax, %rdx
movq	0x20(%rsp), %rax
subq	%rdi, %rax
cmpq	%rax, %rdx
cmovaq	%rax, %rdx
movabsq	$-0x3333333333333333, %rax
mulq	%rdx
shrq	$0x3, %rdx
cmpq	%rdx, %r15
cmovaq	%rdx, %r15
movq	%r15, %rax
leaq	(%rdi,%rax,4), %r15
addq	%rax, %r15
movq	(%rsp), %rdx
movq	%rdi, %rax
cmpq	%rax, %r15
je	L_920
cmpq	%r8, %r9
jb	L_920
cmpq	%r9, %r10
jb	L_920
cmpq	%r10, %r11
jb	L_920
movq	%r15, 0x30(%rsp)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopw	%cs:(%rax,%rax)
nopl	(%rax,%rax)
L_5c0:
movq	%r8, (%rsp)
movq	%rbp, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rsi)
shlxq	%r15, %rbp, %rbp
addq	%rax, %rsi
movq	%rdx, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rbx)
shlxq	%r15, %rdx, %rdx
addq	%rax, %rbx
movq	%r12, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rcx)
shlxq	%r15, %r12, %r12
addq	%rax, %rcx
movq	%r13, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rdi)
shlxq	%r15, %r13, %r13
addq	%rax, %rdi
movq	%rbp, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rsi)
shlxq	%r15, %rbp, %rbp
addq	%rax, %rsi
movq	%rdx, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rbx)
shlxq	%r15, %rdx, %rdx
addq	%rax, %rbx
movq	%r12, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rcx)
shlxq	%r15, %r12, %r12
addq	%rax, %rcx
movq	%r13, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rdi)
shlxq	%r15, %r13, %r13
addq	%rax, %rdi
movq	%rbp, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rsi)
shlxq	%r15, %rbp, %rbp
addq	%rax, %rsi
movq	%rdx, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rbx)
shlxq	%r15, %rdx, %rdx
addq	%rax, %rbx
movq	%r12, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rcx)
shlxq	%r15, %r12, %r12
addq	%rax, %rcx
movq	%r13, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rdi)
shlxq	%r15, %r13, %r13
addq	%rax, %rdi
movq	%rbp, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rsi)
shlxq	%r15, %rbp, %rbp
addq	%rax, %rsi
movq	%rdx, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rbx)
shlxq	%r15, %rdx, %rdx
addq	%rax, %rbx
movq	%r12, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rcx)
shlxq	%r15, %r12, %r12
addq	%rax, %rcx
movq	%r13, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rdi)
shlxq	%r15, %r13, %r13
addq	%rax, %rdi
movq	%rbp, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rsi)
shlxq	%r15, %rbp, %rbp
addq	%rax, %rsi
movq	%rdx, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rbx)
shlxq	%r15, %rdx, %rdx
addq	%rax, %rbx
movq	%r12, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rcx)
shlxq	%r15, %r12, %r12
addq	%rax, %rcx
movq	%r13, %rax
shrq	$0x35, %rax
movzwl	(%r14,%rax,4), %r8d
movzbl	0x2(%r14,%rax,4), %r15d
movzbl	0x3(%r14,%rax,4), %eax
movw	%r8w, (%rdi)
shlxq	%r15, %r13, %r13
addq	%rax, %rdi
movq	(%rsp), %r8
bsfq	%rbp, %rbp
movq	%rbp, %rax
shrq	$0x3, %rbp
andq	$0x7, %rax
subq	%rbp, %r8
movq	(%r8), %rbp
orq	$0x1, %rbp
shlxq	%rax, %rbp, %rbp
bsfq	%rdx, %rdx
movq	%rdx, %rax
shrq	$0x3, %rdx
andq	$0x7, %rax
subq	%rdx, %r9
movq	(%r9), %rdx
orq	$0x1, %rdx
shlxq	%rax, %rdx, %rdx
bsfq	%r12, %r12
movq	%r12, %rax
shrq	$0x3, %r12
andq	$0x7, %rax
subq	%r12, %r10
movq	(%r10), %r12
orq	$0x1, %r12
shlxq	%rax, %r12, %r12
bsfq	%r13, %r13
movq	%r13, %rax
shrq	$0x3, %r13
andq	$0x7, %rax
subq	%r13, %r11
movq	(%r11), %r13
orq	$0x1, %r13
shlxq	%rax, %r13, %r13
cmpq	%rdi, 0x30(%rsp)
ja	L_5c0
jmp	L_4e4
L_920:
addq	$0x8, %rsp
popq	%rax
popq	%rax
popq	%rax
popq	%rax
popq	%rax
popq	%rax
popq	%rax
movq	%r8, (%rax)
movq	%r9, 0x8(%rax)
movq	%r10, 0x10(%rax)
movq	%r11, 0x18(%rax)
movq	%rsi, 0x20(%rax)
movq	%rbx, 0x28(%rax)
movq	%rcx, 0x30(%rax)
movq	%rdi, 0x38(%rax)
movq	%rbp, 0x40(%rax)
movq	%rdx, 0x48(%rax)
movq	%r12, 0x50(%rax)
movq	%r13, 0x58(%rax)
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%r11
popq	%r10
popq	%r9
popq	%r8
popq	%rdi
popq	%rsi
popq	%rbp
popq	%rdx
popq	%rcx
popq	%rbx
popq	%rax
retq

	.text
build_huff_tree:
endbr64
pushq	%r12
movq	%rdx, %rax
build_huff_tree.main_loop:
movq	(%rdi,%rsi,8), %r9
movq	0x8(%rdi), %r8
movq	$-0x1, (%rdi,%rsi,8)
decq	%rsi
movq	%r9, 0x8(%rdi)
movl	$0x1, %r11d
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
..@5.heapify1:
leaq	(%r11,%r11), %rcx
cmpq	%rsi, %rcx
ja	..@5.end_heapify1
movq	(%rdi,%rcx,8), %r9
movq	0x8(%rdi,%rcx,8), %r10
movq	(%rdi,%r11,8), %r12
movq	%rcx, %rdx
addq	$0x1, %rdx
cmpq	%r9, %r10
cmovbq	%rdx, %rcx
cmovbq	%r10, %r9
cmpq	%r9, %r12
jbe	..@5.end_heapify1
movq	%r9, (%rdi,%r11,8)
movq	%r12, (%rdi,%rcx,8)
movq	%rcx, %r11
jmp	..@5.heapify1
..@5.end_heapify1:
movq	0x8(%rdi), %r9
leaq	(%r8,%r9), %r10
movw	%r8w, (%rdi,%rax,8)
movw	%r9w, -0x8(%rdi,%rax,8)
andq	$-0x10000, %r10
orq	%rax, %r10
subq	$0x2, %rax
movq	%r10, 0x8(%rdi)
movl	$0x1, %r11d
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
..@8.heapify1:
leaq	(%r11,%r11), %rcx
cmpq	%rsi, %rcx
ja	..@8.end_heapify1
movq	(%rdi,%rcx,8), %r9
movq	0x8(%rdi,%rcx,8), %r10
movq	(%rdi,%r11,8), %r12
movq	%rcx, %rdx
addq	$0x1, %rdx
cmpq	%r9, %r10
cmovbq	%rdx, %rcx
cmovbq	%r10, %r9
cmpq	%r9, %r12
jbe	..@8.end_heapify1
movq	%r9, (%rdi,%r11,8)
movq	%r12, (%rdi,%rcx,8)
movq	%rcx, %r11
jmp	..@8.heapify1
..@8.end_heapify1:
cmpq	$0x1, %rsi
ja	build_huff_tree.main_loop
movq	0x8(%rdi), %r8
movw	%r8w, (%rdi,%rax,8)
popq	%r12
retq
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
build_heap:
endbr64
pushq	%r12
movq	$-0x1, 0x8(%rdi,%rsi,8)
movq	%rsi, %r11
shrq	%r11
build_heap.loop:
movq	%r11, %r8
nop
nop
nop
nop
nop
nop
nop
nop
..@14.heapify1:
leaq	(%r8,%r8), %rcx
cmpq	%rsi, %rcx
ja	..@14.end_heapify1
movq	(%rdi,%rcx,8), %r9
movq	0x8(%rdi,%rcx,8), %r10
movq	(%rdi,%r8,8), %r12
movq	%rcx, %rdx
addq	$0x1, %rdx
cmpq	%r9, %r10
cmovbq	%rdx, %rcx
cmovbq	%r10, %r9
cmpq	%r9, %r12
jbe	..@14.end_heapify1
movq	%r9, (%rdi,%r8,8)
movq	%r12, (%rdi,%rcx,8)
movq	%rcx, %r8
jmp	..@14.heapify1
..@14.end_heapify1:
decq	%r11
jne	build_heap.loop
popq	%r12
retq

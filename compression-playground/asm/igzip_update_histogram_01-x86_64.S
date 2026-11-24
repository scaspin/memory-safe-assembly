	.text
isal_update_histogram_01:
endbr64
subq	$0x98, %rsp
movq	%rbx, 0x10(%rsp)
movq	%rbp, 0x18(%rsp)
movq	%r12, 0x20(%rsp)
movq	%r13, 0x28(%rsp)
movq	%r14, 0x30(%rsp)
movq	%r15, 0x38(%rsp)
movl	$0x0, %r10d
cmpq	$0x0, %rsi
je	exit_ret
movq	0x800(%rdx), %r11
incq	%r11
movq	%r11, (%rsp)
leaq	rfc1951_lookup_table(%rip), %r9
pxor	%xmm0, %xmm0
movl	$0x1ff0, %ecx
init_hash_table:
movdqu	%xmm0, 0x9e0(%rdx,%rcx,2)
movdqu	%xmm0, 0x9f0(%rdx,%rcx,2)
subq	$0x10, %rcx
jge	init_hash_table
subq	$0x118, %rsi
cmpq	$0x0, %rsi
jle	end_loop_2
movq	(%rdi,%r10), %rax
xorl	%r14d, %r14d
crc32l	%eax, %r14d
andl	$0x1fff, %r14d
movw	%r10w, 0x9e0(%rdx,%r14,2)
andq	$0xff, %rax
incq	(%rdx,%rax,8)
incq	%r10
movdqu	(%rdi,%r10), %xmm2
movq	(%rdi,%r10), %rax
movq	%rax, %r8
xorl	%r14d, %r14d
crc32l	%eax, %r14d
shrq	$0x8, %r8
xorl	%r15d, %r15d
crc32l	%r8d, %r15d
andl	$0x1fff, %r15d
andq	$0x1fff, %r14
loop2:
xorq	%rbx, %rbx
xorq	%r12, %r12
xorq	%r13, %r13
leaq	(%rdi,%r10), %r11
movq	%xmm2, %rax
psrldq	$0x1, %xmm2
movw	%r10w, %bx
subq	$0x1, %rbx
subw	0x9e0(%rdx,%r14,2), %bx
movw	%r10w, 0x9e0(%rdx,%r14,2)
addq	$0x1, %r10
movw	%r10w, %r12w
subq	$0x1, %r12
subw	0x9e0(%rdx,%r15,2), %r12w
movw	%r10w, 0x9e0(%rdx,%r15,2)
movq	%xmm2, %r8
movq	%xmm2, %rcx
shrq	$0x8, %r8
xorl	%r14d, %r14d
crc32l	%r8d, %r14d
andl	$0x7fff, %ebx
negq	%rbx
andl	$0x7fff, %r12d
negq	%r12
shrq	$0x10, %rcx
xorl	%r15d, %r15d
crc32l	%ecx, %r15d
movq	%rax, %rbp
xorq	-0x1(%r11,%rbx), %rbp
je	compare_loop
andl	$0x1fff, %r14d
andl	$0x1fff, %r15d
movq	%xmm2, %r8
xorq	(%r11,%r12), %r8
je	compare_loop2
movzbq	%al, %r11
shrq	$0x8, %rax
leaq	0x1(%r10), %r13
testl	$0xffffffff, %ebp
je	len_dist_huffman_pre
incq	(%rdx,%r11,8)
testl	$0xffffffff, %r8d
jne	lit_lit_huffman
len_dist_lit_huffman_pre:
tzcntq	%r8, %r8
shrq	$0x3, %r8
len_dist_lit_huffman:
movq	%xmm2, %rax
shrq	$0x18, %rax
xorl	%ebp, %ebp
crc32l	%eax, %ebp
movw	%r13w, 0x9e0(%rdx,%r14,2)
addq	$0x1, %r13
movw	%r13w, 0x9e0(%rdx,%r15,2)
addq	$0x1, %r13
addq	%r8, %r10
movdqu	(%rdi,%r10), %xmm2
movq	(%rdi,%r10), %rax
movq	%rax, %r11
xorl	%r14d, %r14d
crc32l	%eax, %r14d
andq	$0x1fff, %rbp
movw	%r13w, 0x9e0(%rdx,%rbp,2)
negl	%r12d
movl	%r12d, %ebx
bsrl	%ebx, %ecx
decl	%ecx
shrq	%cl, %rbx
leal	(%ebx,%ecx,2), %ebx
cmpl	$0x1, %r12d
cmovlel	%r12d, %ebx
movzbq	(%r9,%r8), %rbp
orq	$0x100, %rbp
shrq	$0x8, %r11
xorl	%r15d, %r15d
crc32l	%r11d, %r15d
incq	(%rdx,%rbp,8)
incq	0x8f0(%rdx,%rbx,8)
andl	$0x1fff, %r15d
andq	$0x1fff, %r14
cmpq	%rsi, %r10
jl	loop2
jmp	end_loop_2
len_dist_huffman_pre:
tzcntq	%rbp, %rbp
shrq	$0x3, %rbp
len_dist_huffman:
movw	%r13w, 0x9e0(%rdx,%r14,2)
addq	$0x1, %r13
movw	%r13w, 0x9e0(%rdx,%r15,2)
decq	%r10
addq	%rbp, %r10
movdqu	(%rdi,%r10), %xmm2
movq	(%rdi,%r10), %rax
movq	%rax, %r11
xorl	%r14d, %r14d
crc32l	%eax, %r14d
negl	%ebx
movl	%ebx, %r12d
bsrl	%r12d, %ecx
decl	%ecx
shrq	%cl, %r12
leal	(%r12d,%ecx,2), %r12d
cmpl	$0x1, %ebx
cmovlel	%ebx, %r12d
movzbq	(%r9,%rbp), %rbp
orq	$0x100, %rbp
shrq	$0x8, %r11
xorl	%r15d, %r15d
crc32l	%r11d, %r15d
incq	(%rdx,%rbp,8)
incq	0x8f0(%rdx,%r12,8)
andl	$0x1fff, %r15d
andq	$0x1fff, %r14
cmpq	%rsi, %r10
jl	loop2
jmp	end_loop_2
lit_lit_huffman:
movdqu	0x1(%rdi,%r10), %xmm2
andq	$0xff, %rax
addq	$0x1, %r10
incq	(%rdx,%rax,8)
cmpq	%rsi, %r10
jl	loop2
end_loop_2:
addq	$0x115, %rsi
cmpq	%rsi, %r10
jge	final_bytes
loop2_finish:
movl	(%rdi,%r10), %eax
xorl	%r14d, %r14d
crc32l	%eax, %r14d
andl	$0x1fff, %r14d
xorq	%rbx, %rbx
movw	%r10w, %bx
subw	0x9e0(%rdx,%r14,2), %bx
movw	%r10w, 0x9e0(%rdx,%r14,2)
decq	%rbx
cmpl	$0x7fff, %ebx
jae	encode_literal_finish
incq	%rbx
leaq	0x3(%rsi), %r8
subq	%r10, %r8
leaq	(%rdi,%r10), %r11
movq	%r11, %rcx
subq	%rbx, %rcx
xorq	%rbp, %rbp
subq	$0x7, %r8
jle	..@116.lab2
..@116.loop1:
movq	(%r11,%rbp), %r13
xorq	(%rcx,%rbp), %r13
jne	..@116.miscompare
addq	$0x8, %rbp
subq	$0x8, %r8
jg	..@116.loop1
..@116.lab2:
addq	$0x7, %r8
jle	..@116.end
..@116.loop3:
movb	(%r11,%rbp), %r13b
cmpb	(%rcx,%rbp), %r13b
jne	..@116.end
incq	%rbp
decq	%r8
jg	..@116.loop3
jmp	..@116.end
..@116.miscompare:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rbp
..@116.end:
movl	$0x102, %ecx
cmpq	$0x102, %rbp
cmovaq	%rcx, %rbp
cmpq	$0x4, %rbp
jb	encode_literal_finish
addq	%rbp, %r10
movzbq	(%r9,%rbp), %rbp
orq	$0x100, %rbp
decl	%ebx
movl	%ebx, %r12d
bsrl	%r12d, %ecx
decl	%ecx
shrq	%cl, %r12
leal	(%r12d,%ecx,2), %r12d
cmpl	$0x1, %ebx
cmovlel	%ebx, %r12d
incq	(%rdx,%rbp,8)
incq	0x8f0(%rdx,%r12,8)
cmpq	%rsi, %r10
jl	loop2_finish
jmp	final_bytes
encode_literal_finish:
andl	$0xff, %eax
incq	(%rdx,%rax,8)
addq	$0x1, %r10
cmpq	%rsi, %r10
jl	loop2_finish
final_bytes:
addq	$0x3, %rsi
final_bytes_loop:
cmpq	%rsi, %r10
jge	end
movzbq	(%rdi,%r10), %rax
incq	(%rdx,%rax,8)
incq	%r10
jmp	final_bytes_loop
end:
movq	(%rsp), %r11
movq	%r11, 0x800(%rdx)
exit_ret:
movq	0x10(%rsp), %rbx
movq	0x18(%rsp), %rbp
movq	0x20(%rsp), %r12
movq	0x28(%rsp), %r13
movq	0x30(%rsp), %r14
movq	0x38(%rsp), %r15
addq	$0x98, %rsp
retq
compare_loop:
andl	$0x1fff, %r14d
andl	$0x1fff, %r15d
leaq	-0x1(%r11,%rbx), %rcx
movl	$0xfa, %r8d
movl	$0x8, %ebp
movl	$0xfa, %r13d
cmpq	$0xfa, %r8
cmovgq	%r13, %r8
subq	$0x20, %r8
cmpq	%r8, %rbp
jg	..@124._by_16
..@124.loop1:
movdqu	(%r11,%rbp), %xmm0
movdqu	(%rcx,%rbp), %xmm1
pcmpeqb	%xmm1, %xmm0
pmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@124.miscompare_vect
addq	$0x10, %rbp
movdqu	(%r11,%rbp), %xmm0
movdqu	(%rcx,%rbp), %xmm1
pcmpeqb	%xmm1, %xmm0
pmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@124.miscompare_vect
addq	$0x10, %rbp
cmpq	%r8, %rbp
jle	..@124.loop1
..@124._by_16:
addq	$0x10, %r8
cmpq	%r8, %rbp
jg	..@124._by_8
movdqu	(%r11,%rbp), %xmm0
movdqu	(%rcx,%rbp), %xmm1
pcmpeqb	%xmm1, %xmm0
pmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@124.miscompare_vect
addq	$0x10, %rbp
..@124._by_8:
addq	$0x8, %r8
cmpq	%r8, %rbp
jg	..@124._cmp_last
movq	(%r11,%rbp), %r13
xorq	(%rcx,%rbp), %r13
jne	..@124.miscompare_reg
addq	$0x8, %rbp
..@124._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rbp
je	..@124.end
leaq	-0x8(%r8), %rbp
movq	(%r11,%rbp), %r13
xorq	(%rcx,%rbp), %r13
jne	..@124.miscompare_reg
addq	$0x8, %rbp
jmp	..@124.end
..@124.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rbp
jmp	..@124.end
..@124.miscompare_vect:
bsfq	%r13, %r13
addq	%r13, %rbp
..@124.end:
leaq	0x1(%r10), %r13
jmp	len_dist_huffman
compare_loop2:
addq	$0x1, %r11
leaq	-0x1(%r11,%r12), %rcx
movl	$0xfa, %ebp
movl	$0x8, %r8d
movl	$0xfa, %r13d
cmpq	$0xfa, %rbp
cmovgq	%r13, %rbp
subq	$0x20, %rbp
cmpq	%rbp, %r8
jg	..@141._by_16
..@141.loop1:
movdqu	(%r11,%r8), %xmm0
movdqu	(%rcx,%r8), %xmm1
pcmpeqb	%xmm1, %xmm0
pmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@141.miscompare_vect
addq	$0x10, %r8
movdqu	(%r11,%r8), %xmm0
movdqu	(%rcx,%r8), %xmm1
pcmpeqb	%xmm1, %xmm0
pmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@141.miscompare_vect
addq	$0x10, %r8
cmpq	%rbp, %r8
jle	..@141.loop1
..@141._by_16:
addq	$0x10, %rbp
cmpq	%rbp, %r8
jg	..@141._by_8
movdqu	(%r11,%r8), %xmm0
movdqu	(%rcx,%r8), %xmm1
pcmpeqb	%xmm1, %xmm0
pmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@141.miscompare_vect
addq	$0x10, %r8
..@141._by_8:
addq	$0x8, %rbp
cmpq	%rbp, %r8
jg	..@141._cmp_last
movq	(%r11,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@141.miscompare_reg
addq	$0x8, %r8
..@141._cmp_last:
addq	$0x8, %rbp
cmpq	%rbp, %r8
je	..@141.end
leaq	-0x8(%rbp), %r8
movq	(%r11,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@141.miscompare_reg
addq	$0x8, %r8
jmp	..@141.end
..@141.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
jmp	..@141.end
..@141.miscompare_vect:
bsfq	%r13, %r13
addq	%r13, %r8
..@141.end:
andq	$0xff, %rax
incq	(%rdx,%rax,8)
leaq	0x1(%r10), %r13
jmp	len_dist_lit_huffman
	.section .data
	.p2align 3
D_vector:
	.byte 255,127,255,127,255,127,255,127,255,127,255,127,255,127,255,127
	.byte 255,127,255,127,255,127,255,127,255,127,255,127,255,127,255,127
# ---- rfc1951_lookup.S, for rfc1951_lookup_table
	.text
	.text
	.section .data
	.p2align 3
len_to_code:
rfc1951_lookup_table:
	.byte 0,0,0,1,2,3,4,5,6,7,8,9,9,10,10,11
	.byte 11,12,12,13,13,13,13,14,14,14,14,15,15,15,15,16
	.byte 16,16,16,17,17,17,17,17,17,17,17,18,18,18,18,18
	.byte 18,18,18,19,19,19,19,19,19,19,19,20,20,20,20,20
	.byte 20,20,20,21,21,21,21,21,21,21,21,21,21,21,21,21
	.byte 21,21,21,22,22,22,22,22,22,22,22,22,22,22,22,22
	.byte 22,22,22,23,23,23,23,23,23,23,23,23,23,23,23,23
	.byte 23,23,23,24,24,24,24,24,24,24,24,24,24,24,24,24
	.byte 24,24,24,25,25,25,25,25,25,25,25,25,25,25,25,25
	.byte 25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25
	.byte 25,25,25,26,26,26,26,26,26,26,26,26,26,26,26,26
	.byte 26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
	.byte 26,26,26,27,27,27,27,27,27,27,27,27,27,27,27,27
	.byte 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
	.byte 27,27,27,28,28,28,28,28,28,28,28,28,28,28,28,28
	.byte 28,28,28,28,28,28,28,28,28,28,28,28,28,28,28,28
	.byte 28,28,29,0,0,0,0,0
dist_extra_bit_count:
	.byte 0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6
	.byte 7,7,8,8,9,9,10,10,11,11,12,12,13,13,0,0
dist_start:
	.byte 1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0
	.byte 5,0,0,0,7,0,0,0,9,0,0,0,13,0,0,0
	.byte 17,0,0,0,25,0,0,0,33,0,0,0,49,0,0,0
	.byte 65,0,0,0,97,0,0,0,129,0,0,0,193,0,0,0
	.byte 1,1,0,0,129,1,0,0,1,2,0,0,1,3,0,0
	.byte 1,4,0,0,1,6,0,0,1,8,0,0,1,12,0,0
	.byte 1,16,0,0,1,24,0,0,1,32,0,0,1,48,0,0
	.byte 1,64,0,0,1,96,0,0,0,0,0,0,0,0,0,0
len_extra_bit_count:
	.byte 0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2
	.byte 3,3,3,3,4,4,4,4,5,5,5,5,0,0,0,0
len_start:
	.byte 3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0
	.byte 11,0,13,0,15,0,17,0,19,0,23,0,27,0,31,0
	.byte 35,0,43,0,51,0,59,0,67,0,83,0,99,0,115,0
	.byte 131,0,163,0,195,0,227,0,2,1,0,0,0,0,0,0

	.text
isal_deflate_body_01:
endbr64
movq	%rdi, %rcx
cmpl	$0x0, 0x8(%rcx)
jne	isal_deflate_body_01.skip1
movl	$0x4, %edx
movl	$0x3, %eax
cmpw	$0x0, 0x38(%rcx)
cmovneq	%rdx, %rax
cmpw	$0x0, 0x3a(%rcx)
cmovneq	%rdx, %rax
movl	%eax, 0x54(%rcx)
retq
isal_deflate_body_01.skip1:
subq	$0xa8, %rsp
movq	%rbx, 0x20(%rsp)
movq	%rsi, 0x28(%rsp)
movq	%rdi, 0x30(%rsp)
movq	%rbp, 0x38(%rsp)
movq	%r12, 0x40(%rsp)
movq	%r13, 0x48(%rsp)
movq	%r14, 0x50(%rsp)
movq	%r15, 0x58(%rsp)
movq	%rcx, %r14
movb	$0x0, 0x86(%r14)
movd	0x50(%r14), %xmm3
pshufd	$0x0, %xmm3, %xmm3
movq	0x10(%r14), %r11
movq	%r11, 0x78(%r14)
movl	0x18(%r14), %esi
addq	%r11, %rsi
subq	$0x8, %rsi
movq	%rsi, 0x70(%r14)
movq	0x58(%r14), %r9
movl	0x60(%r14), %ebp
movq	0x20(%r14), %r15
movq	(%r14), %rdi
movl	0xc(%r14), %r10d
subq	%r10, %rdi
movl	0x8(%r14), %r8d
addq	%r10, %r8
movq	$0x10, 0x10(%rsp)
cmpb	$0x0, 0x38(%r14)
jne	isal_deflate_body_01.default_inbuf_padding
cmpb	$0x0, 0x3a(%r14)
jne	isal_deflate_body_01.default_inbuf_padding
movq	$0x120, 0x10(%rsp)
isal_deflate_body_01.default_inbuf_padding:
subq	0x10(%rsp), %r8
movq	%r8, 0x8(%rsp)
cmpq	%r10, %r8
jle	isal_deflate_body_01.input_end
movd	%xmm3, %ebx
movdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %r13
movq	%rax, %r8
xorl	%edx, %edx
crc32l	%eax, %edx
shrq	$0x8, %r13
xorl	%ecx, %ecx
crc32l	%r13d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
cmpb	$0x0, 0x87(%r14)
je	isal_deflate_body_01.write_first_byte
jmp	isal_deflate_body_01.loop2
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
isal_deflate_body_01.loop2:
movl	0x4c(%r14), %r13d
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_01.output_end
xorq	%rbx, %rbx
xorq	%r12, %r12
leaq	(%rdi,%r10), %rsi
movw	%r10w, %bx
decq	%rbx
subw	0x101d0(%r14,%rdx,2), %bx
movw	%r10w, 0x101d0(%r14,%rdx,2)
incq	%r10
movq	%xmm4, %r8
shrq	$0x10, %rax
movq	%rax, %rdx
xorl	%r8d, %r8d
crc32l	%eax, %r8d
movw	%r10w, %r12w
decq	%r12
subw	0x101d0(%r14,%rcx,2), %r12w
movw	%r10w, 0x101d0(%r14,%rcx,2)
andq	%r13, %rbx
negq	%rbx
shrq	$0x8, %rdx
xorl	%ecx, %ecx
crc32l	%edx, %ecx
andq	%r13, %r12
negq	%r12
movq	%xmm4, %rdx
movq	%rdx, %rax
psrldq	$0x1, %xmm4
xorq	-0x1(%rsi,%rbx), %rdx
je	isal_deflate_body_01.compare_loop
movd	%r8d, %xmm2
pinsrd	$0x1, %ecx, %xmm2
pand	%xmm3, %xmm2
movq	%xmm4, %r8
xorq	(%rsi,%r12), %r8
je	isal_deflate_body_01.compare_loop2
movzbq	%al, %rsi
movzbl	0x75a(%r15,%rsi), %ecx
movzwl	0x558(%r15,%rsi,2), %r13d
testl	$0xffffffff, %edx
je	isal_deflate_body_01.len_dist_huffman_pre
shrq	$0x8, %rax
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %esi
movzwl	0x558(%r15,%rax,2), %ebx
shlq	%cl, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
testl	$0xffffffff, %r8d
jne	isal_deflate_body_01.write_lit_bits
isal_deflate_body_01.len_dist_lit_huffman_pre:
movq	%rcx, %rdx
bsfq	%r8, %r8
shrq	$0x3, %r8
isal_deflate_body_01.len_dist_lit_huffman:
negq	%r12
movq	%r12, %rbx
cmpq	$0x1, %rbx
jg	..@102.do_compute
movl	0x150(%r15,%rbx,4), %esi
movq	%rsi, %r12
andq	$0x1f, %rsi
shrq	$0x5, %r12
jmp	..@102.done
..@102.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%rbx, %r12
andq	%rsi, %r12
shrq	%cl, %rbx
leaq	(%rbx,%rcx,2), %rbx
movq	%rcx, %rsi
movzbq	0x898(%r15,%rbx), %rcx
movzwq	0x85c(%r15,%rbx,2), %rbx
shlq	%cl, %r12
orq	%rbx, %r12
addq	%rcx, %rsi
..@102.done:
movl	0x14c(%r15,%r8,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movd	%xmm3, %ebx
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
addq	%r8, %r10
negq	%r8
movq	%rdx, %rcx
shlq	%cl, %r12
movq	%xmm4, %rax
shrq	$0x18, %rax
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebx, %ecx
orq	%r13, %r12
addq	%rdx, %rsi
leaq	0x1(%r10,%r8), %r13
movq	0x8(%rsp), %r8
cmpq	%r8, %r10
jge	isal_deflate_body_01.len_dist_lit_huffman_finish
movdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movd	%xmm2, %edx
pextrd	$0x1, %xmm2, %r8d
movw	%r13w, 0x101d0(%r14,%rdx,2)
xorl	%edx, %edx
crc32l	%eax, %edx
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_01.loop2
isal_deflate_body_01.len_dist_lit_huffman_finish:
movd	%xmm2, %edx
pextrd	$0x1, %xmm2, %r8d
movw	%r13w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
jmp	isal_deflate_body_01.input_end
nop
isal_deflate_body_01.len_dist_huffman_pre:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
isal_deflate_body_01.len_dist_huffman:
decq	%r10
negq	%rbx
movq	%rbx, %r13
cmpq	$0x1, %r13
jg	..@146.do_compute
movl	0x150(%r15,%r13,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@146.done
..@146.do_compute:
bsrq	%r13, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r13, %rbx
andq	%rsi, %rbx
shrq	%cl, %r13
leaq	(%r13,%rcx,2), %r13
movq	%rcx, %rsi
movzbq	0x898(%r13,%r15), %rcx
movzwq	0x85c(%r15,%r13,2), %r13
shlq	%cl, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
..@146.done:
movl	0x14c(%r15,%rdx,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
leaq	0x2(%r10), %r13
addq	%rdx, %r10
movd	%xmm2, %edx
pextrd	$0x1, %xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
movd	%xmm3, %ebx
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_01.len_dist_huffman_finish
movdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
xorl	%edx, %edx
crc32l	%eax, %edx
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_01.loop2
isal_deflate_body_01.len_dist_huffman_finish:
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
jmp	isal_deflate_body_01.input_end
nop
nop
nop
nop
isal_deflate_body_01.write_lit_bits:
psrldq	$0x1, %xmm4
addq	$0x1, %r10
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_01.write_lit_bits_finish
movq	%xmm4, %rax
movdqu	(%rdi,%r10), %xmm4
movd	%xmm2, %edx
movq	%rbp, %rcx
shlq	%cl, %rbx
orq	%rbx, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
pextrd	$0x1, %xmm2, %ecx
jmp	isal_deflate_body_01.loop2
isal_deflate_body_01.write_lit_bits_finish:
movq	%rbp, %rcx
shlq	%cl, %rbx
orq	%rbx, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
isal_deflate_body_01.input_end:
movl	$0x4, %esi
movl	$0x3, %eax
cmpw	$0x0, 0x38(%r14)
cmovneq	%rsi, %rax
cmpw	$0x0, 0x3a(%r14)
cmovneq	%rsi, %rax
movl	%eax, 0x54(%r14)
isal_deflate_body_01.output_end:
movq	0x8(%rsp), %r8
addq	0x10(%rsp), %r8
movl	%r10d, 0xc(%r14)
addq	%r10, %rdi
movq	%rdi, (%r14)
subq	%r10, %r8
movl	%r8d, 0x8(%r14)
movq	%r11, 0x10(%r14)
subq	0x78(%r14), %r11
subl	%r11d, 0x18(%r14)
addl	%r11d, 0x1c(%r14)
movq	%r9, 0x58(%r14)
movl	%ebp, 0x60(%r14)
movq	0x20(%rsp), %rbx
movq	0x28(%rsp), %rsi
movq	0x30(%rsp), %rdi
movq	0x38(%rsp), %rbp
movq	0x40(%rsp), %r12
movq	0x48(%rsp), %r13
movq	0x50(%rsp), %r14
movq	0x58(%rsp), %r15
addq	$0xa8, %rsp
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
isal_deflate_body_01.compare_loop:
movd	%r8d, %xmm2
pinsrd	$0x1, %ecx, %xmm2
pand	%xmm3, %xmm2
leaq	-0x1(%rsi,%rbx), %rcx
movq	0x8(%rsp), %r8
subq	%r10, %r8
addq	0x10(%rsp), %r8
addq	$0x1, %r8
movl	$0x1020, %r13d
cmpq	%r13, %r8
cmovgq	%r13, %r8
movl	$0x8, %edx
subq	$0x10, %r8
cmpq	%r8, %rdx
jg	..@209._by_8
..@209.loop1:
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@209.miscompare_reg
addq	$0x8, %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@209.miscompare_reg
addq	$0x8, %rdx
cmpq	%r8, %rdx
jle	..@209.loop1
..@209._by_8:
addq	$0x8, %r8
cmpq	%r8, %rdx
jg	..@209._cmp_last
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@209.miscompare_reg
addq	$0x8, %rdx
..@209._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rdx
je	..@209.end
leaq	-0x8(%r8), %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@209.miscompare_reg
addq	$0x8, %rdx
jmp	..@209.end
..@209.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rdx
..@209.end:
cmpq	$0x102, %rdx
jle	isal_deflate_body_01.len_dist_huffman
cmpq	$0x108, %rdx
jge	isal_deflate_body_01.do_emit
movl	$0x102, %edx
jmp	isal_deflate_body_01.len_dist_huffman
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
isal_deflate_body_01.compare_loop2:
leaq	(%rsi,%r12), %rcx
addq	$0x1, %rsi
movq	0x8(%rsp), %rdx
subq	%r10, %rdx
addq	0x10(%rsp), %rdx
movl	$0x1020, %r13d
cmpq	%r13, %rdx
cmovgq	%r13, %rdx
movl	$0x8, %r8d
subq	$0x10, %rdx
cmpq	%rdx, %r8
jg	..@213._by_8
..@213.loop1:
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@213.miscompare_reg
addq	$0x8, %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@213.miscompare_reg
addq	$0x8, %r8
cmpq	%rdx, %r8
jle	..@213.loop1
..@213._by_8:
addq	$0x8, %rdx
cmpq	%rdx, %r8
jg	..@213._cmp_last
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@213.miscompare_reg
addq	$0x8, %r8
..@213._cmp_last:
addq	$0x8, %rdx
cmpq	%rdx, %r8
je	..@213.end
leaq	-0x8(%rdx), %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@213.miscompare_reg
addq	$0x8, %r8
jmp	..@213.end
..@213.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
..@213.end:
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %edx
movzwl	0x558(%r15,%rax,2), %r13d
cmpq	$0x102, %r8
jle	isal_deflate_body_01.len_dist_lit_huffman
cmpq	$0x108, %r8
jge	isal_deflate_body_01.do_emit2
movl	$0x102, %r8d
jmp	isal_deflate_body_01.len_dist_lit_huffman
nop
nop
nop
nop
nop
nop
isal_deflate_body_01.do_emit2:
negq	%r12
cmpq	$0x1, %r12
jg	..@217.do_compute
movl	0x150(%r15,%r12,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@217.done
..@217.do_compute:
bsrq	%r12, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r12, %rbx
andq	%rsi, %rbx
shrq	%cl, %r12
leaq	(%r12,%rcx,2), %r12
movq	%rcx, %rsi
movzbq	0x898(%r12,%r15), %rcx
movzwq	0x85c(%r15,%r12,2), %r12
shlq	%cl, %rbx
orq	%r12, %rbx
addq	%rcx, %rsi
..@217.done:
movl	0x554(%r15), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
movq	%rcx, %rax
movq	%rdx, %rcx
movq	%r12, %rdx
shlq	%cl, %rdx
orq	%rdx, %r13
addq	%rsi, %rcx
movq	%rcx, %rdx
movq	%rbp, %rcx
shlq	%cl, %r13
orq	%r13, %r9
addq	%rdx, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
leaq	0x2(%r10), %r13
movd	%xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rcx,2)
addq	$0x1, %r13
pextrd	$0x1, %xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rcx,2)
addq	$0x102, %r10
leaq	-0x102(%r8), %rdx
jmp	isal_deflate_body_01.emit_loop
isal_deflate_body_01.do_emit:
decq	%r10
negq	%rbx
movq	%rbx, %r13
cmpq	$0x1, %r13
jg	..@244.do_compute
movl	0x150(%r15,%r13,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@244.done
..@244.do_compute:
bsrq	%r13, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r13, %rbx
andq	%rsi, %rbx
shrq	%cl, %r13
leaq	(%r13,%rcx,2), %r13
movq	%rcx, %rsi
movzbq	0x898(%r13,%r15), %rcx
movzwq	0x85c(%r15,%r13,2), %r13
shlq	%cl, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
..@244.done:
movl	0x554(%r15), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
leaq	0x2(%r10), %r13
movd	%xmm2, %r8d
pextrd	$0x1, %xmm2, %eax
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rax,2)
movq	%rcx, %rax
isal_deflate_body_01.emit:
addq	$0x102, %r10
subq	$0x102, %rdx
movq	%r12, %r13
movq	%rbp, %rcx
shlq	%cl, %r13
orq	%r13, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
isal_deflate_body_01.emit_loop:
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_01.output_end
cmpq	$0x108, %rdx
jge	isal_deflate_body_01.emit
movl	$0x102, %r8d
cmpq	%r8, %rdx
cmovgq	%r8, %rdx
addq	%rdx, %r10
subq	%rax, %rsi
movl	0x14c(%r15,%rdx,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_01.input_end
leaq	-0x4(%r10), %r12
movd	%xmm3, %ebx
movl	(%rdi,%r12), %eax
movl	0x1(%rdi,%r12), %r8d
xorl	%edx, %edx
crc32l	%eax, %edx
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
movw	%r12w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r12
movw	%r12w, 0x101d0(%r14,%rcx,2)
addq	$0x1, %r12
movl	(%rdi,%r12), %eax
movl	0x1(%rdi,%r12), %r8d
xorl	%edx, %edx
crc32l	%eax, %edx
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
movw	%r12w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r12
movw	%r12w, 0x101d0(%r14,%rcx,2)
movdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
xorl	%edx, %edx
crc32l	%eax, %edx
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_01.loop2
isal_deflate_body_01.write_first_byte:
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_01.output_end
movb	$0x1, 0x87(%r14)
movw	%r10w, 0x101d0(%r14,%rdx,2)
movq	%rcx, %rdx
shrq	$0x10, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
movd	%edx, %xmm2
pinsrd	$0x1, %ecx, %xmm2
pand	%xmm3, %xmm2
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %esi
movzwl	0x558(%r15,%rax,2), %ebx
jmp	isal_deflate_body_01.write_lit_bits
isal_deflate_body_02:
endbr64
movq	%rdi, %rcx
cmpl	$0x0, 0x8(%rcx)
jne	isal_deflate_body_02.skip1
movl	$0x4, %edx
movl	$0x3, %eax
cmpw	$0x0, 0x38(%rcx)
cmovneq	%rdx, %rax
cmpw	$0x0, 0x3a(%rcx)
cmovneq	%rdx, %rax
movl	%eax, 0x54(%rcx)
retq
isal_deflate_body_02.skip1:
subq	$0xa8, %rsp
movq	%rbx, 0x20(%rsp)
movq	%rsi, 0x28(%rsp)
movq	%rdi, 0x30(%rsp)
movq	%rbp, 0x38(%rsp)
movq	%r12, 0x40(%rsp)
movq	%r13, 0x48(%rsp)
movq	%r14, 0x50(%rsp)
movq	%r15, 0x58(%rsp)
movq	%rcx, %r14
movb	$0x0, 0x86(%r14)
vmovd	0x50(%r14), %xmm3
vpshufd	$0x0, %xmm3, %xmm3
movq	0x10(%r14), %r11
movq	%r11, 0x78(%r14)
movl	0x18(%r14), %esi
addq	%r11, %rsi
subq	$0x8, %rsi
movq	%rsi, 0x70(%r14)
movq	0x58(%r14), %r9
movl	0x60(%r14), %ebp
movq	0x20(%r14), %r15
movq	(%r14), %rdi
movl	0xc(%r14), %r10d
subq	%r10, %rdi
movl	0x8(%r14), %r8d
addq	%r10, %r8
movq	$0x10, 0x10(%rsp)
cmpb	$0x0, 0x38(%r14)
jne	isal_deflate_body_02.default_inbuf_padding
cmpb	$0x0, 0x3a(%r14)
jne	isal_deflate_body_02.default_inbuf_padding
movq	$0x120, 0x10(%rsp)
isal_deflate_body_02.default_inbuf_padding:
subq	0x10(%rsp), %r8
movq	%r8, 0x8(%rsp)
cmpq	%r10, %r8
jle	isal_deflate_body_02.input_end
vmovd	%xmm3, %ebx
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %r13
movq	%rax, %r8
xorl	%edx, %edx
crc32l	%eax, %edx
shrq	$0x8, %r13
xorl	%ecx, %ecx
crc32l	%r13d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
cmpb	$0x0, 0x87(%r14)
je	isal_deflate_body_02.write_first_byte
jmp	isal_deflate_body_02.loop2
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
isal_deflate_body_02.loop2:
movl	0x4c(%r14), %r13d
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_02.output_end
xorq	%rbx, %rbx
xorq	%r12, %r12
leaq	(%rdi,%r10), %rsi
movw	%r10w, %bx
decq	%rbx
subw	0x101d0(%r14,%rdx,2), %bx
movw	%r10w, 0x101d0(%r14,%rdx,2)
incq	%r10
vmovq	%xmm4, %r8
shrq	$0x10, %rax
movq	%rax, %rdx
xorl	%r8d, %r8d
crc32l	%eax, %r8d
movw	%r10w, %r12w
decq	%r12
subw	0x101d0(%r14,%rcx,2), %r12w
movw	%r10w, 0x101d0(%r14,%rcx,2)
andq	%r13, %rbx
negq	%rbx
shrq	$0x8, %rdx
xorl	%ecx, %ecx
crc32l	%edx, %ecx
andq	%r13, %r12
negq	%r12
vmovq	%xmm4, %rdx
movq	%rdx, %rax
vpsrldq	$0x1, %xmm4, %xmm4
xorq	-0x1(%rsi,%rbx), %rdx
je	isal_deflate_body_02.compare_loop
vmovd	%r8d, %xmm2
vpinsrd	$0x1, %ecx, %xmm2, %xmm2
vpand	%xmm3, %xmm2, %xmm2
vmovq	%xmm4, %r8
xorq	(%rsi,%r12), %r8
je	isal_deflate_body_02.compare_loop2
movzbq	%al, %rsi
movzbl	0x75a(%r15,%rsi), %ecx
movzwl	0x558(%r15,%rsi,2), %r13d
testl	$0xffffffff, %edx
je	isal_deflate_body_02.len_dist_huffman_pre
shrq	$0x8, %rax
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %esi
movzwl	0x558(%r15,%rax,2), %ebx
shlq	%cl, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
testl	$0xffffffff, %r8d
jne	isal_deflate_body_02.write_lit_bits
isal_deflate_body_02.len_dist_lit_huffman_pre:
movq	%rcx, %rdx
bsfq	%r8, %r8
shrq	$0x3, %r8
isal_deflate_body_02.len_dist_lit_huffman:
negq	%r12
movq	%r12, %rbx
cmpq	$0x1, %rbx
jg	..@318.do_compute
movl	0x150(%r15,%rbx,4), %esi
movq	%rsi, %r12
andq	$0x1f, %rsi
shrq	$0x5, %r12
jmp	..@318.done
..@318.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%rbx, %r12
andq	%rsi, %r12
shrq	%cl, %rbx
leaq	(%rbx,%rcx,2), %rbx
movq	%rcx, %rsi
movzbq	0x898(%r15,%rbx), %rcx
movzwq	0x85c(%r15,%rbx,2), %rbx
shlq	%cl, %r12
orq	%rbx, %r12
addq	%rcx, %rsi
..@318.done:
movl	0x14c(%r15,%r8,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
vmovd	%xmm3, %ebx
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
addq	%r8, %r10
negq	%r8
movq	%rdx, %rcx
shlq	%cl, %r12
vmovq	%xmm4, %rax
shrq	$0x18, %rax
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebx, %ecx
orq	%r13, %r12
addq	%rdx, %rsi
leaq	0x1(%r10,%r8), %r13
movq	0x8(%rsp), %r8
cmpq	%r8, %r10
jge	isal_deflate_body_02.len_dist_lit_huffman_finish
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
vmovd	%xmm2, %edx
vpextrd	$0x1, %xmm2, %r8d
movw	%r13w, 0x101d0(%r14,%rdx,2)
xorl	%edx, %edx
crc32l	%eax, %edx
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_02.loop2
isal_deflate_body_02.len_dist_lit_huffman_finish:
vmovd	%xmm2, %edx
vpextrd	$0x1, %xmm2, %r8d
movw	%r13w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
jmp	isal_deflate_body_02.input_end
nop
nop
nop
isal_deflate_body_02.len_dist_huffman_pre:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
isal_deflate_body_02.len_dist_huffman:
decq	%r10
negq	%rbx
movq	%rbx, %r13
cmpq	$0x1, %r13
jg	..@362.do_compute
movl	0x150(%r15,%r13,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@362.done
..@362.do_compute:
bsrq	%r13, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r13, %rbx
andq	%rsi, %rbx
shrq	%cl, %r13
leaq	(%r13,%rcx,2), %r13
movq	%rcx, %rsi
movzbq	0x898(%r13,%r15), %rcx
movzwq	0x85c(%r15,%r13,2), %r13
shlq	%cl, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
..@362.done:
movl	0x14c(%r15,%rdx,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
leaq	0x2(%r10), %r13
addq	%rdx, %r10
vmovd	%xmm2, %edx
vpextrd	$0x1, %xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
vmovd	%xmm3, %ebx
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_02.len_dist_huffman_finish
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
xorl	%edx, %edx
crc32l	%eax, %edx
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_02.loop2
isal_deflate_body_02.len_dist_huffman_finish:
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
jmp	isal_deflate_body_02.input_end
nop
nop
nop
nop
isal_deflate_body_02.write_lit_bits:
vpsrldq	$0x1, %xmm4, %xmm4
addq	$0x1, %r10
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_02.write_lit_bits_finish
vmovq	%xmm4, %rax
vmovdqu	(%rdi,%r10), %xmm4
vmovd	%xmm2, %edx
movq	%rbp, %rcx
shlq	%cl, %rbx
orq	%rbx, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
vpextrd	$0x1, %xmm2, %ecx
jmp	isal_deflate_body_02.loop2
isal_deflate_body_02.write_lit_bits_finish:
movq	%rbp, %rcx
shlq	%cl, %rbx
orq	%rbx, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
isal_deflate_body_02.input_end:
movl	$0x4, %esi
movl	$0x3, %eax
cmpw	$0x0, 0x38(%r14)
cmovneq	%rsi, %rax
cmpw	$0x0, 0x3a(%r14)
cmovneq	%rsi, %rax
movl	%eax, 0x54(%r14)
isal_deflate_body_02.output_end:
movq	0x8(%rsp), %r8
addq	0x10(%rsp), %r8
movl	%r10d, 0xc(%r14)
addq	%r10, %rdi
movq	%rdi, (%r14)
subq	%r10, %r8
movl	%r8d, 0x8(%r14)
movq	%r11, 0x10(%r14)
subq	0x78(%r14), %r11
subl	%r11d, 0x18(%r14)
addl	%r11d, 0x1c(%r14)
movq	%r9, 0x58(%r14)
movl	%ebp, 0x60(%r14)
movq	0x20(%rsp), %rbx
movq	0x28(%rsp), %rsi
movq	0x30(%rsp), %rdi
movq	0x38(%rsp), %rbp
movq	0x40(%rsp), %r12
movq	0x48(%rsp), %r13
movq	0x50(%rsp), %r14
movq	0x58(%rsp), %r15
addq	$0xa8, %rsp
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
isal_deflate_body_02.compare_loop:
vmovd	%r8d, %xmm2
vpinsrd	$0x1, %ecx, %xmm2, %xmm2
vpand	%xmm3, %xmm2, %xmm2
leaq	-0x1(%rsi,%rbx), %rcx
movq	0x8(%rsp), %r8
subq	%r10, %r8
addq	0x10(%rsp), %r8
addq	$0x1, %r8
movl	$0x1020, %r13d
cmpq	%r13, %r8
cmovgq	%r13, %r8
movl	$0x8, %edx
subq	$0x20, %r8
cmpq	%r8, %rdx
jg	..@424._by_16
..@424.loop1:
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@424.miscompare_vect
addq	$0x10, %rdx
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@424.miscompare_vect
addq	$0x10, %rdx
cmpq	%r8, %rdx
jle	..@424.loop1
..@424._by_16:
addq	$0x10, %r8
cmpq	%r8, %rdx
jg	..@424._by_8
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@424.miscompare_vect
addq	$0x10, %rdx
..@424._by_8:
addq	$0x8, %r8
cmpq	%r8, %rdx
jg	..@424._cmp_last
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@424.miscompare_reg
addq	$0x8, %rdx
..@424._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rdx
je	..@424.end
leaq	-0x8(%r8), %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@424.miscompare_reg
addq	$0x8, %rdx
jmp	..@424.end
..@424.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rdx
jmp	..@424.end
..@424.miscompare_vect:
bsfq	%r13, %r13
addq	%r13, %rdx
..@424.end:
cmpq	$0x102, %rdx
jle	isal_deflate_body_02.len_dist_huffman
cmpq	$0x108, %rdx
jge	isal_deflate_body_02.do_emit
movl	$0x102, %edx
jmp	isal_deflate_body_02.len_dist_huffman
nop
nop
nop
nop
nop
isal_deflate_body_02.compare_loop2:
leaq	(%rsi,%r12), %rcx
addq	$0x1, %rsi
movq	0x8(%rsp), %rdx
subq	%r10, %rdx
addq	0x10(%rsp), %rdx
movl	$0x1020, %r13d
cmpq	%r13, %rdx
cmovgq	%r13, %rdx
movl	$0x8, %r8d
subq	$0x20, %rdx
cmpq	%rdx, %r8
jg	..@440._by_16
..@440.loop1:
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@440.miscompare_vect
addq	$0x10, %r8
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@440.miscompare_vect
addq	$0x10, %r8
cmpq	%rdx, %r8
jle	..@440.loop1
..@440._by_16:
addq	$0x10, %rdx
cmpq	%rdx, %r8
jg	..@440._by_8
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@440.miscompare_vect
addq	$0x10, %r8
..@440._by_8:
addq	$0x8, %rdx
cmpq	%rdx, %r8
jg	..@440._cmp_last
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@440.miscompare_reg
addq	$0x8, %r8
..@440._cmp_last:
addq	$0x8, %rdx
cmpq	%rdx, %r8
je	..@440.end
leaq	-0x8(%rdx), %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@440.miscompare_reg
addq	$0x8, %r8
jmp	..@440.end
..@440.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
jmp	..@440.end
..@440.miscompare_vect:
bsfq	%r13, %r13
addq	%r13, %r8
..@440.end:
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %edx
movzwl	0x558(%r15,%rax,2), %r13d
cmpq	$0x102, %r8
jle	isal_deflate_body_02.len_dist_lit_huffman
cmpq	$0x108, %r8
jge	isal_deflate_body_02.do_emit2
movl	$0x102, %r8d
jmp	isal_deflate_body_02.len_dist_lit_huffman
nop
nop
nop
nop
nop
nop
nop
nop
nop
isal_deflate_body_02.do_emit2:
negq	%r12
cmpq	$0x1, %r12
jg	..@456.do_compute
movl	0x150(%r15,%r12,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@456.done
..@456.do_compute:
bsrq	%r12, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r12, %rbx
andq	%rsi, %rbx
shrq	%cl, %r12
leaq	(%r12,%rcx,2), %r12
movq	%rcx, %rsi
movzbq	0x898(%r12,%r15), %rcx
movzwq	0x85c(%r15,%r12,2), %r12
shlq	%cl, %rbx
orq	%r12, %rbx
addq	%rcx, %rsi
..@456.done:
movl	0x554(%r15), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
movq	%rcx, %rax
movq	%rdx, %rcx
movq	%r12, %rdx
shlq	%cl, %rdx
orq	%rdx, %r13
addq	%rsi, %rcx
movq	%rcx, %rdx
movq	%rbp, %rcx
shlq	%cl, %r13
orq	%r13, %r9
addq	%rdx, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
leaq	0x2(%r10), %r13
vmovd	%xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rcx,2)
addq	$0x1, %r13
vpextrd	$0x1, %xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rcx,2)
addq	$0x102, %r10
leaq	-0x102(%r8), %rdx
jmp	isal_deflate_body_02.emit_loop
isal_deflate_body_02.do_emit:
decq	%r10
negq	%rbx
movq	%rbx, %r13
cmpq	$0x1, %r13
jg	..@483.do_compute
movl	0x150(%r15,%r13,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@483.done
..@483.do_compute:
bsrq	%r13, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r13, %rbx
andq	%rsi, %rbx
shrq	%cl, %r13
leaq	(%r13,%rcx,2), %r13
movq	%rcx, %rsi
movzbq	0x898(%r13,%r15), %rcx
movzwq	0x85c(%r15,%r13,2), %r13
shlq	%cl, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
..@483.done:
movl	0x554(%r15), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
leaq	0x2(%r10), %r13
vmovd	%xmm2, %r8d
vpextrd	$0x1, %xmm2, %eax
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rax,2)
movq	%rcx, %rax
isal_deflate_body_02.emit:
addq	$0x102, %r10
subq	$0x102, %rdx
movq	%r12, %r13
movq	%rbp, %rcx
shlq	%cl, %r13
orq	%r13, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
isal_deflate_body_02.emit_loop:
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_02.output_end
cmpq	$0x108, %rdx
jge	isal_deflate_body_02.emit
movl	$0x102, %r8d
cmpq	%r8, %rdx
cmovgq	%r8, %rdx
addq	%rdx, %r10
subq	%rax, %rsi
movl	0x14c(%r15,%rdx,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
movq	%rbx, %r12
shlq	%cl, %r12
orq	%rax, %r12
addq	%rcx, %rsi
movq	%rbp, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrq	%cl, %r9
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_02.input_end
leaq	-0x4(%r10), %r12
vmovd	%xmm3, %ebx
movl	(%rdi,%r12), %eax
movl	0x1(%rdi,%r12), %r8d
xorl	%edx, %edx
crc32l	%eax, %edx
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
movw	%r12w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r12
movw	%r12w, 0x101d0(%r14,%rcx,2)
addq	$0x1, %r12
movl	(%rdi,%r12), %eax
movl	0x1(%rdi,%r12), %r8d
xorl	%edx, %edx
crc32l	%eax, %edx
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
movw	%r12w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r12
movw	%r12w, 0x101d0(%r14,%rcx,2)
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
xorl	%edx, %edx
crc32l	%eax, %edx
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_02.loop2
isal_deflate_body_02.write_first_byte:
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_02.output_end
movb	$0x1, 0x87(%r14)
movw	%r10w, 0x101d0(%r14,%rdx,2)
movq	%rcx, %rdx
shrq	$0x10, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
vmovd	%edx, %xmm2
vpinsrd	$0x1, %ecx, %xmm2, %xmm2
vpand	%xmm3, %xmm2, %xmm2
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %esi
movzwl	0x558(%r15,%rax,2), %ebx
jmp	isal_deflate_body_02.write_lit_bits
isal_deflate_body_04:
endbr64
movq	%rdi, %rcx
cmpl	$0x0, 0x8(%rcx)
jne	isal_deflate_body_04.skip1
movl	$0x4, %edx
movl	$0x3, %eax
cmpw	$0x0, 0x38(%rcx)
cmovneq	%rdx, %rax
cmpw	$0x0, 0x3a(%rcx)
cmovneq	%rdx, %rax
movl	%eax, 0x54(%rcx)
retq
isal_deflate_body_04.skip1:
subq	$0xa8, %rsp
movq	%rbx, 0x20(%rsp)
movq	%rsi, 0x28(%rsp)
movq	%rdi, 0x30(%rsp)
movq	%rbp, 0x38(%rsp)
movq	%r12, 0x40(%rsp)
movq	%r13, 0x48(%rsp)
movq	%r14, 0x50(%rsp)
movq	%r15, 0x58(%rsp)
movq	%rcx, %r14
movb	$0x0, 0x86(%r14)
vmovd	0x50(%r14), %xmm3
vpshufd	$0x0, %xmm3, %xmm3
movq	0x10(%r14), %r11
movq	%r11, 0x78(%r14)
movl	0x18(%r14), %esi
addq	%r11, %rsi
subq	$0x8, %rsi
movq	%rsi, 0x70(%r14)
movq	0x58(%r14), %r9
movl	0x60(%r14), %ebp
movq	0x20(%r14), %r15
movq	(%r14), %rdi
movl	0xc(%r14), %r10d
subq	%r10, %rdi
movl	0x8(%r14), %r8d
addq	%r10, %r8
movq	$0x10, 0x10(%rsp)
cmpb	$0x0, 0x38(%r14)
jne	isal_deflate_body_04.default_inbuf_padding
cmpb	$0x0, 0x3a(%r14)
jne	isal_deflate_body_04.default_inbuf_padding
movq	$0x120, 0x10(%rsp)
isal_deflate_body_04.default_inbuf_padding:
subq	0x10(%rsp), %r8
movq	%r8, 0x8(%rsp)
cmpq	%r10, %r8
jle	isal_deflate_body_04.input_end
vmovd	%xmm3, %ebx
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %r13
movq	%rax, %r8
xorl	%edx, %edx
crc32l	%eax, %edx
shrq	$0x8, %r13
xorl	%ecx, %ecx
crc32l	%r13d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
cmpb	$0x0, 0x87(%r14)
je	isal_deflate_body_04.write_first_byte
jmp	isal_deflate_body_04.loop2
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
isal_deflate_body_04.loop2:
movl	0x4c(%r14), %r13d
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_04.output_end
xorq	%rbx, %rbx
xorq	%r12, %r12
leaq	(%rdi,%r10), %rsi
movw	%r10w, %bx
decq	%rbx
subw	0x101d0(%r14,%rdx,2), %bx
movw	%r10w, 0x101d0(%r14,%rdx,2)
incq	%r10
vmovq	%xmm4, %r8
shrq	$0x10, %rax
movq	%rax, %rdx
xorl	%r8d, %r8d
crc32l	%eax, %r8d
movw	%r10w, %r12w
decq	%r12
subw	0x101d0(%r14,%rcx,2), %r12w
movw	%r10w, 0x101d0(%r14,%rcx,2)
andq	%r13, %rbx
negq	%rbx
shrq	$0x8, %rdx
xorl	%ecx, %ecx
crc32l	%edx, %ecx
andq	%r13, %r12
negq	%r12
vmovq	%xmm4, %rdx
movq	%rdx, %rax
vpsrldq	$0x1, %xmm4, %xmm4
xorq	-0x1(%rsi,%rbx), %rdx
je	isal_deflate_body_04.compare_loop
vmovd	%r8d, %xmm2
vpinsrd	$0x1, %ecx, %xmm2, %xmm2
vpand	%xmm3, %xmm2, %xmm2
vmovq	%xmm4, %r8
xorq	(%rsi,%r12), %r8
je	isal_deflate_body_04.compare_loop2
movzbq	%al, %rsi
movzbl	0x75a(%r15,%rsi), %ecx
movzwl	0x558(%r15,%rsi,2), %r13d
testl	$0xffffffff, %edx
je	isal_deflate_body_04.len_dist_huffman_pre
shrq	$0x8, %rax
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %esi
movzwl	0x558(%r15,%rax,2), %ebx
shlxq	%rcx, %rbx, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
testl	$0xffffffff, %r8d
jne	isal_deflate_body_04.write_lit_bits
isal_deflate_body_04.len_dist_lit_huffman_pre:
movq	%rcx, %rdx
bsfq	%r8, %r8
shrq	$0x3, %r8
isal_deflate_body_04.len_dist_lit_huffman:
negq	%r12
movq	%r12, %rbx
cmpq	$0x1, %rbx
jg	..@554.do_compute
movl	0x150(%r15,%rbx,4), %esi
movq	%rsi, %r12
andq	$0x1f, %rsi
shrq	$0x5, %r12
jmp	..@554.done
..@554.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
bzhiq	%rcx, %rbx, %r12
shrxq	%rcx, %rbx, %rbx
leaq	(%rbx,%rcx,2), %rbx
movq	%rcx, %rsi
movzbq	0x898(%r15,%rbx), %rcx
movzwq	0x85c(%r15,%rbx,2), %rbx
shlxq	%rcx, %r12, %r12
orq	%rbx, %r12
addq	%rcx, %rsi
..@554.done:
movl	0x14c(%r15,%r8,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
vmovd	%xmm3, %ebx
shlxq	%rcx, %r12, %r12
orq	%rax, %r12
addq	%rcx, %rsi
addq	%r8, %r10
negq	%r8
shlxq	%rdx, %r12, %r12
vmovq	%xmm4, %rax
shrq	$0x18, %rax
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebx, %ecx
orq	%r13, %r12
addq	%rdx, %rsi
leaq	0x1(%r10,%r8), %r13
movq	0x8(%rsp), %r8
cmpq	%r8, %r10
jge	isal_deflate_body_04.len_dist_lit_huffman_finish
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
vmovd	%xmm2, %edx
vpextrd	$0x1, %xmm2, %r8d
movw	%r13w, 0x101d0(%r14,%rdx,2)
xorl	%edx, %edx
crc32l	%eax, %edx
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
shlxq	%rbp, %r12, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_04.loop2
isal_deflate_body_04.len_dist_lit_huffman_finish:
vmovd	%xmm2, %edx
vpextrd	$0x1, %xmm2, %r8d
movw	%r13w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
shlxq	%rbp, %r12, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
jmp	isal_deflate_body_04.input_end
nop
nop
nop
nop
nop
nop
nop
isal_deflate_body_04.len_dist_huffman_pre:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
isal_deflate_body_04.len_dist_huffman:
decq	%r10
negq	%rbx
movq	%rbx, %r13
cmpq	$0x1, %r13
jg	..@580.do_compute
movl	0x150(%r15,%r13,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@580.done
..@580.do_compute:
bsrq	%r13, %rcx
decq	%rcx
bzhiq	%rcx, %r13, %rbx
shrxq	%rcx, %r13, %r13
leaq	(%r13,%rcx,2), %r13
movq	%rcx, %rsi
movzbq	0x898(%r13,%r15), %rcx
movzwq	0x85c(%r15,%r13,2), %r13
shlxq	%rcx, %rbx, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
..@580.done:
movl	0x14c(%r15,%rdx,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
shlxq	%rcx, %rbx, %r12
orq	%rax, %r12
addq	%rcx, %rsi
leaq	0x2(%r10), %r13
addq	%rdx, %r10
vmovd	%xmm2, %edx
vpextrd	$0x1, %xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rcx,2)
vmovd	%xmm3, %ebx
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_04.len_dist_huffman_finish
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
xorl	%edx, %edx
crc32l	%eax, %edx
shlxq	%rbp, %r12, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_04.loop2
isal_deflate_body_04.len_dist_huffman_finish:
shlxq	%rbp, %r12, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
jmp	isal_deflate_body_04.input_end
nop
nop
nop
nop
nop
nop
nop
nop
nop
isal_deflate_body_04.write_lit_bits:
vpsrldq	$0x1, %xmm4, %xmm4
addq	$0x1, %r10
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_04.write_lit_bits_finish
vmovq	%xmm4, %rax
vmovdqu	(%rdi,%r10), %xmm4
vmovd	%xmm2, %edx
shlxq	%rbp, %rbx, %rbx
orq	%rbx, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
vpextrd	$0x1, %xmm2, %ecx
jmp	isal_deflate_body_04.loop2
isal_deflate_body_04.write_lit_bits_finish:
shlxq	%rbp, %rbx, %rbx
orq	%rbx, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
isal_deflate_body_04.input_end:
movl	$0x4, %esi
movl	$0x3, %eax
cmpw	$0x0, 0x38(%r14)
cmovneq	%rsi, %rax
cmpw	$0x0, 0x3a(%r14)
cmovneq	%rsi, %rax
movl	%eax, 0x54(%r14)
isal_deflate_body_04.output_end:
movq	0x8(%rsp), %r8
addq	0x10(%rsp), %r8
movl	%r10d, 0xc(%r14)
addq	%r10, %rdi
movq	%rdi, (%r14)
subq	%r10, %r8
movl	%r8d, 0x8(%r14)
movq	%r11, 0x10(%r14)
subq	0x78(%r14), %r11
subl	%r11d, 0x18(%r14)
addl	%r11d, 0x1c(%r14)
movq	%r9, 0x58(%r14)
movl	%ebp, 0x60(%r14)
movq	0x20(%rsp), %rbx
movq	0x28(%rsp), %rsi
movq	0x30(%rsp), %rdi
movq	0x38(%rsp), %rbp
movq	0x40(%rsp), %r12
movq	0x48(%rsp), %r13
movq	0x50(%rsp), %r14
movq	0x58(%rsp), %r15
addq	$0xa8, %rsp
retq
nop
nop
nop
nop
nop
nop
nop
isal_deflate_body_04.compare_loop:
vmovd	%r8d, %xmm2
vpinsrd	$0x1, %ecx, %xmm2, %xmm2
vpand	%xmm3, %xmm2, %xmm2
leaq	-0x1(%rsi,%rbx), %rcx
movq	0x8(%rsp), %r8
subq	%r10, %r8
addq	0x10(%rsp), %r8
addq	$0x1, %r8
movl	$0x1020, %r13d
cmpq	%r13, %r8
cmovgq	%r13, %r8
movl	$0x8, %edx
subq	$0x40, %r8
cmpq	%r8, %rdx
jg	..@618._by_32
..@618.loop1:
vmovdqu	(%rsi,%rdx), %ymm0
vmovdqu	(%rcx,%rdx), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@618.miscompare_vect
addq	$0x20, %rdx
vmovdqu	(%rsi,%rdx), %ymm0
vmovdqu	(%rcx,%rdx), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@618.miscompare_vect
addq	$0x20, %rdx
cmpq	%r8, %rdx
jle	..@618.loop1
..@618._by_32:
addq	$0x20, %r8
cmpq	%r8, %rdx
jg	..@618._by_16
vmovdqu	(%rsi,%rdx), %ymm0
vmovdqu	(%rcx,%rdx), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@618.miscompare_vect
addq	$0x20, %rdx
..@618._by_16:
addq	$0x10, %r8
cmpq	%r8, %rdx
jg	..@618._by_8
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorl	$0xffff, %r13d
jne	..@618.miscompare_vect
addq	$0x10, %rdx
..@618._by_8:
addq	$0x8, %r8
cmpq	%r8, %rdx
jg	..@618._cmp_last
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@618.miscompare_reg
addq	$0x8, %rdx
..@618._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rdx
je	..@618.end
leaq	-0x8(%r8), %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@618.miscompare_reg
addq	$0x8, %rdx
jmp	..@618.end
..@618.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rdx
jmp	..@618.end
..@618.miscompare_vect:
tzcntq	%r13, %r13
addq	%r13, %rdx
..@618.end:
cmpq	$0x102, %rdx
jle	isal_deflate_body_04.len_dist_huffman
cmpq	$0x108, %rdx
jge	isal_deflate_body_04.do_emit
movl	$0x102, %edx
jmp	isal_deflate_body_04.len_dist_huffman
nop
isal_deflate_body_04.compare_loop2:
leaq	(%rsi,%r12), %rcx
addq	$0x1, %rsi
movq	0x8(%rsp), %rdx
subq	%r10, %rdx
addq	0x10(%rsp), %rdx
movl	$0x1020, %r13d
cmpq	%r13, %rdx
cmovgq	%r13, %rdx
movl	$0x8, %r8d
subq	$0x40, %rdx
cmpq	%rdx, %r8
jg	..@622._by_32
..@622.loop1:
vmovdqu	(%rsi,%r8), %ymm0
vmovdqu	(%rcx,%r8), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@622.miscompare_vect
addq	$0x20, %r8
vmovdqu	(%rsi,%r8), %ymm0
vmovdqu	(%rcx,%r8), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@622.miscompare_vect
addq	$0x20, %r8
cmpq	%rdx, %r8
jle	..@622.loop1
..@622._by_32:
addq	$0x20, %rdx
cmpq	%rdx, %r8
jg	..@622._by_16
vmovdqu	(%rsi,%r8), %ymm0
vmovdqu	(%rcx,%r8), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@622.miscompare_vect
addq	$0x20, %r8
..@622._by_16:
addq	$0x10, %rdx
cmpq	%rdx, %r8
jg	..@622._by_8
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorl	$0xffff, %r13d
jne	..@622.miscompare_vect
addq	$0x10, %r8
..@622._by_8:
addq	$0x8, %rdx
cmpq	%rdx, %r8
jg	..@622._cmp_last
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@622.miscompare_reg
addq	$0x8, %r8
..@622._cmp_last:
addq	$0x8, %rdx
cmpq	%rdx, %r8
je	..@622.end
leaq	-0x8(%rdx), %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@622.miscompare_reg
addq	$0x8, %r8
jmp	..@622.end
..@622.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
jmp	..@622.end
..@622.miscompare_vect:
tzcntq	%r13, %r13
addq	%r13, %r8
..@622.end:
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %edx
movzwl	0x558(%r15,%rax,2), %r13d
cmpq	$0x102, %r8
jle	isal_deflate_body_04.len_dist_lit_huffman
cmpq	$0x108, %r8
jge	isal_deflate_body_04.do_emit2
movl	$0x102, %r8d
jmp	isal_deflate_body_04.len_dist_lit_huffman
nop
nop
nop
isal_deflate_body_04.do_emit2:
negq	%r12
cmpq	$0x1, %r12
jg	..@626.do_compute
movl	0x150(%r15,%r12,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@626.done
..@626.do_compute:
bsrq	%r12, %rcx
decq	%rcx
bzhiq	%rcx, %r12, %rbx
shrxq	%rcx, %r12, %r12
leaq	(%r12,%rcx,2), %r12
movq	%rcx, %rsi
movzbq	0x898(%r12,%r15), %rcx
movzwq	0x85c(%r15,%r12,2), %r12
shlxq	%rcx, %rbx, %rbx
orq	%r12, %rbx
addq	%rcx, %rsi
..@626.done:
movl	0x554(%r15), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
shlxq	%rcx, %rbx, %r12
orq	%rax, %r12
addq	%rcx, %rsi
movq	%rcx, %rax
movq	%rdx, %rcx
shlxq	%rcx, %r12, %rdx
orq	%rdx, %r13
addq	%rsi, %rcx
movq	%rcx, %rdx
shlxq	%rbp, %r13, %r13
orq	%r13, %r9
addq	%rdx, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
leaq	0x2(%r10), %r13
vmovd	%xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rcx,2)
addq	$0x1, %r13
vpextrd	$0x1, %xmm2, %ecx
movw	%r13w, 0x101d0(%r14,%rcx,2)
addq	$0x102, %r10
leaq	-0x102(%r8), %rdx
jmp	isal_deflate_body_04.emit_loop
isal_deflate_body_04.do_emit:
decq	%r10
negq	%rbx
movq	%rbx, %r13
cmpq	$0x1, %r13
jg	..@639.do_compute
movl	0x150(%r15,%r13,4), %esi
movq	%rsi, %rbx
andq	$0x1f, %rsi
shrq	$0x5, %rbx
jmp	..@639.done
..@639.do_compute:
bsrq	%r13, %rcx
decq	%rcx
bzhiq	%rcx, %r13, %rbx
shrxq	%rcx, %r13, %r13
leaq	(%r13,%rcx,2), %r13
movq	%rcx, %rsi
movzbq	0x898(%r13,%r15), %rcx
movzwq	0x85c(%r15,%r13,2), %r13
shlxq	%rcx, %rbx, %rbx
orq	%r13, %rbx
addq	%rcx, %rsi
..@639.done:
movl	0x554(%r15), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
shlxq	%rcx, %rbx, %r12
orq	%rax, %r12
addq	%rcx, %rsi
leaq	0x2(%r10), %r13
vmovd	%xmm2, %r8d
vpextrd	$0x1, %xmm2, %eax
movw	%r13w, 0x101d0(%r14,%r8,2)
addq	$0x1, %r13
movw	%r13w, 0x101d0(%r14,%rax,2)
movq	%rcx, %rax
isal_deflate_body_04.emit:
addq	$0x102, %r10
subq	$0x102, %rdx
movq	%r12, %r13
shlxq	%rbp, %r13, %r13
orq	%r13, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
isal_deflate_body_04.emit_loop:
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_04.output_end
cmpq	$0x108, %rdx
jge	isal_deflate_body_04.emit
movl	$0x102, %r8d
cmpq	%r8, %rdx
cmovgq	%r8, %rdx
addq	%rdx, %r10
subq	%rax, %rsi
movl	0x14c(%r15,%rdx,4), %ecx
movl	%ecx, %eax
andl	$0x1f, %ecx
shrl	$0x5, %eax
shlxq	%rcx, %rbx, %r12
orq	%rax, %r12
addq	%rcx, %rsi
shlxq	%rbp, %r12, %r12
orq	%r12, %r9
addq	%rsi, %rbp
movq	%r9, (%r11)
movq	%rbp, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r11
shlq	$0x3, %rcx
andq	$0x7, %rbp
shrxq	%rcx, %r9, %r9
cmpq	0x8(%rsp), %r10
jge	isal_deflate_body_04.input_end
leaq	-0x4(%r10), %r12
vmovd	%xmm3, %ebx
movl	(%rdi,%r12), %eax
movl	0x1(%rdi,%r12), %r8d
xorl	%edx, %edx
crc32l	%eax, %edx
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
movw	%r12w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r12
movw	%r12w, 0x101d0(%r14,%rcx,2)
addq	$0x1, %r12
movl	(%rdi,%r12), %eax
movl	0x1(%rdi,%r12), %r8d
xorl	%edx, %edx
crc32l	%eax, %edx
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
movw	%r12w, 0x101d0(%r14,%rdx,2)
addq	$0x1, %r12
movw	%r12w, 0x101d0(%r14,%rcx,2)
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
xorl	%edx, %edx
crc32l	%eax, %edx
movq	%rax, %r8
shrq	$0x8, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
andl	%ebx, %edx
andl	%ebx, %ecx
jmp	isal_deflate_body_04.loop2
isal_deflate_body_04.write_first_byte:
cmpq	0x70(%r14), %r11
ja	isal_deflate_body_04.output_end
movb	$0x1, 0x87(%r14)
movw	%r10w, 0x101d0(%r14,%rdx,2)
movq	%rcx, %rdx
shrq	$0x10, %r8
xorl	%ecx, %ecx
crc32l	%r8d, %ecx
vmovd	%edx, %xmm2
vpinsrd	$0x1, %ecx, %xmm2, %xmm2
vpand	%xmm3, %xmm2, %xmm2
andq	$0xff, %rax
movzbl	0x75a(%r15,%rax), %esi
movzwl	0x558(%r15,%rax,2), %ebx
jmp	isal_deflate_body_04.write_lit_bits

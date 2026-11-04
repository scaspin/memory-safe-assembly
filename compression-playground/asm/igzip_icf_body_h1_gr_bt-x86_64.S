	.text
isal_deflate_icf_body_hash_hist_01:
endbr64
movq	%rdi, %rcx
cmpl	$0x0, 0x8(%rcx)
jne	isal_deflate_icf_body_hash_hist_01.skip1
movl	$0x2, %edx
movl	0x54(%rcx), %eax
cmpw	$0x0, 0x38(%rcx)
cmovneq	%rdx, %rax
cmpw	$0x0, 0x3a(%rcx)
cmovneq	%rdx, %rax
movl	%eax, 0x54(%rcx)
retq
isal_deflate_icf_body_hash_hist_01.skip1:
subq	$0xd8, %rsp
movq	%rbx, 0x50(%rsp)
movq	%rsi, 0x58(%rsp)
movq	%rdi, 0x60(%rsp)
movq	%rbp, 0x68(%rsp)
movq	%r12, 0x70(%rsp)
movq	%r13, 0x78(%rsp)
movq	%r14, 0x80(%rsp)
movq	%r15, 0x88(%rsp)
movq	%rcx, %r13
movq	%r13, 0x28(%rsp)
movb	$0x0, 0x86(%r13)
movl	0x4c(%r13), %esi
movq	%rsi, 0x10(%rsp)
movl	0x50(%r13), %esi
movq	%rsi, 0x18(%rsp)
movq	0x30(%r13), %r14
movq	0x1250(%r14), %r11
movq	%r11, 0x8(%rsp)
movq	0x1258(%r14), %rsi
addq	%r11, %rsi
subq	$0x8, %rsi
movq	%rsi, (%rsp)
movq	(%r13), %rdi
movl	0xc(%r13), %r10d
subq	%r10, %rdi
movl	0x8(%r13), %r15d
addq	%r10, %r15
movq	%r10, 0x38(%rsp)
addq	$0x800, 0x38(%rsp)
movq	$0x0, 0x40(%rsp)
movd	min_lit_dist_syms(%rip), %xmm5
pshufd	$0x0, %xmm5, %xmm5
movdqu	low_lit_shuf(%rip), %xmm2
movdqu	up_lit_shuf(%rip), %xmm3
movq	$0x10, 0x30(%rsp)
cmpb	$0x0, 0x38(%r13)
jne	isal_deflate_icf_body_hash_hist_01.default_inbuf_padding
cmpb	$0x0, 0x3a(%r13)
jne	isal_deflate_icf_body_hash_hist_01.default_inbuf_padding
movq	$0x120, 0x30(%rsp)
isal_deflate_icf_body_hash_hist_01.default_inbuf_padding:
subq	0x30(%rsp), %r15
movl	0x18(%rsp), %r8d
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_01.input_end
movdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %rsi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %rsi
xorl	%r9d, %r9d
crc32l	%esi, %r9d
andq	%r8, %rbp
andq	%r8, %r9
cmpb	$0x0, 0x87(%r13)
je	isal_deflate_icf_body_hash_hist_01.write_first_byte
jmp	isal_deflate_icf_body_hash_hist_01.loop2
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
isal_deflate_icf_body_hash_hist_01.loop2:
movl	0x10(%rsp), %r13d
movl	0x18(%rsp), %r8d
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_01.output_end
xorq	%rbx, %rbx
xorq	%r12, %r12
leaq	(%rdi,%r10), %rsi
movw	%r10w, %bx
decq	%rbx
subw	0x1268(%r14,%rbp,2), %bx
movw	%r10w, 0x1268(%r14,%rbp,2)
incq	%r10
movq	%rax, %rcx
shrq	$0x10, %rax
xorl	%ebp, %ebp
crc32l	%eax, %ebp
andl	%r8d, %ebp
movw	%r10w, %r12w
decq	%r12
subw	0x1268(%r14,%r9,2), %r12w
movw	%r10w, 0x1268(%r14,%r9,2)
andl	%r13d, %ebx
negq	%rbx
shrq	$0x18, %rcx
xorl	%r9d, %r9d
crc32l	%ecx, %r9d
andl	%r8d, %r9d
andl	%r13d, %r12d
negq	%r12
movq	%xmm4, %rdx
movq	%rdx, %rax
psrldq	$0x1, %xmm4
xorq	-0x1(%rsi,%rbx), %rdx
je	isal_deflate_icf_body_hash_hist_01.compare_loop
movq	%xmm4, %r8
xorq	(%rsi,%r12), %r8
je	isal_deflate_icf_body_hash_hist_01.compare_loop2
movzbq	%al, %rsi
shrq	$0x8, %rax
testl	$0xffffffff, %edx
je	isal_deflate_icf_body_hash_hist_01.len_dist_huffman_pre
psrldq	$0x1, %xmm4
incl	0x8f8(%r14,%rsi,4)
movzbq	%al, %rbx
testl	$0xffffffff, %r8d
jne	isal_deflate_icf_body_hash_hist_01.write_lit_bits
isal_deflate_icf_body_hash_hist_01.len_dist_lit_huffman_pre:
bsfq	%r8, %r8
shrq	$0x3, %r8
isal_deflate_icf_body_hash_hist_01.len_dist_lit_huffman:
orq	$0x7800, %rsi
movl	%esi, (%r11)
negq	%r12
cmpq	$0x1, %r12
jg	..@95.do_compute
movq	%r12, %rbx
jmp	..@95.done
..@95.do_compute:
bsrq	%r12, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r12, %rbx
andq	%rsi, %rbx
shrq	%cl, %r12
leaq	(%r12,%rcx,2), %r12
shlq	$0x9, %rbx
addq	%r12, %rbx
..@95.done:
shlq	$0xa, %rbx
movl	0x18(%rsp), %r12d
leaq	0x1(%r10), %r13
movq	%r10, %rcx
addq	%r10, %rdi
addq	%r8, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_01.len_dist_lit_huffman_finish
leaq	0x800(%r10), %rsi
movq	%rsi, 0x38(%rsp)
subq	%r8, 0x40(%rsp)
movdqu	(%rdi,%r8), %xmm4
movq	(%rdi,%r8), %rsi
subq	%rcx, %rdi
shrq	$0x18, %rax
xorl	%edx, %edx
crc32l	%eax, %edx
andl	%r12d, %edx
movq	%rsi, %rax
shrq	$0x8, %rsi
movw	%r13w, 0x1268(%r14,%rbp,2)
xorl	%ebp, %ebp
crc32l	%eax, %ebp
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
xorl	%r9d, %r9d
crc32l	%esi, %r9d
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%rdx,2)
addq	$0xfe, %rbx
addq	%r8, %rbx
incl	0xcf0(%r14,%r8,4)
movl	%ebx, 0x4(%r11)
addq	$0x8, %r11
shrq	$0xa, %rbx
andq	$0x1f, %rbx
incl	0x880(%r14,%rbx,4)
andl	%r12d, %ebp
andl	%r12d, %r9d
jmp	isal_deflate_icf_body_hash_hist_01.loop2
isal_deflate_icf_body_hash_hist_01.len_dist_lit_huffman_finish:
subq	%rcx, %rdi
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
addq	$0xfe, %rbx
addq	%r8, %rbx
incl	0xcf0(%r14,%r8,4)
movl	%ebx, 0x4(%r11)
addq	$0x8, %r11
shrq	$0xa, %rbx
andq	$0x1f, %rbx
incl	0x880(%r14,%rbx,4)
jmp	isal_deflate_icf_body_hash_hist_01.input_end
isal_deflate_icf_body_hash_hist_01.len_dist_huffman_pre:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
isal_deflate_icf_body_hash_hist_01.len_dist_huffman:
decq	%r10
leaq	0x2(%r10), %r13
negq	%rbx
cmpq	$0x1, %rbx
jg	..@107.do_compute
movq	%rbx, %r12
jmp	..@107.done
..@107.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%rbx, %r12
andq	%rsi, %r12
shrq	%cl, %rbx
leaq	(%rbx,%rcx,2), %rbx
shlq	$0x9, %r12
addq	%rbx, %r12
..@107.done:
shlq	$0xa, %r12
isal_deflate_icf_body_hash_hist_01.len_dist_huffman_skip:
movl	0x18(%rsp), %ebx
movq	%r10, %rsi
addq	%r10, %rdi
addq	%rdx, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_01.len_dist_huffman_finish
leaq	0x800(%r10), %rcx
movq	%rcx, 0x38(%rsp)
subq	%rdx, 0x40(%rsp)
movdqu	(%rdi,%rdx), %xmm4
movq	(%rdi,%rdx), %r8
movq	%r8, %rax
subq	%rsi, %rdi
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %r8
xorl	%r9d, %r9d
crc32l	%r8d, %r9d
incl	0x8f8(%r14,%rdx,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r14,%r12,4)
andl	%ebx, %ebp
andl	%ebx, %r9d
jmp	isal_deflate_icf_body_hash_hist_01.loop2
isal_deflate_icf_body_hash_hist_01.len_dist_huffman_finish:
subq	%rsi, %rdi
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
incl	0x8f8(%r14,%rdx,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r14,%r12,4)
jmp	isal_deflate_icf_body_hash_hist_01.input_end
isal_deflate_icf_body_hash_hist_01.write_lit_bits:
movq	%xmm4, %rax
addq	$0x1, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_01.write_lit_bits_finish
movdqu	(%rdi,%r10), %xmm4
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
cmpq	0x38(%rsp), %r10
jle	isal_deflate_icf_body_hash_hist_01.loop2
xorq	%r13, %r13
movq	0x40(%rsp), %rcx
addq	$0x1, %rcx
cmovlq	%r13, %rcx
movl	$0x230, %esi
cmpq	$0x230, %rcx
cmovgq	%rsi, %rcx
movl	$0x800, %esi
shrq	%cl, %rsi
cmpq	$0x3f, %rcx
cmovgq	%r13, %rsi
movq	%rsi, 0x38(%rsp)
movq	%rcx, 0x40(%rsp)
subq	$0x200, %rcx
cmovlq	%r13, %rcx
leaq	0x20(%rcx,%rcx), %rcx
andq	$-0x20, %rcx
movq	(%rsp), %rsi
leaq	0x4(%rsi), %rsi
subq	%r11, %rsi
shrq	%rsi
cmpq	%rcx, %rsi
jl	isal_deflate_icf_body_hash_hist_01.skip_forward_short
movq	0x30(%rsp), %rsi
addq	%r15, %rsi
subq	%r10, %rsi
cmpq	%rcx, %rsi
jl	isal_deflate_icf_body_hash_hist_01.skip_forward_short
isal_deflate_icf_body_hash_hist_01.skip_forward_long:
movq	(%rdi,%r10), %xmm4
movzbq	(%rdi,%r10), %rsi
movzbq	0x1(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x2(%rdi,%r10), %rsi
movzbq	0x3(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x4(%rdi,%r10), %rsi
movzbq	0x5(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x6(%rdi,%r10), %rsi
movzbq	0x7(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movdqa	%xmm4, %xmm0
pshufb	%xmm2, %xmm0
movdqa	%xmm4, %xmm1
pshufb	%xmm3, %xmm1
pslld	$0xa, %xmm1
por	%xmm1, %xmm0
paddd	%xmm5, %xmm0
movdqu	%xmm0, (%r11)
addq	$0x10, %r11
addq	$0x8, %r10
subq	$0x8, %rcx
jg	isal_deflate_icf_body_hash_hist_01.skip_forward_long
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_01.input_end
movq	(%rdi,%r10), %rax
movdqu	(%rdi,%r10), %xmm4
addq	%r10, 0x38(%rsp)
jmp	isal_deflate_icf_body_hash_hist_01.loop2
isal_deflate_icf_body_hash_hist_01.skip_forward_short:
movzbq	(%rdi,%r10), %rsi
movzbq	0x1(%rdi,%r10), %rbx
incl	0x8f8(%r14,%rsi,4)
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
addq	$0x2, %r10
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_01.output_end
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_01.input_end
jmp	isal_deflate_icf_body_hash_hist_01.skip_forward_short
isal_deflate_icf_body_hash_hist_01.write_lit_bits_finish:
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
isal_deflate_icf_body_hash_hist_01.input_end:
movq	0x28(%rsp), %r13
movl	$0x4, %esi
movl	$0x3, %ecx
cmpw	$0x0, 0x38(%r13)
cmovneq	%rsi, %rcx
cmpw	$0x0, 0x3a(%r13)
cmovneq	%rsi, %rcx
movl	%ecx, 0x54(%r13)
jmp	isal_deflate_icf_body_hash_hist_01.end
isal_deflate_icf_body_hash_hist_01.output_end:
movq	0x28(%rsp), %r13
movl	$0x2, 0x54(%r13)
isal_deflate_icf_body_hash_hist_01.end:
addq	0x30(%rsp), %r15
movl	%r10d, 0xc(%r13)
movl	%r10d, 0x48(%r13)
addq	%r10, %rdi
movq	%rdi, (%r13)
subq	%r10, %r15
movl	%r15d, 0x8(%r13)
movq	%r11, 0x1250(%r14)
subq	0x8(%rsp), %r11
subl	%r11d, 0x1258(%r14)
movq	0x50(%rsp), %rbx
movq	0x58(%rsp), %rsi
movq	0x60(%rsp), %rdi
movq	0x68(%rsp), %rbp
movq	0x70(%rsp), %r12
movq	0x78(%rsp), %r13
movq	0x80(%rsp), %r14
movq	0x88(%rsp), %r15
addq	$0xd8, %rsp
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
isal_deflate_icf_body_hash_hist_01.compare_loop:
leaq	-0x1(%rsi,%rbx), %rcx
movq	%r15, %r8
subq	%r10, %r8
addq	0x30(%rsp), %r8
addq	$0x1, %r8
movl	$0x1020, %r13d
cmpq	%r13, %r8
cmovgq	%r13, %r8
movl	$0x8, %edx
subq	$0x10, %r8
cmpq	%r8, %rdx
jg	..@138._by_8
..@138.loop1:
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@138.miscompare_reg
addq	$0x8, %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@138.miscompare_reg
addq	$0x8, %rdx
cmpq	%r8, %rdx
jle	..@138.loop1
..@138._by_8:
addq	$0x8, %r8
cmpq	%r8, %rdx
jg	..@138._cmp_last
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@138.miscompare_reg
addq	$0x8, %rdx
..@138._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rdx
je	..@138.end
leaq	-0x8(%r8), %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@138.miscompare_reg
addq	$0x8, %rdx
jmp	..@138.end
..@138.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rdx
..@138.end:
cmpq	$0x102, %rdx
jle	isal_deflate_icf_body_hash_hist_01.len_dist_huffman
cmpq	$0x108, %rdx
jge	isal_deflate_icf_body_hash_hist_01.do_emit
movl	$0x102, %edx
jmp	isal_deflate_icf_body_hash_hist_01.len_dist_huffman
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
isal_deflate_icf_body_hash_hist_01.compare_loop2:
leaq	(%rsi,%r12), %rcx
addq	$0x1, %rsi
movq	%r15, %rdx
subq	%r10, %rdx
addq	0x30(%rsp), %rdx
movl	$0x1020, %r13d
cmpq	%r13, %rdx
cmovgq	%r13, %rdx
movl	$0x8, %r8d
subq	$0x10, %rdx
cmpq	%rdx, %r8
jg	..@142._by_8
..@142.loop1:
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@142.miscompare_reg
addq	$0x8, %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@142.miscompare_reg
addq	$0x8, %r8
cmpq	%rdx, %r8
jle	..@142.loop1
..@142._by_8:
addq	$0x8, %rdx
cmpq	%rdx, %r8
jg	..@142._cmp_last
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@142.miscompare_reg
addq	$0x8, %r8
..@142._cmp_last:
addq	$0x8, %rdx
cmpq	%rdx, %r8
je	..@142.end
leaq	-0x8(%rdx), %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@142.miscompare_reg
addq	$0x8, %r8
jmp	..@142.end
..@142.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
..@142.end:
movzbq	%al, %rsi
shrq	$0x8, %rax
incl	0x8f8(%r14,%rsi,4)
cmpq	$0x102, %r8
jle	isal_deflate_icf_body_hash_hist_01.len_dist_lit_huffman
cmpq	$0x108, %r8
jge	isal_deflate_icf_body_hash_hist_01.do_emit2
movl	$0x102, %r8d
jmp	isal_deflate_icf_body_hash_hist_01.len_dist_lit_huffman
isal_deflate_icf_body_hash_hist_01.do_emit2:
orq	$0x7800, %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
incq	%r10
movq	%r12, %rbx
movq	%r8, %rdx
isal_deflate_icf_body_hash_hist_01.do_emit:
negq	%rbx
cmpq	$0x1, %rbx
jg	..@143.do_compute
movq	%rbx, %r12
jmp	..@143.done
..@143.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%rbx, %r12
andq	%rsi, %r12
shrq	%cl, %rbx
leaq	(%rbx,%rcx,2), %rbx
shlq	$0x9, %r12
addq	%rbx, %r12
..@143.done:
shlq	$0xa, %r12
movl	$0x200, %r8d
orq	%r12, %r8
movq	%r12, %rsi
shrq	$0xa, %rsi
andq	$0x1f, %rsi
leaq	0x1(%r10), %r13
decq	%r10
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
isal_deflate_icf_body_hash_hist_01.emit:
subq	$0x102, %rdx
addq	$0x102, %r10
incl	0x10f8(%r14)
incl	0x880(%r14,%rsi,4)
movl	%r8d, (%r11)
addq	$0x4, %r11
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_01.output_end
cmpq	$0x108, %rdx
jge	isal_deflate_icf_body_hash_hist_01.emit
movl	$0x102, %r8d
cmpq	%r8, %rdx
cmovgq	%r8, %rdx
addq	%rdx, %r10
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
incl	0x8f8(%r14,%rdx,4)
incl	0x880(%r14,%rsi,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_01.input_end
leaq	-0x4(%r10), %rcx
movl	0x18(%rsp), %ebx
movl	(%rdi,%rcx), %eax
movl	0x1(%rdi,%rcx), %r8d
movl	0x2(%rdi,%rcx), %r13d
movl	0x3(%rdi,%rcx), %esi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
xorl	%r9d, %r9d
crc32l	%r8d, %r9d
xorl	%edx, %edx
crc32l	%r13d, %edx
xorl	%r12d, %r12d
crc32l	%esi, %r12d
andl	%ebx, %ebp
andl	%ebx, %r9d
andl	%ebx, %edx
andl	%ebx, %r12d
movw	%cx, 0x1268(%r14,%rbp,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%r9,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%rdx,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%r12,2)
movdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %rsi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %rsi
xorl	%r9d, %r9d
crc32l	%esi, %r9d
andq	%rbx, %rbp
andq	%rbx, %r9
jmp	isal_deflate_icf_body_hash_hist_01.loop2
isal_deflate_icf_body_hash_hist_01.write_first_byte:
movl	0x18(%rsp), %r8d
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_01.output_end
movb	$0x1, 0x87(%r13)
movw	%r10w, 0x1268(%r14,%rbp,2)
movq	%r9, %rbp
shrq	$0x10, %rcx
xorl	%r9d, %r9d
crc32l	%ecx, %r9d
andq	$0xff, %rax
incl	0x8f8(%r14,%rax,4)
orq	$0x7800, %rax
movl	%eax, (%r11)
addq	$0x4, %r11
movdqu	0x1(%rdi,%r10), %xmm4
addq	$0x1, %r10
movq	(%rdi,%r10), %rax
andl	%r8d, %ebp
andl	%r8d, %r9d
cmpq	%r15, %r10
jl	isal_deflate_icf_body_hash_hist_01.loop2
jmp	isal_deflate_icf_body_hash_hist_01.input_end
isal_deflate_icf_body_hash_hist_02:
endbr64
movq	%rdi, %rcx
cmpl	$0x0, 0x8(%rcx)
jne	isal_deflate_icf_body_hash_hist_02.skip1
movl	$0x2, %edx
movl	0x54(%rcx), %eax
cmpw	$0x0, 0x38(%rcx)
cmovneq	%rdx, %rax
cmpw	$0x0, 0x3a(%rcx)
cmovneq	%rdx, %rax
movl	%eax, 0x54(%rcx)
retq
isal_deflate_icf_body_hash_hist_02.skip1:
subq	$0xd8, %rsp
movq	%rbx, 0x50(%rsp)
movq	%rsi, 0x58(%rsp)
movq	%rdi, 0x60(%rsp)
movq	%rbp, 0x68(%rsp)
movq	%r12, 0x70(%rsp)
movq	%r13, 0x78(%rsp)
movq	%r14, 0x80(%rsp)
movq	%r15, 0x88(%rsp)
movq	%rcx, %r13
movq	%r13, 0x28(%rsp)
movb	$0x0, 0x86(%r13)
movl	0x4c(%r13), %esi
movq	%rsi, 0x10(%rsp)
movl	0x50(%r13), %esi
movq	%rsi, 0x18(%rsp)
movq	0x30(%r13), %r14
movq	0x1250(%r14), %r11
movq	%r11, 0x8(%rsp)
movq	0x1258(%r14), %rsi
addq	%r11, %rsi
subq	$0x8, %rsi
movq	%rsi, (%rsp)
movq	(%r13), %rdi
movl	0xc(%r13), %r10d
subq	%r10, %rdi
movl	0x8(%r13), %r15d
addq	%r10, %r15
movq	%r10, 0x38(%rsp)
addq	$0x800, 0x38(%rsp)
movq	$0x0, 0x40(%rsp)
vmovd	min_lit_dist_syms(%rip), %xmm5
vpshufd	$0x0, %xmm5, %xmm5
vmovdqu	low_lit_shuf(%rip), %xmm2
vmovdqu	up_lit_shuf(%rip), %xmm3
movq	$0x10, 0x30(%rsp)
cmpb	$0x0, 0x38(%r13)
jne	isal_deflate_icf_body_hash_hist_02.default_inbuf_padding
cmpb	$0x0, 0x3a(%r13)
jne	isal_deflate_icf_body_hash_hist_02.default_inbuf_padding
movq	$0x120, 0x30(%rsp)
isal_deflate_icf_body_hash_hist_02.default_inbuf_padding:
subq	0x30(%rsp), %r15
movl	0x18(%rsp), %r8d
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_02.input_end
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %rsi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %rsi
xorl	%r9d, %r9d
crc32l	%esi, %r9d
andq	%r8, %rbp
andq	%r8, %r9
cmpb	$0x0, 0x87(%r13)
je	isal_deflate_icf_body_hash_hist_02.write_first_byte
jmp	isal_deflate_icf_body_hash_hist_02.loop2
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
isal_deflate_icf_body_hash_hist_02.loop2:
movl	0x10(%rsp), %r13d
movl	0x18(%rsp), %r8d
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_02.output_end
xorq	%rbx, %rbx
xorq	%r12, %r12
leaq	(%rdi,%r10), %rsi
movw	%r10w, %bx
decq	%rbx
subw	0x1268(%r14,%rbp,2), %bx
movw	%r10w, 0x1268(%r14,%rbp,2)
incq	%r10
movq	%rax, %rcx
shrq	$0x10, %rax
xorl	%ebp, %ebp
crc32l	%eax, %ebp
andl	%r8d, %ebp
movw	%r10w, %r12w
decq	%r12
subw	0x1268(%r14,%r9,2), %r12w
movw	%r10w, 0x1268(%r14,%r9,2)
andl	%r13d, %ebx
negq	%rbx
shrq	$0x18, %rcx
xorl	%r9d, %r9d
crc32l	%ecx, %r9d
andl	%r8d, %r9d
andl	%r13d, %r12d
negq	%r12
vmovq	%xmm4, %rdx
movq	%rdx, %rax
vpsrldq	$0x1, %xmm4, %xmm4
xorq	-0x1(%rsi,%rbx), %rdx
je	isal_deflate_icf_body_hash_hist_02.compare_loop
vmovq	%xmm4, %r8
xorq	(%rsi,%r12), %r8
je	isal_deflate_icf_body_hash_hist_02.compare_loop2
movzbq	%al, %rsi
shrq	$0x8, %rax
testl	$0xffffffff, %edx
je	isal_deflate_icf_body_hash_hist_02.len_dist_huffman_pre
vpsrldq	$0x1, %xmm4, %xmm4
incl	0x8f8(%r14,%rsi,4)
movzbq	%al, %rbx
testl	$0xffffffff, %r8d
jne	isal_deflate_icf_body_hash_hist_02.write_lit_bits
isal_deflate_icf_body_hash_hist_02.len_dist_lit_huffman_pre:
bsfq	%r8, %r8
shrq	$0x3, %r8
isal_deflate_icf_body_hash_hist_02.len_dist_lit_huffman:
orq	$0x7800, %rsi
movl	%esi, (%r11)
negq	%r12
cmpq	$0x1, %r12
jg	..@179.do_compute
movq	%r12, %rbx
jmp	..@179.done
..@179.do_compute:
bsrq	%r12, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%r12, %rbx
andq	%rsi, %rbx
shrq	%cl, %r12
leaq	(%r12,%rcx,2), %r12
shlq	$0x9, %rbx
addq	%r12, %rbx
..@179.done:
shlq	$0xa, %rbx
movl	0x18(%rsp), %r12d
leaq	0x1(%r10), %r13
movq	%r10, %rcx
addq	%r10, %rdi
addq	%r8, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_02.len_dist_lit_huffman_finish
leaq	0x800(%r10), %rsi
movq	%rsi, 0x38(%rsp)
subq	%r8, 0x40(%rsp)
vmovdqu	(%rdi,%r8), %xmm4
movq	(%rdi,%r8), %rsi
subq	%rcx, %rdi
shrq	$0x18, %rax
xorl	%edx, %edx
crc32l	%eax, %edx
andl	%r12d, %edx
movq	%rsi, %rax
shrq	$0x8, %rsi
movw	%r13w, 0x1268(%r14,%rbp,2)
xorl	%ebp, %ebp
crc32l	%eax, %ebp
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
xorl	%r9d, %r9d
crc32l	%esi, %r9d
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%rdx,2)
addq	$0xfe, %rbx
addq	%r8, %rbx
incl	0xcf0(%r14,%r8,4)
movl	%ebx, 0x4(%r11)
addq	$0x8, %r11
shrq	$0xa, %rbx
andq	$0x1f, %rbx
incl	0x880(%r14,%rbx,4)
andl	%r12d, %ebp
andl	%r12d, %r9d
jmp	isal_deflate_icf_body_hash_hist_02.loop2
isal_deflate_icf_body_hash_hist_02.len_dist_lit_huffman_finish:
subq	%rcx, %rdi
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
addq	$0xfe, %rbx
addq	%r8, %rbx
incl	0xcf0(%r14,%r8,4)
movl	%ebx, 0x4(%r11)
addq	$0x8, %r11
shrq	$0xa, %rbx
andq	$0x1f, %rbx
incl	0x880(%r14,%rbx,4)
jmp	isal_deflate_icf_body_hash_hist_02.input_end
isal_deflate_icf_body_hash_hist_02.len_dist_huffman_pre:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
isal_deflate_icf_body_hash_hist_02.len_dist_huffman:
decq	%r10
leaq	0x2(%r10), %r13
negq	%rbx
cmpq	$0x1, %rbx
jg	..@191.do_compute
movq	%rbx, %r12
jmp	..@191.done
..@191.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%rbx, %r12
andq	%rsi, %r12
shrq	%cl, %rbx
leaq	(%rbx,%rcx,2), %rbx
shlq	$0x9, %r12
addq	%rbx, %r12
..@191.done:
shlq	$0xa, %r12
isal_deflate_icf_body_hash_hist_02.len_dist_huffman_skip:
movl	0x18(%rsp), %ebx
movq	%r10, %rsi
addq	%r10, %rdi
addq	%rdx, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_02.len_dist_huffman_finish
leaq	0x800(%r10), %rcx
movq	%rcx, 0x38(%rsp)
subq	%rdx, 0x40(%rsp)
vmovdqu	(%rdi,%rdx), %xmm4
movq	(%rdi,%rdx), %r8
movq	%r8, %rax
subq	%rsi, %rdi
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %r8
xorl	%r9d, %r9d
crc32l	%r8d, %r9d
incl	0x8f8(%r14,%rdx,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r14,%r12,4)
andl	%ebx, %ebp
andl	%ebx, %r9d
jmp	isal_deflate_icf_body_hash_hist_02.loop2
isal_deflate_icf_body_hash_hist_02.len_dist_huffman_finish:
subq	%rsi, %rdi
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
incl	0x8f8(%r14,%rdx,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r14,%r12,4)
jmp	isal_deflate_icf_body_hash_hist_02.input_end
isal_deflate_icf_body_hash_hist_02.write_lit_bits:
vmovq	%xmm4, %rax
addq	$0x1, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_02.write_lit_bits_finish
vmovdqu	(%rdi,%r10), %xmm4
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
cmpq	0x38(%rsp), %r10
jle	isal_deflate_icf_body_hash_hist_02.loop2
xorq	%r13, %r13
movq	0x40(%rsp), %rcx
addq	$0x1, %rcx
cmovlq	%r13, %rcx
movl	$0x230, %esi
cmpq	$0x230, %rcx
cmovgq	%rsi, %rcx
movl	$0x800, %esi
shrq	%cl, %rsi
cmpq	$0x3f, %rcx
cmovgq	%r13, %rsi
movq	%rsi, 0x38(%rsp)
movq	%rcx, 0x40(%rsp)
subq	$0x200, %rcx
cmovlq	%r13, %rcx
leaq	0x20(%rcx,%rcx), %rcx
andq	$-0x20, %rcx
movq	(%rsp), %rsi
leaq	0x4(%rsi), %rsi
subq	%r11, %rsi
shrq	%rsi
cmpq	%rcx, %rsi
jl	isal_deflate_icf_body_hash_hist_02.skip_forward_short
movq	0x30(%rsp), %rsi
addq	%r15, %rsi
subq	%r10, %rsi
cmpq	%rcx, %rsi
jl	isal_deflate_icf_body_hash_hist_02.skip_forward_short
isal_deflate_icf_body_hash_hist_02.skip_forward_long:
vmovq	(%rdi,%r10), %xmm4
movzbq	(%rdi,%r10), %rsi
movzbq	0x1(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x2(%rdi,%r10), %rsi
movzbq	0x3(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x4(%rdi,%r10), %rsi
movzbq	0x5(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x6(%rdi,%r10), %rsi
movzbq	0x7(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
vpshufb	%xmm2, %xmm4, %xmm0
vpshufb	%xmm3, %xmm4, %xmm1
vpslld	$0xa, %xmm1, %xmm1
vpor	%xmm1, %xmm0, %xmm0
vpaddd	%xmm5, %xmm0, %xmm0
vmovdqu	%xmm0, (%r11)
addq	$0x10, %r11
addq	$0x8, %r10
subq	$0x8, %rcx
jg	isal_deflate_icf_body_hash_hist_02.skip_forward_long
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_02.input_end
movq	(%rdi,%r10), %rax
vmovdqu	(%rdi,%r10), %xmm4
addq	%r10, 0x38(%rsp)
jmp	isal_deflate_icf_body_hash_hist_02.loop2
isal_deflate_icf_body_hash_hist_02.skip_forward_short:
movzbq	(%rdi,%r10), %rsi
movzbq	0x1(%rdi,%r10), %rbx
incl	0x8f8(%r14,%rsi,4)
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
addq	$0x2, %r10
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_02.output_end
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_02.input_end
jmp	isal_deflate_icf_body_hash_hist_02.skip_forward_short
isal_deflate_icf_body_hash_hist_02.write_lit_bits_finish:
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
isal_deflate_icf_body_hash_hist_02.input_end:
movq	0x28(%rsp), %r13
movl	$0x4, %esi
movl	$0x3, %ecx
cmpw	$0x0, 0x38(%r13)
cmovneq	%rsi, %rcx
cmpw	$0x0, 0x3a(%r13)
cmovneq	%rsi, %rcx
movl	%ecx, 0x54(%r13)
jmp	isal_deflate_icf_body_hash_hist_02.end
isal_deflate_icf_body_hash_hist_02.output_end:
movq	0x28(%rsp), %r13
movl	$0x2, 0x54(%r13)
isal_deflate_icf_body_hash_hist_02.end:
addq	0x30(%rsp), %r15
movl	%r10d, 0xc(%r13)
movl	%r10d, 0x48(%r13)
addq	%r10, %rdi
movq	%rdi, (%r13)
subq	%r10, %r15
movl	%r15d, 0x8(%r13)
movq	%r11, 0x1250(%r14)
subq	0x8(%rsp), %r11
subl	%r11d, 0x1258(%r14)
movq	0x50(%rsp), %rbx
movq	0x58(%rsp), %rsi
movq	0x60(%rsp), %rdi
movq	0x68(%rsp), %rbp
movq	0x70(%rsp), %r12
movq	0x78(%rsp), %r13
movq	0x80(%rsp), %r14
movq	0x88(%rsp), %r15
addq	$0xd8, %rsp
retq
nop
isal_deflate_icf_body_hash_hist_02.compare_loop:
leaq	-0x1(%rsi,%rbx), %rcx
movq	%r15, %r8
subq	%r10, %r8
addq	0x30(%rsp), %r8
addq	$0x1, %r8
movl	$0x1020, %r13d
cmpq	%r13, %r8
cmovgq	%r13, %r8
movl	$0x8, %edx
subq	$0x20, %r8
cmpq	%r8, %rdx
jg	..@215._by_16
..@215.loop1:
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@215.miscompare_vect
addq	$0x10, %rdx
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@215.miscompare_vect
addq	$0x10, %rdx
cmpq	%r8, %rdx
jle	..@215.loop1
..@215._by_16:
addq	$0x10, %r8
cmpq	%r8, %rdx
jg	..@215._by_8
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@215.miscompare_vect
addq	$0x10, %rdx
..@215._by_8:
addq	$0x8, %r8
cmpq	%r8, %rdx
jg	..@215._cmp_last
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@215.miscompare_reg
addq	$0x8, %rdx
..@215._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rdx
je	..@215.end
leaq	-0x8(%r8), %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@215.miscompare_reg
addq	$0x8, %rdx
jmp	..@215.end
..@215.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rdx
jmp	..@215.end
..@215.miscompare_vect:
bsfq	%r13, %r13
addq	%r13, %rdx
..@215.end:
cmpq	$0x102, %rdx
jle	isal_deflate_icf_body_hash_hist_02.len_dist_huffman
cmpq	$0x108, %rdx
jge	isal_deflate_icf_body_hash_hist_02.do_emit
movl	$0x102, %edx
jmp	isal_deflate_icf_body_hash_hist_02.len_dist_huffman
nop
nop
nop
nop
nop
nop
isal_deflate_icf_body_hash_hist_02.compare_loop2:
leaq	(%rsi,%r12), %rcx
addq	$0x1, %rsi
movq	%r15, %rdx
subq	%r10, %rdx
addq	0x30(%rsp), %rdx
movl	$0x1020, %r13d
cmpq	%r13, %rdx
cmovgq	%r13, %rdx
movl	$0x8, %r8d
subq	$0x20, %rdx
cmpq	%rdx, %r8
jg	..@231._by_16
..@231.loop1:
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@231.miscompare_vect
addq	$0x10, %r8
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@231.miscompare_vect
addq	$0x10, %r8
cmpq	%rdx, %r8
jle	..@231.loop1
..@231._by_16:
addq	$0x10, %rdx
cmpq	%rdx, %r8
jg	..@231._by_8
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorq	$0xffff, %r13
jne	..@231.miscompare_vect
addq	$0x10, %r8
..@231._by_8:
addq	$0x8, %rdx
cmpq	%rdx, %r8
jg	..@231._cmp_last
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@231.miscompare_reg
addq	$0x8, %r8
..@231._cmp_last:
addq	$0x8, %rdx
cmpq	%rdx, %r8
je	..@231.end
leaq	-0x8(%rdx), %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@231.miscompare_reg
addq	$0x8, %r8
jmp	..@231.end
..@231.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
jmp	..@231.end
..@231.miscompare_vect:
bsfq	%r13, %r13
addq	%r13, %r8
..@231.end:
movzbq	%al, %rsi
shrq	$0x8, %rax
incl	0x8f8(%r14,%rsi,4)
cmpq	$0x102, %r8
jle	isal_deflate_icf_body_hash_hist_02.len_dist_lit_huffman
cmpq	$0x108, %r8
jge	isal_deflate_icf_body_hash_hist_02.do_emit2
movl	$0x102, %r8d
jmp	isal_deflate_icf_body_hash_hist_02.len_dist_lit_huffman
isal_deflate_icf_body_hash_hist_02.do_emit2:
orq	$0x7800, %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
incq	%r10
movq	%r12, %rbx
movq	%r8, %rdx
isal_deflate_icf_body_hash_hist_02.do_emit:
negq	%rbx
cmpq	$0x1, %rbx
jg	..@244.do_compute
movq	%rbx, %r12
jmp	..@244.done
..@244.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
movl	$0x1, %esi
shlq	%cl, %rsi
subq	$0x1, %rsi
movq	%rbx, %r12
andq	%rsi, %r12
shrq	%cl, %rbx
leaq	(%rbx,%rcx,2), %rbx
shlq	$0x9, %r12
addq	%rbx, %r12
..@244.done:
shlq	$0xa, %r12
movl	$0x200, %r8d
orq	%r12, %r8
movq	%r12, %rsi
shrq	$0xa, %rsi
andq	$0x1f, %rsi
leaq	0x1(%r10), %r13
decq	%r10
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
isal_deflate_icf_body_hash_hist_02.emit:
subq	$0x102, %rdx
addq	$0x102, %r10
incl	0x10f8(%r14)
incl	0x880(%r14,%rsi,4)
movl	%r8d, (%r11)
addq	$0x4, %r11
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_02.output_end
cmpq	$0x108, %rdx
jge	isal_deflate_icf_body_hash_hist_02.emit
movl	$0x102, %r8d
cmpq	%r8, %rdx
cmovgq	%r8, %rdx
addq	%rdx, %r10
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
incl	0x8f8(%r14,%rdx,4)
incl	0x880(%r14,%rsi,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_02.input_end
leaq	-0x4(%r10), %rcx
movl	0x18(%rsp), %ebx
movl	(%rdi,%rcx), %eax
movl	0x1(%rdi,%rcx), %r8d
movl	0x2(%rdi,%rcx), %r13d
movl	0x3(%rdi,%rcx), %esi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
xorl	%r9d, %r9d
crc32l	%r8d, %r9d
xorl	%edx, %edx
crc32l	%r13d, %edx
xorl	%r12d, %r12d
crc32l	%esi, %r12d
andl	%ebx, %ebp
andl	%ebx, %r9d
andl	%ebx, %edx
andl	%ebx, %r12d
movw	%cx, 0x1268(%r14,%rbp,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%r9,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%rdx,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%r12,2)
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %rsi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %rsi
xorl	%r9d, %r9d
crc32l	%esi, %r9d
andq	%rbx, %rbp
andq	%rbx, %r9
jmp	isal_deflate_icf_body_hash_hist_02.loop2
isal_deflate_icf_body_hash_hist_02.write_first_byte:
movl	0x18(%rsp), %r8d
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_02.output_end
movb	$0x1, 0x87(%r13)
movw	%r10w, 0x1268(%r14,%rbp,2)
movq	%r9, %rbp
shrq	$0x10, %rcx
xorl	%r9d, %r9d
crc32l	%ecx, %r9d
andq	$0xff, %rax
incl	0x8f8(%r14,%rax,4)
orq	$0x7800, %rax
movl	%eax, (%r11)
addq	$0x4, %r11
vmovdqu	0x1(%rdi,%r10), %xmm4
addq	$0x1, %r10
movq	(%rdi,%r10), %rax
andl	%r8d, %ebp
andl	%r8d, %r9d
cmpq	%r15, %r10
jl	isal_deflate_icf_body_hash_hist_02.loop2
jmp	isal_deflate_icf_body_hash_hist_02.input_end
isal_deflate_icf_body_hash_hist_04:
endbr64
movq	%rdi, %rcx
cmpl	$0x0, 0x8(%rcx)
jne	isal_deflate_icf_body_hash_hist_04.skip1
movl	$0x2, %edx
movl	0x54(%rcx), %eax
cmpw	$0x0, 0x38(%rcx)
cmovneq	%rdx, %rax
cmpw	$0x0, 0x3a(%rcx)
cmovneq	%rdx, %rax
movl	%eax, 0x54(%rcx)
retq
isal_deflate_icf_body_hash_hist_04.skip1:
subq	$0xd8, %rsp
movq	%rbx, 0x50(%rsp)
movq	%rsi, 0x58(%rsp)
movq	%rdi, 0x60(%rsp)
movq	%rbp, 0x68(%rsp)
movq	%r12, 0x70(%rsp)
movq	%r13, 0x78(%rsp)
movq	%r14, 0x80(%rsp)
movq	%r15, 0x88(%rsp)
movq	%rcx, %r13
movq	%r13, 0x28(%rsp)
movb	$0x0, 0x86(%r13)
movl	0x4c(%r13), %esi
movq	%rsi, 0x10(%rsp)
movl	0x50(%r13), %esi
movq	%rsi, 0x18(%rsp)
movq	0x30(%r13), %r14
movq	0x1250(%r14), %r11
movq	%r11, 0x8(%rsp)
movq	0x1258(%r14), %rsi
addq	%r11, %rsi
subq	$0x8, %rsi
movq	%rsi, (%rsp)
movq	(%r13), %rdi
movl	0xc(%r13), %r10d
subq	%r10, %rdi
movl	0x8(%r13), %r15d
addq	%r10, %r15
movq	%r10, 0x38(%rsp)
addq	$0x800, 0x38(%rsp)
movq	$0x0, 0x40(%rsp)
vpbroadcastd	min_lit_dist_syms(%rip), %xmm5
vmovdqu	low_lit_shuf(%rip), %xmm2
vmovdqu	up_lit_shuf(%rip), %xmm3
movq	$0x10, 0x30(%rsp)
cmpb	$0x0, 0x38(%r13)
jne	isal_deflate_icf_body_hash_hist_04.default_inbuf_padding
cmpb	$0x0, 0x3a(%r13)
jne	isal_deflate_icf_body_hash_hist_04.default_inbuf_padding
movq	$0x120, 0x30(%rsp)
isal_deflate_icf_body_hash_hist_04.default_inbuf_padding:
subq	0x30(%rsp), %r15
movl	0x18(%rsp), %r8d
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_04.input_end
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %rsi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %rsi
xorl	%r9d, %r9d
crc32l	%esi, %r9d
andq	%r8, %rbp
andq	%r8, %r9
cmpb	$0x0, 0x87(%r13)
je	isal_deflate_icf_body_hash_hist_04.write_first_byte
jmp	isal_deflate_icf_body_hash_hist_04.loop2
nop
nop
nop
isal_deflate_icf_body_hash_hist_04.loop2:
movl	0x10(%rsp), %r13d
movl	0x18(%rsp), %r8d
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_04.output_end
xorq	%rbx, %rbx
xorq	%r12, %r12
leaq	(%rdi,%r10), %rsi
movw	%r10w, %bx
decq	%rbx
subw	0x1268(%r14,%rbp,2), %bx
movw	%r10w, 0x1268(%r14,%rbp,2)
incq	%r10
movq	%rax, %rcx
shrq	$0x10, %rax
xorl	%ebp, %ebp
crc32l	%eax, %ebp
andl	%r8d, %ebp
movw	%r10w, %r12w
decq	%r12
subw	0x1268(%r14,%r9,2), %r12w
movw	%r10w, 0x1268(%r14,%r9,2)
andl	%r13d, %ebx
negq	%rbx
shrq	$0x18, %rcx
xorl	%r9d, %r9d
crc32l	%ecx, %r9d
andl	%r8d, %r9d
andl	%r13d, %r12d
negq	%r12
vmovq	%xmm4, %rdx
movq	%rdx, %rax
vpsrldq	$0x1, %xmm4, %xmm4
xorq	-0x1(%rsi,%rbx), %rdx
je	isal_deflate_icf_body_hash_hist_04.compare_loop
vmovq	%xmm4, %r8
xorq	(%rsi,%r12), %r8
je	isal_deflate_icf_body_hash_hist_04.compare_loop2
movzbq	%al, %rsi
shrq	$0x8, %rax
testl	$0xffffffff, %edx
je	isal_deflate_icf_body_hash_hist_04.len_dist_huffman_pre
vpsrldq	$0x1, %xmm4, %xmm4
incl	0x8f8(%r14,%rsi,4)
movzbq	%al, %rbx
testl	$0xffffffff, %r8d
jne	isal_deflate_icf_body_hash_hist_04.write_lit_bits
isal_deflate_icf_body_hash_hist_04.len_dist_lit_huffman_pre:
bsfq	%r8, %r8
shrq	$0x3, %r8
isal_deflate_icf_body_hash_hist_04.len_dist_lit_huffman:
orq	$0x7800, %rsi
movl	%esi, (%r11)
negq	%r12
cmpq	$0x1, %r12
jg	..@278.do_compute
movq	%r12, %rbx
jmp	..@278.done
..@278.do_compute:
bsrq	%r12, %rcx
decq	%rcx
bzhiq	%rcx, %r12, %rbx
shrxq	%rcx, %r12, %r12
leaq	(%r12,%rcx,2), %r12
shlq	$0x9, %rbx
addq	%r12, %rbx
..@278.done:
shlq	$0xa, %rbx
movl	0x18(%rsp), %r12d
leaq	0x1(%r10), %r13
movq	%r10, %rcx
addq	%r10, %rdi
addq	%r8, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_04.len_dist_lit_huffman_finish
leaq	0x800(%r10), %rsi
movq	%rsi, 0x38(%rsp)
subq	%r8, 0x40(%rsp)
vmovdqu	(%rdi,%r8), %xmm4
movq	(%rdi,%r8), %rsi
subq	%rcx, %rdi
shrq	$0x18, %rax
xorl	%edx, %edx
crc32l	%eax, %edx
andl	%r12d, %edx
movq	%rsi, %rax
shrq	$0x8, %rsi
movw	%r13w, 0x1268(%r14,%rbp,2)
xorl	%ebp, %ebp
crc32l	%eax, %ebp
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
xorl	%r9d, %r9d
crc32l	%esi, %r9d
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%rdx,2)
addq	$0xfe, %rbx
addq	%r8, %rbx
incl	0xcf0(%r14,%r8,4)
movl	%ebx, 0x4(%r11)
addq	$0x8, %r11
shrq	$0xa, %rbx
andq	$0x1f, %rbx
incl	0x880(%r14,%rbx,4)
andl	%r12d, %ebp
andl	%r12d, %r9d
jmp	isal_deflate_icf_body_hash_hist_04.loop2
isal_deflate_icf_body_hash_hist_04.len_dist_lit_huffman_finish:
subq	%rcx, %rdi
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
addq	$0xfe, %rbx
addq	%r8, %rbx
incl	0xcf0(%r14,%r8,4)
movl	%ebx, 0x4(%r11)
addq	$0x8, %r11
shrq	$0xa, %rbx
andq	$0x1f, %rbx
incl	0x880(%r14,%rbx,4)
jmp	isal_deflate_icf_body_hash_hist_04.input_end
isal_deflate_icf_body_hash_hist_04.len_dist_huffman_pre:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
isal_deflate_icf_body_hash_hist_04.len_dist_huffman:
decq	%r10
leaq	0x2(%r10), %r13
negq	%rbx
cmpq	$0x1, %rbx
jg	..@286.do_compute
movq	%rbx, %r12
jmp	..@286.done
..@286.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
bzhiq	%rcx, %rbx, %r12
shrxq	%rcx, %rbx, %rbx
leaq	(%rbx,%rcx,2), %rbx
shlq	$0x9, %r12
addq	%rbx, %r12
..@286.done:
shlq	$0xa, %r12
isal_deflate_icf_body_hash_hist_04.len_dist_huffman_skip:
movl	0x18(%rsp), %ebx
movq	%r10, %rsi
addq	%r10, %rdi
addq	%rdx, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_04.len_dist_huffman_finish
leaq	0x800(%r10), %rcx
movq	%rcx, 0x38(%rsp)
subq	%rdx, 0x40(%rsp)
vmovdqu	(%rdi,%rdx), %xmm4
movq	(%rdi,%rdx), %r8
movq	%r8, %rax
subq	%rsi, %rdi
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %r8
xorl	%r9d, %r9d
crc32l	%r8d, %r9d
incl	0x8f8(%r14,%rdx,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r14,%r12,4)
andl	%ebx, %ebp
andl	%ebx, %r9d
jmp	isal_deflate_icf_body_hash_hist_04.loop2
isal_deflate_icf_body_hash_hist_04.len_dist_huffman_finish:
subq	%rsi, %rdi
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
incl	0x8f8(%r14,%rdx,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r14,%r12,4)
jmp	isal_deflate_icf_body_hash_hist_04.input_end
isal_deflate_icf_body_hash_hist_04.write_lit_bits:
vmovq	%xmm4, %rax
addq	$0x1, %r10
cmpq	%r15, %r10
jg	isal_deflate_icf_body_hash_hist_04.write_lit_bits_finish
vmovdqu	(%rdi,%r10), %xmm4
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
cmpq	0x38(%rsp), %r10
jle	isal_deflate_icf_body_hash_hist_04.loop2
xorq	%r13, %r13
movq	0x40(%rsp), %rcx
addq	$0x1, %rcx
cmovlq	%r13, %rcx
movl	$0x230, %esi
cmpq	$0x230, %rcx
cmovgq	%rsi, %rcx
movl	$0x800, %esi
shrq	%cl, %rsi
cmpq	$0x3f, %rcx
cmovgq	%r13, %rsi
movq	%rsi, 0x38(%rsp)
movq	%rcx, 0x40(%rsp)
subq	$0x200, %rcx
cmovlq	%r13, %rcx
leaq	0x20(%rcx,%rcx), %rcx
andq	$-0x20, %rcx
movq	(%rsp), %rsi
leaq	0x4(%rsi), %rsi
subq	%r11, %rsi
shrq	%rsi
cmpq	%rcx, %rsi
jl	isal_deflate_icf_body_hash_hist_04.skip_forward_short
movq	0x30(%rsp), %rsi
addq	%r15, %rsi
subq	%r10, %rsi
cmpq	%rcx, %rsi
jl	isal_deflate_icf_body_hash_hist_04.skip_forward_short
isal_deflate_icf_body_hash_hist_04.skip_forward_long:
vmovq	(%rdi,%r10), %xmm4
movzbq	(%rdi,%r10), %rsi
movzbq	0x1(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x2(%rdi,%r10), %rsi
movzbq	0x3(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x4(%rdi,%r10), %rsi
movzbq	0x5(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
movzbq	0x6(%rdi,%r10), %rsi
movzbq	0x7(%rdi,%r10), %rbx
addl	$0x1, 0x8f8(%r14,%rsi,4)
addl	$0x1, 0x8f8(%r14,%rbx,4)
vpshufb	%xmm2, %xmm4, %xmm0
vpshufb	%xmm3, %xmm4, %xmm1
vpslld	$0xa, %xmm1, %xmm1
vpor	%xmm1, %xmm0, %xmm0
vpaddd	%xmm5, %xmm0, %xmm0
vmovdqu	%xmm0, (%r11)
addq	$0x10, %r11
addq	$0x8, %r10
subq	$0x8, %rcx
jg	isal_deflate_icf_body_hash_hist_04.skip_forward_long
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_04.input_end
movq	(%rdi,%r10), %rax
vmovdqu	(%rdi,%r10), %xmm4
addq	%r10, 0x38(%rsp)
jmp	isal_deflate_icf_body_hash_hist_04.loop2
isal_deflate_icf_body_hash_hist_04.skip_forward_short:
movzbq	(%rdi,%r10), %rsi
movzbq	0x1(%rdi,%r10), %rbx
incl	0x8f8(%r14,%rsi,4)
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
addq	$0x2, %r10
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_04.output_end
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_04.input_end
jmp	isal_deflate_icf_body_hash_hist_04.skip_forward_short
isal_deflate_icf_body_hash_hist_04.write_lit_bits_finish:
incl	0x8f8(%r14,%rbx,4)
shlq	$0xa, %rbx
leaq	0x7c00(%rsi,%rbx), %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
isal_deflate_icf_body_hash_hist_04.input_end:
movq	0x28(%rsp), %r13
movl	$0x4, %esi
movl	$0x3, %ecx
cmpw	$0x0, 0x38(%r13)
cmovneq	%rsi, %rcx
cmpw	$0x0, 0x3a(%r13)
cmovneq	%rsi, %rcx
movl	%ecx, 0x54(%r13)
jmp	isal_deflate_icf_body_hash_hist_04.end
isal_deflate_icf_body_hash_hist_04.output_end:
movq	0x28(%rsp), %r13
movl	$0x2, 0x54(%r13)
isal_deflate_icf_body_hash_hist_04.end:
addq	0x30(%rsp), %r15
movl	%r10d, 0xc(%r13)
movl	%r10d, 0x48(%r13)
addq	%r10, %rdi
movq	%rdi, (%r13)
subq	%r10, %r15
movl	%r15d, 0x8(%r13)
movq	%r11, 0x1250(%r14)
subq	0x8(%rsp), %r11
subl	%r11d, 0x1258(%r14)
movq	0x50(%rsp), %rbx
movq	0x58(%rsp), %rsi
movq	0x60(%rsp), %rdi
movq	0x68(%rsp), %rbp
movq	0x70(%rsp), %r12
movq	0x78(%rsp), %r13
movq	0x80(%rsp), %r14
movq	0x88(%rsp), %r15
addq	$0xd8, %rsp
retq
nop
nop
nop
isal_deflate_icf_body_hash_hist_04.compare_loop:
leaq	-0x1(%rsi,%rbx), %rcx
movq	%r15, %r8
subq	%r10, %r8
addq	0x30(%rsp), %r8
addq	$0x1, %r8
movl	$0x1020, %r13d
cmpq	%r13, %r8
cmovgq	%r13, %r8
movl	$0x8, %edx
subq	$0x40, %r8
cmpq	%r8, %rdx
jg	..@306._by_32
..@306.loop1:
vmovdqu	(%rsi,%rdx), %ymm0
vmovdqu	(%rcx,%rdx), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@306.miscompare_vect
addq	$0x20, %rdx
vmovdqu	(%rsi,%rdx), %ymm0
vmovdqu	(%rcx,%rdx), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@306.miscompare_vect
addq	$0x20, %rdx
cmpq	%r8, %rdx
jle	..@306.loop1
..@306._by_32:
addq	$0x20, %r8
cmpq	%r8, %rdx
jg	..@306._by_16
vmovdqu	(%rsi,%rdx), %ymm0
vmovdqu	(%rcx,%rdx), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@306.miscompare_vect
addq	$0x20, %rdx
..@306._by_16:
addq	$0x10, %r8
cmpq	%r8, %rdx
jg	..@306._by_8
vmovdqu	(%rsi,%rdx), %xmm0
vmovdqu	(%rcx,%rdx), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorl	$0xffff, %r13d
jne	..@306.miscompare_vect
addq	$0x10, %rdx
..@306._by_8:
addq	$0x8, %r8
cmpq	%r8, %rdx
jg	..@306._cmp_last
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@306.miscompare_reg
addq	$0x8, %rdx
..@306._cmp_last:
addq	$0x8, %r8
cmpq	%r8, %rdx
je	..@306.end
leaq	-0x8(%r8), %rdx
movq	(%rsi,%rdx), %r13
xorq	(%rcx,%rdx), %r13
jne	..@306.miscompare_reg
addq	$0x8, %rdx
jmp	..@306.end
..@306.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %rdx
jmp	..@306.end
..@306.miscompare_vect:
tzcntq	%r13, %r13
addq	%r13, %rdx
..@306.end:
cmpq	$0x102, %rdx
jle	isal_deflate_icf_body_hash_hist_04.len_dist_huffman
cmpq	$0x108, %rdx
jge	isal_deflate_icf_body_hash_hist_04.do_emit
movl	$0x102, %edx
jmp	isal_deflate_icf_body_hash_hist_04.len_dist_huffman
nop
nop
isal_deflate_icf_body_hash_hist_04.compare_loop2:
leaq	(%rsi,%r12), %rcx
addq	$0x1, %rsi
movq	%r15, %rdx
subq	%r10, %rdx
addq	0x30(%rsp), %rdx
movl	$0x1020, %r13d
cmpq	%r13, %rdx
cmovgq	%r13, %rdx
movl	$0x8, %r8d
subq	$0x40, %rdx
cmpq	%rdx, %r8
jg	..@310._by_32
..@310.loop1:
vmovdqu	(%rsi,%r8), %ymm0
vmovdqu	(%rcx,%r8), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@310.miscompare_vect
addq	$0x20, %r8
vmovdqu	(%rsi,%r8), %ymm0
vmovdqu	(%rcx,%r8), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@310.miscompare_vect
addq	$0x20, %r8
cmpq	%rdx, %r8
jle	..@310.loop1
..@310._by_32:
addq	$0x20, %rdx
cmpq	%rdx, %r8
jg	..@310._by_16
vmovdqu	(%rsi,%r8), %ymm0
vmovdqu	(%rcx,%r8), %ymm1
vpcmpeqb	%ymm1, %ymm0, %ymm0
vpmovmskb	%ymm0, %r13d
xorl	$-0x1, %r13d
jne	..@310.miscompare_vect
addq	$0x20, %r8
..@310._by_16:
addq	$0x10, %rdx
cmpq	%rdx, %r8
jg	..@310._by_8
vmovdqu	(%rsi,%r8), %xmm0
vmovdqu	(%rcx,%r8), %xmm1
vpcmpeqb	%xmm1, %xmm0, %xmm0
vpmovmskb	%xmm0, %r13d
xorl	$0xffff, %r13d
jne	..@310.miscompare_vect
addq	$0x10, %r8
..@310._by_8:
addq	$0x8, %rdx
cmpq	%rdx, %r8
jg	..@310._cmp_last
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@310.miscompare_reg
addq	$0x8, %r8
..@310._cmp_last:
addq	$0x8, %rdx
cmpq	%rdx, %r8
je	..@310.end
leaq	-0x8(%rdx), %r8
movq	(%rsi,%r8), %r13
xorq	(%rcx,%r8), %r13
jne	..@310.miscompare_reg
addq	$0x8, %r8
jmp	..@310.end
..@310.miscompare_reg:
bsfq	%r13, %r13
shrq	$0x3, %r13
addq	%r13, %r8
jmp	..@310.end
..@310.miscompare_vect:
tzcntq	%r13, %r13
addq	%r13, %r8
..@310.end:
movzbq	%al, %rsi
shrq	$0x8, %rax
incl	0x8f8(%r14,%rsi,4)
cmpq	$0x102, %r8
jle	isal_deflate_icf_body_hash_hist_04.len_dist_lit_huffman
cmpq	$0x108, %r8
jge	isal_deflate_icf_body_hash_hist_04.do_emit2
movl	$0x102, %r8d
jmp	isal_deflate_icf_body_hash_hist_04.len_dist_lit_huffman
isal_deflate_icf_body_hash_hist_04.do_emit2:
orq	$0x7800, %rsi
movl	%esi, (%r11)
addq	$0x4, %r11
incq	%r10
movq	%r12, %rbx
movq	%r8, %rdx
isal_deflate_icf_body_hash_hist_04.do_emit:
negq	%rbx
cmpq	$0x1, %rbx
jg	..@311.do_compute
movq	%rbx, %r12
jmp	..@311.done
..@311.do_compute:
bsrq	%rbx, %rcx
decq	%rcx
bzhiq	%rcx, %rbx, %r12
shrxq	%rcx, %rbx, %rbx
leaq	(%rbx,%rcx,2), %rbx
shlq	$0x9, %r12
addq	%rbx, %r12
..@311.done:
shlq	$0xa, %r12
movl	$0x200, %r8d
orq	%r12, %r8
movq	%r12, %rsi
shrq	$0xa, %rsi
andq	$0x1f, %rsi
leaq	0x1(%r10), %r13
decq	%r10
movw	%r13w, 0x1268(%r14,%rbp,2)
addq	$0x1, %r13
movw	%r13w, 0x1268(%r14,%r9,2)
isal_deflate_icf_body_hash_hist_04.emit:
subq	$0x102, %rdx
addq	$0x102, %r10
incl	0x10f8(%r14)
incl	0x880(%r14,%rsi,4)
movl	%r8d, (%r11)
addq	$0x4, %r11
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_04.output_end
cmpq	$0x108, %rdx
jge	isal_deflate_icf_body_hash_hist_04.emit
movl	$0x102, %r8d
cmpq	%r8, %rdx
cmovgq	%r8, %rdx
addq	%rdx, %r10
leaq	0xfe(%rdx), %rdx
orq	%rdx, %r12
incl	0x8f8(%r14,%rdx,4)
incl	0x880(%r14,%rsi,4)
movl	%r12d, (%r11)
addq	$0x4, %r11
cmpq	%r10, %r15
jle	isal_deflate_icf_body_hash_hist_04.input_end
leaq	-0x4(%r10), %rcx
movl	0x18(%rsp), %ebx
movl	(%rdi,%rcx), %eax
movl	0x1(%rdi,%rcx), %r8d
movl	0x2(%rdi,%rcx), %r13d
movl	0x3(%rdi,%rcx), %esi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
xorl	%r9d, %r9d
crc32l	%r8d, %r9d
xorl	%edx, %edx
crc32l	%r13d, %edx
xorl	%r12d, %r12d
crc32l	%esi, %r12d
andl	%ebx, %ebp
andl	%ebx, %r9d
andl	%ebx, %edx
andl	%ebx, %r12d
movw	%cx, 0x1268(%r14,%rbp,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%r9,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%rdx,2)
addq	$0x1, %rcx
movw	%cx, 0x1268(%r14,%r12,2)
vmovdqu	(%rdi,%r10), %xmm4
movq	(%rdi,%r10), %rax
movq	%rax, %rsi
xorl	%ebp, %ebp
crc32l	%eax, %ebp
shrq	$0x8, %rsi
xorl	%r9d, %r9d
crc32l	%esi, %r9d
andq	%rbx, %rbp
andq	%rbx, %r9
jmp	isal_deflate_icf_body_hash_hist_04.loop2
isal_deflate_icf_body_hash_hist_04.write_first_byte:
movl	0x18(%rsp), %r8d
cmpq	(%rsp), %r11
ja	isal_deflate_icf_body_hash_hist_04.output_end
movb	$0x1, 0x87(%r13)
movw	%r10w, 0x1268(%r14,%rbp,2)
movq	%r9, %rbp
shrq	$0x10, %rcx
xorl	%r9d, %r9d
crc32l	%ecx, %r9d
andq	$0xff, %rax
incl	0x8f8(%r14,%rax,4)
orq	$0x7800, %rax
movl	%eax, (%r11)
addq	$0x4, %r11
vmovdqu	0x1(%rdi,%r10), %xmm4
addq	$0x1, %r10
movq	(%rdi,%r10), %rax
andl	%r8d, %ebp
andl	%r8d, %r9d
cmpq	%r15, %r10
jl	isal_deflate_icf_body_hash_hist_04.loop2
jmp	isal_deflate_icf_body_hash_hist_04.input_end
	.section .rodata_in_text
min_lit_dist_syms:
	.size min_lit_dist_syms, 4
	.byte 0,124,0,0
low_lit_shuf:
	.size low_lit_shuf, 16
	.byte 0,255,255,255,2,255,255,255,4,255,255,255,6,255,255,255
up_lit_shuf:
	.size up_lit_shuf, 16
	.byte 1,255,255,255,3,255,255,255,5,255,255,255,7,255,255,255

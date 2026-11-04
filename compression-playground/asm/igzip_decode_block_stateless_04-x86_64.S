	.text
decode_huffman_code_block_stateless_04:
endbr64
subq	$0x60, %rsp
movq	%rbx, 0x20(%rsp)
movq	%rbp, 0x28(%rsp)
movq	%r12, 0x30(%rsp)
movq	%r13, 0x38(%rsp)
movq	%r14, 0x40(%rsp)
movq	%r15, 0x48(%rsp)
movq	%rdi, %r11
movq	%rsi, (%rsp)
leaq	rfc1951_lookup_table(%rip), %r15
movq	0x18(%r11), %r9
movl	0x24(%r11), %r10d
movq	(%r11), %r12
movl	0x8(%r11), %r13d
addq	%r12, %r13
movq	0x10(%r11), %rbx
movl	0x20(%r11), %ebp
addq	%rbx, %rbp
movl	$0x0, 0x52cc(%r11)
movl	$0x0, 0x52d0(%r11)
subq	$0x112, %r13
subq	$0x8, %rbp
cmpq	%rbp, %rbx
jg	end_loop_block_pre
cmpq	$0x40, %r10
je	..@35.end
shlxq	%r10, (%rbx), %rdi
orq	%rdi, %r9
movl	$0x40, %edi
subq	%r10, %rdi
shrq	$0x3, %rdi
addq	%rdi, %rbx
leaq	(%r10,%rdi,8), %r10
..@35.end:
skip_load:
movq	%r9, %rax
andq	$0xfff, %rax
movl	0x28(%r11,%rax,4), %r14d
loop_block:
cmpq	%rbp, %rbx
jg	end_loop_block_pre
cmpq	%r13, %r12
jg	end_loop_block_pre
movq	%r14, %rsi
movq	%r14, %rcx
shrq	$0x1c, %rcx
je	invalid_symbol
andq	$0xc000000, %rsi
shrq	$0x1a, %rsi
andq	$0x3ffffff, %r14
testq	$0x2000000, %r14
je	..@37.end
shlq	$0x2, %rcx
orq	%rsi, %rcx
movq	%r9, %rdi
shrq	$0xc, %rdi
subq	$0x4c, %rcx
andq	$0x1f, %rcx
bzhiq	%rcx, %rdi, %rdi
andq	$0x1ffffff, %r14
addq	%rdi, %r14
movzwq	0x4028(%r11,%r14,2), %r14
movl	$0x1, %esi
movq	%r14, %rcx
shrq	$0xa, %rcx
je	invalid_symbol
andq	$0x3ff, %r14
..@37.end:
shrxq	%rcx, %r9, %r9
subq	%rcx, %r10
movq	%r14, (%r12)
addq	%rsi, %r12
leaq	-0x8(,%rsi,8), %rdx
shrxq	%rdx, %r14, %rdx
movl	$0xfff, %eax
andq	%r9, %rax
movq	(%rbx), %rdi
shlxq	%r10, %rdi, %rdi
orq	%rdi, %r9
leaq	-0xfe(%rdx), %r8
cmpq	$0x100, %rdx
je	end_symbol_pre
movl	0x28(%r11,%rax,4), %r14d
movl	$0x40, %edi
subq	%r10, %rdi
shrq	$0x3, %rdi
addq	%rdi, %rbx
leaq	(%r10,%rdi,8), %r10
movl	$0x3ff, %edi
andq	%r9, %rdi
movzwq	0x4a08(%r11,%rdi,2), %rdi
cmpq	$0x100, %rdx
jl	loop_block
decode_len_dist:
leaq	-0x1(%r12,%r8), %r12
movq	%rdi, %rcx
shrq	$0xb, %rcx
je	invalid_dist_symbol_rdi
andq	$0x5ff, %rdi
testq	$0x400, %rdi
je	..@42.end
movq	%r9, %rsi
shrq	$0xa, %rsi
leaq	(%r11,%rdi,2), %rdi
subq	$0x4a, %rcx
andq	$0x1f, %rcx
bzhiq	%rcx, %rsi, %rsi
movzwq	0x4a08(%rdi,%rsi,2), %rdi
movq	%rdi, %rcx
shrq	$0xa, %rcx
je	invalid_dist_symbol_rdi
andq	$0x1ff, %rdi
..@42.end:
shrxq	%rcx, %r9, %r9
subq	%rcx, %r10
movq	%rdi, %rcx
shrq	$0x5, %rcx
andq	$0x1f, %rdi
movl	0x128(%r15,%rdi,4), %edi
movq	%r9, %rsi
bzhiq	%rcx, %rsi, %rsi
shrxq	%rcx, %r9, %r9
movl	$0xfff, %eax
andq	%r9, %rax
movl	0x28(%r11,%rax,4), %r14d
subq	%rcx, %r10
addq	%rsi, %rdi
movq	%r12, %rdx
subq	%r8, %rdx
subq	%rdi, %rdx
cmpq	(%rsp), %rdx
jl	invalid_look_back_distance
vmovdqu	(%rdx), %xmm1
movl	$0x10, %esi
cmpq	%r8, %rsi
cmovgq	%r8, %rsi
cmpq	%rsi, %rdi
jl	small_byte_copy_pre
large_byte_copy:
vmovdqu	%xmm1, (%rdx,%rdi)
subq	$0x10, %r8
jle	loop_block
addq	$0x10, %rdx
vmovdqu	(%rdx), %xmm1
jmp	large_byte_copy
small_byte_copy_pre:
addq	%rdi, %r8
small_byte_copy:
vmovdqu	%xmm1, (%rdx,%rdi)
shlq	%rdi
vmovdqu	(%rdx), %xmm1
cmpq	$0x10, %rdi
jl	small_byte_copy
subq	%rdi, %r8
jge	large_byte_copy
jmp	loop_block
end_loop_block_pre:
addq	$0x112, %r13
addq	$0x8, %rbp
end_loop_block:
movq	%rbp, %rdi
subq	%rbx, %rdi
movq	%r10, %rcx
movl	$0x40, %esi
subq	%r10, %rsi
shrq	$0x3, %rsi
cmpq	%rdi, %rsi
cmovgq	%rdi, %rsi
cmpq	$0x0, %rsi
je	..@52.end
..@52.load_byte:
xorq	%rdi, %rdi
movb	(%rbx), %dil
shlxq	%rcx, %rdi, %rdi
orq	%rdi, %r9
addq	$0x8, %rcx
addq	$0x1, %rbx
subq	$0x1, %rsi
jg	..@52.load_byte
movq	%rcx, %r10
..@52.end:
movq	%r9, 0x8(%rsp)
movq	%r10, 0x10(%rsp)
movq	%r12, 0x18(%rsp)
movq	%r9, %rdi
andq	$0xfff, %rdi
movl	0x28(%r11,%rdi,4), %r14d
movq	%r14, %rsi
movq	%r14, %rcx
shrq	$0x1c, %rcx
je	invalid_symbol
andq	$0xc000000, %rsi
shrq	$0x1a, %rsi
andq	$0x3ffffff, %r14
testq	$0x2000000, %r14
je	..@55.end
shlq	$0x2, %rcx
orq	%rsi, %rcx
movq	%r9, %rdi
shrq	$0xc, %rdi
subq	$0x4c, %rcx
andq	$0x1f, %rcx
bzhiq	%rcx, %rdi, %rdi
andq	$0x1ffffff, %r14
addq	%rdi, %r14
movzwq	0x4028(%r11,%r14,2), %r14
movl	$0x1, %esi
movq	%r14, %rcx
shrq	$0xa, %rcx
je	invalid_symbol
andq	$0x3ff, %r14
..@55.end:
shrxq	%rcx, %r9, %r9
subq	%rcx, %r10
cmpq	$0x0, %r10
jl	end_of_input
multi_symbol_start:
cmpq	$0x1, %rsi
jg	decode_literal
cmpq	$0x100, %r14
jl	decode_literal
je	end_symbol
decode_len_dist_2:
leaq	-0xfe(%r14), %r8
movq	%r9, %rdi
andq	$0x3ff, %rdi
movzwq	0x4a08(%r11,%rdi,2), %r14
movq	%r14, %rcx
shrq	$0xb, %rcx
je	invalid_dist_symbol_r14
andq	$0x5ff, %r14
testq	$0x400, %r14
je	..@59.end
movq	%r9, %rdi
shrq	$0xa, %rdi
leaq	(%r11,%r14,2), %r14
subq	$0x4a, %rcx
andq	$0x1f, %rcx
bzhiq	%rcx, %rdi, %rdi
movzwq	0x4a08(%r14,%rdi,2), %r14
movq	%r14, %rcx
shrq	$0xa, %rcx
je	invalid_dist_symbol_r14
andq	$0x1ff, %r14
..@59.end:
shrxq	%rcx, %r9, %r9
subq	%rcx, %r10
movq	%r14, %rcx
shrq	$0x5, %rcx
andq	$0x1f, %r14
movq	%r9, %rsi
movl	0x128(%r15,%r14,4), %eax
bzhiq	%rcx, %rsi, %rsi
shrxq	%rcx, %r9, %r9
addq	%rsi, %rax
subq	%rcx, %r10
jl	end_of_input
movq	%r12, %rsi
movq	%rsi, %rdi
movq	%r8, %rcx
subq	%rax, %rsi
cmpq	(%rsp), %rsi
jl	invalid_look_back_distance
addq	%r12, %r8
cmpq	%r13, %r8
jg	out_buffer_overflow_repeat
movq	%r8, %r12
rep	movsb	(%rsi), %es:(%rdi)
jmp	end_loop_block
decode_literal:
cmpq	%r13, %r12
jge	out_buffer_overflow_lit
addq	$0x1, %r12
movb	%r14b, -0x1(%r12)
subq	$0x1, %rsi
je	end_loop_block
shrq	$0x8, %r14
jmp	multi_symbol_start
end_of_input:
movq	0x8(%rsp), %r9
movq	0x10(%rsp), %r10
movq	0x18(%rsp), %r12
xorq	%rdi, %rdi
movl	%edi, 0x52c4(%r11)
movl	%edi, 0x52c8(%r11)
movl	$0x1, %eax
jmp	end
out_buffer_overflow_repeat:
movq	%r13, %rcx
subq	%r12, %rcx
subq	%rcx, %r8
subq	%r12, %r8
rep	movsb	(%rsi), %es:(%rdi)
movl	%r8d, 0x52cc(%r11)
movl	%eax, 0x52d0(%r11)
movq	%r13, %r12
movl	$0x2, %eax
jmp	end
out_buffer_overflow_lit:
movl	%r14d, 0x52c4(%r11)
movl	%esi, 0x52c8(%r11)
subq	$0x1, %rsi
shlq	$0x3, %rsi
shrxq	%rsi, %r14, %r14
movl	$0x2, %eax
shrq	$0x3, %rsi
cmpq	$0x100, %r14
jl	end
movl	%esi, 0x52c8(%r11)
jg	decode_len_dist_2
jmp	end_state
invalid_look_back_distance:
movq	$-0x3, %rax
jmp	end
invalid_dist_symbol_r14:
cmpq	%r14, %r10
jl	end_of_input
jmp	invalid_symbol
invalid_dist_symbol_rdi:
cmpq	%rdi, %r10
jl	end_of_input
invalid_symbol:
movq	$-0x2, %rax
jmp	end
end_symbol_pre:
subq	$0x1, %r12
addq	$0x112, %r13
addq	$0x8, %rbp
end_symbol:
xorq	%rax, %rax
end_state:
movb	$0x0, 0x52a8(%r11)
cmpl	$0x0, 0x52b0(%r11)
je	end
movb	$0x4, 0x52a8(%r11)
end:
movq	%r9, 0x18(%r11)
movl	%r10d, 0x24(%r11)
subq	%r12, %r13
movl	%r13d, 0x8(%r11)
movq	%r12, %rdi
subq	(%r11), %rdi
addl	%edi, 0xc(%r11)
movq	%r12, (%r11)
movq	%rbx, 0x10(%r11)
subq	%rbx, %rbp
movl	%ebp, 0x20(%r11)
movq	0x20(%rsp), %rbx
movq	0x28(%rsp), %rbp
movq	0x30(%rsp), %r12
movq	0x38(%rsp), %r13
movq	0x40(%rsp), %r14
movq	0x48(%rsp), %r15
addq	$0x60, %rsp
retq
# ---- rfc1951_lookup.S, for rfc1951_lookup_table
	.text
	.text
	.section .data
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

	.text
isal_deflate_icf_finish_hash_hist_01:
endbr64
pushq	%rbx
pushq	%rsi
pushq	%rdi
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x28, %rsp
movq	%rdi, %rsi
movl	0x4c(%rsi), %ecx
movl	0x50(%rsi), %edx
movq	0x30(%rsi), %r9
movq	0x1250(%r9), %r8
movq	%r8, 0x10(%rsp)
movq	0x1258(%r9), %rax
addq	%r8, %rax
subq	$0x4, %rax
movq	%rcx, 0x18(%rsp)
movq	%rdx, 0x20(%rsp)
movq	%rax, 0x8(%rsp)
movq	0x20(%rsi), %r15
movq	(%rsi), %r13
movl	0xc(%rsi), %edi
subq	%rdi, %r13
movl	0x8(%rsi), %r12d
addq	%rdi, %r12
subq	$0x3, %r12
movq	%r12, (%rsp)
cmpq	%r12, %rdi
jge	isal_deflate_icf_finish_hash_hist_01.end_loop_2
movl	(%r13,%rdi), %eax
cmpb	$0x0, 0x87(%rsi)
jne	isal_deflate_icf_finish_hash_hist_01.skip_write_first_byte
cmpq	0x8(%rsp), %r8
ja	isal_deflate_icf_finish_hash_hist_01.end_loop_2
movl	0x20(%rsp), %ebp
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebp, %ecx
movw	%di, 0x1268(%r9,%rcx,2)
movb	$0x1, 0x87(%rsi)
jmp	isal_deflate_icf_finish_hash_hist_01.encode_literal
isal_deflate_icf_finish_hash_hist_01.skip_write_first_byte:
isal_deflate_icf_finish_hash_hist_01.loop2:
movl	0x18(%rsp), %edx
movl	0x20(%rsp), %ebp
cmpq	0x8(%rsp), %r8
ja	isal_deflate_icf_finish_hash_hist_01.end_loop_2
movl	(%r13,%rdi), %eax
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebp, %ecx
movzwl	0x1268(%r9,%rcx,2), %ebx
movw	%di, 0x1268(%r9,%rcx,2)
movl	%edi, %r10d
subl	%ebx, %r10d
andl	$0xffff, %r10d
movl	%r10d, %eax
subl	$0x1, %eax
cmpl	%edx, %eax
jae	isal_deflate_icf_finish_hash_hist_01.encode_literal
movq	(%rsp), %rbx
subq	%rdi, %rbx
addq	$0x3, %rbx
cmpq	$0x102, %rbx
cmovgq	c258(%rip), %rbx
leaq	(%r13,%rdi), %rax
movq	%rax, %rcx
subq	%r10, %rcx
xorq	%r14, %r14
subq	$0x7, %rbx
jle	..@83.lab2
..@83.loop1:
movq	(%rax,%r14), %rdx
xorq	(%rcx,%r14), %rdx
jne	..@83.miscompare
addq	$0x8, %r14
subq	$0x8, %rbx
jg	..@83.loop1
..@83.lab2:
addq	$0x7, %rbx
jle	..@83.end
..@83.loop3:
movb	(%rax,%r14), %dl
cmpb	(%rcx,%r14), %dl
jne	..@83.end
incq	%r14
decq	%rbx
jg	..@83.loop3
jmp	..@83.end
..@83.miscompare:
bsfq	%rdx, %rdx
shrq	$0x3, %rdx
addq	%rdx, %r14
..@83.end:
cmpq	$0x4, %r14
jb	isal_deflate_icf_finish_hash_hist_01.encode_literal
decq	%r10
cmpq	$0x1, %r10
jg	..@84.do_compute
movq	%r10, %r12
jmp	..@84.done
..@84.do_compute:
bsrq	%r10, %rcx
decq	%rcx
movl	$0x1, %edx
shlq	%cl, %rdx
subq	$0x1, %rdx
movq	%r10, %r12
andq	%rdx, %r12
shrq	%cl, %r10
leaq	(%r10,%rcx,2), %r10
shlq	$0x9, %r12
addq	%r10, %r12
..@84.done:
shlq	$0xa, %r12
leaq	0xfe(%r14), %rbx
movl	0x20(%rsp), %r10d
orq	%rbx, %r12
incl	0x8f8(%r9,%rbx,4)
leaq	0x1(%rdi), %rdx
addq	%r14, %rdi
cmpq	(%rsp), %rdi
jae	isal_deflate_icf_finish_hash_hist_01.skip_hash_update
movl	(%r13,%rdx), %ebx
xorl	%ecx, %ecx
crc32l	%ebx, %ecx
andl	%r10d, %ecx
movw	%dx, 0x1268(%r9,%rcx,2)
addq	$0x1, %rdx
movl	(%r13,%rdx), %ebx
xorl	%ecx, %ecx
crc32l	%ebx, %ecx
andl	%r10d, %ecx
movw	%dx, 0x1268(%r9,%rcx,2)
isal_deflate_icf_finish_hash_hist_01.skip_hash_update:
movl	%r12d, (%r8)
addq	$0x4, %r8
shrq	$0xa, %r12
andq	$0x1f, %r12
incl	0x880(%r9,%r12,4)
cmpq	(%rsp), %rdi
jl	isal_deflate_icf_finish_hash_hist_01.skip_write_first_byte
jmp	isal_deflate_icf_finish_hash_hist_01.end_loop_2
isal_deflate_icf_finish_hash_hist_01.encode_literal:
movzbq	(%r13,%rdi), %rbx
incl	0x8f8(%r9,%rbx,4)
orq	$0x7800, %rbx
movl	%ebx, (%r8)
addq	$0x4, %r8
addq	$0x1, %rdi
cmpq	(%rsp), %rdi
jl	isal_deflate_icf_finish_hash_hist_01.skip_write_first_byte
isal_deflate_icf_finish_hash_hist_01.end_loop_2:
movq	(%rsp), %r12
addq	$0x3, %r12
movq	%r12, (%rsp)
cmpq	%r12, %rdi
jge	isal_deflate_icf_finish_hash_hist_01.input_end
xorq	%rbx, %rbx
isal_deflate_icf_finish_hash_hist_01.final_bytes:
cmpq	0x8(%rsp), %r8
ja	isal_deflate_icf_finish_hash_hist_01.out_end
movzbq	(%r13,%rdi), %rbx
incl	0x8f8(%r9,%rbx,4)
orq	$0x7800, %rbx
movl	%ebx, (%r8)
addq	$0x4, %r8
incq	%rdi
cmpq	(%rsp), %rdi
jl	isal_deflate_icf_finish_hash_hist_01.final_bytes
isal_deflate_icf_finish_hash_hist_01.input_end:
cmpw	$0x0, 0x38(%rsi)
jne	isal_deflate_icf_finish_hash_hist_01.out_end
cmpw	$0x0, 0x3a(%rsi)
jne	isal_deflate_icf_finish_hash_hist_01.out_end
jmp	isal_deflate_icf_finish_hash_hist_01.end
isal_deflate_icf_finish_hash_hist_01.out_end:
movl	$0x2, 0x54(%rsi)
isal_deflate_icf_finish_hash_hist_01.end:
movq	(%rsp), %r12
movl	%edi, 0xc(%rsi)
movl	%edi, 0x48(%rsi)
addq	%rdi, %r13
movq	%r13, (%rsi)
subq	%rdi, %r12
movl	%r12d, 0x8(%rsi)
movq	%r8, 0x1250(%r9)
subq	0x10(%rsp), %r8
subq	%r8, 0x1258(%r9)
addq	$0x28, %rsp
popq	%r15
popq	%r14
popq	%r13
popq	%r12
popq	%rbp
popq	%rdi
popq	%rsi
popq	%rbx
retq
	.section .data
	.p2align 2
c258:
	.byte 2,1,0,0,0,0,0,0

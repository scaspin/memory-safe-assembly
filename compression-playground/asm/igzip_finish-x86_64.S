	.text
isal_deflate_finish_01:
endbr64
pushq	%rbx
pushq	%rsi
pushq	%rdi
pushq	%rbp
pushq	%r12
pushq	%r13
pushq	%r14
pushq	%r15
subq	$0x8, %rsp
movq	%rdi, %rcx
movq	%rcx, %rsi
movq	0x10(%rsi), %r8
movq	%r8, 0x78(%rsi)
movl	0x18(%rsi), %eax
addq	%r8, %rax
subq	$0x8, %rax
skip_SLOP:
movq	%rax, 0x70(%rsi)
movq	0x58(%rsi), %r9
movl	0x60(%rsi), %r11d
movq	0x20(%rsi), %r15
movq	(%rsi), %r13
movl	0xc(%rsi), %edi
subq	%rdi, %r13
movl	0x8(%rsi), %r12d
addq	%rdi, %r12
subq	$0x3, %r12
movq	%r12, (%rsp)
cmpq	%r12, %rdi
jge	end_loop_2
movl	(%r13,%rdi), %eax
cmpb	$0x0, 0x87(%rsi)
jne	skip_write_first_byte
cmpq	0x70(%rsi), %r8
ja	end_loop_2
movl	0x50(%rsi), %ebp
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebp, %ecx
movw	%di, 0x101d0(%rsi,%rcx,2)
movb	$0x1, 0x87(%rsi)
jmp	encode_literal
skip_write_first_byte:
loop2:
movl	0x4c(%rsi), %edx
movl	0x50(%rsi), %ebp
cmpq	0x70(%rsi), %r8
ja	end_loop_2
movl	(%r13,%rdi), %eax
xorl	%ecx, %ecx
crc32l	%eax, %ecx
andl	%ebp, %ecx
movzwl	0x101d0(%rsi,%rcx,2), %ebx
movw	%di, 0x101d0(%rsi,%rcx,2)
movl	%edi, %r10d
subl	%ebx, %r10d
andl	$0xffff, %r10d
movl	%r10d, %eax
subl	$0x1, %eax
cmpl	%edx, %eax
jae	encode_literal
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
jb	encode_literal
decq	%r10
cmpq	$0x1, %r10
jg	..@84.do_compute
movl	0x150(%r15,%r10,4), %ebp
movq	%rbp, %r12
andq	$0x1f, %rbp
shrq	$0x5, %r12
jmp	..@84.done
..@84.do_compute:
bsrq	%r10, %rcx
decq	%rcx
movl	$0x1, %ebp
shlq	%cl, %rbp
subq	$0x1, %rbp
movq	%r10, %r12
andq	%rbp, %r12
shrq	%cl, %r10
leaq	(%r10,%rcx,2), %r10
movq	%rcx, %rbp
movzbq	0x898(%r10,%r15), %rcx
movzwq	0x85c(%r15,%r10,2), %r10
shlq	%cl, %r12
orq	%r10, %r12
addq	%rcx, %rbp
..@84.done:
movl	0x14c(%r15,%r14,4), %ecx
movl	%ecx, %ebx
andl	$0x1f, %ecx
shrl	$0x5, %ebx
movl	0x50(%rsi), %r10d
shlq	%cl, %r12
orq	%rbx, %r12
addq	%rcx, %rbp
leaq	0x1(%rdi), %rdx
addq	%r14, %rdi
cmpq	(%rsp), %rdi
jae	skip_hash_update
movl	(%r13,%rdx), %ebx
xorl	%ecx, %ecx
crc32l	%ebx, %ecx
andl	%r10d, %ecx
movw	%dx, 0x101d0(%rsi,%rcx,2)
addq	$0x1, %rdx
movl	(%r13,%rdx), %ebx
xorl	%ecx, %ecx
crc32l	%ebx, %ecx
andl	%r10d, %ecx
movw	%dx, 0x101d0(%rsi,%rcx,2)
skip_hash_update:
movq	%r11, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rbp, %r11
movq	%r9, (%r8)
movq	%r11, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r8
shlq	$0x3, %rcx
andq	$0x7, %r11
shrq	%cl, %r9
cmpq	(%rsp), %rdi
jl	skip_write_first_byte
jmp	end_loop_2
encode_literal:
movzbq	(%r13,%rdi), %rbx
movzbl	0x75a(%r15,%rbx), %ebp
movzwl	0x558(%r15,%rbx,2), %r12d
movq	%r11, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rbp, %r11
movq	%r9, (%r8)
movq	%r11, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r8
shlq	$0x3, %rcx
andq	$0x7, %r11
shrq	%cl, %r9
addq	$0x1, %rdi
cmpq	(%rsp), %rdi
jl	skip_write_first_byte
end_loop_2:
movq	(%rsp), %r12
addq	$0x3, %r12
movq	%r12, (%rsp)
cmpq	%r12, %rdi
jge	write_eob
xorq	%rbx, %rbx
final_bytes:
cmpq	0x70(%rsi), %r8
ja	not_end
movzbq	(%r13,%rdi), %rbx
movzbl	0x75a(%r15,%rbx), %ebp
movzwl	0x558(%r15,%rbx,2), %r12d
movq	%r11, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rbp, %r11
movq	%r9, (%r8)
movq	%r11, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r8
shlq	$0x3, %rcx
andq	$0x7, %r11
shrq	%cl, %r9
incq	%rdi
cmpq	(%rsp), %rdi
jl	final_bytes
write_eob:
cmpq	0x70(%rsi), %r8
ja	not_end
movzbl	0x85a(%r15), %ebp
movzwl	0x758(%r15), %r12d
movq	%r11, %rcx
shlq	%cl, %r12
orq	%r12, %r9
addq	%rbp, %r11
movq	%r9, (%r8)
movq	%r11, %rcx
shrq	$0x3, %rcx
addq	%rcx, %r8
shlq	$0x3, %rcx
andq	$0x7, %r11
shrq	%cl, %r9
movb	$0x1, 0x86(%rsi)
cmpw	$0x1, 0x38(%rsi)
jne	sync_flush
movl	$0xa, 0x54(%rsi)
jmp	not_end
sync_flush:
movl	$0x8, 0x54(%rsi)
not_end:
movq	(%rsp), %r12
movl	%edi, 0xc(%rsi)
addq	%rdi, %r13
movq	%r13, (%rsi)
subq	%rdi, %r12
movl	%r12d, 0x8(%rsi)
movq	%r8, 0x10(%rsi)
subq	0x78(%rsi), %r8
subl	%r8d, 0x18(%rsi)
addl	%r8d, 0x1c(%rsi)
movq	%r9, 0x58(%rsi)
movl	%r11d, 0x60(%rsi)
addq	$0x8, %rsp
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

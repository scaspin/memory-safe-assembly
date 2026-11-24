	.text
isal_deflate_hash_crc_01:
endbr64
pushq	%r12
negq	%r8
addq	%rdx, %r8
subq	%r8, %rcx
subq	$0x8, %rdx
cmpq	%rdx, %r8
jg	end_main
main_loop:
leaq	0x2(%r8), %rax
xorq	%r9, %r9
crc32l	(%r8,%rcx), %r9d
xorq	%r10, %r10
crc32l	0x1(%r8,%rcx), %r10d
xorq	%r11, %r11
crc32l	(%rax,%rcx), %r11d
xorq	%r12, %r12
crc32l	0x1(%rax,%rcx), %r12d
andq	%rsi, %r9
andq	%rsi, %r10
andq	%rsi, %r11
andq	%rsi, %r12
movw	%r8w, (%rdi,%r9,2)
addq	$0x1, %r8
movw	%r8w, (%rdi,%r10,2)
addq	$0x3, %r8
movw	%ax, (%rdi,%r11,2)
addq	$0x1, %rax
movw	%ax, (%rdi,%r12,2)
cmpq	%rdx, %r8
jle	main_loop
end_main:
addq	$0x4, %rdx
cmpq	%rdx, %r8
jg	end
end_loop:
xorq	%r9, %r9
crc32l	(%r8,%rcx), %r9d
andq	%rsi, %r9
movw	%r8w, (%rdi,%r9,2)
addq	$0x1, %r8
cmpq	%rdx, %r8
jle	end_loop
end:
popq	%r12
retq

	.text
mem_zero_detect_sse:
endbr64
movl	$0x0, %eax
subq	$0x40, %rsi
jle	mem_zero_detect_sse.mem_z_small_block
mem_zero_detect_sse.mem_z_loop:
movdqu	(%rdi,%rax), %xmm0
movdqu	0x10(%rdi,%rax), %xmm1
movdqu	0x20(%rdi,%rax), %xmm2
movdqu	0x30(%rdi,%rax), %xmm3
ptest	%xmm0, %xmm0
jne	mem_zero_detect_sse.return_fail
ptest	%xmm1, %xmm1
jne	mem_zero_detect_sse.return_fail
ptest	%xmm2, %xmm2
jne	mem_zero_detect_sse.return_fail
ptest	%xmm3, %xmm3
jne	mem_zero_detect_sse.return_fail
addq	$0x40, %rax
cmpq	%rsi, %rax
jl	mem_zero_detect_sse.mem_z_loop
mem_zero_detect_sse.mem_z_last_block:
movdqu	(%rdi,%rsi), %xmm0
movdqu	0x10(%rdi,%rsi), %xmm1
movdqu	0x20(%rdi,%rsi), %xmm2
movdqu	0x30(%rdi,%rsi), %xmm3
ptest	%xmm0, %xmm0
jne	mem_zero_detect_sse.return_fail
ptest	%xmm1, %xmm1
jne	mem_zero_detect_sse.return_fail
ptest	%xmm2, %xmm2
jne	mem_zero_detect_sse.return_fail
ptest	%xmm3, %xmm3
jne	mem_zero_detect_sse.return_fail
mem_zero_detect_sse.return_pass:
movl	$0x0, %eax
retq
mem_zero_detect_sse.mem_z_small_block:
addq	$0x40, %rsi
cmpq	$0x20, %rsi
jl	mem_zero_detect_sse.mem_z_lt32
movdqu	(%rdi), %xmm0
movdqu	0x10(%rdi), %xmm1
movdqu	-0x20(%rdi,%rsi), %xmm2
movdqu	-0x10(%rdi,%rsi), %xmm3
ptest	%xmm0, %xmm0
jne	mem_zero_detect_sse.return_fail
ptest	%xmm1, %xmm1
jne	mem_zero_detect_sse.return_fail
ptest	%xmm2, %xmm2
jne	mem_zero_detect_sse.return_fail
ptest	%xmm3, %xmm3
jne	mem_zero_detect_sse.return_fail
jmp	mem_zero_detect_sse.return_pass
mem_zero_detect_sse.mem_z_lt32:
cmpq	$0x10, %rsi
jl	mem_zero_detect_sse.mem_z_lt16
movdqu	(%rdi), %xmm0
movdqu	-0x10(%rdi,%rsi), %xmm1
ptest	%xmm0, %xmm0
jne	mem_zero_detect_sse.return_fail
ptest	%xmm1, %xmm1
jne	mem_zero_detect_sse.return_fail
jmp	mem_zero_detect_sse.return_pass
mem_zero_detect_sse.mem_z_lt16:
cmpq	$0x8, %rsi
jl	mem_zero_detect_sse.mem_z_lt8
movq	(%rdi), %r11
movq	-0x8(%rdi,%rsi), %r8
orq	%r8, %r11
testq	%r11, %r11
jne	mem_zero_detect_sse.return_fail
jmp	mem_zero_detect_sse.return_pass
mem_zero_detect_sse.mem_z_lt8:
cmpq	$0x0, %rsi
je	mem_zero_detect_sse.return_pass
mem_zero_detect_sse.mem_z_1byte_loop:
movb	(%rdi,%rax), %r11b
cmpb	$0x0, %r11b
jne	mem_zero_detect_sse.return_fail
addq	$0x1, %rax
cmpq	%rsi, %rax
jl	mem_zero_detect_sse.mem_z_1byte_loop
jmp	mem_zero_detect_sse.return_pass
mem_zero_detect_sse.return_fail:
movl	$0x1, %eax
retq

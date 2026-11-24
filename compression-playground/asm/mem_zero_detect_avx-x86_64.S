	.text
mem_zero_detect_avx:
endbr64
movl	$0x0, %eax
subq	$0x80, %rsi
jle	mem_zero_detect_avx.mem_z_small_block
mem_zero_detect_avx.mem_z_loop:
vmovdqu	(%rdi,%rax), %ymm0
vmovdqu	0x20(%rdi,%rax), %ymm1
vmovdqu	0x40(%rdi,%rax), %ymm2
vmovdqu	0x60(%rdi,%rax), %ymm3
vptest	%ymm0, %ymm0
jne	mem_zero_detect_avx.return_fail
vptest	%ymm1, %ymm1
jne	mem_zero_detect_avx.return_fail
vptest	%ymm2, %ymm2
jne	mem_zero_detect_avx.return_fail
vptest	%ymm3, %ymm3
jne	mem_zero_detect_avx.return_fail
addq	$0x80, %rax
cmpq	%rsi, %rax
jl	mem_zero_detect_avx.mem_z_loop
mem_zero_detect_avx.mem_z_last_block:
vmovdqu	(%rdi,%rsi), %ymm0
vmovdqu	0x20(%rdi,%rsi), %ymm1
vmovdqu	0x40(%rdi,%rsi), %ymm2
vmovdqu	0x60(%rdi,%rsi), %ymm3
vptest	%ymm0, %ymm0
jne	mem_zero_detect_avx.return_fail
vptest	%ymm1, %ymm1
jne	mem_zero_detect_avx.return_fail
vptest	%ymm2, %ymm2
jne	mem_zero_detect_avx.return_fail
vptest	%ymm3, %ymm3
jne	mem_zero_detect_avx.return_fail
mem_zero_detect_avx.return_pass:
movl	$0x0, %eax
retq
mem_zero_detect_avx.mem_z_small_block:
addq	$0x80, %rsi
cmpq	$0x40, %rsi
jl	mem_zero_detect_avx.mem_z_lt64
vmovdqu	(%rdi), %ymm0
vmovdqu	0x20(%rdi), %ymm1
vmovdqu	-0x40(%rdi,%rsi), %ymm2
vmovdqu	-0x20(%rdi,%rsi), %ymm3
vptest	%ymm0, %ymm0
jne	mem_zero_detect_avx.return_fail
vptest	%ymm1, %ymm1
jne	mem_zero_detect_avx.return_fail
vptest	%ymm2, %ymm2
jne	mem_zero_detect_avx.return_fail
vptest	%ymm3, %ymm3
jne	mem_zero_detect_avx.return_fail
jmp	mem_zero_detect_avx.return_pass
mem_zero_detect_avx.mem_z_lt64:
cmpq	$0x20, %rsi
jl	mem_zero_detect_avx.mem_z_lt32
vmovdqu	(%rdi), %ymm0
vmovdqu	-0x20(%rdi,%rsi), %ymm1
vptest	%ymm0, %ymm0
jne	mem_zero_detect_avx.return_fail
vptest	%ymm1, %ymm1
jne	mem_zero_detect_avx.return_fail
jmp	mem_zero_detect_avx.return_pass
mem_zero_detect_avx.mem_z_lt32:
cmpq	$0x10, %rsi
jl	mem_zero_detect_avx.mem_z_lt16
vmovdqu	(%rdi), %xmm0
vmovdqu	-0x10(%rdi,%rsi), %xmm1
vptest	%xmm0, %xmm0
jne	mem_zero_detect_avx.return_fail
vptest	%xmm1, %xmm1
jne	mem_zero_detect_avx.return_fail
jmp	mem_zero_detect_avx.return_pass
mem_zero_detect_avx.mem_z_lt16:
cmpq	$0x8, %rsi
jl	mem_zero_detect_avx.mem_z_lt8
movq	(%rdi), %r11
movq	-0x8(%rdi,%rsi), %r8
orq	%r8, %r11
testq	%r11, %r11
jne	mem_zero_detect_avx.return_fail
jmp	mem_zero_detect_avx.return_pass
mem_zero_detect_avx.mem_z_lt8:
cmpq	$0x0, %rsi
je	mem_zero_detect_avx.return_pass
mem_zero_detect_avx.mem_z_1byte_loop:
movb	(%rdi,%rax), %r11b
cmpb	$0x0, %r11b
jne	mem_zero_detect_avx.return_fail
addq	$0x1, %rax
cmpq	%rsi, %rax
jl	mem_zero_detect_avx.mem_z_1byte_loop
jmp	mem_zero_detect_avx.return_pass
mem_zero_detect_avx.return_fail:
movl	$0x1, %eax
retq

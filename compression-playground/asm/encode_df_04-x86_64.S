	.text
encode_deflate_icf_04:
endbr64
subq	$0xd8, %rsp
movq	%rbx, (%rsp)
movq	%rbp, 0x8(%rsp)
movq	%r12, 0x10(%rsp)
movq	%rcx, %r11
movq	%rdx, 0xd0(%rsp)
movq	(%rdx), %rax
movl	0x8(%rdx), %ecx
movq	0x18(%rdx), %rbp
movq	0x10(%rdx), %rdx
subq	$0x18, %rbp
subq	$0x40, %rsi
cmpq	%rsi, %rdi
jge	encode_deflate_icf_04.finish
vpcmpeqq	%ymm9, %ymm9, %ymm9
vmovdqu	(%rdi), %ymm12
vpand	lit_mask(%rip), %ymm12, %ymm7
vpgatherdd	%ymm9, 0x7c(%r11,%ymm7,4), %ymm10
vpcmpeqq	%ymm9, %ymm9, %ymm9
vpsrld	$0xa, %ymm12, %ymm8
vpand	dist_mask(%rip), %ymm8, %ymm8
vpgatherdd	%ymm9, (%r11,%ymm8,4), %ymm11
vmovq	%rax, %xmm13
vmovq	%rcx, %xmm14
vmovdqa	offset_mask(%rip), %ymm15
encode_deflate_icf_04.main_loop:
vpsrld	$0x18, %ymm10, %ymm2
vpand	lit_icr_mask(%rip), %ymm10, %ymm1
vpblendw	$0x55, %ymm11, %ymm13, %ymm3
vpsrld	$0x18, %ymm11, %ymm4
vpsrld	$0x10, %ymm11, %ymm6
vpand	eb_icr_mask(%rip), %ymm6, %ymm6
vpsrld	$0x13, %ymm12, %ymm5
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.main_loop_exit
addq	$0x20, %rdi
vpcmpeqq	%ymm9, %ymm9, %ymm9
vmovdqu	(%rdi), %ymm12
vpand	lit_mask(%rip), %ymm12, %ymm7
vpgatherdd	%ymm9, 0x7c(%r11,%ymm7,4), %ymm10
vpcmpeqq	%ymm9, %ymm9, %ymm9
vpsrld	$0xa, %ymm12, %ymm8
vpand	dist_mask(%rip), %ymm8, %ymm8
vpgatherdd	%ymm9, (%r11,%ymm8,4), %ymm11
vpsllvd	%ymm4, %ymm5, %ymm5
vpxor	%ymm5, %ymm3, %ymm3
vpaddd	%ymm6, %ymm4, %ymm4
vpaddd	%ymm4, %ymm2, %ymm6
vpcmpgtd	max_write_d(%rip), %ymm6, %ymm9
vptest	%ymm9, %ymm9
jne	encode_deflate_icf_04.long_codes
vpsllvd	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm1, %ymm1
vpblendd	$0x55, %ymm1, %ymm9, %ymm5
vpsrlq	$0x20, %ymm1, %ymm1
vpsrlq	$0x20, %ymm6, %ymm2
vpblendd	$0x55, %ymm6, %ymm9, %ymm6
vpsllvq	%ymm14, %ymm5, %ymm5
vpxor	%ymm13, %ymm5, %ymm5
vpaddq	%ymm14, %ymm6, %ymm6
vpsllvq	%ymm6, %ymm1, %ymm1
vpxor	%ymm5, %ymm1, %ymm1
vpaddq	%ymm6, %ymm2, %ymm2
vpblendd	$0x33, %ymm1, %ymm9, %ymm3
vpblendd	$0x33, %ymm2, %ymm9, %ymm4
vpsrldq	$0x8, %ymm1, %ymm1
vpsrldq	$0x8, %ymm2, %ymm2
vpaddq	%ymm4, %ymm2, %ymm2
vpand	%ymm15, %ymm2, %ymm14
vpermq	$0xcf, %ymm14, %ymm14
vpaddq	%ymm14, %ymm4, %ymm4
vpsllvq	%ymm14, %ymm3, %ymm3
vmovdqa	q_64(%rip), %ymm9
vpsubq	%ymm4, %ymm9, %ymm6
vpsrlvq	%ymm6, %ymm1, %ymm5
vpslldq	$0x8, %ymm5, %ymm5
vpsllvq	%ymm4, %ymm1, %ymm1
vpxor	%ymm5, %ymm1, %ymm1
vpxor	%ymm3, %ymm1, %ymm1
vmovq	%xmm2, %rbx
shrq	$0x3, %rbx
vpaddq	%ymm14, %ymm2, %ymm4
vpsrlq	$0x3, %ymm4, %ymm4
vpshufb	%ymm4, %ymm1, %ymm3
vpand	bytes_mask(%rip), %ymm3, %ymm3
vextracti128	$0x1, %ymm3, %xmm13
vptest	min_write_mask(%rip), %ymm4
je	encode_deflate_icf_04.short_codes
encode_deflate_icf_04.short_codes_next:
vpermq	$0x45, %ymm3, %ymm3
vpor	%ymm3, %ymm1, %ymm1
vextracti128	$0x1, %ymm2, %xmm4
vmovdqu	%ymm1, (%rdx)
vpaddq	%ymm4, %ymm2, %ymm2
vmovq	%xmm2, %r10
shrq	$0x3, %r10
vpand	%ymm15, %ymm2, %ymm14
vextracti128	$0x1, %ymm1, (%rdx,%rbx)
addq	%r10, %rdx
cmpq	%rsi, %rdi
jbe	encode_deflate_icf_04.main_loop
encode_deflate_icf_04.main_loop_exit:
vmovq	%xmm14, %rcx
vmovq	%xmm13, %rax
jmp	encode_deflate_icf_04.finish
encode_deflate_icf_04.short_codes:
vpor	%xmm3, %xmm13, %xmm13
jmp	encode_deflate_icf_04.short_codes_next
encode_deflate_icf_04.long_codes:
addq	$0x18, %rbp
subq	$0x20, %rdi
vpxor	%ymm9, %ymm9, %ymm9
vpblendd	$0x55, %ymm1, %ymm9, %ymm5
vpblendd	$0x55, %ymm2, %ymm9, %ymm6
vpblendd	$0x55, %ymm3, %ymm9, %ymm7
vpsllvq	%ymm6, %ymm7, %ymm7
vpxor	%ymm7, %ymm5, %ymm5
vpaddd	%ymm4, %ymm2, %ymm6
vpsrlq	$0x20, %ymm1, %ymm1
vpsrlq	$0x20, %ymm2, %ymm2
vpsrlq	$0x20, %ymm3, %ymm3
vpsllvq	%ymm2, %ymm3, %ymm3
vpxor	%ymm3, %ymm1, %ymm1
vpsrlq	$0x20, %ymm6, %ymm2
vpblendd	$0x55, %ymm6, %ymm9, %ymm6
vpsllvq	%ymm14, %ymm5, %ymm5
vpxor	%ymm13, %ymm5, %ymm5
vpaddq	%ymm14, %ymm6, %ymm6
vpaddq	%ymm6, %ymm2, %ymm2
xorq	%rax, %rax
xorq	%rcx, %rcx
vpsubq	%ymm6, %ymm2, %ymm2
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vmovq	%xmm5, %r9
vmovq	%xmm6, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vmovq	%xmm1, %r9
vmovq	%xmm2, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vpextrq	$0x1, %xmm5, %r9
vpextrq	$0x1, %xmm6, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vpextrq	$0x1, %xmm1, %r9
vpextrq	$0x1, %xmm2, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
vextracti128	$0x1, %ymm5, %xmm5
vextracti128	$0x1, %ymm6, %xmm6
vextracti128	$0x1, %ymm1, %xmm1
vextracti128	$0x1, %ymm2, %xmm2
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vmovq	%xmm5, %r9
vmovq	%xmm6, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vmovq	%xmm1, %r9
vmovq	%xmm2, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vpextrq	$0x1, %xmm5, %r9
vpextrq	$0x1, %xmm6, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
vpextrq	$0x1, %xmm1, %r9
vpextrq	$0x1, %xmm2, %r10
shlxq	%rcx, %r9, %r9
orq	%r9, %rax
addq	%r10, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
addq	$0x4, %rdi
vextracti128	$0x1, %ymm5, %xmm5
vextracti128	$0x1, %ymm6, %xmm6
vextracti128	$0x1, %ymm1, %xmm1
vextracti128	$0x1, %ymm2, %xmm2
subq	$0x18, %rbp
vmovq	%rax, %xmm13
vmovq	%rcx, %xmm14
cmpq	%rsi, %rdi
jbe	encode_deflate_icf_04.main_loop
encode_deflate_icf_04.finish:
addq	$0x40, %rsi
addq	$0x18, %rbp
cmpq	%rsi, %rdi
jge	encode_deflate_icf_04.overflow
encode_deflate_icf_04.finish_loop:
movl	(%rdi), %r12d
cmpq	%rbp, %rdx
ja	encode_deflate_icf_04.overflow
movq	%r12, %r9
andq	$0x3ff, %r9
movl	0x7c(%r11,%r9,4), %r9d
movq	%r12, %r8
shrq	$0xa, %r8
andq	$0x1ff, %r8
movl	(%r11,%r8,4), %r8d
movq	%r9, %r10
andq	$0xffffff, %r9
shlxq	%rcx, %r9, %r9
shrq	$0x18, %r10
orq	%r9, %rax
addq	%r10, %rcx
movzwq	%r8w, %rbx
shlxq	%rcx, %rbx, %rbx
orq	%rbx, %rax
movq	%r8, %rbx
shrq	$0x18, %rbx
addq	%rbx, %rcx
shrq	$0x13, %r12
addq	$0x4, %rdi
shlxq	%rcx, %r12, %r12
orq	%r12, %rax
shrq	$0x10, %r8
andq	$0xff, %r8
addq	%r8, %rcx
movq	%rax, (%rdx)
movq	%rcx, %rbx
shrq	$0x3, %rbx
addq	%rbx, %rdx
movq	%rcx, %rbx
andq	$-0x8, %rcx
shrxq	%rcx, %rax, %rax
movq	%rbx, %rcx
andq	$0x7, %rcx
cmpq	%rsi, %rdi
jb	encode_deflate_icf_04.finish_loop
encode_deflate_icf_04.overflow:
movq	0xd0(%rsp), %rbx
movq	%rax, (%rbx)
movl	%ecx, 0x8(%rbx)
movq	%rdx, 0x10(%rbx)
movq	%rdi, %rax
movq	(%rsp), %rbx
movq	0x8(%rsp), %rbp
movq	0x10(%rsp), %r12
addq	$0xd8, %rsp
retq
	.section .data
	.p2align 5
max_write_d:
	.byte 28,0,0,0,29,0,0,0,31,0,0,0,32,0,0,0
	.byte 28,0,0,0,29,0,0,0,31,0,0,0,32,0,0,0
min_write_mask:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
offset_mask:
	.byte 7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
q_64:
	.byte 64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lit_mask:
	.byte 255,3,0,0,255,3,0,0,255,3,0,0,255,3,0,0
	.byte 255,3,0,0,255,3,0,0,255,3,0,0,255,3,0,0
dist_mask:
	.byte 255,1,0,0,255,1,0,0,255,1,0,0,255,1,0,0
	.byte 255,1,0,0,255,1,0,0,255,1,0,0,255,1,0,0
lit_icr_mask:
	.byte 255,255,255,0,255,255,255,0,255,255,255,0,255,255,255,0
	.byte 255,255,255,0,255,255,255,0,255,255,255,0,255,255,255,0
eb_icr_mask:
	.byte 255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0
	.byte 255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0
bytes_mask:
	.byte 255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

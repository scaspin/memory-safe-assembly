	.text
encode_deflate_icf_06:
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
subq	$0x38, %rbp
subq	$0x80, %rsi
cmpq	%rsi, %rdi
jge	encode_deflate_icf_06.finish
kxorq	%k0, %k0, %k0
kmovq	k_mask_1(%rip), %k1
kmovq	k_mask_2(%rip), %k2
kmovq	k_mask_3(%rip), %k3
kmovq	k_mask_4(%rip), %k4
kmovq	k_mask_5(%rip), %k5
vmovdqa64	rot_perm(%rip), %zmm21
vbroadcasti64x2	q_64(%rip), %zmm15
vbroadcasti64x2	q_8(%rip), %zmm22
vpbroadcastq	offset_mask(%rip), %zmm14
vpternlogd	$0x55, %zmm14, %zmm23, %zmm23
vpbroadcastd	lit_mask(%rip), %zmm16
vpbroadcastd	dist_mask(%rip), %zmm17
vpbroadcastd	lit_icr_mask(%rip), %zmm18
vpbroadcastd	eb_icr_mask(%rip), %zmm19
vpbroadcastd	max_write_d(%rip), %zmm20
knotq	%k0, %k6
vmovdqu64	(%rdi), %zmm11
vpandd	%zmm16, %zmm11, %zmm7
vpgatherdd	0x7c(%r11,%zmm7,4), %zmm9 {%k6}
knotq	%k0, %k7
vpsrld	$0xa, %zmm11, %zmm8
vpandd	%zmm17, %zmm8, %zmm8
vpgatherdd	(%r11,%zmm8,4), %zmm10 {%k7}
vmovq	%rax, %xmm12
vmovq	%rcx, %xmm13
encode_deflate_icf_06.main_loop:
vpsrld	$0x18, %zmm9, %zmm2
vpandd	%zmm18, %zmm9, %zmm1
vmovdqu16	%zmm10, %zmm3 {%k1} {z}
vpsrld	$0x18, %zmm10, %zmm4
vpsrld	$0x10, %zmm10, %zmm6
vpandd	%zmm19, %zmm6, %zmm6
vpsrld	$0x13, %zmm11, %zmm5
cmpq	%rbp, %rdx
ja	encode_deflate_icf_06.main_loop_exit
knotq	%k0, %k6
addq	$0x40, %rdi
vmovdqu64	(%rdi), %zmm11
vpandd	%zmm16, %zmm11, %zmm7
vpgatherdd	0x7c(%r11,%zmm7,4), %zmm9 {%k6}
knotq	%k0, %k7
vpsrld	$0xa, %zmm11, %zmm8
vpandd	%zmm17, %zmm8, %zmm8
vpgatherdd	(%r11,%zmm8,4), %zmm10 {%k7}
vpsllvd	%zmm4, %zmm5, %zmm5
vpxord	%zmm5, %zmm3, %zmm3
vpaddd	%zmm6, %zmm4, %zmm4
vpaddd	%zmm4, %zmm2, %zmm6
vpcmpgtd	%zmm20, %zmm6, %k6
ktestd	%k6, %k6
jne	encode_deflate_icf_06.long_codes
vpsllvd	%zmm2, %zmm3, %zmm3
vpxord	%zmm3, %zmm1, %zmm1
vmovdqa32	%zmm1, %zmm5 {%k1} {z}
vpsrlq	$0x20, %zmm1, %zmm1
vpsrlq	$0x20, %zmm6, %zmm2
vmovdqa32	%zmm6, %zmm6 {%k1} {z}
vpsllvq	%zmm13, %zmm5, %zmm5
vpxord	%zmm12, %zmm5, %zmm5
vpaddq	%zmm13, %zmm6, %zmm6
vpsllvq	%zmm6, %zmm1, %zmm1
vpxord	%zmm5, %zmm1, %zmm1
vpaddq	%zmm6, %zmm2, %zmm2
vpermq	%zmm2, %zmm21, %zmm13 {%k5} {z}
vpaddq	%zmm2, %zmm13, %zmm4
vshufi64x2	$0x90, %zmm4, %zmm4, %zmm13 {%k3} {z}
vpaddq	%zmm13, %zmm4, %zmm4
vshufi64x2	$0x40, %zmm4, %zmm4, %zmm13 {%k2} {z}
vpaddq	%zmm13, %zmm4, %zmm4
vpandd	%zmm14, %zmm4, %zmm13
vpermq	%zmm13, %zmm21, %zmm8 {%k5} {z}
vpsllvq	%zmm8, %zmm1, %zmm1
vpcmpltq	%zmm13, %zmm2, %k6 {%k5}
vpsrlq	$0x3, %zmm4, %zmm4
vpaddq	%zmm8, %zmm2, %zmm2
vpandq	%zmm23, %zmm2, %zmm2
vpsrlvq	%zmm2, %zmm1, %zmm5
ktestd	%k6, %k6
jne	encode_deflate_icf_06.small_codes
encode_deflate_icf_06.small_codes_next:
knotq	%k5, %k7
vpermq	%zmm5, %zmm21, %zmm12 {%k7} {z}
vpermq	%zmm13, %zmm21, %zmm13 {%k7} {z}
vpermq	%zmm5, %zmm21, %zmm5 {%k5} {z}
vpxord	%zmm5, %zmm1, %zmm1
vextracti64x2	$0x3, %zmm4, %xmm2
vpextrq	$0x1, %xmm2, %r10
knotq	%k0, %k6
vpermq	%zmm4, %zmm21, %zmm4 {%k5} {z}
vpscatterqq	%zmm1, (%rdx,%zmm4) {%k6}
addq	%r10, %rdx
cmpq	%rsi, %rdi
jbe	encode_deflate_icf_06.main_loop
encode_deflate_icf_06.main_loop_exit:
vmovq	%xmm13, %rcx
vmovq	%xmm12, %rax
jmp	encode_deflate_icf_06.finish
encode_deflate_icf_06.small_codes:
vpermq	%zmm5, %zmm21, %zmm7 {%k6} {z}
vporq	%zmm7, %zmm5, %zmm5
kshiftlq	$0x1, %k6, %k7
ktestd	%k7, %k6
je	encode_deflate_icf_06.small_codes_next
kandq	%k7, %k6, %k6
jmp	encode_deflate_icf_06.small_codes
encode_deflate_icf_06.long_codes:
addq	$0x38, %rbp
subq	$0x40, %rdi
vmovdqa32	%zmm1, %zmm5 {%k1} {z}
vmovdqa32	%zmm2, %zmm6 {%k1} {z}
vmovdqa32	%zmm3, %zmm7 {%k1} {z}
vpsllvq	%zmm6, %zmm7, %zmm7
vpxord	%zmm7, %zmm5, %zmm5
vpaddd	%zmm4, %zmm2, %zmm6
vpsrlq	$0x20, %zmm1, %zmm1
vpsrlq	$0x20, %zmm2, %zmm2
vpsrlq	$0x20, %zmm3, %zmm3
vpsllvq	%zmm2, %zmm3, %zmm3
vpxord	%zmm3, %zmm1, %zmm1
vpsrlq	$0x20, %zmm6, %zmm2
vmovdqa32	%zmm6, %zmm6 {%k1} {z}
vpsllvq	%zmm13, %zmm5, %zmm5
vpxord	%zmm12, %zmm5, %zmm5
vpaddq	%zmm13, %zmm6, %zmm6
vpaddq	%zmm6, %zmm2, %zmm2
xorq	%rax, %rax
xorq	%rcx, %rcx
vpsubq	%zmm6, %zmm2, %zmm2
vmovdqu64	%zmm1, %zmm3
vmovdqu64	%zmm2, %zmm4
vmovdqu64	%zmm5, %zmm7
vmovdqu64	%zmm6, %zmm8
cmpq	%rbp, %rdx
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
vextracti32x4	$0x1, %zmm7, %xmm5
vextracti32x4	$0x1, %zmm8, %xmm6
vextracti32x4	$0x1, %zmm3, %xmm1
vextracti32x4	$0x1, %zmm4, %xmm2
cmpq	%rbp, %rdx
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
vextracti32x4	$0x2, %zmm7, %xmm5
vextracti32x4	$0x2, %zmm8, %xmm6
vextracti32x4	$0x2, %zmm3, %xmm1
vextracti32x4	$0x2, %zmm4, %xmm2
cmpq	%rbp, %rdx
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
vextracti32x4	$0x3, %zmm7, %xmm5
vextracti32x4	$0x3, %zmm8, %xmm6
vextracti32x4	$0x3, %zmm3, %xmm1
vextracti32x4	$0x3, %zmm4, %xmm2
cmpq	%rbp, %rdx
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
ja	encode_deflate_icf_06.overflow
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
vextracti32x4	$0x4, %zmm7, %xmm5
vextracti32x4	$0x4, %zmm8, %xmm6
vextracti32x4	$0x4, %zmm3, %xmm1
vextracti32x4	$0x4, %zmm4, %xmm2
subq	$0x38, %rbp
vmovq	%rax, %xmm12
vmovq	%rcx, %xmm13
cmpq	%rsi, %rdi
jbe	encode_deflate_icf_06.main_loop
encode_deflate_icf_06.finish:
addq	$0x80, %rsi
addq	$0x38, %rbp
cmpq	%rsi, %rdi
jge	encode_deflate_icf_06.overflow
encode_deflate_icf_06.finish_loop:
movl	(%rdi), %r12d
cmpq	%rbp, %rdx
ja	encode_deflate_icf_06.overflow
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
jb	encode_deflate_icf_06.finish_loop
encode_deflate_icf_06.overflow:
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
	.p2align 6
rot_perm:
	.byte 7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	.byte 3,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0
	.byte 5,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0
q_64:
	.byte 64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
q_8:
	.byte 0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0
offset_mask:
	.byte 7,0,0,0,0,0,0,0
max_write_d:
	.byte 28,0,0,0
lit_mask:
	.byte 255,3,0,0
dist_mask:
	.byte 255,1,0,0
lit_icr_mask:
	.byte 255,255,255,0
eb_icr_mask:
	.byte 255,0,0,0
k_mask_1:
	.byte 85,85,85,85,0,0,0,0
k_mask_2:
	.byte 240,255,255,255,0,0,0,0
k_mask_3:
	.byte 252,255,255,255,0,0,0,0
k_mask_4:
	.byte 1,1,1,1,1,1,1,1
k_mask_5:
	.byte 254,255,255,255,0,0,0,0

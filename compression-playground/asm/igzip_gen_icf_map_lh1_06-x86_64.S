	.text
gen_icf_map_lh1_06:
endbr64
endbr64
pushq	%rbp
pushq	%r12
pushq	%r13
movq	(%rdi), %rbp
movl	0xc(%rdi), %eax
movq	%rax, %r13
subq	%rax, %rbp
addq	%rax, %rdx
cmpq	%rdx, %rax
jge	end_main
vpbroadcastd	0x4c(%rdi), %zmm18
vpbroadcastd	0x50(%rdi), %zmm26
movq	%rdi, %r9
movq	0x30(%rdi), %rdi
subq	$0x120, %rdx
vmovdqu64	datas_perm(%rip), %zmm21
vbroadcasti32x8	datas_shuf(%rip), %zmm24
vpbroadcastd	hash_prod(%rip), %zmm25
vmovdqu64	increment(%rip), %zmm27
vmovdqu64	qword_shuf(%rip), %zmm28
vbroadcasti64x2	datas_perm2(%rip), %zmm22
vbroadcasti64x2	datas_perm3(%rip), %zmm23
vpbroadcastd	ones(%rip), %zmm29
vbroadcasti32x4	bswap_shuf(%rip), %zmm31
vpbroadcastd	thirty(%rip), %zmm17
vmovdqu64	drot_left(%rip), %zmm20
vpbroadcastd	shortest_matches(%rip), %zmm19
vpbroadcastd	twofiftyfour(%rip), %zmm30
vpbroadcastd	null_dist_syms(%rip), %zmm15
kxorq	%k0, %k0, %k0
kmovq	k_mask_1(%rip), %k1
kmovq	k_mask_2(%rip), %k2
vmovd	(%rax,%rbp), %xmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpandd	%zmm26, %zmm2, %zmm2
vmovd	%xmm2, %r8d
cmpb	$0x0, 0x87(%r9)
jne	gen_icf_map_lh1_06.has_hist
xorq	%r11, %r11
xorq	%r12, %r12
movb	$0x1, 0x87(%r9)
jmp	gen_icf_map_lh1_06.byte_processed
gen_icf_map_lh1_06.has_hist:
leaq	(%rax,%rbp), %rcx
xorq	%r9, %r9
movw	%ax, %r9w
decq	%r9
subw	0x1268(%rdi,%r8,2), %r9w
vmovd	%xmm18, %r10d
andl	%r10d, %r9d
negq	%r9
movq	(%rcx), %r11
xorq	-0x1(%rcx,%r9), %r11
negq	%r9
cmpq	$0x1, %r9
jg	..@77.do_compute
movq	%r9, %r12
jmp	..@77.done
..@77.do_compute:
bsrq	%r9, %rcx
decq	%rcx
bzhiq	%rcx, %r9, %r12
shrxq	%rcx, %r9, %r9
leaq	(%r9,%rcx,2), %r9
shlq	$0x9, %r12
addq	%r9, %r12
..@77.done:
shlq	$0xa, %r12
xorq	%r10, %r10
tzcntq	%r11, %r11
shrq	$0x3, %r11
cmpq	$0x3, %r11
cmovlq	%r10, %r11
gen_icf_map_lh1_06.byte_processed:
movw	%ax, 0x1268(%rdi,%r8,2)
addq	$0x1, %rax
cmpq	%rdx, %rax
jg	end_main
vmovdqu64	(%rax,%rbp), %ymm0
vpermq	%zmm0, %zmm21, %zmm2
vpshufb	%zmm24, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpandd	%zmm26, %zmm2, %zmm2
vpermq	%zmm0, %zmm22, %zmm9
vpshufb	%zmm28, %zmm9, %zmm9
vpermq	%zmm0, %zmm23, %zmm10
vpshufb	%zmm28, %zmm10, %zmm10
knotq	%k0, %k6
vpgatherdd	0x1268(%rdi,%zmm2,2), %zmm4 {%k6}
vpbroadcastd	%eax, %zmm12
vpaddd	%zmm27, %zmm12, %zmm12
vpblendmw	%zmm4, %zmm12, %zmm5 {%k1}
knotq	%k0, %k6
vpscatterdd	%zmm5, 0x1268(%rdi,%zmm2,2) {%k6}
vmovdqu64	0x10(%rax,%rbp), %ymm0
vpermq	%zmm0, %zmm21, %zmm2
vpshufb	%zmm24, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpandd	%zmm26, %zmm2, %zmm2
vmovdqu64	0x20(%rax,%rbp), %ymm1
subq	$0x10, %rdx
cmpq	%rdx, %rax
jg	gen_icf_map_lh1_06.loop1_end
gen_icf_map_lh1_06.loop1:
leaq	(%rax,%rbp), %rcx
vpaddd	%zmm29, %zmm4, %zmm3
vpsubd	%zmm3, %zmm12, %zmm3
vpandd	%zmm18, %zmm3, %zmm3
vpaddd	%zmm29, %zmm3, %zmm3
vpsubd	%zmm3, %zmm27, %zmm3
addq	$0x10, %rax
kxnorq	%k6, %k6, %k6
kxnorq	%k7, %k7, %k7
vpgatherdd	0x1268(%rdi,%zmm2,2), %zmm4 {%k6}
vpbroadcastd	%eax, %zmm12
vpaddd	%zmm27, %zmm12, %zmm12
vpblendmw	%zmm4, %zmm12, %zmm5 {%k1}
vpscatterdd	%zmm5, 0x1268(%rdi,%zmm2,2) {%k7}
vpermq	%zmm1, %zmm21, %zmm2
vpshufb	%zmm24, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpmaddwd	%zmm25, %zmm2, %zmm2
vpandd	%zmm26, %zmm2, %zmm2
vextracti32x8	$0x1, %zmm3, %ymm6
kxnorq	%k6, %k6, %k6
kxnorq	%k7, %k7, %k7
vpgatherdq	(%rcx,%ymm3), %zmm7 {%k6}
vpgatherdq	(%rcx,%ymm6), %zmm8 {%k7}
vpaddd	%zmm29, %zmm3, %zmm3
vpsubd	%zmm3, %zmm27, %zmm3
vpcmpgtd	%zmm29, %zmm3, %k5
vplzcntd	%zmm3, %zmm13
vpsubd	%zmm13, %zmm17, %zmm13 {%k5} {z}
vpsllvd	%zmm13, %zmm29, %zmm16
vpsubd	%zmm29, %zmm16, %zmm16
vpandd	%zmm16, %zmm3, %zmm16 {%k5} {z}
vpsrlvd	%zmm13, %zmm3, %zmm3
vpslld	$0x1, %zmm13, %zmm13
vpaddd	%zmm13, %zmm3, %zmm3
vpslld	$0x9, %zmm16, %zmm16
vpaddd	%zmm16, %zmm3, %zmm3
vpslld	$0xa, %zmm3, %zmm3
vpxorq	%zmm9, %zmm7, %zmm7
vpxorq	%zmm10, %zmm8, %zmm8
vpermq	%zmm0, %zmm22, %zmm9
vpshufb	%zmm28, %zmm9, %zmm9
vpermq	%zmm0, %zmm23, %zmm10
vpshufb	%zmm28, %zmm10, %zmm10
vpshufb	%zmm31, %zmm7, %zmm7
vpshufb	%zmm31, %zmm8, %zmm8
vplzcntq	%zmm7, %zmm7
vplzcntq	%zmm8, %zmm8
vpmovqd	%zmm7, %ymm7
vpmovqd	%zmm8, %ymm8
vinserti32x8	$0x1, %ymm8, %zmm7, %zmm7
vpsrld	$0x3, %zmm7, %zmm7
vmovdqu64	%zmm1, %zmm0
vmovdqu64	0x20(%rax,%rbp), %ymm1
kshiftrw	$0xf, %k1, %k3
vpermd	%zmm7, %zmm20, %zmm8
vpermd	%zmm3, %zmm20, %zmm3
vmovd	%r11d, %xmm14
vmovd	%xmm8, %r11d
vmovdqu32	%zmm14, %zmm8 {%k3}
vmovd	%r12d, %xmm14
vmovd	%xmm3, %r12d
vmovdqu32	%zmm14, %zmm3 {%k3}
vpcmpgtd	%zmm19, %zmm8, %k3
vpcmpgtd	%zmm8, %zmm7, %k4
knotq	%k3, %k3
korq	%k4, %k3, %k3
knotq	%k3, %k4
vmovdqu32	%zmm8, %zmm7 {%k4} {z}
vpaddd	%zmm7, %zmm3, %zmm3
vpaddd	%zmm30, %zmm3, %zmm3
vpmovzxbd	-0x11(%rax,%rbp), %zmm3 {%k3}
vpaddd	%zmm15, %zmm3, %zmm3 {%k3}
vmovdqu64	%zmm3, (%rsi)
addq	$0x40, %rsi
cmpq	%rdx, %rax
jle	gen_icf_map_lh1_06.loop1
gen_icf_map_lh1_06.loop1_end:
leaq	(%rax,%rbp), %rcx
vpaddd	%zmm29, %zmm4, %zmm3
vpsubd	%zmm3, %zmm12, %zmm3
vpandd	%zmm18, %zmm3, %zmm3
vpaddd	%zmm29, %zmm3, %zmm3
vpsubd	%zmm3, %zmm27, %zmm3
vextracti32x8	$0x1, %zmm3, %ymm6
kxnorq	%k6, %k6, %k6
kxnorq	%k7, %k7, %k7
vpgatherdq	(%rcx,%ymm3), %zmm7 {%k6}
vpgatherdq	(%rcx,%ymm6), %zmm8 {%k7}
vextracti32x4	$0x3, %zmm3, %xmm6
vpextrd	$0x3, %xmm6, %r9d
addl	%eax, %r9d
vmovd	0xf(%rax,%rbp), %xmm2
vpmaddwd	%xmm25, %xmm2, %xmm2
vpmaddwd	%xmm25, %xmm2, %xmm2
vpandd	%xmm26, %xmm2, %xmm2
vmovd	%xmm2, %r8d
movw	%r9w, 0x1268(%rdi,%r8,2)
vpaddd	%zmm29, %zmm3, %zmm3
vpsubd	%zmm3, %zmm27, %zmm3
vpcmpgtd	%zmm29, %zmm3, %k5
vplzcntd	%zmm3, %zmm13
vpsubd	%zmm13, %zmm17, %zmm13 {%k5} {z}
vpsllvd	%zmm13, %zmm29, %zmm16
vpsubd	%zmm29, %zmm16, %zmm16
vpandd	%zmm16, %zmm3, %zmm16 {%k5} {z}
vpsrlvd	%zmm13, %zmm3, %zmm3
vpslld	$0x1, %zmm13, %zmm13
vpaddd	%zmm13, %zmm3, %zmm3
vpslld	$0x9, %zmm16, %zmm16
vpaddd	%zmm16, %zmm3, %zmm3
vpslld	$0xa, %zmm3, %zmm3
vpxorq	%zmm9, %zmm7, %zmm7
vpxorq	%zmm10, %zmm8, %zmm8
vpshufb	%zmm31, %zmm7, %zmm7
vpshufb	%zmm31, %zmm8, %zmm8
vplzcntq	%zmm7, %zmm7
vplzcntq	%zmm8, %zmm8
vpmovqd	%zmm7, %ymm7
vpmovqd	%zmm8, %ymm8
vinserti32x8	$0x1, %ymm8, %zmm7, %zmm7
vpsrld	$0x3, %zmm7, %zmm7
kshiftrw	$0xf, %k1, %k3
vpermd	%zmm7, %zmm20, %zmm8
vpermd	%zmm3, %zmm20, %zmm3
vmovd	%r11d, %xmm14
vmovd	%xmm8, %r11d
vmovdqu32	%zmm14, %zmm8 {%k3}
vmovd	%r12d, %xmm14
vmovd	%xmm3, %r12d
vmovdqu32	%zmm14, %zmm3 {%k3}
vpcmpgtd	%zmm19, %zmm8, %k3
vpcmpgtd	%zmm8, %zmm7, %k4
knotq	%k3, %k3
korq	%k4, %k3, %k3
knotq	%k3, %k4
vmovdqu32	%zmm8, %zmm7 {%k4} {z}
vpaddd	%zmm7, %zmm3, %zmm3
vpaddd	%zmm30, %zmm3, %zmm3
vpmovzxbd	-0x1(%rax,%rbp), %zmm3 {%k3}
vpaddd	%zmm15, %zmm3, %zmm3 {%k3}
vmovdqu64	%zmm3, (%rsi)
addq	$0x10, %rax
end_main:
subq	%r13, %rax
subq	$0x1, %rax
popq	%r13
popq	%r12
popq	%rbp
retq
	.section .data
	.p2align 6
datas_perm:
	.byte 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	.byte 1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
drot_left:
	.byte 15,0,0,0,0,0,0,0,1,0,0,0,2,0,0,0
	.byte 3,0,0,0,4,0,0,0,5,0,0,0,6,0,0,0
	.byte 7,0,0,0,8,0,0,0,9,0,0,0,10,0,0,0
	.byte 11,0,0,0,12,0,0,0,13,0,0,0,14,0,0,0
qword_shuf:
	.byte 0,1,2,3,4,5,6,7,1,2,3,4,5,6,7,8
	.byte 2,3,4,5,6,7,8,9,3,4,5,6,7,8,9,10
	.byte 4,5,6,7,8,9,10,11,5,6,7,8,9,10,11,12
	.byte 6,7,8,9,10,11,12,13,7,8,9,10,11,12,13,14
	.byte 8,9,10,11,12,13,14,15
datas_shuf:
	.byte 0,1,2,3,1,2,3,4,2,3,4,5,3,4,5,6
	.byte 4,5,6,7,5,6,7,8,6,7,8,9,7,8,9,10
increment:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
	.byte 8,0,0,0,9,0,0,0,10,0,0,0,11,0,0,0
	.byte 12,0,0,0,13,0,0,0,14,0,0,0,15,0,0,0
datas_perm2:
	.byte 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
datas_perm3:
	.byte 1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
bswap_shuf:
	.byte 7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8
k_mask_1:
	.byte 170,170,170,170,170,170,170,170
k_mask_2:
	.byte 255,127,0,0,0,0,0,0
null_dist_syms:
	.byte 0,120,0,0
hash_prod:
	.byte 75,232,177,151
ones:
	.byte 1,0,0,0
thirty:
	.byte 30,0,0,0
twofiftyfour:
	.byte 254,0,0,0
lit_len_mask:
	.byte 255,3,0,0
shortest_matches:
	.byte 3,0,0,0

	.text
set_long_icf_fg_06:
endbr64
endbr64
pushq	%r12
pushq	%r13
leaq	(%rdi,%rdx), %rdx
addq	%rdi, %rsi
movq	%rsi, %r12
leaq	0x102(%rsi), %r11
cmpq	%r11, %rdx
cmovgq	%r11, %rdx
subq	$0xf, %rsi
vpbroadcastd	long_len(%rip), %zmm30
vpbroadcastd	long_len2(%rip), %zmm29
vpbroadcastd	len_mask(%rip), %zmm31
vmovdqu16	dist_start(%rip), %zmm28
vpbroadcastd	dists_mask(%rip), %zmm27
vmovdqu32	increment(%rip), %zmm26
vbroadcasti64x2	datas_perm2(%rip), %zmm25
vbroadcasti64x2	datas_perm3(%rip), %zmm24
vmovdqu64	qword_shuf(%rip), %zmm23
vbroadcasti64x2	bswap_shuf(%rip), %zmm22
vpbroadcastd	nlen_mask(%rip), %zmm21
vpbroadcastd	vect_size(%rip), %zmm16
vpbroadcastd	max_len(%rip), %zmm17
vpbroadcastd	twofiftyfour(%rip), %zmm18
vpbroadcastd	twofiftysix(%rip), %zmm19
vpbroadcastd	twosixtytwo(%rip), %zmm20
vmovdqu32	(%rcx), %zmm0
set_long_icf_fg_06.fill_loop:
vmovdqu32	%zmm0, %zmm1
vmovdqu32	0x40(%rcx), %zmm0
cmpq	%rsi, %rdi
jae	set_long_icf_fg_06.end_fill
set_long_icf_fg_06.finish_entry:
vpandd	%zmm31, %zmm1, %zmm2
vpcmpgtd	%zmm30, %zmm2, %k3
addq	$0x10, %rdi
addq	$0x40, %rcx
ktestw	%k3, %k3
je	set_long_icf_fg_06.fill_loop
vpsrld	$0xa, %zmm1, %zmm3
vpmovdw	%zmm3, %ymm5
vpermw	%zmm28, %zmm5, %zmm5
vpmovzxwd	%ymm5, %zmm5
vpsrld	$0x13, %zmm1, %zmm4
vpsubd	%zmm4, %zmm26, %zmm4
vpsubd	%zmm5, %zmm4, %zmm5
vextracti32x8	$0x1, %zmm5, %ymm6
kmovb	%k3, %k6
kshiftrw	$0x8, %k3, %k7
vpgatherdq	-0x8(%rdi,%ymm5), %zmm7 {%k6}
vpgatherdq	-0x8(%rdi,%ymm6), %zmm8 {%k7}
vmovdqu8	-0x8(%rdi), %ymm11
vpermq	%zmm11, %zmm25, %zmm9
vpshufb	%zmm23, %zmm9, %zmm9
vpermq	%zmm11, %zmm24, %zmm10
vpshufb	%zmm23, %zmm10, %zmm10
vpxorq	%zmm9, %zmm7, %zmm7
vpxorq	%zmm10, %zmm8, %zmm8
vpshufb	%zmm22, %zmm7, %zmm7
vpshufb	%zmm22, %zmm8, %zmm8
vplzcntq	%zmm7, %zmm7
vplzcntq	%zmm8, %zmm8
vpmovqd	%zmm7, %ymm7
vpmovqd	%zmm8, %ymm8
vinserti32x8	$0x1, %ymm8, %zmm7, %zmm7
vpsrld	$0x3, %zmm7, %zmm7 {%k3} {z}
vpandd	%zmm21, %zmm1, %zmm1 {%k3} {z}
vpaddd	%zmm20, %zmm1, %zmm1 {%k3} {z}
vpaddd	%zmm7, %zmm1, %zmm1 {%k3} {z}
vmovdqu32	%zmm1, -0x40(%rcx) {%k3}
vpcmpgtd	%zmm29, %zmm7, %k3
ktestw	%k3, %k3
je	set_long_icf_fg_06.fill_loop
vpsubd	%zmm5, %zmm26, %zmm5
vpcompressd	%zmm5, %zmm6 {%k3}
vpcompressd	%zmm1, %zmm1 {%k3}
kmovq	%k3, %r10
tzcntq	%r10, %r10
vmovd	%xmm6, %r9d
leaq	-0x10(%rdi,%r10), %rdi
leaq	-0x40(%rcx,%r10,4), %rcx
movq	%rdi, %rax
subq	%r9, %rax
movl	$0x10, %r8d
movq	%rdx, %r13
subq	%rdi, %r13
subq	$0x80, %r13
cmpq	%r13, %r8
jg	..@76._by_64
..@76.loop1:
vmovdqu8	(%rdi,%r8), %zmm12
vmovdqu8	(%rax,%r8), %zmm13
vpcmpneqb	%zmm13, %zmm12, %k3
ktestq	%k3, %k3
jne	..@76.miscompare
addq	$0x40, %r8
vmovdqu8	(%rdi,%r8), %zmm12
vmovdqu8	(%rax,%r8), %zmm13
vpcmpneqb	%zmm13, %zmm12, %k3
ktestq	%k3, %k3
jne	..@76.miscompare
addq	$0x40, %r8
cmpq	%r13, %r8
jle	..@76.loop1
..@76._by_64:
addq	$0x40, %r13
cmpq	%r13, %r8
jg	..@76._less_than_64
vmovdqu8	(%rdi,%r8), %zmm12
vmovdqu8	(%rax,%r8), %zmm13
vpcmpneqb	%zmm13, %zmm12, %k3
ktestq	%k3, %k3
jne	..@76.miscompare
addq	$0x40, %r8
..@76._less_than_64:
addq	$0x40, %r13
subq	%r8, %r13
jle	..@76.end
movq	$-0x1, %r11
bzhiq	%r13, %r11, %r11
kmovq	%r11, %k3
vmovdqu8	(%rdi,%r8), %zmm12 {%k3} {z}
vmovdqu8	(%rax,%r8), %zmm13 {%k3} {z}
vpcmpneqb	%zmm13, %zmm12, %k3
ktestq	%k3, %k3
jne	..@76.miscompare
addq	%r13, %r8
jmp	..@76.end
..@76.miscompare:
kmovq	%k3, %r11
tzcntq	%r11, %r11
addq	%r11, %r8
..@76.end:
vpbroadcastd	%r8d, %zmm7
vpsubd	%zmm26, %zmm7, %zmm7
vpaddd	%zmm18, %zmm7, %zmm7
movq	%rsi, %r13
subq	%rdi, %r13
cmpq	%r13, %r8
cmovgq	%r13, %r8
addq	%r8, %rdi
leaq	(%rcx,%r8,4), %rcx
vmovdqu32	(%rcx), %zmm0
vpbroadcastd	%xmm1, %zmm1
vpandd	%zmm21, %zmm1, %zmm1
negq	%r8
set_long_icf_fg_06.update_match_lookup:
vpandd	(%rcx,%r8,4), %zmm31, %zmm8
vpcmpgtd	%zmm8, %zmm7, %k3
vpcmpgtd	%zmm19, %zmm7, %k4
kandw	%k4, %k3, %k3
vpcmpgtd	%zmm17, %zmm7, %k4
vmovdqu32	%zmm7, %zmm2
vmovdqu32	%zmm17, %zmm2 {%k4}
vpaddd	%zmm1, %zmm2, %zmm8 {%k3} {z}
vmovdqu32	%zmm8, (%rcx,%r8,4) {%k3}
knotw	%k3, %k3
ktestw	%k3, %k3
jne	set_long_icf_fg_06.fill_loop
addq	$0x10, %r8
vpsubd	%zmm16, %zmm7, %zmm7
jmp	set_long_icf_fg_06.update_match_lookup
set_long_icf_fg_06.end_fill:
movq	%r12, %rsi
cmpq	%rsi, %rdi
jge	set_long_icf_fg_06.finish
movq	%rsi, %r11
subq	%rdi, %r11
vpbroadcastd	%r11d, %zmm12
vpcmpnled	%zmm26, %zmm12, %k3
vmovdqu32	%zmm1, %zmm1 {%k3} {z}
jmp	set_long_icf_fg_06.finish_entry
set_long_icf_fg_06.finish:
popq	%r13
popq	%r12
retq
	.section .data
	.p2align 6
dist_start:
	.byte 1,0,2,0,3,0,4,0,5,0,7,0,9,0,13,0
	.byte 17,0,25,0,33,0,49,0,65,0,97,0,129,0,193,0
	.byte 1,1,129,1,1,2,1,3,1,4,1,6,1,8,1,12
	.byte 1,16,1,24,1,32,1,48,1,64,1,96,0,0,0,0
qword_shuf:
	.byte 0,1,2,3,4,5,6,7,1,2,3,4,5,6,7,8
	.byte 2,3,4,5,6,7,8,9,3,4,5,6,7,8,9,10
	.byte 4,5,6,7,8,9,10,11,5,6,7,8,9,10,11,12
	.byte 6,7,8,9,10,11,12,13,7,8,9,10,11,12,13,14
	.byte 8,9,10,11,12,13,14,15
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
len_mask:
	.byte 255,3,0,0
dists_mask:
	.byte 255,1,0,0
long_len:
	.byte 5,1,0,0
long_len2:
	.byte 7,0,0,0
max_len:
	.byte 0,2,0,0
vect_size:
	.byte 16,0,0,0
twofiftyfour:
	.byte 254,0,0,0
twofiftysix:
	.byte 0,1,0,0
twosixtytwo:
	.byte 6,1,0,0
nlen_mask:
	.byte 0,252,255,255

	.text
gen_icf_map_lh1_04:
endbr64
endbr64
pushq	%rbp
pushq	%r12
pushq	%r13
subq	$0x10, %rsp
movq	(%rdi), %rbp
movl	0xc(%rdi), %eax
movq	%rax, %r13
subq	%rax, %rbp
addq	%rax, %rdx
cmpq	%rdx, %rax
jge	end_main
movl	0x4c(%rdi), %r9d
movq	%r9, (%rsp)
movl	0x50(%rdi), %r9d
movq	%r9, 0x8(%rsp)
movq	%rdi, %r9
movq	0x30(%rdi), %rdi
subq	$0x120, %rdx
vmovdqu	increment(%rip), %ymm14
vpbroadcastd	ones(%rip), %ymm12
vmovdqu	datas_perm2(%rip), %ymm13
vpbroadcastd	hash_prod(%rip), %ymm11
vpbroadcastd	0x8(%rsp), %ymm15
vmovd	(%rax,%rbp), %xmm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpand	%ymm15, %ymm2, %ymm2
vmovd	%xmm2, %r8d
cmpb	$0x0, 0x87(%r9)
jne	gen_icf_map_lh1_04.has_hist
xorq	%r11, %r11
xorq	%r12, %r12
movb	$0x1, 0x87(%r9)
jmp	gen_icf_map_lh1_04.byte_processed
gen_icf_map_lh1_04.has_hist:
leaq	(%rax,%rbp), %rcx
xorq	%r9, %r9
movw	%ax, %r9w
decq	%r9
subw	0x1268(%rdi,%r8,2), %r9w
andl	(%rsp), %r9d
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
gen_icf_map_lh1_04.byte_processed:
movw	%ax, 0x1268(%rdi,%r8,2)
addq	$0x1, %rax
vmovdqu	(%rax,%rbp), %ymm0
vpermq	$0x44, %ymm0, %ymm2
vpshufb	datas_shuf(%rip), %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpand	%ymm15, %ymm2, %ymm2
vpermq	$0x44, %ymm0, %ymm8
vmovdqu	qword_shuf(%rip), %ymm11
vpshufb	%ymm11, %ymm8, %ymm8
vpermd	%ymm0, %ymm13, %ymm9
vpshufb	%ymm11, %ymm9, %ymm9
vpcmpeqq	%ymm15, %ymm15, %ymm15
vpgatherdd	%ymm15, 0x1268(%rdi,%ymm2,2), %ymm4
vpbroadcastd	upper_word(%rip), %ymm5
vpbroadcastd	low_word(%rip), %ymm15
vmovd	%eax, %xmm10
vpbroadcastd	%xmm10, %ymm10
vpaddd	%ymm14, %ymm10, %ymm10
vpand	%ymm5, %ymm4, %ymm5
vpand	%ymm15, %ymm10, %ymm15
vpor	%ymm15, %ymm5, %ymm5
vmovd	%xmm2, %r9d
vmovd	%xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x1, %xmm2, %r9d
vpextrd	$0x1, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x2, %xmm2, %r9d
vpextrd	$0x2, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x3, %xmm2, %r9d
vpextrd	$0x3, %xmm5, 0x1268(%rdi,%r9,2)
vextracti128	$0x1, %ymm5, %xmm5
vextracti128	$0x1, %ymm2, %xmm2
vmovd	%xmm2, %r9d
vmovd	%xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x1, %xmm2, %r9d
vpextrd	$0x1, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x2, %xmm2, %r9d
vpextrd	$0x2, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x3, %xmm2, %r9d
vpextrd	$0x3, %xmm5, 0x1268(%rdi,%r9,2)
vpbroadcastd	hash_prod(%rip), %ymm11
vpbroadcastd	0x8(%rsp), %ymm15
vmovdqu	0x8(%rax,%rbp), %ymm0
vpermq	$0x44, %ymm0, %ymm2
vpshufb	datas_shuf(%rip), %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpand	%ymm15, %ymm2, %ymm2
vmovdqu	0x10(%rax,%rbp), %ymm1
subq	$0x8, %rdx
cmpq	%rdx, %rax
jg	gen_icf_map_lh1_04.loop1_end
gen_icf_map_lh1_04.loop1:
leaq	(%rax,%rbp), %rcx
vpbroadcastd	(%rsp), %ymm15
vpaddd	%ymm12, %ymm4, %ymm3
vpsubd	%ymm3, %ymm10, %ymm3
vpand	%ymm15, %ymm3, %ymm3
vpaddd	%ymm12, %ymm3, %ymm3
vpsubd	%ymm3, %ymm14, %ymm3
addq	$0x8, %rax
vpcmpeqq	%ymm15, %ymm15, %ymm15
vpgatherdd	%ymm15, 0x1268(%rdi,%ymm2,2), %ymm4
vpbroadcastd	upper_word(%rip), %ymm5
vpbroadcastd	low_word(%rip), %ymm15
vmovd	%eax, %xmm10
vpbroadcastd	%xmm10, %ymm10
vpaddd	%ymm14, %ymm10, %ymm10
vpand	%ymm5, %ymm4, %ymm5
vpand	%ymm15, %ymm10, %ymm15
vpor	%ymm15, %ymm5, %ymm5
vmovd	%xmm2, %r9d
vmovd	%xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x1, %xmm2, %r9d
vpextrd	$0x1, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x2, %xmm2, %r9d
vpextrd	$0x2, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x3, %xmm2, %r9d
vpextrd	$0x3, %xmm5, 0x1268(%rdi,%r9,2)
vextracti128	$0x1, %ymm5, %xmm5
vextracti128	$0x1, %ymm2, %xmm2
vmovd	%xmm2, %r9d
vmovd	%xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x1, %xmm2, %r9d
vpextrd	$0x1, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x2, %xmm2, %r9d
vpextrd	$0x2, %xmm5, 0x1268(%rdi,%r9,2)
vpextrd	$0x3, %xmm2, %r9d
vpextrd	$0x3, %xmm5, 0x1268(%rdi,%r9,2)
vpbroadcastd	hash_prod(%rip), %ymm11
vpbroadcastd	0x8(%rsp), %ymm15
vpermq	$0x44, %ymm1, %ymm2
vpshufb	datas_shuf(%rip), %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpmaddwd	%ymm11, %ymm2, %ymm2
vpand	%ymm15, %ymm2, %ymm2
vextracti128	$0x1, %ymm3, %xmm5
vpcmpeqq	%ymm15, %ymm15, %ymm15
vpgatherdq	%ymm15, (%rcx,%xmm3), %ymm6
vpcmpeqq	%ymm15, %ymm15, %ymm15
vpgatherdq	%ymm15, (%rcx,%xmm5), %ymm7
vpaddd	%ymm12, %ymm3, %ymm3
vpsubd	%ymm3, %ymm14, %ymm3
vpbroadcastd	low_nibble(%rip), %ymm5
vbroadcasti128	nibble_order(%rip), %ymm11
vpslld	$0xc, %ymm3, %ymm15
vpor	%ymm15, %ymm3, %ymm15
vpand	%ymm5, %ymm15, %ymm15
vpshufb	%ymm11, %ymm15, %ymm15
vbroadcasti128	bit_index(%rip), %ymm5
vpshufb	%ymm15, %ymm5, %ymm15
vpxor	%ymm5, %ymm5, %ymm5
vpcmpgtb	%ymm5, %ymm15, %ymm5
vpsrld	$0x8, %ymm5, %ymm11
vpandn	%ymm5, %ymm11, %ymm5
vpsrld	$0x10, %ymm5, %ymm11
vpandn	%ymm5, %ymm11, %ymm5
vpsrld	$0x18, %ymm5, %ymm11
vpandn	%ymm5, %ymm11, %ymm5
vpbroadcastd	base_offset(%rip), %ymm11
vpaddb	%ymm11, %ymm15, %ymm15
vpand	%ymm5, %ymm15, %ymm15
vpsrlq	$0x20, %ymm15, %ymm5
vpxor	%ymm11, %ymm11, %ymm11
vpsadbw	%ymm11, %ymm15, %ymm15
vpsadbw	%ymm11, %ymm5, %ymm5
vpsubd	%ymm5, %ymm15, %ymm15
vpsllq	$0x20, %ymm5, %ymm5
vpor	%ymm5, %ymm15, %ymm15
vpcmpgtb	%ymm11, %ymm15, %ymm11
vpand	%ymm11, %ymm15, %ymm15
vpsllvd	%ymm15, %ymm12, %ymm11
vpsubd	%ymm12, %ymm11, %ymm11
vpcmpgtd	%ymm12, %ymm3, %ymm5
vpand	%ymm11, %ymm3, %ymm11
vpand	%ymm5, %ymm11, %ymm11
vpsrlvd	%ymm15, %ymm3, %ymm3
vpslld	$0x1, %ymm15, %ymm15
vpaddd	%ymm15, %ymm3, %ymm3
vpslld	$0x9, %ymm11, %ymm11
vpaddd	%ymm11, %ymm3, %ymm3
vpslld	$0xa, %ymm3, %ymm3
vpxor	%ymm8, %ymm6, %ymm6
vpxor	%ymm9, %ymm7, %ymm7
vpermq	$0x44, %ymm0, %ymm8
vmovdqu	qword_shuf(%rip), %ymm11
vpshufb	%ymm11, %ymm8, %ymm8
vpermd	%ymm0, %ymm13, %ymm9
vpshufb	%ymm11, %ymm9, %ymm9
vpxor	%ymm15, %ymm15, %ymm15
vpcmpeqb	%ymm15, %ymm6, %ymm6
vpcmpeqb	%ymm15, %ymm7, %ymm7
vpbroadcastq	shift_finish(%rip), %ymm11
vpand	%ymm11, %ymm6, %ymm6
vpand	%ymm11, %ymm7, %ymm7
vpsadbw	%ymm15, %ymm6, %ymm6
vpsadbw	%ymm15, %ymm7, %ymm7
vmovdqu	downconvert_qd(%rip), %ymm5
vpshufb	%ymm5, %ymm6, %ymm6
vextracti128	$0x1, %ymm6, %xmm15
vpor	%ymm15, %ymm6, %ymm6
vpshufb	%ymm5, %ymm7, %ymm7
vextracti128	$0x1, %ymm7, %xmm15
vpor	%ymm15, %ymm7, %ymm7
vinserti128	$0x1, %xmm7, %ymm6, %ymm6
vpbroadcastd	low_nibble(%rip), %ymm15
vpsrld	$0x4, %ymm6, %ymm7
vpand	%ymm15, %ymm6, %ymm6
vbroadcasti128	match_cnt_perm(%rip), %ymm15
vpbroadcastd	match_cnt_low_max(%rip), %ymm5
vpshufb	%ymm6, %ymm15, %ymm6
vpshufb	%ymm7, %ymm15, %ymm7
vpcmpeqb	%ymm5, %ymm6, %ymm15
vpand	%ymm15, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vmovdqu	%ymm1, %ymm0
vmovdqu	0x10(%rax,%rbp), %ymm1
vmovdqu	drot_left(%rip), %ymm11
vpermd	%ymm6, %ymm11, %ymm7
vpermd	%ymm3, %ymm11, %ymm3
vpinsrd	$0x0, %r11d, %xmm7, %xmm15
vmovd	%xmm7, %r11d
vinserti128	$0x0, %xmm15, %ymm7, %ymm7
vpinsrd	$0x0, %r12d, %xmm3, %xmm15
vmovd	%xmm3, %r12d
vinserti128	$0x0, %xmm15, %ymm3, %ymm3
vpbroadcastd	shortest_matches(%rip), %ymm15
vpcmpgtd	%ymm15, %ymm7, %ymm15
vpcmpgtd	%ymm7, %ymm6, %ymm5
vpcmpeqd	%ymm11, %ymm11, %ymm11
vpxor	%ymm11, %ymm15, %ymm15
vpor	%ymm5, %ymm15, %ymm15
vpandn	%ymm7, %ymm15, %ymm6
vpbroadcastd	twofiftyfour(%rip), %ymm5
vpaddd	%ymm6, %ymm3, %ymm3
vpaddd	%ymm5, %ymm3, %ymm3
vpbroadcastd	null_dist_syms(%rip), %ymm5
vpmovzxbd	-0x9(%rax,%rbp), %ymm11
vpaddd	%ymm5, %ymm11, %ymm11
vpand	%ymm15, %ymm11, %ymm11
vpandn	%ymm3, %ymm15, %ymm3
vpor	%ymm11, %ymm3, %ymm3
vmovdqu	%ymm3, (%rsi)
addq	$0x20, %rsi
cmpq	%rdx, %rax
jle	gen_icf_map_lh1_04.loop1
gen_icf_map_lh1_04.loop1_end:
leaq	(%rax,%rbp), %rcx
vpbroadcastd	(%rsp), %ymm15
vpaddd	%ymm12, %ymm4, %ymm3
vpsubd	%ymm3, %ymm10, %ymm3
vpand	%ymm15, %ymm3, %ymm3
vpaddd	%ymm12, %ymm3, %ymm3
vpsubd	%ymm3, %ymm14, %ymm3
vextracti128	$0x1, %ymm3, %xmm5
vpcmpeqq	%ymm15, %ymm15, %ymm15
vpgatherdq	%ymm15, (%rcx,%xmm3), %ymm6
vpcmpeqq	%ymm15, %ymm15, %ymm15
vpgatherdq	%ymm15, (%rcx,%xmm5), %ymm7
vpextrd	$0x3, %xmm5, %r9d
addl	%eax, %r9d
vpbroadcastd	hash_prod(%rip), %xmm11
vpbroadcastd	0x8(%rsp), %xmm15
vmovd	0x7(%rax,%rbp), %xmm2
vpmaddwd	%xmm11, %xmm2, %xmm2
vpmaddwd	%xmm11, %xmm2, %xmm2
vpand	%xmm15, %xmm2, %xmm2
vmovd	%xmm2, %r8d
movw	%r9w, 0x1268(%rdi,%r8,2)
vpaddd	%ymm12, %ymm3, %ymm3
vpsubd	%ymm3, %ymm14, %ymm3
vpbroadcastd	low_nibble(%rip), %ymm5
vbroadcasti128	nibble_order(%rip), %ymm11
vpslld	$0xc, %ymm3, %ymm15
vpor	%ymm15, %ymm3, %ymm15
vpand	%ymm5, %ymm15, %ymm15
vpshufb	%ymm11, %ymm15, %ymm15
vbroadcasti128	bit_index(%rip), %ymm5
vpshufb	%ymm15, %ymm5, %ymm15
vpxor	%ymm5, %ymm5, %ymm5
vpcmpgtb	%ymm5, %ymm15, %ymm5
vpsrld	$0x8, %ymm5, %ymm11
vpandn	%ymm5, %ymm11, %ymm5
vpsrld	$0x10, %ymm5, %ymm11
vpandn	%ymm5, %ymm11, %ymm5
vpsrld	$0x18, %ymm5, %ymm11
vpandn	%ymm5, %ymm11, %ymm5
vpbroadcastd	base_offset(%rip), %ymm11
vpaddb	%ymm11, %ymm15, %ymm15
vpand	%ymm5, %ymm15, %ymm15
vpsrlq	$0x20, %ymm15, %ymm5
vpxor	%ymm11, %ymm11, %ymm11
vpsadbw	%ymm11, %ymm15, %ymm15
vpsadbw	%ymm11, %ymm5, %ymm5
vpsubd	%ymm5, %ymm15, %ymm15
vpsllq	$0x20, %ymm5, %ymm5
vpor	%ymm5, %ymm15, %ymm15
vpcmpgtb	%ymm11, %ymm15, %ymm11
vpand	%ymm11, %ymm15, %ymm15
vpsllvd	%ymm15, %ymm12, %ymm11
vpsubd	%ymm12, %ymm11, %ymm11
vpcmpgtd	%ymm12, %ymm3, %ymm5
vpand	%ymm11, %ymm3, %ymm11
vpand	%ymm5, %ymm11, %ymm11
vpsrlvd	%ymm15, %ymm3, %ymm3
vpslld	$0x1, %ymm15, %ymm15
vpaddd	%ymm15, %ymm3, %ymm3
vpslld	$0x9, %ymm11, %ymm11
vpaddd	%ymm11, %ymm3, %ymm3
vpslld	$0xa, %ymm3, %ymm3
vpxor	%ymm8, %ymm6, %ymm6
vpxor	%ymm9, %ymm7, %ymm7
vpxor	%ymm15, %ymm15, %ymm15
vpcmpeqb	%ymm15, %ymm6, %ymm6
vpcmpeqb	%ymm15, %ymm7, %ymm7
vpbroadcastq	shift_finish(%rip), %ymm11
vpand	%ymm11, %ymm6, %ymm6
vpand	%ymm11, %ymm7, %ymm7
vpsadbw	%ymm15, %ymm6, %ymm6
vpsadbw	%ymm15, %ymm7, %ymm7
vmovdqu	downconvert_qd(%rip), %ymm5
vpshufb	%ymm5, %ymm6, %ymm6
vextracti128	$0x1, %ymm6, %xmm15
vpor	%ymm15, %ymm6, %ymm6
vpshufb	%ymm5, %ymm7, %ymm7
vextracti128	$0x1, %ymm7, %xmm15
vpor	%ymm15, %ymm7, %ymm7
vinserti128	$0x1, %xmm7, %ymm6, %ymm6
vpbroadcastd	low_nibble(%rip), %ymm15
vpsrld	$0x4, %ymm6, %ymm7
vpand	%ymm15, %ymm6, %ymm6
vbroadcasti128	match_cnt_perm(%rip), %ymm15
vpbroadcastd	match_cnt_low_max(%rip), %ymm5
vpshufb	%ymm6, %ymm15, %ymm6
vpshufb	%ymm7, %ymm15, %ymm7
vpcmpeqb	%ymm5, %ymm6, %ymm15
vpand	%ymm15, %ymm7, %ymm7
vpaddd	%ymm7, %ymm6, %ymm6
vmovdqu	drot_left(%rip), %ymm11
vpermd	%ymm6, %ymm11, %ymm7
vpermd	%ymm3, %ymm11, %ymm3
vpinsrd	$0x0, %r11d, %xmm7, %xmm15
vinserti128	$0x0, %xmm15, %ymm7, %ymm7
vpinsrd	$0x0, %r12d, %xmm3, %xmm15
vinserti128	$0x0, %xmm15, %ymm3, %ymm3
vpbroadcastd	shortest_matches(%rip), %ymm15
vpcmpgtd	%ymm15, %ymm7, %ymm15
vpcmpgtd	%ymm7, %ymm6, %ymm5
vpcmpeqd	%ymm11, %ymm11, %ymm11
vpxor	%ymm11, %ymm15, %ymm15
vpor	%ymm5, %ymm15, %ymm15
vpandn	%ymm7, %ymm15, %ymm6
vpbroadcastd	twofiftyfour(%rip), %ymm5
vpaddd	%ymm6, %ymm3, %ymm3
vpaddd	%ymm5, %ymm3, %ymm3
vpbroadcastd	null_dist_syms(%rip), %ymm5
vpmovzxbd	-0x1(%rax,%rbp), %ymm11
vpaddd	%ymm5, %ymm11, %ymm11
vpand	%ymm15, %ymm11, %ymm11
vpandn	%ymm3, %ymm15, %ymm3
vpor	%ymm11, %ymm3, %ymm3
vmovdqu	%ymm3, (%rsi)
addq	$0x8, %rax
end_main:
subq	%r13, %rax
subq	$0x1, %rax
addq	$0x10, %rsp
popq	%r13
popq	%r12
popq	%rbp
retq
	.section .data
	.p2align 5
datas_perm2:
	.byte 1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0
	.byte 1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0
drot_left:
	.byte 7,0,0,0,0,0,0,0,1,0,0,0,2,0,0,0
	.byte 3,0,0,0,4,0,0,0,5,0,0,0,6,0,0,0
datas_shuf:
	.byte 0,1,2,3,1,2,3,4,2,3,4,5,3,4,5,6
	.byte 4,5,6,7,5,6,7,8,6,7,8,9,7,8,9,10
qword_shuf:
	.byte 0,1,2,3,4,5,6,7,1,2,3,4,5,6,7,8
	.byte 2,3,4,5,6,7,8,9,3,4,5,6,7,8,9,10
increment:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
downconvert_qd:
	.byte 0,255,255,255,8,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,0,255,255,255,8,255,255,255
match_cnt_perm:
	.byte 0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4
bit_index:
	.byte 0,1,2,2,3,3,3,3,4,4,4,4,4,4,4,4
nibble_order:
	.byte 0,2,1,3,4,6,5,7,8,10,9,11,12,14,13,15
shift_finish:
	.byte 1,2,4,8,16,32,64,128
ones:
	.byte 1,0,0,0
hash_prod:
	.byte 75,232,177,151
null_dist_syms:
	.byte 0,120,0,0
twofiftyfour:
	.byte 254,0,0,0
shortest_matches:
	.byte 3,0,0,0
upper_word:
	.byte 0,0,255,255
low_word:
	.byte 255,255,0,0
low_nibble:
	.byte 15,15,15,15
match_cnt_low_max:
	.byte 4,0,0,0
base_offset:
	.byte 254,2,6,10

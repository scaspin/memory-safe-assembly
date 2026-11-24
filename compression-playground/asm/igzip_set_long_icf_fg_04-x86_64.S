	.text
set_long_icf_fg_04:
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
subq	$0x7, %rsi
vmovdqu	long_len(%rip), %ymm14
vmovdqu	len_mask(%rip), %ymm15
vmovdqu	dists_mask(%rip), %ymm13
vmovdqu	nlen_mask(%rip), %ymm12
vmovdqu	vect_size(%rip), %ymm9
vmovdqu	max_len(%rip), %ymm10
vmovdqu	twofiftysix(%rip), %ymm11
vmovdqu	(%rcx), %ymm0
set_long_icf_fg_04.fill_loop:
vmovdqu	%ymm0, %ymm1
vmovdqu	0x20(%rcx), %ymm0
cmpq	%rsi, %rdi
jae	set_long_icf_fg_04.end_fill
set_long_icf_fg_04.finish_entry:
vpand	%ymm15, %ymm1, %ymm2
vpcmpgtd	%ymm14, %ymm2, %ymm6
vpmovmskb	%ymm6, %r11d
addq	$0x8, %rdi
addq	$0x20, %rcx
testq	%r11, %r11
je	set_long_icf_fg_04.fill_loop
tzcntq	%r11, %r10
shrq	$0x2, %r10
leaq	-0x8(%rdi,%r10), %rdi
leaq	-0x20(%rcx,%r10,4), %rcx
movl	(%rcx), %r9d
vmovd	%r9d, %xmm1
movq	%r9, %r11
shrq	$0xa, %r9
andq	$0x1ff, %r9
shrq	$0x13, %r11
leaq	dist_start(%rip), %r8
movw	(%r8,%r9,2), %r9w
addq	%r11, %r9
movq	%rdi, %rax
subq	%r9, %rax
movl	$0x8, %r8d
movq	%rdx, %r13
subq	%rdi, %r13
subq	$0x40, %r13
cmpq	%r13, %r8
jg	..@77._by_32
..@77.loop1:
vmovdqu	(%rdi,%r8), %ymm7
vmovdqu	(%rax,%r8), %ymm8
vpcmpeqb	%ymm8, %ymm7, %ymm7
vpmovmskb	%ymm7, %r11d
xorl	$-0x1, %r11d
jne	..@77.miscompare_vect
addq	$0x20, %r8
vmovdqu	(%rdi,%r8), %ymm7
vmovdqu	(%rax,%r8), %ymm8
vpcmpeqb	%ymm8, %ymm7, %ymm7
vpmovmskb	%ymm7, %r11d
xorl	$-0x1, %r11d
jne	..@77.miscompare_vect
addq	$0x20, %r8
cmpq	%r13, %r8
jle	..@77.loop1
..@77._by_32:
addq	$0x20, %r13
cmpq	%r13, %r8
jg	..@77._by_16
vmovdqu	(%rdi,%r8), %ymm7
vmovdqu	(%rax,%r8), %ymm8
vpcmpeqb	%ymm8, %ymm7, %ymm7
vpmovmskb	%ymm7, %r11d
xorl	$-0x1, %r11d
jne	..@77.miscompare_vect
addq	$0x20, %r8
..@77._by_16:
addq	$0x10, %r13
cmpq	%r13, %r8
jg	..@77._by_8
vmovdqu	(%rdi,%r8), %xmm7
vmovdqu	(%rax,%r8), %xmm8
vpcmpeqb	%xmm8, %xmm7, %xmm7
vpmovmskb	%xmm7, %r11d
xorl	$0xffff, %r11d
jne	..@77.miscompare_vect
addq	$0x10, %r8
..@77._by_8:
addq	$0x8, %r13
cmpq	%r13, %r8
jg	..@77._cmp_last
movq	(%rdi,%r8), %r11
xorq	(%rax,%r8), %r11
jne	..@77.miscompare_reg
addq	$0x8, %r8
..@77._cmp_last:
addq	$0x8, %r13
cmpq	%r13, %r8
je	..@77.end
leaq	-0x8(%r13), %r8
movq	(%rdi,%r8), %r11
xorq	(%rax,%r8), %r11
jne	..@77.miscompare_reg
addq	$0x8, %r8
jmp	..@77.end
..@77.miscompare_reg:
bsfq	%r11, %r11
shrq	$0x3, %r11
addq	%r11, %r8
jmp	..@77.end
..@77.miscompare_vect:
tzcntq	%r11, %r11
addq	%r11, %r8
..@77.end:
vmovd	%r8d, %xmm4
vpbroadcastd	%xmm4, %ymm4
vpsubd	increment(%rip), %ymm4, %ymm4
vpaddd	twofiftyfour(%rip), %ymm4, %ymm4
movq	%rsi, %r13
subq	%rdi, %r13
cmpq	%r13, %r8
cmovgq	%r13, %r8
addq	%r8, %rdi
leaq	(%rcx,%r8,4), %rcx
vmovdqu	(%rcx), %ymm0
vpbroadcastd	%xmm1, %ymm1
vpand	%ymm12, %ymm1, %ymm1
negq	%r8
set_long_icf_fg_04.update_match_lookup:
vpand	(%rcx,%r8,4), %ymm15, %ymm5
vpcmpgtd	%ymm5, %ymm4, %ymm6
vpcmpgtd	%ymm11, %ymm4, %ymm7
vpand	%ymm7, %ymm6, %ymm6
vpmovmskb	%ymm6, %r11d
vpcmpgtd	%ymm10, %ymm4, %ymm3
vpandn	%ymm4, %ymm3, %ymm2
vpand	%ymm3, %ymm10, %ymm3
vpor	%ymm3, %ymm2, %ymm2
vpaddd	%ymm1, %ymm2, %ymm5
vpand	%ymm6, %ymm5, %ymm5
vpmaskmovd	%ymm5, %ymm6, (%rcx,%r8,4)
testl	%r11d, %r11d
je	set_long_icf_fg_04.fill_loop
addq	$0x8, %r8
vpsubd	%ymm9, %ymm4, %ymm4
jmp	set_long_icf_fg_04.update_match_lookup
set_long_icf_fg_04.end_fill:
movq	%r12, %rsi
cmpq	%rsi, %rdi
jge	set_long_icf_fg_04.finish
movq	%rsi, %r11
subq	%rdi, %r11
vmovd	%r11d, %xmm7
vpbroadcastd	%xmm7, %ymm7
vpcmpgtd	increment(%rip), %ymm7, %ymm7
vpand	%ymm7, %ymm1, %ymm1
jmp	set_long_icf_fg_04.finish_entry
set_long_icf_fg_04.finish:
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
len_mask:
	.byte 255,3,0,0,255,3,0,0,255,3,0,0,255,3,0,0
	.byte 255,3,0,0,255,3,0,0,255,3,0,0,255,3,0,0
dists_mask:
	.byte 255,1,0,0,255,1,0,0,255,1,0,0,255,1,0,0
	.byte 255,1,0,0,255,1,0,0,255,1,0,0,255,1,0,0
long_len:
	.byte 5,1,0,0,5,1,0,0,5,1,0,0,5,1,0,0
	.byte 5,1,0,0,5,1,0,0,5,1,0,0,5,1,0,0
increment:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
vect_size:
	.byte 8,0,0,0,8,0,0,0,8,0,0,0,8,0,0,0
	.byte 8,0,0,0,8,0,0,0,8,0,0,0,8,0,0,0
twofiftyfour:
	.byte 254,0,0,0,254,0,0,0,254,0,0,0,254,0,0,0
	.byte 254,0,0,0,254,0,0,0,254,0,0,0,254,0,0,0
twofiftysix:
	.byte 0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0
	.byte 0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0
nlen_mask:
	.byte 0,252,255,255,0,252,255,255,0,252,255,255,0,252,255,255
	.byte 0,252,255,255,0,252,255,255,0,252,255,255,0,252,255,255
max_len:
	.byte 0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0
	.byte 0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0

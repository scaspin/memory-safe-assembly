	.text
adler32_fold_copy_avx512:
testq	%rdx, %rdx
je	L_21b
testq	%rcx, %rcx
je	L_259
cmpq	$0x40, %rcx
jb	L_22e
movzwl	%di, %r9d
shrl	$0x10, %edi
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa64	bums_rodata(%rip), %zmm1
vpbroadcastw	bums_rodata+128(%rip), %zmm2
movl	$0x80078071, %eax
vmovdqa64	bums_rodata(%rip), %zmm3
vpbroadcastw	bums_rodata+128(%rip), %zmm4
jmp	L_fc
nopl	(%rax)
L_60:
subq	%r8, %rcx
vpslld	$0x6, %zmm7, %zmm7
vpaddd	%zmm7, %zmm5, %zmm5
vextracti64x4	$0x1, %zmm6, %ymm7
vpmovqd	%ymm7, %xmm7
vpmovqd	%ymm6, %xmm6
vpaddd	%xmm6, %xmm7, %xmm6
vpshufd	$0xee, %xmm6, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpshufd	$0x55, %xmm6, %xmm7
vpaddd	%xmm6, %xmm7, %xmm6
vmovd	%xmm6, %r9d
movq	%r9, %rdi
imulq	%rax, %rdi
shrq	$0x2f, %rdi
imull	$0xfff1, %edi, %edi
subl	%edi, %r9d
vextracti64x4	$0x1, %zmm5, %ymm6
vpaddd	%ymm5, %ymm6, %ymm5
vextracti128	$0x1, %ymm5, %xmm6
vpaddd	%xmm5, %xmm6, %xmm5
vpshufd	$0xee, %xmm5, %xmm6
vpaddd	%xmm6, %xmm5, %xmm5
vpshufd	$0x55, %xmm5, %xmm6
vpaddd	%xmm5, %xmm6, %xmm5
vmovd	%xmm5, %edi
movq	%rdi, %r8
imulq	%rax, %r8
shrq	$0x2f, %r8
imull	$0xfff1, %r8d, %r8d
subl	%r8d, %edi
cmpq	$0x3f, %rcx
jbe	L_223
L_fc:
cmpq	$0x15b0, %rcx
movl	$0x15b0, %r10d
cmovbq	%rcx, %r10
movl	%r10d, %r8d
andl	$0x1fc0, %r8d
vmovd	%r9d, %xmm7
vmovd	%edi, %xmm5
addq	$-0x40, %r10
testb	$0x40, %r10b
jne	L_180
vmovdqu64	(%rdx), %zmm6
vmovdqu64	%zmm6, (%rsi)
addq	$0x40, %rsi
addq	$0x40, %rdx
leaq	-0x40(%r8), %rdi
vpsadbw	%zmm0, %zmm6, %zmm8
vpmaddubsw	%zmm1, %zmm6, %zmm6
vpmaddwd	%zmm2, %zmm6, %zmm9
vpaddd	%zmm8, %zmm7, %zmm6
vpaddd	%zmm5, %zmm9, %zmm5
vmovdqa64	%zmm7, %zmm8
cmpq	$0x40, %r10
jae	L_1a0
jmp	L_60
nopw	%cs:(%rax,%rax)
L_180:
vmovdqa64	%zmm7, %zmm6
movq	%r8, %rdi
vpxor	%xmm8, %xmm8, %xmm8
cmpq	$0x40, %r10
jb	L_60
nopl	(%rax,%rax)
L_1a0:
vmovdqu64	(%rdx), %zmm7
vmovdqu64	%zmm7, (%rsi)
vpsadbw	%zmm0, %zmm7, %zmm9
vpmaddubsw	%zmm3, %zmm7, %zmm7
vpaddd	%zmm9, %zmm6, %zmm9
vpaddd	%zmm6, %zmm8, %zmm8
vpmaddwd	%zmm4, %zmm7, %zmm6
vpaddd	%zmm5, %zmm6, %zmm5
vmovdqu64	0x40(%rdx), %zmm6
vmovdqu64	%zmm6, 0x40(%rsi)
subq	$-0x80, %rsi
subq	$-0x80, %rdx
vpsadbw	%zmm0, %zmm6, %zmm7
vpmaddubsw	%zmm3, %zmm6, %zmm10
vpaddd	%zmm7, %zmm9, %zmm6
vpaddd	%zmm9, %zmm8, %zmm8
vpmaddwd	%zmm4, %zmm10, %zmm7
vpaddd	%zmm5, %zmm7, %zmm5
addq	$-0x80, %rdi
jne	L_1a0
vmovdqa64	%zmm8, %zmm7
jmp	L_60
L_21b:
movl	$0x1, %edi
movl	%edi, %eax
retq
L_223:
shll	$0x10, %edi
orl	%r9d, %edi
testq	%rcx, %rcx
je	L_259
L_22e:
movq	$-0x1, %rax
bzhiq	%rcx, %rax, %rax
kmovq	%rax, %k1
vmovdqu8	(%rdx), %zmm0 {%k1} {z}
vmovdqu8	%zmm0, (%rsi) {%k1}
movq	%rdx, %rsi
movq	%rcx, %rdx
vzeroupper
jmp	adler32_avx2
L_259:
movl	%edi, %eax
vzeroupper
retq
nop
adler32_avx512:
testq	%rsi, %rsi
je	L_45a
testq	%rdx, %rdx
je	L_475
cmpq	$0x40, %rdx
jb	L_46d
movzwl	%di, %r8d
shrl	$0x10, %edi
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa64	bums_rodata+192(%rip), %zmm1
vpbroadcastw	bums_rodata+320(%rip), %zmm2
movl	$0x80078071, %eax
vmovdqa64	bums_rodata+192(%rip), %zmm3
vpbroadcastw	bums_rodata+320(%rip), %zmm4
jmp	L_35a
nopl	(%rax)
L_2c0:
subq	%rcx, %rdx
vpslld	$0x6, %zmm7, %zmm7
vpaddd	%zmm7, %zmm5, %zmm5
vextracti64x4	$0x1, %zmm6, %ymm7
vpmovqd	%ymm7, %xmm7
vpmovqd	%ymm6, %xmm6
vpaddd	%xmm6, %xmm7, %xmm6
vpshufd	$0xee, %xmm6, %xmm7
vpaddd	%xmm7, %xmm6, %xmm6
vpshufd	$0x55, %xmm6, %xmm7
vpaddd	%xmm6, %xmm7, %xmm6
vmovd	%xmm6, %r8d
movq	%r8, %rcx
imulq	%rax, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %r8d
vextracti64x4	$0x1, %zmm5, %ymm6
vpaddd	%ymm5, %ymm6, %ymm5
vextracti128	$0x1, %ymm5, %xmm6
vpaddd	%xmm5, %xmm6, %xmm5
vpshufd	$0xee, %xmm5, %xmm6
vpaddd	%xmm6, %xmm5, %xmm5
vpshufd	$0x55, %xmm5, %xmm6
vpaddd	%xmm5, %xmm6, %xmm5
vmovd	%xmm5, %edi
movq	%rdi, %rcx
imulq	%rax, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %edi
cmpq	$0x3f, %rdx
jbe	L_462
L_35a:
cmpq	$0x15b0, %rdx
movl	$0x15b0, %r9d
cmovbq	%rdx, %r9
movl	%r9d, %ecx
andl	$0x1fc0, %ecx
vmovd	%r8d, %xmm7
vmovd	%edi, %xmm5
addq	$-0x40, %r9
testb	$0x40, %r9b
jne	L_3d0
vmovdqu64	(%rsi), %zmm6
addq	$0x40, %rsi
leaq	-0x40(%rcx), %rdi
vpsadbw	%zmm0, %zmm6, %zmm8
vpmaddubsw	%zmm1, %zmm6, %zmm6
vpmaddwd	%zmm2, %zmm6, %zmm9
vpaddd	%zmm8, %zmm7, %zmm6
vpaddd	%zmm5, %zmm9, %zmm5
vmovdqa64	%zmm7, %zmm8
cmpq	$0x40, %r9
jae	L_3f0
jmp	L_2c0
nopw	%cs:(%rax,%rax)
L_3d0:
vmovdqa64	%zmm7, %zmm6
movq	%rcx, %rdi
vpxor	%xmm8, %xmm8, %xmm8
cmpq	$0x40, %r9
jb	L_2c0
nopl	(%rax,%rax)
L_3f0:
vmovdqu64	(%rsi), %zmm7
vmovdqu64	0x40(%rsi), %zmm9
vpsadbw	%zmm0, %zmm7, %zmm10
vpmaddubsw	%zmm3, %zmm7, %zmm7
vpaddd	%zmm10, %zmm6, %zmm10
vpaddd	%zmm6, %zmm8, %zmm8
vpmaddwd	%zmm4, %zmm7, %zmm6
vpaddd	%zmm5, %zmm6, %zmm5
subq	$-0x80, %rsi
vpsadbw	%zmm0, %zmm9, %zmm6
vpmaddubsw	%zmm3, %zmm9, %zmm7
vpaddd	%zmm6, %zmm10, %zmm6
vpaddd	%zmm10, %zmm8, %zmm8
vpmaddwd	%zmm4, %zmm7, %zmm7
vpaddd	%zmm5, %zmm7, %zmm5
addq	$-0x80, %rdi
jne	L_3f0
vmovdqa64	%zmm8, %zmm7
jmp	L_2c0
L_45a:
movl	$0x1, %edi
movl	%edi, %eax
retq
L_462:
shll	$0x10, %edi
orl	%r8d, %edi
testq	%rdx, %rdx
je	L_475
L_46d:
vzeroupper
jmp	adler32_avx2
L_475:
movl	%edi, %eax
vzeroupper
retq
	.section .rodata
bums_rodata:
	.byte 64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,49
	.byte 48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,49
	.byte 48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0
# ---- adler32_avx2.S, for adler32_avx2
	.text
	.text
adler32_avx2:
testq	%rsi, %rsi
je	Ladler32_avx2__233
testq	%rdx, %rdx
je	Ladler32_avx2__22d
movl	%edi, %r8d
shrl	$0x10, %r8d
movzwl	%di, %ecx
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa	.LCPI0_0(%rip), %ymm1
vmovdqa	.LCPI0_1(%rip), %ymm2
vpbroadcastw	adler32_avx2__bums_rodata(%rip), %ymm3
movl	$0x80078071, %eax
nop
Ladler32_avx2__40:
cmpq	$0xf, %rdx
jbe	Ladler32_avx2__239
cmpq	$0x20, %rdx
jb	adler32_ssse3
nopw	%cs:(%rax,%rax)
Ladler32_avx2__60:
cmpq	$0x15b0, %rdx
movl	$0x15b0, %edi
cmovbq	%rdx, %rdi
andl	$0x1fe0, %edi
vmovd	%r8d, %xmm4
vmovd	%ecx, %xmm5
cmpq	$0x40, %rdx
jb	Ladler32_avx2__100
vpxor	%xmm6, %xmm6, %xmm6
movq	%rdi, %rcx
vpxor	%xmm7, %xmm7, %xmm7
Ladler32_avx2__90:
vmovdqu	(%rsi), %ymm8
vmovdqu	0x20(%rsi), %ymm9
addq	$0x40, %rsi
addq	$-0x40, %rcx
vpsadbw	%ymm0, %ymm8, %ymm10
vpsadbw	%ymm0, %ymm9, %ymm11
vpaddd	%ymm5, %ymm10, %ymm10
vpaddd	%ymm5, %ymm7, %ymm7
vpaddd	%ymm11, %ymm10, %ymm5
vpmaddubsw	%ymm1, %ymm8, %ymm8
vpmaddubsw	%ymm2, %ymm9, %ymm9
vpmaddwd	%ymm3, %ymm8, %ymm8
vpaddd	%ymm4, %ymm8, %ymm4
vpmaddwd	%ymm3, %ymm9, %ymm8
vpaddd	%ymm6, %ymm8, %ymm6
cmpq	$0x3f, %rcx
ja	Ladler32_avx2__90
vpslld	$0x6, %ymm7, %ymm7
vpaddd	%ymm7, %ymm4, %ymm4
vpaddd	%ymm6, %ymm4, %ymm4
testq	%rcx, %rcx
jne	Ladler32_avx2__103
vpxor	%xmm7, %xmm7, %xmm7
jmp	Ladler32_avx2__1a2
nopw	%cs:(%rax,%rax)
Ladler32_avx2__100:
movq	%rdi, %rcx
Ladler32_avx2__103:
leaq	-0x20(%rcx), %r8
vpxor	%xmm7, %xmm7, %xmm7
testb	$0x20, %r8b
jne	Ladler32_avx2__140
vmovdqu	(%rsi), %ymm7
addq	$0x20, %rsi
vpsadbw	%ymm0, %ymm7, %ymm6
vpaddd	%ymm6, %ymm5, %ymm6
vpmaddubsw	%ymm2, %ymm7, %ymm7
vpmaddwd	%ymm3, %ymm7, %ymm7
vpaddd	%ymm4, %ymm7, %ymm4
movq	%r8, %rcx
vmovdqa	%ymm5, %ymm7
cmpq	$0x20, %r8
jae	Ladler32_avx2__150
jmp	Ladler32_avx2__199
nopl	(%rax)
Ladler32_avx2__140:
vmovdqa	%ymm5, %ymm6
cmpq	$0x20, %r8
jb	Ladler32_avx2__199
nopw	(%rax,%rax)
Ladler32_avx2__150:
vmovdqu	(%rsi), %ymm5
vmovdqu	0x20(%rsi), %ymm8
vpsadbw	%ymm0, %ymm5, %ymm9
vpaddd	%ymm6, %ymm9, %ymm9
vpaddd	%ymm6, %ymm7, %ymm7
vpmaddubsw	%ymm2, %ymm5, %ymm5
vpmaddwd	%ymm3, %ymm5, %ymm5
vpaddd	%ymm4, %ymm5, %ymm4
addq	$0x40, %rsi
vpsadbw	%ymm0, %ymm8, %ymm5
vpaddd	%ymm5, %ymm9, %ymm6
vpaddd	%ymm7, %ymm9, %ymm7
vpmaddubsw	%ymm2, %ymm8, %ymm5
vpmaddwd	%ymm3, %ymm5, %ymm5
vpaddd	%ymm4, %ymm5, %ymm4
addq	$-0x40, %rcx
jne	Ladler32_avx2__150
vmovdqa	%ymm7, %ymm5
Ladler32_avx2__199:
vpslld	$0x5, %ymm5, %ymm7
vmovdqa	%ymm6, %ymm5
Ladler32_avx2__1a2:
vpaddd	%ymm7, %ymm4, %ymm4
subq	%rdi, %rdx
vextracti128	$0x1, %ymm5, %xmm6
vshufps	$0x88, %xmm6, %xmm5, %xmm5
vpshufd	$0x88, %xmm6, %xmm6
vpaddd	%xmm6, %xmm5, %xmm5
vpshufd	$0x55, %xmm5, %xmm6
vpaddd	%xmm5, %xmm6, %xmm5
vmovd	%xmm5, %ecx
movq	%rcx, %rdi
imulq	%rax, %rdi
shrq	$0x2f, %rdi
imull	$0xfff1, %edi, %edi
subl	%edi, %ecx
vextracti128	$0x1, %ymm4, %xmm5
vpaddd	%xmm4, %xmm5, %xmm4
vpshufd	$0xee, %xmm4, %xmm5
vpaddd	%xmm5, %xmm4, %xmm4
vpshufd	$0x55, %xmm4, %xmm5
vpaddd	%xmm4, %xmm5, %xmm4
vmovd	%xmm4, %r8d
movq	%r8, %rdi
imulq	%rax, %rdi
shrq	$0x2f, %rdi
imull	$0xfff1, %edi, %edi
subl	%edi, %r8d
cmpq	$0x1f, %rdx
ja	Ladler32_avx2__60
movl	%r8d, %edi
shll	$0x10, %edi
orl	%ecx, %edi
testq	%rdx, %rdx
jne	Ladler32_avx2__40
Ladler32_avx2__22d:
movl	%edi, %eax
vzeroupper
retq
Ladler32_avx2__233:
movl	$0x1, %eax
retq
Ladler32_avx2__239:
movq	%rdx, %rax
andq	$0x3, %rax
je	Ladler32_avx2__274
xorl	%edi, %edi
nopw	%cs:(%rax,%rax)
Ladler32_avx2__250:
movzbl	(%rsi,%rdi), %r9d
addl	%r9d, %ecx
addl	%ecx, %r8d
incq	%rdi
cmpq	%rdi, %rax
jne	Ladler32_avx2__250
movq	%rdx, %rax
subq	%rdi, %rax
addq	%rdi, %rsi
cmpq	$0x4, %rdx
jae	Ladler32_avx2__27d
jmp	Ladler32_avx2__2b0
Ladler32_avx2__274:
movq	%rdx, %rax
cmpq	$0x4, %rdx
jb	Ladler32_avx2__2b0
Ladler32_avx2__27d:
xorl	%edx, %edx
nop
Ladler32_avx2__280:
movzbl	(%rsi,%rdx), %edi
addl	%ecx, %edi
addl	%edi, %r8d
movzbl	0x1(%rsi,%rdx), %ecx
addl	%edi, %ecx
addl	%ecx, %r8d
movzbl	0x2(%rsi,%rdx), %edi
addl	%ecx, %edi
addl	%edi, %r8d
movzbl	0x3(%rsi,%rdx), %ecx
addl	%edi, %ecx
addl	%ecx, %r8d
addq	$0x4, %rdx
cmpq	%rdx, %rax
jne	Ladler32_avx2__280
Ladler32_avx2__2b0:
movl	%ecx, %eax
movl	$0x80078071, %edx
imulq	%rdx, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %ecx
movl	%r8d, %eax
imulq	%rdx, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %r8d
shll	$0x10, %r8d
orl	%ecx, %r8d
movl	%r8d, %eax
vzeroupper
retq
nopl	(%rax)
adler32_fold_copy_avx2:
testq	%rdx, %rdx
je	Ladler32_avx2__553
testq	%rcx, %rcx
je	Ladler32_avx2__54d
movl	%edi, %r9d
shrl	$0x10, %r9d
movzwl	%di, %r8d
vpxor	%xmm0, %xmm0, %xmm0
vmovdqa	.LCPI1_0(%rip), %ymm1
vmovdqa	.LCPI1_1(%rip), %ymm2
vpbroadcastw	adler32_avx2__bums_rodata+2(%rip), %ymm3
movl	$0x80078071, %eax
nop
Ladler32_avx2__330:
cmpq	$0xf, %rcx
jbe	Ladler32_avx2__559
cmpq	$0x20, %rcx
jb	adler32_fold_copy_sse42
nopw	%cs:(%rax,%rax)
Ladler32_avx2__350:
cmpq	$0x15b0, %rcx
movl	$0x15b0, %edi
cmovbq	%rcx, %rdi
andl	$0x1fe0, %edi
vmovd	%r9d, %xmm4
vmovd	%r8d, %xmm5
cmpq	$0x40, %rcx
jb	Ladler32_avx2__400
vpxor	%xmm6, %xmm6, %xmm6
movq	%rdi, %r8
vpxor	%xmm7, %xmm7, %xmm7
nopw	%cs:(%rax,%rax)
Ladler32_avx2__390:
vmovdqu	(%rdx), %ymm8
vmovdqu	0x20(%rdx), %ymm9
addq	$0x40, %rdx
addq	$-0x40, %r8
vpsadbw	%ymm0, %ymm8, %ymm10
vpsadbw	%ymm0, %ymm9, %ymm11
vmovdqu	%ymm8, (%rsi)
vmovdqu	%ymm9, 0x20(%rsi)
addq	$0x40, %rsi
vpaddd	%ymm5, %ymm10, %ymm10
vpaddd	%ymm5, %ymm7, %ymm7
vpaddd	%ymm11, %ymm10, %ymm5
vpmaddubsw	%ymm1, %ymm8, %ymm8
vpmaddubsw	%ymm2, %ymm9, %ymm9
vpmaddwd	%ymm3, %ymm8, %ymm8
vpaddd	%ymm4, %ymm8, %ymm4
vpmaddwd	%ymm3, %ymm9, %ymm8
vpaddd	%ymm6, %ymm8, %ymm6
cmpq	$0x3f, %r8
ja	Ladler32_avx2__390
vpslld	$0x6, %ymm7, %ymm7
vpaddd	%ymm7, %ymm4, %ymm4
vpaddd	%ymm6, %ymm4, %ymm4
testq	%r8, %r8
jne	Ladler32_avx2__403
vpxor	%xmm7, %xmm7, %xmm7
jmp	Ladler32_avx2__4bf
nop
Ladler32_avx2__400:
movq	%rdi, %r8
Ladler32_avx2__403:
leaq	-0x20(%r8), %r9
vpxor	%xmm7, %xmm7, %xmm7
testb	$0x20, %r9b
jne	Ladler32_avx2__450
vmovdqu	(%rdx), %ymm7
addq	$0x20, %rdx
vpsadbw	%ymm0, %ymm7, %ymm6
vmovdqu	%ymm7, (%rsi)
addq	$0x20, %rsi
vpaddd	%ymm6, %ymm5, %ymm6
vpmaddubsw	%ymm2, %ymm7, %ymm7
vpmaddwd	%ymm3, %ymm7, %ymm7
vpaddd	%ymm4, %ymm7, %ymm4
movq	%r9, %r8
vmovdqa	%ymm5, %ymm7
cmpq	$0x20, %r9
jae	Ladler32_avx2__460
jmp	Ladler32_avx2__4b6
nopw	%cs:(%rax,%rax)
Ladler32_avx2__450:
vmovdqa	%ymm5, %ymm6
cmpq	$0x20, %r9
jb	Ladler32_avx2__4b6
nopw	(%rax,%rax)
Ladler32_avx2__460:
vmovdqu	(%rdx), %ymm5
vpsadbw	%ymm0, %ymm5, %ymm8
vmovdqu	%ymm5, (%rsi)
vpaddd	%ymm6, %ymm8, %ymm8
vpaddd	%ymm6, %ymm7, %ymm7
vpmaddubsw	%ymm2, %ymm5, %ymm5
vpmaddwd	%ymm3, %ymm5, %ymm5
vpaddd	%ymm4, %ymm5, %ymm4
vmovdqu	0x20(%rdx), %ymm5
addq	$0x40, %rdx
vmovdqu	%ymm5, 0x20(%rsi)
addq	$0x40, %rsi
vpsadbw	%ymm0, %ymm5, %ymm6
vpaddd	%ymm6, %ymm8, %ymm6
vpaddd	%ymm7, %ymm8, %ymm7
vpmaddubsw	%ymm2, %ymm5, %ymm5
vpmaddwd	%ymm3, %ymm5, %ymm5
vpaddd	%ymm4, %ymm5, %ymm4
addq	$-0x40, %r8
jne	Ladler32_avx2__460
vmovdqa	%ymm7, %ymm5
Ladler32_avx2__4b6:
vpslld	$0x5, %ymm5, %ymm7
vmovdqa	%ymm6, %ymm5
Ladler32_avx2__4bf:
vpaddd	%ymm7, %ymm4, %ymm4
subq	%rdi, %rcx
vextracti128	$0x1, %ymm5, %xmm6
vshufps	$0x88, %xmm6, %xmm5, %xmm5
vpshufd	$0x88, %xmm6, %xmm6
vpaddd	%xmm6, %xmm5, %xmm5
vpshufd	$0x55, %xmm5, %xmm6
vpaddd	%xmm5, %xmm6, %xmm5
vmovd	%xmm5, %r8d
movq	%r8, %rdi
imulq	%rax, %rdi
shrq	$0x2f, %rdi
imull	$0xfff1, %edi, %edi
subl	%edi, %r8d
vextracti128	$0x1, %ymm4, %xmm5
vpaddd	%xmm4, %xmm5, %xmm4
vpshufd	$0xee, %xmm4, %xmm5
vpaddd	%xmm5, %xmm4, %xmm4
vpshufd	$0x55, %xmm4, %xmm5
vpaddd	%xmm4, %xmm5, %xmm4
vmovd	%xmm4, %r9d
movq	%r9, %rdi
imulq	%rax, %rdi
shrq	$0x2f, %rdi
imull	$0xfff1, %edi, %edi
subl	%edi, %r9d
cmpq	$0x1f, %rcx
ja	Ladler32_avx2__350
movl	%r9d, %edi
shll	$0x10, %edi
orl	%r8d, %edi
testq	%rcx, %rcx
jne	Ladler32_avx2__330
Ladler32_avx2__54d:
movl	%edi, %eax
vzeroupper
retq
Ladler32_avx2__553:
movl	$0x1, %eax
retq
Ladler32_avx2__559:
movq	%rcx, %rax
andq	$0x3, %rax
je	Ladler32_avx2__59b
xorl	%edi, %edi
nopw	%cs:(%rax,%rax)
Ladler32_avx2__570:
movzbl	(%rdx,%rdi), %r10d
movb	%r10b, (%rsi,%rdi)
addl	%r10d, %r8d
addl	%r8d, %r9d
incq	%rdi
cmpq	%rdi, %rax
jne	Ladler32_avx2__570
movq	%rcx, %rax
subq	%rdi, %rax
addq	%rdi, %rsi
addq	%rdi, %rdx
cmpq	$0x4, %rcx
jae	Ladler32_avx2__5a4
jmp	Ladler32_avx2__5f7
Ladler32_avx2__59b:
movq	%rcx, %rax
cmpq	$0x4, %rcx
jb	Ladler32_avx2__5f7
Ladler32_avx2__5a4:
xorl	%ecx, %ecx
nopw	%cs:(%rax,%rax)
Ladler32_avx2__5b0:
movzbl	(%rdx,%rcx), %edi
movb	%dil, (%rsi,%rcx)
addl	%edi, %r8d
addl	%r8d, %r9d
movzbl	0x1(%rdx,%rcx), %edi
movb	%dil, 0x1(%rsi,%rcx)
addl	%edi, %r8d
addl	%r8d, %r9d
movzbl	0x2(%rdx,%rcx), %edi
movb	%dil, 0x2(%rsi,%rcx)
addl	%edi, %r8d
addl	%r8d, %r9d
movzbl	0x3(%rdx,%rcx), %edi
movb	%dil, 0x3(%rsi,%rcx)
addl	%edi, %r8d
addl	%r8d, %r9d
addq	$0x4, %rcx
cmpq	%rcx, %rax
jne	Ladler32_avx2__5b0
Ladler32_avx2__5f7:
movl	%r8d, %eax
movl	$0x80078071, %ecx
imulq	%rcx, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %r8d
movl	%r9d, %eax
imulq	%rcx, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %r9d
shll	$0x10, %r9d
orl	%r8d, %r9d
movl	%r9d, %eax
vzeroupper
retq
	.section .rodata
adler32_avx2__bums_rodata:
	.byte 1,0,1,0
	.section .rodata.cst32
.LCPI0_0:
	.byte 64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,49
	.byte 48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33
.LCPI0_1:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
.LCPI1_0:
	.byte 64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,49
	.byte 48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33
.LCPI1_1:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
# ---- adler32_sse42.S, for adler32_fold_copy_sse42
	.text
	.text
adler32_fold_copy_sse42:
movzwl	%di, %r9d
movl	%edi, %eax
shrl	$0x10, %eax
pxor	%xmm0, %xmm0
movdqa	.LCPI0_0(%rip), %xmm1
movdqa	.LCPI0_1(%rip), %xmm2
pmovsxbw	.LCPI0_3(%rip), %xmm3
movl	$0x80078071, %edi
jmp	Ladler32_sse42__39
nopl	(%rax)
Ladler32_sse42__30:
testq	%rcx, %rcx
je	Ladler32_sse42__29b
Ladler32_sse42__39:
cmpq	$0x10, %rcx
jae	Ladler32_sse42__bf
jmp	Ladler32_sse42__256
nopl	(%rax,%rax)
Ladler32_sse42__50:
movdqa	%xmm6, %xmm5
Ladler32_sse42__54:
pslld	$0x4, %xmm5
movdqa	%xmm5, %xmm6
movdqa	%xmm7, %xmm5
Ladler32_sse42__61:
paddd	%xmm4, %xmm6
subq	%r8, %rcx
pshufd	$0xee, %xmm5, %xmm4
paddd	%xmm5, %xmm4
movd	%xmm4, %r9d
movq	%r9, %rax
imulq	%rdi, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %r9d
pshufd	$0xee, %xmm6, %xmm4
paddd	%xmm6, %xmm4
pshufd	$0x55, %xmm4, %xmm5
paddd	%xmm4, %xmm5
movd	%xmm5, %eax
movq	%rax, %r8
imulq	%rdi, %r8
shrq	$0x2f, %r8
imull	$0xfff1, %r8d, %r8d
subl	%r8d, %eax
cmpq	$0xf, %rcx
jbe	Ladler32_sse42__30
Ladler32_sse42__bf:
cmpq	$0x15b0, %rcx
movl	$0x15b0, %r8d
cmovbq	%rcx, %r8
andl	$0x1ff0, %r8d
movd	%r9d, %xmm5
movd	%eax, %xmm4
cmpq	$0x20, %rcx
jb	Ladler32_sse42__190
pxor	%xmm6, %xmm6
movq	%r8, %rax
pxor	%xmm7, %xmm7
nopw	%cs:(%rax,%rax)
Ladler32_sse42__100:
movdqa	%xmm5, %xmm8
movdqu	(%rdx), %xmm9
movdqu	0x10(%rdx), %xmm10
addq	$0x20, %rdx
addq	$-0x20, %rax
movdqa	%xmm9, %xmm5
psadbw	%xmm0, %xmm5
movdqa	%xmm10, %xmm11
psadbw	%xmm0, %xmm11
movdqu	%xmm9, (%rsi)
movdqu	%xmm10, 0x10(%rsi)
addq	$0x20, %rsi
pmaddubsw	%xmm1, %xmm9
pmaddubsw	%xmm2, %xmm10
paddd	%xmm8, %xmm5
paddd	%xmm11, %xmm5
paddd	%xmm8, %xmm7
pmaddwd	%xmm3, %xmm9
paddd	%xmm9, %xmm4
pmaddwd	%xmm3, %xmm10
paddd	%xmm10, %xmm6
cmpq	$0x1f, %rax
ja	Ladler32_sse42__100
pslld	$0x5, %xmm7
paddd	%xmm7, %xmm4
paddd	%xmm6, %xmm4
testq	%rax, %rax
jne	Ladler32_sse42__193
pxor	%xmm6, %xmm6
jmp	Ladler32_sse42__61
nopw	(%rax,%rax)
Ladler32_sse42__190:
movq	%r8, %rax
Ladler32_sse42__193:
leaq	-0x10(%rax), %r9
pxor	%xmm6, %xmm6
testb	$0x10, %r9b
jne	Ladler32_sse42__1e0
movdqu	(%rdx), %xmm7
addq	$0x10, %rdx
movdqa	%xmm7, %xmm6
movdqu	%xmm7, (%rsi)
psadbw	%xmm0, %xmm7
pmaddubsw	%xmm2, %xmm6
paddd	%xmm5, %xmm7
pmaddwd	%xmm3, %xmm6
paddd	%xmm6, %xmm4
addq	$0x10, %rsi
movq	%r9, %rax
movdqa	%xmm5, %xmm6
cmpq	$0x10, %r9
jae	Ladler32_sse42__1f0
jmp	Ladler32_sse42__54
nopl	(%rax)
Ladler32_sse42__1e0:
movdqa	%xmm5, %xmm7
cmpq	$0x10, %r9
jb	Ladler32_sse42__54
nop
Ladler32_sse42__1f0:
movdqu	(%rdx), %xmm8
movdqa	%xmm8, %xmm5
movdqu	%xmm8, (%rsi)
psadbw	%xmm0, %xmm8
pmaddubsw	%xmm2, %xmm5
paddd	%xmm7, %xmm8
paddd	%xmm7, %xmm6
pmaddwd	%xmm3, %xmm5
paddd	%xmm4, %xmm5
movdqu	0x10(%rdx), %xmm7
addq	$0x20, %rdx
movdqu	%xmm7, 0x10(%rsi)
addq	$0x20, %rsi
movdqa	%xmm7, %xmm4
psadbw	%xmm0, %xmm7
pmaddubsw	%xmm2, %xmm4
paddd	%xmm8, %xmm7
paddd	%xmm8, %xmm6
pmaddwd	%xmm3, %xmm4
paddd	%xmm5, %xmm4
addq	$-0x20, %rax
jne	Ladler32_sse42__1f0
jmp	Ladler32_sse42__50
Ladler32_sse42__256:
testq	%rcx, %rcx
je	Ladler32_sse42__2fb
movq	%rcx, %rdi
andq	$0x3, %rdi
je	Ladler32_sse42__2a5
xorl	%r8d, %r8d
nopl	(%rax,%rax)
Ladler32_sse42__270:
movzbl	(%rdx,%r8), %r10d
movb	%r10b, (%rsi,%r8)
addl	%r10d, %r9d
addl	%r9d, %eax
incq	%r8
cmpq	%r8, %rdi
jne	Ladler32_sse42__270
movq	%rcx, %rdi
subq	%r8, %rdi
addq	%r8, %rsi
addq	%r8, %rdx
cmpq	$0x4, %rcx
jae	Ladler32_sse42__2ae
jmp	Ladler32_sse42__2fb
Ladler32_sse42__29b:
shll	$0x10, %eax
orl	%eax, %r9d
movl	%r9d, %eax
retq
Ladler32_sse42__2a5:
movq	%rcx, %rdi
cmpq	$0x4, %rcx
jb	Ladler32_sse42__2fb
Ladler32_sse42__2ae:
xorl	%ecx, %ecx
Ladler32_sse42__2b0:
movzbl	(%rdx,%rcx), %r8d
movb	%r8b, (%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
movzbl	0x1(%rdx,%rcx), %r8d
movb	%r8b, 0x1(%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
movzbl	0x2(%rdx,%rcx), %r8d
movb	%r8b, 0x2(%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
movzbl	0x3(%rdx,%rcx), %r8d
movb	%r8b, 0x3(%rsi,%rcx)
addl	%r8d, %r9d
addl	%r9d, %eax
addq	$0x4, %rcx
cmpq	%rcx, %rdi
jne	Ladler32_sse42__2b0
Ladler32_sse42__2fb:
movl	%r9d, %ecx
movl	$0x80078071, %edx
imulq	%rdx, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %r9d
movl	%eax, %ecx
imulq	%rdx, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %eax
shll	$0x10, %eax
orl	%r9d, %eax
retq
	.section .rodata.cst16
.LCPI0_0:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
.LCPI0_1:
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	.section .rodata.cst8
.LCPI0_3:
	.byte 1,1,1,1,1,1,1,1
# ---- adler32_ssse3.S, for adler32_ssse3
	.text
	.text
adler32_ssse3:
pushq	%rbx
movzwl	%di, %ecx
movl	%edi, %eax
shrl	$0x10, %eax
cmpq	$0x1, %rdx
je	Ladler32_ssse3__f6
testq	%rsi, %rsi
je	Ladler32_ssse3__124
cmpq	$0xf, %rdx
jbe	Ladler32_ssse3__12b
movl	%esi, %r8d
movl	$0x15b0, %edi
andl	$0xf, %r8d
je	Ladler32_ssse3__1a5
movl	$0x20, %edi
subq	%r8, %rdi
cmpq	%rdi, %rdx
jae	Ladler32_ssse3__5f
addq	$-0x10, %rdx
movd	%ecx, %xmm2
movd	%eax, %xmm0
pxor	%xmm1, %xmm1
xorl	%edi, %edi
movq	%rdx, %r8
jmp	Ladler32_ssse3__398
Ladler32_ssse3__5f:
movl	$0x10, %edi
subq	%r8, %rdi
movl	%r8d, %r10d
xorl	$0xf, %r10d
movl	%edi, %r9d
andl	$0x3, %r9d
cmpl	$0x3, %r10d
jae	Ladler32_ssse3__80
movq	%rsi, %r10
jmp	Ladler32_ssse3__bd
Ladler32_ssse3__80:
movl	%edi, %r11d
andl	$-0x4, %r11d
movq	%rsi, %r10
nopw	(%rax,%rax)
Ladler32_ssse3__90:
movzbl	(%r10), %ebx
addl	%ecx, %ebx
addl	%ebx, %eax
movzbl	0x1(%r10), %ecx
addl	%ebx, %ecx
addl	%ecx, %eax
movzbl	0x2(%r10), %ebx
addl	%ecx, %ebx
addl	%ebx, %eax
movzbl	0x3(%r10), %ecx
addq	$0x4, %r10
addl	%ebx, %ecx
addl	%ecx, %eax
addq	$-0x4, %r11
jne	Ladler32_ssse3__90
Ladler32_ssse3__bd:
testq	%r9, %r9
je	Ladler32_ssse3__e1
xorl	%r11d, %r11d
nopw	%cs:(%rax,%rax)
Ladler32_ssse3__d0:
movzbl	(%r10,%r11), %ebx
addl	%ebx, %ecx
addl	%ecx, %eax
incq	%r11
cmpq	%r11, %r9
jne	Ladler32_ssse3__d0
Ladler32_ssse3__e1:
addq	%rdi, %rsi
subq	%rdi, %rdx
orq	$0x15a0, %r8
movq	%r8, %rdi
jmp	Ladler32_ssse3__1a5
Ladler32_ssse3__f6:
movzbl	(%rsi), %edx
addl	%edx, %ecx
movl	%ecx, %edx
subl	$0xfff1, %edx
cmovbl	%ecx, %edx
addl	%edx, %eax
movl	$0x80078071, %ecx
imulq	%rax, %rcx
shrq	$0x2f, %rcx
imull	$0xfff1, %ecx, %ecx
subl	%ecx, %eax
shll	$0x10, %eax
addl	%edx, %eax
popq	%rbx
retq
Ladler32_ssse3__124:
movl	$0x1, %eax
popq	%rbx
retq
Ladler32_ssse3__12b:
testq	%rdx, %rdx
je	Ladler32_ssse3__364
movq	%rdx, %rdi
andq	$0x3, %rdi
je	Ladler32_ssse3__15d
xorl	%r8d, %r8d
Ladler32_ssse3__140:
movzbl	(%rsi,%r8), %r9d
addl	%r9d, %ecx
addl	%ecx, %eax
incq	%r8
cmpq	%r8, %rdi
jne	Ladler32_ssse3__140
movq	%rdx, %rdi
subq	%r8, %rdi
addq	%r8, %rsi
jmp	Ladler32_ssse3__160
Ladler32_ssse3__15d:
movq	%rdx, %rdi
Ladler32_ssse3__160:
cmpq	$0x4, %rdx
jb	Ladler32_ssse3__364
xorl	%edx, %edx
Ladler32_ssse3__16c:
movzbl	(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x1(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
movzbl	0x2(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x3(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
addq	$0x4, %rdx
cmpq	%rdx, %rdi
jne	Ladler32_ssse3__16c
jmp	Ladler32_ssse3__364
Ladler32_ssse3__1a5:
cmpq	$0x10, %rdx
jb	Ladler32_ssse3__2e2
movd	%ecx, %xmm2
movd	%eax, %xmm3
cmpq	%rdi, %rdx
cmovbq	%rdx, %rdi
andq	$-0x10, %rdi
movq	%rdx, %r8
subq	%rdi, %r8
pxor	%xmm1, %xmm1
cmpq	$0x20, %rdx
jb	Ladler32_ssse3__267
pxor	%xmm5, %xmm5
movdqa	.LCPI0_0(%rip), %xmm6
movdqa	.LCPI0_1(%rip), %xmm7
movdqa	.LCPI0_2(%rip), %xmm8
pxor	%xmm4, %xmm4
pxor	%xmm0, %xmm0
nopl	(%rax,%rax)
Ladler32_ssse3__200:
movdqa	%xmm2, %xmm9
movdqa	(%rsi), %xmm10
movdqa	0x10(%rsi), %xmm11
addq	$0x20, %rsi
addq	$-0x20, %rdi
movdqa	%xmm10, %xmm2
psadbw	%xmm5, %xmm2
movdqa	%xmm11, %xmm12
psadbw	%xmm5, %xmm12
paddd	%xmm9, %xmm2
paddd	%xmm12, %xmm2
paddd	%xmm9, %xmm0
pmaddubsw	%xmm6, %xmm10
pmaddwd	%xmm7, %xmm10
paddd	%xmm10, %xmm3
pmaddubsw	%xmm8, %xmm11
pmaddwd	%xmm7, %xmm11
paddd	%xmm11, %xmm4
cmpq	$0x1f, %rdi
ja	Ladler32_ssse3__200
pslld	$0x5, %xmm0
jmp	Ladler32_ssse3__26f
Ladler32_ssse3__267:
pxor	%xmm0, %xmm0
pxor	%xmm4, %xmm4
Ladler32_ssse3__26f:
paddd	%xmm4, %xmm0
paddd	%xmm3, %xmm0
cmpq	$0x10, %rdi
jae	Ladler32_ssse3__394
Ladler32_ssse3__281:
pslld	$0x4, %xmm1
paddd	%xmm1, %xmm0
pshufd	$0xee, %xmm2, %xmm1
paddd	%xmm2, %xmm1
movd	%xmm1, %ecx
movl	$0x80078071, %edx
movq	%rcx, %rax
imulq	%rdx, %rax
shrq	$0x2f, %rax
imull	$0xfff1, %eax, %eax
subl	%eax, %ecx
pshufd	$0xee, %xmm0, %xmm1
paddd	%xmm0, %xmm1
pshufd	$0x55, %xmm1, %xmm0
paddd	%xmm1, %xmm0
movd	%xmm0, %eax
imulq	%rax, %rdx
shrq	$0x2f, %rdx
imull	$0xfff1, %edx, %edx
subl	%edx, %eax
movq	%r8, %rdx
movl	$0x15b0, %edi
jmp	Ladler32_ssse3__1a5
Ladler32_ssse3__2e2:
testq	%rdx, %rdx
je	Ladler32_ssse3__364
movq	%rdx, %rdi
andq	$0x3, %rdi
je	Ladler32_ssse3__323
xorl	%r8d, %r8d
nopw	%cs:(%rax,%rax)
Ladler32_ssse3__300:
movzbl	(%rsi,%r8), %r9d
addl	%r9d, %ecx
addl	%ecx, %eax
incq	%r8
cmpq	%r8, %rdi
jne	Ladler32_ssse3__300
movq	%rdx, %rdi
subq	%r8, %rdi
addq	%r8, %rsi
cmpq	$0x4, %rdx
jae	Ladler32_ssse3__32c
jmp	Ladler32_ssse3__364
Ladler32_ssse3__323:
movq	%rdx, %rdi
cmpq	$0x4, %rdx
jb	Ladler32_ssse3__364
Ladler32_ssse3__32c:
xorl	%edx, %edx
nop
Ladler32_ssse3__330:
movzbl	(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x1(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
movzbl	0x2(%rsi,%rdx), %r8d
addl	%ecx, %r8d
addl	%r8d, %eax
movzbl	0x3(%rsi,%rdx), %ecx
addl	%r8d, %ecx
addl	%ecx, %eax
addq	$0x4, %rdx
cmpq	%rdx, %rdi
jne	Ladler32_ssse3__330
Ladler32_ssse3__364:
movl	%ecx, %edx
movl	$0x80078071, %esi
imulq	%rsi, %rdx
shrq	$0x2f, %rdx
imull	$0xfff1, %edx, %edx
subl	%edx, %ecx
movl	%eax, %edx
imulq	%rsi, %rdx
shrq	$0x2f, %rdx
imull	$0xfff1, %edx, %edx
subl	%edx, %eax
shll	$0x10, %eax
orl	%ecx, %eax
popq	%rbx
retq
Ladler32_ssse3__394:
addq	$-0x10, %rdi
Ladler32_ssse3__398:
movdqu	(%rsi), %xmm3
addq	$0x10, %rsi
pxor	%xmm4, %xmm4
psadbw	%xmm3, %xmm4
paddd	%xmm2, %xmm4
paddd	%xmm2, %xmm1
pmaddubsw	.LCPI0_2(%rip), %xmm3
pmaddwd	.LCPI0_1(%rip), %xmm3
paddd	%xmm3, %xmm0
movdqa	%xmm4, %xmm2
cmpq	$0x10, %rdi
jb	Ladler32_ssse3__281
jmp	Ladler32_ssse3__394
	.section .rodata.cst16
.LCPI0_0:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
.LCPI0_1:
	.byte 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
.LCPI0_2:
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1

	.text
adler32_avx2_4:
endbr64
pushq	%r12
pushq	%r13
vmovdqa	SHUF0(%rip), %ymm6
vmovdqa	SHUF1(%rip), %ymm7
movq	%rsi, %r9
movq	%rdx, %r10
movl	%edi, %r8d
shrl	$0x10, %r8d
andl	$0xffff, %edi
cmpq	$0x20, %r10
jb	adler32_avx2_4.lt64
vmovd	%edi, %xmm0
vpxor	%ymm1, %ymm1, %ymm1
adler32_avx2_4.sloop1:
movl	$0x15b0, %r11d
cmpq	%r10, %r11
cmovaq	%r10, %r11
leaq	-0xf(%r11,%r9), %r13
cmpq	%r13, %r9
jae	adler32_avx2_4.skip_loop_1a
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
adler32_avx2_4.sloop1a:
vbroadcastf128	(%r9), %ymm4
addq	$0x10, %r9
vpshufb	%ymm6, %ymm4, %ymm2
vpaddd	%ymm2, %ymm0, %ymm0
vpaddd	%ymm0, %ymm1, %ymm1
vpshufb	%ymm7, %ymm4, %ymm3
vpaddd	%ymm3, %ymm0, %ymm0
vpaddd	%ymm0, %ymm1, %ymm1
cmpq	%r13, %r9
jb	adler32_avx2_4.sloop1a
adler32_avx2_4.skip_loop_1a:
addq	$0xf, %r13
testq	$0xf, %r11
jne	adler32_avx2_4.do_final
subq	%r11, %r10
vpslld	$0x3, %ymm1, %ymm1
vpmulld	A_SCALE(%rip), %ymm0, %ymm4
vextracti128	$0x1, %ymm0, %xmm2
vextracti128	$0x1, %ymm1, %xmm3
vextracti128	$0x1, %ymm4, %xmm5
vpaddd	%xmm2, %xmm0, %xmm0
vpaddd	%xmm3, %xmm1, %xmm1
vpaddd	%xmm5, %xmm4, %xmm4
vphaddd	%xmm0, %xmm0, %xmm0
vphaddd	%xmm1, %xmm1, %xmm1
vphaddd	%xmm4, %xmm4, %xmm4
vphaddd	%xmm0, %xmm0, %xmm0
vphaddd	%xmm1, %xmm1, %xmm1
vphaddd	%xmm4, %xmm4, %xmm4
vmovd	%xmm0, %eax
xorl	%edx, %edx
movl	$0xfff1, %ecx
divl	%ecx
movl	%edx, %r12d
vpsubd	%xmm4, %xmm1, %xmm1
vmovd	%xmm1, %eax
addl	%r8d, %eax
xorl	%edx, %edx
movl	$0xfff1, %ecx
divl	%ecx
movl	%edx, %r8d
testq	%r10, %r10
je	adler32_avx2_4.finish
vmovd	%r12d, %xmm0
vpxor	%ymm1, %ymm1, %ymm1
jmp	adler32_avx2_4.sloop1
adler32_avx2_4.finish:
movl	%r8d, %eax
shll	$0x10, %eax
orl	%r12d, %eax
jmp	adler32_avx2_4.end
adler32_avx2_4.lt64:
movl	%edi, %r12d
leaq	(%r9,%r10), %r13
testq	%r10, %r10
jne	adler32_avx2_4.final_loop
jmp	adler32_avx2_4.zero_size
adler32_avx2_4.do_final:
vpslld	$0x3, %ymm1, %ymm1
vpmulld	A_SCALE(%rip), %ymm0, %ymm4
vextracti128	$0x1, %ymm0, %xmm2
vextracti128	$0x1, %ymm1, %xmm3
vextracti128	$0x1, %ymm4, %xmm5
vpaddd	%xmm2, %xmm0, %xmm0
vpaddd	%xmm3, %xmm1, %xmm1
vpaddd	%xmm5, %xmm4, %xmm4
vphaddd	%xmm0, %xmm0, %xmm0
vphaddd	%xmm1, %xmm1, %xmm1
vphaddd	%xmm4, %xmm4, %xmm4
vphaddd	%xmm0, %xmm0, %xmm0
vphaddd	%xmm1, %xmm1, %xmm1
vphaddd	%xmm4, %xmm4, %xmm4
vpsubd	%xmm4, %xmm1, %xmm1
vmovd	%xmm0, %r12d
vmovd	%xmm1, %eax
addl	%eax, %r8d
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
adler32_avx2_4.final_loop:
movzbl	(%r9), %eax
addl	%eax, %r12d
incq	%r9
addl	%r12d, %r8d
cmpq	%r13, %r9
jb	adler32_avx2_4.final_loop
adler32_avx2_4.zero_size:
movl	%r12d, %eax
xorl	%edx, %edx
movl	$0xfff1, %ecx
divl	%ecx
movl	%edx, %r12d
movl	%r8d, %eax
xorl	%edx, %edx
movl	$0xfff1, %ecx
divl	%ecx
shll	$0x10, %edx
orl	%r12d, %edx
movl	%edx, %eax
adler32_avx2_4.end:
popq	%r13
popq	%r12
retq
	.section .data
A_SCALE:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0
	.byte 4,0,0,0,5,0,0,0,6,0,0,0,7,0,0,0
SHUF0:
	.byte 0,255,255,255,1,255,255,255,2,255,255,255,3,255,255,255
	.byte 4,255,255,255,5,255,255,255,6,255,255,255,7,255,255,255
SHUF1:
	.byte 8,255,255,255,9,255,255,255,10,255,255,255,11,255,255,255
	.byte 12,255,255,255,13,255,255,255,14,255,255,255,15,255,255,255

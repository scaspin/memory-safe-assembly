	.text
adler32_sse:
endbr64
pushq	%r12
pushq	%r13
movq	%rsi, %r9
movq	%rdx, %r10
movl	%edi, %r8d
shrl	$0x10, %r8d
andl	$0xffff, %edi
cmpq	$0x20, %r10
jb	adler32_sse.lt64
movd	%edi, %xmm0
pxor	%xmm1, %xmm1
adler32_sse.sloop1:
movl	$0x15b0, %r11d
cmpq	%r10, %r11
cmovaq	%r10, %r11
leaq	-0x7(%r9,%r11), %r13
cmpq	%r13, %r9
jae	adler32_sse.skip_loop_1a
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
nop
nop
nop
nop
adler32_sse.sloop1a:
pmovzxbd	(%r9), %xmm2
pmovzxbd	0x4(%r9), %xmm3
addq	$0x8, %r9
paddd	%xmm2, %xmm0
paddd	%xmm0, %xmm1
paddd	%xmm3, %xmm0
paddd	%xmm0, %xmm1
cmpq	%r13, %r9
jb	adler32_sse.sloop1a
adler32_sse.skip_loop_1a:
addq	$0x7, %r13
testq	$0x7, %r11
jne	adler32_sse.do_final
subq	%r11, %r10
pslld	$0x2, %xmm1
movdqa	%xmm0, %xmm4
pmulld	A_SCALE(%rip), %xmm4
phaddd	%xmm0, %xmm0
phaddd	%xmm1, %xmm1
phaddd	%xmm4, %xmm4
phaddd	%xmm0, %xmm0
phaddd	%xmm1, %xmm1
phaddd	%xmm4, %xmm4
movd	%xmm0, %eax
xorl	%edx, %edx
movl	$0xfff1, %ecx
divl	%ecx
movl	%edx, %r12d
psubd	%xmm4, %xmm1
movd	%xmm1, %eax
addl	%r8d, %eax
xorl	%edx, %edx
movl	$0xfff1, %ecx
divl	%ecx
movl	%edx, %r8d
testq	%r10, %r10
je	adler32_sse.finish
movd	%r12d, %xmm0
pxor	%xmm1, %xmm1
jmp	adler32_sse.sloop1
adler32_sse.finish:
movl	%r8d, %eax
shll	$0x10, %eax
orl	%r12d, %eax
jmp	adler32_sse.end
adler32_sse.lt64:
movl	%edi, %r12d
leaq	(%r9,%r10), %r13
testq	%r10, %r10
jne	adler32_sse.final_loop
jmp	adler32_sse.zero_size
adler32_sse.do_final:
pslld	$0x2, %xmm1
movdqa	%xmm0, %xmm4
pmulld	A_SCALE(%rip), %xmm4
phaddd	%xmm0, %xmm0
phaddd	%xmm1, %xmm1
phaddd	%xmm4, %xmm4
phaddd	%xmm0, %xmm0
phaddd	%xmm1, %xmm1
phaddd	%xmm4, %xmm4
psubd	%xmm4, %xmm1
movd	%xmm0, %r12d
movd	%xmm1, %eax
addl	%eax, %r8d
adler32_sse.final_loop:
movzbl	(%r9), %eax
addl	%eax, %r12d
incq	%r9
addl	%r12d, %r8d
cmpq	%r13, %r9
jb	adler32_sse.final_loop
adler32_sse.zero_size:
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
adler32_sse.end:
popq	%r13
popq	%r12
retq
	.section .data
A_SCALE:
	.byte 0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0

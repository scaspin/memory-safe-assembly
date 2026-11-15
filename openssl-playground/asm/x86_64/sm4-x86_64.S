	.text
hw_x86_64_sm4_set_key:
endbr64
pushq	%rbp
vmovdqu	(%rdi), %xmm0
vpshufb	IN_SHUFB(%rip), %xmm0, %xmm0
vpxor	SM4_FK(%rip), %xmm0, %xmm0
vmovdqu	SM4_CK(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, (%rsi)
vmovdqu	SM4_CK+16(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x10(%rsi)
vmovdqu	SM4_CK+32(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x20(%rsi)
vmovdqu	SM4_CK+48(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x30(%rsi)
vmovdqu	IN_SHUFB-64(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x40(%rsi)
vmovdqu	IN_SHUFB-48(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x50(%rsi)
vmovdqu	IN_SHUFB-32(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x60(%rsi)
vmovdqu	IN_SHUFB-16(%rip), %xmm1
vsm4key4	%xmm1, %xmm0, %xmm0
vmovdqu	%xmm0, 0x70(%rsi)
vpxor	%xmm0, %xmm0, %xmm0
movl	$0x1, %eax
popq	%rbp
rep	retq
nopw	%cs:(%rax,%rax)
nop
hw_x86_64_sm4_encrypt:
endbr64
pushq	%rbp
vmovdqu	(%rdi), %xmm0
vpshufb	IN_SHUFB(%rip), %xmm0, %xmm0
movq	%rdx, %r10
vsm4rnds4	(%r10), %xmm0, %xmm0
vsm4rnds4	0x10(%r10), %xmm0, %xmm0
vsm4rnds4	0x20(%r10), %xmm0, %xmm0
vsm4rnds4	0x30(%r10), %xmm0, %xmm0
vsm4rnds4	0x40(%r10), %xmm0, %xmm0
vsm4rnds4	0x50(%r10), %xmm0, %xmm0
vsm4rnds4	0x60(%r10), %xmm0, %xmm0
vsm4rnds4	0x70(%r10), %xmm0, %xmm0
vpshufb	OUT_SHUFB(%rip), %xmm0, %xmm0
vmovdqu	%xmm0, (%rsi)
vpxor	%xmm0, %xmm0, %xmm0
popq	%rbp
rep	retq
nopl	(%rax,%rax)
hw_x86_64_sm4_decrypt:
endbr64
pushq	%rbp
vmovdqu	(%rdi), %xmm0
vpshufb	IN_SHUFB(%rip), %xmm0, %xmm0
vmovdqu	0x70(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	0x60(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	0x50(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	0x40(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	0x30(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	0x20(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	0x10(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vmovdqu	(%rdx), %xmm1
vpshufd	$0x1b, %xmm1, %xmm1
vsm4rnds4	%xmm1, %xmm0, %xmm0
vpshufb	OUT_SHUFB(%rip), %xmm0, %xmm0
vmovdqu	%xmm0, (%rsi)
vpxor	%xmm0, %xmm0, %xmm0
vpxor	%xmm1, %xmm1, %xmm1
popq	%rbp
rep	retq
	.section .rodata
SM4_FK:
	.byte 198,186,177,163,80,51,170,86,151,145,125,103,220,34,112,178
SM4_CK:
	.byte 21,14,7,0,49,42,35,28,77,70,63,56,105,98,91,84
	.byte 133,126,119,112,161,154,147,140,189,182,175,168,217,210,203,196
	.byte 245,238,231,224,17,10,3,252,45,38,31,24,73,66,59,52
	.byte 101,94,87,80,129,122,115,108,157,150,143,136,185,178,171,164
	.byte 213,206,199,192,241,234,227,220,13,6,255,248,41,34,27,20
	.byte 69,62,55,48,97,90,83,76,125,118,111,104,153,146,139,132
	.byte 181,174,167,160,209,202,195,188,237,230,223,216,9,2,251,244
	.byte 37,30,23,16,65,58,51,44,93,86,79,72,121,114,107,100
IN_SHUFB:
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
	.byte 3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12
OUT_SHUFB:
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0

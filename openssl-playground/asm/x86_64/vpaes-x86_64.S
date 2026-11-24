	.text
_vpaes_encrypt_core:
movq	%rdx, %r9
movq	$0x10, %r11
movl	0xf0(%rdx), %eax
movdqa	%xmm9, %xmm1
movdqa	_vpaes_consts+48(%rip), %xmm2
pandn	%xmm0, %xmm1
movdqu	(%r9), %xmm5
psrld	$0x4, %xmm1
pand	%xmm9, %xmm0
pshufb	%xmm0, %xmm2
movdqa	_vpaes_consts+64(%rip), %xmm0
pshufb	%xmm1, %xmm0
pxor	%xmm5, %xmm2
addq	$0x10, %r9
pxor	%xmm2, %xmm0
leaq	_vpaes_consts+240(%rip), %r10
jmp	L_d0
nopw	(%rax,%rax)
L_60:
movdqa	%xmm13, %xmm4
movdqa	%xmm12, %xmm0
pshufb	%xmm2, %xmm4
pshufb	%xmm3, %xmm0
pxor	%xmm5, %xmm4
movdqa	%xmm15, %xmm5
pxor	%xmm4, %xmm0
movdqa	-0x40(%r11,%r10), %xmm1
pshufb	%xmm2, %xmm5
movdqa	(%r11,%r10), %xmm4
movdqa	%xmm14, %xmm2
pshufb	%xmm3, %xmm2
movdqa	%xmm0, %xmm3
pxor	%xmm5, %xmm2
pshufb	%xmm1, %xmm0
addq	$0x10, %r9
pxor	%xmm2, %xmm0
pshufb	%xmm4, %xmm3
addq	$0x10, %r11
pxor	%xmm0, %xmm3
pshufb	%xmm1, %xmm0
andq	$0x30, %r11
subq	$0x1, %rax
pxor	%xmm3, %xmm0
L_d0:
movdqa	%xmm9, %xmm1
movdqa	%xmm11, %xmm5
pandn	%xmm0, %xmm1
psrld	$0x4, %xmm1
pand	%xmm9, %xmm0
pshufb	%xmm0, %xmm5
movdqa	%xmm10, %xmm3
pxor	%xmm1, %xmm0
pshufb	%xmm1, %xmm3
movdqa	%xmm10, %xmm4
pxor	%xmm5, %xmm3
pshufb	%xmm0, %xmm4
movdqa	%xmm10, %xmm2
pxor	%xmm5, %xmm4
pshufb	%xmm3, %xmm2
movdqa	%xmm10, %xmm3
pxor	%xmm0, %xmm2
pshufb	%xmm4, %xmm3
movdqu	(%r9), %xmm5
pxor	%xmm1, %xmm3
jne	L_60
movdqa	-0x60(%r10), %xmm4
movdqa	-0x50(%r10), %xmm0
pshufb	%xmm2, %xmm4
pxor	%xmm5, %xmm4
pshufb	%xmm3, %xmm0
movdqa	0x40(%r11,%r10), %xmm1
pxor	%xmm4, %xmm0
pshufb	%xmm1, %xmm0
rep	retq
_vpaes_decrypt_core:
movq	%rdx, %r9
movl	0xf0(%rdx), %eax
movdqa	%xmm9, %xmm1
movdqa	_vpaes_consts+592(%rip), %xmm2
pandn	%xmm0, %xmm1
movq	%rax, %r11
psrld	$0x4, %xmm1
movdqu	(%r9), %xmm5
shlq	$0x4, %r11
pand	%xmm9, %xmm0
pshufb	%xmm0, %xmm2
movdqa	_vpaes_consts+608(%rip), %xmm0
xorq	$0x30, %r11
leaq	_vpaes_consts+656(%rip), %r10
pshufb	%xmm1, %xmm0
andq	$0x30, %r11
pxor	%xmm5, %xmm2
movdqa	_vpaes_consts+224(%rip), %xmm5
pxor	%xmm2, %xmm0
addq	$0x10, %r9
addq	%r10, %r11
jmp	L_264
nopl	(%rax)
L_1d0:
movdqa	-0x20(%r10), %xmm4
movdqa	-0x10(%r10), %xmm1
pshufb	%xmm2, %xmm4
pshufb	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	(%r10), %xmm4
pxor	%xmm1, %xmm0
movdqa	0x10(%r10), %xmm1
pshufb	%xmm2, %xmm4
pshufb	%xmm5, %xmm0
pshufb	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	0x20(%r10), %xmm4
pxor	%xmm1, %xmm0
movdqa	0x30(%r10), %xmm1
pshufb	%xmm2, %xmm4
pshufb	%xmm5, %xmm0
pshufb	%xmm3, %xmm1
pxor	%xmm4, %xmm0
movdqa	0x40(%r10), %xmm4
pxor	%xmm1, %xmm0
movdqa	0x50(%r10), %xmm1
pshufb	%xmm2, %xmm4
pshufb	%xmm5, %xmm0
pshufb	%xmm3, %xmm1
pxor	%xmm4, %xmm0
addq	$0x10, %r9
palignr	$0xc, %xmm5, %xmm5
pxor	%xmm1, %xmm0
subq	$0x1, %rax
L_264:
movdqa	%xmm9, %xmm1
pandn	%xmm0, %xmm1
movdqa	%xmm11, %xmm2
psrld	$0x4, %xmm1
pand	%xmm9, %xmm0
pshufb	%xmm0, %xmm2
movdqa	%xmm10, %xmm3
pxor	%xmm1, %xmm0
pshufb	%xmm1, %xmm3
movdqa	%xmm10, %xmm4
pxor	%xmm2, %xmm3
pshufb	%xmm0, %xmm4
pxor	%xmm2, %xmm4
movdqa	%xmm10, %xmm2
pshufb	%xmm3, %xmm2
movdqa	%xmm10, %xmm3
pxor	%xmm0, %xmm2
pshufb	%xmm4, %xmm3
movdqu	(%r9), %xmm0
pxor	%xmm1, %xmm3
jne	L_1d0
movdqa	0x60(%r10), %xmm4
pshufb	%xmm2, %xmm4
pxor	%xmm0, %xmm4
movdqa	0x70(%r10), %xmm0
movdqa	-0x160(%r11), %xmm2
pshufb	%xmm3, %xmm0
pxor	%xmm4, %xmm0
pshufb	%xmm2, %xmm0
rep	retq
nopw	%cs:(%rax,%rax)
_vpaes_schedule_core:
callq	_vpaes_preheat
movdqa	_vpaes_consts+368(%rip), %xmm8
movdqu	(%rdi), %xmm0
movdqa	%xmm0, %xmm3
leaq	_vpaes_consts+48(%rip), %r11
callq	_vpaes_schedule_transform
movdqa	%xmm0, %xmm7
leaq	_vpaes_consts+304(%rip), %r10
testq	%rcx, %rcx
jne	L_338
movdqu	%xmm0, (%rdx)
jmp	L_34b
L_338:
movdqa	(%r8,%r10), %xmm1
pshufb	%xmm1, %xmm3
movdqu	%xmm3, (%rdx)
xorq	$0x30, %r8
L_34b:
cmpl	$0xc0, %esi
ja	L_3c0
je	L_370
movl	$0xa, %esi
L_35a:
callq	_vpaes_schedule_round
decq	%rsi
je	L_400
callq	_vpaes_schedule_mangle
jmp	L_35a
nop
L_370:
movdqu	0x8(%rdi), %xmm0
callq	_vpaes_schedule_transform
movdqa	%xmm0, %xmm6
pxor	%xmm4, %xmm4
movhlps	%xmm4, %xmm6
movl	$0x4, %esi
L_38a:
callq	_vpaes_schedule_round
palignr	$0x8, %xmm6, %xmm0
callq	_vpaes_schedule_mangle
callq	_vpaes_schedule_192_smear
callq	_vpaes_schedule_mangle
callq	_vpaes_schedule_round
decq	%rsi
je	L_400
callq	_vpaes_schedule_mangle
callq	_vpaes_schedule_192_smear
jmp	L_38a
nopw	(%rax,%rax)
L_3c0:
movdqu	0x10(%rdi), %xmm0
callq	_vpaes_schedule_transform
movl	$0x7, %esi
L_3cf:
callq	_vpaes_schedule_mangle
movdqa	%xmm0, %xmm6
callq	_vpaes_schedule_round
decq	%rsi
je	L_400
callq	_vpaes_schedule_mangle
pshufd	$0xff, %xmm0, %xmm0
movdqa	%xmm7, %xmm5
movdqa	%xmm6, %xmm7
callq	_vpaes_schedule_low_round
movdqa	%xmm5, %xmm7
jmp	L_3cf
nop
L_400:
leaq	_vpaes_consts+432(%rip), %r11
testq	%rcx, %rcx
jne	L_422
movdqa	(%r8,%r10), %xmm1
pshufb	%xmm1, %xmm0
leaq	_vpaes_consts+400(%rip), %r11
addq	$0x20, %rdx
L_422:
addq	$-0x10, %rdx
pxor	_vpaes_consts+384(%rip), %xmm0
callq	_vpaes_schedule_transform
movdqu	%xmm0, (%rdx)
pxor	%xmm0, %xmm0
pxor	%xmm1, %xmm1
pxor	%xmm2, %xmm2
pxor	%xmm3, %xmm3
pxor	%xmm4, %xmm4
pxor	%xmm5, %xmm5
pxor	%xmm6, %xmm6
pxor	%xmm7, %xmm7
rep	retq
nopl	(%rax)
_vpaes_schedule_192_smear:
pshufd	$0x80, %xmm6, %xmm1
pshufd	$0xfe, %xmm7, %xmm0
pxor	%xmm1, %xmm6
pxor	%xmm1, %xmm1
pxor	%xmm0, %xmm6
movdqa	%xmm6, %xmm0
movhlps	%xmm1, %xmm6
rep	retq
nop
_vpaes_schedule_round:
pxor	%xmm1, %xmm1
palignr	$0xf, %xmm8, %xmm1
palignr	$0xf, %xmm8, %xmm8
pxor	%xmm1, %xmm7
pshufd	$0xff, %xmm0, %xmm0
palignr	$0x1, %xmm0, %xmm0
_vpaes_schedule_low_round:
movdqa	%xmm7, %xmm1
pslldq	$0x4, %xmm7
pxor	%xmm1, %xmm7
movdqa	%xmm7, %xmm1
pslldq	$0x8, %xmm7
pxor	%xmm1, %xmm7
pxor	_vpaes_consts+384(%rip), %xmm7
movdqa	%xmm9, %xmm1
pandn	%xmm0, %xmm1
psrld	$0x4, %xmm1
pand	%xmm9, %xmm0
movdqa	%xmm11, %xmm2
pshufb	%xmm0, %xmm2
pxor	%xmm1, %xmm0
movdqa	%xmm10, %xmm3
pshufb	%xmm1, %xmm3
pxor	%xmm2, %xmm3
movdqa	%xmm10, %xmm4
pshufb	%xmm0, %xmm4
pxor	%xmm2, %xmm4
movdqa	%xmm10, %xmm2
pshufb	%xmm3, %xmm2
pxor	%xmm0, %xmm2
movdqa	%xmm10, %xmm3
pshufb	%xmm4, %xmm3
pxor	%xmm1, %xmm3
movdqa	%xmm13, %xmm4
pshufb	%xmm2, %xmm4
movdqa	%xmm12, %xmm0
pshufb	%xmm3, %xmm0
pxor	%xmm4, %xmm0
pxor	%xmm7, %xmm0
movdqa	%xmm0, %xmm7
rep	retq
nop
_vpaes_schedule_transform:
movdqa	%xmm9, %xmm1
pandn	%xmm0, %xmm1
psrld	$0x4, %xmm1
pand	%xmm9, %xmm0
movdqa	(%r11), %xmm2
pshufb	%xmm0, %xmm2
movdqa	0x10(%r11), %xmm0
pshufb	%xmm1, %xmm0
pxor	%xmm2, %xmm0
rep	retq
nop
_vpaes_schedule_mangle:
movdqa	%xmm0, %xmm4
movdqa	_vpaes_consts+176(%rip), %xmm5
testq	%rcx, %rcx
jne	L_5b0
addq	$0x10, %rdx
pxor	_vpaes_consts+384(%rip), %xmm4
pshufb	%xmm5, %xmm4
movdqa	%xmm4, %xmm3
pshufb	%xmm5, %xmm4
pxor	%xmm4, %xmm3
pshufb	%xmm5, %xmm4
pxor	%xmm4, %xmm3
jmp	L_650
nopl	(%rax)
L_5b0:
leaq	_vpaes_consts+464(%rip), %r11
movdqa	%xmm9, %xmm1
pandn	%xmm4, %xmm1
psrld	$0x4, %xmm1
pand	%xmm9, %xmm4
movdqa	(%r11), %xmm2
pshufb	%xmm4, %xmm2
movdqa	0x10(%r11), %xmm3
pshufb	%xmm1, %xmm3
pxor	%xmm2, %xmm3
pshufb	%xmm5, %xmm3
movdqa	0x20(%r11), %xmm2
pshufb	%xmm4, %xmm2
pxor	%xmm3, %xmm2
movdqa	0x30(%r11), %xmm3
pshufb	%xmm1, %xmm3
pxor	%xmm2, %xmm3
pshufb	%xmm5, %xmm3
movdqa	0x40(%r11), %xmm2
pshufb	%xmm4, %xmm2
pxor	%xmm3, %xmm2
movdqa	0x50(%r11), %xmm3
pshufb	%xmm1, %xmm3
pxor	%xmm2, %xmm3
pshufb	%xmm5, %xmm3
movdqa	0x60(%r11), %xmm2
pshufb	%xmm4, %xmm2
pxor	%xmm3, %xmm2
movdqa	0x70(%r11), %xmm3
pshufb	%xmm1, %xmm3
pxor	%xmm2, %xmm3
addq	$-0x10, %rdx
L_650:
movdqa	(%r8,%r10), %xmm1
pshufb	%xmm1, %xmm3
addq	$-0x10, %r8
andq	$0x30, %r8
movdqu	%xmm3, (%rdx)
rep	retq
nopl	(%rax)
vpaes_set_encrypt_key:
endbr64
movl	%esi, %eax
shrl	$0x5, %eax
addl	$0x5, %eax
movl	%eax, 0xf0(%rdx)
movl	$0x0, %ecx
movl	$0x30, %r8d
callq	_vpaes_schedule_core
xorl	%eax, %eax
rep	retq
nopw	%cs:(%rax,%rax)
vpaes_set_decrypt_key:
endbr64
movl	%esi, %eax
shrl	$0x5, %eax
addl	$0x5, %eax
movl	%eax, 0xf0(%rdx)
shll	$0x4, %eax
leaq	0x10(%rdx,%rax), %rdx
movl	$0x1, %ecx
movl	%esi, %r8d
shrl	%r8d
andl	$0x20, %r8d
xorl	$0x20, %r8d
callq	_vpaes_schedule_core
xorl	%eax, %eax
rep	retq
nopw	%cs:(%rax,%rax)
vpaes_encrypt:
endbr64
movdqu	(%rdi), %xmm0
callq	_vpaes_preheat
callq	_vpaes_encrypt_core
movdqu	%xmm0, (%rsi)
rep	retq
nopl	(%rax,%rax)
vpaes_decrypt:
endbr64
movdqu	(%rdi), %xmm0
callq	_vpaes_preheat
callq	_vpaes_decrypt_core
movdqu	%xmm0, (%rsi)
rep	retq
nopl	(%rax,%rax)
vpaes_cbc_encrypt:
endbr64
xchgq	%rcx, %rdx
subq	$0x10, %rcx
jb	L_7a9
movdqu	(%r8), %xmm6
subq	%rdi, %rsi
callq	_vpaes_preheat
cmpl	$0x0, %r9d
je	L_780
jmp	L_750
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_750:
movdqu	(%rdi), %xmm0
pxor	%xmm6, %xmm0
callq	_vpaes_encrypt_core
movdqa	%xmm0, %xmm6
movdqu	%xmm0, (%rsi,%rdi)
leaq	0x10(%rdi), %rdi
subq	$0x10, %rcx
jae	L_750
jmp	L_7a4
nopw	%cs:(%rax,%rax)
nopl	(%rax)
L_780:
movdqu	(%rdi), %xmm0
movdqa	%xmm0, %xmm7
callq	_vpaes_decrypt_core
pxor	%xmm6, %xmm0
movdqa	%xmm7, %xmm6
movdqu	%xmm0, (%rsi,%rdi)
leaq	0x10(%rdi), %rdi
subq	$0x10, %rcx
jae	L_780
L_7a4:
movdqu	%xmm6, (%r8)
L_7a9:
rep	retq
nopl	(%rax,%rax)
_vpaes_preheat:
leaq	_vpaes_consts+32(%rip), %r10
movdqa	-0x20(%r10), %xmm10
movdqa	-0x10(%r10), %xmm11
movdqa	(%r10), %xmm9
movdqa	0x30(%r10), %xmm13
movdqa	0x40(%r10), %xmm12
movdqa	0x50(%r10), %xmm15
movdqa	0x60(%r10), %xmm14
rep	retq
	.section .rodata
	.p2align 6
_vpaes_consts:
	.size _vpaes_consts, 832
	.byte 128,1,8,13,15,6,5,14,2,12,11,10,9,3,7,4
	.byte 128,7,11,15,6,10,4,1,9,8,5,2,12,14,13,3
	.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	.byte 0,112,42,90,152,232,178,194,8,120,34,82,144,224,186,202
	.byte 0,77,124,49,125,48,1,76,129,204,253,176,252,177,128,205
	.byte 0,62,80,203,143,225,155,177,68,245,42,20,110,122,223,165
	.byte 0,35,226,250,21,212,24,54,239,217,46,13,193,204,247,59
	.byte 0,36,113,11,198,147,122,226,205,47,152,188,85,233,183,94
	.byte 0,41,225,10,64,136,235,105,74,35,130,171,200,99,161,194
	.byte 0,199,189,111,23,109,210,208,120,168,2,197,122,191,170,21
	.byte 0,106,187,95,165,116,228,207,250,53,43,65,209,144,30,142
	.byte 1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12
	.byte 5,6,7,4,9,10,11,8,13,14,15,12,1,2,3,0
	.byte 9,10,11,8,13,14,15,12,1,2,3,0,5,6,7,4
	.byte 13,14,15,12,1,2,3,0,5,6,7,4,9,10,11,8
	.byte 3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14
	.byte 15,12,13,14,3,0,1,2,7,4,5,6,11,8,9,10
	.byte 11,8,9,10,15,12,13,14,3,0,1,2,7,4,5,6
	.byte 7,4,5,6,11,8,9,10,15,12,13,14,3,0,1,2
	.byte 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	.byte 0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11
	.byte 0,9,2,11,4,13,6,15,8,1,10,3,12,5,14,7
	.byte 0,13,10,7,4,1,14,11,8,5,2,15,12,9,6,3
	.byte 182,238,157,175,185,145,131,31,129,125,124,77,8,152,42,112
	.byte 91,91,91,91,91,91,91,91,91,91,91,91,91,91,91,91
	.byte 0,96,182,214,41,73,159,255,8,104,190,222,33,65,151,247
	.byte 0,236,188,80,81,189,237,1,224,12,92,176,177,93,13,225
	.byte 0,227,164,71,64,163,228,7,26,249,190,93,90,185,254,29
	.byte 0,105,234,131,220,181,54,95,119,30,157,244,171,194,65,40
	.byte 0,71,228,163,93,26,185,254,249,190,29,90,164,227,64,7
	.byte 0,131,54,181,244,119,194,65,30,157,40,171,234,105,220,95
	.byte 0,213,80,133,31,202,79,154,153,76,201,28,134,83,214,3
	.byte 0,74,252,182,167,237,91,17,200,130,52,126,111,37,147,217
	.byte 0,214,201,31,202,28,3,213,134,80,79,153,76,154,133,83
	.byte 232,123,220,79,5,150,49,162,135,20,179,32,106,249,94,205
	.byte 0,167,217,126,200,111,17,182,252,91,37,130,52,147,237,74
	.byte 0,51,20,39,98,81,118,69,206,253,218,233,172,159,184,139
	.byte 0,95,84,11,4,91,80,15,26,69,78,17,30,65,74,21
	.byte 0,101,5,96,230,131,227,134,148,241,145,244,114,23,119,18
	.byte 0,214,134,154,83,3,28,133,201,76,153,79,80,31,213,202
	.byte 0,73,215,236,137,23,59,192,101,165,251,178,158,44,94,114
	.byte 0,162,177,230,223,204,87,125,57,68,42,136,19,155,110,245
	.byte 0,203,198,36,247,250,226,60,211,239,222,21,13,24,49,41
	.byte 0,66,180,150,146,100,34,208,4,212,242,176,246,70,38,96
	.byte 0,103,89,205,166,152,148,193,107,170,85,50,62,12,255,243
	.byte 0,208,212,38,150,146,242,70,176,246,180,100,4,96,66,34
	.byte 0,193,170,255,205,166,85,12,50,62,89,152,107,243,103,148
	.byte 0,64,249,126,83,234,135,19,45,62,148,212,185,109,170,199
	.byte 0,29,68,147,15,86,215,18,156,142,197,216,89,129,75,202
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 86,101,99,116,111,114,32,80,101,114,109,117,116,97,116,105
	.byte 111,110,32,65,69,83,32,102,111,114,32,120,56,54,95,54
	.byte 52,47,83,83,83,69,51,44,32,77,105,107,101,32,72,97
	.byte 109,98,117,114,103,32,40,83,116,97,110,102,111,114,100,32
	.byte 85,110,105,118,101,114,115,105,116,121,41,0

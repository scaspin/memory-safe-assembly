	.text
crc32_iscsi_3crc_fold:
cbz	x1, .zero_length_ret
tbz	w0, #0x0, .align_short
ldrb	w3, [x0], #0x1
sub	x1, x1, #0x1
crc32cb	w2, w2, w3
.align_short:
tst	x0, #0x2
ccmp	x1, #0x1, #0x0, ne
b.hi	.align_short_2
tst	x0, #0x4
ccmp	x1, #0x3, #0x0, ne
b.hi	.align_word
.align_finish:
cmp	x1, #0x3ff
adr	x3, L_50c
b.ls	L_408
ldp	d2, d3, [x3]
L_3c:
ldr	x9, [x0], #0x8
prfm	pldl2keep, [x0, #0xbf8]
mov	w3, #0x0
mov	w4, #0x0
add	x6, x0, #0x150
add	x7, x0, #0x2a0
crc32cx	w2, w2, x9
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xc28]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xc58]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xc88]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xcb8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xce8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xd18]
prfm	pldl1keep, [x0, #0x798]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xd48]
prfm	pldl1keep, [x0, #0x7c8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xd78]
prfm	pldl1keep, [x0, #0x7f8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xda8]
prfm	pldl1keep, [x0, #0x828]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xdd8]
prfm	pldl1keep, [x0, #0x858]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xe08]
prfm	pldl1keep, [x0, #0x888]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xe38]
prfm	pldl1keep, [x0, #0x8b8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xe68]
prfm	pldl1keep, [x0, #0x8e8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xe98]
prfm	pldl1keep, [x0, #0x918]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x0, #0xec8]
prfm	pldl1keep, [x0, #0x948]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x0, #0x978]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x0, #0x9a8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x0, #0x9d8]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x0, #0xa08]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x0, #0xa38]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldp	x9, x10, [x0], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x0, #0xa68]
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x13, x14, [x7], #0x10
crc32cx	w3, w3, x11
crc32cx	w3, w3, x12
crc32cx	w4, w4, x13
crc32cx	w4, w4, x14
ldr	x13, [x7]
fmov	d0, x2
fmov	d1, x3
crc32cx	w4, w4, x13
add	x0, x0, #0x2a8
pmull	v0.1q, v0.1d, v2.1d
sub	x1, x1, #0x400
pmull	v1.1q, v1.1d, v3.1d
cmp	x1, #0x400
fmov	x2, d0
fmov	x3, d1
crc32cx	w2, wzr, x2
crc32cx	w3, wzr, x3
eor	w2, w2, w4
eor	w2, w2, w3
b.hs	L_3c
L_408:
cmp	x1, #0x3f
b.ls	.loop_16B
.loop_64B:
ldp	x3, x4, [x0], #0x10
sub	x1, x1, #0x40
ldp	x5, x6, [x0], #0x10
cmp	x1, #0x40
crc32cx	w2, w2, x3
crc32cx	w2, w2, x4
ldp	x3, x4, [x0], #0x10
crc32cx	w2, w2, x5
crc32cx	w2, w2, x6
ldp	x5, x6, [x0], #0x10
crc32cx	w2, w2, x3
crc32cx	w2, w2, x4
crc32cx	w2, w2, x5
crc32cx	w2, w2, x6
b.ge	.loop_64B
.loop_16B:
cmp	x1, #0xf
b.ls	.less_16B
ldp	x3, x4, [x0], #0x10
sub	x1, x1, #0x10
cmp	x1, #0xf
crc32cx	w2, w2, x3
crc32cx	w2, w2, x4
b.ls	.less_16B
ldp	x3, x4, [x0], #0x10
sub	x1, x1, #0x10
cmp	x1, #0xf
crc32cx	w2, w2, x3
crc32cx	w2, w2, x4
b.ls	.less_16B
ldp	x3, x4, [x0], #0x10
sub	x1, x1, #0x10
crc32cx	w2, w2, x3
crc32cx	w2, w2, x4
.less_16B:
cmp	x1, #0x7
b.ls	.less_8B
ldr	x3, [x0], #0x8
sub	x1, x1, #0x8
crc32cx	w2, w2, x3
.less_8B:
cmp	x1, #0x3
b.ls	.less_4B
ldr	w3, [x0], #0x4
sub	x1, x1, #0x4
crc32cw	w2, w2, w3
.less_4B:
cmp	x1, #0x1
b.ls	.less_2B
ldrh	w3, [x0], #0x2
sub	x1, x1, #0x2
crc32ch	w2, w2, w3
.less_2B:
cbz	x1, .zero_length_ret
ldrb	w3, [x0]
crc32cb	w2, w2, w3
.zero_length_ret:
mov	w0, w2
ret
.align_short_2:
ldrh	w3, [x0], #0x2
sub	x1, x1, #0x2
tst	x0, #0x4
crc32ch	w2, w2, w3
ccmp	x1, #0x3, #0x0, ne
b.ls	.align_finish
.align_word:
ldr	w3, [x0], #0x4
sub	x1, x1, #0x4
crc32cw	w2, w2, w3
b	.align_finish
	.section .text_data
L_50c:
	.word 0xe417f38a
	.word 0x00000000
	.word 0x8f158014
	.word 0x00000000

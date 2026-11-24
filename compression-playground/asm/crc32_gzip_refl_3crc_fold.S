	.text
crc32_gzip_refl_3crc_fold:
mvn	w0, w0
cbz	x2, .zero_length_ret
tbz	w1, #0x0, .align_short
ldrb	w3, [x1], #0x1
sub	x2, x2, #0x1
crc32b	w0, w0, w3
.align_short:
tst	x1, #0x2
ccmp	x2, #0x1, #0x0, ne
b.hi	.align_short_2
tst	x1, #0x4
ccmp	x2, #0x3, #0x0, ne
b.hi	.align_word
.align_finish:
cmp	x2, #0x3ff
adr	x3, L_510
b.ls	L_40c
ldp	d2, d3, [x3]
L_40:
ldr	x9, [x1], #0x8
prfm	pldl2keep, [x1, #0xbf8]
mov	w3, #0x0
mov	w4, #0x0
add	x6, x1, #0x150
add	x7, x1, #0x2a0
crc32x	w0, w0, x9
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xc28]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xc58]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xc88]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xcb8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xce8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xd18]
prfm	pldl1keep, [x1, #0x798]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xd48]
prfm	pldl1keep, [x1, #0x7c8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xd78]
prfm	pldl1keep, [x1, #0x7f8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xda8]
prfm	pldl1keep, [x1, #0x828]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xdd8]
prfm	pldl1keep, [x1, #0x858]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xe08]
prfm	pldl1keep, [x1, #0x888]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xe38]
prfm	pldl1keep, [x1, #0x8b8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xe68]
prfm	pldl1keep, [x1, #0x8e8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xe98]
prfm	pldl1keep, [x1, #0x918]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl2keep, [x1, #0xec8]
prfm	pldl1keep, [x1, #0x948]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x1, #0x978]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x1, #0x9a8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x1, #0x9d8]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x1, #0xa08]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x1, #0xa38]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldp	x9, x10, [x1], #0x10
ldp	x11, x12, [x6], #0x10
prfm	pldl1keep, [x1, #0xa68]
crc32x	w0, w0, x9
crc32x	w0, w0, x10
ldp	x13, x14, [x7], #0x10
crc32x	w3, w3, x11
crc32x	w3, w3, x12
crc32x	w4, w4, x13
crc32x	w4, w4, x14
ldr	x13, [x7]
fmov	d0, x0
fmov	d1, x3
crc32x	w4, w4, x13
add	x1, x1, #0x2a8
pmull	v0.1q, v0.1d, v2.1d
sub	x2, x2, #0x400
pmull	v1.1q, v1.1d, v3.1d
cmp	x2, #0x400
fmov	x0, d0
fmov	x3, d1
crc32x	w0, wzr, x0
crc32x	w3, wzr, x3
eor	w0, w0, w4
eor	w0, w0, w3
b.hs	L_40
L_40c:
cmp	x2, #0x3f
b.ls	.loop_16B
.loop_64B:
ldp	x3, x4, [x1], #0x10
sub	x2, x2, #0x40
ldp	x5, x6, [x1], #0x10
cmp	x2, #0x40
crc32x	w0, w0, x3
crc32x	w0, w0, x4
ldp	x3, x4, [x1], #0x10
crc32x	w0, w0, x5
crc32x	w0, w0, x6
ldp	x5, x6, [x1], #0x10
crc32x	w0, w0, x3
crc32x	w0, w0, x4
crc32x	w0, w0, x5
crc32x	w0, w0, x6
b.ge	.loop_64B
.loop_16B:
cmp	x2, #0xf
b.ls	.less_16B
ldp	x3, x4, [x1], #0x10
sub	x2, x2, #0x10
cmp	x2, #0xf
crc32x	w0, w0, x3
crc32x	w0, w0, x4
b.ls	.less_16B
ldp	x3, x4, [x1], #0x10
sub	x2, x2, #0x10
cmp	x2, #0xf
crc32x	w0, w0, x3
crc32x	w0, w0, x4
b.ls	.less_16B
ldp	x3, x4, [x1], #0x10
sub	x2, x2, #0x10
crc32x	w0, w0, x3
crc32x	w0, w0, x4
.less_16B:
cmp	x2, #0x7
b.ls	.less_8B
ldr	x3, [x1], #0x8
sub	x2, x2, #0x8
crc32x	w0, w0, x3
.less_8B:
cmp	x2, #0x3
b.ls	.less_4B
ldr	w3, [x1], #0x4
sub	x2, x2, #0x4
crc32w	w0, w0, w3
.less_4B:
cmp	x2, #0x1
b.ls	.less_2B
ldrh	w3, [x1], #0x2
sub	x2, x2, #0x2
crc32h	w0, w0, w3
.less_2B:
cbz	x2, .zero_length_ret
ldrb	w3, [x1]
crc32b	w0, w0, w3
.zero_length_ret:
mvn	w0, w0
ret
.align_short_2:
ldrh	w3, [x1], #0x2
sub	x2, x2, #0x2
tst	x1, #0x4
crc32h	w0, w0, w3
ccmp	x2, #0x3, #0x0, ne
b.ls	.align_finish
.align_word:
ldr	w3, [x1], #0x4
sub	x2, x2, #0x4
crc32w	w0, w0, w3
b	.align_finish
	.section .text_data
L_510:
	.word 0xb486819b
	.word 0x00000000
	.word 0x76278617
	.word 0x00000000

	.text
crc32_iscsi_crc_ext:
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
cmp	x1, #0x3f
b.ls	.loop_16B
.loop_64B:
ldp	x4, x5, [x0], #0x10
prfm	pldl2keep, [x0, #0x800]
sub	x1, x1, #0x40
ldp	x6, x7, [x0], #0x10
prfm	pldl1keep, [x0, #0x100]
cmp	x1, #0x40
crc32cx	w2, w2, x4
crc32cx	w2, w2, x5
ldp	x4, x5, [x0], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x0], #0x10
crc32cx	w2, w2, x4
crc32cx	w2, w2, x5
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
b.ge	.loop_64B
.loop_16B:
cmp	x1, #0xf
b.ls	.less_16B
ldp	x4, x5, [x0], #0x10
sub	x1, x1, #0x10
cmp	x1, #0xf
crc32cx	w2, w2, x4
crc32cx	w2, w2, x5
b.ls	.less_16B
ldp	x4, x5, [x0], #0x10
sub	x1, x1, #0x10
cmp	x1, #0xf
crc32cx	w2, w2, x4
crc32cx	w2, w2, x5
b.ls	.less_16B
ldp	x4, x5, [x0], #0x10
sub	x1, x1, #0x10
crc32cx	w2, w2, x4
crc32cx	w2, w2, x5
.less_16B:
cmp	x1, #0x7
b.ls	.less_8B
ldr	x4, [x0], #0x8
sub	x1, x1, #0x8
crc32cx	w2, w2, x4
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

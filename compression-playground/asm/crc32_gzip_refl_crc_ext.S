	.text
crc32_gzip_refl_crc_ext:
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
cmp	x2, #0x3f
b.ls	.loop_16B
.loop_64B:
ldp	x4, x5, [x1], #0x10
prfm	pldl2keep, [x1, #0x800]
sub	x2, x2, #0x40
ldp	x6, x7, [x1], #0x10
prfm	pldl1keep, [x1, #0x100]
cmp	x2, #0x40
crc32x	w0, w0, x4
crc32x	w0, w0, x5
ldp	x4, x5, [x1], #0x10
crc32x	w0, w0, x6
crc32x	w0, w0, x7
ldp	x6, x7, [x1], #0x10
crc32x	w0, w0, x4
crc32x	w0, w0, x5
crc32x	w0, w0, x6
crc32x	w0, w0, x7
b.ge	.loop_64B
.loop_16B:
cmp	x2, #0xf
b.ls	.less_16B
ldp	x4, x5, [x1], #0x10
sub	x2, x2, #0x10
cmp	x2, #0xf
crc32x	w0, w0, x4
crc32x	w0, w0, x5
b.ls	.less_16B
ldp	x4, x5, [x1], #0x10
sub	x2, x2, #0x10
cmp	x2, #0xf
crc32x	w0, w0, x4
crc32x	w0, w0, x5
b.ls	.less_16B
ldp	x4, x5, [x1], #0x10
sub	x2, x2, #0x10
crc32x	w0, w0, x4
crc32x	w0, w0, x5
.less_16B:
cmp	x2, #0x7
b.ls	.less_8B
ldr	x4, [x1], #0x8
sub	x2, x2, #0x8
crc32x	w0, w0, x4
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

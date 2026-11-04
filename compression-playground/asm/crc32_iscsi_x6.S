	.text
crc32_iscsi_x6:
stp	d8, d9, [sp, #-0xa0]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
stp	x19, x20, [sp, #0x40]
stp	x21, x22, [sp, #0x50]
stp	x23, x24, [sp, #0x60]
stp	x25, x26, [sp, #0x70]
stp	x27, x28, [sp, #0x80]
stp	x29, x30, [sp, #0x90]
cmp	w1, #0x0
b.le	.zero_length_ret
.align_finish:
cmp	x1, #0x400
b.ls	L_3f8
adrp	x8, bums_rodata
add	x8, x8, :lo12:bums_rodata
ldp	d5, d6, [x8]
ldp	d7, d8, [x8, #0x10]
ldr	d9, [x8, #0x20]
L_4c:
mov	w3, #0x0
mov	w4, #0x0
mov	w5, #0x0
mov	w6, #0x0
mov	w7, #0x0
ldr	x14, [x0], #0x8
crc32cx	w2, w2, x14
add	x9, x0, #0xa8
add	x10, x0, #0x150
add	x11, x0, #0x1f8
add	x12, x0, #0x2a0
add	x13, x0, #0x348
ldp	x14, x16, [x0], #0x10
ldp	x15, x17, [x9], #0x10
ldp	x24, x18, [x10], #0x10
ldp	x25, x19, [x11], #0x10
ldp	x22, x20, [x12], #0x10
ldp	x23, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x25
crc32cx	w6, w6, x22
crc32cx	w7, w7, x23
ldp	x14, x25, [x0], #0x10
ldp	x15, x22, [x9], #0x10
ldp	x24, x23, [x10], #0x10
crc32cx	w2, w2, x16
crc32cx	w3, w3, x17
crc32cx	w4, w4, x18
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x16, x19, [x11], #0x10
ldp	x17, x20, [x12], #0x10
ldp	x18, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x16
crc32cx	w6, w6, x17
crc32cx	w7, w7, x18
ldp	x14, x16, [x0], #0x10
ldp	x15, x17, [x9], #0x10
ldp	x24, x18, [x10], #0x10
crc32cx	w2, w2, x25
crc32cx	w3, w3, x22
crc32cx	w4, w4, x23
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x25, x19, [x11], #0x10
ldp	x22, x20, [x12], #0x10
ldp	x23, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x25
crc32cx	w6, w6, x22
crc32cx	w7, w7, x23
ldp	x14, x25, [x0], #0x10
ldp	x15, x22, [x9], #0x10
ldp	x24, x23, [x10], #0x10
crc32cx	w2, w2, x16
crc32cx	w3, w3, x17
crc32cx	w4, w4, x18
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x16, x19, [x11], #0x10
ldp	x17, x20, [x12], #0x10
ldp	x18, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x16
crc32cx	w6, w6, x17
crc32cx	w7, w7, x18
ldp	x14, x16, [x0], #0x10
ldp	x15, x17, [x9], #0x10
ldp	x24, x18, [x10], #0x10
crc32cx	w2, w2, x25
crc32cx	w3, w3, x22
crc32cx	w4, w4, x23
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x25, x19, [x11], #0x10
ldp	x22, x20, [x12], #0x10
ldp	x23, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x25
crc32cx	w6, w6, x22
crc32cx	w7, w7, x23
ldp	x14, x25, [x0], #0x10
ldp	x15, x22, [x9], #0x10
ldp	x24, x23, [x10], #0x10
crc32cx	w2, w2, x16
crc32cx	w3, w3, x17
crc32cx	w4, w4, x18
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x16, x19, [x11], #0x10
ldp	x17, x20, [x12], #0x10
ldp	x18, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x16
crc32cx	w6, w6, x17
crc32cx	w7, w7, x18
ldp	x14, x16, [x0], #0x10
ldp	x15, x17, [x9], #0x10
ldp	x24, x18, [x10], #0x10
crc32cx	w2, w2, x25
crc32cx	w3, w3, x22
crc32cx	w4, w4, x23
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x25, x19, [x11], #0x10
ldp	x22, x20, [x12], #0x10
ldp	x23, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x25
crc32cx	w6, w6, x22
crc32cx	w7, w7, x23
ldp	x14, x25, [x0], #0x10
ldp	x15, x22, [x9], #0x10
ldp	x24, x23, [x10], #0x10
crc32cx	w2, w2, x16
crc32cx	w3, w3, x17
crc32cx	w4, w4, x18
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x16, x19, [x11], #0x10
ldp	x17, x20, [x12], #0x10
ldp	x18, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x16
crc32cx	w6, w6, x17
crc32cx	w7, w7, x18
ldp	x14, x16, [x0], #0x10
ldp	x15, x17, [x9], #0x10
ldp	x24, x18, [x10], #0x10
crc32cx	w2, w2, x25
crc32cx	w3, w3, x22
crc32cx	w4, w4, x23
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x25, x19, [x11], #0x10
ldp	x22, x20, [x12], #0x10
ldp	x23, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x25
crc32cx	w6, w6, x22
crc32cx	w7, w7, x23
ldp	x14, x25, [x0], #0x10
ldp	x15, x22, [x9], #0x10
ldp	x24, x23, [x10], #0x10
crc32cx	w2, w2, x16
crc32cx	w3, w3, x17
crc32cx	w4, w4, x18
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldp	x16, x19, [x11], #0x10
ldp	x17, x20, [x12], #0x10
ldp	x18, x26, [x13], #0x10
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x16
crc32cx	w6, w6, x17
crc32cx	w7, w7, x18
ldr	x14, [x0], #0x8
ldr	x15, [x9], #0x8
ldr	x24, [x10], #0x8
crc32cx	w2, w2, x25
crc32cx	w3, w3, x22
crc32cx	w4, w4, x23
crc32cx	w5, w5, x19
crc32cx	w6, w6, x20
crc32cx	w7, w7, x26
ldr	x25, [x11], #0x8
ldr	x22, [x12], #0x8
ldr	x23, [x13], #0x8
crc32cx	w2, w2, x14
crc32cx	w3, w3, x15
crc32cx	w4, w4, x24
crc32cx	w5, w5, x25
crc32cx	w6, w6, x22
crc32cx	w7, w7, x23
ldr	x23, [x13], #0x8
crc32cx	w7, w7, x23
fmov	d0, x2
fmov	d1, x3
fmov	d2, x4
fmov	d3, x5
fmov	d4, x6
mov	x0, x13
pmull	v0.1q, v0.1d, v5.1d
sub	x1, x1, #0x400
pmull	v1.1q, v1.1d, v6.1d
pmull	v2.1q, v2.1d, v7.1d
pmull	v3.1q, v3.1d, v8.1d
pmull	v4.1q, v4.1d, v9.1d
cmp	x1, #0x400
fmov	x2, d0
fmov	x3, d1
fmov	x4, d2
fmov	x5, d3
fmov	x6, d4
crc32cx	w2, wzr, x2
crc32cx	w3, wzr, x3
crc32cx	w4, wzr, x4
crc32cx	w5, wzr, x5
crc32cx	w6, wzr, x6
eor	w2, w2, w3
eor	w4, w4, w5
eor	w6, w6, w7
eor	w4, w4, w6
eor	w2, w2, w4
b.hs	L_4c
L_3f8:
cmp	x1, #0x3f
b.ls	.loop_16B
.loop_64B:
ldp	x8, x4, [x0], #0x10
sub	x1, x1, #0x40
ldp	x21, x9, [x0], #0x10
cmp	x1, #0x40
crc32cx	w2, w2, x8
crc32cx	w2, w2, x4
ldp	x8, x4, [x0], #0x10
crc32cx	w2, w2, x21
crc32cx	w2, w2, x9
ldp	x21, x9, [x0], #0x10
crc32cx	w2, w2, x8
crc32cx	w2, w2, x4
crc32cx	w2, w2, x21
crc32cx	w2, w2, x9
b.ge	.loop_64B
.loop_16B:
cmp	x1, #0xf
b.ls	.less_16B
ldp	x8, x4, [x0], #0x10
sub	x1, x1, #0x10
cmp	x1, #0xf
crc32cx	w2, w2, x8
crc32cx	w2, w2, x4
b.ls	.less_16B
ldp	x8, x4, [x0], #0x10
sub	x1, x1, #0x10
cmp	x1, #0xf
crc32cx	w2, w2, x8
crc32cx	w2, w2, x4
b.ls	.less_16B
ldp	x8, x4, [x0], #0x10
sub	x1, x1, #0x10
crc32cx	w2, w2, x8
crc32cx	w2, w2, x4
.less_16B:
cmp	x1, #0x7
b.ls	.less_8B
ldr	x8, [x0], #0x8
sub	x1, x1, #0x8
crc32cx	w2, w2, x8
.less_8B:
cmp	x1, #0x3
b.ls	.less_4B
ldr	w8, [x0], #0x4
sub	x1, x1, #0x4
crc32cw	w2, w2, w8
.less_4B:
cmp	x1, #0x1
b.ls	.less_2B
ldrh	w8, [x0], #0x2
sub	x1, x1, #0x2
crc32ch	w2, w2, w8
.less_2B:
cmp	x1, #0x0
b.eq	.zero_length_ret
ldrb	w8, [x0]
crc32cb	w2, w2, w8
.zero_length_ret:
mov	w0, w2
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
ldp	x19, x20, [sp, #0x40]
ldp	x21, x22, [sp, #0x50]
ldp	x23, x24, [sp, #0x60]
ldp	x25, x26, [sp, #0x70]
ldp	x27, x28, [sp, #0x80]
ldp	x29, x30, [sp, #0x90]
ldp	d8, d9, [sp], #0xa0
ret
.align_short_2:
ldrh	w8, [x0], #0x2
sub	x1, x1, #0x2
tst	x0, #0x4
crc32ch	w2, w2, w8
ccmp	x1, #0x3, #0x0, ne
b.ls	.align_finish
.align_word:
ldr	w8, [x0], #0x4
sub	x1, x1, #0x4
crc32cw	w2, w2, w8
b	.align_finish
	.section .rodata
bums_rodata:
	.byte 191,193,65,167,0,0,0,0,138,243,23,228,0,0,0,0
	.byte 12,59,126,221,0,0,0,0,20,128,21,143,0,0,0,0
	.byte 62,231,236,218,0,0,0,0

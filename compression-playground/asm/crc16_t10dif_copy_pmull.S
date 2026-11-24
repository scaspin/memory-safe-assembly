	.text
crc16_t10dif_copy_pmull:
cmp	x3, #0x3f
sub	sp, sp, #0x10
uxth	w0, w0
b.hi	.crc_fold
mov	x6, #0x0
mov	w4, #0x0
.crc_table_loop_pre:
cmp	x3, x6
b.ls	.end
sxtw	x4, w4
adrp	x5, crc16tab
sub	x2, x2, x4
sub	x1, x1, x4
add	x5, x5, :lo12:crc16tab
.crc_table_loop:
ldrb	w6, [x2, x4]
strb	w6, [x1, x4]
add	x4, x4, #0x1
cmp	x3, x4
eor	w6, w6, w0, lsr #8
ldrh	w6, [x5, w6, sxtw #1]
eor	w0, w6, w0, lsl #8
uxth	w0, w0
b.hi	.crc_table_loop
.end:
add	sp, sp, #0x10
ret
.crc_fold:
fmov	d0, x0
fmov	d1, xzr
mov	d16, v1.d[0]
shl	d0, d0, #0x30
mov	v16.d[1], v0.d[0]
and	x4, x3, #0xffffffffffffffc0
sub	x4, x4, #0x40
cmp	x4, #0x3f
add	x0, x2, #0x40
add	x12, x1, #0x40
ldp	q2, q3, [x2]
ldp	q4, q5, [x2, #0x20]
stp	q2, q3, [x1]
stp	q4, q5, [x1, #0x20]
adrp	x6, .shuffle_mask_lanchor
ldr	q7, [x6]
tbl	v0.16b, { v2.16b }, v7.16b
eor	v2.16b, v16.16b, v0.16b
tbl	v3.16b, { v3.16b }, v7.16b
tbl	v4.16b, { v4.16b }, v7.16b
tbl	v5.16b, { v5.16b }, v7.16b
b.ls	.crc_fold_loop_end
ldr	q17, fold_constant
.crc_fold_loop:
add	x0, x0, #0x40
add	x12, x12, #0x40
sub	x4, x4, #0x40
cmp	x4, #0x3f
ldp	q28, q29, [x0, #-0x40]
ldp	q30, q31, [x0, #-0x20]
stp	q28, q29, [x12, #-0x40]
stp	q30, q31, [x12, #-0x20]
prfm	pldl2strm, [x0, #0x400]
prfm	pldl2strm, [x0, #0x440]
pmull2	v24.1q, v2.2d, v17.2d
pmull	v2.1q, v2.1d, v17.1d
pmull2	v25.1q, v3.2d, v17.2d
pmull	v3.1q, v3.1d, v17.1d
pmull2	v26.1q, v4.2d, v17.2d
pmull	v4.1q, v4.1d, v17.1d
pmull2	v27.1q, v5.2d, v17.2d
pmull	v5.1q, v5.1d, v17.1d
tbl	v28.16b, { v28.16b }, v7.16b
eor	v2.16b, v24.16b, v2.16b
eor	v2.16b, v2.16b, v28.16b
tbl	v29.16b, { v29.16b }, v7.16b
eor	v3.16b, v25.16b, v3.16b
eor	v3.16b, v3.16b, v29.16b
tbl	v30.16b, { v30.16b }, v7.16b
eor	v4.16b, v26.16b, v4.16b
eor	v4.16b, v4.16b, v30.16b
tbl	v31.16b, { v31.16b }, v7.16b
eor	v5.16b, v27.16b, v5.16b
eor	v5.16b, v5.16b, v31.16b
b.hi	.crc_fold_loop
.crc_fold_loop_end:
mov	x6, #0x4c1a0000
fmov	d0, x6
mov	x6, #0xfb0b0000
fmov	d1, x6
and	w4, w3, #0xffffffc0
sxtw	x6, w4
add	x2, x2, x6
add	x1, x1, x6
mov	d6, v2.d[1]
mov	d30, v2.d[0]
pmull	v6.1q, v6.1d, v0.1d
pmull	v30.1q, v30.1d, v1.1d
eor	v6.16b, v6.16b, v30.16b
eor	v3.16b, v6.16b, v3.16b
mov	d6, v3.d[1]
mov	d30, v3.d[0]
pmull	v6.1q, v6.1d, v0.1d
pmull	v16.1q, v30.1d, v1.1d
eor	v6.16b, v6.16b, v16.16b
eor	v4.16b, v6.16b, v4.16b
mov	d2, v4.d[1]
mov	d30, v4.d[0]
pmull	v0.1q, v2.1d, v0.1d
pmull	v2.1q, v30.1d, v1.1d
eor	v1.16b, v0.16b, v2.16b
eor	v2.16b, v1.16b, v5.16b
movi	v7.4s, #0x0
mov	x7, #0x2d560000
mov	x11, #0x13680000
ext	v0.16b, v7.16b, v2.16b, #0x8
ext	v0.16b, v0.16b, v7.16b, #0x4
mov	d3, v2.d[1]
fmov	d18, x7
pmull	v16.1q, v3.1d, v18.1d
eor	v0.16b, v0.16b, v16.16b
mov	d6, v0.d[1]
fmov	d4, x11
pmull	v6.1q, v6.1d, v4.1d
eor	v2.16b, v0.16b, v6.16b
mov	x7, #0x57f9
movk	x7, #0xf65a, lsl #16
movk	x7, #0x1, lsl #32
fmov	d3, x7
mov	d1, v2.d[0]
mov	d1, v1.d[0]
ext	v1.16b, v1.16b, v7.16b, #0x4
pmull	v4.1q, v1.1d, v3.1d
ext	v1.16b, v4.16b, v7.16b, #0x4
mov	x7, #0x8bb70000
movk	x7, #0x1, lsl #32
fmov	d5, x7
pmull	v5.1q, v1.1d, v5.1d
eor	v2.16b, v2.16b, v5.16b
mov	x0, v2.d[0]
ubfx	x0, x0, #16, #16
b	.crc_table_loop_pre
nop
nop
	.section .text_data
fold_constant:
	.word 0x87e70000
	.word 0x00000000
	.word 0x371d0000
	.word 0x00000000
	.section .rodata
	.p2align 4
.shuffle_mask_lanchor:
shuffle_mask:
	.size shuffle_mask, 16
	.byte 15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0
crc16tab:
	.size crc16tab, 512
	.byte 0,0,183,139,217,156,110,23,5,178,178,57,220,46,107,165
	.byte 189,239,10,100,100,115,211,248,184,93,15,214,97,193,214,74
	.byte 205,84,122,223,20,200,163,67,200,230,127,109,17,122,166,241
	.byte 112,187,199,48,169,39,30,172,117,9,194,130,172,149,27,30
	.byte 154,169,45,34,67,53,244,190,159,27,40,144,70,135,241,12
	.byte 39,70,144,205,254,218,73,81,34,244,149,127,251,104,76,227
	.byte 87,253,224,118,142,97,57,234,82,79,229,196,139,211,60,88
	.byte 234,18,93,153,51,142,132,5,239,160,88,43,54,60,129,183
	.byte 131,216,52,83,90,68,237,207,134,106,49,225,95,246,232,125
	.byte 62,55,137,188,231,171,80,32,59,133,140,14,226,25,85,146
	.byte 78,140,249,7,151,16,32,155,75,62,252,181,146,162,37,41
	.byte 243,99,68,232,42,255,157,116,246,209,65,90,47,77,152,198
	.byte 25,113,174,250,192,237,119,102,28,195,171,72,197,95,114,212
	.byte 164,158,19,21,125,2,202,137,161,44,22,167,120,176,207,59
	.byte 212,37,99,174,13,185,186,50,209,151,102,28,8,11,191,128
	.byte 105,202,222,65,176,86,7,221,108,120,219,243,181,228,2,111
	.byte 177,58,6,177,104,166,223,45,180,136,3,3,109,20,218,159
	.byte 12,213,187,94,213,73,98,194,9,103,190,236,208,251,103,112
	.byte 124,110,203,229,165,242,18,121,121,220,206,87,160,64,23,203
	.byte 193,129,118,10,24,29,175,150,196,51,115,184,29,175,170,36
	.byte 43,147,156,24,242,15,69,132,46,33,153,170,247,189,64,54
	.byte 150,124,33,247,79,224,248,107,147,206,36,69,74,82,253,217
	.byte 230,199,81,76,63,91,136,208,227,117,84,254,58,233,141,98
	.byte 91,40,236,163,130,180,53,63,94,154,233,17,135,6,48,141
	.byte 50,226,133,105,235,126,92,245,55,80,128,219,238,204,89,71
	.byte 143,13,56,134,86,145,225,26,138,191,61,52,83,35,228,168
	.byte 255,182,72,61,38,42,145,161,250,4,77,143,35,152,148,19
	.byte 66,89,245,210,155,197,44,78,71,235,240,96,158,119,41,252
	.byte 168,75,31,192,113,215,198,92,173,249,26,114,116,101,195,238
	.byte 21,164,162,47,204,56,123,179,16,22,167,157,201,138,126,1
	.byte 101,31,210,148,188,131,11,8,96,173,215,38,185,49,14,186
	.byte 216,240,111,123,1,108,182,231,221,66,106,201,4,222,179,85

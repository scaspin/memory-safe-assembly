	.text
crc32c_mix_neoverse_n1:
cmp	x1, #0x7ff
adr	x3, L_0
b.ls	start_final
ld1	{ v20.16b, v21.16b, v22.16b }, [x3], #48
movi	v26.16b, #0x0
ld1	{ v23.8b, v24.8b, v25.8b }, [x3]
loop_2048:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
add	x5, x0, #0x40
add	x4, x0, #0x200
mov	v4.16b, v26.16b
fmov	s4, w2
ldp	x6, x7, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
mov	w2, #0x0
sub	x1, x1, #0x800
cmp	x1, #0x800
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v20.2d
pmull2	v5.1q, v1.2d, v20.2d
pmull2	v6.1q, v2.2d, v20.2d
pmull2	v7.1q, v3.2d, v20.2d
pmull	v0.1q, v0.1d, v20.1d
pmull	v1.1q, v1.1d, v20.1d
pmull	v2.1q, v2.1d, v20.1d
pmull	v3.1q, v3.1d, v20.1d
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x5], #64
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
eor	v1.16b, v1.16b, v5.16b
eor	v2.16b, v2.16b, v6.16b
eor	v3.16b, v3.16b, v7.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull2	v4.1q, v0.2d, v21.2d
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
pmull	v0.1q, v0.1d, v21.1d
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
eor	v0.16b, v0.16b, v1.16b
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
pmull2	v4.1q, v0.2d, v21.2d
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull	v0.1q, v0.1d, v21.1d
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v2.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
pmull2	v4.1q, v0.2d, v21.2d
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
pmull	v0.1q, v0.1d, v21.1d
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v4.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
eor	v0.16b, v0.16b, v3.16b
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
ext	v1.16b, v0.16b, v0.16b, #0x8
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
pmull2	v1.1q, v1.2d, v21.2d
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
ext	v0.16b, v0.16b, v26.16b, #0x8
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v1.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
ext	v1.16b, v0.16b, v26.16b, #0x4
and	v0.16b, v0.16b, v24.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
pmull	v0.1q, v0.1d, v23.1d
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
eor	v0.16b, v0.16b, v1.16b
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
and	v1.16b, v0.16b, v24.16b
ldp	x6, x7, [x4], #0x10
ext	v1.16b, v26.16b, v1.16b, #0x8
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
pmull2	v1.1q, v1.2d, v22.2d
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
and	v1.16b, v1.16b, v24.16b
ldp	x9, x10, [x4], #0x10
pmull	v1.1q, v1.1d, v22.1d
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
eor	v0.16b, v0.16b, v1.16b
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
mov	v4.16b, v26.16b
mov	v4.s[0], v0.s[1]
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
ldp	x6, x7, [x4], #0x10
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
ldp	x9, x10, [x4], #0x10
crc32cx	w2, w2, x6
crc32cx	w2, w2, x7
crc32cx	w2, w2, x9
crc32cx	w2, w2, x10
pmull	v4.1q, v4.1d, v25.1d
add	x0, x0, #0x800
fmov	x11, d4
crc32cx	w11, wzr, x11
eor	w2, w11, w2
b.ge	loop_2048
start_final:
cmp	x1, #0x3f
b.ls	.loop_16B
.loop_64B:
ldp	x4, x5, [x0], #0x10
sub	x1, x1, #0x40
ldp	x6, x7, [x0], #0x10
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
ldr	w4, [x0], #0x4
sub	x1, x1, #0x4
crc32cw	w2, w2, w4
.less_4B:
cmp	x1, #0x1
b.ls	.less_2B
ldrh	w4, [x0], #0x2
sub	x1, x1, #0x2
crc32ch	w2, w2, w4
.less_2B:
cbz	x1, .finish_exit
ldrb	w4, [x0]
crc32cb	w2, w2, w4
.finish_exit:
mov	w0, w2
ret
	.section .text_data
L_0:
	.word 0x740eef02
	.word 0x00000000
	.word 0x9e4addf8
	.word 0x00000000
	.word 0xf20c0dfe
	.word 0x00000000
	.word 0x4cd00bd6
	.word 0x00000001
	.word 0x05ec76f0
	.word 0x00000001
	.word 0xdea713f1
	.word 0x00000000
	.word 0xdd45aab8
	.word 0x00000000
	.word 0xffffffff
	.word 0x00000000
	.word 0x9ef68d35
	.word 0x00000000
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f
	.word 0xd503201f

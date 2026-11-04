	.text
crc32c_mix_default:
mov	w3, w2
sxtw	x2, w1
mov	x1, x0
mov	w0, w3
cmp	x2, #0x7ff
mov	x5, x2
mov	x3, x1
b.ls	.less_than_2048
sub	x4, x2, #0x800
stp	x29, x30, [sp, #-0x10]!
mov	x29, sp
and	x4, x4, #0xfffffffffffff800
add	x4, x4, #0x800
add	x4, x1, x4
nop
nop
.loop_mix:
mov	x1, x3
fmov	s1, w0
movi	v24.4s, #0x0
adrp	x10, lanchor_crc32
add	x6, x1, #0x40
ldr	x11, [x1, #0x200]
ldr	x12, [x1, #0x400]
ldr	x13, [x1, #0x600]
crc32cx	w7, wzr, x11
crc32cx	w8, wzr, x12
crc32cx	w9, wzr, x13
mov	v24.s[0], v1.s[0]
ld1	{ v1.4s, v2.4s, v3.4s, v4.4s }, [x1]
ldr	x11, [x1, #0x208]
ldr	x12, [x1, #0x408]
ldr	x13, [x1, #0x608]
eor	v1.16b, v1.16b, v24.16b
ldr	q0, [x10]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
nop
nop
nop
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x6, x6, #0x40
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x6, x6, #0x40
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x6, x6, #0x40
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x6, x6, #0x40
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x6, x6, #0x40
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x6, x6, #0x40
ldr	x11, [x6, #0x1d0]
ldr	x12, [x6, #0x3d0]
ldr	x13, [x6, #0x5d0]
pmull	v16.1q, v1.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1d8]
ldr	x12, [x6, #0x3d8]
ldr	x13, [x6, #0x5d8]
pmull	v17.1q, v2.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e0]
ldr	x12, [x6, #0x3e0]
ldr	x13, [x6, #0x5e0]
pmull	v18.1q, v3.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1e8]
ldr	x12, [x6, #0x3e8]
ldr	x13, [x6, #0x5e8]
pmull	v19.1q, v4.1d, v0.1d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x1f0]
ldr	x12, [x6, #0x3f0]
ldr	x13, [x6, #0x5f0]
pmull2	v1.1q, v1.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ld1	{ v20.4s, v21.4s, v22.4s, v23.4s }, [x6]
ldr	x11, [x6, #0x1f8]
ldr	x12, [x6, #0x3f8]
ldr	x13, [x6, #0x5f8]
pmull2	v2.1q, v2.2d, v0.2d
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull2	v3.1q, v3.2d, v0.2d
pmull2	v4.1q, v4.2d, v0.2d
eor	v20.16b, v20.16b, v16.16b
eor	v21.16b, v21.16b, v17.16b
eor	v22.16b, v22.16b, v18.16b
eor	v23.16b, v23.16b, v19.16b
ldr	x11, [x6, #0x200]
ldr	x12, [x6, #0x400]
ldr	x13, [x6, #0x600]
eor	v1.16b, v20.16b, v1.16b
eor	v2.16b, v21.16b, v2.16b
eor	v3.16b, v22.16b, v3.16b
eor	v4.16b, v23.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
ldr	x11, [x6, #0x208]
ldr	x12, [x6, #0x408]
ldr	x13, [x6, #0x608]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
add	x10, x10, :lo12:lanchor_crc32
ldr	x11, [x1, #0x3d0]
ldr	x12, [x1, #0x5d0]
ldr	x13, [x1, #0x7d0]
ldr	q0, [x10, #0x10]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull	v16.1q, v1.1d, v0.1d
pmull2	v1.1q, v1.2d, v0.2d
eor	v1.16b, v16.16b, v1.16b
eor	v1.16b, v1.16b, v2.16b
ldr	x11, [x1, #0x3d8]
ldr	x12, [x1, #0x5d8]
ldr	x13, [x1, #0x7d8]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull	v16.1q, v1.1d, v0.1d
pmull2	v1.1q, v1.2d, v0.2d
ldr	x11, [x1, #0x3e0]
ldr	x12, [x1, #0x5e0]
ldr	x13, [x1, #0x7e0]
eor	v1.16b, v16.16b, v1.16b
eor	v1.16b, v1.16b, v3.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
pmull	v16.1q, v1.1d, v0.1d
pmull2	v1.1q, v1.2d, v0.2d
ldr	x11, [x1, #0x3e8]
ldr	x12, [x1, #0x5e8]
ldr	x13, [x1, #0x7e8]
eor	v1.16b, v16.16b, v1.16b
eor	v1.16b, v1.16b, v4.16b
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
mov	d0, v0.d[1]
pmull	v2.1q, v1.1d, v0.1d
movi	v24.4s, #0x0
ldr	q25, [x10, #0x20]
adrp	x14, .lanchor_mask
ldr	x11, [x1, #0x3f0]
ldr	x12, [x1, #0x5f0]
ldr	x13, [x1, #0x7f0]
ext	v1.16b, v1.16b, v24.16b, #0x8
eor	v1.16b, v2.16b, v1.16b
ldr	q28, [x14]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
mov	d0, v25.d[1]
pmull	v3.1q, v2.1d, v0.1d
ext	v2.16b, v1.16b, v24.16b, #0x4
and	v1.16b, v1.16b, v28.16b
pmull	v1.1q, v1.1d, v25.1d
eor	v1.16b, v2.16b, v1.16b
ldr	q26, [x10, #0x30]
ldr	x11, [x1, #0x3f8]
ldr	x12, [x1, #0x5f8]
ldr	x13, [x1, #0x7f8]
mov	d27, v26.d[1]
crc32cx	w7, w7, x11
crc32cx	w8, w8, x12
crc32cx	w9, w9, x13
and	v2.16b, v1.16b, v28.16b
pmull	v2.1q, v2.1d, v27.1d
and	v2.16b, v28.16b, v2.16b
pmull	v2.1q, v2.1d, v26.1d
eor	v1.16b, v1.16b, v2.16b
mov	s29, v1.s[1]
fmov	s30, w7
fmov	s31, w8
ldr	q5, [x10, #0x40]
ldr	q6, [x10, #0x50]
ldr	q7, [x10, #0x60]
pmull	v29.1q, v29.1d, v5.1d
pmull	v30.1q, v30.1d, v6.1d
pmull	v31.1q, v31.1d, v7.1d
fmov	x15, d30
crc32cx	w7, wzr, x15
fmov	x15, d31
crc32cx	w8, wzr, x15
eor	w0, w8, w7
fmov	x15, d29
crc32cx	w14, wzr, x15
eor	w9, w14, w9
eor	w0, w9, w0
add	x3, x3, #0x800
cmp	x3, x4
b.ne	.loop_mix
and	x5, x5, #0x7ff
cbnz	x5, .remain_ldp
ldp	x29, x30, [sp], #0x10
ret
nop
nop
nop
.remain_ldp:
mov	w10, w0
ldp	x29, x30, [sp], #0x10
mov	x9, x5
mov	x1, x4
b	.crc32_hw_handle
.remain:
mov	w10, w0
mov	x9, x5
mov	x1, x3
b	.crc32_hw_handle
nop
nop
nop
.less_than_2048:
cbnz	x2, .remain
ret
.crc32_hw_handle:
cmp	x9, #0x3f
b.ls	.less_than_64
sub	x3, x9, #0x40
and	x3, x3, #0xffffffffffffffc0
add	x3, x3, #0x40
add	x3, x1, x3
.loop_64:
ldp	x11, x12, [x1]
ldr	x13, [x1, #0x10]
crc32cx	w10, w10, x11
crc32cx	w10, w10, x12
ldp	x11, x12, [x1, #0x18]
add	x1, x1, #0x40
crc32cx	w10, w10, x13
ldur	x13, [x1, #-0x18]
crc32cx	w10, w10, x11
crc32cx	w10, w10, x12
ldp	x11, x12, [x1, #-0x10]
cmp	x3, x1
crc32cx	w10, w10, x13
crc32cx	w10, w10, x11
crc32cx	w10, w10, x12
b.ne	.loop_64
and	x9, x9, #0x3f
.less_than_64:
cmp	x9, #0x7
b.ls	.crc32_hw_w
ldr	x12, [x1]
sub	x11, x9, #0x8
cmp	x11, #0x7
crc32cx	w10, w10, x12
b.ls	.crc32_hw_w_pre
ldr	x12, [x1, #0x8]
sub	x13, x9, #0x10
cmp	x13, #0x7
crc32cx	w10, w10, x12
b.ls	.crc32_hw_w_pre
ldr	x12, [x1, #0x10]
sub	x13, x9, #0x18
cmp	x13, #0x7
crc32cx	w10, w10, x12
b.ls	.crc32_hw_w_pre
ldr	x12, [x1, #0x18]
sub	x13, x9, #0x20
cmp	x13, #0x7
crc32cx	w10, w10, x12
b.ls	.crc32_hw_w_pre
ldr	x12, [x1, #0x20]
sub	x13, x9, #0x28
cmp	x13, #0x7
crc32cx	w10, w10, x12
b.ls	.crc32_hw_w_pre
ldr	x12, [x1, #0x28]
sub	x13, x9, #0x30
cmp	x13, #0x7
crc32cx	w10, w10, x12
b.ls	.crc32_hw_w_pre
ldr	x12, [x1, #0x30]
crc32cx	w10, w10, x12
.crc32_hw_w_pre:
and	x11, x11, #0xfffffffffffffff8
and	x9, x9, #0x7
add	x11, x11, #0x8
add	x1, x1, x11
.crc32_hw_w:
cmp	x9, #0x3
b.ls	.crc32_hw_h
ldr	w12, [x1], #0x4
sub	x9, x9, #0x4
crc32cw	w10, w10, w12
.crc32_hw_h:
cmp	x9, #0x1
b.ls	.crc32_hw_b
ldrh	w12, [x1], #0x2
sub	x9, x9, #0x2
crc32ch	w10, w10, w12
.crc32_hw_b:
cbz	x9, .crc32_hw_done
ldrb	w12, [x1]
crc32cb	w10, w10, w12
.crc32_hw_done:
mov	w0, w10
ret
	.section .rodata
lanchor_crc32:
k1k2:
	.size k1k2, 16
	.byte 2,239,14,116,0,0,0,0,248,221,74,158,0,0,0,0
k3k4:
	.size k3k4, 16
	.byte 254,13,12,242,0,0,0,0,214,11,208,76,1,0,0,0
k5k0:
	.size k5k0, 16
	.byte 184,170,69,221,0,0,0,0,0,0,0,0,0,0,0,0
poly:
	.size poly, 16
	.byte 240,118,236,5,1,0,0,0,241,19,167,222,0,0,0,0
crc32_const:
	.size crc32_const, 48
	.byte 53,141,246,158,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 250,118,0,23,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 12,59,126,221,0,0,0,0,0,0,0,0,0,0,0,0
.lanchor_mask:
mask:
	.size mask, 16
	.byte 255,255,255,255,0,0,0,0,255,255,255,255,0,0,0,0

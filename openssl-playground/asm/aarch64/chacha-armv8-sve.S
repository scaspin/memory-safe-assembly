	.text
ChaCha20_ctr32_sve:
cntw	x5
cmp	x2, x5, lsl #6
b.lt	L_1b1c
mov	x7, #0x0
adrp	x6, OPENSSL_armcap_P
ldr	w6, [x6]
tst	w6, #0x4000
b.eq	L_28
mov	x7, #0x1
b	L_40
L_28:
cmp	x5, #0x4
b.le	L_1b1c
adrp	x6, _chacha_sve_consts+16
add	x6, x6, :lo12:_chacha_sve_consts+16
ldp	w9, w10, [x6]
index	z31.s, w9, w10
L_40:
stp	d8, d9, [sp, #-0xc0]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
stp	x16, x17, [sp, #0x40]
stp	x18, x19, [sp, #0x50]
stp	x20, x21, [sp, #0x60]
stp	x22, x23, [sp, #0x70]
stp	x24, x25, [sp, #0x80]
stp	x26, x27, [sp, #0x90]
stp	x28, x29, [sp, #0xa0]
str	x30, [sp, #0xb0]
adrp	x6, _chacha_sve_consts
add	x6, x6, :lo12:_chacha_sve_consts
ldp	x23, x24, [x6]
ldp	x25, x26, [x3]
ldp	x27, x28, [x3, #0x10]
ldp	x29, x30, [x4]
ptrues	p0.s
cbz	x7, L_cac
nop
nop
nop
nop
L_a0:
subs	x7, x2, x5, lsl #6
b.lt	L_ca8
mov	x2, x7
b.eq	L_7e8
cmp	x2, #0x40
b.lt	L_7e8
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	w7, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	w9, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	w11, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	w13, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	w15, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	z17.s, w28
mov	w17, w28
mov	z14.s, w18
mov	z18.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	z20.s, w30
mov	w21, w30
mov	z15.s, w22
mov	z31.s, w22
add	w20, w29, #0x1
mov	w19, w29
index	z16.s, w20, #0x1
index	z3.s, w20, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	z19.s, w20
mov	x6, #0xa
L_180:
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	w19, w19, w7
xar	z3.s, z3.s, z0.s, #0x10
ror	w19, w19, #0x10
eor	w20, w20, w8
xar	z7.s, z7.s, z4.s, #0x10
ror	w20, w20, #0x10
eor	w21, w21, w9
xar	z11.s, z11.s, z8.s, #0x10
ror	w21, w21, #0x10
eor	w22, w22, w10
xar	z15.s, z15.s, z12.s, #0x10
ror	w22, w22, #0x10
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	w11, w11, w15
xar	z1.s, z1.s, z2.s, #0x14
ror	w11, w11, #0x14
eor	w12, w12, w16
xar	z5.s, z5.s, z6.s, #0x14
ror	w12, w12, #0x14
eor	w13, w13, w17
xar	z9.s, z9.s, z10.s, #0x14
ror	w13, w13, #0x14
eor	w14, w14, w18
xar	z13.s, z13.s, z14.s, #0x14
ror	w14, w14, #0x14
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	w19, w19, w7
xar	z3.s, z3.s, z0.s, #0x18
ror	w19, w19, #0x18
eor	w20, w20, w8
xar	z7.s, z7.s, z4.s, #0x18
ror	w20, w20, #0x18
eor	w21, w21, w9
xar	z11.s, z11.s, z8.s, #0x18
ror	w21, w21, #0x18
eor	w22, w22, w10
xar	z15.s, z15.s, z12.s, #0x18
ror	w22, w22, #0x18
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	w11, w11, w15
xar	z1.s, z1.s, z2.s, #0x19
ror	w11, w11, #0x19
eor	w12, w12, w16
xar	z5.s, z5.s, z6.s, #0x19
ror	w12, w12, #0x19
eor	w13, w13, w17
xar	z9.s, z9.s, z10.s, #0x19
ror	w13, w13, #0x19
eor	w14, w14, w18
xar	z13.s, z13.s, z14.s, #0x19
ror	w14, w14, #0x19
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	w22, w22, w7
xar	z15.s, z15.s, z0.s, #0x10
ror	w22, w22, #0x10
eor	w19, w19, w8
xar	z3.s, z3.s, z4.s, #0x10
ror	w19, w19, #0x10
eor	w20, w20, w9
xar	z7.s, z7.s, z8.s, #0x10
ror	w20, w20, #0x10
eor	w21, w21, w10
xar	z11.s, z11.s, z12.s, #0x10
ror	w21, w21, #0x10
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	w12, w12, w17
xar	z5.s, z5.s, z10.s, #0x14
ror	w12, w12, #0x14
eor	w13, w13, w18
xar	z9.s, z9.s, z14.s, #0x14
ror	w13, w13, #0x14
eor	w14, w14, w15
xar	z13.s, z13.s, z2.s, #0x14
ror	w14, w14, #0x14
eor	w11, w11, w16
xar	z1.s, z1.s, z6.s, #0x14
ror	w11, w11, #0x14
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	w22, w22, w7
xar	z15.s, z15.s, z0.s, #0x18
ror	w22, w22, #0x18
eor	w19, w19, w8
xar	z3.s, z3.s, z4.s, #0x18
ror	w19, w19, #0x18
eor	w20, w20, w9
xar	z7.s, z7.s, z8.s, #0x18
ror	w20, w20, #0x18
eor	w21, w21, w10
xar	z11.s, z11.s, z12.s, #0x18
ror	w21, w21, #0x18
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	w12, w12, w17
xar	z5.s, z5.s, z10.s, #0x19
ror	w12, w12, #0x19
eor	w13, w13, w18
xar	z9.s, z9.s, z14.s, #0x19
ror	w13, w13, #0x19
eor	w14, w14, w15
xar	z13.s, z13.s, z2.s, #0x19
ror	w14, w14, #0x19
eor	w11, w11, w16
xar	z1.s, z1.s, z6.s, #0x19
ror	w11, w11, #0x19
sub	x6, x6, #0x1
cbnz	x6, L_180
add	w7, w7, w23
add	z0.s, z0.s, z25.s
add	x8, x8, x23, lsr #32
add	z4.s, z4.s, z26.s
add	x7, x7, x8, lsl #32
add	w9, w9, w24
add	z8.s, z8.s, z27.s
add	x10, x10, x24, lsr #32
add	z12.s, z12.s, z28.s
add	x9, x9, x10, lsl #32
ldp	x8, x10, [x1], #0x10
add	w11, w11, w25
add	z1.s, z1.s, z29.s
add	x12, x12, x25, lsr #32
add	z5.s, z5.s, z30.s
add	x11, x11, x12, lsl #32
add	w13, w13, w26
add	z9.s, z9.s, z21.s
add	x14, x14, x26, lsr #32
add	z13.s, z13.s, z22.s
add	x13, x13, x14, lsl #32
ldp	x12, x14, [x1], #0x10
add	w15, w15, w27
add	z2.s, z2.s, z23.s
add	x16, x16, x27, lsr #32
add	z6.s, z6.s, z24.s
add	x15, x15, x16, lsl #32
add	w17, w17, w28
add	z10.s, z10.s, z17.s
add	x18, x18, x28, lsr #32
add	z14.s, z14.s, z18.s
add	x17, x17, x18, lsl #32
ldp	x16, x18, [x1], #0x10
add	w19, w19, w29
add	z3.s, z3.s, z16.s
add	x20, x20, x29, lsr #32
add	z7.s, z7.s, z19.s
add	x19, x19, x20, lsl #32
add	w21, w21, w30
add	z11.s, z11.s, z20.s
add	x22, x22, x30, lsr #32
add	z15.s, z15.s, z31.s
add	x21, x21, x22, lsl #32
ldp	x20, x22, [x1], #0x10
add	x29, x29, #0x1
cmp	x5, #0x4
b.ne	L_5d8
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
stp	x7, x9, [x0], #0x10
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_7d8
L_5d8:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
eor	x7, x7, x8
eor	x9, x9, x10
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x11, x11, x12
eor	x13, x13, x14
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
stp	x7, x9, [x0], #0x10
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_7d8:
incw	x29
subs	x2, x2, #0x40
b.gt	L_a0
b	L_ca8
L_7e8:
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	z17.s, w28
mov	z14.s, w18
mov	z18.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	z20.s, w30
mov	z15.s, w22
mov	z31.s, w22
index	z16.s, w29, #0x1
index	z3.s, w29, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	z19.s, w20
mov	x6, #0xa
L_88c:
nop
nop
nop
nop
nop
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
xar	z3.s, z3.s, z0.s, #0x10
xar	z7.s, z7.s, z4.s, #0x10
xar	z11.s, z11.s, z8.s, #0x10
xar	z15.s, z15.s, z12.s, #0x10
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
xar	z1.s, z1.s, z2.s, #0x14
xar	z5.s, z5.s, z6.s, #0x14
xar	z9.s, z9.s, z10.s, #0x14
xar	z13.s, z13.s, z14.s, #0x14
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
xar	z3.s, z3.s, z0.s, #0x18
xar	z7.s, z7.s, z4.s, #0x18
xar	z11.s, z11.s, z8.s, #0x18
xar	z15.s, z15.s, z12.s, #0x18
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
xar	z1.s, z1.s, z2.s, #0x19
xar	z5.s, z5.s, z6.s, #0x19
xar	z9.s, z9.s, z10.s, #0x19
xar	z13.s, z13.s, z14.s, #0x19
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
xar	z15.s, z15.s, z0.s, #0x10
xar	z3.s, z3.s, z4.s, #0x10
xar	z7.s, z7.s, z8.s, #0x10
xar	z11.s, z11.s, z12.s, #0x10
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
xar	z5.s, z5.s, z10.s, #0x14
xar	z9.s, z9.s, z14.s, #0x14
xar	z13.s, z13.s, z2.s, #0x14
xar	z1.s, z1.s, z6.s, #0x14
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
xar	z15.s, z15.s, z0.s, #0x18
xar	z3.s, z3.s, z4.s, #0x18
xar	z7.s, z7.s, z8.s, #0x18
xar	z11.s, z11.s, z12.s, #0x18
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
xar	z5.s, z5.s, z10.s, #0x19
xar	z9.s, z9.s, z14.s, #0x19
xar	z13.s, z13.s, z2.s, #0x19
xar	z1.s, z1.s, z6.s, #0x19
sub	x6, x6, #0x1
cbnz	x6, L_88c
add	z0.s, z0.s, z25.s
add	z4.s, z4.s, z26.s
add	z8.s, z8.s, z27.s
add	z12.s, z12.s, z28.s
add	z1.s, z1.s, z29.s
add	z5.s, z5.s, z30.s
add	z9.s, z9.s, z21.s
add	z13.s, z13.s, z22.s
add	z2.s, z2.s, z23.s
add	z6.s, z6.s, z24.s
add	z10.s, z10.s, z17.s
add	z14.s, z14.s, z18.s
add	z3.s, z3.s, z16.s
add	z7.s, z7.s, z19.s
add	z11.s, z11.s, z20.s
add	z15.s, z15.s, z31.s
cmp	x5, #0x4
b.ne	L_ad4
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_ca4
L_ad4:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_ca4:
incw	x29
L_ca8:
b	L_1ae8
L_cac:
nop
nop
nop
nop
nop
L_cc0:
subs	x7, x2, x5, lsl #6
b.lt	L_1ae8
mov	x2, x7
b.eq	L_1528
cmp	x2, #0x40
b.lt	L_1528
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	w7, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	w9, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	w11, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	w13, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	w15, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	w17, w28
mov	z14.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	w21, w30
mov	z15.s, w22
add	w20, w29, #0x1
mov	w19, w29
index	z16.s, w20, #0x1
index	z3.s, w20, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	x6, #0xa
L_d8c:
nop
nop
nop
nop
nop
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	z3.d, z3.d, z0.d
eor	w19, w19, w7
eor	z7.d, z7.d, z4.d
eor	w20, w20, w8
eor	z11.d, z11.d, z8.d
eor	w21, w21, w9
eor	z15.d, z15.d, z12.d
eor	w22, w22, w10
revh	z3.s, p0/m, z3.s
ror	w19, w19, #0x10
revh	z7.s, p0/m, z7.s
ror	w20, w20, #0x10
revh	z11.s, p0/m, z11.s
ror	w21, w21, #0x10
revh	z15.s, p0/m, z15.s
ror	w22, w22, #0x10
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	z1.d, z1.d, z2.d
eor	w11, w11, w15
eor	z5.d, z5.d, z6.d
eor	w12, w12, w16
eor	z9.d, z9.d, z10.d
eor	w13, w13, w17
eor	z13.d, z13.d, z14.d
eor	w14, w14, w18
lsl	z17.s, z1.s, #0xc
lsl	z18.s, z5.s, #0xc
lsl	z19.s, z9.s, #0xc
lsl	z20.s, z13.s, #0xc
lsr	z1.s, z1.s, #0x14
ror	w11, w11, #0x14
lsr	z5.s, z5.s, #0x14
ror	w12, w12, #0x14
lsr	z9.s, z9.s, #0x14
ror	w13, w13, #0x14
lsr	z13.s, z13.s, #0x14
ror	w14, w14, #0x14
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z1.s
add	w7, w7, w11
add	z4.s, z4.s, z5.s
add	w8, w8, w12
add	z8.s, z8.s, z9.s
add	w9, w9, w13
add	z12.s, z12.s, z13.s
add	w10, w10, w14
eor	z3.d, z3.d, z0.d
eor	w19, w19, w7
eor	z7.d, z7.d, z4.d
eor	w20, w20, w8
eor	z11.d, z11.d, z8.d
eor	w21, w21, w9
eor	z15.d, z15.d, z12.d
eor	w22, w22, w10
tbl	z3.b, { z3.b }, z31.b
ror	w19, w19, #0x18
tbl	z7.b, { z7.b }, z31.b
ror	w20, w20, #0x18
tbl	z11.b, { z11.b }, z31.b
ror	w21, w21, #0x18
tbl	z15.b, { z15.b }, z31.b
ror	w22, w22, #0x18
add	z2.s, z2.s, z3.s
add	w15, w15, w19
add	z6.s, z6.s, z7.s
add	w16, w16, w20
add	z10.s, z10.s, z11.s
add	w17, w17, w21
add	z14.s, z14.s, z15.s
add	w18, w18, w22
eor	z1.d, z1.d, z2.d
eor	w11, w11, w15
eor	z5.d, z5.d, z6.d
eor	w12, w12, w16
eor	z9.d, z9.d, z10.d
eor	w13, w13, w17
eor	z13.d, z13.d, z14.d
eor	w14, w14, w18
lsl	z17.s, z1.s, #0x7
lsl	z18.s, z5.s, #0x7
lsl	z19.s, z9.s, #0x7
lsl	z20.s, z13.s, #0x7
lsr	z1.s, z1.s, #0x19
ror	w11, w11, #0x19
lsr	z5.s, z5.s, #0x19
ror	w12, w12, #0x19
lsr	z9.s, z9.s, #0x19
ror	w13, w13, #0x19
lsr	z13.s, z13.s, #0x19
ror	w14, w14, #0x19
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	z15.d, z15.d, z0.d
eor	w22, w22, w7
eor	z3.d, z3.d, z4.d
eor	w19, w19, w8
eor	z7.d, z7.d, z8.d
eor	w20, w20, w9
eor	z11.d, z11.d, z12.d
eor	w21, w21, w10
revh	z15.s, p0/m, z15.s
ror	w22, w22, #0x10
revh	z3.s, p0/m, z3.s
ror	w19, w19, #0x10
revh	z7.s, p0/m, z7.s
ror	w20, w20, #0x10
revh	z11.s, p0/m, z11.s
ror	w21, w21, #0x10
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	z5.d, z5.d, z10.d
eor	w12, w12, w17
eor	z9.d, z9.d, z14.d
eor	w13, w13, w18
eor	z13.d, z13.d, z2.d
eor	w14, w14, w15
eor	z1.d, z1.d, z6.d
eor	w11, w11, w16
lsl	z17.s, z5.s, #0xc
lsl	z18.s, z9.s, #0xc
lsl	z19.s, z13.s, #0xc
lsl	z20.s, z1.s, #0xc
lsr	z5.s, z5.s, #0x14
ror	w12, w12, #0x14
lsr	z9.s, z9.s, #0x14
ror	w13, w13, #0x14
lsr	z13.s, z13.s, #0x14
ror	w14, w14, #0x14
lsr	z1.s, z1.s, #0x14
ror	w11, w11, #0x14
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
add	z0.s, z0.s, z5.s
add	w7, w7, w12
add	z4.s, z4.s, z9.s
add	w8, w8, w13
add	z8.s, z8.s, z13.s
add	w9, w9, w14
add	z12.s, z12.s, z1.s
add	w10, w10, w11
eor	z15.d, z15.d, z0.d
eor	w22, w22, w7
eor	z3.d, z3.d, z4.d
eor	w19, w19, w8
eor	z7.d, z7.d, z8.d
eor	w20, w20, w9
eor	z11.d, z11.d, z12.d
eor	w21, w21, w10
tbl	z15.b, { z15.b }, z31.b
ror	w22, w22, #0x18
tbl	z3.b, { z3.b }, z31.b
ror	w19, w19, #0x18
tbl	z7.b, { z7.b }, z31.b
ror	w20, w20, #0x18
tbl	z11.b, { z11.b }, z31.b
ror	w21, w21, #0x18
add	z10.s, z10.s, z15.s
add	w17, w17, w22
add	z14.s, z14.s, z3.s
add	w18, w18, w19
add	z2.s, z2.s, z7.s
add	w15, w15, w20
add	z6.s, z6.s, z11.s
add	w16, w16, w21
eor	z5.d, z5.d, z10.d
eor	w12, w12, w17
eor	z9.d, z9.d, z14.d
eor	w13, w13, w18
eor	z13.d, z13.d, z2.d
eor	w14, w14, w15
eor	z1.d, z1.d, z6.d
eor	w11, w11, w16
lsl	z17.s, z5.s, #0x7
lsl	z18.s, z9.s, #0x7
lsl	z19.s, z13.s, #0x7
lsl	z20.s, z1.s, #0x7
lsr	z5.s, z5.s, #0x19
ror	w12, w12, #0x19
lsr	z9.s, z9.s, #0x19
ror	w13, w13, #0x19
lsr	z13.s, z13.s, #0x19
ror	w14, w14, #0x19
lsr	z1.s, z1.s, #0x19
ror	w11, w11, #0x19
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
sub	x6, x6, #0x1
cbnz	x6, L_d8c
lsr	x6, x28, #32
mov	z17.s, w28
mov	z18.s, w6
lsr	x6, x29, #32
mov	z19.s, w6
lsr	x6, x30, #32
add	w7, w7, w23
add	z0.s, z0.s, z25.s
add	x8, x8, x23, lsr #32
add	z4.s, z4.s, z26.s
add	x7, x7, x8, lsl #32
add	w9, w9, w24
add	z8.s, z8.s, z27.s
add	x10, x10, x24, lsr #32
add	z12.s, z12.s, z28.s
add	x9, x9, x10, lsl #32
ldp	x8, x10, [x1], #0x10
add	w11, w11, w25
add	z1.s, z1.s, z29.s
add	x12, x12, x25, lsr #32
add	z5.s, z5.s, z30.s
add	x11, x11, x12, lsl #32
add	w13, w13, w26
add	z9.s, z9.s, z21.s
add	x14, x14, x26, lsr #32
add	z13.s, z13.s, z22.s
add	x13, x13, x14, lsl #32
ldp	x12, x14, [x1], #0x10
add	w15, w15, w27
add	z2.s, z2.s, z23.s
add	x16, x16, x27, lsr #32
add	z6.s, z6.s, z24.s
add	x15, x15, x16, lsl #32
add	w17, w17, w28
add	z10.s, z10.s, z17.s
add	x18, x18, x28, lsr #32
add	z14.s, z14.s, z18.s
add	x17, x17, x18, lsl #32
ldp	x16, x18, [x1], #0x10
mov	z20.s, w30
mov	z25.s, w6
add	w19, w19, w29
add	z3.s, z3.s, z16.s
add	x20, x20, x29, lsr #32
add	z7.s, z7.s, z19.s
add	x19, x19, x20, lsl #32
add	w21, w21, w30
add	z11.s, z11.s, z20.s
add	x22, x22, x30, lsr #32
add	z15.s, z15.s, z25.s
add	x21, x21, x22, lsl #32
ldp	x20, x22, [x1], #0x10
add	x29, x29, #0x1
cmp	x5, #0x4
b.ne	L_1318
eor	x7, x7, x8
eor	x9, x9, x10
eor	x11, x11, x12
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x13, x13, x14
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
stp	x7, x9, [x0], #0x10
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_1518
L_1318:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
eor	x7, x7, x8
eor	x9, x9, x10
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x11, x11, x12
eor	x13, x13, x14
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
eor	x15, x15, x16
eor	x17, x17, x18
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
eor	x19, x19, x20
eor	x21, x21, x22
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
stp	x7, x9, [x0], #0x10
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
stp	x11, x13, [x0], #0x10
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
stp	x15, x17, [x0], #0x10
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
stp	x19, x21, [x0], #0x10
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_1518:
incw	x29
subs	x2, x2, #0x40
b.gt	L_cc0
b	L_1ae8
L_1528:
lsr	x8, x23, #32
mov	z0.s, w23
mov	z25.s, w23
mov	z4.s, w8
mov	z26.s, w8
lsr	x10, x24, #32
mov	z8.s, w24
mov	z27.s, w24
mov	z12.s, w10
mov	z28.s, w10
lsr	x12, x25, #32
mov	z1.s, w25
mov	z29.s, w25
mov	z5.s, w12
mov	z30.s, w12
lsr	x14, x26, #32
mov	z9.s, w26
mov	z21.s, w26
mov	z13.s, w14
mov	z22.s, w14
lsr	x16, x27, #32
mov	z2.s, w27
mov	z23.s, w27
mov	z6.s, w16
mov	z24.s, w16
lsr	x18, x28, #32
mov	z10.s, w28
mov	z14.s, w18
lsr	x22, x30, #32
mov	z11.s, w30
mov	z15.s, w22
index	z16.s, w29, #0x1
index	z3.s, w29, #0x1
lsr	x20, x29, #32
mov	z7.s, w20
mov	x6, #0xa
L_15b8:
nop
nop
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
eor	z3.d, z3.d, z0.d
eor	z7.d, z7.d, z4.d
eor	z11.d, z11.d, z8.d
eor	z15.d, z15.d, z12.d
revh	z3.s, p0/m, z3.s
revh	z7.s, p0/m, z7.s
revh	z11.s, p0/m, z11.s
revh	z15.s, p0/m, z15.s
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
eor	z1.d, z1.d, z2.d
eor	z5.d, z5.d, z6.d
eor	z9.d, z9.d, z10.d
eor	z13.d, z13.d, z14.d
lsl	z17.s, z1.s, #0xc
lsl	z18.s, z5.s, #0xc
lsl	z19.s, z9.s, #0xc
lsl	z20.s, z13.s, #0xc
lsr	z1.s, z1.s, #0x14
lsr	z5.s, z5.s, #0x14
lsr	z9.s, z9.s, #0x14
lsr	z13.s, z13.s, #0x14
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z1.s
add	z4.s, z4.s, z5.s
add	z8.s, z8.s, z9.s
add	z12.s, z12.s, z13.s
eor	z3.d, z3.d, z0.d
eor	z7.d, z7.d, z4.d
eor	z11.d, z11.d, z8.d
eor	z15.d, z15.d, z12.d
tbl	z3.b, { z3.b }, z31.b
tbl	z7.b, { z7.b }, z31.b
tbl	z11.b, { z11.b }, z31.b
tbl	z15.b, { z15.b }, z31.b
add	z2.s, z2.s, z3.s
add	z6.s, z6.s, z7.s
add	z10.s, z10.s, z11.s
add	z14.s, z14.s, z15.s
eor	z1.d, z1.d, z2.d
eor	z5.d, z5.d, z6.d
eor	z9.d, z9.d, z10.d
eor	z13.d, z13.d, z14.d
lsl	z17.s, z1.s, #0x7
lsl	z18.s, z5.s, #0x7
lsl	z19.s, z9.s, #0x7
lsl	z20.s, z13.s, #0x7
lsr	z1.s, z1.s, #0x19
lsr	z5.s, z5.s, #0x19
lsr	z9.s, z9.s, #0x19
lsr	z13.s, z13.s, #0x19
orr	z1.d, z1.d, z17.d
orr	z5.d, z5.d, z18.d
orr	z9.d, z9.d, z19.d
orr	z13.d, z13.d, z20.d
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
eor	z15.d, z15.d, z0.d
eor	z3.d, z3.d, z4.d
eor	z7.d, z7.d, z8.d
eor	z11.d, z11.d, z12.d
revh	z15.s, p0/m, z15.s
revh	z3.s, p0/m, z3.s
revh	z7.s, p0/m, z7.s
revh	z11.s, p0/m, z11.s
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
eor	z5.d, z5.d, z10.d
eor	z9.d, z9.d, z14.d
eor	z13.d, z13.d, z2.d
eor	z1.d, z1.d, z6.d
lsl	z17.s, z5.s, #0xc
lsl	z18.s, z9.s, #0xc
lsl	z19.s, z13.s, #0xc
lsl	z20.s, z1.s, #0xc
lsr	z5.s, z5.s, #0x14
lsr	z9.s, z9.s, #0x14
lsr	z13.s, z13.s, #0x14
lsr	z1.s, z1.s, #0x14
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
add	z0.s, z0.s, z5.s
add	z4.s, z4.s, z9.s
add	z8.s, z8.s, z13.s
add	z12.s, z12.s, z1.s
eor	z15.d, z15.d, z0.d
eor	z3.d, z3.d, z4.d
eor	z7.d, z7.d, z8.d
eor	z11.d, z11.d, z12.d
tbl	z15.b, { z15.b }, z31.b
tbl	z3.b, { z3.b }, z31.b
tbl	z7.b, { z7.b }, z31.b
tbl	z11.b, { z11.b }, z31.b
add	z10.s, z10.s, z15.s
add	z14.s, z14.s, z3.s
add	z2.s, z2.s, z7.s
add	z6.s, z6.s, z11.s
eor	z5.d, z5.d, z10.d
eor	z9.d, z9.d, z14.d
eor	z13.d, z13.d, z2.d
eor	z1.d, z1.d, z6.d
lsl	z17.s, z5.s, #0x7
lsl	z18.s, z9.s, #0x7
lsl	z19.s, z13.s, #0x7
lsl	z20.s, z1.s, #0x7
lsr	z5.s, z5.s, #0x19
lsr	z9.s, z9.s, #0x19
lsr	z13.s, z13.s, #0x19
lsr	z1.s, z1.s, #0x19
orr	z5.d, z5.d, z17.d
orr	z9.d, z9.d, z18.d
orr	z13.d, z13.d, z19.d
orr	z1.d, z1.d, z20.d
sub	x6, x6, #0x1
cbnz	x6, L_15b8
lsr	x6, x28, #32
mov	z17.s, w28
mov	z18.s, w6
lsr	x6, x29, #32
mov	z19.s, w6
lsr	x6, x30, #32
add	z0.s, z0.s, z25.s
add	z4.s, z4.s, z26.s
add	z8.s, z8.s, z27.s
add	z12.s, z12.s, z28.s
add	z1.s, z1.s, z29.s
add	z5.s, z5.s, z30.s
add	z9.s, z9.s, z21.s
add	z13.s, z13.s, z22.s
add	z2.s, z2.s, z23.s
add	z6.s, z6.s, z24.s
add	z10.s, z10.s, z17.s
add	z14.s, z14.s, z18.s
mov	z20.s, w30
mov	z25.s, w6
add	z3.s, z3.s, z16.s
add	z7.s, z7.s, z19.s
add	z11.s, z11.s, z20.s
add	z15.s, z15.s, z25.s
cmp	x5, #0x4
b.ne	L_1914
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z0.d, z0.d, z17.d
eor	z1.d, z1.d, z18.d
eor	z2.d, z2.d, z19.d
eor	z3.d, z3.d, z20.d
eor	z4.d, z4.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z6.d, z6.d, z23.d
eor	z7.d, z7.d, z24.d
ld1	{ v17.4s, v18.4s, v19.4s, v20.4s }, [x1], #64
ld1	{ v21.4s, v22.4s, v23.4s, v24.4s }, [x1], #64
eor	z8.d, z8.d, z17.d
eor	z9.d, z9.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z11.d, z11.d, z20.d
eor	z12.d, z12.d, z21.d
eor	z13.d, z13.d, z22.d
eor	z14.d, z14.d, z23.d
eor	z15.d, z15.d, z24.d
st1	{ v0.4s, v1.4s, v2.4s, v3.4s }, [x0], #64
st1	{ v4.4s, v5.4s, v6.4s, v7.4s }, [x0], #64
st1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x0], #64
st1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x0], #64
b	L_1ae4
L_1914:
zip1	z17.s, z0.s, z1.s
zip2	z18.s, z0.s, z1.s
zip1	z19.s, z2.s, z3.s
zip2	z20.s, z2.s, z3.s
zip1	z21.s, z4.s, z5.s
zip2	z22.s, z4.s, z5.s
zip1	z23.s, z6.s, z7.s
zip2	z24.s, z6.s, z7.s
zip1	z0.d, z17.d, z19.d
zip2	z1.d, z17.d, z19.d
zip1	z2.d, z18.d, z20.d
zip2	z3.d, z18.d, z20.d
zip1	z4.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z6.d, z22.d, z24.d
zip2	z7.d, z22.d, z24.d
zip1	z17.s, z8.s, z9.s
zip2	z18.s, z8.s, z9.s
zip1	z19.s, z10.s, z11.s
zip2	z20.s, z10.s, z11.s
zip1	z21.s, z12.s, z13.s
zip2	z22.s, z12.s, z13.s
zip1	z23.s, z14.s, z15.s
zip2	z24.s, z14.s, z15.s
zip1	z8.d, z17.d, z19.d
zip2	z9.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z11.d, z18.d, z20.d
zip1	z12.d, z21.d, z23.d
zip2	z13.d, z21.d, z23.d
zip1	z14.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
zip1	z17.s, z0.s, z4.s
zip2	z18.s, z0.s, z4.s
zip1	z19.s, z8.s, z12.s
zip2	z20.s, z8.s, z12.s
zip1	z21.s, z1.s, z5.s
zip2	z22.s, z1.s, z5.s
zip1	z23.s, z9.s, z13.s
zip2	z24.s, z9.s, z13.s
zip1	z0.d, z17.d, z19.d
zip2	z4.d, z17.d, z19.d
zip1	z8.d, z18.d, z20.d
zip2	z12.d, z18.d, z20.d
zip1	z1.d, z21.d, z23.d
zip2	z5.d, z21.d, z23.d
zip1	z9.d, z22.d, z24.d
zip2	z13.d, z22.d, z24.d
zip1	z17.s, z2.s, z6.s
zip2	z18.s, z2.s, z6.s
zip1	z19.s, z10.s, z14.s
zip2	z20.s, z10.s, z14.s
zip1	z21.s, z3.s, z7.s
zip2	z22.s, z3.s, z7.s
zip1	z23.s, z11.s, z15.s
zip2	z24.s, z11.s, z15.s
zip1	z2.d, z17.d, z19.d
zip2	z6.d, z17.d, z19.d
zip1	z10.d, z18.d, z20.d
zip2	z14.d, z18.d, z20.d
zip1	z3.d, z21.d, z23.d
zip2	z7.d, z21.d, z23.d
zip1	z11.d, z22.d, z24.d
zip2	z15.d, z22.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z0.d, z0.d, z17.d
eor	z4.d, z4.d, z18.d
eor	z8.d, z8.d, z19.d
eor	z12.d, z12.d, z20.d
eor	z1.d, z1.d, z21.d
eor	z5.d, z5.d, z22.d
eor	z9.d, z9.d, z23.d
eor	z13.d, z13.d, z24.d
ld1w	{ z17.s }, p0/z, [x1]
ld1w	{ z18.s }, p0/z, [x1, #0x1, mul vl]
ld1w	{ z19.s }, p0/z, [x1, #0x2, mul vl]
ld1w	{ z20.s }, p0/z, [x1, #0x3, mul vl]
ld1w	{ z21.s }, p0/z, [x1, #0x4, mul vl]
ld1w	{ z22.s }, p0/z, [x1, #0x5, mul vl]
ld1w	{ z23.s }, p0/z, [x1, #0x6, mul vl]
ld1w	{ z24.s }, p0/z, [x1, #0x7, mul vl]
addvl	x1, x1, #0x8
eor	z2.d, z2.d, z17.d
eor	z6.d, z6.d, z18.d
eor	z10.d, z10.d, z19.d
eor	z14.d, z14.d, z20.d
eor	z3.d, z3.d, z21.d
eor	z7.d, z7.d, z22.d
eor	z11.d, z11.d, z23.d
eor	z15.d, z15.d, z24.d
st1w	{ z0.s }, p0, [x0]
st1w	{ z4.s }, p0, [x0, #0x1, mul vl]
st1w	{ z8.s }, p0, [x0, #0x2, mul vl]
st1w	{ z12.s }, p0, [x0, #0x3, mul vl]
st1w	{ z1.s }, p0, [x0, #0x4, mul vl]
st1w	{ z5.s }, p0, [x0, #0x5, mul vl]
st1w	{ z9.s }, p0, [x0, #0x6, mul vl]
st1w	{ z13.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
st1w	{ z2.s }, p0, [x0]
st1w	{ z6.s }, p0, [x0, #0x1, mul vl]
st1w	{ z10.s }, p0, [x0, #0x2, mul vl]
st1w	{ z14.s }, p0, [x0, #0x3, mul vl]
st1w	{ z3.s }, p0, [x0, #0x4, mul vl]
st1w	{ z7.s }, p0, [x0, #0x5, mul vl]
st1w	{ z11.s }, p0, [x0, #0x6, mul vl]
st1w	{ z15.s }, p0, [x0, #0x7, mul vl]
addvl	x0, x0, #0x8
L_1ae4:
incw	x29
L_1ae8:
str	w29, [x4]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
ldp	x16, x17, [sp, #0x40]
ldp	x18, x19, [sp, #0x50]
ldp	x20, x21, [sp, #0x60]
ldp	x22, x23, [sp, #0x70]
ldp	x24, x25, [sp, #0x80]
ldp	x26, x27, [sp, #0x90]
ldp	x28, x29, [sp, #0xa0]
ldr	x30, [sp, #0xb0]
ldp	d8, d9, [sp], #0xc0
L_1b1c:
ret
	.section .rodata
	.p2align 5
_chacha_sve_consts:
	.size _chacha_sve_consts, 32
	.byte 101,120,112,97,110,100,32,51,50,45,98,121,116,101,32,107
	.byte 3,0,1,2,4,4,4,4,3,0,1,2,4,4,4,4

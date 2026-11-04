	.text
gf_6vect_mad_sve:
cmp	x0, #0x10
b.lt	.return_fail
mov	z0.b, #0xf
add	x3, x3, x2, lsl #5
ldp	q6, q7, [x3]
add	x3, x3, x1, lsl #5
ldp	q17, q18, [x3]
add	x3, x3, x1, lsl #5
ldp	q19, q20, [x3]
add	x3, x3, x1, lsl #5
ldp	q21, q22, [x3]
add	x3, x3, x1, lsl #5
ldp	q23, q24, [x3]
add	x3, x3, x1, lsl #5
ldp	q25, q26, [x3]
ldr	x12, [x5]
ldr	x7, [x5, #0x8]
ldr	x8, [x5, #0x10]
ldr	x9, [x5, #0x18]
ldr	x10, [x5, #0x20]
ldr	x11, [x5, #0x28]
mov	x6, #0x0
L_58:
whilelo	p0.b, x6, x0
b.eq	.return_pass
prfb	pldl2strm, p0, [x12, x6]
prfb	pldl2strm, p0, [x7, x6]
ld1b	{ z1.b }, p0/z, [x4, x6]
and	z2.d, z1.d, z0.d
lsr	z1.b, z1.b, #0x4
ld1b	{ z3.b }, p0/z, [x12, x6]
ld1b	{ z27.b }, p0/z, [x7, x6]
prfb	pldl2strm, p0, [x8, x6]
prfb	pldl2strm, p0, [x9, x6]
tbl	z4.b, { z6.b }, z2.b
tbl	z5.b, { z7.b }, z1.b
eor	z3.d, z4.d, z3.d
eor	z3.d, z5.d, z3.d
ld1b	{ z28.b }, p0/z, [x8, x6]
ld1b	{ z29.b }, p0/z, [x9, x6]
prfb	pldl2strm, p0, [x10, x6]
prfb	pldl2strm, p0, [x11, x6]
tbl	z4.b, { z17.b }, z2.b
tbl	z5.b, { z18.b }, z1.b
eor	z27.d, z4.d, z27.d
eor	z27.d, z5.d, z27.d
ld1b	{ z30.b }, p0/z, [x10, x6]
ld1b	{ z31.b }, p0/z, [x11, x6]
tbl	z4.b, { z19.b }, z2.b
tbl	z5.b, { z20.b }, z1.b
eor	z28.d, z4.d, z28.d
eor	z28.d, z5.d, z28.d
st1b	{ z3.b }, p0, [x12, x6]
st1b	{ z27.b }, p0, [x7, x6]
tbl	z4.b, { z21.b }, z2.b
tbl	z5.b, { z22.b }, z1.b
eor	z29.d, z4.d, z29.d
eor	z29.d, z5.d, z29.d
tbl	z4.b, { z23.b }, z2.b
tbl	z5.b, { z24.b }, z1.b
eor	z30.d, z4.d, z30.d
eor	z30.d, z5.d, z30.d
st1b	{ z28.b }, p0, [x8, x6]
st1b	{ z29.b }, p0, [x9, x6]
tbl	z4.b, { z25.b }, z2.b
tbl	z5.b, { z26.b }, z1.b
eor	z31.d, z4.d, z31.d
eor	z31.d, z5.d, z31.d
st1b	{ z30.b }, p0, [x10, x6]
st1b	{ z31.b }, p0, [x11, x6]
incb	x6
b	L_58
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

	.text
gf_vect_mad_sve:
cmp	x0, #0x10
b.lt	.return_fail
mov	z0.b, #0xf
add	x3, x3, x2, lsl #5
ldp	q6, q7, [x3]
mov	x6, #0x0
L_18:
whilelo	p0.b, x6, x0
b.eq	.return_pass
prfb	pldl2strm, p0, [x5, x6]
ld1b	{ z1.b }, p0/z, [x4, x6]
and	z2.d, z1.d, z0.d
lsr	z1.b, z1.b, #0x4
ld1b	{ z3.b }, p0/z, [x5, x6]
tbl	z4.b, { z6.b }, z2.b
tbl	z5.b, { z7.b }, z1.b
eor	z3.d, z4.d, z3.d
eor	z3.d, z5.d, z3.d
st1b	{ z3.b }, p0, [x5, x6]
incb	x6
b	L_18
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

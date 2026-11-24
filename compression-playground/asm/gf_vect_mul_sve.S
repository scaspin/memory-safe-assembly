	.text
gf_vect_mul_sve:
and	x4, x0, #0x1f
cmp	x4, #0x0
b.ne	.return_fail
mov	z0.b, #0xf
mov	x5, #0x0
ldp	q6, q7, [x1]
L_18:
whilelo	p0.b, x5, x0
b.eq	.return_pass
ld1b	{ z1.b }, p0/z, [x2, x5]
and	z2.d, z1.d, z0.d
lsr	z1.b, z1.b, #0x4
tbl	z4.b, { z6.b }, z2.b
tbl	z3.b, { z7.b }, z1.b
eor	z3.d, z3.d, z4.d
st1b	{ z3.b }, p0, [x3, x5]
incb	x5
b	L_18
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

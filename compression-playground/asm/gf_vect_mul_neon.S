	.text
gf_vect_mul_neon:
cmp	x0, #0x20
b.lt	.return_fail
movi	v0.16b, #0xf
add	x4, x2, x0
ldr	q2, [x1]
ldr	q3, [x1, #0x10]
cmp	x0, #0x80
b.lt	L_148
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x4, x4, #0x80
L_38:
ldr	q16, [x2]
ldr	q17, [x2, #0x10]
ldr	q18, [x2, #0x20]
ldr	q19, [x2, #0x30]
ldr	q20, [x2, #0x40]
ldr	q21, [x2, #0x50]
ldr	q22, [x2, #0x60]
ldr	q23, [x2, #0x70]
and	v24.16b, v16.16b, v0.16b
and	v25.16b, v17.16b, v0.16b
and	v26.16b, v18.16b, v0.16b
and	v27.16b, v19.16b, v0.16b
and	v28.16b, v20.16b, v0.16b
and	v29.16b, v21.16b, v0.16b
and	v30.16b, v22.16b, v0.16b
and	v31.16b, v23.16b, v0.16b
ushr	v16.16b, v16.16b, #0x4
ushr	v17.16b, v17.16b, #0x4
ushr	v18.16b, v18.16b, #0x4
ushr	v19.16b, v19.16b, #0x4
ushr	v20.16b, v20.16b, #0x4
ushr	v21.16b, v21.16b, #0x4
ushr	v22.16b, v22.16b, #0x4
ushr	v23.16b, v23.16b, #0x4
tbl	v24.16b, { v2.16b }, v24.16b
tbl	v25.16b, { v2.16b }, v25.16b
tbl	v26.16b, { v2.16b }, v26.16b
tbl	v27.16b, { v2.16b }, v27.16b
tbl	v28.16b, { v2.16b }, v28.16b
tbl	v29.16b, { v2.16b }, v29.16b
tbl	v30.16b, { v2.16b }, v30.16b
tbl	v31.16b, { v2.16b }, v31.16b
tbl	v16.16b, { v3.16b }, v16.16b
tbl	v17.16b, { v3.16b }, v17.16b
tbl	v18.16b, { v3.16b }, v18.16b
tbl	v19.16b, { v3.16b }, v19.16b
tbl	v20.16b, { v3.16b }, v20.16b
tbl	v21.16b, { v3.16b }, v21.16b
tbl	v22.16b, { v3.16b }, v22.16b
tbl	v23.16b, { v3.16b }, v23.16b
eor	v16.16b, v16.16b, v24.16b
eor	v17.16b, v17.16b, v25.16b
eor	v18.16b, v18.16b, v26.16b
eor	v19.16b, v19.16b, v27.16b
eor	v20.16b, v20.16b, v28.16b
eor	v21.16b, v21.16b, v29.16b
eor	v22.16b, v22.16b, v30.16b
eor	v23.16b, v23.16b, v31.16b
str	q16, [x3]
str	q17, [x3, #0x10]
str	q18, [x3, #0x20]
str	q19, [x3, #0x30]
str	q20, [x3, #0x40]
str	q21, [x3, #0x50]
str	q22, [x3, #0x60]
str	q23, [x3, #0x70]
add	x2, x2, #0x80
add	x3, x3, #0x80
cmp	x2, x4
b.ls	L_38
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x4, x4, #0x80
cmp	x2, x4
b.eq	.return_pass
L_148:
sub	x4, x4, #0x20
cmp	x2, x4
b.hi	.return_fail
L_154:
ldr	q16, [x2]
ldr	q17, [x2, #0x10]
and	v24.16b, v16.16b, v0.16b
and	v25.16b, v17.16b, v0.16b
ushr	v16.16b, v16.16b, #0x4
ushr	v17.16b, v17.16b, #0x4
tbl	v24.16b, { v2.16b }, v24.16b
tbl	v25.16b, { v2.16b }, v25.16b
tbl	v16.16b, { v3.16b }, v16.16b
tbl	v17.16b, { v3.16b }, v17.16b
eor	v16.16b, v16.16b, v24.16b
eor	v17.16b, v17.16b, v25.16b
str	q16, [x3]
str	q17, [x3, #0x10]
add	x3, x3, #0x20
add	x2, x2, #0x20
cmp	x2, x4
b.ls	L_154
sub	x5, x2, x4
cmp	x5, #0x20
b.eq	.return_pass
b	.return_fail
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

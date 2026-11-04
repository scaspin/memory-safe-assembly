	.text
gf_3vect_dot_prod_neon:
cmp	x0, #0x10
b.lt	.return_fail
movi	v6.16b, #0xf
mov	x7, #0x0
lsl	x1, x1, #3
ldr	x9, [x4]
ldr	x11, [x4, #0x8]
ldr	x13, [x4, #0x10]
cmp	x0, #0x40
b.lt	L_1f0
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x0, x0, #0x40
L_40:
movi	v20.16b, #0x0
movi	v21.16b, #0x0
movi	v22.16b, #0x0
movi	v23.16b, #0x0
movi	v24.16b, #0x0
movi	v25.16b, #0x0
movi	v26.16b, #0x0
movi	v27.16b, #0x0
movi	v28.16b, #0x0
movi	v29.16b, #0x0
movi	v30.16b, #0x0
movi	v31.16b, #0x0
mov	x10, x2
add	x12, x10, x1, lsl #2
add	x14, x12, x1, lsl #2
mov	x5, #0x0
L_80:
ldr	x6, [x3, x5]
add	x5, x5, #0x8
add	x6, x6, x7
ldr	q8, [x6], #0x10
ldr	q9, [x6], #0x10
ldp	q0, q1, [x10], #0x20
ldp	q2, q3, [x12], #0x20
ldp	q4, q5, [x14], #0x20
ldr	q10, [x6], #0x10
ldr	q11, [x6], #0x10
prfm	pldl1strm, [x6]
prfm	pldl1keep, [x10]
prfm	pldl1keep, [x12]
prfm	pldl1keep, [x14]
and	v7.16b, v8.16b, v6.16b
ushr	v8.16b, v8.16b, #0x4
tbl	v12.16b, { v0.16b }, v7.16b
tbl	v13.16b, { v1.16b }, v8.16b
eor	v20.16b, v12.16b, v20.16b
eor	v20.16b, v20.16b, v13.16b
tbl	v12.16b, { v2.16b }, v7.16b
tbl	v13.16b, { v3.16b }, v8.16b
eor	v24.16b, v12.16b, v24.16b
eor	v24.16b, v24.16b, v13.16b
tbl	v12.16b, { v4.16b }, v7.16b
tbl	v13.16b, { v5.16b }, v8.16b
eor	v28.16b, v12.16b, v28.16b
eor	v28.16b, v28.16b, v13.16b
and	v7.16b, v9.16b, v6.16b
ushr	v9.16b, v9.16b, #0x4
tbl	v12.16b, { v0.16b }, v7.16b
tbl	v13.16b, { v1.16b }, v9.16b
eor	v21.16b, v12.16b, v21.16b
eor	v21.16b, v21.16b, v13.16b
tbl	v12.16b, { v2.16b }, v7.16b
tbl	v13.16b, { v3.16b }, v9.16b
eor	v25.16b, v12.16b, v25.16b
eor	v25.16b, v25.16b, v13.16b
tbl	v12.16b, { v4.16b }, v7.16b
tbl	v13.16b, { v5.16b }, v9.16b
eor	v29.16b, v12.16b, v29.16b
eor	v29.16b, v29.16b, v13.16b
and	v7.16b, v10.16b, v6.16b
ushr	v10.16b, v10.16b, #0x4
tbl	v12.16b, { v0.16b }, v7.16b
tbl	v13.16b, { v1.16b }, v10.16b
eor	v22.16b, v12.16b, v22.16b
eor	v22.16b, v22.16b, v13.16b
tbl	v12.16b, { v2.16b }, v7.16b
tbl	v13.16b, { v3.16b }, v10.16b
eor	v26.16b, v12.16b, v26.16b
eor	v26.16b, v26.16b, v13.16b
tbl	v12.16b, { v4.16b }, v7.16b
tbl	v13.16b, { v5.16b }, v10.16b
eor	v30.16b, v12.16b, v30.16b
eor	v30.16b, v30.16b, v13.16b
and	v7.16b, v11.16b, v6.16b
ushr	v11.16b, v11.16b, #0x4
tbl	v12.16b, { v0.16b }, v7.16b
tbl	v13.16b, { v1.16b }, v11.16b
eor	v23.16b, v12.16b, v23.16b
eor	v23.16b, v23.16b, v13.16b
tbl	v12.16b, { v2.16b }, v7.16b
tbl	v13.16b, { v3.16b }, v11.16b
eor	v27.16b, v12.16b, v27.16b
eor	v27.16b, v27.16b, v13.16b
tbl	v12.16b, { v4.16b }, v7.16b
tbl	v13.16b, { v5.16b }, v11.16b
eor	v31.16b, v12.16b, v31.16b
eor	v31.16b, v31.16b, v13.16b
cmp	x5, x1
b.lt	L_80
add	x6, x9, x7
stp	q20, q21, [x6], #0x20
stp	q22, q23, [x6]
add	x6, x11, x7
stp	q24, q25, [x6], #0x20
stp	q26, q27, [x6]
add	x6, x13, x7
stp	q28, q29, [x6], #0x20
stp	q30, q31, [x6]
add	x7, x7, #0x40
cmp	x7, x0
b.le	L_40
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x0, x0, #0x40
cmp	x7, x0
b.eq	.return_pass
L_1f0:
sub	x0, x0, #0x10
cmp	x7, x0
b.gt	.lessthan16_init
L_1fc:
movi	v20.16b, #0x0
movi	v24.16b, #0x0
movi	v28.16b, #0x0
mov	x10, x2
add	x12, x10, x1, lsl #2
add	x14, x12, x1, lsl #2
mov	x5, #0x0
L_218:
ldr	x6, [x3, x5]
add	x5, x5, #0x8
ldr	q21, [x6, x7]
ldp	q0, q1, [x10], #0x20
ldp	q2, q3, [x12], #0x20
ldp	q4, q5, [x14], #0x20
and	v22.16b, v21.16b, v6.16b
ushr	v23.16b, v21.16b, #0x4
tbl	v0.16b, { v0.16b }, v22.16b
tbl	v1.16b, { v1.16b }, v23.16b
tbl	v2.16b, { v2.16b }, v22.16b
tbl	v3.16b, { v3.16b }, v23.16b
tbl	v4.16b, { v4.16b }, v22.16b
tbl	v5.16b, { v5.16b }, v23.16b
eor	v20.16b, v1.16b, v20.16b
eor	v20.16b, v20.16b, v0.16b
eor	v24.16b, v3.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
eor	v28.16b, v5.16b, v28.16b
eor	v28.16b, v28.16b, v4.16b
cmp	x5, x1
b.ne	L_218
str	q20, [x9, x7]
str	q24, [x11, x7]
str	q28, [x13, x7]
add	x7, x7, #0x10
cmp	x7, x0
b.le	L_1fc
sub	x8, x7, x0
cmp	x8, #0x10
b.eq	.return_pass
.lessthan16_init:
mov	x7, x0
b	L_1fc
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

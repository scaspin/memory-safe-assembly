	.text
gf_2vect_dot_prod_neon:
cmp	x0, #0x10
b.lt	.return_fail
movi	v4.16b, #0xf
mov	x7, #0x0
lsl	x1, x1, #3
ldr	x11, [x4]
ldr	x12, [x4, #0x8]
cmp	x0, #0x80
b.lt	L_254
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x0, x0, #0x80
L_3c:
movi	v16.16b, #0x0
movi	v17.16b, #0x0
movi	v18.16b, #0x0
movi	v19.16b, #0x0
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
mov	x9, x2
add	x10, x2, x1, lsl #2
mov	x5, #0x0
L_88:
ldr	x6, [x3, x5]
add	x5, x5, #0x8
add	x6, x6, x7
ldp	q8, q9, [x6], #0x20
ldp	q10, q11, [x6], #0x20
ldp	q0, q1, [x9], #0x20
ldp	q2, q3, [x10], #0x20
ldp	q12, q13, [x6], #0x20
ldp	q14, q15, [x6], #0x20
prfm	pldl1strm, [x6]
prfm	pldl1keep, [x9]
prfm	pldl1keep, [x10]
and	v7.16b, v8.16b, v4.16b
ushr	v8.16b, v8.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v8.16b
eor	v16.16b, v5.16b, v16.16b
eor	v16.16b, v16.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v8.16b
eor	v24.16b, v5.16b, v24.16b
eor	v24.16b, v24.16b, v6.16b
and	v7.16b, v9.16b, v4.16b
ushr	v9.16b, v9.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v9.16b
eor	v17.16b, v5.16b, v17.16b
eor	v17.16b, v17.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v9.16b
eor	v25.16b, v5.16b, v25.16b
eor	v25.16b, v25.16b, v6.16b
and	v7.16b, v10.16b, v4.16b
ushr	v10.16b, v10.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v10.16b
eor	v18.16b, v5.16b, v18.16b
eor	v18.16b, v18.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v10.16b
eor	v26.16b, v5.16b, v26.16b
eor	v26.16b, v26.16b, v6.16b
and	v7.16b, v11.16b, v4.16b
ushr	v11.16b, v11.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v11.16b
eor	v19.16b, v5.16b, v19.16b
eor	v19.16b, v19.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v11.16b
eor	v27.16b, v5.16b, v27.16b
eor	v27.16b, v27.16b, v6.16b
and	v7.16b, v12.16b, v4.16b
ushr	v12.16b, v12.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v12.16b
eor	v20.16b, v5.16b, v20.16b
eor	v20.16b, v20.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v12.16b
eor	v28.16b, v5.16b, v28.16b
eor	v28.16b, v28.16b, v6.16b
and	v7.16b, v13.16b, v4.16b
ushr	v13.16b, v13.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v13.16b
eor	v21.16b, v5.16b, v21.16b
eor	v21.16b, v21.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v13.16b
eor	v29.16b, v5.16b, v29.16b
eor	v29.16b, v29.16b, v6.16b
and	v7.16b, v14.16b, v4.16b
ushr	v14.16b, v14.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v14.16b
eor	v22.16b, v5.16b, v22.16b
eor	v22.16b, v22.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v14.16b
eor	v30.16b, v5.16b, v30.16b
eor	v30.16b, v30.16b, v6.16b
and	v7.16b, v15.16b, v4.16b
ushr	v15.16b, v15.16b, #0x4
tbl	v5.16b, { v0.16b }, v7.16b
tbl	v6.16b, { v1.16b }, v15.16b
eor	v23.16b, v5.16b, v23.16b
eor	v23.16b, v23.16b, v6.16b
tbl	v5.16b, { v2.16b }, v7.16b
tbl	v6.16b, { v3.16b }, v15.16b
eor	v31.16b, v5.16b, v31.16b
eor	v31.16b, v31.16b, v6.16b
cmp	x5, x1
b.lt	L_88
add	x6, x11, x7
stp	q16, q17, [x6], #0x20
stp	q18, q19, [x6], #0x20
stp	q20, q21, [x6], #0x20
stp	q22, q23, [x6]
add	x6, x12, x7
stp	q24, q25, [x6], #0x20
stp	q26, q27, [x6], #0x20
stp	q28, q29, [x6], #0x20
stp	q30, q31, [x6]
add	x7, x7, #0x80
cmp	x7, x0
b.le	L_3c
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x0, x0, #0x80
cmp	x7, x0
b.eq	.return_pass
L_254:
sub	x0, x0, #0x10
cmp	x7, x0
b.gt	.lessthan16_init
L_260:
movi	v16.16b, #0x0
movi	v24.16b, #0x0
mov	x9, x2
add	x10, x2, x1, lsl #2
mov	x5, #0x0
L_274:
ldr	x6, [x3, x5]
ldr	q17, [x6, x7]
add	x5, x5, #0x8
ldp	q0, q1, [x9], #0x20
ldp	q2, q3, [x10], #0x20
and	v18.16b, v17.16b, v4.16b
ushr	v19.16b, v17.16b, #0x4
tbl	v6.16b, { v1.16b }, v19.16b
tbl	v5.16b, { v0.16b }, v18.16b
eor	v16.16b, v5.16b, v16.16b
eor	v16.16b, v16.16b, v6.16b
tbl	v6.16b, { v3.16b }, v19.16b
tbl	v5.16b, { v2.16b }, v18.16b
eor	v24.16b, v5.16b, v24.16b
eor	v24.16b, v24.16b, v6.16b
cmp	x5, x1
b.ne	L_274
str	q16, [x11, x7]
str	q24, [x12, x7]
add	x7, x7, #0x10
cmp	x7, x0
b.le	L_260
sub	x8, x7, x0
cmp	x8, #0x10
b.eq	.return_pass
.lessthan16_init:
mov	x7, x0
b	L_260
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

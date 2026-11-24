	.text
gf_5vect_dot_prod_neon:
cmp	x0, #0x10
b.lt	.return_fail
mov	x7, #0x0
lsl	x1, x1, #3
ldr	x9, [x4]
ldr	x10, [x4, #0x8]
ldr	x11, [x4, #0x10]
ldr	x12, [x4, #0x18]
ldr	x13, [x4, #0x20]
cmp	x0, #0x40
b.lt	L_2c8
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x0, x0, #0x40
L_44:
movi	v4.16b, #0x0
movi	v17.16b, #0x0
movi	v22.16b, #0x0
movi	v27.16b, #0x0
movi	v5.16b, #0x0
movi	v18.16b, #0x0
movi	v23.16b, #0x0
movi	v28.16b, #0x0
movi	v6.16b, #0x0
movi	v19.16b, #0x0
movi	v24.16b, #0x0
movi	v29.16b, #0x0
movi	v7.16b, #0x0
movi	v20.16b, #0x0
movi	v25.16b, #0x0
movi	v30.16b, #0x0
movi	v16.16b, #0x0
movi	v21.16b, #0x0
movi	v26.16b, #0x0
movi	v31.16b, #0x0
mov	x5, #0x0
L_98:
ldr	x6, [x3, x5]
add	x6, x6, x7
ldr	q8, [x6], #0x10
ldr	q9, [x6], #0x10
ldr	q10, [x6], #0x10
ldr	q11, [x6], #0x10
prfm	pldl2keep, [x6]
movi	v0.16b, #0xf
and	v12.16b, v8.16b, v0.16b
and	v13.16b, v9.16b, v0.16b
and	v14.16b, v10.16b, v0.16b
and	v15.16b, v11.16b, v0.16b
ushr	v8.16b, v8.16b, #0x4
ushr	v9.16b, v9.16b, #0x4
ushr	v10.16b, v10.16b, #0x4
ushr	v11.16b, v11.16b, #0x4
add	x8, x2, x5, lsl #2
add	x5, x5, #0x8
ldp	q2, q3, [x8]
prfm	pldl3keep, [x8, #0x20]
add	x8, x8, x1, lsl #2
tbl	v0.16b, { v2.16b }, v12.16b
tbl	v1.16b, { v3.16b }, v8.16b
eor	v4.16b, v0.16b, v4.16b
eor	v4.16b, v4.16b, v1.16b
tbl	v0.16b, { v2.16b }, v13.16b
tbl	v1.16b, { v3.16b }, v9.16b
eor	v17.16b, v0.16b, v17.16b
eor	v17.16b, v17.16b, v1.16b
tbl	v0.16b, { v2.16b }, v14.16b
tbl	v1.16b, { v3.16b }, v10.16b
eor	v22.16b, v0.16b, v22.16b
eor	v22.16b, v22.16b, v1.16b
tbl	v0.16b, { v2.16b }, v15.16b
tbl	v1.16b, { v3.16b }, v11.16b
eor	v27.16b, v0.16b, v27.16b
eor	v27.16b, v27.16b, v1.16b
ldp	q2, q3, [x8]
prfm	pldl3keep, [x8, #0x20]
add	x8, x8, x1, lsl #2
tbl	v0.16b, { v2.16b }, v12.16b
tbl	v1.16b, { v3.16b }, v8.16b
eor	v5.16b, v0.16b, v5.16b
eor	v5.16b, v5.16b, v1.16b
tbl	v0.16b, { v2.16b }, v13.16b
tbl	v1.16b, { v3.16b }, v9.16b
eor	v18.16b, v0.16b, v18.16b
eor	v18.16b, v18.16b, v1.16b
tbl	v0.16b, { v2.16b }, v14.16b
tbl	v1.16b, { v3.16b }, v10.16b
eor	v23.16b, v0.16b, v23.16b
eor	v23.16b, v23.16b, v1.16b
tbl	v0.16b, { v2.16b }, v15.16b
tbl	v1.16b, { v3.16b }, v11.16b
eor	v28.16b, v0.16b, v28.16b
eor	v28.16b, v28.16b, v1.16b
ldp	q2, q3, [x8]
prfm	pldl3keep, [x8, #0x20]
add	x8, x8, x1, lsl #2
tbl	v0.16b, { v2.16b }, v12.16b
tbl	v1.16b, { v3.16b }, v8.16b
eor	v6.16b, v0.16b, v6.16b
eor	v6.16b, v6.16b, v1.16b
tbl	v0.16b, { v2.16b }, v13.16b
tbl	v1.16b, { v3.16b }, v9.16b
eor	v19.16b, v0.16b, v19.16b
eor	v19.16b, v19.16b, v1.16b
tbl	v0.16b, { v2.16b }, v14.16b
tbl	v1.16b, { v3.16b }, v10.16b
eor	v24.16b, v0.16b, v24.16b
eor	v24.16b, v24.16b, v1.16b
tbl	v0.16b, { v2.16b }, v15.16b
tbl	v1.16b, { v3.16b }, v11.16b
eor	v29.16b, v0.16b, v29.16b
eor	v29.16b, v29.16b, v1.16b
ldp	q2, q3, [x8]
prfm	pldl3keep, [x8, #0x20]
add	x8, x8, x1, lsl #2
tbl	v0.16b, { v2.16b }, v12.16b
tbl	v1.16b, { v3.16b }, v8.16b
eor	v7.16b, v0.16b, v7.16b
eor	v7.16b, v7.16b, v1.16b
tbl	v0.16b, { v2.16b }, v13.16b
tbl	v1.16b, { v3.16b }, v9.16b
eor	v20.16b, v0.16b, v20.16b
eor	v20.16b, v20.16b, v1.16b
tbl	v0.16b, { v2.16b }, v14.16b
tbl	v1.16b, { v3.16b }, v10.16b
eor	v25.16b, v0.16b, v25.16b
eor	v25.16b, v25.16b, v1.16b
tbl	v0.16b, { v2.16b }, v15.16b
tbl	v1.16b, { v3.16b }, v11.16b
eor	v30.16b, v0.16b, v30.16b
eor	v30.16b, v30.16b, v1.16b
ldp	q2, q3, [x8]
prfm	pldl3keep, [x8, #0x20]
tbl	v0.16b, { v2.16b }, v12.16b
tbl	v1.16b, { v3.16b }, v8.16b
eor	v16.16b, v0.16b, v16.16b
eor	v16.16b, v16.16b, v1.16b
tbl	v0.16b, { v2.16b }, v13.16b
tbl	v1.16b, { v3.16b }, v9.16b
eor	v21.16b, v0.16b, v21.16b
eor	v21.16b, v21.16b, v1.16b
tbl	v0.16b, { v2.16b }, v14.16b
tbl	v1.16b, { v3.16b }, v10.16b
eor	v26.16b, v0.16b, v26.16b
eor	v26.16b, v26.16b, v1.16b
tbl	v0.16b, { v2.16b }, v15.16b
tbl	v1.16b, { v3.16b }, v11.16b
eor	v31.16b, v0.16b, v31.16b
eor	v31.16b, v31.16b, v1.16b
cmp	x5, x1
b.lt	L_98
add	x6, x9, x7
stp	q4, q17, [x6], #0x20
stp	q22, q27, [x6]
add	x6, x10, x7
stp	q5, q18, [x6], #0x20
stp	q23, q28, [x6]
add	x6, x11, x7
stp	q6, q19, [x6], #0x20
stp	q24, q29, [x6]
add	x6, x12, x7
stp	q7, q20, [x6], #0x20
stp	q25, q30, [x6]
add	x6, x13, x7
stp	q16, q21, [x6], #0x20
stp	q26, q31, [x6]
add	x7, x7, #0x40
cmp	x7, x0
b.le	L_44
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x0, x0, #0x40
cmp	x7, x0
b.eq	.return_pass
L_2c8:
sub	x0, x0, #0x10
cmp	x7, x0
b.gt	.lessthan16_init
L_2d4:
movi	v4.16b, #0x0
movi	v5.16b, #0x0
movi	v6.16b, #0x0
movi	v7.16b, #0x0
movi	v16.16b, #0x0
mov	x5, #0x0
L_2ec:
ldr	x6, [x3, x5]
ldr	q17, [x6, x7]
movi	v0.16b, #0xf
and	v18.16b, v17.16b, v0.16b
ushr	v19.16b, v17.16b, #0x4
add	x8, x2, x5, lsl #2
add	x5, x5, #0x8
ldp	q20, q21, [x8]
add	x8, x8, x1, lsl #2
ldp	q22, q23, [x8]
add	x8, x8, x1, lsl #2
ldp	q24, q25, [x8]
add	x8, x8, x1, lsl #2
ldp	q26, q27, [x8]
add	x8, x8, x1, lsl #2
ldp	q28, q29, [x8]
tbl	v20.16b, { v20.16b }, v18.16b
tbl	v21.16b, { v21.16b }, v19.16b
tbl	v22.16b, { v22.16b }, v18.16b
tbl	v23.16b, { v23.16b }, v19.16b
tbl	v24.16b, { v24.16b }, v18.16b
tbl	v25.16b, { v25.16b }, v19.16b
tbl	v26.16b, { v26.16b }, v18.16b
tbl	v27.16b, { v27.16b }, v19.16b
tbl	v28.16b, { v28.16b }, v18.16b
tbl	v29.16b, { v29.16b }, v19.16b
eor	v4.16b, v21.16b, v4.16b
eor	v4.16b, v4.16b, v20.16b
eor	v5.16b, v23.16b, v5.16b
eor	v5.16b, v5.16b, v22.16b
eor	v6.16b, v25.16b, v6.16b
eor	v6.16b, v6.16b, v24.16b
eor	v7.16b, v27.16b, v7.16b
eor	v7.16b, v7.16b, v26.16b
eor	v16.16b, v29.16b, v16.16b
eor	v16.16b, v16.16b, v28.16b
cmp	x5, x1
b.ne	L_2ec
str	q4, [x9, x7]
str	q5, [x10, x7]
str	q6, [x11, x7]
str	q7, [x12, x7]
str	q16, [x13, x7]
add	x7, x7, #0x10
cmp	x7, x0
b.le	L_2d4
sub	x8, x7, x0
cmp	x8, #0x10
b.eq	.return_pass
.lessthan16_init:
mov	x7, x0
b	L_2d4
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret

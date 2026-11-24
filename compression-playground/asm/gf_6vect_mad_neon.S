	.text
gf_6vect_mad_neon:
cmp	x0, #0x10
b.lt	.return_fail
movi	v0.16b, #0xf
lsl	x2, x2, #5
lsl	x1, x1, #5
add	x13, x3, x2
add	x14, x13, x1
add	x15, x14, x1
add	x16, x15, x1
add	x17, x16, x1
add	x3, x17, x1
add	x6, x4, x0
ldr	x7, [x5]
ldr	x8, [x5, #0x8]
ldr	x9, [x5, #0x10]
ldr	x10, [x5, #0x18]
ldr	x11, [x5, #0x20]
ldr	x5, [x5, #0x28]
ldr	q4, [x13]
ldr	q5, [x13, #0x10]
ldr	q18, [x16]
ldr	q19, [x16, #0x10]
cmp	x0, #0x40
b.lt	L_344
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x6, x6, #0x40
L_78:
ldr	q8, [x4]
ldr	q9, [x4, #0x10]
ldr	q10, [x4, #0x20]
ldr	q11, [x4, #0x30]
add	x4, x4, #0x40
ldr	q20, [x7]
ldr	q21, [x7, #0x10]
ldr	q22, [x7, #0x20]
ldr	q23, [x7, #0x30]
ldr	q24, [x8]
ldr	q25, [x8, #0x10]
ldr	q26, [x8, #0x20]
ldr	q27, [x8, #0x30]
ldr	q28, [x9]
ldr	q29, [x9, #0x10]
ldr	q30, [x9, #0x20]
ldr	q31, [x9, #0x30]
ldr	q6, [x14]
ldr	q7, [x14, #0x10]
ldr	q16, [x15]
ldr	q17, [x15, #0x10]
and	v12.16b, v8.16b, v0.16b
and	v13.16b, v9.16b, v0.16b
and	v14.16b, v10.16b, v0.16b
and	v15.16b, v11.16b, v0.16b
ushr	v8.16b, v8.16b, #0x4
ushr	v9.16b, v9.16b, #0x4
ushr	v10.16b, v10.16b, #0x4
ushr	v11.16b, v11.16b, #0x4
tbl	v1.16b, { v4.16b }, v12.16b
tbl	v2.16b, { v5.16b }, v8.16b
eor	v20.16b, v1.16b, v20.16b
eor	v20.16b, v20.16b, v2.16b
tbl	v1.16b, { v4.16b }, v13.16b
tbl	v2.16b, { v5.16b }, v9.16b
eor	v21.16b, v1.16b, v21.16b
eor	v21.16b, v21.16b, v2.16b
tbl	v1.16b, { v4.16b }, v14.16b
tbl	v2.16b, { v5.16b }, v10.16b
eor	v22.16b, v1.16b, v22.16b
eor	v22.16b, v22.16b, v2.16b
tbl	v1.16b, { v4.16b }, v15.16b
tbl	v2.16b, { v5.16b }, v11.16b
eor	v23.16b, v1.16b, v23.16b
eor	v23.16b, v23.16b, v2.16b
tbl	v1.16b, { v6.16b }, v12.16b
tbl	v2.16b, { v7.16b }, v8.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v6.16b }, v13.16b
tbl	v2.16b, { v7.16b }, v9.16b
eor	v25.16b, v1.16b, v25.16b
eor	v25.16b, v25.16b, v2.16b
tbl	v1.16b, { v6.16b }, v14.16b
tbl	v2.16b, { v7.16b }, v10.16b
eor	v26.16b, v1.16b, v26.16b
eor	v26.16b, v26.16b, v2.16b
tbl	v1.16b, { v6.16b }, v15.16b
tbl	v2.16b, { v7.16b }, v11.16b
eor	v27.16b, v1.16b, v27.16b
eor	v27.16b, v27.16b, v2.16b
tbl	v1.16b, { v16.16b }, v12.16b
tbl	v2.16b, { v17.16b }, v8.16b
eor	v28.16b, v1.16b, v28.16b
eor	v28.16b, v28.16b, v2.16b
tbl	v1.16b, { v16.16b }, v13.16b
tbl	v2.16b, { v17.16b }, v9.16b
eor	v29.16b, v1.16b, v29.16b
eor	v29.16b, v29.16b, v2.16b
tbl	v1.16b, { v16.16b }, v14.16b
tbl	v2.16b, { v17.16b }, v10.16b
eor	v30.16b, v1.16b, v30.16b
eor	v30.16b, v30.16b, v2.16b
tbl	v1.16b, { v16.16b }, v15.16b
tbl	v2.16b, { v17.16b }, v11.16b
eor	v31.16b, v1.16b, v31.16b
eor	v31.16b, v31.16b, v2.16b
str	q20, [x7]
str	q21, [x7, #0x10]
str	q22, [x7, #0x20]
str	q23, [x7, #0x30]
add	x7, x7, #0x40
str	q24, [x8]
str	q25, [x8, #0x10]
str	q26, [x8, #0x20]
str	q27, [x8, #0x30]
add	x8, x8, #0x40
str	q28, [x9]
str	q29, [x9, #0x10]
str	q30, [x9, #0x20]
str	q31, [x9, #0x30]
add	x9, x9, #0x40
ldr	q20, [x10]
ldr	q21, [x10, #0x10]
ldr	q22, [x10, #0x20]
ldr	q23, [x10, #0x30]
ldr	q24, [x11]
ldr	q25, [x11, #0x10]
ldr	q26, [x11, #0x20]
ldr	q27, [x11, #0x30]
ldr	q28, [x5]
ldr	q29, [x5, #0x10]
ldr	q30, [x5, #0x20]
ldr	q31, [x5, #0x30]
ldr	q6, [x17]
ldr	q7, [x17, #0x10]
ldr	q16, [x3]
ldr	q17, [x3, #0x10]
tbl	v1.16b, { v18.16b }, v12.16b
tbl	v2.16b, { v19.16b }, v8.16b
eor	v20.16b, v1.16b, v20.16b
eor	v20.16b, v20.16b, v2.16b
tbl	v1.16b, { v18.16b }, v13.16b
tbl	v2.16b, { v19.16b }, v9.16b
eor	v21.16b, v1.16b, v21.16b
eor	v21.16b, v21.16b, v2.16b
tbl	v1.16b, { v18.16b }, v14.16b
tbl	v2.16b, { v19.16b }, v10.16b
eor	v22.16b, v1.16b, v22.16b
eor	v22.16b, v22.16b, v2.16b
tbl	v1.16b, { v18.16b }, v15.16b
tbl	v2.16b, { v19.16b }, v11.16b
eor	v23.16b, v1.16b, v23.16b
eor	v23.16b, v23.16b, v2.16b
tbl	v1.16b, { v6.16b }, v12.16b
tbl	v2.16b, { v7.16b }, v8.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v6.16b }, v13.16b
tbl	v2.16b, { v7.16b }, v9.16b
eor	v25.16b, v1.16b, v25.16b
eor	v25.16b, v25.16b, v2.16b
tbl	v1.16b, { v6.16b }, v14.16b
tbl	v2.16b, { v7.16b }, v10.16b
eor	v26.16b, v1.16b, v26.16b
eor	v26.16b, v26.16b, v2.16b
tbl	v1.16b, { v6.16b }, v15.16b
tbl	v2.16b, { v7.16b }, v11.16b
eor	v27.16b, v1.16b, v27.16b
eor	v27.16b, v27.16b, v2.16b
tbl	v1.16b, { v16.16b }, v12.16b
tbl	v2.16b, { v17.16b }, v8.16b
eor	v28.16b, v1.16b, v28.16b
eor	v28.16b, v28.16b, v2.16b
tbl	v1.16b, { v16.16b }, v13.16b
tbl	v2.16b, { v17.16b }, v9.16b
eor	v29.16b, v1.16b, v29.16b
eor	v29.16b, v29.16b, v2.16b
tbl	v1.16b, { v16.16b }, v14.16b
tbl	v2.16b, { v17.16b }, v10.16b
eor	v30.16b, v1.16b, v30.16b
eor	v30.16b, v30.16b, v2.16b
tbl	v1.16b, { v16.16b }, v15.16b
tbl	v2.16b, { v17.16b }, v11.16b
eor	v31.16b, v1.16b, v31.16b
eor	v31.16b, v31.16b, v2.16b
str	q20, [x10]
str	q21, [x10, #0x10]
str	q22, [x10, #0x20]
str	q23, [x10, #0x30]
add	x10, x10, #0x40
str	q24, [x11]
str	q25, [x11, #0x10]
str	q26, [x11, #0x20]
str	q27, [x11, #0x30]
add	x11, x11, #0x40
str	q28, [x5]
str	q29, [x5, #0x10]
str	q30, [x5, #0x20]
str	q31, [x5, #0x30]
add	x5, x5, #0x40
cmp	x4, x6
b.ls	L_78
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x6, x6, #0x40
L_344:
sub	x6, x6, #0x10
cmp	x4, x6
b.hi	.lessthan16_init
L_350:
ldr	q21, [x4]
ldr	q20, [x7]
ldr	q24, [x8]
ldr	q28, [x9]
ldr	q6, [x14]
ldr	q7, [x14, #0x10]
ldr	q16, [x15]
ldr	q17, [x15, #0x10]
and	v22.16b, v21.16b, v0.16b
ushr	v23.16b, v21.16b, #0x4
tbl	v1.16b, { v4.16b }, v22.16b
tbl	v2.16b, { v5.16b }, v23.16b
eor	v20.16b, v1.16b, v20.16b
eor	v20.16b, v20.16b, v2.16b
tbl	v1.16b, { v6.16b }, v22.16b
tbl	v2.16b, { v7.16b }, v23.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v16.16b }, v22.16b
tbl	v2.16b, { v17.16b }, v23.16b
eor	v28.16b, v1.16b, v28.16b
eor	v28.16b, v28.16b, v2.16b
str	q20, [x7]
str	q24, [x8]
str	q28, [x9]
ldr	q20, [x10]
ldr	q24, [x11]
ldr	q28, [x5]
ldr	q6, [x17]
ldr	q7, [x17, #0x10]
ldr	q16, [x3]
ldr	q17, [x3, #0x10]
tbl	v1.16b, { v18.16b }, v22.16b
tbl	v2.16b, { v19.16b }, v23.16b
eor	v20.16b, v1.16b, v20.16b
eor	v20.16b, v20.16b, v2.16b
tbl	v1.16b, { v6.16b }, v22.16b
tbl	v2.16b, { v7.16b }, v23.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v16.16b }, v22.16b
tbl	v2.16b, { v17.16b }, v23.16b
eor	v28.16b, v1.16b, v28.16b
eor	v28.16b, v28.16b, v2.16b
str	q20, [x10]
str	q24, [x11]
str	q28, [x5]
add	x4, x4, #0x10
add	x7, x7, #0x10
add	x8, x8, #0x10
add	x9, x9, #0x10
add	x10, x10, #0x10
add	x11, x11, #0x10
add	x5, x5, #0x10
cmp	x4, x6
b.ls	L_350
.lessthan16_init:
sub	x12, x4, x6
cmp	x12, #0x10
b.eq	.return_pass
.lessthan16:
mov	x4, x6
sub	x7, x7, x12
sub	x8, x8, x12
sub	x9, x9, x12
sub	x10, x10, x12
sub	x11, x11, x12
sub	x5, x5, x12
adrp	x0, const_tbl
add	x0, x0, :lo12:const_tbl
sub	x0, x0, x12
ldr	q3, [x0, #0x10]
ldr	q21, [x4]
ldr	q20, [x7]
ldr	q24, [x8]
ldr	q28, [x9]
ldr	q6, [x14]
ldr	q7, [x14, #0x10]
ldr	q16, [x15]
ldr	q17, [x15, #0x10]
and	v22.16b, v21.16b, v0.16b
ushr	v23.16b, v21.16b, #0x4
tbl	v1.16b, { v4.16b }, v22.16b
tbl	v2.16b, { v5.16b }, v23.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v20.16b, v20.16b, v2.16b
tbl	v1.16b, { v6.16b }, v22.16b
tbl	v2.16b, { v7.16b }, v23.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v16.16b }, v22.16b
tbl	v2.16b, { v17.16b }, v23.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v28.16b, v28.16b, v2.16b
str	q20, [x7]
str	q24, [x8]
str	q28, [x9]
ldr	q20, [x10]
ldr	q24, [x11]
ldr	q28, [x5]
ldr	q6, [x17]
ldr	q7, [x17, #0x10]
ldr	q16, [x3]
ldr	q17, [x3, #0x10]
tbl	v1.16b, { v18.16b }, v22.16b
tbl	v2.16b, { v19.16b }, v23.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v20.16b, v20.16b, v2.16b
tbl	v1.16b, { v6.16b }, v22.16b
tbl	v2.16b, { v7.16b }, v23.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v16.16b }, v22.16b
tbl	v2.16b, { v17.16b }, v23.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v28.16b, v28.16b, v2.16b
str	q20, [x10]
str	q24, [x11]
str	q28, [x5]
.return_pass:
mov	w0, #0x0
ret
.return_fail:
mov	w0, #0x1
ret
	.section .rodata
	.p2align 3
const_tbl:
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255

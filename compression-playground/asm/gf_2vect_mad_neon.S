	.text
gf_2vect_mad_neon:
cmp	x0, #0x10
b.lt	.return_fail
movi	v0.16b, #0xf
lsl	x2, x2, #5
lsl	x1, x1, #5
add	x10, x3, x2
add	x11, x10, x1
add	x6, x4, x0
ldr	x7, [x5]
ldr	x8, [x5, #0x8]
ldr	q4, [x10]
ldr	q5, [x10, #0x10]
ldr	q6, [x11]
ldr	q7, [x11, #0x10]
cmp	x0, #0x80
b.lt	L_264
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x6, x6, #0x80
L_58:
ldr	q8, [x4]
ldr	q9, [x4, #0x10]
ldr	q10, [x4, #0x20]
ldr	q11, [x4, #0x30]
ldr	q12, [x4, #0x40]
ldr	q13, [x4, #0x50]
ldr	q14, [x4, #0x60]
ldr	q15, [x4, #0x70]
ldr	q24, [x7]
ldr	q25, [x7, #0x10]
ldr	q26, [x7, #0x20]
ldr	q27, [x7, #0x30]
ldr	q28, [x7, #0x40]
ldr	q29, [x7, #0x50]
ldr	q30, [x7, #0x60]
ldr	q31, [x7, #0x70]
and	v16.16b, v8.16b, v0.16b
and	v17.16b, v9.16b, v0.16b
and	v18.16b, v10.16b, v0.16b
and	v19.16b, v11.16b, v0.16b
and	v20.16b, v12.16b, v0.16b
and	v21.16b, v13.16b, v0.16b
and	v22.16b, v14.16b, v0.16b
and	v23.16b, v15.16b, v0.16b
ushr	v8.16b, v8.16b, #0x4
ushr	v9.16b, v9.16b, #0x4
ushr	v10.16b, v10.16b, #0x4
ushr	v11.16b, v11.16b, #0x4
ushr	v12.16b, v12.16b, #0x4
ushr	v13.16b, v13.16b, #0x4
ushr	v14.16b, v14.16b, #0x4
ushr	v15.16b, v15.16b, #0x4
tbl	v1.16b, { v4.16b }, v16.16b
tbl	v2.16b, { v5.16b }, v8.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v4.16b }, v17.16b
tbl	v2.16b, { v5.16b }, v9.16b
eor	v25.16b, v1.16b, v25.16b
eor	v25.16b, v25.16b, v2.16b
tbl	v1.16b, { v4.16b }, v18.16b
tbl	v2.16b, { v5.16b }, v10.16b
eor	v26.16b, v1.16b, v26.16b
eor	v26.16b, v26.16b, v2.16b
tbl	v1.16b, { v4.16b }, v19.16b
tbl	v2.16b, { v5.16b }, v11.16b
eor	v27.16b, v1.16b, v27.16b
eor	v27.16b, v27.16b, v2.16b
tbl	v1.16b, { v4.16b }, v20.16b
tbl	v2.16b, { v5.16b }, v12.16b
eor	v28.16b, v1.16b, v28.16b
eor	v28.16b, v28.16b, v2.16b
tbl	v1.16b, { v4.16b }, v21.16b
tbl	v2.16b, { v5.16b }, v13.16b
eor	v29.16b, v1.16b, v29.16b
eor	v29.16b, v29.16b, v2.16b
tbl	v1.16b, { v4.16b }, v22.16b
tbl	v2.16b, { v5.16b }, v14.16b
eor	v30.16b, v1.16b, v30.16b
eor	v30.16b, v30.16b, v2.16b
tbl	v1.16b, { v4.16b }, v23.16b
tbl	v2.16b, { v5.16b }, v15.16b
eor	v31.16b, v1.16b, v31.16b
eor	v31.16b, v31.16b, v2.16b
str	q24, [x7]
str	q25, [x7, #0x10]
str	q26, [x7, #0x20]
str	q27, [x7, #0x30]
str	q28, [x7, #0x40]
str	q29, [x7, #0x50]
str	q30, [x7, #0x60]
str	q31, [x7, #0x70]
ldr	q24, [x8]
ldr	q25, [x8, #0x10]
ldr	q26, [x8, #0x20]
ldr	q27, [x8, #0x30]
ldr	q28, [x8, #0x40]
ldr	q29, [x8, #0x50]
ldr	q30, [x8, #0x60]
ldr	q31, [x8, #0x70]
tbl	v1.16b, { v6.16b }, v16.16b
tbl	v2.16b, { v7.16b }, v8.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v6.16b }, v17.16b
tbl	v2.16b, { v7.16b }, v9.16b
eor	v25.16b, v1.16b, v25.16b
eor	v25.16b, v25.16b, v2.16b
tbl	v1.16b, { v6.16b }, v18.16b
tbl	v2.16b, { v7.16b }, v10.16b
eor	v26.16b, v1.16b, v26.16b
eor	v26.16b, v26.16b, v2.16b
tbl	v1.16b, { v6.16b }, v19.16b
tbl	v2.16b, { v7.16b }, v11.16b
eor	v27.16b, v1.16b, v27.16b
eor	v27.16b, v27.16b, v2.16b
tbl	v1.16b, { v6.16b }, v20.16b
tbl	v2.16b, { v7.16b }, v12.16b
eor	v28.16b, v1.16b, v28.16b
eor	v28.16b, v28.16b, v2.16b
tbl	v1.16b, { v6.16b }, v21.16b
tbl	v2.16b, { v7.16b }, v13.16b
eor	v29.16b, v1.16b, v29.16b
eor	v29.16b, v29.16b, v2.16b
tbl	v1.16b, { v6.16b }, v22.16b
tbl	v2.16b, { v7.16b }, v14.16b
eor	v30.16b, v1.16b, v30.16b
eor	v30.16b, v30.16b, v2.16b
tbl	v1.16b, { v6.16b }, v23.16b
tbl	v2.16b, { v7.16b }, v15.16b
eor	v31.16b, v1.16b, v31.16b
eor	v31.16b, v31.16b, v2.16b
str	q24, [x8]
str	q25, [x8, #0x10]
str	q26, [x8, #0x20]
str	q27, [x8, #0x30]
str	q28, [x8, #0x40]
str	q29, [x8, #0x50]
str	q30, [x8, #0x60]
str	q31, [x8, #0x70]
add	x4, x4, #0x80
add	x7, x7, #0x80
add	x8, x8, #0x80
cmp	x4, x6
b.ls	L_58
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
add	x6, x6, #0x80
L_264:
sub	x6, x6, #0x10
cmp	x4, x6
b.hi	.lessthan16_init
L_270:
ldr	q16, [x4]
ldr	q24, [x7]
ldr	q25, [x8]
and	v17.16b, v16.16b, v0.16b
ushr	v18.16b, v16.16b, #0x4
tbl	v1.16b, { v4.16b }, v17.16b
tbl	v2.16b, { v5.16b }, v18.16b
eor	v24.16b, v1.16b, v24.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v6.16b }, v17.16b
tbl	v2.16b, { v7.16b }, v18.16b
eor	v25.16b, v1.16b, v25.16b
eor	v25.16b, v25.16b, v2.16b
str	q24, [x7]
str	q25, [x8]
add	x7, x7, #0x10
add	x8, x8, #0x10
add	x4, x4, #0x10
cmp	x4, x6
b.ls	L_270
.lessthan16_init:
sub	x9, x4, x6
cmp	x9, #0x10
b.eq	.return_pass
.lessthan16:
mov	x4, x6
sub	x7, x7, x9
sub	x8, x8, x9
adrp	x12, const_tbl
add	x12, x12, :lo12:const_tbl
sub	x12, x12, x9
ldr	q3, [x12, #0x10]
ldr	q16, [x4]
ldr	q24, [x7]
ldr	q25, [x8]
and	v17.16b, v16.16b, v0.16b
ushr	v18.16b, v16.16b, #0x4
tbl	v1.16b, { v4.16b }, v17.16b
tbl	v2.16b, { v5.16b }, v18.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v24.16b, v24.16b, v2.16b
tbl	v1.16b, { v6.16b }, v17.16b
tbl	v2.16b, { v7.16b }, v18.16b
eor	v2.16b, v1.16b, v2.16b
and	v2.16b, v2.16b, v3.16b
eor	v25.16b, v25.16b, v2.16b
str	q24, [x7]
str	q25, [x8]
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

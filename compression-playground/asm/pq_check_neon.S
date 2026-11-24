	.text
pq_check_neon:
sub	x9, x2, #0x8
sub	w0, w0, #0x3
add	x2, x2, x0, lsl #3
ldr	x10, [x2]
ldp	x3, x4, [x2, #0x8]
add	x5, x4, x1
mov	w12, #-0x1
mov	w6, #0x0
movi	v28.16b, #0x1d
movi	v29.16b, #0x80
cmp	w1, #0x80
b.lo	L_27c
sub	sp, sp, #0x40
stp	d8, d9, [sp]
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
sub	x5, x5, #0x80
L_48:
ldr	q0, [x10]
ldr	q1, [x10, #0x10]
ldr	q2, [x10, #0x20]
ldr	q3, [x10, #0x30]
ldr	q4, [x10, #0x40]
ldr	q5, [x10, #0x50]
ldr	q6, [x10, #0x60]
ldr	q7, [x10, #0x70]
add	x10, x10, #0x80
mov	v8.16b, v0.16b
mov	v9.16b, v1.16b
mov	v10.16b, v2.16b
mov	v11.16b, v3.16b
mov	v12.16b, v4.16b
mov	v13.16b, v5.16b
mov	v14.16b, v6.16b
mov	v15.16b, v7.16b
cbz	w0, L_184
sub	x7, x2, #0x8
L_94:
ldr	x11, [x7], #-0x8
add	x11, x11, x6
cmp	x7, x9
ldr	q16, [x11]
ldr	q17, [x11, #0x10]
ldr	q18, [x11, #0x20]
ldr	q19, [x11, #0x30]
ldr	q20, [x11, #0x40]
ldr	q21, [x11, #0x50]
ldr	q22, [x11, #0x60]
ldr	q23, [x11, #0x70]
eor	v0.16b, v0.16b, v16.16b
eor	v1.16b, v1.16b, v17.16b
eor	v2.16b, v2.16b, v18.16b
eor	v3.16b, v3.16b, v19.16b
eor	v4.16b, v4.16b, v20.16b
eor	v5.16b, v5.16b, v21.16b
eor	v6.16b, v6.16b, v22.16b
eor	v7.16b, v7.16b, v23.16b
cmhs	v24.16b, v8.16b, v29.16b
cmhs	v25.16b, v9.16b, v29.16b
cmhs	v26.16b, v10.16b, v29.16b
cmhs	v27.16b, v11.16b, v29.16b
and	v24.16b, v24.16b, v28.16b
and	v25.16b, v25.16b, v28.16b
and	v26.16b, v26.16b, v28.16b
and	v27.16b, v27.16b, v28.16b
shl	v8.16b, v8.16b, #0x1
shl	v9.16b, v9.16b, #0x1
shl	v10.16b, v10.16b, #0x1
shl	v11.16b, v11.16b, #0x1
eor	v8.16b, v8.16b, v24.16b
eor	v9.16b, v9.16b, v25.16b
eor	v10.16b, v10.16b, v26.16b
eor	v11.16b, v11.16b, v27.16b
eor	v8.16b, v8.16b, v16.16b
eor	v9.16b, v9.16b, v17.16b
eor	v10.16b, v10.16b, v18.16b
eor	v11.16b, v11.16b, v19.16b
cmhs	v24.16b, v12.16b, v29.16b
cmhs	v25.16b, v13.16b, v29.16b
cmhs	v26.16b, v14.16b, v29.16b
cmhs	v27.16b, v15.16b, v29.16b
and	v24.16b, v24.16b, v28.16b
and	v25.16b, v25.16b, v28.16b
and	v26.16b, v26.16b, v28.16b
and	v27.16b, v27.16b, v28.16b
shl	v12.16b, v12.16b, #0x1
shl	v13.16b, v13.16b, #0x1
shl	v14.16b, v14.16b, #0x1
shl	v15.16b, v15.16b, #0x1
eor	v12.16b, v12.16b, v24.16b
eor	v13.16b, v13.16b, v25.16b
eor	v14.16b, v14.16b, v26.16b
eor	v15.16b, v15.16b, v27.16b
eor	v12.16b, v12.16b, v20.16b
eor	v13.16b, v13.16b, v21.16b
eor	v14.16b, v14.16b, v22.16b
eor	v15.16b, v15.16b, v23.16b
b.ne	L_94
L_184:
ldr	q16, [x3]
ldr	q17, [x3, #0x10]
ldr	q18, [x3, #0x20]
ldr	q19, [x3, #0x30]
ldr	q20, [x3, #0x40]
ldr	q21, [x3, #0x50]
ldr	q22, [x3, #0x60]
ldr	q23, [x3, #0x70]
cmeq	v0.16b, v0.16b, v16.16b
cmeq	v1.16b, v1.16b, v17.16b
cmeq	v2.16b, v2.16b, v18.16b
cmeq	v3.16b, v3.16b, v19.16b
cmeq	v4.16b, v4.16b, v20.16b
cmeq	v5.16b, v5.16b, v21.16b
cmeq	v6.16b, v6.16b, v22.16b
cmeq	v7.16b, v7.16b, v23.16b
ldr	q16, [x4]
ldr	q17, [x4, #0x10]
ldr	q18, [x4, #0x20]
ldr	q19, [x4, #0x30]
ldr	q20, [x4, #0x40]
ldr	q21, [x4, #0x50]
ldr	q22, [x4, #0x60]
ldr	q23, [x4, #0x70]
and	v0.16b, v0.16b, v1.16b
and	v2.16b, v2.16b, v3.16b
and	v4.16b, v4.16b, v5.16b
and	v6.16b, v6.16b, v7.16b
and	v0.16b, v0.16b, v2.16b
and	v4.16b, v4.16b, v6.16b
and	v0.16b, v0.16b, v4.16b
cmeq	v8.16b, v8.16b, v16.16b
cmeq	v9.16b, v9.16b, v17.16b
cmeq	v10.16b, v10.16b, v18.16b
cmeq	v11.16b, v11.16b, v19.16b
cmeq	v12.16b, v12.16b, v20.16b
cmeq	v13.16b, v13.16b, v21.16b
cmeq	v14.16b, v14.16b, v22.16b
cmeq	v15.16b, v15.16b, v23.16b
and	v8.16b, v8.16b, v9.16b
and	v10.16b, v10.16b, v11.16b
and	v12.16b, v12.16b, v13.16b
and	v14.16b, v14.16b, v15.16b
and	v8.16b, v8.16b, v10.16b
and	v12.16b, v12.16b, v14.16b
and	v8.16b, v8.16b, v12.16b
and	v0.16b, v0.16b, v8.16b
uminv	b0, v0.16b
umov	w12, v0.b[0]
cbz	w12, L_260
add	x3, x3, #0x80
add	x4, x4, #0x80
cmp	x4, x5
add	w6, w6, #0x80
b.ls	L_48
L_260:
ldp	d8, d9, [sp]
ldp	d10, d11, [sp, #0x10]
ldp	d12, d13, [sp, #0x20]
ldp	d14, d15, [sp, #0x30]
add	sp, sp, #0x40
cbz	w12, L_2f4
add	x5, x5, #0x80
L_27c:
tst	w1, #0x7f
b.eq	L_2ec
sub	x5, x5, #0x10
L_288:
ldr	q0, [x10], #0x10
mov	v1.16b, v0.16b
cbz	w0, L_2c0
sub	x7, x2, #0x8
L_298:
ldr	x11, [x7], #-0x8
ldr	q2, [x11, x6]
cmp	x7, x9
eor	v0.16b, v0.16b, v2.16b
cmhs	v3.16b, v1.16b, v29.16b
and	v3.16b, v3.16b, v28.16b
shl	v1.16b, v1.16b, #0x1
eor	v1.16b, v1.16b, v2.16b
eor	v1.16b, v1.16b, v3.16b
b.ne	L_298
L_2c0:
ldr	q4, [x3], #0x10
ldr	q5, [x4], #0x10
cmp	x4, x5
cmeq	v0.16b, v0.16b, v4.16b
cmeq	v1.16b, v1.16b, v5.16b
and	v0.16b, v0.16b, v1.16b
uminv	b0, v0.16b
umov	w12, v0.b[0]
cbz	w12, L_2f4
add	w6, w6, #0x10
b.ls	L_288
L_2ec:
mov	w0, #0x0
ret
L_2f4:
mov	w0, #0x1
ret

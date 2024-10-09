_sgr_box3_vert_neon:
stp	d8, d9, [sp, #-48]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
add	w4, w4, #2
clz	w9, w6
dup.4s	v28, w5
ldp	x5, x6, [x0]
ldr	x0, [x0, #16]
ldp	x7, x8, [x1]
ldr	x1, [x1, #16]
movi.4s	v31, #9
sub	w9, w9, #24
adrp	x12, sgr_box3_vert_neon
add	x12, x12, #0
mov	w13, #455
ld1.16b	{ v16, v17, v18 }, [x12]
dup.8h	v6, w9
movi.16b	v19, #5
movi.8b	v20, #55
movi.8b	v21, #72
movi.8b	v22, #101
movi.8b	v23, #169
movi.8b	v24, #254
saddl.4s	v7, v6, v6
movi.8h	v29, #1, lsl #8
dup.4s	v30, w13
sub.16b	v16, v16, v19
sub.16b	v17, v17, v19
sub.16b	v18, v18, v19
ld1.4s	{ v8, v9 }, [x5], #32
ld1.4s	{ v10, v11 }, [x6], #32
ld1.8h	{ v12 }, [x7], #16
ld1.8h	{ v13 }, [x8], #16
ld1.4s	{ v0, v1 }, [x0], #32
ld1.8h	{ v2 }, [x1], #16
add.4s	v8, v8, v10
add.4s	v9, v9, v11
add.8h	v12, v12, v13
subs	w4, w4, #8
add.4s	v0, v0, v8
add.4s	v1, v1, v9
add.8h	v2, v2, v12
srshl.4s	v0, v0, v7
srshl.4s	v1, v1, v7
srshl.8h	v4, v2, v6
mul.4s	v0, v0, v31
mul.4s	v1, v1, v31
umull.4s	v3, v4, v4
umull2.4s	v4, v4, v4
uqsub.4s	v0, v0, v3
uqsub.4s	v1, v1, v4
mul.4s	v0, v0, v28
mul.4s	v1, v1, v28
ld1.4s	{ v8, v9 }, [x5], #32
uqshrn.4h	v0, v0, #16
uqshrn2.8h	v0, v1, #16
ld1.4s	{ v10, v11 }, [x6], #32
uqrshrn.8b	v0, v0, #4
ld1.8h	{ v12 }, [x7], #16
cmhi.8b	v25, v0, v20
cmhi.8b	v26, v0, v21
tbl.8b	v1, { v16, v17, v18 }, v0
cmhi.8b	v27, v0, v22
cmhi.8b	v4, v0, v23
add.8b	v25, v25, v26
cmhi.8b	v5, v0, v24
add.8b	v27, v27, v4
add.8b	v5, v5, v19
add.8b	v25, v25, v27
add.8b	v5, v1, v5
ld1.8h	{ v13 }, [x8], #16
add.8b	v5, v5, v25
ld1.4s	{ v0, v1 }, [x0], #32
ushll.8h	v5, v5, #0
umull.4s	v3, v5, v2
umull2.4s	v4, v5, v2
mul.4s	v3, v3, v30
mul.4s	v4, v4, v30
srshr.4s	v3, v3, #12
srshr.4s	v4, v4, #12
sub.8h	v5, v29, v5
ld1.8h	{ v2 }, [x1], #16
st1.4s	{ v3, v4 }, [x2], #32
st1.8h	{ v5 }, [x3], #16
b.gt	sgr_box3_vert_neon
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #48
ret
_sgr_box5_vert_neon:
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
add	w4, w4, #2
clz	w15, w6
dup.4s	v28, w5
ldp	x5, x6, [x0]
ldp	x7, x8, [x0, #16]
ldr	x0, [x0, #32]
ldp	x9, x10, [x1]
ldp	x11, x12, [x1, #16]
ldr	x1, [x1, #32]
movi.4s	v31, #25
sub	w15, w15, #24
adrp	x13, sgr_box5_vert_neon
add	x13, x13, #0
mov	w14, #164
ld1.16b	{ v16, v17, v18 }, [x13]
dup.8h	v6, w15
movi.16b	v19, #5
movi.8b	v24, #254
saddl.4s	v7, v6, v6
movi.8h	v29, #1, lsl #8
dup.4s	v30, w14
sub.16b	v16, v16, v19
sub.16b	v17, v17, v19
sub.16b	v18, v18, v19
ld1.4s	{ v8, v9 }, [x5], #32
ld1.4s	{ v10, v11 }, [x6], #32
ld1.4s	{ v12, v13 }, [x7], #32
ld1.4s	{ v14, v15 }, [x8], #32
ld1.8h	{ v20 }, [x9], #16
ld1.8h	{ v21 }, [x10], #16
ld1.8h	{ v22 }, [x11], #16
ld1.8h	{ v23 }, [x12], #16
ld1.4s	{ v0, v1 }, [x0], #32
ld1.8h	{ v2 }, [x1], #16
add.4s	v8, v8, v10
add.4s	v9, v9, v11
add.4s	v12, v12, v14
add.4s	v13, v13, v15
add.8h	v20, v20, v21
add.8h	v22, v22, v23
add.4s	v0, v0, v8
add.4s	v1, v1, v9
add.8h	v2, v2, v20
add.4s	v0, v0, v12
add.4s	v1, v1, v13
add.8h	v2, v2, v22
subs	w4, w4, #8
movi.8b	v20, #55
movi.8b	v21, #72
movi.8b	v22, #101
movi.8b	v23, #169
srshl.4s	v0, v0, v7
srshl.4s	v1, v1, v7
srshl.8h	v4, v2, v6
mul.4s	v0, v0, v31
mul.4s	v1, v1, v31
umull.4s	v3, v4, v4
umull2.4s	v4, v4, v4
uqsub.4s	v0, v0, v3
uqsub.4s	v1, v1, v4
mul.4s	v0, v0, v28
mul.4s	v1, v1, v28
ld1.4s	{ v8, v9 }, [x5], #32
uqshrn.4h	v0, v0, #16
uqshrn2.8h	v0, v1, #16
ld1.4s	{ v10, v11 }, [x6], #32
uqrshrn.8b	v0, v0, #4
ld1.4s	{ v12, v13 }, [x7], #32
cmhi.8b	v25, v0, v20
cmhi.8b	v26, v0, v21
tbl.8b	v1, { v16, v17, v18 }, v0
cmhi.8b	v27, v0, v22
cmhi.8b	v4, v0, v23
ld1.4s	{ v14, v15 }, [x8], #32
add.8b	v25, v25, v26
cmhi.8b	v5, v0, v24
add.8b	v27, v27, v4
ld1.8h	{ v20 }, [x9], #16
add.8b	v5, v5, v19
add.8b	v25, v25, v27
ld1.8h	{ v21 }, [x10], #16
add.8b	v5, v1, v5
ld1.8h	{ v22 }, [x11], #16
add.8b	v5, v5, v25
ld1.8h	{ v23 }, [x12], #16
ushll.8h	v5, v5, #0
ld1.4s	{ v0, v1 }, [x0], #32
umull.4s	v3, v5, v2
umull2.4s	v4, v5, v2
mul.4s	v3, v3, v30
mul.4s	v4, v4, v30
srshr.4s	v3, v3, #12
srshr.4s	v4, v4, #12
sub.8h	v5, v29, v5
ld1.8h	{ v2 }, [x1], #16
st1.4s	{ v3, v4 }, [x2], #32
st1.8h	{ v5 }, [x3], #16
b.gt	sgr_box5_vert_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret
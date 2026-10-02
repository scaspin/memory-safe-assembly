	.text
sgr_box3_vert_neon:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
add	w4, w4, #0x2
clz	w9, w6
dup	v28.4s, w5
ldp	x5, x6, [x0]
ldr	x0, [x0, #0x10]
ldp	x7, x8, [x1]
ldr	x1, [x1, #0x10]
movi	v31.4s, #0x9
sub	w9, w9, #0x18
adrp	x12, x_by_x_tables
add	x12, x12, :lo12:x_by_x_tables
mov	w13, #0x1c7
ld1	{ v24.16b, v25.16b, v26.16b, v27.16b }, [x12]
movi	v22.16b, #0x7
ldr	q23, [x12, #0x40]
dup	v6.8h, w9
saddl	v7.4s, v6.4h, v6.4h
dup	v30.4s, w13
ld1	{ v8.4s, v9.4s, v10.4s, v11.4s }, [x5], #64
ld1	{ v12.4s, v13.4s, v14.4s, v15.4s }, [x6], #64
ld1	{ v16.4s, v17.4s, v18.4s, v19.4s }, [x0], #64
ld1	{ v20.8h, v21.8h }, [x8], #32
ld1	{ v0.8h, v1.8h }, [x7], #32
L_6c:
ld1	{ v2.8h, v3.8h }, [x1], #32
add	v8.4s, v8.4s, v12.4s
add	v9.4s, v9.4s, v13.4s
add	v10.4s, v10.4s, v14.4s
add	v11.4s, v11.4s, v15.4s
add	v0.8h, v0.8h, v20.8h
add	v1.8h, v1.8h, v21.8h
add	v16.4s, v16.4s, v8.4s
add	v17.4s, v17.4s, v9.4s
add	v18.4s, v18.4s, v10.4s
add	v19.4s, v19.4s, v11.4s
add	v4.8h, v2.8h, v0.8h
add	v5.8h, v3.8h, v1.8h
srshl	v16.4s, v16.4s, v7.4s
srshl	v17.4s, v17.4s, v7.4s
srshl	v18.4s, v18.4s, v7.4s
srshl	v19.4s, v19.4s, v7.4s
srshl	v9.8h, v4.8h, v6.8h
srshl	v13.8h, v5.8h, v6.8h
mul	v16.4s, v16.4s, v31.4s
mul	v17.4s, v17.4s, v31.4s
mul	v18.4s, v18.4s, v31.4s
mul	v19.4s, v19.4s, v31.4s
umull	v8.4s, v9.4h, v9.4h
umull2	v9.4s, v9.8h, v9.8h
umull	v12.4s, v13.4h, v13.4h
umull2	v13.4s, v13.8h, v13.8h
uqsub	v16.4s, v16.4s, v8.4s
uqsub	v17.4s, v17.4s, v9.4s
uqsub	v18.4s, v18.4s, v12.4s
uqsub	v19.4s, v19.4s, v13.4s
mul	v16.4s, v16.4s, v28.4s
mul	v17.4s, v17.4s, v28.4s
mul	v18.4s, v18.4s, v28.4s
mul	v19.4s, v19.4s, v28.4s
uqshrn	v16.4h, v16.4s, #0x10
uqshrn2	v16.8h, v17.4s, #0x10
uqshrn	v18.4h, v18.4s, #0x10
uqshrn2	v18.8h, v19.4s, #0x10
uqrshrn	v1.8b, v16.8h, #0x4
uqrshrn2	v1.16b, v18.8h, #0x4
ld1	{ v16.4s, v17.4s }, [x0], #32
subs	w4, w4, #0x10
ushr	v0.16b, v1.16b, #0x3
ld1	{ v8.4s, v9.4s }, [x5], #32
tbl	v2.16b, { v26.16b, v27.16b }, v0.16b
tbl	v0.16b, { v24.16b, v25.16b }, v0.16b
tbl	v3.16b, { v23.16b }, v1.16b
and	v1.16b, v1.16b, v22.16b
ld1	{ v12.4s, v13.4s }, [x6], #32
ushl	v1.16b, v2.16b, v1.16b
ld1	{ v20.8h, v21.8h }, [x8], #32
add	v3.16b, v3.16b, v0.16b
cnt	v1.16b, v1.16b
ld1	{ v18.4s, v19.4s }, [x0], #32
add	v3.16b, v3.16b, v1.16b
ld1	{ v10.4s, v11.4s }, [x5], #32
ushll	v0.8h, v3.8b, #0x0
ushll2	v1.8h, v3.16b, #0x0
ld1	{ v14.4s, v15.4s }, [x6], #32
umull	v2.4s, v0.4h, v4.4h
umull2	v3.4s, v0.8h, v4.8h
umull	v4.4s, v1.4h, v5.4h
umull2	v5.4s, v1.8h, v5.8h
mul	v2.4s, v2.4s, v30.4s
mul	v3.4s, v3.4s, v30.4s
mul	v4.4s, v4.4s, v30.4s
mul	v5.4s, v5.4s, v30.4s
st1	{ v0.8h, v1.8h }, [x3], #32
ld1	{ v0.8h, v1.8h }, [x7], #32
srshr	v2.4s, v2.4s, #0xc
srshr	v3.4s, v3.4s, #0xc
srshr	v4.4s, v4.4s, #0xc
srshr	v5.4s, v5.4s, #0xc
st1	{ v2.4s, v3.4s, v4.4s, v5.4s }, [x2], #64
b.gt	L_6c
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
sgr_box5_vert_neon:
stp	d8, d9, [sp, #-0x30]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
add	w4, w4, #0x2
clz	w15, w6
dup	v28.4s, w5
ldp	x5, x6, [x0]
ldp	x7, x8, [x0, #0x10]
ldr	x0, [x0, #0x20]
ldp	x9, x10, [x1]
ldp	x11, x12, [x1, #0x10]
ldr	x1, [x1, #0x20]
movi	v31.4s, #0x19
sub	w15, w15, #0x18
adrp	x13, x_by_x_tables
add	x13, x13, :lo12:x_by_x_tables
movi	v30.4s, #0xa4
ld1	{ v24.16b, v25.16b, v26.16b, v27.16b }, [x13]
dup	v6.8h, w15
movi	v19.8b, #0x7
ldr	q18, [x13, #0x40]
saddl	v7.4s, v6.4h, v6.4h
ld1	{ v8.4s, v9.4s }, [x5], #32
ld1	{ v10.4s, v11.4s }, [x6], #32
ld1	{ v12.4s, v13.4s }, [x7], #32
ld1	{ v16.4s, v17.4s }, [x8], #32
ld1	{ v20.8h }, [x9], #16
ld1	{ v21.8h }, [x10], #16
ld1	{ v22.8h }, [x11], #16
ld1	{ v23.8h }, [x12], #16
ld1	{ v0.4s, v1.4s }, [x0], #32
ld1	{ v2.8h }, [x1], #16
L_230:
add	v8.4s, v8.4s, v10.4s
add	v9.4s, v9.4s, v11.4s
add	v12.4s, v12.4s, v16.4s
add	v13.4s, v13.4s, v17.4s
add	v20.8h, v20.8h, v21.8h
add	v22.8h, v22.8h, v23.8h
add	v0.4s, v0.4s, v8.4s
add	v1.4s, v1.4s, v9.4s
add	v2.8h, v2.8h, v20.8h
add	v0.4s, v0.4s, v12.4s
add	v1.4s, v1.4s, v13.4s
add	v2.8h, v2.8h, v22.8h
subs	w4, w4, #0x8
srshl	v0.4s, v0.4s, v7.4s
srshl	v1.4s, v1.4s, v7.4s
srshl	v4.8h, v2.8h, v6.8h
mul	v0.4s, v0.4s, v31.4s
mul	v1.4s, v1.4s, v31.4s
umull	v3.4s, v4.4h, v4.4h
umull2	v4.4s, v4.8h, v4.8h
uqsub	v0.4s, v0.4s, v3.4s
uqsub	v1.4s, v1.4s, v4.4s
mul	v0.4s, v0.4s, v28.4s
mul	v1.4s, v1.4s, v28.4s
ld1	{ v8.4s, v9.4s }, [x5], #32
uqshrn	v0.4h, v0.4s, #0x10
uqshrn2	v0.8h, v1.4s, #0x10
ld1	{ v10.4s, v11.4s }, [x6], #32
uqrshrn	v0.8b, v0.8h, #0x4
ld1	{ v12.4s, v13.4s }, [x7], #32
ushr	v1.8b, v0.8b, #0x3
ld1	{ v16.4s, v17.4s }, [x8], #32
tbl	v5.8b, { v26.16b, v27.16b }, v1.8b
tbl	v1.8b, { v24.16b, v25.16b }, v1.8b
tbl	v4.8b, { v18.16b }, v0.8b
and	v0.8b, v0.8b, v19.8b
ld1	{ v20.8h }, [x9], #16
ushl	v5.8b, v5.8b, v0.8b
add	v4.8b, v4.8b, v1.8b
ld1	{ v21.8h }, [x10], #16
cnt	v5.8b, v5.8b
ld1	{ v22.8h }, [x11], #16
add	v5.8b, v4.8b, v5.8b
ld1	{ v23.8h }, [x12], #16
ushll	v5.8h, v5.8b, #0x0
ld1	{ v0.4s, v1.4s }, [x0], #32
umull	v3.4s, v5.4h, v2.4h
umull2	v4.4s, v5.8h, v2.8h
mul	v3.4s, v3.4s, v30.4s
mul	v4.4s, v4.4s, v30.4s
srshr	v3.4s, v3.4s, #0xc
srshr	v4.4s, v4.4s, #0xc
ld1	{ v2.8h }, [x1], #16
st1	{ v3.4s, v4.4s }, [x2], #32
st1	{ v5.8h }, [x3], #16
b.gt	L_230
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x30
ret
	.section .rodata
x_by_x_tables:
	.size x_by_x_tables, 80
	.byte 0,0,11,8,6,5,5,4,4,3,3,3,2,2,2,2
	.byte 2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,0
	.byte 0,0,212,68,66,4,0,0,0,128,0,0,4,0,0,0
	.byte 0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,2
	.byte 255,128,85,64,51,43,37,32,28,26,23,21,20,18,17,16

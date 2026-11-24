	.text
wiener_filter7_16bpc_neon:
ldr	w8, [sp]
stp	x29, x30, [sp, #-0x20]!
stp	d8, d9, [sp, #0x10]
mov	x29, sp
ld1	{ v0.8h, v1.8h }, [x6]
tst	w7, #0x4
sub	sp, sp, #0x1, lsl #12
sub	sp, sp, #0x200
dup	v28.8h, w8
clz	w8, w8
movi	v30.4s, #0x1
sub	w10, w8, #0x26
sub	w11, w8, #0xb
sub	w8, w8, #0x19
neg	w10, w10
neg	w11, w11
dup	v2.4s, w10
dup	v29.4s, w8
dup	v27.4s, w11
movi	v31.8h, #0x20, lsl #8
ushl	v30.4s, v30.4s, v2.4s
zip1	v0.2d, v0.2d, v1.2d
mov	x14, sp
b.eq	L_11c
mov	x16, x2
mov	x2, #0x0
bl	wiener_filter7_h_16bpc_neon
add	x3, x3, x1
mov	x9, x14
mov	x10, x14
add	x14, x14, #0x300
bl	wiener_filter7_h_16bpc_neon
add	x3, x3, x1, lsl #2
add	x3, x3, x1
mov	x11, x14
add	x14, x14, #0x300
mov	x2, x16
mov	x16, x3
mov	x3, x0
bl	wiener_filter7_h_16bpc_neon
subs	w5, w5, #0x1
mov	x12, x14
mov	x13, x14
b.eq	L_108
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_16bpc_neon
mov	x13, x14
subs	w5, w5, #0x1
b.eq	L_19c
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_16bpc_neon
subs	w5, w5, #0x1
b.eq	L_198
add	x3, x3, x1
L_e0:
add	x15, x14, #0x300
L_e4:
bl	wiener_filter7_hv_16bpc_neon
subs	w5, w5, #0x1
b.ne	L_e4
tst	w7, #0x8
b.eq	L_198
mov	x3, x16
mov	x2, #0x0
bl	wiener_filter7_hv_16bpc_neon
bl	wiener_filter7_hv_16bpc_neon
L_108:
bl	wiener_filter7_v_16bpc_neon
mov	sp, x29
ldp	d8, d9, [sp, #0x10]
ldp	x29, x30, [sp], #0x20
ret
L_11c:
add	x3, x3, x1, lsl #2
add	x16, x3, x1, lsl #1
mov	x3, x0
bl	wiener_filter7_h_16bpc_neon
subs	w5, w5, #0x1
mov	x9, x14
mov	x10, x14
mov	x11, x14
mov	x12, x14
mov	x13, x14
b.eq	L_108
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_16bpc_neon
subs	w5, w5, #0x1
mov	x13, x14
b.eq	L_19c
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_16bpc_neon
subs	w5, w5, #0x1
b.eq	L_198
add	x3, x3, x1
add	x15, x14, #0x300
bl	wiener_filter7_hv_16bpc_neon
subs	w5, w5, #0x1
b.eq	L_198
add	x15, x15, #0xc00
bl	wiener_filter7_hv_16bpc_neon
subs	w5, w5, #0x1
b.ne	L_e0
L_198:
bl	wiener_filter7_v_16bpc_neon
L_19c:
bl	wiener_filter7_v_16bpc_neon
b	L_108
wiener_filter7_h_16bpc_neon:
stp	x3, x4, [sp, #-0x20]!
str	x14, [sp, #0x10]
tst	w7, #0x1
b.eq	L_1dc
cbnz	x2, L_1c4
sub	x3, x3, #0x6
ld1	{ v2.8h, v3.8h }, [x3], #32
b	L_1f0
L_1c4:
ld1	{ v2.8h, v3.8h }, [x3], #32
ld1	{ v4.d }[1], [x2], #8
sub	x3, x3, #0x6
ext	v3.16b, v2.16b, v3.16b, #0xa
ext	v2.16b, v4.16b, v2.16b, #0xa
b	L_1f0
L_1dc:
ld1	{ v2.8h, v3.8h }, [x3], #32
dup	v4.8h, v2.h[0]
sub	x3, x3, #0x6
ext	v3.16b, v2.16b, v3.16b, #0xa
ext	v2.16b, v4.16b, v2.16b, #0xa
L_1f0:
ld1	{ v4.8h }, [x3], #16
tst	w7, #0x2
b.ne	L_22c
L_1fc:
cmp	w4, #0x13
b.ge	L_22c
sub	w17, w4, #0x16
adrp	x6, right_ext_mask_buf+42
add	x6, x6, :lo12:right_ext_mask_buf+42
ldr	h26, [x3, w17, sxtw #1]
sub	x6, x6, w4, uxtw #1
dup	v26.8h, v26.h[0]
ld1	{ v23.16b, v24.16b, v25.16b }, [x6]
bit	v2.16b, v26.16b, v23.16b
bit	v3.16b, v26.16b, v24.16b
bit	v4.16b, v26.16b, v25.16b
L_22c:
ext	v17.16b, v2.16b, v3.16b, #0x4
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v20.16b, v2.16b, v3.16b, #0xa
ext	v21.16b, v2.16b, v3.16b, #0xc
ext	v18.16b, v2.16b, v3.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v2.8h
smull	v6.4s, v18.4h, v0.h[3]
smlal	v6.4s, v19.4h, v0.h[2]
smlal	v6.4s, v20.4h, v0.h[1]
smlal	v6.4s, v21.4h, v0.h[0]
smull2	v7.4s, v18.8h, v0.h[3]
smlal2	v7.4s, v19.8h, v0.h[2]
smlal2	v7.4s, v20.8h, v0.h[1]
smlal2	v7.4s, v21.8h, v0.h[0]
ext	v17.16b, v3.16b, v4.16b, #0x4
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v20.16b, v3.16b, v4.16b, #0xa
ext	v21.16b, v3.16b, v4.16b, #0xc
ext	v18.16b, v3.16b, v4.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v3.8h
smull	v16.4s, v18.4h, v0.h[3]
smlal	v16.4s, v19.4h, v0.h[2]
smlal	v16.4s, v20.4h, v0.h[1]
smlal	v16.4s, v21.4h, v0.h[0]
smull2	v17.4s, v18.8h, v0.h[3]
smlal2	v17.4s, v19.8h, v0.h[2]
smlal2	v17.4s, v20.8h, v0.h[1]
smlal2	v17.4s, v21.8h, v0.h[0]
mvni	v24.8h, #0x80, lsl #8
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
add	v16.4s, v16.4s, v30.4s
add	v17.4s, v17.4s, v30.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
srshl	v16.4s, v16.4s, v29.4s
srshl	v17.4s, v17.4s, v29.4s
sqxtun	v6.4h, v6.4s
sqxtun2	v6.8h, v7.4s
sqxtun	v7.4h, v16.4s
sqxtun2	v7.8h, v17.4s
umin	v6.8h, v6.8h, v24.8h
umin	v7.8h, v7.8h, v24.8h
sub	v6.8h, v6.8h, v31.8h
sub	v7.8h, v7.8h, v31.8h
subs	w4, w4, #0x10
st1	{ v6.8h, v7.8h }, [x14], #32
b.le	L_318
mov	v2.16b, v4.16b
tst	w7, #0x2
ld1	{ v3.8h, v4.8h }, [x3], #32
b.ne	L_22c
b	L_1fc
L_318:
ldr	x14, [sp, #0x10]
ldp	x3, x4, [sp], #0x20
ret
wiener_filter7_v_16bpc_neon:
stp	x10, x11, [sp, #-0x40]!
stp	x12, x13, [sp, #0x10]
stp	x14, x14, [sp, #0x20]
stp	x0, x4, [sp, #0x30]
L_334:
ld1	{ v16.8h, v17.8h }, [x9], #32
ld1	{ v18.8h, v19.8h }, [x10], #32
ld1	{ v20.8h, v21.8h }, [x11], #32
ld1	{ v22.8h, v23.8h }, [x12], #32
ld1	{ v24.8h, v25.8h }, [x13], #32
ld1	{ v6.8h, v7.8h }, [x14], #32
smull	v2.4s, v16.4h, v0.h[4]
smlal	v2.4s, v18.4h, v0.h[5]
smlal	v2.4s, v20.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
smlal	v2.4s, v24.4h, v0.h[6]
smlal	v2.4s, v6.4h, v0.h[5]
smlal	v2.4s, v6.4h, v0.h[4]
smull2	v3.4s, v16.8h, v0.h[4]
smlal2	v3.4s, v18.8h, v0.h[5]
smlal2	v3.4s, v20.8h, v0.h[6]
smlal2	v3.4s, v22.8h, v0.h[7]
smlal2	v3.4s, v24.8h, v0.h[6]
smlal2	v3.4s, v6.8h, v0.h[5]
smlal2	v3.4s, v6.8h, v0.h[4]
smull	v4.4s, v17.4h, v0.h[4]
smlal	v4.4s, v19.4h, v0.h[5]
smlal	v4.4s, v21.4h, v0.h[6]
smlal	v4.4s, v23.4h, v0.h[7]
smlal	v4.4s, v25.4h, v0.h[6]
smlal	v4.4s, v7.4h, v0.h[5]
smlal	v4.4s, v7.4h, v0.h[4]
smull2	v5.4s, v17.8h, v0.h[4]
smlal2	v5.4s, v19.8h, v0.h[5]
smlal2	v5.4s, v21.8h, v0.h[6]
smlal2	v5.4s, v23.8h, v0.h[7]
smlal2	v5.4s, v25.8h, v0.h[6]
smlal2	v5.4s, v7.8h, v0.h[5]
smlal2	v5.4s, v7.8h, v0.h[4]
srshl	v2.4s, v2.4s, v27.4s
srshl	v3.4s, v3.4s, v27.4s
srshl	v4.4s, v4.4s, v27.4s
srshl	v5.4s, v5.4s, v27.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
sqxtun	v3.4h, v4.4s
sqxtun2	v3.8h, v5.4s
umin	v2.8h, v2.8h, v28.8h
umin	v3.8h, v3.8h, v28.8h
subs	w4, w4, #0x10
st1	{ v2.8h, v3.8h }, [x0], #32
b.gt	L_334
ldp	x0, x4, [sp, #0x30]
ldp	x13, x14, [sp, #0x20]
ldp	x11, x12, [sp, #0x10]
ldp	x9, x10, [sp], #0x40
add	x0, x0, x1
ret
wiener_filter7_hv_16bpc_neon:
stp	x10, x11, [sp, #-0x50]!
stp	x12, x13, [sp, #0x10]
stp	x14, x15, [sp, #0x20]
stp	x10, x0, [sp, #0x30]
stp	x3, x4, [sp, #0x40]
tst	w7, #0x1
b.eq	L_44c
cbnz	x2, L_434
sub	x3, x3, #0x6
ld1	{ v2.8h, v3.8h }, [x3], #32
b	L_460
L_434:
ld1	{ v2.8h, v3.8h }, [x3], #32
ld1	{ v4.d }[1], [x2], #8
sub	x3, x3, #0x6
ext	v3.16b, v2.16b, v3.16b, #0xa
ext	v2.16b, v4.16b, v2.16b, #0xa
b	L_460
L_44c:
ld1	{ v2.8h, v3.8h }, [x3], #32
dup	v4.8h, v2.h[0]
sub	x3, x3, #0x6
ext	v3.16b, v2.16b, v3.16b, #0xa
ext	v2.16b, v4.16b, v2.16b, #0xa
L_460:
ld1	{ v4.8h }, [x3], #16
tst	w7, #0x2
b.ne	L_49c
L_46c:
cmp	w4, #0x13
b.ge	L_49c
sub	w17, w4, #0x16
adrp	x6, right_ext_mask_buf+42
add	x6, x6, :lo12:right_ext_mask_buf+42
ldr	h26, [x3, w17, sxtw #1]
sub	x6, x6, w4, uxtw #1
dup	v26.8h, v26.h[0]
ld1	{ v23.16b, v24.16b, v25.16b }, [x6]
bit	v2.16b, v26.16b, v23.16b
bit	v3.16b, v26.16b, v24.16b
bit	v4.16b, v26.16b, v25.16b
L_49c:
ext	v17.16b, v2.16b, v3.16b, #0x4
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v20.16b, v2.16b, v3.16b, #0xa
ext	v21.16b, v2.16b, v3.16b, #0xc
ext	v18.16b, v2.16b, v3.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v2.8h
smull	v6.4s, v18.4h, v0.h[3]
smlal	v6.4s, v19.4h, v0.h[2]
smlal	v6.4s, v20.4h, v0.h[1]
smlal	v6.4s, v21.4h, v0.h[0]
smull2	v7.4s, v18.8h, v0.h[3]
smlal2	v7.4s, v19.8h, v0.h[2]
smlal2	v7.4s, v20.8h, v0.h[1]
smlal2	v7.4s, v21.8h, v0.h[0]
ext	v17.16b, v3.16b, v4.16b, #0x4
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v20.16b, v3.16b, v4.16b, #0xa
ext	v21.16b, v3.16b, v4.16b, #0xc
ext	v18.16b, v3.16b, v4.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v3.8h
smull	v24.4s, v18.4h, v0.h[3]
smlal	v24.4s, v19.4h, v0.h[2]
smlal	v24.4s, v20.4h, v0.h[1]
smlal	v24.4s, v21.4h, v0.h[0]
smull2	v25.4s, v18.8h, v0.h[3]
smlal2	v25.4s, v19.8h, v0.h[2]
smlal2	v25.4s, v20.8h, v0.h[1]
smlal2	v25.4s, v21.8h, v0.h[0]
ld1	{ v16.8h, v17.8h }, [x9], #32
mvni	v26.8h, #0x80, lsl #8
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
add	v24.4s, v24.4s, v30.4s
add	v25.4s, v25.4s, v30.4s
ld1	{ v18.8h, v19.8h }, [x10], #32
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
srshl	v24.4s, v24.4s, v29.4s
srshl	v25.4s, v25.4s, v29.4s
ld1	{ v20.8h, v21.8h }, [x11], #32
sqxtun	v6.4h, v6.4s
sqxtun2	v6.8h, v7.4s
sqxtun	v7.4h, v24.4s
sqxtun2	v7.8h, v25.4s
ld1	{ v22.8h, v23.8h }, [x12], #32
umin	v6.8h, v6.8h, v26.8h
umin	v7.8h, v7.8h, v26.8h
ld1	{ v24.8h, v25.8h }, [x13], #32
sub	v6.8h, v6.8h, v31.8h
sub	v7.8h, v7.8h, v31.8h
ld1	{ v8.8h, v9.8h }, [x14], #32
smull	v1.4s, v16.4h, v0.h[4]
smlal	v1.4s, v18.4h, v0.h[5]
smlal	v1.4s, v20.4h, v0.h[6]
smlal	v1.4s, v22.4h, v0.h[7]
smlal	v1.4s, v24.4h, v0.h[6]
smlal	v1.4s, v8.4h, v0.h[5]
smlal	v1.4s, v6.4h, v0.h[4]
smull2	v5.4s, v16.8h, v0.h[4]
smlal2	v5.4s, v18.8h, v0.h[5]
smlal2	v5.4s, v20.8h, v0.h[6]
smlal2	v5.4s, v22.8h, v0.h[7]
smlal2	v5.4s, v24.8h, v0.h[6]
smlal2	v5.4s, v8.8h, v0.h[5]
smlal2	v5.4s, v6.8h, v0.h[4]
smull	v26.4s, v17.4h, v0.h[4]
smlal	v26.4s, v19.4h, v0.h[5]
smlal	v26.4s, v21.4h, v0.h[6]
smlal	v26.4s, v23.4h, v0.h[7]
smlal	v26.4s, v25.4h, v0.h[6]
smlal	v26.4s, v9.4h, v0.h[5]
smlal	v26.4s, v7.4h, v0.h[4]
smull2	v16.4s, v17.8h, v0.h[4]
smlal2	v16.4s, v19.8h, v0.h[5]
smlal2	v16.4s, v21.8h, v0.h[6]
smlal2	v16.4s, v23.8h, v0.h[7]
smlal2	v16.4s, v25.8h, v0.h[6]
smlal2	v16.4s, v9.8h, v0.h[5]
smlal2	v16.4s, v7.8h, v0.h[4]
srshl	v1.4s, v1.4s, v27.4s
srshl	v5.4s, v5.4s, v27.4s
srshl	v26.4s, v26.4s, v27.4s
srshl	v16.4s, v16.4s, v27.4s
sqxtun	v18.4h, v1.4s
sqxtun2	v18.8h, v5.4s
sqxtun	v19.4h, v26.4s
sqxtun2	v19.8h, v16.4s
st1	{ v6.8h, v7.8h }, [x15], #32
umin	v18.8h, v18.8h, v28.8h
umin	v19.8h, v19.8h, v28.8h
subs	w4, w4, #0x10
st1	{ v18.8h, v19.8h }, [x0], #32
b.le	L_63c
mov	v2.16b, v4.16b
tst	w7, #0x2
ld1	{ v3.8h, v4.8h }, [x3], #32
b.ne	L_49c
b	L_46c
L_63c:
ldp	x3, x4, [sp, #0x40]
ldp	x15, x0, [sp, #0x30]
ldp	x13, x14, [sp, #0x20]
ldp	x11, x12, [sp, #0x10]
ldp	x9, x10, [sp], #0x50
add	x3, x3, x1
add	x0, x0, x1
ret
wiener_filter5_16bpc_neon:
ldr	w8, [sp]
stp	x29, x30, [sp, #-0x20]!
stp	d8, d9, [sp, #0x10]
mov	x29, sp
ld1	{ v0.8h, v1.8h }, [x6]
tst	w7, #0x4
sub	sp, sp, #0xc00
dup	v28.8h, w8
clz	w8, w8
movi	v30.4s, #0x1
sub	w10, w8, #0x26
sub	w11, w8, #0xb
sub	w8, w8, #0x19
neg	w10, w10
neg	w11, w11
dup	v2.4s, w10
dup	v29.4s, w8
dup	v27.4s, w11
movi	v31.8h, #0x20, lsl #8
ushl	v30.4s, v30.4s, v2.4s
zip1	v0.2d, v0.2d, v1.2d
mov	x14, sp
b.eq	L_750
mov	x16, x2
mov	x2, #0x0
bl	wiener_filter5_h_16bpc_neon
add	x3, x3, x1
mov	x11, x14
add	x14, x14, #0x300
bl	wiener_filter5_h_16bpc_neon
add	x3, x3, x1, lsl #2
add	x3, x3, x1
mov	x12, x14
add	x14, x14, #0x300
mov	x2, x16
mov	x16, x3
mov	x3, x0
bl	wiener_filter5_h_16bpc_neon
subs	w5, w5, #0x1
mov	x13, x14
b.eq	L_7c0
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter5_h_16bpc_neon
subs	w5, w5, #0x1
b.eq	L_7ac
add	x3, x3, x1
L_718:
mov	x15, x11
L_71c:
bl	wiener_filter5_hv_16bpc_neon
subs	w5, w5, #0x1
b.ne	L_71c
tst	w7, #0x8
b.eq	L_7ac
mov	x3, x16
mov	x2, #0x0
bl	wiener_filter5_hv_16bpc_neon
bl	wiener_filter5_hv_16bpc_neon
L_740:
mov	sp, x29
ldp	d8, d9, [sp, #0x10]
ldp	x29, x30, [sp], #0x20
ret
L_750:
add	x3, x3, x1, lsl #2
add	x16, x3, x1, lsl #1
mov	x3, x0
bl	wiener_filter5_h_16bpc_neon
subs	w5, w5, #0x1
mov	x11, x14
mov	x12, x14
mov	x13, x14
b.eq	L_7c0
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter5_h_16bpc_neon
subs	w5, w5, #0x1
b.eq	L_7ac
add	x3, x3, x1
add	x15, x14, #0x300
bl	wiener_filter5_hv_16bpc_neon
subs	w5, w5, #0x1
b.eq	L_7ac
add	x15, x15, #0x900
bl	wiener_filter5_hv_16bpc_neon
subs	w5, w5, #0x1
b.ne	L_718
L_7ac:
bl	wiener_filter5_v_16bpc_neon
add	x0, x0, x1
mov	x11, x12
mov	x12, x13
mov	x13, x14
L_7c0:
bl	wiener_filter5_v_16bpc_neon
b	L_740
wiener_filter5_h_16bpc_neon:
stp	x3, x4, [sp, #-0x20]!
str	x14, [sp, #0x10]
tst	w7, #0x1
b.eq	L_800
cbnz	x2, L_7e8
sub	x3, x3, #0x4
ld1	{ v2.8h, v3.8h }, [x3], #32
b	L_814
L_7e8:
ld1	{ v2.8h, v3.8h }, [x3], #32
ld1	{ v4.d }[1], [x2], #8
sub	x3, x3, #0x4
ext	v3.16b, v2.16b, v3.16b, #0xc
ext	v2.16b, v4.16b, v2.16b, #0xc
b	L_814
L_800:
ld1	{ v2.8h, v3.8h }, [x3], #32
dup	v4.8h, v2.h[0]
sub	x3, x3, #0x4
ext	v3.16b, v2.16b, v3.16b, #0xc
ext	v2.16b, v4.16b, v2.16b, #0xc
L_814:
ld1	{ v4.8h }, [x3], #16
tst	w7, #0x2
b.ne	L_850
L_820:
cmp	w4, #0x12
b.ge	L_850
sub	w17, w4, #0x17
adrp	x6, right_ext_mask_buf+44
add	x6, x6, :lo12:right_ext_mask_buf+44
ldr	h26, [x3, w17, sxtw #1]
sub	x6, x6, w4, uxtw #1
dup	v26.8h, v26.h[0]
ld1	{ v23.16b, v24.16b, v25.16b }, [x6]
bit	v2.16b, v26.16b, v23.16b
bit	v3.16b, v26.16b, v24.16b
bit	v4.16b, v26.16b, v25.16b
L_850:
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v18.16b, v2.16b, v3.16b, #0x6
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v17.16b, v2.16b, v3.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v2.8h
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v18.4h, v0.h[2]
smlal	v6.4s, v19.4h, v0.h[1]
smull2	v7.4s, v17.8h, v0.h[3]
smlal2	v7.4s, v18.8h, v0.h[2]
smlal2	v7.4s, v19.8h, v0.h[1]
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v18.16b, v3.16b, v4.16b, #0x6
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v17.16b, v3.16b, v4.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v3.8h
smull	v16.4s, v17.4h, v0.h[3]
smlal	v16.4s, v18.4h, v0.h[2]
smlal	v16.4s, v19.4h, v0.h[1]
smull2	v17.4s, v17.8h, v0.h[3]
smlal2	v17.4s, v18.8h, v0.h[2]
smlal2	v17.4s, v19.8h, v0.h[1]
mvni	v24.8h, #0x80, lsl #8
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
add	v16.4s, v16.4s, v30.4s
add	v17.4s, v17.4s, v30.4s
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
srshl	v16.4s, v16.4s, v29.4s
srshl	v17.4s, v17.4s, v29.4s
sqxtun	v6.4h, v6.4s
sqxtun2	v6.8h, v7.4s
sqxtun	v7.4h, v16.4s
sqxtun2	v7.8h, v17.4s
umin	v6.8h, v6.8h, v24.8h
umin	v7.8h, v7.8h, v24.8h
sub	v6.8h, v6.8h, v31.8h
sub	v7.8h, v7.8h, v31.8h
subs	w4, w4, #0x10
st1	{ v6.8h, v7.8h }, [x14], #32
b.le	L_914
mov	v2.16b, v4.16b
tst	w7, #0x2
ld1	{ v3.8h, v4.8h }, [x3], #32
b.ne	L_850
b	L_820
L_914:
ldr	x14, [sp, #0x10]
ldp	x3, x4, [sp], #0x20
ret
wiener_filter5_v_16bpc_neon:
stp	x11, x12, [sp, #-0x30]!
stp	x13, x14, [sp, #0x10]
stp	x0, x4, [sp, #0x20]
L_92c:
ld1	{ v16.8h, v17.8h }, [x11], #32
ld1	{ v18.8h, v19.8h }, [x12], #32
ld1	{ v20.8h, v21.8h }, [x13], #32
ld1	{ v22.8h, v23.8h }, [x14], #32
smull	v2.4s, v16.4h, v0.h[5]
smlal	v2.4s, v18.4h, v0.h[6]
smlal	v2.4s, v20.4h, v0.h[7]
smlal	v2.4s, v22.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[5]
smull2	v3.4s, v16.8h, v0.h[5]
smlal2	v3.4s, v18.8h, v0.h[6]
smlal2	v3.4s, v20.8h, v0.h[7]
smlal2	v3.4s, v22.8h, v0.h[6]
smlal2	v3.4s, v22.8h, v0.h[5]
smull	v4.4s, v17.4h, v0.h[5]
smlal	v4.4s, v19.4h, v0.h[6]
smlal	v4.4s, v21.4h, v0.h[7]
smlal	v4.4s, v23.4h, v0.h[6]
smlal	v4.4s, v23.4h, v0.h[5]
smull2	v5.4s, v17.8h, v0.h[5]
smlal2	v5.4s, v19.8h, v0.h[6]
smlal2	v5.4s, v21.8h, v0.h[7]
smlal2	v5.4s, v23.8h, v0.h[6]
smlal2	v5.4s, v23.8h, v0.h[5]
srshl	v2.4s, v2.4s, v27.4s
srshl	v3.4s, v3.4s, v27.4s
srshl	v4.4s, v4.4s, v27.4s
srshl	v5.4s, v5.4s, v27.4s
sqxtun	v2.4h, v2.4s
sqxtun2	v2.8h, v3.4s
sqxtun	v3.4h, v4.4s
sqxtun2	v3.8h, v5.4s
umin	v2.8h, v2.8h, v28.8h
umin	v3.8h, v3.8h, v28.8h
subs	w4, w4, #0x10
st1	{ v2.8h, v3.8h }, [x0], #32
b.gt	L_92c
ldp	x0, x4, [sp, #0x20]
ldp	x13, x14, [sp, #0x10]
ldp	x11, x12, [sp], #0x30
ret
wiener_filter5_hv_16bpc_neon:
stp	x12, x13, [sp, #-0x40]!
stp	x14, x15, [sp, #0x10]
stp	x12, x0, [sp, #0x20]
stp	x3, x4, [sp, #0x30]
tst	w7, #0x1
b.eq	L_a10
cbnz	x2, L_9f8
sub	x3, x3, #0x4
ld1	{ v2.8h, v3.8h }, [x3], #32
b	L_a24
L_9f8:
ld1	{ v2.8h, v3.8h }, [x3], #32
ld1	{ v4.d }[1], [x2], #8
sub	x3, x3, #0x4
ext	v3.16b, v2.16b, v3.16b, #0xc
ext	v2.16b, v4.16b, v2.16b, #0xc
b	L_a24
L_a10:
ld1	{ v2.8h, v3.8h }, [x3], #32
dup	v4.8h, v2.h[0]
sub	x3, x3, #0x4
ext	v3.16b, v2.16b, v3.16b, #0xc
ext	v2.16b, v4.16b, v2.16b, #0xc
L_a24:
ld1	{ v4.8h }, [x3], #16
tst	w7, #0x2
b.ne	L_a60
L_a30:
cmp	w4, #0x12
b.ge	L_a60
sub	w17, w4, #0x17
adrp	x6, right_ext_mask_buf+44
add	x6, x6, :lo12:right_ext_mask_buf+44
ldr	h26, [x3, w17, sxtw #1]
sub	x6, x6, w4, uxtw #1
dup	v26.8h, v26.h[0]
ld1	{ v23.16b, v24.16b, v25.16b }, [x6]
bit	v2.16b, v26.16b, v23.16b
bit	v3.16b, v26.16b, v24.16b
bit	v4.16b, v26.16b, v25.16b
L_a60:
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v18.16b, v2.16b, v3.16b, #0x6
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v17.16b, v2.16b, v3.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v2.8h
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v18.4h, v0.h[2]
smlal	v6.4s, v19.4h, v0.h[1]
smull2	v7.4s, v17.8h, v0.h[3]
smlal2	v7.4s, v18.8h, v0.h[2]
smlal2	v7.4s, v19.8h, v0.h[1]
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v18.16b, v3.16b, v4.16b, #0x6
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v17.16b, v3.16b, v4.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v3.8h
smull	v24.4s, v17.4h, v0.h[3]
smlal	v24.4s, v18.4h, v0.h[2]
smlal	v24.4s, v19.4h, v0.h[1]
smull2	v25.4s, v17.8h, v0.h[3]
smlal2	v25.4s, v18.8h, v0.h[2]
smlal2	v25.4s, v19.8h, v0.h[1]
ld1	{ v16.8h, v17.8h }, [x11], #32
mvni	v26.8h, #0x80, lsl #8
add	v6.4s, v6.4s, v30.4s
add	v7.4s, v7.4s, v30.4s
add	v24.4s, v24.4s, v30.4s
add	v25.4s, v25.4s, v30.4s
ld1	{ v18.8h, v19.8h }, [x12], #32
srshl	v6.4s, v6.4s, v29.4s
srshl	v7.4s, v7.4s, v29.4s
srshl	v24.4s, v24.4s, v29.4s
srshl	v25.4s, v25.4s, v29.4s
ld1	{ v20.8h, v21.8h }, [x13], #32
sqxtun	v6.4h, v6.4s
sqxtun2	v6.8h, v7.4s
sqxtun	v7.4h, v24.4s
sqxtun2	v7.8h, v25.4s
ld1	{ v22.8h, v23.8h }, [x14], #32
umin	v6.8h, v6.8h, v26.8h
umin	v7.8h, v7.8h, v26.8h
sub	v6.8h, v6.8h, v31.8h
sub	v7.8h, v7.8h, v31.8h
smull	v8.4s, v16.4h, v0.h[5]
smlal	v8.4s, v18.4h, v0.h[6]
smlal	v8.4s, v20.4h, v0.h[7]
smlal	v8.4s, v22.4h, v0.h[6]
smlal	v8.4s, v6.4h, v0.h[5]
smull2	v9.4s, v16.8h, v0.h[5]
smlal2	v9.4s, v18.8h, v0.h[6]
smlal2	v9.4s, v20.8h, v0.h[7]
smlal2	v9.4s, v22.8h, v0.h[6]
smlal2	v9.4s, v6.8h, v0.h[5]
smull	v1.4s, v17.4h, v0.h[5]
smlal	v1.4s, v19.4h, v0.h[6]
smlal	v1.4s, v21.4h, v0.h[7]
smlal	v1.4s, v23.4h, v0.h[6]
smlal	v1.4s, v7.4h, v0.h[5]
smull2	v5.4s, v17.8h, v0.h[5]
smlal2	v5.4s, v19.8h, v0.h[6]
smlal2	v5.4s, v21.8h, v0.h[7]
smlal2	v5.4s, v23.8h, v0.h[6]
smlal2	v5.4s, v7.8h, v0.h[5]
srshl	v8.4s, v8.4s, v27.4s
srshl	v9.4s, v9.4s, v27.4s
srshl	v1.4s, v1.4s, v27.4s
srshl	v5.4s, v5.4s, v27.4s
sqxtun	v8.4h, v8.4s
sqxtun2	v8.8h, v9.4s
sqxtun	v9.4h, v1.4s
sqxtun2	v9.8h, v5.4s
st1	{ v6.8h, v7.8h }, [x15], #32
umin	v8.8h, v8.8h, v28.8h
umin	v9.8h, v9.8h, v28.8h
subs	w4, w4, #0x10
st1	{ v8.8h, v9.8h }, [x0], #32
b.le	L_bb0
mov	v2.16b, v4.16b
tst	w7, #0x2
ld1	{ v3.8h, v4.8h }, [x3], #32
b.ne	L_a60
b	L_a30
L_bb0:
ldp	x3, x4, [sp, #0x30]
ldp	x15, x0, [sp, #0x20]
ldp	x13, x14, [sp, #0x10]
ldp	x11, x12, [sp], #0x40
add	x3, x3, x1
add	x0, x0, x1
ret
sgr_box3_row_h_16bpc_neon:
add	w4, w4, #0x2
tst	w5, #0x1
b.eq	L_c00
cbnz	x2, L_be8
sub	x3, x3, #0x4
ld1	{ v0.8h, v1.8h }, [x3], #32
b	L_c14
L_be8:
ld1	{ v0.8h, v1.8h }, [x3], #32
ld1	{ v2.d }[1], [x2]
sub	x3, x3, #0x4
ext	v1.16b, v0.16b, v1.16b, #0xc
ext	v0.16b, v2.16b, v0.16b, #0xc
b	L_c14
L_c00:
ld1	{ v0.8h, v1.8h }, [x3], #32
dup	v2.8h, v0.h[0]
sub	x3, x3, #0x4
ext	v1.16b, v0.16b, v1.16b, #0xc
ext	v0.16b, v2.16b, v0.16b, #0xc
L_c14:
tst	w5, #0x2
b.ne	L_c48
sub	w13, w4, #0x11
ldr	h30, [x3, w13, sxtw #1]
dup	v30.8h, v30.h[0]
L_c28:
cmp	w4, #0xa
b.ge	L_c48
adrp	x13, right_ext_mask
add	x13, x13, :lo12:right_ext_mask
sub	x13, x13, w4, uxtw #1
ld1	{ v28.16b, v29.16b }, [x13]
bit	v0.16b, v30.16b, v28.16b
bit	v1.16b, v30.16b, v29.16b
L_c48:
ext	v26.16b, v0.16b, v1.16b, #0x2
ext	v27.16b, v0.16b, v1.16b, #0x4
add	v6.8h, v0.8h, v26.8h
umull	v22.4s, v0.4h, v0.4h
umlal	v22.4s, v26.4h, v26.4h
umlal	v22.4s, v27.4h, v27.4h
add	v6.8h, v6.8h, v27.8h
umull2	v23.4s, v0.8h, v0.8h
umlal2	v23.4s, v26.8h, v26.8h
umlal2	v23.4s, v27.8h, v27.8h
subs	w4, w4, #0x8
st1	{ v6.8h }, [x1], #16
st1	{ v22.4s, v23.4s }, [x0], #32
b.le	L_c94
tst	w5, #0x2
mov	v0.16b, v1.16b
ld1	{ v1.8h }, [x3], #16
b.ne	L_c48
b	L_c28
L_c94:
ret
sgr_box5_row_h_16bpc_neon:
add	w4, w4, #0x2
tst	w5, #0x1
b.eq	L_ccc
cbnz	x2, L_cb4
sub	x3, x3, #0x6
ld1	{ v0.8h, v1.8h }, [x3], #32
b	L_ce0
L_cb4:
ld1	{ v0.8h, v1.8h }, [x3], #32
ld1	{ v2.d }[1], [x2], #8
sub	x3, x3, #0x6
ext	v1.16b, v0.16b, v1.16b, #0xa
ext	v0.16b, v2.16b, v0.16b, #0xa
b	L_ce0
L_ccc:
ld1	{ v0.8h, v1.8h }, [x3], #32
dup	v2.8h, v0.h[0]
sub	x3, x3, #0x6
ext	v1.16b, v0.16b, v1.16b, #0xa
ext	v0.16b, v2.16b, v0.16b, #0xa
L_ce0:
tst	w5, #0x2
b.ne	L_d14
sub	w13, w4, #0x10
ldr	h30, [x3, w13, sxtw #1]
dup	v30.8h, v30.h[0]
L_cf4:
cmp	w4, #0xb
b.ge	L_d14
adrp	x13, right_ext_mask_buf+47
add	x13, x13, :lo12:right_ext_mask_buf+47
sub	x13, x13, w4, uxtw #1
ld1	{ v28.16b, v29.16b }, [x13]
bit	v0.16b, v30.16b, v28.16b
bit	v1.16b, v30.16b, v29.16b
L_d14:
ext	v26.16b, v0.16b, v1.16b, #0x2
ext	v27.16b, v0.16b, v1.16b, #0x4
add	v6.8h, v0.8h, v26.8h
umull	v22.4s, v0.4h, v0.4h
umlal	v22.4s, v26.4h, v26.4h
umlal	v22.4s, v27.4h, v27.4h
add	v6.8h, v6.8h, v27.8h
umull2	v23.4s, v0.8h, v0.8h
umlal2	v23.4s, v26.8h, v26.8h
umlal2	v23.4s, v27.8h, v27.8h
ext	v26.16b, v0.16b, v1.16b, #0x6
ext	v27.16b, v0.16b, v1.16b, #0x8
add	v6.8h, v6.8h, v26.8h
umlal	v22.4s, v26.4h, v26.4h
umlal	v22.4s, v27.4h, v27.4h
add	v6.8h, v6.8h, v27.8h
umlal2	v23.4s, v26.8h, v26.8h
umlal2	v23.4s, v27.8h, v27.8h
subs	w4, w4, #0x8
st1	{ v6.8h }, [x1], #16
st1	{ v22.4s, v23.4s }, [x0], #32
b.le	L_d80
tst	w5, #0x2
mov	v0.16b, v1.16b
ld1	{ v1.8h }, [x3], #16
b.ne	L_d14
b	L_cf4
L_d80:
ret
sgr_box35_row_h_16bpc_neon:
add	w6, w6, #0x2
tst	w7, #0x1
b.eq	L_db8
cbnz	x4, L_da0
sub	x5, x5, #0x6
ld1	{ v0.8h, v1.8h }, [x5], #32
b	L_dcc
L_da0:
ld1	{ v0.8h, v1.8h }, [x5], #32
ld1	{ v2.d }[1], [x4], #8
sub	x5, x5, #0x6
ext	v1.16b, v0.16b, v1.16b, #0xa
ext	v0.16b, v2.16b, v0.16b, #0xa
b	L_dcc
L_db8:
ld1	{ v0.8h, v1.8h }, [x5], #32
dup	v2.8h, v0.h[0]
sub	x5, x5, #0x6
ext	v1.16b, v0.16b, v1.16b, #0xa
ext	v0.16b, v2.16b, v0.16b, #0xa
L_dcc:
tst	w7, #0x2
b.ne	L_e00
sub	w13, w6, #0x10
ldr	h30, [x5, w13, sxtw #1]
dup	v30.8h, v30.h[0]
L_de0:
cmp	w6, #0xb
b.ge	L_e00
adrp	x13, right_ext_mask_buf+47
add	x13, x13, :lo12:right_ext_mask_buf+47
sub	x13, x13, w6, uxtw #1
ld1	{ v28.16b, v29.16b }, [x13]
bit	v0.16b, v30.16b, v28.16b
bit	v1.16b, v30.16b, v29.16b
L_e00:
ext	v16.16b, v0.16b, v1.16b, #0x2
ext	v17.16b, v0.16b, v1.16b, #0x4
ext	v19.16b, v0.16b, v1.16b, #0x8
ext	v18.16b, v0.16b, v1.16b, #0x6
add	v20.8h, v16.8h, v17.8h
add	v21.8h, v0.8h, v19.8h
add	v20.8h, v20.8h, v18.8h
umull	v22.4s, v16.4h, v16.4h
umlal	v22.4s, v17.4h, v17.4h
umlal	v22.4s, v18.4h, v18.4h
umull2	v23.4s, v16.8h, v16.8h
umlal2	v23.4s, v17.8h, v17.8h
umlal2	v23.4s, v18.8h, v18.8h
add	v21.8h, v21.8h, v20.8h
st1	{ v20.8h }, [x1], #16
st1	{ v22.4s, v23.4s }, [x0], #32
umlal	v22.4s, v0.4h, v0.4h
umlal	v22.4s, v19.4h, v19.4h
umlal2	v23.4s, v0.8h, v0.8h
umlal2	v23.4s, v19.8h, v19.8h
subs	w6, w6, #0x8
st1	{ v21.8h }, [x3], #16
st1	{ v22.4s, v23.4s }, [x2], #32
b.le	L_e74
tst	w7, #0x2
mov	v0.16b, v1.16b
ld1	{ v1.8h }, [x5], #16
b.ne	L_e00
b	L_de0
L_e74:
ret
sgr_finish_filter1_2rows_16bpc_neon:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	x7, x8, [x3]
ldp	x9, x3, [x3, #0x10]
ldp	x10, x11, [x4]
ldp	x12, x4, [x4, #0x10]
mov	x13, #0x180
cmp	w6, #0x1
add	x2, x1, x2
csel	x2, x1, x2, le
add	x13, x0, x13, lsl #1
movi	v30.8h, #0x3
movi	v31.4s, #0x3
ld1	{ v0.8h, v1.8h }, [x10], #32
ld1	{ v2.8h, v3.8h }, [x11], #32
ld1	{ v4.8h, v5.8h }, [x12], #32
ld1	{ v6.8h, v7.8h }, [x4], #32
ld1	{ v16.4s, v17.4s, v18.4s }, [x7], #48
ld1	{ v19.4s, v20.4s, v21.4s }, [x8], #48
ld1	{ v22.4s, v23.4s, v24.4s }, [x9], #48
ld1	{ v25.4s, v26.4s, v27.4s }, [x3], #48
L_ed4:
ext	v8.16b, v0.16b, v1.16b, #0x2
ext	v9.16b, v2.16b, v3.16b, #0x2
ext	v10.16b, v4.16b, v5.16b, #0x2
ext	v11.16b, v0.16b, v1.16b, #0x4
ext	v12.16b, v2.16b, v3.16b, #0x4
ext	v13.16b, v4.16b, v5.16b, #0x4
add	v14.8h, v2.8h, v8.8h
add	v15.8h, v9.8h, v10.8h
add	v28.8h, v0.8h, v11.8h
add	v14.8h, v14.8h, v12.8h
add	v29.8h, v4.8h, v13.8h
ext	v8.16b, v6.16b, v7.16b, #0x2
ext	v11.16b, v6.16b, v7.16b, #0x4
add	v14.8h, v14.8h, v15.8h
add	v15.8h, v28.8h, v29.8h
add	v28.8h, v4.8h, v9.8h
add	v29.8h, v10.8h, v8.8h
add	v2.8h, v2.8h, v12.8h
add	v28.8h, v28.8h, v13.8h
add	v4.8h, v6.8h, v11.8h
add	v0.8h, v28.8h, v29.8h
add	v2.8h, v2.8h, v4.8h
shl	v4.8h, v14.8h, #0x2
mla	v4.8h, v15.8h, v30.8h
shl	v0.8h, v0.8h, #0x2
mla	v0.8h, v2.8h, v30.8h
ext	v8.16b, v16.16b, v17.16b, #0x4
ext	v9.16b, v17.16b, v18.16b, #0x4
ext	v10.16b, v16.16b, v17.16b, #0x8
ext	v11.16b, v17.16b, v18.16b, #0x8
ext	v12.16b, v19.16b, v20.16b, #0x4
ext	v13.16b, v20.16b, v21.16b, #0x4
add	v8.4s, v8.4s, v19.4s
add	v9.4s, v9.4s, v20.4s
add	v16.4s, v16.4s, v10.4s
add	v17.4s, v17.4s, v11.4s
ext	v14.16b, v19.16b, v20.16b, #0x8
ext	v15.16b, v20.16b, v21.16b, #0x8
add	v16.4s, v16.4s, v22.4s
add	v17.4s, v17.4s, v23.4s
add	v28.4s, v12.4s, v14.4s
add	v29.4s, v13.4s, v15.4s
ext	v10.16b, v22.16b, v23.16b, #0x4
ext	v11.16b, v23.16b, v24.16b, #0x4
add	v8.4s, v8.4s, v28.4s
add	v9.4s, v9.4s, v29.4s
add	v19.4s, v19.4s, v14.4s
add	v20.4s, v20.4s, v15.4s
add	v14.4s, v22.4s, v12.4s
add	v15.4s, v23.4s, v13.4s
ext	v12.16b, v22.16b, v23.16b, #0x8
ext	v13.16b, v23.16b, v24.16b, #0x8
ext	v28.16b, v25.16b, v26.16b, #0x4
ext	v29.16b, v26.16b, v27.16b, #0x4
add	v8.4s, v8.4s, v10.4s
add	v9.4s, v9.4s, v11.4s
add	v14.4s, v14.4s, v10.4s
add	v15.4s, v15.4s, v11.4s
ext	v10.16b, v25.16b, v26.16b, #0x8
ext	v11.16b, v26.16b, v27.16b, #0x8
add	v16.4s, v16.4s, v12.4s
add	v17.4s, v17.4s, v13.4s
add	v12.4s, v12.4s, v28.4s
add	v13.4s, v13.4s, v29.4s
add	v25.4s, v25.4s, v10.4s
add	v26.4s, v26.4s, v11.4s
add	v14.4s, v14.4s, v12.4s
add	v15.4s, v15.4s, v13.4s
add	v19.4s, v19.4s, v25.4s
add	v20.4s, v20.4s, v26.4s
ld1	{ v25.8h }, [x1], #16
ld1	{ v26.8h }, [x2], #16
shl	v8.4s, v8.4s, #0x2
shl	v9.4s, v9.4s, #0x2
mla	v8.4s, v16.4s, v31.4s
mla	v9.4s, v17.4s, v31.4s
shl	v14.4s, v14.4s, #0x2
shl	v15.4s, v15.4s, #0x2
mla	v14.4s, v19.4s, v31.4s
mla	v15.4s, v20.4s, v31.4s
umlsl	v8.4s, v4.4h, v25.4h
umlsl2	v9.4s, v4.8h, v25.8h
umlsl	v14.4s, v0.4h, v26.4h
umlsl2	v15.4s, v0.8h, v26.8h
mov	v0.16b, v1.16b
rshrn	v8.4h, v8.4s, #0x9
rshrn2	v8.8h, v9.4s, #0x9
mov	v2.16b, v3.16b
rshrn	v14.4h, v14.4s, #0x9
rshrn2	v14.8h, v15.4s, #0x9
subs	w5, w5, #0x8
mov	v4.16b, v5.16b
st1	{ v8.8h }, [x0], #16
mov	v6.16b, v7.16b
st1	{ v14.8h }, [x13], #16
b.le	L_1088
mov	v16.16b, v18.16b
mov	v19.16b, v21.16b
mov	v22.16b, v24.16b
mov	v25.16b, v27.16b
ld1	{ v1.8h }, [x10], #16
ld1	{ v3.8h }, [x11], #16
ld1	{ v5.8h }, [x12], #16
ld1	{ v7.8h }, [x4], #16
ld1	{ v17.4s, v18.4s }, [x7], #32
ld1	{ v20.4s, v21.4s }, [x8], #32
ld1	{ v23.4s, v24.4s }, [x9], #32
ld1	{ v26.4s, v27.4s }, [x3], #32
b	L_ed4
L_1088:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
sgr_finish_weighted1_16bpc_neon:
ldp	x7, x8, [x1]
ldr	x1, [x1, #0x10]
ldp	x9, x10, [x2]
ldr	x2, [x2, #0x10]
dup	v31.8h, w4
dup	v30.8h, w5
movi	v6.8h, #0x3
movi	v7.4s, #0x3
ld1	{ v0.8h, v1.8h }, [x9], #32
ld1	{ v2.8h, v3.8h }, [x10], #32
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v16.4s, v17.4s, v18.4s }, [x7], #48
ld1	{ v19.4s, v20.4s, v21.4s }, [x8], #48
ld1	{ v22.4s, v23.4s, v24.4s }, [x1], #48
L_10d4:
ext	v25.16b, v0.16b, v1.16b, #0x2
ext	v26.16b, v2.16b, v3.16b, #0x2
ext	v27.16b, v4.16b, v5.16b, #0x2
ext	v28.16b, v0.16b, v1.16b, #0x4
ext	v29.16b, v2.16b, v3.16b, #0x4
add	v2.8h, v2.8h, v25.8h
ext	v25.16b, v4.16b, v5.16b, #0x4
add	v26.8h, v26.8h, v27.8h
add	v0.8h, v0.8h, v28.8h
add	v2.8h, v2.8h, v26.8h
add	v4.8h, v4.8h, v25.8h
add	v2.8h, v2.8h, v29.8h
add	v0.8h, v0.8h, v4.8h
ext	v25.16b, v16.16b, v17.16b, #0x4
ext	v26.16b, v17.16b, v18.16b, #0x4
shl	v2.8h, v2.8h, #0x2
ext	v27.16b, v16.16b, v17.16b, #0x8
ext	v28.16b, v17.16b, v18.16b, #0x8
ext	v29.16b, v19.16b, v20.16b, #0x4
ext	v4.16b, v20.16b, v21.16b, #0x4
mla	v2.8h, v0.8h, v6.8h
add	v25.4s, v25.4s, v19.4s
add	v26.4s, v26.4s, v20.4s
add	v16.4s, v16.4s, v27.4s
add	v17.4s, v17.4s, v28.4s
ext	v27.16b, v19.16b, v20.16b, #0x8
ext	v28.16b, v20.16b, v21.16b, #0x8
add	v16.4s, v16.4s, v22.4s
add	v17.4s, v17.4s, v23.4s
add	v29.4s, v29.4s, v27.4s
add	v4.4s, v4.4s, v28.4s
add	v25.4s, v25.4s, v29.4s
add	v26.4s, v26.4s, v4.4s
ext	v27.16b, v22.16b, v23.16b, #0x4
ext	v28.16b, v23.16b, v24.16b, #0x4
ext	v29.16b, v22.16b, v23.16b, #0x8
ext	v4.16b, v23.16b, v24.16b, #0x8
ld1	{ v19.8h }, [x0]
add	v25.4s, v25.4s, v27.4s
add	v26.4s, v26.4s, v28.4s
add	v16.4s, v16.4s, v29.4s
add	v17.4s, v17.4s, v4.4s
shl	v25.4s, v25.4s, #0x2
shl	v26.4s, v26.4s, #0x2
mla	v25.4s, v16.4s, v7.4s
mla	v26.4s, v17.4s, v7.4s
mov	v0.16b, v1.16b
umlsl	v25.4s, v2.4h, v19.4h
umlsl2	v26.4s, v2.8h, v19.8h
mov	v2.16b, v3.16b
rshrn	v25.4h, v25.4s, #0x9
rshrn2	v25.8h, v26.4s, #0x9
subs	w3, w3, #0x8
mov	v4.16b, v5.16b
ld1	{ v1.8h }, [x9], #16
ld1	{ v3.8h }, [x10], #16
smull	v26.4s, v25.4h, v31.4h
smull2	v27.4s, v25.8h, v31.8h
ld1	{ v5.8h }, [x2], #16
rshrn	v26.4h, v26.4s, #0xb
rshrn2	v26.8h, v27.4s, #0xb
usqadd	v19.8h, v26.8h
mov	v16.16b, v18.16b
umin	v26.8h, v19.8h, v30.8h
mov	v19.16b, v21.16b
mov	v22.16b, v24.16b
st1	{ v26.8h }, [x0], #16
b.le	L_11f4
ld1	{ v17.4s, v18.4s }, [x7], #32
ld1	{ v20.4s, v21.4s }, [x8], #32
ld1	{ v23.4s, v24.4s }, [x1], #32
b	L_10d4
L_11f4:
ret
sgr_finish_filter2_2rows_16bpc_neon:
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	x3, x7, [x3]
ldp	x4, x8, [x4]
mov	x10, #0x180
cmp	w6, #0x1
add	x2, x1, x2
csel	x2, x1, x2, le
add	x10, x0, x10, lsl #1
movi	v4.8h, #0x5
movi	v5.4s, #0x5
movi	v6.8h, #0x6
movi	v7.4s, #0x6
ld1	{ v0.8h, v1.8h }, [x4], #32
ld1	{ v2.8h, v3.8h }, [x8], #32
ld1	{ v16.4s, v17.4s, v18.4s }, [x3], #48
ld1	{ v19.4s, v20.4s, v21.4s }, [x7], #48
L_1244:
ext	v24.16b, v0.16b, v1.16b, #0x4
ext	v25.16b, v2.16b, v3.16b, #0x4
ext	v22.16b, v0.16b, v1.16b, #0x2
ext	v23.16b, v2.16b, v3.16b, #0x2
add	v0.8h, v0.8h, v24.8h
add	v25.8h, v2.8h, v25.8h
add	v2.8h, v22.8h, v23.8h
add	v0.8h, v0.8h, v25.8h
mul	v8.8h, v25.8h, v4.8h
mla	v8.8h, v23.8h, v6.8h
ext	v22.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v17.16b, v18.16b, #0x4
ext	v24.16b, v19.16b, v20.16b, #0x4
ext	v25.16b, v20.16b, v21.16b, #0x4
ext	v26.16b, v16.16b, v17.16b, #0x8
ext	v27.16b, v17.16b, v18.16b, #0x8
ext	v28.16b, v19.16b, v20.16b, #0x8
ext	v29.16b, v20.16b, v21.16b, #0x8
mul	v0.8h, v0.8h, v4.8h
mla	v0.8h, v2.8h, v6.8h
ld1	{ v31.8h }, [x1], #16
ld1	{ v30.8h }, [x2], #16
add	v16.4s, v16.4s, v26.4s
add	v17.4s, v17.4s, v27.4s
add	v19.4s, v19.4s, v28.4s
add	v20.4s, v20.4s, v29.4s
add	v16.4s, v16.4s, v19.4s
add	v17.4s, v17.4s, v20.4s
mul	v9.4s, v19.4s, v5.4s
mla	v9.4s, v24.4s, v7.4s
mul	v10.4s, v20.4s, v5.4s
mla	v10.4s, v25.4s, v7.4s
add	v22.4s, v22.4s, v24.4s
add	v23.4s, v23.4s, v25.4s
mul	v16.4s, v16.4s, v5.4s
mla	v16.4s, v22.4s, v7.4s
mul	v17.4s, v17.4s, v5.4s
mla	v17.4s, v23.4s, v7.4s
umlsl	v16.4s, v0.4h, v31.4h
umlsl2	v17.4s, v0.8h, v31.8h
umlsl	v9.4s, v8.4h, v30.4h
umlsl2	v10.4s, v8.8h, v30.8h
mov	v0.16b, v1.16b
rshrn	v16.4h, v16.4s, #0x9
rshrn2	v16.8h, v17.4s, #0x9
rshrn	v9.4h, v9.4s, #0x8
rshrn2	v9.8h, v10.4s, #0x8
subs	w5, w5, #0x8
mov	v2.16b, v3.16b
st1	{ v16.8h }, [x0], #16
st1	{ v9.8h }, [x10], #16
b.le	L_1330
mov	v16.16b, v18.16b
mov	v19.16b, v21.16b
ld1	{ v1.8h }, [x4], #16
ld1	{ v3.8h }, [x8], #16
ld1	{ v17.4s, v18.4s }, [x3], #32
ld1	{ v20.4s, v21.4s }, [x7], #32
b	L_1244
L_1330:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
sgr_finish_weighted2_16bpc_neon:
stp	d8, d9, [sp, #-0x30]!
str	d10, [sp, #0x10]
stp	d14, d15, [sp, #0x20]
dup	v14.8h, w6
dup	v15.8h, w7
ldp	x2, x7, [x2]
ldp	x3, x8, [x3]
cmp	w5, #0x1
add	x1, x0, x1
csel	x1, x2, x1, le
movi	v4.8h, #0x5
movi	v5.4s, #0x5
movi	v6.8h, #0x6
movi	v7.4s, #0x6
ld1	{ v0.8h, v1.8h }, [x3], #32
ld1	{ v2.8h, v3.8h }, [x8], #32
ld1	{ v16.4s, v17.4s, v18.4s }, [x2], #48
ld1	{ v19.4s, v20.4s, v21.4s }, [x7], #48
L_138c:
ext	v24.16b, v0.16b, v1.16b, #0x4
ext	v25.16b, v2.16b, v3.16b, #0x4
ext	v22.16b, v0.16b, v1.16b, #0x2
ext	v23.16b, v2.16b, v3.16b, #0x2
add	v0.8h, v0.8h, v24.8h
add	v25.8h, v2.8h, v25.8h
add	v2.8h, v22.8h, v23.8h
add	v0.8h, v0.8h, v25.8h
mul	v8.8h, v25.8h, v4.8h
mla	v8.8h, v23.8h, v6.8h
ext	v22.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v17.16b, v18.16b, #0x4
ext	v24.16b, v19.16b, v20.16b, #0x4
ext	v25.16b, v20.16b, v21.16b, #0x4
ext	v26.16b, v16.16b, v17.16b, #0x8
ext	v27.16b, v17.16b, v18.16b, #0x8
ext	v28.16b, v19.16b, v20.16b, #0x8
ext	v29.16b, v20.16b, v21.16b, #0x8
mul	v0.8h, v0.8h, v4.8h
mla	v0.8h, v2.8h, v6.8h
ld1	{ v31.8h }, [x0]
ld1	{ v30.8h }, [x1]
add	v16.4s, v16.4s, v26.4s
add	v17.4s, v17.4s, v27.4s
add	v19.4s, v19.4s, v28.4s
add	v20.4s, v20.4s, v29.4s
add	v16.4s, v16.4s, v19.4s
add	v17.4s, v17.4s, v20.4s
mul	v9.4s, v19.4s, v5.4s
mla	v9.4s, v24.4s, v7.4s
mul	v10.4s, v20.4s, v5.4s
mla	v10.4s, v25.4s, v7.4s
add	v22.4s, v22.4s, v24.4s
add	v23.4s, v23.4s, v25.4s
mul	v16.4s, v16.4s, v5.4s
mla	v16.4s, v22.4s, v7.4s
mul	v17.4s, v17.4s, v5.4s
mla	v17.4s, v23.4s, v7.4s
umlsl	v16.4s, v0.4h, v31.4h
umlsl2	v17.4s, v0.8h, v31.8h
umlsl	v9.4s, v8.4h, v30.4h
umlsl2	v10.4s, v8.8h, v30.8h
mov	v0.16b, v1.16b
rshrn	v16.4h, v16.4s, #0x9
rshrn2	v16.8h, v17.4s, #0x9
rshrn	v9.4h, v9.4s, #0x8
rshrn2	v9.8h, v10.4s, #0x8
subs	w4, w4, #0x8
mov	v2.16b, v3.16b
ld1	{ v1.8h }, [x3], #16
ld1	{ v3.8h }, [x8], #16
smull	v22.4s, v16.4h, v14.4h
smull2	v23.4s, v16.8h, v14.8h
mov	v16.16b, v18.16b
smull	v24.4s, v9.4h, v14.4h
smull2	v25.4s, v9.8h, v14.8h
mov	v19.16b, v21.16b
rshrn	v22.4h, v22.4s, #0xb
rshrn2	v22.8h, v23.4s, #0xb
rshrn	v23.4h, v24.4s, #0xb
rshrn2	v23.8h, v25.4s, #0xb
usqadd	v31.8h, v22.8h
usqadd	v30.8h, v23.8h
umin	v22.8h, v31.8h, v15.8h
umin	v23.8h, v30.8h, v15.8h
st1	{ v22.8h }, [x0], #16
st1	{ v23.8h }, [x1], #16
b.le	L_14a8
ld1	{ v17.4s, v18.4s }, [x2], #32
ld1	{ v20.4s, v21.4s }, [x7], #32
b	L_138c
L_14a8:
ldp	d14, d15, [sp, #0x20]
ldr	d10, [sp, #0x10]
ldp	d8, d9, [sp], #0x30
ret
sgr_weighted2_16bpc_neon:
cmp	w5, #0x2
add	x10, x0, x1
add	x12, x2, #0x300
add	x13, x3, #0x300
ld2r	{ v30.8h, v31.8h }, [x6]
dup	v29.8h, w7
mov	x8, #0x600
lsl	x1, x1, #1
add	w9, w4, #0x7
and	x9, x9, #0xfffffffffffffff8
sub	x1, x1, x9, lsl #1
sub	x8, x8, x9, lsl #1
mov	w9, w4
b.lt	L_1588
L_14f0:
ld1	{ v0.8h }, [x0]
ld1	{ v16.8h }, [x10]
ld1	{ v1.8h }, [x2], #16
ld1	{ v17.8h }, [x12], #16
ld1	{ v2.8h }, [x3], #16
ld1	{ v18.8h }, [x13], #16
subs	w4, w4, #0x8
smull	v3.4s, v1.4h, v30.4h
smlal	v3.4s, v2.4h, v31.4h
smull2	v4.4s, v1.8h, v30.8h
smlal2	v4.4s, v2.8h, v31.8h
smull	v19.4s, v17.4h, v30.4h
smlal	v19.4s, v18.4h, v31.4h
smull2	v20.4s, v17.8h, v30.8h
smlal2	v20.4s, v18.8h, v31.8h
rshrn	v3.4h, v3.4s, #0xb
rshrn2	v3.8h, v4.4s, #0xb
rshrn	v19.4h, v19.4s, #0xb
rshrn2	v19.8h, v20.4s, #0xb
usqadd	v0.8h, v3.8h
usqadd	v16.8h, v19.8h
umin	v3.8h, v0.8h, v29.8h
umin	v19.8h, v16.8h, v29.8h
st1	{ v3.8h }, [x0], #16
st1	{ v19.8h }, [x10], #16
b.gt	L_14f0
subs	w5, w5, #0x2
cmp	w5, #0x1
b.lt	L_15c0
mov	w4, w9
add	x0, x0, x1
add	x10, x10, x1
add	x2, x2, x8
add	x12, x12, x8
add	x3, x3, x8
add	x13, x13, x8
b.eq	L_1588
b	L_14f0
L_1588:
ld1	{ v0.8h }, [x0]
ld1	{ v1.8h }, [x2], #16
ld1	{ v2.8h }, [x3], #16
subs	w4, w4, #0x8
smull	v3.4s, v1.4h, v30.4h
smlal	v3.4s, v2.4h, v31.4h
smull2	v4.4s, v1.8h, v30.8h
smlal2	v4.4s, v2.8h, v31.8h
rshrn	v3.4h, v3.4s, #0xb
rshrn2	v3.8h, v4.4s, #0xb
usqadd	v0.8h, v3.8h
umin	v3.8h, v0.8h, v29.8h
st1	{ v3.8h }, [x0], #16
b.gt	L_1588
L_15c0:
ret
	.section .rodata
right_ext_mask_buf:
	.size right_ext_mask_buf, 96
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
right_ext_mask:
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255

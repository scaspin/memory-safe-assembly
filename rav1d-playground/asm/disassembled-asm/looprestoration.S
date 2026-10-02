	.text
wiener_filter7_8bpc_neon:
stp	x29, x30, [sp, #-0x10]!
mov	x29, sp
ld1	{ v0.8h, v1.8h }, [x6]
tst	w7, #0x4
sub	sp, sp, #0x1, lsl #12
sub	sp, sp, #0x200
mov	w17, #0x3ffc
dup	v30.8h, w17
movi	v31.8h, #0x8, lsl #8
mov	x14, sp
b.eq	L_e4
mov	x16, x2
mov	x2, #0x0
bl	wiener_filter7_h_8bpc_neon
add	x3, x3, x1
mov	x9, x14
mov	x10, x14
add	x14, x14, #0x300
bl	wiener_filter7_h_8bpc_neon
add	x3, x3, x1, lsl #2
add	x3, x3, x1
mov	x11, x14
add	x14, x14, #0x300
mov	x2, x16
mov	x16, x3
mov	x3, x0
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #0x1
mov	x12, x14
mov	x13, x14
b.eq	L_d4
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_8bpc_neon
mov	x13, x14
subs	w5, w5, #0x1
b.eq	L_164
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #0x1
b.eq	L_160
add	x3, x3, x1
L_ac:
add	x15, x14, #0x300
L_b0:
bl	wiener_filter7_hv_8bpc_neon
subs	w5, w5, #0x1
b.ne	L_b0
tst	w7, #0x8
b.eq	L_160
mov	x3, x16
mov	x2, #0x0
bl	wiener_filter7_hv_8bpc_neon
bl	wiener_filter7_hv_8bpc_neon
L_d4:
bl	wiener_filter7_v_8bpc_neon
mov	sp, x29
ldp	x29, x30, [sp], #0x10
ret
L_e4:
add	x3, x3, x1, lsl #2
add	x16, x3, x1, lsl #1
mov	x3, x0
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #0x1
mov	x9, x14
mov	x10, x14
mov	x11, x14
mov	x12, x14
mov	x13, x14
b.eq	L_d4
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #0x1
mov	x13, x14
b.eq	L_164
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter7_h_8bpc_neon
subs	w5, w5, #0x1
b.eq	L_160
add	x3, x3, x1
add	x15, x14, #0x300
bl	wiener_filter7_hv_8bpc_neon
subs	w5, w5, #0x1
b.eq	L_160
add	x15, x15, #0xc00
bl	wiener_filter7_hv_8bpc_neon
subs	w5, w5, #0x1
b.ne	L_ac
L_160:
bl	wiener_filter7_v_8bpc_neon
L_164:
bl	wiener_filter7_v_8bpc_neon
b	L_d4
wiener_filter7_h_8bpc_neon:
stp	x3, x4, [sp, #-0x20]!
str	x14, [sp, #0x10]
tst	w7, #0x1
b.eq	L_1a0
cbnz	x2, L_18c
sub	x3, x3, #0x3
ld1	{ v3.16b }, [x3], #16
b	L_1b0
L_18c:
ld1	{ v3.16b }, [x3], #16
ld1	{ v2.s }[3], [x2], #4
sub	x3, x3, #0x3
ext	v3.16b, v2.16b, v3.16b, #0xd
b	L_1b0
L_1a0:
ld1	{ v3.16b }, [x3], #16
dup	v2.16b, v3.b[0]
sub	x3, x3, #0x3
ext	v3.16b, v2.16b, v3.16b, #0xd
L_1b0:
ld1	{ v4.8b }, [x3], #8
ushll	v2.8h, v3.8b, #0x0
ushll2	v3.8h, v3.16b, #0x0
ushll	v4.8h, v4.8b, #0x0
tst	w7, #0x2
b.ne	L_1f8
L_1c8:
cmp	w4, #0x13
b.ge	L_1f8
sub	w17, w4, #0x16
adrp	x6, right_ext_mask_buf+42
add	x6, x6, :lo12:right_ext_mask_buf+42
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup	v28.8h, v28.h[0]
ld1	{ v25.16b, v26.16b, v27.16b }, [x6]
bit	v2.16b, v28.16b, v25.16b
bit	v3.16b, v28.16b, v26.16b
bit	v4.16b, v28.16b, v27.16b
L_1f8:
ext	v17.16b, v2.16b, v3.16b, #0x4
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v20.16b, v2.16b, v3.16b, #0xa
ext	v21.16b, v2.16b, v3.16b, #0xc
ext	v18.16b, v2.16b, v3.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v2.8h
shl	v22.8h, v18.8h, #0x7
mul	v6.8h, v18.8h, v0.h[3]
mla	v6.8h, v19.8h, v0.h[4]
mla	v6.8h, v20.8h, v0.h[5]
mla	v6.8h, v21.8h, v0.h[6]
ext	v17.16b, v3.16b, v4.16b, #0x4
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v20.16b, v3.16b, v4.16b, #0xa
ext	v21.16b, v3.16b, v4.16b, #0xc
ext	v18.16b, v3.16b, v4.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v3.8h
shl	v23.8h, v18.8h, #0x7
mul	v7.8h, v18.8h, v0.h[3]
mla	v7.8h, v19.8h, v0.h[4]
mla	v7.8h, v20.8h, v0.h[5]
mla	v7.8h, v21.8h, v0.h[6]
sub	v22.8h, v22.8h, v30.8h
sub	v23.8h, v23.8h, v30.8h
sqadd	v6.8h, v6.8h, v22.8h
sqadd	v7.8h, v7.8h, v23.8h
sshr	v6.8h, v6.8h, #0x3
sshr	v7.8h, v7.8h, #0x3
add	v6.8h, v6.8h, v31.8h
add	v7.8h, v7.8h, v31.8h
subs	w4, w4, #0x10
st1	{ v6.8h, v7.8h }, [x14], #32
b.le	L_2b0
mov	v2.16b, v4.16b
ld1	{ v4.16b }, [x3], #16
tst	w7, #0x2
ushll	v3.8h, v4.8b, #0x0
ushll2	v4.8h, v4.16b, #0x0
b.ne	L_1f8
b	L_1c8
L_2b0:
ldr	x14, [sp, #0x10]
ldp	x3, x4, [sp], #0x20
ret
wiener_filter7_v_8bpc_neon:
stp	x10, x11, [sp, #-0x40]!
stp	x12, x13, [sp, #0x10]
stp	x14, x14, [sp, #0x20]
stp	x0, x4, [sp, #0x30]
L_2cc:
ld1	{ v20.8h, v21.8h }, [x11], #32
ld1	{ v24.8h, v25.8h }, [x13], #32
ld1	{ v18.8h, v19.8h }, [x10], #32
add	v24.8h, v24.8h, v20.8h
ld1	{ v26.8h, v27.8h }, [x14], #32
ld1	{ v16.8h, v17.8h }, [x9], #32
add	v28.8h, v26.8h, v18.8h
ld1	{ v22.8h, v23.8h }, [x12], #32
add	v16.8h, v26.8h, v16.8h
add	v25.8h, v25.8h, v21.8h
smull	v2.4s, v22.4h, v1.h[3]
smlal	v2.4s, v24.4h, v1.h[4]
smlal	v2.4s, v28.4h, v1.h[5]
smlal	v2.4s, v16.4h, v1.h[6]
add	v29.8h, v27.8h, v19.8h
smull2	v3.4s, v22.8h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[4]
smlal2	v3.4s, v28.8h, v1.h[5]
smlal2	v3.4s, v16.8h, v1.h[6]
add	v17.8h, v27.8h, v17.8h
smull	v4.4s, v23.4h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[4]
smlal	v4.4s, v29.4h, v1.h[5]
smlal	v4.4s, v17.4h, v1.h[6]
smull2	v5.4s, v23.8h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[4]
smlal2	v5.4s, v29.8h, v1.h[5]
smlal2	v5.4s, v17.8h, v1.h[6]
sqrshrun	v2.4h, v2.4s, #0xb
sqrshrun2	v2.8h, v3.4s, #0xb
sqrshrun	v3.4h, v4.4s, #0xb
sqrshrun2	v3.8h, v5.4s, #0xb
sqxtun	v2.8b, v2.8h
sqxtun2	v2.16b, v3.8h
subs	w4, w4, #0x10
st1	{ v2.16b }, [x0], #16
b.gt	L_2cc
ldp	x0, x4, [sp, #0x30]
ldp	x13, x14, [sp, #0x20]
ldp	x11, x12, [sp, #0x10]
ldp	x9, x10, [sp], #0x40
add	x0, x0, x1
ret
wiener_filter7_hv_8bpc_neon:
stp	x10, x11, [sp, #-0x50]!
stp	x12, x13, [sp, #0x10]
stp	x14, x15, [sp, #0x20]
stp	x10, x0, [sp, #0x30]
stp	x3, x4, [sp, #0x40]
tst	w7, #0x1
b.eq	L_3b8
cbnz	x2, L_3a4
sub	x3, x3, #0x3
ld1	{ v3.16b }, [x3], #16
b	L_3c8
L_3a4:
ld1	{ v3.16b }, [x3], #16
ld1	{ v2.s }[3], [x2], #4
sub	x3, x3, #0x3
ext	v3.16b, v2.16b, v3.16b, #0xd
b	L_3c8
L_3b8:
ld1	{ v3.16b }, [x3], #16
dup	v2.16b, v3.b[0]
sub	x3, x3, #0x3
ext	v3.16b, v2.16b, v3.16b, #0xd
L_3c8:
ld1	{ v4.8b }, [x3], #8
ushll	v2.8h, v3.8b, #0x0
ushll2	v3.8h, v3.16b, #0x0
ushll	v4.8h, v4.8b, #0x0
tst	w7, #0x2
b.ne	L_410
L_3e0:
cmp	w4, #0x13
b.ge	L_410
sub	w17, w4, #0x16
adrp	x6, right_ext_mask_buf+42
add	x6, x6, :lo12:right_ext_mask_buf+42
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup	v28.8h, v28.h[0]
ld1	{ v25.16b, v26.16b, v27.16b }, [x6]
bit	v2.16b, v28.16b, v25.16b
bit	v3.16b, v28.16b, v26.16b
bit	v4.16b, v28.16b, v27.16b
L_410:
ext	v17.16b, v2.16b, v3.16b, #0x4
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v20.16b, v2.16b, v3.16b, #0xa
ext	v21.16b, v2.16b, v3.16b, #0xc
ext	v18.16b, v2.16b, v3.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v2.8h
shl	v22.8h, v18.8h, #0x7
mul	v6.8h, v18.8h, v0.h[3]
mla	v6.8h, v19.8h, v0.h[4]
mla	v6.8h, v20.8h, v0.h[5]
mla	v6.8h, v21.8h, v0.h[6]
ext	v17.16b, v3.16b, v4.16b, #0x4
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v20.16b, v3.16b, v4.16b, #0xa
ext	v21.16b, v3.16b, v4.16b, #0xc
ext	v18.16b, v3.16b, v4.16b, #0x6
add	v19.8h, v19.8h, v17.8h
add	v20.8h, v20.8h, v16.8h
add	v21.8h, v21.8h, v3.8h
shl	v23.8h, v18.8h, #0x7
mul	v7.8h, v18.8h, v0.h[3]
mla	v7.8h, v19.8h, v0.h[4]
mla	v7.8h, v20.8h, v0.h[5]
mla	v7.8h, v21.8h, v0.h[6]
ld1	{ v20.8h, v21.8h }, [x11], #32
sub	v22.8h, v22.8h, v30.8h
sub	v23.8h, v23.8h, v30.8h
ld1	{ v26.8h, v27.8h }, [x13], #32
sqadd	v6.8h, v6.8h, v22.8h
sqadd	v7.8h, v7.8h, v23.8h
ld1	{ v18.8h, v19.8h }, [x10], #32
sshr	v6.8h, v6.8h, #0x3
sshr	v7.8h, v7.8h, #0x3
ld1	{ v28.8h, v29.8h }, [x14], #32
add	v6.8h, v6.8h, v31.8h
add	v7.8h, v7.8h, v31.8h
ld1	{ v16.8h, v17.8h }, [x9], #32
add	v26.8h, v20.8h, v26.8h
ld1	{ v24.8h, v25.8h }, [x12], #32
add	v28.8h, v18.8h, v28.8h
add	v16.8h, v16.8h, v6.8h
add	v27.8h, v21.8h, v27.8h
smull	v18.4s, v24.4h, v1.h[3]
smlal	v18.4s, v26.4h, v1.h[4]
smlal	v18.4s, v28.4h, v1.h[5]
smlal	v18.4s, v16.4h, v1.h[6]
add	v29.8h, v19.8h, v29.8h
smull2	v19.4s, v24.8h, v1.h[3]
smlal2	v19.4s, v26.8h, v1.h[4]
smlal2	v19.4s, v28.8h, v1.h[5]
smlal2	v19.4s, v16.8h, v1.h[6]
add	v17.8h, v17.8h, v7.8h
smull	v20.4s, v25.4h, v1.h[3]
smlal	v20.4s, v27.4h, v1.h[4]
smlal	v20.4s, v29.4h, v1.h[5]
smlal	v20.4s, v17.4h, v1.h[6]
smull2	v21.4s, v25.8h, v1.h[3]
smlal2	v21.4s, v27.8h, v1.h[4]
smlal2	v21.4s, v29.8h, v1.h[5]
smlal2	v21.4s, v17.8h, v1.h[6]
sqrshrun	v18.4h, v18.4s, #0xb
sqrshrun2	v18.8h, v19.4s, #0xb
sqrshrun	v19.4h, v20.4s, #0xb
sqrshrun2	v19.8h, v21.4s, #0xb
st1	{ v6.8h, v7.8h }, [x15], #32
sqxtun	v18.8b, v18.8h
sqxtun2	v18.16b, v19.8h
subs	w4, w4, #0x10
st1	{ v18.16b }, [x0], #16
b.le	L_554
mov	v2.16b, v4.16b
ld1	{ v4.16b }, [x3], #16
tst	w7, #0x2
ushll	v3.8h, v4.8b, #0x0
ushll2	v4.8h, v4.16b, #0x0
b.ne	L_410
b	L_3e0
L_554:
ldp	x3, x4, [sp, #0x40]
ldp	x15, x0, [sp, #0x30]
ldp	x13, x14, [sp, #0x20]
ldp	x11, x12, [sp, #0x10]
ldp	x9, x10, [sp], #0x50
add	x3, x3, x1
add	x0, x0, x1
ret
wiener_filter5_8bpc_neon:
stp	x29, x30, [sp, #-0x10]!
mov	x29, sp
ld1	{ v0.8h, v1.8h }, [x6]
tst	w7, #0x4
sub	sp, sp, #0xc00
mov	w17, #0x3ffc
dup	v30.8h, w17
movi	v31.8h, #0x8, lsl #8
mov	x14, sp
b.eq	L_630
mov	x16, x2
mov	x2, #0x0
bl	wiener_filter5_h_8bpc_neon
add	x3, x3, x1
mov	x11, x14
add	x14, x14, #0x300
bl	wiener_filter5_h_8bpc_neon
add	x3, x3, x1, lsl #2
add	x3, x3, x1
mov	x12, x14
add	x14, x14, #0x300
mov	x2, x16
mov	x16, x3
mov	x3, x0
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #0x1
mov	x13, x14
b.eq	L_6a0
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #0x1
b.eq	L_68c
add	x3, x3, x1
L_5fc:
mov	x15, x11
L_600:
bl	wiener_filter5_hv_8bpc_neon
subs	w5, w5, #0x1
b.ne	L_600
tst	w7, #0x8
b.eq	L_68c
mov	x3, x16
mov	x2, #0x0
bl	wiener_filter5_hv_8bpc_neon
bl	wiener_filter5_hv_8bpc_neon
L_624:
mov	sp, x29
ldp	x29, x30, [sp], #0x10
ret
L_630:
add	x3, x3, x1, lsl #2
add	x16, x3, x1, lsl #1
mov	x3, x0
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #0x1
mov	x11, x14
mov	x12, x14
mov	x13, x14
b.eq	L_6a0
add	x3, x3, x1
add	x14, x14, #0x300
bl	wiener_filter5_h_8bpc_neon
subs	w5, w5, #0x1
b.eq	L_68c
add	x3, x3, x1
add	x15, x14, #0x300
bl	wiener_filter5_hv_8bpc_neon
subs	w5, w5, #0x1
b.eq	L_68c
add	x15, x15, #0x900
bl	wiener_filter5_hv_8bpc_neon
subs	w5, w5, #0x1
b.ne	L_5fc
L_68c:
bl	wiener_filter5_v_8bpc_neon
add	x0, x0, x1
mov	x11, x12
mov	x12, x13
mov	x13, x14
L_6a0:
bl	wiener_filter5_v_8bpc_neon
b	L_624
wiener_filter5_h_8bpc_neon:
stp	x3, x4, [sp, #-0x20]!
str	x14, [sp, #0x10]
tst	w7, #0x1
b.eq	L_6dc
cbnz	x2, L_6c8
sub	x3, x3, #0x2
ld1	{ v3.16b }, [x3], #16
b	L_6ec
L_6c8:
ld1	{ v3.16b }, [x3], #16
ld1	{ v2.s }[3], [x2], #4
sub	x3, x3, #0x2
ext	v3.16b, v2.16b, v3.16b, #0xe
b	L_6ec
L_6dc:
ld1	{ v3.16b }, [x3], #16
dup	v2.16b, v3.b[0]
sub	x3, x3, #0x2
ext	v3.16b, v2.16b, v3.16b, #0xe
L_6ec:
ld1	{ v4.8b }, [x3], #8
ushll	v2.8h, v3.8b, #0x0
ushll2	v3.8h, v3.16b, #0x0
ushll	v4.8h, v4.8b, #0x0
tst	w7, #0x2
b.ne	L_734
L_704:
cmp	w4, #0x12
b.ge	L_734
sub	w17, w4, #0x17
adrp	x6, right_ext_mask_buf+44
add	x6, x6, :lo12:right_ext_mask_buf+44
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup	v28.8h, v28.h[0]
ld1	{ v25.16b, v26.16b, v27.16b }, [x6]
bit	v2.16b, v28.16b, v25.16b
bit	v3.16b, v28.16b, v26.16b
bit	v4.16b, v28.16b, v27.16b
L_734:
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v18.16b, v2.16b, v3.16b, #0x6
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v17.16b, v2.16b, v3.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v2.8h
shl	v22.8h, v17.8h, #0x7
mul	v6.8h, v17.8h, v0.h[3]
mla	v6.8h, v18.8h, v0.h[4]
mla	v6.8h, v19.8h, v0.h[5]
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v18.16b, v3.16b, v4.16b, #0x6
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v17.16b, v3.16b, v4.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v3.8h
shl	v23.8h, v17.8h, #0x7
mul	v7.8h, v17.8h, v0.h[3]
mla	v7.8h, v18.8h, v0.h[4]
mla	v7.8h, v19.8h, v0.h[5]
sub	v22.8h, v22.8h, v30.8h
sub	v23.8h, v23.8h, v30.8h
sqadd	v6.8h, v6.8h, v22.8h
sqadd	v7.8h, v7.8h, v23.8h
sshr	v6.8h, v6.8h, #0x3
sshr	v7.8h, v7.8h, #0x3
add	v6.8h, v6.8h, v31.8h
add	v7.8h, v7.8h, v31.8h
subs	w4, w4, #0x10
st1	{ v6.8h, v7.8h }, [x14], #32
b.le	L_7cc
mov	v2.16b, v4.16b
ld1	{ v4.16b }, [x3], #16
tst	w7, #0x2
ushll	v3.8h, v4.8b, #0x0
ushll2	v4.8h, v4.16b, #0x0
b.ne	L_734
b	L_704
L_7cc:
ldr	x14, [sp, #0x10]
ldp	x3, x4, [sp], #0x20
ret
wiener_filter5_v_8bpc_neon:
stp	x11, x12, [sp, #-0x30]!
stp	x13, x14, [sp, #0x10]
stp	x0, x4, [sp, #0x20]
L_7e4:
ld1	{ v18.8h, v19.8h }, [x12], #32
ld1	{ v22.8h, v23.8h }, [x14], #32
ld1	{ v16.8h, v17.8h }, [x11], #32
add	v24.8h, v22.8h, v18.8h
ld1	{ v20.8h, v21.8h }, [x13], #32
add	v16.8h, v22.8h, v16.8h
add	v25.8h, v23.8h, v19.8h
smull	v2.4s, v20.4h, v1.h[3]
smlal	v2.4s, v24.4h, v1.h[4]
smlal	v2.4s, v16.4h, v1.h[5]
add	v17.8h, v23.8h, v17.8h
smull2	v3.4s, v20.8h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[4]
smlal2	v3.4s, v16.8h, v1.h[5]
smull	v4.4s, v21.4h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[4]
smlal	v4.4s, v17.4h, v1.h[5]
smull2	v5.4s, v21.8h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[4]
smlal2	v5.4s, v17.8h, v1.h[5]
sqrshrun	v2.4h, v2.4s, #0xb
sqrshrun2	v2.8h, v3.4s, #0xb
sqrshrun	v3.4h, v4.4s, #0xb
sqrshrun2	v3.8h, v5.4s, #0xb
sqxtun	v2.8b, v2.8h
sqxtun2	v2.16b, v3.8h
subs	w4, w4, #0x10
st1	{ v2.16b }, [x0], #16
b.gt	L_7e4
ldp	x0, x4, [sp, #0x20]
ldp	x13, x14, [sp, #0x10]
ldp	x11, x12, [sp], #0x30
ret
wiener_filter5_hv_8bpc_neon:
stp	x12, x13, [sp, #-0x40]!
stp	x14, x15, [sp, #0x10]
stp	x12, x0, [sp, #0x20]
stp	x3, x4, [sp, #0x30]
tst	w7, #0x1
b.eq	L_8a4
cbnz	x2, L_890
sub	x3, x3, #0x2
ld1	{ v3.16b }, [x3], #16
b	L_8b4
L_890:
ld1	{ v3.16b }, [x3], #16
ld1	{ v2.s }[3], [x2], #4
sub	x3, x3, #0x2
ext	v3.16b, v2.16b, v3.16b, #0xe
b	L_8b4
L_8a4:
ld1	{ v3.16b }, [x3], #16
dup	v2.16b, v3.b[0]
sub	x3, x3, #0x2
ext	v3.16b, v2.16b, v3.16b, #0xe
L_8b4:
ld1	{ v4.8b }, [x3], #8
ushll	v2.8h, v3.8b, #0x0
ushll2	v3.8h, v3.16b, #0x0
ushll	v4.8h, v4.8b, #0x0
tst	w7, #0x2
b.ne	L_8fc
L_8cc:
cmp	w4, #0x12
b.ge	L_8fc
sub	w17, w4, #0x17
adrp	x6, right_ext_mask_buf+44
add	x6, x6, :lo12:right_ext_mask_buf+44
ldr	b28, [x3, w17, sxtw]
sub	x6, x6, w4, uxtw #1
dup	v28.8h, v28.h[0]
ld1	{ v25.16b, v26.16b, v27.16b }, [x6]
bit	v2.16b, v28.16b, v25.16b
bit	v3.16b, v28.16b, v26.16b
bit	v4.16b, v28.16b, v27.16b
L_8fc:
ext	v16.16b, v2.16b, v3.16b, #0x2
ext	v18.16b, v2.16b, v3.16b, #0x6
ext	v19.16b, v2.16b, v3.16b, #0x8
ext	v17.16b, v2.16b, v3.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v2.8h
shl	v22.8h, v17.8h, #0x7
mul	v6.8h, v17.8h, v0.h[3]
mla	v6.8h, v18.8h, v0.h[4]
mla	v6.8h, v19.8h, v0.h[5]
ext	v16.16b, v3.16b, v4.16b, #0x2
ext	v18.16b, v3.16b, v4.16b, #0x6
ext	v19.16b, v3.16b, v4.16b, #0x8
ext	v17.16b, v3.16b, v4.16b, #0x4
add	v18.8h, v18.8h, v16.8h
add	v19.8h, v19.8h, v3.8h
shl	v23.8h, v17.8h, #0x7
mul	v7.8h, v17.8h, v0.h[3]
mla	v7.8h, v18.8h, v0.h[4]
mla	v7.8h, v19.8h, v0.h[5]
ld1	{ v18.8h, v19.8h }, [x12], #32
sub	v22.8h, v22.8h, v30.8h
sub	v23.8h, v23.8h, v30.8h
ld1	{ v24.8h, v25.8h }, [x14], #32
sqadd	v6.8h, v6.8h, v22.8h
sqadd	v7.8h, v7.8h, v23.8h
ld1	{ v16.8h, v17.8h }, [x11], #32
sshr	v6.8h, v6.8h, #0x3
sshr	v7.8h, v7.8h, #0x3
ld1	{ v20.8h, v21.8h }, [x13], #32
add	v6.8h, v6.8h, v31.8h
add	v7.8h, v7.8h, v31.8h
add	v24.8h, v24.8h, v18.8h
add	v16.8h, v16.8h, v6.8h
smull	v18.4s, v20.4h, v1.h[3]
smlal	v18.4s, v24.4h, v1.h[4]
smlal	v18.4s, v16.4h, v1.h[5]
add	v25.8h, v25.8h, v19.8h
smull2	v19.4s, v20.8h, v1.h[3]
smlal2	v19.4s, v24.8h, v1.h[4]
smlal2	v19.4s, v16.8h, v1.h[5]
add	v17.8h, v17.8h, v7.8h
smull	v20.4s, v21.4h, v1.h[3]
smlal	v20.4s, v25.4h, v1.h[4]
smlal	v20.4s, v17.4h, v1.h[5]
smull2	v21.4s, v21.8h, v1.h[3]
smlal2	v21.4s, v25.8h, v1.h[4]
smlal2	v21.4s, v17.8h, v1.h[5]
sqrshrun	v18.4h, v18.4s, #0xb
sqrshrun2	v18.8h, v19.4s, #0xb
sqrshrun	v19.4h, v20.4s, #0xb
sqrshrun2	v19.8h, v21.4s, #0xb
st1	{ v6.8h, v7.8h }, [x15], #32
sqxtun	v18.8b, v18.8h
sqxtun2	v18.16b, v19.8h
subs	w4, w4, #0x10
st1	{ v18.16b }, [x0], #16
b.le	L_a00
mov	v2.16b, v4.16b
ld1	{ v4.16b }, [x3], #16
tst	w7, #0x2
ushll	v3.8h, v4.8b, #0x0
ushll2	v4.8h, v4.16b, #0x0
b.ne	L_8fc
b	L_8cc
L_a00:
ldp	x3, x4, [sp, #0x30]
ldp	x15, x0, [sp, #0x20]
ldp	x13, x14, [sp, #0x10]
ldp	x11, x12, [sp], #0x40
add	x3, x3, x1
add	x0, x0, x1
ret
sgr_box3_row_h_8bpc_neon:
add	w4, w4, #0x2
tst	w5, #0x1
b.eq	L_a4c
cbnz	x2, L_a38
sub	x3, x3, #0x2
ld1	{ v0.16b }, [x3], #16
b	L_a5c
L_a38:
ld1	{ v0.16b }, [x3], #16
ld1	{ v1.s }[3], [x2]
sub	x3, x3, #0x2
ext	v0.16b, v1.16b, v0.16b, #0xe
b	L_a5c
L_a4c:
ld1	{ v0.16b }, [x3], #16
dup	v1.16b, v0.b[0]
sub	x3, x3, #0x2
ext	v0.16b, v1.16b, v0.16b, #0xe
L_a5c:
umull	v1.8h, v0.8b, v0.8b
umull2	v2.8h, v0.16b, v0.16b
tst	w5, #0x2
b.ne	L_a9c
sub	w13, w4, #0x11
ldr	b30, [x3, w13, sxtw]
dup	v30.16b, v30.b[0]
L_a78:
cmp	w4, #0xa
b.ge	L_a9c
adrp	x13, right_ext_mask
add	x13, x13, :lo12:right_ext_mask
sub	x13, x13, w4, uxtw
ld1	{ v29.16b }, [x13]
bit	v0.16b, v30.16b, v29.16b
umull	v1.8h, v0.8b, v0.8b
umull2	v2.8h, v0.16b, v0.16b
L_a9c:
ext	v16.16b, v0.16b, v0.16b, #0x1
ext	v17.16b, v0.16b, v0.16b, #0x2
uaddl	v3.8h, v0.8b, v16.8b
ext	v20.16b, v1.16b, v2.16b, #0x2
uaddw	v3.8h, v3.8h, v17.8b
ext	v21.16b, v1.16b, v2.16b, #0x4
uaddl	v26.4s, v1.4h, v20.4h
uaddl2	v27.4s, v1.8h, v20.8h
uaddw	v26.4s, v26.4s, v21.4h
uaddw2	v27.4s, v27.4s, v21.8h
subs	w4, w4, #0x8
st1	{ v3.8h }, [x1], #16
st1	{ v26.4s, v27.4s }, [x0], #32
b.le	L_af0
tst	w5, #0x2
ld1	{ v3.8b }, [x3], #8
mov	v1.16b, v2.16b
ext	v0.16b, v0.16b, v3.16b, #0x8
umull	v2.8h, v3.8b, v3.8b
b.ne	L_a9c
b	L_a78
L_af0:
ret
sgr_box5_row_h_8bpc_neon:
add	w4, w4, #0x2
tst	w5, #0x1
b.eq	L_b24
cbnz	x2, L_b10
sub	x3, x3, #0x3
ld1	{ v0.16b }, [x3], #16
b	L_b34
L_b10:
ld1	{ v0.16b }, [x3], #16
ld1	{ v1.s }[3], [x2], #4
sub	x3, x3, #0x3
ext	v0.16b, v1.16b, v0.16b, #0xd
b	L_b34
L_b24:
ld1	{ v0.16b }, [x3], #16
dup	v1.16b, v0.b[0]
sub	x3, x3, #0x3
ext	v0.16b, v1.16b, v0.16b, #0xd
L_b34:
umull	v1.8h, v0.8b, v0.8b
umull2	v2.8h, v0.16b, v0.16b
tst	w5, #0x2
b.ne	L_b74
sub	w13, w4, #0x10
ldr	b30, [x3, w13, sxtw]
dup	v30.16b, v30.b[0]
L_b50:
cmp	w4, #0xb
b.ge	L_b74
adrp	x13, right_ext_mask_buf+47
add	x13, x13, :lo12:right_ext_mask_buf+47
sub	x13, x13, w4, uxtw
ld1	{ v29.16b }, [x13]
bit	v0.16b, v30.16b, v29.16b
umull	v1.8h, v0.8b, v0.8b
umull2	v2.8h, v0.16b, v0.16b
L_b74:
ext	v16.16b, v0.16b, v0.16b, #0x1
ext	v17.16b, v0.16b, v0.16b, #0x2
ext	v18.16b, v0.16b, v0.16b, #0x3
ext	v19.16b, v0.16b, v0.16b, #0x4
uaddl	v3.8h, v0.8b, v16.8b
uaddl	v24.8h, v17.8b, v18.8b
uaddw	v3.8h, v3.8h, v19.8b
add	v3.8h, v3.8h, v24.8h
ext	v16.16b, v1.16b, v2.16b, #0x2
ext	v17.16b, v1.16b, v2.16b, #0x4
ext	v18.16b, v1.16b, v2.16b, #0x6
ext	v19.16b, v1.16b, v2.16b, #0x8
uaddl	v26.4s, v1.4h, v16.4h
uaddl2	v27.4s, v1.8h, v16.8h
uaddl	v16.4s, v17.4h, v18.4h
uaddl2	v17.4s, v17.8h, v18.8h
uaddw	v26.4s, v26.4s, v19.4h
uaddw2	v27.4s, v27.4s, v19.8h
add	v26.4s, v26.4s, v16.4s
add	v27.4s, v27.4s, v17.4s
subs	w4, w4, #0x8
st1	{ v3.8h }, [x1], #16
st1	{ v26.4s, v27.4s }, [x0], #32
b.le	L_bf0
tst	w5, #0x2
ld1	{ v3.8b }, [x3], #8
mov	v1.16b, v2.16b
ext	v0.16b, v0.16b, v3.16b, #0x8
umull	v2.8h, v3.8b, v3.8b
b.ne	L_b74
b	L_b50
L_bf0:
ret
sgr_box35_row_h_8bpc_neon:
add	w6, w6, #0x2
tst	w7, #0x1
b.eq	L_c24
cbnz	x4, L_c10
sub	x5, x5, #0x3
ld1	{ v0.16b }, [x5], #16
b	L_c34
L_c10:
ld1	{ v0.16b }, [x5], #16
ld1	{ v1.s }[3], [x4], #4
sub	x5, x5, #0x3
ext	v0.16b, v1.16b, v0.16b, #0xd
b	L_c34
L_c24:
ld1	{ v0.16b }, [x5], #16
dup	v1.16b, v0.b[0]
sub	x5, x5, #0x3
ext	v0.16b, v1.16b, v0.16b, #0xd
L_c34:
umull	v1.8h, v0.8b, v0.8b
umull2	v2.8h, v0.16b, v0.16b
tst	w7, #0x2
b.ne	L_c74
sub	w13, w6, #0x10
ldr	b30, [x5, w13, sxtw]
dup	v30.16b, v30.b[0]
L_c50:
cmp	w6, #0xb
b.ge	L_c74
adrp	x13, right_ext_mask_buf+47
add	x13, x13, :lo12:right_ext_mask_buf+47
sub	x13, x13, w6, uxtw
ld1	{ v29.16b }, [x13]
bit	v0.16b, v30.16b, v29.16b
umull	v1.8h, v0.8b, v0.8b
umull2	v2.8h, v0.16b, v0.16b
L_c74:
ext	v16.16b, v0.16b, v0.16b, #0x1
ext	v17.16b, v0.16b, v0.16b, #0x2
ext	v19.16b, v0.16b, v0.16b, #0x4
ext	v18.16b, v0.16b, v0.16b, #0x3
uaddl	v3.8h, v16.8b, v17.8b
uaddl	v24.8h, v0.8b, v19.8b
uaddw	v3.8h, v3.8h, v18.8b
ext	v16.16b, v1.16b, v2.16b, #0x2
ext	v17.16b, v1.16b, v2.16b, #0x4
ext	v19.16b, v1.16b, v2.16b, #0x8
ext	v18.16b, v1.16b, v2.16b, #0x6
st1	{ v3.8h }, [x1], #16
add	v3.8h, v3.8h, v24.8h
uaddl	v26.4s, v16.4h, v17.4h
uaddl2	v27.4s, v16.8h, v17.8h
uaddl	v16.4s, v1.4h, v19.4h
uaddl2	v17.4s, v1.8h, v19.8h
uaddw	v26.4s, v26.4s, v18.4h
uaddw2	v27.4s, v27.4s, v18.8h
st1	{ v26.4s, v27.4s }, [x0], #32
add	v26.4s, v26.4s, v16.4s
add	v27.4s, v27.4s, v17.4s
subs	w6, w6, #0x8
st1	{ v3.8h }, [x3], #16
st1	{ v26.4s, v27.4s }, [x2], #32
b.le	L_cf8
tst	w7, #0x2
ld1	{ v3.8b }, [x5], #8
mov	v1.16b, v2.16b
ext	v0.16b, v0.16b, v3.16b, #0x8
umull	v2.8h, v3.8b, v3.8b
b.ne	L_c74
b	L_c50
L_cf8:
ret
sgr_finish_filter1_2rows_8bpc_neon:
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
L_d58:
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
ld1	{ v25.8b }, [x1], #8
ld1	{ v26.8b }, [x2], #8
shl	v8.4s, v8.4s, #0x2
shl	v9.4s, v9.4s, #0x2
mla	v8.4s, v16.4s, v31.4s
mla	v9.4s, v17.4s, v31.4s
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
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
b.le	L_f14
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
b	L_d58
L_f14:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
sgr_finish_weighted1_8bpc_neon:
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
L_f60:
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
ld1	{ v19.8b }, [x0]
add	v25.4s, v25.4s, v27.4s
add	v26.4s, v26.4s, v28.4s
add	v16.4s, v16.4s, v29.4s
add	v17.4s, v17.4s, v4.4s
shl	v25.4s, v25.4s, #0x2
shl	v26.4s, v26.4s, #0x2
mla	v25.4s, v16.4s, v7.4s
mla	v26.4s, v17.4s, v7.4s
ushll	v19.8h, v19.8b, #0x0
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
sqxtun	v26.8b, v19.8h
mov	v19.16b, v21.16b
mov	v22.16b, v24.16b
st1	{ v26.8b }, [x0], #8
b.le	L_1084
ld1	{ v17.4s, v18.4s }, [x7], #32
ld1	{ v20.4s, v21.4s }, [x8], #32
ld1	{ v23.4s, v24.4s }, [x1], #32
b	L_f60
L_1084:
ret
sgr_finish_filter2_2rows_8bpc_neon:
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
L_10d4:
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
ld1	{ v31.8b }, [x1], #8
ld1	{ v30.8b }, [x2], #8
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
ushll	v31.8h, v31.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
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
b.le	L_11c8
mov	v16.16b, v18.16b
mov	v19.16b, v21.16b
ld1	{ v1.8h }, [x4], #16
ld1	{ v3.8h }, [x8], #16
ld1	{ v17.4s, v18.4s }, [x3], #32
ld1	{ v20.4s, v21.4s }, [x7], #32
b	L_10d4
L_11c8:
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret
sgr_finish_weighted2_8bpc_neon:
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
L_1224:
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
ld1	{ v31.8b }, [x0]
ld1	{ v30.8b }, [x1]
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
ushll	v31.8h, v31.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
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
sqxtun	v22.8b, v31.8h
sqxtun	v23.8b, v30.8h
st1	{ v22.8b }, [x0], #8
st1	{ v23.8b }, [x1], #8
b.le	L_1348
ld1	{ v17.4s, v18.4s }, [x2], #32
ld1	{ v20.4s, v21.4s }, [x7], #32
b	L_1224
L_1348:
ldp	d14, d15, [sp, #0x20]
ldr	d10, [sp, #0x10]
ldp	d8, d9, [sp], #0x30
ret
sgr_weighted2_8bpc_neon:
cmp	w5, #0x2
add	x10, x0, x1
add	x12, x2, #0x300
add	x13, x3, #0x300
ld2r	{ v30.8h, v31.8h }, [x6]
mov	x8, #0x600
lsl	x1, x1, #1
add	w9, w4, #0x7
and	x9, x9, #0xfffffffffffffff8
sub	x1, x1, x9
sub	x8, x8, x9, lsl #1
mov	w9, w4
b.lt	L_142c
L_138c:
ld1	{ v0.8b }, [x0]
ld1	{ v16.8b }, [x10]
ld1	{ v1.8h }, [x2], #16
ld1	{ v17.8h }, [x12], #16
ld1	{ v2.8h }, [x3], #16
ld1	{ v18.8h }, [x13], #16
subs	w4, w4, #0x8
ushll	v0.8h, v0.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
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
sqxtun	v3.8b, v0.8h
sqxtun	v19.8b, v16.8h
st1	{ v3.8b }, [x0], #8
st1	{ v19.8b }, [x10], #8
b.gt	L_138c
subs	w5, w5, #0x2
cmp	w5, #0x1
b.lt	L_1468
mov	w4, w9
add	x0, x0, x1
add	x10, x10, x1
add	x2, x2, x8
add	x12, x12, x8
add	x3, x3, x8
add	x13, x13, x8
b.eq	L_142c
b	L_138c
L_142c:
ld1	{ v0.8b }, [x0]
ld1	{ v1.8h }, [x2], #16
ld1	{ v2.8h }, [x3], #16
subs	w4, w4, #0x8
ushll	v0.8h, v0.8b, #0x0
smull	v3.4s, v1.4h, v30.4h
smlal	v3.4s, v2.4h, v31.4h
smull2	v4.4s, v1.8h, v30.8h
smlal2	v4.4s, v2.8h, v31.8h
rshrn	v3.4h, v3.4s, #0xb
rshrn2	v3.8h, v4.4s, #0xb
usqadd	v0.8h, v3.8h
sqxtun	v3.8b, v0.8h
st1	{ v3.8b }, [x0], #8
b.gt	L_142c
L_1468:
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

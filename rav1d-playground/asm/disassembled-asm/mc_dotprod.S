	.text
prep_8tap_sharp_8bpc_neon_dotprod:
mov	x9, #0xeac
mov	x10, #0xeac
b	prep_8tap_neon_dotprod
prep_8tap_sharp_smooth_8bpc_neon_dotprod:
mov	x9, #0xeac
mov	x10, #0x73b
b	prep_8tap_neon_dotprod
prep_8tap_sharp_regular_8bpc_neon_dotprod:
mov	x9, #0xeac
mov	x10, #-0x54
b	prep_8tap_neon_dotprod
prep_8tap_smooth_sharp_8bpc_neon_dotprod:
mov	x9, #0x73b
mov	x10, #0xeac
b	prep_8tap_neon_dotprod
prep_8tap_smooth_8bpc_neon_dotprod:
mov	x9, #0x73b
mov	x10, #0x73b
b	prep_8tap_neon_dotprod
prep_8tap_smooth_regular_8bpc_neon_dotprod:
mov	x9, #0x73b
mov	x10, #-0x54
b	prep_8tap_neon_dotprod
prep_8tap_regular_sharp_8bpc_neon_dotprod:
mov	x9, #-0x54
mov	x10, #0xeac
b	prep_8tap_neon_dotprod
prep_8tap_regular_smooth_8bpc_neon_dotprod:
mov	x9, #-0x54
mov	x10, #0x73b
b	prep_8tap_neon_dotprod
prep_8tap_regular_8bpc_neon_dotprod:
mov	x9, #-0x54
mov	x10, #-0x54
prep_8tap_neon_dotprod:
clz	w8, w3
mov	w11, #0x4081
sub	w8, w8, #0x18
adrp	x12, mc_subpel_filters
add	x12, x12, :lo12:mc_subpel_filters
cbnz	w5, L_480
cbnz	w6, L_8c
add	w7, w3, w3
b	prep_neon
L_8c:
madd	w6, w6, w11, w10
adrp	x13, v_tbl_neon_dotprod
add	x13, x13, :lo12:v_tbl_neon_dotprod
sub	x1, x1, x2
mov	w8, #0x2002
dup	v4.4s, w8
ubfx	w11, w6, #7, #7
and	w6, w6, #0x7f
ldp	q6, q28, [x13]
cmp	w4, #0x4
csel	w6, w6, w11, le
sub	x1, x1, x2, lsl #1
add	x6, x12, x6, lsl #3
ldr	q29, [x13, #0x20]
movi	v5.16b, #0x80
ldr	d7, [x6]
cmp	w3, #0x8
b.eq	L_254
b.lt	L_3a4
ldp	q30, q31, [x13, #0x30]
add	w7, w3, w3
L_e0:
mov	x6, x1
mov	x5, x0
sub	w8, w4, #0x1
ldr	q16, [x6]
ldr	q17, [x6, x2]
add	x6, x6, x2, lsl #1
ldr	q18, [x6]
ldr	q19, [x6, x2]
add	x6, x6, x2, lsl #1
zip1	v0.16b, v16.16b, v17.16b
zip2	v1.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip2	v3.16b, v18.16b, v19.16b
ldr	q20, [x6]
ldr	q21, [x6, x2]
add	x6, x6, x2, lsl #1
ldr	q22, [x6]
ldr	q23, [x6, x2]
add	x6, x6, x2, lsl #1
zip1	v18.16b, v20.16b, v21.16b
zip2	v21.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip2	v27.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v22.8h, v1.8h, v3.8h
zip2	v25.8h, v1.8h, v3.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
zip1	v23.8h, v21.8h, v27.8h
zip2	v26.8h, v21.8h, v27.8h
sub	v16.16b, v16.16b, v5.16b
sub	v19.16b, v19.16b, v5.16b
sub	v22.16b, v22.16b, v5.16b
sub	v25.16b, v25.16b, v5.16b
sub	v17.16b, v17.16b, v5.16b
sub	v20.16b, v20.16b, v5.16b
sub	v23.16b, v23.16b, v5.16b
sub	v26.16b, v26.16b, v5.16b
L_17c:
ld1	{ v27.16b }, [x6], x2
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sub	v18.16b, v27.16b, v5.16b
sub	v21.16b, v27.16b, v5.16b
sub	v24.16b, v27.16b, v5.16b
sub	v27.16b, v27.16b, v5.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v3.4s, v25.16b, v7.4b[0]
tbl	v16.16b, { v16.16b, v17.16b }, v6.16b
tbl	v19.16b, { v19.16b, v20.16b }, v6.16b
tbl	v22.16b, { v22.16b, v23.16b }, v6.16b
tbl	v25.16b, { v25.16b, v26.16b }, v6.16b
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v20.16b, v7.4b[1]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v26.16b, v7.4b[1]
tbl	v17.16b, { v17.16b, v18.16b }, v28.16b
tbl	v20.16b, { v20.16b, v21.16b }, v29.16b
tbl	v23.16b, { v23.16b, v24.16b }, v30.16b
tbl	v26.16b, { v26.16b, v27.16b }, v31.16b
subs	w8, w8, #0x1
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sshr	v0.8h, v0.8h, #0x2
sshr	v1.8h, v2.8h, #0x2
st1	{ v0.8h, v1.8h }, [x5], x7
b.gt	L_17c
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v3.4s, v25.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v20.16b, v7.4b[1]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v26.16b, v7.4b[1]
subs	w3, w3, #0x10
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sshr	v0.8h, v0.8h, #0x2
sshr	v1.8h, v2.8h, #0x2
stp	q0, q1, [x5]
add	x0, x0, #0x20
add	x1, x1, #0x10
b.gt	L_e0
ret
L_254:
ldr	d16, [x1]
ldr	d17, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d18, [x1]
ldr	d19, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d20, [x1]
ldr	d21, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d22, [x1]
ldr	d23, [x1, x2]
add	x1, x1, x2, lsl #1
subs	w4, w4, #0x2
zip1	v0.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip1	v18.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
sub	v16.16b, v16.16b, v5.16b
sub	v19.16b, v19.16b, v5.16b
sub	v17.16b, v17.16b, v5.16b
sub	v20.16b, v20.16b, v5.16b
L_2b8:
ldr	d21, [x1]
ldr	d27, [x1, x2]
add	x1, x1, x2, lsl #1
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sub	v18.16b, v21.16b, v5.16b
sub	v21.16b, v21.16b, v5.16b
sub	v24.16b, v27.16b, v5.16b
sub	v27.16b, v27.16b, v5.16b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
tbl	v16.16b, { v22.16b, v23.16b }, v6.16b
tbl	v19.16b, { v25.16b, v26.16b }, v6.16b
tbl	v17.16b, { v23.16b, v24.16b }, v28.16b
tbl	v20.16b, { v26.16b, v27.16b }, v29.16b
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v25.16b, v7.4b[0]
sdot	v3.4s, v26.16b, v7.4b[1]
subs	w4, w4, #0x2
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sshr	v0.8h, v0.8h, #0x2
sshr	v1.8h, v2.8h, #0x2
stp	q0, q1, [x0], #0x20
b.gt	L_2b8
ldr	d21, [x1]
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sub	v18.16b, v21.16b, v5.16b
sub	v21.16b, v21.16b, v5.16b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v25.16b, v7.4b[0]
sdot	v3.4s, v26.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sshr	v0.8h, v0.8h, #0x2
sshr	v1.8h, v2.8h, #0x2
stp	q0, q1, [x0]
ret
L_3a4:
ldr	s16, [x1]
ldr	s17, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s18, [x1]
ldr	s19, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s20, [x1]
ldr	s21, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s22, [x1]
ldr	s23, [x1, x2]
add	x1, x1, x2, lsl #1
subs	w4, w4, #0x2
zip1	v0.8b, v16.8b, v17.8b
zip1	v2.8b, v18.8b, v19.8b
zip1	v18.8b, v20.8b, v21.8b
zip1	v24.8b, v22.8b, v23.8b
zip1	v16.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
sub	v16.16b, v16.16b, v5.16b
sub	v17.16b, v17.16b, v5.16b
L_3f8:
ldr	s18, [x1]
ldr	s21, [x1, x2]
add	x1, x1, x2, lsl #1
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
sub	v18.16b, v18.16b, v5.16b
sub	v21.16b, v21.16b, v5.16b
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
tbl	v16.16b, { v19.16b, v20.16b }, v6.16b
tbl	v17.16b, { v20.16b, v21.16b }, v28.16b
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
subs	w4, w4, #0x2
shrn	v0.4h, v0.4s, #0x2
shrn2	v0.8h, v1.4s, #0x2
str	q0, [x0], #0x10
b.gt	L_3f8
ldr	s18, [x1]
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
sub	v18.16b, v18.16b, v5.16b
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
shrn	v0.4h, v0.4s, #0x2
shrn2	v0.8h, v1.4s, #0x2
str	q0, [x0]
ret
L_480:
madd	w5, w5, w11, w9
madd	w14, w6, w11, w10
mov	w13, #0x2002
dup	v27.4s, w13
adrp	x13, h_tbl_neon_dotprod
add	x13, x13, :lo12:h_tbl_neon_dotprod
sub	x1, x1, #0x3
ldr	q28, [x13]
ubfx	w15, w5, #7, #7
and	w5, w5, #0x7f
ubfx	w11, w14, #7, #7
and	w14, w14, #0x7f
cmp	w3, #0x4
csel	w5, w5, w15, le
add	x5, x12, x5, lsl #3
movi	v24.16b, #0x80
cbz	w6, L_858
cmp	w4, #0x4
csel	w14, w14, w11, le
sub	x1, x1, x2, lsl #1
add	x6, x12, x14, lsl #3
mov	x15, x30
ldr	d7, [x6]
sshll	v7.8h, v7.8b, #0x0
cmp	w10, #0xeac
b.ne	L_6a0
sub	x1, x1, x2
cmp	w3, #0x4
b.eq	L_5fc
ldp	q29, q30, [x13, #0x10]
ldr	d26, [x5]
add	w7, w3, w3
L_500:
mov	x6, x1
mov	x5, x0
mov	w8, w4
bl	L_788
sshr	v16.8h, v22.8h, #0x2
bl	L_788
sshr	v17.8h, v22.8h, #0x2
bl	L_788
sshr	v18.8h, v22.8h, #0x2
bl	L_788
sshr	v19.8h, v22.8h, #0x2
bl	L_788
sshr	v20.8h, v22.8h, #0x2
bl	L_788
sshr	v21.8h, v22.8h, #0x2
bl	L_788
sshr	v22.8h, v22.8h, #0x2
L_544:
ldr	q23, [x6]
add	x6, x6, x2
smull	v0.4s, v16.4h, v7.h[0]
smull2	v1.4s, v16.8h, v7.h[0]
mov	v16.16b, v17.16b
sub	v23.16b, v23.16b, v24.16b
mov	v5.16b, v27.16b
mov	v6.16b, v27.16b
smlal	v0.4s, v17.4h, v7.h[1]
smlal2	v1.4s, v17.8h, v7.h[1]
mov	v17.16b, v18.16b
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
tbl	v4.16b, { v23.16b }, v30.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal2	v1.4s, v18.8h, v7.h[2]
mov	v18.16b, v19.16b
sdot	v5.4s, v2.16b, v26.4b[0]
sdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v19.4h, v7.h[3]
smlal2	v1.4s, v19.8h, v7.h[3]
mov	v19.16b, v20.16b
sdot	v5.4s, v3.16b, v26.4b[1]
sdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v20.4h, v7.h[4]
smlal2	v1.4s, v20.8h, v7.h[4]
mov	v20.16b, v21.16b
smlal	v0.4s, v21.4h, v7.h[5]
smlal2	v1.4s, v21.8h, v7.h[5]
uzp1	v23.8h, v5.8h, v6.8h
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
smlal2	v1.4s, v22.8h, v7.h[6]
sshr	v22.8h, v23.8h, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
smlal2	v1.4s, v22.8h, v7.h[7]
rshrn	v0.4h, v0.4s, #0x6
rshrn2	v0.8h, v1.4s, #0x6
subs	w8, w8, #0x1
st1	{ v0.8h }, [x5], x7
b.gt	L_544
add	x0, x0, #0x10
add	x1, x1, #0x8
subs	w3, w3, #0x8
b.gt	L_500
ret	x15
L_5fc:
ldur	s26, [x5, #0x2]
add	x1, x1, #0x2
bl	L_7bc
shrn	v16.4h, v22.4s, #0x2
bl	L_7bc
shrn	v17.4h, v22.4s, #0x2
bl	L_7bc
shrn	v18.4h, v22.4s, #0x2
bl	L_7bc
shrn	v19.4h, v22.4s, #0x2
bl	L_7bc
shrn	v20.4h, v22.4s, #0x2
bl	L_7bc
shrn	v21.4h, v22.4s, #0x2
bl	L_7bc
shrn	v22.4h, v22.4s, #0x2
L_63c:
ld1	{ v4.8b }, [x1], x2
smull	v0.4s, v16.4h, v7.h[0]
smlal	v0.4s, v17.4h, v7.h[1]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
sub	v4.16b, v4.16b, v24.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal	v0.4s, v19.4h, v7.h[3]
tbl	v2.16b, { v4.16b }, v28.16b
mov	v5.16b, v27.16b
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[4]
smlal	v0.4s, v21.4h, v7.h[5]
sdot	v5.4s, v2.16b, v26.4b[0]
mov	v20.16b, v21.16b
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
shrn	v22.4h, v5.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
rshrn	v0.4h, v0.4s, #0x6
str	d0, [x0], #0x8
subs	w4, w4, #0x1
b.gt	L_63c
ret	x15
L_6a0:
cmp	w3, #0x4
b.eq	L_7d4
ldr	d26, [x5]
add	w7, w3, w3
ldp	q29, q30, [x13, #0x10]
L_6b4:
mov	x6, x1
mov	x5, x0
mov	w8, w4
bl	L_788
sshr	v16.8h, v22.8h, #0x2
bl	L_788
sshr	v17.8h, v22.8h, #0x2
bl	L_788
sshr	v18.8h, v22.8h, #0x2
bl	L_788
sshr	v19.8h, v22.8h, #0x2
bl	L_788
sshr	v20.8h, v22.8h, #0x2
L_6e8:
ldr	q23, [x6]
add	x6, x6, x2
smull	v0.4s, v16.4h, v7.h[1]
smull2	v1.4s, v16.8h, v7.h[1]
sub	v23.16b, v23.16b, v24.16b
mov	v16.16b, v17.16b
mov	v5.16b, v27.16b
mov	v6.16b, v27.16b
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
smlal	v0.4s, v17.4h, v7.h[2]
smlal2	v1.4s, v17.8h, v7.h[2]
tbl	v4.16b, { v23.16b }, v30.16b
mov	v17.16b, v18.16b
sdot	v5.4s, v2.16b, v26.4b[0]
sdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v18.4h, v7.h[3]
smlal2	v1.4s, v18.8h, v7.h[3]
mov	v18.16b, v19.16b
sdot	v5.4s, v3.16b, v26.4b[1]
sdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v19.4h, v7.h[4]
smlal2	v1.4s, v19.8h, v7.h[4]
mov	v19.16b, v20.16b
uzp1	v23.8h, v5.8h, v6.8h
smlal	v0.4s, v20.4h, v7.h[5]
smlal2	v1.4s, v20.8h, v7.h[5]
sshr	v20.8h, v23.8h, #0x2
subs	w8, w8, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
smlal2	v1.4s, v20.8h, v7.h[6]
rshrn	v0.4h, v0.4s, #0x6
rshrn2	v0.8h, v1.4s, #0x6
st1	{ v0.8h }, [x5], x7
b.gt	L_6e8
add	x0, x0, #0x10
add	x1, x1, #0x8
subs	w3, w3, #0x8
b.gt	L_6b4
ret	x15
L_788:
ld1	{ v4.16b }, [x6], x2
sub	v4.16b, v4.16b, v24.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v2.16b, { v4.16b }, v28.16b
tbl	v3.16b, { v4.16b }, v29.16b
tbl	v4.16b, { v4.16b }, v30.16b
sdot	v22.4s, v2.16b, v26.4b[0]
sdot	v23.4s, v3.16b, v26.4b[0]
sdot	v22.4s, v3.16b, v26.4b[1]
sdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v22.8h, v22.8h, v23.8h
ret
L_7bc:
ld1	{ v4.8b }, [x1], x2
mov	v22.16b, v27.16b
sub	v4.16b, v4.16b, v24.16b
tbl	v2.16b, { v4.16b }, v28.16b
sdot	v22.4s, v2.16b, v26.4b[0]
ret
L_7d4:
ldur	s26, [x5, #0x2]
add	x1, x1, #0x2
bl	L_7bc
shrn	v16.4h, v22.4s, #0x2
bl	L_7bc
shrn	v17.4h, v22.4s, #0x2
bl	L_7bc
shrn	v18.4h, v22.4s, #0x2
bl	L_7bc
shrn	v19.4h, v22.4s, #0x2
bl	L_7bc
shrn	v20.4h, v22.4s, #0x2
L_804:
ld1	{ v4.8b }, [x1], x2
smull	v0.4s, v16.4h, v7.h[1]
smlal	v0.4s, v17.4h, v7.h[2]
sub	v4.16b, v4.16b, v24.16b
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal	v0.4s, v19.4h, v7.h[4]
tbl	v2.16b, { v4.16b }, v28.16b
mov	v5.16b, v27.16b
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
sdot	v5.4s, v2.16b, v26.4b[0]
smlal	v0.4s, v20.4h, v7.h[5]
shrn	v20.4h, v5.4s, #0x2
subs	w4, w4, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
rshrn	v0.4h, v0.4s, #0x6
str	d0, [x0], #0x8
b.gt	L_804
ret	x15
L_858:
adrp	x11, prep_8tap_h_neon_dotprod_tbl
add	x11, x11, :lo12:prep_8tap_h_neon_dotprod_tbl
ldrsw	x8, [x11, x8, lsl #2]
add	x11, x11, x8
br	x11
L_86c:
add	x1, x1, #0x2
ldur	s26, [x5, #0x2]
L_874:
ldr	d0, [x1]
ldr	d1, [x1, x2]
add	x1, x1, x2, lsl #1
sub	v0.8b, v0.8b, v24.8b
sub	v1.8b, v1.8b, v24.8b
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
tbl	v2.16b, { v0.16b }, v28.16b
tbl	v3.16b, { v1.16b }, v28.16b
sdot	v4.4s, v2.16b, v26.4b[0]
sdot	v5.4s, v3.16b, v26.4b[0]
subs	w4, w4, #0x2
shrn	v4.4h, v4.4s, #0x2
shrn2	v4.8h, v5.4s, #0x2
str	q4, [x0], #0x10
b.gt	L_874
ret
L_8b8:
ldr	d26, [x5]
ldp	q29, q30, [x13, #0x10]
L_8c0:
ldr	q0, [x1]
ldr	q16, [x1, x2]
add	x1, x1, x2, lsl #1
sub	v0.16b, v0.16b, v24.16b
sub	v16.16b, v16.16b, v24.16b
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
mov	v20.16b, v27.16b
mov	v21.16b, v27.16b
tbl	v1.16b, { v0.16b }, v28.16b
tbl	v2.16b, { v0.16b }, v29.16b
tbl	v3.16b, { v0.16b }, v30.16b
tbl	v17.16b, { v16.16b }, v28.16b
tbl	v18.16b, { v16.16b }, v29.16b
tbl	v19.16b, { v16.16b }, v30.16b
sdot	v4.4s, v1.16b, v26.4b[0]
sdot	v5.4s, v2.16b, v26.4b[0]
sdot	v20.4s, v17.16b, v26.4b[0]
sdot	v21.4s, v18.16b, v26.4b[0]
sdot	v4.4s, v2.16b, v26.4b[1]
sdot	v5.4s, v3.16b, v26.4b[1]
sdot	v20.4s, v18.16b, v26.4b[1]
sdot	v21.4s, v19.16b, v26.4b[1]
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v20.8h, v20.8h, v21.8h
sshr	v4.8h, v4.8h, #0x2
sshr	v20.8h, v20.8h, #0x2
subs	w4, w4, #0x2
stp	q4, q20, [x0], #0x20
b.gt	L_8c0
ret
L_93c:
ldr	d26, [x5]
ldp	q29, q30, [x13, #0x10]
L_944:
ldr	q16, [x1]
ldur	q17, [x1, #0xc]
add	x1, x1, x2
sub	v16.16b, v16.16b, v24.16b
sub	v17.16b, v17.16b, v24.16b
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
sdot	v6.4s, v0.16b, v26.4b[0]
sdot	v7.4s, v1.16b, v26.4b[0]
sdot	v22.4s, v2.16b, v26.4b[0]
sdot	v23.4s, v3.16b, v26.4b[0]
sdot	v6.4s, v1.16b, v26.4b[1]
sdot	v7.4s, v2.16b, v26.4b[1]
sdot	v22.4s, v3.16b, v26.4b[1]
sdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sshr	v6.8h, v6.8h, #0x2
sshr	v22.8h, v22.8h, #0x2
subs	w4, w4, #0x1
stp	q6, q22, [x0], #0x20
b.gt	L_944
ret
L_9bc:
ldr	d26, [x5]
sub	x2, x2, w3, uxtw
mov	w8, w3
ldp	q29, q30, [x13, #0x10]
L_9cc:
ldr	q16, [x1]
ldur	q17, [x1, #0xc]
add	x1, x1, #0x10
sub	v16.16b, v16.16b, v24.16b
sub	v17.16b, v17.16b, v24.16b
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
sdot	v6.4s, v0.16b, v26.4b[0]
sdot	v7.4s, v1.16b, v26.4b[0]
sdot	v22.4s, v2.16b, v26.4b[0]
sdot	v23.4s, v3.16b, v26.4b[0]
sdot	v6.4s, v1.16b, v26.4b[1]
sdot	v7.4s, v2.16b, v26.4b[1]
sdot	v22.4s, v3.16b, v26.4b[1]
sdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sshr	v6.8h, v6.8h, #0x2
sshr	v22.8h, v22.8h, #0x2
subs	w8, w8, #0x10
stp	q6, q22, [x0], #0x20
b.gt	L_9cc
add	x1, x1, x2
mov	w8, w3
subs	w4, w4, #0x1
b.gt	L_9cc
ret
put_8tap_sharp_8bpc_neon_dotprod:
mov	x9, #0xeac
mov	x10, #0xeac
b	put_8tap_neon_dotprod
put_8tap_sharp_smooth_8bpc_neon_dotprod:
mov	x9, #0xeac
mov	x10, #0x73b
b	put_8tap_neon_dotprod
put_8tap_sharp_regular_8bpc_neon_dotprod:
mov	x9, #0xeac
mov	x10, #-0x54
b	put_8tap_neon_dotprod
put_8tap_smooth_sharp_8bpc_neon_dotprod:
mov	x9, #0x73b
mov	x10, #0xeac
b	put_8tap_neon_dotprod
put_8tap_smooth_8bpc_neon_dotprod:
mov	x9, #0x73b
mov	x10, #0x73b
b	put_8tap_neon_dotprod
put_8tap_smooth_regular_8bpc_neon_dotprod:
mov	x9, #0x73b
mov	x10, #-0x54
b	put_8tap_neon_dotprod
put_8tap_regular_sharp_8bpc_neon_dotprod:
mov	x9, #-0x54
mov	x10, #0xeac
b	put_8tap_neon_dotprod
put_8tap_regular_smooth_8bpc_neon_dotprod:
mov	x9, #-0x54
mov	x10, #0x73b
b	put_8tap_neon_dotprod
put_8tap_regular_8bpc_neon_dotprod:
mov	x9, #-0x54
mov	x10, #-0x54
put_8tap_neon_dotprod:
clz	w8, w4
mov	w11, #0x4081
sub	w8, w8, #0x18
adrp	x12, mc_subpel_filters
add	x12, x12, :lo12:mc_subpel_filters
cbnz	w6, L_ffc
cbnz	w7, L_adc
b	put_neon
L_adc:
madd	w7, w7, w11, w10
adrp	x13, v_tbl_neon_dotprod
add	x13, x13, :lo12:v_tbl_neon_dotprod
sub	x2, x2, x3
movi	v4.4s, #0x20, lsl #8
ubfx	w11, w7, #7, #7
and	w7, w7, #0x7f
ldp	q6, q28, [x13]
cmp	w5, #0x4
csel	w7, w7, w11, le
sub	x2, x2, x3, lsl #1
add	x7, x12, x7, lsl #3
ldr	q29, [x13, #0x20]
movi	v5.16b, #0x80
ldr	d7, [x7]
cmp	w4, #0x8
b.eq	L_c9c
b.lt	L_dfc
ldp	q30, q31, [x13, #0x30]
L_b28:
mov	x7, x2
mov	x6, x0
sub	w8, w5, #0x1
ldr	q16, [x7]
ldr	q17, [x7, x3]
add	x7, x7, x3, lsl #1
ldr	q18, [x7]
ldr	q19, [x7, x3]
add	x7, x7, x3, lsl #1
zip1	v0.16b, v16.16b, v17.16b
zip2	v1.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip2	v3.16b, v18.16b, v19.16b
ldr	q20, [x7]
ldr	q21, [x7, x3]
add	x7, x7, x3, lsl #1
ldr	q22, [x7]
ldr	q23, [x7, x3]
add	x7, x7, x3, lsl #1
zip1	v18.16b, v20.16b, v21.16b
zip2	v21.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip2	v27.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v22.8h, v1.8h, v3.8h
zip2	v25.8h, v1.8h, v3.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
zip1	v23.8h, v21.8h, v27.8h
zip2	v26.8h, v21.8h, v27.8h
sub	v16.16b, v16.16b, v5.16b
sub	v19.16b, v19.16b, v5.16b
sub	v22.16b, v22.16b, v5.16b
sub	v25.16b, v25.16b, v5.16b
sub	v17.16b, v17.16b, v5.16b
sub	v20.16b, v20.16b, v5.16b
sub	v23.16b, v23.16b, v5.16b
sub	v26.16b, v26.16b, v5.16b
L_bc4:
ld1	{ v27.16b }, [x7], x3
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sub	v18.16b, v27.16b, v5.16b
sub	v21.16b, v27.16b, v5.16b
sub	v24.16b, v27.16b, v5.16b
sub	v27.16b, v27.16b, v5.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v3.4s, v25.16b, v7.4b[0]
tbl	v16.16b, { v16.16b, v17.16b }, v6.16b
tbl	v19.16b, { v19.16b, v20.16b }, v6.16b
tbl	v22.16b, { v22.16b, v23.16b }, v6.16b
tbl	v25.16b, { v25.16b, v26.16b }, v6.16b
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v20.16b, v7.4b[1]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v26.16b, v7.4b[1]
tbl	v17.16b, { v17.16b, v18.16b }, v28.16b
tbl	v20.16b, { v20.16b, v21.16b }, v29.16b
tbl	v23.16b, { v23.16b, v24.16b }, v30.16b
tbl	v26.16b, { v26.16b, v27.16b }, v31.16b
subs	w8, w8, #0x1
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun2	v0.16b, v2.8h, #0x6
st1	{ v0.16b }, [x6], x1
b.gt	L_bc4
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v3.4s, v25.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v20.16b, v7.4b[1]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v26.16b, v7.4b[1]
subs	w4, w4, #0x10
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun2	v0.16b, v2.8h, #0x6
str	q0, [x6]
add	x0, x0, #0x10
add	x2, x2, #0x10
b.gt	L_b28
ret
L_c9c:
ldr	d16, [x2]
ldr	d17, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	d18, [x2]
ldr	d19, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	d20, [x2]
ldr	d21, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	d22, [x2]
ldr	d23, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
zip1	v0.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip1	v18.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
sub	v16.16b, v16.16b, v5.16b
sub	v19.16b, v19.16b, v5.16b
sub	v17.16b, v17.16b, v5.16b
sub	v20.16b, v20.16b, v5.16b
b.eq	L_d94
L_d04:
ldr	d21, [x2]
ldr	d27, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sub	v18.16b, v21.16b, v5.16b
sub	v21.16b, v21.16b, v5.16b
sub	v24.16b, v27.16b, v5.16b
sub	v27.16b, v27.16b, v5.16b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
tbl	v16.16b, { v22.16b, v23.16b }, v6.16b
tbl	v19.16b, { v25.16b, v26.16b }, v6.16b
tbl	v17.16b, { v23.16b, v24.16b }, v28.16b
tbl	v20.16b, { v26.16b, v27.16b }, v29.16b
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v25.16b, v7.4b[0]
sdot	v3.4s, v26.16b, v7.4b[1]
subs	w5, w5, #0x2
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun	v1.8b, v2.8h, #0x6
str	d0, [x0]
str	d1, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_d04
L_d94:
ldr	d21, [x2]
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
mov	v2.16b, v4.16b
mov	v3.16b, v4.16b
sub	v18.16b, v21.16b, v5.16b
sub	v21.16b, v21.16b, v5.16b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
sdot	v2.4s, v22.16b, v7.4b[0]
sdot	v2.4s, v23.16b, v7.4b[1]
sdot	v3.4s, v25.16b, v7.4b[0]
sdot	v3.4s, v26.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun	v1.8b, v2.8h, #0x6
str	d0, [x0]
str	d1, [x0, x1]
ret
L_dfc:
cmp	w4, #0x2
b.eq	L_f00
ldr	s16, [x2]
ldr	s17, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	s18, [x2]
ldr	s19, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	s20, [x2]
ldr	s21, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	s22, [x2]
ldr	s23, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
zip1	v0.8b, v16.8b, v17.8b
zip1	v2.8b, v18.8b, v19.8b
zip1	v18.8b, v20.8b, v21.8b
zip1	v24.8b, v22.8b, v23.8b
zip1	v16.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
sub	v16.16b, v16.16b, v5.16b
sub	v17.16b, v17.16b, v5.16b
b.eq	L_ebc
L_e5c:
ldr	s18, [x2]
ldr	s21, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
sub	v18.16b, v18.16b, v5.16b
sub	v21.16b, v21.16b, v5.16b
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
tbl	v16.16b, { v19.16b, v20.16b }, v6.16b
tbl	v17.16b, { v20.16b, v21.16b }, v28.16b
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d0
lsr	x9, x8, #32
str	w8, [x0]
str	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_e5c
L_ebc:
ldr	s18, [x2]
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
sub	v18.16b, v18.16b, v5.16b
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
fmov	x8, d0
lsr	x9, x8, #32
str	w8, [x0]
str	w9, [x0, x1]
ret
L_f00:
ldr	h16, [x2]
ldr	h17, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	h18, [x2]
ldr	h19, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	h20, [x2]
ldr	h21, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	h22, [x2]
ldr	h23, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
zip1	v0.8b, v16.8b, v17.8b
zip1	v2.8b, v18.8b, v19.8b
zip1	v18.8b, v20.8b, v21.8b
zip1	v24.8b, v22.8b, v23.8b
zip1	v16.4h, v0.4h, v2.4h
zip1	v17.4h, v18.4h, v24.4h
sub	v16.8b, v16.8b, v5.8b
sub	v17.8b, v17.8b, v5.8b
b.eq	L_fb8
L_f58:
ldr	h18, [x2]
ldr	h21, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
sub	v18.8b, v18.8b, v5.8b
sub	v21.8b, v21.8b, v5.8b
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
tbl	v16.16b, { v19.16b, v20.16b }, v6.16b
tbl	v17.16b, { v20.16b, v21.16b }, v28.16b
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d0
lsr	x9, x8, #32
strh	w8, [x0]
strh	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_f58
L_fb8:
ldr	h18, [x2]
mov	v0.16b, v4.16b
mov	v1.16b, v4.16b
sub	v18.8b, v18.8b, v5.8b
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
sdot	v0.4s, v16.16b, v7.4b[0]
sdot	v0.4s, v17.16b, v7.4b[1]
sdot	v1.4s, v19.16b, v7.4b[0]
sdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
fmov	x8, d0
lsr	x9, x8, #32
strh	w8, [x0]
strh	w9, [x0, x1]
ret
L_ffc:
madd	w6, w6, w11, w9
madd	w14, w7, w11, w10
mov	w13, #0x2002
dup	v27.4s, w13
adrp	x13, h_tbl_neon_dotprod
add	x13, x13, :lo12:h_tbl_neon_dotprod
sub	x2, x2, #0x3
ldr	q28, [x13]
ubfx	w15, w6, #7, #7
and	w6, w6, #0x7f
ubfx	w11, w14, #7, #7
and	w14, w14, #0x7f
cmp	w4, #0x4
csel	w6, w6, w15, le
add	x6, x12, x6, lsl #3
movi	v24.16b, #0x80
cbz	w7, L_1520
cmp	w5, #0x4
csel	w14, w14, w11, le
sub	x2, x2, x3, lsl #1
add	x7, x12, x14, lsl #3
mov	x15, x30
ldr	d7, [x7]
ldr	q25, [x13, #0x50]
sshll	v7.8h, v7.8b, #0x0
cmp	w10, #0xeac
b.ne	L_12d4
sub	x2, x2, x3
cmp	w4, #0x4
b.eq	L_117c
b.lt	L_1228
ldp	q29, q30, [x13, #0x10]
ldr	d26, [x6]
L_1080:
mov	x7, x2
mov	x6, x0
mov	w8, w5
bl	L_13bc
sshr	v16.8h, v22.8h, #0x2
bl	L_13bc
sshr	v17.8h, v22.8h, #0x2
bl	L_13bc
sshr	v18.8h, v22.8h, #0x2
bl	L_13bc
sshr	v19.8h, v22.8h, #0x2
bl	L_13bc
sshr	v20.8h, v22.8h, #0x2
bl	L_13bc
sshr	v21.8h, v22.8h, #0x2
bl	L_13bc
sshr	v22.8h, v22.8h, #0x2
L_10c4:
ldr	q23, [x7]
add	x7, x7, x3
smull	v0.4s, v16.4h, v7.h[0]
smull2	v1.4s, v16.8h, v7.h[0]
mov	v16.16b, v17.16b
sub	v23.16b, v23.16b, v24.16b
mov	v5.16b, v27.16b
mov	v6.16b, v27.16b
smlal	v0.4s, v17.4h, v7.h[1]
smlal2	v1.4s, v17.8h, v7.h[1]
mov	v17.16b, v18.16b
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
tbl	v4.16b, { v23.16b }, v30.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal2	v1.4s, v18.8h, v7.h[2]
mov	v18.16b, v19.16b
sdot	v5.4s, v2.16b, v26.4b[0]
sdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v19.4h, v7.h[3]
smlal2	v1.4s, v19.8h, v7.h[3]
mov	v19.16b, v20.16b
sdot	v5.4s, v3.16b, v26.4b[1]
sdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v20.4h, v7.h[4]
smlal2	v1.4s, v20.8h, v7.h[4]
mov	v20.16b, v21.16b
smlal	v0.4s, v21.4h, v7.h[5]
smlal2	v1.4s, v21.8h, v7.h[5]
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
smlal2	v1.4s, v22.8h, v7.h[6]
shrn	v22.4h, v5.4s, #0x2
shrn2	v22.8h, v6.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
smlal2	v1.4s, v22.8h, v7.h[7]
tbl	v0.16b, { v0.16b, v1.16b }, v25.16b
sqrshrun	v0.8b, v0.8h, #0x2
subs	w8, w8, #0x1
st1	{ v0.8b }, [x6], x1
b.gt	L_10c4
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	w4, w4, #0x8
b.gt	L_1080
ret	x15
L_117c:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_13f0
shrn	v16.4h, v22.4s, #0x2
bl	L_13f0
shrn	v17.4h, v22.4s, #0x2
bl	L_13f0
shrn	v18.4h, v22.4s, #0x2
bl	L_13f0
shrn	v19.4h, v22.4s, #0x2
bl	L_13f0
shrn	v20.4h, v22.4s, #0x2
bl	L_13f0
shrn	v21.4h, v22.4s, #0x2
bl	L_13f0
shrn	v22.4h, v22.4s, #0x2
L_11bc:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[0]
smlal	v0.4s, v17.4h, v7.h[1]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
sub	v4.16b, v4.16b, v24.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal	v0.4s, v19.4h, v7.h[3]
tbl	v2.16b, { v4.16b }, v28.16b
mov	v5.16b, v27.16b
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[4]
smlal	v0.4s, v21.4h, v7.h[5]
sdot	v5.4s, v2.16b, v26.4b[0]
mov	v20.16b, v21.16b
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
shrn	v22.4h, v5.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
subs	w5, w5, #0x1
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	s0, [x0]
add	x0, x0, x1
b.gt	L_11bc
ret	x15
L_1228:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_13f0
shrn	v16.4h, v22.4s, #0x2
bl	L_13f0
shrn	v17.4h, v22.4s, #0x2
bl	L_13f0
shrn	v18.4h, v22.4s, #0x2
bl	L_13f0
shrn	v19.4h, v22.4s, #0x2
bl	L_13f0
shrn	v20.4h, v22.4s, #0x2
bl	L_13f0
shrn	v21.4h, v22.4s, #0x2
bl	L_13f0
shrn	v22.4h, v22.4s, #0x2
L_1268:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[0]
smlal	v0.4s, v17.4h, v7.h[1]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
sub	v4.16b, v4.16b, v24.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal	v0.4s, v19.4h, v7.h[3]
tbl	v2.16b, { v4.16b }, v28.16b
mov	v5.16b, v27.16b
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[4]
smlal	v0.4s, v21.4h, v7.h[5]
sdot	v5.4s, v2.16b, v26.4b[0]
mov	v20.16b, v21.16b
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
shrn	v22.4h, v5.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
subs	w5, w5, #0x1
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	h0, [x0]
add	x0, x0, x1
b.gt	L_1268
ret	x15
L_12d4:
cmp	w4, #0x4
b.eq	L_1408
b.lt	L_1494
ldr	d26, [x6]
ldp	q29, q30, [x13, #0x10]
L_12e8:
mov	x7, x2
mov	x6, x0
mov	w8, w5
bl	L_13bc
sshr	v16.8h, v22.8h, #0x2
bl	L_13bc
sshr	v17.8h, v22.8h, #0x2
bl	L_13bc
sshr	v18.8h, v22.8h, #0x2
bl	L_13bc
sshr	v19.8h, v22.8h, #0x2
bl	L_13bc
sshr	v20.8h, v22.8h, #0x2
L_131c:
ldr	q23, [x7]
add	x7, x7, x3
smull	v0.4s, v16.4h, v7.h[1]
smull2	v1.4s, v16.8h, v7.h[1]
sub	v23.16b, v23.16b, v24.16b
mov	v16.16b, v17.16b
mov	v5.16b, v27.16b
mov	v6.16b, v27.16b
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
smlal	v0.4s, v17.4h, v7.h[2]
smlal2	v1.4s, v17.8h, v7.h[2]
tbl	v4.16b, { v23.16b }, v30.16b
mov	v17.16b, v18.16b
sdot	v5.4s, v2.16b, v26.4b[0]
sdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v18.4h, v7.h[3]
smlal2	v1.4s, v18.8h, v7.h[3]
mov	v18.16b, v19.16b
sdot	v5.4s, v3.16b, v26.4b[1]
sdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v19.4h, v7.h[4]
smlal2	v1.4s, v19.8h, v7.h[4]
mov	v19.16b, v20.16b
uzp1	v23.8h, v5.8h, v6.8h
smlal	v0.4s, v20.4h, v7.h[5]
smlal2	v1.4s, v20.8h, v7.h[5]
sshr	v20.8h, v23.8h, #0x2
subs	w8, w8, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
smlal2	v1.4s, v20.8h, v7.h[6]
tbl	v0.16b, { v0.16b, v1.16b }, v25.16b
sqrshrun	v0.8b, v0.8h, #0x2
st1	{ v0.8b }, [x6], x1
b.gt	L_131c
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	w4, w4, #0x8
b.gt	L_12e8
ret	x15
L_13bc:
ld1	{ v4.16b }, [x7], x3
sub	v4.16b, v4.16b, v24.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v2.16b, { v4.16b }, v28.16b
tbl	v3.16b, { v4.16b }, v29.16b
tbl	v4.16b, { v4.16b }, v30.16b
sdot	v22.4s, v2.16b, v26.4b[0]
sdot	v23.4s, v3.16b, v26.4b[0]
sdot	v22.4s, v3.16b, v26.4b[1]
sdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v22.8h, v22.8h, v23.8h
ret
L_13f0:
ld1	{ v4.8b }, [x2], x3
mov	v22.16b, v27.16b
sub	v4.16b, v4.16b, v24.16b
tbl	v2.16b, { v4.16b }, v28.16b
sdot	v22.4s, v2.16b, v26.4b[0]
ret
L_1408:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_13f0
shrn	v16.4h, v22.4s, #0x2
bl	L_13f0
shrn	v17.4h, v22.4s, #0x2
bl	L_13f0
shrn	v18.4h, v22.4s, #0x2
bl	L_13f0
shrn	v19.4h, v22.4s, #0x2
bl	L_13f0
shrn	v20.4h, v22.4s, #0x2
L_1438:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[1]
smlal	v0.4s, v17.4h, v7.h[2]
sub	v4.16b, v4.16b, v24.16b
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal	v0.4s, v19.4h, v7.h[4]
tbl	v2.16b, { v4.16b }, v28.16b
mov	v5.16b, v27.16b
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
sdot	v5.4s, v2.16b, v26.4b[0]
smlal	v0.4s, v20.4h, v7.h[5]
shrn	v20.4h, v5.4s, #0x2
subs	w5, w5, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	s0, [x0]
add	x0, x0, x1
b.gt	L_1438
ret	x15
L_1494:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_13f0
shrn	v16.4h, v22.4s, #0x2
bl	L_13f0
shrn	v17.4h, v22.4s, #0x2
bl	L_13f0
shrn	v18.4h, v22.4s, #0x2
bl	L_13f0
shrn	v19.4h, v22.4s, #0x2
bl	L_13f0
shrn	v20.4h, v22.4s, #0x2
L_14c4:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[1]
smlal	v0.4s, v17.4h, v7.h[2]
sub	v4.16b, v4.16b, v24.16b
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal	v0.4s, v19.4h, v7.h[4]
tbl	v2.16b, { v4.16b }, v28.16b
mov	v5.16b, v27.16b
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
sdot	v5.4s, v2.16b, v26.4b[0]
smlal	v0.4s, v20.4h, v7.h[5]
shrn	v20.4h, v5.4s, #0x2
subs	w5, w5, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	h0, [x0]
add	x0, x0, x1
b.gt	L_14c4
ret	x15
L_1520:
adrp	x11, put_8tap_h_neon_dotprod_tbl
add	x11, x11, :lo12:put_8tap_h_neon_dotprod_tbl
ldrsw	x8, [x11, x8, lsl #2]
mov	w10, #0x2022
dup	v27.4s, w10
add	x11, x11, x8
br	x11
L_153c:
add	x2, x2, #0x2
ldur	s26, [x6, #0x2]
L_1544:
ldr	d0, [x2]
ldr	d1, [x2, x3]
add	x2, x2, x3, lsl #1
sub	v0.8b, v0.8b, v24.8b
sub	v1.8b, v1.8b, v24.8b
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
tbl	v2.16b, { v0.16b }, v28.16b
tbl	v3.16b, { v1.16b }, v28.16b
sdot	v4.4s, v2.16b, v26.4b[0]
sdot	v5.4s, v3.16b, v26.4b[0]
uzp1	v4.8h, v4.8h, v5.8h
sqshrun	v4.8b, v4.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d4
lsr	x9, x8, #32
strh	w8, [x0]
strh	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_1544
ret
L_1598:
add	x2, x2, #0x2
ldur	s26, [x6, #0x2]
L_15a0:
ldr	d0, [x2]
ldr	d1, [x2, x3]
add	x2, x2, x3, lsl #1
sub	v0.8b, v0.8b, v24.8b
sub	v1.8b, v1.8b, v24.8b
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
tbl	v2.16b, { v0.16b }, v28.16b
tbl	v3.16b, { v1.16b }, v28.16b
sdot	v4.4s, v2.16b, v26.4b[0]
sdot	v5.4s, v3.16b, v26.4b[0]
uzp1	v4.8h, v4.8h, v5.8h
sqshrun	v4.8b, v4.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d4
lsr	x9, x8, #32
str	w8, [x0]
str	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_15a0
ret
L_15f4:
ldr	d26, [x6]
ldp	q29, q30, [x13, #0x10]
L_15fc:
ldr	q0, [x2]
ldr	q16, [x2, x3]
add	x2, x2, x3, lsl #1
sub	v0.16b, v0.16b, v24.16b
sub	v16.16b, v16.16b, v24.16b
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
mov	v20.16b, v27.16b
mov	v21.16b, v27.16b
tbl	v1.16b, { v0.16b }, v28.16b
tbl	v2.16b, { v0.16b }, v29.16b
tbl	v3.16b, { v0.16b }, v30.16b
tbl	v17.16b, { v16.16b }, v28.16b
tbl	v18.16b, { v16.16b }, v29.16b
tbl	v19.16b, { v16.16b }, v30.16b
sdot	v4.4s, v1.16b, v26.4b[0]
sdot	v5.4s, v2.16b, v26.4b[0]
sdot	v20.4s, v17.16b, v26.4b[0]
sdot	v21.4s, v18.16b, v26.4b[0]
sdot	v4.4s, v2.16b, v26.4b[1]
sdot	v5.4s, v3.16b, v26.4b[1]
sdot	v20.4s, v18.16b, v26.4b[1]
sdot	v21.4s, v19.16b, v26.4b[1]
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v20.8h, v20.8h, v21.8h
sqshrun	v4.8b, v4.8h, #0x6
sqshrun	v20.8b, v20.8h, #0x6
subs	w5, w5, #0x2
str	d4, [x0]
str	d20, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_15fc
ret
L_1680:
ldr	d26, [x6]
ldp	q29, q30, [x13, #0x10]
L_1688:
ldr	q16, [x2]
ldur	q17, [x2, #0xc]
add	x2, x2, x3
sub	v16.16b, v16.16b, v24.16b
sub	v17.16b, v17.16b, v24.16b
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
sdot	v6.4s, v0.16b, v26.4b[0]
sdot	v7.4s, v1.16b, v26.4b[0]
sdot	v22.4s, v2.16b, v26.4b[0]
sdot	v23.4s, v3.16b, v26.4b[0]
sdot	v6.4s, v1.16b, v26.4b[1]
sdot	v7.4s, v2.16b, v26.4b[1]
sdot	v22.4s, v3.16b, v26.4b[1]
sdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sqshrun	v6.8b, v6.8h, #0x6
sqshrun2	v6.16b, v22.8h, #0x6
subs	w5, w5, #0x1
st1	{ v6.16b }, [x0], x1
b.gt	L_1688
ret
L_1700:
ldr	d26, [x6]
sub	x1, x1, w4, uxtw
sub	x3, x3, w4, uxtw
mov	w8, w4
ldp	q29, q30, [x13, #0x10]
L_1714:
ldr	q16, [x2]
ldur	q17, [x2, #0xc]
add	x2, x2, #0x10
sub	v16.16b, v16.16b, v24.16b
sub	v17.16b, v17.16b, v24.16b
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
sdot	v6.4s, v0.16b, v26.4b[0]
sdot	v7.4s, v1.16b, v26.4b[0]
sdot	v22.4s, v2.16b, v26.4b[0]
sdot	v23.4s, v3.16b, v26.4b[0]
sdot	v6.4s, v1.16b, v26.4b[1]
sdot	v7.4s, v2.16b, v26.4b[1]
sdot	v22.4s, v3.16b, v26.4b[1]
sdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sqshrun	v6.8b, v6.8h, #0x6
sqshrun2	v6.16b, v22.8h, #0x6
subs	w8, w8, #0x10
str	q6, [x0], #0x10
b.gt	L_1714
add	x2, x2, x3
add	x0, x0, x1
mov	w8, w4
subs	w5, w5, #0x1
b.gt	L_1714
ret
prep_8tap_sharp_8bpc_neon_i8mm:
mov	x9, #0xeac
mov	x10, #0xeac
b	prep_8tap_neon_i8mm
prep_8tap_sharp_smooth_8bpc_neon_i8mm:
mov	x9, #0xeac
mov	x10, #0x73b
b	prep_8tap_neon_i8mm
prep_8tap_sharp_regular_8bpc_neon_i8mm:
mov	x9, #0xeac
mov	x10, #-0x54
b	prep_8tap_neon_i8mm
prep_8tap_smooth_sharp_8bpc_neon_i8mm:
mov	x9, #0x73b
mov	x10, #0xeac
b	prep_8tap_neon_i8mm
prep_8tap_smooth_8bpc_neon_i8mm:
mov	x9, #0x73b
mov	x10, #0x73b
b	prep_8tap_neon_i8mm
prep_8tap_smooth_regular_8bpc_neon_i8mm:
mov	x9, #0x73b
mov	x10, #-0x54
b	prep_8tap_neon_i8mm
prep_8tap_regular_sharp_8bpc_neon_i8mm:
mov	x9, #-0x54
mov	x10, #0xeac
b	prep_8tap_neon_i8mm
prep_8tap_regular_smooth_8bpc_neon_i8mm:
mov	x9, #-0x54
mov	x10, #0x73b
b	prep_8tap_neon_i8mm
prep_8tap_regular_8bpc_neon_i8mm:
mov	x9, #-0x54
mov	x10, #-0x54
prep_8tap_neon_i8mm:
clz	w8, w3
mov	w11, #0x4081
sub	w8, w8, #0x18
adrp	x12, mc_subpel_filters
add	x12, x12, :lo12:mc_subpel_filters
cbnz	w5, L_1bc0
cbnz	w6, L_182c
add	w7, w3, w3
b	prep_neon
L_182c:
madd	w6, w6, w11, w10
adrp	x13, v_tbl_neon_dotprod
add	x13, x13, :lo12:v_tbl_neon_dotprod
sub	x1, x1, x2
ubfx	w11, w6, #7, #7
and	w6, w6, #0x7f
ldp	q6, q28, [x13]
cmp	w4, #0x4
csel	w6, w6, w11, le
sub	x1, x1, x2, lsl #1
add	x6, x12, x6, lsl #3
ldr	q29, [x13, #0x20]
ldr	d7, [x6]
cmp	w3, #0x8
b.eq	L_19c4
b.lt	L_1af8
ldp	q30, q31, [x13, #0x30]
add	w7, w3, w3
L_1874:
mov	x6, x1
mov	x5, x0
sub	w8, w4, #0x1
ldr	q16, [x6]
ldr	q17, [x6, x2]
add	x6, x6, x2, lsl #1
ldr	q18, [x6]
ldr	q19, [x6, x2]
add	x6, x6, x2, lsl #1
zip1	v0.16b, v16.16b, v17.16b
zip2	v1.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip2	v3.16b, v18.16b, v19.16b
ldr	q20, [x6]
ldr	q21, [x6, x2]
add	x6, x6, x2, lsl #1
ldr	q22, [x6]
ldr	q23, [x6, x2]
add	x6, x6, x2, lsl #1
zip1	v18.16b, v20.16b, v21.16b
zip2	v21.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip2	v27.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v22.8h, v1.8h, v3.8h
zip2	v25.8h, v1.8h, v3.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
zip1	v23.8h, v21.8h, v27.8h
zip2	v26.8h, v21.8h, v27.8h
L_18f0:
ld1	{ v18.16b }, [x6], x2
movi	v0.4s, #0x0
movi	v1.4s, #0x0
movi	v2.4s, #0x0
movi	v3.4s, #0x0
mov	v21.16b, v18.16b
mov	v24.16b, v18.16b
mov	v27.16b, v18.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v3.4s, v25.16b, v7.4b[0]
tbl	v16.16b, { v16.16b, v17.16b }, v6.16b
tbl	v19.16b, { v19.16b, v20.16b }, v6.16b
tbl	v22.16b, { v22.16b, v23.16b }, v6.16b
tbl	v25.16b, { v25.16b, v26.16b }, v6.16b
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v20.16b, v7.4b[1]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v26.16b, v7.4b[1]
tbl	v17.16b, { v17.16b, v18.16b }, v28.16b
tbl	v20.16b, { v20.16b, v21.16b }, v29.16b
tbl	v23.16b, { v23.16b, v24.16b }, v30.16b
tbl	v26.16b, { v26.16b, v27.16b }, v31.16b
subs	w8, w8, #0x1
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
srshr	v0.8h, v0.8h, #0x2
srshr	v1.8h, v2.8h, #0x2
st1	{ v0.8h, v1.8h }, [x5], x7
b.gt	L_18f0
movi	v0.4s, #0x0
movi	v1.4s, #0x0
movi	v2.4s, #0x0
movi	v3.4s, #0x0
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v3.4s, v25.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v20.16b, v7.4b[1]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v26.16b, v7.4b[1]
subs	w3, w3, #0x10
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
srshr	v0.8h, v0.8h, #0x2
srshr	v1.8h, v2.8h, #0x2
stp	q0, q1, [x5]
add	x0, x0, #0x20
add	x1, x1, #0x10
b.gt	L_1874
ret
L_19c4:
ldr	d16, [x1]
ldr	d17, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d18, [x1]
ldr	d19, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d20, [x1]
ldr	d21, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d22, [x1]
ldr	d23, [x1, x2]
add	x1, x1, x2, lsl #1
subs	w4, w4, #0x2
zip1	v0.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip1	v18.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
L_1a18:
ldr	d18, [x1]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
ldr	d24, [x1, x2]
add	x1, x1, x2, lsl #1
movi	v2.4s, #0x0
movi	v3.4s, #0x0
mov	v21.8b, v18.8b
mov	v27.8b, v24.8b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
tbl	v16.16b, { v22.16b, v23.16b }, v6.16b
tbl	v19.16b, { v25.16b, v26.16b }, v6.16b
tbl	v17.16b, { v23.16b, v24.16b }, v28.16b
tbl	v20.16b, { v26.16b, v27.16b }, v29.16b
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v25.16b, v7.4b[0]
usdot	v3.4s, v26.16b, v7.4b[1]
subs	w4, w4, #0x2
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
srshr	v0.8h, v0.8h, #0x2
srshr	v1.8h, v2.8h, #0x2
stp	q0, q1, [x0], #0x20
b.gt	L_1a18
ldr	d18, [x1]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
movi	v2.4s, #0x0
movi	v3.4s, #0x0
mov	v21.8b, v18.8b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v25.16b, v7.4b[0]
usdot	v3.4s, v26.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
srshr	v0.8h, v0.8h, #0x2
srshr	v1.8h, v2.8h, #0x2
stp	q0, q1, [x0]
ret
L_1af8:
ldr	s16, [x1]
ldr	s17, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s18, [x1]
ldr	s19, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s20, [x1]
ldr	s21, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s22, [x1]
ldr	s23, [x1, x2]
add	x1, x1, x2, lsl #1
subs	w4, w4, #0x2
zip1	v0.8b, v16.8b, v17.8b
zip1	v2.8b, v18.8b, v19.8b
zip1	v18.8b, v20.8b, v21.8b
zip1	v24.8b, v22.8b, v23.8b
zip1	v16.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
L_1b44:
ldr	s18, [x1]
ldr	s21, [x1, x2]
add	x1, x1, x2, lsl #1
movi	v0.4s, #0x0
movi	v1.4s, #0x0
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
tbl	v16.16b, { v19.16b, v20.16b }, v6.16b
tbl	v17.16b, { v20.16b, v21.16b }, v28.16b
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
subs	w4, w4, #0x2
rshrn	v0.4h, v0.4s, #0x2
rshrn2	v0.8h, v1.4s, #0x2
str	q0, [x0], #0x10
b.gt	L_1b44
ldr	s18, [x1]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
rshrn	v0.4h, v0.4s, #0x2
rshrn2	v0.8h, v1.4s, #0x2
str	q0, [x0]
ret
L_1bc0:
madd	w5, w5, w11, w9
madd	w14, w6, w11, w10
adrp	x13, h_tbl_neon_dotprod
add	x13, x13, :lo12:h_tbl_neon_dotprod
sub	x1, x1, #0x3
ldr	q28, [x13]
ubfx	w15, w5, #7, #7
and	w5, w5, #0x7f
ubfx	w11, w14, #7, #7
and	w14, w14, #0x7f
cmp	w3, #0x4
csel	w5, w5, w15, le
add	x5, x12, x5, lsl #3
cbz	w6, L_206c
cmp	w4, #0x4
csel	w14, w14, w11, le
sub	x1, x1, x2, lsl #1
add	x6, x12, x14, lsl #3
mov	x15, x30
ldr	d7, [x6]
sshll	v7.8h, v7.8b, #0x0
cmp	w10, #0xeac
b.ne	L_1dcc
sub	x1, x1, x2
cmp	w3, #0x4
b.eq	L_1d2c
ldp	q29, q30, [x13, #0x10]
ldr	d26, [x5]
add	w7, w3, w3
L_1c34:
mov	x6, x1
mov	x5, x0
mov	w8, w4
bl	L_1f84
srshr	v16.8h, v22.8h, #0x2
bl	L_1f84
srshr	v17.8h, v22.8h, #0x2
bl	L_1f84
srshr	v18.8h, v22.8h, #0x2
bl	L_1f84
srshr	v19.8h, v22.8h, #0x2
bl	L_1f84
srshr	v20.8h, v22.8h, #0x2
bl	L_1f84
srshr	v21.8h, v22.8h, #0x2
bl	L_1f84
srshr	v22.8h, v22.8h, #0x2
L_1c78:
ldr	q23, [x6]
add	x6, x6, x2
smull	v0.4s, v16.4h, v7.h[0]
smull2	v1.4s, v16.8h, v7.h[0]
mov	v16.16b, v17.16b
movi	v5.4s, #0x0
movi	v6.4s, #0x0
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
smlal	v0.4s, v17.4h, v7.h[1]
smlal2	v1.4s, v17.8h, v7.h[1]
tbl	v4.16b, { v23.16b }, v30.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal2	v1.4s, v18.8h, v7.h[2]
mov	v18.16b, v19.16b
usdot	v5.4s, v2.16b, v26.4b[0]
usdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v19.4h, v7.h[3]
smlal2	v1.4s, v19.8h, v7.h[3]
mov	v19.16b, v20.16b
usdot	v5.4s, v3.16b, v26.4b[1]
usdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v20.4h, v7.h[4]
smlal2	v1.4s, v20.8h, v7.h[4]
mov	v20.16b, v21.16b
smlal	v0.4s, v21.4h, v7.h[5]
smlal2	v1.4s, v21.8h, v7.h[5]
uzp1	v23.8h, v5.8h, v6.8h
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
smlal2	v1.4s, v22.8h, v7.h[6]
subs	w8, w8, #0x1
srshr	v22.8h, v23.8h, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
smlal2	v1.4s, v22.8h, v7.h[7]
rshrn	v0.4h, v0.4s, #0x6
rshrn2	v0.8h, v1.4s, #0x6
st1	{ v0.8h }, [x5], x7
b.gt	L_1c78
add	x0, x0, #0x10
add	x1, x1, #0x8
subs	w3, w3, #0x8
b.gt	L_1c34
ret	x15
L_1d2c:
ldur	s26, [x5, #0x2]
add	x1, x1, #0x2
bl	L_1fd8
shrn	v16.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v17.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v18.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v19.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v20.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v21.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v22.4h, v22.4s, #0x2
L_1d6c:
ld1	{ v4.8b }, [x1], x2
smull	v0.4s, v16.4h, v7.h[0]
smlal	v0.4s, v17.4h, v7.h[1]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal	v0.4s, v19.4h, v7.h[3]
tbl	v2.16b, { v4.16b }, v28.16b
movi	v5.4s, #0x0
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[4]
smlal	v0.4s, v21.4h, v7.h[5]
usdot	v5.4s, v2.16b, v26.4b[0]
mov	v20.16b, v21.16b
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
rshrn	v22.4h, v5.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
rshrn	v0.4h, v0.4s, #0x6
str	d0, [x0], #0x8
subs	w4, w4, #0x1
b.gt	L_1d6c
ret	x15
L_1dcc:
cmp	w3, #0x4
b.eq	L_1fec
ldr	d26, [x5]
add	w7, w3, w3
cmp	w9, #0xeac
b.eq	L_1eb0
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_1df0:
mov	x6, x1
mov	x5, x0
mov	w8, w4
bl	L_1fb4
srshr	v16.8h, v22.8h, #0x2
bl	L_1fb4
srshr	v17.8h, v22.8h, #0x2
bl	L_1fb4
srshr	v18.8h, v22.8h, #0x2
bl	L_1fb4
srshr	v19.8h, v22.8h, #0x2
bl	L_1fb4
srshr	v20.8h, v22.8h, #0x2
L_1e24:
ld1	{ v23.16b }, [x6], x2
smull	v0.4s, v16.4h, v7.h[1]
smull2	v1.4s, v16.8h, v7.h[1]
mov	v16.16b, v17.16b
movi	v5.4s, #0x0
movi	v6.4s, #0x0
tbl	v2.16b, { v23.16b }, v29.16b
tbl	v3.16b, { v23.16b }, v30.16b
smlal	v0.4s, v17.4h, v7.h[2]
smlal2	v1.4s, v17.8h, v7.h[2]
mov	v17.16b, v18.16b
usmmla	v5.4s, v2.16b, v26.16b
usmmla	v6.4s, v3.16b, v26.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal2	v1.4s, v18.8h, v7.h[3]
mov	v18.16b, v19.16b
subs	w8, w8, #0x1
smlal	v0.4s, v19.4h, v7.h[4]
smlal2	v1.4s, v19.8h, v7.h[4]
uzp1	v23.8h, v5.8h, v6.8h
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[5]
smlal2	v1.4s, v20.8h, v7.h[5]
srshr	v20.8h, v23.8h, #0x2
smlal	v0.4s, v20.4h, v7.h[6]
smlal2	v1.4s, v20.8h, v7.h[6]
rshrn	v0.4h, v0.4s, #0x6
rshrn2	v0.8h, v1.4s, #0x6
st1	{ v0.8h }, [x5], x7
b.gt	L_1e24
add	x0, x0, #0x10
add	x1, x1, #0x8
subs	w3, w3, #0x8
b.gt	L_1df0
ret	x15
L_1eb0:
ldp	q29, q30, [x13, #0x10]
L_1eb4:
mov	x6, x1
mov	x5, x0
mov	w8, w4
bl	L_1f84
srshr	v16.8h, v22.8h, #0x2
bl	L_1f84
srshr	v17.8h, v22.8h, #0x2
bl	L_1f84
srshr	v18.8h, v22.8h, #0x2
bl	L_1f84
srshr	v19.8h, v22.8h, #0x2
bl	L_1f84
srshr	v20.8h, v22.8h, #0x2
L_1ee8:
ldr	q23, [x6]
add	x6, x6, x2
smull	v0.4s, v16.4h, v7.h[1]
smull2	v1.4s, v16.8h, v7.h[1]
mov	v16.16b, v17.16b
movi	v5.4s, #0x0
movi	v6.4s, #0x0
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
smlal	v0.4s, v17.4h, v7.h[2]
smlal2	v1.4s, v17.8h, v7.h[2]
tbl	v4.16b, { v23.16b }, v30.16b
mov	v17.16b, v18.16b
usdot	v5.4s, v2.16b, v26.4b[0]
usdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v18.4h, v7.h[3]
smlal2	v1.4s, v18.8h, v7.h[3]
mov	v18.16b, v19.16b
usdot	v5.4s, v3.16b, v26.4b[1]
usdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v19.4h, v7.h[4]
smlal2	v1.4s, v19.8h, v7.h[4]
mov	v19.16b, v20.16b
uzp1	v23.8h, v5.8h, v6.8h
smlal	v0.4s, v20.4h, v7.h[5]
smlal2	v1.4s, v20.8h, v7.h[5]
srshr	v20.8h, v23.8h, #0x2
subs	w8, w8, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
smlal2	v1.4s, v20.8h, v7.h[6]
rshrn	v0.4h, v0.4s, #0x6
rshrn2	v0.8h, v1.4s, #0x6
st1	{ v0.8h }, [x5], x7
b.gt	L_1ee8
add	x0, x0, #0x10
add	x1, x1, #0x8
subs	w3, w3, #0x8
b.gt	L_1eb4
ret	x15
L_1f84:
ld1	{ v4.16b }, [x6], x2
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v2.16b, { v4.16b }, v28.16b
tbl	v3.16b, { v4.16b }, v29.16b
tbl	v4.16b, { v4.16b }, v30.16b
usdot	v22.4s, v2.16b, v26.4b[0]
usdot	v23.4s, v3.16b, v26.4b[0]
usdot	v22.4s, v3.16b, v26.4b[1]
usdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v22.8h, v22.8h, v23.8h
ret
L_1fb4:
ld1	{ v4.16b }, [x6], x2
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v2.16b, { v4.16b }, v29.16b
tbl	v3.16b, { v4.16b }, v30.16b
usmmla	v22.4s, v2.16b, v26.16b
usmmla	v23.4s, v3.16b, v26.16b
uzp1	v22.8h, v22.8h, v23.8h
ret
L_1fd8:
ld1	{ v4.8b }, [x1], x2
movi	v22.4s, #0x2
tbl	v2.16b, { v4.16b }, v28.16b
usdot	v22.4s, v2.16b, v26.4b[0]
ret
L_1fec:
ldur	s26, [x5, #0x2]
add	x1, x1, #0x2
bl	L_1fd8
shrn	v16.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v17.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v18.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v19.4h, v22.4s, #0x2
bl	L_1fd8
shrn	v20.4h, v22.4s, #0x2
L_201c:
ld1	{ v4.8b }, [x1], x2
smull	v0.4s, v16.4h, v7.h[1]
smlal	v0.4s, v17.4h, v7.h[2]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal	v0.4s, v19.4h, v7.h[4]
tbl	v2.16b, { v4.16b }, v28.16b
movi	v5.4s, #0x0
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
usdot	v5.4s, v2.16b, v26.4b[0]
smlal	v0.4s, v20.4h, v7.h[5]
rshrn	v20.4h, v5.4s, #0x2
subs	w4, w4, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
rshrn	v0.4h, v0.4s, #0x6
str	d0, [x0], #0x8
b.gt	L_201c
ret	x15
L_206c:
adrp	x11, prep_8tap_h_neon_i8mm_tbl
add	x11, x11, :lo12:prep_8tap_h_neon_i8mm_tbl
ldrsw	x8, [x11, x8, lsl #2]
add	x11, x11, x8
br	x11
L_2080:
add	x1, x1, #0x2
ldur	s26, [x5, #0x2]
L_2088:
ldr	d0, [x1]
ldr	d1, [x1, x2]
add	x1, x1, x2, lsl #1
movi	v4.4s, #0x0
movi	v5.4s, #0x0
tbl	v2.16b, { v0.16b }, v28.16b
tbl	v3.16b, { v1.16b }, v28.16b
usdot	v4.4s, v2.16b, v26.4b[0]
usdot	v5.4s, v3.16b, v26.4b[0]
subs	w4, w4, #0x2
uzp1	v4.8h, v4.8h, v5.8h
srshr	v4.8h, v4.8h, #0x2
str	q4, [x0], #0x10
b.gt	L_2088
ret
L_20c4:
ldr	d26, [x5]
cmp	w9, #0xeac
b.eq	L_2138
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_20dc:
ldr	q0, [x1]
ldr	q16, [x1, x2]
add	x1, x1, x2, lsl #1
movi	v4.4s, #0x0
movi	v5.4s, #0x0
movi	v20.4s, #0x0
movi	v21.4s, #0x0
tbl	v1.16b, { v0.16b }, v29.16b
tbl	v2.16b, { v0.16b }, v30.16b
tbl	v17.16b, { v16.16b }, v29.16b
tbl	v18.16b, { v16.16b }, v30.16b
usmmla	v4.4s, v1.16b, v26.16b
usmmla	v5.4s, v2.16b, v26.16b
usmmla	v20.4s, v17.16b, v26.16b
usmmla	v21.4s, v18.16b, v26.16b
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v20.8h, v20.8h, v21.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v20.8h, v20.8h, #0x2
subs	w4, w4, #0x2
stp	q4, q20, [x0], #0x20
b.gt	L_20dc
ret
L_2138:
ldp	q29, q30, [x13, #0x10]
L_213c:
ldr	q0, [x1]
ldr	q16, [x1, x2]
add	x1, x1, x2, lsl #1
movi	v4.4s, #0x0
movi	v5.4s, #0x0
movi	v20.4s, #0x0
movi	v21.4s, #0x0
tbl	v1.16b, { v0.16b }, v28.16b
tbl	v2.16b, { v0.16b }, v29.16b
tbl	v3.16b, { v0.16b }, v30.16b
tbl	v17.16b, { v16.16b }, v28.16b
tbl	v18.16b, { v16.16b }, v29.16b
tbl	v19.16b, { v16.16b }, v30.16b
usdot	v4.4s, v1.16b, v26.4b[0]
usdot	v5.4s, v2.16b, v26.4b[0]
usdot	v20.4s, v17.16b, v26.4b[0]
usdot	v21.4s, v18.16b, v26.4b[0]
usdot	v4.4s, v2.16b, v26.4b[1]
usdot	v5.4s, v3.16b, v26.4b[1]
usdot	v20.4s, v18.16b, v26.4b[1]
usdot	v21.4s, v19.16b, v26.4b[1]
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v20.8h, v20.8h, v21.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v20.8h, v20.8h, #0x2
subs	w4, w4, #0x2
stp	q4, q20, [x0], #0x20
b.gt	L_213c
ret
L_21b0:
ldr	d26, [x5]
cmp	w9, #0xeac
b.eq	L_2224
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_21c8:
ldr	q16, [x1]
ldur	q17, [x1, #0x8]
add	x1, x1, x2
movi	v6.4s, #0x0
movi	v7.4s, #0x0
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v0.16b, { v16.16b }, v29.16b
tbl	v1.16b, { v16.16b }, v30.16b
tbl	v2.16b, { v17.16b }, v29.16b
tbl	v3.16b, { v17.16b }, v30.16b
usmmla	v6.4s, v0.16b, v26.16b
usmmla	v7.4s, v1.16b, v26.16b
usmmla	v22.4s, v2.16b, v26.16b
usmmla	v23.4s, v3.16b, v26.16b
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
srshr	v6.8h, v6.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
subs	w4, w4, #0x1
stp	q6, q22, [x0], #0x20
b.gt	L_21c8
ret
L_2224:
ldp	q29, q30, [x13, #0x10]
L_2228:
ldr	q16, [x1]
ldur	q17, [x1, #0xc]
add	x1, x1, x2
movi	v6.4s, #0x0
movi	v7.4s, #0x0
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
usdot	v6.4s, v0.16b, v26.4b[0]
usdot	v7.4s, v1.16b, v26.4b[0]
usdot	v22.4s, v2.16b, v26.4b[0]
usdot	v23.4s, v3.16b, v26.4b[0]
usdot	v6.4s, v1.16b, v26.4b[1]
usdot	v7.4s, v2.16b, v26.4b[1]
usdot	v22.4s, v3.16b, v26.4b[1]
usdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
srshr	v6.8h, v6.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
subs	w4, w4, #0x1
stp	q6, q22, [x0], #0x20
b.gt	L_2228
ret
L_2298:
ldr	d26, [x5]
sub	x2, x2, w3, uxtw
mov	w8, w3
cmp	w9, #0xeac
b.eq	L_2324
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_22b8:
ldr	q16, [x1]
ldur	q17, [x1, #0x8]
add	x1, x1, #0x10
movi	v6.4s, #0x0
movi	v7.4s, #0x0
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v0.16b, { v16.16b }, v29.16b
tbl	v1.16b, { v16.16b }, v30.16b
tbl	v2.16b, { v17.16b }, v29.16b
tbl	v3.16b, { v17.16b }, v30.16b
usmmla	v6.4s, v0.16b, v26.16b
usmmla	v7.4s, v1.16b, v26.16b
usmmla	v22.4s, v2.16b, v26.16b
usmmla	v23.4s, v3.16b, v26.16b
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
srshr	v6.8h, v6.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
subs	w8, w8, #0x10
stp	q6, q22, [x0], #0x20
b.gt	L_22b8
add	x1, x1, x2
mov	w8, w3
subs	w4, w4, #0x1
b.gt	L_22b8
ret
L_2324:
ldp	q29, q30, [x13, #0x10]
L_2328:
ldr	q16, [x1]
ldur	q17, [x1, #0xc]
add	x1, x1, #0x10
movi	v6.4s, #0x0
movi	v7.4s, #0x0
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
usdot	v6.4s, v0.16b, v26.4b[0]
usdot	v7.4s, v1.16b, v26.4b[0]
usdot	v22.4s, v2.16b, v26.4b[0]
usdot	v23.4s, v3.16b, v26.4b[0]
usdot	v6.4s, v1.16b, v26.4b[1]
usdot	v7.4s, v2.16b, v26.4b[1]
usdot	v22.4s, v3.16b, v26.4b[1]
usdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
srshr	v6.8h, v6.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
subs	w8, w8, #0x10
stp	q6, q22, [x0], #0x20
b.gt	L_2328
add	x1, x1, x2
mov	w8, w3
subs	w4, w4, #0x1
b.gt	L_2328
ret
put_8tap_sharp_8bpc_neon_i8mm:
mov	x9, #0xeac
mov	x10, #0xeac
b	put_8tap_neon_i8mm
put_8tap_sharp_smooth_8bpc_neon_i8mm:
mov	x9, #0xeac
mov	x10, #0x73b
b	put_8tap_neon_i8mm
put_8tap_sharp_regular_8bpc_neon_i8mm:
mov	x9, #0xeac
mov	x10, #-0x54
b	put_8tap_neon_i8mm
put_8tap_smooth_sharp_8bpc_neon_i8mm:
mov	x9, #0x73b
mov	x10, #0xeac
b	put_8tap_neon_i8mm
put_8tap_smooth_8bpc_neon_i8mm:
mov	x9, #0x73b
mov	x10, #0x73b
b	put_8tap_neon_i8mm
put_8tap_smooth_regular_8bpc_neon_i8mm:
mov	x9, #0x73b
mov	x10, #-0x54
b	put_8tap_neon_i8mm
put_8tap_regular_sharp_8bpc_neon_i8mm:
mov	x9, #-0x54
mov	x10, #0xeac
b	put_8tap_neon_i8mm
put_8tap_regular_smooth_8bpc_neon_i8mm:
mov	x9, #-0x54
mov	x10, #0x73b
b	put_8tap_neon_i8mm
put_8tap_regular_8bpc_neon_i8mm:
mov	x9, #-0x54
mov	x10, #-0x54
put_8tap_neon_i8mm:
clz	w8, w4
mov	w11, #0x4081
sub	w8, w8, #0x18
adrp	x12, mc_subpel_filters
add	x12, x12, :lo12:mc_subpel_filters
cbnz	w6, L_28e0
cbnz	w7, L_2430
b	put_neon
L_2430:
madd	w7, w7, w11, w10
adrp	x13, v_tbl_neon_dotprod
add	x13, x13, :lo12:v_tbl_neon_dotprod
sub	x2, x2, x3
ubfx	w11, w7, #7, #7
and	w7, w7, #0x7f
ldp	q6, q28, [x13]
cmp	w5, #0x4
csel	w7, w7, w11, le
sub	x2, x2, x3, lsl #1
add	x7, x12, x7, lsl #3
ldr	q29, [x13, #0x20]
ldr	d7, [x7]
cmp	w4, #0x8
b.eq	L_25c4
b.lt	L_2708
ldp	q30, q31, [x13, #0x30]
L_2474:
mov	x7, x2
mov	x6, x0
sub	w8, w5, #0x1
ldr	q16, [x7]
ldr	q17, [x7, x3]
add	x7, x7, x3, lsl #1
ldr	q18, [x7]
ldr	q19, [x7, x3]
add	x7, x7, x3, lsl #1
zip1	v0.16b, v16.16b, v17.16b
zip2	v1.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip2	v3.16b, v18.16b, v19.16b
ldr	q20, [x7]
ldr	q21, [x7, x3]
add	x7, x7, x3, lsl #1
ldr	q22, [x7]
ldr	q23, [x7, x3]
add	x7, x7, x3, lsl #1
zip1	v18.16b, v20.16b, v21.16b
zip2	v21.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip2	v27.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v22.8h, v1.8h, v3.8h
zip2	v25.8h, v1.8h, v3.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
zip1	v23.8h, v21.8h, v27.8h
zip2	v26.8h, v21.8h, v27.8h
L_24f0:
ld1	{ v18.16b }, [x7], x3
movi	v0.4s, #0x0
movi	v1.4s, #0x0
movi	v2.4s, #0x0
movi	v3.4s, #0x0
mov	v21.16b, v18.16b
mov	v24.16b, v18.16b
mov	v27.16b, v18.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v3.4s, v25.16b, v7.4b[0]
tbl	v16.16b, { v16.16b, v17.16b }, v6.16b
tbl	v19.16b, { v19.16b, v20.16b }, v6.16b
tbl	v22.16b, { v22.16b, v23.16b }, v6.16b
tbl	v25.16b, { v25.16b, v26.16b }, v6.16b
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v20.16b, v7.4b[1]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v26.16b, v7.4b[1]
tbl	v17.16b, { v17.16b, v18.16b }, v28.16b
tbl	v20.16b, { v20.16b, v21.16b }, v29.16b
tbl	v23.16b, { v23.16b, v24.16b }, v30.16b
tbl	v26.16b, { v26.16b, v27.16b }, v31.16b
subs	w8, w8, #0x1
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun2	v0.16b, v2.8h, #0x6
st1	{ v0.16b }, [x6], x1
b.gt	L_24f0
movi	v0.4s, #0x0
movi	v1.4s, #0x0
movi	v2.4s, #0x0
movi	v3.4s, #0x0
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v3.4s, v25.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v20.16b, v7.4b[1]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v26.16b, v7.4b[1]
subs	w4, w4, #0x10
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun2	v0.16b, v2.8h, #0x6
str	q0, [x6]
add	x0, x0, #0x10
add	x2, x2, #0x10
b.gt	L_2474
ret
L_25c4:
ldr	d16, [x2]
ldr	d17, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	d18, [x2]
ldr	d19, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	d20, [x2]
ldr	d21, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	d22, [x2]
ldr	d23, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
zip1	v0.16b, v16.16b, v17.16b
zip1	v2.16b, v18.16b, v19.16b
zip1	v18.16b, v20.16b, v21.16b
zip1	v24.16b, v22.16b, v23.16b
zip1	v16.8h, v0.8h, v2.8h
zip2	v19.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
zip2	v20.8h, v18.8h, v24.8h
b.eq	L_26a4
L_261c:
ldr	d18, [x2]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
ldr	d24, [x2, x3]
add	x2, x2, x3, lsl #1
movi	v2.4s, #0x0
movi	v3.4s, #0x0
mov	v21.8b, v18.8b
mov	v27.8b, v24.8b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
tbl	v16.16b, { v22.16b, v23.16b }, v6.16b
tbl	v19.16b, { v25.16b, v26.16b }, v6.16b
tbl	v17.16b, { v23.16b, v24.16b }, v28.16b
tbl	v20.16b, { v26.16b, v27.16b }, v29.16b
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v25.16b, v7.4b[0]
usdot	v3.4s, v26.16b, v7.4b[1]
subs	w5, w5, #0x2
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun	v1.8b, v2.8h, #0x6
str	d0, [x0]
str	d1, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_261c
L_26a4:
ldr	d18, [x2]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
movi	v2.4s, #0x0
movi	v3.4s, #0x0
mov	v21.8b, v18.8b
tbl	v22.16b, { v16.16b, v17.16b }, v6.16b
tbl	v25.16b, { v19.16b, v20.16b }, v6.16b
tbl	v23.16b, { v17.16b, v18.16b }, v28.16b
tbl	v26.16b, { v20.16b, v21.16b }, v29.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
usdot	v2.4s, v22.16b, v7.4b[0]
usdot	v2.4s, v23.16b, v7.4b[1]
usdot	v3.4s, v25.16b, v7.4b[0]
usdot	v3.4s, v26.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
uzp1	v2.8h, v2.8h, v3.8h
sqrshrun	v0.8b, v0.8h, #0x6
sqrshrun	v1.8b, v2.8h, #0x6
str	d0, [x0]
str	d1, [x0, x1]
ret
L_2708:
cmp	w4, #0x2
b.eq	L_27f8
ldr	s16, [x2]
ldr	s17, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	s18, [x2]
ldr	s19, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	s20, [x2]
ldr	s21, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	s22, [x2]
ldr	s23, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
zip1	v0.8b, v16.8b, v17.8b
zip1	v2.8b, v18.8b, v19.8b
zip1	v18.8b, v20.8b, v21.8b
zip1	v24.8b, v22.8b, v23.8b
zip1	v16.8h, v0.8h, v2.8h
zip1	v17.8h, v18.8h, v24.8h
b.eq	L_27b8
L_2760:
ldr	s18, [x2]
ldr	s21, [x2, x3]
add	x2, x2, x3, lsl #1
movi	v0.4s, #0x0
movi	v1.4s, #0x0
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
tbl	v16.16b, { v19.16b, v20.16b }, v6.16b
tbl	v17.16b, { v20.16b, v21.16b }, v28.16b
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d0
lsr	x9, x8, #32
str	w8, [x0]
str	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_2760
L_27b8:
ldr	s18, [x2]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
fmov	x8, d0
lsr	x9, x8, #32
str	w8, [x0]
str	w9, [x0, x1]
ret
L_27f8:
ldr	h16, [x2]
ldr	h17, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	h18, [x2]
ldr	h19, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	h20, [x2]
ldr	h21, [x2, x3]
add	x2, x2, x3, lsl #1
ldr	h22, [x2]
ldr	h23, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
zip1	v0.8b, v16.8b, v17.8b
zip1	v2.8b, v18.8b, v19.8b
zip1	v18.8b, v20.8b, v21.8b
zip1	v24.8b, v22.8b, v23.8b
zip1	v16.4h, v0.4h, v2.4h
zip1	v17.4h, v18.4h, v24.4h
b.eq	L_28a0
L_2848:
ldr	h18, [x2]
ldr	h21, [x2, x3]
add	x2, x2, x3, lsl #1
movi	v0.4s, #0x0
movi	v1.4s, #0x0
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
tbl	v16.16b, { v19.16b, v20.16b }, v6.16b
tbl	v17.16b, { v20.16b, v21.16b }, v28.16b
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d0
lsr	x9, x8, #32
strh	w8, [x0]
strh	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_2848
L_28a0:
ldr	h18, [x2]
movi	v0.4s, #0x0
movi	v1.4s, #0x0
tbl	v19.16b, { v16.16b, v17.16b }, v6.16b
tbl	v20.16b, { v17.16b, v18.16b }, v28.16b
usdot	v0.4s, v16.16b, v7.4b[0]
usdot	v0.4s, v17.16b, v7.4b[1]
usdot	v1.4s, v19.16b, v7.4b[0]
usdot	v1.4s, v20.16b, v7.4b[1]
uzp1	v0.8h, v0.8h, v1.8h
sqrshrun	v0.8b, v0.8h, #0x6
fmov	x8, d0
lsr	x9, x8, #32
strh	w8, [x0]
strh	w9, [x0, x1]
ret
L_28e0:
madd	w6, w6, w11, w9
madd	w14, w7, w11, w10
adrp	x13, h_tbl_neon_dotprod
add	x13, x13, :lo12:h_tbl_neon_dotprod
sub	x2, x2, #0x3
ldr	q28, [x13]
ubfx	w15, w6, #7, #7
and	w6, w6, #0x7f
ubfx	w11, w14, #7, #7
and	w14, w14, #0x7f
cmp	w4, #0x4
csel	w6, w6, w15, le
add	x6, x12, x6, lsl #3
cbz	w7, L_2ed0
cmp	w5, #0x4
csel	w14, w14, w11, le
sub	x2, x2, x3, lsl #1
add	x7, x12, x14, lsl #3
mov	x15, x30
ldr	d7, [x7]
ldr	q25, [x13, #0x50]
sshll	v7.8h, v7.8b, #0x0
cmp	w10, #0xeac
b.ne	L_2ba0
sub	x2, x2, x3
cmp	w4, #0x4
b.eq	L_2a50
b.lt	L_2af8
ldp	q29, q30, [x13, #0x10]
ldr	d26, [x6]
L_2958:
mov	x7, x2
mov	x6, x0
mov	w8, w5
bl	L_2d58
srshr	v16.8h, v22.8h, #0x2
bl	L_2d58
srshr	v17.8h, v22.8h, #0x2
bl	L_2d58
srshr	v18.8h, v22.8h, #0x2
bl	L_2d58
srshr	v19.8h, v22.8h, #0x2
bl	L_2d58
srshr	v20.8h, v22.8h, #0x2
bl	L_2d58
srshr	v21.8h, v22.8h, #0x2
bl	L_2d58
srshr	v22.8h, v22.8h, #0x2
L_299c:
ldr	q23, [x7]
add	x7, x7, x3
smull	v0.4s, v16.4h, v7.h[0]
smull2	v1.4s, v16.8h, v7.h[0]
mov	v16.16b, v17.16b
movi	v5.4s, #0x0
movi	v6.4s, #0x0
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
smlal	v0.4s, v17.4h, v7.h[1]
smlal2	v1.4s, v17.8h, v7.h[1]
tbl	v4.16b, { v23.16b }, v30.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal2	v1.4s, v18.8h, v7.h[2]
mov	v18.16b, v19.16b
usdot	v5.4s, v2.16b, v26.4b[0]
usdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v19.4h, v7.h[3]
smlal2	v1.4s, v19.8h, v7.h[3]
mov	v19.16b, v20.16b
usdot	v5.4s, v3.16b, v26.4b[1]
usdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v20.4h, v7.h[4]
smlal2	v1.4s, v20.8h, v7.h[4]
mov	v20.16b, v21.16b
smlal	v0.4s, v21.4h, v7.h[5]
smlal2	v1.4s, v21.8h, v7.h[5]
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
smlal2	v1.4s, v22.8h, v7.h[6]
subs	w8, w8, #0x1
rshrn	v22.4h, v5.4s, #0x2
rshrn2	v22.8h, v6.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
smlal2	v1.4s, v22.8h, v7.h[7]
tbl	v0.16b, { v0.16b, v1.16b }, v25.16b
sqrshrun	v0.8b, v0.8h, #0x2
st1	{ v0.8b }, [x6], x1
b.gt	L_299c
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	w4, w4, #0x8
b.gt	L_2958
ret	x15
L_2a50:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_2dac
shrn	v16.4h, v22.4s, #0x2
bl	L_2dac
shrn	v17.4h, v22.4s, #0x2
bl	L_2dac
shrn	v18.4h, v22.4s, #0x2
bl	L_2dac
shrn	v19.4h, v22.4s, #0x2
bl	L_2dac
shrn	v20.4h, v22.4s, #0x2
bl	L_2dac
shrn	v21.4h, v22.4s, #0x2
bl	L_2dac
shrn	v22.4h, v22.4s, #0x2
L_2a90:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[0]
smlal	v0.4s, v17.4h, v7.h[1]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal	v0.4s, v19.4h, v7.h[3]
tbl	v2.16b, { v4.16b }, v28.16b
movi	v5.4s, #0x0
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[4]
smlal	v0.4s, v21.4h, v7.h[5]
usdot	v5.4s, v2.16b, v26.4b[0]
mov	v20.16b, v21.16b
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
rshrn	v22.4h, v5.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
subs	w5, w5, #0x1
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	s0, [x0]
add	x0, x0, x1
b.gt	L_2a90
ret	x15
L_2af8:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_2dac
shrn	v16.4h, v22.4s, #0x2
bl	L_2dac
shrn	v17.4h, v22.4s, #0x2
bl	L_2dac
shrn	v18.4h, v22.4s, #0x2
bl	L_2dac
shrn	v19.4h, v22.4s, #0x2
bl	L_2dac
shrn	v20.4h, v22.4s, #0x2
bl	L_2dac
shrn	v21.4h, v22.4s, #0x2
bl	L_2dac
shrn	v22.4h, v22.4s, #0x2
L_2b38:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[0]
smlal	v0.4s, v17.4h, v7.h[1]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[2]
smlal	v0.4s, v19.4h, v7.h[3]
tbl	v2.16b, { v4.16b }, v28.16b
movi	v5.4s, #0x0
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[4]
smlal	v0.4s, v21.4h, v7.h[5]
usdot	v5.4s, v2.16b, v26.4b[0]
mov	v20.16b, v21.16b
mov	v21.16b, v22.16b
smlal	v0.4s, v22.4h, v7.h[6]
rshrn	v22.4h, v5.4s, #0x2
smlal	v0.4s, v22.4h, v7.h[7]
subs	w5, w5, #0x1
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	h0, [x0]
add	x0, x0, x1
b.gt	L_2b38
ret	x15
L_2ba0:
cmp	w4, #0x4
b.eq	L_2dc0
b.lt	L_2e48
ldr	d26, [x6]
cmp	w9, #0xeac
b.eq	L_2c84
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_2bc4:
mov	x7, x2
mov	x6, x0
mov	w8, w5
bl	L_2d88
srshr	v16.8h, v22.8h, #0x2
bl	L_2d88
srshr	v17.8h, v22.8h, #0x2
bl	L_2d88
srshr	v18.8h, v22.8h, #0x2
bl	L_2d88
srshr	v19.8h, v22.8h, #0x2
bl	L_2d88
srshr	v20.8h, v22.8h, #0x2
L_2bf8:
ld1	{ v23.16b }, [x7], x3
smull	v0.4s, v16.4h, v7.h[1]
smull2	v1.4s, v16.8h, v7.h[1]
mov	v16.16b, v17.16b
movi	v5.4s, #0x0
movi	v6.4s, #0x0
tbl	v2.16b, { v23.16b }, v29.16b
tbl	v3.16b, { v23.16b }, v30.16b
smlal	v0.4s, v17.4h, v7.h[2]
smlal2	v1.4s, v17.8h, v7.h[2]
mov	v17.16b, v18.16b
usmmla	v5.4s, v2.16b, v26.16b
usmmla	v6.4s, v3.16b, v26.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal2	v1.4s, v18.8h, v7.h[3]
mov	v18.16b, v19.16b
subs	w8, w8, #0x1
smlal	v0.4s, v19.4h, v7.h[4]
smlal2	v1.4s, v19.8h, v7.h[4]
uzp1	v23.8h, v5.8h, v6.8h
mov	v19.16b, v20.16b
smlal	v0.4s, v20.4h, v7.h[5]
smlal2	v1.4s, v20.8h, v7.h[5]
srshr	v20.8h, v23.8h, #0x2
smlal	v0.4s, v20.4h, v7.h[6]
smlal2	v1.4s, v20.8h, v7.h[6]
tbl	v0.16b, { v0.16b, v1.16b }, v25.16b
sqrshrun	v0.8b, v0.8h, #0x2
st1	{ v0.8b }, [x6], x1
b.gt	L_2bf8
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	w4, w4, #0x8
b.gt	L_2bc4
ret	x15
L_2c84:
ldp	q29, q30, [x13, #0x10]
L_2c88:
mov	x7, x2
mov	x6, x0
mov	w8, w5
bl	L_2d58
srshr	v16.8h, v22.8h, #0x2
bl	L_2d58
srshr	v17.8h, v22.8h, #0x2
bl	L_2d58
srshr	v18.8h, v22.8h, #0x2
bl	L_2d58
srshr	v19.8h, v22.8h, #0x2
bl	L_2d58
srshr	v20.8h, v22.8h, #0x2
L_2cbc:
ldr	q23, [x7]
add	x7, x7, x3
smull	v0.4s, v16.4h, v7.h[1]
smull2	v1.4s, v16.8h, v7.h[1]
mov	v16.16b, v17.16b
movi	v5.4s, #0x0
movi	v6.4s, #0x0
tbl	v2.16b, { v23.16b }, v28.16b
tbl	v3.16b, { v23.16b }, v29.16b
smlal	v0.4s, v17.4h, v7.h[2]
smlal2	v1.4s, v17.8h, v7.h[2]
tbl	v4.16b, { v23.16b }, v30.16b
mov	v17.16b, v18.16b
usdot	v5.4s, v2.16b, v26.4b[0]
usdot	v6.4s, v3.16b, v26.4b[0]
smlal	v0.4s, v18.4h, v7.h[3]
smlal2	v1.4s, v18.8h, v7.h[3]
mov	v18.16b, v19.16b
usdot	v5.4s, v3.16b, v26.4b[1]
usdot	v6.4s, v4.16b, v26.4b[1]
smlal	v0.4s, v19.4h, v7.h[4]
smlal2	v1.4s, v19.8h, v7.h[4]
mov	v19.16b, v20.16b
uzp1	v23.8h, v5.8h, v6.8h
smlal	v0.4s, v20.4h, v7.h[5]
smlal2	v1.4s, v20.8h, v7.h[5]
srshr	v20.8h, v23.8h, #0x2
subs	w8, w8, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
smlal2	v1.4s, v20.8h, v7.h[6]
tbl	v0.16b, { v0.16b, v1.16b }, v25.16b
sqrshrun	v0.8b, v0.8h, #0x2
st1	{ v0.8b }, [x6], x1
b.gt	L_2cbc
add	x0, x0, #0x8
add	x2, x2, #0x8
subs	w4, w4, #0x8
b.gt	L_2c88
ret	x15
L_2d58:
ld1	{ v4.16b }, [x7], x3
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v2.16b, { v4.16b }, v28.16b
tbl	v3.16b, { v4.16b }, v29.16b
tbl	v4.16b, { v4.16b }, v30.16b
usdot	v22.4s, v2.16b, v26.4b[0]
usdot	v23.4s, v3.16b, v26.4b[0]
usdot	v22.4s, v3.16b, v26.4b[1]
usdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v22.8h, v22.8h, v23.8h
ret
L_2d88:
ld1	{ v4.16b }, [x7], x3
movi	v22.4s, #0x0
movi	v23.4s, #0x0
tbl	v2.16b, { v4.16b }, v29.16b
tbl	v3.16b, { v4.16b }, v30.16b
usmmla	v22.4s, v2.16b, v26.16b
usmmla	v23.4s, v3.16b, v26.16b
uzp1	v22.8h, v22.8h, v23.8h
ret
L_2dac:
ld1	{ v4.8b }, [x2], x3
movi	v22.4s, #0x2
tbl	v2.16b, { v4.16b }, v28.16b
usdot	v22.4s, v2.16b, v26.4b[0]
ret
L_2dc0:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_2dac
shrn	v16.4h, v22.4s, #0x2
bl	L_2dac
shrn	v17.4h, v22.4s, #0x2
bl	L_2dac
shrn	v18.4h, v22.4s, #0x2
bl	L_2dac
shrn	v19.4h, v22.4s, #0x2
bl	L_2dac
shrn	v20.4h, v22.4s, #0x2
L_2df0:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[1]
smlal	v0.4s, v17.4h, v7.h[2]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal	v0.4s, v19.4h, v7.h[4]
tbl	v2.16b, { v4.16b }, v28.16b
movi	v5.4s, #0x0
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
usdot	v5.4s, v2.16b, v26.4b[0]
smlal	v0.4s, v20.4h, v7.h[5]
rshrn	v20.4h, v5.4s, #0x2
subs	w5, w5, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	s0, [x0]
add	x0, x0, x1
b.gt	L_2df0
ret	x15
L_2e48:
ldur	s26, [x6, #0x2]
add	x2, x2, #0x2
bl	L_2dac
shrn	v16.4h, v22.4s, #0x2
bl	L_2dac
shrn	v17.4h, v22.4s, #0x2
bl	L_2dac
shrn	v18.4h, v22.4s, #0x2
bl	L_2dac
shrn	v19.4h, v22.4s, #0x2
bl	L_2dac
shrn	v20.4h, v22.4s, #0x2
L_2e78:
ld1	{ v4.8b }, [x2], x3
smull	v0.4s, v16.4h, v7.h[1]
smlal	v0.4s, v17.4h, v7.h[2]
mov	v16.16b, v17.16b
mov	v17.16b, v18.16b
smlal	v0.4s, v18.4h, v7.h[3]
smlal	v0.4s, v19.4h, v7.h[4]
tbl	v2.16b, { v4.16b }, v28.16b
movi	v5.4s, #0x0
mov	v18.16b, v19.16b
mov	v19.16b, v20.16b
usdot	v5.4s, v2.16b, v26.4b[0]
smlal	v0.4s, v20.4h, v7.h[5]
rshrn	v20.4h, v5.4s, #0x2
subs	w5, w5, #0x1
smlal	v0.4s, v20.4h, v7.h[6]
tbl	v0.8b, { v0.16b }, v25.8b
sqrshrun	v0.8b, v0.8h, #0x2
str	h0, [x0]
add	x0, x0, x1
b.gt	L_2e78
ret	x15
L_2ed0:
adrp	x11, put_8tap_h_neon_i8mm_tbl
add	x11, x11, :lo12:put_8tap_h_neon_i8mm_tbl
ldrsw	x8, [x11, x8, lsl #2]
movi	v27.4s, #0x22
add	x11, x11, x8
br	x11
L_2ee8:
add	x2, x2, #0x2
ldur	s26, [x6, #0x2]
L_2ef0:
ldr	d0, [x2]
ldr	d1, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
tbl	v2.16b, { v0.16b }, v28.16b
tbl	v3.16b, { v1.16b }, v28.16b
usdot	v4.4s, v2.16b, v26.4b[0]
usdot	v5.4s, v3.16b, v26.4b[0]
uzp1	v4.8h, v4.8h, v5.8h
sqshrun	v4.8b, v4.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d4
lsr	x9, x8, #32
strh	w8, [x0]
strh	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_2ef0
ret
L_2f3c:
add	x2, x2, #0x2
ldur	s26, [x6, #0x2]
L_2f44:
ldr	d0, [x2]
ldr	d1, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
tbl	v2.16b, { v0.16b }, v28.16b
tbl	v3.16b, { v1.16b }, v28.16b
usdot	v4.4s, v2.16b, v26.4b[0]
usdot	v5.4s, v3.16b, v26.4b[0]
uzp1	v4.8h, v4.8h, v5.8h
sqshrun	v4.8b, v4.8h, #0x6
subs	w5, w5, #0x2
fmov	x8, d4
lsr	x9, x8, #32
str	w8, [x0]
str	w9, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_2f44
ret
L_2f90:
ldr	d26, [x6]
cmp	w9, #0xeac
b.eq	L_300c
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_2fa8:
ldr	q0, [x2]
ldr	q16, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
mov	v20.16b, v27.16b
mov	v21.16b, v27.16b
tbl	v1.16b, { v0.16b }, v29.16b
tbl	v2.16b, { v0.16b }, v30.16b
tbl	v17.16b, { v16.16b }, v29.16b
tbl	v18.16b, { v16.16b }, v30.16b
usmmla	v4.4s, v1.16b, v26.16b
usmmla	v5.4s, v2.16b, v26.16b
usmmla	v20.4s, v17.16b, v26.16b
usmmla	v21.4s, v18.16b, v26.16b
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v20.8h, v20.8h, v21.8h
sqshrun	v4.8b, v4.8h, #0x6
sqshrun	v20.8b, v20.8h, #0x6
subs	w5, w5, #0x2
str	d4, [x0]
str	d20, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_2fa8
ret
L_300c:
ldp	q29, q30, [x13, #0x10]
L_3010:
ldr	q0, [x2]
ldr	q16, [x2, x3]
add	x2, x2, x3, lsl #1
mov	v4.16b, v27.16b
mov	v5.16b, v27.16b
mov	v20.16b, v27.16b
mov	v21.16b, v27.16b
tbl	v1.16b, { v0.16b }, v28.16b
tbl	v2.16b, { v0.16b }, v29.16b
tbl	v3.16b, { v0.16b }, v30.16b
tbl	v17.16b, { v16.16b }, v28.16b
tbl	v18.16b, { v16.16b }, v29.16b
tbl	v19.16b, { v16.16b }, v30.16b
usdot	v4.4s, v1.16b, v26.4b[0]
usdot	v5.4s, v2.16b, v26.4b[0]
usdot	v20.4s, v17.16b, v26.4b[0]
usdot	v21.4s, v18.16b, v26.4b[0]
usdot	v4.4s, v2.16b, v26.4b[1]
usdot	v5.4s, v3.16b, v26.4b[1]
usdot	v20.4s, v18.16b, v26.4b[1]
usdot	v21.4s, v19.16b, v26.4b[1]
uzp1	v4.8h, v4.8h, v5.8h
uzp1	v20.8h, v20.8h, v21.8h
sqshrun	v4.8b, v4.8h, #0x6
sqshrun	v20.8b, v20.8h, #0x6
subs	w5, w5, #0x2
str	d4, [x0]
str	d20, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	L_3010
ret
L_308c:
ldr	d26, [x6]
cmp	w9, #0xeac
b.eq	L_3100
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_30a4:
ldr	q16, [x2]
ldur	q17, [x2, #0x8]
add	x2, x2, x3
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v29.16b
tbl	v1.16b, { v16.16b }, v30.16b
tbl	v2.16b, { v17.16b }, v29.16b
tbl	v3.16b, { v17.16b }, v30.16b
usmmla	v6.4s, v0.16b, v26.16b
usmmla	v7.4s, v1.16b, v26.16b
usmmla	v22.4s, v2.16b, v26.16b
usmmla	v23.4s, v3.16b, v26.16b
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sqshrun	v6.8b, v6.8h, #0x6
sqshrun2	v6.16b, v22.8h, #0x6
subs	w5, w5, #0x1
st1	{ v6.16b }, [x0], x1
b.gt	L_30a4
ret
L_3100:
ldp	q29, q30, [x13, #0x10]
L_3104:
ldr	q16, [x2]
ldur	q17, [x2, #0xc]
add	x2, x2, x3
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
usdot	v6.4s, v0.16b, v26.4b[0]
usdot	v7.4s, v1.16b, v26.4b[0]
usdot	v22.4s, v2.16b, v26.4b[0]
usdot	v23.4s, v3.16b, v26.4b[0]
usdot	v6.4s, v1.16b, v26.4b[1]
usdot	v7.4s, v2.16b, v26.4b[1]
usdot	v22.4s, v3.16b, v26.4b[1]
usdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sqshrun	v6.8b, v6.8h, #0x6
sqshrun2	v6.16b, v22.8h, #0x6
subs	w5, w5, #0x1
st1	{ v6.16b }, [x0], x1
b.gt	L_3104
ret
L_3174:
ldr	d26, [x6]
sub	x1, x1, w4, uxtw
sub	x3, x3, w4, uxtw
mov	w8, w4
cmp	w9, #0xeac
b.eq	L_3208
ldp	q29, q30, [x13, #0x30]
ext	v0.8b, v26.8b, v26.8b, #0x7
mov	v26.d[1], v0.d[0]
L_3198:
ldr	q16, [x2]
ldur	q17, [x2, #0x8]
add	x2, x2, #0x10
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v29.16b
tbl	v1.16b, { v16.16b }, v30.16b
tbl	v2.16b, { v17.16b }, v29.16b
tbl	v3.16b, { v17.16b }, v30.16b
usmmla	v6.4s, v0.16b, v26.16b
usmmla	v7.4s, v1.16b, v26.16b
usmmla	v22.4s, v2.16b, v26.16b
usmmla	v23.4s, v3.16b, v26.16b
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sqshrun	v6.8b, v6.8h, #0x6
sqshrun2	v6.16b, v22.8h, #0x6
subs	w8, w8, #0x10
str	q6, [x0], #0x10
b.gt	L_3198
add	x2, x2, x3
add	x0, x0, x1
mov	w8, w4
subs	w5, w5, #0x1
b.gt	L_3198
ret
L_3208:
ldp	q29, q30, [x13, #0x10]
L_320c:
ldr	q16, [x2]
ldur	q17, [x2, #0xc]
add	x2, x2, #0x10
mov	v6.16b, v27.16b
mov	v7.16b, v27.16b
mov	v22.16b, v27.16b
mov	v23.16b, v27.16b
tbl	v0.16b, { v16.16b }, v28.16b
tbl	v1.16b, { v16.16b }, v29.16b
tbl	v2.16b, { v16.16b }, v30.16b
tbl	v3.16b, { v17.16b }, v28.16b
tbl	v4.16b, { v17.16b }, v29.16b
usdot	v6.4s, v0.16b, v26.4b[0]
usdot	v7.4s, v1.16b, v26.4b[0]
usdot	v22.4s, v2.16b, v26.4b[0]
usdot	v23.4s, v3.16b, v26.4b[0]
usdot	v6.4s, v1.16b, v26.4b[1]
usdot	v7.4s, v2.16b, v26.4b[1]
usdot	v22.4s, v3.16b, v26.4b[1]
usdot	v23.4s, v4.16b, v26.4b[1]
uzp1	v6.8h, v6.8h, v7.8h
uzp1	v22.8h, v22.8h, v23.8h
sqshrun	v6.8b, v6.8h, #0x6
sqshrun2	v6.16b, v22.8h, #0x6
subs	w8, w8, #0x10
str	q6, [x0], #0x10
b.gt	L_320c
add	x2, x2, x3
add	x0, x0, x1
mov	w8, w4
subs	w5, w5, #0x1
b.gt	L_320c
ret
	.section *UND*
	.section .rodata
h_tbl_neon_dotprod:
	.size h_tbl_neon_dotprod, 96
	.byte 0,1,2,3,1,2,3,4,2,3,4,5,3,4,5,6
	.byte 4,5,6,7,5,6,7,8,6,7,8,9,7,8,9,10
	.byte 8,9,10,11,9,10,11,12,10,11,12,13,11,12,13,14
	.byte 0,1,2,3,4,5,6,7,2,3,4,5,6,7,8,9
	.byte 4,5,6,7,8,9,10,11,6,7,8,9,10,11,12,13
	.byte 1,2,5,6,9,10,13,14,17,18,21,22,25,26,29,30
v_tbl_neon_dotprod:
	.size v_tbl_neon_dotprod, 80
	.byte 1,2,3,16,5,6,7,20,9,10,11,24,13,14,15,28
	.byte 1,2,3,16,5,6,7,17,9,10,11,18,13,14,15,19
	.byte 1,2,3,20,5,6,7,21,9,10,11,22,13,14,15,23
	.byte 1,2,3,24,5,6,7,25,9,10,11,26,13,14,15,27
	.byte 1,2,3,28,5,6,7,29,9,10,11,30,13,14,15,31
prep_8tap_h_neon_dotprod_tbl:
	.size prep_8tap_h_neon_dotprod_tbl, 24
	.word L_9bc - prep_8tap_h_neon_dotprod_tbl
	.word L_9bc - prep_8tap_h_neon_dotprod_tbl
	.word L_9bc - prep_8tap_h_neon_dotprod_tbl
	.word L_93c - prep_8tap_h_neon_dotprod_tbl
	.word L_8b8 - prep_8tap_h_neon_dotprod_tbl
	.word L_86c - prep_8tap_h_neon_dotprod_tbl
put_8tap_h_neon_dotprod_tbl:
	.size put_8tap_h_neon_dotprod_tbl, 28
	.word L_1700 - put_8tap_h_neon_dotprod_tbl
	.word L_1700 - put_8tap_h_neon_dotprod_tbl
	.word L_1700 - put_8tap_h_neon_dotprod_tbl
	.word L_1680 - put_8tap_h_neon_dotprod_tbl
	.word L_15f4 - put_8tap_h_neon_dotprod_tbl
	.word L_1598 - put_8tap_h_neon_dotprod_tbl
	.word L_153c - put_8tap_h_neon_dotprod_tbl
prep_8tap_h_neon_i8mm_tbl:
	.size prep_8tap_h_neon_i8mm_tbl, 24
	.word L_2298 - prep_8tap_h_neon_i8mm_tbl
	.word L_2298 - prep_8tap_h_neon_i8mm_tbl
	.word L_2298 - prep_8tap_h_neon_i8mm_tbl
	.word L_21b0 - prep_8tap_h_neon_i8mm_tbl
	.word L_20c4 - prep_8tap_h_neon_i8mm_tbl
	.word L_2080 - prep_8tap_h_neon_i8mm_tbl
put_8tap_h_neon_i8mm_tbl:
	.size put_8tap_h_neon_i8mm_tbl, 28
	.word L_3174 - put_8tap_h_neon_i8mm_tbl
	.word L_3174 - put_8tap_h_neon_i8mm_tbl
	.word L_3174 - put_8tap_h_neon_i8mm_tbl
	.word L_308c - put_8tap_h_neon_i8mm_tbl
	.word L_2f90 - put_8tap_h_neon_i8mm_tbl
	.word L_2f3c - put_8tap_h_neon_i8mm_tbl
	.word L_2ee8 - put_8tap_h_neon_i8mm_tbl
// ---- mc.S, for prep_neon, put_neon
	.text
	.text
avg_8bpc_neon:
clz	w4, w4
adrp	x7, avg_tbl
add	x7, x7, :lo12:avg_tbl
sub	w4, w4, #0x18
ldrsw	x4, [x7, x4, lsl #2]
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
add	x7, x7, x4
br	x7
Lmc__34:
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
b.eq	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
cmp	w5, #0x8
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
b.eq	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
ret
Lmc__d8:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__e0:
st1	{ v4.8b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v5.d }[1], [x7], x1
b.le	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	Lmc__e0
Lmc__12c:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
st1	{ v4.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
st1	{ v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
st1	{ v6.16b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v7.16b }, [x0], x1
b.le	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	Lmc__12c
Lmc__1a8:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__1b0:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
st1	{ v4.16b, v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
subs	w5, w5, #0x2
st1	{ v6.16b, v7.16b }, [x7], x1
b.le	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	Lmc__1b0
Lmc__224:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__22c:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v16.8b, v0.8h, #0x5
sqrshrun2	v16.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v17.8b, v0.8h, #0x5
sqrshrun2	v17.16b, v1.8h, #0x5
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v18.8b, v0.8h, #0x5
sqrshrun2	v18.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v19.8b, v0.8h, #0x5
sqrshrun2	v19.16b, v1.8h, #0x5
subs	w5, w5, #0x2
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	Lmc__22c
Lmc__300:
add	x7, x0, #0x40
Lmc__304:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v5.8b, v0.8h, #0x5
sqrshrun2	v5.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v6.8b, v0.8h, #0x5
sqrshrun2	v6.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v7.8b, v0.8h, #0x5
sqrshrun2	v7.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v16.8b, v0.8h, #0x5
sqrshrun2	v16.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v17.8b, v0.8h, #0x5
sqrshrun2	v17.16b, v1.8h, #0x5
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v18.8b, v0.8h, #0x5
sqrshrun2	v18.16b, v1.8h, #0x5
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v19.8b, v0.8h, #0x5
sqrshrun2	v19.16b, v1.8h, #0x5
subs	w5, w5, #0x1
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	Lmc__3d8
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
add	v0.8h, v0.8h, v2.8h
add	v1.8h, v1.8h, v3.8h
sqrshrun	v4.8b, v0.8h, #0x5
sqrshrun2	v4.16b, v1.8h, #0x5
b	Lmc__304
Lmc__3d8:
ret
w_avg_8bpc_neon:
clz	w4, w4
dup	v30.8h, w6
neg	v30.8h, v30.8h
shl	v30.8h, v30.8h, #0xb
adrp	x7, w_avg_tbl
add	x7, x7, :lo12:w_avg_tbl
sub	w4, w4, #0x18
ldrsw	x4, [x7, x4, lsl #2]
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
add	x7, x7, x4
br	x7
Lmc__42c:
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
b.eq	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
cmp	w5, #0x8
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
b.eq	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
ret
Lmc__500:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__508:
st1	{ v4.8b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v5.d }[1], [x7], x1
b.le	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__508
Lmc__574:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
st1	{ v6.16b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v7.16b }, [x0], x1
b.le	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__574
Lmc__630:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__638:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v6.16b, v7.16b }, [x7], x1
b.le	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__638
Lmc__6ec:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__6f4:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__6f4
Lmc__848:
add	x7, x0, #0x40
Lmc__84c:
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x1
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	Lmc__9a0
ld1	{ v0.8h, v1.8h }, [x2], #32
ld1	{ v2.8h, v3.8h }, [x3], #32
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v30.8h
sqdmulh	v1.8h, v1.8h, v30.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__84c
Lmc__9a0:
ret
mask_8bpc_neon:
clz	w4, w4
movi	v31.16b, #0xfe
adrp	x7, mask_tbl
add	x7, x7, :lo12:mask_tbl
sub	w4, w4, #0x18
ldrsw	x4, [x7, x4, lsl #2]
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
add	x7, x7, x4
br	x7
Lmc__9fc:
add	x7, x0, x1
lsl	x1, x1, #1
cmp	w5, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
b.eq	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
cmp	w5, #0x8
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
b.eq	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x7], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.s }[2], [x0], x1
st1	{ v4.s }[3], [x7], x1
st1	{ v5.s }[0], [x0], x1
st1	{ v5.s }[1], [x7], x1
st1	{ v5.s }[2], [x0], x1
st1	{ v5.s }[3], [x7], x1
ret
Lmc__b00:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__b08:
st1	{ v4.8b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.d }[1], [x7], x1
st1	{ v5.8b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v5.d }[1], [x7], x1
b.le	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__b08
Lmc__b94:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
st1	{ v4.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v5.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
st1	{ v6.16b }, [x0], x1
subs	w5, w5, #0x4
st1	{ v7.16b }, [x0], x1
b.le	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__b94
Lmc__c90:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__c98:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v6.16b, v7.16b }, [x7], x1
b.le	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__c98
Lmc__d8c:
add	x7, x0, x1
lsl	x1, x1, #1
Lmc__d94:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x2
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__d94
Lmc__f68:
add	x7, x0, #0x40
Lmc__f6c:
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v5.8b, v0.8h, #0x4
sqrshrun2	v5.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v6.8b, v0.8h, #0x4
sqrshrun2	v6.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v7.8b, v0.8h, #0x4
sqrshrun2	v7.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v16.8b, v0.8h, #0x4
sqrshrun2	v16.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v17.8b, v0.8h, #0x4
sqrshrun2	v17.16b, v1.8h, #0x4
st1	{ v4.16b, v5.16b, v6.16b, v7.16b }, [x0], x1
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v18.8b, v0.8h, #0x4
sqrshrun2	v18.16b, v1.8h, #0x4
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v19.8b, v0.8h, #0x4
sqrshrun2	v19.16b, v1.8h, #0x4
subs	w5, w5, #0x1
st1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x7], x1
b.le	Lmc__1140
ld1	{ v30.16b }, [x6], #16
ld1	{ v0.8h, v1.8h }, [x2], #32
mul	v30.16b, v30.16b, v31.16b
ld1	{ v2.8h, v3.8h }, [x3], #32
shll	v28.8h, v30.8b, #8
shll2	v29.8h, v30.16b, #8
sub	v0.8h, v2.8h, v0.8h
sub	v1.8h, v3.8h, v1.8h
sqdmulh	v0.8h, v0.8h, v28.8h
sqdmulh	v1.8h, v1.8h, v29.8h
add	v0.8h, v2.8h, v0.8h
add	v1.8h, v3.8h, v1.8h
sqrshrun	v4.8b, v0.8h, #0x4
sqrshrun2	v4.16b, v1.8h, #0x4
b	Lmc__f6c
Lmc__1140:
ret
w_mask_444_8bpc_neon:
clz	w8, w4
adrp	x9, w_mask_444_tbl
add	x9, x9, :lo12:w_mask_444_tbl
sub	w8, w8, #0x18
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
mov	w10, #0x1af7
dup	v0.8h, w10
movi	v1.16b, #0x40
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
Lmc__1174:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
uzp1	v18.16b, v18.16b, v19.16b
sub	v18.16b, v1.16b, v18.16b
st1	{ v18.16b }, [x6], #16
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x12], x1
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x12], x1
b.gt	Lmc__1174
ret
Lmc__11e4:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
uzp1	v18.16b, v18.16b, v19.16b
sub	v18.16b, v1.16b, v18.16b
st1	{ v18.16b }, [x6], #16
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x12], x1
b.gt	Lmc__11e4
ret
Lmc__124c:
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x10, x6, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
Lmc__1260:
mov	w8, w4
Lmc__1264:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
ld1	{ v16.8h, v17.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
sub	v18.8h, v18.8h, v16.8h
sub	v19.8h, v19.8h, v17.8h
abs	v20.8h, v6.8h
abs	v21.8h, v7.8h
abs	v22.8h, v18.8h
abs	v23.8h, v19.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
ushr	v20.8h, v20.8h, #0x8
ushr	v21.8h, v21.8h, #0x8
ushr	v22.8h, v22.8h, #0x8
ushr	v23.8h, v23.8h, #0x8
shl	v24.8h, v20.8h, #0x9
shl	v25.8h, v21.8h, #0x9
shl	v26.8h, v22.8h, #0x9
shl	v27.8h, v23.8h, #0x9
sqdmulh	v24.8h, v24.8h, v6.8h
sqdmulh	v25.8h, v25.8h, v7.8h
sqdmulh	v26.8h, v26.8h, v18.8h
sqdmulh	v27.8h, v27.8h, v19.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v16.8h
add	v27.8h, v27.8h, v17.8h
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun	v25.8b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun	v27.8b, v27.8h, #0x4
uzp1	v20.16b, v20.16b, v21.16b
uzp1	v21.16b, v22.16b, v23.16b
sub	v20.16b, v1.16b, v20.16b
sub	v21.16b, v1.16b, v21.16b
st1	{ v20.16b }, [x6], #16
st1	{ v21.16b }, [x10], #16
st1	{ v24.8b, v25.8b }, [x0], #16
st1	{ v26.8b, v27.8b }, [x12], #16
b.gt	Lmc__1264
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, w4, uxtw
add	x10, x10, w4, uxtw
add	x0, x0, x1
add	x12, x12, x1
b.gt	Lmc__1260
ret
w_mask_422_8bpc_neon:
clz	w8, w4
adrp	x9, w_mask_422_tbl
add	x9, x9, :lo12:w_mask_422_tbl
sub	w8, w8, #0x18
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
mov	w10, #0x1af7
dup	v0.8h, w10
dup	v2.8b, w7
movi	v3.8b, #0x81
sub	v3.8b, v3.8b, v2.8b
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
Lmc__1380:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
addp	v18.8h, v18.8h, v19.8h
xtn	v18.8b, v18.8h
uhsub	v18.8b, v3.8b, v18.8b
st1	{ v18.8b }, [x6], #8
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x12], x1
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x12], x1
b.gt	Lmc__1380
ret
Lmc__13f4:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
addp	v18.8h, v18.8h, v19.8h
xtn	v18.8b, v18.8h
uhsub	v18.8b, v3.8b, v18.8b
st1	{ v18.8b }, [x6], #8
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x12], x1
b.gt	Lmc__13f4
ret
Lmc__1460:
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x10, x6, x11, lsr #1
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
Lmc__1474:
mov	w8, w4
Lmc__1478:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
ld1	{ v16.8h, v17.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
sub	v18.8h, v18.8h, v16.8h
sub	v19.8h, v19.8h, v17.8h
abs	v20.8h, v6.8h
abs	v21.8h, v7.8h
abs	v22.8h, v18.8h
abs	v23.8h, v19.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
ushr	v20.8h, v20.8h, #0x8
ushr	v21.8h, v21.8h, #0x8
ushr	v22.8h, v22.8h, #0x8
ushr	v23.8h, v23.8h, #0x8
shl	v24.8h, v20.8h, #0x9
shl	v25.8h, v21.8h, #0x9
shl	v26.8h, v22.8h, #0x9
shl	v27.8h, v23.8h, #0x9
sqdmulh	v24.8h, v24.8h, v6.8h
sqdmulh	v25.8h, v25.8h, v7.8h
sqdmulh	v26.8h, v26.8h, v18.8h
sqdmulh	v27.8h, v27.8h, v19.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v16.8h
add	v27.8h, v27.8h, v17.8h
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun	v25.8b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun	v27.8b, v27.8h, #0x4
addp	v20.8h, v20.8h, v21.8h
addp	v21.8h, v22.8h, v23.8h
xtn	v20.8b, v20.8h
xtn	v21.8b, v21.8h
uhsub	v20.8b, v3.8b, v20.8b
uhsub	v21.8b, v3.8b, v21.8b
st1	{ v20.8b }, [x6], #8
st1	{ v21.8b }, [x10], #8
st1	{ v24.8b, v25.8b }, [x0], #16
st1	{ v26.8b, v27.8b }, [x12], #16
b.gt	Lmc__1478
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x6, x6, x11, lsr #1
add	x10, x10, x11, lsr #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	Lmc__1474
ret
w_mask_420_8bpc_neon:
clz	w8, w4
adrp	x9, w_mask_420_tbl
add	x9, x9, :lo12:w_mask_420_tbl
sub	w8, w8, #0x18
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
mov	w10, #0x1af7
dup	v0.8h, w10
dup	v2.8h, w7
movi	v3.8h, #0x1, lsl #8
sub	v3.8h, v3.8h, v2.8h
add	x12, x0, x1
lsl	x1, x1, #1
br	x9
Lmc__159c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x4
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
trn1	v24.2d, v18.2d, v19.2d
trn2	v25.2d, v18.2d, v19.2d
add	v24.8h, v24.8h, v25.8h
addp	v18.8h, v24.8h, v24.8h
sub	v18.4h, v3.4h, v18.4h
rshrn	v18.8b, v18.8h, #0x2
str	s18, [x6], #0x4
st1	{ v22.s }[0], [x0], x1
st1	{ v22.s }[1], [x12], x1
st1	{ v23.s }[0], [x0], x1
st1	{ v23.s }[1], [x12], x1
b.gt	Lmc__159c
ret
Lmc__161c:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
subs	w5, w5, #0x2
sub	v16.8h, v6.8h, v4.8h
sub	v17.8h, v7.8h, v5.8h
sabd	v18.8h, v4.8h, v6.8h
sabd	v19.8h, v5.8h, v7.8h
uqsub	v18.8h, v0.8h, v18.8h
uqsub	v19.8h, v0.8h, v19.8h
ushr	v18.8h, v18.8h, #0x8
ushr	v19.8h, v19.8h, #0x8
shl	v20.8h, v18.8h, #0x9
shl	v21.8h, v19.8h, #0x9
sqdmulh	v20.8h, v20.8h, v16.8h
sqdmulh	v21.8h, v21.8h, v17.8h
add	v20.8h, v20.8h, v4.8h
add	v21.8h, v21.8h, v5.8h
sqrshrun	v22.8b, v20.8h, #0x4
sqrshrun	v23.8b, v21.8h, #0x4
add	v18.8h, v18.8h, v19.8h
addp	v18.8h, v18.8h, v18.8h
sub	v18.4h, v3.4h, v18.4h
rshrn	v18.8b, v18.8h, #0x2
str	s18, [x6], #0x4
st1	{ v22.8b }, [x0], x1
st1	{ v23.8b }, [x12], x1
b.gt	Lmc__161c
ret
Lmc__168c:
mov	w11, w4
sub	x1, x1, w4, uxtw
add	x9, x3, w4, uxtw #1
add	x7, x2, w4, uxtw #1
Lmc__169c:
mov	w8, w4
Lmc__16a0:
ld1	{ v4.8h, v5.8h }, [x2], #32
ld1	{ v6.8h, v7.8h }, [x3], #32
ld1	{ v16.8h, v17.8h }, [x7], #32
ld1	{ v18.8h, v19.8h }, [x9], #32
subs	w8, w8, #0x10
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
sub	v18.8h, v18.8h, v16.8h
sub	v19.8h, v19.8h, v17.8h
abs	v20.8h, v6.8h
abs	v21.8h, v7.8h
abs	v22.8h, v18.8h
abs	v23.8h, v19.8h
uqsub	v20.8h, v0.8h, v20.8h
uqsub	v21.8h, v0.8h, v21.8h
uqsub	v22.8h, v0.8h, v22.8h
uqsub	v23.8h, v0.8h, v23.8h
ushr	v20.8h, v20.8h, #0x8
ushr	v21.8h, v21.8h, #0x8
ushr	v22.8h, v22.8h, #0x8
ushr	v23.8h, v23.8h, #0x8
shl	v24.8h, v20.8h, #0x9
shl	v25.8h, v21.8h, #0x9
shl	v26.8h, v22.8h, #0x9
shl	v27.8h, v23.8h, #0x9
sqdmulh	v24.8h, v24.8h, v6.8h
sqdmulh	v25.8h, v25.8h, v7.8h
sqdmulh	v26.8h, v26.8h, v18.8h
sqdmulh	v27.8h, v27.8h, v19.8h
add	v24.8h, v24.8h, v4.8h
add	v25.8h, v25.8h, v5.8h
add	v26.8h, v26.8h, v16.8h
add	v27.8h, v27.8h, v17.8h
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun	v25.8b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun	v27.8b, v27.8h, #0x4
add	v20.8h, v20.8h, v22.8h
add	v21.8h, v21.8h, v23.8h
addp	v20.8h, v20.8h, v21.8h
sub	v20.8h, v3.8h, v20.8h
rshrn	v20.8b, v20.8h, #0x2
st1	{ v20.8b }, [x6], #8
st1	{ v24.8b, v25.8b }, [x0], #16
st1	{ v26.8b, v27.8b }, [x12], #16
b.gt	Lmc__16a0
subs	w5, w5, #0x2
add	x2, x2, w4, uxtw #1
add	x3, x3, w4, uxtw #1
add	x7, x7, w4, uxtw #1
add	x9, x9, w4, uxtw #1
add	x0, x0, x1
add	x12, x12, x1
b.gt	Lmc__169c
ret
blend_8bpc_neon:
adrp	x6, blend_tbl
add	x6, x6, :lo12:blend_tbl
clz	w3, w3
sub	w3, w3, #0x1a
ldrsw	x3, [x6, x3, lsl #2]
add	x6, x6, x3
movi	v4.16b, #0x40
add	x8, x0, x1
lsl	x1, x1, #1
br	x6
Lmc__17a4:
ld1	{ v2.8b }, [x5], #8
ldr	d1, [x2], #0x8
ldr	s0, [x0]
subs	w4, w4, #0x2
ld1	{ v0.s }[1], [x8]
sub	v3.8b, v4.8b, v2.8b
umull	v5.8h, v1.8b, v2.8b
umlal	v5.8h, v0.8b, v3.8b
rshrn	v6.8b, v5.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.gt	Lmc__17a4
ret
Lmc__17d8:
ld1	{ v2.16b }, [x5], #16
ld1	{ v1.16b }, [x2], #16
ldr	d0, [x0]
ld1	{ v0.d }[1], [x8]
sub	v3.16b, v4.16b, v2.16b
subs	w4, w4, #0x2
umull	v5.8h, v1.8b, v2.8b
umlal	v5.8h, v0.8b, v3.8b
umull2	v6.8h, v1.16b, v2.16b
umlal2	v6.8h, v0.16b, v3.16b
rshrn	v7.8b, v5.8h, #0x6
rshrn	v16.8b, v6.8h, #0x6
st1	{ v7.8b }, [x0], x1
st1	{ v16.8b }, [x8], x1
b.gt	Lmc__17d8
ret
Lmc__1818:
ld1	{ v1.16b, v2.16b }, [x5], #32
ld1	{ v5.16b, v6.16b }, [x2], #32
ld1	{ v0.16b }, [x0]
subs	w4, w4, #0x2
sub	v7.16b, v4.16b, v1.16b
sub	v20.16b, v4.16b, v2.16b
ld1	{ v3.16b }, [x8]
umull	v16.8h, v5.8b, v1.8b
umlal	v16.8h, v0.8b, v7.8b
umull2	v17.8h, v5.16b, v1.16b
umlal2	v17.8h, v0.16b, v7.16b
umull	v21.8h, v6.8b, v2.8b
umlal	v21.8h, v3.8b, v20.8b
umull2	v22.8h, v6.16b, v2.16b
umlal2	v22.8h, v3.16b, v20.16b
rshrn	v18.8b, v16.8h, #0x6
rshrn2	v18.16b, v17.8h, #0x6
rshrn	v19.8b, v21.8h, #0x6
rshrn2	v19.16b, v22.8h, #0x6
st1	{ v18.16b }, [x0], x1
st1	{ v19.16b }, [x8], x1
b.gt	Lmc__1818
ret
Lmc__1874:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x5], #64
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
ld1	{ v20.16b, v21.16b }, [x0]
subs	w4, w4, #0x2
ld1	{ v22.16b, v23.16b }, [x8]
sub	v5.16b, v4.16b, v0.16b
sub	v6.16b, v4.16b, v1.16b
sub	v30.16b, v4.16b, v2.16b
sub	v31.16b, v4.16b, v3.16b
umull	v24.8h, v16.8b, v0.8b
umlal	v24.8h, v20.8b, v5.8b
umull2	v26.8h, v16.16b, v0.16b
umlal2	v26.8h, v20.16b, v5.16b
umull	v28.8h, v17.8b, v1.8b
umlal	v28.8h, v21.8b, v6.8b
umull2	v7.8h, v17.16b, v1.16b
umlal2	v7.8h, v21.16b, v6.16b
umull	v27.8h, v18.8b, v2.8b
umlal	v27.8h, v22.8b, v30.8b
umull2	v1.8h, v18.16b, v2.16b
umlal2	v1.8h, v22.16b, v30.16b
umull	v29.8h, v19.8b, v3.8b
umlal	v29.8h, v23.8b, v31.8b
umull2	v21.8h, v19.16b, v3.16b
umlal2	v21.8h, v23.16b, v31.16b
rshrn	v24.8b, v24.8h, #0x6
rshrn2	v24.16b, v26.8h, #0x6
rshrn	v25.8b, v28.8h, #0x6
rshrn2	v25.16b, v7.8h, #0x6
rshrn	v27.8b, v27.8h, #0x6
rshrn2	v27.16b, v1.8h, #0x6
rshrn	v28.8b, v29.8h, #0x6
rshrn2	v28.16b, v21.8h, #0x6
st1	{ v24.16b, v25.16b }, [x0], x1
st1	{ v27.16b, v28.16b }, [x8], x1
b.gt	Lmc__1874
ret
blend_h_8bpc_neon:
adrp	x6, blend_h_tbl
add	x6, x6, :lo12:blend_h_tbl
adrp	x5, obmc_masks
add	x5, x5, :lo12:obmc_masks
add	x5, x5, w4, uxtw
sub	w4, w4, w4, lsr #2
clz	w7, w3
movi	v4.16b, #0x40
add	x8, x0, x1
lsl	x1, x1, #1
sub	w7, w7, #0x18
ldrsw	x7, [x6, x7, lsl #2]
add	x6, x6, x7
br	x6
Lmc__1940:
ldr	h0, [x5], #0x2
ldr	s1, [x2], #0x4
subs	w4, w4, #0x2
ldr	h2, [x0]
zip1	v0.8b, v0.8b, v0.8b
sub	v3.8b, v4.8b, v0.8b
ld1	{ v2.h }[1], [x8]
umull	v5.8h, v1.8b, v0.8b
umlal	v5.8h, v2.8b, v3.8b
rshrn	v5.8b, v5.8h, #0x6
st1	{ v5.h }[0], [x0], x1
st1	{ v5.h }[1], [x8], x1
b.gt	Lmc__1940
ret
Lmc__1978:
ld2r	{ v0.8b, v1.8b }, [x5], #2
ld1	{ v2.8b }, [x2], #8
subs	w4, w4, #0x2
ext	v0.8b, v0.8b, v1.8b, #0x4
ldr	s3, [x0]
sub	v5.8b, v4.8b, v0.8b
ld1	{ v3.s }[1], [x8]
umull	v6.8h, v2.8b, v0.8b
umlal	v6.8h, v3.8b, v5.8b
rshrn	v6.8b, v6.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.gt	Lmc__1978
ret
Lmc__19b0:
ld2r	{ v0.16b, v1.16b }, [x5], #2
ld1	{ v2.16b }, [x2], #16
ldr	d3, [x0]
ext	v0.16b, v0.16b, v1.16b, #0x8
sub	v5.16b, v4.16b, v0.16b
ld1	{ v3.d }[1], [x8]
subs	w4, w4, #0x2
umull	v6.8h, v0.8b, v2.8b
umlal	v6.8h, v3.8b, v5.8b
umull2	v7.8h, v0.16b, v2.16b
umlal2	v7.8h, v3.16b, v5.16b
rshrn	v16.8b, v6.8h, #0x6
rshrn	v17.8b, v7.8h, #0x6
st1	{ v16.8b }, [x0], x1
st1	{ v17.8b }, [x8], x1
b.gt	Lmc__19b0
ret
Lmc__19f4:
ld2r	{ v0.16b, v1.16b }, [x5], #2
ld1	{ v2.16b, v3.16b }, [x2], #32
ld1	{ v5.16b }, [x0]
sub	v7.16b, v4.16b, v0.16b
sub	v16.16b, v4.16b, v1.16b
ld1	{ v6.16b }, [x8]
subs	w4, w4, #0x2
umull	v17.8h, v0.8b, v2.8b
umlal	v17.8h, v5.8b, v7.8b
umull2	v18.8h, v0.16b, v2.16b
umlal2	v18.8h, v5.16b, v7.16b
umull	v19.8h, v1.8b, v3.8b
umlal	v19.8h, v6.8b, v16.8b
umull2	v20.8h, v1.16b, v3.16b
umlal2	v20.8h, v6.16b, v16.16b
rshrn	v21.8b, v17.8h, #0x6
rshrn2	v21.16b, v18.8h, #0x6
rshrn	v22.8b, v19.8h, #0x6
rshrn2	v22.16b, v20.8h, #0x6
st1	{ v21.16b }, [x0], x1
st1	{ v22.16b }, [x8], x1
b.gt	Lmc__19f4
ret
Lmc__1a50:
sub	x1, x1, w3, uxtw
add	x7, x2, w3, uxtw
Lmc__1a58:
ld2r	{ v0.16b, v1.16b }, [x5], #2
mov	w6, w3
sub	v20.16b, v4.16b, v0.16b
sub	v21.16b, v4.16b, v1.16b
Lmc__1a68:
ld1	{ v16.16b, v17.16b }, [x2], #32
ld1	{ v2.16b, v3.16b }, [x0]
subs	w6, w6, #0x20
umull	v23.8h, v0.8b, v16.8b
umlal	v23.8h, v2.8b, v20.8b
ld1	{ v18.16b, v19.16b }, [x7], #32
umull2	v27.8h, v0.16b, v16.16b
umlal2	v27.8h, v2.16b, v20.16b
ld1	{ v6.16b, v7.16b }, [x8]
umull	v24.8h, v0.8b, v17.8b
umlal	v24.8h, v3.8b, v20.8b
umull2	v28.8h, v0.16b, v17.16b
umlal2	v28.8h, v3.16b, v20.16b
umull	v25.8h, v1.8b, v18.8b
umlal	v25.8h, v6.8b, v21.8b
umull2	v5.8h, v1.16b, v18.16b
umlal2	v5.8h, v6.16b, v21.16b
rshrn	v29.8b, v23.8h, #0x6
rshrn2	v29.16b, v27.8h, #0x6
umull	v26.8h, v1.8b, v19.8b
umlal	v26.8h, v7.8b, v21.8b
umull2	v31.8h, v1.16b, v19.16b
umlal2	v31.8h, v7.16b, v21.16b
rshrn	v30.8b, v24.8h, #0x6
rshrn2	v30.16b, v28.8h, #0x6
rshrn	v23.8b, v25.8h, #0x6
rshrn2	v23.16b, v5.8h, #0x6
rshrn	v24.8b, v26.8h, #0x6
st1	{ v29.16b, v30.16b }, [x0], #32
rshrn2	v24.16b, v31.8h, #0x6
st1	{ v23.16b, v24.16b }, [x8], #32
b.gt	Lmc__1a68
subs	w4, w4, #0x2
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, w3, uxtw
add	x7, x7, w3, uxtw
b.gt	Lmc__1a58
ret
blend_v_8bpc_neon:
adrp	x6, blend_v_tbl
add	x6, x6, :lo12:blend_v_tbl
adrp	x5, obmc_masks
add	x5, x5, :lo12:obmc_masks
add	x5, x5, w3, uxtw
clz	w3, w3
movi	v4.16b, #0x40
add	x8, x0, x1
lsl	x1, x1, #1
sub	w3, w3, #0x1a
ldrsw	x3, [x6, x3, lsl #2]
add	x6, x6, x3
br	x6
Lmc__1b38:
ld1r	{ v0.8b }, [x5]
sub	v1.8b, v4.8b, v0.8b
Lmc__1b40:
ldr	h2, [x2], #0x2
ldr	b3, [x0]
subs	w4, w4, #0x2
ld1	{ v2.b }[1], [x2]
ld1	{ v3.b }[1], [x8]
umull	v5.8h, v2.8b, v0.8b
umlal	v5.8h, v3.8b, v1.8b
rshrn	v5.8b, v5.8h, #0x6
add	x2, x2, #0x2
st1	{ v5.b }[0], [x0], x1
st1	{ v5.b }[1], [x8], x1
b.gt	Lmc__1b40
ret
Lmc__1b74:
ld1r	{ v0.2s }, [x5]
sub	x1, x1, #0x2
sub	v1.8b, v4.8b, v0.8b
Lmc__1b80:
ld1	{ v2.8b }, [x2], #8
ldr	s3, [x0]
ld1	{ v3.s }[1], [x8]
subs	w4, w4, #0x2
umull	v5.8h, v2.8b, v0.8b
umlal	v5.8h, v3.8b, v1.8b
rshrn	v5.8b, v5.8h, #0x6
str	h5, [x0], #0x2
st1	{ v5.h }[2], [x8], #2
st1	{ v5.b }[2], [x0], x1
st1	{ v5.b }[6], [x8], x1
b.gt	Lmc__1b80
ret
Lmc__1bb4:
ld1r	{ v0.2d }, [x5]
sub	x1, x1, #0x4
sub	v1.16b, v4.16b, v0.16b
zip2	v16.2d, v1.2d, v1.2d
Lmc__1bc4:
ld1	{ v2.16b }, [x2], #16
ldr	d3, [x0]
ldr	d4, [x8]
subs	w4, w4, #0x2
umull	v5.8h, v0.8b, v2.8b
umlal	v5.8h, v3.8b, v1.8b
umull2	v6.8h, v0.16b, v2.16b
umlal	v6.8h, v4.8b, v16.8b
rshrn	v7.8b, v5.8h, #0x6
rshrn	v17.8b, v6.8h, #0x6
str	s7, [x0], #0x4
str	s17, [x8], #0x4
st1	{ v7.h }[2], [x0], x1
st1	{ v17.h }[2], [x8], x1
b.gt	Lmc__1bc4
ret
Lmc__1c04:
ld1	{ v0.16b }, [x5]
sub	x1, x1, #0x8
sub	v2.16b, v4.16b, v0.16b
Lmc__1c10:
ld1	{ v5.16b, v6.16b }, [x2], #32
ld1	{ v7.16b }, [x0]
subs	w4, w4, #0x2
ld1	{ v16.16b }, [x8]
umull	v17.8h, v5.8b, v0.8b
umlal	v17.8h, v7.8b, v2.8b
umull2	v18.8h, v5.16b, v0.16b
umlal2	v18.8h, v7.16b, v2.16b
umull	v20.8h, v6.8b, v0.8b
umlal	v20.8h, v16.8b, v2.8b
umull2	v21.8h, v6.16b, v0.16b
umlal2	v21.8h, v16.16b, v2.16b
rshrn	v19.8b, v17.8h, #0x6
rshrn2	v19.16b, v18.8h, #0x6
rshrn	v22.8b, v20.8h, #0x6
rshrn2	v22.16b, v21.8h, #0x6
st1	{ v19.8b }, [x0], #8
st1	{ v22.8b }, [x8], #8
st1	{ v19.s }[2], [x0], x1
st1	{ v22.s }[2], [x8], x1
b.gt	Lmc__1c10
ret
Lmc__1c68:
ld1	{ v0.16b, v1.16b }, [x5]
sub	x1, x1, #0x10
sub	v2.16b, v4.16b, v0.16b
sub	v3.8b, v4.8b, v1.8b
Lmc__1c78:
ld1	{ v16.16b, v17.16b, v18.16b, v19.16b }, [x2], #64
ld1	{ v5.16b, v6.16b }, [x0]
subs	w4, w4, #0x2
ld1	{ v20.16b, v21.16b }, [x8]
umull	v22.8h, v16.8b, v0.8b
umlal	v22.8h, v5.8b, v2.8b
umull2	v23.8h, v16.16b, v0.16b
umlal2	v23.8h, v5.16b, v2.16b
umull	v28.8h, v17.8b, v1.8b
umlal	v28.8h, v6.8b, v3.8b
umull	v30.8h, v18.8b, v0.8b
umlal	v30.8h, v20.8b, v2.8b
umull2	v31.8h, v18.16b, v0.16b
umlal2	v31.8h, v20.16b, v2.16b
umull	v25.8h, v19.8b, v1.8b
umlal	v25.8h, v21.8b, v3.8b
rshrn	v24.8b, v22.8h, #0x6
rshrn2	v24.16b, v23.8h, #0x6
rshrn	v28.8b, v28.8h, #0x6
rshrn	v30.8b, v30.8h, #0x6
rshrn2	v30.16b, v31.8h, #0x6
rshrn	v27.8b, v25.8h, #0x6
st1	{ v24.16b }, [x0], #16
st1	{ v30.16b }, [x8], #16
st1	{ v28.8b }, [x0], x1
st1	{ v27.8b }, [x8], x1
b.gt	Lmc__1c78
ret
put_neon:
adrp	x9, put_tbl
add	x9, x9, :lo12:put_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__1cfc:
ldrh	w9, [x2]
ldrh	w10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
strh	w9, [x0]
strh	w10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	Lmc__1cfc
ret
Lmc__1d20:
ldr	w9, [x2]
ldr	w10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
str	w9, [x0]
str	w10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	Lmc__1d20
ret
Lmc__1d44:
ldr	x9, [x2]
ldr	x10, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
str	x9, [x0]
str	x10, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	Lmc__1d44
ret
Lmc__1d68:
ldr	q0, [x2]
ldr	q1, [x2, x3]
add	x2, x2, x3, lsl #1
subs	w5, w5, #0x2
str	q0, [x0]
str	q1, [x0, x1]
add	x0, x0, x1, lsl #1
b.gt	Lmc__1d68
ret
Lmc__1d8c:
ldp	q0, q1, [x2]
add	x2, x2, x3
stp	q0, q1, [x0]
add	x0, x0, x1
ldp	q2, q3, [x2]
add	x2, x2, x3
stp	q2, q3, [x0]
subs	w5, w5, #0x2
add	x0, x0, x1
b.gt	Lmc__1d8c
ret
Lmc__1db8:
ldp	q0, q1, [x2]
stp	q0, q1, [x0]
ldp	q2, q3, [x2, #0x20]
add	x2, x2, x3
stp	q2, q3, [x0, #0x20]
subs	w5, w5, #0x1
add	x0, x0, x1
b.gt	Lmc__1db8
ret
Lmc__1ddc:
ldp	q0, q1, [x2]
stp	q0, q1, [x0]
ldp	q2, q3, [x2, #0x20]
stp	q2, q3, [x0, #0x20]
ldp	q4, q5, [x2, #0x40]
stp	q4, q5, [x0, #0x40]
ldp	q6, q7, [x2, #0x60]
add	x2, x2, x3
stp	q6, q7, [x0, #0x60]
subs	w5, w5, #0x1
add	x0, x0, x1
b.gt	Lmc__1ddc
ret
prep_neon:
adrp	x9, prep_tbl
add	x9, x9, :lo12:prep_tbl
ldrsw	x8, [x9, x8, lsl #2]
movi	v24.16b, #0x10
add	x9, x9, x8
br	x9
Lmc__1e28:
ldr	s0, [x1]
ldr	s2, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	s1, [x1]
ldr	s3, [x1, x2]
add	x1, x1, x2, lsl #1
mov	v0.s[1], v2.s[0]
mov	v1.s[1], v3.s[0]
ushll	v0.8h, v0.8b, #0x4
ushll	v1.8h, v1.8b, #0x4
subs	w4, w4, #0x4
stp	q0, q1, [x0], #0x20
b.gt	Lmc__1e28
ret
Lmc__1e60:
ldr	d0, [x1]
ldr	d1, [x1, x2]
add	x1, x1, x2, lsl #1
ldr	d2, [x1]
ldr	d3, [x1, x2]
add	x1, x1, x2, lsl #1
ushll	v0.8h, v0.8b, #0x4
ushll	v1.8h, v1.8b, #0x4
umull	v2.8h, v2.8b, v24.8b
umull	v3.8h, v3.8b, v24.8b
subs	w4, w4, #0x4
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
add	x0, x0, #0x40
b.gt	Lmc__1e60
ret
Lmc__1ea0:
ldr	q1, [x1]
ldr	q3, [x1, x2]
add	x1, x1, x2, lsl #1
ushll	v0.8h, v1.8b, #0x4
ushll2	v1.8h, v1.16b, #0x4
ldr	q5, [x1]
ldr	q7, [x1, x2]
add	x1, x1, x2, lsl #1
umull	v2.8h, v3.8b, v24.8b
umull2	v3.8h, v3.16b, v24.16b
ushll	v4.8h, v5.8b, #0x4
ushll2	v5.8h, v5.16b, #0x4
umull	v6.8h, v7.8b, v24.8b
umull2	v7.8h, v7.16b, v24.16b
subs	w4, w4, #0x4
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, #0x80
b.gt	Lmc__1ea0
ret
Lmc__1ef8:
ldp	q4, q5, [x1]
add	x1, x1, x2
ldp	q6, q7, [x1]
add	x1, x1, x2
ushll	v0.8h, v4.8b, #0x4
ushll2	v1.8h, v4.16b, #0x4
umull	v2.8h, v5.8b, v24.8b
umull2	v3.8h, v5.16b, v24.16b
ushll	v4.8h, v6.8b, #0x4
ushll2	v5.8h, v6.16b, #0x4
umull	v6.8h, v7.8b, v24.8b
umull2	v7.8h, v7.16b, v24.16b
subs	w4, w4, #0x2
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, #0x80
b.gt	Lmc__1ef8
ret
Lmc__1f48:
ldp	q4, q5, [x1]
ldp	q6, q7, [x1, #0x20]
add	x1, x1, x2
ushll	v0.8h, v4.8b, #0x4
ushll2	v1.8h, v4.16b, #0x4
umull	v2.8h, v5.8b, v24.8b
umull2	v3.8h, v5.16b, v24.16b
ushll	v4.8h, v6.8b, #0x4
ushll2	v5.8h, v6.16b, #0x4
umull	v6.8h, v7.8b, v24.8b
umull2	v7.8h, v7.16b, v24.16b
subs	w4, w4, #0x1
stp	q0, q1, [x0]
stp	q2, q3, [x0, #0x20]
stp	q4, q5, [x0, #0x40]
stp	q6, q7, [x0, #0x60]
add	x0, x0, #0x80
b.gt	Lmc__1f48
ret
Lmc__1f94:
ldp	q28, q29, [x1]
ldp	q30, q31, [x1, #0x20]
ushll	v16.8h, v28.8b, #0x4
ushll2	v17.8h, v28.16b, #0x4
umull	v18.8h, v29.8b, v24.8b
umull2	v19.8h, v29.16b, v24.16b
ushll	v20.8h, v30.8b, #0x4
ushll2	v21.8h, v30.16b, #0x4
umull	v22.8h, v31.8b, v24.8b
umull2	v23.8h, v31.16b, v24.16b
ldp	q28, q29, [x1, #0x40]
ldp	q30, q31, [x1, #0x60]
add	x1, x1, x2
stp	q16, q17, [x0]
stp	q18, q19, [x0, #0x20]
stp	q20, q21, [x0, #0x40]
stp	q22, q23, [x0, #0x60]
ushll	v16.8h, v28.8b, #0x4
ushll2	v17.8h, v28.16b, #0x4
umull	v18.8h, v29.8b, v24.8b
umull2	v19.8h, v29.16b, v24.16b
ushll	v20.8h, v30.8b, #0x4
ushll2	v21.8h, v30.16b, #0x4
umull	v22.8h, v31.8b, v24.8b
umull2	v23.8h, v31.16b, v24.16b
subs	w4, w4, #0x1
stp	q16, q17, [x0, #0x80]
stp	q18, q19, [x0, #0xa0]
stp	q20, q21, [x0, #0xc0]
stp	q22, q23, [x0, #0xe0]
add	x0, x0, #0x100
b.gt	Lmc__1f94
ret
put_8tap_regular_sharp_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0xf2d
b	put_8tap_neon
put_8tap_smooth_sharp_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0xf2d
b	put_8tap_neon
put_8tap_sharp_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0xf2d
b	put_8tap_neon
put_8tap_sharp_regular_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x2d
b	put_8tap_neon
put_8tap_sharp_smooth_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x7bc
b	put_8tap_neon
put_8tap_neon:
mov	w10, #0x4081
mul	w6, w6, w10
mul	w7, w7, w10
add	w6, w6, w8
add	w7, w7, w9
clz	w8, w4
tst	w6, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	Lmc__208c
tst	w7, #0x1fc000
b.ne	Lmc__243c
b	put_neon
Lmc__208c:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	Lmc__20a0
mov	w6, w9
Lmc__20a0:
tst	w7, #0x1fc000
add	x6, x10, w6, uxtw #3
b.ne	Lmc__2e5c
adrp	x9, put_8tap_h_tbl
add	x9, x9, :lo12:put_8tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__20c0:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__20dc:
ld1	{ v4.8b }, [x2], x3
ld1	{ v6.8b }, [x9], x3
ushll	v4.8h, v4.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
subs	w5, w5, #0x2
trn1	v3.2s, v4.2s, v6.2s
trn2	v6.2s, v4.2s, v6.2s
trn1	v4.2s, v5.2s, v7.2s
trn2	v7.2s, v5.2s, v7.2s
mul	v3.4h, v3.4h, v0.h[0]
mla	v3.4h, v4.4h, v0.h[1]
mla	v3.4h, v6.4h, v0.h[2]
mla	v3.4h, v7.4h, v0.h[3]
srshr	v3.4h, v3.4h, #0x2
sqrshrun	v3.8b, v3.8h, #0x4
st1	{ v3.h }[0], [x0], x1
st1	{ v3.h }[1], [x8], x1
b.gt	Lmc__20dc
ret
Lmc__2130:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__214c:
ld1	{ v16.8b }, [x2], x3
ld1	{ v20.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w5, w5, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
sqrshrun	v16.8b, v16.8h, #0x4
sqrshrun	v20.8b, v20.8h, #0x4
str	s16, [x0]
str	s20, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.gt	Lmc__214c
ret
Lmc__21c0:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__21dc:
ld1	{ v16.8b, v17.8b }, [x2], x3
ld1	{ v20.8b, v21.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[0]
mul	v22.8h, v20.8h, v0.h[0]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[1]
mla	v22.8h, v23.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xc
ext	v23.16b, v20.16b, v21.16b, #0xc
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
ext	v19.16b, v16.16b, v17.16b, #0xe
ext	v23.16b, v20.16b, v21.16b, #0xe
mla	v18.8h, v19.8h, v0.h[7]
mla	v22.8h, v23.8h, v0.h[7]
subs	w5, w5, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
sqrshrun	v18.8b, v18.8h, #0x4
sqrshrun	v22.8b, v22.8h, #0x4
st1	{ v18.8b }, [x0], x1
st1	{ v22.8b }, [x8], x1
b.gt	Lmc__21dc
ret
Lmc__2290:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
sub	x3, x3, w4, uxtw
sub	x3, x3, #0x8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
Lmc__22b8:
ld1	{ v16.8b, v17.8b, v18.8b }, [x2], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w6, w4
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__22dc:
mul	v24.8h, v16.8h, v0.h[0]
mul	v25.8h, v17.8h, v0.h[0]
mul	v26.8h, v20.8h, v0.h[0]
mul	v27.8h, v21.8h, v0.h[0]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[1]
mla	v25.8h, v29.8h, v0.h[1]
mla	v26.8h, v30.8h, v0.h[1]
mla	v27.8h, v31.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xc
ext	v29.16b, v17.16b, v18.16b, #0xc
ext	v30.16b, v20.16b, v21.16b, #0xc
ext	v31.16b, v21.16b, v22.16b, #0xc
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
ext	v28.16b, v16.16b, v17.16b, #0xe
ext	v29.16b, v17.16b, v18.16b, #0xe
ext	v30.16b, v20.16b, v21.16b, #0xe
ext	v31.16b, v21.16b, v22.16b, #0xe
mla	v24.8h, v28.8h, v0.h[7]
mla	v25.8h, v29.8h, v0.h[7]
mla	v26.8h, v30.8h, v0.h[7]
mla	v27.8h, v31.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w6, w6, #0x10
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun2	v24.16b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun2	v26.16b, v27.8h, #0x4
st1	{ v24.16b }, [x0], #16
st1	{ v26.16b }, [x8], #16
b.le	Lmc__2420
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x2], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	Lmc__22dc
Lmc__2420:
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #0x2
b.gt	Lmc__22b8
ret
Lmc__243c:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	Lmc__2450
mov	w7, w9
Lmc__2450:
add	x7, x10, w7, uxtw #3
adrp	x9, put_8tap_v_tbl
add	x9, x9, :lo12:put_8tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__2468:
b.gt	Lmc__253c
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
b.gt	Lmc__24e4
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.4h, v1.4h, v0.h[0]
mla	v6.4h, v2.4h, v0.h[1]
mla	v6.4h, v3.4h, v0.h[2]
mla	v6.4h, v4.4h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
ret
Lmc__24e4:
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
st1	{ v6.h }[2], [x0], x1
st1	{ v6.h }[3], [x8], x1
ret
Lmc__253c:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
Lmc__25ac:
subs	w5, w5, #0x4
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
ld1	{ v18.h }[0], [x9], x3
ld1	{ v19.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
trn1	v18.4h, v18.4h, v19.4h
trn1	v5.2s, v5.2s, v7.2s
trn1	v6.2s, v6.2s, v16.2s
trn1	v7.2s, v7.2s, v17.2s
trn1	v16.2s, v16.2s, v18.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.8h, v1.8h, v0.h[0]
mla	v30.8h, v2.8h, v0.h[1]
mla	v30.8h, v3.8h, v0.h[2]
mla	v30.8h, v4.8h, v0.h[3]
mla	v30.8h, v5.8h, v0.h[4]
mla	v30.8h, v6.8h, v0.h[5]
mla	v30.8h, v7.8h, v0.h[6]
mla	v30.8h, v16.8h, v0.h[7]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
st1	{ v30.h }[2], [x0], x1
st1	{ v30.h }[3], [x8], x1
b.le	Lmc__269c
cmp	w5, #0x2
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
mov	v4.16b, v16.16b
mov	v5.16b, v17.16b
mov	v6.16b, v18.16b
mov	v7.16b, v19.16b
b.eq	Lmc__2650
b	Lmc__25ac
Lmc__2650:
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.4h, v1.4h, v0.h[0]
mla	v30.4h, v2.4h, v0.h[1]
mla	v30.4h, v3.4h, v0.h[2]
mla	v30.4h, v4.4h, v0.h[3]
mla	v30.4h, v5.4h, v0.h[4]
mla	v30.4h, v6.4h, v0.h[5]
mla	v30.4h, v7.4h, v0.h[6]
mla	v30.4h, v16.4h, v0.h[7]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
Lmc__269c:
ret
Lmc__26a0:
b.gt	Lmc__2750
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x9], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x9], x3
ld1	{ v5.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.le	Lmc__274c
ld1	{ v6.s }[0], [x9], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v7.s }[0], [x0], x1
st1	{ v7.s }[1], [x8], x1
Lmc__274c:
ret
Lmc__2750:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x2], x3
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
Lmc__27b8:
subs	w5, w5, #0x4
ld1	{ v23.s }[0], [x9], x3
ld1	{ v24.s }[0], [x2], x3
ld1	{ v25.s }[0], [x9], x3
ld1	{ v26.s }[0], [x2], x3
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v18.8h, v0.h[0]
mla	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
mla	v2.8h, v25.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	Lmc__2970
ld1	{ v27.s }[0], [x9], x3
ld1	{ v16.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
b.le	Lmc__2970
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v22.8h, v0.h[0]
mla	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
mla	v2.8h, v17.8h, v0.h[7]
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	Lmc__2970
subs	w5, w5, #0x4
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v26.8h, v0.h[0]
mla	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
mla	v2.8h, v21.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.gt	Lmc__27b8
Lmc__2970:
ret
Lmc__2974:
b.gt	Lmc__2a38
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x2], x3
ld1	{ v2.8b }, [x9], x3
ld1	{ v3.8b }, [x2], x3
ld1	{ v4.8b }, [x9], x3
ld1	{ v5.8b }, [x2], x3
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v6.8b }, [x0], x1
st1	{ v7.8b }, [x8], x1
b.le	Lmc__2a34
ld1	{ v6.8b }, [x9], x3
ld1	{ v7.8b }, [x2], x3
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
Lmc__2a34:
ret
Lmc__2a38:
ld1	{ v0.8b }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w7, w5
Lmc__2a4c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8b }, [x2], x3
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__2a94:
subs	w5, w5, #0x2
ld1	{ v23.8b }, [x9], x3
ld1	{ v24.8b }, [x2], x3
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
mla	v2.8h, v24.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	Lmc__2cfc
subs	w5, w5, #0x2
ld1	{ v25.8b }, [x9], x3
ld1	{ v26.8b }, [x2], x3
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v18.8h, v0.h[0]
mla	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mla	v3.8h, v25.8h, v0.h[7]
mul	v4.8h, v19.8h, v0.h[0]
mla	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
mla	v4.8h, v26.8h, v0.h[7]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__2cfc
subs	w5, w5, #0x2
ld1	{ v27.8b }, [x9], x3
ld1	{ v16.8b }, [x2], x3
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
mul	v2.8h, v21.8h, v0.h[0]
mla	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
mla	v2.8h, v16.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	Lmc__2cfc
subs	w5, w5, #0x2
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v22.8h, v0.h[0]
mla	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mla	v3.8h, v17.8h, v0.h[7]
mul	v4.8h, v23.8h, v0.h[0]
mla	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
mla	v4.8h, v18.8h, v0.h[7]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__2cfc
subs	w5, w5, #0x4
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mla	v2.8h, v20.8h, v0.h[7]
mul	v3.8h, v26.8h, v0.h[0]
mla	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mla	v3.8h, v21.8h, v0.h[7]
mul	v4.8h, v27.8h, v0.h[0]
mla	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
mla	v4.8h, v22.8h, v0.h[7]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.gt	Lmc__2a94
Lmc__2cfc:
subs	w4, w4, #0x8
b.le	Lmc__2d28
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	Lmc__2a4c
Lmc__2d28:
ret
Lmc__2d2c:
b.gt	Lmc__2a38
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w5, #0x2
ld1	{ v1.16b }, [x2], x3
ld1	{ v2.16b }, [x9], x3
ld1	{ v3.16b }, [x2], x3
ld1	{ v4.16b }, [x9], x3
ld1	{ v5.16b }, [x2], x3
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v16.8b, v16.8h, #0x6
sqrshrun2	v16.16b, v17.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v16.16b }, [x8], x1
b.le	Lmc__2e58
ld1	{ v6.16b }, [x9], x3
ld1	{ v7.16b }, [x2], x3
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun2	v3.16b, v4.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v3.16b }, [x8], x1
Lmc__2e58:
ret
Lmc__2e5c:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	Lmc__2e70
mov	w7, w9
Lmc__2e70:
add	x7, x10, w7, uxtw #3
adrp	x9, put_8tap_hv_tbl
add	x9, x9, :lo12:put_8tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__2e88:
ldur	s0, [x6, #0x2]
b.gt	Lmc__2f1c
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	Lmc__2fe8
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
Lmc__2ee0:
bl	Lmc__2fe8
ext	v18.8b, v17.8b, v28.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	Lmc__2fe4
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
b	Lmc__2ee0
Lmc__2f1c:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	Lmc__2fe8
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
bl	Lmc__2fe8
ext	v18.8b, v17.8b, v28.8b, #0x4
mov	v19.8b, v28.8b
bl	Lmc__2fe8
ext	v20.8b, v19.8b, v28.8b, #0x4
mov	v21.8b, v28.8b
Lmc__2f88:
bl	Lmc__2fe8
ext	v22.8b, v21.8b, v28.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal	v2.4s, v28.4h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	Lmc__2fe4
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
b	Lmc__2f88
Lmc__2fe4:
ret	x15
Lmc__2fe8:
ld1	{ v28.8b }, [x9], x3
ld1	{ v30.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
ext	v31.16b, v30.16b, v30.16b, #0x2
trn1	v27.2s, v28.2s, v30.2s
trn2	v30.2s, v28.2s, v30.2s
trn1	v28.2s, v29.2s, v31.2s
trn2	v31.2s, v29.2s, v31.2s
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v30.4h, v0.h[2]
mla	v27.4h, v31.4h, v0.h[3]
srshr	v28.4h, v27.4h, #0x2
ret
Lmc__3028:
ldur	s0, [x6, #0x2]
b.gt	Lmc__30e4
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	Lmc__31e8
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
Lmc__3088:
bl	Lmc__31e8
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	Lmc__31e4
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	Lmc__3088
Lmc__30e4:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	Lmc__31e8
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
bl	Lmc__31e8
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	Lmc__31e8
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
Lmc__3158:
bl	Lmc__31e8
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal	v2.4s, v28.4h, v1.h[7]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smlal	v3.4s, v21.4h, v1.h[4]
smlal	v3.4s, v22.4h, v1.h[5]
smlal	v3.4s, v28.4h, v1.h[6]
smlal	v3.4s, v29.4h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	Lmc__31e4
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	Lmc__3158
Lmc__31e4:
ret	x15
Lmc__31e8:
ld1	{ v26.8b }, [x9], x3
ld1	{ v27.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
Lmc__323c:
b.gt	Lmc__3328
ld1	{ v0.8b }, [x6]
ldur	s1, [x7, #0x2]
sub	x2, x2, #0x3
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
Lmc__3260:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	Lmc__3480
bl	Lmc__34d0
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
Lmc__3280:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	Lmc__34d0
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__32fc
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	Lmc__3280
Lmc__32fc:
subs	w4, w4, #0x8
b.le	Lmc__347c
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	Lmc__3260
Lmc__3328:
ld1	{ v0.8b }, [x6]
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x3
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
Lmc__334c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	Lmc__3480
bl	Lmc__34d0
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
bl	Lmc__34d0
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	Lmc__34d0
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
Lmc__3384:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	Lmc__34d0
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v19.4h, v1.h[2]
smlal2	v5.4s, v19.8h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal2	v3.4s, v19.8h, v1.h[3]
smlal	v4.4s, v20.4h, v1.h[3]
smlal2	v5.4s, v20.8h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal2	v3.4s, v20.8h, v1.h[4]
smlal	v4.4s, v21.4h, v1.h[4]
smlal2	v5.4s, v21.8h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal2	v3.4s, v21.8h, v1.h[5]
smlal	v4.4s, v22.4h, v1.h[5]
smlal2	v5.4s, v22.8h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal2	v3.4s, v22.8h, v1.h[6]
smlal	v4.4s, v24.4h, v1.h[6]
smlal2	v5.4s, v24.8h, v1.h[6]
smlal	v2.4s, v24.4h, v1.h[7]
smlal2	v3.4s, v24.8h, v1.h[7]
smlal	v4.4s, v25.4h, v1.h[7]
smlal2	v5.4s, v25.8h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__3450
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	Lmc__3384
Lmc__3450:
subs	w4, w4, #0x8
b.le	Lmc__347c
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	Lmc__334c
Lmc__347c:
ret	x15
Lmc__3480:
ld1	{ v28.8b, v29.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[0]
ext	v24.16b, v28.16b, v29.16b, #0x2
ext	v25.16b, v28.16b, v29.16b, #0x4
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v28.16b, v29.16b, #0x8
mla	v16.8h, v24.8h, v0.h[1]
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0xa
ext	v25.16b, v28.16b, v29.16b, #0xc
ext	v26.16b, v28.16b, v29.16b, #0xe
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
mla	v16.8h, v26.8h, v0.h[7]
srshr	v16.8h, v16.8h, #0x2
ret
Lmc__34d0:
ld1	{ v28.8b, v29.8b }, [x9], x3
ld1	{ v30.8b, v31.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[0]
mul	v25.8h, v30.8h, v0.h[0]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[1]
mla	v25.8h, v27.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xc
ext	v27.16b, v30.16b, v31.16b, #0xc
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
ext	v26.16b, v28.16b, v29.16b, #0xe
ext	v27.16b, v30.16b, v31.16b, #0xe
mla	v24.8h, v26.8h, v0.h[7]
mla	v25.8h, v27.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
put_8tap_regular_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x2d
b	put_6tap_neon
put_8tap_regular_smooth_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x7bc
b	put_6tap_neon
put_8tap_smooth_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x7bc
b	put_6tap_neon
put_8tap_smooth_regular_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x2d
b	put_6tap_neon
put_6tap_neon:
mov	w10, #0x4081
mul	w6, w6, w10
mul	w7, w7, w10
add	w6, w6, w8
add	w7, w7, w9
clz	w8, w4
tst	w6, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	Lmc__35d4
tst	w7, #0x1fc000
b.ne	Lmc__3924
b	put_neon
Lmc__35d4:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	Lmc__35e8
mov	w6, w9
Lmc__35e8:
tst	w7, #0x1fc000
add	x6, x10, w6, uxtw #3
b.ne	Lmc__42a4
adrp	x9, put_6tap_h_tbl
add	x9, x9, :lo12:put_6tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__3608:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__3624:
ld1	{ v4.8b }, [x2], x3
ld1	{ v6.8b }, [x9], x3
ushll	v4.8h, v4.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ext	v5.16b, v4.16b, v4.16b, #0x2
ext	v7.16b, v6.16b, v6.16b, #0x2
subs	w5, w5, #0x2
trn1	v3.2s, v4.2s, v6.2s
trn2	v6.2s, v4.2s, v6.2s
trn1	v4.2s, v5.2s, v7.2s
trn2	v7.2s, v5.2s, v7.2s
mul	v3.4h, v3.4h, v0.h[0]
mla	v3.4h, v4.4h, v0.h[1]
mla	v3.4h, v6.4h, v0.h[2]
mla	v3.4h, v7.4h, v0.h[3]
srshr	v3.4h, v3.4h, #0x2
sqrshrun	v3.8b, v3.8h, #0x4
st1	{ v3.h }[0], [x0], x1
st1	{ v3.h }[1], [x8], x1
b.gt	Lmc__3624
ret
Lmc__3678:
ldur	s0, [x6, #0x2]
sub	x2, x2, #0x1
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__3694:
ld1	{ v16.8b }, [x2], x3
ld1	{ v20.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w5, w5, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
sqrshrun	v16.8b, v16.8h, #0x4
sqrshrun	v20.8b, v20.8h, #0x4
str	s16, [x0]
str	s20, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.gt	Lmc__3694
ret
Lmc__3708:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x2
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__3724:
ld1	{ v16.8b, v17.8b }, [x2], x3
ld1	{ v20.8b, v21.8b }, [x9], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[1]
mul	v22.8h, v20.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
subs	w5, w5, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
sqrshrun	v18.8b, v18.8h, #0x4
sqrshrun	v22.8b, v22.8h, #0x4
st1	{ v18.8b }, [x0], x1
st1	{ v22.8b }, [x8], x1
b.gt	Lmc__3724
ret
Lmc__37b8:
ld1	{ v0.8b }, [x6]
sub	x2, x2, #0x2
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
sub	x3, x3, w4, uxtw
sub	x3, x3, #0x8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
Lmc__37e0:
ld1	{ v16.8b, v17.8b, v18.8b }, [x2], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w6, w4
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__3804:
mul	v24.8h, v16.8h, v0.h[1]
mul	v25.8h, v17.8h, v0.h[1]
mul	v26.8h, v20.8h, v0.h[1]
mul	v27.8h, v21.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w6, w6, #0x10
sqrshrun	v24.8b, v24.8h, #0x4
sqrshrun2	v24.16b, v25.8h, #0x4
sqrshrun	v26.8b, v26.8h, #0x4
sqrshrun2	v26.16b, v27.8h, #0x4
st1	{ v24.16b }, [x0], #16
st1	{ v26.16b }, [x8], #16
b.le	Lmc__3908
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x2], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	Lmc__3804
Lmc__3908:
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #0x2
b.gt	Lmc__37e0
ret
Lmc__3924:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	Lmc__3938
mov	w7, w9
Lmc__3938:
add	x7, x10, w7, uxtw #3
adrp	x9, put_6tap_v_tbl
add	x9, x9, :lo12:put_6tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__3950:
b.gt	Lmc__3a24
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
b.gt	Lmc__39cc
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.4h, v1.4h, v0.h[0]
mla	v6.4h, v2.4h, v0.h[1]
mla	v6.4h, v3.4h, v0.h[2]
mla	v6.4h, v4.4h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
ret
Lmc__39cc:
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.h }[0], [x0], x1
st1	{ v6.h }[1], [x8], x1
st1	{ v6.h }[2], [x0], x1
st1	{ v6.h }[3], [x8], x1
ret
Lmc__3a24:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.h }[0], [x2], x3
ld1	{ v2.h }[0], [x9], x3
ld1	{ v3.h }[0], [x2], x3
ld1	{ v4.h }[0], [x9], x3
ld1	{ v5.h }[0], [x2], x3
ld1	{ v6.h }[0], [x9], x3
ld1	{ v7.h }[0], [x2], x3
trn1	v1.4h, v1.4h, v2.4h
trn1	v2.4h, v2.4h, v3.4h
trn1	v3.4h, v3.4h, v4.4h
trn1	v4.4h, v4.4h, v5.4h
trn1	v5.4h, v5.4h, v6.4h
trn1	v6.4h, v6.4h, v7.4h
trn1	v1.2s, v1.2s, v3.2s
trn1	v2.2s, v2.2s, v4.2s
trn1	v3.2s, v3.2s, v5.2s
trn1	v4.2s, v4.2s, v6.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
Lmc__3a94:
subs	w5, w5, #0x4
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
ld1	{ v18.h }[0], [x9], x3
ld1	{ v19.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
trn1	v18.4h, v18.4h, v19.4h
trn1	v5.2s, v5.2s, v7.2s
trn1	v6.2s, v6.2s, v16.2s
trn1	v7.2s, v7.2s, v17.2s
trn1	v16.2s, v16.2s, v18.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.8h, v2.8h, v0.h[1]
mla	v30.8h, v3.8h, v0.h[2]
mla	v30.8h, v4.8h, v0.h[3]
mla	v30.8h, v5.8h, v0.h[4]
mla	v30.8h, v6.8h, v0.h[5]
mla	v30.8h, v7.8h, v0.h[6]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
st1	{ v30.h }[2], [x0], x1
st1	{ v30.h }[3], [x8], x1
b.le	Lmc__3b74
cmp	w5, #0x2
mov	v1.16b, v5.16b
mov	v2.16b, v6.16b
mov	v3.16b, v7.16b
mov	v4.16b, v16.16b
mov	v5.16b, v17.16b
mov	v6.16b, v18.16b
mov	v7.16b, v19.16b
b.eq	Lmc__3b30
b	Lmc__3a94
Lmc__3b30:
ld1	{ v16.h }[0], [x9], x3
ld1	{ v17.h }[0], [x2], x3
trn1	v7.4h, v7.4h, v16.4h
trn1	v16.4h, v16.4h, v17.4h
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v30.4h, v2.4h, v0.h[1]
mla	v30.4h, v3.4h, v0.h[2]
mla	v30.4h, v4.4h, v0.h[3]
mla	v30.4h, v5.4h, v0.h[4]
mla	v30.4h, v6.4h, v0.h[5]
mla	v30.4h, v7.4h, v0.h[6]
sqrshrun	v30.8b, v30.8h, #0x6
st1	{ v30.h }[0], [x0], x1
st1	{ v30.h }[1], [x8], x1
Lmc__3b74:
ret
Lmc__3b78:
b.gt	Lmc__3c28
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x2], x3
ld1	{ v2.s }[0], [x9], x3
ld1	{ v3.s }[0], [x2], x3
ld1	{ v4.s }[0], [x9], x3
ld1	{ v5.s }[0], [x2], x3
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
st1	{ v6.s }[0], [x0], x1
st1	{ v6.s }[1], [x8], x1
b.le	Lmc__3c24
ld1	{ v6.s }[0], [x9], x3
ld1	{ v7.s }[0], [x2], x3
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v7.s }[0], [x0], x1
st1	{ v7.s }[1], [x8], x1
Lmc__3c24:
ret
Lmc__3c28:
ld1	{ v0.8b }, [x7]
sub	x9, x2, x3, lsl #1
add	x8, x0, x1
sub	x2, x9, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x2], x3
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
Lmc__3c90:
subs	w5, w5, #0x4
ld1	{ v23.s }[0], [x9], x3
ld1	{ v24.s }[0], [x2], x3
ld1	{ v25.s }[0], [x9], x3
ld1	{ v26.s }[0], [x2], x3
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	Lmc__3e18
ld1	{ v27.s }[0], [x9], x3
ld1	{ v16.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
b.le	Lmc__3e18
ld1	{ v17.s }[0], [x9], x3
ld1	{ v18.s }[0], [x2], x3
subs	w5, w5, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.le	Lmc__3e18
subs	w5, w5, #0x4
ld1	{ v19.s }[0], [x9], x3
ld1	{ v20.s }[0], [x2], x3
ld1	{ v21.s }[0], [x9], x3
ld1	{ v22.s }[0], [x2], x3
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x8], x1
st1	{ v2.s }[0], [x0], x1
st1	{ v2.s }[1], [x8], x1
b.gt	Lmc__3c90
Lmc__3e18:
ret
Lmc__3e1c:
b.gt	Lmc__3ee0
cmp	w5, #0x2
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x2], x3
ld1	{ v2.8b }, [x9], x3
ld1	{ v3.8b }, [x2], x3
ld1	{ v4.8b }, [x9], x3
ld1	{ v5.8b }, [x2], x3
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
sqrshrun	v6.8b, v6.8h, #0x6
sqrshrun	v7.8b, v7.8h, #0x6
st1	{ v6.8b }, [x0], x1
st1	{ v7.8b }, [x8], x1
b.le	Lmc__3edc
ld1	{ v6.8b }, [x9], x3
ld1	{ v7.8b }, [x2], x3
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
Lmc__3edc:
ret
Lmc__3ee0:
ld1	{ v0.8b }, [x7]
sub	x2, x2, x3
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w7, w5
Lmc__3ef4:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8b }, [x2], x3
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__3f3c:
subs	w5, w5, #0x2
ld1	{ v23.8b }, [x9], x3
ld1	{ v24.8b }, [x2], x3
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	Lmc__4144
subs	w5, w5, #0x2
ld1	{ v25.8b }, [x9], x3
ld1	{ v26.8b }, [x2], x3
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mul	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__4144
subs	w5, w5, #0x2
ld1	{ v27.8b }, [x9], x3
ld1	{ v16.8b }, [x2], x3
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mul	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
b.le	Lmc__4144
subs	w5, w5, #0x2
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mul	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__4144
subs	w5, w5, #0x4
ld1	{ v19.8b }, [x9], x3
ld1	{ v20.8b }, [x2], x3
ld1	{ v21.8b }, [x9], x3
ld1	{ v22.8b }, [x2], x3
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mul	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mul	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun	v2.8b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun	v4.8b, v4.8h, #0x6
st1	{ v1.8b }, [x0], x1
st1	{ v2.8b }, [x8], x1
st1	{ v3.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.gt	Lmc__3f3c
Lmc__4144:
subs	w4, w4, #0x8
b.le	Lmc__4170
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	Lmc__3ef4
Lmc__4170:
ret
Lmc__4174:
b.gt	Lmc__3ee0
ldur	s0, [x7, #0x2]
sub	x2, x2, x3
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w5, #0x2
ld1	{ v1.16b }, [x2], x3
ld1	{ v2.16b }, [x9], x3
ld1	{ v3.16b }, [x2], x3
ld1	{ v4.16b }, [x9], x3
ld1	{ v5.16b }, [x2], x3
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v16.8b, v16.8h, #0x6
sqrshrun2	v16.16b, v17.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v16.16b }, [x8], x1
b.le	Lmc__42a0
ld1	{ v6.16b }, [x9], x3
ld1	{ v7.16b }, [x2], x3
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
sqrshrun	v1.8b, v1.8h, #0x6
sqrshrun2	v1.16b, v2.8h, #0x6
sqrshrun	v3.8b, v3.8h, #0x6
sqrshrun2	v3.16b, v4.8h, #0x6
st1	{ v1.16b }, [x0], x1
st1	{ v3.16b }, [x8], x1
Lmc__42a0:
ret
Lmc__42a4:
cmp	w5, #0x4
ubfx	w9, w7, #7, #7
and	w7, w7, #0x7f
b.le	Lmc__42b8
mov	w7, w9
Lmc__42b8:
add	x7, x10, w7, uxtw #3
adrp	x9, put_6tap_hv_tbl
add	x9, x9, :lo12:put_6tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__42d0:
ldur	s0, [x6, #0x2]
b.gt	Lmc__4364
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	Lmc__4428
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
Lmc__4328:
bl	Lmc__4428
ext	v18.8b, v17.8b, v28.8b, #0x4
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	Lmc__4424
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
b	Lmc__4328
Lmc__4364:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3, lsl #1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v28.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
mul	v28.4h, v28.4h, v0.4h
mul	v29.4h, v29.4h, v0.4h
addp	v28.4h, v28.4h, v29.4h
addp	v16.4h, v28.4h, v28.4h
srshr	v16.4h, v16.4h, #0x2
bl	Lmc__4428
trn1	v16.2s, v16.2s, v28.2s
mov	v17.8b, v28.8b
bl	Lmc__4428
ext	v18.8b, v17.8b, v28.8b, #0x4
mov	v19.8b, v28.8b
bl	Lmc__4428
ext	v20.8b, v19.8b, v28.8b, #0x4
mov	v21.8b, v28.8b
Lmc__43d0:
bl	Lmc__4428
ext	v22.8b, v21.8b, v28.8b, #0x4
smull	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0xa
sqxtun	v2.8b, v2.8h
subs	w5, w5, #0x2
st1	{ v2.h }[0], [x0], x1
st1	{ v2.h }[1], [x8], x1
b.le	Lmc__4424
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
b	Lmc__43d0
Lmc__4424:
ret	x15
Lmc__4428:
ld1	{ v28.8b }, [x9], x3
ld1	{ v30.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ext	v29.16b, v28.16b, v28.16b, #0x2
ext	v31.16b, v30.16b, v30.16b, #0x2
trn1	v27.2s, v28.2s, v30.2s
trn2	v30.2s, v28.2s, v30.2s
trn1	v28.2s, v29.2s, v31.2s
trn2	v31.2s, v29.2s, v31.2s
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v30.4h, v0.h[2]
mla	v27.4h, v31.4h, v0.h[3]
srshr	v28.4h, v27.4h, #0x2
ret
Lmc__4468:
ldur	s0, [x6, #0x2]
b.gt	Lmc__4524
ldur	s1, [x7, #0x2]
sub	x9, x2, #0x1
sub	x2, x9, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	Lmc__4604
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
Lmc__44c8:
bl	Lmc__4604
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	Lmc__4600
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	Lmc__44c8
Lmc__4524:
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x1
sub	x9, x2, x3
sub	x2, x2, x3, lsl #1
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v18.4h, v31.4h, #0x2
bl	Lmc__4604
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	Lmc__4604
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
Lmc__458c:
bl	Lmc__4604
smull	v2.4s, v18.4h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal	v2.4s, v28.4h, v1.h[6]
smull	v3.4s, v19.4h, v1.h[1]
smlal	v3.4s, v20.4h, v1.h[2]
smlal	v3.4s, v21.4h, v1.h[3]
smlal	v3.4s, v22.4h, v1.h[4]
smlal	v3.4s, v28.4h, v1.h[5]
smlal	v3.4s, v29.4h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn	v3.4h, v3.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v3.8b, v3.8h
str	s2, [x0]
str	s3, [x8]
add	x0, x0, x1
add	x8, x8, x1
b.le	Lmc__4600
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	Lmc__458c
Lmc__4600:
ret	x15
Lmc__4604:
ld1	{ v26.8b }, [x9], x3
ld1	{ v27.8b }, [x2], x3
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
Lmc__4658:
b.gt	Lmc__4744
ld1	{ v0.8b }, [x6]
ldur	s1, [x7, #0x2]
sub	x2, x2, #0x2
sub	x2, x2, x3
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
Lmc__467c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	Lmc__486c
bl	Lmc__48ac
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
Lmc__469c:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	Lmc__48ac
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__4718
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	Lmc__469c
Lmc__4718:
subs	w4, w4, #0x8
b.le	Lmc__4868
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #2
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	Lmc__467c
Lmc__4744:
ld1	{ v0.8b }, [x6]
ld1	{ v1.8b }, [x7]
sub	x2, x2, #0x2
sub	x2, x2, x3, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w7, w5
Lmc__4764:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
bl	Lmc__486c
mov	v18.16b, v16.16b
bl	Lmc__48ac
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	Lmc__48ac
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
Lmc__4794:
smull	v2.4s, v18.4h, v1.h[1]
smull2	v3.4s, v18.8h, v1.h[1]
bl	Lmc__48ac
smull	v4.4s, v19.4h, v1.h[1]
smull2	v5.4s, v19.8h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal2	v3.4s, v19.8h, v1.h[2]
smlal	v4.4s, v20.4h, v1.h[2]
smlal2	v5.4s, v20.8h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal2	v3.4s, v20.8h, v1.h[3]
smlal	v4.4s, v21.4h, v1.h[3]
smlal2	v5.4s, v21.8h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal2	v3.4s, v21.8h, v1.h[4]
smlal	v4.4s, v22.4h, v1.h[4]
smlal2	v5.4s, v22.8h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal2	v3.4s, v22.8h, v1.h[5]
smlal	v4.4s, v24.4h, v1.h[5]
smlal2	v5.4s, v24.8h, v1.h[5]
smlal	v2.4s, v24.4h, v1.h[6]
smlal2	v3.4s, v24.8h, v1.h[6]
smlal	v4.4s, v25.4h, v1.h[6]
smlal2	v5.4s, v25.8h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0xa
sqrshrn2	v2.8h, v3.4s, #0xa
sqrshrn	v4.4h, v4.4s, #0xa
sqrshrn2	v4.8h, v5.4s, #0xa
subs	w5, w5, #0x2
sqxtun	v2.8b, v2.8h
sqxtun	v4.8b, v4.8h
st1	{ v2.8b }, [x0], x1
st1	{ v4.8b }, [x8], x1
b.le	Lmc__4838
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	Lmc__4794
Lmc__4838:
subs	w4, w4, #0x8
b.le	Lmc__4868
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #3
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
add	x2, x2, x3, lsl #1
b	Lmc__4764
Lmc__4868:
ret	x15
Lmc__486c:
ld1	{ v28.8b, v29.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[1]
ext	v25.16b, v28.16b, v29.16b, #0x2
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v28.16b, v29.16b, #0x6
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0x8
ext	v25.16b, v28.16b, v29.16b, #0xa
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
srshr	v16.8h, v16.8h, #0x2
ret
Lmc__48ac:
ld1	{ v28.8b, v29.8b }, [x9], x3
ld1	{ v30.8b, v31.8b }, [x2], x3
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[1]
mul	v25.8h, v30.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
put_bilin_8bpc_neon:
dup	v1.16b, w6
dup	v3.16b, w7
mov	w9, #0x10
sub	w8, w9, w6
sub	w9, w9, w7
dup	v0.16b, w8
dup	v2.16b, w9
clz	w8, w4
sub	w8, w8, #0x18
cbnz	w6, Lmc__4958
cbnz	w7, Lmc__4af4
b	put_neon
Lmc__4958:
cbnz	w7, Lmc__4ce4
adrp	x9, put_bilin_h_tbl
add	x9, x9, :lo12:put_bilin_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__4970:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
Lmc__4980:
ld1r	{ v4.4s }, [x2], x3
ld1r	{ v6.4s }, [x9], x3
ext	v5.8b, v4.8b, v4.8b, #0x1
ext	v7.8b, v6.8b, v6.8b, #0x1
trn1	v4.4h, v4.4h, v6.4h
trn1	v5.4h, v5.4h, v7.4h
subs	w5, w5, #0x2
umull	v4.8h, v4.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.h }[0], [x0], x1
st1	{ v4.h }[1], [x8], x1
b.gt	Lmc__4980
ret
Lmc__49b8:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
Lmc__49c8:
ld1	{ v4.8b }, [x2], x3
ld1	{ v6.8b }, [x9], x3
ext	v5.8b, v4.8b, v4.8b, #0x1
ext	v7.8b, v6.8b, v6.8b, #0x1
trn1	v4.2s, v4.2s, v6.2s
trn1	v5.2s, v5.2s, v7.2s
subs	w5, w5, #0x2
umull	v4.8h, v4.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x8], x1
b.gt	Lmc__49c8
ret
Lmc__4a00:
add	x8, x0, x1
add	x9, x2, x3
lsl	x1, x1, #1
lsl	x3, x3, #1
Lmc__4a10:
ld1	{ v4.16b }, [x2], x3
ld1	{ v6.16b }, [x9], x3
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v7.16b, v6.16b, v6.16b, #0x1
subs	w5, w5, #0x2
umull	v4.8h, v4.8b, v0.8b
umull	v6.8h, v6.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
umlal	v6.8h, v7.8b, v1.8b
uqrshrn	v4.8b, v4.8h, #0x4
uqrshrn	v6.8b, v6.8h, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v6.8b }, [x8], x1
b.gt	Lmc__4a10
ret
Lmc__4a4c:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
sub	x3, x3, w4, uxtw
sub	x3, x3, #0x8
lsl	x1, x1, #1
sub	x1, x1, w4, uxtw
Lmc__4a68:
ld1	{ v16.d }[1], [x2], #8
ld1	{ v20.d }[1], [x9], #8
mov	w6, w4
Lmc__4a74:
ld1	{ v18.16b }, [x2], #16
ld1	{ v22.16b }, [x9], #16
ext	v17.16b, v16.16b, v18.16b, #0x8
ext	v19.16b, v16.16b, v18.16b, #0x9
ext	v21.16b, v20.16b, v22.16b, #0x8
ext	v23.16b, v20.16b, v22.16b, #0x9
umull	v16.8h, v17.8b, v0.8b
umull2	v17.8h, v17.16b, v0.16b
umull	v20.8h, v21.8b, v0.8b
umull2	v21.8h, v21.16b, v0.16b
umlal	v16.8h, v19.8b, v1.8b
umlal2	v17.8h, v19.16b, v1.16b
umlal	v20.8h, v23.8b, v1.8b
umlal2	v21.8h, v23.16b, v1.16b
subs	w6, w6, #0x10
uqrshrn	v16.8b, v16.8h, #0x4
uqrshrn2	v16.16b, v17.8h, #0x4
uqrshrn	v20.8b, v20.8h, #0x4
uqrshrn2	v20.16b, v21.8h, #0x4
st1	{ v16.16b }, [x0], #16
st1	{ v20.16b }, [x8], #16
b.le	Lmc__4ad8
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
b	Lmc__4a74
Lmc__4ad8:
add	x0, x0, x1
add	x8, x8, x1
add	x2, x2, x3
add	x9, x9, x3
subs	w5, w5, #0x2
b.gt	Lmc__4a68
ret
Lmc__4af4:
cmp	w5, #0x4
adrp	x9, put_bilin_v_tbl
add	x9, x9, :lo12:put_bilin_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__4b0c:
cmp	w5, #0x2
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v16.8h }, [x2], x3
b.gt	Lmc__4b50
Lmc__4b28:
ld1r	{ v17.8h }, [x9], x3
ld1r	{ v18.8h }, [x2], x3
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
uqrshrn	v4.8b, v4.8h, #0x4
str	h4, [x0]
st1	{ v4.h }[1], [x8]
ret
Lmc__4b50:
ld1r	{ v17.8h }, [x9], x3
ld1r	{ v18.8h }, [x2], x3
ld1r	{ v19.8h }, [x9], x3
ld1r	{ v20.8h }, [x2], x3
sub	w5, w5, #0x4
trn1	v16.4h, v16.4h, v17.4h
trn1	v17.4h, v17.4h, v18.4h
trn1	v18.4h, v18.4h, v19.4h
trn1	v19.4h, v19.4h, v20.4h
trn1	v16.2s, v16.2s, v18.2s
trn1	v17.2s, v17.2s, v19.2s
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
cmp	w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.h }[0], [x0], x1
st1	{ v4.h }[1], [x8], x1
st1	{ v4.h }[2], [x0], x1
st1	{ v4.h }[3], [x8], x1
b.lt	Lmc__4bac
mov	v16.8b, v20.8b
b.eq	Lmc__4b28
b	Lmc__4b50
Lmc__4bac:
ret
Lmc__4bb0:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v16.4s }, [x2], x3
Lmc__4bc4:
ld1r	{ v17.4s }, [x9], x3
ld1r	{ v18.4s }, [x2], x3
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x8], x1
b.le	Lmc__4bf8
mov	v16.8b, v18.8b
b	Lmc__4bc4
Lmc__4bf8:
ret
Lmc__4bfc:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.8b }, [x2], x3
Lmc__4c10:
ld1	{ v17.8b }, [x9], x3
ld1	{ v18.8b }, [x2], x3
umull	v4.8h, v16.8b, v2.8b
umull	v5.8h, v17.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
umlal	v5.8h, v18.8b, v3.8b
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
uqrshrn	v5.8b, v5.8h, #0x4
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x8], x1
b.le	Lmc__4c48
mov	v16.8b, v18.8b
b	Lmc__4c10
Lmc__4c48:
ret
Lmc__4c4c:
mov	w7, w5
Lmc__4c50:
add	x8, x0, x1
add	x9, x2, x3
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v16.16b }, [x2], x3
Lmc__4c64:
ld1	{ v17.16b }, [x9], x3
ld1	{ v18.16b }, [x2], x3
umull	v4.8h, v16.8b, v2.8b
umull2	v5.8h, v16.16b, v2.16b
umull	v6.8h, v17.8b, v2.8b
umull2	v7.8h, v17.16b, v2.16b
umlal	v4.8h, v17.8b, v3.8b
umlal2	v5.8h, v17.16b, v3.16b
umlal	v6.8h, v18.8b, v3.8b
umlal2	v7.8h, v18.16b, v3.16b
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x4
uqrshrn2	v4.16b, v5.8h, #0x4
uqrshrn	v6.8b, v6.8h, #0x4
uqrshrn2	v6.16b, v7.8h, #0x4
st1	{ v4.16b }, [x0], x1
st1	{ v6.16b }, [x8], x1
b.le	Lmc__4cb4
mov	v16.16b, v18.16b
b	Lmc__4c64
Lmc__4cb4:
subs	w4, w4, #0x10
b.le	Lmc__4ce0
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #0x10
add	x0, x0, #0x10
b	Lmc__4c50
Lmc__4ce0:
ret
Lmc__4ce4:
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
adrp	x9, put_bilin_hv_tbl
add	x9, x9, :lo12:put_bilin_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__4d00:
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1r	{ v28.4s }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
Lmc__4d20:
ld1r	{ v28.4s }, [x9], x3
ld1r	{ v30.4s }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
ext	v31.8b, v30.8b, v30.8b, #0x1
trn1	v28.4h, v28.4h, v30.4h
trn1	v29.4h, v29.4h, v31.4h
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
trn1	v16.2s, v16.2s, v17.2s
mul	v4.4h, v16.4h, v2.4h
mla	v4.4h, v17.4h, v3.4h
uqrshrn	v4.8b, v4.8h, #0x8
subs	w5, w5, #0x2
st1	{ v4.h }[0], [x0], x1
st1	{ v4.h }[1], [x8], x1
b.le	Lmc__4d68
trn2	v16.2s, v17.2s, v17.2s
b	Lmc__4d20
Lmc__4d68:
ret
Lmc__4d6c:
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v28.8b }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
Lmc__4d8c:
ld1	{ v28.8b }, [x9], x3
ld1	{ v30.8b }, [x2], x3
ext	v29.8b, v28.8b, v28.8b, #0x1
ext	v31.8b, v30.8b, v30.8b, #0x1
trn1	v28.2s, v28.2s, v30.2s
trn1	v29.2s, v29.2s, v31.2s
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
trn1	v16.2d, v16.2d, v17.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x8
st1	{ v4.s }[0], [x0], x1
st1	{ v4.s }[1], [x8], x1
b.le	Lmc__4dd4
trn2	v16.2d, v17.2d, v17.2d
b	Lmc__4d8c
Lmc__4dd4:
ret
Lmc__4dd8:
mov	w7, w5
Lmc__4ddc:
add	x9, x2, x3
add	x8, x0, x1
lsl	x3, x3, #1
lsl	x1, x1, #1
ld1	{ v28.16b }, [x2], x3
ext	v29.16b, v28.16b, v28.16b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
Lmc__4dfc:
ld1	{ v28.16b }, [x9], x3
ld1	{ v30.16b }, [x2], x3
ext	v29.16b, v28.16b, v28.16b, #0x1
ext	v31.16b, v30.16b, v30.16b, #0x1
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
umull	v18.8h, v30.8b, v0.8b
umlal	v18.8h, v31.8b, v1.8b
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v18.8h, v3.8h
subs	w5, w5, #0x2
uqrshrn	v4.8b, v4.8h, #0x8
uqrshrn	v5.8b, v5.8h, #0x8
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x8], x1
b.le	Lmc__4e4c
mov	v16.16b, v18.16b
b	Lmc__4dfc
Lmc__4e4c:
subs	w4, w4, #0x8
b.le	Lmc__4e78
asr	x3, x3, #1
asr	x1, x1, #1
msub	x2, x3, x7, x2
msub	x0, x1, x7, x0
sub	x2, x2, x3, lsl #1
mov	w5, w7
add	x2, x2, #0x8
add	x0, x0, #0x8
b	Lmc__4ddc
Lmc__4e78:
ret
prep_8tap_regular_sharp_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0xf2d
b	prep_8tap_neon
prep_8tap_smooth_sharp_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0xf2d
b	prep_8tap_neon
prep_8tap_sharp_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0xf2d
b	prep_8tap_neon
prep_8tap_sharp_regular_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x2d
b	prep_8tap_neon
prep_8tap_sharp_smooth_8bpc_neon:
mov	x8, #0xf2d
mov	x9, #0x7bc
b	prep_8tap_neon
prep_8tap_neon:
mov	w10, #0x4081
mul	w5, w5, w10
mul	w6, w6, w10
add	w5, w5, w8
add	w6, w6, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
tst	w5, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	Lmc__4ef8
tst	w6, #0x1fc000
b.ne	Lmc__5208
b	prep_neon
Lmc__4ef8:
cmp	w3, #0x4
ubfx	w9, w5, #7, #7
and	w5, w5, #0x7f
b.le	Lmc__4f0c
mov	w5, w9
Lmc__4f0c:
tst	w6, #0x1fc000
add	x5, x10, w5, uxtw #3
b.ne	Lmc__59f0
adrp	x9, prep_8tap_h_tbl
add	x9, x9, :lo12:prep_8tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__4f2c:
ldur	s0, [x5, #0x2]
sub	x1, x1, #0x1
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__4f48:
ld1	{ v16.8b }, [x1], x2
ld1	{ v20.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w4, w4, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
st1	{ v16.4h }, [x0], x7
st1	{ v20.4h }, [x8], x7
b.gt	Lmc__4f48
ret
Lmc__4fac:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x3
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__4fc8:
ld1	{ v16.8b, v17.8b }, [x1], x2
ld1	{ v20.8b, v21.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[0]
mul	v22.8h, v20.8h, v0.h[0]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[1]
mla	v22.8h, v23.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xc
ext	v23.16b, v20.16b, v21.16b, #0xc
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
ext	v19.16b, v16.16b, v17.16b, #0xe
ext	v23.16b, v20.16b, v21.16b, #0xe
mla	v18.8h, v19.8h, v0.h[7]
mla	v22.8h, v23.8h, v0.h[7]
subs	w4, w4, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
st1	{ v18.8h }, [x0], x7
st1	{ v22.8h }, [x8], x7
b.gt	Lmc__4fc8
ret
Lmc__5074:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x3
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
sub	x2, x2, w3, uxtw
sub	x2, x2, #0x8
Lmc__5094:
ld1	{ v16.8b, v17.8b, v18.8b }, [x1], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w5, w3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__50b8:
mul	v24.8h, v16.8h, v0.h[0]
mul	v25.8h, v17.8h, v0.h[0]
mul	v26.8h, v20.8h, v0.h[0]
mul	v27.8h, v21.8h, v0.h[0]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[1]
mla	v25.8h, v29.8h, v0.h[1]
mla	v26.8h, v30.8h, v0.h[1]
mla	v27.8h, v31.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xc
ext	v29.16b, v17.16b, v18.16b, #0xc
ext	v30.16b, v20.16b, v21.16b, #0xc
ext	v31.16b, v21.16b, v22.16b, #0xc
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
ext	v28.16b, v16.16b, v17.16b, #0xe
ext	v29.16b, v17.16b, v18.16b, #0xe
ext	v30.16b, v20.16b, v21.16b, #0xe
ext	v31.16b, v21.16b, v22.16b, #0xe
mla	v24.8h, v28.8h, v0.h[7]
mla	v25.8h, v29.8h, v0.h[7]
mla	v26.8h, v30.8h, v0.h[7]
mla	v27.8h, v31.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w5, w5, #0x10
st1	{ v24.8h, v25.8h }, [x0], #32
st1	{ v26.8h, v27.8h }, [x8], #32
b.le	Lmc__51ec
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x1], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	Lmc__50b8
Lmc__51ec:
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #0x2
b.gt	Lmc__5094
ret
Lmc__5208:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	Lmc__521c
mov	w6, w9
Lmc__521c:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_8tap_v_tbl
add	x9, x9, :lo12:prep_8tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__5234:
b.gt	Lmc__52e4
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x1], x2
ld1	{ v2.s }[0], [x9], x2
ld1	{ v3.s }[0], [x1], x2
ld1	{ v4.s }[0], [x9], x2
ld1	{ v5.s }[0], [x1], x2
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
st1	{ v6.8b }, [x0], x7
st1	{ v6.d }[1], [x8], x7
b.le	Lmc__52e0
ld1	{ v6.s }[0], [x9], x2
ld1	{ v7.s }[0], [x1], x2
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
srshr	v7.8h, v7.8h, #0x2
st1	{ v7.8b }, [x0], x7
st1	{ v7.d }[1], [x8], x7
Lmc__52e0:
ret
Lmc__52e4:
ld1	{ v0.8b }, [x6]
sub	x9, x1, x2, lsl #1
add	x8, x0, x7
sub	x1, x9, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x1], x2
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
Lmc__534c:
subs	w4, w4, #0x4
ld1	{ v23.s }[0], [x9], x2
ld1	{ v24.s }[0], [x1], x2
ld1	{ v25.s }[0], [x9], x2
ld1	{ v26.s }[0], [x1], x2
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v18.8h, v0.h[0]
mla	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
mla	v2.8h, v25.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	Lmc__5504
ld1	{ v27.s }[0], [x9], x2
ld1	{ v16.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
b.le	Lmc__5504
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v22.8h, v0.h[0]
mla	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
mla	v2.8h, v17.8h, v0.h[7]
srshr	v2.8h, v2.8h, #0x2
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	Lmc__5504
subs	w4, w4, #0x4
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v26.8h, v0.h[0]
mla	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
mla	v2.8h, v21.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.gt	Lmc__534c
Lmc__5504:
ret
Lmc__5508:
b.gt	Lmc__55cc
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x1], x2
ld1	{ v2.8b }, [x9], x2
ld1	{ v3.8b }, [x1], x2
ld1	{ v4.8b }, [x9], x2
ld1	{ v5.8b }, [x1], x2
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
st1	{ v6.16b }, [x0], x7
st1	{ v7.16b }, [x8], x7
b.le	Lmc__55c8
ld1	{ v6.8b }, [x9], x2
ld1	{ v7.8b }, [x1], x2
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
Lmc__55c8:
ret
Lmc__55cc:
ld1	{ v0.8b }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w6, w4
Lmc__55e0:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.8b }, [x1], x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__5628:
subs	w4, w4, #0x2
ld1	{ v23.8b }, [x9], x2
ld1	{ v24.8b }, [x1], x2
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mla	v1.8h, v23.8h, v0.h[7]
mul	v2.8h, v17.8h, v0.h[0]
mla	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
mla	v2.8h, v24.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	Lmc__5890
subs	w4, w4, #0x2
ld1	{ v25.8b }, [x9], x2
ld1	{ v26.8b }, [x1], x2
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v18.8h, v0.h[0]
mla	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mla	v3.8h, v25.8h, v0.h[7]
mul	v4.8h, v19.8h, v0.h[0]
mla	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
mla	v4.8h, v26.8h, v0.h[7]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	Lmc__5890
subs	w4, w4, #0x2
ld1	{ v27.8b }, [x9], x2
ld1	{ v16.8b }, [x1], x2
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v20.8h, v0.h[0]
mla	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mla	v1.8h, v27.8h, v0.h[7]
mul	v2.8h, v21.8h, v0.h[0]
mla	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
mla	v2.8h, v16.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	Lmc__5890
subs	w4, w4, #0x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v22.8h, v0.h[0]
mla	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mla	v3.8h, v17.8h, v0.h[7]
mul	v4.8h, v23.8h, v0.h[0]
mla	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
mla	v4.8h, v18.8h, v0.h[7]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	Lmc__5890
subs	w4, w4, #0x4
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v24.8h, v0.h[0]
mla	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mla	v1.8h, v19.8h, v0.h[7]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mla	v2.8h, v20.8h, v0.h[7]
mul	v3.8h, v26.8h, v0.h[0]
mla	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mla	v3.8h, v21.8h, v0.h[7]
mul	v4.8h, v27.8h, v0.h[0]
mla	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
mla	v4.8h, v22.8h, v0.h[7]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.gt	Lmc__5628
Lmc__5890:
subs	w3, w3, #0x8
b.le	Lmc__58bc
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	Lmc__55e0
Lmc__58bc:
ret
Lmc__58c0:
b.gt	Lmc__55cc
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w4, #0x2
ld1	{ v1.16b }, [x1], x2
ld1	{ v2.16b }, [x9], x2
ld1	{ v3.16b }, [x1], x2
ld1	{ v4.16b }, [x9], x2
ld1	{ v5.16b }, [x1], x2
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v16.8h, v16.8h, #0x2
srshr	v17.8h, v17.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v16.8h, v17.8h }, [x8], x7
b.le	Lmc__59ec
ld1	{ v6.16b }, [x9], x2
ld1	{ v7.16b }, [x1], x2
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v3.8h, v4.8h }, [x8], x7
Lmc__59ec:
ret
Lmc__59f0:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	Lmc__5a04
mov	w6, w9
Lmc__5a04:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_8tap_hv_tbl
add	x9, x9, :lo12:prep_8tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__5a1c:
ldur	s0, [x5, #0x2]
b.gt	Lmc__5ac8
ldur	s1, [x6, #0x2]
sub	x9, x1, #0x1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	Lmc__5bbc
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
Lmc__5a7c:
bl	Lmc__5bbc
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	Lmc__5bb8
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	Lmc__5a7c
Lmc__5ac8:
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x1
sub	x9, x1, x2, lsl #1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	Lmc__5bbc
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
bl	Lmc__5bbc
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	Lmc__5bbc
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
Lmc__5b3c:
bl	Lmc__5bbc
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal	v2.4s, v28.4h, v1.h[7]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v19.4h, v1.h[2]
smlal	v3.4s, v20.4h, v1.h[3]
smlal	v3.4s, v21.4h, v1.h[4]
smlal	v3.4s, v22.4h, v1.h[5]
smlal	v3.4s, v28.4h, v1.h[6]
smlal	v3.4s, v29.4h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	Lmc__5bb8
mov	v16.8b, v18.8b
mov	v17.8b, v19.8b
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	Lmc__5b3c
Lmc__5bb8:
ret	x15
Lmc__5bbc:
ld1	{ v26.8b }, [x9], x2
ld1	{ v27.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
Lmc__5c10:
b.gt	Lmc__5cf4
ld1	{ v0.8b }, [x5]
ldur	s1, [x6, #0x2]
sub	x1, x1, #0x3
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
Lmc__5c34:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	Lmc__5e44
bl	Lmc__5e94
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
Lmc__5c54:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	Lmc__5e94
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	Lmc__5cc8
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	Lmc__5c54
Lmc__5cc8:
subs	w3, w3, #0x8
b.le	Lmc__5e40
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	Lmc__5c34
Lmc__5cf4:
ld1	{ v0.8b }, [x5]
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x3
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
Lmc__5d18:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	Lmc__5e44
bl	Lmc__5e94
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
bl	Lmc__5e94
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	Lmc__5e94
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
Lmc__5d50:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	Lmc__5e94
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v19.4h, v1.h[2]
smlal2	v5.4s, v19.8h, v1.h[2]
smlal	v2.4s, v19.4h, v1.h[3]
smlal2	v3.4s, v19.8h, v1.h[3]
smlal	v4.4s, v20.4h, v1.h[3]
smlal2	v5.4s, v20.8h, v1.h[3]
smlal	v2.4s, v20.4h, v1.h[4]
smlal2	v3.4s, v20.8h, v1.h[4]
smlal	v4.4s, v21.4h, v1.h[4]
smlal2	v5.4s, v21.8h, v1.h[4]
smlal	v2.4s, v21.4h, v1.h[5]
smlal2	v3.4s, v21.8h, v1.h[5]
smlal	v4.4s, v22.4h, v1.h[5]
smlal2	v5.4s, v22.8h, v1.h[5]
smlal	v2.4s, v22.4h, v1.h[6]
smlal2	v3.4s, v22.8h, v1.h[6]
smlal	v4.4s, v24.4h, v1.h[6]
smlal2	v5.4s, v24.8h, v1.h[6]
smlal	v2.4s, v24.4h, v1.h[7]
smlal2	v3.4s, v24.8h, v1.h[7]
smlal	v4.4s, v25.4h, v1.h[7]
smlal2	v5.4s, v25.8h, v1.h[7]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	Lmc__5e14
mov	v16.16b, v18.16b
mov	v17.16b, v19.16b
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	Lmc__5d50
Lmc__5e14:
subs	w3, w3, #0x8
b.le	Lmc__5e40
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	Lmc__5d18
Lmc__5e40:
ret	x15
Lmc__5e44:
ld1	{ v28.8b, v29.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[0]
ext	v24.16b, v28.16b, v29.16b, #0x2
ext	v25.16b, v28.16b, v29.16b, #0x4
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v28.16b, v29.16b, #0x8
mla	v16.8h, v24.8h, v0.h[1]
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0xa
ext	v25.16b, v28.16b, v29.16b, #0xc
ext	v26.16b, v28.16b, v29.16b, #0xe
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
mla	v16.8h, v26.8h, v0.h[7]
srshr	v16.8h, v16.8h, #0x2
ret
Lmc__5e94:
ld1	{ v28.8b, v29.8b }, [x9], x2
ld1	{ v30.8b, v31.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[0]
mul	v25.8h, v30.8h, v0.h[0]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[1]
mla	v25.8h, v27.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xc
ext	v27.16b, v30.16b, v31.16b, #0xc
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
ext	v26.16b, v28.16b, v29.16b, #0xe
ext	v27.16b, v30.16b, v31.16b, #0xe
mla	v24.8h, v26.8h, v0.h[7]
mla	v25.8h, v27.8h, v0.h[7]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
prep_8tap_regular_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x2d
b	prep_6tap_neon
prep_8tap_regular_smooth_8bpc_neon:
mov	x8, #0x2d
mov	x9, #0x7bc
b	prep_6tap_neon
prep_8tap_smooth_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x7bc
b	prep_6tap_neon
prep_8tap_smooth_regular_8bpc_neon:
mov	x8, #0x7bc
mov	x9, #0x2d
b	prep_6tap_neon
prep_6tap_neon:
mov	w10, #0x4081
mul	w5, w5, w10
mul	w6, w6, w10
add	w5, w5, w8
add	w6, w6, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
tst	w5, #0x1fc000
sub	w8, w8, #0x18
adrp	x10, mc_subpel_filters-8
add	x10, x10, :lo12:mc_subpel_filters-8
b.ne	Lmc__5fa0
tst	w6, #0x1fc000
b.ne	Lmc__6250
b	prep_neon
Lmc__5fa0:
cmp	w3, #0x4
ubfx	w9, w5, #7, #7
and	w5, w5, #0x7f
b.le	Lmc__5fb4
mov	w5, w9
Lmc__5fb4:
tst	w6, #0x1fc000
add	x5, x10, w5, uxtw #3
b.ne	Lmc__69a8
adrp	x9, prep_6tap_h_tbl
add	x9, x9, :lo12:prep_6tap_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__5fd4:
ldur	s0, [x5, #0x2]
sub	x1, x1, #0x1
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__5ff0:
ld1	{ v16.8b }, [x1], x2
ld1	{ v20.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ext	v17.16b, v16.16b, v16.16b, #0x2
ext	v18.16b, v16.16b, v16.16b, #0x4
ext	v19.16b, v16.16b, v16.16b, #0x6
ext	v21.16b, v20.16b, v20.16b, #0x2
ext	v22.16b, v20.16b, v20.16b, #0x4
ext	v23.16b, v20.16b, v20.16b, #0x6
subs	w4, w4, #0x2
mul	v16.4h, v16.4h, v0.h[0]
mla	v16.4h, v17.4h, v0.h[1]
mla	v16.4h, v18.4h, v0.h[2]
mla	v16.4h, v19.4h, v0.h[3]
mul	v20.4h, v20.4h, v0.h[0]
mla	v20.4h, v21.4h, v0.h[1]
mla	v20.4h, v22.4h, v0.h[2]
mla	v20.4h, v23.4h, v0.h[3]
srshr	v16.4h, v16.4h, #0x2
srshr	v20.4h, v20.4h, #0x2
st1	{ v16.4h }, [x0], x7
st1	{ v20.4h }, [x8], x7
b.gt	Lmc__5ff0
ret
Lmc__6054:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
Lmc__6070:
ld1	{ v16.8b, v17.8b }, [x1], x2
ld1	{ v20.8b, v21.8b }, [x9], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v18.8h, v16.8h, v0.h[1]
mul	v22.8h, v20.8h, v0.h[1]
ext	v19.16b, v16.16b, v17.16b, #0x2
ext	v23.16b, v20.16b, v21.16b, #0x2
mla	v18.8h, v19.8h, v0.h[2]
mla	v22.8h, v23.8h, v0.h[2]
ext	v19.16b, v16.16b, v17.16b, #0x4
ext	v23.16b, v20.16b, v21.16b, #0x4
mla	v18.8h, v19.8h, v0.h[3]
mla	v22.8h, v23.8h, v0.h[3]
ext	v19.16b, v16.16b, v17.16b, #0x6
ext	v23.16b, v20.16b, v21.16b, #0x6
mla	v18.8h, v19.8h, v0.h[4]
mla	v22.8h, v23.8h, v0.h[4]
ext	v19.16b, v16.16b, v17.16b, #0x8
ext	v23.16b, v20.16b, v21.16b, #0x8
mla	v18.8h, v19.8h, v0.h[5]
mla	v22.8h, v23.8h, v0.h[5]
ext	v19.16b, v16.16b, v17.16b, #0xa
ext	v23.16b, v20.16b, v21.16b, #0xa
mla	v18.8h, v19.8h, v0.h[6]
mla	v22.8h, v23.8h, v0.h[6]
subs	w4, w4, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
st1	{ v18.8h }, [x0], x7
st1	{ v22.8h }, [x8], x7
b.gt	Lmc__6070
ret
Lmc__60fc:
ld1	{ v0.8b }, [x5]
sub	x1, x1, #0x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sshll	v0.8h, v0.8b, #0x0
sub	x2, x2, w3, uxtw
sub	x2, x2, #0x8
Lmc__611c:
ld1	{ v16.8b, v17.8b, v18.8b }, [x1], #24
ld1	{ v20.8b, v21.8b, v22.8b }, [x9], #24
mov	w5, w3
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__6140:
mul	v24.8h, v16.8h, v0.h[1]
mul	v25.8h, v17.8h, v0.h[1]
mul	v26.8h, v20.8h, v0.h[1]
mul	v27.8h, v21.8h, v0.h[1]
ext	v28.16b, v16.16b, v17.16b, #0x2
ext	v29.16b, v17.16b, v18.16b, #0x2
ext	v30.16b, v20.16b, v21.16b, #0x2
ext	v31.16b, v21.16b, v22.16b, #0x2
mla	v24.8h, v28.8h, v0.h[2]
mla	v25.8h, v29.8h, v0.h[2]
mla	v26.8h, v30.8h, v0.h[2]
mla	v27.8h, v31.8h, v0.h[2]
ext	v28.16b, v16.16b, v17.16b, #0x4
ext	v29.16b, v17.16b, v18.16b, #0x4
ext	v30.16b, v20.16b, v21.16b, #0x4
ext	v31.16b, v21.16b, v22.16b, #0x4
mla	v24.8h, v28.8h, v0.h[3]
mla	v25.8h, v29.8h, v0.h[3]
mla	v26.8h, v30.8h, v0.h[3]
mla	v27.8h, v31.8h, v0.h[3]
ext	v28.16b, v16.16b, v17.16b, #0x6
ext	v29.16b, v17.16b, v18.16b, #0x6
ext	v30.16b, v20.16b, v21.16b, #0x6
ext	v31.16b, v21.16b, v22.16b, #0x6
mla	v24.8h, v28.8h, v0.h[4]
mla	v25.8h, v29.8h, v0.h[4]
mla	v26.8h, v30.8h, v0.h[4]
mla	v27.8h, v31.8h, v0.h[4]
ext	v28.16b, v16.16b, v17.16b, #0x8
ext	v29.16b, v17.16b, v18.16b, #0x8
ext	v30.16b, v20.16b, v21.16b, #0x8
ext	v31.16b, v21.16b, v22.16b, #0x8
mla	v24.8h, v28.8h, v0.h[5]
mla	v25.8h, v29.8h, v0.h[5]
mla	v26.8h, v30.8h, v0.h[5]
mla	v27.8h, v31.8h, v0.h[5]
ext	v28.16b, v16.16b, v17.16b, #0xa
ext	v29.16b, v17.16b, v18.16b, #0xa
ext	v30.16b, v20.16b, v21.16b, #0xa
ext	v31.16b, v21.16b, v22.16b, #0xa
mla	v24.8h, v28.8h, v0.h[6]
mla	v25.8h, v29.8h, v0.h[6]
mla	v26.8h, v30.8h, v0.h[6]
mla	v27.8h, v31.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
subs	w5, w5, #0x10
st1	{ v24.8h, v25.8h }, [x0], #32
st1	{ v26.8h, v27.8h }, [x8], #32
b.le	Lmc__6234
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
ld1	{ v17.8b, v18.8b }, [x1], #16
ld1	{ v21.8b, v22.8b }, [x9], #16
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
b	Lmc__6140
Lmc__6234:
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #0x2
b.gt	Lmc__611c
ret
Lmc__6250:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	Lmc__6264
mov	w6, w9
Lmc__6264:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_6tap_v_tbl
add	x9, x9, :lo12:prep_6tap_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__627c:
b.gt	Lmc__632c
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.s }[0], [x1], x2
ld1	{ v2.s }[0], [x9], x2
ld1	{ v3.s }[0], [x1], x2
ld1	{ v4.s }[0], [x9], x2
ld1	{ v5.s }[0], [x1], x2
trn1	v1.2s, v1.2s, v2.2s
trn1	v2.2s, v2.2s, v3.2s
trn1	v3.2s, v3.2s, v4.2s
trn1	v4.2s, v4.2s, v5.2s
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
st1	{ v6.8b }, [x0], x7
st1	{ v6.d }[1], [x8], x7
b.le	Lmc__6328
ld1	{ v6.s }[0], [x9], x2
ld1	{ v7.s }[0], [x1], x2
trn1	v5.2s, v5.2s, v6.2s
trn1	v6.2s, v6.2s, v7.2s
ushll	v5.8h, v5.8b, #0x0
ushll	v6.8h, v6.8b, #0x0
mul	v7.8h, v3.8h, v0.h[0]
mla	v7.8h, v4.8h, v0.h[1]
mla	v7.8h, v5.8h, v0.h[2]
mla	v7.8h, v6.8h, v0.h[3]
srshr	v7.8h, v7.8h, #0x2
st1	{ v7.8b }, [x0], x7
st1	{ v7.d }[1], [x8], x7
Lmc__6328:
ret
Lmc__632c:
ld1	{ v0.8b }, [x6]
sub	x9, x1, x2, lsl #1
add	x8, x0, x7
sub	x1, x9, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v16.s }[0], [x1], x2
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
Lmc__6394:
subs	w4, w4, #0x4
ld1	{ v23.s }[0], [x9], x2
ld1	{ v24.s }[0], [x1], x2
ld1	{ v25.s }[0], [x9], x2
ld1	{ v26.s }[0], [x1], x2
trn1	v22.2s, v22.2s, v23.2s
trn1	v23.2s, v23.2s, v24.2s
trn1	v24.2s, v24.2s, v25.2s
trn1	v25.2s, v25.2s, v26.2s
ushll	v22.8h, v22.8b, #0x0
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
ushll	v25.8h, v25.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v19.8h, v0.h[1]
mla	v2.8h, v20.8h, v0.h[2]
mla	v2.8h, v21.8h, v0.h[3]
mla	v2.8h, v22.8h, v0.h[4]
mla	v2.8h, v23.8h, v0.h[5]
mla	v2.8h, v24.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	Lmc__651c
ld1	{ v27.s }[0], [x9], x2
ld1	{ v16.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v26.2s, v26.2s, v27.2s
trn1	v27.2s, v27.2s, v16.2s
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
b.le	Lmc__651c
ld1	{ v17.s }[0], [x9], x2
ld1	{ v18.s }[0], [x1], x2
subs	w4, w4, #0x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
mul	v2.8h, v23.8h, v0.h[1]
mla	v2.8h, v24.8h, v0.h[2]
mla	v2.8h, v25.8h, v0.h[3]
mla	v2.8h, v26.8h, v0.h[4]
mla	v2.8h, v27.8h, v0.h[5]
mla	v2.8h, v16.8h, v0.h[6]
srshr	v2.8h, v2.8h, #0x2
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.le	Lmc__651c
subs	w4, w4, #0x4
ld1	{ v19.s }[0], [x9], x2
ld1	{ v20.s }[0], [x1], x2
ld1	{ v21.s }[0], [x9], x2
ld1	{ v22.s }[0], [x1], x2
trn1	v18.2s, v18.2s, v19.2s
trn1	v19.2s, v19.2s, v20.2s
trn1	v20.2s, v20.2s, v21.2s
trn1	v21.2s, v21.2s, v22.2s
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v27.8h, v0.h[1]
mla	v2.8h, v16.8h, v0.h[2]
mla	v2.8h, v17.8h, v0.h[3]
mla	v2.8h, v18.8h, v0.h[4]
mla	v2.8h, v19.8h, v0.h[5]
mla	v2.8h, v20.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.8b }, [x0], x7
st1	{ v1.d }[1], [x8], x7
st1	{ v2.8b }, [x0], x7
st1	{ v2.d }[1], [x8], x7
b.gt	Lmc__6394
Lmc__651c:
ret
Lmc__6520:
b.gt	Lmc__65e4
cmp	w4, #0x2
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
ld1	{ v1.8b }, [x1], x2
ld1	{ v2.8b }, [x9], x2
ld1	{ v3.8b }, [x1], x2
ld1	{ v4.8b }, [x9], x2
ld1	{ v5.8b }, [x1], x2
ushll	v1.8h, v1.8b, #0x0
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
ushll	v4.8h, v4.8b, #0x0
ushll	v5.8h, v5.8b, #0x0
mul	v6.8h, v1.8h, v0.h[0]
mla	v6.8h, v2.8h, v0.h[1]
mla	v6.8h, v3.8h, v0.h[2]
mla	v6.8h, v4.8h, v0.h[3]
mul	v7.8h, v2.8h, v0.h[0]
mla	v7.8h, v3.8h, v0.h[1]
mla	v7.8h, v4.8h, v0.h[2]
mla	v7.8h, v5.8h, v0.h[3]
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
st1	{ v6.16b }, [x0], x7
st1	{ v7.16b }, [x8], x7
b.le	Lmc__65e0
ld1	{ v6.8b }, [x9], x2
ld1	{ v7.8b }, [x1], x2
ushll	v6.8h, v6.8b, #0x0
ushll	v7.8h, v7.8b, #0x0
mul	v1.8h, v3.8h, v0.h[0]
mla	v1.8h, v4.8h, v0.h[1]
mla	v1.8h, v5.8h, v0.h[2]
mla	v1.8h, v6.8h, v0.h[3]
mul	v2.8h, v4.8h, v0.h[0]
mla	v2.8h, v5.8h, v0.h[1]
mla	v2.8h, v6.8h, v0.h[2]
mla	v2.8h, v7.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
Lmc__65e0:
ret
Lmc__65e4:
ld1	{ v0.8b }, [x6]
sub	x1, x1, x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
mov	w6, w4
Lmc__65f8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.8b }, [x1], x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v16.8h, v16.8b, #0x0
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
Lmc__6640:
subs	w4, w4, #0x2
ld1	{ v23.8b }, [x9], x2
ld1	{ v24.8b }, [x1], x2
ushll	v23.8h, v23.8b, #0x0
ushll	v24.8h, v24.8b, #0x0
mul	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mla	v1.8h, v20.8h, v0.h[4]
mla	v1.8h, v21.8h, v0.h[5]
mla	v1.8h, v22.8h, v0.h[6]
mul	v2.8h, v18.8h, v0.h[1]
mla	v2.8h, v19.8h, v0.h[2]
mla	v2.8h, v20.8h, v0.h[3]
mla	v2.8h, v21.8h, v0.h[4]
mla	v2.8h, v22.8h, v0.h[5]
mla	v2.8h, v23.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	Lmc__6848
subs	w4, w4, #0x2
ld1	{ v25.8b }, [x9], x2
ld1	{ v26.8b }, [x1], x2
ushll	v25.8h, v25.8b, #0x0
ushll	v26.8h, v26.8b, #0x0
mul	v3.8h, v19.8h, v0.h[1]
mla	v3.8h, v20.8h, v0.h[2]
mla	v3.8h, v21.8h, v0.h[3]
mla	v3.8h, v22.8h, v0.h[4]
mla	v3.8h, v23.8h, v0.h[5]
mla	v3.8h, v24.8h, v0.h[6]
mul	v4.8h, v20.8h, v0.h[1]
mla	v4.8h, v21.8h, v0.h[2]
mla	v4.8h, v22.8h, v0.h[3]
mla	v4.8h, v23.8h, v0.h[4]
mla	v4.8h, v24.8h, v0.h[5]
mla	v4.8h, v25.8h, v0.h[6]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	Lmc__6848
subs	w4, w4, #0x2
ld1	{ v27.8b }, [x9], x2
ld1	{ v16.8b }, [x1], x2
ushll	v27.8h, v27.8b, #0x0
ushll	v16.8h, v16.8b, #0x0
mul	v1.8h, v21.8h, v0.h[1]
mla	v1.8h, v22.8h, v0.h[2]
mla	v1.8h, v23.8h, v0.h[3]
mla	v1.8h, v24.8h, v0.h[4]
mla	v1.8h, v25.8h, v0.h[5]
mla	v1.8h, v26.8h, v0.h[6]
mul	v2.8h, v22.8h, v0.h[1]
mla	v2.8h, v23.8h, v0.h[2]
mla	v2.8h, v24.8h, v0.h[3]
mla	v2.8h, v25.8h, v0.h[4]
mla	v2.8h, v26.8h, v0.h[5]
mla	v2.8h, v27.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
b.le	Lmc__6848
subs	w4, w4, #0x2
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
ushll	v17.8h, v17.8b, #0x0
ushll	v18.8h, v18.8b, #0x0
mul	v3.8h, v23.8h, v0.h[1]
mla	v3.8h, v24.8h, v0.h[2]
mla	v3.8h, v25.8h, v0.h[3]
mla	v3.8h, v26.8h, v0.h[4]
mla	v3.8h, v27.8h, v0.h[5]
mla	v3.8h, v16.8h, v0.h[6]
mul	v4.8h, v24.8h, v0.h[1]
mla	v4.8h, v25.8h, v0.h[2]
mla	v4.8h, v26.8h, v0.h[3]
mla	v4.8h, v27.8h, v0.h[4]
mla	v4.8h, v16.8h, v0.h[5]
mla	v4.8h, v17.8h, v0.h[6]
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.le	Lmc__6848
subs	w4, w4, #0x4
ld1	{ v19.8b }, [x9], x2
ld1	{ v20.8b }, [x1], x2
ld1	{ v21.8b }, [x9], x2
ld1	{ v22.8b }, [x1], x2
ushll	v19.8h, v19.8b, #0x0
ushll	v20.8h, v20.8b, #0x0
ushll	v21.8h, v21.8b, #0x0
ushll	v22.8h, v22.8b, #0x0
mul	v1.8h, v25.8h, v0.h[1]
mla	v1.8h, v26.8h, v0.h[2]
mla	v1.8h, v27.8h, v0.h[3]
mla	v1.8h, v16.8h, v0.h[4]
mla	v1.8h, v17.8h, v0.h[5]
mla	v1.8h, v18.8h, v0.h[6]
mul	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v16.8h, v0.h[3]
mla	v2.8h, v17.8h, v0.h[4]
mla	v2.8h, v18.8h, v0.h[5]
mla	v2.8h, v19.8h, v0.h[6]
mul	v3.8h, v27.8h, v0.h[1]
mla	v3.8h, v16.8h, v0.h[2]
mla	v3.8h, v17.8h, v0.h[3]
mla	v3.8h, v18.8h, v0.h[4]
mla	v3.8h, v19.8h, v0.h[5]
mla	v3.8h, v20.8h, v0.h[6]
mul	v4.8h, v16.8h, v0.h[1]
mla	v4.8h, v17.8h, v0.h[2]
mla	v4.8h, v18.8h, v0.h[3]
mla	v4.8h, v19.8h, v0.h[4]
mla	v4.8h, v20.8h, v0.h[5]
mla	v4.8h, v21.8h, v0.h[6]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.16b }, [x0], x7
st1	{ v2.16b }, [x8], x7
st1	{ v3.16b }, [x0], x7
st1	{ v4.16b }, [x8], x7
b.gt	Lmc__6640
Lmc__6848:
subs	w3, w3, #0x8
b.le	Lmc__6874
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	Lmc__65f8
Lmc__6874:
ret
Lmc__6878:
b.gt	Lmc__65e4
ldur	s0, [x6, #0x2]
sub	x1, x1, x2
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
cmp	w4, #0x2
ld1	{ v1.16b }, [x1], x2
ld1	{ v2.16b }, [x9], x2
ld1	{ v3.16b }, [x1], x2
ld1	{ v4.16b }, [x9], x2
ld1	{ v5.16b }, [x1], x2
ushll	v16.8h, v1.8b, #0x0
ushll	v17.8h, v2.8b, #0x0
ushll	v18.8h, v3.8b, #0x0
ushll	v19.8h, v4.8b, #0x0
ushll	v20.8h, v5.8b, #0x0
ushll2	v23.8h, v1.16b, #0x0
ushll2	v24.8h, v2.16b, #0x0
ushll2	v25.8h, v3.16b, #0x0
ushll2	v26.8h, v4.16b, #0x0
ushll2	v27.8h, v5.16b, #0x0
mul	v1.8h, v16.8h, v0.h[0]
mla	v1.8h, v17.8h, v0.h[1]
mla	v1.8h, v18.8h, v0.h[2]
mla	v1.8h, v19.8h, v0.h[3]
mul	v16.8h, v17.8h, v0.h[0]
mla	v16.8h, v18.8h, v0.h[1]
mla	v16.8h, v19.8h, v0.h[2]
mla	v16.8h, v20.8h, v0.h[3]
mul	v2.8h, v23.8h, v0.h[0]
mla	v2.8h, v24.8h, v0.h[1]
mla	v2.8h, v25.8h, v0.h[2]
mla	v2.8h, v26.8h, v0.h[3]
mul	v17.8h, v24.8h, v0.h[0]
mla	v17.8h, v25.8h, v0.h[1]
mla	v17.8h, v26.8h, v0.h[2]
mla	v17.8h, v27.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v16.8h, v16.8h, #0x2
srshr	v17.8h, v17.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v16.8h, v17.8h }, [x8], x7
b.le	Lmc__69a4
ld1	{ v6.16b }, [x9], x2
ld1	{ v7.16b }, [x1], x2
ushll	v21.8h, v6.8b, #0x0
ushll	v22.8h, v7.8b, #0x0
ushll2	v28.8h, v6.16b, #0x0
ushll2	v29.8h, v7.16b, #0x0
mul	v1.8h, v18.8h, v0.h[0]
mla	v1.8h, v19.8h, v0.h[1]
mla	v1.8h, v20.8h, v0.h[2]
mla	v1.8h, v21.8h, v0.h[3]
mul	v3.8h, v19.8h, v0.h[0]
mla	v3.8h, v20.8h, v0.h[1]
mla	v3.8h, v21.8h, v0.h[2]
mla	v3.8h, v22.8h, v0.h[3]
mul	v2.8h, v25.8h, v0.h[0]
mla	v2.8h, v26.8h, v0.h[1]
mla	v2.8h, v27.8h, v0.h[2]
mla	v2.8h, v28.8h, v0.h[3]
mul	v4.8h, v26.8h, v0.h[0]
mla	v4.8h, v27.8h, v0.h[1]
mla	v4.8h, v28.8h, v0.h[2]
mla	v4.8h, v29.8h, v0.h[3]
srshr	v1.8h, v1.8h, #0x2
srshr	v2.8h, v2.8h, #0x2
srshr	v3.8h, v3.8h, #0x2
srshr	v4.8h, v4.8h, #0x2
st1	{ v1.8h, v2.8h }, [x0], x7
st1	{ v3.8h, v4.8h }, [x8], x7
Lmc__69a4:
ret
Lmc__69a8:
cmp	w4, #0x4
ubfx	w9, w6, #7, #7
and	w6, w6, #0x7f
b.le	Lmc__69bc
mov	w6, w9
Lmc__69bc:
add	x6, x10, w6, uxtw #3
adrp	x9, prep_6tap_hv_tbl
add	x9, x9, :lo12:prep_6tap_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__69d4:
ldur	s0, [x5, #0x2]
b.gt	Lmc__6a80
ldur	s1, [x6, #0x2]
sub	x9, x1, #0x1
sub	x1, x9, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v16.4h, v31.4h, #0x2
bl	Lmc__6b50
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
Lmc__6a34:
bl	Lmc__6b50
smull	v2.4s, v16.4h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal	v2.4s, v28.4h, v1.h[3]
smull	v3.4s, v17.4h, v1.h[0]
smlal	v3.4s, v18.4h, v1.h[1]
smlal	v3.4s, v28.4h, v1.h[2]
smlal	v3.4s, v29.4h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	Lmc__6b4c
mov	v16.8b, v18.8b
mov	v17.8b, v28.8b
mov	v18.8b, v29.8b
b	Lmc__6a34
Lmc__6a80:
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x1
sub	x9, x1, x2
sub	x1, x1, x2, lsl #1
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
ld1	{ v26.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
srshr	v18.4h, v31.4h, #0x2
bl	Lmc__6b50
mov	v19.8b, v28.8b
mov	v20.8b, v29.8b
bl	Lmc__6b50
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
Lmc__6ae8:
bl	Lmc__6b50
smull	v2.4s, v18.4h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal	v2.4s, v28.4h, v1.h[6]
smull	v3.4s, v19.4h, v1.h[1]
smlal	v3.4s, v20.4h, v1.h[2]
smlal	v3.4s, v21.4h, v1.h[3]
smlal	v3.4s, v22.4h, v1.h[4]
smlal	v3.4s, v28.4h, v1.h[5]
smlal	v3.4s, v29.4h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn	v3.4h, v3.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.4h }, [x0], x7
st1	{ v3.4h }, [x8], x7
b.le	Lmc__6b4c
mov	v18.8b, v20.8b
mov	v19.8b, v21.8b
mov	v20.8b, v22.8b
mov	v21.8b, v28.8b
mov	v22.8b, v29.8b
b	Lmc__6ae8
Lmc__6b4c:
ret	x15
Lmc__6b50:
ld1	{ v26.8b }, [x9], x2
ld1	{ v27.8b }, [x1], x2
ushll	v26.8h, v26.8b, #0x0
ushll	v27.8h, v27.8b, #0x0
ext	v28.16b, v26.16b, v26.16b, #0x2
ext	v29.16b, v26.16b, v26.16b, #0x4
ext	v30.16b, v26.16b, v26.16b, #0x6
mul	v31.4h, v26.4h, v0.h[0]
mla	v31.4h, v28.4h, v0.h[1]
mla	v31.4h, v29.4h, v0.h[2]
mla	v31.4h, v30.4h, v0.h[3]
ext	v28.16b, v27.16b, v27.16b, #0x2
ext	v29.16b, v27.16b, v27.16b, #0x4
ext	v30.16b, v27.16b, v27.16b, #0x6
mul	v27.4h, v27.4h, v0.h[0]
mla	v27.4h, v28.4h, v0.h[1]
mla	v27.4h, v29.4h, v0.h[2]
mla	v27.4h, v30.4h, v0.h[3]
srshr	v28.4h, v31.4h, #0x2
srshr	v29.4h, v27.4h, #0x2
ret
Lmc__6ba4:
b.gt	Lmc__6c88
ld1	{ v0.8b }, [x5]
ldur	s1, [x6, #0x2]
sub	x1, x1, #0x2
sub	x1, x1, x2
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
Lmc__6bc8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	Lmc__6da8
bl	Lmc__6de8
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
Lmc__6be8:
smull	v2.4s, v16.4h, v1.h[0]
smull2	v3.4s, v16.8h, v1.h[0]
bl	Lmc__6de8
smull	v4.4s, v17.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[0]
smlal	v2.4s, v17.4h, v1.h[1]
smlal2	v3.4s, v17.8h, v1.h[1]
smlal	v4.4s, v18.4h, v1.h[1]
smlal2	v5.4s, v18.8h, v1.h[1]
smlal	v2.4s, v18.4h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[2]
smlal	v4.4s, v24.4h, v1.h[2]
smlal2	v5.4s, v24.8h, v1.h[2]
smlal	v2.4s, v24.4h, v1.h[3]
smlal2	v3.4s, v24.8h, v1.h[3]
smlal	v4.4s, v25.4h, v1.h[3]
smlal2	v5.4s, v25.8h, v1.h[3]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	Lmc__6c5c
mov	v16.16b, v18.16b
mov	v17.16b, v24.16b
mov	v18.16b, v25.16b
b	Lmc__6be8
Lmc__6c5c:
subs	w3, w3, #0x8
b.le	Lmc__6da4
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #2
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	Lmc__6bc8
Lmc__6c88:
ld1	{ v0.8b }, [x5]
ld1	{ v1.8b }, [x6]
sub	x1, x1, #0x2
sub	x1, x1, x2, lsl #1
sshll	v0.8h, v0.8b, #0x0
sshll	v1.8h, v1.8b, #0x0
mov	x15, x30
mov	w6, w4
Lmc__6ca8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
bl	Lmc__6da8
mov	v18.16b, v16.16b
bl	Lmc__6de8
mov	v19.16b, v24.16b
mov	v20.16b, v25.16b
bl	Lmc__6de8
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
Lmc__6cd8:
smull	v2.4s, v18.4h, v1.h[1]
smull2	v3.4s, v18.8h, v1.h[1]
bl	Lmc__6de8
smull	v4.4s, v19.4h, v1.h[1]
smull2	v5.4s, v19.8h, v1.h[1]
smlal	v2.4s, v19.4h, v1.h[2]
smlal2	v3.4s, v19.8h, v1.h[2]
smlal	v4.4s, v20.4h, v1.h[2]
smlal2	v5.4s, v20.8h, v1.h[2]
smlal	v2.4s, v20.4h, v1.h[3]
smlal2	v3.4s, v20.8h, v1.h[3]
smlal	v4.4s, v21.4h, v1.h[3]
smlal2	v5.4s, v21.8h, v1.h[3]
smlal	v2.4s, v21.4h, v1.h[4]
smlal2	v3.4s, v21.8h, v1.h[4]
smlal	v4.4s, v22.4h, v1.h[4]
smlal2	v5.4s, v22.8h, v1.h[4]
smlal	v2.4s, v22.4h, v1.h[5]
smlal2	v3.4s, v22.8h, v1.h[5]
smlal	v4.4s, v24.4h, v1.h[5]
smlal2	v5.4s, v24.8h, v1.h[5]
smlal	v2.4s, v24.4h, v1.h[6]
smlal2	v3.4s, v24.8h, v1.h[6]
smlal	v4.4s, v25.4h, v1.h[6]
smlal2	v5.4s, v25.8h, v1.h[6]
sqrshrn	v2.4h, v2.4s, #0x6
sqrshrn2	v2.8h, v3.4s, #0x6
sqrshrn	v4.4h, v4.4s, #0x6
sqrshrn2	v4.8h, v5.4s, #0x6
subs	w4, w4, #0x2
st1	{ v2.8h }, [x0], x7
st1	{ v4.8h }, [x8], x7
b.le	Lmc__6d74
mov	v18.16b, v20.16b
mov	v19.16b, v21.16b
mov	v20.16b, v22.16b
mov	v21.16b, v24.16b
mov	v22.16b, v25.16b
b	Lmc__6cd8
Lmc__6d74:
subs	w3, w3, #0x8
b.le	Lmc__6da4
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #3
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
add	x1, x1, x2, lsl #1
b	Lmc__6ca8
Lmc__6da4:
ret	x15
Lmc__6da8:
ld1	{ v28.8b, v29.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
mul	v16.8h, v28.8h, v0.h[1]
ext	v25.16b, v28.16b, v29.16b, #0x2
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v28.16b, v29.16b, #0x6
mla	v16.8h, v25.8h, v0.h[2]
mla	v16.8h, v26.8h, v0.h[3]
mla	v16.8h, v27.8h, v0.h[4]
ext	v24.16b, v28.16b, v29.16b, #0x8
ext	v25.16b, v28.16b, v29.16b, #0xa
mla	v16.8h, v24.8h, v0.h[5]
mla	v16.8h, v25.8h, v0.h[6]
srshr	v16.8h, v16.8h, #0x2
ret
Lmc__6de8:
ld1	{ v28.8b, v29.8b }, [x9], x2
ld1	{ v30.8b, v31.8b }, [x1], x2
ushll	v28.8h, v28.8b, #0x0
ushll	v29.8h, v29.8b, #0x0
ushll	v30.8h, v30.8b, #0x0
ushll	v31.8h, v31.8b, #0x0
mul	v24.8h, v28.8h, v0.h[1]
mul	v25.8h, v30.8h, v0.h[1]
ext	v26.16b, v28.16b, v29.16b, #0x2
ext	v27.16b, v30.16b, v31.16b, #0x2
mla	v24.8h, v26.8h, v0.h[2]
mla	v25.8h, v27.8h, v0.h[2]
ext	v26.16b, v28.16b, v29.16b, #0x4
ext	v27.16b, v30.16b, v31.16b, #0x4
mla	v24.8h, v26.8h, v0.h[3]
mla	v25.8h, v27.8h, v0.h[3]
ext	v26.16b, v28.16b, v29.16b, #0x6
ext	v27.16b, v30.16b, v31.16b, #0x6
mla	v24.8h, v26.8h, v0.h[4]
mla	v25.8h, v27.8h, v0.h[4]
ext	v26.16b, v28.16b, v29.16b, #0x8
ext	v27.16b, v30.16b, v31.16b, #0x8
mla	v24.8h, v26.8h, v0.h[5]
mla	v25.8h, v27.8h, v0.h[5]
ext	v26.16b, v28.16b, v29.16b, #0xa
ext	v27.16b, v30.16b, v31.16b, #0xa
mla	v24.8h, v26.8h, v0.h[6]
mla	v25.8h, v27.8h, v0.h[6]
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
ret
prep_bilin_8bpc_neon:
dup	v1.16b, w5
dup	v3.16b, w6
mov	w9, #0x10
sub	w8, w9, w5
sub	w9, w9, w6
dup	v0.16b, w8
dup	v2.16b, w9
ubfx	x7, x3, #0, #32
lsl	x7, x7, #1
clz	w8, w3
sub	w8, w8, #0x18
cbnz	w5, Lmc__6e9c
cbnz	w6, Lmc__6fcc
b	prep_neon
Lmc__6e9c:
cbnz	w6, Lmc__70fc
adrp	x9, prep_bilin_h_tbl
add	x9, x9, :lo12:prep_bilin_h_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__6eb4:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
Lmc__6ec4:
ld1	{ v4.8b }, [x1], x2
ld1	{ v6.8b }, [x9], x2
ext	v5.8b, v4.8b, v4.8b, #0x1
ext	v7.8b, v6.8b, v6.8b, #0x1
trn1	v4.2s, v4.2s, v6.2s
trn1	v5.2s, v5.2s, v7.2s
subs	w4, w4, #0x2
umull	v4.8h, v4.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
st1	{ v4.8b }, [x0], x7
st1	{ v4.d }[1], [x8], x7
b.gt	Lmc__6ec4
ret
Lmc__6ef8:
add	x8, x0, x7
add	x9, x1, x2
lsl	x7, x7, #1
lsl	x2, x2, #1
Lmc__6f08:
ld1	{ v4.16b }, [x1], x2
ld1	{ v6.16b }, [x9], x2
ext	v5.16b, v4.16b, v4.16b, #0x1
ext	v7.16b, v6.16b, v6.16b, #0x1
subs	w4, w4, #0x2
umull	v4.8h, v4.8b, v0.8b
umull	v6.8h, v6.8b, v0.8b
umlal	v4.8h, v5.8b, v1.8b
umlal	v6.8h, v7.8b, v1.8b
st1	{ v4.8h }, [x0], x7
st1	{ v6.8h }, [x8], x7
b.gt	Lmc__6f08
ret
Lmc__6f3c:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
sub	x2, x2, w3, uxtw
sub	x2, x2, #0x8
Lmc__6f50:
ld1	{ v16.d }[1], [x1], #8
ld1	{ v20.d }[1], [x9], #8
mov	w5, w3
Lmc__6f5c:
ld1	{ v18.16b }, [x1], #16
ld1	{ v22.16b }, [x9], #16
ext	v17.16b, v16.16b, v18.16b, #0x8
ext	v19.16b, v16.16b, v18.16b, #0x9
ext	v21.16b, v20.16b, v22.16b, #0x8
ext	v23.16b, v20.16b, v22.16b, #0x9
umull	v16.8h, v17.8b, v0.8b
umull2	v17.8h, v17.16b, v0.16b
umull	v20.8h, v21.8b, v0.8b
umull2	v21.8h, v21.16b, v0.16b
umlal	v16.8h, v19.8b, v1.8b
umlal2	v17.8h, v19.16b, v1.16b
umlal	v20.8h, v23.8b, v1.8b
umlal2	v21.8h, v23.16b, v1.16b
subs	w5, w5, #0x10
st1	{ v16.8h, v17.8h }, [x0], #32
st1	{ v20.8h, v21.8h }, [x8], #32
b.le	Lmc__6fb0
mov	v16.16b, v18.16b
mov	v20.16b, v22.16b
b	Lmc__6f5c
Lmc__6fb0:
add	x0, x0, x7
add	x8, x8, x7
add	x1, x1, x2
add	x9, x9, x2
subs	w4, w4, #0x2
b.gt	Lmc__6f50
ret
Lmc__6fcc:
cmp	w4, #0x4
adrp	x9, prep_bilin_v_tbl
add	x9, x9, :lo12:prep_bilin_v_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__6fe4:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1r	{ v16.4s }, [x1], x2
Lmc__6ff8:
ld1r	{ v17.4s }, [x9], x2
ld1r	{ v18.4s }, [x1], x2
trn1	v16.2s, v16.2s, v17.2s
trn1	v17.2s, v17.2s, v18.2s
umull	v4.8h, v16.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
subs	w4, w4, #0x2
st1	{ v4.8b }, [x0], x7
st1	{ v4.d }[1], [x8], x7
b.le	Lmc__7028
mov	v16.8b, v18.8b
b	Lmc__6ff8
Lmc__7028:
ret
Lmc__702c:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.8b }, [x1], x2
Lmc__7040:
ld1	{ v17.8b }, [x9], x2
ld1	{ v18.8b }, [x1], x2
umull	v4.8h, v16.8b, v2.8b
umull	v5.8h, v17.8b, v2.8b
umlal	v4.8h, v17.8b, v3.8b
umlal	v5.8h, v18.8b, v3.8b
subs	w4, w4, #0x2
st1	{ v4.8h }, [x0], x7
st1	{ v5.8h }, [x8], x7
b.le	Lmc__7070
mov	v16.8b, v18.8b
b	Lmc__7040
Lmc__7070:
ret
Lmc__7074:
mov	w6, w4
Lmc__7078:
add	x8, x0, x7
add	x9, x1, x2
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v16.16b }, [x1], x2
Lmc__708c:
ld1	{ v17.16b }, [x9], x2
ld1	{ v18.16b }, [x1], x2
umull	v4.8h, v16.8b, v2.8b
umull2	v5.8h, v16.16b, v2.16b
umull	v6.8h, v17.8b, v2.8b
umull2	v7.8h, v17.16b, v2.16b
umlal	v4.8h, v17.8b, v3.8b
umlal2	v5.8h, v17.16b, v3.16b
umlal	v6.8h, v18.8b, v3.8b
umlal2	v7.8h, v18.16b, v3.16b
subs	w4, w4, #0x2
st1	{ v4.8h, v5.8h }, [x0], x7
st1	{ v6.8h, v7.8h }, [x8], x7
b.le	Lmc__70cc
mov	v16.16b, v18.16b
b	Lmc__708c
Lmc__70cc:
subs	w3, w3, #0x10
b.le	Lmc__70f8
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #0x10
add	x0, x0, #0x20
b	Lmc__7078
Lmc__70f8:
ret
Lmc__70fc:
ushll	v2.8h, v2.8b, #0x0
ushll	v3.8h, v3.8b, #0x0
adrp	x9, prep_bilin_hv_tbl
add	x9, x9, :lo12:prep_bilin_hv_tbl
ldrsw	x8, [x9, x8, lsl #2]
add	x9, x9, x8
br	x9
Lmc__7118:
add	x9, x1, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v28.8b }, [x1], x2
ext	v29.8b, v28.8b, v28.8b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
Lmc__7138:
ld1	{ v28.8b }, [x9], x2
ld1	{ v30.8b }, [x1], x2
ext	v29.8b, v28.8b, v28.8b, #0x1
ext	v31.8b, v30.8b, v30.8b, #0x1
trn1	v28.2s, v28.2s, v30.2s
trn1	v29.2s, v29.2s, v31.2s
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
trn1	v16.2d, v16.2d, v17.2d
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
subs	w4, w4, #0x2
urshr	v4.8h, v4.8h, #0x4
st1	{ v4.8b }, [x0], x7
st1	{ v4.d }[1], [x8], x7
b.le	Lmc__7180
trn2	v16.2d, v17.2d, v17.2d
b	Lmc__7138
Lmc__7180:
ret
Lmc__7184:
mov	w6, w4
Lmc__7188:
add	x9, x1, x2
add	x8, x0, x7
lsl	x2, x2, #1
lsl	x7, x7, #1
ld1	{ v28.16b }, [x1], x2
ext	v29.16b, v28.16b, v28.16b, #0x1
umull	v16.8h, v28.8b, v0.8b
umlal	v16.8h, v29.8b, v1.8b
Lmc__71a8:
ld1	{ v28.16b }, [x9], x2
ld1	{ v30.16b }, [x1], x2
ext	v29.16b, v28.16b, v28.16b, #0x1
ext	v31.16b, v30.16b, v30.16b, #0x1
umull	v17.8h, v28.8b, v0.8b
umlal	v17.8h, v29.8b, v1.8b
umull	v18.8h, v30.8b, v0.8b
umlal	v18.8h, v31.8b, v1.8b
mul	v4.8h, v16.8h, v2.8h
mla	v4.8h, v17.8h, v3.8h
mul	v5.8h, v17.8h, v2.8h
mla	v5.8h, v18.8h, v3.8h
subs	w4, w4, #0x2
urshr	v4.8h, v4.8h, #0x4
urshr	v5.8h, v5.8h, #0x4
st1	{ v4.8h }, [x0], x7
st1	{ v5.8h }, [x8], x7
b.le	Lmc__71f8
mov	v16.16b, v18.16b
b	Lmc__71a8
Lmc__71f8:
subs	w3, w3, #0x8
b.le	Lmc__7224
asr	x2, x2, #1
asr	x7, x7, #1
msub	x1, x2, x6, x1
msub	x0, x7, x6, x0
sub	x1, x1, x2, lsl #1
mov	w4, w6
add	x1, x1, #0x8
add	x0, x0, #0x10
b	Lmc__7188
Lmc__7224:
ret
warp_filter_horz_neon:
add	w12, w5, #0x200
ld1	{ v16.8b, v17.8b }, [x2], x3
asr	w13, w12, #10
add	w12, w12, w7
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d2, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d3, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d4, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d5, [x11, w13, sxtw #3]
asr	w13, w12, #10
add	w12, w12, w7
ldr	d6, [x11, w13, sxtw #3]
eor	v16.8b, v16.8b, v22.8b
eor	v17.8b, v17.8b, v22.8b
asr	w13, w12, #10
add	w12, w12, w7
ldr	d7, [x11, w13, sxtw #3]
ext	v18.8b, v16.8b, v17.8b, #0x1
ext	v19.8b, v16.8b, v17.8b, #0x2
smull	v0.8h, v0.8b, v16.8b
smull	v1.8h, v1.8b, v18.8b
ext	v18.8b, v16.8b, v17.8b, #0x3
ext	v20.8b, v16.8b, v17.8b, #0x4
smull	v2.8h, v2.8b, v19.8b
smull	v3.8h, v3.8b, v18.8b
ext	v18.8b, v16.8b, v17.8b, #0x5
ext	v19.8b, v16.8b, v17.8b, #0x6
smull	v4.8h, v4.8b, v20.8b
smull	v5.8h, v5.8b, v18.8b
ext	v18.8b, v16.8b, v17.8b, #0x7
smull	v6.8h, v6.8b, v19.8b
smull	v7.8h, v7.8b, v18.8b
addp	v0.8h, v0.8h, v1.8h
addp	v2.8h, v2.8h, v3.8h
addp	v4.8h, v4.8h, v5.8h
addp	v6.8h, v6.8h, v7.8h
addp	v0.8h, v0.8h, v2.8h
addp	v4.8h, v4.8h, v6.8h
addp	v0.8h, v0.8h, v4.8h
add	w5, w5, w8
ret
warp_affine_8x8_8bpc_neon:
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #0x8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #0x3
adrp	x11, mc_warp_filter+512
add	x11, x11, :lo12:mc_warp_filter+512
mov	x15, x30
movi	v22.8b, #0x80
movi	v23.8h, #0x80
bl	warp_filter_horz_neon
srshr	v24.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v25.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v26.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v27.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v28.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v29.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v30.8h, v0.8h, #0x3
Lmc__7368:
add	w14, w6, #0x200
bl	warp_filter_horz_neon
srshr	v31.8h, v0.8h, #0x3
asr	w13, w14, #10
add	w14, w14, w9
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d2, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d3, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d4, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d5, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d6, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d7, [x11, w13, sxtw #3]
zip1	v0.16b, v0.16b, v1.16b
zip1	v2.16b, v2.16b, v3.16b
zip1	v4.16b, v4.16b, v5.16b
zip1	v6.16b, v6.16b, v7.16b
trn1	v1.8h, v0.8h, v2.8h
trn2	v3.8h, v0.8h, v2.8h
trn1	v5.8h, v4.8h, v6.8h
trn2	v7.8h, v4.8h, v6.8h
trn1	v0.4s, v1.4s, v5.4s
trn2	v2.4s, v1.4s, v5.4s
trn1	v1.4s, v3.4s, v7.4s
trn2	v3.4s, v3.4s, v7.4s
sshll2	v4.8h, v0.16b, #0x0
sshll	v0.8h, v0.8b, #0x0
sshll2	v6.8h, v2.16b, #0x0
sshll	v2.8h, v2.8b, #0x0
sshll2	v5.8h, v1.16b, #0x0
sshll	v1.8h, v1.8b, #0x0
sshll2	v7.8h, v3.16b, #0x0
sshll	v3.8h, v3.8b, #0x0
smull	v16.4s, v24.4h, v0.4h
smlal	v16.4s, v25.4h, v1.4h
smlal	v16.4s, v26.4h, v2.4h
smlal	v16.4s, v27.4h, v3.4h
smlal	v16.4s, v28.4h, v4.4h
smlal	v16.4s, v29.4h, v5.4h
smlal	v16.4s, v30.4h, v6.4h
smlal	v16.4s, v31.4h, v7.4h
smull2	v17.4s, v24.8h, v0.8h
smlal2	v17.4s, v25.8h, v1.8h
smlal2	v17.4s, v26.8h, v2.8h
smlal2	v17.4s, v27.8h, v3.8h
smlal2	v17.4s, v28.8h, v4.8h
smlal2	v17.4s, v29.8h, v5.8h
smlal2	v17.4s, v30.8h, v6.8h
smlal2	v17.4s, v31.8h, v7.8h
mov	v24.16b, v25.16b
mov	v25.16b, v26.16b
sqrshrn	v16.4h, v16.4s, #0xb
mov	v26.16b, v27.16b
sqrshrn2	v16.8h, v17.4s, #0xb
mov	v27.16b, v28.16b
mov	v28.16b, v29.16b
add	v16.8h, v16.8h, v23.8h
sqxtun	v16.8b, v16.8h
mov	v29.16b, v30.16b
mov	v30.16b, v31.16b
subs	w10, w10, #0x1
st1	{ v16.8b }, [x0], x1
add	w6, w6, w4
b.gt	Lmc__7368
ret	x15
warp_affine_8x8t_8bpc_neon:
ldr	x4, [x4]
sxth	x7, w4
sbfx	x8, x4, #16, #16
sbfx	x9, x4, #32, #16
asr	x4, x4, #48
mov	w10, #0x8
sub	x2, x2, x3, lsl #1
sub	x2, x2, x3
sub	x2, x2, #0x3
adrp	x11, mc_warp_filter+512
add	x11, x11, :lo12:mc_warp_filter+512
mov	x15, x30
lsl	x1, x1, #1
movi	v22.8b, #0x80
movi	v23.8h, #0x8, lsl #8
bl	warp_filter_horz_neon
srshr	v24.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v25.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v26.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v27.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v28.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v29.8h, v0.8h, #0x3
bl	warp_filter_horz_neon
srshr	v30.8h, v0.8h, #0x3
Lmc__7518:
add	w14, w6, #0x200
bl	warp_filter_horz_neon
srshr	v31.8h, v0.8h, #0x3
asr	w13, w14, #10
add	w14, w14, w9
ldr	d0, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d1, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d2, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d3, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d4, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d5, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d6, [x11, w13, sxtw #3]
asr	w13, w14, #10
add	w14, w14, w9
ldr	d7, [x11, w13, sxtw #3]
zip1	v0.16b, v0.16b, v1.16b
zip1	v2.16b, v2.16b, v3.16b
zip1	v4.16b, v4.16b, v5.16b
zip1	v6.16b, v6.16b, v7.16b
trn1	v1.8h, v0.8h, v2.8h
trn2	v3.8h, v0.8h, v2.8h
trn1	v5.8h, v4.8h, v6.8h
trn2	v7.8h, v4.8h, v6.8h
trn1	v0.4s, v1.4s, v5.4s
trn2	v2.4s, v1.4s, v5.4s
trn1	v1.4s, v3.4s, v7.4s
trn2	v3.4s, v3.4s, v7.4s
sshll2	v4.8h, v0.16b, #0x0
sshll	v0.8h, v0.8b, #0x0
sshll2	v6.8h, v2.16b, #0x0
sshll	v2.8h, v2.8b, #0x0
sshll2	v5.8h, v1.16b, #0x0
sshll	v1.8h, v1.8b, #0x0
sshll2	v7.8h, v3.16b, #0x0
sshll	v3.8h, v3.8b, #0x0
smull	v16.4s, v24.4h, v0.4h
smlal	v16.4s, v25.4h, v1.4h
smlal	v16.4s, v26.4h, v2.4h
smlal	v16.4s, v27.4h, v3.4h
smlal	v16.4s, v28.4h, v4.4h
smlal	v16.4s, v29.4h, v5.4h
smlal	v16.4s, v30.4h, v6.4h
smlal	v16.4s, v31.4h, v7.4h
smull2	v17.4s, v24.8h, v0.8h
smlal2	v17.4s, v25.8h, v1.8h
smlal2	v17.4s, v26.8h, v2.8h
smlal2	v17.4s, v27.8h, v3.8h
smlal2	v17.4s, v28.8h, v4.8h
smlal2	v17.4s, v29.8h, v5.8h
smlal2	v17.4s, v30.8h, v6.8h
smlal2	v17.4s, v31.8h, v7.8h
mov	v24.16b, v25.16b
mov	v25.16b, v26.16b
sqrshrn	v16.4h, v16.4s, #0x7
mov	v26.16b, v27.16b
sqrshrn2	v16.8h, v17.4s, #0x7
mov	v27.16b, v28.16b
mov	v28.16b, v29.16b
add	v16.8h, v16.8h, v23.8h
mov	v29.16b, v30.16b
mov	v30.16b, v31.16b
subs	w10, w10, #0x1
st1	{ v16.8h }, [x0], x1
add	w6, w6, w4
b.gt	Lmc__7518
ret	x15
emu_edge_8bpc_neon:
ldp	x8, x9, [sp]
sub	x12, x3, #0x1
cmp	x5, x3
sub	x13, x2, #0x1
csel	x12, x12, x5, ge
cmp	x4, x2
bic	x12, x12, x12, asr #63
csel	x13, x13, x4, ge
bic	x13, x13, x13, asr #63
madd	x8, x12, x9, x8
add	x8, x8, x13
add	x10, x5, x1
neg	x5, x5
sub	x10, x10, x3
sub	x12, x1, #0x1
cmp	x10, x1
bic	x5, x5, x5, asr #63
csel	x10, x10, x12, lt
cmp	x5, x1
bic	x10, x10, x10, asr #63
csel	x5, x5, x12, lt
add	x11, x4, x0
neg	x4, x4
sub	x11, x11, x2
sub	x13, x0, #0x1
cmp	x11, x0
bic	x4, x4, x4, asr #63
csel	x11, x11, x13, lt
cmp	x4, x0
bic	x11, x11, x11, asr #63
csel	x4, x4, x13, lt
sub	x1, x1, x5
madd	x6, x5, x7, x6
sub	x2, x0, x4
sub	x1, x1, x10
sub	x2, x2, x11
mov	x14, x6
cbz	x4, Lmc__7758
cbz	x11, Lmc__77b0
Lmc__76ec:
ld1r	{ v0.16b }, [x8]
mov	x12, x6
mov	x3, x4
Lmc__76f8:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	Lmc__76f8
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
Lmc__7710:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	Lmc__7710
add	x3, x8, x2
sub	x3, x3, #0x1
add	x12, x6, x4
ld1r	{ v0.16b }, [x3]
add	x12, x12, x2
mov	x3, x11
Lmc__7738:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	Lmc__7738
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	Lmc__76ec
b	Lmc__7824
Lmc__7758:
cbz	x11, Lmc__77f8
Lmc__775c:
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
Lmc__7768:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	Lmc__7768
add	x3, x8, x2
sub	x3, x3, #0x1
add	x12, x6, x4
ld1r	{ v0.16b }, [x3]
add	x12, x12, x2
mov	x3, x11
Lmc__7790:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	Lmc__7790
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	Lmc__775c
b	Lmc__7824
Lmc__77b0:
ld1r	{ v0.16b }, [x8]
mov	x12, x6
mov	x3, x4
Lmc__77bc:
subs	x3, x3, #0x10
st1	{ v0.16b }, [x12], #16
b.gt	Lmc__77bc
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
Lmc__77d4:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	Lmc__77d4
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	Lmc__77b0
b	Lmc__7824
Lmc__77f8:
mov	x13, x8
add	x12, x6, x4
mov	x3, x2
Lmc__7804:
ld1	{ v0.16b, v1.16b }, [x13], #32
subs	x3, x3, #0x20
st1	{ v0.16b, v1.16b }, [x12], #32
b.gt	Lmc__7804
subs	x1, x1, #0x1
add	x6, x6, x7
add	x8, x8, x9
b.gt	Lmc__77f8
Lmc__7824:
cbz	x10, Lmc__7854
sub	x8, x6, x7
mov	x4, x0
Lmc__7830:
ld1	{ v0.16b, v1.16b }, [x8], #32
mov	x3, x10
Lmc__7838:
subs	x3, x3, #0x1
st1	{ v0.16b, v1.16b }, [x6], x7
b.gt	Lmc__7838
msub	x6, x7, x10, x6
subs	x4, x4, #0x20
add	x6, x6, #0x20
b.gt	Lmc__7830
Lmc__7854:
cbz	x5, Lmc__7880
msub	x6, x7, x5, x14
Lmc__785c:
ld1	{ v0.16b, v1.16b }, [x14], #32
mov	x3, x5
Lmc__7864:
subs	x3, x3, #0x1
st1	{ v0.16b, v1.16b }, [x6], x7
b.gt	Lmc__7864
msub	x6, x7, x5, x6
subs	x0, x0, #0x20
add	x6, x6, #0x20
b.gt	Lmc__785c
Lmc__7880:
ret
	.section *UND*
	.section .rodata
avg_tbl:
	.size avg_tbl, 24
	.word Lmc__300 - avg_tbl
	.word Lmc__224 - avg_tbl
	.word Lmc__1a8 - avg_tbl
	.word Lmc__12c - avg_tbl
	.word Lmc__d8 - avg_tbl
	.word Lmc__34 - avg_tbl
w_avg_tbl:
	.size w_avg_tbl, 24
	.word Lmc__848 - w_avg_tbl
	.word Lmc__6ec - w_avg_tbl
	.word Lmc__630 - w_avg_tbl
	.word Lmc__574 - w_avg_tbl
	.word Lmc__500 - w_avg_tbl
	.word Lmc__42c - w_avg_tbl
mask_tbl:
	.size mask_tbl, 24
	.word Lmc__f68 - mask_tbl
	.word Lmc__d8c - mask_tbl
	.word Lmc__c90 - mask_tbl
	.word Lmc__b94 - mask_tbl
	.word Lmc__b00 - mask_tbl
	.word Lmc__9fc - mask_tbl
w_mask_444_tbl:
	.size w_mask_444_tbl, 24
	.word Lmc__124c - w_mask_444_tbl
	.word Lmc__124c - w_mask_444_tbl
	.word Lmc__124c - w_mask_444_tbl
	.word Lmc__124c - w_mask_444_tbl
	.word Lmc__11e4 - w_mask_444_tbl
	.word Lmc__1174 - w_mask_444_tbl
w_mask_422_tbl:
	.size w_mask_422_tbl, 24
	.word Lmc__1460 - w_mask_422_tbl
	.word Lmc__1460 - w_mask_422_tbl
	.word Lmc__1460 - w_mask_422_tbl
	.word Lmc__1460 - w_mask_422_tbl
	.word Lmc__13f4 - w_mask_422_tbl
	.word Lmc__1380 - w_mask_422_tbl
w_mask_420_tbl:
	.size w_mask_420_tbl, 24
	.word Lmc__168c - w_mask_420_tbl
	.word Lmc__168c - w_mask_420_tbl
	.word Lmc__168c - w_mask_420_tbl
	.word Lmc__168c - w_mask_420_tbl
	.word Lmc__161c - w_mask_420_tbl
	.word Lmc__159c - w_mask_420_tbl
blend_tbl:
	.size blend_tbl, 16
	.word Lmc__1874 - blend_tbl
	.word Lmc__1818 - blend_tbl
	.word Lmc__17d8 - blend_tbl
	.word Lmc__17a4 - blend_tbl
blend_h_tbl:
	.size blend_h_tbl, 28
	.word Lmc__1a50 - blend_h_tbl
	.word Lmc__1a50 - blend_h_tbl
	.word Lmc__1a50 - blend_h_tbl
	.word Lmc__19f4 - blend_h_tbl
	.word Lmc__19b0 - blend_h_tbl
	.word Lmc__1978 - blend_h_tbl
	.word Lmc__1940 - blend_h_tbl
blend_v_tbl:
	.size blend_v_tbl, 20
	.word Lmc__1c68 - blend_v_tbl
	.word Lmc__1c04 - blend_v_tbl
	.word Lmc__1bb4 - blend_v_tbl
	.word Lmc__1b74 - blend_v_tbl
	.word Lmc__1b38 - blend_v_tbl
put_tbl:
	.size put_tbl, 28
	.word Lmc__1ddc - put_tbl
	.word Lmc__1db8 - put_tbl
	.word Lmc__1d8c - put_tbl
	.word Lmc__1d68 - put_tbl
	.word Lmc__1d44 - put_tbl
	.word Lmc__1d20 - put_tbl
	.word Lmc__1cfc - put_tbl
prep_tbl:
	.size prep_tbl, 24
	.word Lmc__1f94 - prep_tbl
	.word Lmc__1f48 - prep_tbl
	.word Lmc__1ef8 - prep_tbl
	.word Lmc__1ea0 - prep_tbl
	.word Lmc__1e60 - prep_tbl
	.word Lmc__1e28 - prep_tbl
put_8tap_h_tbl:
	.size put_8tap_h_tbl, 28
	.word Lmc__2290 - put_8tap_h_tbl
	.word Lmc__2290 - put_8tap_h_tbl
	.word Lmc__2290 - put_8tap_h_tbl
	.word Lmc__2290 - put_8tap_h_tbl
	.word Lmc__21c0 - put_8tap_h_tbl
	.word Lmc__2130 - put_8tap_h_tbl
	.word Lmc__20c0 - put_8tap_h_tbl
put_8tap_v_tbl:
	.size put_8tap_v_tbl, 28
	.word Lmc__2a38 - put_8tap_v_tbl
	.word Lmc__2a38 - put_8tap_v_tbl
	.word Lmc__2a38 - put_8tap_v_tbl
	.word Lmc__2d2c - put_8tap_v_tbl
	.word Lmc__2974 - put_8tap_v_tbl
	.word Lmc__26a0 - put_8tap_v_tbl
	.word Lmc__2468 - put_8tap_v_tbl
put_8tap_hv_tbl:
	.size put_8tap_hv_tbl, 28
	.word Lmc__3328 - put_8tap_hv_tbl
	.word Lmc__3328 - put_8tap_hv_tbl
	.word Lmc__323c - put_8tap_hv_tbl
	.word Lmc__323c - put_8tap_hv_tbl
	.word Lmc__323c - put_8tap_hv_tbl
	.word Lmc__3028 - put_8tap_hv_tbl
	.word Lmc__2e88 - put_8tap_hv_tbl
put_6tap_h_tbl:
	.size put_6tap_h_tbl, 28
	.word Lmc__37b8 - put_6tap_h_tbl
	.word Lmc__37b8 - put_6tap_h_tbl
	.word Lmc__37b8 - put_6tap_h_tbl
	.word Lmc__37b8 - put_6tap_h_tbl
	.word Lmc__3708 - put_6tap_h_tbl
	.word Lmc__3678 - put_6tap_h_tbl
	.word Lmc__3608 - put_6tap_h_tbl
put_6tap_v_tbl:
	.size put_6tap_v_tbl, 28
	.word Lmc__3ee0 - put_6tap_v_tbl
	.word Lmc__3ee0 - put_6tap_v_tbl
	.word Lmc__3ee0 - put_6tap_v_tbl
	.word Lmc__4174 - put_6tap_v_tbl
	.word Lmc__3e1c - put_6tap_v_tbl
	.word Lmc__3b78 - put_6tap_v_tbl
	.word Lmc__3950 - put_6tap_v_tbl
put_6tap_hv_tbl:
	.size put_6tap_hv_tbl, 28
	.word Lmc__4744 - put_6tap_hv_tbl
	.word Lmc__4744 - put_6tap_hv_tbl
	.word Lmc__4658 - put_6tap_hv_tbl
	.word Lmc__4658 - put_6tap_hv_tbl
	.word Lmc__4658 - put_6tap_hv_tbl
	.word Lmc__4468 - put_6tap_hv_tbl
	.word Lmc__42d0 - put_6tap_hv_tbl
put_bilin_h_tbl:
	.size put_bilin_h_tbl, 28
	.word Lmc__4a4c - put_bilin_h_tbl
	.word Lmc__4a4c - put_bilin_h_tbl
	.word Lmc__4a4c - put_bilin_h_tbl
	.word Lmc__4a4c - put_bilin_h_tbl
	.word Lmc__4a00 - put_bilin_h_tbl
	.word Lmc__49b8 - put_bilin_h_tbl
	.word Lmc__4970 - put_bilin_h_tbl
put_bilin_v_tbl:
	.size put_bilin_v_tbl, 28
	.word Lmc__4c4c - put_bilin_v_tbl
	.word Lmc__4c4c - put_bilin_v_tbl
	.word Lmc__4c4c - put_bilin_v_tbl
	.word Lmc__4c4c - put_bilin_v_tbl
	.word Lmc__4bfc - put_bilin_v_tbl
	.word Lmc__4bb0 - put_bilin_v_tbl
	.word Lmc__4b0c - put_bilin_v_tbl
put_bilin_hv_tbl:
	.size put_bilin_hv_tbl, 28
	.word Lmc__4dd8 - put_bilin_hv_tbl
	.word Lmc__4dd8 - put_bilin_hv_tbl
	.word Lmc__4dd8 - put_bilin_hv_tbl
	.word Lmc__4dd8 - put_bilin_hv_tbl
	.word Lmc__4dd8 - put_bilin_hv_tbl
	.word Lmc__4d6c - put_bilin_hv_tbl
	.word Lmc__4d00 - put_bilin_hv_tbl
prep_8tap_h_tbl:
	.size prep_8tap_h_tbl, 28
	.word Lmc__5074 - prep_8tap_h_tbl
	.word Lmc__5074 - prep_8tap_h_tbl
	.word Lmc__5074 - prep_8tap_h_tbl
	.word Lmc__5074 - prep_8tap_h_tbl
	.word Lmc__4fac - prep_8tap_h_tbl
	.word Lmc__4f2c - prep_8tap_h_tbl
	.word Lmc__4f2c - prep_8tap_h_tbl
prep_8tap_v_tbl:
	.size prep_8tap_v_tbl, 28
	.word Lmc__55cc - prep_8tap_v_tbl
	.word Lmc__55cc - prep_8tap_v_tbl
	.word Lmc__55cc - prep_8tap_v_tbl
	.word Lmc__58c0 - prep_8tap_v_tbl
	.word Lmc__5508 - prep_8tap_v_tbl
	.word Lmc__5234 - prep_8tap_v_tbl
	.word Lmc__5234 - prep_8tap_v_tbl
prep_8tap_hv_tbl:
	.size prep_8tap_hv_tbl, 28
	.word Lmc__5cf4 - prep_8tap_hv_tbl
	.word Lmc__5cf4 - prep_8tap_hv_tbl
	.word Lmc__5c10 - prep_8tap_hv_tbl
	.word Lmc__5c10 - prep_8tap_hv_tbl
	.word Lmc__5c10 - prep_8tap_hv_tbl
	.word Lmc__5a1c - prep_8tap_hv_tbl
	.word Lmc__5a1c - prep_8tap_hv_tbl
prep_6tap_h_tbl:
	.size prep_6tap_h_tbl, 28
	.word Lmc__60fc - prep_6tap_h_tbl
	.word Lmc__60fc - prep_6tap_h_tbl
	.word Lmc__60fc - prep_6tap_h_tbl
	.word Lmc__60fc - prep_6tap_h_tbl
	.word Lmc__6054 - prep_6tap_h_tbl
	.word Lmc__5fd4 - prep_6tap_h_tbl
	.word Lmc__5fd4 - prep_6tap_h_tbl
prep_6tap_v_tbl:
	.size prep_6tap_v_tbl, 28
	.word Lmc__65e4 - prep_6tap_v_tbl
	.word Lmc__65e4 - prep_6tap_v_tbl
	.word Lmc__65e4 - prep_6tap_v_tbl
	.word Lmc__6878 - prep_6tap_v_tbl
	.word Lmc__6520 - prep_6tap_v_tbl
	.word Lmc__627c - prep_6tap_v_tbl
	.word Lmc__627c - prep_6tap_v_tbl
prep_6tap_hv_tbl:
	.size prep_6tap_hv_tbl, 28
	.word Lmc__6c88 - prep_6tap_hv_tbl
	.word Lmc__6c88 - prep_6tap_hv_tbl
	.word Lmc__6ba4 - prep_6tap_hv_tbl
	.word Lmc__6ba4 - prep_6tap_hv_tbl
	.word Lmc__6ba4 - prep_6tap_hv_tbl
	.word Lmc__69d4 - prep_6tap_hv_tbl
	.word Lmc__69d4 - prep_6tap_hv_tbl
prep_bilin_h_tbl:
	.size prep_bilin_h_tbl, 28
	.word Lmc__6f3c - prep_bilin_h_tbl
	.word Lmc__6f3c - prep_bilin_h_tbl
	.word Lmc__6f3c - prep_bilin_h_tbl
	.word Lmc__6f3c - prep_bilin_h_tbl
	.word Lmc__6ef8 - prep_bilin_h_tbl
	.word Lmc__6eb4 - prep_bilin_h_tbl
	.word Lmc__6eb4 - prep_bilin_h_tbl
prep_bilin_v_tbl:
	.size prep_bilin_v_tbl, 28
	.word Lmc__7074 - prep_bilin_v_tbl
	.word Lmc__7074 - prep_bilin_v_tbl
	.word Lmc__7074 - prep_bilin_v_tbl
	.word Lmc__7074 - prep_bilin_v_tbl
	.word Lmc__702c - prep_bilin_v_tbl
	.word Lmc__6fe4 - prep_bilin_v_tbl
	.word Lmc__6fe4 - prep_bilin_v_tbl
prep_bilin_hv_tbl:
	.size prep_bilin_hv_tbl, 28
	.word Lmc__7184 - prep_bilin_hv_tbl
	.word Lmc__7184 - prep_bilin_hv_tbl
	.word Lmc__7184 - prep_bilin_hv_tbl
	.word Lmc__7184 - prep_bilin_hv_tbl
	.word Lmc__7184 - prep_bilin_hv_tbl
	.word Lmc__7118 - prep_bilin_hv_tbl
	.word Lmc__7118 - prep_bilin_hv_tbl

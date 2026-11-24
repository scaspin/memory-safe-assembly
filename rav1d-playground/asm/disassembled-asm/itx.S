	.text
idct_dc_w4_neon:
ld1	{ v0.s }[0], [x0], x1
ld1	{ v0.s }[1], [x0], x1
ld1	{ v1.s }[0], [x0], x1
ld1	{ v1.s }[1], [x0], x1
subs	w4, w4, #0x4
sub	x0, x0, x1, lsl #2
uaddw	v0.8h, v16.8h, v0.8b
sqxtun	v0.8b, v0.8h
uaddw	v1.8h, v16.8h, v1.8b
st1	{ v0.s }[0], [x0], x1
sqxtun	v1.8b, v1.8h
st1	{ v0.s }[1], [x0], x1
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x0], x1
b.gt	idct_dc_w4_neon
ret
idct_dc_w8_neon:
ld1	{ v0.8b }, [x0], x1
ld1	{ v1.8b }, [x0], x1
ld1	{ v2.8b }, [x0], x1
uaddw	v20.8h, v16.8h, v0.8b
ld1	{ v3.8b }, [x0], x1
sub	x0, x0, x1, lsl #2
subs	w4, w4, #0x4
uaddw	v21.8h, v16.8h, v1.8b
sqxtun	v0.8b, v20.8h
uaddw	v22.8h, v16.8h, v2.8b
sqxtun	v1.8b, v21.8h
uaddw	v23.8h, v16.8h, v3.8b
st1	{ v0.8b }, [x0], x1
sqxtun	v2.8b, v22.8h
st1	{ v1.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
b.gt	idct_dc_w8_neon
ret
idct_dc_w16_neon:
ld1	{ v0.16b }, [x0], x1
ld1	{ v1.16b }, [x0], x1
ld1	{ v2.16b }, [x0], x1
subs	w4, w4, #0x4
uaddw	v20.8h, v16.8h, v0.8b
uaddw2	v21.8h, v16.8h, v0.16b
ld1	{ v3.16b }, [x0], x1
uaddw	v22.8h, v16.8h, v1.8b
uaddw2	v23.8h, v16.8h, v1.16b
sub	x0, x0, x1, lsl #2
uaddw	v24.8h, v16.8h, v2.8b
uaddw2	v25.8h, v16.8h, v2.16b
sqxtun	v0.8b, v20.8h
sqxtun2	v0.16b, v21.8h
uaddw	v26.8h, v16.8h, v3.8b
uaddw2	v27.8h, v16.8h, v3.16b
sqxtun	v1.8b, v22.8h
sqxtun2	v1.16b, v23.8h
sqxtun	v2.8b, v24.8h
sqxtun2	v2.16b, v25.8h
st1	{ v0.16b }, [x0], x1
sqxtun	v3.8b, v26.8h
sqxtun2	v3.16b, v27.8h
st1	{ v1.16b }, [x0], x1
st1	{ v2.16b }, [x0], x1
st1	{ v3.16b }, [x0], x1
b.gt	idct_dc_w16_neon
ret
idct_dc_w32_neon:
ld1	{ v0.16b, v1.16b }, [x0], x1
subs	w4, w4, #0x2
uaddw	v20.8h, v16.8h, v0.8b
uaddw2	v21.8h, v16.8h, v0.16b
ld1	{ v2.16b, v3.16b }, [x0]
uaddw	v22.8h, v16.8h, v1.8b
uaddw2	v23.8h, v16.8h, v1.16b
sub	x0, x0, x1
uaddw	v24.8h, v16.8h, v2.8b
uaddw2	v25.8h, v16.8h, v2.16b
sqxtun	v0.8b, v20.8h
sqxtun2	v0.16b, v21.8h
uaddw	v26.8h, v16.8h, v3.8b
uaddw2	v27.8h, v16.8h, v3.16b
sqxtun	v1.8b, v22.8h
sqxtun2	v1.16b, v23.8h
sqxtun	v2.8b, v24.8h
sqxtun2	v2.16b, v25.8h
st1	{ v0.16b, v1.16b }, [x0], x1
sqxtun	v3.8b, v26.8h
sqxtun2	v3.16b, v27.8h
st1	{ v2.16b, v3.16b }, [x0], x1
b.gt	idct_dc_w32_neon
ret
idct_dc_w64_neon:
ld1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0]
subs	w4, w4, #0x1
uaddw	v20.8h, v16.8h, v0.8b
uaddw2	v21.8h, v16.8h, v0.16b
uaddw	v22.8h, v16.8h, v1.8b
uaddw2	v23.8h, v16.8h, v1.16b
uaddw	v24.8h, v16.8h, v2.8b
uaddw2	v25.8h, v16.8h, v2.16b
sqxtun	v0.8b, v20.8h
sqxtun2	v0.16b, v21.8h
uaddw	v26.8h, v16.8h, v3.8b
uaddw2	v27.8h, v16.8h, v3.16b
sqxtun	v1.8b, v22.8h
sqxtun2	v1.16b, v23.8h
sqxtun	v2.8b, v24.8h
sqxtun2	v2.16b, v25.8h
sqxtun	v3.8b, v26.8h
sqxtun2	v3.16b, v27.8h
st1	{ v0.16b, v1.16b, v2.16b, v3.16b }, [x0], x1
b.gt	idct_dc_w64_neon
ret
inv_dct_4h_x4_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.4h }, [x16]
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v19.4h, v0.h[2]
smull	v4.4s, v17.4h, v0.h[2]
smlsl	v4.4s, v19.4h, v0.h[3]
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[0]
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn	v7.4h, v4.4s, #0xc
smull	v4.4s, v16.4h, v0.h[0]
smlsl	v4.4s, v18.4h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn	v3.4h, v4.4s, #0xc
sqadd	v16.4h, v2.4h, v6.4h
sqsub	v19.4h, v2.4h, v6.4h
sqadd	v17.4h, v3.4h, v7.4h
sqsub	v18.4h, v3.4h, v7.4h
ret
inv_dct_8h_x4_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.4h }, [x16]
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v19.4h, v0.h[2]
smull2	v7.4s, v17.8h, v0.h[3]
smlal2	v7.4s, v19.8h, v0.h[2]
smull	v4.4s, v17.4h, v0.h[2]
smlsl	v4.4s, v19.4h, v0.h[3]
smull2	v5.4s, v17.8h, v0.h[2]
smlsl2	v5.4s, v19.8h, v0.h[3]
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v18.4h, v0.h[0]
smull2	v3.4s, v16.8h, v0.h[0]
smlal2	v3.4s, v18.8h, v0.h[0]
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn2	v6.8h, v7.4s, #0xc
sqrshrn	v7.4h, v4.4s, #0xc
sqrshrn2	v7.8h, v5.4s, #0xc
smull	v4.4s, v16.4h, v0.h[0]
smlsl	v4.4s, v18.4h, v0.h[0]
smull2	v5.4s, v16.8h, v0.h[0]
smlsl2	v5.4s, v18.8h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn2	v2.8h, v3.4s, #0xc
sqrshrn	v3.4h, v4.4s, #0xc
sqrshrn2	v3.8h, v5.4s, #0xc
sqadd	v16.8h, v2.8h, v6.8h
sqsub	v19.8h, v2.8h, v6.8h
sqadd	v17.8h, v3.8h, v7.8h
sqsub	v18.8h, v3.8h, v7.8h
ret
inv_adst_4h_x4_neon:
adrp	x16, iadst4_coeffs
add	x16, x16, :lo12:iadst4_coeffs
ld1	{ v0.8h }, [x16]
ssubl	v3.4s, v16.4h, v18.4h
smull	v4.4s, v16.4h, v0.h[0]
smlal	v4.4s, v18.4h, v0.h[1]
smlal	v4.4s, v19.4h, v0.h[2]
smull	v7.4s, v17.4h, v0.h[3]
saddw	v3.4s, v3.4s, v19.4h
smull	v5.4s, v16.4h, v0.h[2]
smlsl	v5.4s, v18.4h, v0.h[0]
smlsl	v5.4s, v19.4h, v0.h[1]
add	v19.4s, v4.4s, v5.4s
mul	v18.4s, v3.4s, v0.s[2]
add	v16.4s, v4.4s, v7.4s
add	v17.4s, v5.4s, v7.4s
sub	v19.4s, v19.4s, v7.4s
sqrshrn	v16.4h, v16.4s, #0xc
sqrshrn	v18.4h, v18.4s, #0xc
sqrshrn	v17.4h, v17.4s, #0xc
sqrshrn	v19.4h, v19.4s, #0xc
ret
inv_flipadst_4h_x4_neon:
adrp	x16, iadst4_coeffs
add	x16, x16, :lo12:iadst4_coeffs
ld1	{ v0.8h }, [x16]
ssubl	v3.4s, v16.4h, v18.4h
smull	v4.4s, v16.4h, v0.h[0]
smlal	v4.4s, v18.4h, v0.h[1]
smlal	v4.4s, v19.4h, v0.h[2]
smull	v7.4s, v17.4h, v0.h[3]
saddw	v3.4s, v3.4s, v19.4h
smull	v5.4s, v16.4h, v0.h[2]
smlsl	v5.4s, v18.4h, v0.h[0]
smlsl	v5.4s, v19.4h, v0.h[1]
add	v16.4s, v4.4s, v5.4s
mul	v17.4s, v3.4s, v0.s[2]
add	v19.4s, v4.4s, v7.4s
add	v18.4s, v5.4s, v7.4s
sub	v16.4s, v16.4s, v7.4s
sqrshrn	v19.4h, v19.4s, #0xc
sqrshrn	v17.4h, v17.4s, #0xc
sqrshrn	v18.4h, v18.4s, #0xc
sqrshrn	v16.4h, v16.4s, #0xc
ret
inv_adst_8h_x4_neon:
adrp	x16, iadst4_coeffs
add	x16, x16, :lo12:iadst4_coeffs
ld1	{ v0.8h }, [x16]
ssubl	v2.4s, v16.4h, v18.4h
ssubl2	v3.4s, v16.8h, v18.8h
smull	v4.4s, v16.4h, v0.h[0]
smlal	v4.4s, v18.4h, v0.h[1]
smlal	v4.4s, v19.4h, v0.h[2]
smull2	v5.4s, v16.8h, v0.h[0]
smlal2	v5.4s, v18.8h, v0.h[1]
smlal2	v5.4s, v19.8h, v0.h[2]
saddw	v2.4s, v2.4s, v19.4h
saddw2	v3.4s, v3.4s, v19.8h
smull	v6.4s, v16.4h, v0.h[2]
smlsl	v6.4s, v18.4h, v0.h[0]
smlsl	v6.4s, v19.4h, v0.h[1]
smull2	v7.4s, v16.8h, v0.h[2]
smlsl2	v7.4s, v18.8h, v0.h[0]
smlsl2	v7.4s, v19.8h, v0.h[1]
mul	v18.4s, v2.4s, v0.s[2]
mul	v19.4s, v3.4s, v0.s[2]
smull	v2.4s, v17.4h, v0.h[3]
smull2	v3.4s, v17.8h, v0.h[3]
add	v16.4s, v4.4s, v2.4s
add	v17.4s, v5.4s, v3.4s
add	v4.4s, v4.4s, v6.4s
add	v5.4s, v5.4s, v7.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
sub	v4.4s, v4.4s, v2.4s
sub	v5.4s, v5.4s, v3.4s
sqrshrn	v18.4h, v18.4s, #0xc
sqrshrn2	v18.8h, v19.4s, #0xc
sqrshrn	v16.4h, v16.4s, #0xc
sqrshrn2	v16.8h, v17.4s, #0xc
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn2	v17.8h, v7.4s, #0xc
sqrshrn	v19.4h, v4.4s, #0xc
sqrshrn2	v19.8h, v5.4s, #0xc
ret
inv_flipadst_8h_x4_neon:
adrp	x16, iadst4_coeffs
add	x16, x16, :lo12:iadst4_coeffs
ld1	{ v0.8h }, [x16]
ssubl	v2.4s, v16.4h, v18.4h
ssubl2	v3.4s, v16.8h, v18.8h
smull	v4.4s, v16.4h, v0.h[0]
smlal	v4.4s, v18.4h, v0.h[1]
smlal	v4.4s, v19.4h, v0.h[2]
smull2	v5.4s, v16.8h, v0.h[0]
smlal2	v5.4s, v18.8h, v0.h[1]
smlal2	v5.4s, v19.8h, v0.h[2]
saddw	v2.4s, v2.4s, v19.4h
saddw2	v3.4s, v3.4s, v19.8h
smull	v6.4s, v16.4h, v0.h[2]
smlsl	v6.4s, v18.4h, v0.h[0]
smlsl	v6.4s, v19.4h, v0.h[1]
smull2	v7.4s, v16.8h, v0.h[2]
smlsl2	v7.4s, v18.8h, v0.h[0]
smlsl2	v7.4s, v19.8h, v0.h[1]
mul	v18.4s, v2.4s, v0.s[2]
mul	v19.4s, v3.4s, v0.s[2]
smull	v2.4s, v17.4h, v0.h[3]
smull2	v3.4s, v17.8h, v0.h[3]
add	v16.4s, v4.4s, v2.4s
add	v17.4s, v5.4s, v3.4s
add	v4.4s, v4.4s, v6.4s
add	v5.4s, v5.4s, v7.4s
add	v6.4s, v6.4s, v2.4s
add	v7.4s, v7.4s, v3.4s
sub	v4.4s, v4.4s, v2.4s
sub	v5.4s, v5.4s, v3.4s
sqrshrn	v18.4h, v18.4s, #0xc
sqrshrn2	v18.8h, v19.4s, #0xc
sqrshrn	v19.4h, v16.4s, #0xc
sqrshrn2	v19.8h, v17.4s, #0xc
mov	v17.16b, v18.16b
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqrshrn	v16.4h, v4.4s, #0xc
sqrshrn2	v16.8h, v5.4s, #0xc
ret
inv_identity_4h_x4_neon:
mov	w16, #0x3508
dup	v0.4h, w16
sqrdmulh	v4.4h, v16.4h, v0.h[0]
sqrdmulh	v5.4h, v17.4h, v0.h[0]
sqrdmulh	v6.4h, v18.4h, v0.h[0]
sqrdmulh	v7.4h, v19.4h, v0.h[0]
sqadd	v16.4h, v16.4h, v4.4h
sqadd	v17.4h, v17.4h, v5.4h
sqadd	v18.4h, v18.4h, v6.4h
sqadd	v19.4h, v19.4h, v7.4h
ret
inv_identity_8h_x4_neon:
mov	w16, #0x3508
dup	v0.4h, w16
sqrdmulh	v4.8h, v16.8h, v0.h[0]
sqrdmulh	v5.8h, v17.8h, v0.h[0]
sqrdmulh	v6.8h, v18.8h, v0.h[0]
sqrdmulh	v7.8h, v19.8h, v0.h[0]
sqadd	v16.8h, v16.8h, v4.8h
sqadd	v17.8h, v17.8h, v5.8h
sqadd	v18.8h, v18.8h, v6.8h
sqadd	v19.8h, v19.8h, v7.8h
ret
inv_txfm_add_wht_wht_4x4_8bpc_neon:
mov	x15, x30
movi	v31.8h, #0x0
ld1	{ v16.4h, v17.4h, v18.4h, v19.4h }, [x2]
st1	{ v31.8h }, [x2], #16
sshr	v16.4h, v16.4h, #0x2
sshr	v17.4h, v17.4h, #0x2
sshr	v18.4h, v18.4h, #0x2
sshr	v19.4h, v19.4h, #0x2
add	v16.4h, v16.4h, v17.4h
sub	v21.4h, v18.4h, v19.4h
sub	v20.4h, v16.4h, v21.4h
sshr	v20.4h, v20.4h, #0x1
sub	v18.4h, v20.4h, v17.4h
sub	v17.4h, v20.4h, v19.4h
add	v19.4h, v21.4h, v18.4h
sub	v16.4h, v16.4h, v17.4h
st1	{ v31.8h }, [x2], #16
trn1	v20.4h, v16.4h, v17.4h
trn2	v21.4h, v16.4h, v17.4h
trn1	v22.4h, v18.4h, v19.4h
trn2	v23.4h, v18.4h, v19.4h
trn1	v16.2s, v20.2s, v22.2s
trn2	v18.2s, v20.2s, v22.2s
trn1	v17.2s, v21.2s, v23.2s
trn2	v19.2s, v21.2s, v23.2s
add	v16.4h, v16.4h, v17.4h
sub	v21.4h, v18.4h, v19.4h
sub	v20.4h, v16.4h, v21.4h
sshr	v20.4h, v20.4h, #0x1
sub	v18.4h, v20.4h, v17.4h
sub	v17.4h, v20.4h, v19.4h
add	v19.4h, v21.4h, v18.4h
sub	v16.4h, v16.4h, v17.4h
ld1	{ v0.s }[0], [x0], x1
ld1	{ v0.s }[1], [x0], x1
mov	v16.d[1], v17.d[0]
mov	v18.d[1], v19.d[0]
ld1	{ v1.s }[0], [x0], x1
ld1	{ v1.s }[1], [x0], x1
b	L_5c8
inv_txfm_add_4x4_neon:
movi	v31.8h, #0x0
ld1	{ v16.4h, v17.4h, v18.4h, v19.4h }, [x2]
st1	{ v31.8h }, [x2], #16
blr	x4
st1	{ v31.8h }, [x2], #16
trn1	v20.4h, v16.4h, v17.4h
trn2	v21.4h, v16.4h, v17.4h
trn1	v22.4h, v18.4h, v19.4h
trn2	v23.4h, v18.4h, v19.4h
trn1	v16.2s, v20.2s, v22.2s
trn2	v18.2s, v20.2s, v22.2s
trn1	v17.2s, v21.2s, v23.2s
trn2	v19.2s, v21.2s, v23.2s
blr	x5
ld1	{ v0.s }[0], [x0], x1
ld1	{ v0.s }[1], [x0], x1
mov	v16.d[1], v17.d[0]
mov	v18.d[1], v19.d[0]
ld1	{ v1.s }[0], [x0], x1
ld1	{ v1.s }[1], [x0], x1
srshr	v16.8h, v16.8h, #0x4
srshr	v18.8h, v18.8h, #0x4
L_5c8:
sub	x0, x0, x1, lsl #2
uaddw	v16.8h, v16.8h, v0.8b
sqxtun	v0.8b, v16.8h
uaddw	v18.8h, v18.8h, v1.8b
st1	{ v0.s }[0], [x0], x1
sqxtun	v1.8b, v18.8h
st1	{ v0.s }[1], [x0], x1
st1	{ v1.s }[0], [x0], x1
st1	{ v1.s }[1], [x0], x1
ret	x15
inv_txfm_add_dct_dct_4x4_8bpc_neon:
mov	x15, x30
cbnz	w3, L_62c
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v4.8h, w16
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v4.h[0]
ld1	{ v0.s }[0], [x0], x1
sqrdmulh	v20.8h, v16.8h, v4.h[0]
ld1	{ v0.s }[1], [x0], x1
srshr	v16.8h, v20.8h, #0x4
ld1	{ v1.s }[0], [x0], x1
srshr	v18.8h, v20.8h, #0x4
ld1	{ v1.s }[1], [x0], x1
b	L_5c8
L_62c:
adr	x4, inv_dct_4h_x4_neon
adr	x5, inv_dct_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_identity_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x4_neon
adr	x5, inv_identity_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_dct_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_4h_x4_neon
adr	x5, inv_adst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_dct_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_4h_x4_neon
adr	x5, inv_flipadst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_dct_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_4h_x4_neon
adr	x5, inv_identity_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_adst_dct_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x4_neon
adr	x5, inv_dct_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_adst_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x4_neon
adr	x5, inv_adst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_adst_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x4_neon
adr	x5, inv_flipadst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_flipadst_dct_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x4_neon
adr	x5, inv_dct_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_flipadst_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x4_neon
adr	x5, inv_adst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_flipadst_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x4_neon
adr	x5, inv_flipadst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_identity_dct_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x4_neon
adr	x5, inv_dct_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_adst_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x4_neon
adr	x5, inv_identity_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_flipadst_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x4_neon
adr	x5, inv_identity_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_identity_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x4_neon
adr	x5, inv_adst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_txfm_add_identity_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x4_neon
adr	x5, inv_flipadst_4h_x4_neon
b	inv_txfm_add_4x4_neon
inv_dct_8h_x8_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.8h }, [x16]
smull	v6.4s, v18.4h, v0.h[3]
smlal	v6.4s, v22.4h, v0.h[2]
smull2	v7.4s, v18.8h, v0.h[3]
smlal2	v7.4s, v22.8h, v0.h[2]
smull	v4.4s, v18.4h, v0.h[2]
smlsl	v4.4s, v22.4h, v0.h[3]
smull2	v5.4s, v18.8h, v0.h[2]
smlsl2	v5.4s, v22.8h, v0.h[3]
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v20.4h, v0.h[0]
smull2	v3.4s, v16.8h, v0.h[0]
smlal2	v3.4s, v20.8h, v0.h[0]
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn2	v6.8h, v7.4s, #0xc
sqrshrn	v7.4h, v4.4s, #0xc
sqrshrn2	v7.8h, v5.4s, #0xc
smull	v4.4s, v16.4h, v0.h[0]
smlsl	v4.4s, v20.4h, v0.h[0]
smull2	v5.4s, v16.8h, v0.h[0]
smlsl2	v5.4s, v20.8h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn2	v2.8h, v3.4s, #0xc
sqrshrn	v3.4h, v4.4s, #0xc
sqrshrn2	v3.8h, v5.4s, #0xc
sqadd	v16.8h, v2.8h, v6.8h
sqsub	v22.8h, v2.8h, v6.8h
sqadd	v18.8h, v3.8h, v7.8h
sqsub	v20.8h, v3.8h, v7.8h
smull	v2.4s, v17.4h, v0.h[4]
smlsl	v2.4s, v23.4h, v0.h[5]
smull2	v3.4s, v17.8h, v0.h[4]
smlsl2	v3.4s, v23.8h, v0.h[5]
smull	v4.4s, v17.4h, v0.h[5]
smlal	v4.4s, v23.4h, v0.h[4]
smull2	v5.4s, v17.8h, v0.h[5]
smlal2	v5.4s, v23.8h, v0.h[4]
smull	v6.4s, v21.4h, v0.h[6]
smlsl	v6.4s, v19.4h, v0.h[7]
smull2	v7.4s, v21.8h, v0.h[6]
smlsl2	v7.4s, v19.8h, v0.h[7]
sqrshrn	v17.4h, v2.4s, #0xc
sqrshrn2	v17.8h, v3.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
sqrshrn2	v23.8h, v5.4s, #0xc
smull	v2.4s, v21.4h, v0.h[7]
smlal	v2.4s, v19.4h, v0.h[6]
smull2	v3.4s, v21.8h, v0.h[7]
smlal2	v3.4s, v19.8h, v0.h[6]
sqrshrn	v19.4h, v6.4s, #0xc
sqrshrn2	v19.8h, v7.4s, #0xc
sqrshrn	v21.4h, v2.4s, #0xc
sqrshrn2	v21.8h, v3.4s, #0xc
sqadd	v2.8h, v17.8h, v19.8h
sqsub	v17.8h, v17.8h, v19.8h
sqadd	v3.8h, v23.8h, v21.8h
sqsub	v19.8h, v23.8h, v21.8h
smull	v4.4s, v19.4h, v0.h[0]
smlsl	v4.4s, v17.4h, v0.h[0]
smull2	v5.4s, v19.8h, v0.h[0]
smlsl2	v5.4s, v17.8h, v0.h[0]
smull	v6.4s, v19.4h, v0.h[0]
smlal	v6.4s, v17.4h, v0.h[0]
smull2	v7.4s, v19.8h, v0.h[0]
smlal2	v7.4s, v17.8h, v0.h[0]
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn2	v4.8h, v5.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqrshrn2	v5.8h, v7.4s, #0xc
sqsub	v23.8h, v16.8h, v3.8h
sqadd	v16.8h, v16.8h, v3.8h
sqadd	v17.8h, v18.8h, v5.8h
sqsub	v6.8h, v18.8h, v5.8h
sqadd	v18.8h, v20.8h, v4.8h
sqsub	v21.8h, v20.8h, v4.8h
sqadd	v19.8h, v22.8h, v2.8h
sqsub	v20.8h, v22.8h, v2.8h
mov	v22.16b, v6.16b
ret
inv_dct_4h_x8_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.8h }, [x16]
smull	v6.4s, v18.4h, v0.h[3]
smlal	v6.4s, v22.4h, v0.h[2]
smull	v4.4s, v18.4h, v0.h[2]
smlsl	v4.4s, v22.4h, v0.h[3]
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v20.4h, v0.h[0]
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn	v7.4h, v4.4s, #0xc
smull	v4.4s, v16.4h, v0.h[0]
smlsl	v4.4s, v20.4h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn	v3.4h, v4.4s, #0xc
sqadd	v16.4h, v2.4h, v6.4h
sqsub	v22.4h, v2.4h, v6.4h
sqadd	v18.4h, v3.4h, v7.4h
sqsub	v20.4h, v3.4h, v7.4h
smull	v2.4s, v17.4h, v0.h[4]
smlsl	v2.4s, v23.4h, v0.h[5]
smull	v4.4s, v17.4h, v0.h[5]
smlal	v4.4s, v23.4h, v0.h[4]
smull	v6.4s, v21.4h, v0.h[6]
smlsl	v6.4s, v19.4h, v0.h[7]
sqrshrn	v17.4h, v2.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
smull	v2.4s, v21.4h, v0.h[7]
smlal	v2.4s, v19.4h, v0.h[6]
sqrshrn	v19.4h, v6.4s, #0xc
sqrshrn	v21.4h, v2.4s, #0xc
sqadd	v2.4h, v17.4h, v19.4h
sqsub	v17.4h, v17.4h, v19.4h
sqadd	v3.4h, v23.4h, v21.4h
sqsub	v19.4h, v23.4h, v21.4h
smull	v4.4s, v19.4h, v0.h[0]
smlsl	v4.4s, v17.4h, v0.h[0]
smull	v6.4s, v19.4h, v0.h[0]
smlal	v6.4s, v17.4h, v0.h[0]
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqsub	v23.4h, v16.4h, v3.4h
sqadd	v16.4h, v16.4h, v3.4h
sqadd	v17.4h, v18.4h, v5.4h
sqsub	v6.4h, v18.4h, v5.4h
sqadd	v18.4h, v20.4h, v4.4h
sqsub	v21.4h, v20.4h, v4.4h
sqadd	v19.4h, v22.4h, v2.4h
sqsub	v20.4h, v22.4h, v2.4h
mov	v22.8b, v6.8b
ret
inv_adst_8h_x8_neon:
adrp	x16, iadst8_coeffs
add	x16, x16, :lo12:iadst8_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
smull	v2.4s, v23.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull2	v3.4s, v23.8h, v0.h[0]
smlal2	v3.4s, v16.8h, v0.h[1]
smull	v4.4s, v23.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull2	v5.4s, v23.8h, v0.h[1]
smlsl2	v5.4s, v16.8h, v0.h[0]
smull	v6.4s, v21.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
smull2	v7.4s, v21.8h, v0.h[2]
smlal2	v7.4s, v18.8h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn2	v16.8h, v3.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
sqrshrn2	v23.8h, v5.4s, #0xc
smull	v2.4s, v21.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull2	v3.4s, v21.8h, v0.h[3]
smlsl2	v3.4s, v18.8h, v0.h[2]
smull	v4.4s, v19.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
smull2	v5.4s, v19.8h, v0.h[4]
smlal2	v5.4s, v20.8h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqrshrn	v21.4h, v2.4s, #0xc
sqrshrn2	v21.8h, v3.4s, #0xc
smull	v6.4s, v19.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull2	v7.4s, v19.8h, v0.h[5]
smlsl2	v7.4s, v20.8h, v0.h[4]
smull	v2.4s, v17.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
smull2	v3.4s, v17.8h, v0.h[6]
smlal2	v3.4s, v22.8h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v19.4h, v6.4s, #0xc
sqrshrn2	v19.8h, v7.4s, #0xc
smull	v4.4s, v17.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull2	v5.4s, v17.8h, v0.h[7]
smlsl2	v5.4s, v22.8h, v0.h[6]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn2	v22.8h, v3.4s, #0xc
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn2	v17.8h, v5.4s, #0xc
sqadd	v2.8h, v16.8h, v20.8h
sqsub	v3.8h, v16.8h, v20.8h
sqadd	v4.8h, v23.8h, v19.8h
sqsub	v5.8h, v23.8h, v19.8h
sqadd	v6.8h, v18.8h, v22.8h
sqsub	v7.8h, v18.8h, v22.8h
sqadd	v18.8h, v21.8h, v17.8h
sqsub	v19.8h, v21.8h, v17.8h
smull	v16.4s, v3.4h, v1.h[3]
smlal	v16.4s, v5.4h, v1.h[2]
smull2	v17.4s, v3.8h, v1.h[3]
smlal2	v17.4s, v5.8h, v1.h[2]
smull	v20.4s, v3.4h, v1.h[2]
smlsl	v20.4s, v5.4h, v1.h[3]
smull2	v21.4s, v3.8h, v1.h[2]
smlsl2	v21.4s, v5.8h, v1.h[3]
smull	v22.4s, v19.4h, v1.h[3]
smlsl	v22.4s, v7.4h, v1.h[2]
smull2	v23.4s, v19.8h, v1.h[3]
smlsl2	v23.4s, v7.8h, v1.h[2]
sqrshrn	v3.4h, v16.4s, #0xc
sqrshrn2	v3.8h, v17.4s, #0xc
sqrshrn	v5.4h, v20.4s, #0xc
sqrshrn2	v5.8h, v21.4s, #0xc
smull	v16.4s, v19.4h, v1.h[2]
smlal	v16.4s, v7.4h, v1.h[3]
smull2	v17.4s, v19.8h, v1.h[2]
smlal2	v17.4s, v7.8h, v1.h[3]
sqrshrn	v7.4h, v22.4s, #0xc
sqrshrn2	v7.8h, v23.4s, #0xc
sqrshrn	v19.4h, v16.4s, #0xc
sqrshrn2	v19.8h, v17.4s, #0xc
sqadd	v16.8h, v2.8h, v6.8h
sqsub	v2.8h, v2.8h, v6.8h
sqadd	v23.8h, v4.8h, v18.8h
sqsub	v4.8h, v4.8h, v18.8h
sqneg	v23.8h, v23.8h
sqadd	v17.8h, v3.8h, v7.8h
sqsub	v3.8h, v3.8h, v7.8h
sqadd	v22.8h, v5.8h, v19.8h
sqsub	v5.8h, v5.8h, v19.8h
sqneg	v17.8h, v17.8h
smull	v18.4s, v2.4h, v1.h[0]
smlal	v18.4s, v4.4h, v1.h[0]
smull2	v19.4s, v2.8h, v1.h[0]
smlal2	v19.4s, v4.8h, v1.h[0]
smull	v6.4s, v2.4h, v1.h[0]
smlsl	v6.4s, v4.4h, v1.h[0]
smull2	v7.4s, v2.8h, v1.h[0]
smlsl2	v7.4s, v4.8h, v1.h[0]
smull	v20.4s, v3.4h, v1.h[0]
smlsl	v20.4s, v5.4h, v1.h[0]
smull2	v21.4s, v3.8h, v1.h[0]
smlsl2	v21.4s, v5.8h, v1.h[0]
sqrshrn	v2.4h, v18.4s, #0xc
sqrshrn2	v2.8h, v19.4s, #0xc
smull	v18.4s, v3.4h, v1.h[0]
smlal	v18.4s, v5.4h, v1.h[0]
smull2	v19.4s, v3.8h, v1.h[0]
smlal2	v19.4s, v5.8h, v1.h[0]
sqrshrn	v3.4h, v20.4s, #0xc
sqrshrn2	v3.8h, v21.4s, #0xc
sqrshrn	v18.4h, v18.4s, #0xc
sqrshrn2	v18.8h, v19.4s, #0xc
sqrshrn	v20.4h, v6.4s, #0xc
sqrshrn2	v20.8h, v7.4s, #0xc
sqneg	v19.8h, v2.8h
sqneg	v21.8h, v3.8h
ret
inv_flipadst_8h_x8_neon:
adrp	x16, iadst8_coeffs
add	x16, x16, :lo12:iadst8_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
smull	v2.4s, v23.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull2	v3.4s, v23.8h, v0.h[0]
smlal2	v3.4s, v16.8h, v0.h[1]
smull	v4.4s, v23.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull2	v5.4s, v23.8h, v0.h[1]
smlsl2	v5.4s, v16.8h, v0.h[0]
smull	v6.4s, v21.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
smull2	v7.4s, v21.8h, v0.h[2]
smlal2	v7.4s, v18.8h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn2	v16.8h, v3.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
sqrshrn2	v23.8h, v5.4s, #0xc
smull	v2.4s, v21.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull2	v3.4s, v21.8h, v0.h[3]
smlsl2	v3.4s, v18.8h, v0.h[2]
smull	v4.4s, v19.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
smull2	v5.4s, v19.8h, v0.h[4]
smlal2	v5.4s, v20.8h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqrshrn	v21.4h, v2.4s, #0xc
sqrshrn2	v21.8h, v3.4s, #0xc
smull	v6.4s, v19.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull2	v7.4s, v19.8h, v0.h[5]
smlsl2	v7.4s, v20.8h, v0.h[4]
smull	v2.4s, v17.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
smull2	v3.4s, v17.8h, v0.h[6]
smlal2	v3.4s, v22.8h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v19.4h, v6.4s, #0xc
sqrshrn2	v19.8h, v7.4s, #0xc
smull	v4.4s, v17.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull2	v5.4s, v17.8h, v0.h[7]
smlsl2	v5.4s, v22.8h, v0.h[6]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn2	v22.8h, v3.4s, #0xc
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn2	v17.8h, v5.4s, #0xc
sqadd	v2.8h, v16.8h, v20.8h
sqsub	v3.8h, v16.8h, v20.8h
sqadd	v4.8h, v23.8h, v19.8h
sqsub	v5.8h, v23.8h, v19.8h
sqadd	v6.8h, v18.8h, v22.8h
sqsub	v7.8h, v18.8h, v22.8h
sqadd	v18.8h, v21.8h, v17.8h
sqsub	v19.8h, v21.8h, v17.8h
smull	v16.4s, v3.4h, v1.h[3]
smlal	v16.4s, v5.4h, v1.h[2]
smull2	v17.4s, v3.8h, v1.h[3]
smlal2	v17.4s, v5.8h, v1.h[2]
smull	v20.4s, v3.4h, v1.h[2]
smlsl	v20.4s, v5.4h, v1.h[3]
smull2	v21.4s, v3.8h, v1.h[2]
smlsl2	v21.4s, v5.8h, v1.h[3]
smull	v22.4s, v19.4h, v1.h[3]
smlsl	v22.4s, v7.4h, v1.h[2]
smull2	v23.4s, v19.8h, v1.h[3]
smlsl2	v23.4s, v7.8h, v1.h[2]
sqrshrn	v3.4h, v16.4s, #0xc
sqrshrn2	v3.8h, v17.4s, #0xc
sqrshrn	v5.4h, v20.4s, #0xc
sqrshrn2	v5.8h, v21.4s, #0xc
smull	v16.4s, v19.4h, v1.h[2]
smlal	v16.4s, v7.4h, v1.h[3]
smull2	v17.4s, v19.8h, v1.h[2]
smlal2	v17.4s, v7.8h, v1.h[3]
sqrshrn	v7.4h, v22.4s, #0xc
sqrshrn2	v7.8h, v23.4s, #0xc
sqrshrn	v19.4h, v16.4s, #0xc
sqrshrn2	v19.8h, v17.4s, #0xc
sqadd	v23.8h, v2.8h, v6.8h
sqsub	v2.8h, v2.8h, v6.8h
sqadd	v16.8h, v4.8h, v18.8h
sqsub	v4.8h, v4.8h, v18.8h
sqneg	v16.8h, v16.8h
sqadd	v22.8h, v3.8h, v7.8h
sqsub	v3.8h, v3.8h, v7.8h
sqadd	v17.8h, v5.8h, v19.8h
sqsub	v5.8h, v5.8h, v19.8h
sqneg	v22.8h, v22.8h
smull	v18.4s, v2.4h, v1.h[0]
smlal	v18.4s, v4.4h, v1.h[0]
smull2	v19.4s, v2.8h, v1.h[0]
smlal2	v19.4s, v4.8h, v1.h[0]
smull	v6.4s, v2.4h, v1.h[0]
smlsl	v6.4s, v4.4h, v1.h[0]
smull2	v7.4s, v2.8h, v1.h[0]
smlsl2	v7.4s, v4.8h, v1.h[0]
smull	v20.4s, v3.4h, v1.h[0]
smlsl	v20.4s, v5.4h, v1.h[0]
smull2	v21.4s, v3.8h, v1.h[0]
smlsl2	v21.4s, v5.8h, v1.h[0]
sqrshrn	v2.4h, v18.4s, #0xc
sqrshrn2	v2.8h, v19.4s, #0xc
smull	v18.4s, v3.4h, v1.h[0]
smlal	v18.4s, v5.4h, v1.h[0]
smull2	v19.4s, v3.8h, v1.h[0]
smlal2	v19.4s, v5.8h, v1.h[0]
sqrshrn	v3.4h, v20.4s, #0xc
sqrshrn2	v3.8h, v21.4s, #0xc
sqrshrn	v21.4h, v18.4s, #0xc
sqrshrn2	v21.8h, v19.4s, #0xc
sqrshrn	v19.4h, v6.4s, #0xc
sqrshrn2	v19.8h, v7.4s, #0xc
sqneg	v20.8h, v2.8h
sqneg	v18.8h, v3.8h
ret
inv_adst_4h_x8_neon:
adrp	x16, iadst8_coeffs
add	x16, x16, :lo12:iadst8_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
smull	v2.4s, v23.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull	v4.4s, v23.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull	v6.4s, v21.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
smull	v2.4s, v21.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull	v4.4s, v19.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn	v21.4h, v2.4s, #0xc
smull	v6.4s, v19.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull	v2.4s, v17.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn	v19.4h, v6.4s, #0xc
smull	v4.4s, v17.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn	v17.4h, v4.4s, #0xc
sqadd	v2.4h, v16.4h, v20.4h
sqsub	v3.4h, v16.4h, v20.4h
sqadd	v4.4h, v23.4h, v19.4h
sqsub	v5.4h, v23.4h, v19.4h
sqadd	v6.4h, v18.4h, v22.4h
sqsub	v7.4h, v18.4h, v22.4h
sqadd	v18.4h, v21.4h, v17.4h
sqsub	v19.4h, v21.4h, v17.4h
smull	v16.4s, v3.4h, v1.h[3]
smlal	v16.4s, v5.4h, v1.h[2]
smull	v20.4s, v3.4h, v1.h[2]
smlsl	v20.4s, v5.4h, v1.h[3]
smull	v22.4s, v19.4h, v1.h[3]
smlsl	v22.4s, v7.4h, v1.h[2]
sqrshrn	v3.4h, v16.4s, #0xc
sqrshrn	v5.4h, v20.4s, #0xc
smull	v16.4s, v19.4h, v1.h[2]
smlal	v16.4s, v7.4h, v1.h[3]
sqrshrn	v7.4h, v22.4s, #0xc
sqrshrn	v19.4h, v16.4s, #0xc
sqadd	v16.4h, v2.4h, v6.4h
sqsub	v2.4h, v2.4h, v6.4h
sqadd	v23.4h, v4.4h, v18.4h
sqsub	v4.4h, v4.4h, v18.4h
sqneg	v23.4h, v23.4h
sqadd	v17.4h, v3.4h, v7.4h
sqsub	v3.4h, v3.4h, v7.4h
sqadd	v22.4h, v5.4h, v19.4h
sqsub	v5.4h, v5.4h, v19.4h
sqneg	v17.4h, v17.4h
smull	v18.4s, v2.4h, v1.h[0]
smlal	v18.4s, v4.4h, v1.h[0]
smull	v6.4s, v2.4h, v1.h[0]
smlsl	v6.4s, v4.4h, v1.h[0]
smull	v20.4s, v3.4h, v1.h[0]
smlsl	v20.4s, v5.4h, v1.h[0]
sqrshrn	v2.4h, v18.4s, #0xc
smull	v18.4s, v3.4h, v1.h[0]
smlal	v18.4s, v5.4h, v1.h[0]
sqrshrn	v3.4h, v20.4s, #0xc
sqrshrn	v18.4h, v18.4s, #0xc
sqrshrn	v20.4h, v6.4s, #0xc
sqneg	v19.4h, v2.4h
sqneg	v21.4h, v3.4h
ret
inv_flipadst_4h_x8_neon:
adrp	x16, iadst8_coeffs
add	x16, x16, :lo12:iadst8_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
smull	v2.4s, v23.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull	v4.4s, v23.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull	v6.4s, v21.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
smull	v2.4s, v21.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull	v4.4s, v19.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn	v21.4h, v2.4s, #0xc
smull	v6.4s, v19.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull	v2.4s, v17.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn	v19.4h, v6.4s, #0xc
smull	v4.4s, v17.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn	v17.4h, v4.4s, #0xc
sqadd	v2.4h, v16.4h, v20.4h
sqsub	v3.4h, v16.4h, v20.4h
sqadd	v4.4h, v23.4h, v19.4h
sqsub	v5.4h, v23.4h, v19.4h
sqadd	v6.4h, v18.4h, v22.4h
sqsub	v7.4h, v18.4h, v22.4h
sqadd	v18.4h, v21.4h, v17.4h
sqsub	v19.4h, v21.4h, v17.4h
smull	v16.4s, v3.4h, v1.h[3]
smlal	v16.4s, v5.4h, v1.h[2]
smull	v20.4s, v3.4h, v1.h[2]
smlsl	v20.4s, v5.4h, v1.h[3]
smull	v22.4s, v19.4h, v1.h[3]
smlsl	v22.4s, v7.4h, v1.h[2]
sqrshrn	v3.4h, v16.4s, #0xc
sqrshrn	v5.4h, v20.4s, #0xc
smull	v16.4s, v19.4h, v1.h[2]
smlal	v16.4s, v7.4h, v1.h[3]
sqrshrn	v7.4h, v22.4s, #0xc
sqrshrn	v19.4h, v16.4s, #0xc
sqadd	v23.4h, v2.4h, v6.4h
sqsub	v2.4h, v2.4h, v6.4h
sqadd	v16.4h, v4.4h, v18.4h
sqsub	v4.4h, v4.4h, v18.4h
sqneg	v16.4h, v16.4h
sqadd	v22.4h, v3.4h, v7.4h
sqsub	v3.4h, v3.4h, v7.4h
sqadd	v17.4h, v5.4h, v19.4h
sqsub	v5.4h, v5.4h, v19.4h
sqneg	v22.4h, v22.4h
smull	v18.4s, v2.4h, v1.h[0]
smlal	v18.4s, v4.4h, v1.h[0]
smull	v6.4s, v2.4h, v1.h[0]
smlsl	v6.4s, v4.4h, v1.h[0]
smull	v20.4s, v3.4h, v1.h[0]
smlsl	v20.4s, v5.4h, v1.h[0]
sqrshrn	v2.4h, v18.4s, #0xc
smull	v18.4s, v3.4h, v1.h[0]
smlal	v18.4s, v5.4h, v1.h[0]
sqrshrn	v3.4h, v20.4s, #0xc
sqrshrn	v21.4h, v18.4s, #0xc
sqrshrn	v19.4h, v6.4s, #0xc
sqneg	v20.4h, v2.4h
sqneg	v18.4h, v3.4h
ret
inv_identity_8h_x8_neon:
sqshl	v16.8h, v16.8h, #0x1
sqshl	v17.8h, v17.8h, #0x1
sqshl	v18.8h, v18.8h, #0x1
sqshl	v19.8h, v19.8h, #0x1
sqshl	v20.8h, v20.8h, #0x1
sqshl	v21.8h, v21.8h, #0x1
sqshl	v22.8h, v22.8h, #0x1
sqshl	v23.8h, v23.8h, #0x1
ret
inv_identity_4h_x8_neon:
sqshl	v16.4h, v16.4h, #0x1
sqshl	v17.4h, v17.4h, #0x1
sqshl	v18.4h, v18.4h, #0x1
sqshl	v19.4h, v19.4h, #0x1
sqshl	v20.4h, v20.4h, #0x1
sqshl	v21.4h, v21.4h, #0x1
sqshl	v22.4h, v22.4h, #0x1
sqshl	v23.4h, v23.4h, #0x1
ret
inv_txfm_identity_add_8x8_neon:
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x2]
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x2], #64
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x2]
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x2]
b	L_fe8
inv_txfm_add_8x8_neon:
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x2]
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x2], #64
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x2]
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x2]
blr	x4
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
srshr	v20.8h, v20.8h, #0x1
srshr	v21.8h, v21.8h, #0x1
srshr	v22.8h, v22.8h, #0x1
srshr	v23.8h, v23.8h, #0x1
L_fe8:
trn1	v24.8h, v16.8h, v17.8h
trn2	v25.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v25.4s, v19.4s
trn2	v25.4s, v25.4s, v19.4s
trn1	v19.4s, v24.4s, v17.4s
trn2	v24.4s, v24.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v24.2d, v18.2d
trn1	v18.2d, v24.2d, v18.2d
trn1	v19.2d, v25.2d, v23.2d
trn2	v23.2d, v25.2d, v23.2d
blr	x5
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
ret	x15
inv_txfm_add_dct_dct_8x8_8bpc_neon:
mov	x15, x30
cbnz	w3, L_1124
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x8
b	idct_dc_w8_neon
L_1124:
adr	x5, inv_dct_8h_x8_neon
adr	x4, inv_dct_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_identity_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_identity_8h_x8_neon
b	inv_txfm_identity_add_8x8_neon
inv_txfm_add_dct_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_adst_8h_x8_neon
adr	x4, inv_dct_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_dct_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_flipadst_8h_x8_neon
adr	x4, inv_dct_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_dct_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_identity_8h_x8_neon
adr	x4, inv_dct_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_adst_dct_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_dct_8h_x8_neon
adr	x4, inv_adst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_adst_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_adst_8h_x8_neon
adr	x4, inv_adst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_adst_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_flipadst_8h_x8_neon
adr	x4, inv_adst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_flipadst_dct_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_dct_8h_x8_neon
adr	x4, inv_flipadst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_flipadst_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_adst_8h_x8_neon
adr	x4, inv_flipadst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_flipadst_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_flipadst_8h_x8_neon
adr	x4, inv_flipadst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_identity_dct_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_dct_8h_x8_neon
b	inv_txfm_identity_add_8x8_neon
inv_txfm_add_adst_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_identity_8h_x8_neon
adr	x4, inv_adst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_flipadst_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_identity_8h_x8_neon
adr	x4, inv_flipadst_8h_x8_neon
b	inv_txfm_add_8x8_neon
inv_txfm_add_identity_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_adst_8h_x8_neon
b	inv_txfm_identity_add_8x8_neon
inv_txfm_add_identity_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, inv_flipadst_8h_x8_neon
b	inv_txfm_identity_add_8x8_neon
inv_txfm_add_8x4_neon:
movi	v30.8h, #0x0
movi	v31.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.4h, v17.4h, v18.4h, v19.4h }, [x2]
st1	{ v30.8h, v31.8h }, [x2], #32
ld1	{ v20.4h, v21.4h, v22.4h, v23.4h }, [x2]
st1	{ v30.8h, v31.8h }, [x2]
sqrdmulh	v16.4h, v16.4h, v0.h[0]
sqrdmulh	v17.4h, v17.4h, v0.h[0]
sqrdmulh	v18.4h, v18.4h, v0.h[0]
sqrdmulh	v19.4h, v19.4h, v0.h[0]
sqrdmulh	v20.4h, v20.4h, v0.h[0]
sqrdmulh	v21.4h, v21.4h, v0.h[0]
sqrdmulh	v22.4h, v22.4h, v0.h[0]
sqrdmulh	v23.4h, v23.4h, v0.h[0]
blr	x4
trn1	v4.4h, v16.4h, v17.4h
trn2	v5.4h, v16.4h, v17.4h
trn1	v6.4h, v18.4h, v19.4h
trn2	v7.4h, v18.4h, v19.4h
trn1	v16.2s, v4.2s, v6.2s
trn2	v18.2s, v4.2s, v6.2s
trn1	v17.2s, v5.2s, v7.2s
trn2	v19.2s, v5.2s, v7.2s
trn1	v4.4h, v20.4h, v21.4h
trn2	v5.4h, v20.4h, v21.4h
trn1	v6.4h, v22.4h, v23.4h
trn2	v7.4h, v22.4h, v23.4h
trn1	v20.2s, v4.2s, v6.2s
trn2	v22.2s, v4.2s, v6.2s
trn1	v21.2s, v5.2s, v7.2s
trn2	v23.2s, v5.2s, v7.2s
mov	v16.d[1], v20.d[0]
mov	v17.d[1], v21.d[0]
mov	v18.d[1], v22.d[0]
mov	v19.d[1], v23.d[0]
blr	x5
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x0], x1
ret	x15
inv_txfm_add_4x8_neon:
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x2]
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
blr	x4
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v6.8h, v18.8h, v19.8h
trn2	v7.8h, v18.8h, v19.8h
trn1	v16.4s, v4.4s, v6.4s
trn2	v18.4s, v4.4s, v6.4s
trn1	v17.4s, v5.4s, v7.4s
trn2	v19.4s, v5.4s, v7.4s
mov	v20.d[0], v16.d[1]
mov	v21.d[0], v17.d[1]
mov	v22.d[0], v18.d[1]
mov	v23.d[0], v19.d[1]
blr	x5
mov	x7, x0
ld1	{ v0.s }[0], [x7], x1
mov	v16.d[1], v17.d[0]
ld1	{ v0.s }[1], [x7], x1
ld1	{ v1.s }[0], [x7], x1
mov	v18.d[1], v19.d[0]
ld1	{ v1.s }[1], [x7], x1
ld1	{ v2.s }[0], [x7], x1
mov	v20.d[1], v21.d[0]
srshr	v16.8h, v16.8h, #0x4
ld1	{ v2.s }[1], [x7], x1
ld1	{ v3.s }[0], [x7], x1
mov	v22.d[1], v23.d[0]
srshr	v18.8h, v18.8h, #0x4
ld1	{ v3.s }[1], [x7], x1
uaddw	v16.8h, v16.8h, v0.8b
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v1.8b
sqxtun	v0.8b, v16.8h
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v2.8b
st1	{ v0.s }[0], [x0], x1
sqxtun	v1.8b, v18.8h
st1	{ v0.s }[1], [x0], x1
uaddw	v22.8h, v22.8h, v3.8b
st1	{ v1.s }[0], [x0], x1
sqxtun	v2.8b, v20.8h
st1	{ v1.s }[1], [x0], x1
st1	{ v2.s }[0], [x0], x1
sqxtun	v3.8b, v22.8h
st1	{ v2.s }[1], [x0], x1
st1	{ v3.s }[0], [x0], x1
st1	{ v3.s }[1], [x0], x1
ret	x15
inv_txfm_add_dct_dct_4x8_8bpc_neon:
mov	x15, x30
cbnz	w3, L_1420
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x8
b	idct_dc_w4_neon
L_1420:
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_dct_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_identity_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_8h_x4_neon
adr	x5, inv_identity_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_dct_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_adst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_dct_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_flipadst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_dct_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_identity_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_adst_dct_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_dct_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_adst_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_adst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_adst_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_flipadst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_flipadst_dct_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_dct_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_flipadst_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_adst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_flipadst_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_flipadst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_identity_dct_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_8h_x4_neon
adr	x5, inv_dct_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_adst_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_identity_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_flipadst_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_identity_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_identity_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_8h_x4_neon
adr	x5, inv_adst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_identity_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_8h_x4_neon
adr	x5, inv_flipadst_4h_x8_neon
b	inv_txfm_add_4x8_neon
inv_txfm_add_dct_dct_8x4_8bpc_neon:
mov	x15, x30
cbnz	w3, L_154c
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x4
b	idct_dc_w8_neon
L_154c:
adr	x4, inv_dct_4h_x8_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_identity_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x8_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_dct_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_4h_x8_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_dct_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_4h_x8_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_dct_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_dct_4h_x8_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_adst_dct_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x8_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_adst_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x8_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_adst_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x8_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_flipadst_dct_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x8_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_flipadst_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x8_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_flipadst_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x8_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_identity_dct_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x8_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_adst_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_adst_4h_x8_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_flipadst_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_flipadst_4h_x8_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_identity_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x8_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_txfm_add_identity_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, inv_identity_4h_x8_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_8x4_neon
inv_dct_8h_x16_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
smull	v6.4s, v20.4h, v0.h[3]
smlal	v6.4s, v28.4h, v0.h[2]
smull2	v7.4s, v20.8h, v0.h[3]
smlal2	v7.4s, v28.8h, v0.h[2]
smull	v4.4s, v20.4h, v0.h[2]
smlsl	v4.4s, v28.4h, v0.h[3]
smull2	v5.4s, v20.8h, v0.h[2]
smlsl2	v5.4s, v28.8h, v0.h[3]
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v24.4h, v0.h[0]
smull2	v3.4s, v16.8h, v0.h[0]
smlal2	v3.4s, v24.8h, v0.h[0]
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn2	v6.8h, v7.4s, #0xc
sqrshrn	v7.4h, v4.4s, #0xc
sqrshrn2	v7.8h, v5.4s, #0xc
smull	v4.4s, v16.4h, v0.h[0]
smlsl	v4.4s, v24.4h, v0.h[0]
smull2	v5.4s, v16.8h, v0.h[0]
smlsl2	v5.4s, v24.8h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn2	v2.8h, v3.4s, #0xc
sqrshrn	v3.4h, v4.4s, #0xc
sqrshrn2	v3.8h, v5.4s, #0xc
sqadd	v16.8h, v2.8h, v6.8h
sqsub	v28.8h, v2.8h, v6.8h
sqadd	v20.8h, v3.8h, v7.8h
sqsub	v24.8h, v3.8h, v7.8h
smull	v2.4s, v18.4h, v0.h[4]
smlsl	v2.4s, v30.4h, v0.h[5]
smull2	v3.4s, v18.8h, v0.h[4]
smlsl2	v3.4s, v30.8h, v0.h[5]
smull	v4.4s, v18.4h, v0.h[5]
smlal	v4.4s, v30.4h, v0.h[4]
smull2	v5.4s, v18.8h, v0.h[5]
smlal2	v5.4s, v30.8h, v0.h[4]
smull	v6.4s, v26.4h, v0.h[6]
smlsl	v6.4s, v22.4h, v0.h[7]
smull2	v7.4s, v26.8h, v0.h[6]
smlsl2	v7.4s, v22.8h, v0.h[7]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn2	v18.8h, v3.4s, #0xc
sqrshrn	v30.4h, v4.4s, #0xc
sqrshrn2	v30.8h, v5.4s, #0xc
smull	v2.4s, v26.4h, v0.h[7]
smlal	v2.4s, v22.4h, v0.h[6]
smull2	v3.4s, v26.8h, v0.h[7]
smlal2	v3.4s, v22.8h, v0.h[6]
sqrshrn	v22.4h, v6.4s, #0xc
sqrshrn2	v22.8h, v7.4s, #0xc
sqrshrn	v26.4h, v2.4s, #0xc
sqrshrn2	v26.8h, v3.4s, #0xc
sqadd	v2.8h, v18.8h, v22.8h
sqsub	v18.8h, v18.8h, v22.8h
sqadd	v3.8h, v30.8h, v26.8h
sqsub	v22.8h, v30.8h, v26.8h
smull	v4.4s, v22.4h, v0.h[0]
smlsl	v4.4s, v18.4h, v0.h[0]
smull2	v5.4s, v22.8h, v0.h[0]
smlsl2	v5.4s, v18.8h, v0.h[0]
smull	v6.4s, v22.4h, v0.h[0]
smlal	v6.4s, v18.4h, v0.h[0]
smull2	v7.4s, v22.8h, v0.h[0]
smlal2	v7.4s, v18.8h, v0.h[0]
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn2	v4.8h, v5.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqrshrn2	v5.8h, v7.4s, #0xc
sqsub	v30.8h, v16.8h, v3.8h
sqadd	v16.8h, v16.8h, v3.8h
sqadd	v18.8h, v20.8h, v5.8h
sqsub	v6.8h, v20.8h, v5.8h
sqadd	v20.8h, v24.8h, v4.8h
sqsub	v26.8h, v24.8h, v4.8h
sqadd	v22.8h, v28.8h, v2.8h
sqsub	v24.8h, v28.8h, v2.8h
mov	v28.16b, v6.16b
smull	v2.4s, v17.4h, v1.h[0]
smlsl	v2.4s, v31.4h, v1.h[1]
smull2	v3.4s, v17.8h, v1.h[0]
smlsl2	v3.4s, v31.8h, v1.h[1]
smull	v4.4s, v17.4h, v1.h[1]
smlal	v4.4s, v31.4h, v1.h[0]
smull2	v5.4s, v17.8h, v1.h[1]
smlal2	v5.4s, v31.8h, v1.h[0]
smull	v6.4s, v25.4h, v1.h[2]
smlsl	v6.4s, v23.4h, v1.h[3]
smull2	v7.4s, v25.8h, v1.h[2]
smlsl2	v7.4s, v23.8h, v1.h[3]
sqrshrn	v17.4h, v2.4s, #0xc
sqrshrn2	v17.8h, v3.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
sqrshrn2	v31.8h, v5.4s, #0xc
smull	v2.4s, v25.4h, v1.h[3]
smlal	v2.4s, v23.4h, v1.h[2]
smull2	v3.4s, v25.8h, v1.h[3]
smlal2	v3.4s, v23.8h, v1.h[2]
smull	v4.4s, v21.4h, v1.h[4]
smlsl	v4.4s, v27.4h, v1.h[5]
smull2	v5.4s, v21.8h, v1.h[4]
smlsl2	v5.4s, v27.8h, v1.h[5]
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn2	v23.8h, v7.4s, #0xc
sqrshrn	v25.4h, v2.4s, #0xc
sqrshrn2	v25.8h, v3.4s, #0xc
smull	v6.4s, v21.4h, v1.h[5]
smlal	v6.4s, v27.4h, v1.h[4]
smull2	v7.4s, v21.8h, v1.h[5]
smlal2	v7.4s, v27.8h, v1.h[4]
smull	v2.4s, v29.4h, v1.h[6]
smlsl	v2.4s, v19.4h, v1.h[7]
smull2	v3.4s, v29.8h, v1.h[6]
smlsl2	v3.4s, v19.8h, v1.h[7]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn2	v21.8h, v5.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
smull	v4.4s, v29.4h, v1.h[7]
smlal	v4.4s, v19.4h, v1.h[6]
smull2	v5.4s, v29.8h, v1.h[7]
smlal2	v5.4s, v19.8h, v1.h[6]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn2	v19.8h, v3.4s, #0xc
sqrshrn	v29.4h, v4.4s, #0xc
sqrshrn2	v29.8h, v5.4s, #0xc
sqsub	v2.8h, v17.8h, v23.8h
sqadd	v17.8h, v17.8h, v23.8h
sqsub	v3.8h, v31.8h, v25.8h
sqadd	v31.8h, v31.8h, v25.8h
sqsub	v23.8h, v19.8h, v21.8h
sqadd	v19.8h, v19.8h, v21.8h
sqadd	v25.8h, v29.8h, v27.8h
sqsub	v29.8h, v29.8h, v27.8h
smull	v4.4s, v3.4h, v0.h[2]
smlsl	v4.4s, v2.4h, v0.h[3]
smull2	v5.4s, v3.8h, v0.h[2]
smlsl2	v5.4s, v2.8h, v0.h[3]
smull	v6.4s, v3.4h, v0.h[3]
smlal	v6.4s, v2.4h, v0.h[2]
smull2	v7.4s, v3.8h, v0.h[3]
smlal2	v7.4s, v2.8h, v0.h[2]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn2	v21.8h, v5.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
smull	v4.4s, v29.4h, v0.h[2]
smlsl	v4.4s, v23.4h, v0.h[3]
smull2	v5.4s, v29.8h, v0.h[2]
smlsl2	v5.4s, v23.8h, v0.h[3]
smull	v6.4s, v29.4h, v0.h[3]
smlal	v6.4s, v23.4h, v0.h[2]
smull2	v7.4s, v29.8h, v0.h[3]
smlal2	v7.4s, v23.8h, v0.h[2]
sqrshrn	v29.4h, v4.4s, #0xc
sqrshrn2	v29.8h, v5.4s, #0xc
neg	v6.4s, v6.4s
neg	v7.4s, v7.4s
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn2	v23.8h, v7.4s, #0xc
sqsub	v2.8h, v17.8h, v19.8h
sqadd	v17.8h, v17.8h, v19.8h
sqsub	v3.8h, v31.8h, v25.8h
sqadd	v31.8h, v31.8h, v25.8h
sqadd	v19.8h, v21.8h, v23.8h
sqsub	v21.8h, v21.8h, v23.8h
sqsub	v25.8h, v27.8h, v29.8h
sqadd	v27.8h, v27.8h, v29.8h
smull	v4.4s, v3.4h, v0.h[0]
smlsl	v4.4s, v2.4h, v0.h[0]
smull2	v5.4s, v3.8h, v0.h[0]
smlsl2	v5.4s, v2.8h, v0.h[0]
smull	v6.4s, v3.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[0]
smull2	v7.4s, v3.8h, v0.h[0]
smlal2	v7.4s, v2.8h, v0.h[0]
smull	v2.4s, v25.4h, v0.h[0]
smlsl	v2.4s, v21.4h, v0.h[0]
smull2	v3.4s, v25.8h, v0.h[0]
smlsl2	v3.4s, v21.8h, v0.h[0]
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn2	v4.8h, v5.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqrshrn2	v5.8h, v7.4s, #0xc
smull	v6.4s, v25.4h, v0.h[0]
smlal	v6.4s, v21.4h, v0.h[0]
smull2	v7.4s, v25.8h, v0.h[0]
smlal2	v7.4s, v21.8h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn2	v2.8h, v3.4s, #0xc
sqrshrn	v3.4h, v6.4s, #0xc
sqrshrn2	v3.8h, v7.4s, #0xc
sqadd	v6.8h, v16.8h, v31.8h
sqsub	v31.8h, v16.8h, v31.8h
mov	v16.16b, v6.16b
sqadd	v23.8h, v30.8h, v17.8h
sqsub	v7.8h, v30.8h, v17.8h
sqadd	v17.8h, v18.8h, v27.8h
sqsub	v30.8h, v18.8h, v27.8h
sqadd	v18.8h, v20.8h, v3.8h
sqsub	v29.8h, v20.8h, v3.8h
sqadd	v3.8h, v28.8h, v19.8h
sqsub	v25.8h, v28.8h, v19.8h
sqadd	v19.8h, v22.8h, v5.8h
sqsub	v28.8h, v22.8h, v5.8h
sqadd	v20.8h, v24.8h, v4.8h
sqsub	v27.8h, v24.8h, v4.8h
sqadd	v21.8h, v26.8h, v2.8h
sqsub	v26.8h, v26.8h, v2.8h
mov	v24.16b, v7.16b
mov	v22.16b, v3.16b
ret
inv_dct_4h_x16_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
smull	v6.4s, v20.4h, v0.h[3]
smlal	v6.4s, v28.4h, v0.h[2]
smull	v4.4s, v20.4h, v0.h[2]
smlsl	v4.4s, v28.4h, v0.h[3]
smull	v2.4s, v16.4h, v0.h[0]
smlal	v2.4s, v24.4h, v0.h[0]
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn	v7.4h, v4.4s, #0xc
smull	v4.4s, v16.4h, v0.h[0]
smlsl	v4.4s, v24.4h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn	v3.4h, v4.4s, #0xc
sqadd	v16.4h, v2.4h, v6.4h
sqsub	v28.4h, v2.4h, v6.4h
sqadd	v20.4h, v3.4h, v7.4h
sqsub	v24.4h, v3.4h, v7.4h
smull	v2.4s, v18.4h, v0.h[4]
smlsl	v2.4s, v30.4h, v0.h[5]
smull	v4.4s, v18.4h, v0.h[5]
smlal	v4.4s, v30.4h, v0.h[4]
smull	v6.4s, v26.4h, v0.h[6]
smlsl	v6.4s, v22.4h, v0.h[7]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn	v30.4h, v4.4s, #0xc
smull	v2.4s, v26.4h, v0.h[7]
smlal	v2.4s, v22.4h, v0.h[6]
sqrshrn	v22.4h, v6.4s, #0xc
sqrshrn	v26.4h, v2.4s, #0xc
sqadd	v2.4h, v18.4h, v22.4h
sqsub	v18.4h, v18.4h, v22.4h
sqadd	v3.4h, v30.4h, v26.4h
sqsub	v22.4h, v30.4h, v26.4h
smull	v4.4s, v22.4h, v0.h[0]
smlsl	v4.4s, v18.4h, v0.h[0]
smull	v6.4s, v22.4h, v0.h[0]
smlal	v6.4s, v18.4h, v0.h[0]
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqsub	v30.4h, v16.4h, v3.4h
sqadd	v16.4h, v16.4h, v3.4h
sqadd	v18.4h, v20.4h, v5.4h
sqsub	v6.4h, v20.4h, v5.4h
sqadd	v20.4h, v24.4h, v4.4h
sqsub	v26.4h, v24.4h, v4.4h
sqadd	v22.4h, v28.4h, v2.4h
sqsub	v24.4h, v28.4h, v2.4h
mov	v28.8b, v6.8b
smull	v2.4s, v17.4h, v1.h[0]
smlsl	v2.4s, v31.4h, v1.h[1]
smull	v4.4s, v17.4h, v1.h[1]
smlal	v4.4s, v31.4h, v1.h[0]
smull	v6.4s, v25.4h, v1.h[2]
smlsl	v6.4s, v23.4h, v1.h[3]
sqrshrn	v17.4h, v2.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
smull	v2.4s, v25.4h, v1.h[3]
smlal	v2.4s, v23.4h, v1.h[2]
smull	v4.4s, v21.4h, v1.h[4]
smlsl	v4.4s, v27.4h, v1.h[5]
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn	v25.4h, v2.4s, #0xc
smull	v6.4s, v21.4h, v1.h[5]
smlal	v6.4s, v27.4h, v1.h[4]
smull	v2.4s, v29.4h, v1.h[6]
smlsl	v2.4s, v19.4h, v1.h[7]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
smull	v4.4s, v29.4h, v1.h[7]
smlal	v4.4s, v19.4h, v1.h[6]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn	v29.4h, v4.4s, #0xc
sqsub	v2.4h, v17.4h, v23.4h
sqadd	v17.4h, v17.4h, v23.4h
sqsub	v3.4h, v31.4h, v25.4h
sqadd	v31.4h, v31.4h, v25.4h
sqsub	v23.4h, v19.4h, v21.4h
sqadd	v19.4h, v19.4h, v21.4h
sqadd	v25.4h, v29.4h, v27.4h
sqsub	v29.4h, v29.4h, v27.4h
smull	v4.4s, v3.4h, v0.h[2]
smlsl	v4.4s, v2.4h, v0.h[3]
smull	v6.4s, v3.4h, v0.h[3]
smlal	v6.4s, v2.4h, v0.h[2]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
smull	v4.4s, v29.4h, v0.h[2]
smlsl	v4.4s, v23.4h, v0.h[3]
smull	v6.4s, v29.4h, v0.h[3]
smlal	v6.4s, v23.4h, v0.h[2]
sqrshrn	v29.4h, v4.4s, #0xc
neg	v6.4s, v6.4s
sqrshrn	v23.4h, v6.4s, #0xc
sqsub	v2.4h, v17.4h, v19.4h
sqadd	v17.4h, v17.4h, v19.4h
sqsub	v3.4h, v31.4h, v25.4h
sqadd	v31.4h, v31.4h, v25.4h
sqadd	v19.4h, v21.4h, v23.4h
sqsub	v21.4h, v21.4h, v23.4h
sqsub	v25.4h, v27.4h, v29.4h
sqadd	v27.4h, v27.4h, v29.4h
smull	v4.4s, v3.4h, v0.h[0]
smlsl	v4.4s, v2.4h, v0.h[0]
smull	v6.4s, v3.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[0]
smull	v2.4s, v25.4h, v0.h[0]
smlsl	v2.4s, v21.4h, v0.h[0]
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
smull	v6.4s, v25.4h, v0.h[0]
smlal	v6.4s, v21.4h, v0.h[0]
sqrshrn	v2.4h, v2.4s, #0xc
sqrshrn	v3.4h, v6.4s, #0xc
sqadd	v6.4h, v16.4h, v31.4h
sqsub	v31.4h, v16.4h, v31.4h
mov	v16.8b, v6.8b
sqadd	v23.4h, v30.4h, v17.4h
sqsub	v7.4h, v30.4h, v17.4h
sqadd	v17.4h, v18.4h, v27.4h
sqsub	v30.4h, v18.4h, v27.4h
sqadd	v18.4h, v20.4h, v3.4h
sqsub	v29.4h, v20.4h, v3.4h
sqadd	v3.4h, v28.4h, v19.4h
sqsub	v25.4h, v28.4h, v19.4h
sqadd	v19.4h, v22.4h, v5.4h
sqsub	v28.4h, v22.4h, v5.4h
sqadd	v20.4h, v24.4h, v4.4h
sqsub	v27.4h, v24.4h, v4.4h
sqadd	v21.4h, v26.4h, v2.4h
sqsub	v26.4h, v26.4h, v2.4h
mov	v24.8b, v7.8b
mov	v22.8b, v3.8b
ret
inv_adst_8h_x16_neon:
adrp	x16, iadst16_coeffs
add	x16, x16, :lo12:iadst16_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
smull	v2.4s, v31.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull2	v3.4s, v31.8h, v0.h[0]
smlal2	v3.4s, v16.8h, v0.h[1]
smull	v4.4s, v31.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull2	v5.4s, v31.8h, v0.h[1]
smlsl2	v5.4s, v16.8h, v0.h[0]
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
smull2	v7.4s, v29.8h, v0.h[2]
smlal2	v7.4s, v18.8h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn2	v16.8h, v3.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
sqrshrn2	v31.8h, v5.4s, #0xc
smull	v2.4s, v29.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull2	v3.4s, v29.8h, v0.h[3]
smlsl2	v3.4s, v18.8h, v0.h[2]
smull	v4.4s, v27.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
smull2	v5.4s, v27.8h, v0.h[4]
smlal2	v5.4s, v20.8h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn2	v29.8h, v3.4s, #0xc
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull2	v7.4s, v27.8h, v0.h[5]
smlsl2	v7.4s, v20.8h, v0.h[4]
smull	v2.4s, v25.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
smull2	v3.4s, v25.8h, v0.h[6]
smlal2	v3.4s, v22.8h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull2	v5.4s, v25.8h, v0.h[7]
smlsl2	v5.4s, v22.8h, v0.h[6]
smull	v6.4s, v23.4h, v1.h[0]
smlal	v6.4s, v24.4h, v1.h[1]
smull2	v7.4s, v23.8h, v1.h[0]
smlal2	v7.4s, v24.8h, v1.h[1]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn2	v22.8h, v3.4s, #0xc
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn2	v25.8h, v5.4s, #0xc
smull	v2.4s, v23.4h, v1.h[1]
smlsl	v2.4s, v24.4h, v1.h[0]
smull2	v3.4s, v23.8h, v1.h[1]
smlsl2	v3.4s, v24.8h, v1.h[0]
smull	v4.4s, v21.4h, v1.h[2]
smlal	v4.4s, v26.4h, v1.h[3]
smull2	v5.4s, v21.8h, v1.h[2]
smlal2	v5.4s, v26.8h, v1.h[3]
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn2	v23.8h, v7.4s, #0xc
sqrshrn	v24.4h, v2.4s, #0xc
sqrshrn2	v24.8h, v3.4s, #0xc
smull	v6.4s, v21.4h, v1.h[3]
smlsl	v6.4s, v26.4h, v1.h[2]
smull2	v7.4s, v21.8h, v1.h[3]
smlsl2	v7.4s, v26.8h, v1.h[2]
smull	v2.4s, v19.4h, v1.h[4]
smlal	v2.4s, v28.4h, v1.h[5]
smull2	v3.4s, v19.8h, v1.h[4]
smlal2	v3.4s, v28.8h, v1.h[5]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn2	v21.8h, v5.4s, #0xc
sqrshrn	v26.4h, v6.4s, #0xc
sqrshrn2	v26.8h, v7.4s, #0xc
smull	v4.4s, v19.4h, v1.h[5]
smlsl	v4.4s, v28.4h, v1.h[4]
smull2	v5.4s, v19.8h, v1.h[5]
smlsl2	v5.4s, v28.8h, v1.h[4]
smull	v6.4s, v17.4h, v1.h[6]
smlal	v6.4s, v30.4h, v1.h[7]
smull2	v7.4s, v17.8h, v1.h[6]
smlal2	v7.4s, v30.8h, v1.h[7]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn2	v19.8h, v3.4s, #0xc
sqrshrn	v28.4h, v4.4s, #0xc
sqrshrn2	v28.8h, v5.4s, #0xc
smull	v2.4s, v17.4h, v1.h[7]
smlsl	v2.4s, v30.4h, v1.h[6]
smull2	v3.4s, v17.8h, v1.h[7]
smlsl2	v3.4s, v30.8h, v1.h[6]
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn2	v17.8h, v7.4s, #0xc
sqrshrn	v30.4h, v2.4s, #0xc
sqrshrn2	v30.8h, v3.4s, #0xc
ld1	{ v0.8h }, [x16]
sqsub	v2.8h, v16.8h, v23.8h
sqadd	v16.8h, v16.8h, v23.8h
sqsub	v3.8h, v31.8h, v24.8h
sqadd	v31.8h, v31.8h, v24.8h
sqadd	v23.8h, v18.8h, v21.8h
sqsub	v18.8h, v18.8h, v21.8h
sqadd	v24.8h, v29.8h, v26.8h
sqsub	v29.8h, v29.8h, v26.8h
sqadd	v21.8h, v20.8h, v19.8h
sqsub	v20.8h, v20.8h, v19.8h
sqadd	v26.8h, v27.8h, v28.8h
sqsub	v27.8h, v27.8h, v28.8h
sqadd	v19.8h, v22.8h, v17.8h
sqsub	v22.8h, v22.8h, v17.8h
sqadd	v28.8h, v25.8h, v30.8h
sqsub	v25.8h, v25.8h, v30.8h
smull	v4.4s, v2.4h, v0.h[5]
smlal	v4.4s, v3.4h, v0.h[4]
smull2	v5.4s, v2.8h, v0.h[5]
smlal2	v5.4s, v3.8h, v0.h[4]
smull	v6.4s, v2.4h, v0.h[4]
smlsl	v6.4s, v3.4h, v0.h[5]
smull2	v7.4s, v2.8h, v0.h[4]
smlsl2	v7.4s, v3.8h, v0.h[5]
smull	v2.4s, v18.4h, v0.h[7]
smlal	v2.4s, v29.4h, v0.h[6]
smull2	v3.4s, v18.8h, v0.h[7]
smlal2	v3.4s, v29.8h, v0.h[6]
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn2	v17.8h, v5.4s, #0xc
sqrshrn	v30.4h, v6.4s, #0xc
sqrshrn2	v30.8h, v7.4s, #0xc
smull	v4.4s, v18.4h, v0.h[6]
smlsl	v4.4s, v29.4h, v0.h[7]
smull2	v5.4s, v18.8h, v0.h[6]
smlsl2	v5.4s, v29.8h, v0.h[7]
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull2	v7.4s, v27.8h, v0.h[5]
smlsl2	v7.4s, v20.8h, v0.h[4]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn2	v18.8h, v3.4s, #0xc
sqrshrn	v29.4h, v4.4s, #0xc
sqrshrn2	v29.8h, v5.4s, #0xc
smull	v2.4s, v27.4h, v0.h[4]
smlal	v2.4s, v20.4h, v0.h[5]
smull2	v3.4s, v27.8h, v0.h[4]
smlal2	v3.4s, v20.8h, v0.h[5]
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull2	v5.4s, v25.8h, v0.h[7]
smlsl2	v5.4s, v22.8h, v0.h[6]
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
sqrshrn	v20.4h, v2.4s, #0xc
sqrshrn2	v20.8h, v3.4s, #0xc
smull	v6.4s, v25.4h, v0.h[6]
smlal	v6.4s, v22.4h, v0.h[7]
smull2	v7.4s, v25.8h, v0.h[6]
smlal2	v7.4s, v22.8h, v0.h[7]
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn2	v25.8h, v5.4s, #0xc
sqrshrn	v22.4h, v6.4s, #0xc
sqrshrn2	v22.8h, v7.4s, #0xc
sqsub	v2.8h, v16.8h, v21.8h
sqadd	v16.8h, v16.8h, v21.8h
sqsub	v3.8h, v31.8h, v26.8h
sqadd	v31.8h, v31.8h, v26.8h
sqadd	v21.8h, v23.8h, v19.8h
sqsub	v23.8h, v23.8h, v19.8h
sqadd	v26.8h, v24.8h, v28.8h
sqsub	v24.8h, v24.8h, v28.8h
sqadd	v19.8h, v17.8h, v27.8h
sqsub	v17.8h, v17.8h, v27.8h
sqadd	v28.8h, v30.8h, v20.8h
sqsub	v30.8h, v30.8h, v20.8h
sqadd	v27.8h, v18.8h, v25.8h
sqsub	v18.8h, v18.8h, v25.8h
sqadd	v20.8h, v29.8h, v22.8h
sqsub	v29.8h, v29.8h, v22.8h
smull	v4.4s, v2.4h, v0.h[3]
smlal	v4.4s, v3.4h, v0.h[2]
smull2	v5.4s, v2.8h, v0.h[3]
smlal2	v5.4s, v3.8h, v0.h[2]
smull	v6.4s, v2.4h, v0.h[2]
smlsl	v6.4s, v3.4h, v0.h[3]
smull2	v7.4s, v2.8h, v0.h[2]
smlsl2	v7.4s, v3.8h, v0.h[3]
smull	v2.4s, v24.4h, v0.h[3]
smlsl	v2.4s, v23.4h, v0.h[2]
smull2	v3.4s, v24.8h, v0.h[3]
smlsl2	v3.4s, v23.8h, v0.h[2]
sqrshrn	v22.4h, v4.4s, #0xc
sqrshrn2	v22.8h, v5.4s, #0xc
sqrshrn	v25.4h, v6.4s, #0xc
sqrshrn2	v25.8h, v7.4s, #0xc
smull	v4.4s, v24.4h, v0.h[2]
smlal	v4.4s, v23.4h, v0.h[3]
smull2	v5.4s, v24.8h, v0.h[2]
smlal2	v5.4s, v23.8h, v0.h[3]
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v30.4h, v0.h[2]
smull2	v7.4s, v17.8h, v0.h[3]
smlal2	v7.4s, v30.8h, v0.h[2]
sqrshrn	v24.4h, v2.4s, #0xc
sqrshrn2	v24.8h, v3.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
sqrshrn2	v23.8h, v5.4s, #0xc
smull	v2.4s, v17.4h, v0.h[2]
smlsl	v2.4s, v30.4h, v0.h[3]
smull2	v3.4s, v17.8h, v0.h[2]
smlsl2	v3.4s, v30.8h, v0.h[3]
smull	v4.4s, v29.4h, v0.h[3]
smlsl	v4.4s, v18.4h, v0.h[2]
smull2	v5.4s, v29.8h, v0.h[3]
smlsl2	v5.4s, v18.8h, v0.h[2]
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn2	v17.8h, v7.4s, #0xc
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
smull2	v7.4s, v29.8h, v0.h[2]
smlal2	v7.4s, v18.8h, v0.h[3]
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn2	v29.8h, v3.4s, #0xc
sqrshrn	v30.4h, v4.4s, #0xc
sqrshrn2	v30.8h, v5.4s, #0xc
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqsub	v2.8h, v16.8h, v21.8h
sqadd	v16.8h, v16.8h, v21.8h
sqsub	v21.8h, v31.8h, v26.8h
sqadd	v31.8h, v31.8h, v26.8h
sqneg	v31.8h, v31.8h
sqsub	v3.8h, v29.8h, v18.8h
sqadd	v29.8h, v29.8h, v18.8h
sqadd	v18.8h, v17.8h, v30.8h
sqsub	v26.8h, v17.8h, v30.8h
sqneg	v29.8h, v29.8h
sqadd	v17.8h, v19.8h, v27.8h
sqsub	v27.8h, v19.8h, v27.8h
sqadd	v30.8h, v28.8h, v20.8h
sqsub	v20.8h, v28.8h, v20.8h
sqneg	v17.8h, v17.8h
sqadd	v19.8h, v22.8h, v24.8h
sqsub	v22.8h, v22.8h, v24.8h
sqadd	v28.8h, v25.8h, v23.8h
sqsub	v23.8h, v25.8h, v23.8h
sqneg	v19.8h, v19.8h
smull	v24.4s, v2.4h, v0.h[0]
smlsl	v24.4s, v21.4h, v0.h[0]
smull2	v25.4s, v2.8h, v0.h[0]
smlsl2	v25.4s, v21.8h, v0.h[0]
smull	v4.4s, v2.4h, v0.h[0]
smlal	v4.4s, v21.4h, v0.h[0]
smull2	v5.4s, v2.8h, v0.h[0]
smlal2	v5.4s, v21.8h, v0.h[0]
smull	v6.4s, v26.4h, v0.h[0]
smlal	v6.4s, v3.4h, v0.h[0]
smull2	v7.4s, v26.8h, v0.h[0]
smlal2	v7.4s, v3.8h, v0.h[0]
sqrshrn	v24.4h, v24.4s, #0xc
sqrshrn2	v24.8h, v25.4s, #0xc
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn2	v4.8h, v5.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqrshrn2	v5.8h, v7.4s, #0xc
smull	v6.4s, v26.4h, v0.h[0]
smlsl	v6.4s, v3.4h, v0.h[0]
smull2	v7.4s, v26.8h, v0.h[0]
smlsl2	v7.4s, v3.8h, v0.h[0]
smull	v2.4s, v22.4h, v0.h[0]
smlal	v2.4s, v23.4h, v0.h[0]
smull2	v3.4s, v22.8h, v0.h[0]
smlal2	v3.4s, v23.8h, v0.h[0]
sqrshrn	v26.4h, v6.4s, #0xc
sqrshrn2	v26.8h, v7.4s, #0xc
smull	v6.4s, v22.4h, v0.h[0]
smlsl	v6.4s, v23.4h, v0.h[0]
smull2	v7.4s, v22.8h, v0.h[0]
smlsl2	v7.4s, v23.8h, v0.h[0]
smull	v22.4s, v27.4h, v0.h[0]
smlal	v22.4s, v20.4h, v0.h[0]
smull2	v23.4s, v27.8h, v0.h[0]
smlal2	v23.4s, v20.8h, v0.h[0]
smull	v21.4s, v27.4h, v0.h[0]
smlsl	v21.4s, v20.4h, v0.h[0]
smull2	v25.4s, v27.8h, v0.h[0]
smlsl2	v25.4s, v20.8h, v0.h[0]
sqrshrn	v20.4h, v2.4s, #0xc
sqrshrn2	v20.8h, v3.4s, #0xc
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn2	v6.8h, v7.4s, #0xc
sqrshrn	v7.4h, v21.4s, #0xc
sqrshrn2	v7.8h, v25.4s, #0xc
sqrshrn	v22.4h, v22.4s, #0xc
sqrshrn2	v22.8h, v23.4s, #0xc
sqneg	v23.8h, v4.8h
sqneg	v21.8h, v5.8h
sqneg	v27.8h, v6.8h
sqneg	v25.8h, v7.8h
ret
inv_flipadst_8h_x16_neon:
adrp	x16, iadst16_coeffs
add	x16, x16, :lo12:iadst16_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
smull	v2.4s, v31.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull2	v3.4s, v31.8h, v0.h[0]
smlal2	v3.4s, v16.8h, v0.h[1]
smull	v4.4s, v31.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull2	v5.4s, v31.8h, v0.h[1]
smlsl2	v5.4s, v16.8h, v0.h[0]
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
smull2	v7.4s, v29.8h, v0.h[2]
smlal2	v7.4s, v18.8h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn2	v16.8h, v3.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
sqrshrn2	v31.8h, v5.4s, #0xc
smull	v2.4s, v29.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull2	v3.4s, v29.8h, v0.h[3]
smlsl2	v3.4s, v18.8h, v0.h[2]
smull	v4.4s, v27.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
smull2	v5.4s, v27.8h, v0.h[4]
smlal2	v5.4s, v20.8h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn2	v29.8h, v3.4s, #0xc
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull2	v7.4s, v27.8h, v0.h[5]
smlsl2	v7.4s, v20.8h, v0.h[4]
smull	v2.4s, v25.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
smull2	v3.4s, v25.8h, v0.h[6]
smlal2	v3.4s, v22.8h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull2	v5.4s, v25.8h, v0.h[7]
smlsl2	v5.4s, v22.8h, v0.h[6]
smull	v6.4s, v23.4h, v1.h[0]
smlal	v6.4s, v24.4h, v1.h[1]
smull2	v7.4s, v23.8h, v1.h[0]
smlal2	v7.4s, v24.8h, v1.h[1]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn2	v22.8h, v3.4s, #0xc
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn2	v25.8h, v5.4s, #0xc
smull	v2.4s, v23.4h, v1.h[1]
smlsl	v2.4s, v24.4h, v1.h[0]
smull2	v3.4s, v23.8h, v1.h[1]
smlsl2	v3.4s, v24.8h, v1.h[0]
smull	v4.4s, v21.4h, v1.h[2]
smlal	v4.4s, v26.4h, v1.h[3]
smull2	v5.4s, v21.8h, v1.h[2]
smlal2	v5.4s, v26.8h, v1.h[3]
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn2	v23.8h, v7.4s, #0xc
sqrshrn	v24.4h, v2.4s, #0xc
sqrshrn2	v24.8h, v3.4s, #0xc
smull	v6.4s, v21.4h, v1.h[3]
smlsl	v6.4s, v26.4h, v1.h[2]
smull2	v7.4s, v21.8h, v1.h[3]
smlsl2	v7.4s, v26.8h, v1.h[2]
smull	v2.4s, v19.4h, v1.h[4]
smlal	v2.4s, v28.4h, v1.h[5]
smull2	v3.4s, v19.8h, v1.h[4]
smlal2	v3.4s, v28.8h, v1.h[5]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn2	v21.8h, v5.4s, #0xc
sqrshrn	v26.4h, v6.4s, #0xc
sqrshrn2	v26.8h, v7.4s, #0xc
smull	v4.4s, v19.4h, v1.h[5]
smlsl	v4.4s, v28.4h, v1.h[4]
smull2	v5.4s, v19.8h, v1.h[5]
smlsl2	v5.4s, v28.8h, v1.h[4]
smull	v6.4s, v17.4h, v1.h[6]
smlal	v6.4s, v30.4h, v1.h[7]
smull2	v7.4s, v17.8h, v1.h[6]
smlal2	v7.4s, v30.8h, v1.h[7]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn2	v19.8h, v3.4s, #0xc
sqrshrn	v28.4h, v4.4s, #0xc
sqrshrn2	v28.8h, v5.4s, #0xc
smull	v2.4s, v17.4h, v1.h[7]
smlsl	v2.4s, v30.4h, v1.h[6]
smull2	v3.4s, v17.8h, v1.h[7]
smlsl2	v3.4s, v30.8h, v1.h[6]
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn2	v17.8h, v7.4s, #0xc
sqrshrn	v30.4h, v2.4s, #0xc
sqrshrn2	v30.8h, v3.4s, #0xc
ld1	{ v0.8h }, [x16]
sqsub	v2.8h, v16.8h, v23.8h
sqadd	v16.8h, v16.8h, v23.8h
sqsub	v3.8h, v31.8h, v24.8h
sqadd	v31.8h, v31.8h, v24.8h
sqadd	v23.8h, v18.8h, v21.8h
sqsub	v18.8h, v18.8h, v21.8h
sqadd	v24.8h, v29.8h, v26.8h
sqsub	v29.8h, v29.8h, v26.8h
sqadd	v21.8h, v20.8h, v19.8h
sqsub	v20.8h, v20.8h, v19.8h
sqadd	v26.8h, v27.8h, v28.8h
sqsub	v27.8h, v27.8h, v28.8h
sqadd	v19.8h, v22.8h, v17.8h
sqsub	v22.8h, v22.8h, v17.8h
sqadd	v28.8h, v25.8h, v30.8h
sqsub	v25.8h, v25.8h, v30.8h
smull	v4.4s, v2.4h, v0.h[5]
smlal	v4.4s, v3.4h, v0.h[4]
smull2	v5.4s, v2.8h, v0.h[5]
smlal2	v5.4s, v3.8h, v0.h[4]
smull	v6.4s, v2.4h, v0.h[4]
smlsl	v6.4s, v3.4h, v0.h[5]
smull2	v7.4s, v2.8h, v0.h[4]
smlsl2	v7.4s, v3.8h, v0.h[5]
smull	v2.4s, v18.4h, v0.h[7]
smlal	v2.4s, v29.4h, v0.h[6]
smull2	v3.4s, v18.8h, v0.h[7]
smlal2	v3.4s, v29.8h, v0.h[6]
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn2	v17.8h, v5.4s, #0xc
sqrshrn	v30.4h, v6.4s, #0xc
sqrshrn2	v30.8h, v7.4s, #0xc
smull	v4.4s, v18.4h, v0.h[6]
smlsl	v4.4s, v29.4h, v0.h[7]
smull2	v5.4s, v18.8h, v0.h[6]
smlsl2	v5.4s, v29.8h, v0.h[7]
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull2	v7.4s, v27.8h, v0.h[5]
smlsl2	v7.4s, v20.8h, v0.h[4]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn2	v18.8h, v3.4s, #0xc
sqrshrn	v29.4h, v4.4s, #0xc
sqrshrn2	v29.8h, v5.4s, #0xc
smull	v2.4s, v27.4h, v0.h[4]
smlal	v2.4s, v20.4h, v0.h[5]
smull2	v3.4s, v27.8h, v0.h[4]
smlal2	v3.4s, v20.8h, v0.h[5]
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull2	v5.4s, v25.8h, v0.h[7]
smlsl2	v5.4s, v22.8h, v0.h[6]
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
sqrshrn	v20.4h, v2.4s, #0xc
sqrshrn2	v20.8h, v3.4s, #0xc
smull	v6.4s, v25.4h, v0.h[6]
smlal	v6.4s, v22.4h, v0.h[7]
smull2	v7.4s, v25.8h, v0.h[6]
smlal2	v7.4s, v22.8h, v0.h[7]
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn2	v25.8h, v5.4s, #0xc
sqrshrn	v22.4h, v6.4s, #0xc
sqrshrn2	v22.8h, v7.4s, #0xc
sqsub	v2.8h, v16.8h, v21.8h
sqadd	v16.8h, v16.8h, v21.8h
sqsub	v3.8h, v31.8h, v26.8h
sqadd	v31.8h, v31.8h, v26.8h
sqadd	v21.8h, v23.8h, v19.8h
sqsub	v23.8h, v23.8h, v19.8h
sqadd	v26.8h, v24.8h, v28.8h
sqsub	v24.8h, v24.8h, v28.8h
sqadd	v19.8h, v17.8h, v27.8h
sqsub	v17.8h, v17.8h, v27.8h
sqadd	v28.8h, v30.8h, v20.8h
sqsub	v30.8h, v30.8h, v20.8h
sqadd	v27.8h, v18.8h, v25.8h
sqsub	v18.8h, v18.8h, v25.8h
sqadd	v20.8h, v29.8h, v22.8h
sqsub	v29.8h, v29.8h, v22.8h
smull	v4.4s, v2.4h, v0.h[3]
smlal	v4.4s, v3.4h, v0.h[2]
smull2	v5.4s, v2.8h, v0.h[3]
smlal2	v5.4s, v3.8h, v0.h[2]
smull	v6.4s, v2.4h, v0.h[2]
smlsl	v6.4s, v3.4h, v0.h[3]
smull2	v7.4s, v2.8h, v0.h[2]
smlsl2	v7.4s, v3.8h, v0.h[3]
smull	v2.4s, v24.4h, v0.h[3]
smlsl	v2.4s, v23.4h, v0.h[2]
smull2	v3.4s, v24.8h, v0.h[3]
smlsl2	v3.4s, v23.8h, v0.h[2]
sqrshrn	v22.4h, v4.4s, #0xc
sqrshrn2	v22.8h, v5.4s, #0xc
sqrshrn	v25.4h, v6.4s, #0xc
sqrshrn2	v25.8h, v7.4s, #0xc
smull	v4.4s, v24.4h, v0.h[2]
smlal	v4.4s, v23.4h, v0.h[3]
smull2	v5.4s, v24.8h, v0.h[2]
smlal2	v5.4s, v23.8h, v0.h[3]
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v30.4h, v0.h[2]
smull2	v7.4s, v17.8h, v0.h[3]
smlal2	v7.4s, v30.8h, v0.h[2]
sqrshrn	v24.4h, v2.4s, #0xc
sqrshrn2	v24.8h, v3.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
sqrshrn2	v23.8h, v5.4s, #0xc
smull	v2.4s, v17.4h, v0.h[2]
smlsl	v2.4s, v30.4h, v0.h[3]
smull2	v3.4s, v17.8h, v0.h[2]
smlsl2	v3.4s, v30.8h, v0.h[3]
smull	v4.4s, v29.4h, v0.h[3]
smlsl	v4.4s, v18.4h, v0.h[2]
smull2	v5.4s, v29.8h, v0.h[3]
smlsl2	v5.4s, v18.8h, v0.h[2]
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn2	v17.8h, v7.4s, #0xc
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
smull2	v7.4s, v29.8h, v0.h[2]
smlal2	v7.4s, v18.8h, v0.h[3]
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn2	v29.8h, v3.4s, #0xc
sqrshrn	v30.4h, v4.4s, #0xc
sqrshrn2	v30.8h, v5.4s, #0xc
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqsub	v2.8h, v16.8h, v21.8h
sqadd	v4.8h, v16.8h, v21.8h
sqsub	v21.8h, v31.8h, v26.8h
sqadd	v16.8h, v31.8h, v26.8h
mov	v31.16b, v4.16b
sqneg	v16.8h, v16.8h
sqsub	v3.8h, v29.8h, v18.8h
sqadd	v18.8h, v29.8h, v18.8h
sqadd	v29.8h, v17.8h, v30.8h
sqsub	v26.8h, v17.8h, v30.8h
sqneg	v18.8h, v18.8h
sqadd	v30.8h, v19.8h, v27.8h
sqsub	v27.8h, v19.8h, v27.8h
sqadd	v17.8h, v28.8h, v20.8h
sqsub	v20.8h, v28.8h, v20.8h
sqneg	v30.8h, v30.8h
sqadd	v28.8h, v22.8h, v24.8h
sqsub	v22.8h, v22.8h, v24.8h
sqadd	v19.8h, v25.8h, v23.8h
sqsub	v23.8h, v25.8h, v23.8h
sqneg	v28.8h, v28.8h
smull	v24.4s, v2.4h, v0.h[0]
smlsl	v24.4s, v21.4h, v0.h[0]
smull2	v25.4s, v2.8h, v0.h[0]
smlsl2	v25.4s, v21.8h, v0.h[0]
smull	v4.4s, v2.4h, v0.h[0]
smlal	v4.4s, v21.4h, v0.h[0]
smull2	v5.4s, v2.8h, v0.h[0]
smlal2	v5.4s, v21.8h, v0.h[0]
smull	v6.4s, v26.4h, v0.h[0]
smlal	v6.4s, v3.4h, v0.h[0]
smull2	v7.4s, v26.8h, v0.h[0]
smlal2	v7.4s, v3.8h, v0.h[0]
sqrshrn	v24.4h, v24.4s, #0xc
sqrshrn2	v24.8h, v25.4s, #0xc
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn2	v4.8h, v5.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
sqrshrn2	v5.8h, v7.4s, #0xc
smull	v6.4s, v26.4h, v0.h[0]
smlsl	v6.4s, v3.4h, v0.h[0]
smull2	v7.4s, v26.8h, v0.h[0]
smlsl2	v7.4s, v3.8h, v0.h[0]
smull	v2.4s, v22.4h, v0.h[0]
smlal	v2.4s, v23.4h, v0.h[0]
smull2	v3.4s, v22.8h, v0.h[0]
smlal2	v3.4s, v23.8h, v0.h[0]
sqrshrn	v26.4h, v6.4s, #0xc
sqrshrn2	v26.8h, v7.4s, #0xc
smull	v6.4s, v22.4h, v0.h[0]
smlsl	v6.4s, v23.4h, v0.h[0]
smull2	v7.4s, v22.8h, v0.h[0]
smlsl2	v7.4s, v23.8h, v0.h[0]
smull	v22.4s, v27.4h, v0.h[0]
smlal	v22.4s, v20.4h, v0.h[0]
smull2	v23.4s, v27.8h, v0.h[0]
smlal2	v23.4s, v20.8h, v0.h[0]
smull	v21.4s, v27.4h, v0.h[0]
smlsl	v21.4s, v20.4h, v0.h[0]
smull2	v25.4s, v27.8h, v0.h[0]
smlsl2	v25.4s, v20.8h, v0.h[0]
sqrshrn	v27.4h, v2.4s, #0xc
sqrshrn2	v27.8h, v3.4s, #0xc
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn2	v6.8h, v7.4s, #0xc
sqrshrn	v7.4h, v21.4s, #0xc
sqrshrn2	v7.8h, v25.4s, #0xc
sqrshrn	v25.4h, v22.4s, #0xc
sqrshrn2	v25.8h, v23.4s, #0xc
mov	v23.16b, v24.16b
mov	v21.16b, v26.16b
sqneg	v24.8h, v4.8h
sqneg	v26.8h, v5.8h
sqneg	v20.8h, v6.8h
sqneg	v22.8h, v7.8h
ret
inv_adst_4h_x16_neon:
adrp	x16, iadst16_coeffs
add	x16, x16, :lo12:iadst16_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
smull	v2.4s, v31.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull	v4.4s, v31.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
smull	v2.4s, v29.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull	v4.4s, v27.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn	v29.4h, v2.4s, #0xc
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull	v2.4s, v25.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull	v6.4s, v23.4h, v1.h[0]
smlal	v6.4s, v24.4h, v1.h[1]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn	v25.4h, v4.4s, #0xc
smull	v2.4s, v23.4h, v1.h[1]
smlsl	v2.4s, v24.4h, v1.h[0]
smull	v4.4s, v21.4h, v1.h[2]
smlal	v4.4s, v26.4h, v1.h[3]
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn	v24.4h, v2.4s, #0xc
smull	v6.4s, v21.4h, v1.h[3]
smlsl	v6.4s, v26.4h, v1.h[2]
smull	v2.4s, v19.4h, v1.h[4]
smlal	v2.4s, v28.4h, v1.h[5]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn	v26.4h, v6.4s, #0xc
smull	v4.4s, v19.4h, v1.h[5]
smlsl	v4.4s, v28.4h, v1.h[4]
smull	v6.4s, v17.4h, v1.h[6]
smlal	v6.4s, v30.4h, v1.h[7]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn	v28.4h, v4.4s, #0xc
smull	v2.4s, v17.4h, v1.h[7]
smlsl	v2.4s, v30.4h, v1.h[6]
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn	v30.4h, v2.4s, #0xc
ld1	{ v0.8h }, [x16]
sqsub	v2.4h, v16.4h, v23.4h
sqadd	v16.4h, v16.4h, v23.4h
sqsub	v3.4h, v31.4h, v24.4h
sqadd	v31.4h, v31.4h, v24.4h
sqadd	v23.4h, v18.4h, v21.4h
sqsub	v18.4h, v18.4h, v21.4h
sqadd	v24.4h, v29.4h, v26.4h
sqsub	v29.4h, v29.4h, v26.4h
sqadd	v21.4h, v20.4h, v19.4h
sqsub	v20.4h, v20.4h, v19.4h
sqadd	v26.4h, v27.4h, v28.4h
sqsub	v27.4h, v27.4h, v28.4h
sqadd	v19.4h, v22.4h, v17.4h
sqsub	v22.4h, v22.4h, v17.4h
sqadd	v28.4h, v25.4h, v30.4h
sqsub	v25.4h, v25.4h, v30.4h
smull	v4.4s, v2.4h, v0.h[5]
smlal	v4.4s, v3.4h, v0.h[4]
smull	v6.4s, v2.4h, v0.h[4]
smlsl	v6.4s, v3.4h, v0.h[5]
smull	v2.4s, v18.4h, v0.h[7]
smlal	v2.4s, v29.4h, v0.h[6]
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn	v30.4h, v6.4s, #0xc
smull	v4.4s, v18.4h, v0.h[6]
smlsl	v4.4s, v29.4h, v0.h[7]
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn	v29.4h, v4.4s, #0xc
smull	v2.4s, v27.4h, v0.h[4]
smlal	v2.4s, v20.4h, v0.h[5]
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn	v20.4h, v2.4s, #0xc
smull	v6.4s, v25.4h, v0.h[6]
smlal	v6.4s, v22.4h, v0.h[7]
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn	v22.4h, v6.4s, #0xc
sqsub	v2.4h, v16.4h, v21.4h
sqadd	v16.4h, v16.4h, v21.4h
sqsub	v3.4h, v31.4h, v26.4h
sqadd	v31.4h, v31.4h, v26.4h
sqadd	v21.4h, v23.4h, v19.4h
sqsub	v23.4h, v23.4h, v19.4h
sqadd	v26.4h, v24.4h, v28.4h
sqsub	v24.4h, v24.4h, v28.4h
sqadd	v19.4h, v17.4h, v27.4h
sqsub	v17.4h, v17.4h, v27.4h
sqadd	v28.4h, v30.4h, v20.4h
sqsub	v30.4h, v30.4h, v20.4h
sqadd	v27.4h, v18.4h, v25.4h
sqsub	v18.4h, v18.4h, v25.4h
sqadd	v20.4h, v29.4h, v22.4h
sqsub	v29.4h, v29.4h, v22.4h
smull	v4.4s, v2.4h, v0.h[3]
smlal	v4.4s, v3.4h, v0.h[2]
smull	v6.4s, v2.4h, v0.h[2]
smlsl	v6.4s, v3.4h, v0.h[3]
smull	v2.4s, v24.4h, v0.h[3]
smlsl	v2.4s, v23.4h, v0.h[2]
sqrshrn	v22.4h, v4.4s, #0xc
sqrshrn	v25.4h, v6.4s, #0xc
smull	v4.4s, v24.4h, v0.h[2]
smlal	v4.4s, v23.4h, v0.h[3]
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v30.4h, v0.h[2]
sqrshrn	v24.4h, v2.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
smull	v2.4s, v17.4h, v0.h[2]
smlsl	v2.4s, v30.4h, v0.h[3]
smull	v4.4s, v29.4h, v0.h[3]
smlsl	v4.4s, v18.4h, v0.h[2]
sqrshrn	v17.4h, v6.4s, #0xc
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn	v30.4h, v4.4s, #0xc
sqrshrn	v18.4h, v6.4s, #0xc
sqsub	v2.4h, v16.4h, v21.4h
sqadd	v16.4h, v16.4h, v21.4h
sqsub	v21.4h, v31.4h, v26.4h
sqadd	v31.4h, v31.4h, v26.4h
sqneg	v31.4h, v31.4h
sqsub	v3.4h, v29.4h, v18.4h
sqadd	v29.4h, v29.4h, v18.4h
sqadd	v18.4h, v17.4h, v30.4h
sqsub	v26.4h, v17.4h, v30.4h
sqneg	v29.4h, v29.4h
sqadd	v17.4h, v19.4h, v27.4h
sqsub	v27.4h, v19.4h, v27.4h
sqadd	v30.4h, v28.4h, v20.4h
sqsub	v20.4h, v28.4h, v20.4h
sqneg	v17.4h, v17.4h
sqadd	v19.4h, v22.4h, v24.4h
sqsub	v22.4h, v22.4h, v24.4h
sqadd	v28.4h, v25.4h, v23.4h
sqsub	v23.4h, v25.4h, v23.4h
sqneg	v19.4h, v19.4h
smull	v24.4s, v2.4h, v0.h[0]
smlsl	v24.4s, v21.4h, v0.h[0]
smull	v4.4s, v2.4h, v0.h[0]
smlal	v4.4s, v21.4h, v0.h[0]
smull	v6.4s, v26.4h, v0.h[0]
smlal	v6.4s, v3.4h, v0.h[0]
sqrshrn	v24.4h, v24.4s, #0xc
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
smull	v6.4s, v26.4h, v0.h[0]
smlsl	v6.4s, v3.4h, v0.h[0]
smull	v2.4s, v22.4h, v0.h[0]
smlal	v2.4s, v23.4h, v0.h[0]
sqrshrn	v26.4h, v6.4s, #0xc
smull	v6.4s, v22.4h, v0.h[0]
smlsl	v6.4s, v23.4h, v0.h[0]
smull	v22.4s, v27.4h, v0.h[0]
smlal	v22.4s, v20.4h, v0.h[0]
smull	v21.4s, v27.4h, v0.h[0]
smlsl	v21.4s, v20.4h, v0.h[0]
sqrshrn	v20.4h, v2.4s, #0xc
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn	v7.4h, v21.4s, #0xc
sqrshrn	v22.4h, v22.4s, #0xc
sqneg	v23.4h, v4.4h
sqneg	v21.4h, v5.4h
sqneg	v27.4h, v6.4h
sqneg	v25.4h, v7.4h
ret
inv_flipadst_4h_x16_neon:
adrp	x16, iadst16_coeffs
add	x16, x16, :lo12:iadst16_coeffs
ld1	{ v0.8h, v1.8h }, [x16]
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
smull	v2.4s, v31.4h, v0.h[0]
smlal	v2.4s, v16.4h, v0.h[1]
smull	v4.4s, v31.4h, v0.h[1]
smlsl	v4.4s, v16.4h, v0.h[0]
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
smull	v2.4s, v29.4h, v0.h[3]
smlsl	v2.4s, v18.4h, v0.h[2]
smull	v4.4s, v27.4h, v0.h[4]
smlal	v4.4s, v20.4h, v0.h[5]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn	v29.4h, v2.4s, #0xc
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
smull	v2.4s, v25.4h, v0.h[6]
smlal	v2.4s, v22.4h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
smull	v6.4s, v23.4h, v1.h[0]
smlal	v6.4s, v24.4h, v1.h[1]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn	v25.4h, v4.4s, #0xc
smull	v2.4s, v23.4h, v1.h[1]
smlsl	v2.4s, v24.4h, v1.h[0]
smull	v4.4s, v21.4h, v1.h[2]
smlal	v4.4s, v26.4h, v1.h[3]
sqrshrn	v23.4h, v6.4s, #0xc
sqrshrn	v24.4h, v2.4s, #0xc
smull	v6.4s, v21.4h, v1.h[3]
smlsl	v6.4s, v26.4h, v1.h[2]
smull	v2.4s, v19.4h, v1.h[4]
smlal	v2.4s, v28.4h, v1.h[5]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn	v26.4h, v6.4s, #0xc
smull	v4.4s, v19.4h, v1.h[5]
smlsl	v4.4s, v28.4h, v1.h[4]
smull	v6.4s, v17.4h, v1.h[6]
smlal	v6.4s, v30.4h, v1.h[7]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn	v28.4h, v4.4s, #0xc
smull	v2.4s, v17.4h, v1.h[7]
smlsl	v2.4s, v30.4h, v1.h[6]
sqrshrn	v17.4h, v6.4s, #0xc
sqrshrn	v30.4h, v2.4s, #0xc
ld1	{ v0.8h }, [x16]
sqsub	v2.4h, v16.4h, v23.4h
sqadd	v16.4h, v16.4h, v23.4h
sqsub	v3.4h, v31.4h, v24.4h
sqadd	v31.4h, v31.4h, v24.4h
sqadd	v23.4h, v18.4h, v21.4h
sqsub	v18.4h, v18.4h, v21.4h
sqadd	v24.4h, v29.4h, v26.4h
sqsub	v29.4h, v29.4h, v26.4h
sqadd	v21.4h, v20.4h, v19.4h
sqsub	v20.4h, v20.4h, v19.4h
sqadd	v26.4h, v27.4h, v28.4h
sqsub	v27.4h, v27.4h, v28.4h
sqadd	v19.4h, v22.4h, v17.4h
sqsub	v22.4h, v22.4h, v17.4h
sqadd	v28.4h, v25.4h, v30.4h
sqsub	v25.4h, v25.4h, v30.4h
smull	v4.4s, v2.4h, v0.h[5]
smlal	v4.4s, v3.4h, v0.h[4]
smull	v6.4s, v2.4h, v0.h[4]
smlsl	v6.4s, v3.4h, v0.h[5]
smull	v2.4s, v18.4h, v0.h[7]
smlal	v2.4s, v29.4h, v0.h[6]
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn	v30.4h, v6.4s, #0xc
smull	v4.4s, v18.4h, v0.h[6]
smlsl	v4.4s, v29.4h, v0.h[7]
smull	v6.4s, v27.4h, v0.h[5]
smlsl	v6.4s, v20.4h, v0.h[4]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn	v29.4h, v4.4s, #0xc
smull	v2.4s, v27.4h, v0.h[4]
smlal	v2.4s, v20.4h, v0.h[5]
smull	v4.4s, v25.4h, v0.h[7]
smlsl	v4.4s, v22.4h, v0.h[6]
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn	v20.4h, v2.4s, #0xc
smull	v6.4s, v25.4h, v0.h[6]
smlal	v6.4s, v22.4h, v0.h[7]
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn	v22.4h, v6.4s, #0xc
sqsub	v2.4h, v16.4h, v21.4h
sqadd	v16.4h, v16.4h, v21.4h
sqsub	v3.4h, v31.4h, v26.4h
sqadd	v31.4h, v31.4h, v26.4h
sqadd	v21.4h, v23.4h, v19.4h
sqsub	v23.4h, v23.4h, v19.4h
sqadd	v26.4h, v24.4h, v28.4h
sqsub	v24.4h, v24.4h, v28.4h
sqadd	v19.4h, v17.4h, v27.4h
sqsub	v17.4h, v17.4h, v27.4h
sqadd	v28.4h, v30.4h, v20.4h
sqsub	v30.4h, v30.4h, v20.4h
sqadd	v27.4h, v18.4h, v25.4h
sqsub	v18.4h, v18.4h, v25.4h
sqadd	v20.4h, v29.4h, v22.4h
sqsub	v29.4h, v29.4h, v22.4h
smull	v4.4s, v2.4h, v0.h[3]
smlal	v4.4s, v3.4h, v0.h[2]
smull	v6.4s, v2.4h, v0.h[2]
smlsl	v6.4s, v3.4h, v0.h[3]
smull	v2.4s, v24.4h, v0.h[3]
smlsl	v2.4s, v23.4h, v0.h[2]
sqrshrn	v22.4h, v4.4s, #0xc
sqrshrn	v25.4h, v6.4s, #0xc
smull	v4.4s, v24.4h, v0.h[2]
smlal	v4.4s, v23.4h, v0.h[3]
smull	v6.4s, v17.4h, v0.h[3]
smlal	v6.4s, v30.4h, v0.h[2]
sqrshrn	v24.4h, v2.4s, #0xc
sqrshrn	v23.4h, v4.4s, #0xc
smull	v2.4s, v17.4h, v0.h[2]
smlsl	v2.4s, v30.4h, v0.h[3]
smull	v4.4s, v29.4h, v0.h[3]
smlsl	v4.4s, v18.4h, v0.h[2]
sqrshrn	v17.4h, v6.4s, #0xc
smull	v6.4s, v29.4h, v0.h[2]
smlal	v6.4s, v18.4h, v0.h[3]
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn	v30.4h, v4.4s, #0xc
sqrshrn	v18.4h, v6.4s, #0xc
sqsub	v2.4h, v16.4h, v21.4h
sqadd	v4.4h, v16.4h, v21.4h
sqsub	v21.4h, v31.4h, v26.4h
sqadd	v16.4h, v31.4h, v26.4h
mov	v31.8b, v4.8b
sqneg	v16.4h, v16.4h
sqsub	v3.4h, v29.4h, v18.4h
sqadd	v18.4h, v29.4h, v18.4h
sqadd	v29.4h, v17.4h, v30.4h
sqsub	v26.4h, v17.4h, v30.4h
sqneg	v18.4h, v18.4h
sqadd	v30.4h, v19.4h, v27.4h
sqsub	v27.4h, v19.4h, v27.4h
sqadd	v17.4h, v28.4h, v20.4h
sqsub	v20.4h, v28.4h, v20.4h
sqneg	v30.4h, v30.4h
sqadd	v28.4h, v22.4h, v24.4h
sqsub	v22.4h, v22.4h, v24.4h
sqadd	v19.4h, v25.4h, v23.4h
sqsub	v23.4h, v25.4h, v23.4h
sqneg	v28.4h, v28.4h
smull	v24.4s, v2.4h, v0.h[0]
smlsl	v24.4s, v21.4h, v0.h[0]
smull	v4.4s, v2.4h, v0.h[0]
smlal	v4.4s, v21.4h, v0.h[0]
smull	v6.4s, v26.4h, v0.h[0]
smlal	v6.4s, v3.4h, v0.h[0]
sqrshrn	v24.4h, v24.4s, #0xc
sqrshrn	v4.4h, v4.4s, #0xc
sqrshrn	v5.4h, v6.4s, #0xc
smull	v6.4s, v26.4h, v0.h[0]
smlsl	v6.4s, v3.4h, v0.h[0]
smull	v2.4s, v22.4h, v0.h[0]
smlal	v2.4s, v23.4h, v0.h[0]
sqrshrn	v26.4h, v6.4s, #0xc
smull	v6.4s, v22.4h, v0.h[0]
smlsl	v6.4s, v23.4h, v0.h[0]
smull	v22.4s, v27.4h, v0.h[0]
smlal	v22.4s, v20.4h, v0.h[0]
smull	v21.4s, v27.4h, v0.h[0]
smlsl	v21.4s, v20.4h, v0.h[0]
sqrshrn	v27.4h, v2.4s, #0xc
sqrshrn	v6.4h, v6.4s, #0xc
sqrshrn	v7.4h, v21.4s, #0xc
sqrshrn	v25.4h, v22.4s, #0xc
mov	v23.8b, v24.8b
mov	v21.8b, v26.8b
sqneg	v24.4h, v4.4h
sqneg	v26.4h, v5.4h
sqneg	v20.4h, v6.4h
sqneg	v22.4h, v7.4h
ret
inv_identity_8h_x16_neon:
mov	w16, #0x6a10
dup	v0.4h, w16
sqrdmulh	v2.8h, v16.8h, v0.h[0]
sqadd	v16.8h, v16.8h, v16.8h
sqadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v0.h[0]
sqadd	v17.8h, v17.8h, v17.8h
sqadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v0.h[0]
sqadd	v18.8h, v18.8h, v18.8h
sqadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v0.h[0]
sqadd	v19.8h, v19.8h, v19.8h
sqadd	v19.8h, v19.8h, v2.8h
sqrdmulh	v2.8h, v20.8h, v0.h[0]
sqadd	v20.8h, v20.8h, v20.8h
sqadd	v20.8h, v20.8h, v2.8h
sqrdmulh	v2.8h, v21.8h, v0.h[0]
sqadd	v21.8h, v21.8h, v21.8h
sqadd	v21.8h, v21.8h, v2.8h
sqrdmulh	v2.8h, v22.8h, v0.h[0]
sqadd	v22.8h, v22.8h, v22.8h
sqadd	v22.8h, v22.8h, v2.8h
sqrdmulh	v2.8h, v23.8h, v0.h[0]
sqadd	v23.8h, v23.8h, v23.8h
sqadd	v23.8h, v23.8h, v2.8h
sqrdmulh	v2.8h, v24.8h, v0.h[0]
sqadd	v24.8h, v24.8h, v24.8h
sqadd	v24.8h, v24.8h, v2.8h
sqrdmulh	v2.8h, v25.8h, v0.h[0]
sqadd	v25.8h, v25.8h, v25.8h
sqadd	v25.8h, v25.8h, v2.8h
sqrdmulh	v2.8h, v26.8h, v0.h[0]
sqadd	v26.8h, v26.8h, v26.8h
sqadd	v26.8h, v26.8h, v2.8h
sqrdmulh	v2.8h, v27.8h, v0.h[0]
sqadd	v27.8h, v27.8h, v27.8h
sqadd	v27.8h, v27.8h, v2.8h
sqrdmulh	v2.8h, v28.8h, v0.h[0]
sqadd	v28.8h, v28.8h, v28.8h
sqadd	v28.8h, v28.8h, v2.8h
sqrdmulh	v2.8h, v29.8h, v0.h[0]
sqadd	v29.8h, v29.8h, v29.8h
sqadd	v29.8h, v29.8h, v2.8h
sqrdmulh	v2.8h, v30.8h, v0.h[0]
sqadd	v30.8h, v30.8h, v30.8h
sqadd	v30.8h, v30.8h, v2.8h
sqrdmulh	v2.8h, v31.8h, v0.h[0]
sqadd	v31.8h, v31.8h, v31.8h
sqadd	v31.8h, v31.8h, v2.8h
ret
inv_identity_4h_x16_neon:
mov	w16, #0x6a10
dup	v0.4h, w16
sqrdmulh	v2.4h, v16.4h, v0.h[0]
sqadd	v16.4h, v16.4h, v16.4h
sqadd	v16.4h, v16.4h, v2.4h
sqrdmulh	v2.4h, v17.4h, v0.h[0]
sqadd	v17.4h, v17.4h, v17.4h
sqadd	v17.4h, v17.4h, v2.4h
sqrdmulh	v2.4h, v18.4h, v0.h[0]
sqadd	v18.4h, v18.4h, v18.4h
sqadd	v18.4h, v18.4h, v2.4h
sqrdmulh	v2.4h, v19.4h, v0.h[0]
sqadd	v19.4h, v19.4h, v19.4h
sqadd	v19.4h, v19.4h, v2.4h
sqrdmulh	v2.4h, v20.4h, v0.h[0]
sqadd	v20.4h, v20.4h, v20.4h
sqadd	v20.4h, v20.4h, v2.4h
sqrdmulh	v2.4h, v21.4h, v0.h[0]
sqadd	v21.4h, v21.4h, v21.4h
sqadd	v21.4h, v21.4h, v2.4h
sqrdmulh	v2.4h, v22.4h, v0.h[0]
sqadd	v22.4h, v22.4h, v22.4h
sqadd	v22.4h, v22.4h, v2.4h
sqrdmulh	v2.4h, v23.4h, v0.h[0]
sqadd	v23.4h, v23.4h, v23.4h
sqadd	v23.4h, v23.4h, v2.4h
sqrdmulh	v2.4h, v24.4h, v0.h[0]
sqadd	v24.4h, v24.4h, v24.4h
sqadd	v24.4h, v24.4h, v2.4h
sqrdmulh	v2.4h, v25.4h, v0.h[0]
sqadd	v25.4h, v25.4h, v25.4h
sqadd	v25.4h, v25.4h, v2.4h
sqrdmulh	v2.4h, v26.4h, v0.h[0]
sqadd	v26.4h, v26.4h, v26.4h
sqadd	v26.4h, v26.4h, v2.4h
sqrdmulh	v2.4h, v27.4h, v0.h[0]
sqadd	v27.4h, v27.4h, v27.4h
sqadd	v27.4h, v27.4h, v2.4h
sqrdmulh	v2.4h, v28.4h, v0.h[0]
sqadd	v28.4h, v28.4h, v28.4h
sqadd	v28.4h, v28.4h, v2.4h
sqrdmulh	v2.4h, v29.4h, v0.h[0]
sqadd	v29.4h, v29.4h, v29.4h
sqadd	v29.4h, v29.4h, v2.4h
sqrdmulh	v2.4h, v30.4h, v0.h[0]
sqadd	v30.4h, v30.4h, v30.4h
sqadd	v30.4h, v30.4h, v2.4h
sqrdmulh	v2.4h, v31.4h, v0.h[0]
sqadd	v31.4h, v31.4h, v31.4h
sqadd	v31.4h, v31.4h, v2.4h
ret
inv_txfm_horz_scale_16x8_neon:
mov	x14, x30
movi	v7.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
sqrdmulh	v24.8h, v24.8h, v0.h[0]
sqrdmulh	v25.8h, v25.8h, v0.h[0]
sqrdmulh	v26.8h, v26.8h, v0.h[0]
sqrdmulh	v27.8h, v27.8h, v0.h[0]
sqrdmulh	v28.8h, v28.8h, v0.h[0]
sqrdmulh	v29.8h, v29.8h, v0.h[0]
sqrdmulh	v30.8h, v30.8h, v0.h[0]
sqrdmulh	v31.8h, v31.8h, v0.h[0]
blr	x4
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
srshr	v20.8h, v20.8h, #0x1
srshr	v21.8h, v21.8h, #0x1
srshr	v22.8h, v22.8h, #0x1
srshr	v23.8h, v23.8h, #0x1
srshr	v24.8h, v24.8h, #0x1
srshr	v25.8h, v25.8h, #0x1
srshr	v26.8h, v26.8h, #0x1
srshr	v27.8h, v27.8h, #0x1
srshr	v28.8h, v28.8h, #0x1
srshr	v29.8h, v29.8h, #0x1
srshr	v30.8h, v30.8h, #0x1
srshr	v31.8h, v31.8h, #0x1
b	L_2fd4
inv_txfm_horz_identity_16x8_neon:
mov	x14, x30
movi	v7.8h, #0x0
mov	w16, #0x6a10
dup	v0.4h, w16
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
sqrdmulh	v2.8h, v16.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v19.8h, v19.8h, v2.8h
sqrdmulh	v2.8h, v20.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v20.8h, v20.8h, v2.8h
sqrdmulh	v2.8h, v21.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v21.8h, v21.8h, v2.8h
sqrdmulh	v2.8h, v22.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v22.8h, v22.8h, v2.8h
sqrdmulh	v2.8h, v23.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v23.8h, v23.8h, v2.8h
sqrdmulh	v2.8h, v24.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v24.8h, v24.8h, v2.8h
sqrdmulh	v2.8h, v25.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v25.8h, v25.8h, v2.8h
sqrdmulh	v2.8h, v26.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v26.8h, v26.8h, v2.8h
sqrdmulh	v2.8h, v27.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v27.8h, v27.8h, v2.8h
sqrdmulh	v2.8h, v28.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v28.8h, v28.8h, v2.8h
sqrdmulh	v2.8h, v29.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v29.8h, v29.8h, v2.8h
sqrdmulh	v2.8h, v30.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v30.8h, v30.8h, v2.8h
sqrdmulh	v2.8h, v31.8h, v0.h[0]
sshr	v2.8h, v2.8h, #0x1
srhadd	v31.8h, v31.8h, v2.8h
b	L_2fd4
inv_txfm_horz_16x8_neon:
mov	x14, x30
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
blr	x4
srshr	v16.8h, v16.8h, #0x2
srshr	v17.8h, v17.8h, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v19.8h, v19.8h, #0x2
srshr	v20.8h, v20.8h, #0x2
srshr	v21.8h, v21.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
srshr	v23.8h, v23.8h, #0x2
srshr	v24.8h, v24.8h, #0x2
srshr	v25.8h, v25.8h, #0x2
srshr	v26.8h, v26.8h, #0x2
srshr	v27.8h, v27.8h, #0x2
srshr	v28.8h, v28.8h, #0x2
srshr	v29.8h, v29.8h, #0x2
srshr	v30.8h, v30.8h, #0x2
srshr	v31.8h, v31.8h, #0x2
L_2fd4:
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
trn1	v4.8h, v24.8h, v25.8h
trn2	v5.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v5.4s, v27.4s
trn2	v5.4s, v5.4s, v27.4s
trn1	v27.4s, v4.4s, v25.4s
trn2	v4.4s, v4.4s, v25.4s
trn1	v24.2d, v27.2d, v28.2d
trn2	v28.2d, v27.2d, v28.2d
trn1	v25.2d, v29.2d, v30.2d
trn2	v29.2d, v29.2d, v30.2d
trn2	v30.2d, v4.2d, v26.2d
trn1	v26.2d, v4.2d, v26.2d
trn1	v27.2d, v5.2d, v31.2d
trn2	v31.2d, v5.2d, v31.2d
st1	{ v16.8h }, [x6], #16
st1	{ v24.8h }, [x6], #16
st1	{ v17.8h }, [x6], #16
st1	{ v25.8h }, [x6], #16
st1	{ v18.8h }, [x6], #16
st1	{ v26.8h }, [x6], #16
st1	{ v19.8h }, [x6], #16
st1	{ v27.8h }, [x6], #16
st1	{ v20.8h }, [x6], #16
st1	{ v28.8h }, [x6], #16
st1	{ v21.8h }, [x6], #16
st1	{ v29.8h }, [x6], #16
st1	{ v22.8h }, [x6], #16
st1	{ v30.8h }, [x6], #16
st1	{ v23.8h }, [x6], #16
st1	{ v31.8h }, [x6], #16
ret	x14
inv_txfm_add_vert_8x16_neon:
mov	x14, x30
ld1	{ v16.8h }, [x7], x8
ld1	{ v17.8h }, [x7], x8
ld1	{ v18.8h }, [x7], x8
ld1	{ v19.8h }, [x7], x8
ld1	{ v20.8h }, [x7], x8
ld1	{ v21.8h }, [x7], x8
ld1	{ v22.8h }, [x7], x8
ld1	{ v23.8h }, [x7], x8
ld1	{ v24.8h }, [x7], x8
ld1	{ v25.8h }, [x7], x8
ld1	{ v26.8h }, [x7], x8
ld1	{ v27.8h }, [x7], x8
ld1	{ v28.8h }, [x7], x8
ld1	{ v29.8h }, [x7], x8
ld1	{ v30.8h }, [x7], x8
ld1	{ v31.8h }, [x7], x8
blr	x5
mov	x7, x6
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x6], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x6], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x6], x1
ld1	{ v4.8b }, [x7], x1
srshr	v24.8h, v24.8h, #0x4
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x6], x1
ld1	{ v5.8b }, [x7], x1
srshr	v25.8h, v25.8h, #0x4
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x6], x1
ld1	{ v6.8b }, [x7], x1
srshr	v26.8h, v26.8h, #0x4
uaddw	v24.8h, v24.8h, v4.8b
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v7.8b }, [x7], x1
srshr	v27.8h, v27.8h, #0x4
uaddw	v25.8h, v25.8h, v5.8b
sqxtun	v4.8b, v24.8h
st1	{ v3.8b }, [x6], x1
ld1	{ v2.8b }, [x7], x1
srshr	v28.8h, v28.8h, #0x4
uaddw	v26.8h, v26.8h, v6.8b
sqxtun	v5.8b, v25.8h
st1	{ v4.8b }, [x6], x1
ld1	{ v3.8b }, [x7], x1
srshr	v29.8h, v29.8h, #0x4
uaddw	v27.8h, v27.8h, v7.8b
sqxtun	v6.8b, v26.8h
st1	{ v5.8b }, [x6], x1
ld1	{ v4.8b }, [x7], x1
srshr	v30.8h, v30.8h, #0x4
uaddw	v28.8h, v28.8h, v2.8b
sqxtun	v7.8b, v27.8h
st1	{ v6.8b }, [x6], x1
ld1	{ v5.8b }, [x7], x1
srshr	v31.8h, v31.8h, #0x4
uaddw	v29.8h, v29.8h, v3.8b
sqxtun	v2.8b, v28.8h
st1	{ v7.8b }, [x6], x1
uaddw	v30.8h, v30.8h, v4.8b
sqxtun	v3.8b, v29.8h
st1	{ v2.8b }, [x6], x1
uaddw	v31.8h, v31.8h, v5.8b
sqxtun	v4.8b, v30.8h
st1	{ v3.8b }, [x6], x1
sqxtun	v5.8b, v31.8h
st1	{ v4.8b }, [x6], x1
st1	{ v5.8b }, [x6], x1
ret	x14
inv_txfm_add_16x16_neon:
mov	x15, x30
sub	sp, sp, #0x200
mov	x8, #0x20
mov	x6, sp
add	x7, x2, #0x0
blr	x9
add	x6, sp, #0x100
cmp	w3, w13
b.lt	L_3298
add	x7, x2, #0x10
blr	x9
b	L_32b8
L_3298:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
L_32b8:
add	x6, x0, #0x0
mov	x7, sp
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x8
add	x7, sp, #0x10
bl	inv_txfm_add_vert_8x16_neon
add	sp, sp, #0x200
ret	x15
inv_txfm_add_dct_dct_16x16_8bpc_neon:
cbnz	w3, L_3304
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x10
b	idct_dc_w16_neon
L_3304:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_identity_identity_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_identity_16x8_neon
adr	x5, inv_identity_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_dct_adst_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_dct_flipadst_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_dct_identity_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_identity_8h_x16_neon
mov	x13, #0x8
b	inv_txfm_add_16x16_neon
inv_txfm_add_adst_dct_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_adst_adst_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_adst_flipadst_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_flipadst_dct_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_flipadst_adst_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_flipadst_flipadst_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_16x8_neon
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x24
b	inv_txfm_add_16x16_neon
inv_txfm_add_identity_dct_16x16_8bpc_neon:
adr	x9, inv_txfm_horz_identity_16x8_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x8
b	inv_txfm_add_16x16_neon
inv_txfm_identity_add_16x4_neon:
mov	x15, x30
movi	v4.8h, #0x0
ld1	{ v16.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v17.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v18.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v19.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v16.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v17.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v18.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v19.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
mov	w16, #0x6a10
dup	v0.4h, w16
ld1	{ v20.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v21.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v22.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v23.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v20.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v21.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v22.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v23.d }[1], [x2]
st1	{ v4.4h }, [x2], #8
sqrdmulh	v2.8h, v16.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v19.8h, v19.8h, v2.8h
sqrdmulh	v2.8h, v20.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v20.8h, v20.8h, v2.8h
sqrdmulh	v2.8h, v21.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v21.8h, v21.8h, v2.8h
sqrdmulh	v2.8h, v22.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v22.8h, v22.8h, v2.8h
sqrdmulh	v2.8h, v23.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v23.8h, v23.8h, v2.8h
sqrdmulh	v2.8h, v24.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v24.8h, v24.8h, v2.8h
sqrdmulh	v2.8h, v25.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v25.8h, v25.8h, v2.8h
sqrdmulh	v2.8h, v26.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v26.8h, v26.8h, v2.8h
sqrdmulh	v2.8h, v27.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v27.8h, v27.8h, v2.8h
sqrdmulh	v2.8h, v28.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v28.8h, v28.8h, v2.8h
sqrdmulh	v2.8h, v29.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v29.8h, v29.8h, v2.8h
sqrdmulh	v2.8h, v30.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v30.8h, v30.8h, v2.8h
sqrdmulh	v2.8h, v31.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v31.8h, v31.8h, v2.8h
b	L_3710
inv_txfm_identity_add_4x16_neon:
mov	x15, x30
movi	v2.8h, #0x0
mov	x11, #0x20
cmp	w3, w13
b.lt	L_35d4
add	x6, x2, #0x10
ld1	{ v24.8h }, [x6]
st1	{ v2.8h }, [x6], x11
ld1	{ v25.8h }, [x6]
st1	{ v2.8h }, [x6], x11
ld1	{ v26.8h }, [x6]
st1	{ v2.8h }, [x6], x11
ld1	{ v27.8h }, [x6]
st1	{ v2.8h }, [x6], x11
mov	w16, #0x3508
dup	v0.4h, w16
sqrdmulh	v2.8h, v24.8h, v0.h[0]
srhadd	v24.8h, v24.8h, v2.8h
sqrdmulh	v2.8h, v25.8h, v0.h[0]
srhadd	v25.8h, v25.8h, v2.8h
sqrdmulh	v2.8h, v26.8h, v0.h[0]
srhadd	v26.8h, v26.8h, v2.8h
sqrdmulh	v2.8h, v27.8h, v0.h[0]
srhadd	v27.8h, v27.8h, v2.8h
trn1	v4.8h, v24.8h, v25.8h
trn2	v5.8h, v24.8h, v25.8h
trn1	v6.8h, v26.8h, v27.8h
trn2	v7.8h, v26.8h, v27.8h
trn1	v24.4s, v4.4s, v6.4s
trn2	v26.4s, v4.4s, v6.4s
trn1	v25.4s, v5.4s, v7.4s
trn2	v27.4s, v5.4s, v7.4s
mov	v28.d[0], v24.d[1]
mov	v29.d[0], v25.d[1]
mov	v30.d[0], v26.d[1]
mov	v31.d[0], v27.d[1]
b	L_35f4
L_35d4:
movi	v24.4h, #0x0
movi	v25.4h, #0x0
movi	v26.4h, #0x0
movi	v27.4h, #0x0
movi	v28.4h, #0x0
movi	v29.4h, #0x0
movi	v30.4h, #0x0
movi	v31.4h, #0x0
L_35f4:
movi	v2.8h, #0x0
ld1	{ v16.8h }, [x2]
st1	{ v2.8h }, [x2], x11
ld1	{ v17.8h }, [x2]
st1	{ v2.8h }, [x2], x11
ld1	{ v18.8h }, [x2]
st1	{ v2.8h }, [x2], x11
ld1	{ v19.8h }, [x2]
st1	{ v2.8h }, [x2], x11
mov	w16, #0x3508
dup	v0.4h, w16
sqrdmulh	v2.8h, v16.8h, v0.h[0]
srhadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v0.h[0]
srhadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v0.h[0]
srhadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v0.h[0]
srhadd	v19.8h, v19.8h, v2.8h
b	L_38e4
inv_txfm_add_16x4_neon:
mov	x15, x30
movi	v4.8h, #0x0
ld1	{ v16.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v17.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v18.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v19.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v20.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v21.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v22.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v23.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v24.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v25.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v26.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v27.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v28.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v29.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v30.4h }, [x2]
st1	{ v4.4h }, [x2], #8
ld1	{ v31.4h }, [x2]
st1	{ v4.4h }, [x2], #8
blr	x4
mov	v16.d[1], v20.d[0]
mov	v17.d[1], v21.d[0]
mov	v18.d[1], v22.d[0]
mov	v19.d[1], v23.d[0]
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
mov	v24.d[1], v28.d[0]
mov	v25.d[1], v29.d[0]
mov	v26.d[1], v30.d[0]
mov	v27.d[1], v31.d[0]
srshr	v20.8h, v24.8h, #0x1
srshr	v21.8h, v25.8h, #0x1
srshr	v22.8h, v26.8h, #0x1
srshr	v23.8h, v27.8h, #0x1
L_3710:
trn1	v2.8h, v16.8h, v17.8h
trn2	v3.8h, v16.8h, v17.8h
trn1	v4.8h, v18.8h, v19.8h
trn2	v5.8h, v18.8h, v19.8h
trn1	v16.4s, v2.4s, v4.4s
trn2	v18.4s, v2.4s, v4.4s
trn1	v17.4s, v3.4s, v5.4s
trn2	v19.4s, v3.4s, v5.4s
blr	x5
mov	x6, x0
mov	x7, x6
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x6], x1
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x6], x1
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x6], x1
st1	{ v5.8b }, [x6], x1
trn1	v2.8h, v20.8h, v21.8h
trn2	v3.8h, v20.8h, v21.8h
trn1	v4.8h, v22.8h, v23.8h
trn2	v5.8h, v22.8h, v23.8h
trn1	v16.4s, v2.4s, v4.4s
trn2	v18.4s, v2.4s, v4.4s
trn1	v17.4s, v3.4s, v5.4s
trn2	v19.4s, v3.4s, v5.4s
blr	x5
add	x6, x0, #0x8
mov	x7, x6
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x6], x1
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x6], x1
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x6], x1
st1	{ v5.8b }, [x6], x1
ret	x15
inv_txfm_add_4x16_neon:
mov	x15, x30
movi	v2.8h, #0x0
mov	x11, #0x20
cmp	w3, w13
b.lt	L_388c
add	x6, x2, #0x10
ld1	{ v16.8h }, [x6]
st1	{ v2.8h }, [x6], x11
ld1	{ v17.8h }, [x6]
st1	{ v2.8h }, [x6], x11
ld1	{ v18.8h }, [x6]
st1	{ v2.8h }, [x6], x11
ld1	{ v19.8h }, [x6]
st1	{ v2.8h }, [x6], x11
blr	x4
srshr	v24.8h, v16.8h, #0x1
srshr	v25.8h, v17.8h, #0x1
srshr	v26.8h, v18.8h, #0x1
srshr	v27.8h, v19.8h, #0x1
trn1	v4.8h, v24.8h, v25.8h
trn2	v5.8h, v24.8h, v25.8h
trn1	v6.8h, v26.8h, v27.8h
trn2	v7.8h, v26.8h, v27.8h
trn1	v24.4s, v4.4s, v6.4s
trn2	v26.4s, v4.4s, v6.4s
trn1	v25.4s, v5.4s, v7.4s
trn2	v27.4s, v5.4s, v7.4s
mov	v28.d[0], v24.d[1]
mov	v29.d[0], v25.d[1]
mov	v30.d[0], v26.d[1]
mov	v31.d[0], v27.d[1]
b	L_38ac
L_388c:
movi	v24.4h, #0x0
movi	v25.4h, #0x0
movi	v26.4h, #0x0
movi	v27.4h, #0x0
movi	v28.4h, #0x0
movi	v29.4h, #0x0
movi	v30.4h, #0x0
movi	v31.4h, #0x0
L_38ac:
movi	v2.8h, #0x0
ld1	{ v16.8h }, [x2]
st1	{ v2.8h }, [x2], x11
ld1	{ v17.8h }, [x2]
st1	{ v2.8h }, [x2], x11
ld1	{ v18.8h }, [x2]
st1	{ v2.8h }, [x2], x11
ld1	{ v19.8h }, [x2]
st1	{ v2.8h }, [x2], x11
blr	x4
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
L_38e4:
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v6.8h, v18.8h, v19.8h
trn2	v7.8h, v18.8h, v19.8h
trn1	v16.4s, v4.4s, v6.4s
trn2	v18.4s, v4.4s, v6.4s
trn1	v17.4s, v5.4s, v7.4s
trn2	v19.4s, v5.4s, v7.4s
mov	v20.d[0], v16.d[1]
mov	v21.d[0], v17.d[1]
mov	v22.d[0], v18.d[1]
mov	v23.d[0], v19.d[1]
blr	x5
mov	x6, x0
ld1	{ v0.s }[0], [x6], x1
mov	v16.d[1], v17.d[0]
ld1	{ v0.s }[1], [x6], x1
ld1	{ v1.s }[0], [x6], x1
mov	v18.d[1], v19.d[0]
ld1	{ v1.s }[1], [x6], x1
ld1	{ v2.s }[0], [x6], x1
mov	v20.d[1], v21.d[0]
srshr	v16.8h, v16.8h, #0x4
ld1	{ v2.s }[1], [x6], x1
ld1	{ v3.s }[0], [x6], x1
mov	v22.d[1], v23.d[0]
srshr	v18.8h, v18.8h, #0x4
ld1	{ v3.s }[1], [x6], x1
uaddw	v16.8h, v16.8h, v0.8b
ld1	{ v4.s }[0], [x6], x1
mov	v24.d[1], v25.d[0]
srshr	v20.8h, v20.8h, #0x4
ld1	{ v4.s }[1], [x6], x1
uaddw	v18.8h, v18.8h, v1.8b
sqxtun	v0.8b, v16.8h
ld1	{ v5.s }[0], [x6], x1
mov	v26.d[1], v27.d[0]
srshr	v22.8h, v22.8h, #0x4
ld1	{ v5.s }[1], [x6], x1
uaddw	v20.8h, v20.8h, v2.8b
st1	{ v0.s }[0], [x0], x1
sqxtun	v1.8b, v18.8h
st1	{ v0.s }[1], [x0], x1
ld1	{ v6.s }[0], [x6], x1
mov	v28.d[1], v29.d[0]
srshr	v24.8h, v24.8h, #0x4
ld1	{ v6.s }[1], [x6], x1
uaddw	v22.8h, v22.8h, v3.8b
st1	{ v1.s }[0], [x0], x1
sqxtun	v2.8b, v20.8h
st1	{ v1.s }[1], [x0], x1
ld1	{ v7.s }[0], [x6], x1
mov	v30.d[1], v31.d[0]
srshr	v26.8h, v26.8h, #0x4
ld1	{ v7.s }[1], [x6], x1
uaddw	v24.8h, v24.8h, v4.8b
st1	{ v2.s }[0], [x0], x1
sqxtun	v3.8b, v22.8h
st1	{ v2.s }[1], [x0], x1
srshr	v28.8h, v28.8h, #0x4
uaddw	v26.8h, v26.8h, v5.8b
st1	{ v3.s }[0], [x0], x1
sqxtun	v4.8b, v24.8h
st1	{ v3.s }[1], [x0], x1
srshr	v30.8h, v30.8h, #0x4
uaddw	v28.8h, v28.8h, v6.8b
st1	{ v4.s }[0], [x0], x1
sqxtun	v5.8b, v26.8h
st1	{ v4.s }[1], [x0], x1
uaddw	v30.8h, v30.8h, v7.8b
st1	{ v5.s }[0], [x0], x1
sqxtun	v6.8b, v28.8h
st1	{ v5.s }[1], [x0], x1
st1	{ v6.s }[0], [x0], x1
sqxtun	v7.8b, v30.8h
st1	{ v6.s }[1], [x0], x1
st1	{ v7.s }[0], [x0], x1
st1	{ v7.s }[1], [x0], x1
ret	x15
inv_txfm_add_dct_dct_4x16_8bpc_neon:
cbnz	w3, L_3a4c
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x10
b	idct_dc_w4_neon
L_3a4c:
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_dct_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_identity_identity_4x16_8bpc_neon:
adr	x5, inv_identity_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_identity_add_4x16_neon
inv_txfm_add_dct_adst_4x16_8bpc_neon:
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_adst_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_dct_flipadst_4x16_8bpc_neon:
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_flipadst_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_dct_identity_4x16_8bpc_neon:
adr	x4, inv_dct_8h_x4_neon
adr	x5, inv_identity_4h_x16_neon
mov	w13, #0x8
b	inv_txfm_add_4x16_neon
inv_txfm_add_adst_dct_4x16_8bpc_neon:
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_dct_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_adst_adst_4x16_8bpc_neon:
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_adst_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_adst_flipadst_4x16_8bpc_neon:
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_flipadst_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_flipadst_dct_4x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_dct_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_flipadst_adst_4x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_adst_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_flipadst_flipadst_4x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_flipadst_4h_x16_neon
mov	w13, #0x1d
b	inv_txfm_add_4x16_neon
inv_txfm_add_identity_dct_4x16_8bpc_neon:
adr	x5, inv_dct_4h_x16_neon
mov	w13, #0x20
b	inv_txfm_identity_add_4x16_neon
inv_txfm_add_adst_identity_4x16_8bpc_neon:
adr	x4, inv_adst_8h_x4_neon
adr	x5, inv_identity_4h_x16_neon
mov	w13, #0x8
b	inv_txfm_add_4x16_neon
inv_txfm_add_flipadst_identity_4x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x4_neon
adr	x5, inv_identity_4h_x16_neon
mov	w13, #0x8
b	inv_txfm_add_4x16_neon
inv_txfm_add_identity_adst_4x16_8bpc_neon:
adr	x5, inv_adst_4h_x16_neon
mov	w13, #0x20
b	inv_txfm_identity_add_4x16_neon
inv_txfm_add_identity_flipadst_4x16_8bpc_neon:
adr	x5, inv_flipadst_4h_x16_neon
mov	w13, #0x20
b	inv_txfm_identity_add_4x16_neon
inv_txfm_add_dct_dct_16x4_8bpc_neon:
cbnz	w3, L_3b68
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x4
b	idct_dc_w16_neon
L_3b68:
adr	x4, inv_dct_4h_x16_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_identity_identity_16x4_8bpc_neon:
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_identity_add_16x4_neon
inv_txfm_add_dct_adst_16x4_8bpc_neon:
adr	x4, inv_dct_4h_x16_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_dct_flipadst_16x4_8bpc_neon:
adr	x4, inv_dct_4h_x16_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_dct_identity_16x4_8bpc_neon:
adr	x4, inv_dct_4h_x16_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_adst_dct_16x4_8bpc_neon:
adr	x4, inv_adst_4h_x16_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_adst_adst_16x4_8bpc_neon:
adr	x4, inv_adst_4h_x16_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_adst_flipadst_16x4_8bpc_neon:
adr	x4, inv_adst_4h_x16_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_flipadst_dct_16x4_8bpc_neon:
adr	x4, inv_flipadst_4h_x16_neon
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_flipadst_adst_16x4_8bpc_neon:
adr	x4, inv_flipadst_4h_x16_neon
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_flipadst_flipadst_16x4_8bpc_neon:
adr	x4, inv_flipadst_4h_x16_neon
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_identity_dct_16x4_8bpc_neon:
adr	x5, inv_dct_8h_x4_neon
b	inv_txfm_identity_add_16x4_neon
inv_txfm_add_adst_identity_16x4_8bpc_neon:
adr	x4, inv_adst_4h_x16_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_flipadst_identity_16x4_8bpc_neon:
adr	x4, inv_flipadst_4h_x16_neon
adr	x5, inv_identity_8h_x4_neon
b	inv_txfm_add_16x4_neon
inv_txfm_add_identity_adst_16x4_8bpc_neon:
adr	x5, inv_adst_8h_x4_neon
b	inv_txfm_identity_add_16x4_neon
inv_txfm_add_identity_flipadst_16x4_8bpc_neon:
adr	x5, inv_flipadst_8h_x4_neon
b	inv_txfm_identity_add_16x4_neon
inv_txfm_identity_add_16x8_neon:
mov	x15, x30
movi	v4.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v17.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v18.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v19.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v20.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v21.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v22.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v23.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v24.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v25.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v26.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v27.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v28.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v29.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v30.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v31.8h }, [x2]
st1	{ v4.8h }, [x2], #16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
sqrdmulh	v24.8h, v24.8h, v0.h[0]
sqrdmulh	v25.8h, v25.8h, v0.h[0]
sqrdmulh	v26.8h, v26.8h, v0.h[0]
sqrdmulh	v27.8h, v27.8h, v0.h[0]
sqrdmulh	v28.8h, v28.8h, v0.h[0]
sqrdmulh	v29.8h, v29.8h, v0.h[0]
sqrdmulh	v30.8h, v30.8h, v0.h[0]
sqrdmulh	v31.8h, v31.8h, v0.h[0]
mov	w16, #0x6a10
dup	v0.4h, w16
sqrdmulh	v2.8h, v16.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v19.8h, v19.8h, v2.8h
sqrdmulh	v2.8h, v20.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v20.8h, v20.8h, v2.8h
sqrdmulh	v2.8h, v21.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v21.8h, v21.8h, v2.8h
sqrdmulh	v2.8h, v22.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v22.8h, v22.8h, v2.8h
sqrdmulh	v2.8h, v23.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v23.8h, v23.8h, v2.8h
sqrdmulh	v2.8h, v24.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v24.8h, v24.8h, v2.8h
sqrdmulh	v2.8h, v25.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v25.8h, v25.8h, v2.8h
sqrdmulh	v2.8h, v26.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v26.8h, v26.8h, v2.8h
sqrdmulh	v2.8h, v27.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v27.8h, v27.8h, v2.8h
sqrdmulh	v2.8h, v28.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v28.8h, v28.8h, v2.8h
sqrdmulh	v2.8h, v29.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v29.8h, v29.8h, v2.8h
sqrdmulh	v2.8h, v30.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v30.8h, v30.8h, v2.8h
sqrdmulh	v2.8h, v31.8h, v0.h[0]
srshr	v2.8h, v2.8h, #0x1
sqadd	v31.8h, v31.8h, v2.8h
b	L_403c
inv_txfm_identity_add_8x16_neon:
mov	x15, x30
movi	v4.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
mov	x11, #0x20
cmp	w3, w13
b.lt	L_3e98
add	x6, x2, #0x10
ld1	{ v24.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v25.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v26.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v27.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v28.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v29.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v30.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v31.8h }, [x6]
st1	{ v4.8h }, [x6], x11
sqrdmulh	v24.8h, v24.8h, v0.h[0]
sqrdmulh	v25.8h, v25.8h, v0.h[0]
sqrdmulh	v26.8h, v26.8h, v0.h[0]
sqrdmulh	v27.8h, v27.8h, v0.h[0]
sqrdmulh	v28.8h, v28.8h, v0.h[0]
sqrdmulh	v29.8h, v29.8h, v0.h[0]
sqrdmulh	v30.8h, v30.8h, v0.h[0]
sqrdmulh	v31.8h, v31.8h, v0.h[0]
trn1	v2.8h, v24.8h, v25.8h
trn2	v3.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v3.4s, v27.4s
trn2	v3.4s, v3.4s, v27.4s
trn1	v27.4s, v2.4s, v25.4s
trn2	v2.4s, v2.4s, v25.4s
trn1	v24.2d, v27.2d, v28.2d
trn2	v28.2d, v27.2d, v28.2d
trn1	v25.2d, v29.2d, v30.2d
trn2	v29.2d, v29.2d, v30.2d
trn2	v30.2d, v2.2d, v26.2d
trn1	v26.2d, v2.2d, v26.2d
trn1	v27.2d, v3.2d, v31.2d
trn2	v31.2d, v3.2d, v31.2d
b	L_3eb8
L_3e98:
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
L_3eb8:
movi	v4.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v17.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v18.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v19.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v20.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v21.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v22.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v23.8h }, [x2]
st1	{ v4.8h }, [x2], x11
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
b	L_4410
inv_txfm_add_16x8_neon:
mov	x15, x30
movi	v4.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v17.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v18.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v19.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v20.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v21.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v22.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v23.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v24.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v25.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v26.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v27.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v28.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v29.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v30.8h }, [x2]
st1	{ v4.8h }, [x2], #16
ld1	{ v31.8h }, [x2]
st1	{ v4.8h }, [x2], #16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
sqrdmulh	v24.8h, v24.8h, v0.h[0]
sqrdmulh	v25.8h, v25.8h, v0.h[0]
sqrdmulh	v26.8h, v26.8h, v0.h[0]
sqrdmulh	v27.8h, v27.8h, v0.h[0]
sqrdmulh	v28.8h, v28.8h, v0.h[0]
sqrdmulh	v29.8h, v29.8h, v0.h[0]
sqrdmulh	v30.8h, v30.8h, v0.h[0]
sqrdmulh	v31.8h, v31.8h, v0.h[0]
blr	x4
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
srshr	v20.8h, v20.8h, #0x1
srshr	v21.8h, v21.8h, #0x1
srshr	v22.8h, v22.8h, #0x1
srshr	v23.8h, v23.8h, #0x1
srshr	v24.8h, v24.8h, #0x1
srshr	v25.8h, v25.8h, #0x1
srshr	v26.8h, v26.8h, #0x1
srshr	v27.8h, v27.8h, #0x1
srshr	v28.8h, v28.8h, #0x1
srshr	v29.8h, v29.8h, #0x1
srshr	v30.8h, v30.8h, #0x1
srshr	v31.8h, v31.8h, #0x1
L_403c:
trn1	v2.8h, v16.8h, v17.8h
trn2	v3.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v3.4s, v19.4s
trn2	v3.4s, v3.4s, v19.4s
trn1	v19.4s, v2.4s, v17.4s
trn2	v2.4s, v2.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v2.2d, v18.2d
trn1	v18.2d, v2.2d, v18.2d
trn1	v19.2d, v3.2d, v23.2d
trn2	v23.2d, v3.2d, v23.2d
blr	x5
mov	x6, x0
mov	x7, x6
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x6], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x6], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x6], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x6], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x6], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x6], x1
st1	{ v3.8b }, [x6], x1
trn1	v2.8h, v24.8h, v25.8h
trn2	v3.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v3.4s, v27.4s
trn2	v3.4s, v3.4s, v27.4s
trn1	v27.4s, v2.4s, v25.4s
trn2	v2.4s, v2.4s, v25.4s
trn1	v16.2d, v27.2d, v28.2d
trn2	v20.2d, v27.2d, v28.2d
trn1	v17.2d, v29.2d, v30.2d
trn2	v21.2d, v29.2d, v30.2d
trn2	v22.2d, v2.2d, v26.2d
trn1	v18.2d, v2.2d, v26.2d
trn1	v19.2d, v3.2d, v31.2d
trn2	v23.2d, v3.2d, v31.2d
blr	x5
add	x0, x0, #0x8
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
ret	x15
inv_txfm_add_8x16_neon:
mov	x15, x30
movi	v4.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
mov	x11, #0x20
cmp	w3, w13
b.lt	L_4360
add	x6, x2, #0x10
ld1	{ v16.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v17.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v18.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v19.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v20.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v21.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v22.8h }, [x6]
st1	{ v4.8h }, [x6], x11
ld1	{ v23.8h }, [x6]
st1	{ v4.8h }, [x6], x11
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
blr	x4
srshr	v24.8h, v16.8h, #0x1
srshr	v25.8h, v17.8h, #0x1
srshr	v26.8h, v18.8h, #0x1
srshr	v27.8h, v19.8h, #0x1
srshr	v28.8h, v20.8h, #0x1
srshr	v29.8h, v21.8h, #0x1
srshr	v30.8h, v22.8h, #0x1
srshr	v31.8h, v23.8h, #0x1
trn1	v2.8h, v24.8h, v25.8h
trn2	v3.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v3.4s, v27.4s
trn2	v3.4s, v3.4s, v27.4s
trn1	v27.4s, v2.4s, v25.4s
trn2	v2.4s, v2.4s, v25.4s
trn1	v24.2d, v27.2d, v28.2d
trn2	v28.2d, v27.2d, v28.2d
trn1	v25.2d, v29.2d, v30.2d
trn2	v29.2d, v29.2d, v30.2d
trn2	v30.2d, v2.2d, v26.2d
trn1	v26.2d, v2.2d, v26.2d
trn1	v27.2d, v3.2d, v31.2d
trn2	v31.2d, v3.2d, v31.2d
b	L_4380
L_4360:
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
L_4380:
movi	v4.8h, #0x0
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v17.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v18.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v19.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v20.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v21.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v22.8h }, [x2]
st1	{ v4.8h }, [x2], x11
ld1	{ v23.8h }, [x2]
st1	{ v4.8h }, [x2], x11
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
blr	x4
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
srshr	v20.8h, v20.8h, #0x1
srshr	v21.8h, v21.8h, #0x1
srshr	v22.8h, v22.8h, #0x1
srshr	v23.8h, v23.8h, #0x1
L_4410:
trn1	v2.8h, v16.8h, v17.8h
trn2	v3.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v3.4s, v19.4s
trn2	v3.4s, v3.4s, v19.4s
trn1	v19.4s, v2.4s, v17.4s
trn2	v2.4s, v2.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v2.2d, v18.2d
trn1	v18.2d, v2.2d, v18.2d
trn1	v19.2d, v3.2d, v23.2d
trn2	v23.2d, v3.2d, v23.2d
blr	x5
mov	x6, x0
ld1	{ v2.8b }, [x6], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x6], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x6], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x6], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x6], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x6], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x6], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x6], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
ld1	{ v4.8b }, [x6], x1
srshr	v24.8h, v24.8h, #0x4
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
ld1	{ v5.8b }, [x6], x1
srshr	v25.8h, v25.8h, #0x4
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
ld1	{ v6.8b }, [x6], x1
srshr	v26.8h, v26.8h, #0x4
uaddw	v24.8h, v24.8h, v4.8b
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x6], x1
srshr	v27.8h, v27.8h, #0x4
uaddw	v25.8h, v25.8h, v5.8b
sqxtun	v4.8b, v24.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x6], x1
srshr	v28.8h, v28.8h, #0x4
uaddw	v26.8h, v26.8h, v6.8b
sqxtun	v5.8b, v25.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x6], x1
srshr	v29.8h, v29.8h, #0x4
uaddw	v27.8h, v27.8h, v7.8b
sqxtun	v6.8b, v26.8h
st1	{ v5.8b }, [x0], x1
ld1	{ v4.8b }, [x6], x1
srshr	v30.8h, v30.8h, #0x4
uaddw	v28.8h, v28.8h, v2.8b
sqxtun	v7.8b, v27.8h
st1	{ v6.8b }, [x0], x1
ld1	{ v5.8b }, [x6], x1
srshr	v31.8h, v31.8h, #0x4
uaddw	v29.8h, v29.8h, v3.8b
sqxtun	v2.8b, v28.8h
st1	{ v7.8b }, [x0], x1
uaddw	v30.8h, v30.8h, v4.8b
sqxtun	v3.8b, v29.8h
st1	{ v2.8b }, [x0], x1
uaddw	v31.8h, v31.8h, v5.8b
sqxtun	v4.8b, v30.8h
st1	{ v3.8b }, [x0], x1
sqxtun	v5.8b, v31.8h
st1	{ v4.8b }, [x0], x1
st1	{ v5.8b }, [x0], x1
ret	x15
inv_txfm_add_dct_dct_8x16_8bpc_neon:
cbnz	w3, L_45ec
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x10
b	idct_dc_w8_neon
L_45ec:
adr	x4, inv_dct_8h_x8_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_identity_identity_8x16_8bpc_neon:
adr	x5, inv_identity_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_identity_add_8x16_neon
inv_txfm_add_dct_adst_8x16_8bpc_neon:
adr	x4, inv_dct_8h_x8_neon
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_dct_flipadst_8x16_8bpc_neon:
adr	x4, inv_dct_8h_x8_neon
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_dct_identity_8x16_8bpc_neon:
adr	x4, inv_dct_8h_x8_neon
adr	x5, inv_identity_8h_x16_neon
mov	x13, #0x8
b	inv_txfm_add_8x16_neon
inv_txfm_add_adst_dct_8x16_8bpc_neon:
adr	x4, inv_adst_8h_x8_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_adst_adst_8x16_8bpc_neon:
adr	x4, inv_adst_8h_x8_neon
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_adst_flipadst_8x16_8bpc_neon:
adr	x4, inv_adst_8h_x8_neon
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_flipadst_dct_8x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x8_neon
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_flipadst_adst_8x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x8_neon
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_flipadst_flipadst_8x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x8_neon
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x2b
b	inv_txfm_add_8x16_neon
inv_txfm_add_identity_dct_8x16_8bpc_neon:
adr	x5, inv_dct_8h_x16_neon
mov	x13, #0x40
b	inv_txfm_identity_add_8x16_neon
inv_txfm_add_adst_identity_8x16_8bpc_neon:
adr	x4, inv_adst_8h_x8_neon
adr	x5, inv_identity_8h_x16_neon
mov	x13, #0x8
b	inv_txfm_add_8x16_neon
inv_txfm_add_flipadst_identity_8x16_8bpc_neon:
adr	x4, inv_flipadst_8h_x8_neon
adr	x5, inv_identity_8h_x16_neon
mov	x13, #0x8
b	inv_txfm_add_8x16_neon
inv_txfm_add_identity_adst_8x16_8bpc_neon:
adr	x5, inv_adst_8h_x16_neon
mov	x13, #0x40
b	inv_txfm_identity_add_8x16_neon
inv_txfm_add_identity_flipadst_8x16_8bpc_neon:
adr	x5, inv_flipadst_8h_x16_neon
mov	x13, #0x40
b	inv_txfm_identity_add_8x16_neon
inv_txfm_add_dct_dct_16x8_8bpc_neon:
cbnz	w3, L_470c
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x8
b	idct_dc_w16_neon
L_470c:
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_dct_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_identity_identity_16x8_8bpc_neon:
adr	x5, inv_identity_8h_x8_neon
b	inv_txfm_identity_add_16x8_neon
inv_txfm_add_dct_adst_16x8_8bpc_neon:
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_adst_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_dct_flipadst_16x8_8bpc_neon:
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_flipadst_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_dct_identity_16x8_8bpc_neon:
adr	x4, inv_dct_8h_x16_neon
adr	x5, inv_identity_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_adst_dct_16x8_8bpc_neon:
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_dct_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_adst_adst_16x8_8bpc_neon:
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_adst_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_adst_flipadst_16x8_8bpc_neon:
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_flipadst_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_flipadst_dct_16x8_8bpc_neon:
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_dct_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_flipadst_adst_16x8_8bpc_neon:
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_adst_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_flipadst_flipadst_16x8_8bpc_neon:
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_flipadst_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_identity_dct_16x8_8bpc_neon:
adr	x5, inv_dct_8h_x8_neon
b	inv_txfm_identity_add_16x8_neon
inv_txfm_add_adst_identity_16x8_8bpc_neon:
adr	x4, inv_adst_8h_x16_neon
adr	x5, inv_identity_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_flipadst_identity_16x8_8bpc_neon:
adr	x4, inv_flipadst_8h_x16_neon
adr	x5, inv_identity_8h_x8_neon
b	inv_txfm_add_16x8_neon
inv_txfm_add_identity_adst_16x8_8bpc_neon:
adr	x5, inv_adst_8h_x8_neon
b	inv_txfm_identity_add_16x8_neon
inv_txfm_add_identity_flipadst_16x8_8bpc_neon:
adr	x5, inv_flipadst_8h_x8_neon
b	inv_txfm_identity_add_16x8_neon
inv_dct32_odd_8h_x16_neon:
adrp	x16, idct_coeffs+32
add	x16, x16, :lo12:idct_coeffs+32
ld1	{ v0.8h, v1.8h }, [x16]
sub	x16, x16, #0x20
smull	v2.4s, v16.4h, v0.h[0]
smlsl	v2.4s, v31.4h, v0.h[1]
smull2	v3.4s, v16.8h, v0.h[0]
smlsl2	v3.4s, v31.8h, v0.h[1]
smull	v4.4s, v16.4h, v0.h[1]
smlal	v4.4s, v31.4h, v0.h[0]
smull2	v5.4s, v16.8h, v0.h[1]
smlal2	v5.4s, v31.8h, v0.h[0]
smull	v6.4s, v24.4h, v0.h[2]
smlsl	v6.4s, v23.4h, v0.h[3]
smull2	v7.4s, v24.8h, v0.h[2]
smlsl2	v7.4s, v23.8h, v0.h[3]
sqrshrn	v16.4h, v2.4s, #0xc
sqrshrn2	v16.8h, v3.4s, #0xc
sqrshrn	v31.4h, v4.4s, #0xc
sqrshrn2	v31.8h, v5.4s, #0xc
smull	v2.4s, v24.4h, v0.h[3]
smlal	v2.4s, v23.4h, v0.h[2]
smull2	v3.4s, v24.8h, v0.h[3]
smlal2	v3.4s, v23.8h, v0.h[2]
smull	v4.4s, v20.4h, v0.h[4]
smlsl	v4.4s, v27.4h, v0.h[5]
smull2	v5.4s, v20.8h, v0.h[4]
smlsl2	v5.4s, v27.8h, v0.h[5]
sqrshrn	v24.4h, v6.4s, #0xc
sqrshrn2	v24.8h, v7.4s, #0xc
sqrshrn	v23.4h, v2.4s, #0xc
sqrshrn2	v23.8h, v3.4s, #0xc
smull	v6.4s, v20.4h, v0.h[5]
smlal	v6.4s, v27.4h, v0.h[4]
smull2	v7.4s, v20.8h, v0.h[5]
smlal2	v7.4s, v27.8h, v0.h[4]
smull	v2.4s, v28.4h, v0.h[6]
smlsl	v2.4s, v19.4h, v0.h[7]
smull2	v3.4s, v28.8h, v0.h[6]
smlsl2	v3.4s, v19.8h, v0.h[7]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
smull	v4.4s, v28.4h, v0.h[7]
smlal	v4.4s, v19.4h, v0.h[6]
smull2	v5.4s, v28.8h, v0.h[7]
smlal2	v5.4s, v19.8h, v0.h[6]
smull	v6.4s, v18.4h, v1.h[0]
smlsl	v6.4s, v29.4h, v1.h[1]
smull2	v7.4s, v18.8h, v1.h[0]
smlsl2	v7.4s, v29.8h, v1.h[1]
sqrshrn	v28.4h, v2.4s, #0xc
sqrshrn2	v28.8h, v3.4s, #0xc
sqrshrn	v19.4h, v4.4s, #0xc
sqrshrn2	v19.8h, v5.4s, #0xc
smull	v2.4s, v18.4h, v1.h[1]
smlal	v2.4s, v29.4h, v1.h[0]
smull2	v3.4s, v18.8h, v1.h[1]
smlal2	v3.4s, v29.8h, v1.h[0]
smull	v4.4s, v26.4h, v1.h[2]
smlsl	v4.4s, v21.4h, v1.h[3]
smull2	v5.4s, v26.8h, v1.h[2]
smlsl2	v5.4s, v21.8h, v1.h[3]
sqrshrn	v18.4h, v6.4s, #0xc
sqrshrn2	v18.8h, v7.4s, #0xc
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn2	v29.8h, v3.4s, #0xc
smull	v6.4s, v26.4h, v1.h[3]
smlal	v6.4s, v21.4h, v1.h[2]
smull2	v7.4s, v26.8h, v1.h[3]
smlal2	v7.4s, v21.8h, v1.h[2]
smull	v2.4s, v22.4h, v1.h[4]
smlsl	v2.4s, v25.4h, v1.h[5]
smull2	v3.4s, v22.8h, v1.h[4]
smlsl2	v3.4s, v25.8h, v1.h[5]
sqrshrn	v26.4h, v4.4s, #0xc
sqrshrn2	v26.8h, v5.4s, #0xc
sqrshrn	v21.4h, v6.4s, #0xc
sqrshrn2	v21.8h, v7.4s, #0xc
smull	v4.4s, v22.4h, v1.h[5]
smlal	v4.4s, v25.4h, v1.h[4]
smull2	v5.4s, v22.8h, v1.h[5]
smlal2	v5.4s, v25.8h, v1.h[4]
smull	v6.4s, v30.4h, v1.h[6]
smlsl	v6.4s, v17.4h, v1.h[7]
smull2	v7.4s, v30.8h, v1.h[6]
smlsl2	v7.4s, v17.8h, v1.h[7]
sqrshrn	v22.4h, v2.4s, #0xc
sqrshrn2	v22.8h, v3.4s, #0xc
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn2	v25.8h, v5.4s, #0xc
smull	v2.4s, v30.4h, v1.h[7]
smlal	v2.4s, v17.4h, v1.h[6]
smull2	v3.4s, v30.8h, v1.h[7]
smlal2	v3.4s, v17.8h, v1.h[6]
sqrshrn	v30.4h, v6.4s, #0xc
sqrshrn2	v30.8h, v7.4s, #0xc
sqrshrn	v17.4h, v2.4s, #0xc
sqrshrn2	v17.8h, v3.4s, #0xc
ld1	{ v0.8h }, [x16]
sqsub	v2.8h, v16.8h, v24.8h
sqadd	v16.8h, v16.8h, v24.8h
sqsub	v3.8h, v31.8h, v23.8h
sqadd	v31.8h, v31.8h, v23.8h
sqsub	v24.8h, v28.8h, v20.8h
sqadd	v28.8h, v28.8h, v20.8h
sqadd	v23.8h, v18.8h, v26.8h
sqsub	v18.8h, v18.8h, v26.8h
sqsub	v20.8h, v30.8h, v22.8h
sqadd	v30.8h, v30.8h, v22.8h
sqadd	v26.8h, v17.8h, v25.8h
sqsub	v17.8h, v17.8h, v25.8h
sqsub	v22.8h, v29.8h, v21.8h
sqadd	v29.8h, v29.8h, v21.8h
sqadd	v25.8h, v19.8h, v27.8h
sqsub	v19.8h, v19.8h, v27.8h
smull	v4.4s, v3.4h, v0.h[4]
smlsl	v4.4s, v2.4h, v0.h[5]
smull2	v5.4s, v3.8h, v0.h[4]
smlsl2	v5.4s, v2.8h, v0.h[5]
smull	v6.4s, v3.4h, v0.h[5]
smlal	v6.4s, v2.4h, v0.h[4]
smull2	v7.4s, v3.8h, v0.h[5]
smlal2	v7.4s, v2.8h, v0.h[4]
smull	v2.4s, v19.4h, v0.h[5]
smlal	v2.4s, v24.4h, v0.h[4]
smull2	v3.4s, v19.8h, v0.h[5]
smlal2	v3.4s, v24.8h, v0.h[4]
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn2	v21.8h, v5.4s, #0xc
sqrshrn	v27.4h, v6.4s, #0xc
sqrshrn2	v27.8h, v7.4s, #0xc
neg	v2.4s, v2.4s
neg	v3.4s, v3.4s
smull	v4.4s, v19.4h, v0.h[4]
smlsl	v4.4s, v24.4h, v0.h[5]
smull2	v5.4s, v19.8h, v0.h[4]
smlsl2	v5.4s, v24.8h, v0.h[5]
smull	v6.4s, v22.4h, v0.h[6]
smlsl	v6.4s, v18.4h, v0.h[7]
smull2	v7.4s, v22.8h, v0.h[6]
smlsl2	v7.4s, v18.8h, v0.h[7]
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn2	v19.8h, v3.4s, #0xc
sqrshrn	v24.4h, v4.4s, #0xc
sqrshrn2	v24.8h, v5.4s, #0xc
smull	v2.4s, v22.4h, v0.h[7]
smlal	v2.4s, v18.4h, v0.h[6]
smull2	v3.4s, v22.8h, v0.h[7]
smlal2	v3.4s, v18.8h, v0.h[6]
smull	v4.4s, v17.4h, v0.h[7]
smlal	v4.4s, v20.4h, v0.h[6]
smull2	v5.4s, v17.8h, v0.h[7]
smlal2	v5.4s, v20.8h, v0.h[6]
sqrshrn	v22.4h, v6.4s, #0xc
sqrshrn2	v22.8h, v7.4s, #0xc
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn2	v18.8h, v3.4s, #0xc
neg	v4.4s, v4.4s
neg	v5.4s, v5.4s
smull	v6.4s, v17.4h, v0.h[6]
smlsl	v6.4s, v20.4h, v0.h[7]
smull2	v7.4s, v17.8h, v0.h[6]
smlsl2	v7.4s, v20.8h, v0.h[7]
sqrshrn	v17.4h, v4.4s, #0xc
sqrshrn2	v17.8h, v5.4s, #0xc
sqrshrn	v20.4h, v6.4s, #0xc
sqrshrn2	v20.8h, v7.4s, #0xc
sqsub	v2.8h, v27.8h, v24.8h
sqadd	v27.8h, v27.8h, v24.8h
sqsub	v3.8h, v21.8h, v19.8h
sqadd	v21.8h, v21.8h, v19.8h
sqsub	v24.8h, v16.8h, v28.8h
sqadd	v16.8h, v16.8h, v28.8h
sqsub	v19.8h, v30.8h, v23.8h
sqadd	v30.8h, v30.8h, v23.8h
sqsub	v28.8h, v17.8h, v22.8h
sqadd	v17.8h, v17.8h, v22.8h
sqadd	v23.8h, v26.8h, v29.8h
sqsub	v26.8h, v26.8h, v29.8h
sqadd	v22.8h, v20.8h, v18.8h
sqsub	v20.8h, v20.8h, v18.8h
sqsub	v29.8h, v31.8h, v25.8h
sqadd	v31.8h, v31.8h, v25.8h
smull	v4.4s, v2.4h, v0.h[2]
smlsl	v4.4s, v3.4h, v0.h[3]
smull2	v5.4s, v2.8h, v0.h[2]
smlsl2	v5.4s, v3.8h, v0.h[3]
smull	v6.4s, v2.4h, v0.h[3]
smlal	v6.4s, v3.4h, v0.h[2]
smull2	v7.4s, v2.8h, v0.h[3]
smlal2	v7.4s, v3.8h, v0.h[2]
smull	v2.4s, v29.4h, v0.h[2]
smlsl	v2.4s, v24.4h, v0.h[3]
smull2	v3.4s, v29.8h, v0.h[2]
smlsl2	v3.4s, v24.8h, v0.h[3]
sqrshrn	v18.4h, v4.4s, #0xc
sqrshrn2	v18.8h, v5.4s, #0xc
sqrshrn	v25.4h, v6.4s, #0xc
sqrshrn2	v25.8h, v7.4s, #0xc
smull	v4.4s, v29.4h, v0.h[3]
smlal	v4.4s, v24.4h, v0.h[2]
smull2	v5.4s, v29.8h, v0.h[3]
smlal2	v5.4s, v24.8h, v0.h[2]
smull	v6.4s, v26.4h, v0.h[3]
smlal	v6.4s, v19.4h, v0.h[2]
smull2	v7.4s, v26.8h, v0.h[3]
smlal2	v7.4s, v19.8h, v0.h[2]
sqrshrn	v29.4h, v2.4s, #0xc
sqrshrn2	v29.8h, v3.4s, #0xc
sqrshrn	v24.4h, v4.4s, #0xc
sqrshrn2	v24.8h, v5.4s, #0xc
neg	v6.4s, v6.4s
neg	v7.4s, v7.4s
smull	v2.4s, v26.4h, v0.h[2]
smlsl	v2.4s, v19.4h, v0.h[3]
smull2	v3.4s, v26.8h, v0.h[2]
smlsl2	v3.4s, v19.8h, v0.h[3]
smull	v4.4s, v20.4h, v0.h[3]
smlal	v4.4s, v28.4h, v0.h[2]
smull2	v5.4s, v20.8h, v0.h[3]
smlal2	v5.4s, v28.8h, v0.h[2]
sqrshrn	v26.4h, v6.4s, #0xc
sqrshrn2	v26.8h, v7.4s, #0xc
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn2	v19.8h, v3.4s, #0xc
neg	v4.4s, v4.4s
neg	v5.4s, v5.4s
smull	v6.4s, v20.4h, v0.h[2]
smlsl	v6.4s, v28.4h, v0.h[3]
smull2	v7.4s, v20.8h, v0.h[2]
smlsl2	v7.4s, v28.8h, v0.h[3]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v28.4h, v6.4s, #0xc
sqrshrn2	v28.8h, v7.4s, #0xc
sqsub	v2.8h, v16.8h, v30.8h
sqadd	v16.8h, v16.8h, v30.8h
sqsub	v3.8h, v31.8h, v23.8h
sqadd	v31.8h, v31.8h, v23.8h
sqsub	v23.8h, v21.8h, v17.8h
sqadd	v17.8h, v21.8h, v17.8h
sqadd	v30.8h, v27.8h, v22.8h
sqsub	v21.8h, v27.8h, v22.8h
sqsub	v27.8h, v18.8h, v20.8h
sqadd	v18.8h, v18.8h, v20.8h
sqadd	v4.8h, v29.8h, v26.8h
sqsub	v26.8h, v29.8h, v26.8h
sqadd	v29.8h, v25.8h, v28.8h
sqsub	v25.8h, v25.8h, v28.8h
sqadd	v28.8h, v24.8h, v19.8h
sqsub	v24.8h, v24.8h, v19.8h
mov	v19.16b, v4.16b
smull	v4.4s, v24.4h, v0.h[0]
smlsl	v4.4s, v26.4h, v0.h[0]
smull2	v5.4s, v24.8h, v0.h[0]
smlsl2	v5.4s, v26.8h, v0.h[0]
smull	v6.4s, v24.4h, v0.h[0]
smlal	v6.4s, v26.4h, v0.h[0]
smull2	v7.4s, v24.8h, v0.h[0]
smlal2	v7.4s, v26.8h, v0.h[0]
sqrshrn	v20.4h, v4.4s, #0xc
sqrshrn2	v20.8h, v5.4s, #0xc
sqrshrn	v22.4h, v6.4s, #0xc
sqrshrn2	v22.8h, v7.4s, #0xc
smull	v4.4s, v25.4h, v0.h[0]
smlal	v4.4s, v27.4h, v0.h[0]
smull2	v5.4s, v25.8h, v0.h[0]
smlal2	v5.4s, v27.8h, v0.h[0]
smull	v6.4s, v25.4h, v0.h[0]
smlsl	v6.4s, v27.4h, v0.h[0]
smull2	v7.4s, v25.8h, v0.h[0]
smlsl2	v7.4s, v27.8h, v0.h[0]
mov	v27.16b, v22.16b
sqrshrn	v26.4h, v4.4s, #0xc
sqrshrn2	v26.8h, v5.4s, #0xc
smull	v24.4s, v21.4h, v0.h[0]
smlsl	v24.4s, v23.4h, v0.h[0]
smull2	v25.4s, v21.8h, v0.h[0]
smlsl2	v25.4s, v23.8h, v0.h[0]
smull	v4.4s, v21.4h, v0.h[0]
smlal	v4.4s, v23.4h, v0.h[0]
smull2	v5.4s, v21.8h, v0.h[0]
smlal2	v5.4s, v23.8h, v0.h[0]
sqrshrn	v21.4h, v6.4s, #0xc
sqrshrn2	v21.8h, v7.4s, #0xc
sqrshrn	v22.4h, v24.4s, #0xc
sqrshrn2	v22.8h, v25.4s, #0xc
sqrshrn	v25.4h, v4.4s, #0xc
sqrshrn2	v25.8h, v5.4s, #0xc
smull	v4.4s, v3.4h, v0.h[0]
smlsl	v4.4s, v2.4h, v0.h[0]
smull2	v5.4s, v3.8h, v0.h[0]
smlsl2	v5.4s, v2.8h, v0.h[0]
smull	v6.4s, v3.4h, v0.h[0]
smlal	v6.4s, v2.4h, v0.h[0]
smull2	v7.4s, v3.8h, v0.h[0]
smlal2	v7.4s, v2.8h, v0.h[0]
sqrshrn	v23.4h, v4.4s, #0xc
sqrshrn2	v23.8h, v5.4s, #0xc
sqrshrn	v24.4h, v6.4s, #0xc
sqrshrn2	v24.8h, v7.4s, #0xc
ret
inv_txfm_horz_dct_32x8_neon:
mov	x14, x30
movi	v7.8h, #0x0
lsl	x8, x8, #1
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
bl	inv_dct_8h_x16_neon
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
trn1	v4.8h, v24.8h, v25.8h
trn2	v5.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v5.4s, v27.4s
trn2	v5.4s, v5.4s, v27.4s
trn1	v27.4s, v4.4s, v25.4s
trn2	v4.4s, v4.4s, v25.4s
trn1	v24.2d, v27.2d, v28.2d
trn2	v28.2d, v27.2d, v28.2d
trn1	v25.2d, v29.2d, v30.2d
trn2	v29.2d, v29.2d, v30.2d
trn2	v30.2d, v4.2d, v26.2d
trn1	v26.2d, v4.2d, v26.2d
trn1	v27.2d, v5.2d, v31.2d
trn2	v31.2d, v5.2d, v31.2d
st1	{ v16.8h }, [x6], #16
st1	{ v24.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v17.8h }, [x6], #16
st1	{ v25.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v18.8h }, [x6], #16
st1	{ v26.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v19.8h }, [x6], #16
st1	{ v27.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v20.8h }, [x6], #16
st1	{ v28.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v21.8h }, [x6], #16
st1	{ v29.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v22.8h }, [x6], #16
st1	{ v30.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v23.8h }, [x6], #16
st1	{ v31.8h }, [x6], #16
add	x6, x6, #0x20
sub	x6, x6, #0x200
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
bl	inv_dct32_odd_8h_x16_neon
trn1	v4.8h, v31.8h, v30.8h
trn2	v5.8h, v31.8h, v30.8h
trn1	v30.8h, v29.8h, v28.8h
trn2	v28.8h, v29.8h, v28.8h
trn1	v31.8h, v27.8h, v26.8h
trn2	v26.8h, v27.8h, v26.8h
trn1	v29.8h, v25.8h, v24.8h
trn2	v24.8h, v25.8h, v24.8h
trn1	v27.4s, v31.4s, v29.4s
trn2	v29.4s, v31.4s, v29.4s
trn1	v25.4s, v26.4s, v24.4s
trn2	v24.4s, v26.4s, v24.4s
trn1	v26.4s, v5.4s, v28.4s
trn2	v5.4s, v5.4s, v28.4s
trn1	v28.4s, v4.4s, v30.4s
trn2	v4.4s, v4.4s, v30.4s
trn1	v31.2d, v28.2d, v27.2d
trn2	v27.2d, v28.2d, v27.2d
trn1	v30.2d, v26.2d, v25.2d
trn2	v26.2d, v26.2d, v25.2d
trn2	v25.2d, v4.2d, v29.2d
trn1	v29.2d, v4.2d, v29.2d
trn1	v28.2d, v5.2d, v24.2d
trn2	v24.2d, v5.2d, v24.2d
trn1	v4.8h, v23.8h, v22.8h
trn2	v5.8h, v23.8h, v22.8h
trn1	v22.8h, v21.8h, v20.8h
trn2	v20.8h, v21.8h, v20.8h
trn1	v23.8h, v19.8h, v18.8h
trn2	v18.8h, v19.8h, v18.8h
trn1	v21.8h, v17.8h, v16.8h
trn2	v16.8h, v17.8h, v16.8h
trn1	v19.4s, v23.4s, v21.4s
trn2	v21.4s, v23.4s, v21.4s
trn1	v17.4s, v18.4s, v16.4s
trn2	v16.4s, v18.4s, v16.4s
trn1	v18.4s, v5.4s, v20.4s
trn2	v5.4s, v5.4s, v20.4s
trn1	v20.4s, v4.4s, v22.4s
trn2	v4.4s, v4.4s, v22.4s
trn1	v23.2d, v20.2d, v19.2d
trn2	v19.2d, v20.2d, v19.2d
trn1	v22.2d, v18.2d, v17.2d
trn2	v18.2d, v18.2d, v17.2d
trn2	v17.2d, v4.2d, v21.2d
trn1	v21.2d, v4.2d, v21.2d
trn1	v20.2d, v5.2d, v16.2d
trn2	v16.2d, v5.2d, v16.2d
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v31.8h
sqsub	v6.8h, v5.8h, v23.8h
sqadd	v4.8h, v4.8h, v31.8h
sqadd	v5.8h, v5.8h, v23.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v30.8h
sqsub	v6.8h, v5.8h, v22.8h
sqadd	v4.8h, v4.8h, v30.8h
sqadd	v5.8h, v5.8h, v22.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v29.8h
sqsub	v6.8h, v5.8h, v21.8h
sqadd	v4.8h, v4.8h, v29.8h
sqadd	v5.8h, v5.8h, v21.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v28.8h
sqsub	v6.8h, v5.8h, v20.8h
sqadd	v4.8h, v4.8h, v28.8h
sqadd	v5.8h, v5.8h, v20.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v27.8h
sqsub	v6.8h, v5.8h, v19.8h
sqadd	v4.8h, v4.8h, v27.8h
sqadd	v5.8h, v5.8h, v19.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v26.8h
sqsub	v6.8h, v5.8h, v18.8h
sqadd	v4.8h, v4.8h, v26.8h
sqadd	v5.8h, v5.8h, v18.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v25.8h
sqsub	v6.8h, v5.8h, v17.8h
sqadd	v4.8h, v4.8h, v25.8h
sqadd	v5.8h, v5.8h, v17.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v24.8h
sqsub	v6.8h, v5.8h, v16.8h
sqadd	v4.8h, v4.8h, v24.8h
sqadd	v5.8h, v5.8h, v16.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x2
srshr	v5.8h, v5.8h, #0x2
srshr	v6.8h, v6.8h, #0x2
srshr	v7.8h, v7.8h, #0x2
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ret	x14
inv_txfm_horz_scale_dct_32x8_neon:
mov	x14, x30
movi	v7.8h, #0x0
lsl	x8, x8, #1
mov	w16, #0x5a80
dup	v0.4h, w16
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
sqrdmulh	v24.8h, v24.8h, v0.h[0]
sqrdmulh	v25.8h, v25.8h, v0.h[0]
sqrdmulh	v26.8h, v26.8h, v0.h[0]
sqrdmulh	v27.8h, v27.8h, v0.h[0]
sqrdmulh	v28.8h, v28.8h, v0.h[0]
sqrdmulh	v29.8h, v29.8h, v0.h[0]
sqrdmulh	v30.8h, v30.8h, v0.h[0]
sqrdmulh	v31.8h, v31.8h, v0.h[0]
bl	inv_dct_8h_x16_neon
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
trn1	v4.8h, v24.8h, v25.8h
trn2	v5.8h, v24.8h, v25.8h
trn1	v25.8h, v26.8h, v27.8h
trn2	v27.8h, v26.8h, v27.8h
trn1	v24.8h, v28.8h, v29.8h
trn2	v29.8h, v28.8h, v29.8h
trn1	v26.8h, v30.8h, v31.8h
trn2	v31.8h, v30.8h, v31.8h
trn1	v28.4s, v24.4s, v26.4s
trn2	v26.4s, v24.4s, v26.4s
trn1	v30.4s, v29.4s, v31.4s
trn2	v31.4s, v29.4s, v31.4s
trn1	v29.4s, v5.4s, v27.4s
trn2	v5.4s, v5.4s, v27.4s
trn1	v27.4s, v4.4s, v25.4s
trn2	v4.4s, v4.4s, v25.4s
trn1	v24.2d, v27.2d, v28.2d
trn2	v28.2d, v27.2d, v28.2d
trn1	v25.2d, v29.2d, v30.2d
trn2	v29.2d, v29.2d, v30.2d
trn2	v30.2d, v4.2d, v26.2d
trn1	v26.2d, v4.2d, v26.2d
trn1	v27.2d, v5.2d, v31.2d
trn2	v31.2d, v5.2d, v31.2d
st1	{ v16.8h }, [x6], #16
st1	{ v24.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v17.8h }, [x6], #16
st1	{ v25.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v18.8h }, [x6], #16
st1	{ v26.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v19.8h }, [x6], #16
st1	{ v27.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v20.8h }, [x6], #16
st1	{ v28.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v21.8h }, [x6], #16
st1	{ v29.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v22.8h }, [x6], #16
st1	{ v30.8h }, [x6], #16
add	x6, x6, #0x20
st1	{ v23.8h }, [x6], #16
st1	{ v31.8h }, [x6], #16
add	x6, x6, #0x20
sub	x6, x6, #0x200
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v24.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v25.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v26.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v27.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v28.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v29.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v30.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v31.8h }, [x7]
st1	{ v7.8h }, [x7], x8
sqrdmulh	v16.8h, v16.8h, v0.h[1]
sqrdmulh	v17.8h, v17.8h, v0.h[1]
sqrdmulh	v18.8h, v18.8h, v0.h[1]
sqrdmulh	v19.8h, v19.8h, v0.h[1]
sqrdmulh	v20.8h, v20.8h, v0.h[1]
sqrdmulh	v21.8h, v21.8h, v0.h[1]
sqrdmulh	v22.8h, v22.8h, v0.h[1]
sqrdmulh	v23.8h, v23.8h, v0.h[1]
sqrdmulh	v24.8h, v24.8h, v0.h[1]
sqrdmulh	v25.8h, v25.8h, v0.h[1]
sqrdmulh	v26.8h, v26.8h, v0.h[1]
sqrdmulh	v27.8h, v27.8h, v0.h[1]
sqrdmulh	v28.8h, v28.8h, v0.h[1]
sqrdmulh	v29.8h, v29.8h, v0.h[1]
sqrdmulh	v30.8h, v30.8h, v0.h[1]
sqrdmulh	v31.8h, v31.8h, v0.h[1]
bl	inv_dct32_odd_8h_x16_neon
trn1	v4.8h, v31.8h, v30.8h
trn2	v5.8h, v31.8h, v30.8h
trn1	v30.8h, v29.8h, v28.8h
trn2	v28.8h, v29.8h, v28.8h
trn1	v31.8h, v27.8h, v26.8h
trn2	v26.8h, v27.8h, v26.8h
trn1	v29.8h, v25.8h, v24.8h
trn2	v24.8h, v25.8h, v24.8h
trn1	v27.4s, v31.4s, v29.4s
trn2	v29.4s, v31.4s, v29.4s
trn1	v25.4s, v26.4s, v24.4s
trn2	v24.4s, v26.4s, v24.4s
trn1	v26.4s, v5.4s, v28.4s
trn2	v5.4s, v5.4s, v28.4s
trn1	v28.4s, v4.4s, v30.4s
trn2	v4.4s, v4.4s, v30.4s
trn1	v31.2d, v28.2d, v27.2d
trn2	v27.2d, v28.2d, v27.2d
trn1	v30.2d, v26.2d, v25.2d
trn2	v26.2d, v26.2d, v25.2d
trn2	v25.2d, v4.2d, v29.2d
trn1	v29.2d, v4.2d, v29.2d
trn1	v28.2d, v5.2d, v24.2d
trn2	v24.2d, v5.2d, v24.2d
trn1	v4.8h, v23.8h, v22.8h
trn2	v5.8h, v23.8h, v22.8h
trn1	v22.8h, v21.8h, v20.8h
trn2	v20.8h, v21.8h, v20.8h
trn1	v23.8h, v19.8h, v18.8h
trn2	v18.8h, v19.8h, v18.8h
trn1	v21.8h, v17.8h, v16.8h
trn2	v16.8h, v17.8h, v16.8h
trn1	v19.4s, v23.4s, v21.4s
trn2	v21.4s, v23.4s, v21.4s
trn1	v17.4s, v18.4s, v16.4s
trn2	v16.4s, v18.4s, v16.4s
trn1	v18.4s, v5.4s, v20.4s
trn2	v5.4s, v5.4s, v20.4s
trn1	v20.4s, v4.4s, v22.4s
trn2	v4.4s, v4.4s, v22.4s
trn1	v23.2d, v20.2d, v19.2d
trn2	v19.2d, v20.2d, v19.2d
trn1	v22.2d, v18.2d, v17.2d
trn2	v18.2d, v18.2d, v17.2d
trn2	v17.2d, v4.2d, v21.2d
trn1	v21.2d, v4.2d, v21.2d
trn1	v20.2d, v5.2d, v16.2d
trn2	v16.2d, v5.2d, v16.2d
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v31.8h
sqsub	v6.8h, v5.8h, v23.8h
sqadd	v4.8h, v4.8h, v31.8h
sqadd	v5.8h, v5.8h, v23.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v30.8h
sqsub	v6.8h, v5.8h, v22.8h
sqadd	v4.8h, v4.8h, v30.8h
sqadd	v5.8h, v5.8h, v22.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v29.8h
sqsub	v6.8h, v5.8h, v21.8h
sqadd	v4.8h, v4.8h, v29.8h
sqadd	v5.8h, v5.8h, v21.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v28.8h
sqsub	v6.8h, v5.8h, v20.8h
sqadd	v4.8h, v4.8h, v28.8h
sqadd	v5.8h, v5.8h, v20.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v27.8h
sqsub	v6.8h, v5.8h, v19.8h
sqadd	v4.8h, v4.8h, v27.8h
sqadd	v5.8h, v5.8h, v19.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v26.8h
sqsub	v6.8h, v5.8h, v18.8h
sqadd	v4.8h, v4.8h, v26.8h
sqadd	v5.8h, v5.8h, v18.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v25.8h
sqsub	v6.8h, v5.8h, v17.8h
sqadd	v4.8h, v4.8h, v25.8h
sqadd	v5.8h, v5.8h, v17.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ld1	{ v4.8h, v5.8h }, [x6]
sqsub	v7.8h, v4.8h, v24.8h
sqsub	v6.8h, v5.8h, v16.8h
sqadd	v4.8h, v4.8h, v24.8h
sqadd	v5.8h, v5.8h, v16.8h
rev64	v6.8h, v6.8h
rev64	v7.8h, v7.8h
srshr	v4.8h, v4.8h, #0x1
srshr	v5.8h, v5.8h, #0x1
srshr	v6.8h, v6.8h, #0x1
srshr	v7.8h, v7.8h, #0x1
ext	v6.16b, v6.16b, v6.16b, #0x8
st1	{ v4.8h, v5.8h }, [x6], #32
ext	v7.16b, v7.16b, v7.16b, #0x8
st1	{ v6.8h, v7.8h }, [x6], #32
ret	x14
inv_txfm_add_vert_dct_8x32_neon:
mov	x14, x30
lsl	x8, x8, #1
ld1	{ v16.8h }, [x7], x8
ld1	{ v17.8h }, [x7], x8
ld1	{ v18.8h }, [x7], x8
ld1	{ v19.8h }, [x7], x8
ld1	{ v20.8h }, [x7], x8
ld1	{ v21.8h }, [x7], x8
ld1	{ v22.8h }, [x7], x8
ld1	{ v23.8h }, [x7], x8
ld1	{ v24.8h }, [x7], x8
ld1	{ v25.8h }, [x7], x8
ld1	{ v26.8h }, [x7], x8
ld1	{ v27.8h }, [x7], x8
ld1	{ v28.8h }, [x7], x8
ld1	{ v29.8h }, [x7], x8
ld1	{ v30.8h }, [x7], x8
ld1	{ v31.8h }, [x7], x8
sub	x7, x7, x8, lsl #4
bl	inv_dct_8h_x16_neon
st1	{ v16.8h }, [x7], x8
st1	{ v17.8h }, [x7], x8
st1	{ v18.8h }, [x7], x8
st1	{ v19.8h }, [x7], x8
st1	{ v20.8h }, [x7], x8
st1	{ v21.8h }, [x7], x8
st1	{ v22.8h }, [x7], x8
st1	{ v23.8h }, [x7], x8
st1	{ v24.8h }, [x7], x8
st1	{ v25.8h }, [x7], x8
st1	{ v26.8h }, [x7], x8
st1	{ v27.8h }, [x7], x8
st1	{ v28.8h }, [x7], x8
st1	{ v29.8h }, [x7], x8
st1	{ v30.8h }, [x7], x8
st1	{ v31.8h }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
ld1	{ v16.8h }, [x7], x8
ld1	{ v17.8h }, [x7], x8
ld1	{ v18.8h }, [x7], x8
ld1	{ v19.8h }, [x7], x8
ld1	{ v20.8h }, [x7], x8
ld1	{ v21.8h }, [x7], x8
ld1	{ v22.8h }, [x7], x8
ld1	{ v23.8h }, [x7], x8
ld1	{ v24.8h }, [x7], x8
ld1	{ v25.8h }, [x7], x8
ld1	{ v26.8h }, [x7], x8
ld1	{ v27.8h }, [x7], x8
ld1	{ v28.8h }, [x7], x8
ld1	{ v29.8h }, [x7], x8
ld1	{ v30.8h }, [x7], x8
ld1	{ v31.8h }, [x7], x8
sub	x7, x7, x8, lsl #4
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_8h_x16_neon
neg	x9, x8
mov	x10, x6
ld1	{ v5.8h }, [x7], x8
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x8
ld1	{ v3.8b }, [x10], x1
sqadd	v5.8h, v5.8h, v31.8h
ld1	{ v7.8h }, [x7], x8
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqadd	v6.8h, v6.8h, v30.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqadd	v7.8h, v7.8h, v29.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x8
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqadd	v5.8h, v5.8h, v28.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v5.8h }, [x7], x8
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x8
ld1	{ v3.8b }, [x10], x1
sqadd	v5.8h, v5.8h, v27.8h
ld1	{ v7.8h }, [x7], x8
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqadd	v6.8h, v6.8h, v26.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqadd	v7.8h, v7.8h, v25.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x8
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqadd	v5.8h, v5.8h, v24.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v5.8h }, [x7], x8
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x8
ld1	{ v3.8b }, [x10], x1
sqadd	v5.8h, v5.8h, v23.8h
ld1	{ v7.8h }, [x7], x8
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqadd	v6.8h, v6.8h, v22.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqadd	v7.8h, v7.8h, v21.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x8
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqadd	v5.8h, v5.8h, v20.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v5.8h }, [x7], x8
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x8
ld1	{ v3.8b }, [x10], x1
sqadd	v5.8h, v5.8h, v19.8h
ld1	{ v7.8h }, [x7], x8
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqadd	v6.8h, v6.8h, v18.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqadd	v7.8h, v7.8h, v17.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x8
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqadd	v5.8h, v5.8h, v16.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
sub	x7, x7, x8
ld1	{ v5.8h }, [x7], x9
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x9
ld1	{ v3.8b }, [x10], x1
sqsub	v5.8h, v5.8h, v16.8h
ld1	{ v7.8h }, [x7], x9
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqsub	v6.8h, v6.8h, v17.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqsub	v7.8h, v7.8h, v18.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x9
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqsub	v5.8h, v5.8h, v19.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v5.8h }, [x7], x9
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x9
ld1	{ v3.8b }, [x10], x1
sqsub	v5.8h, v5.8h, v20.8h
ld1	{ v7.8h }, [x7], x9
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqsub	v6.8h, v6.8h, v21.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqsub	v7.8h, v7.8h, v22.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x9
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqsub	v5.8h, v5.8h, v23.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v5.8h }, [x7], x9
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x9
ld1	{ v3.8b }, [x10], x1
sqsub	v5.8h, v5.8h, v24.8h
ld1	{ v7.8h }, [x7], x9
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqsub	v6.8h, v6.8h, v25.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqsub	v7.8h, v7.8h, v26.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x9
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqsub	v5.8h, v5.8h, v27.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v5.8h }, [x7], x9
ld1	{ v2.8b }, [x10], x1
ld1	{ v6.8h }, [x7], x9
ld1	{ v3.8b }, [x10], x1
sqsub	v5.8h, v5.8h, v28.8h
ld1	{ v7.8h }, [x7], x9
ld1	{ v4.8b }, [x10], x1
srshr	v5.8h, v5.8h, #0x4
sqsub	v6.8h, v6.8h, v29.8h
uaddw	v5.8h, v5.8h, v2.8b
srshr	v6.8h, v6.8h, #0x4
sqsub	v7.8h, v7.8h, v30.8h
sqxtun	v2.8b, v5.8h
ld1	{ v5.8h }, [x7], x9
uaddw	v6.8h, v6.8h, v3.8b
srshr	v7.8h, v7.8h, #0x4
sqsub	v5.8h, v5.8h, v31.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v2.8b }, [x10], x1
sqxtun	v3.8b, v6.8h
uaddw	v7.8h, v7.8h, v4.8b
srshr	v5.8h, v5.8h, #0x4
st1	{ v3.8b }, [x6], x1
sqxtun	v4.8b, v7.8h
uaddw	v5.8h, v5.8h, v2.8b
st1	{ v4.8b }, [x6], x1
sqxtun	v2.8b, v5.8h
st1	{ v2.8b }, [x6], x1
ret	x14
inv_txfm_add_identity_identity_32x32_8bpc_neon:
movi	v0.8h, #0x0
adrp	x13, eob_32x32
add	x13, x13, :lo12:eob_32x32
mov	x8, #0x40
L_5b58:
mov	w9, #0x0
adrp	x12, eob_32x32
add	x12, x12, :lo12:eob_32x32
L_5b64:
add	w9, w9, #0x8
ld1	{ v16.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v17.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v18.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v19.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v20.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v21.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v22.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v23.8h }, [x2]
st1	{ v0.8h }, [x2], x8
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x2
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x2
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x2
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x2
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x2
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x2
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x2
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x2
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
ldrh	w11, [x12], #0x2
sub	x0, x0, x1, lsl #3
add	x0, x0, #0x8
cmp	w3, w11
b.ge	L_5b64
ldrh	w11, [x13], #0x2
cmp	w3, w11
b.lt	L_5ce0
sub	x0, x0, w9, uxtw
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #0x10
b	L_5b58
L_5ce0:
ret
inv_txfm_add_identity_identity_16x32_8bpc_neon:
mov	w16, #0x5a80
mov	w17, #0x6a10
dup	v1.4h, w16
movi	v0.8h, #0x0
mov	v1.h[1], w17
adrp	x13, eob_16x32
add	x13, x13, :lo12:eob_16x32
mov	x8, #0x40
L_5d04:
mov	w9, #0x0
adrp	x12, eob_16x32_shortside
add	x12, x12, :lo12:eob_16x32_shortside
L_5d10:
add	w9, w9, #0x8
ld1	{ v16.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v17.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v18.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v19.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v20.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v21.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v22.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v23.8h }, [x2]
st1	{ v0.8h }, [x2], x8
sqrdmulh	v16.8h, v16.8h, v1.h[0]
sqrdmulh	v17.8h, v17.8h, v1.h[0]
sqrdmulh	v18.8h, v18.8h, v1.h[0]
sqrdmulh	v19.8h, v19.8h, v1.h[0]
sqrdmulh	v20.8h, v20.8h, v1.h[0]
sqrdmulh	v21.8h, v21.8h, v1.h[0]
sqrdmulh	v22.8h, v22.8h, v1.h[0]
sqrdmulh	v23.8h, v23.8h, v1.h[0]
sqrdmulh	v2.8h, v16.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v19.8h, v19.8h, v2.8h
sqrdmulh	v2.8h, v20.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v20.8h, v20.8h, v2.8h
sqrdmulh	v2.8h, v21.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v21.8h, v21.8h, v2.8h
sqrdmulh	v2.8h, v22.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v22.8h, v22.8h, v2.8h
sqrdmulh	v2.8h, v23.8h, v1.h[1]
srshr	v2.8h, v2.8h, #0x1
sqadd	v23.8h, v23.8h, v2.8h
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x2
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x2
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x2
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x2
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x2
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x2
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x2
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x2
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
ldrh	w11, [x12], #0x2
sub	x0, x0, x1, lsl #3
add	x0, x0, #0x8
cmp	w3, w11
b.ge	L_5d10
ldrh	w11, [x13], #0x2
cmp	w3, w11
b.lt	L_5f0c
sub	x0, x0, w9, uxtw
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #0x10
b	L_5d04
L_5f0c:
ret
inv_txfm_add_identity_identity_32x16_8bpc_neon:
mov	w16, #0x5a80
mov	w17, #0x6a10
dup	v1.4h, w16
movi	v0.8h, #0x0
mov	v1.h[1], w17
adrp	x13, eob_16x32_shortside
add	x13, x13, :lo12:eob_16x32_shortside
mov	x8, #0x20
L_5f30:
mov	w9, #0x0
adrp	x12, eob_16x32
add	x12, x12, :lo12:eob_16x32
L_5f3c:
add	w9, w9, #0x8
ld1	{ v16.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v17.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v18.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v19.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v20.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v21.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v22.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v23.8h }, [x2]
st1	{ v0.8h }, [x2], x8
sqrdmulh	v16.8h, v16.8h, v1.h[0]
sqrdmulh	v17.8h, v17.8h, v1.h[0]
sqrdmulh	v18.8h, v18.8h, v1.h[0]
sqrdmulh	v19.8h, v19.8h, v1.h[0]
sqrdmulh	v20.8h, v20.8h, v1.h[0]
sqrdmulh	v21.8h, v21.8h, v1.h[0]
sqrdmulh	v22.8h, v22.8h, v1.h[0]
sqrdmulh	v23.8h, v23.8h, v1.h[0]
sqshl	v16.8h, v16.8h, #0x1
sqshl	v17.8h, v17.8h, #0x1
sqshl	v18.8h, v18.8h, #0x1
sqshl	v19.8h, v19.8h, #0x1
sqshl	v20.8h, v20.8h, #0x1
sqshl	v21.8h, v21.8h, #0x1
sqshl	v22.8h, v22.8h, #0x1
sqshl	v23.8h, v23.8h, #0x1
sqrdmulh	v2.8h, v16.8h, v1.h[1]
sqadd	v16.8h, v16.8h, v16.8h
sqadd	v16.8h, v16.8h, v2.8h
sqrdmulh	v2.8h, v17.8h, v1.h[1]
sqadd	v17.8h, v17.8h, v17.8h
sqadd	v17.8h, v17.8h, v2.8h
sqrdmulh	v2.8h, v18.8h, v1.h[1]
sqadd	v18.8h, v18.8h, v18.8h
sqadd	v18.8h, v18.8h, v2.8h
sqrdmulh	v2.8h, v19.8h, v1.h[1]
sqadd	v19.8h, v19.8h, v19.8h
sqadd	v19.8h, v19.8h, v2.8h
sqrdmulh	v2.8h, v20.8h, v1.h[1]
sqadd	v20.8h, v20.8h, v20.8h
sqadd	v20.8h, v20.8h, v2.8h
sqrdmulh	v2.8h, v21.8h, v1.h[1]
sqadd	v21.8h, v21.8h, v21.8h
sqadd	v21.8h, v21.8h, v2.8h
sqrdmulh	v2.8h, v22.8h, v1.h[1]
sqadd	v22.8h, v22.8h, v22.8h
sqadd	v22.8h, v22.8h, v2.8h
sqrdmulh	v2.8h, v23.8h, v1.h[1]
sqadd	v23.8h, v23.8h, v23.8h
sqadd	v23.8h, v23.8h, v2.8h
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
ldrh	w11, [x12], #0x2
sub	x0, x0, x1, lsl #3
add	x0, x0, #0x8
cmp	w3, w11
b.ge	L_5f3c
ldrh	w11, [x13], #0x2
cmp	w3, w11
b.lt	L_6158
sub	x0, x0, w9, uxtw
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #0x10
b	L_5f30
L_6158:
ret
inv_txfm_add_identity_identity_8x32_8bpc_neon:
movi	v0.8h, #0x0
adrp	x13, eob_8x32
add	x13, x13, :lo12:eob_8x32
mov	w8, #0x40
L_616c:
ldrh	w12, [x13], #0x2
ld1	{ v16.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v17.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v18.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v19.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v20.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v21.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v22.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v23.8h }, [x2]
st1	{ v0.8h }, [x2], x8
srshr	v16.8h, v16.8h, #0x1
srshr	v17.8h, v17.8h, #0x1
srshr	v18.8h, v18.8h, #0x1
srshr	v19.8h, v19.8h, #0x1
srshr	v20.8h, v20.8h, #0x1
srshr	v21.8h, v21.8h, #0x1
srshr	v22.8h, v22.8h, #0x1
srshr	v23.8h, v23.8h, #0x1
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
cmp	w3, w12
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x2
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x2
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x2
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x2
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x2
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x2
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x2
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x2
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
b.lt	L_62e8
sub	x2, x2, x8, lsl #3
add	x2, x2, #0x10
b	L_616c
L_62e8:
ret
inv_txfm_add_identity_identity_32x8_8bpc_neon:
movi	v0.8h, #0x0
adrp	x13, eob_8x32
add	x13, x13, :lo12:eob_8x32
mov	w8, #0x10
L_62fc:
ldrh	w12, [x13], #0x2
ld1	{ v16.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v17.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v18.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v19.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v20.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v21.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v22.8h }, [x2]
st1	{ v0.8h }, [x2], x8
ld1	{ v23.8h }, [x2]
st1	{ v0.8h }, [x2], x8
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
cmp	w3, w12
mov	x7, x0
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x3
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x3
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x3
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x3
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x3
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x0], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x3
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x0], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x3
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x0], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x3
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x0], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x0], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x0], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x0], x1
st1	{ v3.8b }, [x0], x1
b.lt	L_6458
sub	x0, x0, x1, lsl #3
add	x0, x0, #0x8
b	L_62fc
L_6458:
ret
inv_txfm_add_dct_dct_32x32_8bpc_neon:
cbnz	w3, L_6488
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x20
b	idct_dc_w32_neon
L_6488:
mov	x15, x30
sub	sp, sp, #0x800
adrp	x13, eob_32x32
add	x13, x13, :lo12:eob_32x32
ldrh	w12, [x13], #0x2
mov	x6, sp
add	x7, x2, #0x0
mov	x8, #0x40
bl	inv_txfm_horz_dct_32x8_neon
add	x6, sp, #0x200
mov	w8, #0x18
cmp	w3, w12
b.lt	L_650c
ldrh	w12, [x13], #0x2
add	x7, x2, #0x10
mov	x8, #0x40
bl	inv_txfm_horz_dct_32x8_neon
add	x6, sp, #0x400
mov	w8, #0x10
cmp	w3, w12
b.lt	L_650c
ldrh	w12, [x13], #0x2
add	x7, x2, #0x20
mov	x8, #0x40
bl	inv_txfm_horz_dct_32x8_neon
add	x6, sp, #0x600
mov	w8, #0x8
cmp	w3, w12
b.lt	L_650c
add	x7, x2, #0x30
mov	x8, #0x40
bl	inv_txfm_horz_dct_32x8_neon
b	L_6534
L_650c:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_651c:
subs	w8, w8, #0x4
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_651c
L_6534:
add	x6, x0, #0x0
mov	x7, sp
mov	x8, #0x40
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x8
add	x7, sp, #0x10
mov	x8, #0x40
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x10
add	x7, sp, #0x20
mov	x8, #0x40
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x18
add	x7, sp, #0x30
mov	x8, #0x40
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #0x800
ret	x15
inv_txfm_add_dct_dct_16x32_8bpc_neon:
cbnz	w3, L_65ac
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x20
b	idct_dc_w16_neon
L_65ac:
mov	x15, x30
sub	sp, sp, #0x400
adrp	x13, eob_16x32
add	x13, x13, :lo12:eob_16x32
ldrh	w12, [x13], #0x2
adr	x4, inv_dct_8h_x16_neon
mov	x6, sp
add	x7, x2, #0x0
mov	x8, #0x40
bl	inv_txfm_horz_scale_16x8_neon
add	x6, sp, #0x100
add	x7, x2, #0x10
mov	w8, #0x18
cmp	w3, w12
b.lt	L_6634
ldrh	w12, [x13], #0x2
mov	x8, #0x40
bl	inv_txfm_horz_scale_16x8_neon
add	x6, sp, #0x200
add	x7, x2, #0x20
mov	w8, #0x10
cmp	w3, w12
b.lt	L_6634
ldrh	w12, [x13], #0x2
mov	x8, #0x40
bl	inv_txfm_horz_scale_16x8_neon
add	x6, sp, #0x300
add	x7, x2, #0x30
mov	w8, #0x8
cmp	w3, w12
b.lt	L_6634
mov	x8, #0x40
bl	inv_txfm_horz_scale_16x8_neon
b	L_665c
L_6634:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_6644:
subs	w8, w8, #0x8
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_6644
L_665c:
add	x6, x0, #0x0
mov	x7, sp
mov	x8, #0x20
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x8
add	x7, sp, #0x10
mov	x8, #0x20
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #0x400
ret	x15
inv_txfm_add_dct_dct_32x16_8bpc_neon:
cbnz	w3, L_66b4
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x10
b	idct_dc_w32_neon
L_66b4:
mov	x15, x30
sub	sp, sp, #0x400
adr	x5, inv_dct_8h_x16_neon
mov	x6, sp
add	x7, x2, #0x0
mov	x8, #0x20
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, sp, #0x200
add	x7, x2, #0x10
mov	w8, #0x8
cmp	w3, #0x24
b.lt	L_66f0
mov	x8, #0x20
bl	inv_txfm_horz_scale_dct_32x8_neon
b	L_6718
L_66f0:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_6700:
subs	w8, w8, #0x4
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_6700
L_6718:
mov	x8, #0x40
add	x6, x0, #0x0
mov	x7, sp
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x8
add	x7, sp, #0x10
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x10
add	x7, sp, #0x20
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x18
add	x7, sp, #0x30
bl	inv_txfm_add_vert_8x16_neon
add	sp, sp, #0x400
ret	x15
inv_txfm_add_dct_dct_8x32_8bpc_neon:
cbnz	w3, L_6780
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x20
b	idct_dc_w8_neon
L_6780:
mov	x15, x30
sub	sp, sp, #0x200
adrp	x13, eob_8x32
add	x13, x13, :lo12:eob_8x32
movi	v28.8h, #0x0
mov	x8, #0x40
mov	w9, #0x20
mov	x6, sp
L_67a0:
ld1	{ v16.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v17.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v18.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v19.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v20.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v21.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v22.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ld1	{ v23.8h }, [x2]
st1	{ v28.8h }, [x2], x8
ldrh	w12, [x13], #0x2
sub	x2, x2, x8, lsl #3
sub	w9, w9, #0x8
add	x2, x2, #0x10
bl	inv_dct_8h_x8_neon
srshr	v16.8h, v16.8h, #0x2
srshr	v17.8h, v17.8h, #0x2
srshr	v18.8h, v18.8h, #0x2
srshr	v19.8h, v19.8h, #0x2
srshr	v20.8h, v20.8h, #0x2
srshr	v21.8h, v21.8h, #0x2
srshr	v22.8h, v22.8h, #0x2
srshr	v23.8h, v23.8h, #0x2
trn1	v24.8h, v16.8h, v17.8h
trn2	v25.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v25.4s, v19.4s
trn2	v25.4s, v25.4s, v19.4s
trn1	v19.4s, v24.4s, v17.4s
trn2	v24.4s, v24.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v24.2d, v18.2d
trn1	v18.2d, v24.2d, v18.2d
trn1	v19.2d, v25.2d, v23.2d
trn2	v23.2d, v25.2d, v23.2d
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x6], #64
cmp	w3, w12
st1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x6], #64
b.ge	L_67a0
cbz	w9, L_68a4
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
L_6894:
subs	w9, w9, #0x8
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x6], #64
st1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x6], #64
b.gt	L_6894
L_68a4:
mov	x6, x0
mov	x7, sp
mov	x8, #0x10
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #0x200
ret	x15
inv_txfm_add_dct_dct_32x8_8bpc_neon:
cbnz	w3, L_68e8
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x8
b	idct_dc_w32_neon
L_68e8:
mov	x15, x30
sub	sp, sp, #0x200
mov	x6, sp
mov	x7, x2
mov	x8, #0x10
bl	inv_txfm_horz_dct_32x8_neon
mov	x8, #0x40
mov	w9, #0x0
L_6908:
add	x6, x0, x9
add	x7, sp, x9, lsl #1
ld1	{ v16.8h }, [x7], x8
ld1	{ v17.8h }, [x7], x8
ld1	{ v18.8h }, [x7], x8
ld1	{ v19.8h }, [x7], x8
ld1	{ v20.8h }, [x7], x8
ld1	{ v21.8h }, [x7], x8
ld1	{ v22.8h }, [x7], x8
ld1	{ v23.8h }, [x7], x8
add	w9, w9, #0x8
bl	inv_dct_8h_x8_neon
cmp	w9, #0x20
mov	x7, x6
ld1	{ v2.8b }, [x7], x1
srshr	v16.8h, v16.8h, #0x4
ld1	{ v3.8b }, [x7], x1
srshr	v17.8h, v17.8h, #0x4
ld1	{ v4.8b }, [x7], x1
srshr	v18.8h, v18.8h, #0x4
uaddw	v16.8h, v16.8h, v2.8b
ld1	{ v5.8b }, [x7], x1
srshr	v19.8h, v19.8h, #0x4
uaddw	v17.8h, v17.8h, v3.8b
sqxtun	v2.8b, v16.8h
ld1	{ v6.8b }, [x7], x1
srshr	v20.8h, v20.8h, #0x4
uaddw	v18.8h, v18.8h, v4.8b
sqxtun	v3.8b, v17.8h
st1	{ v2.8b }, [x6], x1
ld1	{ v7.8b }, [x7], x1
srshr	v21.8h, v21.8h, #0x4
uaddw	v19.8h, v19.8h, v5.8b
sqxtun	v4.8b, v18.8h
st1	{ v3.8b }, [x6], x1
ld1	{ v2.8b }, [x7], x1
srshr	v22.8h, v22.8h, #0x4
uaddw	v20.8h, v20.8h, v6.8b
sqxtun	v5.8b, v19.8h
st1	{ v4.8b }, [x6], x1
ld1	{ v3.8b }, [x7], x1
srshr	v23.8h, v23.8h, #0x4
uaddw	v21.8h, v21.8h, v7.8b
sqxtun	v6.8b, v20.8h
st1	{ v5.8b }, [x6], x1
uaddw	v22.8h, v22.8h, v2.8b
sqxtun	v7.8b, v21.8h
st1	{ v6.8b }, [x6], x1
uaddw	v23.8h, v23.8h, v3.8b
sqxtun	v2.8b, v22.8h
st1	{ v7.8b }, [x6], x1
sqxtun	v3.8b, v23.8h
st1	{ v2.8b }, [x6], x1
st1	{ v3.8b }, [x6], x1
b.lt	L_6908
add	sp, sp, #0x200
ret	x15
inv_dct64_step1_neon:
ld1	{ v0.8h, v1.8h }, [x17], #32
sqrdmulh	v23.8h, v16.8h, v0.h[1]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v22.8h, v17.8h, v0.h[2]
sqrdmulh	v17.8h, v17.8h, v0.h[3]
sqrdmulh	v21.8h, v18.8h, v0.h[5]
sqrdmulh	v18.8h, v18.8h, v0.h[4]
sqrdmulh	v20.8h, v19.8h, v0.h[6]
sqrdmulh	v19.8h, v19.8h, v0.h[7]
sqadd	v24.8h, v16.8h, v17.8h
sqsub	v25.8h, v16.8h, v17.8h
sqsub	v26.8h, v19.8h, v18.8h
sqadd	v27.8h, v19.8h, v18.8h
sqadd	v28.8h, v20.8h, v21.8h
sqsub	v29.8h, v20.8h, v21.8h
sqsub	v30.8h, v23.8h, v22.8h
sqadd	v31.8h, v23.8h, v22.8h
smull	v2.4s, v29.4h, v1.h[0]
smlal	v2.4s, v26.4h, v1.h[1]
smull2	v3.4s, v29.8h, v1.h[0]
smlal2	v3.4s, v26.8h, v1.h[1]
smull	v4.4s, v29.4h, v1.h[1]
smlsl	v4.4s, v26.4h, v1.h[0]
smull2	v5.4s, v29.8h, v1.h[1]
smlsl2	v5.4s, v26.8h, v1.h[0]
neg	v2.4s, v2.4s
neg	v3.4s, v3.4s
smull	v6.4s, v30.4h, v1.h[1]
smlsl	v6.4s, v25.4h, v1.h[0]
smull2	v7.4s, v30.8h, v1.h[1]
smlsl2	v7.4s, v25.8h, v1.h[0]
sqrshrn	v26.4h, v2.4s, #0xc
sqrshrn2	v26.8h, v3.4s, #0xc
smull	v2.4s, v30.4h, v1.h[0]
smlal	v2.4s, v25.4h, v1.h[1]
smull2	v3.4s, v30.8h, v1.h[0]
smlal2	v3.4s, v25.8h, v1.h[1]
sqrshrn	v29.4h, v4.4s, #0xc
sqrshrn2	v29.8h, v5.4s, #0xc
sqrshrn	v25.4h, v6.4s, #0xc
sqrshrn2	v25.8h, v7.4s, #0xc
sqrshrn	v30.4h, v2.4s, #0xc
sqrshrn2	v30.8h, v3.4s, #0xc
sqadd	v16.8h, v24.8h, v27.8h
sqsub	v19.8h, v24.8h, v27.8h
sqadd	v17.8h, v25.8h, v26.8h
sqsub	v18.8h, v25.8h, v26.8h
sqsub	v20.8h, v31.8h, v28.8h
sqadd	v23.8h, v31.8h, v28.8h
sqsub	v21.8h, v30.8h, v29.8h
sqadd	v22.8h, v30.8h, v29.8h
smull	v2.4s, v21.4h, v1.h[2]
smlal	v2.4s, v18.4h, v1.h[3]
smull2	v3.4s, v21.8h, v1.h[2]
smlal2	v3.4s, v18.8h, v1.h[3]
smull	v4.4s, v21.4h, v1.h[3]
smlsl	v4.4s, v18.4h, v1.h[2]
smull2	v5.4s, v21.8h, v1.h[3]
smlsl2	v5.4s, v18.8h, v1.h[2]
smull	v6.4s, v20.4h, v1.h[2]
smlal	v6.4s, v19.4h, v1.h[3]
smull2	v7.4s, v20.8h, v1.h[2]
smlal2	v7.4s, v19.8h, v1.h[3]
sqrshrn	v21.4h, v2.4s, #0xc
sqrshrn2	v21.8h, v3.4s, #0xc
sqrshrn	v18.4h, v4.4s, #0xc
sqrshrn2	v18.8h, v5.4s, #0xc
smull	v2.4s, v20.4h, v1.h[3]
smlsl	v2.4s, v19.4h, v1.h[2]
smull2	v3.4s, v20.8h, v1.h[3]
smlsl2	v3.4s, v19.8h, v1.h[2]
sqrshrn	v20.4h, v6.4s, #0xc
sqrshrn2	v20.8h, v7.4s, #0xc
sqrshrn	v19.4h, v2.4s, #0xc
sqrshrn2	v19.8h, v3.4s, #0xc
st1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x6], #64
st1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x6], #64
ret
inv_dct64_step2_neon:
adrp	x16, idct_coeffs
add	x16, x16, :lo12:idct_coeffs
ld1	{ v0.4h }, [x16]
L_6b30:
ldr	q16, [x6]
ldr	q17, [x9, #0x80]
ldr	q18, [x9]
ldr	q19, [x6, #0x80]
ldr	q20, [x6, #0x100]
ldr	q21, [x9, #0x180]
ldr	q22, [x9, #0x100]
ldr	q23, [x6, #0x180]
sqadd	v24.8h, v16.8h, v17.8h
sqsub	v25.8h, v16.8h, v17.8h
sqadd	v26.8h, v18.8h, v19.8h
sqsub	v27.8h, v18.8h, v19.8h
sqsub	v28.8h, v21.8h, v20.8h
sqadd	v29.8h, v21.8h, v20.8h
sqadd	v30.8h, v23.8h, v22.8h
sqsub	v31.8h, v23.8h, v22.8h
smull	v2.4s, v27.4h, v0.h[3]
smlal	v2.4s, v25.4h, v0.h[2]
smull2	v3.4s, v27.8h, v0.h[3]
smlal2	v3.4s, v25.8h, v0.h[2]
smull	v4.4s, v27.4h, v0.h[2]
smlsl	v4.4s, v25.4h, v0.h[3]
smull2	v5.4s, v27.8h, v0.h[2]
smlsl2	v5.4s, v25.8h, v0.h[3]
smull	v6.4s, v31.4h, v0.h[3]
smlal	v6.4s, v28.4h, v0.h[2]
smull2	v7.4s, v31.8h, v0.h[3]
smlal2	v7.4s, v28.8h, v0.h[2]
sqrshrn	v25.4h, v2.4s, #0xc
sqrshrn2	v25.8h, v3.4s, #0xc
sqrshrn	v27.4h, v4.4s, #0xc
sqrshrn2	v27.8h, v5.4s, #0xc
neg	v6.4s, v6.4s
neg	v7.4s, v7.4s
smull	v2.4s, v31.4h, v0.h[2]
smlsl	v2.4s, v28.4h, v0.h[3]
smull2	v3.4s, v31.8h, v0.h[2]
smlsl2	v3.4s, v28.8h, v0.h[3]
sqrshrn	v31.4h, v6.4s, #0xc
sqrshrn2	v31.8h, v7.4s, #0xc
sqrshrn	v28.4h, v2.4s, #0xc
sqrshrn2	v28.8h, v3.4s, #0xc
sqadd	v16.8h, v24.8h, v29.8h
sqsub	v19.8h, v24.8h, v29.8h
sqadd	v17.8h, v27.8h, v31.8h
sqsub	v18.8h, v27.8h, v31.8h
sqsub	v20.8h, v26.8h, v30.8h
sqadd	v23.8h, v26.8h, v30.8h
sqsub	v21.8h, v25.8h, v28.8h
sqadd	v22.8h, v25.8h, v28.8h
smull	v2.4s, v21.4h, v0.h[0]
smlsl	v2.4s, v18.4h, v0.h[0]
smull2	v3.4s, v21.8h, v0.h[0]
smlsl2	v3.4s, v18.8h, v0.h[0]
smull	v4.4s, v21.4h, v0.h[0]
smlal	v4.4s, v18.4h, v0.h[0]
smull2	v5.4s, v21.8h, v0.h[0]
smlal2	v5.4s, v18.8h, v0.h[0]
smull	v6.4s, v20.4h, v0.h[0]
smlsl	v6.4s, v19.4h, v0.h[0]
smull2	v7.4s, v20.8h, v0.h[0]
smlsl2	v7.4s, v19.8h, v0.h[0]
sqrshrn	v18.4h, v2.4s, #0xc
sqrshrn2	v18.8h, v3.4s, #0xc
sqrshrn	v21.4h, v4.4s, #0xc
sqrshrn2	v21.8h, v5.4s, #0xc
smull	v2.4s, v20.4h, v0.h[0]
smlal	v2.4s, v19.4h, v0.h[0]
smull2	v3.4s, v20.8h, v0.h[0]
smlal2	v3.4s, v19.8h, v0.h[0]
sqrshrn	v19.4h, v6.4s, #0xc
sqrshrn2	v19.8h, v7.4s, #0xc
sqrshrn	v20.4h, v2.4s, #0xc
sqrshrn2	v20.8h, v3.4s, #0xc
str	q16, [x6]
str	q17, [x9]
str	q18, [x6, #0x80]
str	q19, [x9, #0x80]
str	q20, [x6, #0x100]
str	q21, [x9, #0x100]
str	q22, [x6, #0x180]
str	q23, [x9, #0x180]
add	x6, x6, #0x10
sub	x9, x9, #0x10
cmp	x6, x9
b.lt	L_6b30
ret
inv_txfm_dct_8h_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
ld1	{ v16.8h }, [x7], x8
ld1	{ v17.8h }, [x7], x8
ld1	{ v18.8h }, [x7], x8
ld1	{ v19.8h }, [x7], x8
ld1	{ v20.8h }, [x7], x8
ld1	{ v21.8h }, [x7], x8
ld1	{ v22.8h }, [x7], x8
ld1	{ v23.8h }, [x7], x8
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
bl	inv_dct_8h_x16_neon
st1	{ v16.8h }, [x6], #16
st1	{ v17.8h }, [x6], #16
st1	{ v18.8h }, [x6], #16
st1	{ v19.8h }, [x6], #16
st1	{ v20.8h }, [x6], #16
st1	{ v21.8h }, [x6], #16
st1	{ v22.8h }, [x6], #16
st1	{ v23.8h }, [x6], #16
st1	{ v24.8h }, [x6], #16
st1	{ v25.8h }, [x6], #16
st1	{ v26.8h }, [x6], #16
st1	{ v27.8h }, [x6], #16
st1	{ v28.8h }, [x6], #16
st1	{ v29.8h }, [x6], #16
st1	{ v30.8h }, [x6], #16
st1	{ v31.8h }, [x6], #16
ld1	{ v16.8h }, [x7], x8
ld1	{ v17.8h }, [x7], x8
ld1	{ v18.8h }, [x7], x8
ld1	{ v19.8h }, [x7], x8
ld1	{ v20.8h }, [x7], x8
ld1	{ v21.8h }, [x7], x8
ld1	{ v22.8h }, [x7], x8
ld1	{ v23.8h }, [x7], x8
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_8h_x16_neon
add	x10, x6, #0xf0
sub	x6, x6, #0x100
mov	x9, #-0x10
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v31.8h
sqsub	v31.8h, v2.8h, v31.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v30.8h
sqsub	v30.8h, v3.8h, v30.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v29.8h
sub	x6, x6, #0x40
sqsub	v29.8h, v4.8h, v29.8h
st1	{ v6.8h }, [x6], #16
st1	{ v31.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v28.8h
sqsub	v28.8h, v5.8h, v28.8h
st1	{ v7.8h }, [x6], #16
st1	{ v30.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v29.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v28.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v27.8h
sqsub	v27.8h, v2.8h, v27.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v26.8h
sqsub	v26.8h, v3.8h, v26.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v25.8h
sub	x6, x6, #0x40
sqsub	v25.8h, v4.8h, v25.8h
st1	{ v6.8h }, [x6], #16
st1	{ v27.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v24.8h
sqsub	v24.8h, v5.8h, v24.8h
st1	{ v7.8h }, [x6], #16
st1	{ v26.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v25.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v24.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v23.8h
sqsub	v23.8h, v2.8h, v23.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v22.8h
sqsub	v22.8h, v3.8h, v22.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v21.8h
sub	x6, x6, #0x40
sqsub	v21.8h, v4.8h, v21.8h
st1	{ v6.8h }, [x6], #16
st1	{ v23.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v20.8h
sqsub	v20.8h, v5.8h, v20.8h
st1	{ v7.8h }, [x6], #16
st1	{ v22.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v21.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v20.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v19.8h
sqsub	v19.8h, v2.8h, v19.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v18.8h
sqsub	v18.8h, v3.8h, v18.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v17.8h
sub	x6, x6, #0x40
sqsub	v17.8h, v4.8h, v17.8h
st1	{ v6.8h }, [x6], #16
st1	{ v19.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v16.8h
sqsub	v16.8h, v5.8h, v16.8h
st1	{ v7.8h }, [x6], #16
st1	{ v18.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v17.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v16.8h }, [x10], x9
add	x6, x6, #0x100
adrp	x17, idct64_coeffs
add	x17, x17, :lo12:idct64_coeffs
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1	{ v16.8h }, [x7]
ld1	{ v17.8h }, [x9]
ld1	{ v18.8h }, [x10]
ld1	{ v19.8h }, [x11]
bl	inv_dct64_step1_neon
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1	{ v16.8h }, [x10]
ld1	{ v17.8h }, [x11]
ld1	{ v18.8h }, [x9]
ld1	{ v19.8h }, [x7]
bl	inv_dct64_step1_neon
sub	x10, x10, x8, lsl #1
sub	x9, x9, x8, lsl #1
add	x7, x7, x8
add	x11, x11, x8
ldr	q16, [x10, x8]
ldr	q17, [x11]
ldr	q18, [x9, x8]
ldr	q19, [x7]
bl	inv_dct64_step1_neon
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
bl	inv_dct64_step1_neon
sub	x6, x6, #0x200
add	x9, x6, #0x70
bl	inv_dct64_step2_neon
ret	x14
inv_txfm_dct_clear_8h_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
bl	inv_dct_8h_x16_neon
st1	{ v16.8h }, [x6], #16
st1	{ v17.8h }, [x6], #16
st1	{ v18.8h }, [x6], #16
st1	{ v19.8h }, [x6], #16
st1	{ v20.8h }, [x6], #16
st1	{ v21.8h }, [x6], #16
st1	{ v22.8h }, [x6], #16
st1	{ v23.8h }, [x6], #16
st1	{ v24.8h }, [x6], #16
st1	{ v25.8h }, [x6], #16
st1	{ v26.8h }, [x6], #16
st1	{ v27.8h }, [x6], #16
st1	{ v28.8h }, [x6], #16
st1	{ v29.8h }, [x6], #16
st1	{ v30.8h }, [x6], #16
st1	{ v31.8h }, [x6], #16
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_8h_x16_neon
add	x10, x6, #0xf0
sub	x6, x6, #0x100
mov	x9, #-0x10
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v31.8h
sqsub	v31.8h, v2.8h, v31.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v30.8h
sqsub	v30.8h, v3.8h, v30.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v29.8h
sub	x6, x6, #0x40
sqsub	v29.8h, v4.8h, v29.8h
st1	{ v6.8h }, [x6], #16
st1	{ v31.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v28.8h
sqsub	v28.8h, v5.8h, v28.8h
st1	{ v7.8h }, [x6], #16
st1	{ v30.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v29.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v28.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v27.8h
sqsub	v27.8h, v2.8h, v27.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v26.8h
sqsub	v26.8h, v3.8h, v26.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v25.8h
sub	x6, x6, #0x40
sqsub	v25.8h, v4.8h, v25.8h
st1	{ v6.8h }, [x6], #16
st1	{ v27.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v24.8h
sqsub	v24.8h, v5.8h, v24.8h
st1	{ v7.8h }, [x6], #16
st1	{ v26.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v25.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v24.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v23.8h
sqsub	v23.8h, v2.8h, v23.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v22.8h
sqsub	v22.8h, v3.8h, v22.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v21.8h
sub	x6, x6, #0x40
sqsub	v21.8h, v4.8h, v21.8h
st1	{ v6.8h }, [x6], #16
st1	{ v23.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v20.8h
sqsub	v20.8h, v5.8h, v20.8h
st1	{ v7.8h }, [x6], #16
st1	{ v22.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v21.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v20.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v19.8h
sqsub	v19.8h, v2.8h, v19.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v18.8h
sqsub	v18.8h, v3.8h, v18.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v17.8h
sub	x6, x6, #0x40
sqsub	v17.8h, v4.8h, v17.8h
st1	{ v6.8h }, [x6], #16
st1	{ v19.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v16.8h
sqsub	v16.8h, v5.8h, v16.8h
st1	{ v7.8h }, [x6], #16
st1	{ v18.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v17.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v16.8h }, [x10], x9
add	x6, x6, #0x100
adrp	x17, idct64_coeffs
add	x17, x17, :lo12:idct64_coeffs
movi	v7.8h, #0x0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1	{ v16.8h }, [x7]
ld1	{ v17.8h }, [x9]
ld1	{ v18.8h }, [x10]
ld1	{ v19.8h }, [x11]
st1	{ v7.8h }, [x7]
st1	{ v7.8h }, [x9]
st1	{ v7.8h }, [x10]
st1	{ v7.8h }, [x11]
bl	inv_dct64_step1_neon
movi	v7.8h, #0x0
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1	{ v16.8h }, [x10]
ld1	{ v17.8h }, [x11]
ld1	{ v18.8h }, [x9]
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7]
st1	{ v7.8h }, [x9]
st1	{ v7.8h }, [x10]
st1	{ v7.8h }, [x11]
bl	inv_dct64_step1_neon
movi	v7.8h, #0x0
sub	x10, x10, x8, lsl #1
sub	x9, x9, x8, lsl #1
add	x7, x7, x8
add	x11, x11, x8
ldr	q16, [x10, x8]
ldr	q17, [x11]
ldr	q18, [x9, x8]
ldr	q19, [x7]
str	q7, [x10, x8]
str	q7, [x11]
str	q7, [x9, x8]
str	q7, [x7]
bl	inv_dct64_step1_neon
movi	v7.8h, #0x0
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
str	q7, [x10]
str	q7, [x11, x8]
str	q7, [x9]
str	q7, [x7, x8]
bl	inv_dct64_step1_neon
sub	x6, x6, #0x200
add	x9, x6, #0x70
bl	inv_dct64_step2_neon
ret	x14
inv_txfm_dct_clear_scale_8h_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
mov	w16, #0x5a80
dup	v0.4h, w16
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
bl	inv_dct_8h_x16_neon
st1	{ v16.8h }, [x6], #16
st1	{ v17.8h }, [x6], #16
st1	{ v18.8h }, [x6], #16
st1	{ v19.8h }, [x6], #16
st1	{ v20.8h }, [x6], #16
st1	{ v21.8h }, [x6], #16
st1	{ v22.8h }, [x6], #16
st1	{ v23.8h }, [x6], #16
st1	{ v24.8h }, [x6], #16
st1	{ v25.8h }, [x6], #16
st1	{ v26.8h }, [x6], #16
st1	{ v27.8h }, [x6], #16
st1	{ v28.8h }, [x6], #16
st1	{ v29.8h }, [x6], #16
st1	{ v30.8h }, [x6], #16
st1	{ v31.8h }, [x6], #16
mov	w16, #0x5a80
dup	v0.4h, w16
movi	v7.8h, #0x0
ld1	{ v16.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v17.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v18.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v20.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v21.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v22.8h }, [x7]
st1	{ v7.8h }, [x7], x8
ld1	{ v23.8h }, [x7]
st1	{ v7.8h }, [x7], x8
movi	v24.8h, #0x0
movi	v25.8h, #0x0
movi	v26.8h, #0x0
movi	v27.8h, #0x0
movi	v28.8h, #0x0
movi	v29.8h, #0x0
movi	v30.8h, #0x0
movi	v31.8h, #0x0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
sqrdmulh	v20.8h, v20.8h, v0.h[0]
sqrdmulh	v21.8h, v21.8h, v0.h[0]
sqrdmulh	v22.8h, v22.8h, v0.h[0]
sqrdmulh	v23.8h, v23.8h, v0.h[0]
bl	inv_dct32_odd_8h_x16_neon
add	x10, x6, #0xf0
sub	x6, x6, #0x100
mov	x9, #-0x10
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v31.8h
sqsub	v31.8h, v2.8h, v31.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v30.8h
sqsub	v30.8h, v3.8h, v30.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v29.8h
sub	x6, x6, #0x40
sqsub	v29.8h, v4.8h, v29.8h
st1	{ v6.8h }, [x6], #16
st1	{ v31.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v28.8h
sqsub	v28.8h, v5.8h, v28.8h
st1	{ v7.8h }, [x6], #16
st1	{ v30.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v29.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v28.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v27.8h
sqsub	v27.8h, v2.8h, v27.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v26.8h
sqsub	v26.8h, v3.8h, v26.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v25.8h
sub	x6, x6, #0x40
sqsub	v25.8h, v4.8h, v25.8h
st1	{ v6.8h }, [x6], #16
st1	{ v27.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v24.8h
sqsub	v24.8h, v5.8h, v24.8h
st1	{ v7.8h }, [x6], #16
st1	{ v26.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v25.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v24.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v23.8h
sqsub	v23.8h, v2.8h, v23.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v22.8h
sqsub	v22.8h, v3.8h, v22.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v21.8h
sub	x6, x6, #0x40
sqsub	v21.8h, v4.8h, v21.8h
st1	{ v6.8h }, [x6], #16
st1	{ v23.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v20.8h
sqsub	v20.8h, v5.8h, v20.8h
st1	{ v7.8h }, [x6], #16
st1	{ v22.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v21.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v20.8h }, [x10], x9
ld1	{ v2.8h }, [x6], #16
ld1	{ v3.8h }, [x6], #16
sqadd	v6.8h, v2.8h, v19.8h
sqsub	v19.8h, v2.8h, v19.8h
ld1	{ v4.8h }, [x6], #16
sqadd	v7.8h, v3.8h, v18.8h
sqsub	v18.8h, v3.8h, v18.8h
ld1	{ v5.8h }, [x6], #16
sqadd	v2.8h, v4.8h, v17.8h
sub	x6, x6, #0x40
sqsub	v17.8h, v4.8h, v17.8h
st1	{ v6.8h }, [x6], #16
st1	{ v19.8h }, [x10], x9
sqadd	v3.8h, v5.8h, v16.8h
sqsub	v16.8h, v5.8h, v16.8h
st1	{ v7.8h }, [x6], #16
st1	{ v18.8h }, [x10], x9
st1	{ v2.8h }, [x6], #16
st1	{ v17.8h }, [x10], x9
st1	{ v3.8h }, [x6], #16
st1	{ v16.8h }, [x10], x9
add	x6, x6, #0x100
adrp	x17, idct64_coeffs
add	x17, x17, :lo12:idct64_coeffs
mov	w16, #0x5a80
dup	v0.4h, w16
movi	v7.8h, #0x0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1	{ v16.8h }, [x7]
ld1	{ v17.8h }, [x9]
ld1	{ v18.8h }, [x10]
ld1	{ v19.8h }, [x11]
st1	{ v7.8h }, [x7]
st1	{ v7.8h }, [x9]
st1	{ v7.8h }, [x10]
st1	{ v7.8h }, [x11]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
bl	inv_dct64_step1_neon
mov	w16, #0x5a80
dup	v0.4h, w16
movi	v7.8h, #0x0
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1	{ v16.8h }, [x10]
ld1	{ v17.8h }, [x11]
ld1	{ v18.8h }, [x9]
ld1	{ v19.8h }, [x7]
st1	{ v7.8h }, [x7]
st1	{ v7.8h }, [x9]
st1	{ v7.8h }, [x10]
st1	{ v7.8h }, [x11]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
bl	inv_dct64_step1_neon
mov	w16, #0x5a80
dup	v0.4h, w16
movi	v7.8h, #0x0
sub	x10, x10, x8, lsl #1
sub	x9, x9, x8, lsl #1
add	x7, x7, x8
add	x11, x11, x8
ldr	q16, [x10, x8]
ldr	q17, [x11]
ldr	q18, [x9, x8]
ldr	q19, [x7]
str	q7, [x10, x8]
str	q7, [x11]
str	q7, [x9, x8]
str	q7, [x7]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
bl	inv_dct64_step1_neon
mov	w16, #0x5a80
dup	v0.4h, w16
movi	v7.8h, #0x0
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
str	q7, [x10]
str	q7, [x11, x8]
str	q7, [x9]
str	q7, [x7, x8]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
sqrdmulh	v17.8h, v17.8h, v0.h[0]
sqrdmulh	v18.8h, v18.8h, v0.h[0]
sqrdmulh	v19.8h, v19.8h, v0.h[0]
bl	inv_dct64_step1_neon
sub	x6, x6, #0x200
add	x9, x6, #0x70
bl	inv_dct64_step2_neon
ret	x14
inv_txfm_horz_dct_64x8_neon:
mov	x14, x30
mov	x7, sp
add	x8, sp, #0x3c0
add	x9, x6, #0x70
mov	x10, #0x80
mov	x11, #-0x40
dup	v7.8h, w12
L_7728:
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], #64
ld1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x8], x11
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x7], #64
ld1	{ v24.8h, v25.8h, v26.8h, v27.8h }, [x8], x11
trn1	v4.8h, v16.8h, v17.8h
trn2	v5.8h, v16.8h, v17.8h
trn1	v17.8h, v18.8h, v19.8h
trn2	v19.8h, v18.8h, v19.8h
trn1	v16.8h, v20.8h, v21.8h
trn2	v21.8h, v20.8h, v21.8h
trn1	v18.8h, v22.8h, v23.8h
trn2	v23.8h, v22.8h, v23.8h
trn1	v20.4s, v16.4s, v18.4s
trn2	v18.4s, v16.4s, v18.4s
trn1	v22.4s, v21.4s, v23.4s
trn2	v23.4s, v21.4s, v23.4s
trn1	v21.4s, v5.4s, v19.4s
trn2	v5.4s, v5.4s, v19.4s
trn1	v19.4s, v4.4s, v17.4s
trn2	v4.4s, v4.4s, v17.4s
trn1	v16.2d, v19.2d, v20.2d
trn2	v20.2d, v19.2d, v20.2d
trn1	v17.2d, v21.2d, v22.2d
trn2	v21.2d, v21.2d, v22.2d
trn2	v22.2d, v4.2d, v18.2d
trn1	v18.2d, v4.2d, v18.2d
trn1	v19.2d, v5.2d, v23.2d
trn2	v23.2d, v5.2d, v23.2d
trn1	v4.8h, v31.8h, v30.8h
trn2	v5.8h, v31.8h, v30.8h
trn1	v30.8h, v29.8h, v28.8h
trn2	v28.8h, v29.8h, v28.8h
trn1	v31.8h, v27.8h, v26.8h
trn2	v26.8h, v27.8h, v26.8h
trn1	v29.8h, v25.8h, v24.8h
trn2	v24.8h, v25.8h, v24.8h
trn1	v27.4s, v31.4s, v29.4s
trn2	v29.4s, v31.4s, v29.4s
trn1	v25.4s, v26.4s, v24.4s
trn2	v24.4s, v26.4s, v24.4s
trn1	v26.4s, v5.4s, v28.4s
trn2	v5.4s, v5.4s, v28.4s
trn1	v28.4s, v4.4s, v30.4s
trn2	v4.4s, v4.4s, v30.4s
trn1	v31.2d, v28.2d, v27.2d
trn2	v27.2d, v28.2d, v27.2d
trn1	v30.2d, v26.2d, v25.2d
trn2	v26.2d, v26.2d, v25.2d
trn2	v25.2d, v4.2d, v29.2d
trn1	v29.2d, v4.2d, v29.2d
trn1	v28.2d, v5.2d, v24.2d
trn2	v24.2d, v5.2d, v24.2d
sqsub	v1.8h, v16.8h, v31.8h
sqadd	v0.8h, v16.8h, v31.8h
sqsub	v3.8h, v17.8h, v30.8h
srshl	v1.8h, v1.8h, v7.8h
sqadd	v2.8h, v17.8h, v30.8h
srshl	v0.8h, v0.8h, v7.8h
srshl	v3.8h, v3.8h, v7.8h
rev64	v1.8h, v1.8h
srshl	v2.8h, v2.8h, v7.8h
rev64	v3.8h, v3.8h
ext	v1.16b, v1.16b, v1.16b, #0x8
st1	{ v0.8h }, [x6], x10
ext	v3.16b, v3.16b, v3.16b, #0x8
st1	{ v1.8h }, [x9], x10
st1	{ v2.8h }, [x6], x10
st1	{ v3.8h }, [x9], x10
sqsub	v1.8h, v18.8h, v29.8h
sqadd	v0.8h, v18.8h, v29.8h
sqsub	v3.8h, v19.8h, v28.8h
srshl	v1.8h, v1.8h, v7.8h
sqadd	v2.8h, v19.8h, v28.8h
srshl	v0.8h, v0.8h, v7.8h
srshl	v3.8h, v3.8h, v7.8h
rev64	v1.8h, v1.8h
srshl	v2.8h, v2.8h, v7.8h
rev64	v3.8h, v3.8h
ext	v1.16b, v1.16b, v1.16b, #0x8
st1	{ v0.8h }, [x6], x10
ext	v3.16b, v3.16b, v3.16b, #0x8
st1	{ v1.8h }, [x9], x10
st1	{ v2.8h }, [x6], x10
st1	{ v3.8h }, [x9], x10
sqsub	v1.8h, v20.8h, v27.8h
sqadd	v0.8h, v20.8h, v27.8h
sqsub	v3.8h, v21.8h, v26.8h
srshl	v1.8h, v1.8h, v7.8h
sqadd	v2.8h, v21.8h, v26.8h
srshl	v0.8h, v0.8h, v7.8h
srshl	v3.8h, v3.8h, v7.8h
rev64	v1.8h, v1.8h
srshl	v2.8h, v2.8h, v7.8h
rev64	v3.8h, v3.8h
ext	v1.16b, v1.16b, v1.16b, #0x8
st1	{ v0.8h }, [x6], x10
ext	v3.16b, v3.16b, v3.16b, #0x8
st1	{ v1.8h }, [x9], x10
st1	{ v2.8h }, [x6], x10
st1	{ v3.8h }, [x9], x10
sqsub	v1.8h, v22.8h, v25.8h
sqadd	v0.8h, v22.8h, v25.8h
sqsub	v3.8h, v23.8h, v24.8h
srshl	v1.8h, v1.8h, v7.8h
sqadd	v2.8h, v23.8h, v24.8h
srshl	v0.8h, v0.8h, v7.8h
srshl	v3.8h, v3.8h, v7.8h
rev64	v1.8h, v1.8h
srshl	v2.8h, v2.8h, v7.8h
rev64	v3.8h, v3.8h
ext	v1.16b, v1.16b, v1.16b, #0x8
st1	{ v0.8h }, [x6], x10
ext	v3.16b, v3.16b, v3.16b, #0x8
st1	{ v1.8h }, [x9], x10
st1	{ v2.8h }, [x6], x10
st1	{ v3.8h }, [x9], x10
sub	x6, x6, x10, lsl #3
sub	x9, x9, x10, lsl #3
add	x6, x6, #0x10
sub	x9, x9, #0x10
cmp	x7, x8
b.lt	L_7728
ret	x14
inv_txfm_add_vert_dct_8x64_neon:
mov	x14, x30
lsl	x8, x8, #1
mov	x7, sp
add	x8, sp, #0x3c0
add	x9, x6, x1, lsl #6
sub	x9, x9, x1
neg	x10, x1
mov	x11, #-0x40
L_7934:
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x7], #64
ld1	{ v28.8h, v29.8h, v30.8h, v31.8h }, [x8], x11
ld1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x7], #64
ld1	{ v24.8h, v25.8h, v26.8h, v27.8h }, [x8], x11
ld1	{ v0.8b }, [x6], x1
ld1	{ v1.8b }, [x9], x10
sqadd	v4.8h, v16.8h, v31.8h
ld1	{ v2.8b }, [x6]
sqsub	v5.8h, v16.8h, v31.8h
ld1	{ v3.8b }, [x9]
sqadd	v6.8h, v17.8h, v30.8h
sqsub	v7.8h, v17.8h, v30.8h
sub	x6, x6, x1
sub	x9, x9, x10
srshr	v4.8h, v4.8h, #0x4
srshr	v5.8h, v5.8h, #0x4
srshr	v6.8h, v6.8h, #0x4
uaddw	v4.8h, v4.8h, v0.8b
srshr	v7.8h, v7.8h, #0x4
uaddw	v5.8h, v5.8h, v1.8b
uaddw	v6.8h, v6.8h, v2.8b
sqxtun	v0.8b, v4.8h
uaddw	v7.8h, v7.8h, v3.8b
sqxtun	v1.8b, v5.8h
st1	{ v0.8b }, [x6], x1
sqxtun	v2.8b, v6.8h
st1	{ v1.8b }, [x9], x10
sqxtun	v3.8b, v7.8h
st1	{ v2.8b }, [x6], x1
st1	{ v3.8b }, [x9], x10
ld1	{ v0.8b }, [x6], x1
ld1	{ v1.8b }, [x9], x10
sqadd	v4.8h, v18.8h, v29.8h
ld1	{ v2.8b }, [x6]
sqsub	v5.8h, v18.8h, v29.8h
ld1	{ v3.8b }, [x9]
sqadd	v6.8h, v19.8h, v28.8h
sqsub	v7.8h, v19.8h, v28.8h
sub	x6, x6, x1
sub	x9, x9, x10
srshr	v4.8h, v4.8h, #0x4
srshr	v5.8h, v5.8h, #0x4
srshr	v6.8h, v6.8h, #0x4
uaddw	v4.8h, v4.8h, v0.8b
srshr	v7.8h, v7.8h, #0x4
uaddw	v5.8h, v5.8h, v1.8b
uaddw	v6.8h, v6.8h, v2.8b
sqxtun	v0.8b, v4.8h
uaddw	v7.8h, v7.8h, v3.8b
sqxtun	v1.8b, v5.8h
st1	{ v0.8b }, [x6], x1
sqxtun	v2.8b, v6.8h
st1	{ v1.8b }, [x9], x10
sqxtun	v3.8b, v7.8h
st1	{ v2.8b }, [x6], x1
st1	{ v3.8b }, [x9], x10
ld1	{ v0.8b }, [x6], x1
ld1	{ v1.8b }, [x9], x10
sqadd	v4.8h, v20.8h, v27.8h
ld1	{ v2.8b }, [x6]
sqsub	v5.8h, v20.8h, v27.8h
ld1	{ v3.8b }, [x9]
sqadd	v6.8h, v21.8h, v26.8h
sqsub	v7.8h, v21.8h, v26.8h
sub	x6, x6, x1
sub	x9, x9, x10
srshr	v4.8h, v4.8h, #0x4
srshr	v5.8h, v5.8h, #0x4
srshr	v6.8h, v6.8h, #0x4
uaddw	v4.8h, v4.8h, v0.8b
srshr	v7.8h, v7.8h, #0x4
uaddw	v5.8h, v5.8h, v1.8b
uaddw	v6.8h, v6.8h, v2.8b
sqxtun	v0.8b, v4.8h
uaddw	v7.8h, v7.8h, v3.8b
sqxtun	v1.8b, v5.8h
st1	{ v0.8b }, [x6], x1
sqxtun	v2.8b, v6.8h
st1	{ v1.8b }, [x9], x10
sqxtun	v3.8b, v7.8h
st1	{ v2.8b }, [x6], x1
st1	{ v3.8b }, [x9], x10
ld1	{ v0.8b }, [x6], x1
ld1	{ v1.8b }, [x9], x10
sqadd	v4.8h, v22.8h, v25.8h
ld1	{ v2.8b }, [x6]
sqsub	v5.8h, v22.8h, v25.8h
ld1	{ v3.8b }, [x9]
sqadd	v6.8h, v23.8h, v24.8h
sqsub	v7.8h, v23.8h, v24.8h
sub	x6, x6, x1
sub	x9, x9, x10
srshr	v4.8h, v4.8h, #0x4
srshr	v5.8h, v5.8h, #0x4
srshr	v6.8h, v6.8h, #0x4
uaddw	v4.8h, v4.8h, v0.8b
srshr	v7.8h, v7.8h, #0x4
uaddw	v5.8h, v5.8h, v1.8b
uaddw	v6.8h, v6.8h, v2.8b
sqxtun	v0.8b, v4.8h
uaddw	v7.8h, v7.8h, v3.8b
sqxtun	v1.8b, v5.8h
st1	{ v0.8b }, [x6], x1
sqxtun	v2.8b, v6.8h
st1	{ v1.8b }, [x9], x10
sqxtun	v3.8b, v7.8h
st1	{ v2.8b }, [x6], x1
st1	{ v3.8b }, [x9], x10
cmp	x7, x8
b.lt	L_7934
ret	x14
inv_txfm_add_dct_dct_64x64_8bpc_neon:
cbnz	w3, L_7b1c
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x40
b	idct_dc_w64_neon
L_7b1c:
mov	x15, x30
sub	sp, sp, #0x1, lsl #12
sub	sp, sp, #0x400
add	x5, sp, #0x400
adrp	x13, eob_32x32
add	x13, x13, :lo12:eob_32x32
add	x6, x5, #0x0
add	x7, x2, #0x0
mov	x8, #0x40
mov	x12, #-0x2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #0x0
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x5, #0x400
mov	w8, #0x18
cmp	w3, w12
b.lt	L_7bd8
add	x7, x2, #0x10
mov	x8, #0x40
mov	x12, #-0x2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #0x400
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x5, #0x800
mov	w8, #0x10
cmp	w3, w12
b.lt	L_7bd8
add	x7, x2, #0x20
mov	x8, #0x40
mov	x12, #-0x2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #0x800
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x5, #0xc00
mov	w8, #0x8
cmp	w3, w12
b.lt	L_7bd8
add	x7, x2, #0x30
mov	x8, #0x40
mov	x12, #-0x2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #0xc00
bl	inv_txfm_horz_dct_64x8_neon
b	L_7c00
L_7bd8:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_7be8:
subs	w8, w8, #0x2
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_7be8
L_7c00:
add	x7, x5, #0x0
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x10
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x8
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x20
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x10
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x30
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x18
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x40
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x20
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x50
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x28
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x60
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x30
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x70
mov	x8, #0x80
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x38
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #0x1, lsl #12
ret	x15
inv_txfm_add_dct_dct_64x32_8bpc_neon:
cbnz	w3, L_7cd8
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x20
b	idct_dc_w64_neon
L_7cd8:
mov	x15, x30
sub	sp, sp, #0x1, lsl #12
sub	sp, sp, #0x400
add	x5, sp, #0x400
adrp	x13, eob_32x32
add	x13, x13, :lo12:eob_32x32
add	x6, x5, #0x0
add	x7, x2, #0x0
mov	x8, #0x40
mov	x12, #-0x1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #0x0
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x5, #0x400
mov	w8, #0x18
cmp	w3, w12
b.lt	L_7d94
add	x7, x2, #0x10
mov	x8, #0x40
mov	x12, #-0x1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #0x400
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x5, #0x800
mov	w8, #0x10
cmp	w3, w12
b.lt	L_7d94
add	x7, x2, #0x20
mov	x8, #0x40
mov	x12, #-0x1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #0x800
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x5, #0xc00
mov	w8, #0x8
cmp	w3, w12
b.lt	L_7d94
add	x7, x2, #0x30
mov	x8, #0x40
mov	x12, #-0x1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #0xc00
bl	inv_txfm_horz_dct_64x8_neon
b	L_7dbc
L_7d94:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_7da4:
subs	w8, w8, #0x2
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_7da4
L_7dbc:
add	x6, x0, #0x0
add	x7, x5, #0x0
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x8
add	x7, x5, #0x10
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x10
add	x7, x5, #0x20
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x18
add	x7, x5, #0x30
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x20
add	x7, x5, #0x40
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x28
add	x7, x5, #0x50
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x30
add	x7, x5, #0x60
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #0x38
add	x7, x5, #0x70
mov	x8, #0x80
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, x5, #0x1, lsl #12
ret	x15
inv_txfm_add_dct_dct_32x64_8bpc_neon:
cbnz	w3, L_7e74
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x1
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x40
b	idct_dc_w32_neon
L_7e74:
mov	x15, x30
sub	sp, sp, #0xc00
add	x5, sp, #0x400
adrp	x13, eob_32x32
add	x13, x13, :lo12:eob_32x32
ldrh	w12, [x13], #0x2
add	x6, x5, #0x0
add	x7, x2, #0x0
mov	x8, #0x40
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, x5, #0x200
mov	w8, #0x18
cmp	w3, w12
b.lt	L_7efc
ldrh	w12, [x13], #0x2
add	x7, x2, #0x10
mov	x8, #0x40
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, x5, #0x400
mov	w8, #0x10
cmp	w3, w12
b.lt	L_7efc
ldrh	w12, [x13], #0x2
add	x7, x2, #0x20
mov	x8, #0x40
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, x5, #0x600
mov	w8, #0x8
cmp	w3, w12
b.lt	L_7efc
add	x7, x2, #0x30
mov	x8, #0x40
bl	inv_txfm_horz_scale_dct_32x8_neon
b	L_7f24
L_7efc:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_7f0c:
subs	w8, w8, #0x4
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_7f0c
L_7f24:
add	x7, x5, #0x0
mov	x8, #0x40
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x10
mov	x8, #0x40
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x8
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x20
mov	x8, #0x40
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x10
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x30
mov	x8, #0x40
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x18
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #0x800
ret	x15
inv_txfm_add_dct_dct_64x16_8bpc_neon:
cbnz	w3, L_7fa8
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x10
b	idct_dc_w64_neon
L_7fa8:
mov	x15, x30
sub	sp, sp, #0xc00
add	x4, sp, #0x400
adrp	x13, eob_16x32
add	x13, x13, :lo12:eob_16x32
add	x6, x4, #0x0
add	x7, x2, #0x0
mov	x8, #0x20
mov	x12, #-0x2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x4, #0x0
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #0x2
add	x6, x4, #0x400
mov	w8, #0x8
cmp	w3, w12
b.lt	L_8008
add	x7, x2, #0x10
mov	x8, #0x20
mov	x12, #-0x2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x4, #0x400
bl	inv_txfm_horz_dct_64x8_neon
b	L_8030
L_8008:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_8018:
subs	w8, w8, #0x2
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_8018
L_8030:
adr	x5, inv_dct_8h_x16_neon
mov	x8, #0x80
add	x6, x0, #0x0
add	x7, x4, #0x0
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x8
add	x7, x4, #0x10
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x10
add	x7, x4, #0x20
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x18
add	x7, x4, #0x30
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x20
add	x7, x4, #0x40
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x28
add	x7, x4, #0x50
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x30
add	x7, x4, #0x60
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #0x38
add	x7, x4, #0x70
bl	inv_txfm_add_vert_8x16_neon
add	sp, x4, #0x800
ret	x15
inv_txfm_add_dct_dct_16x64_8bpc_neon:
cbnz	w3, L_80cc
mov	w16, #0x5a80
ld1r	{ v16.8h }, [x2]
dup	v0.4h, w16
sqrdmulh	v16.8h, v16.8h, v0.h[0]
strh	wzr, [x2]
srshr	v16.8h, v16.8h, #0x2
sqrdmulh	v16.8h, v16.8h, v0.h[0]
srshr	v16.8h, v16.8h, #0x4
mov	w4, #0x40
b	idct_dc_w16_neon
L_80cc:
mov	x15, x30
sub	sp, sp, #0x800
add	x5, sp, #0x400
adrp	x13, eob_16x32
add	x13, x13, :lo12:eob_16x32
ldrh	w12, [x13], #0x2
adr	x4, inv_dct_8h_x16_neon
add	x6, x5, #0x0
add	x7, x2, #0x0
mov	x8, #0x40
bl	inv_txfm_horz_16x8_neon
add	x6, x5, #0x100
mov	w8, #0x18
cmp	w3, w12
b.lt	L_8158
ldrh	w12, [x13], #0x2
add	x7, x2, #0x10
mov	x8, #0x40
bl	inv_txfm_horz_16x8_neon
add	x6, x5, #0x200
mov	w8, #0x10
cmp	w3, w12
b.lt	L_8158
ldrh	w12, [x13], #0x2
add	x7, x2, #0x20
mov	x8, #0x40
bl	inv_txfm_horz_16x8_neon
add	x6, x5, #0x300
mov	w8, #0x8
cmp	w3, w12
b.lt	L_8158
add	x7, x2, #0x30
mov	x8, #0x40
bl	inv_txfm_horz_16x8_neon
b	L_8180
L_8158:
movi	v4.8h, #0x0
movi	v5.8h, #0x0
movi	v6.8h, #0x0
movi	v7.8h, #0x0
L_8168:
subs	w8, w8, #0x8
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
st1	{ v4.8h, v5.8h, v6.8h, v7.8h }, [x6], #64
b.gt	L_8168
L_8180:
add	x7, x5, #0x0
mov	x8, #0x20
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #0x10
mov	x8, #0x20
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0x8
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #0x400
ret	x15
	.section .rodata
idct_coeffs:
	.size idct_coeffs, 64
	.byte 80,11,128,90,31,6,200,14,31,3,177,15,78,13,228,8
	.byte 145,1,236,15,94,12,38,10,139,7,28,14,80,15,165,4
	.byte 201,0,251,15,219,11,191,10,215,6,119,14,17,15,100,5
	.byte 227,3,133,15,185,13,58,8,136,9,218,12,212,15,89,2
idct64_coeffs:
	.size idct64_coeffs, 128
	.byte 40,3,248,127,184,92,192,167,224,51,8,117,112,119,240,209
	.byte 236,15,145,1,177,15,31,3,0,0,0,0,0,0,0,0
	.byte 32,126,32,234,184,73,168,104,40,108,136,187,8,28,224,124
	.byte 162,243,218,245,225,252,79,240,0,0,0,0,0,0,0,0
	.byte 168,15,8,127,232,100,64,177,24,63,96,111,96,123,224,221
	.byte 28,14,139,7,228,8,78,13,0,0,0,0,0,0,0,0
	.byte 168,127,152,246,152,83,240,96,88,114,112,198,40,40,136,121
	.byte 176,240,91,251,178,242,28,247,0,0,0,0,0,0,0,0
iadst4_coeffs:
	.size iadst4_coeffs, 12
	.byte 41,5,219,14,178,9,16,13,16,13,0,0,0,0,0,0
iadst8_coeffs:
	.size iadst8_coeffs, 32
	.byte 236,15,145,1,28,14,139,7,38,10,94,12,165,4,80,15
	.byte 80,11,0,0,31,6,200,14,0,0,0,0,0,0,0,0
iadst16_coeffs:
	.size iadst16_coeffs, 32
	.byte 251,15,201,0,133,15,227,3,119,14,215,6,218,12,136,9
	.byte 191,10,219,11,58,8,185,13,100,5,17,15,89,2,212,15
eob_32x32:
	.size eob_32x32, 8
	.byte 36,0,136,0,44,1,0,4
eob_16x32:
	.size eob_16x32, 8
	.byte 36,0,151,0,23,1,0,2
eob_16x32_shortside:
	.size eob_16x32_shortside, 4
	.byte 36,0,0,2
eob_8x32:
	.size eob_8x32, 8
	.byte 43,0,107,0,171,0,0,1

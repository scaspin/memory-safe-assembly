_ltmp0:
ld1.s	{ v0 }[0], [x0], x1
ld1.s	{ v0 }[1], [x0], x1
ld1.s	{ v1 }[0], [x0], x1
ld1.s	{ v1 }[1], [x0], x1
subs	w4, w4, #4
sub	x0, x0, x1, lsl #2
uaddw.8h	v0, v16, v0
sqxtun.8b	v0, v0
uaddw.8h	v1, v16, v1
st1.s	{ v0 }[0], [x0], x1
sqxtun.8b	v1, v1
st1.s	{ v0 }[1], [x0], x1
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x0], x1
b.gt	ltmp0
ret
_idct_dc_w8_neon:
ld1.8b	{ v0 }, [x0], x1
ld1.8b	{ v1 }, [x0], x1
ld1.8b	{ v2 }, [x0], x1
uaddw.8h	v20, v16, v0
ld1.8b	{ v3 }, [x0], x1
sub	x0, x0, x1, lsl #2
subs	w4, w4, #4
uaddw.8h	v21, v16, v1
sqxtun.8b	v0, v20
uaddw.8h	v22, v16, v2
sqxtun.8b	v1, v21
uaddw.8h	v23, v16, v3
st1.8b	{ v0 }, [x0], x1
sqxtun.8b	v2, v22
st1.8b	{ v1 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
b.gt	idct_dc_w8_neon
ret
_idct_dc_w16_neon:
ld1.16b	{ v0 }, [x0], x1
ld1.16b	{ v1 }, [x0], x1
ld1.16b	{ v2 }, [x0], x1
subs	w4, w4, #4
uaddw.8h	v20, v16, v0
uaddw2.8h	v21, v16, v0
ld1.16b	{ v3 }, [x0], x1
uaddw.8h	v22, v16, v1
uaddw2.8h	v23, v16, v1
sub	x0, x0, x1, lsl #2
uaddw.8h	v24, v16, v2
uaddw2.8h	v25, v16, v2
sqxtun.8b	v0, v20
sqxtun2.16b	v0, v21
uaddw.8h	v26, v16, v3
uaddw2.8h	v27, v16, v3
sqxtun.8b	v1, v22
sqxtun2.16b	v1, v23
sqxtun.8b	v2, v24
sqxtun2.16b	v2, v25
st1.16b	{ v0 }, [x0], x1
sqxtun.8b	v3, v26
sqxtun2.16b	v3, v27
st1.16b	{ v1 }, [x0], x1
st1.16b	{ v2 }, [x0], x1
st1.16b	{ v3 }, [x0], x1
b.gt	idct_dc_w16_neon
ret
_idct_dc_w32_neon:
ld1.16b	{ v0, v1 }, [x0], x1
subs	w4, w4, #2
uaddw.8h	v20, v16, v0
uaddw2.8h	v21, v16, v0
ld1.16b	{ v2, v3 }, [x0]
uaddw.8h	v22, v16, v1
uaddw2.8h	v23, v16, v1
sub	x0, x0, x1
uaddw.8h	v24, v16, v2
uaddw2.8h	v25, v16, v2
sqxtun.8b	v0, v20
sqxtun2.16b	v0, v21
uaddw.8h	v26, v16, v3
uaddw2.8h	v27, v16, v3
sqxtun.8b	v1, v22
sqxtun2.16b	v1, v23
sqxtun.8b	v2, v24
sqxtun2.16b	v2, v25
st1.16b	{ v0, v1 }, [x0], x1
sqxtun.8b	v3, v26
sqxtun2.16b	v3, v27
st1.16b	{ v2, v3 }, [x0], x1
b.gt	idct_dc_w32_neon
ret
_idct_dc_w64_neon:
ld1.16b	{ v0, v1, v2, v3 }, [x0]
subs	w4, w4, #1
uaddw.8h	v20, v16, v0
uaddw2.8h	v21, v16, v0
uaddw.8h	v22, v16, v1
uaddw2.8h	v23, v16, v1
uaddw.8h	v24, v16, v2
uaddw2.8h	v25, v16, v2
sqxtun.8b	v0, v20
sqxtun2.16b	v0, v21
uaddw.8h	v26, v16, v3
uaddw2.8h	v27, v16, v3
sqxtun.8b	v1, v22
sqxtun2.16b	v1, v23
sqxtun.8b	v2, v24
sqxtun2.16b	v2, v25
sqxtun.8b	v3, v26
sqxtun2.16b	v3, v27
st1.16b	{ v0, v1, v2, v3 }, [x0], x1
b.gt	idct_dc_w64_neon
ret
_inv_dct_4h_x4_neon:
adrp	x16, inv_dct_4h_x4_neon
add	x16, x16, #0
ld1.4h	{ v0 }, [x16]
smull.4s	v6, v17, v0[3]
smlal.4s	v6, v19, v0[2]
smull.4s	v4, v17, v0[2]
smlsl.4s	v4, v19, v0[3]
smull.4s	v2, v16, v0[0]
smlal.4s	v2, v18, v0[0]
sqrshrn.4h	v6, v6, #12
sqrshrn.4h	v7, v4, #12
smull.4s	v4, v16, v0[0]
smlsl.4s	v4, v18, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn.4h	v3, v4, #12
sqadd.4h	v16, v2, v6
sqsub.4h	v19, v2, v6
sqadd.4h	v17, v3, v7
sqsub.4h	v18, v3, v7
ret
_inv_dct_8h_x4_neon:
adrp	x16, inv_dct_8h_x4_neon
add	x16, x16, #0
ld1.4h	{ v0 }, [x16]
smull.4s	v6, v17, v0[3]
smlal.4s	v6, v19, v0[2]
smull2.4s	v7, v17, v0[3]
smlal2.4s	v7, v19, v0[2]
smull.4s	v4, v17, v0[2]
smlsl.4s	v4, v19, v0[3]
smull2.4s	v5, v17, v0[2]
smlsl2.4s	v5, v19, v0[3]
smull.4s	v2, v16, v0[0]
smlal.4s	v2, v18, v0[0]
smull2.4s	v3, v16, v0[0]
smlal2.4s	v3, v18, v0[0]
sqrshrn.4h	v6, v6, #12
sqrshrn2.8h	v6, v7, #12
sqrshrn.4h	v7, v4, #12
sqrshrn2.8h	v7, v5, #12
smull.4s	v4, v16, v0[0]
smlsl.4s	v4, v18, v0[0]
smull2.4s	v5, v16, v0[0]
smlsl2.4s	v5, v18, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn2.8h	v2, v3, #12
sqrshrn.4h	v3, v4, #12
sqrshrn2.8h	v3, v5, #12
sqadd.8h	v16, v2, v6
sqsub.8h	v19, v2, v6
sqadd.8h	v17, v3, v7
sqsub.8h	v18, v3, v7
ret
_inv_adst_4h_x4_neon:
adrp	x16, inv_adst_4h_x4_neon
add	x16, x16, #0
ld1.8h	{ v0 }, [x16]
ssubl.4s	v3, v16, v18
smull.4s	v4, v16, v0[0]
smlal.4s	v4, v18, v0[1]
smlal.4s	v4, v19, v0[2]
smull.4s	v7, v17, v0[3]
saddw.4s	v3, v3, v19
smull.4s	v5, v16, v0[2]
smlsl.4s	v5, v18, v0[0]
smlsl.4s	v5, v19, v0[1]
add.4s	v19, v4, v5
mul.4s	v18, v3, v0[2]
add.4s	v16, v4, v7
add.4s	v17, v5, v7
sub.4s	v19, v19, v7
sqrshrn.4h	v16, v16, #12
sqrshrn.4h	v18, v18, #12
sqrshrn.4h	v17, v17, #12
sqrshrn.4h	v19, v19, #12
ret
_inv_flipadst_4h_x4_neon:
adrp	x16, inv_flipadst_4h_x4_neon
add	x16, x16, #0
ld1.8h	{ v0 }, [x16]
ssubl.4s	v3, v16, v18
smull.4s	v4, v16, v0[0]
smlal.4s	v4, v18, v0[1]
smlal.4s	v4, v19, v0[2]
smull.4s	v7, v17, v0[3]
saddw.4s	v3, v3, v19
smull.4s	v5, v16, v0[2]
smlsl.4s	v5, v18, v0[0]
smlsl.4s	v5, v19, v0[1]
add.4s	v16, v4, v5
mul.4s	v17, v3, v0[2]
add.4s	v19, v4, v7
add.4s	v18, v5, v7
sub.4s	v16, v16, v7
sqrshrn.4h	v19, v19, #12
sqrshrn.4h	v17, v17, #12
sqrshrn.4h	v18, v18, #12
sqrshrn.4h	v16, v16, #12
ret
_inv_adst_8h_x4_neon:
adrp	x16, inv_adst_8h_x4_neon
add	x16, x16, #0
ld1.8h	{ v0 }, [x16]
ssubl.4s	v2, v16, v18
ssubl2.4s	v3, v16, v18
smull.4s	v4, v16, v0[0]
smlal.4s	v4, v18, v0[1]
smlal.4s	v4, v19, v0[2]
smull2.4s	v5, v16, v0[0]
smlal2.4s	v5, v18, v0[1]
smlal2.4s	v5, v19, v0[2]
saddw.4s	v2, v2, v19
saddw2.4s	v3, v3, v19
smull.4s	v6, v16, v0[2]
smlsl.4s	v6, v18, v0[0]
smlsl.4s	v6, v19, v0[1]
smull2.4s	v7, v16, v0[2]
smlsl2.4s	v7, v18, v0[0]
smlsl2.4s	v7, v19, v0[1]
mul.4s	v18, v2, v0[2]
mul.4s	v19, v3, v0[2]
smull.4s	v2, v17, v0[3]
smull2.4s	v3, v17, v0[3]
add.4s	v16, v4, v2
add.4s	v17, v5, v3
add.4s	v4, v4, v6
add.4s	v5, v5, v7
add.4s	v6, v6, v2
add.4s	v7, v7, v3
sub.4s	v4, v4, v2
sub.4s	v5, v5, v3
sqrshrn.4h	v18, v18, #12
sqrshrn2.8h	v18, v19, #12
sqrshrn.4h	v16, v16, #12
sqrshrn2.8h	v16, v17, #12
sqrshrn.4h	v17, v6, #12
sqrshrn2.8h	v17, v7, #12
sqrshrn.4h	v19, v4, #12
sqrshrn2.8h	v19, v5, #12
ret
_inv_flipadst_8h_x4_neon:
adrp	x16, inv_flipadst_8h_x4_neon
add	x16, x16, #0
ld1.8h	{ v0 }, [x16]
ssubl.4s	v2, v16, v18
ssubl2.4s	v3, v16, v18
smull.4s	v4, v16, v0[0]
smlal.4s	v4, v18, v0[1]
smlal.4s	v4, v19, v0[2]
smull2.4s	v5, v16, v0[0]
smlal2.4s	v5, v18, v0[1]
smlal2.4s	v5, v19, v0[2]
saddw.4s	v2, v2, v19
saddw2.4s	v3, v3, v19
smull.4s	v6, v16, v0[2]
smlsl.4s	v6, v18, v0[0]
smlsl.4s	v6, v19, v0[1]
smull2.4s	v7, v16, v0[2]
smlsl2.4s	v7, v18, v0[0]
smlsl2.4s	v7, v19, v0[1]
mul.4s	v18, v2, v0[2]
mul.4s	v19, v3, v0[2]
smull.4s	v2, v17, v0[3]
smull2.4s	v3, v17, v0[3]
add.4s	v16, v4, v2
add.4s	v17, v5, v3
add.4s	v4, v4, v6
add.4s	v5, v5, v7
add.4s	v6, v6, v2
add.4s	v7, v7, v3
sub.4s	v4, v4, v2
sub.4s	v5, v5, v3
sqrshrn.4h	v18, v18, #12
sqrshrn2.8h	v18, v19, #12
sqrshrn.4h	v19, v16, #12
sqrshrn2.8h	v19, v17, #12
mov.16b	v17, v18
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqrshrn.4h	v16, v4, #12
sqrshrn2.8h	v16, v5, #12
ret
_inv_identity_4h_x4_neon:
mov	w16, #13576
dup.4h	v0, w16
sqrdmulh.4h	v4, v16, v0[0]
sqrdmulh.4h	v5, v17, v0[0]
sqrdmulh.4h	v6, v18, v0[0]
sqrdmulh.4h	v7, v19, v0[0]
sqadd.4h	v16, v16, v4
sqadd.4h	v17, v17, v5
sqadd.4h	v18, v18, v6
sqadd.4h	v19, v19, v7
ret
_inv_identity_8h_x4_neon:
mov	w16, #13576
dup.4h	v0, w16
sqrdmulh.8h	v4, v16, v0[0]
sqrdmulh.8h	v5, v17, v0[0]
sqrdmulh.8h	v6, v18, v0[0]
sqrdmulh.8h	v7, v19, v0[0]
sqadd.8h	v16, v16, v4
sqadd.8h	v17, v17, v5
sqadd.8h	v18, v18, v6
sqadd.8h	v19, v19, v7
ret
_inv_txfm_add_wht_wht_4x4_8bpc_neon:
mov	x15, x30
movi.8h	v31, #0
ld1.4h	{ v16, v17, v18, v19 }, [x2]
st1.8h	{ v31 }, [x2], #16
sshr.4h	v16, v16, #2
sshr.4h	v17, v17, #2
sshr.4h	v18, v18, #2
sshr.4h	v19, v19, #2
add.4h	v16, v16, v17
sub.4h	v21, v18, v19
sub.4h	v20, v16, v21
sshr.4h	v20, v20, #1
sub.4h	v18, v20, v17
sub.4h	v17, v20, v19
add.4h	v19, v21, v18
sub.4h	v16, v16, v17
st1.8h	{ v31 }, [x2], #16
trn1.4h	v20, v16, v17
trn2.4h	v21, v16, v17
trn1.4h	v22, v18, v19
trn2.4h	v23, v18, v19
trn1.2s	v16, v20, v22
trn2.2s	v18, v20, v22
trn1.2s	v17, v21, v23
trn2.2s	v19, v21, v23
add.4h	v16, v16, v17
sub.4h	v21, v18, v19
sub.4h	v20, v16, v21
sshr.4h	v20, v20, #1
sub.4h	v18, v20, v17
sub.4h	v17, v20, v19
add.4h	v19, v21, v18
sub.4h	v16, v16, v17
ld1.s	{ v0 }[0], [x0], x1
ld1.s	{ v0 }[1], [x0], x1
mov.d	v16[1], v17[0]
mov.d	v18[1], v19[0]
ld1.s	{ v1 }[0], [x0], x1
ld1.s	{ v1 }[1], [x0], x1
b	inv_txfm_add_4x4_neon
_inv_txfm_add_4x4_neon:
movi.8h	v31, #0
ld1.4h	{ v16, v17, v18, v19 }, [x2]
st1.8h	{ v31 }, [x2], #16
blr	x4
st1.8h	{ v31 }, [x2], #16
trn1.4h	v20, v16, v17
trn2.4h	v21, v16, v17
trn1.4h	v22, v18, v19
trn2.4h	v23, v18, v19
trn1.2s	v16, v20, v22
trn2.2s	v18, v20, v22
trn1.2s	v17, v21, v23
trn2.2s	v19, v21, v23
blr	x5
ld1.s	{ v0 }[0], [x0], x1
ld1.s	{ v0 }[1], [x0], x1
mov.d	v16[1], v17[0]
mov.d	v18[1], v19[0]
ld1.s	{ v1 }[0], [x0], x1
ld1.s	{ v1 }[1], [x0], x1
srshr.8h	v16, v16, #4
srshr.8h	v18, v18, #4
sub	x0, x0, x1, lsl #2
uaddw.8h	v16, v16, v0
sqxtun.8b	v0, v16
uaddw.8h	v18, v18, v1
st1.s	{ v0 }[0], [x0], x1
sqxtun.8b	v1, v18
st1.s	{ v0 }[1], [x0], x1
st1.s	{ v1 }[0], [x0], x1
st1.s	{ v1 }[1], [x0], x1
ret	x15
_inv_txfm_add_dct_dct_4x4_8bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_4x4_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.8h	v4, w16
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v4[0]
ld1.s	{ v0 }[0], [x0], x1
sqrdmulh.8h	v20, v16, v4[0]
ld1.s	{ v0 }[1], [x0], x1
srshr.8h	v16, v20, #4
ld1.s	{ v1 }[0], [x0], x1
srshr.8h	v18, v20, #4
ld1.s	{ v1 }[1], [x0], x1
b	inv_txfm_add_4x4_neon
adr	x4, #-1144
adr	x5, #-1148
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-452
adr	x5, #-456
b	inv_txfm_add_4x4_neon
_inv_txfm_add_dct_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1176
adr	x5, #-972
b	inv_txfm_add_4x4_neon
_inv_txfm_add_dct_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1192
adr	x5, #-900
b	inv_txfm_add_4x4_neon
_inv_txfm_add_dct_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1208
adr	x5, #-504
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_dct_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1016
adr	x5, #-1228
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1032
adr	x5, #-1036
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1048
adr	x5, #-964
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_dct_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-976
adr	x5, #-1276
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-992
adr	x5, #-1084
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1008
adr	x5, #-1012
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_dct_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-612
adr	x5, #-1324
b	inv_txfm_add_4x4_neon
_inv_txfm_add_adst_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1128
adr	x5, #-632
b	inv_txfm_add_4x4_neon
_inv_txfm_add_flipadst_identity_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1056
adr	x5, #-648
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_adst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-660
adr	x5, #-1164
b	inv_txfm_add_4x4_neon
_inv_txfm_add_identity_flipadst_4x4_8bpc_neon:
mov	x15, x30
adr	x4, #-676
adr	x5, #-1092
b	inv_txfm_add_4x4_neon
_inv_dct_8h_x8_neon:
adrp	x16, inv_dct_8h_x8_neon
add	x16, x16, #0
ld1.8h	{ v0 }, [x16]
smull.4s	v6, v18, v0[3]
smlal.4s	v6, v22, v0[2]
smull2.4s	v7, v18, v0[3]
smlal2.4s	v7, v22, v0[2]
smull.4s	v4, v18, v0[2]
smlsl.4s	v4, v22, v0[3]
smull2.4s	v5, v18, v0[2]
smlsl2.4s	v5, v22, v0[3]
smull.4s	v2, v16, v0[0]
smlal.4s	v2, v20, v0[0]
smull2.4s	v3, v16, v0[0]
smlal2.4s	v3, v20, v0[0]
sqrshrn.4h	v6, v6, #12
sqrshrn2.8h	v6, v7, #12
sqrshrn.4h	v7, v4, #12
sqrshrn2.8h	v7, v5, #12
smull.4s	v4, v16, v0[0]
smlsl.4s	v4, v20, v0[0]
smull2.4s	v5, v16, v0[0]
smlsl2.4s	v5, v20, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn2.8h	v2, v3, #12
sqrshrn.4h	v3, v4, #12
sqrshrn2.8h	v3, v5, #12
sqadd.8h	v16, v2, v6
sqsub.8h	v22, v2, v6
sqadd.8h	v18, v3, v7
sqsub.8h	v20, v3, v7
smull.4s	v2, v17, v0[4]
smlsl.4s	v2, v23, v0[5]
smull2.4s	v3, v17, v0[4]
smlsl2.4s	v3, v23, v0[5]
smull.4s	v4, v17, v0[5]
smlal.4s	v4, v23, v0[4]
smull2.4s	v5, v17, v0[5]
smlal2.4s	v5, v23, v0[4]
smull.4s	v6, v21, v0[6]
smlsl.4s	v6, v19, v0[7]
smull2.4s	v7, v21, v0[6]
smlsl2.4s	v7, v19, v0[7]
sqrshrn.4h	v17, v2, #12
sqrshrn2.8h	v17, v3, #12
sqrshrn.4h	v23, v4, #12
sqrshrn2.8h	v23, v5, #12
smull.4s	v2, v21, v0[7]
smlal.4s	v2, v19, v0[6]
smull2.4s	v3, v21, v0[7]
smlal2.4s	v3, v19, v0[6]
sqrshrn.4h	v19, v6, #12
sqrshrn2.8h	v19, v7, #12
sqrshrn.4h	v21, v2, #12
sqrshrn2.8h	v21, v3, #12
sqadd.8h	v2, v17, v19
sqsub.8h	v17, v17, v19
sqadd.8h	v3, v23, v21
sqsub.8h	v19, v23, v21
smull.4s	v4, v19, v0[0]
smlsl.4s	v4, v17, v0[0]
smull2.4s	v5, v19, v0[0]
smlsl2.4s	v5, v17, v0[0]
smull.4s	v6, v19, v0[0]
smlal.4s	v6, v17, v0[0]
smull2.4s	v7, v19, v0[0]
smlal2.4s	v7, v17, v0[0]
sqrshrn.4h	v4, v4, #12
sqrshrn2.8h	v4, v5, #12
sqrshrn.4h	v5, v6, #12
sqrshrn2.8h	v5, v7, #12
sqsub.8h	v23, v16, v3
sqadd.8h	v16, v16, v3
sqadd.8h	v17, v18, v5
sqsub.8h	v6, v18, v5
sqadd.8h	v18, v20, v4
sqsub.8h	v21, v20, v4
sqadd.8h	v19, v22, v2
sqsub.8h	v20, v22, v2
mov.16b	v22, v6
ret
_inv_dct_4h_x8_neon:
adrp	x16, inv_dct_4h_x8_neon
add	x16, x16, #0
ld1.8h	{ v0 }, [x16]
smull.4s	v6, v18, v0[3]
smlal.4s	v6, v22, v0[2]
smull.4s	v4, v18, v0[2]
smlsl.4s	v4, v22, v0[3]
smull.4s	v2, v16, v0[0]
smlal.4s	v2, v20, v0[0]
sqrshrn.4h	v6, v6, #12
sqrshrn.4h	v7, v4, #12
smull.4s	v4, v16, v0[0]
smlsl.4s	v4, v20, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn.4h	v3, v4, #12
sqadd.4h	v16, v2, v6
sqsub.4h	v22, v2, v6
sqadd.4h	v18, v3, v7
sqsub.4h	v20, v3, v7
smull.4s	v2, v17, v0[4]
smlsl.4s	v2, v23, v0[5]
smull.4s	v4, v17, v0[5]
smlal.4s	v4, v23, v0[4]
smull.4s	v6, v21, v0[6]
smlsl.4s	v6, v19, v0[7]
sqrshrn.4h	v17, v2, #12
sqrshrn.4h	v23, v4, #12
smull.4s	v2, v21, v0[7]
smlal.4s	v2, v19, v0[6]
sqrshrn.4h	v19, v6, #12
sqrshrn.4h	v21, v2, #12
sqadd.4h	v2, v17, v19
sqsub.4h	v17, v17, v19
sqadd.4h	v3, v23, v21
sqsub.4h	v19, v23, v21
smull.4s	v4, v19, v0[0]
smlsl.4s	v4, v17, v0[0]
smull.4s	v6, v19, v0[0]
smlal.4s	v6, v17, v0[0]
sqrshrn.4h	v4, v4, #12
sqrshrn.4h	v5, v6, #12
sqsub.4h	v23, v16, v3
sqadd.4h	v16, v16, v3
sqadd.4h	v17, v18, v5
sqsub.4h	v6, v18, v5
sqadd.4h	v18, v20, v4
sqsub.4h	v21, v20, v4
sqadd.4h	v19, v22, v2
sqsub.4h	v20, v22, v2
mov.8b	v22, v6
ret
_inv_adst_8h_x8_neon:
adrp	x16, inv_adst_8h_x8_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
smull.4s	v2, v23, v0[0]
smlal.4s	v2, v16, v0[1]
smull2.4s	v3, v23, v0[0]
smlal2.4s	v3, v16, v0[1]
smull.4s	v4, v23, v0[1]
smlsl.4s	v4, v16, v0[0]
smull2.4s	v5, v23, v0[1]
smlsl2.4s	v5, v16, v0[0]
smull.4s	v6, v21, v0[2]
smlal.4s	v6, v18, v0[3]
smull2.4s	v7, v21, v0[2]
smlal2.4s	v7, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn2.8h	v16, v3, #12
sqrshrn.4h	v23, v4, #12
sqrshrn2.8h	v23, v5, #12
smull.4s	v2, v21, v0[3]
smlsl.4s	v2, v18, v0[2]
smull2.4s	v3, v21, v0[3]
smlsl2.4s	v3, v18, v0[2]
smull.4s	v4, v19, v0[4]
smlal.4s	v4, v20, v0[5]
smull2.4s	v5, v19, v0[4]
smlal2.4s	v5, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqrshrn.4h	v21, v2, #12
sqrshrn2.8h	v21, v3, #12
smull.4s	v6, v19, v0[5]
smlsl.4s	v6, v20, v0[4]
smull2.4s	v7, v19, v0[5]
smlsl2.4s	v7, v20, v0[4]
smull.4s	v2, v17, v0[6]
smlal.4s	v2, v22, v0[7]
smull2.4s	v3, v17, v0[6]
smlal2.4s	v3, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v19, v6, #12
sqrshrn2.8h	v19, v7, #12
smull.4s	v4, v17, v0[7]
smlsl.4s	v4, v22, v0[6]
smull2.4s	v5, v17, v0[7]
smlsl2.4s	v5, v22, v0[6]
sqrshrn.4h	v22, v2, #12
sqrshrn2.8h	v22, v3, #12
sqrshrn.4h	v17, v4, #12
sqrshrn2.8h	v17, v5, #12
sqadd.8h	v2, v16, v20
sqsub.8h	v3, v16, v20
sqadd.8h	v4, v23, v19
sqsub.8h	v5, v23, v19
sqadd.8h	v6, v18, v22
sqsub.8h	v7, v18, v22
sqadd.8h	v18, v21, v17
sqsub.8h	v19, v21, v17
smull.4s	v16, v3, v1[3]
smlal.4s	v16, v5, v1[2]
smull2.4s	v17, v3, v1[3]
smlal2.4s	v17, v5, v1[2]
smull.4s	v20, v3, v1[2]
smlsl.4s	v20, v5, v1[3]
smull2.4s	v21, v3, v1[2]
smlsl2.4s	v21, v5, v1[3]
smull.4s	v22, v19, v1[3]
smlsl.4s	v22, v7, v1[2]
smull2.4s	v23, v19, v1[3]
smlsl2.4s	v23, v7, v1[2]
sqrshrn.4h	v3, v16, #12
sqrshrn2.8h	v3, v17, #12
sqrshrn.4h	v5, v20, #12
sqrshrn2.8h	v5, v21, #12
smull.4s	v16, v19, v1[2]
smlal.4s	v16, v7, v1[3]
smull2.4s	v17, v19, v1[2]
smlal2.4s	v17, v7, v1[3]
sqrshrn.4h	v7, v22, #12
sqrshrn2.8h	v7, v23, #12
sqrshrn.4h	v19, v16, #12
sqrshrn2.8h	v19, v17, #12
sqadd.8h	v16, v2, v6
sqsub.8h	v2, v2, v6
sqadd.8h	v23, v4, v18
sqsub.8h	v4, v4, v18
sqneg.8h	v23, v23
sqadd.8h	v17, v3, v7
sqsub.8h	v3, v3, v7
sqadd.8h	v22, v5, v19
sqsub.8h	v5, v5, v19
sqneg.8h	v17, v17
smull.4s	v18, v2, v1[0]
smlal.4s	v18, v4, v1[0]
smull2.4s	v19, v2, v1[0]
smlal2.4s	v19, v4, v1[0]
smull.4s	v6, v2, v1[0]
smlsl.4s	v6, v4, v1[0]
smull2.4s	v7, v2, v1[0]
smlsl2.4s	v7, v4, v1[0]
smull.4s	v20, v3, v1[0]
smlsl.4s	v20, v5, v1[0]
smull2.4s	v21, v3, v1[0]
smlsl2.4s	v21, v5, v1[0]
sqrshrn.4h	v2, v18, #12
sqrshrn2.8h	v2, v19, #12
smull.4s	v18, v3, v1[0]
smlal.4s	v18, v5, v1[0]
smull2.4s	v19, v3, v1[0]
smlal2.4s	v19, v5, v1[0]
sqrshrn.4h	v3, v20, #12
sqrshrn2.8h	v3, v21, #12
sqrshrn.4h	v18, v18, #12
sqrshrn2.8h	v18, v19, #12
sqrshrn.4h	v20, v6, #12
sqrshrn2.8h	v20, v7, #12
sqneg.8h	v19, v2
sqneg.8h	v21, v3
ret
_inv_flipadst_8h_x8_neon:
adrp	x16, inv_flipadst_8h_x8_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
smull.4s	v2, v23, v0[0]
smlal.4s	v2, v16, v0[1]
smull2.4s	v3, v23, v0[0]
smlal2.4s	v3, v16, v0[1]
smull.4s	v4, v23, v0[1]
smlsl.4s	v4, v16, v0[0]
smull2.4s	v5, v23, v0[1]
smlsl2.4s	v5, v16, v0[0]
smull.4s	v6, v21, v0[2]
smlal.4s	v6, v18, v0[3]
smull2.4s	v7, v21, v0[2]
smlal2.4s	v7, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn2.8h	v16, v3, #12
sqrshrn.4h	v23, v4, #12
sqrshrn2.8h	v23, v5, #12
smull.4s	v2, v21, v0[3]
smlsl.4s	v2, v18, v0[2]
smull2.4s	v3, v21, v0[3]
smlsl2.4s	v3, v18, v0[2]
smull.4s	v4, v19, v0[4]
smlal.4s	v4, v20, v0[5]
smull2.4s	v5, v19, v0[4]
smlal2.4s	v5, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqrshrn.4h	v21, v2, #12
sqrshrn2.8h	v21, v3, #12
smull.4s	v6, v19, v0[5]
smlsl.4s	v6, v20, v0[4]
smull2.4s	v7, v19, v0[5]
smlsl2.4s	v7, v20, v0[4]
smull.4s	v2, v17, v0[6]
smlal.4s	v2, v22, v0[7]
smull2.4s	v3, v17, v0[6]
smlal2.4s	v3, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v19, v6, #12
sqrshrn2.8h	v19, v7, #12
smull.4s	v4, v17, v0[7]
smlsl.4s	v4, v22, v0[6]
smull2.4s	v5, v17, v0[7]
smlsl2.4s	v5, v22, v0[6]
sqrshrn.4h	v22, v2, #12
sqrshrn2.8h	v22, v3, #12
sqrshrn.4h	v17, v4, #12
sqrshrn2.8h	v17, v5, #12
sqadd.8h	v2, v16, v20
sqsub.8h	v3, v16, v20
sqadd.8h	v4, v23, v19
sqsub.8h	v5, v23, v19
sqadd.8h	v6, v18, v22
sqsub.8h	v7, v18, v22
sqadd.8h	v18, v21, v17
sqsub.8h	v19, v21, v17
smull.4s	v16, v3, v1[3]
smlal.4s	v16, v5, v1[2]
smull2.4s	v17, v3, v1[3]
smlal2.4s	v17, v5, v1[2]
smull.4s	v20, v3, v1[2]
smlsl.4s	v20, v5, v1[3]
smull2.4s	v21, v3, v1[2]
smlsl2.4s	v21, v5, v1[3]
smull.4s	v22, v19, v1[3]
smlsl.4s	v22, v7, v1[2]
smull2.4s	v23, v19, v1[3]
smlsl2.4s	v23, v7, v1[2]
sqrshrn.4h	v3, v16, #12
sqrshrn2.8h	v3, v17, #12
sqrshrn.4h	v5, v20, #12
sqrshrn2.8h	v5, v21, #12
smull.4s	v16, v19, v1[2]
smlal.4s	v16, v7, v1[3]
smull2.4s	v17, v19, v1[2]
smlal2.4s	v17, v7, v1[3]
sqrshrn.4h	v7, v22, #12
sqrshrn2.8h	v7, v23, #12
sqrshrn.4h	v19, v16, #12
sqrshrn2.8h	v19, v17, #12
sqadd.8h	v23, v2, v6
sqsub.8h	v2, v2, v6
sqadd.8h	v16, v4, v18
sqsub.8h	v4, v4, v18
sqneg.8h	v16, v16
sqadd.8h	v22, v3, v7
sqsub.8h	v3, v3, v7
sqadd.8h	v17, v5, v19
sqsub.8h	v5, v5, v19
sqneg.8h	v22, v22
smull.4s	v18, v2, v1[0]
smlal.4s	v18, v4, v1[0]
smull2.4s	v19, v2, v1[0]
smlal2.4s	v19, v4, v1[0]
smull.4s	v6, v2, v1[0]
smlsl.4s	v6, v4, v1[0]
smull2.4s	v7, v2, v1[0]
smlsl2.4s	v7, v4, v1[0]
smull.4s	v20, v3, v1[0]
smlsl.4s	v20, v5, v1[0]
smull2.4s	v21, v3, v1[0]
smlsl2.4s	v21, v5, v1[0]
sqrshrn.4h	v2, v18, #12
sqrshrn2.8h	v2, v19, #12
smull.4s	v18, v3, v1[0]
smlal.4s	v18, v5, v1[0]
smull2.4s	v19, v3, v1[0]
smlal2.4s	v19, v5, v1[0]
sqrshrn.4h	v3, v20, #12
sqrshrn2.8h	v3, v21, #12
sqrshrn.4h	v21, v18, #12
sqrshrn2.8h	v21, v19, #12
sqrshrn.4h	v19, v6, #12
sqrshrn2.8h	v19, v7, #12
sqneg.8h	v20, v2
sqneg.8h	v18, v3
ret
_inv_adst_4h_x8_neon:
adrp	x16, inv_adst_4h_x8_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
smull.4s	v2, v23, v0[0]
smlal.4s	v2, v16, v0[1]
smull.4s	v4, v23, v0[1]
smlsl.4s	v4, v16, v0[0]
smull.4s	v6, v21, v0[2]
smlal.4s	v6, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn.4h	v23, v4, #12
smull.4s	v2, v21, v0[3]
smlsl.4s	v2, v18, v0[2]
smull.4s	v4, v19, v0[4]
smlal.4s	v4, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn.4h	v21, v2, #12
smull.4s	v6, v19, v0[5]
smlsl.4s	v6, v20, v0[4]
smull.4s	v2, v17, v0[6]
smlal.4s	v2, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn.4h	v19, v6, #12
smull.4s	v4, v17, v0[7]
smlsl.4s	v4, v22, v0[6]
sqrshrn.4h	v22, v2, #12
sqrshrn.4h	v17, v4, #12
sqadd.4h	v2, v16, v20
sqsub.4h	v3, v16, v20
sqadd.4h	v4, v23, v19
sqsub.4h	v5, v23, v19
sqadd.4h	v6, v18, v22
sqsub.4h	v7, v18, v22
sqadd.4h	v18, v21, v17
sqsub.4h	v19, v21, v17
smull.4s	v16, v3, v1[3]
smlal.4s	v16, v5, v1[2]
smull.4s	v20, v3, v1[2]
smlsl.4s	v20, v5, v1[3]
smull.4s	v22, v19, v1[3]
smlsl.4s	v22, v7, v1[2]
sqrshrn.4h	v3, v16, #12
sqrshrn.4h	v5, v20, #12
smull.4s	v16, v19, v1[2]
smlal.4s	v16, v7, v1[3]
sqrshrn.4h	v7, v22, #12
sqrshrn.4h	v19, v16, #12
sqadd.4h	v16, v2, v6
sqsub.4h	v2, v2, v6
sqadd.4h	v23, v4, v18
sqsub.4h	v4, v4, v18
sqneg.4h	v23, v23
sqadd.4h	v17, v3, v7
sqsub.4h	v3, v3, v7
sqadd.4h	v22, v5, v19
sqsub.4h	v5, v5, v19
sqneg.4h	v17, v17
smull.4s	v18, v2, v1[0]
smlal.4s	v18, v4, v1[0]
smull.4s	v6, v2, v1[0]
smlsl.4s	v6, v4, v1[0]
smull.4s	v20, v3, v1[0]
smlsl.4s	v20, v5, v1[0]
sqrshrn.4h	v2, v18, #12
smull.4s	v18, v3, v1[0]
smlal.4s	v18, v5, v1[0]
sqrshrn.4h	v3, v20, #12
sqrshrn.4h	v18, v18, #12
sqrshrn.4h	v20, v6, #12
sqneg.4h	v19, v2
sqneg.4h	v21, v3
ret
_inv_flipadst_4h_x8_neon:
adrp	x16, inv_flipadst_4h_x8_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
smull.4s	v2, v23, v0[0]
smlal.4s	v2, v16, v0[1]
smull.4s	v4, v23, v0[1]
smlsl.4s	v4, v16, v0[0]
smull.4s	v6, v21, v0[2]
smlal.4s	v6, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn.4h	v23, v4, #12
smull.4s	v2, v21, v0[3]
smlsl.4s	v2, v18, v0[2]
smull.4s	v4, v19, v0[4]
smlal.4s	v4, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn.4h	v21, v2, #12
smull.4s	v6, v19, v0[5]
smlsl.4s	v6, v20, v0[4]
smull.4s	v2, v17, v0[6]
smlal.4s	v2, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn.4h	v19, v6, #12
smull.4s	v4, v17, v0[7]
smlsl.4s	v4, v22, v0[6]
sqrshrn.4h	v22, v2, #12
sqrshrn.4h	v17, v4, #12
sqadd.4h	v2, v16, v20
sqsub.4h	v3, v16, v20
sqadd.4h	v4, v23, v19
sqsub.4h	v5, v23, v19
sqadd.4h	v6, v18, v22
sqsub.4h	v7, v18, v22
sqadd.4h	v18, v21, v17
sqsub.4h	v19, v21, v17
smull.4s	v16, v3, v1[3]
smlal.4s	v16, v5, v1[2]
smull.4s	v20, v3, v1[2]
smlsl.4s	v20, v5, v1[3]
smull.4s	v22, v19, v1[3]
smlsl.4s	v22, v7, v1[2]
sqrshrn.4h	v3, v16, #12
sqrshrn.4h	v5, v20, #12
smull.4s	v16, v19, v1[2]
smlal.4s	v16, v7, v1[3]
sqrshrn.4h	v7, v22, #12
sqrshrn.4h	v19, v16, #12
sqadd.4h	v23, v2, v6
sqsub.4h	v2, v2, v6
sqadd.4h	v16, v4, v18
sqsub.4h	v4, v4, v18
sqneg.4h	v16, v16
sqadd.4h	v22, v3, v7
sqsub.4h	v3, v3, v7
sqadd.4h	v17, v5, v19
sqsub.4h	v5, v5, v19
sqneg.4h	v22, v22
smull.4s	v18, v2, v1[0]
smlal.4s	v18, v4, v1[0]
smull.4s	v6, v2, v1[0]
smlsl.4s	v6, v4, v1[0]
smull.4s	v20, v3, v1[0]
smlsl.4s	v20, v5, v1[0]
sqrshrn.4h	v2, v18, #12
smull.4s	v18, v3, v1[0]
smlal.4s	v18, v5, v1[0]
sqrshrn.4h	v3, v20, #12
sqrshrn.4h	v21, v18, #12
sqrshrn.4h	v19, v6, #12
sqneg.4h	v20, v2
sqneg.4h	v18, v3
ret
_inv_identity_8h_x8_neon:
sqshl.8h	v16, v16, #1
sqshl.8h	v17, v17, #1
sqshl.8h	v18, v18, #1
sqshl.8h	v19, v19, #1
sqshl.8h	v20, v20, #1
sqshl.8h	v21, v21, #1
sqshl.8h	v22, v22, #1
sqshl.8h	v23, v23, #1
ret
_inv_identity_4h_x8_neon:
sqshl.4h	v16, v16, #1
sqshl.4h	v17, v17, #1
sqshl.4h	v18, v18, #1
sqshl.4h	v19, v19, #1
sqshl.4h	v20, v20, #1
sqshl.4h	v21, v21, #1
sqshl.4h	v22, v22, #1
sqshl.4h	v23, v23, #1
ret
_inv_txfm_identity_add_8x8_neon:
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
ld1.8h	{ v16, v17, v18, v19 }, [x2]
st1.8h	{ v28, v29, v30, v31 }, [x2], #64
ld1.8h	{ v20, v21, v22, v23 }, [x2]
st1.8h	{ v28, v29, v30, v31 }, [x2]
b	inv_txfm_add_8x8_neon
_inv_txfm_add_8x8_neon:
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
ld1.8h	{ v16, v17, v18, v19 }, [x2]
st1.8h	{ v28, v29, v30, v31 }, [x2], #64
ld1.8h	{ v20, v21, v22, v23 }, [x2]
st1.8h	{ v28, v29, v30, v31 }, [x2]
blr	x4
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
srshr.8h	v20, v20, #1
srshr.8h	v21, v21, #1
srshr.8h	v22, v22, #1
srshr.8h	v23, v23, #1
trn1.8h	v24, v16, v17
trn2.8h	v25, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v25, v19
trn2.4s	v25, v25, v19
trn1.4s	v19, v24, v17
trn2.4s	v24, v24, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v24, v18
trn1.2d	v18, v24, v18
trn1.2d	v19, v25, v23
trn2.2d	v23, v25, v23
blr	x5
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
ret	x15
_inv_txfm_add_dct_dct_8x8_8bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_8x8_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #8
b	idct_dc_w8_neon
adr	x5, #-2556
adr	x4, #-2560
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-508
b	inv_txfm_identity_add_8x8_neon
_inv_txfm_add_dct_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2056
adr	x4, #-2588
b	inv_txfm_add_8x8_neon
_inv_txfm_add_dct_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-1592
adr	x4, #-2604
b	inv_txfm_add_8x8_neon
_inv_txfm_add_dct_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-552
adr	x4, #-2620
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_dct_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2632
adr	x4, #-2108
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2120
adr	x4, #-2124
b	inv_txfm_add_8x8_neon
_inv_txfm_add_adst_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-1656
adr	x4, #-2140
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_dct_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2680
adr	x4, #-1676
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2168
adr	x4, #-1692
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-1704
adr	x4, #-1708
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_dct_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2728
b	inv_txfm_identity_add_8x8_neon
_inv_txfm_add_adst_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-676
adr	x4, #-2216
b	inv_txfm_add_8x8_neon
_inv_txfm_add_flipadst_identity_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-692
adr	x4, #-1752
b	inv_txfm_add_8x8_neon
_inv_txfm_add_identity_adst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-2244
b	inv_txfm_identity_add_8x8_neon
_inv_txfm_add_identity_flipadst_8x8_8bpc_neon:
mov	x15, x30
adr	x5, #-1776
b	inv_txfm_identity_add_8x8_neon
_inv_txfm_add_8x4_neon:
movi.8h	v30, #0
movi.8h	v31, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.4h	{ v16, v17, v18, v19 }, [x2]
st1.8h	{ v30, v31 }, [x2], #32
ld1.4h	{ v20, v21, v22, v23 }, [x2]
st1.8h	{ v30, v31 }, [x2]
sqrdmulh.4h	v16, v16, v0[0]
sqrdmulh.4h	v17, v17, v0[0]
sqrdmulh.4h	v18, v18, v0[0]
sqrdmulh.4h	v19, v19, v0[0]
sqrdmulh.4h	v20, v20, v0[0]
sqrdmulh.4h	v21, v21, v0[0]
sqrdmulh.4h	v22, v22, v0[0]
sqrdmulh.4h	v23, v23, v0[0]
blr	x4
trn1.4h	v4, v16, v17
trn2.4h	v5, v16, v17
trn1.4h	v6, v18, v19
trn2.4h	v7, v18, v19
trn1.2s	v16, v4, v6
trn2.2s	v18, v4, v6
trn1.2s	v17, v5, v7
trn2.2s	v19, v5, v7
trn1.4h	v4, v20, v21
trn2.4h	v5, v20, v21
trn1.4h	v6, v22, v23
trn2.4h	v7, v22, v23
trn1.2s	v20, v4, v6
trn2.2s	v22, v4, v6
trn1.2s	v21, v5, v7
trn2.2s	v23, v5, v7
mov.d	v16[1], v20[0]
mov.d	v17[1], v21[0]
mov.d	v18[1], v22[0]
mov.d	v19[1], v23[0]
blr	x5
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
st1.8b	{ v5 }, [x0], x1
ret	x15
_inv_txfm_add_4x8_neon:
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16, v17, v18, v19 }, [x2]
st1.8h	{ v28, v29, v30, v31 }, [x2]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
blr	x4
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v6, v18, v19
trn2.8h	v7, v18, v19
trn1.4s	v16, v4, v6
trn2.4s	v18, v4, v6
trn1.4s	v17, v5, v7
trn2.4s	v19, v5, v7
mov.d	v20[0], v16[1]
mov.d	v21[0], v17[1]
mov.d	v22[0], v18[1]
mov.d	v23[0], v19[1]
blr	x5
mov	x7, x0
ld1.s	{ v0 }[0], [x7], x1
mov.d	v16[1], v17[0]
ld1.s	{ v0 }[1], [x7], x1
ld1.s	{ v1 }[0], [x7], x1
mov.d	v18[1], v19[0]
ld1.s	{ v1 }[1], [x7], x1
ld1.s	{ v2 }[0], [x7], x1
mov.d	v20[1], v21[0]
srshr.8h	v16, v16, #4
ld1.s	{ v2 }[1], [x7], x1
ld1.s	{ v3 }[0], [x7], x1
mov.d	v22[1], v23[0]
srshr.8h	v18, v18, #4
ld1.s	{ v3 }[1], [x7], x1
uaddw.8h	v16, v16, v0
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v1
sqxtun.8b	v0, v16
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v2
st1.s	{ v0 }[0], [x0], x1
sqxtun.8b	v1, v18
st1.s	{ v0 }[1], [x0], x1
uaddw.8h	v22, v22, v3
st1.s	{ v1 }[0], [x0], x1
sqxtun.8b	v2, v20
st1.s	{ v1 }[1], [x0], x1
st1.s	{ v2 }[0], [x0], x1
sqxtun.8b	v3, v22
st1.s	{ v2 }[1], [x0], x1
st1.s	{ v3 }[0], [x0], x1
st1.s	{ v3 }[1], [x0], x1
ret	x15
_inv_txfm_add_dct_dct_4x8_8bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_4x8_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #8
b	ltmp0
adr	x4, #-4636
adr	x5, #-3000
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-3980
adr	x5, #-1240
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4668
adr	x5, #-1868
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4684
adr	x5, #-1596
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4700
adr	x5, #-1288
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_dct_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4412
adr	x5, #-3080
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4428
adr	x5, #-1932
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4444
adr	x5, #-1660
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_dct_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4300
adr	x5, #-3128
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4316
adr	x5, #-1980
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4332
adr	x5, #-1708
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_dct_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4140
adr	x5, #-3176
b	inv_txfm_add_4x8_neon
_inv_txfm_add_adst_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4524
adr	x5, #-1416
b	inv_txfm_add_4x8_neon
_inv_txfm_add_flipadst_identity_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4380
adr	x5, #-1432
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_adst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4188
adr	x5, #-2060
b	inv_txfm_add_4x8_neon
_inv_txfm_add_identity_flipadst_4x8_8bpc_neon:
mov	x15, x30
adr	x4, #-4204
adr	x5, #-1788
b	inv_txfm_add_4x8_neon
_inv_txfm_add_dct_dct_8x4_8bpc_neon:
mov	x15, x30
cbnz	w3, inv_txfm_add_dct_dct_8x4_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #4
b	idct_dc_w8_neon
adr	x4, #-3296
adr	x5, #-4940
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1536
adr	x5, #-4284
b	inv_txfm_add_8x4_neon
_inv_txfm_add_dct_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-3328
adr	x5, #-4668
b	inv_txfm_add_8x4_neon
_inv_txfm_add_dct_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-3344
adr	x5, #-4524
b	inv_txfm_add_8x4_neon
_inv_txfm_add_dct_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-3360
adr	x5, #-4332
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_dct_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-2212
adr	x5, #-5020
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-2228
adr	x5, #-4732
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-2244
adr	x5, #-4588
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_dct_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1972
adr	x5, #-5068
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1988
adr	x5, #-4780
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-2004
adr	x5, #-4636
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_dct_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1696
adr	x5, #-5116
b	inv_txfm_add_8x4_neon
_inv_txfm_add_adst_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-2324
adr	x5, #-4460
b	inv_txfm_add_8x4_neon
_inv_txfm_add_flipadst_identity_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-2052
adr	x5, #-4476
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_adst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1744
adr	x5, #-4860
b	inv_txfm_add_8x4_neon
_inv_txfm_add_identity_flipadst_8x4_8bpc_neon:
mov	x15, x30
adr	x4, #-1760
adr	x5, #-4716
b	inv_txfm_add_8x4_neon
_inv_dct_8h_x16_neon:
adrp	x16, inv_dct_8h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
smull.4s	v6, v20, v0[3]
smlal.4s	v6, v28, v0[2]
smull2.4s	v7, v20, v0[3]
smlal2.4s	v7, v28, v0[2]
smull.4s	v4, v20, v0[2]
smlsl.4s	v4, v28, v0[3]
smull2.4s	v5, v20, v0[2]
smlsl2.4s	v5, v28, v0[3]
smull.4s	v2, v16, v0[0]
smlal.4s	v2, v24, v0[0]
smull2.4s	v3, v16, v0[0]
smlal2.4s	v3, v24, v0[0]
sqrshrn.4h	v6, v6, #12
sqrshrn2.8h	v6, v7, #12
sqrshrn.4h	v7, v4, #12
sqrshrn2.8h	v7, v5, #12
smull.4s	v4, v16, v0[0]
smlsl.4s	v4, v24, v0[0]
smull2.4s	v5, v16, v0[0]
smlsl2.4s	v5, v24, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn2.8h	v2, v3, #12
sqrshrn.4h	v3, v4, #12
sqrshrn2.8h	v3, v5, #12
sqadd.8h	v16, v2, v6
sqsub.8h	v28, v2, v6
sqadd.8h	v20, v3, v7
sqsub.8h	v24, v3, v7
smull.4s	v2, v18, v0[4]
smlsl.4s	v2, v30, v0[5]
smull2.4s	v3, v18, v0[4]
smlsl2.4s	v3, v30, v0[5]
smull.4s	v4, v18, v0[5]
smlal.4s	v4, v30, v0[4]
smull2.4s	v5, v18, v0[5]
smlal2.4s	v5, v30, v0[4]
smull.4s	v6, v26, v0[6]
smlsl.4s	v6, v22, v0[7]
smull2.4s	v7, v26, v0[6]
smlsl2.4s	v7, v22, v0[7]
sqrshrn.4h	v18, v2, #12
sqrshrn2.8h	v18, v3, #12
sqrshrn.4h	v30, v4, #12
sqrshrn2.8h	v30, v5, #12
smull.4s	v2, v26, v0[7]
smlal.4s	v2, v22, v0[6]
smull2.4s	v3, v26, v0[7]
smlal2.4s	v3, v22, v0[6]
sqrshrn.4h	v22, v6, #12
sqrshrn2.8h	v22, v7, #12
sqrshrn.4h	v26, v2, #12
sqrshrn2.8h	v26, v3, #12
sqadd.8h	v2, v18, v22
sqsub.8h	v18, v18, v22
sqadd.8h	v3, v30, v26
sqsub.8h	v22, v30, v26
smull.4s	v4, v22, v0[0]
smlsl.4s	v4, v18, v0[0]
smull2.4s	v5, v22, v0[0]
smlsl2.4s	v5, v18, v0[0]
smull.4s	v6, v22, v0[0]
smlal.4s	v6, v18, v0[0]
smull2.4s	v7, v22, v0[0]
smlal2.4s	v7, v18, v0[0]
sqrshrn.4h	v4, v4, #12
sqrshrn2.8h	v4, v5, #12
sqrshrn.4h	v5, v6, #12
sqrshrn2.8h	v5, v7, #12
sqsub.8h	v30, v16, v3
sqadd.8h	v16, v16, v3
sqadd.8h	v18, v20, v5
sqsub.8h	v6, v20, v5
sqadd.8h	v20, v24, v4
sqsub.8h	v26, v24, v4
sqadd.8h	v22, v28, v2
sqsub.8h	v24, v28, v2
mov.16b	v28, v6
smull.4s	v2, v17, v1[0]
smlsl.4s	v2, v31, v1[1]
smull2.4s	v3, v17, v1[0]
smlsl2.4s	v3, v31, v1[1]
smull.4s	v4, v17, v1[1]
smlal.4s	v4, v31, v1[0]
smull2.4s	v5, v17, v1[1]
smlal2.4s	v5, v31, v1[0]
smull.4s	v6, v25, v1[2]
smlsl.4s	v6, v23, v1[3]
smull2.4s	v7, v25, v1[2]
smlsl2.4s	v7, v23, v1[3]
sqrshrn.4h	v17, v2, #12
sqrshrn2.8h	v17, v3, #12
sqrshrn.4h	v31, v4, #12
sqrshrn2.8h	v31, v5, #12
smull.4s	v2, v25, v1[3]
smlal.4s	v2, v23, v1[2]
smull2.4s	v3, v25, v1[3]
smlal2.4s	v3, v23, v1[2]
smull.4s	v4, v21, v1[4]
smlsl.4s	v4, v27, v1[5]
smull2.4s	v5, v21, v1[4]
smlsl2.4s	v5, v27, v1[5]
sqrshrn.4h	v23, v6, #12
sqrshrn2.8h	v23, v7, #12
sqrshrn.4h	v25, v2, #12
sqrshrn2.8h	v25, v3, #12
smull.4s	v6, v21, v1[5]
smlal.4s	v6, v27, v1[4]
smull2.4s	v7, v21, v1[5]
smlal2.4s	v7, v27, v1[4]
smull.4s	v2, v29, v1[6]
smlsl.4s	v2, v19, v1[7]
smull2.4s	v3, v29, v1[6]
smlsl2.4s	v3, v19, v1[7]
sqrshrn.4h	v21, v4, #12
sqrshrn2.8h	v21, v5, #12
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
smull.4s	v4, v29, v1[7]
smlal.4s	v4, v19, v1[6]
smull2.4s	v5, v29, v1[7]
smlal2.4s	v5, v19, v1[6]
sqrshrn.4h	v19, v2, #12
sqrshrn2.8h	v19, v3, #12
sqrshrn.4h	v29, v4, #12
sqrshrn2.8h	v29, v5, #12
sqsub.8h	v2, v17, v23
sqadd.8h	v17, v17, v23
sqsub.8h	v3, v31, v25
sqadd.8h	v31, v31, v25
sqsub.8h	v23, v19, v21
sqadd.8h	v19, v19, v21
sqadd.8h	v25, v29, v27
sqsub.8h	v29, v29, v27
smull.4s	v4, v3, v0[2]
smlsl.4s	v4, v2, v0[3]
smull2.4s	v5, v3, v0[2]
smlsl2.4s	v5, v2, v0[3]
smull.4s	v6, v3, v0[3]
smlal.4s	v6, v2, v0[2]
smull2.4s	v7, v3, v0[3]
smlal2.4s	v7, v2, v0[2]
sqrshrn.4h	v21, v4, #12
sqrshrn2.8h	v21, v5, #12
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
smull.4s	v4, v29, v0[2]
smlsl.4s	v4, v23, v0[3]
smull2.4s	v5, v29, v0[2]
smlsl2.4s	v5, v23, v0[3]
smull.4s	v6, v29, v0[3]
smlal.4s	v6, v23, v0[2]
smull2.4s	v7, v29, v0[3]
smlal2.4s	v7, v23, v0[2]
sqrshrn.4h	v29, v4, #12
sqrshrn2.8h	v29, v5, #12
neg.4s	v6, v6
neg.4s	v7, v7
sqrshrn.4h	v23, v6, #12
sqrshrn2.8h	v23, v7, #12
sqsub.8h	v2, v17, v19
sqadd.8h	v17, v17, v19
sqsub.8h	v3, v31, v25
sqadd.8h	v31, v31, v25
sqadd.8h	v19, v21, v23
sqsub.8h	v21, v21, v23
sqsub.8h	v25, v27, v29
sqadd.8h	v27, v27, v29
smull.4s	v4, v3, v0[0]
smlsl.4s	v4, v2, v0[0]
smull2.4s	v5, v3, v0[0]
smlsl2.4s	v5, v2, v0[0]
smull.4s	v6, v3, v0[0]
smlal.4s	v6, v2, v0[0]
smull2.4s	v7, v3, v0[0]
smlal2.4s	v7, v2, v0[0]
smull.4s	v2, v25, v0[0]
smlsl.4s	v2, v21, v0[0]
smull2.4s	v3, v25, v0[0]
smlsl2.4s	v3, v21, v0[0]
sqrshrn.4h	v4, v4, #12
sqrshrn2.8h	v4, v5, #12
sqrshrn.4h	v5, v6, #12
sqrshrn2.8h	v5, v7, #12
smull.4s	v6, v25, v0[0]
smlal.4s	v6, v21, v0[0]
smull2.4s	v7, v25, v0[0]
smlal2.4s	v7, v21, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn2.8h	v2, v3, #12
sqrshrn.4h	v3, v6, #12
sqrshrn2.8h	v3, v7, #12
sqadd.8h	v6, v16, v31
sqsub.8h	v31, v16, v31
mov.16b	v16, v6
sqadd.8h	v23, v30, v17
sqsub.8h	v7, v30, v17
sqadd.8h	v17, v18, v27
sqsub.8h	v30, v18, v27
sqadd.8h	v18, v20, v3
sqsub.8h	v29, v20, v3
sqadd.8h	v3, v28, v19
sqsub.8h	v25, v28, v19
sqadd.8h	v19, v22, v5
sqsub.8h	v28, v22, v5
sqadd.8h	v20, v24, v4
sqsub.8h	v27, v24, v4
sqadd.8h	v21, v26, v2
sqsub.8h	v26, v26, v2
mov.16b	v24, v7
mov.16b	v22, v3
ret
_inv_dct_4h_x16_neon:
adrp	x16, inv_dct_4h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
smull.4s	v6, v20, v0[3]
smlal.4s	v6, v28, v0[2]
smull.4s	v4, v20, v0[2]
smlsl.4s	v4, v28, v0[3]
smull.4s	v2, v16, v0[0]
smlal.4s	v2, v24, v0[0]
sqrshrn.4h	v6, v6, #12
sqrshrn.4h	v7, v4, #12
smull.4s	v4, v16, v0[0]
smlsl.4s	v4, v24, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn.4h	v3, v4, #12
sqadd.4h	v16, v2, v6
sqsub.4h	v28, v2, v6
sqadd.4h	v20, v3, v7
sqsub.4h	v24, v3, v7
smull.4s	v2, v18, v0[4]
smlsl.4s	v2, v30, v0[5]
smull.4s	v4, v18, v0[5]
smlal.4s	v4, v30, v0[4]
smull.4s	v6, v26, v0[6]
smlsl.4s	v6, v22, v0[7]
sqrshrn.4h	v18, v2, #12
sqrshrn.4h	v30, v4, #12
smull.4s	v2, v26, v0[7]
smlal.4s	v2, v22, v0[6]
sqrshrn.4h	v22, v6, #12
sqrshrn.4h	v26, v2, #12
sqadd.4h	v2, v18, v22
sqsub.4h	v18, v18, v22
sqadd.4h	v3, v30, v26
sqsub.4h	v22, v30, v26
smull.4s	v4, v22, v0[0]
smlsl.4s	v4, v18, v0[0]
smull.4s	v6, v22, v0[0]
smlal.4s	v6, v18, v0[0]
sqrshrn.4h	v4, v4, #12
sqrshrn.4h	v5, v6, #12
sqsub.4h	v30, v16, v3
sqadd.4h	v16, v16, v3
sqadd.4h	v18, v20, v5
sqsub.4h	v6, v20, v5
sqadd.4h	v20, v24, v4
sqsub.4h	v26, v24, v4
sqadd.4h	v22, v28, v2
sqsub.4h	v24, v28, v2
mov.8b	v28, v6
smull.4s	v2, v17, v1[0]
smlsl.4s	v2, v31, v1[1]
smull.4s	v4, v17, v1[1]
smlal.4s	v4, v31, v1[0]
smull.4s	v6, v25, v1[2]
smlsl.4s	v6, v23, v1[3]
sqrshrn.4h	v17, v2, #12
sqrshrn.4h	v31, v4, #12
smull.4s	v2, v25, v1[3]
smlal.4s	v2, v23, v1[2]
smull.4s	v4, v21, v1[4]
smlsl.4s	v4, v27, v1[5]
sqrshrn.4h	v23, v6, #12
sqrshrn.4h	v25, v2, #12
smull.4s	v6, v21, v1[5]
smlal.4s	v6, v27, v1[4]
smull.4s	v2, v29, v1[6]
smlsl.4s	v2, v19, v1[7]
sqrshrn.4h	v21, v4, #12
sqrshrn.4h	v27, v6, #12
smull.4s	v4, v29, v1[7]
smlal.4s	v4, v19, v1[6]
sqrshrn.4h	v19, v2, #12
sqrshrn.4h	v29, v4, #12
sqsub.4h	v2, v17, v23
sqadd.4h	v17, v17, v23
sqsub.4h	v3, v31, v25
sqadd.4h	v31, v31, v25
sqsub.4h	v23, v19, v21
sqadd.4h	v19, v19, v21
sqadd.4h	v25, v29, v27
sqsub.4h	v29, v29, v27
smull.4s	v4, v3, v0[2]
smlsl.4s	v4, v2, v0[3]
smull.4s	v6, v3, v0[3]
smlal.4s	v6, v2, v0[2]
sqrshrn.4h	v21, v4, #12
sqrshrn.4h	v27, v6, #12
smull.4s	v4, v29, v0[2]
smlsl.4s	v4, v23, v0[3]
smull.4s	v6, v29, v0[3]
smlal.4s	v6, v23, v0[2]
sqrshrn.4h	v29, v4, #12
neg.4s	v6, v6
sqrshrn.4h	v23, v6, #12
sqsub.4h	v2, v17, v19
sqadd.4h	v17, v17, v19
sqsub.4h	v3, v31, v25
sqadd.4h	v31, v31, v25
sqadd.4h	v19, v21, v23
sqsub.4h	v21, v21, v23
sqsub.4h	v25, v27, v29
sqadd.4h	v27, v27, v29
smull.4s	v4, v3, v0[0]
smlsl.4s	v4, v2, v0[0]
smull.4s	v6, v3, v0[0]
smlal.4s	v6, v2, v0[0]
smull.4s	v2, v25, v0[0]
smlsl.4s	v2, v21, v0[0]
sqrshrn.4h	v4, v4, #12
sqrshrn.4h	v5, v6, #12
smull.4s	v6, v25, v0[0]
smlal.4s	v6, v21, v0[0]
sqrshrn.4h	v2, v2, #12
sqrshrn.4h	v3, v6, #12
sqadd.4h	v6, v16, v31
sqsub.4h	v31, v16, v31
mov.8b	v16, v6
sqadd.4h	v23, v30, v17
sqsub.4h	v7, v30, v17
sqadd.4h	v17, v18, v27
sqsub.4h	v30, v18, v27
sqadd.4h	v18, v20, v3
sqsub.4h	v29, v20, v3
sqadd.4h	v3, v28, v19
sqsub.4h	v25, v28, v19
sqadd.4h	v19, v22, v5
sqsub.4h	v28, v22, v5
sqadd.4h	v20, v24, v4
sqsub.4h	v27, v24, v4
sqadd.4h	v21, v26, v2
sqsub.4h	v26, v26, v2
mov.8b	v24, v7
mov.8b	v22, v3
ret
_inv_adst_8h_x16_neon:
adrp	x16, inv_adst_8h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
adrp	x16, inv_adst_8h_x16_neon
add	x16, x16, #0
smull.4s	v2, v31, v0[0]
smlal.4s	v2, v16, v0[1]
smull2.4s	v3, v31, v0[0]
smlal2.4s	v3, v16, v0[1]
smull.4s	v4, v31, v0[1]
smlsl.4s	v4, v16, v0[0]
smull2.4s	v5, v31, v0[1]
smlsl2.4s	v5, v16, v0[0]
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
smull2.4s	v7, v29, v0[2]
smlal2.4s	v7, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn2.8h	v16, v3, #12
sqrshrn.4h	v31, v4, #12
sqrshrn2.8h	v31, v5, #12
smull.4s	v2, v29, v0[3]
smlsl.4s	v2, v18, v0[2]
smull2.4s	v3, v29, v0[3]
smlsl2.4s	v3, v18, v0[2]
smull.4s	v4, v27, v0[4]
smlal.4s	v4, v20, v0[5]
smull2.4s	v5, v27, v0[4]
smlal2.4s	v5, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqrshrn.4h	v29, v2, #12
sqrshrn2.8h	v29, v3, #12
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
smull2.4s	v7, v27, v0[5]
smlsl2.4s	v7, v20, v0[4]
smull.4s	v2, v25, v0[6]
smlal.4s	v2, v22, v0[7]
smull2.4s	v3, v25, v0[6]
smlal2.4s	v3, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
smull2.4s	v5, v25, v0[7]
smlsl2.4s	v5, v22, v0[6]
smull.4s	v6, v23, v1[0]
smlal.4s	v6, v24, v1[1]
smull2.4s	v7, v23, v1[0]
smlal2.4s	v7, v24, v1[1]
sqrshrn.4h	v22, v2, #12
sqrshrn2.8h	v22, v3, #12
sqrshrn.4h	v25, v4, #12
sqrshrn2.8h	v25, v5, #12
smull.4s	v2, v23, v1[1]
smlsl.4s	v2, v24, v1[0]
smull2.4s	v3, v23, v1[1]
smlsl2.4s	v3, v24, v1[0]
smull.4s	v4, v21, v1[2]
smlal.4s	v4, v26, v1[3]
smull2.4s	v5, v21, v1[2]
smlal2.4s	v5, v26, v1[3]
sqrshrn.4h	v23, v6, #12
sqrshrn2.8h	v23, v7, #12
sqrshrn.4h	v24, v2, #12
sqrshrn2.8h	v24, v3, #12
smull.4s	v6, v21, v1[3]
smlsl.4s	v6, v26, v1[2]
smull2.4s	v7, v21, v1[3]
smlsl2.4s	v7, v26, v1[2]
smull.4s	v2, v19, v1[4]
smlal.4s	v2, v28, v1[5]
smull2.4s	v3, v19, v1[4]
smlal2.4s	v3, v28, v1[5]
sqrshrn.4h	v21, v4, #12
sqrshrn2.8h	v21, v5, #12
sqrshrn.4h	v26, v6, #12
sqrshrn2.8h	v26, v7, #12
smull.4s	v4, v19, v1[5]
smlsl.4s	v4, v28, v1[4]
smull2.4s	v5, v19, v1[5]
smlsl2.4s	v5, v28, v1[4]
smull.4s	v6, v17, v1[6]
smlal.4s	v6, v30, v1[7]
smull2.4s	v7, v17, v1[6]
smlal2.4s	v7, v30, v1[7]
sqrshrn.4h	v19, v2, #12
sqrshrn2.8h	v19, v3, #12
sqrshrn.4h	v28, v4, #12
sqrshrn2.8h	v28, v5, #12
smull.4s	v2, v17, v1[7]
smlsl.4s	v2, v30, v1[6]
smull2.4s	v3, v17, v1[7]
smlsl2.4s	v3, v30, v1[6]
sqrshrn.4h	v17, v6, #12
sqrshrn2.8h	v17, v7, #12
sqrshrn.4h	v30, v2, #12
sqrshrn2.8h	v30, v3, #12
ld1.8h	{ v0 }, [x16]
sqsub.8h	v2, v16, v23
sqadd.8h	v16, v16, v23
sqsub.8h	v3, v31, v24
sqadd.8h	v31, v31, v24
sqadd.8h	v23, v18, v21
sqsub.8h	v18, v18, v21
sqadd.8h	v24, v29, v26
sqsub.8h	v29, v29, v26
sqadd.8h	v21, v20, v19
sqsub.8h	v20, v20, v19
sqadd.8h	v26, v27, v28
sqsub.8h	v27, v27, v28
sqadd.8h	v19, v22, v17
sqsub.8h	v22, v22, v17
sqadd.8h	v28, v25, v30
sqsub.8h	v25, v25, v30
smull.4s	v4, v2, v0[5]
smlal.4s	v4, v3, v0[4]
smull2.4s	v5, v2, v0[5]
smlal2.4s	v5, v3, v0[4]
smull.4s	v6, v2, v0[4]
smlsl.4s	v6, v3, v0[5]
smull2.4s	v7, v2, v0[4]
smlsl2.4s	v7, v3, v0[5]
smull.4s	v2, v18, v0[7]
smlal.4s	v2, v29, v0[6]
smull2.4s	v3, v18, v0[7]
smlal2.4s	v3, v29, v0[6]
sqrshrn.4h	v17, v4, #12
sqrshrn2.8h	v17, v5, #12
sqrshrn.4h	v30, v6, #12
sqrshrn2.8h	v30, v7, #12
smull.4s	v4, v18, v0[6]
smlsl.4s	v4, v29, v0[7]
smull2.4s	v5, v18, v0[6]
smlsl2.4s	v5, v29, v0[7]
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
smull2.4s	v7, v27, v0[5]
smlsl2.4s	v7, v20, v0[4]
sqrshrn.4h	v18, v2, #12
sqrshrn2.8h	v18, v3, #12
sqrshrn.4h	v29, v4, #12
sqrshrn2.8h	v29, v5, #12
smull.4s	v2, v27, v0[4]
smlal.4s	v2, v20, v0[5]
smull2.4s	v3, v27, v0[4]
smlal2.4s	v3, v20, v0[5]
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
smull2.4s	v5, v25, v0[7]
smlsl2.4s	v5, v22, v0[6]
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
sqrshrn.4h	v20, v2, #12
sqrshrn2.8h	v20, v3, #12
smull.4s	v6, v25, v0[6]
smlal.4s	v6, v22, v0[7]
smull2.4s	v7, v25, v0[6]
smlal2.4s	v7, v22, v0[7]
sqrshrn.4h	v25, v4, #12
sqrshrn2.8h	v25, v5, #12
sqrshrn.4h	v22, v6, #12
sqrshrn2.8h	v22, v7, #12
sqsub.8h	v2, v16, v21
sqadd.8h	v16, v16, v21
sqsub.8h	v3, v31, v26
sqadd.8h	v31, v31, v26
sqadd.8h	v21, v23, v19
sqsub.8h	v23, v23, v19
sqadd.8h	v26, v24, v28
sqsub.8h	v24, v24, v28
sqadd.8h	v19, v17, v27
sqsub.8h	v17, v17, v27
sqadd.8h	v28, v30, v20
sqsub.8h	v30, v30, v20
sqadd.8h	v27, v18, v25
sqsub.8h	v18, v18, v25
sqadd.8h	v20, v29, v22
sqsub.8h	v29, v29, v22
smull.4s	v4, v2, v0[3]
smlal.4s	v4, v3, v0[2]
smull2.4s	v5, v2, v0[3]
smlal2.4s	v5, v3, v0[2]
smull.4s	v6, v2, v0[2]
smlsl.4s	v6, v3, v0[3]
smull2.4s	v7, v2, v0[2]
smlsl2.4s	v7, v3, v0[3]
smull.4s	v2, v24, v0[3]
smlsl.4s	v2, v23, v0[2]
smull2.4s	v3, v24, v0[3]
smlsl2.4s	v3, v23, v0[2]
sqrshrn.4h	v22, v4, #12
sqrshrn2.8h	v22, v5, #12
sqrshrn.4h	v25, v6, #12
sqrshrn2.8h	v25, v7, #12
smull.4s	v4, v24, v0[2]
smlal.4s	v4, v23, v0[3]
smull2.4s	v5, v24, v0[2]
smlal2.4s	v5, v23, v0[3]
smull.4s	v6, v17, v0[3]
smlal.4s	v6, v30, v0[2]
smull2.4s	v7, v17, v0[3]
smlal2.4s	v7, v30, v0[2]
sqrshrn.4h	v24, v2, #12
sqrshrn2.8h	v24, v3, #12
sqrshrn.4h	v23, v4, #12
sqrshrn2.8h	v23, v5, #12
smull.4s	v2, v17, v0[2]
smlsl.4s	v2, v30, v0[3]
smull2.4s	v3, v17, v0[2]
smlsl2.4s	v3, v30, v0[3]
smull.4s	v4, v29, v0[3]
smlsl.4s	v4, v18, v0[2]
smull2.4s	v5, v29, v0[3]
smlsl2.4s	v5, v18, v0[2]
sqrshrn.4h	v17, v6, #12
sqrshrn2.8h	v17, v7, #12
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
smull2.4s	v7, v29, v0[2]
smlal2.4s	v7, v18, v0[3]
sqrshrn.4h	v29, v2, #12
sqrshrn2.8h	v29, v3, #12
sqrshrn.4h	v30, v4, #12
sqrshrn2.8h	v30, v5, #12
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqsub.8h	v2, v16, v21
sqadd.8h	v16, v16, v21
sqsub.8h	v21, v31, v26
sqadd.8h	v31, v31, v26
sqneg.8h	v31, v31
sqsub.8h	v3, v29, v18
sqadd.8h	v29, v29, v18
sqadd.8h	v18, v17, v30
sqsub.8h	v26, v17, v30
sqneg.8h	v29, v29
sqadd.8h	v17, v19, v27
sqsub.8h	v27, v19, v27
sqadd.8h	v30, v28, v20
sqsub.8h	v20, v28, v20
sqneg.8h	v17, v17
sqadd.8h	v19, v22, v24
sqsub.8h	v22, v22, v24
sqadd.8h	v28, v25, v23
sqsub.8h	v23, v25, v23
sqneg.8h	v19, v19
smull.4s	v24, v2, v0[0]
smlsl.4s	v24, v21, v0[0]
smull2.4s	v25, v2, v0[0]
smlsl2.4s	v25, v21, v0[0]
smull.4s	v4, v2, v0[0]
smlal.4s	v4, v21, v0[0]
smull2.4s	v5, v2, v0[0]
smlal2.4s	v5, v21, v0[0]
smull.4s	v6, v26, v0[0]
smlal.4s	v6, v3, v0[0]
smull2.4s	v7, v26, v0[0]
smlal2.4s	v7, v3, v0[0]
sqrshrn.4h	v24, v24, #12
sqrshrn2.8h	v24, v25, #12
sqrshrn.4h	v4, v4, #12
sqrshrn2.8h	v4, v5, #12
sqrshrn.4h	v5, v6, #12
sqrshrn2.8h	v5, v7, #12
smull.4s	v6, v26, v0[0]
smlsl.4s	v6, v3, v0[0]
smull2.4s	v7, v26, v0[0]
smlsl2.4s	v7, v3, v0[0]
smull.4s	v2, v22, v0[0]
smlal.4s	v2, v23, v0[0]
smull2.4s	v3, v22, v0[0]
smlal2.4s	v3, v23, v0[0]
sqrshrn.4h	v26, v6, #12
sqrshrn2.8h	v26, v7, #12
smull.4s	v6, v22, v0[0]
smlsl.4s	v6, v23, v0[0]
smull2.4s	v7, v22, v0[0]
smlsl2.4s	v7, v23, v0[0]
smull.4s	v22, v27, v0[0]
smlal.4s	v22, v20, v0[0]
smull2.4s	v23, v27, v0[0]
smlal2.4s	v23, v20, v0[0]
smull.4s	v21, v27, v0[0]
smlsl.4s	v21, v20, v0[0]
smull2.4s	v25, v27, v0[0]
smlsl2.4s	v25, v20, v0[0]
sqrshrn.4h	v20, v2, #12
sqrshrn2.8h	v20, v3, #12
sqrshrn.4h	v6, v6, #12
sqrshrn2.8h	v6, v7, #12
sqrshrn.4h	v7, v21, #12
sqrshrn2.8h	v7, v25, #12
sqrshrn.4h	v22, v22, #12
sqrshrn2.8h	v22, v23, #12
sqneg.8h	v23, v4
sqneg.8h	v21, v5
sqneg.8h	v27, v6
sqneg.8h	v25, v7
ret
_inv_flipadst_8h_x16_neon:
adrp	x16, inv_flipadst_8h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
adrp	x16, inv_flipadst_8h_x16_neon
add	x16, x16, #0
smull.4s	v2, v31, v0[0]
smlal.4s	v2, v16, v0[1]
smull2.4s	v3, v31, v0[0]
smlal2.4s	v3, v16, v0[1]
smull.4s	v4, v31, v0[1]
smlsl.4s	v4, v16, v0[0]
smull2.4s	v5, v31, v0[1]
smlsl2.4s	v5, v16, v0[0]
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
smull2.4s	v7, v29, v0[2]
smlal2.4s	v7, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn2.8h	v16, v3, #12
sqrshrn.4h	v31, v4, #12
sqrshrn2.8h	v31, v5, #12
smull.4s	v2, v29, v0[3]
smlsl.4s	v2, v18, v0[2]
smull2.4s	v3, v29, v0[3]
smlsl2.4s	v3, v18, v0[2]
smull.4s	v4, v27, v0[4]
smlal.4s	v4, v20, v0[5]
smull2.4s	v5, v27, v0[4]
smlal2.4s	v5, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqrshrn.4h	v29, v2, #12
sqrshrn2.8h	v29, v3, #12
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
smull2.4s	v7, v27, v0[5]
smlsl2.4s	v7, v20, v0[4]
smull.4s	v2, v25, v0[6]
smlal.4s	v2, v22, v0[7]
smull2.4s	v3, v25, v0[6]
smlal2.4s	v3, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
smull2.4s	v5, v25, v0[7]
smlsl2.4s	v5, v22, v0[6]
smull.4s	v6, v23, v1[0]
smlal.4s	v6, v24, v1[1]
smull2.4s	v7, v23, v1[0]
smlal2.4s	v7, v24, v1[1]
sqrshrn.4h	v22, v2, #12
sqrshrn2.8h	v22, v3, #12
sqrshrn.4h	v25, v4, #12
sqrshrn2.8h	v25, v5, #12
smull.4s	v2, v23, v1[1]
smlsl.4s	v2, v24, v1[0]
smull2.4s	v3, v23, v1[1]
smlsl2.4s	v3, v24, v1[0]
smull.4s	v4, v21, v1[2]
smlal.4s	v4, v26, v1[3]
smull2.4s	v5, v21, v1[2]
smlal2.4s	v5, v26, v1[3]
sqrshrn.4h	v23, v6, #12
sqrshrn2.8h	v23, v7, #12
sqrshrn.4h	v24, v2, #12
sqrshrn2.8h	v24, v3, #12
smull.4s	v6, v21, v1[3]
smlsl.4s	v6, v26, v1[2]
smull2.4s	v7, v21, v1[3]
smlsl2.4s	v7, v26, v1[2]
smull.4s	v2, v19, v1[4]
smlal.4s	v2, v28, v1[5]
smull2.4s	v3, v19, v1[4]
smlal2.4s	v3, v28, v1[5]
sqrshrn.4h	v21, v4, #12
sqrshrn2.8h	v21, v5, #12
sqrshrn.4h	v26, v6, #12
sqrshrn2.8h	v26, v7, #12
smull.4s	v4, v19, v1[5]
smlsl.4s	v4, v28, v1[4]
smull2.4s	v5, v19, v1[5]
smlsl2.4s	v5, v28, v1[4]
smull.4s	v6, v17, v1[6]
smlal.4s	v6, v30, v1[7]
smull2.4s	v7, v17, v1[6]
smlal2.4s	v7, v30, v1[7]
sqrshrn.4h	v19, v2, #12
sqrshrn2.8h	v19, v3, #12
sqrshrn.4h	v28, v4, #12
sqrshrn2.8h	v28, v5, #12
smull.4s	v2, v17, v1[7]
smlsl.4s	v2, v30, v1[6]
smull2.4s	v3, v17, v1[7]
smlsl2.4s	v3, v30, v1[6]
sqrshrn.4h	v17, v6, #12
sqrshrn2.8h	v17, v7, #12
sqrshrn.4h	v30, v2, #12
sqrshrn2.8h	v30, v3, #12
ld1.8h	{ v0 }, [x16]
sqsub.8h	v2, v16, v23
sqadd.8h	v16, v16, v23
sqsub.8h	v3, v31, v24
sqadd.8h	v31, v31, v24
sqadd.8h	v23, v18, v21
sqsub.8h	v18, v18, v21
sqadd.8h	v24, v29, v26
sqsub.8h	v29, v29, v26
sqadd.8h	v21, v20, v19
sqsub.8h	v20, v20, v19
sqadd.8h	v26, v27, v28
sqsub.8h	v27, v27, v28
sqadd.8h	v19, v22, v17
sqsub.8h	v22, v22, v17
sqadd.8h	v28, v25, v30
sqsub.8h	v25, v25, v30
smull.4s	v4, v2, v0[5]
smlal.4s	v4, v3, v0[4]
smull2.4s	v5, v2, v0[5]
smlal2.4s	v5, v3, v0[4]
smull.4s	v6, v2, v0[4]
smlsl.4s	v6, v3, v0[5]
smull2.4s	v7, v2, v0[4]
smlsl2.4s	v7, v3, v0[5]
smull.4s	v2, v18, v0[7]
smlal.4s	v2, v29, v0[6]
smull2.4s	v3, v18, v0[7]
smlal2.4s	v3, v29, v0[6]
sqrshrn.4h	v17, v4, #12
sqrshrn2.8h	v17, v5, #12
sqrshrn.4h	v30, v6, #12
sqrshrn2.8h	v30, v7, #12
smull.4s	v4, v18, v0[6]
smlsl.4s	v4, v29, v0[7]
smull2.4s	v5, v18, v0[6]
smlsl2.4s	v5, v29, v0[7]
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
smull2.4s	v7, v27, v0[5]
smlsl2.4s	v7, v20, v0[4]
sqrshrn.4h	v18, v2, #12
sqrshrn2.8h	v18, v3, #12
sqrshrn.4h	v29, v4, #12
sqrshrn2.8h	v29, v5, #12
smull.4s	v2, v27, v0[4]
smlal.4s	v2, v20, v0[5]
smull2.4s	v3, v27, v0[4]
smlal2.4s	v3, v20, v0[5]
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
smull2.4s	v5, v25, v0[7]
smlsl2.4s	v5, v22, v0[6]
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
sqrshrn.4h	v20, v2, #12
sqrshrn2.8h	v20, v3, #12
smull.4s	v6, v25, v0[6]
smlal.4s	v6, v22, v0[7]
smull2.4s	v7, v25, v0[6]
smlal2.4s	v7, v22, v0[7]
sqrshrn.4h	v25, v4, #12
sqrshrn2.8h	v25, v5, #12
sqrshrn.4h	v22, v6, #12
sqrshrn2.8h	v22, v7, #12
sqsub.8h	v2, v16, v21
sqadd.8h	v16, v16, v21
sqsub.8h	v3, v31, v26
sqadd.8h	v31, v31, v26
sqadd.8h	v21, v23, v19
sqsub.8h	v23, v23, v19
sqadd.8h	v26, v24, v28
sqsub.8h	v24, v24, v28
sqadd.8h	v19, v17, v27
sqsub.8h	v17, v17, v27
sqadd.8h	v28, v30, v20
sqsub.8h	v30, v30, v20
sqadd.8h	v27, v18, v25
sqsub.8h	v18, v18, v25
sqadd.8h	v20, v29, v22
sqsub.8h	v29, v29, v22
smull.4s	v4, v2, v0[3]
smlal.4s	v4, v3, v0[2]
smull2.4s	v5, v2, v0[3]
smlal2.4s	v5, v3, v0[2]
smull.4s	v6, v2, v0[2]
smlsl.4s	v6, v3, v0[3]
smull2.4s	v7, v2, v0[2]
smlsl2.4s	v7, v3, v0[3]
smull.4s	v2, v24, v0[3]
smlsl.4s	v2, v23, v0[2]
smull2.4s	v3, v24, v0[3]
smlsl2.4s	v3, v23, v0[2]
sqrshrn.4h	v22, v4, #12
sqrshrn2.8h	v22, v5, #12
sqrshrn.4h	v25, v6, #12
sqrshrn2.8h	v25, v7, #12
smull.4s	v4, v24, v0[2]
smlal.4s	v4, v23, v0[3]
smull2.4s	v5, v24, v0[2]
smlal2.4s	v5, v23, v0[3]
smull.4s	v6, v17, v0[3]
smlal.4s	v6, v30, v0[2]
smull2.4s	v7, v17, v0[3]
smlal2.4s	v7, v30, v0[2]
sqrshrn.4h	v24, v2, #12
sqrshrn2.8h	v24, v3, #12
sqrshrn.4h	v23, v4, #12
sqrshrn2.8h	v23, v5, #12
smull.4s	v2, v17, v0[2]
smlsl.4s	v2, v30, v0[3]
smull2.4s	v3, v17, v0[2]
smlsl2.4s	v3, v30, v0[3]
smull.4s	v4, v29, v0[3]
smlsl.4s	v4, v18, v0[2]
smull2.4s	v5, v29, v0[3]
smlsl2.4s	v5, v18, v0[2]
sqrshrn.4h	v17, v6, #12
sqrshrn2.8h	v17, v7, #12
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
smull2.4s	v7, v29, v0[2]
smlal2.4s	v7, v18, v0[3]
sqrshrn.4h	v29, v2, #12
sqrshrn2.8h	v29, v3, #12
sqrshrn.4h	v30, v4, #12
sqrshrn2.8h	v30, v5, #12
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqsub.8h	v2, v16, v21
sqadd.8h	v4, v16, v21
sqsub.8h	v21, v31, v26
sqadd.8h	v16, v31, v26
mov.16b	v31, v4
sqneg.8h	v16, v16
sqsub.8h	v3, v29, v18
sqadd.8h	v18, v29, v18
sqadd.8h	v29, v17, v30
sqsub.8h	v26, v17, v30
sqneg.8h	v18, v18
sqadd.8h	v30, v19, v27
sqsub.8h	v27, v19, v27
sqadd.8h	v17, v28, v20
sqsub.8h	v20, v28, v20
sqneg.8h	v30, v30
sqadd.8h	v28, v22, v24
sqsub.8h	v22, v22, v24
sqadd.8h	v19, v25, v23
sqsub.8h	v23, v25, v23
sqneg.8h	v28, v28
smull.4s	v24, v2, v0[0]
smlsl.4s	v24, v21, v0[0]
smull2.4s	v25, v2, v0[0]
smlsl2.4s	v25, v21, v0[0]
smull.4s	v4, v2, v0[0]
smlal.4s	v4, v21, v0[0]
smull2.4s	v5, v2, v0[0]
smlal2.4s	v5, v21, v0[0]
smull.4s	v6, v26, v0[0]
smlal.4s	v6, v3, v0[0]
smull2.4s	v7, v26, v0[0]
smlal2.4s	v7, v3, v0[0]
sqrshrn.4h	v24, v24, #12
sqrshrn2.8h	v24, v25, #12
sqrshrn.4h	v4, v4, #12
sqrshrn2.8h	v4, v5, #12
sqrshrn.4h	v5, v6, #12
sqrshrn2.8h	v5, v7, #12
smull.4s	v6, v26, v0[0]
smlsl.4s	v6, v3, v0[0]
smull2.4s	v7, v26, v0[0]
smlsl2.4s	v7, v3, v0[0]
smull.4s	v2, v22, v0[0]
smlal.4s	v2, v23, v0[0]
smull2.4s	v3, v22, v0[0]
smlal2.4s	v3, v23, v0[0]
sqrshrn.4h	v26, v6, #12
sqrshrn2.8h	v26, v7, #12
smull.4s	v6, v22, v0[0]
smlsl.4s	v6, v23, v0[0]
smull2.4s	v7, v22, v0[0]
smlsl2.4s	v7, v23, v0[0]
smull.4s	v22, v27, v0[0]
smlal.4s	v22, v20, v0[0]
smull2.4s	v23, v27, v0[0]
smlal2.4s	v23, v20, v0[0]
smull.4s	v21, v27, v0[0]
smlsl.4s	v21, v20, v0[0]
smull2.4s	v25, v27, v0[0]
smlsl2.4s	v25, v20, v0[0]
sqrshrn.4h	v27, v2, #12
sqrshrn2.8h	v27, v3, #12
sqrshrn.4h	v6, v6, #12
sqrshrn2.8h	v6, v7, #12
sqrshrn.4h	v7, v21, #12
sqrshrn2.8h	v7, v25, #12
sqrshrn.4h	v25, v22, #12
sqrshrn2.8h	v25, v23, #12
mov.16b	v23, v24
mov.16b	v21, v26
sqneg.8h	v24, v4
sqneg.8h	v26, v5
sqneg.8h	v20, v6
sqneg.8h	v22, v7
ret
_inv_adst_4h_x16_neon:
adrp	x16, inv_adst_4h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
adrp	x16, inv_adst_4h_x16_neon
add	x16, x16, #0
smull.4s	v2, v31, v0[0]
smlal.4s	v2, v16, v0[1]
smull.4s	v4, v31, v0[1]
smlsl.4s	v4, v16, v0[0]
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn.4h	v31, v4, #12
smull.4s	v2, v29, v0[3]
smlsl.4s	v2, v18, v0[2]
smull.4s	v4, v27, v0[4]
smlal.4s	v4, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn.4h	v29, v2, #12
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
smull.4s	v2, v25, v0[6]
smlal.4s	v2, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn.4h	v27, v6, #12
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
smull.4s	v6, v23, v1[0]
smlal.4s	v6, v24, v1[1]
sqrshrn.4h	v22, v2, #12
sqrshrn.4h	v25, v4, #12
smull.4s	v2, v23, v1[1]
smlsl.4s	v2, v24, v1[0]
smull.4s	v4, v21, v1[2]
smlal.4s	v4, v26, v1[3]
sqrshrn.4h	v23, v6, #12
sqrshrn.4h	v24, v2, #12
smull.4s	v6, v21, v1[3]
smlsl.4s	v6, v26, v1[2]
smull.4s	v2, v19, v1[4]
smlal.4s	v2, v28, v1[5]
sqrshrn.4h	v21, v4, #12
sqrshrn.4h	v26, v6, #12
smull.4s	v4, v19, v1[5]
smlsl.4s	v4, v28, v1[4]
smull.4s	v6, v17, v1[6]
smlal.4s	v6, v30, v1[7]
sqrshrn.4h	v19, v2, #12
sqrshrn.4h	v28, v4, #12
smull.4s	v2, v17, v1[7]
smlsl.4s	v2, v30, v1[6]
sqrshrn.4h	v17, v6, #12
sqrshrn.4h	v30, v2, #12
ld1.8h	{ v0 }, [x16]
sqsub.4h	v2, v16, v23
sqadd.4h	v16, v16, v23
sqsub.4h	v3, v31, v24
sqadd.4h	v31, v31, v24
sqadd.4h	v23, v18, v21
sqsub.4h	v18, v18, v21
sqadd.4h	v24, v29, v26
sqsub.4h	v29, v29, v26
sqadd.4h	v21, v20, v19
sqsub.4h	v20, v20, v19
sqadd.4h	v26, v27, v28
sqsub.4h	v27, v27, v28
sqadd.4h	v19, v22, v17
sqsub.4h	v22, v22, v17
sqadd.4h	v28, v25, v30
sqsub.4h	v25, v25, v30
smull.4s	v4, v2, v0[5]
smlal.4s	v4, v3, v0[4]
smull.4s	v6, v2, v0[4]
smlsl.4s	v6, v3, v0[5]
smull.4s	v2, v18, v0[7]
smlal.4s	v2, v29, v0[6]
sqrshrn.4h	v17, v4, #12
sqrshrn.4h	v30, v6, #12
smull.4s	v4, v18, v0[6]
smlsl.4s	v4, v29, v0[7]
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
sqrshrn.4h	v18, v2, #12
sqrshrn.4h	v29, v4, #12
smull.4s	v2, v27, v0[4]
smlal.4s	v2, v20, v0[5]
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
sqrshrn.4h	v27, v6, #12
sqrshrn.4h	v20, v2, #12
smull.4s	v6, v25, v0[6]
smlal.4s	v6, v22, v0[7]
sqrshrn.4h	v25, v4, #12
sqrshrn.4h	v22, v6, #12
sqsub.4h	v2, v16, v21
sqadd.4h	v16, v16, v21
sqsub.4h	v3, v31, v26
sqadd.4h	v31, v31, v26
sqadd.4h	v21, v23, v19
sqsub.4h	v23, v23, v19
sqadd.4h	v26, v24, v28
sqsub.4h	v24, v24, v28
sqadd.4h	v19, v17, v27
sqsub.4h	v17, v17, v27
sqadd.4h	v28, v30, v20
sqsub.4h	v30, v30, v20
sqadd.4h	v27, v18, v25
sqsub.4h	v18, v18, v25
sqadd.4h	v20, v29, v22
sqsub.4h	v29, v29, v22
smull.4s	v4, v2, v0[3]
smlal.4s	v4, v3, v0[2]
smull.4s	v6, v2, v0[2]
smlsl.4s	v6, v3, v0[3]
smull.4s	v2, v24, v0[3]
smlsl.4s	v2, v23, v0[2]
sqrshrn.4h	v22, v4, #12
sqrshrn.4h	v25, v6, #12
smull.4s	v4, v24, v0[2]
smlal.4s	v4, v23, v0[3]
smull.4s	v6, v17, v0[3]
smlal.4s	v6, v30, v0[2]
sqrshrn.4h	v24, v2, #12
sqrshrn.4h	v23, v4, #12
smull.4s	v2, v17, v0[2]
smlsl.4s	v2, v30, v0[3]
smull.4s	v4, v29, v0[3]
smlsl.4s	v4, v18, v0[2]
sqrshrn.4h	v17, v6, #12
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
sqrshrn.4h	v29, v2, #12
sqrshrn.4h	v30, v4, #12
sqrshrn.4h	v18, v6, #12
sqsub.4h	v2, v16, v21
sqadd.4h	v16, v16, v21
sqsub.4h	v21, v31, v26
sqadd.4h	v31, v31, v26
sqneg.4h	v31, v31
sqsub.4h	v3, v29, v18
sqadd.4h	v29, v29, v18
sqadd.4h	v18, v17, v30
sqsub.4h	v26, v17, v30
sqneg.4h	v29, v29
sqadd.4h	v17, v19, v27
sqsub.4h	v27, v19, v27
sqadd.4h	v30, v28, v20
sqsub.4h	v20, v28, v20
sqneg.4h	v17, v17
sqadd.4h	v19, v22, v24
sqsub.4h	v22, v22, v24
sqadd.4h	v28, v25, v23
sqsub.4h	v23, v25, v23
sqneg.4h	v19, v19
smull.4s	v24, v2, v0[0]
smlsl.4s	v24, v21, v0[0]
smull.4s	v4, v2, v0[0]
smlal.4s	v4, v21, v0[0]
smull.4s	v6, v26, v0[0]
smlal.4s	v6, v3, v0[0]
sqrshrn.4h	v24, v24, #12
sqrshrn.4h	v4, v4, #12
sqrshrn.4h	v5, v6, #12
smull.4s	v6, v26, v0[0]
smlsl.4s	v6, v3, v0[0]
smull.4s	v2, v22, v0[0]
smlal.4s	v2, v23, v0[0]
sqrshrn.4h	v26, v6, #12
smull.4s	v6, v22, v0[0]
smlsl.4s	v6, v23, v0[0]
smull.4s	v22, v27, v0[0]
smlal.4s	v22, v20, v0[0]
smull.4s	v21, v27, v0[0]
smlsl.4s	v21, v20, v0[0]
sqrshrn.4h	v20, v2, #12
sqrshrn.4h	v6, v6, #12
sqrshrn.4h	v7, v21, #12
sqrshrn.4h	v22, v22, #12
sqneg.4h	v23, v4
sqneg.4h	v21, v5
sqneg.4h	v27, v6
sqneg.4h	v25, v7
ret
_inv_flipadst_4h_x16_neon:
adrp	x16, inv_flipadst_4h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
adrp	x16, inv_flipadst_4h_x16_neon
add	x16, x16, #0
smull.4s	v2, v31, v0[0]
smlal.4s	v2, v16, v0[1]
smull.4s	v4, v31, v0[1]
smlsl.4s	v4, v16, v0[0]
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn.4h	v31, v4, #12
smull.4s	v2, v29, v0[3]
smlsl.4s	v2, v18, v0[2]
smull.4s	v4, v27, v0[4]
smlal.4s	v4, v20, v0[5]
sqrshrn.4h	v18, v6, #12
sqrshrn.4h	v29, v2, #12
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
smull.4s	v2, v25, v0[6]
smlal.4s	v2, v22, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn.4h	v27, v6, #12
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
smull.4s	v6, v23, v1[0]
smlal.4s	v6, v24, v1[1]
sqrshrn.4h	v22, v2, #12
sqrshrn.4h	v25, v4, #12
smull.4s	v2, v23, v1[1]
smlsl.4s	v2, v24, v1[0]
smull.4s	v4, v21, v1[2]
smlal.4s	v4, v26, v1[3]
sqrshrn.4h	v23, v6, #12
sqrshrn.4h	v24, v2, #12
smull.4s	v6, v21, v1[3]
smlsl.4s	v6, v26, v1[2]
smull.4s	v2, v19, v1[4]
smlal.4s	v2, v28, v1[5]
sqrshrn.4h	v21, v4, #12
sqrshrn.4h	v26, v6, #12
smull.4s	v4, v19, v1[5]
smlsl.4s	v4, v28, v1[4]
smull.4s	v6, v17, v1[6]
smlal.4s	v6, v30, v1[7]
sqrshrn.4h	v19, v2, #12
sqrshrn.4h	v28, v4, #12
smull.4s	v2, v17, v1[7]
smlsl.4s	v2, v30, v1[6]
sqrshrn.4h	v17, v6, #12
sqrshrn.4h	v30, v2, #12
ld1.8h	{ v0 }, [x16]
sqsub.4h	v2, v16, v23
sqadd.4h	v16, v16, v23
sqsub.4h	v3, v31, v24
sqadd.4h	v31, v31, v24
sqadd.4h	v23, v18, v21
sqsub.4h	v18, v18, v21
sqadd.4h	v24, v29, v26
sqsub.4h	v29, v29, v26
sqadd.4h	v21, v20, v19
sqsub.4h	v20, v20, v19
sqadd.4h	v26, v27, v28
sqsub.4h	v27, v27, v28
sqadd.4h	v19, v22, v17
sqsub.4h	v22, v22, v17
sqadd.4h	v28, v25, v30
sqsub.4h	v25, v25, v30
smull.4s	v4, v2, v0[5]
smlal.4s	v4, v3, v0[4]
smull.4s	v6, v2, v0[4]
smlsl.4s	v6, v3, v0[5]
smull.4s	v2, v18, v0[7]
smlal.4s	v2, v29, v0[6]
sqrshrn.4h	v17, v4, #12
sqrshrn.4h	v30, v6, #12
smull.4s	v4, v18, v0[6]
smlsl.4s	v4, v29, v0[7]
smull.4s	v6, v27, v0[5]
smlsl.4s	v6, v20, v0[4]
sqrshrn.4h	v18, v2, #12
sqrshrn.4h	v29, v4, #12
smull.4s	v2, v27, v0[4]
smlal.4s	v2, v20, v0[5]
smull.4s	v4, v25, v0[7]
smlsl.4s	v4, v22, v0[6]
sqrshrn.4h	v27, v6, #12
sqrshrn.4h	v20, v2, #12
smull.4s	v6, v25, v0[6]
smlal.4s	v6, v22, v0[7]
sqrshrn.4h	v25, v4, #12
sqrshrn.4h	v22, v6, #12
sqsub.4h	v2, v16, v21
sqadd.4h	v16, v16, v21
sqsub.4h	v3, v31, v26
sqadd.4h	v31, v31, v26
sqadd.4h	v21, v23, v19
sqsub.4h	v23, v23, v19
sqadd.4h	v26, v24, v28
sqsub.4h	v24, v24, v28
sqadd.4h	v19, v17, v27
sqsub.4h	v17, v17, v27
sqadd.4h	v28, v30, v20
sqsub.4h	v30, v30, v20
sqadd.4h	v27, v18, v25
sqsub.4h	v18, v18, v25
sqadd.4h	v20, v29, v22
sqsub.4h	v29, v29, v22
smull.4s	v4, v2, v0[3]
smlal.4s	v4, v3, v0[2]
smull.4s	v6, v2, v0[2]
smlsl.4s	v6, v3, v0[3]
smull.4s	v2, v24, v0[3]
smlsl.4s	v2, v23, v0[2]
sqrshrn.4h	v22, v4, #12
sqrshrn.4h	v25, v6, #12
smull.4s	v4, v24, v0[2]
smlal.4s	v4, v23, v0[3]
smull.4s	v6, v17, v0[3]
smlal.4s	v6, v30, v0[2]
sqrshrn.4h	v24, v2, #12
sqrshrn.4h	v23, v4, #12
smull.4s	v2, v17, v0[2]
smlsl.4s	v2, v30, v0[3]
smull.4s	v4, v29, v0[3]
smlsl.4s	v4, v18, v0[2]
sqrshrn.4h	v17, v6, #12
smull.4s	v6, v29, v0[2]
smlal.4s	v6, v18, v0[3]
sqrshrn.4h	v29, v2, #12
sqrshrn.4h	v30, v4, #12
sqrshrn.4h	v18, v6, #12
sqsub.4h	v2, v16, v21
sqadd.4h	v4, v16, v21
sqsub.4h	v21, v31, v26
sqadd.4h	v16, v31, v26
mov.8b	v31, v4
sqneg.4h	v16, v16
sqsub.4h	v3, v29, v18
sqadd.4h	v18, v29, v18
sqadd.4h	v29, v17, v30
sqsub.4h	v26, v17, v30
sqneg.4h	v18, v18
sqadd.4h	v30, v19, v27
sqsub.4h	v27, v19, v27
sqadd.4h	v17, v28, v20
sqsub.4h	v20, v28, v20
sqneg.4h	v30, v30
sqadd.4h	v28, v22, v24
sqsub.4h	v22, v22, v24
sqadd.4h	v19, v25, v23
sqsub.4h	v23, v25, v23
sqneg.4h	v28, v28
smull.4s	v24, v2, v0[0]
smlsl.4s	v24, v21, v0[0]
smull.4s	v4, v2, v0[0]
smlal.4s	v4, v21, v0[0]
smull.4s	v6, v26, v0[0]
smlal.4s	v6, v3, v0[0]
sqrshrn.4h	v24, v24, #12
sqrshrn.4h	v4, v4, #12
sqrshrn.4h	v5, v6, #12
smull.4s	v6, v26, v0[0]
smlsl.4s	v6, v3, v0[0]
smull.4s	v2, v22, v0[0]
smlal.4s	v2, v23, v0[0]
sqrshrn.4h	v26, v6, #12
smull.4s	v6, v22, v0[0]
smlsl.4s	v6, v23, v0[0]
smull.4s	v22, v27, v0[0]
smlal.4s	v22, v20, v0[0]
smull.4s	v21, v27, v0[0]
smlsl.4s	v21, v20, v0[0]
sqrshrn.4h	v27, v2, #12
sqrshrn.4h	v6, v6, #12
sqrshrn.4h	v7, v21, #12
sqrshrn.4h	v25, v22, #12
mov.8b	v23, v24
mov.8b	v21, v26
sqneg.4h	v24, v4
sqneg.4h	v26, v5
sqneg.4h	v20, v6
sqneg.4h	v22, v7
ret
_inv_identity_8h_x16_neon:
mov	w16, #27152
dup.4h	v0, w16
sqrdmulh.8h	v2, v16, v0[0]
sqadd.8h	v16, v16, v16
sqadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v0[0]
sqadd.8h	v17, v17, v17
sqadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v0[0]
sqadd.8h	v18, v18, v18
sqadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v0[0]
sqadd.8h	v19, v19, v19
sqadd.8h	v19, v19, v2
sqrdmulh.8h	v2, v20, v0[0]
sqadd.8h	v20, v20, v20
sqadd.8h	v20, v20, v2
sqrdmulh.8h	v2, v21, v0[0]
sqadd.8h	v21, v21, v21
sqadd.8h	v21, v21, v2
sqrdmulh.8h	v2, v22, v0[0]
sqadd.8h	v22, v22, v22
sqadd.8h	v22, v22, v2
sqrdmulh.8h	v2, v23, v0[0]
sqadd.8h	v23, v23, v23
sqadd.8h	v23, v23, v2
sqrdmulh.8h	v2, v24, v0[0]
sqadd.8h	v24, v24, v24
sqadd.8h	v24, v24, v2
sqrdmulh.8h	v2, v25, v0[0]
sqadd.8h	v25, v25, v25
sqadd.8h	v25, v25, v2
sqrdmulh.8h	v2, v26, v0[0]
sqadd.8h	v26, v26, v26
sqadd.8h	v26, v26, v2
sqrdmulh.8h	v2, v27, v0[0]
sqadd.8h	v27, v27, v27
sqadd.8h	v27, v27, v2
sqrdmulh.8h	v2, v28, v0[0]
sqadd.8h	v28, v28, v28
sqadd.8h	v28, v28, v2
sqrdmulh.8h	v2, v29, v0[0]
sqadd.8h	v29, v29, v29
sqadd.8h	v29, v29, v2
sqrdmulh.8h	v2, v30, v0[0]
sqadd.8h	v30, v30, v30
sqadd.8h	v30, v30, v2
sqrdmulh.8h	v2, v31, v0[0]
sqadd.8h	v31, v31, v31
sqadd.8h	v31, v31, v2
ret
_inv_identity_4h_x16_neon:
mov	w16, #27152
dup.4h	v0, w16
sqrdmulh.4h	v2, v16, v0[0]
sqadd.4h	v16, v16, v16
sqadd.4h	v16, v16, v2
sqrdmulh.4h	v2, v17, v0[0]
sqadd.4h	v17, v17, v17
sqadd.4h	v17, v17, v2
sqrdmulh.4h	v2, v18, v0[0]
sqadd.4h	v18, v18, v18
sqadd.4h	v18, v18, v2
sqrdmulh.4h	v2, v19, v0[0]
sqadd.4h	v19, v19, v19
sqadd.4h	v19, v19, v2
sqrdmulh.4h	v2, v20, v0[0]
sqadd.4h	v20, v20, v20
sqadd.4h	v20, v20, v2
sqrdmulh.4h	v2, v21, v0[0]
sqadd.4h	v21, v21, v21
sqadd.4h	v21, v21, v2
sqrdmulh.4h	v2, v22, v0[0]
sqadd.4h	v22, v22, v22
sqadd.4h	v22, v22, v2
sqrdmulh.4h	v2, v23, v0[0]
sqadd.4h	v23, v23, v23
sqadd.4h	v23, v23, v2
sqrdmulh.4h	v2, v24, v0[0]
sqadd.4h	v24, v24, v24
sqadd.4h	v24, v24, v2
sqrdmulh.4h	v2, v25, v0[0]
sqadd.4h	v25, v25, v25
sqadd.4h	v25, v25, v2
sqrdmulh.4h	v2, v26, v0[0]
sqadd.4h	v26, v26, v26
sqadd.4h	v26, v26, v2
sqrdmulh.4h	v2, v27, v0[0]
sqadd.4h	v27, v27, v27
sqadd.4h	v27, v27, v2
sqrdmulh.4h	v2, v28, v0[0]
sqadd.4h	v28, v28, v28
sqadd.4h	v28, v28, v2
sqrdmulh.4h	v2, v29, v0[0]
sqadd.4h	v29, v29, v29
sqadd.4h	v29, v29, v2
sqrdmulh.4h	v2, v30, v0[0]
sqadd.4h	v30, v30, v30
sqadd.4h	v30, v30, v2
sqrdmulh.4h	v2, v31, v0[0]
sqadd.4h	v31, v31, v31
sqadd.4h	v31, v31, v2
ret
_inv_txfm_horz_scale_16x8_neon:
mov	x14, x30
movi.8h	v7, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
sqrdmulh.8h	v24, v24, v0[0]
sqrdmulh.8h	v25, v25, v0[0]
sqrdmulh.8h	v26, v26, v0[0]
sqrdmulh.8h	v27, v27, v0[0]
sqrdmulh.8h	v28, v28, v0[0]
sqrdmulh.8h	v29, v29, v0[0]
sqrdmulh.8h	v30, v30, v0[0]
sqrdmulh.8h	v31, v31, v0[0]
blr	x4
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
srshr.8h	v20, v20, #1
srshr.8h	v21, v21, #1
srshr.8h	v22, v22, #1
srshr.8h	v23, v23, #1
srshr.8h	v24, v24, #1
srshr.8h	v25, v25, #1
srshr.8h	v26, v26, #1
srshr.8h	v27, v27, #1
srshr.8h	v28, v28, #1
srshr.8h	v29, v29, #1
srshr.8h	v30, v30, #1
srshr.8h	v31, v31, #1
b	inv_txfm_horz_16x8_neon
_inv_txfm_horz_identity_16x8_neon:
mov	x14, x30
movi.8h	v7, #0
mov	w16, #27152
dup.4h	v0, w16
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
sqrdmulh.8h	v2, v16, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v19, v19, v2
sqrdmulh.8h	v2, v20, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v20, v20, v2
sqrdmulh.8h	v2, v21, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v21, v21, v2
sqrdmulh.8h	v2, v22, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v22, v22, v2
sqrdmulh.8h	v2, v23, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v23, v23, v2
sqrdmulh.8h	v2, v24, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v24, v24, v2
sqrdmulh.8h	v2, v25, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v25, v25, v2
sqrdmulh.8h	v2, v26, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v26, v26, v2
sqrdmulh.8h	v2, v27, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v27, v27, v2
sqrdmulh.8h	v2, v28, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v28, v28, v2
sqrdmulh.8h	v2, v29, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v29, v29, v2
sqrdmulh.8h	v2, v30, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v30, v30, v2
sqrdmulh.8h	v2, v31, v0[0]
sshr.8h	v2, v2, #1
srhadd.8h	v31, v31, v2
b	inv_txfm_horz_16x8_neon
_inv_txfm_horz_16x8_neon:
mov	x14, x30
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
blr	x4
srshr.8h	v16, v16, #2
srshr.8h	v17, v17, #2
srshr.8h	v18, v18, #2
srshr.8h	v19, v19, #2
srshr.8h	v20, v20, #2
srshr.8h	v21, v21, #2
srshr.8h	v22, v22, #2
srshr.8h	v23, v23, #2
srshr.8h	v24, v24, #2
srshr.8h	v25, v25, #2
srshr.8h	v26, v26, #2
srshr.8h	v27, v27, #2
srshr.8h	v28, v28, #2
srshr.8h	v29, v29, #2
srshr.8h	v30, v30, #2
srshr.8h	v31, v31, #2
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
trn1.8h	v4, v24, v25
trn2.8h	v5, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v5, v27
trn2.4s	v5, v5, v27
trn1.4s	v27, v4, v25
trn2.4s	v4, v4, v25
trn1.2d	v24, v27, v28
trn2.2d	v28, v27, v28
trn1.2d	v25, v29, v30
trn2.2d	v29, v29, v30
trn2.2d	v30, v4, v26
trn1.2d	v26, v4, v26
trn1.2d	v27, v5, v31
trn2.2d	v31, v5, v31
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v24 }, [x6], #16
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v25 }, [x6], #16
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v26 }, [x6], #16
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v27 }, [x6], #16
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v28 }, [x6], #16
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v29 }, [x6], #16
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v30 }, [x6], #16
st1.8h	{ v23 }, [x6], #16
st1.8h	{ v31 }, [x6], #16
ret	x14
_inv_txfm_add_vert_8x16_neon:
mov	x14, x30
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
ld1.8h	{ v24 }, [x7], x8
ld1.8h	{ v25 }, [x7], x8
ld1.8h	{ v26 }, [x7], x8
ld1.8h	{ v27 }, [x7], x8
ld1.8h	{ v28 }, [x7], x8
ld1.8h	{ v29 }, [x7], x8
ld1.8h	{ v30 }, [x7], x8
ld1.8h	{ v31 }, [x7], x8
blr	x5
mov	x7, x6
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x6], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x6], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x6], x1
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v24, v24, #4
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x6], x1
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v25, v25, #4
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x6], x1
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v26, v26, #4
uaddw.8h	v24, v24, v4
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v27, v27, #4
uaddw.8h	v25, v25, v5
sqxtun.8b	v4, v24
st1.8b	{ v3 }, [x6], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v28, v28, #4
uaddw.8h	v26, v26, v6
sqxtun.8b	v5, v25
st1.8b	{ v4 }, [x6], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v29, v29, #4
uaddw.8h	v27, v27, v7
sqxtun.8b	v6, v26
st1.8b	{ v5 }, [x6], x1
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v30, v30, #4
uaddw.8h	v28, v28, v2
sqxtun.8b	v7, v27
st1.8b	{ v6 }, [x6], x1
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v31, v31, #4
uaddw.8h	v29, v29, v3
sqxtun.8b	v2, v28
st1.8b	{ v7 }, [x6], x1
uaddw.8h	v30, v30, v4
sqxtun.8b	v3, v29
st1.8b	{ v2 }, [x6], x1
uaddw.8h	v31, v31, v5
sqxtun.8b	v4, v30
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v5, v31
st1.8b	{ v4 }, [x6], x1
st1.8b	{ v5 }, [x6], x1
ret	x14
_inv_txfm_add_16x16_neon:
mov	x15, x30
sub	sp, sp, #512
mov	x8, #32
mov	x6, sp
add	x7, x2, #0
blr	x9
add	x6, sp, #256
cmp	w3, w13
b.lt	inv_txfm_add_16x16_neon
add	x7, x2, #16
blr	x9
b	inv_txfm_add_16x16_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
add	x6, x0, #0
mov	x7, sp
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #8
add	x7, sp, #16
bl	inv_txfm_add_vert_8x16_neon
add	sp, sp, #512
ret	x15
_inv_txfm_add_dct_dct_16x16_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x16_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w16_neon
adr	x9, #-1020
adr	x4, #-7360
adr	x5, #-7364
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_identity_identity_16x16_8bpc_neon:
adr	x9, #-1380
adr	x5, #-2072
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_dct_adst_16x16_8bpc_neon:
adr	x9, #-1056
adr	x4, #-7396
adr	x5, #-6004
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_dct_flipadst_16x16_8bpc_neon:
adr	x9, #-1076
adr	x4, #-7416
adr	x5, #-4812
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_dct_identity_16x16_8bpc_neon:
adr	x9, #-1096
adr	x4, #-7436
adr	x5, #-2132
mov	x13, #8
b	inv_txfm_add_16x16_neon
_inv_txfm_add_adst_dct_16x16_8bpc_neon:
adr	x9, #-1116
adr	x4, #-6060
adr	x5, #-7460
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_adst_adst_16x16_8bpc_neon:
adr	x9, #-1136
adr	x4, #-6080
adr	x5, #-6084
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_adst_flipadst_16x16_8bpc_neon:
adr	x9, #-1156
adr	x4, #-6100
adr	x5, #-4892
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_flipadst_dct_16x16_8bpc_neon:
adr	x9, #-1176
adr	x4, #-4908
adr	x5, #-7520
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_flipadst_adst_16x16_8bpc_neon:
adr	x9, #-1196
adr	x4, #-4928
adr	x5, #-6144
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_flipadst_flipadst_16x16_8bpc_neon:
adr	x9, #-1216
adr	x4, #-4948
adr	x5, #-4952
mov	x13, #36
b	inv_txfm_add_16x16_neon
_inv_txfm_add_identity_dct_16x16_8bpc_neon:
adr	x9, #-1576
adr	x5, #-7576
mov	x13, #8
b	inv_txfm_add_16x16_neon
_inv_txfm_identity_add_16x4_neon:
mov	x15, x30
movi.8h	v4, #0
ld1.4h	{ v16 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v17 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v18 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v19 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v16 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v17 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v18 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v19 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
mov	w16, #27152
dup.4h	v0, w16
ld1.4h	{ v20 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v21 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v22 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v23 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v20 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v21 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v22 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
ld1.d	{ v23 }[1], [x2]
st1.4h	{ v4 }, [x2], #8
sqrdmulh.8h	v2, v16, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v19, v19, v2
sqrdmulh.8h	v2, v20, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v20, v20, v2
sqrdmulh.8h	v2, v21, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v21, v21, v2
sqrdmulh.8h	v2, v22, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v22, v22, v2
sqrdmulh.8h	v2, v23, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v23, v23, v2
sqrdmulh.8h	v2, v24, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v24, v24, v2
sqrdmulh.8h	v2, v25, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v25, v25, v2
sqrdmulh.8h	v2, v26, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v26, v26, v2
sqrdmulh.8h	v2, v27, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v27, v27, v2
sqrdmulh.8h	v2, v28, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v28, v28, v2
sqrdmulh.8h	v2, v29, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v29, v29, v2
sqrdmulh.8h	v2, v30, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v30, v30, v2
sqrdmulh.8h	v2, v31, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v31, v31, v2
b	inv_txfm_add_16x4_neon
_inv_txfm_identity_add_4x16_neon:
mov	x15, x30
movi.8h	v2, #0
mov	x11, #32
cmp	w3, w13
b.lt	inv_txfm_identity_add_4x16_neon
add	x6, x2, #16
ld1.8h	{ v24 }, [x6]
st1.8h	{ v2 }, [x6], x11
ld1.8h	{ v25 }, [x6]
st1.8h	{ v2 }, [x6], x11
ld1.8h	{ v26 }, [x6]
st1.8h	{ v2 }, [x6], x11
ld1.8h	{ v27 }, [x6]
st1.8h	{ v2 }, [x6], x11
mov	w16, #13576
dup.4h	v0, w16
sqrdmulh.8h	v2, v24, v0[0]
srhadd.8h	v24, v24, v2
sqrdmulh.8h	v2, v25, v0[0]
srhadd.8h	v25, v25, v2
sqrdmulh.8h	v2, v26, v0[0]
srhadd.8h	v26, v26, v2
sqrdmulh.8h	v2, v27, v0[0]
srhadd.8h	v27, v27, v2
trn1.8h	v4, v24, v25
trn2.8h	v5, v24, v25
trn1.8h	v6, v26, v27
trn2.8h	v7, v26, v27
trn1.4s	v24, v4, v6
trn2.4s	v26, v4, v6
trn1.4s	v25, v5, v7
trn2.4s	v27, v5, v7
mov.d	v28[0], v24[1]
mov.d	v29[0], v25[1]
mov.d	v30[0], v26[1]
mov.d	v31[0], v27[1]
b	inv_txfm_identity_add_4x16_neon
movi.4h	v24, #0
movi.4h	v25, #0
movi.4h	v26, #0
movi.4h	v27, #0
movi.4h	v28, #0
movi.4h	v29, #0
movi.4h	v30, #0
movi.4h	v31, #0
movi.8h	v2, #0
ld1.8h	{ v16 }, [x2]
st1.8h	{ v2 }, [x2], x11
ld1.8h	{ v17 }, [x2]
st1.8h	{ v2 }, [x2], x11
ld1.8h	{ v18 }, [x2]
st1.8h	{ v2 }, [x2], x11
ld1.8h	{ v19 }, [x2]
st1.8h	{ v2 }, [x2], x11
mov	w16, #13576
dup.4h	v0, w16
sqrdmulh.8h	v2, v16, v0[0]
srhadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v0[0]
srhadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v0[0]
srhadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v0[0]
srhadd.8h	v19, v19, v2
b	inv_txfm_add_4x16_neon
_inv_txfm_add_16x4_neon:
mov	x15, x30
movi.8h	v4, #0
ld1.4h	{ v16 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v17 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v18 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v19 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v20 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v21 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v22 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v23 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v24 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v25 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v26 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v27 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v28 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v29 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v30 }, [x2]
st1.4h	{ v4 }, [x2], #8
ld1.4h	{ v31 }, [x2]
st1.4h	{ v4 }, [x2], #8
blr	x4
mov.d	v16[1], v20[0]
mov.d	v17[1], v21[0]
mov.d	v18[1], v22[0]
mov.d	v19[1], v23[0]
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
mov.d	v24[1], v28[0]
mov.d	v25[1], v29[0]
mov.d	v26[1], v30[0]
mov.d	v27[1], v31[0]
srshr.8h	v20, v24, #1
srshr.8h	v21, v25, #1
srshr.8h	v22, v26, #1
srshr.8h	v23, v27, #1
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v4, v18, v19
trn2.8h	v5, v18, v19
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
blr	x5
mov	x6, x0
mov	x7, x6
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x6], x1
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x6], x1
st1.8b	{ v5 }, [x6], x1
trn1.8h	v2, v20, v21
trn2.8h	v3, v20, v21
trn1.8h	v4, v22, v23
trn2.8h	v5, v22, v23
trn1.4s	v16, v2, v4
trn2.4s	v18, v2, v4
trn1.4s	v17, v3, v5
trn2.4s	v19, v3, v5
blr	x5
add	x6, x0, #8
mov	x7, x6
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x6], x1
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x6], x1
st1.8b	{ v5 }, [x6], x1
ret	x15
_inv_txfm_add_4x16_neon:
mov	x15, x30
movi.8h	v2, #0
mov	x11, #32
cmp	w3, w13
b.lt	inv_txfm_add_4x16_neon
add	x6, x2, #16
ld1.8h	{ v16 }, [x6]
st1.8h	{ v2 }, [x6], x11
ld1.8h	{ v17 }, [x6]
st1.8h	{ v2 }, [x6], x11
ld1.8h	{ v18 }, [x6]
st1.8h	{ v2 }, [x6], x11
ld1.8h	{ v19 }, [x6]
st1.8h	{ v2 }, [x6], x11
blr	x4
srshr.8h	v24, v16, #1
srshr.8h	v25, v17, #1
srshr.8h	v26, v18, #1
srshr.8h	v27, v19, #1
trn1.8h	v4, v24, v25
trn2.8h	v5, v24, v25
trn1.8h	v6, v26, v27
trn2.8h	v7, v26, v27
trn1.4s	v24, v4, v6
trn2.4s	v26, v4, v6
trn1.4s	v25, v5, v7
trn2.4s	v27, v5, v7
mov.d	v28[0], v24[1]
mov.d	v29[0], v25[1]
mov.d	v30[0], v26[1]
mov.d	v31[0], v27[1]
b	inv_txfm_add_4x16_neon
movi.4h	v24, #0
movi.4h	v25, #0
movi.4h	v26, #0
movi.4h	v27, #0
movi.4h	v28, #0
movi.4h	v29, #0
movi.4h	v30, #0
movi.4h	v31, #0
movi.8h	v2, #0
ld1.8h	{ v16 }, [x2]
st1.8h	{ v2 }, [x2], x11
ld1.8h	{ v17 }, [x2]
st1.8h	{ v2 }, [x2], x11
ld1.8h	{ v18 }, [x2]
st1.8h	{ v2 }, [x2], x11
ld1.8h	{ v19 }, [x2]
st1.8h	{ v2 }, [x2], x11
blr	x4
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v6, v18, v19
trn2.8h	v7, v18, v19
trn1.4s	v16, v4, v6
trn2.4s	v18, v4, v6
trn1.4s	v17, v5, v7
trn2.4s	v19, v5, v7
mov.d	v20[0], v16[1]
mov.d	v21[0], v17[1]
mov.d	v22[0], v18[1]
mov.d	v23[0], v19[1]
blr	x5
mov	x6, x0
ld1.s	{ v0 }[0], [x6], x1
mov.d	v16[1], v17[0]
ld1.s	{ v0 }[1], [x6], x1
ld1.s	{ v1 }[0], [x6], x1
mov.d	v18[1], v19[0]
ld1.s	{ v1 }[1], [x6], x1
ld1.s	{ v2 }[0], [x6], x1
mov.d	v20[1], v21[0]
srshr.8h	v16, v16, #4
ld1.s	{ v2 }[1], [x6], x1
ld1.s	{ v3 }[0], [x6], x1
mov.d	v22[1], v23[0]
srshr.8h	v18, v18, #4
ld1.s	{ v3 }[1], [x6], x1
uaddw.8h	v16, v16, v0
ld1.s	{ v4 }[0], [x6], x1
mov.d	v24[1], v25[0]
srshr.8h	v20, v20, #4
ld1.s	{ v4 }[1], [x6], x1
uaddw.8h	v18, v18, v1
sqxtun.8b	v0, v16
ld1.s	{ v5 }[0], [x6], x1
mov.d	v26[1], v27[0]
srshr.8h	v22, v22, #4
ld1.s	{ v5 }[1], [x6], x1
uaddw.8h	v20, v20, v2
st1.s	{ v0 }[0], [x0], x1
sqxtun.8b	v1, v18
st1.s	{ v0 }[1], [x0], x1
ld1.s	{ v6 }[0], [x6], x1
mov.d	v28[1], v29[0]
srshr.8h	v24, v24, #4
ld1.s	{ v6 }[1], [x6], x1
uaddw.8h	v22, v22, v3
st1.s	{ v1 }[0], [x0], x1
sqxtun.8b	v2, v20
st1.s	{ v1 }[1], [x0], x1
ld1.s	{ v7 }[0], [x6], x1
mov.d	v30[1], v31[0]
srshr.8h	v26, v26, #4
ld1.s	{ v7 }[1], [x6], x1
uaddw.8h	v24, v24, v4
st1.s	{ v2 }[0], [x0], x1
sqxtun.8b	v3, v22
st1.s	{ v2 }[1], [x0], x1
srshr.8h	v28, v28, #4
uaddw.8h	v26, v26, v5
st1.s	{ v3 }[0], [x0], x1
sqxtun.8b	v4, v24
st1.s	{ v3 }[1], [x0], x1
srshr.8h	v30, v30, #4
uaddw.8h	v28, v28, v6
st1.s	{ v4 }[0], [x0], x1
sqxtun.8b	v5, v26
st1.s	{ v4 }[1], [x0], x1
uaddw.8h	v30, v30, v7
st1.s	{ v5 }[0], [x0], x1
sqxtun.8b	v6, v28
st1.s	{ v5 }[1], [x0], x1
st1.s	{ v6 }[0], [x0], x1
sqxtun.8b	v7, v30
st1.s	{ v6 }[1], [x0], x1
st1.s	{ v7 }[0], [x0], x1
st1.s	{ v7 }[1], [x0], x1
ret	x15
_inv_txfm_add_dct_dct_4x16_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_4x16_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #16
b	ltmp0
adr	x4, #-14408
adr	x5, #-8368
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_identity_4x16_8bpc_neon:
adr	x5, #-3724
mov	w13, #29
b	inv_txfm_identity_add_4x16_neon
_inv_txfm_add_dct_adst_4x16_8bpc_neon:
adr	x4, #-14436
adr	x5, #-5420
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_dct_flipadst_4x16_8bpc_neon:
adr	x4, #-14452
adr	x5, #-4704
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_dct_identity_4x16_8bpc_neon:
adr	x4, #-14468
adr	x5, #-3772
mov	w13, #8
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_dct_4x16_8bpc_neon:
adr	x4, #-14180
adr	x5, #-8444
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_adst_4x16_8bpc_neon:
adr	x4, #-14196
adr	x5, #-5484
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_adst_flipadst_4x16_8bpc_neon:
adr	x4, #-14212
adr	x5, #-4768
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_dct_4x16_8bpc_neon:
adr	x4, #-14068
adr	x5, #-8492
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_adst_4x16_8bpc_neon:
adr	x4, #-14084
adr	x5, #-5532
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_flipadst_4x16_8bpc_neon:
adr	x4, #-14100
adr	x5, #-4816
mov	w13, #29
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_dct_4x16_8bpc_neon:
adr	x5, #-8536
mov	w13, #32
b	inv_txfm_identity_add_4x16_neon
_inv_txfm_add_adst_identity_4x16_8bpc_neon:
adr	x4, #-14288
adr	x5, #-3896
mov	w13, #8
b	inv_txfm_add_4x16_neon
_inv_txfm_add_flipadst_identity_4x16_8bpc_neon:
adr	x4, #-14144
adr	x5, #-3912
mov	w13, #8
b	inv_txfm_add_4x16_neon
_inv_txfm_add_identity_adst_4x16_8bpc_neon:
adr	x5, #-5604
mov	w13, #32
b	inv_txfm_identity_add_4x16_neon
_inv_txfm_add_identity_flipadst_4x16_8bpc_neon:
adr	x5, #-4884
mov	w13, #32
b	inv_txfm_identity_add_4x16_neon
_inv_txfm_add_dct_dct_16x4_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x4_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #4
b	idct_dc_w16_neon
adr	x4, #-8648
adr	x5, #-14696
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_identity_16x4_8bpc_neon:
adr	x5, #-14032
b	inv_txfm_identity_add_16x4_neon
_inv_txfm_add_dct_adst_16x4_8bpc_neon:
adr	x4, #-8668
adr	x5, #-14412
b	inv_txfm_add_16x4_neon
_inv_txfm_add_dct_flipadst_16x4_8bpc_neon:
adr	x4, #-8680
adr	x5, #-14264
b	inv_txfm_add_16x4_neon
_inv_txfm_add_dct_identity_16x4_8bpc_neon:
adr	x4, #-8692
adr	x5, #-14068
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_dct_16x4_8bpc_neon:
adr	x4, #-5728
adr	x5, #-14752
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_adst_16x4_8bpc_neon:
adr	x4, #-5740
adr	x5, #-14460
b	inv_txfm_add_16x4_neon
_inv_txfm_add_adst_flipadst_16x4_8bpc_neon:
adr	x4, #-5752
adr	x5, #-14312
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_dct_16x4_8bpc_neon:
adr	x4, #-5032
adr	x5, #-14788
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_adst_16x4_8bpc_neon:
adr	x4, #-5044
adr	x5, #-14496
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_flipadst_16x4_8bpc_neon:
adr	x4, #-5056
adr	x5, #-14348
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_dct_16x4_8bpc_neon:
adr	x5, #-14820
b	inv_txfm_identity_add_16x4_neon
_inv_txfm_add_adst_identity_16x4_8bpc_neon:
adr	x4, #-5808
adr	x5, #-14160
b	inv_txfm_add_16x4_neon
_inv_txfm_add_flipadst_identity_16x4_8bpc_neon:
adr	x4, #-5088
adr	x5, #-14172
b	inv_txfm_add_16x4_neon
_inv_txfm_add_identity_adst_16x4_8bpc_neon:
adr	x5, #-14548
b	inv_txfm_identity_add_16x4_neon
_inv_txfm_add_identity_flipadst_16x4_8bpc_neon:
adr	x5, #-14396
b	inv_txfm_identity_add_16x4_neon
_inv_txfm_identity_add_16x8_neon:
mov	x15, x30
movi.8h	v4, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v17 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v18 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v19 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v20 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v21 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v22 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v23 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v24 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v25 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v26 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v27 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v28 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v29 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v30 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v31 }, [x2]
st1.8h	{ v4 }, [x2], #16
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
sqrdmulh.8h	v24, v24, v0[0]
sqrdmulh.8h	v25, v25, v0[0]
sqrdmulh.8h	v26, v26, v0[0]
sqrdmulh.8h	v27, v27, v0[0]
sqrdmulh.8h	v28, v28, v0[0]
sqrdmulh.8h	v29, v29, v0[0]
sqrdmulh.8h	v30, v30, v0[0]
sqrdmulh.8h	v31, v31, v0[0]
mov	w16, #27152
dup.4h	v0, w16
sqrdmulh.8h	v2, v16, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v19, v19, v2
sqrdmulh.8h	v2, v20, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v20, v20, v2
sqrdmulh.8h	v2, v21, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v21, v21, v2
sqrdmulh.8h	v2, v22, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v22, v22, v2
sqrdmulh.8h	v2, v23, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v23, v23, v2
sqrdmulh.8h	v2, v24, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v24, v24, v2
sqrdmulh.8h	v2, v25, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v25, v25, v2
sqrdmulh.8h	v2, v26, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v26, v26, v2
sqrdmulh.8h	v2, v27, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v27, v27, v2
sqrdmulh.8h	v2, v28, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v28, v28, v2
sqrdmulh.8h	v2, v29, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v29, v29, v2
sqrdmulh.8h	v2, v30, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v30, v30, v2
sqrdmulh.8h	v2, v31, v0[0]
srshr.8h	v2, v2, #1
sqadd.8h	v31, v31, v2
b	inv_txfm_add_16x8_neon
_inv_txfm_identity_add_8x16_neon:
mov	x15, x30
movi.8h	v4, #0
mov	w16, #23168
dup.4h	v0, w16
mov	x11, #32
cmp	w3, w13
b.lt	inv_txfm_identity_add_8x16_neon
add	x6, x2, #16
ld1.8h	{ v24 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v25 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v26 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v27 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v28 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v29 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v30 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v31 }, [x6]
st1.8h	{ v4 }, [x6], x11
sqrdmulh.8h	v24, v24, v0[0]
sqrdmulh.8h	v25, v25, v0[0]
sqrdmulh.8h	v26, v26, v0[0]
sqrdmulh.8h	v27, v27, v0[0]
sqrdmulh.8h	v28, v28, v0[0]
sqrdmulh.8h	v29, v29, v0[0]
sqrdmulh.8h	v30, v30, v0[0]
sqrdmulh.8h	v31, v31, v0[0]
trn1.8h	v2, v24, v25
trn2.8h	v3, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v3, v27
trn2.4s	v3, v3, v27
trn1.4s	v27, v2, v25
trn2.4s	v2, v2, v25
trn1.2d	v24, v27, v28
trn2.2d	v28, v27, v28
trn1.2d	v25, v29, v30
trn2.2d	v29, v29, v30
trn2.2d	v30, v2, v26
trn1.2d	v26, v2, v26
trn1.2d	v27, v3, v31
trn2.2d	v31, v3, v31
b	inv_txfm_identity_add_8x16_neon
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
movi.8h	v4, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v17 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v18 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v19 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v20 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v21 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v22 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v23 }, [x2]
st1.8h	{ v4 }, [x2], x11
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
b	inv_txfm_add_8x16_neon
_inv_txfm_add_16x8_neon:
mov	x15, x30
movi.8h	v4, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v17 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v18 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v19 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v20 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v21 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v22 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v23 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v24 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v25 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v26 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v27 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v28 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v29 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v30 }, [x2]
st1.8h	{ v4 }, [x2], #16
ld1.8h	{ v31 }, [x2]
st1.8h	{ v4 }, [x2], #16
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
sqrdmulh.8h	v24, v24, v0[0]
sqrdmulh.8h	v25, v25, v0[0]
sqrdmulh.8h	v26, v26, v0[0]
sqrdmulh.8h	v27, v27, v0[0]
sqrdmulh.8h	v28, v28, v0[0]
sqrdmulh.8h	v29, v29, v0[0]
sqrdmulh.8h	v30, v30, v0[0]
sqrdmulh.8h	v31, v31, v0[0]
blr	x4
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
srshr.8h	v20, v20, #1
srshr.8h	v21, v21, #1
srshr.8h	v22, v22, #1
srshr.8h	v23, v23, #1
srshr.8h	v24, v24, #1
srshr.8h	v25, v25, #1
srshr.8h	v26, v26, #1
srshr.8h	v27, v27, #1
srshr.8h	v28, v28, #1
srshr.8h	v29, v29, #1
srshr.8h	v30, v30, #1
srshr.8h	v31, v31, #1
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v3, v19
trn2.4s	v3, v3, v19
trn1.4s	v19, v2, v17
trn2.4s	v2, v2, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v2, v18
trn1.2d	v18, v2, v18
trn1.2d	v19, v3, v23
trn2.2d	v23, v3, v23
blr	x5
mov	x6, x0
mov	x7, x6
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x6], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x6], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x6], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x6], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x6], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x6], x1
st1.8b	{ v3 }, [x6], x1
trn1.8h	v2, v24, v25
trn2.8h	v3, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v3, v27
trn2.4s	v3, v3, v27
trn1.4s	v27, v2, v25
trn2.4s	v2, v2, v25
trn1.2d	v16, v27, v28
trn2.2d	v20, v27, v28
trn1.2d	v17, v29, v30
trn2.2d	v21, v29, v30
trn2.2d	v22, v2, v26
trn1.2d	v18, v2, v26
trn1.2d	v19, v3, v31
trn2.2d	v23, v3, v31
blr	x5
add	x0, x0, #8
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
ret	x15
_inv_txfm_add_8x16_neon:
mov	x15, x30
movi.8h	v4, #0
mov	w16, #23168
dup.4h	v0, w16
mov	x11, #32
cmp	w3, w13
b.lt	inv_txfm_add_8x16_neon
add	x6, x2, #16
ld1.8h	{ v16 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v17 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v18 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v19 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v20 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v21 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v22 }, [x6]
st1.8h	{ v4 }, [x6], x11
ld1.8h	{ v23 }, [x6]
st1.8h	{ v4 }, [x6], x11
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
blr	x4
srshr.8h	v24, v16, #1
srshr.8h	v25, v17, #1
srshr.8h	v26, v18, #1
srshr.8h	v27, v19, #1
srshr.8h	v28, v20, #1
srshr.8h	v29, v21, #1
srshr.8h	v30, v22, #1
srshr.8h	v31, v23, #1
trn1.8h	v2, v24, v25
trn2.8h	v3, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v3, v27
trn2.4s	v3, v3, v27
trn1.4s	v27, v2, v25
trn2.4s	v2, v2, v25
trn1.2d	v24, v27, v28
trn2.2d	v28, v27, v28
trn1.2d	v25, v29, v30
trn2.2d	v29, v29, v30
trn2.2d	v30, v2, v26
trn1.2d	v26, v2, v26
trn1.2d	v27, v3, v31
trn2.2d	v31, v3, v31
b	inv_txfm_add_8x16_neon
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
movi.8h	v4, #0
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v17 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v18 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v19 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v20 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v21 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v22 }, [x2]
st1.8h	{ v4 }, [x2], x11
ld1.8h	{ v23 }, [x2]
st1.8h	{ v4 }, [x2], x11
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
blr	x4
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
srshr.8h	v20, v20, #1
srshr.8h	v21, v21, #1
srshr.8h	v22, v22, #1
srshr.8h	v23, v23, #1
trn1.8h	v2, v16, v17
trn2.8h	v3, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v3, v19
trn2.4s	v3, v3, v19
trn1.4s	v19, v2, v17
trn2.4s	v2, v2, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v2, v18
trn1.2d	v18, v2, v18
trn1.2d	v19, v3, v23
trn2.2d	v23, v3, v23
blr	x5
mov	x6, x0
ld1.8b	{ v2 }, [x6], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x6], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x6], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x6], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x6], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x6], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x6], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x6], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
ld1.8b	{ v4 }, [x6], x1
srshr.8h	v24, v24, #4
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
ld1.8b	{ v5 }, [x6], x1
srshr.8h	v25, v25, #4
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
ld1.8b	{ v6 }, [x6], x1
srshr.8h	v26, v26, #4
uaddw.8h	v24, v24, v4
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x6], x1
srshr.8h	v27, v27, #4
uaddw.8h	v25, v25, v5
sqxtun.8b	v4, v24
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x6], x1
srshr.8h	v28, v28, #4
uaddw.8h	v26, v26, v6
sqxtun.8b	v5, v25
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x6], x1
srshr.8h	v29, v29, #4
uaddw.8h	v27, v27, v7
sqxtun.8b	v6, v26
st1.8b	{ v5 }, [x0], x1
ld1.8b	{ v4 }, [x6], x1
srshr.8h	v30, v30, #4
uaddw.8h	v28, v28, v2
sqxtun.8b	v7, v27
st1.8b	{ v6 }, [x0], x1
ld1.8b	{ v5 }, [x6], x1
srshr.8h	v31, v31, #4
uaddw.8h	v29, v29, v3
sqxtun.8b	v2, v28
st1.8b	{ v7 }, [x0], x1
uaddw.8h	v30, v30, v4
sqxtun.8b	v3, v29
st1.8b	{ v2 }, [x0], x1
uaddw.8h	v31, v31, v5
sqxtun.8b	v4, v30
st1.8b	{ v3 }, [x0], x1
sqxtun.8b	v5, v31
st1.8b	{ v4 }, [x0], x1
st1.8b	{ v5 }, [x0], x1
ret	x15
_inv_txfm_add_dct_dct_8x16_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_8x16_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w8_neon
adr	x4, #-16068
adr	x5, #-12200
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_identity_8x16_8bpc_neon:
adr	x5, #-6904
mov	x13, #43
b	inv_txfm_identity_add_8x16_neon
_inv_txfm_add_dct_adst_8x16_8bpc_neon:
adr	x4, #-16096
adr	x5, #-10832
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_dct_flipadst_8x16_8bpc_neon:
adr	x4, #-16112
adr	x5, #-9636
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_dct_identity_8x16_8bpc_neon:
adr	x4, #-16128
adr	x5, #-6952
mov	x13, #8
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_dct_8x16_8bpc_neon:
adr	x4, #-15616
adr	x5, #-12276
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_adst_8x16_8bpc_neon:
adr	x4, #-15632
adr	x5, #-10896
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_adst_flipadst_8x16_8bpc_neon:
adr	x4, #-15648
adr	x5, #-9700
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_dct_8x16_8bpc_neon:
adr	x4, #-15184
adr	x5, #-12324
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_adst_8x16_8bpc_neon:
adr	x4, #-15200
adr	x5, #-10944
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_flipadst_8x16_8bpc_neon:
adr	x4, #-15216
adr	x5, #-9748
mov	x13, #43
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_dct_8x16_8bpc_neon:
adr	x5, #-12368
mov	x13, #64
b	inv_txfm_identity_add_8x16_neon
_inv_txfm_add_adst_identity_8x16_8bpc_neon:
adr	x4, #-15724
adr	x5, #-7076
mov	x13, #8
b	inv_txfm_add_8x16_neon
_inv_txfm_add_flipadst_identity_8x16_8bpc_neon:
adr	x4, #-15260
adr	x5, #-7092
mov	x13, #8
b	inv_txfm_add_8x16_neon
_inv_txfm_add_identity_adst_8x16_8bpc_neon:
adr	x5, #-11016
mov	x13, #64
b	inv_txfm_identity_add_8x16_neon
_inv_txfm_add_identity_flipadst_8x16_8bpc_neon:
adr	x5, #-9816
mov	x13, #64
b	inv_txfm_identity_add_8x16_neon
_inv_txfm_add_dct_dct_16x8_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x8_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #8
b	idct_dc_w16_neon
adr	x4, #-12484
adr	x5, #-16360
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_identity_16x8_8bpc_neon:
adr	x5, #-14304
b	inv_txfm_identity_add_16x8_neon
_inv_txfm_add_dct_adst_16x8_8bpc_neon:
adr	x4, #-12504
adr	x5, #-15852
b	inv_txfm_add_16x8_neon
_inv_txfm_add_dct_flipadst_16x8_8bpc_neon:
adr	x4, #-12516
adr	x5, #-15384
b	inv_txfm_add_16x8_neon
_inv_txfm_add_dct_identity_16x8_8bpc_neon:
adr	x4, #-12528
adr	x5, #-14340
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_dct_16x8_8bpc_neon:
adr	x4, #-11144
adr	x5, #-16416
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_adst_16x8_8bpc_neon:
adr	x4, #-11156
adr	x5, #-15900
b	inv_txfm_add_16x8_neon
_inv_txfm_add_adst_flipadst_16x8_8bpc_neon:
adr	x4, #-11168
adr	x5, #-15432
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_dct_16x8_8bpc_neon:
adr	x4, #-9968
adr	x5, #-16452
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_adst_16x8_8bpc_neon:
adr	x4, #-9980
adr	x5, #-15936
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_flipadst_16x8_8bpc_neon:
adr	x4, #-9992
adr	x5, #-15468
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_dct_16x8_8bpc_neon:
adr	x5, #-16484
b	inv_txfm_identity_add_16x8_neon
_inv_txfm_add_adst_identity_16x8_8bpc_neon:
adr	x4, #-11224
adr	x5, #-14432
b	inv_txfm_add_16x8_neon
_inv_txfm_add_flipadst_identity_16x8_8bpc_neon:
adr	x4, #-10024
adr	x5, #-14444
b	inv_txfm_add_16x8_neon
_inv_txfm_add_identity_adst_16x8_8bpc_neon:
adr	x5, #-15988
b	inv_txfm_identity_add_16x8_neon
_inv_txfm_add_identity_flipadst_16x8_8bpc_neon:
adr	x5, #-15516
b	inv_txfm_identity_add_16x8_neon
_inv_dct32_odd_8h_x16_neon:
adrp	x16, inv_dct32_odd_8h_x16_neon
add	x16, x16, #0
ld1.8h	{ v0, v1 }, [x16]
sub	x16, x16, #32
smull.4s	v2, v16, v0[0]
smlsl.4s	v2, v31, v0[1]
smull2.4s	v3, v16, v0[0]
smlsl2.4s	v3, v31, v0[1]
smull.4s	v4, v16, v0[1]
smlal.4s	v4, v31, v0[0]
smull2.4s	v5, v16, v0[1]
smlal2.4s	v5, v31, v0[0]
smull.4s	v6, v24, v0[2]
smlsl.4s	v6, v23, v0[3]
smull2.4s	v7, v24, v0[2]
smlsl2.4s	v7, v23, v0[3]
sqrshrn.4h	v16, v2, #12
sqrshrn2.8h	v16, v3, #12
sqrshrn.4h	v31, v4, #12
sqrshrn2.8h	v31, v5, #12
smull.4s	v2, v24, v0[3]
smlal.4s	v2, v23, v0[2]
smull2.4s	v3, v24, v0[3]
smlal2.4s	v3, v23, v0[2]
smull.4s	v4, v20, v0[4]
smlsl.4s	v4, v27, v0[5]
smull2.4s	v5, v20, v0[4]
smlsl2.4s	v5, v27, v0[5]
sqrshrn.4h	v24, v6, #12
sqrshrn2.8h	v24, v7, #12
sqrshrn.4h	v23, v2, #12
sqrshrn2.8h	v23, v3, #12
smull.4s	v6, v20, v0[5]
smlal.4s	v6, v27, v0[4]
smull2.4s	v7, v20, v0[5]
smlal2.4s	v7, v27, v0[4]
smull.4s	v2, v28, v0[6]
smlsl.4s	v2, v19, v0[7]
smull2.4s	v3, v28, v0[6]
smlsl2.4s	v3, v19, v0[7]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
smull.4s	v4, v28, v0[7]
smlal.4s	v4, v19, v0[6]
smull2.4s	v5, v28, v0[7]
smlal2.4s	v5, v19, v0[6]
smull.4s	v6, v18, v1[0]
smlsl.4s	v6, v29, v1[1]
smull2.4s	v7, v18, v1[0]
smlsl2.4s	v7, v29, v1[1]
sqrshrn.4h	v28, v2, #12
sqrshrn2.8h	v28, v3, #12
sqrshrn.4h	v19, v4, #12
sqrshrn2.8h	v19, v5, #12
smull.4s	v2, v18, v1[1]
smlal.4s	v2, v29, v1[0]
smull2.4s	v3, v18, v1[1]
smlal2.4s	v3, v29, v1[0]
smull.4s	v4, v26, v1[2]
smlsl.4s	v4, v21, v1[3]
smull2.4s	v5, v26, v1[2]
smlsl2.4s	v5, v21, v1[3]
sqrshrn.4h	v18, v6, #12
sqrshrn2.8h	v18, v7, #12
sqrshrn.4h	v29, v2, #12
sqrshrn2.8h	v29, v3, #12
smull.4s	v6, v26, v1[3]
smlal.4s	v6, v21, v1[2]
smull2.4s	v7, v26, v1[3]
smlal2.4s	v7, v21, v1[2]
smull.4s	v2, v22, v1[4]
smlsl.4s	v2, v25, v1[5]
smull2.4s	v3, v22, v1[4]
smlsl2.4s	v3, v25, v1[5]
sqrshrn.4h	v26, v4, #12
sqrshrn2.8h	v26, v5, #12
sqrshrn.4h	v21, v6, #12
sqrshrn2.8h	v21, v7, #12
smull.4s	v4, v22, v1[5]
smlal.4s	v4, v25, v1[4]
smull2.4s	v5, v22, v1[5]
smlal2.4s	v5, v25, v1[4]
smull.4s	v6, v30, v1[6]
smlsl.4s	v6, v17, v1[7]
smull2.4s	v7, v30, v1[6]
smlsl2.4s	v7, v17, v1[7]
sqrshrn.4h	v22, v2, #12
sqrshrn2.8h	v22, v3, #12
sqrshrn.4h	v25, v4, #12
sqrshrn2.8h	v25, v5, #12
smull.4s	v2, v30, v1[7]
smlal.4s	v2, v17, v1[6]
smull2.4s	v3, v30, v1[7]
smlal2.4s	v3, v17, v1[6]
sqrshrn.4h	v30, v6, #12
sqrshrn2.8h	v30, v7, #12
sqrshrn.4h	v17, v2, #12
sqrshrn2.8h	v17, v3, #12
ld1.8h	{ v0 }, [x16]
sqsub.8h	v2, v16, v24
sqadd.8h	v16, v16, v24
sqsub.8h	v3, v31, v23
sqadd.8h	v31, v31, v23
sqsub.8h	v24, v28, v20
sqadd.8h	v28, v28, v20
sqadd.8h	v23, v18, v26
sqsub.8h	v18, v18, v26
sqsub.8h	v20, v30, v22
sqadd.8h	v30, v30, v22
sqadd.8h	v26, v17, v25
sqsub.8h	v17, v17, v25
sqsub.8h	v22, v29, v21
sqadd.8h	v29, v29, v21
sqadd.8h	v25, v19, v27
sqsub.8h	v19, v19, v27
smull.4s	v4, v3, v0[4]
smlsl.4s	v4, v2, v0[5]
smull2.4s	v5, v3, v0[4]
smlsl2.4s	v5, v2, v0[5]
smull.4s	v6, v3, v0[5]
smlal.4s	v6, v2, v0[4]
smull2.4s	v7, v3, v0[5]
smlal2.4s	v7, v2, v0[4]
smull.4s	v2, v19, v0[5]
smlal.4s	v2, v24, v0[4]
smull2.4s	v3, v19, v0[5]
smlal2.4s	v3, v24, v0[4]
sqrshrn.4h	v21, v4, #12
sqrshrn2.8h	v21, v5, #12
sqrshrn.4h	v27, v6, #12
sqrshrn2.8h	v27, v7, #12
neg.4s	v2, v2
neg.4s	v3, v3
smull.4s	v4, v19, v0[4]
smlsl.4s	v4, v24, v0[5]
smull2.4s	v5, v19, v0[4]
smlsl2.4s	v5, v24, v0[5]
smull.4s	v6, v22, v0[6]
smlsl.4s	v6, v18, v0[7]
smull2.4s	v7, v22, v0[6]
smlsl2.4s	v7, v18, v0[7]
sqrshrn.4h	v19, v2, #12
sqrshrn2.8h	v19, v3, #12
sqrshrn.4h	v24, v4, #12
sqrshrn2.8h	v24, v5, #12
smull.4s	v2, v22, v0[7]
smlal.4s	v2, v18, v0[6]
smull2.4s	v3, v22, v0[7]
smlal2.4s	v3, v18, v0[6]
smull.4s	v4, v17, v0[7]
smlal.4s	v4, v20, v0[6]
smull2.4s	v5, v17, v0[7]
smlal2.4s	v5, v20, v0[6]
sqrshrn.4h	v22, v6, #12
sqrshrn2.8h	v22, v7, #12
sqrshrn.4h	v18, v2, #12
sqrshrn2.8h	v18, v3, #12
neg.4s	v4, v4
neg.4s	v5, v5
smull.4s	v6, v17, v0[6]
smlsl.4s	v6, v20, v0[7]
smull2.4s	v7, v17, v0[6]
smlsl2.4s	v7, v20, v0[7]
sqrshrn.4h	v17, v4, #12
sqrshrn2.8h	v17, v5, #12
sqrshrn.4h	v20, v6, #12
sqrshrn2.8h	v20, v7, #12
sqsub.8h	v2, v27, v24
sqadd.8h	v27, v27, v24
sqsub.8h	v3, v21, v19
sqadd.8h	v21, v21, v19
sqsub.8h	v24, v16, v28
sqadd.8h	v16, v16, v28
sqsub.8h	v19, v30, v23
sqadd.8h	v30, v30, v23
sqsub.8h	v28, v17, v22
sqadd.8h	v17, v17, v22
sqadd.8h	v23, v26, v29
sqsub.8h	v26, v26, v29
sqadd.8h	v22, v20, v18
sqsub.8h	v20, v20, v18
sqsub.8h	v29, v31, v25
sqadd.8h	v31, v31, v25
smull.4s	v4, v2, v0[2]
smlsl.4s	v4, v3, v0[3]
smull2.4s	v5, v2, v0[2]
smlsl2.4s	v5, v3, v0[3]
smull.4s	v6, v2, v0[3]
smlal.4s	v6, v3, v0[2]
smull2.4s	v7, v2, v0[3]
smlal2.4s	v7, v3, v0[2]
smull.4s	v2, v29, v0[2]
smlsl.4s	v2, v24, v0[3]
smull2.4s	v3, v29, v0[2]
smlsl2.4s	v3, v24, v0[3]
sqrshrn.4h	v18, v4, #12
sqrshrn2.8h	v18, v5, #12
sqrshrn.4h	v25, v6, #12
sqrshrn2.8h	v25, v7, #12
smull.4s	v4, v29, v0[3]
smlal.4s	v4, v24, v0[2]
smull2.4s	v5, v29, v0[3]
smlal2.4s	v5, v24, v0[2]
smull.4s	v6, v26, v0[3]
smlal.4s	v6, v19, v0[2]
smull2.4s	v7, v26, v0[3]
smlal2.4s	v7, v19, v0[2]
sqrshrn.4h	v29, v2, #12
sqrshrn2.8h	v29, v3, #12
sqrshrn.4h	v24, v4, #12
sqrshrn2.8h	v24, v5, #12
neg.4s	v6, v6
neg.4s	v7, v7
smull.4s	v2, v26, v0[2]
smlsl.4s	v2, v19, v0[3]
smull2.4s	v3, v26, v0[2]
smlsl2.4s	v3, v19, v0[3]
smull.4s	v4, v20, v0[3]
smlal.4s	v4, v28, v0[2]
smull2.4s	v5, v20, v0[3]
smlal2.4s	v5, v28, v0[2]
sqrshrn.4h	v26, v6, #12
sqrshrn2.8h	v26, v7, #12
sqrshrn.4h	v19, v2, #12
sqrshrn2.8h	v19, v3, #12
neg.4s	v4, v4
neg.4s	v5, v5
smull.4s	v6, v20, v0[2]
smlsl.4s	v6, v28, v0[3]
smull2.4s	v7, v20, v0[2]
smlsl2.4s	v7, v28, v0[3]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v28, v6, #12
sqrshrn2.8h	v28, v7, #12
sqsub.8h	v2, v16, v30
sqadd.8h	v16, v16, v30
sqsub.8h	v3, v31, v23
sqadd.8h	v31, v31, v23
sqsub.8h	v23, v21, v17
sqadd.8h	v17, v21, v17
sqadd.8h	v30, v27, v22
sqsub.8h	v21, v27, v22
sqsub.8h	v27, v18, v20
sqadd.8h	v18, v18, v20
sqadd.8h	v4, v29, v26
sqsub.8h	v26, v29, v26
sqadd.8h	v29, v25, v28
sqsub.8h	v25, v25, v28
sqadd.8h	v28, v24, v19
sqsub.8h	v24, v24, v19
mov.16b	v19, v4
smull.4s	v4, v24, v0[0]
smlsl.4s	v4, v26, v0[0]
smull2.4s	v5, v24, v0[0]
smlsl2.4s	v5, v26, v0[0]
smull.4s	v6, v24, v0[0]
smlal.4s	v6, v26, v0[0]
smull2.4s	v7, v24, v0[0]
smlal2.4s	v7, v26, v0[0]
sqrshrn.4h	v20, v4, #12
sqrshrn2.8h	v20, v5, #12
sqrshrn.4h	v22, v6, #12
sqrshrn2.8h	v22, v7, #12
smull.4s	v4, v25, v0[0]
smlal.4s	v4, v27, v0[0]
smull2.4s	v5, v25, v0[0]
smlal2.4s	v5, v27, v0[0]
smull.4s	v6, v25, v0[0]
smlsl.4s	v6, v27, v0[0]
smull2.4s	v7, v25, v0[0]
smlsl2.4s	v7, v27, v0[0]
mov.16b	v27, v22
sqrshrn.4h	v26, v4, #12
sqrshrn2.8h	v26, v5, #12
smull.4s	v24, v21, v0[0]
smlsl.4s	v24, v23, v0[0]
smull2.4s	v25, v21, v0[0]
smlsl2.4s	v25, v23, v0[0]
smull.4s	v4, v21, v0[0]
smlal.4s	v4, v23, v0[0]
smull2.4s	v5, v21, v0[0]
smlal2.4s	v5, v23, v0[0]
sqrshrn.4h	v21, v6, #12
sqrshrn2.8h	v21, v7, #12
sqrshrn.4h	v22, v24, #12
sqrshrn2.8h	v22, v25, #12
sqrshrn.4h	v25, v4, #12
sqrshrn2.8h	v25, v5, #12
smull.4s	v4, v3, v0[0]
smlsl.4s	v4, v2, v0[0]
smull2.4s	v5, v3, v0[0]
smlsl2.4s	v5, v2, v0[0]
smull.4s	v6, v3, v0[0]
smlal.4s	v6, v2, v0[0]
smull2.4s	v7, v3, v0[0]
smlal2.4s	v7, v2, v0[0]
sqrshrn.4h	v23, v4, #12
sqrshrn2.8h	v23, v5, #12
sqrshrn.4h	v24, v6, #12
sqrshrn2.8h	v24, v7, #12
ret
_inv_txfm_horz_dct_32x8_neon:
mov	x14, x30
movi.8h	v7, #0
lsl	x8, x8, #1
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
bl	inv_dct_8h_x16_neon
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
trn1.8h	v4, v24, v25
trn2.8h	v5, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v5, v27
trn2.4s	v5, v5, v27
trn1.4s	v27, v4, v25
trn2.4s	v4, v4, v25
trn1.2d	v24, v27, v28
trn2.2d	v28, v27, v28
trn1.2d	v25, v29, v30
trn2.2d	v29, v29, v30
trn2.2d	v30, v4, v26
trn1.2d	v26, v4, v26
trn1.2d	v27, v5, v31
trn2.2d	v31, v5, v31
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v24 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v25 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v26 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v27 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v28 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v29 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v30 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v23 }, [x6], #16
st1.8h	{ v31 }, [x6], #16
add	x6, x6, #32
sub	x6, x6, #512
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
bl	inv_dct32_odd_8h_x16_neon
trn1.8h	v4, v31, v30
trn2.8h	v5, v31, v30
trn1.8h	v30, v29, v28
trn2.8h	v28, v29, v28
trn1.8h	v31, v27, v26
trn2.8h	v26, v27, v26
trn1.8h	v29, v25, v24
trn2.8h	v24, v25, v24
trn1.4s	v27, v31, v29
trn2.4s	v29, v31, v29
trn1.4s	v25, v26, v24
trn2.4s	v24, v26, v24
trn1.4s	v26, v5, v28
trn2.4s	v5, v5, v28
trn1.4s	v28, v4, v30
trn2.4s	v4, v4, v30
trn1.2d	v31, v28, v27
trn2.2d	v27, v28, v27
trn1.2d	v30, v26, v25
trn2.2d	v26, v26, v25
trn2.2d	v25, v4, v29
trn1.2d	v29, v4, v29
trn1.2d	v28, v5, v24
trn2.2d	v24, v5, v24
trn1.8h	v4, v23, v22
trn2.8h	v5, v23, v22
trn1.8h	v22, v21, v20
trn2.8h	v20, v21, v20
trn1.8h	v23, v19, v18
trn2.8h	v18, v19, v18
trn1.8h	v21, v17, v16
trn2.8h	v16, v17, v16
trn1.4s	v19, v23, v21
trn2.4s	v21, v23, v21
trn1.4s	v17, v18, v16
trn2.4s	v16, v18, v16
trn1.4s	v18, v5, v20
trn2.4s	v5, v5, v20
trn1.4s	v20, v4, v22
trn2.4s	v4, v4, v22
trn1.2d	v23, v20, v19
trn2.2d	v19, v20, v19
trn1.2d	v22, v18, v17
trn2.2d	v18, v18, v17
trn2.2d	v17, v4, v21
trn1.2d	v21, v4, v21
trn1.2d	v20, v5, v16
trn2.2d	v16, v5, v16
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v31
sqsub.8h	v6, v5, v23
sqadd.8h	v4, v4, v31
sqadd.8h	v5, v5, v23
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v30
sqsub.8h	v6, v5, v22
sqadd.8h	v4, v4, v30
sqadd.8h	v5, v5, v22
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v29
sqsub.8h	v6, v5, v21
sqadd.8h	v4, v4, v29
sqadd.8h	v5, v5, v21
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v28
sqsub.8h	v6, v5, v20
sqadd.8h	v4, v4, v28
sqadd.8h	v5, v5, v20
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v27
sqsub.8h	v6, v5, v19
sqadd.8h	v4, v4, v27
sqadd.8h	v5, v5, v19
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v26
sqsub.8h	v6, v5, v18
sqadd.8h	v4, v4, v26
sqadd.8h	v5, v5, v18
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v25
sqsub.8h	v6, v5, v17
sqadd.8h	v4, v4, v25
sqadd.8h	v5, v5, v17
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v24
sqsub.8h	v6, v5, v16
sqadd.8h	v4, v4, v24
sqadd.8h	v5, v5, v16
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #2
srshr.8h	v5, v5, #2
srshr.8h	v6, v6, #2
srshr.8h	v7, v7, #2
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ret	x14
_inv_txfm_horz_scale_dct_32x8_neon:
mov	x14, x30
movi.8h	v7, #0
lsl	x8, x8, #1
mov	w16, #23168
dup.4h	v0, w16
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
sqrdmulh.8h	v24, v24, v0[0]
sqrdmulh.8h	v25, v25, v0[0]
sqrdmulh.8h	v26, v26, v0[0]
sqrdmulh.8h	v27, v27, v0[0]
sqrdmulh.8h	v28, v28, v0[0]
sqrdmulh.8h	v29, v29, v0[0]
sqrdmulh.8h	v30, v30, v0[0]
sqrdmulh.8h	v31, v31, v0[0]
bl	inv_dct_8h_x16_neon
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
trn1.8h	v4, v24, v25
trn2.8h	v5, v24, v25
trn1.8h	v25, v26, v27
trn2.8h	v27, v26, v27
trn1.8h	v24, v28, v29
trn2.8h	v29, v28, v29
trn1.8h	v26, v30, v31
trn2.8h	v31, v30, v31
trn1.4s	v28, v24, v26
trn2.4s	v26, v24, v26
trn1.4s	v30, v29, v31
trn2.4s	v31, v29, v31
trn1.4s	v29, v5, v27
trn2.4s	v5, v5, v27
trn1.4s	v27, v4, v25
trn2.4s	v4, v4, v25
trn1.2d	v24, v27, v28
trn2.2d	v28, v27, v28
trn1.2d	v25, v29, v30
trn2.2d	v29, v29, v30
trn2.2d	v30, v4, v26
trn1.2d	v26, v4, v26
trn1.2d	v27, v5, v31
trn2.2d	v31, v5, v31
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v24 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v25 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v26 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v27 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v28 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v29 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v30 }, [x6], #16
add	x6, x6, #32
st1.8h	{ v23 }, [x6], #16
st1.8h	{ v31 }, [x6], #16
add	x6, x6, #32
sub	x6, x6, #512
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v24 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v25 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v26 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v27 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v28 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v29 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v30 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v31 }, [x7]
st1.8h	{ v7 }, [x7], x8
sqrdmulh.8h	v16, v16, v0[1]
sqrdmulh.8h	v17, v17, v0[1]
sqrdmulh.8h	v18, v18, v0[1]
sqrdmulh.8h	v19, v19, v0[1]
sqrdmulh.8h	v20, v20, v0[1]
sqrdmulh.8h	v21, v21, v0[1]
sqrdmulh.8h	v22, v22, v0[1]
sqrdmulh.8h	v23, v23, v0[1]
sqrdmulh.8h	v24, v24, v0[1]
sqrdmulh.8h	v25, v25, v0[1]
sqrdmulh.8h	v26, v26, v0[1]
sqrdmulh.8h	v27, v27, v0[1]
sqrdmulh.8h	v28, v28, v0[1]
sqrdmulh.8h	v29, v29, v0[1]
sqrdmulh.8h	v30, v30, v0[1]
sqrdmulh.8h	v31, v31, v0[1]
bl	inv_dct32_odd_8h_x16_neon
trn1.8h	v4, v31, v30
trn2.8h	v5, v31, v30
trn1.8h	v30, v29, v28
trn2.8h	v28, v29, v28
trn1.8h	v31, v27, v26
trn2.8h	v26, v27, v26
trn1.8h	v29, v25, v24
trn2.8h	v24, v25, v24
trn1.4s	v27, v31, v29
trn2.4s	v29, v31, v29
trn1.4s	v25, v26, v24
trn2.4s	v24, v26, v24
trn1.4s	v26, v5, v28
trn2.4s	v5, v5, v28
trn1.4s	v28, v4, v30
trn2.4s	v4, v4, v30
trn1.2d	v31, v28, v27
trn2.2d	v27, v28, v27
trn1.2d	v30, v26, v25
trn2.2d	v26, v26, v25
trn2.2d	v25, v4, v29
trn1.2d	v29, v4, v29
trn1.2d	v28, v5, v24
trn2.2d	v24, v5, v24
trn1.8h	v4, v23, v22
trn2.8h	v5, v23, v22
trn1.8h	v22, v21, v20
trn2.8h	v20, v21, v20
trn1.8h	v23, v19, v18
trn2.8h	v18, v19, v18
trn1.8h	v21, v17, v16
trn2.8h	v16, v17, v16
trn1.4s	v19, v23, v21
trn2.4s	v21, v23, v21
trn1.4s	v17, v18, v16
trn2.4s	v16, v18, v16
trn1.4s	v18, v5, v20
trn2.4s	v5, v5, v20
trn1.4s	v20, v4, v22
trn2.4s	v4, v4, v22
trn1.2d	v23, v20, v19
trn2.2d	v19, v20, v19
trn1.2d	v22, v18, v17
trn2.2d	v18, v18, v17
trn2.2d	v17, v4, v21
trn1.2d	v21, v4, v21
trn1.2d	v20, v5, v16
trn2.2d	v16, v5, v16
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v31
sqsub.8h	v6, v5, v23
sqadd.8h	v4, v4, v31
sqadd.8h	v5, v5, v23
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v30
sqsub.8h	v6, v5, v22
sqadd.8h	v4, v4, v30
sqadd.8h	v5, v5, v22
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v29
sqsub.8h	v6, v5, v21
sqadd.8h	v4, v4, v29
sqadd.8h	v5, v5, v21
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v28
sqsub.8h	v6, v5, v20
sqadd.8h	v4, v4, v28
sqadd.8h	v5, v5, v20
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v27
sqsub.8h	v6, v5, v19
sqadd.8h	v4, v4, v27
sqadd.8h	v5, v5, v19
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v26
sqsub.8h	v6, v5, v18
sqadd.8h	v4, v4, v26
sqadd.8h	v5, v5, v18
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v25
sqsub.8h	v6, v5, v17
sqadd.8h	v4, v4, v25
sqadd.8h	v5, v5, v17
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ld1.8h	{ v4, v5 }, [x6]
sqsub.8h	v7, v4, v24
sqsub.8h	v6, v5, v16
sqadd.8h	v4, v4, v24
sqadd.8h	v5, v5, v16
rev64.8h	v6, v6
rev64.8h	v7, v7
srshr.8h	v4, v4, #1
srshr.8h	v5, v5, #1
srshr.8h	v6, v6, #1
srshr.8h	v7, v7, #1
ext.16b	v6, v6, v6, #8
st1.8h	{ v4, v5 }, [x6], #32
ext.16b	v7, v7, v7, #8
st1.8h	{ v6, v7 }, [x6], #32
ret	x14
_inv_txfm_add_vert_dct_8x32_neon:
mov	x14, x30
lsl	x8, x8, #1
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
ld1.8h	{ v24 }, [x7], x8
ld1.8h	{ v25 }, [x7], x8
ld1.8h	{ v26 }, [x7], x8
ld1.8h	{ v27 }, [x7], x8
ld1.8h	{ v28 }, [x7], x8
ld1.8h	{ v29 }, [x7], x8
ld1.8h	{ v30 }, [x7], x8
ld1.8h	{ v31 }, [x7], x8
sub	x7, x7, x8, lsl #4
bl	inv_dct_8h_x16_neon
st1.8h	{ v16 }, [x7], x8
st1.8h	{ v17 }, [x7], x8
st1.8h	{ v18 }, [x7], x8
st1.8h	{ v19 }, [x7], x8
st1.8h	{ v20 }, [x7], x8
st1.8h	{ v21 }, [x7], x8
st1.8h	{ v22 }, [x7], x8
st1.8h	{ v23 }, [x7], x8
st1.8h	{ v24 }, [x7], x8
st1.8h	{ v25 }, [x7], x8
st1.8h	{ v26 }, [x7], x8
st1.8h	{ v27 }, [x7], x8
st1.8h	{ v28 }, [x7], x8
st1.8h	{ v29 }, [x7], x8
st1.8h	{ v30 }, [x7], x8
st1.8h	{ v31 }, [x7], x8
sub	x7, x7, x8, lsl #4
add	x7, x7, x8, lsr #1
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
ld1.8h	{ v24 }, [x7], x8
ld1.8h	{ v25 }, [x7], x8
ld1.8h	{ v26 }, [x7], x8
ld1.8h	{ v27 }, [x7], x8
ld1.8h	{ v28 }, [x7], x8
ld1.8h	{ v29 }, [x7], x8
ld1.8h	{ v30 }, [x7], x8
ld1.8h	{ v31 }, [x7], x8
sub	x7, x7, x8, lsl #4
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_8h_x16_neon
neg	x9, x8
mov	x10, x6
ld1.8h	{ v5 }, [x7], x8
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8b	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v31
ld1.8h	{ v7 }, [x7], x8
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v30
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v29
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x8
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v28
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x8
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8b	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v27
ld1.8h	{ v7 }, [x7], x8
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v26
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v25
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x8
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v24
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x8
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8b	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v23
ld1.8h	{ v7 }, [x7], x8
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v22
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v21
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x8
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v20
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x8
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x8
ld1.8b	{ v3 }, [x10], x1
sqadd.8h	v5, v5, v19
ld1.8h	{ v7 }, [x7], x8
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqadd.8h	v6, v6, v18
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqadd.8h	v7, v7, v17
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x8
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqadd.8h	v5, v5, v16
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
sub	x7, x7, x8
ld1.8h	{ v5 }, [x7], x9
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8b	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v16
ld1.8h	{ v7 }, [x7], x9
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v17
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v18
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x9
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v19
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x9
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8b	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v20
ld1.8h	{ v7 }, [x7], x9
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v21
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v22
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x9
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v23
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x9
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8b	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v24
ld1.8h	{ v7 }, [x7], x9
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v25
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v26
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x9
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v27
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ld1.8h	{ v5 }, [x7], x9
ld1.8b	{ v2 }, [x10], x1
ld1.8h	{ v6 }, [x7], x9
ld1.8b	{ v3 }, [x10], x1
sqsub.8h	v5, v5, v28
ld1.8h	{ v7 }, [x7], x9
ld1.8b	{ v4 }, [x10], x1
srshr.8h	v5, v5, #4
sqsub.8h	v6, v6, v29
uaddw.8h	v5, v5, v2
srshr.8h	v6, v6, #4
sqsub.8h	v7, v7, v30
sqxtun.8b	v2, v5
ld1.8h	{ v5 }, [x7], x9
uaddw.8h	v6, v6, v3
srshr.8h	v7, v7, #4
sqsub.8h	v5, v5, v31
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v2 }, [x10], x1
sqxtun.8b	v3, v6
uaddw.8h	v7, v7, v4
srshr.8h	v5, v5, #4
st1.8b	{ v3 }, [x6], x1
sqxtun.8b	v4, v7
uaddw.8h	v5, v5, v2
st1.8b	{ v4 }, [x6], x1
sqxtun.8b	v2, v5
st1.8b	{ v2 }, [x6], x1
ret	x14
_inv_txfm_add_identity_identity_32x32_8bpc_neon:
movi.8h	v0, #0
adrp	x13, inv_txfm_add_identity_identity_32x32_8bpc_neon
add	x13, x13, #0
mov	x8, #64
mov	w9, #0
adrp	x12, inv_txfm_add_identity_identity_32x32_8bpc_neon
add	x12, x12, #0
add	w9, w9, #8
ld1.8h	{ v16 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v17 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v18 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v19 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v20 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v21 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v22 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v23 }, [x2]
st1.8h	{ v0 }, [x2], x8
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #2
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #2
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #2
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #2
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #2
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #2
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #2
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #2
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
ldrh	w11, [x12], #2
sub	x0, x0, x1, lsl #3
add	x0, x0, #8
cmp	w3, w11
b.ge	inv_txfm_add_identity_identity_32x32_8bpc_neon
ldrh	w11, [x13], #2
cmp	w3, w11
b.lt	inv_txfm_add_identity_identity_32x32_8bpc_neon
sub	x0, x0, w9, uxtw
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #16
b	inv_txfm_add_identity_identity_32x32_8bpc_neon
ret
_inv_txfm_add_identity_identity_16x32_8bpc_neon:
mov	w16, #23168
mov	w17, #27152
dup.4h	v1, w16
movi.8h	v0, #0
mov.h	v1[1], w17
adrp	x13, inv_txfm_add_identity_identity_16x32_8bpc_neon
add	x13, x13, #0
mov	x8, #64
mov	w9, #0
adrp	x12, inv_txfm_add_identity_identity_16x32_8bpc_neon
add	x12, x12, #0
add	w9, w9, #8
ld1.8h	{ v16 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v17 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v18 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v19 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v20 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v21 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v22 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v23 }, [x2]
st1.8h	{ v0 }, [x2], x8
sqrdmulh.8h	v16, v16, v1[0]
sqrdmulh.8h	v17, v17, v1[0]
sqrdmulh.8h	v18, v18, v1[0]
sqrdmulh.8h	v19, v19, v1[0]
sqrdmulh.8h	v20, v20, v1[0]
sqrdmulh.8h	v21, v21, v1[0]
sqrdmulh.8h	v22, v22, v1[0]
sqrdmulh.8h	v23, v23, v1[0]
sqrdmulh.8h	v2, v16, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v19, v19, v2
sqrdmulh.8h	v2, v20, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v20, v20, v2
sqrdmulh.8h	v2, v21, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v21, v21, v2
sqrdmulh.8h	v2, v22, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v22, v22, v2
sqrdmulh.8h	v2, v23, v1[1]
srshr.8h	v2, v2, #1
sqadd.8h	v23, v23, v2
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #2
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #2
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #2
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #2
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #2
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #2
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #2
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #2
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
ldrh	w11, [x12], #2
sub	x0, x0, x1, lsl #3
add	x0, x0, #8
cmp	w3, w11
b.ge	inv_txfm_add_identity_identity_16x32_8bpc_neon
ldrh	w11, [x13], #2
cmp	w3, w11
b.lt	inv_txfm_add_identity_identity_16x32_8bpc_neon
sub	x0, x0, w9, uxtw
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #16
b	inv_txfm_add_identity_identity_16x32_8bpc_neon
ret
_inv_txfm_add_identity_identity_32x16_8bpc_neon:
mov	w16, #23168
mov	w17, #27152
dup.4h	v1, w16
movi.8h	v0, #0
mov.h	v1[1], w17
adrp	x13, inv_txfm_add_identity_identity_32x16_8bpc_neon
add	x13, x13, #0
mov	x8, #32
mov	w9, #0
adrp	x12, inv_txfm_add_identity_identity_32x16_8bpc_neon
add	x12, x12, #0
add	w9, w9, #8
ld1.8h	{ v16 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v17 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v18 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v19 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v20 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v21 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v22 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v23 }, [x2]
st1.8h	{ v0 }, [x2], x8
sqrdmulh.8h	v16, v16, v1[0]
sqrdmulh.8h	v17, v17, v1[0]
sqrdmulh.8h	v18, v18, v1[0]
sqrdmulh.8h	v19, v19, v1[0]
sqrdmulh.8h	v20, v20, v1[0]
sqrdmulh.8h	v21, v21, v1[0]
sqrdmulh.8h	v22, v22, v1[0]
sqrdmulh.8h	v23, v23, v1[0]
sqshl.8h	v16, v16, #1
sqshl.8h	v17, v17, #1
sqshl.8h	v18, v18, #1
sqshl.8h	v19, v19, #1
sqshl.8h	v20, v20, #1
sqshl.8h	v21, v21, #1
sqshl.8h	v22, v22, #1
sqshl.8h	v23, v23, #1
sqrdmulh.8h	v2, v16, v1[1]
sqadd.8h	v16, v16, v16
sqadd.8h	v16, v16, v2
sqrdmulh.8h	v2, v17, v1[1]
sqadd.8h	v17, v17, v17
sqadd.8h	v17, v17, v2
sqrdmulh.8h	v2, v18, v1[1]
sqadd.8h	v18, v18, v18
sqadd.8h	v18, v18, v2
sqrdmulh.8h	v2, v19, v1[1]
sqadd.8h	v19, v19, v19
sqadd.8h	v19, v19, v2
sqrdmulh.8h	v2, v20, v1[1]
sqadd.8h	v20, v20, v20
sqadd.8h	v20, v20, v2
sqrdmulh.8h	v2, v21, v1[1]
sqadd.8h	v21, v21, v21
sqadd.8h	v21, v21, v2
sqrdmulh.8h	v2, v22, v1[1]
sqadd.8h	v22, v22, v22
sqadd.8h	v22, v22, v2
sqrdmulh.8h	v2, v23, v1[1]
sqadd.8h	v23, v23, v23
sqadd.8h	v23, v23, v2
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
ldrh	w11, [x12], #2
sub	x0, x0, x1, lsl #3
add	x0, x0, #8
cmp	w3, w11
b.ge	inv_txfm_add_identity_identity_32x16_8bpc_neon
ldrh	w11, [x13], #2
cmp	w3, w11
b.lt	inv_txfm_add_identity_identity_32x16_8bpc_neon
sub	x0, x0, w9, uxtw
add	x0, x0, x1, lsl #3
msub	x2, x8, x9, x2
add	x2, x2, #16
b	inv_txfm_add_identity_identity_32x16_8bpc_neon
ret
_inv_txfm_add_identity_identity_8x32_8bpc_neon:
movi.8h	v0, #0
adrp	x13, inv_txfm_add_identity_identity_8x32_8bpc_neon
add	x13, x13, #0
mov	w8, #64
ldrh	w12, [x13], #2
ld1.8h	{ v16 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v17 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v18 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v19 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v20 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v21 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v22 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v23 }, [x2]
st1.8h	{ v0 }, [x2], x8
srshr.8h	v16, v16, #1
srshr.8h	v17, v17, #1
srshr.8h	v18, v18, #1
srshr.8h	v19, v19, #1
srshr.8h	v20, v20, #1
srshr.8h	v21, v21, #1
srshr.8h	v22, v22, #1
srshr.8h	v23, v23, #1
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
cmp	w3, w12
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #2
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #2
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #2
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #2
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #2
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #2
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #2
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #2
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
b.lt	inv_txfm_add_identity_identity_8x32_8bpc_neon
sub	x2, x2, x8, lsl #3
add	x2, x2, #16
b	inv_txfm_add_identity_identity_8x32_8bpc_neon
ret
_inv_txfm_add_identity_identity_32x8_8bpc_neon:
movi.8h	v0, #0
adrp	x13, inv_txfm_add_identity_identity_32x8_8bpc_neon
add	x13, x13, #0
mov	w8, #16
ldrh	w12, [x13], #2
ld1.8h	{ v16 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v17 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v18 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v19 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v20 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v21 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v22 }, [x2]
st1.8h	{ v0 }, [x2], x8
ld1.8h	{ v23 }, [x2]
st1.8h	{ v0 }, [x2], x8
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
cmp	w3, w12
mov	x7, x0
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #3
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #3
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #3
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #3
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #3
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x0], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #3
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x0], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #3
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x0], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #3
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x0], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x0], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x0], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x0], x1
st1.8b	{ v3 }, [x0], x1
b.lt	inv_txfm_add_identity_identity_32x8_8bpc_neon
sub	x0, x0, x1, lsl #3
add	x0, x0, #8
b	inv_txfm_add_identity_identity_32x8_8bpc_neon
ret
_inv_txfm_add_dct_dct_32x32_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x32_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #2048
adrp	x13, inv_txfm_add_dct_dct_32x32_8bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
mov	x6, sp
add	x7, x2, #0
mov	x8, #64
bl	inv_txfm_horz_dct_32x8_neon
add	x6, sp, #512
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_8bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #64
bl	inv_txfm_horz_dct_32x8_neon
add	x6, sp, #1024
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_8bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #64
bl	inv_txfm_horz_dct_32x8_neon
add	x6, sp, #1536
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x32_8bpc_neon
add	x7, x2, #48
mov	x8, #64
bl	inv_txfm_horz_dct_32x8_neon
b	inv_txfm_add_dct_dct_32x32_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_32x32_8bpc_neon
add	x6, x0, #0
mov	x7, sp
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #8
add	x7, sp, #16
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #16
add	x7, sp, #32
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #24
add	x7, sp, #48
mov	x8, #64
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #2048
ret	x15
_inv_txfm_add_dct_dct_16x32_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x32_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w16_neon
mov	x15, x30
sub	sp, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_16x32_8bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
adr	x4, #-20344
mov	x6, sp
add	x7, x2, #0
mov	x8, #64
bl	inv_txfm_horz_scale_16x8_neon
add	x6, sp, #256
add	x7, x2, #16
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_8bpc_neon
ldrh	w12, [x13], #2
mov	x8, #64
bl	inv_txfm_horz_scale_16x8_neon
add	x6, sp, #512
add	x7, x2, #32
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_8bpc_neon
ldrh	w12, [x13], #2
mov	x8, #64
bl	inv_txfm_horz_scale_16x8_neon
add	x6, sp, #768
add	x7, x2, #48
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x32_8bpc_neon
mov	x8, #64
bl	inv_txfm_horz_scale_16x8_neon
b	inv_txfm_add_dct_dct_16x32_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #8
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_16x32_8bpc_neon
add	x6, x0, #0
mov	x7, sp
mov	x8, #32
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #8
add	x7, sp, #16
mov	x8, #32
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #1024
ret	x15
_inv_txfm_add_dct_dct_32x16_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x16_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #1024
adr	x5, #-20596
mov	x6, sp
add	x7, x2, #0
mov	x8, #32
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, sp, #512
add	x7, x2, #16
mov	w8, #8
cmp	w3, #36
b.lt	inv_txfm_add_dct_dct_32x16_8bpc_neon
mov	x8, #32
bl	inv_txfm_horz_scale_dct_32x8_neon
b	inv_txfm_add_dct_dct_32x16_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_32x16_8bpc_neon
mov	x8, #64
add	x6, x0, #0
mov	x7, sp
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #8
add	x7, sp, #16
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #16
add	x7, sp, #32
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #24
add	x7, sp, #48
bl	inv_txfm_add_vert_8x16_neon
add	sp, sp, #1024
ret	x15
_inv_txfm_add_dct_dct_8x32_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_8x32_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w8_neon
mov	x15, x30
sub	sp, sp, #512
adrp	x13, inv_txfm_add_dct_dct_8x32_8bpc_neon
add	x13, x13, #0
movi.8h	v28, #0
mov	x8, #64
mov	w9, #32
mov	x6, sp
ld1.8h	{ v16 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v17 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v18 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v19 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v20 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v21 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v22 }, [x2]
st1.8h	{ v28 }, [x2], x8
ld1.8h	{ v23 }, [x2]
st1.8h	{ v28 }, [x2], x8
ldrh	w12, [x13], #2
sub	x2, x2, x8, lsl #3
sub	w9, w9, #8
add	x2, x2, #16
bl	inv_dct_8h_x8_neon
srshr.8h	v16, v16, #2
srshr.8h	v17, v17, #2
srshr.8h	v18, v18, #2
srshr.8h	v19, v19, #2
srshr.8h	v20, v20, #2
srshr.8h	v21, v21, #2
srshr.8h	v22, v22, #2
srshr.8h	v23, v23, #2
trn1.8h	v24, v16, v17
trn2.8h	v25, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v25, v19
trn2.4s	v25, v25, v19
trn1.4s	v19, v24, v17
trn2.4s	v24, v24, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v24, v18
trn1.2d	v18, v24, v18
trn1.2d	v19, v25, v23
trn2.2d	v23, v25, v23
st1.8h	{ v16, v17, v18, v19 }, [x6], #64
cmp	w3, w12
st1.8h	{ v20, v21, v22, v23 }, [x6], #64
b.ge	inv_txfm_add_dct_dct_8x32_8bpc_neon
cbz	w9, inv_txfm_add_dct_dct_8x32_8bpc_neon
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
subs	w9, w9, #8
st1.8h	{ v28, v29, v30, v31 }, [x6], #64
st1.8h	{ v28, v29, v30, v31 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_8x32_8bpc_neon
mov	x6, x0
mov	x7, sp
mov	x8, #16
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, sp, #512
ret	x15
_inv_txfm_add_dct_dct_32x8_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x8_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #8
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #512
mov	x6, sp
mov	x7, x2
mov	x8, #16
bl	inv_txfm_horz_dct_32x8_neon
mov	x8, #64
mov	w9, #0
add	x6, x0, x9
add	x7, sp, x9, lsl #1
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
add	w9, w9, #8
bl	inv_dct_8h_x8_neon
cmp	w9, #32
mov	x7, x6
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v16, v16, #4
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v17, v17, #4
ld1.8b	{ v4 }, [x7], x1
srshr.8h	v18, v18, #4
uaddw.8h	v16, v16, v2
ld1.8b	{ v5 }, [x7], x1
srshr.8h	v19, v19, #4
uaddw.8h	v17, v17, v3
sqxtun.8b	v2, v16
ld1.8b	{ v6 }, [x7], x1
srshr.8h	v20, v20, #4
uaddw.8h	v18, v18, v4
sqxtun.8b	v3, v17
st1.8b	{ v2 }, [x6], x1
ld1.8b	{ v7 }, [x7], x1
srshr.8h	v21, v21, #4
uaddw.8h	v19, v19, v5
sqxtun.8b	v4, v18
st1.8b	{ v3 }, [x6], x1
ld1.8b	{ v2 }, [x7], x1
srshr.8h	v22, v22, #4
uaddw.8h	v20, v20, v6
sqxtun.8b	v5, v19
st1.8b	{ v4 }, [x6], x1
ld1.8b	{ v3 }, [x7], x1
srshr.8h	v23, v23, #4
uaddw.8h	v21, v21, v7
sqxtun.8b	v6, v20
st1.8b	{ v5 }, [x6], x1
uaddw.8h	v22, v22, v2
sqxtun.8b	v7, v21
st1.8b	{ v6 }, [x6], x1
uaddw.8h	v23, v23, v3
sqxtun.8b	v2, v22
st1.8b	{ v7 }, [x6], x1
sqxtun.8b	v3, v23
st1.8b	{ v2 }, [x6], x1
st1.8b	{ v3 }, [x6], x1
b.lt	inv_txfm_add_dct_dct_32x8_8bpc_neon
add	sp, sp, #512
ret	x15
_inv_dct64_step1_neon:
ld1.8h	{ v0, v1 }, [x17], #32
sqrdmulh.8h	v23, v16, v0[1]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v22, v17, v0[2]
sqrdmulh.8h	v17, v17, v0[3]
sqrdmulh.8h	v21, v18, v0[5]
sqrdmulh.8h	v18, v18, v0[4]
sqrdmulh.8h	v20, v19, v0[6]
sqrdmulh.8h	v19, v19, v0[7]
sqadd.8h	v24, v16, v17
sqsub.8h	v25, v16, v17
sqsub.8h	v26, v19, v18
sqadd.8h	v27, v19, v18
sqadd.8h	v28, v20, v21
sqsub.8h	v29, v20, v21
sqsub.8h	v30, v23, v22
sqadd.8h	v31, v23, v22
smull.4s	v2, v29, v1[0]
smlal.4s	v2, v26, v1[1]
smull2.4s	v3, v29, v1[0]
smlal2.4s	v3, v26, v1[1]
smull.4s	v4, v29, v1[1]
smlsl.4s	v4, v26, v1[0]
smull2.4s	v5, v29, v1[1]
smlsl2.4s	v5, v26, v1[0]
neg.4s	v2, v2
neg.4s	v3, v3
smull.4s	v6, v30, v1[1]
smlsl.4s	v6, v25, v1[0]
smull2.4s	v7, v30, v1[1]
smlsl2.4s	v7, v25, v1[0]
sqrshrn.4h	v26, v2, #12
sqrshrn2.8h	v26, v3, #12
smull.4s	v2, v30, v1[0]
smlal.4s	v2, v25, v1[1]
smull2.4s	v3, v30, v1[0]
smlal2.4s	v3, v25, v1[1]
sqrshrn.4h	v29, v4, #12
sqrshrn2.8h	v29, v5, #12
sqrshrn.4h	v25, v6, #12
sqrshrn2.8h	v25, v7, #12
sqrshrn.4h	v30, v2, #12
sqrshrn2.8h	v30, v3, #12
sqadd.8h	v16, v24, v27
sqsub.8h	v19, v24, v27
sqadd.8h	v17, v25, v26
sqsub.8h	v18, v25, v26
sqsub.8h	v20, v31, v28
sqadd.8h	v23, v31, v28
sqsub.8h	v21, v30, v29
sqadd.8h	v22, v30, v29
smull.4s	v2, v21, v1[2]
smlal.4s	v2, v18, v1[3]
smull2.4s	v3, v21, v1[2]
smlal2.4s	v3, v18, v1[3]
smull.4s	v4, v21, v1[3]
smlsl.4s	v4, v18, v1[2]
smull2.4s	v5, v21, v1[3]
smlsl2.4s	v5, v18, v1[2]
smull.4s	v6, v20, v1[2]
smlal.4s	v6, v19, v1[3]
smull2.4s	v7, v20, v1[2]
smlal2.4s	v7, v19, v1[3]
sqrshrn.4h	v21, v2, #12
sqrshrn2.8h	v21, v3, #12
sqrshrn.4h	v18, v4, #12
sqrshrn2.8h	v18, v5, #12
smull.4s	v2, v20, v1[3]
smlsl.4s	v2, v19, v1[2]
smull2.4s	v3, v20, v1[3]
smlsl2.4s	v3, v19, v1[2]
sqrshrn.4h	v20, v6, #12
sqrshrn2.8h	v20, v7, #12
sqrshrn.4h	v19, v2, #12
sqrshrn2.8h	v19, v3, #12
st1.8h	{ v16, v17, v18, v19 }, [x6], #64
st1.8h	{ v20, v21, v22, v23 }, [x6], #64
ret
_inv_dct64_step2_neon:
adrp	x16, inv_dct64_step2_neon
add	x16, x16, #0
ld1.4h	{ v0 }, [x16]
ldr	q16, [x6]
ldr	q17, [x9, #128]
ldr	q18, [x9]
ldr	q19, [x6, #128]
ldr	q20, [x6, #256]
ldr	q21, [x9, #384]
ldr	q22, [x9, #256]
ldr	q23, [x6, #384]
sqadd.8h	v24, v16, v17
sqsub.8h	v25, v16, v17
sqadd.8h	v26, v18, v19
sqsub.8h	v27, v18, v19
sqsub.8h	v28, v21, v20
sqadd.8h	v29, v21, v20
sqadd.8h	v30, v23, v22
sqsub.8h	v31, v23, v22
smull.4s	v2, v27, v0[3]
smlal.4s	v2, v25, v0[2]
smull2.4s	v3, v27, v0[3]
smlal2.4s	v3, v25, v0[2]
smull.4s	v4, v27, v0[2]
smlsl.4s	v4, v25, v0[3]
smull2.4s	v5, v27, v0[2]
smlsl2.4s	v5, v25, v0[3]
smull.4s	v6, v31, v0[3]
smlal.4s	v6, v28, v0[2]
smull2.4s	v7, v31, v0[3]
smlal2.4s	v7, v28, v0[2]
sqrshrn.4h	v25, v2, #12
sqrshrn2.8h	v25, v3, #12
sqrshrn.4h	v27, v4, #12
sqrshrn2.8h	v27, v5, #12
neg.4s	v6, v6
neg.4s	v7, v7
smull.4s	v2, v31, v0[2]
smlsl.4s	v2, v28, v0[3]
smull2.4s	v3, v31, v0[2]
smlsl2.4s	v3, v28, v0[3]
sqrshrn.4h	v31, v6, #12
sqrshrn2.8h	v31, v7, #12
sqrshrn.4h	v28, v2, #12
sqrshrn2.8h	v28, v3, #12
sqadd.8h	v16, v24, v29
sqsub.8h	v19, v24, v29
sqadd.8h	v17, v27, v31
sqsub.8h	v18, v27, v31
sqsub.8h	v20, v26, v30
sqadd.8h	v23, v26, v30
sqsub.8h	v21, v25, v28
sqadd.8h	v22, v25, v28
smull.4s	v2, v21, v0[0]
smlsl.4s	v2, v18, v0[0]
smull2.4s	v3, v21, v0[0]
smlsl2.4s	v3, v18, v0[0]
smull.4s	v4, v21, v0[0]
smlal.4s	v4, v18, v0[0]
smull2.4s	v5, v21, v0[0]
smlal2.4s	v5, v18, v0[0]
smull.4s	v6, v20, v0[0]
smlsl.4s	v6, v19, v0[0]
smull2.4s	v7, v20, v0[0]
smlsl2.4s	v7, v19, v0[0]
sqrshrn.4h	v18, v2, #12
sqrshrn2.8h	v18, v3, #12
sqrshrn.4h	v21, v4, #12
sqrshrn2.8h	v21, v5, #12
smull.4s	v2, v20, v0[0]
smlal.4s	v2, v19, v0[0]
smull2.4s	v3, v20, v0[0]
smlal2.4s	v3, v19, v0[0]
sqrshrn.4h	v19, v6, #12
sqrshrn2.8h	v19, v7, #12
sqrshrn.4h	v20, v2, #12
sqrshrn2.8h	v20, v3, #12
str	q16, [x6]
str	q17, [x9]
str	q18, [x6, #128]
str	q19, [x9, #128]
str	q20, [x6, #256]
str	q21, [x9, #256]
str	q22, [x6, #384]
str	q23, [x9, #384]
add	x6, x6, #16
sub	x9, x9, #16
cmp	x6, x9
b.lt	inv_dct64_step2_neon
ret
_inv_txfm_dct_8h_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
bl	inv_dct_8h_x16_neon
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v23 }, [x6], #16
st1.8h	{ v24 }, [x6], #16
st1.8h	{ v25 }, [x6], #16
st1.8h	{ v26 }, [x6], #16
st1.8h	{ v27 }, [x6], #16
st1.8h	{ v28 }, [x6], #16
st1.8h	{ v29 }, [x6], #16
st1.8h	{ v30 }, [x6], #16
st1.8h	{ v31 }, [x6], #16
ld1.8h	{ v16 }, [x7], x8
ld1.8h	{ v17 }, [x7], x8
ld1.8h	{ v18 }, [x7], x8
ld1.8h	{ v19 }, [x7], x8
ld1.8h	{ v20 }, [x7], x8
ld1.8h	{ v21 }, [x7], x8
ld1.8h	{ v22 }, [x7], x8
ld1.8h	{ v23 }, [x7], x8
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_8h_x16_neon
add	x10, x6, #240
sub	x6, x6, #256
mov	x9, #-16
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v31
sqsub.8h	v31, v2, v31
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v30
sqsub.8h	v30, v3, v30
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v29
sub	x6, x6, #64
sqsub.8h	v29, v4, v29
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v31 }, [x10], x9
sqadd.8h	v3, v5, v28
sqsub.8h	v28, v5, v28
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v30 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v29 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v28 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v27
sqsub.8h	v27, v2, v27
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v26
sqsub.8h	v26, v3, v26
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v25
sub	x6, x6, #64
sqsub.8h	v25, v4, v25
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v27 }, [x10], x9
sqadd.8h	v3, v5, v24
sqsub.8h	v24, v5, v24
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v26 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v25 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v24 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v23
sqsub.8h	v23, v2, v23
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v22
sqsub.8h	v22, v3, v22
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v21
sub	x6, x6, #64
sqsub.8h	v21, v4, v21
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v23 }, [x10], x9
sqadd.8h	v3, v5, v20
sqsub.8h	v20, v5, v20
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v22 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v21 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v20 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v19
sqsub.8h	v19, v2, v19
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v18
sqsub.8h	v18, v3, v18
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v17
sub	x6, x6, #64
sqsub.8h	v17, v4, v17
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v19 }, [x10], x9
sqadd.8h	v3, v5, v16
sqsub.8h	v16, v5, v16
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v18 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v17 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v16 }, [x10], x9
add	x6, x6, #256
adrp	x17, inv_txfm_dct_8h_x64_neon
add	x17, x17, #0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1.8h	{ v16 }, [x7]
ld1.8h	{ v17 }, [x9]
ld1.8h	{ v18 }, [x10]
ld1.8h	{ v19 }, [x11]
bl	inv_dct64_step1_neon
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1.8h	{ v16 }, [x10]
ld1.8h	{ v17 }, [x11]
ld1.8h	{ v18 }, [x9]
ld1.8h	{ v19 }, [x7]
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
sub	x6, x6, #512
add	x9, x6, #112
bl	inv_dct64_step2_neon
ret	x14
_inv_txfm_dct_clear_8h_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
bl	inv_dct_8h_x16_neon
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v23 }, [x6], #16
st1.8h	{ v24 }, [x6], #16
st1.8h	{ v25 }, [x6], #16
st1.8h	{ v26 }, [x6], #16
st1.8h	{ v27 }, [x6], #16
st1.8h	{ v28 }, [x6], #16
st1.8h	{ v29 }, [x6], #16
st1.8h	{ v30 }, [x6], #16
st1.8h	{ v31 }, [x6], #16
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
bl	inv_dct32_odd_8h_x16_neon
add	x10, x6, #240
sub	x6, x6, #256
mov	x9, #-16
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v31
sqsub.8h	v31, v2, v31
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v30
sqsub.8h	v30, v3, v30
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v29
sub	x6, x6, #64
sqsub.8h	v29, v4, v29
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v31 }, [x10], x9
sqadd.8h	v3, v5, v28
sqsub.8h	v28, v5, v28
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v30 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v29 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v28 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v27
sqsub.8h	v27, v2, v27
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v26
sqsub.8h	v26, v3, v26
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v25
sub	x6, x6, #64
sqsub.8h	v25, v4, v25
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v27 }, [x10], x9
sqadd.8h	v3, v5, v24
sqsub.8h	v24, v5, v24
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v26 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v25 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v24 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v23
sqsub.8h	v23, v2, v23
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v22
sqsub.8h	v22, v3, v22
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v21
sub	x6, x6, #64
sqsub.8h	v21, v4, v21
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v23 }, [x10], x9
sqadd.8h	v3, v5, v20
sqsub.8h	v20, v5, v20
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v22 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v21 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v20 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v19
sqsub.8h	v19, v2, v19
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v18
sqsub.8h	v18, v3, v18
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v17
sub	x6, x6, #64
sqsub.8h	v17, v4, v17
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v19 }, [x10], x9
sqadd.8h	v3, v5, v16
sqsub.8h	v16, v5, v16
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v18 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v17 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v16 }, [x10], x9
add	x6, x6, #256
adrp	x17, inv_txfm_dct_clear_8h_x64_neon
add	x17, x17, #0
movi.8h	v7, #0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1.8h	{ v16 }, [x7]
ld1.8h	{ v17 }, [x9]
ld1.8h	{ v18 }, [x10]
ld1.8h	{ v19 }, [x11]
st1.8h	{ v7 }, [x7]
st1.8h	{ v7 }, [x9]
st1.8h	{ v7 }, [x10]
st1.8h	{ v7 }, [x11]
bl	inv_dct64_step1_neon
movi.8h	v7, #0
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1.8h	{ v16 }, [x10]
ld1.8h	{ v17 }, [x11]
ld1.8h	{ v18 }, [x9]
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7]
st1.8h	{ v7 }, [x9]
st1.8h	{ v7 }, [x10]
st1.8h	{ v7 }, [x11]
bl	inv_dct64_step1_neon
movi.8h	v7, #0
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
movi.8h	v7, #0
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
str	q7, [x10]
str	q7, [x11, x8]
str	q7, [x9]
str	q7, [x7, x8]
bl	inv_dct64_step1_neon
sub	x6, x6, #512
add	x9, x6, #112
bl	inv_dct64_step2_neon
ret	x14
_inv_txfm_dct_clear_scale_8h_x64_neon:
mov	x14, x30
mov	x6, sp
lsl	x8, x8, #2
mov	w16, #23168
dup.4h	v0, w16
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
sub	x7, x7, x8, lsl #3
add	x7, x7, x8, lsr #1
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
bl	inv_dct_8h_x16_neon
st1.8h	{ v16 }, [x6], #16
st1.8h	{ v17 }, [x6], #16
st1.8h	{ v18 }, [x6], #16
st1.8h	{ v19 }, [x6], #16
st1.8h	{ v20 }, [x6], #16
st1.8h	{ v21 }, [x6], #16
st1.8h	{ v22 }, [x6], #16
st1.8h	{ v23 }, [x6], #16
st1.8h	{ v24 }, [x6], #16
st1.8h	{ v25 }, [x6], #16
st1.8h	{ v26 }, [x6], #16
st1.8h	{ v27 }, [x6], #16
st1.8h	{ v28 }, [x6], #16
st1.8h	{ v29 }, [x6], #16
st1.8h	{ v30 }, [x6], #16
st1.8h	{ v31 }, [x6], #16
mov	w16, #23168
dup.4h	v0, w16
movi.8h	v7, #0
ld1.8h	{ v16 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v17 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v18 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v20 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v21 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v22 }, [x7]
st1.8h	{ v7 }, [x7], x8
ld1.8h	{ v23 }, [x7]
st1.8h	{ v7 }, [x7], x8
movi.8h	v24, #0
movi.8h	v25, #0
movi.8h	v26, #0
movi.8h	v27, #0
movi.8h	v28, #0
movi.8h	v29, #0
movi.8h	v30, #0
movi.8h	v31, #0
sub	x7, x7, x8, lsl #3
lsr	x8, x8, #1
sub	x7, x7, x8, lsr #1
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
sqrdmulh.8h	v20, v20, v0[0]
sqrdmulh.8h	v21, v21, v0[0]
sqrdmulh.8h	v22, v22, v0[0]
sqrdmulh.8h	v23, v23, v0[0]
bl	inv_dct32_odd_8h_x16_neon
add	x10, x6, #240
sub	x6, x6, #256
mov	x9, #-16
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v31
sqsub.8h	v31, v2, v31
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v30
sqsub.8h	v30, v3, v30
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v29
sub	x6, x6, #64
sqsub.8h	v29, v4, v29
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v31 }, [x10], x9
sqadd.8h	v3, v5, v28
sqsub.8h	v28, v5, v28
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v30 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v29 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v28 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v27
sqsub.8h	v27, v2, v27
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v26
sqsub.8h	v26, v3, v26
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v25
sub	x6, x6, #64
sqsub.8h	v25, v4, v25
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v27 }, [x10], x9
sqadd.8h	v3, v5, v24
sqsub.8h	v24, v5, v24
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v26 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v25 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v24 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v23
sqsub.8h	v23, v2, v23
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v22
sqsub.8h	v22, v3, v22
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v21
sub	x6, x6, #64
sqsub.8h	v21, v4, v21
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v23 }, [x10], x9
sqadd.8h	v3, v5, v20
sqsub.8h	v20, v5, v20
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v22 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v21 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v20 }, [x10], x9
ld1.8h	{ v2 }, [x6], #16
ld1.8h	{ v3 }, [x6], #16
sqadd.8h	v6, v2, v19
sqsub.8h	v19, v2, v19
ld1.8h	{ v4 }, [x6], #16
sqadd.8h	v7, v3, v18
sqsub.8h	v18, v3, v18
ld1.8h	{ v5 }, [x6], #16
sqadd.8h	v2, v4, v17
sub	x6, x6, #64
sqsub.8h	v17, v4, v17
st1.8h	{ v6 }, [x6], #16
st1.8h	{ v19 }, [x10], x9
sqadd.8h	v3, v5, v16
sqsub.8h	v16, v5, v16
st1.8h	{ v7 }, [x6], #16
st1.8h	{ v18 }, [x10], x9
st1.8h	{ v2 }, [x6], #16
st1.8h	{ v17 }, [x10], x9
st1.8h	{ v3 }, [x6], #16
st1.8h	{ v16 }, [x10], x9
add	x6, x6, #256
adrp	x17, inv_txfm_dct_clear_scale_8h_x64_neon
add	x17, x17, #0
mov	w16, #23168
dup.4h	v0, w16
movi.8h	v7, #0
add	x9, x7, x8, lsl #4
add	x10, x7, x8, lsl #3
sub	x9, x9, x8
sub	x11, x10, x8
ld1.8h	{ v16 }, [x7]
ld1.8h	{ v17 }, [x9]
ld1.8h	{ v18 }, [x10]
ld1.8h	{ v19 }, [x11]
st1.8h	{ v7 }, [x7]
st1.8h	{ v7 }, [x9]
st1.8h	{ v7 }, [x10]
st1.8h	{ v7 }, [x11]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
bl	inv_dct64_step1_neon
mov	w16, #23168
dup.4h	v0, w16
movi.8h	v7, #0
add	x7, x7, x8, lsl #2
sub	x9, x9, x8, lsl #2
sub	x10, x7, x8
add	x11, x9, x8
ld1.8h	{ v16 }, [x10]
ld1.8h	{ v17 }, [x11]
ld1.8h	{ v18 }, [x9]
ld1.8h	{ v19 }, [x7]
st1.8h	{ v7 }, [x7]
st1.8h	{ v7 }, [x9]
st1.8h	{ v7 }, [x10]
st1.8h	{ v7 }, [x11]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
bl	inv_dct64_step1_neon
mov	w16, #23168
dup.4h	v0, w16
movi.8h	v7, #0
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
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
bl	inv_dct64_step1_neon
mov	w16, #23168
dup.4h	v0, w16
movi.8h	v7, #0
ldr	q16, [x10]
ldr	q17, [x11, x8]
ldr	q18, [x9]
ldr	q19, [x7, x8]
str	q7, [x10]
str	q7, [x11, x8]
str	q7, [x9]
str	q7, [x7, x8]
sqrdmulh.8h	v16, v16, v0[0]
sqrdmulh.8h	v17, v17, v0[0]
sqrdmulh.8h	v18, v18, v0[0]
sqrdmulh.8h	v19, v19, v0[0]
bl	inv_dct64_step1_neon
sub	x6, x6, #512
add	x9, x6, #112
bl	inv_dct64_step2_neon
ret	x14
_inv_txfm_horz_dct_64x8_neon:
mov	x14, x30
mov	x7, sp
add	x8, sp, #960
add	x9, x6, #112
mov	x10, #128
mov	x11, #-64
dup.8h	v7, w12
ld1.8h	{ v16, v17, v18, v19 }, [x7], #64
ld1.8h	{ v28, v29, v30, v31 }, [x8], x11
ld1.8h	{ v20, v21, v22, v23 }, [x7], #64
ld1.8h	{ v24, v25, v26, v27 }, [x8], x11
trn1.8h	v4, v16, v17
trn2.8h	v5, v16, v17
trn1.8h	v17, v18, v19
trn2.8h	v19, v18, v19
trn1.8h	v16, v20, v21
trn2.8h	v21, v20, v21
trn1.8h	v18, v22, v23
trn2.8h	v23, v22, v23
trn1.4s	v20, v16, v18
trn2.4s	v18, v16, v18
trn1.4s	v22, v21, v23
trn2.4s	v23, v21, v23
trn1.4s	v21, v5, v19
trn2.4s	v5, v5, v19
trn1.4s	v19, v4, v17
trn2.4s	v4, v4, v17
trn1.2d	v16, v19, v20
trn2.2d	v20, v19, v20
trn1.2d	v17, v21, v22
trn2.2d	v21, v21, v22
trn2.2d	v22, v4, v18
trn1.2d	v18, v4, v18
trn1.2d	v19, v5, v23
trn2.2d	v23, v5, v23
trn1.8h	v4, v31, v30
trn2.8h	v5, v31, v30
trn1.8h	v30, v29, v28
trn2.8h	v28, v29, v28
trn1.8h	v31, v27, v26
trn2.8h	v26, v27, v26
trn1.8h	v29, v25, v24
trn2.8h	v24, v25, v24
trn1.4s	v27, v31, v29
trn2.4s	v29, v31, v29
trn1.4s	v25, v26, v24
trn2.4s	v24, v26, v24
trn1.4s	v26, v5, v28
trn2.4s	v5, v5, v28
trn1.4s	v28, v4, v30
trn2.4s	v4, v4, v30
trn1.2d	v31, v28, v27
trn2.2d	v27, v28, v27
trn1.2d	v30, v26, v25
trn2.2d	v26, v26, v25
trn2.2d	v25, v4, v29
trn1.2d	v29, v4, v29
trn1.2d	v28, v5, v24
trn2.2d	v24, v5, v24
sqsub.8h	v1, v16, v31
sqadd.8h	v0, v16, v31
sqsub.8h	v3, v17, v30
srshl.8h	v1, v1, v7
sqadd.8h	v2, v17, v30
srshl.8h	v0, v0, v7
srshl.8h	v3, v3, v7
rev64.8h	v1, v1
srshl.8h	v2, v2, v7
rev64.8h	v3, v3
ext.16b	v1, v1, v1, #8
st1.8h	{ v0 }, [x6], x10
ext.16b	v3, v3, v3, #8
st1.8h	{ v1 }, [x9], x10
st1.8h	{ v2 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sqsub.8h	v1, v18, v29
sqadd.8h	v0, v18, v29
sqsub.8h	v3, v19, v28
srshl.8h	v1, v1, v7
sqadd.8h	v2, v19, v28
srshl.8h	v0, v0, v7
srshl.8h	v3, v3, v7
rev64.8h	v1, v1
srshl.8h	v2, v2, v7
rev64.8h	v3, v3
ext.16b	v1, v1, v1, #8
st1.8h	{ v0 }, [x6], x10
ext.16b	v3, v3, v3, #8
st1.8h	{ v1 }, [x9], x10
st1.8h	{ v2 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sqsub.8h	v1, v20, v27
sqadd.8h	v0, v20, v27
sqsub.8h	v3, v21, v26
srshl.8h	v1, v1, v7
sqadd.8h	v2, v21, v26
srshl.8h	v0, v0, v7
srshl.8h	v3, v3, v7
rev64.8h	v1, v1
srshl.8h	v2, v2, v7
rev64.8h	v3, v3
ext.16b	v1, v1, v1, #8
st1.8h	{ v0 }, [x6], x10
ext.16b	v3, v3, v3, #8
st1.8h	{ v1 }, [x9], x10
st1.8h	{ v2 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sqsub.8h	v1, v22, v25
sqadd.8h	v0, v22, v25
sqsub.8h	v3, v23, v24
srshl.8h	v1, v1, v7
sqadd.8h	v2, v23, v24
srshl.8h	v0, v0, v7
srshl.8h	v3, v3, v7
rev64.8h	v1, v1
srshl.8h	v2, v2, v7
rev64.8h	v3, v3
ext.16b	v1, v1, v1, #8
st1.8h	{ v0 }, [x6], x10
ext.16b	v3, v3, v3, #8
st1.8h	{ v1 }, [x9], x10
st1.8h	{ v2 }, [x6], x10
st1.8h	{ v3 }, [x9], x10
sub	x6, x6, x10, lsl #3
sub	x9, x9, x10, lsl #3
add	x6, x6, #16
sub	x9, x9, #16
cmp	x7, x8
b.lt	inv_txfm_horz_dct_64x8_neon
ret	x14
_inv_txfm_add_vert_dct_8x64_neon:
mov	x14, x30
lsl	x8, x8, #1
mov	x7, sp
add	x8, sp, #960
add	x9, x6, x1, lsl #6
sub	x9, x9, x1
neg	x10, x1
mov	x11, #-64
ld1.8h	{ v16, v17, v18, v19 }, [x7], #64
ld1.8h	{ v28, v29, v30, v31 }, [x8], x11
ld1.8h	{ v20, v21, v22, v23 }, [x7], #64
ld1.8h	{ v24, v25, v26, v27 }, [x8], x11
ld1.8b	{ v0 }, [x6], x1
ld1.8b	{ v1 }, [x9], x10
sqadd.8h	v4, v16, v31
ld1.8b	{ v2 }, [x6]
sqsub.8h	v5, v16, v31
ld1.8b	{ v3 }, [x9]
sqadd.8h	v6, v17, v30
sqsub.8h	v7, v17, v30
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v6, v6, #4
uaddw.8h	v4, v4, v0
srshr.8h	v7, v7, #4
uaddw.8h	v5, v5, v1
uaddw.8h	v6, v6, v2
sqxtun.8b	v0, v4
uaddw.8h	v7, v7, v3
sqxtun.8b	v1, v5
st1.8b	{ v0 }, [x6], x1
sqxtun.8b	v2, v6
st1.8b	{ v1 }, [x9], x10
sqxtun.8b	v3, v7
st1.8b	{ v2 }, [x6], x1
st1.8b	{ v3 }, [x9], x10
ld1.8b	{ v0 }, [x6], x1
ld1.8b	{ v1 }, [x9], x10
sqadd.8h	v4, v18, v29
ld1.8b	{ v2 }, [x6]
sqsub.8h	v5, v18, v29
ld1.8b	{ v3 }, [x9]
sqadd.8h	v6, v19, v28
sqsub.8h	v7, v19, v28
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v6, v6, #4
uaddw.8h	v4, v4, v0
srshr.8h	v7, v7, #4
uaddw.8h	v5, v5, v1
uaddw.8h	v6, v6, v2
sqxtun.8b	v0, v4
uaddw.8h	v7, v7, v3
sqxtun.8b	v1, v5
st1.8b	{ v0 }, [x6], x1
sqxtun.8b	v2, v6
st1.8b	{ v1 }, [x9], x10
sqxtun.8b	v3, v7
st1.8b	{ v2 }, [x6], x1
st1.8b	{ v3 }, [x9], x10
ld1.8b	{ v0 }, [x6], x1
ld1.8b	{ v1 }, [x9], x10
sqadd.8h	v4, v20, v27
ld1.8b	{ v2 }, [x6]
sqsub.8h	v5, v20, v27
ld1.8b	{ v3 }, [x9]
sqadd.8h	v6, v21, v26
sqsub.8h	v7, v21, v26
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v6, v6, #4
uaddw.8h	v4, v4, v0
srshr.8h	v7, v7, #4
uaddw.8h	v5, v5, v1
uaddw.8h	v6, v6, v2
sqxtun.8b	v0, v4
uaddw.8h	v7, v7, v3
sqxtun.8b	v1, v5
st1.8b	{ v0 }, [x6], x1
sqxtun.8b	v2, v6
st1.8b	{ v1 }, [x9], x10
sqxtun.8b	v3, v7
st1.8b	{ v2 }, [x6], x1
st1.8b	{ v3 }, [x9], x10
ld1.8b	{ v0 }, [x6], x1
ld1.8b	{ v1 }, [x9], x10
sqadd.8h	v4, v22, v25
ld1.8b	{ v2 }, [x6]
sqsub.8h	v5, v22, v25
ld1.8b	{ v3 }, [x9]
sqadd.8h	v6, v23, v24
sqsub.8h	v7, v23, v24
sub	x6, x6, x1
sub	x9, x9, x10
srshr.8h	v4, v4, #4
srshr.8h	v5, v5, #4
srshr.8h	v6, v6, #4
uaddw.8h	v4, v4, v0
srshr.8h	v7, v7, #4
uaddw.8h	v5, v5, v1
uaddw.8h	v6, v6, v2
sqxtun.8b	v0, v4
uaddw.8h	v7, v7, v3
sqxtun.8b	v1, v5
st1.8b	{ v0 }, [x6], x1
sqxtun.8b	v2, v6
st1.8b	{ v1 }, [x9], x10
sqxtun.8b	v3, v7
st1.8b	{ v2 }, [x6], x1
st1.8b	{ v3 }, [x9], x10
cmp	x7, x8
b.lt	inv_txfm_add_vert_dct_8x64_neon
ret	x14
_inv_txfm_add_dct_dct_64x64_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_64x64_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #64
b	idct_dc_w64_neon
mov	x15, x30
sub	sp, sp, #1, lsl #12     ; =4096
sub	sp, sp, #1024
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_64x64_8bpc_neon
add	x13, x13, #0
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #0
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x5, #1024
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_8bpc_neon
add	x7, x2, #16
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #1024
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x5, #2048
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_8bpc_neon
add	x7, x2, #32
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #2048
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x5, #3072
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x64_8bpc_neon
add	x7, x2, #48
mov	x8, #64
mov	x12, #-2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x5, #3072
bl	inv_txfm_horz_dct_64x8_neon
b	inv_txfm_add_dct_dct_64x64_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #2
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_64x64_8bpc_neon
add	x7, x5, #0
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #16
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #8
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #32
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #16
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #48
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #24
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #64
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #32
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #80
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #40
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #96
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #48
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #112
mov	x8, #128
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #56
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #1, lsl #12     ; =4096
ret	x15
_inv_txfm_add_dct_dct_64x32_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_64x32_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #32
b	idct_dc_w64_neon
mov	x15, x30
sub	sp, sp, #1, lsl #12     ; =4096
sub	sp, sp, #1024
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_64x32_8bpc_neon
add	x13, x13, #0
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #64
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #0
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x5, #1024
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_8bpc_neon
add	x7, x2, #16
mov	x8, #64
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #1024
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x5, #2048
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_8bpc_neon
add	x7, x2, #32
mov	x8, #64
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #2048
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x5, #3072
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x32_8bpc_neon
add	x7, x2, #48
mov	x8, #64
mov	x12, #-1
bl	inv_txfm_dct_clear_scale_8h_x64_neon
add	x6, x5, #3072
bl	inv_txfm_horz_dct_64x8_neon
b	inv_txfm_add_dct_dct_64x32_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #2
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_64x32_8bpc_neon
add	x6, x0, #0
add	x7, x5, #0
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #8
add	x7, x5, #16
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #16
add	x7, x5, #32
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #24
add	x7, x5, #48
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #32
add	x7, x5, #64
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #40
add	x7, x5, #80
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #48
add	x7, x5, #96
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	x6, x0, #56
add	x7, x5, #112
mov	x8, #128
bl	inv_txfm_add_vert_dct_8x32_neon
add	sp, x5, #1, lsl #12     ; =4096
ret	x15
_inv_txfm_add_dct_dct_32x64_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_32x64_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #1
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #64
b	idct_dc_w32_neon
mov	x15, x30
sub	sp, sp, #3072
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_32x64_8bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, x5, #512
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_8bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, x5, #1024
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_8bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x8_neon
add	x6, x5, #1536
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_32x64_8bpc_neon
add	x7, x2, #48
mov	x8, #64
bl	inv_txfm_horz_scale_dct_32x8_neon
b	inv_txfm_add_dct_dct_32x64_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #4
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_32x64_8bpc_neon
add	x7, x5, #0
mov	x8, #64
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #16
mov	x8, #64
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #8
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #32
mov	x8, #64
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #16
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #48
mov	x8, #64
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #24
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #2048
ret	x15
_inv_txfm_add_dct_dct_64x16_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_64x16_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #16
b	idct_dc_w64_neon
mov	x15, x30
sub	sp, sp, #3072
add	x4, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_64x16_8bpc_neon
add	x13, x13, #0
add	x6, x4, #0
add	x7, x2, #0
mov	x8, #32
mov	x12, #-2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x4, #0
bl	inv_txfm_horz_dct_64x8_neon
ldrh	w12, [x13], #2
add	x6, x4, #1024
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_64x16_8bpc_neon
add	x7, x2, #16
mov	x8, #32
mov	x12, #-2
bl	inv_txfm_dct_clear_8h_x64_neon
add	x6, x4, #1024
bl	inv_txfm_horz_dct_64x8_neon
b	inv_txfm_add_dct_dct_64x16_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #2
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_64x16_8bpc_neon
adr	x5, #-27112
mov	x8, #128
add	x6, x0, #0
add	x7, x4, #0
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #8
add	x7, x4, #16
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #16
add	x7, x4, #32
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #24
add	x7, x4, #48
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #32
add	x7, x4, #64
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #40
add	x7, x4, #80
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #48
add	x7, x4, #96
bl	inv_txfm_add_vert_8x16_neon
add	x6, x0, #56
add	x7, x4, #112
bl	inv_txfm_add_vert_8x16_neon
add	sp, x4, #2048
ret	x15
_inv_txfm_add_dct_dct_16x64_8bpc_neon:
cbnz	w3, inv_txfm_add_dct_dct_16x64_8bpc_neon
mov	w16, #23168
ld1r.8h	{ v16 }, [x2]
dup.4h	v0, w16
sqrdmulh.8h	v16, v16, v0[0]
strh	wzr, [x2]
srshr.8h	v16, v16, #2
sqrdmulh.8h	v16, v16, v0[0]
srshr.8h	v16, v16, #4
mov	w4, #64
b	idct_dc_w16_neon
mov	x15, x30
sub	sp, sp, #2048
add	x5, sp, #1024
adrp	x13, inv_txfm_add_dct_dct_16x64_8bpc_neon
add	x13, x13, #0
ldrh	w12, [x13], #2
adr	x4, #-27292
add	x6, x5, #0
add	x7, x2, #0
mov	x8, #64
bl	inv_txfm_horz_16x8_neon
add	x6, x5, #256
mov	w8, #24
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_8bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #16
mov	x8, #64
bl	inv_txfm_horz_16x8_neon
add	x6, x5, #512
mov	w8, #16
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_8bpc_neon
ldrh	w12, [x13], #2
add	x7, x2, #32
mov	x8, #64
bl	inv_txfm_horz_16x8_neon
add	x6, x5, #768
mov	w8, #8
cmp	w3, w12
b.lt	inv_txfm_add_dct_dct_16x64_8bpc_neon
add	x7, x2, #48
mov	x8, #64
bl	inv_txfm_horz_16x8_neon
b	inv_txfm_add_dct_dct_16x64_8bpc_neon
movi.8h	v4, #0
movi.8h	v5, #0
movi.8h	v6, #0
movi.8h	v7, #0
subs	w8, w8, #8
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
st1.8h	{ v4, v5, v6, v7 }, [x6], #64
b.gt	inv_txfm_add_dct_dct_16x64_8bpc_neon
add	x7, x5, #0
mov	x8, #32
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #0
bl	inv_txfm_add_vert_dct_8x64_neon
add	x7, x5, #16
mov	x8, #32
bl	inv_txfm_dct_8h_x64_neon
add	x6, x0, #8
bl	inv_txfm_add_vert_dct_8x64_neon
add	sp, x5, #1024
ret	x15
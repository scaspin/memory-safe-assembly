_ltmp0:
uabd.16b	v0, v22, v23
uabd.16b	v1, v25, v24
uabd.16b	v2, v23, v24
uabd.16b	v3, v22, v25
uabd.16b	v4, v21, v22
uabd.16b	v5, v26, v25
uabd.16b	v6, v20, v21
uabd.16b	v7, v27, v26
umax.16b	v4, v4, v5
uqadd.16b	v2, v2, v2
umax.16b	v6, v6, v7
ushr.16b	v3, v3, #1
umax.16b	v4, v4, v6
and.16b	v4, v4, v14
umax.16b	v0, v0, v1
uqadd.16b	v2, v2, v3
umax.16b	v4, v0, v4
cmhs.16b	v1, v11, v4
cmhs.16b	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
and.16b	v14, v14, v1
and.16b	v15, v15, v1
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	ltmp0
mov	x14, #1
ret
movi.16b	v10, #1
uabd.16b	v2, v21, v23
uabd.16b	v3, v22, v23
uabd.16b	v4, v25, v24
uabd.16b	v5, v26, v24
uabd.16b	v6, v20, v23
uabd.16b	v7, v27, v24
umax.16b	v2, v2, v3
umax.16b	v4, v4, v5
umax.16b	v6, v6, v7
umax.16b	v2, v2, v4
umax.16b	v2, v2, v6
uabd.16b	v3, v17, v23
uabd.16b	v4, v18, v23
uabd.16b	v5, v19, v23
cmhs.16b	v2, v10, v2
uabd.16b	v6, v28, v24
uabd.16b	v7, v29, v24
uabd.16b	v8, v30, v24
and.16b	v14, v2, v14
bic.16b	v1, v1, v14
umax.16b	v3, v3, v4
umax.16b	v5, v5, v6
mov.d	x16, v1[0]
mov.d	x17, v1[1]
umax.16b	v7, v7, v8
umax.16b	v3, v3, v5
umax.16b	v3, v3, v7
cmhs.16b	v3, v10, v3
adds	x16, x16, x17
and.16b	v15, v15, v3
and.16b	v15, v15, v14
bic.16b	v14, v14, v15
b.eq	ltmp0
movi.16b	v3, #128
eor.16b	v2, v22, v3
eor.16b	v3, v25, v3
cmhi.16b	v0, v0, v12
sqsub.16b	v2, v2, v3
and.16b	v4, v2, v0
bic.16b	v0, v1, v0
usubl.8h	v2, v24, v23
movi.8h	v5, #3
usubl2.8h	v3, v24, v23
mul.8h	v2, v2, v5
mul.8h	v3, v3, v5
movi.16b	v6, #4
saddw.8h	v2, v2, v4
saddw2.8h	v3, v3, v4
movi.16b	v7, #3
sqxtn.8b	v2, v2
sqxtn2.16b	v2, v3
sqadd.16b	v4, v6, v2
sqadd.16b	v5, v7, v2
sshr.16b	v4, v4, #3
sshr.16b	v5, v5, #3
mov.16b	v2, v23
mov.16b	v3, v24
neg.16b	v6, v4
srshr.16b	v4, v4, #1
usqadd.16b	v2, v5
usqadd.16b	v3, v6
neg.16b	v6, v4
bit.16b	v23, v2, v1
bit.16b	v24, v3, v1
mov.16b	v2, v22
mov.16b	v3, v25
usqadd.16b	v2, v4
usqadd.16b	v3, v6
bit.16b	v22, v2, v0
bit.16b	v25, v3, v0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	ltmp0
uaddl.8h	v0, v20, v21
uaddl2.8h	v1, v20, v21
uaddl.8h	v2, v22, v25
uaddl2.8h	v3, v22, v25
uaddl.8h	v4, v20, v22
uaddl2.8h	v5, v20, v22
uaddl.8h	v6, v23, v26
uaddl2.8h	v7, v23, v26
add.8h	v8, v0, v0
add.8h	v9, v1, v1
uaddw.8h	v8, v8, v23
uaddw2.8h	v9, v9, v23
uaddw.8h	v8, v8, v24
uaddw2.8h	v9, v9, v24
add.8h	v8, v8, v4
add.8h	v9, v9, v5
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
rshrn.8b	v10, v8, #3
rshrn2.16b	v10, v9, #3
add.8h	v8, v8, v2
add.8h	v9, v9, v3
uaddl.8h	v0, v20, v23
uaddl2.8h	v1, v20, v23
uaddl.8h	v2, v24, v27
uaddl2.8h	v3, v24, v27
rshrn.8b	v11, v8, #3
rshrn2.16b	v11, v9, #3
add.8h	v8, v8, v6
add.8h	v9, v9, v7
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
uaddl.8h	v4, v21, v24
uaddl2.8h	v5, v21, v24
uaddl.8h	v6, v25, v27
uaddl2.8h	v7, v25, v27
rshrn.8b	v12, v8, #3
rshrn2.16b	v12, v9, #3
add.8h	v8, v8, v2
add.8h	v9, v9, v3
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
uaddl.8h	v0, v22, v25
uaddl2.8h	v1, v22, v25
uaddl.8h	v2, v26, v27
uaddl2.8h	v3, v26, v27
rshrn.8b	v13, v8, #3
rshrn2.16b	v13, v9, #3
add.8h	v8, v8, v6
add.8h	v9, v9, v7
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
rshrn.8b	v0, v8, #3
rshrn2.16b	v0, v9, #3
add.8h	v8, v8, v2
add.8h	v9, v9, v3
bit.16b	v21, v10, v14
bit.16b	v22, v11, v14
bit.16b	v23, v12, v14
rshrn.8b	v1, v8, #3
rshrn2.16b	v1, v9, #3
bit.16b	v24, v13, v14
bit.16b	v25, v0, v14
bit.16b	v26, v1, v14
mov.d	x16, v15[0]
mov.d	x17, v15[1]
adds	x16, x16, x17
b.ne	ltmp0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	ltmp0
b	ltmp0
uaddl.8h	v2, v17, v17
uaddl2.8h	v3, v17, v17
uaddl.8h	v4, v17, v18
uaddl2.8h	v5, v17, v18
uaddl.8h	v6, v17, v19
uaddl2.8h	v7, v17, v19
uaddl.8h	v8, v17, v20
uaddl2.8h	v9, v17, v20
add.8h	v12, v2, v4
add.8h	v13, v3, v5
add.8h	v10, v6, v8
add.8h	v11, v7, v9
uaddl.8h	v6, v17, v21
uaddl2.8h	v7, v17, v21
add.8h	v12, v12, v10
add.8h	v13, v13, v11
uaddl.8h	v8, v17, v22
uaddl2.8h	v9, v17, v22
uaddl.8h	v10, v18, v23
uaddl2.8h	v11, v18, v23
add.8h	v6, v6, v8
add.8h	v7, v7, v9
uaddl.8h	v8, v19, v24
uaddl2.8h	v9, v19, v24
add.8h	v12, v12, v6
add.8h	v13, v13, v7
add.8h	v10, v10, v8
add.8h	v11, v11, v9
uaddl.8h	v6, v20, v25
uaddl2.8h	v7, v20, v25
add.8h	v12, v12, v10
add.8h	v13, v13, v11
sub.8h	v6, v6, v2
sub.8h	v7, v7, v3
uaddl.8h	v2, v21, v26
uaddl2.8h	v3, v21, v26
rshrn.8b	v0, v12, #4
rshrn2.16b	v0, v13, #4
add.8h	v12, v12, v6
add.8h	v13, v13, v7
sub.8h	v2, v2, v4
sub.8h	v3, v3, v5
uaddl.8h	v4, v22, v27
uaddl2.8h	v5, v22, v27
uaddl.8h	v6, v17, v19
uaddl2.8h	v7, v17, v19
rshrn.8b	v1, v12, #4
rshrn2.16b	v1, v13, #4
add.8h	v12, v12, v2
add.8h	v13, v13, v3
sub.8h	v4, v4, v6
sub.8h	v5, v5, v7
uaddl.8h	v6, v23, v28
uaddl2.8h	v7, v23, v28
uaddl.8h	v8, v17, v20
uaddl2.8h	v9, v17, v20
rshrn.8b	v2, v12, #4
rshrn2.16b	v2, v13, #4
add.8h	v12, v12, v4
add.8h	v13, v13, v5
sub.8h	v6, v6, v8
sub.8h	v7, v7, v9
uaddl.8h	v8, v24, v29
uaddl2.8h	v9, v24, v29
uaddl.8h	v4, v17, v21
uaddl2.8h	v5, v17, v21
rshrn.8b	v3, v12, #4
rshrn2.16b	v3, v13, #4
add.8h	v12, v12, v6
add.8h	v13, v13, v7
sub.8h	v8, v8, v4
sub.8h	v9, v9, v5
uaddl.8h	v6, v25, v30
uaddl2.8h	v7, v25, v30
uaddl.8h	v10, v17, v22
uaddl2.8h	v11, v17, v22
rshrn.8b	v4, v12, #4
rshrn2.16b	v4, v13, #4
add.8h	v12, v12, v8
add.8h	v13, v13, v9
sub.8h	v6, v6, v10
sub.8h	v7, v7, v11
uaddl.8h	v8, v26, v30
uaddl2.8h	v9, v26, v30
bif.16b	v0, v18, v15
uaddl.8h	v10, v18, v23
uaddl2.8h	v11, v18, v23
rshrn.8b	v5, v12, #4
rshrn2.16b	v5, v13, #4
add.8h	v12, v12, v6
add.8h	v13, v13, v7
sub.8h	v8, v8, v10
sub.8h	v9, v9, v11
uaddl.8h	v10, v27, v30
uaddl2.8h	v11, v27, v30
bif.16b	v1, v19, v15
uaddl.8h	v18, v19, v24
uaddl2.8h	v19, v19, v24
rshrn.8b	v6, v12, #4
rshrn2.16b	v6, v13, #4
add.8h	v12, v12, v8
add.8h	v13, v13, v9
sub.8h	v10, v10, v18
sub.8h	v11, v11, v19
uaddl.8h	v8, v28, v30
uaddl2.8h	v9, v28, v30
bif.16b	v2, v20, v15
uaddl.8h	v18, v20, v25
uaddl2.8h	v19, v20, v25
rshrn.8b	v7, v12, #4
rshrn2.16b	v7, v13, #4
add.8h	v12, v12, v10
add.8h	v13, v13, v11
sub.8h	v18, v8, v18
sub.8h	v19, v9, v19
uaddl.8h	v10, v29, v30
uaddl2.8h	v11, v29, v30
bif.16b	v3, v21, v15
uaddl.8h	v20, v21, v26
uaddl2.8h	v21, v21, v26
rshrn.8b	v8, v12, #4
rshrn2.16b	v8, v13, #4
add.8h	v12, v12, v18
add.8h	v13, v13, v19
sub.8h	v10, v10, v20
sub.8h	v11, v11, v21
uaddl.8h	v18, v30, v30
uaddl2.8h	v19, v30, v30
bif.16b	v4, v22, v15
uaddl.8h	v20, v22, v27
uaddl2.8h	v21, v22, v27
rshrn.8b	v9, v12, #4
rshrn2.16b	v9, v13, #4
add.8h	v12, v12, v10
add.8h	v13, v13, v11
sub.8h	v18, v18, v20
sub.8h	v19, v19, v21
bif.16b	v5, v23, v15
rshrn.8b	v10, v12, #4
rshrn2.16b	v10, v13, #4
add.8h	v12, v12, v18
add.8h	v13, v13, v19
rshrn.8b	v11, v12, #4
rshrn2.16b	v11, v13, #4
bif.16b	v6, v24, v15
bif.16b	v7, v25, v15
bif.16b	v8, v26, v15
bif.16b	v9, v27, v15
bif.16b	v10, v28, v15
bif.16b	v11, v29, v15
mov	x14, #0
ret
mov	x14, #64
ret
mov	x14, #16
ret
_lpf_16_wd8_neon:
uabd.16b	v0, v22, v23
uabd.16b	v1, v25, v24
uabd.16b	v2, v23, v24
uabd.16b	v3, v22, v25
uabd.16b	v4, v21, v22
uabd.16b	v5, v26, v25
uabd.16b	v6, v20, v21
uabd.16b	v7, v27, v26
umax.16b	v4, v4, v5
uqadd.16b	v2, v2, v2
umax.16b	v6, v6, v7
ushr.16b	v3, v3, #1
umax.16b	v4, v4, v6
and.16b	v4, v4, v14
umax.16b	v0, v0, v1
uqadd.16b	v2, v2, v3
umax.16b	v4, v0, v4
cmhs.16b	v1, v11, v4
cmhs.16b	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
and.16b	v14, v14, v1
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	lpf_16_wd8_neon
mov	x14, #1
ret
movi.16b	v10, #1
uabd.16b	v2, v21, v23
uabd.16b	v3, v22, v23
uabd.16b	v4, v25, v24
uabd.16b	v5, v26, v24
uabd.16b	v6, v20, v23
uabd.16b	v7, v27, v24
umax.16b	v2, v2, v3
umax.16b	v4, v4, v5
umax.16b	v6, v6, v7
umax.16b	v2, v2, v4
umax.16b	v2, v2, v6
cmhs.16b	v2, v10, v2
and.16b	v14, v2, v14
bic.16b	v1, v1, v14
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.eq	lpf_16_wd8_neon
movi.16b	v3, #128
eor.16b	v2, v22, v3
eor.16b	v3, v25, v3
cmhi.16b	v0, v0, v12
sqsub.16b	v2, v2, v3
and.16b	v4, v2, v0
bic.16b	v0, v1, v0
usubl.8h	v2, v24, v23
movi.8h	v5, #3
usubl2.8h	v3, v24, v23
mul.8h	v2, v2, v5
mul.8h	v3, v3, v5
movi.16b	v6, #4
saddw.8h	v2, v2, v4
saddw2.8h	v3, v3, v4
movi.16b	v7, #3
sqxtn.8b	v2, v2
sqxtn2.16b	v2, v3
sqadd.16b	v4, v6, v2
sqadd.16b	v5, v7, v2
sshr.16b	v4, v4, #3
sshr.16b	v5, v5, #3
mov.16b	v2, v23
mov.16b	v3, v24
neg.16b	v6, v4
srshr.16b	v4, v4, #1
usqadd.16b	v2, v5
usqadd.16b	v3, v6
neg.16b	v6, v4
bit.16b	v23, v2, v1
bit.16b	v24, v3, v1
mov.16b	v2, v22
mov.16b	v3, v25
usqadd.16b	v2, v4
usqadd.16b	v3, v6
bit.16b	v22, v2, v0
bit.16b	v25, v3, v0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	lpf_16_wd8_neon
uaddl.8h	v0, v20, v21
uaddl2.8h	v1, v20, v21
uaddl.8h	v2, v22, v25
uaddl2.8h	v3, v22, v25
uaddl.8h	v4, v20, v22
uaddl2.8h	v5, v20, v22
uaddl.8h	v6, v23, v26
uaddl2.8h	v7, v23, v26
add.8h	v8, v0, v0
add.8h	v9, v1, v1
uaddw.8h	v8, v8, v23
uaddw2.8h	v9, v9, v23
uaddw.8h	v8, v8, v24
uaddw2.8h	v9, v9, v24
add.8h	v8, v8, v4
add.8h	v9, v9, v5
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
rshrn.8b	v10, v8, #3
rshrn2.16b	v10, v9, #3
add.8h	v8, v8, v2
add.8h	v9, v9, v3
uaddl.8h	v0, v20, v23
uaddl2.8h	v1, v20, v23
uaddl.8h	v2, v24, v27
uaddl2.8h	v3, v24, v27
rshrn.8b	v11, v8, #3
rshrn2.16b	v11, v9, #3
add.8h	v8, v8, v6
add.8h	v9, v9, v7
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
uaddl.8h	v4, v21, v24
uaddl2.8h	v5, v21, v24
uaddl.8h	v6, v25, v27
uaddl2.8h	v7, v25, v27
rshrn.8b	v12, v8, #3
rshrn2.16b	v12, v9, #3
add.8h	v8, v8, v2
add.8h	v9, v9, v3
sub.8h	v6, v6, v4
sub.8h	v7, v7, v5
uaddl.8h	v0, v22, v25
uaddl2.8h	v1, v22, v25
uaddl.8h	v2, v26, v27
uaddl2.8h	v3, v26, v27
rshrn.8b	v13, v8, #3
rshrn2.16b	v13, v9, #3
add.8h	v8, v8, v6
add.8h	v9, v9, v7
sub.8h	v2, v2, v0
sub.8h	v3, v3, v1
rshrn.8b	v0, v8, #3
rshrn2.16b	v0, v9, #3
add.8h	v8, v8, v2
add.8h	v9, v9, v3
bit.16b	v21, v10, v14
bit.16b	v22, v11, v14
bit.16b	v23, v12, v14
rshrn.8b	v1, v8, #3
rshrn2.16b	v1, v9, #3
bit.16b	v24, v13, v14
bit.16b	v25, v0, v14
bit.16b	v26, v1, v14
mov	x14, #0
ret
mov	x14, #16
ret
_lpf_16_wd6_neon:
uabd.16b	v0, v22, v23
uabd.16b	v1, v25, v24
uabd.16b	v2, v23, v24
uabd.16b	v3, v22, v25
uabd.16b	v4, v21, v22
uabd.16b	v5, v26, v25
umax.16b	v4, v4, v5
uqadd.16b	v2, v2, v2
ushr.16b	v3, v3, #1
and.16b	v4, v4, v14
umax.16b	v0, v0, v1
uqadd.16b	v2, v2, v3
umax.16b	v4, v0, v4
cmhs.16b	v1, v11, v4
cmhs.16b	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
and.16b	v14, v14, v1
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	lpf_16_wd6_neon
mov	x14, #1
ret
movi.16b	v10, #1
uabd.16b	v2, v21, v23
uabd.16b	v3, v22, v23
uabd.16b	v4, v25, v24
uabd.16b	v5, v26, v24
umax.16b	v2, v2, v3
umax.16b	v4, v4, v5
umax.16b	v2, v2, v4
cmhs.16b	v2, v10, v2
and.16b	v14, v2, v14
bic.16b	v1, v1, v14
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.eq	lpf_16_wd6_neon
movi.16b	v3, #128
eor.16b	v2, v22, v3
eor.16b	v3, v25, v3
cmhi.16b	v0, v0, v12
sqsub.16b	v2, v2, v3
and.16b	v4, v2, v0
bic.16b	v0, v1, v0
usubl.8h	v2, v24, v23
movi.8h	v5, #3
usubl2.8h	v3, v24, v23
mul.8h	v2, v2, v5
mul.8h	v3, v3, v5
movi.16b	v6, #4
saddw.8h	v2, v2, v4
saddw2.8h	v3, v3, v4
movi.16b	v7, #3
sqxtn.8b	v2, v2
sqxtn2.16b	v2, v3
sqadd.16b	v4, v6, v2
sqadd.16b	v5, v7, v2
sshr.16b	v4, v4, #3
sshr.16b	v5, v5, #3
mov.16b	v2, v23
mov.16b	v3, v24
neg.16b	v6, v4
srshr.16b	v4, v4, #1
usqadd.16b	v2, v5
usqadd.16b	v3, v6
neg.16b	v6, v4
bit.16b	v23, v2, v1
bit.16b	v24, v3, v1
mov.16b	v2, v22
mov.16b	v3, v25
usqadd.16b	v2, v4
usqadd.16b	v3, v6
bit.16b	v22, v2, v0
bit.16b	v25, v3, v0
mov.d	x16, v14[0]
mov.d	x17, v14[1]
adds	x16, x16, x17
b.eq	lpf_16_wd6_neon
uaddl.8h	v0, v21, v21
uaddl2.8h	v1, v21, v21
uaddl.8h	v2, v21, v22
uaddl2.8h	v3, v21, v22
uaddl.8h	v4, v22, v23
uaddl2.8h	v5, v22, v23
uaddl.8h	v6, v23, v24
uaddl2.8h	v7, v23, v24
add.8h	v8, v0, v2
add.8h	v9, v1, v3
add.8h	v10, v4, v6
add.8h	v11, v5, v7
uaddl.8h	v12, v24, v25
uaddl2.8h	v13, v24, v25
add.8h	v8, v8, v10
add.8h	v9, v9, v11
sub.8h	v12, v12, v0
sub.8h	v13, v13, v1
uaddl.8h	v10, v25, v26
uaddl2.8h	v11, v25, v26
rshrn.8b	v0, v8, #3
rshrn2.16b	v0, v9, #3
add.8h	v8, v8, v12
add.8h	v9, v9, v13
sub.8h	v10, v10, v2
sub.8h	v11, v11, v3
uaddl.8h	v12, v26, v26
uaddl2.8h	v13, v26, v26
rshrn.8b	v1, v8, #3
rshrn2.16b	v1, v9, #3
add.8h	v8, v8, v10
add.8h	v9, v9, v11
sub.8h	v12, v12, v4
sub.8h	v13, v13, v5
rshrn.8b	v2, v8, #3
rshrn2.16b	v2, v9, #3
bit.16b	v22, v0, v14
add.8h	v8, v8, v12
add.8h	v9, v9, v13
bit.16b	v23, v1, v14
rshrn.8b	v3, v8, #3
rshrn2.16b	v3, v9, #3
bit.16b	v24, v2, v14
bit.16b	v25, v3, v14
mov	x14, #0
ret
_lpf_16_wd4_neon:
uabd.16b	v0, v22, v23
uabd.16b	v1, v25, v24
uabd.16b	v2, v23, v24
uabd.16b	v3, v22, v25
uqadd.16b	v2, v2, v2
ushr.16b	v3, v3, #1
umax.16b	v0, v0, v1
uqadd.16b	v2, v2, v3
cmhs.16b	v1, v11, v0
cmhs.16b	v2, v10, v2
and.16b	v1, v1, v2
and.16b	v1, v1, v13
mov.d	x16, v1[0]
mov.d	x17, v1[1]
adds	x16, x16, x17
b.ne	lpf_16_wd4_neon
mov	x14, #1
ret
movi.16b	v3, #128
eor.16b	v2, v22, v3
eor.16b	v3, v25, v3
cmhi.16b	v0, v0, v12
sqsub.16b	v2, v2, v3
and.16b	v4, v2, v0
bic.16b	v0, v1, v0
usubl.8h	v2, v24, v23
movi.8h	v5, #3
usubl2.8h	v3, v24, v23
mul.8h	v2, v2, v5
mul.8h	v3, v3, v5
movi.16b	v6, #4
saddw.8h	v2, v2, v4
saddw2.8h	v3, v3, v4
movi.16b	v7, #3
sqxtn.8b	v2, v2
sqxtn2.16b	v2, v3
sqadd.16b	v4, v6, v2
sqadd.16b	v5, v7, v2
sshr.16b	v4, v4, #3
sshr.16b	v5, v5, #3
mov.16b	v2, v23
mov.16b	v3, v24
neg.16b	v6, v4
srshr.16b	v4, v4, #1
usqadd.16b	v2, v5
usqadd.16b	v3, v6
neg.16b	v6, v4
bit.16b	v23, v2, v1
bit.16b	v24, v3, v1
mov.16b	v2, v22
mov.16b	v3, v25
usqadd.16b	v2, v4
usqadd.16b	v3, v6
bit.16b	v22, v2, v0
bit.16b	v25, v3, v0
mov	x14, #0
ret
_lpf_v_4_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
ld1.16b	{ v22 }, [x16], x1
ld1.16b	{ v24 }, [x0], x1
ld1.16b	{ v23 }, [x16], x1
ld1.16b	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
bl	lpf_16_wd4_neon
cbz	x14, lpf_v_4_16_neon
ret	x15
sub	x16, x0, x1, lsl #1
st1.16b	{ v22 }, [x16], x1
st1.16b	{ v24 }, [x0], x1
st1.16b	{ v23 }, [x16], x1
st1.16b	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_4_16_neon:
mov	x15, x30
sub	x16, x0, #2
add	x0, x16, x1, lsl #3
ld1.s	{ v22 }[0], [x16], x1
ld1.s	{ v22 }[2], [x0], x1
ld1.s	{ v23 }[0], [x16], x1
ld1.s	{ v23 }[2], [x0], x1
ld1.s	{ v24 }[0], [x16], x1
ld1.s	{ v24 }[2], [x0], x1
ld1.s	{ v25 }[0], [x16], x1
ld1.s	{ v25 }[2], [x0], x1
ld1.s	{ v22 }[1], [x16], x1
ld1.s	{ v22 }[3], [x0], x1
ld1.s	{ v23 }[1], [x16], x1
ld1.s	{ v23 }[3], [x0], x1
ld1.s	{ v24 }[1], [x16], x1
ld1.s	{ v24 }[3], [x0], x1
ld1.s	{ v25 }[1], [x16], x1
ld1.s	{ v25 }[3], [x0], x1
add	x0, x0, #2
trn1.16b	v26, v22, v23
trn2.16b	v27, v22, v23
trn1.16b	v28, v24, v25
trn2.16b	v29, v24, v25
trn1.8h	v22, v26, v28
trn2.8h	v24, v26, v28
trn1.8h	v23, v27, v29
trn2.8h	v25, v27, v29
bl	lpf_16_wd4_neon
cbz	x14, lpf_h_4_16_neon
ret	x15
sub	x16, x0, x1, lsl #4
sub	x16, x16, #2
trn1.16b	v26, v22, v23
trn2.16b	v27, v22, v23
trn1.16b	v28, v24, v25
trn2.16b	v29, v24, v25
trn1.8h	v22, v26, v28
trn2.8h	v24, v26, v28
trn1.8h	v23, v27, v29
trn2.8h	v25, v27, v29
add	x0, x16, x1, lsl #3
st1.s	{ v22 }[0], [x16], x1
st1.s	{ v22 }[2], [x0], x1
st1.s	{ v23 }[0], [x16], x1
st1.s	{ v23 }[2], [x0], x1
st1.s	{ v24 }[0], [x16], x1
st1.s	{ v24 }[2], [x0], x1
st1.s	{ v25 }[0], [x16], x1
st1.s	{ v25 }[2], [x0], x1
st1.s	{ v22 }[1], [x16], x1
st1.s	{ v22 }[3], [x0], x1
st1.s	{ v23 }[1], [x16], x1
st1.s	{ v23 }[3], [x0], x1
st1.s	{ v24 }[1], [x16], x1
st1.s	{ v24 }[3], [x0], x1
st1.s	{ v25 }[1], [x16], x1
st1.s	{ v25 }[3], [x0], x1
add	x0, x0, #2
ret	x15
_lpf_v_6_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
ld1.16b	{ v21 }, [x16], x1
ld1.16b	{ v24 }, [x0], x1
ld1.16b	{ v22 }, [x16], x1
ld1.16b	{ v25 }, [x0], x1
ld1.16b	{ v23 }, [x16], x1
ld1.16b	{ v26 }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
bl	lpf_16_wd6_neon
cbz	x14, lpf_v_6_16_neon
ret	x15
sub	x16, x0, x1, lsl #1
st1.16b	{ v22 }, [x16], x1
st1.16b	{ v24 }, [x0], x1
st1.16b	{ v23 }, [x16], x1
st1.16b	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_6_16_neon:
mov	x15, x30
sub	x16, x0, #4
add	x0, x16, x1, lsl #3
ld1.d	{ v20 }[0], [x16], x1
ld1.d	{ v20 }[1], [x0], x1
ld1.d	{ v21 }[0], [x16], x1
ld1.d	{ v21 }[1], [x0], x1
ld1.d	{ v22 }[0], [x16], x1
ld1.d	{ v22 }[1], [x0], x1
ld1.d	{ v23 }[0], [x16], x1
ld1.d	{ v23 }[1], [x0], x1
ld1.d	{ v24 }[0], [x16], x1
ld1.d	{ v24 }[1], [x0], x1
ld1.d	{ v25 }[0], [x16], x1
ld1.d	{ v25 }[1], [x0], x1
ld1.d	{ v26 }[0], [x16], x1
ld1.d	{ v26 }[1], [x0], x1
ld1.d	{ v27 }[0], [x16], x1
ld1.d	{ v27 }[1], [x0], x1
add	x0, x0, #4
trn1.16b	v28, v20, v21
trn2.16b	v29, v20, v21
trn1.16b	v21, v22, v23
trn2.16b	v23, v22, v23
trn1.16b	v20, v24, v25
trn2.16b	v25, v24, v25
trn1.16b	v22, v26, v27
trn2.16b	v27, v26, v27
trn1.8h	v24, v20, v22
trn2.8h	v22, v20, v22
trn1.8h	v26, v25, v27
trn2.8h	v27, v25, v27
trn1.8h	v25, v29, v23
trn2.8h	v29, v29, v23
trn1.8h	v23, v28, v21
trn2.8h	v28, v28, v21
trn1.4s	v20, v23, v24
trn2.4s	v24, v23, v24
trn1.4s	v21, v25, v26
trn2.4s	v25, v25, v26
trn2.4s	v26, v28, v22
trn1.4s	v22, v28, v22
trn1.4s	v23, v29, v27
trn2.4s	v27, v29, v27
bl	lpf_16_wd6_neon
cbz	x14, lpf_h_6_16_neon
ret	x15
sub	x16, x0, x1, lsl #4
sub	x16, x16, #2
trn1.16b	v26, v22, v23
trn2.16b	v27, v22, v23
trn1.16b	v28, v24, v25
trn2.16b	v29, v24, v25
trn1.8h	v22, v26, v28
trn2.8h	v24, v26, v28
trn1.8h	v23, v27, v29
trn2.8h	v25, v27, v29
add	x0, x16, x1, lsl #3
st1.s	{ v22 }[0], [x16], x1
st1.s	{ v22 }[2], [x0], x1
st1.s	{ v23 }[0], [x16], x1
st1.s	{ v23 }[2], [x0], x1
st1.s	{ v24 }[0], [x16], x1
st1.s	{ v24 }[2], [x0], x1
st1.s	{ v25 }[0], [x16], x1
st1.s	{ v25 }[2], [x0], x1
st1.s	{ v22 }[1], [x16], x1
st1.s	{ v22 }[3], [x0], x1
st1.s	{ v23 }[1], [x16], x1
st1.s	{ v23 }[3], [x0], x1
st1.s	{ v24 }[1], [x16], x1
st1.s	{ v24 }[3], [x0], x1
st1.s	{ v25 }[1], [x16], x1
st1.s	{ v25 }[3], [x0], x1
add	x0, x0, #2
ret	x15
_lpf_v_8_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #2
ld1.16b	{ v20 }, [x16], x1
ld1.16b	{ v24 }, [x0], x1
ld1.16b	{ v21 }, [x16], x1
ld1.16b	{ v25 }, [x0], x1
ld1.16b	{ v22 }, [x16], x1
ld1.16b	{ v26 }, [x0], x1
ld1.16b	{ v23 }, [x16], x1
ld1.16b	{ v27 }, [x0], x1
sub	x0, x0, x1, lsl #2
bl	lpf_16_wd8_neon
cbz	x14, lpf_v_8_16_neon
tbnz	w14, #4, lpf_v_8_16_neon
ret	x15
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
st1.16b	{ v21 }, [x16], x1
st1.16b	{ v24 }, [x0], x1
st1.16b	{ v22 }, [x16], x1
st1.16b	{ v25 }, [x0], x1
st1.16b	{ v23 }, [x16], x1
st1.16b	{ v26 }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
sub	x16, x0, x1, lsl #1
st1.16b	{ v22 }, [x16], x1
st1.16b	{ v24 }, [x0], x1
st1.16b	{ v23 }, [x16], x1
st1.16b	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_8_16_neon:
mov	x15, x30
sub	x16, x0, #4
add	x0, x16, x1, lsl #3
ld1.d	{ v20 }[0], [x16], x1
ld1.d	{ v20 }[1], [x0], x1
ld1.d	{ v21 }[0], [x16], x1
ld1.d	{ v21 }[1], [x0], x1
ld1.d	{ v22 }[0], [x16], x1
ld1.d	{ v22 }[1], [x0], x1
ld1.d	{ v23 }[0], [x16], x1
ld1.d	{ v23 }[1], [x0], x1
ld1.d	{ v24 }[0], [x16], x1
ld1.d	{ v24 }[1], [x0], x1
ld1.d	{ v25 }[0], [x16], x1
ld1.d	{ v25 }[1], [x0], x1
ld1.d	{ v26 }[0], [x16], x1
ld1.d	{ v26 }[1], [x0], x1
ld1.d	{ v27 }[0], [x16], x1
ld1.d	{ v27 }[1], [x0], x1
add	x0, x0, #4
trn1.16b	v28, v20, v21
trn2.16b	v29, v20, v21
trn1.16b	v21, v22, v23
trn2.16b	v23, v22, v23
trn1.16b	v20, v24, v25
trn2.16b	v25, v24, v25
trn1.16b	v22, v26, v27
trn2.16b	v27, v26, v27
trn1.8h	v24, v20, v22
trn2.8h	v22, v20, v22
trn1.8h	v26, v25, v27
trn2.8h	v27, v25, v27
trn1.8h	v25, v29, v23
trn2.8h	v29, v29, v23
trn1.8h	v23, v28, v21
trn2.8h	v28, v28, v21
trn1.4s	v20, v23, v24
trn2.4s	v24, v23, v24
trn1.4s	v21, v25, v26
trn2.4s	v25, v25, v26
trn2.4s	v26, v28, v22
trn1.4s	v22, v28, v22
trn1.4s	v23, v29, v27
trn2.4s	v27, v29, v27
bl	lpf_16_wd8_neon
cbz	x14, lpf_h_8_16_neon
tbnz	w14, #4, lpf_h_8_16_neon
ret	x15
sub	x16, x0, x1, lsl #4
sub	x16, x16, #4
trn1.16b	v28, v20, v21
trn2.16b	v29, v20, v21
trn1.16b	v21, v22, v23
trn2.16b	v23, v22, v23
trn1.16b	v20, v24, v25
trn2.16b	v25, v24, v25
trn1.16b	v22, v26, v27
trn2.16b	v27, v26, v27
trn1.8h	v24, v20, v22
trn2.8h	v22, v20, v22
trn1.8h	v26, v25, v27
trn2.8h	v27, v25, v27
trn1.8h	v25, v29, v23
trn2.8h	v29, v29, v23
trn1.8h	v23, v28, v21
trn2.8h	v28, v28, v21
trn1.4s	v20, v23, v24
trn2.4s	v24, v23, v24
trn1.4s	v21, v25, v26
trn2.4s	v25, v25, v26
trn2.4s	v26, v28, v22
trn1.4s	v22, v28, v22
trn1.4s	v23, v29, v27
trn2.4s	v27, v29, v27
add	x0, x16, x1, lsl #3
st1.d	{ v20 }[0], [x16], x1
st1.d	{ v20 }[1], [x0], x1
st1.d	{ v21 }[0], [x16], x1
st1.d	{ v21 }[1], [x0], x1
st1.d	{ v22 }[0], [x16], x1
st1.d	{ v22 }[1], [x0], x1
st1.d	{ v23 }[0], [x16], x1
st1.d	{ v23 }[1], [x0], x1
st1.d	{ v24 }[0], [x16], x1
st1.d	{ v24 }[1], [x0], x1
st1.d	{ v25 }[0], [x16], x1
st1.d	{ v25 }[1], [x0], x1
st1.d	{ v26 }[0], [x16], x1
st1.d	{ v26 }[1], [x0], x1
st1.d	{ v27 }[0], [x16], x1
st1.d	{ v27 }[1], [x0], x1
add	x0, x0, #4
ret	x15
sub	x16, x0, x1, lsl #4
sub	x16, x16, #2
trn1.16b	v26, v22, v23
trn2.16b	v27, v22, v23
trn1.16b	v28, v24, v25
trn2.16b	v29, v24, v25
trn1.8h	v22, v26, v28
trn2.8h	v24, v26, v28
trn1.8h	v23, v27, v29
trn2.8h	v25, v27, v29
add	x0, x16, x1, lsl #3
st1.s	{ v22 }[0], [x16], x1
st1.s	{ v22 }[2], [x0], x1
st1.s	{ v23 }[0], [x16], x1
st1.s	{ v23 }[2], [x0], x1
st1.s	{ v24 }[0], [x16], x1
st1.s	{ v24 }[2], [x0], x1
st1.s	{ v25 }[0], [x16], x1
st1.s	{ v25 }[2], [x0], x1
st1.s	{ v22 }[1], [x16], x1
st1.s	{ v22 }[3], [x0], x1
st1.s	{ v23 }[1], [x16], x1
st1.s	{ v23 }[3], [x0], x1
st1.s	{ v24 }[1], [x16], x1
st1.s	{ v24 }[3], [x0], x1
st1.s	{ v25 }[1], [x16], x1
st1.s	{ v25 }[3], [x0], x1
add	x0, x0, #2
ret	x15
_lpf_v_16_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #3
add	x16, x16, x1
ld1.16b	{ v17 }, [x16], x1
ld1.16b	{ v24 }, [x0], x1
ld1.16b	{ v18 }, [x16], x1
ld1.16b	{ v25 }, [x0], x1
ld1.16b	{ v19 }, [x16], x1
ld1.16b	{ v26 }, [x0], x1
ld1.16b	{ v20 }, [x16], x1
ld1.16b	{ v27 }, [x0], x1
ld1.16b	{ v21 }, [x16], x1
ld1.16b	{ v28 }, [x0], x1
ld1.16b	{ v22 }, [x16], x1
ld1.16b	{ v29 }, [x0], x1
ld1.16b	{ v23 }, [x16], x1
ld1.16b	{ v30 }, [x0], x1
sub	x0, x0, x1, lsl #3
add	x0, x0, x1
bl	ltmp0
cbz	x14, lpf_v_16_16_neon
tbnz	w14, #6, lpf_v_16_16_neon
tbnz	w14, #4, lpf_v_16_16_neon
ret	x15
sub	x16, x0, x1, lsl #2
sub	x16, x16, x1, lsl #1
st1.16b	{ v0 }, [x16], x1
st1.16b	{ v6 }, [x0], x1
st1.16b	{ v1 }, [x16], x1
st1.16b	{ v7 }, [x0], x1
st1.16b	{ v2 }, [x16], x1
st1.16b	{ v8 }, [x0], x1
st1.16b	{ v3 }, [x16], x1
st1.16b	{ v9 }, [x0], x1
st1.16b	{ v4 }, [x16], x1
st1.16b	{ v10 }, [x0], x1
st1.16b	{ v5 }, [x16], x1
st1.16b	{ v11 }, [x0], x1
sub	x0, x0, x1, lsl #2
sub	x0, x0, x1, lsl #1
ret	x15
sub	x16, x0, x1
sub	x16, x16, x1, lsl #1
st1.16b	{ v21 }, [x16], x1
st1.16b	{ v24 }, [x0], x1
st1.16b	{ v22 }, [x16], x1
st1.16b	{ v25 }, [x0], x1
st1.16b	{ v23 }, [x16], x1
st1.16b	{ v26 }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
sub	x16, x0, x1, lsl #1
st1.16b	{ v22 }, [x16], x1
st1.16b	{ v24 }, [x0], x1
st1.16b	{ v23 }, [x16], x1
st1.16b	{ v25 }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
_lpf_h_16_16_neon:
mov	x15, x30
sub	x16, x0, #8
ld1.d	{ v16 }[0], [x16], x1
ld1.d	{ v24 }[0], [x0], x1
ld1.d	{ v17 }[0], [x16], x1
ld1.d	{ v25 }[0], [x0], x1
ld1.d	{ v18 }[0], [x16], x1
ld1.d	{ v26 }[0], [x0], x1
ld1.d	{ v19 }[0], [x16], x1
ld1.d	{ v27 }[0], [x0], x1
ld1.d	{ v20 }[0], [x16], x1
ld1.d	{ v28 }[0], [x0], x1
ld1.d	{ v21 }[0], [x16], x1
ld1.d	{ v29 }[0], [x0], x1
ld1.d	{ v22 }[0], [x16], x1
ld1.d	{ v30 }[0], [x0], x1
ld1.d	{ v23 }[0], [x16], x1
ld1.d	{ v31 }[0], [x0], x1
ld1.d	{ v16 }[1], [x16], x1
ld1.d	{ v24 }[1], [x0], x1
ld1.d	{ v17 }[1], [x16], x1
ld1.d	{ v25 }[1], [x0], x1
ld1.d	{ v18 }[1], [x16], x1
ld1.d	{ v26 }[1], [x0], x1
ld1.d	{ v19 }[1], [x16], x1
ld1.d	{ v27 }[1], [x0], x1
ld1.d	{ v20 }[1], [x16], x1
ld1.d	{ v28 }[1], [x0], x1
ld1.d	{ v21 }[1], [x16], x1
ld1.d	{ v29 }[1], [x0], x1
ld1.d	{ v22 }[1], [x16], x1
ld1.d	{ v30 }[1], [x0], x1
ld1.d	{ v23 }[1], [x16], x1
ld1.d	{ v31 }[1], [x0], x1
trn1.16b	v0, v16, v17
trn2.16b	v1, v16, v17
trn1.16b	v17, v18, v19
trn2.16b	v19, v18, v19
trn1.16b	v16, v20, v21
trn2.16b	v21, v20, v21
trn1.16b	v18, v22, v23
trn2.16b	v23, v22, v23
trn1.8h	v20, v16, v18
trn2.8h	v18, v16, v18
trn1.8h	v22, v21, v23
trn2.8h	v23, v21, v23
trn1.8h	v21, v1, v19
trn2.8h	v1, v1, v19
trn1.8h	v19, v0, v17
trn2.8h	v0, v0, v17
trn1.4s	v16, v19, v20
trn2.4s	v20, v19, v20
trn1.4s	v17, v21, v22
trn2.4s	v21, v21, v22
trn2.4s	v22, v0, v18
trn1.4s	v18, v0, v18
trn1.4s	v19, v1, v23
trn2.4s	v23, v1, v23
trn1.16b	v0, v24, v25
trn2.16b	v1, v24, v25
trn1.16b	v25, v26, v27
trn2.16b	v27, v26, v27
trn1.16b	v24, v28, v29
trn2.16b	v29, v28, v29
trn1.16b	v26, v30, v31
trn2.16b	v31, v30, v31
trn1.8h	v28, v24, v26
trn2.8h	v26, v24, v26
trn1.8h	v30, v29, v31
trn2.8h	v31, v29, v31
trn1.8h	v29, v1, v27
trn2.8h	v1, v1, v27
trn1.8h	v27, v0, v25
trn2.8h	v0, v0, v25
trn1.4s	v24, v27, v28
trn2.4s	v28, v27, v28
trn1.4s	v25, v29, v30
trn2.4s	v29, v29, v30
trn2.4s	v30, v0, v26
trn1.4s	v26, v0, v26
trn1.4s	v27, v1, v31
trn2.4s	v31, v1, v31
bl	ltmp0
cbz	x14, lpf_h_16_16_neon
tbnz	w14, #6, lpf_h_16_16_neon
tbnz	w14, #4, lpf_h_16_16_neon
ret	x15
sub	x0, x0, x1, lsl #4
sub	x16, x0, #8
trn1.16b	v18, v16, v17
trn2.16b	v19, v16, v17
trn1.16b	v17, v0, v1
trn2.16b	v1, v0, v1
trn1.16b	v16, v2, v3
trn2.16b	v3, v2, v3
trn1.16b	v0, v4, v5
trn2.16b	v5, v4, v5
trn1.8h	v2, v16, v0
trn2.8h	v0, v16, v0
trn1.8h	v4, v3, v5
trn2.8h	v5, v3, v5
trn1.8h	v3, v19, v1
trn2.8h	v19, v19, v1
trn1.8h	v1, v18, v17
trn2.8h	v18, v18, v17
trn1.4s	v16, v1, v2
trn2.4s	v2, v1, v2
trn1.4s	v17, v3, v4
trn2.4s	v3, v3, v4
trn2.4s	v4, v18, v0
trn1.4s	v0, v18, v0
trn1.4s	v1, v19, v5
trn2.4s	v5, v19, v5
trn1.16b	v18, v6, v7
trn2.16b	v19, v6, v7
trn1.16b	v7, v8, v9
trn2.16b	v9, v8, v9
trn1.16b	v6, v10, v11
trn2.16b	v11, v10, v11
trn1.16b	v8, v30, v31
trn2.16b	v31, v30, v31
trn1.8h	v10, v6, v8
trn2.8h	v8, v6, v8
trn1.8h	v30, v11, v31
trn2.8h	v31, v11, v31
trn1.8h	v11, v19, v9
trn2.8h	v19, v19, v9
trn1.8h	v9, v18, v7
trn2.8h	v18, v18, v7
trn1.4s	v6, v9, v10
trn2.4s	v10, v9, v10
trn1.4s	v7, v11, v30
trn2.4s	v11, v11, v30
trn2.4s	v30, v18, v8
trn1.4s	v8, v18, v8
trn1.4s	v9, v19, v31
trn2.4s	v31, v19, v31
st1.d	{ v16 }[0], [x16], x1
st1.d	{ v6 }[0], [x0], x1
st1.d	{ v17 }[0], [x16], x1
st1.d	{ v7 }[0], [x0], x1
st1.d	{ v0 }[0], [x16], x1
st1.d	{ v8 }[0], [x0], x1
st1.d	{ v1 }[0], [x16], x1
st1.d	{ v9 }[0], [x0], x1
st1.d	{ v2 }[0], [x16], x1
st1.d	{ v10 }[0], [x0], x1
st1.d	{ v3 }[0], [x16], x1
st1.d	{ v11 }[0], [x0], x1
st1.d	{ v4 }[0], [x16], x1
st1.d	{ v30 }[0], [x0], x1
st1.d	{ v5 }[0], [x16], x1
st1.d	{ v31 }[0], [x0], x1
st1.d	{ v16 }[1], [x16], x1
st1.d	{ v6 }[1], [x0], x1
st1.d	{ v17 }[1], [x16], x1
st1.d	{ v7 }[1], [x0], x1
st1.d	{ v0 }[1], [x16], x1
st1.d	{ v8 }[1], [x0], x1
st1.d	{ v1 }[1], [x16], x1
st1.d	{ v9 }[1], [x0], x1
st1.d	{ v2 }[1], [x16], x1
st1.d	{ v10 }[1], [x0], x1
st1.d	{ v3 }[1], [x16], x1
st1.d	{ v11 }[1], [x0], x1
st1.d	{ v4 }[1], [x16], x1
st1.d	{ v30 }[1], [x0], x1
st1.d	{ v5 }[1], [x16], x1
st1.d	{ v31 }[1], [x0], x1
ret	x15
sub	x16, x0, x1, lsl #4
sub	x16, x16, #4
trn1.16b	v28, v20, v21
trn2.16b	v29, v20, v21
trn1.16b	v21, v22, v23
trn2.16b	v23, v22, v23
trn1.16b	v20, v24, v25
trn2.16b	v25, v24, v25
trn1.16b	v22, v26, v27
trn2.16b	v27, v26, v27
trn1.8h	v24, v20, v22
trn2.8h	v22, v20, v22
trn1.8h	v26, v25, v27
trn2.8h	v27, v25, v27
trn1.8h	v25, v29, v23
trn2.8h	v29, v29, v23
trn1.8h	v23, v28, v21
trn2.8h	v28, v28, v21
trn1.4s	v20, v23, v24
trn2.4s	v24, v23, v24
trn1.4s	v21, v25, v26
trn2.4s	v25, v25, v26
trn2.4s	v26, v28, v22
trn1.4s	v22, v28, v22
trn1.4s	v23, v29, v27
trn2.4s	v27, v29, v27
add	x0, x16, x1, lsl #3
st1.d	{ v20 }[0], [x16], x1
st1.d	{ v20 }[1], [x0], x1
st1.d	{ v21 }[0], [x16], x1
st1.d	{ v21 }[1], [x0], x1
st1.d	{ v22 }[0], [x16], x1
st1.d	{ v22 }[1], [x0], x1
st1.d	{ v23 }[0], [x16], x1
st1.d	{ v23 }[1], [x0], x1
st1.d	{ v24 }[0], [x16], x1
st1.d	{ v24 }[1], [x0], x1
st1.d	{ v25 }[0], [x16], x1
st1.d	{ v25 }[1], [x0], x1
st1.d	{ v26 }[0], [x16], x1
st1.d	{ v26 }[1], [x0], x1
st1.d	{ v27 }[0], [x16], x1
st1.d	{ v27 }[1], [x0], x1
add	x0, x0, #4
ret	x15
sub	x16, x0, x1, lsl #4
sub	x16, x16, #2
trn1.16b	v26, v22, v23
trn2.16b	v27, v22, v23
trn1.16b	v28, v24, v25
trn2.16b	v29, v24, v25
trn1.8h	v22, v26, v28
trn2.8h	v24, v26, v28
trn1.8h	v23, v27, v29
trn2.8h	v25, v27, v29
add	x0, x16, x1, lsl #3
st1.s	{ v22 }[0], [x16], x1
st1.s	{ v22 }[2], [x0], x1
st1.s	{ v23 }[0], [x16], x1
st1.s	{ v23 }[2], [x0], x1
st1.s	{ v24 }[0], [x16], x1
st1.s	{ v24 }[2], [x0], x1
st1.s	{ v25 }[0], [x16], x1
st1.s	{ v25 }[2], [x0], x1
st1.s	{ v22 }[1], [x16], x1
st1.s	{ v22 }[3], [x0], x1
st1.s	{ v23 }[1], [x16], x1
st1.s	{ v23 }[3], [x0], x1
st1.s	{ v24 }[1], [x16], x1
st1.s	{ v24 }[3], [x0], x1
st1.s	{ v25 }[1], [x16], x1
st1.s	{ v25 }[3], [x0], x1
add	x0, x0, #2
ret	x15
_lpf_v_sb_y_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
ldr	w2, [x2, #8]
add	x5, x5, #128
orr	w7, w7, w2
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
tst	w6, #0xf
ld1.16b	{ v0 }, [x4], #16
ld1.16b	{ v1 }, [x3], #16
b.eq	lpf_v_sb_y_8bpc_neon
ld1r.16b	{ v5 }, [x5]
add	x5, x5, #8
movi.4s	v2, #255
dup.4s	v13, w6
and.16b	v0, v0, v2
and.16b	v1, v1, v2
cmtst.16b	v3, v1, v2
movi.16b	v4, #1
ld1r.16b	{ v6 }, [x5]
sub	x5, x5, #8
bif.16b	v1, v0, v3
cmtst.4s	v2, v1, v2
mul.4s	v1, v1, v4
dup.4s	v15, w2
dup.4s	v14, w7
mov.d	x16, v2[0]
mov.d	x17, v2[1]
adds	x16, x16, x17
b.eq	lpf_v_sb_y_8bpc_neon
neg.16b	v5, v5
adrp	x16, lpf_v_sb_y_8bpc_neon
add	x16, x16, #0
ushr.16b	v12, v1, #4
ld1.4s	{ v16 }, [x16]
sshl.16b	v3, v1, v5
cmtst.4s	v15, v15, v16
movi.16b	v7, #2
umin.16b	v3, v3, v6
add.16b	v0, v1, v7
umax.16b	v11, v3, v4
add.16b	v0, v0, v0
cmtst.4s	v14, v14, v16
add.16b	v10, v0, v11
cmtst.4s	v13, v13, v16
and.16b	v13, v13, v2
tst	w2, #0xf
b.eq	lpf_v_sb_y_8bpc_neon
bl	lpf_v_16_16_neon
b	lpf_v_sb_y_8bpc_neon
tst	w7, #0xf
b.eq	lpf_v_sb_y_8bpc_neon
bl	lpf_v_8_16_neon
b	lpf_v_sb_y_8bpc_neon
bl	lpf_v_4_16_neon
lsr	w6, w6, #4
lsr	w7, w7, #4
lsr	w2, w2, #4
add	x0, x0, #16
cbnz	w6, lpf_v_sb_y_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
_lpf_h_sb_y_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
ldr	w2, [x2, #8]
add	x5, x5, #128
orr	w7, w7, w2
sub	x3, x3, #4
lsl	x4, x4, #2
orr	w6, w6, w7
tst	w6, #0xf
ld2.s	{ v0, v1 }[0], [x3], x4
ld2.s	{ v0, v1 }[1], [x3], x4
ld2.s	{ v0, v1 }[2], [x3], x4
ld2.s	{ v0, v1 }[3], [x3], x4
b.eq	lpf_h_sb_y_8bpc_neon
ld1r.16b	{ v5 }, [x5]
add	x5, x5, #8
movi.4s	v2, #255
dup.4s	v13, w6
and.16b	v0, v0, v2
and.16b	v1, v1, v2
cmtst.16b	v3, v1, v2
movi.16b	v4, #1
ld1r.16b	{ v6 }, [x5]
sub	x5, x5, #8
bif.16b	v1, v0, v3
cmtst.4s	v2, v1, v2
mul.4s	v1, v1, v4
dup.4s	v15, w2
dup.4s	v14, w7
mov.d	x16, v2[0]
mov.d	x17, v2[1]
adds	x16, x16, x17
b.eq	lpf_h_sb_y_8bpc_neon
neg.16b	v5, v5
adrp	x16, lpf_h_sb_y_8bpc_neon
add	x16, x16, #0
ushr.16b	v12, v1, #4
ld1.4s	{ v16 }, [x16]
sshl.16b	v3, v1, v5
cmtst.4s	v15, v15, v16
movi.16b	v7, #2
umin.16b	v3, v3, v6
add.16b	v0, v1, v7
umax.16b	v11, v3, v4
add.16b	v0, v0, v0
cmtst.4s	v14, v14, v16
add.16b	v10, v0, v11
cmtst.4s	v13, v13, v16
and.16b	v13, v13, v2
tst	w2, #0xf
b.eq	lpf_h_sb_y_8bpc_neon
bl	lpf_h_16_16_neon
b	lpf_h_sb_y_8bpc_neon
tst	w7, #0xf
b.eq	lpf_h_sb_y_8bpc_neon
bl	lpf_h_8_16_neon
b	lpf_h_sb_y_8bpc_neon
bl	lpf_h_4_16_neon
b	lpf_h_sb_y_8bpc_neon
add	x0, x0, x1, lsl #4
lsr	w6, w6, #4
lsr	w7, w7, #4
lsr	w2, w2, #4
cbnz	w6, lpf_h_sb_y_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
_lpf_v_sb_uv_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
add	x5, x5, #128
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
tst	w6, #0xf
ld1.16b	{ v0 }, [x4], #16
ld1.16b	{ v1 }, [x3], #16
b.eq	lpf_v_sb_uv_8bpc_neon
ld1r.16b	{ v5 }, [x5]
add	x5, x5, #8
movi.4s	v2, #255
dup.4s	v13, w6
and.16b	v0, v0, v2
and.16b	v1, v1, v2
cmtst.16b	v3, v1, v2
movi.16b	v4, #1
ld1r.16b	{ v6 }, [x5]
sub	x5, x5, #8
bif.16b	v1, v0, v3
cmtst.4s	v2, v1, v2
mul.4s	v1, v1, v4
dup.4s	v14, w7
mov.d	x16, v2[0]
mov.d	x17, v2[1]
adds	x16, x16, x17
b.eq	lpf_v_sb_uv_8bpc_neon
neg.16b	v5, v5
adrp	x16, lpf_v_sb_uv_8bpc_neon
add	x16, x16, #0
ushr.16b	v12, v1, #4
ld1.4s	{ v16 }, [x16]
sshl.16b	v3, v1, v5
movi.16b	v7, #2
umin.16b	v3, v3, v6
add.16b	v0, v1, v7
umax.16b	v11, v3, v4
add.16b	v0, v0, v0
cmtst.4s	v14, v14, v16
add.16b	v10, v0, v11
cmtst.4s	v13, v13, v16
and.16b	v13, v13, v2
tst	w7, #0xf
b.eq	lpf_v_sb_uv_8bpc_neon
bl	lpf_v_6_16_neon
b	lpf_v_sb_uv_8bpc_neon
bl	lpf_v_4_16_neon
lsr	w6, w6, #4
lsr	w7, w7, #4
add	x0, x0, #16
cbnz	w6, lpf_v_sb_uv_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
_lpf_h_sb_uv_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-64]!
stp	d10, d11, [sp, #16]
stp	d12, d13, [sp, #32]
stp	d14, d15, [sp, #48]
ldp	w6, w7, [x2]
add	x5, x5, #128
sub	x3, x3, #4
lsl	x4, x4, #2
orr	w6, w6, w7
tst	w6, #0xf
ld2.s	{ v0, v1 }[0], [x3], x4
ld2.s	{ v0, v1 }[1], [x3], x4
ld2.s	{ v0, v1 }[2], [x3], x4
ld2.s	{ v0, v1 }[3], [x3], x4
b.eq	lpf_h_sb_uv_8bpc_neon
ld1r.16b	{ v5 }, [x5]
add	x5, x5, #8
movi.4s	v2, #255
dup.4s	v13, w6
and.16b	v0, v0, v2
and.16b	v1, v1, v2
cmtst.16b	v3, v1, v2
movi.16b	v4, #1
ld1r.16b	{ v6 }, [x5]
sub	x5, x5, #8
bif.16b	v1, v0, v3
cmtst.4s	v2, v1, v2
mul.4s	v1, v1, v4
dup.4s	v14, w7
mov.d	x16, v2[0]
mov.d	x17, v2[1]
adds	x16, x16, x17
b.eq	lpf_h_sb_uv_8bpc_neon
neg.16b	v5, v5
adrp	x16, lpf_h_sb_uv_8bpc_neon
add	x16, x16, #0
ushr.16b	v12, v1, #4
ld1.4s	{ v16 }, [x16]
sshl.16b	v3, v1, v5
movi.16b	v7, #2
umin.16b	v3, v3, v6
add.16b	v0, v1, v7
umax.16b	v11, v3, v4
add.16b	v0, v0, v0
cmtst.4s	v14, v14, v16
add.16b	v10, v0, v11
cmtst.4s	v13, v13, v16
and.16b	v13, v13, v2
tst	w7, #0xf
b.eq	lpf_h_sb_uv_8bpc_neon
bl	lpf_h_6_16_neon
b	lpf_h_sb_uv_8bpc_neon
bl	lpf_h_4_16_neon
b	lpf_h_sb_uv_8bpc_neon
add	x0, x0, x1, lsl #4
lsr	w6, w6, #4
lsr	w7, w7, #4
cbnz	w6, lpf_h_sb_uv_8bpc_neon
ldp	d14, d15, [sp, #48]
ldp	d12, d13, [sp, #32]
ldp	d10, d11, [sp, #16]
ldp	d8, d9, [sp], #64
ret	x11
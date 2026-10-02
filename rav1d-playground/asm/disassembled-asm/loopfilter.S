	.text
lpf_16_wd16_neon:
uabd	v0.16b, v22.16b, v23.16b
uabd	v1.16b, v25.16b, v24.16b
uabd	v2.16b, v23.16b, v24.16b
uabd	v3.16b, v22.16b, v25.16b
uabd	v4.16b, v21.16b, v22.16b
uabd	v5.16b, v26.16b, v25.16b
uabd	v6.16b, v20.16b, v21.16b
uabd	v7.16b, v27.16b, v26.16b
umax	v4.16b, v4.16b, v5.16b
uqadd	v2.16b, v2.16b, v2.16b
umax	v6.16b, v6.16b, v7.16b
ushr	v3.16b, v3.16b, #0x1
umax	v4.16b, v4.16b, v6.16b
and	v4.16b, v4.16b, v14.16b
umax	v0.16b, v0.16b, v1.16b
uqadd	v2.16b, v2.16b, v3.16b
umax	v4.16b, v0.16b, v4.16b
cmhs	v1.16b, v11.16b, v4.16b
cmhs	v2.16b, v10.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
and	v14.16b, v14.16b, v1.16b
and	v15.16b, v15.16b, v1.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_74
mov	x14, #0x1
ret
L_74:
movi	v10.16b, #0x1
uabd	v2.16b, v21.16b, v23.16b
uabd	v3.16b, v22.16b, v23.16b
uabd	v4.16b, v25.16b, v24.16b
uabd	v5.16b, v26.16b, v24.16b
uabd	v6.16b, v20.16b, v23.16b
uabd	v7.16b, v27.16b, v24.16b
umax	v2.16b, v2.16b, v3.16b
umax	v4.16b, v4.16b, v5.16b
umax	v6.16b, v6.16b, v7.16b
umax	v2.16b, v2.16b, v4.16b
umax	v2.16b, v2.16b, v6.16b
uabd	v3.16b, v17.16b, v23.16b
uabd	v4.16b, v18.16b, v23.16b
uabd	v5.16b, v19.16b, v23.16b
cmhs	v2.16b, v10.16b, v2.16b
uabd	v6.16b, v28.16b, v24.16b
uabd	v7.16b, v29.16b, v24.16b
uabd	v8.16b, v30.16b, v24.16b
and	v14.16b, v2.16b, v14.16b
bic	v1.16b, v1.16b, v14.16b
umax	v3.16b, v3.16b, v4.16b
umax	v5.16b, v5.16b, v6.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
umax	v7.16b, v7.16b, v8.16b
umax	v3.16b, v3.16b, v5.16b
umax	v3.16b, v3.16b, v7.16b
cmhs	v3.16b, v10.16b, v3.16b
adds	x16, x16, x17
and	v15.16b, v15.16b, v3.16b
and	v15.16b, v15.16b, v14.16b
bic	v14.16b, v14.16b, v15.16b
b.eq	L_190
movi	v3.16b, #0x80
eor	v2.16b, v22.16b, v3.16b
eor	v3.16b, v25.16b, v3.16b
cmhi	v0.16b, v0.16b, v12.16b
sqsub	v2.16b, v2.16b, v3.16b
and	v4.16b, v2.16b, v0.16b
bic	v0.16b, v1.16b, v0.16b
usubl	v2.8h, v24.8b, v23.8b
movi	v5.8h, #0x3
usubl2	v3.8h, v24.16b, v23.16b
mul	v2.8h, v2.8h, v5.8h
mul	v3.8h, v3.8h, v5.8h
movi	v6.16b, #0x4
saddw	v2.8h, v2.8h, v4.8b
saddw2	v3.8h, v3.8h, v4.16b
movi	v7.16b, #0x3
sqxtn	v2.8b, v2.8h
sqxtn2	v2.16b, v3.8h
sqadd	v4.16b, v6.16b, v2.16b
sqadd	v5.16b, v7.16b, v2.16b
sshr	v4.16b, v4.16b, #0x3
sshr	v5.16b, v5.16b, #0x3
mov	v2.16b, v23.16b
mov	v3.16b, v24.16b
neg	v6.16b, v4.16b
srshr	v4.16b, v4.16b, #0x1
usqadd	v2.16b, v5.16b
usqadd	v3.16b, v6.16b
neg	v6.16b, v4.16b
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v3.16b, v1.16b
mov	v2.16b, v22.16b
mov	v3.16b, v25.16b
usqadd	v2.16b, v4.16b
usqadd	v3.16b, v6.16b
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v3.16b, v0.16b
L_190:
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_2a8
uaddl	v0.8h, v20.8b, v21.8b
uaddl2	v1.8h, v20.16b, v21.16b
uaddl	v2.8h, v22.8b, v25.8b
uaddl2	v3.8h, v22.16b, v25.16b
uaddl	v4.8h, v20.8b, v22.8b
uaddl2	v5.8h, v20.16b, v22.16b
uaddl	v6.8h, v23.8b, v26.8b
uaddl2	v7.8h, v23.16b, v26.16b
add	v8.8h, v0.8h, v0.8h
add	v9.8h, v1.8h, v1.8h
uaddw	v8.8h, v8.8h, v23.8b
uaddw2	v9.8h, v9.8h, v23.16b
uaddw	v8.8h, v8.8h, v24.8b
uaddw2	v9.8h, v9.8h, v24.16b
add	v8.8h, v8.8h, v4.8h
add	v9.8h, v9.8h, v5.8h
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
rshrn	v10.8b, v8.8h, #0x3
rshrn2	v10.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v9.8h, v9.8h, v3.8h
uaddl	v0.8h, v20.8b, v23.8b
uaddl2	v1.8h, v20.16b, v23.16b
uaddl	v2.8h, v24.8b, v27.8b
uaddl2	v3.8h, v24.16b, v27.16b
rshrn	v11.8b, v8.8h, #0x3
rshrn2	v11.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v6.8h
add	v9.8h, v9.8h, v7.8h
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
uaddl	v4.8h, v21.8b, v24.8b
uaddl2	v5.8h, v21.16b, v24.16b
uaddl	v6.8h, v25.8b, v27.8b
uaddl2	v7.8h, v25.16b, v27.16b
rshrn	v12.8b, v8.8h, #0x3
rshrn2	v12.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v9.8h, v9.8h, v3.8h
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
uaddl	v0.8h, v22.8b, v25.8b
uaddl2	v1.8h, v22.16b, v25.16b
uaddl	v2.8h, v26.8b, v27.8b
uaddl2	v3.8h, v26.16b, v27.16b
rshrn	v13.8b, v8.8h, #0x3
rshrn2	v13.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v6.8h
add	v9.8h, v9.8h, v7.8h
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
rshrn	v0.8b, v8.8h, #0x3
rshrn2	v0.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v9.8h, v9.8h, v3.8h
bit	v21.16b, v10.16b, v14.16b
bit	v22.16b, v11.16b, v14.16b
bit	v23.16b, v12.16b, v14.16b
rshrn	v1.8b, v8.8h, #0x3
rshrn2	v1.16b, v9.8h, #0x3
bit	v24.16b, v13.16b, v14.16b
bit	v25.16b, v0.16b, v14.16b
bit	v26.16b, v1.16b, v14.16b
L_2a8:
mov	x16, v15.d[0]
mov	x17, v15.d[1]
adds	x16, x16, x17
b.ne	L_2cc
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_534
b	L_52c
L_2cc:
uaddl	v2.8h, v17.8b, v17.8b
uaddl2	v3.8h, v17.16b, v17.16b
uaddl	v4.8h, v17.8b, v18.8b
uaddl2	v5.8h, v17.16b, v18.16b
uaddl	v6.8h, v17.8b, v19.8b
uaddl2	v7.8h, v17.16b, v19.16b
uaddl	v8.8h, v17.8b, v20.8b
uaddl2	v9.8h, v17.16b, v20.16b
add	v12.8h, v2.8h, v4.8h
add	v13.8h, v3.8h, v5.8h
add	v10.8h, v6.8h, v8.8h
add	v11.8h, v7.8h, v9.8h
uaddl	v6.8h, v17.8b, v21.8b
uaddl2	v7.8h, v17.16b, v21.16b
add	v12.8h, v12.8h, v10.8h
add	v13.8h, v13.8h, v11.8h
uaddl	v8.8h, v17.8b, v22.8b
uaddl2	v9.8h, v17.16b, v22.16b
uaddl	v10.8h, v18.8b, v23.8b
uaddl2	v11.8h, v18.16b, v23.16b
add	v6.8h, v6.8h, v8.8h
add	v7.8h, v7.8h, v9.8h
uaddl	v8.8h, v19.8b, v24.8b
uaddl2	v9.8h, v19.16b, v24.16b
add	v12.8h, v12.8h, v6.8h
add	v13.8h, v13.8h, v7.8h
add	v10.8h, v10.8h, v8.8h
add	v11.8h, v11.8h, v9.8h
uaddl	v6.8h, v20.8b, v25.8b
uaddl2	v7.8h, v20.16b, v25.16b
add	v12.8h, v12.8h, v10.8h
add	v13.8h, v13.8h, v11.8h
sub	v6.8h, v6.8h, v2.8h
sub	v7.8h, v7.8h, v3.8h
uaddl	v2.8h, v21.8b, v26.8b
uaddl2	v3.8h, v21.16b, v26.16b
rshrn	v0.8b, v12.8h, #0x4
rshrn2	v0.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v6.8h
add	v13.8h, v13.8h, v7.8h
sub	v2.8h, v2.8h, v4.8h
sub	v3.8h, v3.8h, v5.8h
uaddl	v4.8h, v22.8b, v27.8b
uaddl2	v5.8h, v22.16b, v27.16b
uaddl	v6.8h, v17.8b, v19.8b
uaddl2	v7.8h, v17.16b, v19.16b
rshrn	v1.8b, v12.8h, #0x4
rshrn2	v1.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v2.8h
add	v13.8h, v13.8h, v3.8h
sub	v4.8h, v4.8h, v6.8h
sub	v5.8h, v5.8h, v7.8h
uaddl	v6.8h, v23.8b, v28.8b
uaddl2	v7.8h, v23.16b, v28.16b
uaddl	v8.8h, v17.8b, v20.8b
uaddl2	v9.8h, v17.16b, v20.16b
rshrn	v2.8b, v12.8h, #0x4
rshrn2	v2.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v4.8h
add	v13.8h, v13.8h, v5.8h
sub	v6.8h, v6.8h, v8.8h
sub	v7.8h, v7.8h, v9.8h
uaddl	v8.8h, v24.8b, v29.8b
uaddl2	v9.8h, v24.16b, v29.16b
uaddl	v4.8h, v17.8b, v21.8b
uaddl2	v5.8h, v17.16b, v21.16b
rshrn	v3.8b, v12.8h, #0x4
rshrn2	v3.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v6.8h
add	v13.8h, v13.8h, v7.8h
sub	v8.8h, v8.8h, v4.8h
sub	v9.8h, v9.8h, v5.8h
uaddl	v6.8h, v25.8b, v30.8b
uaddl2	v7.8h, v25.16b, v30.16b
uaddl	v10.8h, v17.8b, v22.8b
uaddl2	v11.8h, v17.16b, v22.16b
rshrn	v4.8b, v12.8h, #0x4
rshrn2	v4.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v8.8h
add	v13.8h, v13.8h, v9.8h
sub	v6.8h, v6.8h, v10.8h
sub	v7.8h, v7.8h, v11.8h
uaddl	v8.8h, v26.8b, v30.8b
uaddl2	v9.8h, v26.16b, v30.16b
bif	v0.16b, v18.16b, v15.16b
uaddl	v10.8h, v18.8b, v23.8b
uaddl2	v11.8h, v18.16b, v23.16b
rshrn	v5.8b, v12.8h, #0x4
rshrn2	v5.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v6.8h
add	v13.8h, v13.8h, v7.8h
sub	v8.8h, v8.8h, v10.8h
sub	v9.8h, v9.8h, v11.8h
uaddl	v10.8h, v27.8b, v30.8b
uaddl2	v11.8h, v27.16b, v30.16b
bif	v1.16b, v19.16b, v15.16b
uaddl	v18.8h, v19.8b, v24.8b
uaddl2	v19.8h, v19.16b, v24.16b
rshrn	v6.8b, v12.8h, #0x4
rshrn2	v6.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v8.8h
add	v13.8h, v13.8h, v9.8h
sub	v10.8h, v10.8h, v18.8h
sub	v11.8h, v11.8h, v19.8h
uaddl	v8.8h, v28.8b, v30.8b
uaddl2	v9.8h, v28.16b, v30.16b
bif	v2.16b, v20.16b, v15.16b
uaddl	v18.8h, v20.8b, v25.8b
uaddl2	v19.8h, v20.16b, v25.16b
rshrn	v7.8b, v12.8h, #0x4
rshrn2	v7.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v10.8h
add	v13.8h, v13.8h, v11.8h
sub	v18.8h, v8.8h, v18.8h
sub	v19.8h, v9.8h, v19.8h
uaddl	v10.8h, v29.8b, v30.8b
uaddl2	v11.8h, v29.16b, v30.16b
bif	v3.16b, v21.16b, v15.16b
uaddl	v20.8h, v21.8b, v26.8b
uaddl2	v21.8h, v21.16b, v26.16b
rshrn	v8.8b, v12.8h, #0x4
rshrn2	v8.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v18.8h
add	v13.8h, v13.8h, v19.8h
sub	v10.8h, v10.8h, v20.8h
sub	v11.8h, v11.8h, v21.8h
uaddl	v18.8h, v30.8b, v30.8b
uaddl2	v19.8h, v30.16b, v30.16b
bif	v4.16b, v22.16b, v15.16b
uaddl	v20.8h, v22.8b, v27.8b
uaddl2	v21.8h, v22.16b, v27.16b
rshrn	v9.8b, v12.8h, #0x4
rshrn2	v9.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v10.8h
add	v13.8h, v13.8h, v11.8h
sub	v18.8h, v18.8h, v20.8h
sub	v19.8h, v19.8h, v21.8h
bif	v5.16b, v23.16b, v15.16b
rshrn	v10.8b, v12.8h, #0x4
rshrn2	v10.16b, v13.8h, #0x4
add	v12.8h, v12.8h, v18.8h
add	v13.8h, v13.8h, v19.8h
rshrn	v11.8b, v12.8h, #0x4
rshrn2	v11.16b, v13.8h, #0x4
bif	v6.16b, v24.16b, v15.16b
bif	v7.16b, v25.16b, v15.16b
bif	v8.16b, v26.16b, v15.16b
bif	v9.16b, v27.16b, v15.16b
bif	v10.16b, v28.16b, v15.16b
bif	v11.16b, v29.16b, v15.16b
mov	x14, #0x0
ret
L_52c:
mov	x14, #0x40
ret
L_534:
mov	x14, #0x10
ret
lpf_16_wd8_neon:
uabd	v0.16b, v22.16b, v23.16b
uabd	v1.16b, v25.16b, v24.16b
uabd	v2.16b, v23.16b, v24.16b
uabd	v3.16b, v22.16b, v25.16b
uabd	v4.16b, v21.16b, v22.16b
uabd	v5.16b, v26.16b, v25.16b
uabd	v6.16b, v20.16b, v21.16b
uabd	v7.16b, v27.16b, v26.16b
umax	v4.16b, v4.16b, v5.16b
uqadd	v2.16b, v2.16b, v2.16b
umax	v6.16b, v6.16b, v7.16b
ushr	v3.16b, v3.16b, #0x1
umax	v4.16b, v4.16b, v6.16b
and	v4.16b, v4.16b, v14.16b
umax	v0.16b, v0.16b, v1.16b
uqadd	v2.16b, v2.16b, v3.16b
umax	v4.16b, v0.16b, v4.16b
cmhs	v1.16b, v11.16b, v4.16b
cmhs	v2.16b, v10.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
and	v14.16b, v14.16b, v1.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_5ac
mov	x14, #0x1
ret
L_5ac:
movi	v10.16b, #0x1
uabd	v2.16b, v21.16b, v23.16b
uabd	v3.16b, v22.16b, v23.16b
uabd	v4.16b, v25.16b, v24.16b
uabd	v5.16b, v26.16b, v24.16b
uabd	v6.16b, v20.16b, v23.16b
uabd	v7.16b, v27.16b, v24.16b
umax	v2.16b, v2.16b, v3.16b
umax	v4.16b, v4.16b, v5.16b
umax	v6.16b, v6.16b, v7.16b
umax	v2.16b, v2.16b, v4.16b
umax	v2.16b, v2.16b, v6.16b
cmhs	v2.16b, v10.16b, v2.16b
and	v14.16b, v2.16b, v14.16b
bic	v1.16b, v1.16b, v14.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.eq	L_68c
movi	v3.16b, #0x80
eor	v2.16b, v22.16b, v3.16b
eor	v3.16b, v25.16b, v3.16b
cmhi	v0.16b, v0.16b, v12.16b
sqsub	v2.16b, v2.16b, v3.16b
and	v4.16b, v2.16b, v0.16b
bic	v0.16b, v1.16b, v0.16b
usubl	v2.8h, v24.8b, v23.8b
movi	v5.8h, #0x3
usubl2	v3.8h, v24.16b, v23.16b
mul	v2.8h, v2.8h, v5.8h
mul	v3.8h, v3.8h, v5.8h
movi	v6.16b, #0x4
saddw	v2.8h, v2.8h, v4.8b
saddw2	v3.8h, v3.8h, v4.16b
movi	v7.16b, #0x3
sqxtn	v2.8b, v2.8h
sqxtn2	v2.16b, v3.8h
sqadd	v4.16b, v6.16b, v2.16b
sqadd	v5.16b, v7.16b, v2.16b
sshr	v4.16b, v4.16b, #0x3
sshr	v5.16b, v5.16b, #0x3
mov	v2.16b, v23.16b
mov	v3.16b, v24.16b
neg	v6.16b, v4.16b
srshr	v4.16b, v4.16b, #0x1
usqadd	v2.16b, v5.16b
usqadd	v3.16b, v6.16b
neg	v6.16b, v4.16b
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v3.16b, v1.16b
mov	v2.16b, v22.16b
mov	v3.16b, v25.16b
usqadd	v2.16b, v4.16b
usqadd	v3.16b, v6.16b
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v3.16b, v0.16b
L_68c:
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_7ac
uaddl	v0.8h, v20.8b, v21.8b
uaddl2	v1.8h, v20.16b, v21.16b
uaddl	v2.8h, v22.8b, v25.8b
uaddl2	v3.8h, v22.16b, v25.16b
uaddl	v4.8h, v20.8b, v22.8b
uaddl2	v5.8h, v20.16b, v22.16b
uaddl	v6.8h, v23.8b, v26.8b
uaddl2	v7.8h, v23.16b, v26.16b
add	v8.8h, v0.8h, v0.8h
add	v9.8h, v1.8h, v1.8h
uaddw	v8.8h, v8.8h, v23.8b
uaddw2	v9.8h, v9.8h, v23.16b
uaddw	v8.8h, v8.8h, v24.8b
uaddw2	v9.8h, v9.8h, v24.16b
add	v8.8h, v8.8h, v4.8h
add	v9.8h, v9.8h, v5.8h
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
rshrn	v10.8b, v8.8h, #0x3
rshrn2	v10.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v9.8h, v9.8h, v3.8h
uaddl	v0.8h, v20.8b, v23.8b
uaddl2	v1.8h, v20.16b, v23.16b
uaddl	v2.8h, v24.8b, v27.8b
uaddl2	v3.8h, v24.16b, v27.16b
rshrn	v11.8b, v8.8h, #0x3
rshrn2	v11.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v6.8h
add	v9.8h, v9.8h, v7.8h
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
uaddl	v4.8h, v21.8b, v24.8b
uaddl2	v5.8h, v21.16b, v24.16b
uaddl	v6.8h, v25.8b, v27.8b
uaddl2	v7.8h, v25.16b, v27.16b
rshrn	v12.8b, v8.8h, #0x3
rshrn2	v12.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v9.8h, v9.8h, v3.8h
sub	v6.8h, v6.8h, v4.8h
sub	v7.8h, v7.8h, v5.8h
uaddl	v0.8h, v22.8b, v25.8b
uaddl2	v1.8h, v22.16b, v25.16b
uaddl	v2.8h, v26.8b, v27.8b
uaddl2	v3.8h, v26.16b, v27.16b
rshrn	v13.8b, v8.8h, #0x3
rshrn2	v13.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v6.8h
add	v9.8h, v9.8h, v7.8h
sub	v2.8h, v2.8h, v0.8h
sub	v3.8h, v3.8h, v1.8h
rshrn	v0.8b, v8.8h, #0x3
rshrn2	v0.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v2.8h
add	v9.8h, v9.8h, v3.8h
bit	v21.16b, v10.16b, v14.16b
bit	v22.16b, v11.16b, v14.16b
bit	v23.16b, v12.16b, v14.16b
rshrn	v1.8b, v8.8h, #0x3
rshrn2	v1.16b, v9.8h, #0x3
bit	v24.16b, v13.16b, v14.16b
bit	v25.16b, v0.16b, v14.16b
bit	v26.16b, v1.16b, v14.16b
mov	x14, #0x0
ret
L_7ac:
mov	x14, #0x10
ret
lpf_16_wd6_neon:
uabd	v0.16b, v22.16b, v23.16b
uabd	v1.16b, v25.16b, v24.16b
uabd	v2.16b, v23.16b, v24.16b
uabd	v3.16b, v22.16b, v25.16b
uabd	v4.16b, v21.16b, v22.16b
uabd	v5.16b, v26.16b, v25.16b
umax	v4.16b, v4.16b, v5.16b
uqadd	v2.16b, v2.16b, v2.16b
ushr	v3.16b, v3.16b, #0x1
and	v4.16b, v4.16b, v14.16b
umax	v0.16b, v0.16b, v1.16b
uqadd	v2.16b, v2.16b, v3.16b
umax	v4.16b, v0.16b, v4.16b
cmhs	v1.16b, v11.16b, v4.16b
cmhs	v2.16b, v10.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
and	v14.16b, v14.16b, v1.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_814
mov	x14, #0x1
ret
L_814:
movi	v10.16b, #0x1
uabd	v2.16b, v21.16b, v23.16b
uabd	v3.16b, v22.16b, v23.16b
uabd	v4.16b, v25.16b, v24.16b
uabd	v5.16b, v26.16b, v24.16b
umax	v2.16b, v2.16b, v3.16b
umax	v4.16b, v4.16b, v5.16b
umax	v2.16b, v2.16b, v4.16b
cmhs	v2.16b, v10.16b, v2.16b
and	v14.16b, v2.16b, v14.16b
bic	v1.16b, v1.16b, v14.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.eq	L_8e4
movi	v3.16b, #0x80
eor	v2.16b, v22.16b, v3.16b
eor	v3.16b, v25.16b, v3.16b
cmhi	v0.16b, v0.16b, v12.16b
sqsub	v2.16b, v2.16b, v3.16b
and	v4.16b, v2.16b, v0.16b
bic	v0.16b, v1.16b, v0.16b
usubl	v2.8h, v24.8b, v23.8b
movi	v5.8h, #0x3
usubl2	v3.8h, v24.16b, v23.16b
mul	v2.8h, v2.8h, v5.8h
mul	v3.8h, v3.8h, v5.8h
movi	v6.16b, #0x4
saddw	v2.8h, v2.8h, v4.8b
saddw2	v3.8h, v3.8h, v4.16b
movi	v7.16b, #0x3
sqxtn	v2.8b, v2.8h
sqxtn2	v2.16b, v3.8h
sqadd	v4.16b, v6.16b, v2.16b
sqadd	v5.16b, v7.16b, v2.16b
sshr	v4.16b, v4.16b, #0x3
sshr	v5.16b, v5.16b, #0x3
mov	v2.16b, v23.16b
mov	v3.16b, v24.16b
neg	v6.16b, v4.16b
srshr	v4.16b, v4.16b, #0x1
usqadd	v2.16b, v5.16b
usqadd	v3.16b, v6.16b
neg	v6.16b, v4.16b
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v3.16b, v1.16b
mov	v2.16b, v22.16b
mov	v3.16b, v25.16b
usqadd	v2.16b, v4.16b
usqadd	v3.16b, v6.16b
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v3.16b, v0.16b
L_8e4:
mov	x16, v14.d[0]
mov	x17, v14.d[1]
adds	x16, x16, x17
b.eq	L_9a4
uaddl	v0.8h, v21.8b, v21.8b
uaddl2	v1.8h, v21.16b, v21.16b
uaddl	v2.8h, v21.8b, v22.8b
uaddl2	v3.8h, v21.16b, v22.16b
uaddl	v4.8h, v22.8b, v23.8b
uaddl2	v5.8h, v22.16b, v23.16b
uaddl	v6.8h, v23.8b, v24.8b
uaddl2	v7.8h, v23.16b, v24.16b
add	v8.8h, v0.8h, v2.8h
add	v9.8h, v1.8h, v3.8h
add	v10.8h, v4.8h, v6.8h
add	v11.8h, v5.8h, v7.8h
uaddl	v12.8h, v24.8b, v25.8b
uaddl2	v13.8h, v24.16b, v25.16b
add	v8.8h, v8.8h, v10.8h
add	v9.8h, v9.8h, v11.8h
sub	v12.8h, v12.8h, v0.8h
sub	v13.8h, v13.8h, v1.8h
uaddl	v10.8h, v25.8b, v26.8b
uaddl2	v11.8h, v25.16b, v26.16b
rshrn	v0.8b, v8.8h, #0x3
rshrn2	v0.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v12.8h
add	v9.8h, v9.8h, v13.8h
sub	v10.8h, v10.8h, v2.8h
sub	v11.8h, v11.8h, v3.8h
uaddl	v12.8h, v26.8b, v26.8b
uaddl2	v13.8h, v26.16b, v26.16b
rshrn	v1.8b, v8.8h, #0x3
rshrn2	v1.16b, v9.8h, #0x3
add	v8.8h, v8.8h, v10.8h
add	v9.8h, v9.8h, v11.8h
sub	v12.8h, v12.8h, v4.8h
sub	v13.8h, v13.8h, v5.8h
rshrn	v2.8b, v8.8h, #0x3
rshrn2	v2.16b, v9.8h, #0x3
bit	v22.16b, v0.16b, v14.16b
add	v8.8h, v8.8h, v12.8h
add	v9.8h, v9.8h, v13.8h
bit	v23.16b, v1.16b, v14.16b
rshrn	v3.8b, v8.8h, #0x3
rshrn2	v3.16b, v9.8h, #0x3
bit	v24.16b, v2.16b, v14.16b
bit	v25.16b, v3.16b, v14.16b
L_9a4:
mov	x14, #0x0
ret
lpf_16_wd4_neon:
uabd	v0.16b, v22.16b, v23.16b
uabd	v1.16b, v25.16b, v24.16b
uabd	v2.16b, v23.16b, v24.16b
uabd	v3.16b, v22.16b, v25.16b
uqadd	v2.16b, v2.16b, v2.16b
ushr	v3.16b, v3.16b, #0x1
umax	v0.16b, v0.16b, v1.16b
uqadd	v2.16b, v2.16b, v3.16b
cmhs	v1.16b, v11.16b, v0.16b
cmhs	v2.16b, v10.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
and	v1.16b, v1.16b, v13.16b
mov	x16, v1.d[0]
mov	x17, v1.d[1]
adds	x16, x16, x17
b.ne	L_9f4
mov	x14, #0x1
ret
L_9f4:
movi	v3.16b, #0x80
eor	v2.16b, v22.16b, v3.16b
eor	v3.16b, v25.16b, v3.16b
cmhi	v0.16b, v0.16b, v12.16b
sqsub	v2.16b, v2.16b, v3.16b
and	v4.16b, v2.16b, v0.16b
bic	v0.16b, v1.16b, v0.16b
usubl	v2.8h, v24.8b, v23.8b
movi	v5.8h, #0x3
usubl2	v3.8h, v24.16b, v23.16b
mul	v2.8h, v2.8h, v5.8h
mul	v3.8h, v3.8h, v5.8h
movi	v6.16b, #0x4
saddw	v2.8h, v2.8h, v4.8b
saddw2	v3.8h, v3.8h, v4.16b
movi	v7.16b, #0x3
sqxtn	v2.8b, v2.8h
sqxtn2	v2.16b, v3.8h
sqadd	v4.16b, v6.16b, v2.16b
sqadd	v5.16b, v7.16b, v2.16b
sshr	v4.16b, v4.16b, #0x3
sshr	v5.16b, v5.16b, #0x3
mov	v2.16b, v23.16b
mov	v3.16b, v24.16b
neg	v6.16b, v4.16b
srshr	v4.16b, v4.16b, #0x1
usqadd	v2.16b, v5.16b
usqadd	v3.16b, v6.16b
neg	v6.16b, v4.16b
bit	v23.16b, v2.16b, v1.16b
bit	v24.16b, v3.16b, v1.16b
mov	v2.16b, v22.16b
mov	v3.16b, v25.16b
usqadd	v2.16b, v4.16b
usqadd	v3.16b, v6.16b
bit	v22.16b, v2.16b, v0.16b
bit	v25.16b, v3.16b, v0.16b
mov	x14, #0x0
ret
lpf_v_4_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
ld1	{ v22.16b }, [x16], x1
ld1	{ v24.16b }, [x0], x1
ld1	{ v23.16b }, [x16], x1
ld1	{ v25.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
bl	lpf_16_wd4_neon
cbz	x14, L_ab8
ret	x15
L_ab8:
sub	x16, x0, x1, lsl #1
st1	{ v22.16b }, [x16], x1
st1	{ v24.16b }, [x0], x1
st1	{ v23.16b }, [x16], x1
st1	{ v25.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_4_16_neon:
mov	x15, x30
sub	x16, x0, #0x2
add	x0, x16, x1, lsl #3
ld1	{ v22.s }[0], [x16], x1
ld1	{ v22.s }[2], [x0], x1
ld1	{ v23.s }[0], [x16], x1
ld1	{ v23.s }[2], [x0], x1
ld1	{ v24.s }[0], [x16], x1
ld1	{ v24.s }[2], [x0], x1
ld1	{ v25.s }[0], [x16], x1
ld1	{ v25.s }[2], [x0], x1
ld1	{ v22.s }[1], [x16], x1
ld1	{ v22.s }[3], [x0], x1
ld1	{ v23.s }[1], [x16], x1
ld1	{ v23.s }[3], [x0], x1
ld1	{ v24.s }[1], [x16], x1
ld1	{ v24.s }[3], [x0], x1
ld1	{ v25.s }[1], [x16], x1
ld1	{ v25.s }[3], [x0], x1
add	x0, x0, #0x2
trn1	v26.16b, v22.16b, v23.16b
trn2	v27.16b, v22.16b, v23.16b
trn1	v28.16b, v24.16b, v25.16b
trn2	v29.16b, v24.16b, v25.16b
trn1	v22.8h, v26.8h, v28.8h
trn2	v24.8h, v26.8h, v28.8h
trn1	v23.8h, v27.8h, v29.8h
trn2	v25.8h, v27.8h, v29.8h
bl	lpf_16_wd4_neon
cbz	x14, L_b50
ret	x15
L_b50:
sub	x16, x0, x1, lsl #4
sub	x16, x16, #0x2
trn1	v26.16b, v22.16b, v23.16b
trn2	v27.16b, v22.16b, v23.16b
trn1	v28.16b, v24.16b, v25.16b
trn2	v29.16b, v24.16b, v25.16b
trn1	v22.8h, v26.8h, v28.8h
trn2	v24.8h, v26.8h, v28.8h
trn1	v23.8h, v27.8h, v29.8h
trn2	v25.8h, v27.8h, v29.8h
add	x0, x16, x1, lsl #3
st1	{ v22.s }[0], [x16], x1
st1	{ v22.s }[2], [x0], x1
st1	{ v23.s }[0], [x16], x1
st1	{ v23.s }[2], [x0], x1
st1	{ v24.s }[0], [x16], x1
st1	{ v24.s }[2], [x0], x1
st1	{ v25.s }[0], [x16], x1
st1	{ v25.s }[2], [x0], x1
st1	{ v22.s }[1], [x16], x1
st1	{ v22.s }[3], [x0], x1
st1	{ v23.s }[1], [x16], x1
st1	{ v23.s }[3], [x0], x1
st1	{ v24.s }[1], [x16], x1
st1	{ v24.s }[3], [x0], x1
st1	{ v25.s }[1], [x16], x1
st1	{ v25.s }[3], [x0], x1
add	x0, x0, #0x2
ret	x15
lpf_v_6_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
ld1	{ v21.16b }, [x16], x1
ld1	{ v24.16b }, [x0], x1
ld1	{ v22.16b }, [x16], x1
ld1	{ v25.16b }, [x0], x1
ld1	{ v23.16b }, [x16], x1
ld1	{ v26.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
bl	lpf_16_wd6_neon
cbz	x14, L_bfc
ret	x15
L_bfc:
sub	x16, x0, x1, lsl #1
st1	{ v22.16b }, [x16], x1
st1	{ v24.16b }, [x0], x1
st1	{ v23.16b }, [x16], x1
st1	{ v25.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_6_16_neon:
mov	x15, x30
sub	x16, x0, #0x4
add	x0, x16, x1, lsl #3
ld1	{ v20.d }[0], [x16], x1
ld1	{ v20.d }[1], [x0], x1
ld1	{ v21.d }[0], [x16], x1
ld1	{ v21.d }[1], [x0], x1
ld1	{ v22.d }[0], [x16], x1
ld1	{ v22.d }[1], [x0], x1
ld1	{ v23.d }[0], [x16], x1
ld1	{ v23.d }[1], [x0], x1
ld1	{ v24.d }[0], [x16], x1
ld1	{ v24.d }[1], [x0], x1
ld1	{ v25.d }[0], [x16], x1
ld1	{ v25.d }[1], [x0], x1
ld1	{ v26.d }[0], [x16], x1
ld1	{ v26.d }[1], [x0], x1
ld1	{ v27.d }[0], [x16], x1
ld1	{ v27.d }[1], [x0], x1
add	x0, x0, #0x4
trn1	v28.16b, v20.16b, v21.16b
trn2	v29.16b, v20.16b, v21.16b
trn1	v21.16b, v22.16b, v23.16b
trn2	v23.16b, v22.16b, v23.16b
trn1	v20.16b, v24.16b, v25.16b
trn2	v25.16b, v24.16b, v25.16b
trn1	v22.16b, v26.16b, v27.16b
trn2	v27.16b, v26.16b, v27.16b
trn1	v24.8h, v20.8h, v22.8h
trn2	v22.8h, v20.8h, v22.8h
trn1	v26.8h, v25.8h, v27.8h
trn2	v27.8h, v25.8h, v27.8h
trn1	v25.8h, v29.8h, v23.8h
trn2	v29.8h, v29.8h, v23.8h
trn1	v23.8h, v28.8h, v21.8h
trn2	v28.8h, v28.8h, v21.8h
trn1	v20.4s, v23.4s, v24.4s
trn2	v24.4s, v23.4s, v24.4s
trn1	v21.4s, v25.4s, v26.4s
trn2	v25.4s, v25.4s, v26.4s
trn2	v26.4s, v28.4s, v22.4s
trn1	v22.4s, v28.4s, v22.4s
trn1	v23.4s, v29.4s, v27.4s
trn2	v27.4s, v29.4s, v27.4s
bl	lpf_16_wd6_neon
cbz	x14, L_cd4
ret	x15
L_cd4:
sub	x16, x0, x1, lsl #4
sub	x16, x16, #0x2
trn1	v26.16b, v22.16b, v23.16b
trn2	v27.16b, v22.16b, v23.16b
trn1	v28.16b, v24.16b, v25.16b
trn2	v29.16b, v24.16b, v25.16b
trn1	v22.8h, v26.8h, v28.8h
trn2	v24.8h, v26.8h, v28.8h
trn1	v23.8h, v27.8h, v29.8h
trn2	v25.8h, v27.8h, v29.8h
add	x0, x16, x1, lsl #3
st1	{ v22.s }[0], [x16], x1
st1	{ v22.s }[2], [x0], x1
st1	{ v23.s }[0], [x16], x1
st1	{ v23.s }[2], [x0], x1
st1	{ v24.s }[0], [x16], x1
st1	{ v24.s }[2], [x0], x1
st1	{ v25.s }[0], [x16], x1
st1	{ v25.s }[2], [x0], x1
st1	{ v22.s }[1], [x16], x1
st1	{ v22.s }[3], [x0], x1
st1	{ v23.s }[1], [x16], x1
st1	{ v23.s }[3], [x0], x1
st1	{ v24.s }[1], [x16], x1
st1	{ v24.s }[3], [x0], x1
st1	{ v25.s }[1], [x16], x1
st1	{ v25.s }[3], [x0], x1
add	x0, x0, #0x2
ret	x15
lpf_v_8_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #2
ld1	{ v20.16b }, [x16], x1
ld1	{ v24.16b }, [x0], x1
ld1	{ v21.16b }, [x16], x1
ld1	{ v25.16b }, [x0], x1
ld1	{ v22.16b }, [x16], x1
ld1	{ v26.16b }, [x0], x1
ld1	{ v23.16b }, [x16], x1
ld1	{ v27.16b }, [x0], x1
sub	x0, x0, x1, lsl #2
bl	lpf_16_wd8_neon
cbz	x14, L_d84
tbnz	w14, #0x4, L_db0
ret	x15
L_d84:
sub	x16, x0, x1, lsl #1
sub	x16, x16, x1
st1	{ v21.16b }, [x16], x1
st1	{ v24.16b }, [x0], x1
st1	{ v22.16b }, [x16], x1
st1	{ v25.16b }, [x0], x1
st1	{ v23.16b }, [x16], x1
st1	{ v26.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
L_db0:
sub	x16, x0, x1, lsl #1
st1	{ v22.16b }, [x16], x1
st1	{ v24.16b }, [x0], x1
st1	{ v23.16b }, [x16], x1
st1	{ v25.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_8_16_neon:
mov	x15, x30
sub	x16, x0, #0x4
add	x0, x16, x1, lsl #3
ld1	{ v20.d }[0], [x16], x1
ld1	{ v20.d }[1], [x0], x1
ld1	{ v21.d }[0], [x16], x1
ld1	{ v21.d }[1], [x0], x1
ld1	{ v22.d }[0], [x16], x1
ld1	{ v22.d }[1], [x0], x1
ld1	{ v23.d }[0], [x16], x1
ld1	{ v23.d }[1], [x0], x1
ld1	{ v24.d }[0], [x16], x1
ld1	{ v24.d }[1], [x0], x1
ld1	{ v25.d }[0], [x16], x1
ld1	{ v25.d }[1], [x0], x1
ld1	{ v26.d }[0], [x16], x1
ld1	{ v26.d }[1], [x0], x1
ld1	{ v27.d }[0], [x16], x1
ld1	{ v27.d }[1], [x0], x1
add	x0, x0, #0x4
trn1	v28.16b, v20.16b, v21.16b
trn2	v29.16b, v20.16b, v21.16b
trn1	v21.16b, v22.16b, v23.16b
trn2	v23.16b, v22.16b, v23.16b
trn1	v20.16b, v24.16b, v25.16b
trn2	v25.16b, v24.16b, v25.16b
trn1	v22.16b, v26.16b, v27.16b
trn2	v27.16b, v26.16b, v27.16b
trn1	v24.8h, v20.8h, v22.8h
trn2	v22.8h, v20.8h, v22.8h
trn1	v26.8h, v25.8h, v27.8h
trn2	v27.8h, v25.8h, v27.8h
trn1	v25.8h, v29.8h, v23.8h
trn2	v29.8h, v29.8h, v23.8h
trn1	v23.8h, v28.8h, v21.8h
trn2	v28.8h, v28.8h, v21.8h
trn1	v20.4s, v23.4s, v24.4s
trn2	v24.4s, v23.4s, v24.4s
trn1	v21.4s, v25.4s, v26.4s
trn2	v25.4s, v25.4s, v26.4s
trn2	v26.4s, v28.4s, v22.4s
trn1	v22.4s, v28.4s, v22.4s
trn1	v23.4s, v29.4s, v27.4s
trn2	v27.4s, v29.4s, v27.4s
bl	lpf_16_wd8_neon
cbz	x14, L_e8c
tbnz	w14, #0x4, L_f40
ret	x15
L_e8c:
sub	x16, x0, x1, lsl #4
sub	x16, x16, #0x4
trn1	v28.16b, v20.16b, v21.16b
trn2	v29.16b, v20.16b, v21.16b
trn1	v21.16b, v22.16b, v23.16b
trn2	v23.16b, v22.16b, v23.16b
trn1	v20.16b, v24.16b, v25.16b
trn2	v25.16b, v24.16b, v25.16b
trn1	v22.16b, v26.16b, v27.16b
trn2	v27.16b, v26.16b, v27.16b
trn1	v24.8h, v20.8h, v22.8h
trn2	v22.8h, v20.8h, v22.8h
trn1	v26.8h, v25.8h, v27.8h
trn2	v27.8h, v25.8h, v27.8h
trn1	v25.8h, v29.8h, v23.8h
trn2	v29.8h, v29.8h, v23.8h
trn1	v23.8h, v28.8h, v21.8h
trn2	v28.8h, v28.8h, v21.8h
trn1	v20.4s, v23.4s, v24.4s
trn2	v24.4s, v23.4s, v24.4s
trn1	v21.4s, v25.4s, v26.4s
trn2	v25.4s, v25.4s, v26.4s
trn2	v26.4s, v28.4s, v22.4s
trn1	v22.4s, v28.4s, v22.4s
trn1	v23.4s, v29.4s, v27.4s
trn2	v27.4s, v29.4s, v27.4s
add	x0, x16, x1, lsl #3
st1	{ v20.d }[0], [x16], x1
st1	{ v20.d }[1], [x0], x1
st1	{ v21.d }[0], [x16], x1
st1	{ v21.d }[1], [x0], x1
st1	{ v22.d }[0], [x16], x1
st1	{ v22.d }[1], [x0], x1
st1	{ v23.d }[0], [x16], x1
st1	{ v23.d }[1], [x0], x1
st1	{ v24.d }[0], [x16], x1
st1	{ v24.d }[1], [x0], x1
st1	{ v25.d }[0], [x16], x1
st1	{ v25.d }[1], [x0], x1
st1	{ v26.d }[0], [x16], x1
st1	{ v26.d }[1], [x0], x1
st1	{ v27.d }[0], [x16], x1
st1	{ v27.d }[1], [x0], x1
add	x0, x0, #0x4
ret	x15
L_f40:
sub	x16, x0, x1, lsl #4
sub	x16, x16, #0x2
trn1	v26.16b, v22.16b, v23.16b
trn2	v27.16b, v22.16b, v23.16b
trn1	v28.16b, v24.16b, v25.16b
trn2	v29.16b, v24.16b, v25.16b
trn1	v22.8h, v26.8h, v28.8h
trn2	v24.8h, v26.8h, v28.8h
trn1	v23.8h, v27.8h, v29.8h
trn2	v25.8h, v27.8h, v29.8h
add	x0, x16, x1, lsl #3
st1	{ v22.s }[0], [x16], x1
st1	{ v22.s }[2], [x0], x1
st1	{ v23.s }[0], [x16], x1
st1	{ v23.s }[2], [x0], x1
st1	{ v24.s }[0], [x16], x1
st1	{ v24.s }[2], [x0], x1
st1	{ v25.s }[0], [x16], x1
st1	{ v25.s }[2], [x0], x1
st1	{ v22.s }[1], [x16], x1
st1	{ v22.s }[3], [x0], x1
st1	{ v23.s }[1], [x16], x1
st1	{ v23.s }[3], [x0], x1
st1	{ v24.s }[1], [x16], x1
st1	{ v24.s }[3], [x0], x1
st1	{ v25.s }[1], [x16], x1
st1	{ v25.s }[3], [x0], x1
add	x0, x0, #0x2
ret	x15
lpf_v_16_16_neon:
mov	x15, x30
sub	x16, x0, x1, lsl #3
add	x16, x16, x1
ld1	{ v17.16b }, [x16], x1
ld1	{ v24.16b }, [x0], x1
ld1	{ v18.16b }, [x16], x1
ld1	{ v25.16b }, [x0], x1
ld1	{ v19.16b }, [x16], x1
ld1	{ v26.16b }, [x0], x1
ld1	{ v20.16b }, [x16], x1
ld1	{ v27.16b }, [x0], x1
ld1	{ v21.16b }, [x16], x1
ld1	{ v28.16b }, [x0], x1
ld1	{ v22.16b }, [x16], x1
ld1	{ v29.16b }, [x0], x1
ld1	{ v23.16b }, [x16], x1
ld1	{ v30.16b }, [x0], x1
sub	x0, x0, x1, lsl #3
add	x0, x0, x1
bl	lpf_16_wd16_neon
cbz	x14, L_1014
tbnz	w14, #0x6, L_1058
tbnz	w14, #0x4, L_1084
ret	x15
L_1014:
sub	x16, x0, x1, lsl #2
sub	x16, x16, x1, lsl #1
st1	{ v0.16b }, [x16], x1
st1	{ v6.16b }, [x0], x1
st1	{ v1.16b }, [x16], x1
st1	{ v7.16b }, [x0], x1
st1	{ v2.16b }, [x16], x1
st1	{ v8.16b }, [x0], x1
st1	{ v3.16b }, [x16], x1
st1	{ v9.16b }, [x0], x1
st1	{ v4.16b }, [x16], x1
st1	{ v10.16b }, [x0], x1
st1	{ v5.16b }, [x16], x1
st1	{ v11.16b }, [x0], x1
sub	x0, x0, x1, lsl #2
sub	x0, x0, x1, lsl #1
ret	x15
L_1058:
sub	x16, x0, x1
sub	x16, x16, x1, lsl #1
st1	{ v21.16b }, [x16], x1
st1	{ v24.16b }, [x0], x1
st1	{ v22.16b }, [x16], x1
st1	{ v25.16b }, [x0], x1
st1	{ v23.16b }, [x16], x1
st1	{ v26.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
sub	x0, x0, x1
ret	x15
L_1084:
sub	x16, x0, x1, lsl #1
st1	{ v22.16b }, [x16], x1
st1	{ v24.16b }, [x0], x1
st1	{ v23.16b }, [x16], x1
st1	{ v25.16b }, [x0], x1
sub	x0, x0, x1, lsl #1
ret	x15
lpf_h_16_16_neon:
mov	x15, x30
sub	x16, x0, #0x8
ld1	{ v16.d }[0], [x16], x1
ld1	{ v24.d }[0], [x0], x1
ld1	{ v17.d }[0], [x16], x1
ld1	{ v25.d }[0], [x0], x1
ld1	{ v18.d }[0], [x16], x1
ld1	{ v26.d }[0], [x0], x1
ld1	{ v19.d }[0], [x16], x1
ld1	{ v27.d }[0], [x0], x1
ld1	{ v20.d }[0], [x16], x1
ld1	{ v28.d }[0], [x0], x1
ld1	{ v21.d }[0], [x16], x1
ld1	{ v29.d }[0], [x0], x1
ld1	{ v22.d }[0], [x16], x1
ld1	{ v30.d }[0], [x0], x1
ld1	{ v23.d }[0], [x16], x1
ld1	{ v31.d }[0], [x0], x1
ld1	{ v16.d }[1], [x16], x1
ld1	{ v24.d }[1], [x0], x1
ld1	{ v17.d }[1], [x16], x1
ld1	{ v25.d }[1], [x0], x1
ld1	{ v18.d }[1], [x16], x1
ld1	{ v26.d }[1], [x0], x1
ld1	{ v19.d }[1], [x16], x1
ld1	{ v27.d }[1], [x0], x1
ld1	{ v20.d }[1], [x16], x1
ld1	{ v28.d }[1], [x0], x1
ld1	{ v21.d }[1], [x16], x1
ld1	{ v29.d }[1], [x0], x1
ld1	{ v22.d }[1], [x16], x1
ld1	{ v30.d }[1], [x0], x1
ld1	{ v23.d }[1], [x16], x1
ld1	{ v31.d }[1], [x0], x1
trn1	v0.16b, v16.16b, v17.16b
trn2	v1.16b, v16.16b, v17.16b
trn1	v17.16b, v18.16b, v19.16b
trn2	v19.16b, v18.16b, v19.16b
trn1	v16.16b, v20.16b, v21.16b
trn2	v21.16b, v20.16b, v21.16b
trn1	v18.16b, v22.16b, v23.16b
trn2	v23.16b, v22.16b, v23.16b
trn1	v20.8h, v16.8h, v18.8h
trn2	v18.8h, v16.8h, v18.8h
trn1	v22.8h, v21.8h, v23.8h
trn2	v23.8h, v21.8h, v23.8h
trn1	v21.8h, v1.8h, v19.8h
trn2	v1.8h, v1.8h, v19.8h
trn1	v19.8h, v0.8h, v17.8h
trn2	v0.8h, v0.8h, v17.8h
trn1	v16.4s, v19.4s, v20.4s
trn2	v20.4s, v19.4s, v20.4s
trn1	v17.4s, v21.4s, v22.4s
trn2	v21.4s, v21.4s, v22.4s
trn2	v22.4s, v0.4s, v18.4s
trn1	v18.4s, v0.4s, v18.4s
trn1	v19.4s, v1.4s, v23.4s
trn2	v23.4s, v1.4s, v23.4s
trn1	v0.16b, v24.16b, v25.16b
trn2	v1.16b, v24.16b, v25.16b
trn1	v25.16b, v26.16b, v27.16b
trn2	v27.16b, v26.16b, v27.16b
trn1	v24.16b, v28.16b, v29.16b
trn2	v29.16b, v28.16b, v29.16b
trn1	v26.16b, v30.16b, v31.16b
trn2	v31.16b, v30.16b, v31.16b
trn1	v28.8h, v24.8h, v26.8h
trn2	v26.8h, v24.8h, v26.8h
trn1	v30.8h, v29.8h, v31.8h
trn2	v31.8h, v29.8h, v31.8h
trn1	v29.8h, v1.8h, v27.8h
trn2	v1.8h, v1.8h, v27.8h
trn1	v27.8h, v0.8h, v25.8h
trn2	v0.8h, v0.8h, v25.8h
trn1	v24.4s, v27.4s, v28.4s
trn2	v28.4s, v27.4s, v28.4s
trn1	v25.4s, v29.4s, v30.4s
trn2	v29.4s, v29.4s, v30.4s
trn2	v30.4s, v0.4s, v26.4s
trn1	v26.4s, v0.4s, v26.4s
trn1	v27.4s, v1.4s, v31.4s
trn2	v31.4s, v1.4s, v31.4s
bl	lpf_16_wd16_neon
cbz	x14, L_11fc
tbnz	w14, #0x6, L_1348
tbnz	w14, #0x4, L_13fc
ret	x15
L_11fc:
sub	x0, x0, x1, lsl #4
sub	x16, x0, #0x8
trn1	v18.16b, v16.16b, v17.16b
trn2	v19.16b, v16.16b, v17.16b
trn1	v17.16b, v0.16b, v1.16b
trn2	v1.16b, v0.16b, v1.16b
trn1	v16.16b, v2.16b, v3.16b
trn2	v3.16b, v2.16b, v3.16b
trn1	v0.16b, v4.16b, v5.16b
trn2	v5.16b, v4.16b, v5.16b
trn1	v2.8h, v16.8h, v0.8h
trn2	v0.8h, v16.8h, v0.8h
trn1	v4.8h, v3.8h, v5.8h
trn2	v5.8h, v3.8h, v5.8h
trn1	v3.8h, v19.8h, v1.8h
trn2	v19.8h, v19.8h, v1.8h
trn1	v1.8h, v18.8h, v17.8h
trn2	v18.8h, v18.8h, v17.8h
trn1	v16.4s, v1.4s, v2.4s
trn2	v2.4s, v1.4s, v2.4s
trn1	v17.4s, v3.4s, v4.4s
trn2	v3.4s, v3.4s, v4.4s
trn2	v4.4s, v18.4s, v0.4s
trn1	v0.4s, v18.4s, v0.4s
trn1	v1.4s, v19.4s, v5.4s
trn2	v5.4s, v19.4s, v5.4s
trn1	v18.16b, v6.16b, v7.16b
trn2	v19.16b, v6.16b, v7.16b
trn1	v7.16b, v8.16b, v9.16b
trn2	v9.16b, v8.16b, v9.16b
trn1	v6.16b, v10.16b, v11.16b
trn2	v11.16b, v10.16b, v11.16b
trn1	v8.16b, v30.16b, v31.16b
trn2	v31.16b, v30.16b, v31.16b
trn1	v10.8h, v6.8h, v8.8h
trn2	v8.8h, v6.8h, v8.8h
trn1	v30.8h, v11.8h, v31.8h
trn2	v31.8h, v11.8h, v31.8h
trn1	v11.8h, v19.8h, v9.8h
trn2	v19.8h, v19.8h, v9.8h
trn1	v9.8h, v18.8h, v7.8h
trn2	v18.8h, v18.8h, v7.8h
trn1	v6.4s, v9.4s, v10.4s
trn2	v10.4s, v9.4s, v10.4s
trn1	v7.4s, v11.4s, v30.4s
trn2	v11.4s, v11.4s, v30.4s
trn2	v30.4s, v18.4s, v8.4s
trn1	v8.4s, v18.4s, v8.4s
trn1	v9.4s, v19.4s, v31.4s
trn2	v31.4s, v19.4s, v31.4s
st1	{ v16.d }[0], [x16], x1
st1	{ v6.d }[0], [x0], x1
st1	{ v17.d }[0], [x16], x1
st1	{ v7.d }[0], [x0], x1
st1	{ v0.d }[0], [x16], x1
st1	{ v8.d }[0], [x0], x1
st1	{ v1.d }[0], [x16], x1
st1	{ v9.d }[0], [x0], x1
st1	{ v2.d }[0], [x16], x1
st1	{ v10.d }[0], [x0], x1
st1	{ v3.d }[0], [x16], x1
st1	{ v11.d }[0], [x0], x1
st1	{ v4.d }[0], [x16], x1
st1	{ v30.d }[0], [x0], x1
st1	{ v5.d }[0], [x16], x1
st1	{ v31.d }[0], [x0], x1
st1	{ v16.d }[1], [x16], x1
st1	{ v6.d }[1], [x0], x1
st1	{ v17.d }[1], [x16], x1
st1	{ v7.d }[1], [x0], x1
st1	{ v0.d }[1], [x16], x1
st1	{ v8.d }[1], [x0], x1
st1	{ v1.d }[1], [x16], x1
st1	{ v9.d }[1], [x0], x1
st1	{ v2.d }[1], [x16], x1
st1	{ v10.d }[1], [x0], x1
st1	{ v3.d }[1], [x16], x1
st1	{ v11.d }[1], [x0], x1
st1	{ v4.d }[1], [x16], x1
st1	{ v30.d }[1], [x0], x1
st1	{ v5.d }[1], [x16], x1
st1	{ v31.d }[1], [x0], x1
ret	x15
L_1348:
sub	x16, x0, x1, lsl #4
sub	x16, x16, #0x4
trn1	v28.16b, v20.16b, v21.16b
trn2	v29.16b, v20.16b, v21.16b
trn1	v21.16b, v22.16b, v23.16b
trn2	v23.16b, v22.16b, v23.16b
trn1	v20.16b, v24.16b, v25.16b
trn2	v25.16b, v24.16b, v25.16b
trn1	v22.16b, v26.16b, v27.16b
trn2	v27.16b, v26.16b, v27.16b
trn1	v24.8h, v20.8h, v22.8h
trn2	v22.8h, v20.8h, v22.8h
trn1	v26.8h, v25.8h, v27.8h
trn2	v27.8h, v25.8h, v27.8h
trn1	v25.8h, v29.8h, v23.8h
trn2	v29.8h, v29.8h, v23.8h
trn1	v23.8h, v28.8h, v21.8h
trn2	v28.8h, v28.8h, v21.8h
trn1	v20.4s, v23.4s, v24.4s
trn2	v24.4s, v23.4s, v24.4s
trn1	v21.4s, v25.4s, v26.4s
trn2	v25.4s, v25.4s, v26.4s
trn2	v26.4s, v28.4s, v22.4s
trn1	v22.4s, v28.4s, v22.4s
trn1	v23.4s, v29.4s, v27.4s
trn2	v27.4s, v29.4s, v27.4s
add	x0, x16, x1, lsl #3
st1	{ v20.d }[0], [x16], x1
st1	{ v20.d }[1], [x0], x1
st1	{ v21.d }[0], [x16], x1
st1	{ v21.d }[1], [x0], x1
st1	{ v22.d }[0], [x16], x1
st1	{ v22.d }[1], [x0], x1
st1	{ v23.d }[0], [x16], x1
st1	{ v23.d }[1], [x0], x1
st1	{ v24.d }[0], [x16], x1
st1	{ v24.d }[1], [x0], x1
st1	{ v25.d }[0], [x16], x1
st1	{ v25.d }[1], [x0], x1
st1	{ v26.d }[0], [x16], x1
st1	{ v26.d }[1], [x0], x1
st1	{ v27.d }[0], [x16], x1
st1	{ v27.d }[1], [x0], x1
add	x0, x0, #0x4
ret	x15
L_13fc:
sub	x16, x0, x1, lsl #4
sub	x16, x16, #0x2
trn1	v26.16b, v22.16b, v23.16b
trn2	v27.16b, v22.16b, v23.16b
trn1	v28.16b, v24.16b, v25.16b
trn2	v29.16b, v24.16b, v25.16b
trn1	v22.8h, v26.8h, v28.8h
trn2	v24.8h, v26.8h, v28.8h
trn1	v23.8h, v27.8h, v29.8h
trn2	v25.8h, v27.8h, v29.8h
add	x0, x16, x1, lsl #3
st1	{ v22.s }[0], [x16], x1
st1	{ v22.s }[2], [x0], x1
st1	{ v23.s }[0], [x16], x1
st1	{ v23.s }[2], [x0], x1
st1	{ v24.s }[0], [x16], x1
st1	{ v24.s }[2], [x0], x1
st1	{ v25.s }[0], [x16], x1
st1	{ v25.s }[2], [x0], x1
st1	{ v22.s }[1], [x16], x1
st1	{ v22.s }[3], [x0], x1
st1	{ v23.s }[1], [x16], x1
st1	{ v23.s }[3], [x0], x1
st1	{ v24.s }[1], [x16], x1
st1	{ v24.s }[3], [x0], x1
st1	{ v25.s }[1], [x16], x1
st1	{ v25.s }[3], [x0], x1
add	x0, x0, #0x2
ret	x15
lpf_v_sb_y_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
ldr	w2, [x2, #0x8]
add	x5, x5, #0x80
orr	w7, w7, w2
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
L_149c:
tst	w6, #0xf
ld1	{ v0.16b }, [x4], #16
ld1	{ v1.16b }, [x3], #16
b.eq	L_155c
ld1r	{ v5.16b }, [x5]
add	x5, x5, #0x8
movi	v2.4s, #0xff
dup	v13.4s, w6
and	v0.16b, v0.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
cmtst	v3.16b, v1.16b, v2.16b
movi	v4.16b, #0x1
ld1r	{ v6.16b }, [x5]
sub	x5, x5, #0x8
bif	v1.16b, v0.16b, v3.16b
cmtst	v2.4s, v1.4s, v2.4s
mul	v1.4s, v1.4s, v4.4s
dup	v15.4s, w2
dup	v14.4s, w7
mov	x16, v2.d[0]
mov	x17, v2.d[1]
adds	x16, x16, x17
b.eq	L_155c
neg	v5.16b, v5.16b
adrp	x16, word_1248
add	x16, x16, :lo12:word_1248
ushr	v12.16b, v1.16b, #0x4
ld1	{ v16.4s }, [x16]
sshl	v3.16b, v1.16b, v5.16b
cmtst	v15.4s, v15.4s, v16.4s
movi	v7.16b, #0x2
umin	v3.16b, v3.16b, v6.16b
add	v0.16b, v1.16b, v7.16b
umax	v11.16b, v3.16b, v4.16b
add	v0.16b, v0.16b, v0.16b
cmtst	v14.4s, v14.4s, v16.4s
add	v10.16b, v0.16b, v11.16b
cmtst	v13.4s, v13.4s, v16.4s
and	v13.16b, v13.16b, v2.16b
tst	w2, #0xf
b.eq	L_1548
bl	lpf_v_16_16_neon
b	L_155c
L_1548:
tst	w7, #0xf
b.eq	L_1558
bl	lpf_v_8_16_neon
b	L_155c
L_1558:
bl	lpf_v_4_16_neon
L_155c:
lsr	w6, w6, #4
lsr	w7, w7, #4
lsr	w2, w2, #4
add	x0, x0, #0x10
cbnz	w6, L_149c
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
lpf_h_sb_y_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
ldr	w2, [x2, #0x8]
add	x5, x5, #0x80
orr	w7, w7, w2
sub	x3, x3, #0x4
lsl	x4, x4, #2
orr	w6, w6, w7
L_15b4:
tst	w6, #0xf
ld2	{ v0.s, v1.s }[0], [x3], x4
ld2	{ v0.s, v1.s }[1], [x3], x4
ld2	{ v0.s, v1.s }[2], [x3], x4
ld2	{ v0.s, v1.s }[3], [x3], x4
b.eq	L_1680
ld1r	{ v5.16b }, [x5]
add	x5, x5, #0x8
movi	v2.4s, #0xff
dup	v13.4s, w6
and	v0.16b, v0.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
cmtst	v3.16b, v1.16b, v2.16b
movi	v4.16b, #0x1
ld1r	{ v6.16b }, [x5]
sub	x5, x5, #0x8
bif	v1.16b, v0.16b, v3.16b
cmtst	v2.4s, v1.4s, v2.4s
mul	v1.4s, v1.4s, v4.4s
dup	v15.4s, w2
dup	v14.4s, w7
mov	x16, v2.d[0]
mov	x17, v2.d[1]
adds	x16, x16, x17
b.eq	L_1680
neg	v5.16b, v5.16b
adrp	x16, word_1248
add	x16, x16, :lo12:word_1248
ushr	v12.16b, v1.16b, #0x4
ld1	{ v16.4s }, [x16]
sshl	v3.16b, v1.16b, v5.16b
cmtst	v15.4s, v15.4s, v16.4s
movi	v7.16b, #0x2
umin	v3.16b, v3.16b, v6.16b
add	v0.16b, v1.16b, v7.16b
umax	v11.16b, v3.16b, v4.16b
add	v0.16b, v0.16b, v0.16b
cmtst	v14.4s, v14.4s, v16.4s
add	v10.16b, v0.16b, v11.16b
cmtst	v13.4s, v13.4s, v16.4s
and	v13.16b, v13.16b, v2.16b
tst	w2, #0xf
b.eq	L_1668
bl	lpf_h_16_16_neon
b	L_1684
L_1668:
tst	w7, #0xf
b.eq	L_1678
bl	lpf_h_8_16_neon
b	L_1684
L_1678:
bl	lpf_h_4_16_neon
b	L_1684
L_1680:
add	x0, x0, x1, lsl #4
L_1684:
lsr	w6, w6, #4
lsr	w7, w7, #4
lsr	w2, w2, #4
cbnz	w6, L_15b4
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
lpf_v_sb_uv_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
add	x5, x5, #0x80
sub	x4, x3, x4, lsl #2
orr	w6, w6, w7
L_16cc:
tst	w6, #0xf
ld1	{ v0.16b }, [x4], #16
ld1	{ v1.16b }, [x3], #16
b.eq	L_1774
ld1r	{ v5.16b }, [x5]
add	x5, x5, #0x8
movi	v2.4s, #0xff
dup	v13.4s, w6
and	v0.16b, v0.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
cmtst	v3.16b, v1.16b, v2.16b
movi	v4.16b, #0x1
ld1r	{ v6.16b }, [x5]
sub	x5, x5, #0x8
bif	v1.16b, v0.16b, v3.16b
cmtst	v2.4s, v1.4s, v2.4s
mul	v1.4s, v1.4s, v4.4s
dup	v14.4s, w7
mov	x16, v2.d[0]
mov	x17, v2.d[1]
adds	x16, x16, x17
b.eq	L_1774
neg	v5.16b, v5.16b
adrp	x16, word_1248
add	x16, x16, :lo12:word_1248
ushr	v12.16b, v1.16b, #0x4
ld1	{ v16.4s }, [x16]
sshl	v3.16b, v1.16b, v5.16b
movi	v7.16b, #0x2
umin	v3.16b, v3.16b, v6.16b
add	v0.16b, v1.16b, v7.16b
umax	v11.16b, v3.16b, v4.16b
add	v0.16b, v0.16b, v0.16b
cmtst	v14.4s, v14.4s, v16.4s
add	v10.16b, v0.16b, v11.16b
cmtst	v13.4s, v13.4s, v16.4s
and	v13.16b, v13.16b, v2.16b
tst	w7, #0xf
b.eq	L_1770
bl	lpf_v_6_16_neon
b	L_1774
L_1770:
bl	lpf_v_4_16_neon
L_1774:
lsr	w6, w6, #4
lsr	w7, w7, #4
add	x0, x0, #0x10
cbnz	w6, L_16cc
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
lpf_h_sb_uv_8bpc_neon:
mov	x11, x30
stp	d8, d9, [sp, #-0x40]!
stp	d10, d11, [sp, #0x10]
stp	d12, d13, [sp, #0x20]
stp	d14, d15, [sp, #0x30]
ldp	w6, w7, [x2]
add	x5, x5, #0x80
sub	x3, x3, #0x4
lsl	x4, x4, #2
orr	w6, w6, w7
L_17c0:
tst	w6, #0xf
ld2	{ v0.s, v1.s }[0], [x3], x4
ld2	{ v0.s, v1.s }[1], [x3], x4
ld2	{ v0.s, v1.s }[2], [x3], x4
ld2	{ v0.s, v1.s }[3], [x3], x4
b.eq	L_1874
ld1r	{ v5.16b }, [x5]
add	x5, x5, #0x8
movi	v2.4s, #0xff
dup	v13.4s, w6
and	v0.16b, v0.16b, v2.16b
and	v1.16b, v1.16b, v2.16b
cmtst	v3.16b, v1.16b, v2.16b
movi	v4.16b, #0x1
ld1r	{ v6.16b }, [x5]
sub	x5, x5, #0x8
bif	v1.16b, v0.16b, v3.16b
cmtst	v2.4s, v1.4s, v2.4s
mul	v1.4s, v1.4s, v4.4s
dup	v14.4s, w7
mov	x16, v2.d[0]
mov	x17, v2.d[1]
adds	x16, x16, x17
b.eq	L_1874
neg	v5.16b, v5.16b
adrp	x16, word_1248
add	x16, x16, :lo12:word_1248
ushr	v12.16b, v1.16b, #0x4
ld1	{ v16.4s }, [x16]
sshl	v3.16b, v1.16b, v5.16b
movi	v7.16b, #0x2
umin	v3.16b, v3.16b, v6.16b
add	v0.16b, v1.16b, v7.16b
umax	v11.16b, v3.16b, v4.16b
add	v0.16b, v0.16b, v0.16b
cmtst	v14.4s, v14.4s, v16.4s
add	v10.16b, v0.16b, v11.16b
cmtst	v13.4s, v13.4s, v16.4s
and	v13.16b, v13.16b, v2.16b
tst	w7, #0xf
b.eq	L_186c
bl	lpf_h_6_16_neon
b	L_1878
L_186c:
bl	lpf_h_4_16_neon
b	L_1878
L_1874:
add	x0, x0, x1, lsl #4
L_1878:
lsr	w6, w6, #4
lsr	w7, w7, #4
cbnz	w6, L_17c0
ldp	d14, d15, [sp, #0x30]
ldp	d12, d13, [sp, #0x20]
ldp	d10, d11, [sp, #0x10]
ldp	d8, d9, [sp], #0x40
ret	x11
	.section .rodata
word_1248:
	.size word_1248, 16
	.byte 1,0,0,0,2,0,0,0,4,0,0,0,8,0,0,0

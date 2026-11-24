	.text
adler32_neon:
lsr	w8, w0, #16
cmp	x2, #0x1
and	w16, w0, #0xffff
b.ne	L_4c
ldrb	w9, [x1]
mov	w10, #-0xfff1
mov	w11, #0xfff1
add	w9, w16, w9, uxtb
add	w10, w9, w10
cmp	w9, w11
csel	w9, w9, w10, lo
mov	w10, #0x8071
add	w8, w9, w8
movk	w10, #0x8007, lsl #16
umull	x10, w8, w10
lsr	x10, x10, #47
msub	w8, w10, w11, w8
add	w0, w9, w8, lsl #16
ret
L_4c:
cbz	x1, L_9c
cmp	x2, #0xf
b.hi	L_a4
cbz	x2, L_70
L_5c:
ldrb	w9, [x1], #0x1
subs	x2, x2, #0x1
add	w16, w16, w9
add	w8, w16, w8
b.ne	L_5c
L_70:
mov	w9, #0x8071
mov	w11, #0xfff1
movk	w9, #0x8007, lsl #16
umull	x10, w16, w9
umull	x9, w8, w9
lsr	x10, x10, #47
lsr	x9, x9, #47
msub	w10, w10, w11, w16
msub	w8, w9, w11, w8
orr	w0, w10, w8, lsl #16
ret
L_9c:
mov	w0, #0x1
ret
L_a4:
ands	w9, w1, #0x1f
mov	w10, #0x20
sub	w11, w10, w9
ands	w12, w1, #0x1f
mov	w10, #0x15b0
csel	w9, wzr, w11, eq
cbz	w12, L_f0
add	w12, w9, #0x10
cmp	x2, x12
b.lo	L_f0
mov	x10, x1
L_d0:
ldrb	w12, [x10], #0x1
subs	x11, x11, #0x1
add	w16, w16, w12
add	w8, w16, w8
b.ne	L_d0
mov	w10, #0x15b0
sub	w10, w10, w9
b	L_f4
L_f0:
mov	w9, wzr
L_f4:
mov	w17, w9
cmp	x2, x17
b.ls	L_308
mov	w13, #0x8071
mov	w11, #0x15b0
adrp	x12, taps
add	x12, x12, :lo12:taps
movk	w13, #0x8007, lsl #16
mov	w14, #0xfff1
mov	w15, w9
b	L_1c4
L_120:
shl	v0.4s, v0.4s, #0x4
add	v17.4s, v0.4s, v17.4s
mov	v0.16b, v18.16b
L_12c:
movi	v18.2d, #0000000000000000
addp	v0.4s, v0.4s, v0.4s
mov	v18.s[0], w8
mov	x8, x12
ld1	{ v19.8h, v20.8h, v21.8h, v22.8h }, [x8], #64
ld1	{ v23.8h, v24.8h, v25.8h, v26.8h }, [x8]
add	v17.4s, v17.4s, v18.4s
umlal2	v17.4s, v19.8h, v7.8h
umlal	v17.4s, v19.4h, v7.4h
umlal2	v17.4s, v20.8h, v16.8h
umlal	v17.4s, v20.4h, v16.4h
umlal2	v17.4s, v21.8h, v6.8h
umlal	v17.4s, v21.4h, v6.4h
umlal2	v17.4s, v22.8h, v5.8h
umlal	v17.4s, v22.4h, v5.4h
umlal2	v17.4s, v23.8h, v4.8h
umlal	v17.4s, v23.4h, v4.4h
umlal2	v17.4s, v24.8h, v3.8h
umlal	v17.4s, v24.4h, v3.4h
umlal2	v17.4s, v25.8h, v2.8h
umlal	v17.4s, v25.4h, v2.4h
umlal2	v17.4s, v26.8h, v1.8h
umlal	v17.4s, v26.4h, v1.4h
addp	v1.4s, v17.4s, v17.4s
addp	v0.2s, v0.2s, v1.2s
mov	w8, v0.s[1]
fmov	w16, s0
umull	x17, w16, w13
umull	x18, w8, w13
lsr	x17, x17, #47
lsr	x18, x18, #47
msub	w16, w17, w14, w16
and	w17, w10, #0x7ffffff0
msub	w8, w18, w14, w8
add	w17, w17, w15
cmp	x2, x17
mov	w15, w17
b.ls	L_308
L_1c4:
cmp	w15, w9
sub	w18, w2, w15
csel	w10, w10, w11, eq
cmp	w18, w10
csel	w10, w18, w10, lt
cmp	w10, #0xf
b.le	L_304
movi	v0.2d, #0000000000000000
movi	v1.2d, #0000000000000000
cmp	w10, #0x40
mov	v0.s[0], w16
add	x16, x1, x17
b.hs	L_224
movi	v2.2d, #0000000000000000
movi	v3.2d, #0000000000000000
movi	v4.2d, #0000000000000000
movi	v5.2d, #0000000000000000
movi	v6.2d, #0000000000000000
movi	v16.2d, #0000000000000000
movi	v7.2d, #0000000000000000
movi	v17.2d, #0000000000000000
ubfx	w17, w10, #4, #2
cbnz	w17, L_2a8
b	L_12c
L_224:
lsr	w18, w10, #6
movi	v7.2d, #0000000000000000
movi	v17.2d, #0000000000000000
movi	v16.2d, #0000000000000000
movi	v6.2d, #0000000000000000
movi	v5.2d, #0000000000000000
movi	v4.2d, #0000000000000000
lsl	x0, x18, #6
movi	v3.2d, #0000000000000000
movi	v2.2d, #0000000000000000
L_24c:
ld1	{ v18.16b, v19.16b, v20.16b, v21.16b }, [x16], #64
add	v17.4s, v0.4s, v17.4s
subs	x18, x18, #0x1
uaddlp	v22.8h, v20.16b
uaddlp	v23.8h, v21.16b
uaddw	v7.8h, v7.8h, v18.8b
uaddw2	v16.8h, v16.8h, v18.16b
uaddw	v6.8h, v6.8h, v19.8b
uaddw2	v5.8h, v5.8h, v19.16b
uaddw	v4.8h, v4.8h, v20.8b
uaddw2	v3.8h, v3.8h, v20.16b
uaddw	v2.8h, v2.8h, v21.8b
uadalp	v22.8h, v18.16b
uaddw2	v1.8h, v1.8h, v21.16b
uadalp	v23.8h, v19.16b
uadalp	v0.4s, v22.8h
uadalp	v0.4s, v23.8h
b.ne	L_24c
shl	v17.4s, v17.4s, #0x6
add	x16, x1, x17
add	x16, x16, x0
ubfx	w17, w10, #4, #2
cbz	w17, L_12c
L_2a8:
ldr	q19, [x16]
mov	v18.16b, v0.16b
cmp	w17, #0x1
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
uadalp	v18.4s, v20.8h
b.eq	L_120
ldr	q19, [x16, #0x10]
add	v0.4s, v18.4s, v0.4s
cmp	w17, #0x2
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
uadalp	v18.4s, v20.8h
b.eq	L_120
ldr	q19, [x16, #0x20]
add	v0.4s, v18.4s, v0.4s
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
uadalp	v18.4s, v20.8h
b	L_120
L_304:
mov	w17, w15
L_308:
subs	x9, x2, x17
b.ls	L_354
add	x10, x1, x17
mov	w11, #0x1
L_318:
ldrb	w12, [x10], #0x1
cmp	x9, w11, uxtw
add	w11, w11, #0x1
add	w16, w16, w12
add	w8, w16, w8
b.hi	L_318
mov	w9, #0x8071
mov	w11, #0xfff1
movk	w9, #0x8007, lsl #16
umull	x10, w16, w9
umull	x9, w8, w9
lsr	x10, x10, #47
lsr	x9, x9, #47
msub	w16, w10, w11, w16
msub	w8, w9, w11, w8
L_354:
orr	w0, w16, w8, lsl #16
ret
adler32_fold_copy_neon:
lsr	w8, w0, #16
cmp	x3, #0x1
and	w10, w0, #0xffff
b.ne	L_3b0
ldrb	w9, [x2]
cbz	x1, L_378
strb	w9, [x1]
L_378:
add	w9, w10, w9, uxtb
mov	w10, #-0xfff1
mov	w11, #0xfff1
add	w10, w9, w10
cmp	w9, w11
csel	w9, w9, w10, lo
mov	w10, #0x8071
add	w8, w9, w8
movk	w10, #0x8007, lsl #16
umull	x10, w8, w10
lsr	x10, x10, #47
msub	w8, w10, w11, w8
add	w0, w9, w8, lsl #16
ret
L_3b0:
cbz	x2, L_3e0
cmp	x3, #0xf
b.hi	L_3e8
cbz	x1, L_47c
cbz	x3, L_8cc
L_3c4:
ldrb	w9, [x2], #0x1
subs	x3, x3, #0x1
add	w10, w10, w9
strb	w9, [x1], #0x1
add	w8, w10, w8
b.ne	L_3c4
b	L_8cc
L_3e0:
mov	w0, #0x1
ret
L_3e8:
ands	w9, w2, #0x1f
mov	w11, #0x20
sub	w12, w11, w9
ands	w13, w2, #0x1f
mov	w11, #0x15b0
csel	w9, wzr, w12, eq
cbz	w13, L_474
add	w13, w9, #0x10
cmp	x3, x13
b.lo	L_474
mov	x11, xzr
L_414:
ldrb	w13, [x2, x11]
add	x11, x11, #0x1
cmp	x12, x11
add	w10, w10, w13
add	w8, w10, w8
b.ne	L_414
cbz	x1, L_524
sub	w11, w9, #0x1
mov	w12, w9
mov	x13, x1
cmp	w11, #0x7
mov	x14, x2
b.lo	L_514
sub	x12, x1, x2
mov	x13, x1
mov	x14, x2
cmp	x12, #0x20
mov	w12, w9
b.lo	L_514
cmp	w11, #0x1f
add	x11, x11, #0x1
b.hs	L_498
mov	x15, xzr
b	L_4d0
L_474:
mov	w9, wzr
b	L_52c
L_47c:
cbz	x3, L_8cc
L_480:
ldrb	w9, [x2], #0x1
subs	x3, x3, #0x1
add	w10, w10, w9
add	w8, w10, w8
b.ne	L_480
b	L_8cc
L_498:
and	x15, x11, #0x1ffffffe0
add	x12, x2, #0x10
add	x13, x1, #0x10
mov	x14, x15
L_4a8:
ldp	q0, q1, [x12, #-0x10]
subs	x14, x14, #0x20
add	x12, x12, #0x20
stp	q0, q1, [x13, #-0x10]
add	x13, x13, #0x20
b.ne	L_4a8
cmp	x11, x15
b.eq	L_524
tst	x11, #0x18
b.eq	L_508
L_4d0:
and	x16, x11, #0x1fffffff8
add	x17, x2, x15
add	x18, x1, x15
sub	w12, w9, w16
add	x13, x1, x16
add	x14, x2, x16
sub	x15, x15, x16
L_4ec:
ldr	d0, [x17], #0x8
adds	x15, x15, #0x8
str	d0, [x18], #0x8
b.ne	L_4ec
cmp	x11, x16
b.ne	L_514
b	L_524
L_508:
sub	w12, w9, w15
add	x13, x1, x15
add	x14, x2, x15
L_514:
ldrb	w11, [x14], #0x1
subs	w12, w12, #0x1
strb	w11, [x13], #0x1
b.ne	L_514
L_524:
mov	w11, #0x15b0
sub	w11, w11, w9
L_52c:
mov	w18, w9
cmp	x3, x18
b.ls	L_85c
mov	w14, #0x8071
mov	w12, #0x15b0
adrp	x13, taps
add	x13, x13, :lo12:taps
movk	w14, #0x8007, lsl #16
mov	w15, #0xfff1
mov	w16, w9
b	L_600
L_558:
shl	v0.4s, v0.4s, #0x4
add	v17.4s, v0.4s, v17.4s
mov	v0.16b, v18.16b
L_564:
movi	v18.2d, #0000000000000000
addp	v0.4s, v0.4s, v0.4s
mov	v18.s[0], w8
mov	x8, x13
ld1	{ v19.8h, v20.8h, v21.8h, v22.8h }, [x8], #64
ld1	{ v23.8h, v24.8h, v25.8h, v26.8h }, [x8]
add	v17.4s, v17.4s, v18.4s
umlal2	v17.4s, v19.8h, v5.8h
umlal	v17.4s, v19.4h, v5.4h
umlal2	v17.4s, v20.8h, v16.8h
umlal	v17.4s, v20.4h, v16.4h
umlal2	v17.4s, v21.8h, v7.8h
umlal	v17.4s, v21.4h, v7.4h
umlal2	v17.4s, v22.8h, v6.8h
umlal	v17.4s, v22.4h, v6.4h
umlal2	v17.4s, v23.8h, v4.8h
umlal	v17.4s, v23.4h, v4.4h
umlal2	v17.4s, v24.8h, v3.8h
umlal	v17.4s, v24.4h, v3.4h
umlal2	v17.4s, v25.8h, v2.8h
umlal	v17.4s, v25.4h, v2.4h
umlal2	v17.4s, v26.8h, v1.8h
umlal	v17.4s, v26.4h, v1.4h
addp	v1.4s, v17.4s, v17.4s
addp	v0.2s, v0.2s, v1.2s
mov	w8, v0.s[1]
fmov	w10, s0
umull	x17, w10, w14
umull	x18, w8, w14
lsr	x17, x17, #47
lsr	x18, x18, #47
msub	w10, w17, w15, w10
and	w17, w11, #0x7ffffff0
msub	w8, w18, w15, w8
add	w18, w17, w16
cmp	x3, x18
mov	w16, w18
mov	w17, w18
b.ls	L_860
L_600:
cmp	w16, w9
sub	w17, w3, w16
csel	w11, w11, w12, eq
cmp	w17, w11
csel	w11, w17, w11, lt
cmp	w11, #0xf
b.le	L_8f8
movi	v0.2d, #0000000000000000
movi	v1.2d, #0000000000000000
lsr	w0, w11, #6
ubfx	w17, w11, #4, #2
cmp	w11, #0x40
mov	v0.s[0], w10
cbz	x1, L_66c
add	x10, x1, x18
add	x18, x2, x18
b.hs	L_69c
movi	v2.2d, #0000000000000000
movi	v3.2d, #0000000000000000
movi	v4.2d, #0000000000000000
movi	v6.2d, #0000000000000000
movi	v7.2d, #0000000000000000
movi	v16.2d, #0000000000000000
movi	v5.2d, #0000000000000000
movi	v17.2d, #0000000000000000
cbnz	w17, L_71c
b	L_564
L_66c:
add	x10, x2, x18
b.hs	L_784
movi	v2.2d, #0000000000000000
movi	v3.2d, #0000000000000000
movi	v4.2d, #0000000000000000
movi	v6.2d, #0000000000000000
movi	v7.2d, #0000000000000000
movi	v16.2d, #0000000000000000
movi	v5.2d, #0000000000000000
movi	v17.2d, #0000000000000000
cbnz	w17, L_800
b	L_564
L_69c:
movi	v5.2d, #0000000000000000
movi	v17.2d, #0000000000000000
movi	v16.2d, #0000000000000000
movi	v7.2d, #0000000000000000
movi	v6.2d, #0000000000000000
movi	v4.2d, #0000000000000000
movi	v3.2d, #0000000000000000
movi	v2.2d, #0000000000000000
L_6bc:
ldp	q18, q19, [x18, #0x20]
add	v17.4s, v0.4s, v17.4s
ldp	q21, q22, [x18], #0x40
subs	x0, x0, #0x1
uaddlp	v20.8h, v18.16b
uaddlp	v23.8h, v19.16b
uaddw	v4.8h, v4.8h, v18.8b
uaddw	v5.8h, v5.8h, v21.8b
uaddw2	v16.8h, v16.8h, v21.16b
uaddw	v7.8h, v7.8h, v22.8b
uaddw2	v6.8h, v6.8h, v22.16b
uaddw2	v3.8h, v3.8h, v18.16b
uaddw	v2.8h, v2.8h, v19.8b
uadalp	v20.8h, v21.16b
uaddw2	v1.8h, v1.8h, v19.16b
stp	q21, q22, [x10]
uadalp	v23.8h, v22.16b
stp	q18, q19, [x10, #0x20]
add	x10, x10, #0x40
uadalp	v0.4s, v20.8h
uadalp	v0.4s, v23.8h
b.ne	L_6bc
shl	v17.4s, v17.4s, #0x6
cbz	w17, L_564
L_71c:
ldr	q19, [x18]
mov	v18.16b, v0.16b
cmp	w17, #0x1
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
str	q19, [x10]
uadalp	v18.4s, v20.8h
b.eq	L_558
ldr	q19, [x18, #0x10]
add	v0.4s, v18.4s, v0.4s
cmp	w17, #0x2
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
str	q19, [x10, #0x10]
uadalp	v18.4s, v20.8h
b.eq	L_558
ldr	q19, [x18, #0x20]
add	v0.4s, v18.4s, v0.4s
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
str	q19, [x10, #0x20]
uadalp	v18.4s, v20.8h
b	L_558
L_784:
movi	v5.2d, #0000000000000000
movi	v17.2d, #0000000000000000
lsl	x4, x0, #6
movi	v16.2d, #0000000000000000
movi	v7.2d, #0000000000000000
movi	v6.2d, #0000000000000000
movi	v4.2d, #0000000000000000
movi	v3.2d, #0000000000000000
movi	v2.2d, #0000000000000000
L_7a8:
ld1	{ v18.16b, v19.16b, v20.16b, v21.16b }, [x10], #64
add	v17.4s, v0.4s, v17.4s
subs	x0, x0, #0x1
uaddlp	v22.8h, v20.16b
uaddlp	v23.8h, v21.16b
uaddw	v5.8h, v5.8h, v18.8b
uaddw2	v16.8h, v16.8h, v18.16b
uaddw	v7.8h, v7.8h, v19.8b
uaddw2	v6.8h, v6.8h, v19.16b
uaddw	v4.8h, v4.8h, v20.8b
uaddw2	v3.8h, v3.8h, v20.16b
uaddw	v2.8h, v2.8h, v21.8b
uadalp	v22.8h, v18.16b
uaddw2	v1.8h, v1.8h, v21.16b
uadalp	v23.8h, v19.16b
uadalp	v0.4s, v22.8h
uadalp	v0.4s, v23.8h
b.ne	L_7a8
shl	v17.4s, v17.4s, #0x6
add	x10, x2, x18
add	x10, x10, x4
cbz	w17, L_564
L_800:
ldr	q19, [x10]
mov	v18.16b, v0.16b
cmp	w17, #0x1
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
uadalp	v18.4s, v20.8h
b.eq	L_558
ldr	q19, [x10, #0x10]
add	v0.4s, v18.4s, v0.4s
cmp	w17, #0x2
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
uadalp	v18.4s, v20.8h
b.eq	L_558
ldr	q19, [x10, #0x20]
add	v0.4s, v18.4s, v0.4s
uaddlp	v20.8h, v19.16b
uaddw	v2.8h, v2.8h, v19.8b
uaddw2	v1.8h, v1.8h, v19.16b
uadalp	v18.4s, v20.8h
b	L_558
L_85c:
mov	w17, w9
L_860:
subs	x11, x3, x18
b.ls	L_908
L_868:
add	x9, x2, x18
mov	w12, #0x1
mov	x13, x2
L_874:
ldrb	w14, [x13, x18]
cmp	x11, w12, uxtw
add	w12, w12, #0x1
add	x13, x13, #0x1
add	w10, w10, w14
add	w8, w10, w8
b.hi	L_874
cbz	x1, L_8cc
cmp	x3, x18
b.eq	L_8cc
add	w13, w17, #0x1
sub	x11, x3, x13
add	x12, x11, #0x1
add	x11, x1, x18
cmp	x12, #0x8
b.hs	L_910
L_8b4:
add	w12, w17, #0x1
L_8b8:
ldrb	w13, [x9], #0x1
cmp	x3, w12, uxtw
add	w12, w12, #0x1
strb	w13, [x11], #0x1
b.ne	L_8b8
L_8cc:
mov	w9, #0x8071
mov	w12, #0xfff1
movk	w9, #0x8007, lsl #16
umull	x11, w10, w9
umull	x9, w8, w9
lsr	x11, x11, #47
lsr	x9, x9, #47
msub	w10, w11, w12, w10
msub	w8, w9, w12, w8
orr	w0, w10, w8, lsl #16
ret
L_8f8:
mov	w18, w16
mov	w17, w16
subs	x11, x3, x18
b.hi	L_868
L_908:
orr	w0, w10, w8, lsl #16
ret
L_910:
mov	w14, #-0x2
sub	x13, x3, x13
sub	w14, w14, w17
cmp	w14, w13
b.lo	L_8b4
lsr	x13, x13, #32
cbnz	x13, L_8b4
sub	x13, x1, x2
cmp	x13, #0x20
b.lo	L_8b4
cmp	x12, #0x20
b.hs	L_948
mov	x13, xzr
b	L_984
L_948:
and	x13, x12, #0xffffffffffffffe0
add	x15, x18, #0x10
add	x14, x2, x15
add	x15, x1, x15
mov	x16, x13
L_95c:
ldp	q0, q1, [x14, #-0x10]
subs	x16, x16, #0x20
add	x14, x14, #0x20
stp	q0, q1, [x15, #-0x10]
add	x15, x15, #0x20
b.ne	L_95c
cmp	x12, x13
b.eq	L_8cc
tst	x12, #0x18
b.eq	L_9c0
L_984:
and	x14, x12, #0xfffffffffffffff8
add	x16, x18, x13
add	x11, x11, x14
add	x9, x9, x14
add	w17, w17, w14
add	x15, x2, x16
add	x16, x1, x16
sub	x13, x13, x14
L_9a4:
ldr	d0, [x15], #0x8
adds	x13, x13, #0x8
str	d0, [x16], #0x8
b.ne	L_9a4
cmp	x12, x14
b.eq	L_8cc
b	L_8b4
L_9c0:
add	x11, x11, x13
add	x9, x9, x13
add	w17, w17, w13
b	L_8b4
	.section .rodata
	.p2align 6
taps:
	.size taps, 128
	.byte 64,0,63,0,62,0,61,0,60,0,59,0,58,0,57,0
	.byte 56,0,55,0,54,0,53,0,52,0,51,0,50,0,49,0
	.byte 48,0,47,0,46,0,45,0,44,0,43,0,42,0,41,0
	.byte 40,0,39,0,38,0,37,0,36,0,35,0,34,0,33,0
	.byte 32,0,31,0,30,0,29,0,28,0,27,0,26,0,25,0
	.byte 24,0,23,0,22,0,21,0,20,0,19,0,18,0,17,0
	.byte 16,0,15,0,14,0,13,0,12,0,11,0,10,0,9,0
	.byte 8,0,7,0,6,0,5,0,4,0,3,0,2,0,1,0

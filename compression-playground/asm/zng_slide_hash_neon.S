	.text
slide_hash_neon:
ldr	w8, [x0, #0x40]
ldr	x9, [x0, #0x68]
mov	x10, #-0x400
dup	v0.8h, w8
L_10:
mov	x11, x9
adds	x10, x10, #0x1
ld1	{ v1.8h, v2.8h, v3.8h, v4.8h }, [x11], #64
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x11]
uqsub	v20.8h, v1.8h, v0.8h
uqsub	v21.8h, v2.8h, v0.8h
uqsub	v22.8h, v3.8h, v0.8h
uqsub	v23.8h, v4.8h, v0.8h
uqsub	v1.8h, v16.8h, v0.8h
uqsub	v2.8h, v17.8h, v0.8h
uqsub	v3.8h, v18.8h, v0.8h
uqsub	v4.8h, v19.8h, v0.8h
st1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x9]
add	x9, x9, #0x80
st1	{ v1.8h, v2.8h, v3.8h, v4.8h }, [x11]
b.lo	L_10
ldr	x9, [x0, #0x60]
ubfx	x8, x8, #6, #10
L_58:
mov	x10, x9
subs	x8, x8, #0x1
ld1	{ v1.8h, v2.8h, v3.8h, v4.8h }, [x10], #64
ld1	{ v16.8h, v17.8h, v18.8h, v19.8h }, [x10]
uqsub	v20.8h, v1.8h, v0.8h
uqsub	v21.8h, v2.8h, v0.8h
uqsub	v22.8h, v3.8h, v0.8h
uqsub	v23.8h, v4.8h, v0.8h
uqsub	v1.8h, v16.8h, v0.8h
uqsub	v2.8h, v17.8h, v0.8h
uqsub	v3.8h, v18.8h, v0.8h
uqsub	v4.8h, v19.8h, v0.8h
st1	{ v20.8h, v21.8h, v22.8h, v23.8h }, [x9]
add	x9, x9, #0x80
st1	{ v1.8h, v2.8h, v3.8h, v4.8h }, [x10]
b.ne	L_58
ret

	.text
adler32_neon:
mov	w6, #0x8071
movk	w6, #0x8007, lsl #16
mov	w7, #0xfff1
and	w4, w0, #0xffff
lsr	w5, w0, #16
lsr	x10, x2, #5
adrp	x3, factors
add	x3, x3, :lo12:factors
ld1	{ v6.16b, v7.16b }, [x3]
add	x0, x1, x2
cbz	x10, final_accum32
mov	x11, #0xad
movi	v16.4s, #0x0
great_than_32:
cmp	x10, #0xad
csel	x11, x10, x11, le
mov	v2.16b, v16.16b
mov	v3.16b, v16.16b
mov	v2.s[0], w4
mov	v3.s[0], w5
add	x8, x1, x11, lsl #5
accum32_neon:
ld1	{ v4.16b, v5.16b }, [x1]
add	x1, x1, #0x20
shl	v20.4s, v2.4s, #0x5
add	v3.4s, v3.4s, v20.4s
uaddlp	v17.8h, v4.16b
uadalp	v17.8h, v5.16b
uadalp	v2.4s, v17.8h
umull	v20.8h, v6.8b, v4.8b
umlal2	v20.8h, v6.16b, v4.16b
umlal	v20.8h, v7.8b, v5.8b
umlal2	v20.8h, v7.16b, v5.16b
uadalp	v3.4s, v20.8h
cmp	x1, x8
b.ne	accum32_neon
uaddlv	d2, v2.4s
uaddlv	d3, v3.4s
fmov	x4, d2
fmov	x5, d3
umull	x8, w4, w6
lsr	x8, x8, #47
msub	w4, w8, w7, w4
umull	x8, w5, w6
lsr	x8, x8, #47
msub	w5, w8, w7, w5
sub	x10, x10, x11
cbnz	x10, great_than_32
final_accum32:
and	x2, x2, #0x1f
cbz	x2, end_func
accum32_body:
cmp	x1, x0
b.eq	end_func
ldrb	w8, [x1], #0x1
add	w4, w4, w8
add	w5, w5, w4
b	accum32_body
end_func:
umull	x8, w4, w6
lsr	x8, x8, #47
msub	w4, w8, w7, w4
umull	x8, w5, w6
lsr	x8, x8, #47
msub	w5, w8, w7, w5
orr	w0, w4, w5, lsl #16
ret
	.section .rodata.cst16
factors:
	.byte 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17
	.byte 16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1

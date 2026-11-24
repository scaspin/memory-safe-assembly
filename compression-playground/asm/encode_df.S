	.text
encode_deflate_icf_aarch64:
cmp	x0, x1
b.hs	.done
ldp	x9, x4, [x2, #0x10]
cmp	x4, x9
b.lo	.done
ldr	w5, [x2, #0x8]
ldr	x10, [x2]
b	.loop_start
.loop:
ldr	x4, [x2, #0x18]
cmp	x4, x9
b.lo	.done
.loop_start:
ldrh	w8, [x0]
add	x0, x0, #0x4
ldur	w7, [x0, #-0x4]
and	x8, x8, #0x3ff
ldurh	w6, [x0, #-0x2]
add	x8, x8, #0x1f
ubfx	x7, x7, #10, #9
add	x14, x3, x8, lsl #2
ubfx	x6, x6, #3, #13
lsl	x7, x7, #2
ldr	w8, [x3, x8, lsl #2]
add	x13, x3, x7
ldrb	w12, [x14, #0x3]
and	x8, x8, #0xffffff
ldrh	w4, [x3, x7]
ldrb	w11, [x13, #0x3]
add	w12, w12, w5
ldrb	w13, [x13, #0x2]
lsl	x14, x8, x5
add	w5, w11, w12
lsl	x4, x4, x12
orr	x4, x4, x14
add	w7, w13, w5
lsl	x5, x6, x5
orr	x5, x5, x10
orr	x14, x4, x5
str	x14, [x2]
str	w7, [x2, #0x8]
str	x14, [x9]
ldr	w5, [x2, #0x8]
ldr	x10, [x2]
and	w14, w5, #0xfffffff8
ldr	x9, [x2, #0x10]
lsr	w15, w5, #3
lsr	x10, x10, x14
sub	w5, w5, w14
add	x9, x9, x15
str	x10, [x2]
str	w5, [x2, #0x8]
str	x9, [x2, #0x10]
cmp	x1, x0
b.hi	.loop
.done:
ret

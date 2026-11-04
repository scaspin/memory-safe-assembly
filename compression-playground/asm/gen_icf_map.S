	.text
gen_icf_map_h1_aarch64:
cmp	x2, #0x11f
b.ls	.fast_exit
stp	x29, x30, [sp, #-0x10]!
mov	x12, x0
mov	x6, x1
mov	x29, sp
ldrb	w0, [x12, #0x87]
mov	x1, #0x1268
ldr	x8, [x12]
mov	x3, x2
ldr	x7, [x12, #0x30]
ldr	w9, [x12, #0xc]
ldp	w11, w10, [x12, #0x4c]
add	x7, x7, x1
sub	x9, x8, x9
cbz	w0, .igzip_no_hist
b	.while_check1
nop
.igzip_no_hist:
ldrb	w1, [x8]
add	x4, x8, #0x1
ldrh	w0, [x6]
bfxil	w0, w1, #0, #10
strh	w0, [x6]
ldr	w0, [x6]
and	w0, w0, #0x3ff
orr	w0, w0, #0x7800
str	w0, [x6], #0x4
ldr	w0, [x8]
crc32cw	w0, wzr, w0
and	w5, w0, w10
sub	x1, x8, x9
mov	w2, #0x1
mov	x0, #0x1
strh	w1, [x7, x5, lsl #1]
strb	w2, [x12, #0x87]
b	.while_check2
.while_check1:
mov	x4, x8
mov	x0, #0x0
.while_check2:
sub	x3, x3, #0x120
add	x8, x8, x3
cmp	x4, x8
b.hs	.exit
mov	w13, #0x20
mov	w14, #0x1
b	.while_loop
nop
.new_match_found:
clz	w5, w2
add	w1, w0, #0xfe
sub	w5, w13, w5
cmp	w15, #0x2
sub	w5, w5, #0x2
b.ls	.skip_compute_dist_icf_code
lsl	w3, w14, w5
sub	w3, w3, #0x1
lsr	w0, w2, w5
and	w3, w3, w2
add	w2, w0, w5, lsl #1
.skip_compute_dist_icf_code:
mov	x0, x6
orr	w1, w1, w3, lsl #19
orr	w1, w1, w2, lsl #10
str	w1, [x0]
add	x4, x4, #0x1
add	x6, x6, #0x4
cmp	x4, x8
b.eq	.save_with_exit
.while_loop:
ldr	w0, [x4]
crc32cw	w0, wzr, w0
and	w0, w0, w10
sub	x1, x4, x9
lsl	x0, x0, #1
sub	w2, w1, #0x1
ldrh	w3, [x7, x0]
strh	w1, [x7, x0]
sub	w2, w2, w3
and	w2, w2, w11
add	w15, w2, #0x1
ldr	x0, [x4]
sub	x1, x4, w15, uxtw
ldr	x1, [x1]
eor	x0, x1, x0
rbit	x1, x0
cmp	x0, #0x0
clz	x1, x1
mov	w0, #0x8
lsr	w1, w1, #3
csel	w0, w1, w0, ne
cmp	w0, #0x3
mov	w3, #0x0
b.hi	.new_match_found
ldrb	w1, [x4]
mov	x0, x6
mov	w3, #0x0
mov	w2, #0x1e
orr	w1, w1, w3, lsl #19
orr	w1, w1, w2, lsl #10
str	w1, [x0]
add	x4, x4, #0x1
add	x6, x6, #0x4
cmp	x4, x8
b.ne	.while_loop
.save_with_exit:
ldr	x0, [x12]
sub	x0, x4, x0
.exit:
ldp	x29, x30, [sp], #0x10
ret
.fast_exit:
mov	x0, #0x0
ret

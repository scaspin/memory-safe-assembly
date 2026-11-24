	.text
isal_deflate_hash_aarch64:
sub	w5, w2, w4
and	w5, w5, #0xffff
ubfx	x4, x4, #0, #32
sub	x4, x4, #0x4
add	x6, x3, x4
cmp	x3, x6
b.hs	exit_func
mov	w7, #0x0
loop_start:
ldr	w2, [x3]
add	x3, x3, #0x1
cmp	x3, x6
crc32cw	w2, w7, w2
and	w2, w2, w1
strh	w5, [x0, x2, lsl #1]
add	w5, w5, #0x1
b.ne	loop_start
exit_func:
ret

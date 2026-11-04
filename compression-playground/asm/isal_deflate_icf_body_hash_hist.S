	.text
isal_deflate_icf_body_hash_hist_aarch64:
stp	x29, x30, [sp, #-0x50]!
mov	x29, sp
str	x24, [sp, #0x38]
ldr	w13, [x0, #0x8]
cbnz	w13, .stream_available
ldr	w1, [x0, #0x38]
cbz	w1, .done
add	x24, x0, #0x40
b	.state_flush_read_buffer
.stream_available:
stp	x19, x20, [x29, #0x10]
stp	x21, x22, [x29, #0x20]
str	x23, [x29, #0x30]
stp	x25, x26, [x29, #0x40]
ldr	x17, [x0, #0x30]
add	x24, x0, #0x40
mov	x11, x0
ldr	x19, [x0]
ldr	w25, [x0, #0xc]
mov	x0, #0x1268
add	x15, x17, x0
ldr	x0, [x17, #0x1258]
ldr	x12, [x17, #0x1250]
mov	x9, x19
and	x0, x0, #0xfffffffffffffffc
ldp	w22, w21, [x24, #0xc]
add	x13, x19, w13, uxtw
mov	x8, x12
add	x12, x12, x0
add	x0, x9, #0x120
sub	x20, x19, w25, uxtw
mov	w23, #0x1e
add	x14, x9, #0x1
cmp	x13, x0
b.ls	.while_loop_end
.while_loop:
cmp	x8, x12
b.hs	.state_create_hdr
ldr	w10, [x9]
mov	w0, w10
crc32cw	w0, wzr, w0
and	w0, w0, w21
sub	x1, x9, x20
lsl	x0, x0, #1
ldrh	w7, [x15, x0]
strh	w1, [x15, x0]
sub	w1, w1, w7
and	w7, w1, #0xffff
sub	w26, w7, #0x1
cmp	w26, w22
b.lo	.dist_vs_hist_size
.while_latter_part:
and	w10, w10, #0xff
mov	x9, x14
add	x8, x8, #0x4
add	x1, x17, w10, uxtb #2
ldr	w0, [x1, #0x8f8]
add	w0, w0, #0x1
str	w0, [x1, #0x8f8]
ldurh	w0, [x8, #-0x4]
bfxil	w0, w10, #0, #10
sturh	w0, [x8, #-0x4]
ldur	w0, [x8, #-0x4]
bfi	w0, w23, #10, #9
stur	w0, [x8, #-0x4]
ubfx	x0, x0, #16, #3
sturh	w0, [x8, #-0x2]
.while_loop_check:
add	x0, x9, #0x120
add	x14, x9, #0x1
cmp	x13, x0
b.hi	.while_loop
b	.while_loop_end
.dist_vs_hist_size:
mov	x1, x9
mov	w2, #0x102
sub	x0, x9, w7, uxth
mov	x3, #0x0
_compare_258_loop:
ldr	x4, [x0, x3]
ldr	x5, [x1, x3]
eor	x4, x5, x4
rbit	x4, x4
clz	x4, x4
lsr	x4, x4, #3
add	x3, x3, x4
cmp	x3, #0x101
ccmp	x4, #0x8, #0x0, ls
b.eq	_compare_258_loop
cmp	x3, #0x102
mov	x5, #0x102
csel	x3, x3, x5, ls
and	w1, w3, #0xffff
cmp	w1, #0x3
b.ls	.while_latter_part
ldur	w0, [x9, #0x1]
mov	x4, x9
add	x9, x9, w1, uxth
crc32cw	w0, wzr, w0
and	w0, w21, w0
sub	x14, x14, x20
strh	w14, [x15, x0, lsl #1]
ldr	w0, [x4, #0x2]!
crc32cw	w0, wzr, w0
and	w0, w21, w0
and	w3, w3, #0xffff
sub	x4, x4, x20
add	w3, w3, #0xfe
mov	w1, #0x0
strh	w4, [x15, x0, lsl #1]
cmp	w7, #0x2
ubfiz	x0, x3, #2, #17
add	x0, x17, x0
b.hi	.compute_dist_icf_code
.match_length_end:
ldr	w2, [x0, #0x8f8]
add	x4, x17, w26, uxtw #2
add	x8, x8, #0x4
add	w2, w2, #0x1
str	w2, [x0, #0x8f8]
ldr	w0, [x4, #0x880]
add	w0, w0, #0x1
str	w0, [x4, #0x880]
ldurh	w0, [x8, #-0x4]
bfxil	w0, w3, #0, #10
sturh	w0, [x8, #-0x4]
ldur	w0, [x8, #-0x4]
bfi	w0, w26, #10, #9
stur	w0, [x8, #-0x4]
lsr	w0, w0, #16
bfi	w0, w1, #3, #13
sturh	w0, [x8, #-0x2]
b	.while_loop_check
.compute_dist_icf_code:
clz	w1, w26
mov	w2, #0x1e
sub	w2, w2, w1
mov	w1, #0x1
lsl	w1, w1, w2
sub	w1, w1, #0x1
and	w1, w1, w26
lsr	w26, w26, w2
add	w26, w26, w2, lsl #1
and	w1, w1, #0x1fff
b	.match_length_end
.while_loop_end:
sub	x19, x9, x19
cmp	x19, #0x0
b.le	.skip_igzip_hist2
mov	w0, #0x1
strb	w0, [x11, #0x87]
.skip_igzip_hist2:
add	w19, w25, w19
ldr	w0, [x11, #0x38]
sub	x12, x12, x8
asr	x12, x12, #2
str	x9, [x11]
str	w19, [x11, #0xc]
sub	x9, x13, x9
str	w19, [x11, #0x48]
ldp	x25, x26, [x29, #0x40]
ldr	x23, [x29, #0x30]
ldp	x21, x22, [x29, #0x20]
ldp	x19, x20, [x29, #0x10]
str	w9, [x11, #0x8]
str	x8, [x17, #0x1250]
str	x12, [x17, #0x1258]
cbnz	w0, .state_flush_read_buffer
b	.done
.state_create_hdr:
mov	w0, #0x2
str	w0, [x24, #0x14]
sub	x19, x9, x19
cmp	x19, #0x0
b.le	.skip_igzip_hist
mov	w0, #0x1
strb	w0, [x11, #0x87]
.skip_igzip_hist:
add	w25, w25, w19
sub	x12, x12, x8
asr	x12, x12, #2
str	x9, [x11]
sub	x9, x13, x9
str	w25, [x11, #0xc]
str	w25, [x11, #0x48]
ldp	x25, x26, [x29, #0x40]
ldr	x23, [x29, #0x30]
ldp	x21, x22, [x29, #0x20]
ldp	x19, x20, [x29, #0x10]
str	w9, [x11, #0x8]
str	x8, [x17, #0x1250]
str	x12, [x17, #0x1258]
b	.done
.state_flush_read_buffer:
mov	w0, #0x4
str	w0, [x24, #0x14]
.done:
ldr	x24, [sp, #0x38]
ldp	x29, x30, [sp], #0x50
ret

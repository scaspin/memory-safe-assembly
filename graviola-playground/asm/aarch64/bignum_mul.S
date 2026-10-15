bignum_mul:
cbz             x0, Lbignum_mul_end
mov             x6, xzr
mov             x7, xzr
mov             x9, xzr
Lbignum_mul_outerloop:
mov             x8, xzr
add             x11, x9, #1
cmp             x11, x2
csel            x12, x11, x2, cc
subs            x11, x11, x4
csel            x11, x11, xzr, cs
subs            x10, x12, x11
bls             Lbignum_mul_innerend
lsl             x14, x11, #3
add             x14, x14, x3
sub             x15, x9, x12
lsl             x15, x15, #3
add             x15, x15, x5
Lbignum_mul_innerloop:
ldr             x11, [x14], #8
ldr             x12, [x15, x10, lsl #3]
mul             x13, x11, x12
umulh           x11, x11, x12
adds            x6, x6, x13
adcs            x7, x7, x11
adc             x8, x8, xzr
subs            x10, x10, #1
bne             Lbignum_mul_innerloop
Lbignum_mul_innerend:
str             x6, [x1, x9, lsl #3]
mov             x6, x7
mov             x7, x8
add             x9, x9, #1
cmp             x9, x0
bcc             Lbignum_mul_outerloop
Lbignum_mul_end:
ret

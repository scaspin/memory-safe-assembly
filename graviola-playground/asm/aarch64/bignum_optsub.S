bignum_optsub:
cbz             x0, Lbignum_optsub_end
cmp             x3, xzr
csetm           x3, ne
subs            x7, xzr, xzr
Lbignum_optsub_loop:
ldr             x5, [x2, x7]
ldr             x6, [x4, x7]
and             x6, x6, x3
sbcs            x5, x5, x6
str             x5, [x1, x7]
add             x7, x7, #8
sub             x0, x0, #1
cbnz            x0, Lbignum_optsub_loop
cset            x0, cc
Lbignum_optsub_end:
ret

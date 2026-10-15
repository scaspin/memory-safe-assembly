bignum_neg_p256:
    ldp             x4, x5, [x1]
    ldp             x6, x7, [x1, #16]
    orr             x3, x4, x5
    orr             x2, x6, x7
    orr             x2, x2, x3
    cmp             x2, #0
    csetm           x2, ne
    subs            x4, x2, x4
    and             x3, x2, #0x00000000ffffffff
    sbcs            x5, x3, x5
    sbcs            x6, xzr, x6
    and             x3, x2, #0xffffffff00000001
    sbc             x7, x3, x7
    stp             x4, x5, [x0]
    stp             x6, x7, [x0, #16]
ret

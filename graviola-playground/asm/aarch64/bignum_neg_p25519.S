bignum_neg_p25519:
    ldp             x2, x3, [x1]
    mov             x7, #-19
    orr             x6, x2, x3
    subs            x2, x7, x2
    mov             x7, #-1
    sbcs            x3, x7, x3
    ldp             x4, x5, [x1, #16]
    orr             x6, x6, x4
    sbcs            x4, x7, x4
    mov             x7, #0x7FFFFFFFFFFFFFFF
    orr             x6, x6, x5
    sbc             x5, x7, x5
    cmp             x6, xzr
    csel            x2, x2, xzr, ne
    csel            x3, x3, xzr, ne
    csel            x4, x4, xzr, ne
    csel            x5, x5, xzr, ne
    stp             x2, x3, [x0]
    stp             x4, x5, [x0, #16]
ret

bignum_madd_n25519:
    stp             x19, x20, [sp, #-16]!
    mov             x19, x0
    ldp             x13, x14, [x1]
    ldp             x7, x0, [x2]
    mul             x8, x13, x7
    umulh           x9, x13, x7
    mul             x16, x13, x0
    umulh           x10, x13, x0
    adds            x9, x9, x16
    ldp             x4, x5, [x2, #16]
    mul             x16, x13, x4
    umulh           x11, x13, x4
    adcs            x10, x10, x16
    mul             x16, x13, x5
    umulh           x12, x13, x5
    adcs            x11, x11, x16
    adc             x12, x12, xzr
    ldp             x15, x6, [x3]
    adds            x8, x8, x15
    adcs            x9, x9, x6
    ldp             x15, x6, [x3, #16]
    adcs            x10, x10, x15
    adcs            x11, x11, x6
    adc             x12, x12, xzr
    ldp             x15, x6, [x1, #16]
    mul             x16, x14, x7
    adds            x9, x9, x16
    mul             x16, x14, x0
    adcs            x10, x10, x16
    mul             x16, x14, x4
    adcs            x11, x11, x16
    mul             x16, x14, x5
    adcs            x12, x12, x16
    umulh           x13, x14, x5
    adc             x13, x13, xzr
    umulh           x16, x14, x7
    adds            x10, x10, x16
    umulh           x16, x14, x0
    adcs            x11, x11, x16
    umulh           x16, x14, x4
    adcs            x12, x12, x16
    adc             x13, x13, xzr
    mul             x16, x15, x7
    adds            x10, x10, x16
    mul             x16, x15, x0
    adcs            x11, x11, x16
    mul             x16, x15, x4
    adcs            x12, x12, x16
    mul             x16, x15, x5
    adcs            x13, x13, x16
    umulh           x14, x15, x5
    adc             x14, x14, xzr
    umulh           x16, x15, x7
    adds            x11, x11, x16
    umulh           x16, x15, x0
    adcs            x12, x12, x16
    umulh           x16, x15, x4
    adcs            x13, x13, x16
    adc             x14, x14, xzr
    mul             x16, x6, x7
    adds            x11, x11, x16
    mul             x16, x6, x0
    adcs            x12, x12, x16
    mul             x16, x6, x4
    adcs            x13, x13, x16
    mul             x16, x6, x5
    adcs            x14, x14, x16
    umulh           x15, x6, x5
    adc             x15, x15, xzr
    umulh           x16, x6, x7
    adds            x12, x12, x16
    umulh           x16, x6, x0
    adcs            x13, x13, x16
    umulh           x16, x6, x4
    adcs            x14, x14, x16
    adc             x15, x15, xzr
    stp             x8, x9, [x19]
    stp             x10, x11, [x19, #16]
    ldp             x19, x20, [sp], #16
ret

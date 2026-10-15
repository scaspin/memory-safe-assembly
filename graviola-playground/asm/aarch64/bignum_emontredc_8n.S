bignum_emontredc_8n:
    stp             x19, x20, [sp, #-16]!
    stp             x21, x22, [sp, #-16]!
    stp             x23, x24, [sp, #-16]!
    stp             x25, x26, [sp, #-16]!
    stp             x27, x28, [sp, #-16]!
    sub             sp, sp, #0x20
    lsr             x0, x0, #2
    mov             x26, x0
    subs            x12, x0, #0x1
    b.cc            Lbignum_emontredc_8n_end
    stp             x3, xzr, [sp]
    stp             x26, xzr, [sp, #16]
    mov             x28, xzr
    lsl             x0, x12, #5
Lbignum_emontredc_8n_outerloop:
    ldp             x3, xzr, [sp]
    ldp             x17, x19, [x1]
    ldp             x20, x21, [x1, #16]
    ldp             x8, x9, [x2]
    ldp             x10, x11, [x2, #16]
    ldr             q21, [x2, #16]
    mul             x4, x17, x3
    dup             v0.2d, x4
    uzp2            v3.4s, v21.4s, v0.4s
    xtn             v4.2s, v0.2d
    xtn             v5.2s, v21.2d
    mul             x12, x4, x8
    adds            x17, x17, x12
    umulh           x12, x4, x8
    mul             x13, x4, x9
    rev64           v1.4s, v21.4s
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v0.4s, v0.4s
    mul             v0.4s, v1.4s, v0.4s
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v1.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v0.2d, v0.2d, #32
    usra            v1.2d, v7.2d, #32
    umlal           v0.2d, v4.2s, v5.2s
    mov             x14, v0.d[0]
    mov             x15, v0.d[1]
    adcs            x19, x19, x13
    umulh           x13, x4, x9
    adcs            x20, x20, x14
    usra            v1.2d, v2.2d, #32
    mov             x14, v1.d[0]
    adcs            x21, x21, x15
    mov             x15, v1.d[1]
    adc             x22, xzr, xzr
    adds            x19, x19, x12
    mul             x5, x19, x3
    adcs            x20, x20, x13
    adcs            x21, x21, x14
    adc             x22, x22, x15
    dup             v0.2d, x5
    uzp2            v3.4s, v21.4s, v0.4s
    xtn             v4.2s, v0.2d
    xtn             v5.2s, v21.2d
    mul             x12, x5, x8
    adds            x19, x19, x12
    umulh           x12, x5, x8
    mul             x13, x5, x9
    rev64           v1.4s, v21.4s
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v0.4s, v0.4s
    mul             v0.4s, v1.4s, v0.4s
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v1.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v0.2d, v0.2d, #32
    usra            v1.2d, v7.2d, #32
    umlal           v0.2d, v4.2s, v5.2s
    mov             x14, v0.d[0]
    mov             x15, v0.d[1]
    adcs            x20, x20, x13
    umulh           x13, x5, x9
    adcs            x21, x21, x14
    usra            v1.2d, v2.2d, #32
    mov             x14, v1.d[0]
    adcs            x22, x22, x15
    mov             x15, v1.d[1]
    adc             x23, xzr, xzr
    adds            x20, x20, x12
    mul             x6, x20, x3
    dup             v0.2d, x6
    uzp2            v3.4s, v0.4s, v21.4s
    xtn             v4.2s, v21.2d
    xtn             v5.2s, v0.2d
    adcs            x21, x21, x13
    adcs            x22, x22, x14
    adc             x23, x23, x15
    stp             x4, x5, [x1]
    ldr             q20, [x1]
    ldr             q22, [x2, #32]
    ldr             q23, [x2, #48]
    rev64           v1.4s, v0.4s
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v21.4s, v21.4s
    mul             x12, x6, x8
    adds            x20, x20, x12
    mul             v0.4s, v1.4s, v21.4s
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v1.2d, v16.2s, v3.2s
    umulh           x12, x6, x8
    mul             x13, x6, x9
    uaddlp          v0.2d, v0.4s
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v0.2d, v0.2d, #32
    adcs            x21, x21, x13
    umulh           x13, x6, x9
    usra            v1.2d, v7.2d, #32
    umlal           v0.2d, v4.2s, v5.2s
    mov             x14, v0.d[0]
    mov             x15, v0.d[1]
    usra            v1.2d, v2.2d, #32
    adcs            x22, x22, x14
    adcs            x23, x23, x15
    mov             x14, v1.d[0]
    mov             x15, v1.d[1]
    adc             x24, xzr, xzr
    adds            x21, x21, x12
    mul             x7, x21, x3
    adcs            x22, x22, x13
    adcs            x23, x23, x14
    adc             x24, x24, x15
    stp             x6, x7, [x1, #16]
    ldr             q21, [x1, #16]
    uzp2            v3.4s, v22.4s, v20.4s
    xtn             v4.2s, v20.2d
    mul             x12, x7, x8
    mul             x13, x7, x9
    xtn             v5.2s, v22.2d
    rev64           v1.4s, v22.4s
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    mul             x14, x7, x10
    mul             x15, x7, x11
    uzp2            v16.4s, v20.4s, v20.4s
    mul             v0.4s, v1.4s, v20.4s
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v25.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    adds            x21, x21, x12
    umulh           x12, x7, x8
    adcs            x22, x22, x13
    umulh           x13, x7, x9
    shl             v24.2d, v0.2d, #32
    usra            v25.2d, v7.2d, #32
    umlal           v24.2d, v4.2s, v5.2s
    usra            v25.2d, v2.2d, #32
    adcs            x23, x23, x14
    umulh           x14, x7, x10
    adcs            x24, x24, x15
    umulh           x15, x7, x11
    uzp2            v3.4s, v23.4s, v21.4s
    xtn             v4.2s, v21.2d
    xtn             v5.2s, v23.2d
    rev64           v1.4s, v23.4s
    ldp             x8, x9, [x2, #32]
    ldp             x10, x11, [x2, #48]
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v21.4s, v21.4s
    mul             v0.4s, v1.4s, v21.4s
    adc             x25, xzr, xzr
    adds            x12, x22, x12
    adcs            x13, x23, x13
    adcs            x14, x24, x14
    adc             x15, x25, x15
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v27.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v26.2d, v0.2d, #32
    usra            v27.2d, v7.2d, #32
    umlal           v26.2d, v4.2s, v5.2s
    usra            v27.2d, v2.2d, #32
    cbz             x0, Lbignum_emontredc_8n_madddone
    mov             x27, x0
    cmp             x0, #0x20
    b.ne            Lbignum_emontredc_8n_maddloop_firstitr
Lbignum_emontredc_8n_maddloop_x0one:
    add             x2, x2, #0x20
    add             x1, x1, #0x20
    mul             x17, x4, x8
    mul             x22, x5, x9
    mul             x23, x6, x10
    mul             x24, x7, x11
    umulh           x16, x4, x8
    adds            x22, x22, x16
    umulh           x16, x5, x9
    adcs            x23, x23, x16
    umulh           x16, x6, x10
    adcs            x24, x24, x16
    umulh           x16, x7, x11
    adc             x25, x16, xzr
    ldp             x20, x21, [x1]
    adds            x12, x12, x20
    adcs            x13, x13, x21
    ldp             x20, x21, [x1, #16]
    adcs            x14, x14, x20
    adcs            x15, x15, x21
    adc             x16, xzr, xzr
    adds            x19, x22, x17
    adcs            x22, x23, x22
    adcs            x23, x24, x23
    adcs            x24, x25, x24
    adc             x25, xzr, x25
    adds            x20, x22, x17
    adcs            x21, x23, x19
    adcs            x22, x24, x22
    adcs            x23, x25, x23
    adcs            x24, xzr, x24
    adc             x25, xzr, x25
    adds            x17, x17, x12
    adcs            x19, x19, x13
    adcs            x20, x20, x14
    adcs            x21, x21, x15
    adcs            x22, x22, x16
    adcs            x23, x23, xzr
    adcs            x24, x24, xzr
    adc             x25, x25, xzr
    subs            x15, x6, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x10
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x23, x23, x14
    eor             x13, x13, x12
    adcs            x24, x24, x13
    adc             x25, x25, x12
    subs            x15, x4, x5
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x9, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x19, x19, x14
    eor             x13, x13, x12
    adcs            x20, x20, x13
    adcs            x21, x21, x12
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x5, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x22, x22, x14
    eor             x13, x13, x12
    adcs            x23, x23, x13
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x20, x20, x14
    eor             x13, x13, x12
    adcs            x21, x21, x13
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x5, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x13, x23, x12
    adcs            x14, x24, x12
    adc             x15, x25, x12
    mov             x12, x22
    stp             x17, x19, [x1]
    stp             x20, x21, [x1, #16]
    sub             x27, x27, #0x20
    b               Lbignum_emontredc_8n_madddone
Lbignum_emontredc_8n_maddloop_firstitr:
    mov             x16, v25.d[0]
    mov             x22, v24.d[1]
    mov             x20, v25.d[1]
    mov             x23, v26.d[0]
    mov             x21, v27.d[0]
    mov             x24, v26.d[1]
    mov             x3, v27.d[1]
    mov             x17, v24.d[0]
    adds            x22, x22, x16
    adcs            x23, x23, x20
    adcs            x24, x24, x21
    adc             x25, x3, xzr
    ldr             q22, [x2, #64]
    ldr             q23, [x2, #80]
    add             x2, x2, #0x20
    add             x1, x1, #0x20
    uzp2            v3.4s, v22.4s, v20.4s
    xtn             v4.2s, v20.2d
    xtn             v5.2s, v22.2d
    rev64           v1.4s, v22.4s
    ldp             x20, x21, [x1]
    adds            x12, x12, x20
    adcs            x13, x13, x21
    ldp             x20, x21, [x1, #16]
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v20.4s, v20.4s
    mul             v0.4s, v1.4s, v20.4s
    adcs            x14, x14, x20
    adcs            x15, x15, x21
    adc             x16, xzr, xzr
    adds            x19, x22, x17
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v25.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    adcs            x22, x23, x22
    adcs            x23, x24, x23
    adcs            x24, x25, x24
    adc             x25, xzr, x25
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v24.2d, v0.2d, #32
    usra            v25.2d, v7.2d, #32
    adds            x20, x22, x17
    adcs            x21, x23, x19
    adcs            x22, x24, x22
    adcs            x23, x25, x23
    umlal           v24.2d, v4.2s, v5.2s
    usra            v25.2d, v2.2d, #32
    adcs            x24, xzr, x24
    adc             x25, xzr, x25
    adds            x17, x17, x12
    adcs            x19, x19, x13
    uzp2            v3.4s, v23.4s, v21.4s
    xtn             v4.2s, v21.2d
    xtn             v5.2s, v23.2d
    rev64           v1.4s, v23.4s
    adcs            x20, x20, x14
    adcs            x21, x21, x15
    adcs            x22, x22, x16
    adcs            x23, x23, xzr
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v21.4s, v21.4s
    mul             v0.4s, v1.4s, v21.4s
    adcs            x24, x24, xzr
    adc             x25, x25, xzr
    subs            x15, x6, x7
    cneg            x15, x15, cc
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v27.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    csetm           x12, cc
    subs            x13, x11, x10
    cneg            x13, x13, cc
    mul             x14, x15, x13
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v26.2d, v0.2d, #32
    usra            v27.2d, v7.2d, #32
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    umlal           v26.2d, v4.2s, v5.2s
    usra            v27.2d, v2.2d, #32
    adcs            x23, x23, x14
    eor             x13, x13, x12
    adcs            x24, x24, x13
    adc             x25, x25, x12
    subs            x15, x4, x5
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x9, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x19, x19, x14
    eor             x13, x13, x12
    adcs            x20, x20, x13
    adcs            x21, x21, x12
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    stp             x17, x19, [x1]
    mov             x16, v25.d[0]
    mov             x26, v27.d[0]
    mov             x3, v25.d[1]
    mov             x17, v27.d[1]
    subs            x15, x5, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x22, x22, x14
    eor             x13, x13, x12
    adcs            x23, x23, x13
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x20, x20, x14
    eor             x13, x13, x12
    adcs            x21, x21, x13
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x5, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    stp             x20, x21, [x1, #16]
    mov             x20, v24.d[1]
    mov             x21, v26.d[0]
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x13, x23, x12
    adcs            x14, x24, x12
    adc             x15, x25, x12
    mov             x12, x22
    mov             x24, v26.d[1]
    sub             x27, x27, #0x20
    cmp             x27, #0x20
    b.eq            Lbignum_emontredc_8n_maddloop_last
Lbignum_emontredc_8n_maddloop:
    ldp             x8, x9, [x2, #32]
    ldp             x10, x11, [x2, #48]
    ldr             q22, [x2, #64]
    ldr             q23, [x2, #80]
    add             x2, x2, #0x20
    add             x1, x1, #0x20
    adds            x22, x20, x16
    adcs            x23, x21, x3
    adcs            x24, x24, x26
    adc             x25, x17, xzr
    mov             x17, v24.d[0]
    uzp2            v3.4s, v22.4s, v20.4s
    xtn             v4.2s, v20.2d
    xtn             v5.2s, v22.2d
    rev64           v1.4s, v22.4s
    ldp             x20, x21, [x1]
    adds            x12, x12, x20
    adcs            x13, x13, x21
    ldp             x20, x21, [x1, #16]
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v20.4s, v20.4s
    mul             v0.4s, v1.4s, v20.4s
    adcs            x14, x14, x20
    adcs            x15, x15, x21
    adc             x16, xzr, xzr
    adds            x19, x22, x17
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v25.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    adcs            x22, x23, x22
    adcs            x23, x24, x23
    adcs            x24, x25, x24
    adc             x25, xzr, x25
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v24.2d, v0.2d, #32
    usra            v25.2d, v7.2d, #32
    adds            x20, x22, x17
    adcs            x21, x23, x19
    adcs            x22, x24, x22
    adcs            x23, x25, x23
    umlal           v24.2d, v4.2s, v5.2s
    usra            v25.2d, v2.2d, #32
    adcs            x24, xzr, x24
    adc             x25, xzr, x25
    adds            x17, x17, x12
    adcs            x19, x19, x13
    uzp2            v3.4s, v23.4s, v21.4s
    xtn             v4.2s, v21.2d
    xtn             v5.2s, v23.2d
    rev64           v1.4s, v23.4s
    adcs            x20, x20, x14
    adcs            x21, x21, x15
    adcs            x22, x22, x16
    adcs            x23, x23, xzr
    umull           v6.2d, v4.2s, v5.2s
    umull           v7.2d, v4.2s, v3.2s
    uzp2            v16.4s, v21.4s, v21.4s
    mul             v0.4s, v1.4s, v21.4s
    adcs            x24, x24, xzr
    adc             x25, x25, xzr
    subs            x15, x6, x7
    cneg            x15, x15, cc
    movi            v2.2d, #0xffffffff
    usra            v7.2d, v6.2d, #32
    umull           v27.2d, v16.2s, v3.2s
    uaddlp          v0.2d, v0.4s
    csetm           x12, cc
    subs            x13, x11, x10
    cneg            x13, x13, cc
    mul             x14, x15, x13
    and             v2.16b, v7.16b, v2.16b
    umlal           v2.2d, v16.2s, v5.2s
    shl             v26.2d, v0.2d, #32
    usra            v27.2d, v7.2d, #32
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    umlal           v26.2d, v4.2s, v5.2s
    usra            v27.2d, v2.2d, #32
    adcs            x23, x23, x14
    eor             x13, x13, x12
    adcs            x24, x24, x13
    adc             x25, x25, x12
    subs            x15, x4, x5
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x9, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x19, x19, x14
    eor             x13, x13, x12
    adcs            x20, x20, x13
    adcs            x21, x21, x12
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    stp             x17, x19, [x1]
    mov             x16, v25.d[0]
    mov             x26, v27.d[0]
    mov             x3, v25.d[1]
    mov             x17, v27.d[1]
    subs            x15, x5, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x22, x22, x14
    eor             x13, x13, x12
    adcs            x23, x23, x13
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x20, x20, x14
    eor             x13, x13, x12
    adcs            x21, x21, x13
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x5, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    stp             x20, x21, [x1, #16]
    mov             x20, v24.d[1]
    mov             x21, v26.d[0]
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x13, x23, x12
    adcs            x14, x24, x12
    adc             x15, x25, x12
    mov             x12, x22
    mov             x24, v26.d[1]
    sub             x27, x27, #0x20
    cmp             x27, #0x20
    b.ne            Lbignum_emontredc_8n_maddloop
Lbignum_emontredc_8n_maddloop_last:
    ldp             x8, x9, [x2, #32]
    ldp             x10, x11, [x2, #48]
    add             x2, x2, #0x20
    add             x1, x1, #0x20
    adds            x22, x20, x16
    adcs            x23, x21, x3
    adcs            x24, x24, x26
    adc             x25, x17, xzr
    mov             x17, v24.d[0]
    ldp             x20, x21, [x1]
    adds            x12, x12, x20
    adcs            x13, x13, x21
    ldp             x20, x21, [x1, #16]
    adcs            x14, x14, x20
    adcs            x15, x15, x21
    adc             x16, xzr, xzr
    adds            x19, x22, x17
    adcs            x22, x23, x22
    adcs            x23, x24, x23
    adcs            x24, x25, x24
    adc             x25, xzr, x25
    adds            x20, x22, x17
    adcs            x21, x23, x19
    adcs            x22, x24, x22
    adcs            x23, x25, x23
    adcs            x24, xzr, x24
    adc             x25, xzr, x25
    adds            x17, x17, x12
    adcs            x19, x19, x13
    adcs            x20, x20, x14
    adcs            x21, x21, x15
    adcs            x22, x22, x16
    adcs            x23, x23, xzr
    adcs            x24, x24, xzr
    adc             x25, x25, xzr
    subs            x15, x6, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x10
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x23, x23, x14
    eor             x13, x13, x12
    adcs            x24, x24, x13
    adc             x25, x25, x12
    subs            x15, x4, x5
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x9, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x19, x19, x14
    eor             x13, x13, x12
    adcs            x20, x20, x13
    adcs            x21, x21, x12
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x5, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x22, x22, x14
    eor             x13, x13, x12
    adcs            x23, x23, x13
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x20, x20, x14
    eor             x13, x13, x12
    adcs            x21, x21, x13
    adcs            x22, x22, x12
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x4, x7
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x11, x8
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x23, x23, x12
    adcs            x24, x24, x12
    adc             x25, x25, x12
    subs            x15, x5, x6
    cneg            x15, x15, cc
    csetm           x12, cc
    subs            x13, x10, x9
    cneg            x13, x13, cc
    mul             x14, x15, x13
    umulh           x13, x15, x13
    cinv            x12, x12, cc
    cmn             x12, #0x1
    eor             x14, x14, x12
    adcs            x21, x21, x14
    eor             x13, x13, x12
    adcs            x22, x22, x13
    adcs            x13, x23, x12
    adcs            x14, x24, x12
    adc             x15, x25, x12
    mov             x12, x22
    stp             x17, x19, [x1]
    stp             x20, x21, [x1, #16]
    subs            x27, x27, #0x40
Lbignum_emontredc_8n_madddone:
    ldp             x17, x19, [x1, #32]
    ldp             x20, x21, [x1, #48]
    ldp             x26, xzr, [sp, #16]
    cmn             x28, x28
    adcs            x17, x17, x12
    adcs            x19, x19, x13
    adcs            x20, x20, x14
    adcs            x21, x21, x15
    csetm           x28, cs
    stp             x17, x19, [x1, #32]
    stp             x20, x21, [x1, #48]
    sub             x1, x1, x0
    sub             x2, x2, x0
    add             x1, x1, #0x20
    subs            x26, x26, #0x1
    stp             x26, xzr, [sp, #16]
    b.ne            Lbignum_emontredc_8n_outerloop
    neg             x0, x28
Lbignum_emontredc_8n_end:
    add             sp, sp, #0x20
    ldp             x27, x28, [sp], #16
    ldp             x25, x26, [sp], #16
    ldp             x23, x24, [sp], #16
    ldp             x21, x22, [sp], #16
    ldp             x19, x20, [sp], #16
ret

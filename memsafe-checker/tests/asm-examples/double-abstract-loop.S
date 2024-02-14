start: 
    add x3,x1,x2
    add x4,x1,#0
loop_1:
    ldr x5,[x1]
    add x1,x1,#1
    cmp x1,x3
    b.ne loop_1
loop_2:
    sub x1,x1,#1
    ldr x5,[x1]
    cmp x1,x4
    b.ne loop_2
add x4,x4,#4

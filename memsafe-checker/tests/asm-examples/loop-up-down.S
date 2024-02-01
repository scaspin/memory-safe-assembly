start: 
    add x3,x1,x2
    add x2,x1,#0
loop_1:
    ldr x5,[x1]
    add x1,x1,#1
    cmp x1,x3
    b.ne loop_1
loop_2:
    ldr x5,[x1]
    sub x1,x1,#1
    cmp x1,x2
    b.ne loop_2
add x4,x4,#4

.thumb

push {r4-r7,lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

ldr r0, [r4, #4]  @get the pointer to the class data
ldrb r0, [r0, #4] @get the class ID (byte)


ldr r3,AvoList
mov r2, #0x00
LoopStart:
ldrb r1,[r3, r2]
cmp r1,#0x00
beq NoBonus
cmp r0,r1
beq AvoBonus
add r2,#1
b LoopStart

AvoBonus:
ldrb r2, [r4, #0x16] @Spd
ldrb r3, [r4, #0x19] @Lck
lsr  r3, #0x01
add  r2, r3, r2
mov r1, #0x62
ldrh r0, [r4, r1] @Avoid
add r0, r2
strh r0, [r4,r1]

NoBonus:
pop {r4-r7, r15}

.ltorg
.pool
.align

AvoList:
@POIN AvoList

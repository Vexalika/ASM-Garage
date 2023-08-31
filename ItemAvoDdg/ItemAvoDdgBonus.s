@Items w/Avo,Crit Avo

.thumb
.global ItemAvoDdgBonus
.type ItemAvoDdgBonus, %function


@attack struct is passed in via r0 with the defense struct in r1

ItemAvoDdgBonus:
push {r4-r7,r14}

mov r4,r0
mov r5,r1

mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r2,#0xFF
and r0,r2
cmp r0,#0
beq End


ldr r3,=ItemAvoBonusList

AvoLoopStart:
ldrb r2,[r3]
cmp r2,#0
beq CheckCritAvo

cmp r2,r0
beq NextAtkrAvo

add r3,#3
b AvoLoopStart



NextAtkrAvo:
ldrb r0,[r3,#1]
cmp r0, #0
beq AtkrAvoBonus
cmp r0, #1
beq AtkrAvoPenalty
b CheckCritAvo


AtkrAvoBonus:
ldrb r1,[r3,#2] @Value

mov r3,r4		@Atkr
add r3, #0x62  	@Avo
ldrb r2,[r3]	
add r2,r1		@add given value
strb r2,[r3]	@store
b CheckCritAvo


AtkrAvoPenalty:
ldrb r1,[r3,#2]  @Value

mov r3,r4		@Atkr
add r3,#0x62  		@given stat
ldrb r2,[r3]	
cmp r2, r1
ble SetZeroAvoA

sub r2,r1		@subtract given value
strb r2,[r3]	@store
b CheckCritAvo

SetZeroAvoA:
mov r2, #0
strb r2,[r3]


CheckCritAvo:

mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r2,#0xFF
and r0,r2
cmp r0,#0
beq End

ldr r3,=ItemDdgBonusList

DdgLoopStart:
ldrb r2,[r3]
cmp r2,#0
beq End

cmp r2,r0
beq NextAtkrDdg

add r3,#3
b DdgLoopStart



NextAtkrDdg:
ldrb r0,[r3,#1]
cmp r0, #0
beq AtkrDdgBonus
cmp r0, #1
beq AtkrDdgPenalty
b End


AtkrDdgBonus:
ldrb r1,[r3,#2] @Value

mov r3,r4		@Atkr
add r3,#0x68  		@given stat
ldrb r2,[r3]	
add r2,r1		@add given value
strb r2,[r3]	@store
b End


AtkrDdgPenalty:
ldrb r1,[r3,#2] @Value

mov r3,r4		@Atkr
add r3,#0x68  		@given stat
ldrb r2,[r3]	
cmp r2, r1
ble SetZeroDdgA

sub r2,r1		@subtract given value
strb r2,[r3]	@store
b End

SetZeroDdgA:
mov r2, #0
strb r2,[r3]

End:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align


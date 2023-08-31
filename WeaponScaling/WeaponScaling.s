.thumb

.global WeaponScaleBonus
.type WeaponScaleBonus, %function


@attack struct is passed in via r0 with the defense struct in r1

WeaponScaleBonus:
push {r4-r7,r14}

mov r4,r0
mov r5,r1

mov r0,r4			 @atkr
add r0,#0x4A         @Item and uses
ldrh r0,[r0]         @
mov r2,#0xFF         @
and r0,r2            @Item ID
cmp r0,#0            @If no item go to defender
beq End    @

ldr r3,=WeaponScaleBonusList

AtkrLoopStart:
ldrb r2,[r3]
cmp r2,#0
beq End

cmp r2,r0
beq NextAtkr

add r3,#3
b AtkrLoopStart

NextAtkr:
mov r0,r4
ldrb r1,[r3,#1] 	@Scale stat byte
add r0,r1			@add to atkr struct
ldrb r0,[r0]		@load actual stat
ldrb r1,[r3,#2] 	@percent to scale by
mul r0,r1			@mul by percent
add r0, #0x63
mov r1, #100 

swi 6

mov r2,r0
mov r0,r4			@scale bonus
add r0,#0x5A	@Atack
ldrh r1,[r0]		@
add r1,r2			@Add bonus attack
strh r1,[r0] 		@store new Atack

End:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align


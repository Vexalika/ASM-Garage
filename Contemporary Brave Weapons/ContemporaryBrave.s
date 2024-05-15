.thumb
.equ AttackerBattleStruct, 0x203A4EC 
@r0 has Atkr/Dfnd struct


mov r3, r0
@vanilla code
ldr r0,[r0,#0x4C] @load the weapon ability 1 from battle struct
mov r1,#0x20 @0x20 is brave
and r0,r1 @check if weapon ability 1 has the brave bit set
cmp r0,#0x0 @if not, we branch to return false
bne RetFalse

ldr r0,[r3,#0x4C]	 @ Item and Uses
mov r1,#0xFF         @
and r0,r1            @Item ID

ldr r2,=ModernBraveWeaponList

ModernLoop:
ldr r1, [r2]
cmp r1,#0
beq RetTrue 

	cmp r0,r1
	beq ModernAttakerCheck

add r2, #1
b ModernLoop


ModernAttakerCheck:
ldr r0, =AttackerBattleStruct 
cmp r0, r3
beq RetTrue


RetFalse:
mov r0,#0
pop {r1}
bx r1
@code to return to where the original function would have returned to

RetTrue:
ldr r0,=0x802B0A1
bx r0
@code to return to the function and let it finish what it was doing
.ltorg
.align

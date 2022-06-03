# increments a counter idefinetly, but also writes to reg_mprj_datal
addi x1, x0, 0
addi x2, x0, 0
addi x3, x0, 0
addi x2, x0, -1 # x2 = 0xFFFF_FFFF
lui x3,0x30010 # x3 = 0x3001000 (GPIO write addr)
loop:
sw x2, 0(x3) // in reality we would need a sleep function in between here
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sw x0, 0(x3)
j loop

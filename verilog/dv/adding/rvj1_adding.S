# increments a counter idefinetly, but also writes to reg_mprj_datal
addi x1, x0, 0
lui x2,0xab610
lui x3,0x30004
sw x2, 0(x3)
loop:
addi x1, x1, 1
j loop

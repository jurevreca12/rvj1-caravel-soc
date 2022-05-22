.section .text
startup:
	la sp, _sstack
	jal ra, main

.global start
.extern _main
.global _set_imask
.global _get_imask
.global _get_fpscr
.global _nop
.global _sleep
.global _set_vbr
.global _set_fpscr
.global _set_cr
.global _vPortSaveFlopRegisters
.global _vPortRestoreFlopRegisters
.global _end

.section .stack, "w"
	.align  4
	.space  65536
stack_base:

.section .text, "ax"

start:
	MOV.L   _stack_base, SP
	MOV.L   __main, R0
	JSR     @R0
	NOP
loop:
	BRA     loop
	NOP

_set_imask:
	MOV.L   __imask, R0
	SHLL2   R4
	SHLL2   R4
	AND     R0, R4
	NOT     R0, R0
	STC     SR, R1
	AND     R0, R1
	OR      R4, R1
	LDC     R1, SR
	RTS
	NOP
_get_imask:
	MOV.L   __imask, R0
	STC     SR, R1
	AND     R0, R1
	SHLR2   R1
	SHLR2   R1
	RTS
	MOV     R1, R0
_get_fpscr:
	RTS
	STS     FPSCR, R0
_nop:
	RTS
	NOP
_sleep:
	SLEEP
	NOP
	RTS
	NOP
_set_vbr:
	LDC     R4, VBR
	RTS
	NOP
_set_fpscr:
	LDS     R4, FPSCR
	RTS
	NOP
_set_cr:
	LDC     R4, SR
	RTS
	NOP

	.align  4
__main:
	.long   _main
_stack_base:
	.long   stack_base
_end:
	.long   stack_base
__imask:
	.long   0x000000F0

.section .bss, "aw"

.section .text, "ax"

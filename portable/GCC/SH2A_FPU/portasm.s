/*
 * FreeRTOS Kernel V10.3.0
 * Copyright (C) 2020 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */

	.extern _pxCurrentTCB
	.extern _vTaskSwitchContext
	.extern _xTaskIncrementTick

	.global _vPortStartFirstTask
	.global _ulPortGetGBR
	.global _vPortYieldHandler
	.global _vPortPreemptiveTick
	.global _vPortCooperativeTick
	.global _vPortSaveFlopRegisters
	.global _vPortRestoreFlopRegisters

_vPortStartFirstTask:

	/* portRESTORE_CONTEXT_start */
	/* Get the address of the pxCurrentTCB variable. */
	mov.l	__pxCurrentTCB_vPortStartFirstTask, r0

	/* Get the address of the task stack from pxCurrentTCB. */
	mov.l	@r0, r0

	/* Get the task stack itself into the stack pointer. */
	mov.l	@r0, r15

	/* Restore system registers. */
	ldc.l	@r15+, gbr
	lds.l	@r15+, mach
	lds.l	@r15+, macl

	/* Restore r0 to r14 and PR */
	movml.l	@r15+, r15

	/* Pop the SR and PC to jump to the start of the task. */
	rte
	nop
	/* portRESTORE_CONTEXT_end */

	.align  4
__pxCurrentTCB_vPortStartFirstTask:
	.long   _pxCurrentTCB

/*-----------------------------------------------------------*/

_vPortYieldHandler:

	/* portSAVE_CONTEXT_start */
	/* Save r0 to r14 and pr. */
	movml.l r15, @-r15

	/* Save mac1, mach and gbr */
	sts.l	macl, @-r15
	sts.l	mach, @-r15
	stc.l	gbr, @-r15

	/* Get the address of pxCurrentTCB */
	mov.l	__pxCurrentTCB_vPortYieldHandler, r0

	/* Get the address of pxTopOfStack from the TCB. */
	mov.l	@r0, r0

	/* Save the stack pointer in pxTopOfStack. */
	mov.l	r15, @r0
	/* portSAVE_CONTEXT_end */

	mov.l	__vTaskSwitchContext_vPortYieldHandler, r0
	jsr		@r0
	nop

	/* portRESTORE_CONTEXT_start */
	/* Get the address of the pxCurrentTCB variable. */
	mov.l	__pxCurrentTCB_vPortYieldHandler, r0

	/* Get the address of the task stack from pxCurrentTCB. */
	mov.l	@r0, r0

	/* Get the task stack itself into the stack pointer. */
	mov.l	@r0, r15

	/* Restore system registers. */
	ldc.l	@r15+, gbr
	lds.l	@r15+, mach
	lds.l	@r15+, macl

	/* Restore r0 to r14 and PR */
	movml.l	@r15+, r15

	/* Pop the SR and PC to jump to the start of the task. */
	rte
	nop
	/* portRESTORE_CONTEXT_end */

	.align  4
__pxCurrentTCB_vPortYieldHandler:
	.long   _pxCurrentTCB
__vTaskSwitchContext_vPortYieldHandler:
	.long   _vTaskSwitchContext

/*-----------------------------------------------------------*/

_vPortPreemptiveTick:

	/* portSAVE_CONTEXT_start */
	/* Save r0 to r14 and pr. */
	movml.l r15, @-r15

	/* Save mac1, mach and gbr */
	sts.l	macl, @-r15
	sts.l	mach, @-r15
	stc.l	gbr, @-r15

	/* Get the address of pxCurrentTCB */
	mov.l	__pxCurrentTCB_vPortPreemptiveTick, r0

	/* Get the address of pxTopOfStack from the TCB. */
	mov.l	@r0, r0

	/* Save the stack pointer in pxTopOfStack. */
	mov.l	r15, @r0
	/* portSAVE_CONTEXT_end */

	mov.l	__xTaskIncrementTick_vPortPreemptiveTick, r0
	jsr		@r0
	nop

	mov.l	__vTaskSwitchContext_vPortPreemptiveTick, r0
	jsr		@r0
	nop

	/* portRESTORE_CONTEXT_start */
	/* Get the address of the pxCurrentTCB variable. */
	mov.l	__pxCurrentTCB_vPortPreemptiveTick, r0

	/* Get the address of the task stack from pxCurrentTCB. */
	mov.l	@r0, r0

	/* Get the task stack itself into the stack pointer. */
	mov.l	@r0, r15

	/* Restore system registers. */
	ldc.l	@r15+, gbr
	lds.l	@r15+, mach
	lds.l	@r15+, macl

	/* Restore r0 to r14 and PR */
	movml.l	@r15+, r15

	/* Pop the SR and PC to jump to the start of the task. */
	rte
	nop
	/* portRESTORE_CONTEXT_end */

	.align  4
__pxCurrentTCB_vPortPreemptiveTick:
	.long   _pxCurrentTCB
__vTaskSwitchContext_vPortPreemptiveTick:
	.long   _vTaskSwitchContext
__xTaskIncrementTick_vPortPreemptiveTick:
	.long   _xTaskIncrementTick

/*-----------------------------------------------------------*/

_vPortCooperativeTick:

	/* portSAVE_CONTEXT_start */
	/* Save r0 to r14 and pr. */
	movml.l r15, @-r15

	/* Save mac1, mach and gbr */
	sts.l	macl, @-r15
	sts.l	mach, @-r15
	stc.l	gbr, @-r15

	/* Get the address of pxCurrentTCB */
	mov.l	__pxCurrentTCB_vPortCooperativeTick, r0

	/* Get the address of pxTopOfStack from the TCB. */
	mov.l	@r0, r0

	/* Save the stack pointer in pxTopOfStack. */
	mov.l	r15, @r0
	/* portSAVE_CONTEXT_end */

	mov.l	__xTaskIncrementTick_vPortCooperativeTick, r0
	jsr		@r0
	nop

	/* portRESTORE_CONTEXT_start */
	/* Get the address of the pxCurrentTCB variable. */
	mov.l	__pxCurrentTCB_vPortCooperativeTick, r0

	/* Get the address of the task stack from pxCurrentTCB. */
	mov.l	@r0, r0

	/* Get the task stack itself into the stack pointer. */
	mov.l	@r0, r15

	/* Restore system registers. */
	ldc.l	@r15+, gbr
	lds.l	@r15+, mach
	lds.l	@r15+, macl

	/* Restore r0 to r14 and PR */
	movml.l	@r15+, r15

	/* Pop the SR and PC to jump to the start of the task. */
	rte
	nop
	/* portRESTORE_CONTEXT_end */

	.align  4
__pxCurrentTCB_vPortCooperativeTick:
	.long   _pxCurrentTCB
__xTaskIncrementTick_vPortCooperativeTick:
	.long   _xTaskIncrementTick

/*-----------------------------------------------------------*/

_ulPortGetGBR:

	stc		gbr, r0
	rts
	nop

/*-----------------------------------------------------------*/

_vPortSaveFlopRegisters:

	fmov.s	fr0, @-r4
	fmov.s	fr1, @-r4
	fmov.s	fr2, @-r4
	fmov.s	fr3, @-r4
	fmov.s	fr4, @-r4
	fmov.s	fr5, @-r4
	fmov.s	fr6, @-r4
	fmov.s	fr7, @-r4
	fmov.s	fr8, @-r4
	fmov.s	fr9, @-r4
	fmov.s	fr10, @-r4
	fmov.s	fr11, @-r4
	fmov.s	fr12, @-r4
	fmov.s	fr13, @-r4
	fmov.s	fr14, @-r4
	fmov.s	fr15, @-r4
	sts.l   fpul, @-r4
	sts.l   fpscr, @-r4

	rts
	nop

/*-----------------------------------------------------------*/

_vPortRestoreFlopRegisters:

	add    #-72, r4
	lds.l  @r4+, fpscr
	lds.l  @r4+, fpul
	fmov.s @r4+, fr15
	fmov.s @r4+, fr14
	fmov.s @r4+, fr13
	fmov.s @r4+, fr12
	fmov.s @r4+, fr11
	fmov.s @r4+, fr10
	fmov.s @r4+, fr9
	fmov.s @r4+, fr8
	fmov.s @r4+, fr7
	fmov.s @r4+, fr6
	fmov.s @r4+, fr5
	fmov.s @r4+, fr4
	fmov.s @r4+, fr3
	fmov.s @r4+, fr2
	fmov.s @r4+, fr1
	fmov.s @r4+, fr0

	rts
	nop

	.end

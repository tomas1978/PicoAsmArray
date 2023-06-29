@
@ Assembler program defines some functions to use with arrays
@ using the Pico SDK.
@
@ R0 - first parameter to printf
@ R1 - second parameter to printf
@

.thumb_func		    	@ Necessary because sdk uses BLX
.global main	        @ Provide program starting address to linker

main:
	BL	stdio_init_all	@ initialize uart or usb
	LDR R5, =my_array
	MOV R1, #5
loop:
	LDR R5, =my_array
	MOV R1, #5
	BL sum
	MOV R2, R0
	LDR	R0, =labelSum	@ load address of helloworld string
	MOV R1, R2
	BL	printf			@ Call pico_printf
	B	loop			@ loop forever

sum:	#Address of array in R0, length of array in R1
	MOV R2, #0	@R2 as loop counter
	MOV R3, #0  @R3 used as sum
	array_loop:
		LDR R4,[R0]	@Load element into R4
		ADD R3, R3, R4
		CMP R3, R2
		ADD R0, R0, #4
		BLE array_loop
	MOV R0, R3
	BX LR




.data
.align  4	@ necessary alignment
labelSum: .asciz   "Sum %d\n"
.align  4	@ necessary alignment
my_array: .word 12, 34, 54, 76, 89

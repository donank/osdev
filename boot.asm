;Constants for the multiboot header
MBALIGN equ 1<<0
MEMINFO equ 1<<1
FLAGS equ MBALIGN | MEMINFO
MAGIC equ 0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS)

;Multiboot header 
section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

;Allocating room for a small stack by creating a symbol at the bottom for it and another at the top with 16384 bytes between them
section .bss
align 4
stack_bottom:
resb 16834 ;16 Kb
stack_top:

;Declare _start as a function symbol which is the entry point to the kernel 
section .text
global _start:function (_start.end - _start)
_start:
	;set the esp register to point to the top of the stacj as it grows downwards on x86 systems
	mov esp, stack_top
	extern kernel_main
	call kernel_main
	;put the computer in infinite loop
	;cli - Disable interrupts hlt - halt (wait for next interrupt)
	cli
.hang:  hlt
	jmp .hang
.end:

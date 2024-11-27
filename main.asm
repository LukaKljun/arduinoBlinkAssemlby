;
; AssemblerApplication4.asm
;
; Created: 27/11/2024 22:56:44
; Author : lukak
;
.include "m328pdef.inc"  ; Include ATmega328P definitions
.equ LED_PIN = 5         ; L LED connected to PB5

.org 0x0000              ; Reset vector
    rjmp RESET           ; Jump to the RESET routine

RESET:
    ldi r16, HIGH(RAMEND) ; Initialize stack pointer (high byte)
    out SPH, r16
    ldi r16, LOW(RAMEND)  ; Initialize stack pointer (low byte)
    out SPL, r16

    ldi r16, (1 << LED_PIN) ; Set bit for PB5
    out DDRB, r16           ; Configure PB5 as an output

MAIN_LOOP:
    ; Turn LED off
    cbi PORTB, LED_PIN
    rcall pavza             ; Call delay

    ; Turn LED on
    sbi PORTB, LED_PIN
    rcall pavza             ; Call delay

    rjmp MAIN_LOOP          ; Repeat the loop

pavza:
    ldi r17, 0xFF           ; Outer loop counter
    ldi r18, 0x16           ; Inner loop counter

pavzaloop_outer:
    ldi r19, 0xFF           ; Innermost loop counter

pavzaloop_inner:
    nop                     ; No operation (wastes 1 clock cycle)
    dec r19                 ; Decrement innermost counter
    brne pavzaloop_inner     ; Repeat until r19 = 0

    dec r18                 ; Decrement inner loop counter
    brne pavzaloop_outer     ; Repeat until r18 = 0

    dec r17                 ; Decrement outer loop counter
    brne pavzaloop_outer     ; Repeat until r17 = 0

    ret                     ; Return from subroutine

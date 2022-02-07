%include "common"

%macro mul ; Multiplies R0 by R1, and then stores the result in R2. Takes 2 frames to complete.
    bump r10
%endmacro

%macro div ; Divides R1 by R0, and then stores the remainder in R2, and the result in R3. Takes 2 frames to complete.
    bump r11
%endmacro

start:
    mov r9, 0
    mov r10, 1
    mov r11, 2

    mov r0, 0x2
    mov r1, 0x6
    div
    nop
    nop
    mov r1, r2
    call set_pix
    hlt


set_pix: ; Set a pixel at a cursor offset
    ; Save register
    push r0

    send r9, 0x200F ; Set the color of the pixels

    mov r0, 0x1000
    or r0, r1
    send r9, r0 ; Set the cursor position

    send r9, 0x007F ; Set the pixel
    
    ; Restore original register value
    pop r0
    ret

unset_pix: ; Clear a pixel at a cursor offset
    ; Save registers
    push r0
    push r1

    send r9, 0x200F ; Set the color of the pixels

    mov r0, 0x1000
    or r0, r1
    send r9, r0 ; Set the cursor position

    send r9, 0x0020 ; Clear the pixel


    ; Restore original register values
    pop r0
    pop r1
    ret
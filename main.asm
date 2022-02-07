%include "common"


%macro mul ; Multiplies R0 by R1, and then stores the result in R2. Takes 2 frames to complete.
    bump r10
%endmacro

%macro div ; Divides R1 by R0, and then stores the remainder in R2, and the result in R3. Takes 2 frames to complete.
    bump r11
%endmacro

org 0x0
start: ; Start label
    mov sp, 0x2000 ; This program uses the stack, so set SP safely out of the way of program memory
    
    mov r9, 0 ; Set terminal port to 0, because that's where the terminal should be
    mov r10, 1 ; Set multiplier port to 1
    mov r11, 2 ; Set divider port to 2


    

    mov r4, ip ; Save return address in r4
    add r4, 3
    jmp parse_parts ; Jump to function
    nop

    mov r4, ip ; Save return address in r4
    add r4, 3
    jmp draw_parts ; Jump to function
    nop
    hlt



%include "input.asm"

%include "screen.asm"

%include "particle.asm"

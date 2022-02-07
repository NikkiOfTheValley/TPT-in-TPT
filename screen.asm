; This is a modification of `print` from https://github.com/LBPHacker/R216/blob/master/quadratic.asm
print: ; r0 is a pointer to a string, r10 is the port
.loop:
    add [r0], 0 ; Make sure the zero flag is set correctly
    jz .exit
    send r9, [r0]
    add r0, 0x1
    jmp .loop
.exit:
    ret

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
parse_parts: ; Parse particles
    mov r3, part_arr ; Set up pointer to particle array
    mov r0, 0 ; Loop index
.loop:
    cmp [r3+2], 0 ; Compare TYPE against 0

    je .is_0 ; If TYPE != 0
    
    mov r7, r3 ; Save register value

    mov r1, 0x10
    div ; Divide the loop index by 16
    
    push [r2] ; loop index % 16 = X
    push [r3] ; loop index / 16 = Y

    mov r3, r7 ; Restore register value
    push [r3+2] ; TYPE

.is_0:
    add r3, 3 ; Add 3 to the pointer address so that it points to the next particle
    add r0, 1 ; Add 1 to the loop index

    cmp r0, 0x38 ; If loop index < 56 (0x38)
    jl .loop ; Loop back

.exit:
    jmp r4 ; Else, return from function


draw_parts: ; Draw all particles
    pop r7 ; Pop function return address into r7
    mov r0, 0
    mov r1, 0
    mov r2, 0

    mov r6, 0 ; Loop index

.loop:
    pop r3 ; X
    pop r4 ; Y
    pop r5 ; TYPE

    mov r3, 5
    mov r3, 5
    
    ; offset = Y * 16 + X
    mov r0, r4
    mov r1, 0x10
    mul
    nop
    add r2, r3
    mov r1, r2

    call set_pix

    
    hlt


%define part 0, 0, 0 ; VX, VY, TYPE
part_arr:
    dw 5, 5, 1, part, part, part, part, part, part, part
    dw part, part, part, part, part, part, part, part
    dw part, part, part, part, part, part, part, part
    dw part, part, part, part, part, part, part, part
    dw part, part, part, part, part, part, part, part
    dw part, part, part, part, part, part, part, part
    dw part, part, part, part, part, part, part, part


num_parts:
    dw 0
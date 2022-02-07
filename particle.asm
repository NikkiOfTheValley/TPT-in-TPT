parse_parts:
    mov r3, part_arr ; Set up pointer to particle array
    mov r1, 0 ; Loop index
.loop:
    cmp [r3+2], 0 ; Compare TYPE against 0

    je .is_0 ; If TYPE != 0
    push [r3] ; Push the particle onto stack
    push [r3+1]
    push [r3+2]

.is_0:
    add r3, 3 ; Add 3 to the pointer address so that it points to the next particle
    add r1, 1 ; Add 1 to the loop index

    cmp r1, 0xC0 ; If loop index < 192 (0xC0)
    jl .loop ; Loop back

.exit:
    jmp r4 ; Else, return from function


draw_parts:
    pop r4 ; Pop function return address into r4

    pop r0
    pop r1
    pop r3
    hlt


%define part 0, 0, 0 ; VX, VY, TYPE
part_arr:
	dw 1, 4, 1, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
	dw part, part, part, part, part, part, part, part, part, part, part, part, part, part
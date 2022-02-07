; !! THIS IS NOT MY CODE! This is copied from https://github.com/LBPHacker/R216/blob/master/quadratic.asm !!


; * Reads a single character from the terminal while blinking a cursor.
; * r6 is cursor colour.
; * r10 is terminal port address.
; * r11 is cursor position.
; * Character read is returned in r3.
read_character_blink:
    mov r4, 0x7F              ; * r4 holds the current cursor character.
    mov r2, 8                 ; * r2 is the counter for the blink loop.
    send r10, r6
    send r10, r11
    send r10, r4              ; * Display cursor.
.wait_loop:
    wait r3                   ; * Wait for a bump

    jns .got_bump             ; * The sign flag is cleared if a bump arrives.

    jmp .wait_loop            ; * Back to waiting
.got_bump:
    bump r10                  ; * Ask for character code.
.recv_loop:
    recv r3, r10              ; * Receive character code.
    jnc .recv_loop            ; * The carry bit it set if something is received.
    ret


; * Reads zero-terminated strings from the terminal.
; * r0 points to buffer to read into and r1 is the size of the buffer,
;   including the zero that terminates the string. If you have a 15 cell
;   buffer, do pass 15 in r1, but expect only 14 characters to be read at most.
; * r7 is the default cursor colour (the one used when the buffer is not about
;   to overflow; when it is, the cursor changes to yellow, 0x200E).
; * r10 is terminal port address.
; * r11 is cursor position.
read_string:
    bump r10                  ; * Drop whatever is in the input buffer.
    mov r5, r1
    sub r5, 1                 ; * The size of the buffer includes the
                              ;   terminating zero, so the character limit
                              ;   should be one less than this size.
    mov r6, r7                ; * Reset the default cursor colour.
    mov r1, 0                 ; * r1 holds the number of characters read.
.read_character:
    call read_character_blink
    cmp r3, 13                ; * Check for the Return key.
    je .got_return
    cmp r3, 8                 ; * Check for the Backspace key.
    je .got_backspace
    cmp r5, r1                ; * Check if whatever else we got fits the buffer.
    je .read_character
    send r10, r11             ; * If it does, display it and add it to the
    send r10, r3              ;   buffer.
    add r11, 1
    mov [r0+r1], r3
    add r1, 1
    cmp r5, r1
    ja .read_character        ; * Change cursor colour to yellow if the buffer
    mov r6, 0x200E            ;   is full.
    jmp .read_character       ; * Back to waiting.
.got_backspace:
    cmp r1, 0                 ; * Only delete a character if there is at least
    je .read_character        ;   one to delete.
    mov r6, r7                ; * Reset the default cursor colour.
    send r10, r11
    send r10, 0x20            ; * Clear the previous position of the cursor.
    sub r11, 1
    sub r1, 1
    jmp .read_character       ; * Back to waiting.
.got_return:
    send r10, r11
    send r10, 0x20            ; * Clear the previous position of the cursor.
    mov [r0+r1], 0            ; * Terminate string explicitly.
    ret
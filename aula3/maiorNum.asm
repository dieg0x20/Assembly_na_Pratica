segment .data
  LF        equ 0xA   ;line feed
  NULL      equ 0xd   ;Final da String
  SYS_CALL  equ 0x80  ; Envia informaçao ao SO 
  ;EAX
  SYS_EXIT  equ 0x1   ; chamada para finalizar o programa
  SYS_WRITE equ 0x4   ; operaçao de escrita
  SYS_READ  equ 0x3   ; operaçao de leitura
  ;EBX
  RET_EXIT  equ 0x0   ; operaçao realizada com sucesso
  STD_OUT   equ 0x1   ; valor de saida padrao
  STD_IN    equ 0x0   ; valor de entrada padrao

section .data 
  ;db 1 byte, dw, db 4 bytes, dq, dt 10 bytes 
  x dd 10
  y dd 50

  msg1 db "X é maior que Y", LF, NULL
  tam1 equ $- msg1 
  msg2 db "Y é maior que x", LF, NULL
  tam2 equ $- msg2

section .text 

global _start

_start: 
  mov eax, DWORD[x]
  mov ebx, DWORD[y]

  ;if - comparaçao 
  cmp eax, ebx
  ;salto condicional
  jge maior ;EAX >= EBX 
  mov ecx, msg2
  mov edx, tam2 
  ;je =, jg >, jge >=, jl <, jle <=, jne !=
  jmp final 
  ;salto incondicional jmp 

maior: 
  mov ecx, msg1
  mov edx, tam1

final: 
  mov eax, SYS_WRITE
  mov ebx, STD_OUT
  int SYS_CALL

  mov eax, SYS_EXIT
  mov ebx, RET_EXIT
  int SYS_CALL 

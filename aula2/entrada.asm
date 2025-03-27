segment .data
  LF        equ 0xA   ;line feed
  NULL      equ 0xd   ;Final da String
  SYS_CALL  equ 0x80  ; Envia informaçao ao SO 
  ;EAX
  SYS_EXIT  equ 0x1   ; chamada para finalizar o programa
  SYS_WRITE equ 0x4   ; operaçao de escrita
  SYS_READ  equ 0x3   ; operaçao de leitura
  ;EAX
  RET_EXIT  equ 0x0   ; operaçao realizada com sucesso
  STD_OUT   equ 0x1   ; valor de saida padrao
  STD_IN    equ 0x0   ; valor de entrada padrao


section .data
  msg db "Entre com seu nome", LF, NULL
  tam equ $- msg

section .bss 
  nome resb 1

section .text 
global _start 

_start:
  mov eax, SYS_WRITE
  mov ebx, STD_OUT
  mov ecx, msg
  mov edx, tam
  int SYS_CALL

  mov eax, SYS_READ
  mov ebx, STD_IN
  mov ecx, nome
  mov edx, 0xA
  int SYS_CALL

  mov eax, SYS_EXIT
  mov ebx, RET_EXIT
  int SYS_CALL


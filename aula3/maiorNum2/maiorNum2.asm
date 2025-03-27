  ;autor: Dieg0x20
  ;modifiquei o codigo para pedir ao usuario uma numero inteiro
  ;agora o programa compara o valor de y com o valor digitado pelo usuario

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
  y dd 50
  msg3 db "Digite um numero:", LF, NULL
  tam3 equ $- msg3 
  msg1 db "X é maior que Y", LF, NULL
  tam1 equ $- msg1 
  msg2 db "Y é maior que x", LF, NULL
  tam2 equ $- msg2

section .bss 
  numero resb 1

section .text 

global _start

_start:
  ;exeibir digite um numero
  mov eax, SYS_WRITE
  mov ebx, STD_OUT
  mov ecx, msg3
  mov edx, tam3
  int SYS_CALL
  
  ;ler numero do usuario  
  mov eax, SYS_READ
  mov ebx, STD_IN
  mov ecx, numero
  mov edx, 4 ;le quatro caracteres
  int SYS_CALL

  ;converter String em numero 
  mov esi, numero ;ponteiro  para a String
  call str_to_int ;valor retorna em eax

  ;comparacao com y 
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

str_to_int:
  xor eax, eax      ; Zera EAX (armazenará o número)
  xor ecx, ecx      ; Zera ECX (usado para multiplicação)
  mov ecx, 10       ; Multiplicador decimal

.loop:
  movzx edx, byte [esi] ; Pega um caractere da string
  test  edx, edx        ; Se for NULL (fim da string), sai
  jz    .done
  sub   edx, '0'        ; Converte ASCII para número
  imul  eax, ecx        ; Multiplica o número atual por 10
  add   eax, edx        ; Soma o novo dígito
  inc   esi             ; Avança para o próximo caractere
  jmp   .loop

.done:
  ret

format binary as 'img'

;;;;;;;;;;;; BOOT SECTOR 
org 7c00h

mov ax, cs
mov ds, ax
xor ax,ax
xor di,di

mov ah,0x02      ;usar el BIOS para cargar
mov al,0x04      ;cantidad de sectores
mov ch,0x00
mov cl,0x02      ;a partir del segundo sector lógico
mov dh,0x00
mov dl,0x80      ;del primer disco duro
mov bx,0x800     ;y escribir el contenido en 0x8000
mov es,bx
mov bx,0x0000

@@: 
  int 0x13
  jc  @b

jmp 8000h	     

;;;;;;;;;;;; fill with 0 the 512 bytes length  boot section has to have
times 510 - ($ - $$) db 0
dw 0aa55h

include 'game.asm'

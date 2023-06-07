;;;;;;;;;; Main Code ;;;;;
org 8000h

;; Stack Set
mov bp, 0x8000 ; set the stack safely away
mov sp, bp

call printStartGameScreen

;; Keyboard initialization
xor ax,ax
mov es, ax
mov ax,keyboard
mov [es:4*9], ax
mov [es:4*9+2], cs

;; TIMER initialization
mov ax,timer
mov [es:4*8] , ax
mov [es:4*8 + 2] ,cs
sti

;;;;;;;;;;;; Graphics Mode initialization
xor eax, eax
mov ax, 13h
int 10h
mov ax, 0A000h
mov es, ax

exit:
  jmp $

;; INCLUDES
include 'draw.asm'
include 'keyboard.asm'
include 'timer.asm'
include 'tank1.asm'
include 'tank2.asm'
include 'bulletTank1.asm'
include 'bulletTank2.asm'
include 'data.asm'
include 'helpers.asm'

keyboard:
  pusha
  cli
  in  al,60h	; Leer el buffer del teclado

  test al,10000000b  ; compruebo si está presionada o no, 1 liberado, 0 presionado
  jz   released      
  jmp  pressed

  released:
    ;;;;; TANK 1 KEYS
    ;; COMPARE WITH D
    mov  bl, [keyMapD]
    cmp  al, bl
    je   actionKeyD
    ;; COMPARE WITH A
    mov  bl , [keyMapA]
    cmp  al, bl
    je  actionKeyA
    ;; COMPARE WITH W
    mov  bl , [keyMapW]
    cmp  al, bl
    je  actionKeyW
    ;; COMPARE WITH S
    mov  bl , [keyMapS]
    cmp  al, bl
    je   actionKeyS
    ;; COMPARE WITH Space  ;; SHOOT
    mov  bl , [keySpace]
    cmp  al, bl
    je   actionKeySpace


    ;;;;; TANK 2 KEYS
    ;; COMPARE WITH LEFT ARROW
    mov  bl, [keyLeftArrow]
    cmp  al, bl
    je   actionKeyLeft
    ;; COMPARE WITH RIGTH ARROW
    mov  bl , [keyRigthArrow]
    cmp  al, bl
    je  actionKeyRigth
    ;; COMPARE WITH UP ARROW
    mov  bl , [keyUpArrow]
    cmp  al, bl
    je  actionKeyUp
    ;; COMPARE WITH DOWN ARROW
    mov  bl , [keyDownArrow]
    cmp  al, bl
    je   actionKeyDown
    ;; COMPARE WITH ENTER  ;; SHOOT
    mov  bl , [keyEnter]
    cmp  al, bl
    je   actionKeyEnter

    jmp  endKeyboardInterrupt

  pressed:
    jmp endKeyboardInterrupt

  endKeyboardInterrupt:
    sti
    mov  al,20h		; fin de interrupción hardware
    out  20h,al		; al pic maestro
  popa
  iret

;; Actions TANK 1 keys
actionKeyW:
  mov [tank1LastDir] , 1
  call incPosTank1Up
  jmp  endKeyboardInterrupt

actionKeyD:
  mov [tank1LastDir] , 2
  call incPosTank1Right
  jmp  endKeyboardInterrupt

actionKeyS:
  mov [tank1LastDir] , 3
  call incPosTank1Down
  jmp  endKeyboardInterrupt

actionKeyA:
  mov [tank1LastDir] , 4
  call incPosTank1Left
  jmp  endKeyboardInterrupt

actionKeySpace:
  pusha
    cmp [tank1BalaActiveTime], 0
    jne exitActionKeySpace
    cmp [tank1LastDir], 1
    je  actionBulletToUp
    cmp [tank1LastDir], 2
    je  actionBulletToRight
    cmp [tank1LastDir], 3
    je  actionBulletToDown
    cmp [tank1LastDir], 4
    je  actionBulletToLeft

    actionBulletToUp:
      mov [tank1BalaActiveDirPos], 1
      ;; Create Bullet
      push ax
	mov ax, [tank1Pos]
	sub ax , 10 * 320 - 7
	mov [tank1BalaPos], ax
      pop ax
      call incPosBala1Up
      jmp exitActionKeySpace
    actionBulletToRight:
      mov [tank1BalaActiveDirPos], 2
      ;; Create Bullet
      push ax
	mov ax, [tank1Pos]
	add  ax , 20 * 1 + 7 * 320
	mov [tank1BalaPos], ax
      pop ax
      call incPosBala1Right
      jmp exitActionKeySpace 
    actionBulletToDown:
      mov [tank1BalaActiveDirPos], 3
      ;; Create Bullet
      push ax
	mov ax, [tank1Pos]
	add ax , 320 * 20 + 7
	mov [tank1BalaPos], ax
      pop ax
      call incPosBala1Down
      jmp exitActionKeySpace 
    actionBulletToLeft:
      mov [tank1BalaActiveDirPos], 4
      ;; Create Bullet
      push ax
	mov ax, [tank1Pos]
	sub ax , 1 * 10  - 7 * 320
	mov [tank1BalaPos], ax
      pop ax
      call incPosBala1Left
      jmp exitActionKeySpace 

  exitActionKeySpace:
  popa
  jmp endKeyboardInterrupt

;; Actions TANK 2 keys
actionKeyUp:
  mov [tank2LastDir] , 1
  call incPosTank2Up
  jmp  endKeyboardInterrupt

actionKeyRigth:
  mov [tank2LastDir] , 2
  call incPosTank2Right
  jmp  endKeyboardInterrupt

actionKeyDown:
  mov [tank2LastDir] , 3
  call incPosTank2Down
  jmp  endKeyboardInterrupt

actionKeyLeft:
  mov [tank2LastDir] , 4
  call incPosTank2Left
  jmp  endKeyboardInterrupt

actionKeyEnter:
  pusha
    cmp [tank2BalaActiveTime], 0
    jne exitActionKeyEnter
    cmp [tank2LastDir], 1
    je actionBullet2ToUp
    cmp [tank2LastDir], 2
    je actionBullet2ToRight
    cmp [tank2LastDir], 3
    je actionBullet2ToDown
    cmp [tank2LastDir], 4
    je actionBullet2ToLeft

    actionBullet2ToUp:
      mov [tank2BalaActiveDirPos], 1
      ;; Create Bullet
      push ax
	mov ax, [tank2Pos]
	sub ax , 10 * 320 - 7
	mov [tank2BalaPos], ax
      pop ax
      call incPosBala2Up
      jmp exitActionKeyEnter
    actionBullet2ToRight:
      mov [tank2BalaActiveDirPos], 2
      ;; Create Bullet
      push ax
	mov ax, [tank2Pos]
	add  ax , 20 * 1 + 7 * 320
	mov [tank2BalaPos], ax
      pop ax
      call incPosBala2Right
      jmp exitActionKeyEnter
    actionBullet2ToDown:
      mov [tank2BalaActiveDirPos], 3
      ;; Create Bullet
      push ax
	mov ax, [tank2Pos]
	add ax , 320 * 20 + 7
	mov [tank2BalaPos], ax
      pop ax
      call incPosBala2Down
      jmp exitActionKeyEnter
    actionBullet2ToLeft:
      mov [tank2BalaActiveDirPos], 4
      ;; Create Bullet
      push ax
	mov ax, [tank2Pos]
	sub ax , 1 * 10  - 7 * 320
	mov [tank2BalaPos], ax
      pop ax
      call incPosBala2Left
      jmp exitActionKeyEnter

  exitActionKeyEnter:
  popa
  jmp endKeyboardInterrupt

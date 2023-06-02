keyboard:
  pusha
  cli
  in  al,60h	; Leer el buffer del teclado

  cmp al,10000000b  ; compruebo si está presionada o no, 1 liberado, 0 presionado
  jne  released      ;si esta liberada no voy a hacer nada
  jmp  pressed

  released:
    ;;;;; TANK 1
    ;; Compare with D
    mov  bl, [keyMapD]
    cmp  al, bl
    je   actionKeyD
    ;; Compare with A
    mov  bl , [keyMapA]
    cmp  al, bl
    je  actionKeyA
    ;; Compare with W
    mov  bl , [keyMapW]
    cmp  al, bl
    je  actionKeyW
    ;; Compare with S
    mov  bl , [keyMapS]
    cmp  al, bl
    je   actionKeyS

    jmp  endKeyboardInterrupt

  pressed:
    jmp endKeyboardInterrupt

  endKeyboardInterrupt:
    sti
    mov  al,20h			; fin de interrupción hardware
    out  20h,al			; al pic maestro
  popa
  iret

;; Actions
actionKeyS:
  call printBackground
  call incPosTank1Down
  call drawTank1ToDown
  jmp  endKeyboardInterrupt

actionKeyW:
  call printBackground
  call incPosTank1Up
  call drawTank1ToUp
  jmp endKeyboardInterrupt

actionKeyD:
  call printBackground
  call incPosTank1Right
  call drawTank1ToRight
  jmp endKeyboardInterrupt

actionKeyA:
  call printBackground
  call incPosTank1Left
  call drawTank1ToLeft
  jmp endKeyboardInterrupt

;; Tank 1 movement
incPosTank1Right:
  pusha
    mov ax, [tank1Pos]
    add ax , 1 * 20     ;; increment possition
    mov [tank1Pos], ax
  popa
  ret

incPosTank1Left:
  pusha
    mov ax, [tank1Pos]
    sub ax , 1 * 20     ;; increment possition
    mov [tank1Pos] , ax
  popa
  ret

incPosTank1Up:
  pusha
    mov ax, [tank1Pos]
    sub ax , (320 * 20)     ;; increment possition
    mov [tank1Pos] , ax
  popa
  ret

incPosTank1Down:
  pusha
    mov ax, [tank1Pos]
    add ax , (320 * 20)     ;; increment possition
    mov [tank1Pos] , ax
  popa
  ret

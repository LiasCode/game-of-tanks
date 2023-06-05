drawTank1:
  pusha
    mov al, [tank1LastDir]
    ;;; Compara con la ultima posicion para eligir en que direccion pintar el tanque
    cmp al , 1
    je call1DrawUp
    cmp al , 2
    je call1DrawRight
    cmp al , 3
    je call1DrawDown
    cmp al , 4
    je call1DrawLeft

    call1DrawUp: 
      call drawTank1ToUp
      jmp drawTank1Return
    call1DrawRight: 
      call drawTank1ToRight
      jmp drawTank1Return
    call1DrawDown: 
      call drawTank1ToDown
      jmp drawTank1Return
    call1DrawLeft: 
      call drawTank1ToLeft
      jmp drawTank1Return

  drawTank1Return:
  popa
  ret


drawTank1ToUp:
  pusha
    mov  ax,[tank1Pos]      ;; position
    mov  dl,[tank1Color]             ;; color
    call drawSquare20x20

    ;; Canon
    mov  ax,[tank1Pos]      ;; position
    mov  dl, [tank1Color]             ;; color
    sub ax , 10 * 320 - 8
    call drawSquare5x5
    ;; Canon
    mov  ax,[tank1Pos]      ;; position
    mov  dl, [tank1Color]             ;; color
    sub ax , 5 * 320 - 8
    call drawSquare5x5

    ;; Cabain Tank
    mov  ax,[tank1Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

drawTank1ToRight:
  pusha
    mov ax, [tank1Pos]
    mov  dl, [tank1Color]             ;; color
    call drawSquare20x20

    ;; Canon
    mov ax, [tank1Pos]
    mov  dl, [tank1Color]             ;; color
    add  ax , 20 * 1 + 7 * 320
    call drawSquare5x5
    ;; Canon
    mov ax, [tank1Pos]
    mov  dl, [tank1Color]             ;; color
    add  ax , 25 * 1 + 7 * 320
    call drawSquare5x5

    ;; Cabain Tank
    mov ax, [tank1Pos]
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

drawTank1ToDown:
  pusha
    ;; Base Tank
    mov  ax,[tank1Pos]      ;; position
    mov  dl, [tank1Color]             ;; color
    call drawSquare20x20

    ;; Canon
    mov  ax,[tank1Pos]      ;; position
    mov  dl, [tank1Color]             ;; color
    add  ax , 20 * 320 + 8
    call drawSquare5x5
    ;; Canon
    mov  ax,[tank1Pos]      ;; position
    mov  dl, [tank1Color]             ;; color
    add ax , 25 * 320 + 8
    call drawSquare5x5
    ;; Cabain Tank
    mov  ax,[tank1Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

drawTank1ToLeft:
  pusha
    mov  ax,[tank1Pos]      ;; position
    mov  dl, [tank1Color]             ;; color
    call drawSquare20x20

    ;; Canon
    mov ax, [tank1Pos]
    mov  dl, [tank1Color]             ;; color
    add  ax , 7 * 320
    sub  ax , 5
    call drawSquare5x5
    ;; Canon
    mov ax, [tank1Pos]
    mov  dl, [tank1Color]             ;; color
    add  ax , 7 * 320
    sub  ax , 10
    call drawSquare5x5

    ;; Cabain Tank
    mov  ax,[tank1Pos]      ;; position
    add ax , 320 * 5 + 5
    mov  dl, 0x13             ;; color
    call drawSquare10x10
  popa
  ret

;; Tank 1 Position Movement
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


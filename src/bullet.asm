drawBullet1:
  pusha
    mov al , 0
    cmp [tank1BalaActiveDirPos], al
    je exitDrawBullet1
    mov  ax,[tank1BalaPos]
    mov  dl, [tank1Color]             ;; color
    call drawSquare5x5
    exitDrawBullet1:
  popa
  ret

incPosBala1Up:
  pusha
    mov ax, [tank1BalaPos]
    sub ax, 320 * 10
    mov [tank1BalaPos], ax
  popa
  ret
incPosBala1Right:
  pusha
    mov ax, [tank1BalaPos]
    add ax, 1 * 10
    mov [tank1BalaPos], ax
  popa
  ret
incPosBala1Down:
  pusha
    mov ax, [tank1BalaPos]
    add ax, 320 * 10
    mov [tank1BalaPos], ax
  popa
  ret
incPosBala1Left:
  pusha
    mov ax, [tank1BalaPos]
    sub ax, 1 * 10
    mov [tank1BalaPos], ax
  popa
  ret

drawBullet2:
  pusha
    mov al , 0
    cmp [tank2BalaActiveDirPos], al
    je exitDrawBullet2
    mov  ax,[tank2BalaPos]
    mov  dl, [tank2Color]             ;; color
    call drawSquare5x5
    exitDrawBullet2:
  popa
  ret

incPosBala2Up:
  pusha
    mov ax, [tank2BalaPos]
    sub ax, 320 * 10
    mov [tank2BalaPos], ax
  popa
  ret
incPosBala2Right:
  pusha
    mov ax, [tank2BalaPos]
    add ax, 1 * 10
    mov [tank2BalaPos], ax
  popa
  ret
incPosBala2Down:
  pusha
    mov ax, [tank2BalaPos]
    add ax, 320 * 10
    mov [tank2BalaPos], ax
  popa
  ret
incPosBala2Left:
  pusha
    mov ax, [tank2BalaPos]
    sub ax, 1 * 10
    mov [tank2BalaPos], ax
  popa
  ret

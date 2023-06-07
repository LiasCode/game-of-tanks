drawBulletTank1:
  pusha
    call calculateBulletTank1Pos

    mov dx , [tank1BalaPosY]
    mov bx , [tank1BalaPosX]
    call calculatePositionFromXYPositions
    mov [tank1BalaPos],ax

    mov al , 0
    cmp [tank1BalaActiveDirPos], al
    je exitDrawBulletTank1
    mov  ax,[tank1BalaPos]
    mov  dl, [tank1Color]             ;; color
    call drawSquare5x5
    exitDrawBulletTank1:
  popa
  ret

calculateBulletTank1Pos:
  pusha
    cmp [tank1BalaActiveDirPos], 0
    je  exitCalculateBulletTank1Pos
    cmp [tank1BalaActiveDirPos], 1
    je  moveBullet1ToUp
    cmp [tank1BalaActiveDirPos], 2
    je  moveBullet1ToRight
    cmp [tank1BalaActiveDirPos], 3
    je  moveBullet1ToDown
    cmp [tank1BalaActiveDirPos], 4
    je  moveBullet1ToLeft

    moveBullet1ToUp:
      call incPosBulletTank1Up
      jmp incBullet1PosTime
    moveBullet1ToRight:
      call incPosBulletTank1Right
      jmp incBullet1PosTime
    moveBullet1ToDown:
      call incPosBulletTank1Down
      jmp incBullet1PosTime
    moveBullet1ToLeft:
      call incPosBulletTank1Left
      jmp incBullet1PosTime

    incBullet1PosTime:
      mov al , [tank1BalaActiveTime]
      inc al
      cmp al , 18
      je resetBullet1
      mov [tank1BalaActiveTime], al
      jmp exitCalculateBulletTank1Pos

    resetBullet1:
      mov al , 0
      mov [tank1BalaActiveDirPos], al
      mov [tank1BalaActiveTime],  al
      jmp exitCalculateBulletTank1Pos

  exitCalculateBulletTank1Pos:
  popa
  ret

incPosBulletTank1Up:
  pusha
    mov ax, [tank1BalaPosY]
    sub ax, 10
    mov [tank1BalaPosY], ax
  popa
  ret

incPosBulletTank1Right:
  pusha
    mov ax, [tank1BalaPosX]
    add ax, 10
    mov [tank1BalaPosX], ax
  popa
  ret

incPosBulletTank1Down:
  pusha
    mov ax, [tank1BalaPosY]
    add ax, 10
    mov [tank1BalaPosY], ax
  popa
  ret

incPosBulletTank1Left:
  pusha
    mov ax, [tank1BalaPosX]
    sub ax, 10
    mov [tank1BalaPosX], ax
  popa
  ret

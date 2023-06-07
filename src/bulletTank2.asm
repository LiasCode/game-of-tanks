drawBulletTank2:
  pusha
    call calculateBulletTank2Pos

    mov dx , [tank2BalaPosY]
    mov bx , [tank2BalaPosX]
    call calculatePositionFromXYPositions
    mov [tank2BalaPos],ax

    mov al , 0
    cmp [tank2BalaActiveDirPos], al
    je exitDrawBulletTank2
    mov  ax,[tank2BalaPos]
    mov  dl, [tank2Color]             ;; color
    call drawSquare5x5
    exitDrawBulletTank2:
  popa
  ret

calculateBulletTank2Pos:
  pusha
    cmp [tank2BalaActiveDirPos], 0
    je  exitCalculateBulletTank2Pos
    cmp [tank2BalaActiveDirPos], 1
    je  moveBullet2ToUp
    cmp [tank2BalaActiveDirPos], 2
    je  moveBullet2ToRight
    cmp [tank2BalaActiveDirPos], 3
    je  moveBullet2ToDown
    cmp [tank2BalaActiveDirPos], 4
    je  moveBullet2ToLeft

    moveBullet2ToUp:
      call incPosBulletTank2Up
      jmp incBullet2PosTime
    moveBullet2ToRight:
      call incPosBulletTank2Right
      jmp incBullet2PosTime
    moveBullet2ToDown:
      call incPosBulletTank2Down
      jmp incBullet2PosTime
    moveBullet2ToLeft:
      call incPosBulletTank2Left
      jmp incBullet2PosTime

    incBullet2PosTime:
      mov al , [tank2BalaActiveTime]
      inc al
      cmp al , 18
      je resetBullet2
      mov [tank2BalaActiveTime], al
      jmp exitCalculateBulletTank2Pos

    resetBullet2:
      mov al , 0
      mov [tank2BalaActiveDirPos], al
      mov [tank2BalaActiveTime],  al
      jmp exitCalculateBulletTank2Pos

  exitCalculateBulletTank2Pos:
  popa
  ret

incPosBulletTank2Up:
  pusha
    mov ax, [tank2BalaPosY]
    sub ax, 10
    mov [tank2BalaPosY], ax
  popa
  ret

incPosBulletTank2Right:
  pusha
    mov ax, [tank2BalaPosX]
    add ax, 10
    mov [tank2BalaPosX], ax
  popa
  ret

incPosBulletTank2Down:
  pusha
    mov ax, [tank2BalaPosY]
    add ax, 10
    mov [tank2BalaPosY], ax
  popa
  ret

incPosBulletTank2Left:
  pusha
    mov ax, [tank2BalaPosX]
    sub ax, 10
    mov [tank2BalaPosX], ax
  popa
  ret



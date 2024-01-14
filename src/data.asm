isPausedGame  db 0
gameTickTimer db 0

;; Tank 1 attibuttes
tank1Pos                         dw 0
tank1PosX                        dw 20   ; columnas 320
tank1PosY                        dw 20   ; filas    200
tank1Hearts                      db 3    ; max 3 hearts
tank1BalaPos                     dw 0
tank1BalaPosX                    dw 0
tank1BalaPosY                    dw 0
tank1BalaActiveDirPos            db 0    ; 1 up, 2 right, 3 down, 4 left, 0 inactive
tank1BalaActiveTime              db 0    ; max 8 times, when == 8 set to 0 and tank1BalaActiveDirPos = 0
tank1LastDir                     db 2    ; 1 up, 2 right, 3 down, 4 left
tank1Color                       db 02h
tank1InvulnerableState           db 0

;; Tank 2 attibuttes
tank2Pos                         dw 0
tank2PosX                        dw 280  ; columnas 320
tank2PosY                        dw 160  ; filas    200
tank2Hearts                      db 3    ; max 3 hearts
tank2BalaPos                     dw 0
tank2BalaPosX                    dw 0
tank2BalaPosY                    dw 0
tank2BalaActiveDirPos            db 0   ; 1 up, 2 right, 3 down, 4 left, 0 inactive
tank2BalaActiveTime              db 0   ; when == 8 set to 0 and tank1BalaActiveDirPos = 0
tank2LastDir                     db 4   ; 1 up, 2 right, 3 down, 4 left
tank2Color                       db 04h
tank2InvulnerableState           db 0

;;;;; KEYs Scan CODES
keyEnter  db 1ch
keyEsc    db 01h
keySpace  db 39h

;;;;; ARROWS KEYS
keyLeftArrow  db 4bh
keyRigthArrow db 4dh
keyUpArrow    db 48h
keyDownArrow  db 50h

;;;;; AWSD KEYS
keyMapA db 1eh
keyMapD db 20h
keyMapW db 11h
keyMapS db 1fh

;; MSG strings
startGameMsgTitle                db 'Game Of Tanks',0
startGameMsgPressEnter           db 'Press "Enter" to start playing',0

startGameMsgTutorialKeys         db 'How to play ??',0
startGameMsgTutorialPayerGreen   db 'Player GREEN : MOVE -> A W S D :  SHOOT -> SPACE',0
startGameMsgTutorialPayerRed     db 'Player RED   : MOVE -> ARROWS  :  SHOOT -> ENTER',0

endGameWinGreenMsg               db 'End Game, Green player WINS. Press "ESC" to reset',0
endGameWinRedMsg                 db 'End Game, RED   player WINS. Press "ESC" to reset' ,0

autorMsg1                        db 'by @LiasCode' ,0

errorMsg                         db 'Fin del juego. Ocurrio un error, Press Enter To Reset' ,0
gameWinner                       db  0  ; 1 -> verde ; 2 -> rojo

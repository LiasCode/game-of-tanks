# /usr/bin/sh

fasm ./src/main.asm ./built/tank-2.img && qemu-system-x86_64 -drive file=./built/tank-2.img,format=raw

# nasm -fbin ./src/tank-2.asm -o ./built/tank-2.bin & qemu-system-x86_64 ./built/tank-2.bin


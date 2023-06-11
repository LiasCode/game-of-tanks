# /usr/bin/sh

make && qemu-system-x86_64 -drive file=./built/game-of-tanks.img,format=raw

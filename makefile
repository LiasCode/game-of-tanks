build: clean
	fasm ./src/main.asm ./built/game-of-tanks.img

clean:
	rm -rf ./built/* && mkdir ./built -p

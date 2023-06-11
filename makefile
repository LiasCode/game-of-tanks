build: clean
	fasm ./src/main.asm ./built/game-of-tanks.img

clean:
	rm -r ./built/*

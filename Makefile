CC=clang
INCLUDES=-I./src/ -I./lib
FRAMEWORKS=-framework Foundation
CFLAGS=-undefined suppress -dynamiclib -flat_namespace $(FRAMEWORKS)
SRC_FILES=./src/*.m
#./lib/**.c

all:
	mkdir -p build
	$(CC) $(INCLUDES) $(CFLAGS) $(SRC_FILES) -o ./build/fast-zip.o

clean:
	rm -rf build

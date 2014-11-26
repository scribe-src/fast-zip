CC=clang
INCLUDES=-I./src/ -I./lib
FRAMEWORKS=-framework Foundation
CFLAGS=-undefined suppress -dynamiclib -flat_namespace $(FRAMEWORKS) -lz
SRC_FILES=$(wildcard ./src/*.m ./deps/minizip/*.c)
FILTERED=./deps/minizip/iowin32.c ./deps/minizip/minizip.c ./deps/minizip/miniunz.c
LIB_FILES=$(filter-out $(FILTERED), $(SRC_FILES))
TEST_FILES=./deps/objc-unit/src/*.m
TEST_FLAGS=$(FRAMEWORKS) -lz -I./deps/objc-unit/src/ $(TEST_FILES)
TEST_OUT=./build/test

.PHONY: test clean

all:
	mkdir -p build
	$(CC) $(INCLUDES) $(CFLAGS) $(LIB_FILES) -o ./build/fast-zip.o

test:
	mkdir -p build
	$(CC) $(INCLUDES) $(LIB_FILES) $(TEST_FLAGS) -o $(TEST_OUT)
	export NSZombieEnabled=YES
	$(TEST_OUT)

clean:
	rm -rf build

bump-deps:
	cd ./deps/scribe-engine-jsc && git pull --ff origin master
	cd ./deps/objc-unit && git pull --ff origin master
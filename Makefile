CC=clang

BUILD_DIR=./build
INCLUDES=-I./src/ -I./deps/minizip/
FRAMEWORKS=-framework Foundation
CFLAGS=-undefined suppress -dynamiclib -flat_namespace $(FRAMEWORKS) -lz

SRC_FILES=$(wildcard ./src/*.m ./deps/minizip/*.c)
FILTERED=./deps/minizip/iowin32.c ./deps/minizip/minizip.c ./deps/minizip/miniunz.c
LIB_FILES=$(filter-out $(FILTERED), $(SRC_FILES))


.PHONY: test clean

all:
	mkdir -p $(BUILD_DIR)
	$(CC) $(INCLUDES) $(CFLAGS) $(LIB_FILES) -o $(BUILD_DIR)/fast-zip.o

TEST_FILES=./deps/objc-unit/src/*.m ./test/*.m
TEST_FLAGS=$(FRAMEWORKS) -lz -I./deps/objc-unit/src/ $(TEST_FILES)
TEST_OUT=$(BUILD_DIR)/test
test:
	mkdir -p $(BUILD_DIR)
	$(CC) $(INCLUDES) $(LIB_FILES) $(TEST_FLAGS) -o $(TEST_OUT)
	export NSZombieEnabled=YES
	$(TEST_OUT)

clean:
	rm -rf $(BUILD_DIR)

bump-deps:
	cd ./deps/minizip && git pull --ff origin master
	cd ./deps/objc-unit && git pull --ff origin master

WAT2WASM=wat2wasm
ESLINT=./node_modules/.bin/eslint
WAT2WASM_FLAGS=
BUILD_FLAGS=
ifeq ($(DEBUG),1)
WAT2WASM_FLAGS:=$(WAT2WASM_FLAGS) --debug-names
BUILD_FLAGS:=--development
endif

all: build

.PHONY: build
build: uxn.wasm
	./build.js $(BUILD_FLAGS)

dev:
	./build.js $(BUILD_FLAGS) --watch

.PHONY: test
test:
	./test.js

test-dev:
	./test.js --watch

%.wasm: %.wat
	$(WAT2WASM) $(WAT2WASM_FLAGS) -o $@ $<

clean:
	-rm -rf build public/uxn-wasm uxn.wasm

lint:
	$(ESLINT) .

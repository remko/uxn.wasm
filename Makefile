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
build: build/uxn.wasm
	./build.js $(BUILD_FLAGS)

dev:
	./build.js $(BUILD_FLAGS) --watch

.PHONY: test
test:
	./test.js

test-dev:
	./test.js --watch

.PHONY: bench
bench:
	./test.js --benchmarks

build/%.wasm: src/%.wat
	mkdir -p build
	$(WAT2WASM) $(WAT2WASM_FLAGS) -o $@ $<

update-tests:
	curl -o src/tests/opctest.tal https://git.sr.ht/~rabbits/uxn-utils/blob/main/cli/opctest/opctest.tal
	curl -o src/benchmarks/mandelbrot.tal https://git.sr.ht/~rabbits/uxn/blob/main/projects/examples/demos/mandelbrot.tal

clean:
	-rm -rf build public/uxn-wasm

lint:
	$(ESLINT) .

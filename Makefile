WAT2WASM=wat2wasm
ESLINT=./node_modules/.bin/eslint
WAT2WASM_FLAGS=
UXNASM ?= $(PWD)/scripts/uxnasm.js
BUILD_FLAGS=
ifeq ($(DEBUG),1)
WAT2WASM_FLAGS:=$(WAT2WASM_FLAGS) --debug-names
BUILD_FLAGS:=--development
endif
CLI=./src/cli/uxncli

all: build

.PHONY: build
build: build/uxn.wasm
	./scripts/build.js $(BUILD_FLAGS)

dev:
	./scripts/build.js $(BUILD_FLAGS) --watch

.PHONY: test
test:
	./scripts/test.cjs

test-dev:
	./scripts/test.cjs --watch

.PHONY: bench
bench:
	./scripts/test.cjs --benchmarks

bench-native: build/mandelbrot.rom build/primes32.rom
	@echo mandelbrot
	@for i in `seq 0 4`; do \
		time (uxncli build/mandelbrot.rom < /dev/null); true; \
	done
	@echo
	@echo primes32
	@for i in `seq 0 4`; do \
		time (uxncli build/primes32.rom < /dev/null > /dev/null); true; \
	done

bench-cli: build/mandelbrot.rom build/primes32.rom
	$(MAKE) -C src/cli
	@echo mandelbrot
	@for i in `seq 0 4`; do \
		time ($(CLI) build/mandelbrot.rom < /dev/null); true; \
	done
	@echo
	@echo primes32
	@for i in `seq 0 4`; do \
		time ($(CLI) build/primes32.rom < /dev/null > /dev/null); true; \
	done

build/mandelbrot.rom: src/benchmarks/mandelbrot.tal
	$(UXNASM) $< $@

build/primes32.rom: src/benchmarks/primes32.tal
	cd src/benchmarks && $(UXNASM) primes32.tal ../../build/primes32.rom

build/%.wasm: src/%.wat
	mkdir -p build
	$(WAT2WASM) $(WAT2WASM_FLAGS) -o $@ $<

update-tests:
	curl -o src/tests/opctest.tal https://git.sr.ht/~rabbits/uxn-utils/blob/main/cli/opctest/opctest.tal
	curl -o src/benchmarks/mandelbrot.tal https://git.sr.ht/~rabbits/uxn/blob/main/projects/examples/demos/mandelbrot.tal
	(curl https://git.sr.ht/~rabbits/uxn5/blob/main/src/uxn.js && echo "export default Uxn;") > src/benchmarks/uxn5.js

update-uxntal-reference:
	curl -o scripts/resources/uxntal_reference.html https://raw.githubusercontent.com/XXIIVV/oscean/main/src/htm/uxntal_reference.htm

clean:
	-rm -rf build dist public/uxn-wasm

lint:
	$(ESLINT) .

TSC ?= tsc
lint-tsc:
	$(TSC) --project jsconfig.json --noEmit

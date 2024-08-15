ROOT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))../..

.DEFAULT_GOAL := all

VERSION?=$(shell cat ../../package.json | grep '"version"' | sed -e 's/.*:.*"\(.*\)".*/\1/')

UXNASM ?= $(ROOT_DIR)/scripts/uxnasm.js

ifeq ($(OS),Windows_NT)
CXX = g++
WABT_DIR = /c/tools/wabt
WABT_INCLUDE_DIR ?= $(WABT_DIR)/include
WABT_DATA_DIR ?= $(WABT_DIR)/share/wabt
package: uxn-wasm-cli
	7z a -tzip uxn-wasm-cli-v$(VERSION)-windows.zip uxn-wasm-cli.exe
else # $(OS)

ifeq (, $(shell which gtar))
TAR := tar
else
# bsd-tar corrupts files on GitHub: https://github.com/actions/virtual-environments/issues/2619
TAR := gtar
endif

LLVM_PROFDATA ?= llvm-profdata
UNAME_S=$(shell uname -s)
UNAME_P=$(shell uname -p)
ifeq ($(UNAME_S),Darwin)
ifeq ($(UNAME_P),arm)
PACKAGE_SUFFIX=arm64-macos
else
PACKAGE_SUFFIX=x86_64-macos
endif
WABT_DIR = $(shell brew --prefix)
WABT_INCLUDE_DIR = $(WABT_DIR)/include
WABT_DATA_DIR = $(WABT_DIR)/share/wabt
LLVM_PROFDATA = $(WABT_DIR)/opt/llvm/bin/llvm-profdata
LLVM_COV = $(WABT_DIR)/opt/llvm/bin/llvm-cov
else # $(UNAME_S)
WABT_INCLUDE_DIR ?= /usr/lib/include
WABT_DATA_DIR ?= /usr/share/wabt
PACKAGE_SUFFIX=x86_64-linux
endif # $(UNAME_S)

CFLAGS := -DVERSION='"$(VERSION)"' -Wall -Wno-unused-function -Wno-unused-value -I$(WABT_INCLUDE_DIR)

ifeq ($(COVERAGE),1)
CFLAGS := $(CFLAGS) -fprofile-instr-generate -fcoverage-mapping  
else ifeq ($(DEBUG), 1)
CFLAGS := $(CFLAGS) -g
else
CFLAGS := $(CFLAGS) -O2
endif

package: uxn-wasm-cli
	mkdir -p ../../dist
	$(TAR) czf ../../dist/uxn-wasm-cli-v$(VERSION)-$(PACKAGE_SUFFIX).tgz uxn-wasm-cli

endif # $(OS)

.PHONY: all
all: uxn-wasm-cli

uxn-wasm-cli: cli_core.o cli.o wasm-rt-impl.o 
	$(CC) $(CFLAGS) $(LINKFLAGS) -o $@ $^

cli_core.c cli_core.h: ../../build/uxn.wasm
	wasm2c $< -o cli_core.c

wasm-rt-impl.o: $(WABT_DATA_DIR)/wasm2c/wasm-rt-impl.c
	$(CC) -c $(CFLAGS) -o $@ $<

wasm-rt-mem-impl.o: $(WABT_DATA_DIR)/wasm2c/wasm-rt-mem-impl.c
	$(CC) -c $(CFLAGS) -o $@ $<

../../build/uxn.wasm: ../../src/uxn.wat
	$(MAKE) -C ../.. build/uxn.wasm

opctest.rom: ../tests/opctest.tal
	$(UXNASM) $< $@

mandelbrot.rom: ../benchmarks/mandelbrot.tal
	$(UXNASM) $< $@

primes32.rom: ../benchmarks/primes32.tal
	cd ../benchmarks && $(UXNASM) $(PWD)/$< $(PWD)/$@

fib.rom: ../benchmarks/fib.tal
	$(UXNASM) $< $@

test: uxn-wasm-cli opctest.rom
	./uxn-wasm-cli opctest.rom | tee opctest.log
	@grep failed opctest.log; if [ $$? -eq 0 ]; then echo "Test failed"; exit -1; fi

.PHONY: coverage
coverage: opctest.rom
	$(MAKE) COVERAGE=1 uxn-wasm-cli
	env LLVM_PROFILE_FILE="opctest.profraw" ./uxn-wasm-cli opctest.rom
	$(LLVM_PROFDATA) merge -sparse opctest.profraw -o opctest.profdata
	$(LLVM_COV) show uxn-wasm-cli -instr-profile=opctest.profdata -format=html -output-dir=coverage -sources cli_core.c

clean:
	-rm -rf *.o cli_core.* uxn-wasm-cli *.rom *.rom.sym *.profraw *.profdata coverage *.log


UNAME_S=$(shell uname -s)
LLVM_PROFDATA ?= llvm-profdata
ifeq ($(UNAME_S),Darwin)
WABT_DIR = $(shell brew --prefix)
WABT_INCLUDE_DIR = $(WABT_DIR)/include
WABT_DATA_DIR = $(WABT_DIR)/share/wabt
LLVM_PROFDATA = $(WABT_DIR)/opt/llvm/bin/llvm-profdata
LLVM_COV = $(WABT_DIR)/opt/llvm/bin/llvm-cov
else # $(UNAME_S)
WABT_INCLUDE_DIR ?= /usr/lib/include
WABT_DATA_DIR ?= /usr/share/wabt
endif # $(UNAME_S)
CPPFLAGS = -I$(WABT_INCLUDE_DIR)

# Add code coverage
CFLAGS := $(CFLAGS) -fprofile-instr-generate -fcoverage-mapping  

.PHONY: all
all: uxnwasm opctest.rom

uxnwasm: uxnwasm_core.o uxnwasm.o wasm-rt-impl.o
	$(CC) $(CFLAGS) $(LINKFLAGS) -o $@ $^

uxnwasm_core.c uxnwasm_core.h: ../../build/uxn.wasm
	wasm2c $< -o uxnwasm_core.c

wasm-rt-impl.o: $(WABT_DATA_DIR)/wasm2c/wasm-rt-impl.c
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

%.o: %.cpp
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

../../build/uxn.wasm:
	$(MAKE) -C ../.. build/uxn.wasm

opctest.rom: ../tests/opctest.tal
	uxnasm $< $@

.PHONY: coverage
coverage: uxnwasm opctest.rom
	env LLVM_PROFILE_FILE="opctest.profraw" ./uxnwasm opctest.rom
	$(LLVM_PROFDATA) merge -sparse opctest.profraw -o opctest.profdata
	$(LLVM_COV) show uxnwasm -instr-profile=opctest.profdata -format=html -output-dir=coverage -sources uxnwasm_core.c

clean:
	-rm -rf *.o uxnwasm_core.* uxnwasm *.rom *.rom.sym *.profraw *.profdata coverage

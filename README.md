<img src="./doc/logo.svg" height="100">

# Uxn implementation in WebAssembly

[![Build](https://github.com/remko/uxn.wasm/actions/workflows/build.yml/badge.svg)](https://github.com/remko/uxn.wasm/actions/workflows/build.yml)

This is an implementation of the [Uxn](https://100r.co/site/uxn.html) virtual
machine in WebAssembly. It provides a drop-in replacement for the
[uxn5](https://git.sr.ht/~rabbits/uxn5) vanilla JS core.

The [WebAssembly
module](https://github.com/remko/uxn.wasm/blob/master/src/uxn.wat) is generated
by [a script](https://github.com/remko/uxn.wasm/blob/master/scripts/emuwasm.js) that generates WebAssembly for the various instruction variants, based on hand-written raw WebAssembly for the base instructions, and does some small local optimizations on the generated code.

Goals of this implementation (in descending order of priority) are:

- **Compliance**: Follows the Uxn specification to the letter. This includes
  support for circular stacks and memory, which comes at the cost of speed (and
  simplicity). Compliance is [tested](https://github.com/remko/uxn.wasm/actions/workflows/upstream-tests.yml) against the [Uxn opcode test suite](https://git.sr.ht/~rabbits/uxn-utils/tree/main/item/cli/opctest).
- **Simplicity**: The implementation needs to be understandable and maintainable.
  When speed optimizations would come at the cost of too much complexity, I
  don’t do them.
- **Speed**: Try to be as fast as possible. If implementation of instructions are
  changed, check the impact on performance of the benchmarks (and
  microbenchmarks) to understand the impact on speed.

See [this blog post](https://mko.re/blog/uxn-wasm/) for some context,
implementation details, and benchmarks.

## Installation

Uxn.wasm is part of the uxn5 distribution.
If you want to install a different version:

1. Download `uxn-wasm.js` from [the Releases page](https://github.com/remko/uxn.wasm/releases).
2. Put `uxn-wasm.js` in the `src/` dir of [uxn5](https://git.sr.ht/~rabbits/uxn5).
3. Open uxn5 `index.html`, and check your browser JavaScript console that it loaded the WebAssembly core.


## Using Uxn.wasm in JavaScript

You can use the core outside of uxn5, as a standalone way to run Uxn programs.
This package ships with extra utilities under the `util` submodule to easily run Uxn
programs, including an Uxntal assembler (`asm`), and utility devices (e.g. a `LogConsole` 
console device that logs output to `console`).

### Example

The example below runs a Uxntal program to compute prime numbers below 65536, and writes
them to the console. 

```javascript
import { Uxn } from "uxn.wasm";
import { asm, mux, LogConsole } from "uxn.wasm/util";

(async () => {
  const uxn = new Uxn();

  // Initialize the system with 1 device: a console at device offset 0x10 that
  // logs output using `console.log`.
  await uxn.init(mux(uxn, { 0x10: new LogConsole() }));

  // Assemble the program written in Uxntal assembly language into a binary ROM 
  // using `asm`, and load it into the core.
  uxn.load(
    asm(`
( Source: https://git.sr.ht/~rabbits/uxn/tree/main/item/projects/examples/exercises )

|0100 ( -> ) @reset
  #0000 INC2k
  &loop
    DUP2 not-prime ?&skip
      DUP2 print/short #2018 DEO
      &skip
    INC2 NEQ2k ?&loop
  POP2 POP2
  ( flush ) #0a18 DEO
  ( halt ) #010f DEO
BRK

@not-prime ( number* -- flag )
  DUP2 ,&t STR2
  ( range ) #01 SFT2 #0002 LTH2k ?&fail
  &loop
    [ LIT2 &t $2 ] OVR2 ( mod2 ) DIV2k MUL2 SUB2 ORA ?&continue
      &fail POP2 POP2 #01 JMP2r &continue
    INC2 GTH2k ?&loop
  POP2 POP2 #00
JMP2r

@print ( short* -- )
  &short ( short* -- ) SWP print/byte
  &byte  ( byte   -- ) DUP #04 SFT print/char
  &char  ( char   -- ) #0f AND DUP #09 GTH #27 MUL ADD #30 ADD #18 DEO
JMP2r
`)
  );

  // Start running at the default offset (0x100)
  uxn.eval();
})();
```


## Development

### Building

    make

### Running the tests

    make test

### Running the benchmarks

    make bench

### Running the tests & benchmarks in a browser

    make dev

The tests and benchmarks can now be run from <http://localhost:8080>.

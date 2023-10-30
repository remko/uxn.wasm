# Uxn implementation in WebAssembly

[![Build](https://github.com/remko/uxn.wasm/actions/workflows/build.yml/badge.svg)](https://github.com/remko/uxn.wasm/actions/workflows/build.yml)

This repository implements the [Uxn](https://100r.co/site/uxn.html) virtual
machine in WebAssembly. It provides a drop-in replacement for the
[uxn5](https://git.sr.ht/~rabbits/uxn5) vanilla JS core.

The [WebAssembly
module](https://github.com/remko/uxn.wasm/blob/master/src/uxn.wat) is generated
by [a script](https://github.com/remko/uxn.wasm/blob/master/scripts/emuwasm.js) that generates WebAssembly for the various instruction variants, based on hand-written raw WebAssembly for the base instructions, and does some small local optimizations on the generated code.

## Installation

Uxn.wasm is part of the uxn5 distribution.
If you want to install a different version:

1. Download `uxn-wasm.js` from [the Releases page](https://github.com/remko/uxn.wasm/releases).
2. Put `uxn-wasm.js` in the `src/` dir of [uxn5](https://git.sr.ht/~rabbits/uxn5).
3. Open uxn5 `index.html`, and check your browser JavaScript console that it loaded the WebAssembly core.

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

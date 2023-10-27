# Uxn implementation in WebAssembly

[![Build](https://github.com/remko/uxn.wasm/actions/workflows/build.yml/badge.svg)](https://github.com/remko/uxn.wasm/actions/workflows/build.yml)

🚧 Under construction  

This repository implements the [Uxn](https://100r.co/site/uxn.html) virtual
machine in WebAssembly. It provides a drop-in replacement for the
[uxn5](https://git.sr.ht/~rabbits/uxn5) vanilla JS core.

## Installation

1. Download `uxn-wasm.js` from [the Releases page](https://github.com/remko/uxn.wasm/releases).
2. Put `uxn-wasm.js` in the `src/` dir of [uxn5](https://git.sr.ht/~rabbits/uxn5).
3. Open uxn5 `index.html`, and check your browser JavaScript console that it loaded the WebAssembly core.

import asm from "./asm.js";

export { asm };

export function peek16(mem, addr) {
  return (mem[addr] << 8) | mem[addr + 1];
}

export function poke16(mem, addr, val) {
  mem[addr] = val >> 8;
  mem[addr + 1] = val;
}

/**
 * Creates a function that accepts character codes in UTF-8 encoding, and calls
 * the callback whenever a complete newline-delimited line is received.
 *
 * The resulting function also has a `flush()` function to flush any remaining output.
 */
export function withLineBuffer(fn) {
  let buffer = [];
  const flush = () => {
    if (buffer.length > 0) {
      fn(new TextDecoder().decode(Uint8Array.from(buffer)));
      buffer = [];
    }
  };
  const r = (c) => {
    buffer.push(c);
    if (c == 0xa) {
      flush();
    }
  };
  r.flush = flush;
  return r;
}

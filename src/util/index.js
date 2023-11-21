export { asm } from "./asm.js";
export { decodeUlz, encodeUlz } from "./ulz.js";

export function peek16(mem, addr) {
  return (mem[addr] << 8) | mem[addr + 1];
}

export function poke16(mem, addr, val) {
  mem[addr] = val >> 8;
  mem[addr + 1] = val;
}

export function mux(uxn, devices) {
  return {
    deo(port, val) {
      const dev = devices[port & 0xf0];
      if (dev && dev.deo != null) {
        dev.deo(port & 0xf, val);
      }
    },

    dei(port) {
      const dev = devices[port & 0xf0];
      if (dev && dev.dei != null) {
        return dev.dei(port & 0xf);
      }
      return uxn.dev[port];
    },
  };
}

/**
 * Creates a function that accepts character codes in UTF-8 encoding, and calls
 * the callback whenever a complete newline-delimited line is received.
 *
 * The resulting function also has a `flush()` function to flush any remaining output.
 */
function withLineBuffer(fn) {
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

export function LogConsole() {
  const out = withLineBuffer(console.log);
  return {
    deo(port, val) {
      switch (port) {
        case 0x8:
          out(val);
          break;
      }
    },

    flush() {
      out.flush();
    },
  };
}

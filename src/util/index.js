export { asm } from "./asm.js";
export { decodeUlz, encodeUlz } from "./ulz.js";

/**
 * @param {Uint8Array} mem
 * @param {number} addr
 * @returns {number}
 */
export function peek16(mem, addr) {
  return (mem[addr] << 8) | mem[addr + 1];
}

/**
 * @param {Uint8Array} mem
 * @param {number} addr
 * @param {number} val
 */
export function poke16(mem, addr, val) {
  mem[addr] = val >> 8;
  mem[addr + 1] = val;
}

/**
 * @typedef {{
 *   deo?: (port: number, val: number) => void;
 *   dei?: (port: number) => number;
 * }} Device
 */

/**
 * @param {import("../uxn.js").Uxn} uxn
 * @param {Record<number, Device>} devices
 * @returns {Device}
 */
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
 * @param {(line: string) => void} fn - The callback to call when a complete
 *   line was received (or a flush was initiated)
 * @returns {{(c: number): void; flush: () => void;}} A function that accepts
 *   character codes in UTF-8 encoding.
 *   The function also has a `flush()` property to flush any remaining output.
 */
export function withLineBuffer(fn) {
  /** @type {number[]} */
  let buffer = [];
  const decoder = new TextDecoder();
  const flush = () => {
    if (buffer.length > 0) {
      fn(decoder.decode(Uint8Array.from(buffer)));
      buffer = [];
    }
  };
  const r = (/** @type {number} */ c) => {
    buffer.push(c);
    if (c == 0xa) {
      flush();
    }
  };
  r.flush = flush;
  return r;
}

/**
 * Creates a function that accepts character codes in UTF-8 encoding, and calls
 * the callback whenever a complete codepoint is received.
 *
 * @param {(line: string) => void} fn - The callback to call when a complete
 *  codepoint was received
 * @returns {(c: number) => void} A function that accepts character codes in
 *   UTF-8 encoding.
 */
export function withBuffer(fn) {
  /** @type {number[]} */
  let buffer = [];
  let n = 0;
  const decoder = new TextDecoder();
  return (/** @type {number} */ c) => {
    if (n > 0) {
      buffer.push(c);
      n--;
      if (n === 0) {
        fn(decoder.decode(Uint8Array.from(buffer)));
        buffer = [];
      }
    } else if ((c & 0x80) === 0x00) {
      fn(String.fromCharCode(c));
    } else {
      buffer.push(c);
      if ((c & 0xe0) === 0xc0) {
        n = 1;
      } else if ((c & 0xf0) === 0xe0) {
        n = 2;
      } else if ((c & 0xf8) === 0xf0) {
        n = 3;
      } else if ((c & 0xfc) === 0xf8) {
        n = 4;
      } else if ((c & 0xfe) === 0xfc) {
        n = 5;
      }
    }
  };
}

/** @returns {Device & {flush: () => void}} */
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

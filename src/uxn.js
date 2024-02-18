// @ts-ignore
import wasmModule from "./uxn.wat";

/**
 * @constructor
 */
export function Uxn() {
  /**
   * @type {{
   *   eval: (addr: number) => void;
   *   wstp: () => number;
   *   rstp: () => number;
   *   reset: () => void;
   *   memory: WebAssembly.Memory;
   * }}
   */
  let core;

  /** @type {Uint8Array} */
  let wst;

  /** @type {Uint8Array} */
  let rst;

  const reset = () => {
    core.reset();
  };

  /** @type {(system: {dei?: (addr: number) => number; deo?: (addr: number, val: number) => void; }) => Promise<void>} */
  this.init = async (system) => {
    system = system != null ? system : {};
    core = /** @type {*} */ (
      await WebAssembly.instantiate(wasmModule, {
        system: {
          deo: system.deo != null ? system.deo : () => {},
          dei:
            system.dei != null
              ? system.dei
              : (/** @type {number} */ port) => {
                  return this.dev[port];
                },
        },
      })
    ).instance.exports;
    this.ram = new Uint8Array(core.memory.buffer, 0, 0x10000);
    wst = new Uint8Array(core.memory.buffer, 0x10000, 0x100);
    rst = new Uint8Array(core.memory.buffer, 0x10100, 0x100);
    this.dev = new Uint8Array(core.memory.buffer, 0x10200, 0x100);
  };

  /** @type {(rom: Uint8Array) => Uxn} */
  this.load = (rom) => {
    reset();
    for (let i = 0, len = rom.length; i < len; ++i) {
      this.ram[0x100 + i] = rom[i];
    }
    return this;
  };

  /** @type {(addr: number) => void} */
  this.eval = (addr = 0x100) => {
    core.eval(addr);
  };

  /** @typedef {{get: (i: number) => number; ptr: () => number; }} Stack */
  /** @type {Stack} */
  this.wst = {
    get: (i) => {
      return wst[0xff - i];
    },
    ptr: () => {
      return (0x100 - core.wstp()) % 0x100;
    },
  };

  /** @type {Stack} */
  this.rst = {
    get: (i) => {
      return rst[0xff - i];
    },
    ptr: () => {
      return (0x100 - core.rstp()) % 0x100;
    },
  };
}

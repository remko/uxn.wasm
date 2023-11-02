import wasmModule from "./uxn.wat";

export function Uxn() {
  let core, wst, rst;

  const reset = () => {
    core.reset();
  };

  this.init = async (system) => {
    system = system != null ? system : {};
    core = (
      await WebAssembly.instantiate(wasmModule, {
        system: {
          deo: system.deo != null ? system.deo : () => {},
          dei:
            system.dei != null
              ? system.dei
              : (port) => {
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

  this.load = (rom) => {
    reset();
    for (let i = 0, len = rom.length; i < len; ++i) {
      this.ram[0x100 + i] = rom[i];
    }
    return this;
  };

  this.eval = (addr) => {
    core.eval(addr);
  };

  this.wst = {
    get: (i) => {
      return wst[0xff - i];
    },
    ptr: () => {
      return (0x100 - core.wstp()) % 0x100;
    },
  };

  this.rst = {
    get: (i) => {
      return rst[0xff - i];
    },
    ptr: () => {
      return (0x100 - core.rstp()) % 0x100;
    },
  };
}

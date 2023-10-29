import wasmModule from "./uxn.wat";

function Uxn() {
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
    this.ram = new Uint8Array(core.memory.buffer, 0, 0x10300);
    this.dev = new Uint8Array(core.memory.buffer, 0x10200, 0x100);
    wst = new Uint8Array(core.memory.buffer, 0x10000, 0xff);
    rst = new Uint8Array(core.memory.buffer, 0x10100, 0xff);
    return this;
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
      return wst[0xfe - i];
    },
    ptr: () => {
      return 0xff - core.wstp();
    },
  };

  this.rst = {
    get: (i) => {
      return rst[0xfe - i];
    },
    ptr: () => {
      return 0xff - core.rstp();
    },
  };
}

module.exports = Uxn;

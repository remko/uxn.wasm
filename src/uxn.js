import wasmModule from "./uxn.wat";

function Uxn() {
  let core, wstd, rstd;

  const reset = () => {
    core.exports.reset();
  };

  this.init = async (system) => {
    core = (await WebAssembly.instantiate(wasmModule, { system })).instance;
    this.ram = new Uint8Array(core.exports.memory.buffer, 0, 0x10300);
    this.dev = new Uint8Array(core.exports.memory.buffer, 0x10200, 0x100);
    wstd = new Uint8Array(core.exports.memory.buffer, 0x10000, 0xff);
    rstd = new Uint8Array(core.exports.memory.buffer, 0x10100, 0xff);
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
    core.exports.eval(addr);
  };

  this.wst = {
    get: (i) => {
      return wstd[0xfe - i];
    },
    ptr: () => {
      return 0x100ff - core.exports.wstp();
    },
  };

  this.rst = {
    get: (i) => {
      return rstd[0xfe - i];
    },
    ptr: () => {
      return 0x101ff - core.exports.rstp();
    },
  };
}

module.exports = Uxn;

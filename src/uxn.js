import wasmModule from "./uxn.wat";

function Uxn() {
  this.dev = 0x10200;

  let core, wstd, rstd;

  const reset = () => {
    core.exports.reset();
  };

  this.init = async (system) => {
    core = (await WebAssembly.instantiate(wasmModule, { system })).instance;
    this.ram = new Uint8Array(core.exports.memory.buffer, 0, 0x10300);
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

  this.poke8 = (addr, val) => {
    this.ram[addr] = val;
  };

  this.poke16 = (addr, val) => {
    this.ram[addr] = val >> 8;
    this.ram[addr + 1] = val;
  };

  this.peek8 = (addr) => {
    return this.ram[addr];
  };

  this.peek16 = (addr) => {
    return (this.ram[addr] << 8) + this.ram[addr + 1];
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

  this.getdev = (port) => {
    return this.ram[this.dev + port];
  };
  this.setdev = (port, val) => {
    this.ram[this.dev + port] = val;
  };
}

module.exports = Uxn;

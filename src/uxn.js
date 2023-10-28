import wasmModule from "./uxn.wat";

function Uxn() {
  this.dev = 0x10200;

  this.init = async (system) => {
    const instance = await WebAssembly.instantiate(wasmModule, { system });
    this._core = instance.instance;
    this.ram = new Uint8Array(this._core.exports.memory.buffer, 0, 0x10300);
    this._wstd = new Uint8Array(
      this._core.exports.memory.buffer,
      0x10000,
      0xff
    );
    this._rstd = new Uint8Array(
      this._core.exports.memory.buffer,
      0x10100,
      0xff
    );
    return this;
  };

  this.load = (rom) => {
    this.reset();
    for (let i = 0, len = rom.length; i < len; ++i) {
      this.ram[0x100 + i] = rom[i];
    }
    return this;
  };

  this.eval = (addr) => {
    this._core.exports.eval(addr);
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

  this.reset = () => {
    this._core.exports.reset();
  };

  this.wst = {
    get: (i) => {
      return this._wstd[0xfe - i];
    },
    ptr: () => {
      return 0x100ff - this._core.exports.wstp();
    },
  };

  this.rst = {
    get: (i) => {
      return this._rstd[0xfe - i];
    },
    ptr: () => {
      return 0x101ff - this._core.exports.rstp();
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

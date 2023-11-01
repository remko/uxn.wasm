import mandelbrot from "./mandelbrot.tal";
import primes32 from "./primes32.tal";
import jcn from "./jcn.tal";
// import Uxn5 from "./uxn5";

const PROGRAM_OFFSET = 0x100;

export default [
  {
    name: "mandelbrot",
    init: async (uxn) => {
      await uxn.init();
    },
    run: (uxn) => {
      uxn.load(mandelbrot);
      uxn.eval(PROGRAM_OFFSET);
    },
    check: () => {},
  },
  {
    skip: true,
    name: "jcn",
    init: async (uxn) => {
      await uxn.init();
    },
    run: (uxn) => {
      uxn.load(jcn);
      uxn.eval(PROGRAM_OFFSET);
    },
    check: () => {},
  },
  // {
  //   name: "mandelbrot (uxn.js)",
  //   init: async () => {
  //     const uxn = new Uxn5({
  //       onStep: () => {},
  //       deo: () => {},
  //       dei: (port) => {
  //         return uxn.dev[port];
  //       },
  //     });
  //     return uxn;
  //   },
  //   run: (uxn) => {
  //     uxn.load(mandelbrot);
  //     uxn.eval(PROGRAM_OFFSET);
  //   },
  //   check: () => {},
  // },
  {
    name: "primes32",
    init: async (uxn) => {
      return await uxn.init({
        deo: (port, value) => {
          switch (port) {
            case 0x18:
              uxn._primes32.output.push(value);
              break;
            case 0xf:
              uxn._primes32.result = value;
              break;
          }
        },
      });
    },
    run: (uxn) => {
      uxn._primes32 = { output: [] };
      uxn.load(primes32);
      uxn.eval(PROGRAM_OFFSET);
    },
    check: (uxn) => {
      if (uxn._primes32.result !== 255) {
        throw Error(`unexpected result: ${uxn._primes32.result}`);
      }
      const output = new TextDecoder().decode(
        Uint8Array.from(uxn._primes32.output)
      );
      const expected = "fffffffb 01\n".repeat(5);
      if (output !== expected) {
        throw Error(`unexpected output: '${output}' != '${expected}`);
      }
    },
  },
  // {
  //   name: "primes32 (uxn.js)",
  //   init: async () => {
  //     const state = { output: [] };
  //     const uxn = new Uxn5({
  //       onStep: () => {},
  //       deo: (port, value) => {
  //         switch (port) {
  //           case 0x18:
  //             state.output.push(value);
  //             break;
  //           case 0xf:
  //             state.result = value;
  //             break;
  //         }
  //       },
  //       dei: (port) => {
  //         return uxn.dev[port];
  //       },
  //     });
  //     uxn._primes32 = state;
  //     return uxn;
  //   },
  //   run: (uxn) => {
  //     uxn.load(primes32);
  //     uxn.eval(PROGRAM_OFFSET);
  //     return uxn;
  //   },
  //   check: (uxn) => {
  //     if (uxn._primes32.result !== 255) {
  //       throw Error(`unexpected result: ${uxn._primes32.result}`);
  //     }
  //     const output = new TextDecoder().decode(
  //       Uint8Array.from(uxn._primes32.output)
  //     );
  //     const expected = "fffffffb 01\n".repeat(5);
  //     if (output !== expected) {
  //       throw Error(`unexpected output: '${output}' != '${expected}`);
  //     }
  //   },
  // },
];

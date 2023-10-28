import mandelbrot from "./mandelbrot.tal";
import primes32 from "./primes32.tal";

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
    name: "prime32",
    init: async (uxn) => {
      await uxn.init({
        deo: (port, value) => {
          switch (port) {
            case 0x18:
              uxn._prime32.output.push(value);
              break;
            case 0xf:
              uxn._prime32.result = value;
              break;
          }
        },
      });
    },
    run: (uxn) => {
      uxn._prime32 = { output: [] };
      uxn.load(primes32);
      uxn.eval(PROGRAM_OFFSET);
    },
    check: (uxn) => {
      if (uxn._prime32.result !== 255) {
        throw Error(`unexpected result: ${uxn._prime32.result}`);
      }
      const output = new TextDecoder().decode(
        Uint8Array.from(uxn._prime32.output)
      );
      const expected = "fffffffb 01\n".repeat(14);
      if (output !== expected) {
        throw Error(`unexpected output: '${output}' != '${expected}`);
      }
    },
  },
];

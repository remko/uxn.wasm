import mandelbrot from "./mandelbrot.tal";

const PROGRAM_OFFSET = 0x100;

export default [
  {
    name: "mandelbrot",
    run: (uxn) => {
      uxn.load(mandelbrot);
      uxn.eval(PROGRAM_OFFSET);
    },
  },
];

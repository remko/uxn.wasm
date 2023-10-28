import mandelbrot from "./mandelbrot.tal";
import Uxn from "../uxn";

const DEV_OFFSET = 0x10200;
const PROGRAM_OFFSET = 0x100;

document.body.innerHTML = `
<h1>Uxn.wasm Benchmarks</h1>
<div>
  <button id="startButton">Start</button>
  <table>
    <tr id="mandelbrotResults"></tr>
  </table>
</div>
`;
const startButtonEl = document.getElementById("startButton");
const mandelbrotResultsEl = document.getElementById("mandelbrotResults");

function runMandelbrot(uxn) {
  uxn.load(mandelbrot);
  uxn.eval(PROGRAM_OFFSET);
}

async function runMandelbrotBenchmark() {
  try {
    startButtonEl.disabled = true;
    const uxn = new Uxn();
    await uxn.init({
      deo: () => {},
      dei: (port) => {
        return uxn.ram[DEV_OFFSET + port];
      },
    });
    mandelbrotResultsEl.innerHTML = "<th>Mandelbrot</th>";
    for (let i = 0; i < 5; i++) {
      const el = document.createElement("td");
      mandelbrotResultsEl.appendChild(el);
      el.appendChild(document.createTextNode("⌛️"));
      const t1 = performance.now();
      runMandelbrot(uxn);
      const t2 = performance.now();
      el.innerHTML = ((t2 - t1) / 1000.0).toFixed(2) + "s";
    }
  } finally {
    startButtonEl.disabled = false;
  }
}

startButtonEl.onclick = () => {
  runMandelbrotBenchmark();
};

import Uxn from "../uxn";
import suite from "./suite";

document.body.innerHTML = `
<h1>Uxn.wasm Benchmarks</h1>
<div>
  <button id="startButton">Start</button>
  <table id="results">
  </table>
</div>
`;
const startButtonEl = document.getElementById("startButton");
const resultsEl = document.getElementById("results");

startButtonEl.onclick = async () => {
  startButtonEl.disabled = true;
  resultsEl.replaceChildren();
  for (const b of suite) {
    const trEl = document.createElement("table");
    resultsEl.appendChild(trEl);
    const thEl = document.createElement("th");
    thEl.appendChild(document.createTextNode(b.name));
    trEl.appendChild(thEl);

    const uxn = new Uxn();
    await uxn.init({
      deo: () => {},
      dei: (port) => {
        return uxn.ram[uxn.dev + port];
      },
    });

    for (let i = 0; i < 5; i++) {
      const tdEl = document.createElement("td");
      const valueEl = document.createTextNode("⌛️");
      tdEl.appendChild(valueEl);
      trEl.appendChild(tdEl);
      let value;

      try {
        const t1 = performance.now();
        b.run(uxn);
        const t2 = performance.now();
        value = ((t2 - t1) / 1000.0).toFixed(2) + "s";
      } catch (e) {
        console.error(e);
        value = "error: " + e;
      }
      tdEl.replaceChild(document.createTextNode(value), valueEl);
    }
  }
  startButtonEl.disabled = false;
};

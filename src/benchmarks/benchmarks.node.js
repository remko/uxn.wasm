const suite = require("./suite").default;
const Uxn = require("../uxn");

(async () => {
  const uxn = new Uxn();
  await uxn.init({
    deo: () => {},
    dei: (port) => {
      return uxn.dev[port];
    },
  });
  for (const b of suite) {
    console.log(b.name);
    for (let i = 0; i < 5; i++) {
      let value;
      const t1 = performance.now();
      b.run(uxn);
      const t2 = performance.now();
      value = ((t2 - t1) / 1000.0).toFixed(2) + "s";
      console.log(`   run ${i + 1}: ` + value);
    }
  }
})();

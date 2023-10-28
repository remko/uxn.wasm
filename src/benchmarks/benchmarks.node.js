const suite = require("./suite").default;
const Uxn = require("../uxn");

(async () => {
  for (const b of suite) {
    console.log(b.name);
    const uxn = new Uxn();
    await b.init(uxn);
    for (let i = 0; i < 5; i++) {
      let value;
      const t1 = performance.now();
      b.run(uxn);
      const t2 = performance.now();
      b.check(uxn);
      value = ((t2 - t1) / 1000.0).toFixed(2) + "s";
      console.log(`   run ${i + 1}: ` + value);
    }
  }
})();

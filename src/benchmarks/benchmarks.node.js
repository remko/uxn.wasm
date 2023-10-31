const suite = require("./suite").default;
const Uxn = require("../uxn").Uxn;

(async () => {
  const haveOnly = suite.some((s) => s.only);
  for (const b of suite) {
    if (b.skip || (haveOnly && !b.only)) {
      continue;
    }
    console.log(b.name);
    let uxn = new Uxn();
    uxn = (await b.init(uxn)) || uxn;
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

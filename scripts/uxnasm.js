#!/usr/bin/env node

import { asm } from "../src/util/index.js";
import process from "process";
import fs from "fs";
import path from "path";

if (process.argv[2] == null || process.argv[3] == 0) {
  console.error("missing input/output parameter");
  process.exit(-1);
}
const sourcepath = process.argv[2];
const d = asm(fs.readFileSync(sourcepath).toString(), {
  include: (f) => {
    const fn = path.join(path.dirname(sourcepath), f);
    return fs.readFileSync(fn).toString();
  },
});
fs.writeFileSync(process.argv[3], d, { encoding: "binary" });

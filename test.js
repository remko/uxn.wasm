#!/usr/bin/env node
/* eslint-env node */

const esbuild = require("esbuild");
const path = require("path");
const { wasmTextPlugin } = require("./scripts/esbuild/wasm-text");
const { uxntalPlugin } = require("./scripts/esbuild/uxntal");
const Mocha = require("mocha");

let watch = false;
for (const arg of process.argv.slice(2)) {
  switch (arg) {
    case "--watch":
      watch = true;
      break;
  }
}

function runTests() {
  const mocha = new Mocha();
  delete require.cache[path.join(__dirname, "build", "tests.js")];
  mocha.addFile("build/tests.js");
  mocha.run((failures) => (process.exitCode = failures ? 1 : 0));
}

const buildOptions = {
  bundle: true,
  logLevel: "warning",
  entryPoints: [path.join(__dirname, "tests", "tests.node")],
  target: "node17",
  outdir: path.join(__dirname, "build"),
  external: ["fs", "stream", "util", "events", "path"],
  minify: false,
  loader: {
    ".wasm": "binary",
    ".rom": "binary",
  },
  sourcemap: true,
  plugins: [
    wasmTextPlugin({ debug: true }),
    uxntalPlugin(),
    {
      name: "watch",
      setup(build) {
        build.onEnd((result) => {
          if (result.errors.length > 0) {
            return;
          }
          runTests();
        });
      },
    },
  ],
};

if (watch) {
  (async () => {
    const ctx = await esbuild.context(buildOptions);
    ctx.watch();
  })();
} else {
  esbuild.build(buildOptions);
}

#!/usr/bin/env node
/* eslint-env node */

const esbuild = require("esbuild");
const path = require("path");
const { wasmTextPlugin } = require("./esbuild/wasm-text.cjs");
const { uxntalPlugin } = require("./esbuild/uxntal.cjs");
const Mocha = require("mocha");

let watch = false;
let benchmarks = false;
for (const arg of process.argv.slice(2)) {
  switch (arg) {
    case "--watch":
      watch = true;
      break;
    case "--benchmarks":
      benchmarks = true;
      break;
  }
}

function runTests() {
  const mocha = new Mocha();
  delete require.cache[path.join(__dirname, "..", "build", "tests.cjs")];
  mocha.addFile(path.join(__dirname, "..", "build/tests.cjs"));
  mocha.run((failures) => (process.exitCode = failures ? 1 : 0));
}

const buildOptions = {
  bundle: true,
  logLevel: "warning",
  target: "node17",
  outdir: path.join(__dirname, "..", "build"),
  outExtension: { ".js": ".cjs" },
  external: ["fs", "stream", "util", "events", "path"],
  minify: false,
  loader: {
    ".wasm": "binary",
    ".rom": "binary",
  },
  sourcemap: true,
  plugins: [wasmTextPlugin({ debug: true }), uxntalPlugin({ uxnasm: false })],
};

const testBuildOptions = {
  ...buildOptions,
  entryPoints: [path.join(__dirname, "..", "src", "tests", "tests.node")],
  plugins: buildOptions.plugins.concat([
    {
      name: "runTests",
      setup(build) {
        build.onEnd((result) => {
          if (result.errors.length > 0) {
            return;
          }
          runTests();
        });
      },
    },
  ]),
};

const benchmarkBuildOptions = {
  ...buildOptions,
  entryPoints: [
    path.join(__dirname, "..", "src", "benchmarks", "benchmarks.node"),
  ],
  plugins: buildOptions.plugins.concat([
    {
      name: "runBenchmarks",
      setup(build) {
        build.onEnd((result) => {
          if (result.errors.length > 0) {
            return;
          }
          delete require.cache[
            path.join(__dirname, "..", "build", "benchmarks.cjs")
          ];
          require("../build/benchmarks.cjs");
        });
      },
    },
  ]),
};

if (benchmarks) {
  esbuild.build(benchmarkBuildOptions);
} else {
  if (watch) {
    (async () => {
      const ctx = await esbuild.context(testBuildOptions);
      ctx.watch();
    })();
  } else {
    esbuild.build(testBuildOptions);
  }
}

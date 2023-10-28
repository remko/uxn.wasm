#!/usr/bin/env node
/* eslint-env node */

const esbuild = require("esbuild");
const path = require("path");
const { wasmTextPlugin } = require("./scripts/esbuild/wasm-text");
const { uxntalPlugin } = require("./scripts/esbuild/uxntal");
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
  delete require.cache[path.join(__dirname, "build", "tests.js")];
  mocha.addFile("build/tests.js");
  mocha.run((failures) => (process.exitCode = failures ? 1 : 0));
}

const buildOptions = {
  bundle: true,
  logLevel: "warning",
  target: "node17",
  outdir: path.join(__dirname, "build"),
  external: ["fs", "stream", "util", "events", "path"],
  minify: false,
  loader: {
    ".wasm": "binary",
    ".rom": "binary",
  },
  sourcemap: true,
  plugins: [wasmTextPlugin({ debug: true }), uxntalPlugin()],
};

const testBuildOptions = {
  ...buildOptions,
  entryPoints: [path.join(__dirname, "src", "tests", "tests.node")],
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
  entryPoints: [path.join(__dirname, "src", "benchmarks", "benchmarks.node")],
  plugins: buildOptions.plugins.concat([
    {
      name: "runBenchmarks",
      setup(build) {
        build.onEnd((result) => {
          if (result.errors.length > 0) {
            return;
          }
          delete require.cache[path.join(__dirname, "build", "benchmarks.js")];
          require("./build/benchmarks.js");
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

#!/usr/bin/env node

import * as esbuild from "esbuild";
import * as path from "path";
import * as fs from "fs";
import * as process from "process";
import { createServer } from "http";
import { wasmTextPlugin } from "./esbuild/wasm-text.cjs";
import { uxntalPlugin } from "./esbuild/uxntal.cjs";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const version = JSON.parse(
  fs.readFileSync(path.join(__dirname, "..", "package.json"))
).version;

let dev = false;
let watch = false;
for (const arg of process.argv.slice(2)) {
  switch (arg) {
    case "--development":
      dev = true;
      break;
    case "--watch":
      watch = true;
      break;
  }
}

const INDEX_TEMPLATE = `<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="theme-color" content="#000000" />
    <link href="/uxn-wasm/dist/$BASE.css" rel="stylesheet" />
    <title>$TITLE</title>
  </head>
  <body>
    <script type="text/javascript" src="/uxn-wasm/dist/$BASE.js"></script>
  </body>
</html>
`;

async function handleBuildFinished(result) {
  const indexes = [
    [
      "Uxn.wasm Tests",
      "tests",
      path.join(__dirname, "../public/uxn-wasm/tests"),
    ],
    [
      "Uxn.wasm Benchmarks",
      "benchmarks",
      path.join(__dirname, "../public/uxn-wasm/benchmarks"),
    ],
    [
      "Uxn.wasm Primes Example",
      "primes",
      path.join(__dirname, "../public/uxn-wasm/examples/primes"),
    ],
  ];
  for (const [title, base, outpath] of indexes) {
    let index = INDEX_TEMPLATE.replace(/\$BASE/g, base).replace(
      /\$TITLE/g,
      title
    );
    for (const [out] of Object.entries(result.metafile.outputs)) {
      const outfile = path.basename(out);
      const sourcefile = outfile.replace(/-c\$[^.]+\./, ".");
      // console.log("%s -> %s", sourcefile, outfile);
      index = index.replace(`/${sourcefile}`, `/${outfile}`);
    }
    await fs.promises.mkdir(outpath, { recursive: true });
    await fs.promises.writeFile(path.join(outpath, "index.html"), index);
  }
}

const buildOptions = {
  bundle: true,
  logLevel: "info",
  minify: !dev,
  format: "iife",
  loader: {
    ".wasm": "binary",
    ".rom": "binary",
  },
  sourcemap: true,
  plugins: [wasmTextPlugin({ debug: true }), uxntalPlugin({ uxnasm: false })],
};

const packageBuildOptions = {
  ...buildOptions,
  entryPoints: [path.join(__dirname, "..", "src", "uxn")],
  outfile: path.join(__dirname, "..", "dist", "uxn-wasm.js"),
  format: "iife",
  banner: {
    js: `// Uxn.wasm v${version}\n// https://github.com/remko/uxn.wasm`,
  },
  globalName: "UxnWASM",
};

const esmPackageBuildOptions = {
  ...buildOptions,
  entryPoints: [
    path.join(__dirname, "..", "src", "uxn"),
    path.join(__dirname, "..", "src", "util"),
  ],
  outdir: path.join(__dirname, "..", "dist"),
  outExtension: { ".js": ".esm.js" },
  format: "esm",
};

let webBuildOptions = {
  ...buildOptions,
  entryPoints: [
    path.join(__dirname, "..", "src", "tests", "tests"),
    path.join(__dirname, "..", "src", "benchmarks", "benchmarks"),
    path.join(__dirname, "..", "src", "examples", "primes"),
  ],
  entryNames: dev ? "[name]" : "[name]-c$[hash]",
  assetNames: "[name]-c$[hash]",
  outdir: path.join(__dirname, "../public/uxn-wasm/dist"),
  publicPath: "/uxn-wasm/dist",
  external: ["fs", "stream", "util", "events", "path"],
  metafile: true,
  plugins: buildOptions.plugins.concat([
    {
      name: "watch",
      setup(build) {
        build.onEnd((result) => {
          if (result.errors.length > 0) {
            return;
          }
          handleBuildFinished(result);
        });
      },
    },
  ]),
};

(async () => {
  if (watch) {
    // Simple static file server
    createServer(async function (req, res) {
      const url = req.url.replace(/\?.*/g, "");
      let f = path.join(__dirname, "..", "public", url);
      try {
        if ((await fs.promises.lstat(f)).isDirectory()) {
          f = path.join(f, "index.html");
        }
      } catch (e) {
        // pass
      }
      try {
        const data = await fs.promises.readFile(f);
        res.writeHead(200);
        res.end(data);
      } catch (err) {
        res.writeHead(404);
        res.end(JSON.stringify(err));
      }
    }).listen(8080);

    console.log("listening on http://localhost:8080");

    const esmPackageCtx = await esbuild.context(esmPackageBuildOptions);
    esmPackageCtx.watch();

    const packageCtx = await esbuild.context(packageBuildOptions);
    packageCtx.watch();

    const webCtx = await esbuild.context(webBuildOptions);
    webCtx.watch();
  } else {
    esbuild.build(packageBuildOptions);
    await esbuild.build(esmPackageBuildOptions);
    esbuild.build(webBuildOptions);
  }
})();

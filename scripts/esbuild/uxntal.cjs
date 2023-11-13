/* eslint-env node */

const { promisify } = require("util");
const exec = promisify(require("child_process").exec);
const path = require("path");
const fs = require("fs");

function uxntalPlugin(options = {}) {
  return {
    name: "uxntal",
    setup(build) {
      build.onResolve({ filter: /.\.tal$/ }, async (args) => {
        if (args.resolveDir === "") {
          return;
        }
        const talPath = path.isAbsolute(args.path)
          ? args.path
          : path.join(args.resolveDir, args.path);
        return {
          path: talPath,
          namespace: "uxntal",
          watchFiles: [talPath],
        };
      });
      build.onLoad({ filter: /.*/, namespace: "uxntal" }, async (args) => {
        let contents;
        if (options.uxnasm) {
          contents = (
            await exec(`uxnasm ${args.path} -`, {
              cwd: path.dirname(args.path),
              encoding: "buffer",
            })
          ).stdout;
        } else {
          const asm = (await import("../../src/util/index.js")).asm;
          contents = asm(fs.readFileSync(args.path).toString(), {
            include: (f) => {
              const fn = path.join(path.dirname(args.path), f);
              return fs.readFileSync(fn).toString();
            },
          });
        }
        return {
          contents,
          loader: "binary",
        };
      });
    },
  };
}

module.exports = {
  uxntalPlugin,
};

/* eslint-env node */

const { promisify } = require("util");
const exec = promisify(require("child_process").exec);
const path = require("path");

function uxntalPlugin() {
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
        const r = await exec(`uxnasm ${args.path} -`, {
          cwd: path.dirname(args.path),
          encoding: "buffer",
        });
        return {
          contents: r.stdout,
          loader: "binary",
        };
      });
    },
  };
}

module.exports = {
  uxntalPlugin,
};

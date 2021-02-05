import * as spawn from "cross-spawn";

export const applyElmFormat = (fileOrFolderToFormat: string): void => {
  try {
    const result = spawn.sync(`elm-format`, ['--elm-version', '0.19', '--yes', fileOrFolderToFormat]);
  } catch (error) {
    console.error("Unable to run elm-format. Please ensure that elm-format is available on your PATH and try again. Or re-run using --skip-elm-format.\n\n", error);
    process.exit(1);
  }
};

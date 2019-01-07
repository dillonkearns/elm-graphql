import { execSync } from "child_process";
import * as fs from "fs-extra";

export const applyElmFormat = (fileOrFolderToFormat: string): void => {
  execSync(`npx elm-format --elm-version=0.19 --yes ${fileOrFolderToFormat}/`);
};

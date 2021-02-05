import { execSync } from "child_process";

export const applyElmFormat = (fileOrFolderToFormat: string): void => {
  execSync(`npx elm-format --elm-version=0.19 --yes ${fileOrFolderToFormat}/`);
};

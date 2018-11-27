import { execSync } from "child_process";
import * as fs from "fs-extra";

const globalInstallPath = `${__dirname}/../node_modules/.bin/elm-format`;
const localInstallPath = `${__dirname}/../../.bin/elm-format`;

export const applyElmFormat = (fileOrFolderToFormat: string): void => {
  execSync(`npx elm-format --elm-version=0.19 --yes ${fileOrFolderToFormat}/`);
};

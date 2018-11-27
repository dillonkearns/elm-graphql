import { execSync } from "child_process";
import * as fs from "fs-extra";

const globalInstallPath = `${__dirname}/../node_modules/.bin/elm-format`;
const localInstallPath = `${__dirname}/../../.bin/elm-format`;

export const applyElmFormat = (fileOrFolderToFormat: string): void => {
  const elmFormatPath = findElmFormatPath();

  if (elmFormatPath) {
    console.log("Applying elm-format...");
    execSync(
      elmFormatPath + " --elm-version=0.19 --yes " + fileOrFolderToFormat + "/"
    );
  } else {
    console.log("Couldn't find elm-format binary, skipping formatting...");
  }
};

const findElmFormatPath = (): string | null => {
  if (fs.existsSync(globalInstallPath)) {
    return globalInstallPath;
  } else if (fs.existsSync(localInstallPath)) {
    return localInstallPath;
  } else {
    return null;
  }
};

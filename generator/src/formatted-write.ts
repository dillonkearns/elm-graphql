import { execSync } from "child_process";
import * as fs from "fs-extra";

const globalInstallPath = `${__dirname}/../node_modules/.bin/elm-format`;
const localInstallPath = `${__dirname}/../../.bin/elm-format`;


export const applyElmFormat = (
  fileOrFolderToFormat: string,
): void => {
  const elmFormatPath = findElmFormatPath();
  
  // If there isn't elm-format, nothing to do
  if(!elmFormatPath) 
     return;
  
  console.log("Applying elm-format...")
  const elmFormat = execSync(
    elmFormatPath + " --elm-version=0.19 --yes " + fileOrFolderToFormat + "/"
  );
    
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

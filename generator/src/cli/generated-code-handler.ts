import * as glob from "glob";
import * as fs from "fs-extra";

// export class CliHelpers
export function removeGenerated(path: string): void {
  glob.sync(path + "/**/*.elm").forEach(fs.unlinkSync);
}

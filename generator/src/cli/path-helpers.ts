import * as path from "path";

export function prependBasePath(
  suffixPath: string,
  baseModule: string[],
  outputPath: string
): string {
  return path.join(outputPath, baseModule.join("/"), suffixPath);
}

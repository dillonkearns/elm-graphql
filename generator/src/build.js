#!/usr/bin/env node

import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { execSync } from "child_process";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const packageJsonPath = path.resolve(__dirname, "../../package.json");
const elmJsonPath = path.resolve(__dirname, "../../elm.json");

let npmVersion = "unknown";
let elmVersion = "unknown";

try {
  const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, "utf8"));
  npmVersion = packageJson.version;
  console.log(`NPM package version: ${npmVersion}`);
} catch (e) {
  console.warn("Warning: Could not read NPM package version", e);
}

try {
  const elmJson = JSON.parse(fs.readFileSync(elmJsonPath, "utf8"));
  elmVersion = elmJson.version || "unknown";
  console.log(`Elm package version: ${elmVersion}`);
} catch (e) {
  console.warn("Warning: Could not read Elm package version", e);
}

const templatePath = path.resolve(__dirname, "./versions.ts.template");
const outputPath = path.resolve(__dirname, "./versions.js");

try {
  let template = fs.readFileSync(templatePath, "utf8");

  template = template.replace("%%NPM_VERSION%%", npmVersion);
  template = template.replace("%%ELM_VERSION%%", elmVersion);

  fs.writeFileSync(outputPath, template);
  console.log(
    `Successfully generated versions.js with npm=${npmVersion}, elm=${elmVersion}`
  );
} catch (e) {
  console.error("Error generating versions.ts file:", e);
  process.exit(1);
}

try {
  const outputPath = path.resolve(__dirname, "../../dist/bundle.js");
  const mainElmPath = path.resolve(__dirname, "./Main.elm");
  const versionInfo = `"npm version ${npmVersion}\\nTargeting elm package dillonkearns/elm-graphql@${elmVersion}"`;
  const command = `elm-pages bundle-script --output ${outputPath} ${mainElmPath} --set-version=${versionInfo}`;
  execSync(command, { stdio: "inherit" });
  console.log("Build completed successfully");
} catch (error) {
  console.error("Build failed:", error);
  process.exit(1);
}

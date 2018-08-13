import { spawn } from 'child_process'
import * as fs from 'fs-extra'

const globalInstallPath = `${__dirname}/../node_modules/.bin/elm-format`
const localInstallPath = `${__dirname}/../../.bin/elm-format`

export const writeFile = (path: string, value: string): void => {
  const elmFormatPath = findElmFormatPath()

  if (elmFormatPath) {
    writeWithElmFormat(path, value, elmFormatPath)
  } else {
    writeWithoutFormatting(path, value)
  }
}

const writeWithElmFormat = (
  path: string,
  value: string,
  elmFormatPath: string
): void => {
  const elmFormat = spawn(elmFormatPath, ['--stdin', '--output', path], {
    shell: true
  })

  elmFormat.stdin.write(value)
  elmFormat.stdin.end()

  elmFormat.stdout.on('data', data => {
    console.log(data.toString())
  })

  elmFormat.stderr.on('data', data => {
    console.log(data.toString())
  })

  elmFormat.on('close', code => {
    if (code !== 0) {
      console.log(`elm-format process exited with code ${code}.
Was attempting to write to path ${path} with contents:
${value}`)
      process.exit(code)
    }
  })
}

const writeWithoutFormatting = (path: string, value: string) => {
  fs.writeFileSync(path, value)
}

const findElmFormatPath = (): string | null => {
  if (fs.existsSync(globalInstallPath)) {
    return globalInstallPath
  } else if (fs.existsSync(localInstallPath)) {
    return localInstallPath
  } else {
    return null
  }
}

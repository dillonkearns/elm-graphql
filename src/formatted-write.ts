import { spawn } from 'child_process'

const elmFormatPath = `${__dirname}/../node_modules/.bin/elm-format`

export const writeWithElmFormat = (path: string, value: string): void => {
  const elmFormat = spawn(elmFormatPath, ['--stdin', '--output', path])

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
      console.log(`elm-format process exited with code ${code}`)
    }
  })
}

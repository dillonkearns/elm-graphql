const Elm = require('./Main.elm')
import * as fs from 'fs'
import * as minimist from 'minimist'

const args = minimist(process.argv.slice(2))
const inputPaths = args._
const tsDeclarationPath = args.output

const graphqlUrl = ''
let app = Elm.Main.worker({ graphqlUrl })
app.ports.generatedFiles.subscribe(function(generatedFile: string) {
  try {
    fs.mkdirSync('./src/Api')
  } catch {}
  fs.writeFileSync('./src/Api/Query.elm', generatedFile)
})

// app.ports.parsingError.subscribe(function(errorString: string) {
//   console.error(`Error parsing input file ${inputPaths}\n`)
//   console.error(errorString)
//   process.exit(1)
// })

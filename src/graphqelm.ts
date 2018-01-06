const Elm = require('./Main.elm')
import * as fs from 'fs-extra'
import { GraphQLClient } from 'graphql-request'
import * as http from 'http'
import * as minimist from 'minimist'
import * as request from 'request'
import { writeFile } from './formatted-write'
import { introspectionQuery } from './introspection-query'
const npmVersion = require('../package.json').version
const elmPackageVersion = require('../elm-package.json').version

const usage = `Usage:
  graphqelm url # generate files based on the schema at \`url\` in folder ./src/Api
  graphqelm url --base My.Api.Submodule # generate files based on the schema at \`url\` in folder ./src/My/Api/Submodule
  graphqelm url --includeDeprecated # includes deprecated enums and fields (they are omitted by default)

  graphqelm --version # print the current graphqelm version
  graphqelm url [--header 'headerKey: header value'...] # you can supply multiple header args`

const args = minimist(process.argv.slice(2))
if (args.version) {
  console.log('npm version ', npmVersion)
  console.log(
    `Targeting elm package dillonkearns/graphqelm@${elmPackageVersion}`
  )
  process.exit(0)
}
const baseArgRegex = /^[A-Z][A-Za-z_]*(\.[A-Z][A-Za-z_]*)*$/
const baseModuleArg: undefined | string = args.base
function isValidBaseArg(baseArg: string): boolean {
  return !!baseArg.match(baseArgRegex)
}
if (baseModuleArg && !isValidBaseArg(baseModuleArg)) {
  console.log(
    `--base was '${baseModuleArg}' but must be in format ${baseArgRegex}`
  )
  process.exit(1)
}
const includeDeprecated: boolean = !!args.includeDeprecated
const headerArg: undefined | string | [string] = args.header
const addHeader = (object: any, header: string) => {
  const [headerKey, headerValue] = header.split(':')
  object[headerKey] = headerValue
  return object
}
let headers = {}
if (typeof headerArg === 'string') {
  addHeader(headers, headerArg)
} else if (headerArg == undefined) {
} else {
  headerArg.forEach(header => {
    addHeader(headers, header)
  })
}
const baseModule = baseModuleArg ? baseModuleArg.split('.') : ['Api']
const graphqlUrl: undefined | string = args._[0]
if (!graphqlUrl) {
  console.log(usage)
  process.exit(0)
}
const tsDeclarationPath = args.output

const onDataAvailable = (data: {}) => {
  let app = Elm.Main.worker({ data, baseModule })
  app.ports.generatedFiles.subscribe(function(generatedFile: any) {
    fs.mkdirpSync(`./src/${baseModule.join('/')}/Object`)
    fs.mkdirpSync(`./src/${baseModule.join('/')}/Interface`)
    fs.mkdirpSync(`./src/${baseModule.join('/')}/Union`)
    fs.mkdirpSync(`./src/${baseModule.join('/')}/Enum`)
    for (let key in generatedFile) {
      let path = './src/' + key
      let value = generatedFile[key]
      writeFile(path, value)
    }
  })
}
new GraphQLClient(graphqlUrl, {
  mode: 'cors',
  headers: headers
})
  .request(introspectionQuery, { includeDeprecated: includeDeprecated })
  .then(data => {
    onDataAvailable(data)
  })
  .catch(err => {
    console.log(err.response || err)
    process.exit(1)
  })

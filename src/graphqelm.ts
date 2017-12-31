const Elm = require('./Main.elm')
import * as fs from 'fs-extra'
import { GraphQLClient } from 'graphql-request'
import * as http from 'http'
import * as minimist from 'minimist'
import * as request from 'request'
import { writeFile } from './formatted-write'
import { introspectionQuery } from './introspection-query'
const version = require('../package.json').version

const usage = `Usage:
  graphqelm url # generate files based on the schema at \`url\` in folder ./src/Api
  graphqelm url --base My.Api.Submodule # generate files based on the schema at \`url\` in folder ./src/My/Api/Submodule
  graphqelm --version # print the current graphqelm version
  graphqelm url [--header 'headerKey: header value'...] # you can supply multiple header args`

const args = minimist(process.argv.slice(2))
if (args.version) {
  console.log(version)
  process.exit(0)
}
const baseModuleArg: undefined | string = args.base
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
  .request(introspectionQuery)
  .then(data => {
    onDataAvailable(data)
  })
  .catch(err => {
    console.log(err.response)
    process.exit(1)
  })

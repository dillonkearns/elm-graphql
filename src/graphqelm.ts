const Elm = require('./Main.elm')
import * as fs from 'fs'
import { GraphQLClient } from 'graphql-request'
import * as http from 'http'
import * as minimist from 'minimist'
import * as request from 'request'

const usage = `Usage:
  graphqelm url # generate files based on the schema at \`url\` in folder ./src/Api
  graphqelm url [--header 'headerKey: header value'...] # you can supply multiple header args`

const args = minimist(process.argv.slice(2))
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
const graphqlUrl: undefined | string = args._[0]
if (!graphqlUrl) {
  console.log(usage)
  process.exit(0)
}
const tsDeclarationPath = args.output

const onDataAvailable = (data: {}) => {
  let app = Elm.Main.worker({ data })
  app.ports.generatedFiles.subscribe(function(generatedFile: any) {
    try {
      fs.mkdirSync('./src/Api')
    } catch {}
    for (let key in generatedFile) {
      let value = generatedFile[key]
      fs.writeFileSync('./src/' + key, value)
    }
  })
}
const introspectionQuery = `{
    __schema {
      queryType {
        name
      }
      mutationType {
        name
      }
      types {
        ...FullType
      }
    }
  }

  fragment FullType on __Type {
    kind
    name
    description
    fields(includeDeprecated: true) {
      name
      description
      args {
        ...InputValue
      }
      type {
        ...TypeRef
      }
      isDeprecated
      deprecationReason
    }
    inputFields {
      ...InputValue
    }
    interfaces {
      ...TypeRef
    }
    enumValues(includeDeprecated: true) {
      name
      description
      isDeprecated
      deprecationReason
    }
    possibleTypes {
      ...TypeRef
    }
  }

  fragment InputValue on __InputValue {
    name
    description
    type { ...TypeRef }
    defaultValue
  }

  fragment TypeRef on __Type {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
        ofType {
          kind
          name
          ofType {
            kind
            name
            ofType {
              kind
              name
              ofType {
                kind
                name
                ofType {
                  kind
                  name
                }
              }
            }
          }
        }
      }
    }
  }`
new GraphQLClient(graphqlUrl, {
  mode: 'cors',
  headers: headers
})
  .request(introspectionQuery)
  .then(data => {
    onDataAvailable(data)
  })
  .catch(err => {
    console.log('error', err)
    process.exit(1)
  })

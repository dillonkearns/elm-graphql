const Elm = require('./Main.elm')
import * as fs from 'fs'
import * as http from 'http'
import * as minimist from 'minimist'
import * as request from 'request'

const args = minimist(process.argv.slice(2))
const inputPaths = args._
const tsDeclarationPath = args.output

const onDataAvailable = (data: any) => {
  let app = Elm.Main.worker({ data })
  app.ports.generatedFiles.subscribe(function(generatedFile: any) {
    try {
      fs.mkdirSync('./src/Api')
    } catch {}
    let foo = { a: 1, b: 2 }
    for (let key in generatedFile) {
      let value = generatedFile[key]
      fs.writeFileSync('./src/Api/' + key, value)
    }
  })
}
const body = `query IntrospectionQuery {
    __schema {
      # queryType { name
      # ...FullType
      # }
      # mutationType { name }
      # subscriptionType { name }
      types {
        ...FullType
      }
      # directives {
      #   name
      #   description
      #   args {
      #     ...InputValue
      #   }
      #   onOperation
      #   onFragment
      #   onField
      # }
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
        }
      }
    }
  }`
request.post('http://localhost:4000/api', { body }, function(a, response, c) {
  onDataAvailable(JSON.parse(response.body))
})

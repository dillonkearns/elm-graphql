# GraphqElm

If your GraphqElm query compiles, it is guaranteed that:

1. It is a valid query (according to your API's GraphQL schema)
2. The response's data type is known at compile-time

**Warning** This project is currently in alpha and may see rapid change.

See the `examples/` folder for a working example.

## Usage

Install the command-line tool. It is recommended that you save this as a dev
dependency so that everyone on your project is using the same version.

```shell
npm install --save-dev graphqelm
# you can now run it locally with the ./node_modules/.bin/graphqelm binary,
# or by calling it through an npm script as in this projects package.json
```

When you call the `graphqelm` binary, you just pass in your GraphQL endpoint and
it will introspect the schema and generate Elm code so you can create queries in
elm without writing any decoders yourself.

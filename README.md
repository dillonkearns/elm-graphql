# GraphQElm

**Warning** This project is currently in alpha and may see rapid change before
the 1.0 release.

See the `examples/` folder for a working example.

## Design Goals

GraphQElm is a tool for generating and using GraphQL queries in Elm such that:

* If a query compiles it is guaranteed to be valid
* The compiler knows the exact shape of the data a query will return at
  compile-time
* The user doesn't need to give any hints about the shape of the data, it's
  inferred from the schema

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

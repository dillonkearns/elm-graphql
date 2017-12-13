# GraphqElm

I built this package because I wanted to have something that:

1. Gives you type-safe GraphQL queries (if it compiles, it's valid according to the schema),
2. Creates decoders for you in a seamless and failsafe way, and
3. Eliminates GraphQL features in favor of Elm language constructs where possible for a simpler UX (for example, GraphQL variables & fragments should just be Elm functions, constants, lets).

See an [example in action on Ellie](https://rebrand.ly/graphqelm).

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

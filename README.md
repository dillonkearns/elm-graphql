# GraphqElm

[![Build Status](https://travis-ci.org/dillonkearns/graphqelm.svg?branch=master)](https://travis-ci.org/dillonkearns/graphqelm)

I built this package because I wanted to have something that:

1. Gives you type-safe GraphQL queries (if it compiles, it's valid according to the schema),
2. Creates decoders for you in a seamless and failsafe way, and
3. Eliminates GraphQL features in favor of Elm language constructs where possible for a simpler UX (for example, GraphQL variables & fragments should just be Elm functions, constants, lets).

See an [example in action on Ellie](https://rebrand.ly/graphqelm).

See more end-to-end example code in the
[`examples/`](https://github.com/dillonkearns/graphqelm/tree/master/examples)
folder.

## Usage

`graphqelm` generates Elm code that allows you to build up type-safe GraphQL requests. Here are the steps to setup `graphqelm`.

1. Add [the `Graphqelm` elm package](http://package.elm-lang.org/packages/dillonkearns/graphqelm/latest)
   as a dependency in your `elm-package.json`.
   ```shell
   elm package install dillonkearns/graphqelm
   ```
2. Install the `graphqelm` command line tool through npm. This is what you will use to generate Elm code for your API.
   It is recommended that you save the `graphqelm` command line tool as a dev
   dependency so that everyone on your project is using the same version.

   ```shell
   npm install --save-dev graphqelm
   # you can now run it locally with the ./node_modules/.bin/graphqelm binary,
   # or by calling it through an npm script as in this project's package.json
   ```

3. Run the `graphqelm` command line tool installed above to generate your code. If you used the `--save-dev` method above, you can simply create a script in your package.json like the following:

   ```
   {
     "name": "star-wars-graphqelm-project",
     "version": "1.0.0",
     "scripts": {
       "api": "graphqelm https://graphqelm.herokuapp.com/api --base StarWars"
     }
   ```

4. With the above in your `package.json`, running `npm run api` will generate Graphqelm code for you to call in `./src/StarWars/`. You can now use the generated code as in this [Ellie example](https://rebrand.ly/graphqelm) or in the [`examples`](https://github.com/dillonkearns/graphqelm/tree/master/examples) folder.

By default, deprecated Fields and Enums are not included in the generated
GraphqElm code. Use the `--includeDeprecated` flag when running the `graphqelm`
commandline tool if you would like to include them.

## Contributors

Thank you Mario Martinez ([martimatix](https://github.com/martimatix)) for
all your feedback and for the elm-format PR!

Thank you Mike Stock ([mikeastock](https://github.com/mikeastock/)) for
setting up Travis CI!

## Roadmap

All core features are supported. That is, you can build any query or mutation
with your graphqelm-generated code, and it is guaranteed to be valid according
to your server's schema.

I would like to investigate adding support for subscriptions, as well as generating
helpers to make pagination simpler for Connections (based on the
[Relay Cursor Connections Specification](https://facebook.github.io/relay/graphql/connections.htm)).

See [the full roadmap on Trello](https://trello.com/b/BCIWtZeL/graphqelm).

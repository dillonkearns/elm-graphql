<img src="https://cdn.rawgit.com/martimatix/logo-graphqelm/master/logo.svg" alt="graphqelm logo" width="40%" align="right">

# GraphqElm

[![Build Status](https://travis-ci.org/dillonkearns/graphqelm.svg?branch=master)](https://travis-ci.org/dillonkearns/graphqelm)

Why use this package over the other available Elm GraphQL packages? This is the only one that
generates type-safe code for your entire schema. (It's also the only type-safe
library with Elm 0.18 support, see
[this discourse thread](https://discourse.elm-lang.org/t/introducing-graphqelm-a-tool-for-type-safe-graphql-queries/472/5?u=dillonkearns)
).

I built this package because I wanted to have something that:

1. Gives you type-safe GraphQL queries (if it compiles, it's valid according to the schema),
2. Creates decoders for you in a seamless and failsafe way, and
3. Eliminates GraphQL features in favor of Elm language constructs where possible for a simpler UX (for example, GraphQL variables & fragments should just be Elm functions, constants, lets).

See an [example in action on Ellie](https://rebrand.ly/graphqelm).

See more end-to-end example code in the
[`examples/`](https://github.com/dillonkearns/graphqelm/tree/master/examples)
folder.

## Overview

`graphqelm` is an Elm package and accompanying command-line code generator that creates type-safe Elm code for your GraphQL endpoint. You don't write any decoders for your API with `graphqelm`, instead you simply select which fields you would like, similar to a standard GraphQL query but in Elm. For example, this GraphQL query

```graphql
query {
  human(id: "1001") {
    name
  }
}
```

would look like this in `graphqelm` (the code in this example that is prefixed with `StarWars` is auto-generated)

```elm
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import StarWars.Object
import StarWars.Object.Human as Human
import StarWars.Query as Query


type alias Response =
    { vader : Maybe Human }


query : SelectionSet Response RootQuery
query =
    Query.selection Response
        |> with (Query.human { id = StarWars.Scalar.Id "1001" } human)


type alias Human =
    { name : String }


human : SelectionSet Human Human.Human
human =
    Human.selection Human
        |> with Human.name
```

GraphQL and Elm are a perfect match because GraphQL is used to enforce the types that your API takes as inputs and outputs, much like Elm's type system does within Elm. `elm-graphql` simply bridges this gap by making your Elm code aware of your GraphQL server's schema. If you are new to GraphQL, [graphql.org/learn/](http://graphql.org/learn/) is an excellent way to learn the basics.

After installing the command line tool and Elm package, running `elm-graphql` just looks like

```bash
graphqelm https://graphqelm.herokuapp.com --base Swapi --output examples/src
```

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

## Contributors

Thank you Mario Martinez ([martimatix](https://github.com/martimatix)) for
all your feedback, the elm-format PR, and for [the incredible logo design](https://github.com/martimatix/logo-graphqelm/)!

Thank you Mike Stock ([mikeastock](https://github.com/mikeastock/)) for
setting up Travis CI!

## Roadmap

All core features are supported. That is, you can build any query or mutation
with your graphqelm-generated code, and it is guaranteed to be valid according
to your server's schema.

I am currently experimenting with subscriptions, checkout
[this live demo](https://rebrand.ly/graphqelm-subscriptions) or
[`examples/src/Subscription.elm`](https://github.com/dillonkearns/graphqelm/blob/master/examples/src/Subscription.elm)
for an example using Phoenix/Absinthe as a backend.

I would like to investigate generating helpers to make pagination simpler
for Connections (based on the
[Relay Cursor Connections Specification](https://facebook.github.io/relay/graphql/connections.htm)).
If you have ideas on this chime in on [this thread](https://github.com/dillonkearns/graphqelm/issues/29).

See [the full roadmap on Trello](https://trello.com/b/BCIWtZeL/graphqelm).

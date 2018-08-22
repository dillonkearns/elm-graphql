<img src="https://cdn.rawgit.com/martimatix/logo-graphqelm/master/logo.svg" alt="graphqelm logo" width="40%" align="right">

# dillonkearns/elm-graphql

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
[`examples/`](https://github.com/dillonkearns/elm-graphql/tree/master/examples)
folder.

## Overview

`dillonkearns/elm-graphql` is an Elm package and accompanying command-line code generator that creates type-safe Elm code for your GraphQL endpoint. You don't write any decoders for your API with `graphqelm`, instead you simply select which fields you would like, similar to a standard GraphQL query but in Elm. For example, this GraphQL query

```graphql
query {
  human(id: "1001") {
    name
  }
}
```

would look like this in `graphqelm` (the code in this example that is prefixed with `StarWars` is auto-generated)

```elm
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet, with)
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

## Learning Resources

If you're just starting out, here are some great resources:

- There are a couple of chapters so far in [The Official `dillonkearns/elm-graphql` Gitbook](https://dillonkearns.gitbooks.io/elm-graphql/content/)
- [A Beginner's Guide to GraphQL with Elm](https://medium.com/@zenitram.oiram/a-beginners-guide-to-graphql-with-elm-315b580f0aad) by [@martimatix](https://github.com/martimatix)
- [Graphqelm: Optional Arguments in a Language Without Optional Arguments](https://medium.com/@zenitram.oiram/graphqelm-optional-arguments-in-a-language-without-optional-arguments-d8074ca3cf74) by [@martimatix](https://github.com/martimatix)

If you're wondering why code is generated a certain way, you're likely to find an answer in the [Frequently Asked Questions (FAQ)](https://github.com/dillonkearns/elm-graphql/blob/master/FAQ.md).

There's a very helpful group of people in the #graphql channel in [the Elm Slack](http://elmlang.herokuapp.com/). Don't hesitate to ask any questions about getting started, best practices, or just general GraphQL in there!

## Usage

`graphqelm` generates Elm code that allows you to build up type-safe GraphQL requests. Here are the steps to setup `graphqelm`.

1. Add [the `dillonkearns/elm-graphql` elm package](http://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest)
   as a dependency in your `elm-package.json`.
   ```shell
   elm package install dillonkearns/elm-graphql
   ```
2. Install the `@dillonkearns/elm-graphql` command line tool through npm. This is what you will use to generate Elm code for your API.
   It is recommended that you save the `@dillonkearns/elm-graphql` command line tool as a dev
   dependency so that everyone on your project is using the same version.

   ```shell
   npm install --save-dev graphqelm
   # you can now run it locally with the ./node_modules/.bin/graphqelm binary,
   # or by calling it through an npm script as in this project's package.json
   ```

3. Run the `@dillonkearns/elm-graphql` command line tool installed above to generate your code. If you used the `--save-dev` method above, you can simply create a script in your package.json like the following:

   ```
   {
     "name": "star-wars-graphqelm-project",
     "version": "1.0.0",
     "scripts": {
       "api": "elm-graphql https://graphqelm.herokuapp.com/api --base StarWars"
     }
   ```

4. With the above in your `package.json`, running `npm run api` will generate `dillonkearns/elm-graphql` code for you to call in `./src/StarWars/`. You can now use the generated code as in this [Ellie example](https://rebrand.ly/graphqelm) or in the [`examples`](https://github.com/dillonkearns/elm-graphql/tree/master/examples) folder.

## Contributors

Thank you Mario Martinez ([martimatix](https://github.com/martimatix)) for
all your feedback, the elm-format PR, and for [the incredible logo design](https://github.com/martimatix/logo-graphqelm/)!

Thank you Mike Stock ([mikeastock](https://github.com/mikeastock/)) for
setting up Travis CI!

Thanks for [the reserved words pull request](https://github.com/dillonkearns/elm-graphql/pull/41) @madsflensted!

## Roadmap

All core features are supported. That is, you can build any query or mutation
with your graphqelm-generated code, and it is guaranteed to be valid according
to your server's schema.

I am currently experimenting with subscriptions, checkout
[this live demo](https://rebrand.ly/graphqelm-subscriptions) or
[`examples/src/Subscription.elm`](https://github.com/dillonkearns/elm-graphql/blob/master/examples/src/Subscription.elm)
for an example using Phoenix/Absinthe as a backend.

I would like to investigate generating helpers to make pagination simpler
for Connections (based on the
[Relay Cursor Connections Specification](https://facebook.github.io/relay/graphql/connections.htm)).
If you have ideas on this chime in on [this thread](https://github.com/dillonkearns/elm-graphql/issues/29).

See [the full roadmap on Trello](https://trello.com/b/BCIWtZeL/graphqelm).

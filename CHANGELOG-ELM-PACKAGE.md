# Changelog [![Elm package](https://img.shields.io/elm-package/v/dillonkearns/elm-graphql.svg)](https://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest/)

All notable changes to
[the `dillonkearns/elm-graphql` elm package](http://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [5.0.12] - 2023-08-29

### Fixed

- Fix bug where hashes would sometimes be omitted in cases where they are needed to disambiguate between sibling fields when they have different types for sibling fields with the same name. See [#633](https://github.com/dillonkearns/elm-graphql/pull/633).

## [5.0.11] - 2022-09-14

### Fixed

- JSON objects are not valid in GraphQL because object properties are unquoted in GraphQL syntax. This release includes a fix that will remove quotes from JSON object properties in the serialized GraphQL query to make them valid GraphQL syntax. Note that not all JSON can be made valid with this approach because some keys need to be quoted (see [#606](https://github.com/dillonkearns/elm-graphql/issues/606) for a discussion of a possible approach to handle those cases). This release fixes [#570](https://github.com/dillonkearns/elm-graphql/issues/570). See [#605](https://github.com/dillonkearns/elm-graphql/pull/605). Thank you [@SiriusStarr](https://github.com/SiriusStarr) for the fix!

## [5.0.10] - 2022-06-20

### Changed

- Hashes are now only included in the GraphQL query when they are needed to disambiguate between other sibling fields that would cause a name collision.
  These details aren't important if you don't depend on any internals, but they will reduce noise when inspecting requests for debugging purposes. Note that
  it's still important not to depend on any low-level details - be sure not to write code that depends on whether or not field aliases with hashes are used
  as `elm-graphql` abstracts away these details.

  This change means that many fields will be unhashed now:

```diff
query {
-  avatar2648687506: avatar(size: 1)
+  avatar(size: 1)
}
```

However, a query like this will still have hashed field aliases because the hashes are needed to avoid a name collision when we query avatar twice at the same level within a selection set:

```graphql
query {
  avatar0: avatar
  avatar2648687506: avatar(size: 1)
}
```

Thank you [@hariroshan](https://github.com/hariroshan) for thinking of this improvement and implementing it! See PR [#596](https://github.com/dillonkearns/elm-graphql/pull/596).

## [5.0.9] - 2022-01-21

### Fixed

- Query params are now passed through for POST requests (they were always empty before).

## [5.0.8] - 2021-11-29

### Fixed

- Order is now correctly preserved. Version 5.0.6 broke this condition, which is required by the GraphQL spec for mutations so they can be performed in a
  specific order. Thank you @kyasu1 for the PR! See [#575](https://github.com/dillonkearns/elm-graphql/pull/575).

## [5.0.7] - 2021-10-26

### Fixed

- `operationName` is now passed in the body of mutation requests (see [#566](https://github.com/dillonkearns/elm-graphql/pull/566)). Thank you [@galdiuz](https://github.com/galdiuz) for the PR!

## [5.0.6] - 2021-08-24

### Changed

- Merge duplicate Leaf and Composite fields so that there are never more than 1 field in a selection set with the same field name. See [#556](https://github.com/dillonkearns/elm-graphql/pull/556). Fixes [#495](https://github.com/dillonkearns/elm-graphql/issues/495).
  Technically having Leaf fields with the same field alias or field name is allowed by the GraphQL Spec, but this change makes field aliases and names unique for both Leaf and Composite fields.

## [5.0.5] - 2021-03-15

### Fixed

- The input object loop detection had some false positives. This fix prevents using nested input object loop wrappers for some deeply nested input objects that are actually not circular. See [#475](https://github.com/dillonkearns/elm-graphql/pull/475/). Thank you [@mcasper](https://github.com/mcasper)!

## [5.0.4] - 2021-02-10

### Fixed

- The README now shows a badge with the GitHub Actions CI status (Travis is deprecated and is no longer being used here).

## [5.0.3] - 2020-10-18

### Changed

- Renamed `SelectionSet decodesTo typeLock` type variable to `SelectionSet decodesTo scope`. See [#407](https://github.com/dillonkearns/elm-graphql/pull/407).

## [5.0.2] - 2020-09-17

### Fixed

- Pulled in vendor code for murmur3 package because of a GitHub username change that started causing problems
  installing that package from the Elm package repository. Thank you [neslinesli93](https://github.com/neslinesli93) for the fix!
  See [#397](https://github.com/dillonkearns/elm-graphql/pull/397).

## [5.0.1] - 2020-08-30

### Changed

- The optional `operationName` field is now sent in the POST body, or GET query parameters, when a request is performed.
  Even though it's optional, some tooling depends on that field being present, so this may make some server-side tools happy.
  See [#388](https://github.com/dillonkearns/elm-graphql/pull/388). Thank you to [Yoni](https://github.com/yonigibbs) for this contribution!

## [5.0.0] - 2019-12-16

### Changed

- (MAJOR API change) Fix order of arguments for Http pipeline function, `withOperationName`
  (fixes [#254](https://github.com/dillonkearns/elm-graphql/issues/254)).
- (MAJOR API change) Switch `discardParsedErrorData` from returning a `()` to an unconstrained `a`.
  This makes it a little more flexible for users in terms of the types
  it allows, without changing the behavior. See [#245](https://github.com/dillonkearns/elm-graphql/pull/245)
  (thank you [@Jayshua](https://github.com/Jayshua)!).
- (MAJOR API change) fix typo in internal function name (`exhuastiveFragmentSelection` -> `exhaustiveFragmentSelection`).

## [4.5.0] - 2019-12-03

### Fixed

- Expose `Graphql.Http.withOperationName` function (which was mistakenly left out last release).

## [4.4.0] - 2019-10-14

### Added

- `Graphql.Http.withOperationName` allows you to (optionally) add
  operation names to your GraphQL queries (thank you @asterite for your PR!
  https://github.com/dillonkearns/elm-graphql/pull/195)

## [4.3.1] - 2019-06-30

### Fixed

- Parse pre-execution GraphQL response that has "error" but no "data"
  (see [#168](https://github.com/dillonkearns/elm-graphql/issues/168)).

## [4.3.0] - 2019-06-13

### Added

- Added `SeletionSet.foldl`
- Added `OptionalArgument.fromMaybeWithNull`

## [4.2.1] - 2019-04-17

### Changed

- Don't use field aliases for \_\_typename fields (see [PR #121](https://github.com/dillonkearns/elm-graphql/pull/121)).

## [4.2.0] - 2019-01-25

### Added

- `SelectionSet.list` lets you combine a `List` of
  `SelectionSet value scope`s into a single `SelectionSet (List value) scope`.
- `SelectionSet.dict` lets you combine a `List` of
  `(String, SelectionSet value scope)`s into a single `SelectionSet (Dict String value) scope`.
  The `String`s in the list are used as the key in the `Dict`.
- Expose type `Graphql.Codec` (for use with the `--scalar-codecs` CLI flag,
  see [this example](https://github.com/dillonkearns/elm-graphql/blob/master/examples/src/Example07CustomCodecs.elm)).

## [4.1.0] - 2018-12-16

### Added

- Expose type `Graphql.Http.HttpError`

## [4.0.0] - 2018-12-15

### Changed

- `elm/http@2.0.0` removed some important data from `Http.Error`. It's now just
  (`BadStatus Int` rather than `BadStatus (Response String)`). See the type
  definitions here:
  https://package.elm-lang.org/packages/elm/http/1.0.0/Http#Error
  https://package.elm-lang.org/packages/elm/http/latest/Http#Error

  In order to allow `dillonkearns/elm-graphql` users to capture the body of
  responses with a bad status, we need to do a major version bump.

  In a nutshell, this change introduces a custom type that looks like this:

```elm
module Graphql.Http.Error exposing -- ..
type alias Error parsedData =
    RawError parsedData HttpError

type RawError parsedData httpError
    = GraphqlError (GraphqlError.PossiblyParsedData parsedData) (List GraphqlError.GraphqlError)
    | HttpError httpError


type HttpError
    = BadUrl String
    | Timeout
    | NetworkError
    | BadStatus Http.Metadata String
    | BadPayload Json.Decode.Error
```

See the full details here: https://github.com/dillonkearns/elm-graphql/issues/89
Note that this will only require you to change your code if you were destructuring
the `Graphql.Http.HttpError` values. And the changes introduce a function to map
into the old type easily:

```elm
withSimpleHttpError : Result (Error parsedData) decodesTo -> Result (RawError parsedData Http.Error) decodesTo
```

Well, not exactly the old type, the old type was `Graphql.Http.Error parsedData`,
the new type is written out as `Graphql.Http.RawError parsedData Http.Error`,
but it would contains the same data as before.

### Removed

- `Graphql.Http.fromHttpError` was removed as it no longer makes sense with
  the default type wrapping `Graphql.Http.HttpError` instead of `Http.Error`.
  See the `Graphql.Http.withSimpleHttpError` docs if you are looking to
  combine a Graphql response with an Http response.
- Removed `ignoreParsedErrorData` to avoid confusion. It's easier to use
  `discardParsedErrorData`, use that function instead. It maps the entire
  result so you don't have to use it in combination with `Graphql.Http.mapError`.

## [3.0.0] - 2018-12-08

### Changed

- Only the internal code changed in this release, so you won't need to do anything
  to upgrade your own code besides re-running the latest CLI tool. The change
  includes the type information of a field in its field alias hash. Since
  the alias is now unique to each field's type and argument values, you
  can no longer encounter validation errors when you build up a query using
  unions or interfaces that include fields with the same names but different types.
  See https://github.com/dillonkearns/elm-graphql/issues/95 for more details.

## [2.0.0] - 2018-12-02

### Changed

- The `Field` module has been removed. With this change, think of a `Field` as
  just a special case of a `SelectionSet`. The `SelectionSet` is now used
  for both a single element or multiple (much like a single `Cmd msg` or multiple
  with `Cmd.batch [cmd1, cmd2]`). This means that any functions you called on
  `Field` before are now in `SelectionSet` (so it's `SelectionSet.nonNullOrFail`,
  `SelectionSet.map`, etc). The [latest docs page for `SelectionSet`](https://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest/Graphql-SelectionSet)
  now has a nice tutorial in it that walks you through the new way that
  `SelectionSet`s work. If you're trying to wrap your head around the
  new design, I highly recommend you read this page!

  To migrate to the new version, just follow these steps:

  - Find and delete all calls to `import Graphql.Field` in your code entirely
  - Anywhere you called `SelectionSet.fieldSelection` can simply be removed now.
  - Anywhere you called `Field.map`, `mapOrFail`, etc., is just `SelectionSet.map`, etc. now.
  - Remove any calls to `<GeneratedModule>.selection` and replace it with `SelectionSet.succeed`
    (for Union types, the `selection` function has been renamed to `fragments`, see the last point below).
  - Any annotations which were `Field decodesTo scope`, simply change them to
    `SelectionSet decodesTo scope`

- The `.selection` function for Unions has been renamed to `.fragments` to be consistent
  with the naming for Interfaces.

### Added

- Add `SelectionSet.mapN` functions for an alternate syntax to the pipeline syntax
  (starting a pipeline with `SelectionSet.succeed`).
- New `SeletionSet.withDefault`. Just a convenience function which is equivalent
  to `SelectionSet.map Maybe.withDefault`.

## [1.5.1] - 2018-12-01

### Fixed

- The `withCredentials` was inverted with release 1.4.0. So it would use
  the `Http.risky` and `Http.riskyTask` versions if you _didn't_ call `withCredentials`
  , and it would use the regular `Http.request` and `Http.task` builders if you
  _did_. Thank you [@kyasu1](https://github.com/kyasu1) for reporting the problem!
  See [#97](https://github.com/dillonkearns/elm-graphql/issues/97).

## [1.5.0] - 2018-11-27

### Added

- Add new internal builder function, for use with the new generated code for
  building exhaustive Union and Interface fragments.
  See this diff to understand the changes and how to migrate:
  [e530d94](https://github.com/dillonkearns/elm-graphql/pull/85/commits/e530d94cded94f43135aa7e68233ab4f8b7e5912).

## [1.4.0] - 2018-11-15

### Changed

- Bump underlying `elm/http` and `elm/json` packages.

### Added

- Add
  [`Graphql.Http.sendWithTracker`](https://package.elm-lang.org/packages/dillonkearns/elm-graphql/1.4.0/Graphql-Http#sendWithTracker)
  function, see the [`Http.request`](https://package.elm-lang.org/packages/elm/http/latest/Http#request)
  docs for details and functions to track Http requests in Elm.

## [1.3.0] - 2018-11-14

### Added

- Add `discardParsedErrorData` to make it easier to map errors into a type that can
  be easily merged together (something that looks like `Result (Error ()) decodesTo`).
- Add `parseableErrorAsSuccess`, which treats any GraphQL errors like successful
  responses (throws away the GraphQL error) as long as it is able to successfully
  run the decoder (it won't be able to if the data returned is partial).

## [1.2.0] - 2018-11-06

### Added

- [`SelectionSet.withFragment`](https://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest/Graphql-SelectionSet#withFragment)
  allows you to include fields from a `SelectionSet`
  when you are defining a `SelectionSet`. This is a nice tool for modularizing your queries!
  [Check out an example in action](https://github.com/dillonkearns/elm-graphql/blob/ef2399b5e44ac30e630090f207702d5f962725d2/examples/src/complex/ElmReposRequest.elm#L84).
- [`SelectionSet.map2`](https://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest/Graphql-SelectionSet#map2)
  allows you to combine two `SelectionSet`s into one.
- New `OptionalArgument.map` funciton, thanks [Romario](https://github.com/romariolopezc)!
  ([See PR #73](https://github.com/dillonkearns/elm-graphql/pull/73)).

### Changed

- The generated selection sets now will include at least a `__typename` to ensure
  they are valid (empty selection sets are invalid in GraphQL). Previously you
  could get an invalid GraphQL query if you used `SelectionSet.hardcoded`.
- (Internal implementation details, not public facing though the generated
  queries will look slightly different now) - The `alias` generation has changed to
  be independent of surrounding context. The new
  algorithm will generate an `alias` for any field if and only if that field has arguments.
  [You can read more about the details and rationale on this thread](https://github.com/dillonkearns/elm-graphql/issues/64#issuecomment-435733851).

## [1.1.0] - 2018-08-28

### Changed

- Extracted `scalarDecoder` constant and moved to module in the `dillonkearns/elm-graphql` package.
  This is only used in generated code. This change allows us to remove all `Debug.toString` calls
  in generated code so that users can compile their code with the `--optimize` flag. This resolves
  [#68](https://github.com/dillonkearns/elm-graphql/issues/68).

## [1.0.0] - 2018-08-23

Take a look at the [`dillonkearns/elm-graphql` Elm 0.19 upgrade guide](https://github.com/dillonkearns/elm-graphql/blob/master/docs/elm-19-upgrade.md).

### Removed

- **Subscriptions Low-Level Data-Transfer Layer** As before, this library will
  generate code based on the subscriptions defined in your GraphQL schema.
  And you will be able to use `Graphql.Document.serializeSubscription` to
  get a `String` that you can send over to your server when you open a subscription.
  Then you'll be able to use the `Graphql.Document.decoder` from your subscription
  to decode the JSON responses from the server.
  What's been removed is just the low level protocols for doing the websocket connection.
  As per [this issue](https://github.com/dillonkearns/elm-graphql/issues/43),
  this responsibility will be moved out of the core `dillonkearns/elm-graphql`
  package in order to decouple this library from the low-level details which
  differ between different GraphQL server implementations.

The low-level data transfer logic for connecting over websockets to a subscription
has been removed from this package.
https://github.com/dillonkearns/elm-graphql/issues/43

### Changed

- Rename package from `dillonkearns/graphqelm` to `dillonkearns/elm-graphql`
  to follow the elm literal naming convention (see
  [issue #23](https://github.com/dillonkearns/elm-graphql/issues/23)).

## BELOW THIS IS FOR `dillonkearns/graphqelm` (before [the rename to `dillonkearns/elm-graphql`](https://github.com/dillonkearns/elm-graphql/issues/23))

## [11.2.0] - 2018-07-02

### Added

- Add `Selectionset.fieldSelection` function to concisely turn a single `Field`
  into a `SelectionSet`. Thanks to [anagrius](https://github.com/anagrius)
  for the suggestion!

## [11.1.0] - 2018-03-21

### Added

- Add `mapError` and `ignoreParsedErrorData` functions to allow you to do more
  manipulation of `ParsedData` within Error data (fixes #52).

## [11.0.0] - 2018-03-21

### Changed

- Responses are errors if any data is present in `errors` field in response.
  The `data` field from the response is also included in `GraphqlError`s now so
  you can inspect the data upon failure. Here is a summary of how this will effect your code:
  - Before, `dillonkearns/elm-graphql` always treated responses where it could parse the response as success.
  - Now, it will treat responses where `errors` are present as an error regardless of whether it is able to parse the response `data`.
  - Users will need to add a type variable to their error type as errors may contain parsed data now (so `RemoteData (Graphql.Http.Error) Response` -> `RemoteData (Graphql.Http.Error Response) Response`)
  - For more context, here's the Github issue: https://github.com/dillonkearns/elm-graphql/issues/48#issuecomment-373175596
  - For an example, see https://github.com/dillonkearns/elm-graphql/blob/30be3570f52f5fd73055321e1a998c4082db32cf/examples/src/ErrorHandling.elm#L80-L107

## [10.2.0] - 2018-03-09

### Added

- Add `SelectionSet.succeed` to provide a hardcoded value as the result of a
  SelectionSet.

## [10.1.0] - 2018-02-25

### Changed

- Expose GraphQL response decoder publicly.

## [10.0.0] - 2018-02-07

### Changed

- Update model to allow more flexibility based on #32.

## [9.1.0] - 2018-02-06

### Added

- Add functions for transforming `Field`s using `Result`s. These functions are
  handy for converting values into types like `DateTime`s but can cause your
  entire response to error when decoding if any incorrect assumptions are made
  so they should be used with extreme care.

## [9.0.0] - 2018-01-28

### Changed

- Remove `AlwaysPost` since `Graphql.Http.queryRequest` now always uses POST.
  Added option to `GetWhenShortEnough`.

### Added

- Add `Graphql.OptionalArgument.fromMaybe`.
- Add `SelectionSet.map`.

## [8.0.1] - 2018-01-27

### Changed

- Always use POST when sending query requests since some APIs like Github don't
  support GET (see https://developer.github.com/v4/guides/forming-calls/#communicating-with-graphql).

## [8.0.0] - 2018-01-27

### Added

- Add `Graphql.Http.withQueryParams`.

### Changed

- Use GET requests by default when sending a query request, unless the resulting
  url would be over 2000 characters. `queryParamsForceMethod` allows you to specify a method when needed.
- Rename `Graphql.Http` functions from `buildMutationRequest` => `mutationRequest`
  and `buildQueryRequest` => `queryRequest` to sound more declarative and concise.
- Extract Subscription.Protocol module which encapsulates the details about
  low-level subscription communication for a given framework. The module includes
  an implementation for Rails and Absinthe/Rhoenix, or custom.

## [7.2.0] - 2018-01-20

### Added

- Add experimental subscriptions module and example.

## [7.1.0] - 2018-01-18

### Added

- Add `Graphql.Http.toTask`.
- Expose `Graphql.Http.withCredentials`.

## [7.0.0] - 2018-01-17

### Changed

- Rename `FieldDecoder` type and module to `Field` to match GraphQL domain language more closely.

## [6.1.0] - 2018-01-11

### Added

- Add `hardcoded` function to add arbitrary constants alongside `with` calls.

## [6.0.0] - 2018-01-10

### Added

- Expose Http.Error constructors.

## [5.0.1] - 2018-01-10

### Removed

- Remove unused elm package dependencies.

## [5.0.0] - 2018-01-10

### Fixed

- Add missing `Encode.float` function. Without this, APIs with float arguments
  would have compilation errors.

### Changed

- Modules that are used only by generated code are now under `Graphql.Internal`
  to make it more clear in the documentation.

## [4.1.0] - 2018-01-08

### Added

- Encode functions to support generated code for input objects.
  There is now no reason for users to consume the Encode module directly! It's
  all done under the hood by the generated code.

## [4.0.1] - 2018-01-07

### Fixed

- Fix bug that excluded arguments when serializing leaves in document.

```

```

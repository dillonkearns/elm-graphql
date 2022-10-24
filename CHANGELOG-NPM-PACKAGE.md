# Changelog [![npm](https://img.shields.io/npm/v/@dillonkearns/elm-graphql.svg)](https://npmjs.com/package/@dillonkearns/elm-graphql)

All notable changes to
[the `@dillonkearns/elm-graphql` npm package](https://www.npmjs.com/package/@dillonkearns/elm-graphql)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.3.1] - 2022-10-24

### Fixed

- Handle generating possible types to select in interfaces in some cases, see [#608](https://github.com/dillonkearns/elm-graphql/pull/608). Thank you [@th3coop](https://github.com/th3coop) for the fix!

## [4.3.0] - 2022-09-14

### Added

- Deprecated fields now include an `@deprecated` message within the doc comment for the generated function. See [#600](https://github.com/dillonkearns/elm-graphql/pull/600). Thank you [@gampleman](https://github.com/gampleman) for the PR!

## [4.2.4] - 2022-02-03

### Added

- New `--skip-validations` flag to avoid running `elm make` to give more precise validation errors for Scalar Codecs module if users want to avoid the extra execution time or the additional `elm make` step.

## [4.2.3] - 2021-12-19

### Fixed

- Improve validation error message for `--scalar-codecs` CLI option (see [#576](https://github.com/dillonkearns/elm-graphql/pull/576)). Thank you for the PR [@ZeldaIV](https://github.com/ZeldaIV)!

## [4.2.2] - 2021-07-28

### Fixed

- Use unqualified reference to `Basics.identity` to avoid naming conflicts in generated code. That means user-defined GraphQL fields
  can have the name `identity` without causing any Elm compiler errors now.

## [4.2.1] - 2021-03-15

### Fixed

- The input object loop detection had some false positives. This fix prevents using nested input object loop wrappers for some deeply nested input objects that are actually not circular. See [#475](https://github.com/dillonkearns/elm-graphql/pull/475/). Thank you [@mcasper](https://github.com/mcasper)!

## [4.2.0] - 2021-02-05

### Fixed

- Added long `_` suffix to generated parameter and let binding names to prevent any shadowing issues in generated code (see [#457](https://github.com/dillonkearns/elm-graphql/pull/457)).
- Don't require `npx` to run `elm-format`. Instead, `elm-graphql` will now look on the PATH to try to find `elm-format`, and give an error message if it is not found. See [#458](https://github.com/dillonkearns/elm-graphql/pull/458).

### Changed

- Node 10.12.0 is now the minimum supported Node version. `elm-graphql` now uses the `fs` package directly from Node instead of using `fs-extra`.
- Remove unused dependencies.
- Give Decoder errors instead of hanging on invalid types in some cases. Solves some of the cases. Others may be addressed in a future change by using more explicit and constrainted types. See [#379](https://github.com/dillonkearns/elm-graphql/issues/379).

## [4.1.4] - 2021-02-04

### Fixed

- Fixed a bug with the ordering of nullable list encoders for input objects (see [#456](https://github.com/dillonkearns/elm-graphql/pull/456)).

## [4.1.3] - 2021-02-04

### Fixed

- Fixed issue with running `elm-tooling install` as a `postinstall` script. This was supposed to run as part of the development tooling, not the published package. Fixed with [these instructions](https://elm-tooling.github.io/elm-tooling-cli/quirks/).

## [4.1.2] - 2021-02-04

### Fixed

- Fixed issue with `--header` options that had `:` within the values, see [#441](https://github.com/dillonkearns/elm-graphql/pull/441). Thank you [Jonas](https://github.com/klaftertief) for the fix!
- Updated NPM dependencies.

## [4.1.1] - 2021-02-04

### Fixed

- Update `graphql` npm package to add support for parsing GraphQL Description syntax in schema files. Fixes [#452](https://github.com/dillonkearns/elm-graphql/issues/452).

## [4.1.0] - 2021-02-02

### Added

- Add `--skip-elm-format` CLI option. See [#447](https://github.com/dillonkearns/elm-graphql/pull/447). Thank you [@lydell](https://github.com/lydell)!

## [4.0.5] - 2020-11-11

### Changed

- Updated to latest version of `graphql-request` NPM dependency, see https://github.com/dillonkearns/elm-graphql/pull/419. Thank you @Hermanverschooten!

## [4.0.4] - 2020-10-21

### Added

- Generate type annotation for `Api.Scalar.unwrapEncoder` function.

## [4.0.3] - 2020-05-31

### Changed

- Use vertical formatting for function type annotations. Thanks to @sporto for the PR! See [#351](https://github.com/dillonkearns/elm-graphql/pull/351).

## [4.0.2] - 2020-03-04

### Fixed

- Fixed CLI stalling when schema had field names with only `_`s (fixes [#285](https://github.com/dillonkearns/elm-graphql/issues/285)). The generated field names will be prefixed with `underscore` (see details in [#311](https://github.com/dillonkearns/elm-graphql/pull/311)).

## [4.0.1] - 2020-02-10

### Fixed

- Suppressed Elm's compiled in dev mode warning, see [#278](https://github.com/dillonkearns/elm-graphql/pull/278). Thank you [@jouderianjr](https://github.com/jouderianjr)!!!

## [4.0.0] - 2019-12-17

### Added

- `--schema-file <schema-file>` option for CLI (thank you [jouderianjr](https://github.com/jouderianjr)!).
  This allows you to directly point the CLI to a file with the GraphQL schema definition
  language (SDL) format, and it will generate code based on that schema. See [#247](https://github.com/dillonkearns/elm-graphql/pull/247).

### Changed

- Fix typo in internal function name (`exhuastiveFragmentSelection` -> `exhaustiveFragmentSelection`).

## [3.6.2] - 2019-05-29

### Changed

- Reduce NPM bundle size by removing `.npmignore` file and
  adding explicit `files` whitelist to `package.json`.

## [3.6.1] - 2019-05-24

### Fixed

- Fixed error when running CLI ([#150](https://github.com/dillonkearns/elm-graphql/issues/150))
  that was caused by an issue with the parcel build step. The Travis continuous integration build
  script is now running a more realistic check that will avoid issues like this slipping through into
  the published binaries in the future (NPM versions are only published after a green build). See
  [the issue](https://github.com/dillonkearns/elm-graphql/issues/150) for more details.

## [3.6.0] - 2019-05-17

### Fixed

- Fixed [#138](https://github.com/dillonkearns/elm-graphql/issues/138). Before this fix, an input object would incorrectly use a Custom Type wrapper instead of
  a plain record type alias to avoid circular dependencies in a case where there was no circular dependency.
  Thank you [@mattdb](https://github.com/mattdb) for reporting the issue, and providing a minimal
  failing test case! 🙏

## [3.5.0] - 2019-05-17

### Changed

Just some changes under the hood.

- Update to latest npm dependencies. Note that the latest elm npm package
  doesn't change the elm version, just the npm asset. It's still just elm 0.19.
- Use parcel for bundling, and minify the `elm-graphql` npm binary. The behavior
  should be exactly the same, and the extensive automated tests check out, plus
  my manual testing of the binary.

## [3.4.0] - 2019-04-17

### Changed

- Don't use field aliases for \_\_typename fields (see [PR #121](https://github.com/dillonkearns/elm-graphql/pull/121)).

## [3.3.0] - 2019-03-31

### Added

- Generate `fromString` for Enums. This function is the inverse of the Enum `toString` helper.
  So `NewHope |> Episode.toString |> Episode.fromString == Just NewHope`.

## [3.2.0] - 2019-01-25

### Fixed

- The code now for the scalar codecs file
  includes custom Encoders (not just Decoders). Before this, you would
  get an error if you tried to use custom decoders but your Custom Scalar
  was passed somewhere as an argument
  (see [#109](https://github.com/dillonkearns/elm-graphql/issues/109)).

### Changed

- Renamed `--scalar-decoders` flag to `--scalar-codecs`.

## [3.1.0] - 2019-01-07

### Added

- New `--scalar-decoders` flag allows you to define your scalar decoders
  in a custom module. See [pull request #101](https://github.com/dillonkearns/elm-graphql/pull/101).

## [3.0.1] - 2018-12-08

### Changed

- This change doesn't require
  any modifications to user code. Simply re-run the latest CLI and upgrade to the
  latest Elm package and you'll be good to go! See the 3.0.0 Elm package
  changelog for implementation details about this change.

## [3.0.0] - 2018-12-02

## Changed

- The code generate has changed to completely remove the `Field` module. See
  the [Elm package version 2.0.0 release notes](https://github.com/dillonkearns/elm-graphql/blob/master/CHANGELOG-ELM-PACKAGE.md#100---2018-12-02)
  for details and migration steps.

## [2.0.3] - 2018-11-29

### Changed

- Now using `--optimize` flag so there is no more warning printed from Elm when
  running the CLI.
- Now using https://github.com/dillonkearns/elm-cli-options-parser so you will
  get better feedback when you pass invalid arguments to the CLI.

## [2.0.2] - 2018-11-28

### Fixed

- Only run `elm-format` on the generated code directory, not the entire  
  `--output` directory. In the last release, it didn't take `--base` into account
  when running `elm-format`.

## [2.0.1] - 2018-11-27

### Changed

- Add newlines for readability in the generated code between fields in type
  alias definitions. See [#74](https://github.com/dillonkearns/elm-graphql/issues/74)
  for details.

## [2.0.0] - 2018-11-27

### Changed

- This introduces a backwards-incompatible change for any selections on Unions or Interfaces.
  The change allows you to do exhaustive type-specific fragments. Now, if you
  add a new type to a Union or Interface in your schema, the Elm compiler will
  tell you to check for that type if you're doing an exhaustive selection.
  See this diff to understand the changes and how to migrate to the new version:
  [e530d94](https://github.com/dillonkearns/elm-graphql/pull/85/commits/e530d94cded94f43135aa7e68233ab4f8b7e5912).
- With the new change, you can build exhaustive type-specific fragments that
  get rid of the Maybe (because the compiler knows you're handling all possibilities).

## [1.0.8] - 2018-11-27

### Fixed

- `elm-format` failed to run during the code generation in some configurations.
  The new solution uses [an NPM peer dependency](https://nodejs.org/en/blog/npm/peer-dependencies/)
  of `elm-format`. That means that it will make you install it if it's not already
  in your dependencies in your `package.json`. With that as a local dependency, we
  can safely call [`npx`](https://www.npmjs.com/package/npx) to run your local
  elm-format version. Note that this requires `npm >= 5.2.0`.
  See [#87](https://github.com/dillonkearns/elm-graphql/pull/87) and
  [#91](https://github.com/dillonkearns/elm-graphql/issues/91) for more details.
- The `elm-format` binary was previously run for each individual file asynchronously, which
  could cause performance issues in some environments. Now, `elm-format` is run
  as a single step on the entire generated directory after files are generated.
  This is more performant and more reliable.

## [1.0.7] - 2018-11-06

### Changed

- Add explicit `elm-version=0.19` argument when running `elm-format`
  in order to fix [#79](https://github.com/dillonkearns/elm-graphql/issues/79).

## [1.0.6] - 2018-10-31

### Added

- Generate a list of all possible enums for each enum module. Adds [#77](https://github.com/dillonkearns/elm-graphql/issues/77).

## [1.0.5] - 2018-10-31

### Fixed

- There was a missing import for schemas which referenced the root query/mutation/subscription
  objects. This came up with schemas generated by Graphile (though it may have effected
  other schemas as well). This resolves [#78](https://github.com/dillonkearns/elm-graphql/issues/78).

## [1.0.4] - 2018-08-28

Nothing to see here! Release 1.0.4 was just testing out a new Travis npm deploy script.

## [1.0.1] - 2018-08-28

### Changed

- Use extracted `scalarDecoder` constant from `dillonkearns/elm-graphql` package.
  This change allows us to remove all `Debug.toString` calls
  in generated code so that users can compile their code with the `--optimize` flag. This resolves
  [#68](https://github.com/dillonkearns/elm-graphql/issues/68).

## [1.0.0] - 2018-08-23

### Changed

- Generate code for `dillonkearns/elm-graphql`. This requires Elm version 0.19.
- If you are upgrading to Elm 0.19 follow [the `dillonkearns/elm-graphql` 0.19 upgrade guide](https://github.com/dillonkearns/elm-graphql/blob/master/docs/elm-19-upgrade.md).
  You can see more details of what's changed in [the Elm package changelog](https://github.com/dillonkearns/elm-graphql/blob/master/CHANGELOG-ELM-PACKAGE.md#100---2018-08-23).

## BELOW THIS IS FOR the npm `graphqelm` package (elm package`dillonkearns/graphqelm`). Read more about [the rename to `dillonkearns/elm-graphql`](https://github.com/dillonkearns/elm-graphql/issues/23).

## [3.1.12] - 2018-04-15

### Fixed

- Fix [#55](https://github.com/dillonkearns/elm-graphql/issues/55). Encoding was incorrect
  for Elm reserved words because it was incorrectly normalizing input object keys when
  it should have used the raw keys.

## [3.1.11] - 2018-03-21

### Fixed

- Fix code generation for constructors for circular input objects.
  Previously, `build<InputObject>` returned records without wrapping them in their type constructors
  when needed. This worked for plain type aliases but not for the types for
  self-referential input object types. The code generation is now correct for both of these types.

## [3.1.10] - 2018-03-13

### Added

- Generate `build<InputObject>` constructor functions (#49).

## [3.1.9] - 2018-03-08

### Fixed

- Fixed `RangeError: Maximum call stack size exceeded` that was coming from
  infinite recursion CLI bug, issue #47.

### Added

- Add `--introspection-file` CLI option to usage message.

## [3.1.8] - 2018-03-02

### Fixed

- Normalize all Elm reserved words by appending an `_` (previously only `type` was normalized). Resolves #40 (thanks for pull request #41 @madsflensted!).

## [3.1.7] - 2018-03-01

- Import all `Operation` values (it's rare but possible for schemas to refer to other operations) #45.

## [3.1.6] - 2018-03-01

- Add maybe encoder to pipeline for nullable scalar encoders. Fixes #44.

## [3.1.5] - 2018-02-24

### Fixed

- Fix infinite loop when checking for circular InputObject defs. This resolves issue #47 (the CLI was crashing for graph.cool endpoints).

## [3.1.4] - 2018-02-07

### Added

- Generate type alias for required args to make it easier to annotate
  consumer code. Fixes #31.

## [3.1.3] - 2018-02-07

### Fixed

- Add support for non-string scalars, fixes issue #37.

## [3.1.2] - 2018-02-06

### Changed

- Use `Decode.nullable` rather than `Decode.maybe` so that decode failures don't
  incorrectly get swallowed into a `Nothing` values but rather bubble up as
  `Err` `Results`.

### Added

- Generate type alias for optional args to make it easier to annotate consumer code.

## [3.1.1] - 2018-02-04

### Added

- Include type alias for records in the union type for Input Objects with loops.
  This allows for nicer annotations in consumer code.

## [3.1.0] - 2018-02-04

### Changed

- Generate wrapped record union type for Input Objects with loop (recursive or circular references),
  and plain type alias for Input Objects with no loop.

## [3.0.1] - 2018-02-01

### Fixed

- Fix issue with type generation for InputObject type aliases that contain a List type.

## [3.0.0] - 2018-02-01

### Fixed

- Generate InputObjects as types (not type aliases) inside a single file to allow for recursive or circular input types.

## [2.1.3] - 2018-01-28

### Added

- Add log statements to show progress while running CLI.

### Changed

- Include deprecated fields by default. Add `--excludeDeprecated` CLI flag in place
  of `--includeDeprecated`.

## [2.1.2] - 2018-01-20

### Changed

- Generate special module for Subscriptions.

## [2.1.1] - 2018-01-17

### Changed

- Renamed type variables from `selection` to `decodesTo` for clarity.
- Updated code generation to use type and module name `Field` rather than `FieldDecoder` for elm package version 7.0.0.

## [2.1.0] - 2018-01-13

### Fixed

- Single-letter names no longer cause exceptions (like `x` or `y`).

### Changed

- Update name normalization strategy to make only the minimal change to make a name valid
  (that is, put leading underscores at the tail, and make sure the first letter is the correct case).
  Unless it is ALL_UPPERCASE_UNDERSCORE_SEPARATED_NAME, then make it ClassCase.

## [2.0.3] - 2018-01-13

### Added

- Generate metadata json file with target elm package version and npm package version.

### Removed

- Remove npm version number and target elm package version number from comments
  on generated modules to reduce diff noise in future updates.

## [2.0.2] - 2018-01-11

### Fixed

- Fixed error on windows related to shelling out.

### Removed

- Stopped generating unnecessary InputObject type definitions file.

## [2.0.1] - 2018-01-10

### Added

- Add `--output` flag to command line to choose a directory
  other than `./src` for generated output
- Support intropsection json files with no top-level `data` json key.

## [2.0.0] - 2018-01-10

### Added

- Generate Scalars module with type definitions/constructors for each custom scalar.
- Experimental `--introspection-file` flag to allow users to pass in a file with
  the result of the introspection query. This may change in the future.

## [1.0.1] - 2018-01-08

### Added

- Generate InputObject modules for type-safe input objects.

# Changelog

All notable changes to
[the `@dillonkearns/elm-graphql` npm package](https://www.npmjs.com/package/@dillonkearns/elm-graphql)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

# Changelog

All notable changes to
[the `graphqelm` elm package](http://package.elm-lang.org/packages/dillonkearns/graphqelm/latest)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

* Rename `Graphqelm.Http` functions from `buildMutationRequest` => `mutationRequest`
  and `buildQueryRequest` => `queryRequest` to sound more declarative and concise.

## [7.2.0] - 2018-01-20

### Added

* Add experimental subscriptions module and example.

## [7.1.0] - 2018-01-18

### Added

* Add `Graphqelm.Http.toTask`.
* Expose `Graphqelm.Http.withCredentials`.

## [7.0.0] - 2018-01-17

### Changed

* Rename `FieldDecoder` type and module to `Field` to match GraphQL domain language more closely.

## [6.1.0] - 2018-01-11

### Added

* Add `hardcoded` function to add arbitrary constants alongside `with` calls.

## [6.0.0] - 2018-01-10

### Added

* Expose Http.Error constructors.

## [5.0.1] - 2018-01-10

### Removed

* Remove unused elm package dependencies.

## [5.0.0] - 2018-01-10

### Fixed

* Add missing `Encode.float` function. Without this, APIs with float arguments
  would have compilation errors.

### Changed

* Modules that are used only by generated code are now under `Graphqelm.Internal`
  to make it more clear in the documentation.

## [4.1.0] - 2018-01-08

### Added

* Encode functions to support generated code for input objects.
  There is now no reason for users to consume the Encode module directly! It's
  all done under the hood by the generated code.

## [4.0.1] - 2018-01-07

### Fixed

* Fix bug that excluded arguments when serializing leaves in document.

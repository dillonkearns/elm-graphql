# Changelog

All notable changes to
[the `graphqelm` elm package](http://package.elm-lang.org/packages/dillonkearns/graphqelm/latest)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

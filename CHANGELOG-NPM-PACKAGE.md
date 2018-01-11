# Changelog

All notable changes to
[the `graphqelm` npm package](https://www.npmjs.com/package/graphqelm)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

* Fixed error on windows related to shelling out.

### Removed

* Stopped generating unnecessary InputObject type definitions file.

## [2.0.1] - 2018-01-10

### Added

* Add `--output` flag to command line to choose a directory
  other than `./src` for generated output
* Support intropsection json files with no top-level `data` json key.

## [2.0.0] - 2018-01-10

### Added

* Generate Scalars module with type definitions/constructors for each custom scalar.
* Experimental `--introspection-file` flag to allow users to pass in a file with
  the result of the introspection query. This may change in the future.

## [1.0.1] - 2018-01-08

### Added

* Generate InputObject modules for type-safe input objects.

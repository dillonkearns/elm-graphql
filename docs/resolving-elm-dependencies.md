# Resolving Elm Dependencies

Users of `dillonkearns/elm-graphql` have been running into an issue with the `elm install`
tool recently. The `elm` CLI doesn't currently have a mechanism for automatically
resolving/updating dependencies. If you have `elm/http` < 2.0.0 as a dependency,
`elm install dillonkearns/elm-graphql` will not install the latest version of
`dillonkearns/elm-graphql`. The reason is because the latest version depends on the
newer `elm/http`, so you first need to update that dependency. Unfortunately,
resolving dependencies is a manual process at the moment.

Some other notes:

- There is a misleading message at the moment that states you shouldn't manually edit the `elm.json`.
  While this will be good advice once the automatic dependency resolution is implemented, that advice is inaccurate right now.
- `elm/core` is not up-to-date when you do an `elm init`. The latest version (as of this writing) is 1.0.2.
- One technique you can use is update to the latest version of a dependency is to remove it from `elm.json` and then do an `elm install` for it. For example, remove the line with `elm/core` version 1.0.0 from `elm.json` and then run `elm install elm/core`.
- Some packages rely on an older version of `elm/http`. You may need these to be updated before you can use the latest versions of libraries like `dillonkearns/elm-graphql` which have upgraded to the latest `elm/http`.

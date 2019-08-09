# Resolving Elm Dependencies

Users of `dillonkearns/elm-graphql` have been running into an issue with the `elm install`
tool recently. The `elm` CLI doesn't currently have a mechanism for automatically
resolving/updating dependencies. If you have `elm/http` < 2.0.0 as a dependency,
`elm install dillonkearns/elm-graphql` will not install the latest version of
`dillonkearns/elm-graphql`. The reason is because the latest version depends on the
newer `elm/http`, so you first need to update that dependency. 

Here's a semi-automatic aproach that you might take towards identifying the package that holds you back from updating `elm-graphql` to the latest version:

1. Globally install [`elm-json`](https://github.com/zwilias/elm-json) by running `npm i -g elm-json`
2. Create clean new `elm.json` file by running `elm-json new`
3. Install the latest `elm-graphql` by running `elm-json install dillonkearns/elm-graphql`
4. Attempt to install the rest of the packages in your project in one go by running `elm-json install author1/package1 author2/package2 author3/package3 ...`. It should look something like:
```
elm-json install NoRedInk/elm-json-decode-pipeline danyx23/elm-mimetype debois/elm-dom elm/browser elm/core elm/html elm/http elm/json elm/regex elm/svg elm/time elm/url elm-community/dict-extra elm-community/html-extra elm-community/json-extra elm-community/list-extra elm-community/maybe-extra elm-community/result-extra elm-community/string-extra justinmimbs/date justinmimbs/time-extra labzero/elm-google-geocoding myrho/elm-round simonh1000/elm-jwt thaterikperson/elm-strftime wernerdegroot/listzipper
```
5. Expect it to fail describing the package that conflicts with `elm-graphql` or one of it's dependencies

Some other notes:

- There is a misleading message at the moment that states you shouldn't manually edit the `elm.json`.
  While this will be good advice once the automatic dependency resolution is implemented, that advice is inaccurate right now.
- `elm/core` is not up-to-date when you do an `elm init`. The latest version (as of this writing) is 1.0.2.
- One technique you can use is update to the latest version of a dependency is to remove it from `elm.json` and then do an `elm install` for it. For example, remove the line with `elm/core` version 1.0.0 from `elm.json` and then run `elm install elm/core`.
- Some packages rely on an older version of `elm/http`. You may need these to be updated before you can use the latest versions of libraries like `dillonkearns/elm-graphql` which have upgraded to the latest `elm/http`.

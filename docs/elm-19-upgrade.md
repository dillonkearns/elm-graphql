# `dillonkearns/elm-graphql` (Formerly Graphqelm) 0.19 Upgrade Guide

How to upgrade from Elm 0.18 with `dillonkearns/graphqelm` to Elm 0.19 with
`dillonkearns/elm-graphql`

You can take a look at the [changelog entry](https://github.com/dillonkearns/elm-graphql/blob/master/CHANGELOG-ELM-PACKAGE.md#100---2018-08-23) for a full list of changes.

With the Elm 0.19 update, `dillonkearns/graphqelm` was moved to `dillonkearns/elm-graphql` to follow the elm literal naming convention (see
[issue #23](https://github.com/dillonkearns/elm-graphql/issues/23)). First you
can use the [`elm-upgrade`](https://github.com/avh4/elm-upgrade#elm-upgrade--)
tool to get your code ready for Elm 0.19. Running the latest version of `elm-upgrade` will
automatically rename the dependency in `elm.json` for you. Then simply do a find
and replace of `Graphqelm.` in your codebase with `Graphql.`.

If you were using the `Graphqelm.Subscription` module, please see the removed
section in the [changelog entry](https://github.com/dillonkearns/elm-graphql/blob/master/CHANGELOG-ELM-PACKAGE.md#100---2018-08-23) (while you can still
get decoders and subscription queries from `dillonkearns/elm-graphql` for your GraphQL Subscriptions, the low-level transport protocol for subscriptions will be handled by outside packages and code).

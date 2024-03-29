-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module GithubNoFormat.Object.TextMatch exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import GithubNoFormat.Object
import GithubNoFormat.Interface
import GithubNoFormat.Union
import GithubNoFormat.Scalar
import GithubNoFormat.InputObject
import GithubNoFormat.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)

{-| The specific text fragment within the property matched on.
-}
fragment : SelectionSet String GithubNoFormat.Object.TextMatch
fragment =
      Object.selectionForField "String" "fragment" [] (Decode.string)


{-| Highlights within the matched fragment.
-}
highlights : SelectionSet decodesTo GithubNoFormat.Object.TextMatchHighlight
 -> SelectionSet (List (Maybe decodesTo)) GithubNoFormat.Object.TextMatch
highlights object____ =
      Object.selectionForCompositeField "highlights" [] (object____) (Basics.identity >> Decode.nullable >> Decode.list)


{-| The property matched on.
-}
property : SelectionSet String GithubNoFormat.Object.TextMatch
property =
      Object.selectionForField "String" "property" [] (Decode.string)

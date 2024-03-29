-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Object.ReactingUserEdge exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.ScalarCodecs
import Github.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


cursor : SelectionSet String Github.Object.ReactingUserEdge
cursor =
    Object.selectionForField "String" "cursor" [] Decode.string


node :
    SelectionSet decodesTo Github.Object.User
    -> SelectionSet decodesTo Github.Object.ReactingUserEdge
node object____ =
    Object.selectionForCompositeField "node" [] object____ Basics.identity


{-| The moment when the user made the reaction.
-}
reactedAt : SelectionSet Github.ScalarCodecs.DateTime Github.Object.ReactingUserEdge
reactedAt =
    Object.selectionForField "ScalarCodecs.DateTime" "reactedAt" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)

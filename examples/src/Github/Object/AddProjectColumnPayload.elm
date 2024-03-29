-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Object.AddProjectColumnPayload exposing (..)

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


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : SelectionSet (Maybe String) Github.Object.AddProjectColumnPayload
clientMutationId =
    Object.selectionForField "(Maybe String)" "clientMutationId" [] (Decode.string |> Decode.nullable)


{-| The edge from the project's column connection.
-}
columnEdge :
    SelectionSet decodesTo Github.Object.ProjectColumnEdge
    -> SelectionSet decodesTo Github.Object.AddProjectColumnPayload
columnEdge object____ =
    Object.selectionForCompositeField "columnEdge" [] object____ Basics.identity


{-| The project
-}
project :
    SelectionSet decodesTo Github.Object.Project
    -> SelectionSet decodesTo Github.Object.AddProjectColumnPayload
project object____ =
    Object.selectionForCompositeField "project" [] object____ Basics.identity

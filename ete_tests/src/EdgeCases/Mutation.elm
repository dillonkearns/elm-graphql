-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module EdgeCases.Mutation exposing (..)

import EdgeCases.InputObject
import EdgeCases.Interface
import EdgeCases.Object
import EdgeCases.Scalar
import EdgeCases.ScalarCodecs
import EdgeCases.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


type alias CreatePunchListItemOptionalArguments =
    { shapes : OptionalArgument (List (Maybe EdgeCases.InputObject.ShapeInput)) }


createPunchListItem :
    (CreatePunchListItemOptionalArguments -> CreatePunchListItemOptionalArguments)
    -> SelectionSet String RootMutation
createPunchListItem fillInOptionals____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { shapes = Absent }

        optionalArgs____ =
            [ Argument.optional "shapes" filledInOptionals____.shapes (EdgeCases.InputObject.encodeShapeInput |> Encode.maybe |> Encode.list) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForField "String" "createPunchListItem" optionalArgs____ Decode.string

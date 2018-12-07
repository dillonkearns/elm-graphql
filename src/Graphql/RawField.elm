module Graphql.RawField exposing (RawField(..), name, typename)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)


type RawField
    = Composite String (List Argument) (List RawField)
    | Leaf { typeString : String, fieldName : String } (List Argument)


name : RawField -> String
name field =
    case field of
        Composite fieldName argumentList fieldList ->
            fieldName

        Leaf { typeString, fieldName } argumentList ->
            fieldName


typename : RawField
typename =
    Leaf { typeString = "", fieldName = "__typename" } []

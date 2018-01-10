module Graphqelm.Field exposing (Field(Composite, Leaf), name)

import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


name : Field -> String
name field =
    case field of
        Composite fieldName argumentList fieldList ->
            fieldName

        Leaf fieldName argumentList ->
            fieldName

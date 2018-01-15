module Graphqelm.RawField exposing (RawField(Composite, Leaf), name)

import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)


type RawField
    = Composite String (List Argument) (List RawField)
    | Leaf String (List Argument)


name : RawField -> String
name field =
    case field of
        Composite fieldName argumentList fieldList ->
            fieldName

        Leaf fieldName argumentList ->
            fieldName

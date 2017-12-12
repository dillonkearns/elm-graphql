module Graphqelm.DocumentSerializer.Argument exposing (serialize)

import Graphqelm.Builder.Argument as Argument exposing (Argument(Argument))
import Graphqelm.Value as Value


serialize : List Argument -> String
serialize args =
    case args of
        [] ->
            ""

        nonemptyArgs ->
            "("
                ++ (nonemptyArgs
                        |> List.map argToString
                        |> String.join ", "
                   )
                ++ ")"


argToString : Argument -> String
argToString (Argument name value) =
    name ++ ": " ++ Value.serialize value

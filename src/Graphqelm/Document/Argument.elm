module Graphqelm.Document.Argument exposing (serialize)

import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument(Argument))
import Graphqelm.Internal.Encode as Encode


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
    name ++ ": " ++ Encode.serialize value

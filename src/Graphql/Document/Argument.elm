module Graphql.Document.Argument exposing (serialize)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument(..))
import Graphql.Internal.Encode as Encode


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

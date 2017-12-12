module Graphqelm.QuerySerializer.Field exposing (serialize)

import Graphqelm.Field exposing (Field(Composite, Leaf, QueryField))
import Graphqelm.QuerySerializer.Argument as Argument
import Graphqelm.QuerySerializer.Indent as Indent


serialize : Bool -> Int -> Field -> String
serialize skipIndentationLevel indentationLevel field =
    case field of
        Composite fieldName args children ->
            (Indent.generate skipIndentationLevel indentationLevel
                ++ fieldName
                ++ Argument.serialize args
                ++ " {\n"
                ++ (children
                        |> List.map (serialize False (indentationLevel + 1))
                        |> String.join "\n"
                   )
            )
                ++ "\n"
                ++ Indent.generate False indentationLevel
                ++ "}"

        Leaf fieldName args ->
            Indent.generate skipIndentationLevel indentationLevel ++ fieldName

        QueryField nestedField ->
            serialize False indentationLevel nestedField

module Graphqelm.Document.Field exposing (serialize)

import Graphqelm.Document.Argument as Argument
import Graphqelm.Document.Indent as Indent
import Graphqelm.Field exposing (Field(Composite, Leaf, QueryField))


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

module Graphqelm.Document.Field exposing (serialize)

import Graphqelm.Document.Argument as Argument
import Graphqelm.Document.Indent as Indent
import Graphqelm.Field exposing (Field(Composite, Leaf, QueryField))
import Interpolate exposing (interpolate)


serialize : Bool -> Int -> Field -> String
serialize skipIndentationLevel indentationLevel field =
    case field of
        Composite fieldName args children ->
            (Indent.generate skipIndentationLevel indentationLevel
                ++ fieldName
                ++ Argument.serialize args
                ++ " {\n"
                ++ (children
                        |> List.indexedMap
                            (\index selection ->
                                interpolate "  {0}: {1}"
                                    [ "result" ++ toString (index + 1)
                                    , serialize False
                                        (indentationLevel + 1)
                                        selection
                                    ]
                            )
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

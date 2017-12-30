module Graphqelm.Document.Field exposing (serialize, serializeChildren)

import Graphqelm.Document.Argument as Argument
import Graphqelm.Document.Indent as Indent
import Graphqelm.Field exposing (Field(Composite, Leaf))
import List.Extra


alias : Int -> List Field -> Field -> Maybe String
alias fieldIndex fields field =
    let
        fieldName =
            Graphqelm.Field.name field

        indices =
            fields
                |> List.Extra.findIndices
                    (\currentField ->
                        Graphqelm.Field.name currentField
                            == fieldName
                    )
                |> List.filter (\index -> index < fieldIndex)
    in
    if indices == [] then
        Nothing
    else
        Just (fieldName ++ toString (List.length indices + 1))


serialize : Maybe String -> Int -> Field -> String
serialize alias indentationLevel field =
    let
        prefix =
            case alias of
                Just aliasName ->
                    aliasName ++ ": "

                Nothing ->
                    ""
    in
    Indent.generate indentationLevel
        ++ prefix
        ++ (case field of
                Composite fieldName args children ->
                    if children == [] then
                        ""
                        -- TODO don't include prefix when empty
                    else
                        (fieldName
                            ++ Argument.serialize args
                            ++ " {\n"
                            ++ serializeChildren indentationLevel children
                        )
                            ++ "\n"
                            ++ Indent.generate indentationLevel
                            ++ "}"

                Leaf fieldName args ->
                    fieldName
           )


serializeChildren : Int -> List Field -> String
serializeChildren indentationLevel children =
    children
        |> List.indexedMap
            (\index selection ->
                serialize (alias index children selection) (indentationLevel + 1) selection
            )
        |> String.join "\n"

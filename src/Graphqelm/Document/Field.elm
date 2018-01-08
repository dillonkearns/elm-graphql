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


serialize : Maybe String -> Int -> Field -> Maybe String
serialize alias indentationLevel field =
    let
        prefix =
            case alias of
                Just aliasName ->
                    aliasName ++ ": "

                Nothing ->
                    ""
    in
    (case field of
        Composite fieldName args children ->
            if children == [] then
                Nothing
            else
                (fieldName
                    ++ Argument.serialize args
                    ++ " {\n"
                    ++ serializeChildren indentationLevel children
                )
                    ++ "\n"
                    ++ Indent.generate indentationLevel
                    ++ "}"
                    |> Just

        Leaf fieldName args ->
            Just (fieldName ++ Argument.serialize args)
    )
        |> Maybe.map
            (\string ->
                Indent.generate indentationLevel
                    ++ prefix
                    ++ string
            )


serializeChildren : Int -> List Field -> String
serializeChildren indentationLevel children =
    children
        |> List.indexedMap
            (\index selection ->
                serialize (alias index children selection) (indentationLevel + 1) selection
            )
        |> List.filterMap identity
        |> String.join "\n"

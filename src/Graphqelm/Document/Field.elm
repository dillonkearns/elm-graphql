module Graphqelm.Document.Field exposing (serialize)

import Graphqelm.Document.Argument as Argument
import Graphqelm.Document.Indent as Indent
import Graphqelm.Field exposing (Field(Composite, Leaf))
import Interpolate exposing (interpolate)
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


serialize : Bool -> Int -> Field -> String
serialize skipIndentationLevel indentationLevel field =
    case field of
        Composite fieldName args children ->
            (Indent.generate skipIndentationLevel indentationLevel
                ++ fieldName
                ++ Argument.serialize args
                ++ " {\n"
                ++ serializeChildren indentationLevel children
            )
                ++ "\n"
                ++ Indent.generate False indentationLevel
                ++ "}"

        Leaf fieldName args ->
            Indent.generate skipIndentationLevel indentationLevel ++ fieldName


serializeChildren : Int -> List Field -> String
serializeChildren indentationLevel children =
    children
        |> List.indexedMap
            (\index selection ->
                case alias index children selection of
                    Just aliasName ->
                        interpolate "  {0}: {1}"
                            [ aliasName, serialize False (indentationLevel + 1) selection ]

                    Nothing ->
                        "  " ++ serialize False (indentationLevel + 1) selection
            )
        |> String.join "\n"

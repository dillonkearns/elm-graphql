module Graphqelm.Document.Field exposing (serializeChildren)

import Graphqelm.Document.Argument as Argument
import Graphqelm.Document.Indent as Indent
import Graphqelm.RawField exposing (RawField(..))
import List.Extra


alias : Int -> List RawField -> RawField -> Maybe String
alias fieldIndex fields field =
    let
        fieldName =
            Graphqelm.RawField.name field

        indices =
            fields
                |> List.Extra.findIndices
                    (\currentField ->
                        Graphqelm.RawField.name currentField
                            == fieldName
                    )
                |> List.filter (\index -> index < fieldIndex)
    in
    if indices == [] then
        Nothing

    else
        Just (fieldName ++ toString (List.length indices + 1))


serialize : Maybe String -> Maybe Int -> RawField -> Maybe String
serialize aliasName mIndentationLevel field =
    let
        prefix =
            case aliasName of
                Just aliasName_ ->
                    aliasName_
                        ++ (case mIndentationLevel of
                                Just _ ->
                                    ": "

                                Nothing ->
                                    ":"
                           )

                Nothing ->
                    ""
    in
    (case field of
        Composite fieldName args children ->
            if children == [] then
                Nothing

            else
                case mIndentationLevel of
                    Nothing ->
                        (fieldName
                            ++ Argument.serialize args
                            ++ "{"
                            ++ serializeChildren Nothing children
                        )
                            ++ "}"
                            |> Just

                    Just indentationLevel ->
                        (fieldName
                            ++ Argument.serialize args
                            ++ " {\n"
                            ++ serializeChildren (Just indentationLevel) children
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
                Indent.generate (mIndentationLevel |> Maybe.withDefault 0)
                    ++ prefix
                    ++ string
            )


serializeChildren : Maybe Int -> List RawField -> String
serializeChildren indentationLevel children =
    children
        |> List.indexedMap
            (\index selection ->
                serialize (alias index children selection) (indentationLevel |> Maybe.map ((+) 1)) selection
            )
        |> List.filterMap identity
        |> String.join
            (case indentationLevel of
                Just _ ->
                    "\n"

                Nothing ->
                    " "
            )

module Graphql.Document.Field exposing (hashedAliasName, serializeChildren)

import Graphql.Document.Argument as Argument
import Graphql.Document.Indent as Indent
import Graphql.RawField exposing (RawField(..))
import List.Extra
import Murmur3


hashedAliasName : RawField -> String
hashedAliasName rawField =
    Graphql.RawField.name rawField
        ++ (unaliasedSerializeChildren Nothing rawField
                |> Murmur3.hashString 0
                |> String.fromInt
           )


alias : Int -> List RawField -> RawField -> Maybe String
alias fieldIndex fields field =
    if
        (field |> Graphql.RawField.name |> String.startsWith "...")
            || (field |> Graphql.RawField.name |> String.startsWith "__")
    then
        Nothing

    else
        hashedAliasName field
            |> Just


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


unaliasedSerializeChildren : Maybe Int -> RawField -> String
unaliasedSerializeChildren indentationLevel field =
    [ field ]
        |> List.indexedMap
            (\index selection ->
                serialize Nothing (indentationLevel |> Maybe.map ((+) 1)) selection
            )
        |> List.filterMap identity
        |> String.join
            (case indentationLevel of
                Just _ ->
                    "\n"

                Nothing ->
                    " "
            )

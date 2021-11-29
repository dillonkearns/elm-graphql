module Graphql.Document.Field exposing (hashedAliasName, serializeChildren)

import OrderedDict as Dict
import Graphql.Document.Argument as Argument
import Graphql.Document.Hash exposing (hashString)
import Graphql.Document.Indent as Indent
import Graphql.Internal.Builder.Argument exposing (Argument)
import Graphql.RawField exposing (RawField(..))

type alias Dict comparable v  = Dict.OrderedDict comparable v

hashedAliasName : RawField -> String
hashedAliasName field =
    field
        |> alias
        |> Maybe.withDefault (Graphql.RawField.name field)


maybeAliasHash : RawField -> Maybe Int
maybeAliasHash field =
    (case field of
        Composite name arguments children ->
            if List.isEmpty arguments then
                Nothing

            else
                arguments
                    |> Argument.serialize
                    |> Just

        Leaf { typeString, fieldName } arguments ->
            -- __typename fields never takes arguments or has a different type,
            -- so they don't need to be aliased
            -- see https://github.com/dillonkearns/elm-graphql/issues/120
            if fieldName == "__typename" then
                Nothing

            else
                arguments
                    |> Argument.serialize
                    |> List.singleton
                    |> List.append [ typeString ]
                    |> String.concat
                    |> Just
    )
        |> Maybe.map (hashString 0)


alias : RawField -> Maybe String
alias field =
    field
        |> maybeAliasHash
        |> Maybe.map (\aliasHash -> Graphql.RawField.name field ++ String.fromInt aliasHash)


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

        Leaf { fieldName } args ->
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
        |> mergedFields
        |> nonemptyChildren
        |> List.map
            (\field ->
                serialize (alias field) (indentationLevel |> Maybe.map ((+) 1)) field
            )
        |> List.filterMap identity
        |> String.join
            (case indentationLevel of
                Just _ ->
                    "\n"

                Nothing ->
                    " "
            )


mergedFields : List RawField -> List RawField
mergedFields children =
    let
        mergeThing : MergedFields
        mergeThing =
            mergeFields children
    in
    (mergeThing.leaves |> Dict.values |> List.map leafToField)
        ++ (mergeThing.composites |> Dict.values |> List.map compositeToField)


type alias MergedFields =
    { leaves : Dict String ( { typeString : String, fieldName : String }, List Argument )
    , composites : Dict String ( { name : String, args : List Argument }, List RawField )
    }


leafToField : ( { typeString : String, fieldName : String }, List Argument ) -> RawField
leafToField ( record, arguments ) =
    Leaf record arguments


compositeToField : ( { name : String, args : List Argument }, List RawField ) -> RawField
compositeToField ( record, children ) =
    Composite record.name record.args children


{-| Fields will have collisions if there is more than one with the same field name or field alias.

This ensures that composite fields with the same field name or field alias are merged into one composite.

-}
mergeFields : List RawField -> MergedFields
mergeFields rawFields =
    rawFields
        |> List.foldl
            (\field { leaves, composites } ->
                case field of
                    Composite fieldName args children ->
                        { leaves = leaves
                        , composites =
                            composites
                                |> Dict.update (hashedAliasName field)
                                    (\maybeChildrenSoFar ->
                                        maybeChildrenSoFar
                                            |> Maybe.withDefault ( { name = fieldName, args = args }, [] )
                                            |> Tuple.mapSecond ((++) children)
                                            |> Just
                                    )
                        }

                    Leaf info args ->
                        { leaves =
                            leaves
                                |> Dict.update (hashedAliasName field)
                                    (\maybeChildrenSoFar ->
                                        maybeChildrenSoFar
                                            |> Maybe.withDefault ( info, args )
                                            |> Just
                                    )
                        , composites = composites
                        }
            )
            { leaves = Dict.empty
            , composites = Dict.empty
            }


nonemptyChildren : List RawField -> List RawField
nonemptyChildren children =
    if List.isEmpty children then
        Graphql.RawField.typename :: children

    else
        children

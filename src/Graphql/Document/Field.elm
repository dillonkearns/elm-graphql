module Graphql.Document.Field exposing (hashedAliasName, serializeChildren)

import Dict as UnorderedDict
import Graphql.Document.Argument as Argument
import Graphql.Document.Hash exposing (hashString)
import Graphql.Document.Indent as Indent
import Graphql.RawField exposing (RawField(..), name)
import OrderedDict as Dict
import Set exposing (Set)


type alias Dict comparable v =
    Dict.OrderedDict comparable v


hashedAliasName : RawField -> String
hashedAliasName field =
    field
        |> alias
        |> Maybe.withDefault (name field)


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
        |> Maybe.map (\aliasHash -> name field ++ String.fromInt aliasHash)


serialize : Set String -> Maybe String -> Maybe Int -> RawField -> Maybe String
serialize forceHashing aliasName mIndentationLevel field =
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
                        ++ serializeChildrenHelp forceHashing Nothing children
                    )
                        ++ "}"
                        |> Just

                Just indentationLevel ->
                    (fieldName
                        ++ Argument.serialize args
                        ++ " {\n"
                        ++ serializeChildrenHelp forceHashing (Just indentationLevel) children
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
    serializeChildrenHelp Set.empty indentationLevel children


serializeChildrenHelp : Set String -> Maybe Int -> List RawField -> String
serializeChildrenHelp forceHashing indentationLevel children =
    children
        |> mergedFields
        |> nonemptyChildren
        |> canAllowHashing forceHashing
        |> List.map
            (\( field, maybeAlias, conflictingTypeFields ) ->
                serialize conflictingTypeFields maybeAlias (indentationLevel |> Maybe.map ((+) 1)) field
            )
        |> List.filterMap identity
        |> String.join
            (case indentationLevel of
                Just _ ->
                    "\n"

                Nothing ->
                    " "
            )


canAllowHashing : Set String -> List RawField -> List ( RawField, Maybe String, Set String )
canAllowHashing forceHashing rawFields =
    let
        conflictingTypeFields : Set String
        conflictingTypeFields =
            findConflictingTypeFields rawFields

        fieldCounts : Dict.OrderedDict String Int
        fieldCounts =
            rawFields
                |> List.map name
                |> List.foldl
                    (\fld acc ->
                        acc
                            |> Dict.update fld
                                (\val ->
                                    Just
                                        (case val of
                                            Nothing ->
                                                0

                                            Just count ->
                                                count + 1
                                        )
                                )
                    )
                    Dict.empty
    in
    rawFields
        |> List.map
            (\field ->
                ( field
                , if forceHashing |> Set.member (name field) then
                    alias field

                  else if (fieldCounts |> Dict.get (name field) |> Maybe.withDefault 0) == 0 then
                    Nothing

                  else
                    alias field
                , conflictingTypeFields
                )
            )


findConflictingTypeFields : List RawField -> Set String
findConflictingTypeFields rawFields =
    let
        compositeCount : Int
        compositeCount =
            rawFields
                |> List.filterMap
                    (\field ->
                        case field of
                            Composite _ _ _ ->
                                Just ()

                            Leaf _ _ ->
                                Nothing
                    )
                |> List.length
    in
    if compositeCount <= 1 then
        -- if there are no siblings then there are no type conflicts
        Set.empty

    else
        let
            levelBelowNodes : List RawField
            levelBelowNodes =
                rawFields
                    |> List.concatMap
                        (\field ->
                            case field of
                                Leaf _ _ ->
                                    []

                                Composite _ _ children ->
                                    children
                        )

            fieldTypes : UnorderedDict.Dict String (Set String)
            fieldTypes =
                levelBelowNodes
                    |> List.filterMap
                        (\field ->
                            case field of
                                Leaf { typeString } _ ->
                                    Just
                                        ( name field
                                        , typeString
                                        )

                                Composite _ _ _ ->
                                    Nothing
                        )
                    |> List.foldl
                        (\( fieldName, fieldType ) acc ->
                            acc
                                |> UnorderedDict.update fieldName
                                    (\maybeFieldTypes ->
                                        case maybeFieldTypes of
                                            Nothing ->
                                                Just (Set.singleton fieldType)

                                            Just fieldTypes_ ->
                                                fieldTypes_
                                                    |> Set.insert fieldType
                                                    |> Just
                                    )
                        )
                        UnorderedDict.empty
        in
        fieldTypes
            |> UnorderedDict.filter
                (\fieldType fields ->
                    fields
                        |> Set.size
                        |> (\size -> size > 1)
                )
            |> UnorderedDict.keys
            |> Set.fromList


mergedFields : List RawField -> List RawField
mergedFields children =
    Dict.values (mergeFields children)


type alias MergedFields =
    Dict String RawField


{-| Fields will have collisions if there is more than one with the same field name or field alias.

This ensures that composite fields with the same field name or field alias are merged into one composite.

-}
mergeFields : List RawField -> MergedFields
mergeFields rawFields =
    rawFields
        |> List.foldl
            (\field mergedSoFar ->
                case field of
                    Composite _ _ newChildren ->
                        mergedSoFar
                            |> Dict.update (hashedAliasName field)
                                (\maybeChildrenSoFar ->
                                    case maybeChildrenSoFar of
                                        Nothing ->
                                            Just field

                                        Just (Composite existingFieldName existingArgs existingChildren) ->
                                            Composite existingFieldName existingArgs (existingChildren ++ newChildren) |> Just

                                        _ ->
                                            Just field
                                )

                    Leaf _ _ ->
                        mergedSoFar
                            |> Dict.update (hashedAliasName field)
                                (\maybeChildrenSoFar ->
                                    maybeChildrenSoFar
                                        |> Maybe.withDefault field
                                        |> Just
                                )
            )
            Dict.empty


nonemptyChildren : List RawField -> List RawField
nonemptyChildren children =
    if List.isEmpty children then
        Graphql.RawField.typename :: children

    else
        children

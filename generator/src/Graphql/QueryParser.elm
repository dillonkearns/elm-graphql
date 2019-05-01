module Graphql.QueryParser exposing (..)

import Parser
    exposing
        ( (|.)
        , (|=)
        , Parser
        , Step
        , Trailing
        , float
        , loop
        , map
        , oneOf
        , spaces
        , succeed
        , symbol
        )
import Set

import Debug
import Dict
import Graphql.Parser.Type exposing (..)
import  Graphql.Parser.ClassCaseName as ClassCaseName
import  Graphql.Parser.CamelCaseName as CamelCaseName
---
import Graphql.Generator.Group exposing (IntrospectionData)


-- Name :: /[_A-Za-z][_0-9A-Za-z]*/


type alias Name =
    String


type OperationDefintion
    = SelectionSet SelectionSet
    | Operation OperationRecord


type alias OperationRecord =
    { type_ : OperationType
    , name : Maybe Name

    -- , variableDefinitions : List VariableDefinition TBD
    -- , directives: List Directive TBD
    , selectionSet : SelectionSet
    }


type OperationType
    = Query
    | Mutation
    | Subscription



-- VariableDefinition : Variable : Type DefaultValue? Directives[Const]?


type alias VariableDefinition =
    { variable : Name
    , type_ : Type

    -- , defaultValue: Maybe DefaultValue TBD
    -- , directives: List Directive TBD
    }


type Type
    = NamedType NamedType
    | ListType ListType
    | NonNullType NonNullType


type NamedType
    = Name


type alias ListType =
    List Type


type NonNullType
    = NonNullNamedType NamedType
    | NonNullListType ListType


type alias SelectionSet =
    List Selection


type Selection
    = Field FieldType



-- | FragmentSpread FragmentSpreadType TBD
-- | InlineFragment InlineFragmentType TBD


type alias FieldType =
    { alias : Maybe Name
    , name : Name

    -- , arguments: List Argument TBD
    -- , directives: List Directive TBD
    , selectionSet : Maybe SelectionSet
    }

parse query =
    Parser.run parser query

parser : Parser OperationDefintion
parser =
    oneOf
        [ Parser.map Operation operation
        , Parser.map SelectionSet selectionSet
        ]


operation : Parser OperationRecord
operation =
    Parser.succeed OperationRecord
        |. spaces
        |= operationType
        |. spaces
        |= alias
        |. spaces
        |= selectionSet
        |. spaces


operationType : Parser OperationType
operationType =
    oneOf
        [ map (always Query) (symbol "query")
        , map (always Mutation) (symbol "mutation")
        , map (always Subscription) (symbol "subscription")
        ]


name : Parser Name
name =
    Parser.variable
        { start = Char.isAlpha
        , inner = \c -> Char.isAlphaNum c || c == '_'
        , reserved = Set.fromList [ "query", "mutation", "subscription" ]
        }



-- selectionSet : Parser SelectionSet
-- selectionSet =
--   Parser.sequence
--     { start = "{"
--     , separator = "\n"
--     , end = "}"
--     , spaces = spaces
--     , item = field
--     , trailing = Parser.Optional
--     }


field : Parser Selection
field =
    Parser.succeed FieldType
        |= succeed Nothing --alias TBD
        |= name
        |= oneOf
            [ Parser.backtrackable (Parser.map Just selectionSet)
            , succeed Nothing
            ]
        |> Parser.map Field


alias : Parser (Maybe Name)
alias =
    oneOf
        [ Parser.map Just name
        , succeed Nothing
        ]



-- selectionSet : Parser SelectionSet


selectionSet : Parser (List Selection)
selectionSet =
  succeed identity
    |. spaces
    |. symbol "{"
    |. spaces
    |= loop [] fieldsHelper
    |. spaces
    |. symbol "}"
    |. spaces


fieldsHelper : List Selection -> Parser (Step (List Selection) (List Selection))
fieldsHelper revStmts =
    oneOf
        [ succeed (\stmt -> Parser.Loop (stmt :: revStmts))
            |. spaces
            |= field
            |. spaces
        , succeed ()
            |> map (\_ -> Parser.Done (List.reverse revStmts))
        ]

------ this will all get moved out
--utility from Result extra
combine = List.foldr (Result.map2 (::)) (Ok [])
--
transform : String -> IntrospectionData -> Result String String
transform query introspectionData =
    let
        -- _ = Debug.log "introspectionData" introspectionData

 
        nameToTypeDef =
            introspectionData.typeDefinitions
                |> List.map (\((TypeDefinition className _ _) as typeDef) -> 
                    (ClassCaseName.raw className, typeDef)
                )
                |> Dict.fromList


        findTypeDef rootName =
            Dict.get rootName nameToTypeDef

        selectionToString : TypeDefinition -> Selection -> Result String String
        selectionToString ((TypeDefinition classCaseName definableType _) as parentTypeDef) (Field fieldType) =
            let
                maybeFieldTypeDef = 
                    case definableType of
                        ObjectType fields ->
                            fields
                                |> List.map (\field_ -> (CamelCaseName.raw field_.name, field_))
                                |> Dict.fromList
                                |> Dict.get fieldType.name
                        _ ->
                            Nothing
            in
            case maybeFieldTypeDef of
                Nothing -> Err ("Can't resolve " ++ fieldType.name)
                Just fieldTypeDef ->
                    let
                        camelCaseName = CamelCaseName.raw fieldTypeDef.name
                    in
                    case fieldType.selectionSet of
                        Nothing -> --scalar
                            Ok camelCaseName
                        Just selectionSet_ ->
                            let
                                typeName =
                                    case fieldTypeDef.typeRef of 
                                        TypeReference (ObjectRef str) _ -> str
                                        _ -> "foo"

                                maybeSubFieldTypeDef = findTypeDef typeName
                            in
                            case maybeSubFieldTypeDef of
                                Nothing -> Err ("Can't resolve " ++ (CamelCaseName.raw fieldTypeDef.name) ++ " : " ++ typeName)
                                Just ((TypeDefinition classCaseName_ definableType_ _) as subFieldTypeDef) ->
                                    let
                                        class = ClassCaseName.raw classCaseName_
                                    in
                                    selectionSet_
                                        |> List.map (selectionToString subFieldTypeDef
                                            >> Result.map (\str -> "|> with " ++ camelCaseName ++ "." ++ str)
                                        )
                                        |> combine
                                        |> Result.map (String.join "\n")
                                        |> Result.andThen (\childStr ->
                                            Ok("SelectionSet.succeed "++ class ++"\n"
                                            ++ childStr
                                            ++ "\n)")
                                        )
                
        opDefToString : OperationDefintion -> Result String String
        opDefToString opDef =
            case opDef of 
                Operation operationRecord ->
                    let
                        maybeFieldName = 
                            case operationRecord.type_ of
                                Query -> 
                                    Just introspectionData.queryObjectName
                                Mutation ->
                                    introspectionData.mutationObjectName
                                Subscription ->
                                    introspectionData.subscriptionObjectName

                        maybeTypeDef = 
                           maybeFieldName
                                |> Maybe.andThen findTypeDef
                    in
                    case maybeTypeDef of
                        Just ((TypeDefinition classCaseName definableType _) as typeDef) ->
                            let
                                 class = ClassCaseName.raw classCaseName
                            in
                            operationRecord.selectionSet
                                |> List.map (\((Field fieldType) as selection) -> selectionToString typeDef selection
                                    |> Result.map (\str -> "|> with " ++ class ++ "." ++ fieldType.name ++ "(" ++ str ++ ")")
                                )
                                |> combine
                                |> Result.map (String.join "\n")
                                |> Result.andThen (\childStr ->
                                    Ok("SelectionSet.succeed PageData\n"
                                    ++ childStr)
                                )
                        Nothing -> 
                            Err ("Can't find " ++ (maybeFieldName |> Maybe.withDefault "unknown type"))

                _ -> Err "Unsupported root level structure"
    in
    parse query
        |> Result.mapError (always "Parser Error")
        |> Result.andThen opDefToString
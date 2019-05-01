module Graphql.QueryParser exposing (FieldType, ListType, Name, NamedType(..), NonNullType(..), OperationDefintion(..), OperationRecord, OperationType(..), Selection(..), SelectionSet, Type(..), VariableDefinition, alias, combine, field, fieldsHelper, name, operation, operationType, parse, parser, selectionSet, transform)

---

import Debug
import Dict exposing (Dict)
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder as Decoder
import Graphql.Generator.Group exposing (IntrospectionData)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type exposing (..)
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
import Set exposing (Set)



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


field : Parser Selection
field =
    Parser.succeed FieldType
        |= succeed Nothing
        --alias TBD
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


combine =
    List.foldr (Result.map2 (::)) (Ok [])



--


type alias RecordContext =
    Dict String (List { fieldName : String, fieldType : String })


transform : IntrospectionData -> Context -> String -> Result String String
transform introspectionData context query =
    let
        moduleName typeDef =
            ModuleName.generate context typeDef

        nameToTypeDef =
            introspectionData.typeDefinitions
                |> List.map
                    (\((TypeDefinition className _ _) as typeDef) ->
                        ( ClassCaseName.raw className, typeDef )
                    )
                |> Dict.fromList

        findTypeDef rootName =
            Dict.get rootName nameToTypeDef

        selectionSetToString : TypeDefinition -> RecordContext -> SelectionSet -> Result String { imports : Set String, body : String, correspondElmType : { fieldName : String, fieldType : String }, recordContext : RecordContext }
        selectionSetToString ((TypeDefinition classCaseName definableType _) as typeDef) recordContext selectionSet_ =
            let
                targetRecordName =
                    ClassCaseName.raw classCaseName ++ "Record"

                modulePath =
                    moduleName typeDef
                        |> String.join "."
            in
            selectionSet_
                |> List.map
                    (\((Field fieldType) as selection) ->
                        let
                            maybeFieldTypeRef =
                                case definableType of
                                    ObjectType fields ->
                                        fields
                                            |> List.map (\field_ -> ( CamelCaseName.raw field_.name, field_ ))
                                            |> Dict.fromList
                                            |> Dict.get fieldType.name
                                            |> Maybe.map .typeRef

                                    _ ->
                                        Nothing
                        in
                        case maybeFieldTypeRef of
                            Nothing ->
                                Err ("No such type for field: " ++ fieldType.name)

                            Just fieldTypeRef ->
                                case fieldType.selectionSet of
                                    Nothing ->
                                        --scalar case
                                        Ok
                                            { imports = Set.singleton modulePath
                                            , body = "|> with " ++ modulePath ++ "." ++ fieldType.name
                                            , correspondElmType =
                                                { fieldName = fieldType.name
                                                , fieldType = Decoder.generateType context fieldTypeRef
                                                }
                                            , recordContext = recordContext
                                            }

                                    Just selectionSet__ ->
                                        let
                                            typeName =
                                                case maybeFieldTypeRef of
                                                    Just (TypeReference (ObjectRef str) _) ->
                                                        str

                                                    _ ->
                                                        "foo0"

                                            maybeSubFieldTypeDef =
                                                findTypeDef typeName
                                        in
                                        case maybeSubFieldTypeDef of
                                            Nothing ->
                                                Err ("Can't resolve " ++ fieldType.name)

                                            Just fieldTypeDef ->
                                                selectionSetToString fieldTypeDef recordContext selectionSet__
                                                    |> Result.map
                                                        (\result ->
                                                            { imports =
                                                                result.imports
                                                                    |> Set.insert modulePath
                                                            , body = "|> with " ++ modulePath ++ "." ++ fieldType.name ++ " (\n" ++ result.body ++ "\n)"
                                                            , correspondElmType = { fieldName = fieldType.name, fieldType = result.correspondElmType.fieldType }
                                                            , recordContext = result.recordContext
                                                            }
                                                        )
                    )
                |> combine
                |> Result.map
                    (\results ->
                        { imports =
                            results
                                |> List.map .imports
                                |> List.foldl Set.union Set.empty
                        , body =
                            results
                                |> List.map .body
                                |> String.join "\n"
                        , correspondElmType = { fieldName = "foo", fieldType = "foo1" }
                        , recordContext =
                            results
                                |> List.map .recordContext
                                |> List.foldl
                                    (Dict.merge
                                        (\key a -> Dict.insert key a)
                                        (\key a b -> Dict.insert key a)
                                        (\key b -> Dict.insert key b)
                                        Dict.empty
                                    )
                                    Dict.empty
                                |>  Dict.insert targetRecordName (results |> List.map .correspondElmType)
                        }
                    )
                |> Result.andThen
                    (\result ->
                        Ok
                            { imports =
                                result.imports
                                    |> Set.insert modulePath
                            , body = "SelectionSet.succeed " ++ targetRecordName ++ "\n" ++ result.body
                            , correspondElmType = { fieldName = "foo", fieldType = targetRecordName }
                            , recordContext = result.recordContext
                            }
                    )

        opDefToString : OperationDefintion -> Result String { imports : Set String, body : String, recordContext : RecordContext }
        opDefToString opDef =
            case opDef of
                Operation operationRecord ->
                    let
                        selectionSet_ =
                            operationRecord.selectionSet

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
                        Just typeDef ->
                            selectionSetToString typeDef Dict.empty selectionSet_
                                |> Result.map (\{ imports, body, correspondElmType, recordContext } -> { imports = imports, body = body, recordContext = recordContext })

                        Nothing ->
                            Err ("Can't find " ++ (maybeFieldName |> Maybe.withDefault "unknown type"))

                _ ->
                    Err "Unsupported root level structure"
    in
    parse query
        |> Result.mapError (always "Parser Error")
        |> Result.andThen opDefToString
        |> Result.map
            (\{ imports, body, recordContext } ->
                "module Foo exposing (..)\n\n"
                    ++ "import Graphql.SelectionSet as SelectionSet exposing (hardcoded, with)\n\n"
                    ++ (Set.toList imports
                            |> List.map ((++) "import ")
                            |> String.join "\n"
                       )
                    ++ encodeRecords recordContext
                    ++ "\n\nselection = "
                    ++ body
            )


encodeRecords : Dict String (List { fieldName : String, fieldType : String }) -> String
encodeRecords recordNameToDefinition =
    recordNameToDefinition
        |> Dict.toList
        |> List.map
            (\( recordName, fields ) ->
                "\ntype alias "
                    ++ recordName
                    ++ " =\n{"
                    ++ (fields
                            |> List.map
                                (\{ fieldName, fieldType } ->
                                    fieldName ++ " : " ++ fieldType
                                )
                            |> String.join "\n,"
                       )
                    ++ "\n}"
            )
        |> String.join "\n"

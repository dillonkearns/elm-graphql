module Graphql.QuerySelectionGenerator exposing (..)

import Debug
import Dict exposing (Dict)
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder as Decoder
import Graphql.Generator.Group exposing (IntrospectionData)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (DefinableType(..), TypeReference(..), TypeDefinition(..), ReferrableType(..))
import ModuleName exposing (ModuleName(..))

import Set exposing (Set)
import Graphql.QueryParser exposing (..)

--utility from Result extra


combine =
    List.foldr (Result.map2 (::)) (Ok [])



--


type alias RecordContext =
    Dict String (List { fieldName : String, fieldType : String })


transform : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> IntrospectionData -> Context -> String -> Result String String
transform options introspectionData context query =
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
                                                            , body = "|> with (" ++ modulePath ++ "." ++ fieldType.name ++ " (\n" ++ result.body ++ "\n))"
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

        opDefToString : OperationDefintion -> Result String { imports : Set String, body : String, recordContext : RecordContext, correspondElmType : { fieldName : String, fieldType : String } }
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
                            --     |> Result.map (\{ imports, body, correspondElmType, recordContext } -> 
                            --     { imports = imports, body = body, recordContext = recordContext }
                            -- )

                        Nothing ->
                            Err ("Can't find " ++ (maybeFieldName |> Maybe.withDefault "unknown type"))

                _ ->
                    Err "Unsupported root level structure"
    in
    parse query
        |> Result.mapError (always "Parser Error")
        |> Result.andThen opDefToString
        |> Result.map
            (\{ imports, body, recordContext, correspondElmType } ->
                let
                    modulePath = 
                        List.append options.apiSubmodule [ "Foo" ]
                            |> String.join "."

                in
                
                "module "++ modulePath ++" exposing (..)\n\n"
                    ++ "import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)\n"
                    ++ "import Graphql.Operation exposing (RootQuery)\n"
                    ++ (Set.toList imports
                            |> List.map ((++) "import ")
                            |> String.join "\n"
                       )
                    ++ encodeRecords recordContext
                    ++ "\n\nselection : SelectionSet "++ correspondElmType.fieldType ++ " RootQuery"
                    ++ "\nselection = "
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

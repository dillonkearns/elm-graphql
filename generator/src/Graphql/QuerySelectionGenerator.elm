module Graphql.QuerySelectionGenerator exposing (..)

import Debug
import Dict exposing (Dict)
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder as Decoder
import Graphql.Generator.Group exposing (IntrospectionData)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type as Type exposing (IsNullable(..), DefinableType(..), TypeReference(..), TypeDefinition(..), ReferrableType(..))
import ModuleName exposing (ModuleName(..))
import Graphql.Parser.Scalar as Scalar

import Set exposing (Set)
import Graphql.QueryParser exposing (..)

--utility from Result extra


combine =
    List.foldr (Result.map2 (::)) (Ok [])

incrementUntilUnique dict desiredName iteration =
    let
        candidateName =
            if iteration == 0 then
                desiredName   
            else
                desiredName ++ (String.fromInt iteration)
    in
    case Dict.get candidateName dict of
        Nothing -> candidateName
        Just _ -> --collision
            incrementUntilUnique dict desiredName (iteration +1)

--
type alias ElmRecordField =  { name : String, type_ : String }

type alias RecordContext =
    Dict String (List ElmRecordField)

type alias TranslationResult = 
    Result String 
        { imports : Set String
        , body : String
        , elmRecordField : ElmRecordField
        , recordContext : RecordContext 
        } 

argumentsToString : List Argument -> String
argumentsToString arguments =
    arguments
        |> List.map (\argument ->
            argument.name ++ " = " ++
            case argument.value of 
                Variable name -> "UNIMPLEMENTED"
                IntValue int -> String.fromInt int
                FloatValue float -> String.fromFloat float
                StringValue str -> str
                BooleanValue b -> if b then "True" else "False"
                NullValue  -> "UNIMPLEMENTED"
                EnumValue name -> "UNIMPLEMENTED"
                ListValue values ->  "UNIMPLEMENTED"
                ObjectValue objectValues ->  "UNIMPLEMENTED"
        )
        |> String.join ","

moduleName context typeDef =
    ModuleName.generate context typeDef

nameToTypeDef introspectionData =
    introspectionData.typeDefinitions
        |> List.map
            (\((TypeDefinition className _ _) as typeDef) ->
                ( ClassCaseName.raw className, typeDef )
            )
        |> Dict.fromList

findTypeDef introspectionData rootName =
    Dict.get rootName (nameToTypeDef introspectionData)

typeRefToString (TypeReference referrableType nullable) =
    let
        typeName = case referrableType of
            ObjectRef str -> 
                str
            Scalar scalar -> 
                Scalar.toString scalar
            List typeRef ->
                "List (" ++ typeRefToString typeRef ++ ")"
            _ ->
                "foo0"
    in
    case nullable of
        Nullable -> "Maybe (" ++ typeName ++ ")"
        NonNullable -> typeName


typeRefToTypeString (TypeReference referrableType nullable) =
    case referrableType of
        ObjectRef str -> 
            str
        Scalar scalar -> 
            Scalar.toString scalar
        List typeRef ->
            typeRefToTypeString typeRef
        _ ->
            "foo0"

typeDefinitionToString (TypeDefinition classCaseName definableType maybeDescription) =
    ClassCaseName.raw classCaseName

translateField : Context -> IntrospectionData -> RecordContext -> String -> FieldType -> Type.Field -> TypeDefinition -> TranslationResult
translateField context introspectionData recordContext modulePath fieldType field typeDefinition =
    let            
        fullyQualifiedFieldSelector =
            modulePath ++ "." ++ fieldType.name ++
            (case field.args of 
                [] -> ""
                args -> 
                    -- tbd - handle proper cases of required/optional/combo args
                    -- this just happens to work for my test case for now
                    if List.isEmpty fieldType.arguments then
                        " identity"
                    else
                        " {" ++ (argumentsToString fieldType.arguments) ++ "}"
            )
    in
    case fieldType.selectionSet of
        Nothing ->
            --scalar case
            Ok
                { imports = Set.singleton modulePath -- for now, scalars won't contribute any new imports, but could later
                , body = "|> with " ++ fullyQualifiedFieldSelector
                , elmRecordField =
                    { name = fieldType.name
                    , type_ = typeDefinitionToString typeDefinition
                    }
                , recordContext = recordContext
                }

        Just selectionSet ->
            translateSelectionSet context introspectionData recordContext typeDefinition selectionSet
                |> Result.map
                    (\result ->
                        { imports =
                            result.imports
                                |> Set.insert modulePath
                        , body = "|> with (" ++ fullyQualifiedFieldSelector ++ " (\n" ++ result.body ++ "\n))"
                        , elmRecordField = 
                            { name = fieldType.name
                            , type_ = result.elmRecordField.type_ 
                            }
                        , recordContext = result.recordContext
                        }
                    )


translateTypeReference : TypeReference -> { decorateElmType : String -> String, className : Maybe String }
translateTypeReference (TypeReference referableType isNullable) =
    let
        applyNullableModifier type_ =
            case isNullable of
                Nullable -> "Maybe (" ++ type_ ++ ")"
                NonNullable -> type_
    in
    (case referableType of 
        ObjectRef str -> { decorateElmType = identity, className = Just str }
        Scalar scalar ->
            { decorateElmType = identity 
            , className = Just (Scalar.toString scalar)
            }
        List typeReference ->
            let
                { decorateElmType, className } = translateTypeReference typeReference
            in
            { decorateElmType =  (\elmType_ -> "List (" ++ elmType_ ++ ")")
            , className = className
            }
        _ ->
            { decorateElmType = identity, className = Nothing}
    )
    |> (\res ->
        { decorateElmType = res.decorateElmType >> applyNullableModifier
        , className = res.className
        }
    )

translateSelectionSet : Context -> IntrospectionData -> RecordContext -> TypeDefinition ->  SelectionSet -> TranslationResult
translateSelectionSet context introspectionData recordContext ((TypeDefinition classCaseName definableType maybeDescription) as typeDef) selectionSet =
    let
        modulePath =
            moduleName context typeDef
                |> String.join "."
    in
    case definableType of
        ScalarType -> Err "Unsupported ScalarType type on selection set"
        InterfaceType _ _ -> Err "Unsupported InterfaceType type on selection set"
        UnionType _ -> Err "Unsupported UnionType type on selection set"
        EnumType _ -> Err "Unsupported EnumType type on selection set"
        InputObjectType _ -> Err "Unsupported InputObjectType type on selection set"
        ObjectType fields ->
            let
                fieldNameToField =
                    fields
                        |> List.map (\field -> ( CamelCaseName.raw field.name, field ))
                        |> Dict.fromList
            in
            selectionSet
                |> List.map (\(Field fieldSelection) -> 
                    let
                        maybeField =
                            fieldNameToField
                                |> Dict.get fieldSelection.name
                    in
                    case maybeField of 
                        Nothing -> Err ("Unable to resolve field " ++ fieldSelection.name)
                        Just field ->
                            let
                                { decorateElmType, className } = translateTypeReference field.typeRef
                            
                                maybeTypeDefinition = 
                                    className
                                        |> Maybe.andThen (findTypeDef introspectionData)
                            in
                            case maybeTypeDefinition of
                                Nothing -> Err "Couldn't resolve field's type"
                                Just fieldTypeDef ->
                                    translateField context introspectionData recordContext modulePath fieldSelection field fieldTypeDef
                                        |> Result.map (\result ->
                                            { imports = result.imports
                                            , body = result.body
                                            , elmRecordField = 
                                                { name = result.elmRecordField.name
                                                , type_ = decorateElmType result.elmRecordField.type_ 
                                                }
                                            , recordContext = result.recordContext
                                            }
                                        )
                )
                |> combine
                |> Result.map
                    (\results ->
                        let
                            imports =
                                results
                                    |> List.map .imports
                                    |> List.foldl Set.union Set.empty
                                    |> Set.insert modulePath
                            body =
                                results
                                    |> List.map .body
                                    |> String.join "\n"
                            
                            newRecordContext =
                                results
                                    |> List.map .recordContext
                                    |> (List.foldl
                                        (\d1 d2 ->
                                            Dict.merge
                                                (Dict.insert)
                                                (\key a b -> 
                                                    Dict.insert key a
                                                        >> Dict.insert (key ++ "2") b -- doing this breaks resolution later
                                                )
                                                (Dict.insert)
                                                d1
                                                d2
                                                Dict.empty
                                        )
                                        Dict.empty)
 
                            targetRecordName =
                                incrementUntilUnique newRecordContext (ClassCaseName.raw classCaseName ++ "Record") 0

                        in
                            { imports = imports
                            , body = "SelectionSet.succeed " ++ targetRecordName ++ "\n" ++ body
                            , elmRecordField = { name = "foo", type_ = targetRecordName }
                            , recordContext = 
                                newRecordContext 
                                    |> Dict.insert targetRecordName (results |> List.map .elmRecordField)
                            }
                    )
       

translateOperationDefinition : Context -> IntrospectionData -> OperationDefintion -> TranslationResult
translateOperationDefinition context introspectionData opDef =
    case opDef of
        SelectionSet selectionSet -> Err "Unsupported root level structure"
        Operation operationRecord ->
            let
                selectionSet = operationRecord.selectionSet

                maybeFieldName =
                    case operationRecord.type_ of
                        Query -> Just introspectionData.queryObjectName
                        Mutation -> introspectionData.mutationObjectName
                        Subscription -> introspectionData.subscriptionObjectName

                maybeTypeDef =
                    maybeFieldName
                        |> Maybe.andThen (findTypeDef introspectionData)
            in
            case maybeTypeDef of
                Nothing ->  Err ("Can't find " ++ (maybeFieldName |> Maybe.withDefault "unknown type"))
                Just typeDef ->
                    translateSelectionSet context introspectionData  Dict.empty typeDef selectionSet

transform : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> IntrospectionData -> Context -> String -> Result String String
transform options introspectionData context query =
    parse query
        |> Result.mapError (always "Parser Error")
        |> Result.andThen (translateOperationDefinition context introspectionData)
        |> Result.map
            (\{ imports, body, recordContext, elmRecordField } ->
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
                    ++ "\n\nselection : SelectionSet "++ elmRecordField.type_ ++ " RootQuery"
                    ++ "\nselection = "
                    ++ body
            )


encodeRecords : RecordContext -> String
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
                                (\{ name, type_ } ->
                                    name ++ " : " ++ type_
                                )
                            |> String.join "\n,"
                       )
                    ++ "\n}"
            )
        |> String.join "\n"

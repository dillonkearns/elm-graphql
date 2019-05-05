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
import Result.Extra as Result
import Parser
import Set exposing (Set)
import Graphql.QueryParser exposing (..)
import Graphql.Generator.Normalize as Normalize


deadEndToString : Parser.DeadEnd -> String
deadEndToString deadend = 
  problemToString deadend.problem ++ " at row " ++ String.fromInt deadend.row ++ ", col " ++ String.fromInt deadend.col


problemToString : Parser.Problem -> String 
problemToString p = 
  case p of 
   Parser.Expecting s -> "expecting '" ++ s ++ "'"
   Parser.ExpectingInt -> "expecting int" 
   Parser.ExpectingHex -> "expecting hex" 
   Parser.ExpectingOctal -> "expecting octal" 
   Parser.ExpectingBinary -> "expecting binary" 
   Parser.ExpectingFloat -> "expecting float" 
   Parser.ExpectingNumber -> "expecting number" 
   Parser.ExpectingVariable -> "expecting variable" 
   Parser.ExpectingSymbol s -> "expecting symbol '" ++ s ++ "'"
   Parser.ExpectingKeyword s -> "expecting keyword '" ++ s ++ "'"
   Parser.ExpectingEnd -> "expecting end" 
   Parser.UnexpectedChar -> "unexpected char" 
   Parser.Problem s -> "problem " ++ s 
   Parser.BadRepeat -> "bad repeat" 

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

type alias Translation = 
    { imports : Set String
    , body : String
    , elmRecordField : ElmRecordField
    , recordContext : RecordContext 
    } 

type alias TranslationResult = 
    Result String Translation
    

argumentToString : (Argument, Type.Arg)-> String
argumentToString (argument, argType) =
    let
        (TypeReference referrableType isNullable) = argType.typeRef

        wrapValueBasedOnType = 
            case referrableType of
                Scalar(Scalar.Custom(className)) ->
                    (\value -> (ClassCaseName.normalized className) ++ "(" ++ value ++ ")")
                _ -> identity

        argumentValueString = 
            case argument.value of 
                Variable name -> name
                IntValue int -> String.fromInt int |> wrapValueBasedOnType
                FloatValue float -> String.fromFloat float |> wrapValueBasedOnType
                StringValue str -> str |> wrapValueBasedOnType
                BooleanValue b -> if b then "True" else "False" |> wrapValueBasedOnType
                NullValue  -> "UNIMPLEMENTED"
                EnumValue name -> "UNIMPLEMENTED"
                ListValue values ->  "UNIMPLEMENTED"
                ObjectValue objectValues ->  "UNIMPLEMENTED"
    in
    argument.name ++ " = " ++ argumentValueString
        

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

typeDefinitionToString (TypeDefinition classCaseName definableType maybeDescription) =
    ClassCaseName.raw classCaseName

typeToString type_ = 
    case type_ of
        NamedType name -> "Maybe " ++ name
        ListType type__ -> "Maybe (List ("++ (typeToString type__)++"))"
        NonNullType(NonNullNamedType name) -> name
        NonNullType(NonNullListType type__) -> "List ("++ (typeToString type__)++")"


translateArguments : List Argument -> List Type.Arg -> Result String String
translateArguments arguments argumentTypes =
    let
        hasAnyOptionalArgs =
            argumentTypes
                |> List.any isArgumentOptional
        
        hasAnyRequiredArgs = 
            argumentTypes
                    |> List.any (isArgumentOptional >> not)

        argNameToType =
            argumentTypes
                |> List.map (\arg -> (CamelCaseName.raw arg.name, arg))
                |> Dict.fromList

        isArgumentOptional arg =
            case arg.typeRef of
                TypeReference referableType Nullable ->
                    True
                TypeReference referableType NonNullable ->
                    False

        split argsAndTypes =
            List.partition (Tuple.second >> isArgumentOptional) argsAndTypes

        argAndTypesResults =
            arguments
                |> List.map (\arg -> 
                    Dict.get arg.name argNameToType
                        |> Maybe.map (\argType -> Ok (arg, argType))
                        |> Maybe.withDefault (Err ("Can't resolve type for arg " ++ arg.name))
                )
    in
    Result.combine argAndTypesResults
        |> Result.map (\argsAndTypes ->
            let
                (optionalArgAndTypes, requiredArgsAndTypes) = split argsAndTypes

                -- Optional arguments are in the form of a function that modifies
                -- a record pre-populated with default values
                optionalArgumentCode =
                    if not hasAnyOptionalArgs then
                        ""
                    else if List.isEmpty optionalArgAndTypes then
                        "identity"
                    else
                        "(\\optionalArgs -> " ++
                        "{ optionalArgs | " ++
                            (optionalArgAndTypes
                                |> List.map argumentToString
                                |> String.join ",") ++
                        "})"
                    
                requiredArgumentCode = 
                    if not hasAnyRequiredArgs then
                        ""
                    else if List.isEmpty requiredArgsAndTypes then
                        ""
                    else
                        "{" ++
                            (requiredArgsAndTypes
                                |> List.map argumentToString
                                |> String.join ","
                            ) ++
                        "}"
            in
             " " ++ optionalArgumentCode ++ " " ++ requiredArgumentCode
        )

translateField : Context -> IntrospectionData -> RecordContext -> String -> FieldType -> Type.Field -> TypeDefinition -> TranslationResult
translateField context introspectionData recordContext modulePath fieldType field typeDefinition =
    let
        fullyQualifiedFieldSelectorResult = translateArguments fieldType.arguments field.args
            |> Result.map (\translatedArguments ->
                modulePath ++ "." ++ fieldType.name ++
                (case field.args of 
                    [] -> ""
                    args -> translatedArguments
                )
            )
    in
    fullyQualifiedFieldSelectorResult
        |> Result.andThen(\fullyQualifiedFieldSelector -> 
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
translateSelectionSet context introspectionData recordContextOriginal ((TypeDefinition classCaseName definableType maybeDescription) as typeDef) selectionSet =
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
                
                accumulateFieldResults : Selection -> { recordContext : RecordContext, translatedFields : List TranslationResult } -> { recordContext : RecordContext, translatedFields : List TranslationResult }
                accumulateFieldResults (Field fieldSelection) accumContext  =
                    let
                        maybeField =
                            fieldNameToField
                                |> Dict.get fieldSelection.name
                    in
                    case maybeField of 
                        Nothing -> { accumContext | translatedFields = accumContext.translatedFields ++ [ Err ("Unable to resolve field " ++ fieldSelection.name) ] }
                        Just field ->
                            let
                                { decorateElmType, className } = translateTypeReference field.typeRef
                            
                                maybeTypeDefinition = 
                                    className
                                        |> Maybe.andThen (findTypeDef introspectionData)
                            in
                            case maybeTypeDefinition of
                                Nothing -> { accumContext | translatedFields = accumContext.translatedFields ++ [  Err "Couldn't resolve field's type" ] }
                                Just fieldTypeDef ->
                                    let
                                        translatedFieldResult = translateField context introspectionData accumContext.recordContext modulePath fieldSelection field fieldTypeDef
                                            |> Result.map (\translation ->
                                                { translation |
                                                    elmRecordField = 
                                                        { name = translation.elmRecordField.name
                                                        , type_ = decorateElmType translation.elmRecordField.type_
                                                        }
                                                }
                                            )

                                        recordContext_ = 
                                            translatedFieldResult
                                                |> Result.map .recordContext
                                                |> Result.withDefault accumContext.recordContext
                                        

                                    in
                                    { recordContext =  recordContext_
                                    , translatedFields = accumContext.translatedFields ++ [ translatedFieldResult ]
                                    }
            in
            -- if we FOLD over children, vs map + combine, we can thread the global
            -- record name context through and avoid complicated type name collision 
            -- resolution
            selectionSet
                |> List.foldl accumulateFieldResults { recordContext = recordContextOriginal, translatedFields = [] } 
                |> (\accumulatedFieldResults ->
                    -- let's do a quick translation to err if any of the fields errd
                    Result.combine accumulatedFieldResults.translatedFields
                        |> Result.map (\translations ->
                            { recordContext = accumulatedFieldResults.recordContext
                            , translations = translations
                            }
                        )
                )
                |> Result.map (\{ recordContext, translations } ->
                    let
                        imports =
                            translations
                                |> List.map .imports
                                |> List.foldl Set.union Set.empty
                                |> Set.insert modulePath
                        body =
                            translations
                                |> List.map .body
                                |> String.join "\n"

                        newRecordName =
                            incrementUntilUnique recordContext (ClassCaseName.raw classCaseName ++ "Record") 0

                        newRecordFields =
                            translations |> List.map .elmRecordField
                    in
                        { imports = imports
                        , body = "SelectionSet.succeed " ++ newRecordName ++ "\n" ++ body
                        , elmRecordField = { name = "foo", type_ = newRecordName }
                        , recordContext = 
                            recordContext 
                                |> Dict.insert newRecordName newRecordFields
                        }
                )
       

translateOperationDefinition : Context -> IntrospectionData -> OperationDefintion -> Result String { imports : Set String, body : String, recordContext: RecordContext}
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

                variableNames =
                    operationRecord.variableDefinitions
                        |> List.map .variable
                        |> String.join " "

                variableTypes =
                    operationRecord.variableDefinitions
                        |> List.map .type_
                        |> List.map typeToString
                        |> List.map Normalize.capitalized
            in
            case maybeTypeDef of
                Nothing ->  Err ("Can't find " ++ (maybeFieldName |> Maybe.withDefault "unknown type"))
                Just typeDef ->
                    translateSelectionSet context introspectionData Dict.empty typeDef selectionSet
                        |> Result.map (\result ->
                            let
                                typeSignature = 
                                    (variableTypes++["SelectionSet "++ result.elmRecordField.type_ ++ " RootQuery"])
                                        |> String.join " -> "
                            in
                            
                            { imports = result.imports
                            , recordContext = result.recordContext
                            , body = 
                                "\n\nselection : " ++ typeSignature ++
                                "\nselection " ++ variableNames ++ " = " ++
                                result.body
                            }
                        )

transform : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> IntrospectionData -> Context -> List String -> String -> Result String String
transform options introspectionData context modulePath query =
    parse query
        |> Result.mapError (\deadEnds -> String.concat (List.intersperse "; " (List.map deadEndToString deadEnds)))
        |> Result.andThen (translateOperationDefinition context introspectionData)
        |> Result.map
            (\{ imports, body, recordContext } ->
                let
                    modulePathString = 
                        modulePath
                            |> String.join "."
                in
                "module "++ modulePathString ++" exposing (..)\n\n"
                    ++ "import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)\n"
                    ++ "import Graphql.OptionalArgument exposing (OptionalArgument(..), fromMaybe)\n"
                    ++ "import Graphql.Operation exposing (RootQuery)\n"
                    ++ (context.scalarCodecsModule
                        |> Maybe.map ModuleName.toString
                        |> Maybe.map (\path -> "import " ++ path ++ " exposing (..)\n")
                        |> Maybe.withDefault ""
                    )
                    ++ (Set.toList imports
                            |> List.map ((++) "import ")
                            |> String.join "\n"
                       )
                    ++ encodeRecords recordContext
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

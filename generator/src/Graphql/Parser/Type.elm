module Graphql.Parser.Type exposing
    ( Arg
    , DefinableType(..)
    , EnumValue
    , Field
    , IsNullable(..)
    , RawTypeRef(..)
    , ReferrableType(..)
    , TypeDefinition(..)
    , TypeReference(..)
    , decoder
    , parseRef
    , typeDefinition
    , typeRefDecoder
    )

import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Scalar as Scalar exposing (Scalar)
import Graphql.Parser.TypeKind as TypeKind exposing (TypeKind)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra exposing (fromResult)
import Result.Extra


decoder : Decoder TypeDefinition
decoder =
    Decode.field "kind" Decode.string
        |> Decode.andThen decodeKind


decodeKind : String -> Decoder TypeDefinition
decodeKind kind =
    case kind of
        "OBJECT" ->
            objectDecoder

        "ENUM" ->
            enumDecoder

        "SCALAR" ->
            scalarDecoder

        "INTERFACE" ->
            interfaceDecoder

        "UNION" ->
            unionDecoder

        "INPUT_OBJECT" ->
            inputObjectDecoder

        _ ->
            Decode.fail ("Unexpected kind " ++ kind)


scalarDecoder : Decoder TypeDefinition
scalarDecoder =
    Decode.map (\scalarName -> typeDefinition scalarName ScalarType Nothing)
        (Decode.field "name" Decode.string)


inputObjectDecoder : Decoder TypeDefinition
inputObjectDecoder =
    Decode.map2 createInputObject
        (Decode.field "name" Decode.string)
        (inputField
            |> Decode.andThen
                (parseField
                    >> fromResult
                )
            |> Decode.list
            |> Decode.field "inputFields"
        )


interfaceDecoder : Decoder TypeDefinition
interfaceDecoder =
    Decode.map3 createInterface
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.andThen
                (parseField
                    >> fromResult
                )
            |> Decode.list
            |> Decode.field "fields"
        )
        (Decode.field "possibleTypes" (Decode.string |> Decode.field "name" |> Decode.list))


unionDecoder : Decoder TypeDefinition
unionDecoder =
    Decode.map2 createUnion
        (Decode.field "name" Decode.string)
        (Decode.field "possibleTypes" (Decode.string |> Decode.field "name" |> Decode.list))


parseField : RawField -> Result String Field
parseField { name, ofType, args, description } =
    Result.map2
        (\typeRef args_ ->
            { name = CamelCaseName.build name
            , description = description
            , typeRef = typeRef
            , args = args_
            }
        )
        (parseRef ofType)
        (args
            |> List.map
                (\arg ->
                    arg.ofType
                        |> parseRef
                        |> Result.map
                            (\ofType_ ->
                                { name = CamelCaseName.build arg.name
                                , description = arg.description
                                , typeRef = ofType_
                                }
                            )
                )
            |> Result.Extra.combine
        )


objectDecoder : Decoder TypeDefinition
objectDecoder =
    Decode.map2 createObject
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.andThen
                (parseField
                    >> fromResult
                )
            |> Decode.list
            |> Decode.field "fields"
        )


enumDecoder : Decoder TypeDefinition
enumDecoder =
    Decode.map3 createEnum
        (Decode.field "name" Decode.string)
        (Decode.maybe (Decode.field "description" Decode.string))
        (enumValueDecoder
            |> Decode.list
            |> Decode.field "enumValues"
        )


enumValueDecoder : Decoder EnumValue
enumValueDecoder =
    Decode.map2 EnumValue
        (Decode.field "name" Decode.string |> Decode.map ClassCaseName.build)
        (Decode.field "description" (Decode.maybe Decode.string))


type alias EnumValue =
    { name : ClassCaseName
    , description : Maybe String
    }


createEnum : String -> Maybe String -> List EnumValue -> TypeDefinition
createEnum enumName description enumValues =
    typeDefinition enumName (EnumType enumValues) description


createObject : String -> List Field -> TypeDefinition
createObject objectName fields =
    typeDefinition objectName (ObjectType fields) Nothing


createInterface : String -> List Field -> List String -> TypeDefinition
createInterface interfaceName fields possibleTypes =
    typeDefinition interfaceName (InterfaceType fields (List.map ClassCaseName.build possibleTypes)) Nothing


createInputObject : String -> List Field -> TypeDefinition
createInputObject inputObjectName fields =
    typeDefinition inputObjectName (InputObjectType fields) Nothing


createUnion : String -> List String -> TypeDefinition
createUnion interfaceName possibleTypes =
    typeDefinition interfaceName (UnionType (List.map ClassCaseName.build possibleTypes)) Nothing


typeRefDecoder : Decoder RawTypeRef
typeRefDecoder =
    Decode.map3 createRawTypeRef
        (Decode.field "name" Decode.string |> Decode.maybe)
        (Decode.field "kind" TypeKind.decoder)
        (Decode.maybe
            (Decode.field "ofType"
                (Decode.lazy (\_ -> typeRefDecoder))
            )
        )


fieldDecoder : Decoder RawField
fieldDecoder =
    Decode.map4 RawField
        (Decode.field "name" Decode.string)
        (Decode.field "description" (Decode.maybe Decode.string))
        (Decode.field "type" typeRefDecoder)
        (argDecoder |> Decode.list |> Decode.field "args")


inputField : Decoder RawField
inputField =
    Decode.map4 RawField
        (Decode.field "name" Decode.string)
        (Decode.field "description" (Decode.maybe Decode.string))
        (Decode.field "type" typeRefDecoder)
        (Decode.succeed [])


argDecoder : Decoder RawArg
argDecoder =
    Decode.map3 RawArg
        (Decode.field "name" Decode.string)
        (Decode.field "description" (Decode.maybe Decode.string))
        (Decode.field "type" typeRefDecoder)


createRawTypeRef : Maybe String -> TypeKind -> Maybe RawTypeRef -> RawTypeRef
createRawTypeRef stringMaybe typeKind rawTypeRefMaybe =
    RawTypeRef { name = stringMaybe, kind = typeKind, ofType = rawTypeRefMaybe }


type alias Arg =
    { name : CamelCaseName
    , description : Maybe String
    , typeRef : TypeReference
    }


type alias Field =
    { name : CamelCaseName
    , description : Maybe String
    , typeRef : TypeReference
    , args : List Arg
    }


type TypeDefinition
    = TypeDefinition ClassCaseName DefinableType (Maybe String)


typeDefinition : String -> DefinableType -> Maybe String -> TypeDefinition
typeDefinition name definableType description =
    TypeDefinition (ClassCaseName.build name) definableType description


type DefinableType
    = ScalarType
    | ObjectType (List Field)
    | InterfaceType (List Field) (List ClassCaseName)
    | UnionType (List ClassCaseName)
    | EnumType (List EnumValue)
    | InputObjectType (List Field)


type TypeReference
    = TypeReference ReferrableType IsNullable


type ReferrableType
    = Scalar Scalar.Scalar
    | List TypeReference
    | EnumRef ClassCaseName
    | ObjectRef String
    | InputObjectRef ClassCaseName
    | UnionRef String
    | InterfaceRef String


expectString : Maybe String -> Result String String
expectString =
    Result.fromMaybe "Expected string but got Nothing"


parseRef : RawTypeRef -> Result String TypeReference
parseRef (RawTypeRef rawTypeRef) =
    case rawTypeRef.kind of
        TypeKind.List ->
            case rawTypeRef.ofType of
                Just nestedOfType ->
                    nestedOfType
                        |> parseRef
                        |> Result.map
                            (\t ->
                                TypeReference (List t) Nullable
                            )

                Nothing ->
                    Err "Missing nested type for List reference"

        TypeKind.Scalar ->
            case rawTypeRef.name of
                Just scalarName ->
                    TypeReference
                        (Scalar (Scalar.parse scalarName))
                        Nullable
                        |> Ok

                Nothing ->
                    Err "Should not get null names for scalar references"

        TypeKind.Interface ->
            case rawTypeRef.name of
                Just interfaceName ->
                    TypeReference (InterfaceRef interfaceName) Nullable
                        |> Ok

                Nothing ->
                    Err "Should not get null names for interface references"

        TypeKind.Object ->
            case rawTypeRef.name of
                Just objectName ->
                    TypeReference (ObjectRef objectName) Nullable
                        |> Ok

                Nothing ->
                    Err "Should not get null names for object references"

        TypeKind.NonNull ->
            case rawTypeRef.ofType of
                Just (RawTypeRef actualOfType) ->
                    case ( actualOfType.kind, actualOfType.name ) of
                        ( TypeKind.Scalar, scalarName ) ->
                            scalarName
                                |> expectString
                                |> Result.map
                                    (\str ->
                                        TypeReference
                                            (Scalar (Scalar.parse str))
                                            NonNullable
                                    )

                        ( TypeKind.Object, objectName ) ->
                            objectName
                                |> expectString
                                |> Result.map
                                    (\str ->
                                        TypeReference (ObjectRef str) NonNullable
                                    )

                        ( TypeKind.Interface, interfaceName ) ->
                            interfaceName
                                |> expectString
                                |> Result.map
                                    (\str ->
                                        TypeReference (InterfaceRef str) NonNullable
                                    )

                        ( TypeKind.List, _ ) ->
                            case actualOfType.ofType of
                                Just nestedOfType ->
                                    nestedOfType
                                        |> parseRef
                                        |> Result.map
                                            (\t ->
                                                TypeReference (List t) NonNullable
                                            )

                                Nothing ->
                                    Err "TODO"

                        ( TypeKind.NonNull, _ ) ->
                            Err "Can't have nested non-null types"

                        ( TypeKind.Ignore, _ ) ->
                            Ok ignoreRef

                        ( TypeKind.Enum, enumName ) ->
                            enumName
                                |> expectString
                                |> Result.map
                                    (\str ->
                                        TypeReference (str |> ClassCaseName.build |> EnumRef) NonNullable
                                    )

                        ( TypeKind.InputObject, inputObjectName ) ->
                            inputObjectName
                                |> expectString
                                |> Result.map
                                    (\str ->
                                        TypeReference (str |> ClassCaseName.build |> InputObjectRef) NonNullable
                                    )

                        ( TypeKind.Union, _ ) ->
                            actualOfType.name
                                |> expectString
                                |> Result.map
                                    (\str ->
                                        TypeReference (UnionRef str) NonNullable
                                    )

                Nothing ->
                    Ok ignoreRef

        TypeKind.Ignore ->
            Ok ignoreRef

        TypeKind.Enum ->
            case rawTypeRef.name of
                Just objectName ->
                    TypeReference (objectName |> ClassCaseName.build |> EnumRef) Nullable
                        |> Ok

                Nothing ->
                    Err "Should not get null names for enum references"

        TypeKind.InputObject ->
            case rawTypeRef.name of
                Just inputObjectName ->
                    TypeReference (inputObjectName |> ClassCaseName.build |> InputObjectRef) Nullable
                        |> Ok

                Nothing ->
                    Err "Should not get null names for input object references"

        TypeKind.Union ->
            rawTypeRef.name
                |> expectString
                |> Result.map
                    (\str ->
                        TypeReference (UnionRef str) Nullable
                    )


ignoreRef : TypeReference
ignoreRef =
    TypeReference (Scalar Scalar.String) Nullable


type IsNullable
    = Nullable
    | NonNullable


type RawTypeRef
    = RawTypeRef
        { name : Maybe String
        , kind : TypeKind
        , ofType : Maybe RawTypeRef
        }


type alias RawField =
    { name : String
    , description : Maybe String
    , ofType : RawTypeRef
    , args : List RawArg
    }


type alias RawArg =
    { name : String
    , description : Maybe String
    , ofType : RawTypeRef
    }

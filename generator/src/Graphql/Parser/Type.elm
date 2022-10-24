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
    , interfacesImplemented
    , isInterfaceType
    , isObjectType
    , parseRef
    , rawName
    , typeDefinition
    , typeRefDecoder
    )

import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Scalar as Scalar exposing (Scalar)
import Graphql.Parser.TypeKind as TypeKind exposing (TypeKind)
import Json.Decode as Decode exposing (Decoder)
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
            |> Decode.andThen parseField
            |> Decode.list
            |> Decode.field "inputFields"
        )


interfaceDecoder : Decoder TypeDefinition
interfaceDecoder =
    Decode.map4 createInterface
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.andThen parseField
            |> Decode.list
            |> Decode.field "fields"
        )
        (Decode.field "possibleTypes" (Decode.string |> Decode.field "name" |> Decode.list)
            |> Decode.map (List.map ClassCaseName.build)
        )
        (Decode.field "interfaces" (Decode.maybe (Decode.string |> Decode.field "name" |> Decode.list))
            |> Decode.map (Maybe.map (List.map ClassCaseName.build))
            |> Decode.map (Maybe.withDefault [])
        )


unionDecoder : Decoder TypeDefinition
unionDecoder =
    Decode.map2 createUnion
        (Decode.field "name" Decode.string)
        (Decode.field "possibleTypes" (Decode.string |> Decode.field "name" |> Decode.list))


parseField : RawField -> Decoder Field
parseField { name, ofType, args, description } =
    let
        argRefs =
            args
                |> List.map
                    (\arg ->
                        parseRef arg.ofType
                            |> Result.map
                                (\argType ->
                                    { name = CamelCaseName.build arg.name
                                    , description = arg.description
                                    , typeRef = argType
                                    }
                                )
                    )
                |> Result.Extra.combine
    in
    case Result.map2 Tuple.pair (parseRef ofType) argRefs of
        Ok ( ofTypeRef, okArgRefs ) ->
            Decode.succeed
                { name = CamelCaseName.build name
                , description = description
                , typeRef = ofTypeRef
                , args = okArgRefs
                }

        Err error ->
            Decode.fail error


objectDecoder : Decoder TypeDefinition
objectDecoder =
    Decode.map3 createObject
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.andThen parseField
            |> Decode.list
            |> Decode.field "fields"
        )
        (Decode.field "interfaces" (Decode.maybe (Decode.string |> Decode.field "name" |> Decode.list))
            |> Decode.map (Maybe.map (List.map ClassCaseName.build))
            |> Decode.map (Maybe.withDefault [])
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


createObject : String -> List Field -> List ClassCaseName -> TypeDefinition
createObject objectName fields interfaces_ =
    typeDefinition objectName (ObjectType fields interfaces_) Nothing


createInterface : String -> List Field -> List ClassCaseName -> List ClassCaseName -> TypeDefinition
createInterface interfaceName fields possibleTypes interfaces_ =
    typeDefinition interfaceName (InterfaceType fields possibleTypes interfaces_) Nothing


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
        descriptionWithDeprecationDecoder
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


descriptionWithDeprecationDecoder : Decoder (Maybe String)
descriptionWithDeprecationDecoder =
    Decode.map3
        (\description isDeprecated deprecationReason ->
            Maybe.map
                (\desc ->
                    if isDeprecated then
                        desc ++ "\n@deprecated " ++ Maybe.withDefault "" deprecationReason

                    else
                        desc
                )
                description
        )
        (Decode.field "description" (Decode.maybe Decode.string))
        (Decode.field "isDeprecated" Decode.bool)
        (Decode.field "deprecationReason" (Decode.maybe Decode.string))


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
typeDefinition name definableType_ description =
    TypeDefinition (ClassCaseName.build name) definableType_ description


type DefinableType
    = ScalarType
    | ObjectType (List Field) (List ClassCaseName)
    | InterfaceType (List Field) (List ClassCaseName) (List ClassCaseName)
    | UnionType (List ClassCaseName)
    | EnumType (List EnumValue)
    | InputObjectType (List Field)


type TypeReference
    = TypeReference ReferrableType IsNullable


type ReferrableType
    = Scalar Scalar
    | List TypeReference
    | EnumRef ClassCaseName
    | ObjectRef String
    | InputObjectRef ClassCaseName
    | UnionRef String
    | InterfaceRef String


isObjectType : TypeDefinition -> Bool
isObjectType typeDef =
    case typeDef of
        TypeDefinition _ (ObjectType _ _) _ ->
            True

        _ ->
            False


isInterfaceType : TypeDefinition -> Bool
isInterfaceType typeDef =
    case typeDef of
        TypeDefinition _ (InterfaceType _ _ _) _ ->
            True

        _ ->
            False


{-| Returns a list of ClassCaseName of the Interfaces that this Type
implements
-}
interfacesImplemented : TypeDefinition -> List ClassCaseName
interfacesImplemented typeDef =
    case typeDef of
        TypeDefinition _ (InterfaceType _ _ i) _ ->
            i

        TypeDefinition _ (ObjectType _ i) _ ->
            i

        _ ->
            []


rawName : TypeDefinition -> String
rawName (TypeDefinition n _ _) =
    ClassCaseName.raw n


expectPresent : Maybe value -> Result String value
expectPresent maybeString =
    case maybeString of
        Just string ->
            Ok string

        Nothing ->
            Err "Expected string but got Nothing"


parseRef : RawTypeRef -> Result String TypeReference
parseRef (RawTypeRef rawTypeRef) =
    case rawTypeRef.kind of
        TypeKind.List ->
            case rawTypeRef.ofType of
                Just nestedOfType ->
                    parseRef nestedOfType
                        |> Result.map (\listRef -> TypeReference (List listRef) Nullable)

                Nothing ->
                    Err "Missing nested type for List reference"

        TypeKind.Scalar ->
            case rawTypeRef.name of
                Just scalarName ->
                    TypeReference (Scalar (Scalar.parse scalarName)) Nullable
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
                                |> expectPresent
                                |> Result.map
                                    (\presentScalarName ->
                                        TypeReference
                                            (Scalar (presentScalarName |> Scalar.parse))
                                            NonNullable
                                    )

                        ( TypeKind.Object, objectName ) ->
                            objectName
                                |> expectPresent
                                |> Result.map
                                    (\presentObjectName ->
                                        TypeReference (presentObjectName |> ObjectRef) NonNullable
                                    )

                        ( TypeKind.Interface, interfaceName ) ->
                            interfaceName
                                |> expectPresent
                                |> Result.map
                                    (\presentName ->
                                        TypeReference (presentName |> InterfaceRef) NonNullable
                                    )

                        ( TypeKind.List, _ ) ->
                            case actualOfType.ofType of
                                Just nestedOfType ->
                                    parseRef nestedOfType
                                        |> Result.map (\listRef -> TypeReference (List listRef) NonNullable)

                                Nothing ->
                                    Err ""

                        ( TypeKind.NonNull, _ ) ->
                            Err "Can't have nested non-null types"

                        ( TypeKind.Ignore, _ ) ->
                            Ok ignoreRef

                        ( TypeKind.Enum, enumName ) ->
                            enumName
                                |> expectPresent
                                |> Result.map
                                    (\presentName ->
                                        TypeReference (presentName |> ClassCaseName.build |> EnumRef) NonNullable
                                    )

                        ( TypeKind.InputObject, inputObjectName ) ->
                            inputObjectName
                                |> expectPresent
                                |> Result.map
                                    (\presentName ->
                                        TypeReference (presentName |> ClassCaseName.build |> InputObjectRef) NonNullable
                                    )

                        ( TypeKind.Union, _ ) ->
                            actualOfType.name
                                |> expectPresent
                                |> Result.map
                                    (\presentName ->
                                        TypeReference (presentName |> UnionRef) NonNullable
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
                |> expectPresent
                |> Result.map (\typeRefName -> TypeReference (UnionRef typeRefName) Nullable)


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

module Graphqelm.Parser.Type
    exposing
        ( Arg
        , DefinableType(..)
        , EnumValue
        , Field
        , IsNullable(..)
        , RawTypeRef(RawTypeRef)
        , ReferrableType(..)
        , TypeDefinition(TypeDefinition)
        , TypeReference(TypeReference)
        , decoder
        , parseRef
        , typeRefDecoder
        )

import Graphqelm.Parser.EnumName as EnumName exposing (EnumName)
import Graphqelm.Parser.FieldName as FieldName exposing (FieldName)
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.TypeKind as TypeKind exposing (TypeKind)
import Json.Decode as Decode exposing (Decoder)


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

        _ ->
            scalarDecoder



-- Decode.fail ("Unknown kind " ++ kind)


scalarDecoder : Decoder TypeDefinition
scalarDecoder =
    Decode.map (\scalarName -> TypeDefinition scalarName ScalarType Nothing)
        (Decode.field "name" Decode.string)


interfaceDecoder : Decoder TypeDefinition
interfaceDecoder =
    Decode.map3 createInterface
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.map parseField
            |> Decode.list
            |> Decode.field "fields"
        )
        (Decode.field "possibleTypes" (Decode.string |> Decode.field "name" |> Decode.list))


unionDecoder : Decoder TypeDefinition
unionDecoder =
    Decode.map2 createUnion
        (Decode.field "name" Decode.string)
        (Decode.field "possibleTypes" (Decode.string |> Decode.field "name" |> Decode.list))


parseField : RawField -> Field
parseField { name, ofType, args, description } =
    { name = FieldName.fieldName name
    , description = description
    , typeRef = parseRef ofType
    , args =
        List.map
            (\arg ->
                { name = arg.name
                , description = arg.description
                , typeRef = parseRef arg.ofType
                }
            )
            args
    }


objectDecoder : Decoder TypeDefinition
objectDecoder =
    Decode.map2 createObject
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.map parseField
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
        (Decode.field "name" Decode.string |> Decode.map EnumName.enumName)
        (Decode.field "description" (Decode.maybe Decode.string))


type alias EnumValue =
    { name : EnumName
    , description : Maybe String
    }


createEnum : String -> Maybe String -> List EnumValue -> TypeDefinition
createEnum enumName description enumValues =
    TypeDefinition enumName (EnumType enumValues) description


createObject : String -> List Field -> TypeDefinition
createObject objectName fields =
    TypeDefinition objectName (ObjectType fields) Nothing


createInterface : String -> List Field -> List String -> TypeDefinition
createInterface interfaceName fields possibleTypes =
    TypeDefinition interfaceName (InterfaceType fields possibleTypes) Nothing


createUnion : String -> List String -> TypeDefinition
createUnion interfaceName possibleTypes =
    TypeDefinition interfaceName (UnionType possibleTypes) Nothing


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
    { name : String
    , description : Maybe String
    , typeRef : TypeReference
    }


type alias Field =
    { name : FieldName
    , description : Maybe String
    , typeRef : TypeReference
    , args : List Arg
    }


type TypeDefinition
    = TypeDefinition String DefinableType (Maybe String)


type DefinableType
    = ScalarType
    | ObjectType (List Field)
    | InterfaceType (List Field) (List String)
    | UnionType (List String)
    | EnumType (List EnumValue)


type TypeReference
    = TypeReference ReferrableType IsNullable


type ReferrableType
    = Scalar Scalar.Scalar
    | List TypeReference
    | EnumRef String
    | ObjectRef String
    | InputObjectRef String
    | UnionRef String
    | InterfaceRef String


expectString : Maybe String -> String
expectString maybeString =
    case maybeString of
        Just string ->
            string

        Nothing ->
            Debug.crash "Expected string but got Nothing"


parseRef : RawTypeRef -> TypeReference
parseRef (RawTypeRef rawTypeRef) =
    case rawTypeRef.kind of
        TypeKind.List ->
            case rawTypeRef.ofType of
                Just nestedOfType ->
                    TypeReference (List (parseRef nestedOfType)) Nullable

                Nothing ->
                    Debug.crash "Missing nested type for List reference"

        TypeKind.Scalar ->
            case rawTypeRef.name of
                Just scalarName ->
                    TypeReference
                        (Scalar (Scalar.parse scalarName))
                        Nullable

                Nothing ->
                    Debug.crash "Should not get null names for scalar references"

        TypeKind.Interface ->
            case rawTypeRef.name of
                Just interfaceName ->
                    TypeReference (InterfaceRef interfaceName) Nullable

                Nothing ->
                    Debug.crash "Should not get null names for interface references"

        TypeKind.Object ->
            case rawTypeRef.name of
                Just objectName ->
                    TypeReference (ObjectRef objectName) Nullable

                Nothing ->
                    Debug.crash "Should not get null names for object references"

        TypeKind.NonNull ->
            case rawTypeRef.ofType of
                Just (RawTypeRef actualOfType) ->
                    case ( actualOfType.kind, actualOfType.name ) of
                        ( TypeKind.Scalar, scalarName ) ->
                            TypeReference
                                (Scalar (scalarName |> expectString |> Scalar.parse))
                                NonNullable

                        ( TypeKind.Object, objectName ) ->
                            TypeReference (objectName |> expectString |> ObjectRef) NonNullable

                        ( TypeKind.Interface, interfaceName ) ->
                            TypeReference (interfaceName |> expectString |> InterfaceRef) NonNullable

                        ( TypeKind.List, _ ) ->
                            case actualOfType.ofType of
                                Just nestedOfType ->
                                    TypeReference (List (parseRef nestedOfType)) NonNullable

                                Nothing ->
                                    Debug.crash ""

                        ( TypeKind.NonNull, _ ) ->
                            Debug.crash "Can't have nested non-null types"

                        ( TypeKind.Ignore, _ ) ->
                            ignoreRef

                        ( TypeKind.Enum, enumName ) ->
                            TypeReference (enumName |> expectString |> EnumRef) NonNullable

                        ( TypeKind.InputObject, inputObjectName ) ->
                            TypeReference (inputObjectName |> expectString |> InputObjectRef) NonNullable

                        ( TypeKind.Union, _ ) ->
                            TypeReference (actualOfType.name |> expectString |> UnionRef) NonNullable

                Nothing ->
                    ignoreRef

        TypeKind.Ignore ->
            ignoreRef

        TypeKind.Enum ->
            case rawTypeRef.name of
                Just objectName ->
                    TypeReference (EnumRef objectName) Nullable

                Nothing ->
                    Debug.crash "Should not get null names for enum references"

        TypeKind.InputObject ->
            case rawTypeRef.name of
                Just inputObjectName ->
                    TypeReference (InputObjectRef inputObjectName) Nullable

                Nothing ->
                    Debug.crash "Should not get null names for input object references"

        TypeKind.Union ->
            TypeReference (UnionRef (expectString rawTypeRef.name)) Nullable


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

module GraphqElm.Parser.Type exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind)
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

        _ ->
            Decode.fail ("Unknown kind " ++ kind)


scalarDecoder : Decoder TypeDefinition
scalarDecoder =
    Decode.map (\scalarName -> TypeDefinition scalarName ScalarType)
        (Decode.field "name" Decode.string)


objectDecoder : Decoder TypeDefinition
objectDecoder =
    Decode.map2 createObject
        (Decode.field "name" Decode.string)
        (fieldDecoder
            |> Decode.map (\{ name, ofType } -> { name = name, typeRef = parseRef ofType })
            |> Decode.list
            |> Decode.field "fields"
        )


enumDecoder : Decoder TypeDefinition
enumDecoder =
    Decode.map2 createEnum
        (Decode.field "name" Decode.string)
        (Decode.string
            |> Decode.field "name"
            |> Decode.list
            |> Decode.field "enumValues"
        )


createEnum : String -> List String -> TypeDefinition
createEnum enumName enumValues =
    TypeDefinition enumName (EnumType enumValues)


createObject : String -> List Field -> TypeDefinition
createObject objectName fields =
    TypeDefinition objectName (ObjectType fields)


typeRefDecoder : Decoder RawTypeRef
typeRefDecoder =
    Decode.map3 createRawTypeRef
        (Decode.field "name" Decode.string |> Decode.maybe)
        (Decode.field "kind" TypeKind.decoder)
        (Decode.field "ofType"
            (Decode.maybe (Decode.lazy (\_ -> typeRefDecoder)))
        )


fieldDecoder : Decoder RawField
fieldDecoder =
    Decode.map2 RawField
        (Decode.field "name" Decode.string)
        (Decode.field "type" typeRefDecoder)


createRawTypeRef : Maybe String -> TypeKind -> Maybe RawTypeRef -> RawTypeRef
createRawTypeRef stringMaybe typeKind rawTypeRefMaybe =
    RawTypeRef { name = stringMaybe, kind = typeKind, ofType = rawTypeRefMaybe }


type alias Field =
    { name : String
    , typeRef : TypeReference
    }


type TypeDefinition
    = TypeDefinition String DefinableType


type DefinableType
    = ScalarType
    | ObjectType (List Field)
    | EnumType (List String)


type TypeReference
    = TypeReference ReferrableType IsNullable


type ReferrableType
    = Scalar Scalar.Scalar
    | List TypeReference
    | EnumRef String
    | ObjectRef String


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
                        ( TypeKind.Scalar, Just scalarName ) ->
                            TypeReference
                                (Scalar (scalarName |> Scalar.parse))
                                NonNullable

                        ( TypeKind.Object, _ ) ->
                            Debug.crash "TODO a"

                        ( TypeKind.List, _ ) ->
                            case actualOfType.ofType of
                                Just nestedOfType ->
                                    TypeReference (List (parseRef nestedOfType)) NonNullable

                                Nothing ->
                                    Debug.crash ""

                        ( TypeKind.NonNull, _ ) ->
                            Debug.crash "TODO c"

                        ( _, Maybe.Nothing ) ->
                            Debug.crash "TODO d"

                        ( TypeKind.Ignore, Maybe.Just _ ) ->
                            ignoreRef

                        ( TypeKind.Enum, Maybe.Just enumName ) ->
                            TypeReference (EnumRef enumName) NonNullable

                Nothing ->
                    Debug.crash "TODO"

        TypeKind.Ignore ->
            ignoreRef

        TypeKind.Enum ->
            case rawTypeRef.name of
                Just objectName ->
                    TypeReference (EnumRef objectName) Nullable

                Nothing ->
                    Debug.crash "Should not get null names for enum references"


ignoreRef : TypeReference
ignoreRef =
    TypeReference (Scalar (Scalar.Custom { name = "Ignore" })) NonNullable


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
    { name : String, ofType : RawTypeRef }

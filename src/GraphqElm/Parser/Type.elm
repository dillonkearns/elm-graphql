module GraphqElm.Parser.Type exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind)
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder RawTypeDef
decoder =
    Decode.map5 createType
        (Decode.field "name" Decode.string)
        (Decode.field "kind" TypeKind.decoder)
        (Decode.maybe (Decode.field "ofType" typeRefDecoder))
        (Decode.maybe <|
            Decode.field "fields" <|
                Decode.list <|
                    fieldDecoder
        )
        (Decode.string
            |> Decode.field "name"
            |> Decode.list
            |> Decode.maybe
            |> Decode.field "enumValues"
        )


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


parse : RawTypeDef -> TypeDefinition
parse (RawTypeDef rawType) =
    case rawType.kind of
        TypeKind.Scalar ->
            TypeDefinition
                "Date"
                ScalarType

        TypeKind.Object ->
            TypeDefinition
                rawType.name
                (ObjectType
                    (List.map
                        (\{ name, ofType } ->
                            { name = name
                            , typeRef = parseRef ofType
                            }
                        )
                        (rawType.fields |> Maybe.withDefault [])
                    )
                )

        TypeKind.List ->
            Debug.crash "List will not occur at the top-level definitions"

        TypeKind.NonNull ->
            Debug.crash "NonNull will not occur at the top-level definitions"

        TypeKind.Ignore ->
            TypeDefinition
                "Ignore"
                ScalarType

        TypeKind.Enum ->
            -- case rawType.enumValues of
            -- Just enumValues ->
            TypeDefinition
                rawType.name
                (EnumType (rawType.enumValues |> Maybe.withDefault []))



-- Nothing ->
--     Debug.crash ("Expected enum values for top-level enum definition" ++ "\n" ++ toString rawType)


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


createType : String -> TypeKind -> Maybe RawTypeRef -> Maybe (List RawField) -> Maybe (List String) -> RawTypeDef
createType name kind ofType fields enumValues =
    RawTypeDef
        { name = name
        , kind = kind
        , ofType = ofType
        , fields = fields
        , enumValues = enumValues
        }


type IsNullable
    = Nullable
    | NonNullable


type RawTypeRef
    = RawTypeRef
        { name : Maybe String
        , kind : TypeKind
        , ofType : Maybe RawTypeRef
        }


type RawTypeDef
    = RawTypeDef
        { name : String
        , kind : TypeKind
        , ofType : Maybe RawTypeRef
        , fields : Maybe (List RawField)
        , enumValues : Maybe (List String)
        }


type alias RawField =
    { name : String, ofType : RawTypeRef }

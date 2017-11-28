module GraphqElm.Parser.Type exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind)
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder RawTypeDef
decoder =
    Decode.map4 createType
        (Decode.field "name" Decode.string)
        (Decode.field "kind" TypeKind.decoder)
        (Decode.maybe (Decode.field "ofType" typeRefDecoder))
        (Decode.maybe <|
            Decode.field "fields" <|
                Decode.list <|
                    fieldDecoder
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
    = ScalarType String
    | ObjectType (List Field)


type TypeReference
    = TypeReference ReferrableType IsNullable


type ReferrableType
    = Scalar Scalar.Scalar
    | List TypeReference


parse : RawTypeDef -> TypeDefinition
parse (RawTypeDef rawType) =
    case rawType.kind of
        TypeKind.Scalar ->
            TypeDefinition
                "Date"
                (ScalarType "Date")

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
            Debug.crash "TODO"

        TypeKind.NonNull ->
            Debug.crash "TODO"

        TypeKind.Ignore ->
            TypeDefinition
                "Ignore"
                (ScalarType "Ignore")


parseRef : RawTypeRef -> TypeReference
parseRef (RawTypeRef rawTypeRef) =
    case rawTypeRef.kind of
        TypeKind.List ->
            case rawTypeRef.ofType of
                Just nestedOfType ->
                    TypeReference (List (parseRef nestedOfType)) Nullable

                Nothing ->
                    Debug.crash ""

        TypeKind.Scalar ->
            TypeReference
                (Scalar
                    (rawTypeRef.name
                        |> Maybe.withDefault "asdfasdf"
                        |> Scalar.parse
                    )
                )
                Nullable

        TypeKind.Object ->
            TypeReference (Scalar Scalar.Boolean) Nullable

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

                Nothing ->
                    Debug.crash "TODO"

        TypeKind.Ignore ->
            ignoreRef


ignoreRef : TypeReference
ignoreRef =
    TypeReference (Scalar (Scalar.Custom { name = "Ignore" })) NonNullable


createType : String -> TypeKind -> Maybe RawTypeRef -> Maybe (List RawField) -> RawTypeDef
createType name kind ofType fields =
    RawTypeDef
        { name = name
        , kind = kind
        , ofType = ofType
        , fields = fields
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
        }


type alias RawField =
    { name : String, ofType : RawTypeRef }

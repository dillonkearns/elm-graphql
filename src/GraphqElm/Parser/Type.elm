module GraphqElm.Parser.Type exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind)
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder RawType
decoder =
    Decode.map3 createType
        (Decode.field "kind" TypeKind.decoder)
        (Decode.field "name" (Decode.maybe Decode.string))
        (Decode.field "ofType"
            (Decode.maybe (Decode.lazy (\_ -> decoder)))
        )


type Type
    = Scalar IsNullable Scalar
    | List IsNullable Type


parseRaw : RawType -> Type
parseRaw ((RawType { kind, name, ofType }) as rawType) =
    case ( kind, name ) of
        ( TypeKind.Scalar, Just scalarName ) ->
            Scalar Nullable (Scalar.parse scalarName)

        ( compositeNodeType, _ ) ->
            case ofType of
                Just actualOfType ->
                    parseCompositeType compositeNodeType actualOfType

                Nothing ->
                    -- TODO temp to avoid errors
                    Scalar Nullable Scalar.String



-- "Invalid type, no child type to parse for composite parent node "
--     ++ toString compositeNodeType
--     ++ "\n at:\n"
--     ++ toString rawType
--     |> Debug.crash


parseCompositeType : TypeKind -> RawType -> Type
parseCompositeType typeKind (RawType actualOfType) =
    case typeKind of
        TypeKind.List ->
            List Nullable (parseRaw (RawType actualOfType))

        TypeKind.NonNull ->
            case ( actualOfType.kind, actualOfType.name ) of
                ( TypeKind.Scalar, Just scalarName ) ->
                    Scalar NonNullable (Scalar.parse scalarName)

                ( TypeKind.List, Nothing ) ->
                    case actualOfType.ofType of
                        Just nested ->
                            List NonNullable (parseRaw nested)

                        _ ->
                            Debug.crash ("Expected nested ofType to parse, got " ++ toString actualOfType)

                _ ->
                    Debug.crash ("Expected scalar, got " ++ toString actualOfType)

        TypeKind.Scalar ->
            Debug.crash "Not expecting scalar."

        TypeKind.Object ->
            Debug.crash "Unhandled"


createType : TypeKind -> Maybe String -> Maybe RawType -> RawType
createType kind name ofType =
    RawType
        { kind = kind
        , name = name
        , ofType = ofType
        }


type IsNullable
    = Nullable
    | NonNullable


type RawType
    = RawType
        { kind : TypeKind
        , name : Maybe String
        , ofType : Maybe RawType
        }

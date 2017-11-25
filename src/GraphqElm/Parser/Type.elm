module GraphqElm.Parser.Type exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind(..))
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
    = Leaf IsNullable Scalar
    | Composite IsNullable Type


parseRaw : RawType -> Type
parseRaw (RawType { kind, name, ofType }) =
    case ( kind, name ) of
        ( Scalar, Just scalarName ) ->
            Leaf Nullable (Scalar.parse scalarName)

        ( compositeNodeType, _ ) ->
            case ofType of
                Just actualOfType ->
                    parseCompositeType compositeNodeType actualOfType

                Nothing ->
                    "Invalid type, no child type to parse for composite parent node "
                        ++ toString compositeNodeType
                        |> Debug.crash


parseCompositeType : TypeKind -> RawType -> Type
parseCompositeType typeKind (RawType actualOfType) =
    case typeKind of
        List ->
            Composite Nullable (parseRaw (RawType actualOfType))

        NonNull ->
            case ( actualOfType.kind, actualOfType.name ) of
                ( Scalar, Just scalarName ) ->
                    Leaf NonNullable (Scalar.parse scalarName)

                _ ->
                    Debug.crash ("Expected scalar, got " ++ toString actualOfType)

        Scalar ->
            Debug.crash "Not expecting scalar."

        Object ->
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

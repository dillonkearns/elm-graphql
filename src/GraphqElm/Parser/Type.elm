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

        ( NonNull, Nothing ) ->
            case ofType of
                Just (RawType actualOfType) ->
                    case ( actualOfType.kind, actualOfType.name ) of
                        ( Scalar, Just scalarName ) ->
                            Leaf NonNullable (Scalar.parse scalarName)

                        _ ->
                            Debug.crash ("Expected scalar, got " ++ toString actualOfType)

                Nothing ->
                    Debug.crash "Invalid, no type to parse for non-null parent node."

        ( List, Nothing ) ->
            case ofType of
                Nothing ->
                    Debug.crash "Invalid, no type to parse for List parent node."

                Just actualOfType ->
                    Composite Nullable (parseRaw actualOfType)

        _ ->
            Debug.crash "TODO"


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

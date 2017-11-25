module GraphqElm.Parser.Type exposing (..)

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
    = Type IsNullable ScalarPrimitive


parseRaw : RawType -> Type
parseRaw (RawType { kind, name, ofType }) =
    case name of
        Just "String" ->
            Type Nullable String

        Just "Boolean" ->
            Type Nullable Boolean

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


type ScalarPrimitive
    = Boolean
    | ID
    | String
    | Int
    | Float
    | Custom { name : String }

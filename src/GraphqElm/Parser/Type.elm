module GraphqElm.Parser.Type exposing (..)

import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind(..))
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder Type
decoder =
    Decode.map3 createType
        (Decode.field "kind" TypeKind.decoder)
        (Decode.field "name" (Decode.maybe Decode.string))
        (Decode.field "ofType"
            (Decode.maybe (Decode.lazy (\_ -> decoder)))
        )


createType : TypeKind -> Maybe String -> Maybe Type -> Type
createType kind name ofType =
    Type { kind = kind, name = name, ofType = ofType }


type Type
    = Type
        { kind : TypeKind
        , name : Maybe String
        , ofType : Maybe Type
        }

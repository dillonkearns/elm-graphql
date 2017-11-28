module GraphqElm.Parser exposing (Field, decoder, decoderAt3)

import GraphqElm.Parser.Type as Type exposing (TypeDefinition)
import Json.Decode as Decode exposing (Decoder)


type alias Field =
    { name : String, typeOf : Type.TypeDefinition }


decoder : Decoder (List Field)
decoder =
    fieldsDecoder
        |> Decode.index 0
        |> Decode.at [ "data", "__schema", "types" ]


decoderAt3 : Decoder (List Field)
decoderAt3 =
    fieldsDecoder
        |> Decode.index 3
        |> Decode.at [ "data", "__schema", "types" ]


fieldsDecoder : Decoder (List Field)
fieldsDecoder =
    Decode.list
        (Decode.map2 Field
            (Decode.field "name" Decode.string)
            (Decode.field "type"
                (Type.decoder |> Decode.map Type.parseRaw)
            )
        )
        |> Decode.field "fields"

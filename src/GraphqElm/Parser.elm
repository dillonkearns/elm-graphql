module GraphqElm.Parser exposing (Field, decoder)

import GraphqElm.Parser.Type as Type exposing (Type)
import Json.Decode as Decode exposing (Decoder)


type alias Field =
    { name : String, typeOf : Type.Type }


decoder : Decoder (List Field)
decoder =
    Decode.list
        (Decode.map2 Field
            (Decode.field "name" Decode.string)
            (Decode.field "type"
                (Type.decoder |> Decode.map Type.parseRaw)
            )
        )
        |> Decode.field "fields"
        |> Decode.index 0
        |> Decode.at [ "data", "__schema", "types" ]

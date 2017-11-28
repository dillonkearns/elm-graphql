module GraphqElm.Parser exposing (decoderNew)

import GraphqElm.Generator.Group
import GraphqElm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)


decoderNew : Decoder GraphqElm.Generator.Group.Group
decoderNew =
    Type.decoder
        |> Decode.map Type.parse
        |> Decode.list
        |> Decode.at [ "data", "__schema", "types" ]
        |> Decode.map GraphqElm.Generator.Group.gather

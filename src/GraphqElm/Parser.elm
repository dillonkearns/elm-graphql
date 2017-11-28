module GraphqElm.Parser exposing (decoderNew)

import GraphqElm.Generator.Group
import GraphqElm.Parser.TypeNew as TypeNew
import Json.Decode as Decode exposing (Decoder)


decoderNew : Decoder GraphqElm.Generator.Group.Group
decoderNew =
    TypeNew.decoder
        |> Decode.map TypeNew.parse
        |> Decode.list
        |> Decode.at [ "data", "__schema", "types" ]
        |> Decode.map GraphqElm.Generator.Group.gather

module GraphqElm.Parser exposing (decoderNew)

import Dict exposing (Dict)
import GraphqElm.Generator.Group
import GraphqElm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)


decoderNew : Decoder (Dict String String)
decoderNew =
    Type.decoder
        |> Decode.map Type.parse
        |> Decode.list
        |> Decode.at [ "data", "__schema", "types" ]
        |> Decode.map GraphqElm.Generator.Group.generateFiles

module GraphqElm.Parser exposing (decoder)

import Dict exposing (Dict)
import GraphqElm.Generator.Group
import GraphqElm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder (Dict String String)
decoder =
    Type.decoder
        |> Decode.list
        |> Decode.at [ "__schema", "types" ]
        |> Decode.map GraphqElm.Generator.Group.generateFiles

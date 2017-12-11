module Graphqelm.Parser exposing (decoder)

import Dict exposing (Dict)
import Graphqelm.Generator.Group exposing (IntrospectionData)
import Graphqelm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder (Dict String String)
decoder =
    Decode.map3 IntrospectionData
        (Type.decoder
            |> Decode.list
            |> Decode.at [ "__schema", "types" ]
        )
        (Decode.at [ "__schema", "queryType", "name" ] Decode.string)
        (Decode.maybe (Decode.at [ "__schema", "mutationType", "name" ] Decode.string))
        |> Decode.map Graphqelm.Generator.Group.generateFiles

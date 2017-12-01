module GraphqElm.Parser exposing (decoder)

import Dict exposing (Dict)
import GraphqElm.Generator.Group exposing (IntrospectionData)
import GraphqElm.Parser.Type as Type exposing (TypeDefinition)
import Json.Decode as Decode exposing (Decoder)


decoder : Decoder (Dict String String)
decoder =
    Decode.map2 IntrospectionData
        (Type.decoder
            |> Decode.list
            |> Decode.at [ "__schema", "types" ]
        )
        (Decode.at [ "__schema", "queryType", "name" ] Decode.string)
        |> Decode.map GraphqElm.Generator.Group.generateFiles

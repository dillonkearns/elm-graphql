module Graphqelm.Parser exposing (decoder)

import Dict exposing (Dict)
import Graphqelm.Generator.Group exposing (IntrospectionData, sortedIntrospectionData)
import Graphqelm.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)


decoder : List String -> Decoder (Dict String String)
decoder baseModule =
    Decode.map4 sortedIntrospectionData
        (Type.decoder
            |> Decode.list
            |> Decode.at [ "__schema", "types" ]
        )
        (Decode.at [ "__schema", "queryType", "name" ] Decode.string)
        (Decode.maybe (Decode.at [ "__schema", "mutationType", "name" ] Decode.string))
        (Decode.maybe (Decode.at [ "__schema", "subscriptionType", "name" ] Decode.string))
        |> Decode.map (Graphqelm.Generator.Group.generateFiles baseModule)

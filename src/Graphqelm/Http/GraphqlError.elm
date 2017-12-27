module Graphqelm.Http.GraphqlError exposing (GraphqlError, decoder)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)


type alias GraphqlError =
    { message : String
    , locations : Maybe (List Location)
    , details : Dict String Decode.Value
    }


decoder : Decoder (List GraphqlError)
decoder =
    Decode.map3 GraphqlError
        (Decode.field "message" Decode.string)
        (Decode.maybe (Decode.field "locations" (Decode.list locationDecoder)))
        (Decode.dict Decode.value
            |> Decode.map (Dict.remove "message")
            |> Decode.map (Dict.remove "locations")
        )
        |> Decode.list
        |> Decode.field "errors"


type alias Location =
    { line : Int, column : Int }


locationDecoder : Decode.Decoder Location
locationDecoder =
    Decode.map2 Location
        (Decode.field "line" Decode.int)
        (Decode.field "column" Decode.int)

module Graphqelm.Parser.Response exposing (errorDecoder)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)


type alias Error =
    { message : String
    , details : Dict String Decode.Value
    }


errorDecoder : Decoder Error
errorDecoder =
    Decode.succeed
        { message = "You must provide a `first` or `last` value to properly paginate the `releases` connection."
        , details = Dict.empty
        }

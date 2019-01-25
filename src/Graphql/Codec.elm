module Graphql.Codec exposing (Codec)

import Graphql.Internal.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder)


type alias Codec elmValue =
    { encoder : elmValue -> Value
    , decoder : Decoder elmValue
    }

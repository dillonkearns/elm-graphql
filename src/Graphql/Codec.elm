module Graphql.Codec exposing (Codec)

{-| This module is used when you define custom scalars codecs for your schema.
See an example and steps for how to set this up in your codebase here:
<https://github.com/dillonkearns/elm-graphql/blob/master/examples/src/Example07CustomCodecs.elm>

@docs Codec

-}

import Json.Decode
import Json.Encode


{-| A simple definition of a decoder/encoder pair.
-}
type alias Codec elmValue =
    { encoder : elmValue -> Json.Encode.Value
    , decoder : Json.Decode.Decoder elmValue
    }

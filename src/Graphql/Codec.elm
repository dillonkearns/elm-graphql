module Graphql.Codec exposing (Codec)

{-| This module is used when you define custom scalars codecs for your schema.
See an example and steps for how to set this up in your codebase here:
<https://github.com/dillonkearns/elm-graphql/blob/master/examples/src/Example07CustomCodecs.elm>
-}

import Graphql.Internal.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder)


{-| A simple definition of a decoder/encoder pair.
-}
type alias Codec elmValue =
    { encoder : elmValue -> Value
    , decoder : Decoder elmValue
    }

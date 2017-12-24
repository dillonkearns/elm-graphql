module Graphqelm.Document.LowLevel exposing (decoder)

{-| Low level functions to selection up a GraphQL query string or get a decoder.
-}

import Graphqelm.Object exposing (Object(Object))
import Json.Decode as Decode exposing (Decoder)


decoder : Object decodesTo typeLock -> Decoder decodesTo
decoder (Object fields decoder) =
    decoder
        |> Decode.field "data"

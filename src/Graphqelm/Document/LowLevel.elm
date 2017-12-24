module Graphqelm.Document.LowLevel exposing (decoder)

{-| Low level functions to selection up a GraphQL query string or get a decoder.
-}

import Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet))
import Json.Decode as Decode exposing (Decoder)


decoder : SelectionSet decodesTo typeLock -> Decoder decodesTo
decoder (SelectionSet fields decoder) =
    decoder
        |> Decode.field "data"

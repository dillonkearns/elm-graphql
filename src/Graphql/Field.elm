module Graphql.Field exposing (Field(..))

{-|

@docs Field

-}

import Graphql.RawField as Field exposing (RawField)
import Json.Decode as Decode exposing (Decoder)


{-| -}
type Field decodesTo typeLock
    = Field RawField (Decoder decodesTo)

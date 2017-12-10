module Api.Mutation exposing (..)

import Graphqelm.Document exposing (DocumentRoot)
import Graphqelm.Mutation as Mutation
import Json.Decode as Decode exposing (Decoder)


increment : DocumentRoot Int
increment =
    Mutation.fieldDecoder "increment" [] Decode.int

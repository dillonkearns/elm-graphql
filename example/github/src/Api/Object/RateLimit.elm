module Api.Object.RateLimit exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RateLimit
selection constructor =
    Object.object constructor


cost : FieldDecoder Int Api.Object.RateLimit
cost =
    Object.fieldDecoder "cost" [] Decode.int


limit : FieldDecoder Int Api.Object.RateLimit
limit =
    Object.fieldDecoder "limit" [] Decode.int


nodeCount : FieldDecoder Int Api.Object.RateLimit
nodeCount =
    Object.fieldDecoder "nodeCount" [] Decode.int


remaining : FieldDecoder Int Api.Object.RateLimit
remaining =
    Object.fieldDecoder "remaining" [] Decode.int


resetAt : FieldDecoder String Api.Object.RateLimit
resetAt =
    Object.fieldDecoder "resetAt" [] Decode.string

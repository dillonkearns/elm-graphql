module Api.Object.RateLimit exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RateLimit
build constructor =
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

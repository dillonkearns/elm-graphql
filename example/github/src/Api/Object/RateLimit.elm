module Api.Object.RateLimit exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


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

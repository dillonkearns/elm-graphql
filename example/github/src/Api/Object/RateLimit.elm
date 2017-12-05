module Api.Object.RateLimit exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RateLimit
build constructor =
    Object.object constructor


cost : FieldDecoder Int Api.Object.RateLimit
cost =
    Field.fieldDecoder "cost" [] Decode.int


limit : FieldDecoder Int Api.Object.RateLimit
limit =
    Field.fieldDecoder "limit" [] Decode.int


nodeCount : FieldDecoder Int Api.Object.RateLimit
nodeCount =
    Field.fieldDecoder "nodeCount" [] Decode.int


remaining : FieldDecoder Int Api.Object.RateLimit
remaining =
    Field.fieldDecoder "remaining" [] Decode.int


resetAt : FieldDecoder String Api.Object.RateLimit
resetAt =
    Field.fieldDecoder "resetAt" [] Decode.string

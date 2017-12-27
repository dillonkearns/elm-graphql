module Github.Object.RateLimit exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RateLimit
selection constructor =
    Object.object constructor


cost : FieldDecoder Int Github.Object.RateLimit
cost =
    Object.fieldDecoder "cost" [] Decode.int


limit : FieldDecoder Int Github.Object.RateLimit
limit =
    Object.fieldDecoder "limit" [] Decode.int


nodeCount : FieldDecoder Int Github.Object.RateLimit
nodeCount =
    Object.fieldDecoder "nodeCount" [] Decode.int


remaining : FieldDecoder Int Github.Object.RateLimit
remaining =
    Object.fieldDecoder "remaining" [] Decode.int


resetAt : FieldDecoder String Github.Object.RateLimit
resetAt =
    Object.fieldDecoder "resetAt" [] Decode.string

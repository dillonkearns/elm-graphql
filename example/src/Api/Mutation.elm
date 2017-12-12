module Api.Mutation exposing (..)

import Api.Object
import Graphqelm exposing (RootMutation)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Builder.RootObject as RootObject
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)


build : (a -> constructor) -> Object (a -> constructor) RootMutation
build constructor =
    RootObject.object constructor


decrement : FieldDecoder Int RootMutation
decrement =
    RootObject.fieldDecoder "decrement" [] Decode.int


increment : FieldDecoder Int RootMutation
increment =
    RootObject.fieldDecoder "increment" [] Decode.int

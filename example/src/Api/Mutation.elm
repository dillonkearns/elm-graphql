module Api.Mutation exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Document exposing (RootMutation)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.RootObject as RootObject
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) RootMutation
build constructor =
    RootObject.object constructor


decrement : FieldDecoder Int RootMutation
decrement =
    RootObject.fieldDecoder "decrement" [] Decode.int


increment : FieldDecoder Int RootMutation
increment =
    RootObject.fieldDecoder "increment" [] Decode.int

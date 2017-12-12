module Api.Object.Lockable exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Lockable
build constructor =
    Object.object constructor


locked : FieldDecoder Bool Api.Object.Lockable
locked =
    Object.fieldDecoder "locked" [] Decode.bool

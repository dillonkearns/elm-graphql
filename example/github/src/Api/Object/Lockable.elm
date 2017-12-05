module Api.Object.Lockable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Lockable
build constructor =
    Object.object constructor


locked : FieldDecoder Bool Api.Object.Lockable
locked =
    Field.fieldDecoder "locked" [] Decode.bool

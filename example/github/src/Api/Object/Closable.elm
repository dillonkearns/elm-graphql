module Api.Object.Closable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Closable
build constructor =
    Object.object constructor


closed : FieldDecoder String Api.Object.Closable
closed =
    Field.fieldDecoder "closed" [] Decode.string


closedAt : FieldDecoder String Api.Object.Closable
closedAt =
    Field.fieldDecoder "closedAt" [] Decode.string

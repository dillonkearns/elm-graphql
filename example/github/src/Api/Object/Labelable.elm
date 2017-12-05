module Api.Object.Labelable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Labelable
build constructor =
    Object.object constructor


labels : Object labels Api.Object.LabelConnection -> FieldDecoder labels Api.Object.Labelable
labels object =
    Object.single "labels" [] object

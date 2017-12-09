module Api.Object.Updatable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Updatable
build constructor =
    Object.object constructor


viewerCanUpdate : FieldDecoder Bool Api.Object.Updatable
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool

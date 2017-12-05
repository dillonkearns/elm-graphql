module Api.Object.Updatable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Updatable
build constructor =
    Object.object constructor


viewerCanUpdate : FieldDecoder String Api.Object.Updatable
viewerCanUpdate =
    Field.fieldDecoder "viewerCanUpdate" [] Decode.string

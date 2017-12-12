module Api.Object.Updatable exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Updatable
build constructor =
    Object.object constructor


viewerCanUpdate : FieldDecoder Bool Api.Object.Updatable
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool

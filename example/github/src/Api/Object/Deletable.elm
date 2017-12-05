module Api.Object.Deletable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Deletable
build constructor =
    Object.object constructor


viewerCanDelete : FieldDecoder String Api.Object.Deletable
viewerCanDelete =
    Field.fieldDecoder "viewerCanDelete" [] Decode.string

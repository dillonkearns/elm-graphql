module Api.Object.LabelEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LabelEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.LabelEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Label -> FieldDecoder node Api.Object.LabelEdge
node object =
    Object.single "node" [] object

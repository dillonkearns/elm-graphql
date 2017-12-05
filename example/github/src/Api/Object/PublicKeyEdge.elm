module Api.Object.PublicKeyEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PublicKeyEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PublicKeyEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.PublicKey -> FieldDecoder node Api.Object.PublicKeyEdge
node object =
    Object.single "node" [] object

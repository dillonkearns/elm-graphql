module Api.Object.PublicKeyEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PublicKeyEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.PublicKeyEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.PublicKey -> FieldDecoder node Api.Object.PublicKeyEdge
node object =
    Object.single "node" [] object

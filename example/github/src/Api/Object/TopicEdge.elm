module Api.Object.TopicEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TopicEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TopicEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Topic -> FieldDecoder node Api.Object.TopicEdge
node object =
    Object.single "node" [] object

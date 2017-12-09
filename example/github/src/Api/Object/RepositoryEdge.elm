module Api.Object.RepositoryEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.RepositoryEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Repository -> FieldDecoder node Api.Object.RepositoryEdge
node object =
    Object.single "node" [] object

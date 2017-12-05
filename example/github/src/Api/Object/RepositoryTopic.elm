module Api.Object.RepositoryTopic exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryTopic
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.RepositoryTopic
id =
    Field.fieldDecoder "id" [] Decode.string


resourcePath : FieldDecoder String Api.Object.RepositoryTopic
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


topic : Object topic Api.Object.Topic -> FieldDecoder topic Api.Object.RepositoryTopic
topic object =
    Object.single "topic" [] object


url : FieldDecoder String Api.Object.RepositoryTopic
url =
    Field.fieldDecoder "url" [] Decode.string

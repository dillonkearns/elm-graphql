module Api.Object.RepositoryTopic exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryTopic
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.RepositoryTopic
id =
    Object.fieldDecoder "id" [] Decode.string


resourcePath : FieldDecoder String Api.Object.RepositoryTopic
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


topic : Object topic Api.Object.Topic -> FieldDecoder topic Api.Object.RepositoryTopic
topic object =
    Object.single "topic" [] object


url : FieldDecoder String Api.Object.RepositoryTopic
url =
    Object.fieldDecoder "url" [] Decode.string

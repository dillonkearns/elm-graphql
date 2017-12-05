module Api.Object.Topic exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Topic
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Topic
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Topic
name =
    Field.fieldDecoder "name" [] Decode.string


relatedTopics : FieldDecoder (List String) Api.Object.Topic
relatedTopics =
    Field.fieldDecoder "relatedTopics" [] (Decode.string |> Decode.list)

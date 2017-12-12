module Api.Object.Topic exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Topic
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Topic
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Topic
name =
    Object.fieldDecoder "name" [] Decode.string


relatedTopics : FieldDecoder (List String) Api.Object.Topic
relatedTopics =
    Object.fieldDecoder "relatedTopics" [] (Decode.string |> Decode.list)

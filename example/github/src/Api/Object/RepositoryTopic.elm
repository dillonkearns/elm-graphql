module Api.Object.RepositoryTopic exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RepositoryTopic
selection constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.RepositoryTopic
id =
    Object.fieldDecoder "id" [] Decode.string


resourcePath : FieldDecoder String Api.Object.RepositoryTopic
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


topic : SelectionSet topic Api.Object.Topic -> FieldDecoder topic Api.Object.RepositoryTopic
topic object =
    Object.single "topic" [] object


url : FieldDecoder String Api.Object.RepositoryTopic
url =
    Object.fieldDecoder "url" [] Decode.string

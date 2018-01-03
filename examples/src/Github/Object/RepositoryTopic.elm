module Github.Object.RepositoryTopic exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryTopic
selection constructor =
    Object.object constructor


id : FieldDecoder String Github.Object.RepositoryTopic
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The HTTP path for this repository-topic.
-}
resourcePath : FieldDecoder String Github.Object.RepositoryTopic
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The topic.
-}
topic : SelectionSet topic Github.Object.Topic -> FieldDecoder topic Github.Object.RepositoryTopic
topic object =
    Object.selectionFieldDecoder "topic" [] object identity


{-| The HTTP URL for this repository-topic.
-}
url : FieldDecoder String Github.Object.RepositoryTopic
url =
    Object.fieldDecoder "url" [] Decode.string

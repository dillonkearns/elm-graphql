module Github.Object.Reaction exposing (..)

import Github.Enum.ReactionContent
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Reaction
selection constructor =
    Object.object constructor


content : FieldDecoder Github.Enum.ReactionContent.ReactionContent Github.Object.Reaction
content =
    Object.fieldDecoder "content" [] Github.Enum.ReactionContent.decoder


createdAt : FieldDecoder String Github.Object.Reaction
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Github.Object.Reaction
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Github.Object.Reaction
id =
    Object.fieldDecoder "id" [] Decode.string


reactable : SelectionSet reactable Github.Object.Reactable -> FieldDecoder reactable Github.Object.Reaction
reactable object =
    Object.single "reactable" [] object


user : SelectionSet user Github.Object.User -> FieldDecoder user Github.Object.Reaction
user object =
    Object.single "user" [] object

module Github.Object.RemoveReactionPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RemoveReactionPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.RemoveReactionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


reaction : SelectionSet reaction Github.Object.Reaction -> FieldDecoder reaction Github.Object.RemoveReactionPayload
reaction object =
    Object.single "reaction" [] object


subject : SelectionSet subject Github.Object.Reactable -> FieldDecoder subject Github.Object.RemoveReactionPayload
subject object =
    Object.single "subject" [] object

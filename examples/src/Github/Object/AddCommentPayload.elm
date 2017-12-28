module Github.Object.AddCommentPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddCommentPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Github.Object.AddCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


commentEdge : SelectionSet commentEdge Github.Object.IssueCommentEdge -> FieldDecoder commentEdge Github.Object.AddCommentPayload
commentEdge object =
    Object.selectionFieldDecoder "commentEdge" [] object identity


subject : SelectionSet subject Github.Object.Node -> FieldDecoder subject Github.Object.AddCommentPayload
subject object =
    Object.selectionFieldDecoder "subject" [] object identity


timelineEdge : SelectionSet timelineEdge Github.Object.IssueTimelineItemEdge -> FieldDecoder timelineEdge Github.Object.AddCommentPayload
timelineEdge object =
    Object.selectionFieldDecoder "timelineEdge" [] object identity

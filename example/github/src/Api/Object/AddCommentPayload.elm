module Api.Object.AddCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.AddCommentPayload
selection constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


commentEdge : SelectionSet commentEdge Api.Object.IssueCommentEdge -> FieldDecoder commentEdge Api.Object.AddCommentPayload
commentEdge object =
    Object.single "commentEdge" [] object


subject : SelectionSet subject Api.Object.Node -> FieldDecoder subject Api.Object.AddCommentPayload
subject object =
    Object.single "subject" [] object


timelineEdge : SelectionSet timelineEdge Api.Object.IssueTimelineItemEdge -> FieldDecoder timelineEdge Api.Object.AddCommentPayload
timelineEdge object =
    Object.single "timelineEdge" [] object

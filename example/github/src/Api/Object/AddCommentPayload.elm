module Api.Object.AddCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddCommentPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


commentEdge : Object commentEdge Api.Object.IssueCommentEdge -> FieldDecoder commentEdge Api.Object.AddCommentPayload
commentEdge object =
    Object.single "commentEdge" [] object


subject : Object subject Api.Object.Node -> FieldDecoder subject Api.Object.AddCommentPayload
subject object =
    Object.single "subject" [] object


timelineEdge : Object timelineEdge Api.Object.IssueTimelineItemEdge -> FieldDecoder timelineEdge Api.Object.AddCommentPayload
timelineEdge object =
    Object.single "timelineEdge" [] object

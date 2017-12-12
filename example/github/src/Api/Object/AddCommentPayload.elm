module Api.Object.AddCommentPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


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

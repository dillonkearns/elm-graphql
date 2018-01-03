module Github.Object.AddCommentPayload exposing (..)

import Github.Interface
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


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.AddCommentPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The edge from the subject's comment connection.
-}
commentEdge : SelectionSet commentEdge Github.Object.IssueCommentEdge -> FieldDecoder commentEdge Github.Object.AddCommentPayload
commentEdge object =
    Object.selectionFieldDecoder "commentEdge" [] object identity


{-| The subject
-}
subject : SelectionSet subject Github.Interface.Node -> FieldDecoder subject Github.Object.AddCommentPayload
subject object =
    Object.selectionFieldDecoder "subject" [] object identity


{-| The edge from the subject's timeline connection.
-}
timelineEdge : SelectionSet timelineEdge Github.Object.IssueTimelineItemEdge -> FieldDecoder timelineEdge Github.Object.AddCommentPayload
timelineEdge object =
    Object.selectionFieldDecoder "timelineEdge" [] object identity

module Github.Object.AddReactionPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddReactionPayload
selection constructor =
    Object.object constructor


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.AddReactionPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The reaction object.
-}
reaction : SelectionSet reaction Github.Object.Reaction -> FieldDecoder reaction Github.Object.AddReactionPayload
reaction object =
    Object.selectionFieldDecoder "reaction" [] object identity


{-| The reactable subject.
-}
subject : SelectionSet subject Github.Object.Reactable -> FieldDecoder subject Github.Object.AddReactionPayload
subject object =
    Object.selectionFieldDecoder "subject" [] object identity

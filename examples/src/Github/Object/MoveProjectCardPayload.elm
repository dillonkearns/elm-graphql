module Github.Object.MoveProjectCardPayload exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MoveProjectCardPayload
selection constructor =
    Object.object constructor


{-| The new edge of the moved card.
-}
cardEdge : SelectionSet selection Github.Object.ProjectCardEdge -> FieldDecoder selection Github.Object.MoveProjectCardPayload
cardEdge object =
    Object.selectionFieldDecoder "cardEdge" [] object identity


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.MoveProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)

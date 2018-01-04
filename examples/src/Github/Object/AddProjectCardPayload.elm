module Github.Object.AddProjectCardPayload exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddProjectCardPayload
selection constructor =
    Object.object constructor


{-| The edge from the ProjectColumn's card connection.
-}
cardEdge : SelectionSet cardEdge Github.Object.ProjectCardEdge -> FieldDecoder cardEdge Github.Object.AddProjectCardPayload
cardEdge object =
    Object.selectionFieldDecoder "cardEdge" [] object identity


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.AddProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The ProjectColumn
-}
projectColumn : SelectionSet projectColumn Github.Object.Project -> FieldDecoder projectColumn Github.Object.AddProjectCardPayload
projectColumn object =
    Object.selectionFieldDecoder "projectColumn" [] object identity

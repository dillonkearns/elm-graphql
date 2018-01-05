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


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddProjectCardPayload
selection constructor =
    Object.selection constructor


{-| The edge from the ProjectColumn's card connection.
-}
cardEdge : SelectionSet selection Github.Object.ProjectCardEdge -> FieldDecoder selection Github.Object.AddProjectCardPayload
cardEdge object =
    Object.selectionFieldDecoder "cardEdge" [] object identity


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.AddProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| The ProjectColumn
-}
projectColumn : SelectionSet selection Github.Object.Project -> FieldDecoder selection Github.Object.AddProjectCardPayload
projectColumn object =
    Object.selectionFieldDecoder "projectColumn" [] object identity

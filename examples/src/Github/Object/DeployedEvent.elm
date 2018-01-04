module Github.Object.DeployedEvent exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeployedEvent
selection constructor =
    Object.object constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet actor Github.Interface.Actor -> FieldDecoder (Maybe actor) Github.Object.DeployedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.DeployedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.DeployedEvent
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


{-| The deployment associated with the 'deployed' event.
-}
deployment : SelectionSet deployment Github.Object.Deployment -> FieldDecoder deployment Github.Object.DeployedEvent
deployment object =
    Object.selectionFieldDecoder "deployment" [] object identity


id : FieldDecoder String Github.Object.DeployedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


{-| PullRequest referenced by event.
-}
pullRequest : SelectionSet pullRequest Github.Object.PullRequest -> FieldDecoder pullRequest Github.Object.DeployedEvent
pullRequest object =
    Object.selectionFieldDecoder "pullRequest" [] object identity


{-| The ref associated with the 'deployed' event.
-}
ref : SelectionSet ref Github.Object.Ref -> FieldDecoder (Maybe ref) Github.Object.DeployedEvent
ref object =
    Object.selectionFieldDecoder "ref" [] object (identity >> Decode.maybe)

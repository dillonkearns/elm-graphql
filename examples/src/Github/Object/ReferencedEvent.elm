module Github.Object.ReferencedEvent exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReferencedEvent
selection constructor =
    Object.object constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet actor Github.Interface.Actor -> FieldDecoder (Maybe actor) Github.Object.ReferencedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Identifies the commit associated with the 'referenced' event.
-}
commit : SelectionSet commit Github.Object.Commit -> FieldDecoder (Maybe commit) Github.Object.ReferencedEvent
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


{-| Identifies the repository associated with the 'referenced' event.
-}
commitRepository : SelectionSet commitRepository Github.Object.Repository -> FieldDecoder commitRepository Github.Object.ReferencedEvent
commitRepository object =
    Object.selectionFieldDecoder "commitRepository" [] object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.ReferencedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.ReferencedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Reference originated in a different repository.
-}
isCrossReference : FieldDecoder Bool Github.Object.ReferencedEvent
isCrossReference =
    Object.fieldDecoder "isCrossReference" [] Decode.bool


{-| Reference originated in a different repository.
-}
isCrossRepository : FieldDecoder Bool Github.Object.ReferencedEvent
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


{-| Checks if the commit message itself references the subject. Can be false in the case of a commit comment reference.
-}
isDirectReference : FieldDecoder Bool Github.Object.ReferencedEvent
isDirectReference =
    Object.fieldDecoder "isDirectReference" [] Decode.bool


{-| Object referenced by event.
-}
subject : FieldDecoder (Maybe String) Github.Object.ReferencedEvent
subject =
    Object.fieldDecoder "subject" [] (Decode.string |> Decode.maybe)

module Github.Object.RenamedTitleEvent exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RenamedTitleEvent
selection constructor =
    Object.object constructor


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet actor Github.Interface.Actor -> FieldDecoder (Maybe actor) Github.Object.RenamedTitleEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object (identity >> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.RenamedTitleEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Identifies the current title of the issue or pull request.
-}
currentTitle : FieldDecoder String Github.Object.RenamedTitleEvent
currentTitle =
    Object.fieldDecoder "currentTitle" [] Decode.string


id : FieldDecoder String Github.Object.RenamedTitleEvent
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the previous title of the issue or pull request.
-}
previousTitle : FieldDecoder String Github.Object.RenamedTitleEvent
previousTitle =
    Object.fieldDecoder "previousTitle" [] Decode.string


{-| Subject that was renamed.
-}
subject : FieldDecoder (Maybe String) Github.Object.RenamedTitleEvent
subject =
    Object.fieldDecoder "subject" [] (Decode.string |> Decode.maybe)

module Github.Object.Status exposing (..)

import Github.Enum.StatusState
import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Status
selection constructor =
    Object.object constructor


{-| The commit this status is attached to.
-}
commit : SelectionSet commit Github.Object.Commit -> FieldDecoder (Maybe commit) Github.Object.Status
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


{-| Looks up an individual status context by context name.

  - name - The context name.

-}
context : { name : String } -> SelectionSet context Github.Object.StatusContext -> FieldDecoder (Maybe context) Github.Object.Status
context requiredArgs object =
    Object.selectionFieldDecoder "context" [ Argument.required "name" requiredArgs.name Encode.string ] object (identity >> Decode.maybe)


{-| The individual status contexts for this commit.
-}
contexts : SelectionSet contexts Github.Object.StatusContext -> FieldDecoder (List contexts) Github.Object.Status
contexts object =
    Object.selectionFieldDecoder "contexts" [] object (identity >> Decode.list)


id : FieldDecoder String Github.Object.Status
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The combined commit status.
-}
state : FieldDecoder Github.Enum.StatusState.StatusState Github.Object.Status
state =
    Object.fieldDecoder "state" [] Github.Enum.StatusState.decoder

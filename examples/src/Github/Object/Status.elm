module Github.Object.Status exposing (..)

import Github.Enum.StatusState
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


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.Status
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


context : { name : String } -> SelectionSet context Github.Object.StatusContext -> FieldDecoder context Github.Object.Status
context requiredArgs object =
    Object.selectionFieldDecoder "context" [ Argument.string "name" requiredArgs.name ] object identity


contexts : SelectionSet contexts Github.Object.StatusContext -> FieldDecoder (List contexts) Github.Object.Status
contexts object =
    Object.selectionFieldDecoder "contexts" [] object (identity >> Decode.list)


id : FieldDecoder String Github.Object.Status
id =
    Object.fieldDecoder "id" [] Decode.string


state : FieldDecoder Github.Enum.StatusState.StatusState Github.Object.Status
state =
    Object.fieldDecoder "state" [] Github.Enum.StatusState.decoder

module Github.Object.StatusContext exposing (..)

import Github.Enum.StatusState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.StatusContext
selection constructor =
    Object.object constructor


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.StatusContext
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


context : FieldDecoder String Github.Object.StatusContext
context =
    Object.fieldDecoder "context" [] Decode.string


createdAt : FieldDecoder String Github.Object.StatusContext
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.StatusContext
creator object =
    Object.selectionFieldDecoder "creator" [] object identity


description : FieldDecoder String Github.Object.StatusContext
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Github.Object.StatusContext
id =
    Object.fieldDecoder "id" [] Decode.string


state : FieldDecoder Github.Enum.StatusState.StatusState Github.Object.StatusContext
state =
    Object.fieldDecoder "state" [] Github.Enum.StatusState.decoder


targetUrl : FieldDecoder String Github.Object.StatusContext
targetUrl =
    Object.fieldDecoder "targetUrl" [] Decode.string

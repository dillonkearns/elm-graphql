module Github.Object.StatusContext exposing (..)

import Github.Enum.StatusState
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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.StatusContext
selection constructor =
    Object.selection constructor


{-| This commit this status context is attached to.
-}
commit : SelectionSet selection Github.Object.Commit -> FieldDecoder (Maybe selection) Github.Object.StatusContext
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


{-| The name of this status context.
-}
context : FieldDecoder String Github.Object.StatusContext
context =
    Object.fieldDecoder "context" [] Decode.string


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.StatusContext
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| The actor who created this status context.
-}
creator : SelectionSet selection Github.Interface.Actor -> FieldDecoder (Maybe selection) Github.Object.StatusContext
creator object =
    Object.selectionFieldDecoder "creator" [] object (identity >> Decode.maybe)


{-| The description for this status context.
-}
description : FieldDecoder (Maybe String) Github.Object.StatusContext
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.StatusContext
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The state of this status context.
-}
state : FieldDecoder Github.Enum.StatusState.StatusState Github.Object.StatusContext
state =
    Object.fieldDecoder "state" [] Github.Enum.StatusState.decoder


{-| The URL for this status context.
-}
targetUrl : FieldDecoder (Maybe String) Github.Object.StatusContext
targetUrl =
    Object.fieldDecoder "targetUrl" [] (Decode.string |> Decode.maybe)

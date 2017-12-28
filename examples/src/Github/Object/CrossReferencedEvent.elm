module Github.Object.CrossReferencedEvent exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CrossReferencedEvent
selection constructor =
    Object.object constructor


actor : SelectionSet actor Github.Object.Actor -> FieldDecoder actor Github.Object.CrossReferencedEvent
actor object =
    Object.selectionFieldDecoder "actor" [] object identity


createdAt : FieldDecoder String Github.Object.CrossReferencedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.CrossReferencedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Github.Object.CrossReferencedEvent
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


referencedAt : FieldDecoder String Github.Object.CrossReferencedEvent
referencedAt =
    Object.fieldDecoder "referencedAt" [] Decode.string


resourcePath : FieldDecoder String Github.Object.CrossReferencedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


source : FieldDecoder String Github.Object.CrossReferencedEvent
source =
    Object.fieldDecoder "source" [] Decode.string


target : FieldDecoder String Github.Object.CrossReferencedEvent
target =
    Object.fieldDecoder "target" [] Decode.string


url : FieldDecoder String Github.Object.CrossReferencedEvent
url =
    Object.fieldDecoder "url" [] Decode.string


willCloseTarget : FieldDecoder Bool Github.Object.CrossReferencedEvent
willCloseTarget =
    Object.fieldDecoder "willCloseTarget" [] Decode.bool

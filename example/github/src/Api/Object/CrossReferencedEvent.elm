module Api.Object.CrossReferencedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CrossReferencedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.CrossReferencedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.CrossReferencedEvent
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.CrossReferencedEvent
id =
    Field.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Api.Object.CrossReferencedEvent
isCrossRepository =
    Field.fieldDecoder "isCrossRepository" [] Decode.bool


referencedAt : FieldDecoder String Api.Object.CrossReferencedEvent
referencedAt =
    Field.fieldDecoder "referencedAt" [] Decode.string


resourcePath : FieldDecoder String Api.Object.CrossReferencedEvent
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


source : FieldDecoder String Api.Object.CrossReferencedEvent
source =
    Field.fieldDecoder "source" [] Decode.string


target : FieldDecoder String Api.Object.CrossReferencedEvent
target =
    Field.fieldDecoder "target" [] Decode.string


url : FieldDecoder String Api.Object.CrossReferencedEvent
url =
    Field.fieldDecoder "url" [] Decode.string


willCloseTarget : FieldDecoder Bool Api.Object.CrossReferencedEvent
willCloseTarget =
    Field.fieldDecoder "willCloseTarget" [] Decode.bool

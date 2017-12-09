module Api.Object.CrossReferencedEvent exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CrossReferencedEvent
build constructor =
    Object.object constructor


actor : Object actor Api.Object.Actor -> FieldDecoder actor Api.Object.CrossReferencedEvent
actor object =
    Object.single "actor" [] object


createdAt : FieldDecoder String Api.Object.CrossReferencedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Api.Object.CrossReferencedEvent
id =
    Object.fieldDecoder "id" [] Decode.string


isCrossRepository : FieldDecoder Bool Api.Object.CrossReferencedEvent
isCrossRepository =
    Object.fieldDecoder "isCrossRepository" [] Decode.bool


referencedAt : FieldDecoder String Api.Object.CrossReferencedEvent
referencedAt =
    Object.fieldDecoder "referencedAt" [] Decode.string


resourcePath : FieldDecoder String Api.Object.CrossReferencedEvent
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


source : FieldDecoder String Api.Object.CrossReferencedEvent
source =
    Object.fieldDecoder "source" [] Decode.string


target : FieldDecoder String Api.Object.CrossReferencedEvent
target =
    Object.fieldDecoder "target" [] Decode.string


url : FieldDecoder String Api.Object.CrossReferencedEvent
url =
    Object.fieldDecoder "url" [] Decode.string


willCloseTarget : FieldDecoder Bool Api.Object.CrossReferencedEvent
willCloseTarget =
    Object.fieldDecoder "willCloseTarget" [] Decode.bool

module Api.Object.Blob exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Blob
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Blob
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


byteSize : FieldDecoder Int Api.Object.Blob
byteSize =
    Object.fieldDecoder "byteSize" [] Decode.int


commitResourcePath : FieldDecoder String Api.Object.Blob
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Blob
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Api.Object.Blob
id =
    Object.fieldDecoder "id" [] Decode.string


isBinary : FieldDecoder Bool Api.Object.Blob
isBinary =
    Object.fieldDecoder "isBinary" [] Decode.bool


isTruncated : FieldDecoder Bool Api.Object.Blob
isTruncated =
    Object.fieldDecoder "isTruncated" [] Decode.bool


oid : FieldDecoder String Api.Object.Blob
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Blob
repository object =
    Object.single "repository" [] object


text : FieldDecoder String Api.Object.Blob
text =
    Object.fieldDecoder "text" [] Decode.string

module Api.Object.Blob exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Blob
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Blob
abbreviatedOid =
    Field.fieldDecoder "abbreviatedOid" [] Decode.string


byteSize : FieldDecoder String Api.Object.Blob
byteSize =
    Field.fieldDecoder "byteSize" [] Decode.string


commitResourcePath : FieldDecoder String Api.Object.Blob
commitResourcePath =
    Field.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Blob
commitUrl =
    Field.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Api.Object.Blob
id =
    Field.fieldDecoder "id" [] Decode.string


isBinary : FieldDecoder String Api.Object.Blob
isBinary =
    Field.fieldDecoder "isBinary" [] Decode.string


isTruncated : FieldDecoder String Api.Object.Blob
isTruncated =
    Field.fieldDecoder "isTruncated" [] Decode.string


oid : FieldDecoder String Api.Object.Blob
oid =
    Field.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Blob
repository object =
    Object.single "repository" [] object


text : FieldDecoder String Api.Object.Blob
text =
    Field.fieldDecoder "text" [] Decode.string

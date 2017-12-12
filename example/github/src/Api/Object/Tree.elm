module Api.Object.Tree exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Tree
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Tree
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Api.Object.Tree
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Tree
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


entries : Object entries Api.Object.TreeEntry -> FieldDecoder (List entries) Api.Object.Tree
entries object =
    Object.listOf "entries" [] object


id : FieldDecoder String Api.Object.Tree
id =
    Object.fieldDecoder "id" [] Decode.string


oid : FieldDecoder String Api.Object.Tree
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Tree
repository object =
    Object.single "repository" [] object
